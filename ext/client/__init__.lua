require('LockEquipment')
require('UnlockEquipment')

require('__shared/config')
require("__shared/KitVariables")
local generalProgressionUnlockList = require("__shared/Progression/GeneralProgressionConfig")
local assaultProgressionUnlockList = require("__shared/Progression/AssaultProgressionConfig")
local engineerProgressUnlockList = require("__shared/Progression/EngineerProgressionConfig")
local supportProgressUnlockList = require("__shared/Progression/SupportProgressionConfig")
local reconProgressUnlockList = require("__shared/Progression/ReconProgressionConfig")
local weaponProgressUnlocks = require("__shared/Progression/WeaponProgressionConfig")

-- This function unlocks an item for the client, depending on the selected category
function UnlockClientItem(levelCat, currentXp)
    
    -- print("levelCat: " .. levelCat)
    -- print("level: " .. tostring(level))

    -- If level category is general, unlock a piece of equipment for general
    if levelCat == 'General' then
        if #generalProgressionUnlockList > 0 then
            for _, unlock in pairs(generalProgressionUnlockList) do
                if unlock.xpRequired <= currentXp then
                    ApplyUnlock(unlock.equipmentPath, unlock.slotId, unlock.kit)
                end
            end
        end
    end
    
    -- If level category is assault, unlock a piece of equipment for assault
    if levelCat == 'Assault' then

        if #assaultProgressionUnlockList > 0 then
            for _, unlock in pairs(assaultProgressionUnlockList) do
                if unlock.xpRequired <= currentXp then
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
                if unlock.xpRequired <= currentXp then
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
                if unlock.xpRequired <= currentXp then
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
                if unlock.xpRequired <= currentXp then
                    -- print("THE FOUND UNLOCK IS: ")
                    -- print(unlock)

                    ApplyUnlock(unlock.equipmentPath, unlock.slotId, unlock.uskit)
                    ApplyUnlock(unlock.equipmentPath, unlock.slotId, unlock.rukit)
                end
            end
        end
    end
end

function UnlockClientAttachment(weaponName, kills)
    if #weaponProgressUnlocks > 0 then
        for _, weaponUnlocks in pairs(weaponProgressUnlocks) do

            if weaponUnlocks.weaponName == weaponName then
                if #weaponUnlocks.unlocks > 0 then
                    for _, unlocks in pairs(weaponUnlocks.unlocks) do

                        if kills >= unlocks.killsRequired then
                            UnlockAttachment(weaponUnlocks.customizationPath, unlocks.attachmentPath, unlocks.attachmentSlotIndex)
                        end

                    end
                end

                -- Break the main loop when a weapon is found
                break
            end

        end
    end 
end


Events:Subscribe('Level:Finalized', function(levelName, gameMode)
    InitAssetsLock()
    NetEvents:Send('AddNewPlayerForStats', 'Adding new player to Stats')
end)

NetEvents:Subscribe('OnInitialUnlock', function(levelCat, currentXp)
    print("THE SELECTED LEVEL CAT IS:")
    print(levelCat)

    UnlockClientItem(levelCat, currentXp)

end)

NetEvents:Subscribe('OnInitialAttachmentUnlock', function(weaponProgressList)
    print("UNLOCKING INITIAL ATTACHMENTS")
    
    -- if #weaponProgressUnlocks > 0 then
    --     for _, weaponUnlocks in pairs(weaponProgressUnlocks) do
    --         UnlockClientAttachment(weaponUnlocks.weaponName, 0)
    --     end
    -- end
    if #weaponProgressList > 0 then
        for _, weapon in pairs(weaponProgressList) do
            UnlockClientAttachment(weapon.weaponName, weapon.kills)
        end
    end
    
end)

NetEvents:Subscribe('OnKilledPlayer', function(weaponName, kills)
    print("RECIEVED " .. tostring(kills) .. " KILLS WITH THE WEAPON " .. weaponName)
    
    -- if #weaponProgressUnlocks > 0 then
    --     for _, weaponUnlocks in pairs(weaponProgressUnlocks) do
    --         UnlockClientAttachment(weaponUnlocks.weaponName, 0)
    --     end
    -- end
    UnlockClientAttachment(weaponName, kills)
end)

NetEvents:Subscribe('OnLevelUp', function(levelCat, currentXp)
    -- if levelCat == 'Assault' then
    --     print("OH YEAH ITS ASSAULT LEVELLIN TIMEEEEE!!!!!!! UWU")
    -- end
    UnlockClientItem(levelCat, currentXp)
end)

local command = Console:Register('addExperience', 'Adds Experience', function()
	NetEvents:Send('AddExperience', 4000)
end)

local command = Console:Register('addKill', 'Adds Kill for M16', function()
	NetEvents:Send('AddKill', 'Weapons/M16A4/M16A4')
end)