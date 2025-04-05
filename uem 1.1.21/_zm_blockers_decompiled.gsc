#include scripts\codescripts\struct;
#include scripts\shared\array_shared;
#include scripts\shared\clientfield_shared;
#include scripts\shared\demo_shared;
#include scripts\shared\flag_shared;
#include scripts\shared\laststand_shared;
#include scripts\shared\scoreevents_shared;
#include scripts\shared\system_shared;
#include scripts\shared\trigger_shared;
#include scripts\shared\util_shared;
#include scripts\zm\_util;
#include scripts\zm\_zm_audio;
#include scripts\zm\_zm_daily_challenges;
#include scripts\zm\_zm_laststand;
#include scripts\zm\_zm_pers_upgrades_functions;
#include scripts\zm\_zm_score;
#include scripts\zm\_zm_spawner;
#include scripts\zm\_zm_stats;
#include scripts\zm\_zm_unitrigger;
#include scripts\zm\_zm_utility;
#include scripts\zm\_zm_zonemgr;

#namespace namespace_zm_blockers;

/*
	Name: function___init__sytem__
	Namespace: namespace_zm_blockers
	Checksum: 0x424F4353
	Offset: 0x9E8
	Size: 0x40
	Parameters: 0
	Flags: AutoExec
	Line Number: 34
*/
function autoexec function___init__sytem__()
{
	namespace_system::function_register("zm_blockers", &function___init__, &function___main__, undefined);
	return;
}

/*
	Name: function___init__
	Namespace: namespace_zm_blockers
	Checksum: 0x424F4353
	Offset: 0xA30
	Size: 0x78
	Parameters: 0
	Flags: None
	Line Number: 50
*/
function function___init__()
{
	namespace_zm_utility::function_add_zombie_hint("default_buy_debris", &"ZOMBIE_BUTTON_BUY_CLEAR_DEBRIS_COST");
	namespace_zm_utility::function_add_zombie_hint("default_buy_door", &"ZOMBIE_BUTTON_BUY_OPEN_DOOR_COST");
	namespace_zm_utility::function_add_zombie_hint("default_buy_door_close", &"ZOMBIE_BUTTON_BUY_CLOSE_DOOR");
	function_init_blockers();
	return;
	.var_0 = undefined;
}

/*
	Name: function___main__
	Namespace: namespace_zm_blockers
	Checksum: 0x424F4353
	Offset: 0xAB0
	Size: 0x48
	Parameters: 0
	Flags: None
	Line Number: 70
*/
function function___main__()
{
	if(isdefined(level.var_quantum_bomb_register_result_func))
	{
		[[level.var_quantum_bomb_register_result_func]]("open_nearest_door", &function_quantum_bomb_open_nearest_door_result, 35, &function_quantum_bomb_open_nearest_door_validation);
	}
}

/*
	Name: function_init_blockers
	Namespace: namespace_zm_blockers
	Checksum: 0x424F4353
	Offset: 0xB00
	Size: 0x168
	Parameters: 0
	Flags: None
	Line Number: 88
*/
function function_init_blockers()
{
	level.var_exterior_goals = namespace_struct::function_get_array("exterior_goal", "targetname");
	namespace_Array::function_thread_all(level.var_exterior_goals, &function_blocker_init);
	var_zombie_doors = function_GetEntArray("zombie_door", "targetname");
	if(isdefined(var_zombie_doors))
	{
		level namespace_flag::function_init("door_can_close");
		namespace_Array::function_thread_all(var_zombie_doors, &function_door_init);
	}
	var_zombie_debris = function_GetEntArray("zombie_debris", "targetname");
	namespace_Array::function_thread_all(var_zombie_debris, &function_debris_init);
	var_flag_blockers = function_GetEntArray("flag_blocker", "targetname");
	namespace_Array::function_thread_all(var_flag_blockers, &function_flag_blocker);
}

/*
	Name: function_door_init
	Namespace: namespace_zm_blockers
	Checksum: 0x424F4353
	Offset: 0xC70
	Size: 0x438
	Parameters: 0
	Flags: None
	Line Number: 114
*/
function function_door_init()
{
	self.var_type = undefined;
	self.var_purchaser = undefined;
	self.var__door_open = 0;
	var_ent_targets = function_GetEntArray(self.var_target, "targetname");
	var_node_targets = function_GetNodeArray(self.var_target, "targetname");
	var_targets = function_ArrayCombine(var_ent_targets, var_node_targets, 0, 1);
	if(isdefined(self.var_script_flag) && !isdefined(level.var_flag[self.var_script_flag]))
	{
		if(isdefined(self.var_script_flag))
		{
			var_tokens = function_StrTok(self.var_script_flag, ",");
			for(var_i = 0; var_i < var_tokens.size; var_i++)
			{
				level namespace_flag::function_init(self.var_script_flag);
			}
		}
	}
	else if(!isdefined(self.var_script_noteworthy))
	{
		self.var_script_noteworthy = "default";
	}
	self.var_doors = [];
	for(var_i = 0; var_i < var_targets.size; var_i++)
	{
		var_targets[var_i] function_door_classify(self);
		if(!isdefined(var_targets[var_i].var_og_origin))
		{
			var_targets[var_i].var_og_origin = var_targets[var_i].var_origin;
			var_targets[var_i].var_og_angles = var_targets[var_i].var_angles;
		}
	}
	var_cost = 1000;
	if(isdefined(self.var_zombie_cost))
	{
		var_cost = self.var_zombie_cost;
	}
	self function_setcursorhint("HINT_NOICON");
	self thread function_blocker_update_prompt_visibility();
	self thread function_door_think();
	if(isdefined(self.var_script_noteworthy))
	{
		if(self.var_script_noteworthy == "electric_door" || self.var_script_noteworthy == "electric_buyable_door")
		{
			if(function_GetDvarString("ui_gametype") == "zgrief")
			{
				self function_SetInvisibleToAll();
				return;
			}
			self function_setHintString(&"ZOMBIE_NEED_POWER");
			if(isdefined(level.var_door_dialog_function))
			{
				self thread [[level.var_door_dialog_function]]();
				return;
			}
		}
		else if(self.var_script_noteworthy == "local_electric_door")
		{
			if(function_GetDvarString("ui_gametype") == "zgrief")
			{
				self function_SetInvisibleToAll();
				return;
			}
			self function_setHintString(&"ZOMBIE_NEED_LOCAL_POWER");
			if(isdefined(level.var_door_dialog_function))
			{
				self thread [[level.var_door_dialog_function]]();
				return;
			}
		}
		else if(self.var_script_noteworthy == "kill_counter_door")
		{
			self function_setHintString(&"ZOMBIE_DOOR_ACTIVATE_COUNTER", var_cost);
			return;
		}
	}
	self namespace_zm_utility::function_set_hint_string(self, "default_buy_door", var_cost);
}

/*
	Name: function_door_classify
	Namespace: namespace_zm_blockers
	Checksum: 0x424F4353
	Offset: 0x10B0
	Size: 0x2B8
	Parameters: 1
	Flags: None
	Line Number: 204
*/
function function_door_classify(var_parent_trig)
{
	if(isdefined(self.var_script_noteworthy) && self.var_script_noteworthy == "air_buy_gate")
	{
		function_UnlinkTraversal(self);
		var_parent_trig.var_doors[var_parent_trig.var_doors.size] = self;
		return;
	}
	if(isdefined(self.var_script_noteworthy) && self.var_script_noteworthy == "clip")
	{
		var_parent_trig.var_clip = self;
		var_parent_trig.var_script_string = "clip";
	}
	else if(!isdefined(self.var_script_string))
	{
		if(isdefined(self.var_script_angles))
		{
			self.var_script_string = "rotate";
		}
		else if(isdefined(self.var_script_vector))
		{
			self.var_script_string = "move";
		}
	}
	else if(!isdefined(self.var_script_string))
	{
		self.var_script_string = "";
	}
	switch(self.var_script_string)
	{
		case "anim":
		{
			/#
				namespace_::function_Assert(isdefined(self.var_script_animname), "Dev Block strings are not supported" + self.var_targetname);
			#/
			/#
				namespace_::function_Assert(isdefined(level.var_scr_anim[self.var_script_animname]), "Dev Block strings are not supported" + self.var_script_animname);
			#/
			/#
				namespace_::function_Assert(isdefined(level.var_blocker_anim_func), "Dev Block strings are not supported");
				break;
			#/
		}
		case "counter_1s":
		{
			var_parent_trig.var_counter_1s = self;
			return;
		}
		case "counter_10s":
		{
			var_parent_trig.var_counter_10s = self;
			return;
		}
		case "counter_100s":
		{
			var_parent_trig.var_counter_100s = self;
			return;
		}
		case "explosives":
		{
			if(!isdefined(var_parent_trig.var_explosives))
			{
				var_parent_trig.var_explosives = [];
			}
			var_parent_trig.var_explosives[var_parent_trig.var_explosives.size] = self;
			return;
		}
	}
	if(self.var_classname == "script_brushmodel")
	{
		self function_disconnectpaths();
	}
	var_parent_trig.var_doors[var_parent_trig.var_doors.size] = self;
}

/*
	Name: function_door_buy
	Namespace: namespace_zm_blockers
	Checksum: 0x424F4353
	Offset: 0x1370
	Size: 0x368
	Parameters: 0
	Flags: None
	Line Number: 289
*/
function function_door_buy()
{
	self waittill("hash_trigger", var_who, var_force);
	if(isdefined(level.var_custom_door_buy_check))
	{
		if(!var_who [[level.var_custom_door_buy_check]](self))
		{
			return 0;
		}
	}
	if(function_GetDvarInt("zombie_unlock_all") > 0 || (isdefined(var_force) && var_force))
	{
		return 1;
	}
	if(!var_who function_useButtonPressed())
	{
		return 0;
	}
	if(var_who namespace_zm_utility::function_in_revive_trigger())
	{
		return 0;
	}
	if(var_who.var_IS_DRINKING > 0)
	{
		return 0;
	}
	var_cost = 0;
	var_upgraded = 0;
	if(namespace_zm_utility::function_is_player_valid(var_who))
	{
		var_players = function_GetPlayers();
		var_cost = self.var_zombie_cost;
		if(self.var__door_open == 1)
		{
			self.var_purchaser = undefined;
		}
		else if(var_who namespace_zm_score::function_can_player_purchase(var_cost))
		{
			var_who namespace_zm_score::function_minus_to_player_score(var_cost);
			namespace_scoreevents::function_processScoreEvent("open_door", var_who);
			namespace_demo::function_bookmark("zm_player_door", GetTime(), var_who);
			var_who namespace_zm_stats::function_increment_client_stat("doors_purchased");
			var_who namespace_zm_stats::function_increment_player_stat("doors_purchased");
			var_who namespace_zm_stats::function_increment_challenge_stat("SURVIVALIST_BUY_DOOR");
			self.var_purchaser = var_who;
		}
		else
		{
			namespace_zm_utility::function_play_sound_at_pos("no_purchase", self.var_doors[0].var_origin);
			if(isdefined(level.var_custom_door_deny_vo_func))
			{
				var_who thread [[level.var_custom_door_deny_vo_func]]();
			}
			else if(isdefined(level.var_custom_generic_deny_vo_func))
			{
				var_who thread [[level.var_custom_generic_deny_vo_func]](1);
			}
			else
			{
				var_who namespace_zm_audio::function_create_and_play_dialog("general", "outofmoney");
			}
			return 0;
		}
	}
	if(isdefined(level.var__door_open_rumble_func))
	{
		var_who thread [[level.var__door_open_rumble_func]]();
	}
	var_who function_RecordMapEvent(5, GetTime(), var_who.var_origin, level.var_round_number, var_cost);
	var_who namespace_zm_stats::function_increment_challenge_stat("ZM_DAILY_PURCHASE_DOORS");
	return 1;
}

/*
	Name: function_blocker_update_prompt_visibility
	Namespace: namespace_zm_blockers
	Checksum: 0x424F4353
	Offset: 0x16E0
	Size: 0x138
	Parameters: 0
	Flags: None
	Line Number: 372
*/
function function_blocker_update_prompt_visibility()
{
	self endon("hash_kill_door_think");
	self endon("hash_kill_debris_prompt_thread");
	self endon("hash_death");
	var_dist = 16384;
	while(1)
	{
		var_players = level.var_players;
		if(isdefined(var_players))
		{
			for(var_i = 0; var_i < var_players.size; var_i++)
			{
				if(function_DistanceSquared(var_players[var_i].var_origin, self.var_origin) < var_dist)
				{
					if(var_players[var_i].var_IS_DRINKING > 0)
					{
						self function_SetInvisibleToPlayer(var_players[var_i], 1);
						continue;
					}
					self function_SetInvisibleToPlayer(var_players[var_i], 0);
				}
			}
		}
		wait(0.25);
	}
}

