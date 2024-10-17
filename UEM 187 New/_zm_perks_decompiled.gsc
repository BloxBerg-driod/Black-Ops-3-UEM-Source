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

#namespace zm_perks;

/*
	Name: init
	Namespace: zm_perks
	Checksum: 0x424F4353
	Offset: 0x6D8
	Size: 0x330
	Parameters: 0
	Flags: None
	Line Number: 36
*/
function init()
{
	level.perk_purchase_limit = 4;
	perks_register_clientfield();
	if(!level.enable_magic)
	{
		return;
	}
	initialize_custom_perk_arrays();
	perk_machine_spawn_init();
	vending_weapon_upgrade_trigger = [];
	vending_triggers = getentarray("zombie_vending", "targetname");
	if(vending_triggers.size < 1)
	{
		return;
	}
	level.machine_assets = [];
	if(!isdefined(level.custom_vending_precaching))
	{
		level.custom_vending_precaching = &default_vending_precaching;
	}
	[[level.custom_vending_precaching]]();
	zombie_utility::set_zombie_var("zombie_perk_cost", 2000);
	array::thread_all(vending_triggers, &vending_trigger_think);
	array::thread_all(vending_triggers, &electric_perks_dialog);
	if(level._custom_perks.size > 0)
	{
		a_keys = getarraykeys(level._custom_perks);
		for(i = 0; i < a_keys.size; i++)
		{
			if(isdefined(level._custom_perks[a_keys[i]].perk_machine_thread))
			{
				level thread [[level._custom_perks[a_keys[i]].perk_machine_thread]]();
			}
			if(isdefined(level._custom_perks[a_keys[i]].perk_machine_power_override_thread))
			{
				level thread [[level._custom_perks[a_keys[i]].perk_machine_power_override_thread]]();
				continue;
			}
			if(isdefined(level._custom_perks[a_keys[i]].alias) && isdefined(level._custom_perks[a_keys[i]].radiant_machine_name) && isdefined(level._custom_perks[a_keys[i]].machine_light_effect))
			{
				level thread perk_machine_think(a_keys[i], level._custom_perks[a_keys[i]]);
			}
		}
	}
	else if(isdefined(level.quantum_bomb_register_result_func))
	{
		[[level.quantum_bomb_register_result_func]]("give_nearest_perk", &quantum_bomb_give_nearest_perk_result, 10, &quantum_bomb_give_nearest_perk_validation);
	}
	level thread perk_hostmigration();
}

/*
	Name: perk_machine_think
	Namespace: zm_perks
	Checksum: 0x424F4353
	Offset: 0xA10
	Size: 0x3C0
	Parameters: 2
	Flags: None
	Line Number: 98
*/
function perk_machine_think(str_key, s_custom_perk)
{
	str_endon = str_key + "_power_thread_end";
	level endon(str_endon);
	var_fb1cd1b2 = s_custom_perk.alias + "_on";
	str_off = s_custom_perk.alias + "_off";
	str_notify = str_key + "_power_on";
	while(1)
	{
		machine = getentarray(s_custom_perk.radiant_machine_name, "targetname");
		machine_triggers = getentarray(s_custom_perk.radiant_machine_name, "target");
		for(i = 0; i < machine.size; i++)
		{
			machine[i] setmodel(level.machine_assets[str_key].off_model);
			machine[i] solid();
		}
		level thread do_initial_power_off_callback(machine, str_key);
		array::thread_all(machine_triggers, &set_power_on, 0);
		level waittill(var_fb1cd1b2);
		for(i = 0; i < machine.size; i++)
		{
			machine[i] setmodel(level.machine_assets[str_key].on_model);
			machine[i] vibrate(VectorScale((0, -1, 0), 100), 0.3, 0.4, 3);
			machine[i] playsound("zmb_perks_power_on");
			machine[i] thread perk_fx(s_custom_perk.machine_light_effect);
			machine[i] thread play_loop_on_machine();
		}
		level notify(str_notify);
		array::thread_all(machine_triggers, &set_power_on, 1);
		if(isdefined(level.machine_assets[str_key].power_on_callback))
		{
			array::thread_all(machine, level.machine_assets[str_key].power_on_callback);
		}
		level waittill(str_off);
		if(isdefined(level.machine_assets[str_key].power_off_callback))
		{
			array::thread_all(machine, level.machine_assets[str_key].power_off_callback);
		}
		array::thread_all(machine, &turn_perk_off);
	}
}

/*
	Name: default_vending_precaching
	Namespace: zm_perks
	Checksum: 0x424F4353
	Offset: 0xDD8
	Size: 0xB0
	Parameters: 0
	Flags: None
	Line Number: 150
*/
function default_vending_precaching()
{
	if(level._custom_perks.size > 0)
	{
		a_keys = getarraykeys(level._custom_perks);
		for(i = 0; i < a_keys.size; i++)
		{
			if(isdefined(level._custom_perks[a_keys[i]].precache_func))
			{
				level [[level._custom_perks[a_keys[i]].precache_func]]();
			}
		}
	}
}

/*
	Name: do_initial_power_off_callback
	Namespace: zm_perks
	Checksum: 0x424F4353
	Offset: 0xE90
	Size: 0x80
	Parameters: 2
	Flags: None
	Line Number: 175
*/
function do_initial_power_off_callback(machine_array, perkname)
{
	if(!isdefined(level.machine_assets[perkname]))
	{
		return;
	}
	if(!isdefined(level.machine_assets[perkname].power_off_callback))
	{
		return;
	}
	wait(0.05);
	array::thread_all(machine_array, level.machine_assets[perkname].power_off_callback);
}

/*
	Name: use_solo_revive
	Namespace: zm_perks
	Checksum: 0x424F4353
	Offset: 0xF18
	Size: 0x90
	Parameters: 0
	Flags: None
	Line Number: 199
*/
function use_solo_revive()
{
	if(isdefined(level.override_use_solo_revive))
	{
		return [[level.override_use_solo_revive]]();
	}
	players = getplayers();
	solo_mode = 0;
	if(players.size == 1 || (isdefined(level.force_solo_quick_revive) && level.force_solo_quick_revive))
	{
		solo_mode = 1;
	}
	level.using_solo_revive = solo_mode;
	return solo_mode;
}

/*
	Name: set_power_on
	Namespace: zm_perks
	Checksum: 0x424F4353
	Offset: 0xFB0
	Size: 0x18
	Parameters: 1
	Flags: None
	Line Number: 225
*/
function set_power_on(state)
{
	self.power_on = state;
}

/*
	Name: turn_perk_off
	Namespace: zm_perks
	Checksum: 0x424F4353
	Offset: 0xFD0
	Size: 0x118
	Parameters: 1
	Flags: None
	Line Number: 240
*/
function turn_perk_off(ishidden)
{
	self notify("stop_loopsound");
	if(!(isdefined(self.b_keep_when_turned_off) && self.b_keep_when_turned_off))
	{
		newMachine = spawn("script_model", self.origin);
		newMachine.angles = self.angles;
		newMachine.targetname = self.targetname;
		if(isdefined(ishidden) && ishidden)
		{
			newMachine.ishidden = 1;
			newMachine ghost();
			newMachine notsolid();
		}
		self delete();
	}
	else
	{
		perk_fx(undefined, 1);
		return;
	}
	ERROR: Exception occured: Index was out of range. Must be non-negative and less than the size of the collection.
Parameter name: index
}

/*
	Name: play_loop_on_machine
	Namespace: zm_perks
	Checksum: 0x424F4353
	Offset: 0x10F0
	Size: 0xB0
	Parameters: 0
	Flags: None
	Line Number: 275
*/
function play_loop_on_machine()
{
	if(isdefined(level.sndPerksacolaLoopOverride))
	{
		return;
	}
	sound_ent = spawn("script_origin", self.origin);
	sound_ent playloopsound("zmb_perks_machine_loop");
	sound_ent linkto(self);
	self waittill("stop_loopsound");
	sound_ent unlink();
	sound_ent delete();
}

