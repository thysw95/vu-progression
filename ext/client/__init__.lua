require('LockEquipment')
require('UnlockEquipment')
require('__shared/config')

-- This function unlocks an item for the client, depending on the selected category
function UnlockClientItem(levelCat, level)
    
    -- print("levelCat: " .. levelCat)
    -- print("level: " .. tostring(level))

    -- If level category is general, unlock a piece of equipment for general
    if levelCat == 'General' then
        if #generalProgressionUnlockList > 0 then
            for _, unlock in pairs(generalProgressionUnlockList) do
                if unlock.lvl == level then
                    ApplyUnlock(unlock.equipmentPath, unlock.slotId, unlock.kit)
                end
            end
        end
    end
    
    -- If level category is assault, unlock a piece of equipment for assault
    if levelCat == 'Assault' then
        print("SOMETHING WITH ASSUALT IS SUPPOSED TO HAPPEN")
        print("ASSAULT IS LEVEL " .. level)

        if #assaultProgressionUnlockList > 0 then
            for _, unlock in pairs(assaultProgressionUnlockList) do
                if unlock.lvl == level then
                    print("THE FOUND UNLOCK IS: ")
                    print(unlock)

                    ApplyUnlock(unlock.equipmentPath, unlock.slotId, unlock.uskit)
                    ApplyUnlock(unlock.equipmentPath, unlock.slotId, unlock.rukit)
                end
            end
        end
    end

    -- If level category is engineer, unlock a piece of equipment for engineer
    if levelCat == 'Engineer' then
        if #engineerProgressUnlockList > 0 then
            for _, unlock in pairs(engineerProgressUnlockList) do
                if unlock.lvl == level then
                    -- print("THE FOUND UNLOCK IS: ")
                    -- print(unlock)

                    ApplyUnlock(unlock.equipmentPath, unlock.slotId, unlock.uskit)
                    ApplyUnlock(unlock.equipmentPath, unlock.slotId, unlock.rukit)
                end
            end
        end
    end

    -- If level category is support, unlock a piece of equipment for support
    if levelCat == 'Support' then
        if #supportProgressUnlockList > 0 then
            for _, unlock in pairs(supportProgressUnlockList) do
                if unlock.lvl == level then
                    -- print("THE FOUND UNLOCK IS: ")
                    -- print(unlock)

                    ApplyUnlock(unlock.equipmentPath, unlock.slotId, unlock.uskit)
                    ApplyUnlock(unlock.equipmentPath, unlock.slotId, unlock.rukit)
                end
            end
        end
    end

    -- If level category is recon, unlock a piece of equipment for recon
    if levelCat == 'Recon' then
        if #reconProgressUnlockList > 0 then
            for _, unlock in pairs(reconProgressUnlockList) do
                if unlock.lvl == level then
                    -- print("THE FOUND UNLOCK IS: ")
                    -- print(unlock)

                    ApplyUnlock(unlock.equipmentPath, unlock.slotId, unlock.uskit)
                    ApplyUnlock(unlock.equipmentPath, unlock.slotId, unlock.rukit)
                end
            end
        end
    end
end

Events:Subscribe('Level:Finalized', function(levelName, gameMode)
    InitAssetsLock()
    NetEvents:Send('AddNewPlayerForStats', 'Adding new player to Stats')
end)

NetEvents:Subscribe('OnInitialUnlock', function(levelCat, level)
    print("THE SELECTED LEVEL CAT IS:")
    print(levelCat)
    UnlockClientItem(levelCat, level)
end)

NetEvents:Subscribe('OnLevelUp', function(levelCat, level)
    -- if levelCat == 'Assault' then
    --     print("OH YEAH ITS ASSAULT LEVELLIN TIMEEEEE!!!!!!! UWU")
    -- end
    UnlockClientItem(levelCat, level)
end)

local command = Console:Register('addExperience', 'Adds Experience', function()
	NetEvents:Send('AddExperience', 4000)
end)