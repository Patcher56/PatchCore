function pcore.check( d, text, font, check, cb, x, y, w, h, color, tooltip )

	h = h or 20
	color = color or Color( 0, 0, 0 )
	local chk
	local class = pnl:GetClassName()

	if class == "Panel" then

		chk = vgui.Create( "DPanel" )
		d:AddItem( chk )

	else

		chk = vgui.Create( "DPanel", d )
		chk:SetPos( x, y )
		chk:SetSize( w, h )

	end
	if tooltip then chk:SetTooltip( tooltip ) end

	-- Label
	chk.lbl = vgui.Create( "DLabel", chk )
	chk.lbl:SetText( text )
	chk.lbl:SetPos( 5, 3 )
	chk.lbl:SetFont( font )
	chk.lbl:SetColor( color )
	chk.lbl:SizeToContents()

	-- Checkbox
	chk.box = vgui.Create( "DCheckBox", chk )
	chk.box:SetPos( w - 55, 0 )
	chk.box:SetSize( h * 2, h )
	chk.box:SetChecked( check )

	function chk:Paint() end

	function chk.box:Paint()
		if chk.box:GetChecked() then
			draw.RoundedBox( h * 0.2, 0, 0, h * 2, h, Color( 255, 150, 0 ) )
			draw.RoundedBox( h * 0.2, h + ( h * 0.15 ), h * 0.15, h * 0.7, h * 0.7, Color( 240, 240, 240 ) )
			draw.SimpleText( "ON", pcore.font( "roboto", 11, 1000 ), h * 0.25, h * 0.25, Color( 255, 255, 255 ) )
		else
			draw.RoundedBox( h * 0.2, 0, 0, 40, 20, Color( 75, 75, 75 ) )
			draw.RoundedBox( h * 0.2, h * 0.15, h * 0.15, h * 0.7, h * 0.7, Color( 240, 240, 240 ) )
			draw.SimpleText( "OFF", pcore.font( "roboto", 11, 1000 ), h, h * 0.25, Color( 255, 255, 255 ) )
		end
	end

	function chk.box:OnChange( c )
		cb( c )
	end

	return chk

end
