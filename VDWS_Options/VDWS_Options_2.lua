-- some variables --
local G = VDW.Local.Override
local L = VDW.VDWS.Local
local C = VDW.GetAddonColors("VDWS")
local prefixTip = VDW.Prefix("VDWS")
local NameExist = false
local maxW = 160
local finalW = 0
local counter = 0
local backgroundStyle = {G.OPTIONS_C_DEFAULT,}
local fontsStyle = {"Normal",  "Funky", "Groovy",}
local fontsStyle1 = {"Normal 12", "Normal 13", "Normal 14", "Normal 15", "Normal 16", "Normal 17", "Normal 18"}
local fontsStyle2 = {"Funky 14", "Funky 15", "Funky 16", "Funky 17", "Funky 18", "Funky 19", "Funky 20",}
local fontsStyle3 = {"Groovy 14", "Groovy 15", "Groovy 16", "Groovy 17", "Groovy 18", "Groovy 19", "Groovy 20"}
local color = {G.OPTIONS_C_DEFAULT, G.OPTIONS_C_CLASS, G.OPTIONS_C_FACTION,}
-- Taking care of the option panel --
vdwsOptions2:SetSize(576, 498)
vdwsOptions2:ClearAllPoints()
vdwsOptions2:SetPoint("TOPLEFT", vdwsOptions0, "TOPLEFT", 0, 0)
-- Background of the option panel --
vdwsOptions2.BGtexture:SetAtlas("UI-Frame-BossPortrait-Background", false)
vdwsOptions2.BGtexture:SetVertexColor(C.High:GetRGB())
vdwsOptions2.BGtexture:SetDesaturation(0.3)
-- Title of the option panel --
vdwsOptions2.Title:SetTextColor(C.Main:GetRGB())
vdwsOptions2.Title:SetText(prefixTip.."|nVersion: "..C.High:WrapTextInColorCode(C_AddOns.GetAddOnMetadata("VDWS", "Version")))
-- Top text of the option panel --
vdwsOptions2.TopTxt:SetTextColor(C.Main:GetRGB())
vdwsOptions2.TopTxt:SetText(string.format(L.OPTIONS_FOR, L.LOOTY_GROOVE))
-- Bottom right text of the option panel --
vdwsOptions2.BottomRightTxt:SetTextColor(C.Main:GetRGB())
vdwsOptions2.BottomRightTxt:SetText("May the Good "..C.High:WrapTextInColorCode("Mojo").." be with you! ")
-- taking care of the boxes --
vdwsOptions2Box1:SetHeight(408)
vdwsOptions2Box2:SetHeight(136)
vdwsOptions2Box3:SetHeight(144)
vdwsOptions2Box4:SetHeight(136)
vdwsOptions2Box1.Title:SetText(L.VISIBILITY)
vdwsOptions2Box2.Title:SetText(L.BACKGROUND)
vdwsOptions2Box3.Title:SetText(L.SIZE)
vdwsOptions2Box4.Title:SetText(L.FONTS)
vdwsOptions2Box2:ClearAllPoints()
vdwsOptions2Box2:SetPoint("TOPLEFT", vdwsOptions2Box1, "TOPRIGHT", 0, 0)
vdwsOptions2Box3:ClearAllPoints()
vdwsOptions2Box3:SetPoint("TOPLEFT", vdwsOptions2Box2, "BOTTOMLEFT", 0, 0)
vdwsOptions2Box4:ClearAllPoints()
vdwsOptions2Box4:SetPoint("TOPLEFT", vdwsOptions2Box3, "BOTTOMLEFT", 0, 0)
for i = 1, 4, 1 do
	local tW = _G["vdwsOptions2Box"..i].Title:GetStringWidth()+16
	local W = _G["vdwsOptions2Box"..i]:GetWidth()
	if tW >= W then
		_G["vdwsOptions2Box"..i]:SetWidth(tW)
	end
end
-- Coloring the boxes --
for i = 1, 4, 1 do
	_G["vdwsOptions2Box"..i].Title:SetTextColor(C.Main:GetRGB())
	_G["vdwsOptions2Box"..i].BorderTop:SetVertexColor(C.High:GetRGB())
	_G["vdwsOptions2Box"..i].BorderBottom:SetVertexColor(C.High:GetRGB())
	_G["vdwsOptions2Box"..i].BorderLeft:SetVertexColor(C.High:GetRGB())
	_G["vdwsOptions2Box"..i].BorderRight:SetVertexColor(C.High:GetRGB())
end
-- Coloring the pop out buttons --
local function ColoringPopOutButtons(k, var1)
	_G["vdwsOptions2Box"..k.."PopOut"..var1].Text:SetTextColor(C.Main:GetRGB())
	_G["vdwsOptions2Box"..k.."PopOut"..var1].Title:SetTextColor(C.High:GetRGB())
	_G["vdwsOptions2Box"..k.."PopOut"..var1].NormalTexture:SetVertexColor(C.High:GetRGB())
	_G["vdwsOptions2Box"..k.."PopOut"..var1].HighlightTexture:SetVertexColor(C.Main:GetRGB())
	_G["vdwsOptions2Box"..k.."PopOut"..var1].PushedTexture:SetVertexColor(C.High:GetRGB())
end
-- Stoping the Looty Groove --
local function StopMoving(self)
	VDWSsettings.Looty.Position.X = Round(self:GetLeft())
	VDWSsettings.Looty.Position.Y = Round(self:GetBottom())
	self:StopMovingOrSizing()
end
-- Moving the Looty Groove --
vdwsLooty:SetScript("OnDragStart", FramerateFrame.StartMoving)
vdwsLooty:SetScript("OnDragStop", function(self) StopMoving(self) end)
-- Mouse Wheel on Sliders --
local function MouseWheelSlider(self, delta)
	if delta == 1 then
		self:SetValue(self:GetValue() + 1)
	elseif delta == -1 then
		self:SetValue(self:GetValue() - 1)
	end