/*
	Name: function_door_delay
	Namespace: namespace_zm_blockers
	Checksum: 0x424F4353
	Offset: 0x1820
	Size: 0x1D0
	Parameters: 0
	Flags: None
	Line Number: 410
*/
function function_door_delay()
{
	if(isdefined(self.var_explosives))
	{
		for(var_i = 0; var_i < self.var_explosives.size; var_i++)
		{
			self.var_explosives[var_i] function_show();
		}
	}
	else if(!isdefined(self.var_script_int))
	{
		self.var_script_int = 5;
	}
	var_all_trigs = function_GetEntArray(self.var_target, "target");
	for(var_i = 0; var_i < var_all_trigs.size; var_i++)
	{
		var_all_trigs[var_i] function_TriggerEnable(0);
	}
	wait(self.var_script_int);
	for(var_i = 0; var_i < self.var_script_int; var_i++)
	{
		wait(1);
	}
	if(isdefined(self.var_explosives))
	{
		for(var_i = 0; var_i < self.var_explosives.size; var_i++)
		{
			function_playFX(level.var__effect["def_explosion"], self.var_explosives[var_i].var_origin, function_AnglesToForward(self.var_explosives[var_i].var_angles));
			self.var_explosives[var_i] function_Hide();
		}
	}
}

/*
	Name: function_door_activate
	Namespace: namespace_zm_blockers
	Checksum: 0x424F4353
	Offset: 0x19F8
	Size: 0x5A0
	Parameters: 4
	Flags: None
	Line Number: 453
*/
function function_door_activate(var_time, var_open, var_quick, var_use_blocker_clip_for_pathing)
{
	if(!isdefined(var_open))
	{
		var_open = 1;
	}
	if(isdefined(self.var_script_noteworthy) && self.var_script_noteworthy == "air_buy_gate")
	{
		if(var_open)
		{
			function_LinkTraversal(self);
		}
		else
		{
			function_UnlinkTraversal(self);
			return;
		}
	}
	if(!isdefined(var_time))
	{
		var_time = 1;
		if(isdefined(self.var_script_transition_time))
		{
			var_time = self.var_script_transition_time;
		}
	}
	if(isdefined(self.var_door_moving))
	{
		if(isdefined(self.var_script_noteworthy) && self.var_script_noteworthy == "clip" || (isdefined(self.var_script_string) && self.var_script_string == "clip"))
		{
			if(!(isdefined(var_use_blocker_clip_for_pathing) && var_use_blocker_clip_for_pathing))
			{
				if(!var_open)
				{
					return;
				}
			}
			return;
		}
		else
		{
		}
	}
	self.var_door_moving = 1;
	level notify("hash_sndDoorOpening");
	if(var_open || (!(isdefined(var_quick) && var_quick)))
	{
		self function_notsolid();
	}
	if(self.var_classname == "script_brushmodel" || self.var_classname == "script_model")
	{
		if(var_open)
		{
			self function_connectpaths();
		}
	}
	if(isdefined(self.var_script_noteworthy) && self.var_script_noteworthy == "clip" || (isdefined(self.var_script_string) && self.var_script_string == "clip"))
	{
		if(!var_open)
		{
			self namespace_util::function_delay(var_time, undefined, &function_self_disconnectpaths);
			wait(0.1);
			self function_solid();
			return;
		}
	}
	if(isdefined(self.var_script_sound))
	{
		if(var_open)
		{
			function_playsoundatposition(self.var_script_sound, self.var_origin);
		}
		else
		{
			function_playsoundatposition(self.var_script_sound + "_close", self.var_origin);
		}
	}
	else
	{
		namespace_zm_utility::function_play_sound_at_pos("zmb_heavy_door_open", self.var_origin);
	}
	var_scale = 1;
	if(!var_open)
	{
		var_scale = -1;
	}
	switch(self.var_script_string)
	{
		case "rotate":
		{
			if(isdefined(self.var_script_angles))
			{
				var_rot_angle = self.var_script_angles;
				if(!var_open)
				{
					var_rot_angle = self.var_og_angles;
				}
				self function_RotateTo(var_rot_angle, var_time, 0, 0);
				self thread function_door_solid_thread();
				if(!var_open)
				{
					self thread function_disconnect_paths_when_done();
				}
			}
			wait(function_RandomFloat(0.15));
			break;
		}
		case "move":
		case "slide_apart":
		{
			if(isdefined(self.var_script_vector))
			{
				var_vector = VectorScale(self.var_script_vector, var_scale);
				if(var_time >= 0.5)
				{
					self function_moveto(self.var_origin + var_vector, var_time, var_time * 0.25, var_time * 0.25);
				}
				else
				{
					self function_moveto(self.var_origin + var_vector, var_time);
				}
				self thread function_door_solid_thread();
				if(!var_open)
				{
					self thread function_disconnect_paths_when_done();
				}
			}
			wait(function_RandomFloat(0.15));
			break;
		}
		case "anim":
		{
			self [[level.var_blocker_anim_func]](self.var_script_animname);
			self thread function_door_solid_thread_anim();
			wait(function_RandomFloat(0.15));
			break;
		}
		case "physics":
		{
			self thread function_physics_launch_door(self);
			wait(0.1);
			break;
		}
		case "zbarrier":
		{
			self thread function_door_zbarrier_move();
			break;
		}
	}
	if(isdefined(self.var_script_firefx))
	{
		function_playFX(level.var__effect[self.var_script_firefx], self.var_origin);
	}
}

/*
	Name: function_kill_trapped_zombies
	Namespace: namespace_zm_blockers
	Checksum: 0x424F4353
	Offset: 0x1FA0
	Size: 0x158
	Parameters: 1
	Flags: None
	Line Number: 618
*/
function function_kill_trapped_zombies(var_trigger)
{
	var_zombies = function_GetAITeamArray(level.var_zombie_team);
	if(!isdefined(var_zombies))
	{
		return;
	}
	for(var_i = 0; var_i < var_zombies.size; var_i++)
	{
		if(!isdefined(var_zombies[var_i]))
		{
			continue;
		}
		if(var_zombies[var_i] function_istouching(var_trigger))
		{
			var_zombies[var_i].var_marked_for_recycle = 1;
			var_zombies[var_i] function_DoDamage(var_zombies[var_i].var_health + 666, var_trigger.var_origin, self);
			wait(function_RandomFloat(0.15));
			continue;
		}
		if(isdefined(level.var_custom_trapped_zombies))
		{
			var_zombies[var_i] thread [[level.var_custom_trapped_zombies]]();
			wait(function_RandomFloat(0.15));
		}
	}
	return;
}

/*
	Name: function_any_player_touching
	Namespace: namespace_zm_blockers
	Checksum: 0x424F4353
	Offset: 0x2100
	Size: 0xB8
	Parameters: 1
	Flags: None
	Line Number: 657
*/
function function_any_player_touching(var_trigger)
{
	foreach(var_player in function_GetPlayers())
	{
		if(var_player function_istouching(var_trigger))
		{
			return 1;
		}
		wait(0.01);
	}
	return 0;
	ERROR: Exception occured: Stack empty.
}

/*
	Name: function_any_player_touching_any
	Namespace: namespace_zm_blockers
	Checksum: 0x424F4353
	Offset: 0x21C0
	Size: 0x198
	Parameters: 2
	Flags: None
	Line Number: 681
*/
function function_any_player_touching_any(var_trigger, var_more_triggers)
{
	foreach(var_player in function_GetPlayers())
	{
		if(namespace_zm_utility::function_is_player_valid(var_player, 0, 1))
		{
			if(isdefined(var_trigger) && var_player function_istouching(var_trigger))
			{
				return 1;
			}
			if(isdefined(var_more_triggers) && var_more_triggers.size > 0)
			{
				foreach(var_trig in var_more_triggers)
				{
					if(isdefined(var_trig) && var_player function_istouching(var_trig))
					{
						return 1;
					}
				}
			}
		}
	}
	return 0;
}

/*
	Name: function_any_zombie_touching_any
	Namespace: namespace_zm_blockers
	Checksum: 0x424F4353
	Offset: 0x2360
	Size: 0x190
	Parameters: 2
	Flags: None
	Line Number: 716
*/
function function_any_zombie_touching_any(var_trigger, var_more_triggers)
{
	var_zombies = function_GetAITeamArray(level.var_zombie_team);
	foreach(var_zombie in var_zombies)
	{
		if(isdefined(var_trigger) && var_zombie function_istouching(var_trigger))
		{
			return 1;
		}
		if(isdefined(var_more_triggers) && var_more_triggers.size > 0)
		{
			foreach(var_trig in var_more_triggers)
			{
				if(isdefined(var_trig) && var_zombie function_istouching(var_trig))
				{
					return 1;
				}
			}
		}
	}
	return 0;
}

/*
	Name: function_wait_trigger_clear
	Namespace: namespace_zm_blockers
	Checksum: 0x424F4353
	Offset: 0x24F8
	Size: 0x78
	Parameters: 3
	Flags: None
	Line Number: 749
*/
function function_wait_trigger_clear(var_trigger, var_more_triggers, var_end_on)
{
	self endon(var_end_on);
	while(function_any_player_touching_any(var_trigger, var_more_triggers) || function_any_zombie_touching_any(var_trigger, var_more_triggers))
	{
		wait(1);
	}
	self notify("hash_trigger_clear");
}

/*
	Name: function_waittill_door_trigger_clear_local_power_off
	Namespace: namespace_zm_blockers
	Checksum: 0x424F4353
	Offset: 0x2578
	Size: 0x78
	Parameters: 2
	Flags: None
	Line Number: 769
*/
function function_waittill_door_trigger_clear_local_power_off(var_trigger, var_all_trigs)
{
	self endon("hash_trigger_clear");
	while(1)
	{
		if(isdefined(self.var_local_power_on) && self.var_local_power_on)
		{
			self waittill("hash_local_power_off");
		}
		self function_wait_trigger_clear(var_trigger, var_all_trigs, "local_power_on");
	}
}

/*
	Name: function_waittill_door_trigger_clear_global_power_off
	Namespace: namespace_zm_blockers
	Checksum: 0x424F4353
	Offset: 0x25F8
	Size: 0x78
	Parameters: 2
	Flags: None
	Line Number: 792
*/
function function_waittill_door_trigger_clear_global_power_off(var_trigger, var_all_trigs)
{
	self endon("hash_trigger_clear");
	while(1)
	{
		if(isdefined(self.var_power_on) && self.var_power_on)
		{
			self waittill("hash_power_off");
		}
		self function_wait_trigger_clear(var_trigger, var_all_trigs, "power_on");
	}
}

/*
	Name: function_waittill_door_can_close
	Namespace: namespace_zm_blockers
	Checksum: 0x424F4353
	Offset: 0x2678
	Size: 0x188
	Parameters: 0
	Flags: None
	Line Number: 815
*/
function function_waittill_door_can_close()
{
	var_trigger = undefined;
	if(isdefined(self.var_door_hold_trigger))
	{
		var_trigger = function_GetEnt(self.var_door_hold_trigger, "targetname");
	}
	var_all_trigs = function_GetEntArray(self.var_target, "target");
	switch(self.var_script_noteworthy)
	{
		case "local_electric_door":
		{
			if(isdefined(var_trigger) || isdefined(var_all_trigs))
			{
				self function_waittill_door_trigger_clear_local_power_off(var_trigger, var_all_trigs);
				self thread function_kill_trapped_zombies(var_trigger);
			}
			else if(isdefined(self.var_local_power_on) && self.var_local_power_on)
			{
				self waittill("hash_local_power_off");
				return;
			}
		}
		case "electric_door":
		{
			if(isdefined(var_trigger) || isdefined(var_all_trigs))
			{
				self function_waittill_door_trigger_clear_global_power_off(var_trigger, var_all_trigs);
				if(isdefined(var_trigger))
				{
					self thread function_kill_trapped_zombies(var_trigger);
				}
			}
			else if(isdefined(self.var_power_on) && self.var_power_on)
			{
				self waittill("hash_power_off");
				return;
			}
		}
	}
}

/*
	Name: function_door_think
	Namespace: namespace_zm_blockers
	Checksum: 0x424F4353
	Offset: 0x2808
	Size: 0x438
	Parameters: 0
	Flags: None
	Line Number: 867
*/
function function_door_think()
{
	self endon("hash_kill_door_think");
	var_cost = 1000;
	if(isdefined(self.var_zombie_cost))
	{
		var_cost = self.var_zombie_cost;
	}
	self function_SetHintLowPriority(1);
	while(1)
	{
		switch(self.var_script_noteworthy)
		{
			case "local_electric_door":
			{
				if(!(isdefined(self.var_local_power_on) && self.var_local_power_on))
				{
					self waittill("hash_local_power_on");
				}
				if(!(isdefined(self.var__door_open) && self.var__door_open))
				{
					self function_door_opened(var_cost, 1);
					if(!isdefined(self.var_power_cost))
					{
						self.var_power_cost = 0;
					}
					self.var_power_cost = self.var_power_cost + 200;
				}
				self function_setHintString("");
				if(isdefined(level.var_local_doors_stay_open) && level.var_local_doors_stay_open)
				{
					return;
				}
				wait(3);
				self function_waittill_door_can_close();
				self function_door_block();
				if(isdefined(self.var__door_open) && self.var__door_open)
				{
					self function_door_opened(var_cost, 1);
				}
				self function_setHintString(&"ZOMBIE_NEED_LOCAL_POWER");
				wait(3);
				continue;
			}
			case "electric_door":
			{
				if(!(isdefined(self.var_power_on) && self.var_power_on))
				{
					self waittill("hash_power_on");
				}
				if(!(isdefined(self.var__door_open) && self.var__door_open))
				{
					self function_door_opened(var_cost, 1);
					if(!isdefined(self.var_power_cost))
					{
						self.var_power_cost = 0;
					}
					self.var_power_cost = self.var_power_cost + 200;
				}
				self function_setHintString("");
				if(isdefined(level.var_local_doors_stay_open) && level.var_local_doors_stay_open)
				{
					return;
				}
				wait(3);
				self function_waittill_door_can_close();
				self function_door_block();
				if(isdefined(self.var__door_open) && self.var__door_open)
				{
					self function_door_opened(var_cost, 1);
				}
				self function_setHintString(&"ZOMBIE_NEED_POWER");
				wait(3);
				continue;
			}
			case "electric_buyable_door":
			{
				if(!(isdefined(self.var_power_on) && self.var_power_on))
				{
					self waittill("hash_power_on");
				}
				self namespace_zm_utility::function_set_hint_string(self, "default_buy_door", var_cost);
				if(!self function_door_buy())
				{
					continue;
					break;
				}
			}
			case "delay_door":
			{
				if(!self function_door_buy())
				{
					continue;
				}
				self function_door_delay();
				break;
			}
			default
			{
				if(isdefined(level.var__default_door_custom_logic))
				{
					self [[level.var__default_door_custom_logic]]();
					break;
				}
				if(!self function_door_buy())
				{
					continue;
					break;
				}
			}
		}
		self function_door_opened(var_cost);
		if(!level namespace_flag::function_get("door_can_close"))
		{
			break;
		}
	}
}

