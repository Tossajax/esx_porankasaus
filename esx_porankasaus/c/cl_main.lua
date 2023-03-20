local ESX = nil

local kasaa = false

CreateThread(function()
    while ESX == nil do
        Wait(10)
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
    end
    TriggerServerEvent('kasaus:serverista')
     Wait(7000)
    while true do
        local wait = 1000
        local playerPed = PlayerPedId()
        local coords = GetEntityCoords(playerPed)
        for k,v in pairs(perse) do
            local lol = v.pos
            if #(coords - lol) < 2 then 
                wait = 0
		if aika < 4 or aika >= 22 then		
			if not kasaa then
			    ESX.ShowHelpNotification("Paina ~INPUT_CONTEXT~ kasataksesi pora")
			    if IsControlJustPressed(0, 38) then
			       TriggerServerEvent('esx_porankasaus:itemcheck')
			    end
			end   
		else
		     ESX.ShowHelpNotification("Takas vaikka yöllä???")			
		end
            end
        end
        Wait(wait)
    end
end)

RegisterNetEvent('kasaus:clienttiin')
AddEventHandler('kasaus:clienttiin', function(infot)
    perse = infot
end)

function valmistatuli()
	if kasaa then
		TriggerServerEvent('esx_porankasaus:pora') 
		ESX.ShowNotification('Valmista tuli!')
		ClearPedTasks(GetPlayerPed(-1))
		paska = false
	else
		print("modder issue") --voit lisää tähä kämäsen bänni sydeemin
	end
end

RegisterNetEvent('esx_porankasaus:onitemit')
AddEventHandler('esx_porankasaus:onitemit', function()
	if kasaa then
		kasaa = true
		ESX.ShowNotification('Alotellaas kasaus!')
		SetEntityHeading(PlayerPedId(), 0.0) --tähä coordien vika h: (voit myös ottaa pois jos et halua)
		SetEntityCoords(PlayerPedId(), 0.0, 0.0, 0.0) --omat coordit sit (voit myös ottaa pois jos et halua)
		ExecuteCommand("e mechanic4")
		TriggerEvent("mythic_progbar:client:progress", {
			name = "sdasdsa",
			duration = 20000, 
			label = "Kasataan poraa",
			useWhileDead = false,
			canCancel = false,
			controlDisables = {
				disableMovement = true,
				disableCarMovement = true,
				disableMouse = false,
				disableCombat = true,
			},
		}, function(status)
			if not status then
				kasaa = false
				valmistatuli()
			end
		end)
	else
		print("bannit pirkuleesti")
	end
end)
