#include scripts\codescripts\struct;
#include scripts\shared\aat_shared;
#include scripts\shared\ai\systems\gib;
#include scripts\shared\array_shared;
#include scripts\shared\clientfield_shared;
#include scripts\shared\flag_shared;
#include scripts\shared\math_shared;
#include scripts\shared\system_shared;
#include scripts\shared\util_shared;
#include scripts\zm\_zm_spawner;
#include scripts\zm\_zm_stats;
#include scripts\zm\_zm_utility;

#namespace namespace_zm_aat_fire_works;

/*
	Name: function___init__sytem__
	Namespace: namespace_zm_aat_fire_works
	Checksum: 0x424F4353
	Offset: 0x278
	Size: 0x38
	Parameters: 0
	Flags: AutoExec
	Line Number: 25
*/
function autoexec function___init__sytem__()
{
	namespace_system::function_register("zm_aat_fire_works", &function___init__, undefined, "aat");
}

/*
	Name: function___init__
	Namespace: namespace_zm_aat_fire_works
	Checksum: 0x424F4353
	Offset: 0x2B8
	Size: 0x100
	Parameters: 0
	Flags: None
	Line Number: 40
*/
function function___init__()
{
	if(!(isdefined(level.var_aat_in_use) && level.var_aat_in_use))
	{
		return;
	}
	namespace_AAT::function_register("zm_aat_fire_works", 0.1, 0, function_randomIntRange(27, 32), 10, 1, &function_result, "t7_hud_zm_aat_fireworks", "wpn_aat_fire_works_plr", &function_fire_works_zombie_validation);
	namespace_clientfield::function_register("scriptmover", "zm_aat_fire_works", 1, 1, "int");
	namespace_zm_spawner::function_register_zombie_damage_callback(&function_zm_aat_fire_works_zombie_damage_response);
	namespace_zm_spawner::function_register_zombie_death_event_callback(&function_zm_aat_fire_works_death_callback);
	return;
}

/*
	Name: function_result
	Namespace: namespace_zm_aat_fire_works
	Checksum: 0x424F4353
	Offset: 0x3C0
	Size: 0x48
	Parameters: 4
	Flags: None
	Line Number: 63
*/
function function_result(var_death, var_attacker, var_mod, var_weapon)
{
	self function_fire_works_summon(var_attacker, var_weapon);
}

/*
	Name: function_fire_works_zombie_validation
	Namespace: namespace_zm_aat_fire_works
	Checksum: 0x424F4353
	Offset: 0x410
	Size: 0x88
	Parameters: 0
	Flags: None
	Line Number: 78
*/
function function_fire_works_zombie_validation()
{
	if(isdefined(self.var_barricade_enter) && self.var_barricade_enter)
	{
		return 0;
	}
	if(isdefined(self.var_is_traversing) && self.var_is_traversing)
	{
		return 0;
	}
	if(!(isdefined(self.var_completed_emerging_into_playable_area) && self.var_completed_emerging_into_playable_area) && !isdefined(self.var_first_node))
	{
		return 0;
	}
	if(isdefined(self.var_is_leaping) && self.var_is_leaping)
	{
		return 0;
	}
	return 1;
}

/*
	Name: function_fire_works_summon
	Namespace: namespace_zm_aat_fire_works
	Checksum: 0x424F4353
	Offset: 0x4A0
	Size: 0x418
	Parameters: 2
	Flags: None
	Line Number: 109
*/
function function_fire_works_summon(var_e_player, var_w_weapon)
{
	var_w_summoned_weapon = var_e_player function_GetCurrentWeapon();
	var_v_target_zombie_origin = self.var_origin;
	if(!(isdefined(level.var_AAT["zm_aat_fire_works"].var_immune_result_direct[self.var_archetype]) && level.var_AAT["zm_aat_fire_works"].var_immune_result_direct[self.var_archetype]))
	{
		self thread function_zombie_death_gib(var_e_player, var_w_weapon, var_e_player);
	}
	var_v_firing_pos = var_v_target_zombie_origin + VectorScale((0, 0, 1), 56);
	var_v_start_yaw = function_VectorToAngles(var_v_firing_pos - var_v_target_zombie_origin);
	var_v_start_yaw = (0, var_v_start_yaw[1], 0);
	var_mdl_weapon = namespace_zm_utility::function_spawn_weapon_model(var_w_summoned_weapon, undefined, var_v_target_zombie_origin, var_v_start_yaw);
	var_mdl_weapon.var_owner = var_e_player;
	var_mdl_weapon.var_b_aat_fire_works_weapon = 1;
	var_mdl_weapon.var_allow_zombie_to_target_ai = 1;
	var_mdl_weapon thread namespace_clientfield::function_set("zm_aat_fire_works", 1);
	var_mdl_weapon function_moveto(var_v_firing_pos, 0.5);
	var_mdl_weapon waittill("hash_movedone");
	var_35347698 = 0;
	var_87f2cced = 5;
	for(var_i = 0; var_i < 4; var_i++)
	{
		var_zombie = var_mdl_weapon function_zm_aat_fire_works_get_target();
		if(!isdefined(var_zombie))
		{
			var_v_curr_yaw = (0, function_randomIntRange(0, 360), 0);
			var_v_target_pos = var_mdl_weapon.var_origin + VectorScale(function_AnglesToForward(var_v_curr_yaw), 40);
		}
		else
		{
			var_v_target_pos = var_zombie function_GetCentroid();
			var_35347698++;
		}
		var_mdl_weapon.var_angles = function_VectorToAngles(var_v_target_pos - var_mdl_weapon.var_origin);
		var_v_flash_pos = var_mdl_weapon function_GetTagOrigin("tag_flash");
		var_mdl_weapon function_DontInterpolate();
		function_MagicBullet(var_w_summoned_weapon, var_v_flash_pos, var_v_target_pos, var_mdl_weapon);
		namespace_util::function_wait_network_frame();
	}
	var_mdl_weapon function_moveto(var_v_target_zombie_origin, 0.5);
	var_mdl_weapon waittill("hash_movedone");
	var_mdl_weapon namespace_clientfield::function_set("zm_aat_fire_works", 0);
	namespace_util::function_wait_network_frame();
	namespace_util::function_wait_network_frame();
	namespace_util::function_wait_network_frame();
	var_mdl_weapon function_delete();
	wait(0.25);
}

