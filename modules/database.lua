local _, EonLash = ...;
EonLash = LibStub("AceAddon-3.0"):GetAddon("EonLash")

DB = EonLash.db

-- add item
function DB:Add(index, entry)
  EonLashDB[index] = entry
end

-- get item
function DB:Get(index)
  return EonLashDB[index]
end

-- clear database
function DB:Clear()
  wipe(EonLashDB)
end

-- return count of items in database
function DB:Count()
  local count = 0
  for _ in pairs(EonLashDB) do count = count + 1 end
  return count
end