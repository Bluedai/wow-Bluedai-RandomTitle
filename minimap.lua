local addonName, addonTable = ...

local minimapButton = CreateFrame("Button", "bd_RandomTitleMinimapButton", Minimap)
minimapButton:SetSize(32, 32) -- Framesize, not iconsize 
minimapButton:SetFrameStrata("MEDIUM")
minimapButton:SetPoint("CENTER", Minimap, "LEFT", -20, 0)

-- Mouseover Highlight Texture: blue ring from blizzard archive
minimapButton:SetHighlightTexture("Interface\\Minimap\\UI-Minimap-ZoomButton-Highlight")

-- Border
local ring = minimapButton:CreateTexture(nil, "OVERLAY")
ring:SetSize(32, 32)
ring:SetTexCoord(0, 0.6, 0, 0.6)
ring:SetPoint("CENTER", minimapButton, "CENTER", 0, 0)
ring:SetTexture("Interface\\Minimap\\minimap-trackingborder")

-- set symbol 
local icon = minimapButton:CreateTexture(nil, "BACKGROUND")
icon:SetSize(25, 25)
icon:SetPoint("CENTER", minimapButton, "CENTER", 0, 0)
icon:SetTexture("Interface\\AddOns\\"..addonName.."\\minimap_icon.blp")

-- Mouseover Text
minimapButton:SetScript("OnEnter", function(self)
    GameTooltip:SetOwner(self, "ANCHOR_LEFT")
    GameTooltip:SetText("Bluedai-Random Title")
    GameTooltip:Show()
end)
minimapButton:SetScript("OnLeave", function(self)
    GameTooltip:Hide()
end)

-- left and right clicks 
minimapButton:RegisterForClicks("LeftButtonUp", "RightButtonUp")

minimapButton:SetScript("OnClick", function(self, button)
    if button == "LeftButton" then
        Bluedai_RT_Functions.SetRandomTitle()
    end
    if button == "RightButton" then
        local category = Bluedai_RT_Variables.Category
        if category then
            Settings.OpenToCategory(category:GetID())
        else
            print("Category not found")
        end
    end
end)

-- make minimap icon movable 
minimapButton:SetMovable(true)
minimapButton:SetClampedToScreen(true) -- Prevents the icon from being dragged outside of the screen
minimapButton:EnableMouse(true)
minimapButton:RegisterForDrag("LeftButton") -- Can only be moved with the left mouse button
minimapButton:SetScript("OnDragStart", minimapButton.StartMoving)
minimapButton:SetScript("OnDragStop", function(self)
    self:StopMovingOrSizing()
end)
