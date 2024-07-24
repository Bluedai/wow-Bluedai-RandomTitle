-- https://wowpedia.fandom.com/wiki/Using_the_Interface_Options_Addons_panel
local panel = CreateFrame("Frame")
panel.name = "Bluedai-Random Title"
-- InterfaceOptions_AddCategory(panel) - doesn't work after 11.0 patch
local category, layout = Settings.RegisterCanvasLayoutCategory(panel, "Bluedai-Random Title")
Settings.RegisterAddOnCategory(category)
Bluedai_RT_Variables.Category = category -- Save the category for minimap.lua

-- Title
local title = panel:CreateFontString("ARTWORK", nil, "GameFontNormalLarge")
title:SetPoint("TOPLEFT")
title:SetText("Bluedai-Random Title")

-- EnabledLoginResponse checkbox
local checkBox = CreateFrame("CheckButton", "BluedaiRTEnabledLoginResponseCheckbox", panel, "ChatConfigCheckButtonTemplate")
checkBox:SetPoint("TOPLEFT", title, "BOTTOMLEFT", 0, -30)

BluedaiRTEnabledLoginResponseCheckboxText:SetText("Enabled Login Response")
checkBox.tooltip = "Enable or disable the button after login"

checkBox:SetScript("OnShow", function(self)
    self:SetChecked(Bluedai_RT.EnabledLoginResponse)
end)

checkBox:SetScript("OnClick", function(self)
    Bluedai_RT.EnabledLoginResponse = not Bluedai_RT.EnabledLoginResponse
end)

local function isIgnored(id)
    for _, ignoredId in pairs(Bluedai_RT.IgnoredTitles) do
        if ignoredId == id then
            return true
        end
    end
    return false
end

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
    local scrollFrameHeight = 490
    local scrollFrameWidth = 650

    local totalHeight = 0

    local scrollFrame = CreateFrame("ScrollFrame", nil, panel, "UIPanelScrollFrameTemplate")
    scrollFrame:SetSize(scrollFrameWidth, scrollFrameHeight)
    scrollFrame:SetPoint("TOPLEFT", -10, -100)

    local content = CreateFrame("Frame", nil, scrollFrame)
    content:SetSize(20, 2000) -- Setze eine vorläufige Höhe
    scrollFrame:SetScrollChild(content)

    -- create checkbox for each title
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

        -- Sets the checkbox based on whether the title is ignored or not
        checkBox:SetScript("OnShow", function(self)
            self:SetChecked(not isIgnored(titleInfo.id))
        end)

        -- Update IgnoredTitles when the checkbox is toggled
        checkBox:SetScript("OnClick", function(self)
            updateIgnoredTitles(titleInfo.id, not self:GetChecked())
        end)

        yOffset = yOffset - 20
        if TitelDisplayCount == halfTitelCount then
            yOffset = -10
            xOffset = scrollFrameWidth / 2 + 10
        end

        if TitelDisplayCount <= halfTitelCount then
            totalHeight = totalHeight + 20
        end
    end
    -- create text under trigger checkbox
    local infoText = panel:CreateFontString(nil, "ARTWORK", "GameFontHighlight")
    infoText:SetPoint("TOPLEFT", checkBox, "BOTTOMLEFT", 0, -8)
    infoText:SetText("You have " .. TitelCount .. " titles")
    
    -- Stelle die tatsächliche Höhe von 'content' basierend auf der Anzahl der Checkboxen ein
    content:SetHeight(totalHeight)
end

-- global functions
Bluedai_RT_Functions.OptionIgnoredTitles = OptionIgnoredTitles
