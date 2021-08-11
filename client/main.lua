local PlayerData                = {}

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
    PlayerData.job = job
end)

Citizen.CreateThread(function ()
    while true do
            Citizen.Wait(0)
            local inv = Config.inventory
            local ped = PlayerPedId()
            local pedpos = GetEntityCoords(ped)
            if PlayerData.job.name == "phoner" then
            for i = 1, #inv do
                if GetDistanceBetweenCoords(pedpos.x, pedpos.y, pedpos.z, inv[i].x, inv[i].y, inv[i].z, true) < Config.DrawDistance then
                    DrawMarker(1, inv[i].x, inv[i].y, inv[i].z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 1.0, 1.0, Config.MarkerColor.r, Config.MarkerColor.g, Config.MarkerColor.b, 100, false, true, 2,true, false, false, false)
                end
            if GetDistanceBetweenCoords(pedpos.x, pedpos.y, pedpos.z, inv[i].x, inv[i].y, inv[i].z, true) < 1.3 then
                ESX.ShowHelpNotification(_U('prees_open'))
                    if IsControlJustPressed(0, 38) then
                        OpenInventoryMenu()
                    end
                end
            end
        end
    end
end)

Citizen.CreateThread(function ()
    while true do
        local Lock = Config.Shop
        local ped = PlayerPedId()
        local pedpos = GetEntityCoords(ped)
        Citizen.Wait(0)
        for i = 1, #Lock do
            if GetDistanceBetweenCoords(pedpos.x, pedpos.y, pedpos.z, Lock[i].x, Lock[i].y, Lock[i].z, true) < Config.DrawDistance then
                DrawMarker(1, Lock[i].x, Lock[i].y,  Lock[i].z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 1.0, 1.0, Config.MarkerColor.r, Config.MarkerColor.g, Config.MarkerColor.b, 100, false, true, 2,true, false, false, false)
            end
        if GetDistanceBetweenCoords(pedpos.x, pedpos.y, pedpos.z, Lock[i].x, Lock[i].y, Lock[i].z, true) < 1.3 then
            ESX.ShowHelpNotification(_U('prees_open'))
                if IsControlJustPressed(0, 38) then     
                    OpenBuyMenu()
                end
            end
        end
    end
end)

Citizen.CreateThread(function ()
        while true do
                Citizen.Wait(0)
                local Boss = Config.BossActions
                local ped = PlayerPedId()
                local pedpos = GetEntityCoords(ped)
                if PlayerData.job.name == "phoner" then
                for i = 1, #Boss do
                    if GetDistanceBetweenCoords(pedpos.x, pedpos.y, pedpos.z, Boss[i].x, Boss[i].y, Boss[i].z, true) < Config.DrawDistance then
                        DrawMarker(1, Boss[i].x, Boss[i].y,  Boss[i].z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 1.0, 1.0, Config.MarkerColor.r, Config.MarkerColor.g, Config.MarkerColor.b, 100, false, true, 2,true, false, false, false)
                    end
                    if GetDistanceBetweenCoords(pedpos.x, pedpos.y, pedpos.z, Boss[i].x, Boss[i].y, Boss[i].z, true) < 1.3 then
                        ESX.ShowHelpNotification(_U('prees_open'))
                        if IsControlJustPressed(0, 38) then
                            ESX.UI.Menu.CloseAll()
                        TriggerEvent('esx_society:openBosirpixelsMenu', 'phoner', function(data, menu)
                             menu.close()
                        end, {wash = false})
                    end
                end
            end
        end
    end
end)

function OpenInventoryMenu()
    local elements = {
    	{label = 'LapTop',        value = 'laptop'},
        {label = 'Glass Moblie',  value = 'glass' },
        {label = 'Cover Mobile',  value = 'cover' },
    }
    ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'phone_shop', {
    	title    = 'Phone Shop',
    	align    = 'center',
    	elements = elements
    }, function(data, menu)
        if data.current.value == 'laptop' then
            TriggerServerEvent('esx_phonejob:BuyItem', 'laptop')
            menu.close()
        elseif data.current.value == 'glass' then
            TriggerServerEvent('esx_phonejob:BuyItem', 'mobile_glass')
            menu.close()
        elseif data.current.value == 'cover' then
            TriggerServerEvent('esx_phonejob:BuyItem', 'mobile_cover')
            menu.close()
        end
    end, function (data, menu)
        ESX.UI.Menu.CloseAll()
    end)
end

function OpenBuyMenu()
    local elements = {
		{label = 'Radio (Price : '..Config.RadioPrice..')', value = 'radio'},
        {label = 'Goshi (Price : '..Config.PhonePrice..')', value = 'phone'}
    }
    ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'phone_shop', {
		title    = 'Phone Shop',
		align    = 'center',
		elements = elements
	}, function(data, menu)
        if data.current.value == 'radio' then
            TriggerServerEvent('esx_phonejob:BuyItem', 'radio')
            menu.close()
        elseif data.current.value == 'phone' then
            TriggerServerEvent('esx_phonejob:BuyItem', 'phone')
            menu.close()
        end
    end, function (data, menu)
        ESX.UI.Menu.CloseAll()
    end)
end

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
PlayerData.job = xPlayer.job
  if xPlayer.job.name == "phoner" then
      TriggerEvent('esx_phonejob:addSuggestions', xPlayer.source)
  end
end)

RegisterNetEvent('esx_phonejob:addSuggestions')
AddEventHandler('esx_phonejob:addSuggestions', function ()
	TriggerEvent('chat:addSuggestion', '/setsim', 'For Change Number Player', {
		{ name="IC Name", help="For Example : Amir_Shams" },
		{ name="New Number", help="For Example : 0902xxxxxxxx" }
	})

    TriggerEvent('chat:addSuggestion', '/getsim', 'For Player Information', {
		{ name="Number", help="For Example : 0902xxxxxxxx" }
	})
end)

Citizen.CreateThread(function()
    local Lock = Config.Shop
    for i = 1, #Lock do
		local blip = AddBlipForCoord(Lock[i].x , Lock[i].y, Lock[i].z)

		SetBlipSprite (blip, 619)
		SetBlipDisplay(blip, 4)
		SetBlipScale  (blip, 1.2)
		SetBlipColour (blip, 46)
		SetBlipAsShortRange(blip, true)

		BeginTextCommandSetBlipName("STRING")
		AddTextComponentSubstringPlayerName(_U('phone_shop'))
		EndTextCommandSetBlipName(blip)
	end
end)
