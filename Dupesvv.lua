-- FPS Stabilizer v1.0 (Luau)
-- Ổn định 5 FPS

local FPSStabilizer = {}
FPSStabilizer.__index = FPSStabilizer

function FPSStabilizer.new(): {}
    local self = setmetatable({}, FPSStabilizer)
    self.targetFPS = 5
    self.frameTime = 1 / 5 -- 0.2 second per frame
    self.lastFrameTime = os.clock()
    self.isRunning = false
    return self
end

-- Giữ FPS ổn định 5
function FPSStabilizer:WaitForFrame()
    local currentTime = os.clock()
    local elapsedTime = currentTime - self.lastFrameTime
    local waitTime = self.frameTime - elapsedTime
    
    if waitTime > 0 then
        -- Đợi để đạt 5 FPS
        os.execute("timeout /t " .. math.ceil(waitTime * 1000) / 1000)
    end
    
    self.lastFrameTime = os.clock()
end

-- Khởi động
function FPSStabilizer:Start()
    self.isRunning = true
    print("========== FPS STABILIZER ==========")
    print("Target FPS: 5")
    print("Frame Time: 0.2 seconds")
    print("Status: RUNNING ✓")
    print("====================================\n")
end

-- Dừng
function FPSStabilizer:Stop()
    self.isRunning = false
    print("[✓] FPS Stabilizer stopped")
end

-- Chạy 1 frame
function FPSStabilizer:RunFrame()
    if self.isRunning then
        self:WaitForFrame()
    end
end

-- Main
local function main()
    local stabilizer = FPSStabilizer.new()
    stabilizer:Start()
    
    print("Running 10 frames at 5 FPS...\n")
    
    for i = 1, 10 do
        local startTime = os.clock()
        stabilizer:RunFrame()
        local frameTime = os.clock() - startTime
        
        print("Frame " .. i .. " - Time: " .. string.format("%.3f", frameTime) .. "s")
    end
    
    stabilizer:Stop()
end

main()

return FPSStabilizer
