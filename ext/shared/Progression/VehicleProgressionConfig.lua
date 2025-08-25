-- Unlocks must be in increasing score order
-- `vehicleNames` must be what `VehicleEntityData.controllableType` returns
VIC_PROG_CONFIG = {
    {
        prettyName = 'Mobile AA',
        unlocks = {
            {
                prettyName = 'No Upgrade',
                unlockPath = 'Persistence/Unlocks/Vehicles/NoPassive',
                category = 'ID_VEHICLE_PASSIVE',
                vicScoreRequired = 0
            },
            {
                prettyName = 'No Gadget',
                unlockPath = 'Persistence/Unlocks/Vehicles/NoActive',
                category = 'ID_VEHICLE_ACTIVE',
                vicScoreRequired = 0
            },
            {
                prettyName = 'No Weapon',
                unlockPath = 'Persistence/Unlocks/Vehicles/NoStance',
                category = 'ID_VEHICLE_STANCE',
                vicScoreRequired = 0
            },
            {
                prettyName = 'IR Smoke',
                unlockPath = 'Persistence/Unlocks/Vehicles/AavSmokeLaunchers',
                category = 'ID_VEHICLE_ACTIVE',
                vicScoreRequired = 400
            },
            {
                prettyName = 'Anti-Air Missile',
                unlockPath = 'Persistence/Unlocks/Vehicles/AavMissiles',
                category = 'ID_VEHICLE_STANCE',
                vicScoreRequired = 1200
            },
            {
                prettyName = 'Belt Speed',
                unlockPath = 'Persistence/Unlocks/Vehicles/AavReloadUpgrade',
                category = 'ID_VEHICLE_PASSIVE',
                vicScoreRequired = 2500
            },
            {
                prettyName = 'Zoom Optics',
                unlockPath = 'Persistence/Unlocks/Vehicles/AavZoomOptics',
                category = 'ID_VEHICLE_ACTIVE',
                vicScoreRequired = 4400
            },
            {
                prettyName = 'Proximity Scan',
                unlockPath = 'Persistence/Unlocks/Vehicles/AavProximityScan',
                category = 'ID_VEHICLE_PASSIVE',
                vicScoreRequired = 7000
            },
            {
                prettyName = 'Thermal Optics',
                unlockPath = 'Persistence/Unlocks/Vehicles/AavENVGOptics',
                category = 'ID_VEHICLE_ACTIVE',
                vicScoreRequired = 10000
            },
            {
                prettyName = 'Air Radar',
                unlockPath = 'Persistence/Unlocks/Vehicles/AavAirRadar',
                category = 'ID_VEHICLE_PASSIVE',
                vicScoreRequired = 14000
            },
            {
                prettyName = 'Maintenance',
                unlockPath = 'Persistence/Unlocks/Vehicles/AavRegenUpgrade',
                category = 'ID_VEHICLE_PASSIVE',
                vicScoreRequired = 19000
            },
            {
                prettyName = 'Thermal Camo',
                unlockPath = 'Persistence/Unlocks/Vehicles/AavStealth',
                category = 'ID_VEHICLE_PASSIVE',
                vicScoreRequired = 25000
            },
            {
                prettyName = 'Reactive Armor',
                unlockPath = 'Persistence/Unlocks/Vehicles/AavReactiveArmor',
                category = 'ID_VEHICLE_PASSIVE',
                vicScoreRequired = 32000
            },
        },
        customizationPath = 'Gameplay/Vehicles/AAVCustomization',
        vehicleNames = {
            'Vehicles/LAV25/LAV_AD', -- LAV-AD
            'Vehicles/9K22_Tunguska_M/9K22_Tunguska_M', -- 9K22 TUNGUSKA-M
        }
    },
    {
        prettyName = 'Attack Helicopters',
        unlocks = {
            {
                prettyName = 'No Upgrade',
                unlockPath = 'Persistence/Unlocks/Vehicles/NoPilotPassive',
                category = 'ID_VEHICLE_PILOT_PASSIVE',
                vicScoreRequired = 0
            },
            {
                prettyName = 'No Gadget',
                unlockPath = 'Persistence/Unlocks/Vehicles/NoPilotActive',
                category = 'ID_VEHICLE_PILOT_ACTIVE',
                vicScoreRequired = 0
            },
            {
                prettyName = 'No Weapon',
                unlockPath = 'Persistence/Unlocks/Vehicles/NoPilotStance',
                category = 'ID_VEHICLE_PILOT_STANCE',
                vicScoreRequired = 0
            },
            {
                prettyName = 'No Upgrade',
                unlockPath = 'Persistence/Unlocks/Vehicles/NoGunnerPassive',
                category = 'ID_VEHICLE_GUNNER_PASSIVE',
                vicScoreRequired = 0
            },
            {
                prettyName = 'No Gadget',
                unlockPath = 'Persistence/Unlocks/Vehicles/NoGunnerActive',
                category = 'ID_VEHICLE_GUNNER_ACTIVE',
                vicScoreRequired = 0
            },
            {
                prettyName = 'No Weapon',
                unlockPath = 'Persistence/Unlocks/Vehicles/NoGunnerStance',
                category = 'ID_VEHICLE_GUNNER_STANCE',
                vicScoreRequired = 0
            },
            {
                prettyName = 'IR Flares',
                unlockPath = 'Persistence/Unlocks/Vehicles/AtkHeliFlareLauncher',
                category = 'ID_VEHICLE_PILOT_ACTIVE',
                vicScoreRequired = 300
            },
            {
                prettyName = 'Heat Seekers',
                unlockPath = 'Persistence/Unlocks/Vehicles/AtkHeliHeatseekerMissile',
                category = 'ID_VEHICLE_PILOT_STANCE',
                vicScoreRequired = 800
            },
            {
                prettyName = 'Stealth',
                unlockPath = 'Persistence/Unlocks/Vehicles/AtkHeliStealth',
                category = 'ID_VEHICLE_PILOT_PASSIVE',
                vicScoreRequired = 1600
            },
            {
                prettyName = 'Stealth',
                unlockPath = 'Persistence/Unlocks/Vehicles/AtkHeliStealthGunner',
                category = 'ID_VEHICLE_GUNNER_PASSIVE',
                vicScoreRequired = 1600
            },
            {
                prettyName = 'Autoloader',
                unlockPath = 'Persistence/Unlocks/Vehicles/AtkHeliReloadUpgradePilot',
                category = 'ID_VEHICLE_PILOT_PASSIVE',
                vicScoreRequired = 2800
            },
            {
                prettyName = 'Autoloader',
                unlockPath = 'Persistence/Unlocks/Vehicles/AtkHeliReloadUpgradeGunner',
                category = 'ID_VEHICLE_GUNNER_PASSIVE',
                vicScoreRequired = 2800
            },
            {
                prettyName = 'Zoom Optics',
                unlockPath = 'Persistence/Unlocks/Vehicles/AtkHeliZoomOptics',
                category = 'ID_VEHICLE_GUNNER_ACTIVE',
                vicScoreRequired = 4400
            },
            {
                prettyName = 'Proximity Scan',
                unlockPath = 'Persistence/Unlocks/Vehicles/AtkHeliProximityScan',
                category = 'ID_VEHICLE_PILOT_PASSIVE',
                vicScoreRequired = 6500
            },
            {
                prettyName = 'Proximity Scan',
                unlockPath = 'Persistence/Unlocks/Vehicles/AtkHeliProximityScanGunner',
                category = 'ID_VEHICLE_GUNNER_PASSIVE',
                vicScoreRequired = 6500
            },
            {
                prettyName = 'Air Radar',
                unlockPath = 'Persistence/Unlocks/Vehicles/AtkHeliAirRadar',
                category = 'ID_VEHICLE_PILOT_PASSIVE',
                vicScoreRequired = 9000
            },
            {
                prettyName = 'Guided Missile',
                unlockPath = 'Persistence/Unlocks/Vehicles/AtkHeliHellfireMissile',
                category = 'ID_VEHICLE_GUNNER_STANCE',
                vicScoreRequired = 12000
            },
            {
                prettyName = 'Extinguisher',
                unlockPath = 'Persistence/Unlocks/Vehicles/AtkHeliExtinguisher',
                category = 'ID_VEHICLE_PILOT_ACTIVE',
                vicScoreRequired = 16000
            },
            {
                prettyName = 'Maintenance',
                unlockPath = 'Persistence/Unlocks/Vehicles/AtkHeliRegenUpgrade',
                category = 'ID_VEHICLE_PILOT_PASSIVE',
                vicScoreRequired = 20000
            },
            {
                prettyName = 'Maintenance',
                unlockPath = 'Persistence/Unlocks/Vehicles/AtkHeliRegenUpgradeGunner',
                category = 'ID_VEHICLE_GUNNER_PASSIVE',
                vicScoreRequired = 20000
            },
            {
                prettyName = 'Thermal Optics',
                unlockPath = 'Persistence/Unlocks/Vehicles/AtkHeliENVGOptics',
                category = 'ID_VEHICLE_GUNNER_ACTIVE',
                vicScoreRequired = 25000
            },
            {
                prettyName = 'Laser Painter',
                unlockPath = 'Persistence/Unlocks/Vehicles/AtkHeliLaserDesignator',
                category = 'ID_VEHICLE_PILOT_PASSIVE',
                vicScoreRequired = 30500
            },
            -- This is a permanent unlock (i.e. it is in a 4th vehicle unlock group), that once unlocked is always applied to the vehicle.
            -- It doesn't appear to have a selectable unlock path, so it is not included for now (ie. it should hopefully always be active)
            -- {
            --     prettyName = 'Below Radar',
            --     unlockPath = '',
            --     category = '',
            --     vicScoreRequired = 37000
            -- },
            {
                prettyName = 'ECM Jammer',
                unlockPath = 'Persistence/Unlocks/Vehicles/AtkHeliECMJammer',
                category = 'ID_VEHICLE_PILOT_ACTIVE',
                vicScoreRequired = 44000
            },
            {
                prettyName = 'Guided Rocket',
                unlockPath = 'Persistence/Unlocks/Vehicles/AtkHeliRocketGuidance',
                category = 'ID_VEHICLE_PILOT_PASSIVE',
                vicScoreRequired = 51000
            },
            {
                prettyName = 'TV Missile',
                unlockPath = 'Persistence/Unlocks/Vehicles/AtkHeliTVGuidedMissile',
                category = 'ID_VEHICLE_GUNNER_STANCE',
                vicScoreRequired = 60000
            },
        },
        customizationPath = 'Gameplay/Vehicles/ATKHELCustomization',
        vehicleNames = {
            'Vehicles/AH1Z/AH1Z', -- AH-1Z VIPER
            'Vehicles/Mi28/Mi28', -- MI-28 HAVOC
        }
    },
    {
        prettyName = 'Mobile Artillery',
        unlocks = {
            {
                prettyName = 'No Upgrade',
                unlockPath = 'Persistence/Unlocks/Vehicles/NoPassive',
                category = 'ID_VEHICLE_PASSIVE',
                vicScoreRequired = 0
            },
            {
                prettyName = 'No Gadget',
                unlockPath = 'Persistence/Unlocks/Vehicles/NoActive',
                category = 'ID_VEHICLE_ACTIVE',
                vicScoreRequired = 0
            },
            {
                prettyName = 'No Weapon',
                unlockPath = 'Persistence/Unlocks/Vehicles/NoStance',
                category = 'ID_VEHICLE_STANCE',
                vicScoreRequired = 0
            },
            {
                prettyName = 'IR Smoke',
                unlockPath = 'Persistence/Unlocks/Vehicles/ArtillerySmokeLaunchers',
                category = 'ID_VEHICLE_ACTIVE',
                vicScoreRequired = 400
            },
            {
                prettyName = 'Autoloader',
                unlockPath = 'Persistence/Unlocks/Vehicles/ArtilleryReloadUpgrade',
                category = 'ID_VEHICLE_PASSIVE',
                vicScoreRequired = 800
            },
            {
                prettyName = 'Air-Burst Missile',
                unlockPath = 'Persistence/Unlocks/Vehicles/ArtilleryAirBurst',
                category = 'ID_VEHICLE_STANCE',
                vicScoreRequired = 1000 -- Approx (Rocket Specialist Assignment = 10 kills)
            },
            {
                prettyName = 'Anti-Air Missile',
                unlockPath = 'Persistence/Unlocks/Vehicles/ArtilleryAirBurst',
                category = 'ID_VEHICLE_STANCE',
                vicScoreRequired = 1500 -- Approx (Anti-air Support Assignment = 15 Gunship kills)
            },
            {
                prettyName = 'Proximity Scan',
                unlockPath = 'Persistence/Unlocks/Vehicles/ArtilleryProximityScan',
                category = 'ID_VEHICLE_PASSIVE',
                vicScoreRequired = 1600
            },
            {
                prettyName = 'ATACMS Missile',
                unlockPath = 'Persistence/Unlocks/Vehicles/ArtilleryATACMS',
                category = 'ID_VEHICLE_STANCE',
                vicScoreRequired = 2500
            },
            {
                prettyName = 'Maintenance',
                unlockPath = 'Persistence/Unlocks/Vehicles/ArtilleryRegenUpgrade',
                category = 'ID_VEHICLE_PASSIVE',
                vicScoreRequired = 3500
            },
            {
                prettyName = 'Zoom Optics',
                unlockPath = 'Persistence/Unlocks/Vehicles/ArtilleryZoomOptics',
                category = 'ID_VEHICLE_ACTIVE',
                vicScoreRequired = 4500
            },
            {
                prettyName = 'Thermal Camo',
                unlockPath = 'Persistence/Unlocks/Vehicles/ArtilleryStealth',
                category = 'ID_VEHICLE_PASSIVE',
                vicScoreRequired = 5500
            },
            {
                prettyName = 'TOW',
                unlockPath = 'Persistence/Unlocks/Vehicles/ArtilleryTOW',
                category = 'ID_VEHICLE_STANCE',
                vicScoreRequired = 7000
            },
            {
                prettyName = 'Proximity Defense',
                unlockPath = 'Persistence/Unlocks/Vehicles/ArtilleryProximityDefense',
                category = 'ID_VEHICLE_ACTIVE',
                vicScoreRequired = 9000
            },
        },
        customizationPath = 'Gameplay/Vehicles/ArtilleryCustomization',
        vehicleNames = {
            'Vehicles/XP3/HIMARS/HIMARS', -- M142
            'Vehicles/XP3/STAR_1466/STAR_1466', -- BM-23
        }
    },
    {
        prettyName = 'IFV',
        unlocks = {
            {
                prettyName = 'No Upgrade',
                unlockPath = 'Persistence/Unlocks/Vehicles/NoPassive',
                category = 'ID_VEHICLE_PASSIVE',
                vicScoreRequired = 0
            },
            {
                prettyName = 'No Gadget',
                unlockPath = 'Persistence/Unlocks/Vehicles/NoActive',
                category = 'ID_VEHICLE_ACTIVE',
                vicScoreRequired = 0
            },
            {
                prettyName = 'No Weapon',
                unlockPath = 'Persistence/Unlocks/Vehicles/NoStance',
                category = 'ID_VEHICLE_STANCE',
                vicScoreRequired = 0
            },
            {
                prettyName = 'IR Smoke',
                unlockPath = 'Persistence/Unlocks/Vehicles/IfvSmokeLaunchers',
                category = 'ID_VEHICLE_ACTIVE',
                vicScoreRequired = 800
            },
            {
                prettyName = 'ATGM Launcher',
                unlockPath = 'Persistence/Unlocks/Vehicles/IfvTOW',
                category = 'ID_VEHICLE_STANCE',
                vicScoreRequired = 2300
            },
            {
                prettyName = 'Belt Speed',
                unlockPath = 'Persistence/Unlocks/Vehicles/IfvReloadUpgrade',
                category = 'ID_VEHICLE_PASSIVE',
                vicScoreRequired = 4700
            },
            {
                prettyName = 'Coaxial LMG',
                unlockPath = 'Persistence/Unlocks/Vehicles/IfvCoax',
                category = 'ID_VEHICLE_STANCE',
                vicScoreRequired = 8300
            },
            {
                prettyName = 'Thermal Optics',
                unlockPath = 'Persistence/Unlocks/Vehicles/IfvENVGOptics',
                category = 'ID_VEHICLE_ACTIVE',
                vicScoreRequired = 13100
            },
            {
                prettyName = 'Proximity Scan',
                unlockPath = 'Persistence/Unlocks/Vehicles/IfvProximityScan',
                category = 'ID_VEHICLE_PASSIVE',
                vicScoreRequired = 19200
            },
            {
                prettyName = 'Zoom Optics',
                unlockPath = 'Persistence/Unlocks/Vehicles/IfvZoomOptics',
                category = 'ID_VEHICLE_ACTIVE',
                vicScoreRequired = 26900
            },
            {
                prettyName = 'Maintenance',
                unlockPath = 'Persistence/Unlocks/Vehicles/IfvRegenUpgrade',
                category = 'ID_VEHICLE_PASSIVE',
                vicScoreRequired = 36000
            },
            {
                prettyName = 'APFSDS-T Shell',
                unlockPath = 'Persistence/Unlocks/Vehicles/IfvAPFSDS-T',
                category = 'ID_VEHICLE_STANCE',
                vicScoreRequired = 47000
            },
            {
                prettyName = 'Thermal Camo',
                unlockPath = 'Persistence/Unlocks/Vehicles/IfvStealth',
                category = 'ID_VEHICLE_PASSIVE',
                vicScoreRequired = 60000
            },
            {
                prettyName = 'Guided Missile',
                unlockPath = 'Persistence/Unlocks/Vehicles/IfvHellfire',
                category = 'ID_VEHICLE_STANCE',
                vicScoreRequired = 74000
            },
            {
                prettyName = 'Reactive Armor',
                unlockPath = 'Persistence/Unlocks/Vehicles/IfvReactiveArmor',
                category = 'ID_VEHICLE_PASSIVE',
                vicScoreRequired = 90000
            },
        },
        customizationPath = 'Gameplay/Vehicles/IFVCustomization',
        vehicleNames = {
            'BMP2', -- BMP-2M
            'Vehicles/LAV25/LAV25', -- LAV-25
            'Vehicles/XPack01/BTR-90/BTR90', -- BTR-90
        }
    },
    {
        prettyName = 'Jets',
        unlocks = {
            {
                prettyName = 'No Upgrade',
                unlockPath = 'Persistence/Unlocks/Vehicles/NoPassive',
                category = 'ID_VEHICLE_PASSIVE',
                vicScoreRequired = 0
            },
            {
                prettyName = 'No Gadget',
                unlockPath = 'Persistence/Unlocks/Vehicles/NoActive',
                category = 'ID_VEHICLE_ACTIVE',
                vicScoreRequired = 0
            },
            {
                prettyName = 'No Weapon',
                unlockPath = 'Persistence/Unlocks/Vehicles/NoStance',
                category = 'ID_VEHICLE_STANCE',
                vicScoreRequired = 0
            },
            {
                prettyName = 'IR Flares',
                unlockPath = 'Persistence/Unlocks/Vehicles/JetFlareLauncher',
                category = 'ID_VEHICLE_ACTIVE',
                vicScoreRequired = 300
            },
            {
                prettyName = 'Heat Seekers',
                unlockPath = 'Persistence/Unlocks/Vehicles/JetHeatseekerStance',
                category = 'ID_VEHICLE_STANCE',
                vicScoreRequired = 700
            },
            {
                prettyName = 'Stealth',
                unlockPath = 'Persistence/Unlocks/Vehicles/JetStealth',
                category = 'ID_VEHICLE_PASSIVE',
                vicScoreRequired = 1500
            },
            {
                prettyName = 'Belt Speed',
                unlockPath = 'Persistence/Unlocks/Vehicles/JetReload',
                category = 'ID_VEHICLE_PASSIVE',
                vicScoreRequired = 2700
            },
            {
                prettyName = 'Proximity Scan',
                unlockPath = 'Persistence/Unlocks/Vehicles/JetProximityScan',
                category = 'ID_VEHICLE_PASSIVE',
                vicScoreRequired = 4200
            },
            {
                prettyName = 'Rocket Pods',
                unlockPath = 'Persistence/Unlocks/Vehicles/JetRocketStance',
                category = 'ID_VEHICLE_STANCE',
                vicScoreRequired = 6200
            },
            {
                prettyName = 'Air Radar',
                unlockPath = 'Persistence/Unlocks/Vehicles/JetAirRadar',
                category = 'ID_VEHICLE_PASSIVE',
                vicScoreRequired = 8600
            },
            {
                prettyName = 'Extinguisher',
                unlockPath = 'Persistence/Unlocks/Vehicles/JetFireExtinguisher',
                category = 'ID_VEHICLE_ACTIVE',
                vicScoreRequired = 11600
            },
            -- This is a permanent unlock (i.e. it is in a 4th vehicle unlock group), that once unlocked is always applied to the vehicle.
            -- It doesn't appear to have a selectable unlock path, so it is not included for now (ie. it should hopefully always be active)
            -- {
            --     prettyName = 'Below Radar',
            --     unlockPath = '',
            --     category = '',
            --     vicScoreRequired = 15000
            -- },
            {
                prettyName = 'Maintenance',
                unlockPath = 'Persistence/Unlocks/Vehicles/JetRegenUpgrade',
                category = 'ID_VEHICLE_PASSIVE',
                vicScoreRequired = 19000
            },
            {
                prettyName = 'Guided Missile',
                unlockPath = 'Persistence/Unlocks/Vehicles/JetMaverickMissiles',
                category = 'ID_VEHICLE_STANCE',
                vicScoreRequired = 24000
            },
            {
                prettyName = 'Beam Scanning',
                unlockPath = 'Persistence/Unlocks/Vehicles/JetAvionicsUpgrade',
                category = 'ID_VEHICLE_PASSIVE',
                vicScoreRequired = 29000
            },
            {
                prettyName = 'ECM Jammer',
                unlockPath = 'Persistence/Unlocks/Vehicles/JetECMJammerPod',
                category = 'ID_VEHICLE_ACTIVE',
                vicScoreRequired = 35000
            },
        },
        customizationPath = 'Gameplay/Vehicles/JETCustomization',
        vehicleNames = {
            'Su-25TM', -- SU-25TM FROGFOOT
            'Su-35BM Flanker-E', -- SU-35BM FLANKER-E
            'F16', -- F/A-18E SUPER HORNET
            'Vehicles/A-10_THUNDERBOLT/A10_THUNDERBOLT', -- A-10 THUNDERBOLT
            'F35B', -- F-35
        }
    },
    {
        prettyName = 'Tank Destroyers',
        unlocks = {
            {
                prettyName = 'No Upgrade',
                unlockPath = 'Persistence/Unlocks/Vehicles/NoPassive',
                category = 'ID_VEHICLE_PASSIVE',
                vicScoreRequired = 0
            },
            {
                prettyName = 'No Gadget',
                unlockPath = 'Persistence/Unlocks/Vehicles/NoActive',
                category = 'ID_VEHICLE_ACTIVE',
                vicScoreRequired = 0
            },
            {
                prettyName = 'No Weapon',
                unlockPath = 'Persistence/Unlocks/Vehicles/NoStance',
                category = 'ID_VEHICLE_STANCE',
                vicScoreRequired = 0
            },
            {
                prettyName = 'IR Smoke',
                unlockPath = 'Persistence/Unlocks/Vehicles/LbtSmokeLaunchers',
                category = 'ID_VEHICLE_ACTIVE',
                vicScoreRequired = 400
            },
            {
                prettyName = 'Coaxial LMG',
                unlockPath = 'Persistence/Unlocks/Vehicles/LbtCoaxLMG',
                category = 'ID_VEHICLE_STANCE',
                vicScoreRequired = 800
            },
            {
                prettyName = 'TOW',
                unlockPath = 'Persistence/Unlocks/Vehicles/LbtTOWMissile',
                category = 'ID_VEHICLE_STANCE',
                vicScoreRequired = 1100 -- Approx (Wired Attack Assignment = Destroy 10 Tank Destroyers and 1 Mobile Artillery)
            },
            {
                prettyName = 'Cannon HE',
                unlockPath = 'Persistence/Unlocks/Vehicles/LbtMbtHERounds',
                category = 'ID_VEHICLE_STANCE',
                vicScoreRequired = 1500 -- Approx (Explosive Danger Assignment = 15 Kills with Tank Destroyers)
            },
            {
                prettyName = 'Autoloader',
                unlockPath = 'Persistence/Unlocks/Vehicles/LbtReloadUpgrade1',
                category = 'ID_VEHICLE_PASSIVE',
                vicScoreRequired = 1600
            },
            {
                prettyName = 'Extinguisher',
                unlockPath = 'Persistence/Unlocks/Vehicles/LandVehicleFireExtinguisher',
                category = 'ID_VEHICLE_ACTIVE',
                vicScoreRequired = 2000 -- Approx (Need Repair Assignment = Repair 20 Friendly Vehicles)
            },
            {
                prettyName = 'Zoom Optics',
                unlockPath = 'Persistence/Unlocks/Vehicles/LbtZoomOptics',
                category = 'ID_VEHICLE_ACTIVE',
                vicScoreRequired = 3000
            },
            {
                prettyName = 'Maintenance',
                unlockPath = 'Persistence/Unlocks/Vehicles/LbtRegenUpgrade',
                category = 'ID_VEHICLE_PASSIVE',
                vicScoreRequired = 6000
            },
            {
                prettyName = 'Proximity Scan',
                unlockPath = 'Persistence/Unlocks/Vehicles/LbtProximityScan',
                category = 'ID_VEHICLE_PASSIVE',
                vicScoreRequired = 10000
            },
            {
                prettyName = 'Guided Shell',
                unlockPath = 'Persistence/Unlocks/Vehicles/LbtATGMShell',
                category = 'ID_VEHICLE_STANCE',
                vicScoreRequired = 16000
            },
            {
                prettyName = 'Thermal Optics',
                unlockPath = 'Persistence/Unlocks/Vehicles/LbtENVGOptics',
                category = 'ID_VEHICLE_ACTIVE',
                vicScoreRequired = 22000
            },
            {
                prettyName = 'Thermal Camo',
                unlockPath = 'Persistence/Unlocks/Vehicles/LbtStealth',
                category = 'ID_VEHICLE_PASSIVE',
                vicScoreRequired = 28000
            },
            {
                prettyName = 'Canister Shell',
                unlockPath = 'Persistence/Unlocks/Vehicles/LbtCanisterShell',
                category = 'ID_VEHICLE_STANCE',
                vicScoreRequired = 34000
            },
            {
                prettyName = 'Reactive Armor',
                unlockPath = 'Persistence/Unlocks/Vehicles/LbtReactiveArmor',
                category = 'ID_VEHICLE_PASSIVE',
                vicScoreRequired = 40000
            },
        },
        customizationPath = 'Gameplay/Vehicles/LBTCustomization',
        vehicleNames = {
            'Vehicles/XP3/M1128-Stryker/M1128-Stryker', -- M1128
            'Vehicles/XP3/2S25-SPRUT-SD/2S25_SPRUT-SD', -- SPRUT-SD
        }
    },
    {
        prettyName = 'MBT',
        unlocks = {
            {
                prettyName = 'No Upgrade',
                unlockPath = 'Persistence/Unlocks/Vehicles/NoPassive',
                category = 'ID_VEHICLE_PASSIVE',
                vicScoreRequired = 0
            },
            {
                prettyName = 'No Gadget',
                unlockPath = 'Persistence/Unlocks/Vehicles/NoActive',
                category = 'ID_VEHICLE_ACTIVE',
                vicScoreRequired = 0
            },
            {
                prettyName = 'No Weapon',
                unlockPath = 'Persistence/Unlocks/Vehicles/NoStance',
                category = 'ID_VEHICLE_STANCE',
                vicScoreRequired = 0
            },
            {
                prettyName = 'IR Smoke',
                unlockPath = 'Persistence/Unlocks/Vehicles/MbtSmokeLaunchers',
                category = 'ID_VEHICLE_ACTIVE',
                vicScoreRequired = 800
            },
            {
                prettyName = 'Coaxial LMG',
                unlockPath = 'Persistence/Unlocks/Vehicles/MbtCoaxLMG',
                category = 'ID_VEHICLE_STANCE',
                vicScoreRequired = 2100
            },
            {
                prettyName = 'Autoloader',
                unlockPath = 'Persistence/Unlocks/Vehicles/MbtReloadUpgrade1',
                category = 'ID_VEHICLE_PASSIVE',
                vicScoreRequired = 4400
            },
            {
                prettyName = 'Zoom Optics',
                unlockPath = 'Persistence/Unlocks/Vehicles/MbtZoomOptics',
                category = 'ID_VEHICLE_ACTIVE',
                vicScoreRequired = 7600
            },
            {
                prettyName = 'Maintenance',
                unlockPath = 'Persistence/Unlocks/Vehicles/MbtRegenUpgrade',
                category = 'ID_VEHICLE_PASSIVE',
                vicScoreRequired = 12000
            },
            {
                prettyName = 'Coaxial HMG',
                unlockPath = 'Persistence/Unlocks/Vehicles/MbtCoaxHMG',
                category = 'ID_VEHICLE_STANCE',
                vicScoreRequired = 17700
            },
            {
                prettyName = 'Proximity Scan',
                unlockPath = 'Persistence/Unlocks/Vehicles/MbtProximityScan',
                category = 'ID_VEHICLE_PASSIVE',
                vicScoreRequired = 24700
            },
            {
                prettyName = 'Guided Shell',
                unlockPath = 'Persistence/Unlocks/Vehicles/MbtATGMShell',
                category = 'ID_VEHICLE_STANCE',
                vicScoreRequired = 33200
            },
            {
                prettyName = 'Thermal Optics',
                unlockPath = 'Persistence/Unlocks/Vehicles/MbtENVGOptics',
                category = 'ID_VEHICLE_ACTIVE',
                vicScoreRequired = 43200
            },
            {
                prettyName = 'Thermal Camo',
                unlockPath = 'Persistence/Unlocks/Vehicles/MbtStealth',
                category = 'ID_VEHICLE_PASSIVE',
                vicScoreRequired = 54800
            },
            {
                prettyName = 'Canister Shell',
                unlockPath = 'Persistence/Unlocks/Vehicles/MbtCanisterShell',
                category = 'ID_VEHICLE_STANCE',
                vicScoreRequired = 68100
            },
            {
                prettyName = 'Reactive Armor',
                unlockPath = 'Persistence/Unlocks/Vehicles/MbtReactiveArmor',
                category = 'ID_VEHICLE_PASSIVE',
                vicScoreRequired = 83200
            },
            -- This is a permanent unlock (i.e. it is in a 4th vehicle unlock group), that once unlocked is always applied to the vehicle.
            -- It doesn't appear to have a selectable unlock path, so it is not included for now (ie. it should hopefully always be active)
            -- {
            --     prettyName = 'CITV Station',
            --     unlockPath = '',
            --     category = '',
            --     vicScoreRequired = 100000
            -- },
        },
        customizationPath = 'Gameplay/Vehicles/MBTCustomization',
        vehicleNames = {
            'T90', -- T-90A
            'Vehicles/M1A2/M1Abrams', -- M1 ABRAMS
        }
    },
    {
        prettyName = 'Scout Helicopters',
        unlocks = {
            {
                prettyName = 'No Upgrade',
                unlockPath = 'Persistence/Unlocks/Vehicles/NoPassive',
                category = 'ID_VEHICLE_PASSIVE',
                vicScoreRequired = 0
            },
            {
                prettyName = 'No Gadget',
                unlockPath = 'Persistence/Unlocks/Vehicles/NoActive',
                category = 'ID_VEHICLE_ACTIVE',
                vicScoreRequired = 0
            },
            {
                prettyName = 'No Weapon',
                unlockPath = 'Persistence/Unlocks/Vehicles/NoStance',
                category = 'ID_VEHICLE_STANCE',
                vicScoreRequired = 0
            },
            {
                prettyName = 'IR Flares',
                unlockPath = 'Persistence/Unlocks/Vehicles/ScoutFlares',
                category = 'ID_VEHICLE_ACTIVE',
                vicScoreRequired = 400
            },
            {
                prettyName = 'Heat Seekers',
                unlockPath = 'Persistence/Unlocks/Vehicles/ScoutAAMissile',
                category = 'ID_VEHICLE_STANCE',
                vicScoreRequired = 1200
            },
            {
                prettyName = 'Stealth',
                unlockPath = 'Persistence/Unlocks/Vehicles/ScoutStealth',
                category = 'ID_VEHICLE_PASSIVE',
                vicScoreRequired = 2500
            },
            {
                prettyName = 'Belt Speed',
                unlockPath = 'Persistence/Unlocks/Vehicles/ScoutWPEfficiency',
                category = 'ID_VEHICLE_PASSIVE',
                vicScoreRequired = 4400
            },
            {
                prettyName = 'Proximity Scan',
                unlockPath = 'Persistence/Unlocks/Vehicles/ScoutScan',
                category = 'ID_VEHICLE_PASSIVE',
                vicScoreRequired = 7000
            },
            {
                prettyName = 'Air Radar',
                unlockPath = 'Persistence/Unlocks/Vehicles/ScoutHeliAirRadar',
                category = 'ID_VEHICLE_PASSIVE',
                vicScoreRequired = 10000
            },
            {
                prettyName = 'Extinguisher',
                unlockPath = 'Persistence/Unlocks/Vehicles/ScoutExtinguisher',
                category = 'ID_VEHICLE_ACTIVE',
                vicScoreRequired = 14000
            },
            {
                prettyName = 'Maintenance',
                unlockPath = 'Persistence/Unlocks/Vehicles/ScoutHealthRegen',
                category = 'ID_VEHICLE_PASSIVE',
                vicScoreRequired = 19000
            },
            {
                prettyName = 'Guided Missile',
                unlockPath = 'Persistence/Unlocks/Vehicles/ScoutATGMissile',
                category = 'ID_VEHICLE_STANCE',
                vicScoreRequired = 25000
            },
            -- This is a permanent unlock (i.e. it is in a 4th vehicle unlock group), that once unlocked is always applied to the vehicle.
            -- It doesn't appear to have a selectable unlock path, so it is not included for now (ie. it should hopefully always be active)
            -- {
            --     prettyName = 'Below Radar',
            --     unlockPath = '',
            --     category = '',
            --     vicScoreRequired = 32000
            -- },
            -- This is a permanent unlock(?) (i.e. it is in a 4th vehicle unlock group), that once unlocked is always applied to the vehicle.
            -- It doesn't appear to have a selectable unlock path, so it is not included for now (ie. it should hopefully always be active)
            -- {
            --     prettyName = 'Laser Painter',
            --     unlockPath = '',
            --     category = '',
            --     vicScoreRequired = 40000
            -- },
            {
                prettyName = 'ECM Jammer',
                unlockPath = 'Persistence/Unlocks/Vehicles/ScoutECMJammer',
                category = 'ID_VEHICLE_ACTIVE',
                vicScoreRequired = 48000
            },
        },
        customizationPath = 'Gameplay/Vehicles/SCOUTCustomization',
        vehicleNames = {
            'Vehicles/Z11W/Z-11w', -- Z-11W
            'Vehicles/AH6/AH6_Littlebird', -- AH-6J LITTLE BIRD
            -- vvv TRANSPORT HELICOPTERS vvv
            -- 'Vehicles/Venom/Venom', -- UH-1Y VENOM
            -- 'AAV-7A1', -- AAV-7A1 AMTRAC
            -- 'Ka-60', -- KA-60 KASATKA
        }
    },
}