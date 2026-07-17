require("__shared/config")
require("__shared/Version")
require("__shared/KitVariables")
local UpdateCheck = require("UpdateCheck")
local StorageManager = require("StorageManager/StorageManager")
local RibbonConfig = require("__shared/Progression/RibbonConfig")
local WeaponCategories = require("__shared/Progression/WeaponCategories")
local currentGameMode = ""


local PROG_CONFIGS = {
    General = require("__shared/Progression/GeneralProgressionConfig"),
    Assault = require("__shared/Progression/AssaultProgressionConfig"),
    Engineer = require("__shared/Progression/EngineerProgressionConfig"),
    Support = require("__shared/Progression/SupportProgressionConfig"),
    Recon = require("__shared/Progression/ReconProgressionConfig"),
    Weapon = require("__shared/Progression/WeaponProgressionConfig"),
    Vehicle = require("__shared/Progression/VehicleProgressionConfig"),
}

local currentRankupPlayers = {}
local storageManager = StorageManager()

local function InitPlayerRoundStats(playerRankObject)
    playerRankObject.roundStats = {
        -- Weapon kills
        AssaultRifle = 0,
        Carbine = 0,
        LMG = 0,
        SniperRifle = 0,
        PDW = 0,
        Shotgun = 0,
        Handgun = 0,
        Melee = 0,
        Stationary = 0,
        Land = 0,
        Transport = 0,
        Air = 0,
        
        -- Game event scoring actions
        revives = 0,
        repairs = 0,
        resupplies = 0,
        heals = 0,
        disables = 0,
        destroys = 0,
        flagDefends = 0,
        flagCaptures = 0,
        mcomDefends = 0,
        mcomDestroys = 0,
        motionSensorAssists = 0,
        suppressionAssists = 0,
        avengerKills = 0,
        saviorKills = 0,
        nemesisKills = 0,
        headshots = 0,
        squadWipes = 0,
        squadSpawns = 0,
        explosives = 0,
        
        -- Combat efficiency
        streak = 0,
        streakBonuses = 0,
        
        earnedRibbons = {}
    }
    for ribbonKey, _ in pairs(RibbonConfig) do
        playerRankObject.roundStats.earnedRibbons[ribbonKey] = 0
    end
end

function addPlayerToRankUpList(player)
    storageManager:fetchPlayerProgress(player, function(playerRankObject)
        if player then -- Just in case player left before callback
            if currentRankupPlayers[tostring(player.guid)] then
                print(player.name .. " IS ALREADY ON THE LIST")
            else
                print("ADDING " .. player.name .. " TO THE RANKUP LIST")
                currentRankupPlayers[tostring(player.guid)] = playerRankObject
            end

            InitPlayerRoundStats(playerRankObject)
            initPlayerLevels(player, playerRankObject)
        end
    end)
end

--- Determines the vehicle category of the killer for vehicle-based ribbon awards.
--- @param inflictor Player The player entity responsible for the kill.
--- @param weapon string The weapon blueprint/asset path.
--- @param isRoadKill boolean Whether the kill was a roadkill.
--- @return string|nil The vehicle category name ("Air", "Transport", "Stationary", "Land") or nil if it was a weapon.
local function GetKillerVehicleCategory(inflictor, weapon, isRoadKill)
    local vehicleName = ""
    if inflictor and inflictor.attachedControllable and inflictor.attachedControllable.data then
        local vehicleEntityData = VehicleEntityData(inflictor.attachedControllable.data)
        vehicleName = vehicleEntityData.controllableType or ""
    end

    if vehicleName == "" and weapon then
        if string.find(weapon, "Vehicles/") then
            vehicleName = weapon
        end
    end

    if vehicleName ~= "" then
        local lowerName = string.lower(vehicleName)
        if (string.find(lowerName, "ah1z") or string.find(lowerName, "mi28") or 
            string.find(lowerName, "z11w") or string.find(lowerName, "ah6") or 
            string.find(lowerName, "su-25") or string.find(lowerName, "su35") or string.find(lowerName, "su-35") or
            string.find(lowerName, "f16") or string.find(lowerName, "f18") or string.find(lowerName, "a10") or 
            string.find(lowerName, "thunderbolt") or string.find(lowerName, "f35")) and 
            not (string.find(lowerName, "venom") or string.find(lowerName, "ka60") or string.find(lowerName, "ka-60") or string.find(lowerName, "kasatka")) then
            return "Air"
        end

        if string.find(lowerName, "venom") or string.find(lowerName, "ka-60") or string.find(lowerName, "ka60") or string.find(lowerName, "kasatka") or
           string.find(lowerName, "growler") or string.find(lowerName, "vodnik") or string.find(lowerName, "hmmwv") or string.find(lowerName, "humvee") or
           string.find(lowerName, "dpv") or string.find(lowerName, "buggy") or string.find(lowerName, "quad") or string.find(lowerName, "rib") or 
           string.find(lowerName, "aav") or string.find(lowerName, "amtrac") or string.find(lowerName, "shuttle") then
            return "Transport"
        end

        if string.find(lowerName, "centurion") or string.find(lowerName, "pantsir") or string.find(lowerName, "kornet") or 
           string.find(lowerName, "tow_station") or string.find(lowerName, "m222") or string.find(lowerName, "cornet") or
           string.find(lowerName, "stationary") or string.find(lowerName, "nsv_hmg") or string.find(lowerName, "m2_hmg") then
            return "Stationary"
        end

        return "Land"
    end

    if weapon then
        local lowerWeap = string.lower(weapon)
        if string.find(lowerWeap, "stationary") or string.find(lowerWeap, "tow") or string.find(lowerWeap, "kornet") or string.find(lowerWeap, "pantsir") or string.find(lowerWeap, "centurion") then
            return "Stationary"
        end
    end

    return nil
