display.setStatusBar(display.HiddenStatusBar)
local sprite = require("sprite")


local myCloud = display.newImage("images/myCloud.png")
myCloud.x = 200
myCloud.y=50
myCloud.alpha = 0.75

local background = display.newImage("images/background.png")
background.x = 240
background.y = 160
background.alpha = 0.5

local backgroundfar = display.newImage("images/bgfar1.png")
backgroundfar.x = 480
backgroundfar.y = 160
backgroundfar.alpha = 0.5

local backgroundnear1 = display.newImage("images/bgnear2.png")
backgroundnear1.x = 240
backgroundnear1.y = 160
backgroundnear1.alpha = 0.5

local backgroundnear2 = display.newImage("images/bgnear2.png")
backgroundnear2.x = 760
backgroundnear2.y = 160
backgroundnear2.alpha = 0.5

-- Our hero character
local spriteSheet = sprite.newSpriteSheet("images/monsterSpriteSheet.png",100,100)
local monsterSet = sprite.newSpriteSet(spriteSheet,1,7)
sprite.add(monsterSet,"running",1,6,600,0)
sprite.add(monsterSet,"jumping",7,7,1,1)
hero = sprite.newSprite(monsterSet)

x = display.contentWidth/2
y = display.contentHeight-70
right = true
hero.x = x
hero.y = y


local blocks = display.newGroup()
local speed = 5
local groundMin = 420
local groundMax = 340
local groundLevel = groundMin

for a =1,8,1 do
	isDone = false
	numGen = math.random(2)
	local newBlock
	print(numGen)
	if(numGen == 1 and isDone == false) then
		newBlock = display.newImage("images/ground1.png")
		isDone = true
	end
	if(numGen == 2 and isDone == false) then
		newBlock = display.newImage("images/ground2.png")
		isDone = true
	end
	
	newBlock.name = ("block"..a)
	newBlock.id = a

	newBlock.x = (a*79)-79
	newBlock.y = groundLevel
	blocks:insert(newBlock)
end

hero:prepare("running")

function moveHero(event)
	if(event.x > hero.x) then
		hero.x = hero.x +3
	else
		hero.x = hero.x -3
	end
end

function update(event)
	
	moveHero("touch")

	
	if(right) then
		hero.x = hero.x +3
	else
		hero.x = hero.x -3
	end
	if(hero.x > 380) then
		right = false
		hero.xScale = -1
	end
	if(hero.x < -1) then
		right = true
		hero.xScale = 1
	end

	speed = speed + 0.005
	updateBackgrounds()
	updateBlocks()
	updateClouds()
	
	hero:play()
	
end

function updateBlocks()
	for a = 1,blocks.numChildren,1 do
		if(a>1) then
			newX = (blocks[a-1]).x + 79
		else
			newX = (blocks[8]).x + 79 - speed
		end
		
		if((blocks[a]).x<-40) then
			(blocks[a]).x, (blocks[a]).y = newX,(blocks[a]).y
		else
			(blocks[a]):translate(speed*-1,0)
		end
	end
end

function updateClouds()
	myCloud.x = myCloud.x - (speed/15)
	if(myCloud.x < -120) then
		myCloud.x = 400
	end
end

function updateBackgrounds()
backgroundfar.x = backgroundfar.x - (speed/55)
backgroundnear1.x = backgroundnear1.x - (speed/5)
	if(backgroundnear1.x < -239) then
		backgroundnear1.x = 760
	end
	
backgroundnear2.x = backgroundnear2.x - (speed/5)
	if(backgroundnear2.x < -239) then
		backgroundnear2.x = 760
	end
end


timer.performWithDelay(1,update,-1)