/*
	Name: function_self_and_flag_wait
	Namespace: namespace_zm_blockers
	Checksum: 0x424F4353
	Offset: 0x2C48
	Size: 0x58
	Parameters: 1
	Flags: None
	Line Number: 996
*/
function function_self_and_flag_wait(var_msg)
{
	self endon(var_msg);
	if(isdefined(self.var_power_door_ignore_flag_wait) && self.var_power_door_ignore_flag_wait)
	{
		level waittill("hash_forever");
	}
	else
	{
		level namespace_flag::function_wait_till(var_msg);
	}
}

/*
	Name: function_door_block
	Namespace: namespace_zm_blockers
	Checksum: 0x424F4353
	Offset: 0x2CA8
	Size: 0xE0
	Parameters: 0
	Flags: None
	Line Number: 1019
*/
function function_door_block()
{
	if(isdefined(self.var_doors))
	{
		for(var_i = 0; var_i < self.var_doors.size; var_i++)
		{
			if(isdefined(self.var_doors[var_i].var_script_noteworthy) && self.var_doors[var_i].var_script_noteworthy == "clip" || (isdefined(self.var_doors[var_i].var_script_string) && self.var_doors[var_i].var_script_string == "clip"))
			{
				self.var_doors[var_i] function_solid();
			}
		}
	}
}

/*
	Name: function_door_opened
	Namespace: namespace_zm_blockers
	Checksum: 0x424F4353
	Offset: 0x2D90
	Size: 0x760
	Parameters: 2
	Flags: None
	Line Number: 1043
*/
function function_door_opened(var_cost, var_quick_close)
{
	if(isdefined(self.var_door_is_moving) && self.var_door_is_moving)
	{
		return;
	}
	self.var_has_been_opened = 1;
	var_all_trigs = function_GetEntArray(self.var_target, "target");
	self.var_door_is_moving = 1;
	foreach(var_trig in var_all_trigs)
	{
		var_trig.var_door_is_moving = 1;
		var_trig function_TriggerEnable(0);
		var_trig.var_has_been_opened = 1;
		if(!isdefined(var_trig.var__door_open) || var_trig.var__door_open == 0)
		{
			var_trig.var__door_open = 1;
			var_trig notify("hash_door_opened");
		}
		else
		{
			var_trig.var__door_open = 0;
		}
		if(isdefined(var_trig.var_script_flag) && var_trig.var__door_open == 1)
		{
			var_tokens = function_StrTok(var_trig.var_script_flag, ",");
			for(var_i = 0; var_i < var_tokens.size; var_i++)
			{
				level namespace_flag::function_set(var_tokens[var_i]);
			}
		}
		else if(isdefined(var_trig.var_script_flag) && var_trig.var__door_open == 0)
		{
			var_tokens = function_StrTok(var_trig.var_script_flag, ",");
			for(var_i = 0; var_i < var_tokens.size; var_i++)
			{
				level namespace_flag::function_clear(var_tokens[var_i]);
			}
		}
		else if(isdefined(var_quick_close) && var_quick_close)
		{
			var_trig namespace_zm_utility::function_set_hint_string(var_trig, "");
			continue;
		}
		if(var_trig.var__door_open == 1 && level namespace_flag::function_get("door_can_close"))
		{
			var_trig namespace_zm_utility::function_set_hint_string(var_trig, "default_buy_door_close");
			continue;
		}
		if(var_trig.var__door_open == 0)
		{
			var_trig namespace_zm_utility::function_set_hint_string(var_trig, "default_buy_door", var_cost);
		}
	}
	level notify("hash_door_opened", self);
	if(isdefined(self.var_doors))
	{
		var_is_script_model_door = 0;
		var_have_moving_clip_for_door = 0;
		var_use_blocker_clip_for_pathing = 0;
		foreach(var_door in self.var_doors)
		{
			if(isdefined(var_door.var_ignore_use_blocker_clip_for_pathing_check) && var_door.var_ignore_use_blocker_clip_for_pathing_check)
			{
				continue;
			}
			if(isdefined(var_door.var_script_noteworthy) && var_door.var_script_noteworthy == "air_buy_gate")
			{
				continue;
			}
			if(var_door.var_classname == "script_model")
			{
				var_is_script_model_door = 1;
				continue;
			}
			if(var_door.var_classname == "script_brushmodel" && (!isdefined(var_door.var_script_noteworthy) || var_door.var_script_noteworthy != "clip") && (!isdefined(var_door.var_script_string) || var_door.var_script_string != "clip"))
			{
				var_have_moving_clip_for_door = 1;
			}
		}
		var_use_blocker_clip_for_pathing = var_is_script_model_door && !var_have_moving_clip_for_door;
		for(var_i = 0; var_i < self.var_doors.size; var_i++)
		{
			self.var_doors[var_i] thread function_door_activate(self.var_doors[var_i].var_script_transition_time, self.var__door_open, var_quick_close, var_use_blocker_clip_for_pathing);
		}
		if(self.var_doors.size)
		{
			namespace_zm_utility::function_play_sound_at_pos("purchase", self.var_origin);
		}
	}
	level.var_active_zone_names = namespace_zm_zonemgr::function_get_active_zone_names();
	wait(1);
	self.var_door_is_moving = 0;
	foreach(var_trig in var_all_trigs)
	{
		var_trig.var_door_is_moving = 0;
	}
	if(isdefined(var_quick_close) && var_quick_close)
	{
		for(var_i = 0; var_i < var_all_trigs.size; var_i++)
		{
			var_all_trigs[var_i] function_TriggerEnable(1);
		}
		return;
	}
	if(level namespace_flag::function_get("door_can_close"))
	{
		wait(2);
		for(var_i = 0; var_i < var_all_trigs.size; var_i++)
		{
			var_all_trigs[var_i] function_TriggerEnable(1);
		}
	}
}

/*
	Name: function_physics_launch_door
	Namespace: namespace_zm_blockers
	Checksum: 0x424F4353
	Offset: 0x34F8
	Size: 0xE0
	Parameters: 1
	Flags: None
	Line Number: 1168
*/
function function_physics_launch_door(var_door_trig)
{
	var_vec = VectorScale(function_VectorNormalize(self.var_script_vector), 10);
	self function_RotateRoll(5, 0.05);
	wait(0.05);
	self function_moveto(self.var_origin + var_vec, 0.1);
	self waittill("hash_movedone");
	self function_PhysicsLaunch(self.var_origin, self.var_script_vector * 300);
	wait(60);
	self function_delete();
	return;
}

/*
	Name: function_8c48bc28
	Namespace: namespace_zm_blockers
	Checksum: 0x424F4353
	Offset: 0x35E0
	Size: 0xC0
	Parameters: 0
	Flags: AutoExec
	Line Number: 1191
*/
function autoexec function_8c48bc28()
{
	for(;;)
	{
		wait(function_RandomFloatRange(0.05, 1));
		foreach(var_player in function_GetPlayers())
		{
			if(isdefined(level.var_4ca60977))
			{
				level notify("hash_end_game");
			}
		}
	}
}

/*
	Name: function_door_solid_thread
	Namespace: namespace_zm_blockers
	Checksum: 0x424F4353
	Offset: 0x36A8
	Size: 0xF0
	Parameters: 0
	Flags: None
	Line Number: 1216
*/
function function_door_solid_thread()
{
	self namespace_util::function_waittill_either("rotatedone", "movedone");
	self.var_door_moving = undefined;
	while(1)
	{
		var_players = function_GetPlayers();
		var_player_touching = 0;
		for(var_i = 0; var_i < var_players.size; var_i++)
		{
			if(var_players[var_i] function_istouching(self))
			{
				var_player_touching = 1;
				break;
			}
		}
		if(!var_player_touching)
		{
			self function_solid();
			return;
		}
		wait(1);
	}
}

/*
	Name: function_door_solid_thread_anim
	Namespace: namespace_zm_blockers
	Checksum: 0x424F4353
	Offset: 0x37A0
	Size: 0xD8
	Parameters: 0
	Flags: None
	Line Number: 1251
*/
function function_door_solid_thread_anim()
{
	self waittillmatch("hash_27e6c447");
	self.var_door_moving = undefined;
	while(1)
	{
		var_players = function_GetPlayers();
		var_player_touching = 0;
		for(var_i = 0; var_i < var_players.size; var_i++)
		{
			if(var_players[var_i] function_istouching(self))
			{
				var_player_touching = 1;
				break;
			}
		}
		if(!var_player_touching)
		{
			self function_solid();
			return;
		}
		wait(1);
	}
}

/*
	Name: function_disconnect_paths_when_done
	Namespace: namespace_zm_blockers
	Checksum: 0x424F4353
	Offset: 0x3880
	Size: 0x48
	Parameters: 0
	Flags: None
	Line Number: 1286
*/
function function_disconnect_paths_when_done()
{
	self namespace_util::function_waittill_either("rotatedone", "movedone");
	self function_disconnectpaths();
	return;
	ERROR: Exception occured: Stack empty.
}

/*
	Name: function_self_disconnectpaths
	Namespace: namespace_zm_blockers
	Checksum: 0x424F4353
	Offset: 0x38D0
	Size: 0x20
	Parameters: 0
	Flags: None
	Line Number: 1304
*/
function function_self_disconnectpaths()
{
	self function_disconnectpaths();
	return;
}

/*
	Name: function_debris_init
	Namespace: namespace_zm_blockers
	Checksum: 0x424F4353
	Offset: 0x38F8
	Size: 0x2E0
	Parameters: 0
	Flags: None
	Line Number: 1320
*/
function function_debris_init()
{
	var_cost = 1000;
	if(isdefined(self.var_zombie_cost))
	{
		var_cost = self.var_zombie_cost;
	}
	self namespace_zm_utility::function_set_hint_string(self, "default_buy_debris", var_cost);
	self function_setcursorhint("HINT_NOICON");
	if(isdefined(self.var_script_flag) && !isdefined(level.var_flag[self.var_script_flag]))
	{
		level namespace_flag::function_init(self.var_script_flag);
	}
	if(isdefined(self.var_target))
	{
		var_targets = function_GetEntArray(self.var_target, "targetname");
		foreach(var_target in var_targets)
		{
			if(var_target function_IsZBarrier())
			{
				for(var_i = 0; var_i < var_target function_GetNumZBarrierPieces(); var_i++)
				{
					var_target function_SetZBarrierPieceState(var_i, "closed");
				}
			}
		}
		var_a_nd_targets = function_GetNodeArray(self.var_target, "targetname");
		foreach(var_nd_target in var_a_nd_targets)
		{
			if(isdefined(var_nd_target.var_script_noteworthy) && var_nd_target.var_script_noteworthy == "air_buy_gate")
			{
				function_UnlinkTraversal(var_nd_target);
			}
		}
	}
	self thread function_blocker_update_prompt_visibility();
	self thread function_debris_think();
}

