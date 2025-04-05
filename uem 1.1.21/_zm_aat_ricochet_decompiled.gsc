#include scripts\codescripts\struct;
#include scripts\shared\aat_shared;
#include scripts\shared\ai\systems\gib;
#include scripts\shared\ai\zombie_utility;
#include scripts\shared\array_shared;
#include scripts\shared\clientfield_shared;
#include scripts\shared\flag_shared;
#include scripts\shared\math_shared;
#include scripts\shared\system_shared;
#include scripts\shared\util_shared;
#include scripts\zm\_zm_audio;
#include scripts\zm\_zm_lightning_chain;
#include scripts\zm\_zm_utility;

#namespace namespace_832f77bb;

/*
	Name: function___init__sytem__
	Namespace: namespace_832f77bb
	Checksum: 0x424F4353
	Offset: 0x2A8
	Size: 0x38
	Parameters: 0
	Flags: AutoExec
	Line Number: 26
*/
function autoexec function___init__sytem__()
{
	namespace_system::function_register("zm_aat_ricochet", &function___init__, undefined, "aat");
}

/*
	Name: function___init__
	Namespace: namespace_832f77bb
	Checksum: 0x424F4353
	Offset: 0x2E8
	Size: 0x80
	Parameters: 0
	Flags: None
	Line Number: 41
*/
function function___init__()
{
	if(!(isdefined(level.var_aat_in_use) && level.var_aat_in_use))
	{
		return;
	}
	namespace_AAT::function_register("zm_aat_ricochet", 0.1, 0, function_randomIntRange(27, 32), 2, 1, &function_result, "t7_hud_zm_aat_deadwire", "wpn_aat_ricochet_plr");
}

/*
	Name: function_result
	Namespace: namespace_832f77bb
	Checksum: 0x424F4353
	Offset: 0x370
	Size: 0x48
	Parameters: 4
	Flags: None
	Line Number: 60
*/
function function_result(var_death, var_attacker, var_mod, var_weapon)
{
	self function_379e1914(var_attacker, var_weapon);
}

/*
	Name: function_379e1914
	Namespace: namespace_832f77bb
	Checksum: 0x424F4353
	Offset: 0x3C0
	Size: 0x2E8
	Parameters: 2
	Flags: None
	Line Number: 75
*/
function function_379e1914(var_e_attacker, var_w_weapon)
{
	var_ec4fed16 = namespace_Array::function_get_all_closest(self.var_origin, function_GetAITeamArray("axis"), undefined, undefined, 150);
	if(var_ec4fed16.size > 0)
	{
		var_i = 0;
		while(var_i < var_ec4fed16.size)
		{
			if(function_isalive(var_ec4fed16[var_i]))
			{
				if(isdefined(level.var_AAT["zm_aat_ricochet"].var_immune_result_indirect[var_ec4fed16[var_i].var_archetype]) && level.var_AAT["zm_aat_ricochet"].var_immune_result_indirect[var_ec4fed16[var_i].var_archetype])
				{
					function_ArrayRemoveValue(var_ec4fed16, var_ec4fed16[var_i]);
					continue;
				}
				if(function_isVehicle(var_ec4fed16[var_i]))
				{
					function_ArrayRemoveValue(var_ec4fed16, var_ec4fed16[var_i]);
					continue;
				}
				if(var_ec4fed16[var_i] == self && (!(isdefined(level.var_AAT["zm_aat_ricochet"].var_immune_result_direct[var_ec4fed16[var_i].var_archetype]) && level.var_AAT["zm_aat_ricochet"].var_immune_result_direct[var_ec4fed16[var_i].var_archetype])))
				{
					self thread function_zombie_death_gib(var_e_attacker, var_w_weapon);
					function_ArrayRemoveValue(var_ec4fed16, var_ec4fed16[var_i]);
					continue;
				}
			}
			var_i++;
		}
		wait(0.2);
		var_ec4fed16 = namespace_Array::function_remove_dead(var_ec4fed16);
		var_ec4fed16 = namespace_Array::function_remove_undefined(var_ec4fed16);
		var_killed = 0;
		for(var_i = 0; var_i < 4; var_i++)
		{
			var_ec4fed16[var_i] thread function_zombie_death_gib(var_e_attacker, var_w_weapon);
			var_killed++;
			wait(0.15);
		}
	}
}

/*
	Name: function_zombie_death_gib
	Namespace: namespace_832f77bb
	Checksum: 0x424F4353
	Offset: 0x6B0
	Size: 0x124
	Parameters: 2
	Flags: None
	Line Number: 127
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
	var_e_attacker thread namespace_zm_audio::function_create_and_play_dialog("kill", "sword_slam");
	function_PlayFXOnTag(level.var__effect["crossbow_skull_zombie_explode"], self, "j_head");
	wait(0.05);
	self function_DoDamage(self.var_health * 5, self.var_origin, var_e_attacker, undefined, "none", "MOD_HEAD_SHOT", 0, var_w_weapon);
}

