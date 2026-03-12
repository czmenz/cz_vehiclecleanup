# cz_vehiclecleanup

<p align="center">
  <img src="https://img.shields.io/badge/FiveM-Ready-orange?style=for-the-badge">
  <img src="https://img.shields.io/badge/Framework-Standalone-success?style=for-the-badge">
  <img src="https://img.shields.io/badge/Version-1.0.0-blue?style=for-the-badge">
</p>

<p align="center">
  <strong>cz_vehiclecleanup</strong> is a lightweight vehicle cleanup system for FiveM that automatically removes unused vehicles and allows players to protect their vehicles with a simple command. Fully configurable, with support for ESX, QBCore, and standalone frameworks.
</p>

---

## ✨ Features

- 🚗 **Automatic Vehicle Cleanup:** Removes unoccupied vehicles at configurable intervals.
- 🛡️ **Do Not Remove Command:** Players can protect their vehicles from the next cleanup using `/donotremove [plate]`.
- ⏱️ **Customizable Warnings:** Send notifications at any number of minutes before cleanup (e.g., 10, 5, 1 minute).
- 🔧 **Command Permissions & Delay:** Control who can use `/forcevehremove` or `/donotremove` and set cooldowns.
- 🌐 **Framework Detection:** Automatically detects ESX, QBCore, or standalone.
- 📢 **Built-in Notifications:** Uses internal notification function, no external dependency required.
- 🕊️ **Lightweight & Efficient:** Optimized to run without lag, handles many vehicles safely.

---

## 🧱 Framework

- ✅ Standalone
- 📦 ESX
- 📢 QB-CORE

---

## 📦 Installation

1. Place the `cz_vehiclecleanup` resource in your `resources` directory.

2. Add to `server.cfg`:
```cfg
ensure cz_vehiclecleanup
````

---

## 🎛️ Commands

| Command                | Description                                       | Permission   | Cooldown (ms) |
| ---------------------- | ------------------------------------------------- | ------------ | ------------- |
| `/forcevehremove`      | Forces immediate cleanup of all eligible vehicles | Configurable | Configurable  |
| `/donotremove [plate]` | Protect your vehicle from the next cleanup        | Configurable | Configurable  |

* `/donotremove` automatically detects the plate of the vehicle you're in if you don’t specify one.

---

## 📄 Configuration

Key config options are located in `config.lua`:

```lua
Config.IntervalMinutes = 30 -- How often cleanup runs
Config.Warnings = {
    [10] = "Vehicles will be removed in 10 minutes.",
    [5]  = "Vehicles will be removed in 5 minutes.",
    [1]  = "Vehicles will be removed in 1 minute."
}
Config.Commands = {
    ForceCleanup = "forcevehremove",
    DoNotRemove = "donotremove"
}
Config.Permissions = {
    ForceCleanup = "admin",  -- empty = anyone
    DoNotRemove = ""
}
Config.CommandDelay = 5000 -- Cooldown for commands
Config.NotifyTitle = "Vehicles"
```

* You can add/remove warning minutes freely using `Config.Warnings`.
* Permissions are configurable per command. Empty = accessible to all players.

---

## 🧩 Usage

### Server-Side Events

* Force cleanup from server or admin scripts:

```lua
TriggerEvent("cz_vehiclecleanup:forceCleanup")
```

* Add a plate to ignore list programmatically:

```lua
TriggerEvent("cz_vehiclecleanup:addIgnorePlate", "ABC123")
```

### Client-Side

* If a player uses `/donotremove` in a vehicle, the vehicle’s plate is automatically detected.
* If the player is not in a vehicle, they must provide the plate manually.

---

## 📜 License & Usage Rules

This project is open source for learning, modifying, and use on servers.

### ✔ You are allowed to:

* Use it in private/public servers.
* Modify it for your own needs.
* Share improvements with credit.

### ❌ You are not allowed to:

* Sell this resource (original or modified).
* Re-upload and claim authorship.
* Remove original author credit.

---

**Author:** Czmenz
