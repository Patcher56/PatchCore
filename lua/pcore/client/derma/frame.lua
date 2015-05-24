--[[
-------------
--  FRAME  --
-------------

function PCore.derma.frame( text, font, x, y, w, h, close, blur )

	-- Structure
	local frm = vgui.Create( "DFrame" )
	close = close or true
	blur = blur or false

	frm:SetPos( x, y )
	frm:SetSize( w, h )
	frm:ShowCloseButton( close )
	frm:SetTitle( text )
	frm.lblTitle:SetColor( Color( 75, 75, 75 ) )
	frm.lblTitle:SetFont( font )
	frm:MakePopup()

	frm.btnMaxim:SetVisible( false )
	frm.btnMinim:SetVisible( false )

	-- Design
	function frm:PerformLayout()

		self.lblTitle:SetPos( 8, 2 )
		self.lblTitle:SetSize( self:GetWide() - 25, 20 )

		self.btnClose:SetPos( self:GetWide() - 20 - 6, 0 )
		self.btnClose:SetSize( 20, 20 )

	end

	function frm:Paint()

		if blur then
			Derma_DrawBackgroundBlur( self, self.m_fCreateTime )
		end

		draw.RoundedBox( 0, 0, 0, frm:GetWide(), frm:GetTall(), Color( 200, 150, 30, 255 ) )
		draw.RoundedBox( 0, 1, 1, frm:GetWide() - 2, frm:GetTall() - 2, Color( 255, 175, 0, 255 ) )
		draw.RoundedBox( 0, 6, 24, frm:GetWide() - 12, frm:GetTall() - 30, Color( 255, 255, 255, 255 ) )

	end

	function frm.btnClose:Paint()

		draw.RoundedBox( 0, 0, 0, self:GetWide(), self:GetTall(), Color( 199, 80, 80, 255 ) )
		draw.SimpleText( "x", "pcore_akbar_40_ns", 4, -16, Color( 255, 255, 255 ) )
		
	end

	return frm

end
]]
