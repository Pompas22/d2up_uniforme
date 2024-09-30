fx_version 'bodacious'
game 'gta5'
lua54 'yes'

ui_page 'nui/badland.html'

client_scripts {
	'@vrp/lib/utils.lua',
	'client.lua',
	"config.lua"
}

server_scripts {
	'@vrp/lib/utils.lua',
	'server.lua',
	"config.lua"
}

files {
	'nui/badland.html',
	'nui/badland.js',
    'nui/badland.css',
    
	'nui/images/*.png',
}

escrow_ignore {
	'config.lua',
}