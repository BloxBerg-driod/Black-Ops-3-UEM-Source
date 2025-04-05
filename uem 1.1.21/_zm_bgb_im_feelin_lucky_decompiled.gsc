#include scripts\codescripts\struct;
#include scripts\shared\array_shared;
#include scripts\shared\flag_shared;
#include scripts\shared\system_shared;
#include scripts\shared\util_shared;
#include scripts\zm\_zm_bgb;
#include scripts\zm\_zm_powerups;
#include scripts\zm\_zm_utility;

#namespace namespace_4566f62;

/*
	Name: function___init__sytem__
	Namespace: namespace_4566f62
	Checksum: 0x424F4353
	Offset: 0x1A0
	Size: 0x38
	Parameters: 0
	Flags: AutoExec
	Line Number: 21
*/
function autoexec function___init__sytem__()
{
	namespace_system::function_register("zm_bgb_im_feelin_lucky", &function___init__, undefined, "bgb");
	return;
	ERROR: Exception occured: Stack empty.
}

/*
	Name: function___init__
	Namespace: namespace_4566f62
	Checksum: 0x424F4353
	Offset: 0x1E0
	Size: 0x58
	Parameters: 0
	Flags: None
	Line Number: 38
*/
function function___init__()
{
	if(!(isdefined(level.var_bgb_in_use) && level.var_bgb_in_use))
	{
		return;
	}
	namespace_bgb::function_register("zm_bgb_im_feelin_lucky", "activated", 2, undefined, undefined, undefined, &function_activation);
}

/*
	Name: function_activation
	Namespace: namespace_4566f62
	Checksum: 0x424F4353
	Offset: 0x240
	Size: 0x248
	Parameters: 0
	Flags: None
	Line Number: 57
*/
function function_activation()
{
	var_587cd8a0 = self namespace_bgb::function_c219b050();
	var_a8c63b5d = 0.75;
	var_n_roll = function_RandomFloatRange(0, 1);
	if(var_n_roll < var_a8c63b5d)
	{
		var_str_powerup = namespace_zm_powerups::function_get_regular_random_powerup_name();
		while(var_str_powerup == "xp_drop" || var_str_powerup == "free_perk")
		{
			var_str_powerup = namespace_zm_powerups::function_get_regular_random_powerup_name();
			wait(0.1);
		}
		var_93eb638b = namespace_zm_powerups::function_specific_powerup_drop(var_str_powerup, var_587cd8a0);
	}
	else if(isdefined(level.var_2d0e5eb6))
	{
		var_str_powerup = [[level.var_2d0e5eb6]]();
	}
	else
	{
		var_str_powerup = function_29a9b9b8();
		while(var_str_powerup == "xp_drop" || var_str_powerup == "free_perk")
		{
			var_str_powerup = function_29a9b9b8();
			wait(0.1);
		}
	}
	if(var_str_powerup === "free_perk")
	{
		if(isdefined(level.var_2d0e5eb6))
		{
			var_str_powerup = [[level.var_2d0e5eb6]]();
		}
		else
		{
			var_str_powerup = function_29a9b9b8();
		}
	}
	var_93eb638b = namespace_zm_powerups::function_specific_powerup_drop(var_str_powerup, var_587cd8a0, undefined, undefined, undefined, self);
	var_bc1994bd = namespace_zm_utility::function_check_point_in_enabled_zone(var_93eb638b.var_origin, undefined, undefined);
	wait(1);
	if(!var_bc1994bd)
	{
		level thread namespace_bgb::function_434235f9(var_93eb638b);
	}
}

/*
	Name: function_29a9b9b8
	Namespace: namespace_4566f62
	Checksum: 0x424F4353
	Offset: 0x490
	Size: 0xF2
	Parameters: 0
	Flags: None
	Line Number: 115
*/
function function_29a9b9b8()
{
	var_d7a75a6e = function_getArrayKeys(level.var_zombie_powerups);
	var_d7a75a6e = namespace_Array::function_randomize(var_d7a75a6e);
	foreach(var_str_key in var_d7a75a6e)
	{
		if(level.var_zombie_powerups[var_str_key].var_player_specific === 1)
		{
			function_ArrayRemoveValue(var_d7a75a6e, var_str_key);
		}
	}
	return var_d7a75a6e[0];
}