end
-- check button show - hide edge artwork --
vdwsOptions2Box1CheckButton1.Text:SetText(L.LOOTY_GROOVE)
vdwsOptions2Box1CheckButton2.Text:SetText(L.TITLE)
vdwsOptions2Box1CheckButton3.Text:SetText("Sweet Sound of Auction House")
vdwsOptions2Box1CheckButton4.Text:SetText(L.LOOT)
vdwsOptions2Box1CheckButton5.Text:SetText(L.COINS)
vdwsOptions2Box1CheckButton6.Text:SetText(L.CURRENCIES)
vdwsOptions2Box1CheckButton7.Text:SetText(L.EXPIRIENCE)
vdwsOptions2Box1CheckButton8.Text:SetText(L.HONOR)
vdwsOptions2Box1CheckButton9.Text:SetText(L.REPUTATION)
vdwsOptions2Box1CheckButton10.Text:SetText(L.SKILL)
vdwsOptions2Box1CheckButton11.Text:SetText(L.MISCELLANEOUS)
for i = 1, 11, 1 do
	_G["vdwsOptions2Box1CheckButton"..i].Text:SetWidth(vdwsOptions2Box1:GetWidth()*0.8)
	_G["vdwsOptions2Box1CheckButton"..i]:SetScript("OnEnter", function(self)
		local word1 = self.Text:GetText()
		local word2 = C.High:WrapTextInColorCode(L.LOOTY_GROOVE)
		if i >= 3 then
			VDW.Tooltip_Show(self, prefixTip, string.format(L.CHECK_VISIBILITY_TIP_IN_THE, word1, word2), C.Main)
		else
			VDW.Tooltip_Show(self, prefixTip, string.format(L.CHECK_VISIBILITY_TIP, word1), C.Main)
		end
	end)
	_G["vdwsOptions2Box1CheckButton"..i]:HookScript("OnLeave", function(self) VDW.Tooltip_Hide() end)
	_G["vdwsOptions2Box1CheckButton"..i]:HookScript("OnClick", function (self, button)
		if button == "LeftButton" then
			if self:GetChecked() == true then
				if i == 1 then
					VDWSsettings.Looty.Visible = true
				elseif i == 2 then
					VDWSsettings.Looty.Title = true
				elseif i == 3 then
					VDWSsettings.Looty.SSOA = true
				elseif i == 4 then
					VDWSsettings.Looty.Loot = true
				elseif i == 5 then
					VDWSsettings.Looty.Coins = true
				elseif i == 6 then
					VDWSsettings.Looty.Currencies = true
				elseif i == 7 then
					VDWSsettings.Looty.XP = true
				elseif i == 8 then
					VDWSsettings.Looty.Honor = true
				elseif i == 9 then
					VDWSsettings.Looty.Reputation = true
				elseif i == 10 then
					VDWSsettings.Looty.Skill = true
				elseif i == 11 then
					VDWSsettings.Looty.Miscellaneous = true
				end
				self.Text:SetTextColor(C.Main:GetRGB())
			elseif self:GetChecked() == false then
				if i == 1 then
					VDWSsettings.Looty.Visible = false
				elseif i == 2 then
					VDWSsettings.Looty.Title = false
				elseif i == 3 then
					VDWSsettings.Looty.SSOA = false
				elseif i == 4 then
					VDWSsettings.Looty.Loot = false
				elseif i == 5 then
					VDWSsettings.Looty.Coins = false
				elseif i == 6 then
					VDWSsettings.Looty.Currencies = false
				elseif i == 7 then
					VDWSsettings.Looty.XP = false
				elseif i == 8 then
					VDWSsettings.Looty.Honor = false
				elseif i == 9 then
					VDWSsettings.Looty.Reputation = false
				elseif i == 10 then
					VDWSsettings.Looty.Skill = false
				elseif i == 11 then
					VDWSsettings.Looty.Miscellaneous = false
				end
				self.Text:SetTextColor(0.35, 0.35, 0.35, 0.8)
			end
			PlaySound(858, "Master")
			VDW.VDWS.LootyChk()
		end
	end)
end
-- popout artwork --
ColoringPopOutButtons(2, 1)
vdwsOptions2Box2PopOut1.Title:SetText(L.STYLE)
for i, name in ipairs(backgroundStyle) do
	counter = counter + 1
	local btn = CreateFrame("Button", "vdwsOptions2Box2PopOut1Choice"..i, nil, "vdwPopOutButton")
	_G["vdwsOptions2Box2PopOut1Choice"..i]:ClearAllPoints()
	if i == 1 then
		_G["vdwsOptions2Box2PopOut1Choice"..i]:SetParent(vdwsOptions2Box2PopOut1)
		_G["vdwsOptions2Box2PopOut1Choice"..i]:SetPoint("TOP", vdwsOptions2Box2PopOut1, "BOTTOM", 0, 4)
		_G["vdwsOptions2Box2PopOut1Choice"..i]:SetScript("OnShow", function(self)
			self:GetParent():SetNormalAtlas("charactercreate-customize-dropdownbox-hover")
			PlaySound(855, "Master")
		end)
		_G["vdwsOptions2Box2PopOut1Choice"..i]:SetScript("OnHide", function(self)
			self:GetParent():SetNormalAtlas("charactercreate-customize-dropdownbox-open")
			PlaySound(855, "Master")
		end)
	else
		_G["vdwsOptions2Box2PopOut1Choice"..i]:SetParent(vdwsOptions2Box2PopOut1Choice1)
		_G["vdwsOptions2Box2PopOut1Choice"..i]:SetPoint("TOP", _G["vdwsOptions2Box2PopOut1Choice"..i-1], "BOTTOM", 0, 0)
		_G["vdwsOptions2Box2PopOut1Choice"..i]:Show()
	end
	_G["vdwsOptions2Box2PopOut1Choice"..i].Text:SetText(name)
	_G["vdwsOptions2Box2PopOut1Choice"..i]:HookScript("OnClick", function(self, button, down)
		if button == "LeftButton" and down == false then
			VDWSsettings.Looty.Background.Style = self.Text:GetText()
			vdwsOptions2Box2PopOut1.Text:SetText(self.Text:GetText())
			vdwsOptions2Box2PopOut1Choice1:Hide()
			VDW.VDWS.LootyChk()
		end
	end)
	local w = _G["vdwsOptions2Box2PopOut1Choice"..i].Text:GetStringWidth()
	if w > maxW then maxW = w end
