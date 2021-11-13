--TOSsaja kkonaa





local ESX 			= nil
local PlayerData 	= {}
vaihe1 = false
vaihe2 = false
vaihe3 = false
vaihe4 = false
vaihe5 = false
vaihe6 = false


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
	{0.0,0.0,0.0} --tähän myös coordit
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
						ESX.ShowHelpNotification('Paina ~INPUT_CONTEXT~ ~r~kasataksesi ~w~poran.')
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

function DrawSpecialText(m_text, showtime)
	SetTextEntry_2("STRING")
	AddTextComponentString(m_text)
	DrawSubtitleTimed(showtime, 1)
end

RegisterNetEvent('esx_porankasaus:puuttuu')
AddEventHandler('esx_porankasaus:puuttuu', function()
	ESX.ShowNotification('Tarvitset poran rungon ja ohjeen!')
end)


function tekstitsunmuut()
    local paska = true
    local alotusaika = GetGameTimer()
    local tossaja = Config.paskat["kasauspaikka"][1]
        while paska do
			Citizen.Wait(1)
			local aika = 60 * 1000
			local kasausProcent = (GetGameTimer() - alotusaika) / aika * 1000
            if kasausProcent <= 100 then
				local aika = 60 * 1000
				local kasausProcent = (GetGameTimer() - alotusaika) / aika * 1000
			end
        if kasausProcent >= 100 then
			paska = false
            valmistatuli()
        end
    end
end


function valmistatuli()
	Citizen.Wait(1000)
	TriggerServerEvent('esx_porankasaus:pora')
	ClearPedTasks(GetPlayerPed(-1))
	paska = false
	kasaa = false
end

RegisterNetEvent('esx_porankasaus:onitemit')
AddEventHandler('esx_porankasaus:onitemit', function()
	kasaa = true
	ESX.ShowNotification('Alotellaas kasaus!')
	ExecuteCommand("e mechanic4")
	tekstitsunmuut()
	Citizen.Wait(4000)
	ClearPedTasksImmediately(ped)
end)

function Draw3DText2(x, y, z, text)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    local dist = GetDistanceBetweenCoords(px,py,pz, x,y,z, 1)
    local scale = (1/dist)*1
    local fov = (1/GetGameplayCamFov())*100
    local scale = 1.0
   
    if onScreen then
        SetTextScale(0.0*scale, 0.25*scale)
        SetTextFont(0)
        SetTextProportional(1)
        SetTextColour(0, 0, 0, 255)
        SetTextDropshadow(0, 0, 0, 0, 255)
        SetTextEdge(2, 0, 0, 0, 150)
        SetTextDropShadow()
        SetTextOutline()
        SetTextEntry("STRING")
        SetTextCentre(1)
        AddTextComponentString(text)
        DrawText(_x,_y)
    local factor = (string.len(text)) / 370
    	DrawRect(_x,_y+0.0125, 0.013+ factor, 0.03, 0, 0, 0, 68)
    end
end
