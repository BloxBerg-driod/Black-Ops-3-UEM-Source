#include scripts\codescripts\struct;
#include scripts\shared\array_shared;
#include scripts\shared\clientfield_shared;
#include scripts\shared\exploder_shared;
#include scripts\shared\flag_shared;
#include scripts\shared\system_shared;
#include scripts\shared\util_shared;
#include scripts\shared\visionset_mgr_shared;
#include scripts\zm\_util;
#include scripts\zm\_zm;
#include scripts\zm\_zm_perks;
#include scripts\zm\_zm_pers_upgrades;
#include scripts\zm\_zm_pers_upgrades_functions;
#include scripts\zm\_zm_pers_upgrades_system;
#include scripts\zm\_zm_stats;
#include scripts\zm\_zm_utility;

#namespace namespace_zm_perk_quick_revive;

/*
	Name: function___init__sytem__
	Namespace: namespace_zm_perk_quick_revive
	Checksum: 0x424F4353
	Offset: 0x490
	Size: 0x38
	Parameters: 0
	Flags: AutoExec
	Line Number: 29
*/
function autoexec function___init__sytem__()
{
	namespace_system::function_register("zm_perk_quick_revive", &function___init__, undefined, undefined);
	return;
	ERROR: Exception occured: Stack empty.
}

/*
	Name: function___init__
	Namespace: namespace_zm_perk_quick_revive
	Checksum: 0x424F4353
	Offset: 0x4D0
	Size: 0x30
	Parameters: 0
	Flags: None
	Line Number: 46
*/
function function___init__()
{
	function_enable_quick_revive_perk_for_level();
	level.var_check_quickrevive_hotjoin = &function_check_quickrevive_for_hotjoin;
}

/*
	Name: function_enable_quick_revive_perk_for_level
	Namespace: namespace_zm_perk_quick_revive
	Checksum: 0x424F4353
	Offset: 0x508
	Size: 0x188
	Parameters: 0
	Flags: None
	Line Number: 62
*/
function function_enable_quick_revive_perk_for_level()
{
	namespace_zm_perks::function_register_perk_basic_info("specialty_quickrevive", "revive", &function_revive_cost_override, &"ZOMBIE_PERK_QUICKREVIVE", function_GetWeapon("zombie_perk_bottle_revive"));
	namespace_zm_perks::function_register_perk_precache_func("specialty_quickrevive", &function_quick_revive_precache);
	namespace_zm_perks::function_register_perk_clientfields("specialty_quickrevive", &function_quick_revive_register_clientfield, &function_quick_revive_set_clientfield);
	namespace_zm_perks::function_register_perk_machine("specialty_quickrevive", &function_quick_revive_perk_machine_setup);
	namespace_zm_perks::function_register_perk_threads("specialty_quickrevive", &function_give_quick_revive_perk, &function_take_quick_revive_perk);
	namespace_zm_perks::function_register_perk_host_migration_params("specialty_quickrevive", "vending_revive", "revive_light");
	namespace_zm_perks::function_register_perk_machine_power_override("specialty_quickrevive", &function_turn_revive_on);
	level namespace_flag::function_init("solo_revive");
	return;
	ERROR: Exception occured: Stack empty.
	ERROR: Exception occured: Stack empty.
}

/*
	Name: function_quick_revive_precache
	Namespace: namespace_zm_perk_quick_revive
	Checksum: 0x424F4353
	Offset: 0x698
	Size: 0xE0
	Parameters: 0
	Flags: None
	Line Number: 87
*/
function function_quick_revive_precache()
{
	if(isdefined(level.var_quick_revive_precache_override_func))
	{
		[[level.var_quick_revive_precache_override_func]]();
		return;
	}
	level.var__effect["revive_light"] = "zombie/fx_perk_quick_revive_zmb";
	level.var_machine_assets["specialty_quickrevive"] = function_spawnstruct();
	level.var_machine_assets["specialty_quickrevive"].var_weapon = function_GetWeapon("zombie_perk_bottle_revive");
	level.var_machine_assets["specialty_quickrevive"].var_off_model = "p7_zm_vending_revive";
	level.var_machine_assets["specialty_quickrevive"].var_on_model = "p7_zm_vending_revive";
}

