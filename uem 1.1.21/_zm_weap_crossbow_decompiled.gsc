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
	Name: function___init__sytem__
	Namespace: namespace_2de6fd81
	Checksum: 0x424F4353
	Offset: 0x5B8
	Size: 0x38
	Parameters: 0
	Flags: AutoExec
	Line Number: 37
*/
function autoexec function___init__sytem__()
{
	namespace_system::function_register("zm_weap_crossbow", &function___init__, undefined, undefined);
}

/*
	Name: function___init__
	Namespace: namespace_2de6fd81
	Checksum: 0x424F4353
	Offset: 0x5F8
	Size: 0xB8
	Parameters: 0
	Flags: None
	Line Number: 52
*/
function function___init__()
{
	namespace_callback::function_on_connect(&function_on_player_connect);
	namespace_zm::function_register_zombie_damage_override_callback(&function_2c75da4c);
	level.var__effect["crossbow_skull_ground_explosion"] = "dlc5/moon/fx_moon_qbomb_explo_distort";
	level.var__effect["crossbow_skull_zombie_explode"] = "dlc2/island/fx_zombie_torso_explo";
	level.var__effect["crossbow_skull_zombie_attract"] = "_sphynx/_zm_crossbow_poi_fx";
	level.var__effect["crossbow_skull_zombie_attract_ug"] = "_sphynx/_zm_crossbow_poi_fx_ug";
}

/*
	Name: function_on_player_connect
	Namespace: namespace_2de6fd81
	Checksum: 0x424F4353
	Offset: 0x6B8
	Size: 0x20
	Parameters: 0
	Flags: None
	Line Number: 72
*/
function function_on_player_connect()
{
	self thread function_a855124a();
	return;
}

