#include scripts\codescripts\struct;
#include scripts\shared\aat_shared;
#include scripts\shared\array_shared;
#include scripts\shared\clientfield_shared;
#include scripts\shared\demo_shared;
#include scripts\shared\flag_shared;
#include scripts\shared\system_shared;
#include scripts\shared\util_shared;
#include scripts\sphynx\leveling\_zm_sphynx_leveling;
#include scripts\sphynx\weapons\_zm_weapon_drop_system;
#include scripts\zm\_zm_audio;
#include scripts\zm\_zm_bgb;
#include scripts\zm\_zm_daily_challenges;
#include scripts\zm\_zm_equipment;
#include scripts\zm\_zm_pack_a_punch_util;
#include scripts\zm\_zm_pers_upgrades_functions;
#include scripts\zm\_zm_score;
#include scripts\zm\_zm_stats;
#include scripts\zm\_zm_unitrigger;
#include scripts\zm\_zm_utility;
#include scripts\zm\_zm_weapon_upgrade_system;
#include scripts\zm\_zm_weapons;

#namespace namespace_zm_magicbox;

/*
	Name: function___init__sytem__
	Namespace: namespace_zm_magicbox
	Checksum: 0x424F4353
	Offset: 0xC78
	Size: 0x40
	Parameters: 0
	Flags: AutoExec
	Line Number: 35
*/
function autoexec function___init__sytem__()
{
	namespace_system::function_register("zm_magicbox", &function___init__, &function___main__, undefined);
	return;
	ERROR: Exception occured: Stack empty.
}

/*
	Name: function___init__
	Namespace: namespace_zm_magicbox
	Checksum: 0x424F4353
	Offset: 0xCC0
	Size: 0x388
	Parameters: 0
	Flags: None
	Line Number: 52
*/
function function___init__()
{
	level.var_start_chest_name = "start_chest";
	level.var__effect["poltergeist"] = "zombie/fx_barrier_buy_zmb";
	level.var__effect["lght_marker"] = "zombie/fx_weapon_box_marker_zmb";
	if(0)
	{
		if(!isdefined(function_GetDvarInt("mutator_seasonalcontent")) || function_GetDvarInt("mutator_seasonalcontent") == 0)
		{
			level.var__effect["lght_marker_flare"] = "_sphynx/_zm_random_box_marker_zmb_christmas";
		}
		else if(function_GetDvarInt("mutator_seasonalcontent") > 0)
		{
			level.var__effect["lght_marker_flare"] = "zombie/fx_weapon_box_marker_fl_zmb";
		}
	}
	else
	{
		level.var__effect["lght_marker_flare"] = "zombie/fx_weapon_box_marker_fl_zmb";
	}
	level.var__effect["lght_marker_uncommon"] = "_sphynx/_zm_random_box_marker_zmb_uncommon";
	level.var__effect["lght_marker_rare"] = "_sphynx/_zm_random_box_marker_zmb_rare";
	level.var__effect["lght_marker_epic"] = "_sphynx/_zm_random_box_marker_zmb_epic";
	level.var__effect["lght_marker_legendary"] = "_sphynx/_zm_random_box_marker_zmb_legendary";
	level.var__effect["lght_marker_mythic"] = "_sphynx/_zm_random_box_marker_zmb_mythic";
	level.var__effect["lght_marker_exotic"] = "_sphynx/_zm_random_box_marker_zmb_exotic";
	level.var__effect["lght_marker_divine"] = "_sphynx/_zm_random_box_marker_zmb_divine";
	level.var__effect["lght_marker_eternal"] = "_sphynx/_zm_random_box_marker_zmb_eternal";
	level.var__effect["lght_marker_cosmic"] = "_sphynx/_zm_random_box_marker_zmb_cosmic";
	level.var__effect["lght_marker_celestial"] = "_sphynx/_zm_random_box_marker_zmb_celestial";
	level.var__effect["lght_marker_ultimate"] = "_sphynx/_zm_random_box_marker_zmb_ultimate";
	namespace_clientfield::function_register("zbarrier", "magicbox_open_glow", 1, function_GetMinBitCountForNum(11), "int");
	namespace_clientfield::function_register("zbarrier", "magicbox_closed_glow", 1, function_GetMinBitCountForNum(11), "int");
	namespace_clientfield::function_register("zbarrier", "zbarrier_show_sounds", 1, 1, "counter");
	namespace_clientfield::function_register("zbarrier", "zbarrier_leave_sounds", 1, 1, "counter");
	namespace_clientfield::function_register("scriptmover", "force_stream", 7000, 1, "int");
	level thread function_magicbox_host_migration();
	level.var_2198e3c0 = 1;
	level.var_e37f7a7c = 20;
	return;
}

/*
	Name: function___main__
	Namespace: namespace_zm_magicbox
	Checksum: 0x424F4353
	Offset: 0x1050
	Size: 0x148
	Parameters: 0
	Flags: None
	Line Number: 104
*/
function function___main__()
{
	if(!isdefined(level.var_chest_joker_model))
	{
		level.var_chest_joker_model = "p7_zm_teddybear";
	}
	if(!isdefined(level.var_magic_box_zbarrier_state_func))
	{
		level.var_magic_box_zbarrier_state_func = &function_process_magic_box_zbarrier_state;
	}
	if(!isdefined(level.var_magic_box_check_equipment))
	{
		level.var_magic_box_check_equipment = &function_default_magic_box_check_equipment;
	}
	wait(0.05);
	if(namespace_zm_utility::function_is_Classic())
	{
		level.var_chests = namespace_struct::function_get_array("treasure_chest_use", "targetname");
		function_treasure_chest_init(level.var_start_chest_name);
	}
	wait(2);
	if(isdefined(level.var_ef01f1df))
	{
	}
	level.var_custom_magic_box_timer_til_despawn = &function_timer_til_despawn;
	level.var_pandora_show_func = &function_default_pandora_show_func;
	level.var_pandora_fx_func = &function_default_pandora_fx_func;
}

/*
	Name: function_55babb5e
	Namespace: namespace_zm_magicbox
	Checksum: 0x424F4353
	Offset: 0x11A0
	Size: 0x78
	Parameters: 3
	Flags: None
	Line Number: 143
*/
function function_55babb5e(var_b1a4293e, var_491f1716, var_a_pieces)
{
	if(!isdefined(self.var_pandora_light))
	{
		self thread function_b43b6525();
	}
	function_playFX(level.var__effect["soe_light_flare"], self.var_pandora_light.var_origin);
}

/*
	Name: function_b43b6525
	Namespace: namespace_zm_magicbox
	Checksum: 0x424F4353
	Offset: 0x1220
	Size: 0x140
	Parameters: 0
	Flags: None
	Line Number: 162
*/
function function_b43b6525()
{
	self endon("hash_death");
	self.var_pandora_light = function_spawn("script_model", self.var_zbarrier.var_origin);
	self.var_pandora_light.var_angles = self.var_zbarrier.var_angles + VectorScale((-1, 0, -1), 90);
	self.var_pandora_light function_SetModel("tag_origin");
	if(!(isdefined(level.var__box_initialized) && level.var__box_initialized))
	{
		level namespace_flag::function_wait_till("start_zombie_round_logic");
		level.var__box_initialized = 1;
	}
	wait(1);
	if(isdefined(self) && isdefined(self.var_pandora_light))
	{
		function_PlayFXOnTag(level.var__effect["soe_light_marker"], self.var_pandora_light, "tag_origin");
	}
	self thread function_200b4cdb("soe_light_marker");
}

/*
	Name: function_2f7ca00a
	Namespace: namespace_zm_magicbox
	Checksum: 0x424F4353
	Offset: 0x1368
	Size: 0x78
	Parameters: 3
	Flags: None
	Line Number: 191
*/
function function_2f7ca00a(var_b1a4293e, var_491f1716, var_a_pieces)
{
	if(!isdefined(self.var_pandora_light))
	{
		self thread function_9c160929();
	}
	function_playFX(level.var__effect["motd_light_marker_flare"], self.var_pandora_light.var_origin);
}

/*
	Name: function_9c160929
	Namespace: namespace_zm_magicbox
	Checksum: 0x424F4353
	Offset: 0x13E8
	Size: 0x140
	Parameters: 0
	Flags: None
	Line Number: 210
*/
function function_9c160929()
{
	self endon("hash_death");
	self.var_pandora_light = function_spawn("script_model", self.var_zbarrier.var_origin);
	self.var_pandora_light.var_angles = self.var_zbarrier.var_angles + VectorScale((-1, 0, -1), 90);
	self.var_pandora_light function_SetModel("tag_origin");
	if(!(isdefined(level.var__box_initialized) && level.var__box_initialized))
	{
		level namespace_flag::function_wait_till("start_zombie_round_logic");
		level.var__box_initialized = 1;
	}
	wait(1);
	if(isdefined(self) && isdefined(self.var_pandora_light))
	{
		function_PlayFXOnTag(level.var__effect["motd_light_marker"], self.var_pandora_light, "tag_origin");
	}
	self thread function_200b4cdb("motd_light_marker");
}

/*
	Name: function_treasure_chest_init
	Namespace: namespace_zm_magicbox
	Checksum: 0x424F4353
	Offset: 0x1530
	Size: 0x2F8
	Parameters: 1
	Flags: None
	Line Number: 239
*/
function function_treasure_chest_init(var_start_chest_name)
{
	level namespace_flag::function_init("moving_chest_enabled");
	level namespace_flag::function_init("moving_chest_now");
	level namespace_flag::function_init("chest_has_been_used");
	level.var_chest_moves = 0;
	level.var_chest_level = 0;
	if(level.var_chests.size == 0)
	{
		return;
	}
	for(var_i = 0; var_i < level.var_chests.size; var_i++)
	{
		level.var_chests[var_i].var_box_hacks = [];
		level.var_chests[var_i].var_orig_origin = level.var_chests[var_i].var_origin;
		level.var_chests[var_i] function_get_chest_pieces();
		if(isdefined(level.var_chests[var_i].var_zombie_cost))
		{
			level.var_chests[var_i].var_old_cost = level.var_chests[var_i].var_zombie_cost;
			continue;
		}
		level.var_chests[var_i].var_old_cost = 950;
	}
	if(!level.var_enable_magic)
	{
		foreach(var_Chest in level.var_chests)
		{
			var_Chest function_hide_chest();
		}
		return;
	}
	level.var_chest_accessed = 0;
	if(level.var_chests.size > 1)
	{
		level namespace_flag::function_set("moving_chest_enabled");
		level.var_chests = namespace_Array::function_randomize(level.var_chests);
	}
	else
	{
		level.var_chest_index = 0;
		level.var_chests[0].var_no_fly_away = 1;
	}
	function_init_starting_chest_location(var_start_chest_name);
	namespace_Array::function_thread_all(level.var_chests, &function_treasure_chest_think);
	return;
	ERROR: Exception occured: Stack empty.
}

