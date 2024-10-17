#include scripts\codescripts\struct;
#include scripts\shared\aat_shared;
#include scripts\shared\ai\zombie_utility;
#include scripts\shared\array_shared;
#include scripts\shared\callbacks_shared;
#include scripts\shared\clientfield_shared;
#include scripts\shared\compass;
#include scripts\shared\flag_shared;
#include scripts\shared\gameobjects_shared;
#include scripts\shared\laststand_shared;
#include scripts\shared\scene_shared;
#include scripts\shared\spawner_shared;
#include scripts\shared\system_shared;
#include scripts\shared\util_shared;
#include scripts\sphynx\leveling\_zm_sphynx_leveling;
#include scripts\sphynx\perks\_zm_perk_frost_brew;
#include scripts\zm\_zm;
#include scripts\zm\_zm_audio;
#include scripts\zm\_zm_bgb;
#include scripts\zm\_zm_equipment;
#include scripts\zm\_zm_hero_weapon;
#include scripts\zm\_zm_magicbox;
#include scripts\zm\_zm_pack_a_punch_util;
#include scripts\zm\_zm_score;
#include scripts\zm\_zm_spawner;
#include scripts\zm\_zm_stats;
#include scripts\zm\_zm_unitrigger;
#include scripts\zm\_zm_utility;
#include scripts\zm\_zm_weapons;
#include scripts\zm\gametypes\_globallogic;
#include scripts\zm\gametypes\_globallogic_score;
#include scripts\zm\gametypes\_globallogic_vehicle;

#namespace namespace_5e1f56dc;

/*
	Name: __init__sytem__
	Namespace: namespace_5e1f56dc
	Checksum: 0x424F4353
	Offset: 0x1F60
	Size: 0x40
	Parameters: 0
	Flags: AutoExec
	Line Number: 45
*/
function autoexec __init__sytem__()
{
	system::register("zm_weapon_upgrade_system", &__init__, &__main__, undefined);
}

/*
	Name: __init__
	Namespace: namespace_5e1f56dc
	Checksum: 0x424F4353
	Offset: 0x1FA8
	Size: 0xC58
	Parameters: 0
	Flags: None
	Line Number: 60
*/
function __init__()
{
	clientfield::register("scriptmover", "weapon_drop_enable_keyline", 1, 1, "int");
	if(tolower(getdvarstring("mapname")) != "zm_castle")
	{
		clientfield::register("scriptmover", "weapon_drop_unpacked_fx", 1, 1, "int");
		clientfield::register("scriptmover", "weapon_drop_level_enable_keyline", 1, 4, "int");
	}
	callback::on_spawned(&function_34636341);
	level.var_e2a6fd15 = [];
	level.var_42a6c418 = [];
	level thread function_160b27f3();
	level.var_9458e47 = [];
	level thread function_27f1a29b();
	level.var_eae5b518 = array(0.25, 1, 0.6, 0.55, 0.6, 0.8, 0.9, 1.2, 1.4, 4, 7, 11.2);
	level.var_ce9bfb71 = array(500, 750, 1000, 1250, 1500, 1750, 2000, 2250, 2500, 2750, 3000, 3500, 4000, 4500, 5000, 5500, 6000, 6500, 7000, 7500);
	level.var_1e656cc4 = array(1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21);
	level.var_3aa708b = [];
	level.var_3aa708b["soe"] = array("idgun_upgraded", "idgun_0", "idgun_upgraded_0", "idgun_1", "idgun_upgraded_1", "idgun_2", "idgun_upgraded_2", "idgun_3", "idgun_upgraded_3", "idgun_4", "idgun_upgraded_4");
	level.var_3aa708b["giant"] = array("tesla_gun", "tesla_gun_upgraded");
	level.var_3aa708b["castle"] = array("elemental_bow", "elemental_bow1", "elemental_bow2", "elemental_bow3", "elemental_bow4", "elemental_bow_storm", "elemental_bow_storm1", "elemental_bow_storm2", "elemental_bow_storm3", "elemental_bow_storm4", "elemental_bow_demongate", "elemental_bow_demongate1", "elemental_bow_demongate2", "elemental_bow_demongate3", "elemental_bow_demongate4", "elemental_bow_rune_prison", "elemental_bow_rune_prison1", "elemental_bow_rune_prison2", "elemental_bow_rune_prison3", "elemental_bow_rune_prison4", "elemental_bow_wolf", "elemental_bow_wolf1", "elemental_bow_wolf2", "elemental_bow_wolf3", "elemental_bow_wolf4", "elemental_bow_wolf_howl", "elemental_bow_wolf_howl1", "elemental_bow_wolf_howl2", "elemental_bow_wolf_howl3", "elemental_bow_wolf_howl4");
	level.var_3aa708b["island"] = array("t7_hero_mirg2000", "t7_hero_mirg2000_upgraded", "hero_mirg2000", "hero_mirg2000_upgraded");
	level.var_3aa708b["gorod"] = array("raygun_mark3", "raygun_mark3_upgraded");
	level.var_3aa708b["rev"] = array("t7_idgun_genesis_0", "t7_idgun_genesis_0_upgraded", "idgun_genesis_0", "idgun_genesis_0_upgraded");
	level.var_3aa708b["verruckt"] = array("tesla_gun", "tesla_gun_upgraded");
	level.var_3aa708b["shino"] = array("tesla_gun", "tesla_gun_upgraded");
	level.var_3aa708b["kino"] = array("thundergun", "thundergun_upgraded");
	level.var_3aa708b["asc"] = array("thundergun", "thundergun_upgraded");
	level.var_3aa708b["shang"] = array("t7_shrink_ray", "t7_shrink_ray_upgraded", "shrink_ray", "shrink_ray_upgraded");
	level.var_3aa708b["moon"] = array("microwavegundw", "microwavegundw_upgraded", "microwavegun", "microwavegun_upgraded", "microwavegunlh", "microwavegunlh_upgraded");
	level.var_3aa708b["origins"] = array("staff_fire", "staff_fire_upgraded2", "staff_fire_upgraded3", "staff_water", "staff_water_upgraded2", "staff_water_upgraded3", "staff_lightning", "staff_lightning_upgraded2", "staff_lightning_upgraded3", "staff_air", "staff_air_upgraded2", "staff_air_upgraded3");
	level thread function_87a20e06();
	level._effect["pack_a_punch_lights_fx"] = "_sphynx/_zm_pack_a_punch_lights";
	level._effect["zm_weapon_vip_damage"] = "_sphynx/weapons/_zm_weapon_vip_weapon_sparks";
	level._effect["zm_weapon_vip_death"] = "_sphynx/weapons/_zm_weapon_vip_weapon_sparks_fireworks";
	callback::on_connect(&player_on_connect);
	callback::on_spawned(&function_ef6ce1d3);
	if(!isdefined(level.actor_damage_callbacks))
	{
		level.actor_damage_callbacks = [];
	}
	if(!isdefined(level.vehicle_damage_callbacks))
	{
		level.vehicle_damage_callbacks = [];
	}
	array::push(level.actor_damage_callbacks, &function_bcb41215, 0);
	array::push(level.vehicle_damage_callbacks, &function_99b02ca6, 0);
	level.check_for_instakill_override = &function_642d1d4d;
	zm_spawner::register_zombie_death_event_callback(&function_51093d89);
	array::thread_all(getentarray("_mc_enchanting_table_pap", "targetname"), &function_e3eae7af);
	level.var_7ceb1b41 = 11;
	level.var_919b0320 = 0;
	level.var_fd6c66c2 = 1;
	array::thread_all(getentarray("dsbr_bar_pack_machine", "targetname"), &function_866e6b95);
	array::thread_all(getentarray("pap_trig", "targetname"), &function_d161f757);
	wait(0.05);
	level flag::wait_till("initial_blackscreen_passed");
	switch(tolower(getdvarstring("mapname")))
	{
		case "zm_moon":
		{
			level notify("Pack_A_Punch_on");
			break;
		}
		case "zm_prototype":
		{
			level thread function_475b7b66((-175.6, 246.16, 144.125), VectorScale((0, 1, 0), 90), 1, 0, "original");
			break;
		}
		case "zm_castle":
		{
			level thread function_475b7b66((4010, -2202.45, -2291.88), VectorScale((0, 1, 0), 75), 0, 0, "original");
			break;
		}
		case "zm_asylum":
		{
			level thread function_475b7b66((-558.78, 458.718, 226.125), (0, 0, 0), 0, 0, "original");
			break;
		}
		case "zm_sumpf":
		{
			level thread function_475b7b66((8547.52, 2092.41, -731.3), VectorScale((0, 1, 0), 125), 1, 0, "original");
			break;
		}
		case "zm_zod":
		{
			level thread function_475b7b66((2618, -2208.64, -351.875), (0, 0, 0), 0, 1, "zod");
			break;
		}
		case "zm_farm_hd":
		{
			level thread function_475b7b66((-506.6, -969.34, 320.375), VectorScale((0, 1, 0), 270), 1, 0, "original");
			break;
		}
		case "zm_eingesperrt":
		{
			level thread function_475b7b66((3030.06, -734.31, 160.125), VectorScale((0, 1, 0), 178), 1, 0, "original");
			break;
		}
		case "zm_classic_asylum":
		{
			level thread function_475b7b66((154.61, 375.426, -1.569), VectorScale((0, 1, 0), 92), 1, 0, "original");
			break;
		}
		case "zm_barbra":
		{
			level thread function_475b7b66((-98.1301, -18.7997, -159.875), VectorScale((0, 1, 0), 180), 1, 0, "original");
			break;
			break;
		}
		case "zm_tranzit_busdepot":
		{
		}
	}
}

/*
	Name: function_87a20e06
	Namespace: namespace_5e1f56dc
	Checksum: 0x424F4353
	Offset: 0x2C08
	Size: 0xF0
	Parameters: 0
	Flags: None
	Line Number: 186
*/
function function_87a20e06()
{
	wait(0.05);
	level flag::wait_till("debug_dev");
	switch(tolower(getdvarstring("mapname")))
	{
		case "zm_zod":
		{
			level thread function_475b7b66((990.225, -5660.17, 126.547), VectorScale((0, 1, 0), 95), 1);
			break;
		}
	}
	thread function_c3bfd518();
	thread function_5a6cb9bd();
	thread function_516e13aa();
	thread function_10363972();
}

/*
	Name: function_34636341
	Namespace: namespace_5e1f56dc
	Checksum: 0x424F4353
	Offset: 0x2D00
	Size: 0x50
	Parameters: 0
	Flags: None
	Line Number: 214
*/
function function_34636341()
{
	util::wait_network_frame(4);
	if(isdefined(self.hud_damagefeedback))
	{
		self.hud_damagefeedback destroy();
		self.hud_damagefeedback = undefined;
		return;
	}
}

/*
	Name: function_27f1a29b
	Namespace: namespace_5e1f56dc
	Checksum: 0x424F4353
	Offset: 0x2D58
	Size: 0x1B0
	Parameters: 0
	Flags: None
	Line Number: 235
*/
function function_27f1a29b()
{
	index = 1;
	table = "gamedata/weapons/zm_damage_multiplier.csv";
	for(row = tablelookuprow(table, index); isdefined(row); row = tablelookuprow(table, index))
	{
		weapon = checkStringValid(row[0]);
		var_f4340604 = float(checkStringValid(row[1]));
		var_1ed30589 = float(checkStringValid(row[2]));
		if(isdefined(weapon) && weapon != "")
		{
			level.var_9458e47[weapon] = spawnstruct();
			level.var_9458e47[weapon].weapon = weapon;
			level.var_9458e47[weapon].var_f4340604 = var_f4340604;
			level.var_9458e47[weapon].var_1ed30589 = var_1ed30589;
		}
		index++;
	}
}

/*
	Name: __main__
	Namespace: namespace_5e1f56dc
	Checksum: 0x424F4353
	Offset: 0x2F10
	Size: 0x30
	Parameters: 0
	Flags: None
	Line Number: 265
*/
function __main__()
{
	wait(0.05);
	level flag::init("pap_beacon_powered");
}

/*
	Name: function_160b27f3
	Namespace: namespace_5e1f56dc
	Checksum: 0x424F4353
	Offset: 0x2F48
	Size: 0x140
	Parameters: 0
	Flags: None
	Line Number: 281
*/
function function_160b27f3()
{
	index = 1;
	table = "gamedata/weapons/weapon_saving_data_index.csv";
	for(row = tablelookuprow(table, index); isdefined(row); row = tablelookuprow(table, index))
	{
		var_bd058c01 = checkStringValid(row[0]);
		type = checkStringValid(row[1]);
		description = checkStringValid(row[2]);
		if(isdefined(var_bd058c01) && var_bd058c01 != "")
		{
			level.var_e2a6fd15[var_bd058c01] = index;
			level.var_42a6c418[var_bd058c01] = type;
		}
		index++;
	}
}

/*
	Name: function_7e18304e
	Namespace: namespace_5e1f56dc
	Checksum: 0x424F4353
	Offset: 0x3090
	Size: 0x358
	Parameters: 3
	Flags: None
	Line Number: 309
*/
function function_7e18304e(var_bd058c01, weapon_level, var_2b90edc8)
{
	if(!isdefined(weapon_level))
	{
		weapon_level = 0;
	}
	if(!isdefined(var_2b90edc8))
	{
		var_2b90edc8 = 0;
	}
	if(self issplitscreen() && self.name == level.players[0].name + " 1" || (self issplitscreen() && self.name == level.players[0].name + " 2") || (self issplitscreen() && self.name == level.players[0].name + " 3") || (self issplitscreen() && self.name == level.players[0].name + " 4") || (self issplitscreen() && self.name == level.players[0].name + " 5") || (self issplitscreen() && self.name == level.players[0].name + " 6") || (self issplitscreen() && self.name == level.players[0].name + " 7"))
	{
	}
	else
	{
		self luinotifyevent(&"spx_weapon_save_data", 2, int(level.var_e2a6fd15["xuid"]), int(self getxuid(1)));
		wait(0.1);
		self luinotifyevent(&"spx_weapon_save_data", 2, int(level.var_e2a6fd15["reset_keyword"]), int(35184));
		wait(0.1);
		self luinotifyevent(&"spx_weapon_save_data", 3, int(level.var_e2a6fd15[var_bd058c01]), int(weapon_level), int(var_2b90edc8));
		wait(0.1);
	}
}

/*
	Name: function_f11f718a
	Namespace: namespace_5e1f56dc
	Checksum: 0x424F4353
	Offset: 0x33F0
	Size: 0x288
	Parameters: 0
	Flags: None
	Line Number: 343
*/
function function_f11f718a()
{
	self endon("disconnect");
	self endon("hash_56a3d9aa");
	self luinotifyevent(&"spx_get_weapon_save_data", 1, int(level.var_e2a6fd15["xuid"]));
	wait(0.1);
	foreach(key in getarraykeys(level.zombie_weapons_upgraded))
	{
		if(isdefined(level.var_e2a6fd15[key.name]))
		{
			self luinotifyevent(&"spx_get_weapon_save_data", 1, int(level.var_e2a6fd15[key.name]));
			self waittill("hash_6520165e", dataName);
			if(isdefined(self.is_hotjoining) && self.is_hotjoining || tolower(getdvarstring("mapname")) == "zm_shoothouse" || tolower(getdvarstring("mapname")) == "zm_irondragon")
			{
				wait(0.25 * self getentitynumber() + 1);
				continue;
			}
			wait(0.08 * self getentitynumber() + 1);
		}
	}
	self thread namespace_97ac1184::function_b3489bf5("^3" + self.playername + "^7 loaded Weapon Stats");
	self.var_c6452f46["weapon"] = 1;
	self notify("hash_cb55d4d2");
}

