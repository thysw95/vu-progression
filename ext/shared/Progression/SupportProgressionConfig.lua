---------------------------------------------------------
-------------- Support Progression Config ---------------
---------------------------------------------------------

-- Add/update values in the below table to edit progression for the Support Class

local supportProgression = {
    {
        xpRequired = 0,
        unlocks = {
            {
        
                prettyName = 'RPK-74M (RU)',
                equipmentPath = 'Weapons/RPK/U_RPK-74M',
                kits = {
                    'Gameplay/Kits/RUSupport',
                    'Gameplay/Kits/RUSupport_XP4',
                },
                slotId = 'ID_M_SOLDIER_PRIMARY',
            },
            {
                
                prettyName = 'M27 IAR (US)',
                equipmentPath = 'Weapons/M27IAR/U_M27IAR',
                kits = {
                    'Gameplay/Kits/USSupport',
                    'Gameplay/Kits/USSupport_XP4',
                },
                slotId = 'ID_M_SOLDIER_PRIMARY',
            },
            {
                
                prettyName = 'No Gadget',
                equipmentPath = 'Weapons/Common/NoGadget2',
                kits = {
                    'Gameplay/Kits/USSupport',
                    'Gameplay/Kits/USSupport_XP4',
                    'Gameplay/Kits/RUSupport',
                    'Gameplay/Kits/RUSupport_XP4',
                },
                slotId = 'ID_M_SOLDIER_GADGET2',
            },
            -- This is a strange one. For some reason, the Ammo Bag is in a CustomizationUnlockParts table with an
            -- inconsistent UICategorySid from kit to kit. Sometimes it it `nil`; sometimes it is `GADGET1`.
            -- Disabled here to prevent a duplicate Ammo Bag from being added.
            -- {
            --     
            --     prettyName = 'Ammo Box',
            --     equipmentPath = 'Weapons/Gadgets/Ammobag/U_Ammobag',
            --     kits = {
            --         'Gameplay/Kits/USSupport',
            --         'Gameplay/Kits/USSupport_XP4',
            --         'Gameplay/Kits/RUSupport',
            --         'Gameplay/Kits/RUSupport_XP4',
            --     },
            --     slotId = 'ID_M_SOLDIER_GADGET1',
            -- },
        }
    },
    {
        xpRequired = 4000,
        unlocks = {
            {
                prettyName = 'C4 Explosives',
                equipmentPath = 'Weapons/Gadgets/C4/U_C4',
                kits = {
                    'Gameplay/Kits/USSupport',
                    'Gameplay/Kits/USSupport_XP4',
                    'Gameplay/Kits/RUSupport',
                    'Gameplay/Kits/RUSupport_XP4',
                },
                slotId = 'ID_M_SOLDIER_GADGET2',
            },
        }
    },
    {
        xpRequired = 11000,
        unlocks = {
            {
                prettyName = 'M249',
                equipmentPath = 'Weapons/M249/U_M249',
                kits = {
                    'Gameplay/Kits/USSupport',
                    'Gameplay/Kits/USSupport_XP4',
                    'Gameplay/Kits/RUSupport',
                    'Gameplay/Kits/RUSupport_XP4',
                },
                slotId = 'ID_M_SOLDIER_PRIMARY',
            },
        }
    },
    {
        xpRequired = 23000,
        unlocks = {
            {
                prettyName = 'M18 Claymore',
                equipmentPath = 'Weapons/Gadgets/Claymore/U_Claymore',
                kits = {
                    'Gameplay/Kits/USSupport',
                    'Gameplay/Kits/USSupport_XP4',
                    'Gameplay/Kits/RUSupport',
                    'Gameplay/Kits/RUSupport_XP4',
                },
                slotId = 'ID_M_SOLDIER_GADGET2',
            },
        }
    },
    {
        xpRequired = 40000,
        unlocks = {
            {
                prettyName = 'M224 Mortar',
                equipmentPath = 'Weapons/Gadgets/M224/U_M224',
                kits = {
                    'Gameplay/Kits/USSupport',
                    'Gameplay/Kits/USSupport_XP4',
                    'Gameplay/Kits/RUSupport',
                    'Gameplay/Kits/RUSupport_XP4',
                },
                slotId = 'ID_M_SOLDIER_GADGET2',
            },
        }
    },
    {
        xpRequired = 60000,
        unlocks = {
            {
                prettyName = 'PKP PECHENEG',
                equipmentPath = 'Weapons/Pecheneg/U_Pecheneg',
                kits = {
                    'Gameplay/Kits/USSupport',
                    'Gameplay/Kits/USSupport_XP4',
                    'Gameplay/Kits/RUSupport',
                    'Gameplay/Kits/RUSupport_XP4',
                },
                slotId = 'ID_M_SOLDIER_PRIMARY',
            },
        }
    },
    {
        xpRequired = 90000,
        unlocks = {
            {
                prettyName = 'M240B',
                equipmentPath = 'Weapons/M240/U_M240',
                kits = {
                    'Gameplay/Kits/USSupport',
                    'Gameplay/Kits/USSupport_XP4',
                    'Gameplay/Kits/RUSupport',
                    'Gameplay/Kits/RUSupport_XP4',
                },
                slotId = 'ID_M_SOLDIER_PRIMARY',
            },
        }
    },
    {
        xpRequired = 130000,
        unlocks = {
            {
                prettyName = 'M60E4',
                equipmentPath = 'Weapons/M60/U_M60',
                kits = {
                    'Gameplay/Kits/USSupport',
                    'Gameplay/Kits/USSupport_XP4',
                    'Gameplay/Kits/RUSupport',
                    'Gameplay/Kits/RUSupport_XP4',
                },
                slotId = 'ID_M_SOLDIER_PRIMARY',
            },
        }
    },
    {
        xpRequired = 170000,
        unlocks = {
            {
                prettyName = 'RPK-74M (US)',
                equipmentPath = 'Weapons/RPK/U_RPK-74M',
                kits = {
                    'Gameplay/Kits/USSupport',
                    'Gameplay/Kits/USSupport_XP4',
                },
                slotId = 'ID_M_SOLDIER_PRIMARY',
            },
            {
                prettyName = 'M27 IAR (RU)',
                equipmentPath = 'Weapons/M27IAR/U_M27IAR',
                kits = {
                    'Gameplay/Kits/RUSupport',
                    'Gameplay/Kits/RUSupport_XP4',
                },
                slotId = 'ID_M_SOLDIER_PRIMARY',
            },
        }
    },
    {
        xpRequired = 200000,
        unlocks = {
            {
                prettyName = 'MG36',
                equipmentPath = 'Weapons/XP1_MG36/U_MG36',
                kits = {
                    'Gameplay/Kits/USSupport',
                    'Gameplay/Kits/USSupport_XP4',
                    'Gameplay/Kits/RUSupport',
                    'Gameplay/Kits/RUSupport_XP4',
                },
                slotId = 'ID_M_SOLDIER_PRIMARY',
            },
        }
    },
    {
        xpRequired = 230000,
        unlocks = {
            {
                prettyName = 'QBB-95',
                equipmentPath = 'Weapons/XP1_QBB-95/U_QBB-95',
                kits = {
                    'Gameplay/Kits/USSupport',
                    'Gameplay/Kits/USSupport_XP4',
                    'Gameplay/Kits/RUSupport',
                    'Gameplay/Kits/RUSupport_XP4',
                },
                slotId = 'ID_M_SOLDIER_PRIMARY',
            },
        }
    },
    {
        xpRequired = 260000,
        unlocks = {
            {
                prettyName = 'L86A2',
                equipmentPath = ' Weapons/XP2_L86/U_L86',
                kits = {
                    'Gameplay/Kits/USSupport',
                    'Gameplay/Kits/USSupport_XP4',
                    'Gameplay/Kits/RUSupport',
                    'Gameplay/Kits/RUSupport_XP4',
                },
                slotId = 'ID_M_SOLDIER_PRIMARY',
            },
        }
    },
    {
        xpRequired = 290000,
        unlocks = {
            {
                prettyName = 'LSAT',
                equipmentPath = 'Weapons/XP2_LSAT/U_LSAT',
                kits = {
                    'Gameplay/Kits/USSupport',
                    'Gameplay/Kits/USSupport_XP4',
                    'Gameplay/Kits/RUSupport',
                    'Gameplay/Kits/RUSupport_XP4',
                },
                slotId = 'ID_M_SOLDIER_PRIMARY',
            },
        }
    },
}

---------- END OF CONFIG | DO NOT EDIT BELOW ----------

local progressionManager = require("__shared/ProgressionManager")
progressionManager:sortKitProgressionTable(supportProgression)

return supportProgression