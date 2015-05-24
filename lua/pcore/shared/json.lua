--[[
// DESCRIPTION //


// EXAMPLE //

]]

function pcore.saveJSON( name, tbl )

	file.Write( name .. ".txt", util.TableToJSON( tbl ) )
	if file.Exists( name .. ".txt", "DATA" ) then
		return true
	else
		return false
	end

end

--[[
// DESCRIPTION //


// EXAMPLE //

]]

function pcore.loadJSON( name )

	if file.Exists( name .. ".txt", "DATA" ) then
		return util.JSONToTable( file.Read( name .. ".txt", "DATA" ) )
	else
		return false
	end

end
