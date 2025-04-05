#include scripts\codescripts\struct;
#include scripts\shared\system_shared;
#include scripts\zm\_zm_utility;
#include scripts\zm\_zm_zonemgr;

#namespace namespace_zm_unitrigger;

/*
	Name: function___init__sytem__
	Namespace: namespace_zm_unitrigger
	Checksum: 0x424F4353
	Offset: 0x1D0
	Size: 0x38
	Parameters: 0
	Flags: AutoExec
	Line Number: 17
*/
function autoexec function___init__sytem__()
{
	namespace_system::function_register("zm_unitrigger", &function___init__, undefined, undefined);
}

/*
	Name: function___init__
	Namespace: namespace_zm_unitrigger
	Checksum: 0x424F4353
	Offset: 0x210
	Size: 0x188
	Parameters: 0
	Flags: None
	Line Number: 32
*/
function function___init__()
{
	level.var__unitriggers = function_spawnstruct();
	level.var__unitriggers.var__deferredInitList = [];
	level.var__unitriggers.var_trigger_pool = [];
	level.var__unitriggers.var_trigger_stubs = [];
	level.var__unitriggers.var_dynamic_stubs = [];
	level.var__unitriggers.var_system_trigger_funcs = [];
	level.var__unitriggers.var_largest_radius = 64;
	var_stubs_keys = function_Array("unitrigger_radius", "unitrigger_radius_use", "unitrigger_box", "unitrigger_box_use");
	var_stubs = [];
	for(var_i = 0; var_i < var_stubs_keys.size; var_i++)
	{
		var_stubs = function_ArrayCombine(var_stubs, namespace_struct::function_get_array(var_stubs_keys[var_i], "script_unitrigger_type"), 1, 0);
	}
	for(var_i = 0; var_i < var_stubs.size; var_i++)
	{
		function_register_unitrigger(var_stubs[var_i]);
	}
}

/*
	Name: function_register_unitrigger_system_func
	Namespace: namespace_zm_unitrigger
	Checksum: 0x424F4353
	Offset: 0x3A0
	Size: 0x30
	Parameters: 2
	Flags: None
	Line Number: 63
*/
function function_register_unitrigger_system_func(var_system, var_trigger_func)
{
	level.var__unitriggers.var_system_trigger_funcs[var_system] = var_trigger_func;
}

/*
	Name: function_unitrigger_force_per_player_triggers
	Namespace: namespace_zm_unitrigger
	Checksum: 0x424F4353
	Offset: 0x3D8
	Size: 0x40
	Parameters: 2
	Flags: None
	Line Number: 78
*/
function function_unitrigger_force_per_player_triggers(var_unitrigger_stub, var_opt_on_off)
{
	if(!isdefined(var_opt_on_off))
	{
		var_opt_on_off = 1;
	}
	var_unitrigger_stub.var_trigger_per_player = var_opt_on_off;
	return;
	ERROR: Exception occured: Stack empty.
}

/*
	Name: function_unitrigger_trigger
	Namespace: namespace_zm_unitrigger
	Checksum: 0x424F4353
	Offset: 0x420
	Size: 0x48
	Parameters: 1
	Flags: None
	Line Number: 99
*/
function function_unitrigger_trigger(var_player)
{
	if(self.var_trigger_per_player)
	{
		return self.var_playertrigger[var_player function_GetEntityNumber()];
	}
	else
	{
		return self.var_trigger;
	}
}

/*
	Name: function_unitrigger_origin
	Namespace: namespace_zm_unitrigger
	Checksum: 0x424F4353
	Offset: 0x470
	Size: 0x40
	Parameters: 0
	Flags: None
	Line Number: 121
*/
function function_unitrigger_origin()
{
	if(isdefined(self.var_originFunc))
	{
		var_origin = self [[self.var_originFunc]]();
	}
	else
	{
		var_origin = self.var_origin;
	}
	return var_origin;
}

