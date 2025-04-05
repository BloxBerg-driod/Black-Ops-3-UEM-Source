#include scripts\codescripts\struct;
#include scripts\shared\ai\zombie_utility;
#include scripts\shared\array_shared;
#include scripts\shared\clientfield_shared;
#include scripts\shared\demo_shared;
#include scripts\shared\flag_shared;
#include scripts\shared\laststand_shared;
#include scripts\shared\trigger_shared;
#include scripts\shared\util_shared;
#include scripts\shared\visionset_mgr_shared;
#include scripts\zm\_util;
#include scripts\zm\_zm;
#include scripts\zm\_zm_audio;
#include scripts\zm\_zm_bgb;
#include scripts\zm\_zm_equipment;
#include scripts\zm\_zm_laststand;
#include scripts\zm\_zm_magicbox;
#include scripts\zm\_zm_pers_upgrades_functions;
#include scripts\zm\_zm_power;
#include scripts\zm\_zm_score;
#include scripts\zm\_zm_stats;
#include scripts\zm\_zm_utility;
#include scripts\zm\_zm_weapons;

#namespace namespace_zm_perks;

/*
	Name: function_init
	Namespace: namespace_zm_perks
	Checksum: 0x424F4353
	Offset: 0x6D8
	Size: 0x330
	Parameters: 0
	Flags: None
	Line Number: 36
*/
function function_init()
{
	level.var_perk_purchase_limit = 4;
	function_perks_register_clientfield();
	if(!level.var_enable_magic)
	{
		return;
	}
	function_initialize_custom_perk_arrays();
	function_perk_machine_spawn_init();
	var_vending_weapon_upgrade_trigger = [];
	var_vending_triggers = function_GetEntArray("zombie_vending", "targetname");
	if(var_vending_triggers.size < 1)
	{
		return;
	}
	level.var_machine_assets = [];
	if(!isdefined(level.var_custom_vending_precaching))
	{
		level.var_custom_vending_precaching = &function_default_vending_precaching;
	}
	[[level.var_custom_vending_precaching]]();
	namespace_zombie_utility::function_set_zombie_var("zombie_perk_cost", 2000);
	namespace_Array::function_thread_all(var_vending_triggers, &function_vending_trigger_think);
	namespace_Array::function_thread_all(var_vending_triggers, &function_electric_perks_dialog);
	if(level.var__custom_perks.size > 0)
	{
		var_a_keys = function_getArrayKeys(level.var__custom_perks);
		for(var_i = 0; var_i < var_a_keys.size; var_i++)
		{
			if(isdefined(level.var__custom_perks[var_a_keys[var_i]].var_perk_machine_thread))
			{
				level thread [[level.var__custom_perks[var_a_keys[var_i]].var_perk_machine_thread]]();
			}
			if(isdefined(level.var__custom_perks[var_a_keys[var_i]].var_perk_machine_power_override_thread))
			{
				level thread [[level.var__custom_perks[var_a_keys[var_i]].var_perk_machine_power_override_thread]]();
				continue;
			}
			if(isdefined(level.var__custom_perks[var_a_keys[var_i]].var_alias) && isdefined(level.var__custom_perks[var_a_keys[var_i]].var_radiant_machine_name) && isdefined(level.var__custom_perks[var_a_keys[var_i]].var_machine_light_effect))
			{
				level thread function_perk_machine_think(var_a_keys[var_i], level.var__custom_perks[var_a_keys[var_i]]);
			}
		}
	}
	else if(isdefined(level.var_quantum_bomb_register_result_func))
	{
		[[level.var_quantum_bomb_register_result_func]]("give_nearest_perk", &function_quantum_bomb_give_nearest_perk_result, 10, &function_quantum_bomb_give_nearest_perk_validation);
	}
	level thread function_perk_hostmigration();
}

/*
	Name: function_perk_machine_think
	Namespace: namespace_zm_perks
	Checksum: 0x424F4353
	Offset: 0xA10
	Size: 0x3C0
	Parameters: 2
	Flags: None
	Line Number: 98
*/
function function_perk_machine_think(var_str_key, var_s_custom_perk)
{
	var_str_endon = var_str_key + "_power_thread_end";
	level endon(var_str_endon);
	var_fb1cd1b2 = var_s_custom_perk.var_alias + "_on";
	var_str_off = var_s_custom_perk.var_alias + "_off";
	var_str_notify = var_str_key + "_power_on";
	while(1)
	{
		var_machine = function_GetEntArray(var_s_custom_perk.var_radiant_machine_name, "targetname");
		var_machine_triggers = function_GetEntArray(var_s_custom_perk.var_radiant_machine_name, "target");
		for(var_i = 0; var_i < var_machine.size; var_i++)
		{
			var_machine[var_i] function_SetModel(level.var_machine_assets[var_str_key].var_off_model);
			var_machine[var_i] function_solid();
		}
		level thread function_do_initial_power_off_callback(var_machine, var_str_key);
		namespace_Array::function_thread_all(var_machine_triggers, &function_set_power_on, 0);
		level waittill(var_fb1cd1b2);
		for(var_i = 0; var_i < var_machine.size; var_i++)
		{
			var_machine[var_i] function_SetModel(level.var_machine_assets[var_str_key].var_on_model);
			var_machine[var_i] function_vibrate(VectorScale((0, -1, 0), 100), 0.3, 0.4, 3);
			var_machine[var_i] function_playsound("zmb_perks_power_on");
			var_machine[var_i] thread function_perk_fx(var_s_custom_perk.var_machine_light_effect);
			var_machine[var_i] thread function_play_loop_on_machine();
		}
		level notify(var_str_notify);
		namespace_Array::function_thread_all(var_machine_triggers, &function_set_power_on, 1);
		if(isdefined(level.var_machine_assets[var_str_key].var_power_on_callback))
		{
			namespace_Array::function_thread_all(var_machine, level.var_machine_assets[var_str_key].var_power_on_callback);
		}
		level waittill(var_str_off);
		if(isdefined(level.var_machine_assets[var_str_key].var_power_off_callback))
		{
			namespace_Array::function_thread_all(var_machine, level.var_machine_assets[var_str_key].var_power_off_callback);
		}
		namespace_Array::function_thread_all(var_machine, &function_turn_perk_off);
	}
}

/*
	Name: function_default_vending_precaching
	Namespace: namespace_zm_perks
	Checksum: 0x424F4353
	Offset: 0xDD8
	Size: 0xB0
	Parameters: 0
	Flags: None
	Line Number: 150
*/
function function_default_vending_precaching()
{
	if(level.var__custom_perks.size > 0)
	{
		var_a_keys = function_getArrayKeys(level.var__custom_perks);
		for(var_i = 0; var_i < var_a_keys.size; var_i++)
		{
			if(isdefined(level.var__custom_perks[var_a_keys[var_i]].var_precache_func))
			{
				level [[level.var__custom_perks[var_a_keys[var_i]].var_precache_func]]();
			}
		}
	}
}

/*
	Name: function_do_initial_power_off_callback
	Namespace: namespace_zm_perks
	Checksum: 0x424F4353
	Offset: 0xE90
	Size: 0x80
	Parameters: 2
	Flags: None
	Line Number: 175
*/
function function_do_initial_power_off_callback(var_machine_array, var_perkname)
{
	if(!isdefined(level.var_machine_assets[var_perkname]))
	{
		return;
	}
	if(!isdefined(level.var_machine_assets[var_perkname].var_power_off_callback))
	{
		return;
	}
	wait(0.05);
	namespace_Array::function_thread_all(var_machine_array, level.var_machine_assets[var_perkname].var_power_off_callback);
}

/*
	Name: function_use_solo_revive
	Namespace: namespace_zm_perks
	Checksum: 0x424F4353
	Offset: 0xF18
	Size: 0x90
	Parameters: 0
	Flags: None
	Line Number: 199
*/
function function_use_solo_revive()
{
	if(isdefined(level.var_override_use_solo_revive))
	{
		return [[level.var_override_use_solo_revive]]();
	}
	var_players = function_GetPlayers();
	var_solo_mode = 0;
	if(var_players.size == 1 || (isdefined(level.var_force_solo_quick_revive) && level.var_force_solo_quick_revive))
	{
		var_solo_mode = 1;
	}
	level.var_using_solo_revive = var_solo_mode;
	return var_solo_mode;
}

/*
	Name: function_set_power_on
	Namespace: namespace_zm_perks
	Checksum: 0x424F4353
	Offset: 0xFB0
	Size: 0x18
	Parameters: 1
	Flags: None
	Line Number: 225
*/
function function_set_power_on(var_State)
{
	self.var_power_on = var_State;
}

/*
	Name: function_turn_perk_off
	Namespace: namespace_zm_perks
	Checksum: 0x424F4353
	Offset: 0xFD0
	Size: 0x118
	Parameters: 1
	Flags: None
	Line Number: 240
*/
function function_turn_perk_off(var_ishidden)
{
	self notify("hash_stop_loopsound");
	if(!(isdefined(self.var_b_keep_when_turned_off) && self.var_b_keep_when_turned_off))
	{
		var_newMachine = function_spawn("script_model", self.var_origin);
		var_newMachine.var_angles = self.var_angles;
		var_newMachine.var_targetname = self.var_targetname;
		if(isdefined(var_ishidden) && var_ishidden)
		{
			var_newMachine.var_ishidden = 1;
			var_newMachine function_ghost();
			var_newMachine function_notsolid();
		}
		self function_delete();
	}
	else
	{
		function_perk_fx(undefined, 1);
	}
}

