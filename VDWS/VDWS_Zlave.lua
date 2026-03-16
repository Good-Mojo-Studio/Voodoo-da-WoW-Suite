-- some variables --
VDW.VDWS = VDW.VDWS or {}
local G = VDW.Local.Override
local C = VDW.GetAddonColors("VDWS")
local prefixTip = VDW.Prefix("VDWS")
local prefixChat = VDW.PrefixChat("VDWS")
local function CreateGlobalVariables()
-- function for opening the options --
	local function ShowMenu()
		if not InCombatLockdown() then
			local _, loaded = C_AddOns.IsAddOnLoaded("VDWS_Options")
			local loadable, reason = C_AddOns.IsAddOnLoadable("VDWS_Options" , nil , true)
			if reason == "MISSING" then
				C_Sound.PlayVocalErrorSound(48)
				DEFAULT_CHAT_FRAME:AddMessage(C.Main:WrapTextInColorCode(prefixChat.." "..string.format(G.WRN_ADDON_IS_STATE, C.High:WrapTextInColorCode("Voodoo da Wow Suite Options"), reason)))
				UIErrorsFrame:AddExternalWarningMessage(string.format(G.WRN_ADDON_IS_STATE, C.High:WrapTextInColorCode("Voodoo da Wow Suite Options"), reason))
			elseif loadable and not loaded then
				C_AddOns.LoadAddOn("VDWS_Options")
				if not vdwsOptions0:IsShown() then
					vdwsOptions0:Show()
				else
					vdwsOptions0:Hide()
				end
			elseif loadable and loaded then
				if not vdwsOptions0:IsShown() then
					vdwsOptions0:Show()
				else
					vdwsOptions0:Hide()
				end
			else
				C_Sound.PlayVocalErrorSound(48)
				DEFAULT_CHAT_FRAME:AddMessage(C.Main:WrapTextInColorCode(prefixChat.." "..string.format(G.WRN_ADDON_IS_STATE, C_AddOns.GetAddOnMetadata("VDWS_Options", "Title"), reason)))
				UIErrorsFrame:AddExternalWarningMessage(string.format(G.WRN_ADDON_IS_STATE, C_AddOns.GetAddOnMetadata("VDWS_Options", "Title"), reason))
			end
		else
			C_Sound.PlayVocalErrorSound(48)
			DEFAULT_CHAT_FRAME:AddMessage(C.Main:WrapTextInColorCode(prefixChat.." "..G.WRN_COMBAT_LOCKDOWN))
			UIErrorsFrame:AddExternalWarningMessage(G.WRN_COMBAT_LOCKDOWN)
		end
	end
-- slash command --
	RegisterNewSlashCommand(ShowMenu, "vdws", "voodoodawowsuite")
-- mini map button functions --
	AddonCompartmentFrame:RegisterAddon({
		text = C.Main:WrapTextInColorCode(C_AddOns.GetAddOnMetadata("VDWS", "Title")),
		icon = C_AddOns.GetAddOnMetadata("VDWS", "IconAtlas"),
		notCheckable = true,
		func = function(button, menuInputData, menu)
			local buttonName = menuInputData.buttonName
			if buttonName == "LeftButton" then
				ShowMenu()
			end
		end,
		funcOnEnter = function(button)
			VDW.Tooltip_Show(button, prefixTip, G.BUTTON_L_CLICK..": "..G.TIP_OPEN_SETTINGS_MAIN, C.Main)
		end,
		funcOnLeave = function(button)
			VDW.Tooltip_Hide()
		end,
	})
