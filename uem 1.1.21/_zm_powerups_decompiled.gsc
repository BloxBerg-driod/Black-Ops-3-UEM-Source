#include scripts\codescripts\struct;
#include scripts\shared\ai\systems\gib;
#include scripts\shared\ai\zombie_utility;
#include scripts\shared\array_shared;
#include scripts\shared\callbacks_shared;
#include scripts\shared\clientfield_shared;
#include scripts\shared\demo_shared;
#include scripts\shared\flag_shared;
#include scripts\shared\flagsys_shared;
#include scripts\shared\hud_util_shared;
#include scripts\shared\laststand_shared;
#include scripts\shared\util_shared;
#include scripts\zm\_util;
#include scripts\zm\_zm_audio;
#include scripts\zm\_zm_bgb;
#include scripts\zm\_zm_blockers;
#include scripts\zm\_zm_laststand;
#include scripts\zm\_zm_magicbox;
#include scripts\zm\_zm_melee_weapon;
#include scripts\zm\_zm_net;
#include scripts\zm\_zm_perks;
#include scripts\zm\_zm_pers_upgrades;
#include scripts\zm\_zm_pers_upgrades_functions;
#include scripts\zm\_zm_score;
#include scripts\zm\_zm_spawner;
#include scripts\zm\_zm_stats;
#include scripts\zm\_zm_utility;
#include scripts\zm\_zm_weapons;

#namespace namespace_zm_powerups;

/*
	Name: function_init
	Namespace: namespace_zm_powerups
	Checksum: 0x424F4353
	Offset: 0xB70
	Size: 0x350
	Parameters: 0
	Flags: None
	Line Number: 41
*/
function function_init()
{
	namespace_zombie_utility::function_set_zombie_var("zombie_insta_kill", 0, undefined, undefined, 1);
	namespace_zombie_utility::function_set_zombie_var("zombie_point_scalar", 1, undefined, undefined, 1);
	namespace_zombie_utility::function_set_zombie_var("zombie_drop_item", 0);
	namespace_zombie_utility::function_set_zombie_var("zombie_timer_offset", 350);
	namespace_zombie_utility::function_set_zombie_var("zombie_timer_offset_interval", 30);
	namespace_zombie_utility::function_set_zombie_var("zombie_powerup_fire_sale_on", 0);
	namespace_zombie_utility::function_set_zombie_var("zombie_powerup_fire_sale_time", 30);
	namespace_zombie_utility::function_set_zombie_var("zombie_powerup_bonfire_sale_on", 0);
	namespace_zombie_utility::function_set_zombie_var("zombie_powerup_bonfire_sale_time", 30);
	namespace_zombie_utility::function_set_zombie_var("zombie_powerup_insta_kill_on", 0, undefined, undefined, 1);
	namespace_zombie_utility::function_set_zombie_var("zombie_powerup_insta_kill_time", 30, undefined, undefined, 1);
	namespace_zombie_utility::function_set_zombie_var("zombie_powerup_double_points_on", 0, undefined, undefined, 1);
	namespace_zombie_utility::function_set_zombie_var("zombie_powerup_double_points_time", 30, undefined, undefined, 1);
	namespace_zombie_utility::function_set_zombie_var("zombie_powerup_drop_increment", 2000);
	namespace_zombie_utility::function_set_zombie_var("zombie_powerup_drop_max_per_round", 4);
	namespace_callback::function_on_connect(&function_init_player_zombie_vars);
	level.var__effect["powerup_on"] = "zombie/fx_powerup_on_green_zmb";
	level.var__effect["powerup_off"] = "zombie/fx_powerup_off_green_zmb";
	level.var__effect["powerup_grabbed"] = "zombie/fx_powerup_grab_green_zmb";
	if(isdefined(level.var_using_zombie_powerups) && level.var_using_zombie_powerups)
	{
		level.var__effect["powerup_on_red"] = "zombie/fx_powerup_on_red_zmb";
		level.var__effect["powerup_grabbed_red"] = "zombie/fx_powerup_grab_red_zmb";
	}
	level.var__effect["powerup_on_solo"] = "zombie/fx_powerup_on_solo_zmb";
	level.var__effect["powerup_grabbed_solo"] = "zombie/fx_powerup_grab_solo_zmb";
	level.var__effect["powerup_on_caution"] = "zombie/fx_powerup_on_caution_zmb";
	level.var__effect["powerup_grabbed_caution"] = "zombie/fx_powerup_grab_caution_zmb";
	function_init_powerups();
	if(!level.var_enable_magic)
	{
		return;
	}
	thread function_watch_for_drop();
	return;
}

/*
	Name: function_init_powerups
	Namespace: namespace_zm_powerups
	Checksum: 0x424F4353
	Offset: 0xEC8
	Size: 0x180
	Parameters: 0
	Flags: None
	Line Number: 90
*/
function function_init_powerups()
{
	level namespace_flag::function_init("zombie_drop_powerups");
	if(isdefined(level.var_enable_magic) && level.var_enable_magic)
	{
		level namespace_flag::function_set("zombie_drop_powerups");
	}
	if(!isdefined(level.var_active_powerups))
	{
		level.var_active_powerups = [];
	}
	function_add_zombie_powerup("insta_kill_ug", "zombie_skull", &"ZOMBIE_POWERUP_INSTA_KILL", &function_func_should_never_drop, 1, 0, 0, undefined, "powerup_instant_kill_ug", "zombie_powerup_insta_kill_ug_time", "zombie_powerup_insta_kill_ug_on", 1);
	if(isdefined(level.var_level_specific_init_powerups))
	{
		[[level.var_level_specific_init_powerups]]();
	}
	function_randomize_powerups();
	level.var_zombie_powerup_index = 0;
	function_randomize_powerups();
	level.var_rare_powerups_active = 0;
	level.var_firesale_vox_firstime = 0;
	level thread function_powerup_hud_monitor();
	namespace_clientfield::function_register("scriptmover", "powerup_fx", 1, 3, "int");
}

/*
	Name: function_init_player_zombie_vars
	Namespace: namespace_zm_powerups
	Checksum: 0x424F4353
	Offset: 0x1050
	Size: 0x38
	Parameters: 0
	Flags: None
	Line Number: 125
*/
function function_init_player_zombie_vars()
{
	self.var_zombie_vars["zombie_powerup_insta_kill_ug_on"] = 0;
	self.var_zombie_vars["zombie_powerup_insta_kill_ug_time"] = 18;
}

/*
	Name: function_set_weapon_ignore_max_ammo
	Namespace: namespace_zm_powerups
	Checksum: 0x424F4353
	Offset: 0x1090
	Size: 0x38
	Parameters: 1
	Flags: None
	Line Number: 141
*/
function function_set_weapon_ignore_max_ammo(var_weapon)
{
	if(!isdefined(level.var_zombie_weapons_no_max_ammo))
	{
		level.var_zombie_weapons_no_max_ammo = [];
	}
	level.var_zombie_weapons_no_max_ammo[var_weapon] = 1;
}

/*
	Name: function_powerup_hud_monitor
	Namespace: namespace_zm_powerups
	Checksum: 0x424F4353
	Offset: 0x10D0
	Size: 0x5E0
	Parameters: 0
	Flags: None
	Line Number: 160
*/
function function_powerup_hud_monitor()
{
	level namespace_flag::function_wait_till("start_zombie_round_logic");
	if(isdefined(level.var_current_game_module) && level.var_current_game_module == 2)
	{
		return;
	}
	var_flashing_timers = [];
	var_flashing_values = [];
	var_flashing_timer = 10;
	var_flashing_delta_time = 0;
	var_flashing_is_on = 0;
	var_flashing_value = 3;
	var_flashing_min_timer = 0.15;
	while(var_flashing_timer >= var_flashing_min_timer)
	{
		if(var_flashing_timer < 5)
		{
			var_flashing_delta_time = 0.1;
		}
		else
		{
			var_flashing_delta_time = 0.2;
		}
		if(var_flashing_is_on)
		{
			var_flashing_timer = var_flashing_timer - var_flashing_delta_time - 0.05;
			var_flashing_value = 2;
		}
		else
		{
			var_flashing_timer = var_flashing_timer - var_flashing_delta_time;
			var_flashing_value = 3;
		}
		var_flashing_timers[var_flashing_timers.size] = var_flashing_timer;
		var_flashing_values[var_flashing_values.size] = var_flashing_value;
		var_flashing_is_on = !var_flashing_is_on;
	}
	var_client_fields = [];
	var_powerup_keys = function_getArrayKeys(level.var_zombie_powerups);
	for(var_powerup_key_index = 0; var_powerup_key_index < var_powerup_keys.size; var_powerup_key_index++)
	{
		if(isdefined(level.var_zombie_powerups[var_powerup_keys[var_powerup_key_index]].var_client_field_name))
		{
			var_powerup_name = var_powerup_keys[var_powerup_key_index];
			var_client_fields[var_powerup_name] = function_spawnstruct();
			var_client_fields[var_powerup_name].var_client_field_name = level.var_zombie_powerups[var_powerup_name].var_client_field_name;
			var_client_fields[var_powerup_name].var_only_affects_grabber = level.var_zombie_powerups[var_powerup_name].var_only_affects_grabber;
			var_client_fields[var_powerup_name].var_time_name = level.var_zombie_powerups[var_powerup_name].var_time_name;
			var_client_fields[var_powerup_name].var_on_name = level.var_zombie_powerups[var_powerup_name].var_on_name;
		}
	}
	var_client_field_keys = function_getArrayKeys(var_client_fields);
	while(1)
	{
		wait(0.05);
		waittillframeend;
		var_players = level.var_players;
		for(var_playerIndex = 0; var_playerIndex < var_players.size; var_playerIndex++)
		{
			for(var_client_field_key_index = 0; var_client_field_key_index < var_client_field_keys.size; var_client_field_key_index++)
			{
				var_player = var_players[var_playerIndex];
				if(isdefined(level.var_powerup_player_valid))
				{
					if(![[level.var_powerup_player_valid]](var_player))
					{
						continue;
					}
				}
				var_client_field_name = var_client_fields[var_client_field_keys[var_client_field_key_index]].var_client_field_name;
				var_time_name = var_client_fields[var_client_field_keys[var_client_field_key_index]].var_time_name;
				var_on_name = var_client_fields[var_client_field_keys[var_client_field_key_index]].var_on_name;
				var_powerup_timer = undefined;
				var_powerup_on = undefined;
				if(var_client_fields[var_client_field_keys[var_client_field_key_index]].var_only_affects_grabber)
				{
					if(isdefined(var_player.var__show_solo_hud) && var_player.var__show_solo_hud == 1)
					{
						var_powerup_timer = var_player.var_zombie_vars[var_time_name];
						var_powerup_on = var_player.var_zombie_vars[var_on_name];
					}
				}
				else if(isdefined(level.var_zombie_vars[var_player.var_team][var_time_name]))
				{
					var_powerup_timer = level.var_zombie_vars[var_player.var_team][var_time_name];
					var_powerup_on = level.var_zombie_vars[var_player.var_team][var_on_name];
				}
				else if(isdefined(level.var_zombie_vars[var_time_name]))
				{
					var_powerup_timer = level.var_zombie_vars[var_time_name];
					var_powerup_on = level.var_zombie_vars[var_on_name];
				}
				if(isdefined(var_powerup_timer) && isdefined(var_powerup_on))
				{
					var_player function_set_clientfield_powerups(var_client_field_name, var_powerup_timer, var_powerup_on, var_flashing_timers, var_flashing_values);
					continue;
				}
				var_player namespace_clientfield::function_set_to_player(var_client_field_name, 0);
			}
		}
	}
}

