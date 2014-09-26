-- Open Temp Variables for preventing chaos
PCore.Temp = {}

function PCore.ClearTemp()

	PCore.Temp = {}

end

--[[
// DESCRIPTION //
With PCore.Send you can send information to the server or to the client (it gets detected automatically). You have to write a name for calling a function after
receiving the message.

WARNING: Only works with one undertable! Ex: Working: PCore.Test Not Working: PCore.Net.Test

// EXAMPLE //
PCore.Send( "")
PCore.getSQLTable( padmin_settings, function() print("got the table") end, true )
]]
function PCore.Send( name, ... )

	local vars = {...}
	local ply = nil

	print("got it")

	if type(vars[1]) == "Player" or type(vars[1]) == "Entity" then

		ply = vars[1]
		table.remove(vars, 1)

	end

	PrintTable(vars)

	net.Start("pcore_send") -- Start the net message
		net.WriteString( name )

		net.WriteTable( vars ) -- Write the values

	if SERVER then
			
		if ply then net.Send( ply ) else net.Broadcast() end -- Broadcast the message or send it to a special player

	else

		print("sending to server")

		net.SendToServer() -- Send to the server

	end

end