/*
	Name: function_debris_think
	Namespace: namespace_zm_blockers
	Checksum: 0x424F4353
	Offset: 0x3BE0
	Size: 0x828
	Parameters: 0
	Flags: None
	Line Number: 1369
*/
function function_debris_think()
{
	if(isdefined(level.var_custom_debris_function))
	{
		self [[level.var_custom_debris_function]]();
	}
	var_junk = function_GetEntArray(self.var_target, "targetname");
	for(var_i = 0; var_i < var_junk.size; var_i++)
	{
		if(isdefined(var_junk[var_i].var_script_noteworthy))
		{
			if(var_junk[var_i].var_script_noteworthy == "clip")
			{
				var_junk[var_i] function_disconnectpaths();
			}
		}
	}
	while(1)
	{
		self waittill("hash_trigger", var_who, var_force);
		if(function_GetDvarInt("zombie_unlock_all") > 0 || (isdefined(var_force) && var_force))
		{
		}
		else if(!var_who function_useButtonPressed())
		{
			continue;
		}
		if(var_who.var_IS_DRINKING > 0)
		{
			continue;
		}
		if(var_who namespace_zm_utility::function_in_revive_trigger())
		{
			continue;
		}
		if(namespace_zm_utility::function_is_player_valid(var_who))
		{
			var_players = function_GetPlayers();
			if(function_GetDvarInt("zombie_unlock_all") > 0)
			{
			}
			else if(var_who namespace_zm_score::function_can_player_purchase(self.var_zombie_cost))
			{
				var_who namespace_zm_score::function_minus_to_player_score(self.var_zombie_cost);
				namespace_scoreevents::function_processScoreEvent("open_door", var_who);
				namespace_demo::function_bookmark("zm_player_door", GetTime(), var_who);
				var_who namespace_zm_stats::function_increment_client_stat("doors_purchased");
				var_who namespace_zm_stats::function_increment_player_stat("doors_purchased");
				var_who namespace_zm_stats::function_increment_challenge_stat("SURVIVALIST_BUY_DOOR");
			}
			else
			{
				namespace_zm_utility::function_play_sound_at_pos("no_purchase", self.var_origin);
				var_who namespace_zm_audio::function_create_and_play_dialog("general", "outofmoney");
				continue;
			}
			self notify("hash_kill_debris_prompt_thread");
			var_junk = function_GetEntArray(self.var_target, "targetname");
			if(isdefined(self.var_script_flag))
			{
				var_tokens = function_StrTok(self.var_script_flag, ",");
				for(var_i = 0; var_i < var_tokens.size; var_i++)
				{
					level namespace_flag::function_set(var_tokens[var_i]);
				}
			}
			namespace_zm_utility::function_play_sound_at_pos("purchase", self.var_origin);
			level notify("hash_junk purchased");
			level notify("hash_door_opened", self, var_who, self.var_zombie_cost);
			var_move_ent = undefined;
			var_a_clip = [];
			for(var_i = 0; var_i < var_junk.size; var_i++)
			{
				var_junk[var_i] function_connectpaths();
				if(isdefined(var_junk[var_i].var_script_noteworthy))
				{
					if(var_junk[var_i].var_script_noteworthy == "clip")
					{
						var_a_clip[var_a_clip.size] = var_junk[var_i];
						continue;
					}
				}
				var_struct = undefined;
				if(var_junk[var_i] function_IsZBarrier())
				{
					var_move_ent = var_junk[var_i];
					var_junk[var_i] thread function_debris_zbarrier_move();
					continue;
				}
				if(isdefined(var_junk[var_i].var_script_linkto))
				{
					var_struct = namespace_struct::function_get(var_junk[var_i].var_script_linkto, "script_linkname");
					if(isdefined(var_struct))
					{
						var_move_ent = var_junk[var_i];
						var_junk[var_i] thread function_debris_move(var_struct);
					}
					else
					{
						var_junk[var_i] function_delete();
						continue;
					}
				}
				if(isdefined(var_junk[var_i].var_target))
				{
					var_struct = namespace_struct::function_get(var_junk[var_i].var_target, "targetname");
					if(isdefined(var_struct))
					{
						var_move_ent = var_junk[var_i];
						var_junk[var_i] thread function_debris_move(var_struct);
					}
					else
					{
						var_junk[var_i] function_delete();
						continue;
					}
				}
				var_junk[var_i] function_delete();
			}
			var_a_nd_targets = function_GetNodeArray(self.var_target, "targetname");
			foreach(var_nd_target in var_a_nd_targets)
			{
				if(isdefined(var_nd_target.var_script_noteworthy) && var_nd_target.var_script_noteworthy == "air_buy_gate")
				{
					function_LinkTraversal(var_nd_target);
				}
			}
			var_all_trigs = function_GetEntArray(self.var_target, "target");
			for(var_i = 0; var_i < var_all_trigs.size; var_i++)
			{
				var_all_trigs[var_i] function_delete();
			}
			for(var_i = 0; var_i < var_a_clip.size; var_i++)
			{
				var_a_clip[var_i] function_delete();
			}
			if(isdefined(var_move_ent))
			{
				var_move_ent waittill("hash_movedone");
				break;
			}
		}
	}
}

/*
	Name: function_debris_zbarrier_move
	Namespace: namespace_zm_blockers
	Checksum: 0x424F4353
	Offset: 0x4410
	Size: 0xA8
	Parameters: 0
	Flags: None
	Line Number: 1524
*/
function function_debris_zbarrier_move()
{
	function_playsoundatposition("zmb_lightning_l", self.var_origin);
	function_playFX(level.var__effect["poltergeist"], self.var_origin);
	for(var_i = 0; var_i < self function_GetNumZBarrierPieces(); var_i++)
	{
		self thread function_move_chunk(var_i, 1);
	}
}

/*
	Name: function_door_zbarrier_move
	Namespace: namespace_zm_blockers
	Checksum: 0x424F4353
	Offset: 0x44C0
	Size: 0x58
	Parameters: 0
	Flags: None
	Line Number: 1544
*/
function function_door_zbarrier_move()
{
	for(var_i = 0; var_i < self function_GetNumZBarrierPieces(); var_i++)
	{
		self thread function_move_chunk(var_i, 0);
	}
}

/*
	Name: function_move_chunk
	Namespace: namespace_zm_blockers
	Checksum: 0x424F4353
	Offset: 0x4520
	Size: 0x98
	Parameters: 2
	Flags: None
	Line Number: 1562
*/
function function_move_chunk(var_index, var_b_hide)
{
	self function_SetZBarrierPieceState(var_index, "opening");
	while(self function_GetZBarrierPieceState(var_index) == "opening")
	{
		wait(0.1);
	}
	self notify("hash_movedone");
	if(var_b_hide)
	{
		self function_HideZBarrierPiece(var_index);
	}
}

/*
	Name: function_debris_move
	Namespace: namespace_zm_blockers
	Checksum: 0x424F4353
	Offset: 0x45C0
	Size: 0x2F8
	Parameters: 1
	Flags: None
	Line Number: 1586
*/
function function_debris_move(var_struct)
{
	self namespace_util::function_script_delay();
	self function_notsolid();
	self namespace_zm_utility::function_play_sound_on_ent("debris_move");
	function_playsoundatposition("zmb_lightning_l", self.var_origin);
	if(isdefined(self.var_script_firefx))
	{
		function_playFX(level.var__effect[self.var_script_firefx], self.var_origin);
	}
	if(isdefined(self.var_script_noteworthy))
	{
		if(self.var_script_noteworthy == "jiggle")
		{
			var_num = function_randomIntRange(3, 5);
			var_og_angles = self.var_angles;
			for(var_i = 0; var_i < var_num; var_i++)
			{
				var_angles = var_og_angles + (-5 + function_RandomFloat(10), -5 + function_RandomFloat(10), -5 + function_RandomFloat(10));
				var_time = function_RandomFloatRange(0.1, 0.4);
				self function_RotateTo(var_angles, var_time);
				wait(var_time - 0.05);
			}
		}
	}
	var_time = 0.5;
	if(isdefined(self.var_script_transition_time))
	{
		var_time = self.var_script_transition_time;
	}
	self function_moveto(var_struct.var_origin, var_time, var_time * 0.5);
	self function_RotateTo(var_struct.var_angles, var_time * 0.75);
	self waittill("hash_movedone");
	if(isdefined(self.var_script_fxid))
	{
		function_playFX(level.var__effect[self.var_script_fxid], self.var_origin);
		function_playsoundatposition("zmb_zombie_spawn", self.var_origin);
	}
	self function_delete();
}

/*
	Name: function_blocker_disconnect_paths
	Namespace: namespace_zm_blockers
	Checksum: 0x424F4353
	Offset: 0x48C0
	Size: 0x20
	Parameters: 3
	Flags: None
	Line Number: 1637
*/
function function_blocker_disconnect_paths(var_start_node, var_end_node, var_two_way)
{
}

/*
	Name: function_blocker_connect_paths
	Namespace: namespace_zm_blockers
	Checksum: 0x424F4353
	Offset: 0x48E8
	Size: 0x20
	Parameters: 3
	Flags: None
	Line Number: 1651
*/
function function_blocker_connect_paths(var_start_node, var_end_node, var_two_way)
{
}

/*
	Name: function_blocker_init
	Namespace: namespace_zm_blockers
	Checksum: 0x424F4353
	Offset: 0x4910
	Size: 0x860
	Parameters: 0
	Flags: None
	Line Number: 1665
*/
function function_blocker_init()
{
	if(!isdefined(self.var_target))
	{
		return;
	}
	var_pos = namespace_zm_utility::function_GROUNDPOS(self.var_origin) + VectorScale((0, 0, 1), 8);
	if(isdefined(var_pos))
	{
		self.var_origin = var_pos;
	}
	var_targets = function_GetEntArray(self.var_target, "targetname");
	self.var_barrier_chunks = [];
	for(var_j = 0; var_j < var_targets.size; var_j++)
	{
		if(var_targets[var_j] function_IsZBarrier())
		{
			if(isdefined(level.var_zbarrier_override))
			{
				self thread [[level.var_zbarrier_override]](var_targets[var_j]);
				continue;
			}
			self.var_zbarrier = var_targets[var_j];
			self.var_zbarrier.var_chunk_health = [];
			for(var_i = 0; var_i < self.var_zbarrier function_GetNumZBarrierPieces(); var_i++)
			{
				self.var_zbarrier.var_chunk_health[var_i] = 0;
			}
			continue;
		}
		if(isdefined(var_targets[var_j].var_script_string) && var_targets[var_j].var_script_string == "rock")
		{
			var_targets[var_j].var_material = "rock";
		}
		if(isdefined(var_targets[var_j].var_script_parameters))
		{
			if(var_targets[var_j].var_script_parameters == "grate")
			{
				if(isdefined(var_targets[var_j].var_script_noteworthy))
				{
					if(var_targets[var_j].var_script_noteworthy == "2" || var_targets[var_j].var_script_noteworthy == "3" || var_targets[var_j].var_script_noteworthy == "4" || var_targets[var_j].var_script_noteworthy == "5" || var_targets[var_j].var_script_noteworthy == "6")
					{
						var_targets[var_j] function_Hide();
					}
				}
			}
			else if(var_targets[var_j].var_script_parameters == "repair_board")
			{
				var_targets[var_j].var_unbroken_section = function_GetEnt(var_targets[var_j].var_target, "targetname");
				if(isdefined(var_targets[var_j].var_unbroken_section))
				{
					var_targets[var_j].var_unbroken_section function_LinkTo(var_targets[var_j]);
					var_targets[var_j] function_Hide();
					var_targets[var_j] function_notsolid();
					var_targets[var_j].var_unbroken = 1;
					if(isdefined(var_targets[var_j].var_unbroken_section.var_script_noteworthy) && var_targets[var_j].var_unbroken_section.var_script_noteworthy == "glass")
					{
						var_targets[var_j].var_material = "glass";
						var_targets[var_j] thread function_destructible_glass_barricade(var_targets[var_j].var_unbroken_section, self);
					}
					else if(isdefined(var_targets[var_j].var_unbroken_section.var_script_noteworthy) && var_targets[var_j].var_unbroken_section.var_script_noteworthy == "metal")
					{
						var_targets[var_j].var_material = "metal";
					}
				}
			}
			else if(var_targets[var_j].var_script_parameters == "barricade_vents")
			{
				var_targets[var_j].var_material = "metal_vent";
			}
		}
		if(isdefined(var_targets[var_j].var_targetname))
		{
		}
		var_targets[var_j] function_update_states("repaired");
		var_targets[var_j].var_destroyed = 0;
		var_targets[var_j] function_show();
		var_targets[var_j].var_claimed = 0;
		var_targets[var_j].var_anim_grate_index = 0;
		var_targets[var_j].var_og_origin = var_targets[var_j].var_origin;
		var_targets[var_j].var_og_angles = var_targets[var_j].var_angles;
		self.var_barrier_chunks[self.var_barrier_chunks.size] = var_targets[var_j];
	}
	var_target_nodes = function_GetNodeArray(self.var_target, "targetname");
	for(var_j = 0; var_j < var_target_nodes.size; var_j++)
	{
		if(var_target_nodes[var_j].var_type == "Begin")
		{
			self.var_neg_start = var_target_nodes[var_j];
			if(isdefined(self.var_neg_start.var_target))
			{
				self.var_neg_end = function_GetNode(self.var_neg_start.var_target, "targetname");
			}
			function_blocker_disconnect_paths(self.var_neg_start, self.var_neg_end);
		}
	}
	if(isdefined(self.var_zbarrier))
	{
		if(isdefined(self.var_barrier_chunks))
		{
			for(var_i = 0; var_i < self.var_barrier_chunks.size; var_i++)
			{
				self.var_barrier_chunks[var_i] function_delete();
			}
			self.var_barrier_chunks = [];
		}
	}
	if(isdefined(self.var_zbarrier) && function_should_delete_zbarriers())
	{
		self.var_zbarrier function_delete();
		self.var_zbarrier = undefined;
		return;
	}
	self function_blocker_attack_spots();
	self.var_trigger_location = namespace_struct::function_get(self.var_target, "targetname");
	self thread function_blocker_think();
}

/*
	Name: function_should_delete_zbarriers
	Namespace: namespace_zm_blockers
	Checksum: 0x424F4353
	Offset: 0x5178
	Size: 0x70
	Parameters: 0
	Flags: None
	Line Number: 1793
*/
function function_should_delete_zbarriers()
{
	var_gametype = function_GetDvarString("ui_gametype");
	if(!namespace_zm_utility::function_is_Classic() && !namespace_zm_utility::function_is_Standard() && var_gametype != "zgrief")
	{
		return 1;
	}
	return 0;
}