/*
	Name: function_db2310a5
	Namespace: namespace_5e1f56dc
	Checksum: 0x424F4353
	Offset: 0x3680
	Size: 0x208
	Parameters: 0
	Flags: None
	Line Number: 378
*/
function function_db2310a5()
{
	while(!(isdefined(self.var_c6452f46["weapon"]) && self.var_c6452f46["weapon"]))
	{
		wait(0.5);
	}
	player_weapons = self getweaponslistprimaries();
	foreach(weapon in player_weapons)
	{
		if(zm_weapons::is_weapon_upgraded(weapon))
		{
			var_ed5e1bff = self function_e942fd68(weapon);
			if(!(isdefined(var_ed5e1bff) && var_ed5e1bff))
			{
				if(isdefined(self function_c3370d47(weapon)) && self function_c3370d47(weapon))
				{
					var_de6974d4 = spawnstruct();
					var_de6974d4.stored_weapon = weapon.rootweapon;
					var_de6974d4.var_79fe8f18 = var_de6974d4.var_79fe8f18;
					var_de6974d4.var_4c25c2f2 = var_de6974d4.var_4c25c2f2;
					var_de6974d4.pap_camo_to_use = level.var_1e656cc4[var_de6974d4.var_4c25c2f2];
					self.var_3818be12[self.var_3818be12.size] = var_de6974d4;
				}
			}
		}
	}
}

/*
	Name: function_e39c79f7
	Namespace: namespace_5e1f56dc
	Checksum: 0x424F4353
	Offset: 0x3890
	Size: 0x60
	Parameters: 0
	Flags: None
	Line Number: 416
*/
function function_e39c79f7()
{
	iprintlnbold(self.name + ": Resetting Full Weapon System");
	self.var_c6452f46["weapon"] = 1;
	self notify("hash_cb55d4d2");
	self notify("hash_56a3d9aa");
}

/*
	Name: function_3a391177
	Namespace: namespace_5e1f56dc
	Checksum: 0x424F4353
	Offset: 0x38F8
	Size: 0x568
	Parameters: 0
	Flags: None
	Line Number: 434
*/
function function_3a391177()
{
	self endon("disconnect");
	self endon("hash_56a3d9aa");
	self.var_d31d6052 = 0;
	while(1)
	{
		self waittill("menuresponse", menu, response);
		if(menu == "weaponskilldatamenu")
		{
			if(response == "reset")
			{
				self function_e39c79f7();
			}
			else if(response == "skip")
			{
				self notify("hash_6520165e");
				continue;
			}
			var_b9b0ebb3 = strtok(response, "=");
			if(var_b9b0ebb3.size != 3)
			{
				self notify("hash_6520165e");
				continue;
			}
			dataName = tolower(var_b9b0ebb3[0]);
			value = var_b9b0ebb3[1];
			var_7c854903 = var_b9b0ebb3[2];
			var_abe6703d = tolower(level.var_42a6c418[dataName]);
			if(dataName == "tryagain")
			{
				self luinotifyevent(&"spx_get_save_data", 1, int(level.var_ac46587c[value]));
				iprintlnbold("Did not get a proper response; Trying again");
				continue;
			}
			switch(var_abe6703d)
			{
				case "player":
				{
					if(dataName == "xuid" && value != self getxuid(1))
					{
						self function_e39c79f7();
					}
					else if(dataName == "reset_keyword" && int(value) != 35184)
					{
						self function_e39c79f7();
						break;
					}
				}
				case "weapon":
				{
					if(int(value) >= 21)
					{
						self.var_d31d6052++;
					}
					var_ed5e1bff = self function_e942fd68(getweapon(dataName));
					if(!(isdefined(var_ed5e1bff) && var_ed5e1bff))
					{
						if(isdefined(self function_c3370d47(getweapon(dataName))) && self function_c3370d47(getweapon(dataName)))
						{
							var_de6974d4 = spawnstruct();
							var_de6974d4.stored_weapon = getweapon(dataName).rootweapon;
							var_de6974d4.var_79fe8f18 = int(var_7c854903);
							var_de6974d4.var_4c25c2f2 = int(value);
							var_de6974d4.pap_camo_to_use = level.var_1e656cc4[var_de6974d4.var_4c25c2f2];
							self.var_3818be12[self.var_3818be12.size] = var_de6974d4;
						}
					}
					else if(isdefined(var_ed5e1bff))
					{
						var_ed5e1bff.stored_weapon = getweapon(dataName).rootweapon;
						iprintlnbold("Known Weapon Rank: " + var_ed5e1bff.var_4c25c2f2 + " Value Add: " + value + " | Known Weapon XP: " + var_ed5e1bff.var_79fe8f18 + " Value Add: " + var_7c854903);
						var_ed5e1bff.var_79fe8f18 = int(var_ed5e1bff.var_79fe8f18 + var_7c854903);
						var_ed5e1bff.var_4c25c2f2 = int(var_ed5e1bff.var_4c25c2f2 + value);
						var_ed5e1bff.pap_camo_to_use = level.var_1e656cc4[var_ed5e1bff.var_4c25c2f2];
						break;
					}
				}
			}
			self notify("hash_6520165e", dataName);
		}
	}
	return;
	ERROR: Exception occured: Stack empty.
}

/*
	Name: player_on_connect
	Namespace: namespace_5e1f56dc
	Checksum: 0x424F4353
	Offset: 0x3E68
	Size: 0x198
	Parameters: 0
	Flags: None
	Line Number: 530
*/
function player_on_connect()
{
	self endon("disconnect");
	self.var_f4d01b67["hitmarkers"] = int(0);
	self.var_f4d01b67["hitmarker_sounds"] = int(0);
	self.var_f4d01b67["fx_damage"] = int(0);
	self.var_f4d01b67["damage_numbers"] = int(0);
	wait(0.05);
	level flag::wait_till("initial_blackscreen_passed");
	if(!isdefined(self.var_fb56a719))
	{
		self.var_fb56a719 = [];
	}
	if(!isdefined(self.var_3818be12))
	{
		self.var_3818be12 = [];
	}
	if(!isdefined(self.var_41ff59ae))
	{
		self.var_41ff59ae = 0;
	}
	if(!isdefined(self.var_ddbf6bf2))
	{
		self.var_ddbf6bf2 = 0;
	}
	self flag::wait_till("completed_maps_stats_loading");
	wait(0.05);
	self thread function_3a391177();
	wait(0.05);
	self thread function_f11f718a();
}

/*
	Name: function_7677f493
	Namespace: namespace_5e1f56dc
	Checksum: 0x424F4353
	Offset: 0x4008
	Size: 0x50
	Parameters: 0
	Flags: None
	Line Number: 572
*/
function function_7677f493()
{
	self luinotifyevent(&"spx_weapon_save_data", 2, int(level.var_e2a6fd15["savedata"]), 1);
}

/*
	Name: function_a8a57aa3
	Namespace: namespace_5e1f56dc
	Checksum: 0x424F4353
	Offset: 0x4060
	Size: 0x270
	Parameters: 1
	Flags: None
	Line Number: 587
*/
function function_a8a57aa3(response)
{
	var_a788e083 = response;
	if(var_a788e083 != "")
	{
		data = strtok(var_a788e083, ",");
		if(data[0] != self getxuid(1) || data[1] != 35184)
		{
			self luinotifyevent(&"spx_gun_level", 2, 0, level.var_ce9bfb71[0]);
		}
		else
		{
			for(i = 2; i < data.size; i = 2)
			{
				var_ed5e1bff = self function_e942fd68(getweapon(data[i]));
				if(!(isdefined(var_ed5e1bff) && var_ed5e1bff))
				{
					var_de6974d4 = spawnstruct();
					var_de6974d4.stored_weapon = getweapon(data[i]).rootweapon;
					var_de6974d4.var_79fe8f18 = int(data[i + 1]);
					var_de6974d4.var_4c25c2f2 = int(data[i + 2]);
					var_de6974d4.pap_camo_to_use = level.var_1e656cc4[var_de6974d4.var_4c25c2f2];
					self.var_3818be12[self.var_3818be12.size] = var_de6974d4;
				}
			}
			self luinotifyevent(&"spx_gun_level", 2, 0, level.var_ce9bfb71[0]);
			return;
		}
	}
	ERROR: Exception occured: Stack empty.
	continue;
}

/*
	Name: function_ef6ce1d3
	Namespace: namespace_5e1f56dc
	Checksum: 0x424F4353
	Offset: 0x42D8
	Size: 0x118
	Parameters: 0
	Flags: None
	Line Number: 630
*/
function function_ef6ce1d3()
{
	self endon("bled_out");
	self endon("spawned_player");
	self endon("disconnect");
	for(;;)
	{
		self waittill("weapon_change_complete");
		current_weapon = self getcurrentweapon();
		var_480fed80 = self function_1c1990e8(current_weapon);
		if(isdefined(var_480fed80) && zm_weapons::is_weapon_upgraded(current_weapon))
		{
			self luinotifyevent(&"spx_gun_level", 2, var_480fed80.var_79fe8f18, level.var_ce9bfb71[var_480fed80.var_4c25c2f2]);
		}
		else
		{
			self luinotifyevent(&"spx_gun_level", 2, 0, 0);
		}
	}
}

/*
	Name: function_475b7b66
	Namespace: namespace_5e1f56dc
	Checksum: 0x424F4353
	Offset: 0x43F8
	Size: 0x2C8
	Parameters: 5
	Flags: Private
	Line Number: 661
*/
function private function_475b7b66(origin, angles, power_on, hidden, type)
{
	if(!isdefined(hidden))
	{
		hidden = 0;
	}
	if(!isdefined(type))
	{
		type = "original";
	}
	var_b2fe474a = util::spawn_model("p7_zm_vending_packapunch", origin, angles);
	collision = spawn("script_model", var_b2fe474a.origin, 1);
	collision.angles = var_b2fe474a.angles;
	collision setmodel("zm_collision_perks1");
	collision.script_noteworthy = "clip";
	collision disconnectpaths();
	while(!level flag::exists("initial_blackscreen_passed"))
	{
		wait(0.5);
	}
	level flag::wait_till("initial_blackscreen_passed");
	if(isdefined(hidden) && hidden)
	{
		var_b2fe474a hide();
	}
	else
	{
		var_b2fe474a.var_3508bfff = playfxontag(level._effect["pack_a_punch_lights_fx"], var_b2fe474a, "tag_origin");
	}
	var_b2fe474a.script_sound = "mus_perks_packa_jingle";
	var_b2fe474a.script_label = "mus_perks_packa_sting";
	var_b2fe474a.longJingleWait = 1;
	var_b2fe474a thread function_9d8de684(power_on, hidden);
	var_b2fe474a create_unitrigger(&"ZM_MINECRAFT_HINTSTRING_CAN_PACK_A_PUNCH", 40, &function_7e6983a0);
	var_b2fe474a thread function_ed17d6c(type);
	if(tolower(getdvarstring("mapname")) == "zm_zod")
	{
		var_b2fe474a thread function_27c3c66f();
	}
}

/*
	Name: function_27c3c66f
	Namespace: namespace_5e1f56dc
	Checksum: 0x424F4353
	Offset: 0x46C8
	Size: 0x30
	Parameters: 0
	Flags: None
	Line Number: 712
*/
function function_27c3c66f()
{
	level flag::wait_till("ritual_pap_complete");
	self.var_977bc4ba = 1;
}

/*
	Name: function_9d8de684
	Namespace: namespace_5e1f56dc
	Checksum: 0x424F4353
	Offset: 0x4700
	Size: 0x250
	Parameters: 2
	Flags: None
	Line Number: 728
*/
function function_9d8de684(power_on, hidden)
{
	if(!isdefined(hidden))
	{
		hidden = 0;
	}
	if(isdefined(power_on) && power_on)
	{
		self.var_977bc4ba = 1;
		for(;;)
		{
			level util::waittill_any_return("power_off");
			self.var_977bc4ba = 0;
			if(!(isdefined(hidden) && hidden))
			{
				self setmodel("p7_zm_vending_packapunch");
			}
			self stoploopsound(0.1);
			level util::waittill_any_return("power_on", "ritual_pap_complete");
			self.var_977bc4ba = 1;
			if(!(isdefined(hidden) && hidden))
			{
				self setmodel("p7_zm_vending_packapunch_on");
			}
			self playloopsound("zmb_perks_packa_loop");
		}
	}
	else
	{
		self.var_977bc4ba = 0;
		for(;;)
		{
			level util::waittill_any_return("power_on", "ritual_pap_complete");
			self.var_977bc4ba = 1;
			if(!(isdefined(hidden) && hidden))
			{
				self setmodel("p7_zm_vending_packapunch_on");
			}
			self playloopsound("zmb_perks_packa_loop");
			level util::waittill_any_return("power_off", "ritual_pap_complete");
			self.var_977bc4ba = 0;
			if(!(isdefined(hidden) && hidden))
			{
				self setmodel("p7_zm_vending_packapunch");
			}
			self stoploopsound(0.1);
		}
	}
}

/*
	Name: function_e3eae7af
	Namespace: namespace_5e1f56dc
	Checksum: 0x424F4353
	Offset: 0x4958
	Size: 0x90
	Parameters: 0
	Flags: None
	Line Number: 788
*/
function function_e3eae7af()
{
	self thread function_db2e4f3f();
	self thread function_e230860b();
	self.var_977bc4ba = 1;
	self create_unitrigger(&"ZM_MINECRAFT_HINTSTRING_CAN_PACK_A_PUNCH", 40, &function_7e6983a0);
	self thread function_ed17d6c();
}

/*
	Name: function_866e6b95
	Namespace: namespace_5e1f56dc
	Checksum: 0x424F4353
	Offset: 0x49F0
	Size: 0x210
	Parameters: 0
	Flags: None
	Line Number: 807
*/
function function_866e6b95()
{
	wait(0.05);
	level flag::wait_till("initial_blackscreen_passed");
	trigger_target = getent("dsbr_bar_pack_machine", "targetname");
	var_3be010a7 = undefined;
	keys = getarraykeys(level.zones);
	for(i = 0; i < keys.size; i++)
	{
		if(isdefined(level.zones[keys[i]].unitrigger_stubs))
		{
			foreach(unitrigger in level.zones[keys[i]].unitrigger_stubs)
			{
				if(isdefined(unitrigger.trigger_target) && unitrigger.trigger_target == trigger_target)
				{
					var_3be010a7 = unitrigger;
					break;
				}
			}
		}
	}
	zm_unitrigger::unregister_unitrigger(var_3be010a7);
	self.var_977bc4ba = 1;
	self create_unitrigger(&"ZM_MINECRAFT_HINTSTRING_CAN_PACK_A_PUNCH", 40, &function_7e6983a0);
	self thread function_ed17d6c();
}

/*
	Name: function_d161f757
	Namespace: namespace_5e1f56dc
	Checksum: 0x424F4353
	Offset: 0x4C08
	Size: 0x78
	Parameters: 0
	Flags: None
	Line Number: 844
*/
function function_d161f757()
{
	wait(0.05);
	level flag::wait_till("initial_blackscreen_passed");
	self create_unitrigger(&"ZM_MINECRAFT_HINTSTRING_CAN_PACK_A_PUNCH", 40, &function_7e6983a0);
	self thread function_ed17d6c();
	return;
	ERROR: Exception occured: Stack empty.
}

/*
	Name: function_e230860b
	Namespace: namespace_5e1f56dc
	Checksum: 0x424F4353
	Offset: 0x4C88
	Size: 0x60
	Parameters: 0
	Flags: None
	Line Number: 864
*/
function function_e230860b()
{
	for(;;)
	{
		self thread scene::play("_mc_entity_enchanting_table_book_close", self);
		self waittill("hash_27d369a0");
		self thread scene::play("_mc_entity_enchanting_table_book_open", self);
		self waittill("hash_f1b18632");
	}
}

