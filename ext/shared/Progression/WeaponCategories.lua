-- THIS IS NOT A CONFIG FILE
-- It is game data used to map weapon names to their categories for Ribbon progress.

local WEAPON_CATEGORIES = {
    -- Assault Rifles
    ['AEK-971'] = 'AssaultRifle',
    ['AN-94 Abakan'] = 'AssaultRifle',
    ['F2000'] = 'AssaultRifle',
    ['FAMAS'] = 'AssaultRifle',
    ['M16A4'] = 'AssaultRifle',
    ['M416'] = 'AssaultRifle',
    ['QBZ-95'] = 'AssaultRifle',
    ['SCAR-L'] = 'AssaultRifle',
    ['Steyr AUG'] = 'AssaultRifle',
    ['Weapons/AK74M/AK74'] = 'AssaultRifle',
    ['Weapons/G3A3/G3A3'] = 'AssaultRifle',
    ['Weapons/KH2002/KH2002'] = 'AssaultRifle',
    ['Weapons/XP1_L85A2/L85A2'] = 'AssaultRifle',
    -- Additional common names / fallback checks
    ['AK74M'] = 'AssaultRifle',
    ['AK-74M'] = 'AssaultRifle',
    ['AN-94'] = 'AssaultRifle',
    ['G3A3'] = 'AssaultRifle',
    ['KH2002'] = 'AssaultRifle',
    ['L85A2'] = 'AssaultRifle',

    -- Carbines
    ['AKS-74u'] = 'Carbine',
    ['HK53'] = 'Carbine', -- G53
    ['M4A1'] = 'Carbine',
    ['SG 553 LB'] = 'Carbine',
    ['Weapons/A91/A91'] = 'Carbine',
    ['Weapons/G36C/G36C'] = 'Carbine',
    ['Weapons/SCAR-H/SCAR-H'] = 'Carbine',
    ['Weapons/XP2_ACR/ACR'] = 'Carbine', -- ACW-R
    ['Weapons/XP2_MTAR/MTAR'] = 'Carbine', -- MTAR-21
    -- Fallbacks
    ['A91'] = 'Carbine',
    ['A-91'] = 'Carbine',
    ['AKS74U'] = 'Carbine',
    ['G36C'] = 'Carbine',
    ['G53'] = 'Carbine',
    ['SG553'] = 'Carbine',
    ['SCAR-H'] = 'Carbine',
    ['ACW-R'] = 'Carbine',
    ['MTAR-21'] = 'Carbine',
    ['M4'] = 'Carbine',

    -- Light Machine Guns (LMGs)
    ['LSAT'] = 'LMG',
    ['M240'] = 'LMG',
    ['M249'] = 'LMG',
    ['M27IAR'] = 'LMG',
    ['M60'] = 'LMG',
    ['MG36'] = 'LMG',
    ['Pecheneg'] = 'LMG',
    ['QBB-95'] = 'LMG',
    ['RPK-74M'] = 'LMG',
    ['Type88'] = 'LMG',
    ['Weapons/XP2_L86/L86'] = 'LMG', -- L86 LSW
    -- Fallbacks
    ['M240B'] = 'LMG',
    ['M60E4'] = 'LMG',
    ['PKP Pecheneg'] = 'LMG',
    ['QBB95'] = 'LMG',
    ['RPK'] = 'LMG',
    ['L86'] = 'LMG',

    -- Sniper Rifles
    ['JNG90'] = 'SniperRifle',
    ['L96'] = 'SniperRifle',
    ['M39'] = 'SniperRifle',
    ['M40A5'] = 'SniperRifle',
    ['M417'] = 'SniperRifle',
    ['M82A3'] = 'SniperRifle',
    ['Mk11'] = 'SniperRifle',
    ['Model98B'] = 'SniperRifle',
    ['QBU-88'] = 'SniperRifle',
    ['SKS'] = 'SniperRifle',
    ['SV98'] = 'SniperRifle',
    ['SVD'] = 'SniperRifle',
    -- Fallbacks
    ['M39 EMR'] = 'SniperRifle',
    ['M98B'] = 'SniperRifle',
    ['QBU88'] = 'SniperRifle',
    ['SV-98'] = 'SniperRifle',

    -- PDWs (Personal Defense Weapons)
    ['AS Val'] = 'PDW',
    ['MP7'] = 'PDW',
    ['PP-19'] = 'PDW',
    ['PP-2000'] = 'PDW',
    ['Weapons/MagpulPDR/MagpulPDR'] = 'PDW', -- PDW-R
    ['Weapons/P90/P90'] = 'PDW',
    ['Weapons/UMP45/UMP45'] = 'PDW',
    ['Weapons/XP2_MP5K/MP5K'] = 'PDW', -- M5K
    -- Fallbacks
    ['ASVal'] = 'PDW',
    ['PDW-R'] = 'PDW',
    ['P90'] = 'PDW',
    ['UMP45'] = 'PDW',
    ['UMP-45'] = 'PDW',
    ['PP19'] = 'PDW',
    ['PP2000'] = 'PDW',
    ['M5K'] = 'PDW',

    -- Shotguns
    ['870MCS'] = 'Shotgun',
    ['DAO-12'] = 'Shotgun',
    ['jackhammer'] = 'Shotgun', -- MK3A1
    ['M1014'] = 'Shotgun',
    ['Siaga20k'] = 'Shotgun', -- Saiga 12K
    ['SPAS-12'] = 'Shotgun',
    ['USAS-12'] = 'Shotgun',
    -- Fallbacks
    ['Remington 870'] = 'Shotgun',
    ['DAO12'] = 'Shotgun',
    ['Saiga 12K'] = 'Shotgun',
    ['Saiga12'] = 'Shotgun',
    ['USAS12'] = 'Shotgun',
    ['MK3A1'] = 'Shotgun',
    ['M26 MASS'] = 'Shotgun',
    ['M26'] = 'Shotgun',

    -- Handguns
    ['Glock18'] = 'Handgun',
    ['M93R'] = 'Handgun',
    ['Taurus .44'] = 'Handgun',
    -- Fallbacks
    ['M9'] = 'Handgun',
    ['MP443'] = 'Handgun',
    ['M1911'] = 'Handgun',
    ['Glock17'] = 'Handgun',
    ['Glock 17'] = 'Handgun',
    ['Glock 18'] = 'Handgun',
    ['93R'] = 'Handgun',
    ['Rex'] = 'Handgun',
    ['MP412'] = 'Handgun',

    -- Melee
    ['Knife'] = 'Melee',
    ['Weapons/Melee/Knife'] = 'Melee',
    ['Weapons/Melee/Knife_Phys'] = 'Melee',
    ['Weapons/Melee/Knife_Razor'] = 'Melee',
}