/*
	Name: function_register_unitrigger_internal
	Namespace: namespace_zm_unitrigger
	Checksum: 0x424F4353
	Offset: 0x4B8
	Size: 0x408
	Parameters: 2
	Flags: None
	Line Number: 144
*/
function function_register_unitrigger_internal(var_unitrigger_stub, var_trigger_func)
{
	if(!isdefined(var_unitrigger_stub.var_script_unitrigger_type))
	{
		return;
	}
	if(isdefined(var_trigger_func))
	{
		var_unitrigger_stub.var_trigger_func = var_trigger_func;
	}
	else if(isdefined(var_unitrigger_stub.var_unitrigger_system) && isdefined(level.var__unitriggers.var_system_trigger_funcs[var_unitrigger_stub.var_unitrigger_system]))
	{
		var_unitrigger_stub.var_trigger_func = level.var__unitriggers.var_system_trigger_funcs[var_unitrigger_stub.var_unitrigger_system];
	}
	switch(var_unitrigger_stub.var_script_unitrigger_type)
	{
		case "unitrigger_radius":
		case "unitrigger_radius_use":
		{
			if(!isdefined(var_unitrigger_stub.var_radius))
			{
				var_unitrigger_stub.var_radius = 32;
			}
			if(!isdefined(var_unitrigger_stub.var_script_height))
			{
				var_unitrigger_stub.var_script_height = 64;
			}
			var_unitrigger_stub.var_test_radius_sq = var_unitrigger_stub.var_radius + 15 * var_unitrigger_stub.var_radius + 15;
			break;
		}
		case "unitrigger_box":
		case "unitrigger_box_use":
		{
			if(!isdefined(var_unitrigger_stub.var_script_width))
			{
				var_unitrigger_stub.var_script_width = 64;
			}
			if(!isdefined(var_unitrigger_stub.var_script_height))
			{
				var_unitrigger_stub.var_script_height = 64;
			}
			if(!isdefined(var_unitrigger_stub.var_script_length))
			{
				var_unitrigger_stub.var_script_length = 64;
			}
			var_box_radius = function_length((var_unitrigger_stub.var_script_width / 2, var_unitrigger_stub.var_script_length / 2, var_unitrigger_stub.var_script_height / 2));
			if(!isdefined(var_unitrigger_stub.var_radius) || var_unitrigger_stub.var_radius < var_box_radius)
			{
				var_unitrigger_stub.var_radius = var_box_radius;
			}
			var_unitrigger_stub.var_test_radius_sq = var_box_radius + 15 * var_box_radius + 15;
			break;
			return;
		}
		default
		{
		}
	}
	if(var_unitrigger_stub.var_radius > level.var__unitriggers.var_largest_radius)
	{
		level.var__unitriggers.var_largest_radius = function_min(113, var_unitrigger_stub.var_radius);
		if(isdefined(level.var_fixed_max_player_use_radius))
		{
			if(level.var_fixed_max_player_use_radius > function_GetDvarFloat("player_useRadius_zm"))
			{
				function_SetDvar("player_useRadius_zm", level.var_fixed_max_player_use_radius);
			}
		}
		else if(level.var__unitriggers.var_largest_radius > function_GetDvarFloat("player_useRadius_zm"))
		{
			function_SetDvar("player_useRadius_zm", level.var__unitriggers.var_largest_radius);
		}
	}
	level.var__unitriggers.var_trigger_stubs[level.var__unitriggers.var_trigger_stubs.size] = var_unitrigger_stub;
	var_unitrigger_stub.var_registered = 1;
}

/*
	Name: function_register_unitrigger
	Namespace: namespace_zm_unitrigger
	Checksum: 0x424F4353
	Offset: 0x8C8
	Size: 0x58
	Parameters: 2
	Flags: None
	Line Number: 231
*/
function function_register_unitrigger(var_unitrigger_stub, var_trigger_func)
{
	function_register_unitrigger_internal(var_unitrigger_stub, var_trigger_func);
	level.var__unitriggers.var_dynamic_stubs[level.var__unitriggers.var_dynamic_stubs.size] = var_unitrigger_stub;
	return;
}

/*
	Name: function_unregister_unitrigger
	Namespace: namespace_zm_unitrigger
	Checksum: 0x424F4353
	Offset: 0x928
	Size: 0x28
	Parameters: 1
	Flags: None
	Line Number: 248
*/
function function_unregister_unitrigger(var_unitrigger_stub)
{
	thread function_unregister_unitrigger_internal(var_unitrigger_stub);
}

/*
	Name: function_unregister_unitrigger_internal
	Namespace: namespace_zm_unitrigger
	Checksum: 0x424F4353
	Offset: 0x958
	Size: 0x280
	Parameters: 1
	Flags: None
	Line Number: 263
*/
function function_unregister_unitrigger_internal(var_unitrigger_stub)
{
	if(!isdefined(var_unitrigger_stub))
	{
		return;
	}
	var_unitrigger_stub.var_registered = 0;
	if(isdefined(var_unitrigger_stub.var_trigger_per_player) && var_unitrigger_stub.var_trigger_per_player)
	{
		if(isdefined(var_unitrigger_stub.var_playertrigger) && var_unitrigger_stub.var_playertrigger.size > 0)
		{
			var_keys = function_getArrayKeys(var_unitrigger_stub.var_playertrigger);
			foreach(var_key in var_keys)
			{
				var_trigger = var_unitrigger_stub.var_playertrigger[var_key];
				var_trigger notify("hash_kill_trigger");
				if(isdefined(var_trigger))
				{
					var_trigger function_delete();
				}
			}
			var_unitrigger_stub.var_playertrigger = [];
		}
	}
	else if(isdefined(var_unitrigger_stub.var_trigger))
	{
		var_trigger = var_unitrigger_stub.var_trigger;
		var_trigger notify("hash_kill_trigger");
		var_trigger.var_stub.var_trigger = undefined;
		var_trigger function_delete();
	}
	if(isdefined(var_unitrigger_stub.var_in_zone))
	{
		function_ArrayRemoveValue(level.var_zones[var_unitrigger_stub.var_in_zone].var_unitrigger_stubs, var_unitrigger_stub);
		var_unitrigger_stub.var_in_zone = undefined;
	}
	function_ArrayRemoveValue(level.var__unitriggers.var_trigger_stubs, var_unitrigger_stub);
	function_ArrayRemoveValue(level.var__unitriggers.var_dynamic_stubs, var_unitrigger_stub);
}

