EonLash = LibStub("AceAddon-3.0"):GetAddon("EonLash")

function EonLash:DisplaySelfScan(scanContent)
  -- Create a frame to hold the EditBox
  local frame = AceGUI:Create("Frame")
  frame:SetTitle("EonLash")
  frame:SetStatusText("Press CTRL/C to copy and Paste at https://eonlash.com")
  frame:SetCallback("OnClose", function(widget) AceGUI:Release(widget) end)
  frame:SetLayout("Fill")

  -- Create a MultiLineEditBox
  local multiLineEditBox = AceGUI:Create("MultiLineEditBox")
  multiLineEditBox:SetLabel("Press CTRL/C to copy.")
  multiLineEditBox:SetWidth(300)
  multiLineEditBox:SetNumLines(5)
  multiLineEditBox:DisableButton(true)
  multiLineEditBox:SetFocus()
  multiLineEditBox:SetText(scanContent)
  multiLineEditBox:HighlightText(0, strlen(scanContent))
  -- multiLineEditBox:SetDisabled(true)

  -- Add the MultiLineEditBox to the frame
  frame:AddChild(multiLineEditBox)

  frame:Show()
end