/*
	Name: perk_fx
	Namespace: zm_perks
	Checksum: 0x424F4353
	Offset: 0x11A8
	Size: 0x168
	Parameters: 2
	Flags: None
	Line Number: 299
*/
function perk_fx(fx, turnOffFx)
{
	if(isdefined(turnOffFx))
	{
		self.perk_fx = 0;
		if(isdefined(self.b_keep_when_turned_off) && self.b_keep_when_turned_off && isdefined(self.s_fxloc))
		{
			self.s_fxloc delete();
		}
	}
	else
	{
		wait(3);
		if(!isdefined(self))
		{
			return;
		}
		if(!(isdefined(self.b_keep_when_turned_off) && self.b_keep_when_turned_off))
		{
			if(isdefined(self) && (!(isdefined(self.perk_fx) && self.perk_fx)))
			{
				playfxontag(level._effect[fx], self, "tag_origin");
				self.perk_fx = 1;
			}
		}
		else if(isdefined(self) && !isdefined(self.s_fxloc))
		{
			self.s_fxloc = util::spawn_model("tag_origin", self.origin);
			playfxontag(level._effect[fx], self.s_fxloc, "tag_origin");
			self.perk_fx = 1;
		}
	}
}

/*
	Name: electric_perks_dialog
	Namespace: zm_perks
	Checksum: 0x424F4353
	Offset: 0x1318
	Size: 0x1E0
	Parameters: 0
	Flags: None
	Line Number: 343
*/
function electric_perks_dialog()
{
	self endon("death");
	wait(0.01);
	level flag::wait_till("start_zombie_round_logic");
	players = getplayers();
	if(players.size == 1)
	{
		return;
	}
	self endon("warning_dialog");
	level endon("switch_flipped");
	timer = 0;
	while(1)
	{
		wait(0.5);
		players = getplayers();
		for(i = 0; i < players.size; i++)
		{
			if(!isdefined(players[i]))
			{
				continue;
			}
			dist = distancesquared(players[i].origin, self.origin);
			if(dist > 4900)
			{
				timer = 0;
				continue;
			}
			if(dist < 4900 && timer < 3)
			{
				wait(0.5);
				timer++;
			}
			if(dist < 4900 && timer == 3)
			{
				if(!isdefined(players[i]))
				{
					continue;
				}
				players[i] thread zm_utility::do_player_vo("vox_start", 5);
				wait(3);
				self notify("warning_dialog");
			}
		}
	}
}

/*
	Name: reset_vending_hint_string
	Namespace: zm_perks
	Checksum: 0x424F4353
	Offset: 0x1500
	Size: 0x140
	Parameters: 0
	Flags: None
	Line Number: 401
*/
function reset_vending_hint_string()
{
	perk = self.script_noteworthy;
	Solo = use_solo_revive();
	if(isdefined(level._custom_perks))
	{
		if(isdefined(level._custom_perks[perk]) && isdefined(level._custom_perks[perk].cost) && isdefined(level._custom_perks[perk].hint_string))
		{
			if(IsFunctionPtr(level._custom_perks[perk].cost))
			{
				n_cost = [[level._custom_perks[perk].cost]]();
			}
			else
			{
				n_cost = level._custom_perks[perk].cost;
			}
			self sethintstring(level._custom_perks[perk].hint_string, n_cost);
		}
	}
}

/*
	Name: vending_trigger_can_player_use
	Namespace: zm_perks
	Checksum: 0x424F4353
	Offset: 0x1648
	Size: 0xE8
	Parameters: 1
	Flags: None
	Line Number: 432
*/
function vending_trigger_can_player_use(player)
{
	if(player laststand::player_is_in_laststand() || (isdefined(player.intermission) && player.intermission))
	{
		return 0;
	}
	if(player zm_utility::in_revive_trigger())
	{
		return 0;
	}
	if(!player zm_magicbox::can_buy_weapon())
	{
		return 0;
	}
	if(player IsThrowingGrenade())
	{
		return 0;
	}
	if(player isswitchingweapons())
	{
		return 0;
	}
	if(player.is_drinking > 0)
	{
		return 0;
	}
	return 1;
	ERROR: Exception occured: Stack empty.
}

/*
	Name: function_cef02b83
	Namespace: zm_perks
	Checksum: 0x424F4353
	Offset: 0x1738
	Size: 0xA0
	Parameters: 0
	Flags: None
	Line Number: 472
*/
function function_cef02b83()
{
	self endon("death");
	wait(0.01);
	while(isdefined(self))
	{
		foreach(player in getplayers())
		{
		}
	}
}

/*
	Name: vending_trigger_think
	Namespace: zm_perks
	Checksum: 0x424F4353
	Offset: 0x17E0
	Size: 0x7A0
	Parameters: 0
	Flags: None
	Line Number: 494
*/
function vending_trigger_think()
{
	self endon("death");
	wait(0.01);
	perk = self.script_noteworthy;
	Solo = 0;
	start_on = 0;
	level.revive_machine_is_solo = 0;
	if(isdefined(perk) && perk == "specialty_quickrevive")
	{
		level flag::wait_till("start_zombie_round_logic");
		Solo = use_solo_revive();
		self endon("stop_quickrevive_logic");
		level.quick_revive_trigger = self;
		if(Solo)
		{
			if(!(isdefined(level.revive_machine_is_solo) && level.revive_machine_is_solo))
			{
				if(!(isdefined(level.initial_quick_revive_power_off) && level.initial_quick_revive_power_off))
				{
					start_on = 1;
				}
				players = getplayers();
				foreach(player in players)
				{
					if(!isdefined(player.lives))
					{
						player.lives = 0;
					}
				}
				level zm::set_default_laststand_pistol(1);
			}
			level.revive_machine_is_solo = 1;
		}
	}
	self sethintstring(&"ZOMBIE_NEED_POWER");
	self setcursorhint("HINT_NOICON");
	self usetriggerrequirelookat();
	cost = level.zombie_vars["zombie_perk_cost"];
	if(isdefined(level._custom_perks[perk]) && isdefined(level._custom_perks[perk].cost))
	{
		if(isint(level._custom_perks[perk].cost))
		{
			cost = level._custom_perks[perk].cost;
		}
		else
		{
			cost = [[level._custom_perks[perk].cost]]();
		}
	}
	self.cost = cost;
	if(!start_on)
	{
		notify_name = perk + "_power_on";
		level waittill(notify_name);
	}
	start_on = 0;
	if(!isdefined(level._perkmachinenetworkchoke))
	{
		level._perkmachinenetworkchoke = 0;
	}
	else
	{
		level._perkmachinenetworkchoke++;
	}
	for(i = 0; i < level._perkmachinenetworkchoke; i++)
	{
		util::wait_network_frame();
	}
	self thread zm_audio::sndPerksJingles_Timer();
	self thread check_player_has_perk(perk);
	if(isdefined(level._custom_perks[perk]) && isdefined(level._custom_perks[perk].hint_string))
	{
		self sethintstring(level._custom_perks[perk].hint_string, cost);
	}
	for(;;)
	{
		self waittill("trigger", player);
		index = zm_utility::get_player_index(player);
		if(!vending_trigger_can_player_use(player))
		{
			wait(0.1);
		}
		else if(player hasperk(perk) || player has_perk_paused(perk))
		{
			cheat = 0;
			if(cheat != 1)
			{
				self playsound("evt_perk_deny");
				player zm_audio::create_and_play_dialog("general", "sigh");
			}
		}
		else
		{
			valid = self [[level.custom_perk_validation]](player);
			if(!valid)
			{
			}
			else
			{
				current_cost = self.cost;
				if(player zm_pers_upgrades_functions::is_pers_double_points_active())
				{
					current_cost = player zm_pers_upgrades_functions::pers_upgrade_double_points_cost(current_cost);
				}
				if(!player zm_score::can_player_purchase(current_cost))
				{
					self playsound("evt_perk_deny");
					player zm_audio::create_and_play_dialog("general", "outofmoney");
				}
				else if(!player zm_utility::can_player_purchase_perk())
				{
					self playsound("evt_perk_deny");
					player zm_audio::create_and_play_dialog("general", "sigh");
				}
				else
				{
					sound = "evt_bottle_dispense";
					playsoundatposition(sound, self.origin);
					player zm_score::minus_to_player_score(current_cost);
					perkHash = -1;
					if(isdefined(level._custom_perks[perk]) && isdefined(level._custom_perks[perk].hash_id))
					{
						perkHash = level._custom_perks[perk].hash_id;
					}
					player RecordMapEvent(29, GetTime(), self.origin, level.round_number, perkHash);
					player.perk_purchased = perk;
					player notify("perk_purchased", perk);
					self thread zm_audio::sndPerksJingles_Player(1);
					self thread vending_trigger_post_think(player, perk);
				}
			}
			else
			{
			}
		}
		else if(isdefined(level.custom_perk_validation))
		{
		}
	}
}