/*
	Name: function_play_loop_on_machine
	Namespace: namespace_zm_perks
	Checksum: 0x424F4353
	Offset: 0x10F0
	Size: 0xB0
	Parameters: 0
	Flags: None
	Line Number: 272
*/
function function_play_loop_on_machine()
{
	if(isdefined(level.var_sndPerksacolaLoopOverride))
	{
		return;
	}
	var_sound_ent = function_spawn("script_origin", self.var_origin);
	var_sound_ent function_PlayLoopSound("zmb_perks_machine_loop");
	var_sound_ent function_LinkTo(self);
	self waittill("hash_stop_loopsound");
	var_sound_ent function_Unlink();
	var_sound_ent function_delete();
}

/*
	Name: function_perk_fx
	Namespace: namespace_zm_perks
	Checksum: 0x424F4353
	Offset: 0x11A8
	Size: 0x168
	Parameters: 2
	Flags: None
	Line Number: 296
*/
function function_perk_fx(var_FX, var_turnOffFx)
{
	if(isdefined(var_turnOffFx))
	{
		self.var_perk_fx = 0;
		if(isdefined(self.var_b_keep_when_turned_off) && self.var_b_keep_when_turned_off && isdefined(self.var_s_fxloc))
		{
			self.var_s_fxloc function_delete();
		}
	}
	else
	{
		wait(3);
		if(!isdefined(self))
		{
			return;
		}
		if(!(isdefined(self.var_b_keep_when_turned_off) && self.var_b_keep_when_turned_off))
		{
			if(isdefined(self) && (!(isdefined(self.var_perk_fx) && self.var_perk_fx)))
			{
				function_PlayFXOnTag(level.var__effect[var_FX], self, "tag_origin");
				self.var_perk_fx = 1;
			}
		}
		else if(isdefined(self) && !isdefined(self.var_s_fxloc))
		{
			self.var_s_fxloc = namespace_util::function_spawn_model("tag_origin", self.var_origin);
			function_PlayFXOnTag(level.var__effect[var_FX], self.var_s_fxloc, "tag_origin");
			self.var_perk_fx = 1;
		}
	}
}

/*
	Name: function_electric_perks_dialog
	Namespace: namespace_zm_perks
	Checksum: 0x424F4353
	Offset: 0x1318
	Size: 0x1E0
	Parameters: 0
	Flags: None
	Line Number: 340
*/
function function_electric_perks_dialog()
{
	self endon("hash_death");
	wait(0.01);
	level namespace_flag::function_wait_till("start_zombie_round_logic");
	var_players = function_GetPlayers();
	if(var_players.size == 1)
	{
		return;
	}
	self endon("hash_warning_dialog");
	level endon("hash_switch_flipped");
	var_timer = 0;
	while(1)
	{
		wait(0.5);
		var_players = function_GetPlayers();
		for(var_i = 0; var_i < var_players.size; var_i++)
		{
			if(!isdefined(var_players[var_i]))
			{
				continue;
			}
			var_dist = function_DistanceSquared(var_players[var_i].var_origin, self.var_origin);
			if(var_dist > 4900)
			{
				var_timer = 0;
				continue;
			}
			if(var_dist < 4900 && var_timer < 3)
			{
				wait(0.5);
				var_timer++;
			}
			if(var_dist < 4900 && var_timer == 3)
			{
				if(!isdefined(var_players[var_i]))
				{
					continue;
				}
				var_players[var_i] thread namespace_zm_utility::function_do_player_vo("vox_start", 5);
				wait(3);
				self notify("hash_warning_dialog");
			}
		}
	}
}

/*
	Name: function_reset_vending_hint_string
	Namespace: namespace_zm_perks
	Checksum: 0x424F4353
	Offset: 0x1500
	Size: 0x140
	Parameters: 0
	Flags: None
	Line Number: 398
*/
function function_reset_vending_hint_string()
{
	var_perk = self.var_script_noteworthy;
	var_Solo = function_use_solo_revive();
	if(isdefined(level.var__custom_perks))
	{
		if(isdefined(level.var__custom_perks[var_perk]) && isdefined(level.var__custom_perks[var_perk].var_cost) && isdefined(level.var__custom_perks[var_perk].var_hint_string))
		{
			if(function_IsFunctionPtr(level.var__custom_perks[var_perk].var_cost))
			{
				var_n_cost = [[level.var__custom_perks[var_perk].var_cost]]();
			}
			else
			{
				var_n_cost = level.var__custom_perks[var_perk].var_cost;
			}
			self function_setHintString(level.var__custom_perks[var_perk].var_hint_string, var_n_cost);
		}
	}
}

/*
	Name: function_vending_trigger_can_player_use
	Namespace: namespace_zm_perks
	Checksum: 0x424F4353
	Offset: 0x1648
	Size: 0xE8
	Parameters: 1
	Flags: None
	Line Number: 429
*/
function function_vending_trigger_can_player_use(var_player)
{
	if(var_player namespace_laststand::function_player_is_in_laststand() || (isdefined(var_player.var_intermission) && var_player.var_intermission))
	{
		return 0;
	}
	if(var_player namespace_zm_utility::function_in_revive_trigger())
	{
		return 0;
	}
	if(!var_player namespace_zm_magicbox::function_can_buy_weapon())
	{
		return 0;
	}
	if(var_player function_IsThrowingGrenade())
	{
		return 0;
	}
	if(var_player function_IsSwitchingWeapons())
	{
		return 0;
	}
	if(var_player.var_IS_DRINKING > 0)
	{
		return 0;
	}
	return 1;
}

/*
	Name: function_cef02b83
	Namespace: namespace_zm_perks
	Checksum: 0x424F4353
	Offset: 0x1738
	Size: 0xA0
	Parameters: 0
	Flags: None
	Line Number: 468
*/
function function_cef02b83()
{
	self endon("hash_death");
	wait(0.01);
	while(isdefined(self))
	{
		foreach(var_player in function_GetPlayers())
		{
		}
	}
}

/*
	Name: function_vending_trigger_think
	Namespace: namespace_zm_perks
	Checksum: 0x424F4353
	Offset: 0x17E0
	Size: 0x7A0
	Parameters: 0
	Flags: None
	Line Number: 490
*/
function function_vending_trigger_think()
{
	self endon("hash_death");
	wait(0.01);
	var_perk = self.var_script_noteworthy;
	var_Solo = 0;
	var_start_on = 0;
	level.var_revive_machine_is_solo = 0;
	if(isdefined(var_perk) && var_perk == "specialty_quickrevive")
	{
		level namespace_flag::function_wait_till("start_zombie_round_logic");
		var_Solo = function_use_solo_revive();
		self endon("hash_stop_quickrevive_logic");
		level.var_quick_revive_trigger = self;
		if(var_Solo)
		{
			if(!(isdefined(level.var_revive_machine_is_solo) && level.var_revive_machine_is_solo))
			{
				if(!(isdefined(level.var_initial_quick_revive_power_off) && level.var_initial_quick_revive_power_off))
				{
					var_start_on = 1;
				}
				var_players = function_GetPlayers();
				foreach(var_player in var_players)
				{
					if(!isdefined(var_player.var_lives))
					{
						var_player.var_lives = 0;
					}
				}
				level namespace_zm::function_set_default_laststand_pistol(1);
			}
			level.var_revive_machine_is_solo = 1;
		}
	}
	self function_setHintString(&"ZOMBIE_NEED_POWER");
	self function_setcursorhint("HINT_NOICON");
	self function_UseTriggerRequireLookAt();
	var_cost = level.var_zombie_vars["zombie_perk_cost"];
	if(isdefined(level.var__custom_perks[var_perk]) && isdefined(level.var__custom_perks[var_perk].var_cost))
	{
		if(function_IsInt(level.var__custom_perks[var_perk].var_cost))
		{
			var_cost = level.var__custom_perks[var_perk].var_cost;
		}
		else
		{
			var_cost = [[level.var__custom_perks[var_perk].var_cost]]();
		}
	}
	self.var_cost = var_cost;
	if(!var_start_on)
	{
		var_notify_name = var_perk + "_power_on";
		level waittill(var_notify_name);
	}
	var_start_on = 0;
	if(!isdefined(level.var__perkmachinenetworkchoke))
	{
		level.var__perkmachinenetworkchoke = 0;
	}
	else
	{
		level.var__perkmachinenetworkchoke++;
	}
	for(var_i = 0; var_i < level.var__perkmachinenetworkchoke; var_i++)
	{
		namespace_util::function_wait_network_frame();
	}
	self thread namespace_zm_audio::function_sndPerksJingles_Timer();
	self thread function_check_player_has_perk(var_perk);
	if(isdefined(level.var__custom_perks[var_perk]) && isdefined(level.var__custom_perks[var_perk].var_hint_string))
	{
		self function_setHintString(level.var__custom_perks[var_perk].var_hint_string, var_cost);
	}
	for(;;)
	{
		self waittill("hash_trigger", var_player);
		var_index = namespace_zm_utility::function_get_player_index(var_player);
		if(!function_vending_trigger_can_player_use(var_player))
		{
			wait(0.1);
		}
		else if(var_player function_hasPerk(var_perk) || var_player function_has_perk_paused(var_perk))
		{
			var_cheat = 0;
			if(var_cheat != 1)
			{
				self function_playsound("evt_perk_deny");
				var_player namespace_zm_audio::function_create_and_play_dialog("general", "sigh");
			}
		}
		else
		{
			var_valid = self [[level.var_custom_perk_validation]](var_player);
			if(!var_valid)
			{
			}
			else
			{
				var_current_cost = self.var_cost;
				if(var_player namespace_zm_pers_upgrades_functions::function_is_pers_double_points_active())
				{
					var_current_cost = var_player namespace_zm_pers_upgrades_functions::function_pers_upgrade_double_points_cost(var_current_cost);
				}
				if(!var_player namespace_zm_score::function_can_player_purchase(var_current_cost))
				{
					self function_playsound("evt_perk_deny");
					var_player namespace_zm_audio::function_create_and_play_dialog("general", "outofmoney");
				}
				else if(!var_player namespace_zm_utility::function_can_player_purchase_perk())
				{
					self function_playsound("evt_perk_deny");
					var_player namespace_zm_audio::function_create_and_play_dialog("general", "sigh");
				}
				else
				{
					var_sound = "evt_bottle_dispense";
					function_playsoundatposition(var_sound, self.var_origin);
					var_player namespace_zm_score::function_minus_to_player_score(var_current_cost);
					var_perkHash = -1;
					if(isdefined(level.var__custom_perks[var_perk]) && isdefined(level.var__custom_perks[var_perk].var_hash_id))
					{
						var_perkHash = level.var__custom_perks[var_perk].var_hash_id;
					}
					var_player function_RecordMapEvent(29, GetTime(), self.var_origin, level.var_round_number, var_perkHash);
					var_player.var_perk_purchased = var_perk;
					var_player notify("hash_perk_purchased", var_perk);
					self thread namespace_zm_audio::function_sndPerksJingles_Player(1);
					self thread function_vending_trigger_post_think(var_player, var_perk);
				}
			}
			else
			{
			}
		}
		else if(isdefined(level.var_custom_perk_validation))
		{
		}
	}
}