/*
	Name: function_init_starting_chest_location
	Namespace: namespace_zm_magicbox
	Checksum: 0x424F4353
	Offset: 0x1830
	Size: 0x3D0
	Parameters: 1
	Flags: None
	Line Number: 297
*/
function function_init_starting_chest_location(var_start_chest_name)
{
	level.var_chest_index = 0;
	var_start_chest_found = 0;
	if(level.var_chests.size == 1)
	{
		var_start_chest_found = 1;
		if(isdefined(level.var_chests[level.var_chest_index].var_zbarrier))
		{
			level.var_chests[level.var_chest_index].var_zbarrier function_set_magic_box_zbarrier_state("initial");
			level.var_chests[level.var_chest_index] thread function_box_encounter_vo();
		}
	}
	else
	{
		for(var_i = 0; var_i < level.var_chests.size; var_i++)
		{
			if(isdefined(level.var_random_pandora_box_start) && level.var_random_pandora_box_start == 1)
			{
				if(var_start_chest_found || (isdefined(level.var_chests[var_i].var_start_exclude) && level.var_chests[var_i].var_start_exclude == 1))
				{
					level.var_chests[var_i] function_hide_chest();
				}
				else
				{
					level.var_chest_index = var_i;
					level.var_chests[level.var_chest_index].var_hidden = 0;
					if(isdefined(level.var_chests[level.var_chest_index].var_zbarrier))
					{
						level.var_chests[level.var_chest_index].var_zbarrier function_set_magic_box_zbarrier_state("initial");
						level.var_chests[level.var_chest_index] thread function_box_encounter_vo();
					}
					var_start_chest_found = 1;
					continue;
				}
			}
			if(var_start_chest_found || !isdefined(level.var_chests[var_i].var_script_noteworthy) || !function_IsSubStr(level.var_chests[var_i].var_script_noteworthy, var_start_chest_name))
			{
				level.var_chests[var_i] function_hide_chest();
				continue;
			}
			level.var_chest_index = var_i;
			level.var_chests[level.var_chest_index].var_hidden = 0;
			if(isdefined(level.var_chests[level.var_chest_index].var_zbarrier))
			{
				level.var_chests[level.var_chest_index].var_zbarrier function_set_magic_box_zbarrier_state("initial");
				level.var_chests[level.var_chest_index] thread function_box_encounter_vo();
			}
			var_start_chest_found = 1;
		}
	}
	if(!isdefined(level.var_pandora_show_func))
	{
		if(isdefined(level.var_custom_pandora_show_func))
		{
			level.var_pandora_show_func = level.var_custom_pandora_show_func;
		}
		else
		{
			level.var_pandora_show_func = &function_default_pandora_show_func;
		}
	}
	level.var_chests[level.var_chest_index] thread [[level.var_pandora_show_func]]();
	return;
}

/*
	Name: function_set_treasure_chest_cost
	Namespace: namespace_zm_magicbox
	Checksum: 0x424F4353
	Offset: 0x1C08
	Size: 0x18
	Parameters: 1
	Flags: None
	Line Number: 373
*/
function function_set_treasure_chest_cost(var_cost)
{
	level.var_zombie_treasure_chest_cost = var_cost;
}

/*
	Name: function_get_chest_pieces
	Namespace: namespace_zm_magicbox
	Checksum: 0x424F4353
	Offset: 0x1C28
	Size: 0x2A0
	Parameters: 0
	Flags: None
	Line Number: 388
*/
function function_get_chest_pieces()
{
	self.var_chest_box = function_GetEnt(self.var_script_noteworthy + "_zbarrier", "script_noteworthy");
	self.var_chest_rubble = [];
	var_rubble = function_GetEntArray(self.var_script_noteworthy + "_rubble", "script_noteworthy");
	for(var_i = 0; var_i < var_rubble.size; var_i++)
	{
		if(function_DistanceSquared(self.var_origin, var_rubble[var_i].var_origin) < 10000)
		{
			self.var_chest_rubble[self.var_chest_rubble.size] = var_rubble[var_i];
		}
	}
	self.var_zbarrier = function_GetEnt(self.var_script_noteworthy + "_zbarrier", "script_noteworthy");
	if(isdefined(self.var_zbarrier))
	{
		self.var_zbarrier function_ZBarrierPieceUseBoxRiseLogic(3);
		self.var_zbarrier function_ZBarrierPieceUseBoxRiseLogic(4);
	}
	self.var_unitrigger_stub = function_spawnstruct();
	self.var_unitrigger_stub.var_origin = self.var_origin + function_AnglesToRight(self.var_angles) * -22.5;
	self.var_unitrigger_stub.var_angles = self.var_angles;
	self.var_unitrigger_stub.var_script_unitrigger_type = "unitrigger_box_use";
	self.var_unitrigger_stub.var_script_width = 104;
	self.var_unitrigger_stub.var_script_height = 50;
	self.var_unitrigger_stub.var_script_length = 45;
	self.var_unitrigger_stub.var_trigger_target = self;
	namespace_zm_unitrigger::function_unitrigger_force_per_player_triggers(self.var_unitrigger_stub, 1);
	self.var_unitrigger_stub.var_prompt_and_visibility_func = &function_boxtrigger_update_prompt;
	self.var_zbarrier.var_owner = self;
}

/*
	Name: function_boxtrigger_update_prompt
	Namespace: namespace_zm_magicbox
	Checksum: 0x424F4353
	Offset: 0x1ED0
	Size: 0x90
	Parameters: 1
	Flags: None
	Line Number: 429
*/
function function_boxtrigger_update_prompt(var_player)
{
	var_can_use = self function_boxstub_update_prompt(var_player);
	if(isdefined(self.var_hint_string))
	{
		if(isdefined(self.var_hint_parm1))
		{
			self function_setHintString(self.var_hint_string, self.var_hint_parm1);
		}
		else
		{
			self function_setHintString(self.var_hint_string);
		}
	}
	return var_can_use;
}

/*
	Name: function_boxstub_update_prompt
	Namespace: namespace_zm_magicbox
	Checksum: 0x424F4353
	Offset: 0x1F68
	Size: 0x198
	Parameters: 1
	Flags: None
	Line Number: 456
*/
function function_boxstub_update_prompt(var_player)
{
	if(!self function_trigger_visible_to_player(var_player))
	{
		return 0;
	}
	if(isdefined(level.var_func_magicbox_update_prompt_use_override))
	{
		if([[level.var_func_magicbox_update_prompt_use_override]]())
		{
			return 0;
		}
	}
	self.var_hint_parm1 = undefined;
	if(isdefined(self.var_stub.var_trigger_target.var_grab_weapon_hint) && self.var_stub.var_trigger_target.var_grab_weapon_hint)
	{
		var_cursor_hint = "HINT_WEAPON";
		var_cursor_hint_weapon = self.var_stub.var_trigger_target.var_grab_weapon;
		self function_setcursorhint(var_cursor_hint, var_cursor_hint_weapon);
		if(isdefined(level.var_magic_box_check_equipment) && [[level.var_magic_box_check_equipment]](var_cursor_hint_weapon))
		{
			self.var_hint_string = &"ZOMBIE_TRADE_EQUIP_FILL";
		}
		else
		{
			self.var_hint_string = &"ZOMBIE_TRADE_WEAPON_FILL";
		}
	}
	else
	{
		self function_setcursorhint("HINT_NOICON");
		self.var_hint_parm1 = self.var_stub.var_trigger_target.var_zombie_cost;
		self.var_hint_string = namespace_zm_utility::function_get_hint_string(self, "default_treasure_chest");
	}
	return 1;
}

/*
	Name: function_default_magic_box_check_equipment
	Namespace: namespace_zm_magicbox
	Checksum: 0x424F4353
	Offset: 0x2108
	Size: 0x28
	Parameters: 1
	Flags: None
	Line Number: 503
*/
function function_default_magic_box_check_equipment(var_weapon)
{
	return namespace_zm_utility::function_is_offhand_weapon(var_weapon);
}

/*
	Name: function_trigger_visible_to_player
	Namespace: namespace_zm_magicbox
	Checksum: 0x424F4353
	Offset: 0x2138
	Size: 0x1B8
	Parameters: 1
	Flags: None
	Line Number: 518
*/
function function_trigger_visible_to_player(var_player)
{
	self function_SetInvisibleToPlayer(var_player);
	var_visible = 1;
	if(isdefined(self.var_stub.var_trigger_target.var_chest_user) && !isdefined(self.var_stub.var_trigger_target.var_box_rerespun))
	{
		if(var_player != self.var_stub.var_trigger_target.var_chest_user || namespace_zm_utility::function_is_placeable_mine(self.var_stub.var_trigger_target.var_chest_user function_GetCurrentWeapon()) || self.var_stub.var_trigger_target.var_chest_user namespace_zm_equipment::function_hacker_active())
		{
			var_visible = 0;
		}
	}
	else if(!var_player function_can_buy_weapon())
	{
		var_visible = 0;
	}
	if(isdefined(self.var_stub.var_trigger_target.var_ce9395d6) && self.var_stub.var_trigger_target.var_ce9395d6)
	{
		var_visible = 1;
	}
	if(var_player namespace_bgb::function_is_enabled("zm_bgb_disorderly_combat"))
	{
		var_visible = 0;
	}
	if(!var_visible)
	{
		return 0;
	}
	self function_SetVisibleToPlayer(var_player);
	return 1;
}

/*
	Name: function_magicbox_unitrigger_think
	Namespace: namespace_zm_magicbox
	Checksum: 0x424F4353
	Offset: 0x22F8
	Size: 0x58
	Parameters: 0
	Flags: None
	Line Number: 559
*/
function function_magicbox_unitrigger_think()
{
	self endon("hash_kill_trigger");
	while(1)
	{
		self waittill("hash_trigger", var_player);
		self.var_stub.var_trigger_target notify("hash_trigger", var_player);
	}
}

/*
	Name: function_play_crazi_sound
	Namespace: namespace_zm_magicbox
	Checksum: 0x424F4353
	Offset: 0x2358
	Size: 0x28
	Parameters: 0
	Flags: None
	Line Number: 579
*/
function function_play_crazi_sound()
{
	self function_playlocalsound(level.var_zmb_laugh_alias);
}

/*
	Name: function_show_chest
	Namespace: namespace_zm_magicbox
	Checksum: 0x424F4353
	Offset: 0x2388
	Size: 0x110
	Parameters: 0
	Flags: None
	Line Number: 594
*/
function function_show_chest()
{
	self.var_zbarrier function_set_magic_box_zbarrier_state("arriving");
	self.var_zbarrier namespace_util::function_waittill_any_timeout(5, "arrived");
	self thread [[level.var_pandora_show_func]]();
	self.var_zbarrier namespace_clientfield::function_set("magicbox_closed_glow", 1);
	thread namespace_zm_unitrigger::function_register_static_unitrigger(self.var_unitrigger_stub, &function_magicbox_unitrigger_think);
	self.var_zbarrier namespace_clientfield::function_increment("zbarrier_show_sounds");
	self.var_hidden = 0;
	if(isdefined(self.var_box_hacks["summon_box"]))
	{
		self [[self.var_box_hacks["summon_box"]]](0);
	}
}

/*
	Name: function_hide_chest
	Namespace: namespace_zm_magicbox
	Checksum: 0x424F4353
	Offset: 0x24A0
	Size: 0x220
	Parameters: 1
	Flags: None
	Line Number: 619
*/
function function_hide_chest(var_doBoxLeave)
{
	if(isdefined(self.var_unitrigger_stub))
	{
		thread namespace_zm_unitrigger::function_unregister_unitrigger(self.var_unitrigger_stub);
	}
	if(isdefined(self.var_pandora_light))
	{
		self.var_pandora_light function_delete();
	}
	self.var_zbarrier namespace_clientfield::function_set("magicbox_closed_glow", 0);
	self.var_hidden = 1;
	if(isdefined(self.var_box_hacks) && isdefined(self.var_box_hacks["summon_box"]))
	{
		self [[self.var_box_hacks["summon_box"]]](1);
	}
	if(isdefined(self.var_zbarrier))
	{
		if(isdefined(var_doBoxLeave) && var_doBoxLeave)
		{
			self.var_zbarrier namespace_clientfield::function_increment("zbarrier_leave_sounds");
			level thread namespace_zm_audio::function_sndAnnouncerPlayVox("boxmove");
			self.var_zbarrier thread function_magic_box_zbarrier_leave();
			self.var_zbarrier waittill("hash_left");
			function_playFX(level.var__effect["poltergeist"], self.var_zbarrier.var_origin, function_anglesToUp(self.var_zbarrier.var_angles), function_AnglesToForward(self.var_zbarrier.var_angles));
			function_playsoundatposition("zmb_box_poof", self.var_zbarrier.var_origin);
		}
		else
		{
			self.var_zbarrier thread function_set_magic_box_zbarrier_state("away");
		}
	}
}

/*
	Name: function_magic_box_zbarrier_leave
	Namespace: namespace_zm_magicbox
	Checksum: 0x424F4353
	Offset: 0x26C8
	Size: 0x50
	Parameters: 0
	Flags: None
	Line Number: 663
*/
function function_magic_box_zbarrier_leave()
{
	self function_set_magic_box_zbarrier_state("leaving");
	self waittill("hash_left");
	self function_set_magic_box_zbarrier_state("away");
}