/*
	Name: function_ed17d6c
	Namespace: namespace_5e1f56dc
	Checksum: 0x424F4353
	Offset: 0x4CF0
	Size: 0x2F0
	Parameters: 1
	Flags: Private
	Line Number: 885
*/
function private function_ed17d6c(type)
{
	if(isdefined(type))
	{
		var_be737923 = type;
	}
	while(isdefined(self))
	{
		self waittill("trigger_activated", player);
		var_7750a3aa = player function_1239e0ad(player getcurrentweapon());
		if(!player zm_score::can_player_purchase(player.var_439d3100))
		{
			zm_utility::play_sound_at_pos("no_purchase", player.origin);
			player zm_audio::create_and_play_dialog("general", "outofmoney");
			self playsound("zmb_perks_packa_deny");
			continue;
		}
		if(isdefined(var_7750a3aa) && var_7750a3aa.var_a39a2843 >= level.var_7ceb1b41)
		{
			continue;
		}
		if(isdefined(var_be737923) && var_be737923 == "original")
		{
			sound = "evt_bottle_dispense";
			playsoundatposition(sound, self.origin);
			self thread zm_audio::sndPerksJingles_Player(1);
			player zm_audio::create_and_play_dialog("general", "pap_wait");
		}
		player zm_score::minus_to_player_score(player.var_439d3100);
		zm_utility::play_sound_at_pos("purchase", player.origin);
		player zm_audio::create_and_play_dialog("general", "generic_wall_buy");
		player zm_stats::increment_client_stat("use_pap");
		player zm_stats::increment_player_stat("use_pap");
		player thread namespace_97ac1184::function_1d39abf6("end_game_use_pap", 1, 0);
		player thread namespace_97ac1184::function_7e18304e("spx_save_data", "use_pap", player.pers["use_pap"], 0);
		player thread function_9c955ddd();
	}
}

/*
	Name: function_9c955ddd
	Namespace: namespace_5e1f56dc
	Checksum: 0x424F4353
	Offset: 0x4FE8
	Size: 0x928
	Parameters: 2
	Flags: None
	Line Number: 934
*/
function function_9c955ddd(var_a76169e6, w_weapon)
{
	if(isdefined(w_weapon))
	{
		current_weapon = w_weapon;
	}
	else
	{
		current_weapon = self getcurrentweapon();
		current_weapon = self zm_weapons::switch_from_alt_weapon(current_weapon);
	}
	var_7750a3aa = self function_1239e0ad(current_weapon);
	if(current_weapon.name == "idgun_0" || current_weapon.name == "idgun_1" || current_weapon.name == "idgun_2" || current_weapon.name == "idgun_3")
	{
		switch(current_weapon.name)
		{
			case "idgun_0":
			{
				var_12030910 = getweapon("idgun_upgraded_0");
				break;
			}
			case "idgun_1":
			{
				var_12030910 = getweapon("idgun_upgraded_1");
				break;
			}
			case "idgun_2":
			{
				var_12030910 = getweapon("idgun_upgraded_2");
				break;
			}
			case "idgun_3":
			{
				var_12030910 = getweapon("idgun_upgraded_3");
				break;
			}
		}
	}
	else
	{
		var_12030910 = zm_weapons::get_upgrade_weapon(current_weapon, 0);
	}
	current_weapon = self getbuildkitweapon(current_weapon, 0);
	var_12030910 = self getbuildkitweapon(var_12030910, 1);
	if(!(isdefined(self function_92bf1671(current_weapon)) && self function_92bf1671(current_weapon)))
	{
	}
	else
	{
		var_ed5e1bff = self function_e942fd68(var_12030910);
		if(isdefined(var_7750a3aa))
		{
			if(isdefined(var_7750a3aa.var_a39a2843) && var_7750a3aa.var_a39a2843 < level.var_7ceb1b41)
			{
				if(isdefined(var_a76169e6))
				{
					if(var_a76169e6 <= var_7750a3aa.var_a39a2843)
					{
						zm_utility::play_sound_at_pos("no_purchase", self.origin);
					}
					else
					{
						var_7750a3aa.var_a39a2843 = var_a76169e6;
					}
				}
				else
				{
					var_7750a3aa.var_a39a2843++;
				}
				if(var_7750a3aa.var_a39a2843 > self.pers["highest_enchantment"])
				{
					self.pers["highest_enchantment"] = var_7750a3aa.var_a39a2843;
					self thread namespace_97ac1184::function_7e18304e("spx_save_data", "highest_enchantment", self.pers["highest_enchantment"], 0);
				}
				if(var_7750a3aa.var_a39a2843 > self.pers["end_game_highest_enchantment"])
				{
					self thread namespace_97ac1184::function_1d39abf6("end_game_highest_enchantment", var_7750a3aa.var_a39a2843, 1);
				}
				wait(0.05);
				if(var_7750a3aa.var_a39a2843 > self.var_ddbf6bf2)
				{
					self.var_ddbf6bf2 = var_7750a3aa.var_a39a2843;
					wait(0.05);
					self notify("hash_79ef118b", "milestone_completed_enchantment_" + var_7750a3aa.var_a39a2843, undefined);
				}
				self thread namespace_97ac1184::function_b3489bf5("^3" + self.playername + "^7 Pack-a-Punched to ^9" + var_7750a3aa function_3ce97289() + " ^7on " + makelocalizedstring(var_7750a3aa.stored_weapon.displayname));
				self function_febfc6ba(current_weapon);
			}
		}
		else if(isdefined(self.var_c6452f46["weapon"]) && self.var_c6452f46["weapon"])
		{
			if(!(isdefined(var_ed5e1bff) && var_ed5e1bff))
			{
				if(isdefined(self function_c3370d47(var_12030910)) && self function_c3370d47(var_12030910))
				{
					var_de6974d4 = spawnstruct();
					var_de6974d4.stored_weapon = var_12030910.rootweapon;
					var_de6974d4.var_79fe8f18 = 0;
					var_de6974d4.var_4c25c2f2 = 0;
					var_de6974d4.pap_camo_to_use = level.var_1e656cc4[var_de6974d4.var_4c25c2f2];
					self.var_3818be12[self.var_3818be12.size] = var_de6974d4;
				}
			}
		}
		if(!(isdefined(var_7750a3aa) && var_7750a3aa))
		{
			var_d2433c1d = spawnstruct();
			var_d2433c1d.stored_weapon = var_12030910.rootweapon;
			if(!isdefined(var_a76169e6))
			{
				var_a76169e6 = self function_49e2047b();
			}
			var_d2433c1d.var_a39a2843 = var_a76169e6;
			self.var_fb56a719[self.var_fb56a719.size] = var_d2433c1d;
		}
		acvi = self getbuildkitattachmentcosmeticvariantindexes(var_12030910, 1);
		self takeweapon(current_weapon);
		self giveweapon(var_12030910, self zm_weapons::get_pack_a_punch_weapon_options(var_12030910), acvi);
		if(isdefined(var_12030910.start_ammo) && var_12030910.start_ammo != var_12030910.maxAmmo)
		{
			if(self hasperk("specialty_extraammo"))
			{
				self setweaponammostock(var_12030910, var_12030910.maxAmmo);
			}
			else
			{
				self setweaponammostock(var_12030910, var_12030910.startammo);
			}
		}
		else
		{
			self setweaponammostock(var_12030910, var_12030910.startammo);
		}
		if(isdefined(var_12030910.clipsize) && var_12030910.clipsize > 0)
		{
			self setweaponammoclip(var_12030910, var_12030910.clipsize);
		}
		self switchtoweapon(var_12030910);
		var_7750a3aa = self function_1239e0ad(current_weapon);
		if(isdefined(var_7750a3aa))
		{
			self thread namespace_97ac1184::function_b3489bf5("^3" + self.playername + "^7 Pack-a-Punched to ^9" + var_7750a3aa function_3ce97289() + " ^7on " + makelocalizedstring(var_7750a3aa.stored_weapon.displayname));
		}
		zm_utility::play_sound_at_pos("zmb_perks_packa_ready", self);
		level notify("hash_2210fa9c", "upgraded_current_weapon", self, current_weapon, var_12030910);
	}
}

/*
	Name: function_3ce97289
	Namespace: namespace_5e1f56dc
	Checksum: 0x424F4353
	Offset: 0x5918
	Size: 0xD8
	Parameters: 0
	Flags: None
	Line Number: 1092
*/
function function_3ce97289()
{
	switch(self.var_a39a2843)
	{
		case 1:
		{
			return "Uncommon";
		}
		case 2:
		{
			return "Rare";
		}
		case 3:
		{
			return "Epic";
		}
		case 4:
		{
			return "Legendary";
		}
		case 5:
		{
			return "Mythic";
		}
		case 6:
		{
			return "Exotic";
		}
		case 7:
		{
			return "Divine";
		}
		case 8:
		{
			return "Eternal";
		}
		case 9:
		{
			return "Cosmic";
		}
		case 10:
		{
			return "Celestial";
		}
		case 11:
		{
			return "Ultimate";
		}
	}
	return "Uncommon";
	ERROR: Exception occured: Stack empty.
}

/*
	Name: function_92bf1671
	Namespace: namespace_5e1f56dc
	Checksum: 0x424F4353
	Offset: 0x59F8
	Size: 0xB8
	Parameters: 1
	Flags: None
	Line Number: 1155
*/
function function_92bf1671(weapon)
{
	w_weapon = zm_weapons::get_nonalternate_weapon(weapon);
	if(isdefined(w_weapon.rootweapon))
	{
		w_weapon = w_weapon.rootweapon;
	}
	if(w_weapon.var_8c86d7b3 || w_weapon.var_7e163cf8 || zm_equipment::is_equipment(w_weapon) || zm_utility::is_placeable_mine(w_weapon))
	{
		return 0;
	}
	return 1;
	ERROR: Exception occured: Stack empty.
}

/*
	Name: function_49e2047b
	Namespace: namespace_5e1f56dc
	Checksum: 0x424F4353
	Offset: 0x5AB8
	Size: 0x540
	Parameters: 0
	Flags: None
	Line Number: 1180
*/
function function_49e2047b()
{
	if(!(isdefined(level.var_2198e3c0) && level.var_2198e3c0))
	{
		return 1;
	}
	if(level.round_number >= 25 && level.round_number <= 32)
	{
		if(level.var_c181264f)
		{
		}
		else if(randomintrange(0, 100) < 35)
		{
			return 2;
		}
		else
		{
			return 1;
		}
	}
	else if(level.round_number >= 33 && level.round_number <= 40)
	{
		if(level.var_c181264f)
		{
		}
		else if(randomintrange(0, 100) < 35)
		{
			return 3;
		}
		else
		{
			return 2;
		}
	}
	else if(level.round_number >= 41 && level.round_number <= 48)
	{
		if(level.var_c181264f)
		{
		}
		else if(randomintrange(0, 100) < 35)
		{
			return 4;
		}
		else
		{
			return 3;
		}
	}
	else if(level.round_number >= 49 && level.round_number <= 56)
	{
		if(level.var_c181264f)
		{
		}
		else if(randomintrange(0, 100) < 35)
		{
			return 5;
		}
		else
		{
			return 4;
		}
	}
	else if(level.round_number >= 57 && level.round_number <= 64)
	{
		if(level.var_c181264f)
		{
		}
		else if(randomintrange(0, 100) < 35)
		{
			return 6;
		}
		else
		{
			return 5;
		}
	}
	else if(level.round_number >= 65 && level.round_number <= 72)
	{
		if(level.var_c181264f)
		{
		}
		else if(randomintrange(0, 100) < 35)
		{
			return 7;
		}
		else
		{
			return 6;
		}
	}
	else if(level.round_number >= 73 && level.round_number <= 80)
	{
		if(level.var_c181264f)
		{
		}
		else if(randomintrange(0, 100) < 35)
		{
			return 8;
		}
		else
		{
			return 7;
		}
	}
	else if(level.round_number >= 81 && level.round_number <= 88)
	{
		if(level.var_c181264f)
		{
		}
		else if(randomintrange(0, 100) < 35)
		{
			return 9;
		}
		else
		{
			return 8;
		}
	}
	else if(level.round_number >= 89 && level.round_number <= 96)
	{
		if(level.var_c181264f)
		{
		}
		else if(randomintrange(0, 100) < 35)
		{
			return 10;
		}
		else
		{
			return 9;
		}
	}
	else if(level.round_number >= 97 && level.round_number <= 105)
	{
		if(level.var_c181264f)
		{
		}
		else if(randomintrange(0, 100) < 35)
		{
			return 11;
		}
		else
		{
			return 10;
		}
	}
	else if(level.round_number >= 106)
	{
		return 11;
	}
	else
	{
		return 1;
	}
}

/*
	Name: function_febfc6ba
	Namespace: namespace_5e1f56dc
	Checksum: 0x424F4353
	Offset: 0x6000
	Size: 0x128
	Parameters: 1
	Flags: None
	Line Number: 1346
*/
function function_febfc6ba(current_weapon)
{
	if(isdefined(current_weapon.start_ammo) && current_weapon.start_ammo != current_weapon.maxAmmo)
	{
		if(self hasperk("specialty_extraammo"))
		{
			self setweaponammostock(current_weapon, current_weapon.maxAmmo);
		}
		else
		{
			self setweaponammostock(current_weapon, current_weapon.startammo);
		}
	}
	else
	{
		self setweaponammostock(current_weapon, current_weapon.startammo);
	}
	if(isdefined(current_weapon.clipsize) && current_weapon.clipsize > 0)
	{
		self setweaponammoclip(current_weapon, current_weapon.clipsize);
	}
}

/*
	Name: function_e942fd68
	Namespace: namespace_5e1f56dc
	Checksum: 0x424F4353
	Offset: 0x6130
	Size: 0xF0
	Parameters: 1
	Flags: None
	Line Number: 1379
*/
function function_e942fd68(weapon)
{
	if(isdefined(self.var_3818be12) && self.var_3818be12.size > 0)
	{
		foreach(var_52bd8d74 in self.var_3818be12)
		{
			if(var_52bd8d74.stored_weapon == weapon.rootweapon || var_52bd8d74.stored_weapon.name == weapon.rootweapon.name)
			{
				return 1;
			}
		}
	}
	return 0;
}

/*
	Name: function_7e6983a0
	Namespace: namespace_5e1f56dc
	Checksum: 0x424F4353
	Offset: 0x6228
	Size: 0x408
	Parameters: 1
	Flags: None
	Line Number: 1404
*/
function function_7e6983a0(player)
{
	var_7750a3aa = player function_1239e0ad(player getcurrentweapon());
	if(isdefined(var_7750a3aa))
	{
		if(var_7750a3aa.var_a39a2843 == 1)
		{
			player.var_439d3100 = 10000;
		}
		if(var_7750a3aa.var_a39a2843 == 2)
		{
			player.var_439d3100 = 15000;
		}
		if(var_7750a3aa.var_a39a2843 == 3)
		{
			player.var_439d3100 = 30000;
		}
		if(var_7750a3aa.var_a39a2843 == 4)
		{
			player.var_439d3100 = 50000;
		}
		if(var_7750a3aa.var_a39a2843 == 5)
		{
			player.var_439d3100 = 75000;
		}
		if(var_7750a3aa.var_a39a2843 == 6)
		{
			player.var_439d3100 = 100000;
		}
		if(var_7750a3aa.var_a39a2843 == 7)
		{
			player.var_439d3100 = 125000;
		}
		if(var_7750a3aa.var_a39a2843 == 8)
		{
			player.var_439d3100 = 150000;
		}
		if(var_7750a3aa.var_a39a2843 == 9)
		{
			player.var_439d3100 = 175000;
		}
		if(var_7750a3aa.var_a39a2843 == 10)
		{
			player.var_439d3100 = 200000;
		}
	}
	else
	{
		player.var_439d3100 = 5000;
	}
	if(!(isdefined(self.stub.related_parent.var_977bc4ba) && self.stub.related_parent.var_977bc4ba))
	{
		self sethintstring(&"ZOMBIE_NEED_POWER");
		return 0;
	}
	if(isdefined(level.var_919b0320) && level.var_919b0320)
	{
		self sethintstring(&"ZM_MINECRAFT_HINTSTRING_PAP_DISABLED");
		return 0;
	}
	if(zm_weapons::is_weapon_upgraded(player getcurrentweapon()) && isdefined(var_7750a3aa) && var_7750a3aa.var_a39a2843 >= level.var_7ceb1b41)
	{
		self sethintstring(&"ZM_MINECRAFT_HINTSTRING_CANNOT_USE_PAP_WEAPON_MAX");
		return 0;
	}
	else if(!(isdefined(player player_use_can_pack_now()) && player player_use_can_pack_now()))
	{
		self sethintstring(&"ZM_MINECRAFT_HINTSTRING_CANNOT_USE_PAP_WEAPON");
		return 0;
	}
	else if(!player zm_score::can_player_purchase(player.var_439d3100))
	{
		self sethintstring(&"ZM_MINECRAFT_HINTSTRING_PAP_NO_MONEY", player.var_439d3100);
		return 0;
	}
	else
	{
		self sethintstring(&"ZM_MINECRAFT_HINTSTRING_CAN_PACK_A_PUNCH", player.var_439d3100);
		return 1;
	}
}

