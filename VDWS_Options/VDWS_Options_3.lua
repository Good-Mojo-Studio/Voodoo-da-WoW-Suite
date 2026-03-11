-- some variables --
local G = VDW.Local.Override
local L = VDW.VDWS.Local
local C = VDW.GetAddonColors("VDWS")
local prefixTip = VDW.Prefix("VDWS")
local NameExist = false
local maxW = 160
local finalW = 0
local counter = 0
local fontsStyle = {"Normal",  "Funky", "Groovy",}
local fontsErrorStyle1 = {"Normal 13", "Normal 14", "Normal 15", "Normal 16", "Normal 17", "Normal 18", "Normal 19", "Normal 20",}
local fontsErrorStyle2 = {"Funky 17", "Funky 18", "Funky 19", "Funky 20", "Funky 21", "Funky 22", "Funky 23", "Funky 24",}
local fontsErrorStyle3 = {"Groovy 17", "Groovy 18", "Groovy 19", "Groovy 20", "Groovy 21", "Groovy 22", "Groovy 23", "Groovy 24",}
local fontsErrorColor = {G.OPTIONS_C_DEFAULT, G.OPTIONS_C_CLASS, G.OPTIONS_C_FACTION,}
local fontsFpsStyle1 = {"Normal 10", "Normal 11", "Normal 12", "Normal 13", "Normal 14", "Normal 15", "Normal 16",}
local fontsFpsStyle2 = {"Funky 12", "Funky 13", "Funky 14", "Funky 15", "Funky 16", "Funky 17", "Funky 18",}
local fontsFpsStyle3 = {"Groovy 12", "Groovy 13", "Groovy 14", "Groovy 15", "Groovy 16", "Groovy 17", "Groovy 18",}
local fontsFpsColor = {G.OPTIONS_C_DEFAULT, G.OPTIONS_C_CLASS, G.OPTIONS_C_FACTION,}
local chatBackground = {G.OPTIONS_C_DEFAULT, "Kladia",}
-- Taking care of the option panel --
vdwsOptions3:SetSize(576, 498)
vdwsOptions3:ClearAllPoints()
vdwsOptions3:SetPoint("TOPLEFT", vdwsOptions0, "TOPLEFT", 0, 0)
-- Background of the option panel --
vdwsOptions3.BGtexture:SetAtlas("UI-Frame-BossPortrait-Background", false)
vdwsOptions3.BGtexture:SetVertexColor(C.High:GetRGB())
vdwsOptions3.BGtexture:SetDesaturation(0.3)
-- Title of the option panel --
vdwsOptions3.Title:SetTextColor(C.Main:GetRGB())
vdwsOptions3.Title:SetText(prefixTip.."|nVersion: "..C.High:WrapTextInColorCode(C_AddOns.GetAddOnMetadata("VDWS", "Version")))
-- Top text of the option panel --
vdwsOptions3.TopTxt:SetTextColor(C.Main:GetRGB())
vdwsOptions3.TopTxt:SetText(string.format(L.OPTIONS_FOR, L.ERROR_FRAME_FPS))
-- Bottom right text of the option panel --
vdwsOptions3.BottomRightTxt:SetTextColor(C.Main:GetRGB())
vdwsOptions3.BottomRightTxt:SetText("May the Good "..C.High:WrapTextInColorCode("Mojo").." be with you! ")
-- taking care of the boxes --
vdwsOptions3Box1.Title:SetText(L.ERROR_FRAME.." "..L.FONTS)
vdwsOptions3Box1:SetHeight(148)
vdwsOptions3Box2.Title:SetText(L.FPS_FRAME.." "..L.FONTS)
vdwsOptions3Box2:SetHeight(148)
vdwsOptions3Box2:ClearAllPoints()
vdwsOptions3Box2:SetPoint("TOPLEFT", vdwsOptions3Box1, "BOTTOMLEFT", 0, 0)
vdwsOptions3Box3.Title:SetText(L.ET_CHETERA)
vdwsOptions3Box3:SetHeight(160)
vdwsOptions3Box3:ClearAllPoints()
vdwsOptions3Box3:SetPoint("TOPLEFT", vdwsOptions3Box1, "TOPRIGHT", 0, 0)
vdwsOptions3Box4.Title:SetText(L.CHAT_BACKGROUND)
vdwsOptions3Box4:SetHeight(104)
vdwsOptions3Box4:ClearAllPoints()
vdwsOptions3Box4:SetPoint("TOPLEFT", vdwsOptions3Box3, "BOTTOMLEFT", 0, 0)
for i = 1, 4, 1 do
	local tW = _G["vdwsOptions3Box"..i].Title:GetStringWidth()+16
	local W = _G["vdwsOptions3Box"..i]:GetWidth()
	if tW >= W then
		_G["vdwsOptions3Box"..i]:SetWidth(tW)
	end
end
-- Coloring the boxes --
for i = 1, 4, 1 do
	_G["vdwsOptions3Box"..i].Title:SetTextColor(C.Main:GetRGB())
	_G["vdwsOptions3Box"..i].BorderTop:SetVertexColor(C.High:GetRGB())
	_G["vdwsOptions3Box"..i].BorderBottom:SetVertexColor(C.High:GetRGB())
	_G["vdwsOptions3Box"..i].BorderLeft:SetVertexColor(C.High:GetRGB())
	_G["vdwsOptions3Box"..i].BorderRight:SetVertexColor(C.High:GetRGB())
end
-- Coloring the pop out buttons --
local function ColoringPopOutButtons(k, var1)
	_G["vdwsOptions3Box"..k.."PopOut"..var1].Text:SetTextColor(C.Main:GetRGB())
	_G["vdwsOptions3Box"..k.."PopOut"..var1].Title:SetTextColor(C.High:GetRGB())
	_G["vdwsOptions3Box"..k.."PopOut"..var1].NormalTexture:SetVertexColor(C.High:GetRGB())
	_G["vdwsOptions3Box"..k.."PopOut"..var1].HighlightTexture:SetVertexColor(C.Main:GetRGB())
	_G["vdwsOptions3Box"..k.."PopOut"..var1].PushedTexture:SetVertexColor(C.High:GetRGB())
end
-- pop out button enable - disable --
local function popEnable(self)
	self:EnableMouse(true)
	self:SetAlpha(1)
end
local function popDisable(self)
	self:EnableMouse(false)
	self:SetAlpha(0.35)
end
-- check box change error frame --
vdwsOptions3Box1CheckButton1.Text:SetText(L.CHANGE_THE_ERROR_FRAME_FONTS)
vdwsOptions3Box1CheckButton1:SetScript("OnEnter", function(self)
		local word = self.Text:GetText()
		VDW.Tooltip_Show(self, prefixTip, string.format(L.CHECK_IF_YOU_WANT_TO_TIP, word), C.Main)
	end)
