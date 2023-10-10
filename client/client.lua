local RSGCore = exports['rsg-core']:GetCoreObject()

-- example:
-- dict = 'ai_gestures@gen_male@standing@speaker',
-- clip = 'empathise_headshake_f_001',
-- flag = 15

function LoadAnimationDic(dict)
  if not HasAnimDictLoaded(dict) then
      RequestAnimDict(dict)
      while not HasAnimDictLoaded(dict) do
          Citizen.Wait(0)
      end
  end
end

-- anim input
RegisterNetEvent('rsg-animtester:client:test', function()
    local input = lib.inputDialog('Animation Tester', {
        { 
            label = 'animDictionary',
            type = 'input',
            required = true,
        },
        { 
            label = 'animationName',
            type = 'input',
            required = true,
        },
        { 
            label = 'flag',
            type = 'number',
            required = true,
        },
    })
    if not input then return end
    
    TriggerEvent('rsg-animtester:client:dotest', input[1], input[2], input[3])

end)

RegisterNetEvent('rsg-animtester:client:dotest', function(dict, name, flag)
    LoadAnimationDic(dict)
    TaskPlayAnim( PlayerPedId(), dict, name, 2.0, 0, -1, flag, 0, 0, 0, 0)
    print(dict, clip, flag)
end)

RegisterNetEvent('rsg-animtester:client:stop', function()
    ClearPedTasks(PlayerPedId())
end)