require('LockEquipment')
require('UnlockEquipment')
require('__shared/config')

function UnlockClientEquipment(level)
    print("AM I GOING TO UNLOCK SOMETHING??? OWO")
    if #generalProgressionUnlockList > 0 then
        for _, unlock in pairs(generalProgressionUnlockList) do
            if unlock.lvl == level then
                ApplyUnlock(unlock.equipmentPath, unlock.slotId, unlock.kit)
            end
        end
    end
end

Events:Subscribe('Level:Finalized', function(levelName, gameMode)
    InitAssetsLock()
    NetEvents:Send('AddNewPlayerForStats', 'Adding new player to Stats')
end)

NetEvents:Subscribe('OnInitialUnlock', function(level)
    UnlockClientEquipment(level)
end)

NetEvents:Subscribe('OnGeneralLevelUp', function(level)
    UnlockClientEquipment(level)
end)

local command = Console:Register('addExperience', 'Adds Experience', function()
	NetEvents:Send('AddExperience', 4000)
end)