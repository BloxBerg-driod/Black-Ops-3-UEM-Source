#include scripts\codescripts\struct;
#include scripts\shared\ai\zombie_death;
#include scripts\shared\array_shared;
#include scripts\shared\clientfield_shared;
#include scripts\shared\flag_shared;
#include scripts\shared\flagsys_shared;
#include scripts\shared\laststand_shared;
#include scripts\shared\system_shared;
#include scripts\shared\util_shared;
#include scripts\zm\_zm_blockers;
#include scripts\zm\_zm_devgui;
#include scripts\zm\_zm_melee_weapon;
#include scripts\zm\_zm_pers_upgrades;
#include scripts\zm\_zm_pers_upgrades_functions;
#include scripts\zm\_zm_powerups;
#include scripts\zm\_zm_score;
#include scripts\zm\_zm_spawner;
#include scripts\zm\_zm_utility;
#include scripts\zm\_zm_weapons;

#namespace namespace_zm_powerup_ww_grenade;

/*
	Name: function___init__sytem__
	Namespace: namespace_zm_powerup_ww_grenade
	Checksum: 0x424F4353
	Offset: 0x360
	Size: 0x38
	Parameters: 0
	Flags: AutoExec
	Line Number: 32
*/
function autoexec function___init__sytem__()
{
	namespace_system::function_register("zm_powerup_xp_drop", &function___init__, undefined, undefined);
}

/*
	Name: function___init__
	Namespace: namespace_zm_powerup_ww_grenade
	Checksum: 0x424F4353
	Offset: 0x3A0
	Size: 0xA8
	Parameters: 0
	Flags: None
	Line Number: 47
*/
function function___init__()
{
	namespace_zm_powerups::function_register_powerup("xp_drop", &function_63efa79e);
	namespace_zm_powerups::function_add_zombie_powerup("xp_drop", "powerup_xp", &"POWERUP_XP_DROP", &function_a61c5cdc, 1, 0, 0);
	if(!isdefined(level.var_147d7517))
	{
		level.var_147d7517 = [];
	}
	level.var_999cc9cf = 0;
	level.var_147d7517["xp_drop"] = 1;
}

/*
	Name: function_a61c5cdc
	Namespace: namespace_zm_powerup_ww_grenade
	Checksum: 0x424F4353
	Offset: 0x450
	Size: 0x108
	Parameters: 0
	Flags: None
	Line Number: 69
*/
function function_a61c5cdc()
{
	foreach(var_player in function_GetPlayers())
	{
		if(var_player.var_bgb == "zm_bgb_power_vacuum")
		{
			level.var_999cc9cf = 1;
			continue;
		}
		level.var_999cc9cf = 0;
	}
	if(!(isdefined(level.var_147d7517["xp_drop"]) && level.var_147d7517["xp_drop"]) || (isdefined(level.var_999cc9cf) && level.var_999cc9cf))
	{
		return 0;
	}
	return 1;
}

/*
	Name: function_63efa79e
	Namespace: namespace_zm_powerup_ww_grenade
	Checksum: 0x424F4353
	Offset: 0x560
	Size: 0x4C
	Parameters: 1
	Flags: None
	Line Number: 97
*/
function function_63efa79e(var_player)
{
	var_player function_LUINotifyEvent(&"zombie_notification", 1, &"ZM_MINECRAFT_POWERUP_XP_DROP");
	var_player notify("hash_79ef118b", "powerup_xp_drop", undefined);
}

