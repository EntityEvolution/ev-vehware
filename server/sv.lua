RegisterNetEvent('ev:updateWarehouseStatus', function(id)
    TriggerClientEvent('ev:updateWarehouseStatus', -1, id)
end)