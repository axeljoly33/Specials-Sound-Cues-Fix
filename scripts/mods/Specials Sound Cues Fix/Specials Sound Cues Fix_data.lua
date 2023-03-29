local mod = get_mod("Specials Sound Cues Fix")

return {
	name = " Specials Sound Cues Fix",
	description = mod:localize("mod_description"),
	is_togglable = true,
	options = {
		widgets = {
			{
				setting_id  = "packmaster_group",
				type        = "group",
				sub_widgets = {
					{
						setting_id    = "sscf_enemy_packmaster_foley",
						type          = "checkbox",
						default_value = true,
						sub_widgets   = {
							{
								setting_id    = "sscf_enemy_packmaster_foley_volume",
								type          = "numeric",
								default_value = 0,
								range         = {0, 24},
								unit_text     = "sscf_unit_db"
							},
							{
								setting_id  = "packmaster_test_group",
								type        = "group",
								sub_widgets = {
									{
										setting_id    = "sscf_test_enemy_packmaster_foley",
										type          = "checkbox",
										default_value = false
									}
								}
							}
						}
					}
				}
			},
			{
				setting_id  = "leech_group",
				type        = "group",
				sub_widgets = {
					{
						setting_id    = "sscf_enemy_chaos_sorcerer_magic_teleport",
						type          = "checkbox",
						default_value = true,
						sub_widgets   = {
							{
								setting_id    = "sscf_enemy_chaos_sorcerer_magic_teleport_volume",
								type          = "numeric",
								default_value = 0,
								range         = {0, 24},
								unit_text     = "sscf_unit_db"
							},
							{
								setting_id  = "leech_test_group",
								type        = "group",
								sub_widgets = {
									{
										setting_id    = "sscf_test_enemy_chaos_sorcerer_magic_teleport",
										type          = "checkbox",
										default_value = false
									}
								}
							}
						}
					}
				}
			}
		}
	}
}
	