lib.locale()

Wash = {}

Wash.WithAnimation = true -- water falling on the vehicle
Wash.Ticket = false  -- if you wish to pay with money set to false
Wash.Duration = 5000 -- duration of vehicle washing
Wash.PriceAmount = 2000 -- Price for washing the vehicle using money (Wash.Ticket = false)
Wash.TicketAmount = 1 -- amount to be removed from the ticket
Wash.VehicleDistance = 3.5 -- distance from the vehicle to the washing machine
Wash.targetIcon = 'fas fa-hands-bubbles' -- icon displayed in the ox target
Wash.TargetDistance = 2 -- ox target interaction distance

Wash.Blips = {
    {
        pos = vector3(-698.9388, -698.9388, -698.9388 ),
        icon = 100,
        color = 4,
        scale = 1.0,
        label = locale('title'), -- you can change to any name example: label = 'mi carwash',
        blip = false
    },
    {
        pos = vector3(24.9860, -1392.2036, 29.3339 ),
        icon = 100,
        color = 4,
        scale = 1.0,
        label = locale('title'),
        blip = true
    },
    {
        pos = vector3(170.4428, -1718.6241, 29.3016 ),
        icon = 100,
        color = 4,
        scale = 1.0,
        label = locale('title'),
        blip = true
    },
    {
        pos = vector3(1365.0729, 3604.1377, 34.8182 ),
        icon = 100,
        color = 4,
        scale = 1.0,
        label = locale('title'),
        blip = true
    },
    {
        pos = vector3(1698.3536, 4916.9810, 42.0781 ),
        icon = 100,
        color = 4,
        scale = 1.0,
        label = locale('title'),
        blip = true
    },
    {
        pos = vector3(-216.5613, 6216.5005, 31.4910 ),
        icon = 100,
        color = 4,
        scale = 1.0,
        label = locale('title'),
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