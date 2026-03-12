Config = {}

-- COMMAND SETTINGS
Config.Commands = {
    ForceCleanup = "forcevehremove",
    DoNotRemove = "donotremove"
}

Config.EnableForceCommand = true
Config.EnableDoNotRemoveCommand = true
Config.CommandDelay = 5000 -- (MS)

Config.Permissions = {
    ForceCleanup = "admin",
    DoNotRemove = ""
    -- prázdný = žádná permisse
    -- jinak podle ranků
}


Config.IntervalMinutes = 30
Config.NotifyTitle = "Vehicles"

Config.Messages = {
    warn10 = "Vehicles will be removed in 10 minutes. Type: /donotremove [plate] to save your vehicle",
    warn5 = "Vehicles will be removed in 5 minutes. Type: /donotremove [plate] to save your vehicle",
    warn1 = "Vehicles will be removed in 1 minute. Sit in your vehicle or type: /donotremove [plate]",
    
    
    CleanupDone = "Vehicle cleanup completed.",
    PlateAddedIgnore = "Vehicle with plate %s will be ignored in the next cleanup.",
    NotInVehicle = "Use: /donotremove [plate]"
}

Config.Warnings = {
    [10] = Config.Messages.warn10,
    [5] = Config.Messages.warn5,
    [1] = Config.Messages.warn1
}