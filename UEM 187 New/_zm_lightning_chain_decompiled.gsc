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

#namespace lightning_chain;

/*
	Name: __init__sytem__
	Namespace: lightning_chain
	Checksum: 0x424F4353
	Offset: 0x560
	Size: 0x38
	Parameters: 0
	Flags: AutoExec
	Line Number: 32
*/
function autoexec __init__sytem__()
{
	system::register("lightning_chain", &init, undefined, undefined);
}

/*
	Name: init
	Namespace: lightning_chain
	Checksum: 0x424F4353
	Offset: 0x5A0
	Size: 0x190
	Parameters: 0
	Flags: None
	Line Number: 47
*/
function init()
{
	level._effect["tesla_bolt"] = "zombie/fx_tesla_bolt_secondary_zmb";
	level._effect["tesla_shock"] = "zombie/fx_tesla_shock_zmb";
	level._effect["tesla_shock_secondary"] = "zombie/fx_tesla_bolt_secondary_zmb";
	level._effect["tesla_shock_nonfatal"] = "zombie/fx_bmode_shock_os_zod_zmb";
	level._effect["tesla_shock_eyes"] = "zombie/fx_tesla_shock_eyes_zmb";
	level.default_lightning_chain_params = create_lightning_chain_params();
	clientfield::register("actor", "lc_fx", 1, 2, "int");
	clientfield::register("vehicle", "lc_fx", 1, 2, "int");
	clientfield::register("actor", "lc_death_fx", 1, 2, "int");
	clientfield::register("vehicle", "lc_death_fx", 10000, 2, "int");
	callback::on_connect(&on_player_connect);
}

/*
	Name: create_lightning_chain_params
	Namespace: lightning_chain
	Checksum: 0x424F4353
	Offset: 0x738
	Size: 0x2C8
	Parameters: 14
	Flags: None
	Line Number: 72
*/
function create_lightning_chain_params(max_arcs, max_enemies_killed, radius_start, radius_decay, head_gib_chance, arc_travel_time, kills_for_powerup, min_fx_distance, network_death_choke, should_kill_enemies, clientside_fx, arc_fx_sound, no_fx, prevent_weapon_kill_credit)
{
	if(!isdefined(max_arcs))
	{
		max_arcs = 5;
	}
	if(!isdefined(max_enemies_killed))
	{
		max_enemies_killed = 10;
	}
	if(!isdefined(radius_start))
	{
		radius_start = 300;
	}
	if(!isdefined(radius_decay))
	{
		radius_decay = 20;
	}
	if(!isdefined(head_gib_chance))
	{
		head_gib_chance = 75;
	}
	if(!isdefined(arc_travel_time))
	{
		arc_travel_time = 0.11;
	}
	if(!isdefined(kills_for_powerup))
	{
		kills_for_powerup = 10;
	}
	if(!isdefined(min_fx_distance))
	{
		min_fx_distance = 128;
	}
	if(!isdefined(network_death_choke))
	{
		network_death_choke = 4;
	}
	if(!isdefined(should_kill_enemies))
	{
		should_kill_enemies = 1;
	}
	if(!isdefined(clientside_fx))
	{
		clientside_fx = 1;
	}
	if(!isdefined(arc_fx_sound))
	{
		arc_fx_sound = undefined;
	}
	if(!isdefined(no_fx))
	{
		no_fx = 0;
	}
	if(!isdefined(prevent_weapon_kill_credit))
	{
		prevent_weapon_kill_credit = 0;
	}
	lcp = spawnstruct();
	lcp.max_arcs = max_arcs;
	lcp.max_enemies_killed = max_enemies_killed;
	lcp.radius_start = radius_start;
	lcp.radius_decay = radius_decay;
	lcp.head_gib_chance = head_gib_chance;
	lcp.arc_travel_time = arc_travel_time;
	lcp.kills_for_powerup = kills_for_powerup;
	lcp.min_fx_distance = min_fx_distance;
	lcp.network_death_choke = network_death_choke;
	lcp.should_kill_enemies = should_kill_enemies;
	lcp.clientside_fx = clientside_fx;
	lcp.arc_fx_sound = arc_fx_sound;
	lcp.no_fx = no_fx;
	lcp.prevent_weapon_kill_credit = prevent_weapon_kill_credit;
	return lcp;
}

