local progressionManager = require("__shared/ProgressionManager")

-- Add/update values in the below table to edit progression
local generalProgression = {
    {
        xpRequired = 0,
        unlocks = {
            {
        
                prettyName = 'M9',
                equipmentPath = 'Weapons/M9/U_M9',
                kits = {'All'},
                slotId = 'ID_M_SOLDIER_SECONDARY',
            },
            {
                
                prettyName = 'MP443',
                equipmentPath = 'Weapons/MP443/U_MP443',
                kits = {'All'},
                slotId = 'ID_M_SOLDIER_SECONDARY',
            },
            {
                
                prettyName = 'NONE Specialization',
                equipmentPath = 'Weapons/Common/NoSpecialization',
                kits = {'All'},
                slotId = 'ID_M_SOLDIER_SPECIALIZATION',
            },
            -- {
            --     
            --     prettyName = 'Default Camo',
            --     equipmentPath = 'UI/Art/Persistence/Camo/U_CAMO_DEFAULT',
            --     kits = {'All'},
            --     slotId = 'CAMO',
            -- },
        }
    },
    {
        xpRequired = 1000,
        unlocks = {
            {
                prettyName = '870MCS',
                equipmentPath = 'Weapons/Remington870/U_870',
                kits = {'All'},
                slotId = 'ID_M_SOLDIER_PRIMARY',
            },
        }
    },
    {
        xpRequired = 2100,
        unlocks = {
            {
                prettyName = 'SQD SPRNT',
                equipmentPath = 'Persistence/Unlocks/Soldiers/Specializations/SprintBoostL2',
                kits = {'All'},
                slotId = 'ID_M_SOLDIER_SPECIALIZATION',
            },
        }
    },
    {
        xpRequired = 3200,
        unlocks = {
            {
                prettyName = 'G17C',
                equipmentPath = 'Weapons/Glock17/U_Glock17',
                kits = {'All'},
                slotId = 'ID_M_SOLDIER_SECONDARY',
            },
        }
    },
    {
        xpRequired = 4400,
        unlocks = {
            {
                prettyName = 'SQD AMMO',
                equipmentPath = 'Persistence/Unlocks/Soldiers/Specializations/AmmoBoostL2',
                kits = {'All'},
                slotId = 'ID_M_SOLDIER_SPECIALIZATION',
            },
        }
    },
    {
        xpRequired = 5600,
        unlocks = {
            {
                prettyName = 'PP-2000',
                equipmentPath = 'Weapons/PP2000/U_PP2000',
                kits = {'All'},
                slotId = 'ID_M_SOLDIER_PRIMARY',
            },
        }
    },
    {
        xpRequired = 8000,
        unlocks = {
            {
                prettyName = 'SQD FLAK',
                equipmentPath = 'Persistence/Unlocks/Soldiers/Specializations/ExplosiveResistL2',
                kits = {'All'},
                slotId = 'ID_M_SOLDIER_SPECIALIZATION',
            },
        }
    },
    {
        xpRequired = 11000,
        unlocks = {
            {
                prettyName = 'M9 TACT.',
                equipmentPath = 'Weapons/M9/U_M9_TacticalLight',
                kits = {'All'},
                slotId = 'ID_M_SOLDIER_SECONDARY',
            },
        }
    },
    {
        xpRequired = 16000,
        unlocks = {
            {
                prettyName = 'SQD EXPL',
                equipmentPath = 'Persistence/Unlocks/Soldiers/Specializations/ExplosiveBoostL2',
                kits = {'All'},
                slotId = 'ID_M_SOLDIER_SPECIALIZATION',
            },
        }
    },
    {
        xpRequired = 32000,
        unlocks = {
            {
                prettyName = 'MP443 TACT.',
                equipmentPath = 'Weapons/MP443/U_MP443_TacticalLight',
                kits = {'All'},
                slotId = 'ID_M_SOLDIER_SECONDARY',
            },
        }
    },
    {
        xpRequired = 43000,
        unlocks = {
            {
                prettyName = 'SQD COVR',
                equipmentPath = 'Persistence/Unlocks/Soldiers/Specializations/SuppressionResistL2',
                kits = {'All'},
                slotId = 'ID_M_SOLDIER_SPECIALIZATION',
            },
        }
    },
    {
        xpRequired = 56000,
        unlocks = {
            {
                prettyName = 'UMP-45',
                equipmentPath = 'Weapons/UMP45/U_UMP45',
                kits = {'All'},
                slotId = 'ID_M_SOLDIER_PRIMARY',
            },
        }
    },
    {
        xpRequired = 71000,
        unlocks = {
            {
                prettyName = 'SQD SUPR',
                equipmentPath = 'Persistence/Unlocks/Soldiers/Specializations/SuppressionBoostL2',
                kits = {'All'},
                slotId = 'ID_M_SOLDIER_SPECIALIZATION',
            },
        }
    },
    {
        xpRequired = 88000,
        unlocks = {
            {
                prettyName = 'G17C SUPP.',
                equipmentPath = 'Weapons/Glock17/U_Glock17_Silenced',
                kits = {'All'},
                slotId = 'ID_M_SOLDIER_SECONDARY',
            },
        }
    },
    {
        xpRequired = 107000,
        unlocks = {
            {
                prettyName = 'SQD FRAG',
                equipmentPath = 'Persistence/Unlocks/Soldiers/Specializations/GrenadeBoostL2',
                kits = {'All'},
                slotId = 'ID_M_SOLDIER_SPECIALIZATION',
            },
        }
    },
    {
        xpRequired = 128000,
        unlocks = {
            {
                prettyName = 'M1014',
                equipmentPath = 'Weapons/M1014/U_M1014',
                kits = {'All'},
                slotId = 'ID_M_SOLDIER_PRIMARY',
            },
        }
    },
    {
        xpRequired = 152000,
        unlocks = {
            {
                prettyName = 'SQD SPRNT',
                equipmentPath = 'Persistence/Unlocks/Soldiers/Specializations/SprintBoostL2',
                kits = {'All'},
                slotId = 'ID_M_SOLDIER_SPECIALIZATION',
            },
        }
    },
    {
        xpRequired = 180000,
        unlocks = {
            {
                prettyName = 'M9 SUPP.',
                equipmentPath = 'Weapons/M9/U_M9_Silenced',
                kits = {'All'},
                slotId = 'ID_M_SOLDIER_SECONDARY',
            },
        }
    },
    {
        xpRequired = 213000,
        unlocks = {
            {
                prettyName = 'SQD AMMO',
                equipmentPath = 'Persistence/Unlocks/Soldiers/Specializations/AmmoBoostL2',
                kits = {'All'},
                slotId = 'ID_M_SOLDIER_SPECIALIZATION',
            },
        }
    },
    {
        xpRequired = 253000,
        unlocks = {
            {
                prettyName = 'MP443 SUPP.',
                equipmentPath = 'Weapons/MP443/U_MP443_Silenced',
                kits = {'All'},
                slotId = 'ID_M_SOLDIER_SECONDARY',
            },
        }
    },
    {
        xpRequired = 303000,
        unlocks = {
            {
                prettyName = 'SQD FLAK',
                equipmentPath = 'Persistence/Unlocks/Soldiers/Specializations/ExplosiveResistL2',
                kits = {'All'},
                slotId = 'ID_M_SOLDIER_SPECIALIZATION',
            },
        }
    },
    {
        xpRequired = 365000,
        unlocks = {
            {
                prettyName = 'G18',
                equipmentPath = 'Weapons/Glock18/U_Glock18',
                kits = {'All'},
                slotId = 'ID_M_SOLDIER_SECONDARY',
            },
        }
    },
    {
        xpRequired = 440000,
        unlocks = {
            {
                prettyName = 'SQD EXPL',
                equipmentPath = 'Persistence/Unlocks/Soldiers/Specializations/ExplosiveBoostL2',
                kits = {'All'},
                slotId = 'ID_M_SOLDIER_SPECIALIZATION',
            },
        }
    },
    {
        xpRequired = 530000,
        unlocks = {
            {
                prettyName = 'PDW-R',
                equipmentPath = 'Weapons/MagpulPDR/U_MagpulPDR',
                kits = {'All'},
                slotId = 'ID_M_SOLDIER_PRIMARY',
            },
        }
    },
    {
        xpRequired = 640000,
        unlocks = {
            {
                prettyName = 'SQD SUPR',
                equipmentPath = 'Persistence/Unlocks/Soldiers/Specializations/SuppressionBoostL2',
                kits = {'All'},
                slotId = 'ID_M_SOLDIER_SPECIALIZATION',
            },
        }
    },
    {
        xpRequired = 770000,
        unlocks = {
            {
                prettyName = 'SAIGA 12K',
                equipmentPath = 'Weapons/SAIGA20K/U_SAIGA_20K',
                kits = {'All'},
                slotId = 'ID_M_SOLDIER_PRIMARY',
            },
        }
    },
    {
        xpRequired = 920000,
        unlocks = {
            {
                prettyName = 'SQD COVR',
                equipmentPath = 'Persistence/Unlocks/Soldiers/Specializations/SuppressionResistL2',
                kits = {'All'},
                slotId = 'ID_M_SOLDIER_SPECIALIZATION',
            },
        }
    },
    {
        xpRequired = 1090000,
        unlocks = {
            {
                prettyName = '.44 MAGNUM',
                equipmentPath = 'Weapons/Taurus44/U_Taurus44',
                kits = {'All'},
                slotId = 'ID_M_SOLDIER_SECONDARY',
            },
        }
    },
    {
        xpRequired = 1280000,
        unlocks = {
            {
                prettyName = 'SQD FRAG',
                equipmentPath = 'Persistence/Unlocks/Soldiers/Specializations/GrenadeBoostL2',
                kits = {'All'},
                slotId = 'ID_M_SOLDIER_SPECIALIZATION',
            },
        }
    },
    {
        xpRequired = 1490000,
        unlocks = {
            {
                prettyName = 'DAO-12',
                equipmentPath = 'Weapons/DAO-12/U_DAO-12',
                kits = {'All'},
                slotId = 'ID_M_SOLDIER_PRIMARY',
            },
        }
    },
    {
        xpRequired = 1720000,
        unlocks = {
            {
                prettyName = 'P90',
                equipmentPath = 'Weapons/P90/U_P90',
                kits = {'All'},
                slotId = 'ID_M_SOLDIER_PRIMARY',
            },
        }
    },
    {
        xpRequired = 1970000,
        unlocks = {
            {
                prettyName = 'G18 SUPP.',
                equipmentPath = 'Weapons/Glock18/U_Glock18_Silenced',
                kits = {'All'},
                slotId = 'ID_M_SOLDIER_SECONDARY',
            },
        }
    },
    {
        xpRequired = 2240000,
        unlocks = {
            {
                prettyName = 'USAS-12',
                equipmentPath = 'Weapons/USAS-12/U_USAS-12',
                kits = {'All'},
                slotId = 'ID_M_SOLDIER_PRIMARY',
            },
        }
    },
    {
        xpRequired = 2540000,
        unlocks = {
            {
                prettyName = '.44 SCOPED',
                equipmentPath = 'Weapons/Taurus44/U_Taurus44_Scoped',
                kits = {'All'},
                slotId = 'ID_M_SOLDIER_SECONDARY',
            },
        }
    },
    {
        xpRequired = 2800000,
        unlocks = {
            {
                prettyName = 'AS VAL',
                equipmentPath = 'Weapons/ASVal/U_ASVal',
                kits = {'All'},
                slotId = 'ID_M_SOLDIER_PRIMARY',
            },
        }
    },
}

print("Sorting General Progress...")

generalProgression = progressionManager:sortKitProgressionTable(generalProgression)

return generalProgression