/*
	Name: function_zm_aat_fire_works_get_target
	Namespace: namespace_zm_aat_fire_works
	Checksum: 0x424F4353
	Offset: 0x8C0
	Size: 0x128
	Parameters: 0
	Flags: None
	Line Number: 168
*/
function function_zm_aat_fire_works_get_target()
{
	var_a_ai_zombies = namespace_Array::function_randomize(function_GetAITeamArray("axis"));
	var_los_checks = 0;
	for(var_i = 0; var_i < var_a_ai_zombies.size; var_i++)
	{
		var_zombie = var_a_ai_zombies[var_i];
		var_test_origin = var_zombie function_GetCentroid();
		if(function_DistanceSquared(self.var_origin, var_test_origin) > 250)
		{
			continue;
		}
		if(var_los_checks < 3 && !var_zombie function_damageConeTrace(self.var_origin))
		{
			var_los_checks++;
			continue;
		}
		return var_zombie;
	}
	if(var_a_ai_zombies.size)
	{
		return var_a_ai_zombies[0];
	}
	return undefined;
}

/*
	Name: function_zm_aat_fire_works_zombie_damage_response
	Namespace: namespace_zm_aat_fire_works
	Checksum: 0x424F4353
	Offset: 0x9F0
	Size: 0x120
	Parameters: 13
	Flags: None
	Line Number: 204
*/
function function_zm_aat_fire_works_zombie_damage_response(var_str_mod, var_str_hit_location, var_v_hit_origin, var_e_attacker, var_n_amount, var_w_weapon, var_direction_vec, var_tagName, var_modelName, var_partName, var_dFlags, var_inflictor, var_chargeLevel)
{
	if(isdefined(level.var_AAT["zm_aat_fire_works"].var_immune_result_indirect[self.var_archetype]) && level.var_AAT["zm_aat_fire_works"].var_immune_result_indirect[self.var_archetype])
	{
		return 0;
	}
	if(isdefined(var_e_attacker.var_b_aat_fire_works_weapon) && var_e_attacker.var_b_aat_fire_works_weapon)
	{
		self thread function_zombie_death_gib(var_e_attacker, var_w_weapon, var_e_attacker.var_owner);
		return 1;
	}
	return 0;
}

/*
	Name: function_zm_aat_fire_works_death_callback
	Namespace: namespace_zm_aat_fire_works
	Checksum: 0x424F4353
	Offset: 0xB18
	Size: 0x68
	Parameters: 1
	Flags: None
	Line Number: 228
*/
function function_zm_aat_fire_works_death_callback(var_attacker)
{
	if(isdefined(var_attacker))
	{
		if(isdefined(var_attacker.var_b_aat_fire_works_weapon) && var_attacker.var_b_aat_fire_works_weapon)
		{
			if(isdefined(var_attacker.var_owner))
			{
				var_e_attacking_player = var_attacker.var_owner;
			}
		}
	}
}

/*
	Name: function_zombie_death_gib
	Namespace: namespace_zm_aat_fire_works
	Checksum: 0x424F4353
	Offset: 0xB88
	Size: 0x104
	Parameters: 3
	Flags: None
	Line Number: 252
*/
function function_zombie_death_gib(var_e_attacker, var_w_weapon, var_e_owner)
{
	namespace_GibServerUtils::function_GibHead(self);
	if(namespace_math::function_cointoss())
	{
		namespace_GibServerUtils::function_GibLeftArm(self);
	}
	else
	{
		namespace_GibServerUtils::function_GibRightArm(self);
	}
	namespace_GibServerUtils::function_GibLegs(self);
	self function_DoDamage(self.var_health, self.var_origin, var_e_attacker, var_w_weapon, "torso_upper");
	if(isdefined(var_e_owner) && function_isPlayer(var_e_owner))
	{
		var_e_owner namespace_zm_stats::function_increment_challenge_stat("ZOMBIE_HUNTER_FIRE_WORKS");
	}
}

