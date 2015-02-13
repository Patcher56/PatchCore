-- Run function on the client
net.Receive( "pcore_send", function( len )

	local func = net.ReadString()
	local sub = string.find( func, "%." ) - 1
	local vars = unpack( net.ReadTable() )

	-- Run function
	_G[ string.sub( func, 1, sub ) ][ string.sub( func, sub ) ]( vars )

end )

-- Receive SQL-Table from server
function PCore.receiveSQL( tbl )

	PCore.Send( PCore.sendSQL, LocalPlayer(), tbl )
	return tbl

end
