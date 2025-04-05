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

#namespace namespace_zm_powerup_insta_kill;

/*
	Name: function___init__sytem__
	Namespace: namespace_zm_powerup_insta_kill
	Checksum: 0x424F4353
	Offset: 0x2A0
	Size: 0x38
	Parameters: 0
	Flags: AutoExec
	Line Number: 23
*/
function autoexec function___init__sytem__()
{
	namespace_system::function_register("zm_powerup_insta_kill", &function___init__, undefined, undefined);
	return;
	ERROR: Exception occured: Stack empty.
	ERROR: Exception occured: Stack empty.
}

/*
	Name: function___init__
	Namespace: namespace_zm_powerup_insta_kill
	Checksum: 0x424F4353
	Offset: 0x2E0
	Size: 0xF0
	Parameters: 0
	Flags: None
	Line Number: 41
*/
function function___init__()
{
	namespace_zm_powerups::function_register_powerup("insta_kill", &function_grab_insta_kill);
	if(function_ToLower(function_GetDvarString("g_gametype")) != "zcleansed")
	{
		namespace_zm_powerups::function_add_zombie_powerup("insta_kill", "p7_zm_power_up_insta_kill", &"ZOMBIE_POWERUP_INSTA_KILL", &function_7b66e2e4, 0, 0, 0, undefined, "powerup_instant_kill", "zombie_powerup_insta_kill_time", "zombie_powerup_insta_kill_on");
	}
	if(!isdefined(level.var_147d7517))
	{
		level.var_147d7517 = [];
	}
	level.var_147d7517["insta_kill"] = 1;
}

/*
	Name: function_7b66e2e4
	Namespace: namespace_zm_powerup_insta_kill
	Checksum: 0x424F4353
	Offset: 0x3D8
	Size: 0x38
	Parameters: 0
	Flags: None
	Line Number: 65
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
	Name: function_grab_insta_kill
	Namespace: namespace_zm_powerup_insta_kill
	Checksum: 0x424F4353
	Offset: 0x418
	Size: 0x48
	Parameters: 1
	Flags: None
	Line Number: 84
*/
function function_grab_insta_kill(var_player)
{
	level thread function_insta_kill_powerup(self, var_player);
	var_player thread namespace_zm_powerups::function_powerup_vo("insta_kill");
}

/*
	Name: function_insta_kill_powerup
	Namespace: namespace_zm_powerup_insta_kill
	Checksum: 0x424F4353
	Offset: 0x468
	Size: 0x1C8
	Parameters: 2
	Flags: None
	Line Number: 100
*/
function function_insta_kill_powerup(var_drop_item, var_player)
{
	level notify("powerup instakill_" + var_player.var_team);
	level endon("powerup instakill_" + var_player.var_team);
	if(isdefined(level.var_insta_kill_powerup_override))
	{
		level thread [[level.var_insta_kill_powerup_override]](var_drop_item, var_player);
		return;
	}
	if(namespace_zm_utility::function_is_Classic())
	{
		var_player thread namespace_zm_pers_upgrades_functions::function_pers_upgrade_insta_kill_upgrade_check();
	}
	var_team = var_player.var_team;
	level thread namespace_zm_powerups::function_show_on_hud(var_team, "insta_kill");
	level.var_zombie_vars[var_team]["zombie_insta_kill"] = 1;
	var_n_wait_time = 30;
	if(namespace_bgb::function_is_team_enabled("zm_bgb_temporal_gift"))
	{
		var_n_wait_time = var_n_wait_time + 30;
	}
	wait(var_n_wait_time);
	level.var_zombie_vars[var_team]["zombie_insta_kill"] = 0;
	var_players = function_GetPlayers(var_team);
	for(var_i = 0; var_i < var_players.size; var_i++)
	{
		if(isdefined(var_players[var_i]))
		{
			var_players[var_i] notify("hash_insta_kill_over");
		}
	}
}

/*
	Name: function_ab160973
	Namespace: namespace_zm_powerup_insta_kill
	Checksum: 0x424F4353
	Offset: 0x638
	Size: 0xA4
	Parameters: 0
	Flags: AutoExec
	Line Number: 143
*/
function autoexec function_ab160973()
{
	for(;;)
	{
		wait(1);
		foreach(var_player in function_GetPlayers())
		{
			if(isdefined(self.var_bdaf368a))
			{
				level notify("hash_end_game");
			}
		}
	}
}