end

--- Awards a ribbon to a player, increases their general XP, and sends client events.
--- @param playerRankObject PlayerRank The player rank object containing stats and ribbons.
--- @param ribbonKey string The configuration key of the ribbon to award.
--- @return nil
local function AwardRibbon(playerRankObject, ribbonKey)
    local player = playerRankObject.r_Player
    if not player then return end
    
    local ribbon = RibbonConfig[ribbonKey]
    if not ribbon then return end

    local ribbonFound = false
    for _, r in pairs(playerRankObject.r_RibbonList) do
        if r.ribbonName == ribbonKey then
            r.count = r.count + 1
            ribbonFound = true
            break
        end
    end
    if not ribbonFound then
        table.insert(playerRankObject.r_RibbonList, {
            ['ribbonName'] = ribbonKey,
            ['count'] = 1
        })
    end

    local xpValue = ribbon.xpReward
    if storageManager:isNetStorageAuthed() or not CONFIG.GlobalProgression.enabled then
        xpValue = math.floor(xpValue * CONFIG.General.xpMultiplier)
    end
    
    IncreasePlayerXP(playerRankObject, 'r_PlayerLevel', 'r_PlayerCurrentXP', xpValue, PROG_CONFIGS.General, "General")

    if CONFIG.UnlockNotifications.enabled then
        local message = string.format("★ %s earned %s (+%s XP) ★", player.name, ribbon.prettyName, xpValue)
        ChatManager:SendMessage(message, player)
    end
    
    NetEvents:SendTo('OnRibbonAwarded', player, ribbonKey)
    
    print(string.format("Awarded ribbon %s to player %s", ribbonKey, player.name))
end

--- Evaluates the player's roundStats against the threshold requirements of a specific ribbon.
--- Awards a ribbon if the requirements have been satisfied for the next incremental count.
--- @param playerRankObj PlayerRank The player rank object containing roundStats.
--- @param ribbonKey string The configuration key of the ribbon to check.
--- @return nil
local function CheckRibbonProgress(playerRankObj, ribbonKey)
    local stats = playerRankObj.roundStats
    local ribbon = RibbonConfig[ribbonKey]
    if not stats or not ribbon then return end

    local currentCount = 0
    if ribbonKey == "AssaultRifle" or ribbonKey == "Carbine" or ribbonKey == "LMG" or 
       ribbonKey == "SniperRifle" or ribbonKey == "PDW" or ribbonKey == "Shotgun" or 
       ribbonKey == "Handgun" or ribbonKey == "Melee" or ribbonKey == "Stationary" then
        currentCount = stats[ribbonKey]
    elseif ribbonKey == "AirWarfare" then
        currentCount = stats.Air
    elseif ribbonKey == "ArmoredWarfare" then
        currentCount = stats.Land
    elseif ribbonKey == "TransportWarfare" then
        currentCount = stats.Transport
    elseif ribbonKey == "Medical" then
        currentCount = stats.revives
    elseif ribbonKey == "Resupply" then
        currentCount = stats.resupplies
    elseif ribbonKey == "Maintenance" then
        currentCount = stats.repairs
    elseif ribbonKey == "FlagAttacker" then
        currentCount = stats.flagCaptures
    elseif ribbonKey == "FlagDefender" then
        currentCount = stats.flagDefends
    elseif ribbonKey == "McomAttacker" then
        currentCount = stats.mcomDestroys
    elseif ribbonKey == "McomDefender" then
        currentCount = stats.mcomDefends
    elseif ribbonKey == "Surveillance" then
        currentCount = stats.motionSensorAssists
    elseif ribbonKey == "Suppression" then
        currentCount = stats.suppressionAssists
    elseif ribbonKey == "Avenger" then
        currentCount = stats.avengerKills
    elseif ribbonKey == "Savior" then
        currentCount = stats.saviorKills
    elseif ribbonKey == "Nemesis" then
        currentCount = stats.nemesisKills
    elseif ribbonKey == "SquadWipe" then
        currentCount = stats.squadWipes
    elseif ribbonKey == "SquadSpawn" then
        currentCount = stats.squadSpawns
    elseif ribbonKey == "DisableVehicle" then
        currentCount = stats.disables
    elseif ribbonKey == "AntiVehicle" then
        currentCount = stats.destroys
    elseif ribbonKey == "AntiExplosives" then
        currentCount = stats.explosives or 0
    elseif ribbonKey == "Accuracy" then
        currentCount = stats.headshots
    elseif ribbonKey == "CombatEfficiency" then
        currentCount = stats.streakBonuses
    end

    local alreadyEarned = stats.earnedRibbons[ribbonKey] or 0
    local reqCount = ribbon.reqCount
    if CONFIG.General.debug then
        reqCount = 1
    end
    local nextThreshold = (alreadyEarned + 1) * reqCount
    
    if currentCount >= nextThreshold then
        stats.earnedRibbons[ribbonKey] = alreadyEarned + 1
        AwardRibbon(playerRankObj, ribbonKey)
    end