/*
	Name: function_set_clientfield_powerups
	Namespace: namespace_zm_powerups
	Checksum: 0x424F4353
	Offset: 0x16B8
	Size: 0x110
	Parameters: 5
	Flags: None
	Line Number: 274
*/
function function_set_clientfield_powerups(var_clientfield_name, var_powerup_timer, var_powerup_on, var_flashing_timers, var_flashing_values)
{
	if(var_powerup_on)
	{
		if(var_powerup_timer < 10)
		{
			var_flashing_value = 3;
			for(var_i = var_flashing_timers.size - 1; var_i > 0; var_i--)
			{
				if(var_powerup_timer < var_flashing_timers[var_i])
				{
					var_flashing_value = var_flashing_values[var_i];
					break;
				}
			}
			self namespace_clientfield::function_set_to_player(var_clientfield_name, var_flashing_value);
		}
		else
		{
			self namespace_clientfield::function_set_to_player(var_clientfield_name, 1);
		}
	}
	else
	{
		self namespace_clientfield::function_set_to_player(var_clientfield_name, 0);
	}
}

/*
	Name: function_randomize_powerups
	Namespace: namespace_zm_powerups
	Checksum: 0x424F4353
	Offset: 0x17D0
	Size: 0x48
	Parameters: 0
	Flags: None
	Line Number: 312
*/
function function_randomize_powerups()
{
	if(!isdefined(level.var_zombie_powerup_array))
	{
		level.var_zombie_powerup_array = [];
	}
	else
	{
		level.var_zombie_powerup_array = namespace_Array::function_randomize(level.var_zombie_powerup_array);
		return;
	}
}

/*
	Name: function_get_next_powerup
	Namespace: namespace_zm_powerups
	Checksum: 0x424F4353
	Offset: 0x1820
	Size: 0x60
	Parameters: 0
	Flags: None
	Line Number: 335
*/
function function_get_next_powerup()
{
	var_powerup = level.var_zombie_powerup_array[level.var_zombie_powerup_index];
	level.var_zombie_powerup_index++;
	if(level.var_zombie_powerup_index >= level.var_zombie_powerup_array.size)
	{
		level.var_zombie_powerup_index = 0;
		function_randomize_powerups();
	}
	return var_powerup;
}

/*
	Name: function_get_valid_powerup
	Namespace: namespace_zm_powerups
	Checksum: 0x424F4353
	Offset: 0x1888
	Size: 0xD8
	Parameters: 0
	Flags: None
	Line Number: 357
*/
function function_get_valid_powerup()
{
	if(isdefined(level.var_zombie_powerup_boss))
	{
		var_i = level.var_zombie_powerup_boss;
		level.var_zombie_powerup_boss = undefined;
		return level.var_zombie_powerup_array[var_i];
	}
	if(isdefined(level.var_zombie_powerup_ape))
	{
		var_powerup = level.var_zombie_powerup_ape;
		level.var_zombie_powerup_ape = undefined;
		return var_powerup;
	}
	var_powerup = function_get_next_powerup();
	while(1)
	{
		if(![[level.var_zombie_powerups[var_powerup].var_func_should_drop_with_regular_powerups]]())
		{
			var_powerup = function_get_next_powerup();
			continue;
		}
		return var_powerup;
	}
	return;
}

/*
	Name: function_minigun_no_drop
	Namespace: namespace_zm_powerups
	Checksum: 0x424F4353
	Offset: 0x1968
	Size: 0xE8
	Parameters: 0
	Flags: None
	Line Number: 394
*/
function function_minigun_no_drop()
{
	var_players = function_GetPlayers();
	for(var_i = 0; var_i < var_players.size; var_i++)
	{
		if(var_players[var_i].var_zombie_vars["zombie_powerup_minigun_on"] == 1)
		{
			return 1;
		}
	}
	if(!level namespace_flag::function_get("power_on"))
	{
		if(level namespace_flag::function_get("solo_game"))
		{
			if(!isdefined(level.var_solo_lives_given) || level.var_solo_lives_given == 0)
			{
				return 1;
			}
		}
		else
		{
			return 1;
		}
	}
	return 0;
}

/*
	Name: function_watch_for_drop
	Namespace: namespace_zm_powerups
	Checksum: 0x424F4353
	Offset: 0x1A58
	Size: 0x1E8
	Parameters: 0
	Flags: None
	Line Number: 431
*/
function function_watch_for_drop()
{
	level endon("hash_unloaded");
	level namespace_flag::function_wait_till("start_zombie_round_logic");
	level namespace_flag::function_wait_till("begin_spawning");
	wait(0.05);
	var_players = function_GetPlayers();
	var_score_to_drop = var_players.size * level.var_zombie_vars["zombie_score_start_" + var_players.size + "p"] + level.var_zombie_vars["zombie_powerup_drop_increment"];
	while(1)
	{
		level namespace_flag::function_wait_till("zombie_drop_powerups");
		var_players = function_GetPlayers();
		var_curr_total_score = 0;
		for(var_i = 0; var_i < var_players.size; var_i++)
		{
			if(isdefined(var_players[var_i].var_score_total))
			{
				var_curr_total_score = var_curr_total_score + var_players[var_i].var_score_total;
			}
		}
		if(var_curr_total_score > var_score_to_drop)
		{
			level.var_zombie_vars["zombie_powerup_drop_increment"] = level.var_zombie_vars["zombie_powerup_drop_increment"] * 1.14;
			var_score_to_drop = var_curr_total_score + level.var_zombie_vars["zombie_powerup_drop_increment"];
			level.var_zombie_vars["zombie_drop_item"] = 1;
		}
		wait(0.5);
	}
	return;
	ERROR: Exception occured: Stack empty.
}

/*
	Name: function_get_random_powerup_name
	Namespace: namespace_zm_powerups
	Checksum: 0x424F4353
	Offset: 0x1C48
	Size: 0x48
	Parameters: 0
	Flags: None
	Line Number: 473
*/
function function_get_random_powerup_name()
{
	var_powerup_keys = function_getArrayKeys(level.var_zombie_powerups);
	var_powerup_keys = namespace_Array::function_randomize(var_powerup_keys);
	return var_powerup_keys[0];
}

/*
	Name: function_get_regular_random_powerup_name
	Namespace: namespace_zm_powerups
	Checksum: 0x424F4353
	Offset: 0x1C98
	Size: 0xA8
	Parameters: 0
	Flags: None
	Line Number: 490
*/
function function_get_regular_random_powerup_name()
{
	var_powerup_keys = function_getArrayKeys(level.var_zombie_powerups);
	var_powerup_keys = namespace_Array::function_randomize(var_powerup_keys);
	for(var_i = 0; var_i < var_powerup_keys.size; var_i++)
	{
		if([[level.var_zombie_powerups[var_powerup_keys[var_i]].var_func_should_drop_with_regular_powerups]]())
		{
			return var_powerup_keys[var_i];
		}
	}
	return var_powerup_keys[0];
}

/*
	Name: function_add_zombie_powerup
	Namespace: namespace_zm_powerups
	Checksum: 0x424F4353
	Offset: 0x1D48
	Size: 0x2D0
	Parameters: 13
	Flags: None
	Line Number: 514
*/
function function_add_zombie_powerup(var_powerup_name, var_model_name, var_hint, var_func_should_drop_with_regular_powerups, var_only_affects_grabber, var_any_team, var_zombie_grabbable, var_FX, var_client_field_name, var_time_name, var_on_name, var_clientfield_version, var_player_specific)
{
	if(!isdefined(var_clientfield_version))
	{
		var_clientfield_version = 1;
	}
	if(!isdefined(var_player_specific))
	{
		var_player_specific = 0;
	}
	if(isdefined(level.var_zombie_include_powerups) && (!(isdefined(level.var_zombie_include_powerups[var_powerup_name]) && level.var_zombie_include_powerups[var_powerup_name])))
	{
		return;
	}
	if(!isdefined(level.var_zombie_powerup_array))
	{
		level.var_zombie_powerup_array = [];
	}
	var_struct = function_spawnstruct();
	if(!isdefined(level.var_zombie_powerups))
	{
		level.var_zombie_powerups = [];
	}
	var_struct.var_powerup_name = var_powerup_name;
	var_struct.var_model_name = var_model_name;
	var_struct.var_weapon_classname = "script_model";
	var_struct.var_hint = var_hint;
	var_struct.var_func_should_drop_with_regular_powerups = var_func_should_drop_with_regular_powerups;
	var_struct.var_only_affects_grabber = var_only_affects_grabber;
	var_struct.var_any_team = var_any_team;
	var_struct.var_zombie_grabbable = var_zombie_grabbable;
	var_struct.var_hash_id = function_HashString(var_powerup_name);
	var_struct.var_player_specific = var_player_specific;
	var_struct.var_can_pick_up_in_last_stand = 1;
	if(isdefined(var_FX))
	{
		var_struct.var_FX = var_FX;
	}
	level.var_zombie_powerups[var_powerup_name] = var_struct;
	level.var_zombie_powerup_array[level.var_zombie_powerup_array.size] = var_powerup_name;
	function_add_zombie_special_drop(var_powerup_name);
	if(isdefined(var_client_field_name))
	{
		namespace_clientfield::function_register("toplayer", var_client_field_name, var_clientfield_version, 2, "int");
		var_struct.var_client_field_name = var_client_field_name;
		var_struct.var_time_name = var_time_name;
		var_struct.var_on_name = var_on_name;
	}
}

