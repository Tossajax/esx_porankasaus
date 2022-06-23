--TOSsaja kkonaa


local ESX = nil
local PlayerData  = {}


RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
  PlayerData = xPlayer
end)

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)



Kasaus = {
	{0.0, 0.0, 0.0} --Omat coordsit
}


local kasaa = false
Citizen.CreateThread(function()
	while true do
		Wait(1500)
		for i = 1, #Kasaus do
			kordinaatit = Kasaus[i]
			while GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), kordinaatit[1], kordinaatit[2], kordinaatit[3], true) < 25 do
				Citizen.Wait(4)
				if not kasaa then
					if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), kordinaatit[1], kordinaatit[2], kordinaatit[3], true ) < 2 and not kasaa then
						ESX.ShowHelpNotification("Paina ~INPUT_CONTEXT~ kasataksesi pora")
						if(IsControlJustPressed(1, 38)) then
							TriggerServerEvent('esx_porankasaus:itemcheck')
						end
					end
				else
					Wait(1000)
				end
			end
		end
	end
end)


RegisterNetEvent('esx_porankasaus:puuttuu')
AddEventHandler('esx_porankasaus:puuttuu', function()
	ESX.ShowNotification('Tarvitset poran rungon ja ohjeen!') --Omat itemit serveriin
end)




function valmistatuli()
	TriggerServerEvent('esx_porankasaus:pora')
	ESX.ShowNotification('Valmista tuli!')
	ClearPedTasks(GetPlayerPed(-1))
	paska = false
	kasaa = false
end

RegisterNetEvent('esx_porankasaus:onitemit')
AddEventHandler('esx_porankasaus:onitemit', function()
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
			valmistatuli()
		end
	end)
end)
