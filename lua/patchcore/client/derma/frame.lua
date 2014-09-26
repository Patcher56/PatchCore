-------------
--  FRAME  --
-------------

function PCore.derma.frame( text, pos, size, close, blur )

	local frm = vgui.Create( "DFrame" )
	pos = pos or { ScrW() / 2 - ( size[1] / 2 ), ScrH() / 2 - ( size[2] / 2 ) }
	close = close or true
	blur = blur or false

	frm:SetPos( pos[1], pos[2] )
	frm:SetSize( size[1], size[2] )
	frm:ShowCloseButton( close )
	frm:SetTitle( text )
	frm.lblTitle:SetColor( Color( 75, 75, 75 ) )
	frm.lblTitle:SetFont( "pcore_roboto_14_ns" )
	frm:MakePopup()

	frm.btnMaxim:SetVisible( false )
	frm.btnMinim:SetVisible( false )

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