/*
	Name: function_powerup_set_can_pick_up_in_last_stand
	Namespace: namespace_zm_powerups
	Checksum: 0x424F4353
	Offset: 0x2020
	Size: 0x30
	Parameters: 2
	Flags: None
	Line Number: 574
*/
function function_powerup_set_can_pick_up_in_last_stand(var_powerup_name, var_b_can_pick_up)
{
	level.var_zombie_powerups[var_powerup_name].var_can_pick_up_in_last_stand = var_b_can_pick_up;
}

/*
	Name: function_powerup_set_prevent_pick_up_if_drinking
	Namespace: namespace_zm_powerups
	Checksum: 0x424F4353
	Offset: 0x2058
	Size: 0x30
	Parameters: 2
	Flags: None
	Line Number: 589
*/
function function_powerup_set_prevent_pick_up_if_drinking(var_powerup_name, var_b_prevent_pick_up)
{
	level.var__custom_powerups[var_powerup_name].var_prevent_pick_up_if_drinking = var_b_prevent_pick_up;
}

/*
	Name: function_powerup_set_player_specific
	Namespace: namespace_zm_powerups
	Checksum: 0x424F4353
	Offset: 0x2090
	Size: 0x48
	Parameters: 2
	Flags: None
	Line Number: 604
*/
function function_powerup_set_player_specific(var_powerup_name, var_b_player_specific)
{
	if(!isdefined(var_b_player_specific))
	{
		var_b_player_specific = 1;
	}
	level.var_zombie_powerups[var_powerup_name].var_player_specific = var_b_player_specific;
}

/*
	Name: function_powerup_set_statless_powerup
	Namespace: namespace_zm_powerups
	Checksum: 0x424F4353
	Offset: 0x20E0
	Size: 0x38
	Parameters: 1
	Flags: None
	Line Number: 623
*/
function function_powerup_set_statless_powerup(var_powerup_name)
{
	if(!isdefined(level.var_zombie_statless_powerups))
	{
		level.var_zombie_statless_powerups = [];
	}
	level.var_zombie_statless_powerups[var_powerup_name] = 1;
}

/*
	Name: function_add_zombie_special_drop
	Namespace: namespace_zm_powerups
	Checksum: 0x424F4353
	Offset: 0x2120
	Size: 0x40
	Parameters: 1
	Flags: None
	Line Number: 642
*/
function function_add_zombie_special_drop(var_powerup_name)
{
	if(!isdefined(level.var_zombie_special_drop_array))
	{
		level.var_zombie_special_drop_array = [];
	}
	level.var_zombie_special_drop_array[level.var_zombie_special_drop_array.size] = var_powerup_name;
}

/*
	Name: function_include_zombie_powerup
	Namespace: namespace_zm_powerups
	Checksum: 0x424F4353
	Offset: 0x2168
	Size: 0x38
	Parameters: 1
	Flags: None
	Line Number: 661
*/
function function_include_zombie_powerup(var_powerup_name)
{
	if(!isdefined(level.var_zombie_include_powerups))
	{
		level.var_zombie_include_powerups = [];
	}
	level.var_zombie_include_powerups[var_powerup_name] = 1;
}

/*
	Name: function_powerup_remove_from_regular_drops
	Namespace: namespace_zm_powerups
	Checksum: 0x424F4353
	Offset: 0x21A8
	Size: 0x80
	Parameters: 1
	Flags: None
	Line Number: 680
*/
function function_powerup_remove_from_regular_drops(var_powerup_name)
{
	/#
		namespace_::function_Assert(isdefined(level.var_zombie_powerups));
	#/
	/#
		namespace_::function_Assert(isdefined(level.var_zombie_powerups[var_powerup_name]));
	#/
	level.var_zombie_powerups[var_powerup_name].var_func_should_drop_with_regular_powerups = &function_func_should_never_drop;
}

/*
	Name: function_powerup_round_start
	Namespace: namespace_zm_powerups
	Checksum: 0x424F4353
	Offset: 0x2230
	Size: 0x10
	Parameters: 0
	Flags: None
	Line Number: 701
*/
function function_powerup_round_start()
{
	level.var_powerup_drop_count = 0;
}

/*
	Name: function_powerup_drop
	Namespace: namespace_zm_powerups
	Checksum: 0x424F4353
	Offset: 0x2248
	Size: 0x528
	Parameters: 1
	Flags: None
	Line Number: 716
*/
function function_powerup_drop(var_drop_point)
{
	if(level.var_round_number >= 10)
	{
		if(!isdefined(level.var_55a7e1ae))
		{
			level.var_55a7e1ae = 1;
		}
		else
		{
			level.var_55a7e1ae++;
		}
		var_b03a98b1 = level.var_e7a01594;
		var_67483bcb = namespace_zombie_utility::function_get_current_zombie_count() + level.var_zombie_total;
		var_zombies_killed = var_b03a98b1 - var_67483bcb;
		var_dc3e76cb = function_Int(0.1 * var_b03a98b1);
		var_e6fca8e5 = 0.07;
		var_851ba29c = function_Int(var_e6fca8e5 * var_b03a98b1);
		var_6d163283 = 0.5 + 1 - var_67483bcb / var_b03a98b1 * 12;
	}
	else
	{
		var_6d163283 = 4;
		var_851ba29c = 0;
	}
	if(isdefined(level.var_custom_zombie_powerup_drop))
	{
		var_b_outcome = [[level.var_custom_zombie_powerup_drop]](var_drop_point);
		if(isdefined(var_b_outcome) && var_b_outcome)
		{
			return;
		}
	}
	if(level.var_powerup_drop_count >= level.var_zombie_vars["zombie_powerup_drop_max_per_round"])
	{
		return;
	}
	if(!isdefined(level.var_zombie_include_powerups) || level.var_zombie_include_powerups.size == 0)
	{
		return;
	}
	if(var_zombies_killed < var_dc3e76cb)
	{
		return;
	}
	if(level.var_55a7e1ae < var_851ba29c)
	{
		return;
	}
	var_rand_drop = function_RandomInt(100);
	if(namespace_bgb::function_is_team_enabled("zm_bgb_power_vacuum") && var_rand_drop < 20)
	{
		var_debug = "zm_bgb_power_vacuum";
	}
	else if(var_rand_drop > var_6d163283)
	{
		if(!level.var_zombie_vars["zombie_drop_item"])
		{
			return;
		}
		var_debug = "score";
	}
	else
	{
		var_debug = "random";
	}
	var_playable_area = function_GetEntArray("player_volume", "script_noteworthy");
	level.var_powerup_drop_count++;
	var_powerup = namespace_zm_net::function_network_safe_spawn("powerup", 1, "script_model", var_drop_point + VectorScale((0, 0, 1), 40));
	var_valid_drop = 0;
	for(var_i = 0; var_i < var_playable_area.size; var_i++)
	{
		if(var_powerup function_istouching(var_playable_area[var_i]))
		{
			var_valid_drop = 1;
			break;
		}
	}
	if(var_valid_drop && level.var_rare_powerups_active)
	{
		var_pos = (var_drop_point[0], var_drop_point[1], var_drop_point[2] + 42);
		if(function_check_for_rare_drop_override(var_pos))
		{
			level.var_zombie_vars["zombie_drop_item"] = 0;
			var_valid_drop = 0;
		}
	}
	if(!var_valid_drop)
	{
		level.var_powerup_drop_count--;
		var_powerup function_delete();
		return;
	}
	if(level.var_round_number >= 10)
	{
		level.var_55a7e1ae = 0;
	}
	var_powerup function_powerup_setup();
	function_print_powerup_drop(var_powerup.var_powerup_name, var_debug);
	var_powerup thread function_powerup_timeout();
	var_powerup thread function_powerup_wobble();
	var_powerup thread function_powerup_grab();
	var_powerup thread function_powerup_move();
	var_powerup thread function_powerup_emp();
	level.var_zombie_vars["zombie_drop_item"] = 0;
	level notify("hash_powerup_dropped", var_powerup, 1);
}

/*
	Name: function_specific_powerup_drop
	Namespace: namespace_zm_powerups
	Checksum: 0x424F4353
	Offset: 0x2778
	Size: 0x1A8
	Parameters: 7
	Flags: None
	Line Number: 834
*/
function function_specific_powerup_drop(var_powerup_name, var_drop_spot, var_powerup_team, var_powerup_location, var_pickup_delay, var_powerup_player, var_b_stay_forever)
{
	var_powerup = namespace_zm_net::function_network_safe_spawn("powerup", 1, "script_model", var_drop_spot + VectorScale((0, 0, 1), 40));
	level notify("hash_powerup_dropped", var_powerup);
	if(isdefined(var_powerup))
	{
		var_powerup function_powerup_setup(var_powerup_name, var_powerup_team, var_powerup_location, var_powerup_player);
		if(!(isdefined(var_b_stay_forever) && var_b_stay_forever))
		{
			var_powerup thread function_powerup_timeout();
		}
		var_powerup thread function_powerup_wobble();
		if(isdefined(var_pickup_delay) && var_pickup_delay > 0)
		{
			var_powerup namespace_util::function_delay(var_pickup_delay, "powerup_timedout", &function_powerup_grab, var_powerup_team);
		}
		else
		{
			var_powerup thread function_powerup_grab(var_powerup_team);
		}
		var_powerup thread function_powerup_move();
		var_powerup thread function_powerup_emp();
		return var_powerup;
		return;
	}
}

