--[[
ideas:
make game speed up every X seconds
enemy's tiles makes you lose health
larger area of contiguous tiles makes you lose more
hitting walls makes you lose health
]]

display.setStatusBar(display.HiddenStatusBar)
require("string")

function main()
  initBoard()
end

function initBoard()
  local w = 20
  local h = 20
  local i
  local j
  local numx = display.contentWidth / w
  local numy = display.contentHeight / h
  local square
  for i=0, numx-1 do
    for j=0, numy do
      square = display.newRect(i*w, j*h, w, h)
      square:setFillColor(math.random(50,255))
    end
  end
end

local speed = 2
local xdirection, ydirection = 0, speed
local xpos, ypos = display.contentWidth / 2, display.contentHeight / 8
local radius = 20
local circle = display.newCircle( xpos, ypos, radius )
circle:setFillColor(255, 255, 255)
local direction = "left"


function touchScreen(event)
  if event.phase == "began"  and event.y > display.contentHeight / 2 then
    print("bottom")
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
    else --for when direction = "right"
      --TODO
    end
  elseif event.phase == "began" and event.y <= display.contentHeight / 2 then
    print("top")
  end
end
Runtime:addEventListener("touch", touchScreen)


--game loop
local tPrevious = system.getTimer()
function animate(event)
  local tDelta = event.time - tPrevious
  tPrevious = event.time
  xpos = xpos + (0.084*xdirection*tDelta)
  ypos = ypos + (0.066*ydirection*tDelta)

  if (xpos + xdirection + radius > display.contentWidth or xpos + xdirection < radius) then
    print("bounce-x")
    if xdirection > 0 then
      xpos = display.contentWidth - radius
    else
      xpos = 0 + radius
    end
    xdirection = xdirection * -1
  end

  if (ypos + ydirection + radius > display.contentHeight or ypos + ydirection < radius) then
    print("bounce-y")
    if ydirection > 0 then
      ypos = display.contentHeight - radius
    else
      ypos = 0 + radius
    end
    ydirection = ydirection * -1
  end
  circle:translate(xpos - circle.x, ypos - circle.y)

  --TODO
  --print(math.floor(system.getTimer()))
  local v = ((math.floor(system.getTimer())) % 100) 
  if v == 0 then 
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
