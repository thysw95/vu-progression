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
    NetEvents:SendTo('OnInitialUnlock', player, "General", playerRankObject['r_PlayerLevel'])
    NetEvents:SendTo('OnInitialUnlock', player, "Assault", playerRankObject['r_AssaultLevel'])
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

                IncreaseGeneralPlayerXP(playerIndex, score)

                if kitName == 'ID_M_ASSAULT' then
                    IncreaseAssaultPlayerXP(playerIndex, score)
                end
            end
        end
    end
end

function IncreaseGeneralPlayerXP(playerIndex, xpValue)
    currentRankupPlayers[playerIndex]['r_PlayerCurrentXP'] = currentRankupPlayers[playerIndex]['r_PlayerCurrentXP'] + xpValue

    if #generalProgressionUnlockList > 0 then
        for _, gProgress in pairs(generalProgressionUnlockList) do
            if currentRankupPlayers[playerIndex]['r_PlayerLevel'] < gProgress.lvl and currentRankupPlayers[playerIndex]['r_PlayerCurrentXP'] >= gProgress.xpRequired then
                currentRankupPlayers[playerIndex]['r_PlayerLevel'] = gProgress.lvl

                print("CHANGED GENERAL PROGRESSION TO LEVEL " .. tostring(currentRankupPlayers[playerIndex]['r_PlayerLevel']))

                PlayerLevelUp(playerIndex, "General", currentRankupPlayers[playerIndex]['r_PlayerLevel'])
            end
        end
    end
end

function IncreaseAssaultPlayerXP(playerIndex, xpValue)
    currentRankupPlayers[playerIndex]['r_AssaultCurrentXP'] = currentRankupPlayers[playerIndex]['r_AssaultCurrentXP'] + xpValue

    if #assaultProgressionUnlockList > 0 then
        for _, aProgress in pairs(assaultProgressionUnlockList) do
            if currentRankupPlayers[playerIndex]['r_AssaultLevel'] < aProgress.lvl and currentRankupPlayers[playerIndex]['r_AssaultCurrentXP'] >= aProgress.xpRequired then
                currentRankupPlayers[playerIndex]['r_AssaultLevel'] = aProgress.lvl

                print("CHANGED ASSAULT PROGRESSION TO LEVEL " .. tostring(currentRankupPlayers[playerIndex]['r_AssaultLevel']))

                PlayerLevelUp(playerIndex, "Assault", currentRankupPlayers[playerIndex]['r_AssaultLevel'])
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
        NetEvents:SendTo('OnGeneralLevelUp', player, levelType, level)
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