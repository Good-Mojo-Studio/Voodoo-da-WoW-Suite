-- some variables --
local G = VDW.Local.Override
local L = VDW.VDWS.Local
local C = VDW.GetAddonColors("VDWS")
local prefixTip = VDW.Prefix("VDWS")
local prefixChat = VDW.PrefixChat("VDWS")
local maxW = 160
local finalW = 0
local counter = 0
local style = {"Izes", "Kedima", "Kuriza", "Kladia",}
local color = {G.OPTIONS_C_DEFAULT, G.OPTIONS_C_CLASS, G.OPTIONS_C_FACTION,}
-- Taking care of the option panel --
vdwsOptions1:SetSize(576, 498)
vdwsOptions1:ClearAllPoints()
vdwsOptions1:SetPoint("TOPLEFT", vdwsOptions0, "TOPLEFT", 0, 0)
-- Background of the option panel --
vdwsOptions1.BGtexture:SetAtlas("UI-Frame-BossPortrait-Background", false)
vdwsOptions1.BGtexture:SetVertexColor(C.High:GetRGB())
vdwsOptions1.BGtexture:SetDesaturation(0.3)
-- Title of the option panel --
vdwsOptions1.Title:SetTextColor(C.Main:GetRGB())
vdwsOptions1.Title:SetText(prefixTip.."|nVersion: "..C.High:WrapTextInColorCode(C_AddOns.GetAddOnMetadata("VDWS", "Version")))
-- Top text of the option panel --
vdwsOptions1.TopTxt:SetTextColor(C.Main:GetRGB())
vdwsOptions1.TopTxt:SetText("Four Edges Options")
-- Bottom right text of the option panel --
vdwsOptions1.BottomRightTxt:SetTextColor(C.Main:GetRGB())
vdwsOptions1.BottomRightTxt:SetText("May the Good "..C.High:WrapTextInColorCode("Mojo").." be with you!")
-- taking care of the boxes --
vdwsOptions1Box1:SetHeight(224)
vdwsOptions1Box3:SetHeight(144)
vdwsOptions1Box1.Title:SetText(L.W_VISIBILITY)
vdwsOptions1Box2.Title:SetText("Artwork")
vdwsOptions1Box3.Title:SetText("Size")
vdwsOptions1Box2:ClearAllPoints()
vdwsOptions1Box2:SetPoint("TOPLEFT", vdwsOptions1Box1, "TOPRIGHT", 0, 0)
vdwsOptions1Box3:ClearAllPoints()
vdwsOptions1Box3:SetPoint("TOPLEFT", vdwsOptions1Box2, "BOTTOMLEFT", 0, 0)
for i = 1, 3, 1 do
	local tW = _G["vdwsOptions1Box"..i].Title:GetStringWidth()+16
	local W = _G["vdwsOptions1Box"..i]:GetWidth()
	if tW >= W then
		_G["vdwsOptions1Box"..i]:SetWidth(tW)
	end
end
-- Coloring the boxes --
for i = 1, 3, 1 do
	_G["vdwsOptions1Box"..i].Title:SetTextColor(C.Main:GetRGB())
	_G["vdwsOptions1Box"..i].BorderTop:SetVertexColor(C.High:GetRGB())
	_G["vdwsOptions1Box"..i].BorderBottom:SetVertexColor(C.High:GetRGB())
	_G["vdwsOptions1Box"..i].BorderLeft:SetVertexColor(C.High:GetRGB())
	_G["vdwsOptions1Box"..i].BorderRight:SetVertexColor(C.High:GetRGB())
end
-- Coloring the pop out buttons --
local function ColoringPopOutButtons(k, var1)
	_G["vdwsOptions1Box"..k.."PopOut"..var1].Text:SetTextColor(C.Main:GetRGB())
	_G["vdwsOptions1Box"..k.."PopOut"..var1].Title:SetTextColor(C.High:GetRGB())
	_G["vdwsOptions1Box"..k.."PopOut"..var1].NormalTexture:SetVertexColor(C.High:GetRGB())
	_G["vdwsOptions1Box"..k.."PopOut"..var1].HighlightTexture:SetVertexColor(C.Main:GetRGB())
	_G["vdwsOptions1Box"..k.."PopOut"..var1].PushedTexture:SetVertexColor(C.High:GetRGB())
