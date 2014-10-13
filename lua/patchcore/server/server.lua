--COMPILER:SERVER

function PCore.sendSQLTable( ply, info )

	PCore.getSQLTable( info.tblname, nil, true, ply )

end

function PCore.receiveInsert( ply, info )

	sh_PPlay.insertRow( true, info.tblname, unpack( info.values ) )

end

net.Receive( "pcore_send", function( len, ply )

	local str_func = net.ReadString()
	local vars = net.ReadTable()

	_G[string.sub(str_func, 1, string.find(str_func, "%.") - 1)][string.sub(str_func, string.find(str_func, "%.") + 1)]( unpack(vars) )

end )
