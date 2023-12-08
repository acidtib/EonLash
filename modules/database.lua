EonLash = LibStub("AceAddon-3.0"):GetAddon("EonLash")

-- add item
function EonLash:DBAdd(index, entry)
  EonLashDB[index] = entry
end

-- get item
function EonLash:DBGet(index)
  return EonLashDB[index]
end

-- clear database
function EonLash:DBClear()
  wipe(EonLashDB)
end

-- return count of items in database
function EonLash:DBCount()
  local count = 0
  for _ in pairs(EonLashDB) do count = count + 1 end
  return count
end