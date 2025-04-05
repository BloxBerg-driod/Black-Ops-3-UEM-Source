#include scripts\codescripts\struct;
#include scripts\shared\ai\systems\gib;
#include scripts\shared\ai\zombie_death;
#include scripts\shared\ai\zombie_utility;
#include scripts\shared\clientfield_shared;
#include scripts\shared\flag_shared;
#include scripts\shared\lui_shared;
#include scripts\shared\system_shared;
#include scripts\shared\util_shared;
#include scripts\zm\_zm_daily_challenges;
#include scripts\zm\_zm_powerups;
#include scripts\zm\_zm_score;
#include scripts\zm\_zm_spawner;
#include scripts\zm\_zm_utility;

#namespace namespace_zm_powerup_nuke;

/*
	Name: function___init__sytem__
	Namespace: namespace_zm_powerup_nuke
	Checksum: 0x424F4353
	Offset: 0x2C8
	Size: 0x38
	Parameters: 0
	Flags: AutoExec
	Line Number: 27
*/
function autoexec function___init__sytem__()
{
	namespace_system::function_register("zm_powerup_nuke", &function___init__, undefined, undefined);
	return;
	ERROR: Exception occured: Stack empty.
}

/*
	Name: function___init__
	Namespace: namespace_zm_powerup_nuke
	Checksum: 0x424F4353
	Offset: 0x308
	Size: 0xE8
	Parameters: 0
	Flags: None
	Line Number: 44
*/
function function___init__()
{
	namespace_zm_powerups::function_register_powerup("nuke", &function_grab_nuke);
	namespace_clientfield::function_register("actor", "zm_nuked", 1000, 1, "counter");
	namespace_clientfield::function_register("vehicle", "zm_nuked", 1000, 1, "counter");
	namespace_zm_powerups::function_add_zombie_powerup("nuke", "p7_zm_power_up_nuke", &"ZOMBIE_POWERUP_NUKE", &function_5ea3cd77, 0, 0, 0);
	level.var_147d7517["nuke"] = 1;
}

/*
	Name: function_5ea3cd77
	Namespace: namespace_zm_powerup_nuke
	Checksum: 0x424F4353
	Offset: 0x3F8
	Size: 0x38
	Parameters: 0
	Flags: None
	Line Number: 63
*/
function function_5ea3cd77()
{
	if(!(isdefined(level.var_147d7517["nuke"]) && level.var_147d7517["nuke"]))
	{
		return 0;
	}
	return 1;
}

/*
	Name: function_grab_nuke
	Namespace: namespace_zm_powerup_nuke
	Checksum: 0x424F4353
	Offset: 0x438
	Size: 0xA8
	Parameters: 1
	Flags: None
	Line Number: 82
*/
function function_grab_nuke(var_player)
{
	level thread function_nuke_powerup(self, var_player.var_team);
	var_player thread namespace_zm_powerups::function_powerup_vo("nuke");
	var_zombies = function_GetAITeamArray(level.var_zombie_team);
	var_player.var_zombie_nuked = function_ArraySort(var_zombies, self.var_origin);
	var_player notify("hash_nuke_triggered");
}

