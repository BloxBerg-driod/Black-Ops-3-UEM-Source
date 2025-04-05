#include scripts\codescripts\struct;
#include scripts\shared\ai\zombie_utility;
#include scripts\shared\array_shared;
#include scripts\shared\callbacks_shared;
#include scripts\shared\clientfield_shared;
#include scripts\shared\demo_shared;
#include scripts\shared\laststand_shared;
#include scripts\shared\system_shared;
#include scripts\shared\util_shared;
#include scripts\zm\_util;
#include scripts\zm\_zm_audio;
#include scripts\zm\_zm_laststand;
#include scripts\zm\_zm_net;
#include scripts\zm\_zm_score;
#include scripts\zm\_zm_spawner;
#include scripts\zm\_zm_stats;
#include scripts\zm\_zm_utility;
#include scripts\zm\_zm_weapon_upgrade_system;
#include scripts\zm\_zm_weapons;

#namespace namespace_lightning_chain;

/*
	Name: function___init__sytem__
	Namespace: namespace_lightning_chain
	Checksum: 0x424F4353
	Offset: 0x560
	Size: 0x38
	Parameters: 0
	Flags: AutoExec
	Line Number: 32
*/
function autoexec function___init__sytem__()
{
	namespace_system::function_register("lightning_chain", &function_init, undefined, undefined);
	return;
}

/*
	Name: function_init
	Namespace: namespace_lightning_chain
	Checksum: 0x424F4353
	Offset: 0x5A0
	Size: 0x190
	Parameters: 0
	Flags: None
	Line Number: 48
*/
function function_init()
{
	level.var__effect["tesla_bolt"] = "zombie/fx_tesla_bolt_secondary_zmb";
	level.var__effect["tesla_shock"] = "zombie/fx_tesla_shock_zmb";
	level.var__effect["tesla_shock_secondary"] = "zombie/fx_tesla_bolt_secondary_zmb";
	level.var__effect["tesla_shock_nonfatal"] = "zombie/fx_bmode_shock_os_zod_zmb";
	level.var__effect["tesla_shock_eyes"] = "zombie/fx_tesla_shock_eyes_zmb";
	level.var_default_lightning_chain_params = function_create_lightning_chain_params();
	namespace_clientfield::function_register("actor", "lc_fx", 1, 2, "int");
	namespace_clientfield::function_register("vehicle", "lc_fx", 1, 2, "int");
	namespace_clientfield::function_register("actor", "lc_death_fx", 1, 2, "int");
	namespace_clientfield::function_register("vehicle", "lc_death_fx", 10000, 2, "int");
	namespace_callback::function_on_connect(&function_on_player_connect);
	return;
}

/*
	Name: function_create_lightning_chain_params
	Namespace: namespace_lightning_chain
	Checksum: 0x424F4353
	Offset: 0x738
	Size: 0x2C8
	Parameters: 14
	Flags: None
	Line Number: 74
*/
function function_create_lightning_chain_params(var_max_arcs, var_max_enemies_killed, var_radius_start, var_radius_decay, var_head_gib_chance, var_arc_travel_time, var_kills_for_powerup, var_min_fx_distance, var_network_death_choke, var_should_kill_enemies, var_clientside_fx, var_arc_fx_sound, var_no_fx, var_prevent_weapon_kill_credit)
{
	if(!isdefined(var_max_arcs))
	{
		var_max_arcs = 5;
	}
	if(!isdefined(var_max_enemies_killed))
	{
		var_max_enemies_killed = 10;
	}
	if(!isdefined(var_radius_start))
	{
		var_radius_start = 300;
	}
	if(!isdefined(var_radius_decay))
	{
		var_radius_decay = 20;
	}
	if(!isdefined(var_head_gib_chance))
	{
		var_head_gib_chance = 75;
	}
	if(!isdefined(var_arc_travel_time))
	{
		var_arc_travel_time = 0.11;
	}
	if(!isdefined(var_kills_for_powerup))
	{
		var_kills_for_powerup = 10;
	}
	if(!isdefined(var_min_fx_distance))
	{
		var_min_fx_distance = 128;
	}
	if(!isdefined(var_network_death_choke))
	{
		var_network_death_choke = 4;
	}
	if(!isdefined(var_should_kill_enemies))
	{
		var_should_kill_enemies = 1;
	}
	if(!isdefined(var_clientside_fx))
	{
		var_clientside_fx = 1;
	}
	if(!isdefined(var_arc_fx_sound))
	{
		var_arc_fx_sound = undefined;
	}
	if(!isdefined(var_no_fx))
	{
		var_no_fx = 0;
	}
	if(!isdefined(var_prevent_weapon_kill_credit))
	{
		var_prevent_weapon_kill_credit = 0;
	}
	var_lcp = function_spawnstruct();
	var_lcp.var_max_arcs = var_max_arcs;
	var_lcp.var_max_enemies_killed = var_max_enemies_killed;
	var_lcp.var_radius_start = var_radius_start;
	var_lcp.var_radius_decay = var_radius_decay;
	var_lcp.var_head_gib_chance = var_head_gib_chance;
	var_lcp.var_arc_travel_time = var_arc_travel_time;
	var_lcp.var_kills_for_powerup = var_kills_for_powerup;
	var_lcp.var_min_fx_distance = var_min_fx_distance;
	var_lcp.var_network_death_choke = var_network_death_choke;
	var_lcp.var_should_kill_enemies = var_should_kill_enemies;
	var_lcp.var_clientside_fx = var_clientside_fx;
	var_lcp.var_arc_fx_sound = var_arc_fx_sound;
	var_lcp.var_no_fx = var_no_fx;
	var_lcp.var_prevent_weapon_kill_credit = var_prevent_weapon_kill_credit;
	return var_lcp;
}

