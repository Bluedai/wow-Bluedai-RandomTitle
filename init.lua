Bluedai_RT_Functions = {}

local frame = CreateFrame("FRAME"); -- Need a frame to respond to events
frame:RegisterEvent("ADDON_LOADED"); -- Fired when saved variables are loaded


local function LoginResponse()
  -- Erstelle ein neues Frame für den Button
  local ResponseFrame = CreateFrame("Frame", "BluedaiRTFrame", UIParent, "BasicFrameTemplateWithInset")
  ResponseFrame:SetSize(170, 80) -- Größe des Frames
  ResponseFrame:SetPoint("CENTER") -- Position in der Mitte des Bildschirms
  ResponseFrame:SetMovable(true)
  ResponseFrame:EnableMouse(true)
  ResponseFrame:SetScript("OnMouseDown", ResponseFrame.StartMoving)
  ResponseFrame:SetScript("OnMouseUp", ResponseFrame.StopMovingOrSizing)

  -- Titel für das Frame
  ResponseFrame.title = ResponseFrame:CreateFontString(nil, "OVERLAY")
  ResponseFrame.title:SetFontObject("GameFontHighlight")
  ResponseFrame.title:SetPoint("LEFT", ResponseFrame.TitleBg, "LEFT", 5, 0)
  ResponseFrame.title:SetText("Bluedai Random Title")

  -- Button im Frame
  local button = CreateFrame("Button", nil, ResponseFrame, "GameMenuButtonTemplate")
  button:SetPoint("CENTER", ResponseFrame, "CENTER", 0, -10)
  button:SetSize(150, 40)
  button:SetText("Set Random Title")
  button:SetNormalFontObject("GameFontNormalLarge")
  button:SetHighlightFontObject("GameFontHighlightLarge")

  -- Funktion des Buttons, um die Aktion auszuführen und das Fenster zu schließen
  button:SetScript("OnClick", function()
      Bluedai_RT_Functions.SetRandomTitle() -- Führe die Funktion aus
      ResponseFrame:Hide() -- Verstecke das Frame
      ResponseFrame:SetScript("OnMouseDown", nil) -- Entferne die Scripte
      ResponseFrame:SetScript("OnMouseUp", nil)
      ResponseFrame:UnregisterAllEvents() -- Stoppe alle weiteren Events
      ResponseFrame = nil -- Frame löschen
  end)

  -- Zeige das Frame an
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
      if Bluedai_RT.Enabled == nil then
        Bluedai_RT.Enabled = true
      end
      -- Unregister from the event, it just consumes unnecessary resources
      frame:UnregisterEvent("ADDON_LOADED")
      Bluedai_RT_Functions.LoadTitles()
      Bluedai_RT_Functions.OptionIgnoredTitles()
      -- Überprüfung, ob das Addon aktiviert ist
      if Bluedai_RT.Enabled then
        LoginResponse()
      end
    end
end
frame:SetScript("OnEvent", frame.OnEvent);
