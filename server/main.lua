local ignorePlates = {}

local function runCleanup()
    TriggerClientEvent("cz_vehiclecleanup:cleanup", -1, ignorePlates)
    ignorePlates = {}
    Framework.NotifyAll(Config.Messages.CleanupDone)
end

local function scheduleWarnings()
    local interval = Config.IntervalMinutes
    for minute, message in pairs(Config.Warnings) do
        if minute < interval then
            CreateThread(function()
                Wait((interval - minute) * 60000)
                Framework.NotifyAll(message)
            end)
        end
    end
end

CreateThread(function()
    local interval = Config.IntervalMinutes * 60000
    while true do
        scheduleWarnings()
        Wait(interval)
        runCleanup()
    end
end)


RegisterNetEvent("cz_vehiclecleanup:addIgnorePlate", function(plate)
    local src = source
    ignorePlates[plate] = true
    Framework.Notify(src, string.format(Config.Messages.PlateAddedIgnore, plate))
end)

RegisterNetEvent("cz_vehiclecleanup:noVehicle", function()
    local src = source
    Framework.Notify(src, Config.Messages.NotInVehicle)
end)


if Config.EnableForceCommand then
    Framework.RegisterCommand(Config.Commands.ForceCleanup, function(source)
        runCleanup()
        print("[VehicleCleanup] /forcevehremove executed by: " .. source)
    end, {
        permission = Config.Permissions.ForceCleanup,
        delay = Config.CommandDelay
    })
end

if Config.EnableDoNotRemoveCommand then
    Framework.RegisterCommand(Config.Commands.DoNotRemove, function(source, args)
        local plate = args[1]
        if not plate then
            TriggerClientEvent("cz_vehiclecleanup:requestPlate", source)
            return
        end
        plate = string.upper(plate)
        ignorePlates[plate] = true
        Framework.Notify(source, string.format(Config.Messages.PlateAddedIgnore, plate))
    end, {
        permission = Config.Permissions.DoNotRemove,
        delay = Config.CommandDelay
    })
end

CreateThread(function()
    Wait(500)
    print("^2[VehicleCleanup]^7 Registered Commands:")
    for _, cmd in ipairs(Framework.RegisteredCommands) do
        print("^3 - " .. cmd)
    end
end)