vdwsOptions3Box1CheckButton1:HookScript("OnLeave", function(self) VDW.Tooltip_Hide() end)
vdwsOptions3Box1CheckButton1:HookScript("OnClick", function (self, button)
	if button == "LeftButton" then
		if self:GetChecked() == true then
			popEnable(vdwsOptions3Box1PopOut1)
			popEnable(vdwsOptions3Box1PopOut2)
			popEnable(vdwsOptions3Box1PopOut3)
			popEnable(vdwsOptions3Box1PopOut4)
			popEnable(vdwsOptions3Box1PopOut5)
			popEnable(vdwsOptions3Box1PopOut6)
			VDWSsettings.ErrorFrame.Changed = true
			self.Text:SetTextColor(C.Main:GetRGB())
		elseif self:GetChecked() == false then
			popDisable(vdwsOptions3Box1PopOut1)
			popDisable(vdwsOptions3Box1PopOut2)
			popDisable(vdwsOptions3Box1PopOut3)
			popDisable(vdwsOptions3Box1PopOut4)
			popDisable(vdwsOptions3Box1PopOut5)
			popDisable(vdwsOptions3Box1PopOut6)
			VDWSsettings.ErrorFrame.Changed = false
			self.Text:SetTextColor(0.35, 0.35, 0.35, 0.8)
		end
		VDW.VDWS.ErrorFrameChk()
		PlaySound(858, "Master")
	end
end)
-- pop out error frame fonts family
ColoringPopOutButtons(1, 1)
vdwsOptions3Box1PopOut1.Title:SetText(L.FONTS)
for i, name in ipairs(fontsStyle) do
	counter = counter + 1
	local btn = CreateFrame("Button", "vdwsOptions3Box1PopOut1Choice"..i, nil, "vdwPopOutButton")
	_G["vdwsOptions3Box1PopOut1Choice"..i]:ClearAllPoints()
	if i == 1 then
		_G["vdwsOptions3Box1PopOut1Choice"..i]:SetParent(vdwsOptions3Box1PopOut1)
		_G["vdwsOptions3Box1PopOut1Choice"..i]:SetPoint("TOP", vdwsOptions3Box1PopOut1, "BOTTOM", 0, 4)
		_G["vdwsOptions3Box1PopOut1Choice"..i]:SetScript("OnShow", function(self)
			self:GetParent():SetNormalAtlas("charactercreate-customize-dropdownbox-hover")
			PlaySound(855, "Master")
		end)
		_G["vdwsOptions3Box1PopOut1Choice"..i]:SetScript("OnHide", function(self)
			self:GetParent():SetNormalAtlas("charactercreate-customize-dropdownbox-open")
			PlaySound(855, "Master")
		end)
	else
		_G["vdwsOptions3Box1PopOut1Choice"..i]:SetParent(vdwsOptions3Box1PopOut1Choice1)
		_G["vdwsOptions3Box1PopOut1Choice"..i]:SetPoint("TOP", _G["vdwsOptions3Box1PopOut1Choice"..i-1], "BOTTOM", 0, 0)
		_G["vdwsOptions3Box1PopOut1Choice"..i]:Show()
	end
	_G["vdwsOptions3Box1PopOut1Choice"..i].Text:SetText(name)
	_G["vdwsOptions3Box1PopOut1Choice"..i]:HookScript("OnClick", function(self, button, down)
		if button == "LeftButton" and down == false then
			if self.Text:GetText() == "Normal" then
				vdwsOptions3Box1PopOut2:Show()
				vdwsOptions3Box1PopOut2.Text:SetText("")
				vdwsOptions3Box1PopOut3:Hide()
				vdwsOptions3Box1PopOut4:Hide()
			elseif self.Text:GetText() == "Funky" then
				vdwsOptions3Box1PopOut2:Hide()
				vdwsOptions3Box1PopOut3:Show()
				vdwsOptions3Box1PopOut3.Text:SetText("")
				vdwsOptions3Box1PopOut4:Hide()
			elseif self.Text:GetText() == "Groovy" then
				vdwsOptions3Box1PopOut2:Hide()
				vdwsOptions3Box1PopOut3:Hide()
				vdwsOptions3Box1PopOut4:Show()
				vdwsOptions3Box1PopOut4.Text:SetText("")
			end
			VDWSsettings.ErrorFrame.Fonts.Family = self.Text:GetText()
			vdwsOptions3Box1PopOut1.Text:SetText(self.Text:GetText())
			vdwsOptions3Box1PopOut1Choice1:Hide()
		end
	end)
	local w = _G["vdwsOptions3Box1PopOut1Choice"..i].Text:GetStringWidth()
	if w > maxW then maxW = w end
end
finalW = math.ceil(maxW + 24)
for i = 1, counter, 1 do
	_G["vdwsOptions3Box1PopOut1Choice"..i]:SetWidth(finalW)
end
counter = 0
maxW = 160
vdwsOptions3Box1PopOut1:HookScript("OnEnter", function(self)
	local parent = self:GetParent()
	local word = parent.Title:GetText()
	VDW.Tooltip_Show(self, prefixTip, string.format(L.STYLE_TIP, word), C.Main)
end)
vdwsOptions3Box1PopOut1:HookScript("OnLeave", function(self) VDW.Tooltip_Hide() end)
vdwsOptions3Box1PopOut1:HookScript("OnClick", function(self, button, down)
	if button == "LeftButton" and down == false then
		if not vdwsOptions3Box1PopOut1Choice1:IsShown() then
			vdwsOptions3Box1PopOut1Choice1:Show()
		else
			vdwsOptions3Box1PopOut1Choice1:Hide()
		end
	end
end)
-- pop out error frame fonts normal
ColoringPopOutButtons(1, 2)
vdwsOptions3Box1PopOut2.Title:SetText(L.SIZE)
for i, name in ipairs(fontsErrorStyle1) do
	counter = counter + 1
	local btn = CreateFrame("Button", "vdwsOptions3Box1PopOut2Choice"..i, nil, "vdwPopOutButton")
	_G["vdwsOptions3Box1PopOut2Choice"..i]:ClearAllPoints()
	if i == 1 then
		_G["vdwsOptions3Box1PopOut2Choice"..i]:SetParent(vdwsOptions3Box1PopOut2)
		_G["vdwsOptions3Box1PopOut2Choice"..i]:SetPoint("TOP", vdwsOptions3Box1PopOut2, "BOTTOM", 0, 4)
		_G["vdwsOptions3Box1PopOut2Choice"..i]:SetScript("OnShow", function(self)
			self:GetParent():SetNormalAtlas("charactercreate-customize-dropdownbox-hover")
			PlaySound(855, "Master")
		end)
		_G["vdwsOptions3Box1PopOut2Choice"..i]:SetScript("OnHide", function(self)
			self:GetParent():SetNormalAtlas("charactercreate-customize-dropdownbox-open")
			PlaySound(855, "Master")
		end)
	else
		_G["vdwsOptions3Box1PopOut2Choice"..i]:SetParent(vdwsOptions3Box1PopOut2Choice1)
		_G["vdwsOptions3Box1PopOut2Choice"..i]:SetPoint("TOP", _G["vdwsOptions3Box1PopOut2Choice"..i-1], "BOTTOM", 0, 0)
		_G["vdwsOptions3Box1PopOut2Choice"..i]:Show()
	end
	_G["vdwsOptions3Box1PopOut2Choice"..i].Text:SetText(name)
	_G["vdwsOptions3Box1PopOut2Choice"..i]:HookScript("OnClick", function(self, button, down)
		if button == "LeftButton" and down == false then
			VDWSsettings.ErrorFrame.Fonts.Style = self.Text:GetText()
			vdwsOptions3Box1PopOut2.Text:SetText(self.Text:GetText())
			vdwsOptions3Box1PopOut2Choice1:Hide()
			VDW.VDWS.ErrorFrameChk()
		end
	end)
	local w = _G["vdwsOptions3Box1PopOut2Choice"..i].Text:GetStringWidth()
	if w > maxW then maxW = w end
end
finalW = math.ceil(maxW + 24)
for i = 1, counter, 1 do
	_G["vdwsOptions3Box1PopOut2Choice"..i]:SetWidth(finalW)
