#include scripts\codescripts\struct;
#include scripts\shared\array_shared;
#include scripts\shared\callbacks_shared;
#include scripts\shared\clientfield_shared;
#include scripts\shared\flag_shared;
#include scripts\shared\hud_util_shared;
#include scripts\shared\laststand_shared;
#include scripts\shared\math_shared;
#include scripts\shared\scene_shared;
#include scripts\shared\system_shared;
#include scripts\shared\throttle_shared;
#include scripts\shared\util_shared;
#include scripts\sphynx\equipment\_zm_deployment_station;
#include scripts\sphynx\leveling\_zm_sphynx_leveling;
#include scripts\zm\_zm;
#include scripts\zm\_zm_audio;
#include scripts\zm\_zm_bgb;
#include scripts\zm\_zm_equipment;
#include scripts\zm\_zm_laststand;
#include scripts\zm\_zm_magicbox;
#include scripts\zm\_zm_net;
#include scripts\zm\_zm_perk_electric_cherry_uem;
#include scripts\zm\_zm_perks;
#include scripts\zm\_zm_powerups;
#include scripts\zm\_zm_score;
#include scripts\zm\_zm_spawner;
#include scripts\zm\_zm_unitrigger;
#include scripts\zm\_zm_utility;
#include scripts\zm\_zm_weapon_upgrade_system;
#include scripts\zm\_zm_weapons;

#namespace namespace_c6910797;

/*
	Name: function___init__sytem__
	Namespace: namespace_c6910797
	Checksum: 0x424F4353
	Offset: 0xC18
	Size: 0x38
	Parameters: 0
	Flags: AutoExec
	Line Number: 43
*/
function autoexec function___init__sytem__()
{
	namespace_system::function_register("zm_gungame", &function___init__, undefined, undefined);
}

/*
	Name: function___init__
	Namespace: namespace_c6910797
	Checksum: 0x424F4353
	Offset: 0xC58
	Size: 0x8D0
	Parameters: 0
	Flags: None
	Line Number: 58
*/
function function___init__()
{
	if(!isdefined(level.var_90d57b96))
	{
		level.var_90d57b96 = function_Int(0);
	}
	if(!isdefined(level.var_b1cf1e73))
	{
		level.var_b1cf1e73 = function_Int(0);
	}
	if(!isdefined(level.var_9ff42471))
	{
		level.var_9ff42471 = function_Int(0);
	}
	level namespace_flag::function_init("gun_game_active");
	wait(0.05);
	level namespace_flag::function_wait_till("allow_gungame");
	if(function_ToLower(function_GetDvarString("mapname")) != "zm_tranzit_busdepot")
	{
		level.var_2d1d6521 = [];
		level thread function_3363a1ee();
		level.var_c181264f = 1;
		level namespace_flag::function_set("gun_game_active");
		namespace_callback::function_on_connect(&function_e8c29a80);
		namespace_callback::function_on_spawned(&function_on_player_spawned);
		namespace_zm_spawner::function_register_zombie_death_event_callback(&function_70521d40);
		level thread function_26561004();
		level thread function_20c0581b();
		level thread function_c2bf8a3e();
		level.var_func_override_wallbuy_prompt = &function_f431efcb;
		level thread function_delete_triggers();
		level.var_dog_rounds_allowed = 0;
		level.var_lastStandGetupAllowed = 1;
		level.var_whoswho_laststand_func = &function_de351df;
		level.var_5e740b8 = function_Array();
		level.var_d4977bde = function_Array("pistol_standard", "pistol_burst", "pistol_fullauto");
		level.var_a6dfbcba = function_Array("sniper_fastbolt", "sniper_powerbolt", "sniper_fastsemi");
		level.var_db2e32a7 = function_Array("shotgun_pump", "shotgun_precision", "shotgun_fullauto", "shotgun_energy", "shotgun_semiauto");
		level.var_244a19ad = function_Array("lmg_cqb", "lmg_light", "lmg_heavy");
		if(isdefined(level.var_3e85df60) && level.var_3e85df60)
		{
			level.var_87f0fce = function_Array("smg_longrange", "ar_damage", "ar_longburst", "ar_marksman", "ar_standard", "ar_cqb", "ar_accurate");
			level.var_3c0604e2 = function_Array("smg_burst", "smg_capacity", "smg_fastfire", "smg_standard", "smg_versatile");
			level.var_3185f12 = function_Array("ray_gun");
		}
		else
		{
			level.var_87f0fce = function_Array("smg_longrange", "ar_damage", "ar_longburst", "ar_marksman", "ar_standard", "ar_cqb", "ar_accurate", "ar_stg44");
			level.var_3c0604e2 = function_Array("smg_burst", "smg_capacity", "smg_fastfire", "smg_standard", "smg_versatile", "smg_ppsh", "smg_thompson", "smg_mp40_1940");
			level.var_3185f12 = function_Array("t9_crossbow_skull", "ray_gun", "t9_gallo_raygun");
		}
		if(isdefined(level.var_9ff42471) && level.var_9ff42471 == 2)
		{
			level.var_d4977bde = namespace_Array::function_randomize(level.var_d4977bde);
			level.var_3c0604e2 = namespace_Array::function_randomize(level.var_3c0604e2);
			level.var_a6dfbcba = namespace_Array::function_randomize(level.var_a6dfbcba);
			level.var_db2e32a7 = namespace_Array::function_randomize(level.var_db2e32a7);
			level.var_87f0fce = namespace_Array::function_randomize(level.var_87f0fce);
			level.var_244a19ad = namespace_Array::function_randomize(level.var_244a19ad);
			level.var_3185f12 = namespace_Array::function_randomize(level.var_3185f12);
		}
		level.var_5e740b8 = function_ArrayCombine(level.var_5e740b8, level.var_d4977bde, 0, 0);
		level.var_5e740b8 = function_ArrayCombine(level.var_5e740b8, level.var_3c0604e2, 0, 0);
		level.var_5e740b8 = function_ArrayCombine(level.var_5e740b8, level.var_a6dfbcba, 0, 0);
		level.var_5e740b8 = function_ArrayCombine(level.var_5e740b8, level.var_db2e32a7, 0, 0);
		level.var_5e740b8 = function_ArrayCombine(level.var_5e740b8, level.var_87f0fce, 0, 0);
		level.var_5e740b8 = function_ArrayCombine(level.var_5e740b8, level.var_244a19ad, 0, 0);
		level.var_5e740b8 = function_ArrayCombine(level.var_5e740b8, level.var_3185f12, 0, 0);
		if(isdefined(level.var_9ff42471) && level.var_9ff42471 == 3)
		{
			level.var_5e740b8 = namespace_Array::function_randomize(level.var_5e740b8);
		}
		if(isdefined(level.var_90d57b96) && level.var_90d57b96 == 1)
		{
			level.var_83972a9b = function_Array();
			for(var_i = 0; var_i < level.var_5e740b8.size; var_i++)
			{
				var_weapon = function_GetWeapon(level.var_5e740b8[var_i]);
				if(isdefined(level.var_zombie_weapons[var_weapon]) && isdefined(level.var_zombie_weapons[var_weapon].var_upgrade))
				{
					level.var_83972a9b[var_i] = level.var_zombie_weapons[var_weapon].var_upgrade.var_name;
				}
			}
			if(isdefined(level.var_9ff42471) && level.var_9ff42471 == 3)
			{
				level.var_83972a9b = namespace_Array::function_randomize(level.var_83972a9b);
			}
			level.var_5e740b8 = function_ArrayCombine(level.var_5e740b8, level.var_83972a9b, 0, 0);
		}
	}
}