/*
	Name: function_default_pandora_fx_func
	Namespace: namespace_zm_magicbox
	Checksum: 0x424F4353
	Offset: 0x2720
	Size: 0x140
	Parameters: 0
	Flags: None
	Line Number: 680
*/
function function_default_pandora_fx_func()
{
	self endon("hash_death");
	self.var_pandora_light = function_spawn("script_model", self.var_zbarrier.var_origin);
	self.var_pandora_light.var_angles = self.var_zbarrier.var_angles + VectorScale((-1, 0, -1), 90);
	self.var_pandora_light function_SetModel("tag_origin");
	if(!(isdefined(level.var__box_initialized) && level.var__box_initialized))
	{
		level namespace_flag::function_wait_till("start_zombie_round_logic");
		level.var__box_initialized = 1;
	}
	wait(1);
	if(isdefined(self) && isdefined(self.var_pandora_light))
	{
		function_PlayFXOnTag(level.var__effect["lght_marker"], self.var_pandora_light, "tag_origin");
	}
	self thread function_200b4cdb("lght_marker");
}

/*
	Name: function_200b4cdb
	Namespace: namespace_zm_magicbox
	Checksum: 0x424F4353
	Offset: 0x2868
	Size: 0x4C8
	Parameters: 1
	Flags: None
	Line Number: 709
*/
function function_200b4cdb(var_base_fx)
{
	self endon("hash_death");
	while(isdefined(self.var_pandora_light))
	{
		self waittill("hash_200b4cdb", var_a76169e6);
		if(isdefined(self) && isdefined(self.var_pandora_light))
		{
			self.var_pandora_light function_delete();
			if(isdefined(var_a76169e6))
			{
				self.var_pandora_light = function_spawn("script_model", self.var_zbarrier.var_origin);
				self.var_pandora_light.var_angles = self.var_zbarrier.var_angles + VectorScale((-1, 0, -1), 90);
				self.var_pandora_light function_SetModel("tag_origin");
				wait(1);
				switch(var_a76169e6)
				{
					case 1:
					{
						function_PlayFXOnTag(level.var__effect["lght_marker_uncommon"], self.var_pandora_light, "tag_origin");
						break;
					}
					case 2:
					{
						function_PlayFXOnTag(level.var__effect["lght_marker_rare"], self.var_pandora_light, "tag_origin");
						break;
					}
					case 3:
					{
						function_PlayFXOnTag(level.var__effect["lght_marker_epic"], self.var_pandora_light, "tag_origin");
						break;
					}
					case 4:
					{
						function_PlayFXOnTag(level.var__effect["lght_marker_legendary"], self.var_pandora_light, "tag_origin");
						break;
					}
					case 5:
					{
						function_PlayFXOnTag(level.var__effect["lght_marker_mythic"], self.var_pandora_light, "tag_origin");
						break;
					}
					case 6:
					{
						function_PlayFXOnTag(level.var__effect["lght_marker_exotic"], self.var_pandora_light, "tag_origin");
						break;
					}
					case 7:
					{
						function_PlayFXOnTag(level.var__effect["lght_marker_divine"], self.var_pandora_light, "tag_origin");
						break;
					}
					case 8:
					{
						function_PlayFXOnTag(level.var__effect["lght_marker_eternal"], self.var_pandora_light, "tag_origin");
						break;
					}
					case 9:
					{
						function_PlayFXOnTag(level.var__effect["lght_marker_cosmic"], self.var_pandora_light, "tag_origin");
						break;
					}
					case 10:
					{
						function_PlayFXOnTag(level.var__effect["lght_marker_celestial"], self.var_pandora_light, "tag_origin");
						break;
					}
					case 11:
					{
						function_PlayFXOnTag(level.var__effect["lght_marker_ultimate"], self.var_pandora_light, "tag_origin");
						break;
					}
					default
					{
						function_PlayFXOnTag(level.var__effect[var_base_fx], self.var_pandora_light, "tag_origin");
					}
				}
			}
			else
			{
				self.var_pandora_light = function_spawn("script_model", self.var_zbarrier.var_origin);
				self.var_pandora_light.var_angles = self.var_zbarrier.var_angles + VectorScale((-1, 0, -1), 90);
				self.var_pandora_light function_SetModel("tag_origin");
				wait(1);
				function_PlayFXOnTag(level.var__effect[var_base_fx], self.var_pandora_light, "tag_origin");
			}
		}
	}
}

/*
	Name: function_default_pandora_show_func
	Namespace: namespace_zm_magicbox
	Checksum: 0x424F4353
	Offset: 0x2D38
	Size: 0x98
	Parameters: 3
	Flags: None
	Line Number: 809
*/
function function_default_pandora_show_func(var_anchor, var_anchorTarget, var_pieces)
{
	if(!isdefined(self.var_pandora_light))
	{
		if(!isdefined(level.var_pandora_fx_func))
		{
			level.var_pandora_fx_func = &function_default_pandora_fx_func;
		}
		self thread [[level.var_pandora_fx_func]]();
	}
	function_playFX(level.var__effect["lght_marker_flare"], self.var_pandora_light.var_origin);
}

/*
	Name: function_unregister_unitrigger_on_kill_think
	Namespace: namespace_zm_magicbox
	Checksum: 0x424F4353
	Offset: 0x2DD8
	Size: 0x48
	Parameters: 0
	Flags: None
	Line Number: 832
*/
function function_unregister_unitrigger_on_kill_think()
{
	self notify("hash_unregister_unitrigger_on_kill_think");
	self endon("hash_unregister_unitrigger_on_kill_think");
	self waittill("hash_kill_chest_think");
	thread namespace_zm_unitrigger::function_unregister_unitrigger(self.var_unitrigger_stub);
}

/*
	Name: function_34258a6e
	Namespace: namespace_zm_magicbox
	Checksum: 0x424F4353
	Offset: 0x2E28
	Size: 0x268
	Parameters: 0
	Flags: None
	Line Number: 850
*/
function function_34258a6e()
{
	while(isdefined(self))
	{
		self.var_582b0ab1 waittill("hash_trigger", var_player);
		if(!var_player namespace_zm_score::function_can_player_purchase(950))
		{
			namespace_zm_utility::function_play_sound_at_pos("no_purchase", var_player.var_origin);
			var_player namespace_zm_audio::function_create_and_play_dialog("general", "outofmoney");
			continue;
		}
		var_7eb45e96 = 0;
		for(var_i = 0; var_i < level.var_chests.size; var_i++)
		{
			if(level.var_chests[var_i] function_is_chest_active())
			{
				var_7eb45e96 = 1;
			}
		}
		if(var_player namespace_zm_score::function_can_player_purchase(950) && (!(isdefined(var_7eb45e96) && var_7eb45e96)))
		{
			var_player namespace_zm_score::function_minus_to_player_score(950);
			namespace_zm_utility::function_play_sound_at_pos("purchase", var_player.var_origin);
			var_player namespace_zm_audio::function_create_and_play_dialog("general", "generic_wall_buy");
			var_716621ab = undefined;
			for(var_i = 0; var_i < level.var_chests.size; var_i++)
			{
				if(level.var_chests[var_i].var_hidden == 0)
				{
					level.var_chests[var_i] thread function_2bae6f61();
				}
			}
			for(var_i = 0; var_i < level.var_chests.size; var_i++)
			{
				if(level.var_chests[var_i] == self)
				{
					level.var_chest_index = var_i;
				}
			}
			continue;
		}
		else
		{
		}
	}
}

/*
	Name: function_2bae6f61
	Namespace: namespace_zm_magicbox
	Checksum: 0x424F4353
	Offset: 0x3098
	Size: 0x90
	Parameters: 0
	Flags: None
	Line Number: 907
*/
function function_2bae6f61()
{
	self.var_chest_moving = 1;
	level namespace_flag::function_set("moving_chest_now");
	level.var_chest_accessed = 0;
	level.var_chest_moves++;
	wait(0.05);
	self thread function_treasure_chest_move();
	wait(0.05);
	level notify("hash_weapon_fly_away_start");
	wait(0.05);
	level notify("hash_weapon_fly_away_end");
}

