#include scripts\codescripts\struct;
#include scripts\shared\ai\zombie_death;
#include scripts\shared\callbacks_shared;
#include scripts\shared\clientfield_shared;
#include scripts\shared\laststand_shared;
#include scripts\shared\system_shared;
#include scripts\shared\util_shared;
#include scripts\zm\_zm;
#include scripts\zm\_zm_blockers;
#include scripts\zm\_zm_melee_weapon;
#include scripts\zm\_zm_pers_upgrades;
#include scripts\zm\_zm_pers_upgrades_functions;
#include scripts\zm\_zm_powerups;
#include scripts\zm\_zm_score;
#include scripts\zm\_zm_spawner;
#include scripts\zm\_zm_utility;
#include scripts\zm\_zm_weapons;

#namespace namespace_zm_powerup_weapon_minigun;

/*
	Name: function___init__sytem__
	Namespace: namespace_zm_powerup_weapon_minigun
	Checksum: 0x424F4353
	Offset: 0x3A0
	Size: 0x38
	Parameters: 0
	Flags: AutoExec
	Line Number: 30
*/
function autoexec function___init__sytem__()
{
	namespace_system::function_register("zm_powerup_minigun", &function___init__, undefined, undefined);
}

/*
	Name: function___init__
	Namespace: namespace_zm_powerup_weapon_minigun
	Checksum: 0x424F4353
	Offset: 0x3E0
	Size: 0x270
	Parameters: 0
	Flags: None
	Line Number: 45
*/
function function___init__()
{
	namespace_zm_powerups::function_register_powerup("minigun", &function_grab_minigun);
	namespace_zm_powerups::function_register_powerup_weapon("minigun", &function_minigun_countdown);
	namespace_zm_powerups::function_powerup_set_prevent_pick_up_if_drinking("minigun", 1);
	namespace_zm_powerups::function_set_weapon_ignore_max_ammo("minigun");
	if(function_ToLower(function_GetDvarString("g_gametype")) != "zcleansed")
	{
		switch(function_ToLower(function_GetDvarString("mapname")))
		{
			case "zm_consulate":
			case "zm_crazy_place":
			case "zm_miragenoah":
			case "zm_stairs_of_ammenu":
			{
				namespace_zm_powerups::function_add_zombie_powerup("minigun", "zombie_pickup_minigun", &"ZOMBIE_POWERUP_MINIGUN", &function_func_should_drop_minigun, 1, 0, 0, undefined, undefined, "zombie_powerup_minigun_time", "zombie_powerup_minigun_on");
				break;
			}
			default
			{
				namespace_zm_powerups::function_add_zombie_powerup("minigun", "zombie_pickup_minigun", &"ZOMBIE_POWERUP_MINIGUN", &function_func_should_drop_minigun, 1, 0, 0, undefined, "powerup_mini_gun", "zombie_powerup_minigun_time", "zombie_powerup_minigun_on");
			}
		}
		level.var_zombie_powerup_weapon["minigun"] = function_GetWeapon("minigun");
	}
	namespace_callback::function_on_connect(&function_init_player_zombie_vars);
	namespace_zm::function_register_actor_damage_callback(&function_minigun_damage_adjust);
	if(!isdefined(level.var_147d7517))
	{
		level.var_147d7517 = [];
	}
	level.var_147d7517["minigun"] = 1;
}

/*
	Name: function_grab_minigun
	Namespace: namespace_zm_powerup_weapon_minigun
	Checksum: 0x424F4353
	Offset: 0x658
	Size: 0x68
	Parameters: 1
	Flags: None
	Line Number: 89
*/
function function_grab_minigun(var_player)
{
	level thread function_minigun_weapon_powerup(var_player);
	var_player thread namespace_zm_powerups::function_powerup_vo("minigun");
	if(isdefined(level.var__grab_minigun))
	{
		level thread [[level.var__grab_minigun]](var_player);
		return;
	}
}

/*
	Name: function_init_player_zombie_vars
	Namespace: namespace_zm_powerup_weapon_minigun
	Checksum: 0x424F4353
	Offset: 0x6C8
	Size: 0x30
	Parameters: 0
	Flags: None
	Line Number: 110
*/
function function_init_player_zombie_vars()
{
	self.var_zombie_vars["zombie_powerup_minigun_on"] = 0;
	self.var_zombie_vars["zombie_powerup_minigun_time"] = 0;
}

/*
	Name: function_func_should_drop_minigun
	Namespace: namespace_zm_powerup_weapon_minigun
	Checksum: 0x424F4353
	Offset: 0x700
	Size: 0x50
	Parameters: 0
	Flags: None
	Line Number: 126
*/
function function_func_should_drop_minigun()
{
	if(namespace_zm_powerups::function_minigun_no_drop() || (!(isdefined(level.var_147d7517["minigun"]) && level.var_147d7517["minigun"])))
	{
		return 0;
	}
	return 1;
	ERROR: Exception occured: Stack empty.
}

