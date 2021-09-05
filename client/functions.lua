---Shows a floating notification above ped
---@param ped number
function showNoti(ped)
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
                showFloatingNotification(Config.openText, vec3(coords.x, coords.y, coords.z + 1))
                if IsControlJustPressed(0, Config.openKey) then
                    isOpen = true
                    SetNuiFocus(isOpen, isOpen)
                    SendNUIMessage({action = 'show'})
                    break
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
    local modelHash = GetHashKey(vehicle)
    local truckModel = GetHashKey('flatbed')
    if not IsModelInCdimage(modelHash) then return print(vehicle .. ' does not exist') end

    RequestModel(modelHash)
    RequestModel(truckModel)
    while not HasModelLoaded(modelHash) and not HasModelLoaded(truckModel) do
        Wait(10)
    end
    local truck = CreateVehicle(truckModel, vector4(coords[1], coords[2], coords[3], coords[4]), true, false)
    local targetVehicle = CreateVehicle(modelHash, vector4(coords[1], coords[2], coords[3] + 1, coords[4]), true, false)
    SetVehicleDoorsLocked(targetVehicle, 4)
    AttachEntityToEntity(targetVehicle, truck, 20, -0.5, -5.0, 1.0, 0.0, 0.0, 0.0, false, false, false, false, 20, true)

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

RegisterCommand('a', function()
    print(GetEntityCoords(PlayerPedId()))
end)