end
finalW = math.ceil(maxW + 24)
for i = 1, counter, 1 do
	_G["vdwsOptions2Box2PopOut1Choice"..i]:SetWidth(finalW)
end
counter = 0
maxW = 160
vdwsOptions2Box2PopOut1:HookScript("OnEnter", function(self)
	local parent = self:GetParent()
	local word = parent.Title:GetText()
	VDW.Tooltip_Show(self, prefixTip, string.format(L.STYLE_TIP, word), C.Main)
end)
vdwsOptions2Box2PopOut1:HookScript("OnLeave", function(self) VDW.Tooltip_Hide() end)
vdwsOptions2Box2PopOut1:HookScript("OnClick", function(self, button, down)
	if button == "LeftButton" and down == false then
		if not vdwsOptions2Box2PopOut1Choice1:IsShown() then
			vdwsOptions2Box2PopOut1Choice1:Show()
		else
			vdwsOptions2Box2PopOut1Choice1:Hide()
		end
	end
end)
-- popout color --
ColoringPopOutButtons(2, 2)
vdwsOptions2Box2PopOut2.Title:SetText(L.COLOR)
for i, name in ipairs(color) do
	counter = counter + 1
	local btn = CreateFrame("Button", "vdwsOptions2Box2PopOut2Choice"..i, nil, "vdwPopOutButton")
	_G["vdwsOptions2Box2PopOut2Choice"..i]:ClearAllPoints()
	if i == 1 then
		_G["vdwsOptions2Box2PopOut2Choice"..i]:SetParent(vdwsOptions2Box2PopOut2)
		_G["vdwsOptions2Box2PopOut2Choice"..i]:SetPoint("TOP", vdwsOptions2Box2PopOut2, "BOTTOM", 0, 4)
		_G["vdwsOptions2Box2PopOut2Choice"..i]:SetScript("OnShow", function(self)
			self:GetParent():SetNormalAtlas("charactercreate-customize-dropdownbox-hover")
			PlaySound(855, "Master")
		end)
		_G["vdwsOptions2Box2PopOut2Choice"..i]:SetScript("OnHide", function(self)
			self:GetParent():SetNormalAtlas("charactercreate-customize-dropdownbox-open")
			PlaySound(855, "Master")
		end)
	else
		_G["vdwsOptions2Box2PopOut2Choice"..i]:SetParent(vdwsOptions2Box2PopOut2Choice1)
		_G["vdwsOptions2Box2PopOut2Choice"..i]:SetPoint("TOP", _G["vdwsOptions2Box2PopOut2Choice"..i-1], "BOTTOM", 0, 0)
		_G["vdwsOptions2Box2PopOut2Choice"..i]:Show()
	end
	_G["vdwsOptions2Box2PopOut2Choice"..i].Text:SetText(name)
	_G["vdwsOptions2Box2PopOut2Choice"..i]:HookScript("OnClick", function(self, button, down)
		if button == "LeftButton" and down == false then
			VDWSsettings.Looty.Background.Color = self.Text:GetText()
			vdwsOptions2Box2PopOut2.Text:SetText(self.Text:GetText())
			vdwsOptions2Box2PopOut2Choice1:Hide()
			VDW.VDWS.LootyChk()
		end
	end)
	local w = _G["vdwsOptions2Box2PopOut2Choice"..i].Text:GetStringWidth()
	if w > maxW then maxW = w end
end
finalW = math.ceil(maxW + 24)
for i = 1, counter, 1 do
	_G["vdwsOptions2Box2PopOut2Choice"..i]:SetWidth(finalW)