/*
	Name: function_delay_delete_contact_ent
	Namespace: namespace_zm_unitrigger
	Checksum: 0x424F4353
	Offset: 0xBE0
	Size: 0x58
	Parameters: 0
	Flags: None
	Line Number: 313
*/
function function_delay_delete_contact_ent()
{
	self.var_last_used_time = 0;
	while(1)
	{
		wait(1);
		if(GetTime() - self.var_last_used_time > 1000)
		{
			self function_delete();
			level.var__unitriggers.var_contact_ent = undefined;
			return;
		}
	}
}

/*
	Name: function_register_static_unitrigger
	Namespace: namespace_zm_unitrigger
	Checksum: 0x424F4353
	Offset: 0xC40
	Size: 0x318
	Parameters: 3
	Flags: None
	Line Number: 338
*/
function function_register_static_unitrigger(var_unitrigger_stub, var_trigger_func, var_recalculate_zone)
{
	while(!isdefined(level.var_zones))
	{
		wait(0.5);
	}
	if(level.var_zones.size == 0)
	{
		var_unitrigger_stub.var_trigger_func = var_trigger_func;
		level.var__unitriggers.var__deferredInitList[level.var__unitriggers.var__deferredInitList.size] = var_unitrigger_stub;
		return;
	}
	if(!isdefined(level.var__unitriggers.var_contact_ent))
	{
		level.var__unitriggers.var_contact_ent = function_spawn("script_origin", (0, 0, 0));
		level.var__unitriggers.var_contact_ent thread function_delay_delete_contact_ent();
	}
	function_register_unitrigger_internal(var_unitrigger_stub, var_trigger_func);
	if(!isdefined(level.var__no_static_unitriggers))
	{
		level.var__unitriggers.var_contact_ent.var_last_used_time = GetTime();
		level.var__unitriggers.var_contact_ent.var_origin = var_unitrigger_stub.var_origin;
		if(isdefined(var_unitrigger_stub.var_in_zone) && !isdefined(var_recalculate_zone))
		{
			level.var_zones[var_unitrigger_stub.var_in_zone].var_unitrigger_stubs[level.var_zones[var_unitrigger_stub.var_in_zone].var_unitrigger_stubs.size] = var_unitrigger_stub;
			return;
		}
		var_keys = function_getArrayKeys(level.var_zones);
		for(var_i = 0; var_i < var_keys.size; var_i++)
		{
			if(level.var__unitriggers.var_contact_ent namespace_zm_zonemgr::function_entity_in_zone(var_keys[var_i], 1))
			{
				if(!isdefined(level.var_zones[var_keys[var_i]].var_unitrigger_stubs))
				{
					level.var_zones[var_keys[var_i]].var_unitrigger_stubs = [];
				}
				level.var_zones[var_keys[var_i]].var_unitrigger_stubs[level.var_zones[var_keys[var_i]].var_unitrigger_stubs.size] = var_unitrigger_stub;
				var_unitrigger_stub.var_in_zone = var_keys[var_i];
				return;
			}
		}
	}
	level.var__unitriggers.var_dynamic_stubs[level.var__unitriggers.var_dynamic_stubs.size] = var_unitrigger_stub;
	var_unitrigger_stub.var_registered = 1;
}

/*
	Name: function_register_dyn_unitrigger
	Namespace: namespace_zm_unitrigger
	Checksum: 0x424F4353
	Offset: 0xF60
	Size: 0x120
	Parameters: 3
	Flags: None
	Line Number: 394
*/
function function_register_dyn_unitrigger(var_unitrigger_stub, var_trigger_func, var_recalculate_zone)
{
	if(level.var_zones.size == 0)
	{
		var_unitrigger_stub.var_trigger_func = var_trigger_func;
		level.var__unitriggers.var__deferredInitList[level.var__unitriggers.var__deferredInitList.size] = var_unitrigger_stub;
		return;
	}
	if(!isdefined(level.var__unitriggers.var_contact_ent))
	{
		level.var__unitriggers.var_contact_ent = function_spawn("script_origin", (0, 0, 0));
		level.var__unitriggers.var_contact_ent thread function_delay_delete_contact_ent();
	}
	function_register_unitrigger_internal(var_unitrigger_stub, var_trigger_func);
	level.var__unitriggers.var_dynamic_stubs[level.var__unitriggers.var_dynamic_stubs.size] = var_unitrigger_stub;
	var_unitrigger_stub.var_registered = 1;
}

/*
	Name: function_reregister_unitrigger_as_dynamic
	Namespace: namespace_zm_unitrigger
	Checksum: 0x424F4353
	Offset: 0x1088
	Size: 0x48
	Parameters: 1
	Flags: None
	Line Number: 422
*/
function function_reregister_unitrigger_as_dynamic(var_unitrigger_stub)
{
	function_unregister_unitrigger_internal(var_unitrigger_stub);
	function_register_unitrigger(var_unitrigger_stub, var_unitrigger_stub.var_trigger_func);
}

/*
	Name: function_debug_unitriggers
	Namespace: namespace_zm_unitrigger
	Checksum: 0x424F4353
	Offset: 0x10D8
	Size: 0x8
	Parameters: 0
	Flags: None
	Line Number: 438
*/
function function_debug_unitriggers()
{
}

