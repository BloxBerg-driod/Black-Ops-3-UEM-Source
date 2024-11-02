#include scripts\codescripts\struct;
#include scripts\shared\ai\systems\gib;
#include scripts\shared\ai\zombie_death;
#include scripts\shared\ai\zombie_utility;
#include scripts\shared\array_shared;
#include scripts\shared\callbacks_shared;
#include scripts\shared\clientfield_shared;
#include scripts\shared\laststand_shared;
#include scripts\shared\math_shared;
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

#namespace namespace_2de6fd81;

/*
	Name: __init__sytem__
	Namespace: namespace_2de6fd81
	Checksum: 0x424F4353
	Offset: 0x5B8
	Size: 0x38
	Parameters: 0
	Flags: AutoExec
	Line Number: 37
*/
function autoexec __init__sytem__()
{
	system::register("zm_weap_crossbow", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: namespace_2de6fd81
	Checksum: 0x424F4353
	Offset: 0x5F8
	Size: 0xB8
	Parameters: 0
	Flags: None
	Line Number: 52
*/
function __init__()
{
	callback::on_connect(&on_player_connect);
	zm::register_zombie_damage_override_callback(&function_2c75da4c);
	level._effect["crossbow_skull_ground_explosion"] = "dlc5/moon/fx_moon_qbomb_explo_distort";
	level._effect["crossbow_skull_zombie_explode"] = "dlc2/island/fx_zombie_torso_explo";
	level._effect["crossbow_skull_zombie_attract"] = "_sphynx/_zm_crossbow_poi_fx";
	level._effect["crossbow_skull_zombie_attract_ug"] = "_sphynx/_zm_crossbow_poi_fx_ug";
}

/*
	Name: on_player_connect
	Namespace: namespace_2de6fd81
	Checksum: 0x424F4353
	Offset: 0x6B8
	Size: 0x20
	Parameters: 0
	Flags: None
	Line Number: 72
*/
function on_player_connect()
{
	self thread function_a855124a();
}

/*
	Name: function_a855124a
	Namespace: namespace_2de6fd81
	Checksum: 0x424F4353
	Offset: 0x6E0
	Size: 0x118
	Parameters: 0
	Flags: None
	Line Number: 87
*/
function function_a855124a()
{
	self endon("disconnect");
	for(;;)
	{
		self waittill("projectile_impact", w_weapon, v_pos, n_radius, e_projectile, v_normal);
		v_pos_final = function_e46d59be(v_pos);
		pos = zm_utility::GROUNDPOS(v_pos_final.origin) + VectorScale((0, 0, 1), 8);
		if(w_weapon.name == "t9_crossbow_skull" || w_weapon.name == "t9_crossbow_skull_up")
		{
			self thread function_120ea33f(w_weapon, v_pos, pos, n_radius, e_projectile, v_normal);
		}
	}
}

/*
	Name: function_e46d59be
	Namespace: namespace_2de6fd81
	Checksum: 0x424F4353
	Offset: 0x800
	Size: 0x90
	Parameters: 1
	Flags: None
	Line Number: 112
*/
function function_e46d59be(v_impact_origin)
{
	v_nearest_navmesh_point = getclosestpointonnavmesh(v_impact_origin, 50, 48);
	if(isdefined(v_nearest_navmesh_point))
	{
		v_vortex_origin = v_nearest_navmesh_point;
		v_vortex_origin = util::ground_position(v_vortex_origin, 0, 1);
	}
	else
	{
		v_vortex_origin = v_impact_origin;
	}
	return v_vortex_origin;
}

/*
	Name: proximity_detonate
	Namespace: namespace_2de6fd81
	Checksum: 0x424F4353
	Offset: 0x898
	Size: 0x3B0
	Parameters: 2
	Flags: None
	Line Number: 137
*/
function proximity_detonate(owner, w_weapon)
{
	if(!isdefined(self))
	{
		return;
	}
	detonateRadius = 130;
	explosionRadius = detonateRadius * 2;
	self stoploopsound(0.05);
	self playsound("crossbow_blast_pre_explosion");
	wait(0.5);
	playfxontag(level._effect["crossbow_skull_ground_explosion"], self, "tag_origin");
	self playsound("crossbow_blast_main");
	wait(0.05);
	self hide();
	if(w_weapon.name == "t9_crossbow_skull_up")
	{
		var_480fed80 = owner namespace_5e1f56dc::function_1239e0ad(w_weapon);
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
	zombies = array::get_all_closest(self.origin, getaiteamarray(level.zombie_team), undefined, undefined, 240);
	for(i = 0; i < max_zombies; i++)
	{
		if(!isdefined(zombies[i]) || !isalive(zombies[i]))
		{
			continue;
		}
		dist_sq = distancesquared(self.origin, zombies[i].origin);
		if(w_weapon.name == "t9_crossbow_skull_up")
		{
			if(dist_sq < 115600)
			{
				owner thread function_8d5b17df(zombies[i], w_weapon);
				continue;
			}
			if(dist_sq > 115600)
			{
				continue;
			}
		}
		else if(dist_sq < 40000)
		{
			owner thread function_8d5b17df(zombies[i], w_weapon);
			continue;
		}
		if(dist_sq > 40000)
		{
			continue;
		}
		if(0 == zombies[i] damageconetrace(self.origin, self))
		{
			continue;
		}
		owner thread function_8d5b17df(zombies[i], w_weapon);
	}
	self delete();
}

/*
	Name: function_120ea33f
	Namespace: namespace_2de6fd81
	Checksum: 0x424F4353
	Offset: 0xC50
	Size: 0x620
	Parameters: 6
	Flags: None
	Line Number: 219
*/
function function_120ea33f(w_weapon, v_pos, v_pos_final, n_radius, e_projectile, v_normal)
{
	self endon("disconnect");
	util::wait_network_frame();
	if(isdefined(e_projectile))
	{
		zombies = array::get_all_closest(self.origin, getaiteamarray(level.zombie_team), undefined, undefined, 400);
		foreach(zombie in zombies)
		{
			if(isdefined(zombie.var_16b92567) && zombie.var_16b92567)
			{
				var_74baf296 = zombie;
				break;
			}
		}
		if(isdefined(var_74baf296))
		{
			new_origin = var_74baf296.origin;
		}
		else
		{
			new_origin = e_projectile.origin;
		}
		model = spawn("script_model", new_origin);
		if(w_weapon.name == "t9_crossbow_skull_up")
		{
			model setmodel("zmu_skull_crossbow_poi_ug");
		}
		else
		{
			model setmodel("zmu_skull_crossbow_poi");
		}
		wait(0.05);
		e_projectile delete();
	}
	util::wait_network_frame();
	if(w_weapon.name == "t9_crossbow_skull_up")
	{
		if(isdefined(var_74baf296) && var_74baf296)
		{
			playfxontag(level._effect["crossbow_skull_zombie_attract_ug"], model, "j_spine4");
		}
		else
		{
			playfxontag(level._effect["crossbow_skull_zombie_attract_ug"], model, "tag_origin");
		}
	}
	else if(isdefined(var_74baf296) && var_74baf296)
	{
		playfxontag(level._effect["crossbow_skull_zombie_attract"], model, "j_spine4");
	}
	else
	{
		playfxontag(level._effect["crossbow_skull_zombie_attract"], model, "tag_origin");
	}
	valid_poi = zm_utility::check_point_in_enabled_zone(model.origin, undefined, undefined);
	valid_poi = model move_valid_poi_to_navmesh(valid_poi);
	valid_poi = model [[level.check_valid_poi]](valid_poi);
	if(isdefined(model))
	{
		if(valid_poi)
		{
			model zm_utility::create_zombie_point_of_interest(1024, 32, 10000);
			model.attract_to_origin = 1;
			model thread zm_utility::create_zombie_point_of_interest_attractor_positions(4, 45);
			model thread zm_utility::wait_for_attractor_positions_complete();
			if(w_weapon.name == "t9_crossbow_skull_up")
			{
				model thread pulse_damage(self, w_weapon);
				model thread function_ad19108b();
				wait(2.6);
				model thread proximity_detonate(self, w_weapon);
			}
			else
			{
				model thread function_ad19108b();
				wait(1.9);
				model thread proximity_detonate(self, w_weapon);
			}
		}
		else if(w_weapon.name == "t9_crossbow_skull_up")
		{
			model thread pulse_damage(self, w_weapon);
			model thread function_ad19108b();
			wait(2.6);
			model thread proximity_detonate(self, w_weapon);
		}
		else
		{
			model thread function_ad19108b();
			wait(1.9);
			model thread proximity_detonate(self, w_weapon);
		}
	}
	else
	{
		model.script_noteworthy = undefined;
		playfxontag(level._effect["grenade_samantha_steal"], model, "tag_origin");
		if(isdefined(model))
		{
			model delete();
			return;
		}
	}
}

/*
	Name: function_1ff3643d
	Namespace: namespace_2de6fd81
	Checksum: 0x424F4353
	Offset: 0x1278
	Size: 0x1C8
	Parameters: 2
	Flags: None
	Line Number: 335
*/
function function_1ff3643d(w_weapon, owner)
{
	self endon("death");
	util::wait_network_frame();
	if(w_weapon.name == "t9_crossbow_skull_up")
	{
		playfxontag(level._effect["crossbow_skull_zombie_attract_ug"], self, "j_spine4");
	}
	else
	{
		playfxontag(level._effect["crossbow_skull_zombie_attract"], self, "j_spine4");
	}
	self zm_utility::create_zombie_point_of_interest(1024, 32, 10000);
	self.attract_to_origin = 1;
	self thread zm_utility::create_zombie_point_of_interest_attractor_positions(4, 45);
	self thread zm_utility::wait_for_attractor_positions_complete();
	if(w_weapon.name == "t9_crossbow_skull_up")
	{
		self thread pulse_damage(owner, w_weapon);
		self thread function_ad19108b();
		wait(2.6);
		self thread proximity_detonate(owner, w_weapon);
	}
	else
	{
		self thread function_ad19108b();
		wait(1.9);
		self thread proximity_detonate(owner, w_weapon);
	}
}

/*
	Name: function_ad19108b
	Namespace: namespace_2de6fd81
	Checksum: 0x424F4353
	Offset: 0x1448
	Size: 0x28
	Parameters: 0
	Flags: None
	Line Number: 376
*/
function function_ad19108b()
{
	self playloopsound("crossbow_beep");
}

/*
	Name: pulse_damage
	Namespace: namespace_2de6fd81
	Checksum: 0x424F4353
	Offset: 0x1478
	Size: 0x1E8
	Parameters: 2
	Flags: None
	Line Number: 391
*/
function pulse_damage(e_owner, w_weapon)
{
	self endon("death");
	util::wait_network_frame();
	n_damage_origin = self.origin + VectorScale((0, 0, 1), 12);
	while(isdefined(self))
	{
		a_ai_targets = getaiteamarray("axis");
		foreach(ai_target in a_ai_targets)
		{
			if(isdefined(ai_target))
			{
				n_distance_to_target = distance(ai_target.origin, n_damage_origin);
				if(n_distance_to_target > 80)
				{
					continue;
				}
				n_damage = math::linear_map(n_distance_to_target, 0, 80, 160, 240);
				n_damage = namespace_5e1f56dc::function_bcb41215(undefined, e_owner, n_damage, undefined, undefined, w_weapon);
				ai_target dodamage(n_damage, ai_target.origin, e_owner, self, "none", "MOD_GRENADE_SPLASH", 0, w_weapon);
			}
		}
		wait(1);
	}
}

/*
	Name: function_42f80185
	Namespace: namespace_2de6fd81
	Checksum: 0x424F4353
	Offset: 0x1668
	Size: 0x48
	Parameters: 1
	Flags: None
	Line Number: 427
*/
function function_42f80185(parent)
{
	while(1)
	{
		if(!isdefined(parent))
		{
			zm_utility::self_delete();
			return;
		}
		wait(0.05);
	}
}

/*
	Name: move_valid_poi_to_navmesh
	Namespace: namespace_2de6fd81
	Checksum: 0x424F4353
	Offset: 0x16B8
	Size: 0x1F0
	Parameters: 1
	Flags: None
	Line Number: 450
*/
function move_valid_poi_to_navmesh(valid_poi)
{
	if(!(isdefined(valid_poi) && valid_poi))
	{
		return 0;
	}
	if(ispointonnavmesh(self.origin))
	{
		return 1;
	}
	v_orig = self.origin;
	queryresult = positionquery_source_navigation(self.origin, 0, level.VALID_POI_MAX_RADIUS, level.VALID_POI_HALF_HEIGHT, level.VALID_POI_INNER_SPACING, level.VALID_POI_RADIUS_FROM_EDGES);
	if(queryresult.data.size)
	{
		foreach(point in queryresult.data)
		{
			height_offset = abs(self.origin[2] - point.origin[2]);
			if(height_offset > level.VALID_POI_HEIGHT)
			{
				continue;
			}
			if(bullettracepassed(point.origin + VectorScale((0, 0, 1), 20), v_orig + VectorScale((0, 0, 1), 20), 0, self, undefined, 0, 0))
			{
				self.origin = point.origin;
				return 1;
			}
		}
	}
	return 0;
}

/*
	Name: function_8d5b17df
	Namespace: namespace_2de6fd81
	Checksum: 0x424F4353
	Offset: 0x18B0
	Size: 0x68
	Parameters: 2
	Flags: None
	Line Number: 491
*/
function function_8d5b17df(ai, w_weapon)
{
	self endon("disconnect");
	if(!isdefined(ai) || !isalive(ai))
	{
		return;
	}
	ai thread function_a541545(self, w_weapon);
}

/*
	Name: function_a541545
	Namespace: namespace_2de6fd81
	Checksum: 0x424F4353
	Offset: 0x1920
	Size: 0x220
	Parameters: 2
	Flags: None
	Line Number: 511
*/
function function_a541545(player, w_weapon)
{
	self endon("death");
	player thread zm_audio::create_and_play_dialog("kill", "sword_slam");
	wait(0.05);
	if(w_weapon.name == "t9_crossbow_skull_up")
	{
		n_damage = namespace_5e1f56dc::function_bcb41215(undefined, player, 1140, undefined, undefined, w_weapon);
		if(n_damage > self.health)
		{
			playfxontag(level._effect["crossbow_skull_zombie_explode"], self, "j_head");
			if(isdefined(self) && IsActor(self))
			{
				gibserverutils::gibhead(self);
			}
		}
		self dodamage(n_damage, self.origin, player, undefined, "none", "MOD_EXPLOSIVE", 0, w_weapon);
	}
	else
	{
		n_damage = namespace_5e1f56dc::function_bcb41215(undefined, player, 800, undefined, undefined, w_weapon);
		if(n_damage > self.health)
		{
			playfxontag(level._effect["crossbow_skull_zombie_explode"], self, "j_head");
			if(isdefined(self) && IsActor(self))
			{
				gibserverutils::gibhead(self);
			}
		}
		self dodamage(n_damage, self.origin, player, undefined, "none", "MOD_EXPLOSIVE", 0, w_weapon);
		return;
	}
	waittillframeend;
}

/*
	Name: function_862aadab
	Namespace: namespace_2de6fd81
	Checksum: 0x424F4353
	Offset: 0x1B48
	Size: 0x150
	Parameters: 1
	Flags: None
	Line Number: 556
*/
function function_862aadab(random_gibs)
{
	if(isdefined(self) && IsActor(self))
	{
		if(!random_gibs || randomint(100) < 50)
		{
			gibserverutils::gibhead(self);
			return 1;
		}
		if(!random_gibs || randomint(100) < 50)
		{
			gibserverutils::gibleftarm(self);
			return 0;
		}
		if(!random_gibs || randomint(100) < 50)
		{
			gibserverutils::gibrightarm(self);
			return 0;
		}
		if(!random_gibs || randomint(100) < 50)
		{
			gibserverutils::giblegs(self);
			return 0;
		}
		return 0;
	}
	return 0;
	ERROR: Exception occured: Stack empty.
}

/*
	Name: function_2c75da4c
	Namespace: namespace_2de6fd81
	Checksum: 0x424F4353
	Offset: 0x1CA0
	Size: 0xA8
	Parameters: 13
	Flags: None
	Line Number: 596
*/
function function_2c75da4c(willBeKilled, inflictor, attacker, damage, flags, meansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, boneindex, surfacetype)
{
	if(self function_609e17d0(meansofdeath, weapon))
	{
		self.var_16b92567 = 1;
		return 1;
	}
	return 0;
}

/*
	Name: function_609e17d0
	Namespace: namespace_2de6fd81
	Checksum: 0x424F4353
	Offset: 0x1D50
	Size: 0x74
	Parameters: 2
	Flags: None
	Line Number: 616
*/
function function_609e17d0(mod, weapon)
{
	return weapon == getweapon("t9_crossbow_skull") || weapon == getweapon("t9_crossbow_skull_up") && (mod == "MOD_PROJECTILE" || mod == "MOD_PROJECTILE_SPLASH");
}