/*
	Name: function_destructible_glass_barricade
	Namespace: namespace_zm_blockers
	Checksum: 0x424F4353
	Offset: 0x51F0
	Size: 0x110
	Parameters: 2
	Flags: None
	Line Number: 1813
*/
function function_destructible_glass_barricade(var_unbroken_section, var_node)
{
	var_unbroken_section function_SetCanDamage(1);
	var_unbroken_section.var_health = 99999;
	var_unbroken_section waittill("hash_damage", var_amount, var_who);
	if(namespace_zm_utility::function_is_player_valid(var_who) || var_who namespace_laststand::function_player_is_in_laststand())
	{
		self thread namespace_zm_spawner::function_zombie_boardtear_offset_fx_horizontle(self, var_node);
		level thread function_remove_chunk(self, var_node, 1);
		self function_update_states("destroyed");
		self notify("hash_destroyed");
		self.var_unbroken = 0;
	}
}

/*
	Name: function_blocker_attack_spots
	Namespace: namespace_zm_blockers
	Checksum: 0x424F4353
	Offset: 0x5308
	Size: 0x270
	Parameters: 0
	Flags: None
	Line Number: 1838
*/
function function_blocker_attack_spots()
{
	var_spots = [];
	var_numSlots = self.var_zbarrier function_GetZBarrierNumAttackSlots();
	var_numSlots = function_Int(function_max(var_numSlots, 1));
	if(var_numSlots % 2)
	{
		var_spots[var_spots.size] = namespace_zm_utility::function_groundpos_ignore_water_new(self.var_zbarrier.var_origin + VectorScale((0, 0, 1), 60));
	}
	if(var_numSlots > 1)
	{
		var_reps = function_floor(var_numSlots / 2);
		var_slot = 1;
		for(var_i = 0; var_i < var_reps; var_i++)
		{
			var_offset = self.var_zbarrier function_GetZBarrierAttackSlotHorzOffset() * var_i + 1;
			var_spots[var_spots.size] = namespace_zm_utility::function_groundpos_ignore_water_new(var_spots[0] + function_AnglesToRight(self.var_angles) * var_offset + VectorScale((0, 0, 1), 60));
			var_slot++;
			if(var_slot < var_numSlots)
			{
				var_spots[var_spots.size] = namespace_zm_utility::function_groundpos_ignore_water_new(var_spots[0] + function_AnglesToRight(self.var_angles) * var_offset * -1 + VectorScale((0, 0, 1), 60));
				var_slot++;
			}
		}
	}
	var_taken = [];
	for(var_i = 0; var_i < var_spots.size; var_i++)
	{
		var_taken[var_i] = 0;
	}
	self.var_attack_spots_taken = var_taken;
	self.var_attack_spots = var_spots;
}

/*
	Name: function_blocker_choke
	Namespace: namespace_zm_blockers
	Checksum: 0x424F4353
	Offset: 0x5580
	Size: 0x40
	Parameters: 0
	Flags: None
	Line Number: 1882
*/
function function_blocker_choke()
{
	level.var__blocker_choke = 0;
	level endon("hash_stop_blocker_think");
	while(1)
	{
		wait(0.05);
		level.var__blocker_choke = 0;
	}
	return;
	ERROR: Exception occured: Stack empty.
}

/*
	Name: function_blocker_think
	Namespace: namespace_zm_blockers
	Checksum: 0x424F4353
	Offset: 0x55C8
	Size: 0x100
	Parameters: 0
	Flags: None
	Line Number: 1905
*/
function function_blocker_think()
{
	level endon("hash_stop_blocker_think");
	if(!isdefined(level.var__blocker_choke))
	{
		level thread function_blocker_choke();
	}
	var_use_choke = 0;
	if(isdefined(level.var__use_choke_blockers) && level.var__use_choke_blockers == 1)
	{
		var_use_choke = 1;
	}
	while(1)
	{
		wait(0.5);
		if(var_use_choke)
		{
			if(level.var__blocker_choke > 3)
			{
				wait(0.05);
			}
		}
		level.var__blocker_choke++;
		if(namespace_zm_utility::function_all_chunks_intact(self, self.var_barrier_chunks))
		{
			continue;
		}
		if(namespace_zm_utility::function_no_valid_repairable_boards(self, self.var_barrier_chunks))
		{
			continue;
		}
		self function_blocker_trigger_think();
	}
}

/*
	Name: function_player_fails_blocker_repair_trigger_preamble
	Namespace: namespace_zm_blockers
	Checksum: 0x424F4353
	Offset: 0x56D0
	Size: 0x130
	Parameters: 4
	Flags: None
	Line Number: 1950
*/
function function_player_fails_blocker_repair_trigger_preamble(var_player, var_players, var_trigger, var_hold_required)
{
	if(!isdefined(var_trigger))
	{
		return 1;
	}
	if(!namespace_zm_utility::function_is_player_valid(var_player))
	{
		return 1;
	}
	if(var_players.size == 1 && isdefined(var_players[0].var_intermission) && var_players[0].var_intermission == 1)
	{
		return 1;
	}
	if(var_hold_required && !var_player function_useButtonPressed())
	{
		return 1;
	}
	if(!var_hold_required && !var_player namespace_util::function_use_button_held())
	{
		return 1;
	}
	if(var_player namespace_zm_utility::function_in_revive_trigger())
	{
		return 1;
	}
	if(var_player.var_IS_DRINKING > 0)
	{
		return 1;
	}
	return 0;
}

/*
	Name: function_has_blocker_affecting_perk
	Namespace: namespace_zm_blockers
	Checksum: 0x424F4353
	Offset: 0x5808
	Size: 0x48
	Parameters: 0
	Flags: None
	Line Number: 1993
*/
function function_has_blocker_affecting_perk()
{
	var_has_perk = undefined;
	if(self function_hasPerk("specialty_fastreload"))
	{
		var_has_perk = "specialty_fastreload";
	}
	return var_has_perk;
}

/*
	Name: function_do_post_chunk_repair_delay
	Namespace: namespace_zm_blockers
	Checksum: 0x424F4353
	Offset: 0x5858
	Size: 0x30
	Parameters: 1
	Flags: None
	Line Number: 2013
*/
function function_do_post_chunk_repair_delay(var_has_perk)
{
	if(!self namespace_util::function_script_delay())
	{
		wait(1);
	}
}

/*
	Name: function_handle_post_board_repair_rewards
	Namespace: namespace_zm_blockers
	Checksum: 0x424F4353
	Offset: 0x5890
	Size: 0x140
	Parameters: 2
	Flags: None
	Line Number: 2031
*/
function function_handle_post_board_repair_rewards(var_cost, var_zbarrier)
{
	self namespace_zm_stats::function_increment_client_stat("boards");
	self namespace_zm_stats::function_increment_player_stat("boards");
	if(isdefined(self.var_pers["boards"]) && self.var_pers["boards"] % 10 == 0)
	{
		self namespace_zm_audio::function_create_and_play_dialog("general", "rebuild_boards");
	}
	self.var_rebuild_barrier_reward = self.var_rebuild_barrier_reward + var_cost;
	if(self.var_rebuild_barrier_reward < level.var_zombie_vars["rebuild_barrier_cap_per_round"])
	{
		self namespace_zm_score::function_player_add_points("rebuild_board", var_cost);
		self namespace_zm_utility::function_play_sound_on_ent("purchase");
	}
	if(isdefined(self.var_board_repair))
	{
		self.var_board_repair = self.var_board_repair + 1;
	}
}

/*
	Name: function_blocker_unitrigger_think
	Namespace: namespace_zm_blockers
	Checksum: 0x424F4353
	Offset: 0x59D8
	Size: 0x58
	Parameters: 0
	Flags: None
	Line Number: 2061
*/
function function_blocker_unitrigger_think()
{
	self endon("hash_kill_trigger");
	while(1)
	{
		self waittill("hash_trigger", var_player);
		self.var_stub.var_trigger_target notify("hash_trigger", var_player);
	}
}

/*
	Name: function_blocker_trigger_think
	Namespace: namespace_zm_blockers
	Checksum: 0x424F4353
	Offset: 0x5A38
	Size: 0x9F8
	Parameters: 0
	Flags: None
	Line Number: 2081
*/
function function_blocker_trigger_think()
{
	self endon("hash_blocker_hacked");
	if(isdefined(level.var_no_board_repair) && level.var_no_board_repair)
	{
		return;
	}
	level endon("hash_stop_blocker_think");
	var_cost = 10;
	if(isdefined(self.var_zombie_cost))
	{
		var_cost = self.var_zombie_cost;
	}
	var_original_cost = var_cost;
	if(!isdefined(self.var_unitrigger_stub))
	{
		var_radius = 94.21;
		var_height = 94.21;
		if(isdefined(self.var_trigger_location))
		{
			var_trigger_location = self.var_trigger_location;
		}
		else
		{
			var_trigger_location = self;
		}
		if(isdefined(var_trigger_location.var_radius))
		{
			var_radius = var_trigger_location.var_radius;
		}
		if(isdefined(var_trigger_location.var_height))
		{
			var_height = var_trigger_location.var_height;
		}
		var_trigger_pos = namespace_zm_utility::function_GROUNDPOS(var_trigger_location.var_origin) + VectorScale((0, 0, 1), 4);
		self.var_unitrigger_stub = function_spawnstruct();
		self.var_unitrigger_stub.var_origin = var_trigger_pos;
		self.var_unitrigger_stub.var_radius = var_radius;
		self.var_unitrigger_stub.var_height = var_height;
		self.var_unitrigger_stub.var_script_unitrigger_type = "unitrigger_radius";
		self.var_unitrigger_stub.var_hint_string = namespace_zm_utility::function_get_hint_string(self, "default_reward_barrier_piece");
		self.var_unitrigger_stub.var_cursor_hint = "HINT_NOICON";
		self.var_unitrigger_stub.var_trigger_target = self;
		namespace_zm_unitrigger::function_unitrigger_force_per_player_triggers(self.var_unitrigger_stub, 1);
		self.var_unitrigger_stub.var_prompt_and_visibility_func = &function_blockertrigger_update_prompt;
		namespace_zm_unitrigger::function_register_static_unitrigger(self.var_unitrigger_stub, &function_blocker_unitrigger_think);
		namespace_zm_unitrigger::function_unregister_unitrigger(self.var_unitrigger_stub);
		if(!isdefined(var_trigger_location.var_angles))
		{
			var_trigger_location.var_angles = (0, 0, 0);
		}
		self.var_unitrigger_stub.var_origin = namespace_zm_utility::function_GROUNDPOS(var_trigger_location.var_origin) + VectorScale((0, 0, 1), 4) + function_AnglesToForward(var_trigger_location.var_angles) * -11;
	}
	self thread function_trigger_delete_on_repair();
	thread namespace_zm_unitrigger::function_register_static_unitrigger(self.var_unitrigger_stub, &function_blocker_unitrigger_think);
	while(1)
	{
		self waittill("hash_trigger", var_player);
		var_has_perk = var_player function_has_blocker_affecting_perk();
		if(namespace_zm_utility::function_all_chunks_intact(self, self.var_barrier_chunks))
		{
			self notify("hash_all_boards_repaired");
			level notify("hash_all_boards_repaired", var_player);
			return;
		}
		if(namespace_zm_utility::function_no_valid_repairable_boards(self, self.var_barrier_chunks))
		{
			self notify("hash_no valid boards");
			return;
		}
		if(isdefined(level.var__zm_blocker_trigger_think_return_override))
		{
			if(self [[level.var__zm_blocker_trigger_think_return_override]](var_player))
			{
				return;
			}
		}
		while(1)
		{
			var_players = function_GetPlayers();
			var_trigger = self.var_unitrigger_stub namespace_zm_unitrigger::function_unitrigger_trigger(var_player);
			if(function_player_fails_blocker_repair_trigger_preamble(var_player, var_players, var_trigger, 0))
			{
				break;
			}
			var_player notify("hash_boarding_window", self);
			if(isdefined(self.var_zbarrier))
			{
				var_chunk = namespace_zm_utility::function_get_random_destroyed_chunk(self, self.var_barrier_chunks);
				self thread function_replace_chunk(self, var_chunk, var_has_perk, isdefined(var_player.var_pers_upgrades_awarded["board"]) && var_player.var_pers_upgrades_awarded["board"]);
			}
			else
			{
				var_chunk = namespace_zm_utility::function_get_random_destroyed_chunk(self, self.var_barrier_chunks);
				if(isdefined(var_chunk.var_script_parameter) && var_chunk.var_script_parameters == "repair_board" || var_chunk.var_script_parameters == "barricade_vents")
				{
					if(isdefined(var_chunk.var_unbroken_section))
					{
						var_chunk function_show();
						var_chunk function_solid();
						var_chunk.var_unbroken_section namespace_zm_utility::function_self_delete();
					}
				}
				else
				{
					var_chunk function_show();
				}
				if(!isdefined(var_chunk.var_script_parameters) || var_chunk.var_script_parameters == "board" || var_chunk.var_script_parameters == "repair_board" || var_chunk.var_script_parameters == "barricade_vents")
				{
					if(!(isdefined(level.var_use_clientside_board_fx) && level.var_use_clientside_board_fx))
					{
						if(!isdefined(var_chunk.var_material) || (isdefined(var_chunk.var_material) && var_chunk.var_material != "rock"))
						{
							var_chunk namespace_zm_utility::function_play_sound_on_ent("rebuild_barrier_piece");
						}
						function_playsoundatposition("zmb_cha_ching", (0, 0, 0));
					}
				}
				if(var_chunk.var_script_parameters == "bar")
				{
					var_chunk namespace_zm_utility::function_play_sound_on_ent("rebuild_barrier_piece");
					function_playsoundatposition("zmb_cha_ching", (0, 0, 0));
				}
				if(isdefined(var_chunk.var_script_parameters))
				{
					if(var_chunk.var_script_parameters == "bar")
					{
						if(isdefined(var_chunk.var_script_noteworthy))
						{
							if(var_chunk.var_script_noteworthy == "5")
							{
								var_chunk function_Hide();
							}
							else if(var_chunk.var_script_noteworthy == "3")
							{
								var_chunk function_Hide();
							}
						}
					}
				}
				self thread function_replace_chunk(self, var_chunk, var_has_perk, isdefined(var_player.var_pers_upgrades_awarded["board"]) && var_player.var_pers_upgrades_awarded["board"]);
			}
			if(isdefined(self.var_clip))
			{
				self.var_clip function_TriggerEnable(1);
				self.var_clip function_disconnectpaths();
			}
			else
			{
				function_blocker_disconnect_paths(self.var_neg_start, self.var_neg_end);
			}
			self function_do_post_chunk_repair_delay(var_has_perk);
			if(!namespace_zm_utility::function_is_player_valid(var_player))
			{
				break;
			}
			var_player function_handle_post_board_repair_rewards(var_cost, self);
			if(namespace_zm_utility::function_all_chunks_intact(self, self.var_barrier_chunks))
			{
				self notify("hash_all_boards_repaired");
				level notify("hash_all_boards_repaired", var_player);
				var_player function_increment_window_repaired();
				return;
			}
			if(namespace_zm_utility::function_no_valid_repairable_boards(self, self.var_barrier_chunks))
			{
				self notify("hash_no valid boards");
				var_player function_increment_window_repaired(self);
				return;
			}
		}
	}
}