/*
	Name: player_use_can_pack_now
	Namespace: namespace_5e1f56dc
	Checksum: 0x424F4353
	Offset: 0x6638
	Size: 0x2F0
	Parameters: 0
	Flags: None
	Line Number: 1496
*/
function player_use_can_pack_now()
{
	if(self laststand::player_is_in_laststand() || (isdefined(self.intermission) && self.intermission) || self IsThrowingGrenade())
	{
		return 0;
	}
	if(!self zm_magicbox::can_buy_weapon() || self bgb::is_enabled("zm_bgb_disorderly_combat") || zm_utility::is_hero_weapon(self getcurrentweapon()))
	{
		return 0;
	}
	if(!zm_utility::is_player_valid(self) || self.is_drinking > 0 || zm_utility::is_placeable_mine(self getcurrentweapon()) || zm_equipment::is_equipment(self getcurrentweapon()) || self zm_utility::is_player_revive_tool(self getcurrentweapon()) || level.weaponnone == self getcurrentweapon() || self zm_equipment::hacker_active())
	{
		return 0;
	}
	if(self getcurrentweapon().isRiotShield)
	{
		return 0;
	}
	weapon = self zm_weapons::get_nonalternate_weapon(self getcurrentweapon());
	if(!zm_weapons::is_weapon_or_base_included(self getcurrentweapon()))
	{
		return 0;
	}
	if(tolower(getdvarstring("mapname")) != "zm_zod")
	{
		if(!zm_weapons::is_weapon_upgraded(self getcurrentweapon()) && !self zm_weapons::can_upgrade_weapon(self getcurrentweapon()))
		{
			return 0;
		}
	}
	if(isdefined(self getcurrentweapon() function_25b21deb()) && self getcurrentweapon() function_25b21deb())
	{
		return 0;
	}
	return 1;
	ERROR: Exception occured: Stack empty.
}

/*
	Name: function_db2e4f3f
	Namespace: namespace_5e1f56dc
	Checksum: 0x424F4353
	Offset: 0x6930
	Size: 0x180
	Parameters: 0
	Flags: None
	Line Number: 1544
*/
function function_db2e4f3f()
{
	link_ent = util::spawn_model("tag_origin", self.origin, self.angles);
	wait(0.05);
	self linkto(link_ent);
	while(isdefined(self))
	{
		var_dc518be1 = arraygetclosest(self.origin, getplayers());
		if(isdefined(var_dc518be1))
		{
			dist = distance(self.origin, var_dc518be1.origin);
			if(dist < 150)
			{
				self notify("hash_27d369a0");
				angles = link_ent function_ab9afa24(var_dc518be1.origin);
				link_ent rotateto(angles - VectorScale((0, 1, 0), 90), 0.3);
			}
			else
			{
				self notify("hash_f1b18632");
			}
		}
		wait(0.3);
	}
}

/*
	Name: function_ab9afa24
	Namespace: namespace_5e1f56dc
	Checksum: 0x424F4353
	Offset: 0x6AB8
	Size: 0x88
	Parameters: 1
	Flags: None
	Line Number: 1580
*/
function function_ab9afa24(position)
{
	v_to_enemy = (position - self.origin[0], position - self.origin[1], 0);
	v_to_enemy = vectornormalize(v_to_enemy);
	goalAngles = vectortoangles(v_to_enemy);
	return goalAngles;
}

/*
	Name: function_642d1d4d
	Namespace: namespace_5e1f56dc
	Checksum: 0x424F4353
	Offset: 0x6B48
	Size: 0x10
	Parameters: 1
	Flags: None
	Line Number: 1598
*/
function function_642d1d4d(e_player)
{
	return 0;
}

/*
	Name: function_73f71a35
	Namespace: namespace_5e1f56dc
	Checksum: 0x424F4353
	Offset: 0x6B60
	Size: 0x18
	Parameters: 0
	Flags: None
	Line Number: 1613
*/
function function_73f71a35()
{
	return self.var_b74a3cd1["brutal_xp"];
}

/*
	Name: function_51093d89
	Namespace: namespace_5e1f56dc
	Checksum: 0x424F4353
	Offset: 0x6B80
	Size: 0xAC8
	Parameters: 1
	Flags: Private
	Line Number: 1628
*/
function private function_51093d89(e_attacker)
{
	if(!isdefined(e_attacker) || !isplayer(e_attacker) || !isdefined(self.damageWeapon) || (!(isdefined(e_attacker namespace_97ac1184::function_ae5b65af()) && e_attacker namespace_97ac1184::function_ae5b65af())))
	{
		return;
	}
	if(isdefined(self.damageWeapon.dualWieldWeapon) && self.damageWeapon.dualWieldWeapon != level.weaponnone)
	{
		if(issubstr(self.damageWeapon.name, "lh") || issubstr(self.damageWeapon.name, "ldw"))
		{
			if(self.damageWeapon != e_attacker getcurrentweapon().dualWieldWeapon)
			{
				return;
			}
		}
		else if(self.damageWeapon != e_attacker getcurrentweapon())
		{
			return;
		}
	}
	else if(self.damageWeapon != e_attacker getcurrentweapon())
	{
		return;
	}
	if(isdefined(e_attacker function_c3370d47(self.damageWeapon)) && e_attacker function_c3370d47(self.damageWeapon))
	{
		if(isdefined(self.damageWeapon.dualWieldWeapon) && self.damageWeapon.dualWieldWeapon != level.weaponnone)
		{
			if(issubstr(self.damageWeapon.name, "lh") || issubstr(self.damageWeapon.name, "ldw"))
			{
				w_weapon = zm_weapons::get_nonalternate_weapon(self.damageWeapon.dualWieldWeapon);
				if(isdefined(w_weapon.rootweapon))
				{
					w_weapon = w_weapon.rootweapon;
				}
			}
			else
			{
				w_weapon = zm_weapons::get_nonalternate_weapon(self.damageWeapon);
				if(isdefined(w_weapon.rootweapon))
				{
					w_weapon = w_weapon.rootweapon;
				}
			}
		}
		else
		{
			w_weapon = zm_weapons::get_nonalternate_weapon(self.damageWeapon);
			if(isdefined(w_weapon.rootweapon))
			{
				w_weapon = w_weapon.rootweapon;
			}
		}
		var_480fed80 = e_attacker function_1c1990e8(w_weapon);
		if(isdefined(var_480fed80))
		{
			if(issubstr(var_480fed80.stored_weapon.name, "season_") || issubstr(var_480fed80.stored_weapon.name, "blaster") || issubstr(var_480fed80.stored_weapon.name, "darth_vader"))
			{
				var_480fed80.var_79fe8f18 = var_480fed80.var_79fe8f18 + 2;
			}
			else
			{
				var_480fed80.var_79fe8f18 = var_480fed80.var_79fe8f18 + 1;
			}
			e_attacker luinotifyevent(&"spx_gun_level", 2, int(var_480fed80.var_79fe8f18), int(level.var_ce9bfb71[var_480fed80.var_4c25c2f2]));
			if(var_480fed80.var_79fe8f18 >= level.var_ce9bfb71[var_480fed80.var_4c25c2f2])
			{
				var_480fed80.var_4c25c2f2 = var_480fed80.var_4c25c2f2 + 1;
				if(issubstr(var_480fed80.stored_weapon.name, "season_") && var_480fed80.var_4c25c2f2 == 21)
				{
					self.pers["seasonal_points"] = self.pers["seasonal_points"] + 50;
					self.pers["seasonal_weapons_completed"] = self.pers["seasonal_weapons_completed"] + 1;
					self thread namespace_97ac1184::function_7e18304e("spx_save_data", "seasonal_points", self.pers["seasonal_points"], 0);
					self thread namespace_97ac1184::function_7e18304e("spx_save_data", "seasonal_weapons_completed", self.pers["seasonal_weapons_completed"], 0);
				}
				var_480fed80.var_79fe8f18 = 0;
				var_480fed80.pap_camo_to_use = level.var_1e656cc4[var_480fed80.var_4c25c2f2];
				if(isdefined(e_attacker.var_fa202141["player_specifiedcamo"]) && e_attacker.var_fa202141["player_specifiedcamo"] == 0)
				{
					if(isdefined(e_attacker.var_fa202141["player_favouritecamo"]) && e_attacker.var_fa202141["player_favouritecamo"] == 0 || (isdefined(e_attacker.var_fa202141["player_favouritecamo"]) && e_attacker.var_fa202141["player_favouritecamo"] > var_480fed80.var_4c25c2f2))
					{
						e_attacker function_c8540b60(w_weapon, e_attacker calcweaponoptions(level.var_1e656cc4[var_480fed80.var_4c25c2f2], 0, 0));
					}
				}
				e_attacker thread namespace_97ac1184::function_b3489bf5("^3" + e_attacker.playername + "^7 achieved ^9" + function_b51ad244(int(var_480fed80.var_4c25c2f2)) + " ^7on " + makelocalizedstring(var_480fed80.stored_weapon.displayname));
				e_attacker luinotifyevent(&"spx_camo_notification", 1, int(var_480fed80.var_4c25c2f2));
				e_attacker thread function_e5bef058(var_480fed80.var_4c25c2f2);
			}
			e_attacker thread function_7e18304e(var_480fed80.stored_weapon.rootweapon.name, var_480fed80.var_4c25c2f2, var_480fed80.var_79fe8f18);
		}
	}
	if(randomintrange(0, 100) <= function_5cbadafe(self.damageWeapon) && e_attacker.var_41ff59ae == 0 && (isdefined(level.var_fd6c66c2) && level.var_fd6c66c2))
	{
		var_bcce182e = util::spawn_model("tag_origin", self.origin, self.angles);
		playable_area = getentarray("player_volume", "script_noteworthy");
		valid_drop = 0;
		for(i = 0; i < playable_area.size; i++)
		{
			if(var_bcce182e istouching(playable_area[i]))
			{
				valid_drop = 1;
				break;
			}
		}
		if(isdefined(valid_drop) && valid_drop)
		{
			e_attacker.var_41ff59ae = function_32d4b0df(self.damageWeapon);
			e_attacker thread function_669b1c40();
			var_bcce182e setmodel("zmu_ammo_pack");
			final_pos = zm_weapons::function_a2b97522(self, 50, var_bcce182e);
			var_8f7442a5 = util::ground_position(final_pos, 500, 25);
			var_bcce182e zm_utility::fake_physicslaunch(var_8f7442a5, randomintrange(50, 100));
			var_bcce182e thread function_ff00213(20);
		}
		else
		{
			var_bcce182e delete();
		}
	}
	return -1;
}

/*
	Name: function_32d4b0df
	Namespace: namespace_5e1f56dc
	Checksum: 0x424F4353
	Offset: 0x7650
	Size: 0x48
	Parameters: 1
	Flags: None
	Line Number: 1760
*/
function function_32d4b0df(weapon)
{
	if(isdefined(weapon function_e078665a()) && weapon function_e078665a())
	{
		return 70;
	}
	return 40;
}

/*
	Name: function_5cbadafe
	Namespace: namespace_5e1f56dc
	Checksum: 0x424F4353
	Offset: 0x76A0
	Size: 0x48
	Parameters: 1
	Flags: None
	Line Number: 1779
*/
function function_5cbadafe(weapon)
{
	if(isdefined(weapon function_e078665a()) && weapon function_e078665a())
	{
		return 1;
	}
	return 10;
}

/*
	Name: function_b51ad244
	Namespace: namespace_5e1f56dc
	Checksum: 0x424F4353
	Offset: 0x76F0
	Size: 0x178
	Parameters: 1
	Flags: None
	Line Number: 1798
*/
function function_b51ad244(index)
{
	switch(index)
	{
		case 0:
		{
			return "Gold Camo";
		}
		case 1:
		{
			return "Diamond Camo";
		}
		case 2:
		{
			return "Glacial Frost Camo";
		}
		case 3:
		{
			return "Oil Slick Camo";
		}
		case 4:
		{
			return "Nebula Shroud Camo";
		}
		case 5:
		{
			return "Liquid Midnight Camo";
		}
		case 6:
		{
			return "Icy Stellar Camo";
		}
		case 7:
		{
			return "Galaxy Stars Camo";
		}
		case 8:
		{
			return "Blood Camo Camo";
		}
		case 9:
		{
			return "Enchanted Emerald Camo";
		}
		case 10:
		{
			return "Orion's Veil Camo";
		}
		case 11:
		{
			return "Stellar Eclipse Camo";
		}
		case 12:
		{
			return "Deep Depth Camo";
		}
		case 13:
		{
			return "Yellow Maelstrom Camo";
		}
		case 14:
		{
			return "Astral Red Storm Camo";
		}
		case 15:
		{
			return "Green Aurora Camo";
		}
		case 16:
		{
			return "White Cosmos Camo";
		}
		case 17:
		{
			return "Andromeda Drift Camo";
		}
		case 18:
		{
			return "Acidic Radiance Camo";
		}
		case 19:
		{
			return "Galactic Amethyst Camo";
		}
		case 20:
		{
			return "Electralized Diamonds Camo";
		}
	}
	return "Gold Camo";
	~;
}