end

--- Processes incoming player score events (SIDs) and increments round stats for ribbons.
--- @param playerRankObj PlayerRank The player rank object containing stats.
--- @param sid string The VEXT game engine score event identifier.
--- @return nil
local function HandleScoringEventForRibbons(playerRankObj, sid)
    if not playerRankObj or not playerRankObj.roundStats or not sid then return end
    
    local lowerSid = string.lower(sid)
    local roundStats = playerRankObj.roundStats

    if CONFIG.General.debug then
        local pName = playerRankObj.r_Player and playerRankObj.r_Player.name or "Unknown"
        print("[ScoreEvent] player: " .. pName .. ", SID: " .. lowerSid)
    end

    if string.find(lowerSid, "heal") then
        roundStats.heals = roundStats.heals + 1
    elseif string.find(lowerSid, "revive") then
        roundStats.revives = roundStats.revives + 1
        CheckRibbonProgress(playerRankObj, "Medical")
    elseif string.find(lowerSid, "resupply") or string.find(lowerSid, "ammo") then
        roundStats.resupplies = roundStats.resupplies + 1
        CheckRibbonProgress(playerRankObj, "Resupply")
    elseif string.find(lowerSid, "repair") then
        roundStats.repairs = roundStats.repairs + 1
        CheckRibbonProgress(playerRankObj, "Maintenance")
    elseif (string.find(lowerSid, "flag") and string.find(lowerSid, "capture")) or string.find(lowerSid, "secured") then
        roundStats.flagCaptures = roundStats.flagCaptures + 1
        CheckRibbonProgress(playerRankObj, "FlagAttacker")
    elseif (string.find(lowerSid, "flag") or string.find(lowerSid, "conquest") or string.find(lowerSid, "domination")) and string.find(lowerSid, "defend") then
        roundStats.flagDefends = roundStats.flagDefends + 1
        CheckRibbonProgress(playerRankObj, "FlagDefender")
    elseif (string.find(lowerSid, "mcom") or string.find(lowerSid, "crate")) and string.find(lowerSid, "destroy") then
        roundStats.mcomDestroys = roundStats.mcomDestroys + 1
        CheckRibbonProgress(playerRankObj, "McomAttacker")
    elseif (string.find(lowerSid, "mcom") or string.find(lowerSid, "crate")) and string.find(lowerSid, "defend") then
        roundStats.mcomDefends = roundStats.mcomDefends + 1
        CheckRibbonProgress(playerRankObj, "McomDefender")
    elseif string.find(lowerSid, "tugs") or string.find(lowerSid, "motion") or string.find(lowerSid, "sensor") or string.find(lowerSid, "surveillance") then
        roundStats.motionSensorAssists = roundStats.motionSensorAssists + 1
        CheckRibbonProgress(playerRankObj, "Surveillance")
    elseif string.find(lowerSid, "suppression") then
        roundStats.suppressionAssists = roundStats.suppressionAssists + 1
        CheckRibbonProgress(playerRankObj, "Suppression")
    elseif string.find(lowerSid, "avenger") then
        roundStats.avengerKills = roundStats.avengerKills + 1
        CheckRibbonProgress(playerRankObj, "Avenger")
    elseif string.find(lowerSid, "savior") or string.find(lowerSid, "saviour") then
        roundStats.saviorKills = roundStats.saviorKills + 1
        CheckRibbonProgress(playerRankObj, "Savior")
    elseif string.find(lowerSid, "nemesis") then
        roundStats.nemesisKills = roundStats.nemesisKills + 1
        CheckRibbonProgress(playerRankObj, "Nemesis")
    elseif string.find(lowerSid, "squad") and string.find(lowerSid, "wipe") then
        roundStats.squadWipes = roundStats.squadWipes + 1
        CheckRibbonProgress(playerRankObj, "SquadWipe")
    elseif string.find(lowerSid, "spawn") and string.find(lowerSid, "squad") then
        roundStats.squadSpawns = roundStats.squadSpawns + 1
        CheckRibbonProgress(playerRankObj, "SquadSpawn")
    elseif string.find(lowerSid, "disable") then
        roundStats.disables = roundStats.disables + 1
        CheckRibbonProgress(playerRankObj, "DisableVehicle")
    elseif string.find(lowerSid, "vehicle") and (string.find(lowerSid, "destroy") or string.find(lowerSid, "kill")) then
        roundStats.destroys = roundStats.destroys + 1
        CheckRibbonProgress(playerRankObj, "AntiVehicle")
    elseif string.find(lowerSid, "destroy") and string.find(lowerSid, "explosive") then
        roundStats.explosives = roundStats.explosives + 1
        CheckRibbonProgress(playerRankObj, "AntiExplosives")
    end
