require("__shared/KitVariables")

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
                    --local equipment = SoldierWeaponUnlockAsset(findEquipment)
                    local equipment = UnlockAssetBase(findEquipment)
                    -- Can later come back to UnlockAssetBase to figure out how to lock or unluck something without removing them from the SoldierAsset 
                    equipment:MakeWritable()

                    print("THE UNLOCK ID OF THIS ITEM IS: ")
                    print(equipment.debugUnlockId)
                    -- equipment.hiddenInProgression = true
                    local foundEquip = false

                    if #unlockPart.selectableUnlocks > 0 then
                        for _, unlock in pairs(unlockPart.selectableUnlocks) do

                            unlock = UnlockAssetBase(unlock)
                            unlock:MakeWritable()

                            if unlock.debugUnlockId == equipment.debugUnlockId then
                                foundEquip = true
                            end
                        end
                    end

                    if foundEquip == false then
                        unlockPart.selectableUnlocks:add(equipment)
                    end
                    
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
        local attachmentMain = UnlockAssetBase(attachment)
        attachmentMain:MakeWritable()

        local attachTable = CustomizationTable(weaponCustomAssetMain.customization)

        attachTable.unlockParts[slotIndex]:MakeWritable();

        local foundAttach = false

        if #attachTable.unlockParts[slotIndex].selectableUnlocks > 0 then
            for _, unlock in pairs(attachTable.unlockParts[slotIndex].selectableUnlocks) do

                unlock = UnlockAssetBase(unlock)
                unlock:MakeWritable()

                if unlock.debugUnlockId == attachmentMain.debugUnlockId then
                    foundAttach = true
                end
            end
        end

        if foundAttach == false then
            attachTable.unlockParts[slotIndex].selectableUnlocks:add(attachmentMain)
        end
        
    end
end