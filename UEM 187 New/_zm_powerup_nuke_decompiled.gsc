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

#namespace zm_powerup_nuke;

/*
	Name: __init__sytem__
	Namespace: zm_powerup_nuke
	Checksum: 0x424F4353
	Offset: 0x2C8
	Size: 0x38
	Parameters: 0
	Flags: AutoExec
	Line Number: 27
*/
function autoexec __init__sytem__()
{
	system::register("zm_powerup_nuke", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: zm_powerup_nuke
	Checksum: 0x424F4353
	Offset: 0x308
	Size: 0xE8
	Parameters: 0
	Flags: None
	Line Number: 42
*/
function __init__()
{
	zm_powerups::register_powerup("nuke", &grab_nuke);
	clientfield::register("actor", "zm_nuked", 1000, 1, "counter");
	clientfield::register("vehicle", "zm_nuked", 1000, 1, "counter");
	zm_powerups::add_zombie_powerup("nuke", "p7_zm_power_up_nuke", &"ZOMBIE_POWERUP_NUKE", &function_5ea3cd77, 0, 0, 0);
	level.var_147d7517["nuke"] = 1;
}

/*
	Name: function_5ea3cd77
	Namespace: zm_powerup_nuke
	Checksum: 0x424F4353
	Offset: 0x3F8
	Size: 0x38
	Parameters: 0
	Flags: None
	Line Number: 61
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
	Name: grab_nuke
	Namespace: zm_powerup_nuke
	Checksum: 0x424F4353
	Offset: 0x438
	Size: 0xA8
	Parameters: 1
	Flags: None
	Line Number: 80
*/
function grab_nuke(player)
{
	level thread nuke_powerup(self, player.team);
	player thread zm_powerups::powerup_vo("nuke");
	zombies = getaiteamarray(level.zombie_team);
	player.zombie_nuked = ArraySort(zombies, self.origin);
	player notify("nuke_triggered");
}

/*
	Name: nuke_powerup
	Namespace: zm_powerup_nuke
	Checksum: 0x424F4353
	Offset: 0x4E8
	Size: 0x4A0
	Parameters: 2
	Flags: None
	Line Number: 99
*/
function nuke_powerup(drop_item, player_team)
{
	level thread nuke_delay_spawning(3);
	location = drop_item.origin;
	if(isdefined(drop_item.fx))
	{
		playfx(drop_item.fx, location);
	}
	level thread nuke_flash(player_team);
	wait(0.5);
	zombies = getaiteamarray(level.zombie_team);
	zombies = ArraySort(zombies, location);
	zombies_nuked = [];
	for(i = 0; i < zombies.size; i++)
	{
		if(isdefined(zombies[i].ignore_nuke) && zombies[i].ignore_nuke)
		{
			continue;
		}
		if(isdefined(zombies[i].marked_for_death) && zombies[i].marked_for_death)
		{
			continue;
		}
		if(isdefined(zombies[i].nuke_damage_func))
		{
			zombies[i] thread [[zombies[i].nuke_damage_func]]();
			continue;
		}
		if(zm_utility::is_magic_bullet_shield_enabled(zombies[i]))
		{
			continue;
		}
		zombies[i].marked_for_death = 1;
		if(!(isdefined(zombies[i].nuked) && zombies[i].nuked) && !zm_utility::is_magic_bullet_shield_enabled(zombies[i]))
		{
			zombies[i].nuked = 1;
			zombies_nuked[zombies_nuked.size] = zombies[i];
			zombies[i] clientfield::increment("zm_nuked");
		}
	}
	var_29ed7b02 = 0;
	for(i = 0; i < zombies_nuked.size; i++)
	{
		var_29ed7b02++;
		if(!isdefined(zombies_nuked[i]))
		{
			continue;
		}
		if(zm_utility::is_magic_bullet_shield_enabled(zombies_nuked[i]))
		{
			continue;
		}
		if(!(isdefined(zombies_nuked[i].isdog) && zombies_nuked[i].isdog))
		{
			if(!(isdefined(zombies_nuked[i].no_gib) && zombies_nuked[i].no_gib))
			{
				zombies_nuked[i] zombie_utility::zombie_head_gib();
			}
			zombies_nuked[i] playsound("evt_nuked");
		}
		zombies_nuked[i] dodamage(zombies_nuked[i].health + 666, zombies_nuked[i].origin);
		level thread zm_daily_challenges::increment_nuked_zombie();
	}
	level notify("nuke_complete");
	players = getplayers(player_team);
	for(i = 0; i < players.size; i++)
	{
		players[i] zm_score::player_add_points("nuke_powerup", 400 + var_29ed7b02 * 50);
	}
}

/*
	Name: nuke_flash
	Namespace: zm_powerup_nuke
	Checksum: 0x424F4353
	Offset: 0x990
	Size: 0xB0
	Parameters: 1
	Flags: None
	Line Number: 180
*/
function nuke_flash(team)
{
	if(isdefined(team))
	{
		getplayers()[0] playsoundtoteam("evt_nuke_flash", team);
	}
	else
	{
		getplayers()[0] playsound("evt_nuke_flash");
	}
	lui::screen_flash(0.2, 0.5, 1, 0.8, "white");
	return;
	ERROR: Bad function call
}

/*
	Name: nuke_delay_spawning
	Namespace: zm_powerup_nuke
	Checksum: 0x424F4353
	Offset: 0xA48
	Size: 0xC4
	Parameters: 1
	Flags: None
	Line Number: 205
*/
function nuke_delay_spawning(n_spawn_delay)
{
	level endon("disable_nuke_delay_spawning");
	if(isdefined(level.disable_nuke_delay_spawning) && level.disable_nuke_delay_spawning)
	{
		return;
	}
	b_spawn_zombies_before_nuke = level flag::get("spawn_zombies");
	level flag::clear("spawn_zombies");
	level waittill("nuke_complete");
	if(isdefined(level.disable_nuke_delay_spawning) && level.disable_nuke_delay_spawning)
	{
		return;
	}
	wait(n_spawn_delay);
	if(b_spawn_zombies_before_nuke)
	{
		level flag::set("spawn_zombies");
	}
}

