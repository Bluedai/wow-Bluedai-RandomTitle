local addonName, addonTable = ...

local minimapButton = CreateFrame("Button", "bd_RandomTitleMinimapButton", Minimap)
-- größe des Frames ( nicht des icons, sondern des Frame elements)
minimapButton:SetSize(32, 32)
minimapButton:SetFrameStrata("MEDIUM")
minimapButton:SetPoint("CENTER", Minimap, "LEFT", -20, 0)

-- welche Grafik bei Mouseover zusätzlich angezeigt wird. ( blauer ring aus dem Blizzard archiv)
minimapButton:SetHighlightTexture("Interface\\Minimap\\UI-Minimap-ZoomButton-Highlight")

-- Border
local ring = minimapButton:CreateTexture(nil, "OVERLAY")
ring:SetSize(32, 32)
ring:SetTexCoord(0, 0.6, 0, 0.6)
ring:SetPoint("CENTER", minimapButton, "CENTER", 0, 0)
ring:SetTexture("Interface\\Minimap\\minimap-trackingborder")


-- Symbol festlegen 
local icon = minimapButton:CreateTexture(nil, "BACKGROUND")
icon:SetSize(25, 25)
icon:SetPoint("CENTER", minimapButton, "CENTER", 0, 0)
icon:SetTexture("Interface\\AddOns\\"..addonName.."\\minimap_icon.blp")

-- funktion die beim click ausgeführt werden soll
minimapButton:SetScript("OnClick", function()
    Bluedai_RT_Functions.SetRandomTitle()
end);

-- Mache das Minimap-Symbol verschiebbar
minimapButton:SetMovable(true)
minimapButton:SetClampedToScreen(true) -- Verhindert, dass das Symbol außerhalb des Bildschirms gezogen wird
minimapButton:EnableMouse(true)
minimapButton:RegisterForDrag("LeftButton") -- Nur mit der linken Maustaste verschiebbar
minimapButton:SetScript("OnDragStart", minimapButton.StartMoving)
minimapButton:SetScript("OnDragStop", function(self)
    self:StopMovingOrSizing()
end)