/*
	Name: vending_trigger_post_think
	Namespace: zm_perks
	Checksum: 0x424F4353
	Offset: 0x1F88
	Size: 0x218
	Parameters: 2
	Flags: None
	Line Number: 646
*/
function vending_trigger_post_think(player, perk)
{
	player endon("disconnect");
	player endon("end_game");
	player endon("perk_abort_drinking");
	gun = player perk_give_bottle_begin(perk);
	evt = player util::waittill_any_return("fake_death", "death", "player_downed", "weapon_change_complete", "perk_abort_drinking", "disconnect");
	if(evt == "weapon_change_complete")
	{
		player thread wait_give_perk(perk, 1);
	}
	player perk_give_bottle_end(gun, perk);
	if(player laststand::player_is_in_laststand() || (isdefined(player.intermission) && player.intermission))
	{
		return;
	}
	player notify("burp");
	if(isdefined(level.pers_upgrade_cash_back) && level.pers_upgrade_cash_back)
	{
		player zm_pers_upgrades_functions::cash_back_player_drinks_perk();
	}
	if(isdefined(level.pers_upgrade_perk_lose) && level.pers_upgrade_perk_lose)
	{
		player thread zm_pers_upgrades_functions::pers_upgrade_perk_lose_bought();
	}
	if(isdefined(level.perk_bought_func))
	{
		player [[level.perk_bought_func]](perk);
	}
	player.perk_purchased = undefined;
	if(!(isdefined(self.power_on) && self.power_on))
	{
		wait(1);
		perk_pause(self.script_noteworthy);
	}
}

/*
	Name: wait_give_perk
	Namespace: zm_perks
	Checksum: 0x424F4353
	Offset: 0x21A8
	Size: 0xA8
	Parameters: 2
	Flags: None
	Line Number: 693
*/
function wait_give_perk(perk, bought)
{
	self endon("player_downed");
	self endon("disconnect");
	self endon("end_game");
	self endon("perk_abort_drinking");
	self util::waittill_any_timeout(0.5, "burp", "player_downed", "disconnect", "end_game", "perk_abort_drinking");
	self give_perk(perk, bought);
}

/*
	Name: return_retained_perks
	Namespace: zm_perks
	Checksum: 0x424F4353
	Offset: 0x2258
	Size: 0xE8
	Parameters: 0
	Flags: None
	Line Number: 713
*/
function return_retained_perks()
{
	if(isdefined(self._retain_perks_array))
	{
		keys = getarraykeys(self._retain_perks_array);
		foreach(perk in keys)
		{
			if(isdefined(self._retain_perks_array[perk]) && self._retain_perks_array[perk])
			{
				self give_perk(perk, 0);
			}
		}
		return;
	}
	.var_60707e62 = undefined;
}

/*
	Name: give_perk_presentation
	Namespace: zm_perks
	Checksum: 0x424F4353
	Offset: 0x2348
	Size: 0x110
	Parameters: 1
	Flags: None
	Line Number: 740
*/
function give_perk_presentation(perk)
{
	self endon("player_downed");
	self endon("disconnect");
	self endon("end_game");
	self endon("perk_abort_drinking");
	self zm_audio::playerExert("burp");
	if(isdefined(level.remove_perk_vo_delay) && level.remove_perk_vo_delay)
	{
		self zm_audio::create_and_play_dialog("perk", perk);
	}
	else
	{
		self util::delay(1.5, undefined, &zm_audio::create_and_play_dialog, "perk", perk);
	}
	self setblur(9, 0.1);
	wait(0.1);
	self setblur(0, 0.1);
}

/*
	Name: give_perk
	Namespace: zm_perks
	Checksum: 0x424F4353
	Offset: 0x2460
	Size: 0x288
	Parameters: 2
	Flags: None
	Line Number: 770
*/
function give_perk(perk, bought)
{
	self setperk(perk);
	self.num_perks++;
	if(isdefined(bought) && bought)
	{
		self thread give_perk_presentation(perk);
		self notify("perk_bought", perk);
		self zm_stats::increment_challenge_stat("SURVIVALIST_BUY_PERK");
	}
	if(isdefined(level._custom_perks[perk]) && isdefined(level._custom_perks[perk].player_thread_give))
	{
		self thread [[level._custom_perks[perk].player_thread_give]]();
	}
	self set_perk_clientfield(perk, 1);
	demo::bookmark("zm_player_perk", GetTime(), self);
	self zm_stats::increment_client_stat("perks_drank");
	self zm_stats::increment_client_stat(perk + "_drank");
	self zm_stats::increment_player_stat(perk + "_drank");
	self zm_stats::increment_player_stat("perks_drank");
	if(!isdefined(self.perk_history))
	{
		self.perk_history = [];
	}
	array::add(self.perk_history, perk, 0);
	if(!isdefined(self.perks_active))
	{
		self.perks_active = [];
	}
	if(!isdefined(self.perks_active))
	{
		self.perks_active = [];
	}
	else if(!isarray(self.perks_active))
	{
		self.perks_active = array(self.perks_active);
	}
	self.perks_active[self.perks_active.size] = perk;
	self notify("perk_acquired", perk);
	self thread perk_think(perk);
	return;
	ERROR: Exception occured: Stack empty.
}

/*
	Name: perk_set_max_health_if_jugg
	Namespace: zm_perks
	Checksum: 0x424F4353
	Offset: 0x26F0
	Size: 0x218
	Parameters: 3
	Flags: None
	Line Number: 824
*/
function perk_set_max_health_if_jugg(str_perk, set_preMaxHealth, clamp_health_to_max_health)
{
	n_max_total_health = undefined;
	switch(str_perk)
	{
		case "specialty_armorvest":
		{
			if(set_preMaxHealth)
			{
				self.preMaxHealth = self.maxhealth;
			}
			n_max_total_health = self.maxhealth + level.zombie_vars["zombie_perk_juggernaut_health"];
			break;
		}
		case "jugg_upgrade":
		{
			if(set_preMaxHealth)
			{
				self.preMaxHealth = self.maxhealth;
			}
			if(self hasperk("specialty_armorvest"))
			{
				n_max_total_health = n_max_total_health + level.zombie_vars["zombie_perk_juggernaut_health"];
			}
			else
			{
				n_max_total_health = level.zombie_vars["player_base_health"];
				break;
			}
		}
		case "health_reboot":
		{
			n_max_total_health = level.zombie_vars["player_base_health"];
			if(isdefined(self.n_player_health_boost))
			{
				n_max_total_health = n_max_total_health + self.n_player_health_boost;
			}
			if(self hasperk("specialty_armorvest"))
			{
				n_max_total_health = n_max_total_health + level.zombie_vars["zombie_perk_juggernaut_health"];
			}
		}
	}
	if(isdefined(n_max_total_health))
	{
		if(self zm_pers_upgrades_functions::pers_jugg_active())
		{
			n_max_total_health = n_max_total_health + level.pers_jugg_upgrade_health_bonus;
		}
		self.maxhealth = n_max_total_health;
		self setmaxhealth(n_max_total_health);
		if(isdefined(clamp_health_to_max_health) && clamp_health_to_max_health == 1)
		{
			if(self.health > self.maxhealth)
			{
				self.health = self.maxhealth;
			}
		}
	}
}