end
-- Mouse Wheel on Sliders --
local function MouseWheelSlider(self, delta)
	if delta == 1 then
		self:SetValue(self:GetValue() + 1)
	elseif delta == -1 then
		self:SetValue(self:GetValue() - 1)
	end
end
-- check button show - hide edge artwork --
vdwsOptions1Box1CheckButton1.Text:SetText("Top left edge artwork")
vdwsOptions1Box1CheckButton2.Text:SetText("Bottom left edge artwork")
vdwsOptions1Box1CheckButton3.Text:SetText("Top right edge artwork")
vdwsOptions1Box1CheckButton4.Text:SetText("Bottom right edge artwork")
for i = 1, 4, 1 do
	_G["vdwsOptions1Box1CheckButton"..i].Text:SetWidth(vdwsOptions1Box1:GetWidth()*0.8)
	_G["vdwsOptions1Box1CheckButton"..i]:SetScript("OnEnter", function(self)
		local word = self.Text:GetText()
		VDW.Tooltip_Show(self, prefixTip, string.format(L.W_CHECKBOX_TIP, word), C.Main)
	end)
	_G["vdwsOptions1Box1CheckButton"..i]:HookScript("OnLeave", function(self) VDW.Tooltip_Hide() end)
	_G["vdwsOptions1Box1CheckButton"..i]:HookScript("OnClick", function (self, button)
		if button == "LeftButton" then
			if self:GetChecked() == true then
				VDWSsettings["FourEdges"]["vdwsFourEdges"..i] = true
				self.Text:SetTextColor(C.Main:GetRGB())
			elseif self:GetChecked() == false then
				VDWSsettings["FourEdges"]["vdwsFourEdges"..i] = false
				self.Text:SetTextColor(0.35, 0.35, 0.35, 0.8)
			end
			VDW.VDWS.FourEdgesChk()
			PlaySound(858, "Master")
		end
	end)
end
-- slide bar opacity --
vdwsOptions1Box1Slider1:SetWidth(vdwsOptions1Box1:GetWidth() * 0.9)
vdwsOptions1Box1Slider1.Slider.Thumb:SetVertexColor(C.Main:GetRGB())
vdwsOptions1Box1Slider1.Back:GetRegions():SetVertexColor(C.Main:GetRGB())
vdwsOptions1Box1Slider1.Forward:GetRegions():SetVertexColor(C.Main:GetRGB())
vdwsOptions1Box1Slider1.TopText:SetTextColor(C.High:GetRGB())
vdwsOptions1Box1Slider1.MinText:SetTextColor(C.High:GetRGB())
vdwsOptions1Box1Slider1.MaxText:SetTextColor(C.High:GetRGB())
vdwsOptions1Box1Slider1.MinText:SetText(0)
vdwsOptions1Box1Slider1.MaxText:SetText(1)
vdwsOptions1Box1Slider1.Slider:SetMinMaxValues(0, 100)
-- enter --
vdwsOptions1Box1Slider1.Slider:HookScript("OnEnter", function(self)
	VDW.Tooltip_Show(self, prefixTip, L.W_SLIDER_TIP, C.Main)
end)
-- leave --
vdwsOptions1Box1Slider1.Slider:HookScript("OnLeave", function(self) VDW.Tooltip_Hide() end)
-- mouse wheel --
vdwsOptions1Box1Slider1.Slider:SetScript("OnMouseWheel", MouseWheelSlider)
-- value change --
vdwsOptions1Box1Slider1.Slider:SetScript("OnValueChanged", function (self, value, userInput)
	vdwsOptions1Box1Slider1.TopText:SetText("Opacity: "..self:GetValue()/100)
	VDWSsettings.FourEdges.Alpha = self:GetValue()/100
	for i = 1, 4, 1 do
		_G["vdwsFourEdges"..i]:SetAlpha(VDWSsettings.FourEdges.Alpha)
	end
	PlaySound(858, "Master")
end)
-- popout artwork --
ColoringPopOutButtons(2, 1)
vdwsOptions1Box2PopOut1.Title:SetText(L.W_STYLE)
for i, name in ipairs(style) do
	counter = counter + 1
	local btn = CreateFrame("Button", "vdwsOptions1Box2PopOut1Choice"..i, nil, "vdwPopOutButton")
	_G["vdwsOptions1Box2PopOut1Choice"..i]:ClearAllPoints()
	if i == 1 then
		_G["vdwsOptions1Box2PopOut1Choice"..i]:SetParent(vdwsOptions1Box2PopOut1)
		_G["vdwsOptions1Box2PopOut1Choice"..i]:SetPoint("TOP", vdwsOptions1Box2PopOut1, "BOTTOM", 0, 4)
		_G["vdwsOptions1Box2PopOut1Choice"..i]:SetScript("OnShow", function(self)
			self:GetParent():SetNormalAtlas("charactercreate-customize-dropdownbox-hover")
			PlaySound(855, "Master")
		end)
		_G["vdwsOptions1Box2PopOut1Choice"..i]:SetScript("OnHide", function(self)
			self:GetParent():SetNormalAtlas("charactercreate-customize-dropdownbox-open")
			PlaySound(855, "Master")
		end)
	else
		_G["vdwsOptions1Box2PopOut1Choice"..i]:SetParent(vdwsOptions1Box2PopOut1Choice1)
		_G["vdwsOptions1Box2PopOut1Choice"..i]:SetPoint("TOP", _G["vdwsOptions1Box2PopOut1Choice"..i-1], "BOTTOM", 0, 0)
		_G["vdwsOptions1Box2PopOut1Choice"..i]:Show()
	end
	_G["vdwsOptions1Box2PopOut1Choice"..i].Text:SetText(name)
	_G["vdwsOptions1Box2PopOut1Choice"..i]:HookScript("OnClick", function(self, button, down)
		if button == "LeftButton" and down == false then
			VDWSsettings.FourEdges.Style = self.Text:GetText()
			vdwsOptions1Box2PopOut1.Text:SetText(self.Text:GetText())
			vdwsOptions1Box2PopOut1Choice1:Hide()
			VDW.VDWS.FourEdgesChk()
		end
	end)
	local w = _G["vdwsOptions1Box2PopOut1Choice"..i].Text:GetStringWidth()
	if w > maxW then maxW = w end
