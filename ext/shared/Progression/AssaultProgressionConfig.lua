local progressionManager = require("__shared/ProgressionManager")

-- Add/update values in the below table to edit progression
local assaultProgression = {
    {
        xpRequired = 0,
        unlocks = {
            {
                prettyName = 'AK-74M (RU)',
                equipmentPath = 'Weapons/AK74M/U_AK74M',
                kits = {
                    'Gameplay/Kits/RUAssault',
                    'Gameplay/Kits/RUAssault_XP4',
                },
                slotId = 'ID_M_SOLDIER_PRIMARY',
            },
            { 
                prettyName = 'M16A3 (US)',
                equipmentPath = 'Weapons/M16A4/U_M16A4',
                kits = {
                    'Gameplay/Kits/USAssault',
                    'Gameplay/Kits/USAssault_XP4',
                },
                slotId = 'ID_M_SOLDIER_PRIMARY',
            },
            -- This is a strange one. For some reason, the Medic Kit is in a CustomizationUnlockParts table with an
            -- inconsistent UICategorySid from kit to kit. Sometimes it it `GADGET1`; sometimes it is `ID_WEAPON_CATEGORYGADGET1`.
            -- Disabled here to prevent a duplicate Medic Kit from being added.
            -- {
            --     
            --     prettyName = 'Medic Kit',
            --     equipmentPath = 'Weapons/Gadgets/Medicbag/U_Medkit',
            --     kits = {
            --         'Gameplay/Kits/USAssault',
            --         'Gameplay/Kits/USAssault_XP4',
            --         'Gameplay/Kits/RUAssault',
            --         'Gameplay/Kits/RUAssault_XP4',
            --     },
            --     slotId = 'ID_M_SOLDIER_GADGET1',
            -- },
            {
                prettyName = 'No Gadget',
                equipmentPath = 'Weapons/Common/NoGadget2',
                kits = {
                    'Gameplay/Kits/USAssault',
                    'Gameplay/Kits/USAssault_XP4',
                    'Gameplay/Kits/RUAssault',
                    'Gameplay/Kits/RUAssault_XP4',
                },
                slotId = 'ID_M_SOLDIER_GADGET2',
            }
        }
    },
    {
        xpRequired = 4000,
        unlocks = {
            {
                prettyName = 'Defibrillator',
                equipmentPath = 'Weapons/Gadgets/Defibrillator/U_Defib',
                kits = {
                    'Gameplay/Kits/USAssault',
                    'Gameplay/Kits/USAssault_XP4',
                    'Gameplay/Kits/RUAssault',
                    'Gameplay/Kits/RUAssault_XP4',
                },
                slotId = 'ID_M_SOLDIER_GADGET2',
            },
        }
    },
    {
        xpRequired = 11000,
        unlocks = {
            {
                prettyName = 'M320',
                equipmentPath = 'Weapons/Gadgets/M320/U_M320_HE',
                kits = {
                    'Gameplay/Kits/USAssault',
                    'Gameplay/Kits/USAssault_XP4',
                    'Gameplay/Kits/RUAssault',
                    'Gameplay/Kits/RUAssault_XP4',
                },
                slotId = 'ID_M_SOLDIER_GADGET1',
            },
            {
                prettyName = 'M320 BUCK',
                equipmentPath = 'Weapons/Gadgets/M320/U_M320_SHG',
                kits = {
                    'Gameplay/Kits/USAssault',
                    'Gameplay/Kits/USAssault_XP4',
                    'Gameplay/Kits/RUAssault',
                    'Gameplay/Kits/RUAssault_XP4',
                },
                slotId = 'ID_M_SOLDIER_GADGET1',
            },
            {
                prettyName = 'M320 SMOKE',
                equipmentPath = 'Weapons/Gadgets/M320/U_M320_SMK',
                kits = {
                    'Gameplay/Kits/USAssault',
                    'Gameplay/Kits/USAssault_XP4',
                    'Gameplay/Kits/RUAssault',
                    'Gameplay/Kits/RUAssault_XP4',
                },
                slotId = 'ID_M_SOLDIER_GADGET1',
            },
            {
                prettyName = 'M320 LVG',
                equipmentPath = 'Weapons/Gadgets/M320/U_M320_LVG',
                kits = {
                    'Gameplay/Kits/USAssault',
                    'Gameplay/Kits/USAssault_XP4',
                    'Gameplay/Kits/RUAssault',
                    'Gameplay/Kits/RUAssault_XP4',
                },
                slotId = 'ID_M_SOLDIER_GADGET1',
            },
        }
    },
    {
        xpRequired = 22000,
        unlocks = {
            {
                prettyName = 'M416',
                equipmentPath = 'Weapons/M416/U_M416',
                kits = {
                    'Gameplay/Kits/USAssault',
                    'Gameplay/Kits/USAssault_XP4',
                    'Gameplay/Kits/RUAssault',
                    'Gameplay/Kits/RUAssault_XP4',
                },
                slotId = 'ID_M_SOLDIER_PRIMARY',
            },
        }
    },
    {
        xpRequired = 38000,
        unlocks = {
            {
                prettyName = 'M26 MASS',
                equipmentPath = 'Weapons/Gadgets/M26Mass/U_M26Mass',
                kits = {
                    'Gameplay/Kits/USAssault',
                    'Gameplay/Kits/USAssault_XP4',
                    'Gameplay/Kits/RUAssault',
                    'Gameplay/Kits/RUAssault_XP4',
                },
                slotId = 'ID_M_SOLDIER_GADGET1',
            },
            {
                prettyName = 'M26 DART',
                equipmentPath = 'Weapons/Gadgets/M26Mass/U_M26Mass_Flechette',
                kits = {
                    'Gameplay/Kits/USAssault',
                    'Gameplay/Kits/USAssault_XP4',
                    'Gameplay/Kits/RUAssault',
                    'Gameplay/Kits/RUAssault_XP4',
                },
                slotId = 'ID_M_SOLDIER_GADGET1',
            },
            {
                prettyName = 'M26 FRAG',
                equipmentPath = 'Weapons/Gadgets/M26Mass/U_M26Mass_Frag',
                kits = {
                    'Gameplay/Kits/USAssault',
                    'Gameplay/Kits/USAssault_XP4',
                    'Gameplay/Kits/RUAssault',
                    'Gameplay/Kits/RUAssault_XP4',
                },
                slotId = 'ID_M_SOLDIER_GADGET1',
            },
            {
                prettyName = 'M26 SLUG',
                equipmentPath = 'Weapons/Gadgets/M26Mass/U_M26Mass_Slug',
                kits = {
                    'Gameplay/Kits/USAssault',
                    'Gameplay/Kits/USAssault_XP4',
                    'Gameplay/Kits/RUAssault',
                    'Gameplay/Kits/RUAssault_XP4',
                },
                slotId = 'ID_M_SOLDIER_GADGET1',
            },
        }
    },
    {
        xpRequired = 60000,
        unlocks = {
            {
                prettyName = 'AEK-971',
                equipmentPath = 'Weapons/AEK971/U_AEK971',
                kits = {
                    'Gameplay/Kits/USAssault',
                    'Gameplay/Kits/USAssault_XP4',
                    'Gameplay/Kits/RUAssault',
                    'Gameplay/Kits/RUAssault_XP4',
                },
                slotId = 'ID_M_SOLDIER_PRIMARY',
            },
        }
    },
    {
        xpRequired = 89000,
        unlocks = {
            {
                prettyName = 'M16A4',
                equipmentPath = 'Weapons/M16A4/U_M16_Burst',
                kits = {
                    'Gameplay/Kits/USAssault',
                    'Gameplay/Kits/USAssault_XP4',
                    'Gameplay/Kits/RUAssault',
                    'Gameplay/Kits/RUAssault_XP4',
                },
                slotId = 'ID_M_SOLDIER_PRIMARY',
            },
        }
    },
    {
        xpRequired = 124000,
        unlocks = {
            {
                prettyName = 'F2000',
                equipmentPath = 'Weapons/F2000/U_F2000',
                kits = {
                    'Gameplay/Kits/USAssault',
                    'Gameplay/Kits/USAssault_XP4',
                    'Gameplay/Kits/RUAssault',
                    'Gameplay/Kits/RUAssault_XP4',
                },
                slotId = 'ID_M_SOLDIER_PRIMARY',
            },
        }
    },
    {
        xpRequired = 166000,
        unlocks = {
            {
                prettyName = 'AN-94',
                equipmentPath = 'Weapons/AN94/U_AN94',
                kits = {
                    'Gameplay/Kits/USAssault',
                    'Gameplay/Kits/USAssault_XP4',
                    'Gameplay/Kits/RUAssault',
                    'Gameplay/Kits/RUAssault_XP4',
                },
                slotId = 'ID_M_SOLDIER_PRIMARY',
            },
        }
    },
    {
        xpRequired = 220000,
        unlocks = {
            {
                prettyName = 'AK-74M (US)',
                equipmentPath = 'Weapons/AK74M/U_AK74M',
                kits = {
                    'Gameplay/Kits/USAssault',
                    'Gameplay/Kits/USAssault_XP4',
                },
                slotId = 'ID_M_SOLDIER_PRIMARY',
            },
            {
                prettyName = 'M16A3 (RU)',
                equipmentPath = 'Weapons/M16A4/U_M16A4',
                kits = {
                    'Gameplay/Kits/RUAssault',
                    'Gameplay/Kits/RUAssault_XP4',
                },
                slotId = 'ID_M_SOLDIER_PRIMARY',
            },
        }
    },
    {
        xpRequired = 250000,
        unlocks = {
            {
                prettyName = 'KH2002',
                equipmentPath = 'Weapons/KH2002/U_KH2002',
                kits = {
                    'Gameplay/Kits/USAssault',
                    'Gameplay/Kits/USAssault_XP4',
                    'Gameplay/Kits/RUAssault',
                    'Gameplay/Kits/RUAssault_XP4',
                },
                slotId = 'ID_M_SOLDIER_PRIMARY',
            },
        }
    },
    {
        xpRequired = 280000,
        unlocks = {
            {
                prettyName = 'G3A3',
                equipmentPath = 'Weapons/G3A3/U_G3A3/',
                kits = {
                    'Gameplay/Kits/USAssault',
                    'Gameplay/Kits/USAssault_XP4',
                    'Gameplay/Kits/RUAssault',
                    'Gameplay/Kits/RUAssault_XP4',
                },
                slotId = 'ID_M_SOLDIER_PRIMARY',
            },
        }
    },
    {
        xpRequired = 310000,
        unlocks = {
            {
                prettyName = 'FAMAS',
                equipmentPath = 'Weapons/XP1_FAMAS/U_FAMAS',
                kits = {
                    'Gameplay/Kits/USAssault',
                    'Gameplay/Kits/USAssault_XP4',
                    'Gameplay/Kits/RUAssault',
                    'Gameplay/Kits/RUAssault_XP4',
                },
                slotId = 'ID_M_SOLDIER_PRIMARY',
            },
        }
    },
    {
        xpRequired = 340000,
        unlocks = {
            {
                prettyName = 'L85A2',
                equipmentPath = 'Weapons/XP1_L85A2/U_L85A2',
                kits = {
                    'Gameplay/Kits/USAssault',
                    'Gameplay/Kits/USAssault_XP4',
                    'Gameplay/Kits/RUAssault',
                    'Gameplay/Kits/RUAssault_XP4',
                },
                slotId = 'ID_M_SOLDIER_PRIMARY',
            },
        }
    },
    {
        xpRequired = 370000,
        unlocks = {
            {
                prettyName = 'AUG A3',
                equipmentPath = 'Weapons/XP2_SteyrAug/U_SteyrAug',
                kits = {
                    'Gameplay/Kits/USAssault',
                    'Gameplay/Kits/USAssault_XP4',
                    'Gameplay/Kits/RUAssault',
                    'Gameplay/Kits/RUAssault_XP4',
                },
                slotId = 'ID_M_SOLDIER_PRIMARY',
            },
        }
    },
    {
        xpRequired = 400000,
        unlocks = {
            {
                prettyName = 'SCAR L',
                equipmentPath = 'Weapons/XP2_SCAR-L/U_SCAR-L',
                kits = {
                    'Gameplay/Kits/USAssault',
                    'Gameplay/Kits/USAssault_XP4',
                    'Gameplay/Kits/RUAssault',
                    'Gameplay/Kits/RUAssault_XP4',
                },
                slotId = 'ID_M_SOLDIER_PRIMARY',
            },
        }
    }
}

print("Sorting Assault Progress...")

assaultProgression = progressionManager:sortKitProgressionTable(assaultProgression)

return assaultProgression