/*
	Name: check_player_has_perk
	Namespace: zm_perks
	Checksum: 0x424F4353
	Offset: 0x2910
	Size: 0x1E0
	Parameters: 1
	Flags: None
	Line Number: 895
*/
function check_player_has_perk(perk)
{
	self endon("death");
	dist = 16384;
	while(1)
	{
		players = getplayers();
		for(i = 0; i < players.size; i++)
		{
			if(distancesquared(players[i].origin, self.origin) < dist)
			{
				if(!players[i] hasperk(perk) && self vending_trigger_can_player_use(players[i]) && !players[i] has_perk_paused(perk) && !players[i] zm_utility::in_revive_trigger() && !zm_equipment::is_equipment_that_blocks_purchase(players[i] getcurrentweapon()) && !players[i] zm_equipment::hacker_active())
				{
					self setinvisibletoplayer(players[i], 0);
					continue;
				}
				self setinvisibletoplayer(players[i], 1);
			}
		}
		wait(0.1);
	}
	return;
	players++;
}

/*
	Name: vending_set_hintstring
	Namespace: zm_perks
	Checksum: 0x424F4353
	Offset: 0x2AF8
	Size: 0x30
	Parameters: 1
	Flags: None
	Line Number: 930
*/
function vending_set_hintstring(perk)
{
	switch(perk)
	{
		case "specialty_armorvest":
		{
			break;
		}
	}
}

/*
	Name: perk_think
	Namespace: zm_perks
	Checksum: 0x424F4353
	Offset: 0x2B30
	Size: 0x280
	Parameters: 1
	Flags: None
	Line Number: 951
*/
function perk_think(perk)
{
	self endon("disconnect");
	perk_str = perk + "_stop";
	result = self util::waittill_any_return("fake_death", "death", "player_downed", perk_str);
	while(self bgb::lost_perk_override(perk))
	{
		result = self util::waittill_any_return("fake_death", "death", "player_downed", perk_str);
	}
	do_retain = 1;
	if(use_solo_revive() && perk == "specialty_quickrevive")
	{
		do_retain = 0;
	}
	if(do_retain)
	{
		if(isdefined(self._retain_perks) && self._retain_perks)
		{
			return;
		}
		else if(isdefined(self._retain_perks_array) && (isdefined(self._retain_perks_array[perk]) && self._retain_perks_array[perk]))
		{
			return;
		}
	}
	self unsetperk(perk);
	self.num_perks--;
	if(isdefined(level._custom_perks[perk]) && isdefined(level._custom_perks[perk].player_thread_take))
	{
		self thread [[level._custom_perks[perk].player_thread_take]](0, perk_str, result);
	}
	self set_perk_clientfield(perk, 0);
	self.perk_purchased = undefined;
	if(isdefined(level.perk_lost_func))
	{
		self [[level.perk_lost_func]](perk);
	}
	if(isdefined(self.perks_active) && isinarray(self.perks_active, perk))
	{
		arrayremovevalue(self.perks_active, perk, 0);
	}
	self notify("perk_lost");
	return;
}

/*
	Name: set_perk_clientfield
	Namespace: zm_perks
	Checksum: 0x424F4353
	Offset: 0x2DB8
	Size: 0x68
	Parameters: 2
	Flags: None
	Line Number: 1006
*/
function set_perk_clientfield(perk, state)
{
	if(isdefined(level._custom_perks[perk]) && isdefined(level._custom_perks[perk].clientfield_set))
	{
		self [[level._custom_perks[perk].clientfield_set]](state);
	}
}

/*
	Name: perk_hud_destroy
	Namespace: zm_perks
	Checksum: 0x424F4353
	Offset: 0x2E28
	Size: 0x38
	Parameters: 1
	Flags: None
	Line Number: 1024
*/
function perk_hud_destroy(perk)
{
	self.perk_hud[perk] zm_utility::destroy_hud();
	self.perk_hud[perk] = undefined;
}

/*
	Name: perk_hud_grey
	Namespace: zm_perks
	Checksum: 0x424F4353
	Offset: 0x2E68
	Size: 0x60
	Parameters: 2
	Flags: None
	Line Number: 1040
*/
function perk_hud_grey(perk, grey_on_off)
{
	if(grey_on_off)
	{
		self.perk_hud[perk].alpha = 0.3;
	}
	else
	{
		self.perk_hud[perk].alpha = 1;
	}
}

/*
	Name: perk_give_bottle_begin
	Namespace: zm_perks
	Checksum: 0x424F4353
	Offset: 0x2ED0
	Size: 0xF8
	Parameters: 1
	Flags: None
	Line Number: 1062
*/
function perk_give_bottle_begin(perk)
{
	self zm_utility::increment_is_drinking();
	self zm_utility::disable_player_move_states(1);
	original_weapon = self getcurrentweapon();
	weapon = "";
	if(isdefined(level._custom_perks[perk]) && isdefined(level._custom_perks[perk].perk_bottle_weapon))
	{
		weapon = level._custom_perks[perk].perk_bottle_weapon;
	}
	self giveweapon(weapon);
	self switchtoweapon(weapon);
	return original_weapon;
}

/*
	Name: perk_give_bottle_end
	Namespace: zm_perks
	Checksum: 0x424F4353
	Offset: 0x2FD0
	Size: 0x278
	Parameters: 2
	Flags: None
	Line Number: 1087
*/
function perk_give_bottle_end(original_weapon, perk)
{
	self endon("perk_abort_drinking");
	/#
		Assert(!original_weapon.isPerkBottle);
	#/
	/#
		Assert(original_weapon != level.weaponReviveTool);
	#/
	self zm_utility::enable_player_move_states();
	weapon = "";
	if(isdefined(level._custom_perks[perk]) && isdefined(level._custom_perks[perk].perk_bottle_weapon))
	{
		weapon = level._custom_perks[perk].perk_bottle_weapon;
	}
	if(self laststand::player_is_in_laststand() || (isdefined(self.intermission) && self.intermission))
	{
		self takeweapon(weapon);
		return;
	}
	self takeweapon(weapon);
	if(self zm_utility::is_multiple_drinking())
	{
		self zm_utility::decrement_is_drinking();
		return;
	}
	else if(original_weapon != level.weaponnone && !zm_utility::is_placeable_mine(original_weapon) && !zm_equipment::is_equipment_that_blocks_purchase(original_weapon))
	{
		self zm_weapons::switch_back_primary_weapon(original_weapon);
		if(zm_utility::is_melee_weapon(original_weapon))
		{
			self zm_utility::decrement_is_drinking();
			return;
		}
	}
	else
	{
		self zm_weapons::switch_back_primary_weapon();
	}
	self waittill("weapon_change_complete");
	if(!self laststand::player_is_in_laststand() && (!(isdefined(self.intermission) && self.intermission)))
	{
		self zm_utility::decrement_is_drinking();
		return;
	}
	ERROR: Exception occured: Stack empty.
}

/*
	Name: perk_abort_drinking
	Namespace: zm_perks
	Checksum: 0x424F4353
	Offset: 0x3250
	Size: 0x60
	Parameters: 1
	Flags: None
	Line Number: 1145
*/
function perk_abort_drinking(post_delay)
{
	if(self.is_drinking)
	{
		self notify("perk_abort_drinking");
		self zm_utility::decrement_is_drinking();
		self zm_utility::enable_player_move_states();
		if(isdefined(post_delay))
		{
			wait(post_delay);
		}
	}
}

