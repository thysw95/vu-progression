local progressionManager = require("__shared/ProgressionManager")

-- Add/update values in the below table to edit progression
local reconProgression = {
    {
        xpRequired = 0,
        unlocks = {
            {
                prettyName = 'SVD (RU)',
                equipmentPath = 'Weapons/SVD/U_SVD',
                kits = {
                    'Gameplay/Kits/RURecon',
                    'Gameplay/Kits/RURecon_XP4',
                },
                slotId = 'ID_M_SOLDIER_PRIMARY',
            },
            {
                prettyName = 'MK11 MOD 0 (US)',
                equipmentPath = 'Weapons/MK11/U_MK11',
                kits = {
                    'Gameplay/Kits/USRecon',
                    'Gameplay/Kits/USRecon_XP4',
                },
                slotId = 'ID_M_SOLDIER_PRIMARY',
            },
            {
                prettyName = 'No Gadget',
                equipmentPath = 'Weapons/Common/NoGadget1',
                kits = {
                    'Gameplay/Kits/USRecon',
                    'Gameplay/Kits/USRecon_XP4',
                    'Gameplay/Kits/RURecon',
                    'Gameplay/Kits/RURecon_XP4',
                },
                slotId = 'ID_M_SOLDIER_GADGET1',
            },
            {
                prettyName = 'Radio Beacon',
                equipmentPath = 'Weapons/Gadgets/RadioBeacon/U_RadioBeacon',
                kits = {
                    'Gameplay/Kits/USRecon',
                    'Gameplay/Kits/USRecon_XP4',
                    'Gameplay/Kits/RURecon',
                    'Gameplay/Kits/RURecon_XP4',
                },
                slotId = 'ID_M_SOLDIER_GADGET2',
            },
        }
    },
    {
        xpRequired = 5000,
        unlocks = {
            {
                prettyName = 'T-UGS',
                equipmentPath = 'Weapons/Gadgets/T-UGS/U_UGS',
                kits = {
                    'Gameplay/Kits/USRecon',
                    'Gameplay/Kits/USRecon_XP4',
                    'Gameplay/Kits/RURecon',
                    'Gameplay/Kits/RURecon_XP4',
                },
                slotId = 'ID_M_SOLDIER_GADGET1',
            },
        }
    },
    {
        xpRequired = 13000,
        unlocks = {
            {
                prettyName = 'SV98',
                equipmentPath = 'Weapons/SV98/U_SV98',
                kits = {
                    'Gameplay/Kits/USRecon',
                    'Gameplay/Kits/USRecon_XP4',
                    'Gameplay/Kits/RURecon',
                    'Gameplay/Kits/RURecon_XP4',
                },
                slotId = 'ID_M_SOLDIER_PRIMARY',
            },
        }
    },
    {
        xpRequired = 26000,
        unlocks = {
            {
                prettyName = 'SOFLAM',
                equipmentPath = 'Weapons/Gadgets/SOFLAM/U_SOFLAM',
                kits = {
                    'Gameplay/Kits/USRecon',
                    'Gameplay/Kits/USRecon_XP4',
                    'Gameplay/Kits/RURecon',
                    'Gameplay/Kits/RURecon_XP4',
                },
                slotId = 'ID_M_SOLDIER_GADGET1',
            },
        }
    },
    {
        xpRequired = 45000,
        unlocks = {
            {
                prettyName = 'MAV',
                equipmentPath = 'Weapons/Gadgets/MAV/U_MAV',
                kits = {
                    'Gameplay/Kits/USRecon',
                    'Gameplay/Kits/USRecon_XP4',
                    'Gameplay/Kits/RURecon',
                    'Gameplay/Kits/RURecon_XP4',
                },
                slotId = 'ID_M_SOLDIER_GADGET2',
            },
        }
    },
    {
        xpRequired = 71000,
        unlocks = {
            {
                prettyName = 'SKS',
                equipmentPath = 'Weapons/SKS/U_SKS',
                kits = {
                    'Gameplay/Kits/USRecon',
                    'Gameplay/Kits/USRecon_XP4',
                    'Gameplay/Kits/RURecon',
                    'Gameplay/Kits/RURecon_XP4',
                },
                slotId = 'ID_M_SOLDIER_PRIMARY',
            },
        }
    },
    {
        xpRequired = 104000,
        unlocks = {
            {
                prettyName = 'M40A5',
                equipmentPath = 'Weapons/M40A5/U_M40A5',
                kits = {
                    'Gameplay/Kits/USRecon',
                    'Gameplay/Kits/USRecon_XP4',
                    'Gameplay/Kits/RURecon',
                    'Gameplay/Kits/RURecon_XP4',
                },
                slotId = 'ID_M_SOLDIER_PRIMARY',
            },
        }
    },
    {
        xpRequired = 146000,
        unlocks = {
            {
                prettyName = 'M98B',
                equipmentPath = 'Weapons/M98B/U_M98B',
                kits = {
                    'Gameplay/Kits/USRecon',
                    'Gameplay/Kits/USRecon_XP4',
                    'Gameplay/Kits/RURecon',
                    'Gameplay/Kits/RURecon_XP4',
                },
                slotId = 'ID_M_SOLDIER_PRIMARY',
            },
        }
    },
    {
        xpRequired = 195000,
        unlocks = {
            {
                prettyName = 'SVD (US)',
                equipmentPath = 'Weapons/SVD/U_SVD',
                kits = {
                    'Gameplay/Kits/USRecon',
                    'Gameplay/Kits/USRecon_XP4',
                },
                slotId = 'ID_M_SOLDIER_PRIMARY',
            },
            {
                prettyName = 'MK11 MOD 0 (RU)',
                equipmentPath = 'Weapons/MK11/U_MK11',
                kits = {
                    'Gameplay/Kits/RURecon',
                    'Gameplay/Kits/RURecon_XP4',
                },
                slotId = 'ID_M_SOLDIER_PRIMARY',
            },
        }
    },
    {
        xpRequired = 220000,
        unlocks = {
            {
                prettyName = 'Crossbow',
                equipmentPath = 'Weapons/XBow/U_Crossbow',
                kits = {
                    'Gameplay/Kits/USRecon',
                    'Gameplay/Kits/USRecon_XP4',
                    'Gameplay/Kits/RURecon',
                    'Gameplay/Kits/RURecon_XP4',
                },
                slotId = 'ID_M_SOLDIER_PRIMARY',
            },
        }
    },
}

print("Sorting Recon Progress...")

reconProgression = progressionManager:sortKitProgressionTable(reconProgression)

return reconProgression