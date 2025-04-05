#include scripts\codescripts\struct;
#include scripts\shared\aat_shared;
#include scripts\shared\ai\systems\gib;
#include scripts\shared\array_shared;
#include scripts\shared\clientfield_shared;
#include scripts\shared\flag_shared;
#include scripts\shared\fx_shared;
#include scripts\shared\math_shared;
#include scripts\shared\system_shared;
#include scripts\shared\util_shared;
#include scripts\zm\_zm_stats;
#include scripts\zm\_zm_utility;

#namespace namespace_zm_aat_thunder_wall;

/*
	Name: function___init__sytem__
	Namespace: namespace_zm_aat_thunder_wall
	Checksum: 0x424F4353
	Offset: 0x2B8
	Size: 0x38
	Parameters: 0
	Flags: AutoExec
	Line Number: 25
*/
function autoexec function___init__sytem__()
{
	namespace_system::function_register("zm_aat_thunder_wall", &function___init__, undefined, "aat");
}

/*
	Name: function___init__
	Namespace: namespace_zm_aat_thunder_wall
	Checksum: 0x424F4353
	Offset: 0x2F8
	Size: 0xA0
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
	namespace_AAT::function_register("zm_aat_thunder_wall", 0.1, 0, function_randomIntRange(27, 32), 0, 1, &function_result, "t7_hud_zm_aat_thunderwall", "wpn_aat_thunder_wall_plr");
	level.var__effect["zm_aat_thunder_wall" + "_break_fx"] = "zombie/fx_aat_thunderwall_zmb";
}

/*
	Name: function_result
	Namespace: namespace_zm_aat_thunder_wall
	Checksum: 0x424F4353
	Offset: 0x3A0
	Size: 0x40
	Parameters: 4
	Flags: None
	Line Number: 60
*/
function function_result(var_death, var_attacker, var_mod, var_weapon)
{
	self thread function_thunder_wall_blast(var_attacker);
}

/*
	Name: function_thunder_wall_blast
	Namespace: namespace_zm_aat_thunder_wall
	Checksum: 0x424F4353
	Offset: 0x3E8
	Size: 0x538
	Parameters: 1
	Flags: None
	Line Number: 75
*/
function function_thunder_wall_blast(var_attacker)
{
	var_v_thunder_wall_blast_pos = self.var_origin;
	var_v_attacker_facing_forward_dir = function_VectorToAngles(var_v_thunder_wall_blast_pos - var_attacker.var_origin);
	var_v_attacker_facing = var_attacker function_GetWeaponForwardDir();
	var_v_attacker_orientation = var_attacker.var_angles;
	var_a_ai_zombies = namespace_Array::function_get_all_closest(var_v_thunder_wall_blast_pos, function_GetAITeamArray("axis"), undefined, undefined, 220);
	if(!isdefined(var_a_ai_zombies))
	{
		return;
	}
	var_f_thunder_wall_range_sq = 12100;
	var_f_thunder_wall_effect_area_sq = 108900;
	var_end_pos = var_v_thunder_wall_blast_pos + VectorScale(var_v_attacker_facing, 110);
	self function_playsound("wpn_aat_thunderwall_impact");
	level thread function_thunder_wall_blast_fx(var_v_thunder_wall_blast_pos, var_v_attacker_orientation);
	var_n_flung_zombies = 0;
	for(var_i = 0; var_i < 5; var_i++)
	{
		if(!isdefined(var_a_ai_zombies[var_i]) || !function_isalive(var_a_ai_zombies[var_i]))
		{
			continue;
		}
		if(isdefined(level.var_AAT["zm_aat_thunder_wall"].var_immune_result_direct[var_a_ai_zombies[var_i].var_archetype]) && level.var_AAT["zm_aat_thunder_wall"].var_immune_result_direct[var_a_ai_zombies[var_i].var_archetype])
		{
			continue;
		}
		if(var_a_ai_zombies[var_i] == self)
		{
			var_v_curr_zombie_origin = self.var_origin;
			var_v_curr_zombie_origin_sq = 0;
		}
		else
		{
			var_v_curr_zombie_origin = var_a_ai_zombies[var_i] function_GetCentroid();
			var_v_curr_zombie_origin_sq = function_DistanceSquared(var_v_thunder_wall_blast_pos, var_v_curr_zombie_origin);
			var_v_curr_zombie_to_thunder_wall = function_VectorNormalize(var_v_curr_zombie_origin - var_v_thunder_wall_blast_pos);
			var_v_curr_zombie_facing_dot = function_VectorDot(var_v_attacker_facing, var_v_curr_zombie_to_thunder_wall);
			if(var_v_curr_zombie_facing_dot < 0)
			{
				continue;
			}
			var_radial_origin = function_PointOnSegmentNearestToPoint(var_v_thunder_wall_blast_pos, var_end_pos, var_v_curr_zombie_origin);
			if(function_DistanceSquared(var_v_curr_zombie_origin, var_radial_origin) > var_f_thunder_wall_effect_area_sq)
			{
				continue;
			}
		}
		if(var_v_curr_zombie_origin_sq < var_f_thunder_wall_range_sq)
		{
			var_a_ai_zombies[var_i] function_DoDamage(var_a_ai_zombies[var_i].var_health, var_v_curr_zombie_origin, var_attacker, var_attacker, "none", "MOD_IMPACT");
			if(isdefined(var_attacker) && function_isPlayer(var_attacker))
			{
				var_attacker namespace_zm_stats::function_increment_challenge_stat("ZOMBIE_HUNTER_THUNDER_WALL");
			}
			if(!(isdefined(level.var_AAT["zm_aat_thunder_wall"].var_immune_result_indirect[self.var_archetype]) && level.var_AAT["zm_aat_thunder_wall"].var_immune_result_indirect[self.var_archetype]))
			{
				var_n_random_x = function_RandomFloatRange(-3, 3);
				var_n_random_y = function_RandomFloatRange(-3, 3);
				var_a_ai_zombies[var_i] function_StartRagdoll(1);
				var_a_ai_zombies[var_i] function_LaunchRagdoll(100 * function_VectorNormalize(var_v_curr_zombie_origin - var_v_thunder_wall_blast_pos + (var_n_random_x, var_n_random_y, 30)), "torso_lower");
			}
			var_n_flung_zombies++;
		}
		if(-1 && var_n_flung_zombies >= 5)
		{
			break;
		}
	}
}

/*
	Name: function_thunder_wall_blast_fx
	Namespace: namespace_zm_aat_thunder_wall
	Checksum: 0x424F4353
	Offset: 0x928
	Size: 0x4C
	Parameters: 2
	Flags: None
	Line Number: 156
*/
function function_thunder_wall_blast_fx(var_v_blast_origin, var_v_attacker_orientation)
{
	namespace_FX::function_Play("zm_aat_thunder_wall" + "_break_fx", var_v_blast_origin, var_v_attacker_orientation, 1);
}

