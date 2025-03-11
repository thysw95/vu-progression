require("__shared/config")
require("__shared/KitVariables")
require("SQL/DBCreation")

local generalProgressionUnlockList = require("__shared/Progression/GeneralProgressionConfig")
local assaultProgressionUnlockList = require("__shared/Progression/AssaultProgressionConfig")
local engineerProgressUnlockList = require("__shared/Progression/EngineerProgressionConfig")
local supportProgressUnlockList = require("__shared/Progression/SupportProgressionConfig")
local reconProgressUnlockList = require("__shared/Progression/ReconProgressionConfig")

local rankingStorageManager = require('SQL/RankingStorageManager')
-- local weaponProgressUnlocks = require("__shared/Progression/WeaponProgressionConfig")
-- require("SQLTest")

playerRankClass = require('__shared/PlayerRank')
currentRankupPlayers = {}


function AddPlayerToRankUpList(player)
    local playerRankObject = playerRankClass(player)

    playerRankObject = rankingStorageManager:FetchPlayerProgress(playerRankObject)

    print("NEW PLAYER GUID: ")
    print(playerRankObject['r_PlayerGuid'])
    -- local playerAdded = false
    
    if #currentRankupPlayers > 0 then
        local foundPlayer = false

        for _, cPlayer in pairs(currentRankupPlayers) do
            if cPlayer['r_PlayerGuid'] == player.guid then
                print(player.name .. ' IS ALREADY ON THE LIST')

                foundPlayer = true
            end
        end

        if foundPlayer == false then
            print("ADDING " .. player.name .. " TO THE RANKUP LIST")

            table.insert(currentRankupPlayers, playerRankObject)

            -- playerAdded = true
        end
    else
        print("ADDING " .. player.name .. " TO THE RANKUP LIST")

        table.insert(currentRankupPlayers, playerRankObject)

        -- playerAdded = true
    end

    -- if playerAdded == true then
    --     initPlayerLevels(player, playerRankObject)
    -- end
    initPlayerLevels(player, playerRankObject)
end

function initPlayerLevels(player, playerRankObject)
    -- Player General Initial Unlock
    NetEvents:SendTo('OnInitialUnlock', player, "General", playerRankObject['r_PlayerCurrentXP'])

    -- Kit Initial Unlocks
    NetEvents:SendTo('OnInitialUnlock', player, "Assault", playerRankObject['r_AssaultCurrentXP'])
    NetEvents:SendTo('OnInitialUnlock', player, "Engineer", playerRankObject['r_EngineerCurrentXP'])
    NetEvents:SendTo('OnInitialUnlock', player, "Support", playerRankObject['r_SupportCurrentXP'])
    NetEvents:SendTo('OnInitialUnlock', player, "Recon", playerRankObject['r_ReconCurrentXP'])

    -- Attachment unlocks
    if #playerRankObject['r_WeaponProgressList'] > 0 then
        NetEvents:SendTo('OnInitialAttachmentUnlock', player, playerRankObject['r_WeaponProgressList'])
    end
    -- NetEvents:SendTo('OnInitialAttachmentUnlock', player)
end

function PlayerXPUpdated(player, score)
    -- player:MakeWritable()
    local selectedKit = player.customization
    local kitData = DataContainer(selectedKit)
    local veniceSoldierAsset = VeniceSoldierCustomizationAsset(kitData)
    veniceSoldierAsset:MakeWritable()

    local kitName = veniceSoldierAsset.labelSid
    local xp = score * xpMultiplier

    if #currentRankupPlayers > 0 then
        for playerIndex, cPlayer in pairs(currentRankupPlayers) do
            if cPlayer['r_PlayerGuid'] == player.guid then
                print("Found a player to increase XP!!!!")

                -- IncreaseGeneralPlayerXP(playerIndex, score)
                IncreasePlayerXP(playerIndex, 'r_PlayerLevel', 'r_PlayerCurrentXP', xp, generalProgressionUnlockList, "General")

                if kitName == 'ID_M_ASSAULT' then
                    -- IncreaseAssaultPlayerXP(playerIndex, score)
                    IncreasePlayerXP(playerIndex, 'r_AssaultLevel', 'r_AssaultCurrentXP', xp, assaultProgressionUnlockList, "Assault")
                end

                if kitName == 'ID_M_ENGINEER' then
                    IncreasePlayerXP(playerIndex, 'r_EngineerLevel', 'r_EngineerCurrentXP', xp, engineerProgressUnlockList, "Engineer")
                end

                if kitName == 'ID_M_SUPPORT' then
                    IncreasePlayerXP(playerIndex, 'r_SupportLevel', 'r_SupportCurrentXP', xp, supportProgressUnlockList, "Support")
                end

                if kitName == 'ID_M_RECON' then
                    IncreasePlayerXP(playerIndex, 'r_ReconLevel', 'r_ReconCurrentXP', xp, reconProgressUnlockList, "Recon")
                end
            end
        end
    end
