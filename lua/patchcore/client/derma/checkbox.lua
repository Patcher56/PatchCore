----------------
--  CHECKBOX  --
----------------

function PCore.derma.checkbox( pnl, text, event, pos, checked, tooltip )

	local chk
	local class = pnl:GetClassName()

	-- Specific settings who depend on the parent's class
	if class == "Panel" then

		chk = vgui.Create( "DCheckBoxLabel" )
		pnl:AddItem( chk )

	else

		chk = vgui.Create( "DCheckBoxLabel", pnl )
		chk:SetPos( pos[1], pos[2] )

	end

	chk:SetText( text )
	chk:SetChecked( checked )
	chk:SetDark( true )

	tooltip = tooltip or nil
	chk:SetTooltip( tooltip )
	chk.Label:SetFont( "pcore_roboto_14_ns" )
	chk:SizeToContents()

	function chk:OnChange()

		event( chk:GetChecked() )

	end

	function chk:PaintOver()
		draw.RoundedBox( 0, 0, 0, chk:GetTall(), chk:GetTall(), Color( 150, 150, 150, 255 ) )
		draw.RoundedBox( 0, 1, 1, chk:GetTall() - 2, chk:GetTall() - 2, Color( 240, 240, 240, 255 ) )
		if chk:GetChecked() == false then return end
		draw.RoundedBox( 0, 2, 2, chk:GetTall() - 4, chk:GetTall() - 4, Color( 255, 150, 0, 255 ) )
	end

	return chk

end