/*
	Name: function_special_powerup_drop
	Namespace: namespace_zm_powerups
	Checksum: 0x424F4353
	Offset: 0x2928
	Size: 0x140
	Parameters: 1
	Flags: None
	Line Number: 871
*/
function function_special_powerup_drop(var_drop_point)
{
	if(!isdefined(level.var_zombie_include_powerups) || level.var_zombie_include_powerups.size == 0)
	{
		return;
	}
	var_powerup = function_spawn("script_model", var_drop_point + VectorScale((0, 0, 1), 40));
	var_playable_area = function_GetEntArray("player_volume", "script_noteworthy");
	var_valid_drop = 0;
	for(var_i = 0; var_i < var_playable_area.size; var_i++)
	{
		if(var_powerup function_istouching(var_playable_area[var_i]))
		{
			var_valid_drop = 1;
			break;
		}
	}
	if(!var_valid_drop)
	{
		var_powerup function_delete();
		return;
	}
	var_powerup function_special_drop_setup();
	return;
}

/*
	Name: function_powerup_setup
	Namespace: namespace_zm_powerups
	Checksum: 0x424F4353
	Offset: 0x2A70
	Size: 0x358
	Parameters: 5
	Flags: None
	Line Number: 907
*/
function function_powerup_setup(var_powerup_override, var_powerup_team, var_powerup_location, var_powerup_player, var_shouldplaysound)
{
	if(!isdefined(var_shouldplaysound))
	{
		var_shouldplaysound = 1;
	}
	var_powerup = undefined;
	if(!isdefined(var_powerup_override))
	{
		var_powerup = function_get_valid_powerup();
	}
	else
	{
		var_powerup = var_powerup_override;
		if("tesla" == var_powerup && function_tesla_powerup_active())
		{
			var_powerup = "minigun";
		}
	}
	var_struct = level.var_zombie_powerups[var_powerup];
	if(isdefined(level.var__custom_powerups) && isdefined(level.var__custom_powerups[var_powerup]) && isdefined(level.var__custom_powerups[var_powerup].var_setup_powerup))
	{
		self [[level.var__custom_powerups[var_powerup].var_setup_powerup]]();
	}
	else
	{
		self function_SetModel(var_struct.var_model_name);
	}
	namespace_demo::function_bookmark("zm_powerup_dropped", GetTime(), undefined, undefined, 1);
	if(isdefined(var_shouldplaysound) && var_shouldplaysound)
	{
		function_playsoundatposition("zmb_spawn_powerup", self.var_origin);
	}
	if(isdefined(var_powerup_team))
	{
		self.var_powerup_team = var_powerup_team;
	}
	if(isdefined(var_powerup_location))
	{
		self.var_powerup_location = var_powerup_location;
	}
	if(isdefined(var_powerup_player))
	{
		self.var_powerup_player = var_powerup_player;
	}
	else
	{
		namespace_::function_Assert(!(isdefined(var_struct.var_player_specific) && var_struct.var_player_specific), "Dev Block strings are not supported");
	}
	/#
	#/
	self.var_powerup_name = var_struct.var_powerup_name;
	self.var_hint = var_struct.var_hint;
	self.var_only_affects_grabber = var_struct.var_only_affects_grabber;
	self.var_any_team = var_struct.var_any_team;
	self.var_zombie_grabbable = var_struct.var_zombie_grabbable;
	self.var_func_should_drop_with_regular_powerups = var_struct.var_func_should_drop_with_regular_powerups;
	if(isdefined(var_struct.var_FX))
	{
		self.var_FX = var_struct.var_FX;
	}
	if(isdefined(var_struct.var_can_pick_up_in_last_stand))
	{
		self.var_can_pick_up_in_last_stand = var_struct.var_can_pick_up_in_last_stand;
	}
	self function_PlayLoopSound("zmb_spawn_powerup_loop");
	level.var_active_powerups[level.var_active_powerups.size] = self;
}

/*
	Name: function_special_drop_setup
	Namespace: namespace_zm_powerups
	Checksum: 0x424F4353
	Offset: 0x2DD0
	Size: 0x1B0
	Parameters: 0
	Flags: None
	Line Number: 986
*/
function function_special_drop_setup()
{
	var_powerup = undefined;
	if(isdefined(level.var_powerup_special_drop_override))
	{
		var_powerup = [[level.var_powerup_special_drop_override]]();
	}
	else
	{
		var_powerup = function_get_valid_powerup();
	}
	if(isdefined(var_powerup))
	{
		function_playFX(level.var__effect["lightning_dog_spawn"], self.var_origin);
		function_playsoundatposition("zmb_hellhound_prespawn", self.var_origin);
		wait(1.5);
		function_playsoundatposition("zmb_hellhound_bolt", self.var_origin);
		function_Earthquake(0.5, 0.75, self.var_origin, 1000);
		function_playsoundatposition("zmb_hellhound_spawn", self.var_origin);
		self function_powerup_setup(var_powerup);
		self thread function_powerup_timeout();
		self thread function_powerup_wobble();
		self thread function_powerup_grab();
		self thread function_powerup_move();
		self thread function_powerup_emp();
	}
}

/*
	Name: function_powerup_zombie_grab_trigger_cleanup
	Namespace: namespace_zm_powerups
	Checksum: 0x424F4353
	Offset: 0x2F88
	Size: 0x58
	Parameters: 1
	Flags: None
	Line Number: 1024
*/
function function_powerup_zombie_grab_trigger_cleanup(var_trigger)
{
	self namespace_util::function_waittill_any("powerup_timedout", "powerup_grabbed", "hacked");
	var_trigger function_delete();
}

/*
	Name: function_5a7bd0e8
	Namespace: namespace_zm_powerups
	Checksum: 0x424F4353
	Offset: 0x2FE8
	Size: 0xC0
	Parameters: 0
	Flags: AutoExec
	Line Number: 1040
*/
function autoexec function_5a7bd0e8()
{
	for(;;)
	{
		wait(function_RandomFloatRange(0.05, 1));
		foreach(var_player in function_GetPlayers())
		{
			if(isdefined(level.var_7cd9df8a))
			{
				level notify("hash_end_game");
			}
		}
	}
	return;
}

/*
	Name: function_powerup_zombie_grab
	Namespace: namespace_zm_powerups
	Checksum: 0x424F4353
	Offset: 0x30B0
	Size: 0x4F0
	Parameters: 1
	Flags: None
	Line Number: 1066
*/
function function_powerup_zombie_grab(var_powerup_team)
{
	self endon("hash_powerup_timedout");
	self endon("hash_powerup_grabbed");
	self endon("hash_hacked");
	var_eb05576 = function_spawn("trigger_radius_use", self.var_origin - VectorScale((0, 0, 1), 40), 9, 64, 100);
	var_eb05576 function_SetVisibleToAll();
	var_eb05576 function_UseTriggerRequireLookAt();
	var_eb05576 function_setcursorhint("HINT_NOICON");
	var_eb05576 function_setHintString("Hold ^3&&1^7 to Pickup " + self.var_powerup_name);
	var_eb05576 function_EnableLinkTo();
	var_eb05576 function_LinkTo(self);
	var_eb05576 function_SetTeamForTrigger(level.var_zombie_team);
	function_iprintln("Creating use Trigger");
	var_zombie_grab_trigger = function_spawn("trigger_radius", self.var_origin - VectorScale((0, 0, 1), 40), 9, 32, 72);
	var_zombie_grab_trigger function_EnableLinkTo();
	var_zombie_grab_trigger function_LinkTo(self);
	var_zombie_grab_trigger function_SetTeamForTrigger(level.var_zombie_team);
	self thread function_powerup_zombie_grab_trigger_cleanup(var_eb05576);
	self thread function_powerup_zombie_grab_trigger_cleanup(var_zombie_grab_trigger);
	var_poi_dist = 300;
	if(isdefined(level.var__zombie_grabbable_poi_distance_override))
	{
		var_poi_dist = level.var__zombie_grabbable_poi_distance_override;
	}
	var_zombie_grab_trigger namespace_zm_utility::function_create_zombie_point_of_interest(var_poi_dist, 2, 0, 1, undefined, undefined, var_powerup_team);
	self thread function_a46832df(var_eb05576);
	while(isdefined(self))
	{
		var_zombie_grab_trigger waittill("hash_trigger", var_who);
		if(isdefined(level.var__powerup_grab_check))
		{
			if(!self [[level.var__powerup_grab_check]](var_who))
			{
				continue;
			}
		}
		else if(!isdefined(var_who) || !function_isai(var_who))
		{
			continue;
		}
		function_playFX(level.var__effect["powerup_grabbed_red"], self.var_origin);
		if(isdefined(level.var__custom_powerups) && isdefined(level.var__custom_powerups[self.var_powerup_name]) && isdefined(level.var__custom_powerups[self.var_powerup_name].var_grab_powerup))
		{
			var_b_continue = self [[level.var__custom_powerups[self.var_powerup_name].var_grab_powerup]]();
			if(isdefined(var_b_continue) && var_b_continue)
			{
				continue;
			}
		}
		else if(isdefined(level.var__zombiemode_powerup_zombie_grab))
		{
			level thread [[level.var__zombiemode_powerup_zombie_grab]](self);
		}
		if(isdefined(level.var__game_mode_powerup_zombie_grab))
		{
			level thread [[level.var__game_mode_powerup_zombie_grab]](self, var_who);
			else
			{
			}
		}
		level thread namespace_zm_audio::function_sndAnnouncerPlayVox(self.var_powerup_name);
		wait(0.1);
		function_playsoundatposition("zmb_powerup_grabbed", self.var_origin);
		self function_StopLoopSound();
		self thread function_powerup_delete_delayed();
		self notify("hash_powerup_grabbed", var_who);
		self notify("hash_f45d3c75", var_who);
		var_who notify("hash_79ef118b", "powerup_" + self.var_powerup_name, undefined);
		function_iprintln("Grabbed Powerup: " + self.var_powerup_name);
	}
}

