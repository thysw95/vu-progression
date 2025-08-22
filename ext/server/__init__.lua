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
    local playerRankObject = playerRankClass(player)

    playerRankObject = rankingStorageManager:FetchPlayerProgress(playerRankObject)

    -- print("NEW PLAYER GUID: ")
    -- print(playerRankObject['r_PlayerGuid'])
    -- local playerAdded = false
    
    if #currentRankupPlayers > 0 then
        local foundPlayer = false

        for _, cPlayer in pairs(currentRankupPlayers) do
            if cPlayer['r_PlayerGuid'] == player.guid then
                print(player.name .. ' IS ALREADY ON THE LIST')

                foundPlayer = true
            end
        end

        if foundPlayer == false then
            print("ADDING " .. player.name .. " TO THE RANKUP LIST")

            table.insert(currentRankupPlayers, playerRankObject)

            -- playerAdded = true
        end
    else
        print("ADDING " .. player.name .. " TO THE RANKUP LIST")

        table.insert(currentRankupPlayers, playerRankObject)

        -- playerAdded = true
    end

    -- if playerAdded == true then
    --     initPlayerLevels(player, playerRankObject)
    -- end
    initPlayerLevels(player, playerRankObject)
end

function initPlayerLevels(player, playerRankObject)
    -- Player General Initial Unlock
    NetEvents:SendTo('OnInitialUnlock', player, "General", playerRankObject['r_PlayerCurrentXP'])

    -- Kit Initial Unlocks
    NetEvents:SendTo('OnInitialUnlock', player, "Assault", playerRankObject['r_AssaultCurrentXP'])
    NetEvents:SendTo('OnInitialUnlock', player, "Engineer", playerRankObject['r_EngineerCurrentXP'])
    NetEvents:SendTo('OnInitialUnlock', player, "Support", playerRankObject['r_SupportCurrentXP'])
    NetEvents:SendTo('OnInitialUnlock', player, "Recon", playerRankObject['r_ReconCurrentXP'])

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
    -- player:MakeWritable()
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

    if #currentRankupPlayers > 0 then
        for playerIndex, cPlayer in pairs(currentRankupPlayers) do
            if cPlayer['r_PlayerGuid'] == player.guid then
                -- print(player.name .. " earned " .. score .. " XP on " .. kitName)

                -- IncreaseGeneralPlayerXP(playerIndex, score)
                IncreasePlayerXP(playerIndex, 'r_PlayerLevel', 'r_PlayerCurrentXP', xp, generalProgressionUnlockList, "General")

                if kitName == 'ID_M_ASSAULT' then
                    -- IncreaseAssaultPlayerXP(playerIndex, score)
                    IncreasePlayerXP(playerIndex, 'r_AssaultLevel', 'r_AssaultCurrentXP', xp, assaultProgressionUnlockList, "Assault")
                elseif kitName == 'ID_M_ENGINEER' then
                    IncreasePlayerXP(playerIndex, 'r_EngineerLevel', 'r_EngineerCurrentXP', xp, engineerProgressUnlockList, "Engineer")
                elseif kitName == 'ID_M_SUPPORT' then
                    IncreasePlayerXP(playerIndex, 'r_SupportLevel', 'r_SupportCurrentXP', xp, supportProgressUnlockList, "Support")
                elseif kitName == 'ID_M_RECON' then
                    IncreasePlayerXP(playerIndex, 'r_ReconLevel', 'r_ReconCurrentXP', xp, reconProgressUnlockList, "Recon")
                elseif kitName == 'Vehicle' then
                    IncreaseVehicleScore(player, playerIndex, vehicleEntityData.controllableType, xp)
                end

                break -- Player found in currentRankupPlayers
            end
        end
    end
end