/*
	Name: function_quick_revive_register_clientfield
	Namespace: namespace_zm_perk_quick_revive
	Checksum: 0x424F4353
	Offset: 0x780
	Size: 0x38
	Parameters: 0
	Flags: None
	Line Number: 111
*/
function function_quick_revive_register_clientfield()
{
	namespace_clientfield::function_register("clientuimodel", "hudItems.perks.quick_revive", 1, 2, "int");
}

/*
	Name: function_quick_revive_set_clientfield
	Namespace: namespace_zm_perk_quick_revive
	Checksum: 0x424F4353
	Offset: 0x7C0
	Size: 0x30
	Parameters: 1
	Flags: None
	Line Number: 126
*/
function function_quick_revive_set_clientfield(var_State)
{
	self namespace_clientfield::function_set_player_uimodel("hudItems.perks.quick_revive", var_State);
}

/*
	Name: function_quick_revive_perk_machine_setup
	Namespace: namespace_zm_perk_quick_revive
	Checksum: 0x424F4353
	Offset: 0x7F8
	Size: 0xC0
	Parameters: 4
	Flags: None
	Line Number: 141
*/
function function_quick_revive_perk_machine_setup(var_use_trigger, var_perk_machine, var_bump_trigger, var_collision)
{
	var_use_trigger.var_script_sound = "mus_perks_revive_jingle";
	var_use_trigger.var_script_string = "revive_perk";
	var_use_trigger.var_script_label = "mus_perks_revive_sting";
	var_use_trigger.var_target = "vending_revive";
	var_perk_machine.var_script_string = "revive_perk";
	var_perk_machine.var_targetname = "vending_revive";
	if(isdefined(var_bump_trigger))
	{
		var_bump_trigger.var_script_string = "revive_perk";
	}
}

/*
	Name: function_revive_cost_override
	Namespace: namespace_zm_perk_quick_revive
	Checksum: 0x424F4353
	Offset: 0x8C0
	Size: 0x38
	Parameters: 0
	Flags: None
	Line Number: 165
*/
function function_revive_cost_override()
{
	var_Solo = namespace_zm_perks::function_use_solo_revive();
	if(var_Solo)
	{
		return 500;
	}
	else
	{
		return 1500;
	}
}