/*
	Name: function_nuke_powerup
	Namespace: namespace_zm_powerup_nuke
	Checksum: 0x424F4353
	Offset: 0x4E8
	Size: 0x4A0
	Parameters: 2
	Flags: None
	Line Number: 101
*/
function function_nuke_powerup(var_drop_item, var_player_team)
{
	level thread function_nuke_delay_spawning(3);
	var_location = var_drop_item.var_origin;
	if(isdefined(var_drop_item.var_FX))
	{
		function_playFX(var_drop_item.var_FX, var_location);
	}
	level thread function_nuke_flash(var_player_team);
	wait(0.5);
	var_zombies = function_GetAITeamArray(level.var_zombie_team);
	var_zombies = function_ArraySort(var_zombies, var_location);
	var_zombies_nuked = [];
	for(var_i = 0; var_i < var_zombies.size; var_i++)
	{
		if(isdefined(var_zombies[var_i].var_ignore_nuke) && var_zombies[var_i].var_ignore_nuke)
		{
			continue;
		}
		if(isdefined(var_zombies[var_i].var_marked_for_death) && var_zombies[var_i].var_marked_for_death)
		{
			continue;
		}
		if(isdefined(var_zombies[var_i].var_nuke_damage_func))
		{
			var_zombies[var_i] thread [[var_zombies[var_i].var_nuke_damage_func]]();
			continue;
		}
		if(namespace_zm_utility::function_is_magic_bullet_shield_enabled(var_zombies[var_i]))
		{
			continue;
		}
		var_zombies[var_i].var_marked_for_death = 1;
		if(!(isdefined(var_zombies[var_i].var_nuked) && var_zombies[var_i].var_nuked) && !namespace_zm_utility::function_is_magic_bullet_shield_enabled(var_zombies[var_i]))
		{
			var_zombies[var_i].var_nuked = 1;
			var_zombies_nuked[var_zombies_nuked.size] = var_zombies[var_i];
			var_zombies[var_i] namespace_clientfield::function_increment("zm_nuked");
		}
	}
	var_29ed7b02 = 0;
	for(var_i = 0; var_i < var_zombies_nuked.size; var_i++)
	{
		var_29ed7b02++;
		if(!isdefined(var_zombies_nuked[var_i]))
		{
			continue;
		}
		if(namespace_zm_utility::function_is_magic_bullet_shield_enabled(var_zombies_nuked[var_i]))
		{
			continue;
		}
		if(!(isdefined(var_zombies_nuked[var_i].var_isdog) && var_zombies_nuked[var_i].var_isdog))
		{
			if(!(isdefined(var_zombies_nuked[var_i].var_no_gib) && var_zombies_nuked[var_i].var_no_gib))
			{
				var_zombies_nuked[var_i] namespace_zombie_utility::function_zombie_head_gib();
			}
			var_zombies_nuked[var_i] function_playsound("evt_nuked");
		}
		var_zombies_nuked[var_i] function_DoDamage(var_zombies_nuked[var_i].var_health + 666, var_zombies_nuked[var_i].var_origin);
		level thread namespace_zm_daily_challenges::function_increment_nuked_zombie();
	}
	level notify("hash_nuke_complete");
	var_players = function_GetPlayers(var_player_team);
	for(var_i = 0; var_i < var_players.size; var_i++)
	{
		var_players[var_i] namespace_zm_score::function_player_add_points("nuke_powerup", 400 + var_29ed7b02 * 50);
	}
}

/*
	Name: function_nuke_flash
	Namespace: namespace_zm_powerup_nuke
	Checksum: 0x424F4353
	Offset: 0x990
	Size: 0xB0
	Parameters: 1
	Flags: None
	Line Number: 182
*/
function function_nuke_flash(var_team)
{
	if(isdefined(var_team))
	{
		function_GetPlayers()[0] function_playsoundtoteam("evt_nuke_flash", var_team);
	}
	else
	{
		function_GetPlayers()[0] function_playsound("evt_nuke_flash");
	}
	namespace_LUI::function_screen_flash(0.2, 0.5, 1, 0.8, "white");
}

/*
	Name: function_nuke_delay_spawning
	Namespace: namespace_zm_powerup_nuke
	Checksum: 0x424F4353
	Offset: 0xA48
	Size: 0xC4
	Parameters: 1
	Flags: None
	Line Number: 205
*/
function function_nuke_delay_spawning(var_n_spawn_delay)
{
	level endon("hash_disable_nuke_delay_spawning");
	if(isdefined(level.var_disable_nuke_delay_spawning) && level.var_disable_nuke_delay_spawning)
	{
		return;
	}
	var_b_spawn_zombies_before_nuke = level namespace_flag::function_get("spawn_zombies");
	level namespace_flag::function_clear("spawn_zombies");
	level waittill("hash_nuke_complete");
	if(isdefined(level.var_disable_nuke_delay_spawning) && level.var_disable_nuke_delay_spawning)
	{
		return;
	}
	wait(var_n_spawn_delay);
	if(var_b_spawn_zombies_before_nuke)
	{
		level namespace_flag::function_set("spawn_zombies");
	}
}