end
-- loading first time the variables --
local function FirstTimeSavedVariables()
	if VDWSprofiles == nil then VDWSprofiles = {} end
	if VDWSsettings == nil then
		VDWSsettings = {
			FourEdges ={
				Style = "Izes",
				Color = G.OPTIONS_C_CLASS,
				Alpha = 1,
				Size = {W = 185, H = 152,},
				vdwsFourEdges1 = true, vdwsFourEdges2 = true, vdwsFourEdges3 = true, vdwsFourEdges4 = true,
			},
			Looty = {
				Visible = true,
				Title = true,
				Size = {W = 376, H = 104,},
				Position = {X = 580, Y = 410,},
				Fonts = {Style = "Normal 13", Color = G.OPTIONS_C_DEFAULT,},
				Background = {Style = G.OPTIONS_C_DEFAULT, Color = G.OPTIONS_C_DEFAULT, Alpha = 0.6,},
				Duration = 25,
				SSOA = true,
				Loot = true,
				Coins = true,
				Currencies = true,
				XP = true,
				Honor = true,
				Reputation = true,
				Skill = true,
				Miscellaneous = true,
			},
			ErrorFrame = {
				Changed = true,
				Fonts = {Style = "Normal 15",},
			},
			FPSframe = {
				Visible = true,
				Fonts = {Style = "Normal 15", Color = G.OPTIONS_C_DEFAULT,},
				Position = {X = 950, Y = 540,},
			},
			MicroMenuContainer = {
				Changed = true,
			},
			Chat = {
				Changed = true,
			},
			MapClock24 = true,
			StatusBarText = true,
		}
	end
-- special settings --
	if VDWSspecialSettings == nil then VDWSspecialSettings = {} end
-- extra settings --
	if VDWSsettings.LastLocation == nil then VDWSsettings.LastLocation = GetLocale() end
	if VDWSsettings.ErrorFrame.Fonts.Family == nil then VDWSsettings.ErrorFrame.Fonts.Family = "Normal" end
	if VDWSsettings.FPSframe.Fonts.Family == nil then VDWSsettings.FPSframe.Fonts.Family = "Normal" end
	if VDWSsettings.FPSframe.Background ~= nil then VDWSsettings.FPSframe.Background = nil end
	if VDWSsettings.Chat.Background == nil then VDWSsettings.Chat.Background = {Style = G.OPTIONS_C_DEFAULT} end
	if VDWSsettings.ErrorFrame.Fonts.WarningColor == nil then VDWSsettings.ErrorFrame.Fonts.WarningColor = G.OPTIONS_C_DEFAULT end
	if VDWSsettings.ErrorFrame.Fonts.ErrorColor == nil then VDWSsettings.ErrorFrame.Fonts.ErrorColor = G.OPTIONS_C_DEFAULT end
end
-- protect the options --
local function ProtectOptions()
	local loc = GetLocale()
	if loc ~= VDWSsettings.LastLocation then
		for k, v in pairs(VDW.Local.Translate) do
			for i, s in pairs (v) do
				if VDWSsettings.FPSframe.Fonts.Color == s then
					VDWSsettings.FPSframe.Fonts.Color = VDW.Local.Translate[loc][i]
				end
				if VDWSsettings.Chat.Background.Style == s then
					VDWSsettings.Chat.Background.Style = VDW.Local.Translate[loc][i]
				end
			end
		end
	end
end
-- Function for stoping the movement --
local function StopMoving(self)
	VDWSsettings.FPSframe.Position.X = Round(self:GetLeft())
	VDWSsettings.FPSframe.Position.Y = Round(self:GetBottom())
	self:StopMovingOrSizing()
