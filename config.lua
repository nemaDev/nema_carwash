lib.locale()

Wash = {}

Wash.RadialMenu = true -- if you want to use ox_target set this to false
Wash.WithAnimation = true -- water falling on the vehicle
Wash.Ticket = false  -- if you wish to pay with money set to false

Wash.Duration = 10000 -- duration of vehicle washing
Wash.PriceAmount = 300 -- Price for washing the vehicle using money (Wash.Ticket = false)
Wash.TicketAmount = 1 -- amount to be removed from the ticket
Wash.VehicleDistance = 3.5 -- distance from the vehicle to the washing machine
Wash.targetIcon = 'fas fa-hands-bubbles'
Wash.TargetDistance = 2 -- ox target interaction distance

Wash.Blips = {
    {
        pos = vec3(169.25, -1717.0, 29.3016),
        icon = 100,
        color = 4,
        scale = 1.0,
        label = locale('title'), -- if you wish to use blips with different names simply do this, eg: label = locale 'My carwash',
        size = vec3(6.0, 7.0, 2),
        heading = 50.5,
        debug = false,
        blip = true,

    },{
        pos = vec3(174.75, -1736.8, 29.0),
        size = vec3(7.0, 6.5, 2),
        heading = 0.0,
        debug = false,
        blip = false,
    },

    {
        pos = vec3(24.4675, -1391.8799, 29.3333),
        icon = 100,
        color = 4,
        scale = 1.0,
        label = locale('title'),
        size = vec3(5, 7, 3),
        heading = 268.71707,
        debug = false,
        blip = true,
    },

    {
        pos = vec3(1368.0, 3602.0, 35.0),
        icon = 100,
        color = 4,
        scale = 1.0,
        label = locale('title'),
        size = vec3(5.0, 9.0, 2),
        heading = 110.5,
        debug = false,
        blip = true
    },

    {
        pos = vec3(1696.0, 4916.0, 42.0),
        icon = 100,
        color = 4,
        scale = 1.0,
        label = locale('title'),
        size = vec3(5.0, 7.0, 2),
        heading = 55.5,
        debug = false,
        blip = true
    },

    {
        pos = vec3(-216.0, 6214.0, 31.0),
        icon = 100,
        color = 4,
        scale = 1.0,
        label = locale('title'),
        size = vec3(7.0, 6.0, 2),
        heading = 45.5,
        debug = false,
        blip = true
    },
}

RegisterNetEvent('nema_carwash:Notify')
AddEventHandler('nema_carwash:Notify', function(title, msg)
    lib.notify({
        title = title,
        description = msg,
        position = 'top-right',
        icon = 'fas fa-hands-bubbles',
        iconColor = '#0df2c9'
    })
end)