function IncreaseWeaponKills(playerIndex, weaponName) 
    -- if currentRankupPlayers[playerIndex] ~= nil then
        if #currentRankupPlayers[playerIndex]['r_WeaponProgressList'] > 0 then
            for _, weapon in pairs(currentRankupPlayers[playerIndex]['r_WeaponProgressList']) do
                if weapon['weaponName'] == weaponName then
                    weapon['kills'] = weapon['kills'] + 1

                    -- print("THE WEAPON " .. weapon['weaponName'] .. " CURRENT KILLS IS " .. tostring(weapon['kills']))

                    local player = PlayerManager:GetPlayerByGuid(currentRankupPlayers[playerIndex]['r_PlayerGuid'])
                    if player ~= nil then
                        NetEvents:SendTo('OnKilledPlayer', player, weapon['weaponName'], weapon['kills'])
                        WeapAttachUnlockCheck(player, weaponName, weapon['kills'])
                    end
                    break
                end
            end
        end
    -- end
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

-- function IncreaseGeneralPlayerXP(playerIndex, xpValue)
--     currentRankupPlayers[playerIndex]['r_PlayerCurrentXP'] = currentRankupPlayers[playerIndex]['r_PlayerCurrentXP'] + xpValue

--     if #generalProgressionUnlockList > 0 then
--         for _, gProgress in pairs(generalProgressionUnlockList) do
--             if currentRankupPlayers[playerIndex]['r_PlayerLevel'] < gProgress.lvl and currentRankupPlayers[playerIndex]['r_PlayerCurrentXP'] >= gProgress.xpRequired then
--                 currentRankupPlayers[playerIndex]['r_PlayerLevel'] = gProgress.lvl

--                 print("CHANGED GENERAL PROGRESSION TO LEVEL " .. tostring(currentRankupPlayers[playerIndex]['r_PlayerLevel']))

--                 PlayerLevelUp(playerIndex, "General", currentRankupPlayers[playerIndex]['r_PlayerLevel'])
--             end
--         end
--     end
-- end

-- function IncreaseAssaultPlayerXP(playerIndex, xpValue)
--     currentRankupPlayers[playerIndex]['r_AssaultCurrentXP'] = currentRankupPlayers[playerIndex]['r_AssaultCurrentXP'] + xpValue

--     if #assaultProgressionUnlockList > 0 then
--         for _, aProgress in pairs(assaultProgressionUnlockList) do
--             if currentRankupPlayers[playerIndex]['r_AssaultLevel'] < aProgress.lvl and currentRankupPlayers[playerIndex]['r_AssaultCurrentXP'] >= aProgress.xpRequired then
--                 currentRankupPlayers[playerIndex]['r_AssaultLevel'] = aProgress.lvl

--                 print("CHANGED ASSAULT PROGRESSION TO LEVEL " .. tostring(currentRankupPlayers[playerIndex]['r_AssaultLevel']))

--                 PlayerLevelUp(playerIndex, "Assault", currentRankupPlayers[playerIndex]['r_AssaultLevel'])
--             end
--         end
--     end
-- end

function IncreasePlayerXP(playerIndex, levelKey, xpKey, xpValue, progressUnlockList, levelType)
    local origScore = currentRankupPlayers[playerIndex][xpKey]
    currentRankupPlayers[playerIndex][xpKey] = currentRankupPlayers[playerIndex][xpKey] + xpValue

    if #progressUnlockList > 0 then
        -- for _, aProgress in pairs(progressUnlockList) do
        --     if currentRankupPlayers[playerIndex][levelKey] < aProgress.lvl and currentRankupPlayers[playerIndex][xpKey] >= aProgress.xpRequired then
        --         currentRankupPlayers[playerIndex][levelKey] = aProgress.lvl

        --         -- print("CHANGED " .. levelType .. " PROGRESSION TO LEVEL " .. tostring(currentRankupPlayers[playerIndex][levelKey]))

        --         PlayerLevelUp(
        --             PlayerManager:GetPlayerByGuid(currentRankupPlayers[playerIndex]['r_PlayerGuid']), 
        --             levelType, 
        --             currentRankupPlayers[playerIndex][levelKey], 
        --             currentRankupPlayers[playerIndex][xpKey],
        --             aProgress.prettyName
        --         )
        --     end
        -- end

        for index, aProgress in pairs(progressUnlockList) do
            local progressRequired = aProgress.xpRequired

            if progressRequired > origScore and progressRequired <= currentRankupPlayers[playerIndex][xpKey] then
                currentRankupPlayers[playerIndex][levelKey] = index

                local prettyNames = ""
                -- Create a list of pretty unlocks
                if #aProgress.unlocks > 0 then
                    for index, unlock in pairs(aProgress.unlocks) do
                        if index == 1 then
                            prettyNames = unlock.prettyName
                        else
                            prettyNames = prettyNames .. ", " .. unlock.prettyName
                        end
                    end
                end

                PlayerLevelUp(
                    PlayerManager:GetPlayerByGuid(currentRankupPlayers[playerIndex]['r_PlayerGuid']), 
                    levelType, 
                    currentRankupPlayers[playerIndex][levelKey], 
                    currentRankupPlayers[playerIndex][xpKey],
                    prettyNames
                )
            end
        end
    end
