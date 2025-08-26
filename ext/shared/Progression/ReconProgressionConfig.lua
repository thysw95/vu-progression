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
        xpRequired = 22000,
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
        xpRequired = 38000,
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
        xpRequired = 58000, -- Co-op score
        unlocks = {
            {
                prettyName = 'M39 EBR',
                equipmentPath = 'Weapons/EBR/U_EBR',
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
        xpRequired = 76000,
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
        xpRequired = 88000,
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
        xpRequired = 110000,
        unlocks = {
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
        xpRequired = 125000,
        unlocks = {
            {
                prettyName = 'M417',
                equipmentPath = 'Weapons/HK417/U_HK417',
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
        xpRequired = 145000,
        unlocks = {
            {
                prettyName = 'JNG-90',
                equipmentPath = 'Weapons/JNG90/U_JNG90',
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
        xpRequired = 160000,
        unlocks = {
            {
                prettyName = 'L96',
                equipmentPath = 'Weapons/L96/U_L96',
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
        xpRequired = 170000,
        unlocks = {
            {
                prettyName = 'M320 Smoke',
                equipmentPath = 'Weapons/Gadgets/M320/U_M320_SMK',
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
        xpRequired = 195000,
        unlocks = {
            {
                prettyName = 'M417 (alternate)',
                equipmentPath = 'Weapons/HK417/U_HK417',
                kits = {
                    'Gameplay/Kits/USRecon',
                    'Gameplay/Kits/USRecon_XP4',
                    'Gameplay/Kits/RURecon',
                    'Gameplay/Kits/RURecon_XP4',
                },
                slotId = 'ID_M_SOLDIER_PRIMARY',
            },
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