end
finalW = math.ceil(maxW + 24)
for i = 1, counter, 1 do
	_G["vdwsOptions1Box2PopOut1Choice"..i]:SetWidth(finalW)
end
counter = 0
maxW = 160
vdwsOptions1Box2PopOut1:HookScript("OnEnter", function(self)
	local parent = self:GetParent()
	local word = parent.Title:GetText()
	VDW.Tooltip_Show(self, prefixTip, string.format(L.W_S_TIP, word), C.Main)
end)
vdwsOptions1Box2PopOut1:HookScript("OnLeave", function(self) VDW.Tooltip_Hide() end)
vdwsOptions1Box2PopOut1:HookScript("OnClick", function(self, button, down)
	if button == "LeftButton" and down == false then
		if not vdwsOptions1Box2PopOut1Choice1:IsShown() then
			vdwsOptions1Box2PopOut1Choice1:Show()
		else
			vdwsOptions1Box2PopOut1Choice1:Hide()
		end
	end
end)
-- popout color --
ColoringPopOutButtons(2, 2)
vdwsOptions1Box2PopOut2.Title:SetText(L.W_COLOR)
for i, name in ipairs(color) do
	counter = counter + 1
	local btn = CreateFrame("Button", "vdwsOptions1Box2PopOut2Choice"..i, nil, "vdwPopOutButton")
	_G["vdwsOptions1Box2PopOut2Choice"..i]:ClearAllPoints()
	if i == 1 then
		_G["vdwsOptions1Box2PopOut2Choice"..i]:SetParent(vdwsOptions1Box2PopOut2)
		_G["vdwsOptions1Box2PopOut2Choice"..i]:SetPoint("TOP", vdwsOptions1Box2PopOut2, "BOTTOM", 0, 4)
		_G["vdwsOptions1Box2PopOut2Choice"..i]:SetScript("OnShow", function(self)
			self:GetParent():SetNormalAtlas("charactercreate-customize-dropdownbox-hover")
			PlaySound(855, "Master")
		end)
		_G["vdwsOptions1Box2PopOut2Choice"..i]:SetScript("OnHide", function(self)
			self:GetParent():SetNormalAtlas("charactercreate-customize-dropdownbox-open")
			PlaySound(855, "Master")
		end)
	else
		_G["vdwsOptions1Box2PopOut2Choice"..i]:SetParent(vdwsOptions1Box2PopOut2Choice1)
		_G["vdwsOptions1Box2PopOut2Choice"..i]:SetPoint("TOP", _G["vdwsOptions1Box2PopOut2Choice"..i-1], "BOTTOM", 0, 0)
		_G["vdwsOptions1Box2PopOut2Choice"..i]:Show()
	end
	_G["vdwsOptions1Box2PopOut2Choice"..i].Text:SetText(name)
	_G["vdwsOptions1Box2PopOut2Choice"..i]:HookScript("OnClick", function(self, button, down)
		if button == "LeftButton" and down == false then
			VDWSsettings.FourEdges.Color = self.Text:GetText()
			vdwsOptions1Box2PopOut2.Text:SetText(self.Text:GetText())
			vdwsOptions1Box2PopOut2Choice1:Hide()
			VDW.VDWS.FourEdgesChk()
		end
	end)
	local w = _G["vdwsOptions1Box2PopOut2Choice"..i].Text:GetStringWidth()
	if w > maxW then maxW = w end
