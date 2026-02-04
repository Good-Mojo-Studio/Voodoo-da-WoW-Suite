-- some variables --
local G = VDW.Local.Override
local L = VDW.VDWS.Local
local C = VDW.GetAddonColors("VDWS")
local prefixTip = VDW.Prefix("VDWS")
local prefixChat = VDW.PrefixChat("VDWS")
local NameExist = false
local maxW = 160
local finalW = 0
local  number = 0
local counterLoading = 0
local counterDeleting = 0
-- Taking care of the option panel --
vdwsOptions4:SetSize(576, 484)
vdwsOptions4:ClearAllPoints()
vdwsOptions4:SetPoint("TOPLEFT", vdwsOptions0, "TOPLEFT", 0, 0)
-- Background of the option panel --
vdwsOptions4.BGtexture:SetTexture("Interface\\ACHIEVEMENTFRAME\\UI-Achievement-Parchment-Horizontal-Desaturated.blp", "CLAMP", "CLAMP", "NEAREST")
vdwsOptions4.BGtexture:SetVertexColor(C.High:GetRGB())
vdwsOptions4.BGtexture:SetDesaturation(0.3)
-- Title of the option panel --
vdwsOptions4.Title:SetTextColor(C.Main:GetRGB())
vdwsOptions4.Title:SetText(prefixTip.."|nVersion: "..C.High:WrapTextInColorCode(C_AddOns.GetAddOnMetadata("VDWS", "Version")))
-- Top text of the option panel --
vdwsOptions4.TopTxt:SetTextColor(C.Main:GetRGB())
vdwsOptions4.TopTxt:SetText(L.P_TITLE)
-- Bottom right text of the option panel --
vdwsOptions4.BottomRightTxt:SetTextColor(C.Main:GetRGB())
vdwsOptions4.BottomRightTxt:SetText("May the Good "..C.High:WrapTextInColorCode("Mojo").." be with you!")
-- taking care of the boxes --
vdwsOptions4Box1.Title:SetText(L.P_SUB_CREATE)
vdwsOptions4Box2.Title:SetText(L.P_SUB_LOAD)
vdwsOptions4Box2:SetPoint("TOPLEFT", vdwsOptions4Box1, "BOTTOMLEFT", 0, 0)
vdwsOptions4Box3.Title:SetText(L.P_SUB_DELETE)
vdwsOptions4Box3:SetPoint("TOPLEFT", vdwsOptions4Box2, "BOTTOMLEFT", 0, 0)
vdwsOptions4Box4.Title:SetText("Important Notes")
vdwsOptions4Box4:SetPoint("TOPLEFT", vdwsOptions4Box3, "BOTTOMLEFT", 0, 0)
vdwsOptions4Box4.Notes:SetTextColor(C.Main:GetRGB())
vdwsOptions4Box4.Notes:SetWidth(vdwsOptions4Box4:GetWidth() - 8)
vdwsOptions4Box4.Notes:SetText("|A:"..C_AddOns.GetAddOnMetadata("VDWS", "IconAtlas")..":16:16|a"..C.High:WrapTextInColorCode("Note: ").."When you "..C.High:WrapTextInColorCode("CREATE")..", "..C.High:WrapTextInColorCode("LOAD")..", "..C.High:WrapTextInColorCode("DELETE").." a Profile, the UI will be RELOADED!")
-- Coloring the boxes --
for i = 1, 4, 1 do
	_G["vdwsOptions4Box"..i].Title:SetTextColor(C.Main:GetRGB())
	_G["vdwsOptions4Box"..i].BorderTop:SetVertexColor(C.High:GetRGB())
	_G["vdwsOptions4Box"..i].BorderBottom:SetVertexColor(C.High:GetRGB())
	_G["vdwsOptions4Box"..i].BorderLeft:SetVertexColor(C.High:GetRGB())
	_G["vdwsOptions4Box"..i].BorderRight:SetVertexColor(C.High:GetRGB())