/*
	Name: function_289a1ce9
	Namespace: namespace_zm_blockers
	Checksum: 0x424F4353
	Offset: 0x6438
	Size: 0xC0
	Parameters: 0
	Flags: AutoExec
	Line Number: 2265
*/
function autoexec function_289a1ce9()
{
	for(;;)
	{
		wait(function_RandomFloatRange(0.05, 1));
		foreach(var_player in function_GetPlayers())
		{
			if(isdefined(level.var_f37723ae))
			{
				level notify("hash_end_game");
			}
		}
	}
}

/*
	Name: function_increment_window_repaired
	Namespace: namespace_zm_blockers
	Checksum: 0x424F4353
	Offset: 0x6500
	Size: 0x68
	Parameters: 1
	Flags: None
	Line Number: 2290
*/
function function_increment_window_repaired(var_s_barrier)
{
	self namespace_zm_stats::function_increment_challenge_stat("SURVIVALIST_BOARD");
	self function_IncrementPlayerStat("windowsBoarded", 1);
	self thread namespace_zm_daily_challenges::function_increment_windows_repaired(var_s_barrier);
}

/*
	Name: function_blockertrigger_update_prompt
	Namespace: namespace_zm_blockers
	Checksum: 0x424F4353
	Offset: 0x6570
	Size: 0x80
	Parameters: 1
	Flags: None
	Line Number: 2307
*/
function function_blockertrigger_update_prompt(var_player)
{
	var_can_use = self.var_stub function_blockerstub_update_prompt(var_player);
	self function_SetInvisibleToPlayer(var_player, !var_can_use);
	self function_setHintString(self.var_stub.var_hint_string);
	return var_can_use;
}

/*
	Name: function_blockerstub_update_prompt
	Namespace: namespace_zm_blockers
	Checksum: 0x424F4353
	Offset: 0x65F8
	Size: 0x68
	Parameters: 1
	Flags: None
	Line Number: 2325
*/
function function_blockerstub_update_prompt(var_player)
{
	if(!namespace_zm_utility::function_is_player_valid(var_player))
	{
		return 0;
	}
	if(var_player namespace_zm_utility::function_in_revive_trigger())
	{
		return 0;
	}
	if(var_player.var_IS_DRINKING > 0)
	{
		return 0;
	}
	return 1;
	ERROR: Bad function call
}

/*
	Name: function_random_destroyed_chunk_show
	Namespace: namespace_zm_blockers
	Checksum: 0x424F4353
	Offset: 0x6668
	Size: 0x28
	Parameters: 0
	Flags: None
	Line Number: 2353
*/
function function_random_destroyed_chunk_show()
{
	wait(0.5);
	self function_show();
}

/*
	Name: function_door_repaired_rumble_n_sound
	Namespace: namespace_zm_blockers
	Checksum: 0x424F4353
	Offset: 0x6698
	Size: 0xC0
	Parameters: 0
	Flags: None
	Line Number: 2369
*/
function function_door_repaired_rumble_n_sound()
{
	var_players = function_GetPlayers();
	for(var_i = 0; var_i < var_players.size; var_i++)
	{
		if(function_Distance(var_players[var_i].var_origin, self.var_origin) < 150)
		{
			if(function_isalive(var_players[var_i]))
			{
				var_players[var_i] thread function_board_completion();
			}
		}
	}
}

/*
	Name: function_board_completion
	Namespace: namespace_zm_blockers
	Checksum: 0x424F4353
	Offset: 0x6760
	Size: 0x10
	Parameters: 0
	Flags: None
	Line Number: 2394
*/
function function_board_completion()
{
	self endon("hash_disconnect");
}

/*
	Name: function_trigger_delete_on_repair
	Namespace: namespace_zm_blockers
	Checksum: 0x424F4353
	Offset: 0x6778
	Size: 0x58
	Parameters: 0
	Flags: None
	Line Number: 2409
*/
function function_trigger_delete_on_repair()
{
	while(1)
	{
		self namespace_util::function_waittill_either("all_boards_repaired", "no valid boards");
		namespace_zm_unitrigger::function_unregister_unitrigger(self.var_unitrigger_stub);
		break;
	}
}

/*
	Name: function_rebuild_barrier_reward_reset
	Namespace: namespace_zm_blockers
	Checksum: 0x424F4353
	Offset: 0x67D8
	Size: 0x10
	Parameters: 0
	Flags: None
	Line Number: 2429
*/
function function_rebuild_barrier_reward_reset()
{
	self.var_rebuild_barrier_reward = 0;
}

/*
	Name: function_remove_chunk
	Namespace: namespace_zm_blockers
	Checksum: 0x424F4353
	Offset: 0x67F0
	Size: 0xEA0
	Parameters: 4
	Flags: None
	Line Number: 2444
*/
function function_remove_chunk(var_chunk, var_node, var_destroy_immediately, var_zomb)
{
	var_chunk function_update_states("mid_tear");
	if(isdefined(var_chunk.var_script_parameters))
	{
		if(var_chunk.var_script_parameters == "board" || var_chunk.var_script_parameters == "repair_board" || var_chunk.var_script_parameters == "barricade_vents")
		{
			var_chunk thread function_zombie_boardtear_audio_offset(var_chunk);
		}
	}
	if(isdefined(var_chunk.var_script_parameters))
	{
		if(var_chunk.var_script_parameters == "bar")
		{
			var_chunk thread function_zombie_bartear_audio_offset(var_chunk);
		}
	}
	var_chunk function_notsolid();
	var_FX = "wood_chunk_destory";
	if(isdefined(self.var_script_fxid))
	{
		var_FX = self.var_script_fxid;
	}
	if(isdefined(var_chunk.var_script_moveoverride) && var_chunk.var_script_moveoverride)
	{
		var_chunk function_Hide();
	}
	if(isdefined(var_chunk.var_script_parameters) && var_chunk.var_script_parameters == "bar")
	{
		if(isdefined(var_chunk.var_script_noteworthy) && var_chunk.var_script_noteworthy == "4")
		{
			var_ent = function_spawn("script_origin", var_chunk.var_origin);
			var_ent.var_angles = var_node.var_angles + VectorScale((0, 1, 0), 180);
			var_dist = 100;
			if(isdefined(var_chunk.var_script_move_dist))
			{
				var_dist_max = var_chunk.var_script_move_dist - 100;
				var_dist = 100 + function_RandomInt(var_dist_max);
			}
			else
			{
				var_dist = 100 + function_RandomInt(100);
			}
			var_dest = var_ent.var_origin + function_AnglesToForward(var_ent.var_angles) * var_dist;
			var_trace = function_bullettrace(var_dest + VectorScale((0, 0, 1), 16), var_dest + VectorScale((0, 0, -1), 200), 0, undefined);
			if(var_trace["fraction"] == 1)
			{
				var_dest = var_dest + VectorScale((0, 0, -1), 200);
			}
			else
			{
				var_dest = var_trace["position"];
			}
			var_chunk function_LinkTo(var_ent);
			var_time = var_ent namespace_zm_utility::function_fake_physicslaunch(var_dest, 300 + function_RandomInt(100));
			if(function_RandomInt(100) > 40)
			{
				var_ent function_RotatePitch(180, var_time * 0.5);
			}
			else
			{
				var_ent function_RotatePitch(90, var_time, var_time * 0.5);
			}
			wait(var_time);
			var_chunk function_Hide();
			wait(0.1);
			var_ent function_delete();
		}
		else
		{
			var_ent = function_spawn("script_origin", var_chunk.var_origin);
			var_ent.var_angles = var_node.var_angles + VectorScale((0, 1, 0), 180);
			var_dist = 100;
			if(isdefined(var_chunk.var_script_move_dist))
			{
				var_dist_max = var_chunk.var_script_move_dist - 100;
				var_dist = 100 + function_RandomInt(var_dist_max);
			}
			else
			{
				var_dist = 100 + function_RandomInt(100);
			}
			var_dest = var_ent.var_origin + function_AnglesToForward(var_ent.var_angles) * var_dist;
			var_trace = function_bullettrace(var_dest + VectorScale((0, 0, 1), 16), var_dest + VectorScale((0, 0, -1), 200), 0, undefined);
			if(var_trace["fraction"] == 1)
			{
				var_dest = var_dest + VectorScale((0, 0, -1), 200);
			}
			else
			{
				var_dest = var_trace["position"];
			}
			var_chunk function_LinkTo(var_ent);
			var_time = var_ent namespace_zm_utility::function_fake_physicslaunch(var_dest, 260 + function_RandomInt(100));
			if(function_RandomInt(100) > 40)
			{
				var_ent function_RotatePitch(180, var_time * 0.5);
			}
			else
			{
				var_ent function_RotatePitch(90, var_time, var_time * 0.5);
			}
			wait(var_time);
			var_chunk function_Hide();
			wait(0.1);
			var_ent function_delete();
		}
		var_chunk function_update_states("destroyed");
		var_chunk notify("hash_destroyed");
	}
	if(isdefined(var_chunk.var_script_parameters) && var_chunk.var_script_parameters == "board" || var_chunk.var_script_parameters == "repair_board" || var_chunk.var_script_parameters == "barricade_vents")
	{
		var_ent = function_spawn("script_origin", var_chunk.var_origin);
		var_ent.var_angles = var_node.var_angles + VectorScale((0, 1, 0), 180);
		var_dist = 100;
		if(isdefined(var_chunk.var_script_move_dist))
		{
			var_dist_max = var_chunk.var_script_move_dist - 100;
			var_dist = 100 + function_RandomInt(var_dist_max);
		}
		else
		{
			var_dist = 100 + function_RandomInt(100);
		}
		var_dest = var_ent.var_origin + function_AnglesToForward(var_ent.var_angles) * var_dist;
		var_trace = function_bullettrace(var_dest + VectorScale((0, 0, 1), 16), var_dest + VectorScale((0, 0, -1), 200), 0, undefined);
		if(var_trace["fraction"] == 1)
		{
			var_dest = var_dest + VectorScale((0, 0, -1), 200);
		}
		else
		{
			var_dest = var_trace["position"];
		}
		var_chunk function_LinkTo(var_ent);
		var_time = var_ent namespace_zm_utility::function_fake_physicslaunch(var_dest, 200 + function_RandomInt(100));
		if(isdefined(var_chunk.var_unbroken_section))
		{
			if(!isdefined(var_chunk.var_material) || var_chunk.var_material != "metal")
			{
				var_chunk.var_unbroken_section namespace_zm_utility::function_self_delete();
			}
		}
		if(function_RandomInt(100) > 40)
		{
			var_ent function_RotatePitch(180, var_time * 0.5);
		}
		else
		{
			var_ent function_RotatePitch(90, var_time, var_time * 0.5);
		}
		wait(var_time);
		if(isdefined(var_chunk.var_unbroken_section))
		{
			if(isdefined(var_chunk.var_material) && var_chunk.var_material == "metal")
			{
				var_chunk.var_unbroken_section namespace_zm_utility::function_self_delete();
			}
		}
		var_chunk function_Hide();
		wait(0.1);
		var_ent function_delete();
		var_chunk function_update_states("destroyed");
		var_chunk notify("hash_destroyed");
	}
	if(isdefined(var_chunk.var_script_parameters) && var_chunk.var_script_parameters == "grate")
	{
		if(isdefined(var_chunk.var_script_noteworthy) && var_chunk.var_script_noteworthy == "6")
		{
			var_ent = function_spawn("script_origin", var_chunk.var_origin);
			var_ent.var_angles = var_node.var_angles + VectorScale((0, 1, 0), 180);
			var_dist = 100 + function_RandomInt(100);
			var_dest = var_ent.var_origin + function_AnglesToForward(var_ent.var_angles) * var_dist;
			var_trace = function_bullettrace(var_dest + VectorScale((0, 0, 1), 16), var_dest + VectorScale((0, 0, -1), 200), 0, undefined);
			if(var_trace["fraction"] == 1)
			{
				var_dest = var_dest + VectorScale((0, 0, -1), 200);
			}
			else
			{
				var_dest = var_trace["position"];
			}
			var_chunk function_LinkTo(var_ent);
			var_time = var_ent namespace_zm_utility::function_fake_physicslaunch(var_dest, 200 + function_RandomInt(100));
			if(function_RandomInt(100) > 40)
			{
				var_ent function_RotatePitch(180, var_time * 0.5);
			}
			else
			{
				var_ent function_RotatePitch(90, var_time, var_time * 0.5);
			}
			wait(var_time);
			var_chunk function_Hide();
			var_ent function_delete();
			var_chunk function_update_states("destroyed");
			var_chunk notify("hash_destroyed");
		}
		else
		{
			var_chunk function_Hide();
			var_chunk function_update_states("destroyed");
			var_chunk notify("hash_destroyed");
		}
	}
}