end
counter = 0
maxW = 160
vdwsOptions3Box1PopOut2:HookScript("OnEnter", function(self)
	local parent = self:GetParent()
	local word = parent.Title:GetText()
	VDW.Tooltip_Show(self, prefixTip, string.format(L.SIZE_TIP, word), C.Main)
end)
vdwsOptions3Box1PopOut2:HookScript("OnLeave", function(self) VDW.Tooltip_Hide() end)
vdwsOptions3Box1PopOut2:HookScript("OnClick", function(self, button, down)
	if button == "LeftButton" and down == false then
		if not vdwsOptions3Box1PopOut2Choice1:IsShown() then
			vdwsOptions3Box1PopOut2Choice1:Show()
		else
			vdwsOptions3Box1PopOut2Choice1:Hide()
		end
	end
end)
-- pop out error frame fonts funky
ColoringPopOutButtons(1, 3)
vdwsOptions3Box1PopOut3.Title:SetText(L.SIZE)
for i, name in ipairs(fontsErrorStyle2) do
	counter = counter + 1
	local btn = CreateFrame("Button", "vdwsOptions3Box1PopOut3Choice"..i, nil, "vdwPopOutButton")
	_G["vdwsOptions3Box1PopOut3Choice"..i]:ClearAllPoints()
	if i == 1 then
		_G["vdwsOptions3Box1PopOut3Choice"..i]:SetParent(vdwsOptions3Box1PopOut3)
		_G["vdwsOptions3Box1PopOut3Choice"..i]:SetPoint("TOP", vdwsOptions3Box1PopOut3, "BOTTOM", 0, 4)
		_G["vdwsOptions3Box1PopOut3Choice"..i]:SetScript("OnShow", function(self)
			self:GetParent():SetNormalAtlas("charactercreate-customize-dropdownbox-hover")
			PlaySound(855, "Master")
		end)
		_G["vdwsOptions3Box1PopOut3Choice"..i]:SetScript("OnHide", function(self)
			self:GetParent():SetNormalAtlas("charactercreate-customize-dropdownbox-open")
			PlaySound(855, "Master")
		end)
	else
		_G["vdwsOptions3Box1PopOut3Choice"..i]:SetParent(vdwsOptions3Box1PopOut3Choice1)
		_G["vdwsOptions3Box1PopOut3Choice"..i]:SetPoint("TOP", _G["vdwsOptions3Box1PopOut3Choice"..i-1], "BOTTOM", 0, 0)
		_G["vdwsOptions3Box1PopOut3Choice"..i]:Show()
	end
	_G["vdwsOptions3Box1PopOut3Choice"..i].Text:SetText(name)
	_G["vdwsOptions3Box1PopOut3Choice"..i]:HookScript("OnClick", function(self, button, down)
		if button == "LeftButton" and down == false then
			VDWSsettings.ErrorFrame.Fonts.Style = self.Text:GetText()
			vdwsOptions3Box1PopOut3.Text:SetText(self.Text:GetText())
			vdwsOptions3Box1PopOut3Choice1:Hide()
			VDW.VDWS.ErrorFrameChk()
		end
	end)
	local w = _G["vdwsOptions3Box1PopOut3Choice"..i].Text:GetStringWidth()
	if w > maxW then maxW = w end
end
finalW = math.ceil(maxW + 24)
for i = 1, counter, 1 do
	_G["vdwsOptions3Box1PopOut3Choice"..i]:SetWidth(finalW)
end
counter = 0
maxW = 160
vdwsOptions3Box1PopOut3:HookScript("OnEnter", function(self)
	local parent = self:GetParent()
	local word = parent.Title:GetText()
	VDW.Tooltip_Show(self, prefixTip, string.format(L.SIZE_TIP, word), C.Main)
end)
vdwsOptions3Box1PopOut3:HookScript("OnLeave", function(self) VDW.Tooltip_Hide() end)
vdwsOptions3Box1PopOut3:HookScript("OnClick", function(self, button, down)
	if button == "LeftButton" and down == false then
		if not vdwsOptions3Box1PopOut3Choice1:IsShown() then
			vdwsOptions3Box1PopOut3Choice1:Show()
		else
			vdwsOptions3Box1PopOut3Choice1:Hide()
		end
	end
end)
-- pop out error frame fonts groovy
ColoringPopOutButtons(1, 4)
vdwsOptions3Box1PopOut4.Title:SetText(L.SIZE)
for i, name in ipairs(fontsErrorStyle3) do
	counter = counter + 1
	local btn = CreateFrame("Button", "vdwsOptions3Box1PopOut4Choice"..i, nil, "vdwPopOutButton")
	_G["vdwsOptions3Box1PopOut4Choice"..i]:ClearAllPoints()
	if i == 1 then
		_G["vdwsOptions3Box1PopOut4Choice"..i]:SetParent(vdwsOptions3Box1PopOut4)
		_G["vdwsOptions3Box1PopOut4Choice"..i]:SetPoint("TOP", vdwsOptions3Box1PopOut4, "BOTTOM", 0, 4)
		_G["vdwsOptions3Box1PopOut4Choice"..i]:SetScript("OnShow", function(self)
			self:GetParent():SetNormalAtlas("charactercreate-customize-dropdownbox-hover")
			PlaySound(855, "Master")
		end)
		_G["vdwsOptions3Box1PopOut4Choice"..i]:SetScript("OnHide", function(self)
			self:GetParent():SetNormalAtlas("charactercreate-customize-dropdownbox-open")
			PlaySound(855, "Master")
		end)
	else
		_G["vdwsOptions3Box1PopOut4Choice"..i]:SetParent(vdwsOptions3Box1PopOut4Choice1)
		_G["vdwsOptions3Box1PopOut4Choice"..i]:SetPoint("TOP", _G["vdwsOptions3Box1PopOut4Choice"..i-1], "BOTTOM", 0, 0)
		_G["vdwsOptions3Box1PopOut4Choice"..i]:Show()
	end
	_G["vdwsOptions3Box1PopOut4Choice"..i].Text:SetText(name)
	_G["vdwsOptions3Box1PopOut4Choice"..i]:HookScript("OnClick", function(self, button, down)
		if button == "LeftButton" and down == false then
			VDWSsettings.ErrorFrame.Fonts.Style = self.Text:GetText()
			vdwsOptions3Box1PopOut4.Text:SetText(self.Text:GetText())
			vdwsOptions3Box1PopOut4Choice1:Hide()
			VDW.VDWS.ErrorFrameChk()
		end
	end)
	local w = _G["vdwsOptions3Box1PopOut4Choice"..i].Text:GetStringWidth()
	if w > maxW then maxW = w end
end
finalW = math.ceil(maxW + 24)
for i = 1, counter, 1 do
	_G["vdwsOptions3Box1PopOut4Choice"..i]:SetWidth(finalW)
end
counter = 0
maxW = 160
vdwsOptions3Box1PopOut4:HookScript("OnEnter", function(self)
	local parent = self:GetParent()
	local word = parent.Title:GetText()
	VDW.Tooltip_Show(self, prefixTip, string.format(L.SIZE_TIP, word), C.Main)
end)
vdwsOptions3Box1PopOut4:HookScript("OnLeave", function(self) VDW.Tooltip_Hide() end)
vdwsOptions3Box1PopOut4:HookScript("OnClick", function(self, button, down)
	if button == "LeftButton" and down == false then
		if not vdwsOptions3Box1PopOut4Choice1:IsShown() then
			vdwsOptions3Box1PopOut4Choice1:Show()
		else
			vdwsOptions3Box1PopOut4Choice1:Hide()
		end
	end
end)
-- pop out error frame fonts color fontsErrorColor
-- worning color
ColoringPopOutButtons(1, 5)
vdwsOptions3Box1PopOut5.Title:SetText(L.WARNINGS)
for i, name in ipairs(fontsErrorColor) do
	counter = counter + 1
	local btn = CreateFrame("Button", "vdwsOptions3Box1PopOut5Choice"..i, nil, "vdwPopOutButton")
	_G["vdwsOptions3Box1PopOut5Choice"..i]:ClearAllPoints()
	if i == 1 then
		_G["vdwsOptions3Box1PopOut5Choice"..i]:SetParent(vdwsOptions3Box1PopOut5)
		_G["vdwsOptions3Box1PopOut5Choice"..i]:SetPoint("TOP", vdwsOptions3Box1PopOut5, "BOTTOM", 0, 4)
		_G["vdwsOptions3Box1PopOut5Choice"..i]:SetScript("OnShow", function(self)
			self:GetParent():SetNormalAtlas("charactercreate-customize-dropdownbox-hover")
			PlaySound(855, "Master")
		end)
		_G["vdwsOptions3Box1PopOut5Choice"..i]:SetScript("OnHide", function(self)
			self:GetParent():SetNormalAtlas("charactercreate-customize-dropdownbox-open")
			PlaySound(855, "Master")
		end)
	else
		_G["vdwsOptions3Box1PopOut5Choice"..i]:SetParent(vdwsOptions3Box1PopOut5Choice1)
		_G["vdwsOptions3Box1PopOut5Choice"..i]:SetPoint("TOP", _G["vdwsOptions3Box1PopOut5Choice"..i-1], "BOTTOM", 0, 0)
		_G["vdwsOptions3Box1PopOut5Choice"..i]:Show()
	end
	_G["vdwsOptions3Box1PopOut5Choice"..i].Text:SetText(name)
	_G["vdwsOptions3Box1PopOut5Choice"..i]:HookScript("OnClick", function(self, button, down)
		if button == "LeftButton" and down == false then
			VDWSsettings.ErrorFrame.Fonts.WarningColor = self.Text:GetText()
			vdwsOptions3Box1PopOut5.Text:SetText(self.Text:GetText())
			vdwsOptions3Box1PopOut5Choice1:Hide()
			VDW.VDWS.ErrorFrameChk()
		end
	end)
	local w = _G["vdwsOptions3Box1PopOut5Choice"..i].Text:GetStringWidth()
	if w > maxW then maxW = w end