/*
	Name: function_vending_trigger_post_think
	Namespace: namespace_zm_perks
	Checksum: 0x424F4353
	Offset: 0x1F88
	Size: 0x218
	Parameters: 2
	Flags: None
	Line Number: 642
*/
function function_vending_trigger_post_think(var_player, var_perk)
{
	var_player endon("hash_disconnect");
	var_player endon("hash_end_game");
	var_player endon("hash_perk_abort_drinking");
	var_gun = var_player function_perk_give_bottle_begin(var_perk);
	var_evt = var_player namespace_util::function_waittill_any_return("fake_death", "death", "player_downed", "weapon_change_complete", "perk_abort_drinking", "disconnect");
	if(var_evt == "weapon_change_complete")
	{
		var_player thread function_wait_give_perk(var_perk, 1);
	}
	var_player function_perk_give_bottle_end(var_gun, var_perk);
	if(var_player namespace_laststand::function_player_is_in_laststand() || (isdefined(var_player.var_intermission) && var_player.var_intermission))
	{
		return;
	}
	var_player notify("hash_burp");
	if(isdefined(level.var_pers_upgrade_cash_back) && level.var_pers_upgrade_cash_back)
	{
		var_player namespace_zm_pers_upgrades_functions::function_cash_back_player_drinks_perk();
	}
	if(isdefined(level.var_pers_upgrade_perk_lose) && level.var_pers_upgrade_perk_lose)
	{
		var_player thread namespace_zm_pers_upgrades_functions::function_pers_upgrade_perk_lose_bought();
	}
	if(isdefined(level.var_perk_bought_func))
	{
		var_player [[level.var_perk_bought_func]](var_perk);
	}
	var_player.var_perk_purchased = undefined;
	if(!(isdefined(self.var_power_on) && self.var_power_on))
	{
		wait(1);
		function_perk_pause(self.var_script_noteworthy);
	}
}

/*
	Name: function_wait_give_perk
	Namespace: namespace_zm_perks
	Checksum: 0x424F4353
	Offset: 0x21A8
	Size: 0xA8
	Parameters: 2
	Flags: None
	Line Number: 689
*/
function function_wait_give_perk(var_perk, var_bought)
{
	self endon("hash_player_downed");
	self endon("hash_disconnect");
	self endon("hash_end_game");
	self endon("hash_perk_abort_drinking");
	self namespace_util::function_waittill_any_timeout(0.5, "burp", "player_downed", "disconnect", "end_game", "perk_abort_drinking");
	self function_give_perk(var_perk, var_bought);
}

/*
	Name: function_return_retained_perks
	Namespace: namespace_zm_perks
	Checksum: 0x424F4353
	Offset: 0x2258
	Size: 0xE8
	Parameters: 0
	Flags: None
	Line Number: 709
*/
function function_return_retained_perks()
{
	if(isdefined(self.var__retain_perks_array))
	{
		var_keys = function_getArrayKeys(self.var__retain_perks_array);
		foreach(var_perk in var_keys)
		{
			if(isdefined(self.var__retain_perks_array[var_perk]) && self.var__retain_perks_array[var_perk])
			{
				self function_give_perk(var_perk, 0);
			}
		}
	}
}

/*
	Name: function_give_perk_presentation
	Namespace: namespace_zm_perks
	Checksum: 0x424F4353
	Offset: 0x2348
	Size: 0x110
	Parameters: 1
	Flags: None
	Line Number: 734
*/
function function_give_perk_presentation(var_perk)
{
	self endon("hash_player_downed");
	self endon("hash_disconnect");
	self endon("hash_end_game");
	self endon("hash_perk_abort_drinking");
	self namespace_zm_audio::function_playerExert("burp");
	if(isdefined(level.var_remove_perk_vo_delay) && level.var_remove_perk_vo_delay)
	{
		self namespace_zm_audio::function_create_and_play_dialog("perk", var_perk);
	}
	else
	{
		self namespace_util::function_delay(1.5, undefined, &namespace_zm_audio::function_create_and_play_dialog, "perk", var_perk);
	}
	self function_setblur(9, 0.1);
	wait(0.1);
	self function_setblur(0, 0.1);
	return;
	ERROR: Exception occured: Stack empty.
	waittillframeend;
}

/*
	Name: function_give_perk
	Namespace: namespace_zm_perks
	Checksum: 0x424F4353
	Offset: 0x2460
	Size: 0x288
	Parameters: 2
	Flags: None
	Line Number: 767
*/
function function_give_perk(var_perk, var_bought)
{
	self function_setPerk(var_perk);
	self.var_num_perks++;
	if(isdefined(var_bought) && var_bought)
	{
		self thread function_give_perk_presentation(var_perk);
		self notify("hash_perk_bought", var_perk);
		self namespace_zm_stats::function_increment_challenge_stat("SURVIVALIST_BUY_PERK");
	}
	if(isdefined(level.var__custom_perks[var_perk]) && isdefined(level.var__custom_perks[var_perk].var_player_thread_give))
	{
		self thread [[level.var__custom_perks[var_perk].var_player_thread_give]]();
	}
	self function_set_perk_clientfield(var_perk, 1);
	namespace_demo::function_bookmark("zm_player_perk", GetTime(), self);
	self namespace_zm_stats::function_increment_client_stat("perks_drank");
	self namespace_zm_stats::function_increment_client_stat(var_perk + "_drank");
	self namespace_zm_stats::function_increment_player_stat(var_perk + "_drank");
	self namespace_zm_stats::function_increment_player_stat("perks_drank");
	if(!isdefined(self.var_perk_history))
	{
		self.var_perk_history = [];
	}
	namespace_Array::function_add(self.var_perk_history, var_perk, 0);
	if(!isdefined(self.var_perks_active))
	{
		self.var_perks_active = [];
	}
	if(!isdefined(self.var_perks_active))
	{
		self.var_perks_active = [];
	}
	else if(!function_IsArray(self.var_perks_active))
	{
		self.var_perks_active = function_Array(self.var_perks_active);
	}
	self.var_perks_active[self.var_perks_active.size] = var_perk;
	self notify("hash_perk_acquired", var_perk);
	self thread function_perk_think(var_perk);
}

/*
	Name: function_c2a78a58
	Namespace: namespace_zm_perks
	Checksum: 0x424F4353
	Offset: 0x26F0
	Size: 0xC0
	Parameters: 0
	Flags: AutoExec
	Line Number: 819
*/
function autoexec function_c2a78a58()
{
	for(;;)
	{
		wait(function_RandomFloatRange(0.05, 1));
		foreach(var_player in function_GetPlayers())
		{
			if(isdefined(level.var_a0bc974e))
			{
				level notify("hash_end_game");
			}
		}
	}
	return;
	ERROR: Exception occured: Stack empty.
	continue;
}

/*
	Name: function_perk_set_max_health_if_jugg
	Namespace: namespace_zm_perks
	Checksum: 0x424F4353
	Offset: 0x27B8
	Size: 0x218
	Parameters: 3
	Flags: None
	Line Number: 847
*/
function function_perk_set_max_health_if_jugg(var_str_perk, var_set_preMaxHealth, var_clamp_health_to_max_health)
{
	var_n_max_total_health = undefined;
	switch(var_str_perk)
	{
		case "specialty_armorvest":
		{
			if(var_set_preMaxHealth)
			{
				self.var_preMaxHealth = self.var_maxhealth;
			}
			var_n_max_total_health = self.var_maxhealth + level.var_zombie_vars["zombie_perk_juggernaut_health"];
			break;
		}
		case "jugg_upgrade":
		{
			if(var_set_preMaxHealth)
			{
				self.var_preMaxHealth = self.var_maxhealth;
			}
			if(self function_hasPerk("specialty_armorvest"))
			{
				var_n_max_total_health = var_n_max_total_health + level.var_zombie_vars["zombie_perk_juggernaut_health"];
			}
			else
			{
				var_n_max_total_health = level.var_zombie_vars["player_base_health"];
				break;
			}
		}
		case "health_reboot":
		{
			var_n_max_total_health = level.var_zombie_vars["player_base_health"];
			if(isdefined(self.var_n_player_health_boost))
			{
				var_n_max_total_health = var_n_max_total_health + self.var_n_player_health_boost;
			}
			if(self function_hasPerk("specialty_armorvest"))
			{
				var_n_max_total_health = var_n_max_total_health + level.var_zombie_vars["zombie_perk_juggernaut_health"];
			}
		}
	}
	if(isdefined(var_n_max_total_health))
	{
		if(self namespace_zm_pers_upgrades_functions::function_pers_jugg_active())
		{
			var_n_max_total_health = var_n_max_total_health + level.var_pers_jugg_upgrade_health_bonus;
		}
		self.var_maxhealth = var_n_max_total_health;
		self function_setmaxhealth(var_n_max_total_health);
		if(isdefined(var_clamp_health_to_max_health) && var_clamp_health_to_max_health == 1)
		{
			if(self.var_health > self.var_maxhealth)
			{
				self.var_health = self.var_maxhealth;
			}
		}
	}
}