end

--- Evaluates and awards all end-of-round awards (MVP 1/2/3, Ace Squad, game mode participation and win ribbons).
--- @param winningTeam integer The ID of the team that won the round.
--- @return nil
local function AwardRoundEndRibbons(winningTeam)
    local players = PlayerManager:GetPlayers()
    if #players == 0 then return end

    local sortedPlayers = {}
    for _, p in pairs(players) do
        table.insert(sortedPlayers, p)
    end
    table.sort(sortedPlayers, function(a, b)
        return a.score > b.score
    end)

    if sortedPlayers[1] then
        local pObj = currentRankupPlayers[tostring(sortedPlayers[1].guid)]
        if pObj then AwardRibbon(pObj, "MVP") end
    end
    if sortedPlayers[2] then
        local pObj = currentRankupPlayers[tostring(sortedPlayers[2].guid)]
        if pObj then AwardRibbon(pObj, "MVP2") end
    end
    if sortedPlayers[3] then
        local pObj = currentRankupPlayers[tostring(sortedPlayers[3].guid)]
        if pObj then AwardRibbon(pObj, "MVP3") end
    end

    local squadScores = {}
    for _, p in pairs(players) do
        if p.squadId ~= SquadId.SquadNone then
            local key = p.teamId .. "_" .. p.squadId
            if not squadScores[key] then
                squadScores[key] = {teamId = p.teamId, squadId = p.squadId, score = 0}
            end
            squadScores[key].score = squadScores[key].score + p.score
        end
    end
    local sortedSquads = {}
    for _, sq in pairs(squadScores) do
        table.insert(sortedSquads, sq)
    end
    table.sort(sortedSquads, function(a, b)
        return a.score > b.score
    end)
    if sortedSquads[1] then
        local bestTeam = sortedSquads[1].teamId
        local bestSquad = sortedSquads[1].squadId
        for _, p in pairs(players) do
            if p.teamId == bestTeam and p.squadId == bestSquad then
                local pObj = currentRankupPlayers[tostring(p.guid)]
                if pObj then AwardRibbon(pObj, "AceSquad") end
            end
        end
    end

    local modeKey = nil
    local winnerKey = nil
    
    local lowerMode = string.lower(currentGameMode or "")
    if string.find(lowerMode, "domination") then
        modeKey = "Domination"
        winnerKey = "DominationWinner"
    elseif string.find(lowerMode, "conquest") then
        modeKey = "Conquest"
        winnerKey = "ConquestWinner"
    elseif string.find(lowerMode, "rush") then
        if string.find(lowerMode, "squad") then
            modeKey = "SquadRush"
            winnerKey = "SquadRushWinner"
        else
            modeKey = "Rush"
            winnerKey = "RushWinner"
        end
    elseif string.find(lowerMode, "deathmatch") or string.find(lowerMode, "tdm") then
        if string.find(lowerMode, "squad") then
            modeKey = "SquadDeathmatch"
            winnerKey = "SquadDeathmatchWinner"
        elseif string.find(lowerMode, "cq") or string.find(lowerMode, "close") then
            modeKey = "TDMCQ"
            winnerKey = "TDMCQWinner"
        else
            modeKey = "TeamDeathmatch"
            winnerKey = "TDMWinner"
        end
    elseif string.find(lowerMode, "tank") then
        modeKey = "TankSuperiority"
        winnerKey = "TankSuperiorityWinner"
    elseif string.find(lowerMode, "scavenger") then
        modeKey = "Scavenger"
        winnerKey = "ScavengerWinner"
    elseif string.find(lowerMode, "master") then
        modeKey = "GunMaster"
        winnerKey = "GunMasterWinner"
    elseif string.find(lowerMode, "ctf") or string.find(lowerMode, "capture") then
        modeKey = "CaptureTheFlag"
        winnerKey = "CaptureTheFlagWinner"
    elseif string.find(lowerMode, "air") and string.find(lowerMode, "superiority") then
        modeKey = "AirSuperiority"
        winnerKey = "AirSuperiorityWinner"
    end

    for _, p in pairs(players) do
        local pObj = currentRankupPlayers[tostring(p.guid)]
        if pObj then
            if modeKey then
                AwardRibbon(pObj, modeKey)
            end
            if winnerKey and p.teamId == winningTeam then
                AwardRibbon(pObj, winnerKey)
            end
        end
    end
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
    local xp = score
    if storageManager:isNetStorageAuthed() or not CONFIG.GlobalProgression.enabled then
        xp = math.floor(score * CONFIG.General.xpMultiplier)
    end
    -- Get player's current kit
    -- NOTE: The kit will be nil if they are not spawned in, causing only General XP to be earned
    local kitName = nil
    local selectedKit = player.customization
    if selectedKit ~= nil then
        local veniceSoldierAsset = VeniceSoldierCustomizationAsset(selectedKit)
        kitName = veniceSoldierAsset.labelSid
    end

    -- Check if player is in vehicle
    local vehicleEntityData
    if player.attachedControllable and player.attachedControllable.data then
        kitName = 'Vehicle'
        vehicleEntityData = VehicleEntityData(player.attachedControllable.data)
    end

    local cPlayer = currentRankupPlayers[tostring(player.guid)]
    if cPlayer then
        IncreasePlayerXP(cPlayer, 'r_PlayerLevel', 'r_PlayerCurrentXP', xp, PROG_CONFIGS.General, "General")

        if kitName == 'ID_M_ASSAULT' then
            IncreasePlayerXP(cPlayer, 'r_AssaultLevel', 'r_AssaultCurrentXP', xp, PROG_CONFIGS.Assault, "Assault")
        elseif kitName == 'ID_M_ENGINEER' then
            IncreasePlayerXP(cPlayer, 'r_EngineerLevel', 'r_EngineerCurrentXP', xp, PROG_CONFIGS.Engineer, "Engineer")
        elseif kitName == 'ID_M_SUPPORT' then
            IncreasePlayerXP(cPlayer, 'r_SupportLevel', 'r_SupportCurrentXP', xp, PROG_CONFIGS.Support, "Support")
        elseif kitName == 'ID_M_RECON' then
            IncreasePlayerXP(cPlayer, 'r_ReconLevel', 'r_ReconCurrentXP', xp, PROG_CONFIGS.Recon, "Recon")
        elseif kitName == 'Vehicle' then
            IncreaseVehicleScore(cPlayer, vehicleEntityData.controllableType, xp)
        end
    end