end
finalW = math.ceil(maxW + 24)
for i = 1, counter, 1 do
	_G["vdwsOptions3Box1PopOut5Choice"..i]:SetWidth(finalW)
end
counter = 0
maxW = 160
vdwsOptions3Box1PopOut5:HookScript("OnEnter", function(self)
	local word = self.Title:GetText()
	VDW.Tooltip_Show(self, prefixTip, string.format(L.COLOR_TIP, word), C.Main)
end)
vdwsOptions3Box1PopOut5:HookScript("OnLeave", function(self) VDW.Tooltip_Hide() end)
vdwsOptions3Box1PopOut5:HookScript("OnClick", function(self, button, down)
	if button == "LeftButton" and down == false then
		if not vdwsOptions3Box1PopOut5Choice1:IsShown() then
			vdwsOptions3Box1PopOut5Choice1:Show()
		else
			vdwsOptions3Box1PopOut5Choice1:Hide()
		end
	end
end)
--error color
ColoringPopOutButtons(1, 6)
vdwsOptions3Box1PopOut6.Title:SetText(L.ERRORS)
for i, name in ipairs(fontsErrorColor) do
	counter = counter + 1
	local btn = CreateFrame("Button", "vdwsOptions3Box1PopOut6Choice"..i, nil, "vdwPopOutButton")
	_G["vdwsOptions3Box1PopOut6Choice"..i]:ClearAllPoints()
	if i == 1 then
		_G["vdwsOptions3Box1PopOut6Choice"..i]:SetParent(vdwsOptions3Box1PopOut6)
		_G["vdwsOptions3Box1PopOut6Choice"..i]:SetPoint("TOP", vdwsOptions3Box1PopOut6, "BOTTOM", 0, 4)
		_G["vdwsOptions3Box1PopOut6Choice"..i]:SetScript("OnShow", function(self)
			self:GetParent():SetNormalAtlas("charactercreate-customize-dropdownbox-hover")
			PlaySound(855, "Master")
		end)
		_G["vdwsOptions3Box1PopOut6Choice"..i]:SetScript("OnHide", function(self)
			self:GetParent():SetNormalAtlas("charactercreate-customize-dropdownbox-open")
			PlaySound(855, "Master")
		end)
	else
		_G["vdwsOptions3Box1PopOut6Choice"..i]:SetParent(vdwsOptions3Box1PopOut6Choice1)
		_G["vdwsOptions3Box1PopOut6Choice"..i]:SetPoint("TOP", _G["vdwsOptions3Box1PopOut6Choice"..i-1], "BOTTOM", 0, 0)
		_G["vdwsOptions3Box1PopOut6Choice"..i]:Show()
	end
	_G["vdwsOptions3Box1PopOut6Choice"..i].Text:SetText(name)
	_G["vdwsOptions3Box1PopOut6Choice"..i]:HookScript("OnClick", function(self, button, down)
		if button == "LeftButton" and down == false then
			VDWSsettings.ErrorFrame.Fonts.ErrorColor = self.Text:GetText()
			vdwsOptions3Box1PopOut6.Text:SetText(self.Text:GetText())
			vdwsOptions3Box1PopOut6Choice1:Hide()
			VDW.VDWS.ErrorFrameChk()
		end
	end)
	local w = _G["vdwsOptions3Box1PopOut6Choice"..i].Text:GetStringWidth()
	if w > maxW then maxW = w end
end
finalW = math.ceil(maxW + 24)
for i = 1, counter, 1 do
	_G["vdwsOptions3Box1PopOut6Choice"..i]:SetWidth(finalW)
end
counter = 0
maxW = 160
vdwsOptions3Box1PopOut6:HookScript("OnEnter", function(self)
	local word = self.Title:GetText()
	VDW.Tooltip_Show(self, prefixTip, string.format(L.COLOR_TIP, word), C.Main)
end)
vdwsOptions3Box1PopOut6:HookScript("OnLeave", function(self) VDW.Tooltip_Hide() end)
vdwsOptions3Box1PopOut6:HookScript("OnClick", function(self, button, down)
	if button == "LeftButton" and down == false then
		if not vdwsOptions3Box1PopOut6Choice1:IsShown() then
			vdwsOptions3Box1PopOut6Choice1:Show()
		else
			vdwsOptions3Box1PopOut6Choice1:Hide()
		end
	end
end)
-- check box show fps frame --
vdwsOptions3Box2CheckButton1.Text:SetText(L.SHOW_FPS)
vdwsOptions3Box2CheckButton1:SetScript("OnEnter", function(self)
	local word = self.Text:GetText()
	VDW.Tooltip_Show(self, prefixTip, string.format(L.CHECK_IF_YOU_WANT_TO_TIP, word), C.Main)
end)
vdwsOptions3Box2CheckButton1:HookScript("OnLeave", function(self) VDW.Tooltip_Hide() end)
vdwsOptions3Box2CheckButton1:HookScript("OnClick", function (self, button)
	if button == "LeftButton" then
		if self:GetChecked() == true then
			popEnable(vdwsOptions3Box2PopOut1)
			popEnable(vdwsOptions3Box2PopOut2)
			popEnable(vdwsOptions3Box2PopOut3)
			popEnable(vdwsOptions3Box2PopOut4)
			popEnable(vdwsOptions3Box2PopOut5)
			VDWSsettings.FPSframe.Visible = true
			self.Text:SetTextColor(C.Main:GetRGB())
		elseif self:GetChecked() == false then
			popDisable(vdwsOptions3Box2PopOut1)
			popDisable(vdwsOptions3Box2PopOut2)
			popDisable(vdwsOptions3Box2PopOut3)
			popDisable(vdwsOptions3Box2PopOut4)
			popDisable(vdwsOptions3Box2PopOut5)
			VDWSsettings.FPSframe.Visible = false
			self.Text:SetTextColor(0.35, 0.35, 0.35, 0.8)
		end
		VDW.VDWS.FPScheck()
		PlaySound(858, "Master")
	end
end)
-- pop out Fps frame fonts family
ColoringPopOutButtons(2, 1)
vdwsOptions3Box2PopOut1.Title:SetText(L.FONTS)
for i, name in ipairs(fontsStyle) do
	counter = counter + 1
	local btn = CreateFrame("Button", "vdwsOptions3Box2PopOut1Choice"..i, nil, "vdwPopOutButton")
	_G["vdwsOptions3Box2PopOut1Choice"..i]:ClearAllPoints()
	if i == 1 then
		_G["vdwsOptions3Box2PopOut1Choice"..i]:SetParent(vdwsOptions3Box2PopOut1)
		_G["vdwsOptions3Box2PopOut1Choice"..i]:SetPoint("TOP", vdwsOptions3Box2PopOut1, "BOTTOM", 0, 4)
		_G["vdwsOptions3Box2PopOut1Choice"..i]:SetScript("OnShow", function(self)
			self:GetParent():SetNormalAtlas("charactercreate-customize-dropdownbox-hover")
			PlaySound(855, "Master")
		end)
		_G["vdwsOptions3Box2PopOut1Choice"..i]:SetScript("OnHide", function(self)
			self:GetParent():SetNormalAtlas("charactercreate-customize-dropdownbox-open")
			PlaySound(855, "Master")
		end)
	else
		_G["vdwsOptions3Box2PopOut1Choice"..i]:SetParent(vdwsOptions3Box2PopOut1Choice1)
		_G["vdwsOptions3Box2PopOut1Choice"..i]:SetPoint("TOP", _G["vdwsOptions3Box2PopOut1Choice"..i-1], "BOTTOM", 0, 0)
		_G["vdwsOptions3Box2PopOut1Choice"..i]:Show()
	end
	_G["vdwsOptions3Box2PopOut1Choice"..i].Text:SetText(name)
	_G["vdwsOptions3Box2PopOut1Choice"..i]:HookScript("OnClick", function(self, button, down)
		if button == "LeftButton" and down == false then
			if self.Text:GetText() == "Normal" then
				vdwsOptions3Box2PopOut2:Show()
				vdwsOptions3Box2PopOut2.Text:SetText("")
				vdwsOptions3Box2PopOut3:Hide()
				vdwsOptions3Box2PopOut4:Hide()
			elseif self.Text:GetText() == "Funky" then
				vdwsOptions3Box2PopOut2:Hide()
				vdwsOptions3Box2PopOut3:Show()
				vdwsOptions3Box2PopOut3.Text:SetText("")
				vdwsOptions3Box2PopOut4:Hide()
			elseif self.Text:GetText() == "Groovy" then
				vdwsOptions3Box2PopOut2:Hide()
				vdwsOptions3Box2PopOut3:Hide()
				vdwsOptions3Box2PopOut4:Show()
				vdwsOptions3Box2PopOut4.Text:SetText("")
			end
			VDWSsettings.FPSframe.Fonts.Family = self.Text:GetText()
			vdwsOptions3Box2PopOut1.Text:SetText(self.Text:GetText())
			vdwsOptions3Box2PopOut1Choice1:Hide()
		end
	end)
	local w = _G["vdwsOptions3Box2PopOut1Choice"..i].Text:GetStringWidth()
	if w > maxW then maxW = w end