/*
	Name: function_turn_revive_on
	Namespace: namespace_zm_perk_quick_revive
	Checksum: 0x424F4353
	Offset: 0x900
	Size: 0x750
	Parameters: 0
	Flags: None
	Line Number: 188
*/
function function_turn_revive_on()
{
	level endon("hash_stop_quickrevive_logic");
	level namespace_flag::function_wait_till("start_zombie_round_logic");
	var_solo_mode = 0;
	if(namespace_zm_perks::function_use_solo_revive())
	{
		var_solo_mode = 1;
	}
	if(var_solo_mode && (!(isdefined(level.var_solo_revive_init) && level.var_solo_revive_init)))
	{
		level.var_solo_revive_init = 1;
	}
	while(1)
	{
		var_machine = function_GetEntArray("vending_revive", "targetname");
		var_machine_triggers = function_GetEntArray("vending_revive", "target");
		for(var_i = 0; var_i < var_machine.size; var_i++)
		{
			if(level namespace_flag::function_exists("solo_game") && level namespace_flag::function_exists("solo_revive") && level namespace_flag::function_get("solo_game") && level namespace_flag::function_get("solo_revive"))
			{
				var_machine[var_i] function_ghost();
				var_machine[var_i] function_notsolid();
			}
			var_machine[var_i] function_SetModel(level.var_machine_assets["specialty_quickrevive"].var_off_model);
			if(isdefined(level.var_quick_revive_final_pos))
			{
				level.var_quick_revive_default_origin = level.var_quick_revive_final_pos;
			}
			if(!isdefined(level.var_quick_revive_default_origin))
			{
				level.var_quick_revive_default_origin = var_machine[var_i].var_origin;
				level.var_quick_revive_default_angles = var_machine[var_i].var_angles;
			}
			level.var_quick_revive_machine = var_machine[var_i];
		}
		namespace_Array::function_thread_all(var_machine_triggers, &namespace_zm_perks::function_set_power_on, 0);
		if(isdefined(level.var_initial_quick_revive_power_off) && level.var_initial_quick_revive_power_off)
		{
			level waittill("hash_revive_on");
		}
		else if(!var_solo_mode)
		{
			level waittill("hash_revive_on");
		}
		for(var_i = 0; var_i < var_machine.size; var_i++)
		{
			if(isdefined(var_machine[var_i].var_classname) && var_machine[var_i].var_classname == "script_model")
			{
				if(isdefined(var_machine[var_i].var_script_noteworthy) && var_machine[var_i].var_script_noteworthy == "clip")
				{
					var_machine_clip = var_machine[var_i];
					continue;
				}
				var_machine[var_i] function_SetModel(level.var_machine_assets["specialty_quickrevive"].var_on_model);
				var_machine[var_i] function_playsound("zmb_perks_power_on");
				var_machine[var_i] function_vibrate(VectorScale((0, -1, 0), 100), 0.3, 0.4, 3);
				var_machine_model = var_machine[var_i];
				var_machine[var_i] thread namespace_zm_perks::function_perk_fx("revive_light");
				namespace_exploder::function_exploder("quick_revive_lgts");
				var_machine[var_i] notify("hash_stop_loopsound");
				var_machine[var_i] thread namespace_zm_perks::function_play_loop_on_machine();
				if(isdefined(var_machine_triggers[var_i]))
				{
					var_machine_clip = var_machine_triggers[var_i].var_clip;
				}
				if(isdefined(var_machine_triggers[var_i]))
				{
					var_blocker_model = var_machine_triggers[var_i].var_blocker_model;
				}
			}
		}
		namespace_util::function_wait_network_frame();
		if(var_solo_mode && isdefined(var_machine_model) && (!(isdefined(var_machine_model.var_ishidden) && var_machine_model.var_ishidden)))
		{
			var_machine_model thread function_revive_solo_fx(var_machine_clip, var_blocker_model);
		}
		namespace_Array::function_thread_all(var_machine_triggers, &namespace_zm_perks::function_set_power_on, 1);
		if(isdefined(level.var_machine_assets["specialty_quickrevive"].var_power_on_callback))
		{
			namespace_Array::function_thread_all(var_machine, level.var_machine_assets["specialty_quickrevive"].var_power_on_callback);
		}
		level notify("hash_specialty_quickrevive_power_on");
		if(isdefined(var_machine_model))
		{
			var_machine_model.var_ishidden = 0;
		}
		var_notify_str = level namespace_util::function_waittill_any_return("revive_off", "revive_hide", "stop_quickrevive_logic");
		var_should_hide = 0;
		if(var_notify_str == "revive_hide")
		{
			var_should_hide = 1;
		}
		if(isdefined(level.var_machine_assets["specialty_quickrevive"].var_power_off_callback))
		{
			namespace_Array::function_thread_all(var_machine, level.var_machine_assets["specialty_quickrevive"].var_power_off_callback);
		}
		for(var_i = 0; var_i < var_machine.size; var_i++)
		{
			if(isdefined(var_machine[var_i].var_classname) && var_machine[var_i].var_classname == "script_model")
			{
				var_machine[var_i] namespace_zm_perks::function_turn_perk_off(var_should_hide);
			}
		}
	}
}

