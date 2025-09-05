require('lib/csv')


-- Class that handles local SQLite storage
local LocalStorage = class('LocalStorage')

function LocalStorage:__init()
    print('Initializing VU Progression Local Storage')
    self._initDB()
    self._patchDB()
end

function LocalStorage:__gc()
    print('Closing VU Progression Local Storage')
    SQL:Close()
end

function LocalStorage:_initDB()
    if not SQL:Open() then
        print("Local SQLite DB could not be opened!")
        return
    end

    local query = [[
    CREATE TABLE IF NOT EXISTS player_rankings_table (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        player_name TEXT,
        player_guid TEXT,
        player_kills INTEGER,
        player_deaths INTEGER,
        player_level INTEGER,
        player_current_xp INTEGER,
        player_assault_level INTEGER,
        player_assault_current_xp INTEGER,
        player_engineer_level INTEGER,
        player_engineer_current_xp INTEGER,
        player_support_level INTEGER,
        player_support_current_xp INTEGER,
        player_recon_level INTEGER,
        player_recon_current_xp INTEGER,
        weapon_progression BLOB,
        vehicle_progression BLOB
    )
    ]]
    if not SQL:Query(query) then
        print('Failed to execute query: ' .. SQL:Error())
        return
    end
end

function LocalStorage:_patchDB()
    local response = SQL:Query('SELECT * FROM player_rankings_table LIMIT 1')
    if response == nil or #response ~= 1 or response[1] == nil then return end
    
    -- Add vehicle_progression if missing
    if response[1]['vehicle_progression'] == nil then
        print("Missing 'vehicle_progression' column detected. Patching DB to include it...")
        if not SQL:Query('ALTER TABLE player_rankings_table ADD COLUMN vehicle_progression BLOB') then
            print('Failed to execute query: ' .. SQL:Error())
        end
    end
end

-- Injects progression data into a given default playerRankObject if player is present in DB
function LocalStorage:fetchPlayerProgress(playerRankObject)
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

function LocalStorage:storePlayerProgress(playerRankObject)
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

return LocalStorage
