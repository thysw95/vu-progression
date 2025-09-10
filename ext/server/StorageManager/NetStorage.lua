require("__shared/config")
require("__shared/Version")
require('lib/csv')
local json = require('lib/json')

local API_TIMEOUT = 5 -- Timeout (sec)
-- Server loading state that will trigger net storage init/auth.
-- (ie. The earliest time `RCON:GetServerGuid()` can reliably be called)
local INIT_STORAGE_EVENT_STATE = 'Registering entity resources'
-- Maps Net Storage keys to PlayerRank keys
local KEY_MAP = {
    name                = 'r_PlayerName',
    guid                = 'r_PlayerGuid',
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
            local tbl = json.decode(res.body)
            print("GLOBAL PROGRESSION ERROR " .. res.status .. ": " .. tbl.error)
            print("Defaulting to local storage...")
            self._loadingEvent:Unsubscribe() -- Fatal; don't try again
            return
        end

        print("Successfully authenticated with Global Progression server!")
        self.authed = true
        self._loadingEvent:Unsubscribe()
    end
end

function NetStorage:_isValidResponse(res)
    if not res or not res.body then
        print("CANNOT REACH GLOBAL PROGRESSION SERVER!")
        return false
    end
    if CONFIG.General.debug then
        print("API Response: " .. res.status)
    end
    return true
end

function NetStorage:_remapData(src, dest, map, toNet)
    for k, v in pairs(map) do
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
                dest[v] = src[k]
            end
        end
    end
end

function NetStorage:fetchPlayerProgress(playerRankObject, callback)
    Net:GetHTTPAsync(
        CONFIG.GlobalProgression.url .. "/players/" .. playerRankObject['r_PlayerGuid']:ToString('D'),
        self._httpOptions,
        function(res)
            if self:_isValidResponse(res) and res.status == 200 then
                self:_remapData(
                    json.decode(res.body),
                    playerRankObject,
                    KEY_MAP,
                    false -- To PlayerRank keys
                )
            end
            callback()
        end
    )
end

function NetStorage:storePlayerProgress(playerRankObject, callback)
    local data = {}
    self:_remapData(
        playerRankObject,
        data,
        KEY_MAP,
        true -- To Net keys
    )
    Net:PostHTTPAsync(
        CONFIG.GlobalProgression.url .. "/players/" .. playerRankObject['r_PlayerGuid']:ToString('D'),
        json.encode(data),
        self._httpOptions,
        function(res)
            if self:_isValidResponse(res) and res.status == 200 then
                callback(true)
            else
                local tbl = json.decode(res.body)
                print("FAILED TO SAVE " .. playerRankObject['r_PlayerName'] .. " data globally: " .. (tbl.error or "No response"))
                callback(false)
            end
        end
    )
end

return NetStorage