/*
	Name: function_reenable_quickrevive
	Namespace: namespace_zm_perk_quick_revive
	Checksum: 0x424F4353
	Offset: 0x1058
	Size: 0x668
	Parameters: 2
	Flags: None
	Line Number: 305
*/
function function_reenable_quickrevive(var_machine_clip, var_solo_mode)
{
	if(isdefined(level.var_revive_machine_spawned) && (!(isdefined(level.var_revive_machine_spawned) && level.var_revive_machine_spawned)))
	{
		return;
	}
	wait(0.1);
	var_power_state = 0;
	if(isdefined(var_solo_mode) && var_solo_mode)
	{
		var_power_state = 1;
		var_should_pause = 1;
		var_players = function_GetPlayers();
		foreach(var_player in var_players)
		{
			if(isdefined(var_player.var_lives) && var_player.var_lives > 0 && var_power_state)
			{
				var_should_pause = 0;
				continue;
			}
			if(isdefined(var_player.var_lives) && var_player.var_lives < 1)
			{
				var_should_pause = 1;
			}
		}
		if(var_should_pause)
		{
			namespace_zm_perks::function_perk_pause("specialty_quickrevive");
		}
		else
		{
			namespace_zm_perks::function_perk_unpause("specialty_quickrevive");
		}
		if(isdefined(level.var_solo_revive_init) && level.var_solo_revive_init && level namespace_flag::function_get("solo_revive"))
		{
			function_disable_quickrevive(var_machine_clip);
			return;
		}
		function_update_quickrevive_power_state(1);
		function_unhide_quickrevive();
		function_restart_quickrevive();
		level notify("hash_revive_off");
		wait(0.1);
		level notify("hash_stop_quickrevive_logic");
	}
	else if(!(isdefined(level.var__dont_unhide_quickervive_on_hotjoin) && level.var__dont_unhide_quickervive_on_hotjoin))
	{
		function_unhide_quickrevive();
		level notify("hash_revive_off");
		wait(0.1);
	}
	level notify("hash_revive_hide");
	level notify("hash_stop_quickrevive_logic");
	function_restart_quickrevive();
	var_triggers = function_GetEntArray("zombie_vending", "targetname");
	foreach(var_trigger in var_triggers)
	{
		if(!isdefined(var_trigger.var_script_noteworthy))
		{
			continue;
		}
		if(var_trigger.var_script_noteworthy == "specialty_quickrevive")
		{
			if(isdefined(var_trigger.var_script_int))
			{
				if(level namespace_flag::function_get("power_on" + var_trigger.var_script_int))
				{
					var_power_state = 1;
					continue;
				}
			}
			if(level namespace_flag::function_get("power_on"))
			{
				var_power_state = 1;
			}
		}
	}
	function_update_quickrevive_power_state(var_power_state);
	level thread function_turn_revive_on();
	if(var_power_state)
	{
		namespace_zm_perks::function_perk_unpause("specialty_quickrevive");
		level notify("hash_revive_on");
		wait(0.1);
		level notify("hash_specialty_quickrevive_power_on");
	}
	else
	{
		namespace_zm_perks::function_perk_pause("specialty_quickrevive");
	}
	if(!(isdefined(var_solo_mode) && var_solo_mode))
	{
		return;
	}
	var_should_pause = 1;
	var_players = function_GetPlayers();
	foreach(var_player in var_players)
	{
		if(!namespace_zm_utility::function_is_player_valid(var_player))
		{
			continue;
		}
		if(var_player function_hasPerk("specialty_quickrevive"))
		{
			if(!isdefined(var_player.var_lives))
			{
				var_player.var_lives = 0;
			}
			if(!isdefined(level.var_solo_lives_given))
			{
				level.var_solo_lives_given = 0;
			}
			level.var_solo_lives_given++;
			var_player.var_lives++;
			if(isdefined(var_player.var_lives) && var_player.var_lives > 0 && var_power_state)
			{
				var_should_pause = 0;
				continue;
			}
			var_should_pause = 1;
		}
	}
	if(var_should_pause)
	{
		namespace_zm_perks::function_perk_pause("specialty_quickrevive");
	}
	else
	{
		namespace_zm_perks::function_perk_unpause("specialty_quickrevive");
	}
}