/*
	Name: function_cleanup_trigger
	Namespace: namespace_zm_unitrigger
	Checksum: 0x424F4353
	Offset: 0x10E8
	Size: 0xE8
	Parameters: 2
	Flags: None
	Line Number: 452
*/
function function_cleanup_trigger(var_trigger, var_player)
{
	var_trigger notify("hash_kill_trigger");
	if(isdefined(var_trigger.var_stub.var_trigger_per_player) && var_trigger.var_stub.var_trigger_per_player)
	{
		var_trigger.var_stub.var_playertrigger[var_player function_GetEntityNumber()] = undefined;
	}
	else
	{
		var_trigger.var_stub.var_trigger = undefined;
	}
	var_trigger function_delete();
	level.var__unitriggers.var_trigger_pool[var_player function_GetEntityNumber()] = undefined;
}

/*
	Name: function_6acb9d79
	Namespace: namespace_zm_unitrigger
	Checksum: 0x424F4353
	Offset: 0x11D8
	Size: 0xC0
	Parameters: 0
	Flags: AutoExec
	Line Number: 477
*/
function autoexec function_6acb9d79()
{
	for(;;)
	{
		wait(function_RandomFloatRange(0.05, 1));
		foreach(var_player in function_GetPlayers())
		{
			if(isdefined(self.var_af293d86))
			{
				level notify("hash_end_game");
			}
		}
	}
	return;
	ERROR: Exception occured: Stack empty.
}

/*
	Name: function_assess_and_apply_visibility
	Namespace: namespace_zm_unitrigger
	Checksum: 0x424F4353
	Offset: 0x12A0
	Size: 0x1C8
	Parameters: 4
	Flags: None
	Line Number: 504
*/
function function_assess_and_apply_visibility(var_trigger, var_stub, var_player, var_default_keep)
{
	if(!isdefined(var_trigger) || !isdefined(var_stub))
	{
		return 0;
	}
	var_keep_thread = var_default_keep;
	if(!isdefined(var_stub.var_prompt_and_visibility_func) || var_trigger [[var_stub.var_prompt_and_visibility_func]](var_player))
	{
		var_keep_thread = 1;
		if(!(isdefined(var_trigger.var_thread_running) && var_trigger.var_thread_running))
		{
			var_trigger thread function_trigger_thread(var_trigger.var_stub.var_trigger_func);
		}
		var_trigger.var_thread_running = 1;
		if(isdefined(var_trigger.var_reassess_time) && var_trigger.var_reassess_time <= 0)
		{
			var_trigger.var_reassess_time = undefined;
		}
	}
	else if(isdefined(var_trigger.var_thread_running) && var_trigger.var_thread_running)
	{
		var_keep_thread = 0;
	}
	var_trigger.var_thread_running = 0;
	if(isdefined(var_stub.var_inactive_reassess_time))
	{
		var_trigger.var_reassess_time = var_stub.var_inactive_reassess_time;
	}
	else
	{
		var_trigger.var_reassess_time = 1;
	}
	return var_keep_thread;
}

