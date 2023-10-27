-- supportProgressUnlockList = {
return {
    {
        lvl = 1,
        equipmentPath = 'Weapons/RPK/U_RPK-74M',
        uskit = 'Gameplay/Kits/USSupport',
        rukit = 'Gameplay/Kits/RUSupport',
        slotId = 'ID_M_SOLDIER_PRIMARY',
        xpRequired = 0
    },
    {
        lvl = 1,
        equipmentPath = 'Weapons/M27IAR/U_M27IAR',
        uskit = 'Gameplay/Kits/USSupport',
        rukit = 'Gameplay/Kits/RUSupport',
        slotId = 'ID_M_SOLDIER_PRIMARY',
        xpRequired = 0
    },
    -- This is a strange one. For some reason, im unable to lock the ammo bag because its in a weird slot. 
    -- You would think it would go into 'ID_M_SOLDIER_GADGET1', and it does, but this category is shared with another. 
    -- So currently, its unnecessary to unlock it again, because it will get duplicated...
    -- {
    --     lvl = 1,
    --     equipmentPath = 'Weapons/Gadgets/Ammobag/U_Ammobag',
    --     uskit = 'Gameplay/Kits/USSupport',
    --     rukit = 'Gameplay/Kits/RUSupport',
    --     slotId = 'ID_M_SOLDIER_GADGET1',
    --     xpRequired = 0
    -- },
    {
        lvl = 2,
        equipmentPath = 'Weapons/Gadgets/C4/U_C4',
        uskit = 'Gameplay/Kits/USSupport',
        rukit = 'Gameplay/Kits/RUSupport',
        slotId = 'ID_M_SOLDIER_GADGET2',
        xpRequired = 3000
    },
    {
        lvl = 3,
        equipmentPath = 'Weapons/M249/U_M249',
        uskit = 'Gameplay/Kits/USSupport',
        rukit = 'Gameplay/Kits/RUSupport',
        slotId = 'ID_M_SOLDIER_PRIMARY',
        xpRequired = 7000
    },
    {
        lvl = 4,
        equipmentPath = 'Weapons/Gadgets/Claymore/U_Claymore',
        uskit = 'Gameplay/Kits/USSupport',
        rukit = 'Gameplay/Kits/RUSupport',
        slotId = 'ID_M_SOLDIER_GADGET2',
        xpRequired = 12000
    },
    {
        lvl = 5,
        equipmentPath = 'Weapons/Gadgets/M224/U_M224',
        uskit = 'Gameplay/Kits/USSupport',
        rukit = 'Gameplay/Kits/RUSupport',
        slotId = 'ID_M_SOLDIER_GADGET2',
        xpRequired = 18000
    },
    {
        lvl = 6,
        equipmentPath = 'Weapons/Pecheneg/U_Pecheneg',
        uskit = 'Gameplay/Kits/USSupport',
        rukit = 'Gameplay/Kits/RUSupport',
        slotId = 'ID_M_SOLDIER_PRIMARY',
        xpRequired = 25000
    },
    {
        lvl = 7,
        equipmentPath = 'Weapons/M240/U_M240',
        uskit = 'Gameplay/Kits/USSupport',
        rukit = 'Gameplay/Kits/RUSupport',
        slotId = 'ID_M_SOLDIER_PRIMARY',
        xpRequired = 38000
    },
    {
        lvl = 8,
        equipmentPath = 'Weapons/M60/U_M60',
        uskit = 'Gameplay/Kits/USSupport',
        rukit = 'Gameplay/Kits/RUSupport',
        slotId = 'ID_M_SOLDIER_PRIMARY',
        xpRequired = 70000
    }
}