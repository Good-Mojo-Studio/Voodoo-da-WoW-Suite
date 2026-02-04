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
			MenuUtil.ShowTooltip(button, function(tooltip)
			tooltip:SetOwner(AddonCompartmentFrame, "ANCHOR_TOP", 0, 0)
			tooltip:SetText(C.Main:WrapTextInColorCode(prefixTip).."|n"..G.BUTTON_L_CLICK..": "..G.TIP_OPEN_SETTINGS_MAIN)
			end)
		end,
		funcOnLeave = function(button)
			MenuUtil.HideTooltip(AddonCompartmentFrame)
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
				Color = "Class",
				Alpha = 1,
				Size = {W = 185, H = 152,},
				vdwsFourEdges1 = true, vdwsFourEdges2 = true, vdwsFourEdges3 = true, vdwsFourEdges4 = true,
			},
			Looty = {
				Visible = true,
				Title = true,
				Size = {W = 376, H = 104,},
				Position = {X = 580, Y = 410,},
				Fonts = {Style = "Normal 13", Color = "Default",},
				Background = {Style = "Default", Color = "Default", Alpha = 0.6,},
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
				Fonts = {Style = "Normal 15", Color = "Default",},
				Background = {Style = "Highlight", Color = "Default",},
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
	if VDWSspecialSettings["LastLocation"] == nil then
		VDWSspecialSettings["LastLocation"] = GetLocale()
	end
end
-- protect the options --
local function ProtectOptions()
	local loc = GetLocale()
	if loc ~= VDWSspecialSettings.LastLocation then
		for k, v in pairs(VDW.Local.Translate) do
			for i, s in pairs (v) do
				if VDWSsettings.FPSframe.Fonts.Color == s then
					VDWSsettings.FPSframe.Fonts.Color = VDW.Local.Translate[loc][i]
				end
				if VDWSsettings.FPSframe.Background.Color == s then
					VDWSsettings.FPSframe.Background.Color = VDW.Local.Translate[loc][i]
				end
			end
		end
	end
end
-- Error frame --
function VDW.VDWS.ErrorFrameChk()
	if VDWSsettings.ErrorFrame.Changed then
		for i = 13, 22, 1 do
			if VDWSsettings.ErrorFrame.Fonts.Style == "Normal "..i then
				UIErrorsFrame:SetFontObject(_G["vdws_NFshadowOut_"..i])
			elseif VDWSsettings.ErrorFrame.Fonts.Style == "Funky "..i then
				UIErrorsFrame:SetFontObject(_G["vdws_FFshadowOut_"..i])
			elseif VDWSsettings.ErrorFrame.Fonts.Style == "Groovy "..i then
				UIErrorsFrame:SetFontObject(_G["vdws_GFshadowOut_"..i])
			end
		end
	end
end
-- FPS frame --
EditModeManagerFrame:HookScript("OnHide", function(self)
	if VDWSsettings.FPSframe.Visible then
		FramerateFrame:ClearAllPoints()
		FramerateFrame:SetPoint("BOTTOMLEFT", UIParent, "BOTTOMLEFT", VDWSsettings.FPSframe.Position.X, VDWSsettings.FPSframe.Position.Y)
	end
end)
-- check FPS --
function VDW.VDWS.FPScheck()
	if VDWSsettings.FPSframe.Visible then
		if not FramerateFrame:IsShown() then FramerateFrame:Toggle() end
		FramerateFrame:EnableMouse(true)
		FramerateFrame:SetClampedToScreen(true)
		FramerateFrame:ClearAllPoints()
		FramerateFrame:SetPoint("BOTTOMLEFT", UIParent, "BOTTOMLEFT", VDWSsettings.FPSframe.Position.X, VDWSsettings.FPSframe.Position.Y)
-- fonts --
		for i = 9, 17, 1 do
			if VDWSsettings.FPSframe.Fonts.Style == "Normal "..i then
				if i == 13 then
					FramerateFrame.Label:SetFontObject(_G["vdw_NFshadow_"..i])
					FramerateFrame.FramerateText:SetFontObject(_G["vdw_NFshadow_"..i])
				else
					FramerateFrame.Label:SetFontObject(_G["vdws_NFshadow_"..i])
					FramerateFrame.FramerateText:SetFontObject(_G["vdws_NFshadow_"..i])
				end
			elseif VDWSsettings.FPSframe.Fonts.Style == "Funky "..i then
				if i == 15 then
					FramerateFrame.Label:SetFontObject(_G["vdw_FFshadow_"..i])
					FramerateFrame.FramerateText:SetFontObject(_G["vdw_FFshadow_"..i])
				else
					FramerateFrame.Label:SetFontObject(_G["vdws_FFshadow_"..i])
					FramerateFrame.FramerateText:SetFontObject(_G["vdws_FFshadow_"..i])
				end
			elseif VDWSsettings.FPSframe.Fonts.Style == "Groovy "..i then
				FramerateFrame.Label:SetFontObject(_G["vdws_GFshadow_"..i])
				FramerateFrame.FramerateText:SetFontObject(_G["vdws_GFshadow_"..i])
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
-- background -- style
		if VDWSsettings.FPSframe.Background.Style == "None" then
			vdwsFPS:Hide()
		elseif VDWSsettings.FPSframe.Background.Style == "Highlight" then
			vdwsFPS.Background:SetAtlas("GarrMissionLocation-Maw-ButtonHighlight")
			vdwsFPS:ClearAllPoints()
			vdwsFPS:SetPoint("TOPLEFT", FramerateFrame, "TOPLEFT", -5, 4)
			vdwsFPS:SetPoint("BOTTOMRIGHT", FramerateFrame, "BOTTOMRIGHT", 2, -1)
			vdwsFPS:Show()
		elseif VDWSsettings.FPSframe.Background.Style == "Kyrian" then
			vdwsFPS.Background:SetAtlas("CovenantSanctum-Level-Border-Kyrian")
			vdwsFPS:ClearAllPoints()
			vdwsFPS:SetPoint("TOPLEFT", FramerateFrame, "TOPLEFT", -10, 20)
			vdwsFPS:SetPoint("BOTTOMRIGHT", FramerateFrame, "BOTTOMRIGHT", 2, 2)
			vdwsFPS:Show()
		elseif VDWSsettings.FPSframe.Background.Style == "Necrolord" then
			vdwsFPS.Background:SetAtlas("CovenantSanctum-Level-Border-Necrolord")
			vdwsFPS:ClearAllPoints()
			vdwsFPS:SetPoint("TOPLEFT", FramerateFrame, "TOPLEFT", -10, 20)
			vdwsFPS:SetPoint("BOTTOMRIGHT", FramerateFrame, "BOTTOMRIGHT", 2, 2)
			vdwsFPS:Show()
		elseif VDWSsettings.FPSframe.Background.Style == "Nightfae" then
			vdwsFPS.Background:SetAtlas("CovenantSanctum-Level-Border-Nightfae")
			vdwsFPS:ClearAllPoints()
			vdwsFPS:SetPoint("TOPLEFT", FramerateFrame, "TOPLEFT", -10, 20)
			vdwsFPS:SetPoint("BOTTOMRIGHT", FramerateFrame, "BOTTOMRIGHT", 2, 2)
			vdwsFPS:Show()
		elseif VDWSsettings.FPSframe.Background.Style == "Venthyr" then
			vdwsFPS.Background:SetAtlas("CovenantSanctum-Level-Border-Venthyr")
			vdwsFPS:ClearAllPoints()
			vdwsFPS:SetPoint("TOPLEFT", FramerateFrame, "TOPLEFT", -10, 20)
			vdwsFPS:SetPoint("BOTTOMRIGHT", FramerateFrame, "BOTTOMRIGHT", 2, 2)
			vdwsFPS:Show()
		end
-- background -- color
		if VDWSsettings.FPSframe.Background.Color == G.OPTIONS_C_DEFAULT then
			vdwsFPS.Background:SetDesaturation(0)
			vdwsFPS.Background:SetVertexColor(1, 1, 1, 1)
		elseif VDWSsettings.FPSframe.Background.Color == G.OPTIONS_C_CLASS then
			vdwsFPS.Background:SetDesaturation(1)
			vdwsFPS.Background:SetVertexColor(VDW.PlayerClassColor:GetRGB())
		elseif VDWSsettings.FPSframe.Background.Color == G.OPTIONS_C_FACTION then
			vdwsFPS.Background:SetDesaturation(1)
			vdwsFPS.Background:SetVertexColor(VDW.PlayerFactionColor:GetRGB())
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
	else
		C_CVar.SetCVar("xpBarText", "0")
	end
end
-- durability --
local currentTotal = 0
local maximumTotal = 0
local function durability()
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
		VDW.VDWS.FPScheck()
		VDW.VDWS.ChatFrameChk()
		VDW.VDWS.MMCFrameChk()
		VDW.VDWS.StatusBarTextChk()
		VDW.VDWS.MapClock24Chk()
	elseif event == "PLAYER_ENTERING_WORLD" then
		VDW.VDWS.FPScheck()
	elseif event == "PLAYER_INTERACTION_MANAGER_FRAME_SHOW" then
		if arg1 == 57 then
			if FramerateFrame:IsShown() then FramerateFrame:Toggle() end
		end
	elseif event == "PLAYER_INTERACTION_MANAGER_FRAME_HIDE" then
		if arg1 == 57 then
			C_Timer.After(0.5, function() VDW.VDWS.FPScheck() end)
		end
	end
end
vdwsZlave:SetScript("OnEvent", EventsTime)
