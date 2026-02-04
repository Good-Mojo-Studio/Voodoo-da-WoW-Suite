local G = VDW.Local.Override
-- protect the options --
local function ProtectOptions()
	local loc = GetLocale()
	if loc ~= VDWSspecialSettings.LastLocation then
		for k, v in pairs(VDW.Local.Translate) do
			for i, s in pairs (v) do
				if VDWSsettings.FourEdges.Color == s then
					VDWSsettings.FourEdges.Color = VDW.Local.Translate[loc][i]
				end
			end
		end
	end
end
-- checking function --
function VDW.VDWS.FourEdgesChk()
-- style --
	if VDWSsettings.FourEdges.Style == "Izes" or VDWSsettings.FourEdges.Style == "Filigree"then
		for i = 1, 4, 1 do
			_G["vdwsFourEdges"..i]:ClearAllPoints()
			if i == 1 then
				_G["vdwsFourEdges"..i]:SetPoint("TOPLEFT", UIParent, "TOPLEFT", -16, 24)
				_G["vdwsFourEdges"..i].Background:SetTexCoord(0, 1, 0, 1)
			elseif i == 2 then
				_G["vdwsFourEdges"..i]:SetPoint("BOTTOMLEFT", UIParent, "BOTTOMLEFT", -16, -24)
				_G["vdwsFourEdges"..i].Background:SetTexCoord(0, 1, 1, 0)
			elseif i == 3 then
				_G["vdwsFourEdges"..i]:SetPoint("TOPRIGHT", UIParent, "TOPRIGHT", 16, 24)
				_G["vdwsFourEdges"..i].Background:SetTexCoord(1, 0, 0, 1)
			elseif i == 4 then
				_G["vdwsFourEdges"..i]:SetPoint("BOTTOMRIGHT", UIParent, "BOTTOMRIGHT", 16, -24)
				_G["vdwsFourEdges"..i].Background:SetTexCoord(1, 0, 1, 0)
			end
			_G["vdwsFourEdges"..i].Background:SetAtlas("parchmentpopup-filigree", false)
		end
	elseif VDWSsettings.FourEdges.Style == "Kedima" or VDWSsettings.FourEdges.Style == "CoolCorner" then
		for i = 1, 4, 1 do
			_G["vdwsFourEdges"..i]:ClearAllPoints()
			if i == 1 then
				_G["vdwsFourEdges"..i]:SetPoint("TOPLEFT", UIParent, "TOPLEFT", 0, 0)
				_G["vdwsFourEdges"..i].Background:SetTexCoord(0, 1, 0, 1)
			elseif i == 2 then
				_G["vdwsFourEdges"..i]:SetPoint("BOTTOMLEFT", UIParent, "BOTTOMLEFT", 0, 0)
				_G["vdwsFourEdges"..i].Background:SetTexCoord(0, 1, 1, 0)
			elseif i == 3 then
				_G["vdwsFourEdges"..i]:SetPoint("TOPRIGHT", UIParent, "TOPRIGHT", 0, 0)
				_G["vdwsFourEdges"..i].Background:SetTexCoord(1, 0, 0, 1)
			elseif i == 4 then
				_G["vdwsFourEdges"..i]:SetPoint("BOTTOMRIGHT", UIParent, "BOTTOMRIGHT", 0, 0)
				_G["vdwsFourEdges"..i].Background:SetTexCoord(1, 0, 1, 0)
			end
			_G["vdwsFourEdges"..i].Background:SetAtlas("collections-background-corner", false)
		end
	elseif VDWSsettings.FourEdges.Style == "Kuriza" then
		for i = 1, 4, 1 do
			_G["vdwsFourEdges"..i]:ClearAllPoints()
			if i == 1 then
				_G["vdwsFourEdges"..i]:SetPoint("TOPLEFT", UIParent, "TOPLEFT", 0, 0)
				_G["vdwsFourEdges"..i].Background:SetTexCoord(0, 1, 0, 1)
			elseif i == 2 then
				_G["vdwsFourEdges"..i]:SetPoint("BOTTOMLEFT", UIParent, "BOTTOMLEFT", 0, 0)
				_G["vdwsFourEdges"..i].Background:SetTexCoord(0, 1, 1, 0)
			elseif i == 3 then
				_G["vdwsFourEdges"..i]:SetPoint("TOPRIGHT", UIParent, "TOPRIGHT", 0, 0)
				_G["vdwsFourEdges"..i].Background:SetTexCoord(1, 0, 0, 1)
			elseif i == 4 then
				_G["vdwsFourEdges"..i]:SetPoint("BOTTOMRIGHT", UIParent, "BOTTOMRIGHT", 0, 0)
				_G["vdwsFourEdges"..i].Background:SetTexCoord(1, 0, 1, 0)
			end
			_G["vdwsFourEdges"..i].Background:SetAtlas("Garr_InfoBoxBorder-FiligreeCorner", false)
		end
	elseif VDWSsettings.FourEdges.Style == "Kladia" then
		for i = 1, 4, 1 do
			_G["vdwsFourEdges"..i]:ClearAllPoints()
			if i == 1 then
				_G["vdwsFourEdges"..i]:SetPoint("TOPLEFT", UIParent, "TOPLEFT", -8, 8)
				_G["vdwsFourEdges"..i].Background:SetTexCoord(1, 0, 1, 0)
			elseif i == 2 then
				_G["vdwsFourEdges"..i]:SetPoint("BOTTOMLEFT", UIParent, "BOTTOMLEFT", -8, -8)
				_G["vdwsFourEdges"..i].Background:SetTexCoord(1, 0, 0, 1)
			elseif i == 3 then
				_G["vdwsFourEdges"..i]:SetPoint("TOPRIGHT", UIParent, "TOPRIGHT", 8, 8)
				_G["vdwsFourEdges"..i].Background:SetTexCoord(0, 1, 1, 0)
			elseif i == 4 then
				_G["vdwsFourEdges"..i]:SetPoint("BOTTOMRIGHT", UIParent, "BOTTOMRIGHT", 8, -8)
				_G["vdwsFourEdges"..i].Background:SetTexCoord(0, 1, 0, 1)
			end
			_G["vdwsFourEdges"..i].Background:SetAtlas("decor-abilitybar-bookend-left", false)
		end
	end
