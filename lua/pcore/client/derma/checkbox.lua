----------------
--  CHECKBOX  --
----------------

function PCore.derma.checkbox( pnl, text, font, checked, event, tooltip, x, y )

	-- Structure
	local chk
	local class = pnl:GetClassName()

	if class == "Panel" then

		chk = vgui.Create( "DCheckBoxLabel" )
		pnl:AddItem( chk )

	else

		chk = vgui.Create( "DCheckBoxLabel", pnl )
		chk:SetPos( x, y )

	end

	chk:SetText( text )
	chk:SetChecked( checked )
	chk:SetDark( true )

	tooltip = tooltip or nil
	chk:SetTooltip( tooltip )
	chk.Label:SetFont( font )
	chk:SizeToContents()

	-- Callback
	function chk:OnChange() event( chk:GetChecked() ) end

	-- Design
	function chk:PaintOver()

		draw.RoundedBox( 0, 0, 0, chk:GetTall(), chk:GetTall(), Color( 150, 150, 150, 255 ) )
		draw.RoundedBox( 0, 1, 1, chk:GetTall() - 2, chk:GetTall() - 2, Color( 240, 240, 240, 255 ) )
		if chk:GetChecked() == false then return end
		draw.RoundedBox( 0, 2, 2, chk:GetTall() - 4, chk:GetTall() - 4, Color( 255, 150, 0, 255 ) )
		
	end

	return chk

end
