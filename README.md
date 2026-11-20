# XP Collector Device 2.0 (Verse - UEFN)

This repository contains a **Verse** script for **Unreal Editor for Fortnite (UEFN)**. The code modularly manages item collection mechanics, granting XP to players through *Accolades* devices and automating the respawn timers for grouped collectibles.

## 🚀 Features

- **Modular Collectible Groups:** Organize items into distinct groups directly inside the UEFN editor.
- **Per-Group Custom XP:** Assign a dedicated *Accolades* device to each collectible group to reward players with specific amounts of XP.
- **Individual Respawn Timers:** Configure a custom cooldown duration per group before collected items respawn for all players.
- **Concurrent Management:** Uses Verse's asynchronous features (`<suspends>` and `spawn`) to handle respawn timers independently for each collected item.

---

## 💻 Code Structure

The script is built around three main structures:

1. **`collectible_group` (Concrete Class):**
   - Groups a list of `collectible_object_device` instances.
   - Defines the `RespawnTime` variable (in seconds).
   - Links a dedicated `accolades_device` to the group.

2. **`xp_collector_device2` (Main Creative Device):**
   - Inherits from `creative_device`.
   - Exposes the `Groups` list so it can be configured in the editor.
   - During initialization (`OnBegin`), iterates through all groups and collectibles, subscribing to collection event handlers (`CollectedEvent`).

3. **`respawn_handler` (Helper Class):**
   - Handles the individual logic triggered when an item is collected.
   - Grants XP by calling `Accolade.Award(Collector)`.
   - Waits for the configured duration (`Sleep`) and reactivates the collectible globally (`Collectible.RespawnForAll()`).

---

## 🛠️ How to Use in UEFN

1. Create or open a project in **Unreal Editor for Fortnite**.
2. Create a new Verse script (or paste this code into an existing `.verse` file in your project).
3. Place the main device (`xp_collector_device2`) onto your island.
4. In the device's **Details** panel in the editor:
   - Add new entries to the **Groups** array.
   - Assign your *Collectible Object Devices* to each group's array.
   - Set the desired cooldown in **Respawn Time**.
   - Drag and assign the matching *Accolades Device* to the **Accolade** property.
5. Build/compile your Verse code and playtest the island in a session.
