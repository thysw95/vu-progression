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
- Weapon unlocks based on score
- Attachment unlocks per weapon based on kills
- Vehicle unlock progression
- Persistent player stats across all servers (req. opt-in approval; see below for details)
- Configurable progression settings for server owners

> [!TIP]
> If you would like your VU server to be included in public global progression, please visit [this wiki page](https://github.com/redthirten/vu-progression-api/wiki/Public-Global-Progression) for instructions to apply.\
> \
> The mod will default to local storage if you prefer not to participate.

---

## 📦 Installation
### Requirements
- [Venice Unleashed](https://veniceunleashed.net/) installed
- A dedicated server or local server

### Steps
1. Download the latest release from the [Releases](https://github.com/thysw95/vu-progression/releases) page.
2. Extract the mod into your server’s `mods` directory. The folder structure should look like this:
    ```bash
    instance/
    └── Admin/
        └── Mods/
            └── vu-progression/
                ├── ext/
                └── mod.json
    ```
3. Add `vu-progression` to your server’s `ModList.txt`:
   ```
   vu-progression
   ```
4. (Optional) Adjust config files (see below for details).
5. Restart your server.

---

## ⚙️ Configuration
The mod includes a general config file at `ext/shared/config.lua` where you can adjust various settings. Advanced users can adjust additional config files under `/ext/shared/Progression` if they wish to have non-vanilla unlock requirements (useful if you want to make progression less grindy).

---

## 💬 Chat Commands

These should be considered temporary until a proper UI can be built to view these stats.

- `!level` or `!score`: Privately prints to the player all Class & General levels, score, and score required for next unlock.
- `!kills <Weapon Name>`: Prints number of kills for that weapon, kills required for next unlock, and what that unlock will be.
- `!vs <Vehicle Type>`: Does the same, but for Vehicle Score.

## 🎮 Usage
- Join a server with a `progression` mod tag
- Play as usual — progression is tracked automatically
- Unlocks and ranks are saved between rounds or if you leave the server

---

## 🛠️ Development
Want to contribute? Here’s how:
1. Fork the repo
2. Create a feature branch
3. Submit a pull request to the `dev` branch

The mod is written in [VEXT (VeniceEXT)](https://docs.veniceunleashed.net/vext/) scripting, primarily in LUA.

---

## 🚧 Roadmap
- [x] Global persistent tracking across multiple servers
- [ ] Add Ribbons and Assignments
- [ ] Add dog tag unlocks
- [ ] UI stats page 
- [ ] UI notifications for rank up / unlocks (like vanilla BF3)
- [ ] Bugfixes
- [ ] Possible non-BF3 features, such as Prestige

---

## 🐞 Known Issues
- Unlock notifications are currently minimal. 
- Some awards (like Assignment-based unlocks) may not track properly or have arbitrary/placeholder XP/kill requirements.

---

## 🤝 Credits
- **Author**: [thysw95](https://github.com/thysw95)
- **Contributors**:
  - [Red-Thirten](https://github.com/redthirten)
- Additional thanks to [Doc-ice](https://github.com/Doc-ice) for keeping the mod going on the side!

Special thanks to the [Venice Unleashed](https://veniceunleashed.net/) team and community.

---
