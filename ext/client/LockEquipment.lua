require("__shared/KitVariables")
local weaponProgConfig = require("__shared/Progression/WeaponProgressionConfig")
local vehicleProgConfig = require("__shared/Progression/VehicleProgressionConfig")

-- Function to remove all the customization options for a given soldier asset and category ID
function lockSoldierCustomizationAsset(veniceSoldierAsset, categoryId)
    local customizationTable

    -- Get correct CustomizationTable 
    if categoryId == CUST_UNLOCK_CAT_IDS.specialization then
        customizationTable = CustomizationTable(veniceSoldierAsset.specializationTable)
    elseif categoryId == CUST_UNLOCK_CAT_IDS.camo then
        customizationTable = CustomizationTable(veniceSoldierAsset.visualTable)
    else
        customizationTable = CustomizationTable(veniceSoldierAsset.weaponTable)
    end

    -- Loop through UnlockParts until category ID is found 
    for _, unlockPart in pairs(customizationTable.unlockParts) do
        local unlockPart = CustomizationUnlockParts(unlockPart)

        if categoryId == unlockPart.uiCategorySid
            or categoryId == CUST_UNLOCK_CAT_IDS.camo then -- Camo has special case b/c it has nil ID and only 1 unlock part
            unlockPart:MakeWritable()
            for i = #unlockPart.selectableUnlocks,1,-1 do
                unlockPart.selectableUnlocks:erase(i)
            end
            break -- Category ID found 
        end
    end
end

-- Function to remove all the customization options on the selected weapon
function lockWeaponCustomizationAsset(weaponCustomizationAsset)
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
function lockVehicleCustomizationAsset(veniceVehicleCustomizationAsset)
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

                for _, categoryId in pairs(CUST_UNLOCK_CAT_IDS) do
                    lockSoldierCustomizationAsset(veniceSoldierAsset, categoryId)
                end
            end
        end
    end

    -- Loop through all the weapon customization assets
    print(">>>>>>>> LOCKING WEAPON CUSTOMIZATION ASSETS <<<<<<<<")
    for _, weapon in pairs(weaponProgConfig) do
        local weaponCustomizationAsset = ResourceManager:SearchForDataContainer(weapon.customizationPath)

        if weaponCustomizationAsset ~= nil then
            weaponCustomizationAsset = VeniceSoldierWeaponCustomizationAsset(weaponCustomizationAsset)

            lockWeaponCustomizationAsset(weaponCustomizationAsset)
        end
    end

    -- Loop through all the vehicle customization assets
    print(">>>>>>>> LOCKING VEHICLE ASSETS <<<<<<<<")
    for _, vicType in pairs(vehicleProgConfig) do
        local veniceVehicleCustomizationAsset = ResourceManager:SearchForDataContainer(vicType.customizationPath)

        if veniceVehicleCustomizationAsset ~= nil then
            veniceVehicleCustomizationAsset = VeniceVehicleCustomizationAsset(veniceVehicleCustomizationAsset)

            lockVehicleCustomizationAsset(veniceVehicleCustomizationAsset)
        end
    end
end