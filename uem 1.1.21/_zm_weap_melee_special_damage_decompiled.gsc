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
	Name: function___init__sytem__
	Namespace: namespace_a844404b
	Checksum: 0x424F4353
	Offset: 0x648
	Size: 0x38
	Parameters: 0
	Flags: AutoExec
	Line Number: 38
*/
function autoexec function___init__sytem__()
{
	namespace_system::function_register("zm_special_melee", &function___init__, undefined, undefined);
	return;
	ERROR: Exception occured: Stack empty.
}

/*
	Name: function___init__
	Namespace: namespace_a844404b
	Checksum: 0x424F4353
	Offset: 0x688
	Size: 0xD0
	Parameters: 0
	Flags: None
	Line Number: 55
*/
function function___init__()
{
	namespace_callback::function_on_connect(&function_on_player_connect);
	level.var_a41d0ea9 = namespace_lightning_chain::function_create_lightning_chain_params(1);
	level.var_a41d0ea9.var_head_gib_chance = 100;
	level.var_a41d0ea9.var_network_death_choke = 4;
	level.var_a41d0ea9.var_should_kill_enemies = 1;
	level.var_b2a993b8 = [];
	level.var_b2a993b8["seasonal_pipe"] = function_spawnstruct();
	level.var_b2a993b8["seasonal_pipe"].var_min_damage = 350;
}

/*
	Name: function_on_player_connect
	Namespace: namespace_a844404b
	Checksum: 0x424F4353
	Offset: 0x760
	Size: 0x20
	Parameters: 0
	Flags: None
	Line Number: 77
*/
function function_on_player_connect()
{
	self thread function_d52a054b();
	return;
	ERROR: Exception occured: Stack empty.
}

/*
	Name: function_f85ea925
	Namespace: namespace_a844404b
	Checksum: 0x424F4353
	Offset: 0x788
	Size: 0x60
	Parameters: 0
	Flags: None
	Line Number: 94
*/
function function_f85ea925()
{
	self endon("hash_disconnect");
	for(;;)
	{
		self waittill("hash_weapon_fired", var_weapon);
		function_IPrintLnBold("Weapon Fired, First test");
		self thread function_30cc4d3b();
	}
}

/*
	Name: function_30cc4d3b
	Namespace: namespace_a844404b
	Checksum: 0x424F4353
	Offset: 0x7F0
	Size: 0x168
	Parameters: 0
	Flags: None
	Line Number: 115
*/
function function_30cc4d3b()
{
	var_3e4d761f = function_GetWeapon("t9_gallo_raygun");
	var_start = self function_GetWeaponMuzzlePoint();
	var_forward_dir = self function_GetWeaponForwardDir();
	var_player_angles = self function_getPlayerAngles();
	var_mdl_weapon = namespace_zm_utility::function_spawn_weapon_model(var_3e4d761f, undefined, var_start, var_forward_dir);
	var_v_flash_pos = var_mdl_weapon function_GetTagOrigin("tag_flash");
	var_v_target_pos = var_mdl_weapon.var_origin + VectorScale(function_AnglesToForward(var_player_angles), 40);
	function_MagicBullet(var_3e4d761f, var_v_flash_pos, var_v_target_pos);
	namespace_util::function_wait_network_frame();
	var_mdl_weapon function_delete();
}

