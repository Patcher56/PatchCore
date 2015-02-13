--COMPILER:CLIENT

-------------
--  LABEL  --
-------------

function PCore.derma.label( pnl, text, pos )

	-- Structure
	local lbl
	local class = pnl:GetClassName()

	if class == "Panel" then

		lbl = vgui.Create( "DLabel" )
		pnl:AddItem( lbl )

	else

		lbl = vgui.Create( "DLabel", pnl )
		lbl:SetPos( pos[1], pos[2] )

	end

	lbl:SetText( text )
	lbl:SetDark( true )
	lbl:SetFont( "pcore_roboto_14_ns" )
	lbl:SizeToContents()

	return lbl
	
end
