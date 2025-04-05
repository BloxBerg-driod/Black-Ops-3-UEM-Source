#include scripts\codescripts\struct;
#include scripts\shared\ai\zombie_utility;
#include scripts\shared\flag_shared;
#include scripts\shared\system_shared;
#include scripts\shared\util_shared;
#include scripts\zm\_zm_bgb;
#include scripts\zm\_zm_powerups;
#include scripts\zm\_zm_score;
#include scripts\zm\_zm_utility;

#namespace namespace_98efd7b6;

/*
	Name: function___init__sytem__
	Namespace: namespace_98efd7b6
	Checksum: 0x424F4353
	Offset: 0x1C0
	Size: 0x38
	Parameters: 0
	Flags: AutoExec
	Line Number: 22
*/
function autoexec function___init__sytem__()
{
	namespace_system::function_register("zm_bgb_round_robbin", &function___init__, undefined, "bgb");
}

/*
	Name: function___init__
	Namespace: namespace_98efd7b6
	Checksum: 0x424F4353
	Offset: 0x200
	Size: 0x20
	Parameters: 0
	Flags: None
	Line Number: 37
*/
function function___init__()
{
	if(!(isdefined(level.var_bgb_in_use) && level.var_bgb_in_use))
	{
		return;
		return;
	}
	ERROR: Bad function call
}

/*
	Name: function_validation
	Namespace: namespace_98efd7b6
	Checksum: 0x424F4353
	Offset: 0x228
	Size: 0xB8
	Parameters: 0
	Flags: None
	Line Number: 57
*/
function function_validation()
{
	if(!level namespace_flag::function_get("spawn_zombies"))
	{
		return 0;
	}
	var_zombies = function_GetAITeamArray(level.var_zombie_team);
	if(!isdefined(var_zombies) || var_zombies.size < 1)
	{
		return 0;
	}
	if(isdefined(level.var_35efa94c))
	{
		if(![[level.var_35efa94c]]())
		{
			return 0;
		}
	}
	if(isdefined(level.var_dfd95560) && level.var_dfd95560)
	{
		return 0;
	}
	return 1;
}

/*
	Name: function_activation
	Namespace: namespace_98efd7b6
	Checksum: 0x424F4353
	Offset: 0x2E8
	Size: 0x108
	Parameters: 0
	Flags: None
	Line Number: 92
*/
function function_activation()
{
	level.var_dfd95560 = 1;
	function_8824774d(level.var_round_number + 1);
	foreach(var_player in level.var_players)
	{
		if(namespace_zm_utility::function_is_player_valid(var_player))
		{
			var_multiplier = namespace_zm_score::function_get_points_multiplier(var_player);
			var_player namespace_zm_score::function_add_to_player_score(var_multiplier * 1600);
		}
	}
}

/*
	Name: function_b10a9b0c
	Namespace: namespace_98efd7b6
	Checksum: 0x424F4353
	Offset: 0x3F8
	Size: 0x88
	Parameters: 1
	Flags: None
	Line Number: 116
*/
function function_b10a9b0c(var_zombie)
{
	if(!isdefined(var_zombie))
	{
		return 0;
	}
	if(isdefined(var_zombie.var_ignore_round_robbin_death) && var_zombie.var_ignore_round_robbin_death || (isdefined(var_zombie.var_marked_for_death) && var_zombie.var_marked_for_death) || namespace_zm_utility::function_is_magic_bullet_shield_enabled(var_zombie))
	{
		return 0;
	}
	return 1;
	ERROR: Bad function call
}

/*
	Name: function_8824774d
	Namespace: namespace_98efd7b6
	Checksum: 0x424F4353
	Offset: 0x488
	Size: 0x2E2
	Parameters: 1
	Flags: None
	Line Number: 140
*/
function function_8824774d(var_target_round)
{
	if(var_target_round < 1)
	{
		var_target_round = 1;
	}
	level.var_zombie_total = 0;
	namespace_zombie_utility::function_ai_calculate_health(var_target_round);
	level.var_round_number = var_target_round - 1;
	level notify("hash_kill_round");
	function_playsoundatposition("zmb_bgb_round_robbin", (0, 0, 0));
	wait(0.1);
	var_zombies = function_GetAITeamArray(level.var_zombie_team);
	for(var_i = 0; var_i < var_zombies.size; var_i++)
	{
		if(isdefined(var_zombies[var_i].var_ignore_round_robbin_death) && var_zombies[var_i].var_ignore_round_robbin_death)
		{
			function_ArrayRemoveValue(var_zombies, var_zombies[var_i]);
		}
	}
	if(isdefined(var_zombies))
	{
		var_e_last = undefined;
		foreach(var_zombie in var_zombies)
		{
			if(function_b10a9b0c(var_zombie))
			{
				var_e_last = var_zombie;
			}
		}
		if(isdefined(var_e_last))
		{
			level.var_last_ai_origin = var_e_last.var_origin;
			level notify("hash_last_ai_down", var_e_last);
		}
	}
	namespace_util::function_wait_network_frame();
	if(isdefined(var_zombies))
	{
		foreach(var_zombie in var_zombies)
		{
			if(!function_b10a9b0c(var_zombie))
			{
				continue;
			}
			var_zombie function_DoDamage(var_zombie.var_health + 666, var_zombie.var_origin);
		}
	}
	level.var_dfd95560 = undefined;
}

