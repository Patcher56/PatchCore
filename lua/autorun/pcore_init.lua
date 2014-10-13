--------------------
--  CREATE TABLES --
--------------------

PCore = {}

if CLIENT then

	PCore.derma = {}

end

--COMPILER:STOP



-------------------------
--  LOAD SHARED FILES  --
-------------------------

-- Loads all shared files
local shared_files, shared_directories = file.Find( "patchcore/shared/*", "LUA" )
table.foreach( shared_directories, function( key, dir ) -- Loop all directories

	local files = file.Find( "patchcore/shared/" .. dir .. "/*.lua", "LUA" )
	table.foreach( files, function( key, file )

		AddCSLuaFile("patchcore/shared/" .. dir .. "/" .. file )
		include( "patchcore/shared/" .. dir .. "/" .. file )

	end )

end )

table.foreach( shared_files, function( key, file ) -- Loop files in shared folder

	AddCSLuaFile("patchcore/shared/" .. file )
	include( "patchcore/shared/" .. file )

end )



-------------------------
--  LOAD CLIENT FILES  --
-------------------------

AddCSLuaFile()

--Loads all client files
local client_files, client_directories = file.Find( "patchcore/client/*", "LUA" )
table.foreach( client_directories, function( key, dir ) -- Loop all directories

	local files = file.Find( "patchcore/client/" .. dir .. "/*.lua", "LUA" )
	table.foreach( files, function( key, file )

		AddCSLuaFile("patchcore/client/" .. dir .. "/" .. file )
		if CLIENT then
			include( "patchcore/client/" .. dir .. "/" .. file )
		end

	end )

end )

table.foreach( client_files, function( key, file ) -- Loop files in client folder

	AddCSLuaFile("patchcore/client/" .. file )
	if CLIENT then
		include( "patchcore/client/" .. file )
	end

end )



-------------------------
--  LOAD SERVER FILES  --
-------------------------

-- Loads all server files
if SERVER then

	local server_files, server_directories = file.Find( "patchcore/server/*", "LUA" )

	table.foreach( server_directories, function( key, dir ) -- Loop all directories

		local files = file.Find( "patchcore/server/" .. dir .. "/*.lua", "LUA" )
		table.foreach( files, function( key, file )
			include( "patchcore/server/" .. dir .. "/" .. file )
		end )

	end )

	table.foreach( server_files, function( key, file ) -- Loop files in server folder
		include( "patchcore/server/" .. file )
	end )

end
