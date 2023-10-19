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
    -- print("SUCCESSFULLY ADDED INITIALIZED A NEW PLAYER!!!!!!!!!")
end

function VUPlayerRankClass:InitPlayerVariables(player)
    self.r_PlayerName = player.name
end

function VUPlayerRankClass:InitGeneralRankStats()
    self.r_PlayerLevel = 1
    self.r_PlayerCurrentXP = 0
    -- self.r_PlayerRequiredXP = 200
end

function VUPlayerRankClass:InitAssaultRankStats()
    self.r_AssaultLevel = 1
    self.r_AssaultCurrentXP = 0
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