/*
	Name: function_c2bf8a3e
	Namespace: namespace_c6910797
	Checksum: 0x424F4353
	Offset: 0x1530
	Size: 0x558
	Parameters: 0
	Flags: None
	Line Number: 160
*/
function function_c2bf8a3e()
{
	self endon("hash_disconnect");
	var_a42d1f45 = function_Array("specialty_staminup", "specialty_deadshot", "specialty_fastreload", "specialty_armorvest", "specialty_doubletap2", "specialty_electriccherry");
	var_a42d1f45 = namespace_Array::function_randomize(var_a42d1f45);
	var_total_time = 0;
	for(;;)
	{
		wait(1);
		var_total_time++;
		switch(var_total_time)
		{
			case 300:
			{
				foreach(var_player in function_GetPlayers())
				{
					if(!var_player function_hasPerk(var_a42d1f45[0]))
					{
						var_player namespace_zm_perks::function_give_perk(var_a42d1f45[0], 0);
					}
				}
				break;
			}
			case 500:
			{
				foreach(var_player in function_GetPlayers())
				{
					if(!var_player function_hasPerk(var_a42d1f45[1]))
					{
						var_player namespace_zm_perks::function_give_perk(var_a42d1f45[1], 0);
					}
				}
				break;
			}
			case 700:
			{
				foreach(var_player in function_GetPlayers())
				{
					if(!var_player function_hasPerk(var_a42d1f45[2]))
					{
						var_player namespace_zm_perks::function_give_perk(var_a42d1f45[2], 0);
					}
				}
				break;
			}
			case 900:
			{
				foreach(var_player in function_GetPlayers())
				{
					if(!var_player function_hasPerk(var_a42d1f45[3]))
					{
						var_player namespace_zm_perks::function_give_perk(var_a42d1f45[3], 0);
					}
				}
				break;
			}
			case 1100:
			{
				foreach(var_player in function_GetPlayers())
				{
					if(!var_player function_hasPerk(var_a42d1f45[4]))
					{
						var_player namespace_zm_perks::function_give_perk(var_a42d1f45[4], 0);
					}
				}
				break;
			}
			case 1300:
			{
				foreach(var_player in function_GetPlayers())
				{
					if(!var_player function_hasPerk(var_a42d1f45[5]))
					{
						var_player namespace_zm_perks::function_give_perk(var_a42d1f45[5], 0);
					}
				}
				break;
			}
		}
	}
}

