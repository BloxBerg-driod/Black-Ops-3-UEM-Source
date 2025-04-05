#include scripts\codescripts\struct;
#include scripts\shared\aat_shared;
#include scripts\shared\ai\systems\gib;
#include scripts\shared\array_shared;
#include scripts\shared\clientfield_shared;
#include scripts\shared\flag_shared;
#include scripts\shared\math_shared;
#include scripts\shared\system_shared;
#include scripts\shared\util_shared;
#include scripts\zm\_zm_stats;
#include scripts\zm\_zm_utility;

#namespace namespace_zm_aat_blast_furnace;

/*
	Name: function___init__sytem__
	Namespace: namespace_zm_aat_blast_furnace
	Checksum: 0x424F4353
	Offset: 0x2A0
	Size: 0x38
	Parameters: 0
	Flags: AutoExec
	Line Number: 24
*/
function autoexec function___init__sytem__()
{
	namespace_system::function_register("zm_aat_blast_furnace", &function___init__, undefined, "aat");
}

/*
	Name: function___init__
	Namespace: namespace_zm_aat_blast_furnace
	Checksum: 0x424F4353
	Offset: 0x2E0
	Size: 0x160
	Parameters: 0
	Flags: None
	Line Number: 39
*/
function function___init__()
{
	if(!(isdefined(level.var_aat_in_use) && level.var_aat_in_use))
	{
		return;
	}
	namespace_AAT::function_register("zm_aat_blast_furnace", 0.1, 0, function_randomIntRange(27, 32), 0, 1, &function_result, "t7_hud_zm_aat_blastfurnace", "wpn_aat_blast_furnace_plr");
	namespace_clientfield::function_register("actor", "zm_aat_blast_furnace" + "_explosion", 1, 1, "counter");
	namespace_clientfield::function_register("vehicle", "zm_aat_blast_furnace" + "_explosion_vehicle", 1, 1, "counter");
	namespace_clientfield::function_register("actor", "zm_aat_blast_furnace" + "_burn", 1, 1, "counter");
	namespace_clientfield::function_register("vehicle", "zm_aat_blast_furnace" + "_burn_vehicle", 1, 1, "counter");
}

/*
	Name: function_result
	Namespace: namespace_zm_aat_blast_furnace
	Checksum: 0x424F4353
	Offset: 0x448
	Size: 0x48
	Parameters: 4
	Flags: None
	Line Number: 62
*/
function function_result(var_death, var_attacker, var_mod, var_weapon)
{
	self thread function_blast_furnace_explosion(var_attacker, var_weapon);
}

/*
	Name: function_blast_furnace_explosion
	Namespace: namespace_zm_aat_blast_furnace
	Checksum: 0x424F4353
	Offset: 0x498
	Size: 0x408
	Parameters: 2
	Flags: None
	Line Number: 77
*/
function function_blast_furnace_explosion(var_e_attacker, var_w_weapon)
{
	if(function_isVehicle(self))
	{
		self thread namespace_clientfield::function_increment("zm_aat_blast_furnace" + "_explosion_vehicle");
	}
	else
	{
		self thread namespace_clientfield::function_increment("zm_aat_blast_furnace" + "_explosion");
	}
	var_a_e_blasted_zombies = namespace_Array::function_get_all_closest(self.var_origin, function_GetAITeamArray("axis"), undefined, undefined, 110);
	if(var_a_e_blasted_zombies.size > 0)
	{
		var_i = 0;
		while(var_i < var_a_e_blasted_zombies.size)
		{
			if(function_isalive(var_a_e_blasted_zombies[var_i]))
			{
				if(isdefined(level.var_AAT["zm_aat_blast_furnace"].var_immune_result_indirect[var_a_e_blasted_zombies[var_i].var_archetype]) && level.var_AAT["zm_aat_blast_furnace"].var_immune_result_indirect[var_a_e_blasted_zombies[var_i].var_archetype])
				{
					function_ArrayRemoveValue(var_a_e_blasted_zombies, var_a_e_blasted_zombies[var_i]);
					continue;
				}
				if(var_a_e_blasted_zombies[var_i] == self && (!(isdefined(level.var_AAT["zm_aat_blast_furnace"].var_immune_result_direct[var_a_e_blasted_zombies[var_i].var_archetype]) && level.var_AAT["zm_aat_blast_furnace"].var_immune_result_direct[var_a_e_blasted_zombies[var_i].var_archetype])))
				{
					self thread function_zombie_death_gib(var_e_attacker, var_w_weapon);
					if(function_isVehicle(var_a_e_blasted_zombies[var_i]))
					{
						var_a_e_blasted_zombies[var_i] thread namespace_clientfield::function_increment("zm_aat_blast_furnace" + "_burn_vehicle");
					}
					else
					{
						var_a_e_blasted_zombies[var_i] thread namespace_clientfield::function_increment("zm_aat_blast_furnace" + "_burn");
					}
					function_ArrayRemoveValue(var_a_e_blasted_zombies, var_a_e_blasted_zombies[var_i]);
					continue;
				}
				if(function_isVehicle(var_a_e_blasted_zombies[var_i]))
				{
					var_a_e_blasted_zombies[var_i] thread namespace_clientfield::function_increment("zm_aat_blast_furnace" + "_burn_vehicle");
				}
				else
				{
					var_a_e_blasted_zombies[var_i] thread namespace_clientfield::function_increment("zm_aat_blast_furnace" + "_burn");
				}
			}
			var_i++;
		}
		wait(0.25);
		var_a_e_blasted_zombies = namespace_Array::function_remove_dead(var_a_e_blasted_zombies);
		var_a_e_blasted_zombies = namespace_Array::function_remove_undefined(var_a_e_blasted_zombies);
		var_killed = 0;
		for(var_i = 0; var_i < 4; var_i++)
		{
			var_a_e_blasted_zombies[var_i] thread function_blast_furnace_zombie_burn(var_e_attacker, var_w_weapon);
			var_killed++;
			wait(0.12);
		}
	}
}

/*
	Name: function_blast_furnace_zombie_burn
	Namespace: namespace_zm_aat_blast_furnace
	Checksum: 0x424F4353
	Offset: 0x8A8
	Size: 0xD0
	Parameters: 2
	Flags: None
	Line Number: 148
*/
function function_blast_furnace_zombie_burn(var_e_attacker, var_w_weapon)
{
	self endon("hash_death");
	var_n_damage = self.var_health / 3;
	for(var_i = 0; var_i <= 3; var_i++)
	{
		if(self.var_health < var_n_damage)
		{
			var_e_attacker namespace_zm_stats::function_increment_challenge_stat("ZOMBIE_HUNTER_BLAST_FURNACE");
		}
		self function_DoDamage(var_n_damage, self.var_origin, var_e_attacker, undefined, "none", "MOD_UNKNOWN", 0, var_w_weapon);
		wait(0.5);
	}
}

/*
	Name: function_zombie_death_gib
	Namespace: namespace_zm_aat_blast_furnace
	Checksum: 0x424F4353
	Offset: 0x980
	Size: 0xEC
	Parameters: 2
	Flags: None
	Line Number: 173
*/
function function_zombie_death_gib(var_e_attacker, var_w_weapon)
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
	self function_DoDamage(self.var_health, self.var_origin, var_e_attacker);
	if(isdefined(var_e_attacker) && function_isPlayer(var_e_attacker))
	{
		var_e_attacker namespace_zm_stats::function_increment_challenge_stat("ZOMBIE_HUNTER_BLAST_FURNACE");
	}
}

