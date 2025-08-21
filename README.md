# vu-progression

_Reintroducing Battlefield 3’s original progression system into Venice Unleashed._

---

## 📖 About
`vu-progression` restores the classic Battlefield 3 progression mechanics to Venice Unleashed.  
Players can unlock weapons, attachments, gadgets, and ranks through gameplay, just like in the original game.  

This mod is designed for server administrators and players who want a more authentic BF3 experience.

This mod is still in early development, so some key features are still missing.

---

## ✨ Features
- Rank progression system
- Weapon unlocks based on kills and score  
- Attachment unlocks per weapon  
- Vehicle unlock progression  
- Persistent player stats (if supported by server setup)  
- Configurable progression settings for server owners  

---

## 📦 Installation
### Requirements
- [Venice Unleashed](https://veniceunleashed.net/) installed  
- A dedicated server or local server with RCON access  

### Steps
1. Download the latest release from the [Releases](./releases) page.  
2. Extract the mod into your server’s `mods` directory:
   ```bash
   Mods/vu-progression/
   ```
3. Add `vu-progression` to your server’s `modlist.txt`:
   ```
   vu-progression
   ```
4. Restart your server.  

---

## ⚙️ Configuration
The mod includes a config file (`ext/shared/config.lua`) where you can adjust:  

```lua
-- Multiplier for how quickly you gane experience in game
xpMultiplier = 1
-- Turn unlock notifications on or off
enablePlayerUnlockNotifications = true
-- Duration of how long a notifications should be visible
notificationDurationSec = 10
-- Notification must have `%s` for Class name, followed by `%i` for new level, followed by `%s` for gear name, in that order
levelUpNotification = "[= PROMOTED! =]\n%s Level %i\n~ %s Unlocked ~"
-- Award sounds: https://github.com/VeniceUnleashed/Venice-EBX/tree/master/Sound/UI/Awards
levelUpSoundPath = "Sound/UI/Awards/UI_Award_RankUp"
-- Notification must have `%s` for weapon name, followed by `%i` for total kills, followed by `%s` for attachment name, in that order
weapAttachUnlockNotification = "[= WEAPON MILESTONE =]\n%s — %i Kills\n~ %s Unlocked ~"
-- Award sounds: https://github.com/VeniceUnleashed/Venice-EBX/tree/master/Sound/UI/Awards
weapAttachUnlockSoundPath = "Sound/UI/Awards/UI_Award_Unlock"
-- Notification must have `%s` for vehicle type name, followed by `%i` for total vehicle score, followed by `%s` for unlock name, in that order
vehicleUnlockNotification = "[= VEHICLE MILESTONE =]\n%s — %i Vehicle Score\n~ %s Unlocked ~"
-- Award sounds: https://github.com/VeniceUnleashed/Venice-EBX/tree/master/Sound/UI/Awards
vehicleUnlockSoundPath = "Sound/UI/Awards/UI_Award_RankUp"
```

---

## Commands

These should be considered temporary until a proper UI can be built to view these stats.

- !level or !score (privately prints to the player all Class & General levels, score, and score required for next unlock.)
- !kills <Weapon Name> (prints number of kills for that weapon, kills required for next unlock, and what that unlock will be.)
- vs <Vehicle Type> (does the same, but for Vehicle Score.)

## 🎮 Usage
- Join a server running `vu-progression`  
- Play as usual — progression is tracked automatically  
- Unlocks and ranks are saved between sessions (if persistence is enabled)  

---

## 🛠️ Development
Want to contribute? Here’s how:  
1. Fork the repo  
2. Create a feature branch  
3. Submit a pull request  

The mod is written in [VEXT (VeniceEXT)](https://docs.veniceunleashed.net/vext/) scripting, primarily in LUA.  

---

## 🚧 Roadmap
- [ ] Global persistent tracking across multiple servers
- [ ] Add Ribbons and challenges
- [ ] Add dog tag unlocks  
- [ ] UI stats page 
- [ ] UI notifications for rank up / unlocks (like vanilla BF3)  
- [ ] Bugfixes
- [ ] Possible non-BF3 features, such as Prestige

---

## 🐞 Known Issues
- Unlock notifications are currently minimal  
- Some awards may not track properly  

---

## 🤝 Credits
- **Author**: [thysw95]
- **Contributors**:  
  - [redthirten]  

Special thanks to the [Venice Unleashed](https://veniceunleashed.net/) team and community.  

---