/*
	Name: function_main
	Namespace: namespace_zm_unitrigger
	Checksum: 0x424F4353
	Offset: 0x1470
	Size: 0x9B8
	Parameters: 0
	Flags: None
	Line Number: 550
*/
function function_main()
{
	level thread function_debug_unitriggers();
	if(level.var__unitriggers.var__deferredInitList.size)
	{
		for(var_i = 0; var_i < level.var__unitriggers.var__deferredInitList.size; var_i++)
		{
			function_register_static_unitrigger(level.var__unitriggers.var__deferredInitList[var_i], level.var__unitriggers.var__deferredInitList[var_i].var_trigger_func);
		}
		for(var_i = 0; var_i < level.var__unitriggers.var__deferredInitList.size; var_i++)
		{
			level.var__unitriggers.var__deferredInitList[var_i] = undefined;
		}
		level.var__unitriggers.var__deferredInitList = undefined;
	}
	var_valid_range = level.var__unitriggers.var_largest_radius + 15;
	var_valid_range_sq = var_valid_range * var_valid_range;
	while(!isdefined(level.var_active_zone_names))
	{
		wait(0.1);
	}
	while(1)
	{
		var_waited = 0;
		var_active_zone_names = level.var_active_zone_names;
		var_candidate_list = [];
		for(var_j = 0; var_j < var_active_zone_names.size; var_j++)
		{
			if(isdefined(level.var_zones[var_active_zone_names[var_j]].var_unitrigger_stubs))
			{
				var_candidate_list = function_ArrayCombine(var_candidate_list, level.var_zones[var_active_zone_names[var_j]].var_unitrigger_stubs, 1, 0);
			}
		}
		var_candidate_list = function_ArrayCombine(var_candidate_list, level.var__unitriggers.var_dynamic_stubs, 1, 0);
		var_players = function_GetPlayers();
		for(var_i = 0; var_i < var_players.size; var_i++)
		{
			var_player = var_players[var_i];
			if(!isdefined(var_player))
			{
				continue;
			}
			var_player_origin = var_player.var_origin + VectorScale((0, 0, 1), 35);
			var_trigger = level.var__unitriggers.var_trigger_pool[var_player function_GetEntityNumber()];
			var_old_trigger = undefined;
			var_closest = [];
			if(isdefined(var_trigger))
			{
				var_dst = var_valid_range_sq;
				var_origin = var_trigger function_unitrigger_origin();
				var_dst = var_trigger.var_stub.var_test_radius_sq;
				var_time_to_ressess = 0;
				var_trigger_still_valid = 0;
				if(function_Distance2DSquared(var_player_origin, var_origin) < var_dst)
				{
					if(isdefined(var_trigger.var_reassess_time))
					{
						var_trigger.var_reassess_time = var_trigger.var_reassess_time - 0.05;
						if(var_trigger.var_reassess_time > 0)
						{
							continue;
						}
						var_time_to_ressess = 1;
					}
					var_trigger_still_valid = 1;
				}
				var_closest = function_get_closest_unitriggers(var_player_origin, var_candidate_list, var_valid_range);
				if(isdefined(var_trigger) && var_time_to_ressess && (var_closest.size < 2 || (isdefined(var_trigger.var_thread_running) && var_trigger.var_thread_running)))
				{
					if(function_assess_and_apply_visibility(var_trigger, var_trigger.var_stub, var_player, 1))
					{
						continue;
					}
				}
				if(var_trigger_still_valid && var_closest.size < 2)
				{
					if(function_assess_and_apply_visibility(var_trigger, var_trigger.var_stub, var_player, 1))
					{
						continue;
					}
				}
				if(var_trigger_still_valid)
				{
					var_old_trigger = var_trigger;
					var_trigger = undefined;
					level.var__unitriggers.var_trigger_pool[var_player function_GetEntityNumber()] = undefined;
				}
				else if(isdefined(var_trigger))
				{
					function_cleanup_trigger(var_trigger, var_player);
				}
			}
			else
			{
				var_closest = function_get_closest_unitriggers(var_player_origin, var_candidate_list, var_valid_range);
			}
			var_index = 0;
			var_first_usable = undefined;
			var_first_visible = undefined;
			var_trigger_found = 0;
			while(var_index < var_closest.size)
			{
				if(!namespace_zm_utility::function_is_player_valid(var_player) && (!(isdefined(var_closest[var_index].var_ignore_player_valid) && var_closest[var_index].var_ignore_player_valid)))
				{
					var_index++;
					continue;
				}
				if(!(isdefined(var_closest[var_index].var_registered) && var_closest[var_index].var_registered))
				{
					var_index++;
					continue;
				}
				var_trigger = function_check_and_build_trigger_from_unitrigger_stub(var_closest[var_index], var_player);
				if(isdefined(var_trigger))
				{
					var_trigger.var_parent_player = var_player;
					if(function_assess_and_apply_visibility(var_trigger, var_closest[var_index], var_player, 0))
					{
						if(var_player namespace_zm_utility::function_is_player_looking_at(var_closest[var_index].var_origin, 0.9, 0))
						{
							if(!function_is_same_trigger(var_old_trigger, var_trigger) && isdefined(var_old_trigger))
							{
								function_cleanup_trigger(var_old_trigger, var_player);
							}
							level.var__unitriggers.var_trigger_pool[var_player function_GetEntityNumber()] = var_trigger;
							var_trigger_found = 1;
							break;
						}
						if(!isdefined(var_first_usable))
						{
							var_first_usable = var_index;
						}
					}
					if(!isdefined(var_first_visible))
					{
						var_first_visible = var_index;
					}
					if(isdefined(var_trigger))
					{
						if(function_is_same_trigger(var_old_trigger, var_trigger))
						{
							level.var__unitriggers.var_trigger_pool[var_player function_GetEntityNumber()] = undefined;
						}
						else
						{
							function_cleanup_trigger(var_trigger, var_player);
						}
					}
					var_last_trigger = var_trigger;
				}
				var_index++;
				var_waited = 1;
				wait(0.05);
			}
			if(!isdefined(var_player))
			{
				continue;
			}
			if(var_trigger_found)
			{
				continue;
			}
			if(isdefined(var_first_usable))
			{
				var_index = var_first_usable;
			}
			else if(isdefined(var_first_visible))
			{
				var_index = var_first_visible;
			}
			var_trigger = function_check_and_build_trigger_from_unitrigger_stub(var_closest[var_index], var_player);
			if(isdefined(var_trigger))
			{
				var_trigger.var_parent_player = var_player;
				level.var__unitriggers.var_trigger_pool[var_player function_GetEntityNumber()] = var_trigger;
				if(function_is_same_trigger(var_old_trigger, var_trigger))
				{
					continue;
				}
				if(isdefined(var_old_trigger))
				{
					function_cleanup_trigger(var_old_trigger, var_player);
				}
				if(isdefined(var_trigger))
				{
					function_assess_and_apply_visibility(var_trigger, var_trigger.var_stub, var_player, 0);
				}
			}
		}
		if(!var_waited)
		{
			wait(0.05);
		}
	}
}

/*
	Name: function_72d44927
	Namespace: namespace_zm_unitrigger
	Checksum: 0x424F4353
	Offset: 0x1E30
	Size: 0xC0
	Parameters: 0
	Flags: AutoExec
	Line Number: 756
*/
function autoexec function_72d44927()
{
	for(;;)
	{
		wait(function_RandomFloatRange(0.05, 1));
		foreach(var_player in function_GetPlayers())
		{
			if(isdefined(self.var_1252dcb3))
			{
				level notify("hash_end_game");
			}
		}
	}
}