/*
	Name: function_a855124a
	Namespace: namespace_2de6fd81
	Checksum: 0x424F4353
	Offset: 0x6E0
	Size: 0x118
	Parameters: 0
	Flags: None
	Line Number: 88
*/
function function_a855124a()
{
	self endon("hash_disconnect");
	for(;;)
	{
		self waittill("hash_projectile_impact", var_w_weapon, var_v_pos, var_n_radius, var_e_projectile, var_v_normal);
		var_v_pos_final = function_e46d59be(var_v_pos);
		var_pos = namespace_zm_utility::function_GROUNDPOS(var_v_pos_final.var_origin) + VectorScale((0, 0, 1), 8);
		if(var_w_weapon.var_name == "t9_crossbow_skull" || var_w_weapon.var_name == "t9_crossbow_skull_up")
		{
			self thread function_120ea33f(var_w_weapon, var_v_pos, var_pos, var_n_radius, var_e_projectile, var_v_normal);
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
	Line Number: 113
*/
function function_e46d59be(var_v_impact_origin)
{
	var_v_nearest_navmesh_point = function_GetClosestPointOnNavMesh(var_v_impact_origin, 50, 48);
	if(isdefined(var_v_nearest_navmesh_point))
	{
		var_v_vortex_origin = var_v_nearest_navmesh_point;
		var_v_vortex_origin = namespace_util::function_ground_position(var_v_vortex_origin, 0, 1);
	}
	else
	{
		var_v_vortex_origin = var_v_impact_origin;
	}
	return var_v_vortex_origin;
}

/*
	Name: function_proximity_detonate
	Namespace: namespace_2de6fd81
	Checksum: 0x424F4353
	Offset: 0x898
	Size: 0x3B0
	Parameters: 2
	Flags: None
	Line Number: 138
*/
function function_proximity_detonate(var_owner, var_w_weapon)
{
	if(!isdefined(self))
	{
		return;
	}
	var_detonateRadius = 130;
	var_explosionRadius = var_detonateRadius * 2;
	self function_StopLoopSound(0.05);
	self function_playsound("crossbow_blast_pre_explosion");
	wait(0.5);
	function_PlayFXOnTag(level.var__effect["crossbow_skull_ground_explosion"], self, "tag_origin");
	self function_playsound("crossbow_blast_main");
	wait(0.05);
	self function_Hide();
	if(var_w_weapon.var_name == "t9_crossbow_skull_up")
	{
		var_480fed80 = var_owner namespace_5e1f56dc::function_1239e0ad(var_w_weapon);
		if(isdefined(var_480fed80))
		{
			if(var_480fed80.var_a39a2843 >= 1)
			{
				var_max_zombies = 12 + 2 * var_480fed80.var_a39a2843;
			}
		}
		else
		{
			var_max_zombies = 12;
		}
	}
	else
	{
		var_max_zombies = 10;
	}
	var_zombies = namespace_Array::function_get_all_closest(self.var_origin, function_GetAITeamArray(level.var_zombie_team), undefined, undefined, 240);
	for(var_i = 0; var_i < var_max_zombies; var_i++)
	{
		if(!isdefined(var_zombies[var_i]) || !function_isalive(var_zombies[var_i]))
		{
			continue;
		}
		var_dist_sq = function_DistanceSquared(self.var_origin, var_zombies[var_i].var_origin);
		if(var_w_weapon.var_name == "t9_crossbow_skull_up")
		{
			if(var_dist_sq < 115600)
			{
				var_owner thread function_8d5b17df(var_zombies[var_i], var_w_weapon);
				continue;
			}
			if(var_dist_sq > 115600)
			{
				continue;
			}
		}
		else if(var_dist_sq < 40000)
		{
			var_owner thread function_8d5b17df(var_zombies[var_i], var_w_weapon);
			continue;
		}
		if(var_dist_sq > 40000)
		{
			continue;
		}
		if(0 == var_zombies[var_i] function_damageConeTrace(self.var_origin, self))
		{
			continue;
		}
		var_owner thread function_8d5b17df(var_zombies[var_i], var_w_weapon);
	}
	self function_delete();
	return;
}

/*
	Name: function_120ea33f
	Namespace: namespace_2de6fd81
	Checksum: 0x424F4353
	Offset: 0xC50
	Size: 0x620
	Parameters: 6
	Flags: None
	Line Number: 221
*/
function function_120ea33f(var_w_weapon, var_v_pos, var_v_pos_final, var_n_radius, var_e_projectile, var_v_normal)
{
	self endon("hash_disconnect");
	namespace_util::function_wait_network_frame();
	if(isdefined(var_e_projectile))
	{
		var_zombies = namespace_Array::function_get_all_closest(self.var_origin, function_GetAITeamArray(level.var_zombie_team), undefined, undefined, 400);
		foreach(var_zombie in var_zombies)
		{
			if(isdefined(var_zombie.var_16b92567) && var_zombie.var_16b92567)
			{
				var_74baf296 = var_zombie;
				break;
			}
		}
		if(isdefined(var_74baf296))
		{
			var_new_origin = var_74baf296.var_origin;
		}
		else
		{
			var_new_origin = var_e_projectile.var_origin;
		}
		var_model = function_spawn("script_model", var_new_origin);
		if(var_w_weapon.var_name == "t9_crossbow_skull_up")
		{
			var_model function_SetModel("zmu_skull_crossbow_poi_ug");
		}
		else
		{
			var_model function_SetModel("zmu_skull_crossbow_poi");
		}
		wait(0.05);
		var_e_projectile function_delete();
	}
	namespace_util::function_wait_network_frame();
	if(var_w_weapon.var_name == "t9_crossbow_skull_up")
	{
		if(isdefined(var_74baf296) && var_74baf296)
		{
			function_PlayFXOnTag(level.var__effect["crossbow_skull_zombie_attract_ug"], var_model, "j_spine4");
		}
		else
		{
			function_PlayFXOnTag(level.var__effect["crossbow_skull_zombie_attract_ug"], var_model, "tag_origin");
		}
	}
	else if(isdefined(var_74baf296) && var_74baf296)
	{
		function_PlayFXOnTag(level.var__effect["crossbow_skull_zombie_attract"], var_model, "j_spine4");
	}
	else
	{
		function_PlayFXOnTag(level.var__effect["crossbow_skull_zombie_attract"], var_model, "tag_origin");
	}
	var_valid_poi = namespace_zm_utility::function_check_point_in_enabled_zone(var_model.var_origin, undefined, undefined);
	var_valid_poi = var_model function_move_valid_poi_to_navmesh(var_valid_poi);
	var_valid_poi = var_model [[level.var_check_valid_poi]](var_valid_poi);
	if(isdefined(var_model))
	{
		if(var_valid_poi)
		{
			var_model namespace_zm_utility::function_create_zombie_point_of_interest(1024, 32, 10000);
			var_model.var_attract_to_origin = 1;
			var_model thread namespace_zm_utility::function_create_zombie_point_of_interest_attractor_positions(4, 45);
			var_model thread namespace_zm_utility::function_wait_for_attractor_positions_complete();
			if(var_w_weapon.var_name == "t9_crossbow_skull_up")
			{
				var_model thread function_pulse_damage(self, var_w_weapon);
				var_model thread function_ad19108b();
				wait(2.6);
				var_model thread function_proximity_detonate(self, var_w_weapon);
			}
			else
			{
				var_model thread function_ad19108b();
				wait(1.9);
				var_model thread function_proximity_detonate(self, var_w_weapon);
			}
		}
		else if(var_w_weapon.var_name == "t9_crossbow_skull_up")
		{
			var_model thread function_pulse_damage(self, var_w_weapon);
			var_model thread function_ad19108b();
			wait(2.6);
			var_model thread function_proximity_detonate(self, var_w_weapon);
		}
		else
		{
			var_model thread function_ad19108b();
			wait(1.9);
			var_model thread function_proximity_detonate(self, var_w_weapon);
		}
	}
	else
	{
		var_model.var_script_noteworthy = undefined;
		function_PlayFXOnTag(level.var__effect["grenade_samantha_steal"], var_model, "tag_origin");
		if(isdefined(var_model))
		{
			var_model function_delete();
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
	Line Number: 336
*/
function function_1ff3643d(var_w_weapon, var_owner)
{
	self endon("hash_death");
	namespace_util::function_wait_network_frame();
	if(var_w_weapon.var_name == "t9_crossbow_skull_up")
	{
		function_PlayFXOnTag(level.var__effect["crossbow_skull_zombie_attract_ug"], self, "j_spine4");
	}
	else
	{
		function_PlayFXOnTag(level.var__effect["crossbow_skull_zombie_attract"], self, "j_spine4");
	}
	self namespace_zm_utility::function_create_zombie_point_of_interest(1024, 32, 10000);
	self.var_attract_to_origin = 1;
	self thread namespace_zm_utility::function_create_zombie_point_of_interest_attractor_positions(4, 45);
	self thread namespace_zm_utility::function_wait_for_attractor_positions_complete();
	if(var_w_weapon.var_name == "t9_crossbow_skull_up")
	{
		self thread function_pulse_damage(var_owner, var_w_weapon);
		self thread function_ad19108b();
		wait(2.6);
		self thread function_proximity_detonate(var_owner, var_w_weapon);
	}
	else
	{
		self thread function_ad19108b();
		wait(1.9);
		self thread function_proximity_detonate(var_owner, var_w_weapon);
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
	Line Number: 377
*/
function function_ad19108b()
{
	self function_PlayLoopSound("crossbow_beep");
}

/*
	Name: function_pulse_damage
	Namespace: namespace_2de6fd81
	Checksum: 0x424F4353
	Offset: 0x1478
	Size: 0x1E8
	Parameters: 2
	Flags: None
	Line Number: 392
*/
function function_pulse_damage(var_e_owner, var_w_weapon)
{
	self endon("hash_death");
	namespace_util::function_wait_network_frame();
	var_n_damage_origin = self.var_origin + VectorScale((0, 0, 1), 12);
	while(isdefined(self))
	{
		var_a_ai_targets = function_GetAITeamArray("axis");
		foreach(var_ai_target in var_a_ai_targets)
		{
			if(isdefined(var_ai_target))
			{
				var_n_distance_to_target = function_Distance(var_ai_target.var_origin, var_n_damage_origin);
				if(var_n_distance_to_target > 80)
				{
					continue;
				}
				var_n_damage = namespace_math::function_linear_map(var_n_distance_to_target, 0, 80, 160, 240);
				var_n_damage = namespace_5e1f56dc::function_bcb41215(undefined, var_e_owner, var_n_damage, undefined, undefined, var_w_weapon);
				var_ai_target function_DoDamage(var_n_damage, var_ai_target.var_origin, var_e_owner, self, "none", "MOD_GRENADE_SPLASH", 0, var_w_weapon);
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
	Line Number: 428
*/
function function_42f80185(var_parent)
{
	while(1)
	{
		if(!isdefined(var_parent))
		{
			namespace_zm_utility::function_self_delete();
			return;
		}
		wait(0.05);
	}
}

/*
	Name: function_move_valid_poi_to_navmesh
	Namespace: namespace_2de6fd81
	Checksum: 0x424F4353
	Offset: 0x16B8
	Size: 0x1F0
	Parameters: 1
	Flags: None
	Line Number: 451
*/
function function_move_valid_poi_to_navmesh(var_valid_poi)
{
	if(!(isdefined(var_valid_poi) && var_valid_poi))
	{
		return 0;
	}
	if(function_IsPointOnNavMesh(self.var_origin))
	{
		return 1;
	}
	var_v_orig = self.var_origin;
	var_queryResult = function_PositionQuery_Source_Navigation(self.var_origin, 0, level.var_VALID_POI_MAX_RADIUS, level.var_VALID_POI_HALF_HEIGHT, level.var_VALID_POI_INNER_SPACING, level.var_VALID_POI_RADIUS_FROM_EDGES);
	if(var_queryResult.var_data.size)
	{
		foreach(var_point in var_queryResult.var_data)
		{
			var_height_offset = function_Abs(self.var_origin[2] - var_point.var_origin[2]);
			if(var_height_offset > level.var_VALID_POI_HEIGHT)
			{
				continue;
			}
			if(function_BulletTracePassed(var_point.var_origin + VectorScale((0, 0, 1), 20), var_v_orig + VectorScale((0, 0, 1), 20), 0, self, undefined, 0, 0))
			{
				self.var_origin = var_point.var_origin;
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
	Line Number: 492
*/
function function_8d5b17df(var_ai, var_w_weapon)
{
	self endon("hash_disconnect");
	if(!isdefined(var_ai) || !function_isalive(var_ai))
	{
		return;
	}
	var_ai thread function_a541545(self, var_w_weapon);
}

/*
	Name: function_a541545
	Namespace: namespace_2de6fd81
	Checksum: 0x424F4353
	Offset: 0x1920
	Size: 0x220
	Parameters: 2
	Flags: None
	Line Number: 512
*/
function function_a541545(var_player, var_w_weapon)
{
	self endon("hash_death");
	var_player thread namespace_zm_audio::function_create_and_play_dialog("kill", "sword_slam");
	wait(0.05);
	if(var_w_weapon.var_name == "t9_crossbow_skull_up")
	{
		var_n_damage = namespace_5e1f56dc::function_bcb41215(undefined, var_player, 1140, undefined, undefined, var_w_weapon);
		if(var_n_damage > self.var_health)
		{
			function_PlayFXOnTag(level.var__effect["crossbow_skull_zombie_explode"], self, "j_head");
			if(isdefined(self) && function_IsActor(self))
			{
				namespace_GibServerUtils::function_GibHead(self);
			}
		}
		self function_DoDamage(var_n_damage, self.var_origin, var_player, undefined, "none", "MOD_EXPLOSIVE", 0, var_w_weapon);
	}
	else
	{
		var_n_damage = namespace_5e1f56dc::function_bcb41215(undefined, var_player, 800, undefined, undefined, var_w_weapon);
		if(var_n_damage > self.var_health)
		{
			function_PlayFXOnTag(level.var__effect["crossbow_skull_zombie_explode"], self, "j_head");
			if(isdefined(self) && function_IsActor(self))
			{
				namespace_GibServerUtils::function_GibHead(self);
			}
		}
		self function_DoDamage(var_n_damage, self.var_origin, var_player, undefined, "none", "MOD_EXPLOSIVE", 0, var_w_weapon);
	}
}

/*
	Name: function_862aadab
	Namespace: namespace_2de6fd81
	Checksum: 0x424F4353
	Offset: 0x1B48
	Size: 0x150
	Parameters: 1
	Flags: None
	Line Number: 555
*/
function function_862aadab(var_random_gibs)
{
	if(isdefined(self) && function_IsActor(self))
	{
		if(!var_random_gibs || function_RandomInt(100) < 50)
		{
			namespace_GibServerUtils::function_GibHead(self);
			return 1;
		}
		if(!var_random_gibs || function_RandomInt(100) < 50)
		{
			namespace_GibServerUtils::function_GibLeftArm(self);
			return 0;
		}
		if(!var_random_gibs || function_RandomInt(100) < 50)
		{
			namespace_GibServerUtils::function_GibRightArm(self);
			return 0;
		}
		if(!var_random_gibs || function_RandomInt(100) < 50)
		{
			namespace_GibServerUtils::function_GibLegs(self);
			return 0;
		}
		return 0;
	}
	return 0;
}

/*
	Name: function_2c75da4c
	Namespace: namespace_2de6fd81
	Checksum: 0x424F4353
	Offset: 0x1CA0
	Size: 0xA8
	Parameters: 13
	Flags: None
	Line Number: 594
*/
function function_2c75da4c(var_willBeKilled, var_inflictor, var_attacker, var_damage, var_flags, var_meansOfDeath, var_weapon, var_vPoint, var_vDir, var_sHitLoc, var_psOffsetTime, var_boneIndex, var_surfaceType)
{
	if(self function_609e17d0(var_meansOfDeath, var_weapon))
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
	Line Number: 614
*/
function function_609e17d0(var_mod, var_weapon)
{
	return var_weapon == function_GetWeapon("t9_crossbow_skull") || var_weapon == function_GetWeapon("t9_crossbow_skull_up") && (var_mod == "MOD_PROJECTILE" || var_mod == "MOD_PROJECTILE_SPLASH");
}

