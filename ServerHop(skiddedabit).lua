local HttpService = game:GetService("HttpService")
local TeleportService = game:GetService("TeleportService")
local Players = game:GetService("Players")
local PlaceId = game.PlaceId
local JobId = game.JobId

local function ServerHop()
    if httprequest then
        local servers = {}
        local req = httprequest({Url = string.format("https://games.roblox.com/v1/games/%d/servers/Public?sortOrder=Desc&limit=100&excludeFullGames=true", PlaceId)})
        local body = HttpService:JSONDecode(req.Body)

        if body and body.data then
            for i, v in next, body.data do
                if type(v) == "table" and tonumber(v.playing) and tonumber(v.maxPlayers) and v.playing < v.maxPlayers and v.id ~= JobId then
                    table.insert(servers, 1, v.id)
                end
            end
        end

        if #servers > 0 then
            TeleportService:TeleportToPlaceInstance(PlaceId, servers[math.random(1, #servers)], Players.LocalPlayer)
            return true
        else
            return false, "Serverhop", "Couldn't find a server."
        end
    else
        return false, "Incompatible Exploit", "Your exploit does not support this command (missing request)"
    end
end

return ServerHop