/*
	Name: function_d52a054b
	Namespace: namespace_a844404b
	Checksum: 0x424F4353
	Offset: 0x960
	Size: 0x298
	Parameters: 0
	Flags: None
	Line Number: 139
*/
function function_d52a054b()
{
	self endon("hash_disconnect");
	for(;;)
	{
		self waittill("hash_weapon_melee", var_weapon);
		if(var_weapon.var_name == "sw_lightsaber_obi_wan" || var_weapon.var_name == "sw_lightsaber_obi_wan_upgraded" || var_weapon.var_name == "sw_lightsaber_darth_vader" || var_weapon.var_name == "sw_lightsaber_darth_vader_upgraded")
		{
			self thread function_da195a32(var_weapon);
		}
		else if(var_weapon.var_name == "t9_bat_crockiller" || var_weapon.var_name == "t9_bat_crockiller_up" || var_weapon.var_name == "melee_jug" || var_weapon.var_name == "melee_jug_up" || var_weapon.var_name == "t9_me_knife_american" || var_weapon.var_name == "t9_me_knife_american_up" || var_weapon.var_name == "bowie_knife" || var_weapon.var_name == "melee_seasonal_pipe" || var_weapon.var_name == "melee_seasonal_pipe_upgraded" || var_weapon.var_name == "melee_4090" || var_weapon.var_name == "melee_4090_up" || var_weapon.var_name == "melee_t9_chrysalax" || var_weapon.var_name == "melee_t9_chrysalax_upgraded")
		{
			self thread function_e18b6e4a(var_weapon);
		}
		else if(var_weapon.var_name == "sw_lightsaber_kylo_ren" || var_weapon.var_name == "sw_lightsaber_kylo_ren_upgraded")
		{
			self thread function_da195a32(var_weapon);
		}
	}
}

/*
	Name: function_e18b6e4a
	Namespace: namespace_a844404b
	Checksum: 0x424F4353
	Offset: 0xC00
	Size: 0x548
	Parameters: 1
	Flags: None
	Line Number: 170
*/
function function_e18b6e4a(var_52baa43a)
{
	var_view_pos = self function_GetWeaponMuzzlePoint();
	var_v_player_angles = self function_getPlayerAngles();
	var_v_player_forward = function_AnglesToForward(var_v_player_angles);
	var_zombies = namespace_Array::function_get_all_closest(var_view_pos, function_GetAITeamArray(level.var_zombie_team), undefined, undefined, 600);
	if(var_52baa43a.var_name == "t9_bat_crockiller_up" || var_52baa43a.var_name == "melee_jug_up" || var_52baa43a.var_name == "melee_4090_up" || var_52baa43a.var_name == "t9_me_knife_american_up" || var_52baa43a.var_name == "melee_seasonal_pipe_upgraded" || var_52baa43a.var_name == "melee_t9_chrysalax_upgraded")
	{
		var_480fed80 = self namespace_5e1f56dc::function_1239e0ad(var_52baa43a);
		if(isdefined(var_480fed80))
		{
			if(var_480fed80.var_a39a2843 >= 1)
			{
				var_max_zombies = 3 + 1 * var_480fed80.var_a39a2843;
				if(var_max_zombies > 10)
				{
					var_max_zombies = 10;
				}
			}
			else
			{
				var_max_zombies = 3;
			}
		}
		else
		{
			var_max_zombies = 3;
		}
	}
	else
	{
		var_max_zombies = 3;
	}
	if(isdefined(var_max_zombies))
	{
		for(var_i = 0; var_i < var_max_zombies; var_i++)
		{
			if(!isdefined(var_zombies[var_i]) || !function_isalive(var_zombies[var_i]))
			{
				continue;
			}
			var_test_origin = var_zombies[var_i] function_GetCentroid();
			var_dist_sq = function_DistanceSquared(var_view_pos, var_test_origin);
			if(var_dist_sq >= 0 && var_dist_sq <= 3000)
			{
				var_6b049366 = var_zombies[var_i].var_origin - var_view_pos;
				var_6b049366 = function_VectorNormalize(var_6b049366);
				var_n_dot = function_VectorDot(var_v_player_forward, var_6b049366);
				if(var_n_dot >= 0.5)
				{
					self thread function_1dd32418(var_zombies[var_i], var_52baa43a, var_dist_sq);
					continue;
				}
			}
			if(var_52baa43a.var_name == "t9_bat_crockiller_up" || var_52baa43a.var_name == "melee_jug_up" || var_52baa43a.var_name == "melee_4090_up" || var_52baa43a.var_name == "t9_me_knife_american_up" || var_52baa43a.var_name == "melee_t9_chrysalax_upgraded")
			{
				if(var_dist_sq > 6084)
				{
					continue;
				}
			}
			else if(var_52baa43a.var_name == "melee_seasonal_pipe_upgraded" || var_52baa43a.var_name == "melee_seasonal_pipe")
			{
				if(var_dist_sq > 6084)
				{
					continue;
				}
			}
			else if(var_dist_sq > 6084)
			{
				continue;
			}
			var_6b049366 = var_zombies[var_i].var_origin - var_view_pos;
			var_6b049366 = function_VectorNormalize(var_6b049366);
			var_n_dot = function_VectorDot(var_v_player_forward, var_6b049366);
			if(var_n_dot < 0.65)
			{
				continue;
			}
			if(!var_zombies[var_i] function_cansee(self))
			{
				continue;
			}
			self thread function_1dd32418(var_zombies[var_i], var_52baa43a, var_dist_sq);
		}
	}
}

