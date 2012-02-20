-- Libraries to include in the game
require('physics')

-- Setup of System
display.setStatusBar(display.HiddenStatusBar)

-- Globals 
last_paddle_hit = 1

p1_score = 0
p2_score = 0 






-- Grass
local baseline = 280
-- This is doubled so we can slide it
-- When one of the grass images slides offscreen, we move it all the way to the right of the next one.
local grass = display.newImage( "background.png" )
grass:setReferencePoint( display.CenterLeftReferencePoint )
grass.x = 0
grass.y = baseline - 20
local grass2 = display.newImage( "background.png" )
grass2:setReferencePoint( display.CenterLeftReferencePoint )
grass2.x = 280
grass2.y = baseline - 20

function main()
	setupPhysics()
	createWalls()
	createBricks()
	createBall()
	createPaddle1()
	createPaddle2()
	userInterface()
	startGame()
end

function userInterface()
	local player1 = display.newText("Player 1 Score: "..p1_score, 0,20,nil, 32)
	local player2 = display.newText("Player 2 Score: "..p2_score, 0,display.contentHeight-40,nil, 32)
end

function setupPhysics()
	physics.start()
	physics.setDrawMode("hybrid")
	physics.setGravity(0,0)
end

function startGame()
	if(last_paddle_hit <2) then
		ball:setLinearVelocity(150,250)
	else
		ball:setLinearVelocity(150,-250)
	end
end


function createPaddle1()

	local paddleWidth = 100
	local paddleHeight = 10
	
	local paddle = display.newRect(display.contentWidth/2-paddleWidth/2, display.contentHeight-50,paddleWidth,paddleHeight)
	physics.addBody(paddle, "static",{friction=0,bounce=1})
	
	paddle.type = "paddle1"
	
			local movePaddle1 = function(event)	
				if (event.y > display.contentHeight*0.5) then
					if(event.x < paddleWidth*0.5 or event.x > display.contentWidth-paddleWidth*0.5) then
						print("Out of bounds for paddle 1")
					else
						paddle.x = event.x
					end
				end
			end
	Runtime:addEventListener("touch",movePaddle1)
	
end

function createPaddle2()

	local paddleWidth = 100
	local paddleHeight = 10
	
	local paddle = display.newRect(display.contentWidth/2-paddleWidth/2, 50,paddleWidth,paddleHeight)
	physics.addBody(paddle, "static",{friction=0,bounce=1})
	
	paddle.type = "paddle2"
	
		local movePaddle2 = function(event)
			if (event.y < display.contentHeight*0.5) then
					if(event.x < paddleWidth*0.5 or event.x > display.contentWidth-paddleWidth*0.5) then
						print("Out of bounds for paddle 2")
					else
						paddle.x = event.x
					end
			end
		end

	Runtime:addEventListener("touch",movePaddle2)	
end




function createBall()
	local ballRadius = 10
	
	ball = display.newCircle( display.contentWidth / 2 , display.contentHeight/1.5 , ballRadius)
	physics.addBody(ball, "dynamic", {friction=0, bounce =1, radius=ballRadius})
	
	ball.collision = function(self,event)
		if(event.phase == "ended") then
		
			-- Remove the brick
			if(event.other.type == "destructible") then
				event.other:removeSelf()

				print(last_paddle_hit)
				
				if(event.other.type == "paddle1") then
					_G["p1_score"] = _G["p1_score"]+1
				end
				if(event.other.type == "paddle2") then
					_G["p2_score"] = _G["p2_score"] + 1
				end
			end
			
			-- Remove the ball
			if(event.other.type == "bottomWall" or event.other.type == "topWall") then
				 -- Subtrack appropriate points from each player
				 if(event.other.type == "topWall") then
					_G["p1_score"] = _G["p1_score"] - 5
					print("player 1 score"..p1_score)
				 end
				 if(event.other.type == "bottomWall") then
					_G["p2_score"] = _G["p2_score"] - 5
					print("player 2 score"..p2_score)
				 end
				 print(event.other.type)
				 self:removeSelf()
				
				-- Create a new ball once we have passed throught the bottom wall.
				local onTimerComplete = function(event)
					createBall()
					startGame()
				end
				
				-- Create a 500ms delay to start again.
				timer.performWithDelay(500,onTimerComplete,1)
			end
			
			
			
		end
	end
	
	ball:addEventListener("collision",ball)
end


function createBricks()
	local brickWidth = 40
	local brickHeight = 20
	
	local numOfRows = 4
	local numOfCols = 6
	
	local topLeft = {x= display.contentWidth*0.5 - (brickWidth * numOfCols)*0.5, y= (display.contentHeight/2)-(numOfRows*brickHeight/2) }
	
	local row
	local col
	
	-- Creates a grid of bricks for the user to knock out.
	for row = 0, numOfRows -1 do
		for col = 0, numOfCols -1 do
			-- Create a brick
			local brick = display.newRect( topLeft.x + (col*brickWidth), topLeft.y + (row * brickHeight), brickWidth, brickHeight)
			brick:setFillColor(math.random(50,155), math.random(50,155),math.random(50,255),155)
			brick.type = "destructible"
			
			physics.addBody(brick, "static", {friction=0,bounce = 1})
		end
	end

end


function createWalls()
	local wallThickness = 10
	
	--left wall
	local wall = display.newRect(0,0,wallThickness, display.contentHeight)
	physics.addBody(wall, "static", {fricton=0,bounce=1})
	wall.type = "leftWall"
	
	--top wall
	local wall = display.newRect(0,0,display.contentWidth,wallThickness)
	physics.addBody(wall, "static", {fricton=0,bounce=1})
	wall.type = "topWall"
	
	--Right wall
	local wall = display.newRect(display.contentWidth-wallThickness,0,wallThickness,display.contentHeight)
	physics.addBody(wall, "static", {fricton=0,bounce=1})
	wall.type = "rightWall"
	
	--Bottom wall
	local wall = display.newRect(0, display.contentHeight-wallThickness, display.contentWidth, wallThickness)
	physics.addBody(wall, "static", {fricton=0,bounce=1})
	wall.type = "bottomWall"
end


	

main()
