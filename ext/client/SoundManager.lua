require('__shared/config')

local soundAssets = {} -- dictionary of prepared game sounds for further use
local playerSoundEntities = {} -- current player initialized sound entities

-- on level load
local function onLevelLoaded()
    -- load sound assets/entities when possible
    for sound, params in pairs(CONFIG.UnlockNotifications.sounds) do
        print("Loading " .. sound .. " sound...")
        local soundDataContainer = ResourceManager:SearchForDataContainer(params.path)
        if soundDataContainer == nil then
            print("Failed to find data container for path: " .. params.path)
            goto continue_loop
        end
        local soundAsset = SoundPatchConfigurationAsset(soundDataContainer)
        -- Set volume for unique config asset
        soundAsset = soundAsset:Clone()
        for k, entry in pairs(soundAsset.entries) do
            if entry:Is(SoundPatchConfigurationParameterEntry.typeInfo.name) then
                local spcpEntry = SoundPatchConfigurationParameterEntry(entry)
                if spcpEntry.nameHash == 698564572 then -- (Amplitude)
                    spcpEntry = spcpEntry:Clone()
                    spcpEntry.value = params.volumeMult
                    soundAsset.entries[k] = spcpEntry -- Replace ref with unique clone
                    break
                end
            end
        end
        soundAssets[sound] = soundAsset
        ::continue_loop::
    end
end

local function PlayUnlockSound(sound)
    local player = PlayerManager:GetLocalPlayer()
    print("Playing sound " .. sound .. " for player " .. player.name)
    -- do not continue when player soldier does not exist
    if player.soldier == nil then return end
    -- do not continue when sound does not exist
    if soundAssets[sound] == nil then
        print(sound .. ' is not a loaded sound!')
        return
    end
    -- delete old entity
    if playerSoundEntities[player.id] ~= nil then
        playerSoundEntities[player.id]:Destroy()
        playerSoundEntities[player.id] = nil
    end
    -- create entity position
    local entityPos = LinearTransform()
    -- set entity position to player position
    entityPos.trans = player.soldier.transform.trans:Clone()
    -- set entity sound a little bit higher
    entityPos.trans.y = entityPos.trans.y + 1.0 -- was 1.5
    -- create sound entity data
    local data = SoundEntityData()
    -- set entity data position to player position
    data.transform = entityPos
    data.sound = SoundAsset(soundAssets[sound])
    data.obstructionHandle = 0
    data.playOnCreation = true
    -- create entity
    local soundEntity = SoundEntity(EntityManager:CreateEntity(data, entityPos))
    -- spawn entity
    if soundEntity ~= nil then
        soundEntity:Init(Realm.Realm_Client, true)
        playerSoundEntities[player.id] = soundEntity
    end
end

-- on level destroy
local function onLevelDestroy()
    for _, entity in pairs(playerSoundEntities) do
        entity:Destroy()
    end
    playerSoundEntities = {}
end

Events:Subscribe('Level:Loaded', onLevelLoaded)
Events:Subscribe('Level:Destroy', onLevelDestroy)

NetEvents:Subscribe('PlayUnlockSound', PlayUnlockSound)

-- DEBUG
if CONFIG.General.debug then

    Console:Register('PlayUnlockSound', 'DEBUG: Plays unlock notification sound[1]', function(args)
        if #args == 1 then
            PlayUnlockSound(args[1])
        end
    end)

end