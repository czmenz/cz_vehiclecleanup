local function requestControl(entity)
    local timeout = GetGameTimer() + 2000
    while not NetworkHasControlOfEntity(entity) do
        NetworkRequestControlOfEntity(entity)
        if GetGameTimer() > timeout then return false end
        Wait(50)
    end
    return true
end

local function vehicleHasPlayer(vehicle)
    for seat = -1, GetVehicleMaxNumberOfPassengers(vehicle) - 1 do
        local ped = GetPedInVehicleSeat(vehicle, seat)
        if ped ~= 0 and IsPedAPlayer(ped) then return true end
    end
    return false
end

local function tryDelete(vehicle)
    if not requestControl(vehicle) then return end
    SetEntityAsMissionEntity(vehicle, true, true)
    DeleteVehicle(vehicle)
    if DoesEntityExist(vehicle) then DeleteEntity(vehicle) end
end

RegisterNetEvent("cz_vehiclecleanup:requestPlate", function()
    local ped = PlayerPedId()
    if not IsPedInAnyVehicle(ped, false) then
        TriggerServerEvent("cz_vehiclecleanup:noVehicle")
        return
    end
    local vehicle = GetVehiclePedIsIn(ped, false)
    local plate = GetVehicleNumberPlateText(vehicle)
    plate = string.gsub(plate, "%s+", "") -- odstraní mezery
    TriggerServerEvent("cz_vehiclecleanup:addIgnorePlate", string.upper(plate))
end)

RegisterNetEvent("cz_vehiclecleanup:cleanup", function(ignorePlates)
    local vehicles = GetGamePool("CVehicle")
    for i = 1, #vehicles do
        local vehicle = vehicles[i]
        if DoesEntityExist(vehicle) then
            local plate = string.upper(GetVehicleNumberPlateText(vehicle))
            plate = string.gsub(plate, "%s+", "")
            if not ignorePlates[plate] and not vehicleHasPlayer(vehicle) then
                tryDelete(vehicle)
            end
        end
        if i % 25 == 0 then Wait(0) end
    end
end)