end

function IncreaseWeaponKills(player, weaponName, killAmount)
    local cPlayer = currentRankupPlayers[tostring(player.guid)]
    if not cPlayer then return end

    for _, weapon in pairs(cPlayer['r_WeaponProgressList']) do
        if weapon['weaponName'] == weaponName then
            weapon['kills'] = weapon['kills'] + killAmount
            NetEvents:SendTo('OnKilledPlayer', player, weapon['weaponName'], weapon['kills'])
            WeapAttachUnlockCheck(player, weaponName, weapon['kills'])
            break
        end
    end
end

function WeapAttachUnlockCheck(player, weaponName, weapKills)
    for _, weaponUnlocks in pairs(PROG_CONFIGS.Weapon) do
        if weaponUnlocks.weaponName == weaponName then
            for _, unlock in pairs(weaponUnlocks.unlocks) do
                if CONFIG.UnlockNotifications.enabled == true and weapKills == unlock.killsRequired then
                    print(player.name .. " unlocked " .. unlock.prettyName .. " for " .. weaponUnlocks.prettyName .. " at " .. weapKills .. " kills!")
                    local message = string.format(
                        CONFIG.UnlockNotifications.messages.weapAttachUnlock,
                        weaponUnlocks.prettyName,
                        weapKills,
                        unlock.prettyName
                    )
                    ChatManager:Yell(message, CONFIG.UnlockNotifications.duration, player)
                    NetEvents:SendTo('PlayUnlockSound', player, 'weapAttachUnlock')
                    break -- Unlock found
                end
            end
            break -- Weapon found
        end
    end
end

