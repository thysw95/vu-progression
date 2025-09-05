require("__shared/config")
local LocalStorage = require('StorageManager/LocalStorage')
local NetStorage = require('StorageManager/NetStorage')


-- Class that brokers storage calls between the main program and the appropriate storage method(s).
local StorageManager = class('StorageManager')

function StorageManager:__init()
    self.localStorage = LocalStorage()
    self.netStorage = NetStorage()
end

function StorageManager:fetchPlayerProgress(playerRankObject)
    return self.localStorage:fetchPlayerProgress(playerRankObject)
end

function StorageManager:storePlayerProgress(playerRankObject)
    return self.localStorage:storePlayerProgress(playerRankObject)
end

return StorageManager