end
finalW = math.ceil(maxW + 24)
for i = 1, counter, 1 do
	_G["vdwsOptions3Box2PopOut1Choice"..i]:SetWidth(finalW)
end
counter = 0
maxW = 160
vdwsOptions3Box2PopOut1:HookScript("OnEnter", function(self)
	local parent = self:GetParent()
	local word = parent.Title:GetText()
	VDW.Tooltip_Show(self, prefixTip, string.format(L.STYLE_TIP, word), C.Main)
end)
vdwsOptions3Box2PopOut1:HookScript("OnLeave", function(self) VDW.Tooltip_Hide() end)
vdwsOptions3Box2PopOut1:HookScript("OnClick", function(self, button, down)
	if button == "LeftButton" and down == false then
		if not vdwsOptions3Box2PopOut1Choice1:IsShown() then
			vdwsOptions3Box2PopOut1Choice1:Show()
		else
			vdwsOptions3Box2PopOut1Choice1:Hide()
		end
	end
end)
-- pop out Fps frame fonts normal
ColoringPopOutButtons(2, 2)
vdwsOptions3Box2PopOut2.Title:SetText(L.SIZE)
for i, name in ipairs(fontsFpsStyle1) do
	counter = counter + 1
	local btn = CreateFrame("Button", "vdwsOptions3Box2PopOut2Choice"..i, nil, "vdwPopOutButton")
	_G["vdwsOptions3Box2PopOut2Choice"..i]:ClearAllPoints()
	if i == 1 then
		_G["vdwsOptions3Box2PopOut2Choice"..i]:SetParent(vdwsOptions3Box2PopOut2)
		_G["vdwsOptions3Box2PopOut2Choice"..i]:SetPoint("TOP", vdwsOptions3Box2PopOut2, "BOTTOM", 0, 4)
		_G["vdwsOptions3Box2PopOut2Choice"..i]:SetScript("OnShow", function(self)
			self:GetParent():SetNormalAtlas("charactercreate-customize-dropdownbox-hover")
			PlaySound(855, "Master")
		end)
		_G["vdwsOptions3Box2PopOut2Choice"..i]:SetScript("OnHide", function(self)
			self:GetParent():SetNormalAtlas("charactercreate-customize-dropdownbox-open")
			PlaySound(855, "Master")
		end)
	else
		_G["vdwsOptions3Box2PopOut2Choice"..i]:SetParent(vdwsOptions3Box2PopOut2Choice1)
		_G["vdwsOptions3Box2PopOut2Choice"..i]:SetPoint("TOP", _G["vdwsOptions3Box2PopOut2Choice"..i-1], "BOTTOM", 0, 0)
		_G["vdwsOptions3Box2PopOut2Choice"..i]:Show()
	end
	_G["vdwsOptions3Box2PopOut2Choice"..i].Text:SetText(name)
	_G["vdwsOptions3Box2PopOut2Choice"..i]:HookScript("OnClick", function(self, button, down)
		if button == "LeftButton" and down == false then
			VDWSsettings.FPSframe.Fonts.Style = self.Text:GetText()
			vdwsOptions3Box2PopOut2.Text:SetText(self.Text:GetText())
			vdwsOptions3Box2PopOut2Choice1:Hide()
			VDW.VDWS.FPScheck()
		end
	end)
	local w = _G["vdwsOptions3Box2PopOut2Choice"..i].Text:GetStringWidth()
	if w > maxW then maxW = w end
end
finalW = math.ceil(maxW + 24)
for i = 1, counter, 1 do
	_G["vdwsOptions3Box2PopOut2Choice"..i]:SetWidth(finalW)
end
counter = 0
maxW = 160
vdwsOptions3Box2PopOut2:HookScript("OnEnter", function(self)
	local parent = self:GetParent()
	local word = parent.Title:GetText()
	VDW.Tooltip_Show(self, prefixTip, string.format(L.SIZE_TIP, word), C.Main)
end)
vdwsOptions3Box2PopOut2:HookScript("OnLeave", function(self) VDW.Tooltip_Hide() end)
vdwsOptions3Box2PopOut2:HookScript("OnClick", function(self, button, down)
	if button == "LeftButton" and down == false then
		if not vdwsOptions3Box2PopOut2Choice1:IsShown() then
			vdwsOptions3Box2PopOut2Choice1:Show()
		else
			vdwsOptions3Box2PopOut2Choice1:Hide()
		end
	end
end)
-- pop out Fps frame fonts funky
ColoringPopOutButtons(2, 3)
vdwsOptions3Box2PopOut3.Title:SetText(L.SIZE)
for i, name in ipairs(fontsFpsStyle2) do
	counter = counter + 1
	local btn = CreateFrame("Button", "vdwsOptions3Box2PopOut3Choice"..i, nil, "vdwPopOutButton")
	_G["vdwsOptions3Box2PopOut3Choice"..i]:ClearAllPoints()
	if i == 1 then
		_G["vdwsOptions3Box2PopOut3Choice"..i]:SetParent(vdwsOptions3Box2PopOut3)
		_G["vdwsOptions3Box2PopOut3Choice"..i]:SetPoint("TOP", vdwsOptions3Box2PopOut3, "BOTTOM", 0, 4)
		_G["vdwsOptions3Box2PopOut3Choice"..i]:SetScript("OnShow", function(self)
			self:GetParent():SetNormalAtlas("charactercreate-customize-dropdownbox-hover")
			PlaySound(855, "Master")
		end)
		_G["vdwsOptions3Box2PopOut3Choice"..i]:SetScript("OnHide", function(self)
			self:GetParent():SetNormalAtlas("charactercreate-customize-dropdownbox-open")
			PlaySound(855, "Master")
		end)
	else
		_G["vdwsOptions3Box2PopOut3Choice"..i]:SetParent(vdwsOptions3Box2PopOut3Choice1)
		_G["vdwsOptions3Box2PopOut3Choice"..i]:SetPoint("TOP", _G["vdwsOptions3Box2PopOut3Choice"..i-1], "BOTTOM", 0, 0)
		_G["vdwsOptions3Box2PopOut3Choice"..i]:Show()
	end
	_G["vdwsOptions3Box2PopOut3Choice"..i].Text:SetText(name)
	_G["vdwsOptions3Box2PopOut3Choice"..i]:HookScript("OnClick", function(self, button, down)
		if button == "LeftButton" and down == false then
			VDWSsettings.FPSframe.Fonts.Style = self.Text:GetText()
			vdwsOptions3Box2PopOut3.Text:SetText(self.Text:GetText())
			vdwsOptions3Box2PopOut3Choice1:Hide()
			VDW.VDWS.FPScheck()
		end
	end)
	local w = _G["vdwsOptions3Box2PopOut3Choice"..i].Text:GetStringWidth()
	if w > maxW then maxW = w end