end
counter = 0
maxW = 160
vdwsOptions2Box2PopOut2:HookScript("OnEnter", function(self)
	local parent = self:GetParent()
	local word = parent.Title:GetText()
	VDW.Tooltip_Show(self, prefixTip, string.format(L.COLOR_TIP, word), C.Main)
end)
vdwsOptions2Box2PopOut2:HookScript("OnLeave", function(self) VDW.Tooltip_Hide() end)
vdwsOptions2Box2PopOut2:HookScript("OnClick", function(self, button, down)
	if button == "LeftButton" and down == false then
		if not vdwsOptions2Box2PopOut2Choice1:IsShown() then
			vdwsOptions2Box2PopOut2Choice1:Show()
		else
			vdwsOptions2Box2PopOut2Choice1:Hide()
		end
	end
end)
-- slide bar opacity --
vdwsOptions2Box2Slider1:SetWidth(vdwsOptions2Box2:GetWidth() * 0.9)
vdwsOptions2Box2Slider1.Slider.Thumb:SetVertexColor(C.Main:GetRGB())
vdwsOptions2Box2Slider1.Back:GetRegions():SetVertexColor(C.Main:GetRGB())
vdwsOptions2Box2Slider1.Forward:GetRegions():SetVertexColor(C.Main:GetRGB())
vdwsOptions2Box2Slider1.TopText:SetTextColor(C.High:GetRGB())
vdwsOptions2Box2Slider1.MinText:SetTextColor(C.High:GetRGB())
vdwsOptions2Box2Slider1.MaxText:SetTextColor(C.High:GetRGB())
vdwsOptions2Box2Slider1.MinText:SetText("0%")
vdwsOptions2Box2Slider1.MaxText:SetText("100%")
vdwsOptions2Box2Slider1.Slider:SetMinMaxValues(0, 100)
-- enter --
vdwsOptions2Box2Slider1.Slider:HookScript("OnEnter", function(self)
	VDW.Tooltip_Show(self, prefixTip, L.SLIDER_TIP, C.Main)
end)
-- leave --
vdwsOptions2Box2Slider1.Slider:HookScript("OnLeave", function(self) VDW.Tooltip_Hide() end)
-- mouse wheel --
vdwsOptions2Box2Slider1.Slider:SetScript("OnMouseWheel", MouseWheelSlider)
-- value change --
vdwsOptions2Box2Slider1.Slider:SetScript("OnValueChanged", function (self, value, userInput)
	vdwsOptions2Box2Slider1.TopText:SetText(string.format(L.SLIDER_TEXT_OPACITY, self:GetValue()).."%")
	VDWSsettings.Looty.Background.Alpha = self:GetValue()/100
	vdwsLooty.BGtexture1:SetAlpha(VDWSsettings.Looty.Background.Alpha)
	vdwsLooty.BGtexture2:SetAlpha(VDWSsettings.Looty.Background.Alpha*0.75)
	vdwsLooty.Title:SetAlpha(VDWSsettings.Looty.Background.Alpha)
	PlaySound(858, "Master")
end)
-- slide bar width --
vdwsOptions2Box3Slider1:SetWidth(vdwsOptions2Box3:GetWidth() * 0.9)
vdwsOptions2Box3Slider1.Slider.Thumb:SetVertexColor(C.Main:GetRGB())
vdwsOptions2Box3Slider1.Back:GetRegions():SetVertexColor(C.Main:GetRGB())
vdwsOptions2Box3Slider1.Forward:GetRegions():SetVertexColor(C.Main:GetRGB())
vdwsOptions2Box3Slider1.TopText:SetTextColor(C.High:GetRGB())
vdwsOptions2Box3Slider1.MinText:SetTextColor(C.High:GetRGB())
vdwsOptions2Box3Slider1.MaxText:SetTextColor(C.High:GetRGB())
vdwsOptions2Box3Slider1.MinText:SetText(240)
vdwsOptions2Box3Slider1.MaxText:SetText(640)
vdwsOptions2Box3Slider1.Slider:SetMinMaxValues(240, 640)
-- enter --
vdwsOptions2Box3Slider1.Slider:HookScript("OnEnter", function(self)
	VDW.Tooltip_Show(self, prefixTip, L.SLIDER_TIP, C.Main)
end)
-- leave --
vdwsOptions2Box3Slider1.Slider:HookScript("OnLeave", function(self) VDW.Tooltip_Hide() end)
-- mouse wheel --
vdwsOptions2Box3Slider1.Slider:SetScript("OnMouseWheel", MouseWheelSlider)
-- value change --
vdwsOptions2Box3Slider1.Slider:SetScript("OnValueChanged", function (self, value, userInput)
	vdwsOptions2Box3Slider1.TopText:SetText(string.format(L.SLIDER_TEXT_WIDTH, self:GetValue()))
	VDWSsettings.Looty.Size.W = self:GetValue()
	vdwsLooty:SetWidth(VDWSsettings.Looty.Size.W)
	PlaySound(858, "Master")
end)
-- slide bar Height --
vdwsOptions2Box3Slider2:SetWidth(vdwsOptions2Box3:GetWidth() * 0.9)
vdwsOptions2Box3Slider2.Slider.Thumb:SetVertexColor(C.Main:GetRGB())
vdwsOptions2Box3Slider2.Back:GetRegions():SetVertexColor(C.Main:GetRGB())
vdwsOptions2Box3Slider2.Forward:GetRegions():SetVertexColor(C.Main:GetRGB())
vdwsOptions2Box3Slider2.TopText:SetTextColor(C.High:GetRGB())
vdwsOptions2Box3Slider2.MinText:SetTextColor(C.High:GetRGB())
vdwsOptions2Box3Slider2.MaxText:SetTextColor(C.High:GetRGB())
vdwsOptions2Box3Slider2.MinText:SetText(80)
vdwsOptions2Box3Slider2.MaxText:SetText(640)
vdwsOptions2Box3Slider2.Slider:SetMinMaxValues(80, 640)
-- enter --
vdwsOptions2Box3Slider2.Slider:HookScript("OnEnter", function(self)
	VDW.Tooltip_Show(self, prefixTip, L.SLIDER_TIP, C.Main)
end)
-- leave --
vdwsOptions2Box3Slider2.Slider:HookScript("OnLeave", function(self) VDW.Tooltip_Hide() end)
-- mouse wheel --
vdwsOptions2Box3Slider2.Slider:SetScript("OnMouseWheel", MouseWheelSlider)
-- value change --
vdwsOptions2Box3Slider2.Slider:SetScript("OnValueChanged", function (self, value, userInput)
	vdwsOptions2Box3Slider2.TopText:SetText(string.format(L.SLIDER_TEXT_HEIGHT, self:GetValue()))
	VDWSsettings.Looty.Size.H = self:GetValue()
	vdwsLooty:SetHeight(VDWSsettings.Looty.Size.H)
	PlaySound(858, "Master")
end)
-- popout general style
ColoringPopOutButtons(4, 1)
vdwsOptions2Box4PopOut1.Title:SetText(L.STYLE)
for i, name in ipairs(fontsStyle) do
	counter = counter + 1
	local btn = CreateFrame("Button", "vdwsOptions2Box4PopOut1Choice"..i, nil, "vdwPopOutButton")
	_G["vdwsOptions2Box4PopOut1Choice"..i]:ClearAllPoints()
	if i == 1 then
		_G["vdwsOptions2Box4PopOut1Choice"..i]:SetParent(vdwsOptions2Box4PopOut1)
		_G["vdwsOptions2Box4PopOut1Choice"..i]:SetPoint("TOP", vdwsOptions2Box4PopOut1, "BOTTOM", 0, 4)
		_G["vdwsOptions2Box4PopOut1Choice"..i]:SetScript("OnShow", function(self)
			self:GetParent():SetNormalAtlas("charactercreate-customize-dropdownbox-hover")
			PlaySound(855, "Master")
		end)
		_G["vdwsOptions2Box4PopOut1Choice"..i]:SetScript("OnHide", function(self)
			self:GetParent():SetNormalAtlas("charactercreate-customize-dropdownbox-open")
			PlaySound(855, "Master")
		end)
	else
		_G["vdwsOptions2Box4PopOut1Choice"..i]:SetParent(vdwsOptions2Box4PopOut1Choice1)
		_G["vdwsOptions2Box4PopOut1Choice"..i]:SetPoint("TOP", _G["vdwsOptions2Box4PopOut1Choice"..i-1], "BOTTOM", 0, 0)
		_G["vdwsOptions2Box4PopOut1Choice"..i]:Show()
	end
	_G["vdwsOptions2Box4PopOut1Choice"..i].Text:SetText(name)
	_G["vdwsOptions2Box4PopOut1Choice"..i]:HookScript("OnClick", function(self, button, down)
		if button == "LeftButton" and down == false then
			if self.Text:GetText() == "Normal" then
				vdwsOptions2Box4PopOut2:Show()
				vdwsOptions2Box4PopOut2.Text:SetText("")
				vdwsOptions2Box4PopOut3:Hide()
				vdwsOptions2Box4PopOut4:Hide()
			elseif self.Text:GetText() == "Funky" then
				vdwsOptions2Box4PopOut2:Hide()
				vdwsOptions2Box4PopOut3:Show()
				vdwsOptions2Box4PopOut3.Text:SetText("")
				vdwsOptions2Box4PopOut4:Hide()
			elseif self.Text:GetText() == "Groovy" then
				vdwsOptions2Box4PopOut2:Hide()
				vdwsOptions2Box4PopOut3:Hide()
				vdwsOptions2Box4PopOut4:Show()
				vdwsOptions2Box4PopOut4.Text:SetText("")
			end
			VDWSsettings.Looty.Fonts.Color = self.Text:GetText()
			vdwsOptions2Box4PopOut1.Text:SetText(self.Text:GetText())
			vdwsOptions2Box4PopOut1Choice1:Hide()
		end
	end)
	local w = _G["vdwsOptions2Box4PopOut1Choice"..i].Text:GetStringWidth()
	if w > maxW then maxW = w end
