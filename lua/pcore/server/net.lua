-- Pool Network-Strings
util.AddNetworkString( "pcore_send" )

-- Run function on the server
net.Receive( "pcore_send", function( len, ply )

	local func = net.ReadString()
	local sub = string.find( func, "%." ) - 1
	local vars = unpack( net.ReadTable() )

	-- Run function
	_G[ string.sub( func, 1, sub ) ][ string.sub( func, sub ) ]( vars )

end )

-- Send SQL-Table to client
function pcore.sendSQL( data )

	pcore.Send( "pcore.receiveSQL", data[1], pcore.getSQL( data[2] ) )

end
