fx_version 'bodacious'
games { 'gta5' }

author 'AmIrReZa#2080'
description 'ESX Phone Job'
version '1.0.0'

shared_script '@es_extended/imports.lua'

server_scripts {
	'@mysql-async/lib/MySQL.lua',
	'@es_extended/locale.lua',
	'config.lua',
	'server/main.lua'
}

client_scripts {
	'@es_extended/locale.lua',
	'locales/*.lua',
	'config.lua',
	'client/main.lua'
}
