
-- Called when the addon is loaded
function EonLash:OnInitialize()

  -- self:RegisterComm("TalentsRequest", "OnTalentsReceived")

  self:RegisterChatCommand("eon", "SlashCommand")
end

-- Called when the addon is enabled
function EonLash:OnEnable()
  -- clean out the database
  EonLashDB = {}

  -- self:RegisterEvent("PLAYER_STARTED_MOVING")
  -- self:RegisterEvent("MAIL_SHOW")
  -- self:RegisterEvent("INSPECT_READY")
  self:RegisterEvent("UPDATE_MOUSEOVER_UNIT")

  -- self:SecureHook(EonLash, "InspectPlayer", function(e, ...)
  --   self:Print("SecureHook - InspectPlayer")
  --   print(e)
  --   local nameTalent = GetTalentInfo(1, 1, true)
  --   print(nameTalent)
  -- end)
end

-- Called when the addon is disabled
function EonLash:OnDisable()
  self:Print("adios!")
end


function EonLash:PLAYER_STARTED_MOVING(event)
  self:Print(event)
end

function EonLash:MAIL_SHOW()
  -- self:Print("Mail Shown")
  message("Send Conpollo some coins!")
end

-- function EonLash:INSPECT_READY(_, event)
--   self:Print("INSPECT_READY")
--   self:Print(_)
--   self:Print(event)
-- end

-- event trigger when mouse is over a player
function EonLash:UPDATE_MOUSEOVER_UNIT()
  local unitId = "mouseover"
  if UnitExists(unitId) and UnitIsPlayer(unitId) and CanInspect(unitId) and CheckInteractDistance(unitId, 1) then
    self:ScanPlayer(unitId)
  end

  -- ensure this is a player
  -- if UnitExists(unitId) and UnitIsPlayer(unitId) then
  --   -- grab character details
  --   local targetName = UnitName(unitId)
  --   local targetLevel = UnitLevel(unitId)
  --   local targetRace = UnitRace(unitId)
  --   local targetClass = UnitClass(unitId)
  --   local gender = UnitSex(unitId)-1

	-- 	local targetGuild, targetGuildRank = GetGuildInfo(unitId)
  --   if not targetGuild then
  --     targetGuild = ""
  --     targetGuildRank = ""
  --   end

  --   local playerGuid = UnitGUID(unitId)
	-- 	local targetInventory = ""
	-- 	local scanType = "SEMI"

  --   local pvpTitle = UnitPVPName(unitId)
  --   if pvpTitle == targetName then
  --     pvpTitle = ""
  --   else
  --     pvpTitle = string.sub(pvpTitle, 0, string.len(pvpTitle) - string.len(targetName))
  --   end

  --   self:Print("-----------------")
  --   self:Print(format("Scanned |cffff0000%s|r [%s]", targetName, scanType))

  --   self:Print("Name: " .. targetName)
  --   self:Print("Level: " .. targetLevel)
  --   self:Print("Race: " .. targetRace)
  --   self:Print("targetClass: " .. targetClass)
  --   self:Print("gender: " .. gender)

  --   self:Print("targetGuild: " .. targetGuild)
  --   self:Print("targetGuildRank: " .. targetGuildRank)
  --   self:Print("playerGuid: " .. playerGuid)
  --   self:Print("pvpTitle: " .. pvpTitle)

  --   self:Print("-----------------")

  --   local payloadData = {
  --     targetName = targetName,
  --     targetLevel = targetLevel,
  --     targetRace = targetRace,
  --     targetClass = targetClass,
  --     gender = gender,
  --     targetGuild = targetGuild,
  --     targetGuildRank = targetGuildRank,
  --     playerGuid = playerGuid,
  --     pvpTitle = pvpTitle
  --   }

  --   DB:Add(targetName, payloadData)
  --   -- EonLash.db.global.scans[targetName].targetName = targetName
  -- end
end

function EonLash:SlashCommand(msg)
	if msg == "scan" then
    -- scan players when mouse over
		self:Print("pong!")
	else

    -- scan current player and display info
    self:ScanPlayer("player")
	end
end
