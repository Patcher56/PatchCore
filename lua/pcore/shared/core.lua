--[[
// DESCRIPTION //
With PCore.Send you can send information to the server or to the client (it gets detected automatically). You have to write a name for calling a function after
receiving the message.

WARNING: Only works with one undertable! Ex: Working: PCore.Test Not Working: PCore.Net.Test

// EXAMPLE //
PCore.Send( "" )
PCore.getSQLTable( padmin_settings, function() print("got the table") end, true )
]]

function PCore.Send( name, ... )

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

-- Convert strings to right var-types
function PCore.repairTypes( tbl )

	if !tbl then return end

	table.foreach( tbl, function( k, v )

		if type( v ) != "string" then return end

		if v == "true" or v == "false" then

			tbl[ k ] = tobool( v )

		elseif tonumber( v ) != nil then

			tbl[ k ] = tonumber( v )

		end

	end )

	return tbl

end

-- Convert all vars to strings
function PCore.stringTypes( tbl )

	if !tbl then return end

	table.foreach( tbl, function( k, v )

		if type( v ) == "string" then
			return
		else
			tbl[ k ] = tostring( v )
		end

	end )

	return tbl

end