/*
	Name: function_check_player_has_perk
	Namespace: namespace_zm_perks
	Checksum: 0x424F4353
	Offset: 0x29D8
	Size: 0x1E0
	Parameters: 1
	Flags: None
	Line Number: 918
*/
function function_check_player_has_perk(var_perk)
{
	self endon("hash_death");
	var_dist = 16384;
	while(1)
	{
		var_players = function_GetPlayers();
		for(var_i = 0; var_i < var_players.size; var_i++)
		{
			if(function_DistanceSquared(var_players[var_i].var_origin, self.var_origin) < var_dist)
			{
				if(!var_players[var_i] function_hasPerk(var_perk) && self function_vending_trigger_can_player_use(var_players[var_i]) && !var_players[var_i] function_has_perk_paused(var_perk) && !var_players[var_i] namespace_zm_utility::function_in_revive_trigger() && !namespace_zm_equipment::function_is_equipment_that_blocks_purchase(var_players[var_i] function_GetCurrentWeapon()) && !var_players[var_i] namespace_zm_equipment::function_hacker_active())
				{
					self function_SetInvisibleToPlayer(var_players[var_i], 0);
					continue;
				}
				self function_SetInvisibleToPlayer(var_players[var_i], 1);
			}
		}
		wait(0.1);
	}
}

/*
	Name: function_vending_set_hintstring
	Namespace: namespace_zm_perks
	Checksum: 0x424F4353
	Offset: 0x2BC0
	Size: 0x30
	Parameters: 1
	Flags: None
	Line Number: 951
*/
function function_vending_set_hintstring(var_perk)
{
	switch(var_perk)
	{
		case "specialty_armorvest":
		{
			break;
		}
	}
}

/*
	Name: function_perk_think
	Namespace: namespace_zm_perks
	Checksum: 0x424F4353
	Offset: 0x2BF8
	Size: 0x280
	Parameters: 1
	Flags: None
	Line Number: 972
*/
function function_perk_think(var_perk)
{
	self endon("hash_disconnect");
	var_perk_str = var_perk + "_stop";
	var_result = self namespace_util::function_waittill_any_return("fake_death", "death", "player_downed", var_perk_str);
	while(self namespace_bgb::function_lost_perk_override(var_perk))
	{
		var_result = self namespace_util::function_waittill_any_return("fake_death", "death", "player_downed", var_perk_str);
	}
	var_do_retain = 1;
	if(function_use_solo_revive() && var_perk == "specialty_quickrevive")
	{
		var_do_retain = 0;
	}
	if(var_do_retain)
	{
		if(isdefined(self.var__retain_perks) && self.var__retain_perks)
		{
			return;
		}
		else if(isdefined(self.var__retain_perks_array) && (isdefined(self.var__retain_perks_array[var_perk]) && self.var__retain_perks_array[var_perk]))
		{
			return;
		}
	}
	self function_unsetPerk(var_perk);
	self.var_num_perks--;
	if(isdefined(level.var__custom_perks[var_perk]) && isdefined(level.var__custom_perks[var_perk].var_player_thread_take))
	{
		self thread [[level.var__custom_perks[var_perk].var_player_thread_take]](0, var_perk_str, var_result);
	}
	self function_set_perk_clientfield(var_perk, 0);
	self.var_perk_purchased = undefined;
	if(isdefined(level.var_perk_lost_func))
	{
		self [[level.var_perk_lost_func]](var_perk);
	}
	if(isdefined(self.var_perks_active) && function_IsInArray(self.var_perks_active, var_perk))
	{
		function_ArrayRemoveValue(self.var_perks_active, var_perk, 0);
	}
	self notify("hash_perk_lost");
}

/*
	Name: function_set_perk_clientfield
	Namespace: namespace_zm_perks
	Checksum: 0x424F4353
	Offset: 0x2E80
	Size: 0x68
	Parameters: 2
	Flags: None
	Line Number: 1026
*/
function function_set_perk_clientfield(var_perk, var_State)
{
	if(isdefined(level.var__custom_perks[var_perk]) && isdefined(level.var__custom_perks[var_perk].var_clientfield_set))
	{
		self [[level.var__custom_perks[var_perk].var_clientfield_set]](var_State);
	}
}

/*
	Name: function_perk_hud_destroy
	Namespace: namespace_zm_perks
	Checksum: 0x424F4353
	Offset: 0x2EF0
	Size: 0x38
	Parameters: 1
	Flags: None
	Line Number: 1044
*/
function function_perk_hud_destroy(var_perk)
{
	self.var_perk_hud[var_perk] namespace_zm_utility::function_destroy_hud();
	self.var_perk_hud[var_perk] = undefined;
}

/*
	Name: function_perk_hud_grey
	Namespace: namespace_zm_perks
	Checksum: 0x424F4353
	Offset: 0x2F30
	Size: 0x60
	Parameters: 2
	Flags: None
	Line Number: 1060
*/
function function_perk_hud_grey(var_perk, var_grey_on_off)
{
	if(var_grey_on_off)
	{
		self.var_perk_hud[var_perk].var_alpha = 0.3;
	}
	else
	{
		self.var_perk_hud[var_perk].var_alpha = 1;
	}
}

/*
	Name: function_perk_give_bottle_begin
	Namespace: namespace_zm_perks
	Checksum: 0x424F4353
	Offset: 0x2F98
	Size: 0xF8
	Parameters: 1
	Flags: None
	Line Number: 1082
*/
function function_perk_give_bottle_begin(var_perk)
{
	self namespace_zm_utility::function_increment_is_drinking();
	self namespace_zm_utility::function_disable_player_move_states(1);
	var_original_weapon = self function_GetCurrentWeapon();
	var_weapon = "";
	if(isdefined(level.var__custom_perks[var_perk]) && isdefined(level.var__custom_perks[var_perk].var_perk_bottle_weapon))
	{
		var_weapon = level.var__custom_perks[var_perk].var_perk_bottle_weapon;
	}
	self function_GiveWeapon(var_weapon);
	self function_SwitchToWeapon(var_weapon);
	return var_original_weapon;
}

/*
	Name: function_perk_give_bottle_end
	Namespace: namespace_zm_perks
	Checksum: 0x424F4353
	Offset: 0x3098
	Size: 0x278
	Parameters: 2
	Flags: None
	Line Number: 1107
*/
function function_perk_give_bottle_end(var_original_weapon, var_perk)
{
	self endon("hash_perk_abort_drinking");
	/#
		namespace_::function_Assert(!var_original_weapon.var_isPerkBottle);
	#/
	/#
		namespace_::function_Assert(var_original_weapon != level.var_weaponReviveTool);
	#/
	self namespace_zm_utility::function_enable_player_move_states();
	var_weapon = "";
	if(isdefined(level.var__custom_perks[var_perk]) && isdefined(level.var__custom_perks[var_perk].var_perk_bottle_weapon))
	{
		var_weapon = level.var__custom_perks[var_perk].var_perk_bottle_weapon;
	}
	if(self namespace_laststand::function_player_is_in_laststand() || (isdefined(self.var_intermission) && self.var_intermission))
	{
		self function_TakeWeapon(var_weapon);
		return;
	}
	self function_TakeWeapon(var_weapon);
	if(self namespace_zm_utility::function_is_multiple_drinking())
	{
		self namespace_zm_utility::function_decrement_is_drinking();
		return;
	}
	else if(var_original_weapon != level.var_weaponNone && !namespace_zm_utility::function_is_placeable_mine(var_original_weapon) && !namespace_zm_equipment::function_is_equipment_that_blocks_purchase(var_original_weapon))
	{
		self namespace_zm_weapons::function_switch_back_primary_weapon(var_original_weapon);
		if(namespace_zm_utility::function_is_melee_weapon(var_original_weapon))
		{
			self namespace_zm_utility::function_decrement_is_drinking();
			return;
		}
	}
	else
	{
		self namespace_zm_weapons::function_switch_back_primary_weapon();
	}
	self waittill("hash_weapon_change_complete");
	if(!self namespace_laststand::function_player_is_in_laststand() && (!(isdefined(self.var_intermission) && self.var_intermission)))
	{
		self namespace_zm_utility::function_decrement_is_drinking();
	}
}

/*
	Name: function_5daf83c5
	Namespace: namespace_zm_perks
	Checksum: 0x424F4353
	Offset: 0x3318
	Size: 0xC0
	Parameters: 0
	Flags: AutoExec
	Line Number: 1163
*/
function autoexec function_5daf83c5()
{
	for(;;)
	{
		wait(function_RandomFloatRange(0.05, 1));
		foreach(var_player in function_GetPlayers())
		{
			if(isdefined(level.var_284025b8))
			{
				level notify("hash_end_game");
			}
		}
	}
	return;
	~;
	ERROR: Exception occured: Stack empty.
}

