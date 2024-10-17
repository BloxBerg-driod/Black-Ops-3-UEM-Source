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
	Name: __init__sytem__
	Namespace: namespace_50ac7dd1
	Checksum: 0x424F4353
	Offset: 0x2B8
	Size: 0x38
	Parameters: 0
	Flags: AutoExec
	Line Number: 28
*/
function autoexec __init__sytem__()
{
	system::register("zm_powerup_bonus_points_team", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: namespace_50ac7dd1
	Checksum: 0x424F4353
	Offset: 0x2F8
	Size: 0xA0
	Parameters: 0
	Flags: None
	Line Number: 43
*/
function __init__()
{
	zm_powerups::register_powerup("bonus_points_team", &function_b6e2445);
	zm_powerups::add_zombie_powerup("bonus_points_team", "zombie_z_money_icon", &"ZOMBIE_POWERUP_BONUS_POINTS", &function_acaa3c0d, 0, 0, 0);
	if(!isdefined(level.var_147d7517))
	{
		level.var_147d7517 = [];
	}
	level.var_147d7517["bonus_points_team"] = 1;
}

/*
	Name: function_acaa3c0d
	Namespace: namespace_50ac7dd1
	Checksum: 0x424F4353
	Offset: 0x3A0
	Size: 0x38
	Parameters: 0
	Flags: None
	Line Number: 64
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
	Line Number: 83
*/
function function_b6e2445(player)
{
	level thread bonus_points_team_powerup(self, player.team);
	player thread zm_powerups::powerup_vo("bonus_points_team");
}

/*
	Name: bonus_points_team_powerup
	Namespace: namespace_50ac7dd1
	Checksum: 0x424F4353
	Offset: 0x438
	Size: 0xB6
	Parameters: 2
	Flags: None
	Line Number: 99
*/
function bonus_points_team_powerup(item, player_team)
{
	points = randomintrange(10, 50) * 50;
	players = getplayers(player_team);
	for(i = 0; i < players.size; i++)
	{
		players[i] zm_score::add_to_player_score(points, 1, "bonus_points_team");
	}
}