return {
    GetCategory = function(weaponName)
        if not weaponName then return nil end
        
        -- Exact match
        if WEAPON_CATEGORIES[weaponName] then
            return WEAPON_CATEGORIES[weaponName]
        end
        
        -- Pattern / substring match
        local lowerName = string.lower(weaponName)
        if string.find(lowerName, "knife") or string.find(lowerName, "melee") then
            return 'Melee'
        elseif string.find(lowerName, "m16") or string.find(lowerName, "ak74") or string.find(lowerName, "m416") or string.find(lowerName, "aek") or string.find(lowerName, "f2000") or string.find(lowerName, "famas") or string.find(lowerName, "g3a3") or string.find(lowerName, "kh2002") or string.find(lowerName, "l85") or string.find(lowerName, "aug") or string.find(lowerName, "scar-l") or string.find(lowerName, "an94") or string.find(lowerName, "abakan") then
            return 'AssaultRifle'
        elseif string.find(lowerName, "aks74") or string.find(lowerName, "g36c") or string.find(lowerName, "m4a1") or string.find(lowerName, "sg553") or string.find(lowerName, "hk53") or string.find(lowerName, "acr") or string.find(lowerName, "mtar") or string.find(lowerName, "scar-h") or string.find(lowerName, "a91") or string.find(lowerName, "a-91") then
            return 'Carbine'
        elseif string.find(lowerName, "m249") or string.find(lowerName, "pech") or string.find(lowerName, "pkp") or string.find(lowerName, "m60") or string.find(lowerName, "m27") or string.find(lowerName, "rpk") or string.find(lowerName, "mg36") or string.find(lowerName, "qbb") or string.find(lowerName, "l86") or string.find(lowerName, "lsat") or string.find(lowerName, "type88") or string.find(lowerName, "m240") then
            return 'LMG'
        elseif string.find(lowerName, "sv98") or string.find(lowerName, "sv-98") or string.find(lowerName, "l96") or string.find(lowerName, "m40") or string.find(lowerName, "m98") or string.find(lowerName, "model98") or string.find(lowerName, "jng") or string.find(lowerName, "svd") or string.find(lowerName, "mk11") or string.find(lowerName, "m39") or string.find(lowerName, "sks") or string.find(lowerName, "m417") or string.find(lowerName, "qbu") or string.find(lowerName, "m82") then
            return 'SniperRifle'
        elseif string.find(lowerName, "mp7") or string.find(lowerName, "p90") or string.find(lowerName, "ump") or string.find(lowerName, "pp2000") or string.find(lowerName, "pp-2000") or string.find(lowerName, "pp19") or string.find(lowerName, "pp-19") or string.find(lowerName, "mp5") or string.find(lowerName, "m5k") or string.find(lowerName, "asval") or string.find(lowerName, "pdr") then
            return 'PDW'
        elseif string.find(lowerName, "870") or string.find(lowerName, "m1014") or string.find(lowerName, "saiga") or string.find(lowerName, "siaga") or string.find(lowerName, "dao") or string.find(lowerName, "usas") or string.find(lowerName, "spas") or string.find(lowerName, "jackhammer") or string.find(lowerName, "m26") then
            return 'Shotgun'
        elseif string.find(lowerName, "m9") or string.find(lowerName, "mp443") or string.find(lowerName, "m1911") or string.find(lowerName, "glock") or string.find(lowerName, "taurus") or string.find(lowerName, "rex") or string.find(lowerName, "93r") then
            return 'Handgun'
        end
        
        return nil
    end
}