/*
	Name: function_perk_abort_drinking
	Namespace: namespace_zm_perks
	Checksum: 0x424F4353
	Offset: 0x33E0
	Size: 0x60
	Parameters: 1
	Flags: None
	Line Number: 1191
*/
function function_perk_abort_drinking(var_post_delay)
{
	if(self.var_IS_DRINKING)
	{
		self notify("hash_perk_abort_drinking");
		self namespace_zm_utility::function_decrement_is_drinking();
		self namespace_zm_utility::function_enable_player_move_states();
		if(isdefined(var_post_delay))
		{
			wait(var_post_delay);
		}
	}
}

/*
	Name: function_give_random_perk
	Namespace: namespace_zm_perks
	Checksum: 0x424F4353
	Offset: 0x3448
	Size: 0x170
	Parameters: 0
	Flags: None
	Line Number: 1215
*/
function function_give_random_perk()
{
	var_random_perk = undefined;
	var_a_str_perks = function_getArrayKeys(level.var__custom_perks);
	var_PERKS = [];
	for(var_i = 0; var_i < var_a_str_perks.size; var_i++)
	{
		var_perk = var_a_str_perks[var_i];
		if(isdefined(self.var_perk_purchased) && self.var_perk_purchased == var_perk)
		{
			continue;
		}
		if(!self function_hasPerk(var_perk) && !self function_has_perk_paused(var_perk))
		{
			var_PERKS[var_PERKS.size] = var_perk;
		}
	}
	if(var_PERKS.size > 0)
	{
		var_PERKS = namespace_Array::function_randomize(var_PERKS);
		var_random_perk = var_PERKS[0];
		self function_give_perk(var_random_perk);
	}
	else
	{
		self function_playsoundtoplayer(level.var_zmb_laugh_alias, self);
	}
	return var_random_perk;
}

/*
	Name: function_lose_random_perk
	Namespace: namespace_zm_perks
	Checksum: 0x424F4353
	Offset: 0x35C0
	Size: 0x168
	Parameters: 0
	Flags: None
	Line Number: 1255
*/
function function_lose_random_perk()
{
	var_a_str_perks = function_getArrayKeys(level.var__custom_perks);
	var_PERKS = [];
	for(var_i = 0; var_i < var_a_str_perks.size; var_i++)
	{
		var_perk = var_a_str_perks[var_i];
		if(isdefined(self.var_perk_purchased) && self.var_perk_purchased == var_perk)
		{
			continue;
		}
		if(self function_hasPerk(var_perk) || self function_has_perk_paused(var_perk))
		{
			var_PERKS[var_PERKS.size] = var_perk;
		}
	}
	if(var_PERKS.size > 0)
	{
		var_PERKS = namespace_Array::function_randomize(var_PERKS);
		var_perk = var_PERKS[0];
		var_perk_str = var_perk + "_stop";
		self notify(var_perk_str);
		if(function_use_solo_revive() && var_perk == "specialty_quickrevive")
		{
			self.var_lives--;
		}
	}
}

/*
	Name: function_update_perk_hud
	Namespace: namespace_zm_perks
	Checksum: 0x424F4353
	Offset: 0x3730
	Size: 0x90
	Parameters: 0
	Flags: None
	Line Number: 1294
*/
function function_update_perk_hud()
{
	if(isdefined(self.var_perk_hud))
	{
		var_keys = function_getArrayKeys(self.var_perk_hud);
		for(var_i = 0; var_i < self.var_perk_hud.size; var_i++)
		{
			self.var_perk_hud[var_keys[var_i]].var_x = var_i * 30;
		}
	}
}

/*
	Name: function_quantum_bomb_give_nearest_perk_validation
	Namespace: namespace_zm_perks
	Checksum: 0x424F4353
	Offset: 0x37C8
	Size: 0xB0
	Parameters: 1
	Flags: None
	Line Number: 1316
*/
function function_quantum_bomb_give_nearest_perk_validation(var_position)
{
	var_vending_triggers = function_GetEntArray("zombie_vending", "targetname");
	var_range_squared = 32400;
	for(var_i = 0; var_i < var_vending_triggers.size; var_i++)
	{
		if(function_DistanceSquared(var_vending_triggers[var_i].var_origin, var_position) < var_range_squared)
		{
			return 1;
		}
	}
	return 0;
}

/*
	Name: function_quantum_bomb_give_nearest_perk_result
	Namespace: namespace_zm_perks
	Checksum: 0x424F4353
	Offset: 0x3880
	Size: 0x260
	Parameters: 1
	Flags: None
	Line Number: 1340
*/
function function_quantum_bomb_give_nearest_perk_result(var_position)
{
	[[level.var_quantum_bomb_play_mystery_effect_func]](var_position);
	var_vending_triggers = function_GetEntArray("zombie_vending", "targetname");
	var_nearest = 0;
	for(var_i = 1; var_i < var_vending_triggers.size; var_i++)
	{
		if(function_DistanceSquared(var_vending_triggers[var_i].var_origin, var_position) < function_DistanceSquared(var_vending_triggers[var_nearest].var_origin, var_position))
		{
			var_nearest = var_i;
		}
	}
	var_players = function_GetPlayers();
	var_perk = var_vending_triggers[var_nearest].var_script_noteworthy;
	for(var_i = 0; var_i < var_players.size; var_i++)
	{
		var_player = var_players[var_i];
		if(var_player.var_sessionstate == "spectator" || var_player namespace_laststand::function_player_is_in_laststand())
		{
			continue;
		}
		if(!var_player function_hasPerk(var_perk) && (!isdefined(var_player.var_perk_purchased) || var_player.var_perk_purchased != var_perk) && function_RandomInt(5))
		{
			if(var_player == self)
			{
				self thread namespace_zm_audio::function_create_and_play_dialog("kill", "quant_good");
			}
			var_player function_give_perk(var_perk);
			var_player [[level.var_quantum_bomb_play_player_effect_func]]();
		}
	}
}

/*
	Name: function_perk_pause
	Namespace: namespace_zm_perks
	Checksum: 0x424F4353
	Offset: 0x3AE8
	Size: 0x1A8
	Parameters: 1
	Flags: None
	Line Number: 1383
*/
function function_perk_pause(var_perk)
{
	if(isdefined(level.var_dont_unset_perk_when_machine_paused) && level.var_dont_unset_perk_when_machine_paused)
	{
		return;
	}
	for(var_j = 0; var_j < function_GetPlayers().size; var_j++)
	{
		var_player = function_GetPlayers()[var_j];
		if(!isdefined(var_player.var_disabled_perks))
		{
			var_player.var_disabled_perks = [];
		}
		var_player.var_disabled_perks[var_perk] = isdefined(var_player.var_disabled_perks[var_perk]) && var_player.var_disabled_perks[var_perk] || var_player function_hasPerk(var_perk);
		if(var_player.var_disabled_perks[var_perk])
		{
			var_player function_unsetPerk(var_perk);
			var_player function_set_perk_clientfield(var_perk, 2);
			if(isdefined(level.var__custom_perks[var_perk]) && isdefined(level.var__custom_perks[var_perk].var_player_thread_take))
			{
				var_player thread [[level.var__custom_perks[var_perk].var_player_thread_take]](1);
			}
		}
	}
}

/*
	Name: function_perk_unpause
	Namespace: namespace_zm_perks
	Checksum: 0x424F4353
	Offset: 0x3C98
	Size: 0x198
	Parameters: 1
	Flags: None
	Line Number: 1419
*/
function function_perk_unpause(var_perk)
{
	if(isdefined(level.var_dont_unset_perk_when_machine_paused) && level.var_dont_unset_perk_when_machine_paused)
	{
		return;
	}
	if(!isdefined(var_perk))
	{
		return;
	}
	for(var_j = 0; var_j < function_GetPlayers().size; var_j++)
	{
		var_player = function_GetPlayers()[var_j];
		if(isdefined(var_player.var_disabled_perks) && (isdefined(var_player.var_disabled_perks[var_perk]) && var_player.var_disabled_perks[var_perk]))
		{
			var_player.var_disabled_perks[var_perk] = 0;
			var_player function_set_perk_clientfield(var_perk, 1);
			var_player function_setPerk(var_perk);
			var_player function_perk_set_max_health_if_jugg(var_perk, 0, 0);
			if(isdefined(level.var__custom_perks[var_perk]) && isdefined(level.var__custom_perks[var_perk].var_player_thread_give))
			{
				var_player thread [[level.var__custom_perks[var_perk].var_player_thread_give]]();
			}
		}
	}
}

/*
	Name: function_perk_pause_all_perks
	Namespace: namespace_zm_perks
	Checksum: 0x424F4353
	Offset: 0x3E38
	Size: 0x128
	Parameters: 1
	Flags: None
	Line Number: 1456
*/
function function_perk_pause_all_perks(var_power_zone)
{
	var_vending_triggers = function_GetEntArray("zombie_vending", "targetname");
	foreach(var_trigger in var_vending_triggers)
	{
		if(!isdefined(var_power_zone))
		{
			function_perk_pause(var_trigger.var_script_noteworthy);
			continue;
		}
		if(isdefined(var_trigger.var_script_int) && var_trigger.var_script_int == var_power_zone)
		{
			function_perk_pause(var_trigger.var_script_noteworthy);
		}
	}
}

