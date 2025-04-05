#include scripts\codescripts\struct;
#include scripts\shared\ai\zombie_death;
#include scripts\shared\clientfield_shared;
#include scripts\shared\system_shared;
#include scripts\shared\util_shared;
#include scripts\zm\_zm_bgb;
#include scripts\zm\_zm_pers_upgrades_functions;
#include scripts\zm\_zm_powerups;
#include scripts\zm\_zm_score;
#include scripts\zm\_zm_spawner;
#include scripts\zm\_zm_utility;

#namespace namespace_zm_powerup_double_points;

/*
	Name: function___init__sytem__
	Namespace: namespace_zm_powerup_double_points
	Checksum: 0x424F4353
	Offset: 0x2F8
	Size: 0x38
	Parameters: 0
	Flags: AutoExec
	Line Number: 24
*/
function autoexec function___init__sytem__()
{
	namespace_system::function_register("zm_powerup_double_points", &function___init__, undefined, undefined);
}

/*
	Name: function___init__
	Namespace: namespace_zm_powerup_double_points
	Checksum: 0x424F4353
	Offset: 0x338
	Size: 0xF8
	Parameters: 0
	Flags: None
	Line Number: 39
*/
function function___init__()
{
	namespace_zm_powerups::function_register_powerup("double_points", &function_grab_double_points);
	if(function_ToLower(function_GetDvarString("g_gametype")) != "zcleansed")
	{
		namespace_zm_powerups::function_add_zombie_powerup("double_points", "p7_zm_power_up_double_points", &"ZOMBIE_POWERUP_DOUBLE_POINTS", &function_25ec3c2b, 0, 0, 0, undefined, "powerup_double_points", "zombie_powerup_double_points_time", "zombie_powerup_double_points_on");
	}
	if(!isdefined(level.var_147d7517))
	{
		level.var_147d7517 = [];
	}
	level.var_147d7517["double_points"] = 1;
	level.var_e0a14cc9 = 0;
}

/*
	Name: function_25ec3c2b
	Namespace: namespace_zm_powerup_double_points
	Checksum: 0x424F4353
	Offset: 0x438
	Size: 0x38
	Parameters: 0
	Flags: None
	Line Number: 64
*/
function function_25ec3c2b()
{
	if(!(isdefined(level.var_147d7517["double_points"]) && level.var_147d7517["double_points"]))
	{
		return 0;
	}
	return 1;
}

/*
	Name: function_grab_double_points
	Namespace: namespace_zm_powerup_double_points
	Checksum: 0x424F4353
	Offset: 0x478
	Size: 0x48
	Parameters: 1
	Flags: None
	Line Number: 83
*/
function function_grab_double_points(var_player)
{
	level thread function_double_points_powerup(self, var_player);
	var_player thread namespace_zm_powerups::function_powerup_vo("double_points");
	return;
	ERROR: Exception occured: Stack empty.
}

/*
	Name: function_double_points_powerup
	Namespace: namespace_zm_powerup_double_points
	Checksum: 0x424F4353
	Offset: 0x4C8
	Size: 0x2C6
	Parameters: 2
	Flags: None
	Line Number: 101
*/
function function_double_points_powerup(var_drop_item, var_player)
{
	level notify("powerup points scaled_" + var_player.var_team);
	level endon("powerup points scaled_" + var_player.var_team);
	var_team = var_player.var_team;
	level thread namespace_zm_powerups::function_show_on_hud(var_team, "double_points");
	if(isdefined(level.var_pers_upgrade_double_points) && level.var_pers_upgrade_double_points)
	{
		var_player thread namespace_zm_pers_upgrades_functions::function_pers_upgrade_double_points_pickup_start();
	}
	if(isdefined(level.var_current_game_module) && level.var_current_game_module == 2)
	{
		if(isdefined(var_player.var__race_team))
		{
			if(var_player.var__race_team == 1)
			{
				level.var__race_team_double_points = 1;
			}
			else
			{
				level.var__race_team_double_points = 2;
			}
		}
	}
	level.var_zombie_vars[var_team]["zombie_point_scalar"] = 2;
	level.var_e0a14cc9 = 1;
	var_players = function_GetPlayers();
	for(var_player_index = 0; var_player_index < var_players.size; var_player_index++)
	{
		if(var_team == var_players[var_player_index].var_team)
		{
			var_players[var_player_index] namespace_clientfield::function_set_player_uimodel("hudItems.doublePointsActive", 1);
		}
	}
	var_n_wait = 30;
	if(namespace_bgb::function_is_team_enabled("zm_bgb_temporal_gift"))
	{
		var_n_wait = var_n_wait + 30;
	}
	wait(var_n_wait);
	level.var_zombie_vars[var_team]["zombie_point_scalar"] = 1;
	level.var_e0a14cc9 = 0;
	level.var__race_team_double_points = undefined;
	var_players = function_GetPlayers();
	for(var_player_index = 0; var_player_index < var_players.size; var_player_index++)
	{
		if(var_team == var_players[var_player_index].var_team)
		{
			var_players[var_player_index] namespace_clientfield::function_set_player_uimodel("hudItems.doublePointsActive", 0);
		}
	}
}