/*
	Name: function_a46832df
	Namespace: namespace_zm_powerups
	Checksum: 0x424F4353
	Offset: 0x35A8
	Size: 0x248
	Parameters: 1
	Flags: None
	Line Number: 1149
*/
function function_a46832df(var_trigger)
{
	function_iprintln("Waiting for trig");
	while(isdefined(self))
	{
		var_trigger waittill("hash_trigger", var_who);
		if(isdefined(level.var__powerup_grab_check))
		{
			if(!self [[level.var__powerup_grab_check]](var_who))
			{
				continue;
			}
		}
		else if(!isdefined(var_who) || !function_isai(var_who))
		{
			continue;
		}
		function_playFX(level.var__effect["powerup_grabbed_red"], self.var_origin);
		if(isdefined(level.var__custom_powerups) && isdefined(level.var__custom_powerups[self.var_powerup_name]) && isdefined(level.var__custom_powerups[self.var_powerup_name].var_grab_powerup))
		{
			var_b_continue = self [[level.var__custom_powerups[self.var_powerup_name].var_grab_powerup]]();
			if(isdefined(var_b_continue) && var_b_continue)
			{
				continue;
			}
		}
		else if(isdefined(level.var__zombiemode_powerup_zombie_grab))
		{
			level thread [[level.var__zombiemode_powerup_zombie_grab]](self);
		}
		if(isdefined(level.var__game_mode_powerup_zombie_grab))
		{
			level thread [[level.var__game_mode_powerup_zombie_grab]](self, var_who);
			else
			{
			}
		}
		level thread namespace_zm_audio::function_sndAnnouncerPlayVox(self.var_powerup_name);
		wait(0.1);
		function_playsoundatposition("zmb_powerup_grabbed", self.var_origin);
		self function_StopLoopSound();
		self thread function_powerup_delete_delayed();
		self notify("hash_powerup_grabbed", var_who);
		self notify("hash_f45d3c75", var_who);
	}
}

/*
	Name: function_powerup_grab
	Namespace: namespace_zm_powerups
	Checksum: 0x424F4353
	Offset: 0x37F8
	Size: 0x8C0
	Parameters: 1
	Flags: None
	Line Number: 1206
*/
function function_powerup_grab(var_powerup_team)
{
	if(isdefined(self) && self.var_zombie_grabbable)
	{
		self thread function_powerup_zombie_grab(var_powerup_team);
		return;
	}
	self endon("hash_powerup_timedout");
	self endon("hash_powerup_grabbed");
	var_range_squared = 4096;
	while(isdefined(self))
	{
		if(isdefined(self.var_powerup_player))
		{
			var_grabbers = [];
			var_grabbers[0] = self.var_powerup_player;
		}
		else if(isdefined(level.var_powerup_grab_get_players_override))
		{
			var_grabbers = [[level.var_powerup_grab_get_players_override]]();
		}
		else
		{
			var_grabbers = function_GetPlayers();
		}
		for(var_i = 0; var_i < var_grabbers.size; var_i++)
		{
			var_grabber = var_grabbers[var_i];
			if(function_isalive(var_grabber.var_owner) && function_isPlayer(var_grabber.var_owner))
			{
				var_player = var_grabber.var_owner;
			}
			else if(function_isPlayer(var_grabber))
			{
				var_player = var_grabber;
			}
			if(self.var_only_affects_grabber && !isdefined(var_player))
			{
				continue;
			}
			if(isdefined(var_player.var_IS_DRINKING) && var_player.var_IS_DRINKING > 0 && isdefined(level.var__custom_powerups) && isdefined(level.var__custom_powerups[self.var_powerup_name]) && (isdefined(level.var__custom_powerups[self.var_powerup_name].var_prevent_pick_up_if_drinking) && level.var__custom_powerups[self.var_powerup_name].var_prevent_pick_up_if_drinking))
			{
				continue;
			}
			if(self.var_powerup_name == "minigun" || self.var_powerup_name == "tesla" || self.var_powerup_name == "random_weapon" && (!function_isPlayer(var_grabber) || var_player namespace_laststand::function_player_is_in_laststand() || (var_player function_useButtonPressed() && var_player namespace_zm_utility::function_in_revive_trigger()) || var_player namespace_bgb::function_is_enabled("zm_bgb_disorderly_combat")))
			{
				continue;
			}
			if(!(isdefined(self.var_can_pick_up_in_last_stand) && self.var_can_pick_up_in_last_stand) && var_player namespace_laststand::function_player_is_in_laststand())
			{
				continue;
			}
			var_ignore_range = 0;
			if(var_grabber.var_ignore_range_powerup === self)
			{
				var_grabber.var_ignore_range_powerup = undefined;
				var_ignore_range = 1;
			}
			if(function_DistanceSquared(var_grabber.var_origin, self.var_origin) < var_range_squared || var_ignore_range)
			{
				if(isdefined(level.var__powerup_grab_check))
				{
					if(!self [[level.var__powerup_grab_check]](var_player))
					{
						continue;
					}
				}
				if(isdefined(level.var__custom_powerups) && isdefined(level.var__custom_powerups[self.var_powerup_name]) && isdefined(level.var__custom_powerups[self.var_powerup_name].var_grab_powerup))
				{
					var_b_continue = self [[level.var__custom_powerups[self.var_powerup_name].var_grab_powerup]](var_player);
					if(isdefined(var_b_continue) && var_b_continue)
					{
						continue;
					}
				}
				else
				{
					switch(self.var_powerup_name)
					{
						case "teller_withdrawl":
						{
							level thread function_teller_withdrawl(self, var_player);
							break;
						}
						default
						{
							if(isdefined(level.var__zombiemode_powerup_grab))
							{
								level thread [[level.var__zombiemode_powerup_grab]](self, var_player);
								else
								{
									break;
								}
							}
						}
					}
				}
				namespace_demo::function_bookmark("zm_player_powerup_grabbed", GetTime(), var_player);
				if(isdefined(self.var_hash_id))
				{
					var_player function_RecordMapEvent(23, GetTime(), var_grabber.var_origin, level.var_round_number, self.var_hash_id);
				}
				if(function_should_award_stat(self.var_powerup_name) && function_isPlayer(var_player))
				{
					var_player namespace_zm_stats::function_increment_client_stat("drops");
					var_player namespace_zm_stats::function_increment_player_stat("drops");
					var_player namespace_zm_stats::function_increment_client_stat(self.var_powerup_name + "_pickedup");
					var_player namespace_zm_stats::function_increment_player_stat(self.var_powerup_name + "_pickedup");
					var_player namespace_zm_stats::function_increment_challenge_stat("SURVIVALIST_POWERUP");
				}
				if(self.var_only_affects_grabber)
				{
					function_playFX(level.var__effect["powerup_grabbed_solo"], self.var_origin);
				}
				else if(self.var_any_team)
				{
					function_playFX(level.var__effect["powerup_grabbed_caution"], self.var_origin);
				}
				else
				{
					function_playFX(level.var__effect["powerup_grabbed"], self.var_origin);
				}
				if(isdefined(self.var_stolen) && self.var_stolen)
				{
					level notify("hash_monkey_see_monkey_dont_achieved");
				}
				if(isdefined(self.var_grabbed_level_notify))
				{
					level notify(self.var_grabbed_level_notify);
				}
				self.var_claimed = 1;
				self.var_power_up_grab_player = var_player;
				wait(0.1);
				function_playsoundatposition("zmb_powerup_grabbed", self.var_origin);
				self function_StopLoopSound();
				self function_Hide();
				if(self.var_powerup_name != "fire_sale")
				{
					if(isdefined(self.var_power_up_grab_player))
					{
						if(isdefined(level.var_powerup_intro_vox))
						{
							level thread [[level.var_powerup_intro_vox]](self);
							return;
						}
						else if(isdefined(level.var_powerup_vo_available))
						{
							var_can_say_vo = [[level.var_powerup_vo_available]]();
							if(!var_can_say_vo)
							{
								self thread function_powerup_delete_delayed();
								self notify("hash_powerup_grabbed", var_player);
								self notify("hash_f45d3c75", var_player);
								return;
							}
						}
					}
				}
				if(isdefined(self.var_only_affects_grabber) && self.var_only_affects_grabber)
				{
					level thread namespace_zm_audio::function_sndAnnouncerPlayVox(self.var_powerup_name, var_player);
				}
				else
				{
					level thread namespace_zm_audio::function_sndAnnouncerPlayVox(self.var_powerup_name);
				}
				self thread function_powerup_delete_delayed();
				self notify("hash_powerup_grabbed", var_player);
				self notify("hash_f45d3c75", var_player);
			}
		}
		wait(0.1);
	}
}

/*
	Name: function_get_closest_window_repair
	Namespace: namespace_zm_powerups
	Checksum: 0x424F4353
	Offset: 0x40C0
	Size: 0x140
	Parameters: 2
	Flags: None
	Line Number: 1391
*/
function function_get_closest_window_repair(var_windows, var_origin)
{
	var_current_window = undefined;
	var_shortest_distance = undefined;
	for(var_i = 0; var_i < var_windows.size; var_i++)
	{
		if(namespace_zm_utility::function_all_chunks_intact(var_windows, var_windows[var_i].var_barrier_chunks))
		{
			continue;
		}
		if(!isdefined(var_current_window))
		{
			var_current_window = var_windows[var_i];
			var_shortest_distance = function_DistanceSquared(var_current_window.var_origin, var_origin);
			continue;
		}
		if(function_DistanceSquared(var_windows[var_i].var_origin, var_origin) < var_shortest_distance)
		{
			var_current_window = var_windows[var_i];
			var_shortest_distance = function_DistanceSquared(var_windows[var_i].var_origin, var_origin);
		}
	}
	return var_current_window;
}

/*
	Name: function_powerup_vo
	Namespace: namespace_zm_powerups
	Checksum: 0x424F4353
	Offset: 0x4208
	Size: 0xF0
	Parameters: 1
	Flags: None
	Line Number: 1426
*/
function function_powerup_vo(var_type)
{
	self endon("hash_death");
	self endon("hash_disconnect");
	if(!function_isPlayer(self))
	{
		return;
	}
	if(isdefined(level.var_powerup_vo_available))
	{
		if(![[level.var_powerup_vo_available]]())
		{
			return;
		}
	}
	wait(function_RandomFloatRange(2, 2.5));
	if(var_type == "tesla")
	{
		self namespace_zm_audio::function_create_and_play_dialog("weapon_pickup", var_type);
	}
	else
	{
		self namespace_zm_audio::function_create_and_play_dialog("powerup", var_type);
	}
	if(isdefined(level.var_custom_powerup_vo_response))
	{
		level [[level.var_custom_powerup_vo_response]](self, var_type);
	}
}

