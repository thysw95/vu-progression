require("__shared/config")
require("__shared/KitVariables")
require("SQL/DBCreation")

local generalProgressionUnlockList = require("__shared/Progression/GeneralProgressionConfig")
local assaultProgressionUnlockList = require("__shared/Progression/AssaultProgressionConfig")
local engineerProgressUnlockList = require("__shared/Progression/EngineerProgressionConfig")
local supportProgressUnlockList = require("__shared/Progression/SupportProgressionConfig")
local reconProgressUnlockList = require("__shared/Progression/ReconProgressionConfig")
local weaponProgressUnlocks = require("__shared/Progression/WeaponProgressionConfig")
require("__shared/Progression/VehicleProgressionConfig")

local rankingStorageManager = require('SQL/RankingStorageManager')
-- require("SQL/SQLTest")

playerRankClass = require('__shared/PlayerRank')
currentRankupPlayers = {}

function AddPlayerToRankUpList(player)
    local guidKey = tostring(player.guid)
    local playerRankObject = playerRankClass(player)

    playerRankObject = rankingStorageManager:FetchPlayerProgress(playerRankObject)

    if currentRankupPlayers[guidKey] then
        print(player.name .. " IS ALREADY ON THE LIST")
    else
        print("ADDING " .. player.name .. " TO THE RANKUP LIST")
        currentRankupPlayers[guidKey] = playerRankObject
    end

    initPlayerLevels(player, playerRankObject)
end

function initPlayerLevels(player, playerRankObject)
    -- Player General Initial Unlock
    NetEvents:SendTo('OnInitialUnlock', player, "General", playerRankObject['r_PlayerLevel'])

    -- Kit Initial Unlocks
    NetEvents:SendTo('OnInitialUnlock', player, "Assault", playerRankObject['r_AssaultLevel'])
    NetEvents:SendTo('OnInitialUnlock', player, "Engineer", playerRankObject['r_EngineerLevel'])
    NetEvents:SendTo('OnInitialUnlock', player, "Support", playerRankObject['r_SupportLevel'])
    NetEvents:SendTo('OnInitialUnlock', player, "Recon", playerRankObject['r_ReconLevel'])

    -- Attachment unlocks
    if #playerRankObject['r_WeaponProgressList'] > 0 then
        NetEvents:SendTo('OnInitialAttachmentUnlock', player, playerRankObject['r_WeaponProgressList'])
    end

    -- Vehicle unlocks
    if #playerRankObject['r_VehicleProgressList'] > 0 then
        NetEvents:SendTo('OnInitialVehicleUnlock', player, playerRankObject['r_VehicleProgressList'])
    end
end

function PlayerXPUpdated(player, score)
    local selectedKit = player.customization
    local kitData = DataContainer(selectedKit)
    local veniceSoldierAsset = VeniceSoldierCustomizationAsset(kitData)
    veniceSoldierAsset:MakeWritable()

    local kitName = veniceSoldierAsset.labelSid
    local xp = score * xpMultiplier

    -- Check if player is in vehicle
    local vehicleEntityData
    if player.attachedControllable and player.attachedControllable.data then
        kitName = 'Vehicle'
        vehicleEntityData = VehicleEntityData(player.attachedControllable.data)
    end

    local guid = tostring(player.guid)

    local cPlayer = currentRankupPlayers[guid]
    if cPlayer then
        IncreasePlayerXP(guid, 'r_PlayerLevel', 'r_PlayerCurrentXP', xp, generalProgressionUnlockList, "General")

        if kitName == 'ID_M_ASSAULT' then
            IncreasePlayerXP(guid, 'r_AssaultLevel', 'r_AssaultCurrentXP', xp, assaultProgressionUnlockList, "Assault")
        elseif kitName == 'ID_M_ENGINEER' then
            IncreasePlayerXP(guid, 'r_EngineerLevel', 'r_EngineerCurrentXP', xp, engineerProgressUnlockList, "Engineer")
        elseif kitName == 'ID_M_SUPPORT' then
            IncreasePlayerXP(guid, 'r_SupportLevel', 'r_SupportCurrentXP', xp, supportProgressUnlockList, "Support")
        elseif kitName == 'ID_M_RECON' then
            IncreasePlayerXP(guid, 'r_ReconLevel', 'r_ReconCurrentXP', xp, reconProgressUnlockList, "Recon")
        elseif kitName == 'Vehicle' then
            IncreaseVehicleScore(player, guid, vehicleEntityData.controllableType, xp)
        end
    end
end

