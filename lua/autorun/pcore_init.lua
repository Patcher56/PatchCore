-------------------
--  CREATE TABLE --
-------------------

PCore = {}

-------------------
--  NET MESSAGES --
-------------------

if SERVER then

	util.AddNetworkString( "pcore_send" )

end

-------------------------
--  LOAD SHARED FILES  --
-------------------------

local files = file.Find( "patchcore/shared/*.lua", "LUA" )
table.foreach( files, function( key, s_file )

	AddCSLuaFile("patchcore/shared/" .. s_file)
	include( "patchcore/shared/" .. s_file)
	print("loaded " .. s_file)

end )


-------------------------
--  LOAD CLIENT FILES  --
-------------------------

AddCSLuaFile()
AddCSLuaFile("patchcore/client/client.lua")



---------------------------------------
--  LOAD SHARED/SERVER/CLIENT FILES  --
---------------------------------------



if SERVER then

	-- INCLUDE FILES
	include( "patchcore/server/server.lua" )
	include( "patchcore/server/config.lua" )
	include( "patchcore/server/sql.lua" )
	

else

	include( "patchcore/client/client.lua" )
	
end