/*
	Name: function_e5bef058
	Namespace: namespace_5e1f56dc
	Checksum: 0x424F4353
	Offset: 0x7870
	Size: 0x700
	Parameters: 1
	Flags: None
	Line Number: 1901
*/
function function_e5bef058(var_4c25c2f2)
{
	switch(var_4c25c2f2)
	{
		case 1:
		{
			self.pers["player_points"] = self.pers["player_points"] + 25;
			self notify("hash_79ef118b", "camo_1_obtained", undefined);
			break;
		}
		case 2:
		{
			self.pers["player_points"] = self.pers["player_points"] + 50;
			self notify("hash_79ef118b", "camo_2_obtained", undefined);
			break;
		}
		case 3:
		{
			self.pers["player_points"] = self.pers["player_points"] + 100;
			self notify("hash_79ef118b", "camo_3_obtained", undefined);
			break;
		}
		case 4:
		{
			self.pers["player_points"] = self.pers["player_points"] + 150;
			self notify("hash_79ef118b", "camo_4_obtained", undefined);
			break;
		}
		case 5:
		{
			self.pers["player_points"] = self.pers["player_points"] + 200;
			self notify("hash_79ef118b", "camo_5_obtained", undefined);
			break;
		}
		case 6:
		{
			self.pers["player_points"] = self.pers["player_points"] + 300;
			self notify("hash_79ef118b", "camo_6_obtained", undefined);
			break;
		}
		case 7:
		{
			self.pers["player_points"] = self.pers["player_points"] + 400;
			self notify("hash_79ef118b", "camo_7_obtained", undefined);
			break;
		}
		case 8:
		{
			self.pers["player_points"] = self.pers["player_points"] + 600;
			self notify("hash_79ef118b", "camo_8_obtained", undefined);
			break;
		}
		case 9:
		{
			self.pers["player_points"] = self.pers["player_points"] + 800;
			self notify("hash_79ef118b", "camo_9_obtained", undefined);
			break;
		}
		case 10:
		{
			self.pers["player_points"] = self.pers["player_points"] + 1000;
			self notify("hash_79ef118b", "camo_10_obtained", undefined);
			break;
		}
		case 11:
		{
			self.pers["player_points"] = self.pers["player_points"] + 1200;
			self notify("hash_79ef118b", "camo_11_obtained", undefined);
			break;
		}
		case 12:
		{
			self.pers["player_points"] = self.pers["player_points"] + 1200;
			self notify("hash_79ef118b", "camo_12_obtained", undefined);
			break;
		}
		case 13:
		{
			self.pers["player_points"] = self.pers["player_points"] + 1400;
			self notify("hash_79ef118b", "camo_13_obtained", undefined);
			break;
		}
		case 14:
		{
			self.pers["player_points"] = self.pers["player_points"] + 1400;
			self notify("hash_79ef118b", "camo_14_obtained", undefined);
			break;
		}
		case 15:
		{
			self.pers["player_points"] = self.pers["player_points"] + 1600;
			self notify("hash_79ef118b", "camo_15_obtained", undefined);
			break;
		}
		case 16:
		{
			self.pers["player_points"] = self.pers["player_points"] + 1600;
			self notify("hash_79ef118b", "camo_16_obtained", undefined);
			break;
		}
		case 17:
		{
			self.pers["player_points"] = self.pers["player_points"] + 1800;
			self notify("hash_79ef118b", "camo_17_obtained", undefined);
			break;
		}
		case 18:
		{
			self.pers["player_points"] = self.pers["player_points"] + 1800;
			self notify("hash_79ef118b", "camo_18_obtained", undefined);
			break;
		}
		case 19:
		{
			self.pers["player_points"] = self.pers["player_points"] + 2000;
			self notify("hash_79ef118b", "camo_19_obtained", undefined);
			break;
		}
		case 20:
		{
			self.pers["player_points"] = self.pers["player_points"] + 2000;
			self notify("hash_79ef118b", "camo_20_obtained", undefined);
			break;
		}
		case 21:
		{
			self.pers["player_points"] = self.pers["player_points"] + 2200;
			self notify("hash_79ef118b", "camo_21_obtained", undefined);
			break;
		}
		case 22:
		{
			self.pers["player_points"] = self.pers["player_points"] + 2200;
			self notify("hash_79ef118b", "camo_22_obtained", undefined);
			break;
		}
	}
}

/*
	Name: function_669b1c40
	Namespace: namespace_5e1f56dc
	Checksum: 0x424F4353
	Offset: 0x7F78
	Size: 0x28
	Parameters: 0
	Flags: None
	Line Number: 2050
*/
function function_669b1c40()
{
	while(self.var_41ff59ae > 0)
	{
		self.var_41ff59ae--;
		wait(1);
	}
}

/*
	Name: function_1c1990e8
	Namespace: namespace_5e1f56dc
	Checksum: 0x424F4353
	Offset: 0x7FA8
	Size: 0xF0
	Parameters: 1
	Flags: None
	Line Number: 2069
*/
function function_1c1990e8(weapon)
{
	if(isdefined(self.var_3818be12) && self.var_3818be12.size > 0)
	{
		foreach(var_52bd8d74 in self.var_3818be12)
		{
			if(var_52bd8d74.stored_weapon == weapon.rootweapon || var_52bd8d74.stored_weapon.name == weapon.rootweapon.name)
			{
				return var_52bd8d74;
			}
		}
	}
	return undefined;
}

/*
	Name: function_c3370d47
	Namespace: namespace_5e1f56dc
	Checksum: 0x424F4353
	Offset: 0x80A0
	Size: 0x1B8
	Parameters: 1
	Flags: None
	Line Number: 2094
*/
function function_c3370d47(weapon)
{
	w_weapon = zm_weapons::get_nonalternate_weapon(weapon);
	if(isdefined(w_weapon.rootweapon))
	{
		w_weapon = w_weapon.rootweapon;
	}
	if(isdefined(w_weapon.dualWieldWeapon) && w_weapon.dualWieldWeapon != level.weaponnone)
	{
		if(issubstr(w_weapon.name, "lh") || issubstr(w_weapon.name, "ldw"))
		{
			w_weapon = zm_weapons::get_nonalternate_weapon(w_weapon.dualWieldWeapon);
			if(isdefined(w_weapon.rootweapon))
			{
				w_weapon = w_weapon.rootweapon;
			}
		}
	}
	if(!isdefined(level.var_e2a6fd15[w_weapon.name]))
	{
		return 0;
	}
	if(w_weapon.var_8c86d7b3 || w_weapon.var_7e163cf8 || zm_equipment::is_equipment(w_weapon) || zm_utility::is_placeable_mine(w_weapon))
	{
		return 0;
	}
	if(w_weapon.isRiotShield)
	{
		return 0;
	}
	return 1;
}

/*
	Name: function_1239e0ad
	Namespace: namespace_5e1f56dc
	Checksum: 0x424F4353
	Offset: 0x8260
	Size: 0xC0
	Parameters: 1
	Flags: None
	Line Number: 2137
*/
function function_1239e0ad(weapon)
{
	if(isdefined(self.var_fb56a719) && self.var_fb56a719.size > 0)
	{
		foreach(var_52bd8d74 in self.var_fb56a719)
		{
			if(var_52bd8d74.stored_weapon == weapon.rootweapon)
			{
				return var_52bd8d74;
			}
		}
	}
	return undefined;
}

/*
	Name: function_e078665a
	Namespace: namespace_5e1f56dc
	Checksum: 0x424F4353
	Offset: 0x8328
	Size: 0x2D8
	Parameters: 0
	Flags: None
	Line Number: 2162
*/
function function_e078665a()
{
	switch(self.name)
	{
		case "elemental_bow":
		case "elemental_bow1":
		case "elemental_bow2":
		case "elemental_bow3":
		case "elemental_bow4":
		case "elemental_bow_demongate":
		case "elemental_bow_demongate1":
		case "elemental_bow_demongate2":
		case "elemental_bow_demongate3":
		case "elemental_bow_demongate4":
		case "elemental_bow_rune_prison":
		case "elemental_bow_rune_prison1":
		case "elemental_bow_rune_prison2":
		case "elemental_bow_rune_prison3":
		case "elemental_bow_rune_prison4":
		case "elemental_bow_storm":
		case "elemental_bow_storm1":
		case "elemental_bow_storm2":
		case "elemental_bow_storm3":
		case "elemental_bow_storm4":
		case "elemental_bow_wolf":
		case "elemental_bow_wolf1":
		case "elemental_bow_wolf2":
		case "elemental_bow_wolf3":
		case "elemental_bow_wolf4":
		case "elemental_bow_wolf_howl":
		case "elemental_bow_wolf_howl1":
		case "elemental_bow_wolf_howl2":
		case "elemental_bow_wolf_howl3":
		case "elemental_bow_wolf_howl4":
		case "hero_gravityspikes_melee":
		case "hero_mirg2000":
		case "hero_mirg2000_upgraded":
		case "idgun_0":
		case "idgun_1":
		case "idgun_2":
		case "idgun_3":
		case "idgun_4":
		case "idgun_genesis_0":
		case "idgun_genesis_0_upgraded":
		case "idgun_upgraded":
		case "idgun_upgraded_0":
		case "idgun_upgraded_1":
		case "idgun_upgraded_2":
		case "idgun_upgraded_3":
		case "idgun_upgraded_4":
		case "microwavegun":
		case "microwavegun_upgraded":
		case "microwavegundw":
		case "microwavegundw_upgraded":
		case "microwavegunlh":
		case "microwavegunlh_upgraded":
		case "octobomb":
		case "octobomb_upgraded":
		case "skull_gun":
		case "staff_air":
		case "staff_air_upgraded2":
		case "staff_air_upgraded3":
		case "staff_fire":
		case "staff_fire_upgraded2":
		case "staff_fire_upgraded3":
		case "staff_lightning":
		case "staff_lightning_upgraded2":
		case "staff_lightning_upgraded3":
		case "staff_water":
		case "staff_water_upgraded2":
		case "staff_water_upgraded3":
		case "t7_hero_mirg2000":
		case "t7_hero_mirg2000_upgraded":
		case "t7_idgun_genesis_0":
		case "t7_idgun_genesis_0_upgraded":
		case "t7_shrink_ray":
		case "t7_shrink_ray_upgraded":
		case "t7_staff_air":
		case "t7_staff_air_upgraded":
		case "t7_staff_fire":
		case "t7_staff_fire_upgraded":
		case "t7_staff_lightning":
		case "t7_staff_lightning_upgraded":
		case "t7_staff_water":
		case "t7_staff_water_upgraded":
		case "tesla_gun":
		case "tesla_gun_upgraded":
		case "thundergun":
		case "thundergun_upgraded":
		{
			return 1;
		}
		default
		{
			return 0;
		}
	}
	return 0;
}

/*
	Name: function_d12c593e
	Namespace: namespace_5e1f56dc
	Checksum: 0x424F4353
	Offset: 0x8608
	Size: 0x128
	Parameters: 12
	Flags: None
	Line Number: 2272
*/
function function_d12c593e(e_inflictor, e_attacker, n_damage, var_73c5e99d, str_means_of_death, w_weapon, v_point, v_direction, str_hit_loc, var_bb4cbbbb, var_22b92c8f, str_surface_type)
{
	switch(tolower(getdvarstring("mapname")))
	{
		case "zm_crazy_place":
		{
			if(!isdefined(self.var_73a2e922))
			{
				self.var_73a2e922 = 0;
			}
			if(self.var_73a2e922 < 3 && w_weapon == getweapon("t8_snowball"))
			{
				self.var_73a2e922++;
			}
			else if(self.var_73a2e922 >= 3 && !self.var_18494d02)
			{
				self.var_18494d02 = 1;
				break;
			}
		}
	}
}

/*
	Name: function_f22f093d
	Namespace: namespace_5e1f56dc
	Checksum: 0x424F4353
	Offset: 0x8738
	Size: 0x300
	Parameters: 12
	Flags: None
	Line Number: 2305
*/
function function_f22f093d(e_inflictor, e_attacker, n_damage, var_73c5e99d, str_means_of_death, w_weapon, v_point, v_direction, str_hit_loc, var_bb4cbbbb, var_22b92c8f, str_surface_type)
{
	if(e_attacker hasperk("specialty_immunetriggershock") && isdefined(e_attacker.var_8815f6c1) && str_means_of_death != "MOD_MELEE_WEAPON_BUTT" && str_means_of_death != "MOD_MELEE" && str_means_of_death != "MOD_MELEE_ASSASSINATE")
	{
		var_cdca0d27 = self.health / self.maxhealth * 100;
		if(str_means_of_death == "MOD_MELEE" || str_means_of_death == "MOD_GRENADE" || str_means_of_death == "MOD_GRENADE_SPLASH" || str_means_of_death == "MOD_EXPLOSIVE" || str_means_of_death == "MOD_EXPLOSIVE_SPLASH" || str_means_of_death == "MOD_ELECTROCUTED")
		{
			return 0;
		}
		if(isdefined(w_weapon.is_wonder_weapon) && w_weapon.is_wonder_weapon || array::contains(level.var_e33eb0d5, w_weapon.name))
		{
			return 0;
		}
		if(self.health - n_damage <= 0)
		{
			self notify("hash_23b51ce8");
		}
		if(isdefined(self.var_d229f756) && self.var_d229f756)
		{
			return 1;
		}
		if(var_cdca0d27 < 0.7)
		{
			return 0;
		}
		proc = randomintrange(0, 100);
		if(e_attacker.var_8815f6c1["shot_timer"] < 1 && (!(isdefined(self.var_d229f756) && self.var_d229f756)) && proc < e_attacker.var_8815f6c1["proc_chance"])
		{
			self.var_d229f756 = 1;
			self thread namespace_92fb2abd::function_8224092f();
			original_health = self.health;
			self.health = self.health * 0.07;
			self thread namespace_92fb2abd::function_3b87d567();
			e_attacker thread namespace_92fb2abd::function_11c25256();
			return 1;
		}
	}
	return 0;
}

/*
	Name: function_59adaa49
	Namespace: namespace_5e1f56dc
	Checksum: 0x424F4353
	Offset: 0x8A40
	Size: 0x358
	Parameters: 8
	Flags: None
	Line Number: 2355
*/
function function_59adaa49(e_attacker, n_damage, v_point, death, is_headshot, is_minigun, var_c13cf7dd, var_8ccd861d)
{
	if(!isdefined(death))
	{
		death = 0;
	}
	if(!isdefined(is_headshot))
	{
		is_headshot = 0;
	}
	if(!isdefined(is_minigun))
	{
		is_minigun = 0;
	}
	if(!isdefined(var_c13cf7dd))
	{
		var_c13cf7dd = 0;
	}
	if(!isdefined(var_8ccd861d))
	{
		var_8ccd861d = 0;
	}
	if(isdefined(e_attacker.var_b9961962) && e_attacker.var_b9961962)
	{
		number = n_damage;
		color = 14539725;
		if(is_minigun || var_c13cf7dd)
		{
			number = self.maxhealth + 1;
			color = 8018662;
		}
		else if(self.health - n_damage <= 0 || death)
		{
			color = 14632004;
		}
		else if(var_8ccd861d)
		{
			color = 4913398;
		}
		else if(is_headshot)
		{
			color = 15391081;
		}
		if(n_damage >= self.maxhealth)
		{
			number = self.maxhealth + 1;
			color = 8018662;
		}
		if(isdefined(number) && isdefined(color))
		{
			e_attacker.var_b9961962 = 0;
			e_attacker.var_df17dfe1 = 1;
			distance = distance(self.origin, e_attacker.origin);
			e_attacker luinotifyevent(&"damage_3d", 6, int(number), color, int(v_point[0] + randomfloatrange(-4.5, 4.5)), int(v_point[1] + randomfloatrange(-4.5, 4.5)), int(v_point[2] + randomfloatrange(-4.5, 4.5)), int(distance / 300));
			wait(0.06 * e_attacker getentitynumber() + 1);
			e_attacker.var_b9961962 = 1;
			e_attacker.var_df17dfe1 = 0;
		}
	}
}

/*
	Name: function_2dce8d67
	Namespace: namespace_5e1f56dc
	Checksum: 0x424F4353
	Offset: 0x8DA0
	Size: 0xC0
	Parameters: 0
	Flags: None
	Line Number: 2426
*/
function function_2dce8d67()
{
	switch(self.archetype)
	{
		case "astronaut":
		case "margwa":
		case "mechz":
		case "raz":
		case "thrasher":
		case "undead_saint":
		case "zombie_george":
		{
			return 1;
		}
	}
	if(self.animname == "napalm_zombie" || self.animname == "sonic_zombie" || self.animname == "zombie_boss" || (isdefined(self.var_a44ca904) && self.var_a44ca904) || isdefined(self.var_81b254b3))
	{
		return 1;
	}
	return 0;
}