end

function IncreaseWeaponKills(playerIndex, weaponName) 
    -- if currentRankupPlayers[playerIndex] ~= nil then
        if #currentRankupPlayers[playerIndex]['r_WeaponProgressList'] > 0 then
            for _, weapon in pairs(currentRankupPlayers[playerIndex]['r_WeaponProgressList']) do
                if weapon['weaponName'] == weaponName then
                    weapon['kills'] = weapon['kills'] + 1

                    print("THE WEAPON " .. weapon['weaponName'] .. " CURRENT KILLS IS " .. tostring(weapon['kills']))

                    local player = PlayerManager:GetPlayerByGuid(currentRankupPlayers[playerIndex]['r_PlayerGuid'])
                    if player ~= nil then
                        NetEvents:SendTo('OnKilledPlayer', player, weapon['weaponName'], weapon['kills'])
                    end

                    break
                end
            end
        end
    -- end
end

-- function IncreaseGeneralPlayerXP(playerIndex, xpValue)
--     currentRankupPlayers[playerIndex]['r_PlayerCurrentXP'] = currentRankupPlayers[playerIndex]['r_PlayerCurrentXP'] + xpValue

--     if #generalProgressionUnlockList > 0 then
--         for _, gProgress in pairs(generalProgressionUnlockList) do
--             if currentRankupPlayers[playerIndex]['r_PlayerLevel'] < gProgress.lvl and currentRankupPlayers[playerIndex]['r_PlayerCurrentXP'] >= gProgress.xpRequired then
--                 currentRankupPlayers[playerIndex]['r_PlayerLevel'] = gProgress.lvl

--                 print("CHANGED GENERAL PROGRESSION TO LEVEL " .. tostring(currentRankupPlayers[playerIndex]['r_PlayerLevel']))

--                 PlayerLevelUp(playerIndex, "General", currentRankupPlayers[playerIndex]['r_PlayerLevel'])
--             end
--         end
--     end
-- end

-- function IncreaseAssaultPlayerXP(playerIndex, xpValue)
--     currentRankupPlayers[playerIndex]['r_AssaultCurrentXP'] = currentRankupPlayers[playerIndex]['r_AssaultCurrentXP'] + xpValue

--     if #assaultProgressionUnlockList > 0 then
--         for _, aProgress in pairs(assaultProgressionUnlockList) do
--             if currentRankupPlayers[playerIndex]['r_AssaultLevel'] < aProgress.lvl and currentRankupPlayers[playerIndex]['r_AssaultCurrentXP'] >= aProgress.xpRequired then
--                 currentRankupPlayers[playerIndex]['r_AssaultLevel'] = aProgress.lvl

--                 print("CHANGED ASSAULT PROGRESSION TO LEVEL " .. tostring(currentRankupPlayers[playerIndex]['r_AssaultLevel']))

--                 PlayerLevelUp(playerIndex, "Assault", currentRankupPlayers[playerIndex]['r_AssaultLevel'])
--             end
--         end
--     end
-- end