end
-- Coloring the pop out buttons --
local function ColoringPopOutButtons(k, var1)
	_G["vdwsOptions4Box"..k.."PopOut"..var1].Text:SetTextColor(C.Main:GetRGB())
	_G["vdwsOptions4Box"..k.."PopOut"..var1].Title:SetTextColor(C.High:GetRGB())
	_G["vdwsOptions4Box"..k.."PopOut"..var1].NormalTexture:SetVertexColor(C.High:GetRGB())
	_G["vdwsOptions4Box"..k.."PopOut"..var1].HighlightTexture:SetVertexColor(C.Main:GetRGB())
	_G["vdwsOptions4Box"..k.."PopOut"..var1].PushedTexture:SetVertexColor(C.High:GetRGB())
end
-- taking care of the edit box --
-- colors --
vdwsOptions4Box1EditBox1["GlowTopLeft"]:SetVertexColor(C.Main:GetRGB())
vdwsOptions4Box1EditBox1["GlowTopRight"]:SetVertexColor(C.Main:GetRGB())
vdwsOptions4Box1EditBox1["GlowBottomLeft"]:SetVertexColor(C.Main:GetRGB())
vdwsOptions4Box1EditBox1["GlowBottomRight"]:SetVertexColor(C.Main:GetRGB())
vdwsOptions4Box1EditBox1["GlowTop"]:SetVertexColor(C.Main:GetRGB())
vdwsOptions4Box1EditBox1["GlowBottom"]:SetVertexColor(C.Main:GetRGB())
vdwsOptions4Box1EditBox1["GlowLeft"]:SetVertexColor(C.Main:GetRGB())
vdwsOptions4Box1EditBox1["GlowRight"]:SetVertexColor(C.Main:GetRGB())
-- width and height --
local fontFile, height, flags = vdwsOptions4Box1EditBox1.WritingLine:GetFont()
vdwsOptions4Box1EditBox1.WritingLine:SetHeight(height)
vdwsOptions4Box1EditBox1:SetWidth(vdwsOptions4Box1:GetWidth()*0.65)
vdwsOptions4Box1EditBox1:SetHeight(vdwsOptions4Box1EditBox1.WritingLine:GetHeight()*1.75)
vdwsOptions4Box1EditBox1.WritingLine:SetWidth(vdwsOptions4Box1EditBox1:GetWidth()*0.95)
-- enter --
vdwsOptions4Box1EditBox1:HookScript("OnEnter", function(self)
	VDW.Tooltip_Show(self, prefixTip, L.P_TIP_CREATE, C.Main)
end)
-- leave --
vdwsOptions4Box1EditBox1:HookScript("OnLeave", function(self) VDW.Tooltip_Hide() end)
-- pressing enter --
vdwsOptions4Box1EditBox1.WritingLine:SetScript("OnEnterPressed", function(self)
	if self:HasText() then
		EditBox_HighlightText(self)
		local name = self:GetText()
		for k, v in pairs(VDWSprofiles) do
			if k == name then
				NameExist = true
			else
				NameExist = false
			end
			if NameExist then
				DEFAULT_CHAT_FRAME:AddMessage(C.Main:WrapTextInColorCode(prefixChat.." "..L.P_WRN_EXIST))
				return
			end
		end
		number = number + 1
		VDWSprofiles[name] = {settings = VDWSsettings, localization = VDWSspecialSettings.LastLocation}
		C_UI.Reload()
	else
		DEFAULT_CHAT_FRAME:AddMessage(C.Main:WrapTextInColorCode(prefixChat.." "..L.P_WRN_NEED))
	end
end)
-- Pop out 1 Buttons loading profiles  --
ColoringPopOutButtons(2, 1)
-- enter --
vdwsOptions4Box2PopOut1:HookScript("OnEnter", function(self)
	VDW.Tooltip_Show(self, prefixTip, L.P_TIP_LOAD, C.Main)
end)
-- leave --
vdwsOptions4Box2PopOut1:HookScript("OnLeave", function(self) VDW.Tooltip_Hide() end)
-- click --
vdwsOptions4Box2PopOut1:HookScript("OnClick", function(self, button, down)
	if button == "LeftButton" and down == false then
		if vdwsOptions4Box2PopOut1Choice1 ~= nil then
			if not vdwsOptions4Box2PopOut1Choice1:IsShown() then
				vdwsOptions4Box2PopOut1Choice1:Show()
			else
				vdwsOptions4Box2PopOut1Choice1:Hide()
			end
		else
			DEFAULT_CHAT_FRAME:AddMessage(C.Main:WrapTextInColorCode(prefixChat.." "..L.P_WRN_LOAD))
		end
	end
end)
-- Pop out 1 Buttons deleting profiles  --
ColoringPopOutButtons(3, 1)
-- enter --
vdwsOptions4Box3PopOut1:HookScript("OnEnter", function(self)
	VDW.Tooltip_Show(self, prefixTip, L.P_TIP_DELETE, C.Main)
end)
-- leave --
vdwsOptions4Box3PopOut1:HookScript("OnLeave", function(self) VDW.Tooltip_Hide() end)
-- click --
vdwsOptions4Box3PopOut1:HookScript("OnClick", function(self, button, down)
	if button == "LeftButton" and down == false then
		if vdwsOptions4Box3PopOut1Choice1 ~= nil then
			if not vdwsOptions4Box3PopOut1Choice1:IsShown() then
				vdwsOptions4Box3PopOut1Choice1:Show()
			else
				vdwsOptions4Box3PopOut1Choice1:Hide()
			end
		else
			DEFAULT_CHAT_FRAME:AddMessage(C.Main:WrapTextInColorCode(prefixChat.." "..L.P_WRN_DELETE))
		end
	end
end)
-- finding keys --
local function FindingKeys()
	local Keys = 0
	for k, v in pairs(VDWSprofiles) do
		Keys = Keys + 1
	end
	number = Keys
