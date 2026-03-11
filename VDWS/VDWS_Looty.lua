local G = VDW.Local.Override
local C = VDW.GetAddonColors("VDWS")
local frameInput = false
local tempValue = 0
local icon  = C_AddOns.GetAddOnMetadata("VDWS", "IconAtlas")
local vTime = 0
local function prefixChat()
	local t = GameTime_GetTime(false)
	local icon  = C_AddOns.GetAddOnMetadata("VDWS", "IconAtlas")
	local p = (" ["..t.."]|A:%s:16:16:0:0|a"):format(icon)
	return p
end
-- title --
vdwsLooty.Title:SetText("|A:"..icon..":16:16:0:0|aLooty Groove|A:"..icon..":16:16:0:0|a")
-- protect the options --
local function ProtectOptions()
	local loc = GetLocale()
	if loc ~= VDWSsettings.LastLocation then
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
	for i = 12, 20, 1 do
		if VDWSsettings.Looty.Fonts.Style == "Normal "..i then
			vdwsLooty:SetFontObject(_G["vdw_NFshadow_"..i])
		elseif VDWSsettings.Looty.Fonts.Style == "Funky "..i then
			vdwsLooty:SetFontObject(_G["vdw_FFshadow_"..i])
		elseif VDWSsettings.Looty.Fonts.Style == "Groovy "..i then
			vdwsLooty:SetFontObject(_G["vdw_GFshadow_"..i])
		end
	end
	vdwsLooty:SetTextColor(C.Main:GetRGB())
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
	elseif VDWSsettings.Looty.Background.Style == "Kladia" then
		vdwsLooty.BGtexture1:SetAtlas("housing-wood-frame")
		vdwsLooty.BGtexture2:SetAtlas("BfAMission-Icon-Treasure")
		local w = vdwsLooty:GetHeight() * 0.65
		local h = vdwsLooty:GetHeight() * 0.65
		vdwsLooty.BGtexture2:SetSize(w, h)
		if VDWSsettings.Looty.Background.Color == G.OPTIONS_C_DEFAULT then
			vdwsLooty.BGtexture1:SetDesaturation(0.35)
			vdwsLooty.BGtexture1:SetVertexColor(1, 1, 1, 1)
			vdwsLooty.BGtexture2:SetDesaturation(0.35)
			vdwsLooty.BGtexture2:SetVertexColor(1, 1, 1, 1)
		elseif VDWSsettings.Looty.Background.Color == G.OPTIONS_C_CLASS then
			vdwsLooty.BGtexture1:SetDesaturation(0.75)
			vdwsLooty.BGtexture1:SetVertexColor(VDW.PlayerClassColor:GetRGB())
			vdwsLooty.BGtexture2:SetDesaturation(0.75)
			vdwsLooty.BGtexture2:SetVertexColor(VDW.PlayerClassColor:GetRGB())
		elseif VDWSsettings.Looty.Background.Color == G.OPTIONS_C_FACTION then
			vdwsLooty.BGtexture1:SetDesaturation(0)
			vdwsLooty.BGtexture1:SetVertexColor(VDW.PlayerFactionColor:GetRGB())
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
-- Scroll bar value step
vdwsLooty.Box.ScrollBar.Slider:SetValueStep(1)
-- scroll bar on value changed
vdwsLooty.Box.ScrollBar.Slider:SetScript("OnValueChanged", function (self, value, userInput)
	if not frameInput then
		vdwsLooty:ScrollByAmount(tempValue - self:GetValue())
		tempValue = self:GetValue()
	else
		frameInput = false
	end
end)
-- hyperlink function
local function hyperLink(link, text, button, self)
	if not InCombatLockdown() then
		SetItemRef(link, text, button, self)
	else
		C_Sound.PlayVocalErrorSound(48)
		DEFAULT_CHAT_FRAME:AddMessage(C.Main:WrapTextInColorCode(prefixChat().." "..G.WRN_COMBAT_LOCKDOWN))
		UIErrorsFrame:AddExternalWarningMessage(G.WRN_COMBAT_LOCKDOWN)
	end
end
-- Taking care of the Looty frame
vdwsLooty:SetScript("OnMouseWheel", function(self, delta) Scrolling(self, delta) end)
vdwsLooty:HookScript("OnHyperlinkClick", function(self, link, text, button) hyperLink(link, text, button, self) end)
-- after message
local function afterMessage(self)
	if self:GetNumMessages() >= 2 then
		self.Box.ScrollBar.Slider:SetMinMaxValues(1, self:GetNumMessages())
		self.Box.ScrollBar.Slider:SetValue(self:GetNumMessages())
		tempValue = self.Box.ScrollBar.Slider:GetValue()
		if not self.Box:IsShown() then self.Box:Show() end
	end
end
-- events time
local function EventsTime1(self, event, arg1, arg2, arg3, arg4)
	if event == "PLAYER_LOGIN" then
		ProtectOptions()
		VDW.VDWS.LootyChk()
		VDWSsettings["LastLocation"] = GetLocale()
	end
end
vdwsZlave:HookScript("OnEvent", EventsTime1)
-- events time --
local function EventsTime2(self, event, arg1, arg2, arg3, arg4)
	if event == "CHAT_MSG_MONEY" then
		if VDWSsettings.Looty.Coins then
			self:AddMessage(prefixChat()..GOLD_FONT_COLOR:WrapTextInColorCode(arg1))
			afterMessage(self)
		end
	elseif event == "CHAT_MSG_LOOT" then
		if VDWSsettings.Looty.Loot then
			self:AddMessage(prefixChat()..LOOT_LINK_COLOR:WrapTextInColorCode(arg1))
			afterMessage(self)
		end
	elseif event == "CHAT_MSG_CURRENCY" then
		if VDWSsettings.Looty.Currencies then
			self:AddMessage(prefixChat()..FACTION_ORANGE_COLOR:WrapTextInColorCode(arg1))
			afterMessage(self)
		end
	elseif event == "CHAT_MSG_COMBAT_XP_GAIN" then
		if VDWSsettings.Looty.XP then
			self:AddMessage(prefixChat()..EPIC_PURPLE_COLOR:WrapTextInColorCode(arg1))
			afterMessage(self)
		end
	elseif event == "CHAT_MSG_COMBAT_HONOR_GAIN" or event == "CHAT_COMBAT_MSG_ARENA_POINTS_GAIN" then
		if VDWSsettings.Looty.Honor then
			self:AddMessage(prefixChat()..BATTLE_TAG_FONT_COLOR:WrapTextInColorCode(arg1))
			afterMessage(self)
		end
	elseif event == "CHAT_MSG_COMBAT_FACTION_CHANGE" then
		if VDWSsettings.Looty.Reputation then
			self:AddMessage(prefixChat()..STARS_MAJOR_FACTION_COLOR:WrapTextInColorCode(arg1))
			afterMessage(self)
		end
	elseif event == "CHAT_MSG_TRADESKILLS" or event == "CHAT_MSG_SKILL" then
		if VDWSsettings.Looty.Skill then
			self:AddMessage(prefixChat()..TRADESKILL_EXPERIENCE_COLOR:WrapTextInColorCode(arg1))
			afterMessage(self)
		end
	elseif event == "CHAT_MSG_COMBAT_MISC_INFO" or event == "CHAT_MSG_OPENING" then
		if VDWSsettings.Looty.Miscellaneous then
			self:AddMessage(prefixChat()..DULL_RED_FONT_COLOR:WrapTextInColorCode(arg1))
			afterMessage(self)
		end
	end
end
vdwsLooty:SetScript("OnEvent", EventsTime2)