/*
	Name: function_3363a1ee
	Namespace: namespace_c6910797
	Checksum: 0x424F4353
	Offset: 0x1A90
	Size: 0x2B0
	Parameters: 0
	Flags: None
	Line Number: 252
*/
function function_3363a1ee()
{
	var_index = 1;
	var_table = "gamedata/weapons/damage_multiplier/zm_gungame_stats.csv";
	for(var_row = function_TableLookupRow(var_table, var_index); isdefined(var_row); var_row = function_TableLookupRow(var_table, var_index))
	{
		var_34c9778a = function_Int(function_checkStringValid(var_row[0]));
		var_d8ea7d0f = function_Int(function_checkStringValid(var_row[1]));
		if(isdefined(var_34c9778a))
		{
			level.var_2d1d6521[var_34c9778a] = function_spawnstruct();
			level.var_2d1d6521[var_34c9778a].var_34c9778a = var_34c9778a;
			if(isdefined(level.var_b1cf1e73) && level.var_b1cf1e73 == 2)
			{
				level.var_2d1d6521[var_34c9778a].var_d8ea7d0f = var_d8ea7d0f * 0.5;
			}
			else if(isdefined(level.var_b1cf1e73) && level.var_b1cf1e73 == 3)
			{
				level.var_2d1d6521[var_34c9778a].var_d8ea7d0f = var_d8ea7d0f * 0.75;
			}
			else if(isdefined(level.var_b1cf1e73) && level.var_b1cf1e73 == 4)
			{
				level.var_2d1d6521[var_34c9778a].var_d8ea7d0f = var_d8ea7d0f * 2;
			}
			else if(isdefined(level.var_b1cf1e73) && level.var_b1cf1e73 == 5)
			{
				level.var_2d1d6521[var_34c9778a].var_d8ea7d0f = var_d8ea7d0f * 3;
			}
			else if(isdefined(level.var_b1cf1e73) && level.var_b1cf1e73 == 6)
			{
				level.var_2d1d6521[var_34c9778a].var_d8ea7d0f = var_d8ea7d0f * 4;
			}
			else
			{
				level.var_2d1d6521[var_34c9778a].var_d8ea7d0f = var_d8ea7d0f;
			}
		}
		var_index++;
	}
}

/*
	Name: function_checkStringValid
	Namespace: namespace_c6910797
	Checksum: 0x424F4353
	Offset: 0x1D48
	Size: 0x28
	Parameters: 1
	Flags: None
	Line Number: 303
*/
function function_checkStringValid(var_STR)
{
	if(var_STR != "")
	{
		return var_STR;
	}
	return undefined;
}

/*
	Name: function_e8c29a80
	Namespace: namespace_c6910797
	Checksum: 0x424F4353
	Offset: 0x1D78
	Size: 0xC0
	Parameters: 0
	Flags: None
	Line Number: 322
*/
function function_e8c29a80()
{
	self endon("hash_disconnect");
	self thread function_97c95414();
	if(!isdefined(level.var_5e740b8))
	{
		while(!isdefined(level.var_5e740b8))
		{
			wait(0.05);
			function_IPrintLnBold("Not working; Try restarting Gun Game");
		}
	}
	self.var_f218f8f2 = [];
	self.var_f218f8f2["xp"] = function_Int(0);
	self.var_f218f8f2["current_gun"] = function_Int(0);
}

/*
	Name: function_on_player_spawned
	Namespace: namespace_c6910797
	Checksum: 0x424F4353
	Offset: 0x1E40
	Size: 0xF0
	Parameters: 0
	Flags: None
	Line Number: 349
*/
function function_on_player_spawned()
{
	wait(2);
	self thread function_d00dd5f5();
	self thread function_60d5316b();
	self thread function_eae0487c();
	self thread function_1e0b6d79();
	if(level.var_round_number <= 2)
	{
		self.var_f218f8f2["current_gun"] = function_Int(0);
	}
	else
	{
		self.var_f218f8f2["current_gun"] = function_Int(namespace_zm_utility::function_round_up_score(level.var_round_number / 2, 1));
	}
}

/*
	Name: function_97c95414
	Namespace: namespace_c6910797
	Checksum: 0x424F4353
	Offset: 0x1F38
	Size: 0x48
	Parameters: 0
	Flags: None
	Line Number: 376
*/
function function_97c95414()
{
	self endon("hash_disconnect");
	for(;;)
	{
		self function_setPerk("specialty_whoswho");
		self.var_lives = 999999;
		wait(2);
	}
}

/*
	Name: function_eae0487c
	Namespace: namespace_c6910797
	Checksum: 0x424F4353
	Offset: 0x1F88
	Size: 0xE8
	Parameters: 0
	Flags: None
	Line Number: 397
*/
function function_eae0487c()
{
	self endon("hash_disconnect");
	for(;;)
	{
		wait(0.2);
		var_current_weapon = function_GetWeapon(level.var_5e740b8[self.var_f218f8f2["current_gun"]]);
		var_w_weapon = self function_GetCurrentWeapon();
		if(isdefined(var_w_weapon) && var_w_weapon != var_current_weapon)
		{
			if(isdefined(var_w_weapon function_baa39e24(self)) && var_w_weapon function_baa39e24(self))
			{
				continue;
			}
			else
			{
				self thread function_43efb74a();
			}
		}
	}
}

/*
	Name: function_baa39e24
	Namespace: namespace_c6910797
	Checksum: 0x424F4353
	Offset: 0x2078
	Size: 0x1F8
	Parameters: 1
	Flags: None
	Line Number: 429
*/
function function_baa39e24(var_player)
{
	if(self != level.var_zombie_weapons[function_GetWeapon(level.var_5e740b8[self.var_f218f8f2["current_gun"]])].var_upgrade)
	{
		return 1;
	}
	if(level.var__custom_perks.size > 0)
	{
		var_a_keys = function_getArrayKeys(level.var__custom_perks);
		for(var_i = 0; var_i < var_a_keys.size; var_i++)
		{
			if(isdefined(level.var__custom_perks[var_a_keys[var_i]].var_perk_bottle_weapon) && self == level.var__custom_perks[var_a_keys[var_i]].var_perk_bottle_weapon)
			{
				return 1;
				break;
			}
		}
	}
	else if(var_player function_IsThrowingGrenade() || var_player function_fragButtonPressed() || var_player function_SecondaryOffhandButtonPressed() || var_player function_IsMeleeing())
	{
		return 1;
	}
	if(var_player namespace_flag::function_exists("in_beastmode") && var_player namespace_flag::function_get("in_beastmode"))
	{
		return 1;
	}
	if(self.var_isRiotShield)
	{
		return 1;
	}
	if(self.var_name == "equip_hacker" || self.var_name == "equip_gasmask")
	{
		return 0;
	}
}

