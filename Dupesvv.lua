local TeleportService = game:GetService("TeleportService")
local Players = game:GetService("Players")

local placeId = game.PlaceId  -- Use the current place ID, or change to another in your universe

-- Connect the button click event

    -- Check if we're in a place that supports reserved servers (same universe)
if not TeleportService:IsAsyncTeleportAllowedToPlaceId(placeId) then
    warn("Cannot teleport to this place ID. Ensure it's in the same universe.")
    return
end

-- Create a reserved server (new and empty)
local success, code = pcall(function()
    return TeleportService:ReserveServer(placeId)
end)

if success and code then
    print("Reserved server code: " .. code)  -- For debugging
    -- Teleport the local player to the private server
    TeleportService:TeleportToPrivateServer(placeId, code, {Players.LocalPlayer})
else
    warn("Failed to reserve server: " .. tostring(code))  -- Error handling
end
