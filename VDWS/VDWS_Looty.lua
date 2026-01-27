local G = VDW.Local.Override
local C = VDW.GetAddonColors("VDWS")
local prefixChat = VDW.PrefixChat("VDWS")
local frameInput = false
local tempValue = 0
local icon  = C_AddOns.GetAddOnMetadata("VDWS", "IconAtlas")
-- title --
vdwsLooty.Title:SetText("|A:"..icon..":16:16:0:0|aLooty Groove|A:"..icon..":16:16:0:0|a")
-- protect the options --
local function ProtectOptions()
	local loc = GetLocale()
	if loc ~= VDWSspecialSettings.LastLocation then
		for k, v in pairs(VDW.Local.Translate) do
			for i, s in pairs (v) do
				if VDWSsettings.Looty.Fonts.Color == s then
					VDWSsettings.Looty.Fonts.Color = VDW.Local.Translate[loc][i]
				end
				if VDWSsettings.Looty.Background.Style == s then
					VDWSsettings.Looty.Background.Style = VDW.Local.Translate[loc][i]
				end
				if VDWSsettings.Looty.Background.Color == s then
					VDWSsettings.Looty.Background.Color = VDW.Local.Translate[loc][i]
				end
			end
		end
	end
end
-- check --
function VDW.VDWS.LootyChk()
-- main --
	vdwsLooty:ClearAllPoints()
	vdwsLooty:SetPoint("BOTTOMLEFT", UIParent, "BOTTOMLEFT", VDWSsettings.Looty.Position.X, VDWSsettings.Looty.Position.Y)
	vdwsLooty:SetSize(VDWSsettings.Looty.Size.W, VDWSsettings.Looty.Size.H)
	vdwsLooty:SetTimeVisible(VDWSsettings.Looty.Duration)
-- fonts --
	for i = 9, 17, 1 do
		if VDWSsettings.Looty.Fonts.Style == "Normal "..i then
			if i == 13 then
				vdwsLooty:SetFontObject(_G["vdw_NFshadow_"..i])
			else
				vdwsLooty:SetFontObject(_G["vdws_NFshadow_"..i])
			end
		elseif VDWSsettings.Looty.Fonts.Style == "Funky "..i then
			if i == 15 then
				vdwsLooty:SetFontObject(_G["vdw_FFshadow_"..i])
			else
				vdwsLooty:SetFontObject(_G["vdws_FFshadow_"..i])
			end
		elseif VDWSsettings.Looty.Fonts.Style == "Groovy "..i then
			vdwsLooty:SetFontObject(_G["vdws_GFshadow_"..i])
		end
	end
	if VDWSsettings.Looty.Fonts.Color == G.OPTIONS_C_DEFAULT then
		vdwsLooty:SetTextColor(C.Main:GetRGB())
	elseif VDWSsettings.Looty.Fonts.Color == G.OPTIONS_C_CLASS then
		vdwsLooty:SetTextColor(VDW.PlayerClassColor:GetRGB())
	elseif VDWSsettings.Looty.Fonts.Color == G.OPTIONS_C_FACTION then
		vdwsLooty:SetTextColor(VDW.PlayerFactionColor:GetRGB())
	end
-- background --
	if VDWSsettings.Looty.Background.Style == G.OPTIONS_C_DEFAULT then
		vdwsLooty.BGtexture1:SetAtlas("Artifacts-BG-Shadow")
		vdwsLooty.BGtexture2:SetAtlas("BfAMission-Icon-Treasure")
		local w = vdwsLooty:GetHeight() * 0.65
		local h = vdwsLooty:GetHeight() * 0.65
		vdwsLooty.BGtexture2:SetSize(w, h)
		if VDWSsettings.Looty.Background.Color == G.OPTIONS_C_DEFAULT then
			vdwsLooty.BGtexture2:SetDesaturation(0.35)
			vdwsLooty.BGtexture2:SetVertexColor(1, 1, 1, 1)
		elseif VDWSsettings.Looty.Background.Color == G.OPTIONS_C_CLASS then
			vdwsLooty.BGtexture2:SetDesaturation(0.75)
			vdwsLooty.BGtexture2:SetVertexColor(VDW.PlayerClassColor:GetRGB())
		elseif VDWSsettings.Looty.Background.Color == G.OPTIONS_C_FACTION then
			vdwsLooty.BGtexture2:SetDesaturation(0)
			vdwsLooty.BGtexture2:SetVertexColor(VDW.PlayerFactionColor:GetRGB())
		end
	end
	vdwsLooty.BGtexture1:SetAlpha(VDWSsettings.Looty.Background.Alpha)
	vdwsLooty.BGtexture2:SetAlpha(VDWSsettings.Looty.Background.Alpha*0.75)
-- title --
	vdwsLooty.Title:SetAlpha(VDWSsettings.Looty.Background.Alpha)
	if VDWSsettings.Looty.Title then
		vdwsLooty.Title:Show()
	else
		vdwsLooty.Title:Hide()
	end
-- main --
	if VDWSsettings.Looty.Visible then
		vdwsLooty:Show()
	else
		vdwsLooty:Hide()
	end