/*
	Name: give_random_perk
	Namespace: zm_perks
	Checksum: 0x424F4353
	Offset: 0x32B8
	Size: 0x170
	Parameters: 0
	Flags: None
	Line Number: 1169
*/
function give_random_perk()
{
	random_perk = undefined;
	a_str_perks = getarraykeys(level._custom_perks);
	perks = [];
	for(i = 0; i < a_str_perks.size; i++)
	{
		perk = a_str_perks[i];
		if(isdefined(self.perk_purchased) && self.perk_purchased == perk)
		{
			continue;
		}
		if(!self hasperk(perk) && !self has_perk_paused(perk))
		{
			perks[perks.size] = perk;
		}
	}
	if(perks.size > 0)
	{
		perks = array::randomize(perks);
		random_perk = perks[0];
		self give_perk(random_perk);
	}
	else
	{
		self playsoundtoplayer(level.zmb_laugh_alias, self);
	}
	return random_perk;
}

/*
	Name: lose_random_perk
	Namespace: zm_perks
	Checksum: 0x424F4353
	Offset: 0x3430
	Size: 0x168
	Parameters: 0
	Flags: None
	Line Number: 1209
*/
function lose_random_perk()
{
	a_str_perks = getarraykeys(level._custom_perks);
	perks = [];
	for(i = 0; i < a_str_perks.size; i++)
	{
		perk = a_str_perks[i];
		if(isdefined(self.perk_purchased) && self.perk_purchased == perk)
		{
			continue;
		}
		if(self hasperk(perk) || self has_perk_paused(perk))
		{
			perks[perks.size] = perk;
		}
	}
	if(perks.size > 0)
	{
		perks = array::randomize(perks);
		perk = perks[0];
		perk_str = perk + "_stop";
		self notify(perk_str);
		if(use_solo_revive() && perk == "specialty_quickrevive")
		{
			self.lives--;
		}
	}
}

/*
	Name: update_perk_hud
	Namespace: zm_perks
	Checksum: 0x424F4353
	Offset: 0x35A0
	Size: 0x90
	Parameters: 0
	Flags: None
	Line Number: 1248
*/
function update_perk_hud()
{
	if(isdefined(self.perk_hud))
	{
		keys = getarraykeys(self.perk_hud);
		for(i = 0; i < self.perk_hud.size; i++)
		{
			self.perk_hud[keys[i]].x = i * 30;
		}
		return;
	}
	ERROR: Exception occured: Stack empty.
}

/*
	Name: quantum_bomb_give_nearest_perk_validation
	Namespace: zm_perks
	Checksum: 0x424F4353
	Offset: 0x3638
	Size: 0xB0
	Parameters: 1
	Flags: None
	Line Number: 1272
*/
function quantum_bomb_give_nearest_perk_validation(position)
{
	vending_triggers = getentarray("zombie_vending", "targetname");
	range_squared = 32400;
	for(i = 0; i < vending_triggers.size; i++)
	{
		if(distancesquared(vending_triggers[i].origin, position) < range_squared)
		{
			return 1;
		}
	}
	return 0;
}

/*
	Name: quantum_bomb_give_nearest_perk_result
	Namespace: zm_perks
	Checksum: 0x424F4353
	Offset: 0x36F0
	Size: 0x260
	Parameters: 1
	Flags: None
	Line Number: 1296
*/
function quantum_bomb_give_nearest_perk_result(position)
{
	[[level.quantum_bomb_play_mystery_effect_func]](position);
	vending_triggers = getentarray("zombie_vending", "targetname");
	nearest = 0;
	for(i = 1; i < vending_triggers.size; i++)
	{
		if(distancesquared(vending_triggers[i].origin, position) < distancesquared(vending_triggers[nearest].origin, position))
		{
			nearest = i;
		}
	}
	players = getplayers();
	perk = vending_triggers[nearest].script_noteworthy;
	for(i = 0; i < players.size; i++)
	{
		player = players[i];
		if(player.sessionstate == "spectator" || player laststand::player_is_in_laststand())
		{
			continue;
		}
		if(!player hasperk(perk) && (!isdefined(player.perk_purchased) || player.perk_purchased != perk) && randomint(5))
		{
			if(player == self)
			{
				self thread zm_audio::create_and_play_dialog("kill", "quant_good");
			}
			player give_perk(perk);
			player [[level.quantum_bomb_play_player_effect_func]]();
		}
	}
}

/*
	Name: perk_pause
	Namespace: zm_perks
	Checksum: 0x424F4353
	Offset: 0x3958
	Size: 0x1A8
	Parameters: 1
	Flags: None
	Line Number: 1339
*/
function perk_pause(perk)
{
	if(isdefined(level.dont_unset_perk_when_machine_paused) && level.dont_unset_perk_when_machine_paused)
	{
		return;
	}
	for(j = 0; j < getplayers().size; j++)
	{
		player = getplayers()[j];
		if(!isdefined(player.disabled_perks))
		{
			player.disabled_perks = [];
		}
		player.disabled_perks[perk] = isdefined(player.disabled_perks[perk]) && player.disabled_perks[perk] || player hasperk(perk);
		if(player.disabled_perks[perk])
		{
			player unsetperk(perk);
			player set_perk_clientfield(perk, 2);
			if(isdefined(level._custom_perks[perk]) && isdefined(level._custom_perks[perk].player_thread_take))
			{
				player thread [[level._custom_perks[perk].player_thread_take]](1);
			}
		}
	}
}

/*
	Name: perk_unpause
	Namespace: zm_perks
	Checksum: 0x424F4353
	Offset: 0x3B08
	Size: 0x198
	Parameters: 1
	Flags: None
	Line Number: 1375
*/
function perk_unpause(perk)
{
	if(isdefined(level.dont_unset_perk_when_machine_paused) && level.dont_unset_perk_when_machine_paused)
	{
		return;
	}
	if(!isdefined(perk))
	{
		return;
	}
	for(j = 0; j < getplayers().size; j++)
	{
		player = getplayers()[j];
		if(isdefined(player.disabled_perks) && (isdefined(player.disabled_perks[perk]) && player.disabled_perks[perk]))
		{
			player.disabled_perks[perk] = 0;
			player set_perk_clientfield(perk, 1);
			player setperk(perk);
			player perk_set_max_health_if_jugg(perk, 0, 0);
			if(isdefined(level._custom_perks[perk]) && isdefined(level._custom_perks[perk].player_thread_give))
			{
				player thread [[level._custom_perks[perk].player_thread_give]]();
			}
		}
	}
	return;
}

/*
	Name: perk_pause_all_perks
	Namespace: zm_perks
	Checksum: 0x424F4353
	Offset: 0x3CA8
	Size: 0x128
	Parameters: 1
	Flags: None
	Line Number: 1413
*/
function perk_pause_all_perks(power_zone)
{
	vending_triggers = getentarray("zombie_vending", "targetname");
	foreach(trigger in vending_triggers)
	{
		if(!isdefined(power_zone))
		{
			perk_pause(trigger.script_noteworthy);
			continue;
		}
		if(isdefined(trigger.script_int) && trigger.script_int == power_zone)
		{
			perk_pause(trigger.script_noteworthy);
		}
	}
}

/*
	Name: perk_unpause_all_perks
	Namespace: zm_perks
	Checksum: 0x424F4353
	Offset: 0x3DD8
	Size: 0x128
	Parameters: 1
	Flags: None
	Line Number: 1440
*/
function perk_unpause_all_perks(power_zone)
{
	vending_triggers = getentarray("zombie_vending", "targetname");
	foreach(trigger in vending_triggers)
	{
		if(!isdefined(power_zone))
		{
			perk_unpause(trigger.script_noteworthy);
			continue;
		}
		if(isdefined(trigger.script_int) && trigger.script_int == power_zone)
		{
			perk_unpause(trigger.script_noteworthy);
		}
	}
}