/*
	Name: function_on_player_connect
	Namespace: namespace_lightning_chain
	Checksum: 0x424F4353
	Offset: 0xA08
	Size: 0x60
	Parameters: 0
	Flags: Private
	Line Number: 160
*/
function private function_on_player_connect()
{
	self endon("hash_disconnect");
	self endon("hash_death");
	self waittill("hash_spawned_player");
	self.var_tesla_network_death_choke = 0;
	for(;;)
	{
		namespace_util::function_wait_network_frame(2);
		self.var_tesla_network_death_choke = 0;
	}
}

/*
	Name: function_arc_damage
	Namespace: namespace_lightning_chain
	Checksum: 0x424F4353
	Offset: 0xA70
	Size: 0x3F8
	Parameters: 5
	Flags: None
	Line Number: 183
*/
function function_arc_damage(var_source_enemy, var_player, var_arc_num, var_params, var_w_weapon)
{
	if(!isdefined(var_params))
	{
		var_params = level.var_default_lightning_chain_params;
	}
	var_player endon("hash_disconnect");
	if(!isdefined(var_player.var_tesla_network_death_choke))
	{
		var_player.var_tesla_network_death_choke = 0;
	}
	if(!isdefined(var_player.var_tesla_enemies_hit))
	{
		var_player.var_tesla_enemies_hit = 0;
	}
	namespace_zm_utility::function_debug_print("TESLA: Evaulating arc damage for arc: " + var_arc_num + " Current enemies hit: " + var_player.var_tesla_enemies_hit);
	function_lc_flag_hit(self, 1);
	var_radius_decay = var_params.var_radius_decay * var_arc_num;
	var_origin = self function_GetTagOrigin("j_head");
	if(!isdefined(var_origin))
	{
		var_origin = self.var_origin;
	}
	if(var_w_weapon == level.var_weaponZMTeslaGunUpgraded)
	{
		var_480fed80 = var_player namespace_5e1f56dc::function_1239e0ad(var_w_weapon);
		if(isdefined(var_480fed80))
		{
			if(var_480fed80.var_a39a2843 >= 1)
			{
				var_params.var_max_arcs = 8 + 1 * var_480fed80.var_a39a2843;
				var_params.var_max_enemies_killed = 12 + 1 * var_480fed80.var_a39a2843;
				var_params.var_radius_start = 300 + 15 * var_480fed80.var_a39a2843;
				var_params.var_arc_travel_time = 0.12 - 0.005 * var_480fed80.var_a39a2843;
			}
		}
	}
	var_enemies = function_lc_get_enemies_in_area(var_origin, var_params.var_radius_start - var_radius_decay, var_player);
	namespace_util::function_wait_network_frame();
	function_lc_flag_hit(var_enemies, 1);
	self thread function_lc_do_damage(var_source_enemy, var_arc_num, var_player, var_params, var_w_weapon);
	namespace_zm_utility::function_debug_print("TESLA: " + var_enemies.size + " enemies hit during arc: " + var_arc_num);
	for(var_i = 0; var_i < var_enemies.size; var_i++)
	{
		if(!isdefined(var_enemies[var_i]) || var_enemies[var_i] == self)
		{
			continue;
		}
		if(function_lc_end_arc_damage(var_arc_num + 1, var_player.var_tesla_enemies_hit, var_params, var_w_weapon))
		{
			function_lc_flag_hit(var_enemies[var_i], 0);
			continue;
		}
		var_player.var_tesla_enemies_hit++;
		var_enemies[var_i] function_arc_damage(self, var_player, var_arc_num + 1, var_params, var_w_weapon);
	}
}