function IncreaseWeaponKills(playerGuid, weaponName, killamount) 
    local guid = tostring(playerGuid)

    local cPlayer = currentRankupPlayers[guid]
    if not cPlayer then return end

    if #cPlayer['r_WeaponProgressList'] > 0 then
        for _, weapon in pairs(cPlayer['r_WeaponProgressList']) do
            if weapon['weaponName'] == weaponName then
                weapon['kills'] = weapon['kills'] + killamount

                local player = PlayerManager:GetPlayerByGuid(playerGuid)
                if player ~= nil then
                    NetEvents:SendTo('OnKilledPlayer', player, weapon['weaponName'], weapon['kills'])
                    WeapAttachUnlockCheck(player, weaponName, weapon['kills'])
                end
                break
            end
        end
    end
end
function WeapAttachUnlockCheck(player, weaponName, weapKills)
    if #weaponProgressUnlocks > 0 then
        for _, weaponUnlocks in pairs(weaponProgressUnlocks) do

            if weaponUnlocks.weaponName == weaponName then
                if #weaponUnlocks.unlocks > 0 then
                    for _, unlock in pairs(weaponUnlocks.unlocks) do
                        if enablePlayerUnlockNotifications == true and weapKills == unlock.killsRequired then
                            print(player.name .. " unlocked " .. unlock.prettyName .. " for " .. weaponUnlocks.prettyName .. " at " .. weapKills .. " kills!")
                            local message = string.format(weapAttachUnlockNotification, weaponUnlocks.prettyName, weapKills, unlock.prettyName)
                            ChatManager:Yell(message, notificationDurationSec, player)
                            NetEvents:SendTo('PlayUnlockSound', player, weapAttachUnlockSoundPath)
                            break
                        end

                    end
                end
                break
            end

        end
    end
end

function IncreasePlayerXP(playerGuid, levelKey, xpKey, xpValue, progressUnlockList, levelType)
    local cPlayer = currentRankupPlayers[playerGuid]
    if not cPlayer then return end

    local origScore = cPlayer[xpKey]
    cPlayer[xpKey] = cPlayer[xpKey] + xpValue

    -- if #progressUnlockList > 0 then
    --     for index, aProgress in pairs(progressUnlockList) do
    --         local progressRequired = aProgress.xpRequired

    --         if progressRequired > origScore and progressRequired <= cPlayer[xpKey] then
    --             cPlayer[levelKey] = index

    --             local prettyNames = ""
    --             if #aProgress.unlocks > 0 then
    --                 for i, unlock in pairs(aProgress.unlocks) do
    --                     if i == 1 then
    --                         prettyNames = unlock.prettyName
    --                     else
    --                         prettyNames = prettyNames .. ", " .. unlock.prettyName
    --                     end
    --                 end
    --             end

    --             PlayerLevelUp(
    --                 PlayerManager:GetPlayerByGuid(cPlayer.r_PlayerGuid), 
    --                 levelType, 
    --                 cPlayer[levelKey],
    --                 prettyNames
    --             )
    --         end
    --     end
    -- end

    if progressUnlockList then
        local nextLevelIndex = cPlayer[levelKey] + 1

        while nextLevelIndex <= #progressUnlockList do
            local aProgress = progressUnlockList[nextLevelIndex]

            local progressRequired = aProgress.xpRequired

            if progressRequired <= cPlayer[xpKey] then
                cPlayer[levelKey] = nextLevelIndex

                local prettyNames = ""
                if #aProgress.unlocks > 0 then
                    for i, unlock in pairs(aProgress.unlocks) do
                        if i == 1 then
                            prettyNames = unlock.prettyName
                        else
                            prettyNames = prettyNames .. ", " .. unlock.prettyName
                        end
                    end
                end

                PlayerLevelUp(
                    PlayerManager:GetPlayerByGuid(cPlayer.r_PlayerGuid), 
                    levelType, 
                    cPlayer[levelKey],
                    prettyNames
                )
            else
                break
            end

            nextLevelIndex = nextLevelIndex + 1
        end
    end
end

function PlayerLevelUp(player, levelType, level, unlockName)
    if player ~= nil then
        print(player.name .. " leveled up " .. levelType .. " to " .. level .. "!")
        NetEvents:SendTo('OnLevelUp', player, levelType, level)
        
        if enablePlayerUnlockNotifications == true then
            local message = string.format(levelUpNotification, levelType, level, unlockName)
            ChatManager:Yell(message, notificationDurationSec, player)
            NetEvents:SendTo('PlayUnlockSound', player, levelUpSoundPath)
        end
    end
end

