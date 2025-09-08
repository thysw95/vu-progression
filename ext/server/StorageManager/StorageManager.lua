require("__shared/config")
local LocalStorage = require('StorageManager/LocalStorage')
local NetStorage = require('StorageManager/NetStorage')
local playerRankClass = require('__shared/PlayerRank')


-- Class that brokers storage calls between the main program and the appropriate storage method(s).
local StorageManager = class('StorageManager')

function StorageManager:__init()
    self.localStorage = LocalStorage()
    if CONFIG.GlobalProgression.enabled then
        self.netStorage = NetStorage()
    end
end

function StorageManager:fetchPlayerProgress(player, callback)
    local localPlayerRankObj = playerRankClass(player)
    localPlayerRankObj = self.localStorage:fetchPlayerProgress(localPlayerRankObj)

    if CONFIG.GlobalProgression.enabled and self.netStorage.authed then
        local netPlayerRankObj = playerRankClass(player)
        self.netStorage:fetchPlayerProgress(netPlayerRankObj, function()
            -- print("LOCAL XP: " .. localPlayerRankObj['r_PlayerCurrentXP'])
            -- print("NET XP: " .. netPlayerRankObj['r_PlayerCurrentXP'])
            callback(localPlayerRankObj)
        end)
    else
        -- Net storage not available, just return local rank object
        callback(localPlayerRankObj)
    end
end

function StorageManager:storePlayerProgress(playerRankObject)
    return self.localStorage:storePlayerProgress(playerRankObject)
end

return StorageManager