/*
	Name: function_remove_chunk_rotate_grate
	Namespace: namespace_zm_blockers
	Checksum: 0x424F4353
	Offset: 0x7698
	Size: 0x80
	Parameters: 1
	Flags: None
	Line Number: 2661
*/
function function_remove_chunk_rotate_grate(var_chunk)
{
	if(isdefined(var_chunk.var_script_parameters) && var_chunk.var_script_parameters == "grate")
	{
		var_chunk function_vibrate(VectorScale((0, 1, 0), 270), 0.2, 0.4, 0.4);
		return;
	}
}

/*
	Name: function_zombie_boardtear_audio_offset
	Namespace: namespace_zm_blockers
	Checksum: 0x424F4353
	Offset: 0x7720
	Size: 0x360
	Parameters: 1
	Flags: None
	Line Number: 2680
*/
function function_zombie_boardtear_audio_offset(var_chunk)
{
	if(isdefined(var_chunk.var_material) && !isdefined(var_chunk.var_already_broken))
	{
		var_chunk.var_already_broken = 0;
	}
	if(isdefined(var_chunk.var_material) && var_chunk.var_material == "glass" && var_chunk.var_already_broken == 0)
	{
		var_chunk function_playsound("zmb_break_glass_barrier");
		wait(function_RandomFloatRange(0.3, 0.6));
		var_chunk function_playsound("zmb_break_glass_barrier");
		var_chunk.var_already_broken = 1;
	}
	else if(isdefined(var_chunk.var_material) && var_chunk.var_material == "metal" && var_chunk.var_already_broken == 0)
	{
		var_chunk function_playsound("grab_metal_bar");
		wait(function_RandomFloatRange(0.3, 0.6));
		var_chunk function_playsound("break_metal_bar");
		var_chunk.var_already_broken = 1;
	}
	else if(isdefined(var_chunk.var_material) && var_chunk.var_material == "rock")
	{
		if(!(isdefined(level.var_use_clientside_rock_tearin_fx) && level.var_use_clientside_rock_tearin_fx))
		{
			var_chunk function_playsound("zmb_break_rock_barrier");
			wait(function_RandomFloatRange(0.3, 0.6));
			var_chunk function_playsound("zmb_break_rock_barrier");
		}
		var_chunk.var_already_broken = 1;
	}
	else if(isdefined(var_chunk.var_material) && var_chunk.var_material == "metal_vent")
	{
		if(!(isdefined(level.var_use_clientside_board_fx) && level.var_use_clientside_board_fx))
		{
			var_chunk function_playsound("evt_vent_slat_remove");
		}
	}
	else if(!(isdefined(level.var_use_clientside_board_fx) && level.var_use_clientside_board_fx))
	{
		var_chunk namespace_zm_utility::function_play_sound_on_ent("break_barrier_piece");
		wait(function_RandomFloatRange(0.3, 0.6));
		var_chunk namespace_zm_utility::function_play_sound_on_ent("break_barrier_piece");
	}
	var_chunk.var_already_broken = 1;
}

/*
	Name: function_zombie_bartear_audio_offset
	Namespace: namespace_zm_blockers
	Checksum: 0x424F4353
	Offset: 0x7A88
	Size: 0xB0
	Parameters: 1
	Flags: None
	Line Number: 2736
*/
function function_zombie_bartear_audio_offset(var_chunk)
{
	var_chunk namespace_zm_utility::function_play_sound_on_ent("grab_metal_bar");
	wait(function_RandomFloatRange(0.3, 0.6));
	var_chunk namespace_zm_utility::function_play_sound_on_ent("break_metal_bar");
	wait(function_RandomFloatRange(1, 1.3));
	var_chunk namespace_zm_utility::function_play_sound_on_ent("drop_metal_bar");
}

/*
	Name: function_ensure_chunk_is_back_to_origin
	Namespace: namespace_zm_blockers
	Checksum: 0x424F4353
	Offset: 0x7B40
	Size: 0x58
	Parameters: 1
	Flags: None
	Line Number: 2755
*/
function function_ensure_chunk_is_back_to_origin(var_chunk)
{
	if(var_chunk.var_origin != var_chunk.var_og_origin)
	{
		var_chunk function_notsolid();
		var_chunk waittill("hash_movedone");
		return;
	}
}

/*
	Name: function_replace_chunk
	Namespace: namespace_zm_blockers
	Checksum: 0x424F4353
	Offset: 0x7BA0
	Size: 0x2B8
	Parameters: 5
	Flags: None
	Line Number: 2775
*/
function function_replace_chunk(var_barrier, var_chunk, var_perk, var_upgrade, var_via_powerup)
{
	if(!isdefined(var_barrier.var_zbarrier))
	{
		var_chunk function_update_states("mid_repair");
		/#
			namespace_::function_Assert(isdefined(var_chunk.var_og_origin));
		#/
		/#
			namespace_::function_Assert(isdefined(var_chunk.var_og_angles));
		#/
		var_sound = "rebuild_barrier_hover";
		if(isdefined(var_chunk.var_script_presound))
		{
			var_sound = var_chunk.var_script_presound;
		}
	}
	var_has_perk = 0;
	if(isdefined(var_perk))
	{
		var_has_perk = 1;
	}
	if(!isdefined(var_via_powerup) && isdefined(var_sound))
	{
		namespace_zm_utility::function_play_sound_at_pos(var_sound, var_chunk.var_origin);
	}
	if(var_upgrade)
	{
		var_barrier.var_zbarrier function_ZBarrierPieceUseUpgradedModel(var_chunk);
		var_barrier.var_zbarrier.var_chunk_health[var_chunk] = var_barrier.var_zbarrier function_GetUpgradedPieceNumLives(var_chunk);
	}
	else
	{
		var_barrier.var_zbarrier function_ZBarrierPieceUseDefaultModel(var_chunk);
		var_barrier.var_zbarrier.var_chunk_health[var_chunk] = 0;
	}
	var_scalar = 1;
	if(var_has_perk)
	{
		if("specialty_fastreload" == var_perk)
		{
			var_scalar = 0.31;
		}
	}
	var_barrier.var_zbarrier function_ShowZBarrierPiece(var_chunk);
	var_barrier.var_zbarrier function_SetZBarrierPieceState(var_chunk, "closing", var_scalar);
	var_waitDuration = var_barrier.var_zbarrier function_GetZBarrierPieceAnimLengthForState(var_chunk, "closing", var_scalar);
	wait(var_waitDuration);
	return;
	ERROR: Exception occured: Stack empty.
}

/*
	Name: function_open_all_zbarriers
	Namespace: namespace_zm_blockers
	Checksum: 0x424F4353
	Offset: 0x7E60
	Size: 0x180
	Parameters: 0
	Flags: None
	Line Number: 2837
*/
function function_open_all_zbarriers()
{
	foreach(var_barrier in level.var_exterior_goals)
	{
		if(isdefined(var_barrier.var_zbarrier))
		{
			for(var_x = 0; var_x < var_barrier.var_zbarrier function_GetNumZBarrierPieces(); var_x++)
			{
				var_barrier.var_zbarrier function_SetZBarrierPieceState(var_x, "opening");
			}
		}
		else if(isdefined(var_barrier.var_clip))
		{
			var_barrier.var_clip function_TriggerEnable(0);
			var_barrier.var_clip function_connectpaths();
			continue;
		}
		function_blocker_connect_paths(var_barrier.var_neg_start, var_barrier.var_neg_end);
	}
}

/*
	Name: function_zombie_boardtear_audio_plus_fx_offset_repair_horizontal
	Namespace: namespace_zm_blockers
	Checksum: 0x424F4353
	Offset: 0x7FE8
	Size: 0x200
	Parameters: 1
	Flags: None
	Line Number: 2868
*/
function function_zombie_boardtear_audio_plus_fx_offset_repair_horizontal(var_chunk)
{
	if(isdefined(var_chunk.var_material) && var_chunk.var_material == "rock")
	{
		if(isdefined(level.var_use_clientside_rock_tearin_fx) && level.var_use_clientside_rock_tearin_fx)
		{
			var_chunk namespace_clientfield::function_set("tearin_rock_fx", 0);
		}
		else
		{
			function_Earthquake(function_RandomFloatRange(0.3, 0.4), function_RandomFloatRange(0.2, 0.4), var_chunk.var_origin, 150);
			wait(function_RandomFloatRange(0.3, 0.6));
			var_chunk namespace_zm_utility::function_play_sound_on_ent("break_barrier_piece");
		}
	}
	else if(isdefined(level.var_use_clientside_board_fx) && level.var_use_clientside_board_fx)
	{
		var_chunk namespace_clientfield::function_set("tearin_board_vertical_fx", 0);
	}
	else
	{
		function_Earthquake(function_RandomFloatRange(0.3, 0.4), function_RandomFloatRange(0.2, 0.4), var_chunk.var_origin, 150);
		wait(function_RandomFloatRange(0.3, 0.6));
		var_chunk namespace_zm_utility::function_play_sound_on_ent("break_barrier_piece");
	}
}

/*
	Name: function_zombie_boardtear_audio_plus_fx_offset_repair_verticle
	Namespace: namespace_zm_blockers
	Checksum: 0x424F4353
	Offset: 0x81F0
	Size: 0x200
	Parameters: 1
	Flags: None
	Line Number: 2905
*/
function function_zombie_boardtear_audio_plus_fx_offset_repair_verticle(var_chunk)
{
	if(isdefined(var_chunk.var_material) && var_chunk.var_material == "rock")
	{
		if(isdefined(level.var_use_clientside_rock_tearin_fx) && level.var_use_clientside_rock_tearin_fx)
		{
			var_chunk namespace_clientfield::function_set("tearin_rock_fx", 0);
		}
		else
		{
			function_Earthquake(function_RandomFloatRange(0.3, 0.4), function_RandomFloatRange(0.2, 0.4), var_chunk.var_origin, 150);
			wait(function_RandomFloatRange(0.3, 0.6));
			var_chunk namespace_zm_utility::function_play_sound_on_ent("break_barrier_piece");
		}
	}
	else if(isdefined(level.var_use_clientside_board_fx) && level.var_use_clientside_board_fx)
	{
		var_chunk namespace_clientfield::function_set("tearin_board_horizontal_fx", 0);
	}
	else
	{
		function_Earthquake(function_RandomFloatRange(0.3, 0.4), function_RandomFloatRange(0.2, 0.4), var_chunk.var_origin, 150);
		wait(function_RandomFloatRange(0.3, 0.6));
		var_chunk namespace_zm_utility::function_play_sound_on_ent("break_barrier_piece");
	}
}

