require("__shared/config")
-- require("SQLTest")

playerRankClass = require('__shared/PlayerRank')
currentPlayers = {}

function PlayerXPUpdated(player, score)
    if #currentPlayers > 0 then
        for playerIndex, cPlayer in pairs(currentPlayers) do
            if cPlayer['r_PlayerName'] == player.name then
                -- self.r_PlayerCurrentXP = self.r_PlayerCurrentXP + xpValue
                -- currentPlayers[i]['r_PlayerCurrentXP'] = currentPlayers[i]['r_PlayerCurrentXP']
                print("Found a player to increase XP!!!!")

                IncreaseGeneralPlayerXP(playerIndex, score)
            end
        end
    end
end

function IncreaseGeneralPlayerXP(playerIndex, xpValue)
    currentPlayers[playerIndex]['r_PlayerCurrentXP'] = currentPlayers[playerIndex]['r_PlayerCurrentXP'] + xpValue

    -- print("GAINED EXPERIENCE!!!!!")
    -- print("CURRENT EXPERIENCE:")
    -- print(currentPlayers[playerIndex]['r_PlayerCurrentXP'])

    if currentPlayers[playerIndex]['r_PlayerCurrentXP'] >= currentPlayers[playerIndex]['r_PlayerRequiredXP'] then
        GeneralLevelUp(playerIndex)
    end
end

function GeneralLevelUp(playerIndex)
    currentPlayers[playerIndex]['r_PlayerRequiredXP'] = currentPlayers[playerIndex]['r_PlayerRequiredXP'] + (currentPlayers[playerIndex]['r_PlayerRequiredXP'])
    currentPlayers[playerIndex]['r_PlayerLevel'] = currentPlayers[playerIndex]['r_PlayerLevel'] + 1

    print(currentPlayers[playerIndex]['r_PlayerName'] .. " HAS GAINED A LEVEL!!!!")
    print("NEW LEVEL IS: ")
    print(currentPlayers[playerIndex]['r_PlayerLevel'])

    local level = currentPlayers[playerIndex]['r_PlayerLevel']

    NetEvents:Broadcast('OnGeneralLevelUp', level)
    
    -- print(currentPlayers[playerIndex]['r_PlayerLevel'])
    
end

Events:Subscribe('Player:Score', function(player, scoringTypeData, score)
    -- local rankPlayer = PlayerManager:GetPlayerByName(playerName)

    -- if rankPlayer.name == player.name then
    --     NetEvents:Broadcast('PlayerScoreEvent', score)
    -- end
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

    --     table.insert(currentPlayers, playerRankObject)
    -- end

    
end)

Events:Subscribe('Player:Created', function(player)
    -- local playerRankObject = playerRankClass(player)

    -- print("THE RECEIVED PLAYER OBJECT IS: ")
    -- print(player)

    -- table.insert(currentPlayers, playerRankObject)

end)

NetEvents:Subscribe('AddNewPlayerForStats', function(player, data)
    print(player.name .. ' is joining.')
    print(data)

    local playerRankObject = playerRankClass(player)
    table.insert(currentPlayers, playerRankObject)


end)

Events:Subscribe('Player:Left', function(player)
    if #currentPlayers > 0 then
        for playerIndex, cPlayer in pairs(currentPlayers) do
            if cPlayer['r_PlayerName'] == player.name then
                print("AWWW A PLAYER LEFT QWQ")

                currentPlayers[playerIndex] = nil
            end
        end
    end
end)

NetEvents:Subscribe('AddExperience', function(player, data)
    PlayerXPUpdated(player, data)
end)