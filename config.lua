-- https://wowpedia.fandom.com/wiki/Using_the_Interface_Options_Addons_panel
local panel = CreateFrame("Frame")
panel.name = "Bluedai-Random Title"  -- see panel fields
InterfaceOptions_AddCategory(panel)  -- see InterfaceOptions API

-- Title
local title = panel:CreateFontString("ARTWORK", nil, "GameFontNormalLarge")
title:SetPoint("TOPLEFT")
title:SetText("Bluedai-Random Title")

-- checkbox enabled
local checkBox = CreateFrame("CheckButton", "BluedaiRTEnabledCheckbox", panel, "ChatConfigCheckButtonTemplate")
checkBox:SetPoint("TOPLEFT", title, "BOTTOMLEFT", 0, -30)

BluedaiRTEnabledCheckboxText:SetText("Enabled Login Response")
checkBox.tooltip = "Aktiviere oder deaktiviere die Funktion"

-- Die Checkbox beim Laden des Panels setzen
checkBox:SetScript("OnShow", function(self)
    self:SetChecked(Bluedai_RT.Enabled)
end)

-- Ändere die Variable, wenn die Checkbox umgeschaltet wird
checkBox:SetScript("OnClick", function(self)
    Bluedai_RT.Enabled = not Bluedai_RT.Enabled -- wechselt den Wert
end)

-- Funktion zum Überprüfen, ob eine ID ignoriert wird
local function isIgnored(id)
    for _, ignoredId in pairs(Bluedai_RT.IgnoredTitles) do
        if ignoredId == id then
            return true
        end
    end
    return false
end

-- Funktion zum Aktualisieren der IgnoredTitles
local function updateIgnoredTitles(id, shouldBeIgnored)
    if shouldBeIgnored then
        table.insert(Bluedai_RT.IgnoredTitles, id)
    else
        for i, ignoredId in pairs(Bluedai_RT.IgnoredTitles) do
            if ignoredId == id then
                table.remove(Bluedai_RT.IgnoredTitles, i)
                break
            end
        end
    end
end

local function OptionIgnoredTitles()
    -- Vorausgesetzte Einstellungen und Variablen
    local scrollFrameHeight = 490 -- Höhe des Scrollbereichs
    local scrollFrameWidth = 600 -- Breite des Scrollbereichs
    local totalHeight = 0 -- Gesamthöhe der Checkboxen

    -- Erstelle das ScrollFrame
    local scrollFrame = CreateFrame("ScrollFrame", nil, panel, "UIPanelScrollFrameTemplate")
    scrollFrame:SetSize(scrollFrameWidth, scrollFrameHeight)
    scrollFrame:SetPoint("TOPLEFT", -10, -100)

    local content = CreateFrame("Frame", nil, scrollFrame)
    content:SetSize(20, 2000) -- Setze eine vorläufige Höhe
    scrollFrame:SetScrollChild(content)


    -- Checkboxen für jeden Titel erstellen
    
    local TitelCount = 0
    for _ in pairs(Bluedai_RT.MyTitles) do
        TitelCount = TitelCount + 1
    end
    local halfTitelCount = math.ceil(TitelCount / 2)


    local TitelDisplayCount = 0
    local yOffset = -10
    local xOffset = 10
    for _, titleInfo in pairs(Bluedai_RT.MyTitles) do
        TitelDisplayCount = TitelDisplayCount + 1
        local checkBox = CreateFrame("CheckButton", nil, content, "ChatConfigCheckButtonTemplate")
        checkBox:SetPoint("TOPLEFT", xOffset, yOffset)
        checkBox.Text:SetText(titleInfo.name .. " (" .. titleInfo.id .. ")")
        checkBox.tooltip = titleInfo.name

        -- Setzt die Checkbox basierend darauf, ob der Titel ignoriert wird oder nicht
        checkBox:SetScript("OnShow", function(self)
            self:SetChecked(not isIgnored(titleInfo.id))
        end)

        -- Aktualisiere IgnoredTitles, wenn die Checkbox umgeschaltet wird
        checkBox:SetScript("OnClick", function(self)
            updateIgnoredTitles(titleInfo.id, not self:GetChecked())
        end)

        -- Verschiebe die nächste Checkbox
        yOffset = yOffset - 20
        if TitelDisplayCount == halfTitelCount then
            yOffset = -10
            xOffset = scrollFrameWidth / 2 + 10
        end

        if TitelDisplayCount <= halfTitelCount then
            totalHeight = totalHeight + 20
        end
    end
    -- Stelle die tatsächliche Höhe von 'content' basierend auf der Anzahl der Checkboxen ein
    content:SetHeight(totalHeight)
    -- Aktualisiere die Scrollbar automatisch, wenn nötig
    -- scrollFrame:SetScript("OnSizeChanged", function(self)
    -- scrollFrame.ScrollBar:SetMinMaxValues(0, max(0, totalHeight - scrollFrameHeight))
    -- end)
end
Bluedai_RT_Functions.OptionIgnoredTitles = OptionIgnoredTitles



