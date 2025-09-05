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
- Persistent player stats (local to server; global progression coming soon!)
- Configurable progression settings for server owners

---

## 📦 Installation
### Requirements
- [Venice Unleashed](https://veniceunleashed.net/) installed
- A dedicated server or local server

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
The mod includes a config file (`ext/shared/config.lua`) where you can adjust various settings.

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
- **Author**: [thysw95](https://github.com/thysw95)
- **Contributors**:
  - [Red-Thirten](https://github.com/redthirten)
- Additional thanks to [Doc-ice](https://github.com/Doc-ice) for keeping the mod going on the side!
- **Libraries**:
  - [json.lua](https://github.com/rxi/json.lua)

Special thanks to the [Venice Unleashed](https://veniceunleashed.net/) team and community.

---