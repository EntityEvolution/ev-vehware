fx_version 'cerulean'

game { 'gta5' }

lua54 'yes'

description 'A simple NUI vehicle warehouse created by Entity Evolution'

version '1.0.0'

client_scripts {
    '@PolyZone/client.lua',
    '@PolyZone/CircleZone.lua',
	'@PolyZone/ComboZone.lua',
    'config/config.lua',
    'client/*.lua'
}

server_scripts {
    'server/*.lua'
}

ui_page 'html/ui.html'

files {
    'html/ui.html',
    'config/config.json',
    'html/fonts/*.ttf',
    'html/img/*.jpg',
    'html/img/*.png',
    'html/css/style.css',
    'html/js/script.js'
}

dependency 'PolyZone'