/*
	Name: function_1dd32418
	Namespace: namespace_a844404b
	Checksum: 0x424F4353
	Offset: 0x1150
	Size: 0x78
	Parameters: 3
	Flags: None
	Line Number: 268
*/
function function_1dd32418(var_ai, var_52baa43a, var_Distance)
{
	self endon("hash_disconnect");
	if(!isdefined(var_ai) || !function_isalive(var_ai))
	{
		return;
	}
	var_ai thread function_a541545(self, var_52baa43a, var_Distance);
}

/*
	Name: function_a541545
	Namespace: namespace_a844404b
	Checksum: 0x424F4353
	Offset: 0x11D0
	Size: 0x268
	Parameters: 3
	Flags: None
	Line Number: 288
*/
function function_a541545(var_player, var_w_weapon, var_Distance)
{
	self endon("hash_death");
	var_max_damage = 1375;
	var_480fed80 = self namespace_5e1f56dc::function_1239e0ad(var_w_weapon);
	if(isdefined(var_480fed80))
	{
		if(var_480fed80.var_a39a2843 >= 1 && var_480fed80.var_a39a2843 <= 7)
		{
			var_max_damage = var_max_damage + 200 * var_480fed80.var_a39a2843;
		}
		else if(var_480fed80.var_a39a2843 >= 8)
		{
			var_max_damage = var_max_damage;
		}
	}
	switch(var_w_weapon.var_name)
	{
		case "melee_4090_up":
		case "melee_jug_up":
		case "melee_seasonal_pipe_upgraded":
		case "t9_bat_crockiller_up":
		{
			var_max_damage = var_max_damage + 800;
			break;
		}
		case "t9_me_knife_american_up":
		{
			var_max_damage = var_max_damage + 1000;
			break;
		}
		case "t9_me_knife_american":
		{
			var_max_damage = var_max_damage - 400;
			break;
		}
	}
	var_n_damage = namespace_5e1f56dc::function_bcb41215(undefined, var_player, var_max_damage, undefined, undefined, var_w_weapon);
	if(var_n_damage > self.var_health)
	{
		var_player thread namespace_zm_audio::function_create_and_play_dialog("kill", "sword_slam");
		function_PlayFXOnTag(level.var__effect["crossbow_skull_zombie_explode"], self, "j_head");
	}
	else
	{
		function_PlayFXOnTag(level.var__effect["crossbow_skull_zombie_explode"], self, "j_spine4");
	}
	self function_DoDamage(var_n_damage, self.var_origin, var_player, undefined, "none", "MOD_MELEE", 0, var_w_weapon);
}