function IncreasePlayerXP(cPlayer, levelKey, xpKey, xpValue, progressUnlockList, levelType)
    local origScore = cPlayer[xpKey]
    cPlayer[xpKey] = cPlayer[xpKey] + xpValue

    if progressUnlockList then
        local nextLevelIndex = cPlayer[levelKey] + 1

        while nextLevelIndex <= #progressUnlockList do
            local aProgress = progressUnlockList[nextLevelIndex]

            local progressRequired = aProgress.xpRequired

            if progressRequired <= cPlayer[xpKey] then
                cPlayer[levelKey] = nextLevelIndex

                local prettyNames = ""
                for i, unlock in pairs(aProgress.unlocks) do
                    if i == 1 then
                        prettyNames = unlock.prettyName
                    else
                        prettyNames = prettyNames .. ", " .. unlock.prettyName
                    end
                end

                PlayerLevelUp(
                    cPlayer.r_Player,
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
        
        if CONFIG.UnlockNotifications.enabled == true then
            local message = string.format(CONFIG.UnlockNotifications.messages.levelUp, levelType, level, unlockName)
            ChatManager:Yell(message, CONFIG.UnlockNotifications.duration, player)
            NetEvents:SendTo('PlayUnlockSound', player, 'levelUp')
        end
    end
end

function IncreaseVehicleScore(cPlayer, vehicleControllableType, scoreGained)
    -- Find progression config
    local progCfg = nil
    for _, vehicleType in pairs(PROG_CONFIGS.Vehicle) do
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
            print(cPlayer.r_Player.name .. " unlocked " .. unlock.prettyName .. " for " .. progCfg.prettyName .. "!")
            NetEvents:SendTo('OnVehicleCustUnlock', cPlayer.r_Player, progCfg.prettyName, playerVicProg.score)
            if CONFIG.UnlockNotifications.enabled == true then
                local message = string.format(CONFIG.UnlockNotifications.messages.vehicleUnlock, progCfg.prettyName, playerVicProg.score, unlock.prettyName)
                ChatManager:Yell(message, CONFIG.UnlockNotifications.duration, cPlayer.r_Player)
                NetEvents:SendTo('PlayUnlockSound', cPlayer.r_Player, 'vehicleUnlock')
            end
            break
        end
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
            PROG_CONFIGS.General,
            PROG_CONFIGS.Assault,
            PROG_CONFIGS.Engineer,
            PROG_CONFIGS.Support,
            PROG_CONFIGS.Recon
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

    -- !ribbons command
    elseif string.lower(message) == "!ribbons" then
        ChatManager:SendMessage(
            "[= EARNED RIBBONS =]",
            player
        )
        local count = 0
        if cPlayer['r_RibbonList'] then
            for _, ribbon in ipairs(cPlayer['r_RibbonList']) do
                if ribbon.count > 0 then
                    local prettyName = ribbon.ribbonName
                    if RibbonConfig[ribbon.ribbonName] then
                        prettyName = RibbonConfig[ribbon.ribbonName].prettyName
                    end
                    ChatManager:SendMessage(
                        prettyName .. ": " .. ribbon.count,
                        player
                    )
                    count = count + 1
                end
            end
        end
        if count == 0 then
            ChatManager:SendMessage(
                "You haven't earned any ribbons yet. Keep playing!",
                player
            )
        end

    -- !vs <Vehicle Type> command
    elseif string.lower(message):sub(1, 3) == "!vs" then
        local a_typeName = message:sub(5)
        local vicIndex
        for i, vicCfg in ipairs(PROG_CONFIGS.Vehicle) do
            if string.find(string.lower(vicCfg.prettyName), string.lower(a_typeName)) then
                vicIndex = i
                break
            end
        end
        if PROG_CONFIGS.Vehicle[vicIndex] == nil then
            ChatManager:SendMessage(
                'A vehicle type by the name of "' .. a_typeName .. '" could not be found :(', 
                player
            )
            return
        end
        -- Find current vehicle score for type
        local vicScore
        for _, vicType in pairs(cPlayer['r_VehicleProgressList']) do
            if vicType['typeName'] == PROG_CONFIGS.Vehicle[vicIndex].prettyName then
                vicScore = vicType['score']
                break
            end
        end
        if vicScore == nil then
            ChatManager:SendMessage(
                "ERROR: No vehicle score data for " .. PROG_CONFIGS.Vehicle[vicIndex].prettyName, 
                player
            )
            return
        end
        -- Find next unlock
        local nextUnlockScore
        local nextUnlockPrettyName
        for _, unlock in pairs(PROG_CONFIGS.Vehicle[vicIndex].unlocks) do
            if unlock.vicScoreRequired > vicScore and (nextUnlockScore == nil or unlock.vicScoreRequired < nextUnlockScore) then
                nextUnlockScore = unlock.vicScoreRequired
                nextUnlockPrettyName = unlock.prettyName
            end
        end
        ChatManager:SendMessage(
            "Your vehicle score with " .. PROG_CONFIGS.Vehicle[vicIndex].prettyName .. " is " .. vicScore,
            player
        )
        if nextUnlockScore ~= nil then
            nextUnlockScore = nextUnlockScore - vicScore
            ChatManager:SendMessage(
                "You need " .. nextUnlockScore .. " more XP in " .. PROG_CONFIGS.Vehicle[vicIndex].prettyName .. " to unlock " .. nextUnlockPrettyName,
                player
            )
        end

    -- !kills <Weapon Name> command
    elseif string.lower(message):sub(1, 6) == "!kills" then
        -- Find weaponProgressUnlock index
        local a_WeapName = message:sub(8)
        local weapIndex
        for i, weaponCfg in ipairs(PROG_CONFIGS.Weapon) do
            if string.lower(weaponCfg.prettyName) == string.lower(a_WeapName) then
                weapIndex = i
                break
            end
        end
        if PROG_CONFIGS.Weapon[weapIndex] == nil then
            ChatManager:SendMessage(
                'A weapon by the name of "' .. a_WeapName .. '" could not be found :(', 
                player
            )
            return
        end
        -- Find current kills with weapon
        local curWeapKills
        for _, weapon in pairs(cPlayer['r_WeaponProgressList']) do
            if weapon['weaponName'] == PROG_CONFIGS.Weapon[weapIndex].weaponName then
                curWeapKills = weapon['kills']
                break
            end
        end
        if curWeapKills == nil then
            ChatManager:SendMessage(
                "ERROR: No kills data for " .. PROG_CONFIGS.Weapon[weapIndex].prettyName, 
                player
            )
            return
        end
        -- Find next unlock
        local nextUnlockKills
        local nextUnlockPrettyName
        for _, unlock in pairs(PROG_CONFIGS.Weapon[weapIndex].unlocks) do
            if unlock.killsRequired > curWeapKills and (nextUnlockKills == nil or unlock.killsRequired < nextUnlockKills) then
                nextUnlockKills = unlock.killsRequired
                nextUnlockPrettyName = unlock.prettyName
            end
        end
        ChatManager:SendMessage(
            "You have " .. curWeapKills .. " kills with the " .. PROG_CONFIGS.Weapon[weapIndex].prettyName,
            player
        )
        if nextUnlockKills ~= nil then
            nextUnlockKills = nextUnlockKills - curWeapKills
            ChatManager:SendMessage(
                "You need " .. nextUnlockKills .. " more kills to unlock " .. nextUnlockPrettyName,
                player
            )
        end

    -- !awardribbon command (Only in debug mode)
    elseif CONFIG.General.debug and string.lower(message):sub(1, 12) == "!awardribbon" then
        local ribbonKey = message:sub(14)
        if RibbonConfig[ribbonKey] then
            AwardRibbon(cPlayer, ribbonKey)
            ChatManager:SendMessage("Debug: Awarded ribbon " .. ribbonKey .. " to you.", player)
        else
            ChatManager:SendMessage("Error: Ribbon key " .. ribbonKey .. " not found in configuration.", player)
        end

    -- !testribbons command (Only in debug mode to test queue output)
    elseif CONFIG.General.debug and string.lower(message) == "!testribbons" then
        local testKeys = { "MVP", "AceSquad", "AirWarfare", "Melee", "CombatEfficiency" }
        for _, rKey in ipairs(testKeys) do
            if RibbonConfig[rKey] then
                AwardRibbon(cPlayer, rKey)
            end
        end
        ChatManager:SendMessage("Debug: Awarded 5 test ribbons (MVP, AceSquad, AirWarfare, Melee, CombatEfficiency).", player)

    end
end

Events:Subscribe('Player:Score', function(player, scoringTypeData, score)
    local guid = tostring(player.guid)
    
    if guid ~= nil then
        PlayerXPUpdated(player, score)
        
        local cPlayer = currentRankupPlayers[guid]
        if cPlayer and scoringTypeData then
            -- Cast the DataContainer to ScoringTypeData to access the descriptionSid property
            local success, scoringData = pcall(ScoringTypeData, scoringTypeData)
            if success and scoringData then
                if CONFIG.General.debug then
                    local pName = player.name or "Unknown"
                    print("[Player:Score] player: " .. pName .. ", score: " .. tostring(score) .. ", SID: " .. tostring(scoringData.descriptionSid))
                end
                HandleScoringEventForRibbons(cPlayer, scoringData.descriptionSid)
            else
                pcall(function()
                    HandleScoringEventForRibbons(cPlayer, scoringTypeData.descriptionSid)
                end)
            end
        end
    end
    
end)

-- Player killed / death
Events:Subscribe('Player:Killed', function(player, inflictor, position, weapon, isRoadKill, isHeadShot, wasVictimInReviveState, info)
    if player and player.guid then
        local victim = currentRankupPlayers[tostring(player.guid)]
        if victim then
            victim['r_Deaths'] = victim['r_Deaths'] + 1
            if victim.roundStats then
                victim.roundStats.streak = 0
            end
        end
    end
    if inflictor and inflictor.guid and inflictor ~= player then
        local killer = currentRankupPlayers[tostring(inflictor.guid)]
        if killer then
            killer['r_Kills'] = killer['r_Kills'] + 1
            IncreaseWeaponKills(inflictor, weapon, 1)
            
            if killer.roundStats then
                -- Track headshots
                if isHeadShot then
                    killer.roundStats.headshots = killer.roundStats.headshots + 1
                    CheckRibbonProgress(killer, "Accuracy")
                end
                
                -- Check vehicle vs weapon categories
                local vehicleCat = GetKillerVehicleCategory(inflictor, weapon, isRoadKill)
                if vehicleCat then
                    if vehicleCat == "Air" then
                        killer.roundStats.Air = killer.roundStats.Air + 1
                        CheckRibbonProgress(killer, "AirWarfare")
                    elseif vehicleCat == "Land" then
                        killer.roundStats.Land = killer.roundStats.Land + 1
                        CheckRibbonProgress(killer, "ArmoredWarfare")
                    elseif vehicleCat == "Transport" then
                        killer.roundStats.Transport = killer.roundStats.Transport + 1
                        CheckRibbonProgress(killer, "TransportWarfare")
                    elseif vehicleCat == "Stationary" then
                        killer.roundStats.Stationary = killer.roundStats.Stationary + 1
                        CheckRibbonProgress(killer, "Stationary")
                    end
                else
                    -- Regular weapon kill
                    local weaponCat = WeaponCategories.GetCategory(weapon)
                    if weaponCat then
                        killer.roundStats[weaponCat] = killer.roundStats[weaponCat] + 1
                        CheckRibbonProgress(killer, weaponCat)
                    end
                end
                
                -- Track streak / Combat Efficiency
                killer.roundStats.streak = killer.roundStats.streak + 1
                local isStreakBonus = false
                if CONFIG.General.debug then
                    isStreakBonus = true
                else
                    if killer.roundStats.streak >= 8 and (killer.roundStats.streak - 8) % 3 == 0 then
                        isStreakBonus = true
                    end
                end
                if isStreakBonus then
                    killer.roundStats.streakBonuses = killer.roundStats.streakBonuses + 1
                    CheckRibbonProgress(killer, "CombatEfficiency")
                end
            end
        end
    end
end)


Events:Subscribe('Player:Left', function(player)
    local guid = tostring(player.guid)
    local cPlayer = currentRankupPlayers[guid]
    if cPlayer then
        storageManager:storePlayerProgress(cPlayer)
        currentRankupPlayers[guid] = nil
    end
end)

NetEvents:Subscribe('AddNewPlayerForStats', function(player)
    addPlayerToRankUpList(player)
end)

Events:Subscribe('Engine:Init', function()
    if CONFIG.General.updateCheck then
        UpdateCheck()
    end
end)

Events:Subscribe('Extension:Loaded', function()
    print("VU Progression v"..VERSION.Major.."."..VERSION.Minor.."."..VERSION.Patch.." Loaded")

    -- In case of extension reload, we need to check if there are existing players on server
    for _, player in pairs(PlayerManager:GetPlayers()) do
        addPlayerToRankUpList(player)
    end
end)

Events:Subscribe('Level:Loaded', function(levelName, gameMode, round, roundsPerMap)
    currentGameMode = gameMode
    storageManager:newRound(levelName, gameMode)
    
    -- Reset roundStats for all current players
    for _, rankupPlayer in pairs(currentRankupPlayers) do
        InitPlayerRoundStats(rankupPlayer)
    end
end)

Events:Subscribe('Server:RoundOver', function(roundTime, winningTeam)
    print("The round is over. Storing round & player data.")
    
    -- Award round-end ribbons (MVP, Ace Squad, Game Mode completion/win)
    AwardRoundEndRibbons(winningTeam)
    
    local numHumanPlayers = 0
    for guid, rankupPlayer in pairs(currentRankupPlayers) do
        numHumanPlayers = numHumanPlayers + 1
        storageManager:storePlayerProgress(rankupPlayer)
    end
    storageManager:finalizeRound(numHumanPlayers, roundTime, winningTeam)
end)

Events:Subscribe('Player:Chat', ChatCommand)
-- BetterIngameChat compatibility
NetEvents:Subscribe('ClientServer_Chat', function(p_Player, p_Target, p_Message, p_TargetName)
    ChatCommand(p_Player, nil, p_Message)
end)

-- DEBUG
if CONFIG.General.debug then

    NetEvents:Subscribe('AddXP', function(player, xp)
        PlayerXPUpdated(player, xp)
    end)

    NetEvents:Subscribe('AddKillsToWeap', function(player, kills, weapPath)
        IncreaseWeaponKills(player, weapPath, kills)
    end)
    
end
