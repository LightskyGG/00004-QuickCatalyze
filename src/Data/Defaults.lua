local addonName, ns = ...

ns.Modes = {
	off = 0,
	free = 1,
	always = 2,
}

ns.ModeOptions = {
	{ value = ns.Modes.off, label = "Off", tooltip = "Never skip the countdown." },
	{ value = ns.Modes.free, label = "Free only", tooltip = "Skip only when no charges or currency are spent." },
	{ value = ns.Modes.always, label = "Always", tooltip = "Always skip the countdown." },
}

ns.Defaults = {
	mode = ns.Modes.free,
}
