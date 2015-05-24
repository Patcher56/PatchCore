--COMPILER:CLIENT

-------------
--  LABEL  --
-------------

function PCore.derma.label( pnl, text, font, x, y, color )

	-- Structure
	local lbl
	local class = pnl:GetClassName()

	if class == "Panel" then

		lbl = vgui.Create( "DLabel" )
		pnl:AddItem( lbl )

	else

		lbl = vgui.Create( "DLabel", pnl )
		lbl:SetPos( x, y )

	end

	lbl:SetText( text )
	lbl:SetDark( true )
	lbl:SetFont( font )
	if color then
		lbl:SetFGColor( color )
	end
	lbl:SizeToContents()

	return lbl
	
end
