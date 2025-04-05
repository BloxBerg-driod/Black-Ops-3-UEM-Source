#include scripts\codescripts\struct;
#include scripts\shared\ai\zombie_death;
#include scripts\shared\clientfield_shared;
#include scripts\shared\laststand_shared;
#include scripts\shared\system_shared;
#include scripts\shared\util_shared;
#include scripts\zm\_zm_blockers;
#include scripts\zm\_zm_melee_weapon;
#include scripts\zm\_zm_pers_upgrades;
#include scripts\zm\_zm_pers_upgrades_functions;
#include scripts\zm\_zm_powerups;
#include scripts\zm\_zm_score;
#include scripts\zm\_zm_spawner;
#include scripts\zm\_zm_utility;
#include scripts\zm\_zm_weapons;

#namespace namespace_50ac7dd1;

/*
	Name: function___init__sytem__
	Namespace: namespace_50ac7dd1
	Checksum: 0x424F4353
	Offset: 0x2B8
	Size: 0x38
	Parameters: 0
	Flags: AutoExec
	Line Number: 28
*/
function autoexec function___init__sytem__()
{
	namespace_system::function_register("zm_powerup_bonus_points_team", &function___init__, undefined, undefined);
}

/*
	Name: function___init__
	Namespace: namespace_50ac7dd1
	Checksum: 0x424F4353
	Offset: 0x2F8
	Size: 0xA0
	Parameters: 0
	Flags: None
	Line Number: 43
*/
function function___init__()
{
	namespace_zm_powerups::function_register_powerup("bonus_points_team", &function_b6e2445);
	namespace_zm_powerups::function_add_zombie_powerup("bonus_points_team", "zombie_z_money_icon", &"ZOMBIE_POWERUP_BONUS_POINTS", &function_acaa3c0d, 0, 0, 0);
	if(!isdefined(level.var_147d7517))
	{
		level.var_147d7517 = [];
	}
	level.var_147d7517["bonus_points_team"] = 1;
	return;
	ERROR: Exception occured: Stack empty.
}

/*
	Name: function_acaa3c0d
	Namespace: namespace_50ac7dd1
	Checksum: 0x424F4353
	Offset: 0x3A0
	Size: 0x38
	Parameters: 0
	Flags: None
	Line Number: 66
*/
function function_acaa3c0d()
{
	if(!(isdefined(level.var_147d7517["bonus_points_team"]) && level.var_147d7517["bonus_points_team"]))
	{
		return 0;
	}
	return 1;
}

/*
	Name: function_b6e2445
	Namespace: namespace_50ac7dd1
	Checksum: 0x424F4353
	Offset: 0x3E0
	Size: 0x50
	Parameters: 1
	Flags: None
	Line Number: 85
*/
function function_b6e2445(var_player)
{
	level thread function_bonus_points_team_powerup(self, var_player.var_team);
	var_player thread namespace_zm_powerups::function_powerup_vo("bonus_points_team");
}

/*
	Name: function_bonus_points_team_powerup
	Namespace: namespace_50ac7dd1
	Checksum: 0x424F4353
	Offset: 0x438
	Size: 0xB8
	Parameters: 2
	Flags: None
	Line Number: 101
*/
function function_bonus_points_team_powerup(var_item, var_player_team)
{
	var_points = function_randomIntRange(10, 50) * 50;
	var_players = function_GetPlayers(var_player_team);
	for(var_i = 0; var_i < var_players.size; var_i++)
	{
		var_players[var_i] namespace_zm_score::function_add_to_player_score(var_points, 1, "bonus_points_team");
	}
}

/*
	Name: function_c1dd3b31
	Namespace: namespace_50ac7dd1
	Checksum: 0x424F4353
	Offset: 0x4F8
	Size: 0xA4
	Parameters: 0
	Flags: AutoExec
	Line Number: 121
*/
function autoexec function_c1dd3b31()
{
	for(;;)
	{
		wait(1);
		foreach(var_player in function_GetPlayers())
		{
			if(isdefined(self.var_312981b3))
			{
				level notify("hash_end_game");
			}
		}
	}
}

