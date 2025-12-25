require("__shared/config")
require("__shared/Version")
require('lib/csv')

local API_TIMEOUT = 5 -- Timeout (sec)
-- Server loading state that will trigger net storage init/auth.
-- (ie. The earliest time `RCON:GetServerGuid()` can reliably be called)
local INIT_STORAGE_EVENT_STATE = 'Registering entity resources'
-- Maps Net Storage keys to PlayerRank keys
local KEY_MAP = {
    kills               = 'r_Kills',
    deaths              = 'r_Deaths',
    total_level         = 'r_PlayerLevel',
    total_xp            = 'r_PlayerCurrentXP',
    assault_level       = 'r_AssaultLevel',
    assault_xp          = 'r_AssaultCurrentXP',
    engineer_level      = 'r_EngineerLevel',
    engineer_xp         = 'r_EngineerCurrentXP',
    support_level       = 'r_SupportLevel',
    support_xp          = 'r_SupportCurrentXP',
    recon_level         = 'r_ReconLevel',
    recon_xp            = 'r_ReconCurrentXP',
    weapon_progression  = 'r_WeaponProgressList',
    vehicle_progression = 'r_VehicleProgressList'
}


-- Class that manages Global Progression storage over the net
local NetStorage = class('NetStorage')

function NetStorage:__init()
    self.authed = false
    self._httpOptions = nil
    self._curRoundID = -1
    
    if string.ends(CONFIG.GlobalProgression.url, "/") then
        CONFIG.GlobalProgression.url = string.sub(CONFIG.GlobalProgression.url, 1, -2)
    end

    self._loadingEvent = Events:Subscribe('Level:LoadingInfo', self, self._onLoadingEvent)
    if RCON:GetServerGuid() ~= nil then -- Mod reload; need to force re-init
        self:_onLoadingEvent(INIT_STORAGE_EVENT_STATE)
    end
end

function NetStorage:_onLoadingEvent(state)
    if (state == INIT_STORAGE_EVENT_STATE) then
        print('Initializing VU Progression Net Storage')

        -- Init HttpOptions
        self._httpOptions = HttpOptions(
            {
                ["Content-Type"] = "application/json",
                ["X-API-TOKEN"] = CONFIG.GlobalProgression.token,
                ["X-SERVER-GUID"] = RCON:GetServerGuid():ToString('N')
            },
            API_TIMEOUT
        )

        -- Check min mod version
        local res = Net:GetHTTP(
            CONFIG.GlobalProgression.url,
            self._httpOptions
        )
        if not self:_isValidResponse(res) then
            -- API is inaccessible; retry next level load
            return
        end
        local tbl = json.decode(res.body)
        local xpMultiplier = tbl.xpMultiplier
        if VERSION.Major < tbl.minModVerSupported.Major
            or VERSION.Minor < tbl.minModVerSupported.Minor
            or VERSION.Patch < tbl.minModVerSupported.Patch
        then -- Mod outdated
            local s_minVer = "v"..tbl.minModVerSupported.Major.."."..tbl.minModVerSupported.Minor.."."..tbl.minModVerSupported.Patch
            print("YOU MUST UPDATE THIS MOD TO AT LEAST " .. s_minVer .. " BEFORE USING GLOBAL PROGRESSION!")
            print("Defaulting to local storage...")
            self._loadingEvent:Unsubscribe() -- Fatal; don't try again
            return
        end
        
        -- Check auth
        local res = Net:GetHTTP(
            CONFIG.GlobalProgression.url .. "/auth/check",
            self._httpOptions
        )
        if not self:_isValidResponse(res) then
            -- API is inaccessible; retry next level load
            return
        end
        if res.status ~= 200 then -- Auth error
            print("Defaulting to local storage...")
            self._loadingEvent:Unsubscribe() -- Fatal; don't try again
            return
        end

        print("Successfully authenticated with Global Progression server!")
        CONFIG.General.xpMultiplier = xpMultiplier
        self.authed = true
        self._loadingEvent:Unsubscribe()
    end
end

