-- supportProgressUnlockList = {
return {
    {
        lvl = 1,
        prettyName = 'RPK-74M (RU)',
        equipmentPath = 'Weapons/RPK/U_RPK-74M',
        kits = {
            'Gameplay/Kits/RUSupport',
            'Gameplay/Kits/RUSupport_XP4',
        },
        slotId = 'ID_M_SOLDIER_PRIMARY',
        xpRequired = 0
    },
    {
        lvl = 1,
        prettyName = 'M27 IAR (US)',
        equipmentPath = 'Weapons/M27IAR/U_M27IAR',
        kits = {
            'Gameplay/Kits/USSupport',
            'Gameplay/Kits/USSupport_XP4',
        },
        slotId = 'ID_M_SOLDIER_PRIMARY',
        xpRequired = 0
    },
    {
        lvl = 1,
        prettyName = 'No Gadget',
        equipmentPath = 'Weapons/Common/NoGadget2',
        kits = {
            'Gameplay/Kits/USSupport',
            'Gameplay/Kits/USSupport_XP4',
            'Gameplay/Kits/RUSupport',
            'Gameplay/Kits/RUSupport_XP4',
        },
        slotId = 'ID_M_SOLDIER_GADGET2',
        xpRequired = 0
    },
    -- This is a strange one. For some reason, the Ammo Bag is in a CustomizationUnlockParts table with an
    -- inconsistent UICategorySid from kit to kit. Sometimes it it `nil`; sometimes it is `GADGET1`.
    -- Disabled here to prevent a duplicate Ammo Bag from being added.
    -- {
    --     lvl = 1,
    --     prettyName = 'Ammo Box',
    --     equipmentPath = 'Weapons/Gadgets/Ammobag/U_Ammobag',
    --     kits = {
    --         'Gameplay/Kits/USSupport',
    --         'Gameplay/Kits/USSupport_XP4',
    --         'Gameplay/Kits/RUSupport',
    --         'Gameplay/Kits/RUSupport_XP4',
    --     },
    --     slotId = 'ID_M_SOLDIER_GADGET1',
    --     xpRequired = 0
    -- },
    {
        lvl = 2,
        prettyName = 'C4 Explosives',
        equipmentPath = 'Weapons/Gadgets/C4/U_C4',
        kits = {
            'Gameplay/Kits/USSupport',
            'Gameplay/Kits/USSupport_XP4',
            'Gameplay/Kits/RUSupport',
            'Gameplay/Kits/RUSupport_XP4',
        },
        slotId = 'ID_M_SOLDIER_GADGET2',
        xpRequired = 4000
    },
    {
        lvl = 3,
        prettyName = 'M249',
        equipmentPath = 'Weapons/M249/U_M249',
        kits = {
            'Gameplay/Kits/USSupport',
            'Gameplay/Kits/USSupport_XP4',
            'Gameplay/Kits/RUSupport',
            'Gameplay/Kits/RUSupport_XP4',
        },
        slotId = 'ID_M_SOLDIER_PRIMARY',
        xpRequired = 11000
    },
    {
        lvl = 4,
        prettyName = 'M18 Claymore',
        equipmentPath = 'Weapons/Gadgets/Claymore/U_Claymore',
        kits = {
            'Gameplay/Kits/USSupport',
            'Gameplay/Kits/USSupport_XP4',
            'Gameplay/Kits/RUSupport',
            'Gameplay/Kits/RUSupport_XP4',
        },
        slotId = 'ID_M_SOLDIER_GADGET2',
        xpRequired = 23000
    },
    {
        lvl = 5,
        prettyName = 'M224 Mortar',
        equipmentPath = 'Weapons/Gadgets/M224/U_M224',
        kits = {
            'Gameplay/Kits/USSupport',
            'Gameplay/Kits/USSupport_XP4',
            'Gameplay/Kits/RUSupport',
            'Gameplay/Kits/RUSupport_XP4',
        },
        slotId = 'ID_M_SOLDIER_GADGET2',
        xpRequired = 40000
    },
    {
        lvl = 6,
        prettyName = 'PKP PECHENEG',
        equipmentPath = 'Weapons/Pecheneg/U_Pecheneg',
        kits = {
            'Gameplay/Kits/USSupport',
            'Gameplay/Kits/USSupport_XP4',
            'Gameplay/Kits/RUSupport',
            'Gameplay/Kits/RUSupport_XP4',
        },
        slotId = 'ID_M_SOLDIER_PRIMARY',
        xpRequired = 60000
    },
    {
        lvl = 7,
        prettyName = 'M240B',
        equipmentPath = 'Weapons/M240/U_M240',
        kits = {
            'Gameplay/Kits/USSupport',
            'Gameplay/Kits/USSupport_XP4',
            'Gameplay/Kits/RUSupport',
            'Gameplay/Kits/RUSupport_XP4',
        },
        slotId = 'ID_M_SOLDIER_PRIMARY',
        xpRequired = 90000
    },
    {
        lvl = 8,
        prettyName = 'M60E4',
        equipmentPath = 'Weapons/M60/U_M60',
        kits = {
            'Gameplay/Kits/USSupport',
            'Gameplay/Kits/USSupport_XP4',
            'Gameplay/Kits/RUSupport',
            'Gameplay/Kits/RUSupport_XP4',
        },
        slotId = 'ID_M_SOLDIER_PRIMARY',
        xpRequired = 130000
    },
    {
        lvl = 9,
        prettyName = 'RPK-74M (US)',
        equipmentPath = 'Weapons/RPK/U_RPK-74M',
        kits = {
            'Gameplay/Kits/USSupport',
            'Gameplay/Kits/USSupport_XP4',
        },
        slotId = 'ID_M_SOLDIER_PRIMARY',
        xpRequired = 170000
    },
    {
        lvl = 9,
        prettyName = 'M27 IAR (RU)',
        equipmentPath = 'Weapons/M27IAR/U_M27IAR',
        kits = {
            'Gameplay/Kits/RUSupport',
            'Gameplay/Kits/RUSupport_XP4',
        },
        slotId = 'ID_M_SOLDIER_PRIMARY',
        xpRequired = 170000
    },
    {
        lvl = 10,
        prettyName = 'XBOW',
        equipmentPath = 'Weapons/XP4_Crossbow_Prototype/U_Crossbow_Scoped_Cobra',
        kits = {
            'Gameplay/Kits/USSupport',
            'Gameplay/Kits/USSupport_XP4',
            'Gameplay/Kits/RUSupport',
            'Gameplay/Kits/RUSupport_XP4',
        },
        slotId = 'ID_M_SOLDIER_GADGET2',
        xpRequired = 200000
    },
    {
        lvl = 11,
        prettyName = 'XBOW SCOPED',
        equipmentPath = 'Weapons/XP4_Crossbow_Prototype/U_Crossbow_Scoped_RifleScope',
        kits = {
            'Gameplay/Kits/USSupport',
            'Gameplay/Kits/USSupport_XP4',
            'Gameplay/Kits/RUSupport',
            'Gameplay/Kits/RUSupport_XP4',
        },
        slotId = 'ID_M_SOLDIER_GADGET2',
        xpRequired = 230000
    },
}