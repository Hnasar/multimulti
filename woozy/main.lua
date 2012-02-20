local physics = require("physics")

function main ()
  initPhysics()
  initWalls()
  --initSnakes()
  --start()
end

function initPhysics()
  physics.start()
  physics.setDrawMode("hybrid")
  physics.setGravity(0,0)
end
function initWall()

end

--[[
local speed = 5
local xdirection, ydirection = 0, speed
local xpos, ypos = display.contentWidth / 2, display.contentHeight / 8
local radius = 20
local circle = display.newCircle( xpos, ypos, radius )
circle:setFillColor(255, 255, 255)
local direction = "left"

local function touchScreen(event)
  if event.phase == "began" then
    if direction == "left" then
      if ydirection > 0 then
        xdirection = speed
        ydirection = 0
      elseif ydirection < 0 then
        xdirection = -speed
        ydirection = 0
      elseif xdirection > 0 then
        xdirection = 0
        ydirection = -speed
      elseif xdirection < 0 then
        xdirection = 0
        ydirection = speed
      end
    end
  end
end
Runtime:addEventListener("touch", touchScreen)


local tPrevious = system.getTimer()
local function animate(event)
  local tDelta = event.time - tPrevious
  tPrevious = event.time
  xpos = xpos + (0.084*xdirection*tDelta)
  ypos = ypos + (0.066*ydirection*tDelta)

  if (xpos > display.contentWidth - 20 or xpos < 20) then
    xdirection = xdirection * -1
  end
  if (ypos > display.contentHeight - 20 or ypos < 20) then
    ydirection = ydirection * -1
  end
  circle:translate(xpos - circle.x, ypos - circle.y)

  --TODO
  if not system.getTimer() % 5000 then 
    print "switching"
  end
end
Runtime:addEventListener("enterFrame", animate)

local tSuspend
local function onSuspendResume (event)
  if "applicationSuspend" == event.type then
    tSuspend = system.getTimer()
  elseif "applicationResume" == event.type then
    tPrevious = tPrevious + ( system.getTimer() - tSuspend )
  end
end
Runtime:addEventListener("system", onSuspendResume)
]]--
