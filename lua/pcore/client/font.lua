local fonts = {}

function pcore.font( f, s, b, a, sh, sy )

	b = b or 500
	a = a or true
	sh = sh or false
	sy = sy or false

	local font = "pcore_" .. f .. "_" .. tostring( s ) .. "_" .. tostring( b ) .. "_" .. tostring( a ) .. "_" .. tostring( sh )

	if table.HasValue( fonts, font ) then return font end

	surface.CreateFont( font, {
		font = f,
		size = s,
		weight = b,
		antialias = a,
		shadow = sh,
		symbol = sy
	} )

	table.insert( fonts, font )

	return font

end