function IncreasePlayerXP(playerIndex, levelKey, xpKey, xpValue, progressUnlockList, levelType)
    currentRankupPlayers[playerIndex][xpKey] = currentRankupPlayers[playerIndex][xpKey] + xpValue

    if #progressUnlockList > 0 then
        for _, aProgress in pairs(progressUnlockList) do
            if currentRankupPlayers[playerIndex][levelKey] < aProgress.lvl and currentRankupPlayers[playerIndex][xpKey] >= aProgress.xpRequired then
                currentRankupPlayers[playerIndex][levelKey] = aProgress.lvl

                print("CHANGED " .. levelType .. " PROGRESSION TO LEVEL " .. tostring(currentRankupPlayers[playerIndex][levelKey]))

                PlayerLevelUp(playerIndex, levelType, currentRankupPlayers[playerIndex][xpKey])
            end
        end
    end
end

function PlayerLevelUp(playerIndex, levelType, currentXp)
    -- print(currentRankupPlayers[playerIndex]['r_PlayerName'] .. " HAS GAINED A LEVEL FOR " .. levelType .. "!!!!")
    -- print("NEW " .. levelType .. " LEVEL IS: ")
    -- print(currentRankupPlayers[playerIndex]['r_PlayerLevel'])

    -- local level = currentRankupPlayers[playerIndex]['r_PlayerLevel']

    local player = PlayerManager:GetPlayerByGuid(currentRankupPlayers[playerIndex]['r_PlayerGuid'])

    if player ~= nil then
        NetEvents:SendTo('OnLevelUp', player, levelType, currentXp)
    end
    
end

function StoreAllPlayerStats()
    if #currentRankupPlayers > 0 then
        for playerIndex, cPlayer in pairs(currentRankupPlayers) do
            rankingStorageManager:StorePlayerProgress(currentRankupPlayers[playerIndex])
        end
    end
end

Events:Subscribe('Player:Score', function(player, scoringTypeData, score)
    -- local rankPlayer = PlayerManager:GetPlayerByName(playerName)

    -- if rankPlayer.name == player.name then
    --     NetEvents:Broadcast('PlayerScoreEvent', score)
    -- end
    

    if player.name == 'MJShepherd' then
        print("A SCORING EVENT HAS TRIGGERED FOR: " .. player.name)
        print("SCORE AMOUNT: " .. tostring(score))

        print('THE CURRENT PLAYER LIST IS: ')
        if #currentRankupPlayers > 0 then
            for playerIndex, cPlayer in pairs(currentRankupPlayers) do
                print(cPlayer['r_PlayerName'])
            end
        end
    end

    if player.guid ~= nil then
        PlayerXPUpdated(player, score)
    end
  getplayercount()  
end)

-- This event is used by the inflictor
Events:Subscribe('Player:Killed', function(player, inflictor, position, weapon, isRoadKill, isHeadShot, wasVictimInReviveState, info)

    if inflictor ~= nil and inflictor.name == 'MJShepherd' then
        print(player.name .. " was killed by " .. inflictor.name .. " with a " .. weapon)
    end

    -- Player was killed
    if player ~= nil and #currentRankupPlayers > 0 and player.guid ~= nil then
        for playerIndex, cPlayer in pairs(currentRankupPlayers) do
            if currentRankupPlayers[playerIndex]['r_PlayerGuid'] == player.guid then
                currentRankupPlayers[playerIndex]['r_Deaths'] = currentRankupPlayers[playerIndex]['r_Deaths'] + 1
            end
        end
    end
    
    -- Player got a kill
    if inflictor ~= nil and #currentRankupPlayers > 0 and inflictor.guid ~= nil then
        for playerIndex, cPlayer in pairs(currentRankupPlayers) do
            if currentRankupPlayers[playerIndex]['r_PlayerGuid'] == inflictor.guid then

                currentRankupPlayers[playerIndex]['r_Kills'] = currentRankupPlayers[playerIndex]['r_Kills'] + 1
                IncreaseWeaponKills(playerIndex, weapon)
            end
        end
    end
	getplayercount()
end)

end)