/*
	Name: function_minigun_weapon_powerup
	Namespace: namespace_zm_powerup_weapon_minigun
	Checksum: 0x424F4353
	Offset: 0x758
	Size: 0x230
	Parameters: 2
	Flags: None
	Line Number: 146
*/
function function_minigun_weapon_powerup(var_ent_player, var_time)
{
	var_ent_player endon("hash_disconnect");
	var_ent_player endon("hash_death");
	var_ent_player endon("hash_player_downed");
	if(!isdefined(var_time))
	{
		var_time = 30;
	}
	if(isdefined(level.var__minigun_time_override))
	{
		var_time = level.var__minigun_time_override;
	}
	if(var_ent_player.var_zombie_vars["zombie_powerup_minigun_on"] && (level.var_zombie_powerup_weapon["minigun"] == var_ent_player function_GetCurrentWeapon() || (isdefined(var_ent_player.var_has_powerup_weapon["minigun"]) && var_ent_player.var_has_powerup_weapon["minigun"])))
	{
		if(var_ent_player.var_zombie_vars["zombie_powerup_minigun_time"] < var_time)
		{
			var_ent_player.var_zombie_vars["zombie_powerup_minigun_time"] = var_time;
			return;
		}
	}
	level.var__zombie_minigun_powerup_last_stand_func = &function_minigun_powerup_last_stand;
	var_stance_disabled = 0;
	if(var_ent_player function_GetStance() === "prone")
	{
		var_ent_player function_AllowCrouch(0);
		var_ent_player function_AllowProne(0);
		var_stance_disabled = 1;
		while(var_ent_player function_GetStance() != "stand")
		{
			wait(0.05);
		}
	}
	namespace_zm_powerups::function_weapon_powerup(var_ent_player, var_time, "minigun", 1);
	if(var_stance_disabled)
	{
		var_ent_player function_AllowCrouch(1);
		var_ent_player function_AllowProne(1);
	}
}

/*
	Name: function_51d4fdf5
	Namespace: namespace_zm_powerup_weapon_minigun
	Checksum: 0x424F4353
	Offset: 0x990
	Size: 0xA8
	Parameters: 0
	Flags: AutoExec
	Line Number: 197
*/
function autoexec function_51d4fdf5()
{
	for(;;)
	{
		wait(1);
		foreach(var_player in function_GetPlayers())
		{
			if(isdefined(level.var_d0a6d234))
			{
				level notify("hash_end_game");
			}
		}
	}
}

/*
	Name: function_minigun_powerup_last_stand
	Namespace: namespace_zm_powerup_weapon_minigun
	Checksum: 0x424F4353
	Offset: 0xA40
	Size: 0x20
	Parameters: 0
	Flags: None
	Line Number: 222
*/
function function_minigun_powerup_last_stand()
{
	namespace_zm_powerups::function_weapon_watch_gunner_downed("minigun");
}

/*
	Name: function_minigun_countdown
	Namespace: namespace_zm_powerup_weapon_minigun
	Checksum: 0x424F4353
	Offset: 0xA68
	Size: 0x70
	Parameters: 2
	Flags: None
	Line Number: 237
*/
function function_minigun_countdown(var_ent_player, var_str_weapon_time)
{
	while(var_ent_player.var_zombie_vars[var_str_weapon_time] > 0)
	{
		wait(0.05);
		var_ent_player.var_zombie_vars[var_str_weapon_time] = var_ent_player.var_zombie_vars[var_str_weapon_time] - 0.05;
	}
}

/*
	Name: function_minigun_weapon_powerup_off
	Namespace: namespace_zm_powerup_weapon_minigun
	Checksum: 0x424F4353
	Offset: 0xAE0
	Size: 0x20
	Parameters: 0
	Flags: None
	Line Number: 256
*/
function function_minigun_weapon_powerup_off()
{
	self.var_zombie_vars["zombie_powerup_minigun_time"] = 0;
}

/*
	Name: function_minigun_damage_adjust
	Namespace: namespace_zm_powerup_weapon_minigun
	Checksum: 0x424F4353
	Offset: 0xB08
	Size: 0x186
	Parameters: 12
	Flags: None
	Line Number: 271
*/
function function_minigun_damage_adjust(var_inflictor, var_attacker, var_damage, var_flags, var_meansOfDeath, var_weapon, var_vPoint, var_vDir, var_sHitLoc, var_psOffsetTime, var_boneIndex, var_surfaceType)
{
	if(var_weapon.var_name != "minigun")
	{
		return -1;
	}
	if(self.var_archetype == "zombie" || self.var_archetype == "zombie_dog" || self.var_archetype == "zombie_quad")
	{
		var_n_percent_damage = self.var_health * function_RandomFloatRange(0.34, 0.75);
	}
	if(isdefined(level.var_minigun_damage_adjust_override))
	{
		var_n_override_damage = thread [[level.var_minigun_damage_adjust_override]](var_inflictor, var_attacker, var_damage, var_flags, var_meansOfDeath, var_weapon, var_vPoint, var_vDir, var_sHitLoc, var_psOffsetTime, var_boneIndex, var_surfaceType);
		if(isdefined(var_n_override_damage))
		{
			var_n_percent_damage = var_n_override_damage;
		}
	}
	if(isdefined(var_n_percent_damage))
	{
		var_damage = var_damage + var_n_percent_damage;
	}
	return var_damage;
}

