require("__shared/config")
require("__shared/Version")
local json = require('lib/json')

local API_TIMEOUT = 5 -- Timeout (sec)
-- Server loading state that will trigger net storage init/auth.
-- (ie. The earliest time `RCON:GetServerGuid()` can reliably be called)
local INIT_STORAGE_EVENT_STATE = 'Registering entity resources'


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
        print("Defaulting to local storage...")
        return false
    end
    return true
end

function NetStorage:fetchPlayerProgress(playerRankObject, callback)
    playerRankObject['r_PlayerCurrentXP'] = 123
    callback()
end

function NetStorage:storePlayerProgress(playerRankObject)
    
end

return NetStorage