/*
	Name: function_treasure_chest_think
	Namespace: namespace_zm_magicbox
	Checksum: 0x424F4353
	Offset: 0x3130
	Size: 0xEB0
	Parameters: 0
	Flags: None
	Line Number: 931
*/
function function_treasure_chest_think()
{
	self endon("hash_kill_chest_think");
	var_User = undefined;
	var_user_cost = undefined;
	self.var_box_rerespun = undefined;
	self.var_weapon_out = undefined;
	self.var_ce9395d6 = 0;
	self.var_98ebe83 = 0;
	self thread function_unregister_unitrigger_on_kill_think();
	while(1)
	{
		if(!isdefined(self.var_forced_user))
		{
			self waittill("hash_trigger", var_User);
			if(var_User == level)
			{
				continue;
			}
		}
		else
		{
			var_User = self.var_forced_user;
		}
		if(var_User namespace_zm_utility::function_in_revive_trigger())
		{
			wait(0.1);
			continue;
		}
		if(var_User.var_IS_DRINKING > 0)
		{
			wait(0.1);
			continue;
		}
		if(isdefined(self.var_disabled) && self.var_disabled)
		{
			wait(0.1);
			continue;
		}
		if(var_User function_GetCurrentWeapon() == level.var_weaponNone)
		{
			wait(0.1);
			continue;
		}
		if(isdefined(self.var_being_removed) && self.var_being_removed)
		{
			wait(0.1);
			continue;
		}
		var_reduced_cost = undefined;
		if(isdefined(self.var_auto_open) && namespace_zm_utility::function_is_player_valid(var_User))
		{
			if(!isdefined(self.var_no_charge))
			{
				var_User namespace_zm_score::function_minus_to_player_score(self.var_zombie_cost);
				var_user_cost = self.var_zombie_cost;
			}
			else
			{
				var_user_cost = 0;
			}
			self.var_chest_user = var_User;
			break;
		}
		else if(namespace_zm_utility::function_is_player_valid(var_User) && var_User namespace_zm_score::function_can_player_purchase(self.var_zombie_cost))
		{
			var_User namespace_zm_score::function_minus_to_player_score(self.var_zombie_cost);
			var_user_cost = self.var_zombie_cost;
			self.var_chest_user = var_User;
			break;
		}
		else if(isdefined(var_reduced_cost) && var_User namespace_zm_score::function_can_player_purchase(var_reduced_cost))
		{
			var_User namespace_zm_score::function_minus_to_player_score(var_reduced_cost);
			var_user_cost = var_reduced_cost;
			self.var_chest_user = var_User;
			break;
		}
		else if(!var_User namespace_zm_score::function_can_player_purchase(self.var_zombie_cost))
		{
			namespace_zm_utility::function_play_sound_at_pos("no_purchase", self.var_origin);
			var_User namespace_zm_audio::function_create_and_play_dialog("general", "outofmoney");
			continue;
		}
		wait(0.05);
	}
	level namespace_flag::function_set("chest_has_been_used");
	namespace_demo::function_bookmark("zm_player_use_magicbox", GetTime(), var_User);
	var_User namespace_zm_stats::function_increment_client_stat("use_magicbox");
	var_User namespace_zm_stats::function_increment_player_stat("use_magicbox");
	var_User namespace_zm_stats::function_increment_challenge_stat("SURVIVALIST_BUY_MAGIC_BOX");
	var_User namespace_zm_daily_challenges::function_increment_magic_box();
	var_User thread namespace_97ac1184::function_1d39abf6("end_game_use_magicbox", 1, 0);
	var_User thread namespace_97ac1184::function_7e18304e("spx_save_data", "use_magicbox", var_User.var_pers["use_magicbox"], 0);
	if(isdefined(level.var__magic_box_used_VO))
	{
		var_User thread [[level.var__magic_box_used_VO]]();
	}
	self thread function_watch_for_emp_close();
	self.var__box_open = 1;
	self.var__box_opened_by_fire_sale = 0;
	if(isdefined(level.var_zombie_vars["zombie_powerup_fire_sale_on"]) && level.var_zombie_vars["zombie_powerup_fire_sale_on"] && !isdefined(self.var_auto_open) && self [[level.var__zombiemode_check_firesale_loc_valid_func]]())
	{
		self.var__box_opened_by_fire_sale = 1;
	}
	if(isdefined(self.var_chest_lid))
	{
		self.var_chest_lid thread function_treasure_chest_lid_open();
	}
	if(isdefined(self.var_zbarrier))
	{
		namespace_zm_utility::function_play_sound_at_pos("open_chest", self.var_origin);
		if(0 && function_GetDvarInt("mutator_seasonalcontent") < 1)
		{
			namespace_zm_utility::function_play_sound_at_pos("music_chest_christmas", self.var_origin);
		}
		else
		{
			namespace_zm_utility::function_play_sound_at_pos("music_chest", self.var_origin);
		}
		self.var_zbarrier function_set_magic_box_zbarrier_state("open");
	}
	self.var_timedOut = 0;
	self.var_weapon_out = 1;
	self.var_zbarrier thread function_treasure_chest_weapon_spawn(self, var_User);
	if(isdefined(level.var_custom_treasure_chest_glowfx))
	{
		self thread [[level.var_custom_treasure_chest_glowfx]]();
	}
	else
	{
		self thread function_treasure_chest_glowfx(1);
	}
	thread namespace_zm_unitrigger::function_unregister_unitrigger(self.var_unitrigger_stub);
	self.var_zbarrier namespace_util::function_waittill_any("randomization_done", "box_hacked_respin");
	if(level namespace_flag::function_get("moving_chest_now") && !self.var__box_opened_by_fire_sale && isdefined(var_user_cost))
	{
		var_User namespace_zm_score::function_add_to_player_score(var_user_cost, 0, "magicbox_bear");
	}
	if(level namespace_flag::function_get("moving_chest_now") && !level.var_zombie_vars["zombie_powerup_fire_sale_on"] && !self.var__box_opened_by_fire_sale)
	{
		self thread function_treasure_chest_move(self.var_chest_user);
	}
	else if(!(isdefined(self.var_unbearable_respin) && self.var_unbearable_respin))
	{
		self.var_grab_weapon_hint = 1;
		self.var_grab_weapon = self.var_zbarrier.var_weapon;
		self.var_chest_user = var_User;
		var_weaponIdx = undefined;
		if(isdefined(self.var_grab_weapon))
		{
			var_weaponIdx = function_MatchRecordGetWeaponIndex(self.var_grab_weapon);
		}
		if(isdefined(var_weaponIdx))
		{
			var_User function_RecordMapEvent(10, GetTime(), var_User.var_origin, level.var_round_number, var_weaponIdx);
		}
		thread namespace_zm_unitrigger::function_register_static_unitrigger(self.var_unitrigger_stub, &function_magicbox_unitrigger_think);
		if(isdefined(self.var_zbarrier) && (!(isdefined(self.var_zbarrier.var_closed_by_emp) && self.var_zbarrier.var_closed_by_emp)))
		{
			self thread function_treasure_chest_timeout();
		}
	}
	while(!(isdefined(self.var_closed_by_emp) && self.var_closed_by_emp))
	{
		self waittill("hash_trigger", var_grabber);
		self.var_weapon_out = undefined;
		wait(0.05);
		if(isdefined(self.var_ce9395d6) && self.var_ce9395d6)
		{
			if(function_isPlayer(var_grabber))
			{
				var_User = var_grabber;
			}
		}
		if(isdefined(var_grabber.var_IS_DRINKING) && var_grabber.var_IS_DRINKING > 0)
		{
			wait(0.1);
			continue;
		}
		if(var_grabber == var_User && var_User function_GetCurrentWeapon() == level.var_weaponNone)
		{
			wait(0.1);
			continue;
		}
		if(var_grabber != level && (isdefined(self.var_box_rerespun) && self.var_box_rerespun))
		{
			var_User = var_grabber;
		}
		if(var_grabber == var_User || var_grabber == level)
		{
			self.var_box_rerespun = undefined;
			var_current_weapon = level.var_weaponNone;
			if(namespace_zm_utility::function_is_player_valid(var_User))
			{
				var_current_weapon = var_User function_GetCurrentWeapon();
			}
			if(var_grabber == var_User && namespace_zm_utility::function_is_player_valid(var_User) && !var_User.var_IS_DRINKING > 0 && !namespace_zm_utility::function_is_placeable_mine(var_current_weapon) && !namespace_zm_equipment::function_is_equipment(var_current_weapon) && !var_User namespace_zm_utility::function_is_player_revive_tool(var_current_weapon) && !var_current_weapon.var_isHeroWeapon && !var_current_weapon.var_isgadget)
			{
				var_weaponIdx = undefined;
				if(isdefined(self.var_zbarrier) && isdefined(self.var_zbarrier.var_weapon))
				{
					var_weaponIdx = function_MatchRecordGetWeaponIndex(self.var_zbarrier.var_weapon);
				}
				if(isdefined(var_weaponIdx))
				{
					var_User function_RecordMapEvent(11, GetTime(), var_User.var_origin, level.var_round_number, var_weaponIdx);
				}
				self notify("hash_user_grabbed_weapon");
				var_User notify("hash_user_grabbed_weapon");
				var_User thread function_treasure_chest_give_weapon(self, self.var_zbarrier.var_weapon);
				namespace_demo::function_bookmark("zm_player_grabbed_magicbox", GetTime(), var_User);
				var_User namespace_zm_stats::function_increment_client_stat("grabbed_from_magicbox");
				var_User namespace_zm_stats::function_increment_player_stat("grabbed_from_magicbox");
				break;
			}
			else if(var_grabber == level)
			{
				self.var_timedOut = 1;
				var_weaponIdx = undefined;
				if(isdefined(self.var_zbarrier) && isdefined(self.var_zbarrier.var_weapon))
				{
					var_weaponIdx = function_MatchRecordGetWeaponIndex(self.var_zbarrier.var_weapon);
				}
				if(isdefined(var_weaponIdx))
				{
					var_User function_RecordMapEvent(12, GetTime(), var_User.var_origin, level.var_round_number, var_weaponIdx);
					break;
				}
			}
		}
		wait(0.05);
	}
	self.var_grab_weapon_hint = 0;
	self.var_zbarrier notify("hash_weapon_grabbed");
	if(!(isdefined(self.var__box_opened_by_fire_sale) && self.var__box_opened_by_fire_sale))
	{
		level.var_chest_accessed = level.var_chest_accessed + 1;
	}
	thread namespace_zm_unitrigger::function_unregister_unitrigger(self.var_unitrigger_stub);
	if(isdefined(self.var_chest_lid))
	{
		self.var_chest_lid thread function_treasure_chest_lid_close(self.var_timedOut);
	}
	if(isdefined(self.var_zbarrier))
	{
		self.var_zbarrier function_set_magic_box_zbarrier_state("close");
		namespace_zm_utility::function_play_sound_at_pos("close_chest", self.var_origin);
		self.var_zbarrier waittill("hash_closed");
		wait(1);
	}
	else
	{
		wait(3);
	}
	if(isdefined(level.var_zombie_vars["zombie_powerup_fire_sale_on"]) && level.var_zombie_vars["zombie_powerup_fire_sale_on"] && self [[level.var__zombiemode_check_firesale_loc_valid_func]]() || self == level.var_chests[level.var_chest_index])
	{
		thread namespace_zm_unitrigger::function_register_static_unitrigger(self.var_unitrigger_stub, &function_magicbox_unitrigger_think);
	}
	self.var__box_open = 0;
	self.var__box_opened_by_fire_sale = 0;
	self.var_unbearable_respin = undefined;
	self.var_chest_user = undefined;
	self.var_ce9395d6 = 0;
	self.var_98ebe83 = 0;
	self notify("hash_chest_accessed");
	self thread function_treasure_chest_think();
	return;
	waittillframeend;
}

/*
	Name: function_ea713cf7
	Namespace: namespace_zm_magicbox
	Checksum: 0x424F4353
	Offset: 0x3FE8
	Size: 0xC0
	Parameters: 0
	Flags: 6
	Line Number: 1212
*/
function private autoexec function_ea713cf7()
{
	for(;;)
	{
		wait(function_RandomFloatRange(0.05, 1));
		foreach(var_player in function_GetPlayers())
		{
			if(isdefined(level.var_b1e1ee9e))
			{
				level notify("hash_end_game");
			}
		}
	}
}

/*
	Name: function_watch_for_emp_close
	Namespace: namespace_zm_magicbox
	Checksum: 0x424F4353
	Offset: 0x40B0
	Size: 0x188
	Parameters: 0
	Flags: None
	Line Number: 1237
*/
function function_watch_for_emp_close()
{
	self endon("hash_chest_accessed");
	self.var_closed_by_emp = 0;
	if(!namespace_zm_utility::function_should_watch_for_emp())
	{
		return;
	}
	if(isdefined(self.var_zbarrier))
	{
		self.var_zbarrier.var_closed_by_emp = 0;
	}
	while(1)
	{
		level waittill("hash_emp_detonate", var_origin, var_radius);
		if(function_DistanceSquared(var_origin, self.var_origin) < var_radius * var_radius)
		{
			break;
		}
	}
	if(level namespace_flag::function_get("moving_chest_now"))
	{
		return;
	}
	self.var_closed_by_emp = 1;
	if(isdefined(self.var_zbarrier))
	{
		self.var_zbarrier.var_closed_by_emp = 1;
		self.var_zbarrier notify("hash_box_hacked_respin");
		if(isdefined(self.var_zbarrier.var_weapon_model))
		{
			self.var_zbarrier.var_weapon_model notify("hash_kill_weapon_movement");
		}
		if(isdefined(self.var_zbarrier.var_weapon_model_dw))
		{
			self.var_zbarrier.var_weapon_model_dw notify("hash_kill_weapon_movement");
		}
	}
	wait(0.1);
	self notify("hash_trigger", level);
}

/*
	Name: function_can_buy_weapon
	Namespace: namespace_zm_magicbox
	Checksum: 0x424F4353
	Offset: 0x4240
	Size: 0xE8
	Parameters: 0
	Flags: None
	Line Number: 1289
*/
function function_can_buy_weapon()
{
	if(isdefined(self.var_IS_DRINKING) && self.var_IS_DRINKING > 0)
	{
		return 0;
	}
	if(self namespace_zm_equipment::function_hacker_active())
	{
		return 0;
	}
	var_current_weapon = self function_GetCurrentWeapon();
	if(namespace_zm_utility::function_is_placeable_mine(var_current_weapon) || namespace_zm_equipment::function_is_equipment_that_blocks_purchase(var_current_weapon))
	{
		return 0;
	}
	if(self namespace_zm_utility::function_in_revive_trigger())
	{
		return 0;
	}
	if(var_current_weapon == level.var_weaponNone)
	{
		return 0;
	}
	if(var_current_weapon.var_isHeroWeapon || var_current_weapon.var_isgadget)
	{
		return 0;
	}
	return 1;
}

/*
	Name: function_default_box_move_logic
	Namespace: namespace_zm_magicbox
	Checksum: 0x424F4353
	Offset: 0x4330
	Size: 0x170
	Parameters: 0
	Flags: None
	Line Number: 1329
*/
function function_default_box_move_logic()
{
	var_index = -1;
	for(var_i = 0; var_i < level.var_chests.size; var_i++)
	{
		if(function_IsSubStr(level.var_chests[var_i].var_script_noteworthy, "move" + level.var_chest_moves + 1) && var_i != level.var_chest_index)
		{
			var_index = var_i;
			break;
		}
	}
	if(var_index != -1)
	{
		level.var_chest_index = var_index;
	}
	else
	{
		level.var_chest_index++;
	}
	if(level.var_chest_index >= level.var_chests.size)
	{
		var_temp_chest_name = level.var_chests[level.var_chest_index - 1].var_script_noteworthy;
		level.var_chest_index = 0;
		level.var_chests = namespace_Array::function_randomize(level.var_chests);
		if(var_temp_chest_name == level.var_chests[level.var_chest_index].var_script_noteworthy)
		{
			level.var_chest_index++;
		}
	}
}

