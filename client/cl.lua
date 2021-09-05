insidePoly, isOpen = false, false

local insidePoly, isOpen = insidePoly, isOpen

RegisterNUICallback('getVehicleData', function(data, cb)
    if isOpen then
        isOpen = false
        SendNUIMessage({action = 'hide'})
        SetNuiFocus(isOpen, isOpen)
        if data then
            createTruck(data.vehicles[math.random(1, tableLength(data.vehicles))]:lower(), data.coords)
        end
    end
    cb({})
end)

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

warehouse:onPointInOut(PolyZone.getPlayerPosition, function(isPointInside)
    if isPointInside then
        if not insidePoly then
            insidePoly = true
            showNoti(PlayerPedId())
        end
    else
        if insidePoly then
            insidePoly = false
            showNoti()
        end
    end
end)

-- Delete Zones
local circleA = CircleZone:Create(Config.DeleteZones[1].coords, Config.DeleteZones[1].radius, {
    name=Config.DeleteZones[1].name,
    useZ = true
})

local circleA = CircleZone:Create(Config.DeleteZones[1].coords, Config.DeleteZones[1].radius, {
    name=Config.DeleteZones[1].name,
    useZ = true
})

local circleA = CircleZone:Create(Config.DeleteZones[1].coords, Config.DeleteZones[1].radius, {
    name=Config.DeleteZones[1].name,
    useZ = true
})

local combo = ComboZone:Create({circleA, circleB, circleC}, {
    name="combo",
    debugPoly=true
})

combo:onPlayerInOut(function(isPointInside, _, zone)
    if isPointInside then
        if zone then
            print(zone.name)
        end
    end
end)