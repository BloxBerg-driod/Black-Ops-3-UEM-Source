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
	Name: __init__sytem__
	Namespace: namespace_c6910797
	Checksum: 0x424F4353
	Offset: 0xC18
	Size: 0x38
	Parameters: 0
	Flags: AutoExec
	Line Number: 43
*/
function autoexec __init__sytem__()
{
	system::register("zm_gungame", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: namespace_c6910797
	Checksum: 0x424F4353
	Offset: 0xC58
	Size: 0x8D0
	Parameters: 0
	Flags: None
	Line Number: 58
*/
function __init__()
{
	if(!isdefined(level.var_90d57b96))
	{
		level.var_90d57b96 = int(0);
	}
	if(!isdefined(level.var_b1cf1e73))
	{
		level.var_b1cf1e73 = int(0);
	}
	if(!isdefined(level.var_9ff42471))
	{
		level.var_9ff42471 = int(0);
	}
	level flag::init("gun_game_active");
	wait(0.05);
	level flag::wait_till("allow_gungame");
	if(tolower(getdvarstring("mapname")) != "zm_tranzit_busdepot")
	{
		level.var_2d1d6521 = [];
		level thread function_3363a1ee();
		level.var_c181264f = 1;
		level flag::set("gun_game_active");
		callback::on_connect(&function_e8c29a80);
		callback::on_spawned(&on_player_spawned);
		zm_spawner::register_zombie_death_event_callback(&function_70521d40);
		level thread function_26561004();
		level thread function_20c0581b();
		level thread function_c2bf8a3e();
		level.func_override_wallbuy_prompt = &function_f431efcb;
		level thread delete_triggers();
		level.dog_rounds_allowed = 0;
		level.lastStandGetupAllowed = 1;
		level.whoswho_laststand_func = &function_de351df;
		level.var_5e740b8 = array();
		level.var_d4977bde = array("pistol_standard", "pistol_burst", "pistol_fullauto");
		level.var_a6dfbcba = array("sniper_fastbolt", "sniper_powerbolt", "sniper_fastsemi");
		level.var_db2e32a7 = array("shotgun_pump", "shotgun_precision", "shotgun_fullauto", "shotgun_energy", "shotgun_semiauto");
		level.var_244a19ad = array("lmg_cqb", "lmg_light", "lmg_heavy");
		if(isdefined(level.var_3e85df60) && level.var_3e85df60)
		{
			level.var_87f0fce = array("smg_longrange", "ar_damage", "ar_longburst", "ar_marksman", "ar_standard", "ar_cqb", "ar_accurate", "ar_stg44");
			level.var_3c0604e2 = array("smg_burst", "smg_capacity", "smg_fastfire", "smg_standard", "smg_versatile");
			level.var_3185f12 = array("ray_gun");
		}
		else
		{
			level.var_87f0fce = array("smg_longrange", "ar_damage", "ar_longburst", "ar_marksman", "ar_standard", "ar_cqb", "ar_accurate");
			level.var_3c0604e2 = array("smg_burst", "smg_capacity", "smg_fastfire", "smg_standard", "smg_versatile", "smg_ppsh", "smg_thompson", "smg_mp40_1940");
			level.var_3185f12 = array("t9_crossbow_skull", "ray_gun", "t9_gallo_raygun");
		}
		if(isdefined(level.var_9ff42471) && level.var_9ff42471 == 2)
		{
			level.var_d4977bde = array::randomize(level.var_d4977bde);
			level.var_3c0604e2 = array::randomize(level.var_3c0604e2);
			level.var_a6dfbcba = array::randomize(level.var_a6dfbcba);
			level.var_db2e32a7 = array::randomize(level.var_db2e32a7);
			level.var_87f0fce = array::randomize(level.var_87f0fce);
			level.var_244a19ad = array::randomize(level.var_244a19ad);
			level.var_3185f12 = array::randomize(level.var_3185f12);
		}
		level.var_5e740b8 = arraycombine(level.var_5e740b8, level.var_d4977bde, 0, 0);
		level.var_5e740b8 = arraycombine(level.var_5e740b8, level.var_3c0604e2, 0, 0);
		level.var_5e740b8 = arraycombine(level.var_5e740b8, level.var_a6dfbcba, 0, 0);
		level.var_5e740b8 = arraycombine(level.var_5e740b8, level.var_db2e32a7, 0, 0);
		level.var_5e740b8 = arraycombine(level.var_5e740b8, level.var_87f0fce, 0, 0);
		level.var_5e740b8 = arraycombine(level.var_5e740b8, level.var_244a19ad, 0, 0);
		level.var_5e740b8 = arraycombine(level.var_5e740b8, level.var_3185f12, 0, 0);
		if(isdefined(level.var_9ff42471) && level.var_9ff42471 == 3)
		{
			level.var_5e740b8 = array::randomize(level.var_5e740b8);
		}
		if(isdefined(level.var_90d57b96) && level.var_90d57b96 == 1)
		{
			level.var_83972a9b = array();
			for(i = 0; i < level.var_5e740b8.size; i++)
			{
				weapon = getweapon(level.var_5e740b8[i]);
				if(isdefined(level.zombie_weapons[weapon]) && isdefined(level.zombie_weapons[weapon].upgrade))
				{
					level.var_83972a9b[i] = level.zombie_weapons[weapon].upgrade.name;
				}
			}
			if(isdefined(level.var_9ff42471) && level.var_9ff42471 == 3)
			{
				level.var_83972a9b = array::randomize(level.var_83972a9b);
			}
			level.var_5e740b8 = arraycombine(level.var_5e740b8, level.var_83972a9b, 0, 0);
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
	self endon("disconnect");
	var_a42d1f45 = array("specialty_staminup", "specialty_deadshot", "specialty_fastreload", "specialty_armorvest", "specialty_doubletap2", "specialty_electriccherry");
	var_a42d1f45 = array::randomize(var_a42d1f45);
	total_time = 0;
	for(;;)
	{
		wait(1);
		total_time++;
		switch(total_time)
		{
			case 300:
			{
				foreach(player in getplayers())
				{
					if(!player hasperk(var_a42d1f45[0]))
					{
						player zm_perks::give_perk(var_a42d1f45[0], 0);
					}
				}
				break;
			}
			case 500:
			{
				foreach(player in getplayers())
				{
					if(!player hasperk(var_a42d1f45[1]))
					{
						player zm_perks::give_perk(var_a42d1f45[1], 0);
					}
				}
				break;
			}
			case 700:
			{
				foreach(player in getplayers())
				{
					if(!player hasperk(var_a42d1f45[2]))
					{
						player zm_perks::give_perk(var_a42d1f45[2], 0);
					}
				}
				break;
			}
			case 900:
			{
				foreach(player in getplayers())
				{
					if(!player hasperk(var_a42d1f45[3]))
					{
						player zm_perks::give_perk(var_a42d1f45[3], 0);
					}
				}
				break;
			}
			case 1100:
			{
				foreach(player in getplayers())
				{
					if(!player hasperk(var_a42d1f45[4]))
					{
						player zm_perks::give_perk(var_a42d1f45[4], 0);
					}
				}
				break;
			}
			case 1300:
			{
				foreach(player in getplayers())
				{
					if(!player hasperk(var_a42d1f45[5]))
					{
						player zm_perks::give_perk(var_a42d1f45[5], 0);
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
	index = 1;
	table = "gamedata/weapons/damage_multiplier/zm_gungame_stats.csv";
	for(row = tablelookuprow(table, index); isdefined(row); row = tablelookuprow(table, index))
	{
		var_34c9778a = int(checkStringValid(row[0]));
		var_d8ea7d0f = int(checkStringValid(row[1]));
		if(isdefined(var_34c9778a))
		{
			level.var_2d1d6521[var_34c9778a] = spawnstruct();
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
		index++;
	}
}

/*
	Name: checkStringValid
	Namespace: namespace_c6910797
	Checksum: 0x424F4353
	Offset: 0x1D48
	Size: 0x28
	Parameters: 1
	Flags: None
	Line Number: 303
*/
function checkStringValid(str)
{
	if(str != "")
	{
		return str;
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
	self endon("disconnect");
	self thread function_97c95414();
	if(!isdefined(level.var_5e740b8))
	{
		while(!isdefined(level.var_5e740b8))
		{
			wait(0.05);
			iprintlnbold("Not working; Try restarting Gun Game");
		}
	}
	self.var_f218f8f2 = [];
	self.var_f218f8f2["xp"] = int(0);
	self.var_f218f8f2["current_gun"] = int(0);
	return;
}

/*
	Name: on_player_spawned
	Namespace: namespace_c6910797
	Checksum: 0x424F4353
	Offset: 0x1E40
	Size: 0xF0
	Parameters: 0
	Flags: None
	Line Number: 350
*/
function on_player_spawned()
{
	wait(2);
	self thread function_d00dd5f5();
	self thread function_60d5316b();
	self thread function_eae0487c();
	self thread function_1e0b6d79();
	if(level.round_number <= 2)
	{
		self.var_f218f8f2["current_gun"] = int(0);
	}
	else
	{
		self.var_f218f8f2["current_gun"] = int(zm_utility::round_up_score(level.round_number / 2, 1));
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
	Line Number: 377
*/
function function_97c95414()
{
	self endon("disconnect");
	for(;;)
	{
		self setperk("specialty_whoswho");
		self.lives = 999999;
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
	Line Number: 398
*/
function function_eae0487c()
{
	self endon("disconnect");
	for(;;)
	{
		wait(0.2);
		current_weapon = getweapon(level.var_5e740b8[self.var_f218f8f2["current_gun"]]);
		w_weapon = self getcurrentweapon();
		if(isdefined(w_weapon) && w_weapon != current_weapon)
		{
			if(isdefined(w_weapon function_baa39e24(self)) && w_weapon function_baa39e24(self))
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
	Line Number: 430
*/
function function_baa39e24(player)
{
	if(self != level.zombie_weapons[getweapon(level.var_5e740b8[self.var_f218f8f2["current_gun"]])].upgrade)
	{
		return 1;
	}
	if(level._custom_perks.size > 0)
	{
		a_keys = getarraykeys(level._custom_perks);
		for(i = 0; i < a_keys.size; i++)
		{
			if(isdefined(level._custom_perks[a_keys[i]].perk_bottle_weapon) && self == level._custom_perks[a_keys[i]].perk_bottle_weapon)
			{
				return 1;
				break;
			}
		}
	}
	else if(player IsThrowingGrenade() || player fragbuttonpressed() || player secondaryoffhandbuttonpressed() || player ismeleeing())
	{
		return 1;
	}
	if(player flag::exists("in_beastmode") && player flag::get("in_beastmode"))
	{
		return 1;
	}
	if(self.isRiotShield)
	{
		return 1;
	}
	if(self.name == "equip_hacker" || self.name == "equip_gasmask")
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
	Line Number: 476
*/
function function_1e0b6d79()
{
	self endon("disconnect");
	self.var_a67cf276 = 0;
	self.var_65e04c04 = int(0);
	while(1)
	{
		self waittill("hash_379210d1", type, XP);
		self.var_f218f8f2["xp"] = self.var_f218f8f2["xp"] + XP;
		self thread function_d00dd5f5();
		if(self.var_f218f8f2["xp"] >= level.var_2d1d6521[self.var_f218f8f2["current_gun"]].var_d8ea7d0f)
		{
			if(self.var_f218f8f2["current_gun"] + 1 > level.var_5e740b8.size - 1)
			{
				self.var_a67cf276 = 1;
				self.var_f218f8f2["xp"] = level.var_2d1d6521[self.var_f218f8f2["current_gun"]].var_d8ea7d0f;
				self.var_f218f8f2["current_gun"]++;
				self thread function_d00dd5f5();
				level.custom_game_over_hud_elem = &function_b8f48865;
				level flag::clear("spawn_zombies");
				a_ai_enemies = getaiteamarray("axis");
				foreach(ai_enemy in a_ai_enemies)
				{
					level.zombie_total++;
					level.zombie_respawns++;
					ai_enemy dodamage(ai_enemy.health + 666, ai_enemy.origin);
				}
				if(isdefined(self.var_a67cf276) && self.var_a67cf276)
				{
					if(self.var_65e04c04 <= 0)
					{
						self.pers["gungame_flawless_wins"]++;
						self thread namespace_97ac1184::function_7e18304e("spx_save_data", "gungame_flawless_wins", self.pers["gungame_flawless_wins"], 0);
					}
					else
					{
						self.pers["gungame_wins"]++;
						self thread namespace_97ac1184::function_7e18304e("spx_save_data", "gungame_wins", self.pers["gungame_wins"], 0);
					}
				}
				foreach(player in getplayers())
				{
					if(!(isdefined(player.var_a67cf276) && player.var_a67cf276))
					{
						player.pers["gungame_losses"]++;
						player thread namespace_97ac1184::function_7e18304e("spx_save_data", "gungame_losses", player.pers["gungame_losses"], 0);
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
				self thread namespace_97ac1184::function_b3489bf5("^3" + self.playername + "^7 obtained the next gun ^9" + self.var_f218f8f2["current_gun"] + "/" + int(level.var_5e740b8.size));
				self.var_f218f8f2["xp"] = 0;
				self playsoundtoplayer("gun_game_rank_up", self);
				self thread namespace_97ac1184::score_event(&"ZM_MINECRAFT_GUN_GAME_PROMOTION", 100);
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
	Line Number: 557
*/
function function_d00dd5f5()
{
	wait(0.05);
	self.var_df17dfe1 = 1;
	for(i = 0; i < getdvarint("com_maxclients"); i++)
	{
		if(self.var_a67cf276)
		{
			self luinotifyevent(&"ZMBU_info", 6, &"ZM_MINECRAFT_GUN_GAME", i, int(getplayers()[i].var_f218f8f2["current_gun"] + 1), int(getplayers()[i].var_f218f8f2["xp"]), int(level.var_2d1d6521[getplayers()[i].var_f218f8f2["current_gun"] - 1].var_d8ea7d0f), int(level.var_5e740b8.size));
		}
		else
		{
			self luinotifyevent(&"ZMBU_info", 6, &"ZM_MINECRAFT_GUN_GAME", i, int(getplayers()[i].var_f218f8f2["current_gun"]), int(getplayers()[i].var_f218f8f2["xp"]), int(level.var_2d1d6521[getplayers()[i].var_f218f8f2["current_gun"]].var_d8ea7d0f), int(level.var_5e740b8.size));
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
	Line Number: 586
*/
function private function_26561004()
{
	for(;;)
	{
		level waittill("earned_points", player, points, event);
		switch(event)
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
				player notify("hash_379210d1", "points_gained", points / 5);
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
	Line Number: 620
*/
function private function_20c0581b()
{
	for(;;)
	{
		level waittill("end_of_round");
		var_c4cf5697 = undefined;
		foreach(player in getplayers())
		{
			if(!isdefined(var_c4cf5697))
			{
				var_c4cf5697 = player;
			}
			if(player.var_f218f8f2["current_gun"] > var_c4cf5697.var_f218f8f2["current_gun"])
			{
				var_c4cf5697 = player;
			}
			player notify("hash_379210d1", "round_survived", 15 * level.round_number);
		}
		foreach(player in getplayers())
		{
			if(player == var_c4cf5697)
			{
				continue;
			}
			gap = var_c4cf5697.var_f218f8f2["current_gun"] - player.var_f218f8f2["current_gun"];
			if(player.var_f218f8f2["current_gun"] < var_c4cf5697.var_f218f8f2["current_gun"] && gap == 1 && player.var_f218f8f2["xp"] < level.var_2d1d6521[player.var_f218f8f2["current_gun"]].var_d8ea7d0f / 3)
			{
				player notify("hash_379210d1", "round_survived", level.var_2d1d6521[player.var_f218f8f2["current_gun"]].var_d8ea7d0f / 6);
				continue;
			}
			if(player.var_f218f8f2["current_gun"] < var_c4cf5697.var_f218f8f2["current_gun"] && gap == 2)
			{
				player notify("hash_379210d1", "round_survived", level.var_2d1d6521[player.var_f218f8f2["current_gun"]].var_d8ea7d0f / 4);
				continue;
			}
			player notify("hash_379210d1", "round_survived", level.var_2d1d6521[player.var_f218f8f2["current_gun"]].var_d8ea7d0f / 2);
		}
	}
	return;
	ERROR: Exception occured: Stack empty.
}

/*
	Name: function_de351df
	Namespace: namespace_c6910797
	Checksum: 0x424F4353
	Offset: 0x2EE0
	Size: 0x5D0
	Parameters: 0
	Flags: None
	Line Number: 672
*/
function function_de351df()
{
	self endon("disconnect");
	if(self hasperk("specialty_quickrevive"))
	{
		var_a4db5092 = int(level.var_2d1d6521[self.var_f218f8f2["current_gun"]].var_d8ea7d0f / 6);
	}
	else
	{
		var_a4db5092 = int(level.var_2d1d6521[self.var_f218f8f2["current_gun"]].var_d8ea7d0f / randomintrange(4, 5));
	}
	self.var_65e04c04++;
	self.pers["gungame_downs"]++;
	self thread namespace_97ac1184::function_7e18304e("spx_save_data", "gungame_downs", self.pers["gungame_downs"], 0);
	XP = self.var_f218f8f2["xp"] - var_a4db5092;
	if(XP < 0)
	{
		var_af7d80a6 = abs(XP);
		if(self.var_f218f8f2["current_gun"] <= 0)
		{
			self.var_f218f8f2["current_gun"] = 0;
		}
		else
		{
			self playsoundtoplayer("gun_game_rank_down", self);
			self.var_f218f8f2["current_gun"]--;
		}
		self thread namespace_97ac1184::score_event(&"ZM_MINECRAFT_GUN_GAME_DEMOTION", -100);
		self.var_f218f8f2["xp"] = int(level.var_2d1d6521[self.var_f218f8f2["current_gun"]].var_d8ea7d0f - var_af7d80a6);
		self thread function_43efb74a();
	}
	else
	{
		self.var_f218f8f2["xp"] = self.var_f218f8f2["xp"] - var_a4db5092;
		self thread namespace_97ac1184::score_event(&"ZM_MINECRAFT_GUN_GAME_XP_LOSS", var_a4db5092 * -1);
	}
	self thread function_d00dd5f5();
	self zm_laststand::increment_downed_stat();
	self zm_utility::increment_ignoreme();
	self setnormalhealth(1);
	a_ai = getaiarray();
	var_aca0d7c7 = arraysortclosest(a_ai, self.origin, a_ai.size, 0, 150);
	foreach(ai in var_aca0d7c7)
	{
		if(IsActor(ai))
		{
			if(ai.archetype === "zombie")
			{
				playfx(level._effect["teleport_aoe_kill"], ai gettagorigin("j_spineupper"));
			}
			else
			{
				playfx(level._effect["teleport_aoe_kill"], ai.origin);
			}
			ai.marked_for_recycle = 1;
			ai.has_been_damaged_by_player = 0;
			ai dodamage(ai.health + 1000, self.origin);
		}
	}
	if(self hasperk("specialty_quickrevive"))
	{
		self function_c65ada05("specialty_quickrevive");
		wait(3);
	}
	else
	{
		earthquake(0.7, 1, self.origin, 150);
		self shellshock("shock_field", 1);
		self clientfield::set("shock_field", 0);
		wait(1);
		self clientfield::set("shock_field", 1);
		wait(2);
	}
	wait(2);
	self zm_utility::decrement_ignoreme();
	return;
}

/*
	Name: function_c65ada05
	Namespace: namespace_c6910797
	Checksum: 0x424F4353
	Offset: 0x34B8
	Size: 0x60
	Parameters: 1
	Flags: None
	Line Number: 760
*/
function function_c65ada05(perk)
{
	perk_str = perk + "_stop";
	self notify(perk_str);
	if(use_solo_revive() && perk == "specialty_quickrevive")
	{
		self.lives--;
	}
}

/*
	Name: use_solo_revive
	Namespace: namespace_c6910797
	Checksum: 0x424F4353
	Offset: 0x3520
	Size: 0x90
	Parameters: 0
	Flags: None
	Line Number: 780
*/
function use_solo_revive()
{
	if(isdefined(level.override_use_solo_revive))
	{
		return [[level.override_use_solo_revive]]();
	}
	players = getplayers();
	solo_mode = 0;
	if(players.size == 1 || (isdefined(level.force_solo_quick_revive) && level.force_solo_quick_revive))
	{
		solo_mode = 1;
	}
	level.using_solo_revive = solo_mode;
	return solo_mode;
}

/*
	Name: offhand_weapon_overrride
	Namespace: namespace_c6910797
	Checksum: 0x424F4353
	Offset: 0x35B8
	Size: 0x10
	Parameters: 0
	Flags: None
	Line Number: 806
*/
function offhand_weapon_overrride()
{
	level.zombie_equipment_player_init = undefined;
	return;
	ERROR: Bad function call
}

/*
	Name: offhand_weapon_give_override
	Namespace: namespace_c6910797
	Checksum: 0x424F4353
	Offset: 0x35D0
	Size: 0x18
	Parameters: 1
	Flags: None
	Line Number: 823
*/
function offhand_weapon_give_override(weapon)
{
	self endon("death");
	return 0;
}

/*
	Name: giveCustomLoadout
	Namespace: namespace_c6910797
	Checksum: 0x424F4353
	Offset: 0x35F0
	Size: 0x30
	Parameters: 2
	Flags: None
	Line Number: 839
*/
function giveCustomLoadout(takeallweapons, alreadyspawned)
{
	self zm_utility::give_start_weapon(0);
}

/*
	Name: function_43efb74a
	Namespace: namespace_c6910797
	Checksum: 0x424F4353
	Offset: 0x3628
	Size: 0x2A0
	Parameters: 0
	Flags: None
	Line Number: 854
*/
function function_43efb74a()
{
	Primaries = self getweaponslistprimaries();
	current_weapon = self getcurrentweapon();
	foreach(weapon in Primaries)
	{
		if(weapon == current_weapon)
		{
			self takeweapon(current_weapon);
			var_7750a3aa = self namespace_5e1f56dc::function_1239e0ad(current_weapon);
			if(isdefined(var_7750a3aa))
			{
				arrayremovevalue(self.var_fb56a719, var_7750a3aa);
			}
		}
	}
	weapon = getweapon(level.var_5e740b8[self.var_f218f8f2["current_gun"]]);
	var_a0dc0ad9 = should_upgrade_weapon(self, weapon);
	if(isdefined(var_a0dc0ad9) && var_a0dc0ad9)
	{
		if(isdefined(self namespace_5e1f56dc::function_92bf1671(weapon)) && self namespace_5e1f56dc::function_92bf1671(weapon))
		{
			self zm_weapons::weapon_give(weapon, 0, 1);
			var_a76169e6 = self namespace_5e1f56dc::function_49e2047b();
			self thread namespace_5e1f56dc::function_9c955ddd(var_a76169e6, weapon);
		}
		else
		{
			self zm_weapons::weapon_give(weapon, 0, 1);
		}
	}
	else if(zm_weapons::is_weapon_upgraded(weapon))
	{
		self zm_weapons::weapon_give(weapon, 0, 1);
	}
	else
	{
		self zm_weapons::weapon_give(weapon, 0, 1);
		return;
	}
}

/*
	Name: should_upgrade_weapon
	Namespace: namespace_c6910797
	Checksum: 0x424F4353
	Offset: 0x38D0
	Size: 0xA0
	Parameters: 2
	Flags: None
	Line Number: 906
*/
function should_upgrade_weapon(player, weapon)
{
	if(level.round_number >= 20 && level.round_number <= 36)
	{
		index = level.round_number - 19;
		if(randomintrange(0, 100) < index * 15)
		{
		}
		else
		{
			return 0;
		}
	}
	else if(level.round_number >= 37)
	{
		return 1;
	}
}

/*
	Name: function_60d5316b
	Namespace: namespace_c6910797
	Checksum: 0x424F4353
	Offset: 0x3978
	Size: 0x98
	Parameters: 0
	Flags: None
	Line Number: 935
*/
function function_60d5316b()
{
	self endon("disconnect");
	while(1)
	{
		var_6242144b = self getcurrentweapon();
		self util::waittill_any("reload", "weapon_change");
		if(var_6242144b != self getcurrentweapon())
		{
			continue;
		}
		self givemaxammo(var_6242144b);
	}
}

/*
	Name: function_f431efcb
	Namespace: namespace_c6910797
	Checksum: 0x424F4353
	Offset: 0x3A18
	Size: 0x40
	Parameters: 1
	Flags: None
	Line Number: 960
*/
function function_f431efcb(player)
{
	self.stub.hint_string = "Guns cannot be bought during Gun Game";
	self.stub.cursor_hint = "HINT_NOICON";
	return 0;
}

/*
	Name: delete_triggers
	Namespace: namespace_c6910797
	Checksum: 0x424F4353
	Offset: 0x3A60
	Size: 0x138
	Parameters: 0
	Flags: None
	Line Number: 977
*/
function delete_triggers()
{
	foreach(trig in getentarray("craft_pap_zm_craftable_trigger", "targetname"))
	{
		trig triggerenable(0);
	}
	wait(5);
	foreach(magicbox in level.chests)
	{
		magicbox thread zm_magicbox::hide_chest(1);
	}
	return;
	ERROR: Exception occured: Stack empty.
}

/*
	Name: function_70521d40
	Namespace: namespace_c6910797
	Checksum: 0x424F4353
	Offset: 0x3BA0
	Size: 0x7E0
	Parameters: 1
	Flags: Private
	Line Number: 1002
*/
function private function_70521d40(e_attacker)
{
	if(!isdefined(e_attacker) || !isplayer(e_attacker) || (isdefined(self.nuked) && self.nuked))
	{
		return;
	}
	if(isdefined(self.var_42397ab9))
	{
		foreach(player in self.var_42397ab9)
		{
			if(player != e_attacker)
			{
				archetype = 0;
				switch(self.archetype)
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
						player notify("hash_379210d1", "zombie_special_assist", 50);
						break;
					}
				}
				if(isdefined(self.isdog) && self.isdog || (isdefined(self.archetype) && self.archetype == "spider") || (isdefined(self.archetype) && self.archetype == "monkey"))
				{
					player notify("hash_379210d1", "zombie_dog_assist", 5);
					continue;
				}
				player notify("hash_379210d1", "zombie_regular_assist", 10);
			}
		}
	}
	switch(e_attacker.pers["milestone_kills"])
	{
		case 500:
		{
			e_attacker notify("hash_379210d1", "zombie_dog_kill", 500);
			break;
		}
		case 750:
		{
			e_attacker notify("hash_379210d1", "zombie_dog_kill", 750);
			break;
		}
		case 1000:
		{
			e_attacker notify("hash_379210d1", "zombie_dog_kill", 1000);
			break;
		}
		case 1500:
		{
			e_attacker notify("hash_379210d1", "zombie_dog_kill", 1500);
			break;
		}
		case 2000:
		{
			e_attacker notify("hash_379210d1", "zombie_dog_kill", 2000);
			break;
		}
		case 3000:
		{
			e_attacker notify("hash_379210d1", "zombie_dog_kill", 3000);
			break;
		}
		case 4000:
		{
			e_attacker notify("hash_379210d1", "zombie_dog_kill", 4000);
			break;
		}
		case 5000:
		{
			e_attacker notify("hash_379210d1", "zombie_dog_kill", 5000);
			break;
		}
		case 7500:
		{
			e_attacker notify("hash_379210d1", "zombie_dog_kill", 7500);
			break;
		}
		case 10000:
		{
			e_attacker notify("hash_379210d1", "zombie_dog_kill", 10000);
			break;
		}
		case 15000:
		{
			e_attacker notify("hash_379210d1", "zombie_dog_kill", 15000);
			break;
		}
		case 20000:
		{
			e_attacker notify("hash_379210d1", "zombie_dog_kill", 20000);
			break;
		}
		case 30000:
		{
			e_attacker notify("hash_379210d1", "zombie_dog_kill", 30000);
			break;
		}
		case 40000:
		{
			e_attacker notify("hash_379210d1", "zombie_dog_kill", 40000);
			break;
		}
		case 50000:
		{
			e_attacker notify("hash_379210d1", "zombie_dog_kill", 50000);
			break;
		}
		case 75000:
		{
			e_attacker notify("hash_379210d1", "zombie_dog_kill", 75000);
			break;
		}
		case 100000:
		{
			e_attacker notify("hash_379210d1", "zombie_dog_kill", 100000);
			break;
		}
	}
	switch(self.archetype)
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
			e_attacker notify("hash_379210d1", "zombie_special_kill", 100);
			break;
		}
	}
	if(self.damageMod === "MOD_MELEE" || self.damageMod === "MOD_MELEE_ASSASSINATE" || self.damageMod === "MOD_MELEE_WEAPON_BUTT")
	{
		e_attacker notify("hash_379210d1", "melee_kill", 25);
		return;
	}
	if(self.damageWeapon.var_8c86d7b3 || self.damageWeapon.var_7e163cf8 || zm_equipment::is_equipment(self.damageWeapon) || zm_utility::is_placeable_mine(self.damageWeapon))
	{
		e_attacker notify("hash_379210d1", "equipment_kill", 5);
		return;
	}
	if(self.damagelocation === "head" && (!(isdefined(self.isdog) && self.isdog)) || (self.damagelocation === "helmet" && (!(isdefined(self.isdog) && self.isdog))) || (self.damageMod === "MOD_HEAD_SHOT" && (!(isdefined(self.isdog) && self.isdog))))
	{
		e_attacker notify("hash_379210d1", "headshot_kill", 30);
		return;
	}
	if(isdefined(self.isdog) && self.isdog || (isdefined(self.archetype) && self.archetype == "spider") || (isdefined(self.archetype) && self.archetype == "monkey") || (isdefined(self.archetype) && self.archetype == "parasite") || (isdefined(self.archetype) && self.archetype == "raps") || (isdefined(self.archetype) && self.archetype == "zombie_quad"))
	{
		e_attacker notify("hash_379210d1", "zombie_dog_kill", 10);
	}
	else
	{
		e_attacker notify("hash_379210d1", "zombie_regular_kill", 20);
		return;
	}
}

/*
	Name: function_b8f48865
	Namespace: namespace_c6910797
	Checksum: 0x424F4353
	Offset: 0x4388
	Size: 0x590
	Parameters: 3
	Flags: None
	Line Number: 1185
*/
function function_b8f48865(player, game_over, survived)
{
	game_over.alignx = "center";
	game_over.aligny = "middle";
	game_over.horzalign = "center";
	game_over.vertalign = "middle";
	game_over.y = game_over.y - 180;
	game_over.foreground = 1;
	game_over.fontscale = 2.3;
	game_over.alpha = 0;
	game_over.color = (1, 1, 1);
	game_over.hidewheninmenu = 1;
	var_f594237a = undefined;
	foreach(player in getplayers())
	{
		if(!isdefined(var_f594237a) && (isdefined(player.var_a67cf276) && player.var_a67cf276))
		{
			var_f594237a = player;
		}
	}
	if(isdefined(player.var_a67cf276) && player.var_a67cf276)
	{
		if(player.var_65e04c04 <= 0)
		{
			game_over settext("You've got a Flawless Victory on Gun Game!");
		}
		else
		{
			game_over settext("You've got a Victory on Gun Game!");
		}
	}
	else if(var_f594237a.var_65e04c04 <= 0)
	{
		game_over settext(var_f594237a.name + " has gotten a Flawless Victory on Gun Game!");
	}
	else
	{
		game_over settext(var_f594237a.name + " has gotten a Victory on Gun Game!");
	}
	game_over fadeovertime(1);
	game_over.alpha = 1;
	if(player issplitscreen())
	{
		game_over.fontscale = 2;
		game_over.y = game_over.y + 40;
	}
	survived.alignx = "center";
	survived.aligny = "middle";
	survived.horzalign = "center";
	survived.vertalign = "middle";
	survived.y = survived.y - 150;
	survived.foreground = 1;
	survived.fontscale = 1.5;
	survived.alpha = 0;
	survived.color = (1, 1, 1);
	survived.hidewheninmenu = 1;
	if(player issplitscreen())
	{
		survived.fontscale = 1.5;
		survived.y = survived.y + 40;
	}
	if(level.round_number < 2)
	{
		if(level.script == "zm_moon")
		{
			if(!isdefined(level.left_nomans_land))
			{
				nomanslandtime = level.nml_best_time;
				player_survival_time = int(nomanslandtime / 1000);
				player_survival_time_in_mins = zm::to_mins(player_survival_time);
				survived settext(&"ZOMBIE_SURVIVED_NOMANS", player_survival_time_in_mins);
			}
			else if(level.left_nomans_land == 2)
			{
				survived settext(&"ZOMBIE_SURVIVED_ROUND");
			}
		}
		else
		{
			survived settext(&"ZOMBIE_SURVIVED_ROUND");
		}
	}
	else
	{
		survived settext(&"ZOMBIE_SURVIVED_ROUNDS", level.round_number);
	}
	survived fadeovertime(1);
	survived.alpha = 1;
}

