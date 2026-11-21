local addonName, ns = ...

local conversionType = Enum.UIItemInteractionType.ItemConversion
local interactionAddon = "Blizzard_ItemInteractionUI"

local function OnInteract(frame)
	local mode = ns.config.mode
	if mode == ns.Modes.off or frame:GetInteractionType() ~= conversionType then return end
	if mode == ns.Modes.always or not (frame:UsesCharges() or frame:CostsCurrency()) then
		frame:CompleteItemInteraction()
	end
end

local function HookInteraction()
	hooksecurefunc(ItemInteractionFrame, "InteractWithItem", OnInteract)
end

function ns.InitCatalyze()
	if C_AddOns.IsAddOnLoaded(interactionAddon) then
		return HookInteraction()
	end

	local loaderFrame = CreateFrame("Frame")
	loaderFrame:RegisterEvent("ADDON_LOADED")
	loaderFrame:SetScript("OnEvent", function(self, event, loadedAddon)
		if loadedAddon ~= interactionAddon then return end
		self:UnregisterEvent(event)
		HookInteraction()
	end)
end
