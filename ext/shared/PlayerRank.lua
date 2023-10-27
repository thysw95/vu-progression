local VUPlayerRankClass = class('VUPlayerRank')

function VUPlayerRankClass:__init(player)
    -- print("I RECEIVED THE FOLLOWING PLAYER FOR OBJECT CREATION:")
    -- print(player)
	self.InitVariables(self, player)
end

function VUPlayerRankClass:InitVariables(player)
    self.InitPlayerVariables(self, player)
    self.InitGeneralRankStats(self)

    self.InitAssaultRankStats(self)
    self.InitEngineerRankStats(self)
    self.InitSupportRankStats(self)
    self.InitReconRankStats(self)
    self.InitWeaponKills(self)
end

function VUPlayerRankClass:InitPlayerVariables(player)
    self.r_PlayerName = player.name
    self.r_PlayerGuid = player.guid
    self.r_Kills = 0
    self.r_Deaths = 0
end

function VUPlayerRankClass:InitGeneralRankStats()
    self.r_PlayerLevel = 1
    self.r_PlayerCurrentXP = 0
end

function VUPlayerRankClass:InitAssaultRankStats()
    self.r_AssaultLevel = 1
    self.r_AssaultCurrentXP = 0
end

function VUPlayerRankClass:InitEngineerRankStats()
    self.r_EngineerLevel = 1
    self.r_EngineerCurrentXP = 0
end

function VUPlayerRankClass:InitSupportRankStats()
    self.r_SupportLevel = 1
    self.r_SupportCurrentXP = 0
end

function VUPlayerRankClass:InitReconRankStats()
    self.r_ReconLevel = 1
    self.r_ReconCurrentXP = 0
end

