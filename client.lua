
local troggle = true
local showMyName = true
local showID = true 

local players = {}

local admintxd = CreateRuntimeTxd("admin")
local admintx = CreateRuntimeTextureFromImage(admintxd, "admin", "asset/admin.png")


RegisterNetEvent("gtaos-nametag:client:updatePlayer",function(data)
    players = data
end)


CreateThread(function()
    while true do
        Wait(1)
        if troggle then
            if players then
                for k,v in pairs(players) do
                    if NetworkIsPlayerActive(GetPlayerFromServerId(v.source)) then
                        if v.source == GetPlayerPed(-1) then
                            if not showMyName then
                                print(1)
                                ::continue::
                            end
                        end
                        local coords = getPedHeadCoords(GetPlayerPed(GetPlayerFromServerId(v.source)))
                        local camCoords = GetGameplayCamCoord()
                        if #(coords-camCoords) < STREAM_DISTANCE then
                            DrawText3D(
                                coords, 
                                {
                                    { text = v.lastname.." "..v.firstname, color = { 255, 255, 255 } ,pos = { -0.01, -0.01 }},
                                    showID and { text = "[".. k .."]", color = { 0, 255, 0 }, pos = { -0.03, -0.01 }} or nil,
                                    MumbleIsPlayerTalking(v.souce) or NetworkIsPlayerTalking(v.souce) and {
                                        text = SPEAK_ICON,
                                        pos = { -0.1, 0 },
                                        color = { 0, 198, 185 },
                                        scale = 0.4,
                                    } or nil,
                                },
                                0.8, 
                                255
                            )
                            if v.permission then
                                local bool, screenX, screenY = GetScreenCoordFromWorldCoord(
                                    coords.x, 
                                    coords.y, 
                                    coords.z
                                )
                                -- DrawMarker(
                                --     43,
                                --     coords + vector3(0, 0, 0.15),
                                --     vector3(0, 0, 0),
                                --     vector3(89.9, 180, 0),
                                --     vector3(ADMINLOGO.width, ADMINLOGO.height, 0),
                                --     255,
                                --     255,
                                --     255,
                                --     255,
                                --     false, --up-down anim
                                --     true, --face cam
                                --     0,
                                --     ADMINLOGO.rotate, --rotate
                                --     "admin",
                                --     "admin",
                                --     false --[[drawon ents]]
                                -- )
                            end
                        end
                    end
                end
            end
        end
    end
end)