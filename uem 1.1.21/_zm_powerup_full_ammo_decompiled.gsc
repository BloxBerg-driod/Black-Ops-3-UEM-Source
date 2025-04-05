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

#namespace namespace_zm_powerup_full_ammo;

/*
	Name: function___init__sytem__
	Namespace: namespace_zm_powerup_full_ammo
	Checksum: 0x424F4353
	Offset: 0x2B8
	Size: 0x38
	Parameters: 0
	Flags: AutoExec
	Line Number: 26
*/
function autoexec function___init__sytem__()
{
	namespace_system::function_register("zm_powerup_full_ammo", &function___init__, undefined, undefined);
}

/*
	Name: function___init__
	Namespace: namespace_zm_powerup_full_ammo
	Checksum: 0x424F4353
	Offset: 0x2F8
	Size: 0xB8
	Parameters: 0
	Flags: None
	Line Number: 41
*/
function function___init__()
{
	namespace_zm_powerups::function_register_powerup("full_ammo", &function_grab_full_ammo);
	if(function_ToLower(function_GetDvarString("g_gametype")) != "zcleansed")
	{
		namespace_zm_powerups::function_add_zombie_powerup("full_ammo", "p7_zm_power_up_max_ammo", &"ZOMBIE_POWERUP_MAX_AMMO", &function_680df69b, 0, 0, 0);
	}
	level.var_147d7517["full_ammo"] = 1;
}

/*
	Name: function_680df69b
	Namespace: namespace_zm_powerup_full_ammo
	Checksum: 0x424F4353
	Offset: 0x3B8
	Size: 0x38
	Parameters: 0
	Flags: None
	Line Number: 61
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
	Name: function_grab_full_ammo
	Namespace: namespace_zm_powerup_full_ammo
	Checksum: 0x424F4353
	Offset: 0x3F8
	Size: 0x48
	Parameters: 1
	Flags: None
	Line Number: 80
*/
function function_grab_full_ammo(var_player)
{
	level thread function_full_ammo_powerup(self, var_player);
	var_player thread namespace_zm_powerups::function_powerup_vo("full_ammo");
}

/*
	Name: function_full_ammo_powerup
	Namespace: namespace_zm_powerup_full_ammo
	Checksum: 0x424F4353
	Offset: 0x448
	Size: 0x4B0
	Parameters: 2
	Flags: None
	Line Number: 96
*/
function function_full_ammo_powerup(var_drop_item, var_player)
{
	var_players = function_GetPlayers(var_player.var_team);
	if(isdefined(level.var__get_game_module_players))
	{
		var_players = [[level.var__get_game_module_players]](var_player);
	}
	level notify("hash_zmb_max_ammo_level");
	for(var_i = 0; var_i < var_players.size; var_i++)
	{
		if(var_players[var_i] namespace_laststand::function_player_is_in_laststand())
		{
			continue;
		}
		if(isdefined(level.var_check_player_is_ready_for_ammo))
		{
			if([[level.var_check_player_is_ready_for_ammo]](var_players[var_i]) == 0)
			{
				continue;
			}
		}
		var_primary_weapons = var_players[var_i] function_GetWeaponsList(1);
		var_players[var_i] notify("hash_zmb_max_ammo");
		var_players[var_i] notify("hash_zmb_lost_knife");
		var_players[var_i] namespace_zm_placeable_mine::function_disable_all_prompts_for_player();
		for(var_x = 0; var_x < var_primary_weapons.size; var_x++)
		{
			if(level.var_headshots_only && namespace_zm_utility::function_is_lethal_grenade(var_primary_weapons[var_x]))
			{
				continue;
			}
			if(isdefined(level.var_zombie_include_equipment) && isdefined(level.var_zombie_include_equipment[var_primary_weapons[var_x]]) && (!(isdefined(level.var_zombie_equipment[var_primary_weapons[var_x]].var_refill_max_ammo) && level.var_zombie_equipment[var_primary_weapons[var_x]].var_refill_max_ammo)))
			{
				continue;
			}
			if(isdefined(level.var_zombie_weapons_no_max_ammo) && isdefined(level.var_zombie_weapons_no_max_ammo[var_primary_weapons[var_x].var_name]))
			{
				continue;
			}
			if(namespace_zm_utility::function_is_hero_weapon(var_primary_weapons[var_x]))
			{
				continue;
			}
			if(var_players[var_i] function_HasWeapon(var_primary_weapons[var_x]))
			{
				if(var_players[var_i] function_hasPerk("specialty_extraammo"))
				{
					var_players[var_i] function_giveMaxAmmo(var_primary_weapons[var_x]);
				}
				else
				{
					var_players[var_i] function_GiveStartAmmo(var_primary_weapons[var_x]);
				}
			}
			if(isdefined(level.var_240d2289) && level.var_240d2289)
			{
				foreach(var_weapon in var_players[var_i] function_GetWeaponsList(1))
				{
					if(isdefined(var_weapon.var_clipSize) && var_weapon.var_clipSize > 0)
					{
						if(isdefined(var_weapon.var_dualWieldWeapon) && var_weapon.var_dualWieldWeapon != level.var_weaponNone)
						{
							var_players[var_i] function_SetWeaponAmmoClip(var_weapon.var_dualWieldWeapon, var_weapon.var_dualWieldWeapon.var_clipSize);
						}
						var_players[var_i] function_SetWeaponAmmoClip(var_weapon, var_weapon.var_clipSize);
					}
				}
			}
		}
	}
	level thread function_full_ammo_on_hud(var_drop_item, var_player.var_team);
}

/*
	Name: function_full_ammo_on_hud
	Namespace: namespace_zm_powerup_full_ammo
	Checksum: 0x424F4353
	Offset: 0x900
	Size: 0x94
	Parameters: 2
	Flags: None
	Line Number: 179
*/
function function_full_ammo_on_hud(var_drop_item, var_player_team)
{
	var_players = function_GetPlayers(var_player_team);
	var_players[0] function_playsoundtoteam("zmb_full_ammo", var_player_team);
	if(isdefined(var_drop_item))
	{
		function_LUINotifyEvent(&"zombie_notification", 1, var_drop_item.var_hint);
	}
}

