# Technical Modding Reference & Guides (technical.md)

This document provides a technical modding guide for Venice Unleashed (VU) development based on this progression and ribbon mod, explaining standard commands, VEXT event subscriptions, Frostbite casting mechanisms, database layout, and UI compilation.

---

## 🛠️ UI Compilation & Debugging
Venice Unleashed UI uses standard HTML/CSS/JS compiled into a single virtual container archive file named `ui.vuic` in the mod's root folder.

### Compiling WebUI:
To compile changes in the `WebUI/` folder into `ui.vuic`:
1. Use the official Venice Unleashed UI Compiler tool (`vuicc.exe`), which is distributed with the Venice Unleashed developer tools.
2. Run the compiler from your command prompt, passing the source folder and the destination file:
   ```bash
   vuicc.exe WebUI ui.vuic
   ```

### Debugging WebUI in Real-Time:
To debug or live-inspect the WebUI elements:
1. Start the Venice Unleashed client with the `-dwebui` launch argument:
   ```bash
   vu.exe -dwebui
   ```
2. While the game is running and you have joined a server, open any Chromium-based browser (like Chrome or Edge) and navigate to:
   ```
   http://localhost:8884
   ```
3. Select your mod from the list of loaded frames to open standard Chromium Developer Tools (inspect elements, view console logs, debug JS).

---

## 🏗️ Frostbite Object Downcasting (VEXT Lua)
In the Venice Unleashed Lua engine (VEXT), parameters passed to events or returned by general APIs are often wrapped as their base classes (e.g., `DataContainer`, `Asset`, `EntityData`). To access properties defined on derived subclasses, you **must** explicitly downcast them using the subclass constructor.

### Key Casting Examples:

1. **Scoring Type Data (Score Events)**:
   Passed as `DataContainer` to `Player:Score`. Cast to `ScoringTypeData` to retrieve the event name (`descriptionSid`):
   ```lua
   Events:Subscribe('Player:Score', function(player, scoringTypeData, score)
       local success, scoringData = pcall(ScoringTypeData, scoringTypeData)
       if success and scoringData then
           local eventSid = scoringData.descriptionSid -- e.g., "ID_SCORE_CAPTURE_FLAG"
       end
   end)
   ```
   > [!NOTE]
   > * **Savior spelling nuance:** The game engine uses British spelling for the Savior Kill event SID: `ID_SCORE_SAVIOUR`, while the ribbon config might refer to it as `Savior`. Match both.
   > * **M-COM naming nuance:** In Frostbite engine files, M-COM stations are referred to as "crates". The corresponding SIDs are `ID_SCORE_CRATE_DESTROY` and `ID_SCORE_CRATE_DEFEND`.


2. **Vehicle Entity Data (Inside Vehicle)**:
   Retrieve vehicle subclass details (such as the vehicle category `controllableType`) from the attached player controllable:
   ```lua
   if player.attachedControllable and player.attachedControllable.data then
       local vehicleEntityData = VehicleEntityData(player.attachedControllable.data)
       local vehicleCategory = vehicleEntityData.controllableType -- e.g., "Air", "Land", "Transport"
   end
   ```

3. **Venice Soldier Customization Asset (Player Kit)**:
   Access customization configurations to retrieve the kit SID (`labelSid`):
   ```lua
   local selectedKit = player.customization
   if selectedKit ~= nil then
       local veniceSoldierAsset = VeniceSoldierCustomizationAsset(selectedKit)
       local kitName = veniceSoldierAsset.labelSid -- e.g., "ID_M_ASSAULT", "ID_M_ENGINEER"
   end
   ```

---

## 📡 Essential VEXT Server Event Hooks
The following are the core VEXT server events used for progression and stats tracking.

### 1. `Player:Score`
Fired when a player receives points for any action (kills, heals, flag capture, etc.).
```lua
Events:Subscribe('Player:Score', function(player, scoringTypeData, score)
    -- player: Player object
    -- scoringTypeData: DataContainer (needs casting to ScoringTypeData)
    -- score: int (points awarded)
end)
```

### 2. `Player:Killed`
Fired when a player is killed. Used for weapon tracking, ribbons, and streak calculation.
```lua
Events:Subscribe('Player:Killed', function(player, inflictor, position, weapon, isRoadKill, isHeadShot, wasVictimInReviveState, info)
    -- player: Player (victim)
    -- inflictor: Player (killer, can be nil or player itself)
    -- weapon: string (asset path, e.g. "Weapons/M16A4/M16A4")
    -- isRoadKill: bool
    -- isHeadShot: bool
    -- wasVictimInReviveState: bool
    -- info: DamageInfo
end)
```

### 3. `Level:Loaded`
Fired when a map finishes loading. Used to initialize and reset round-based tables.
```lua
Events:Subscribe('Level:Loaded', function(levelName, gameMode, round, roundsPerMap)
    -- Reset round states
end)
```

### 4. `Server:RoundOver`
Fired when the current round terminates.
```lua
Events:Subscribe('Server:RoundOver', function(roundTime, winningTeam)
    -- Award MVP / Acesquad ribbons and save database progress
end)
```

---

## 🎮 Battlefield 3 Console & RCON Commands
Common Battlefield 3 admin/RCON commands useful for debugging or managing servers.

### Game Mode & Tickets:
* `vars.gamemodecounter <value>` — Sets the ticket multiplier percentage (default `100`).
* `vars.tickets <teamId> <amount>` — Directly updates the tickets for a specific team.
* `admin.say "<message>" <subset>` — Send message to all/team/squad/player.
* `mapList.list` — Retrieve the list of active maps in rotation.
* `mapList.runNextRound` — Skips the current round and proceeds to the next map.

### Mod Debugging (Client Console `~`):
* `vu.modlist` — Prints all currently running client mods.
* `render.drawfps 1` — Enables the standard FPS counter.
* `ui.drawenable 0` — Hides the entire game HUD (useful for screenshots/cinematics).

---

## 🗄️ Database SQLite Schema
The local database stores player ranks and ribbon progress. If `CONFIG.GlobalProgression.enabled` is false, it uses SQLite file in `SQLite/progression.db`.

### Progression Schema:
```sql
CREATE TABLE IF NOT EXISTS player_progression (
    r_PlayerGuid TEXT PRIMARY KEY,
    r_PlayerName TEXT,
    r_PlayerLevel INTEGER DEFAULT 0,
    r_PlayerCurrentXP INTEGER DEFAULT 0,
    r_AssaultLevel INTEGER DEFAULT 0,
    r_AssaultCurrentXP INTEGER DEFAULT 0,
    r_EngineerLevel INTEGER DEFAULT 0,
    r_EngineerCurrentXP INTEGER DEFAULT 0,
    r_SupportLevel INTEGER DEFAULT 0,
    r_SupportCurrentXP INTEGER DEFAULT 0,
    r_ReconLevel INTEGER DEFAULT 0,
    r_ReconCurrentXP INTEGER DEFAULT 0,
    r_Kills INTEGER DEFAULT 0,
    r_Deaths INTEGER DEFAULT 0,
    r_WeaponProgressList TEXT,
    r_RibbonList TEXT -- Stored as a serialized CSV blob matching RibbonConfig keys: "Key:Count,Key:Count"
);
```