end
finalW = math.ceil(maxW + 24)
for i = 1, counter, 1 do
	_G["vdwsOptions1Box2PopOut2Choice"..i]:SetWidth(finalW)
end
counter = 0
maxW = 160
vdwsOptions1Box2PopOut2:HookScript("OnEnter", function(self)
	local parent = self:GetParent()
	local word = parent.Title:GetText()
	VDW.Tooltip_Show(self, prefixTip, string.format(L.W_C_TIP, word), C.Main)
end)
vdwsOptions1Box2PopOut2:HookScript("OnLeave", function(self) VDW.Tooltip_Hide() end)
vdwsOptions1Box2PopOut2:HookScript("OnClick", function(self, button, down)
	if button == "LeftButton" and down == false then
		if not vdwsOptions1Box2PopOut2Choice1:IsShown() then
			vdwsOptions1Box2PopOut2Choice1:Show()
		else
			vdwsOptions1Box2PopOut2Choice1:Hide()
		end
	end
end)
-- slide bar width --
vdwsOptions1Box3Slider1:SetWidth(vdwsOptions1Box3:GetWidth() * 0.9)
vdwsOptions1Box3Slider1.Slider.Thumb:SetVertexColor(C.Main:GetRGB())
vdwsOptions1Box3Slider1.Back:GetRegions():SetVertexColor(C.Main:GetRGB())
vdwsOptions1Box3Slider1.Forward:GetRegions():SetVertexColor(C.Main:GetRGB())
vdwsOptions1Box3Slider1.TopText:SetTextColor(C.High:GetRGB())
vdwsOptions1Box3Slider1.MinText:SetTextColor(C.High:GetRGB())
vdwsOptions1Box3Slider1.MaxText:SetTextColor(C.High:GetRGB())
vdwsOptions1Box3Slider1.MinText:SetText(80)
vdwsOptions1Box3Slider1.MaxText:SetText(560)
vdwsOptions1Box3Slider1.Slider:SetMinMaxValues(80, 560)
-- enter --
vdwsOptions1Box3Slider1.Slider:HookScript("OnEnter", function(self)
	VDW.Tooltip_Show(self, prefixTip, L.W_SLIDER_TIP, C.Main)
end)
-- leave --
vdwsOptions1Box3Slider1.Slider:HookScript("OnLeave", function(self) VDW.Tooltip_Hide() end)
-- mouse wheel --
vdwsOptions1Box3Slider1.Slider:SetScript("OnMouseWheel", MouseWheelSlider)
-- value change --
vdwsOptions1Box3Slider1.Slider:SetScript("OnValueChanged", function (self, value, userInput)
	vdwsOptions1Box3Slider1.TopText:SetText("Width: "..self:GetValue())
	VDWSsettings.FourEdges.Size.W = self:GetValue()
	for i = 1, 4, 1 do
		_G["vdwsFourEdges"..i]:SetWidth(VDWSsettings.FourEdges.Size.W)
	end
	PlaySound(858, "Master")
end)
-- slide bar Height --
vdwsOptions1Box3Slider2:SetWidth(vdwsOptions1Box3:GetWidth() * 0.9)
vdwsOptions1Box3Slider2.Slider.Thumb:SetVertexColor(C.Main:GetRGB())
vdwsOptions1Box3Slider2.Back:GetRegions():SetVertexColor(C.Main:GetRGB())
vdwsOptions1Box3Slider2.Forward:GetRegions():SetVertexColor(C.Main:GetRGB())
vdwsOptions1Box3Slider2.TopText:SetTextColor(C.High:GetRGB())
vdwsOptions1Box3Slider2.MinText:SetTextColor(C.High:GetRGB())
vdwsOptions1Box3Slider2.MaxText:SetTextColor(C.High:GetRGB())
vdwsOptions1Box3Slider2.MinText:SetText(80)
vdwsOptions1Box3Slider2.MaxText:SetText(560)
vdwsOptions1Box3Slider2.Slider:SetMinMaxValues(80, 560)
-- enter --
vdwsOptions1Box3Slider2.Slider:HookScript("OnEnter", function(self)
	VDW.Tooltip_Show(self, prefixTip, L.W_SLIDER_TIP, C.Main)
end)
-- leave --
vdwsOptions1Box3Slider2.Slider:HookScript("OnLeave", function(self) VDW.Tooltip_Hide() end)
-- mouse wheel --
vdwsOptions1Box3Slider2.Slider:SetScript("OnMouseWheel", MouseWheelSlider)
-- value change --
vdwsOptions1Box3Slider2.Slider:SetScript("OnValueChanged", function (self, value, userInput)
	vdwsOptions1Box3Slider2.TopText:SetText("Height: "..self:GetValue())
	VDWSsettings.FourEdges.Size.H = self:GetValue()
	for i = 1, 4, 1 do
		_G["vdwsFourEdges"..i]:SetHeight(VDWSsettings.FourEdges.Size.H)
	end
	PlaySound(858, "Master")
end)