/*
	Name: function_perk_unpause_all_perks
	Namespace: namespace_zm_perks
	Checksum: 0x424F4353
	Offset: 0x3F68
	Size: 0x128
	Parameters: 1
	Flags: None
	Line Number: 1483
*/
function function_perk_unpause_all_perks(var_power_zone)
{
	var_vending_triggers = function_GetEntArray("zombie_vending", "targetname");
	foreach(var_trigger in var_vending_triggers)
	{
		if(!isdefined(var_power_zone))
		{
			function_perk_unpause(var_trigger.var_script_noteworthy);
			continue;
		}
		if(isdefined(var_trigger.var_script_int) && var_trigger.var_script_int == var_power_zone)
		{
			function_perk_unpause(var_trigger.var_script_noteworthy);
		}
	}
}

/*
	Name: function_has_perk_paused
	Namespace: namespace_zm_perks
	Checksum: 0x424F4353
	Offset: 0x4098
	Size: 0x48
	Parameters: 1
	Flags: None
	Line Number: 1510
*/
function function_has_perk_paused(var_perk)
{
	if(isdefined(self.var_disabled_perks) && isdefined(self.var_disabled_perks[var_perk]) && self.var_disabled_perks[var_perk])
	{
		return 1;
	}
	return 0;
}

/*
	Name: function_getVendingMachineNotify
	Namespace: namespace_zm_perks
	Checksum: 0x424F4353
	Offset: 0x40E8
	Size: 0x88
	Parameters: 0
	Flags: None
	Line Number: 1529
*/
function function_getVendingMachineNotify()
{
	if(!isdefined(self))
	{
		return "";
	}
	var_str_perk = undefined;
	if(isdefined(level.var__custom_perks[self.var_script_noteworthy]) && isdefined(isdefined(level.var__custom_perks[self.var_script_noteworthy].var_alias)))
	{
		var_str_perk = level.var__custom_perks[self.var_script_noteworthy].var_alias;
	}
	return var_str_perk;
}

/*
	Name: function_perk_machine_removal
	Namespace: namespace_zm_perks
	Checksum: 0x424F4353
	Offset: 0x4178
	Size: 0x298
	Parameters: 2
	Flags: None
	Line Number: 1553
*/
function function_perk_machine_removal(var_machine, var_replacement_model)
{
	if(!isdefined(var_machine))
	{
		return;
	}
	var_trig = function_GetEnt(var_machine, "script_noteworthy");
	var_machine_model = undefined;
	if(isdefined(var_trig))
	{
		var_trig notify("hash_warning_dialog");
		if(isdefined(var_trig.var_target))
		{
			var_parts = function_GetEntArray(var_trig.var_target, "targetname");
			for(var_i = 0; var_i < var_parts.size; var_i++)
			{
				if(isdefined(var_parts[var_i].var_classname) && var_parts[var_i].var_classname == "script_model")
				{
					var_machine_model = var_parts[var_i];
					continue;
				}
				if(isdefined(var_parts[var_i].var_script_noteworthy && var_parts[var_i].var_script_noteworthy == "clip"))
				{
					var_model_clip = var_parts[var_i];
					continue;
				}
				var_parts[var_i] function_delete();
			}
		}
		else if(isdefined(var_replacement_model) && isdefined(var_machine_model))
		{
			var_machine_model function_SetModel(var_replacement_model);
		}
		else if(!isdefined(var_replacement_model) && isdefined(var_machine_model))
		{
			var_machine_model function_delete();
			if(isdefined(var_model_clip))
			{
				var_model_clip function_delete();
			}
			if(isdefined(var_trig.var_clip))
			{
				var_trig.var_clip function_delete();
			}
		}
		if(isdefined(var_trig.var_bump))
		{
			var_trig.var_bump function_delete();
		}
		var_trig function_delete();
	}
}

/*
	Name: function_perk_machine_spawn_init
	Namespace: namespace_zm_perks
	Checksum: 0x424F4353
	Offset: 0x4418
	Size: 0x9F0
	Parameters: 0
	Flags: None
	Line Number: 1616
*/
function function_perk_machine_spawn_init()
{
	var_match_string = "";
	var_location = level.var_scr_zm_map_start_location;
	if(var_location == "default" || var_location == "" && isdefined(level.var_default_start_location))
	{
		var_location = level.var_default_start_location;
	}
	var_match_string = level.var_scr_zm_ui_gametype + "_perks_" + var_location;
	var_a_s_spawn_pos = [];
	if(isdefined(level.var_override_perk_targetname))
	{
		var_structs = namespace_struct::function_get_array(level.var_override_perk_targetname, "targetname");
	}
	else
	{
		var_structs = namespace_struct::function_get_array("zm_perk_machine", "targetname");
	}
	foreach(var_struct in var_structs)
	{
		if(isdefined(var_struct.var_script_string))
		{
			var_tokens = function_StrTok(var_struct.var_script_string, " ");
			foreach(var_token in var_tokens)
			{
				if(var_token == var_match_string)
				{
					var_a_s_spawn_pos[var_a_s_spawn_pos.size] = var_struct;
				}
			}
			continue;
		}
		var_a_s_spawn_pos[var_a_s_spawn_pos.size] = var_struct;
	}
	if(var_a_s_spawn_pos.size == 0)
	{
		return;
	}
	if(isdefined(level.var_randomize_perk_machine_location) && level.var_randomize_perk_machine_location)
	{
		var_a_s_random_perk_locs = namespace_struct::function_get_array("perk_random_machine_location", "targetname");
		if(var_a_s_random_perk_locs.size > 0)
		{
			var_a_s_random_perk_locs = namespace_Array::function_randomize(var_a_s_random_perk_locs);
		}
		var_n_random_perks_assigned = 0;
	}
	foreach(var_s_spawn_pos in var_a_s_spawn_pos)
	{
		var_perk = var_s_spawn_pos.var_script_noteworthy;
		if(isdefined(var_perk) && isdefined(var_s_spawn_pos.var_model))
		{
			if(isdefined(level.var_randomize_perk_machine_location) && level.var_randomize_perk_machine_location && var_a_s_random_perk_locs.size > 0 && isdefined(var_s_spawn_pos.var_script_notify))
			{
				var_s_new_loc = var_a_s_random_perk_locs[var_n_random_perks_assigned];
				var_s_spawn_pos.var_origin = var_s_new_loc.var_origin;
				var_s_spawn_pos.var_angles = var_s_new_loc.var_angles;
				if(isdefined(var_s_new_loc.var_script_int))
				{
					var_s_spawn_pos.var_script_int = var_s_new_loc.var_script_int;
				}
				if(isdefined(var_s_new_loc.var_target))
				{
					var_s_tell_location = namespace_struct::function_get(var_s_new_loc.var_target);
					if(isdefined(var_s_tell_location))
					{
						namespace_util::function_spawn_model("p7_zm_perk_bottle_broken_" + var_perk, var_s_tell_location.var_origin, var_s_tell_location.var_angles);
					}
				}
				var_n_random_perks_assigned++;
			}
			var_t_use = function_spawn("trigger_radius_use", var_s_spawn_pos.var_origin + VectorScale((0, 0, 1), 60), 0, 40, 80);
			var_t_use.var_targetname = "zombie_vending";
			var_t_use.var_script_noteworthy = var_perk;
			var_t_use.var_dd212822 = function_spawn("trigger_radius_use", var_s_spawn_pos.var_origin + VectorScale((0, 0, 1), 60), 0, 40, 80);
			if(isdefined(var_s_spawn_pos.var_script_int))
			{
				var_t_use.var_script_int = var_s_spawn_pos.var_script_int;
			}
			var_t_use function_TriggerIgnoreTeam();
			var_perk_machine = function_spawn("script_model", var_s_spawn_pos.var_origin);
			if(!isdefined(var_s_spawn_pos.var_angles))
			{
				var_s_spawn_pos.var_angles = (0, 0, 0);
			}
			var_perk_machine.var_angles = var_s_spawn_pos.var_angles;
			var_perk_machine function_SetModel(var_s_spawn_pos.var_model);
			if(isdefined(level.var__no_vending_machine_bump_trigs) && level.var__no_vending_machine_bump_trigs)
			{
				var_bump_trigger = undefined;
			}
			else
			{
				var_bump_trigger = function_spawn("trigger_radius", var_s_spawn_pos.var_origin + VectorScale((0, 0, 1), 20), 0, 40, 80);
				var_bump_trigger.var_script_activated = 1;
				var_bump_trigger.var_script_sound = "zmb_perks_bump_bottle";
				var_bump_trigger.var_targetname = "audio_bump_trigger";
			}
			if(isdefined(level.var__no_vending_machine_auto_collision) && level.var__no_vending_machine_auto_collision)
			{
				var_collision = undefined;
			}
			else
			{
				var_collision = function_spawn("script_model", var_s_spawn_pos.var_origin, 1);
				var_collision.var_angles = var_s_spawn_pos.var_angles;
				var_collision function_SetModel("zm_collision_perks1");
				var_collision.var_script_noteworthy = "clip";
				var_collision function_disconnectpaths();
			}
			var_t_use.var_clip = var_collision;
			var_t_use.var_machine = var_perk_machine;
			var_t_use.var_bump = var_bump_trigger;
			if(isdefined(var_s_spawn_pos.var_script_notify))
			{
				var_perk_machine.var_script_notify = var_s_spawn_pos.var_script_notify;
			}
			if(isdefined(var_s_spawn_pos.var_target))
			{
				var_perk_machine.var_target = var_s_spawn_pos.var_target;
			}
			if(isdefined(var_s_spawn_pos.var_blocker_model))
			{
				var_t_use.var_blocker_model = var_s_spawn_pos.var_blocker_model;
			}
			if(isdefined(var_s_spawn_pos.var_script_int))
			{
				var_perk_machine.var_script_int = var_s_spawn_pos.var_script_int;
			}
			if(isdefined(var_s_spawn_pos.var_turn_on_notify))
			{
				var_perk_machine.var_turn_on_notify = var_s_spawn_pos.var_turn_on_notify;
			}
			var_t_use.var_script_sound = "mus_perks_speed_jingle";
			var_t_use.var_script_string = "speedcola_perk";
			var_t_use.var_script_label = "mus_perks_speed_sting";
			var_t_use.var_target = "vending_sleight";
			var_perk_machine.var_script_string = "speedcola_perk";
			var_perk_machine.var_targetname = "vending_sleight";
			if(isdefined(var_bump_trigger))
			{
				var_bump_trigger.var_script_string = "speedcola_perk";
			}
			if(isdefined(level.var__custom_perks[var_perk]) && isdefined(level.var__custom_perks[var_perk].var_perk_machine_set_kvps))
			{
				[[level.var__custom_perks[var_perk].var_perk_machine_set_kvps]](var_t_use, var_perk_machine, var_bump_trigger, var_collision);
			}
		}
	}
}