/*
	Name: function_update_quick_revive
	Namespace: namespace_zm_perk_quick_revive
	Checksum: 0x424F4353
	Offset: 0x16C8
	Size: 0xA0
	Parameters: 1
	Flags: None
	Line Number: 447
*/
function function_update_quick_revive(var_solo_mode)
{
	if(!isdefined(var_solo_mode))
	{
		var_solo_mode = 0;
	}
	var_clip = undefined;
	if(isdefined(level.var_quick_revive_machine_clip))
	{
		var_clip = level.var_quick_revive_machine_clip;
	}
	level.var__custom_perks["specialty_quickrevive"].var_cost = function_revive_cost_override();
	level.var_quick_revive_machine thread function_reenable_quickrevive(var_clip, var_solo_mode);
}

/*
	Name: function_check_quickrevive_for_hotjoin
	Namespace: namespace_zm_perk_quick_revive
	Checksum: 0x424F4353
	Offset: 0x1770
	Size: 0x180
	Parameters: 0
	Flags: None
	Line Number: 472
*/
function function_check_quickrevive_for_hotjoin()
{
	level notify("hash_notify_check_quickrevive_for_hotjoin");
	level endon("hash_notify_check_quickrevive_for_hotjoin");
	var_solo_mode = 0;
	var_should_update = 0;
	wait(0.05);
	var_players = function_GetPlayers();
	if(var_players.size == 1 || (isdefined(level.var_force_solo_quick_revive) && level.var_force_solo_quick_revive))
	{
		var_solo_mode = 1;
		if(!level namespace_flag::function_get("solo_game"))
		{
			var_should_update = 1;
		}
		level namespace_flag::function_set("solo_game");
	}
	else if(level namespace_flag::function_get("solo_game"))
	{
		var_should_update = 1;
	}
	level namespace_flag::function_clear("solo_game");
	level.var_using_solo_revive = var_solo_mode;
	level.var_revive_machine_is_solo = var_solo_mode;
	namespace_zm::function_set_default_laststand_pistol(var_solo_mode);
	if(var_should_update && isdefined(level.var_quick_revive_machine))
	{
		function_update_quick_revive(var_solo_mode);
	}
}

/*
	Name: function_revive_solo_fx
	Namespace: namespace_zm_perk_quick_revive
	Checksum: 0x424F4353
	Offset: 0x18F8
	Size: 0x390
	Parameters: 2
	Flags: None
	Line Number: 513
*/
function function_revive_solo_fx(var_machine_clip, var_blocker_model)
{
	if(level namespace_flag::function_exists("solo_revive") && level namespace_flag::function_get("solo_revive") && !level namespace_flag::function_get("solo_game"))
	{
		return;
	}
	if(isdefined(var_machine_clip))
	{
		level.var_quick_revive_machine_clip = var_machine_clip;
	}
	level notify("hash_revive_solo_fx");
	level endon("hash_revive_solo_fx");
	self endon("hash_death");
	level namespace_flag::function_wait_till("solo_revive");
	if(isdefined(level.var_revive_solo_fx_func))
	{
		level thread [[level.var_revive_solo_fx_func]]();
	}
	wait(2);
	self function_playsound("zmb_box_move");
	function_playsoundatposition("zmb_whoosh", self.var_origin);
	if(isdefined(self.var__linked_ent))
	{
		self function_Unlink();
	}
	self function_moveto(self.var_origin + VectorScale((0, 0, 1), 40), 3);
	if(isdefined(level.var_custom_vibrate_func))
	{
		[[level.var_custom_vibrate_func]](self);
	}
	else
	{
		var_direction = self.var_origin;
		var_direction = (var_direction[1], var_direction[0], 0);
		if(var_direction[1] < 0 || (var_direction[0] > 0 && var_direction[1] > 0))
		{
			var_direction = (var_direction[0], var_direction[1] * -1, 0);
		}
		else if(var_direction[0] < 0)
		{
			var_direction = (var_direction[0] * -1, var_direction[1], 0);
		}
		self function_vibrate(var_direction, 10, 0.5, 5);
	}
	self waittill("hash_movedone");
	function_playFX(level.var__effect["poltergeist"], self.var_origin);
	function_playsoundatposition("zmb_box_poof", self.var_origin);
	if(isdefined(self.var_FX))
	{
		self.var_FX function_Unlink();
		self.var_FX function_delete();
	}
	if(isdefined(var_machine_clip))
	{
		var_machine_clip function_Hide();
		var_machine_clip function_connectpaths();
	}
	if(isdefined(var_blocker_model))
	{
		var_blocker_model function_show();
	}
	level notify("hash_revive_hide");
}

