require('LockEquipment')
require('UnlockEquipment')
require('SoundManager')

require('__shared/config')
require("__shared/KitVariables")
local PROG_CONFIGS = {
    General = require("__shared/Progression/GeneralProgressionConfig"),
    Assault = require("__shared/Progression/AssaultProgressionConfig"),
    Engineer = require("__shared/Progression/EngineerProgressionConfig"),
    Support = require("__shared/Progression/SupportProgressionConfig"),
    Recon = require("__shared/Progression/ReconProgressionConfig"),
    Weapon = require("__shared/Progression/WeaponProgressionConfig"),
    Vehicle = require("__shared/Progression/VehicleProgressionConfig"),
}

-- This function unlocks an item for the client, depending on the selected category
function UnlockClientItem(levelCat, levelIndex)
    if #PROG_CONFIGS[levelCat] > 0 then
        -- for _, unlockSet in pairs(PROG_CONFIGS[levelCat]) do
        --     if (currentXp >= unlockSet.xpRequired and #unlockSet.unlocks > 0) then
        --         -- Loop through unlocks in each unlock
        --         for _, unlock in pairs(unlockSet.unlocks) do
        --             for _, kit in pairs(unlock.kits) do
        --                 ApplyUnlock(unlock.equipmentPath, unlock.slotId, kit)
        --             end
        --         end

        --     end
        -- end
        local unlockSet = PROG_CONFIGS[levelCat][levelIndex]

        if unlockSet then
            for _, unlock in pairs(unlockSet.unlocks) do
                for _, kit in pairs(unlock.kits) do
                    ApplyUnlock(unlock.equipmentPath, unlock.slotId, kit)
                end
            end
        end
    end
end

function UnlockClientAttachment(weaponName, kills)
    for _, weaponUnlocks in pairs(PROG_CONFIGS.Weapon) do
        if weaponUnlocks.weaponName == weaponName then
            for _, unlock in pairs(weaponUnlocks.unlocks) do
                if kills >= unlock.killsRequired then
                    UnlockAttachment(weaponUnlocks.customizationPath, unlock.attachmentPath, unlock.attachmentSlotIndex)
                end
            end
            -- Break the main loop when a weapon is found
            break
        end
    end
end

function UnlockClientVehicleCust(typeName, score)
    for _, vicType in pairs(PROG_CONFIGS.Vehicle) do
        if vicType.prettyName == typeName then
            for _, unlock in pairs(vicType.unlocks) do
                if score >= unlock.vicScoreRequired then
                    UnlockVicCustomization(vicType.customizationPath, unlock.unlockPath, unlock.category)
                end
            end
            -- Break the main loop when the vehicle type is found
            break
        end
    end
end

Events:Subscribe('Level:Finalized', function(levelName, gameMode)
    InitAssetsLock()
    NetEvents:Send('AddNewPlayerForStats', 'Adding new player to Stats')
end)

NetEvents:Subscribe('OnInitialUnlock', function(levelCat, levelIndex)
    print("UNLOCKING INITIAL " .. levelCat .. " GEAR")

    -- UnlockClientItem does not loop through the entire list
    -- so, for initial unlocks, we need to get everything up until the current level
    for i = 1, levelIndex do
       UnlockClientItem(levelCat, i) 
    end
end)

NetEvents:Subscribe('OnInitialAttachmentUnlock', function(weaponProgressList)
    print("UNLOCKING INITIAL Weapon ATTACHMENTS")
    
    for _, weapon in pairs(weaponProgressList) do
        UnlockClientAttachment(weapon.weaponName, weapon.kills)
    end
end)

NetEvents:Subscribe('OnInitialVehicleUnlock', function(vehicleProgressList)
    print("UNLOCKING INITIAL Vehicle CUSTOMIZATIONS")
    
    for _, vicType in pairs(vehicleProgressList) do
        UnlockClientVehicleCust(vicType.typeName, vicType.score)
    end
end)

NetEvents:Subscribe('OnKilledPlayer', function(weaponName, kills)
    UnlockClientAttachment(weaponName, kills)
end)

NetEvents:Subscribe('OnLevelUp', function(levelCat, levelIndex)
    UnlockClientItem(levelCat, levelIndex)
end)

NetEvents:Subscribe('OnVehicleCustUnlock', function(typeName, score)
    UnlockClientVehicleCust(typeName, score)
end)

-- DEBUG
if CONFIG.General.debug then

    Console:Register('AddXP', 'DEBUG: Adds experience to local player', function(args)
        if #args == 1 then
            if PlayerManager:GetLocalPlayer().soldier == nil then
                print("Warning: You must be spawned in to earn Class XP!")
            end
            NetEvents:SendLocal('AddXP', args[1])
            print("Added " .. args[1] .. " XP to self")
        end
    end)

    Console:Register('AddKillsToWeap', 'DEBUG: Adds kills[1] to weaponName[2]', function(args)
        if #args == 2 then
            NetEvents:SendLocal('AddKillsToWeap', args[1], args[2])
            print("Added " .. args[1] .. " kills to " .. args[2] .. " for self")
        end
    end)

end