--[[
░█████╗░██████╗░███╗░░██╗██╗███████╗
██╔══██╗██╔══██╗████╗░██║██║██╔════╝
███████║██████╔╝██╔██╗██║██║█████╗░░
██╔══██║██╔══██╗██║╚████║██║██╔══╝░░
██║░░██║██║░░██║██║░╚███║██║███████╗
╚═╝░░╚═╝╚═╝░░╚═╝╚═╝░░╚══╝╚═╝╚══════╝
--]]

local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
MySQL = module("vrp_mysql", "MySQL")

vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP","Arnie_Hacker")


RegisterServerEvent('HackerStik')
AddEventHandler('HackerStik', function()
    local user_id = vRP.getUserId({source})
    vRP.tryFullPayment({user_id,10000})
    vRP.giveInventoryItem({user_id,"Hackerstik",1,true})
end)

RegisterServerEvent('AlertCops')
AddEventHandler('AlertCops', function()
    local users = vRP.getUsers({})
    if vRP.hasPermissions({users , "police.pc"}) then
        SendNotify()
    end
end)

function SendNotify()
    local users = vRP.getUsers({})
      for user_id in pairs(users) do 
      local Plysource = vRP.getUserSource({user_id})
        if vRP.hasPermissions({user_id, "police.pc"}) then
          TriggerClientEvent("pNotify:SendNotification", Plysource,{text = "Der er røverri", type = "error", queue = "global", timeout = 2000, layout = "centerRight",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"},killer = true})
        end 
    end
end


RegisterServerEvent('Fejled')
AddEventHandler('Fejled', function()
    local user_id = vRP.getUserId({source})
function sendToDiscord(farve, titel, besked, undertext)
    local embed = {
          {
              ["color"] = farve,
              ["title"] = "**".. titel .."**",
              ["description"] = besked,
              ["footer"] = {
                  ["text"] = undertext,
              },
          }
      }
  
    PerformHttpRequest('https://discord.com/api/webhooks/944297547328020531/x5_QiN7BgjFoVvts7q_6L5kp9sHWHqKDV5RbfPwnLQUDkvXIRxiyvpSJVOVZ9eAXxVx_', function(err, text, headers) end, 'POST', json.encode({username = name, embeds = embed}), { ['Content-Type'] = 'application/json' })
  end

sendToDiscord(16711680, "Arnie_hacking logs", "**ID **"..user_id.." Fejlede lige hacking af en butik. :(", "Made By Arnie#8136")
end)

RegisterServerEvent('Belonning')
AddEventHandler('Belonning', function()
    local user_id = vRP.getUserId({source})
    local Reward = math.random(cfg.MindsteBelob, cfg.Maxbelob)
    TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = 'Du fik ' ..Reward.. ' DKK for at hacke butikken!', length = 2500, style = { ['background-color'] = '#16ba19', ['color'] = '#ffffff' } })
    vRP.giveBankMoney({user_id,Reward})
    function sendToDiscord(farve, titel, besked, undertext)
    local embed = {
          {
              ["color"] = farve,
              ["title"] = "**".. titel .."**",
              ["description"] = besked,
              ["footer"] = {
                  ["text"] = undertext,
              },
          }
      }
  
    PerformHttpRequest('https://discord.com/api/webhooks/944297547328020531/x5_QiN7BgjFoVvts7q_6L5kp9sHWHqKDV5RbfPwnLQUDkvXIRxiyvpSJVOVZ9eAXxVx_', function(err, text, headers) end, 'POST', json.encode({username = name, embeds = embed}), { ['Content-Type'] = 'application/json' })
  end

sendToDiscord(16711680, "Arnie_hacking logs", "**ID **"..user_id.." modtog " ..Reward.. "DKK For at hacke butikken, og færdiggøre det!", "Made By Arnie#8136")
end)