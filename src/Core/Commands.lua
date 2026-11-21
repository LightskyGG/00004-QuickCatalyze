local addonName, ns = ...

local function GetModeLabel(mode)
	for _, option in ipairs(ns.ModeOptions) do
		if option.value == mode then return option.label end
	end
end

SLASH_QUICKCATALYZE1 = "/qc"
SlashCmdList.QUICKCATALYZE = function(message)
	local argument = strlower(strtrim(message))
	for modeName, modeValue in pairs(ns.Modes) do
		if argument == modeName then
			ns.modeSetting:SetValue(modeValue)
			break
		end
	end
	print("|cff33ff99QuickCatalyze|r: " .. GetModeLabel(ns.config.mode) .. "  (/qc off | free | always)")
end
