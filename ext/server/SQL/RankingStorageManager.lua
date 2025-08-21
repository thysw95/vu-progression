local RankingStorageManager = class('RankingStorageManager')

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
--         vehicle_progression BLOB

-- This functions retrieves the progress data of a given player, if they are stored in the DB. Else, return the given object
function RankingStorageManager:FetchPlayerProgress(playerRankObject)
    local existingPlayers = SQL:Query(
        'SELECT * FROM player_rankings_table WHERE player_guid = ?',
        tostring(playerRankObject['r_PlayerGuid'])
    )
    local returnPlayer = playerRankObject

    if existingPlayers ~= nil and #existingPlayers > 0 and existingPlayers[1] ~= nil then
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

        returnPlayer['r_WeaponProgressList'] = csvToTableList(
            existingPlayers[1]['weapon_progression'],
            'weaponName',
            'kills'
        )
        -- returnPlayer['r_WeaponProgressList'] = loadstring("return " .. existingPlayers[1]['weapon_progression'])()

        -- if #returnPlayer['r_WeaponProgressList'] > 0 then
        --     for _, w in pairs(returnPlayer['r_WeaponProgressList']) do
        --         print(w)
        --     end
        -- end

        -- New addition; need to check if nil
        if existingPlayers[1]['vehicle_progression'] ~= nil then
            returnPlayer['r_VehicleProgressList'] = csvToTableList(
                existingPlayers[1]['vehicle_progression'],
                'typeName',
                'score'
            )
        end

        return returnPlayer
    end

    return playerRankObject
end

function RankingStorageManager:StorePlayerProgress(playerRankObject)
    -- print("STORING PLAYER RANKING DETAILS.")
    -- print("PLAYER TO ADD TO DB: " .. playerRankObject['r_PlayerName'])

    local existingPlayer = SQL:Query(
        'SELECT * FROM player_rankings_table WHERE player_guid = ?',
        tostring(playerRankObject['r_PlayerGuid'])
    )

    local weaponTable = tableListToCSV(
        playerRankObject['r_WeaponProgressList'],
        'weaponName',
        'kills'
    )
    local vehicleTable = tableListToCSV(
        playerRankObject['r_VehicleProgressList'],
        'typeName',
        'score'
    )

    if #existingPlayer > 0 then -- Existing player found in DB
        local query = [[
        UPDATE player_rankings_table
        SET
            player_kills = ?,
            player_deaths = ?,
            player_level = ?,
            player_current_xp = ?,
            player_assault_level = ?,
            player_assault_current_xp = ?,
            player_engineer_level = ?,
            player_engineer_current_xp = ?,
            player_support_level = ?,
            player_support_current_xp = ?,
            player_recon_level = ?,
            player_recon_current_xp = ?,
            weapon_progression = ?,
            vehicle_progression = ?
        WHERE player_guid = ?
        ]]

        if SQL:Query(
            query,
            playerRankObject['r_Kills'],
            playerRankObject['r_Deaths'],
            playerRankObject['r_PlayerLevel'],
            playerRankObject['r_PlayerCurrentXP'],
            playerRankObject['r_AssaultLevel'],
            playerRankObject['r_AssaultCurrentXP'],
            playerRankObject['r_EngineerLevel'],
            playerRankObject['r_EngineerCurrentXP'],
            playerRankObject['r_SupportLevel'],
            playerRankObject['r_SupportCurrentXP'],
            playerRankObject['r_ReconLevel'],
            playerRankObject['r_ReconCurrentXP'],
            weaponTable,
            vehicleTable,
            tostring(playerRankObject['r_PlayerGuid'])
        ) then
            print("SUCCESSFULLY SAVED EXISTING PLAYER DATA: " .. playerRankObject['r_PlayerName'])
        else
            print('Failed to execute query: ' .. SQL:Error())
        end
        
    else -- New player to save to DB
        local query = [[
        INSERT INTO player_rankings_table (
            player_name,
            player_guid,
            player_kills,
            player_deaths,
            player_level,
            player_current_xp,
            player_assault_level,
            player_assault_current_xp,
            player_engineer_level,
            player_engineer_current_xp,
            player_support_level,
            player_support_current_xp,
            player_recon_level,
            player_recon_current_xp,
            weapon_progression,
            vehicle_progression
        )
        VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
        ]]

        if SQL:Query(
            query,
            playerRankObject['r_PlayerName'],
            tostring(playerRankObject['r_PlayerGuid']),
            playerRankObject['r_Kills'],
            playerRankObject['r_Deaths'],
            playerRankObject['r_PlayerLevel'],
            playerRankObject['r_PlayerCurrentXP'],
            playerRankObject['r_AssaultLevel'],
            playerRankObject['r_AssaultCurrentXP'],
            playerRankObject['r_EngineerLevel'],
            playerRankObject['r_EngineerCurrentXP'],
            playerRankObject['r_SupportLevel'],
            playerRankObject['r_SupportCurrentXP'],
            playerRankObject['r_ReconLevel'],
            playerRankObject['r_ReconCurrentXP'],
            weaponTable,
            vehicleTable
        ) then
            print("SUCCESSFULLY SAVED A NEW PLAYER IN DB: " .. playerRankObject['r_PlayerName'])
        else
            print('Failed to execute query: ' .. SQL:Error())
        end

    end

end

-- Converts list of tables into "val1,val2,val1,val2,..."
function tableListToCSV(tblList, key1, key2)
    local parts = {}
    for _, subtable in ipairs(tblList) do
        table.insert(parts, tostring(subtable[key1]))
        table.insert(parts, tostring(subtable[key2]))
    end
    return table.concat(parts, ",")
end

-- Converts "val1,val2,val1,val2,..." back into list of tables
-- key1 and key2 define the keys to use in each subtable
function csvToTableList(str, key1, key2)
    local tblList = {}
    local parts = {}
    for part in string.gmatch(str, "([^,]+)") do
        table.insert(parts, part)
    end

    for i = 1, #parts, 2 do
        local subtable = {}
        subtable[key1] = tonumber(parts[i]) or parts[i]
        subtable[key2] = tonumber(parts[i + 1]) or parts[i + 1]
        table.insert(tblList, subtable)
    end

    return tblList
end

return RankingStorageManager