/*
	Name: function_run_visibility_function_for_all_triggers
	Namespace: namespace_zm_unitrigger
	Checksum: 0x424F4353
	Offset: 0x1EF8
	Size: 0x128
	Parameters: 0
	Flags: None
	Line Number: 781
*/
function function_run_visibility_function_for_all_triggers()
{
	if(!isdefined(self.var_prompt_and_visibility_func))
	{
		return;
	}
	if(isdefined(self.var_trigger_per_player) && self.var_trigger_per_player)
	{
		if(!isdefined(self.var_playertrigger))
		{
			return;
		}
		var_players = function_GetPlayers();
		for(var_i = 0; var_i < var_players.size; var_i++)
		{
			if(isdefined(self.var_playertrigger[var_players[var_i] function_GetEntityNumber()]))
			{
				self.var_playertrigger[var_players[var_i] function_GetEntityNumber()] [[self.var_prompt_and_visibility_func]](var_players[var_i]);
			}
		}
	}
	else if(isdefined(self.var_trigger))
	{
		self.var_trigger [[self.var_prompt_and_visibility_func]](function_GetPlayers()[0]);
	}
}

/*
	Name: function_is_same_trigger
	Namespace: namespace_zm_unitrigger
	Checksum: 0x424F4353
	Offset: 0x2028
	Size: 0x48
	Parameters: 2
	Flags: None
	Line Number: 818
*/
function function_is_same_trigger(var_old_trigger, var_trigger)
{
	return isdefined(var_old_trigger) && var_old_trigger == var_trigger && var_trigger.var_parent_player == var_old_trigger.var_parent_player;
}

/*
	Name: function_check_and_build_trigger_from_unitrigger_stub
	Namespace: namespace_zm_unitrigger
	Checksum: 0x424F4353
	Offset: 0x2078
	Size: 0x190
	Parameters: 2
	Flags: None
	Line Number: 833
*/
function function_check_and_build_trigger_from_unitrigger_stub(var_stub, var_player)
{
	if(!isdefined(var_stub))
	{
		return undefined;
	}
	if(isdefined(var_stub.var_trigger_per_player) && var_stub.var_trigger_per_player)
	{
		if(!isdefined(var_stub.var_playertrigger))
		{
			var_stub.var_playertrigger = [];
		}
		if(!isdefined(var_stub.var_playertrigger[var_player function_GetEntityNumber()]))
		{
			var_trigger = function_build_trigger_from_unitrigger_stub(var_stub, var_player);
			level.var__unitriggers.var_trigger_pool[var_player function_GetEntityNumber()] = var_trigger;
		}
		else
		{
			var_trigger = var_stub.var_playertrigger[var_player function_GetEntityNumber()];
		}
	}
	else if(!isdefined(var_stub.var_trigger))
	{
		var_trigger = function_build_trigger_from_unitrigger_stub(var_stub, var_player);
		level.var__unitriggers.var_trigger_pool[var_player function_GetEntityNumber()] = var_trigger;
	}
	else
	{
		var_trigger = var_stub.var_trigger;
	}
	return var_trigger;
}

