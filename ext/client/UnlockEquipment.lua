require("__shared/KitVariables")

function ApplyUnlock(equipmentPath, equipmentSlot, kitName)
    local unlockAssetBase = ResourceManager:SearchForDataContainer(equipmentPath)
    if unlockAssetBase == nil then
        print("CANNOT FIND UNLOCK equipmentPath: " .. equipmentPath)
        return
    end
    unlockAssetBase = UnlockAssetBase(unlockAssetBase)
    
    -- print("Unlocking " .. unlockAssetBase.debugUnlockId .. " in " .. equipmentSlot .. " for " .. kitName)

    if kitName == 'All' then -- Unlock for all kits
        for _, class in pairs(KITS) do
            for _, kit in pairs(class) do
                local veniceSoldierAsset = ResourceManager:SearchForDataContainer(kit)

                if veniceSoldierAsset ~= nil then
                    veniceSoldierAsset = VeniceSoldierCustomizationAsset(veniceSoldierAsset)

                    UnlockEquipment(veniceSoldierAsset, unlockAssetBase, equipmentSlot)
                end 
            end 
        end
    else -- Unlock for specific kit (kitName)
        local veniceSoldierAsset = ResourceManager:SearchForDataContainer(kitName)

        if veniceSoldierAsset ~= nil then
            veniceSoldierAsset = VeniceSoldierCustomizationAsset(veniceSoldierAsset)

            UnlockEquipment(veniceSoldierAsset, unlockAssetBase, equipmentSlot)
        end  
    end
        
end

function UnlockEquipment(veniceSoldierAsset, unlockAssetBase, equipmentSlot)
    local customizationTable
    if equipmentSlot == KIT_SPECIALIZATION_ID then
        if veniceSoldierAsset.specializationTable == nil then
            print("specializationTable IS NIL!?")
            return
        end
        customizationTable = CustomizationTable(veniceSoldierAsset.specializationTable)
    else
        if veniceSoldierAsset.weaponTable == nil then
            print("weaponTable IS NIL!?")
            return
        end
        customizationTable = CustomizationTable(veniceSoldierAsset.weaponTable)
    end

    for _, customizationUnlockParts in pairs(customizationTable.unlockParts) do
        if customizationUnlockParts.uiCategorySid == equipmentSlot then
            -- Can later come back to UnlockAssetBase to figure out how to lock or unlock something without removing them from the SoldierAsset
            local foundEquip = false

            if #customizationUnlockParts.selectableUnlocks > 0 then -- Check if already unlocked
                for _, unlock in pairs(customizationUnlockParts.selectableUnlocks) do
                    if unlock.debugUnlockId == unlockAssetBase.debugUnlockId then
                        foundEquip = true
                        break
                    end
                end
            end

            if foundEquip == false then
                -- print("Unlocking " .. unlockAssetBase.debugUnlockId .. " in " .. equipmentSlot .. " for " .. veniceSoldierAsset.name)
                customizationUnlockParts:MakeWritable()
                customizationUnlockParts.selectableUnlocks:add(unlockAssetBase)
            end

            break -- We found the right equipment slot
        end
    end
    
end

-- Unlock weapon attachment
function UnlockAttachment(weaponCustomizationPath, attachmentPath, slotIndex)
    local weaponCustomAsset = ResourceManager:SearchForDataContainer(weaponCustomizationPath)
    local attachment = ResourceManager:SearchForDataContainer(attachmentPath)

    if weaponCustomAsset ~= nil and attachment ~= nil then
        local weaponCustomAssetMain = VeniceSoldierWeaponCustomizationAsset(weaponCustomAsset)
        local attachmentMain = UnlockAssetBase(attachment)

        local attachTable = CustomizationTable(weaponCustomAssetMain.customization)

        local foundAttach = false

        if #attachTable.unlockParts[slotIndex].selectableUnlocks > 0 then -- Check if already unlocked
            for _, unlock in pairs(attachTable.unlockParts[slotIndex].selectableUnlocks) do
                if unlock.debugUnlockId == attachmentMain.debugUnlockId then
                    foundAttach = true
                    break
                end
            end
        end

        if foundAttach == false then
            -- print("Unlocking " .. attachmentPath .. " in " .. weaponCustomizationPath)
            attachTable.unlockParts[slotIndex]:MakeWritable();
            attachTable.unlockParts[slotIndex].selectableUnlocks:add(attachmentMain)
        end
        
    end
end

-- Unlock vehicle customization
function UnlockVicCustomization(vehicleCustomizationPath, unlockPath, unlockCategory)
    local veniceVehicleCustomizationAsset = ResourceManager:SearchForDataContainer(vehicleCustomizationPath)
    if veniceVehicleCustomizationAsset == nil then
        print("CANNOT FIND VEHICLE customizationPath: " .. vehicleCustomizationPath)
        return
    end
    veniceVehicleCustomizationAsset = VeniceVehicleCustomizationAsset(veniceVehicleCustomizationAsset)

    local unlockAssetBase = ResourceManager:SearchForDataContainer(unlockPath)
    if unlockAssetBase == nil then
        print("CANNOT FIND VEHICLE unlockPath: " .. unlockPath)
        return
    end
    unlockAssetBase = UnlockAssetBase(unlockAssetBase)

    for _, customizationUnlockParts in pairs(veniceVehicleCustomizationAsset.customization.unlockParts) do
        if customizationUnlockParts.uiCategorySid == unlockCategory then
            local foundUnlock = false

            if #customizationUnlockParts.selectableUnlocks > 0 then -- Check if already unlocked
                for _, unlock in pairs(customizationUnlockParts.selectableUnlocks) do
                    if unlock.debugUnlockId == unlockAssetBase.debugUnlockId then
                        foundUnlock = true
                        break
                    end
                end
            end

            if foundUnlock == false then
                -- print("Unlocking " .. unlockAssetBase.debugUnlockId .. " in " .. unlockCategory .. " for " .. veniceVehicleCustomizationAsset.name)
                customizationUnlockParts:MakeWritable()
                customizationUnlockParts.selectableUnlocks:add(unlockAssetBase)
            end

            break -- We found the right customization category
        end
    end

end