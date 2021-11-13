ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)



 RegisterServerEvent('esx_porankasaus:itemcheck')
 AddEventHandler('esx_porankasaus:itemcheck', function()
   local _source = source
   local xPlayer = ESX.GetPlayerFromId(source)
   local item1 = xPlayer.getInventoryItem('poranohje')
   local item2 = xPlayer.getInventoryItem('poranrunko')
   if item1.count > 0 and item2.count > 0 then
      xPlayer.removeInventoryItem('poranrunko', 1)
      xPlayer.removeInventoryItem('poranohje', 1)
      TriggerClientEvent('esx_porankasaus:onitemit', _source)
   else
      TriggerClientEvent('esx_porankasaus:puuttuu', _source)
   end
end)


RegisterServerEvent('esx_porankasaus:pora')
AddEventHandler('esx_porankasaus:pora', function()
   local _source = source
   local xPlayer = ESX.GetPlayerFromId(source)
   xPlayer.addInventoryItem('drill', 1)
end)