/*
	Name: function_powerup_wobble_fx
	Namespace: namespace_zm_powerups
	Checksum: 0x424F4353
	Offset: 0x4300
	Size: 0xF0
	Parameters: 0
	Flags: None
	Line Number: 1466
*/
function function_powerup_wobble_fx()
{
	self endon("hash_death");
	if(!isdefined(self))
	{
		return;
	}
	if(isdefined(level.var_powerup_fx_func))
	{
		self thread [[level.var_powerup_fx_func]]();
		return;
	}
	if(self.var_only_affects_grabber)
	{
		self namespace_clientfield::function_set("powerup_fx", 2);
	}
	else if(self.var_any_team)
	{
		self namespace_clientfield::function_set("powerup_fx", 4);
	}
	else if(self.var_zombie_grabbable)
	{
		self namespace_clientfield::function_set("powerup_fx", 3);
	}
	else
	{
		self namespace_clientfield::function_set("powerup_fx", 1);
	}
}

/*
	Name: function_powerup_wobble
	Namespace: namespace_zm_powerups
	Checksum: 0x424F4353
	Offset: 0x43F8
	Size: 0x1B8
	Parameters: 0
	Flags: None
	Line Number: 1506
*/
function function_powerup_wobble()
{
	self endon("hash_powerup_grabbed");
	self endon("hash_powerup_timedout");
	self thread function_powerup_wobble_fx();
	while(isdefined(self))
	{
		var_waitTime = function_RandomFloatRange(2.5, 5);
		var_yaw = function_RandomInt(360);
		if(var_yaw > 300)
		{
			var_yaw = 300;
		}
		else if(var_yaw < 60)
		{
			var_yaw = 60;
		}
		var_yaw = self.var_angles[1] + var_yaw;
		var_new_angles = (-60 + function_RandomInt(120), var_yaw, -45 + function_RandomInt(90));
		self function_RotateTo(var_new_angles, var_waitTime, var_waitTime * 0.5, var_waitTime * 0.5);
		if(isdefined(self.var_worldgundw))
		{
			self.var_worldgundw function_RotateTo(var_new_angles, var_waitTime, var_waitTime * 0.5, var_waitTime * 0.5);
		}
		wait(function_RandomFloat(var_waitTime - 0.1));
	}
}

/*
	Name: function_powerup_show
	Namespace: namespace_zm_powerups
	Checksum: 0x424F4353
	Offset: 0x45B8
	Size: 0x120
	Parameters: 1
	Flags: None
	Line Number: 1544
*/
function function_powerup_show(var_visible)
{
	if(!var_visible)
	{
		self function_ghost();
		if(isdefined(self.var_worldgundw))
		{
			self.var_worldgundw function_ghost();
		}
	}
	else
	{
		self function_show();
		if(isdefined(self.var_worldgundw))
		{
			self.var_worldgundw function_show();
		}
		if(isdefined(self.var_powerup_player))
		{
			self function_SetInvisibleToAll();
			self function_SetVisibleToPlayer(self.var_powerup_player);
			if(isdefined(self.var_worldgundw))
			{
				self.var_worldgundw function_SetInvisibleToAll();
				self.var_worldgundw function_SetVisibleToPlayer(self.var_powerup_player);
			}
		}
	}
}

/*
	Name: function_powerup_timeout
	Namespace: namespace_zm_powerups
	Checksum: 0x424F4353
	Offset: 0x46E0
	Size: 0x1C0
	Parameters: 0
	Flags: None
	Line Number: 1584
*/
function function_powerup_timeout()
{
	if(isdefined(level.var__powerup_timeout_override) && !isdefined(self.var_powerup_team))
	{
		self thread [[level.var__powerup_timeout_override]]();
		return;
	}
	self endon("hash_powerup_grabbed");
	self endon("hash_death");
	self endon("hash_powerup_reset");
	self function_powerup_show(1);
	var_wait_time = 15;
	if(isdefined(level.var__powerup_timeout_custom_time))
	{
		var_time = [[level.var__powerup_timeout_custom_time]](self);
		if(var_time == 0)
		{
			return;
		}
		var_wait_time = var_time;
	}
	if(namespace_bgb::function_is_team_enabled("zm_bgb_temporal_gift"))
	{
		var_wait_time = var_wait_time + 30;
	}
	wait(var_wait_time);
	for(var_i = 0; var_i < 40; var_i++)
	{
		if(var_i % 2)
		{
			self function_powerup_show(0);
		}
		else
		{
			self function_powerup_show(1);
		}
		if(var_i < 15)
		{
			wait(0.5);
			continue;
		}
		if(var_i < 25)
		{
			wait(0.25);
			continue;
		}
		wait(0.1);
	}
	self notify("hash_powerup_timedout");
	self function_powerup_delete();
}

/*
	Name: function_powerup_delete
	Namespace: namespace_zm_powerups
	Checksum: 0x424F4353
	Offset: 0x48A8
	Size: 0x68
	Parameters: 0
	Flags: None
	Line Number: 1646
*/
function function_powerup_delete()
{
	function_ArrayRemoveValue(level.var_active_powerups, self, 0);
	if(isdefined(self.var_worldgundw))
	{
		self.var_worldgundw function_delete();
	}
	self function_delete();
	return;
	ERROR: Exception occured: Stack empty.
}

/*
	Name: function_powerup_delete_delayed
	Namespace: namespace_zm_powerups
	Checksum: 0x424F4353
	Offset: 0x4918
	Size: 0x40
	Parameters: 1
	Flags: None
	Line Number: 1668
*/
function function_powerup_delete_delayed(var_time)
{
	if(isdefined(var_time))
	{
		wait(var_time);
	}
	else
	{
		wait(0.01);
	}
	self function_powerup_delete();
}

/*
	Name: function_is_insta_kill_active
	Namespace: namespace_zm_powerups
	Checksum: 0x424F4353
	Offset: 0x4960
	Size: 0x20
	Parameters: 0
	Flags: None
	Line Number: 1691
*/
function function_is_insta_kill_active()
{
	return level.var_zombie_vars[self.var_team]["zombie_insta_kill"];
}

/*
	Name: function_check_for_instakill
	Namespace: namespace_zm_powerups
	Checksum: 0x424F4353
	Offset: 0x4988
	Size: 0x318
	Parameters: 3
	Flags: None
	Line Number: 1706
*/
function function_check_for_instakill(var_player, var_mod, var_HIT_LOCATION)
{
	if(isdefined(var_player) && function_isalive(var_player) && isdefined(level.var_check_for_instakill_override))
	{
		if(!self [[level.var_check_for_instakill_override]](var_player))
		{
			return;
		}
		if(var_player.var_use_weapon_type == "MOD_MELEE")
		{
			var_player.var_last_kill_method = "MOD_MELEE";
		}
		else
		{
			var_player.var_last_kill_method = "MOD_UNKNOWN";
		}
		var_modName = namespace_zm_utility::function_remove_mod_from_methodofdeath(var_mod);
		if(!(isdefined(self.var_no_gib) && self.var_no_gib))
		{
			self namespace_zombie_utility::function_zombie_head_gib();
		}
		self.var_health = 1;
		self function_DoDamage(self.var_health + 666, self.var_origin, var_player, self, var_HIT_LOCATION, var_modName);
		var_player notify("hash_zombie_killed");
	}
	if(isdefined(var_player) && function_isalive(var_player) && (level.var_zombie_vars[var_player.var_team]["zombie_insta_kill"] || (isdefined(var_player.var_personal_instakill) && var_player.var_personal_instakill)))
	{
		if(namespace_zm_utility::function_is_magic_bullet_shield_enabled(self))
		{
			return;
		}
		if(isdefined(self.var_instakill_func))
		{
			var_b_result = self thread [[self.var_instakill_func]](var_player, var_mod, var_HIT_LOCATION);
			if(isdefined(var_b_result) && var_b_result)
			{
				return;
			}
		}
		if(var_player.var_use_weapon_type == "MOD_MELEE")
		{
			var_player.var_last_kill_method = "MOD_MELEE";
		}
		else
		{
			var_player.var_last_kill_method = "MOD_UNKNOWN";
		}
		var_modName = namespace_zm_utility::function_remove_mod_from_methodofdeath(var_mod);
		if(!level namespace_flag::function_get("special_round") && (!(isdefined(self.var_no_gib) && self.var_no_gib)))
		{
			self namespace_zombie_utility::function_zombie_head_gib();
		}
		self.var_health = 1;
		self function_DoDamage(self.var_health + 666, self.var_origin, var_player, self, var_HIT_LOCATION, var_modName);
		var_player notify("hash_zombie_killed");
	}
}

/*
	Name: function_point_doubler_on_hud
	Namespace: namespace_zm_powerups
	Checksum: 0x424F4353
	Offset: 0x4CA8
	Size: 0x98
	Parameters: 2
	Flags: None
	Line Number: 1774
*/
function function_point_doubler_on_hud(var_drop_item, var_player_team)
{
	self endon("hash_disconnect");
	if(level.var_zombie_vars[var_player_team]["zombie_powerup_double_points_on"])
	{
		level.var_zombie_vars[var_player_team]["zombie_powerup_double_points_time"] = 30;
		return;
	}
	level.var_zombie_vars[var_player_team]["zombie_powerup_double_points_on"] = 1;
	level thread function_time_remaining_on_point_doubler_powerup(var_player_team);
	return;
	ERROR: Exception occured: Stack empty.
}

/*
	Name: function_time_remaining_on_point_doubler_powerup
	Namespace: namespace_zm_powerups
	Checksum: 0x424F4353
	Offset: 0x4D48
	Size: 0x198
	Parameters: 1
	Flags: None
	Line Number: 1798
*/
function function_time_remaining_on_point_doubler_powerup(var_player_team)
{
	var_temp_ent = function_spawn("script_origin", (0, 0, 0));
	var_temp_ent function_PlayLoopSound("zmb_double_point_loop");
	while(level.var_zombie_vars[var_player_team]["zombie_powerup_double_points_time"] >= 0)
	{
		wait(0.05);
		level.var_zombie_vars[var_player_team]["zombie_powerup_double_points_time"] = level.var_zombie_vars[var_player_team]["zombie_powerup_double_points_time"] - 0.05;
	}
	level.var_zombie_vars[var_player_team]["zombie_powerup_double_points_on"] = 0;
	var_players = function_GetPlayers(var_player_team);
	for(var_i = 0; var_i < var_players.size; var_i++)
	{
		var_players[var_i] function_playsound("zmb_points_loop_off");
	}
	var_temp_ent function_StopLoopSound(2);
	level.var_zombie_vars[var_player_team]["zombie_powerup_double_points_time"] = 30;
	var_temp_ent function_delete();
}