/*
	Name: has_perk_paused
	Namespace: zm_perks
	Checksum: 0x424F4353
	Offset: 0x3F08
	Size: 0x48
	Parameters: 1
	Flags: None
	Line Number: 1467
*/
function has_perk_paused(perk)
{
	if(isdefined(self.disabled_perks) && isdefined(self.disabled_perks[perk]) && self.disabled_perks[perk])
	{
		return 1;
	}
	return 0;
}

/*
	Name: getVendingMachineNotify
	Namespace: zm_perks
	Checksum: 0x424F4353
	Offset: 0x3F58
	Size: 0x88
	Parameters: 0
	Flags: None
	Line Number: 1486
*/
function getVendingMachineNotify()
{
	if(!isdefined(self))
	{
		return "";
	}
	str_perk = undefined;
	if(isdefined(level._custom_perks[self.script_noteworthy]) && isdefined(isdefined(level._custom_perks[self.script_noteworthy].alias)))
	{
		str_perk = level._custom_perks[self.script_noteworthy].alias;
	}
	return str_perk;
}

/*
	Name: perk_machine_removal
	Namespace: zm_perks
	Checksum: 0x424F4353
	Offset: 0x3FE8
	Size: 0x298
	Parameters: 2
	Flags: None
	Line Number: 1510
*/
function perk_machine_removal(machine, replacement_model)
{
	if(!isdefined(machine))
	{
		return;
	}
	trig = getent(machine, "script_noteworthy");
	machine_model = undefined;
	if(isdefined(trig))
	{
		trig notify("warning_dialog");
		if(isdefined(trig.target))
		{
			parts = getentarray(trig.target, "targetname");
			for(i = 0; i < parts.size; i++)
			{
				if(isdefined(parts[i].classname) && parts[i].classname == "script_model")
				{
					machine_model = parts[i];
					continue;
				}
				if(isdefined(parts[i].script_noteworthy && parts[i].script_noteworthy == "clip"))
				{
					model_clip = parts[i];
					continue;
				}
				parts[i] delete();
			}
		}
		else if(isdefined(replacement_model) && isdefined(machine_model))
		{
			machine_model setmodel(replacement_model);
		}
		else if(!isdefined(replacement_model) && isdefined(machine_model))
		{
			machine_model delete();
			if(isdefined(model_clip))
			{
				model_clip delete();
			}
			if(isdefined(trig.clip))
			{
				trig.clip delete();
			}
		}
		if(isdefined(trig.bump))
		{
			trig.bump delete();
		}
		trig delete();
	}
}

/*
	Name: perk_machine_spawn_init
	Namespace: zm_perks
	Checksum: 0x424F4353
	Offset: 0x4288
	Size: 0x9F0
	Parameters: 0
	Flags: None
	Line Number: 1573
*/
function perk_machine_spawn_init()
{
	match_string = "";
	location = level.scr_zm_map_start_location;
	if(location == "default" || location == "" && isdefined(level.default_start_location))
	{
		location = level.default_start_location;
	}
	match_string = level.scr_zm_ui_gametype + "_perks_" + location;
	a_s_spawn_pos = [];
	if(isdefined(level.override_perk_targetname))
	{
		structs = struct::get_array(level.override_perk_targetname, "targetname");
	}
	else
	{
		structs = struct::get_array("zm_perk_machine", "targetname");
	}
	foreach(struct in structs)
	{
		if(isdefined(struct.script_string))
		{
			tokens = strtok(struct.script_string, " ");
			foreach(token in tokens)
			{
				if(token == match_string)
				{
					a_s_spawn_pos[a_s_spawn_pos.size] = struct;
				}
			}
			continue;
		}
		a_s_spawn_pos[a_s_spawn_pos.size] = struct;
	}
	if(a_s_spawn_pos.size == 0)
	{
		return;
	}
	if(isdefined(level.randomize_perk_machine_location) && level.randomize_perk_machine_location)
	{
		a_s_random_perk_locs = struct::get_array("perk_random_machine_location", "targetname");
		if(a_s_random_perk_locs.size > 0)
		{
			a_s_random_perk_locs = array::randomize(a_s_random_perk_locs);
		}
		n_random_perks_assigned = 0;
	}
	foreach(s_spawn_pos in a_s_spawn_pos)
	{
		perk = s_spawn_pos.script_noteworthy;
		if(isdefined(perk) && isdefined(s_spawn_pos.model))
		{
			if(isdefined(level.randomize_perk_machine_location) && level.randomize_perk_machine_location && a_s_random_perk_locs.size > 0 && isdefined(s_spawn_pos.script_notify))
			{
				s_new_loc = a_s_random_perk_locs[n_random_perks_assigned];
				s_spawn_pos.origin = s_new_loc.origin;
				s_spawn_pos.angles = s_new_loc.angles;
				if(isdefined(s_new_loc.script_int))
				{
					s_spawn_pos.script_int = s_new_loc.script_int;
				}
				if(isdefined(s_new_loc.target))
				{
					s_tell_location = struct::get(s_new_loc.target);
					if(isdefined(s_tell_location))
					{
						util::spawn_model("p7_zm_perk_bottle_broken_" + perk, s_tell_location.origin, s_tell_location.angles);
					}
				}
				n_random_perks_assigned++;
			}
			t_use = spawn("trigger_radius_use", s_spawn_pos.origin + VectorScale((0, 0, 1), 60), 0, 40, 80);
			t_use.targetname = "zombie_vending";
			t_use.script_noteworthy = perk;
			t_use.var_dd212822 = spawn("trigger_radius_use", s_spawn_pos.origin + VectorScale((0, 0, 1), 60), 0, 40, 80);
			if(isdefined(s_spawn_pos.script_int))
			{
				t_use.script_int = s_spawn_pos.script_int;
			}
			t_use triggerignoreteam();
			perk_machine = spawn("script_model", s_spawn_pos.origin);
			if(!isdefined(s_spawn_pos.angles))
			{
				s_spawn_pos.angles = (0, 0, 0);
			}
			perk_machine.angles = s_spawn_pos.angles;
			perk_machine setmodel(s_spawn_pos.model);
			if(isdefined(level._no_vending_machine_bump_trigs) && level._no_vending_machine_bump_trigs)
			{
				bump_trigger = undefined;
			}
			else
			{
				bump_trigger = spawn("trigger_radius", s_spawn_pos.origin + VectorScale((0, 0, 1), 20), 0, 40, 80);
				bump_trigger.script_activated = 1;
				bump_trigger.script_sound = "zmb_perks_bump_bottle";
				bump_trigger.targetname = "audio_bump_trigger";
			}
			if(isdefined(level._no_vending_machine_auto_collision) && level._no_vending_machine_auto_collision)
			{
				collision = undefined;
			}
			else
			{
				collision = spawn("script_model", s_spawn_pos.origin, 1);
				collision.angles = s_spawn_pos.angles;
				collision setmodel("zm_collision_perks1");
				collision.script_noteworthy = "clip";
				collision disconnectpaths();
			}
			t_use.clip = collision;
			t_use.machine = perk_machine;
			t_use.bump = bump_trigger;
			if(isdefined(s_spawn_pos.script_notify))
			{
				perk_machine.script_notify = s_spawn_pos.script_notify;
			}
			if(isdefined(s_spawn_pos.target))
			{
				perk_machine.target = s_spawn_pos.target;
			}
			if(isdefined(s_spawn_pos.blocker_model))
			{
				t_use.blocker_model = s_spawn_pos.blocker_model;
			}
			if(isdefined(s_spawn_pos.script_int))
			{
				perk_machine.script_int = s_spawn_pos.script_int;
			}
			if(isdefined(s_spawn_pos.turn_on_notify))
			{
				perk_machine.turn_on_notify = s_spawn_pos.turn_on_notify;
			}
			t_use.script_sound = "mus_perks_speed_jingle";
			t_use.script_string = "speedcola_perk";
			t_use.script_label = "mus_perks_speed_sting";
			t_use.target = "vending_sleight";
			perk_machine.script_string = "speedcola_perk";
			perk_machine.targetname = "vending_sleight";
			if(isdefined(bump_trigger))
			{
				bump_trigger.script_string = "speedcola_perk";
			}
			if(isdefined(level._custom_perks[perk]) && isdefined(level._custom_perks[perk].perk_machine_set_kvps))
			{
				[[level._custom_perks[perk].perk_machine_set_kvps]](t_use, perk_machine, bump_trigger, collision);
			}
		}
	}
}

