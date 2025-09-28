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
    self.localStorage:fetchPlayerProgress(localPlayerRankObj)

    if CONFIG.GlobalProgression.enabled and self.netStorage.authed then
        local netPlayerRankObj = playerRankClass(player)
        self.netStorage:fetchPlayerProgress(netPlayerRankObj, function()
            -- Return net data if the total XP is greater than local total XP,
            -- or if the total XP is exactly 1 (to allow for debug resets).
            -- print("LOCAL XP: " .. localPlayerRankObj['r_PlayerCurrentXP'])
            -- print("NET XP: " .. netPlayerRankObj['r_PlayerCurrentXP'])
            if netPlayerRankObj['r_PlayerCurrentXP'] >= localPlayerRankObj['r_PlayerCurrentXP']
                or netPlayerRankObj['r_PlayerCurrentXP'] == 1
            then
                callback(netPlayerRankObj)
            else
                print("Falling back to local progression data for " .. player.name)
                -- TODO: Notify player somehow of server being offline
                callback(localPlayerRankObj)
            end
        end)
    else
        -- Net storage not available, just return local rank object
        callback(localPlayerRankObj)
    end
end

function StorageManager:storePlayerProgress(playerRankObject)
    local localStored = self.localStorage:storePlayerProgress(playerRankObject)
    if CONFIG.GlobalProgression.enabled and self.netStorage.authed then
        self.netStorage:storePlayerProgress(playerRankObject, function(netStored)
            if netStored then
                print("SUCCESSFULLY SAVED player data globally: " .. playerRankObject['r_PlayerName'])
            elseif localStored then
                print("Failsafe: Saved player data locally: " .. playerRankObject['r_PlayerName'])
            end
        end)
    elseif localStored then
        print("SUCCESSFULLY SAVED player data locally: " .. playerRankObject['r_PlayerName'])
    end
end

function StorageManager:isNetStorageAuthed()
    if self.netStorage and self.netStorage.authed then
        return true
    else
        return false
    end
end

return StorageManager
