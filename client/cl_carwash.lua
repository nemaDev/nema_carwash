lib.locale()

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
    end
end)

AddEventHandler('nema_carwash:WashVehicle', function()
    local vehicle = lib.getClosestVehicle(GetEntityCoords(cache.ped), Wash.VehicleDistance, true)
    local ticket = exports.ox_inventory:Search('count','wash_ticket')
    local money = exports.ox_inventory:Search('count','money')

    if IsPedSittingInAnyVehicle(cache.ped) then
        TriggerEvent('nema_carwash:Notify', locale('title'), locale('car_inside'))
        return
    end
    if Wash.Ticket then
        if ticket >= Wash.TicketAmount then

            if vehicle == nil then
                TriggerEvent('nema_carwash:Notify', locale('title'), locale('close_veh'))
            else
                TriggerServerEvent('nema_carwash:PayWash', ticket)

                if Wash.WithAnimation then
                    local vehcoords = GetEntityCoords(vehicle)
                    local dist = 'cut_family2'
                    local fxName = 'cs_fam2_ped_water_splash'
                    RequestNamedPtfxAsset(dist)
                    while not HasNamedPtfxAssetLoaded(dist) do
                        Wait(1)
                    end
                    UseParticleFxAssetNextCall(dist)
                    local particle = StartParticleFxLoopedAtCoord(fxName, vehcoords, 0.0, 0.0, 0.0, 8.0, false, false, false, 0)
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
                        StopParticleFxLooped(particle, false)
                        SetVehicleDirtLevel(vehicle, 0.0)
                        WashDecalsFromVehicle(vehicle, 1.0)
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
                        TriggerEvent('nema_carwash:Notify', locale('title'), locale('finish_wash'))
                    end
                end
            end
        else
            TriggerEvent('nema_carwash:Notify', locale('title'), locale('need_ticket', Wash.TicketAmount))
        end
    else
        if money >= Wash.PriceAmount then

            if vehicle == nil then
                TriggerEvent('nema_carwash:Notify', locale('title'), locale('close_veh'))
            else
                TriggerServerEvent('nema_carwash:PayWash', money)

                if Wash.WithAnimation then
                    local vehcoords = GetEntityCoords(vehicle)
                    local dist = 'cut_family2'
                    local fxName = 'cs_fam2_ped_water_splash'
                    RequestNamedPtfxAsset(dist)
                    while not HasNamedPtfxAssetLoaded(dist) do
                        Wait(1)
                    end
                    UseParticleFxAssetNextCall(dist)
                    local particle = StartParticleFxLoopedAtCoord(fxName, vehcoords, 0.0, 0.0, 0.0, 8.0, false, false, false, 0)
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
                        StopParticleFxLooped(particle, false)
                        SetVehicleDirtLevel(vehicle, 0.0)
                        WashDecalsFromVehicle(vehicle, 1.0)
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
                        TriggerEvent('nema_carwash:Notify', locale('title'), locale('finish_wash'))
                    end
                end
            end
        else
            TriggerEvent('nema_carwash:Notify', locale('title'), locale('need_money', Wash.PriceAmount))
        end
    end
end)

if Wash.Ticket then
    local models = {262335250}
    local options = {
        {
            event = "nema_carwash:WashVehicle",
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
            event = "nema_carwash:WashVehicle",
            icon = Wash.targetIcon,
            label = locale('price_wash', Wash.PriceAmount),
            distance = Wash.TargetDistance
        },
    }

    exports.ox_target:addModel(models, options)
end
