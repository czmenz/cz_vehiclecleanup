Framework = {}
Framework.Type = "standalone"
Framework.RegisteredCommands = {}
Framework.LastCommandTime = {}


CreateThread(function()
    if GetResourceState("es_extended") == "started" then
        Framework.Type = "esx"
    elseif GetResourceState("qb-core") == "started" then
        Framework.Type = "qb"
    else
        Framework.Type = "standalone"
    end

    if IsDuplicityVersion() then
        print("^2[VehicleCleanup]^7 Detected Framework: " .. Framework.Type)
    end
end)


function Framework.Notify(source, message)
    if Framework.Type == "esx" then
        local xPlayer = ESX.GetPlayerFromId(source)
        if xPlayer then
            TriggerClientEvent('esx:showNotification', source, message)
        end
    elseif Framework.Type == "qb" then
        TriggerClientEvent('QBCore:Notify', source, message, 'primary', 5000)
    else
        TriggerClientEvent('chat:addMessage', source, {
            color = {255, 0, 0},
            args = {Config.NotifyTitle or "VehicleCleanup", message}
        })
    end
end

function Framework.NotifyAll(message)
    if Framework.Type == "esx" then
        local xPlayers = ESX.GetPlayers()
        if xPlayers then
            for _, src in ipairs(xPlayers) do
                TriggerClientEvent('esx:showNotification', src, message)
            end
        end
    elseif Framework.Type == "qb" then
        local players = QBCore.Functions.GetPlayers()
        if players then
            for _, src in ipairs(players) do
                TriggerClientEvent('QBCore:Notify', src, message, 'primary', 5000)
            end
        end
    else
        TriggerClientEvent('chat:addMessage', -1, {
            color = {255, 0, 0},
            args = {Config.NotifyTitle or "VehicleCleanup", message}
        })
    end
end


function Framework.RegisterCommand(name, callback, options)
    options = options or {}
    local delay = options.delay or 5000
    local permission = options.permission or ""

    RegisterCommand(name, function(source, args)
        -- Permission check
        if permission ~= "" then
            if Framework.Type == "esx" and ESX then
                local xPlayer = ESX.GetPlayerFromId(source)
                if not (xPlayer and xPlayer.getGroup() == permission) then return end
            elseif Framework.Type == "qb" and QBCore then
                local Player = QBCore.Functions.GetPlayer(source)
                if not (Player and Player.PlayerData.job.name == permission) then return end
            end
        end

        -- Delay check
        Framework.LastCommandTime[source] = Framework.LastCommandTime[source] or {}
        local last = Framework.LastCommandTime[source][name] or 0
        local now = os.time() * 1000
        if now - last < delay then return end
        Framework.LastCommandTime[source][name] = now

        callback(source, args)
    end)

    table.insert(Framework.RegisteredCommands, "/" .. name)
end