end
finalW = math.ceil(maxW + 24)
for i = 1, counter, 1 do
	_G["vdwsOptions3Box2PopOut3Choice"..i]:SetWidth(finalW)
end
counter = 0
maxW = 160
vdwsOptions3Box2PopOut3:HookScript("OnEnter", function(self)
	local parent = self:GetParent()
	local word = parent.Title:GetText()
	VDW.Tooltip_Show(self, prefixTip, string.format(L.SIZE_TIP, word), C.Main)
end)
vdwsOptions3Box2PopOut3:HookScript("OnLeave", function(self) VDW.Tooltip_Hide() end)
vdwsOptions3Box2PopOut3:HookScript("OnClick", function(self, button, down)
	if button == "LeftButton" and down == false then
		if not vdwsOptions3Box2PopOut3Choice1:IsShown() then
			vdwsOptions3Box2PopOut3Choice1:Show()
		else
			vdwsOptions3Box2PopOut3Choice1:Hide()
		end
	end
end)
-- pop out Fps frame fonts groovy
ColoringPopOutButtons(2, 4)
vdwsOptions3Box2PopOut4.Title:SetText(L.SIZE)
for i, name in ipairs(fontsFpsStyle3) do
	counter = counter + 1
	local btn = CreateFrame("Button", "vdwsOptions3Box2PopOut4Choice"..i, nil, "vdwPopOutButton")
	_G["vdwsOptions3Box2PopOut4Choice"..i]:ClearAllPoints()
	if i == 1 then
		_G["vdwsOptions3Box2PopOut4Choice"..i]:SetParent(vdwsOptions3Box2PopOut4)
		_G["vdwsOptions3Box2PopOut4Choice"..i]:SetPoint("TOP", vdwsOptions3Box2PopOut4, "BOTTOM", 0, 4)
		_G["vdwsOptions3Box2PopOut4Choice"..i]:SetScript("OnShow", function(self)
			self:GetParent():SetNormalAtlas("charactercreate-customize-dropdownbox-hover")
			PlaySound(855, "Master")
		end)
		_G["vdwsOptions3Box2PopOut4Choice"..i]:SetScript("OnHide", function(self)
			self:GetParent():SetNormalAtlas("charactercreate-customize-dropdownbox-open")
			PlaySound(855, "Master")
		end)
	else
		_G["vdwsOptions3Box2PopOut4Choice"..i]:SetParent(vdwsOptions3Box2PopOut4Choice1)
		_G["vdwsOptions3Box2PopOut4Choice"..i]:SetPoint("TOP", _G["vdwsOptions3Box2PopOut4Choice"..i-1], "BOTTOM", 0, 0)
		_G["vdwsOptions3Box2PopOut4Choice"..i]:Show()
	end
	_G["vdwsOptions3Box2PopOut4Choice"..i].Text:SetText(name)
	_G["vdwsOptions3Box2PopOut4Choice"..i]:HookScript("OnClick", function(self, button, down)
		if button == "LeftButton" and down == false then
			VDWSsettings.FPSframe.Fonts.Style = self.Text:GetText()
			vdwsOptions3Box2PopOut4.Text:SetText(self.Text:GetText())
			vdwsOptions3Box2PopOut4Choice1:Hide()
			VDW.VDWS.FPScheck()
		end
	end)
	local w = _G["vdwsOptions3Box2PopOut4Choice"..i].Text:GetStringWidth()
	if w > maxW then maxW = w end
end
finalW = math.ceil(maxW + 24)
for i = 1, counter, 1 do
	_G["vdwsOptions3Box2PopOut4Choice"..i]:SetWidth(finalW)
end
counter = 0
maxW = 160
vdwsOptions3Box2PopOut4:HookScript("OnEnter", function(self)
	local parent = self:GetParent()
	local word = parent.Title:GetText()
	VDW.Tooltip_Show(self, prefixTip, string.format(L.SIZE_TIP, word), C.Main)
end)
vdwsOptions3Box2PopOut4:HookScript("OnLeave", function(self) VDW.Tooltip_Hide() end)
vdwsOptions3Box2PopOut4:HookScript("OnClick", function(self, button, down)
	if button == "LeftButton" and down == false then
		if not vdwsOptions3Box2PopOut4Choice1:IsShown() then
			vdwsOptions3Box2PopOut4Choice1:Show()
		else
			vdwsOptions3Box2PopOut4Choice1:Hide()
		end
	end
end)
-- pop out FPS frame fonts color
ColoringPopOutButtons(2, 5)
vdwsOptions3Box2PopOut5.Title:SetText(L.COLOR)
for i, name in ipairs(fontsFpsColor) do
	counter = counter + 1
	local btn = CreateFrame("Button", "vdwsOptions3Box2PopOut5Choice"..i, nil, "vdwPopOutButton")
	_G["vdwsOptions3Box2PopOut5Choice"..i]:ClearAllPoints()
	if i == 1 then
		_G["vdwsOptions3Box2PopOut5Choice"..i]:SetParent(vdwsOptions3Box2PopOut5)
		_G["vdwsOptions3Box2PopOut5Choice"..i]:SetPoint("TOP", vdwsOptions3Box2PopOut5, "BOTTOM", 0, 4)
		_G["vdwsOptions3Box2PopOut5Choice"..i]:SetScript("OnShow", function(self)
			self:GetParent():SetNormalAtlas("charactercreate-customize-dropdownbox-hover")
			PlaySound(855, "Master")
		end)
		_G["vdwsOptions3Box2PopOut5Choice"..i]:SetScript("OnHide", function(self)
			self:GetParent():SetNormalAtlas("charactercreate-customize-dropdownbox-open")
			PlaySound(855, "Master")
		end)
	else
		_G["vdwsOptions3Box2PopOut5Choice"..i]:SetParent(vdwsOptions3Box2PopOut5Choice1)
		_G["vdwsOptions3Box2PopOut5Choice"..i]:SetPoint("TOP", _G["vdwsOptions3Box2PopOut5Choice"..i-1], "BOTTOM", 0, 0)
		_G["vdwsOptions3Box2PopOut5Choice"..i]:Show()
	end
	_G["vdwsOptions3Box2PopOut5Choice"..i].Text:SetText(name)
	_G["vdwsOptions3Box2PopOut5Choice"..i]:HookScript("OnClick", function(self, button, down)
		if button == "LeftButton" and down == false then
			VDWSsettings.FPSframe.Fonts.Color = self.Text:GetText()
			vdwsOptions3Box2PopOut5.Text:SetText(self.Text:GetText())
			vdwsOptions3Box2PopOut5Choice1:Hide()
			VDW.VDWS.FPScheck()
		end
	end)
	local w = _G["vdwsOptions3Box2PopOut5Choice"..i].Text:GetStringWidth()
	if w > maxW then maxW = w end
