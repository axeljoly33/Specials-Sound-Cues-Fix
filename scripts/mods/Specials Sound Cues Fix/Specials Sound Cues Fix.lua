local mod = get_mod("Specials Sound Cues Fix")

--#############################################################################################################################################################################
--#############################################################################################################################################################################
--#############################################################################################################################################################################

-----------
-- BANKS --
-----------

-- Packmaster
Wwise.load_bank("wwise/ssfx_enemy_packmaster_foley")
-- Leech
Wwise.load_bank("wwise/ssfx_enemy_chaos_sorcerer_magic_teleport")

--#############################################################################################################################################################################
--#############################################################################################################################################################################
--#############################################################################################################################################################################

mod.start_game = false

mod.on_game_state_changed = function(self, state_name, status)
    if state_name == "StateIngame" then
        if not mod.start_game then
            mod.start_game = true
            -- Managers.level_transition_handler.enemy_package_loader:_load_startup_enemy_packages()
            if not Managers.level_transition_handler.enemy_package_loader.breed_processed["skaven_pack_master"] then
                Managers.level_transition_handler.enemy_package_loader:request_breed("skaven_pack_master", false)
            end
            if not Managers.level_transition_handler.enemy_package_loader.breed_processed["chaos_corruptor_sorcerer"] then
                Managers.level_transition_handler.enemy_package_loader:request_breed("chaos_corruptor_sorcerer", false)
            end
        end
    end
end

mod.sscf_split_volume = function(self, event_name_volume, vv)
    local sscf_volume = mod:get(event_name_volume)

    if vv then
        if (tonumber(sscf_volume) >= 12) then
            return 12
        else
            return tonumber(sscf_volume)
        end
    end
    
    if not vv then
        if (tonumber(sscf_volume) > 12) then
            return (tonumber(sscf_volume) - 12)
        else
            return 0
        end
    end
end

mod.on_setting_changed = function(self)
    -- ###############
    -- # Hookrats
    WwiseWorld.set_global_parameter(Wwise.wwise_world(Managers.world:world("level_world")), "ssfx_enemy_packmaster_foley_vv", mod:sscf_split_volume("sscf_enemy_packmaster_foley_volume", true))
    WwiseWorld.set_global_parameter(Wwise.wwise_world(Managers.world:world("level_world")), "ssfx_enemy_packmaster_foley_bv", mod:sscf_split_volume("sscf_enemy_packmaster_foley_volume", false))

    -- ###############
    -- # Leech
    WwiseWorld.set_global_parameter(Wwise.wwise_world(Managers.world:world("level_world")), "ssfx_enemy_chaos_sorcerer_magic_teleport_vv", mod:sscf_split_volume("sscf_enemy_chaos_sorcerer_magic_teleport_volume", true))
    WwiseWorld.set_global_parameter(Wwise.wwise_world(Managers.world:world("level_world")), "ssfx_enemy_chaos_sorcerer_magic_teleport_bv", mod:sscf_split_volume("sscf_enemy_chaos_sorcerer_magic_teleport_volume", false))
end

mod.update = function(self)
    -- ###############
    -- # Hookrats
    if mod:get("sscf_test_enemy_packmaster_foley") then
        WwiseWorld.trigger_event(Wwise.wwise_world(Managers.world:world("level_world")), "ssfx_enemy_packmaster_foley")
        mod:set("sscf_test_enemy_packmaster_foley", false)
    end

    -- ###############
    -- # Leech
    if mod:get("sscf_test_enemy_chaos_sorcerer_magic_teleport") then
        WwiseWorld.trigger_event(Wwise.wwise_world(Managers.world:world("level_world")), "ssfx_enemy_chaos_sorcerer_magic_teleport")
        mod:set("sscf_test_enemy_chaos_sorcerer_magic_teleport", false)
    end
end

mod:hook_safe(BTQuickTeleportAction, "play_teleport_effect", function (self, unit, blackboard, start_position, end_position, ...)
    if mod:get("sscf_enemy_chaos_sorcerer_magic_teleport") then
        if unit then
            if Unit.get_data(unit, "breed") then
                if Unit.get_data(unit, "breed").name == "chaos_corruptor_sorcerer" then
                    mod.leech_tp_x = end_position.x
                    mod.leech_tp_y = end_position.y
                    mod.leech_tp_z = end_position.z
                end
            end
        end
    end
end)

--#############################################################################################################################################################################
--#############################################################################################################################################################################
--#############################################################################################################################################################################

--------------
-- REGISTER --
--------------

mod.leech_tp_x = 0.0
mod.leech_tp_y = 0.0
mod.leech_tp_z = 0.0

mod:hook(WwiseWorld, "trigger_event", function (func, self, event_name, ...)
    if event_name == "enemy_packmaster_foley" then
        if mod:get("sscf_enemy_packmaster_foley") then
            if Managers.state.unit_storage.map_goid_to_unit then
                for key,value in pairs(Managers.state.unit_storage.map_goid_to_unit) do
                    if Unit.get_data(value, "breed") then
                        if Unit.get_data(value, "breed").name == "skaven_pack_master" then
                            if not ScriptUnit.extension(value, "health_system").dead then
                                WwiseWorld.set_global_parameter(Wwise.wwise_world(Managers.world:world("level_world")), "ssfx_enemy_packmaster_foley_vv", mod:sscf_split_volume("sscf_enemy_packmaster_foley_volume", true))
                                WwiseWorld.set_global_parameter(Wwise.wwise_world(Managers.world:world("level_world")), "ssfx_enemy_packmaster_foley_bv", mod:sscf_split_volume("sscf_enemy_packmaster_foley_volume", false))
                                WwiseWorld.trigger_event(Wwise.wwise_world(Managers.world:world("level_world")), "ssfx_enemy_packmaster_foley", value)
                            end
                        end
                    end
                end
            end
        else
            return func(self, event_name, ...)
        end
    elseif event_name == "enemy_chaos_sorcerer_magic_teleport" then
        if mod:get("sscf_enemy_chaos_sorcerer_magic_teleport") then
            WwiseWorld.set_global_parameter(Wwise.wwise_world(Managers.world:world("level_world")), "ssfx_enemy_chaos_sorcerer_magic_teleport_vv", mod:sscf_split_volume("sscf_enemy_chaos_sorcerer_magic_teleport_volume", true))
            WwiseWorld.set_global_parameter(Wwise.wwise_world(Managers.world:world("level_world")), "ssfx_enemy_chaos_sorcerer_magic_teleport_bv", mod:sscf_split_volume("sscf_enemy_chaos_sorcerer_magic_teleport_volume", false))
            WwiseWorld.trigger_event(Wwise.wwise_world(Managers.world:world("level_world")), "ssfx_enemy_chaos_sorcerer_magic_teleport", Vector3(mod.leech_tp_x, mod.leech_tp_y, mod.leech_tp_z))
        else
            return func(self, event_name, ...)
        end
    else
        return func(self, event_name, ...)
    end
end)

--#############################################################################################################################################################################
--#############################################################################################################################################################################
--#############################################################################################################################################################################