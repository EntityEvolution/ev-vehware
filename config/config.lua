Config = {}

-- Opening job center
Config.openKey = 38

-- Notification Message
Config.openText = '~r~E~w~ | Vehicle Warehouse'

-- Truck Blip Settings
Config.Truck = {
    BlipSprite = 635,
    BlipScale = 0.9,
    BlipColor = 24,
    BlipShortRange = false,
    BlipText = 'Warehouse Truck'
}

-- Delete Zone Names
Config.DeleteZones = {
    {name = "barnZone", coords = vec3(1902.17, 4919.125, 48.78), radius = 5.0},
    {name = "constructionZone", coords = vec3(1902.17, 4919.125, 48.78), radius = 5.0},
    {name = "paletoZone", coords = vec3(1902.17, 4919.125, 48.78), radius = 5.0}
}