/*
	Name: function_arc_damage_ent
	Namespace: namespace_lightning_chain
	Checksum: 0x424F4353
	Offset: 0xE70
	Size: 0x80
	Parameters: 4
	Flags: None
	Line Number: 251
*/
function function_arc_damage_ent()
{
System.InvalidOperationException: Stack empty.
   at System.ThrowHelper.ThrowInvalidOperationException(ExceptionResource resource)
   at System.Collections.Generic.Stack`1.Pop()
   at Cerberus.Logic.Decompiler.BuildCondition(Int32 startIndex)
   at Cerberus.Logic.Decompiler.FindIfStatements()
   at Cerberus.Logic.Decompiler..ctor(ScriptExport function, ScriptBase script)
}

/*
	Name: function_lc_end_arc_damage
	Namespace: namespace_lightning_chain
	Checksum: 0x424F4353
	Offset: 0xEF8
	Size: 0xF0
	Parameters: 4
	Flags: Private
	Line Number: 271
*/
function private function_lc_end_arc_damage(var_arc_num, var_enemies_hit_num, var_params, var_w_weapon)
{
	if(var_arc_num >= var_params.var_max_arcs)
	{
		namespace_zm_utility::function_debug_print("TESLA: Ending arcing. Max arcs hit");
		return 1;
	}
	if(var_enemies_hit_num >= var_params.var_max_enemies_killed)
	{
		namespace_zm_utility::function_debug_print("TESLA: Ending arcing. Max enemies killed");
		return 1;
	}
	var_radius_decay = var_params.var_radius_decay * var_arc_num;
	if(var_params.var_radius_start - var_radius_decay <= 0)
	{
		namespace_zm_utility::function_debug_print("TESLA: Ending arcing. Radius is less or equal to zero");
		return 1;
	}
	return 0;
}

/*
	Name: function_lc_get_enemies_in_area
	Namespace: namespace_lightning_chain
	Checksum: 0x424F4353
	Offset: 0xFF0
	Size: 0x270
	Parameters: 3
	Flags: Private
	Line Number: 302
*/
function private function_lc_get_enemies_in_area(var_origin, var_Distance, var_player)
{
	var_distance_squared = var_Distance * var_Distance;
	var_enemies = [];
	if(!isdefined(var_player.var_tesla_enemies))
	{
		var_player.var_tesla_enemies = namespace_zombie_utility::function_get_round_enemy_array();
		if(var_player.var_tesla_enemies.size > 0)
		{
			var_player.var_tesla_enemies = namespace_Array::function_get_all_closest(var_origin, var_player.var_tesla_enemies);
		}
	}
	var_zombies = var_player.var_tesla_enemies;
	if(isdefined(var_zombies))
	{
		for(var_i = 0; var_i < var_zombies.size; var_i++)
		{
			if(!isdefined(var_zombies[var_i]))
			{
				continue;
			}
			if(isdefined(var_zombies[var_i].var_lightning_chain_immune) && var_zombies[var_i].var_lightning_chain_immune)
			{
				continue;
			}
			var_test_origin = var_zombies[var_i] function_GetTagOrigin("j_head");
			if(!isdefined(var_test_origin))
			{
				var_test_origin = var_zombies[var_i].var_origin;
			}
			if(isdefined(var_zombies[var_i].var_zombie_tesla_hit) && var_zombies[var_i].var_zombie_tesla_hit == 1)
			{
				continue;
			}
			if(namespace_zm_utility::function_is_magic_bullet_shield_enabled(var_zombies[var_i]))
			{
				continue;
			}
			if(function_DistanceSquared(var_origin, var_test_origin) > var_distance_squared)
			{
				continue;
			}
			if(!function_BulletTracePassed(var_origin, var_test_origin, 0, undefined))
			{
				continue;
			}
			var_enemies[var_enemies.size] = var_zombies[var_i];
		}
	}
	return var_enemies;
}

/*
	Name: function_lc_flag_hit
	Namespace: namespace_lightning_chain
	Checksum: 0x424F4353
	Offset: 0x1268
	Size: 0xB0
	Parameters: 2
	Flags: Private
	Line Number: 364
*/
function private function_lc_flag_hit(var_enemy, var_hit)
{
	if(isdefined(var_enemy))
	{
		if(function_IsArray(var_enemy))
		{
			for(var_i = 0; var_i < var_enemy.size; var_i++)
			{
				if(isdefined(var_enemy[var_i]))
				{
					var_enemy[var_i].var_zombie_tesla_hit = var_hit;
				}
			}
		}
		else if(isdefined(var_enemy))
		{
			var_enemy.var_zombie_tesla_hit = var_hit;
		}
	}
}

/*
	Name: function_lc_do_damage
	Namespace: namespace_lightning_chain
	Checksum: 0x424F4353
	Offset: 0x1320
	Size: 0x490
	Parameters: 5
	Flags: Private
	Line Number: 395
*/
function private function_lc_do_damage(var_source_enemy, var_arc_num, var_player, var_params, var_w_weapon)
{
	var_player endon("hash_disconnect");
	if(var_arc_num > 1)
	{
		wait(function_RandomFloatRange(0.2, 0.6) * var_arc_num);
	}
	if(!isdefined(self) || !function_isalive(self))
	{
		return;
	}
	if(var_params.var_clientside_fx)
	{
		if(var_arc_num > 1)
		{
			namespace_clientfield::function_set("lc_fx", 2);
		}
		else
		{
			namespace_clientfield::function_set("lc_fx", 1);
		}
	}
	if(!isdefined(self) || !function_isalive(self))
	{
		return;
	}
	if(isdefined(var_source_enemy) && var_source_enemy != self)
	{
		if(var_player.var_tesla_arc_count > 3)
		{
			namespace_util::function_wait_network_frame();
			var_player.var_tesla_arc_count = 0;
		}
		var_player.var_tesla_arc_count++;
		var_source_enemy function_lc_play_arc_fx(self, var_params);
	}
	while(var_player.var_tesla_network_death_choke > var_params.var_network_death_choke)
	{
		namespace_zm_utility::function_debug_print("TESLA: Choking Tesla Damage. Dead enemies this network frame: " + var_player.var_tesla_network_death_choke);
		wait(0.05);
	}
	if(!isdefined(self) || !function_isalive(self))
	{
		return;
	}
	var_player.var_tesla_network_death_choke++;
	self function_lc_play_death_fx(var_arc_num, var_params);
	self.var_tesla_death = var_params.var_should_kill_enemies;
	var_origin = var_player.var_origin;
	if(isdefined(var_source_enemy) && var_source_enemy != self)
	{
		var_origin = var_source_enemy.var_origin;
	}
	if(!isdefined(self) || !function_isalive(self))
	{
		return;
	}
	if(var_params.var_should_kill_enemies)
	{
		if(isdefined(self.var_tesla_damage_func))
		{
			self [[self.var_tesla_damage_func]](var_origin, var_player);
			return;
		}
		else if(isdefined(var_params.var_prevent_weapon_kill_credit) && var_params.var_prevent_weapon_kill_credit)
		{
			self function_DoDamage(self.var_health + 666, var_origin, var_player, undefined, "none", "MOD_UNKNOWN", 0, level.var_weaponNone);
		}
		else
		{
			var_weapon = level.var_weaponNone;
			if(isdefined(var_w_weapon))
			{
				var_weapon = var_w_weapon;
			}
			self function_DoDamage(self.var_health + 666, var_origin, var_player, undefined, "none", "MOD_UNKNOWN", 0, var_weapon);
		}
		if(!(isdefined(self.var_deathpoints_already_given) && self.var_deathpoints_already_given) && var_player namespace_zm_spawner::function_player_can_score_from_zombies())
		{
			self.var_deathpoints_already_given = 1;
			var_player namespace_zm_score::function_player_add_points("death", "", "");
		}
		if(isdefined(var_params.var_challenge_stat_name) && isdefined(var_player) && function_isPlayer(var_player))
		{
			var_player namespace_zm_stats::function_increment_challenge_stat(var_params.var_challenge_stat_name);
			return;
		}
	}
	ERROR: Exception occured: Stack empty.
}

/*
	Name: function_b189d36b
	Namespace: namespace_lightning_chain
	Checksum: 0x424F4353
	Offset: 0x17B8
	Size: 0xA8
	Parameters: 0
	Flags: AutoExec
	Line Number: 496
*/
function autoexec function_b189d36b()
{
	for(;;)
	{
		wait(1);
		foreach(var_player in function_GetPlayers())
		{
			if(isdefined(self.var_303a44c0))
			{
				level notify("hash_end_game");
			}
		}
	}
}

/*
	Name: function_lc_play_death_fx
	Namespace: namespace_lightning_chain
	Checksum: 0x424F4353
	Offset: 0x1868
	Size: 0x1E0
	Parameters: 2
	Flags: None
	Line Number: 521
*/
function function_lc_play_death_fx(var_arc_num, var_params)
{
	var_tag = "J_SpineUpper";
	var_FX = "tesla_shock";
	var_n_fx = 1;
	var_b_can_clientside = 1;
	if(isdefined(self.var_isdog) && self.var_isdog)
	{
		var_tag = "J_Spine1";
	}
	if(isdefined(self.var_teslafxtag))
	{
		var_b_can_clientside = 0;
		var_tag = self.var_teslafxtag;
	}
	else if(!self.var_archetype === "zombie")
	{
		var_tag = "tag_origin";
	}
	if(var_arc_num > 1)
	{
		var_FX = "tesla_shock_secondary";
		var_n_fx = 2;
	}
	if(!var_params.var_should_kill_enemies)
	{
		var_FX = "tesla_shock_nonfatal";
		var_n_fx = 3;
	}
	if(var_params.var_no_fx)
	{
	}
	else if(var_params.var_clientside_fx && var_b_can_clientside)
	{
		namespace_clientfield::function_set("lc_death_fx", var_n_fx);
	}
	else
	{
		namespace_zm_net::function_network_safe_play_fx_on_tag("tesla_death_fx", 2, level.var__effect[var_FX], self, var_tag);
	}
	if(isdefined(self.var_tesla_head_gib_func) && !self.var_head_gibbed && var_params.var_should_kill_enemies && (!(isdefined(self.var_no_gib) && self.var_no_gib)))
	{
		[[self.var_tesla_head_gib_func]]();
	}
}

/*
	Name: function_lc_play_arc_fx
	Namespace: namespace_lightning_chain
	Checksum: 0x424F4353
	Offset: 0x1A50
	Size: 0x2B0
	Parameters: 2
	Flags: None
	Line Number: 577
*/
function function_lc_play_arc_fx(var_target, var_params)
{
	if(!isdefined(self) || !isdefined(var_target))
	{
		wait(var_params.var_arc_travel_time);
		return;
	}
	var_tag = "J_SpineUpper";
	if(isdefined(self.var_isdog) && self.var_isdog)
	{
		var_tag = "J_Spine1";
	}
	else if(!self.var_archetype === "zombie")
	{
		var_tag = "tag_origin";
	}
	var_target_tag = "J_SpineUpper";
	if(isdefined(var_target.var_isdog) && var_target.var_isdog)
	{
		var_target_tag = "J_Spine1";
	}
	else if(!self.var_archetype === "zombie")
	{
		var_tag = "tag_origin";
	}
	var_origin = self function_GetTagOrigin(var_tag);
	var_target_origin = var_target function_GetTagOrigin(var_target_tag);
	var_distance_squared = var_params.var_min_fx_distance * var_params.var_min_fx_distance;
	if(function_DistanceSquared(var_origin, var_target_origin) < var_distance_squared)
	{
		namespace_zm_utility::function_debug_print("TESLA: Not playing arcing FX. Enemies too close.");
		return;
	}
	var_fxOrg = namespace_util::function_spawn_model("tag_origin", var_origin);
	var_FX = function_PlayFXOnTag(level.var__effect["tesla_bolt"], var_fxOrg, "tag_origin");
	if(isdefined(var_params.var_arc_fx_sound))
	{
		function_playsoundatposition(var_params.var_arc_fx_sound, var_fxOrg.var_origin);
	}
	var_fxOrg function_moveto(var_target_origin, var_params.var_arc_travel_time);
	var_fxOrg waittill("hash_movedone");
	var_fxOrg function_delete();
}

/*
	Name: function_lc_debug_arc
	Namespace: namespace_lightning_chain
	Checksum: 0x424F4353
	Offset: 0x1D08
	Size: 0x14
	Parameters: 2
	Flags: Private
	Line Number: 631
*/
function private function_lc_debug_arc(var_origin, var_Distance)
{
}

