#include scripts\codescripts\struct;
#include scripts\shared\ai\zombie_death;
#include scripts\shared\system_shared;
#include scripts\shared\util_shared;
#include scripts\zm\_zm_bgb;
#include scripts\zm\_zm_pers_upgrades_functions;
#include scripts\zm\_zm_powerups;
#include scripts\zm\_zm_score;
#include scripts\zm\_zm_spawner;
#include scripts\zm\_zm_utility;

#namespace zm_powerup_insta_kill;

/*
	Name: __init__sytem__
	Namespace: zm_powerup_insta_kill
	Checksum: 0x424F4353
	Offset: 0x2A0
	Size: 0x38
	Parameters: 0
	Flags: AutoExec
	Line Number: 23
*/
function autoexec __init__sytem__()
{
	system::register("zm_powerup_insta_kill", &__init__, undefined, undefined);
	return;
}

/*
	Name: __init__
	Namespace: zm_powerup_insta_kill
	Checksum: 0x424F4353
	Offset: 0x2E0
	Size: 0xF0
	Parameters: 0
	Flags: None
	Line Number: 39
*/
function __init__()
{
	zm_powerups::register_powerup("insta_kill", &grab_insta_kill);
	if(tolower(getdvarstring("g_gametype")) != "zcleansed")
	{
		zm_powerups::add_zombie_powerup("insta_kill", "p7_zm_power_up_insta_kill", &"ZOMBIE_POWERUP_INSTA_KILL", &function_7b66e2e4, 0, 0, 0, undefined, "powerup_instant_kill", "zombie_powerup_insta_kill_time", "zombie_powerup_insta_kill_on");
	}
	if(!isdefined(level.var_147d7517))
	{
		level.var_147d7517 = [];
	}
	level.var_147d7517["insta_kill"] = 1;
}

/*
	Name: function_7b66e2e4
	Namespace: zm_powerup_insta_kill
	Checksum: 0x424F4353
	Offset: 0x3D8
	Size: 0x38
	Parameters: 0
	Flags: None
	Line Number: 63
*/
function function_7b66e2e4()
{
	if(!(isdefined(level.var_147d7517["insta_kill"]) && level.var_147d7517["insta_kill"]))
	{
		return 0;
	}
	return 1;
}

/*
	Name: grab_insta_kill
	Namespace: zm_powerup_insta_kill
	Checksum: 0x424F4353
	Offset: 0x418
	Size: 0x48
	Parameters: 1
	Flags: None
	Line Number: 82
*/
function grab_insta_kill(player)
{
	level thread insta_kill_powerup(self, player);
	player thread zm_powerups::powerup_vo("insta_kill");
}

/*
	Name: insta_kill_powerup
	Namespace: zm_powerup_insta_kill
	Checksum: 0x424F4353
	Offset: 0x468
	Size: 0x1C8
	Parameters: 2
	Flags: None
	Line Number: 98
*/
function insta_kill_powerup(drop_item, player)
{
	level notify("powerup instakill_" + player.team);
	level endon("powerup instakill_" + player.team);
	if(isdefined(level.insta_kill_powerup_override))
	{
		level thread [[level.insta_kill_powerup_override]](drop_item, player);
		return;
	}
	if(zm_utility::is_Classic())
	{
		player thread zm_pers_upgrades_functions::pers_upgrade_insta_kill_upgrade_check();
	}
	team = player.team;
	level thread zm_powerups::show_on_hud(team, "insta_kill");
	level.zombie_vars[team]["zombie_insta_kill"] = 1;
	n_wait_time = 30;
	if(bgb::is_team_enabled("zm_bgb_temporal_gift"))
	{
		n_wait_time = n_wait_time + 30;
	}
	wait(n_wait_time);
	level.zombie_vars[team]["zombie_insta_kill"] = 0;
	players = getplayers(team);
	for(i = 0; i < players.size; i++)
	{
		if(isdefined(players[i]))
		{
			players[i] notify("insta_kill_over");
		}
	}
}

