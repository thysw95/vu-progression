# Ribbon System (Ribbons) in vu-progression

This document contains a description of the implemented Battlefield 3 Ribbon System for Venice Unleashed, list of modified/new files, and testing/usage instructions.

---

## 📋 Summary of Changes

A tracking system for **59 types of ribbons** has been implemented based on the official Battlefield 3 list. Players earn ribbons for achieving specific conditions during a round (kills with different weapon categories, vehicle usage, tactical support actions, teamplay, and match completion). Each ribbon has a configured base XP reward, which may be modified by the server's XP multiplier, displays a beautiful centered top-HUD WebUI notification with a premium holographic/glitch pop-up effect, and plays the original unlock sound synchronized exactly with the animation.

---

## 🛠 Architecture and Files

The following new files were added:
1. **`ext/shared/Progression/RibbonConfig.lua`**
   * *Purpose:* Stores configuration for all 59 ribbons: pretty name (`prettyName`), description (`description`), action count per round (`reqCount`), and XP reward (`xpReward`).
2. **`ext/shared/Progression/WeaponCategories.lua`**
   * *Purpose:* Helper class to map weapon assets to categories (Assault Rifles, Carbines, LMGs, Sniper Rifles, PDWs, Shotguns, Handguns, Melee). Supports exact matches and pattern/substring lookups.
3. **`WebUI/` folder**
   * *Purpose:* Custom HUD overlay using HTML/CSS/JS. Renders original-style transparent HUD popup at the top-center of the screen with smooth scaling pop-out transitions, black CRT scanline grids, moving laser sweeps, and RGB color-splitting glitches (chromatic aberration).
   * *`test.html`:* Helper developer tool to test animations and visual effects directly in any web browser without running the game.

Modified existing files:
1. **`ext/shared/PlayerRank.lua`**
   * Initializes player ribbon list counters (`r_RibbonList`) to 0 when the player rank object is initialized.
2. **`ext/server/StorageManager/LocalStorage.lua`**
   * Added `ribbon_progression` blob column to local SQLite database with automatic schema patch checking (`PRAGMA table_info` columns lookup to run `ALTER TABLE` only if column is missing, ensuring no profile reset).
   * Ribbon count data is serialized as a CSV string and saved when players disconnect or round completes.
3. **`ext/server/__init__.lua`**
   * Tracks round-based stats for each player (`roundStats`), resetting them at the start of each round (`Level:Loaded`).
   * Hooks `Player:Killed` event to track weapon class kills, vehicle types (air, land, transport, stationary), headshots (Accuracy), and kill streaks (Combat Efficiency).
   * Hooks `Player:Score` event to capture and filter VEXT score events for support awards (revives, repairs, resupplies, heals, flag capture/defend, MCOM destroy/defend, motion sensor assists, suppression assists, avengers, saviors, spawn on squad, destroy explosives).
   * Hooks `Server:RoundOver` event to award end-round ribbons: MVP (1st, 2nd, 3rd), Ace Squad (best squad overall by combined score), and game mode completion/win awards.
   * Handles chat command `!ribbons`.
4. **`ext/shared/config.lua`**
   * Configured award unlock sound path (`"Sound/UI/Awards/UI_Award_Unlock"`).
5. **`mod.json`**
   * Enabled WebUI support with `"HasWebUI": true`.
6. **`ext/client/__init__.lua`**
   * Handles WebUI initialization (`WebUI:Init()`) on `Extension:Loaded`.
   * Listens to the network event `OnRibbonAwarded` (if `CONFIG.UnlockNotifications.enabled` is active), encodes ribbon data to JSON, and calls the WebUI Javascript interface (`window.showRibbon`) to trigger HUD animations.
6. **`ext/client/SoundManager.lua`**
   * Subscribes to local client event `PlayRibbonSound` to play the award unlock sound natively on demand.

---

## 🕹 How it Works (Gameplay)