/*
	Name: function_da195a32
	Namespace: namespace_a844404b
	Checksum: 0x424F4353
	Offset: 0x1440
	Size: 0x2C8
	Parameters: 1
	Flags: Private
	Line Number: 348
*/
function private function_da195a32(var_52baa43a)
{
	var_view_pos = self function_GetWeaponMuzzlePoint();
	var_forward_view_angles = self function_GetWeaponForwardDir();
	var_zombies = namespace_Array::function_get_all_closest(var_view_pos, function_GetAITeamArray(level.var_zombie_team), undefined, undefined, 2 * level.var_zombie_vars["riotshield_knockdown_range"]);
	if(var_52baa43a.var_name == "sw_lightsaber_obi_wan_upgraded")
	{
		var_480fed80 = self namespace_5e1f56dc::function_1239e0ad(var_52baa43a);
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
	for(var_i = 0; var_i < var_max_zombies; var_i++)
	{
		if(!isdefined(var_zombies[var_i]) || !function_isalive(var_zombies[var_i]))
		{
			continue;
		}
		var_test_origin = var_zombies[var_i] function_GetCentroid();
		var_dist_sq = function_DistanceSquared(var_view_pos, var_test_origin);
		if(var_dist_sq > 10000)
		{
			continue;
		}
		var_normal = function_VectorNormalize(var_test_origin - var_view_pos);
		var_dot = function_VectorDot(var_forward_view_angles, var_normal);
		if(0.707 > var_dot)
		{
			continue;
		}
		if(0 == var_zombies[var_i] function_damageConeTrace(var_view_pos, self))
		{
			continue;
		}
		self thread function_20654ca0(var_zombies[var_i], var_52baa43a, var_dist_sq);
	}
}

/*
	Name: function_20654ca0
	Namespace: namespace_a844404b
	Checksum: 0x424F4353
	Offset: 0x1710
	Size: 0xF0
	Parameters: 3
	Flags: None
	Line Number: 408
*/
function function_20654ca0(var_ai, var_52baa43a, var_Distance)
{
	self endon("hash_disconnect");
	if(!isdefined(var_ai) || !function_isalive(var_ai))
	{
		return;
	}
	if(!isdefined(self.var_tesla_enemies_hit))
	{
		self.var_tesla_enemies_hit = 1;
	}
	var_ai notify("hash_bhtn_action_notify", "electrocute");
	var_ai.var_tesla_death = 0;
	var_ai thread function_fe8a580e(var_ai.var_origin, var_ai.var_origin, self, var_52baa43a);
	var_ai thread function_tesla_death(self, var_52baa43a, var_Distance);
}

/*
	Name: function_fe8a580e
	Namespace: namespace_a844404b
	Checksum: 0x424F4353
	Offset: 0x1808
	Size: 0x78
	Parameters: 4
	Flags: None
	Line Number: 435
*/
function function_fe8a580e(var_HIT_LOCATION, var_hit_origin, var_player, var_w_weapon)
{
	var_player endon("hash_disconnect");
	if(isdefined(self.var_zombie_tesla_hit) && self.var_zombie_tesla_hit)
	{
		return;
	}
	self namespace_lightning_chain::function_arc_damage(self, var_player, 1, level.var_tesla_lightning_params, var_w_weapon);
}

/*
	Name: function_tesla_death
	Namespace: namespace_a844404b
	Checksum: 0x424F4353
	Offset: 0x1888
	Size: 0x1A0
	Parameters: 3
	Flags: None
	Line Number: 455
*/
function function_tesla_death(var_player, var_w_weapon, var_Distance)
{
	self endon("hash_death");
	wait(1);
	var_player thread namespace_zm_audio::function_create_and_play_dialog("kill", "sword_slam");
	if(var_w_weapon.var_name == "sw_lightsaber_obi_wan_upgraded")
	{
		var_n_damage = namespace_5e1f56dc::function_bcb41215(undefined, var_player, 125 + var_Distance / 100 * 120, undefined, undefined, var_w_weapon);
	}
	else
	{
		var_n_damage = namespace_5e1f56dc::function_bcb41215(undefined, var_player, 125 + var_Distance / 100 * 50, undefined, undefined, var_w_weapon);
	}
	if(var_n_damage > self.var_health)
	{
		function_PlayFXOnTag(level.var__effect["crossbow_skull_zombie_explode"], self, "j_head");
		if(isdefined(self) && function_IsActor(self))
		{
			namespace_GibServerUtils::function_GibHead(self);
		}
	}
	self function_DoDamage(var_n_damage, self.var_origin, var_player, undefined, "none", "MOD_MELEE", 0, var_w_weapon);
}

/*
	Name: function_862aadab
	Namespace: namespace_a844404b
	Checksum: 0x424F4353
	Offset: 0x1A30
	Size: 0x130
	Parameters: 1
	Flags: None
	Line Number: 489
*/
function function_862aadab(var_random_gibs)
{
	if(isdefined(self) && function_IsActor(self))
	{
		if(!var_random_gibs || function_RandomInt(100) < 50)
		{
			namespace_GibServerUtils::function_GibHead(self);
		}
		if(!var_random_gibs || function_RandomInt(100) < 50)
		{
			namespace_GibServerUtils::function_GibLeftArm(self);
		}
		if(!var_random_gibs || function_RandomInt(100) < 50)
		{
			namespace_GibServerUtils::function_GibRightArm(self);
		}
		if(!var_random_gibs || function_RandomInt(100) < 50)
		{
			namespace_GibServerUtils::function_GibLegs(self);
		}
	}
}

/*
	Name: function_5c92a768
	Namespace: namespace_a844404b
	Checksum: 0x424F4353
	Offset: 0x1B68
	Size: 0x278
	Parameters: 1
	Flags: Private
	Line Number: 522
*/
function private function_5c92a768(var_52baa43a)
{
	var_view_pos = self function_GetWeaponMuzzlePoint();
	var_forward_view_angles = self function_GetWeaponForwardDir();
	var_zombies = namespace_Array::function_get_all_closest(var_view_pos, function_GetAITeamArray(level.var_zombie_team), undefined, undefined, 2 * level.var_zombie_vars["riotshield_knockdown_range"]);
	foreach(var_ai in var_zombies)
	{
		if(!isdefined(var_ai) || !function_isalive(var_ai))
		{
			continue;
		}
		var_test_origin = var_ai function_GetCentroid();
		var_dist_sq = function_DistanceSquared(var_view_pos, var_test_origin);
		if(var_dist_sq < 12100)
		{
			self thread function_disintegrate_zombie(var_ai, var_52baa43a);
			continue;
		}
		if(var_dist_sq > 12100)
		{
			continue;
		}
		var_normal = function_VectorNormalize(var_test_origin - var_view_pos);
		var_dot = function_VectorDot(var_forward_view_angles, var_normal);
		if(0.707 > var_dot)
		{
			continue;
		}
		if(0 == var_ai function_damageConeTrace(var_view_pos, self))
		{
			continue;
		}
		self thread function_disintegrate_zombie(var_ai, var_52baa43a);
	}
}

/*
	Name: function_disintegrate_zombie
	Namespace: namespace_a844404b
	Checksum: 0x424F4353
	Offset: 0x1DE8
	Size: 0x68
	Parameters: 2
	Flags: None
	Line Number: 568
*/
function function_disintegrate_zombie(var_ai, var_52baa43a)
{
	self endon("hash_disconnect");
	if(!isdefined(var_ai) || !function_isalive(var_ai))
	{
		return;
	}
	var_ai thread function_5e2a765b(self, var_52baa43a);
	return;
}

/*
	Name: function_5e2a765b
	Namespace: namespace_a844404b
	Checksum: 0x424F4353
	Offset: 0x1E58
	Size: 0x1B4
	Parameters: 2
	Flags: None
	Line Number: 589
*/
function function_5e2a765b(var_e_attacker, var_w_weapon)
{
	self endon("hash_death");
	if(isdefined(self.var_b_disintegrating) && self.var_b_disintegrating)
	{
		return;
	}
	self.var_b_disintegrating = 1;
	self namespace_clientfield::function_set("ai_disintegrate", 1);
	if(function_isVehicle(self))
	{
		self namespace_ai::function_set_ignoreall(1);
		wait(1.1);
		self function_ghost();
		self function_DoDamage(self.var_health + 666, self.var_origin, var_e_attacker, undefined, undefined, "MOD_UNKNOWN", 0, var_w_weapon);
	}
	else
	{
		self namespace_scene::function_Play("cin_zm_dlc3_zombie_dth_deathray_0" + function_randomIntRange(1, 4), self);
		self namespace_clientfield::function_set("ai_slow_vortex_fx", 0);
		namespace_util::function_wait_network_frame();
		self function_ghost();
		self function_DoDamage(self.var_health + 666, self.var_origin, var_e_attacker, undefined, undefined, "MOD_UNKNOWN", 0, var_w_weapon);
	}
}