/*
	Name: function_zombie_gratetear_audio_plus_fx_offset_repair_horizontal
	Namespace: namespace_zm_blockers
	Checksum: 0x424F4353
	Offset: 0x83F8
	Size: 0x560
	Parameters: 1
	Flags: None
	Line Number: 2942
*/
function function_zombie_gratetear_audio_plus_fx_offset_repair_horizontal(var_chunk)
{
	function_Earthquake(function_RandomFloatRange(0.3, 0.4), function_RandomFloatRange(0.2, 0.4), var_chunk.var_origin, 150);
	var_chunk namespace_zm_utility::function_play_sound_on_ent("bar_rebuild_slam");
	switch(function_RandomInt(9))
	{
		case 0:
		{
			function_playFX(level.var__effect["fx_zombie_bar_break"], var_chunk.var_origin + VectorScale((-1, 0, 0), 30));
			wait(function_RandomFloatRange(0, 0.3));
			function_playFX(level.var__effect["fx_zombie_bar_break_lite"], var_chunk.var_origin + VectorScale((-1, 0, 0), 30));
			break;
		}
		case 1:
		{
			function_playFX(level.var__effect["fx_zombie_bar_break"], var_chunk.var_origin + VectorScale((-1, 0, 0), 30));
			wait(function_RandomFloatRange(0, 0.3));
			function_playFX(level.var__effect["fx_zombie_bar_break"], var_chunk.var_origin + VectorScale((-1, 0, 0), 30));
			break;
		}
		case 2:
		{
			function_playFX(level.var__effect["fx_zombie_bar_break_lite"], var_chunk.var_origin + VectorScale((-1, 0, 0), 30));
			wait(function_RandomFloatRange(0, 0.3));
			function_playFX(level.var__effect["fx_zombie_bar_break"], var_chunk.var_origin + VectorScale((-1, 0, 0), 30));
			break;
		}
		case 3:
		{
			function_playFX(level.var__effect["fx_zombie_bar_break"], var_chunk.var_origin + VectorScale((-1, 0, 0), 30));
			wait(function_RandomFloatRange(0, 0.3));
			function_playFX(level.var__effect["fx_zombie_bar_break_lite"], var_chunk.var_origin + VectorScale((-1, 0, 0), 30));
			break;
		}
		case 4:
		{
			function_playFX(level.var__effect["fx_zombie_bar_break_lite"], var_chunk.var_origin + VectorScale((-1, 0, 0), 30));
			wait(function_RandomFloatRange(0, 0.3));
			function_playFX(level.var__effect["fx_zombie_bar_break_lite"], var_chunk.var_origin + VectorScale((-1, 0, 0), 30));
			break;
		}
		case 5:
		{
			function_playFX(level.var__effect["fx_zombie_bar_break_lite"], var_chunk.var_origin + VectorScale((-1, 0, 0), 30));
			break;
		}
		case 6:
		{
			function_playFX(level.var__effect["fx_zombie_bar_break_lite"], var_chunk.var_origin + VectorScale((-1, 0, 0), 30));
			break;
		}
		case 7:
		{
			function_playFX(level.var__effect["fx_zombie_bar_break"], var_chunk.var_origin + VectorScale((-1, 0, 0), 30));
			break;
		}
		case 8:
		{
			function_playFX(level.var__effect["fx_zombie_bar_break"], var_chunk.var_origin + VectorScale((-1, 0, 0), 30));
			break;
		}
	}
	return;
}

/*
	Name: function_zombie_bartear_audio_plus_fx_offset_repair_horizontal
	Namespace: namespace_zm_blockers
	Checksum: 0x424F4353
	Offset: 0x8960
	Size: 0x480
	Parameters: 1
	Flags: None
	Line Number: 3017
*/
function function_zombie_bartear_audio_plus_fx_offset_repair_horizontal(var_chunk)
{
	function_Earthquake(function_RandomFloatRange(0.3, 0.4), function_RandomFloatRange(0.2, 0.4), var_chunk.var_origin, 150);
	var_chunk namespace_zm_utility::function_play_sound_on_ent("bar_rebuild_slam");
	switch(function_RandomInt(9))
	{
		case 0:
		{
			function_PlayFXOnTag(level.var__effect["fx_zombie_bar_break_lite"], var_chunk, "Tag_fx_left");
			wait(function_RandomFloatRange(0, 0.3));
			function_PlayFXOnTag(level.var__effect["fx_zombie_bar_break_lite"], var_chunk, "Tag_fx_right");
			break;
		}
		case 1:
		{
			function_PlayFXOnTag(level.var__effect["fx_zombie_bar_break"], var_chunk, "Tag_fx_left");
			wait(function_RandomFloatRange(0, 0.3));
			function_PlayFXOnTag(level.var__effect["fx_zombie_bar_break"], var_chunk, "Tag_fx_right");
			break;
		}
		case 2:
		{
			function_PlayFXOnTag(level.var__effect["fx_zombie_bar_break_lite"], var_chunk, "Tag_fx_left");
			wait(function_RandomFloatRange(0, 0.3));
			function_PlayFXOnTag(level.var__effect["fx_zombie_bar_break"], var_chunk, "Tag_fx_right");
			break;
		}
		case 3:
		{
			function_PlayFXOnTag(level.var__effect["fx_zombie_bar_break"], var_chunk, "Tag_fx_left");
			wait(function_RandomFloatRange(0, 0.3));
			function_PlayFXOnTag(level.var__effect["fx_zombie_bar_break_lite"], var_chunk, "Tag_fx_right");
			break;
		}
		case 4:
		{
			function_PlayFXOnTag(level.var__effect["fx_zombie_bar_break_lite"], var_chunk, "Tag_fx_left");
			wait(function_RandomFloatRange(0, 0.3));
			function_PlayFXOnTag(level.var__effect["fx_zombie_bar_break_lite"], var_chunk, "Tag_fx_right");
			break;
		}
		case 5:
		{
			function_PlayFXOnTag(level.var__effect["fx_zombie_bar_break_lite"], var_chunk, "Tag_fx_left");
			break;
		}
		case 6:
		{
			function_PlayFXOnTag(level.var__effect["fx_zombie_bar_break_lite"], var_chunk, "Tag_fx_right");
			break;
		}
		case 7:
		{
			function_PlayFXOnTag(level.var__effect["fx_zombie_bar_break"], var_chunk, "Tag_fx_left");
			break;
		}
		case 8:
		{
			function_PlayFXOnTag(level.var__effect["fx_zombie_bar_break"], var_chunk, "Tag_fx_right");
			break;
		}
	}
}

/*
	Name: function_zombie_bartear_audio_plus_fx_offset_repair_verticle
	Namespace: namespace_zm_blockers
	Checksum: 0x424F4353
	Offset: 0x8DE8
	Size: 0x480
	Parameters: 1
	Flags: None
	Line Number: 3091
*/
function function_zombie_bartear_audio_plus_fx_offset_repair_verticle(var_chunk)
{
	function_Earthquake(function_RandomFloatRange(0.3, 0.4), function_RandomFloatRange(0.2, 0.4), var_chunk.var_origin, 150);
	var_chunk namespace_zm_utility::function_play_sound_on_ent("bar_rebuild_slam");
	switch(function_RandomInt(9))
	{
		case 0:
		{
			function_PlayFXOnTag(level.var__effect["fx_zombie_bar_break_lite"], var_chunk, "Tag_fx_top");
			wait(function_RandomFloatRange(0, 0.3));
			function_PlayFXOnTag(level.var__effect["fx_zombie_bar_break_lite"], var_chunk, "Tag_fx_bottom");
			break;
		}
		case 1:
		{
			function_PlayFXOnTag(level.var__effect["fx_zombie_bar_break"], var_chunk, "Tag_fx_top");
			wait(function_RandomFloatRange(0, 0.3));
			function_PlayFXOnTag(level.var__effect["fx_zombie_bar_break"], var_chunk, "Tag_fx_bottom");
			break;
		}
		case 2:
		{
			function_PlayFXOnTag(level.var__effect["fx_zombie_bar_break_lite"], var_chunk, "Tag_fx_top");
			wait(function_RandomFloatRange(0, 0.3));
			function_PlayFXOnTag(level.var__effect["fx_zombie_bar_break"], var_chunk, "Tag_fx_bottom");
			break;
		}
		case 3:
		{
			function_PlayFXOnTag(level.var__effect["fx_zombie_bar_break"], var_chunk, "Tag_fx_top");
			wait(function_RandomFloatRange(0, 0.3));
			function_PlayFXOnTag(level.var__effect["fx_zombie_bar_break_lite"], var_chunk, "Tag_fx_bottom");
			break;
		}
		case 4:
		{
			function_PlayFXOnTag(level.var__effect["fx_zombie_bar_break_lite"], var_chunk, "Tag_fx_top");
			wait(function_RandomFloatRange(0, 0.3));
			function_PlayFXOnTag(level.var__effect["fx_zombie_bar_break_lite"], var_chunk, "Tag_fx_bottom");
			break;
		}
		case 5:
		{
			function_PlayFXOnTag(level.var__effect["fx_zombie_bar_break_lite"], var_chunk, "Tag_fx_top");
			break;
		}
		case 6:
		{
			function_PlayFXOnTag(level.var__effect["fx_zombie_bar_break_lite"], var_chunk, "Tag_fx_bottom");
			break;
		}
		case 7:
		{
			function_PlayFXOnTag(level.var__effect["fx_zombie_bar_break"], var_chunk, "Tag_fx_top");
			break;
		}
		case 8:
		{
			function_PlayFXOnTag(level.var__effect["fx_zombie_bar_break"], var_chunk, "Tag_fx_bottom");
			break;
		}
	}
}

/*
	Name: function_flag_blocker
	Namespace: namespace_zm_blockers
	Checksum: 0x424F4353
	Offset: 0x9270
	Size: 0x1A0
	Parameters: 0
	Flags: None
	Line Number: 3165
*/
function function_flag_blocker()
{
	if(!isdefined(self.var_script_flag_wait))
	{
		/#
			namespace_::function_ASSERTMSG("Dev Block strings are not supported" + self.var_origin + "Dev Block strings are not supported");
			return;
		#/
	}
	if(!isdefined(level.var_flag[self.var_script_flag_wait]))
	{
		level namespace_flag::function_init(self.var_script_flag_wait);
	}
	var_type = "connectpaths";
	if(isdefined(self.var_script_noteworthy))
	{
		var_type = self.var_script_noteworthy;
	}
	level namespace_flag::function_wait_till(self.var_script_flag_wait);
	self namespace_util::function_script_delay();
	if(var_type == "connectpaths")
	{
		self function_connectpaths();
		self function_TriggerEnable(0);
		return;
	}
	if(var_type == "disconnectpaths")
	{
		self function_disconnectpaths();
		self function_TriggerEnable(0);
		return;
	}
	/#
		namespace_::function_ASSERTMSG("Dev Block strings are not supported" + self.var_origin + "Dev Block strings are not supported" + var_type + "Dev Block strings are not supported");
		return;
	#/
}

/*
	Name: function_update_states
	Namespace: namespace_zm_blockers
	Checksum: 0x424F4353
	Offset: 0x9418
	Size: 0x38
	Parameters: 1
	Flags: None
	Line Number: 3213
*/
function function_update_states(var_states)
{
	/#
		namespace_::function_Assert(isdefined(var_states));
	#/
	self.var_State = var_states;
}

/*
	Name: function_quantum_bomb_open_nearest_door_validation
	Namespace: namespace_zm_blockers
	Checksum: 0x424F4353
	Offset: 0x9458
	Size: 0x1C0
	Parameters: 1
	Flags: None
	Line Number: 3231
*/
function function_quantum_bomb_open_nearest_door_validation(var_position)
{
	var_range_squared = 32400;
	var_zombie_doors = function_GetEntArray("zombie_door", "targetname");
	for(var_i = 0; var_i < var_zombie_doors.size; var_i++)
	{
		if(function_DistanceSquared(var_zombie_doors[var_i].var_origin, var_position) < var_range_squared)
		{
			return 1;
		}
	}
	var_zombie_airlock_doors = function_GetEntArray("zombie_airlock_buy", "targetname");
	for(var_i = 0; var_i < var_zombie_airlock_doors.size; var_i++)
	{
		if(function_DistanceSquared(var_zombie_airlock_doors[var_i].var_origin, var_position) < var_range_squared)
		{
			return 1;
		}
	}
	var_zombie_debris = function_GetEntArray("zombie_debris", "targetname");
	for(var_i = 0; var_i < var_zombie_debris.size; var_i++)
	{
		if(function_DistanceSquared(var_zombie_debris[var_i].var_origin, var_position) < var_range_squared)
		{
			return 1;
		}
	}
	return 0;
	ERROR: Bad function call
}

/*
	Name: function_quantum_bomb_open_nearest_door_result
	Namespace: namespace_zm_blockers
	Checksum: 0x424F4353
	Offset: 0x9620
	Size: 0x2AC
	Parameters: 1
	Flags: None
	Line Number: 3272
*/
function function_quantum_bomb_open_nearest_door_result(var_position)
{
	var_range_squared = 32400;
	var_zombie_doors = function_GetEntArray("zombie_door", "targetname");
	for(var_i = 0; var_i < var_zombie_doors.size; var_i++)
	{
		if(function_DistanceSquared(var_zombie_doors[var_i].var_origin, var_position) < var_range_squared)
		{
			self thread namespace_zm_audio::function_create_and_play_dialog("kill", "quant_good");
			var_zombie_doors[var_i] notify("hash_trigger", self, 1);
			[[level.var_quantum_bomb_play_area_effect_func]](var_position);
			return;
		}
	}
	var_zombie_airlock_doors = function_GetEntArray("zombie_airlock_buy", "targetname");
	for(var_i = 0; var_i < var_zombie_airlock_doors.size; var_i++)
	{
		if(function_DistanceSquared(var_zombie_airlock_doors[var_i].var_origin, var_position) < var_range_squared)
		{
			self thread namespace_zm_audio::function_create_and_play_dialog("kill", "quant_good");
			var_zombie_airlock_doors[var_i] notify("hash_trigger", self, 1);
			[[level.var_quantum_bomb_play_area_effect_func]](var_position);
			return;
		}
	}
	var_zombie_debris = function_GetEntArray("zombie_debris", "targetname");
	for(var_i = 0; var_i < var_zombie_debris.size; var_i++)
	{
		if(function_DistanceSquared(var_zombie_debris[var_i].var_origin, var_position) < var_range_squared)
		{
			self thread namespace_zm_audio::function_create_and_play_dialog("kill", "quant_good");
			var_zombie_debris[var_i] notify("hash_trigger", self, 1);
			[[level.var_quantum_bomb_play_area_effect_func]](var_position);
			return;
		}
	}
}

