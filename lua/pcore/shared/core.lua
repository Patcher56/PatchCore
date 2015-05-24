
-- Check if PCore is available
function pcore.check()

	if pcore then
		print("PCore is running!")
	else
		print("PCore is there but not working correctly!")
	end

end

--[[
// DESCRIPTION //
With pcore.send you can send information to the server or to the client (auto-dectected).
You have to write a name for calling a function after receiving the message.

WARNING: Only works with one childtable! e.g.: pcore.Test, not pcore.Net.Test

// EXAMPLE //
pcore.send( "func.func", { arg1, arg2 } )
pcore.getSQLTable( padmin_settings, function() print("got the table") end, true )
]]

function pcore.send( name, ... )

	local vars = { ... }
	local ply = nil

	if vars[1]:IsPlayer() then
		ply = vars[1]
		table.remove( vars, 1 )
	end

	net.Start( "pcore_send" )

		net.WriteString( name )
		net.WriteTable( vars )

	if SERVER then
			
		if ply then net.Send( ply ) else net.Broadcast() end

	else

		net.SendToServer()

	end

end

-- Convert strings to correct var-types (Generic)
function pcore.convert( var )

	if !var then return end

	if istable( var ) then

		table.foreach( var, function( k, v )
			var[k] = pcore.convert( v )
		end )

	else

		if isstring( var ) then
			if v == "true" or v == "false" then var = tobool( var ) end
			if tonumber( var ) != nil then var = tonumber( var ) end
		end

	end

	return var

end

-- Convert vars to strings (Generic)
function pcore.tostring( var )

	if !var then return end

	if istable( var ) then

		table.foreach( var, function( k, v )
			var[k] = pcore.tostring( v )
		end )

	else

		var = tostring( var )

	end

	return var

end
