lib.locale()

local Lavando = false

CreateThread(function()
    for k, v in pairs(Wash.Blips) do
        if v.blip then
            blip = AddBlipForCoord(v.pos.x, v.pos.y, v.pos.z)
            SetBlipSprite(blip, v.icon)
            SetBlipDisplay(blip, 4)
            SetBlipScale(blip, v.scale)
            SetBlipColour(blip, v.color)
            SetBlipAsShortRange(blip, true)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString(v.label)
            EndTextCommandSetBlipName(blip)
        end
        if Wash.RadialMenu then
            lib.zones.box({
                coords = v.pos,
                size = v.size,
                rotation = v.heading,
                debug = v.debug,
                onEnter = function()
                    lib.showTextUI(locale('pulse_key'), {
                        position = "right-center",
                        icon = Wash.targetIcon,
                        style = {
                            borderRadius = 0,
                            backgroundColor = '#48BB78',
                            color = 'white'
                        }
                    })
                    if Wash.Ticket then
                        lib.addRadialItem({
                            {
                                id = 'carwash',
                                label = locale('price_wash_ticket', Wash.TicketAmount),
                                icon = Wash.targetIcon,
                                onSelect = function()
                                    TriggerEvent('nema_carwash:Verificar')
                                end
                            },
                        })
                    else
                        lib.addRadialItem({
                            {
                                id = 'carwash',
                                label = locale('price_wash', Wash.PriceAmount),
                                icon = Wash.targetIcon,
                                onSelect = function()
                                    TriggerEvent('nema_carwash:Verificar')
                                end
                            },
                        })
                    end
                end,
                onExit = function()
                    lib.removeRadialItem('carwash')
                    lib.hideTextUI()
                end
            })
        end
    end
    if not Wash.RadialMenu then
        if Wash.Ticket then
            local models = {262335250}
            local options = {
                {
                    event = "nema_carwash:Verificar",
                    icon = Wash.targetIcon,
                    label = locale('price_wash_ticket', Wash.TicketAmount),
                    distance = Wash.TargetDistance
                },
            }
    
            exports.ox_target:addModel(models, options)
        else
            local models = {262335250}
            local options = {
                {
                    event = "nema_carwash:Verificar",
                    icon = Wash.targetIcon,
                    label = locale('price_wash', Wash.PriceAmount),
                    distance = Wash.TargetDistance
                },
            }
    
            exports.ox_target:addModel(models, options)
        end
    end
end)

AddEventHandler('nema_carwash:Verificar', function()
    if Lavando then
        return lib.notify({
            title = 'Error',
            description = locale('washing_vehicle'),
            type = 'error'
        })
    end

    TriggerEvent('nema_carwash:EmpezarLavado')
end)

AddEventHandler('nema_carwash:EmpezarLavado', function()
    local vehicle = lib.getClosestVehicle(GetEntityCoords(cache.ped), Wash.VehicleDistance, true)
    local ticket = exports.ox_inventory:Search('count','wash_ticket')
    local money = exports.ox_inventory:Search('count','money')

    if IsPedInAnyVehicle(cache.ped, false) then
        TriggerEvent('nema_carwash:Notify', locale('title'), locale('car_inside'))
        return
    end
    if vehicle == nil then
        TriggerEvent('nema_carwash:Notify', locale('title'), locale('close_veh'))
    else
        if Wash.Ticket then
            if ticket >= Wash.TicketAmount then

                TriggerServerEvent('nema_carwash:PagarLavado', ticket)
                Lavando = true
                if Wash.WithAnimation then
                    local vehcoords = GetEntityCoords(vehicle)
                    local dist = 'cut_family2'
                    local fxName = 'cs_fam2_ped_water_splash'
                    RequestNamedPtfxAsset(dist)
                    while not HasNamedPtfxAssetLoaded(dist) do
                        Wait(1)
                    end
                    UseParticleFxAssetNextCall(dist)
                    local particula = StartParticleFxLoopedAtCoord(fxName, vehcoords, 0.0, 0.0, 0.0, 8.0, false, false, false, 0)
                    if lib.progressBar({
                            duration = Wash.Duration,
                            label = locale('washing_veh'),
                            useWhileDead = false,
                            canCancel = false,
                            disable = {
                                car = true,
                            }
                        })
                    then
                        StopParticleFxLooped(particula, false)
                        SetVehicleDirtLevel(vehicle, 0.0)
                        WashDecalsFromVehicle(vehicle, 1.0)
                        Lavando = false
                        TriggerEvent('nema_carwash:Notify', locale('title'), locale('finish_wash'))
                    end
                else
                    if lib.progressBar({
                            duration = Wash.Duration,
                            label = locale('washing_veh'),
                            useWhileDead = false,
                            canCancel = false,
                            disable = {
                                car = true,
                            }
                        })
                    then
                        SetVehicleDirtLevel(vehicle, 0.0)
                        WashDecalsFromVehicle(vehicle, 1.0)
                        Lavando = false
                        TriggerEvent('nema_carwash:Notify', locale('title'), locale('finish_wash'))
                    end
                end
            else
                TriggerEvent('nema_carwash:Notify', locale('title'), locale('need_ticket', Wash.TicketAmount))
            end
        else
            if money >= Wash.PriceAmount then

                TriggerServerEvent('nema_carwash:PagarLavado', money)
                Lavando = true
                if Wash.WithAnimation then
                    local vehcoords = GetEntityCoords(vehicle)
                    local dist = 'cut_family2'
                    local fxName = 'cs_fam2_ped_water_splash'
                    RequestNamedPtfxAsset(dist)
                    while not HasNamedPtfxAssetLoaded(dist) do
                        Wait(1)
                    end
                    UseParticleFxAssetNextCall(dist)
                    local particula = StartParticleFxLoopedAtCoord(fxName, vehcoords, 0.0, 0.0, 0.0, 8.0, false, false, false, 0)
                    if lib.progressBar({
                            duration = Wash.Duration,
                            label = locale('washing_veh'),
                            useWhileDead = false,
                            canCancel = false,
                            disable = {
                                car = true,
                            }
                        })
                    then
                        StopParticleFxLooped(particula, false)
                        SetVehicleDirtLevel(vehicle, 0.0)
                        WashDecalsFromVehicle(vehicle, 1.0)
                        Lavando = false
                        TriggerEvent('nema_carwash:Notify', locale('title'), locale('finish_wash'))
                    end
                else
                    if lib.progressBar({
                            duration = Wash.Duration,
                            label = locale('washing_veh'),
                            useWhileDead = false,
                            canCancel = false,
                            disable = {
                                car = true,
                            }
                        })
                    then
                        SetVehicleDirtLevel(vehicle, 0.0)
                        WashDecalsFromVehicle(vehicle, 1.0)
                        Lavando = false
                        TriggerEvent('nema_carwash:Notify', locale('title'), locale('finish_wash'))
                    end
                end
            else
                TriggerEvent('nema_carwash:Notify', locale('title'), locale('need_money', Wash.PriceAmount))
            end
        end
    end
end)