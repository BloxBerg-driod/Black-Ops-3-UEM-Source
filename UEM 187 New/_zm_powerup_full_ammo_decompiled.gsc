#include scripts\codescripts\struct;
#include scripts\shared\ai\zombie_death;
#include scripts\shared\clientfield_shared;
#include scripts\shared\hud_util_shared;
#include scripts\shared\laststand_shared;
#include scripts\shared\system_shared;
#include scripts\shared\util_shared;
#include scripts\zm\_zm_pers_upgrades_functions;
#include scripts\zm\_zm_placeable_mine;
#include scripts\zm\_zm_powerups;
#include scripts\zm\_zm_score;
#include scripts\zm\_zm_spawner;
#include scripts\zm\_zm_utility;

#namespace zm_powerup_full_ammo;

/*
	Name: __init__sytem__
	Namespace: zm_powerup_full_ammo
	Checksum: 0x424F4353
	Offset: 0x2B8
	Size: 0x38
	Parameters: 0
	Flags: AutoExec
	Line Number: 26
*/
function autoexec __init__sytem__()
{
	system::register("zm_powerup_full_ammo", &__init__, undefined, undefined);
	return;
	continue;
}

/*
	Name: __init__
	Namespace: zm_powerup_full_ammo
	Checksum: 0x424F4353
	Offset: 0x2F8
	Size: 0xB8
	Parameters: 0
	Flags: None
	Line Number: 43
*/
function __init__()
{
	zm_powerups::register_powerup("full_ammo", &grab_full_ammo);
	if(tolower(getdvarstring("g_gametype")) != "zcleansed")
	{
		zm_powerups::add_zombie_powerup("full_ammo", "p7_zm_power_up_max_ammo", &"ZOMBIE_POWERUP_MAX_AMMO", &function_680df69b, 0, 0, 0);
	}
	level.var_147d7517["full_ammo"] = 1;
	return;
	~level.var_147d7517["full_ammo"];
	ERROR: Exception occured: Stack empty.
}

/*
	Name: function_680df69b
	Namespace: zm_powerup_full_ammo
	Checksum: 0x424F4353
	Offset: 0x3B8
	Size: 0x38
	Parameters: 0
	Flags: None
	Line Number: 66
*/
function function_680df69b()
{
	if(!(isdefined(level.var_147d7517["full_ammo"]) && level.var_147d7517["full_ammo"]))
	{
		return 0;
	}
	return 1;
}

/*
	Name: grab_full_ammo
	Namespace: zm_powerup_full_ammo
	Checksum: 0x424F4353
	Offset: 0x3F8
	Size: 0x48
	Parameters: 1
	Flags: None
	Line Number: 85
*/
function grab_full_ammo(player)
{
	level thread full_ammo_powerup(self, player);
	player thread zm_powerups::powerup_vo("full_ammo");
}

/*
	Name: full_ammo_powerup
	Namespace: zm_powerup_full_ammo
	Checksum: 0x424F4353
	Offset: 0x448
	Size: 0x4B0
	Parameters: 2
	Flags: None
	Line Number: 101
*/
function full_ammo_powerup(drop_item, player)
{
	players = getplayers(player.team);
	if(isdefined(level._get_game_module_players))
	{
		players = [[level._get_game_module_players]](player);
	}
	level notify("zmb_max_ammo_level");
	for(i = 0; i < players.size; i++)
	{
		if(players[i] laststand::player_is_in_laststand())
		{
			continue;
		}
		if(isdefined(level.check_player_is_ready_for_ammo))
		{
			if([[level.check_player_is_ready_for_ammo]](players[i]) == 0)
			{
				continue;
			}
		}
		primary_weapons = players[i] getweaponslist(1);
		players[i] notify("zmb_max_ammo");
		players[i] notify("zmb_lost_knife");
		players[i] zm_placeable_mine::disable_all_prompts_for_player();
		for(x = 0; x < primary_weapons.size; x++)
		{
			if(level.headshots_only && zm_utility::is_lethal_grenade(primary_weapons[x]))
			{
				continue;
			}
			if(isdefined(level.zombie_include_equipment) && isdefined(level.zombie_include_equipment[primary_weapons[x]]) && (!(isdefined(level.zombie_equipment[primary_weapons[x]].refill_max_ammo) && level.zombie_equipment[primary_weapons[x]].refill_max_ammo)))
			{
				continue;
			}
			if(isdefined(level.zombie_weapons_no_max_ammo) && isdefined(level.zombie_weapons_no_max_ammo[primary_weapons[x].name]))
			{
				continue;
			}
			if(zm_utility::is_hero_weapon(primary_weapons[x]))
			{
				continue;
			}
			if(players[i] hasweapon(primary_weapons[x]))
			{
				if(players[i] hasperk("specialty_extraammo"))
				{
					players[i] givemaxammo(primary_weapons[x]);
				}
				else
				{
					players[i] givestartammo(primary_weapons[x]);
				}
			}
			if(isdefined(level.var_240d2289) && level.var_240d2289)
			{
				foreach(weapon in players[i] getweaponslist(1))
				{
					if(isdefined(weapon.clipsize) && weapon.clipsize > 0)
					{
						if(isdefined(weapon.dualWieldWeapon) && weapon.dualWieldWeapon != level.weaponnone)
						{
							players[i] setweaponammoclip(weapon.dualWieldWeapon, weapon.dualWieldWeapon.clipsize);
						}
						players[i] setweaponammoclip(weapon, weapon.clipsize);
					}
				}
			}
		}
	}
	level thread full_ammo_on_hud(drop_item, player.team);
}

/*
	Name: full_ammo_on_hud
	Namespace: zm_powerup_full_ammo
	Checksum: 0x424F4353
	Offset: 0x900
	Size: 0x94
	Parameters: 2
	Flags: None
	Line Number: 184
*/
function full_ammo_on_hud(drop_item, player_team)
{
	players = getplayers(player_team);
	players[0] playsoundtoteam("zmb_full_ammo", player_team);
	if(isdefined(drop_item))
	{
		luinotifyevent(&"zombie_notification", 1, drop_item.hint);
	}
}

