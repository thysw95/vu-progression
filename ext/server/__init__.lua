require("__shared/config")
-- require("SQLTest")

playerRankClass = require('__shared/PlayerRank')
currentRankupPlayers = {}

function AddPlayerToRankUpList(player)
    local playerRankObject = playerRankClass(player)

    -- local playerAdded = false
    
    if #currentRankupPlayers > 0 then
        local foundPlayer = false

        for _, cPlayer in pairs(currentRankupPlayers) do
            if cPlayer['r_PlayerName'] == player.name then
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
    -- NetEvents:SendTo('OnInitialAttachmentUnlock', player)
end

function PlayerXPUpdated(player, score)
    -- player:MakeWritable()
    local selectedKit = player.customization
    local kitData = DataContainer(selectedKit)
    local veniceSoldierAsset = VeniceSoldierCustomizationAsset(kitData)
    veniceSoldierAsset:MakeWritable()

    local kitName = veniceSoldierAsset.labelSid

    if #currentRankupPlayers > 0 then
        for playerIndex, cPlayer in pairs(currentRankupPlayers) do
            if cPlayer['r_PlayerName'] == player.name then
                print("Found a player to increase XP!!!!")

                -- IncreaseGeneralPlayerXP(playerIndex, score)
                IncreasePlayerXP(playerIndex, 'r_PlayerLevel', 'r_PlayerCurrentXP', score, generalProgressionUnlockList, "General")

                if kitName == 'ID_M_ASSAULT' then
                    -- IncreaseAssaultPlayerXP(playerIndex, score)
                    IncreasePlayerXP(playerIndex, 'r_AssaultLevel', 'r_AssaultCurrentXP', score, assaultProgressionUnlockList, "Assault")
                end

                if kitName == 'ID_M_ENGINEER' then
                    IncreasePlayerXP(playerIndex, 'r_EngineerLevel', 'r_EngineerCurrentXP', score, engineerProgressUnlockList, "Engineer")
                end

                if kitName == 'ID_M_SUPPORT' then
                    IncreasePlayerXP(playerIndex, 'r_SupportLevel', 'r_SupportCurrentXP', score, supportProgressUnlockList, "Support")
                end

                if kitName == 'ID_M_RECON' then
                    IncreasePlayerXP(playerIndex, 'r_ReconLevel', 'r_ReconCurrentXP', score, reconProgressUnlockList, "Recon")
                end
            end
        end
    end
end

function IncreaseWeaponKills(playerIndex, weaponName) 
    -- if currentRankupPlayers[playerIndex] ~= nil then
        if #currentRankupPlayers[playerIndex]['r_WeaponProgressList'] > 0 then
            for _, weapon in pairs(currentRankupPlayers[playerIndex]['r_WeaponProgressList']) do
                if weapon.weaponName == weaponName then
                    weapon.kills = weapon.kills + 1

                    print("THE WEAPON " .. weapon.weaponName .. " CURRENT KILLS IS " .. tostring(weapon.kills))

                    local player = PlayerManager:GetPlayerByName(currentRankupPlayers[playerIndex]['r_PlayerName'])
                    if player ~= nil then
                        NetEvents:SendTo('OnKilledPlayer', player, weapon.weaponName, weapon.kills)
                    end

                    break
                end
            end
        end
    -- end
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
    currentRankupPlayers[playerIndex][xpKey] = currentRankupPlayers[playerIndex][xpKey] + xpValue

    if #progressUnlockList > 0 then
        for _, aProgress in pairs(progressUnlockList) do
            if currentRankupPlayers[playerIndex][levelKey] < aProgress.lvl and currentRankupPlayers[playerIndex][xpKey] >= aProgress.xpRequired then
                currentRankupPlayers[playerIndex][levelKey] = aProgress.lvl

                print("CHANGED " .. levelType .. " PROGRESSION TO LEVEL " .. tostring(currentRankupPlayers[playerIndex][levelKey]))

                PlayerLevelUp(playerIndex, levelType, currentRankupPlayers[playerIndex][levelKey])
            end
        end
    end
end