/*
	Name: function_disable_quickrevive
	Namespace: namespace_zm_perk_quick_revive
	Checksum: 0x424F4353
	Offset: 0x1C90
	Size: 0x4F0
	Parameters: 1
	Flags: None
	Line Number: 587
*/
function function_disable_quickrevive(var_machine_clip)
{
	if(isdefined(level.var_solo_revive_init) && level.var_solo_revive_init && level namespace_flag::function_get("solo_revive") && isdefined(level.var_quick_revive_machine))
	{
		var_triggers = function_GetEntArray("zombie_vending", "targetname");
		foreach(var_trigger in var_triggers)
		{
			if(!isdefined(var_trigger.var_script_noteworthy))
			{
				continue;
			}
			if(var_trigger.var_script_noteworthy == "specialty_quickrevive")
			{
				var_trigger function_TriggerEnable(0);
			}
		}
		foreach(var_item in level.var_powered_items)
		{
			if(isdefined(var_item.var_target) && isdefined(var_item.var_target.var_script_noteworthy) && var_item.var_target.var_script_noteworthy == "specialty_quickrevive")
			{
				var_item.var_power = 1;
				var_item.var_self_powered = 1;
			}
		}
		if(isdefined(level.var_quick_revive_machine.var_original_pos))
		{
			level.var_quick_revive_default_origin = level.var_quick_revive_machine.var_original_pos;
			level.var_quick_revive_default_angles = level.var_quick_revive_machine.var_original_angles;
		}
		var_move_org = level.var_quick_revive_default_origin;
		if(isdefined(level.var_quick_revive_linked_ent))
		{
			var_move_org = level.var_quick_revive_linked_ent.var_origin;
			if(isdefined(level.var_quick_revive_linked_ent_offset))
			{
				var_move_org = var_move_org + level.var_quick_revive_linked_ent_offset;
			}
			level.var_quick_revive_machine function_Unlink();
		}
		level.var_quick_revive_machine function_moveto(var_move_org + VectorScale((0, 0, 1), 40), 3);
		var_direction = level.var_quick_revive_machine.var_origin;
		var_direction = (var_direction[1], var_direction[0], 0);
		if(var_direction[1] < 0 || (var_direction[0] > 0 && var_direction[1] > 0))
		{
			var_direction = (var_direction[0], var_direction[1] * -1, 0);
		}
		else if(var_direction[0] < 0)
		{
			var_direction = (var_direction[0] * -1, var_direction[1], 0);
		}
		level.var_quick_revive_machine function_vibrate(var_direction, 10, 0.5, 4);
		level.var_quick_revive_machine waittill("hash_movedone");
		level.var_quick_revive_machine function_Hide();
		level.var_quick_revive_machine.var_ishidden = 1;
		if(isdefined(level.var_quick_revive_machine_clip))
		{
			level.var_quick_revive_machine_clip function_Hide();
			level.var_quick_revive_machine_clip function_connectpaths();
		}
		function_playFX(level.var__effect["poltergeist"], level.var_quick_revive_machine.var_origin);
		if(isdefined(level.var_quick_revive_trigger) && isdefined(level.var_quick_revive_trigger.var_blocker_model))
		{
			level.var_quick_revive_trigger.var_blocker_model function_show();
		}
		level notify("hash_revive_hide");
		return;
	}
	ERROR: Exception occured: Stack empty.
}

