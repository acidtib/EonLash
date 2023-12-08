
-- Called when the addon is loaded
function EonLash:OnInitialize()

  self:RegisterChatCommand("eon", "SlashCommand")
end

-- Called when the addon is enabled
function EonLash:OnEnable()
  -- clean out the database
  EonLashDB = {}
  EonLashBeeper = false
  EonLashDataFormat = "BASE64"

  -- self:RegisterEvent("PLAYER_STARTED_MOVING")
  self:RegisterEvent("UPDATE_MOUSEOVER_UNIT")
end

-- Called when the addon is disabled
function EonLash:OnDisable()
  self:Print("adios!")
end

-- used for testing
function EonLash:PLAYER_STARTED_MOVING(event)
  self:Print(event)
end

-- event trigger when mouse is over a player
function EonLash:UPDATE_MOUSEOVER_UNIT()
  -- scan player if scan is active
  -- by default dont do anything else
  if EonLashBeeper == true then
    local unitId = "mouseover"
    -- ensure we have a player, and withing distance
    if UnitExists(unitId) and UnitIsPlayer(unitId) and CanInspect(unitId) and CheckInteractDistance(unitId, 1) then
      self:ScanPlayer(unitId)
    end
  end
end

-- handle /eon command
function EonLash:SlashCommand(msg)
	if msg == "scan" then
    -- toggle on, scan players when mouse over
		self:Print("Scanning has been enabled. You will now automatically scan players you interact with. Thank you for contributing!");
		EonLashBeeper = true;

  elseif msg == "scan.stop" then
    -- toggle off, scan players when mouse over
    self:Print("Scanning has been disabled. You will no longer automatically scan players you interact with.");
		EonLashBeeper = false;

  elseif msg == "clear" then
    -- /eon clean
    -- scan current player and display info in raw text
    EonLashDataFormat = "TEXT"
    self:ScanPlayer("player")
	else
    -- /eon command default
    -- scan current player and display info
    self:ScanPlayer("player")
	end
end