function VUPlayerRankClass:InitWeaponKills()
    self.r_WeaponProgressList = {
        -- {
        --     weaponName = "Weapons/AK74M/AK74",
        --     kills = 0
        -- },
        -- {
        --     weaponName = "M16A4",
        --     kills = 0
        -- },
        {
            weaponName = 'Weapons/A91/A91',
            kills = 0
        },
        {
            weaponName = 'AEK-971',
            kills = 0
        },
        {
            weaponName = 'Weapons/AK74M/AK74',
            kills = 0
        },
        {
            weaponName = 'AKS-74u',
            kills = 0
        },
        {
            weaponName = 'AN-94 Abakan',
            kills = 0
        },
        {
            weaponName = 'AS Val',
            kills = 0
        },
        {
            weaponName = 'DAO-12',
            kills = 0
        },
        {
            weaponName = 'F2000',
            kills = 0
        },
        {
            weaponName = 'FGM-148',
            kills = 0
        },
        {
            weaponName = 'FGM-148',
            kills = 0
        },
        {
            weaponName = 'FIM92',
            kills = 0
        },
        {
            weaponName = 'FIM92',
            kills = 0
        },
        {
            weaponName = 'Weapons/G36C/G36C',
            kills = 0
        },
        {
            weaponName = 'Weapons/G3A3/G3A3',
            kills = 0
        },
        {
            weaponName = 'AmmoBag',
            kills = 0
        },
        {
            weaponName = 'Weapons/Gadgets/C4/C4',
            kills = 0
        },
        {
            weaponName = 'Weapons/Gadgets/Claymore/Claymore',
            kills = 0
        },
        {
            weaponName = 'Defib',
            kills = 0
        },
        {
            weaponName = 'Weapons/Gadgets/EODBot/EODBot_PDA',
            kills = 0
        },
        {
            weaponName = 'EOD Repair Tool',
            kills = 0
        },
        {
            weaponName = 'EOD Bot HMG',
            kills = 0
        },
        {
            weaponName = 'M15 AT Mine',
            kills = 0
        },
        {
            weaponName = 'Weapons/Gadgets/M224/M224_SPOnly',
            kills = 0
        },
        {
            weaponName = 'Weapons/Gadgets/M224/M224',
            kills = 0
        },
        {
            weaponName = 'M26Mass',
            kills = 0
        },
        {
            weaponName = 'M320',
            kills = 0
        },
        {
            weaponName = 'Weapons/Gadgets/MAV/MAV_PDA',
            kills = 0
        },
        {
            weaponName = 'MAV EMP Weapon',
            kills = 0
        },
        {
            weaponName = 'Medkit',
            kills = 0
        },
        {
            weaponName = 'Weapons/Gadgets/RadioBeacon/Radio_Beacon',
            kills = 0
        },
        {
            weaponName = 'Repair Tool',
            kills = 0
        },
        {
            weaponName = 'Weapons/Gadgets/SOFLAM/SOFLAM_PDA',
            kills = 0
        },
        {
            weaponName = 'Weapons/Gadgets/T-UGS/T-UGS',
            kills = 0
        },
        {
            weaponName = 'Glock18',
            kills = 0
        },
        {
            weaponName = 'Weapons/Handcuffs/Handcuff',
            kills = 0
        },
        {
            weaponName = 'Weapons/KH2002/KH2002',
            kills = 0
        },
        {
            weaponName = 'Weapons/Knife/Knife',
            kills = 0
        },
        {
            weaponName = 'M1014',
            kills = 0
        },
        {
            weaponName = 'M136',
            kills = 0
        },
        {
            weaponName = 'M16A4',
            kills = 0
        },
        {
            weaponName = 'M1911',
            kills = 0
        },
        {
            weaponName = 'M240',
            kills = 0
        },
        {
            weaponName = 'M249',
            kills = 0
        },
        {
            weaponName = 'M27IAR',
            kills = 0
        },
        {
            weaponName = 'M39',
            kills = 0
        },
        {
            weaponName = 'M40A5',
            kills = 0
        },
        {
            weaponName = 'M416',
            kills = 0
        },
        {
            weaponName = 'M4A1',
            kills = 0
        },
        {
            weaponName = 'M60',
            kills = 0
        },
        {
            weaponName = 'M67',
            kills = 0
        },
        {
            weaponName = 'M67',
            kills = 0
        },
        {
            weaponName = 'M82A3',
            kills = 0
        },
        {
            weaponName = 'M9',
            kills = 0
        },
        {
            weaponName = 'M9',
            kills = 0
        },
        {
            weaponName = 'M93R',
            kills = 0
        },
        {
            weaponName = 'M93R',
            kills = 0
        },
        {
            weaponName = 'Weapons/Machete/Machete',
            kills = 0
        },
        {
            weaponName = 'Weapons/MagpulPDR/MagpulPDR',
            kills = 0
        },
        {
            weaponName = 'Mk11',
            kills = 0
        },
        {
            weaponName = 'Model98B',
            kills = 0
        },
        {
            weaponName = 'Weapons/MP412Rex/MP412REX',
            kills = 0
        },
        {
            weaponName = 'Weapons/MP443/MP443_GM',
            kills = 0
        },
        {
            weaponName = 'Weapons/MP443/MP443',
            kills = 0
        },
        {
            weaponName = 'MP7',
            kills = 0
        },
        {
            weaponName = 'Weapons/P90/P90_GM',
            kills = 0
        },
        {
            weaponName = 'Weapons/P90/P90',
            kills = 0
        },
        {
            weaponName = 'Pecheneg',
            kills = 0
        },
        {
            weaponName = 'PP-2000',
            kills = 0
        },
        {
            weaponName = '870MCS',
            kills = 0
        },
        {
            weaponName = 'RPG-7',
            kills = 0
        },
        {
            weaponName = 'RPG-7',
            kills = 0
        },
        {
            weaponName = 'RPK-74M',
            kills = 0
        },
        {
            weaponName = 'Weapons/Sa18IGLA/Sa18IGLA',
            kills = 0
        },
        {
            weaponName = 'Siaga20k',
            kills = 0
        },
        {
            weaponName = 'Weapons/SCAR-H/SCAR-H',
            kills = 0
        },
        {
            weaponName = 'SG 553 LB',
            kills = 0
        },
        {
            weaponName = 'SKS',
            kills = 0
        },
        {
            weaponName = 'SMAW',
            kills = 0
        },
        {
            weaponName = 'SV98',
            kills = 0
        },
        {
            weaponName = 'SVD',
            kills = 0
        },
        {
            weaponName = 'Taurus .44',
            kills = 0
        },
        {
            weaponName = 'Taurus .44',
            kills = 0
        },
        {
            weaponName = 'Type88',
            kills = 0
        },
        {
            weaponName = 'Weapons/UMP45/UMP45',
            kills = 0
        },
        {
            weaponName = 'USAS-12',
            kills = 0
        },
        {
            weaponName = 'Weapons/Weapon_Dummy/Weapon_Dummy',
            kills = 0
        },
        {
            weaponName = 'FAMAS',
            kills = 0
        },
        {
            weaponName = 'HK53',
            kills = 0
        },
        {
            weaponName = 'jackhammer',
            kills = 0
        },
        {
            weaponName = 'Weapons/XP1_L85A2/L85A2',
            kills = 0
        },
        {
            weaponName = 'L96',
            kills = 0
        },
        {
            weaponName = 'MG36',
            kills = 0
        },
        {
            weaponName = 'PP-19',
            kills = 0
        },
        {
            weaponName = 'QBB-95',
            kills = 0
        },
        {
            weaponName = 'QBU-88',
            kills = 0
        },
        {
            weaponName = 'QBZ-95',
            kills = 0
        },
        {
            weaponName = 'Weapons/XP2_ACR/ACR',
            kills = 0
        },
        {
            weaponName = 'M417',
            kills = 0
        },
        {
            weaponName = 'JNG90',
            kills = 0
        },
        {
            weaponName = 'Knife_RazorBlade',
            kills = 0
        },
        {
            weaponName = 'Weapons/XP2_L86/L86',
            kills = 0
        },
        {
            weaponName = 'LSAT',
            kills = 0
        },
        {
            weaponName = 'Weapons/XP2_MP5K/MP5K',
            kills = 0
        },
        {
            weaponName = 'Weapons/XP2_MTAR/MTAR',
            kills = 0
        },
        {
            weaponName = 'SCAR-L',
            kills = 0
        },
        {
            weaponName = 'SPAS-12',
            kills = 0
        },
        {
            weaponName = 'Steyr AUG',
            kills = 0
        },
        {
            weaponName = 'CrossBow',
            kills = 0
        }
    }
end




-- function VUPlayerRankClass:OnExperienceGained(xpValue)
--     self.r_PlayerCurrentXP = self.r_PlayerCurrentXP + xpValue

--     print("GAINED EXPERIENCE!!!!!")
--     print("CURRENT EXPERIENCE:")
--     print(self.r_PlayerCurrentXP)

--     if self.r_PlayerCurrentXP >= self.r_PlayerRequiredXP then
--         self.LevelUp(self)
--     end
-- end

-- function VUPlayerRankClass:LevelUp()
--     self.r_PlayerRequiredXP = self.r_PlayerRequiredXP + (self.r_PlayerRequiredXP)
--     self.r_PlayerLevel = self.r_PlayerLevel + 1

--     print(self.r_PlayerName .. " HAS GAINED A LEVEL!!!!")
--     print("NEW LEVEL IS: ")
--     print(self.r_PlayerLevel)
    
-- end

return VUPlayerRankClass