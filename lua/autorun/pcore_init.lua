-- Create main table
pcore = {}

local function loadFiles( path )

	local f, d = file.Find( path .. "/*", "LUA" )
	local files = {}

	table.foreach( f, function( key, file )
		table.insert( files, path .. "/" .. file )
	end )

	table.foreach( d, function( key, dir )

		f = file.Find( path .. "/" .. dir .. "/*", "LUA" )

		table.foreach( f, function( k, file )
			table.insert( files, path .. "/" .. dir .. "/" .. file )
		end )

	end )

	return files

end

-- Serverside code
if SERVER then

	-- Send this file
	AddCSLuaFile()

	-- Send shared-files
	table.foreach( loadFiles( "pcore/shared" ), function( key, file )
		AddCSLuaFile( file )
	end )

	-- Send client-files
	table.foreach( loadFiles( "pcore/client" ), function( key, file )
		AddCSLuaFile( file )
	end )

	-- Load server-files
	table.foreach( loadFiles( "pcore/server" ), function( key, file )
		include( file )
	end )

end

-- Clientside code
if CLIENT then

	-- Create derma table
	pcore.derma = {}

	-- Load shared-files
	table.foreach( loadFiles( "pcore/shared" ), function( key, file )
		include( file )
	end )

	-- Load client-files
	table.foreach( loadFiles( "pcore/client" ), function( key, file )
		include( file )
	end )

end

MsgC( Color( 255, 255, 0 ), "\n[PatchCore]", Color( 255, 255, 255 ), " Successfully loaded!\n\n" )
