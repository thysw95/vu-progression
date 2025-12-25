---------------------------------------------------------
-------------------- Main Mod Config --------------------
---------------------------------------------------------

CONFIG = {
    General = {
        -- Multiplier for how quickly you gain experience in game
        -- (Does not apply if Global Progression is enabled)
        xpMultiplier = 1,
        -- Enable verbose logging and debug commands
        -- Do not enable unless you know what you are doing!
        debug = false,
    },

    GlobalProgression = {
        -- Global Progression is a way for all servers running this mod to share player progression data.
        -- If you would like your server to be included in public global progression, or if you would like
        -- to host your own private master server, please go to the following link for instructions:
        -- https://github.com/redthirten/vu-progression-api
        -- (Progression will default to local storage if disabled, or if the server is unreachable)
        enabled = false,
        url = "",
        token = "",
    },

    UnlockNotifications = {
        -- Turn unlock notifications on or off
        enabled = true,
        -- How long (in seconds) the notification should be visible on screen
        duration = 10,
        -- Notification messages to print on screen, based on unlock type
        messages = {
            -- Message must have `%s` for Class name, followed by `%i` for new level, followed by `%s` for gear name, in that order
            levelUp = "[= PROMOTED! =]\n%s Level %i\n~ %s Unlocked ~",
            -- Message must have `%s` for weapon name, followed by `%i` for total kills, followed by `%s` for attachment name, in that order
            weapAttachUnlock = "[= WEAPON MILESTONE =]\n%s — %i Kills\n~ %s Unlocked ~",
            -- Message must have `%s` for vehicle type name, followed by `%i` for total vehicle score, followed by `%s` for unlock name, in that order
            vehicleUnlock = "[= VEHICLE MILESTONE =]\n%s — %i Vehicle Score\n~ %s Unlocked ~",
        },
        -- Sounds to play, based on unlock type
        -- Award sounds: https://github.com/VeniceUnleashed/Venice-EBX/tree/master/Sound/UI/Awards
        sounds = {
            levelUp = {
                path = "Sound/UI/Awards/UI_Award_RankUp",
                volumeMult = 3.0, -- Volume multiplier (eg. 3.0 = 300% original volume; 1.0 is fairly quiet)
            },
            weapAttachUnlock = {
                path = "Sound/UI/Awards/UI_Award_Unlock",
                volumeMult = 2.5,
            },
            vehicleUnlock = {
                path = "Sound/UI/Awards/UI_Award_RankUp",
                volumeMult = 3.0,
            },
        },
    },
}