### 1. Earning Ribbons In-Game
Once a player meets a ribbon's requirement during a round (e.g., gets 7 kills with an Assault Rifle):
* The server calls `AwardRibbon(playerRank, ribbonKey)`.
* The player is awarded global XP (multiplied by the server's `xpMultiplier`).
* A message is sent to the chat: `★ [Player] earned Assault Rifle Ribbon (+200 XP) ★`.
* A yell notification appears: `★ [Player] earned Assault Rifle Ribbon (+200 XP) ★`.
* The top-center WebUI HUD displays a transparent holographic notification containing the ribbon name, horizontal ribbon icon, and XP points.
* The client plays the original award unlock sound at the exact millisecond the ribbon pops up. For multiple ribbons awarded in a row, the sound triggers sequentially as each ribbon animates onto the screen, preventing overlapping or skipped audio.
* Ribbons can be earned **multiple times per round** (e.g., 14 Assault Rifle kills will award 2 ribbons).

### 2. End-Round Summary
When a round completes, the server calculates:
* Top 3 players by score and awards them **MVP**, **MVP 2**, and **MVP 3** ribbons.
* Combined scores of all active squads. All players in the highest-scoring squad receive the **Ace Squad** ribbon.
* Game mode participation (e.g., **Conquest Ribbon**) for all players.
* Game mode victory (e.g., **Conquest Winner Ribbon**) for players in the winning team.

---

## ⌨️ Available Commands

### Chat Commands (available to everyone):
* **`!ribbons`** — Prints a list of all your earned ribbons and their total counts (accumulated and saved in the database).

### Console Commands `~` (only when `CONFIG.General.debug = true` in config.lua):
* **`PlayUnlockSound ribbon`** — Plays the ribbon unlock sound.

---

## 💾 Storage & Networking
All progress is saved in SQLite database (`ribbon_progression`). Global API networking (`NetStorage.lua`) is untouched, guaranteeing backward compatibility. Data is saved automatically on map reload or disconnect.

---

## 🎗️ Complete Ribbon List Reference
Use the **Ribbon Key** column to test specific ribbons with the debug chat command:
`!awardribbon <RibbonKey>`

### 1. Combat & Weapons
| Ribbon Key | Pretty Name | Description (Per Round) | XP Reward |
| :--- | :--- | :--- | :--- |
| `AssaultRifle` | Assault Rifle Ribbon | Kill 7 enemies with Assault Rifles | 200 |
| `LMG` | Light Machine Gun Ribbon | Kill 7 enemies with Light Machine Guns | 200 |
| `Carbine` | Carbine Ribbon | Kill 7 enemies with Carbines | 200 |
| `Handgun` | Handgun Ribbon | Kill 4 enemies with Handguns | 200 |
| `SniperRifle` | Sniper Rifle Ribbon | Kill 7 enemies with Sniper Rifles | 200 |
| `PDW` | PDW Ribbon | Kill 7 enemies with Personal Defense Weapons | 200 |
| `Shotgun` | Shotgun Ribbon | Kill 7 enemies with Shotguns | 200 |
| `Melee` | Melee Ribbon | Kill 4 enemies with Melee Weapons | 200 |
| `Accuracy` | Accuracy Ribbon | Get 5 Headshot Kills | 200 |
| `CombatEfficiency` | Combat Efficiency Ribbon | Get 3 Streak Bonuses | 500 |

### 2. Teamplay & Support
| Ribbon Key | Pretty Name | Description (Per Round) | XP Reward |
| :--- | :--- | :--- | :--- |
| `Resupply` | Resupply Efficiency Ribbon | Perform 7 Resupplies | 200 |
| `Surveillance` | Surveillance Efficiency Ribbon | Get 5 Motion Sensor Assists | 200 |
| `Medical` | Medical Efficiency Ribbon | Perform 5 Revives | 200 |
| `Maintenance` | Maintenance Efficiency Ribbon | Perform 7 Repairs | 200 |
| `SquadWipe` | Squad Wipe Ribbon | Get 2 Squad Wipe Bonuses | 200 |
| `SquadSpawn` | Squad Spawn Ribbon | Get 7 Squad Spawn Bonuses | 200 |
| `Suppression` | Suppression Ribbon | Get 4 Suppression Assists | 200 |
| `Avenger` | Avenger Ribbon | Get 2 Avenger Kills | 200 |
| `Savior` | Savior Ribbon | Get 2 Savior Kills | 200 |
| `Nemesis` | Nemesis Ribbon | Get 2 Nemesis Kills | 200 |

### 3. Objectives & Tactics
| Ribbon Key | Pretty Name | Description (Per Round) | XP Reward |
| :--- | :--- | :--- | :--- |
| `FlagAttacker` | Flag Attacker Ribbon | Get 4 Flag Captures | 200 |
| `FlagDefender` | Flag Defender Ribbon | Get 5 Flag Defends | 200 |
| `McomAttacker` | M-COM Attacker Ribbon | Destroy 2 M-COM stations | 200 |
| `McomDefender` | M-COM Defender Ribbon | Defend 2 M-COM stations | 200 |
| `AntiExplosives` | Anti Explosives Ribbon | Destroy 3 enemy Explosives | 200 |

### 4. Vehicle Warfare
| Ribbon Key | Pretty Name | Description (Per Round) | XP Reward |
| :--- | :--- | :--- | :--- |
| `DisableVehicle` | Disable Vehicle Ribbon | Disable 4 enemy Vehicles | 200 |
| `AntiVehicle` | Anti Vehicle Ribbon | Destroy 3 enemy Vehicles | 200 |
| `AirWarfare` | Air Warfare Ribbon | Kill 5 enemies with Air Vehicles | 200 |
| `ArmoredWarfare` | Armored Warfare Ribbon | Kill 7 enemies with Land Vehicles | 200 |
| `TransportWarfare` | Transport Warfare Ribbon | Kill 4 enemies with Transport Vehicles | 200 |
| `Stationary` | Stationary Emplacement Ribbon | Kill 2 enemies with Emplaced Weapons | 200 |

### 5. Match MVP & Squad Bonuses
| Ribbon Key | Pretty Name | Description (End of Round) | XP Reward |
| :--- | :--- | :--- | :--- |
| `MVP` | MVP Ribbon | Be the best Player of the round | 500 |
| `MVP2` | MVP 2 Ribbon | Be the second best Player of the round | 400 |
| `MVP3` | MVP 3 Ribbon | Be the third best Player of the round | 300 |
| `AceSquad` | Ace Squad Ribbon | Be part of the best Squad of the round | 500 |

### 6. Game Mode Completion & Victory
| Ribbon Key (Finish) | Ribbon Key (Winner) | Game Mode Name | XP (Finish/Win) |
| :--- | :--- | :--- | :--- |
| `Conquest` | `ConquestWinner` | Conquest | 200 / 500 |
| `Rush` | `RushWinner` | Rush | 200 / 500 |
| `TeamDeathmatch` | `TDMWinner` | Team Deathmatch (TDM) | 200 / 500 |
| `SquadRush` | `SquadRushWinner` | Squad Rush | 200 / 500 |
| `SquadDeathmatch` | `SquadDeathmatchWinner` | Squad Deathmatch (SQDM) | 200 / 500 |
| `TDMCQ` | `TDMCQWinner` | TDM Close Quarters (CQ) | 200 / 500 |
| `TankSuperiority` | `TankSuperiorityWinner` | Tank Superiority | 200 / 500 |
| `Scavenger` | `ScavengerWinner` | Scavenger | 200 / 500 |
| `Domination` | `DominationWinner` | Conquest Domination | 200 / 500 |
| `GunMaster` | `GunMasterWinner` | Gun Master | 200 / 500 |
| `CaptureTheFlag` | `CaptureTheFlagWinner` | Capture The Flag (CTF) | 200 / 500 |
| `AirSuperiority` | `AirSuperiorityWinner` | Air Superiority | 200 / 500 |
