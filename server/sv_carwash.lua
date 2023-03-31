RegisterNetEvent('nema_carwash:PayWash', function()
    if Wash.Ticket then
        exports.ox_inventory:RemoveItem(source, 'wash_ticket', Wash.TicketAmount)
    else
        exports.ox_inventory:RemoveItem(source, 'money', Wash.PriceAmount)
    end
end)