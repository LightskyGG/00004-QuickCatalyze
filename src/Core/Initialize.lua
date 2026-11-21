local addonName, ns = ...

local function InitializeConfig()
	QUICKCATALYZE_CONFIG = QUICKCATALYZE_CONFIG or {}
	for key, value in pairs(ns.Defaults) do
		if QUICKCATALYZE_CONFIG[key] == nil then
			QUICKCATALYZE_CONFIG[key] = value
		end
	end
	ns.config = QUICKCATALYZE_CONFIG
end

local eventFrame = CreateFrame("Frame")
eventFrame:RegisterEvent("ADDON_LOADED")
eventFrame:SetScript("OnEvent", function(self, event, loadedAddon)
	if loadedAddon ~= addonName then return end
	self:UnregisterEvent(event)

	InitializeConfig()
	ns.InitSettings()
	ns.InitCatalyze()
end)