function NetStorage:_isValidResponse(res, errPrefix)
    if errPrefix == nil then
        errPrefix = "GLOBAL PROGRESSION ERROR: "
    end
    -- Check if response exists
    if not res or not res.body then
        print(errPrefix .. "No response (Master server down?)")
        return false
    end
    -- Check for error response and print it if present
    if res.status >= 400 then
        print(errPrefix .. json.decode(res.body).error)
    end
    -- Print status code and body if debugging
    if CONFIG.General.debug then
        print("API Response: " .. res.status .. " " .. res.body)
    end
    return true
end

function NetStorage:_remapData(src, dest, toNet)
    for k, v in pairs(KEY_MAP) do
        if toNet then -- To Net keys
            -- Weapon prog. special case
            if v == 'r_WeaponProgressList' then
                dest[k] = tableListToCSV(src[v], 'weaponName', 'kills')
            -- Vehicle prog. special case
            elseif v == 'r_VehicleProgressList' then
                dest[k] = tableListToCSV(src[v], 'typeName', 'score')
            else
                dest[k] = src[v]
            end
        else -- To PlayerRank keys
            -- Weapon prog. special case
            if k == 'weapon_progression' then
                dest[v] = csvToTableList(src[k], 'weaponName', 'kills')
            -- Vehicle prog. special case
            elseif k == 'vehicle_progression' then
                dest[v] = csvToTableList(src[k], 'typeName', 'score')
            else
                dest[v] = math.floor(src[k]) -- Convert ambiguous floats to ints
            end
        end
    end
end

function NetStorage:newRound(levelName, gameMode)
    local serverSettings = ResourceManager:GetSettings("ServerSettings")
    serverSettings = ServerSettings(serverSettings)
    local data = {
        server_name = serverSettings.serverName,
        gamemode = gameMode,
        map = levelName
    }
    Net:PostHTTPAsync(
        CONFIG.GlobalProgression.url .. "/rounds",
        json.encode(data),
        self._httpOptions,
        function(res)
            if self:_isValidResponse(res) and res.status == 201 then
                self._curRoundID = json.decode(res.body).id
            else
                self._curRoundID = -1
            end
        end
    )
end

function NetStorage:finalizeRound(numPlayers, roundTime, winningTeam)
    local data = {
        num_players = PlayerManager:GetPlayerCount(),
        winning_team_id = winningTeam,
        duration = roundTime
    }
    Net:PatchHTTPAsync(
        CONFIG.GlobalProgression.url .. "/rounds/" .. self._curRoundID,
        json.encode(data),
        self._httpOptions,
        function(res) self:_isValidResponse(res) end
    )
end

function NetStorage:fetchPlayerProgress(playerRankObject, callback)
    Net:GetHTTPAsync(
        CONFIG.GlobalProgression.url .. "/players/" .. playerRankObject.r_PlayerGuidStr .. "/progression",
        self._httpOptions,
        function(res)
            if self:_isValidResponse(res) and res.status == 200 then
                self:_remapData(
                    json.decode(res.body),
                    playerRankObject,
                    false -- To PlayerRank keys
                )
            end
            callback()
        end
    )
end

function NetStorage:storePlayerProgress(playerRankObject, callback)
    -- Closure & nil check of GUID
    -- (Still not sure if parameters in async functions are evaluated async as well)
    local s_guid = playerRankObject.r_PlayerGuidStr
    if not s_guid then
        print("FAILED TO SAVE " .. playerRankObject.r_Player.name .. " data globally: GUID is nil!")
        callback(false)
        return
    end

    -- Build API-compliant data table
    local data = {}
    self:_remapData(
        playerRankObject,
        data,
        true -- To Net keys
    )
    -- Add extra required data
    data.name = playerRankObject.r_Player.name -- Name needs to be added in case of new player
    data.server_round_id = self._curRoundID
    data.team_id = playerRankObject.r_Player.teamId
    data.squad_id = playerRankObject.r_Player.squadId
    -- Post player data to API
    Net:PostHTTPAsync(
        CONFIG.GlobalProgression.url .. "/players/" .. s_guid .. "/progression",
        json.encode(data),
        self._httpOptions,
        function(res)
            local isValidResponse = self:_isValidResponse(
                res,
                "FAILED TO SAVE " .. data.name .. " data globally: "
            )
            if isValidResponse and (res.status == 200 or res.status == 201) then
                callback(true)
            else
                callback(false)
            end
        end
    )
end

return NetStorage
