require("__shared/config")

function ApplyUnlock(equipmentPath, equipmentSlot, kitName)
    print('PASS1')
    if kitName == 'All' then
        if #kits > 0 then
            for _, kit in pairs(kits) do
                local veniceSoldierAsset = ResourceManager:SearchForDataContainer(kit)

                -- print('THE VENICE ASSET IS:')
                -- print(veniceSoldierAsset)

                if veniceSoldierAsset ~= nil then
                    veniceSoldierAsset = VeniceSoldierCustomizationAsset(veniceSoldierAsset)

                    UnlockEquipment(veniceSoldierAsset, equipmentPath, equipmentSlot)
                end
            end
        end
    end
end

function UnlockEquipment(veniceSoldierAsset, equipmentPath, equipmentSlot)
    -- print('PASS2')
    -- local slotId = UICategorySid(equipmentSlot)
    if veniceSoldierAsset.weaponTable ~= nil then
        local customTable = CustomizationTable(veniceSoldierAsset.weaponTable)
        
        -- print('PASS3')

        -- print("EQUIPPATH:")
        -- print(equipmentPath)

        print("SLOT")
        print(equipmentSlot)

        for i,unlockPart in pairs(customTable.unlockParts) do
            local unlockPart = CustomizationUnlockParts(unlockPart)

            print("GIVEN SLOT")
            print(equipmentSlot)

            print("CURRENT SLOT")
            print(unlockPart.uiCategorySid)

            if unlockPart.uiCategorySid == equipmentSlot then
                unlockPart:MakeWritable()

                print('PASS4')

                local findEquipment = ResourceManager:SearchForDataContainer(equipmentPath)
                if findEquipment ~= nil then
                    local equipment = SoldierWeaponUnlockAsset(findEquipment)

                    unlockPart.selectableUnlocks:add(equipment)
                end
            end
        end
    end
    
end