function PlayerLevelUp(playerIndex, levelType, level)
    -- print(currentRankupPlayers[playerIndex]['r_PlayerName'] .. " HAS GAINED A LEVEL FOR " .. levelType .. "!!!!")
    -- print("NEW " .. levelType .. " LEVEL IS: ")
    -- print(currentRankupPlayers[playerIndex]['r_PlayerLevel'])

    -- local level = currentRankupPlayers[playerIndex]['r_PlayerLevel']

    local player = PlayerManager:GetPlayerByName(currentRankupPlayers[playerIndex]['r_PlayerName'])

    if player ~= nil then
        NetEvents:SendTo('OnLevelUp', player, levelType, level)
    end
    
end

Events:Subscribe('Player:Score', function(player, scoringTypeData, score)
    -- local rankPlayer = PlayerManager:GetPlayerByName(playerName)

    -- if rankPlayer.name == player.name then
    --     NetEvents:Broadcast('PlayerScoreEvent', score)
    -- end
    

    if player.name == 'MJShepherd' then
        print("A SCORING EVENT HAS TRIGGERED FOR: " .. player.name)
        print("SCORE AMOUNT: " .. tostring(score))

        print('THE CURRENT PLAYER LIST IS: ')
        if #currentRankupPlayers > 0 then
            for playerIndex, cPlayer in pairs(currentRankupPlayers) do
                print(cPlayer['r_PlayerName'])
            end
        end
    end

    PlayerXPUpdated(player, score)
end)

-- This event is used by the inflictor
Events:Subscribe('Player:Killed', function(player, inflictor, position, weapon, isRoadKill, isHeadShot, wasVictimInReviveState, info)
    if inflictor ~= nil and inflictor.name == 'MJShepherd' then
        print(player.name .. " was killed by " .. inflictor.name .. " with a " .. weapon)

        -- local damageGiverInfo = DamageGiverInfo(info)
        -- local soldierWeaponUnlockAsset = SoldierWeaponUnlockAsset(damageGiverInfo.weaponUnlock)
        -- local weaponFiringData = WeaponFiringData(damageGiverInfo.weaponFiring)

        -- print("WEAPON UNLOCK")
        -- print(soldierWeaponUnlockAsset)
        -- print("WEAPON FIRING")
        -- print(weaponFiringData)
        -- print("MOMENT OF TRUTH")
        -- print("WEAPON IDENTIFIER")
        -- print(soldierWeaponUnlockAsset.weaponIdentifier)
    end
    
    if inflictor ~= nil and #currentRankupPlayers > 0 then
        for playerIndex, cPlayer in pairs(currentRankupPlayers) do
            if currentRankupPlayers[playerIndex]['r_PlayerName'] == inflictor.name then
                print("HERE WE FUCKING GOOOOOOOOOOOO")
                IncreaseWeaponKills(playerIndex, weapon)
            end
        end
    end
end)

Events:Subscribe('Player:Joining', function(name, playerGuid, ipAddress, accountGuid)
    -- print('PLAYER JOINING OWO!!!!!!!!!')
    -- print('Player Name:')
    -- print(name)
    -- print('Player Guid:')
    -- print(playerGuid)
    -- print('Account Guid')
    -- print(accountGuid)

    -- local player = PlayerManager:GetPlayersByName(playerGuid)

    -- -- testSQL()
    -- if player ~= nil then
    --     print("New player found!!!! Adding to the stats list now")

    --     local playerRankObject = playerRankClass(player)

    --     table.insert(currentRankupPlayers, playerRankObject)
    -- end

    
end)

Events:Subscribe('Player:Created', function(player)
    -- local playerRankObject = playerRankClass(player)

    -- print("THE RECEIVED PLAYER OBJECT IS: ")
    -- print(player)

    -- table.insert(currentRankupPlayers, playerRankObject)

end)

NetEvents:Subscribe('AddNewPlayerForStats', function(player, data)
    -- local playerRankObject = playerRankClass(player)
    -- table.insert(currentRankupPlayers, playerRankObject)
    AddPlayerToRankUpList(player)

    
end)

Events:Subscribe('Player:Left', function(player)
    if #currentRankupPlayers > 0 then
        for playerIndex, cPlayer in pairs(currentRankupPlayers) do
            if cPlayer['r_PlayerName'] == player.name then
                print("AWWW A PLAYER LEFT QWQ")

                currentRankupPlayers[playerIndex] = nil
            end
        end
    end
end)

NetEvents:Subscribe('AddExperience', function(player, data)
    PlayerXPUpdated(player, data)
end)

NetEvents:Subscribe('AddM16Kill', function(player, data)
    -- PlayerXPUpdated(player, data)
end)

-- AddM16Kill