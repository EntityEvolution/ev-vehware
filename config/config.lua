Config = {}

-- Opening job center
Config.openKey = 38

-- Notification Message
Config.openText = '~r~E~w~ | Vehicle Warehouse'
Config.deleteText = '~r~E~w~ | Dropoff Flatbed'

-- Truck Blip Settings
Config.Truck = {
    BlipSprite = 635,
    BlipScale = 0.9,
    BlipColor = 24,
    BlipShortRange = false,
    BlipText = 'Warehouse Truck'
}

-- Vehicle Give Settings
Config.Vehicle = {
    BlipSprite = 306,
    BlipScale = 0.9,
    BlipColor = 24,
    BlipShortRange = false,
    BlipText = 'Dropoff'
}

-- Delete Zone Names
Config.DeleteZones = {
    CircleZone:Create(vec3(1902.17, 4919.125, 48.78), 5.0, {
        name="barnZone",
        useZ = true
    }),
    CircleZone:Create(vec3(2686.79, 2764.79, 37.87), 5.0, {
        name="constructionZone",
        useZ = true
    })
}

-- Drop/Delete Zones. Keep both the same.
Config.DropZones = {
    {coords = vec3(1902.17, 4919.125, 48.78), name = "barnZone"},
    {coords = vec3(2686.79, 2764.79, 37.87), name = "constructionZone"}
}

Config.Debug = false