end
finalW = math.ceil(maxW + 24)
for i = 1, counter, 1 do
	_G["vdwsOptions2Box4PopOut1Choice"..i]:SetWidth(finalW)
end
counter = 0
maxW = 160
vdwsOptions2Box4PopOut1:HookScript("OnEnter", function(self)
	local parent = self:GetParent()
	local word = parent.Title:GetText()
	VDW.Tooltip_Show(self, prefixTip, string.format(L.STYLE_TIP, word), C.Main)
end)
vdwsOptions2Box4PopOut1:HookScript("OnLeave", function(self) VDW.Tooltip_Hide() end)
vdwsOptions2Box4PopOut1:HookScript("OnClick", function(self, button, down)
	if button == "LeftButton" and down == false then
		if not vdwsOptions2Box4PopOut1Choice1:IsShown() then
			vdwsOptions2Box4PopOut1Choice1:Show()
		else
			vdwsOptions2Box4PopOut1Choice1:Hide()
		end
	end
end)
-- popout style normal
ColoringPopOutButtons(4, 2)
vdwsOptions2Box4PopOut2.Title:SetText(L.SIZE)
for i, name in ipairs(fontsStyle1) do
	counter = counter + 1
	local btn = CreateFrame("Button", "vdwsOptions2Box4PopOut2Choice"..i, nil, "vdwPopOutButton")
	_G["vdwsOptions2Box4PopOut2Choice"..i]:ClearAllPoints()
	if i == 1 then
		_G["vdwsOptions2Box4PopOut2Choice"..i]:SetParent(vdwsOptions2Box4PopOut2)
		_G["vdwsOptions2Box4PopOut2Choice"..i]:SetPoint("TOP", vdwsOptions2Box4PopOut2, "BOTTOM", 0, 4)
		_G["vdwsOptions2Box4PopOut2Choice"..i]:SetScript("OnShow", function(self)
			self:GetParent():SetNormalAtlas("charactercreate-customize-dropdownbox-hover")
			PlaySound(855, "Master")
		end)
		_G["vdwsOptions2Box4PopOut2Choice"..i]:SetScript("OnHide", function(self)
			self:GetParent():SetNormalAtlas("charactercreate-customize-dropdownbox-open")
			PlaySound(855, "Master")
		end)
	else
		_G["vdwsOptions2Box4PopOut2Choice"..i]:SetParent(vdwsOptions2Box4PopOut2Choice1)
		_G["vdwsOptions2Box4PopOut2Choice"..i]:SetPoint("TOP", _G["vdwsOptions2Box4PopOut2Choice"..i-1], "BOTTOM", 0, 0)
		_G["vdwsOptions2Box4PopOut2Choice"..i]:Show()
	end
	_G["vdwsOptions2Box4PopOut2Choice"..i].Text:SetText(name)
	_G["vdwsOptions2Box4PopOut2Choice"..i]:HookScript("OnClick", function(self, button, down)
		if button == "LeftButton" and down == false then
			VDWSsettings.Looty.Fonts.Style = self.Text:GetText()
			vdwsOptions2Box4PopOut2.Text:SetText(self.Text:GetText())
			vdwsOptions2Box4PopOut2Choice1:Hide()
			VDW.VDWS.LootyChk()
		end
	end)
	local w = _G["vdwsOptions2Box4PopOut2Choice"..i].Text:GetStringWidth()
	if w > maxW then maxW = w end
