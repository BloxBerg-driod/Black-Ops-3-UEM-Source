#include scripts\codescripts\struct;
#include scripts\shared\aat_shared;
#include scripts\shared\ai\systems\gib;
#include scripts\shared\ai\zombie_utility;
#include scripts\shared\array_shared;
#include scripts\shared\clientfield_shared;
#include scripts\shared\flag_shared;
#include scripts\shared\math_shared;
#include scripts\shared\spawner_shared;
#include scripts\shared\system_shared;
#include scripts\shared\table_shared;
#include scripts\shared\util_shared;
#include scripts\zm\_zm_stats;
#include scripts\zm\_zm_utility;

#namespace namespace_zm_aat_turned;

/*
	Name: function___init__sytem__
	Namespace: namespace_zm_aat_turned
	Checksum: 0x424F4353
	Offset: 0x290
	Size: 0x38
	Parameters: 0
	Flags: AutoExec
	Line Number: 27
*/
function autoexec function___init__sytem__()
{
	namespace_system::function_register("zm_aat_turned", &function___init__, undefined, "aat");
}

/*
	Name: function___init__
	Namespace: namespace_zm_aat_turned
	Checksum: 0x424F4353
	Offset: 0x2D0
	Size: 0x20
	Parameters: 0
	Flags: None
	Line Number: 42
*/
function function___init__()
{
	if(!(isdefined(level.var_aat_in_use) && level.var_aat_in_use))
	{
		return;
	}
}

/*
	Name: function_result
	Namespace: namespace_zm_aat_turned
	Checksum: 0x424F4353
	Offset: 0x2F8
	Size: 0x1B0
	Parameters: 4
	Flags: None
	Line Number: 60
*/
function function_result(var_death, var_attacker, var_mod, var_weapon)
{
	self thread namespace_clientfield::function_set("zm_aat_turned", 1);
	self thread function_zombie_death_time_limit(var_attacker);
	self.var_team = "allies";
	self.var_aat_turned = 1;
	self.var_n_aat_turned_zombie_kills = 0;
	self.var_allowdeath = 0;
	self.var_allowPain = 0;
	self.var_no_gib = 1;
	self namespace_zombie_utility::function_set_zombie_run_cycle("sprint");
	if(namespace_math::function_cointoss())
	{
		if(self.var_zombie_arms_position == "up")
		{
			self.var_variant_type = 6;
		}
		else
		{
			self.var_variant_type = 7;
		}
	}
	else if(self.var_zombie_arms_position == "up")
	{
		self.var_variant_type = 7;
	}
	else
	{
		self.var_variant_type = 8;
	}
	if(isdefined(var_attacker) && function_isPlayer(var_attacker))
	{
		var_attacker namespace_zm_stats::function_increment_challenge_stat("ZOMBIE_HUNTER_TURNED");
	}
	self thread function_turned_local_blast(var_attacker);
	self thread function_zombie_kill_tracker(var_attacker);
}

