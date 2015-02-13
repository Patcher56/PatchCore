-- Create main table
PCore = {}

function PCore.GetFiles( path )

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

	-- Force client to download PCore-LUA-Files
	AddCSLuaFile()

	-- Shared files
	table.foreach( PCore.GetFiles( "pcore/shared" ), function( key, file )
		AddCSLuaFile( file )
	end )

	-- Client files
	table.foreach( PCore.GetFiles( "pcore/client" ), function( key, file )
		AddCSLuaFile( file )
	end )

	-- Load server files
	table.foreach( PCore.GetFiles( "pcore/server" ), function( key, file )
		include( file )
	end )

end

-- Clientside code
if CLIENT then

	-- Create derma table
	PCore.derma = {}

	-- Load shared files
	table.foreach( PCore.GetFiles( "pcore/shared" ), function( key, file )
		include( file )
	end )

	-- Load client files
	table.foreach( PCore.GetFiles( "pcore/client" ), function( key, file )
		include( file )
	end )

end

MsgC( Color( 255, 255, 0 ), "\n[PatchCore]", Color( 255, 255, 255 ), " Successfully loaded!\n\n" )
