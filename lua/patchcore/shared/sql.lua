--COMPILER:SHARED

function PCore.createTable( name, values, cb, drop )

	if drop == nil then drop = false end

	local function create()

		local v = "'" .. table.concat( values, "' TEXT, '" ) .. "' TEXT"

		sql.Query( "CREATE TABLE IF NOT EXISTS " .. name .. "( ID INTEGER PRIMARY KEY AUTOINCREMENT, " .. v .. ");" )

		MsgC(
			Color(0, 255, 0),
			"[PatchCore] Created new table: " .. name .. "\n"
		)

		cb()

	end

	if !sql.TableExists( name ) then

		create()

	else

		local columns = sql.Query( "PRAGMA table_info(" .. name .. ");" )
		local rows = sql.Query( "SELECT * FROM " .. name )

		--Check if the right column names are set in the existing table
		local rightcols = 0
		table.foreach( columns, function( key, col )

			table.foreach( values, function( key, value )

				if col.name == value then
					rightcols = rightcols + 1
				end

			end )

		end )

		if rightcols != #values then drop = true end

		if columns[#values] == nil or drop then

			MsgC(
				Color(255, 0, 0),
				"[PatchCore] The table-structure of " .. name .. " is outdated! Recreating table now...\n"
			)

			sql.Query( "DROP TABLE " .. name )
			create()

		end

	end

end

PCore.createTable( "pcore_test", {"name", "job", "house"}, function()

	sql.Query( "INSERT INTO pcore_test( 'name', 'job', 'house' ) VALUES( 'Patrick', 'Programmer', 'true')" )
	sql.Query( "INSERT INTO pcore_test( 'name', 'job', 'house' ) VALUES( 'Dominik', 'Programmer', 'true')" )
	sql.Query( "INSERT INTO pcore_test( 'name', 'job', 'house' ) VALUES( 'Hans', 'Penner', 'false')" )

end, false )

--[[
// DESCRIPTION //
With PCore.getSQLTable you can get the content of a SQL-Table (also on the server). The Callback gets called when PCore read the table.

// EXAMPLE //
PCore.getSQLTable( padmin_settings, function() print("got the table") end, true, LocalPlayer() )
]]

function PCore.getSQLTable( name, cb, onServer, ply )

	if SERVER and onServer then

		local package = {}
		package.tblname = name
		package.result = table.RepairTypes( sql.Query("SELECT * FROM " .. name) )

		PCore.Send( "PCore.receiveSQLTable", ply, package )

	elseif CLIENT and onServer then

		PCore.Temp.SQLFunction = cb

		local info = {}
		info.tblname = name

		PCore.Send( "PCore.sendSQLTable", info )

	else

		local result = table.RepairTypes( sql.Query("SELECT * FROM " .. name) )

		if result == nil then return end
		
		cb( result )

	end

end

--[[
// DESCRIPTION //
With PCore.insertRow you can insert content in a SQL-Table (also on the server).

// EXAMPLE //
PCore.insertRow( true, padmin_settings, "showHUD", "true" )

Inserts a row in the table padmin_settings with the values "showHUD" and "true"
]]
function PCore.insertRow( onServer, name, ... )

	local values = {...}

	if CLIENT and onServer then

		PCore.Send( "PCore.insertRow", false, name, ... )
		return

	end

	local colnames = table.GetColumns( name )

	if table.HasValue(colnames, "ID") then

		table.remove(colnames, 1)

	end

	values = table.ClearKeys(values) -- Make numeric keys
	values = table.ClearTypes(values) -- Makes all wrong types (tables, booleans) to strings

	if #values != #colnames then
		print( "Not saved! Number of Savevalues is not equal to the number of the needed values!" )
		return
	end

	sql.Query( "INSERT INTO " .. name .. "( '" .. table.concat( colnames, "', '") .. "' ) VALUES( '" .. table.concat( values, "', '") .. "')" )

end

function PCore.changeRow( onServer, name, wherecol, whereval, ... )

	local values = {...}

	if !SERVER and onServer then
		
		local change = {}
		change.values = {}
		table.foreach(sql.Query( "PRAGMA table_info( " .. name .. " );"), function(key, value)

			change.values[ value.name ] = values[key]

		end )

		change.where = {
			wherecol,
			whereval
		}


		cl_PPlay.sendToServer( string.sub(name, 7) .. "_change", change )
		return

	end

	local colnames = PCore.getColumns( name )

	table.foreach(values, function( k, v )

		if type(v) == "table" then

			values[k] = PCore.tableToSyntax( v )

		end

	end )

	if table.Count(values) != table.Count(colnames) then
		print("Not saved! Number of Savevalues is not equal to the number of the needed values!")
		return
	end

	local set = ""
	table.foreach( colnames, function( key, col )

		set = set .. colnames[key] .. "='" .. values[key] .. "'"

		if key != #colnames then set = set .. "," end

	end )

	sql.Query( "UPDATE " .. name .. " SET " .. set .. " WHERE " .. wherecol .. "='" .. whereval .. "';" )

end

function PCore.deleteRow( onServer, name, wherecol, whereval )

	if !SERVER and onServer then
		
		local delete = {}

		delete.where = {
			wherecol,
			whereval
		}
		delete.name = name

		cl_PPlay.sendToServer( "deleterow", delete )
		return

	end

	sql.Query( "DELETE FROM " .. name .. " WHERE " .. wherecol .. "='" .. whereval .. "';" )

end





if CLIENT then
	
	timer.Simple(5, function()

		PCore.insertRow( true, "pcore_test", "ply", {streamurl = "test", title = "test"}, true ) --JUST A TEST -> DELETE!

	end )
	
end
