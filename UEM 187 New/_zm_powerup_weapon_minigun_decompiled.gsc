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

#namespace zm_powerup_weapon_minigun;

/*
	Name: __init__sytem__
	Namespace: zm_powerup_weapon_minigun
	Checksum: 0x424F4353
	Offset: 0x3A0
	Size: 0x38
	Parameters: 0
	Flags: AutoExec
	Line Number: 30
*/
function autoexec __init__sytem__()
{
	system::register("zm_powerup_minigun", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: zm_powerup_weapon_minigun
	Checksum: 0x424F4353
	Offset: 0x3E0
	Size: 0x270
	Parameters: 0
	Flags: None
	Line Number: 45
*/
function __init__()
{
	zm_powerups::register_powerup("minigun", &grab_minigun);
	zm_powerups::register_powerup_weapon("minigun", &minigun_countdown);
	zm_powerups::powerup_set_prevent_pick_up_if_drinking("minigun", 1);
	zm_powerups::set_weapon_ignore_max_ammo("minigun");
	if(tolower(getdvarstring("g_gametype")) != "zcleansed")
	{
		switch(tolower(getdvarstring("mapname")))
		{
			case "zm_consulate":
			case "zm_crazy_place":
			case "zm_miragenoah":
			case "zm_stairs_of_ammenu":
			{
				zm_powerups::add_zombie_powerup("minigun", "zombie_pickup_minigun", &"ZOMBIE_POWERUP_MINIGUN", &func_should_drop_minigun, 1, 0, 0, undefined, undefined, "zombie_powerup_minigun_time", "zombie_powerup_minigun_on");
				break;
			}
			default
			{
				zm_powerups::add_zombie_powerup("minigun", "zombie_pickup_minigun", &"ZOMBIE_POWERUP_MINIGUN", &func_should_drop_minigun, 1, 0, 0, undefined, "powerup_mini_gun", "zombie_powerup_minigun_time", "zombie_powerup_minigun_on");
			}
		}
		level.zombie_powerup_weapon["minigun"] = getweapon("minigun");
	}
	callback::on_connect(&init_player_zombie_vars);
	zm::register_actor_damage_callback(&minigun_damage_adjust);
	if(!isdefined(level.var_147d7517))
	{
		level.var_147d7517 = [];
	}
	level.var_147d7517["minigun"] = 1;
}

/*
	Name: grab_minigun
	Namespace: zm_powerup_weapon_minigun
	Checksum: 0x424F4353
	Offset: 0x658
	Size: 0x68
	Parameters: 1
	Flags: None
	Line Number: 89
*/
function grab_minigun(player)
{
	level thread minigun_weapon_powerup(player);
	player thread zm_powerups::powerup_vo("minigun");
	if(isdefined(level._grab_minigun))
	{
		level thread [[level._grab_minigun]](player);
	}
}

/*
	Name: init_player_zombie_vars
	Namespace: zm_powerup_weapon_minigun
	Checksum: 0x424F4353
	Offset: 0x6C8
	Size: 0x30
	Parameters: 0
	Flags: None
	Line Number: 109
*/
function init_player_zombie_vars()
{
	self.zombie_vars["zombie_powerup_minigun_on"] = 0;
	self.zombie_vars["zombie_powerup_minigun_time"] = 0;
}

/*
	Name: func_should_drop_minigun
	Namespace: zm_powerup_weapon_minigun
	Checksum: 0x424F4353
	Offset: 0x700
	Size: 0x50
	Parameters: 0
	Flags: None
	Line Number: 125
*/
function func_should_drop_minigun()
{
	if(zm_powerups::minigun_no_drop() || (!(isdefined(level.var_147d7517["minigun"]) && level.var_147d7517["minigun"])))
	{
		return 0;
	}
	return 1;
}

/*
	Name: minigun_weapon_powerup
	Namespace: zm_powerup_weapon_minigun
	Checksum: 0x424F4353
	Offset: 0x758
	Size: 0x230
	Parameters: 2
	Flags: None
	Line Number: 144
*/
function minigun_weapon_powerup(ent_player, time)
{
	ent_player endon("disconnect");
	ent_player endon("death");
	ent_player endon("player_downed");
	if(!isdefined(time))
	{
		time = 30;
	}
	if(isdefined(level._minigun_time_override))
	{
		time = level._minigun_time_override;
	}
	if(ent_player.zombie_vars["zombie_powerup_minigun_on"] && (level.zombie_powerup_weapon["minigun"] == ent_player getcurrentweapon() || (isdefined(ent_player.has_powerup_weapon["minigun"]) && ent_player.has_powerup_weapon["minigun"])))
	{
		if(ent_player.zombie_vars["zombie_powerup_minigun_time"] < time)
		{
			ent_player.zombie_vars["zombie_powerup_minigun_time"] = time;
			return;
		}
	}
	level._zombie_minigun_powerup_last_stand_func = &minigun_powerup_last_stand;
	stance_disabled = 0;
	if(ent_player getstance() === "prone")
	{
		ent_player allowcrouch(0);
		ent_player allowprone(0);
		stance_disabled = 1;
		while(ent_player getstance() != "stand")
		{
			wait(0.05);
		}
	}
	zm_powerups::weapon_powerup(ent_player, time, "minigun", 1);
	if(stance_disabled)
	{
		ent_player allowcrouch(1);
		ent_player allowprone(1);
	}
}

/*
	Name: minigun_powerup_last_stand
	Namespace: zm_powerup_weapon_minigun
	Checksum: 0x424F4353
	Offset: 0x990
	Size: 0x20
	Parameters: 0
	Flags: None
	Line Number: 195
*/
function minigun_powerup_last_stand()
{
	zm_powerups::weapon_watch_gunner_downed("minigun");
}

/*
	Name: minigun_countdown
	Namespace: zm_powerup_weapon_minigun
	Checksum: 0x424F4353
	Offset: 0x9B8
	Size: 0x70
	Parameters: 2
	Flags: None
	Line Number: 210
*/
function minigun_countdown(ent_player, str_weapon_time)
{
	while(ent_player.zombie_vars[str_weapon_time] > 0)
	{
		wait(0.05);
		ent_player.zombie_vars[str_weapon_time] = ent_player.zombie_vars[str_weapon_time] - 0.05;
	}
	return;
	ERROR: Exception occured: Stack empty.
}

/*
	Name: minigun_weapon_powerup_off
	Namespace: zm_powerup_weapon_minigun
	Checksum: 0x424F4353
	Offset: 0xA30
	Size: 0x20
	Parameters: 0
	Flags: None
	Line Number: 231
*/
function minigun_weapon_powerup_off()
{
	self.zombie_vars["zombie_powerup_minigun_time"] = 0;
}

/*
	Name: minigun_damage_adjust
	Namespace: zm_powerup_weapon_minigun
	Checksum: 0x424F4353
	Offset: 0xA58
	Size: 0x186
	Parameters: 12
	Flags: None
	Line Number: 246
*/
function minigun_damage_adjust(inflictor, attacker, damage, flags, meansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, boneindex, surfacetype)
{
	if(weapon.name != "minigun")
	{
		return -1;
	}
	if(self.archetype == "zombie" || self.archetype == "zombie_dog" || self.archetype == "zombie_quad")
	{
		n_percent_damage = self.health * randomfloatrange(0.34, 0.75);
	}
	if(isdefined(level.minigun_damage_adjust_override))
	{
		n_override_damage = thread [[level.minigun_damage_adjust_override]](inflictor, attacker, damage, flags, meansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, boneindex, surfacetype);
		if(isdefined(n_override_damage))
		{
			n_percent_damage = n_override_damage;
		}
	}
	if(isdefined(n_percent_damage))
	{
		damage = damage + n_percent_damage;
	}
	return damage;
}

