require("__shared/KitVariables")
local weaponProgConfig = require("__shared/Progression/WeaponProgressionConfig")
local vehicleProgConfig = require("__shared/Progression/VehicleProgressionConfig")

-- Function to remove all the customization options on the selected soldier
function LockSoldierCustomizationAsset(veniceSoldierAsset, categoryId)
    local weaponTable = CustomizationTable(veniceSoldierAsset.weaponTable)
    for i,unlockPart in pairs(weaponTable.unlockParts) do
        local unlockPart = CustomizationUnlockParts(unlockPart)
        unlockPart:MakeWritable()

        local partCatId = unlockPart.uiCategorySid

        if partCatId == categoryId then
            for i = #unlockPart.selectableUnlocks,1,-1 do
                unlockPart.selectableUnlocks:erase(i)
            end
        end
        
    end
end

-- Function to remove all the specialization options on the selected soldier
function lockSoldierSpecializationAsset(veniceSoldierAsset)
    local specialTable = CustomizationTable(veniceSoldierAsset.specializationTable)

    if specialTable ~= nil then
        for _, unlockPart in pairs(specialTable.unlockParts) do
            local unlockPart = CustomizationUnlockParts(unlockPart)
            unlockPart:MakeWritable()

            for i = #unlockPart.selectableUnlocks,1,-1 do
                unlockPart.selectableUnlocks:erase(i)
            end
        end
    end
end

-- Function to remove all the customization options on the selected weapon
function LockWeaponCustomizationAsset(weaponCustomizationAsset)
    local attachTable = CustomizationTable(weaponCustomizationAsset.customization)
    -- print("{name = " .. weaponCustomizationAsset.name .. "}")

    for i, unlockPart in pairs(attachTable.unlockParts) do

        local unlockPart = CustomizationUnlockParts(unlockPart)
        unlockPart:MakeWritable()

        -- print("INDEX: " .. i)

        for i = #unlockPart.selectableUnlocks,1,-1 do
            -- print("UNLOCK: ")
            -- print(unlockPart.selectableUnlocks[i])
            unlockPart.selectableUnlocks:erase(i)
        end
    end
end

-- Function to remove all the customization options on the selected vehicle
function LockVehicleCustomizationAsset(veniceVehicleCustomizationAsset)
    for _, unlockPart in pairs(veniceVehicleCustomizationAsset.customization.unlockParts) do
        unlockPart:MakeWritable()

        for i = #unlockPart.selectableUnlocks,1,-1 do
            -- print(unlockPart.selectableUnlocks[i].debugUnlockId)
            unlockPart.selectableUnlocks:erase(i)
        end

    end
end


-- Events:Subscribe('Partition:Loaded', function(partition)
--     for _, instance in pairs(partition.instances) do
--         if instance:Is("VeniceSoldierWeaponCustomizationAsset") then
--             local weaponCustomizationAsset = VeniceSoldierWeaponCustomizationAsset(instance)

--             print(weaponCustomizationAsset.name)
--         end
--     end
-- end)

function InitAssetsLock()
    -- Loop through all the kits and lock all assets
    print(">>>>>>>> LOCKING KIT ASSETS <<<<<<<<")
    for _, class in pairs(KITS) do
        for _, kit in pairs(class) do
            local veniceSoldierAsset = ResourceManager:SearchForDataContainer(kit)

            if veniceSoldierAsset ~= nil then
                veniceSoldierAsset = VeniceSoldierCustomizationAsset(veniceSoldierAsset)

                -- Lock primary weapons
                LockSoldierCustomizationAsset(veniceSoldierAsset, KIT_PRIMARY_WEAP_ID)

                -- Lock secondary weapons
                LockSoldierCustomizationAsset(veniceSoldierAsset, KIT_SECONDARY_WEAP_ID)

                -- Lock specializations
                lockSoldierSpecializationAsset(veniceSoldierAsset)

                -- Lock Soldier Gadget 1
                LockSoldierCustomizationAsset(veniceSoldierAsset, KIT_SOLDIER_GADGET1_ID)

                -- Lock Soldier Gadget 2
                LockSoldierCustomizationAsset(veniceSoldierAsset, KIT_SOLDIER_GADGET2_ID)

            end
        end
    end

    -- Loop through all the weapon customization assets
    print(">>>>>>>> LOCKING WEAPON CUSTOMIZATION ASSETS <<<<<<<<")
    for _, weapon in pairs(weaponProgConfig) do
        local weaponCustomizationAsset = ResourceManager:SearchForDataContainer(weapon.customizationPath)

        if weaponCustomizationAsset ~= nil then
            weaponCustomizationAsset = VeniceSoldierWeaponCustomizationAsset(weaponCustomizationAsset)

            LockWeaponCustomizationAsset(weaponCustomizationAsset)
        end
    end

    -- Loop through all the vehicle customization assets
    print(">>>>>>>> LOCKING VEHICLE ASSETS <<<<<<<<")
    for _, vicType in pairs(vehicleProgConfig) do
        local veniceVehicleCustomizationAsset = ResourceManager:SearchForDataContainer(vicType.customizationPath)

        if veniceVehicleCustomizationAsset ~= nil then
            veniceVehicleCustomizationAsset = VeniceVehicleCustomizationAsset(veniceVehicleCustomizationAsset)

            LockVehicleCustomizationAsset(veniceVehicleCustomizationAsset)
        end
    end
end