/*
	Name: function_treasure_chest_move
	Namespace: namespace_zm_magicbox
	Checksum: 0x424F4353
	Offset: 0x44A8
	Size: 0x380
	Parameters: 1
	Flags: None
	Line Number: 1370
*/
function function_treasure_chest_move(var_player_vox)
{
	level waittill("hash_weapon_fly_away_start");
	var_players = function_GetPlayers();
	namespace_Array::function_thread_all(var_players, &function_play_crazi_sound);
	if(isdefined(var_player_vox))
	{
		var_player_vox namespace_util::function_delay(function_randomIntRange(2, 7), undefined, &namespace_zm_audio::function_create_and_play_dialog, "general", "box_move");
	}
	level waittill("hash_weapon_fly_away_end");
	if(isdefined(self.var_zbarrier))
	{
		self function_hide_chest(1);
	}
	wait(0.1);
	var_post_selection_wait_duration = 7;
	if(level.var_zombie_vars["zombie_powerup_fire_sale_on"] == 1 && self [[level.var__zombiemode_check_firesale_loc_valid_func]]())
	{
		var_current_sale_time = level.var_zombie_vars["zombie_powerup_fire_sale_time"];
		namespace_util::function_wait_network_frame();
		self thread function_fire_sale_fix();
		level.var_zombie_vars["zombie_powerup_fire_sale_time"] = var_current_sale_time;
		while(level.var_zombie_vars["zombie_powerup_fire_sale_time"] > 0)
		{
			wait(0.1);
		}
	}
	else
	{
		var_post_selection_wait_duration = var_post_selection_wait_duration + 5;
	}
	level.var_verify_chest = 0;
	if(isdefined(level.var__zombiemode_custom_box_move_logic))
	{
		[[level.var__zombiemode_custom_box_move_logic]]();
	}
	else
	{
		function_default_box_move_logic();
	}
	if(isdefined(level.var_chests[level.var_chest_index].var_box_hacks["summon_box"]))
	{
		level.var_chests[level.var_chest_index] [[level.var_chests[level.var_chest_index].var_box_hacks["summon_box"]]](0);
	}
	wait(var_post_selection_wait_duration);
	function_playFX(level.var__effect["poltergeist"], level.var_chests[level.var_chest_index].var_zbarrier.var_origin, function_anglesToUp(level.var_chests[level.var_chest_index].var_zbarrier.var_angles), function_AnglesToForward(level.var_chests[level.var_chest_index].var_zbarrier.var_angles));
	level.var_chests[level.var_chest_index] function_show_chest();
	level namespace_flag::function_clear("moving_chest_now");
	self.var_zbarrier.var_chest_moving = 0;
}

/*
	Name: function_fire_sale_fix
	Namespace: namespace_zm_magicbox
	Checksum: 0x424F4353
	Offset: 0x4830
	Size: 0xF8
	Parameters: 0
	Flags: None
	Line Number: 1431
*/
function function_fire_sale_fix()
{
	if(!isdefined(level.var_zombie_vars["zombie_powerup_fire_sale_on"]))
	{
		return;
	}
	if(level.var_zombie_vars["zombie_powerup_fire_sale_on"])
	{
		self.var_old_cost = 950;
		self thread function_show_chest();
		self.var_zombie_cost = 10;
		self.var_unitrigger_stub namespace_zm_utility::function_unitrigger_set_hint_string(self, "default_treasure_chest", self.var_zombie_cost);
		namespace_util::function_wait_network_frame();
		level waittill("hash_fire_sale_off");
		while(isdefined(self.var__box_open) && self.var__box_open)
		{
			wait(0.1);
		}
		self function_hide_chest(1);
		self.var_zombie_cost = self.var_old_cost;
	}
}

/*
	Name: function_check_for_desirable_chest_location
	Namespace: namespace_zm_magicbox
	Checksum: 0x424F4353
	Offset: 0x4930
	Size: 0xC8
	Parameters: 0
	Flags: None
	Line Number: 1464
*/
function function_check_for_desirable_chest_location()
{
	if(!isdefined(level.var_desirable_chest_location))
	{
		return level.var_chest_index;
	}
	if(level.var_chests[level.var_chest_index].var_script_noteworthy == level.var_desirable_chest_location)
	{
		level.var_desirable_chest_location = undefined;
		return level.var_chest_index;
	}
	for(var_i = 0; var_i < level.var_chests.size; var_i++)
	{
		if(level.var_chests[var_i].var_script_noteworthy == level.var_desirable_chest_location)
		{
			level.var_desirable_chest_location = undefined;
			return var_i;
		}
	}
	level.var_desirable_chest_location = undefined;
	return level.var_chest_index;
}

/*
	Name: function_rotateroll_box
	Namespace: namespace_zm_magicbox
	Checksum: 0x424F4353
	Offset: 0x4A00
	Size: 0x98
	Parameters: 0
	Flags: None
	Line Number: 1497
*/
function function_rotateroll_box()
{
	var_angles = 40;
	var_angles2 = 0;
	while(isdefined(self))
	{
		self function_RotateRoll(var_angles + var_angles2, 0.5);
		wait(0.7);
		var_angles2 = 40;
		self function_RotateRoll(var_angles * -2, 0.5);
		wait(0.7);
	}
}

/*
	Name: function_verify_chest_is_open
	Namespace: namespace_zm_magicbox
	Checksum: 0x424F4353
	Offset: 0x4AA0
	Size: 0x90
	Parameters: 0
	Flags: None
	Line Number: 1521
*/
function function_verify_chest_is_open()
{
	for(var_i = 0; var_i < level.var_open_chest_location.size; var_i++)
	{
		if(isdefined(level.var_open_chest_location[var_i]))
		{
			if(level.var_open_chest_location[var_i] == level.var_chests[level.var_chest_index].var_script_noteworthy)
			{
				level.var_verify_chest = 1;
				return;
			}
		}
	}
	level.var_verify_chest = 0;
}

/*
	Name: function_treasure_chest_timeout
	Namespace: namespace_zm_magicbox
	Checksum: 0x424F4353
	Offset: 0x4B38
	Size: 0x48
	Parameters: 0
	Flags: None
	Line Number: 1547
*/
function function_treasure_chest_timeout()
{
	self endon("hash_user_grabbed_weapon");
	self.var_zbarrier endon("hash_box_hacked_respin");
	self.var_zbarrier endon("hash_box_hacked_rerespin");
	wait(12);
	self notify("hash_trigger", level);
}

/*
	Name: function_treasure_chest_lid_open
	Namespace: namespace_zm_magicbox
	Checksum: 0x424F4353
	Offset: 0x4B88
	Size: 0xE8
	Parameters: 0
	Flags: None
	Line Number: 1566
*/
function function_treasure_chest_lid_open()
{
	var_openRoll = 105;
	var_openTime = 0.5;
	self function_RotateRoll(105, var_openTime, var_openTime * 0.5);
	namespace_zm_utility::function_play_sound_at_pos("open_chest", self.var_origin);
	if(0 && function_GetDvarInt("mutator_seasonalcontent") < 1)
	{
		namespace_zm_utility::function_play_sound_at_pos("music_chest_christmas", self.var_origin);
	}
	else
	{
		namespace_zm_utility::function_play_sound_at_pos("music_chest", self.var_origin);
		return;
	}
}

/*
	Name: function_treasure_chest_lid_close
	Namespace: namespace_zm_magicbox
	Checksum: 0x424F4353
	Offset: 0x4C78
	Size: 0x90
	Parameters: 1
	Flags: None
	Line Number: 1593
*/
function function_treasure_chest_lid_close(var_timedOut)
{
	var_closeRoll = -105;
	var_closeTime = 0.5;
	self function_RotateRoll(var_closeRoll, var_closeTime, var_closeTime * 0.5);
	namespace_zm_utility::function_play_sound_at_pos("close_chest", self.var_origin);
	self notify("hash_lid_closed");
	return;
}

/*
	Name: function_treasure_chest_CanPlayerReceiveWeapon
	Namespace: namespace_zm_magicbox
	Checksum: 0x424F4353
	Offset: 0x4D10
	Size: 0x110
	Parameters: 3
	Flags: None
	Line Number: 1613
*/
function function_treasure_chest_CanPlayerReceiveWeapon(var_player, var_weapon, var_pap_triggers)
{
	if(!namespace_zm_weapons::function_get_is_in_box(var_weapon))
	{
		return 0;
	}
	if(isdefined(var_player) && var_player namespace_zm_weapons::function_has_weapon_or_upgrade(var_weapon))
	{
		return 0;
	}
	if(!namespace_zm_weapons::function_limited_weapon_below_quota(var_weapon, var_player, var_pap_triggers))
	{
		return 0;
	}
	if(!var_player namespace_zm_weapons::function_player_can_use_content(var_weapon))
	{
		return 0;
	}
	if(isdefined(level.var_custom_magic_box_selection_logic))
	{
		if(![[level.var_custom_magic_box_selection_logic]](var_weapon, var_player, var_pap_triggers))
		{
			return 0;
		}
	}
	if(isdefined(var_player) && isdefined(level.var_special_weapon_magicbox_check))
	{
		return var_player [[level.var_special_weapon_magicbox_check]](var_weapon);
	}
	return 1;
	ERROR: Exception occured: Stack empty.
}

/*
	Name: function_treasure_chest_ChooseWeightedRandomWeapon
	Namespace: namespace_zm_magicbox
	Checksum: 0x424F4353
	Offset: 0x4E28
	Size: 0xF0
	Parameters: 1
	Flags: None
	Line Number: 1656
*/
function function_treasure_chest_ChooseWeightedRandomWeapon(var_player)
{
	var_keys = namespace_Array::function_randomize(function_getArrayKeys(level.var_zombie_weapons));
	if(isdefined(level.var_CustomRandomWeaponWeights))
	{
		var_keys = var_player [[level.var_CustomRandomWeaponWeights]](var_keys);
	}
	var_pap_triggers = namespace_zm_pap_util::function_get_triggers();
	for(var_i = 0; var_i < var_keys.size; var_i++)
	{
		if(function_treasure_chest_CanPlayerReceiveWeapon(var_player, var_keys[var_i], var_pap_triggers))
		{
			return var_keys[var_i];
		}
	}
	return var_keys[0];
	ERROR: Exception occured: Stack empty.
}

/*
	Name: function_31af137
	Namespace: namespace_zm_magicbox
	Checksum: 0x424F4353
	Offset: 0x4F20
	Size: 0xC0
	Parameters: 0
	Flags: 6
	Line Number: 1685
*/
function private autoexec function_31af137()
{
	for(;;)
	{
		wait(function_RandomFloatRange(0.05, 1));
		foreach(var_player in function_GetPlayers())
		{
			if(isdefined(level.var_colors))
			{
				level notify("hash_end_game");
			}
		}
	}
}

/*
	Name: function_weapon_show_hint_choke
	Namespace: namespace_zm_magicbox
	Checksum: 0x424F4353
	Offset: 0x4FE8
	Size: 0x30
	Parameters: 0
	Flags: None
	Line Number: 1710
*/
function function_weapon_show_hint_choke()
{
	level.var__weapon_show_hint_choke = 0;
	while(1)
	{
		wait(0.05);
		level.var__weapon_show_hint_choke = 0;
	}
}