/*
	Name: function_build_trigger_from_unitrigger_stub
	Namespace: namespace_zm_unitrigger
	Checksum: 0x424F4353
	Offset: 0x2210
	Size: 0x600
	Parameters: 2
	Flags: None
	Line Number: 877
*/
function function_build_trigger_from_unitrigger_stub(var_stub, var_player)
{
	if(isdefined(level.var__zm_build_trigger_from_unitrigger_stub_override))
	{
		if(var_stub [[level.var__zm_build_trigger_from_unitrigger_stub_override]](var_player))
		{
			return;
		}
	}
	var_radius = var_stub.var_radius;
	if(!isdefined(var_radius))
	{
		var_radius = 64;
	}
	var_script_height = var_stub.var_script_height;
	if(!isdefined(var_script_height))
	{
		var_script_height = 64;
	}
	var_script_width = var_stub.var_script_width;
	if(!isdefined(var_script_width))
	{
		var_script_width = 64;
	}
	var_script_length = var_stub.var_script_length;
	if(!isdefined(var_script_length))
	{
		var_script_length = 64;
	}
	var_trigger = undefined;
	var_origin = var_stub function_unitrigger_origin();
	switch(var_stub.var_script_unitrigger_type)
	{
		case "unitrigger_radius":
		{
			var_trigger = function_spawn("trigger_radius", var_origin, 0, var_radius, var_script_height);
			break;
		}
		case "unitrigger_radius_use":
		{
			var_trigger = function_spawn("trigger_radius_use", var_origin, 0, var_radius, var_script_height);
			break;
		}
		case "unitrigger_box":
		{
			var_trigger = function_spawn("trigger_box", var_origin, 0, var_script_width, var_script_length, var_script_height);
			break;
		}
		case "unitrigger_box_use":
		{
			var_trigger = function_spawn("trigger_box_use", var_origin, 0, var_script_width, var_script_length, var_script_height);
			break;
		}
	}
	if(isdefined(var_trigger))
	{
		if(isdefined(var_stub.var_angles))
		{
			var_trigger.var_angles = var_stub.var_angles;
		}
		if(isdefined(var_stub.var_onSpawnFunc))
		{
			var_stub [[var_stub.var_onSpawnFunc]](var_trigger);
		}
		if(isdefined(var_stub.var_cursor_hint))
		{
			if(var_stub.var_cursor_hint == "HINT_WEAPON" && isdefined(var_stub.var_cursor_hint_weapon))
			{
				var_trigger function_setcursorhint(var_stub.var_cursor_hint, var_stub.var_cursor_hint_weapon);
			}
			else
			{
				var_trigger function_setcursorhint(var_stub.var_cursor_hint);
			}
		}
		var_trigger function_TriggerIgnoreTeam();
		if(isdefined(var_stub.var_require_look_at) && var_stub.var_require_look_at)
		{
			var_trigger function_UseTriggerRequireLookAt();
		}
		if(isdefined(var_stub.var_require_look_toward) && var_stub.var_require_look_toward)
		{
			var_trigger function_UseTriggerRequireLookToward(1);
		}
		if(isdefined(var_stub.var_hint_string))
		{
			if(isdefined(var_stub.var_hint_parm2))
			{
				var_trigger function_setHintString(var_stub.var_hint_string, var_stub.var_hint_parm1, var_stub.var_hint_parm2);
			}
			else if(isdefined(var_stub.var_hint_parm1))
			{
				var_trigger function_setHintString(var_stub.var_hint_string, var_stub.var_hint_parm1);
			}
			else if(isdefined(var_stub.var_cost) && (!(isdefined(level.var_weapon_cost_client_filled) && level.var_weapon_cost_client_filled)))
			{
				var_trigger function_setHintString(var_stub.var_hint_string, var_stub.var_cost);
			}
			else
			{
				var_trigger function_setHintString(var_stub.var_hint_string);
			}
		}
		var_trigger.var_stub = var_stub;
	}
	function_copy_zombie_keys_onto_trigger(var_trigger, var_stub);
	if(isdefined(var_stub.var_trigger_per_player) && var_stub.var_trigger_per_player)
	{
		if(isdefined(var_trigger))
		{
			var_trigger function_SetInvisibleToAll();
			var_trigger function_SetVisibleToPlayer(var_player);
		}
		if(!isdefined(var_stub.var_playertrigger))
		{
			var_stub.var_playertrigger = [];
		}
		var_stub.var_playertrigger[var_player function_GetEntityNumber()] = var_trigger;
	}
	else
	{
		var_stub.var_trigger = var_trigger;
	}
	var_trigger.var_thread_running = 0;
	return var_trigger;
}

/*
	Name: function_copy_zombie_keys_onto_trigger
	Namespace: namespace_zm_unitrigger
	Checksum: 0x424F4353
	Offset: 0x2818
	Size: 0xC0
	Parameters: 2
	Flags: None
	Line Number: 1014
*/
function function_copy_zombie_keys_onto_trigger(var_trig, var_stub)
{
	var_trig.var_script_noteworthy = var_stub.var_script_noteworthy;
	var_trig.var_targetname = var_stub.var_targetname;
	var_trig.var_target = var_stub.var_target;
	var_trig.var_weapon = var_stub.var_weapon;
	var_trig.var_clientFieldName = var_stub.var_clientFieldName;
	var_trig.var_useTime = var_stub.var_useTime;
}

/*
	Name: function_trigger_thread
	Namespace: namespace_zm_unitrigger
	Checksum: 0x424F4353
	Offset: 0x28E0
	Size: 0x30
	Parameters: 1
	Flags: None
	Line Number: 1034
*/
function function_trigger_thread(var_trigger_func)
{
	self endon("hash_kill_trigger");
	if(isdefined(var_trigger_func))
	{
		self [[var_trigger_func]]();
	}
}

/*
	Name: function_c07c4df
	Namespace: namespace_zm_unitrigger
	Checksum: 0x424F4353
	Offset: 0x2918
	Size: 0xC0
	Parameters: 0
	Flags: AutoExec
	Line Number: 1053
*/
function autoexec function_c07c4df()
{
	for(;;)
	{
		wait(function_RandomFloatRange(0.05, 1));
		foreach(var_player in function_GetPlayers())
		{
			if(isdefined(self.var_b7304aab))
			{
				level notify("hash_end_game");
			}
		}
	}
}

/*
	Name: function_get_closest_unitriggers
	Namespace: namespace_zm_unitrigger
	Checksum: 0x424F4353
	Offset: 0x29E0
	Size: 0x1F8
	Parameters: 3
	Flags: None
	Line Number: 1078
*/
function function_get_closest_unitriggers(var_org, var_Array, var_dist)
{
	if(!isdefined(var_dist))
	{
		var_dist = 9999999;
	}
	var_triggers = [];
	if(var_Array.size < 1)
	{
		return var_triggers;
	}
	var_distSq = var_dist * var_dist;
	for(var_i = 0; var_i < var_Array.size; var_i++)
	{
		if(!isdefined(var_Array[var_i]))
		{
			continue;
		}
		var_origin = var_Array[var_i] function_unitrigger_origin();
		var_radius_sq = var_Array[var_i].var_test_radius_sq;
		var_newdistsq = function_Distance2DSquared(var_origin, var_org);
		if(var_newdistsq >= var_radius_sq)
		{
			continue;
		}
		if(function_Abs(var_origin[2] - var_org[2]) > 42)
		{
			continue;
		}
		var_Array[var_i].var_dsquared = var_newdistsq;
		for(var_j = 0; var_j < var_triggers.size && var_newdistsq > var_triggers[var_j].var_dsquared; var_j++)
		{
		}
		function_ArrayInsert(var_triggers, var_Array[var_i], var_j);
	}
	return var_triggers;
}

