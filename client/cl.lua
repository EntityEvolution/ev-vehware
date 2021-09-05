local insidePoly, isOpen, inMission = false, false, false
local maxZones, currentZones = 1, 0
local dropZone = ""
local currentVehicleList, currentCoordsList, currentAttached

local vehicleBlip, truckBlip

RegisterNUICallback('getVehicleData', function(data, cb)
    if isOpen then
        isOpen = false
        SendNUIMessage({action = 'hide'})
        SetNuiFocus(isOpen, isOpen)
        if data then
            maxZones = data.maxZones
            createTruck(data.vehicles[math.random(1, tableLength(data.vehicles))]:lower(), data.coords)
            currentVehicleList = data.vehicles
            currentCoordsList = data.coords
            inMission = true
        end
    end
    cb({})
end)

---Shows a floating notification above ped
---@param ped number
function showNoti(ped, type, message)
    ---Returns a floating notification on coords
    ---@param message string
    ---@param coords number
    local function showFloatingNotification(message, coords)
        AddTextEntry('warehouseNoti', message)
        SetFloatingHelpTextWorldPosition(1, coords)
        SetFloatingHelpTextStyle(1, 1, 2, -1, 3, 0)
        BeginTextCommandDisplayHelp('warehouseNoti')
        EndTextCommandDisplayHelp(2, false, false, -1)
    end
    if insidePoly and not isOpen then
        CreateThread(function()
            while insidePoly do
                local coords = GetEntityCoords(ped)
                showFloatingNotification(message, vec3(coords.x, coords.y, coords.z + 1))
                if IsControlJustPressed(0, Config.openKey) then
                    if type == "warehouse" then
                        if not inMission then
                            isOpen = true
                            SetNuiFocus(isOpen, isOpen)
                            SendNUIMessage({action = 'show'})
                        else
                            print('Your already doing a mission')
                        end
                        break
                    elseif type == "delete" then
                        local vehicle = GetVehiclePedIsIn(ped, false)
                        if IsVehicleModel(vehicle, GetHashKey('flatbed')) then
                            if IsEntityAttachedToEntity(currentAttached, vehicle) then
                                SetEntityAsMissionEntity(vehicle, true, true)
                                DeleteVehicle(vehicle)
                                SetEntityAsNoLongerNeeded(vehicle)
                                currentZones = currentZones + 1
                                createTruck(currentVehicleList[math.random(1, tableLength(currentVehicleList))]:lower(), currentCoordsList)
                                break
                            else
                                print('Seems like you dropped your vehicle somewhere')
                            end
                        else
                            print('You cannot do the mission with that vehicle')
                        end
                    end
                end
                Wait(5)
            end
        end)
    end
end

---Creates a truck with param vehicle at vector coords
---@param vehicle string
---@param coords table
---@return any
function createTruck(vehicle, coords)
    if currentAttached then currentAttached = nil end
    if DoesBlipExist(vehicleBlip) then RemoveBlip(vehicleBlip) end
    if DoesBlipExist(truckBlip) then RemoveBlip(truckBlip) end
    if currentZones == maxZones then
        currentZones = 0
        currentVehicleList = nil
        currentCoordsList = nil
        inMission = false
        return print('done with warehouse')
    end
    local modelHash = GetHashKey(vehicle)
    local truckModel = GetHashKey('flatbed')
    if not IsModelInCdimage(modelHash) then return print(vehicle .. ' does not exist') end

    RequestModel(modelHash)
    RequestModel(truckModel)
    while not HasModelLoaded(modelHash) and not HasModelLoaded(truckModel) do
        Wait(15)
    end
    local truck = CreateVehicle(truckModel, vector4(coords[1], coords[2], coords[3], coords[4]), true, false)
    local targetVehicle = CreateVehicle(modelHash, vector4(coords[1], coords[2], coords[3] + 1, coords[4]), true, false)
    SetVehicleDoorsLocked(targetVehicle, 4)
    AttachEntityToEntity(targetVehicle, truck, 20, -0.5, -5.0, 1.0, 0.0, 0.0, 0.0, false, false, false, false, 20, true)
    currentAttached = targetVehicle
    -- Blip for truck
    truckBlip = AddBlipForEntity(truck)
    SetBlipSprite(truckBlip, Config.Truck.BlipSprite)
    SetBlipScale(truckBlip, Config.Truck.BlipScale)
    SetBlipColour(truckBlip, Config.Truck.BlipColor)
    SetBlipAsShortRange(truckBlip, Config.Truck.BlipShortRange)
    BeginTextCommandSetBlipName('STRING')
    AddTextComponentSubstringPlayerName(Config.Truck.BlipText)
    EndTextCommandSetBlipName(truckBlip)
    SetNewWaypoint(coords[1], coords[2])

    -- Blip for giving car
    local randomPlace = math.random(1, tableLength(Config.DropZones))
    dropZone = Config.DropZones[randomPlace].name
    vehicleBlip = AddBlipForCoord(Config.DropZones[randomPlace].coords)
    SetBlipSprite(vehicleBlip, Config.Vehicle.BlipSprite)
    SetBlipScale(vehicleBlip, Config.Vehicle.BlipScale)
    SetBlipColour(vehicleBlip, Config.Vehicle.BlipColor)
    SetBlipAsShortRange(vehicleBlip, Config.Vehicle.BlipShortRange)
    BeginTextCommandSetBlipName('STRING')
    AddTextComponentSubstringPlayerName(Config.Vehicle.BlipText)
    EndTextCommandSetBlipName(vehicleBlip)
end

---Returns the 
---@param table any
---@return number
function tableLength(table)
    local count = 0
    for _ in pairs(table) do
        count = count + 1
    end
    return count
end

-- Polyzones
local warehouse <const> = PolyZone:Create({
    vector2(1713.1801757812, 3325.0007324219),
    vector2(1717.5881347656, 3326.5939941406),
    vector2(1719.3165283203, 3320.400390625),
    vector2(1714.6280517578, 3319.1982421875)
}, {
    name="warehouse",
    minZ = 40.141624450684,
    maxZ = 43.170108795166,
    lazyGrid = true,
    debugPoly = false
})

-- Delete Zones
local combo <const> = ComboZone:Create(Config.DeleteZones, {
    name="combo",
    useGrid = true,
    debugPoly=false
})

warehouse:onPointInOut(PolyZone.getPlayerPosition, function(isPointInside)
    if isPointInside then
        if not insidePoly then
            insidePoly = true
            showNoti(PlayerPedId(), 'warehouse', Config.openText)
        end
    else
        if insidePoly then
            insidePoly = false
        end
    end
end)

combo:onPlayerInOut(function(isPointInside, _, zone)
    if isPointInside then
        if zone then
            if zone.name == dropZone then
                if not insidePoly then
                    insidePoly = true
                    showNoti(PlayerPedId(), 'delete', Config.deleteText)
                end
            end
        end
    else
        if insidePoly then
            insidePoly = false
        end
    end
end)