end
-- Error frame --
function VDW.VDWS.ErrorFrameChk()
	if VDWSsettings.ErrorFrame.Changed then
		function UIErrorsFrame:TryDisplayMessage(messageType, message, r, g, b)
			if not self:GetMessagesSuppressed() and self:ShouldDisplayMessageType(messageType, message) then
				local rr, rg, rb = RED_FONT_COLOR:GetRGB()
				local yr, yg, yb = YELLOW_FONT_COLOR:GetRGB()
				if r ==  rr and g == rg and b == rb then
					if VDWSsettings.ErrorFrame.Fonts.ErrorColor == G.OPTIONS_C_DEFAULT then
						r, g, b = C.Main:GetRGB()
					elseif VDWSsettings.ErrorFrame.Fonts.ErrorColor == G.OPTIONS_C_CLASS then
						r, g, b = VDW.PlayerClassColor:GetRGB()
					elseif VDWSsettings.ErrorFrame.Fonts.ErrorColor == G.OPTIONS_C_FACTION then
						r, g, b = VDW.PlayerFactionColor:GetRGB()
					end
				end
				if r ==  yr and g == yg and b == yb then
					if VDWSsettings.ErrorFrame.Fonts.WarningColor == G.OPTIONS_C_DEFAULT then
						r, g, b = C.Main:GetRGB()
					elseif VDWSsettings.ErrorFrame.Fonts.WarningColor == G.OPTIONS_C_CLASS then
						r, g, b = VDW.PlayerClassColor:GetRGB()
					elseif VDWSsettings.ErrorFrame.Fonts.WarningColor == G.OPTIONS_C_FACTION then
						r, g, b = VDW.PlayerFactionColor:GetRGB()
					end
				end
				self:AddMessage(message, r, g, b, 1.0, messageType)
				local errorStringId, soundKitID, voiceID = GetGameMessageInfo(messageType)
				if voiceID then
					C_Sound.PlayVocalErrorSound(voiceID)
				elseif soundKitID then
					PlaySound(soundKitID)
				end
			end
		end
		for i = 13, 24, 1 do
			if VDWSsettings.ErrorFrame.Fonts.Style == "Normal "..i then
				UIErrorsFrame:SetFontObject(_G["vdw_NFshadowOut_"..i])
			elseif VDWSsettings.ErrorFrame.Fonts.Style == "Funky "..i then
				UIErrorsFrame:SetFontObject(_G["vdw_FFshadowOut_"..i])
			elseif VDWSsettings.ErrorFrame.Fonts.Style == "Groovy "..i then
				UIErrorsFrame:SetFontObject(_G["vdw_GFshadowOut_"..i])
			end
		end
	else
		function UIErrorsFrame:TryDisplayMessage(messageType, message, r, g, b)
			if not self:GetMessagesSuppressed() and self:ShouldDisplayMessageType(messageType, message) then
				self:AddMessage(message, r, g, b, 1.0, messageType)

				local errorStringId, soundKitID, voiceID = GetGameMessageInfo(messageType)
				if voiceID then
					C_Sound.PlayVocalErrorSound(voiceID)
				elseif soundKitID then
					PlaySound(soundKitID)
				end
			end
		end
		UIErrorsFrame:SetFontObject(ErrorFont)
	end
end
-- FPS frame --
EditModeManagerFrame:HookScript("OnHide", function(self)
	if VDWSsettings.FPSframe.Visible then
		FramerateFrame:ClearAllPoints()
		FramerateFrame:SetPoint("BOTTOMLEFT", UIParent, "BOTTOMLEFT", VDWSsettings.FPSframe.Position.X, VDWSsettings.FPSframe.Position.Y)
	end
end)
EditModeManagerFrame:HookScript("OnShow", function(self)
	if VDWSsettings.FPSframe.Visible then
		C_Timer.After(0.1, function()
			FramerateFrame:ClearAllPoints()
			FramerateFrame:SetPoint("BOTTOMLEFT", UIParent, "BOTTOMLEFT", VDWSsettings.FPSframe.Position.X, VDWSsettings.FPSframe.Position.Y)
		end)
	end
end)
QueueStatusButtonIcon:HookScript("OnShow", function(self)
	if VDWSsettings.FPSframe.Visible then
		C_Timer.After(0.1, function()
			FramerateFrame:ClearAllPoints()
			FramerateFrame:SetPoint("BOTTOMLEFT", UIParent, "BOTTOMLEFT", VDWSsettings.FPSframe.Position.X, VDWSsettings.FPSframe.Position.Y)
		end)
	end
end)
-- check FPS --
function VDW.VDWS.FPScheck()
	if VDWSsettings.FPSframe.Visible then
		if not FramerateFrame:IsShown() then FramerateFrame:Toggle() end
		FramerateFrame:EnableMouse(true)
		FramerateFrame:SetClampedToScreen(true)
		FramerateFrame:SetMovable(true)
		FramerateFrame:RegisterForDrag("LeftButton")
		FramerateFrame:SetScript("OnDragStart", FramerateFrame.StartMoving)
		FramerateFrame:SetScript("OnDragStop", function(self) StopMoving(self) end)
		FramerateFrame:ClearAllPoints()
		FramerateFrame:SetPoint("BOTTOMLEFT", UIParent, "BOTTOMLEFT", VDWSsettings.FPSframe.Position.X, VDWSsettings.FPSframe.Position.Y)