/*
	Name: function_1e0b6d79
	Namespace: namespace_c6910797
	Checksum: 0x424F4353
	Offset: 0x2278
	Size: 0x590
	Parameters: 0
	Flags: None
	Line Number: 475
*/
function function_1e0b6d79()
{
	self endon("hash_disconnect");
	self.var_a67cf276 = 0;
	self.var_65e04c04 = function_Int(0);
	while(1)
	{
		self waittill("hash_379210d1", var_type, var_XP);
		self.var_f218f8f2["xp"] = self.var_f218f8f2["xp"] + var_XP;
		self thread function_d00dd5f5();
		if(self.var_f218f8f2["xp"] >= level.var_2d1d6521[self.var_f218f8f2["current_gun"]].var_d8ea7d0f)
		{
			if(self.var_f218f8f2["current_gun"] + 1 > level.var_5e740b8.size - 1)
			{
				self.var_a67cf276 = 1;
				self.var_f218f8f2["xp"] = level.var_2d1d6521[self.var_f218f8f2["current_gun"]].var_d8ea7d0f;
				self.var_f218f8f2["current_gun"]++;
				self thread function_d00dd5f5();
				level.var_custom_game_over_hud_elem = &function_b8f48865;
				level namespace_flag::function_clear("spawn_zombies");
				var_a_ai_enemies = function_GetAITeamArray("axis");
				foreach(var_ai_enemy in var_a_ai_enemies)
				{
					level.var_zombie_total++;
					level.var_zombie_respawns++;
					var_ai_enemy function_DoDamage(var_ai_enemy.var_health + 666, var_ai_enemy.var_origin);
				}
				if(isdefined(self.var_a67cf276) && self.var_a67cf276)
				{
					if(self.var_65e04c04 <= 0)
					{
						self.var_pers["gungame_flawless_wins"]++;
						self thread namespace_97ac1184::function_7e18304e("spx_save_data", "gungame_flawless_wins", self.var_pers["gungame_flawless_wins"], 0);
					}
					else
					{
						self.var_pers["gungame_wins"]++;
						self thread namespace_97ac1184::function_7e18304e("spx_save_data", "gungame_wins", self.var_pers["gungame_wins"], 0);
					}
				}
				foreach(var_player in function_GetPlayers())
				{
					if(!(isdefined(var_player.var_a67cf276) && var_player.var_a67cf276))
					{
						var_player.var_pers["gungame_losses"]++;
						var_player thread namespace_97ac1184::function_7e18304e("spx_save_data", "gungame_losses", var_player.var_pers["gungame_losses"], 0);
					}
				}
				wait(0.05);
				level thread namespace_97ac1184::function_231f215a();
				wait(2);
				namespace_a74e4f35::function_b8bbdc71();
			}
			else
			{
				self.var_f218f8f2["current_gun"]++;
				self thread namespace_97ac1184::function_b3489bf5("^3" + self.var_playerName + "^7 obtained the next gun ^9" + self.var_f218f8f2["current_gun"] + "/" + function_Int(level.var_5e740b8.size));
				self.var_f218f8f2["xp"] = 0;
				self function_playsoundtoplayer("gun_game_rank_up", self);
				self thread namespace_97ac1184::function_score_event(&"ZM_MINECRAFT_GUN_GAME_PROMOTION", 100);
				if(self.var_f218f8f2["xp"] < 0)
				{
					self.var_f218f8f2["xp"] = 0;
				}
				self thread function_43efb74a();
				self thread function_d00dd5f5();
			}
		}
	}
}

/*
	Name: function_d00dd5f5
	Namespace: namespace_c6910797
	Checksum: 0x424F4353
	Offset: 0x2810
	Size: 0x2A8
	Parameters: 0
	Flags: None
	Line Number: 556
*/
function function_d00dd5f5()
{
	wait(0.05);
	self.var_df17dfe1 = 1;
	for(var_i = 0; var_i < function_GetDvarInt("com_maxclients"); var_i++)
	{
		if(self.var_a67cf276)
		{
			self function_LUINotifyEvent(&"ZMBU_info", 6, &"ZM_MINECRAFT_GUN_GAME", var_i, function_Int(function_GetPlayers()[var_i].var_f218f8f2["current_gun"] + 1), function_Int(function_GetPlayers()[var_i].var_f218f8f2["xp"]), function_Int(level.var_2d1d6521[function_GetPlayers()[var_i].var_f218f8f2["current_gun"] - 1].var_d8ea7d0f), function_Int(level.var_5e740b8.size));
		}
		else
		{
			self function_LUINotifyEvent(&"ZMBU_info", 6, &"ZM_MINECRAFT_GUN_GAME", var_i, function_Int(function_GetPlayers()[var_i].var_f218f8f2["current_gun"]), function_Int(function_GetPlayers()[var_i].var_f218f8f2["xp"]), function_Int(level.var_2d1d6521[function_GetPlayers()[var_i].var_f218f8f2["current_gun"]].var_d8ea7d0f), function_Int(level.var_5e740b8.size));
		}
		wait(0.05);
	}
	self.var_df17dfe1 = 0;
}

