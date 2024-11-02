#include scripts\codescripts\struct;
#include scripts\shared\ai\systems\gib;
#include scripts\shared\ai\zombie_death;
#include scripts\shared\ai\zombie_utility;
#include scripts\shared\ai_shared;
#include scripts\shared\array_shared;
#include scripts\shared\callbacks_shared;
#include scripts\shared\clientfield_shared;
#include scripts\shared\laststand_shared;
#include scripts\shared\scene_shared;
#include scripts\shared\system_shared;
#include scripts\shared\util_shared;
#include scripts\shared\weapons\_weaponobjects;
#include scripts\zm\_util;
#include scripts\zm\_zm;
#include scripts\zm\_zm_audio;
#include scripts\zm\_zm_equipment;
#include scripts\zm\_zm_laststand;
#include scripts\zm\_zm_lightning_chain;
#include scripts\zm\_zm_spawner;
#include scripts\zm\_zm_stats;
#include scripts\zm\_zm_unitrigger;
#include scripts\zm\_zm_utility;
#include scripts\zm\_zm_weapon_upgrade_system;
#include scripts\zm\_zm_weapons;

#namespace namespace_a844404b;

/*
	Name: __init__sytem__
	Namespace: namespace_a844404b
	Checksum: 0x424F4353
	Offset: 0x5E0
	Size: 0x38
	Parameters: 0
	Flags: AutoExec
	Line Number: 38
*/
function autoexec __init__sytem__()
{
	system::register("zm_special_melee", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: namespace_a844404b
	Checksum: 0x424F4353
	Offset: 0x620
	Size: 0xD0
	Parameters: 0
	Flags: None
	Line Number: 53
*/
function __init__()
{
	callback::on_connect(&on_player_connect);
	level.var_a41d0ea9 = lightning_chain::create_lightning_chain_params(1);
	level.var_a41d0ea9.head_gib_chance = 100;
	level.var_a41d0ea9.network_death_choke = 4;
	level.var_a41d0ea9.should_kill_enemies = 1;
	level.var_b2a993b8 = [];
	level.var_b2a993b8["seasonal_pipe"] = spawnstruct();
	level.var_b2a993b8["seasonal_pipe"].min_damage = 350;
}

/*
	Name: on_player_connect
	Namespace: namespace_a844404b
	Checksum: 0x424F4353
	Offset: 0x6F8
	Size: 0x20
	Parameters: 0
	Flags: None
	Line Number: 75
*/
function on_player_connect()
{
	self thread function_d52a054b();
}

/*
	Name: function_f85ea925
	Namespace: namespace_a844404b
	Checksum: 0x424F4353
	Offset: 0x720
	Size: 0x60
	Parameters: 0
	Flags: None
	Line Number: 90
*/
function function_f85ea925()
{
	self endon("disconnect");
	for(;;)
	{
		self waittill("weapon_fired", weapon);
		iprintlnbold("Weapon Fired, First test");
		self thread function_30cc4d3b();
	}
}

/*
	Name: function_30cc4d3b
	Namespace: namespace_a844404b
	Checksum: 0x424F4353
	Offset: 0x788
	Size: 0x168
	Parameters: 0
	Flags: None
	Line Number: 111
*/
function function_30cc4d3b()
{
	var_3e4d761f = getweapon("t9_gallo_raygun");
	start = self getweaponmuzzlepoint();
	forward_dir = self getweaponforwarddir();
	player_angles = self getplayerangles();
	mdl_weapon = zm_utility::spawn_weapon_model(var_3e4d761f, undefined, start, forward_dir);
	v_flash_pos = mdl_weapon gettagorigin("tag_flash");
	v_target_pos = mdl_weapon.origin + VectorScale(anglestoforward(player_angles), 40);
	magicbullet(var_3e4d761f, v_flash_pos, v_target_pos);
	util::wait_network_frame();
	mdl_weapon delete();
}

/*
	Name: function_d52a054b
	Namespace: namespace_a844404b
	Checksum: 0x424F4353
	Offset: 0x8F8
	Size: 0x228
	Parameters: 0
	Flags: None
	Line Number: 135
*/
function function_d52a054b()
{
	self endon("disconnect");
	for(;;)
	{
		self waittill("weapon_melee", weapon);
		if(weapon.name == "sw_lightsaber_obi_wan" || weapon.name == "sw_lightsaber_obi_wan_upgraded" || weapon.name == "sw_lightsaber_darth_vader" || weapon.name == "sw_lightsaber_darth_vader_upgraded")
		{
			self thread function_da195a32(weapon);
		}
		else if(weapon.name == "t9_bat_crockiller" || weapon.name == "t9_bat_crockiller_up" || weapon.name == "melee_jug" || weapon.name == "melee_jug_up" || weapon.name == "bowie_knife" || weapon.name == "melee_seasonal_pipe" || weapon.name == "melee_seasonal_pipe_upgraded" || weapon.name == "melee_4090" || weapon.name == "melee_4090_up")
		{
			self thread function_e18b6e4a(weapon);
		}
		else if(weapon.name == "sw_lightsaber_kylo_ren" || weapon.name == "sw_lightsaber_kylo_ren_upgraded")
		{
			self thread function_da195a32(weapon);
		}
	}
}

/*
	Name: function_e18b6e4a
	Namespace: namespace_a844404b
	Checksum: 0x424F4353
	Offset: 0xB28
	Size: 0x2E0
	Parameters: 1
	Flags: None
	Line Number: 166
*/
function function_e18b6e4a(var_52baa43a)
{
	view_pos = self getweaponmuzzlepoint();
	forward_view_angles = self getweaponforwarddir();
	zombies = array::get_all_closest(view_pos, getaiteamarray(level.zombie_team), undefined, undefined, 2 * level.zombie_vars["riotshield_knockdown_range"]);
	for(i = 0; i < 7; i++)
	{
		if(!isdefined(zombies[i]) || !isalive(zombies[i]))
		{
			continue;
		}
		test_origin = zombies[i] getcentroid();
		dist_sq = distancesquared(view_pos, test_origin);
		if(var_52baa43a.name == "t9_bat_crockiller_up" || var_52baa43a.name == "melee_jug_up" || var_52baa43a.name == "melee_4090_up")
		{
			if(dist_sq > 12100)
			{
				continue;
			}
		}
		else if(var_52baa43a.name == "melee_seasonal_pipe_upgraded")
		{
			if(dist_sq > 14400)
			{
				continue;
			}
		}
		else if(dist_sq > 6400)
		{
			continue;
		}
		normal = vectornormalize(test_origin - view_pos);
		dot = vectordot(forward_view_angles, normal);
		if(0.705 > dot)
		{
			continue;
		}
		if(!zombies[i] cansee(self))
		{
			continue;
		}
		if(0 == zombies[i] damageconetrace(view_pos, self))
		{
			continue;
		}
		self thread function_1dd32418(zombies[i], var_52baa43a, dist_sq);
	}
}

/*
	Name: function_1dd32418
	Namespace: namespace_a844404b
	Checksum: 0x424F4353
	Offset: 0xE10
	Size: 0x78
	Parameters: 3
	Flags: None
	Line Number: 225
*/
function function_1dd32418(ai, var_52baa43a, distance)
{
	self endon("disconnect");
	if(!isdefined(ai) || !isalive(ai))
	{
		return;
	}
	ai thread function_a541545(self, var_52baa43a, distance);
}

/*
	Name: function_a541545
	Namespace: namespace_a844404b
	Checksum: 0x424F4353
	Offset: 0xE90
	Size: 0x298
	Parameters: 3
	Flags: None
	Line Number: 245
*/
function function_a541545(player, w_weapon, distance)
{
	self endon("death");
	player thread zm_audio::create_and_play_dialog("kill", "sword_slam");
	if(w_weapon.name == "t9_bat_crockiller_up" || w_weapon.name == "melee_jug_up" || w_weapon.name == "melee_seasonal_pipe_upgraded" || w_weapon.name == "melee_4090_up")
	{
		n_damage = namespace_5e1f56dc::function_bcb41215(undefined, player, 125 + distance / 100 * 110, undefined, undefined, w_weapon);
		if(n_damage > self.health)
		{
			playfxontag(level._effect["crossbow_skull_zombie_explode"], self, "j_head");
			if(isdefined(self) && IsActor(self))
			{
				gibserverutils::gibhead(self);
			}
		}
		self dodamage(n_damage, self.origin, player, undefined, "none", "MOD_MELEE", 0, w_weapon);
	}
	else
	{
		n_damage = namespace_5e1f56dc::function_bcb41215(undefined, player, 125 + distance / 100 * 40, undefined, undefined, w_weapon);
		if(n_damage > self.health)
		{
			playfxontag(level._effect["crossbow_skull_zombie_explode"], self, "j_head");
			if(isdefined(self) && IsActor(self))
			{
				gibserverutils::gibhead(self);
			}
		}
		self dodamage(n_damage, self.origin, player, undefined, "none", "MOD_MELEE", 0, w_weapon);
		return;
	}
}

/*
	Name: function_da195a32
	Namespace: namespace_a844404b
	Checksum: 0x424F4353
	Offset: 0x1130
	Size: 0x2C8
	Parameters: 1
	Flags: Private
	Line Number: 288
*/
function private function_da195a32(var_52baa43a)
{
	view_pos = self getweaponmuzzlepoint();
	forward_view_angles = self getweaponforwarddir();
	zombies = array::get_all_closest(view_pos, getaiteamarray(level.zombie_team), undefined, undefined, 2 * level.zombie_vars["riotshield_knockdown_range"]);
	if(var_52baa43a.name == "sw_lightsaber_obi_wan_upgraded")
	{
		var_480fed80 = self namespace_5e1f56dc::function_1239e0ad(var_52baa43a);
		if(isdefined(var_480fed80))
		{
			if(var_480fed80.var_a39a2843 >= 1)
			{
				max_zombies = 12 + 2 * var_480fed80.var_a39a2843;
			}
		}
		else
		{
			max_zombies = 12;
		}
	}
	else
	{
		max_zombies = 10;
	}
	for(i = 0; i < max_zombies; i++)
	{
		if(!isdefined(zombies[i]) || !isalive(zombies[i]))
		{
			continue;
		}
		test_origin = zombies[i] getcentroid();
		dist_sq = distancesquared(view_pos, test_origin);
		if(dist_sq > 10000)
		{
			continue;
		}
		normal = vectornormalize(test_origin - view_pos);
		dot = vectordot(forward_view_angles, normal);
		if(0.707 > dot)
		{
			continue;
		}
		if(0 == zombies[i] damageconetrace(view_pos, self))
		{
			continue;
		}
		self thread function_20654ca0(zombies[i], var_52baa43a, dist_sq);
	}
}

/*
	Name: function_20654ca0
	Namespace: namespace_a844404b
	Checksum: 0x424F4353
	Offset: 0x1400
	Size: 0xF0
	Parameters: 3
	Flags: None
	Line Number: 348
*/
function function_20654ca0(ai, var_52baa43a, distance)
{
	self endon("disconnect");
	if(!isdefined(ai) || !isalive(ai))
	{
		return;
	}
	if(!isdefined(self.tesla_enemies_hit))
	{
		self.tesla_enemies_hit = 1;
	}
	ai notify("bhtn_action_notify", "electrocute");
	ai.tesla_death = 0;
	ai thread function_fe8a580e(ai.origin, ai.origin, self, var_52baa43a);
	ai thread tesla_death(self, var_52baa43a, distance);
}

/*
	Name: function_fe8a580e
	Namespace: namespace_a844404b
	Checksum: 0x424F4353
	Offset: 0x14F8
	Size: 0x78
	Parameters: 4
	Flags: None
	Line Number: 375
*/
function function_fe8a580e(hit_location, hit_origin, player, w_weapon)
{
	player endon("disconnect");
	if(isdefined(self.zombie_tesla_hit) && self.zombie_tesla_hit)
	{
		return;
	}
	self lightning_chain::arc_damage(self, player, 1, level.tesla_lightning_params, w_weapon);
}

/*
	Name: tesla_death
	Namespace: namespace_a844404b
	Checksum: 0x424F4353
	Offset: 0x1578
	Size: 0x1A0
	Parameters: 3
	Flags: None
	Line Number: 395
*/
function tesla_death(player, w_weapon, distance)
{
	self endon("death");
	wait(1);
	player thread zm_audio::create_and_play_dialog("kill", "sword_slam");
	if(w_weapon.name == "sw_lightsaber_obi_wan_upgraded")
	{
		n_damage = namespace_5e1f56dc::function_bcb41215(undefined, player, 125 + distance / 100 * 120, undefined, undefined, w_weapon);
	}
	else
	{
		n_damage = namespace_5e1f56dc::function_bcb41215(undefined, player, 125 + distance / 100 * 50, undefined, undefined, w_weapon);
	}
	if(n_damage > self.health)
	{
		playfxontag(level._effect["crossbow_skull_zombie_explode"], self, "j_head");
		if(isdefined(self) && IsActor(self))
		{
			gibserverutils::gibhead(self);
		}
	}
	self dodamage(n_damage, self.origin, player, undefined, "none", "MOD_MELEE", 0, w_weapon);
}

/*
	Name: function_862aadab
	Namespace: namespace_a844404b
	Checksum: 0x424F4353
	Offset: 0x1720
	Size: 0x130
	Parameters: 1
	Flags: None
	Line Number: 429
*/
function function_862aadab(random_gibs)
{
	if(isdefined(self) && IsActor(self))
	{
		if(!random_gibs || randomint(100) < 50)
		{
			gibserverutils::gibhead(self);
		}
		if(!random_gibs || randomint(100) < 50)
		{
			gibserverutils::gibleftarm(self);
		}
		if(!random_gibs || randomint(100) < 50)
		{
			gibserverutils::gibrightarm(self);
		}
		if(!random_gibs || randomint(100) < 50)
		{
			gibserverutils::giblegs(self);
		}
	}
}

/*
	Name: function_5c92a768
	Namespace: namespace_a844404b
	Checksum: 0x424F4353
	Offset: 0x1858
	Size: 0x278
	Parameters: 1
	Flags: Private
	Line Number: 462
*/
function private function_5c92a768(var_52baa43a)
{
	view_pos = self getweaponmuzzlepoint();
	forward_view_angles = self getweaponforwarddir();
	zombies = array::get_all_closest(view_pos, getaiteamarray(level.zombie_team), undefined, undefined, 2 * level.zombie_vars["riotshield_knockdown_range"]);
	foreach(ai in zombies)
	{
		if(!isdefined(ai) || !isalive(ai))
		{
			continue;
		}
		test_origin = ai getcentroid();
		dist_sq = distancesquared(view_pos, test_origin);
		if(dist_sq < 12100)
		{
			self thread disintegrate_zombie(ai, var_52baa43a);
			continue;
		}
		if(dist_sq > 12100)
		{
			continue;
		}
		normal = vectornormalize(test_origin - view_pos);
		dot = vectordot(forward_view_angles, normal);
		if(0.707 > dot)
		{
			continue;
		}
		if(0 == ai damageconetrace(view_pos, self))
		{
			continue;
		}
		self thread disintegrate_zombie(ai, var_52baa43a);
	}
}

/*
	Name: disintegrate_zombie
	Namespace: namespace_a844404b
	Checksum: 0x424F4353
	Offset: 0x1AD8
	Size: 0x68
	Parameters: 2
	Flags: None
	Line Number: 508
*/
function disintegrate_zombie(ai, var_52baa43a)
{
	self endon("disconnect");
	if(!isdefined(ai) || !isalive(ai))
	{
		return;
	}
	ai thread function_5e2a765b(self, var_52baa43a);
}

/*
	Name: function_5e2a765b
	Namespace: namespace_a844404b
	Checksum: 0x424F4353
	Offset: 0x1B48
	Size: 0x1B4
	Parameters: 2
	Flags: None
	Line Number: 528
*/
function function_5e2a765b(e_attacker, w_weapon)
{
	self endon("death");
	if(isdefined(self.b_disintegrating) && self.b_disintegrating)
	{
		return;
	}
	self.b_disintegrating = 1;
	self clientfield::set("ai_disintegrate", 1);
	if(isVehicle(self))
	{
		self ai::set_ignoreall(1);
		wait(1.1);
		self ghost();
		self dodamage(self.health + 666, self.origin, e_attacker, undefined, undefined, "MOD_UNKNOWN", 0, w_weapon);
	}
	else
	{
		self scene::play("cin_zm_dlc3_zombie_dth_deathray_0" + randomintrange(1, 4), self);
		self clientfield::set("ai_slow_vortex_fx", 0);
		util::wait_network_frame();
		self ghost();
		self dodamage(self.health + 666, self.origin, e_attacker, undefined, undefined, "MOD_UNKNOWN", 0, w_weapon);
	}
}