-- check saved variables --
local function CheckSavedVariables()
	for i = 1, 4, 1 do
		if VDWSsettings["FourEdges"]["vdwsFourEdges"..i] then
			_G["vdwsOptions1Box1CheckButton"..i]:SetChecked(true)
			_G["vdwsOptions1Box1CheckButton"..i].Text:SetTextColor(C.Main:GetRGB())
		else
			_G["vdwsOptions1Box1CheckButton"..i]:SetChecked(false)
			_G["vdwsOptions1Box1CheckButton"..i].Text:SetTextColor(0.35, 0.35, 0.35, 0.8)
		end
	end
	vdwsOptions1Box2PopOut1.Text:SetText(VDWSsettings.FourEdges.Style)
	vdwsOptions1Box2PopOut2.Text:SetText(VDWSsettings.FourEdges.Color)
	vdwsOptions1Box1Slider1.Slider:SetValue(VDWSsettings.FourEdges.Alpha*100)
	vdwsOptions1Box3Slider1.Slider:SetValue(VDWSsettings.FourEdges.Size.W)
	vdwsOptions1Box3Slider2.Slider:SetValue(VDWSsettings.FourEdges.Size.H)
end
-- Show the option panel --
vdwsOptions1:HookScript("OnShow", function(self)
	vdwsOptions0Tab2.Text:SetTextColor(0.4, 0.4, 0.4, 1)
	vdwsOptions0Tab3.Text:SetTextColor(0.4, 0.4, 0.4, 1)
	vdwsOptions0Tab4.Text:SetTextColor(0.4, 0.4, 0.4, 1)
	if vdwsOptions2:IsShown() then vdwsOptions2:Hide() end
	if vdwsOptions3:IsShown() then vdwsOptions3:Hide() end
	if vdwsOptions4:IsShown() then vdwsOptions4:Hide() end
	vdwsOptions0Tab1.Text:SetTextColor(C.High:GetRGB())
	CheckSavedVariables()
end)
-- Background of the tabs frame --
local OptionsW = vdwsOptions1:GetWidth()
vdwsOptions0:SetWidth(vdwsOptions0Tab1:GetWidth() + OptionsW)
vdwsOptions0:SetHeight(vdwsOptions1:GetHeight())
vdwsOptions0.BGtexture:ClearAllPoints()
vdwsOptions0.BGtexture:SetPoint("TOPRIGHT", vdwsOptions0, "TOPRIGHT", 0, 0)
vdwsOptions0.BGtexture:SetPoint("BOTTOMLEFT", vdwsOptions0, "BOTTOMLEFT", OptionsW, 0)
vdwsOptions0.BGtexture:SetAtlas("UI-Frame-BossPortrait-Background", false)
vdwsOptions0.BGtexture:SetDesaturation(0.3)
vdwsOptions0.BGtexture:SetGradient("VERTICAL", C.NoHigh, C.High)
