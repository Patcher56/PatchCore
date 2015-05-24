--[[
--------------
--  SWITCH  --
--------------

function pcore.derma.switch( pnl, text, font, checked, event, tooltip, x, y )

	-- Structure
	local switch
	local class = pnl:GetClassName()

	-- Specific settings who depend on the parent's class
	if class == "Panel" then

		switch = vgui.Create( "DCheckBoxLabel" )
		pnl:AddItem( switch )

	else

		switch = vgui.Create( "DCheckBoxLabel", pnl )
		switch:SetPos( x, y )

	end

	-- Design
	function switch:PerformLayout()

		local x = self.m_iIndent or 0

		self.Button:SetSize( 40, 19 )
		self.Button:SetPos( x, 0 )
		
		if self.Label then
			self.Label:SizeToContents()
			self.Label:SetPos( x + 35 + 10, self.Button:GetTall() / 2 - 7 )
		end

	end

	-- Structure
	switch:SetText( text )
	switch.Label:SetFont( font )
	switch:SizeToContents()
	switch:SetDark( true )
	switch:SetChecked( checked )

	-- Callback
	function switch:OnChange() event( switch:GetChecked() ) end

	-- Animation
	local curx = 0
	local function smooth( goal )

		local speed = math.abs( goal - curx ) / 3

		if curx > goal then curx = curx - speed
		elseif curx < goal then curx = curx + speed
		end

		return curx

	end

	-- Design
	if switch:GetChecked() then

		curx = switch.Button:GetWide() - switch:GetTall() / 1.5 - 3

	end

	function switch.Button:Paint()

		local switchColor = {

			checked = Color( 255, 116, 0 ),
			unchecked = Color( 200, 200, 200 ),
			disabled = Color( 210, 210, 210 )

		}

		local knobColor = {

			regular = Color( 240, 240, 240 ),
			disabled = Color( 212, 212, 212 )

		}

		if switch:GetChecked() then

			local curSwitchCol
			local curKnobCol

			if switch:GetDisabled() then

				curSwitchCol = switchColor["disabled"]
				curKnobCol = knobColor["disabled"]
			else

				curSwitchCol = switchColor["checked"]
				curKnobCol = knobColor["regular"]
			end

			draw.RoundedBox( 8, 0, 0, self:GetWide(), self:GetTall(), curSwitchCol )
			draw.RoundedBox( 6, smooth( self:GetWide() - switch:GetTall() / 1.5 - 3 ), switch:GetTall() / 2 - switch:GetTall() / 1.5 / 2, switch:GetTall() / 1.5, switch:GetTall() / 1.5, curKnobCol )
			
		else

			local curSwitchCol
			local curKnobCol

			if switch:GetDisabled() then

				curSwitchCol = switchColor["disabled"]
				curKnobCol = knobColor["disabled"]
			else

				curSwitchCol = switchColor["unchecked"]
				curKnobCol = knobColor["regular"]
			end

			draw.RoundedBox( 8, 0, 0, self:GetWide(), self:GetTall(), curSwitchCol )
			draw.RoundedBox( 6, smooth(3), switch:GetTall() / 2 - switch:GetTall() / 1.5 / 2, switch:GetTall() / 1.5, switch:GetTall() / 1.5, curKnobCol )
		
		end

	end

	return switch

end
]]