/*
	Name: get_perk_machine_start_state
	Namespace: zm_perks
	Checksum: 0x424F4353
	Offset: 0x4C80
	Size: 0x68
	Parameters: 1
	Flags: None
	Line Number: 1734
*/
function get_perk_machine_start_state(perk)
{
	if(isdefined(level.vending_machines_powered_on_at_start) && level.vending_machines_powered_on_at_start)
	{
		return 1;
	}
	if(perk == "specialty_quickrevive")
	{
		/#
			Assert(isdefined(level.revive_machine_is_solo));
		#/
		return level.revive_machine_is_solo;
	}
	return 0;
	ERROR: Exception occured: Stack empty.
}

/*
	Name: perks_register_clientfield
	Namespace: zm_perks
	Checksum: 0x424F4353
	Offset: 0x4CF0
	Size: 0xF8
	Parameters: 0
	Flags: None
	Line Number: 1761
*/
function perks_register_clientfield()
{
	if(isdefined(level.zombiemode_using_perk_intro_fx) && level.zombiemode_using_perk_intro_fx)
	{
		clientfield::register("scriptmover", "clientfield_perk_intro_fx", 1, 1, "int");
	}
	if(isdefined(level._custom_perks))
	{
		a_keys = getarraykeys(level._custom_perks);
		for(i = 0; i < a_keys.size; i++)
		{
			if(isdefined(level._custom_perks[a_keys[i]].clientfield_register))
			{
				level [[level._custom_perks[a_keys[i]].clientfield_register]]();
			}
		}
	}
}

/*
	Name: thread_bump_trigger
	Namespace: zm_perks
	Checksum: 0x424F4353
	Offset: 0x4DF0
	Size: 0x80
	Parameters: 0
	Flags: None
	Line Number: 1790
*/
function thread_bump_trigger()
{
	for(;;)
	{
		self waittill("trigger", trigPlayer);
		trigPlayer playsound(self.script_sound);
		while(zm_utility::is_player_valid(trigPlayer) && trigPlayer istouching(self))
		{
			wait(0.5);
		}
	}
}

/*
	Name: players_are_in_perk_area
	Namespace: zm_perks
	Checksum: 0x424F4353
	Offset: 0x4E78
	Size: 0x168
	Parameters: 1
	Flags: None
	Line Number: 1813
*/
function players_are_in_perk_area(perk_machine)
{
	perk_area_origin = level.quick_revive_default_origin;
	if(isdefined(perk_machine._linked_ent))
	{
		perk_area_origin = perk_machine._linked_ent.origin;
		if(isdefined(perk_machine._linked_ent_offset))
		{
			perk_area_origin = perk_area_origin + perk_machine._linked_ent_offset;
		}
	}
	in_area = 0;
	players = getplayers();
	dist_check = 9216;
	foreach(player in players)
	{
		if(distancesquared(player.origin, perk_area_origin) < dist_check)
		{
			return 1;
		}
	}
	return 0;
}

/*
	Name: perk_hostmigration
	Namespace: zm_perks
	Checksum: 0x424F4353
	Offset: 0x4FE8
	Size: 0x150
	Parameters: 0
	Flags: None
	Line Number: 1847
*/
function perk_hostmigration()
{
	level endon("end_game");
	level notify("perk_hostmigration");
	level endon("perk_hostmigration");
	while(1)
	{
		level waittill("host_migration_end");
		if(isdefined(level._custom_perks) && level._custom_perks.size > 0)
		{
			a_keys = getarraykeys(level._custom_perks);
			foreach(key in a_keys)
			{
				if(isdefined(level._custom_perks[key].radiant_machine_name) && isdefined(level._custom_perks[key].machine_light_effect))
				{
					level thread host_migration_func(level._custom_perks[key], key);
				}
			}
		}
	}
}

/*
	Name: host_migration_func
	Namespace: zm_perks
	Checksum: 0x424F4353
	Offset: 0x5140
	Size: 0x138
	Parameters: 2
	Flags: None
	Line Number: 1879
*/
function host_migration_func(s_custom_perk, keyName)
{
	a_machines = getentarray(s_custom_perk.radiant_machine_name, "targetname");
	foreach(perk in a_machines)
	{
		if(isdefined(perk.model) && perk.model == level.machine_assets[keyName].on_model)
		{
			perk perk_fx(undefined, 1);
			perk thread perk_fx(s_custom_perk.machine_light_effect);
		}
	}
}

/*
	Name: spare_change
	Namespace: zm_perks
	Checksum: 0x424F4353
	Offset: 0x5280
	Size: 0x110
	Parameters: 2
	Flags: None
	Line Number: 1902
*/
function spare_change(str_trigger, str_sound)
{
	if(!isdefined(str_trigger))
	{
		str_trigger = "audio_bump_trigger";
	}
	if(!isdefined(str_sound))
	{
		str_sound = "zmb_perks_bump_bottle";
	}
	a_t_audio = getentarray(str_trigger, "targetname");
	foreach(t_audio_bump in a_t_audio)
	{
		if(t_audio_bump.script_sound === str_sound)
		{
			t_audio_bump thread check_for_change();
		}
	}
}

/*
	Name: check_for_change
	Namespace: zm_perks
	Checksum: 0x424F4353
	Offset: 0x5398
	Size: 0xA8
	Parameters: 0
	Flags: None
	Line Number: 1932
*/
function check_for_change()
{
	self endon("death");
	while(1)
	{
		self waittill("trigger", player);
		if(player getstance() == "prone")
		{
			player zm_score::add_to_player_score(100);
			zm_utility::play_sound_at_pos("purchase", player.origin);
			break;
		}
		wait(0.1);
	}
}

/*
	Name: get_perk_array
	Namespace: zm_perks
	Checksum: 0x424F4353
	Offset: 0x5448
	Size: 0xB0
	Parameters: 0
	Flags: None
	Line Number: 1958
*/
function get_perk_array()
{
	perk_array = [];
	if(level._custom_perks.size > 0)
	{
		a_keys = getarraykeys(level._custom_perks);
		for(i = 0; i < a_keys.size; i++)
		{
			if(self hasperk(a_keys[i]))
			{
				perk_array[perk_array.size] = a_keys[i];
			}
		}
	}
	return perk_array;
}

/*
	Name: initialize_custom_perk_arrays
	Namespace: zm_perks
	Checksum: 0x424F4353
	Offset: 0x5500
	Size: 0x20
	Parameters: 0
	Flags: None
	Line Number: 1985
*/
function initialize_custom_perk_arrays()
{
	if(!isdefined(level._custom_perks))
	{
		level._custom_perks = [];
	}
}

/*
	Name: register_revive_success_perk_func
	Namespace: zm_perks
	Checksum: 0x424F4353
	Offset: 0x5528
	Size: 0x40
	Parameters: 1
	Flags: None
	Line Number: 2003
*/
function register_revive_success_perk_func(revive_func)
{
	if(!isdefined(level.a_revive_success_perk_func))
	{
		level.a_revive_success_perk_func = [];
	}
	level.a_revive_success_perk_func[level.a_revive_success_perk_func.size] = revive_func;
	return;
	ERROR: Exception occured: Stack empty.
}