-- color --
	if VDWSsettings.FourEdges.Color == G.OPTIONS_C_DEFAULT then
		for i = 1, 4, 1 do
			_G["vdwsFourEdges"..i].Background:SetDesaturation(0)
			_G["vdwsFourEdges"..i].Background:SetVertexColor(1, 1, 1, 1)
		end
	elseif VDWSsettings.FourEdges.Color == G.OPTIONS_C_CLASS then
		for i = 1, 4, 1 do
			_G["vdwsFourEdges"..i].Background:SetDesaturation(1)
			_G["vdwsFourEdges"..i].Background:SetVertexColor(VDW.PlayerClassColor:GetRGB())
		end
	elseif VDWSsettings.FourEdges.Color == G.OPTIONS_C_FACTION then
		for i = 1, 4, 1 do
			_G["vdwsFourEdges"..i].Background:SetDesaturation(1)
			_G["vdwsFourEdges"..i].Background:SetVertexColor(VDW.PlayerFactionColor:GetRGB())
		end
	end
-- size & opacity --
	for i = 1, 4, 1 do
		_G["vdwsFourEdges"..i]:SetSize(VDWSsettings.FourEdges.Size.W, VDWSsettings.FourEdges.Size.H)
		_G["vdwsFourEdges"..i]:SetAlpha(VDWSsettings.FourEdges.Alpha)
	end
-- visibility --
	if VDWSsettings.FourEdges.vdwsFourEdges1 then
		vdwsFourEdges1:Show()
	else
		vdwsFourEdges1:Hide()
	end
	if VDWSsettings.FourEdges.vdwsFourEdges2 then
		vdwsFourEdges2:Show()
	else
		vdwsFourEdges2:Hide()
	end
	if VDWSsettings.FourEdges.vdwsFourEdges3 then
		vdwsFourEdges3:Show()
	else
		vdwsFourEdges3:Hide()
	end
	if VDWSsettings.FourEdges.vdwsFourEdges4 then
		vdwsFourEdges4:Show()
	else
		vdwsFourEdges4:Hide()
	end
end
-- events time --
local function EventsTime(self, event, arg1, arg2, arg3, arg4)
	if event == "PLAYER_LOGIN" then
		ProtectOptions()
		VDW.VDWS.FourEdgesChk()
	end
end
vdwsZlave:HookScript("OnEvent", EventsTime)
