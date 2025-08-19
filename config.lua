local function createPanel()
    -- https://wowpedia.fandom.com/wiki/Using_the_Interface_Options_Addons_panel
    local panel = CreateFrame("Frame")
    panel.name = "Bluedai-Random Title"
    local category, layout = Settings.RegisterCanvasLayoutCategory(panel, "Bluedai-Random Title")
    Settings.RegisterAddOnCategory(category)
    Bluedai_RT_Variables.Category = category -- Save the category for minimap.lua
    Bluedai_RT_Variables.panel = panel
end

local function createContentFrame()
    local panel = Bluedai_RT_Variables.panel
    local contentFrame = CreateFrame("Frame", nil, panel)
    contentFrame:SetPoint("TOPLEFT", 0, 0)
    contentFrame:SetPoint("BOTTOMRIGHT", 0, 0)
    Bluedai_RT_Variables.contentFrame = contentFrame
end

local function createContentFrameTitle()
    local frame = Bluedai_RT_Variables.contentFrame
    local title = frame:CreateFontString("ARTWORK", nil, "GameFontNormalLarge")
    title:SetPoint("TOPLEFT")
    title:SetText("Bluedai-Random Title")
    Bluedai_RT_Variables.title = title
end

local function destroyContentFrame()
    if Bluedai_RT_Variables.contentFrame then
        Bluedai_RT_Variables.contentFrame:Hide()
        Bluedai_RT_Variables.contentFrame:SetParent(nil)
        Bluedai_RT_Variables.contentFrame = nil
    end
end

local function createCheckbox()
    local frame = Bluedai_RT_Variables.contentFrame
    local title = Bluedai_RT_Variables.title

    -- EnabledLoginResponse checkbox
    local checkBox = CreateFrame("CheckButton", nil, frame, "ChatConfigCheckButtonTemplate")
    checkBox:SetPoint("TOPLEFT", title, "BOTTOMLEFT", 0, -30)
    checkBox.Text:SetText("Enabled Login Response")
    checkBox.tooltip = "Enable or disable the button after login"

    checkBox:SetChecked(Bluedai_RT.EnabledLoginResponse)
    -- checkBox:SetScript("OnShow", function(self)
    --     self:SetChecked(Bluedai_RT.EnabledLoginResponse)
    -- end)
    checkBox:SetScript("OnClick", function(self)
        Bluedai_RT.EnabledLoginResponse = not Bluedai_RT.EnabledLoginResponse
    end)

    -- EnabledshownewTitle checkbox
    local checkBox2 = CreateFrame("CheckButton", nil, frame, "ChatConfigCheckButtonTemplate")
    checkBox2:SetPoint("TOPLEFT", checkBox, "TOPLEFT", 325, 0  )
    checkBox2.Text:SetText("Show New Title Popup")
    checkBox2.tooltip = "Display a popup to show the new title after it is randomly changed"

    checkBox2:SetChecked(Bluedai_RT.EnabledshownewTitle)
    -- checkBox2:SetScript("OnShow", function(self)
    --     self:SetChecked(Bluedai_RT.EnabledshownewTitle)
    -- end)
    checkBox2:SetScript("OnClick", function(self)
        Bluedai_RT.EnabledshownewTitle = not Bluedai_RT.EnabledshownewTitle
    end)
end

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

local function setAllTitles(state)  -- state=true -> select all, false -> deselect all
    wipe(Bluedai_RT.IgnoredTitles)
    if not state then
        for _, t in ipairs(Bluedai_RT.MyTitles) do
            table.insert(Bluedai_RT.IgnoredTitles, t.id)
        end
    end
end

local function getTitleCount()
    local count = 0
    for _ in pairs(Bluedai_RT.MyTitles) do
        count = count + 1
    end
    return count
end

local function DisplayTitleCount()
    local frame = Bluedai_RT_Variables.contentFrame
    local infoText = frame:CreateFontString(nil, "ARTWORK", "GameFontHighlight")
    infoText:SetPoint("TOPLEFT", frame, "TOPLEFT", 0, -80)
    infoText:SetText("You have " .. getTitleCount() .. " titles")
end

local function DisplaySelectAllButtons()
    local frame = Bluedai_RT_Variables.contentFrame
    local ButtonSelectAll = CreateFrame("Button", nil, frame, "UIPanelButtonTemplate")
    ButtonSelectAll:SetSize(130, 22)
    ButtonSelectAll:SetPoint("TOPRIGHT", -180, -75)
    ButtonSelectAll:SetText("Select all")
    ButtonSelectAll:SetScript("OnClick", function()
        setAllTitles(true)
        Bluedai_RT_Functions.configPanelUpdate()
    end)

    local ButtonSelectNone = CreateFrame("Button", nil, frame, "UIPanelButtonTemplate")
    ButtonSelectNone:SetSize(130, 22)
    ButtonSelectNone:SetPoint("TOPLEFT", ButtonSelectAll, "TOPRIGHT", 10, 0)
    ButtonSelectNone:SetText("Deselect all")
    ButtonSelectNone:SetScript("OnClick", function()
        setAllTitles(false)
        Bluedai_RT_Functions.configPanelUpdate()
    end)

end

local function OptionIgnoredTitles()
    local frame = Bluedai_RT_Variables.contentFrame
    local scrollFrameHeight = 490
    local scrollFrameWidth = 650
    local totalHeight = 0

    local scrollFrame = CreateFrame("ScrollFrame", nil, frame, "UIPanelScrollFrameTemplate")
    scrollFrame:SetSize(scrollFrameWidth, scrollFrameHeight)
    scrollFrame:SetPoint("TOPLEFT", -10, -100)

    local content = CreateFrame("Frame", nil, scrollFrame)
    content:SetSize(20, 2000) -- set the height temporarily to a large number
    scrollFrame:SetScrollChild(content)

    -- create checkbox for each title
    TitelCount = getTitleCount()
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

        checkBox:SetChecked(not isIgnored(titleInfo.id))

        -- -- Sets the checkbox based on whether the title is ignored or not
        -- checkBox:SetScript("OnShow", function(self)
        --     self:SetChecked(not isIgnored(titleInfo.id))
        -- end)

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
    -- Set the actual height of 'content' based on the number of checkboxes
    content:SetHeight(totalHeight)
end

local function configPanelUpdate()
    -- recreate the ContentFrame
    destroyContentFrame()
    createContentFrame()
    createContentFrameTitle()
    createCheckbox()
    DisplayTitleCount()
    OptionIgnoredTitles()
    DisplaySelectAllButtons()
end
Bluedai_RT_Functions.configPanelUpdate = configPanelUpdate

createPanel()
