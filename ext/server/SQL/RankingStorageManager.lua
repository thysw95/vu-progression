local RankingStorageManager = class('RankingStorageManager')

function RankingStorageManager:StorePlayerProgress(playerRankObject)

    print("STORING PLAYER RANKING DETAILS.")
    print("PLAYER TO ADD TO DB: ")
    print(playerRankObject['r_PlayerName'])


    local existingPlayers = SQL:Query('SELECT * FROM player_rankings_table WHERE player_guid = ?', tostring(playerRankObject['r_PlayerGuid']))
    local foundPlayer = false;

    if #existingPlayers > 0 then
        foundPlayer = true
        print("IVE FOUND A PLAYER!!!!")
    end

    local query = ""
    local weaponTable = WeaponsToString(playerRankObject['r_WeaponProgressList'])

    if foundPlayer == false then
        query = "INSERT INTO player_rankings_table (player_name, player_guid, player_kills, player_deaths, player_level, player_current_xp, player_assault_level, player_assault_current_xp, player_engineer_level, player_engineer_current_xp, player_support_level, player_support_current_xp, player_recon_level, player_recon_current_xp, weapon_progression) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)"
        
        if not SQL:Query(query, playerRankObject['r_PlayerName'], tostring(playerRankObject['r_PlayerGuid']), playerRankObject['r_Kills'], playerRankObject['r_Deaths'], playerRankObject['r_PlayerLevel'], playerRankObject['r_PlayerCurrentXP'], playerRankObject['r_AssaultLevel'], playerRankObject['r_AssaultCurrentXP'], playerRankObject['r_EngineerLevel'], playerRankObject['r_EngineerCurrentXP'], playerRankObject['r_SupportLevel'], playerRankObject['r_SupportCurrentXP'], playerRankObject['r_ReconLevel'], playerRankObject['r_ReconCurrentXP'], weaponTable) then
            print('Failed to execute query: ' .. SQL:Error())
            return
        end

        print("SUCCESSFULLY CREATED A NEW PLAYER IN DB")
    else
        query = "UPDATE player_rankings_table SET player_kills = ?, player_deaths = ?, player_level = ?, player_current_xp = ?, player_assault_level = ?, player_assault_current_xp = ?, player_engineer_level = ?, player_engineer_current_xp = ?, player_support_level = ?, player_support_current_xp = ?, player_recon_level = ?, player_recon_current_xp = ?, weapon_progression = ? WHERE player_guid = ?"

        print('HAWWO WEAPON TABLE!!!!!!!!!!')
        if #playerRankObject['r_WeaponProgressList'] > 0 then
            for _, weapon in pairs(playerRankObject['r_WeaponProgressList']) do
                if weapon['weaponName'] == "M16A4" then
                    print(weapon)
                end
            end
        end

        if not SQL:Query(query, playerRankObject['r_Kills'], playerRankObject['r_Deaths'], playerRankObject['r_PlayerLevel'], playerRankObject['r_PlayerCurrentXP'], playerRankObject['r_AssaultLevel'], playerRankObject['r_AssaultCurrentXP'], playerRankObject['r_EngineerLevel'], playerRankObject['r_EngineerCurrentXP'], playerRankObject['r_SupportLevel'], playerRankObject['r_SupportCurrentXP'], playerRankObject['r_ReconLevel'], playerRankObject['r_ReconCurrentXP'], weaponTable, tostring(playerRankObject['r_PlayerGuid'])) then
            print('Failed to execute query: ' .. SQL:Error())
            return
        end

        print("SUCCESSFULLY UPDATED EXISTING PLAYER DATA")
    end

end

-- id INTEGER PRIMARY KEY AUTOINCREMENT,
--         player_name TEXT,
--         player_guid TEXT,
--         player_kills INTEGER,
--         player_deaths INTEGER,
--         player_level INTEGER,
--         player_current_xp INTEGER,
--         player_assault_level INTEGER,
--         player_assault_current_xp INTEGER,
--         player_engineer_level INTEGER,
--         player_engineer_current_xp INTEGER,
--         player_support_level INTEGER,
--         player_support_current_xp INTEGER,
--         player_recon_level INTEGER,
--         player_recon_current_xp INTEGER,
--         weapon_progression BLOB