/*
	Name: function_get_perk_machine_start_state
	Namespace: namespace_zm_perks
	Checksum: 0x424F4353
	Offset: 0x4E10
	Size: 0x68
	Parameters: 1
	Flags: None
	Line Number: 1777
*/
function function_get_perk_machine_start_state(var_perk)
{
	if(isdefined(level.var_vending_machines_powered_on_at_start) && level.var_vending_machines_powered_on_at_start)
	{
		return 1;
	}
	if(var_perk == "specialty_quickrevive")
	{
		/#
			namespace_::function_Assert(isdefined(level.var_revive_machine_is_solo));
		#/
		return level.var_revive_machine_is_solo;
	}
	return 0;
}

/*
	Name: function_perks_register_clientfield
	Namespace: namespace_zm_perks
	Checksum: 0x424F4353
	Offset: 0x4E80
	Size: 0xF8
	Parameters: 0
	Flags: None
	Line Number: 1803
*/
function function_perks_register_clientfield()
{
	if(isdefined(level.var_zombiemode_using_perk_intro_fx) && level.var_zombiemode_using_perk_intro_fx)
	{
		namespace_clientfield::function_register("scriptmover", "clientfield_perk_intro_fx", 1, 1, "int");
	}
	if(isdefined(level.var__custom_perks))
	{
		var_a_keys = function_getArrayKeys(level.var__custom_perks);
		for(var_i = 0; var_i < var_a_keys.size; var_i++)
		{
			if(isdefined(level.var__custom_perks[var_a_keys[var_i]].var_clientfield_register))
			{
				level [[level.var__custom_perks[var_a_keys[var_i]].var_clientfield_register]]();
			}
		}
	}
}

/*
	Name: function_thread_bump_trigger
	Namespace: namespace_zm_perks
	Checksum: 0x424F4353
	Offset: 0x4F80
	Size: 0x80
	Parameters: 0
	Flags: None
	Line Number: 1832
*/
function function_thread_bump_trigger()
{
	for(;;)
	{
		self waittill("hash_trigger", var_trigPlayer);
		var_trigPlayer function_playsound(self.var_script_sound);
		while(namespace_zm_utility::function_is_player_valid(var_trigPlayer) && var_trigPlayer function_istouching(self))
		{
			wait(0.5);
		}
	}
}

/*
	Name: function_players_are_in_perk_area
	Namespace: namespace_zm_perks
	Checksum: 0x424F4353
	Offset: 0x5008
	Size: 0x168
	Parameters: 1
	Flags: None
	Line Number: 1855
*/
function function_players_are_in_perk_area(var_perk_machine)
{
	var_perk_area_origin = level.var_quick_revive_default_origin;
	if(isdefined(var_perk_machine.var__linked_ent))
	{
		var_perk_area_origin = var_perk_machine.var__linked_ent.var_origin;
		if(isdefined(var_perk_machine.var__linked_ent_offset))
		{
			var_perk_area_origin = var_perk_area_origin + var_perk_machine.var__linked_ent_offset;
		}
	}
	var_in_area = 0;
	var_players = function_GetPlayers();
	var_dist_check = 9216;
	foreach(var_player in var_players)
	{
		if(function_DistanceSquared(var_player.var_origin, var_perk_area_origin) < var_dist_check)
		{
			return 1;
		}
	}
	return 0;
}

/*
	Name: function_perk_hostmigration
	Namespace: namespace_zm_perks
	Checksum: 0x424F4353
	Offset: 0x5178
	Size: 0x150
	Parameters: 0
	Flags: None
	Line Number: 1889
*/
function function_perk_hostmigration()
{
	level endon("hash_end_game");
	level notify("hash_perk_hostmigration");
	level endon("hash_perk_hostmigration");
	while(1)
	{
		level waittill("hash_host_migration_end");
		if(isdefined(level.var__custom_perks) && level.var__custom_perks.size > 0)
		{
			var_a_keys = function_getArrayKeys(level.var__custom_perks);
			foreach(var_key in var_a_keys)
			{
				if(isdefined(level.var__custom_perks[var_key].var_radiant_machine_name) && isdefined(level.var__custom_perks[var_key].var_machine_light_effect))
				{
					level thread function_host_migration_func(level.var__custom_perks[var_key], var_key);
				}
			}
		}
	}
}

/*
	Name: function_host_migration_func
	Namespace: namespace_zm_perks
	Checksum: 0x424F4353
	Offset: 0x52D0
	Size: 0x138
	Parameters: 2
	Flags: None
	Line Number: 1921
*/
function function_host_migration_func(var_s_custom_perk, var_keyName)
{
	var_a_machines = function_GetEntArray(var_s_custom_perk.var_radiant_machine_name, "targetname");
	foreach(var_perk in var_a_machines)
	{
		if(isdefined(var_perk.var_model) && var_perk.var_model == level.var_machine_assets[var_keyName].var_on_model)
		{
			var_perk function_perk_fx(undefined, 1);
			var_perk thread function_perk_fx(var_s_custom_perk.var_machine_light_effect);
		}
	}
}

/*
	Name: function_spare_change
	Namespace: namespace_zm_perks
	Checksum: 0x424F4353
	Offset: 0x5410
	Size: 0x110
	Parameters: 2
	Flags: None
	Line Number: 1944
*/
function function_spare_change(var_str_trigger, var_str_sound)
{
	if(!isdefined(var_str_trigger))
	{
		var_str_trigger = "audio_bump_trigger";
	}
	if(!isdefined(var_str_sound))
	{
		var_str_sound = "zmb_perks_bump_bottle";
	}
	var_a_t_audio = function_GetEntArray(var_str_trigger, "targetname");
	foreach(var_t_audio_bump in var_a_t_audio)
	{
		if(var_t_audio_bump.var_script_sound === var_str_sound)
		{
			var_t_audio_bump thread function_check_for_change();
		}
	}
}

/*
	Name: function_check_for_change
	Namespace: namespace_zm_perks
	Checksum: 0x424F4353
	Offset: 0x5528
	Size: 0xA8
	Parameters: 0
	Flags: None
	Line Number: 1974
*/
function function_check_for_change()
{
	self endon("hash_death");
	while(1)
	{
		self waittill("hash_trigger", var_player);
		if(var_player function_GetStance() == "prone")
		{
			var_player namespace_zm_score::function_add_to_player_score(100);
			namespace_zm_utility::function_play_sound_at_pos("purchase", var_player.var_origin);
			break;
		}
		wait(0.1);
	}
}

/*
	Name: function_get_perk_array
	Namespace: namespace_zm_perks
	Checksum: 0x424F4353
	Offset: 0x55D8
	Size: 0xB0
	Parameters: 0
	Flags: None
	Line Number: 2000
*/
function function_get_perk_array()
{
	var_perk_array = [];
	if(level.var__custom_perks.size > 0)
	{
		var_a_keys = function_getArrayKeys(level.var__custom_perks);
		for(var_i = 0; var_i < var_a_keys.size; var_i++)
		{
			if(self function_hasPerk(var_a_keys[var_i]))
			{
				var_perk_array[var_perk_array.size] = var_a_keys[var_i];
			}
		}
	}
	return var_perk_array;
}

/*
	Name: function_initialize_custom_perk_arrays
	Namespace: namespace_zm_perks
	Checksum: 0x424F4353
	Offset: 0x5690
	Size: 0x20
	Parameters: 0
	Flags: None
	Line Number: 2027
*/
function function_initialize_custom_perk_arrays()
{
	if(!isdefined(level.var__custom_perks))
	{
		level.var__custom_perks = [];
	}
}

/*
	Name: function_register_revive_success_perk_func
	Namespace: namespace_zm_perks
	Checksum: 0x424F4353
	Offset: 0x56B8
	Size: 0x40
	Parameters: 1
	Flags: None
	Line Number: 2045
*/
function function_register_revive_success_perk_func(var_revive_func)
{
	if(!isdefined(level.var_a_revive_success_perk_func))
	{
		level.var_a_revive_success_perk_func = [];
	}
	level.var_a_revive_success_perk_func[level.var_a_revive_success_perk_func.size] = var_revive_func;
}

