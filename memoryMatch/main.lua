-- Setup
display.setStatusBar(display.HiddenStatusBar);

-- Globals
_W = display.contentWidth;
_H = display.contentHeight;

local totalButtons = 0
local secondSelect = 0
local checkForMatch = false

x = -20

-- Button Tables
local button = {}
local buttonCover = {}
local buttonImages = {1,1, 2,2,3,3,4,4,5,5,6,6}

local lastButton = display.newImage("1.png");
lastButton.myName = 1;

--Background
local myRectangle = display.newRect(0,0,_W,_H)
myRectangle:setFillColor(235,235,235)

--Notifications
local matchText = display.newText(" ",0,0,native.systemFont,26)
matchText:setReferencePoint(display.CenterReferencePoint)
matchText:setTextColor(0,0,0)
matchText.x = _W/2 

-- Playing the game
function game(object,event)
		if(event.phase =="began") then
			if(checkForMatch == false and secondSelect == 0) then
			--Flip over first button
			buttonCover[object.number].isVisible = false;
			lastButton = object
			checkForMatch = true
			elseif(checkForMatch == true) then
				if(secondSelect==0) then
				--Flip over second button
				buttonCover[object.number].isVisible = false;
				secondSelect = 1;
					if(lastButton.myName ~= object.myName) then
						matchText.text = "Match Not Found!";
						timer.performWithDelay(1250,function() matchText.text = " ";
													checkForMatch = false;
													secondSelect = 0;
													buttonCover[lastButton.number].isVisible = true;
													buttonCover[object.number].isVisible = true;
												end, 1)
					elseif(lastButton.myName == object.myName) then
						matchText.text = "Match Found!";
						timer.performWithDelay(1250,function() 
													matchText.text = " ";
													checkForMatch = false;
													secondSelect = 0;
													lastButton:removeSelf();
													object:removeSelf();		
													buttonCover[lastButton.number]:removeSelf();
													buttonCover[object.number]:removeSelf();
												end, 1)
					end
				end
			end
		end
end

--Place buttons on screen
for count = 1,3 do
	x = x + 90
	y = 20
		for insideCount = 1,4 do
			y = y + 90
			temp = math.random(1,#buttonImages)
			button[count] = display.newImage(buttonImages[temp]..".png");
			--Position the button
			button[count].x = x;
			button[count].y = y;
			
			-- Give buttons names
			button[count].myName = buttonImages[temp]
			button[count].number = totalButtons
			-- Remove button from buttom Images table
			table.remove(buttonImages,temp)
			
			-- Set a cover to hide the button image
			buttonCover[totalButtons] = display.newImage("button.png");
			buttonCover[totalButtons].x = x;
			buttonCover[totalButtons].y = y;
			totalButtons = totalButtons + 1;
			
			-- Attach a listener to each button
			button[count].touch = game
			button[count]:addEventListener("touch",button[count])
			
		end
end