end

function PlayerLevelUp(player, levelType, level, currentXp, unlockName)
    if player ~= nil then
        print(player.name .. " leveled up " .. levelType .. " to " .. level .. "!")
        NetEvents:SendTo('OnLevelUp', player, levelType, currentXp)
        
        if enablePlayerUnlockNotifications == true then
            local message = string.format(levelUpNotification, levelType, level, unlockName)
            ChatManager:Yell(message, notificationDurationSec, player)
            NetEvents:SendTo('PlayUnlockSound', player, levelUpSoundPath)
        end
    end
end

function IncreaseVehicleScore(player, playerIndex, vehicleControllableType, scoreGained)
    -- Find progression config for vehicle name
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

    -- Find player vehicle progression for vehicle type name
    local playerVicProg = nil
    for _, vehicleType in pairs(currentRankupPlayers[playerIndex]['r_VehicleProgressList']) do
        if vehicleType.typeName == progCfg.prettyName then
            playerVicProg = vehicleType
            break
        end
    end
    if playerVicProg == nil then return end

    local origScore = playerVicProg.score
    playerVicProg.score = playerVicProg.score + scoreGained
    
    -- Check if vehicle customization unlock occurred
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
    if #currentRankupPlayers > 0 then
        for playerIndex, cPlayer in pairs(currentRankupPlayers) do
            rankingStorageManager:StorePlayerProgress(currentRankupPlayers[playerIndex])
        end
    end
end

function ChatCommand(player, recipientMask, message)
    if player == nil then return end
    -- Get player index from rankup table
    local playerIndex = nil
    for iPlayer, cPlayer in pairs(currentRankupPlayers) do
        if cPlayer['r_PlayerGuid'] == player.guid then
            playerIndex = iPlayer
            break
        end
    end
    if playerIndex == nil then
        print("COULD NOT FIND PLAYER " .. player.name .. " INDEX IN RANKUP PLAYERS TABLE!?")
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
            local classLvl = currentRankupPlayers[playerIndex]['r_' .. className .. 'Level']
            local classXp = currentRankupPlayers[playerIndex]['r_' .. className .. 'CurrentXP']
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
        for _, vicType in pairs(currentRankupPlayers[playerIndex]['r_VehicleProgressList']) do
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
        for _, weapon in pairs(currentRankupPlayers[playerIndex]['r_WeaponProgressList']) do
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
    end
end

Events:Subscribe('Player:Score', function(player, scoringTypeData, score)
    -- local rankPlayer = PlayerManager:GetPlayerByName(playerName)

    -- if rankPlayer.name == player.name then
    --     NetEvents:Broadcast('PlayerScoreEvent', score)
    -- end
    

    -- if player.name == 'MJShepherd' then
    --     print("A SCORING EVENT HAS TRIGGERED FOR: " .. player.name)
    --     print("SCORE AMOUNT: " .. tostring(score))

    --     print('THE CURRENT PLAYER LIST IS: ')
    --     if #currentRankupPlayers > 0 then
    --         for playerIndex, cPlayer in pairs(currentRankupPlayers) do
    --             print(cPlayer['r_PlayerName'])
    --         end
    --     end
    -- end
    
    if player.guid ~= nil then
        PlayerXPUpdated(player, score)
    end
    
end)