function IncreaseVehicleScore(player, playerGuid, vehicleControllableType, scoreGained)
    local guid = tostring(playerGuid)

    local cPlayer = currentRankupPlayers[guid]
    if not cPlayer then return end

    -- Find progression config
    local progCfg = nil
    for _, vehicleType in pairs(VIC_PROG_CONFIG) do
        for _, vehicleName in pairs(vehicleType.vehicleNames) do
            if vehicleName == vehicleControllableType then
                progCfg = vehicleType
                break
            end
        end
        if progCfg ~= nil then break end
    end
    if progCfg == nil then return end

    -- Find player vehicle progression
    local playerVicProg = nil
    for _, vehicleType in pairs(cPlayer['r_VehicleProgressList']) do
        if vehicleType.typeName == progCfg.prettyName then
            playerVicProg = vehicleType
            break
        end
    end
    if playerVicProg == nil then return end

    local origScore = playerVicProg.score
    playerVicProg.score = playerVicProg.score + scoreGained

    for _, unlock in pairs(progCfg.unlocks) do
        if unlock.vicScoreRequired > origScore and unlock.vicScoreRequired <= playerVicProg.score then
            print(player.name .. " unlocked " .. unlock.prettyName .. " for " .. progCfg.prettyName .. "!")
            NetEvents:SendTo('OnVehicleCustUnlock', player, progCfg.prettyName, playerVicProg.score)
            if enablePlayerUnlockNotifications == true then
                local message = string.format(vehicleUnlockNotification, progCfg.prettyName, playerVicProg.score, unlock.prettyName)
                ChatManager:Yell(message, notificationDurationSec, player)
                NetEvents:SendTo('PlayUnlockSound', player, vehicleUnlockSoundPath)
            end
            break
        end
    end
end


function StoreAllPlayerStats()
    for guid, cPlayer in pairs(currentRankupPlayers) do
        rankingStorageManager:StorePlayerProgress(cPlayer)
    end
end

function ChatCommand(player, recipientMask, message)
    if player == nil then return end

    local guid = tostring(player.guid)

    local cPlayer = currentRankupPlayers[guid]

    if not cPlayer then
        print("COULD NOT FIND PLAYER " .. player.name .. " IN RANKUP PLAYERS TABLE!?")
        return
    end

    -- !level/!score command
    if string.lower(message) == "!level" or string.lower(message) == "!score" then
        local classNames = {"Player", "Assault", "Engineer", "Support", "Recon"}
        local unlockLists = {
            generalProgressionUnlockList,
            assaultProgressionUnlockList,
            engineerProgressUnlockList,
            supportProgressUnlockList,
            reconProgressUnlockList
        }
        ChatManager:SendMessage(
            "[= CLASS LEVELS =]",
            player
        )
        for i, className in pairs(classNames) do
            local classLvl = cPlayer['r_' .. className .. 'Level']
            local classXp = cPlayer['r_' .. className .. 'CurrentXP']
            local classNextLvlXp
            for _, unlock in pairs(unlockLists[i]) do
                if classXp < unlock.xpRequired then
                    classNextLvlXp = unlock.xpRequired
                    break
                end
            end
            local msg = string.upper(className) .. " Lvl " .. classLvl .. " | " .. classXp .. " XP"
            if classNextLvlXp ~= nil then
                classNextLvlXp = classNextLvlXp - classXp
                msg = msg .. " | Need " .. classNextLvlXp .. " XP to level"
            end
            ChatManager:SendMessage(msg, player)
        end

    -- !vs <Vehicle Type> command
    elseif string.lower(message):sub(1, 3) == "!vs" then
        local a_typeName = message:sub(5)
        local vicIndex
        for i, vicCfg in ipairs(VIC_PROG_CONFIG) do
            if string.find(string.lower(vicCfg.prettyName), string.lower(a_typeName)) then
                vicIndex = i
                break
            end
        end
        if VIC_PROG_CONFIG[vicIndex] == nil then
            ChatManager:SendMessage(
                'A vehicle type by the name of "' .. a_typeName .. '" could not be found :(', 
                player
            )
            return
        end
        -- Find current vehicle score for type
        local vicScore
        for _, vicType in pairs(cPlayer['r_VehicleProgressList']) do
            if vicType['typeName'] == VIC_PROG_CONFIG[vicIndex].prettyName then
                vicScore = vicType['score']
                break
            end
        end
        if vicScore == nil then
            ChatManager:SendMessage(
                "ERROR: No vehicle score data for " .. VIC_PROG_CONFIG[vicIndex].prettyName, 
                player
            )
            return
        end
        -- Find next unlock
        local nextUnlockScore
        local nextUnlockPrettyName
        for _, unlock in pairs(VIC_PROG_CONFIG[vicIndex].unlocks) do
            if unlock.vicScoreRequired > vicScore and (nextUnlockScore == nil or unlock.vicScoreRequired < nextUnlockScore) then
                nextUnlockScore = unlock.vicScoreRequired
                nextUnlockPrettyName = unlock.prettyName
            end
        end
        ChatManager:SendMessage(
            "Your vehicle score with " .. VIC_PROG_CONFIG[vicIndex].prettyName .. " is " .. vicScore,
            player
        )
        if nextUnlockScore ~= nil then
            nextUnlockScore = nextUnlockScore - vicScore
            ChatManager:SendMessage(
                "You need " .. nextUnlockScore .. " more XP in " .. VIC_PROG_CONFIG[vicIndex].prettyName .. " to unlock " .. nextUnlockPrettyName,
                player
            )
        end

    -- !kills <Weapon Name> command
    elseif string.lower(message):sub(1, 6) == "!kills" then
        -- Find weaponProgressUnlock index
        local a_WeapName = message:sub(8)
        local weapIndex
        for i, weaponCfg in ipairs(weaponProgressUnlocks) do
            if string.lower(weaponCfg.prettyName) == string.lower(a_WeapName) then
                weapIndex = i
                break
            end
        end
        if weaponProgressUnlocks[weapIndex] == nil then
            ChatManager:SendMessage(
                'A weapon by the name of "' .. a_WeapName .. '" could not be found :(', 
                player
            )
            return
        end
        -- Find current kills with weapon
        local curWeapKills
        for _, weapon in pairs(cPlayer['r_WeaponProgressList']) do
            if weapon['weaponName'] == weaponProgressUnlocks[weapIndex].weaponName then
                curWeapKills = weapon['kills']
                break
            end
        end
        if curWeapKills == nil then
            ChatManager:SendMessage(
                "ERROR: No kills data for " .. weaponProgressUnlocks[weapIndex].prettyName, 
                player
            )
            return
        end
        -- Find next unlock
        local nextUnlockKills
        local nextUnlockPrettyName
        for _, unlock in pairs(weaponProgressUnlocks[weapIndex].unlocks) do
            if unlock.killsRequired > curWeapKills and (nextUnlockKills == nil or unlock.killsRequired < nextUnlockKills) then
                nextUnlockKills = unlock.killsRequired
                nextUnlockPrettyName = unlock.prettyName
            end
        end
        ChatManager:SendMessage(
            "You have " .. curWeapKills .. " kills with the " .. weaponProgressUnlocks[weapIndex].prettyName,
            player
        )
        if nextUnlockKills ~= nil then
            nextUnlockKills = nextUnlockKills - curWeapKills
            ChatManager:SendMessage(
                "You need " .. nextUnlockKills .. " more kills to unlock " .. nextUnlockPrettyName,
                player
            )
        end

    elseif string.lower(message):sub(1, 3) == "!xp" then
        local xpAmount = message:sub(5)
        PlayerXPUpdated(player, xpAmount)
    -- elseif string.lower(message):sub(1, 3) == "!wp" then
    --     local killAmount = message:sub(5)
    --     ChatManager:SendMessage(
    --         "Added " .. killAmount .. " to the M16A4",
    --         player
    --     )
    --     IncreaseWeaponKills(player.guid, "M16A4", killAmount)
    end
