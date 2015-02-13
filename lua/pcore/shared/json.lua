--[[
// DESCRIPTION //


// EXAMPLE //

]]

function PCore.saveJSONTable( name, tbl )

	tbl = util.TableToJSON( tbl )
	file.Write( name .. ".txt", tbl )
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

function PCore.getJSONTable( name )

	if file.Exists( name .. ".txt", "DATA" ) then
		return file.Read( name .. ".txt", "DATA" )
	else
		return false
	end

end