end
finalW = math.ceil(maxW + 24)
for i = 1, counter, 1 do
	_G["vdwsOptions2Box4PopOut2Choice"..i]:SetWidth(finalW)
end
counter = 0
maxW = 160
vdwsOptions2Box4PopOut2:HookScript("OnEnter", function(self)
	local parent = self:GetParent()
	local word = parent.Title:GetText()
	VDW.Tooltip_Show(self, prefixTip, string.format(L.SIZE_TIP, word), C.Main)
end)
vdwsOptions2Box4PopOut2:HookScript("OnLeave", function(self) VDW.Tooltip_Hide() end)
vdwsOptions2Box4PopOut2:HookScript("OnClick", function(self, button, down)
	if button == "LeftButton" and down == false then
		if not vdwsOptions2Box4PopOut2Choice1:IsShown() then
			vdwsOptions2Box4PopOut2Choice1:Show()
		else
			vdwsOptions2Box4PopOut2Choice1:Hide()
		end
	end
end)
-- popout style funky
ColoringPopOutButtons(4, 3)
vdwsOptions2Box4PopOut3.Title:SetText(L.SIZE)
for i, name in ipairs(fontsStyle2) do
	counter = counter + 1
	local btn = CreateFrame("Button", "vdwsOptions2Box4PopOut3Choice"..i, nil, "vdwPopOutButton")
	_G["vdwsOptions2Box4PopOut3Choice"..i]:ClearAllPoints()
	if i == 1 then
		_G["vdwsOptions2Box4PopOut3Choice"..i]:SetParent(vdwsOptions2Box4PopOut3)
		_G["vdwsOptions2Box4PopOut3Choice"..i]:SetPoint("TOP", vdwsOptions2Box4PopOut3, "BOTTOM", 0, 4)
		_G["vdwsOptions2Box4PopOut3Choice"..i]:SetScript("OnShow", function(self)
			self:GetParent():SetNormalAtlas("charactercreate-customize-dropdownbox-hover")
			PlaySound(855, "Master")
		end)
		_G["vdwsOptions2Box4PopOut3Choice"..i]:SetScript("OnHide", function(self)
			self:GetParent():SetNormalAtlas("charactercreate-customize-dropdownbox-open")
			PlaySound(855, "Master")
		end)
	else
		_G["vdwsOptions2Box4PopOut3Choice"..i]:SetParent(vdwsOptions2Box4PopOut3Choice1)
		_G["vdwsOptions2Box4PopOut3Choice"..i]:SetPoint("TOP", _G["vdwsOptions2Box4PopOut3Choice"..i-1], "BOTTOM", 0, 0)
		_G["vdwsOptions2Box4PopOut3Choice"..i]:Show()
	end
	_G["vdwsOptions2Box4PopOut3Choice"..i].Text:SetText(name)
	_G["vdwsOptions2Box4PopOut3Choice"..i]:HookScript("OnClick", function(self, button, down)
		if button == "LeftButton" and down == false then
			VDWSsettings.Looty.Fonts.Style = self.Text:GetText()
			vdwsOptions2Box4PopOut3.Text:SetText(self.Text:GetText())
			vdwsOptions2Box4PopOut3Choice1:Hide()
			VDW.VDWS.LootyChk()
		end
	end)
	local w = _G["vdwsOptions2Box4PopOut3Choice"..i].Text:GetStringWidth()
	if w > maxW then maxW = w end
end
finalW = math.ceil(maxW + 24)
for i = 1, counter, 1 do
	_G["vdwsOptions2Box4PopOut3Choice"..i]:SetWidth(finalW)
end
counter = 0
maxW = 160
vdwsOptions2Box4PopOut3:HookScript("OnEnter", function(self)
	local parent = self:GetParent()
	local word = parent.Title:GetText()
	VDW.Tooltip_Show(self, prefixTip, string.format(L.SIZE_TIP, word), C.Main)
end)
vdwsOptions2Box4PopOut3:HookScript("OnLeave", function(self) VDW.Tooltip_Hide() end)
vdwsOptions2Box4PopOut3:HookScript("OnClick", function(self, button, down)
	if button == "LeftButton" and down == false then
		if not vdwsOptions2Box4PopOut3Choice1:IsShown() then
			vdwsOptions2Box4PopOut3Choice1:Show()
		else
			vdwsOptions2Box4PopOut3Choice1:Hide()
		end
	end
end)
-- popout style groovy
ColoringPopOutButtons(4, 4)
vdwsOptions2Box4PopOut4.Title:SetText(L.SIZE)
for i, name in ipairs(fontsStyle3) do
	counter = counter + 1
	local btn = CreateFrame("Button", "vdwsOptions2Box4PopOut4Choice"..i, nil, "vdwPopOutButton")
	_G["vdwsOptions2Box4PopOut4Choice"..i]:ClearAllPoints()
	if i == 1 then
		_G["vdwsOptions2Box4PopOut4Choice"..i]:SetParent(vdwsOptions2Box4PopOut4)
		_G["vdwsOptions2Box4PopOut4Choice"..i]:SetPoint("TOP", vdwsOptions2Box4PopOut4, "BOTTOM", 0, 4)
		_G["vdwsOptions2Box4PopOut4Choice"..i]:SetScript("OnShow", function(self)
			self:GetParent():SetNormalAtlas("charactercreate-customize-dropdownbox-hover")
			PlaySound(855, "Master")
		end)
		_G["vdwsOptions2Box4PopOut4Choice"..i]:SetScript("OnHide", function(self)
			self:GetParent():SetNormalAtlas("charactercreate-customize-dropdownbox-open")
			PlaySound(855, "Master")
		end)
	else
		_G["vdwsOptions2Box4PopOut4Choice"..i]:SetParent(vdwsOptions2Box4PopOut4Choice1)
		_G["vdwsOptions2Box4PopOut4Choice"..i]:SetPoint("TOP", _G["vdwsOptions2Box4PopOut4Choice"..i-1], "BOTTOM", 0, 0)
		_G["vdwsOptions2Box4PopOut4Choice"..i]:Show()
	end
	_G["vdwsOptions2Box4PopOut4Choice"..i].Text:SetText(name)
	_G["vdwsOptions2Box4PopOut4Choice"..i]:HookScript("OnClick", function(self, button, down)
		if button == "LeftButton" and down == false then
			VDWSsettings.Looty.Fonts.Style = self.Text:GetText()
			vdwsOptions2Box4PopOut4.Text:SetText(self.Text:GetText())
			vdwsOptions2Box4PopOut4Choice1:Hide()
			VDW.VDWS.LootyChk()
		end
	end)
	local w = _G["vdwsOptions2Box4PopOut4Choice"..i].Text:GetStringWidth()
	if w > maxW then maxW = w end
