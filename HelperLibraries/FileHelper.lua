--[[ 
File Helper Library:
Written by: Mike Shah 2/25/12
Last Edited by: Mike Shah 2/25/12

Functions available:
-readFileAndPrintToConsole
-writeToFile
-appendToFile
-readFromFile

--]]





--[[
	Useful debugging function that prints out contents of
	a file to the console.
--]]
function readFileAndPrintToConsole( fileName,baseDirectory)
	local baseDirectory = baseDirectory or system.DocumentsDirectory
	local path = system.pathForFile(fileName,baseDirectory)
	local file = io.open(path,"r")
	for line in file:lines() do
		print(line.."\n")
	end
	io.close(file)
end


--[[ Writes a piece of data into an existing file.
	If a file does not exist, it will be created.
	If a file does exist, it will be overwritten with the new data.
--]]
function writeToFile(data, fileName,baseDirectory)
	local baseDirectory = baseDirectory or system.DocumentsDirectory
		
	if baseDirectory == system.ResourceDirectory then
		native.showAlert("Warning","Writing to ResourceDirectory may break integrity of program, please try documents, temp, or cache directory. File NOT written")
	else
		local path = system.pathForFile(fileName,baseDirectory)
		local file = io.open(path,"w")
		file:write(data)
		io.close(file)
	end
end

--[[ Appends(or Adds) a single piece of data at the end of an existing file.
--]] 
function appendToFile(data, fileName,baseDirectory)
	local baseDirectory = baseDirectory or system.DocumentsDirectory
	
	if baseDirectory == system.ResourceDirectory then
		native.showAlert("Warning","Appending to ResourceDirectory may break integrity of program, please try documents, temp, or cache directory. File NOT appended")
	else
		local path = system.pathForFile(fileName,baseDirectory)
		local file = io.open(path,"a+")
		file:write(data)
		io.close(file)
	end
end

--[[ Reads the entire contents of a file, and returns the
 contents in data.
 --]]
function readFromFile(fileName, baseDirectory)
	local baseDirectory = baseDirectory or system.ResourceDirectory
	local path = system.pathForFile(fileName, baseDirectory)
	local file = io.open(path,"r")
	local data = file:read("*a")
	io.close(file)
	return data
end


function unitTest1() -- Expected to Pass and give us 3 lines of output
	writeToFile("1st write","writeTest.txt",system.DocumentsDirectory)
	readFileAndPrintToConsole("writeTest.txt",system.DocumentsDirectory)
	appendToFile("\n2nd write with append","writeTest.txt",system.DocumentsDirectory)
	readFileAndPrintToConsole("writeTest.txt",system.DocumentsDirectory)
	local data = readFromFile("writeTest.txt",system.DocumentsDirectory)
end
function unitTest2() -- Expected to give a warning
	writeToFile("1st write","writeTest.txt",system.ResourceDirectory)
end

--[[
Unit Test functions
--]]	
unitTest1() -- Expected to Pass
unitTest2() -- Expected to give a warning
	

	
--[[ More information here

http://blog.anscamobile.com/2012/02/reading-and-writing-files-in-corona/

--]]

	