/*
	Name: function_turned_local_blast
	Namespace: namespace_zm_aat_turned
	Checksum: 0x424F4353
	Offset: 0x4B0
	Size: 0x2F0
	Parameters: 1
	Flags: None
	Line Number: 108
*/
function function_turned_local_blast(var_attacker)
{
	var_v_turned_blast_pos = self.var_origin;
	var_a_ai_zombies = namespace_Array::function_get_all_closest(var_v_turned_blast_pos, function_GetAITeamArray("axis"), undefined, undefined, 90);
	if(!isdefined(var_a_ai_zombies))
	{
		return;
	}
	var_f_turned_range_sq = 8100;
	var_n_flung_zombies = 0;
	for(var_i = 0; var_i < var_a_ai_zombies.size; var_i++)
	{
		if(!isdefined(var_a_ai_zombies[var_i]) || !function_isalive(var_a_ai_zombies[var_i]))
		{
			continue;
		}
		if(isdefined(level.var_AAT["zm_aat_turned"].var_immune_result_indirect[var_a_ai_zombies[var_i].var_archetype]) && level.var_AAT["zm_aat_turned"].var_immune_result_indirect[var_a_ai_zombies[var_i].var_archetype])
		{
			continue;
		}
		if(var_a_ai_zombies[var_i] == self)
		{
			continue;
		}
		var_v_curr_zombie_origin = var_a_ai_zombies[var_i] function_GetCentroid();
		if(function_DistanceSquared(var_v_turned_blast_pos, var_v_curr_zombie_origin) > var_f_turned_range_sq)
		{
			continue;
		}
		var_a_ai_zombies[var_i] function_DoDamage(var_a_ai_zombies[var_i].var_health, var_v_curr_zombie_origin, var_attacker, var_attacker, "none", "MOD_IMPACT");
		var_n_random_x = function_RandomFloatRange(-3, 3);
		var_n_random_y = function_RandomFloatRange(-3, 3);
		var_a_ai_zombies[var_i] function_StartRagdoll(1);
		var_a_ai_zombies[var_i] function_LaunchRagdoll(60 * function_VectorNormalize(var_v_curr_zombie_origin - var_v_turned_blast_pos + (var_n_random_x, var_n_random_y, 10)), "torso_lower");
		var_n_flung_zombies++;
		if(-1 && var_n_flung_zombies >= 3)
		{
			break;
		}
	}
	return;
	ERROR: Bad function call
}

/*
	Name: function_turned_zombie_validation
	Namespace: namespace_zm_aat_turned
	Checksum: 0x424F4353
	Offset: 0x7A8
	Size: 0xF8
	Parameters: 0
	Flags: None
	Line Number: 162
*/
function function_turned_zombie_validation()
{
	if(isdefined(level.var_AAT["zm_aat_turned"].var_immune_result_direct[self.var_archetype]) && level.var_AAT["zm_aat_turned"].var_immune_result_direct[self.var_archetype])
	{
		return 0;
	}
	if(isdefined(self.var_barricade_enter) && self.var_barricade_enter)
	{
		return 0;
	}
	if(isdefined(self.var_is_traversing) && self.var_is_traversing)
	{
		return 0;
	}
	if(!(isdefined(self.var_completed_emerging_into_playable_area) && self.var_completed_emerging_into_playable_area))
	{
		return 0;
	}
	if(isdefined(self.var_is_leaping) && self.var_is_leaping)
	{
		return 0;
	}
	if(isdefined(level.var_zm_aat_turned_validation_override) && !self [[level.var_zm_aat_turned_validation_override]]())
	{
		return 0;
	}
	return 1;
}

/*
	Name: function_zombie_death_time_limit
	Namespace: namespace_zm_aat_turned
	Checksum: 0x424F4353
	Offset: 0x8A8
	Size: 0x70
	Parameters: 1
	Flags: None
	Line Number: 201
*/
function function_zombie_death_time_limit(var_e_attacker)
{
	self endon("hash_death");
	self endon("hash_entityshutdown");
	wait(20);
	self namespace_clientfield::function_set("zm_aat_turned", 0);
	self.var_allowdeath = 1;
	self function_zombie_death_gib(var_e_attacker);
}

/*
	Name: function_zombie_kill_tracker
	Namespace: namespace_zm_aat_turned
	Checksum: 0x424F4353
	Offset: 0x920
	Size: 0x90
	Parameters: 1
	Flags: None
	Line Number: 221
*/
function function_zombie_kill_tracker(var_e_attacker)
{
	self endon("hash_death");
	self endon("hash_entityshutdown");
	while(self.var_n_aat_turned_zombie_kills < 12)
	{
		wait(0.05);
	}
	wait(0.5);
	self namespace_clientfield::function_set("zm_aat_turned", 0);
	self.var_allowdeath = 1;
	self function_zombie_death_gib(var_e_attacker);
}

/*
	Name: function_zombie_death_gib
	Namespace: namespace_zm_aat_turned
	Checksum: 0x424F4353
	Offset: 0x9B8
	Size: 0xA4
	Parameters: 1
	Flags: None
	Line Number: 245
*/
function function_zombie_death_gib(var_e_attacker)
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
	self function_DoDamage(self.var_health, self.var_origin);
}

