local ADDON = ...

local OFF, FREE, ALWAYS = 0, 1, 2
local MODE_NAMES = { [OFF] = "off", [FREE] = "free", [ALWAYS] = "always" }
local CONVERSION = Enum.UIItemInteractionType.ItemConversion

local mode = FREE

local function OnInteract(frame)
  if mode == OFF or frame:GetInteractionType() ~= CONVERSION then return end
  if mode == ALWAYS or not (frame:UsesCharges() or frame:CostsCurrency()) then
    frame:CompleteItemInteraction()
  end
end

local function Hook()
  hooksecurefunc(ItemInteractionFrame, "InteractWithItem", OnInteract)
end

local loader = CreateFrame("Frame")
loader:RegisterEvent("ADDON_LOADED")
loader:SetScript("OnEvent", function(self, _, name)
  if name == ADDON then
    QUICKCATALYZE_CONFIG = QUICKCATALYZE_CONFIG or {}
    mode = QUICKCATALYZE_CONFIG.mode or FREE
    if C_AddOns.IsAddOnLoaded("Blizzard_ItemInteractionUI") then
      Hook()
      self:UnregisterEvent("ADDON_LOADED")
    end
  elseif name == "Blizzard_ItemInteractionUI" then
    Hook()
    self:UnregisterEvent("ADDON_LOADED")
  end
end)

SLASH_QUICKCATALYZE1 = "/qc"
SlashCmdList.QUICKCATALYZE = function(msg)
  local arg = strlower(strtrim(msg))
  for value, label in pairs(MODE_NAMES) do
    if arg == label then
      mode = value
      QUICKCATALYZE_CONFIG.mode = value
      break
    end
  end
  print("|cff33ff99QuickCatalyze|r: " .. MODE_NAMES[mode] .. "  (/qc off | free | always)")
end