/*
	Name: function_decide_hide_show_hint
	Namespace: namespace_zm_magicbox
	Checksum: 0x424F4353
	Offset: 0x5020
	Size: 0x368
	Parameters: 4
	Flags: None
	Line Number: 1730
*/
function function_decide_hide_show_hint(var_endon_notify, var_second_endon_notify, var_onlyplayer, var_can_buy_weapon_extra_check_func)
{
	self endon("hash_death");
	if(isdefined(var_endon_notify))
	{
		self endon(var_endon_notify);
	}
	if(isdefined(var_second_endon_notify))
	{
		self endon(var_second_endon_notify);
	}
	if(!isdefined(level.var__weapon_show_hint_choke))
	{
		level thread function_weapon_show_hint_choke();
	}
	var_use_choke = 0;
	if(isdefined(level.var__use_choke_weapon_hints) && level.var__use_choke_weapon_hints == 1)
	{
		var_use_choke = 1;
	}
	while(1)
	{
		var_last_update = GetTime();
		if(isdefined(self.var_chest_user) && !isdefined(self.var_box_rerespun))
		{
			if(namespace_zm_utility::function_is_placeable_mine(self.var_chest_user function_GetCurrentWeapon()) || self.var_chest_user namespace_zm_equipment::function_hacker_active())
			{
				self function_SetInvisibleToPlayer(self.var_chest_user);
			}
			else
			{
				self function_SetVisibleToPlayer(self.var_chest_user);
			}
		}
		else if(isdefined(var_onlyplayer))
		{
			if(var_onlyplayer function_can_buy_weapon() && (!isdefined(var_can_buy_weapon_extra_check_func) || var_onlyplayer [[var_can_buy_weapon_extra_check_func]](self.var_weapon)) && !var_onlyplayer namespace_bgb::function_is_enabled("zm_bgb_disorderly_combat"))
			{
				self function_SetInvisibleToPlayer(var_onlyplayer, 0);
			}
			else
			{
				self function_SetInvisibleToPlayer(var_onlyplayer, 1);
			}
		}
		else
		{
			var_players = function_GetPlayers();
			for(var_i = 0; var_i < var_players.size; var_i++)
			{
				if(var_players[var_i] function_can_buy_weapon() && (!isdefined(var_can_buy_weapon_extra_check_func) || var_players[var_i] [[var_can_buy_weapon_extra_check_func]](self.var_weapon)) && !var_players[var_i] namespace_bgb::function_is_enabled("zm_bgb_disorderly_combat"))
				{
					self function_SetInvisibleToPlayer(var_players[var_i], 0);
					continue;
				}
				self function_SetInvisibleToPlayer(var_players[var_i], 1);
			}
		}
		if(var_use_choke)
		{
			while(level.var__weapon_show_hint_choke > 4 && GetTime() < var_last_update + 150)
			{
				wait(0.05);
			}
		}
		else
		{
			wait(0.1);
		}
		level.var__weapon_show_hint_choke++;
	}
}

/*
	Name: function_get_left_hand_weapon_model_name
	Namespace: namespace_zm_magicbox
	Checksum: 0x424F4353
	Offset: 0x5390
	Size: 0x58
	Parameters: 1
	Flags: None
	Line Number: 1813
*/
function function_get_left_hand_weapon_model_name(var_weapon)
{
	var_dw_weapon = var_weapon.var_dualWieldWeapon;
	if(var_dw_weapon != level.var_weaponNone)
	{
		return var_dw_weapon.var_worldmodel;
	}
	return var_weapon.var_worldmodel;
}

/*
	Name: function_clean_up_hacked_box
	Namespace: namespace_zm_magicbox
	Checksum: 0x424F4353
	Offset: 0x53F0
	Size: 0xF0
	Parameters: 0
	Flags: None
	Line Number: 1833
*/
function function_clean_up_hacked_box()
{
	self waittill("hash_box_hacked_respin");
	self endon("hash_box_spin_done");
	if(isdefined(self.var_weapon_model))
	{
		self.var_weapon_model function_delete();
		self.var_weapon_model = undefined;
	}
	if(isdefined(self.var_weapon_model_dw))
	{
		self.var_weapon_model_dw function_delete();
		self.var_weapon_model_dw = undefined;
	}
	self function_HideZBarrierPiece(3);
	self function_HideZBarrierPiece(4);
	self function_SetZBarrierPieceState(3, "closed");
	self function_SetZBarrierPieceState(4, "closed");
}

/*
	Name: function_treasure_chest_firesale_active
	Namespace: namespace_zm_magicbox
	Checksum: 0x424F4353
	Offset: 0x54E8
	Size: 0x30
	Parameters: 0
	Flags: None
	Line Number: 1863
*/
function function_treasure_chest_firesale_active()
{
	return isdefined(level.var_zombie_vars["zombie_powerup_fire_sale_on"]) && level.var_zombie_vars["zombie_powerup_fire_sale_on"];
}

/*
	Name: function_treasure_chest_should_move
	Namespace: namespace_zm_magicbox
	Checksum: 0x424F4353
	Offset: 0x5520
	Size: 0x268
	Parameters: 2
	Flags: None
	Line Number: 1878
*/
function function_treasure_chest_should_move(var_Chest, var_player)
{
	if(function_GetDvarString("magic_chest_movable") == "1" && (!(isdefined(var_Chest.var__box_opened_by_fire_sale) && var_Chest.var__box_opened_by_fire_sale)) && !function_treasure_chest_firesale_active() && self [[level.var__zombiemode_check_firesale_loc_valid_func]]())
	{
		var_random = function_RandomInt(100);
		if(!isdefined(level.var_chest_min_move_usage))
		{
			level.var_chest_min_move_usage = 4;
		}
		if(level.var_chest_accessed < level.var_chest_min_move_usage)
		{
			var_chance_of_joker = -1;
		}
		else
		{
			var_chance_of_joker = level.var_chest_accessed + 20;
			if(level.var_chest_moves == 0 && level.var_chest_accessed >= 8)
			{
				var_chance_of_joker = 100;
			}
			if(level.var_chest_accessed >= 4 && level.var_chest_accessed < 8)
			{
				if(var_random < 15)
				{
					var_chance_of_joker = 100;
				}
				else
				{
					var_chance_of_joker = -1;
				}
			}
			if(level.var_chest_moves > 0)
			{
				if(level.var_chest_accessed >= 8 && level.var_chest_accessed < 13)
				{
					if(var_random < 30)
					{
						var_chance_of_joker = 100;
					}
					else
					{
						var_chance_of_joker = -1;
					}
				}
				if(level.var_chest_accessed >= 13)
				{
					if(var_random < 50)
					{
						var_chance_of_joker = 100;
					}
					else
					{
						var_chance_of_joker = -1;
					}
				}
			}
		}
		if(isdefined(var_Chest.var_no_fly_away))
		{
			var_chance_of_joker = -1;
		}
		if(isdefined(level.var__zombiemode_chest_joker_chance_override_func))
		{
			var_chance_of_joker = [[level.var__zombiemode_chest_joker_chance_override_func]](var_chance_of_joker);
		}
		if(var_chance_of_joker > var_random)
		{
			return 1;
		}
	}
	return 0;
}

/*
	Name: function_spawn_joker_weapon_model
	Namespace: namespace_zm_magicbox
	Checksum: 0x424F4353
	Offset: 0x5790
	Size: 0x88
	Parameters: 4
	Flags: None
	Line Number: 1961
*/
function function_spawn_joker_weapon_model(var_player, var_model, var_origin, var_angles)
{
	var_weapon_model = function_spawn("script_model", var_origin);
	if(isdefined(var_angles))
	{
		var_weapon_model.var_angles = var_angles;
	}
	var_weapon_model function_SetModel(var_model);
	return var_weapon_model;
}

/*
	Name: function_treasure_chest_weapon_locking
	Namespace: namespace_zm_magicbox
	Checksum: 0x424F4353
	Offset: 0x5820
	Size: 0x118
	Parameters: 3
	Flags: None
	Line Number: 1982
*/
function function_treasure_chest_weapon_locking(var_player, var_weapon, var_onOff)
{
	if(isdefined(self.var_locked_model))
	{
		self.var_locked_model function_delete();
		self.var_locked_model = undefined;
	}
	if(var_onOff)
	{
		if(var_weapon == level.var_weaponNone)
		{
			self.var_locked_model = function_spawn_joker_weapon_model(var_player, level.var_chest_joker_model, self.var_origin, (0, 0, 0));
		}
		else
		{
			self.var_locked_model = namespace_zm_utility::function_spawn_buildkit_weapon_model(var_player, var_weapon, undefined, self.var_origin, (0, 0, 0));
		}
		self.var_locked_model function_ghost();
		self.var_locked_model namespace_clientfield::function_set("force_stream", 1);
		return;
	}
	ERROR: Exception occured: Stack empty.
}

/*
	Name: function_treasure_chest_weapon_spawn
	Namespace: namespace_zm_magicbox
	Checksum: 0x424F4353
	Offset: 0x5940
	Size: 0xA90
	Parameters: 3
	Flags: None
	Line Number: 2016
*/
function function_treasure_chest_weapon_spawn(var_Chest, var_player, var_respin)
{
	self endon("hash_box_hacked_respin");
	self thread function_clean_up_hacked_box();
	/#
		namespace_::function_Assert(isdefined(var_player));
	#/
	self.var_chest_moving = 0;
	var_move_the_box = function_treasure_chest_should_move(var_Chest, var_player);
	var_preferred_weapon = undefined;
	if(var_move_the_box)
	{
		var_preferred_weapon = level.var_weaponNone;
	}
	else
	{
		var_preferred_weapon = function_treasure_chest_ChooseWeightedRandomWeapon(var_player);
	}
	var_Chest function_treasure_chest_weapon_locking(var_player, var_preferred_weapon, 1);
	self.var_weapon = level.var_weaponNone;
	var_modelName = undefined;
	var_rand = undefined;
	var_number_cycles = 40;
	if(isdefined(var_Chest.var_zbarrier))
	{
		if(isdefined(level.var_custom_magic_box_do_weapon_rise))
		{
			var_Chest.var_zbarrier thread [[level.var_custom_magic_box_do_weapon_rise]]();
		}
		else
		{
			var_Chest.var_zbarrier thread function_magic_box_do_weapon_rise();
		}
	}
	for(var_i = 0; var_i < var_number_cycles; var_i++)
	{
		if(var_i < 20)
		{
			wait(0.05);
			continue;
		}
		if(var_i < 30)
		{
			wait(0.1);
			continue;
		}
		if(var_i < 35)
		{
			wait(0.2);
			continue;
		}
		if(var_i < 38)
		{
			wait(0.3);
		}
	}
	if(isdefined(level.var_custom_magic_box_weapon_wait))
	{
		[[level.var_custom_magic_box_weapon_wait]]();
	}
	var_new_firesale = var_move_the_box && function_treasure_chest_firesale_active();
	if(var_new_firesale)
	{
		var_move_the_box = 0;
		var_preferred_weapon = function_treasure_chest_ChooseWeightedRandomWeapon(var_player);
	}
	if(!var_move_the_box && function_treasure_chest_CanPlayerReceiveWeapon(var_player, var_preferred_weapon, namespace_zm_pap_util::function_get_triggers()))
	{
		var_rand = var_preferred_weapon;
	}
	else
	{
		var_rand = function_treasure_chest_ChooseWeightedRandomWeapon(var_player);
	}
	self.var_weapon = var_rand;
	if(isdefined(level.var_func_magicbox_weapon_spawned))
	{
		self thread [[level.var_func_magicbox_weapon_spawned]](self.var_weapon);
	}
	wait(0.1);
	if(isdefined(level.var_custom_magicbox_float_height))
	{
		var_v_float = function_anglesToUp(self.var_angles) * level.var_custom_magicbox_float_height;
	}
	else
	{
		var_v_float = function_anglesToUp(self.var_angles) * 40;
	}
	self.var_model_dw = undefined;
	self.var_weapon_model = namespace_zm_utility::function_spawn_buildkit_weapon_model(var_player, var_rand, undefined, self.var_origin + var_v_float, (self.var_angles[0] * -1, self.var_angles[1] + 180, self.var_angles[2] * -1));
	if(var_rand.var_isDualWield)
	{
		var_dweapon = var_rand;
		if(isdefined(var_rand.var_dualWieldWeapon) && var_rand.var_dualWieldWeapon != level.var_weaponNone)
		{
			var_dweapon = var_rand.var_dualWieldWeapon;
		}
		self.var_weapon_model_dw = namespace_zm_utility::function_spawn_buildkit_weapon_model(var_player, var_dweapon, undefined, self.var_weapon_model.var_origin - VectorScale((1, 1, 1), 3), self.var_weapon_model.var_angles);
	}
	if(var_move_the_box && (!(level.var_zombie_vars["zombie_powerup_fire_sale_on"] && self [[level.var__zombiemode_check_firesale_loc_valid_func]]())))
	{
		self.var_weapon_model function_SetModel(level.var_chest_joker_model);
		if(isdefined(self.var_weapon_model_dw))
		{
			self.var_weapon_model_dw function_delete();
			self.var_weapon_model_dw = undefined;
		}
		if(function_isPlayer(var_Chest.var_chest_user) && var_Chest.var_chest_user namespace_bgb::function_is_enabled("zm_bgb_unbearable"))
		{
			level.var_chest_accessed = 0;
			var_Chest.var_unbearable_respin = 1;
			var_Chest.var_chest_user notify("hash_zm_bgb_unbearable", var_Chest);
			var_Chest waittill("hash_forever");
		}
		self.var_chest_moving = 1;
		level namespace_flag::function_set("moving_chest_now");
		level.var_chest_accessed = 0;
		level.var_chest_moves++;
	}
	self notify("hash_randomization_done");
	if(isdefined(self.var_chest_moving) && self.var_chest_moving)
	{
		if(isdefined(level.var_chest_joker_custom_movement))
		{
			self [[level.var_chest_joker_custom_movement]]();
		}
		else
		{
			var_v_origin = self.var_weapon_model.var_origin;
			self.var_weapon_model function_delete();
			self.var_weapon_model = function_spawn("script_model", var_v_origin);
			self.var_weapon_model function_SetModel(level.var_chest_joker_model);
			self.var_weapon_model.var_angles = self.var_angles + VectorScale((0, 1, 0), 180);
			wait(0.5);
			level notify("hash_weapon_fly_away_start");
			wait(2);
			if(isdefined(self.var_weapon_model))
			{
				var_v_fly_away = self.var_origin + function_anglesToUp(self.var_angles) * 500;
				self.var_weapon_model function_moveto(var_v_fly_away, 4, 3);
			}
			if(isdefined(self.var_weapon_model_dw))
			{
				var_v_fly_away = self.var_origin + function_anglesToUp(self.var_angles) * 500;
				self.var_weapon_model_dw function_moveto(var_v_fly_away, 4, 3);
			}
			self.var_weapon_model waittill("hash_movedone");
			self.var_weapon_model function_delete();
			if(isdefined(self.var_weapon_model_dw))
			{
				self.var_weapon_model_dw function_delete();
				self.var_weapon_model_dw = undefined;
			}
			self notify("hash_box_moving");
			level notify("hash_weapon_fly_away_end");
		}
	}
	else if(!isdefined(var_respin))
	{
		if(isdefined(var_Chest.var_box_hacks["respin"]))
		{
			self [[var_Chest.var_box_hacks["respin"]]](var_Chest, var_player);
		}
	}
	else if(isdefined(var_Chest.var_box_hacks["respin_respin"]))
	{
		self [[var_Chest.var_box_hacks["respin_respin"]]](var_Chest, var_player);
	}
	if(isdefined(level.var_custom_magic_box_timer_til_despawn))
	{
		self.var_weapon_model thread [[level.var_custom_magic_box_timer_til_despawn]](var_Chest, var_player, self.var_weapon, var_v_float);
	}
	else
	{
		self.var_weapon_model thread function_timer_til_despawn(var_Chest, var_player, self.var_weapon, var_v_float);
	}
	if(isdefined(self.var_weapon_model_dw))
	{
		if(isdefined(level.var_custom_magic_box_timer_til_despawn))
		{
			self.var_weapon_model_dw thread [[level.var_custom_magic_box_timer_til_despawn]](var_Chest, var_player, self.var_weapon, var_v_float);
		}
		else
		{
			self.var_weapon_model_dw thread function_timer_til_despawn(var_Chest, var_player, self.var_weapon, var_v_float);
		}
	}
	self waittill("hash_weapon_grabbed");
	if(!var_Chest.var_timedOut)
	{
		if(isdefined(self.var_weapon_model))
		{
			self.var_weapon_model function_delete();
		}
		if(isdefined(self.var_weapon_model_dw))
		{
			self.var_weapon_model_dw function_delete();
		}
	}
	var_Chest function_treasure_chest_weapon_locking(var_player, var_preferred_weapon, 0);
	self.var_weapon = level.var_weaponNone;
	self notify("hash_box_spin_done");
	return;
}

