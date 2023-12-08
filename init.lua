--the ace way of initializing addons, add the ace modules 
--you want to use as trailing parameters in :NewAddon()
EonLash = LibStub("AceAddon-3.0"):NewAddon("EonLash", "AceEvent-3.0", "AceConsole-3.0")

-- Addon comms prefix
EonLash.prefix = "eonlash";

-- Load AceGUI-3.0
AceGUI = LibStub("AceGUI-3.0")

-- Load LibBase64-1.0
EonLash.Base64 = LibStub("LibBase64-1.0")