require("__shared/config")

Events:Subscribe('Player:Score', function(player, scoringTypeData, score)
    local rankPlayer = PlayerManager:GetPlayerByName(playerName)

    if rankPlayer.name == player.name then
        NetEvents:Broadcast('PlayerScoreEvent', score)
    end
end)

Events:Subscribe('Player:Joining', function(name, playerGuid, ipAddress, accountGuid)
    print('PLAYER JOINING OWO!!!!!!!!!')
    print('Player Name:')
    print(name)
    print('Player Guid:')
    print(playerGuid)
    print('Account Guid')
    print(accountGuid)
end)