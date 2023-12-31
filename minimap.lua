local minimapButton = CreateFrame("Button", "bd_RandomTitleMinimapButton", Minimap)
-- größe des Frames ( nicht des icons, sondern des Frame elements)
minimapButton:SetSize(32, 32)
minimapButton:SetFrameStrata("MEDIUM")
minimapButton:SetPoint("CENTER", Minimap, "LEFT", -20, 0)

-- welche Grafik bei Mouseover zusätzlich angezeigt wird. ( blauer ring aus dem Blizzard archiv)
minimapButton:SetHighlightTexture("Interface\\Minimap\\UI-Minimap-ZoomButton-Highlight")

-- Symbol festlegen 
local icon = minimapButton:CreateTexture(nil, "BACKGROUND")
icon:SetSize(20, 20)
icon:SetPoint("CENTER", minimapButton, "CENTER", 0, 0)
icon:SetTexture("Interface\\Minimap\\TRACKING\\UpgradeItem-32x32") -- 4025144

-- funktion die beim click ausgeführt werden soll
minimapButton:SetScript("OnClick", function()
    Bluedai_RT_Functions.SetRandomTitle()
end);