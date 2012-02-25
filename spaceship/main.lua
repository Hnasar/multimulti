--INITIALIZATION--
display.setStatusBar(display.HiddenStatusBar)
display.newImage( "resources/starrybg-white.png", 0, 0 )
system.activate("multitouch")

local physics = require("physics")
physics.start()
physics.setGravity(0,0)

--MAKING BUTTONS--
local buttonArrB = {}
local buttonArrT = {}
local ssB
local ssT
local timeLastBullet = 0

local function makeButtons()
  local w, h = display.contentWidth/3, display.contentWidth/3
  local function makeButton(x,y,w,h)
    local rect = display.newRect(x,y,w,h)
    rect:setFillColor(10,10,10)
    rect.alpha = 0.04
    return rect
  end

  for i=1, 3 do
    buttonArrB[i] = makeButton(display.contentWidth*(i-1)/3, display.contentHeight-h, w, h)
    buttonArrT[i] = makeButton(display.contentWidth*(i-1)/3, 0, w, h)
  end

  local function moveShipB(event)
    local button = event.target
    transition.to(ssB, {time=100, alpha=1.0, x=button.x, y=button.y})
  end

  local function moveShipT(event)
    local button = event.target
    transition.to(ssT, {time=100, alpha=1.0, x=button.x, y=button.y})
  end

  for i=1, 3 do
    buttonArrB[i]:addEventListener("touch", moveShipB)
    buttonArrT[i]:addEventListener("touch", moveShipT)
  end


end

makeButtons()


--MAKING SHIP--


--physics.addbody(ssT)
--ssB:addEventHandler('collision', collisionHandler)

--MAKING BUTTONS MOVE SHIP--

--[[
local ships = {}
]]--


local function shoot(event)
  if event.time - timeLastBullet >= 500 then
    local missileB = display.newImage("missile.png")
    missileB.x = ssB.x
    missileB.y = ssB.y-ssB.contentHeight/2
    physics.addBody(missileB)
    transition.to(missileB, {time = 1500, y = -missileB.contentHeight,
      onComplete = function(self) self.parent:remove(self); self = nil; end
    })
    local missileT = display.newImage("missile.png")
    missileT:rotate(180)
    missileT.x = ssT.x
    missileT.y = ssT.y-ssT.contentHeight/2
    physics.addBody(missileT)
    transition.to(missileT, {time = 1500, y = display.contentHeight+missileT.contentHeight,
      onComplete = function(self) self.parent:remove(self); self = nil; end
    })
    timeLastBullet = event.time
  end
end

Runtime:addEventListener("enterFrame", shoot)


local function collisionHandler(event)
  print("BOOM!!")
  display.remove(event.target)
end

local function makeShips()
  ssB = display.newImage("spaceship.png")
  ssB.x = buttonArrB[2].x
  ssB.y = buttonArrB[2].y

  ssT = display.newImage("spaceship.png")
  ssT:rotate(180)
  ssT.x = buttonArrT[2].x
  ssT.y = buttonArrT[2].y

  physics.addbody(ssB)
  physics.addbody(ssT)
  ssB:addEventListener("collision", collisionHandler)
  ssT:addEventListener("collision", collisionHandler)

end

makeShips()



--MAKE SHOOTING--

physics.stop()