-- fonts --
		for i = 9, 18, 1 do
			if VDWSsettings.FPSframe.Fonts.Style == "Normal "..i then
				FramerateFrame.Label:SetFontObject(_G["vdw_NFshadow_"..i])
				FramerateFrame.FramerateText:SetFontObject(_G["vdw_NFshadow_"..i])
			elseif VDWSsettings.FPSframe.Fonts.Style == "Funky "..i then
				FramerateFrame.Label:SetFontObject(_G["vdw_FFshadow_"..i])
				FramerateFrame.FramerateText:SetFontObject(_G["vdw_FFshadow_"..i])
			elseif VDWSsettings.FPSframe.Fonts.Style == "Groovy "..i then
				FramerateFrame.Label:SetFontObject(_G["vdw_GFshadow_"..i])
				FramerateFrame.FramerateText:SetFontObject(_G["vdw_GFshadow_"..i])
			end
		end
-- color --
		if VDWSsettings.FPSframe.Fonts.Color == G.OPTIONS_C_DEFAULT then
			FramerateFrame.Label:SetTextColor(1, 1, 1, 1)
			FramerateFrame.FramerateText:SetTextColor(1, 1, 1, 1)
		elseif VDWSsettings.FPSframe.Fonts.Color == G.OPTIONS_C_CLASS then
			FramerateFrame.Label:SetTextColor(VDW.PlayerClassColor:GetRGB())
			FramerateFrame.FramerateText:SetTextColor(VDW.PlayerClassColor:GetRGB())
		elseif VDWSsettings.FPSframe.Fonts.Color == G.OPTIONS_C_FACTION then
			FramerateFrame.Label:SetTextColor(VDW.PlayerFactionColor:GetRGB())
			FramerateFrame.FramerateText:SetTextColor(VDW.PlayerFactionColor:GetRGB())
		end
		FramerateFrame:HookScript("OnEnter", function(self)
-- addon memmory --
			local addonMemTotal = 0
			UpdateAddOnMemoryUsage()
			for i = 1, C_AddOns.GetNumAddOns() do
				addonMemTotal = addonMemTotal + GetAddOnMemoryUsage(i)
			end
			local textMemmory = "Addons Memmory: "..string.format("%.2f", addonMemTotal).." KB"
			VDW.Tooltip_Show(self, prefixTip, textMemmory, C.Main, "Top")
		end)
		FramerateFrame:HookScript("OnLeave", function(self) VDW.Tooltip_Hide() end)
	else
		if FramerateFrame:IsShown() then FramerateFrame:Toggle() end
		FramerateFrame:EnableMouse(false)
		FramerateFrame:SetMovable(false)
		FramerateFrame:RegisterForDrag("None")
	end
end
-- MMC frame --
function VDW.VDWS.MMCFrameChk()
	if VDWSsettings.MicroMenuContainer.Changed then
		vdwsMMC:ClearAllPoints()
		vdwsMMC:SetPoint("TOPLEFT", MicroMenuContainer, "TOPLEFT", -16, 8)
		vdwsMMC:SetPoint("BOTTOMRIGHT", MicroMenuContainer, "BOTTOMRIGHT", 16, -8)
		vdwsMMC.Background:SetDesaturation(1)
		vdwsMMC:Show()
	else
		vdwsMMC:Hide()
	end
