fx_version 'cerulean'

game 'gta5'

name 'nema_carwash'

author 'ameN#0001'

repository 'https://github.com/NemaDev/nema_carwash'

lua54 'yes'

shared_scripts {
    '@ox_lib/init.lua',
    'config.lua'
}

client_scripts {
    'client/*.lua'
}

server_scripts {
    'server/*.lua'
}

files {
    'locales/*.json'
}