end
-- Scrolling Functions --
local function Scrolling(self, delta)
	if delta == -1 and IsShiftKeyDown() then
		self:ScrollByAmount(-8)
		frameInput = true
		self.Box.ScrollBar.Slider:SetValue(self.Box.ScrollBar.Slider:GetValue() + 8)
	elseif delta == -1 and not IsShiftKeyDown() then
		self:ScrollByAmount(-1)
		frameInput = true
		self.Box.ScrollBar.Slider:SetValue(self.Box.ScrollBar.Slider:GetValue() + 1)
	elseif delta == 1 and IsShiftKeyDown() then
		self:ScrollByAmount(8)
		frameInput = true
		self.Box.ScrollBar.Slider:SetValue(self.Box.ScrollBar.Slider:GetValue() - 8)
	elseif delta == 1 and not IsShiftKeyDown() then
		self:ScrollByAmount(1)
		frameInput = true
		self.Box.ScrollBar.Slider:SetValue(self.Box.ScrollBar.Slider:GetValue() - 1)
	end
end
-- Scroll bar value step --
vdwsLooty.Box.ScrollBar.Slider:SetValueStep(1)
-- scroll bar on value changed --
vdwsLooty.Box.ScrollBar.Slider:SetScript("OnValueChanged", function (self, value, userInput)
	if not frameInput then
		vdwsLooty:ScrollByAmount(tempValue - self:GetValue())
		tempValue = self:GetValue()
	else
		frameInput = false
	end
end)
-- hyperlink function --
local function hyperLink(link, text, button, self)
	if not InCombatLockdown() then
		SetItemRef(link, text, button, self)
	else
		C_Sound.PlayVocalErrorSound(48)
		DEFAULT_CHAT_FRAME:AddMessage(C.Main:WrapTextInColorCode(prefixChat.." "..G.WRN_COMBAT_LOCKDOWN))
		UIErrorsFrame:AddExternalWarningMessage(G.WRN_COMBAT_LOCKDOWN)
	end
end
-- Taking care of the SSoA frame --
vdwsLooty:SetScript("OnMouseWheel", function(self, delta) Scrolling(self, delta) end)
vdwsLooty:HookScript("OnHyperlinkClick", function(self, link, text, button) hyperLink(link, text, button, self) end)
-- pre message function --
local function preMessageFunction()
	local t = GameTime_GetTime(false)
	local p = ("["..t.."]|A:%s:16:16:0:0|a"):format(icon)
	return p
end
local preMessage = preMessageFunction()
-- after message --
local function afterMessage(self)
	if self:GetNumMessages() >= 2 then
		self.Box.ScrollBar.Slider:SetMinMaxValues(1, self:GetNumMessages())
		self.Box.ScrollBar.Slider:SetValue(self:GetNumMessages())
		tempValue = self.Box.ScrollBar.Slider:GetValue()
		if not self.Box:IsShown() then self.Box:Show() end
	end
end
-- events time --
local function EventsTime1(self, event, arg1, arg2, arg3, arg4)
	if event == "PLAYER_LOGIN" then
		ProtectOptions()
		VDW.VDWS.LootyChk()
		VDWSspecialSettings["LastLocation"] = GetLocale()
	end
end
vdwsZlave:HookScript("OnEvent", EventsTime1)
-- events time --
local function EventsTime2(self, event, arg1, arg2, arg3, arg4)
	if event == "CHAT_MSG_MONEY" then
		if VDWSsettings.Looty.Coins then
			self:AddMessage(" "..preMessage..arg1)
			afterMessage(self)
		end
	elseif event == "CHAT_MSG_LOOT" then
		if VDWSsettings.Looty.Loot then
			self:AddMessage(" "..preMessage..arg1)
			afterMessage(self)
		end
	elseif event == "CHAT_MSG_CURRENCY" then
		if VDWSsettings.Looty.Currencies then
			self:AddMessage(" "..preMessage..arg1)
			afterMessage(self)
		end
	elseif event == "CHAT_MSG_COMBAT_XP_GAIN" then
		if VDWSsettings.Looty.XP then
			self:AddMessage(" "..preMessage..arg1)
			afterMessage(self)
		end
	elseif event == "CHAT_MSG_COMBAT_HONOR_GAIN" or event == "CHAT_COMBAT_MSG_ARENA_POINTS_GAIN" then
		if VDWSsettings.Looty.Honor then
			self:AddMessage(" "..preMessage..arg1)
			afterMessage(self)
		end
	elseif event == "CHAT_MSG_COMBAT_FACTION_CHANGE" then
		if VDWSsettings.Looty.Reputation then
			self:AddMessage(" "..preMessage..arg1)
			afterMessage(self)
		end
	elseif event == "CHAT_MSG_TRADESKILLS" or event == "CHAT_MSG_SKILL" then
		if VDWSsettings.Looty.Skill then
			self:AddMessage(" "..preMessage..arg1)
			afterMessage(self)
		end
	elseif event == "CHAT_MSG_COMBAT_MISC_INFO" or event == "CHAT_MSG_OPENING" then
		if VDWSsettings.Looty.Miscellaneous then
			self:AddMessage(" "..preMessage..arg1)
			afterMessage(self)
		end
	end
end
vdwsLooty:SetScript("OnEvent", EventsTime2)