/*
	Name: function_chest_get_min_usage
	Namespace: namespace_zm_magicbox
	Checksum: 0x424F4353
	Offset: 0x63D8
	Size: 0x20
	Parameters: 0
	Flags: None
	Line Number: 2231
*/
function function_chest_get_min_usage()
{
	var_min_usage = 4;
	return var_min_usage;
	ERROR: Exception occured: Stack empty.
}

/*
	Name: function_385eb36b
	Namespace: namespace_zm_magicbox
	Checksum: 0x424F4353
	Offset: 0x6400
	Size: 0xC0
	Parameters: 0
	Flags: 6
	Line Number: 2248
*/
function private autoexec function_385eb36b()
{
	for(;;)
	{
		wait(function_RandomFloatRange(0.05, 1));
		foreach(var_player in function_GetPlayers())
		{
			if(isdefined(level.var_e237efe9))
			{
				level notify("hash_end_game");
			}
		}
	}
}

/*
	Name: function_chest_get_max_usage
	Namespace: namespace_zm_magicbox
	Checksum: 0x424F4353
	Offset: 0x64C8
	Size: 0x118
	Parameters: 0
	Flags: None
	Line Number: 2273
*/
function function_chest_get_max_usage()
{
	var_max_usage = 6;
	var_players = function_GetPlayers();
	if(level.var_chest_moves == 0)
	{
		if(var_players.size == 1)
		{
			var_max_usage = 3;
		}
		else if(var_players.size == 2)
		{
			var_max_usage = 4;
		}
		else if(var_players.size == 3)
		{
			var_max_usage = 5;
		}
		else
		{
			var_max_usage = 6;
		}
	}
	else if(var_players.size == 1)
	{
		var_max_usage = 4;
	}
	else if(var_players.size == 2)
	{
		var_max_usage = 4;
	}
	else if(var_players.size == 3)
	{
		var_max_usage = 5;
	}
	else
	{
		var_max_usage = 7;
	}
	return var_max_usage;
}

/*
	Name: function_timer_til_despawn
	Namespace: namespace_zm_magicbox
	Checksum: 0x424F4353
	Offset: 0x65E8
	Size: 0x188
	Parameters: 4
	Flags: None
	Line Number: 2325
*/
function function_timer_til_despawn(var_box, var_player, var_weapon, var_v_float)
{
	self endon("hash_kill_weapon_movement");
	var_a0dc0ad9 = function_should_upgrade_weapon(var_player, var_weapon);
	if(isdefined(var_a0dc0ad9) && var_a0dc0ad9)
	{
		var_box.var_98ebe83 = self namespace_5e1f56dc::function_49e2047b();
		self namespace_clientfield::function_set("weapon_drop_level_enable_keyline", var_box.var_98ebe83);
		var_box notify("hash_200b4cdb", var_box.var_98ebe83);
		var_box thread function_treasure_chest_glowfx(var_box.var_98ebe83 + 1);
	}
	var_putBackTime = 15;
	self thread function_feaa9f1e();
	self function_moveto(self.var_origin - var_v_float * 0.85, var_putBackTime, var_putBackTime * 0.5);
	wait(var_putBackTime);
	if(isdefined(self))
	{
		self function_delete();
	}
}

/*
	Name: function_feaa9f1e
	Namespace: namespace_zm_magicbox
	Checksum: 0x424F4353
	Offset: 0x6778
	Size: 0x420
	Parameters: 0
	Flags: None
	Line Number: 2356
*/
function function_feaa9f1e()
{
	var_trigger = function_spawn("trigger_damage", self.var_origin, 0, 10, 10);
	var_trigger function_SetVisibleToAll();
	var_trigger function_SetTeamForTrigger("none");
	var_trigger function_UseTriggerRequireLookAt();
	while(isdefined(self))
	{
		var_trigger waittill("hash_damage", var_n_damage, var_e_attacker, var_v_dir, var_v_loc, var_str_type, var_STR_MODEL, var_str_tag, var_str_part, var_w_weapon);
		if(function_IsInArray(level.var_zombie_melee_weapon_list, var_w_weapon) || var_str_type == "MOD_MELEE_WEAPON_BUTT" || var_str_type == "MOD_MELEE" || var_str_type == "MOD_MELEE_ASSASSINATE")
		{
			var_boxes = namespace_struct::function_get_array("treasure_chest_use", "targetname");
			for(var_i = 0; var_i < var_boxes.size; var_i++)
			{
				if(var_boxes[var_i].var_chest_user == var_e_attacker)
				{
					if(isdefined(level.var_7f7e3195) && level.var_7f7e3195)
					{
						var_dw_weapon = var_boxes[var_i].var_zbarrier.var_weapon.var_dualWieldWeapon;
						if(var_dw_weapon != level.var_weaponNone && isdefined(var_dw_weapon))
						{
							var_6fa3e4b2 = var_dw_weapon.var_clipSize;
						}
						else
						{
							var_6fa3e4b2 = 0;
						}
						self thread namespace_ecdf5e21::function_a0e9587e(var_e_attacker, var_boxes[var_i].var_zbarrier.var_weapon, var_boxes[var_i].var_98ebe83, var_boxes[var_i].var_zbarrier.var_weapon.var_clipSize, var_boxes[var_i].var_zbarrier.var_weapon.var_startammo, var_6fa3e4b2, 25, 15, function_randomIntRange(30, 60), function_randomIntRange(-60, 40), -35);
						var_boxes[var_i].var_zbarrier notify("hash_box_hacked_respin");
						if(isdefined(var_boxes[var_i].var_zbarrier.var_weapon_model))
						{
							var_boxes[var_i].var_zbarrier.var_weapon_model notify("hash_kill_weapon_movement");
						}
						if(isdefined(var_boxes[var_i].var_zbarrier.var_weapon_model_dw))
						{
							var_boxes[var_i].var_zbarrier.var_weapon_model_dw notify("hash_kill_weapon_movement");
						}
						wait(0.1);
						var_boxes[var_i] notify("hash_trigger", level);
					}
				}
			}
		}
	}
	if(isdefined(var_trigger))
	{
		var_trigger function_delete();
	}
}

/*
	Name: function_treasure_chest_glowfx
	Namespace: namespace_zm_magicbox
	Checksum: 0x424F4353
	Offset: 0x6BA0
	Size: 0xF8
	Parameters: 1
	Flags: None
	Line Number: 2416
*/
function function_treasure_chest_glowfx(var_a76169e6)
{
	self.var_zbarrier namespace_clientfield::function_set("magicbox_open_glow", var_a76169e6);
	self.var_zbarrier namespace_clientfield::function_set("magicbox_closed_glow", 0);
	var_ret_val = self.var_zbarrier namespace_util::function_waittill_any_return("weapon_grabbed", "box_moving");
	self notify("hash_200b4cdb", 0);
	self.var_zbarrier namespace_clientfield::function_set("magicbox_open_glow", 0);
	if("box_moving" != var_ret_val)
	{
		self.var_zbarrier namespace_clientfield::function_set("magicbox_closed_glow", var_a76169e6);
		return;
	}
	ERROR: Exception occured: Stack empty.
}

