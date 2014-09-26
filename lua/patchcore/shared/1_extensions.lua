-- SYNTAX

function PCore.tableToSyntax( tbl )

	local string = "|"
	table.foreach( tbl, function( field, val )

		string = string .. field .. ":" .. val .. "|"

	end)
	return string

end

function PCore.syntaxToTable( syntax )

	local tbl = {}

	local raw = string.Explode( "|", syntax, false )
	table.remove( raw, 1 )
	table.remove( raw, #raw )

	table.foreach( raw, function( key, syn )

		local sep = string.find( syn, ":" )
		local newKey = string.sub( syn, 1, sep - 1 )
		tbl[newKey] = string.sub( syn, sep + 1 )

	end)
	return tbl

end

function PCore.isSyntax( val )
	
	if type( val ) != "string" then return false end

	if string.find( val, "|" ) and string.find( val, ":" ) and string.find( val, "|", -1 ) then	return true	end

	return false

end

function table.RepairTypes( tbl )

	if tbl == nil then return end

	table.foreach( tbl, function( key, value )

		if PCore.isSyntax( value ) then

			tbl[key] = PCore.syntaxToTable( value )

		elseif value == "true" or value == "false" then

			tbl[key] = tobool(value)

		elseif type( value ) == "table" then 

			table.RepairTypes( value )

		end

	end)

	return tbl

end

function table.ClearTypes( tbl )

	if tbl == nil then return end

	table.foreach( tbl, function( key, value )

		if type( value ) == "table" then

			tbl[key] = PCore.tableToSyntax( value )

		elseif type( value ) == "boolean" then

			tbl[key] = tostring(value)

		end

	end)

	return tbl

end

function table.GetColumns( tbl )

	if tbl == nil then return end

	local result = {}
	table.foreach(sql.Query( "PRAGMA table_info( " .. tbl .. " );"), function(key, value)

		result[key] = value.name

	end)

	return result

end