end
finalW = math.ceil(maxW + 24)
for i = 1, counter, 1 do
	_G["vdwsOptions3Box2PopOut5Choice"..i]:SetWidth(finalW)
end
counter = 0
maxW = 160
vdwsOptions3Box2PopOut5:HookScript("OnEnter", function(self)
	local parent = self:GetParent()
	local word = parent.Title:GetText()
	VDW.Tooltip_Show(self, prefixTip, string.format(L.COLOR_TIP, word), C.Main)
end)
vdwsOptions3Box2PopOut5:HookScript("OnLeave", function(self) VDW.Tooltip_Hide() end)
vdwsOptions3Box2PopOut5:HookScript("OnClick", function(self, button, down)
	if button == "LeftButton" and down == false then
		if not vdwsOptions3Box2PopOut5Choice1:IsShown() then
			vdwsOptions3Box2PopOut5Choice1:Show()
		else
			vdwsOptions3Box2PopOut5Choice1:Hide()
		end
	end
end)
-- check button et chetera --
vdwsOptions3Box3CheckButton1.Text:SetText(L.SHOW_MICROMENU)
vdwsOptions3Box3CheckButton2.Text:SetText(L.SHOW_BAR_TEXT)
vdwsOptions3Box3CheckButton3.Text:SetText(L.MAP_CLOCK)
for i = 1, 3, 1 do
	_G["vdwsOptions3Box3CheckButton"..i].Text:SetWidth(vdwsOptions3Box3:GetWidth()*0.8)
	_G["vdwsOptions3Box3CheckButton"..i]:SetScript("OnEnter", function(self)
		local word = self.Text:GetText()
		VDW.Tooltip_Show(self, prefixTip, string.format(L.CHECK_IF_YOU_WANT_TO_TIP, word), C.Main)
	end)
	_G["vdwsOptions3Box3CheckButton"..i]:HookScript("OnLeave", function(self) VDW.Tooltip_Hide() end)
	_G["vdwsOptions3Box3CheckButton"..i]:HookScript("OnClick", function (self, button)
		if button == "LeftButton" then
			if self:GetChecked() == true then
				if i == 1 then
					VDWSsettings.MicroMenuContainer.Changed = true
					VDW.VDWS.MMCFrameChk()
				elseif i == 2 then
					VDWSsettings.StatusBarText = true
					VDW.VDWS.StatusBarTextChk()
				elseif i == 3 then
					VDWSsettings.MapClock24 = true
					VDW.VDWS.MapClock24Chk()
				end
				self.Text:SetTextColor(C.Main:GetRGB())
			elseif self:GetChecked() == false then
				if i == 1 then
					VDWSsettings.MicroMenuContainer.Changed = false
					VDW.VDWS.MMCFrameChk()
				elseif i == 2 then
					VDWSsettings.StatusBarText = false
					VDW.VDWS.StatusBarTextChk()
				elseif i == 3 then
					VDWSsettings.MapClock24 = false
					VDW.VDWS.MapClock24Chk()
				end
				self.Text:SetTextColor(0.35, 0.35, 0.35, 0.8)
			end
			PlaySound(858, "Master")
		end
	end)
end
-- chat background
vdwsOptions3Box4CheckButton1.Text:SetText(L.SHOW_CHAT_BACKGROUND)
vdwsOptions3Box4CheckButton1.Text:SetWidth(vdwsOptions3Box3:GetWidth()*0.8)
vdwsOptions3Box4CheckButton1:SetScript("OnEnter", function(self)
	local word = self.Text:GetText()
	VDW.Tooltip_Show(self, prefixTip, string.format(L.CHECK_IF_YOU_WANT_TO_TIP, word), C.Main)
end)
vdwsOptions3Box4CheckButton1:HookScript("OnLeave", function(self) VDW.Tooltip_Hide() end)
vdwsOptions3Box4CheckButton1:HookScript("OnClick", function (self, button)
	if button == "LeftButton" then
		if self:GetChecked() == true then
			VDWSsettings.Chat.Changed = true
			VDW.VDWS.ChatFrameChk()
			self.Text:SetTextColor(C.Main:GetRGB())
			popEnable(vdwsOptions3Box4PopOut1)
		elseif self:GetChecked() == false then
			VDWSsettings.Chat.Changed = false
			VDW.VDWS.ChatFrameChk()
			self.Text:SetTextColor(0.35, 0.35, 0.35, 0.8)
			popDisable(vdwsOptions3Box4PopOut1)
		end
	end
end)
-- pop out style chat background
ColoringPopOutButtons(4, 1)
vdwsOptions3Box4PopOut1.Title:SetText(L.STYLE)
for i, name in ipairs(chatBackground) do
	counter = counter + 1
	local btn = CreateFrame("Button", "vdwsOptions3Box4PopOut1Choice"..i, nil, "vdwPopOutButton")
	_G["vdwsOptions3Box4PopOut1Choice"..i]:ClearAllPoints()
	if i == 1 then
		_G["vdwsOptions3Box4PopOut1Choice"..i]:SetParent(vdwsOptions3Box4PopOut1)
		_G["vdwsOptions3Box4PopOut1Choice"..i]:SetPoint("TOP", vdwsOptions3Box4PopOut1, "BOTTOM", 0, 4)
		_G["vdwsOptions3Box4PopOut1Choice"..i]:SetScript("OnShow", function(self)
			self:GetParent():SetNormalAtlas("charactercreate-customize-dropdownbox-hover")
			PlaySound(855, "Master")
		end)
		_G["vdwsOptions3Box4PopOut1Choice"..i]:SetScript("OnHide", function(self)
			self:GetParent():SetNormalAtlas("charactercreate-customize-dropdownbox-open")
			PlaySound(855, "Master")
		end)
	else
		_G["vdwsOptions3Box4PopOut1Choice"..i]:SetParent(vdwsOptions3Box4PopOut1Choice1)
		_G["vdwsOptions3Box4PopOut1Choice"..i]:SetPoint("TOP", _G["vdwsOptions3Box4PopOut1Choice"..i-1], "BOTTOM", 0, 0)
		_G["vdwsOptions3Box4PopOut1Choice"..i]:Show()
	end
	_G["vdwsOptions3Box4PopOut1Choice"..i].Text:SetText(name)
	_G["vdwsOptions3Box4PopOut1Choice"..i]:HookScript("OnClick", function(self, button, down)
		if button == "LeftButton" and down == false then
			VDWSsettings.Chat.Background.Style = self.Text:GetText()
			vdwsOptions3Box4PopOut1.Text:SetText(self.Text:GetText())
			vdwsOptions3Box4PopOut1Choice1:Hide()
			VDW.VDWS.ChatFrameChk()
		end
	end)
	local w = _G["vdwsOptions3Box4PopOut1Choice"..i].Text:GetStringWidth()
	if w > maxW then maxW = w end
end
finalW = math.ceil(maxW + 24)
for i = 1, counter, 1 do
	_G["vdwsOptions3Box4PopOut1Choice"..i]:SetWidth(finalW)
