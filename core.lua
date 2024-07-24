-- Global variables from init.lua:
-- Bluedai_RT.IgnoredTitles
-- Bluedai_RT.MyTitles
-- Bluedai_RT_Functions = {}
-- Bluedai_RT_Variables = {}

local function LoadTitles()
    Bluedai_RT.MyTitles = {}
    for i = 1, GetNumTitles() do
        if IsTitleKnown(i) == true then
            local title = GetTitleName(i)
            Bluedai_RT.MyTitles[#Bluedai_RT.MyTitles + 1] = {
                id			= i,
                name		= title,
            }
        end
    end
    sort(Bluedai_RT.MyTitles, function(a, b) return a["name"] < b["name"] end)
end
Bluedai_RT_Functions.LoadTitles = LoadTitles

local function SetRandomTitle()
    local eligibleIDs = {}  -- A table to store valid IDs
    local currentTitleID = GetCurrentTitle()

    for _, titleData in ipairs(Bluedai_RT.MyTitles) do
        local isIgnored = false
        for _, ignoredId in ipairs(Bluedai_RT.IgnoredTitles) do
            if ignoredId == titleData.id then
                isIgnored = true
                break
            end
        end
        if not isIgnored and currentTitleID ~= titleData.id then
            table.insert(eligibleIDs, titleData.id)
        end
    end
    if #eligibleIDs > 0 then
        local randomIndex = math.random(1, #eligibleIDs)
        -- print("debug: RandomTitleID : " .. eligibleIDs[randomIndex] .. "  Titel:" .. GetTitleName(eligibleIDs[randomIndex]) )
        SetCurrentTitle(eligibleIDs[randomIndex])
    end
end
Bluedai_RT_Functions.SetRandomTitle = SetRandomTitle

SLASH_BluedaiRandomTitle_brt1 = "/brt";
SlashCmdList["BluedaiRandomTitle_brt"] = function (msg)
    SetRandomTitle()
end

