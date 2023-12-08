EonLash = LibStub("AceAddon-3.0"):GetAddon("EonLash")

function EonLash:DisplaySelfScan(playerEntry)
  -- format data to be displayed on the UI
  local scanContent = string.format([[playerGuid: %s,scanType: %s,timeStamp: %s,targetName: %s,realmName: %s,targetLevel: %d,targetPvpTitle: %s,targetRace: %s,targetGender: %d,targetClass: %s,targetGuild: %s,targetGuildRank: %s,targetInventory: %s,targetTalent: %s,targetRune: %s,inspectUnitId: %s]], playerEntry.playerGuid, playerEntry.scanType, playerEntry.timeStamp,
  playerEntry.targetName, playerEntry.realmName, playerEntry.targetLevel, playerEntry.targetPvpTitle,
  playerEntry.targetRace, playerEntry.targetGender, playerEntry.targetClass,
  playerEntry.targetGuild, playerEntry.targetGuildRank, playerEntry.targetInventory,
  playerEntry.targetTalent, playerEntry.targetRune, playerEntry.inspectUnitId)

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

function EonLash:DisplaySelfScanEncoded(playerEntry)
  -- format data to be displayed on the UI
  local scanContent = string.format([[playerGuid: %s,scanType: %s,timeStamp: %s,targetName: %s,realmName: %s,targetLevel: %d,targetPvpTitle: %s,targetRace: %s,targetGender: %d,targetClass: %s,targetGuild: %s,targetGuildRank: %s,targetInventory: %s,targetTalent: %s,targetRune: %s,inspectUnitId: %s]], playerEntry.playerGuid, playerEntry.scanType, playerEntry.timeStamp,
  playerEntry.targetName, playerEntry.realmName, playerEntry.targetLevel, playerEntry.targetPvpTitle,
  playerEntry.targetRace, playerEntry.targetGender, playerEntry.targetClass,
  playerEntry.targetGuild, playerEntry.targetGuildRank, playerEntry.targetInventory,
  playerEntry.targetTalent, playerEntry.targetRune, playerEntry.inspectUnitId)

  local scanContentEncoded = EonLash.Base64.Encode(scanContent, 76)

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
  multiLineEditBox:SetText(scanContentEncoded)
  multiLineEditBox:HighlightText(0, strlen(scanContentEncoded))
  -- multiLineEditBox:SetDisabled(true)

  -- Add the MultiLineEditBox to the frame
  frame:AddChild(multiLineEditBox)

  frame:Show()
end