/*
	Name: function_bcb41215
	Namespace: namespace_5e1f56dc
	Checksum: 0x424F4353
	Offset: 0x8E68
	Size: 0x1030
	Parameters: 12
	Flags: None
	Line Number: 2458
*/
function function_bcb41215(e_inflictor, e_attacker, n_damage, var_73c5e99d, str_means_of_death, w_weapon, v_point, v_direction, str_hit_loc, var_bb4cbbbb, var_22b92c8f, str_surface_type)
{
	if(!isdefined(e_attacker) || !isplayer(e_attacker) || !isdefined(w_weapon) || (isdefined(w_weapon function_e078665a()) && w_weapon function_e078665a()))
	{
		return -1;
	}
	iprintlnbold("weapon: " + w_weapon);
	alt_weapon = w_weapon.altweapon;
	if(alt_weapon != level.weaponnone)
	{
		iprintlnbold("Alt weapon: " + alt_weapon);
	}
	w_weapon = zm_weapons::get_nonalternate_weapon(w_weapon);
	if(isdefined(w_weapon.rootweapon))
	{
		w_weapon = w_weapon.rootweapon;
	}
	if(e_attacker hasperk("specialty_immunetriggerbetty"))
	{
		if(!(isdefined(self.no_damage_points) && self.no_damage_points) && isdefined(e_attacker))
		{
			chance = randomintrange(1, 100);
			if(chance <= 25)
			{
				e_attacker zm_score::player_add_points("damage", str_means_of_death, str_hit_loc, 0, undefined, w_weapon);
			}
		}
	}
	self thread function_d12c593e(e_inflictor, e_attacker, n_damage, var_73c5e99d, str_means_of_death, w_weapon, v_point, v_direction, str_hit_loc, var_bb4cbbbb, var_22b92c8f, str_surface_type);
	if(!isdefined(self.var_42397ab9))
	{
		self.var_42397ab9 = [];
	}
	if(!array::contains(self.var_42397ab9, e_attacker))
	{
		self.var_42397ab9[self.var_42397ab9.size] = e_attacker;
	}
	if(self function_2dce8d67())
	{
		var_2dce8d67 = 1;
	}
	if(isdefined(level.zombie_vars[e_attacker.team]["zombie_insta_kill"]) && level.zombie_vars[e_attacker.team]["zombie_insta_kill"])
	{
		if(isdefined(var_2dce8d67) && var_2dce8d67)
		{
			n_damage = n_damage * 1.5;
		}
		else
		{
			self.health = 1;
			var_c13cf7dd = 1;
		}
	}
	if(isdefined(e_attacker.cookedTime) && e_attacker.cookedTime > 300 && issubstr(str_means_of_death, "MOD_GRENADE"))
	{
		var_5567414f = 1 + 0.02 * e_attacker.cookedTime - 1000;
		var_94aafc21 = 1;
		if(level.round_number > 0 && level.round_number % 5 == 1)
		{
			var_12ac46ba = level.round_number - 1 / 5;
			var_a168ae5b = 17;
			if(var_12ac46ba > var_a168ae5b)
			{
				var_12ac46ba = var_a168ae5b;
			}
			for(i = 0; i < var_12ac46ba; i++)
			{
				var_94aafc21 = var_94aafc21 * 1.25;
			}
		}
		else if(isdefined(var_2dce8d67) && var_2dce8d67)
		{
			n_damage = n_damage * var_5567414f * var_94aafc21 / 10;
		}
		else
		{
			n_damage = n_damage * var_5567414f * var_94aafc21;
		}
	}
	var_8ccd861d = self thread function_f22f093d(e_inflictor, e_attacker, n_damage, var_73c5e99d, str_means_of_death, w_weapon, v_point, v_direction, str_hit_loc, var_bb4cbbbb, var_22b92c8f, str_surface_type);
	if(issubstr(w_weapon.name, "minigun") || w_weapon == level.zombie_powerup_weapon["minigun"])
	{
		is_minigun = 1;
		if(isdefined(var_2dce8d67) && var_2dce8d67)
		{
			n_damage = n_damage * 2;
		}
		else
		{
			self.health = 1;
		}
	}
	if(w_weapon.name == "special_crossbow_dw" || w_weapon.name == "special_crossbow_dw_upgraded")
	{
		n_damage = n_damage * 3;
	}
	if(level.round_number > 10 && !level flag::get("classic_enabled"))
	{
		if(level.round_number < 35 || (level.round_number < 35 && zm_weapons::is_weapon_upgraded(w_weapon)))
		{
			var_49503885 = level.round_number;
		}
		else
		{
			var_49503885 = 35;
		}
		if(zm_weapons::is_weapon_upgraded(w_weapon))
		{
			var_9c34c6c2 = e_attacker function_871a41a6(n_damage, w_weapon, 1);
			if(isdefined(var_9c34c6c2))
			{
				if(level flag::get("debug_dev"))
				{
					iprintlnbold("Upgraded Weapon Multiplier: " + var_9c34c6c2);
				}
				if(e_attacker hasperk("specialty_doubletap2"))
				{
				}
				else
				{
				}
				n_damage = int(n_damage + n_damage * var_49503885 * 0.019 * var_9c34c6c2);
			}
			else if(e_attacker hasperk("specialty_doubletap2"))
			{
			}
			else
			{
			}
			n_damage = int(n_damage + n_damage * var_49503885 * 0.008);
		}
		else
		{
			var_9c34c6c2 = e_attacker function_871a41a6(n_damage, w_weapon, 0);
			if(isdefined(var_9c34c6c2))
			{
				if(level flag::get("debug_dev"))
				{
					iprintlnbold("Weapon Multiplier: " + var_9c34c6c2);
				}
				if(e_attacker hasperk("specialty_doubletap2"))
				{
				}
				else
				{
				}
				n_damage = int(n_damage + n_damage * var_49503885 * 0.019 * var_9c34c6c2);
			}
			else if(e_attacker hasperk("specialty_doubletap2"))
			{
			}
			else
			{
			}
			n_damage = int(n_damage + n_damage * var_49503885 * 0.019);
		}
	}
	if(isdefined(w_weapon.dualWieldWeapon) && w_weapon.dualWieldWeapon != level.weaponnone && (issubstr(w_weapon.name, "ldw") || issubstr(w_weapon.name, "lh")))
	{
		var_480fed80 = e_attacker function_1239e0ad(w_weapon.dualWieldWeapon);
		if(isdefined(var_480fed80))
		{
			if(var_480fed80.var_a39a2843 >= 1)
			{
				n_damage = n_damage * var_480fed80.var_a39a2843 * level.var_eae5b518[var_480fed80.var_a39a2843];
			}
		}
	}
	else
	{
		var_480fed80 = e_attacker function_1239e0ad(w_weapon);
		if(isdefined(var_480fed80))
		{
			if(var_480fed80.var_a39a2843 >= 1)
			{
				n_damage = n_damage * var_480fed80.var_a39a2843 * level.var_eae5b518[var_480fed80.var_a39a2843];
			}
		}
	}
	if(level.round_number > 10 && str_means_of_death != "MOD_MELEE_WEAPON_BUTT" && str_means_of_death != "MOD_MELEE" && str_means_of_death != "MOD_MELEE_ASSASSINATE" && !level flag::get("classic_enabled"))
	{
		var_32e25858 = e_attacker function_927ab3e5(e_attacker hasperk("specialty_doubletap2"), e_attacker is_shotgun(w_weapon));
		n_damage = n_damage * var_32e25858;
	}
	if(str_hit_loc == "head" || str_hit_loc == "helmet" && str_means_of_death != "MOD_MELEE_WEAPON_BUTT" && str_means_of_death != "MOD_MELEE" && str_means_of_death != "MOD_MELEE_ASSASSINATE" && !level flag::get("classic_enabled"))
	{
		var_5956b503 = e_attacker function_8cf695b8(e_attacker hasperk("specialty_deadshot"));
		n_damage = n_damage * var_5956b503;
		is_headshot = 1;
	}
	if(isdefined(e_attacker.var_fa202141["player_playerdifficulty"]) && e_attacker.var_fa202141["player_playerdifficulty"] > 0)
	{
		multiplier = 0.8 - e_attacker.var_fa202141["player_playerdifficulty"] * 0.005;
		n_damage = n_damage * multiplier;
	}
	if(isdefined(level.var_18ffd3f2[e_attacker getxuid(1)]) && e_attacker.var_f4d01b67["fx_damage"] == 0 && randomintrange(1, 100) < 30)
	{
		switch(level.var_18ffd3f2[e_attacker getxuid(1)].rank)
		{
			case "master":
			case "paragon":
			case "ultimate":
			{
				if(self.health - n_damage < 1)
				{
					self thread function_ec39f1ff(level._effect["zm_weapon_vip_death"], "tag_origin", "fireworks_show");
				}
				else
				{
					self thread function_ec39f1ff(level._effect["zm_weapon_vip_damage"], "j_spine4", undefined);
					break;
				}
			}
		}
	}
	if(isdefined(e_attacker.hud_damagefeedback_additional) && e_attacker.var_f4d01b67["hitmarkers"] == 0)
	{
		self thread function_d2b0307(e_attacker, n_damage, str_hit_loc, str_means_of_death);
	}
	if(level.headshots_only && (str_hit_loc != "head" || str_hit_loc != "helmet"))
	{
		return -1;
	}
	e_attacker thread namespace_97ac1184::function_1d39abf6("end_game_total_damage", n_damage, 0);
	var_3ef05c92 = e_attacker.pers["end_game_total_damage"] / e_attacker.pers["total_hits"] - e_attacker.pers["end_game_total_hits"];
	e_attacker thread namespace_97ac1184::function_1d39abf6("end_game_average_damage", var_3ef05c92, 0);
	if(n_damage > e_attacker.pers["end_game_highest_damage"])
	{
		e_attacker thread namespace_97ac1184::function_1d39abf6("end_game_highest_damage", n_damage, 0);
	}
	if(e_attacker.var_f4d01b67["damage_numbers"] == 0)
	{
		self thread function_59adaa49(e_attacker, n_damage, v_point, 0, is_headshot, is_minigun, var_c13cf7dd, var_8ccd861d);
	}
	return n_damage;
}

/*
	Name: is_shotgun
	Namespace: namespace_5e1f56dc
	Checksum: 0x424F4353
	Offset: 0x9EA0
	Size: 0x70
	Parameters: 1
	Flags: None
	Line Number: 2705
*/
function is_shotgun(weapon)
{
	shotguns = array("shotgun_pump", "shotgun_precision", "shotgun_fullauto", "shotgun_energy", "shotgun_semiauto");
	return isinarray(shotguns, weapon);
}

/*
	Name: function_8cf695b8
	Namespace: namespace_5e1f56dc
	Checksum: 0x424F4353
	Offset: 0x9F18
	Size: 0x200
	Parameters: 1
	Flags: None
	Line Number: 2721
*/
function function_8cf695b8(var_40be383d)
{
	multiplier = 1;
	if(isdefined(self.var_fa202141["player_playerdifficulty"]) && self.var_fa202141["player_playerdifficulty"] > 0)
	{
		multiplier = 1 - self.var_fa202141["player_playerdifficulty"] * 0.003;
	}
	rand = randomfloatrange(0, 1);
	if(var_40be383d)
	{
		if(rand <= 0.5)
		{
			return 0.5 * multiplier * randomfloatrange(1, 1.3);
		}
		else if(rand <= 0.8)
		{
			return 0.5 * multiplier * randomfloatrange(1.3, 1.9);
		}
		else
		{
			return 0.5 * multiplier * randomfloatrange(1.9, 2.8);
		}
	}
	else if(rand <= 0.7)
	{
		return 0.4 * multiplier * randomfloatrange(1, 1.2);
	}
	else if(rand <= 0.9)
	{
		return 0.4 * multiplier * randomfloatrange(1.2, 1.6);
	}
	else
	{
		return 0.4 * multiplier * randomfloatrange(1.6, 2.2);
	}
}

/*
	Name: function_927ab3e5
	Namespace: namespace_5e1f56dc
	Checksum: 0x424F4353
	Offset: 0xA120
	Size: 0x228
	Parameters: 2
	Flags: None
	Line Number: 2768
*/
function function_927ab3e5(var_684cdff, var_b17eaa4d)
{
	multiplier = 1;
	if(isdefined(var_b17eaa4d) && var_b17eaa4d)
	{
		return randomfloatrange(0.9, 1.5);
	}
	if(isdefined(self.var_fa202141["player_playerdifficulty"]) && self.var_fa202141["player_playerdifficulty"] > 0)
	{
		multiplier = 1 - self.var_fa202141["player_playerdifficulty"] * 0.003;
	}
	rand = randomfloatrange(0, 1);
	if(var_684cdff)
	{
		if(rand <= 0.5)
		{
			return multiplier * randomfloatrange(1, 1.3);
		}
		else if(rand <= 0.8)
		{
			return multiplier * randomfloatrange(1.6, 3);
		}
		else
		{
			return multiplier * randomfloatrange(3.4, 4.5);
		}
	}
	else if(rand <= 0.7)
	{
		return 0.8 * multiplier * randomfloatrange(1, 1.4);
	}
	else if(rand <= 0.9)
	{
		return 0.8 * multiplier * randomfloatrange(1.4, 1.8);
	}
	else
	{
		return 0.8 * multiplier * randomfloatrange(1.8, 3);
	}
}

/*
	Name: function_d2b0307
	Namespace: namespace_5e1f56dc
	Checksum: 0x424F4353
	Offset: 0xA350
	Size: 0x4C0
	Parameters: 4
	Flags: None
	Line Number: 2819
*/
function function_d2b0307(player, n_damage, str_hit_loc, str_means_of_death)
{
	shader = "damage_feedback";
	var_a8c6a152 = array(24, 48);
	switch(player.var_f4d01b67["hitmarkers"])
	{
		default
		{
			if(self.health - n_damage < 1)
			{
				shader = "damage_feedback_glow_orange";
				var_a8c6a152 = array(24, 48);
			}
			else
			{
				shader = "damage_feedback";
				var_a8c6a152 = array(24, 48);
				break;
			}
		}
	}
	switch(player.var_f4d01b67["hitmarker_sounds"])
	{
		case 0:
		{
			if(self.health - n_damage < 1)
			{
				if(str_hit_loc == "head" || str_hit_loc == "helmet" || str_means_of_death == "MOD_HEAD_SHOT")
				{
					sound = "uem_hitmarker_headshot";
				}
				else
				{
					sound = "uem_hitmarker_death";
				}
			}
			else
			{
				sound = "uem_hitmarker_default";
				break;
			}
		}
		case 2:
		{
			if(self.health - n_damage < 1)
			{
				sound = "uem_hitmarker_minecraft_death";
			}
			else
			{
				sound = "uem_hitmarker_minecraft_default";
				break;
			}
		}
	}
	if(player.var_f4d01b67["hitmarker_sounds"] == 0)
	{
		player playsoundtoplayer(sound, player);
	}
	if(self.health - n_damage < 1)
	{
		player.hud_damagefeedback_additional.x = -14;
		player.hud_damagefeedback_additional.y = -14;
		player.hud_damagefeedback_additional setshader(shader, var_a8c6a152[0], var_a8c6a152[1]);
		player.hud_damagefeedback_additional.alpha = 1;
		player.hud_damagefeedback_additional scaleovertime(0.1, 34, 58);
		wait(0.4);
		player.hud_damagefeedback_additional scaleovertime(0.1, var_a8c6a152[0], var_a8c6a152[1]);
		wait(0.4);
		player.hud_damagefeedback_additional fadeovertime(0.2);
		player.hud_damagefeedback_additional.alpha = 0;
	}
	else
	{
		player.hud_damagefeedback_additional.x = -12;
		player.hud_damagefeedback_additional.y = -12;
		player.hud_damagefeedback_additional setshader(shader, var_a8c6a152[0], var_a8c6a152[1]);
		player.hud_damagefeedback_additional.alpha = 1;
		player.hud_damagefeedback_additional scaleovertime(0.1, 28, 52);
		wait(0.4);
		player.hud_damagefeedback_additional scaleovertime(0.1, var_a8c6a152[0], var_a8c6a152[1]);
		wait(0.4);
		player.hud_damagefeedback_additional fadeovertime(0.2);
		player.hud_damagefeedback_additional.alpha = 0;
	}
}