/*
	Name: function_unhide_quickrevive
	Namespace: namespace_zm_perk_quick_revive
	Checksum: 0x424F4353
	Offset: 0x2188
	Size: 0x418
	Parameters: 0
	Flags: None
	Line Number: 667
*/
function function_unhide_quickrevive()
{
	while(namespace_zm_perks::function_players_are_in_perk_area(level.var_quick_revive_machine))
	{
		wait(0.1);
	}
	if(isdefined(level.var_quick_revive_machine_clip))
	{
		level.var_quick_revive_machine_clip function_show();
		level.var_quick_revive_machine_clip function_disconnectpaths();
	}
	if(isdefined(level.var_quick_revive_final_pos))
	{
		level.var_quick_revive_machine.var_origin = level.var_quick_revive_final_pos;
	}
	function_playFX(level.var__effect["poltergeist"], level.var_quick_revive_machine.var_origin);
	if(isdefined(level.var_quick_revive_trigger) && isdefined(level.var_quick_revive_trigger.var_blocker_model))
	{
		level.var_quick_revive_trigger.var_blocker_model function_Hide();
	}
	level.var_quick_revive_machine function_show();
	level.var_quick_revive_machine function_solid();
	if(isdefined(level.var_quick_revive_machine.var_original_pos))
	{
		level.var_quick_revive_default_origin = level.var_quick_revive_machine.var_original_pos;
		level.var_quick_revive_default_angles = level.var_quick_revive_machine.var_original_angles;
	}
	var_direction = level.var_quick_revive_machine.var_origin;
	var_direction = (var_direction[1], var_direction[0], 0);
	if(var_direction[1] < 0 || (var_direction[0] > 0 && var_direction[1] > 0))
	{
		var_direction = (var_direction[0], var_direction[1] * -1, 0);
	}
	else if(var_direction[0] < 0)
	{
		var_direction = (var_direction[0] * -1, var_direction[1], 0);
	}
	var_org = level.var_quick_revive_default_origin;
	if(isdefined(level.var_quick_revive_linked_ent))
	{
		var_org = level.var_quick_revive_linked_ent.var_origin;
		if(isdefined(level.var_quick_revive_linked_ent_offset))
		{
			var_org = var_org + level.var_quick_revive_linked_ent_offset;
		}
	}
	if(!(isdefined(level.var_quick_revive_linked_ent_moves) && level.var_quick_revive_linked_ent_moves) && level.var_quick_revive_machine.var_origin != var_org)
	{
		level.var_quick_revive_machine function_moveto(var_org, 3);
		level.var_quick_revive_machine function_vibrate(var_direction, 10, 0.5, 2.9);
		level.var_quick_revive_machine waittill("hash_movedone");
		level.var_quick_revive_machine.var_angles = level.var_quick_revive_default_angles;
	}
	else if(isdefined(level.var_quick_revive_linked_ent))
	{
		var_org = level.var_quick_revive_linked_ent.var_origin;
		if(isdefined(level.var_quick_revive_linked_ent_offset))
		{
			var_org = var_org + level.var_quick_revive_linked_ent_offset;
		}
		level.var_quick_revive_machine.var_origin = var_org;
	}
	level.var_quick_revive_machine function_vibrate(VectorScale((0, -1, 0), 100), 0.3, 0.4, 3);
	if(isdefined(level.var_quick_revive_linked_ent))
	{
		level.var_quick_revive_machine function_LinkTo(level.var_quick_revive_linked_ent);
	}
	level.var_quick_revive_machine.var_ishidden = 0;
}

/*
	Name: function_restart_quickrevive
	Namespace: namespace_zm_perk_quick_revive
	Checksum: 0x424F4353
	Offset: 0x25A8
	Size: 0x118
	Parameters: 0
	Flags: None
	Line Number: 747
*/
function function_restart_quickrevive()
{
	var_triggers = function_GetEntArray("zombie_vending", "targetname");
	foreach(var_trigger in var_triggers)
	{
		if(!isdefined(var_trigger.var_script_noteworthy))
		{
			continue;
		}
		if(var_trigger.var_script_noteworthy == "specialty_quickrevive")
		{
			var_trigger notify("hash_stop_quickrevive_logic");
			var_trigger thread namespace_zm_perks::function_vending_trigger_think();
			var_trigger function_TriggerEnable(1);
		}
	}
}