end
-- Chat frame --
function VDW.VDWS.ChatFrameChk()
	if VDWSsettings.Chat.Changed then
		if VDWSsettings.Chat.Background.Style == G.OPTIONS_C_DEFAULT then
			for i = 1, 10, 1 do
				_G["vdwsChat"..i].Background:SetAtlas("Artifacts-BG-Shadow")
			end
		elseif VDWSsettings.Chat.Background.Style == "Kladia" then
			for i = 1, 10, 1 do
				_G["vdwsChat"..i].Background:SetAtlas("housing-wood-frame")
			end
		end
		for i = 1, 10, 1 do
		_G["vdwsChat"..i]:ClearAllPoints()
		_G["vdwsChat"..i]:SetPoint("TOPLEFT", ChatFrame1ButtonFrame, "TOPLEFT", 1, 2)
		_G["vdwsChat"..i]:SetPoint("BOTTOMRIGHT", ChatFrame1EditBox, "BOTTOMRIGHT", 0, 4)
		_G["vdwsChat"..i]:Show()
		end
	else
		for i = 1, 10, 1 do
		_G["vdwsChat"..i]:Hide()
		end
	end
end
function VDW.VDWS.MapClock24Chk()
	if VDWSsettings.MapClock24 then
		C_CVar.SetCVar("timeMgrUseMilitaryTime", "1")
	else
		C_CVar.SetCVar("timeMgrUseMilitaryTime", "0")
	end
end
function VDW.VDWS.StatusBarTextChk()
	if VDWSsettings.StatusBarText then
		C_CVar.SetCVar("xpBarText", "1")
		MainStatusTrackingBarContainer:ShowText()
		SecondaryStatusTrackingBarContainer:ShowText()
	else
		C_CVar.SetCVar("xpBarText", "0")
	end
end
-- durability --
local function durability()
	local currentTotal = 0
	local maximumTotal = 0
	for i = 1, 30, 1 do
		local current, maximum = GetInventoryItemDurability(i)
		if current and maximum then
			currentTotal = currentTotal + current
			maximumTotal = maximumTotal + maximum
		end
	end
	local percent = (currentTotal * 100) / maximumTotal
	print(currentTotal.. " - "..maximumTotal.." : "..percent.."%")
end
-- events time --
local function EventsTime(self, event, arg1, arg2, arg3, arg4)
	if event == "PLAYER_LOGIN" then
		CreateGlobalVariables()
		FirstTimeSavedVariables()
		ProtectOptions()
		VDW.VDWS.ErrorFrameChk()
		VDW.VDWS.ChatFrameChk()
		VDW.VDWS.MMCFrameChk()
		VDW.VDWS.StatusBarTextChk()
		VDW.VDWS.MapClock24Chk()
	elseif event == "PLAYER_ENTERING_WORLD" then
		C_Timer.After(0.5, function() VDW.VDWS.FPScheck() end)
	elseif event == "PLAYER_INTERACTION_MANAGER_FRAME_SHOW" then
		if arg1 == 57 then
			if FramerateFrame:IsShown() then FramerateFrame:Toggle() end
		end
	elseif event == "PLAYER_INTERACTION_MANAGER_FRAME_HIDE" then
		if arg1 == 57 then
			C_Timer.After(0.5, function() VDW.VDWS.FPScheck() end)
		end
	elseif event == "PET_BATTLE_OPENING_DONE" or event == "PET_BATTLE_CLOSE" or event == "STOP_MOVIE" or event == "PLAYER_SPECIALIZATION_CHANGED" or event == "PLAYER_LEVEL_UP" then
		VDW.VDWS.FPScheck()
	elseif event == "PLAY_MOVIE" then
		if FramerateFrame:IsShown() then FramerateFrame:Toggle() end
	end
end
vdwsZlave:SetScript("OnEvent", EventsTime)