Events:Subscribe('Player:Created', function(player)
    -- local playerRankObject = playerRankClass(player)

    -- print("THE RECEIVED PLAYER OBJECT IS: ")
    -- print(player)

    -- table.insert(currentRankupPlayers, playerRankObject)

end)

NetEvents:Subscribe('AddNewPlayerForStats', function(player, data)
    -- local playerRankObject = playerRankClass(player)
    -- table.insert(currentRankupPlayers, playerRankObject)
    AddPlayerToRankUpList(player)

    
end)

Events:Subscribe('Player:Left', function(player)
    if #currentRankupPlayers > 0 then
        for playerIndex, cPlayer in pairs(currentRankupPlayers) do
            if cPlayer['r_PlayerGuid'] == player.guid then
                -- print("AWWW A PLAYER LEFT")
                -- print("THEY LEFT WITH " .. tostring(currentRankupPlayers[playerIndex]['r_Kills']) .. " KILLS AND WITH " .. tostring(currentRankupPlayers[playerIndex]['r_Deaths']) .. " DEATHS")
                rankingStorageManager:StorePlayerProgress(currentRankupPlayers[playerIndex])

                currentRankupPlayers[playerIndex] = nil
				getplayercount()
            end
        end
    end
end)

NetEvents:Subscribe('AddExperience', function(player, data)
    PlayerXPUpdated(player, data)
end)

NetEvents:Subscribe('AddKill', function(player, data)
    -- PlayerXPUpdated(player, data)
    if player ~= nil and #currentRankupPlayers > 0 and player.guid ~= nil then
        for playerIndex, cPlayer in pairs(currentRankupPlayers) do
            if currentRankupPlayers[playerIndex]['r_PlayerGuid'] == player.guid then
                currentRankupPlayers[playerIndex]['r_Kills'] = currentRankupPlayers[playerIndex]['r_Kills'] + 10
                IncreaseWeaponKills(playerIndex, 'M16A4')
            end
        end
    end
    
end)

Events:Subscribe('Extension:Loaded', function()
    print('Initializing VU Progression DB')
    CreateProgressionTable()
end)

Events:Subscribe('Server:RoundOver', function(roundTime, winningTeam)
    print("THE ROUND IS OVER!!! TIME TO SAVE THE CONNECTED PLAYERS' STATS!!!!")
    StoreAllPlayerStats()
end)

NetEvents:Subscribe('getinfo', function(player, data)
if player ~= nil then
   NetEvents:Broadcast('showscore', {getplayercount()})
   end
end)
function getplayercount()
local team1={}
local team2={}
local pdata={}
pdata[1]={}
pdata[2]={}

for _, player in pairs(PlayerManager:GetPlayers()) do
if player.guid ~= nil and player.onlineId and findp(player.guid) ~= nil then
playerIndex=findp(player.guid)
prank=currentRankupPlayers[playerIndex]['r_PlayerLevel']
if player.teamId == 1 then
table.insert(team1,{player.name,prank,player.kills,player.deaths,player.score,player.ping})
elseif player.teamId == 2 then
table.insert(team2,{player.name,prank,player.kills,player.deaths,player.score,player.ping})
end
else
rndping=math.random(25,150)
if player.teamId == 1 then

table.insert(team1,{player.name,145,player.kills,player.deaths,player.score,rndping})
else
table.insert(team2,{player.name,145,player.kills,player.deaths,player.score,rndping})
end
end
end
pdata[1]=team1
pdata[2]=team2
	return pdata
    end
	
function findp(ptab)
for index, data1 in pairs(currentRankupPlayers) do
    --print(index)
    for key, value in pairs(data1) do
       -- print('\t', key, value)
      if key=='r_PlayerGuid' and tostring(value) == tostring(ptab) then
        return index
      end
    end
	return null
end
end

function checkplayerinlist()
for playerIndex, cPlayer in pairs(currentRankupPlayers) do
for _, player in pairs(PlayerManager:GetPlayers()) do 
      if currentRankupPlayers[playerIndex]['r_PlayerGuid']== player.guid then
        return null
		else
		currentRankupPlayers[playerIndex] = nil
      end
    end
end
end
