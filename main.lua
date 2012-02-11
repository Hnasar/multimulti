display.setStatusBar(display.HiddenStatusBar)
display.setDefault("background", 255, 255, 255)

local physics = require("physics")
physics.start()

local ssBM = display.newImage("spaceship.png")
ssBM.x = display.contentWidth/2
ssBM.y = display.contentHeight - ssBM.contentHeight/2

--[[
local ssBL = display.newImage("spaceship.png")
ssBL.x = display.contentWidth/4 -- + ssBM.contentWidth
ssBL.y = display.contentHeight - ssBL.contentHeight/2

local ssBR = display.newImage("spaceship.png")
ssBR.x = display.contentWidth*3/4 -- - ssBM.contentWidth
ssBR.y = display.contentHeight - ssBR.contentHeight/2
--]]

local function onTap(event)
  local missile = display.newImage("missile.png")
  missile.x = ssBM.x
  missile.y = ssBM.y-ssBM.contentHeight/2
  transition.to(missile, {time = 1000, y = -missile.contentHeight,
    onComplete = function(self) self.parent:remove(self); self = nil; end
  })
end

ssBM:addEventListener("tap", onTap)

physics.stop()

--local ss2 = display.newImage("spaceship.png");
--ss2:rotate(180)
--ss2.x = display.contentWidth/2
--ss2.y = ss1.contentHeight/2