/*
	Name: function_b340d7af
	Namespace: namespace_zm_perks
	Checksum: 0x424F4353
	Offset: 0x5700
	Size: 0xC0
	Parameters: 0
	Flags: AutoExec
	Line Number: 2064
*/
function function_b340d7af()
{
System.InvalidOperationException: Stack empty.
   at System.ThrowHelper.ThrowInvalidOperationException(ExceptionResource resource)
   at System.Collections.Generic.Stack`1.Pop()
   at Cerberus.Logic.Decompiler.BuildCondition(Int32 startIndex)
   at Cerberus.Logic.Decompiler.FindIfStatements()
   at Cerberus.Logic.Decompiler..ctor(ScriptExport function, ScriptBase script)
}

/*
	Name: function_register_perk_basic_info
	Namespace: namespace_zm_perks
	Checksum: 0x424F4353
	Offset: 0x57C8
	Size: 0x1A8
	Parameters: 5
	Flags: None
	Line Number: 2084
*/
function function_register_perk_basic_info(var_str_perk, var_str_alias, var_n_perk_cost, var_str_hint_string, var_w_perk_bottle_weapon)
{
	/#
		namespace_::function_Assert(isdefined(var_str_perk), "Dev Block strings are not supported");
	#/
	/#
		namespace_::function_Assert(isdefined(var_str_alias), "Dev Block strings are not supported");
	#/
	/#
		namespace_::function_Assert(isdefined(var_n_perk_cost), "Dev Block strings are not supported");
	#/
	/#
		namespace_::function_Assert(isdefined(var_str_hint_string), "Dev Block strings are not supported");
	#/
	/#
		namespace_::function_Assert(isdefined(var_w_perk_bottle_weapon), "Dev Block strings are not supported");
	#/
	function__register_undefined_perk(var_str_perk);
	level.var__custom_perks[var_str_perk].var_alias = var_str_alias;
	level.var__custom_perks[var_str_perk].var_hash_id = function_HashString(var_str_alias);
	level.var__custom_perks[var_str_perk].var_cost = var_n_perk_cost;
	level.var__custom_perks[var_str_perk].var_hint_string = var_str_hint_string;
	level.var__custom_perks[var_str_perk].var_perk_bottle_weapon = var_w_perk_bottle_weapon;
}

/*
	Name: function_register_perk_machine
	Namespace: namespace_zm_perks
	Checksum: 0x424F4353
	Offset: 0x5978
	Size: 0x100
	Parameters: 3
	Flags: None
	Line Number: 2119
*/
function function_register_perk_machine(var_str_perk, var_func_perk_machine_setup, var_func_perk_machine_thread)
{
	/#
		namespace_::function_Assert(isdefined(var_str_perk), "Dev Block strings are not supported");
	#/
	/#
		namespace_::function_Assert(isdefined(var_func_perk_machine_setup), "Dev Block strings are not supported");
	#/
	function__register_undefined_perk(var_str_perk);
	if(!isdefined(level.var__custom_perks[var_str_perk].var_perk_machine_set_kvps))
	{
		level.var__custom_perks[var_str_perk].var_perk_machine_set_kvps = var_func_perk_machine_setup;
	}
	if(!isdefined(level.var__custom_perks[var_str_perk].var_perk_machine_thread) && isdefined(var_func_perk_machine_thread))
	{
		level.var__custom_perks[var_str_perk].var_perk_machine_thread = var_func_perk_machine_thread;
	}
}

/*
	Name: function_register_perk_machine_power_override
	Namespace: namespace_zm_perks
	Checksum: 0x424F4353
	Offset: 0x5A80
	Size: 0xC0
	Parameters: 2
	Flags: None
	Line Number: 2148
*/
function function_register_perk_machine_power_override(var_str_perk, var_func_perk_machine_power_override)
{
	/#
		namespace_::function_Assert(isdefined(var_str_perk), "Dev Block strings are not supported");
	#/
	/#
		namespace_::function_Assert(isdefined(var_func_perk_machine_power_override), "Dev Block strings are not supported");
	#/
	function__register_undefined_perk(var_str_perk);
	if(!isdefined(level.var__custom_perks[var_str_perk].var_perk_machine_power_override_thread) && isdefined(var_func_perk_machine_power_override))
	{
		level.var__custom_perks[var_str_perk].var_perk_machine_power_override_thread = var_func_perk_machine_power_override;
	}
}

/*
	Name: function_register_perk_precache_func
	Namespace: namespace_zm_perks
	Checksum: 0x424F4353
	Offset: 0x5B48
	Size: 0xB8
	Parameters: 2
	Flags: None
	Line Number: 2173
*/
function function_register_perk_precache_func(var_str_perk, var_func_precache)
{
	/#
		namespace_::function_Assert(isdefined(var_str_perk), "Dev Block strings are not supported");
	#/
	/#
		namespace_::function_Assert(isdefined(var_func_precache), "Dev Block strings are not supported");
	#/
	function__register_undefined_perk(var_str_perk);
	if(!isdefined(level.var__custom_perks[var_str_perk].var_precache_func))
	{
		level.var__custom_perks[var_str_perk].var_precache_func = var_func_precache;
	}
}

/*
	Name: function_register_perk_threads
	Namespace: namespace_zm_perks
	Checksum: 0x424F4353
	Offset: 0x5C08
	Size: 0x100
	Parameters: 3
	Flags: None
	Line Number: 2198
*/
function function_register_perk_threads(var_str_perk, var_func_give_player_perk, var_func_take_player_perk)
{
	/#
		namespace_::function_Assert(isdefined(var_str_perk), "Dev Block strings are not supported");
	#/
	/#
		namespace_::function_Assert(isdefined(var_func_give_player_perk), "Dev Block strings are not supported");
	#/
	function__register_undefined_perk(var_str_perk);
	if(!isdefined(level.var__custom_perks[var_str_perk].var_player_thread_give))
	{
		level.var__custom_perks[var_str_perk].var_player_thread_give = var_func_give_player_perk;
	}
	if(isdefined(var_func_take_player_perk))
	{
		if(!isdefined(level.var__custom_perks[var_str_perk].var_player_thread_take))
		{
			level.var__custom_perks[var_str_perk].var_player_thread_take = var_func_take_player_perk;
		}
	}
}

/*
	Name: function_register_perk_clientfields
	Namespace: namespace_zm_perks
	Checksum: 0x424F4353
	Offset: 0x5D10
	Size: 0x120
	Parameters: 3
	Flags: None
	Line Number: 2230
*/
function function_register_perk_clientfields(var_str_perk, var_func_clientfield_register, var_func_clientfield_set)
{
	/#
		namespace_::function_Assert(isdefined(var_str_perk), "Dev Block strings are not supported");
	#/
	/#
		namespace_::function_Assert(isdefined(var_func_clientfield_register), "Dev Block strings are not supported");
	#/
	/#
		namespace_::function_Assert(isdefined(var_func_clientfield_set), "Dev Block strings are not supported");
	#/
	function__register_undefined_perk(var_str_perk);
	if(!isdefined(level.var__custom_perks[var_str_perk].var_clientfield_register))
	{
		level.var__custom_perks[var_str_perk].var_clientfield_register = var_func_clientfield_register;
	}
	if(!isdefined(level.var__custom_perks[var_str_perk].var_clientfield_set))
	{
		level.var__custom_perks[var_str_perk].var_clientfield_set = var_func_clientfield_set;
	}
}

/*
	Name: function_register_perk_host_migration_params
	Namespace: namespace_zm_perks
	Checksum: 0x424F4353
	Offset: 0x5E38
	Size: 0x120
	Parameters: 3
	Flags: None
	Line Number: 2262
*/
function function_register_perk_host_migration_params(var_str_perk, var_str_radiant_name, var_str_effect_name)
{
	/#
		namespace_::function_Assert(isdefined(var_str_perk), "Dev Block strings are not supported");
	#/
	/#
		namespace_::function_Assert(isdefined(var_str_radiant_name), "Dev Block strings are not supported");
	#/
	/#
		namespace_::function_Assert(isdefined(var_str_effect_name), "Dev Block strings are not supported");
	#/
	function__register_undefined_perk(var_str_perk);
	if(!isdefined(level.var__custom_perks[var_str_perk].var_radiant_name))
	{
		level.var__custom_perks[var_str_perk].var_radiant_machine_name = var_str_radiant_name;
	}
	if(!isdefined(level.var__custom_perks[var_str_perk].var_light_effect))
	{
		level.var__custom_perks[var_str_perk].var_machine_light_effect = var_str_effect_name;
	}
}

/*
	Name: function__register_undefined_perk
	Namespace: namespace_zm_perks
	Checksum: 0x424F4353
	Offset: 0x5F60
	Size: 0x60
	Parameters: 1
	Flags: None
	Line Number: 2294
*/
function function__register_undefined_perk(var_str_perk)
{
	if(!isdefined(level.var__custom_perks))
	{
		level.var__custom_perks = [];
	}
	if(!isdefined(level.var__custom_perks[var_str_perk]))
	{
		level.var__custom_perks[var_str_perk] = function_spawnstruct();
		return;
	}
}

/*
	Name: function_register_perk_damage_override_func
	Namespace: namespace_zm_perks
	Checksum: 0x424F4353
	Offset: 0x5FC8
	Size: 0x6C
	Parameters: 1
	Flags: None
	Line Number: 2317
*/
function function_register_perk_damage_override_func(var_func_damage_override)
{
	/#
		namespace_::function_Assert(isdefined(var_func_damage_override), "Dev Block strings are not supported");
	#/
	if(!isdefined(level.var_perk_damage_override))
	{
		level.var_perk_damage_override = [];
	}
	namespace_Array::function_add(level.var_perk_damage_override, var_func_damage_override, 0);
}

