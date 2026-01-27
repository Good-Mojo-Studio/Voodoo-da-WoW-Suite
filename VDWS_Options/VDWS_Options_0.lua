-- some variables --
local L = VDW.VDWS.Local
local C = VDW.GetAddonColors("VDWS")
local prefixTip = VDW.Prefix("VDWS")
local maxW = 128
local finalW = 0
-- Entering the tabs frame' Exit Button --
vdwsOptions0.ExitButton:HookScript("OnEnter", function(self)
	VDW.Tooltip_Show(self, prefixTip, L.TIP_CLOSE_PANEL, C.Main)
end)
-- Move the tabs frame --
vdwsOptions0:RegisterForDrag("LeftButton")
vdwsOptions0:SetScript("OnDragStart", vdwsOptions0.StartMoving)
vdwsOptions0:SetScript("OnDragStop", vdwsOptions0.StopMovingOrSizing)
-- Taking care of the Tabs --
-- Naming the tab --
vdwsOptions0Tab1.Text:SetText("Four Edges")
vdwsOptions0Tab2.Text:SetText("Looty Groove")
vdwsOptions0Tab3.Text:SetText("Error Frame, FPS Frame, etchetera")
vdwsOptions0Tab4.Text:SetText(L.P_TAB)
-- Position & center text color --
for i = 1, 4, 1 do
	local w = _G["vdwsOptions0Tab"..i].Text:GetStringWidth()
	if w > maxW then maxW = w end
end
finalW = math.ceil(maxW + 16)
for i = 1, 4, 1 do
	_G["vdwsOptions0Tab"..i]:SetWidth(finalW)
end
for i = 2, 4, 1 do
	_G["vdwsOptions0Tab"..i]:SetPoint("TOP", _G["vdwsOptions0Tab"..i-1], "BOTTOM", 0, 0)
end
-- Entering the tabs --
for i = 1, 3, 1 do
	_G["vdwsOptions0Tab"..i]:HookScript("OnEnter", function(self)
		local word = self.Text:GetText()
		VDW.Tooltip_Show(self, prefixTip, string.format(L.T_TIP, word), C.Main)
	end)
end
vdwsOptions0Tab4:HookScript("OnEnter", function(self)
	VDW.Tooltip_Show(self, prefixTip, L.P_TITLE, C.Main)
end)
-- Leaving the tabs --
for i = 1, 4, 1 do
	_G["vdwsOptions0Tab"..i]:HookScript("OnLeave", function(self)
		VDW.Tooltip_Hide()
	end)
end
-- clickingthe tabs --
for i = 1, 4, 1 do
	_G["vdwsOptions0Tab"..i]:HookScript("OnClick", function(self, button, down)
		if button == "LeftButton" and down == false then
			if not _G["vdwsOptions"..i]:IsShown() then _G["vdwsOptions"..i]:Show() end
		end
	end)
end
-- show the tabs frame --
vdwsOptions0:SetScript("OnShow", function(self)
	if not vdwsOptions1:IsShown() then vdwsOptions1:Show() end
end)
-- Hide the tabs frame --
vdwsOptions0:HookScript("OnHide", function(self)
	for i = 1, 4, 1 do
		if _G["vdwsOptions"..i]:IsShown() then _G["vdwsOptions"..i]:Hide() end
	end
end)
