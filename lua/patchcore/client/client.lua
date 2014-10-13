--COMPILER:CLIENT

function PCore.receiveSQLTable( package )

	if !PCore.Temp.SQLFunction or !package.result then return end

	PCore.Temp.SQLFunction( package.result )

	PCore.Temp.SQLFunction = nil

end

net.Receive( "pcore_send", function( len )

	local str_func = net.ReadString()
	local vars = net.ReadTable()

	_G[string.sub(str_func, 1, string.find(str_func, "%.") - 1)][string.sub(str_func, string.find(str_func, "%.") + 1)]( unpack(vars) )

end )
