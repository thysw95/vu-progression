Events:Subscribe('Partition:Loaded', function(partition)
    local index = 1
    local foundThingie = false

    for _, instance in pairs(partition.instances) do
        if instance:Is("VeniceSoldierWeaponCustomizationAsset") then
            local weaponCustomizationAsset = VeniceSoldierWeaponCustomizationAsset(instance)

            testAttachmentErase(weaponCustomizationAsset)
        end

        if instance:Is("VeniceSoldierCustomizationAsset") then
            local veniceSoldierAsset = VeniceSoldierCustomizationAsset(instance)
            
            testWeaponErase(veniceSoldierAsset)
            testWeaponAdd(veniceSoldierAsset, 'Weapons/F2000/U_F2000')
        end

        

        index = index + 1
    end
end)

local command = Console:Register('addScopeToGun', 'Adds a scope to the f2000 :3', function()
	local weaponCustomAsset = ResourceManager:SearchForDataContainer('Weapons/F2000/F2000_Customization')
    local attachment = ResourceManager:SearchForDataContainer('Weapons/F2000/U_F2000_PSO-1')

    if weaponCustomAsset ~= nil and attachment ~= nil then
        local weaponCustomAssetMain = VeniceSoldierWeaponCustomizationAsset(weaponCustomAsset)
        local attachmentMain = UnlockAsset(attachment)

        testAttachmentAdd(weaponCustomAssetMain, attachmentMain, 1)

        print("IM HOPEFULLY FUCKING DOING WHAT IM SUPPOSED TO OWO!!!!!!!!")
    end
end)

-- Any loudout specific data (weapons, gadgets etc) is part of the VeniceSoldierCustomizationAsset datatype. Every kit (USAssualt, recon etc) is 
-- of a VeniceSoldierCustomizationAsset data type. To get an asset, you can use "ResourceManager:SearchForDataContainer('KitName')"
-- To find a comprehensive list of all datacontainers within BF 3, go to: https://github.com/VeniceUnleashed/Venice-EBX
-- The kits of type VeniceSoldierCustomizationAsset, are found under Gameplay/Kits/. 

-- Example of how to get the RUAssualt kit, is as follows:
-- "local usAssualt = ResourceManager:SearchForDataContainer('Gameplay/Kits/USAssualt')"

-- The structure of a kit/VeniceSoldierCustomizationAsset can be understood by opening the accompannying text file and reading though each section.
-- A section contains its own data values and is bound to other sections via a GUID. Example, to get the data of a section of a VeniceSoldierCustomizationAsset, do the following
-- "VeniceSoldierCustomizationAsset.weaponTable.unlockParts[1].selectableUnlocks[i]"

function testAttachmentErase(weaponCustomizationAsset)
    local attachTable = CustomizationTable(weaponCustomizationAsset.customization)
    for i, unlockPart in pairs(attachTable.unlockParts) do

        local unlockPart = CustomizationUnlockParts(unlockPart)
        unlockPart:MakeWritable()

        for i = #unlockPart.selectableUnlocks,1,-1 do


            unlockPart.selectableUnlocks:erase(i)
        end
    end
end

function testAttachmentAdd(weaponCustomizationAsset, attachement, attachmentSlotIndex)
    local attachTable = CustomizationTable(weaponCustomizationAsset.customization)
    -- print("With the attachment path " .. attachmentGuid)

    -- local attachmentToAdd = UnlockAsset(foundAttachment)

    attachTable.unlockParts[attachmentSlotIndex]:MakeWritable();
    attachTable.unlockParts[attachmentSlotIndex].selectableUnlocks:add(attachement)
end

function testWeaponErase(veniceSoldierAsset)
    local weaponTable = CustomizationTable(veniceSoldierAsset.weaponTable)
    for i,unlockPart in pairs(weaponTable.unlockParts) do
        local unlockPart = CustomizationUnlockParts(unlockPart)
        unlockPart:MakeWritable()

        for i = #unlockPart.selectableUnlocks,1,-1 do
            if i ~= 1 then


                unlockPart.selectableUnlocks:erase(i)
            end
            
        end
    end
end

function testWeaponAdd(veniceSoldierAsset, weaponPath)
    local weaponTable = CustomizationTable(veniceSoldierAsset.weaponTable)
    for i,unlockPart in pairs(weaponTable.unlockParts) do
        local unlockPart = CustomizationUnlockParts(unlockPart)
        unlockPart:MakeWritable()

        local testWeapon = ResourceManager:SearchForDataContainer(weaponPath)
        if testWeapon ~= nil then
            local weapon = SoldierWeaponUnlockAsset(testWeapon)

            unlockPart.selectableUnlocks:add(weapon)
        end
    end
end