/*
	Name: register_perk_basic_info
	Namespace: zm_perks
	Checksum: 0x424F4353
	Offset: 0x5570
	Size: 0x1A8
	Parameters: 5
	Flags: None
	Line Number: 2024
*/
function register_perk_basic_info(str_perk, str_alias, n_perk_cost, str_hint_string, w_perk_bottle_weapon)
{
	/#
		Assert(isdefined(str_perk), "Dev Block strings are not supported");
	#/
	/#
		Assert(isdefined(str_alias), "Dev Block strings are not supported");
	#/
	/#
		Assert(isdefined(n_perk_cost), "Dev Block strings are not supported");
	#/
	/#
		Assert(isdefined(str_hint_string), "Dev Block strings are not supported");
	#/
	/#
		Assert(isdefined(w_perk_bottle_weapon), "Dev Block strings are not supported");
	#/
	_register_undefined_perk(str_perk);
	level._custom_perks[str_perk].alias = str_alias;
	level._custom_perks[str_perk].hash_id = HashString(str_alias);
	level._custom_perks[str_perk].cost = n_perk_cost;
	level._custom_perks[str_perk].hint_string = str_hint_string;
	level._custom_perks[str_perk].perk_bottle_weapon = w_perk_bottle_weapon;
}

/*
	Name: register_perk_machine
	Namespace: zm_perks
	Checksum: 0x424F4353
	Offset: 0x5720
	Size: 0x100
	Parameters: 3
	Flags: None
	Line Number: 2059
*/
function register_perk_machine(str_perk, func_perk_machine_setup, func_perk_machine_thread)
{
	/#
		Assert(isdefined(str_perk), "Dev Block strings are not supported");
	#/
	/#
		Assert(isdefined(func_perk_machine_setup), "Dev Block strings are not supported");
	#/
	_register_undefined_perk(str_perk);
	if(!isdefined(level._custom_perks[str_perk].perk_machine_set_kvps))
	{
		level._custom_perks[str_perk].perk_machine_set_kvps = func_perk_machine_setup;
	}
	if(!isdefined(level._custom_perks[str_perk].perk_machine_thread) && isdefined(func_perk_machine_thread))
	{
		level._custom_perks[str_perk].perk_machine_thread = func_perk_machine_thread;
	}
}

/*
	Name: register_perk_machine_power_override
	Namespace: zm_perks
	Checksum: 0x424F4353
	Offset: 0x5828
	Size: 0xC0
	Parameters: 2
	Flags: None
	Line Number: 2088
*/
function register_perk_machine_power_override(str_perk, func_perk_machine_power_override)
{
	/#
		Assert(isdefined(str_perk), "Dev Block strings are not supported");
	#/
	/#
		Assert(isdefined(func_perk_machine_power_override), "Dev Block strings are not supported");
	#/
	_register_undefined_perk(str_perk);
	if(!isdefined(level._custom_perks[str_perk].perk_machine_power_override_thread) && isdefined(func_perk_machine_power_override))
	{
		level._custom_perks[str_perk].perk_machine_power_override_thread = func_perk_machine_power_override;
	}
}

/*
	Name: register_perk_precache_func
	Namespace: zm_perks
	Checksum: 0x424F4353
	Offset: 0x58F0
	Size: 0xB8
	Parameters: 2
	Flags: None
	Line Number: 2113
*/
function register_perk_precache_func(str_perk, func_precache)
{
	/#
		Assert(isdefined(str_perk), "Dev Block strings are not supported");
	#/
	/#
		Assert(isdefined(func_precache), "Dev Block strings are not supported");
	#/
	_register_undefined_perk(str_perk);
	if(!isdefined(level._custom_perks[str_perk].precache_func))
	{
		level._custom_perks[str_perk].precache_func = func_precache;
	}
}

/*
	Name: register_perk_threads
	Namespace: zm_perks
	Checksum: 0x424F4353
	Offset: 0x59B0
	Size: 0x100
	Parameters: 3
	Flags: None
	Line Number: 2138
*/
function register_perk_threads(str_perk, func_give_player_perk, func_take_player_perk)
{
	/#
		Assert(isdefined(str_perk), "Dev Block strings are not supported");
	#/
	/#
		Assert(isdefined(func_give_player_perk), "Dev Block strings are not supported");
	#/
	_register_undefined_perk(str_perk);
	if(!isdefined(level._custom_perks[str_perk].player_thread_give))
	{
		level._custom_perks[str_perk].player_thread_give = func_give_player_perk;
	}
	if(isdefined(func_take_player_perk))
	{
		if(!isdefined(level._custom_perks[str_perk].player_thread_take))
		{
			level._custom_perks[str_perk].player_thread_take = func_take_player_perk;
		}
	}
}

/*
	Name: register_perk_clientfields
	Namespace: zm_perks
	Checksum: 0x424F4353
	Offset: 0x5AB8
	Size: 0x120
	Parameters: 3
	Flags: None
	Line Number: 2170
*/
function register_perk_clientfields(str_perk, func_clientfield_register, func_clientfield_set)
{
	/#
		Assert(isdefined(str_perk), "Dev Block strings are not supported");
	#/
	/#
		Assert(isdefined(func_clientfield_register), "Dev Block strings are not supported");
	#/
	/#
		Assert(isdefined(func_clientfield_set), "Dev Block strings are not supported");
	#/
	_register_undefined_perk(str_perk);
	if(!isdefined(level._custom_perks[str_perk].clientfield_register))
	{
		level._custom_perks[str_perk].clientfield_register = func_clientfield_register;
	}
	if(!isdefined(level._custom_perks[str_perk].clientfield_set))
	{
		level._custom_perks[str_perk].clientfield_set = func_clientfield_set;
	}
}

/*
	Name: register_perk_host_migration_params
	Namespace: zm_perks
	Checksum: 0x424F4353
	Offset: 0x5BE0
	Size: 0x120
	Parameters: 3
	Flags: None
	Line Number: 2202
*/
function register_perk_host_migration_params(str_perk, str_radiant_name, str_effect_name)
{
	/#
		Assert(isdefined(str_perk), "Dev Block strings are not supported");
	#/
	/#
		Assert(isdefined(str_radiant_name), "Dev Block strings are not supported");
	#/
	/#
		Assert(isdefined(str_effect_name), "Dev Block strings are not supported");
	#/
	_register_undefined_perk(str_perk);
	if(!isdefined(level._custom_perks[str_perk].radiant_name))
	{
		level._custom_perks[str_perk].radiant_machine_name = str_radiant_name;
	}
	if(!isdefined(level._custom_perks[str_perk].light_effect))
	{
		level._custom_perks[str_perk].machine_light_effect = str_effect_name;
	}
}

/*
	Name: _register_undefined_perk
	Namespace: zm_perks
	Checksum: 0x424F4353
	Offset: 0x5D08
	Size: 0x60
	Parameters: 1
	Flags: None
	Line Number: 2234
*/
function _register_undefined_perk(str_perk)
{
	if(!isdefined(level._custom_perks))
	{
		level._custom_perks = [];
	}
	if(!isdefined(level._custom_perks[str_perk]))
	{
		level._custom_perks[str_perk] = spawnstruct();
	}
}

/*
	Name: register_perk_damage_override_func
	Namespace: zm_perks
	Checksum: 0x424F4353
	Offset: 0x5D70
	Size: 0x6C
	Parameters: 1
	Flags: None
	Line Number: 2256
*/
function register_perk_damage_override_func(func_damage_override)
{
	/#
		Assert(isdefined(func_damage_override), "Dev Block strings are not supported");
	#/
	if(!isdefined(level.perk_damage_override))
	{
		level.perk_damage_override = [];
	}
	array::add(level.perk_damage_override, func_damage_override, 0);
}

