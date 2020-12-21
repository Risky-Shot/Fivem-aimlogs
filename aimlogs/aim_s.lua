local hook = 'YOUR_WEBHOOK_LINK'

local dataTable = {}

RegisterServerEvent('aimlogs:log')
AddEventHandler('aimlogs:log', function(pedId)
    local _source = source
    local name = GetPlayerName(_source)
    local targetName = GetPlayerName(pedId)
    table.insert(dataTable, {pName = name , aiming = targetName})
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(60000)
		for k,v in pairs(dataTable) do
            if #dataTable ~= nil then
                PerformHttpRequest(hook, function(err, text, headers) end, 'POST', json.encode({embeds={{title="_**Aim Logs**__",description="\nPlayer name: "..v.pName.."\nis aiming: "..v.aiming.."",color=16711680}}}), { ['Content-Type'] = 'application/json' }) 
			end
		end
        dataTable = {}
	end
end)