/*
	Name: function_ec39f1ff
	Namespace: namespace_5e1f56dc
	Checksum: 0x424F4353
	Offset: 0xA818
	Size: 0x90
	Parameters: 3
	Flags: None
	Line Number: 2916
*/
function function_ec39f1ff(fx, tag, sound)
{
	if(isdefined(self) && isalive(self))
	{
		if(isdefined(sound))
		{
			playsoundatposition(sound, self.origin);
		}
		if(isdefined(fx))
		{
			playfxontag(fx, self, tag);
			return;
		}
	}
	ERROR: Exception occured: Stack empty.
}

/*
	Name: function_871a41a6
	Namespace: namespace_5e1f56dc
	Checksum: 0x424F4353
	Offset: 0xA8B0
	Size: 0x198
	Parameters: 3
	Flags: None
	Line Number: 2943
*/
function function_871a41a6(n_damage, w_weapon, upgraded)
{
	w_weapon = zm_weapons::get_nonalternate_weapon(w_weapon);
	if(isdefined(w_weapon.rootweapon))
	{
		w_weapon = w_weapon.rootweapon;
	}
	weapon_check = w_weapon.name;
	var_cde9f622 = strtok(w_weapon.name, "_");
	if(isdefined(upgraded) && upgraded)
	{
		weapon_check = var_cde9f622[0] + "_" + var_cde9f622[1];
	}
	if(isdefined(level.var_9458e47[weapon_check]))
	{
		if(issubstr(weapon_check, level.var_9458e47[weapon_check].weapon))
		{
			if(isdefined(upgraded) && upgraded)
			{
				return float(level.var_9458e47[weapon_check].var_1ed30589);
			}
			else
			{
				return float(level.var_9458e47[weapon_check].var_f4340604);
			}
		}
	}
	return undefined;
}

/*
	Name: function_672cee89
	Namespace: namespace_5e1f56dc
	Checksum: 0x424F4353
	Offset: 0xAA50
	Size: 0x10
	Parameters: 0
	Flags: None
	Line Number: 2983
*/
function function_672cee89()
{
	return "gamedata/weapons/damage_multiplier/zm_damage_multiplier.csv";
}

/*
	Name: checkStringValid
	Namespace: namespace_5e1f56dc
	Checksum: 0x424F4353
	Offset: 0xAA68
	Size: 0x28
	Parameters: 1
	Flags: None
	Line Number: 2998
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
	Name: function_99b02ca6
	Namespace: namespace_5e1f56dc
	Checksum: 0x424F4353
	Offset: 0xAA98
	Size: 0x908
	Parameters: 15
	Flags: None
	Line Number: 3017
*/
function function_99b02ca6(e_inflictor, e_attacker, n_damage, var_df862ae6, str_means_of_death, w_weapon, v_point, v_direction, str_hit_loc, v_damage_origin, var_bb4cbbbb, var_e37399f9, n_model_index, str_part_name, str_surface_type)
{
	if(!isdefined(e_attacker) || !isplayer(e_attacker) || !isdefined(w_weapon))
	{
		return n_damage;
	}
	if(!isdefined(self.var_42397ab9))
	{
		self.var_42397ab9 = [];
	}
	if(!array::contains(self.var_42397ab9, e_attacker))
	{
		self.var_42397ab9[self.var_42397ab9.size] = e_attacker;
	}
	if(isdefined(level.zombie_vars[e_attacker.team]["zombie_insta_kill"]) && level.zombie_vars[e_attacker.team]["zombie_insta_kill"])
	{
		self.health = 1;
	}
	if(issubstr(w_weapon.name, "minigun") || w_weapon == level.zombie_powerup_weapon["minigun"])
	{
		self.health = 1;
	}
	if(level.round_number > 10 && (!(isdefined(level.var_679e1a9e) && level.var_679e1a9e)) || (level.round_number > 10 && level.var_bdc116e3 > 2))
	{
		if(level.round_number < 35 || (level.round_number < 35 && zm_weapons::is_weapon_upgraded(w_weapon)))
		{
			var_49503885 = level.round_number;
		}
		else
		{
			var_49503885 = 35;
		}
		if(zm_weapons::is_weapon_upgraded(w_weapon))
		{
			var_9c34c6c2 = e_attacker function_871a41a6(n_damage, w_weapon, 1);
			if(isdefined(var_9c34c6c2))
			{
				if(level flag::get("debug_dev"))
				{
					iprintlnbold("Upgraded Weapon Multiplier: " + var_9c34c6c2);
				}
				if(e_attacker hasperk("specialty_doubletap2"))
				{
				}
				else
				{
				}
				n_damage = int(n_damage + n_damage * var_49503885 * 0.019 * var_9c34c6c2);
			}
			else if(e_attacker hasperk("specialty_doubletap2"))
			{
			}
			else
			{
			}
			n_damage = int(n_damage + n_damage * var_49503885 * 0.008);
		}
		else
		{
			var_9c34c6c2 = e_attacker function_871a41a6(n_damage, w_weapon, 0);
			if(isdefined(var_9c34c6c2))
			{
				if(level flag::get("debug_dev"))
				{
					iprintlnbold("Weapon Multiplier: " + var_9c34c6c2);
				}
				if(e_attacker hasperk("specialty_doubletap2"))
				{
				}
				else
				{
				}
				n_damage = int(n_damage + n_damage * var_49503885 * 0.019 * var_9c34c6c2);
			}
			else if(e_attacker hasperk("specialty_doubletap2"))
			{
			}
			else
			{
			}
			n_damage = int(n_damage + n_damage * var_49503885 * 0.019);
		}
	}
	var_480fed80 = e_attacker function_1239e0ad(w_weapon);
	if(isdefined(var_480fed80))
	{
		if(var_480fed80.var_a39a2843 >= 1)
		{
			if(isdefined(level.var_679e1a9e) && level.var_679e1a9e)
			{
				n_damage = n_damage * var_480fed80.var_a39a2843 * level.var_eae5b518[var_480fed80.var_a39a2843] * 0.82;
			}
			else
			{
				n_damage = n_damage * var_480fed80.var_a39a2843 * level.var_eae5b518[var_480fed80.var_a39a2843];
			}
		}
	}
	if(level.headshots_only && (str_hit_loc != "head" && str_hit_loc != "helmet"))
	{
		return n_damage;
	}
	if(array::contains(level.var_1fbd3ed, e_attacker getxuid(1)) && e_attacker.var_f4d01b67["fx_damage"] == 0 && randomintrange(1, 100) < 30)
	{
		if(self.health - n_damage < 1)
		{
			self thread function_ec39f1ff(level._effect["zm_weapon_vip_death"], "tag_origin", "fireworks_show");
		}
		else
		{
			self thread function_ec39f1ff(level._effect["zm_weapon_vip_damage"], "j_spine4", undefined);
		}
	}
	if(isdefined(e_attacker.hud_damagefeedback_additional) && e_attacker.var_f4d01b67["hitmarkers"] == 0)
	{
		if(self.health - n_damage < 1)
		{
			e_attacker.hud_damagefeedback_additional setshader("damage_feedback_glow_orange", 24, 48);
		}
		else if(isdefined(self.armored) && self.armored)
		{
			e_attacker.hud_damagefeedback_additional setshader("spx_hitmarker_shield", 24, 24);
			e_attacker playsoundtoplayer("damage_feedback_armor_impact", e_attacker);
		}
		else
		{
			e_attacker.hud_damagefeedback_additional setshader("damage_feedback", 24, 48);
		}
		e_attacker.hud_damagefeedback_additional.alpha = 1;
		e_attacker.hud_damagefeedback_additional fadeovertime(1);
		e_attacker.hud_damagefeedback_additional.alpha = 0;
	}
	self globallogic_vehicle::Callback_VehicleDamage(e_inflictor, e_attacker, n_damage, var_df862ae6, str_means_of_death, w_weapon, v_point, v_direction, str_hit_loc, v_damage_origin, var_bb4cbbbb, var_e37399f9, n_model_index, str_part_name, str_surface_type);
	return n_damage;
}

/*
	Name: create_unitrigger
	Namespace: namespace_5e1f56dc
	Checksum: 0x424F4353
	Offset: 0xB3A8
	Size: 0x1B8
	Parameters: 5
	Flags: None
	Line Number: 3163
*/
function create_unitrigger(str_hint, n_radius, func_prompt_and_visibility, func_unitrigger_logic, s_trigger_type)
{
	if(!isdefined(n_radius))
	{
		n_radius = 48;
	}
	if(!isdefined(func_prompt_and_visibility))
	{
		func_prompt_and_visibility = &zm_unitrigger::unitrigger_prompt_and_visibility;
	}
	if(!isdefined(func_unitrigger_logic))
	{
		func_unitrigger_logic = &unitrigger_logic;
	}
	if(!isdefined(s_trigger_type))
	{
		s_trigger_type = "unitrigger_radius_use";
	}
	self.s_unitrigger = spawnstruct();
	self.s_unitrigger.origin = self.origin;
	self.s_unitrigger.angles = self.angles;
	self.s_unitrigger.script_unitrigger_type = "unitrigger_box_use";
	self.s_unitrigger.cursor_hint = "HINT_NOICON";
	self.s_unitrigger.hint_string = str_hint;
	self.s_unitrigger.require_look_at = 0;
	self.s_unitrigger.related_parent = self;
	self.s_unitrigger.radius = n_radius;
	zm_unitrigger::unitrigger_force_per_player_triggers(self.s_unitrigger, 1);
	self.s_unitrigger.prompt_and_visibility_func = func_prompt_and_visibility;
	zm_unitrigger::register_static_unitrigger(self.s_unitrigger, func_unitrigger_logic);
}

/*
	Name: unitrigger_logic
	Namespace: namespace_5e1f56dc
	Checksum: 0x424F4353
	Offset: 0xB568
	Size: 0xA8
	Parameters: 0
	Flags: None
	Line Number: 3205
*/
function unitrigger_logic()
{
	self endon("death");
	while(1)
	{
		self waittill("trigger", player);
		if(player zm_utility::in_revive_trigger())
		{
			continue;
		}
		if(player.is_drinking > 0)
		{
			continue;
		}
		if(!zm_utility::is_player_valid(player))
		{
			continue;
		}
		self.stub.related_parent notify("trigger_activated", player);
	}
}

/*
	Name: function_ff00213
	Namespace: namespace_5e1f56dc
	Checksum: 0x424F4353
	Offset: 0xB618
	Size: 0x2E0
	Parameters: 1
	Flags: None
	Line Number: 3237
*/
function function_ff00213(fadetime)
{
	if(tolower(getdvarstring("mapname")) != "zm_castle")
	{
		self clientfield::set("weapon_drop_enable_keyline", 1);
		self clientfield::set("weapon_drop_unpacked_fx", 1);
	}
	else
	{
		self clientfield::set("weapon_drop_enable_keyline", 1);
	}
	wait(0.3);
	self thread function_e1859039();
	self.trigger_use = spawn("trigger_radius_use", self.origin - VectorScale((0, 0, -1), 8), 0, 100, 20);
	self.trigger_use triggerignoreteam();
	self.trigger_use setvisibletoall();
	self.trigger_use setteamfortrigger("none");
	self.trigger_use usetriggerrequirelookat();
	self.trigger_use setcursorhint("HINT_NOICON");
	self.trigger_use sethintstring(&"ZM_MINECRAFT_AMMO_DROP_PROMPT");
	self.var_ba5e26d7 = spawn("trigger_radius", self.origin, 0, 14, 14);
	self.var_ba5e26d7 triggerignoreteam();
	self.var_ba5e26d7 setvisibletoall();
	self.var_ba5e26d7 setteamfortrigger("none");
	self.var_ba5e26d7 setcursorhint("HINT_NOICON");
	self.var_ba5e26d7 sethintstring(&"ZM_MINECRAFT_AMMO_DROP_PROMPT");
	if(isdefined(fadetime))
	{
		self thread function_2aa7612d(fadetime);
	}
	self thread function_8fedabe9();
	self thread function_c71d30f1();
	self thread function_d02b4a40();
}

/*
	Name: function_e1859039
	Namespace: namespace_5e1f56dc
	Checksum: 0x424F4353
	Offset: 0xB900
	Size: 0x120
	Parameters: 5
	Flags: None
	Line Number: 3282
*/
function function_e1859039(var_466503ff, var_278b47c3, var_aa7689cd, var_df20f103, var_620c330d)
{
	if(!isdefined(var_466503ff))
	{
		var_466503ff = 3.5;
	}
	if(!isdefined(var_278b47c3))
	{
		var_278b47c3 = 6;
	}
	if(!isdefined(var_aa7689cd))
	{
		var_aa7689cd = 9;
	}
	if(!isdefined(var_df20f103))
	{
		var_df20f103 = 6;
	}
	if(!isdefined(var_620c330d))
	{
		var_620c330d = 7;
	}
	wait(2);
	self Bobbing((0, 0, 1), var_466503ff, randomintrange(var_278b47c3, var_aa7689cd));
	while(isdefined(self))
	{
		var_ec3f8524 = randomintrange(var_df20f103, var_620c330d);
		self rotateyaw(360, var_ec3f8524);
		wait(var_ec3f8524);
	}
}

/*
	Name: function_d02b4a40
	Namespace: namespace_5e1f56dc
	Checksum: 0x424F4353
	Offset: 0xBA28
	Size: 0x90
	Parameters: 0
	Flags: None
	Line Number: 3324
*/
function function_d02b4a40()
{
	self endon("death");
	while(1)
	{
		self.trigger_use waittill("trigger", player);
		if(!zm_utility::is_player_valid(player) || player laststand::player_is_in_laststand())
		{
			continue;
		}
		self thread ammo_pickup(player);
		break;
	}
}

/*
	Name: function_c71d30f1
	Namespace: namespace_5e1f56dc
	Checksum: 0x424F4353
	Offset: 0xBAC0
	Size: 0x88
	Parameters: 0
	Flags: None
	Line Number: 3349
*/
function function_c71d30f1()
{
	self endon("death");
	while(1)
	{
		self.var_ba5e26d7 waittill("trigger", player);
		if(!zm_utility::is_player_valid(player) || player laststand::player_is_in_laststand())
		{
			continue;
		}
		self thread ammo_pickup(player);
	}
}

/*
	Name: ammo_pickup
	Namespace: namespace_5e1f56dc
	Checksum: 0x424F4353
	Offset: 0xBB50
	Size: 0x380
	Parameters: 1
	Flags: None
	Line Number: 3373
*/
function ammo_pickup(player)
{
	current_weapon = player getcurrentweapon();
	current_weapon = player getbuildkitweapon(current_weapon, 0);
	if(current_weapon.isRiotShield && (current_weapon == level.zombie_powerup_weapon["minigun"] || zm_utility::is_hero_weapon(current_weapon) || current_weapon.name == "none" || current_weapon.name == "zombie_bgb_grab" || current_weapon.name == "zombie_bgb_use" || current_weapon.name == "zombie_beast_grapple_dwr" || current_weapon.name == "staff_revive"))
	{
		return;
	}
	if(!(isdefined(player function_f85156b0(current_weapon)) && player function_f85156b0(current_weapon)))
	{
		return;
	}
	self notify("hash_690bf263");
	var_97dd65ed = current_weapon function_38dd02ea(player);
	wait(0.05);
	if(isdefined(current_weapon function_25b21deb()) && current_weapon function_25b21deb())
	{
		player setweaponammoclip(current_weapon, current_weapon.clipsize + var_97dd65ed);
	}
	else if(player hasperk("specialty_extraammo"))
	{
		if(player getammocount(current_weapon) + var_97dd65ed > current_weapon.maxAmmo)
		{
			player setweaponammostock(current_weapon, current_weapon.maxAmmo);
		}
		else
		{
			player setweaponammostock(current_weapon, player getammocount(current_weapon) + var_97dd65ed);
		}
	}
	else if(player getammocount(current_weapon) + var_97dd65ed > current_weapon.startammo)
	{
		player setweaponammostock(current_weapon, current_weapon.startammo);
	}
	else
	{
		player setweaponammostock(current_weapon, player getammocount(current_weapon) + var_97dd65ed);
	}
	player playsoundtoplayer("iw8_ammo_pickup", player);
}