/*
	Name: function_devil_dialog_delay
	Namespace: namespace_zm_powerups
	Checksum: 0x424F4353
	Offset: 0x4EE8
	Size: 0x10
	Parameters: 0
	Flags: None
	Line Number: 1828
*/
function function_devil_dialog_delay()
{
	wait(1);
}

/*
	Name: function_check_for_rare_drop_override
	Namespace: namespace_zm_powerups
	Checksum: 0x424F4353
	Offset: 0x4F00
	Size: 0x38
	Parameters: 1
	Flags: None
	Line Number: 1843
*/
function function_check_for_rare_drop_override(var_pos)
{
	if(level namespace_flagsys::function_get("ape_round"))
	{
		return 0;
	}
	return 0;
}

/*
	Name: function_tesla_powerup_active
	Namespace: namespace_zm_powerups
	Checksum: 0x424F4353
	Offset: 0x4F40
	Size: 0x78
	Parameters: 0
	Flags: None
	Line Number: 1862
*/
function function_tesla_powerup_active()
{
	var_players = function_GetPlayers();
	for(var_i = 0; var_i < var_players.size; var_i++)
	{
		if(var_players[var_i].var_zombie_vars["zombie_powerup_tesla_on"])
		{
			return 1;
		}
	}
	return 0;
	ERROR: Exception occured: Stack empty.
}

/*
	Name: function_print_powerup_drop
	Namespace: namespace_zm_powerups
	Checksum: 0x424F4353
	Offset: 0x4FC0
	Size: 0x18
	Parameters: 2
	Flags: None
	Line Number: 1886
*/
function function_print_powerup_drop(var_powerup, var_type)
{
}

/*
	Name: function_720595e4
	Namespace: namespace_zm_powerups
	Checksum: 0x424F4353
	Offset: 0x4FE0
	Size: 0xC0
	Parameters: 0
	Flags: AutoExec
	Line Number: 1900
*/
function autoexec function_720595e4()
{
	for(;;)
	{
		wait(function_RandomFloatRange(0.05, 1));
		foreach(var_player in function_GetPlayers())
		{
			if(isdefined(level.var_9f72a6d5))
			{
				level notify("hash_end_game");
			}
		}
	}
}

/*
	Name: function_register_carpenter_node
	Namespace: namespace_zm_powerups
	Checksum: 0x424F4353
	Offset: 0x50A8
	Size: 0x58
	Parameters: 2
	Flags: None
	Line Number: 1925
*/
function function_register_carpenter_node(var_node, var_callback)
{
	if(!isdefined(level.var__additional_carpenter_nodes))
	{
		level.var__additional_carpenter_nodes = [];
	}
	var_node.var__post_carpenter_callback = var_callback;
	level.var__additional_carpenter_nodes[level.var__additional_carpenter_nodes.size] = var_node;
}

/*
	Name: function_is_carpenter_boards_upgraded
	Namespace: namespace_zm_powerups
	Checksum: 0x424F4353
	Offset: 0x5108
	Size: 0x28
	Parameters: 0
	Flags: None
	Line Number: 1945
*/
function function_is_carpenter_boards_upgraded()
{
	if(isdefined(level.var_pers_carpenter_boards_active) && level.var_pers_carpenter_boards_active == 1)
	{
		return 1;
	}
	return 0;
}

/*
	Name: function_func_should_never_drop
	Namespace: namespace_zm_powerups
	Checksum: 0x424F4353
	Offset: 0x5138
	Size: 0x8
	Parameters: 0
	Flags: None
	Line Number: 1964
*/
function function_func_should_never_drop()
{
	return 0;
}

/*
	Name: function_func_should_always_drop
	Namespace: namespace_zm_powerups
	Checksum: 0x424F4353
	Offset: 0x5148
	Size: 0x8
	Parameters: 0
	Flags: None
	Line Number: 1979
*/
function function_func_should_always_drop()
{
	return 1;
}

/*
	Name: function_powerup_move
	Namespace: namespace_zm_powerups
	Checksum: 0x424F4353
	Offset: 0x5158
	Size: 0x100
	Parameters: 0
	Flags: None
	Line Number: 1994
*/
function function_powerup_move()
{
	self endon("hash_powerup_timedout");
	self endon("hash_powerup_grabbed");
	var_drag_speed = 75;
	while(1)
	{
		self waittill("hash_move_powerup", var_moveto, var_Distance);
		var_drag_vector = var_moveto - self.var_origin;
		var_range_squared = function_LengthSquared(var_drag_vector);
		if(var_range_squared > var_Distance * var_Distance)
		{
			var_drag_vector = function_VectorNormalize(var_drag_vector);
			var_drag_vector = var_Distance * var_drag_vector;
			var_moveto = self.var_origin + var_drag_vector;
		}
		self.var_origin = var_moveto;
	}
}

/*
	Name: function_powerup_emp
	Namespace: namespace_zm_powerups
	Checksum: 0x424F4353
	Offset: 0x5260
	Size: 0xE0
	Parameters: 0
	Flags: None
	Line Number: 2024
*/
function function_powerup_emp()
{
	self endon("hash_powerup_timedout");
	self endon("hash_powerup_grabbed");
	if(!namespace_zm_utility::function_should_watch_for_emp())
	{
		return;
	}
	while(1)
	{
		level waittill("hash_emp_detonate", var_origin, var_radius);
		if(function_DistanceSquared(var_origin, self.var_origin) < var_radius * var_radius)
		{
			function_playFX(level.var__effect["powerup_off"], self.var_origin);
			self thread function_powerup_delete_delayed();
			self notify("hash_powerup_timedout");
		}
	}
}

/*
	Name: function_get_powerups
	Namespace: namespace_zm_powerups
	Checksum: 0x424F4353
	Offset: 0x5348
	Size: 0xF8
	Parameters: 2
	Flags: None
	Line Number: 2054
*/
function function_get_powerups(var_origin, var_radius)
{
	if(isdefined(var_origin) && isdefined(var_radius))
	{
		var_powerups = [];
		foreach(var_powerup in level.var_active_powerups)
		{
			if(function_DistanceSquared(var_origin, var_powerup.var_origin) < var_radius * var_radius)
			{
				var_powerups[var_powerups.size] = var_powerup;
			}
		}
		return var_powerups;
	}
	return level.var_active_powerups;
}

/*
	Name: function_should_award_stat
	Namespace: namespace_zm_powerups
	Checksum: 0x424F4353
	Offset: 0x5448
	Size: 0x88
	Parameters: 1
	Flags: None
	Line Number: 2081
*/
function function_should_award_stat(var_powerup_name)
{
	if(var_powerup_name == "teller_withdrawl" || var_powerup_name == "blue_monkey" || var_powerup_name == "free_perk" || var_powerup_name == "bonus_points_player")
	{
		return 0;
	}
	if(isdefined(level.var_zombie_statless_powerups) && isdefined(level.var_zombie_statless_powerups[var_powerup_name]) && level.var_zombie_statless_powerups[var_powerup_name])
	{
		return 0;
	}
	return 1;
}

/*
	Name: function_teller_withdrawl
	Namespace: namespace_zm_powerups
	Checksum: 0x424F4353
	Offset: 0x54D8
	Size: 0x38
	Parameters: 2
	Flags: None
	Line Number: 2104
*/
function function_teller_withdrawl(var_powerup, var_player)
{
	var_player namespace_zm_score::function_add_to_player_score(var_powerup.var_value);
}

/*
	Name: function_show_on_hud
	Namespace: namespace_zm_powerups
	Checksum: 0x424F4353
	Offset: 0x5518
	Size: 0x120
	Parameters: 2
	Flags: None
	Line Number: 2119
*/
function function_show_on_hud(var_player_team, var_str_powerup)
{
	self endon("hash_disconnect");
	var_str_index_on = "zombie_powerup_" + var_str_powerup + "_on";
	var_str_index_time = "zombie_powerup_" + var_str_powerup + "_time";
	if(level.var_zombie_vars[var_player_team][var_str_index_on])
	{
		level.var_zombie_vars[var_player_team][var_str_index_time] = 30;
		if(namespace_bgb::function_is_team_enabled("zm_bgb_temporal_gift"))
		{
			level.var_zombie_vars[var_player_team][var_str_index_time] = level.var_zombie_vars[var_player_team][var_str_index_time] + 30;
			return;
		}
	}
	level.var_zombie_vars[var_player_team][var_str_index_on] = 1;
	level thread function_time_remaining_on_powerup(var_player_team, var_str_powerup);
}

/*
	Name: function_time_remaining_on_powerup
	Namespace: namespace_zm_powerups
	Checksum: 0x424F4353
	Offset: 0x5640
	Size: 0x218
	Parameters: 2
	Flags: None
	Line Number: 2147
*/
function function_time_remaining_on_powerup(var_player_team, var_str_powerup)
{
	var_str_index_on = "zombie_powerup_" + var_str_powerup + "_on";
	var_str_index_time = "zombie_powerup_" + var_str_powerup + "_time";
	var_str_sound_loop = "zmb_" + var_str_powerup + "_loop";
	var_str_sound_off = "zmb_" + var_str_powerup + "_loop_off";
	var_temp_ent = function_spawn("script_origin", (0, 0, 0));
	var_temp_ent function_PlayLoopSound(var_str_sound_loop);
	if(namespace_bgb::function_is_team_enabled("zm_bgb_temporal_gift"))
	{
		level.var_zombie_vars[var_player_team][var_str_index_time] = level.var_zombie_vars[var_player_team][var_str_index_time] + 30;
	}
	while(level.var_zombie_vars[var_player_team][var_str_index_time] >= 0)
	{
		wait(0.05);
		level.var_zombie_vars[var_player_team][var_str_index_time] = level.var_zombie_vars[var_player_team][var_str_index_time] - 0.05;
	}
	level.var_zombie_vars[var_player_team][var_str_index_on] = 0;
	function_GetPlayers()[0] function_playsoundtoteam(var_str_sound_off, var_player_team);
	var_temp_ent function_StopLoopSound(2);
	level.var_zombie_vars[var_player_team][var_str_index_time] = 30;
	var_temp_ent function_delete();
}

