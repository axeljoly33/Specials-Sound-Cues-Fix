return {
	run = function()
		fassert(rawget(_G, "new_mod"), "`Specials Sound Cues Fix` mod must be lower than Vermintide Mod Framework in your launcher's load order.")

		new_mod("Specials Sound Cues Fix", {
			mod_script       = "scripts/mods/Specials Sound Cues Fix/Specials Sound Cues Fix",
			mod_data         = "scripts/mods/Specials Sound Cues Fix/Specials Sound Cues Fix_data",
			mod_localization = "scripts/mods/Specials Sound Cues Fix/Specials Sound Cues Fix_localization",
		})
	end,
	packages = {
		"resource_packages/Specials Sound Cues Fix/Specials Sound Cues Fix",
	},
}