end
finalW = math.ceil(maxW + 24)
for i = 1, counter, 1 do
	_G["vdwsOptions2Box4PopOut4Choice"..i]:SetWidth(finalW)
end
counter = 0
maxW = 160
vdwsOptions2Box4PopOut4:HookScript("OnEnter", function(self)
	local parent = self:GetParent()
	local word = parent.Title:GetText()
	VDW.Tooltip_Show(self, prefixTip, string.format(L.SIZE_TIP, word), C.Main)
end)
vdwsOptions2Box4PopOut4:HookScript("OnLeave", function(self) VDW.Tooltip_Hide() end)
vdwsOptions2Box4PopOut4:HookScript("OnClick", function(self, button, down)
	if button == "LeftButton" and down == false then
		if not vdwsOptions2Box4PopOut4Choice1:IsShown() then
			vdwsOptions2Box4PopOut4Choice1:Show()
		else
			vdwsOptions2Box4PopOut4Choice1:Hide()
		end
	end
end)
-- slide bar duration --
vdwsOptions2Box4Slider1:SetWidth(vdwsOptions2Box4:GetWidth() * 0.9)
vdwsOptions2Box4Slider1.Slider.Thumb:SetVertexColor(C.Main:GetRGB())
vdwsOptions2Box4Slider1.Back:GetRegions():SetVertexColor(C.Main:GetRGB())
vdwsOptions2Box4Slider1.Forward:GetRegions():SetVertexColor(C.Main:GetRGB())
vdwsOptions2Box4Slider1.TopText:SetTextColor(C.High:GetRGB())
vdwsOptions2Box4Slider1.MinText:SetTextColor(C.High:GetRGB())
vdwsOptions2Box4Slider1.MaxText:SetTextColor(C.High:GetRGB())
vdwsOptions2Box4Slider1.MinText:SetText(10)
vdwsOptions2Box4Slider1.MaxText:SetText(180)
vdwsOptions2Box4Slider1.Slider:SetMinMaxValues(10, 180)
-- enter --
vdwsOptions2Box4Slider1.Slider:HookScript("OnEnter", function(self)
	VDW.Tooltip_Show(self, prefixTip, L.SLIDER_TIP, C.Main)
end)
-- leave --
vdwsOptions2Box4Slider1.Slider:HookScript("OnLeave", function(self) VDW.Tooltip_Hide() end)
-- mouse wheel --
vdwsOptions2Box4Slider1.Slider:SetScript("OnMouseWheel", MouseWheelSlider)
-- value change --
vdwsOptions2Box4Slider1.Slider:SetScript("OnValueChanged", function (self, value, userInput)
	vdwsOptions2Box4Slider1.TopText:SetText(string.format(L.SLIDER_TEXT_VISIBILITY, self:GetValue()))
	VDWSsettings.Looty.Duration = self:GetValue()
	vdwsLooty:SetTimeVisible(VDWSsettings.Looty.Duration)
	PlaySound(858, "Master")
end)
-- check saved variables --
local function CheckSavedVariables()
	if VDWSsettings.Looty.Visible then
		vdwsOptions2Box1CheckButton1:SetChecked(true)
		vdwsOptions2Box1CheckButton1.Text:SetTextColor(C.Main:GetRGB())
	else
		vdwsOptions2Box1CheckButton1:SetChecked(false)
		vdwsOptions2Box1CheckButton1.Text:SetTextColor(0.35, 0.35, 0.35, 0.8)
	end
	if VDWSsettings.Looty.Title then
		vdwsOptions2Box1CheckButton2:SetChecked(true)
		vdwsOptions2Box1CheckButton2.Text:SetTextColor(C.Main:GetRGB())
	else
		vdwsOptions2Box1CheckButton2:SetChecked(false)
		vdwsOptions2Box1CheckButton2.Text:SetTextColor(0.35, 0.35, 0.35, 0.8)
	end
	if VDWSsettings.Looty.SSOA then
		vdwsOptions2Box1CheckButton3:SetChecked(true)
		vdwsOptions2Box1CheckButton3.Text:SetTextColor(C.Main:GetRGB())
	else
		vdwsOptions2Box1CheckButton3:SetChecked(false)
		vdwsOptions2Box1CheckButton3.Text:SetTextColor(0.35, 0.35, 0.35, 0.8)
	end
	if VDWSsettings.Looty.Loot then
		vdwsOptions2Box1CheckButton4:SetChecked(true)
		vdwsOptions2Box1CheckButton4.Text:SetTextColor(C.Main:GetRGB())
	else
		vdwsOptions2Box1CheckButton4:SetChecked(false)
		vdwsOptions2Box1CheckButton4.Text:SetTextColor(0.35, 0.35, 0.35, 0.8)
	end
	if VDWSsettings.Looty.Coins then
		vdwsOptions2Box1CheckButton5:SetChecked(true)
		vdwsOptions2Box1CheckButton5.Text:SetTextColor(C.Main:GetRGB())
	else
		vdwsOptions2Box1CheckButton5:SetChecked(false)
		vdwsOptions2Box1CheckButton5.Text:SetTextColor(0.35, 0.35, 0.35, 0.8)
	end
	if VDWSsettings.Looty.Currencies then
		vdwsOptions2Box1CheckButton6:SetChecked(true)
		vdwsOptions2Box1CheckButton6.Text:SetTextColor(C.Main:GetRGB())
	else
		vdwsOptions2Box1CheckButton6:SetChecked(false)
		vdwsOptions2Box1CheckButton6.Text:SetTextColor(0.35, 0.35, 0.35, 0.8)
	end
	if VDWSsettings.Looty.XP then
		vdwsOptions2Box1CheckButton7:SetChecked(true)
		vdwsOptions2Box1CheckButton7.Text:SetTextColor(C.Main:GetRGB())
	else
		vdwsOptions2Box1CheckButton7:SetChecked(false)
		vdwsOptions2Box1CheckButton7.Text:SetTextColor(0.35, 0.35, 0.35, 0.8)
	end
	if VDWSsettings.Looty.Honor then
		vdwsOptions2Box1CheckButton8:SetChecked(true)
		vdwsOptions2Box1CheckButton8.Text:SetTextColor(C.Main:GetRGB())
	else
		vdwsOptions2Box1CheckButton8:SetChecked(false)
		vdwsOptions2Box1CheckButton8.Text:SetTextColor(0.35, 0.35, 0.35, 0.8)
	end
	if VDWSsettings.Looty.Reputation then
		vdwsOptions2Box1CheckButton9:SetChecked(true)
		vdwsOptions2Box1CheckButton9.Text:SetTextColor(C.Main:GetRGB())
	else
		vdwsOptions2Box1CheckButton9:SetChecked(false)
		vdwsOptions2Box1CheckButton9.Text:SetTextColor(0.35, 0.35, 0.35, 0.8)
	end
	if VDWSsettings.Looty.Skill then
		vdwsOptions2Box1CheckButton10:SetChecked(true)
		vdwsOptions2Box1CheckButton10.Text:SetTextColor(C.Main:GetRGB())
	else
		vdwsOptions2Box1CheckButton10:SetChecked(false)
		vdwsOptions2Box1CheckButton10.Text:SetTextColor(0.35, 0.35, 0.35, 0.8)
	end
	if VDWSsettings.Looty.Miscellaneous then
		vdwsOptions2Box1CheckButton11:SetChecked(true)
		vdwsOptions2Box1CheckButton11.Text:SetTextColor(C.Main:GetRGB())
	else
		vdwsOptions2Box1CheckButton11:SetChecked(false)
		vdwsOptions2Box1CheckButton11.Text:SetTextColor(0.35, 0.35, 0.35, 0.8)
	end
	vdwsOptions2Box2PopOut1.Text:SetText(VDWSsettings.Looty.Background.Style)
	vdwsOptions2Box2PopOut2.Text:SetText(VDWSsettings.Looty.Background.Color)
	vdwsOptions2Box2Slider1.Slider:SetValue(VDWSsettings.Looty.Background.Alpha*100)
	vdwsOptions2Box3Slider1.Slider:SetValue(VDWSsettings.Looty.Size.W)
	vdwsOptions2Box3Slider2.Slider:SetValue(VDWSsettings.Looty.Size.H)
	vdwsOptions2Box4PopOut1.Text:SetText(VDWSsettings.Looty.Fonts.Color)
	vdwsOptions2Box4PopOut2.Text:SetText(VDWSsettings.Looty.Fonts.Style)
	vdwsOptions2Box4PopOut3.Text:SetText(VDWSsettings.Looty.Fonts.Style)
	vdwsOptions2Box4PopOut4.Text:SetText(VDWSsettings.Looty.Fonts.Style)
	if VDWSsettings.Looty.Fonts.Color == "Normal" then
		vdwsOptions2Box4PopOut2:Show()
		vdwsOptions2Box4PopOut3:Hide()
		vdwsOptions2Box4PopOut4:Hide()
	elseif VDWSsettings.Looty.Fonts.Color == "Funky" then
		vdwsOptions2Box4PopOut2:Hide()
		vdwsOptions2Box4PopOut3:Show()
		vdwsOptions2Box4PopOut4:Hide()
	elseif VDWSsettings.Looty.Fonts.Color == "Groovy" then
		vdwsOptions2Box4PopOut2:Hide()
		vdwsOptions2Box4PopOut3:Hide()
		vdwsOptions2Box4PopOut4:Show()
	end
	vdwsOptions2Box4Slider1.Slider:SetValue(VDWSsettings.Looty.Duration)
end
-- Show the option panel --
vdwsOptions2:HookScript("OnShow", function(self)
	vdwsOptions0Tab1.Text:SetTextColor(0.4, 0.4, 0.4, 1)
	vdwsOptions0Tab3.Text:SetTextColor(0.4, 0.4, 0.4, 1)
	vdwsOptions0Tab4.Text:SetTextColor(0.4, 0.4, 0.4, 1)
	if vdwsOptions1:IsShown() then vdwsOptions1:Hide() end
	if vdwsOptions3:IsShown() then vdwsOptions3:Hide() end
	if vdwsOptions4:IsShown() then vdwsOptions4:Hide() end
	vdwsOptions0Tab2.Text:SetTextColor(C.High:GetRGB())
	vdwsLooty:RegisterForDrag("LeftButton")
	CheckSavedVariables()
end)
-- Show the option panel --
vdwsOptions2:HookScript("OnHide", function(self)
	vdwsLooty:RegisterForDrag("None")
end)