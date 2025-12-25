---------------------------------------------------------
-------------- General Progression Config ---------------
---------------------------------------------------------

-- Add/update values in the below table to edit progression for
-- gear, specializations, and camos available to all Classes

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
            {
                prettyName = 'Default Camo', -- Level 1
                equipmentPath = 'UI/Art/Persistence/Camo/U_CAMO_DEFAULT',
                kits = {'All'},
                slotId = 'CAMO',
            },
            {
                prettyName = 'Premium 1 Camo', -- Exclusive Premium bonus
                equipmentPath = 'UI/Art/Persistence/Camo/U_CAMO_XP2_ABU',
                kits = {'All'},
                slotId = 'CAMO',
            },
            {
                prettyName = 'Premium 2 Camo', -- Exclusive Premium bonus
                equipmentPath = 'UI/Art/Persistence/Camo/U_CAMO_XP2_ATACS',
                kits = {'All'},
                slotId = 'CAMO',
            },
            {
                prettyName = 'Premium 3 Camo', -- Exclusive Premium bonus
                equipmentPath = 'UI/Art/Persistence/Camo/U_CAMO_XP2_DsrtTiger',
                kits = {'All'},
                slotId = 'CAMO',
            },
            {
                prettyName = 'Premium 4 Camo', -- Exclusive Premium bonus
                equipmentPath = 'UI/Art/Persistence/Camo/U_CAMO_XP2_NWU',
                kits = {'All'},
                slotId = 'CAMO',
            },
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
            {
                prettyName = 'Woodland Pattern Camo', -- Level 3
                equipmentPath = 'UI/Art/Persistence/Camo/U_CAMO1',
                kits = {'All'},
                slotId = 'CAMO',
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
            {
                prettyName = 'Ranger Camo', -- Level 6
                equipmentPath = 'UI/Art/Persistence/Camo/U_CAMO2',
                kits = {'All'},
                slotId = 'CAMO',
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
            {
                prettyName = 'Army Green Camo', -- Level 8
                equipmentPath = 'UI/Art/Persistence/Camo/U_CAMO3',
                kits = {'All'},
                slotId = 'CAMO',
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
            {
                prettyName = 'Expeditinary Force Camo', -- Level 12
                equipmentPath = 'UI/Art/Persistence/Camo/U_CAMO4',
                kits = {'All'},
                slotId = 'CAMO',
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
            {
                prettyName = 'Paratrooper Camo', -- Level 15
                equipmentPath = 'UI/Art/Persistence/Camo/U_CAMO5',
                kits = {'All'},
                slotId = 'CAMO',
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
            {
                prettyName = 'Navy Blue Camo', -- Level 18
                equipmentPath = 'UI/Art/Persistence/Camo/U_CAMO6',
                kits = {'All'},
                slotId = 'CAMO',
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
            {
                prettyName = 'Jungle Pattern Camo', -- Level 20
                equipmentPath = 'UI/Art/Persistence/Camo/U_CAMO7',
                kits = {'All'},
                slotId = 'CAMO',
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
            {
                prettyName = 'Desert Khaki Camo', -- Level 24
                equipmentPath = 'UI/Art/Persistence/Camo/U_CAMO8',
                kits = {'All'},
                slotId = 'CAMO',
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
            {
                prettyName = 'Urban Pattern Camo', -- Level 27
                equipmentPath = 'UI/Art/Persistence/Camo/U_CAMO9',
                kits = {'All'},
                slotId = 'CAMO',
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
        xpRequired = 1180000,
        unlocks = {
            {
                prettyName = 'M1911',
                equipmentPath = 'Weapons/M1911/U_M1911',
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
        xpRequired = 2000000,
        unlocks = {
            {
                prettyName = 'M1911 Light',
                equipmentPath = 'Weapons/M1911/U_M1911_Lit',
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
        xpRequired = 2400000,
        unlocks = {
            {
                prettyName = 'M1911 Silenced',
                equipmentPath = 'Weapons/M1911/U_M1911_Silenced',
                kits = {'All'},
                slotId = 'ID_M_SOLDIER_SECONDARY',
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
    {
        xpRequired = 2900000,
        unlocks = {
            {
                prettyName = 'M1911 Tactical',
                equipmentPath = 'Weapons/M1911/U_M1911_Tactical',
                kits = {'All'},
                slotId = 'ID_M_SOLDIER_SECONDARY',
            },
            {
                prettyName = 'Veteran Kit Camo', -- Level 39
                equipmentPath = 'UI/Art/Persistence/Camo/U_CAMO10',
                kits = {'All'},
                slotId = 'CAMO',
            },
        }
    },
    {
        xpRequired = 3100000,
        unlocks = {
            {
                prettyName = '93R',
                equipmentPath = 'Weapons/M93R/U_M93R',
                kits = {'All'},
                slotId = 'ID_M_SOLDIER_SECONDARY',
            },
        }
    },
    {
        xpRequired = 3400000,
        unlocks = {
            {
                prettyName = 'MP412 REX',
                equipmentPath = 'Weapons/MP412Rex/U_MP412Rex',
                kits = {'All'},
                slotId = 'ID_M_SOLDIER_SECONDARY',
            },
        }
    },
    {
        xpRequired = 3700000,
        unlocks = {
            {
                prettyName = 'SPAS-12',
                equipmentPath = 'Weapons/ASVal/U_ASVal',
                kits = {'All'},
                slotId = 'ID_M_SOLDIER_PRIMARY',
            },
            {
                prettyName = 'Spec Ops Black Camo', -- Level 42
                equipmentPath = 'UI/Art/Persistence/Camo/U_CAMO11',
                kits = {'All'},
                slotId = 'CAMO',
            },
        }
    },
    {
        xpRequired = 4000000,
        unlocks = {
            {
                prettyName = 'PP-19 Bizon',
                equipmentPath = 'Weapons/XP1_PP-19/U_PP-19',
                kits = {'All'},
                slotId = 'ID_M_SOLDIER_PRIMARY',
            },
        }
    },
    {
        xpRequired = 4300000,
        unlocks = {
            {
                prettyName = 'M5K',
                equipmentPath = 'Weapons/XP2_MP5K/U_MP5K',
                kits = {'All'},
                slotId = 'ID_M_SOLDIER_PRIMARY',
            },
        }
    },
    {
        xpRequired = 4600000,
        unlocks = {
            {
                prettyName = 'MP7',
                equipmentPath = 'Weapons/MP7/U_MP7',
                kits = {'All'},
                slotId = 'ID_M_SOLDIER_PRIMARY',
            },
            {
                prettyName = 'SPECACT Camo', -- Pre-order bonus & Purchasable content
                equipmentPath = 'UI/Art/Persistence/Camo/U_CAMO_SPECACT',
                kits = {'All'},
                slotId = 'CAMO',
            },
        }
    },
    {
        xpRequired = 4900000,
        unlocks = {
            {
                prettyName = 'MK3A1',
                equipmentPath = 'Weapons/XP1_Jackhammer/U_Jackhammer',
                kits = {'All'},
                slotId = 'ID_M_SOLDIER_PRIMARY',
            },
        }
    },
    {
        xpRequired = 5200000,
        unlocks = {
            {
                prettyName = 'XBOW',
                equipmentPath = 'Weapons/XP4_Crossbow_Prototype/U_Crossbow_Scoped_Cobra',
                kits = {'All'},
                slotId = 'ID_M_SOLDIER_GADGET1',
            },
        }
    },
    {
        xpRequired = 5500000,
        unlocks = {
            {
                prettyName = 'XBOW SCOPED',
                equipmentPath = 'Weapons/XP4_Crossbow_Prototype/U_Crossbow_Scoped_RifleScope',
                kits = {'All'},
                slotId = 'ID_M_SOLDIER_GADGET1',
            },
            {
                prettyName = 'Dr. Pepper Camo', -- Dr. Pepper promotion & Purchasable content
                equipmentPath = 'UI/Art/Persistence/Camo/U_CAMO_DrPepper',
                kits = {'All'},
                slotId = 'CAMO',
            },
        }
    },
}

---------- END OF CONFIG | DO NOT EDIT BELOW ----------

local progressionManager = require("__shared/ProgressionManager")
progressionManager:sortKitProgressionTable(generalProgression)

return generalProgression