/*
	Name: function_26561004
	Namespace: namespace_c6910797
	Checksum: 0x424F4353
	Offset: 0x2AC0
	Size: 0xA8
	Parameters: 0
	Flags: Private
	Line Number: 585
*/
function private function_26561004()
{
	for(;;)
	{
		level waittill("hash_earned_points", var_player, var_points, var_event);
		switch(var_event)
		{
			case "bonus_points_team":
				break;
			case "deployment_cash":
			case "equip_hacker":
			case "magicbox_bear":
			case "nuke_powerup":
			case "zm_bgb_profit_sharing":
			{
			}
			default
			{
				var_player notify("hash_379210d1", "points_gained", var_points / 5);
			}
		}
	}
}

/*
	Name: function_20c0581b
	Namespace: namespace_c6910797
	Checksum: 0x424F4353
	Offset: 0x2B70
	Size: 0x368
	Parameters: 0
	Flags: Private
	Line Number: 619
*/
function private function_20c0581b()
{
	for(;;)
	{
		level waittill("hash_end_of_round");
		var_c4cf5697 = undefined;
		foreach(var_player in function_GetPlayers())
		{
			if(!isdefined(var_c4cf5697))
			{
				var_c4cf5697 = var_player;
			}
			if(var_player.var_f218f8f2["current_gun"] > var_c4cf5697.var_f218f8f2["current_gun"])
			{
				var_c4cf5697 = var_player;
			}
			var_player notify("hash_379210d1", "round_survived", 15 * level.var_round_number);
		}
		foreach(var_player in function_GetPlayers())
		{
			if(var_player == var_c4cf5697)
			{
				continue;
			}
			var_gap = var_c4cf5697.var_f218f8f2["current_gun"] - var_player.var_f218f8f2["current_gun"];
			if(var_player.var_f218f8f2["current_gun"] < var_c4cf5697.var_f218f8f2["current_gun"] && var_gap == 1 && var_player.var_f218f8f2["xp"] < level.var_2d1d6521[var_player.var_f218f8f2["current_gun"]].var_d8ea7d0f / 3)
			{
				var_player notify("hash_379210d1", "round_survived", level.var_2d1d6521[var_player.var_f218f8f2["current_gun"]].var_d8ea7d0f / 6);
				continue;
			}
			if(var_player.var_f218f8f2["current_gun"] < var_c4cf5697.var_f218f8f2["current_gun"] && var_gap == 2)
			{
				var_player notify("hash_379210d1", "round_survived", level.var_2d1d6521[var_player.var_f218f8f2["current_gun"]].var_d8ea7d0f / 4);
				continue;
			}
			var_player notify("hash_379210d1", "round_survived", level.var_2d1d6521[var_player.var_f218f8f2["current_gun"]].var_d8ea7d0f / 2);
		}
	}
}

/*
	Name: function_de351df
	Namespace: namespace_c6910797
	Checksum: 0x424F4353
	Offset: 0x2EE0
	Size: 0x5E8
	Parameters: 0
	Flags: None
	Line Number: 669
*/
function function_de351df()
{
	self endon("hash_disconnect");
	if(self function_hasPerk("specialty_quickrevive"))
	{
		var_a4db5092 = function_Int(level.var_2d1d6521[self.var_f218f8f2["current_gun"]].var_d8ea7d0f / 6);
	}
	else
	{
		var_a4db5092 = function_Int(level.var_2d1d6521[self.var_f218f8f2["current_gun"]].var_d8ea7d0f / function_randomIntRange(4, 5));
	}
	self.var_65e04c04++;
	self.var_pers["gungame_downs"]++;
	self thread namespace_97ac1184::function_7e18304e("spx_save_data", "gungame_downs", self.var_pers["gungame_downs"], 0);
	var_XP = self.var_f218f8f2["xp"] - var_a4db5092;
	if(var_XP < 0)
	{
		var_af7d80a6 = function_Abs(var_XP);
		if(self.var_f218f8f2["current_gun"] <= 0)
		{
			self.var_f218f8f2["current_gun"] = 0;
		}
		else
		{
			self function_playsoundtoplayer("gun_game_rank_down", self);
			self.var_f218f8f2["current_gun"]--;
		}
		self thread namespace_97ac1184::function_score_event(&"ZM_MINECRAFT_GUN_GAME_DEMOTION", -100);
		self.var_f218f8f2["xp"] = function_Int(level.var_2d1d6521[self.var_f218f8f2["current_gun"]].var_d8ea7d0f - var_af7d80a6);
		self thread function_43efb74a();
	}
	else
	{
		self.var_f218f8f2["xp"] = self.var_f218f8f2["xp"] - var_a4db5092;
		self thread namespace_97ac1184::function_score_event(&"ZM_MINECRAFT_GUN_GAME_XP_LOSS", var_a4db5092 * -1);
	}
	self thread function_d00dd5f5();
	self namespace_zm_laststand::function_increment_downed_stat();
	self namespace_zm_utility::function_increment_ignoreme();
	self.var_7991bdc3 = 1;
	self function_setnormalhealth(1);
	var_a_ai = function_GetAIArray();
	var_aca0d7c7 = function_ArraySortClosest(var_a_ai, self.var_origin, var_a_ai.size, 0, 150);
	foreach(var_ai in var_aca0d7c7)
	{
		if(function_IsActor(var_ai))
		{
			if(var_ai.var_archetype === "zombie")
			{
				function_playFX(level.var__effect["teleport_aoe_kill"], var_ai function_GetTagOrigin("j_spineupper"));
			}
			else
			{
				function_playFX(level.var__effect["teleport_aoe_kill"], var_ai.var_origin);
			}
			var_ai.var_marked_for_recycle = 1;
			var_ai.var_has_been_damaged_by_player = 0;
			var_ai function_DoDamage(var_ai.var_health + 1000, self.var_origin);
		}
	}
	if(self function_hasPerk("specialty_quickrevive"))
	{
		self function_c65ada05("specialty_quickrevive");
		wait(3);
	}
	else
	{
		function_Earthquake(0.7, 1, self.var_origin, 150);
		self function_shellshock("shock_field", 1);
		self namespace_clientfield::function_set("shock_field", 0);
		wait(1);
		self namespace_clientfield::function_set("shock_field", 1);
		wait(2);
	}
	wait(2);
	self namespace_zm_utility::function_decrement_ignoreme();
	self.var_7991bdc3 = 0;
}