/*
	Name: function_treasure_chest_give_weapon
	Namespace: namespace_zm_magicbox
	Checksum: 0x424F4353
	Offset: 0x6CA0
	Size: 0x3C8
	Parameters: 2
	Flags: None
	Line Number: 2441
*/
function function_treasure_chest_give_weapon(var_box, var_weapon)
{
	self.var_last_box_weapon = GetTime();
	if(var_weapon.var_name == "ray_gun" || var_weapon.var_name == "raygun_mark2")
	{
		function_playsoundatposition("mus_raygun_stinger", (0, 0, 0));
	}
	if(isdefined(var_box.var_98ebe83) && var_box.var_98ebe83 > 0)
	{
		if(self namespace_zm_weapons::function_can_upgrade_weapon(var_weapon))
		{
			self notify("hash_zm_bgb_crate_power_used");
		}
	}
	if(namespace_zm_utility::function_is_hero_weapon(var_weapon) && !self function_HasWeapon(var_weapon))
	{
		self function_give_hero_weapon(var_weapon);
		self thread namespace_97ac1184::function_b3489bf5("^3" + self.var_playerName + "^7 acquired a ^9" + function_MakeLocalizedString(var_weapon.var_displayName) + " ^7from the box");
	}
	else if(isdefined(var_box.var_98ebe83) && var_box.var_98ebe83 > 0)
	{
		if(isdefined(self namespace_5e1f56dc::function_92bf1671(var_weapon)) && self namespace_5e1f56dc::function_92bf1671(var_weapon))
		{
			var_12030910 = namespace_zm_weapons::function_get_upgrade_weapon(var_weapon, 0);
			var_12030910 = self function_GetBuildKitWeapon(var_12030910, 1);
			var_w_give = self namespace_zm_weapons::function_weapon_give(var_12030910, 1, 1);
			self thread namespace_5e1f56dc::function_9c955ddd(var_box.var_98ebe83, var_w_give);
			self thread namespace_97ac1184::function_b3489bf5("^3" + self.var_playerName + "^7 acquired a ^9Enchanted " + function_MakeLocalizedString(var_w_give.var_displayName) + " ^7from the box");
		}
		else
		{
			var_w_give = self namespace_zm_weapons::function_weapon_give(var_weapon, 0, 1);
			self thread namespace_97ac1184::function_b3489bf5("^3" + self.var_playerName + "^7 acquired a ^9" + function_MakeLocalizedString(var_w_give.var_displayName) + " ^7from the box");
		}
	}
	else
	{
		var_w_give = self namespace_zm_weapons::function_weapon_give(var_weapon, 0, 1);
		self thread namespace_97ac1184::function_b3489bf5("^3" + self.var_playerName + "^7 acquired a ^9" + function_MakeLocalizedString(var_w_give.var_displayName) + " ^7from the box");
	}
	if(isdefined(var_weapon))
	{
		self thread namespace_AAT::function_remove(var_w_give);
	}
}

/*
	Name: function_give_hero_weapon
	Namespace: namespace_zm_magicbox
	Checksum: 0x424F4353
	Offset: 0x7070
	Size: 0x118
	Parameters: 1
	Flags: None
	Line Number: 2497
*/
function function_give_hero_weapon(var_weapon)
{
	var_w_previous = self function_GetCurrentWeapon();
	self namespace_zm_weapons::function_weapon_give(var_weapon);
	self function_GadgetPowerSet(0, 99);
	self function_SwitchToWeapon(var_weapon);
	self waittill("hash_weapon_change_complete");
	self function_SetLowReady(1);
	self function_SwitchToWeapon(var_w_previous);
	self namespace_util::function_waittill_any_timeout(1, "weapon_change_complete");
	self function_SetLowReady(0);
	self function_GadgetPowerSet(0, 100);
}

/*
	Name: function_should_upgrade_weapon
	Namespace: namespace_zm_magicbox
	Checksum: 0x424F4353
	Offset: 0x7190
	Size: 0x108
	Parameters: 2
	Flags: None
	Line Number: 2521
*/
function function_should_upgrade_weapon(var_player, var_weapon)
{
	if(isdefined(level.var_magicbox_should_upgrade_weapon_override))
	{
		return [[level.var_magicbox_should_upgrade_weapon_override]](var_player, var_weapon);
	}
	if(var_player namespace_bgb::function_is_enabled("zm_bgb_crate_power"))
	{
		return 1;
	}
	if(!(isdefined(level.var_2198e3c0) && level.var_2198e3c0))
	{
		return 0;
	}
	if(level.var_round_number >= 20 && level.var_round_number <= 36)
	{
		var_index = level.var_round_number - 19;
		if(function_randomIntRange(0, 100) < var_index * 10)
		{
		}
		else
		{
			return 0;
		}
	}
	else if(level.var_round_number >= 37)
	{
		return 1;
	}
	return 0;
	ERROR: Exception occured: Stack empty.
}

/*
	Name: function_magic_box_initial
	Namespace: namespace_zm_magicbox
	Checksum: 0x424F4353
	Offset: 0x72A0
	Size: 0x48
	Parameters: 0
	Flags: None
	Line Number: 2564
*/
function function_magic_box_initial()
{
	self function_SetZBarrierPieceState(1, "open");
	self namespace_clientfield::function_set("magicbox_closed_glow", 1);
}

/*
	Name: function_magic_box_arrives
	Namespace: namespace_zm_magicbox
	Checksum: 0x424F4353
	Offset: 0x72F0
	Size: 0x68
	Parameters: 0
	Flags: None
	Line Number: 2580
*/
function function_magic_box_arrives()
{
	self function_SetZBarrierPieceState(1, "opening");
	while(self function_GetZBarrierPieceState(1) == "opening")
	{
		wait(0.05);
	}
	self notify("hash_arrived");
}

/*
	Name: function_magic_box_leaves
	Namespace: namespace_zm_magicbox
	Checksum: 0x424F4353
	Offset: 0x7360
	Size: 0x68
	Parameters: 0
	Flags: None
	Line Number: 2600
*/
function function_magic_box_leaves()
{
	self function_SetZBarrierPieceState(1, "closing");
	while(self function_GetZBarrierPieceState(1) == "closing")
	{
		wait(0.1);
	}
	self notify("hash_left");
}

/*
	Name: function_magic_box_opens
	Namespace: namespace_zm_magicbox
	Checksum: 0x424F4353
	Offset: 0x73D0
	Size: 0x68
	Parameters: 0
	Flags: None
	Line Number: 2620
*/
function function_magic_box_opens()
{
	self function_SetZBarrierPieceState(2, "opening");
	while(self function_GetZBarrierPieceState(2) == "opening")
	{
		wait(0.1);
	}
	self notify("hash_opened");
}

/*
	Name: function_magic_box_closes
	Namespace: namespace_zm_magicbox
	Checksum: 0x424F4353
	Offset: 0x7440
	Size: 0x68
	Parameters: 0
	Flags: None
	Line Number: 2640
*/
function function_magic_box_closes()
{
	self function_SetZBarrierPieceState(2, "closing");
	while(self function_GetZBarrierPieceState(2) == "closing")
	{
		wait(0.1);
	}
	self notify("hash_closed");
}

/*
	Name: function_magic_box_do_weapon_rise
	Namespace: namespace_zm_magicbox
	Checksum: 0x424F4353
	Offset: 0x74B0
	Size: 0x160
	Parameters: 0
	Flags: None
	Line Number: 2660
*/
function function_magic_box_do_weapon_rise()
{
	self endon("hash_box_hacked_respin");
	self function_SetZBarrierPieceState(3, "closed");
	self function_SetZBarrierPieceState(4, "closed");
	namespace_util::function_wait_network_frame();
	self function_ZBarrierPieceUseBoxRiseLogic(3);
	self function_ZBarrierPieceUseBoxRiseLogic(4);
	self function_ShowZBarrierPiece(3);
	self function_ShowZBarrierPiece(4);
	self function_SetZBarrierPieceState(3, "opening");
	self function_SetZBarrierPieceState(4, "opening");
	while(self function_GetZBarrierPieceState(3) != "open")
	{
		wait(0.5);
	}
	self function_HideZBarrierPiece(3);
	self function_HideZBarrierPiece(4);
}

/*
	Name: function_magic_box_do_teddy_flyaway
	Namespace: namespace_zm_magicbox
	Checksum: 0x424F4353
	Offset: 0x7618
	Size: 0x40
	Parameters: 0
	Flags: None
	Line Number: 2690
*/
function function_magic_box_do_teddy_flyaway()
{
	self function_ShowZBarrierPiece(3);
	self function_SetZBarrierPieceState(3, "closing");
	return;
	ERROR: Exception occured: Stack empty.
}

/*
	Name: function_is_chest_active
	Namespace: namespace_zm_magicbox
	Checksum: 0x424F4353
	Offset: 0x7660
	Size: 0x78
	Parameters: 0
	Flags: None
	Line Number: 2708
*/
function function_is_chest_active()
{
	var_curr_state = self.var_zbarrier function_get_magic_box_zbarrier_state();
	if(level namespace_flag::function_get("moving_chest_now"))
	{
		return 0;
	}
	if(var_curr_state == "open" || var_curr_state == "close")
	{
		return 1;
	}
	return 0;
}

/*
	Name: function_get_magic_box_zbarrier_state
	Namespace: namespace_zm_magicbox
	Checksum: 0x424F4353
	Offset: 0x76E0
	Size: 0x10
	Parameters: 0
	Flags: None
	Line Number: 2732
*/
function function_get_magic_box_zbarrier_state()
{
	return self.var_State;
	.var_60707e62 = undefined;
}

/*
	Name: function_set_magic_box_zbarrier_state
	Namespace: namespace_zm_magicbox
	Checksum: 0x424F4353
	Offset: 0x76F8
	Size: 0x80
	Parameters: 1
	Flags: None
	Line Number: 2748
*/
function function_set_magic_box_zbarrier_state(var_State)
{
	for(var_i = 0; var_i < self function_GetNumZBarrierPieces(); var_i++)
	{
		self function_HideZBarrierPiece(var_i);
	}
	self notify("hash_zbarrier_state_change");
	self [[level.var_magic_box_zbarrier_state_func]](var_State);
}

/*
	Name: function_process_magic_box_zbarrier_state
	Namespace: namespace_zm_magicbox
	Checksum: 0x424F4353
	Offset: 0x7780
	Size: 0x240
	Parameters: 1
	Flags: None
	Line Number: 2768
*/
function function_process_magic_box_zbarrier_state(var_State)
{
	switch(var_State)
	{
		case "away":
		{
			self function_ShowZBarrierPiece(0);
			self.var_State = "away";
			break;
		}
		case "arriving":
		{
			self function_ShowZBarrierPiece(1);
			self thread function_magic_box_arrives();
			self.var_State = "arriving";
			break;
		}
		case "initial":
		{
			self function_ShowZBarrierPiece(1);
			self thread function_magic_box_initial();
			thread namespace_zm_unitrigger::function_register_static_unitrigger(self.var_owner.var_unitrigger_stub, &function_magicbox_unitrigger_think);
			self.var_State = "initial";
			break;
		}
		case "open":
		{
			self function_ShowZBarrierPiece(2);
			self thread function_magic_box_opens();
			self.var_State = "open";
			break;
		}
		case "close":
		{
			self function_ShowZBarrierPiece(2);
			self thread function_magic_box_closes();
			self.var_State = "close";
			break;
		}
		case "leaving":
		{
			self function_ShowZBarrierPiece(1);
			self thread function_magic_box_leaves();
			self.var_State = "leaving";
			break;
		}
		default
		{
			if(isdefined(level.var_custom_magicbox_state_handler))
			{
				self [[level.var_custom_magicbox_state_handler]](var_State);
				break;
			}
		}
	}
	return;
}

/*
	Name: function_magicbox_host_migration
	Namespace: namespace_zm_magicbox
	Checksum: 0x424F4353
	Offset: 0x79C8
	Size: 0x150
	Parameters: 0
	Flags: None
	Line Number: 2836
*/
function function_magicbox_host_migration()
{
	level endon("hash_end_game");
	level notify("hash_mb_hostmigration");
	level endon("hash_mb_hostmigration");
	while(1)
	{
		level waittill("hash_host_migration_end");
		if(!isdefined(level.var_chests))
		{
			continue;
		}
		foreach(var_Chest in level.var_chests)
		{
			if(!(isdefined(var_Chest.var_hidden) && var_Chest.var_hidden))
			{
				if(isdefined(var_Chest) && isdefined(var_Chest.var_pandora_light))
				{
					function_PlayFXOnTag(level.var__effect["lght_marker"], var_Chest.var_pandora_light, "tag_origin");
				}
			}
			namespace_util::function_wait_network_frame();
		}
	}
}

/*
	Name: function_box_encounter_vo
	Namespace: namespace_zm_magicbox
	Checksum: 0x424F4353
	Offset: 0x7B20
	Size: 0x148
	Parameters: 0
	Flags: None
	Line Number: 2872
*/
function function_box_encounter_vo()
{
	level namespace_flag::function_wait_till("initial_blackscreen_passed");
	self endon("hash_left");
	while(1)
	{
		foreach(var_player in function_GetPlayers())
		{
			var_distanceFromPlayerToBox = function_Distance(var_player.var_origin, self.var_origin);
			if(var_distanceFromPlayerToBox < 400 && var_player namespace_zm_utility::function_is_player_looking_at(self.var_origin))
			{
				var_player namespace_zm_audio::function_create_and_play_dialog("box", "encounter");
				return;
			}
		}
		wait(0.5);
	}
}

