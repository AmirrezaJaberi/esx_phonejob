ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)


RegisterCommand('setsim', function (source, args)
    local xPlayer = ESX.GetPlayerFromId(source)
    local xTarget = ESX.GetPlayerFromId(args[1])
    if xPlayer.job.name == "phoner" then
        
         MySQL.Async.execute('UPDATE users SET phone_number = @phone_number WHERE identifier = @identifier', {
             ['@identifier']         = xTarget.identifier,
             ['@phone_number']       = args[2]
            }, function(rowsChanged)
                StopResource('gcphone')
                StartResource('gcphone')
               print('^'..math.random(1, 9)..'['..GetCurrentResourceName()..']^0 Player ^3'..xPlayer.getName()..'^0 Phone Number : ^1'..args[2]..'^0')
            end)
        else
        TriggerClientEvent('chatMessage', source, "[SYSTEM]", {255, 0, 0}, _U('not_phoner'))
    end
end)

RegisterCommand('getsim', function (source, args)
    local xPlayer = ESX.GetPlayerFromId(source)
    local num = tonumber(args[1])
    if xPlayer.job.name == "phoner" then
        MySQL.Async.fetchAll('SELECT * FROM users WHERE phone_number = @phone_number', {
            ['@phone_number'] = num
        }, function(data)
            if data then
                TriggerClientEvent('chatMessage', source, "[SYSTEM]", {255, 0, 0}, _U('owner_is', data[1].firstname, data[1].lastname))
            else
                TriggerClientEvent('chatMessage', source, "[SYSTEM]", {255, 0, 0}, _U('not_availble'))
            end
          end)
    else
        TriggerClientEvent('chatMessage', source, "[SYSTEM]", {255, 0, 0}, _U('not_phoner'))
    end
end)

RegisterNetEvent('esx_phonejob:BuyItem')
AddEventHandler('esx_phonejob:BuyItem', function (item)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    if item == 'radio' then
        if xPlayer.getMoney() >= Config.RadioPrice then
            xPlayer.removeMoney(Config.RadioPrice)
            xPlayer.addInventoryItem('radio', 1)
        else
            TriggerClientEvent('chatMessage', source, "[SYSTEM]", {255, 0, 0}, _U('not_enough'))
        end
    elseif item == 'phone' then
        if xPlayer.getMoney() >= Config.PhonePrice then
            xPlayer.removeMoney(Config.PhonePrice)
            xPlayer.addInventoryItem('phone', 1)
        else
            TriggerClientEvent('chatMessage', source, "[SYSTEM]", {255, 0, 0}, "Shoma Pool Kafi Nadarad")
        end
    end
end)