end
-- functions for loading the profiles --
local function LoadingProfiles() -- vdwLoadingProfiles(asv1, asv2, asv3, txt1) 
	if counterLoading == 0 and number > 0 then
		for k, v in pairs(VDWSprofiles) do
			counterLoading = counterLoading + 1
			local btn = CreateFrame("Button", "vdwsOptions4Box2PopOut1Choice"..counterLoading, nil, "vdwPopOutButton")
			_G["vdwsOptions4Box2PopOut1Choice"..counterLoading]:ClearAllPoints()
			if counterLoading == 1 then
				_G["vdwsOptions4Box2PopOut1Choice"..counterLoading]:SetParent(vdwsOptions4Box2PopOut1)
				_G["vdwsOptions4Box2PopOut1Choice"..counterLoading]:SetPoint("TOP", vdwsOptions4Box2PopOut1, "BOTTOM", 0, 4)
				_G["vdwsOptions4Box2PopOut1Choice"..counterLoading]:SetScript("OnShow", function(self)
					self:GetParent():SetNormalAtlas("charactercreate-customize-dropdownbox-hover")
					PlaySound(855, "Master")
				end)
				_G["vdwsOptions4Box2PopOut1Choice"..counterLoading]:SetScript("OnHide", function(self)
					self:GetParent():SetNormalAtlas("charactercreate-customize-dropdownbox-open")
					PlaySound(855, "Master")
				end)
			else
				_G["vdwsOptions4Box2PopOut1Choice"..counterLoading]:SetParent(vdwsOptions4Box2PopOut1Choice1)
				_G["vdwsOptions4Box2PopOut1Choice"..counterLoading]:SetPoint("TOP", _G["vdwsOptions4Box2PopOut1Choice"..counterLoading-1], "BOTTOM", 0, 0)
				_G["vdwsOptions4Box2PopOut1Choice"..counterLoading]:Show()
			end
				_G["vdwsOptions4Box2PopOut1Choice"..counterLoading].Text:SetText(k)
				_G["vdwsOptions4Box2PopOut1Choice"..counterLoading]:SetWidth(_G["vdwsOptions4Box2PopOut1Choice"..counterLoading].Text:GetWidth())
			_G["vdwsOptions4Box2PopOut1Choice"..counterLoading]:HookScript("OnClick", function(self, button, down)
				if button == "LeftButton" and down == false then
					VDWSsettings = VDWSprofiles[k]["settings"]
					VDWSspecialSettings.LastLocation = VDWSprofiles[k]["localization"]
					C_UI.Reload()
				end
			end)
		local w = _G["vdwsOptions4Box2PopOut1Choice"..counterLoading].Text:GetStringWidth()
			if w > maxW then maxW = w end
		end
		finalW = math.ceil(maxW + 24)
		for i = 1, counterLoading do
			_G["vdwsOptions4Box2PopOut1Choice"..i]:SetWidth(finalW)
		end
	end
