--[[
░█████╗░██████╗░███╗░░██╗██╗███████╗
██╔══██╗██╔══██╗████╗░██║██║██╔════╝
███████║██████╔╝██╔██╗██║██║█████╗░░
██╔══██║██╔══██╗██║╚████║██║██╔══╝░░
██║░░██║██║░░██║██║░╚███║██║███████╗
╚═╝░░╚═╝╚═╝░░╚═╝╚═╝░░╚══╝╚═╝╚══════╝
--]]

-- Variabler --
LigeRoevet = false
HackingGennemfoert = false
KobletTeli = false
HeleHackGennemfort = false

Citizen.CreateThread(function()
    while true do
       Citizen.Wait(1)
       if LigeRoevet == false then
       for k,v in pairs(cfg.Butik) do
        DrawMarker(2, v[1], v[2], v[3], 0, 0, 0, 0, 0, 0, 1.0, 1.0, 0.5001, 217, 28, 28, 200, 0, 0, 0, 50)
        if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), v[1], v[2], v[3]) < 1 then
            DrawText3Ds(v[1], v[2], v[3]+0.15, "~r~[F]~w~ - Hack Butikken")
            if IsControlJustPressed(1, 23) then
               TriggerEvent("mhacking:show")
               TriggerEvent("mhacking:start",2,25,mycb)
                TriggerServerEvent('TagStik')
              Citizen.Wait(1000)
              end
           end
         end
       end
    end
end)

RegisterCommand("sej", function()
  TriggerServerEvent('AlertCops')
end)

Citizen.CreateThread(function()
    while true do
    Citizen.Wait(1)
    if LigeRoevet == true then
        for k,v in pairs (cfg.Butik) do
            DrawMarker(2, v[1], v[2], v[3], 0, 0, 0, 0, 0, 0, 1.0, 1.0, 0.5001, 217, 28, 28, 200, 0, 0, 0, 50)
        if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), v[1], v[2], v[3]) < 1 then
            DrawText3Ds(v[1], v[2], v[3]+0.15, "~r~[F]~w~ - Hack Butikken")
            if IsControlJustPressed(1, 23) then
                exports['mythic_notify']:DoHudText('error', 'Du har lige hacket en butik du kan ikke gøre det igen før om lang tid!', { ['g'] = '#ffffff', ['w'] = '#000000' })
            end       
        end
    end
end
    end
    end)

    Citizen.CreateThread(function()
        while true do
        Citizen.Wait(1)
        if KobletTeli == false then
       if HackingGennemfoert == true then
          for k,v in pairs (cfg.KobleTel) do
            if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), v[1], v[2], v[3]) < 1 then
                DrawText3Ds(v[1], v[2], v[3]+0.15, "~r~[F]~w~ - Kobl telefon")
                if IsControlJustPressed(1, 23) then
                    Citizen.Wait(1000)
                    exports['progressBars']:startUI(7000, "Kobler telefon til pc...")
                    RequestAnimDict("amb@prop_human_parking_meter@male@base")
                    while not HasAnimDictLoaded("amb@prop_human_parking_meter@male@base") do
                        Citizen.Wait(100)
                    end
                    TaskPlayAnim(PlayerPedId(-1), "amb@prop_human_parking_meter@male@base", "base", 8.0, 8.0, -1, 1, 0, 0, 0, 0)
                    Wait(7000)
                    ClearPedTasks(PlayerPedId())
                    KobletTeli = true
                    exports['mythic_notify']:DoHudText('inform', 'Du har koblet din telefon til pcen, kør til din GPS og færdiggøre det der', { ['g'] = '#ffffff', ['w'] = '#000000' })
                    TriggerEvent('GPS:Fuldførehack')
                  end
         end
        end
      end
    end
    end
  end)


  Citizen.CreateThread(function()
    while true do
    Citizen.Wait(1)
    if KobletTeli == true then
   if HeleHackGennemfort == false then
      for k,v in pairs (cfg.FinishHack) do
        if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), v[1], v[2], v[3]) < 1 then
            DrawText3Ds(v[1], v[2], v[3]+0.15, "~r~[E]~w~ - Færdiggør hacking")
            if IsControlJustPressed(1, 38) then
              exports['progressBars']:startUI(7000, "Fuldføre hacket...")
              RequestAnimDict("amb@prop_human_parking_meter@male@base")
              while not HasAnimDictLoaded("amb@prop_human_parking_meter@male@base") do
                  Citizen.Wait(100)
              end
              TaskPlayAnim(PlayerPedId(-1), "amb@prop_human_parking_meter@male@base", "base", 8.0, 8.0, -1, 1, 0, 0, 0, 0)
                    Wait(7000)
                    ClearPedTasks(PlayerPedId())
              HeleHackGennemfort = true
              Citizen.Wait(2000)
              TriggerServerEvent('Belonning')
            end
          end
        end
      end
end
end
end)

RegisterNetEvent('GPS:Fuldførehack')
AddEventHandler('GPS:Fuldførehack', function()
local player = GetPlayerPed(-1)
SetNewWaypoint(1275.7357177734,-1710.4270019531,54.771453857422)
end)

function mycb(success, timeremaining)
    if success then
      TriggerEvent("mhacking:hide")
      FreezeEntityPosition(PlayerPedId(), true)
      FreezeEntityPosition(PlayerPedId(), false)
      exports['mythic_notify']:DoHudText('success', 'Du hackede computeren! Nu skal du lige koble din telefon til så den kan overfør alle pengene!', { ['g'] = '#ffffff', ['w'] = '#000000' })
      LigeRoevet = true
      HackingGennemfoert = true
    else
      TriggerEvent("mhacking:hide")
      ClearPedTasks(PlayerPedId())
      FreezeEntityPosition(PlayerPedId(), false)
      exports['mythic_notify']:DoHudText('error', 'Du fejlede! Skynd dig væk!', { ['g'] = '#ffffff', ['w'] = '#000000' })
      LigeRoevet = true
      TriggerServerEvent('Fejled')
    end
  end
                        

-- 3D TEXT -- 
    function DrawText3Ds(x,y,z, text)
        local onScreen,_x,_y=World3dToScreen2d(x,y,z)
        local px,py,pz=table.unpack(GetGameplayCamCoords())

        SetTextScale(0.35, 0.35)
        SetTextFont(4)
        SetTextProportional(1)
        SetTextColour(255, 255, 255, 215)
        SetTextEntry("STRING")
        SetTextCentre(1)
        AddTextComponentString(text)
        DrawText(_x,_y)
        local factor = (string.len(text)) / 370
        DrawRect(_x,_y+0.0125, 0.015+ factor, 0.03, 20, 20, 20, 150)
    end