require("__shared/KitVariables")

function ApplyUnlock(equipmentPath, equipmentSlot, kitName)
    local unlockAssetBase = ResourceManager:SearchForDataContainer(equipmentPath)
    -- Handle XP4 maps having different equipment paths for soldier camos
    if unlockAssetBase == nil and equipmentSlot == CUST_UNLOCK_CAT_IDS.camo then
        -- Default camo is the only one that doesn't end in '_XP4'
        if equipmentPath:match("_DEFAULT$") then
            equipmentPath = equipmentPath:gsub("_DEFAULT$", "_XP4_DEFAULT")
        else
            equipmentPath = equipmentPath .. "_XP4"
        end
        unlockAssetBase = ResourceManager:SearchForDataContainer(equipmentPath)
    end
    -- Final check if resource was found
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
    
    -- Get correct CustomizationTable 
    if equipmentSlot == CUST_UNLOCK_CAT_IDS.specialization then
        customizationTable = CustomizationTable(veniceSoldierAsset.specializationTable)
    elseif equipmentSlot == CUST_UNLOCK_CAT_IDS.camo then
        customizationTable = CustomizationTable(veniceSoldierAsset.visualTable)
    else
        customizationTable = CustomizationTable(veniceSoldierAsset.weaponTable)
    end

    for _, customizationUnlockParts in pairs(customizationTable.unlockParts) do
        if equipmentSlot == customizationUnlockParts.uiCategorySid
            or equipmentSlot == CUST_UNLOCK_CAT_IDS.camo then -- Camo has special case b/c it has nil ID and only 1 unlock part
            -- Can later come back to UnlockAssetBase to figure out how to lock or unlock something without removing them from the SoldierAsset
            local foundEquip = false

            for _, unlock in pairs(customizationUnlockParts.selectableUnlocks) do -- Check if already unlocked
                if unlock.debugUnlockId == unlockAssetBase.debugUnlockId then
                    foundEquip = true
                    break
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

        if attachTable ~= nil and weaponCustomAssetMain ~= nil and attachmentMain ~= nil then
            for _, unlock in pairs(attachTable.unlockParts[slotIndex].selectableUnlocks) do -- Check if already unlocked
                if unlock.debugUnlockId == attachmentMain.debugUnlockId then
                    foundAttach = true
                    break
                end
            end

            if foundAttach == false then
                -- print("Unlocking " .. attachmentPath .. " in " .. weaponCustomizationPath)
                attachTable.unlockParts[slotIndex]:MakeWritable();
                attachTable.unlockParts[slotIndex].selectableUnlocks:add(attachmentMain)
            end
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

            for _, unlock in pairs(customizationUnlockParts.selectableUnlocks) do -- Check if already unlocked
                if unlock.debugUnlockId == unlockAssetBase.debugUnlockId then
                    foundUnlock = true
                    break
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