end
counter = 0
maxW = 160
vdwsOptions3Box4PopOut1:HookScript("OnEnter", function(self)
	local parent = self:GetParent()
	local word = parent.Title:GetText()
	VDW.Tooltip_Show(self, prefixTip, string.format(L.STYLE_TIP, word), C.Main)
end)
vdwsOptions3Box4PopOut1:HookScript("OnLeave", function(self) VDW.Tooltip_Hide() end)
vdwsOptions3Box4PopOut1:HookScript("OnClick", function(self, button, down)
	if button == "LeftButton" and down == false then
		if not vdwsOptions3Box4PopOut1Choice1:IsShown() then
			vdwsOptions3Box4PopOut1Choice1:Show()
		else
			vdwsOptions3Box4PopOut1Choice1:Hide()
		end
	end
end)
-- check saved variables --
local function CheckSavedVariables()
	if VDWSsettings.ErrorFrame.Changed then
		vdwsOptions3Box1CheckButton1:SetChecked(true)
		vdwsOptions3Box1CheckButton1.Text:SetTextColor(C.Main:GetRGB())
		popEnable(vdwsOptions3Box1PopOut1)
		popEnable(vdwsOptions3Box1PopOut2)
		popEnable(vdwsOptions3Box1PopOut3)
		popEnable(vdwsOptions3Box1PopOut4)
		popEnable(vdwsOptions3Box1PopOut5)
		popEnable(vdwsOptions3Box1PopOut6)
	else
		vdwsOptions3Box1CheckButton1:SetChecked(false)
		vdwsOptions3Box1CheckButton1.Text:SetTextColor(0.35, 0.35, 0.35, 0.8)
		popDisable(vdwsOptions3Box1PopOut1)
		popDisable(vdwsOptions3Box1PopOut2)
		popDisable(vdwsOptions3Box1PopOut3)
		popDisable(vdwsOptions3Box1PopOut4)
		popDisable(vdwsOptions3Box1PopOut5)
		popDisable(vdwsOptions3Box1PopOut6)
	end
	vdwsOptions3Box1PopOut1.Text:SetText(VDWSsettings.ErrorFrame.Fonts.Family)
	if vdwsOptions3Box1PopOut1.Text:GetText() == "Normal" then
		vdwsOptions3Box1PopOut2:Show()
		vdwsOptions3Box1PopOut3:Hide()
		vdwsOptions3Box1PopOut4:Hide()
	elseif vdwsOptions3Box1PopOut1.Text:GetText() == "Funky" then
		vdwsOptions3Box1PopOut2:Hide()
		vdwsOptions3Box1PopOut3:Show()
		vdwsOptions3Box1PopOut4:Hide()
	elseif vdwsOptions3Box1PopOut1.Text:GetText() == "Groovy" then
		vdwsOptions3Box1PopOut2:Hide()
		vdwsOptions3Box1PopOut3:Hide()
		vdwsOptions3Box1PopOut4:Show()
	end
	vdwsOptions3Box1PopOut2.Text:SetText(VDWSsettings.ErrorFrame.Fonts.Style)
	vdwsOptions3Box1PopOut3.Text:SetText(VDWSsettings.ErrorFrame.Fonts.Style)
	vdwsOptions3Box1PopOut4.Text:SetText(VDWSsettings.ErrorFrame.Fonts.Style)
	vdwsOptions3Box1PopOut5.Text:SetText(VDWSsettings.ErrorFrame.Fonts.WarningColor)
	vdwsOptions3Box1PopOut6.Text:SetText(VDWSsettings.ErrorFrame.Fonts.ErrorColor)
	if VDWSsettings.FPSframe.Visible then
		vdwsOptions3Box2CheckButton1:SetChecked(true)
		vdwsOptions3Box2CheckButton1.Text:SetTextColor(C.Main:GetRGB())
		popEnable(vdwsOptions3Box2PopOut1)
		popEnable(vdwsOptions3Box2PopOut2)
		popEnable(vdwsOptions3Box2PopOut3)
		popEnable(vdwsOptions3Box2PopOut4)
		popEnable(vdwsOptions3Box2PopOut5)
	else
		vdwsOptions3Box2CheckButton1:SetChecked(false)
		vdwsOptions3Box2CheckButton1.Text:SetTextColor(0.35, 0.35, 0.35, 0.8)
		popDisable(vdwsOptions3Box2PopOut1)
		popDisable(vdwsOptions3Box2PopOut2)
		popDisable(vdwsOptions3Box2PopOut3)
		popDisable(vdwsOptions3Box2PopOut4)
		popDisable(vdwsOptions3Box2PopOut5)
	end
	vdwsOptions3Box2PopOut1.Text:SetText(VDWSsettings.FPSframe.Fonts.Family)
	if vdwsOptions3Box2PopOut1.Text:GetText() == "Normal" then
		vdwsOptions3Box2PopOut2:Show()
		vdwsOptions3Box2PopOut3:Hide()
		vdwsOptions3Box2PopOut4:Hide()
	elseif vdwsOptions3Box2PopOut1.Text:GetText() == "Funky" then
		vdwsOptions3Box2PopOut2:Hide()
		vdwsOptions3Box2PopOut3:Show()
		vdwsOptions3Box2PopOut4:Hide()
	elseif vdwsOptions3Box2PopOut1.Text:GetText() == "Groovy" then
		vdwsOptions3Box2PopOut2:Hide()
		vdwsOptions3Box2PopOut3:Hide()
		vdwsOptions3Box2PopOut4:Show()
	end
	vdwsOptions3Box2PopOut2.Text:SetText(VDWSsettings.FPSframe.Fonts.Style)
	vdwsOptions3Box2PopOut3.Text:SetText(VDWSsettings.FPSframe.Fonts.Style)
	vdwsOptions3Box2PopOut4.Text:SetText(VDWSsettings.FPSframe.Fonts.Style)
	vdwsOptions3Box2PopOut5.Text:SetText(VDWSsettings.FPSframe.Fonts.Color)
	
	if VDWSsettings.MicroMenuContainer.Changed then
		vdwsOptions3Box3CheckButton1:SetChecked(true)
		vdwsOptions3Box3CheckButton1.Text:SetTextColor(C.Main:GetRGB())
	else
		vdwsOptions3Box3CheckButton1:SetChecked(false)
		vdwsOptions3Box3CheckButton1.Text:SetTextColor(0.35, 0.35, 0.35, 0.8)
	end
	
	if VDWSsettings.StatusBarText then
		vdwsOptions3Box3CheckButton2:SetChecked(true)
		vdwsOptions3Box3CheckButton2.Text:SetTextColor(C.Main:GetRGB())
	else
		vdwsOptions3Box3CheckButton2:SetChecked(false)
		vdwsOptions3Box3CheckButton2.Text:SetTextColor(0.35, 0.35, 0.35, 0.8)
	end
	
	if VDWSsettings.MapClock24 then
		vdwsOptions3Box3CheckButton3:SetChecked(true)
		vdwsOptions3Box3CheckButton3.Text:SetTextColor(C.Main:GetRGB())
	else
		vdwsOptions3Box3CheckButton3:SetChecked(false)
		vdwsOptions3Box3CheckButton3.Text:SetTextColor(0.35, 0.35, 0.35, 0.8)
	end
	
	if VDWSsettings.Chat.Changed then
		vdwsOptions3Box4CheckButton1:SetChecked(true)
		vdwsOptions3Box4CheckButton1.Text:SetTextColor(C.Main:GetRGB())
		popEnable(vdwsOptions3Box4PopOut1)
	else
		vdwsOptions3Box4CheckButton1:SetChecked(false)
		vdwsOptions3Box4CheckButton1.Text:SetTextColor(0.35, 0.35, 0.35, 0.8)
		popDisable(vdwsOptions3Box4PopOut1)
	end
	vdwsOptions3Box4PopOut1.Text:SetText(VDWSsettings.Chat.Background.Style)
end
-- Show the option panel --
vdwsOptions3:HookScript("OnShow", function(self)
	vdwsOptions0Tab1.Text:SetTextColor(0.4, 0.4, 0.4, 1)
	vdwsOptions0Tab2.Text:SetTextColor(0.4, 0.4, 0.4, 1)
	vdwsOptions0Tab4.Text:SetTextColor(0.4, 0.4, 0.4, 1)
	if vdwsOptions1:IsShown() then vdwsOptions1:Hide() end
	if vdwsOptions2:IsShown() then vdwsOptions2:Hide() end
	if vdwsOptions4:IsShown() then vdwsOptions4:Hide() end
	vdwsOptions0Tab3.Text:SetTextColor(C.High:GetRGB())
	CheckSavedVariables()
end)
