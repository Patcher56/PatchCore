-- Create SQL-Table
function pcore.setSQL( name, tbl, drop )

	drop = drop or false

	-- Compare colums
	local cols = pcore.getSQLcolums( name )
	table.foreach( sql.Query( "SELECT * FROM " .. name ), function( key, col )
		if !table.HasValue( cols, col ) then drop = true end
	end )

	-- Drop old SQL-Table
	if drop then

		MsgC( Color( 255, 0, 0 ), "[PatchCore] The table-structure of " .. name .. " is outdated! Recreating table...\n" )
		sql.Query( "DROP TABLE " .. name )

	end

	-- Create new SQL-Table
	if !sql.TableExists( name ) then

		local v = "'" .. table.concat( tbl, "' TEXT, '" ) .. "' TEXT"
		sql.Query( "CREATE TABLE IF NOT EXISTS " .. name .. "( ID INTEGER PRIMARY KEY AUTOINCREMENT, " .. v .. ")" )

		MsgC( Color( 0, 255, 0 ), "[PatchCore] Created new table: " .. name .. "\n" )
		return true

	end

	return false

end

-- Get SQL-Table-Colums
function pcore.getSQLcolums( name )

	local cols = {}
	table.foreach( sql.Query( "PRAGMA table_info( " .. name .. " )" ), function( key, col )
		table.insert( cols, col.name )
	end )

	return cols

end

--[[
// DESCRIPTION //
With pcore.getSQLTable you can get the content of a SQL-Table (also on the server).

// EXAMPLE //
pcore.getSQL( padmin_settings )
]]

function pcore.getSQL( name )

	return pcore.convert( sql.Query( "SELECT * FROM " .. name ) )

end

--[[
// DESCRIPTION //
With pcore.insertRow you can insert content in a SQL-Table (also on the server).

// EXAMPLE //
pcore.insertRow( true, padmin_settings, "showHUD", "true" )
]]

function pcore.insertSQL( name, ... )

	local v = { ... }

	local cols = pcore.getSQLcolums( name )
	if table.HasValue( cols, "ID" ) then table.remove( cols, 1 ) end

	v = table.ClearKeys( v ) -- Make numeric keys
	v = pcore.setstring( v ) -- Converts all non-strings to strings (numbers, booleans, tables)

	sql.Query( "INSERT INTO " .. name .. "( '" .. table.concat( cols, "', '") .. "' ) VALUES ( '" .. table.concat( v, "', '") .. "')" )

end

--[[
// DESCRIPTION //


// EXAMPLE //

]]

function pcore.updateSQL( name, col, where, v )

	v = { v }
	v = PCore.stringTypes( v )

	if v[ 1 ] == sql.QueryValue( "SELECT * FROM " .. name .. " WHERE " .. col .. " = " .. where ) then
		return false
	else
		sql.Query( "UPDATE " .. name .. " SET " .. v[ 1 ] .. " WHERE " .. col .. " = " .. where )
		return true
	end

end

--[[
// DESCRIPTION //


// EXAMPLE //

]]

function pcore.deleteSQL( name, col, where )

	sql.Query( "DELETE FROM " .. name .. " WHERE " .. col .. " = " .. where )
	if sql.Query( "SELECT * FROM " .. name .. " WHERE " .. col .. " = " .. where ) then
		return false
	else
		return true
	end

end