/*
	Name: on_player_connect
	Namespace: lightning_chain
	Checksum: 0x424F4353
	Offset: 0xA08
	Size: 0x60
	Parameters: 0
	Flags: Private
	Line Number: 158
*/
function private on_player_connect()
{
	self endon("disconnect");
	self endon("death");
	self waittill("spawned_player");
	self.tesla_network_death_choke = 0;
	for(;;)
	{
		util::wait_network_frame(2);
		self.tesla_network_death_choke = 0;
	}
	return;
}

/*
	Name: arc_damage
	Namespace: lightning_chain
	Checksum: 0x424F4353
	Offset: 0xA70
	Size: 0x3F8
	Parameters: 5
	Flags: None
	Line Number: 182
*/
function arc_damage(source_enemy, player, arc_num, params, w_weapon)
{
	if(!isdefined(params))
	{
		params = level.default_lightning_chain_params;
	}
	player endon("disconnect");
	if(!isdefined(player.tesla_network_death_choke))
	{
		player.tesla_network_death_choke = 0;
	}
	if(!isdefined(player.tesla_enemies_hit))
	{
		player.tesla_enemies_hit = 0;
	}
	zm_utility::debug_print("TESLA: Evaulating arc damage for arc: " + arc_num + " Current enemies hit: " + player.tesla_enemies_hit);
	lc_flag_hit(self, 1);
	radius_decay = params.radius_decay * arc_num;
	origin = self gettagorigin("j_head");
	if(!isdefined(origin))
	{
		origin = self.origin;
	}
	if(w_weapon == level.weaponZMTeslaGunUpgraded)
	{
		var_480fed80 = player namespace_5e1f56dc::function_1239e0ad(w_weapon);
		if(isdefined(var_480fed80))
		{
			if(var_480fed80.var_a39a2843 >= 1)
			{
				params.max_arcs = 8 + 1 * var_480fed80.var_a39a2843;
				params.max_enemies_killed = 12 + 1 * var_480fed80.var_a39a2843;
				params.radius_start = 300 + 15 * var_480fed80.var_a39a2843;
				params.arc_travel_time = 0.12 - 0.005 * var_480fed80.var_a39a2843;
			}
		}
	}
	enemies = lc_get_enemies_in_area(origin, params.radius_start - radius_decay, player);
	util::wait_network_frame();
	lc_flag_hit(enemies, 1);
	self thread lc_do_damage(source_enemy, arc_num, player, params, w_weapon);
	zm_utility::debug_print("TESLA: " + enemies.size + " enemies hit during arc: " + arc_num);
	for(i = 0; i < enemies.size; i++)
	{
		if(!isdefined(enemies[i]) || enemies[i] == self)
		{
			continue;
		}
		if(lc_end_arc_damage(arc_num + 1, player.tesla_enemies_hit, params, w_weapon))
		{
			lc_flag_hit(enemies[i], 0);
			continue;
		}
		player.tesla_enemies_hit++;
		enemies[i] arc_damage(self, player, arc_num + 1, params, w_weapon);
	}
}

/*
	Name: arc_damage_ent
	Namespace: lightning_chain
	Checksum: 0x424F4353
	Offset: 0xE70
	Size: 0x80
	Parameters: 4
	Flags: None
	Line Number: 250
*/
function arc_damage_ent(player, arc_num, params, w_weapon)
{
	if(!isdefined(params))
	{
		params = level.default_lightning_chain_params;
	}
	lc_flag_hit(self, 1);
	self thread lc_do_damage(self, arc_num, player, params, w_weapon);
	return;
	ERROR: Bad function call
}

/*
	Name: lc_end_arc_damage
	Namespace: lightning_chain
	Checksum: 0x424F4353
	Offset: 0xEF8
	Size: 0xF0
	Parameters: 4
	Flags: Private
	Line Number: 272
*/
function private lc_end_arc_damage(arc_num, enemies_hit_num, params, w_weapon)
{
	if(arc_num >= params.max_arcs)
	{
		zm_utility::debug_print("TESLA: Ending arcing. Max arcs hit");
		return 1;
	}
	if(enemies_hit_num >= params.max_enemies_killed)
	{
		zm_utility::debug_print("TESLA: Ending arcing. Max enemies killed");
		return 1;
	}
	radius_decay = params.radius_decay * arc_num;
	if(params.radius_start - radius_decay <= 0)
	{
		zm_utility::debug_print("TESLA: Ending arcing. Radius is less or equal to zero");
		return 1;
	}
	return 0;
	ERROR: Exception occured: Stack empty.
}

