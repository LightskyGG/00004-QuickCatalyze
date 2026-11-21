local addonName, ns = ...

local settingsCategory

local function GetModeOptions()
	local container = Settings.CreateControlTextContainer()
	for _, option in ipairs(ns.ModeOptions) do
		container:Add(option.value, option.label, option.tooltip)
	end
	return container:GetData()
end

function ns.InitSettings()
	local category = Settings.RegisterVerticalLayoutCategory(addonName)
	ns.modeSetting = Settings.RegisterAddOnSetting(
		category,
		"QUICKCATALYZE_MODE",
		"mode",
		ns.config,
		Settings.VarType.Number,
		"Mode",
		ns.Defaults.mode
	)
	Settings.CreateDropdown(category, ns.modeSetting, GetModeOptions, "When to skip the conversion countdown.")
	Settings.RegisterAddOnCategory(category)
	settingsCategory = category
end

function QuickCatalyze_AddonCompartmentCallback()
	if settingsCategory then
		Settings.OpenToCategory(settingsCategory:GetID())
	end
end