/*
	Name: function_25b21deb
	Namespace: namespace_5e1f56dc
	Checksum: 0x424F4353
	Offset: 0xBED8
	Size: 0x98
	Parameters: 0
	Flags: None
	Line Number: 3424
*/
function function_25b21deb()
{
	switch(self.name)
	{
		case "elemental_bow":
		case "elemental_bow_demongate":
		case "elemental_bow_rune_prison":
		case "elemental_bow_storm":
		case "elemental_bow_wolf_howl":
		case "t7_staff_air":
		case "t7_staff_air_upgraded":
		case "t7_staff_fire":
		case "t7_staff_fire_upgraded":
		case "t7_staff_lightning":
		case "t7_staff_lightning_upgraded":
		case "t7_staff_water":
		case "t7_staff_water_upgraded":
		{
			return 1;
		}
		default
		{
			return 0;
		}
	}
	return 0;
}

/*
	Name: function_f85156b0
	Namespace: namespace_5e1f56dc
	Checksum: 0x424F4353
	Offset: 0xBF78
	Size: 0x110
	Parameters: 1
	Flags: Private
	Line Number: 3462
*/
function private function_f85156b0(current_weapon)
{
	if(self laststand::player_is_in_laststand() || (isdefined(self.intermission) && self.intermission) || self IsThrowingGrenade())
	{
		return 0;
	}
	if(!zm_utility::is_player_valid(self) || self.is_drinking > 0 || zm_utility::is_placeable_mine(current_weapon) || zm_equipment::is_equipment(current_weapon) || self zm_utility::is_player_revive_tool(current_weapon) || level.weaponnone == current_weapon || self zm_equipment::hacker_active() || zm_utility::is_hero_weapon(current_weapon))
	{
		return 0;
	}
	return 1;
}

/*
	Name: function_38dd02ea
	Namespace: namespace_5e1f56dc
	Checksum: 0x424F4353
	Offset: 0xC090
	Size: 0x898
	Parameters: 1
	Flags: None
	Line Number: 3485
*/
function function_38dd02ea(player)
{
	if(self.rootweapon.name == "ray_gun" || self.rootweapon.name == "raygun_mark2" || self.rootweapon.name == "raygun_mark3" || self.rootweapon.name == "t9_gallo_raygun")
	{
		return 4;
	}
	else if(self.rootweapon.name == "ray_gun_up" || self.rootweapon.name == "raygun_mark2_up" || self.rootweapon.name == "ray_gun_upgraded" || self.rootweapon.name == "raygun_mark2_upgraded" || self.rootweapon.name == "raygun_mark3_up" || self.rootweapon.name == "raygun_mark3_upgraded" || self.rootweapon.name == "t9_gallo_raygun_up")
	{
		return 6;
	}
	if(self.rootweapon.name == "thundergun" || self.rootweapon.name == "idgun_0" || self.rootweapon.name == "idgun_1" || self.rootweapon.name == "idgun_2" || self.rootweapon.name == "idgun_3" || self.rootweapon.name == "idgun_upgraded_0" || self.rootweapon.name == "idgun_upgraded_1" || self.rootweapon.name == "idgun_upgraded_2" || self.rootweapon.name == "idgun_upgraded_3" || self.rootweapon.name == "t7_idgun_genesis_0" || self.rootweapon.name == "t7_idgun_genesis_0_upgraded" || self.rootweapon.name == "shrink_ray" || self.rootweapon.name == "madgaz_cng_zm" || self.rootweapon.name == "madgaz_cng2_zm" || self.rootweapon.name == "madgaz_cng3_zm" || self.rootweapon.name == "tesla_gun" || self.rootweapon.name == "t9_crossbow_skull_up" || self.rootweapon.name == "idgun_genesis_0" || self.rootweapon.name == "idgun_genesis_0_upgraded")
	{
		return 1;
	}
	else if(self.rootweapon.name == "thundergun_upgraded" || self.rootweapon.name == "shrink_ray_upgraded" || self.rootweapon.name == "madgaz_cng_upgraded_zm" || self.rootweapon.name == "madgaz_cng2_upgraded_zm" || self.rootweapon.name == "madgaz_cng3_upgraded_zm" || self.rootweapon.name == "tesla_gun_upgraded" || self.rootweapon.name == "t9_crossbow_skull")
	{
		return 2;
	}
	if(self.rootweapon.name == "t7_staff_air" || self.rootweapon.name == "t7_staff_fire" || self.rootweapon.name == "t7_staff_lightning" || self.rootweapon.name == "t7_staff_water" || self.rootweapon.name == "t7_hero_mirg2000" || self.rootweapon.name == "hero_mirg2000" || self.rootweapon.name == "t8_shotgun_blundergat" || self.rootweapon.name == "t8_shotgun_acidgat" || self.rootweapon.name == "t8_shotgun_magmagat" || self.rootweapon.name == "t8_zombie_tomahawk" || self.rootweapon.name == "t8_zombie_tomahawk" || self.rootweapon.name == "t7_shrink_ray" || self.name == "elemental_bow" || self.rootweapon.name == "t7_microwavegundw" || self.rootweapon.name == "microwavegundw")
	{
		return 2;
	}
	else if(self.rootweapon.name == "t7_staff_air_upgraded" || self.rootweapon.name == "t7_staff_fire_upgraded" || self.rootweapon.name == "t7_staff_lightning_upgraded" || self.rootweapon.name == "t7_staff_water_upgraded" || self.rootweapon.name == "t7_hero_mirg2000_upgraded" || self.rootweapon.name == "hero_mirg2000_upgraded" || self.rootweapon.name == "t8_shotgun_blundergat_upgraded" || self.rootweapon.name == "t8_shotgun_acidgat_upgraded" || self.rootweapon.name == "t8_shotgun_magmagat_upgraded" || self.rootweapon.name == "t8_zombie_tomahawk_upgraded" || self.rootweapon.name == "t7_shrink_ray_upgraded" || self.name == "elemental_bow_rune_prison" || self.name == "elemental_bow_storm" || self.name == "elemental_bow_wolf_howl" || self.name == "elemental_bow_demongate" || self.rootweapon.name == "t7_microwavegundw_upgraded" || self.rootweapon.name == "microwavegundw_upgraded")
	{
		return 3;
	}
	if(self.weapClass == "shotgun")
	{
		return 4;
	}
	else if(self.weapClass == "rifle")
	{
		return 16;
	}
	else if(self.weapClass == "pistol")
	{
		return 8;
	}
	else if(self.weapClass == "lmg")
	{
		return 24;
	}
	else if(self.weapClass == "launcher")
	{
		return 1;
	}
	else if(self.weapClass == "smg")
	{
		return 12;
	}
	if(player getweaponammoclip(self) > 32)
	{
		return 20;
	}
	else
	{
		return 8;
		return;
	}
	ERROR: Exception occured: Stack empty.
}

/*
	Name: function_8fedabe9
	Namespace: namespace_5e1f56dc
	Checksum: 0x424F4353
	Offset: 0xC930
	Size: 0x78
	Parameters: 0
	Flags: None
	Line Number: 3557
*/
function function_8fedabe9()
{
	self waittill("hash_690bf263");
	if(isdefined(self.trigger_use))
	{
		self.trigger_use delete();
	}
	if(isdefined(self.var_ba5e26d7))
	{
		self.var_ba5e26d7 delete();
	}
	self delete();
}

/*
	Name: function_2aa7612d
	Namespace: namespace_5e1f56dc
	Checksum: 0x424F4353
	Offset: 0xC9B0
	Size: 0xE0
	Parameters: 1
	Flags: None
	Line Number: 3581
*/
function function_2aa7612d(fadetime)
{
	self endon("hash_690bf263");
	self endon("death");
	wait(fadetime);
	for(i = 0; i < 40; i++)
	{
		if(i % 2)
		{
			self hide();
		}
		else
		{
			self show();
		}
		if(i < 15)
		{
			wait(0.5);
			continue;
		}
		if(i < 25)
		{
			wait(0.25);
			continue;
		}
		wait(0.1);
	}
	self notify("hash_690bf263");
	return;
	ERROR: Exception occured: Stack empty.
}

/*
	Name: function_c5f97490
	Namespace: namespace_5e1f56dc
	Checksum: 0x424F4353
	Offset: 0xCA98
	Size: 0xD8
	Parameters: 1
	Flags: Private
	Line Number: 3623
*/
function private function_c5f97490(var_34d37a48)
{
	function_8b57c052("saveweaponskill", "");
	for(;;)
	{
		wait(0.05);
		dvar_value = tolower(getdvarstring("saveweaponskill", ""));
		if(isdefined(dvar_value) && dvar_value != "")
		{
			function_8b57c052("saveweaponskill", "");
			getplayers()[0] thread function_7677f493();
		}
	}
}

/*
	Name: function_e8603e7
	Namespace: namespace_5e1f56dc
	Checksum: 0x424F4353
	Offset: 0xCB78
	Size: 0xD8
	Parameters: 1
	Flags: Private
	Line Number: 3648
*/
function private function_e8603e7(var_34d37a48)
{
	function_8b57c052("getweaponskill", "");
	for(;;)
	{
		wait(0.05);
		dvar_value = tolower(getdvarstring("getweaponskill", ""));
		if(isdefined(dvar_value) && dvar_value != "")
		{
			function_8b57c052("getweaponskill", "");
			getplayers()[0] thread function_f11f718a();
		}
	}
}

/*
	Name: function_516e13aa
	Namespace: namespace_5e1f56dc
	Checksum: 0x424F4353
	Offset: 0xCC58
	Size: 0x110
	Parameters: 1
	Flags: Private
	Line Number: 3673
*/
function private function_516e13aa(var_34d37a48)
{
	function_8b57c052("spawn_pack", "");
	for(;;)
	{
		wait(0.05);
		dvar_value = tolower(getdvarstring("spawn_pack", ""));
		if(isdefined(dvar_value) && dvar_value != "")
		{
			function_8b57c052("spawn_pack", "");
			level thread function_475b7b66(level.players[0].origin, level.players[0].angles + VectorScale((0, 1, 0), 90), 1, 0, "original");
		}
	}
}

/*
	Name: function_10363972
	Namespace: namespace_5e1f56dc
	Checksum: 0x424F4353
	Offset: 0xCD70
	Size: 0x1F0
	Parameters: 1
	Flags: Private
	Line Number: 3698
*/
function private function_10363972(var_34d37a48)
{
	function_8b57c052("spawn_ammo", "");
	for(;;)
	{
		wait(0.05);
		dvar_value = tolower(getdvarstring("spawn_ammo", ""));
		if(isdefined(dvar_value) && dvar_value != "")
		{
			function_8b57c052("spawn_ammo", "");
			var_bcce182e = util::spawn_model("tag_origin", getplayers()[0].origin, getplayers()[0].angles);
			var_bcce182e setmodel("zmu_ammo_pack");
			final_pos = zm_weapons::function_a2b97522(getplayers()[0], 50, var_bcce182e);
			var_8f7442a5 = util::ground_position(final_pos, 500, 25);
			var_bcce182e zm_utility::fake_physicslaunch(var_8f7442a5, randomintrange(50, 100));
			var_bcce182e thread function_ff00213(20);
		}
	}
}

/*
	Name: function_c3bfd518
	Namespace: namespace_5e1f56dc
	Checksum: 0x424F4353
	Offset: 0xCF68
	Size: 0xA0
	Parameters: 1
	Flags: Private
	Line Number: 3728
*/
function private function_c3bfd518(var_34d37a48)
{
	function_8b57c052("weapon_damage", 0);
	for(;;)
	{
		wait(0.05);
		dvar_value = tolower(getdvarint("weapon_damage", 0));
		if(isdefined(dvar_value) && dvar_value != "none")
		{
			function_8b57c052("weapon_damage", 0);
		}
	}
}

/*
	Name: function_5a6cb9bd
	Namespace: namespace_5e1f56dc
	Checksum: 0x424F4353
	Offset: 0xD010
	Size: 0x280
	Parameters: 1
	Flags: Private
	Line Number: 3752
*/
function private function_5a6cb9bd(var_34d37a48)
{
	function_8b57c052("upgrade_weapon_special", "none");
	for(;;)
	{
		wait(0.05);
		dvar_value = tolower(getdvarstring("upgrade_weapon_special", "none"));
		if(isdefined(dvar_value) && dvar_value != "none")
		{
			function_8b57c052("upgrade_weapon_special", "none");
			if(dvar_value == "")
			{
				foreach(player in getplayers())
				{
					player function_9c955ddd();
				}
			}
			var_cde9f622 = strtok(dvar_value, " ");
			if(var_cde9f622.size > 1)
			{
				player_index = int(var_cde9f622[0]);
				value = int(var_cde9f622[1]);
				if(player_index >= 0 && player_index <= 7)
				{
					level.players[player_index] function_9c955ddd();
				}
				else
				{
					array::thread_all(getplayers(), &function_9c955ddd);
				}
			}
			else
			{
				array::thread_all(getplayers(), &function_9c955ddd);
			}
		}
	}
}

/*
	Name: function_c41abcf0
	Namespace: namespace_5e1f56dc
	Checksum: 0x424F4353
	Offset: 0xD298
	Size: 0x3B0
	Parameters: 1
	Flags: Private
	Line Number: 3801
*/
function private function_c41abcf0(var_34d37a48)
{
	function_8b57c052("update_w_kills", 0);
	for(;;)
	{
		wait(0.05);
		dvar_value = getdvarint("update_w_kills", 0);
		if(isdefined(dvar_value) && dvar_value != 0)
		{
			function_8b57c052("update_w_kills", 0);
			var_480fed80 = getplayers()[0] function_1c1990e8(getplayers()[0] getcurrentweapon());
			if(isdefined(var_480fed80) && var_480fed80.var_4c25c2f2 < 21)
			{
				var_480fed80.var_79fe8f18 = var_480fed80.var_79fe8f18 + dvar_value;
				getplayers()[0] luinotifyevent(&"spx_gun_level", 2, int(var_480fed80.var_79fe8f18), int(level.var_ce9bfb71[var_480fed80.var_4c25c2f2]));
				iprintlnbold("repack_xp: " + var_480fed80.var_79fe8f18 + " of " + level.var_ce9bfb71[var_480fed80.var_4c25c2f2]);
				if(var_480fed80.var_79fe8f18 >= level.var_ce9bfb71[var_480fed80.var_4c25c2f2])
				{
					var_480fed80.var_4c25c2f2 = var_480fed80.var_4c25c2f2 + 1;
					var_480fed80.var_79fe8f18 = 0;
					var_480fed80.pap_camo_to_use = level.var_1e656cc4[var_480fed80.var_4c25c2f2];
					getplayers()[0] function_c8540b60(self.damageWeapon, getplayers()[0] calcweaponoptions(level.var_1e656cc4[var_480fed80.var_4c25c2f2], 0, 0));
					getplayers()[0] luinotifyevent(&"spx_camo_notification", 1, int(var_480fed80.var_4c25c2f2));
					getplayers()[0] thread function_e5bef058(var_480fed80.var_4c25c2f2);
				}
				getplayers()[0] thread function_7e18304e(var_480fed80.stored_weapon.rootweapon.name, var_480fed80.var_4c25c2f2, var_480fed80.var_79fe8f18);
			}
		}
	}
}