/*
	Name: lc_get_enemies_in_area
	Namespace: lightning_chain
	Checksum: 0x424F4353
	Offset: 0xFF0
	Size: 0x270
	Parameters: 3
	Flags: Private
	Line Number: 304
*/
function private lc_get_enemies_in_area(origin, distance, player)
{
	distance_squared = distance * distance;
	enemies = [];
	if(!isdefined(player.tesla_enemies))
	{
		player.tesla_enemies = zombie_utility::get_round_enemy_array();
		if(player.tesla_enemies.size > 0)
		{
			player.tesla_enemies = array::get_all_closest(origin, player.tesla_enemies);
		}
	}
	zombies = player.tesla_enemies;
	if(isdefined(zombies))
	{
		for(i = 0; i < zombies.size; i++)
		{
			if(!isdefined(zombies[i]))
			{
				continue;
			}
			if(isdefined(zombies[i].lightning_chain_immune) && zombies[i].lightning_chain_immune)
			{
				continue;
			}
			test_origin = zombies[i] gettagorigin("j_head");
			if(!isdefined(test_origin))
			{
				test_origin = zombies[i].origin;
			}
			if(isdefined(zombies[i].zombie_tesla_hit) && zombies[i].zombie_tesla_hit == 1)
			{
				continue;
			}
			if(zm_utility::is_magic_bullet_shield_enabled(zombies[i]))
			{
				continue;
			}
			if(distancesquared(origin, test_origin) > distance_squared)
			{
				continue;
			}
			if(!bullettracepassed(origin, test_origin, 0, undefined))
			{
				continue;
			}
			enemies[enemies.size] = zombies[i];
		}
	}
	return enemies;
}

/*
	Name: lc_flag_hit
	Namespace: lightning_chain
	Checksum: 0x424F4353
	Offset: 0x1268
	Size: 0xB0
	Parameters: 2
	Flags: Private
	Line Number: 366
*/
function private lc_flag_hit(enemy, hit)
{
	if(isdefined(enemy))
	{
		if(isarray(enemy))
		{
			for(i = 0; i < enemy.size; i++)
			{
				if(isdefined(enemy[i]))
				{
					enemy[i].zombie_tesla_hit = hit;
				}
			}
		}
		else if(isdefined(enemy))
		{
			enemy.zombie_tesla_hit = hit;
			return;
		}
	}
	ERROR: Exception occured: Stack empty.
}

/*
	Name: lc_do_damage
	Namespace: lightning_chain
	Checksum: 0x424F4353
	Offset: 0x1320
	Size: 0x490
	Parameters: 5
	Flags: Private
	Line Number: 399
*/
function private lc_do_damage(source_enemy, arc_num, player, params, w_weapon)
{
	player endon("disconnect");
	if(arc_num > 1)
	{
		wait(randomfloatrange(0.2, 0.6) * arc_num);
	}
	if(!isdefined(self) || !isalive(self))
	{
		return;
	}
	if(params.clientside_fx)
	{
		if(arc_num > 1)
		{
			clientfield::set("lc_fx", 2);
		}
		else
		{
			clientfield::set("lc_fx", 1);
		}
	}
	if(!isdefined(self) || !isalive(self))
	{
		return;
	}
	if(isdefined(source_enemy) && source_enemy != self)
	{
		if(player.tesla_arc_count > 3)
		{
			util::wait_network_frame();
			player.tesla_arc_count = 0;
		}
		player.tesla_arc_count++;
		source_enemy lc_play_arc_fx(self, params);
	}
	while(player.tesla_network_death_choke > params.network_death_choke)
	{
		zm_utility::debug_print("TESLA: Choking Tesla Damage. Dead enemies this network frame: " + player.tesla_network_death_choke);
		wait(0.05);
	}
	if(!isdefined(self) || !isalive(self))
	{
		return;
	}
	player.tesla_network_death_choke++;
	self lc_play_death_fx(arc_num, params);
	self.tesla_death = params.should_kill_enemies;
	origin = player.origin;
	if(isdefined(source_enemy) && source_enemy != self)
	{
		origin = source_enemy.origin;
	}
	if(!isdefined(self) || !isalive(self))
	{
		return;
	}
	if(params.should_kill_enemies)
	{
		if(isdefined(self.tesla_damage_func))
		{
			self [[self.tesla_damage_func]](origin, player);
			return;
		}
		else if(isdefined(params.prevent_weapon_kill_credit) && params.prevent_weapon_kill_credit)
		{
			self dodamage(self.health + 666, origin, player, undefined, "none", "MOD_UNKNOWN", 0, level.weaponnone);
		}
		else
		{
			weapon = level.weaponnone;
			if(isdefined(w_weapon))
			{
				weapon = w_weapon;
			}
			self dodamage(self.health + 666, origin, player, undefined, "none", "MOD_UNKNOWN", 0, weapon);
		}
		if(!(isdefined(self.deathpoints_already_given) && self.deathpoints_already_given) && player zm_spawner::player_can_score_from_zombies())
		{
			self.deathpoints_already_given = 1;
			player zm_score::player_add_points("death", "", "");
		}
		if(isdefined(params.challenge_stat_name) && isdefined(player) && isplayer(player))
		{
			player zm_stats::increment_challenge_stat(params.challenge_stat_name);
		}
	}
}

