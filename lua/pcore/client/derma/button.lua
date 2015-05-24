-------------
--  BUTTON --
-------------

function pcore.derma.button( pnl, text, font, event, x, y, w, h )

	-- Structure
	local btn
	local class = pnl:GetClassName()

	if class == "Panel" then

		btn = vgui.Create( "DButton" )
		btn:SetDark( true )
		pnl:AddItem( btn )

	else

		btn = vgui.Create( "DButton", pnl )
		btn:SetDark( false )
		btn:SetPos( x, y )
		btn:SetSize( w, h )

	end

	btn:SetText( text )
	btn:SetFont( font )

	-- Click-Event
	function btn.DoClick() event() end

	-- Design
	function btn:Paint()

		if btn:GetDisabled() then
			draw.RoundedBox( 0, 0, 0, btn:GetWide(), btn:GetTall(), Color( 240, 240, 240, 255 ) )
			btn:SetCursor("arrow")
		elseif btn.Depressed then
			draw.RoundedBox( 0, 0, 0, btn:GetWide(), btn:GetTall(), Color( 250, 150, 0, 255 ) )
		elseif btn.Hovered then
			draw.RoundedBox( 0, 0, 0, btn:GetWide(), btn:GetTall(), Color( 220, 220, 220, 255 ) )
		else
			draw.RoundedBox( 0, 0, 0, btn:GetWide(), btn:GetTall(), Color( 200, 200, 200, 255 ) )
		end

	end

	return btn

end
