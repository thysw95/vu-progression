require('LockEquipment')

Events:Subscribe('Level:Finalized', function(levelName, gameMode)
    InitAssetsLock()
end)

NetEvents:Subscribe('PlayerScoreEvent', function(score)
    print("SCORING EVENT JUST OCCURED")
    print("SCORE: ")
    print(score)
end)