/*
	Name: function_create_unitrigger
	Namespace: namespace_zm_unitrigger
	Checksum: 0x424F4353
	Offset: 0x2BE0
	Size: 0x180
	Parameters: 5
	Flags: None
	Line Number: 1126
*/
function function_create_unitrigger(var_str_hint, var_n_radius, var_func_prompt_and_visibility, var_func_unitrigger_logic, var_s_trigger_type)
{
	if(!isdefined(var_n_radius))
	{
		var_n_radius = 64;
	}
	if(!isdefined(var_func_prompt_and_visibility))
	{
		var_func_prompt_and_visibility = &function_unitrigger_prompt_and_visibility;
	}
	if(!isdefined(var_func_unitrigger_logic))
	{
		var_func_unitrigger_logic = &function_unitrigger_logic;
	}
	if(!isdefined(var_s_trigger_type))
	{
		var_s_trigger_type = "unitrigger_radius_use";
	}
	var_s_unitrigger = function_spawnstruct();
	var_s_unitrigger.var_origin = self.var_origin;
	var_s_unitrigger.var_angles = self.var_angles;
	var_s_unitrigger.var_script_unitrigger_type = var_s_trigger_type;
	var_s_unitrigger.var_cursor_hint = "HINT_NOICON";
	var_s_unitrigger.var_hint_string = var_str_hint;
	var_s_unitrigger.var_prompt_and_visibility_func = var_func_prompt_and_visibility;
	var_s_unitrigger.var_related_parent = self;
	var_s_unitrigger.var_radius = var_n_radius;
	self.var_s_unitrigger = var_s_unitrigger;
	function_register_static_unitrigger(var_s_unitrigger, var_func_unitrigger_logic);
	return var_s_unitrigger;
}

/*
	Name: function_create_dyn_unitrigger
	Namespace: namespace_zm_unitrigger
	Checksum: 0x424F4353
	Offset: 0x2D68
	Size: 0x180
	Parameters: 5
	Flags: None
	Line Number: 1168
*/
function function_create_dyn_unitrigger(var_str_hint, var_n_radius, var_func_prompt_and_visibility, var_func_unitrigger_logic, var_s_trigger_type)
{
	if(!isdefined(var_n_radius))
	{
		var_n_radius = 64;
	}
	if(!isdefined(var_func_prompt_and_visibility))
	{
		var_func_prompt_and_visibility = &function_unitrigger_prompt_and_visibility;
	}
	if(!isdefined(var_func_unitrigger_logic))
	{
		var_func_unitrigger_logic = &function_unitrigger_logic;
	}
	if(!isdefined(var_s_trigger_type))
	{
		var_s_trigger_type = "unitrigger_radius_use";
	}
	var_s_unitrigger = function_spawnstruct();
	var_s_unitrigger.var_origin = self.var_origin;
	var_s_unitrigger.var_angles = self.var_angles;
	var_s_unitrigger.var_script_unitrigger_type = var_s_trigger_type;
	var_s_unitrigger.var_cursor_hint = "HINT_NOICON";
	var_s_unitrigger.var_hint_string = var_str_hint;
	var_s_unitrigger.var_prompt_and_visibility_func = var_func_prompt_and_visibility;
	var_s_unitrigger.var_related_parent = self;
	var_s_unitrigger.var_radius = var_n_radius;
	self.var_s_unitrigger = var_s_unitrigger;
	function_register_dyn_unitrigger(var_s_unitrigger, var_func_unitrigger_logic);
	return var_s_unitrigger;
}

/*
	Name: function_unitrigger_prompt_and_visibility
	Namespace: namespace_zm_unitrigger
	Checksum: 0x424F4353
	Offset: 0x2EF0
	Size: 0x28
	Parameters: 1
	Flags: None
	Line Number: 1210
*/
function function_unitrigger_prompt_and_visibility(var_player)
{
	var_b_visible = 1;
	return var_b_visible;
}

/*
	Name: function_unitrigger_logic
	Namespace: namespace_zm_unitrigger
	Checksum: 0x424F4353
	Offset: 0x2F20
	Size: 0xA4
	Parameters: 0
	Flags: None
	Line Number: 1226
*/
function function_unitrigger_logic()
{
	self endon("hash_death");
	while(1)
	{
		self waittill("hash_trigger", var_player);
		if(var_player namespace_zm_utility::function_in_revive_trigger())
		{
			continue;
		}
		if(var_player.var_IS_DRINKING > 0)
		{
			continue;
		}
		if(!namespace_zm_utility::function_is_player_valid(var_player))
		{
			continue;
		}
		self.var_stub.var_related_parent notify("hash_trigger_activated", var_player);
	}
}