-- This event is used by the inflictor
Events:Subscribe('Player:Killed', function(player, inflictor, position, weapon, isRoadKill, isHeadShot, wasVictimInReviveState, info)
    -- if inflictor ~= nil and inflictor.name == 'MJShepherd' then
    --     print(player.name .. " was killed by " .. inflictor.name .. " with a " .. weapon)
    -- end

    -- Player was killed
    if player ~= nil and #currentRankupPlayers > 0 and player.guid ~= nil then
        for playerIndex, cPlayer in pairs(currentRankupPlayers) do
            if currentRankupPlayers[playerIndex]['r_PlayerGuid'] == player.guid then
                currentRankupPlayers[playerIndex]['r_Deaths'] = currentRankupPlayers[playerIndex]['r_Deaths'] + 1
                break -- Player found in currentRankupPlayers
            end
        end
    end
    
    -- Player got a kill
    if inflictor ~= nil and #currentRankupPlayers > 0 and inflictor.guid ~= nil then
        for playerIndex, cPlayer in pairs(currentRankupPlayers) do
            if currentRankupPlayers[playerIndex]['r_PlayerGuid'] == inflictor.guid then
                currentRankupPlayers[playerIndex]['r_Kills'] = currentRankupPlayers[playerIndex]['r_Kills'] + 1
                IncreaseWeaponKills(playerIndex, weapon)
                break -- Inflictor found in currentRankupPlayers
            end
        end
    end
end)

-- Events:Subscribe('Player:Joining', function(name, playerGuid, ipAddress, accountGuid)
--     -- print('PLAYER JOINING OWO!!!!!!!!!')
--     -- print('Player Name:')
--     -- print(name)
--     -- print('Player Guid:')
--     -- print(playerGuid)
--     -- print('Account Guid')
--     -- print(accountGuid)

--     -- local player = PlayerManager:GetPlayersByName(playerGuid)

--     -- -- testSQL()
--     -- if player ~= nil then
--     --     print("New player found!!!! Adding to the stats list now")

--     --     local playerRankObject = playerRankClass(player)

--     --     table.insert(currentRankupPlayers, playerRankObject)
--     -- end

    
-- end)

-- Events:Subscribe('Player:Created', function(player)
--     -- local playerRankObject = playerRankClass(player)

--     -- print("THE RECEIVED PLAYER OBJECT IS: ")
--     -- print(player)

--     -- table.insert(currentRankupPlayers, playerRankObject)

-- end)

NetEvents:Subscribe('AddNewPlayerForStats', function(player, data)
    -- local playerRankObject = playerRankClass(player)
    -- table.insert(currentRankupPlayers, playerRankObject)
    AddPlayerToRankUpList(player)
    
end)

Events:Subscribe('Player:Left', function(player)
    if #currentRankupPlayers > 0 then
        for playerIndex, cPlayer in pairs(currentRankupPlayers) do
            if cPlayer['r_PlayerGuid'] == player.guid then
                -- print("AWWW A PLAYER LEFT")
                -- print("THEY LEFT WITH " .. tostring(currentRankupPlayers[playerIndex]['r_Kills']) .. " KILLS AND WITH " .. tostring(currentRankupPlayers[playerIndex]['r_Deaths']) .. " DEATHS")
                rankingStorageManager:StorePlayerProgress(currentRankupPlayers[playerIndex])

                currentRankupPlayers[playerIndex] = nil
            end
        end
    end
end)

NetEvents:Subscribe('AddXP', function(player, xp)
    PlayerXPUpdated(player, xp)
end)

NetEvents:Subscribe('AddKillsToWeap', function(player, kills, weapPath)
    if player ~= nil and #currentRankupPlayers > 0 and player.guid ~= nil then
        for playerIndex, cPlayer in pairs(currentRankupPlayers) do
            if currentRankupPlayers[playerIndex]['r_PlayerGuid'] == player.guid then
                for i = 1, kills do
                    IncreaseWeaponKills(playerIndex, weapPath)
                end
                break
            end
        end
    end
    
end)

Events:Subscribe('Extension:Loaded', function()
    print('Initializing VU Progression DB')
    CreateProgressionTable()
    PatchProgressionTable()
end)

Events:Subscribe('Server:RoundOver', function(roundTime, winningTeam)
    print("THE ROUND IS OVER!!! TIME TO SAVE THE CONNECTED PLAYERS' STATS!!!!")
    StoreAllPlayerStats()
end)

Events:Subscribe('Player:Chat', ChatCommand)