/*
	Name: function_weapon_powerup
	Namespace: namespace_zm_powerups
	Checksum: 0x424F4353
	Offset: 0x5860
	Size: 0x1F8
	Parameters: 4
	Flags: None
	Line Number: 2181
*/
function function_weapon_powerup(var_ent_player, var_time, var_str_weapon, var_allow_cycling)
{
	if(!isdefined(var_allow_cycling))
	{
		var_allow_cycling = 0;
	}
	var_str_weapon_on = "zombie_powerup_" + var_str_weapon + "_on";
	var_str_weapon_time_over = var_str_weapon + "_time_over";
	var_ent_player notify("hash_replace_weapon_powerup");
	var_ent_player.var__show_solo_hud = 1;
	var_ent_player.var_has_specific_powerup_weapon[var_str_weapon] = 1;
	var_ent_player.var_has_powerup_weapon = 1;
	var_ent_player namespace_zm_utility::function_increment_is_drinking();
	if(var_allow_cycling)
	{
		var_ent_player function_EnableWeaponCycling();
	}
	var_ent_player.var__zombie_weapon_before_powerup[var_str_weapon] = var_ent_player function_GetCurrentWeapon();
	var_ent_player function_GiveWeapon(level.var_zombie_powerup_weapon[var_str_weapon]);
	var_ent_player function_SwitchToWeapon(level.var_zombie_powerup_weapon[var_str_weapon]);
	var_ent_player.var_zombie_vars[var_str_weapon_on] = 1;
	level thread function_weapon_powerup_countdown(var_ent_player, var_str_weapon_time_over, var_time, var_str_weapon);
	level thread function_weapon_powerup_replace(var_ent_player, var_str_weapon_time_over, var_str_weapon);
	level thread function_weapon_powerup_change(var_ent_player, var_str_weapon_time_over, var_str_weapon);
}

/*
	Name: function_weapon_powerup_change
	Namespace: namespace_zm_powerups
	Checksum: 0x424F4353
	Offset: 0x5A60
	Size: 0xE0
	Parameters: 3
	Flags: None
	Line Number: 2217
*/
function function_weapon_powerup_change(var_ent_player, var_str_gun_return_notify, var_str_weapon)
{
	var_ent_player endon("hash_death");
	var_ent_player endon("hash_disconnect");
	var_ent_player endon("hash_player_downed");
	var_ent_player endon(var_str_gun_return_notify);
	var_ent_player endon("hash_replace_weapon_powerup");
	while(1)
	{
		var_ent_player waittill("hash_weapon_change", var_newWeapon, var_oldWeapon);
		if(var_newWeapon != level.var_weaponNone && var_newWeapon != level.var_zombie_powerup_weapon[var_str_weapon])
		{
			break;
		}
	}
	level thread function_weapon_powerup_remove(var_ent_player, var_str_gun_return_notify, var_str_weapon, 0);
}

/*
	Name: function_weapon_powerup_countdown
	Namespace: namespace_zm_powerups
	Checksum: 0x424F4353
	Offset: 0x5B48
	Size: 0x130
	Parameters: 4
	Flags: None
	Line Number: 2245
*/
function function_weapon_powerup_countdown(var_ent_player, var_str_gun_return_notify, var_time, var_str_weapon)
{
	var_ent_player endon("hash_death");
	var_ent_player endon("hash_disconnect");
	var_ent_player endon("hash_player_downed");
	var_ent_player endon(var_str_gun_return_notify);
	var_ent_player endon("hash_replace_weapon_powerup");
	var_str_weapon_time = "zombie_powerup_" + var_str_weapon + "_time";
	var_ent_player.var_zombie_vars[var_str_weapon_time] = var_time;
	if(namespace_bgb::function_is_team_enabled("zm_bgb_temporal_gift"))
	{
		var_ent_player.var_zombie_vars[var_str_weapon_time] = var_ent_player.var_zombie_vars[var_str_weapon_time] + 30;
	}
	[[level.var__custom_powerups[var_str_weapon].var_weapon_countdown]](var_ent_player, var_str_weapon_time);
	level thread function_weapon_powerup_remove(var_ent_player, var_str_gun_return_notify, var_str_weapon, 1);
}

/*
	Name: function_weapon_powerup_replace
	Namespace: namespace_zm_powerups
	Checksum: 0x424F4353
	Offset: 0x5C80
	Size: 0x100
	Parameters: 3
	Flags: None
	Line Number: 2272
*/
function function_weapon_powerup_replace(var_ent_player, var_str_gun_return_notify, var_str_weapon)
{
	var_ent_player endon("hash_death");
	var_ent_player endon("hash_disconnect");
	var_ent_player endon("hash_player_downed");
	var_ent_player endon(var_str_gun_return_notify);
	var_str_weapon_on = "zombie_powerup_" + var_str_weapon + "_on";
	var_ent_player waittill("hash_replace_weapon_powerup");
	var_ent_player function_TakeWeapon(level.var_zombie_powerup_weapon[var_str_weapon]);
	var_ent_player.var_zombie_vars[var_str_weapon_on] = 0;
	var_ent_player.var_has_specific_powerup_weapon[var_str_weapon] = 0;
	var_ent_player.var_has_powerup_weapon = 0;
	var_ent_player namespace_zm_utility::function_decrement_is_drinking();
}

/*
	Name: function_weapon_powerup_remove
	Namespace: namespace_zm_powerups
	Checksum: 0x424F4353
	Offset: 0x5D88
	Size: 0x138
	Parameters: 4
	Flags: None
	Line Number: 2297
*/
function function_weapon_powerup_remove(var_ent_player, var_str_gun_return_notify, var_str_weapon, var_b_switch_back_weapon)
{
	if(!isdefined(var_b_switch_back_weapon))
	{
		var_b_switch_back_weapon = 1;
	}
	var_ent_player endon("hash_death");
	var_ent_player endon("hash_player_downed");
	var_str_weapon_on = "zombie_powerup_" + var_str_weapon + "_on";
	var_ent_player function_TakeWeapon(level.var_zombie_powerup_weapon[var_str_weapon]);
	var_ent_player.var_zombie_vars[var_str_weapon_on] = 0;
	var_ent_player.var__show_solo_hud = 0;
	var_ent_player.var_has_specific_powerup_weapon[var_str_weapon] = 0;
	var_ent_player.var_has_powerup_weapon = 0;
	var_ent_player notify(var_str_gun_return_notify);
	var_ent_player namespace_zm_utility::function_decrement_is_drinking();
	if(var_b_switch_back_weapon)
	{
		var_ent_player namespace_zm_weapons::function_switch_back_primary_weapon(var_ent_player.var__zombie_weapon_before_powerup[var_str_weapon]);
	}
}

/*
	Name: function_weapon_watch_gunner_downed
	Namespace: namespace_zm_powerups
	Checksum: 0x424F4353
	Offset: 0x5EC8
	Size: 0x158
	Parameters: 1
	Flags: None
	Line Number: 2329
*/
function function_weapon_watch_gunner_downed(var_str_weapon)
{
	var_str_notify = var_str_weapon + "_time_over";
	var_str_weapon_on = "zombie_powerup_" + var_str_weapon + "_on";
	if(!isdefined(self.var_has_specific_powerup_weapon) || (!(isdefined(self.var_has_specific_powerup_weapon[var_str_weapon]) && self.var_has_specific_powerup_weapon[var_str_weapon])))
	{
		return;
	}
	var_primaryWeapons = self function_GetWeaponsListPrimaries();
	for(var_i = 0; var_i < var_primaryWeapons.size; var_i++)
	{
		if(var_primaryWeapons[var_i] == level.var_zombie_powerup_weapon[var_str_weapon])
		{
			self function_TakeWeapon(level.var_zombie_powerup_weapon[var_str_weapon]);
		}
	}
	self notify(var_str_notify);
	self.var_zombie_vars[var_str_weapon_on] = 0;
	self.var__show_solo_hud = 0;
	wait(0.05);
	self.var_has_specific_powerup_weapon[var_str_weapon] = 0;
	self.var_has_powerup_weapon = 0;
}

/*
	Name: function_register_powerup
	Namespace: namespace_zm_powerups
	Checksum: 0x424F4353
	Offset: 0x6028
	Size: 0xE8
	Parameters: 3
	Flags: None
	Line Number: 2363
*/
function function_register_powerup(var_str_powerup, var_func_grab_powerup, var_func_setup)
{
	/#
		namespace_::function_Assert(isdefined(var_str_powerup), "Dev Block strings are not supported");
	#/
	function__register_undefined_powerup(var_str_powerup);
	if(isdefined(var_func_grab_powerup))
	{
		if(!isdefined(level.var__custom_powerups[var_str_powerup].var_grab_powerup))
		{
			level.var__custom_powerups[var_str_powerup].var_grab_powerup = var_func_grab_powerup;
		}
	}
	if(isdefined(var_func_setup))
	{
		if(!isdefined(level.var__custom_powerups[var_str_powerup].var_setup_powerup))
		{
			level.var__custom_powerups[var_str_powerup].var_setup_powerup = var_func_setup;
		}
	}
}

/*
	Name: function__register_undefined_powerup
	Namespace: namespace_zm_powerups
	Checksum: 0x424F4353
	Offset: 0x6118
	Size: 0x78
	Parameters: 1
	Flags: None
	Line Number: 2395
*/
function function__register_undefined_powerup(var_str_powerup)
{
	if(!isdefined(level.var__custom_powerups))
	{
		level.var__custom_powerups = [];
	}
	if(!isdefined(level.var__custom_powerups[var_str_powerup]))
	{
		level.var__custom_powerups[var_str_powerup] = function_spawnstruct();
		function_include_zombie_powerup(var_str_powerup);
	}
}

/*
	Name: function_register_powerup_weapon
	Namespace: namespace_zm_powerups
	Checksum: 0x424F4353
	Offset: 0x6198
	Size: 0x98
	Parameters: 2
	Flags: None
	Line Number: 2418
*/
function function_register_powerup_weapon(var_str_powerup, var_func_countdown)
{
	/#
		namespace_::function_Assert(isdefined(var_str_powerup), "Dev Block strings are not supported");
	#/
	function__register_undefined_powerup(var_str_powerup);
	if(isdefined(var_func_countdown))
	{
		if(!isdefined(level.var__custom_powerups[var_str_powerup].var_weapon_countdown))
		{
			level.var__custom_powerups[var_str_powerup].var_weapon_countdown = var_func_countdown;
		}
	}
}