end

Events:Subscribe('Player:Score', function(player, scoringTypeData, score)
    local guid = tostring(player.guid)
    
    if guid ~= nil then
        PlayerXPUpdated(player, score)
    end
    
end)

-- Player killed / death
Events:Subscribe('Player:Killed', function(player, inflictor, position, weapon, isRoadKill, isHeadShot, wasVictimInReviveState, info)
    local guid = tostring(player.guid)
    
    if player and guid then
        local victim = currentRankupPlayers[guid]
        if victim then
            victim['r_Deaths'] = victim['r_Deaths'] + 1
        end
    end
    if inflictor and inflictor.guid then
        local inflictorGuid = tostring(inflictor.guid)
        local killer = currentRankupPlayers[inflictorGuid]
        if killer then
            killer['r_Kills'] = killer['r_Kills'] + 1
            IncreaseWeaponKills(inflictor.guid, weapon, 1)
        end
    end
end)


Events:Subscribe('Player:Left', function(player)
    local guid = tostring(player.guid)
    local cPlayer = currentRankupPlayers[guid]
    if cPlayer then
        rankingStorageManager:StorePlayerProgress(cPlayer)
        currentRankupPlayers[guid] = nil
    end
end)

NetEvents:Subscribe('AddNewPlayerForStats', function(player, data)
    AddPlayerToRankUpList(player)
end)

NetEvents:Subscribe('AddXP', function(player, xp)
    PlayerXPUpdated(player, xp)
end)

Events:Subscribe('Extension:Loaded', function()
    print('Initializing VU Progression DB')
    CreateProgressionTable()
    PatchProgressionTable()
end)

Events:Subscribe('Server:RoundOver', function(roundTime, winningTeam)
    print("The round is over. Storing player data.")
    StoreAllPlayerStats()
end)

Events:Subscribe('Player:Chat', ChatCommand)