/*
	Name: function_c65ada05
	Namespace: namespace_c6910797
	Checksum: 0x424F4353
	Offset: 0x34D0
	Size: 0x60
	Parameters: 1
	Flags: None
	Line Number: 758
*/
function function_c65ada05(var_perk)
{
	var_perk_str = var_perk + "_stop";
	self notify(var_perk_str);
	if(function_use_solo_revive() && var_perk == "specialty_quickrevive")
	{
		self.var_lives--;
	}
}

/*
	Name: function_use_solo_revive
	Namespace: namespace_c6910797
	Checksum: 0x424F4353
	Offset: 0x3538
	Size: 0x90
	Parameters: 0
	Flags: None
	Line Number: 778
*/
function function_use_solo_revive()
{
	if(isdefined(level.var_override_use_solo_revive))
	{
		return [[level.var_override_use_solo_revive]]();
	}
	var_players = function_GetPlayers();
	var_solo_mode = 0;
	if(var_players.size == 1 || (isdefined(level.var_force_solo_quick_revive) && level.var_force_solo_quick_revive))
	{
		var_solo_mode = 1;
	}
	level.var_using_solo_revive = var_solo_mode;
	return var_solo_mode;
}

/*
	Name: function_offhand_weapon_overrride
	Namespace: namespace_c6910797
	Checksum: 0x424F4353
	Offset: 0x35D0
	Size: 0x10
	Parameters: 0
	Flags: None
	Line Number: 804
*/
function function_offhand_weapon_overrride()
{
	level.var_zombie_equipment_player_init = undefined;
}

/*
	Name: function_offhand_weapon_give_override
	Namespace: namespace_c6910797
	Checksum: 0x424F4353
	Offset: 0x35E8
	Size: 0x18
	Parameters: 1
	Flags: None
	Line Number: 819
*/
function function_offhand_weapon_give_override(var_weapon)
{
	self endon("hash_death");
	return 0;
}

/*
	Name: function_giveCustomLoadout
	Namespace: namespace_c6910797
	Checksum: 0x424F4353
	Offset: 0x3608
	Size: 0x30
	Parameters: 2
	Flags: None
	Line Number: 835
*/
function function_giveCustomLoadout(var_TakeAllWeapons, var_alreadySpawned)
{
	self namespace_zm_utility::function_give_start_weapon(0);
}

/*
	Name: function_43efb74a
	Namespace: namespace_c6910797
	Checksum: 0x424F4353
	Offset: 0x3640
	Size: 0x2A0
	Parameters: 0
	Flags: None
	Line Number: 850
*/
function function_43efb74a()
{
	var_Primaries = self function_GetWeaponsListPrimaries();
	var_current_weapon = self function_GetCurrentWeapon();
	foreach(var_weapon in var_Primaries)
	{
		if(var_weapon == var_current_weapon)
		{
			self function_TakeWeapon(var_current_weapon);
			var_7750a3aa = self namespace_5e1f56dc::function_1239e0ad(var_current_weapon);
			if(isdefined(var_7750a3aa))
			{
				function_ArrayRemoveValue(self.var_fb56a719, var_7750a3aa);
			}
		}
	}
	var_weapon = function_GetWeapon(level.var_5e740b8[self.var_f218f8f2["current_gun"]]);
	var_a0dc0ad9 = function_should_upgrade_weapon(self, var_weapon);
	if(isdefined(var_a0dc0ad9) && var_a0dc0ad9)
	{
		if(isdefined(self namespace_5e1f56dc::function_92bf1671(var_weapon)) && self namespace_5e1f56dc::function_92bf1671(var_weapon))
		{
			self namespace_zm_weapons::function_weapon_give(var_weapon, 0, 1);
			var_a76169e6 = self namespace_5e1f56dc::function_49e2047b();
			self thread namespace_5e1f56dc::function_9c955ddd(var_a76169e6, var_weapon);
		}
		else
		{
			self namespace_zm_weapons::function_weapon_give(var_weapon, 0, 1);
		}
	}
	else if(namespace_zm_weapons::function_is_weapon_upgraded(var_weapon))
	{
		self namespace_zm_weapons::function_weapon_give(var_weapon, 0, 1);
	}
	else
	{
		self namespace_zm_weapons::function_weapon_give(var_weapon, 0, 1);
	}
}

/*
	Name: function_should_upgrade_weapon
	Namespace: namespace_c6910797
	Checksum: 0x424F4353
	Offset: 0x38E8
	Size: 0xA0
	Parameters: 2
	Flags: None
	Line Number: 901
*/
function function_should_upgrade_weapon(var_player, var_weapon)
{
	if(level.var_round_number >= 20 && level.var_round_number <= 36)
	{
		var_index = level.var_round_number - 19;
		if(function_randomIntRange(0, 100) < var_index * 15)
		{
		}
		else
		{
			return 0;
		}
	}
	else if(level.var_round_number >= 37)
	{
		return 1;
		return;
	}
}

