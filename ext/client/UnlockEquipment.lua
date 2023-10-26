require("__shared/config")

foundAssaultKit = false
kitNameGlobal = ''
equipSlotGlobal= ''

function ApplyUnlock(equipmentPath, equipmentSlot, kitName)

    -- print("THE FOLLOWING UNLONCK VALUES ARE BEING APPLIED:")
    -- print("EQUIPMENT PATH: " .. equipmentPath)
    -- print("EQUIPMENT SLOT: " .. equipmentSlot)
    -- print("KITNAME " .. kitName)

    if kitName == 'All' then

        if #kits > 0 then
            for _, kit in pairs(kits) do
                local veniceSoldierAsset = ResourceManager:SearchForDataContainer(kit)

                if veniceSoldierAsset ~= nil then
                    veniceSoldierAsset = VeniceSoldierCustomizationAsset(veniceSoldierAsset)

                    UnlockEquipment(veniceSoldierAsset, equipmentPath, equipmentSlot)
                end   
            end
        end
    else 
        -- print("I AM A DIFFERENT KIT!!!!! HEAR ME ROAR!!!!!!!!!")
        foundAssaultKit = true
        kitNameGlobal = kitName
        equipSlotGlobal = equipmentSlot
        local veniceSoldierAsset = ResourceManager:SearchForDataContainer(kitName)

        if veniceSoldierAsset ~= nil then
            veniceSoldierAsset = VeniceSoldierCustomizationAsset(veniceSoldierAsset)

            UnlockEquipment(veniceSoldierAsset, equipmentPath, equipmentSlot)
        end  
    end
        
end

function UnlockEquipment(veniceSoldierAsset, equipmentPath, equipmentSlot)
    -- print('PASS 2')
    -- local slotId = UICategorySid(equipmentSlot)
    

    if veniceSoldierAsset.weaponTable ~= nil then
        local customTable = CustomizationTable(veniceSoldierAsset.weaponTable)
        
        -- print('PASS 3')

        -- print("EQUIPPATH:")
        -- print(equipmentPath)

        -- print("SLOT")
        -- print(equipmentSlot)

        for i,unlockPart in pairs(customTable.unlockParts) do
            local unlockPart = CustomizationUnlockParts(unlockPart)

            -- print("GIVEN SLOT")
            -- print(equipmentSlot)

            -- print("CURRENT SLOT")
            -- print(unlockPart.uiCategorySid)

            if unlockPart.uiCategorySid == equipmentSlot then
                unlockPart:MakeWritable()

                -- print("UNLOCKING:")
                -- print(equipmentPath)

                local findEquipment = ResourceManager:SearchForDataContainer(equipmentPath)
                if findEquipment ~= nil then
                    local equipment = SoldierWeaponUnlockAsset(findEquipment)

                    

                    unlockPart.selectableUnlocks:add(equipment)

                end
            end
        end
    end
    
end

-- Unlock weapon attachment
function UnlockAttachment(weaponCustimozationPath, attachmentPath, slotIndex)
    local weaponCustomAsset = ResourceManager:SearchForDataContainer(weaponCustimozationPath)
    local attachment = ResourceManager:SearchForDataContainer(attachmentPath)

    if weaponCustomAsset ~= nil and attachment ~= nil then
        local weaponCustomAssetMain = VeniceSoldierWeaponCustomizationAsset(weaponCustomAsset)
        local attachmentMain = UnlockAsset(attachment)

        local attachTable = CustomizationTable(weaponCustomAssetMain.customization)

        attachTable.unlockParts[slotIndex]:MakeWritable();
        attachTable.unlockParts[slotIndex].selectableUnlocks:add(attachmentMain)
    end
end