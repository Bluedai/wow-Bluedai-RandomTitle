Bluedai_RT_Functions = {}
Bluedai_RT_Variables = {}

-- TempVariables
Bluedai_RT_Variables.show = false

local frame = CreateFrame("FRAME") -- Need a frame to respond to events
frame:RegisterEvent("ADDON_LOADED") -- Fired when saved variables are loaded
frame:RegisterEvent("PLAYER_ENTERING_WORLD") -- Fired when entering world and Titles are available
frame:RegisterEvent("UNIT_NAME_UPDATE") -- Fired when the player's name change

local function LoginResponse()
  local ResponseFrame = CreateFrame("Frame", "BluedaiRTFrame", UIParent, "BasicFrameTemplateWithInset")
  ResponseFrame:SetSize(170, 80)
  ResponseFrame:SetPoint("CENTER")
  ResponseFrame:SetMovable(true)
  ResponseFrame:EnableMouse(true)
  ResponseFrame:SetScript("OnMouseDown", ResponseFrame.StartMoving)
  ResponseFrame:SetScript("OnMouseUp", ResponseFrame.StopMovingOrSizing)

  ResponseFrame.title = ResponseFrame:CreateFontString(nil, "OVERLAY")
  ResponseFrame.title:SetFontObject("GameFontHighlight")
  ResponseFrame.title:SetPoint("LEFT", ResponseFrame.TitleBg, "LEFT", 5, 0)
  ResponseFrame.title:SetText("Bluedai-Random Title")

  local button = CreateFrame("Button", nil, ResponseFrame, "GameMenuButtonTemplate")
  button:SetPoint("CENTER", ResponseFrame, "CENTER", 0, -10)
  button:SetSize(150, 40)
  button:SetText("Set Random Title")
  button:SetNormalFontObject("GameFontNormalLarge")
  button:SetHighlightFontObject("GameFontHighlightLarge")

  button:SetScript("OnClick", function()
      Bluedai_RT_Functions.SetRandomTitle()
      ResponseFrame:Hide()
      ResponseFrame:SetScript("OnMouseDown", nil) -- remove script 
      ResponseFrame:SetScript("OnMouseUp", nil) -- remove script 
      ResponseFrame:UnregisterAllEvents()
      ResponseFrame = nil -- delete frame 
  end)

  ResponseFrame:Show()
end


function frame:OnEvent(event, arg1)
  if event == "ADDON_LOADED" and arg1 == "Bluedai-RandomTitle" then
    if Bluedai_RT == nil then
      Bluedai_RT = {};
    end
    if Bluedai_RT.IgnoredTitles == nil then
      Bluedai_RT.IgnoredTitles = {}
    end
    if Bluedai_RT.MyTitles == nil then
      Bluedai_RT.MyTitles = {}
    end
    if Bluedai_RT.EnabledLoginResponse == nil then
      Bluedai_RT.EnabledLoginResponse = true
    end
    if Bluedai_RT.EnabledshownewTitle == nil then
      Bluedai_RT.EnabledshownewTitle = true
    end
    frame:UnregisterEvent("ADDON_LOADED")
  end
  if event == "PLAYER_ENTERING_WORLD" then
    Bluedai_RT_Functions.LoadTitles()
    Bluedai_RT_Functions.OptionIgnoredTitles()
    if Bluedai_RT.EnabledLoginResponse then
      LoginResponse()
    end
    frame:UnregisterEvent("PLAYER_ENTERING_WORLD")
  end
  if event == "UNIT_NAME_UPDATE" and arg1 == "player" then
    Bluedai_RT_Functions.show_new_title()
  end
end
frame:SetScript("OnEvent", frame.OnEvent);