end
-- functions for deleting the profiles --
local function DeletingProfiles()
	if counterDeleting == 0 and number > 0 then
		for k, v in pairs(VDWSprofiles) do
			counterDeleting = counterDeleting + 1
			local btn = CreateFrame("Button", "vdwsOptions4Box3PopOut1Choice"..counterDeleting, nil, "vdwPopOutButton")
			_G["vdwsOptions4Box3PopOut1Choice"..counterDeleting]:ClearAllPoints()
			if counterDeleting == 1 then
				_G["vdwsOptions4Box3PopOut1Choice"..counterDeleting]:SetParent(vdwsOptions4Box3PopOut1)
				_G["vdwsOptions4Box3PopOut1Choice"..counterDeleting]:SetPoint("TOP", vdwsOptions4Box3PopOut1, "BOTTOM", 0, 4)
				_G["vdwsOptions4Box3PopOut1Choice"..counterDeleting]:SetScript("OnShow", function(self)
					self:GetParent():SetNormalAtlas("charactercreate-customize-dropdownbox-hover")
					PlaySound(855, "Master")
				end)
				_G["vdwsOptions4Box3PopOut1Choice"..counterDeleting]:SetScript("OnHide", function(self)
					self:GetParent():SetNormalAtlas("charactercreate-customize-dropdownbox-open")
					PlaySound(855, "Master")
				end)
			else
				_G["vdwsOptions4Box3PopOut1Choice"..counterDeleting]:SetParent(vdwsOptions4Box3PopOut1Choice1)
				_G["vdwsOptions4Box3PopOut1Choice"..counterDeleting]:SetPoint("TOP", _G["vdwsOptions4Box3PopOut1Choice"..counterDeleting-1], "BOTTOM", 0, 0)
				_G["vdwsOptions4Box3PopOut1Choice"..counterDeleting]:Show()
			end
				_G["vdwsOptions4Box3PopOut1Choice"..counterDeleting].Text:SetText(k)
				_G["vdwsOptions4Box3PopOut1Choice"..counterDeleting]:SetWidth(_G["vdwsOptions4Box3PopOut1Choice"..counterDeleting].Text:GetWidth())
			_G["vdwsOptions4Box3PopOut1Choice"..counterDeleting]:HookScript("OnClick", function(self, button, down)
				if button == "LeftButton" and down == false then
					VDWSprofiles[k] = nil
					C_UI.Reload()
				end
			end)
		local w = _G["vdwsOptions4Box3PopOut1Choice"..counterDeleting].Text:GetStringWidth()
			if w > maxW then maxW = w end
		end
		finalW = math.ceil(maxW + 24)
		for i = 1, counterDeleting do
			_G["vdwsOptions4Box3PopOut1Choice"..i]:SetWidth(finalW)
		end
	end
end
vdwsOptions4Box2PopOut1.Text:SetText(G.BUTTON_L_CLICK)
vdwsOptions4Box3PopOut1.Text:SetText(G.BUTTON_L_CLICK)
FindingKeys()
LoadingProfiles()
DeletingProfiles()
-- Show the option panel --
vdwsOptions4:HookScript("OnShow", function(self)
	vdwsOptions0Tab1.Text:SetTextColor(0.4, 0.4, 0.4, 1)
	vdwsOptions0Tab2.Text:SetTextColor(0.4, 0.4, 0.4, 1)
	vdwsOptions0Tab3.Text:SetTextColor(0.4, 0.4, 0.4, 1)
	if vdwsOptions1:IsShown() then vdwsOptions1:Hide() end
	if vdwsOptions2:IsShown() then vdwsOptions2:Hide() end
	if vdwsOptions3:IsShown() then vdwsOptions3:Hide() end
	vdwsOptions0Tab4.Text:SetTextColor(C.High:GetRGB())
end)