/*
	Name: function_update_quickrevive_power_state
	Namespace: namespace_zm_perk_quick_revive
	Checksum: 0x424F4353
	Offset: 0x26C8
	Size: 0x1C8
	Parameters: 1
	Flags: None
	Line Number: 775
*/
function function_update_quickrevive_power_state(var_poweron)
{
	foreach(var_item in level.var_powered_items)
	{
		if(isdefined(var_item.var_target) && isdefined(var_item.var_target.var_script_noteworthy) && var_item.var_target.var_script_noteworthy == "specialty_quickrevive")
		{
			if(var_item.var_power && !var_poweron)
			{
				if(!isdefined(var_item.var_powered_count))
				{
					var_item.var_powered_count = 0;
				}
				else if(var_item.var_powered_count > 0)
				{
					var_item.var_powered_count--;
				}
			}
			else if(!var_item.var_power && var_poweron)
			{
				if(!isdefined(var_item.var_powered_count))
				{
					var_item.var_powered_count = 0;
				}
				var_item.var_powered_count++;
			}
			if(!isdefined(var_item.var_depowered_count))
			{
				var_item.var_depowered_count = 0;
			}
			var_item.var_power = var_poweron;
		}
	}
}

/*
	Name: function_solo_revive_buy_trigger_move
	Namespace: namespace_zm_perk_quick_revive
	Checksum: 0x424F4353
	Offset: 0x2898
	Size: 0xD0
	Parameters: 1
	Flags: None
	Line Number: 819
*/
function function_solo_revive_buy_trigger_move(var_revive_trigger_noteworthy)
{
	self endon("hash_death");
	var_revive_perk_triggers = function_GetEntArray(var_revive_trigger_noteworthy, "script_noteworthy");
	foreach(var_revive_perk_trigger in var_revive_perk_triggers)
	{
		self thread function_solo_revive_buy_trigger_move_trigger(var_revive_perk_trigger);
	}
	return;
	ERROR: Exception occured: Stack empty.
}

/*
	Name: function_solo_revive_buy_trigger_move_trigger
	Namespace: namespace_zm_perk_quick_revive
	Checksum: 0x424F4353
	Offset: 0x2970
	Size: 0xC8
	Parameters: 1
	Flags: None
	Line Number: 841
*/
function function_solo_revive_buy_trigger_move_trigger(var_revive_perk_trigger)
{
	self endon("hash_death");
	var_revive_perk_trigger function_SetInvisibleToPlayer(self);
	if(level.var_solo_lives_given >= 3)
	{
		var_revive_perk_trigger function_TriggerEnable(0);
		namespace_exploder::function_stop_exploder("quick_revive_lgts");
		if(isdefined(level.var__solo_revive_machine_expire_func))
		{
			var_revive_perk_trigger [[level.var__solo_revive_machine_expire_func]]();
			return;
		}
	}
	while(self.var_lives > 0)
	{
		wait(0.1);
	}
	var_revive_perk_trigger function_SetVisibleToPlayer(self);
}

/*
	Name: function_give_quick_revive_perk
	Namespace: namespace_zm_perk_quick_revive
	Checksum: 0x424F4353
	Offset: 0x2A40
	Size: 0xB0
	Parameters: 0
	Flags: None
	Line Number: 872
*/
function function_give_quick_revive_perk()
{
	if(namespace_zm_perks::function_use_solo_revive())
	{
		self.var_lives = 1;
		if(!isdefined(level.var_solo_lives_given))
		{
			level.var_solo_lives_given = 0;
		}
		if(isdefined(level.var_solo_game_free_player_quickrevive))
		{
			level.var_solo_game_free_player_quickrevive = undefined;
		}
		else
		{
			level.var_solo_lives_given++;
		}
		if(level.var_solo_lives_given >= 3)
		{
			level namespace_flag::function_set("solo_revive");
		}
		self thread function_solo_revive_buy_trigger_move("specialty_quickrevive");
	}
}

/*
	Name: function_take_quick_revive_perk
	Namespace: namespace_zm_perk_quick_revive
	Checksum: 0x424F4353
	Offset: 0x2AF8
	Size: 0x1C
	Parameters: 3
	Flags: None
	Line Number: 907
*/
function function_take_quick_revive_perk(var_b_pause, var_str_perk, var_str_result)
{
}

