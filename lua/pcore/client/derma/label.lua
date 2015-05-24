function pcore.label( d, text, font, x, y, color )

	color = color or Color( 0, 0, 0 )
	local lbl
	local class = d:GetClassName()

	if class == "Panel" then

		lbl = vgui.Create( "DLabel" )
		d:AddItem( lbl )

	else

		lbl = vgui.Create( "DLabel", d )
		lbl:SetPos( x, y )

	end

	lbl:SetText( text )
	lbl:SetFont( font )
	lbl:SetColor( color )
	lbl:SizeToContents()

	return lbl

end