/*
	Name: function_60d5316b
	Namespace: namespace_c6910797
	Checksum: 0x424F4353
	Offset: 0x3990
	Size: 0x98
	Parameters: 0
	Flags: None
	Line Number: 931
*/
function function_60d5316b()
{
	self endon("hash_disconnect");
	while(1)
	{
		var_6242144b = self function_GetCurrentWeapon();
		self namespace_util::function_waittill_any("reload", "weapon_change");
		if(var_6242144b != self function_GetCurrentWeapon())
		{
			continue;
		}
		self function_giveMaxAmmo(var_6242144b);
	}
}

/*
	Name: function_f431efcb
	Namespace: namespace_c6910797
	Checksum: 0x424F4353
	Offset: 0x3A30
	Size: 0x40
	Parameters: 1
	Flags: None
	Line Number: 956
*/
function function_f431efcb(var_player)
{
	self.var_stub.var_hint_string = "Guns cannot be bought during Gun Game";
	self.var_stub.var_cursor_hint = "HINT_NOICON";
	return 0;
}

/*
	Name: function_delete_triggers
	Namespace: namespace_c6910797
	Checksum: 0x424F4353
	Offset: 0x3A78
	Size: 0x138
	Parameters: 0
	Flags: None
	Line Number: 973
*/
function function_delete_triggers()
{
	foreach(var_trig in function_GetEntArray("craft_pap_zm_craftable_trigger", "targetname"))
	{
		var_trig function_TriggerEnable(0);
	}
	wait(5);
	foreach(var_magicbox in level.var_chests)
	{
		var_magicbox thread namespace_zm_magicbox::function_hide_chest(1);
	}
	return;
	ERROR: Exception occured: Stack empty.
}

/*
	Name: function_70521d40
	Namespace: namespace_c6910797
	Checksum: 0x424F4353
	Offset: 0x3BB8
	Size: 0x7E0
	Parameters: 1
	Flags: Private
	Line Number: 998
*/
function private function_70521d40(var_e_attacker)
{
	if(!isdefined(var_e_attacker) || !function_isPlayer(var_e_attacker) || (isdefined(self.var_nuked) && self.var_nuked))
	{
		return;
	}
	if(isdefined(self.var_42397ab9))
	{
		foreach(var_player in self.var_42397ab9)
		{
			if(var_player != var_e_attacker)
			{
				var_archetype = 0;
				switch(self.var_archetype)
				{
					case "apothicon_fury":
					case "astronaut":
					case "keeper":
					case "keeper_companion":
					case "margwa":
					case "mechz":
					case "monkey":
					case "parasite":
					case "raps":
					case "raz":
					case "spider":
					case "thrasher":
					case "zod_companion":
					case "zombie_quad":
					{
						var_player notify("hash_379210d1", "zombie_special_assist", 50);
						break;
					}
				}
				if(isdefined(self.var_isdog) && self.var_isdog || (isdefined(self.var_archetype) && self.var_archetype == "spider") || (isdefined(self.var_archetype) && self.var_archetype == "monkey"))
				{
					var_player notify("hash_379210d1", "zombie_dog_assist", 5);
					continue;
				}
				var_player notify("hash_379210d1", "zombie_regular_assist", 10);
			}
		}
	}
	switch(var_e_attacker.var_pers["milestone_kills"])
	{
		case 500:
		{
			var_e_attacker notify("hash_379210d1", "zombie_dog_kill", 500);
			break;
		}
		case 750:
		{
			var_e_attacker notify("hash_379210d1", "zombie_dog_kill", 750);
			break;
		}
		case 1000:
		{
			var_e_attacker notify("hash_379210d1", "zombie_dog_kill", 1000);
			break;
		}
		case 1500:
		{
			var_e_attacker notify("hash_379210d1", "zombie_dog_kill", 1500);
			break;
		}
		case 2000:
		{
			var_e_attacker notify("hash_379210d1", "zombie_dog_kill", 2000);
			break;
		}
		case 3000:
		{
			var_e_attacker notify("hash_379210d1", "zombie_dog_kill", 3000);
			break;
		}
		case 4000:
		{
			var_e_attacker notify("hash_379210d1", "zombie_dog_kill", 4000);
			break;
		}
		case 5000:
		{
			var_e_attacker notify("hash_379210d1", "zombie_dog_kill", 5000);
			break;
		}
		case 7500:
		{
			var_e_attacker notify("hash_379210d1", "zombie_dog_kill", 7500);
			break;
		}
		case 10000:
		{
			var_e_attacker notify("hash_379210d1", "zombie_dog_kill", 10000);
			break;
		}
		case 15000:
		{
			var_e_attacker notify("hash_379210d1", "zombie_dog_kill", 15000);
			break;
		}
		case 20000:
		{
			var_e_attacker notify("hash_379210d1", "zombie_dog_kill", 20000);
			break;
		}
		case 30000:
		{
			var_e_attacker notify("hash_379210d1", "zombie_dog_kill", 30000);
			break;
		}
		case 40000:
		{
			var_e_attacker notify("hash_379210d1", "zombie_dog_kill", 40000);
			break;
		}
		case 50000:
		{
			var_e_attacker notify("hash_379210d1", "zombie_dog_kill", 50000);
			break;
		}
		case 75000:
		{
			var_e_attacker notify("hash_379210d1", "zombie_dog_kill", 75000);
			break;
		}
		case 100000:
		{
			var_e_attacker notify("hash_379210d1", "zombie_dog_kill", 100000);
			break;
		}
	}
	switch(self.var_archetype)
	{
		case "apothicon_fury":
		case "astronaut":
		case "keeper":
		case "keeper_companion":
		case "margwa":
		case "mechz":
		case "raz":
		case "thrasher":
		case "zod_companion":
		{
			var_e_attacker notify("hash_379210d1", "zombie_special_kill", 100);
			break;
		}
	}
	if(self.var_damageMod === "MOD_MELEE" || self.var_damageMod === "MOD_MELEE_ASSASSINATE" || self.var_damageMod === "MOD_MELEE_WEAPON_BUTT")
	{
		var_e_attacker notify("hash_379210d1", "melee_kill", 25);
		return;
	}
	if(self.var_damageWeapon.var_8c86d7b3 || self.var_damageWeapon.var_7e163cf8 || namespace_zm_equipment::function_is_equipment(self.var_damageWeapon) || namespace_zm_utility::function_is_placeable_mine(self.var_damageWeapon))
	{
		var_e_attacker notify("hash_379210d1", "equipment_kill", 5);
		return;
	}
	if(self.var_damagelocation === "head" && (!(isdefined(self.var_isdog) && self.var_isdog)) || (self.var_damagelocation === "helmet" && (!(isdefined(self.var_isdog) && self.var_isdog))) || (self.var_damageMod === "MOD_HEAD_SHOT" && (!(isdefined(self.var_isdog) && self.var_isdog))))
	{
		var_e_attacker notify("hash_379210d1", "headshot_kill", 30);
		return;
	}
	if(isdefined(self.var_isdog) && self.var_isdog || (isdefined(self.var_archetype) && self.var_archetype == "spider") || (isdefined(self.var_archetype) && self.var_archetype == "monkey") || (isdefined(self.var_archetype) && self.var_archetype == "parasite") || (isdefined(self.var_archetype) && self.var_archetype == "raps") || (isdefined(self.var_archetype) && self.var_archetype == "zombie_quad"))
	{
		var_e_attacker notify("hash_379210d1", "zombie_dog_kill", 10);
	}
	else
	{
		var_e_attacker notify("hash_379210d1", "zombie_regular_kill", 20);
		return;
	}
}

