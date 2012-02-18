display.setStatusBar(display.HiddenStatusBar)
display.setDefault("background", 255, 255, 255)

local physics = require("physics")
physics.start()

--MAKING OBJECTS--

local function makeButton(x,y,w,h)
  local rect = display.newRect(x,y,w,h)
  rect:setFillColor(10,10,10)
  rect.alpha = 0.08
  return rect
end


local w, h = display.contentWidth/3, display.contentWidth/3
local buttonArr = {}

for i=1, 3 do
  buttonArr[i] = makeButton(display.contentWidth*(i-1)/3, display.contentHeight-h, w, h)
end

local ssB = display.newImage("spaceship.png")
ssB.x = buttonArr[2].x
ssB.y = buttonArr[2].y

local listener = function(obj)
  print("Transitioning...")
end

local function moveShip(event)
  local button = event.target
  transition.to(ssB, {time=200, alpha=1.0, x=button.x, y=button.y, onComplete=listener})
end

for i=1, 3 do
  buttonArr[i]:addEventListener("tap", moveShip)
end

--[[
local function onTap(event)
  local missile = display.newImage("missile.png")
  missile.x = ssB.x
  missile.y = ssB.y-ssB.contentHeight/2
  transition.to(missile, {time = 1000, y = -missile.contentHeight,
    onComplete = function(self) self.parent:remove(self); self = nil; end
  })
end
ssB:addEventListener("tap", onTap)
]]--
local timeLastBullet = 0
local function mainLoop(event)
    if event.time - timeLastBullet >= 300 then
      local missile = display.newImage("missile.png")
      missile.x = ssB.x
      missile.y = ssB.y-ssB.contentHeight/2
      transition.to(missile, {time = 1000, y = -missile.contentHeight,
        onComplete = function(self) self.parent:remove(self); self = nil; end
      })
      timeLastBullet = event.time
    end
end


Runtime:addEventListener("enterFrame", mainLoop)

physics.stop()

--local ss2 = display.newImage("spaceship.png");
--ss2:rotate(180)
--ss2.x = display.contentWidth/2
--ss2.y = ss1.contentHeight/2

