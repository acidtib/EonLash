EonLash = LibStub("AceAddon-3.0"):GetAddon("EonLash")

-- whats the current realm name
local serverName = GetRealmName()

-- grab target player details
function EonLash:ScanPlayerDetails(playerGuid, unitId)
  local playerEntry = self:DBGet(playerGuid)

  playerEntry.targetLevel = UnitLevel(unitId)
  playerEntry.targetRace = UnitRace(unitId)
  playerEntry.targetClass = UnitClass(unitId)
  playerEntry.targetGender = UnitSex(unitId)-1

  local targetGuild, targetGuildRank = GetGuildInfo(unitId)
  if not targetGuild then
    targetGuild = ""
    targetGuildRank = ""
  end
  playerEntry.targetGuild = targetGuild
  playerEntry.targetGuildRank = targetGuildRank

	playerEntry.scanType = "SEMI"

  local targetPvpTitle = UnitPVPName(unitId)
  if targetPvpTitle == playerEntry.targetName then
    targetPvpTitle = ""
  else
    targetPvpTitle = string.sub(targetPvpTitle, 0, string.len(targetPvpTitle) - string.len(playerEntry.targetName))
  end
  playerEntry.targetPvpTitle = targetPvpTitle

  -- save to database
  self:DBAdd(playerGuid, playerEntry)
end

-- inspect a target
function EonLash:ScanInspectPlayer(unitId)
  NotifyInspect(unitId)
  self:RegisterEvent("INSPECT_READY")
end

-- handle INSPECT_READY event
function EonLash:INSPECT_READY(event, guid)
  local playerEntry = self:DBGet(guid)

  if playerEntry then

    -- grab player talents
    local numTabs = GetNumTalentTabs()
    local targetTalent = ""

    for t=1, numTabs do
      targetTalent = string.format("%s%s[", targetTalent, GetTalentTabInfo(t))

      local numTalents = GetNumTalents(t)
      for i=1, numTalents do
        name, iconPath, tier, column, currentRank, maxRank, isExceptional, meetsPrereq = GetTalentInfo(t, i)
        local talent_entry = string.format("%s:%s:%d:%d:%d:%d--", name, iconPath, tier, column, currentRank, maxRank)
        targetTalent = string.format("%s%s", targetTalent, talent_entry)
      end	
      targetTalent = string.format("%s]", targetTalent)
    end

    -- grab player active gear
    local targetInventory = ""

    for i = 1, 19, 1 do
      local itemId = GetInventoryItemID(playerEntry.inspectUnitId, i)
      local link = GetInventoryItemLink(playerEntry.inspectUnitId, i)
      local enchantId = 0

      if not (link == null) then
        --local _, enchantId, gem1, gem2, gem3, gem4 = link:match("item:(%d+):(%d+):(%d+):(%d+):(%d+):(%d+)");
        local _, _, Color, Ltype, Id, Enchant, Gem1, Gem2, Gem3, Gem4, Suffix, Unique, LinkLvl, Name = string.find(link, "|?c?f?f?(%x*)|?H?([^:]*):?(%d+):?(%d*):?(%d*):?(%d*):?(%d*):?(%d*):?(%-?%d*):?(%-?%d*):?(%d*):?(%d*):?(%-?%d*)|?h?%[?([^%[%]]*)%]?|?h?|?r?")
        enchantId = tonumber(Enchant)

        if enchantId == nil then
          enchantId = 0
        end
      end

      if targetInventory == "" then
        targetInventory = format("%d:%d", itemId, enchantId)
      else
        targetInventory = format("%s %d:%d", targetInventory, itemId, enchantId)
      end
    end

    -- grab character active runes
    local supportedSlots = { [5] = "Chest", [7] = "Legs", [10] = "Hands" }
    local targetRune = ""

    for slot, name in pairs(supportedSlots) do
      local activeRune = C_Engraving.GetRuneForEquipmentSlot(slot)
      if activeRune then
        targetRune = string.format("%s%s[", targetRune, name)

        local runeEntry = string.format("%s:%s:%s:%s--", activeRune.name, activeRune.learnedAbilitySpellIDs[1], activeRune.level, activeRune.iconTexture)
        targetRune = string.format("%s%s", targetRune, runeEntry)

        targetRune = string.format("%s]", targetRune)
      end
    end

    playerEntry.targetTalent = targetTalent
    playerEntry.targetInventory = targetInventory
    playerEntry.targetRune = targetRune
    playerEntry.scanType = "FULL"

    self:DBAdd(playerEntry.playerGuid, playerEntry)

    self:UnregisterEvent("INSPECT_READY")


    if playerEntry.inspectUnitId == "player" then
      -- self:DisplaySelfScan(playerEntry)
      self:DisplaySelfScanEncoded(playerEntry)
    end
  end
end

-- scan player and display frame with data
function EonLash:ScanPlayer(unitId)
  if CanInspect(unitId) and CheckInteractDistance(unitId, 1) then
    -- default data
    local payload = {
      playerGuid = "",
      inspectUnitId = "player",
      targetName = "",
      targetLevel = "",
      targetRace = "",
      targetClass = "",
      targetGender = "",
      targetGuild = "",
      targetGuildRank = "",
      targetPvpTitle = "",
      realmName = serverName,
      scanType = "SEMI",
      timeStamp = GetServerTime(),
      targetInventory = "",
      targetTalent = "",
      targetRune = ""
    }

    payload.playerGuid = UnitGUID(unitId)
    payload.targetName = UnitName(unitId)
    payload.inspectUnitId = unitId

    -- save partial record early
    self:DBAdd(payload.playerGuid, payload)

    self:Print("Scanning: " .. payload.targetName)

    self:ScanPlayerDetails(payload.playerGuid, unitId)
    self:ScanInspectPlayer(unitId)
  end
end