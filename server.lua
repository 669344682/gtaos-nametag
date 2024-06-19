local players = {}


RegisterServerEvent("QBCore:Server:PlayerLoaded",function(source)
    -- local id = QBCore.Functions.GetPlayer(source)
    local id = source.PlayerData.source
    players[id] = {
        cid = source.PlayerData.cid,
        firstname = source.PlayerData.charinfo.firstname,
        lastname = source.PlayerData.charinfo.lastname,
        source = source.PlayerData.source,

        joblabel = source.PlayerData.job.label or '平民',
        jobgradelevel = source.PlayerData.job.grade.level or '0',
        jobgradeName = source.PlayerData.job.grade.name or '无',
        jobduty = source.PlayerData.job.onduty or false,
        permission = QBCore.Functions.HasPermission(source.PlayerData.source, 'admin') or false
    }
    --print("nametag server")
    TriggerClientEvent("gtaos-nametag:client:updatePlayer",-1,players)
end)

RegisterServerEvent("QBCore:Server:OnPlayerUnload",function(source)
    local id = source.PlayerData.source
    players[id] = nil
    TriggerClientEvent("gtaos-nametag:client:updatePlayer",-1,players)
end)

AddEventHandler('playerDropped', function (reason)
    if players[source] then
        players[source] = nil
        TriggerClientEvent("gtaos-nametag:client:updatePlayer",-1,players)
    end
end)
  
CreateThread(function()
    while true do
        Wait(1000*5)
        for key, value in pairs(QBCore.Functions.GetQBPlayers()) do
            players[key] = {
                cid = value.PlayerData.cid,
                firstname = value.PlayerData.charinfo.firstname,
                lastname = value.PlayerData.charinfo.lastname,
                source = value.PlayerData.source,

                permission = QBCore.Functions.HasPermission(value.PlayerData.source, 'admin') or false,
            }
        end
        TriggerClientEvent("gtaos-nametag:client:updatePlayer",-1,players)
        -- print(json.encode(players))
    end
end)