-- This functions retrieves the progress data of a given player, if they are stored in the DB. Else, return the given object
function RankingStorageManager:FetchPlayerProgress(playerRankObject)
    local existingPlayers = SQL:Query('SELECT * FROM player_rankings_table WHERE player_guid = ?', tostring(playerRankObject['r_PlayerGuid']))
    local returnPlayer = playerRankObject

    if #existingPlayers > 0 then
        print("FOUND THE CONNECTED PLAYER IN THE DB!!!!")
        if existingPlayers[1] ~= nil then
            print("YUMMMMYYYYYYYYYYYYYYYYYYY")

            returnPlayer['r_Kills'] = existingPlayers[1]['player_kills']
            returnPlayer['r_Deaths'] = existingPlayers[1]['player_deaths']
            returnPlayer['r_PlayerLevel'] = existingPlayers[1]['player_level']
            returnPlayer['r_PlayerCurrentXP'] = existingPlayers[1]['player_current_xp']
            returnPlayer['r_AssaultLevel'] = existingPlayers[1]['player_assault_level']
            returnPlayer['r_AssaultCurrentXP'] = existingPlayers[1]['player_assault_current_xp']
            returnPlayer['r_EngineerLevel'] = existingPlayers[1]['player_engineer_level']
            returnPlayer['r_EngineerCurrentXP'] = existingPlayers[1]['player_engineer_current_xp']
            returnPlayer['r_SupportLevel'] = existingPlayers[1]['player_support_level']
            returnPlayer['r_SupportCurrentXP'] = existingPlayers[1]['player_support_current_xp']
            returnPlayer['r_ReconLevel'] = existingPlayers[1]['player_recon_level']
            returnPlayer['r_ReconCurrentXP'] = existingPlayers[1]['player_recon_current_xp']

            returnPlayer['r_WeaponProgressList'] = string_to_table(existingPlayers[1]['weapon_progression'])
            -- returnPlayer['r_WeaponProgressList'] = loadstring("return " .. existingPlayers[1]['weapon_progression'])()

            print("THE RETURNING WEAPON PROGRESSION IS: ")
            -- if #returnPlayer['r_WeaponProgressList'] > 0 then
            --     for _, w in pairs(returnPlayer['r_WeaponProgressList']) do
            --         print(w)
            --     end
            -- end
            print(returnPlayer['r_WeaponProgressList'])

            return returnPlayer
        end
    end

    return playerRankObject
end

function WeaponsToString(tbl)
    local outString = ""

    if #tbl > 0 then
        for _, item in pairs(tbl) do
            outString = outString .. tostring(item['weaponName']) .. "," .. tostring(item['kills']) .. ","
        end
    end

    return outString
end

function table_to_string(tbl)
    local result = ""
    for k, v in pairs(tbl) do
        -- Check the key type (ignore any numerical keys - assume its an array)
        if type(k) == "string" then
            result = result.."[\""..k.."\"]".."="
        end

        -- Check the value type
        if type(v) == "table" then
            result = result..table_to_string(v)
        elseif type(v) == "boolean" then
            result = result..tostring(v)
        else
            result = result.."\""..v.."\""
        end
        result = result..","
    end
    -- Remove leading commas from the result
    if result ~= "{" then
        result = result:sub(1, result:len()-1)
    end
    return result..""
end

function split(inputstr, sep)
    if sep == nil then
        sep = "%s"
    end
    local t={}
    for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
            table.insert(t, str)
    end
    return t
end

function string_to_table(inputstr)
    outputtable = {}
    
    splittedStr = split_with_comma(inputstr)
    itemIndex = 0
    weaponStr = ""
    kills = 0

    if #splittedStr > 0 then
        for _, str in pairs(splittedStr) do
            -- if string.find(str, "kills") then
            --     tableIndex = tableIndex + 1
            --     -- table.insert(outputtable, {})
            -- end
            if itemIndex == 1 then
                kills = tonumber(str)
                table.insert(outputtable, {
                    ['weaponName'] = weaponStr,
                    ['kills'] = kills
                })

                itemIndex = 0
            else
                weaponStr = str
                itemIndex = 1
            end
            -- table.insert(outputtable, {str})
            -- print(str)
        end
    end

    return outputtable
end

function split_with_comma(str)
    local fields = {}
    for field in str:gmatch('([^,]+)') do
      fields[#fields+1] = field
    end
    return fields
end

return RankingStorageManager