/*
	Name: function_b8f48865
	Namespace: namespace_c6910797
	Checksum: 0x424F4353
	Offset: 0x43A0
	Size: 0x590
	Parameters: 3
	Flags: None
	Line Number: 1181
*/
function function_b8f48865(var_player, var_game_over, var_survived)
{
	var_game_over.var_alignX = "center";
	var_game_over.var_alignY = "middle";
	var_game_over.var_horzAlign = "center";
	var_game_over.var_vertAlign = "middle";
	var_game_over.var_y = var_game_over.var_y - 180;
	var_game_over.var_foreground = 1;
	var_game_over.var_fontscale = 2.3;
	var_game_over.var_alpha = 0;
	var_game_over.var_color = (1, 1, 1);
	var_game_over.var_hidewheninmenu = 1;
	var_f594237a = undefined;
	foreach(var_player in function_GetPlayers())
	{
		if(!isdefined(var_f594237a) && (isdefined(var_player.var_a67cf276) && var_player.var_a67cf276))
		{
			var_f594237a = var_player;
		}
	}
	if(isdefined(var_player.var_a67cf276) && var_player.var_a67cf276)
	{
		if(var_player.var_65e04c04 <= 0)
		{
			var_game_over function_setText("You've got a Flawless Victory on Gun Game!");
		}
		else
		{
			var_game_over function_setText("You've got a Victory on Gun Game!");
		}
	}
	else if(var_f594237a.var_65e04c04 <= 0)
	{
		var_game_over function_setText(var_f594237a.var_name + " has gotten a Flawless Victory on Gun Game!");
	}
	else
	{
		var_game_over function_setText(var_f594237a.var_name + " has gotten a Victory on Gun Game!");
	}
	var_game_over function_fadeOverTime(1);
	var_game_over.var_alpha = 1;
	if(var_player function_IsSplitscreen())
	{
		var_game_over.var_fontscale = 2;
		var_game_over.var_y = var_game_over.var_y + 40;
	}
	var_survived.var_alignX = "center";
	var_survived.var_alignY = "middle";
	var_survived.var_horzAlign = "center";
	var_survived.var_vertAlign = "middle";
	var_survived.var_y = var_survived.var_y - 150;
	var_survived.var_foreground = 1;
	var_survived.var_fontscale = 1.5;
	var_survived.var_alpha = 0;
	var_survived.var_color = (1, 1, 1);
	var_survived.var_hidewheninmenu = 1;
	if(var_player function_IsSplitscreen())
	{
		var_survived.var_fontscale = 1.5;
		var_survived.var_y = var_survived.var_y + 40;
	}
	if(level.var_round_number < 2)
	{
		if(level.var_script == "zm_moon")
		{
			if(!isdefined(level.var_left_nomans_land))
			{
				var_nomanslandtime = level.var_nml_best_time;
				var_player_survival_time = function_Int(var_nomanslandtime / 1000);
				var_player_survival_time_in_mins = namespace_zm::function_to_mins(var_player_survival_time);
				var_survived function_setText(&"ZOMBIE_SURVIVED_NOMANS", var_player_survival_time_in_mins);
			}
			else if(level.var_left_nomans_land == 2)
			{
				var_survived function_setText(&"ZOMBIE_SURVIVED_ROUND");
			}
		}
		else
		{
			var_survived function_setText(&"ZOMBIE_SURVIVED_ROUND");
		}
	}
	else
	{
		var_survived function_setText(&"ZOMBIE_SURVIVED_ROUNDS", level.var_round_number);
	}
	var_survived function_fadeOverTime(1);
	var_survived.var_alpha = 1;
}