/*
	Name: lc_play_death_fx
	Namespace: lightning_chain
	Checksum: 0x424F4353
	Offset: 0x17B8
	Size: 0x1E0
	Parameters: 2
	Flags: None
	Line Number: 498
*/
function lc_play_death_fx(arc_num, params)
{
	tag = "J_SpineUpper";
	fx = "tesla_shock";
	n_fx = 1;
	b_can_clientside = 1;
	if(isdefined(self.isdog) && self.isdog)
	{
		tag = "J_Spine1";
	}
	if(isdefined(self.teslafxtag))
	{
		b_can_clientside = 0;
		tag = self.teslafxtag;
	}
	else if(!self.archetype === "zombie")
	{
		tag = "tag_origin";
	}
	if(arc_num > 1)
	{
		fx = "tesla_shock_secondary";
		n_fx = 2;
	}
	if(!params.should_kill_enemies)
	{
		fx = "tesla_shock_nonfatal";
		n_fx = 3;
	}
	if(params.no_fx)
	{
	}
	else if(params.clientside_fx && b_can_clientside)
	{
		clientfield::set("lc_death_fx", n_fx);
	}
	else
	{
		zm_net::network_safe_play_fx_on_tag("tesla_death_fx", 2, level._effect[fx], self, tag);
	}
	if(isdefined(self.tesla_head_gib_func) && !self.head_gibbed && params.should_kill_enemies && (!(isdefined(self.no_gib) && self.no_gib)))
	{
		[[self.tesla_head_gib_func]]();
	}
}

/*
	Name: lc_play_arc_fx
	Namespace: lightning_chain
	Checksum: 0x424F4353
	Offset: 0x19A0
	Size: 0x2B0
	Parameters: 2
	Flags: None
	Line Number: 554
*/
function lc_play_arc_fx(target, params)
{
	if(!isdefined(self) || !isdefined(target))
	{
		wait(params.arc_travel_time);
		return;
	}
	tag = "J_SpineUpper";
	if(isdefined(self.isdog) && self.isdog)
	{
		tag = "J_Spine1";
	}
	else if(!self.archetype === "zombie")
	{
		tag = "tag_origin";
	}
	target_tag = "J_SpineUpper";
	if(isdefined(target.isdog) && target.isdog)
	{
		target_tag = "J_Spine1";
	}
	else if(!self.archetype === "zombie")
	{
		tag = "tag_origin";
	}
	origin = self gettagorigin(tag);
	target_origin = target gettagorigin(target_tag);
	distance_squared = params.min_fx_distance * params.min_fx_distance;
	if(distancesquared(origin, target_origin) < distance_squared)
	{
		zm_utility::debug_print("TESLA: Not playing arcing FX. Enemies too close.");
		return;
	}
	fxorg = util::spawn_model("tag_origin", origin);
	fx = playfxontag(level._effect["tesla_bolt"], fxorg, "tag_origin");
	if(isdefined(params.arc_fx_sound))
	{
		playsoundatposition(params.arc_fx_sound, fxorg.origin);
	}
	fxorg moveto(target_origin, params.arc_travel_time);
	fxorg waittill("movedone");
	fxorg delete();
}

/*
	Name: lc_debug_arc
	Namespace: lightning_chain
	Checksum: 0x424F4353
	Offset: 0x1C58
	Size: 0x14
	Parameters: 2
	Flags: Private
	Line Number: 608
*/
function private lc_debug_arc(origin, distance)
{
}

