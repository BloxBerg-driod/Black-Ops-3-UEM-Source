#include scripts\codescripts\struct;
#include scripts\shared\aat_shared;
#include scripts\shared\ai\zombie_utility;
#include scripts\shared\array_shared;
#include scripts\shared\callbacks_shared;
#include scripts\shared\clientfield_shared;
#include scripts\shared\compass;
#include scripts\shared\demo_shared;
#include scripts\shared\flag_shared;
#include scripts\shared\gameobjects_shared;
#include scripts\shared\laststand_shared;
#include scripts\shared\math_shared;
#include scripts\shared\scene_shared;
#include scripts\shared\spawner_shared;
#include scripts\shared\system_shared;
#include scripts\shared\util_shared;
#include scripts\sphynx\leveling\_zm_sphynx_leveling;
#include scripts\sphynx\perks\_zm_perk_frost_brew;
#include scripts\sphynx\weapons\_zm_weapon_drop_system;
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
	Name: function___init__sytem__
	Namespace: namespace_5e1f56dc
	Checksum: 0x424F4353
	Offset: 0x2400
	Size: 0x40
	Parameters: 0
	Flags: AutoExec
	Line Number: 48
*/
function autoexec function___init__sytem__()
{
	namespace_system::function_register("zm_weapon_upgrade_system", &function___init__, &function___main__, undefined);
}

/*
	Name: function___init__
	Namespace: namespace_5e1f56dc
	Checksum: 0x424F4353
	Offset: 0x2448
	Size: 0xC90
	Parameters: 0
	Flags: None
	Line Number: 63
*/
function function___init__()
{
	namespace_clientfield::function_register("scriptmover", "weapon_drop_enable_keyline", 1, 1, "int");
	if(function_ToLower(function_GetDvarString("mapname")) != "zm_castle")
	{
		namespace_clientfield::function_register("scriptmover", "weapon_drop_unpacked_fx", 1, 1, "int");
		namespace_clientfield::function_register("scriptmover", "weapon_drop_level_enable_keyline", 1, 4, "int");
	}
	namespace_callback::function_on_spawned(&function_34636341);
	level.var_e2a6fd15 = [];
	level.var_42a6c418 = [];
	level thread function_160b27f3();
	level.var_eae5b518 = function_Array(0.25, 1, 0.6, 0.55, 0.6, 0.8, 0.9, 1.2, 1.4, 4, 7, 11.2);
	level.var_ce9bfb71 = function_Array(2000, 3500, 5000, 6500, 8000, 10000, 12000, 14000, 16000, 18000, 20000, 23000, 26000, 29000, 32000, 35000, 39000, 43000, 47000, 51000);
	level.var_1e656cc4 = function_Array(1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21);
	level.var_3aa708b = [];
	level.var_3aa708b["soe"] = function_Array("idgun_upgraded", "idgun_0", "idgun_upgraded_0", "idgun_1", "idgun_upgraded_1", "idgun_2", "idgun_upgraded_2", "idgun_3", "idgun_upgraded_3", "idgun_4", "idgun_upgraded_4");
	level.var_3aa708b["giant"] = function_Array("tesla_gun", "tesla_gun_upgraded");
	level.var_3aa708b["castle"] = function_Array("elemental_bow", "elemental_bow1", "elemental_bow2", "elemental_bow3", "elemental_bow4", "elemental_bow_storm", "elemental_bow_storm1", "elemental_bow_storm2", "elemental_bow_storm3", "elemental_bow_storm4", "elemental_bow_demongate", "elemental_bow_demongate1", "elemental_bow_demongate2", "elemental_bow_demongate3", "elemental_bow_demongate4", "elemental_bow_rune_prison", "elemental_bow_rune_prison1", "elemental_bow_rune_prison2", "elemental_bow_rune_prison3", "elemental_bow_rune_prison4", "elemental_bow_wolf", "elemental_bow_wolf1", "elemental_bow_wolf2", "elemental_bow_wolf3", "elemental_bow_wolf4", "elemental_bow_wolf_howl", "elemental_bow_wolf_howl1", "elemental_bow_wolf_howl2", "elemental_bow_wolf_howl3", "elemental_bow_wolf_howl4");
	level.var_3aa708b["island"] = function_Array("t7_hero_mirg2000", "t7_hero_mirg2000_upgraded", "hero_mirg2000", "hero_mirg2000_upgraded");
	level.var_3aa708b["gorod"] = function_Array("raygun_mark3", "raygun_mark3_upgraded");
	level.var_3aa708b["rev"] = function_Array("t7_idgun_genesis_0", "t7_idgun_genesis_0_upgraded", "idgun_genesis_0", "idgun_genesis_0_upgraded");
	level.var_3aa708b["verruckt"] = function_Array("tesla_gun", "tesla_gun_upgraded");
	level.var_3aa708b["shino"] = function_Array("tesla_gun", "tesla_gun_upgraded");
	level.var_3aa708b["kino"] = function_Array("thundergun", "thundergun_upgraded");
	level.var_3aa708b["asc"] = function_Array("thundergun", "thundergun_upgraded");
	level.var_3aa708b["shang"] = function_Array("t7_shrink_ray", "t7_shrink_ray_upgraded", "shrink_ray", "shrink_ray_upgraded");
	level.var_3aa708b["moon"] = function_Array("microwavegundw", "microwavegundw_upgraded", "microwavegun", "microwavegun_upgraded", "microwavegunlh", "microwavegunlh_upgraded");
	level.var_3aa708b["origins"] = function_Array("staff_fire", "staff_fire_upgraded2", "staff_fire_upgraded3", "staff_water", "staff_water_upgraded2", "staff_water_upgraded3", "staff_lightning", "staff_lightning_upgraded2", "staff_lightning_upgraded3", "staff_air", "staff_air_upgraded2", "staff_air_upgraded3");
	level thread function_87a20e06();
	level.var__effect["pack_a_punch_lights_fx"] = "_sphynx/_zm_pack_a_punch_lights";
	level.var__effect["zm_weapon_vip_damage"] = "_sphynx/weapons/_zm_weapon_vip_weapon_sparks";
	level.var__effect["zm_weapon_vip_death"] = "_sphynx/weapons/_zm_weapon_vip_weapon_sparks_fireworks";
	namespace_callback::function_on_connect(&function_player_on_connect);
	namespace_callback::function_on_spawned(&function_ef6ce1d3);
	if(!isdefined(level.var_actor_damage_callbacks))
	{
		level.var_actor_damage_callbacks = [];
	}
	if(!isdefined(level.var_vehicle_damage_callbacks))
	{
		level.var_vehicle_damage_callbacks = [];
	}
	namespace_Array::function_push(level.var_actor_damage_callbacks, &function_bcb41215, 0);
	namespace_Array::function_push(level.var_vehicle_damage_callbacks, &function_99b02ca6, 0);
	level.var_check_for_instakill_override = &function_642d1d4d;
	namespace_zm_spawner::function_register_zombie_death_event_callback(&function_51093d89);
	namespace_Array::function_thread_all(function_GetEntArray("_mc_enchanting_table_pap", "targetname"), &function_e3eae7af);
	level.var_7ceb1b41 = 11;
	level.var_919b0320 = 0;
	level.var_fd6c66c2 = 1;
	namespace_Array::function_thread_all(function_GetEntArray("dsbr_bar_pack_machine", "targetname"), &function_866e6b95);
	namespace_Array::function_thread_all(function_GetEntArray("pap_trig", "targetname"), &function_d161f757);
	namespace_Array::function_thread_all(function_GetEntArray("pack_a_punch_model", "targetname"), &function_3c6665c7);
	wait(0.05);
	level namespace_flag::function_wait_till("initial_blackscreen_passed");
	switch(function_ToLower(function_GetDvarString("mapname")))
	{
		case "zm_moon":
		{
			level notify("hash_Pack_A_Punch_on");
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
	Offset: 0x30E0
	Size: 0xF0
	Parameters: 0
	Flags: None
	Line Number: 188
*/
function function_87a20e06()
{
	wait(0.05);
	level namespace_flag::function_wait_till("debug_dev");
	switch(function_ToLower(function_GetDvarString("mapname")))
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
	return;
	~;
	ERROR: Exception occured: Stack empty.
}

/*
	Name: function_34636341
	Namespace: namespace_5e1f56dc
	Checksum: 0x424F4353
	Offset: 0x31D8
	Size: 0x50
	Parameters: 0
	Flags: None
	Line Number: 219
*/
function function_34636341()
{
	namespace_util::function_wait_network_frame(4);
	if(isdefined(self.var_hud_damagefeedback))
	{
		self.var_hud_damagefeedback function_destroy();
		self.var_hud_damagefeedback = undefined;
	}
}

/*
	Name: function_27f1a29b
	Namespace: namespace_5e1f56dc
	Checksum: 0x424F4353
	Offset: 0x3230
	Size: 0x1B0
	Parameters: 0
	Flags: None
	Line Number: 239
*/
function function_27f1a29b()
{
	var_index = 1;
	var_table = "gamedata/weapons/zm_damage_multiplier.csv";
	for(var_row = function_TableLookupRow(var_table, var_index); isdefined(var_row); var_row = function_TableLookupRow(var_table, var_index))
	{
		var_weapon = function_checkStringValid(var_row[0]);
		var_f4340604 = function_float(function_checkStringValid(var_row[1]));
		var_1ed30589 = function_float(function_checkStringValid(var_row[2]));
		if(isdefined(var_weapon) && var_weapon != "")
		{
			level.var_9458e47[var_weapon] = function_spawnstruct();
			level.var_9458e47[var_weapon].var_weapon = var_weapon;
			level.var_9458e47[var_weapon].var_f4340604 = var_f4340604;
			level.var_9458e47[var_weapon].var_1ed30589 = var_1ed30589;
		}
		var_index++;
	}
}

/*
	Name: function___main__
	Namespace: namespace_5e1f56dc
	Checksum: 0x424F4353
	Offset: 0x33E8
	Size: 0x30
	Parameters: 0
	Flags: None
	Line Number: 269
*/
function function___main__()
{
	wait(0.05);
	level namespace_flag::function_init("pap_beacon_powered");
}

/*
	Name: function_160b27f3
	Namespace: namespace_5e1f56dc
	Checksum: 0x424F4353
	Offset: 0x3420
	Size: 0x140
	Parameters: 0
	Flags: None
	Line Number: 285
*/
function function_160b27f3()
{
	var_index = 1;
	var_table = "gamedata/weapons/weapon_saving_data_index.csv";
	for(var_row = function_TableLookupRow(var_table, var_index); isdefined(var_row); var_row = function_TableLookupRow(var_table, var_index))
	{
		var_bd058c01 = function_checkStringValid(var_row[0]);
		var_type = function_checkStringValid(var_row[1]);
		var_description = function_checkStringValid(var_row[2]);
		if(isdefined(var_bd058c01) && var_bd058c01 != "")
		{
			level.var_e2a6fd15[var_bd058c01] = var_index;
			level.var_42a6c418[var_bd058c01] = var_type;
		}
		var_index++;
	}
	return;
}

/*
	Name: function_7e18304e
	Namespace: namespace_5e1f56dc
	Checksum: 0x424F4353
	Offset: 0x3568
	Size: 0x358
	Parameters: 3
	Flags: None
	Line Number: 314
*/
function function_7e18304e(var_bd058c01, var_3d5fe6a2, var_2b90edc8)
{
	if(!isdefined(var_3d5fe6a2))
	{
		var_3d5fe6a2 = 0;
	}
	if(!isdefined(var_2b90edc8))
	{
		var_2b90edc8 = 0;
	}
	if(self function_IsSplitscreen() && self.var_name == level.var_players[0].var_name + " 1" || (self function_IsSplitscreen() && self.var_name == level.var_players[0].var_name + " 2") || (self function_IsSplitscreen() && self.var_name == level.var_players[0].var_name + " 3") || (self function_IsSplitscreen() && self.var_name == level.var_players[0].var_name + " 4") || (self function_IsSplitscreen() && self.var_name == level.var_players[0].var_name + " 5") || (self function_IsSplitscreen() && self.var_name == level.var_players[0].var_name + " 6") || (self function_IsSplitscreen() && self.var_name == level.var_players[0].var_name + " 7"))
	{
	}
	else
	{
		self function_LUINotifyEvent(&"spx_weapon_save_data", 2, function_Int(level.var_e2a6fd15["xuid"]), function_Int(self function_getxuid(1)));
		wait(0.1);
		self function_LUINotifyEvent(&"spx_weapon_save_data", 2, function_Int(level.var_e2a6fd15["reset_keyword"]), function_Int(35184));
		wait(0.1);
		self function_LUINotifyEvent(&"spx_weapon_save_data", 3, function_Int(level.var_e2a6fd15[var_bd058c01]), function_Int(var_3d5fe6a2), function_Int(var_2b90edc8));
		wait(0.1);
		return;
	}
}

/*
	Name: function_f11f718a
	Namespace: namespace_5e1f56dc
	Checksum: 0x424F4353
	Offset: 0x38C8
	Size: 0x98
	Parameters: 0
	Flags: None
	Line Number: 349
*/
function function_f11f718a()
{
	self endon("hash_disconnect");
	self endon("hash_56a3d9aa");
	self function_SetControllerUIModelValue("UEM.get_weapon_stats", 1);
	self waittill("hash_2eb9fc5a");
	self thread namespace_97ac1184::function_b3489bf5("^3" + self.var_playerName + "^7 loaded Weapon Stats");
	self.var_c6452f46["weapon"] = 1;
	self notify("hash_cb55d4d2");
}

/*
	Name: function_db2310a5
	Namespace: namespace_5e1f56dc
	Checksum: 0x424F4353
	Offset: 0x3968
	Size: 0x208
	Parameters: 0
	Flags: None
	Line Number: 370
*/
function function_db2310a5()
{
	while(!(isdefined(self.var_c6452f46["weapon"]) && self.var_c6452f46["weapon"]))
	{
		wait(0.5);
	}
	var_player_weapons = self function_GetWeaponsListPrimaries();
	foreach(var_weapon in var_player_weapons)
	{
		if(namespace_zm_weapons::function_is_weapon_upgraded(var_weapon))
		{
			var_ed5e1bff = self function_e942fd68(var_weapon);
			if(!(isdefined(var_ed5e1bff) && var_ed5e1bff))
			{
				if(isdefined(self function_c3370d47(var_weapon)) && self function_c3370d47(var_weapon))
				{
					var_de6974d4 = function_spawnstruct();
					var_de6974d4.var_stored_weapon = var_weapon.var_rootweapon;
					var_de6974d4.var_79fe8f18 = var_de6974d4.var_79fe8f18;
					var_de6974d4.var_4c25c2f2 = var_de6974d4.var_4c25c2f2;
					var_de6974d4.var_pap_camo_to_use = level.var_1e656cc4[var_de6974d4.var_4c25c2f2];
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
	Offset: 0x3B78
	Size: 0x80
	Parameters: 0
	Flags: None
	Line Number: 408
*/
function function_e39c79f7()
{
	function_IPrintLnBold(self.var_name + ": Resetting Full Weapon System");
	self function_SetControllerUIModelValue("UEM.get_weapon_stats", 0);
	self.var_c6452f46["weapon"] = 1;
	self notify("hash_cb55d4d2");
	self notify("hash_56a3d9aa");
	return;
	ERROR: Exception occured: Stack empty.
	continue;
}

/*
	Name: function_3a391177
	Namespace: namespace_5e1f56dc
	Checksum: 0x424F4353
	Offset: 0x3C00
	Size: 0x5C0
	Parameters: 0
	Flags: None
	Line Number: 430
*/
function function_3a391177()
{
	self endon("hash_disconnect");
	self endon("hash_56a3d9aa");
	self.var_d31d6052 = 0;
	var_7069805c = 0;
	var_ed5b6ee = [];
	while(1)
	{
		self waittill("hash_menuresponse", var_menu, var_response);
		if(var_menu == "weaponskilldatamenu")
		{
			if(var_response == "stop_sending")
			{
				var_7069805c = 1;
			}
			else
			{
				var_ed5b6ee[var_ed5b6ee.size] = var_response;
			}
			if(var_7069805c)
			{
				break;
			}
		}
	}
	foreach(var_d8234c81 in var_ed5b6ee)
	{
		var_cde9f622 = function_StrTok(var_d8234c81, ",");
		foreach(var_token in var_cde9f622)
		{
			var_b9b0ebb3 = function_StrTok(var_token, "=");
			if(var_b9b0ebb3.size != 3)
			{
				continue;
			}
			var_dataName = function_ToLower(var_b9b0ebb3[0]);
			var_value = var_b9b0ebb3[1];
			var_7c854903 = var_b9b0ebb3[2];
			var_abe6703d = function_ToLower(level.var_42a6c418[var_dataName]);
			switch(var_abe6703d)
			{
				case "player":
				{
					if(var_dataName == "xuid" && var_value != self function_getxuid(1))
					{
						self function_e39c79f7();
					}
					else if(var_dataName == "reset_keyword" && function_Int(var_value) != 35184)
					{
						self function_e39c79f7();
						break;
					}
				}
				case "weapon":
				{
					if(function_Int(var_value) >= 20)
					{
						self.var_d31d6052++;
					}
					var_ed5e1bff = self function_e942fd68(function_GetWeapon(var_dataName));
					if(!(isdefined(var_ed5e1bff) && var_ed5e1bff))
					{
						if(isdefined(self function_c3370d47(function_GetWeapon(var_dataName))) && self function_c3370d47(function_GetWeapon(var_dataName)))
						{
							var_de6974d4 = function_spawnstruct();
							var_de6974d4.var_stored_weapon = function_GetWeapon(var_dataName).var_rootweapon;
							var_de6974d4.var_79fe8f18 = function_Int(var_7c854903);
							var_de6974d4.var_4c25c2f2 = function_Int(var_value);
							var_de6974d4.var_pap_camo_to_use = level.var_1e656cc4[var_de6974d4.var_4c25c2f2];
							self.var_3818be12[self.var_3818be12.size] = var_de6974d4;
						}
					}
					else if(isdefined(var_ed5e1bff))
					{
						var_ed5e1bff.var_stored_weapon = function_GetWeapon(var_dataName).var_rootweapon;
						var_ed5e1bff.var_79fe8f18 = function_Int(var_ed5e1bff.var_79fe8f18 + var_7c854903);
						var_ed5e1bff.var_4c25c2f2 = function_Int(var_ed5e1bff.var_4c25c2f2 + var_value);
						var_ed5e1bff.var_pap_camo_to_use = level.var_1e656cc4[var_ed5e1bff.var_4c25c2f2];
						break;
					}
				}
			}
		}
	}
	self function_SetControllerUIModelValue("UEM.get_weapon_stats", 0);
	self notify("hash_2eb9fc5a");
}

/*
	Name: function_player_on_connect
	Namespace: namespace_5e1f56dc
	Checksum: 0x424F4353
	Offset: 0x41C8
	Size: 0x1F0
	Parameters: 0
	Flags: None
	Line Number: 529
*/
function function_player_on_connect()
{
	self endon("hash_disconnect");
	self.var_f4d01b67["hitmarkers"] = function_Int(0);
	self.var_f4d01b67["hitmarker_sounds"] = function_Int(0);
	self.var_f4d01b67["fx_damage"] = function_Int(0);
	self.var_f4d01b67["damage_numbers"] = function_Int(0);
	self.var_f4d01b67["blood_splatter"] = function_Int(0);
	self.var_f4d01b67["pickup_ui"] = function_Int(0);
	self.var_5511c660 = 0;
	wait(0.05);
	level namespace_flag::function_wait_till("initial_blackscreen_passed");
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
	self namespace_flag::function_wait_till("completed_challenges_stats_loading");
	wait(0.05);
	self thread function_3a391177();
	wait(0.05);
	self thread function_f11f718a();
}

/*
	Name: function_7677f493
	Namespace: namespace_5e1f56dc
	Checksum: 0x424F4353
	Offset: 0x43C0
	Size: 0x50
	Parameters: 0
	Flags: None
	Line Number: 574
*/
function function_7677f493()
{
	self function_LUINotifyEvent(&"spx_weapon_save_data", 2, function_Int(level.var_e2a6fd15["savedata"]), 1);
}

/*
	Name: function_a8a57aa3
	Namespace: namespace_5e1f56dc
	Checksum: 0x424F4353
	Offset: 0x4418
	Size: 0x270
	Parameters: 1
	Flags: None
	Line Number: 589
*/
function function_a8a57aa3(var_response)
{
	var_a788e083 = var_response;
	if(var_a788e083 != "")
	{
		var_data = function_StrTok(var_a788e083, ",");
		if(var_data[0] != self function_getxuid(1) || var_data[1] != 35184)
		{
			self function_LUINotifyEvent(&"spx_gun_level", 2, 0, level.var_ce9bfb71[0]);
		}
		else
		{
			for(var_i = 2; var_i < var_data.size; var_i = 2)
			{
				var_ed5e1bff = self function_e942fd68(function_GetWeapon(var_data[var_i]));
				if(!(isdefined(var_ed5e1bff) && var_ed5e1bff))
				{
					var_de6974d4 = function_spawnstruct();
					var_de6974d4.var_stored_weapon = function_GetWeapon(var_data[var_i]).var_rootweapon;
					var_de6974d4.var_79fe8f18 = function_Int(var_data[var_i + 1]);
					var_de6974d4.var_4c25c2f2 = function_Int(var_data[var_i + 2]);
					var_de6974d4.var_pap_camo_to_use = level.var_1e656cc4[var_de6974d4.var_4c25c2f2];
					self.var_3818be12[self.var_3818be12.size] = var_de6974d4;
				}
			}
			self function_LUINotifyEvent(&"spx_gun_level", 2, 0, level.var_ce9bfb71[0]);
		}
	}
}

/*
	Name: function_ef6ce1d3
	Namespace: namespace_5e1f56dc
	Checksum: 0x424F4353
	Offset: 0x4690
	Size: 0x118
	Parameters: 0
	Flags: None
	Line Number: 629
*/
function function_ef6ce1d3()
{
	self endon("hash_bled_out");
	self endon("hash_spawned_player");
	self endon("hash_disconnect");
	for(;;)
	{
		self waittill("hash_weapon_change_complete");
		var_current_weapon = self function_GetCurrentWeapon();
		var_480fed80 = self function_1c1990e8(var_current_weapon);
		if(isdefined(var_480fed80) && namespace_zm_weapons::function_is_weapon_upgraded(var_current_weapon))
		{
			self function_LUINotifyEvent(&"spx_gun_level", 2, var_480fed80.var_79fe8f18, level.var_ce9bfb71[var_480fed80.var_4c25c2f2]);
		}
		else
		{
			self function_LUINotifyEvent(&"spx_gun_level", 2, 0, 0);
		}
	}
}

/*
	Name: function_475b7b66
	Namespace: namespace_5e1f56dc
	Checksum: 0x424F4353
	Offset: 0x47B0
	Size: 0x2C8
	Parameters: 5
	Flags: Private
	Line Number: 660
*/
function private function_475b7b66(var_origin, var_angles, var_power_on, var_hidden, var_type)
{
	if(!isdefined(var_hidden))
	{
		var_hidden = 0;
	}
	if(!isdefined(var_type))
	{
		var_type = "original";
	}
	var_b2fe474a = namespace_util::function_spawn_model("p7_zm_vending_packapunch", var_origin, var_angles);
	var_collision = function_spawn("script_model", var_b2fe474a.var_origin, 1);
	var_collision.var_angles = var_b2fe474a.var_angles;
	var_collision function_SetModel("zm_collision_perks1");
	var_collision.var_script_noteworthy = "clip";
	var_collision function_disconnectpaths();
	while(!level namespace_flag::function_exists("initial_blackscreen_passed"))
	{
		wait(0.5);
	}
	level namespace_flag::function_wait_till("initial_blackscreen_passed");
	if(isdefined(var_hidden) && var_hidden)
	{
		var_b2fe474a function_Hide();
	}
	else
	{
		var_b2fe474a.var_3508bfff = function_PlayFXOnTag(level.var__effect["pack_a_punch_lights_fx"], var_b2fe474a, "tag_origin");
	}
	var_b2fe474a.var_script_sound = "mus_perks_packa_jingle";
	var_b2fe474a.var_script_label = "mus_perks_packa_sting";
	var_b2fe474a.var_longJingleWait = 1;
	var_b2fe474a thread function_9d8de684(var_power_on, var_hidden);
	var_b2fe474a function_create_unitrigger(&"ZM_MINECRAFT_HINTSTRING_CAN_PACK_A_PUNCH", 128, &function_7e6983a0);
	var_b2fe474a thread function_ed17d6c(var_type);
	if(function_ToLower(function_GetDvarString("mapname")) == "zm_zod")
	{
		var_b2fe474a thread function_27c3c66f();
	}
}

/*
	Name: function_27c3c66f
	Namespace: namespace_5e1f56dc
	Checksum: 0x424F4353
	Offset: 0x4A80
	Size: 0x30
	Parameters: 0
	Flags: None
	Line Number: 711
*/
function function_27c3c66f()
{
	level namespace_flag::function_wait_till("ritual_pap_complete");
	self.var_977bc4ba = 1;
}

/*
	Name: function_9d8de684
	Namespace: namespace_5e1f56dc
	Checksum: 0x424F4353
	Offset: 0x4AB8
	Size: 0x250
	Parameters: 2
	Flags: None
	Line Number: 727
*/
function function_9d8de684(var_power_on, var_hidden)
{
	if(!isdefined(var_hidden))
	{
		var_hidden = 0;
	}
	if(isdefined(var_power_on) && var_power_on)
	{
		self.var_977bc4ba = 1;
		for(;;)
		{
			level namespace_util::function_waittill_any_return("power_off");
			self.var_977bc4ba = 0;
			if(!(isdefined(var_hidden) && var_hidden))
			{
				self function_SetModel("p7_zm_vending_packapunch");
			}
			self function_StopLoopSound(0.1);
			level namespace_util::function_waittill_any_return("power_on", "ritual_pap_complete");
			self.var_977bc4ba = 1;
			if(!(isdefined(var_hidden) && var_hidden))
			{
				self function_SetModel("p7_zm_vending_packapunch_on");
			}
			self function_PlayLoopSound("zmb_perks_packa_loop");
		}
	}
	else
	{
		self.var_977bc4ba = 0;
		for(;;)
		{
			level namespace_util::function_waittill_any_return("power_on", "ritual_pap_complete");
			self.var_977bc4ba = 1;
			if(!(isdefined(var_hidden) && var_hidden))
			{
				self function_SetModel("p7_zm_vending_packapunch_on");
			}
			self function_PlayLoopSound("zmb_perks_packa_loop");
			level namespace_util::function_waittill_any_return("power_off", "ritual_pap_complete");
			self.var_977bc4ba = 0;
			if(!(isdefined(var_hidden) && var_hidden))
			{
				self function_SetModel("p7_zm_vending_packapunch");
			}
			self function_StopLoopSound(0.1);
		}
	}
}

/*
	Name: function_e3eae7af
	Namespace: namespace_5e1f56dc
	Checksum: 0x424F4353
	Offset: 0x4D10
	Size: 0x90
	Parameters: 0
	Flags: None
	Line Number: 787
*/
function function_e3eae7af()
{
	self thread function_db2e4f3f();
	self thread function_e230860b();
	self.var_977bc4ba = 1;
	self function_create_unitrigger(&"ZM_MINECRAFT_HINTSTRING_CAN_PACK_A_PUNCH", 128, &function_7e6983a0);
	self thread function_ed17d6c();
}

/*
	Name: function_866e6b95
	Namespace: namespace_5e1f56dc
	Checksum: 0x424F4353
	Offset: 0x4DA8
	Size: 0x210
	Parameters: 0
	Flags: None
	Line Number: 806
*/
function function_866e6b95()
{
	wait(0.05);
	level namespace_flag::function_wait_till("initial_blackscreen_passed");
	var_trigger_target = function_GetEnt("dsbr_bar_pack_machine", "targetname");
	var_3be010a7 = undefined;
	var_keys = function_getArrayKeys(level.var_zones);
	for(var_i = 0; var_i < var_keys.size; var_i++)
	{
		if(isdefined(level.var_zones[var_keys[var_i]].var_unitrigger_stubs))
		{
			foreach(var_unitrigger in level.var_zones[var_keys[var_i]].var_unitrigger_stubs)
			{
				if(isdefined(var_unitrigger.var_trigger_target) && var_unitrigger.var_trigger_target == var_trigger_target)
				{
					var_3be010a7 = var_unitrigger;
					break;
				}
			}
		}
	}
	namespace_zm_unitrigger::function_unregister_unitrigger(var_3be010a7);
	self.var_977bc4ba = 1;
	self function_create_unitrigger(&"ZM_MINECRAFT_HINTSTRING_CAN_PACK_A_PUNCH", 128, &function_7e6983a0);
	self thread function_ed17d6c();
	return;
	level.var_zones[var_keys[var_i]].var_0 = undefined;
}

/*
	Name: function_d161f757
	Namespace: namespace_5e1f56dc
	Checksum: 0x424F4353
	Offset: 0x4FC0
	Size: 0x78
	Parameters: 0
	Flags: None
	Line Number: 845
*/
function function_d161f757()
{
	wait(0.05);
	level namespace_flag::function_wait_till("initial_blackscreen_passed");
	self function_create_unitrigger(&"ZM_MINECRAFT_HINTSTRING_CAN_PACK_A_PUNCH", 128, &function_7e6983a0);
	self thread function_ed17d6c();
	return;
	ERROR: Bad function call
}

/*
	Name: function_3c6665c7
	Namespace: namespace_5e1f56dc
	Checksum: 0x424F4353
	Offset: 0x5040
	Size: 0xD8
	Parameters: 0
	Flags: None
	Line Number: 865
*/
function function_3c6665c7()
{
	wait(0.05);
	level namespace_flag::function_wait_till("initial_blackscreen_passed");
	var_aa37ce2d = function_GetEnt("pack_a_punch_trig", "targetname");
	wait(0.05);
	var_aa37ce2d function_delete();
	self thread function_9d8de684(0, 1);
	self function_create_unitrigger(&"ZM_MINECRAFT_HINTSTRING_CAN_PACK_A_PUNCH", 128, &function_7e6983a0);
	self thread function_ed17d6c();
}

/*
	Name: function_e230860b
	Namespace: namespace_5e1f56dc
	Checksum: 0x424F4353
	Offset: 0x5120
	Size: 0x60
	Parameters: 0
	Flags: None
	Line Number: 887
*/
function function_e230860b()
{
	for(;;)
	{
		self thread namespace_scene::function_Play("_mc_entity_enchanting_table_book_close", self);
		self waittill("hash_27d369a0");
		self thread namespace_scene::function_Play("_mc_entity_enchanting_table_book_open", self);
		self waittill("hash_f1b18632");
	}
}

/*
	Name: function_db6319b2
	Namespace: namespace_5e1f56dc
	Checksum: 0x424F4353
	Offset: 0x5188
	Size: 0x710
	Parameters: 0
	Flags: Private
	Line Number: 908
*/
function private function_db6319b2()
{
	level endon("hash_Pack_A_Punch_off");
	var_pap_machine = self;
	self.var_pap_machine = var_pap_machine;
	var_packa_rollers = function_spawn("script_origin", self.var_origin);
	var_packa_timer = function_spawn("script_origin", self.var_origin);
	var_packa_rollers function_LinkTo(self);
	var_packa_timer function_LinkTo(self);
	var_power_off = !self function_is_on();
	if(var_power_off)
	{
		var_pap_array = [];
		var_pap_array[0] = var_pap_machine;
		level waittill("hash_Pack_A_Punch_on");
	}
	if(isdefined(level.var_pack_a_punch.var_power_on_callback))
	{
		var_pap_machine thread [[level.var_pack_a_punch.var_power_on_callback]]();
	}
	self thread function_pack_a_punch_machine_trigger_think();
	var_pap_machine function_PlayLoopSound("zmb_perks_packa_loop");
	self thread function_shutOffPAPSounds(var_pap_machine, var_packa_rollers, var_packa_timer);
	self.var_53c64808 = 0;
	self.var_wait_for_player_to_take = 0;
	for(;;)
	{
		wait(0.5);
		self.var_pack_player = undefined;
		self waittill("hash_trigger_activated", var_player);
		if(isdefined(self.var_53c64808) && self.var_53c64808 || (isdefined(self.var_wait_for_player_to_take) && self.var_wait_for_player_to_take))
		{
			function_iprintln("Pack in use or player waiting");
		}
		else
		{
			var_index = namespace_zm_utility::function_get_player_index(var_player);
			var_current_weapon = var_player function_GetCurrentWeapon();
			var_current_weapon = var_player namespace_zm_weapons::function_switch_from_alt_weapon(var_current_weapon);
			if(!(isdefined(var_player function_player_use_can_pack_now()) && var_player function_player_use_can_pack_now()))
			{
			}
			else
			{
				var_current_cost = var_player.var_439d3100;
				if(var_player function_IsSwitchingWeapons())
				{
					wait(0.1);
					if(var_player function_IsSwitchingWeapons())
					{
					}
				}
				else
				{
					self function_playsound("zmb_perks_packa_deny");
					if(isdefined(level.var_pack_a_punch.var_custom_deny_func))
					{
						var_player [[level.var_pack_a_punch.var_custom_deny_func]]();
					}
					else
					{
						var_player namespace_zm_audio::function_create_and_play_dialog("general", "outofmoney", 0);
					}
					else
					{
						var_player namespace_zm_stats::function_increment_client_stat("use_pap");
						var_player namespace_zm_stats::function_increment_player_stat("use_pap");
						var_player thread namespace_97ac1184::function_1d39abf6("end_game_use_pap", 1, 0);
						var_player thread namespace_97ac1184::function_7e18304e("spx_save_data", "use_pap", var_player.var_pers["use_pap"], 0);
						var_player namespace_zm_score::function_minus_to_player_score(var_current_cost);
						var_sound = "evt_bottle_dispense";
						function_playsoundatposition(var_sound, self.var_origin);
						self.var_pack_player = var_player;
						self.var_53c64808 = 1;
						level namespace_flag::function_set("pack_machine_in_use");
						self thread function_destroy_weapon_in_blackout(var_player);
						self thread namespace_zm_audio::function_sndPerksJingles_Player(1);
						var_player namespace_zm_audio::function_create_and_play_dialog("general", "pap_wait");
						self function_TriggerEnable(0);
						var_player thread function_do_knuckle_crack();
						self.var_current_weapon = var_current_weapon;
						var_upgrade_weapon = namespace_zm_weapons::function_get_upgrade_weapon(var_current_weapon);
						var_player function_third_person_weapon_upgrade(var_current_weapon, var_upgrade_weapon, var_packa_rollers, var_pap_machine, self);
						self function_TriggerEnable(1);
						self namespace_flag::function_set("pap_offering_gun");
						if(isdefined(var_player))
						{
							self.var_wait_for_player_to_take = 1;
							self thread function_wait_for_player_to_take(var_player, var_current_weapon, var_packa_timer);
							self thread function_wait_for_timeout(var_current_weapon, var_packa_timer, var_player);
							self namespace_util::function_waittill_any("pap_timeout", "pap_taken", "pap_player_disconnected");
						}
						else
						{
							self function_wait_for_timeout(var_current_weapon, var_packa_timer, var_player);
						}
						self.var_zbarrier function_set_pap_zbarrier_state("powered");
						self namespace_flag::function_clear("pap_offering_gun");
						wait(0.5);
						self.var_pack_player = undefined;
						self.var_53c64808 = 0;
						self.var_wait_for_player_to_take = 0;
						level namespace_flag::function_clear("pack_machine_in_use");
					}
				}
				else if(!var_player namespace_zm_score::function_can_player_purchase(var_current_cost))
				{
				}
			}
		}
	}
}

/*
	Name: function_29b95c3e
	Namespace: namespace_5e1f56dc
	Checksum: 0x424F4353
	Offset: 0x58A0
	Size: 0x1A0
	Parameters: 0
	Flags: None
	Line Number: 1031
*/
function function_29b95c3e()
{
	self.var_trigger = function_spawn("trigger_damage", self.var_origin, 0, 30, 30);
	self.var_trigger function_EnableLinkTo();
	self.var_trigger function_LinkTo(self);
	while(isdefined(self.var_trigger))
	{
		self.var_trigger waittill("hash_damage", var_n_damage, var_e_attacker, var_v_dir, var_v_loc, var_str_type, var_STR_MODEL, var_str_tag, var_str_part, var_w_weapon);
		if(function_IsInArray(level.var_zombie_melee_weapon_list, var_w_weapon) || var_str_type == "MOD_MELEE_WEAPON_BUTT" || var_str_type == "MOD_MELEE" || var_str_type == "MOD_MELEE_ASSASSINATE")
		{
			if(var_e_attacker.var_5511c660 == 0)
			{
				var_e_attacker.var_5511c660 = 1;
				var_e_attacker thread function_351b996a();
			}
			else
			{
				var_e_attacker.var_5511c660 = 0;
			}
		}
		wait(1);
	}
}

/*
	Name: function_351b996a
	Namespace: namespace_5e1f56dc
	Checksum: 0x424F4353
	Offset: 0x5A48
	Size: 0x70
	Parameters: 0
	Flags: None
	Line Number: 1065
*/
function function_351b996a()
{
	self notify("hash_fe4d6597");
	self endon("hash_fe4d6597");
	self endon("hash_c3d5e0ab");
	var_count = 0;
	while(var_count < 15)
	{
		var_count = var_count + 1;
		wait(1);
	}
	self.var_5511c660 = 0;
}

/*
	Name: function_ed17d6c
	Namespace: namespace_5e1f56dc
	Checksum: 0x424F4353
	Offset: 0x5AC0
	Size: 0x668
	Parameters: 1
	Flags: Private
	Line Number: 1089
*/
function private function_ed17d6c(var_type)
{
	if(isdefined(var_type))
	{
		var_be737923 = var_type;
	}
	self thread function_29b95c3e();
	while(isdefined(self))
	{
		wait(0.1);
		self waittill("hash_trigger_activated", var_player);
		var_7750a3aa = var_player function_1239e0ad(var_player function_GetCurrentWeapon());
		if(isdefined(var_player.var_5511c660) && var_player.var_5511c660 == 1)
		{
			if(!var_player namespace_zm_score::function_can_player_purchase(5000))
			{
				namespace_zm_utility::function_play_sound_at_pos("no_purchase", var_player.var_origin);
				var_player namespace_zm_audio::function_create_and_play_dialog("general", "outofmoney");
				self function_playsound("zmb_perks_packa_deny");
				continue;
			}
			if(namespace_zm_weapons::function_is_weapon_upgraded(var_player function_GetCurrentWeapon()) && isdefined(var_7750a3aa) && var_7750a3aa.var_a39a2843 < 3)
			{
				namespace_zm_utility::function_play_sound_at_pos("no_purchase", var_player.var_origin);
				self function_playsound("zmb_perks_packa_deny");
				continue;
			}
			if(namespace_zm_weapons::function_is_weapon_upgraded(var_player function_GetCurrentWeapon()) && isdefined(var_7750a3aa) && namespace_zm_weapons::function_weapon_supports_aat(var_player function_GetCurrentWeapon()))
			{
				var_isRepack = 0;
				var_currentAATHashID = -1;
				if(isdefined(namespace_zm_weapons::function_weapon_supports_aat(var_player function_GetCurrentWeapon())) && namespace_zm_weapons::function_weapon_supports_aat(var_player function_GetCurrentWeapon()))
				{
					var_player namespace_zm_score::function_minus_to_player_score(5000);
					namespace_zm_utility::function_play_sound_at_pos("purchase", var_player.var_origin);
					var_player namespace_zm_audio::function_create_and_play_dialog("general", "generic_wall_buy");
					var_player thread namespace_AAT::function_acquire(var_player function_GetCurrentWeapon());
					var_aatObj = var_player namespace_AAT::function_getAATOnWeapon(var_player function_GetCurrentWeapon());
					if(isdefined(var_aatObj))
					{
						var_aatID = var_aatObj.var_hash_id;
					}
					var_isRepack = 1;
				}
				else
				{
					var_player thread namespace_AAT::function_remove(var_player function_GetCurrentWeapon());
					continue;
				}
			}
		}
		if(!var_player namespace_zm_score::function_can_player_purchase(var_player.var_439d3100))
		{
			namespace_zm_utility::function_play_sound_at_pos("no_purchase", var_player.var_origin);
			var_player namespace_zm_audio::function_create_and_play_dialog("general", "outofmoney");
			self function_playsound("zmb_perks_packa_deny");
			continue;
		}
		if(isdefined(var_7750a3aa) && var_7750a3aa.var_a39a2843 >= level.var_7ceb1b41)
		{
			continue;
		}
		if(isdefined(var_be737923) && var_be737923 == "original")
		{
			var_sound = "evt_bottle_dispense";
			function_playsoundatposition(var_sound, self.var_origin);
			self thread namespace_zm_audio::function_sndPerksJingles_Player(1);
			var_player namespace_zm_audio::function_create_and_play_dialog("general", "pap_wait");
		}
		var_player namespace_zm_score::function_minus_to_player_score(var_player.var_439d3100);
		namespace_zm_utility::function_play_sound_at_pos("purchase", var_player.var_origin);
		var_player namespace_zm_audio::function_create_and_play_dialog("general", "generic_wall_buy");
		var_player namespace_zm_stats::function_increment_client_stat("use_pap");
		var_player namespace_zm_stats::function_increment_player_stat("use_pap");
		var_player thread namespace_97ac1184::function_1d39abf6("end_game_use_pap", 1, 0);
		var_player thread namespace_97ac1184::function_7e18304e("spx_save_data", "use_pap", var_player.var_pers["use_pap"], 0);
		var_player thread function_9c955ddd();
	}
}

/*
	Name: function_9c955ddd
	Namespace: namespace_5e1f56dc
	Checksum: 0x424F4353
	Offset: 0x6130
	Size: 0xAF0
	Parameters: 2
	Flags: None
	Line Number: 1179
*/
function function_9c955ddd(var_a76169e6, var_w_weapon)
{
	if(isdefined(var_w_weapon))
	{
		var_current_weapon = var_w_weapon;
	}
	else
	{
		var_current_weapon = self function_GetCurrentWeapon();
		var_current_weapon = self namespace_zm_weapons::function_switch_from_alt_weapon(var_current_weapon);
	}
	var_7750a3aa = self function_1239e0ad(var_current_weapon);
	if(var_current_weapon.var_name == "idgun_0" || var_current_weapon.var_name == "idgun_1" || var_current_weapon.var_name == "idgun_2" || var_current_weapon.var_name == "idgun_3")
	{
		switch(var_current_weapon.var_name)
		{
			case "idgun_0":
			{
				var_12030910 = function_GetWeapon("idgun_upgraded_0");
				break;
			}
			case "idgun_1":
			{
				var_12030910 = function_GetWeapon("idgun_upgraded_1");
				break;
			}
			case "idgun_2":
			{
				var_12030910 = function_GetWeapon("idgun_upgraded_2");
				break;
			}
			case "idgun_3":
			{
				var_12030910 = function_GetWeapon("idgun_upgraded_3");
				break;
			}
		}
	}
	else
	{
		var_12030910 = namespace_zm_weapons::function_get_upgrade_weapon(var_current_weapon, 0);
	}
	var_current_weapon = self function_GetBuildKitWeapon(var_current_weapon, 0);
	var_12030910 = self function_GetBuildKitWeapon(var_12030910, 1);
	if(!(isdefined(self function_92bf1671(var_current_weapon)) && self function_92bf1671(var_current_weapon)))
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
						namespace_zm_utility::function_play_sound_at_pos("no_purchase", self.var_origin);
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
				if(var_7750a3aa.var_a39a2843 > self.var_pers["highest_enchantment"])
				{
					self.var_pers["highest_enchantment"] = var_7750a3aa.var_a39a2843;
					self thread namespace_97ac1184::function_7e18304e("spx_save_data", "highest_enchantment", self.var_pers["highest_enchantment"], 0);
				}
				if(var_7750a3aa.var_a39a2843 > self.var_pers["end_game_highest_enchantment"])
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
				self thread namespace_97ac1184::function_b3489bf5("^3" + self.var_playerName + "^7 Pack-a-Punched to ^9" + var_7750a3aa function_3ce97289() + " ^7on " + function_MakeLocalizedString(var_7750a3aa.var_stored_weapon.var_displayName));
				wait(0.05);
				if(level.var_fcee636 == "motd")
				{
					self notify("hash_63cf7d21", "map0_motd_pack_a_punched", 1, 1, 75000, 10);
					wait(0.05);
					if(self.var_pers["map0_motd_pack_a_punched"] >= 1)
					{
						self notify("hash_63cf7d21", "map0_motd_pack_a_punched_multiple", 1, 25, 135000, 250, "motd_camo_0");
						wait(0.05);
						if(self.var_pers["map0_motd_pack_a_punched_multiple"] >= 25)
						{
							self notify("hash_63cf7d21", "map0_motd_pack_a_punched_multiple_2", 1, 125, 235000, 1000, "motd_camo_1");
							wait(0.05);
						}
					}
				}
				self function_febfc6ba(var_current_weapon);
			}
		}
		else if(!(isdefined(var_ed5e1bff) && var_ed5e1bff))
		{
			if(isdefined(self function_c3370d47(var_12030910)) && self function_c3370d47(var_12030910))
			{
				var_de6974d4 = function_spawnstruct();
				var_de6974d4.var_stored_weapon = var_12030910.var_rootweapon;
				var_de6974d4.var_79fe8f18 = 0;
				var_de6974d4.var_4c25c2f2 = 0;
				var_de6974d4.var_pap_camo_to_use = level.var_1e656cc4[var_de6974d4.var_4c25c2f2];
				self.var_3818be12[self.var_3818be12.size] = var_de6974d4;
			}
		}
		if(!(isdefined(var_7750a3aa) && var_7750a3aa))
		{
			var_d2433c1d = function_spawnstruct();
			var_d2433c1d.var_stored_weapon = var_12030910.var_rootweapon;
			if(!isdefined(var_a76169e6))
			{
				var_a76169e6 = self function_49e2047b();
			}
			var_d2433c1d.var_a39a2843 = var_a76169e6;
			self.var_fb56a719[self.var_fb56a719.size] = var_d2433c1d;
		}
		var_acvi = self function_GetBuildKitAttachmentCosmeticVariantIndexes(var_12030910, 1);
		self function_TakeWeapon(var_current_weapon);
		self function_GiveWeapon(var_12030910, self namespace_zm_weapons::function_get_pack_a_punch_weapon_options(var_12030910), var_acvi);
		if(isdefined(var_12030910.var_start_ammo) && var_12030910.var_start_ammo != var_12030910.var_maxAmmo)
		{
			if(self function_hasPerk("specialty_extraammo"))
			{
				self function_SetWeaponAmmoStock(var_12030910, var_12030910.var_maxAmmo);
			}
			else
			{
				self function_SetWeaponAmmoStock(var_12030910, var_12030910.var_startammo);
			}
		}
		else
		{
			self function_SetWeaponAmmoStock(var_12030910, var_12030910.var_startammo);
		}
		if(isdefined(var_12030910.var_clipSize) && var_12030910.var_clipSize > 0)
		{
			self function_SetWeaponAmmoClip(var_12030910, var_12030910.var_clipSize);
		}
		self function_SwitchToWeapon(var_12030910);
		var_7750a3aa = self function_1239e0ad(var_current_weapon);
		if(isdefined(var_7750a3aa))
		{
			self thread namespace_97ac1184::function_b3489bf5("^3" + self.var_playerName + "^7 Pack-a-Punched to ^9" + var_7750a3aa function_3ce97289() + " ^7on " + function_MakeLocalizedString(var_7750a3aa.var_stored_weapon.var_displayName));
		}
		namespace_zm_utility::function_play_sound_at_pos("zmb_perks_packa_ready", self);
		wait(0.05);
		if(level.var_fcee636 == "motd")
		{
			self notify("hash_63cf7d21", "map0_motd_pack_a_punched", 1, 1, 75000, 10);
			wait(0.05);
			if(self.var_pers["map0_motd_pack_a_punched"] >= 1)
			{
				self notify("hash_63cf7d21", "map0_motd_pack_a_punched_multiple", 1, 25, 135000, 250, "motd_camo_0");
				wait(0.05);
				if(self.var_pers["map0_motd_pack_a_punched_multiple"] >= 25)
				{
					self notify("hash_63cf7d21", "map0_motd_pack_a_punched_multiple_2", 1, 125, 235000, 1000, "motd_camo_1");
					wait(0.05);
				}
			}
		}
		level notify("hash_2210fa9c", "upgraded_current_weapon", self, var_current_weapon, var_12030910);
	}
}

/*
	Name: function_3ce97289
	Namespace: namespace_5e1f56dc
	Checksum: 0x424F4353
	Offset: 0x6C28
	Size: 0xD8
	Parameters: 0
	Flags: None
	Line Number: 1366
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
}

/*
	Name: function_92bf1671
	Namespace: namespace_5e1f56dc
	Checksum: 0x424F4353
	Offset: 0x6D08
	Size: 0xB8
	Parameters: 1
	Flags: None
	Line Number: 1428
*/
function function_92bf1671(var_weapon)
{
	var_w_weapon = namespace_zm_weapons::function_get_nonalternate_weapon(var_weapon);
	if(isdefined(var_w_weapon.var_rootweapon))
	{
		var_w_weapon = var_w_weapon.var_rootweapon;
	}
	if(var_w_weapon.var_8c86d7b3 || var_w_weapon.var_7e163cf8 || namespace_zm_equipment::function_is_equipment(var_w_weapon) || namespace_zm_utility::function_is_placeable_mine(var_w_weapon))
	{
		return 0;
	}
	return 1;
}

/*
	Name: function_49e2047b
	Namespace: namespace_5e1f56dc
	Checksum: 0x424F4353
	Offset: 0x6DC8
	Size: 0x540
	Parameters: 0
	Flags: None
	Line Number: 1452
*/
function function_49e2047b()
{
	if(!(isdefined(level.var_2198e3c0) && level.var_2198e3c0))
	{
		return 1;
	}
	if(level.var_round_number >= 25 && level.var_round_number <= 32)
	{
		if(level.var_c181264f)
		{
		}
		else if(function_randomIntRange(0, 100) < 35)
		{
			return 2;
		}
		else
		{
			return 1;
		}
	}
	else if(level.var_round_number >= 33 && level.var_round_number <= 40)
	{
		if(level.var_c181264f)
		{
		}
		else if(function_randomIntRange(0, 100) < 35)
		{
			return 3;
		}
		else
		{
			return 2;
		}
	}
	else if(level.var_round_number >= 41 && level.var_round_number <= 48)
	{
		if(level.var_c181264f)
		{
		}
		else if(function_randomIntRange(0, 100) < 35)
		{
			return 4;
		}
		else
		{
			return 3;
		}
	}
	else if(level.var_round_number >= 49 && level.var_round_number <= 56)
	{
		if(level.var_c181264f)
		{
		}
		else if(function_randomIntRange(0, 100) < 35)
		{
			return 5;
		}
		else
		{
			return 4;
		}
	}
	else if(level.var_round_number >= 57 && level.var_round_number <= 64)
	{
		if(level.var_c181264f)
		{
		}
		else if(function_randomIntRange(0, 100) < 35)
		{
			return 6;
		}
		else
		{
			return 5;
		}
	}
	else if(level.var_round_number >= 65 && level.var_round_number <= 72)
	{
		if(level.var_c181264f)
		{
		}
		else if(function_randomIntRange(0, 100) < 35)
		{
			return 7;
		}
		else
		{
			return 6;
		}
	}
	else if(level.var_round_number >= 73 && level.var_round_number <= 80)
	{
		if(level.var_c181264f)
		{
		}
		else if(function_randomIntRange(0, 100) < 35)
		{
			return 8;
		}
		else
		{
			return 7;
		}
	}
	else if(level.var_round_number >= 81 && level.var_round_number <= 88)
	{
		if(level.var_c181264f)
		{
		}
		else if(function_randomIntRange(0, 100) < 35)
		{
			return 9;
		}
		else
		{
			return 8;
		}
	}
	else if(level.var_round_number >= 89 && level.var_round_number <= 96)
	{
		if(level.var_c181264f)
		{
		}
		else if(function_randomIntRange(0, 100) < 35)
		{
			return 10;
		}
		else
		{
			return 9;
		}
	}
	else if(level.var_round_number >= 97 && level.var_round_number <= 105)
	{
		if(level.var_c181264f)
		{
		}
		else if(function_randomIntRange(0, 100) < 35)
		{
			return 11;
		}
		else
		{
			return 10;
		}
	}
	else if(level.var_round_number >= 106)
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
	Offset: 0x7310
	Size: 0x128
	Parameters: 1
	Flags: None
	Line Number: 1618
*/
function function_febfc6ba(var_current_weapon)
{
	if(isdefined(var_current_weapon.var_start_ammo) && var_current_weapon.var_start_ammo != var_current_weapon.var_maxAmmo)
	{
		if(self function_hasPerk("specialty_extraammo"))
		{
			self function_SetWeaponAmmoStock(var_current_weapon, var_current_weapon.var_maxAmmo);
		}
		else
		{
			self function_SetWeaponAmmoStock(var_current_weapon, var_current_weapon.var_startammo);
		}
	}
	else
	{
		self function_SetWeaponAmmoStock(var_current_weapon, var_current_weapon.var_startammo);
	}
	if(isdefined(var_current_weapon.var_clipSize) && var_current_weapon.var_clipSize > 0)
	{
		self function_SetWeaponAmmoClip(var_current_weapon, var_current_weapon.var_clipSize);
	}
}

/*
	Name: function_e942fd68
	Namespace: namespace_5e1f56dc
	Checksum: 0x424F4353
	Offset: 0x7440
	Size: 0xF0
	Parameters: 1
	Flags: None
	Line Number: 1651
*/
function function_e942fd68(var_weapon)
{
	if(isdefined(self.var_3818be12) && self.var_3818be12.size > 0)
	{
		foreach(var_52bd8d74 in self.var_3818be12)
		{
			if(var_52bd8d74.var_stored_weapon == var_weapon.var_rootweapon || var_52bd8d74.var_stored_weapon.var_name == var_weapon.var_rootweapon.var_name)
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
	Offset: 0x7538
	Size: 0x730
	Parameters: 1
	Flags: None
	Line Number: 1676
*/
function function_7e6983a0(var_player)
{
	var_7750a3aa = var_player function_1239e0ad(var_player function_GetCurrentWeapon());
	if(isdefined(var_7750a3aa))
	{
		if(var_7750a3aa.var_a39a2843 == 1)
		{
			var_player.var_439d3100 = 10000;
		}
		if(var_7750a3aa.var_a39a2843 == 2)
		{
			var_player.var_439d3100 = 15000;
		}
		if(var_7750a3aa.var_a39a2843 == 3)
		{
			var_player.var_439d3100 = 30000;
		}
		if(var_7750a3aa.var_a39a2843 == 4)
		{
			var_player.var_439d3100 = 50000;
		}
		if(var_7750a3aa.var_a39a2843 == 5)
		{
			var_player.var_439d3100 = 75000;
		}
		if(var_7750a3aa.var_a39a2843 == 6)
		{
			var_player.var_439d3100 = 100000;
		}
		if(var_7750a3aa.var_a39a2843 == 7)
		{
			var_player.var_439d3100 = 125000;
		}
		if(var_7750a3aa.var_a39a2843 == 8)
		{
			var_player.var_439d3100 = 150000;
		}
		if(var_7750a3aa.var_a39a2843 == 9)
		{
			var_player.var_439d3100 = 175000;
		}
		if(var_7750a3aa.var_a39a2843 == 10)
		{
			var_player.var_439d3100 = 200000;
		}
	}
	else
	{
		var_player.var_439d3100 = 5000;
	}
	if(!(isdefined(self.var_stub.var_related_parent.var_977bc4ba) && self.var_stub.var_related_parent.var_977bc4ba))
	{
		self function_setHintString(&"ZOMBIE_NEED_POWER");
		return 0;
	}
	if(isdefined(level.var_919b0320) && level.var_919b0320)
	{
		self function_setHintString(&"ZM_MINECRAFT_HINTSTRING_PAP_DISABLED");
		return 0;
	}
	if(isdefined(var_player.var_5511c660) && var_player.var_5511c660 == 1)
	{
		if(var_player function_istouching(self))
		{
			var_player thread function_351b996a();
		}
		if(!(isdefined(level.var_7f38ec2c) && level.var_7f38ec2c))
		{
			self function_setHintString(&"ZM_MINECRAFT_HINTSTRING_PAP_AAT_DISABLED");
			return 0;
		}
		else if(!namespace_zm_weapons::function_weapon_supports_aat(var_player function_GetCurrentWeapon()))
		{
			self function_setHintString(&"ZM_MINECRAFT_HINTSTRING_CANNOT_USE_PAP_AAT");
			return 0;
		}
		else if(namespace_zm_weapons::function_is_weapon_upgraded(var_player function_GetCurrentWeapon()) && isdefined(var_7750a3aa) && var_7750a3aa.var_a39a2843 < 3)
		{
			self function_setHintString(&"ZM_MINECRAFT_HINTSTRING_CANNOT_USE_PAP_AAT_REQUIREMENT");
			return 0;
		}
		else if(!(isdefined(var_player function_player_use_can_pack_now()) && var_player function_player_use_can_pack_now()))
		{
			self function_setHintString(&"ZM_MINECRAFT_HINTSTRING_CANNOT_USE_PAP_AAT");
			return 0;
		}
		else if(!var_player namespace_zm_score::function_can_player_purchase(5000))
		{
			self function_setHintString(&"ZM_MINECRAFT_HINTSTRING_PAP_AAT_NO_MONEY", 5000);
			return 0;
		}
		else if(namespace_zm_weapons::function_is_weapon_upgraded(var_player function_GetCurrentWeapon()) && isdefined(var_7750a3aa) && namespace_zm_weapons::function_weapon_supports_aat(var_player function_GetCurrentWeapon()))
		{
			self function_setHintString(&"ZM_MINECRAFT_HINTSTRING_CAN_PACK_AAT", 5000);
			return 1;
		}
		else
		{
			self function_setHintString(&"ZM_MINECRAFT_HINTSTRING_CANNOT_USE_PAP_AAT");
			return 0;
		}
	}
	else if(var_player function_istouching(self))
	{
		var_player notify("hash_c3d5e0ab");
	}
	if(namespace_zm_weapons::function_is_weapon_upgraded(var_player function_GetCurrentWeapon()) && isdefined(var_7750a3aa) && var_7750a3aa.var_a39a2843 >= level.var_7ceb1b41)
	{
		self function_setHintString(&"ZM_MINECRAFT_HINTSTRING_CANNOT_USE_PAP_WEAPON_MAX");
		return 0;
	}
	else if(!(isdefined(var_player function_player_use_can_pack_now()) && var_player function_player_use_can_pack_now()))
	{
		self function_setHintString(&"ZM_MINECRAFT_HINTSTRING_CANNOT_USE_PAP_WEAPON");
		return 0;
	}
	else if(!var_player namespace_zm_score::function_can_player_purchase(var_player.var_439d3100))
	{
		self function_setHintString(&"ZM_MINECRAFT_HINTSTRING_PAP_NO_MONEY", var_player.var_439d3100);
		return 0;
	}
	else if(!isdefined(var_7750a3aa))
	{
		self function_setHintString(&"ZM_MINECRAFT_HINTSTRING_CAN_PACK_A_PUNCH", var_player.var_439d3100, "Uncommon Enchantment");
	}
	else
	{
		self function_setHintString(&"ZM_MINECRAFT_HINTSTRING_CAN_PACK_A_PUNCH", var_player.var_439d3100, var_player function_5a6a55da(var_7750a3aa.var_a39a2843 + 1));
	}
	return 1;
	return;
	ERROR: Bad function call
}

/*
	Name: function_5a6a55da
	Namespace: namespace_5e1f56dc
	Checksum: 0x424F4353
	Offset: 0x7C70
	Size: 0xF0
	Parameters: 1
	Flags: None
	Line Number: 1820
*/
function function_5a6a55da(var_a39a2843)
{
	switch(var_a39a2843)
	{
		case 0:
		{
			return "No Enchantment";
		}
		case 1:
		{
			return "Uncommon Enchantment | I";
		}
		case 2:
		{
			return "Rare Enchantment | II";
		}
		case 3:
		{
			return "Epic Enchantment | III";
		}
		case 4:
		{
			return "Legendary Enchantment | IV";
		}
		case 5:
		{
			return "Mythic Enchantment | V";
		}
		case 6:
		{
			return "Exotic Enchantment | VI";
		}
		case 7:
		{
			return "Divine Enchantment | VII";
		}
		case 8:
		{
			return "Eternal Enchantment | VIII";
		}
		case 9:
		{
			return "Cosmic Enchantment | IX";
		}
		case 10:
		{
			return "Celestial Enchantment | X";
		}
		case 11:
		{
			return "Ultimate Enchantment | XI";
		}
		default
		{
			return "Cheater Enchantment | XII";
		}
	}
}

/*
	Name: function_player_use_can_pack_now
	Namespace: namespace_5e1f56dc
	Checksum: 0x424F4353
	Offset: 0x7D68
	Size: 0x2F0
	Parameters: 0
	Flags: None
	Line Number: 1889
*/
function function_player_use_can_pack_now()
{
	if(self namespace_laststand::function_player_is_in_laststand() || (isdefined(self.var_intermission) && self.var_intermission) || self function_IsThrowingGrenade())
	{
		return 0;
	}
	if(!self namespace_zm_magicbox::function_can_buy_weapon() || self namespace_bgb::function_is_enabled("zm_bgb_disorderly_combat") || namespace_zm_utility::function_is_hero_weapon(self function_GetCurrentWeapon()))
	{
		return 0;
	}
	if(!namespace_zm_utility::function_is_player_valid(self) || self.var_IS_DRINKING > 0 || namespace_zm_utility::function_is_placeable_mine(self function_GetCurrentWeapon()) || namespace_zm_equipment::function_is_equipment(self function_GetCurrentWeapon()) || self namespace_zm_utility::function_is_player_revive_tool(self function_GetCurrentWeapon()) || level.var_weaponNone == self function_GetCurrentWeapon() || self namespace_zm_equipment::function_hacker_active())
	{
		return 0;
	}
	if(self function_GetCurrentWeapon().var_isRiotShield)
	{
		return 0;
	}
	var_weapon = self namespace_zm_weapons::function_get_nonalternate_weapon(self function_GetCurrentWeapon());
	if(!namespace_zm_weapons::function_is_weapon_or_base_included(self function_GetCurrentWeapon()))
	{
		return 0;
	}
	if(function_ToLower(function_GetDvarString("mapname")) != "zm_zod")
	{
		if(!namespace_zm_weapons::function_is_weapon_upgraded(self function_GetCurrentWeapon()) && !self namespace_zm_weapons::function_can_upgrade_weapon(self function_GetCurrentWeapon()))
		{
			return 0;
		}
	}
	if(isdefined(self function_GetCurrentWeapon() function_25b21deb()) && self function_GetCurrentWeapon() function_25b21deb())
	{
		return 0;
	}
	return 1;
}

/*
	Name: function_db2e4f3f
	Namespace: namespace_5e1f56dc
	Checksum: 0x424F4353
	Offset: 0x8060
	Size: 0x180
	Parameters: 0
	Flags: None
	Line Number: 1936
*/
function function_db2e4f3f()
{
	var_link_ent = namespace_util::function_spawn_model("tag_origin", self.var_origin, self.var_angles);
	wait(0.05);
	self function_LinkTo(var_link_ent);
	while(isdefined(self))
	{
		var_dc518be1 = function_ArrayGetClosest(self.var_origin, function_GetPlayers());
		if(isdefined(var_dc518be1))
		{
			var_dist = function_Distance(self.var_origin, var_dc518be1.var_origin);
			if(var_dist < 150)
			{
				self notify("hash_27d369a0");
				var_angles = var_link_ent function_ab9afa24(var_dc518be1.var_origin);
				var_link_ent function_RotateTo(var_angles - VectorScale((0, 1, 0), 90), 0.3);
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
	Offset: 0x81E8
	Size: 0x88
	Parameters: 1
	Flags: None
	Line Number: 1972
*/
function function_ab9afa24(var_position)
{
	var_v_to_enemy = (var_position - self.var_origin[0], var_position - self.var_origin[1], 0);
	var_v_to_enemy = function_VectorNormalize(var_v_to_enemy);
	var_goalAngles = function_VectorToAngles(var_v_to_enemy);
	return var_goalAngles;
}

/*
	Name: function_642d1d4d
	Namespace: namespace_5e1f56dc
	Checksum: 0x424F4353
	Offset: 0x8278
	Size: 0x10
	Parameters: 1
	Flags: None
	Line Number: 1990
*/
function function_642d1d4d(var_e_player)
{
	return 0;
}

/*
	Name: function_73f71a35
	Namespace: namespace_5e1f56dc
	Checksum: 0x424F4353
	Offset: 0x8290
	Size: 0x18
	Parameters: 0
	Flags: None
	Line Number: 2005
*/
function function_73f71a35()
{
	return self.var_b74a3cd1["brutal_xp"];
}

/*
	Name: function_51093d89
	Namespace: namespace_5e1f56dc
	Checksum: 0x424F4353
	Offset: 0x82B0
	Size: 0xC38
	Parameters: 1
	Flags: Private
	Line Number: 2020
*/
function private function_51093d89(var_e_attacker)
{
	if(!isdefined(var_e_attacker) || !function_isPlayer(var_e_attacker) || !isdefined(self.var_damageWeapon) || (!(isdefined(var_e_attacker namespace_97ac1184::function_ae5b65af()) && var_e_attacker namespace_97ac1184::function_ae5b65af())))
	{
		return;
	}
	if(isdefined(self.var_damageWeapon.var_dualWieldWeapon) && self.var_damageWeapon.var_dualWieldWeapon != level.var_weaponNone)
	{
		if(function_IsSubStr(self.var_damageWeapon.var_name, "lh") || function_IsSubStr(self.var_damageWeapon.var_name, "ldw"))
		{
			if(self.var_damageWeapon != var_e_attacker function_GetCurrentWeapon().var_dualWieldWeapon)
			{
				return;
			}
		}
		else if(self.var_damageWeapon != var_e_attacker function_GetCurrentWeapon())
		{
			return;
		}
	}
	else if(self.var_damageWeapon != var_e_attacker function_GetCurrentWeapon())
	{
		return;
	}
	if(isdefined(var_e_attacker function_c3370d47(self.var_damageWeapon)) && var_e_attacker function_c3370d47(self.var_damageWeapon))
	{
		if(isdefined(self.var_damageWeapon.var_dualWieldWeapon) && self.var_damageWeapon.var_dualWieldWeapon != level.var_weaponNone)
		{
			if(function_IsSubStr(self.var_damageWeapon.var_name, "lh") || function_IsSubStr(self.var_damageWeapon.var_name, "ldw"))
			{
				var_w_weapon = namespace_zm_weapons::function_get_nonalternate_weapon(self.var_damageWeapon.var_dualWieldWeapon);
			}
			else
			{
				var_w_weapon = namespace_zm_weapons::function_get_nonalternate_weapon(self.var_damageWeapon);
			}
		}
		else
		{
			var_w_weapon = namespace_zm_weapons::function_get_nonalternate_weapon(self.var_damageWeapon);
		}
		if(isdefined(var_w_weapon.var_rootweapon))
		{
			var_w_weapon = var_w_weapon.var_rootweapon;
		}
		var_8b98cf00 = [];
		var_8b98cf00["idgun_upgraded"] = function_Array("idgun_upgraded_0", "idgun_upgraded_1", "idgun_upgraded_2", "idgun_upgraded_3", "idgun_upgraded_4");
		var_weapon_list = [];
		var_current_weapon = var_e_attacker function_GetCurrentWeapon();
		var_30bfe5b0 = self function_ba339dcd(var_e_attacker);
		foreach(var_weapon_array in var_8b98cf00)
		{
			if(function_IsSubStr(var_w_weapon.var_name, var_group_name))
			{
				foreach(var_gun in var_weapon_array)
				{
					var_26bb88c4 = var_e_attacker function_1c1990e8(function_GetWeapon(var_gun));
					if(isdefined(var_26bb88c4))
					{
						var_weapon_list[var_weapon_list.size] = var_26bb88c4;
					}
				}
			}
		}
		if(var_weapon_list.size == 0)
		{
			var_480fed80 = var_e_attacker function_1c1990e8(var_w_weapon);
			if(isdefined(var_480fed80))
			{
				var_weapon_list[var_weapon_list.size] = var_480fed80;
			}
		}
		foreach(var_weapon in var_weapon_list)
		{
			if(var_30bfe5b0 == 0)
			{
				var_weapon.var_79fe8f18 = var_weapon.var_79fe8f18 + 3;
			}
			else if(function_IsSubStr(var_weapon.var_stored_weapon.var_name, "season_") || function_IsSubStr(var_weapon.var_stored_weapon.var_name, "blaster") || function_IsSubStr(var_weapon.var_stored_weapon.var_name, "darth_vader"))
			{
				var_weapon.var_79fe8f18 = var_weapon.var_79fe8f18 + var_30bfe5b0 * 3;
			}
			else
			{
				var_weapon.var_79fe8f18 = var_weapon.var_79fe8f18 + var_30bfe5b0;
			}
			var_e_attacker function_LUINotifyEvent(&"spx_gun_level", 2, function_Int(var_weapon.var_79fe8f18), function_Int(level.var_ce9bfb71[var_weapon.var_4c25c2f2]));
			if(var_weapon.var_79fe8f18 >= level.var_ce9bfb71[var_weapon.var_4c25c2f2])
			{
				var_weapon.var_4c25c2f2 = var_weapon.var_4c25c2f2 + 1;
				var_weapon.var_79fe8f18 = 0;
				var_weapon.var_pap_camo_to_use = level.var_1e656cc4[var_weapon.var_4c25c2f2];
				if(isdefined(var_e_attacker.var_fa202141["player_specifiedcamo"]) && var_e_attacker.var_fa202141["player_specifiedcamo"] == 0)
				{
					if(isdefined(var_e_attacker.var_fa202141["player_favouritecamo"]) && (var_e_attacker.var_fa202141["player_favouritecamo"] == 0 || var_e_attacker.var_fa202141["player_favouritecamo"] > var_weapon.var_4c25c2f2))
					{
						var_e_attacker function_c8540b60(var_w_weapon, var_e_attacker function_CalcWeaponOptions(level.var_1e656cc4[var_weapon.var_4c25c2f2], 0, 0));
					}
				}
				var_e_attacker thread namespace_97ac1184::function_b3489bf5("^3" + var_e_attacker.var_playerName + "^7 achieved ^9" + function_b51ad244(function_Int(var_weapon.var_4c25c2f2)) + " ^7on " + function_MakeLocalizedString(var_weapon.var_stored_weapon.var_displayName));
				var_e_attacker function_LUINotifyEvent(&"spx_camo_notification", 1, function_Int(var_weapon.var_4c25c2f2));
				if(var_weapon.var_stored_weapon == var_current_weapon)
				{
					var_e_attacker thread function_e5bef058(var_weapon.var_4c25c2f2);
				}
			}
			var_e_attacker thread function_7e18304e(var_weapon.var_stored_weapon.var_rootweapon.var_name, var_weapon.var_4c25c2f2, var_weapon.var_79fe8f18);
		}
	}
	else if(function_randomIntRange(0, 100) <= function_5cbadafe(self.var_damageWeapon) && var_e_attacker.var_41ff59ae == 0 && (isdefined(level.var_fd6c66c2) && level.var_fd6c66c2))
	{
		var_bcce182e = namespace_util::function_spawn_model("tag_origin", self.var_origin + VectorScale((0, 0, 1), 30), self.var_angles);
		var_playable_area = function_GetEntArray("player_volume", "script_noteworthy");
		var_valid_drop = 0;
		for(var_i = 0; var_i < var_playable_area.size; var_i++)
		{
			if(var_bcce182e function_istouching(var_playable_area[var_i]))
			{
				var_valid_drop = 1;
				break;
			}
		}
		if(isdefined(var_valid_drop) && var_valid_drop)
		{
			var_e_attacker.var_41ff59ae = function_32d4b0df(self.var_damageWeapon);
			var_e_attacker thread function_669b1c40();
			var_bcce182e function_SetModel("zmu_ammo_pack");
			var_spawn_position = self function_675d72a5();
			var_final_pos = self namespace_ecdf5e21::function_a2b97522(var_spawn_position, 35, var_bcce182e, 1);
			var_bcce182e namespace_ecdf5e21::function_a170d6f0(var_final_pos, 15);
			var_bcce182e thread function_ff00213(20);
		}
		else
		{
			var_bcce182e function_delete();
		}
	}
	return -1;
}

/*
	Name: function_675d72a5
	Namespace: namespace_5e1f56dc
	Checksum: 0x424F4353
	Offset: 0x8EF0
	Size: 0xB8
	Parameters: 0
	Flags: None
	Line Number: 2170
*/
function function_675d72a5()
{
	var_spawn_origin = self.var_origin;
	var_spawn_angles = self.var_angles;
	var_forward_direction = function_AnglesToForward(var_spawn_angles);
	var_right_direction = function_AnglesToRight(var_spawn_angles);
	return var_spawn_origin + var_forward_direction * function_randomIntRange(30, 45) + var_right_direction * function_randomIntRange(-45, 45);
}

/*
	Name: function_24464e9d
	Namespace: namespace_5e1f56dc
	Checksum: 0x424F4353
	Offset: 0x8FB0
	Size: 0x38
	Parameters: 1
	Flags: Private
	Line Number: 2189
*/
function private function_24464e9d(var_type)
{
	if(!isdefined(self.var_2d58b7d3[var_type]))
	{
		self.var_2d58b7d3[var_type] = var_type;
	}
}

/*
	Name: function_ba339dcd
	Namespace: namespace_5e1f56dc
	Checksum: 0x424F4353
	Offset: 0x8FF0
	Size: 0x3F0
	Parameters: 1
	Flags: None
	Line Number: 2207
*/
function function_ba339dcd(var_e_attacker)
{
	var_e_attacker.var_2d58b7d3 = [];
	var_8b004135 = 6;
	var_65c1b965 = 0;
	var_7d80bdc7 = 0;
	var_is_headshot = 0;
	var_is_sliding = 0;
	var_35846e = 0;
	var_8fffad25 = 0;
	var_6aca54a5 = 0;
	if(self.var_damagelocation === "head" && (!(isdefined(self.var_isdog) && self.var_isdog)) || (self.var_damagelocation === "helmet" && (!(isdefined(self.var_isdog) && self.var_isdog))) || (self.var_damageMod === "MOD_HEAD_SHOT" && (!(isdefined(self.var_isdog) && self.var_isdog))))
	{
		var_is_headshot = 1;
		var_8b004135 = 8;
		var_e_attacker thread function_24464e9d("headshot");
	}
	if(var_e_attacker function_IsSliding())
	{
		var_is_sliding = 1;
		var_8b004135 = 8;
		var_e_attacker thread function_24464e9d("sliding");
	}
	if(function_Distance(self.var_origin, var_e_attacker.var_origin) > 700)
	{
		var_35846e = 1;
		var_8b004135 = 8;
		var_e_attacker thread function_24464e9d("longshot");
	}
	if(var_e_attacker function_GetStance() == "prone")
	{
		var_8fffad25 = 1;
		var_8b004135 = 7;
		var_e_attacker thread function_24464e9d("prone");
	}
	if(self function_2dce8d67())
	{
		var_8b004135 = var_8b004135 + 6;
	}
	if(self.var_fc3ab987)
	{
		var_8b004135 = var_8b004135 + 4;
	}
	if(var_is_headshot && var_35846e && !var_7d80bdc7)
	{
		var_65c1b965 = 5;
		var_7d80bdc7 = 1;
	}
	else if(var_is_sliding && var_is_headshot && !var_7d80bdc7)
	{
		var_65c1b965 = 5;
		var_7d80bdc7 = 1;
	}
	else if(var_8fffad25 && var_35846e && !var_7d80bdc7)
	{
		var_65c1b965 = 5;
		var_7d80bdc7 = 1;
	}
	var_4171bcd0 = var_8b004135 + var_65c1b965;
	if(isdefined(var_e_attacker.var_d31d6052))
	{
		var_957b57a7 = namespace_math::function_clamp(1 + var_e_attacker.var_d31d6052 * 0.005, 1, 1.5);
		var_4171bcd0 = var_4171bcd0 * var_957b57a7;
	}
	if(0)
	{
	}
	else
	{
		return function_Int(var_4171bcd0);
	}
}

/*
	Name: function_32d4b0df
	Namespace: namespace_5e1f56dc
	Checksum: 0x424F4353
	Offset: 0x93E8
	Size: 0x48
	Parameters: 1
	Flags: None
	Line Number: 2290
*/
function function_32d4b0df(var_weapon)
{
	if(isdefined(var_weapon function_e078665a()) && var_weapon function_e078665a())
	{
		return 70;
	}
	return 40;
}

/*
	Name: function_5cbadafe
	Namespace: namespace_5e1f56dc
	Checksum: 0x424F4353
	Offset: 0x9438
	Size: 0x48
	Parameters: 1
	Flags: None
	Line Number: 2309
*/
function function_5cbadafe(var_weapon)
{
	if(isdefined(var_weapon function_e078665a()) && var_weapon function_e078665a())
	{
		return 1;
	}
	return 10;
}

/*
	Name: function_b51ad244
	Namespace: namespace_5e1f56dc
	Checksum: 0x424F4353
	Offset: 0x9488
	Size: 0x178
	Parameters: 1
	Flags: None
	Line Number: 2328
*/
function function_b51ad244(var_index)
{
	switch(var_index)
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
}

/*
	Name: function_e5bef058
	Namespace: namespace_5e1f56dc
	Checksum: 0x424F4353
	Offset: 0x9608
	Size: 0x700
	Parameters: 1
	Flags: None
	Line Number: 2430
*/
function function_e5bef058(var_4c25c2f2)
{
	switch(var_4c25c2f2)
	{
		case 1:
		{
			self.var_pers["player_points"] = self.var_pers["player_points"] + 25;
			self notify("hash_79ef118b", "camo_1_obtained", undefined);
			break;
		}
		case 2:
		{
			self.var_pers["player_points"] = self.var_pers["player_points"] + 50;
			self notify("hash_79ef118b", "camo_2_obtained", undefined);
			break;
		}
		case 3:
		{
			self.var_pers["player_points"] = self.var_pers["player_points"] + 100;
			self notify("hash_79ef118b", "camo_3_obtained", undefined);
			break;
		}
		case 4:
		{
			self.var_pers["player_points"] = self.var_pers["player_points"] + 150;
			self notify("hash_79ef118b", "camo_4_obtained", undefined);
			break;
		}
		case 5:
		{
			self.var_pers["player_points"] = self.var_pers["player_points"] + 200;
			self notify("hash_79ef118b", "camo_5_obtained", undefined);
			break;
		}
		case 6:
		{
			self.var_pers["player_points"] = self.var_pers["player_points"] + 300;
			self notify("hash_79ef118b", "camo_6_obtained", undefined);
			break;
		}
		case 7:
		{
			self.var_pers["player_points"] = self.var_pers["player_points"] + 400;
			self notify("hash_79ef118b", "camo_7_obtained", undefined);
			break;
		}
		case 8:
		{
			self.var_pers["player_points"] = self.var_pers["player_points"] + 600;
			self notify("hash_79ef118b", "camo_8_obtained", undefined);
			break;
		}
		case 9:
		{
			self.var_pers["player_points"] = self.var_pers["player_points"] + 800;
			self notify("hash_79ef118b", "camo_9_obtained", undefined);
			break;
		}
		case 10:
		{
			self.var_pers["player_points"] = self.var_pers["player_points"] + 1000;
			self notify("hash_79ef118b", "camo_10_obtained", undefined);
			break;
		}
		case 11:
		{
			self.var_pers["player_points"] = self.var_pers["player_points"] + 1200;
			self notify("hash_79ef118b", "camo_11_obtained", undefined);
			break;
		}
		case 12:
		{
			self.var_pers["player_points"] = self.var_pers["player_points"] + 1200;
			self notify("hash_79ef118b", "camo_12_obtained", undefined);
			break;
		}
		case 13:
		{
			self.var_pers["player_points"] = self.var_pers["player_points"] + 1400;
			self notify("hash_79ef118b", "camo_13_obtained", undefined);
			break;
		}
		case 14:
		{
			self.var_pers["player_points"] = self.var_pers["player_points"] + 1400;
			self notify("hash_79ef118b", "camo_14_obtained", undefined);
			break;
		}
		case 15:
		{
			self.var_pers["player_points"] = self.var_pers["player_points"] + 1600;
			self notify("hash_79ef118b", "camo_15_obtained", undefined);
			break;
		}
		case 16:
		{
			self.var_pers["player_points"] = self.var_pers["player_points"] + 1600;
			self notify("hash_79ef118b", "camo_16_obtained", undefined);
			break;
		}
		case 17:
		{
			self.var_pers["player_points"] = self.var_pers["player_points"] + 1800;
			self notify("hash_79ef118b", "camo_17_obtained", undefined);
			break;
		}
		case 18:
		{
			self.var_pers["player_points"] = self.var_pers["player_points"] + 1800;
			self notify("hash_79ef118b", "camo_18_obtained", undefined);
			break;
		}
		case 19:
		{
			self.var_pers["player_points"] = self.var_pers["player_points"] + 2000;
			self notify("hash_79ef118b", "camo_19_obtained", undefined);
			break;
		}
		case 20:
		{
			self.var_pers["player_points"] = self.var_pers["player_points"] + 2000;
			self notify("hash_79ef118b", "camo_20_obtained", undefined);
			break;
		}
		case 21:
		{
			self.var_pers["player_points"] = self.var_pers["player_points"] + 2200;
			self notify("hash_79ef118b", "camo_21_obtained", undefined);
			break;
		}
		case 22:
		{
			self.var_pers["player_points"] = self.var_pers["player_points"] + 2200;
			self notify("hash_79ef118b", "camo_22_obtained", undefined);
			break;
		}
	}
}

/*
	Name: function_669b1c40
	Namespace: namespace_5e1f56dc
	Checksum: 0x424F4353
	Offset: 0x9D10
	Size: 0x28
	Parameters: 0
	Flags: None
	Line Number: 2579
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
	Offset: 0x9D40
	Size: 0xF0
	Parameters: 1
	Flags: None
	Line Number: 2598
*/
function function_1c1990e8(var_weapon)
{
	if(isdefined(self.var_3818be12) && self.var_3818be12.size > 0)
	{
		foreach(var_52bd8d74 in self.var_3818be12)
		{
			if(var_52bd8d74.var_stored_weapon == var_weapon.var_rootweapon || var_52bd8d74.var_stored_weapon.var_name == var_weapon.var_rootweapon.var_name)
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
	Offset: 0x9E38
	Size: 0x1B8
	Parameters: 1
	Flags: None
	Line Number: 2623
*/
function function_c3370d47(var_weapon)
{
	var_w_weapon = namespace_zm_weapons::function_get_nonalternate_weapon(var_weapon);
	if(isdefined(var_w_weapon.var_rootweapon))
	{
		var_w_weapon = var_w_weapon.var_rootweapon;
	}
	if(isdefined(var_w_weapon.var_dualWieldWeapon) && var_w_weapon.var_dualWieldWeapon != level.var_weaponNone)
	{
		if(function_IsSubStr(var_w_weapon.var_name, "lh") || function_IsSubStr(var_w_weapon.var_name, "ldw"))
		{
			var_w_weapon = namespace_zm_weapons::function_get_nonalternate_weapon(var_w_weapon.var_dualWieldWeapon);
			if(isdefined(var_w_weapon.var_rootweapon))
			{
				var_w_weapon = var_w_weapon.var_rootweapon;
			}
		}
	}
	if(!isdefined(level.var_e2a6fd15[var_w_weapon.var_name]))
	{
		return 0;
	}
	if(var_w_weapon.var_8c86d7b3 || var_w_weapon.var_7e163cf8 || namespace_zm_equipment::function_is_equipment(var_w_weapon) || namespace_zm_utility::function_is_placeable_mine(var_w_weapon))
	{
		return 0;
	}
	if(var_w_weapon.var_isRiotShield)
	{
		return 0;
	}
	return 1;
}

/*
	Name: function_1239e0ad
	Namespace: namespace_5e1f56dc
	Checksum: 0x424F4353
	Offset: 0x9FF8
	Size: 0xC0
	Parameters: 1
	Flags: None
	Line Number: 2666
*/
function function_1239e0ad(var_weapon)
{
	if(isdefined(self.var_fb56a719) && self.var_fb56a719.size > 0)
	{
		foreach(var_52bd8d74 in self.var_fb56a719)
		{
			if(var_52bd8d74.var_stored_weapon == var_weapon.var_rootweapon)
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
	Offset: 0xA0C0
	Size: 0x2D8
	Parameters: 0
	Flags: None
	Line Number: 2691
*/
function function_e078665a()
{
	switch(self.var_name)
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
	Offset: 0xA3A0
	Size: 0x128
	Parameters: 12
	Flags: None
	Line Number: 2801
*/
function function_d12c593e(var_e_inflictor, var_e_attacker, var_n_damage, var_73c5e99d, var_str_means_of_death, var_w_weapon, var_v_point, var_v_direction, var_str_hit_loc, var_bb4cbbbb, var_22b92c8f, var_str_surface_type)
{
	switch(function_ToLower(function_GetDvarString("mapname")))
	{
		case "zm_crazy_place":
		{
			if(!isdefined(self.var_73a2e922))
			{
				self.var_73a2e922 = 0;
			}
			if(self.var_73a2e922 < 3 && var_w_weapon == function_GetWeapon("t8_snowball"))
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
	return;
	ERROR: Exception occured: Stack empty.
}

/*
	Name: function_f22f093d
	Namespace: namespace_5e1f56dc
	Checksum: 0x424F4353
	Offset: 0xA4D0
	Size: 0x2F8
	Parameters: 12
	Flags: None
	Line Number: 2836
*/
function function_f22f093d(var_e_inflictor, var_e_attacker, var_n_damage, var_73c5e99d, var_str_means_of_death, var_w_weapon, var_v_point, var_v_direction, var_str_hit_loc, var_bb4cbbbb, var_22b92c8f, var_str_surface_type)
{
	if(var_e_attacker function_hasPerk("specialty_immunetriggershock") && isdefined(var_e_attacker.var_8815f6c1) && var_str_means_of_death != "MOD_MELEE_WEAPON_BUTT" && var_str_means_of_death != "MOD_MELEE" && var_str_means_of_death != "MOD_MELEE_ASSASSINATE")
	{
		var_cdca0d27 = self.var_health / self.var_maxhealth * 100;
		if(var_str_means_of_death == "MOD_MELEE" || var_str_means_of_death == "MOD_GRENADE" || var_str_means_of_death == "MOD_GRENADE_SPLASH" || var_str_means_of_death == "MOD_EXPLOSIVE" || var_str_means_of_death == "MOD_EXPLOSIVE_SPLASH" || var_str_means_of_death == "MOD_ELECTROCUTED")
		{
			return 0;
		}
		if(isdefined(var_w_weapon.var_is_wonder_weapon) && var_w_weapon.var_is_wonder_weapon || namespace_Array::function_contains(level.var_e33eb0d5, var_w_weapon.var_name))
		{
			return 0;
		}
		if(self.var_health - var_n_damage <= 0 && self.var_d229f756)
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
		var_proc = function_randomIntRange(0, 100);
		if(var_e_attacker.var_8815f6c1["shot_timer"] < 1 && !self.var_d229f756 && var_proc < var_e_attacker.var_8815f6c1["proc_chance"])
		{
			self.var_d229f756 = 1;
			self thread namespace_92fb2abd::function_8224092f();
			var_original_health = self.var_health;
			self.var_health = self.var_health * 0.07;
			self thread namespace_92fb2abd::function_3b87d567();
			var_e_attacker thread namespace_92fb2abd::function_11c25256();
			return 1;
		}
	}
	return 0;
}

/*
	Name: function_59adaa49
	Namespace: namespace_5e1f56dc
	Checksum: 0x424F4353
	Offset: 0xA7D0
	Size: 0x388
	Parameters: 9
	Flags: None
	Line Number: 2886
*/
function function_59adaa49(var_e_attacker, var_n_damage, var_v_point, var_death, var_is_headshot, var_is_minigun, var_c13cf7dd, var_8ccd861d, var_fc3ab987)
{
	if(!isdefined(var_death))
	{
		var_death = 0;
	}
	if(!isdefined(var_is_headshot))
	{
		var_is_headshot = 0;
	}
	if(!isdefined(var_is_minigun))
	{
		var_is_minigun = 0;
	}
	if(!isdefined(var_c13cf7dd))
	{
		var_c13cf7dd = 0;
	}
	if(!isdefined(var_8ccd861d))
	{
		var_8ccd861d = 0;
	}
	if(!isdefined(var_fc3ab987))
	{
		var_fc3ab987 = 0;
	}
	if(isdefined(var_e_attacker.var_b9961962) && var_e_attacker.var_b9961962)
	{
		var_Number = var_n_damage;
		var_color = 14539725;
		if(var_is_minigun || var_c13cf7dd)
		{
			var_Number = self.var_maxhealth + 1;
			var_color = 8018662;
		}
		else if(var_fc3ab987)
		{
			var_color = 5532651;
		}
		else if(self.var_health - var_n_damage <= 0 || var_death)
		{
			var_color = 14632004;
		}
		else if(var_8ccd861d)
		{
			var_color = 4913398;
		}
		else if(var_is_headshot)
		{
			var_color = 15391081;
		}
		if(var_n_damage >= self.var_maxhealth)
		{
			var_Number = self.var_maxhealth + 1;
			var_color = 8018662;
		}
		if(isdefined(var_Number) && isdefined(var_color))
		{
			var_e_attacker.var_b9961962 = 0;
			var_e_attacker.var_df17dfe1 = 1;
			var_Distance = function_Distance(self.var_origin, var_e_attacker.var_origin);
			var_e_attacker function_LUINotifyEvent(&"damage_3d", 6, function_Int(var_Number), var_color, function_Int(var_v_point[0] + function_RandomFloatRange(-4.5, 4.5)), function_Int(var_v_point[1] + function_RandomFloatRange(-4.5, 4.5)), function_Int(var_v_point[2] + function_RandomFloatRange(-4.5, 4.5)), function_Int(var_Distance / 300));
			wait(0.06 * var_e_attacker function_GetEntityNumber() + 1);
			var_e_attacker.var_b9961962 = 1;
			var_e_attacker.var_df17dfe1 = 0;
		}
	}
}

/*
	Name: function_2dce8d67
	Namespace: namespace_5e1f56dc
	Checksum: 0x424F4353
	Offset: 0xAB60
	Size: 0xD0
	Parameters: 0
	Flags: None
	Line Number: 2965
*/
function function_2dce8d67()
{
	switch(self.var_archetype)
	{
		case "astronaut":
		case "brutus":
		case "margwa":
		case "mechz":
		case "raz":
		case "thrasher":
		case "uemghost":
		case "undead_saint":
		case "zombie_george":
		{
			return 1;
		}
	}
	if(self.var_animName == "napalm_zombie" || self.var_animName == "sonic_zombie" || self.var_animName == "zombie_boss" || (isdefined(self.var_a44ca904) && self.var_a44ca904) || isdefined(self.var_81b254b3))
	{
		return 1;
	}
	return 0;
}

/*
	Name: function_bcb41215
	Namespace: namespace_5e1f56dc
	Checksum: 0x424F4353
	Offset: 0xAC38
	Size: 0x1348
	Parameters: 12
	Flags: None
	Line Number: 2999
*/
function function_bcb41215(var_e_inflictor, var_e_attacker, var_n_damage, var_73c5e99d, var_str_means_of_death, var_w_weapon, var_v_point, var_v_direction, var_str_hit_loc, var_bb4cbbbb, var_22b92c8f, var_str_surface_type)
{
	if(!isdefined(var_e_attacker) || !function_isPlayer(var_e_attacker) || !isdefined(var_w_weapon) || (isdefined(var_w_weapon function_e078665a()) && var_w_weapon function_e078665a()))
	{
		return -1;
	}
	var_is_headshot = 0;
	var_is_minigun = 0;
	var_c13cf7dd = 0;
	var_8ccd861d = 0;
	var_fc3ab987 = 0;
	var_w_weapon = namespace_zm_weapons::function_get_nonalternate_weapon(var_w_weapon);
	if(isdefined(var_w_weapon.var_rootweapon))
	{
		var_w_weapon = var_w_weapon.var_rootweapon;
	}
	if(var_e_attacker function_hasPerk("specialty_immunetriggerbetty"))
	{
		if(!(isdefined(self.var_no_damage_points) && self.var_no_damage_points) && isdefined(var_e_attacker))
		{
			var_chance = function_randomIntRange(1, 100);
			if(var_chance <= 25)
			{
				var_e_attacker namespace_zm_score::function_player_add_points("damage", var_str_means_of_death, var_str_hit_loc, 0, undefined, var_w_weapon);
			}
		}
	}
	self thread function_d12c593e(var_e_inflictor, var_e_attacker, var_n_damage, var_73c5e99d, var_str_means_of_death, var_w_weapon, var_v_point, var_v_direction, var_str_hit_loc, var_bb4cbbbb, var_22b92c8f, var_str_surface_type);
	if(!isdefined(self.var_42397ab9))
	{
		self.var_42397ab9 = [];
	}
	if(!namespace_Array::function_contains(self.var_42397ab9, var_e_attacker))
	{
		self.var_42397ab9[self.var_42397ab9.size] = var_e_attacker;
	}
	if(self function_2dce8d67())
	{
		var_2dce8d67 = 1;
	}
	if(isdefined(var_e_attacker.var_cookedTime) && var_e_attacker.var_cookedTime > 300 && (function_IsSubStr(var_str_means_of_death, "MOD_GRENADE") || function_IsSubStr(var_str_means_of_death, "MOD_GRENADE_SPLASH")))
	{
		var_5567414f = 1 + 0.02 * var_e_attacker.var_cookedTime - 1000;
		var_94aafc21 = 1;
		if(level.var_round_number > 0 && level.var_round_number % 5 == 1)
		{
			var_12ac46ba = level.var_round_number - 1 / 5;
			var_a168ae5b = 17;
			if(var_12ac46ba > var_a168ae5b)
			{
				var_12ac46ba = var_a168ae5b;
			}
			for(var_i = 0; var_i < var_12ac46ba; var_i++)
			{
				var_94aafc21 = var_94aafc21 * 1.25;
			}
		}
		else if(isdefined(var_2dce8d67) && var_2dce8d67)
		{
			var_n_damage = var_n_damage * var_5567414f * var_94aafc21 / 10;
		}
		else
		{
			var_n_damage = var_n_damage * var_5567414f * var_94aafc21;
		}
	}
	var_8ccd861d = self thread function_f22f093d(var_e_inflictor, var_e_attacker, var_n_damage, var_73c5e99d, var_str_means_of_death, var_w_weapon, var_v_point, var_v_direction, var_str_hit_loc, var_bb4cbbbb, var_22b92c8f, var_str_surface_type);
	if(function_IsSubStr(var_w_weapon.var_name, "minigun") || var_w_weapon == level.var_zombie_powerup_weapon["minigun"])
	{
		var_is_minigun = 1;
		if(isdefined(var_2dce8d67) && var_2dce8d67)
		{
			var_n_damage = var_n_damage * 2;
		}
		else
		{
			self.var_health = 1;
		}
	}
	if(var_w_weapon.var_name == "special_crossbow_dw" || var_w_weapon.var_name == "special_crossbow_dw_upgraded")
	{
		var_n_damage = var_n_damage * 7;
	}
	if(level.var_round_number > 10 && !level namespace_flag::function_get("classic_enabled"))
	{
		if(level.var_round_number < 35 || (level.var_round_number < 35 && namespace_zm_weapons::function_is_weapon_upgraded(var_w_weapon)))
		{
			var_49503885 = level.var_round_number;
		}
		else
		{
			var_49503885 = 35;
		}
		if(namespace_zm_weapons::function_is_weapon_upgraded(var_w_weapon))
		{
			var_9c34c6c2 = var_e_attacker function_871a41a6(var_n_damage, var_w_weapon, 1);
			if(isdefined(var_9c34c6c2))
			{
				if(level namespace_flag::function_get("debug_dev"))
				{
					function_IPrintLnBold("Upgraded Weapon Multiplier: " + var_9c34c6c2);
				}
				if(var_e_attacker function_hasPerk("specialty_doubletap2"))
				{
				}
				else
				{
				}
				var_n_damage = function_Int(var_n_damage + var_n_damage * var_49503885 * 0.019 * var_9c34c6c2);
			}
			else if(var_e_attacker function_hasPerk("specialty_doubletap2"))
			{
			}
			else
			{
			}
			var_n_damage = function_Int(var_n_damage + var_n_damage * var_49503885 * 0.008);
		}
		else
		{
			var_9c34c6c2 = var_e_attacker function_871a41a6(var_n_damage, var_w_weapon, 0);
			if(isdefined(var_9c34c6c2))
			{
				if(level namespace_flag::function_get("debug_dev"))
				{
					function_IPrintLnBold("Weapon Multiplier: " + var_9c34c6c2);
				}
				if(var_e_attacker function_hasPerk("specialty_doubletap2"))
				{
				}
				else
				{
				}
				var_n_damage = function_Int(var_n_damage + var_n_damage * var_49503885 * 0.019 * var_9c34c6c2);
			}
			else if(var_e_attacker function_hasPerk("specialty_doubletap2"))
			{
			}
			else
			{
			}
			var_n_damage = function_Int(var_n_damage + var_n_damage * var_49503885 * 0.019);
		}
	}
	if(isdefined(var_w_weapon.var_dualWieldWeapon) && var_w_weapon.var_dualWieldWeapon != level.var_weaponNone && (function_IsSubStr(var_w_weapon.var_name, "ldw") || function_IsSubStr(var_w_weapon.var_name, "lh")))
	{
		var_480fed80 = var_e_attacker function_1239e0ad(var_w_weapon.var_dualWieldWeapon);
		if(isdefined(var_480fed80))
		{
			if(var_480fed80.var_a39a2843 >= 1)
			{
				var_n_damage = var_n_damage * var_480fed80.var_a39a2843 * level.var_eae5b518[var_480fed80.var_a39a2843];
			}
		}
	}
	else
	{
		var_480fed80 = var_e_attacker function_1239e0ad(var_w_weapon);
		if(isdefined(var_480fed80))
		{
			if(var_480fed80.var_a39a2843 >= 1)
			{
				var_n_damage = var_n_damage * var_480fed80.var_a39a2843 * level.var_eae5b518[var_480fed80.var_a39a2843];
			}
		}
	}
	if(level.var_round_number > 10 && var_str_means_of_death != "MOD_MELEE_WEAPON_BUTT" && var_str_means_of_death != "MOD_MELEE" && var_str_means_of_death != "MOD_MELEE_ASSASSINATE" && !level namespace_flag::function_get("classic_enabled"))
	{
		var_32e25858 = var_e_attacker function_927ab3e5(var_e_attacker function_hasPerk("specialty_doubletap2"), var_e_attacker function_is_shotgun(var_w_weapon));
		var_n_damage = var_n_damage * var_32e25858;
	}
	if(var_str_hit_loc == "head" || var_str_hit_loc == "helmet" && var_str_means_of_death != "MOD_MELEE_WEAPON_BUTT" && var_str_means_of_death != "MOD_MELEE" && var_str_means_of_death != "MOD_MELEE_ASSASSINATE" && !level namespace_flag::function_get("classic_enabled"))
	{
		var_5956b503 = var_e_attacker function_8cf695b8(var_e_attacker function_hasPerk("specialty_deadshot"));
		var_n_damage = var_n_damage * var_5956b503;
		var_is_headshot = 1;
	}
	if(isdefined(var_e_attacker.var_fa202141["player_playerdifficulty"]) && var_e_attacker.var_fa202141["player_playerdifficulty"] > 0)
	{
		if(!(isdefined(var_e_attacker.var_afterlife) && var_e_attacker.var_afterlife))
		{
			var_multiplier = 0.8 - var_e_attacker.var_fa202141["player_playerdifficulty"] * 0.005;
			var_n_damage = var_n_damage * var_multiplier;
		}
	}
	if(isdefined(level.var_18ffd3f2[var_e_attacker function_getxuid(1)]) && var_e_attacker.var_f4d01b67["fx_damage"] == 0 && function_randomIntRange(1, 100) < 30)
	{
		switch(level.var_18ffd3f2[var_e_attacker function_getxuid(1)].var_rank)
		{
			case "master":
			case "paragon":
			case "ultimate":
			{
				if(self.var_health - var_n_damage < 1)
				{
					self thread function_ec39f1ff(level.var__effect["zm_weapon_vip_death"], "tag_origin", "fireworks_show");
				}
				else
				{
					self thread function_ec39f1ff(level.var__effect["zm_weapon_vip_damage"], "j_spine4", undefined);
					break;
				}
			}
		}
	}
	if(isdefined(level.var_zombie_vars[var_e_attacker.var_team]["zombie_insta_kill"]) && level.var_zombie_vars[var_e_attacker.var_team]["zombie_insta_kill"])
	{
		if(isdefined(var_2dce8d67) && var_2dce8d67)
		{
			var_n_damage = var_n_damage * 1.15;
		}
		else if(!(isdefined(self.var_fc3ab987) && self.var_fc3ab987))
		{
			self.var_health = 1;
			var_c13cf7dd = 1;
		}
	}
	if(isdefined(self.var_fc3ab987) && self.var_fc3ab987)
	{
		var_fc3ab987 = 1;
		if(var_str_means_of_death == "MOD_GRENADE" || var_str_means_of_death == "MOD_GRENADE_SPLASH" || var_str_means_of_death == "MOD_EXPLOSIVE" || var_str_means_of_death == "MOD_EXPLOSIVE_SPLASH")
		{
			var_n_damage = var_n_damage * 2;
		}
		else if(var_w_weapon == function_GetWeapon("t9_me_knife_american") || var_w_weapon == function_GetWeapon("t9_me_knife_american_up"))
		{
			var_n_damage = var_n_damage * 3;
		}
		else if(isdefined(level.var_zombie_vars[var_e_attacker.var_team]["zombie_insta_kill"]) && level.var_zombie_vars[var_e_attacker.var_team]["zombie_insta_kill"])
		{
			var_n_damage = var_n_damage * 4;
		}
		else if(var_w_weapon.var_weapClass == "spread")
		{
			var_n_damage = var_n_damage * 1.5;
		}
	}
	if(var_e_attacker.var_d3e2d270["pet"])
	{
		if(var_e_attacker.var_d3e2d270["pet"].var_pet == "motd_plushie")
		{
			if(var_2dce8d67)
			{
				var_n_damage = var_n_damage * 1.05;
			}
		}
	}
	if(isdefined(var_e_attacker.var_hud_damagefeedback_additional) && var_e_attacker.var_f4d01b67["hitmarkers"] == 0)
	{
		var_hitmarker = 1;
		if(self.var_archetype == "margwa" && !self function_7db1344c(var_v_point))
		{
			var_hitmarker = 0;
		}
		if(isdefined(self.var_22ce02e1) && self.var_22ce02e1)
		{
			var_hitmarker = 0;
		}
		if(var_hitmarker)
		{
			self thread function_d2b0307(var_e_attacker, var_n_damage, var_str_hit_loc, var_str_means_of_death, var_fc3ab987);
		}
	}
	if(level.var_headshots_only && (var_str_hit_loc != "head" || var_str_hit_loc != "helmet"))
	{
		return -1;
	}
	var_e_attacker thread namespace_97ac1184::function_1d39abf6("end_game_total_damage", var_n_damage, 0);
	var_3ef05c92 = var_e_attacker.var_pers["end_game_total_damage"] / var_e_attacker.var_pers["total_hits"] - var_e_attacker.var_pers["end_game_total_hits"];
	var_e_attacker thread namespace_97ac1184::function_1d39abf6("end_game_average_damage", var_3ef05c92, 0);
	if(var_n_damage > var_e_attacker.var_pers["end_game_highest_damage"])
	{
		var_e_attacker thread namespace_97ac1184::function_1d39abf6("end_game_highest_damage", var_n_damage, 0);
	}
	if(var_e_attacker.var_f4d01b67["damage_numbers"] == 0)
	{
		var_59adaa49 = 1;
		if(self.var_archetype == "margwa" && !self function_7db1344c(var_v_point))
		{
			var_59adaa49 = 0;
		}
		if(!(isdefined(self.var_86bf39b2) && self.var_86bf39b2) && (isdefined(self.var_a44ca904) && self.var_a44ca904 || self.var_archetype == "ghost"))
		{
			var_59adaa49 = 0;
		}
		if(isdefined(self.var_22ce02e1) && self.var_22ce02e1)
		{
			var_59adaa49 = 0;
		}
		if(var_59adaa49)
		{
			self thread function_59adaa49(var_e_attacker, var_n_damage, var_v_point, 0, var_is_headshot, var_is_minigun, var_c13cf7dd, var_8ccd861d, var_fc3ab987);
		}
	}
	return var_n_damage;
}

/*
	Name: function_7db1344c
	Namespace: namespace_5e1f56dc
	Checksum: 0x424F4353
	Offset: 0xBF88
	Size: 0x118
	Parameters: 1
	Flags: None
	Line Number: 3306
*/
function function_7db1344c(var_v_point)
{
	var_6a28811 = 0;
	if(isdefined(self.var_head))
	{
		foreach(var_head in self.var_head)
		{
			var_head_pos = self function_GetTagOrigin(var_head.var_tag);
			if(function_DistanceSquared(var_head_pos, var_v_point) < 250 && var_head.var_canDamage)
			{
				var_6a28811 = 1;
			}
		}
	}
	else if(var_6a28811)
	{
		return 1;
	}
	return 0;
}

/*
	Name: function_is_shotgun
	Namespace: namespace_5e1f56dc
	Checksum: 0x424F4353
	Offset: 0xC0A8
	Size: 0x70
	Parameters: 1
	Flags: None
	Line Number: 3337
*/
function function_is_shotgun(var_weapon)
{
	var_shotguns = function_Array("shotgun_pump", "shotgun_precision", "shotgun_fullauto", "shotgun_energy", "shotgun_semiauto");
	return function_IsInArray(var_shotguns, var_weapon);
}

/*
	Name: function_8cf695b8
	Namespace: namespace_5e1f56dc
	Checksum: 0x424F4353
	Offset: 0xC120
	Size: 0x200
	Parameters: 1
	Flags: None
	Line Number: 3353
*/
function function_8cf695b8(var_40be383d)
{
	var_multiplier = 1;
	if(isdefined(self.var_fa202141["player_playerdifficulty"]) && self.var_fa202141["player_playerdifficulty"] > 0)
	{
		var_multiplier = 1 - self.var_fa202141["player_playerdifficulty"] * 0.003;
	}
	var_rand = function_RandomFloatRange(0, 1);
	if(var_40be383d)
	{
		if(var_rand <= 0.5)
		{
			return 0.5 * var_multiplier * function_RandomFloatRange(1, 1.3);
		}
		else if(var_rand <= 0.8)
		{
			return 0.5 * var_multiplier * function_RandomFloatRange(1.3, 1.9);
		}
		else
		{
			return 0.5 * var_multiplier * function_RandomFloatRange(1.9, 2.8);
		}
	}
	else if(var_rand <= 0.7)
	{
		return 0.4 * var_multiplier * function_RandomFloatRange(1, 1.2);
	}
	else if(var_rand <= 0.9)
	{
		return 0.4 * var_multiplier * function_RandomFloatRange(1.2, 1.6);
	}
	else
	{
		return 0.4 * var_multiplier * function_RandomFloatRange(1.6, 2.2);
	}
}

/*
	Name: function_927ab3e5
	Namespace: namespace_5e1f56dc
	Checksum: 0x424F4353
	Offset: 0xC328
	Size: 0x228
	Parameters: 2
	Flags: None
	Line Number: 3400
*/
function function_927ab3e5(var_684cdff, var_b17eaa4d)
{
	var_multiplier = 1;
	if(isdefined(var_b17eaa4d) && var_b17eaa4d)
	{
		return function_RandomFloatRange(0.9, 1.5);
	}
	if(isdefined(self.var_fa202141["player_playerdifficulty"]) && self.var_fa202141["player_playerdifficulty"] > 0)
	{
		var_multiplier = 1 - self.var_fa202141["player_playerdifficulty"] * 0.003;
	}
	var_rand = function_RandomFloatRange(0, 1);
	if(var_684cdff)
	{
		if(var_rand <= 0.5)
		{
			return var_multiplier * function_RandomFloatRange(1, 1.3);
		}
		else if(var_rand <= 0.8)
		{
			return var_multiplier * function_RandomFloatRange(1.6, 3);
		}
		else
		{
			return var_multiplier * function_RandomFloatRange(3.4, 4.5);
		}
	}
	else if(var_rand <= 0.7)
	{
		return 0.8 * var_multiplier * function_RandomFloatRange(1, 1.4);
	}
	else if(var_rand <= 0.9)
	{
		return 0.8 * var_multiplier * function_RandomFloatRange(1.4, 1.8);
	}
	else
	{
		return 0.8 * var_multiplier * function_RandomFloatRange(1.8, 3);
	}
}

/*
	Name: function_d2b0307
	Namespace: namespace_5e1f56dc
	Checksum: 0x424F4353
	Offset: 0xC558
	Size: 0x5C8
	Parameters: 6
	Flags: None
	Line Number: 3451
*/
function function_d2b0307(var_player, var_n_damage, var_str_hit_loc, var_str_means_of_death, var_shield, var_7a827622)
{
	if(!isdefined(var_shield))
	{
		var_shield = 0;
	}
	if(!isdefined(var_7a827622))
	{
		var_7a827622 = 0;
	}
	var_shader = "damage_feedback";
	var_a8c6a152 = function_Array(24, 48);
	switch(var_player.var_f4d01b67["hitmarkers"])
	{
		default
		{
			if(isdefined(var_7a827622) && var_7a827622)
			{
				var_shader = "uem_hitmarker_shield";
				var_a8c6a152 = function_Array(24, 48);
			}
			else if(self.var_health - var_n_damage < 1)
			{
				var_shader = "damage_feedback_glow_orange";
				var_a8c6a152 = function_Array(24, 48);
			}
			else
			{
				var_shader = "damage_feedback";
				var_a8c6a152 = function_Array(24, 48);
				break;
			}
		}
	}
	switch(var_player.var_f4d01b67["hitmarker_sounds"])
	{
		case 0:
		{
			if(isdefined(var_shield) && var_shield && function_randomIntRange(0, 10) < 7)
			{
				if(self.var_health - var_n_damage < 1 || (isdefined(var_7a827622) && var_7a827622))
				{
					var_sound = "uem_hitmarker_shield_break";
				}
				else
				{
					var_sound = "uem_hitmarker_shield";
				}
			}
			else if(self.var_health - var_n_damage < 1)
			{
				if(var_str_hit_loc == "head" || var_str_hit_loc == "helmet" || var_str_means_of_death == "MOD_HEAD_SHOT")
				{
					var_sound = "uem_hitmarker_headshot";
				}
				else
				{
					var_sound = "uem_hitmarker_death";
				}
			}
			else
			{
				var_sound = "uem_hitmarker_default";
				break;
			}
		}
		case 2:
		{
			if(self.var_health - var_n_damage < 1)
			{
				var_sound = "uem_hitmarker_minecraft_death";
			}
			else
			{
				var_sound = "uem_hitmarker_minecraft_default";
				break;
			}
		}
	}
	if(var_player.var_f4d01b67["hitmarker_sounds"] == 0)
	{
		var_player function_playsoundtoplayer(var_sound, var_player);
	}
	if(self.var_health - var_n_damage < 1)
	{
		var_player.var_hud_damagefeedback_additional.var_x = -14;
		var_player.var_hud_damagefeedback_additional.var_y = -14;
		var_player.var_hud_damagefeedback_additional function_SetShader(var_shader, var_a8c6a152[0], var_a8c6a152[1]);
		var_player.var_hud_damagefeedback_additional.var_alpha = 1;
		if(!(isdefined(var_shield) && var_shield))
		{
			var_player.var_hud_damagefeedback_additional function_ScaleOverTime(0.1, 34, 58);
		}
		wait(0.4);
		var_player.var_hud_damagefeedback_additional function_ScaleOverTime(0.1, var_a8c6a152[0], var_a8c6a152[1]);
		wait(0.4);
		var_player.var_hud_damagefeedback_additional function_fadeOverTime(0.2);
		var_player.var_hud_damagefeedback_additional.var_alpha = 0;
	}
	else
	{
		var_player.var_hud_damagefeedback_additional.var_x = -12;
		var_player.var_hud_damagefeedback_additional.var_y = -12;
		var_player.var_hud_damagefeedback_additional function_SetShader(var_shader, var_a8c6a152[0], var_a8c6a152[1]);
		var_player.var_hud_damagefeedback_additional.var_alpha = 1;
		if(!(isdefined(var_shield) && var_shield))
		{
			var_player.var_hud_damagefeedback_additional function_ScaleOverTime(0.1, 28, 52);
		}
		wait(0.4);
		var_player.var_hud_damagefeedback_additional function_ScaleOverTime(0.1, var_a8c6a152[0], var_a8c6a152[1]);
		wait(0.4);
		var_player.var_hud_damagefeedback_additional function_fadeOverTime(0.2);
		var_player.var_hud_damagefeedback_additional.var_alpha = 0;
	}
}

/*
	Name: function_ec39f1ff
	Namespace: namespace_5e1f56dc
	Checksum: 0x424F4353
	Offset: 0xCB28
	Size: 0x90
	Parameters: 3
	Flags: None
	Line Number: 3578
*/
function function_ec39f1ff(var_FX, var_tag, var_sound)
{
	if(isdefined(self) && function_isalive(self))
	{
		if(isdefined(var_sound))
		{
			function_playsoundatposition(var_sound, self.var_origin);
		}
		if(isdefined(var_FX))
		{
			function_PlayFXOnTag(var_FX, self, var_tag);
			return;
		}
	}
	ERROR: Exception occured: Stack empty.
}

/*
	Name: function_871a41a6
	Namespace: namespace_5e1f56dc
	Checksum: 0x424F4353
	Offset: 0xCBC0
	Size: 0x198
	Parameters: 3
	Flags: None
	Line Number: 3605
*/
function function_871a41a6(var_n_damage, var_w_weapon, var_upgraded)
{
	var_w_weapon = namespace_zm_weapons::function_get_nonalternate_weapon(var_w_weapon);
	if(isdefined(var_w_weapon.var_rootweapon))
	{
		var_w_weapon = var_w_weapon.var_rootweapon;
	}
	var_weapon_check = var_w_weapon.var_name;
	var_cde9f622 = function_StrTok(var_w_weapon.var_name, "_");
	if(isdefined(var_upgraded) && var_upgraded)
	{
		var_weapon_check = var_cde9f622[0] + "_" + var_cde9f622[1];
	}
	if(isdefined(level.var_9458e47[var_weapon_check]))
	{
		if(function_IsSubStr(var_weapon_check, level.var_9458e47[var_weapon_check].var_weapon))
		{
			if(isdefined(var_upgraded) && var_upgraded)
			{
				return function_float(level.var_9458e47[var_weapon_check].var_1ed30589);
			}
			else
			{
				return function_float(level.var_9458e47[var_weapon_check].var_f4340604);
			}
		}
	}
	return undefined;
}

/*
	Name: function_672cee89
	Namespace: namespace_5e1f56dc
	Checksum: 0x424F4353
	Offset: 0xCD60
	Size: 0x10
	Parameters: 0
	Flags: None
	Line Number: 3645
*/
function function_672cee89()
{
	return "gamedata/weapons/damage_multiplier/zm_damage_multiplier.csv";
}

/*
	Name: function_checkStringValid
	Namespace: namespace_5e1f56dc
	Checksum: 0x424F4353
	Offset: 0xCD78
	Size: 0x28
	Parameters: 1
	Flags: None
	Line Number: 3660
*/
function function_checkStringValid(var_STR)
{
	if(var_STR != "")
	{
		return var_STR;
	}
	return undefined;
	ERROR: Bad function call
}

/*
	Name: function_99b02ca6
	Namespace: namespace_5e1f56dc
	Checksum: 0x424F4353
	Offset: 0xCDA8
	Size: 0x10D8
	Parameters: 15
	Flags: None
	Line Number: 3680
*/
function function_99b02ca6(var_e_inflictor, var_e_attacker, var_n_damage, var_73c5e99d, var_str_means_of_death, var_w_weapon, var_v_point, var_v_direction, var_str_hit_loc, var_v_damage_origin, var_bb4cbbbb, var_e37399f9, var_22b92c8f, var_str_part_name, var_str_surface_type)
{
	if(!isdefined(var_e_attacker) || !function_isPlayer(var_e_attacker) || !isdefined(var_w_weapon))
	{
		return var_n_damage;
	}
	var_is_headshot = 0;
	var_is_minigun = 0;
	var_c13cf7dd = 0;
	var_8ccd861d = 0;
	var_fc3ab987 = 0;
	var_w_weapon = namespace_zm_weapons::function_get_nonalternate_weapon(var_w_weapon);
	if(isdefined(var_w_weapon.var_rootweapon))
	{
		var_w_weapon = var_w_weapon.var_rootweapon;
	}
	if(var_e_attacker function_hasPerk("specialty_immunetriggerbetty"))
	{
		if(!(isdefined(self.var_no_damage_points) && self.var_no_damage_points) && isdefined(var_e_attacker))
		{
			var_chance = function_randomIntRange(1, 100);
			if(var_chance <= 25)
			{
				var_e_attacker namespace_zm_score::function_player_add_points("damage", var_str_means_of_death, var_str_hit_loc, 0, undefined, var_w_weapon);
			}
		}
	}
	self thread function_d12c593e(var_e_inflictor, var_e_attacker, var_n_damage, var_73c5e99d, var_str_means_of_death, var_w_weapon, var_v_point, var_v_direction, var_str_hit_loc, var_bb4cbbbb, var_22b92c8f, var_str_surface_type);
	if(!isdefined(self.var_42397ab9))
	{
		self.var_42397ab9 = [];
	}
	if(!namespace_Array::function_contains(self.var_42397ab9, var_e_attacker))
	{
		self.var_42397ab9[self.var_42397ab9.size] = var_e_attacker;
	}
	if(self function_2dce8d67())
	{
		var_2dce8d67 = 1;
	}
	if(isdefined(var_e_attacker.var_cookedTime) && var_e_attacker.var_cookedTime > 300 && (function_IsSubStr(var_str_means_of_death, "MOD_GRENADE") || function_IsSubStr(var_str_means_of_death, "MOD_GRENADE_SPLASH")))
	{
		var_5567414f = 1 + 0.02 * var_e_attacker.var_cookedTime - 1000;
		var_94aafc21 = 1;
		if(level.var_round_number > 0 && level.var_round_number % 5 == 1)
		{
			var_12ac46ba = level.var_round_number - 1 / 5;
			var_a168ae5b = 17;
			if(var_12ac46ba > var_a168ae5b)
			{
				var_12ac46ba = var_a168ae5b;
			}
			for(var_i = 0; var_i < var_12ac46ba; var_i++)
			{
				var_94aafc21 = var_94aafc21 * 1.25;
			}
		}
		else if(isdefined(var_2dce8d67) && var_2dce8d67)
		{
			var_n_damage = var_n_damage * var_5567414f * var_94aafc21 / 10;
		}
		else
		{
			var_n_damage = var_n_damage * var_5567414f * var_94aafc21;
		}
	}
	var_8ccd861d = self thread function_f22f093d(var_e_inflictor, var_e_attacker, var_n_damage, var_73c5e99d, var_str_means_of_death, var_w_weapon, var_v_point, var_v_direction, var_str_hit_loc, var_bb4cbbbb, var_22b92c8f, var_str_surface_type);
	if(function_IsSubStr(var_w_weapon.var_name, "minigun") || var_w_weapon == level.var_zombie_powerup_weapon["minigun"])
	{
		var_is_minigun = 1;
		if(isdefined(var_2dce8d67) && var_2dce8d67)
		{
			var_n_damage = var_n_damage * 2;
		}
		else
		{
			self.var_health = 1;
		}
	}
	if(var_w_weapon.var_name == "special_crossbow_dw" || var_w_weapon.var_name == "special_crossbow_dw_upgraded")
	{
		var_n_damage = var_n_damage * 7;
	}
	if(level.var_round_number > 10 && !level namespace_flag::function_get("classic_enabled"))
	{
		if(level.var_round_number < 35 || (level.var_round_number < 35 && namespace_zm_weapons::function_is_weapon_upgraded(var_w_weapon)))
		{
			var_49503885 = level.var_round_number;
		}
		else
		{
			var_49503885 = 35;
		}
		if(namespace_zm_weapons::function_is_weapon_upgraded(var_w_weapon))
		{
			if(var_e_attacker function_hasPerk("specialty_doubletap2"))
			{
			}
			else
			{
			}
			var_n_damage = function_Int(var_n_damage + var_n_damage * var_49503885 * 0.008);
		}
		else if(var_e_attacker function_hasPerk("specialty_doubletap2"))
		{
		}
		else
		{
		}
		var_n_damage = function_Int(var_n_damage + var_n_damage * var_49503885 * 0.019);
	}
	if(isdefined(var_w_weapon.var_dualWieldWeapon) && var_w_weapon.var_dualWieldWeapon != level.var_weaponNone && (function_IsSubStr(var_w_weapon.var_name, "ldw") || function_IsSubStr(var_w_weapon.var_name, "lh")))
	{
		var_480fed80 = var_e_attacker function_1239e0ad(var_w_weapon.var_dualWieldWeapon);
		if(isdefined(var_480fed80))
		{
			if(var_480fed80.var_a39a2843 >= 1)
			{
				var_n_damage = var_n_damage * var_480fed80.var_a39a2843 * level.var_eae5b518[var_480fed80.var_a39a2843];
			}
		}
	}
	else
	{
		var_480fed80 = var_e_attacker function_1239e0ad(var_w_weapon);
		if(isdefined(var_480fed80))
		{
			if(var_480fed80.var_a39a2843 >= 1)
			{
				var_n_damage = var_n_damage * var_480fed80.var_a39a2843 * level.var_eae5b518[var_480fed80.var_a39a2843];
			}
		}
	}
	if(level.var_round_number > 10 && var_str_means_of_death != "MOD_MELEE_WEAPON_BUTT" && var_str_means_of_death != "MOD_MELEE" && var_str_means_of_death != "MOD_MELEE_ASSASSINATE" && !level namespace_flag::function_get("classic_enabled"))
	{
		var_32e25858 = var_e_attacker function_927ab3e5(var_e_attacker function_hasPerk("specialty_doubletap2"), var_e_attacker function_is_shotgun(var_w_weapon));
		var_n_damage = var_n_damage * var_32e25858;
	}
	if(var_str_hit_loc == "head" || var_str_hit_loc == "helmet" && var_str_means_of_death != "MOD_MELEE_WEAPON_BUTT" && var_str_means_of_death != "MOD_MELEE" && var_str_means_of_death != "MOD_MELEE_ASSASSINATE" && !level namespace_flag::function_get("classic_enabled"))
	{
		var_5956b503 = var_e_attacker function_8cf695b8(var_e_attacker function_hasPerk("specialty_deadshot"));
		var_n_damage = var_n_damage * var_5956b503;
		var_is_headshot = 1;
	}
	if(isdefined(var_e_attacker.var_fa202141["player_playerdifficulty"]) && var_e_attacker.var_fa202141["player_playerdifficulty"] > 0)
	{
		var_multiplier = 0.8 - var_e_attacker.var_fa202141["player_playerdifficulty"] * 0.005;
		var_n_damage = var_n_damage * var_multiplier;
	}
	if(isdefined(level.var_18ffd3f2[var_e_attacker function_getxuid(1)]) && var_e_attacker.var_f4d01b67["fx_damage"] == 0 && function_randomIntRange(1, 100) < 30)
	{
		switch(level.var_18ffd3f2[var_e_attacker function_getxuid(1)].var_rank)
		{
			case "master":
			case "paragon":
			case "ultimate":
			{
				if(self.var_health - var_n_damage < 1)
				{
					self thread function_ec39f1ff(level.var__effect["zm_weapon_vip_death"], "tag_origin", "fireworks_show");
				}
				else
				{
					self thread function_ec39f1ff(level.var__effect["zm_weapon_vip_damage"], "j_spine4", undefined);
					break;
				}
			}
		}
	}
	if(isdefined(level.var_zombie_vars[var_e_attacker.var_team]["zombie_insta_kill"]) && level.var_zombie_vars[var_e_attacker.var_team]["zombie_insta_kill"])
	{
		if(isdefined(var_2dce8d67) && var_2dce8d67)
		{
			var_n_damage = var_n_damage * 1.15;
		}
		else
		{
			self.var_health = 1;
			var_c13cf7dd = 1;
		}
	}
	if(isdefined(self.var_fc3ab987) && self.var_fc3ab987)
	{
		var_fc3ab987 = 1;
		if(var_str_means_of_death == "MOD_GRENADE" || var_str_means_of_death == "MOD_GRENADE_SPLASH" || var_str_means_of_death == "MOD_EXPLOSIVE" || var_str_means_of_death == "MOD_EXPLOSIVE_SPLASH")
		{
			var_n_damage = var_n_damage * 2;
		}
		else if(var_str_means_of_death == "MOD_MELEE_WEAPON_BUTT" || var_str_means_of_death == "MOD_MELEE" || var_str_means_of_death == "MOD_MELEE_ASSASSINATE")
		{
			var_n_damage = var_n_damage * 3;
		}
		else if(isdefined(level.var_zombie_vars[var_e_attacker.var_team]["zombie_insta_kill"]) && level.var_zombie_vars[var_e_attacker.var_team]["zombie_insta_kill"])
		{
			var_n_damage = var_n_damage * 4;
		}
		else if(var_w_weapon.var_weapClass == "spread")
		{
			var_n_damage = var_n_damage * 1.5;
		}
	}
	if(isdefined(var_e_attacker.var_hud_damagefeedback_additional) && var_e_attacker.var_f4d01b67["hitmarkers"] == 0)
	{
		var_hitmarker = 1;
		if(self.var_archetype == "margwa" && !self function_7db1344c(var_v_point))
		{
			var_hitmarker = 0;
		}
		if(isdefined(self.var_22ce02e1) && self.var_22ce02e1)
		{
			var_hitmarker = 0;
		}
		if(var_hitmarker)
		{
			self thread function_d2b0307(var_e_attacker, var_n_damage, var_str_hit_loc, var_str_means_of_death, var_fc3ab987);
		}
	}
	if(level.var_headshots_only && (var_str_hit_loc != "head" || var_str_hit_loc != "helmet"))
	{
		return -1;
	}
	var_e_attacker thread namespace_97ac1184::function_1d39abf6("end_game_total_damage", var_n_damage, 0);
	var_3ef05c92 = var_e_attacker.var_pers["end_game_total_damage"] / var_e_attacker.var_pers["total_hits"] - var_e_attacker.var_pers["end_game_total_hits"];
	var_e_attacker thread namespace_97ac1184::function_1d39abf6("end_game_average_damage", var_3ef05c92, 0);
	if(var_n_damage > var_e_attacker.var_pers["end_game_highest_damage"])
	{
		var_e_attacker thread namespace_97ac1184::function_1d39abf6("end_game_highest_damage", var_n_damage, 0);
	}
	if(var_e_attacker.var_f4d01b67["damage_numbers"] == 0)
	{
		var_59adaa49 = 1;
		if(self.var_archetype == "margwa" && !self function_7db1344c(var_v_point))
		{
			var_59adaa49 = 0;
		}
		if(!(isdefined(self.var_86bf39b2) && self.var_86bf39b2) && (isdefined(self.var_a44ca904) && self.var_a44ca904 || self.var_archetype == "ghost"))
		{
			var_59adaa49 = 0;
		}
		if(isdefined(self.var_22ce02e1) && self.var_22ce02e1)
		{
			var_59adaa49 = 0;
		}
		if(var_59adaa49)
		{
			self thread function_59adaa49(var_e_attacker, var_n_damage, var_v_point, 0, var_is_headshot, var_is_minigun, var_c13cf7dd, var_8ccd861d, var_fc3ab987);
		}
	}
	self namespace_globallogic_vehicle::function_Callback_VehicleDamage(var_e_inflictor, var_e_attacker, var_n_damage, var_73c5e99d, var_str_means_of_death, var_w_weapon, var_v_point, var_v_direction, var_str_hit_loc, var_v_damage_origin, var_bb4cbbbb, var_e37399f9, var_22b92c8f, var_str_part_name, var_str_surface_type);
	return var_n_damage;
}

/*
	Name: function_create_unitrigger
	Namespace: namespace_5e1f56dc
	Checksum: 0x424F4353
	Offset: 0xDE88
	Size: 0x1B8
	Parameters: 5
	Flags: None
	Line Number: 3942
*/
function function_create_unitrigger(var_str_hint, var_n_radius, var_func_prompt_and_visibility, var_func_unitrigger_logic, var_s_trigger_type)
{
	if(!isdefined(var_n_radius))
	{
		var_n_radius = 128;
	}
	if(!isdefined(var_func_prompt_and_visibility))
	{
		var_func_prompt_and_visibility = &namespace_zm_unitrigger::function_unitrigger_prompt_and_visibility;
	}
	if(!isdefined(var_func_unitrigger_logic))
	{
		var_func_unitrigger_logic = &function_unitrigger_logic;
	}
	if(!isdefined(var_s_trigger_type))
	{
		var_s_trigger_type = "unitrigger_radius_use";
	}
	self.var_s_unitrigger = function_spawnstruct();
	self.var_s_unitrigger.var_origin = self.var_origin;
	self.var_s_unitrigger.var_angles = self.var_angles;
	self.var_s_unitrigger.var_script_unitrigger_type = "unitrigger_box_use";
	self.var_s_unitrigger.var_cursor_hint = "HINT_NOICON";
	self.var_s_unitrigger.var_hint_string = var_str_hint;
	self.var_s_unitrigger.var_require_look_at = 0;
	self.var_s_unitrigger.var_related_parent = self;
	self.var_s_unitrigger.var_radius = var_n_radius;
	namespace_zm_unitrigger::function_unitrigger_force_per_player_triggers(self.var_s_unitrigger, 1);
	self.var_s_unitrigger.var_prompt_and_visibility_func = var_func_prompt_and_visibility;
	namespace_zm_unitrigger::function_register_static_unitrigger(self.var_s_unitrigger, var_func_unitrigger_logic);
	return;
	ERROR: Exception occured: Stack empty.
}

/*
	Name: function_unitrigger_logic
	Namespace: namespace_5e1f56dc
	Checksum: 0x424F4353
	Offset: 0xE048
	Size: 0xA8
	Parameters: 0
	Flags: None
	Line Number: 3986
*/
function function_unitrigger_logic()
{
	self endon("hash_death");
	while(1)
	{
		self waittill("hash_trigger", var_player);
		if(var_player namespace_zm_utility::function_in_revive_trigger())
		{
			continue;
		}
		if(var_player.var_IS_DRINKING > 0)
		{
			continue;
		}
		if(!namespace_zm_utility::function_is_player_valid(var_player))
		{
			continue;
		}
		self.var_stub.var_related_parent notify("hash_trigger_activated", var_player);
	}
}

/*
	Name: function_ff00213
	Namespace: namespace_5e1f56dc
	Checksum: 0x424F4353
	Offset: 0xE0F8
	Size: 0x2E0
	Parameters: 1
	Flags: None
	Line Number: 4018
*/
function function_ff00213(var_fadetime)
{
	if(function_ToLower(function_GetDvarString("mapname")) != "zm_castle")
	{
		self namespace_clientfield::function_set("weapon_drop_enable_keyline", 1);
		self namespace_clientfield::function_set("weapon_drop_unpacked_fx", 1);
	}
	else
	{
		self namespace_clientfield::function_set("weapon_drop_enable_keyline", 1);
	}
	wait(0.3);
	self thread function_e1859039();
	self.var_trigger_use = function_spawn("trigger_radius_use", self.var_origin - VectorScale((0, 0, -1), 8), 0, 100, 20);
	self.var_trigger_use function_TriggerIgnoreTeam();
	self.var_trigger_use function_SetVisibleToAll();
	self.var_trigger_use function_SetTeamForTrigger("none");
	self.var_trigger_use function_UseTriggerRequireLookAt();
	self.var_trigger_use function_setcursorhint("HINT_NOICON");
	self.var_trigger_use function_setHintString(&"ZM_MINECRAFT_AMMO_DROP_PROMPT");
	self.var_ba5e26d7 = function_spawn("trigger_radius", self.var_origin, 0, 14, 14);
	self.var_ba5e26d7 function_TriggerIgnoreTeam();
	self.var_ba5e26d7 function_SetVisibleToAll();
	self.var_ba5e26d7 function_SetTeamForTrigger("none");
	self.var_ba5e26d7 function_setcursorhint("HINT_NOICON");
	self.var_ba5e26d7 function_setHintString(&"ZM_MINECRAFT_AMMO_DROP_PROMPT");
	if(isdefined(var_fadetime))
	{
		self thread function_2aa7612d(var_fadetime);
	}
	self thread function_8fedabe9();
	self thread function_c71d30f1();
	self thread function_d02b4a40();
}

/*
	Name: function_e1859039
	Namespace: namespace_5e1f56dc
	Checksum: 0x424F4353
	Offset: 0xE3E0
	Size: 0x120
	Parameters: 5
	Flags: None
	Line Number: 4063
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
	self function_Bobbing((0, 0, 1), var_466503ff, function_randomIntRange(var_278b47c3, var_aa7689cd));
	while(isdefined(self))
	{
		var_ec3f8524 = function_randomIntRange(var_df20f103, var_620c330d);
		self function_RotateYaw(360, var_ec3f8524);
		wait(var_ec3f8524);
	}
	return;
	ERROR: Exception occured: Stack empty.
}

/*
	Name: function_d02b4a40
	Namespace: namespace_5e1f56dc
	Checksum: 0x424F4353
	Offset: 0xE508
	Size: 0x90
	Parameters: 0
	Flags: None
	Line Number: 4107
*/
function function_d02b4a40()
{
	self endon("hash_death");
	while(1)
	{
		self.var_trigger_use waittill("hash_trigger", var_player);
		if(!namespace_zm_utility::function_is_player_valid(var_player) || var_player namespace_laststand::function_player_is_in_laststand())
		{
			continue;
		}
		self thread function_ammo_pickup(var_player);
		break;
	}
}

/*
	Name: function_c71d30f1
	Namespace: namespace_5e1f56dc
	Checksum: 0x424F4353
	Offset: 0xE5A0
	Size: 0x88
	Parameters: 0
	Flags: None
	Line Number: 4132
*/
function function_c71d30f1()
{
	self endon("hash_death");
	while(1)
	{
		self.var_ba5e26d7 waittill("hash_trigger", var_player);
		if(!namespace_zm_utility::function_is_player_valid(var_player) || var_player namespace_laststand::function_player_is_in_laststand())
		{
			continue;
		}
		self thread function_ammo_pickup(var_player);
	}
}

/*
	Name: function_ammo_pickup
	Namespace: namespace_5e1f56dc
	Checksum: 0x424F4353
	Offset: 0xE630
	Size: 0x3E0
	Parameters: 1
	Flags: None
	Line Number: 4156
*/
function function_ammo_pickup(var_player)
{
	var_current_weapon = var_player function_GetCurrentWeapon();
	var_current_weapon = var_player function_GetBuildKitWeapon(var_current_weapon, 0);
	if(var_current_weapon.var_isRiotShield && (var_current_weapon == level.var_zombie_powerup_weapon["minigun"] || namespace_zm_utility::function_is_hero_weapon(var_current_weapon) || var_current_weapon.var_name == "none" || var_current_weapon.var_name == "zombie_bgb_grab" || var_current_weapon.var_name == "zombie_bgb_use" || var_current_weapon.var_name == "zombie_beast_grapple_dwr" || var_current_weapon.var_name == "staff_revive"))
	{
		return;
	}
	if(!(isdefined(var_player function_f85156b0(var_current_weapon)) && var_player function_f85156b0(var_current_weapon)))
	{
		return;
	}
	self notify("hash_690bf263");
	var_97dd65ed = var_current_weapon function_38dd02ea(var_player);
	if(var_player.var_f4d01b67["pickup_ui"] == 0)
	{
		var_player thread namespace_97ac1184::function_8c165b4d("Data", "PickupUI", "+" + var_97dd65ed + " Ammo,zmu_ui_pickup_ammo", 1, 1);
	}
	wait(0.05);
	if(isdefined(var_current_weapon function_25b21deb()) && var_current_weapon function_25b21deb())
	{
		var_player function_SetWeaponAmmoClip(var_current_weapon, var_current_weapon.var_clipSize + var_97dd65ed);
	}
	else if(var_player function_hasPerk("specialty_extraammo"))
	{
		if(var_player function_getammocount(var_current_weapon) + var_97dd65ed > var_current_weapon.var_maxAmmo)
		{
			var_player function_SetWeaponAmmoStock(var_current_weapon, var_current_weapon.var_maxAmmo);
		}
		else
		{
			var_player function_SetWeaponAmmoStock(var_current_weapon, var_player function_getammocount(var_current_weapon) + var_97dd65ed);
		}
	}
	else if(var_player function_getammocount(var_current_weapon) + var_97dd65ed > var_current_weapon.var_startammo)
	{
		var_player function_SetWeaponAmmoStock(var_current_weapon, var_current_weapon.var_startammo);
	}
	else
	{
		var_player function_SetWeaponAmmoStock(var_current_weapon, var_player function_getammocount(var_current_weapon) + var_97dd65ed);
	}
	var_player function_playsoundtoplayer("iw8_ammo_pickup", var_player);
}

/*
	Name: function_25b21deb
	Namespace: namespace_5e1f56dc
	Checksum: 0x424F4353
	Offset: 0xEA18
	Size: 0x98
	Parameters: 0
	Flags: None
	Line Number: 4211
*/
function function_25b21deb()
{
	switch(self.var_name)
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
	Offset: 0xEAB8
	Size: 0x110
	Parameters: 1
	Flags: Private
	Line Number: 4249
*/
function private function_f85156b0(var_current_weapon)
{
	if(self namespace_laststand::function_player_is_in_laststand() || (isdefined(self.var_intermission) && self.var_intermission) || self function_IsThrowingGrenade())
	{
		return 0;
	}
	if(!namespace_zm_utility::function_is_player_valid(self) || self.var_IS_DRINKING > 0 || namespace_zm_utility::function_is_placeable_mine(var_current_weapon) || namespace_zm_equipment::function_is_equipment(var_current_weapon) || self namespace_zm_utility::function_is_player_revive_tool(var_current_weapon) || level.var_weaponNone == var_current_weapon || self namespace_zm_equipment::function_hacker_active() || namespace_zm_utility::function_is_hero_weapon(var_current_weapon))
	{
		return 0;
	}
	return 1;
}

/*
	Name: function_38dd02ea
	Namespace: namespace_5e1f56dc
	Checksum: 0x424F4353
	Offset: 0xEBD0
	Size: 0x8D0
	Parameters: 1
	Flags: None
	Line Number: 4272
*/
function function_38dd02ea(var_player)
{
	if(self.var_rootweapon.var_name == "ray_gun" || self.var_rootweapon.var_name == "raygun_mark2" || self.var_rootweapon.var_name == "raygun_mark3" || self.var_rootweapon.var_name == "t9_gallo_raygun")
	{
		return 4;
	}
	else if(self.var_rootweapon.var_name == "ray_gun_up" || self.var_rootweapon.var_name == "raygun_mark2_up" || self.var_rootweapon.var_name == "ray_gun_upgraded" || self.var_rootweapon.var_name == "raygun_mark2_upgraded" || self.var_rootweapon.var_name == "raygun_mark3_up" || self.var_rootweapon.var_name == "raygun_mark3_upgraded" || self.var_rootweapon.var_name == "t9_gallo_raygun_up")
	{
		return 6;
	}
	if(self.var_rootweapon.var_name == "thundergun" || self.var_rootweapon.var_name == "idgun_0" || self.var_rootweapon.var_name == "idgun_1" || self.var_rootweapon.var_name == "idgun_2" || self.var_rootweapon.var_name == "idgun_3" || self.var_rootweapon.var_name == "idgun_upgraded_0" || self.var_rootweapon.var_name == "idgun_upgraded_1" || self.var_rootweapon.var_name == "idgun_upgraded_2" || self.var_rootweapon.var_name == "idgun_upgraded_3" || self.var_rootweapon.var_name == "t7_idgun_genesis_0" || self.var_rootweapon.var_name == "t7_idgun_genesis_0_upgraded" || self.var_rootweapon.var_name == "shrink_ray" || self.var_rootweapon.var_name == "madgaz_cng_zm" || self.var_rootweapon.var_name == "madgaz_cng2_zm" || self.var_rootweapon.var_name == "madgaz_cng3_zm" || self.var_rootweapon.var_name == "tesla_gun" || self.var_rootweapon.var_name == "t9_crossbow_skull_up" || self.var_rootweapon.var_name == "idgun_genesis_0" || self.var_rootweapon.var_name == "idgun_genesis_0_upgraded")
	{
		return 1;
	}
	else if(self.var_rootweapon.var_name == "thundergun_upgraded" || self.var_rootweapon.var_name == "shrink_ray_upgraded" || self.var_rootweapon.var_name == "madgaz_cng_upgraded_zm" || self.var_rootweapon.var_name == "madgaz_cng2_upgraded_zm" || self.var_rootweapon.var_name == "madgaz_cng3_upgraded_zm" || self.var_rootweapon.var_name == "tesla_gun_upgraded" || self.var_rootweapon.var_name == "t9_crossbow_skull")
	{
		return 2;
	}
	if(self.var_rootweapon.var_name == "t6_xl_slipgun" || self.var_rootweapon.var_name == "t7_staff_air" || self.var_rootweapon.var_name == "t7_staff_fire" || self.var_rootweapon.var_name == "t7_staff_lightning" || self.var_rootweapon.var_name == "t7_staff_water" || self.var_rootweapon.var_name == "t7_hero_mirg2000" || self.var_rootweapon.var_name == "hero_mirg2000" || self.var_rootweapon.var_name == "t8_shotgun_blundergat" || self.var_rootweapon.var_name == "t8_shotgun_acidgat" || self.var_rootweapon.var_name == "t8_shotgun_magmagat" || self.var_rootweapon.var_name == "t8_zombie_tomahawk" || self.var_rootweapon.var_name == "t8_zombie_tomahawk" || self.var_rootweapon.var_name == "t7_shrink_ray" || self.var_name == "elemental_bow" || self.var_rootweapon.var_name == "t7_microwavegundw" || self.var_rootweapon.var_name == "microwavegundw")
	{
		return 2;
	}
	else if(self.var_rootweapon.var_name == "t6_xl_slipgun_up" || self.var_rootweapon.var_name == "t7_staff_air_upgraded" || self.var_rootweapon.var_name == "t7_staff_fire_upgraded" || self.var_rootweapon.var_name == "t7_staff_lightning_upgraded" || self.var_rootweapon.var_name == "t7_staff_water_upgraded" || self.var_rootweapon.var_name == "t7_hero_mirg2000_upgraded" || self.var_rootweapon.var_name == "hero_mirg2000_upgraded" || self.var_rootweapon.var_name == "t8_shotgun_blundergat_upgraded" || self.var_rootweapon.var_name == "t8_shotgun_acidgat_upgraded" || self.var_rootweapon.var_name == "t8_shotgun_magmagat_upgraded" || self.var_rootweapon.var_name == "t8_zombie_tomahawk_upgraded" || self.var_rootweapon.var_name == "t7_shrink_ray_upgraded" || self.var_name == "elemental_bow_rune_prison" || self.var_name == "elemental_bow_storm" || self.var_name == "elemental_bow_wolf_howl" || self.var_name == "elemental_bow_demongate" || self.var_rootweapon.var_name == "t7_microwavegundw_upgraded" || self.var_rootweapon.var_name == "microwavegundw_upgraded")
	{
		return 3;
	}
	if(self.var_weapClass == "shotgun")
	{
		return 4;
	}
	else if(self.var_weapClass == "rifle")
	{
		return 16;
	}
	else if(self.var_weapClass == "pistol")
	{
		return 8;
	}
	else if(self.var_weapClass == "lmg")
	{
		return 24;
	}
	else if(self.var_weapClass == "launcher")
	{
		return 1;
	}
	else if(self.var_weapClass == "smg")
	{
		return 12;
	}
	if(var_player function_GetWeaponAmmoClip(self) > 32)
	{
		return 20;
	}
	else
	{
		return 8;
	}
}

/*
	Name: function_8fedabe9
	Namespace: namespace_5e1f56dc
	Checksum: 0x424F4353
	Offset: 0xF4A8
	Size: 0x78
	Parameters: 0
	Flags: None
	Line Number: 4342
*/
function function_8fedabe9()
{
	self waittill("hash_690bf263");
	if(isdefined(self.var_trigger_use))
	{
		self.var_trigger_use function_delete();
	}
	if(isdefined(self.var_ba5e26d7))
	{
		self.var_ba5e26d7 function_delete();
	}
	self function_delete();
	return;
}

/*
	Name: function_2aa7612d
	Namespace: namespace_5e1f56dc
	Checksum: 0x424F4353
	Offset: 0xF528
	Size: 0xE0
	Parameters: 1
	Flags: None
	Line Number: 4367
*/
function function_2aa7612d(var_fadetime)
{
	self endon("hash_690bf263");
	self endon("hash_death");
	wait(var_fadetime);
	for(var_i = 0; var_i < 40; var_i++)
	{
		if(var_i % 2)
		{
			self function_Hide();
		}
		else
		{
			self function_show();
		}
		if(var_i < 15)
		{
			wait(0.5);
			continue;
		}
		if(var_i < 25)
		{
			wait(0.25);
			continue;
		}
		wait(0.1);
	}
	self notify("hash_690bf263");
}

/*
	Name: function_c5f97490
	Namespace: namespace_5e1f56dc
	Checksum: 0x424F4353
	Offset: 0xF610
	Size: 0xD8
	Parameters: 1
	Flags: Private
	Line Number: 4407
*/
function private function_c5f97490(var_34d37a48)
{
	function_8b57c052("saveweaponskill", "");
	for(;;)
	{
		wait(0.05);
		var_dvar_value = function_ToLower(function_GetDvarString("saveweaponskill", ""));
		if(isdefined(var_dvar_value) && var_dvar_value != "")
		{
			function_8b57c052("saveweaponskill", "");
			function_GetPlayers()[0] thread function_7677f493();
		}
	}
}

/*
	Name: function_e8603e7
	Namespace: namespace_5e1f56dc
	Checksum: 0x424F4353
	Offset: 0xF6F0
	Size: 0xD8
	Parameters: 1
	Flags: Private
	Line Number: 4432
*/
function private function_e8603e7(var_34d37a48)
{
	function_8b57c052("getweaponskill", "");
	for(;;)
	{
		wait(0.05);
		var_dvar_value = function_ToLower(function_GetDvarString("getweaponskill", ""));
		if(isdefined(var_dvar_value) && var_dvar_value != "")
		{
			function_8b57c052("getweaponskill", "");
			function_GetPlayers()[0] thread function_f11f718a();
		}
	}
}

/*
	Name: function_516e13aa
	Namespace: namespace_5e1f56dc
	Checksum: 0x424F4353
	Offset: 0xF7D0
	Size: 0x110
	Parameters: 1
	Flags: Private
	Line Number: 4457
*/
function private function_516e13aa(var_34d37a48)
{
	function_8b57c052("spawn_pack", "");
	for(;;)
	{
		wait(0.05);
		var_dvar_value = function_ToLower(function_GetDvarString("spawn_pack", ""));
		if(isdefined(var_dvar_value) && var_dvar_value != "")
		{
			function_8b57c052("spawn_pack", "");
			level thread function_475b7b66(level.var_players[0].var_origin, level.var_players[0].var_angles + VectorScale((0, 1, 0), 90), 1, 0, "original");
		}
	}
}

/*
	Name: function_10363972
	Namespace: namespace_5e1f56dc
	Checksum: 0x424F4353
	Offset: 0xF8E8
	Size: 0x198
	Parameters: 1
	Flags: Private
	Line Number: 4482
*/
function private function_10363972(var_34d37a48)
{
	function_8b57c052("spawn_ammo", "");
	for(;;)
	{
		wait(0.05);
		var_dvar_value = function_ToLower(function_GetDvarString("spawn_ammo", ""));
		if(isdefined(var_dvar_value) && var_dvar_value != "")
		{
			function_8b57c052("spawn_ammo", "");
			var_bcce182e = namespace_util::function_spawn_model("zmu_ammo_pack", function_GetPlayers()[0].var_origin, function_GetPlayers()[0].var_angles);
			var_final_pos = function_GetPlayers()[0] namespace_ecdf5e21::function_a2b97522(undefined, 50, var_bcce182e, 1);
			var_bcce182e namespace_ecdf5e21::function_a170d6f0(var_final_pos, 15);
			var_bcce182e thread function_ff00213(20);
		}
	}
}

/*
	Name: function_c3bfd518
	Namespace: namespace_5e1f56dc
	Checksum: 0x424F4353
	Offset: 0xFA88
	Size: 0xA0
	Parameters: 1
	Flags: Private
	Line Number: 4510
*/
function private function_c3bfd518(var_34d37a48)
{
	function_8b57c052("weapon_damage", 0);
	for(;;)
	{
		wait(0.05);
		var_dvar_value = function_ToLower(function_GetDvarInt("weapon_damage", 0));
		if(isdefined(var_dvar_value) && var_dvar_value != "none")
		{
			function_8b57c052("weapon_damage", 0);
		}
	}
}

/*
	Name: function_5a6cb9bd
	Namespace: namespace_5e1f56dc
	Checksum: 0x424F4353
	Offset: 0xFB30
	Size: 0x280
	Parameters: 1
	Flags: Private
	Line Number: 4534
*/
function private function_5a6cb9bd(var_34d37a48)
{
	function_8b57c052("upgrade_weapon_special", "none");
	for(;;)
	{
		wait(0.05);
		var_dvar_value = function_ToLower(function_GetDvarString("upgrade_weapon_special", "none"));
		if(isdefined(var_dvar_value) && var_dvar_value != "none")
		{
			function_8b57c052("upgrade_weapon_special", "none");
			if(var_dvar_value == "")
			{
				foreach(var_player in function_GetPlayers())
				{
					var_player function_9c955ddd();
				}
			}
			var_cde9f622 = function_StrTok(var_dvar_value, " ");
			if(var_cde9f622.size > 1)
			{
				var_player_index = function_Int(var_cde9f622[0]);
				var_value = function_Int(var_cde9f622[1]);
				if(var_player_index >= 0 && var_player_index <= 7)
				{
					level.var_players[var_player_index] function_9c955ddd();
				}
				else
				{
					namespace_Array::function_thread_all(function_GetPlayers(), &function_9c955ddd);
				}
			}
			else
			{
				namespace_Array::function_thread_all(function_GetPlayers(), &function_9c955ddd);
			}
		}
	}
}

/*
	Name: function_c41abcf0
	Namespace: namespace_5e1f56dc
	Checksum: 0x424F4353
	Offset: 0xFDB8
	Size: 0x3B0
	Parameters: 1
	Flags: Private
	Line Number: 4583
*/
function private function_c41abcf0(var_34d37a48)
{
	function_8b57c052("update_w_kills", 0);
	for(;;)
	{
		wait(0.05);
		var_dvar_value = function_GetDvarInt("update_w_kills", 0);
		if(isdefined(var_dvar_value) && var_dvar_value != 0)
		{
			function_8b57c052("update_w_kills", 0);
			var_480fed80 = function_GetPlayers()[0] function_1c1990e8(function_GetPlayers()[0] function_GetCurrentWeapon());
			if(isdefined(var_480fed80) && var_480fed80.var_4c25c2f2 < 21)
			{
				var_480fed80.var_79fe8f18 = var_480fed80.var_79fe8f18 + var_dvar_value;
				function_GetPlayers()[0] function_LUINotifyEvent(&"spx_gun_level", 2, function_Int(var_480fed80.var_79fe8f18), function_Int(level.var_ce9bfb71[var_480fed80.var_4c25c2f2]));
				function_IPrintLnBold("repack_xp: " + var_480fed80.var_79fe8f18 + " of " + level.var_ce9bfb71[var_480fed80.var_4c25c2f2]);
				if(var_480fed80.var_79fe8f18 >= level.var_ce9bfb71[var_480fed80.var_4c25c2f2])
				{
					var_480fed80.var_4c25c2f2 = var_480fed80.var_4c25c2f2 + 1;
					var_480fed80.var_79fe8f18 = 0;
					var_480fed80.var_pap_camo_to_use = level.var_1e656cc4[var_480fed80.var_4c25c2f2];
					function_GetPlayers()[0] function_c8540b60(self.var_damageWeapon, function_GetPlayers()[0] function_CalcWeaponOptions(level.var_1e656cc4[var_480fed80.var_4c25c2f2], 0, 0));
					function_GetPlayers()[0] function_LUINotifyEvent(&"spx_camo_notification", 1, function_Int(var_480fed80.var_4c25c2f2));
					function_GetPlayers()[0] thread function_e5bef058(var_480fed80.var_4c25c2f2);
				}
				function_GetPlayers()[0] thread function_7e18304e(var_480fed80.var_stored_weapon.var_rootweapon.var_name, var_480fed80.var_4c25c2f2, var_480fed80.var_79fe8f18);
			}
		}
	}
}

/*
	Name: function_pack_a_punch_machine_trigger_think
	Namespace: namespace_5e1f56dc
	Checksum: 0x424F4353
	Offset: 0x10170
	Size: 0x148
	Parameters: 0
	Flags: Private
	Line Number: 4624
*/
function private function_pack_a_punch_machine_trigger_think()
{
	self endon("hash_death");
	self endon("hash_Pack_A_Punch_off");
	self notify("hash_pack_a_punch_trigger_think");
	self endon("hash_pack_a_punch_trigger_think");
	while(1)
	{
		var_players = function_GetPlayers();
		for(var_i = 0; var_i < var_players.size; var_i++)
		{
			if(isdefined(self.var_pack_player) && self.var_pack_player != var_players[var_i] || !var_players[var_i] function_player_use_can_pack_now() || var_players[var_i] namespace_bgb::function_is_active("zm_bgb_ephemeral_enhancement"))
			{
				self function_SetInvisibleToPlayer(var_players[var_i], 1);
				continue;
			}
			self function_SetInvisibleToPlayer(var_players[var_i], 0);
		}
		wait(0.1);
	}
}

/*
	Name: function_shutOffPAPSounds
	Namespace: namespace_5e1f56dc
	Checksum: 0x424F4353
	Offset: 0x102C0
	Size: 0xB0
	Parameters: 3
	Flags: Private
	Line Number: 4656
*/
function private function_shutOffPAPSounds(var_ent1, var_ent2, var_ent3)
{
	while(1)
	{
		level waittill("hash_Pack_A_Punch_off");
		level thread function_turnOnPAPSounds(var_ent1);
		var_ent1 function_StopLoopSound(0.1);
		var_ent2 function_StopLoopSound(0.1);
		var_ent3 function_StopLoopSound(0.1);
	}
}

/*
	Name: function_turnOnPAPSounds
	Namespace: namespace_5e1f56dc
	Checksum: 0x424F4353
	Offset: 0x10378
	Size: 0x38
	Parameters: 1
	Flags: Private
	Line Number: 4678
*/
function private function_turnOnPAPSounds(var_ent)
{
	level waittill("hash_Pack_A_Punch_on");
	var_ent function_PlayLoopSound("zmb_perks_packa_loop");
	return;
}

/*
	Name: function_destroy_weapon_in_blackout
	Namespace: namespace_5e1f56dc
	Checksum: 0x424F4353
	Offset: 0x103B8
	Size: 0xA8
	Parameters: 1
	Flags: Private
	Line Number: 4695
*/
function private function_destroy_weapon_in_blackout(var_player)
{
	self endon("hash_pap_timeout");
	self endon("hash_pap_taken");
	self endon("hash_pap_player_disconnected");
	level waittill("hash_Pack_A_Punch_off");
	self.var_zbarrier function_set_pap_zbarrier_state("take_gun");
	var_player function_playlocalsound(level.var_zmb_laugh_alias);
	wait(1.5);
	self.var_zbarrier function_set_pap_zbarrier_state("power_off");
}

/*
	Name: function_do_knuckle_crack
	Namespace: namespace_5e1f56dc
	Checksum: 0x424F4353
	Offset: 0x10468
	Size: 0x78
	Parameters: 0
	Flags: Private
	Line Number: 4717
*/
function private function_do_knuckle_crack()
{
	self endon("hash_disconnect");
	self function_upgrade_knuckle_crack_begin();
	self namespace_util::function_waittill_any("fake_death", "death", "player_downed", "weapon_change_complete");
	self function_upgrade_knuckle_crack_end();
}

/*
	Name: function_upgrade_knuckle_crack_begin
	Namespace: namespace_5e1f56dc
	Checksum: 0x424F4353
	Offset: 0x104E8
	Size: 0x140
	Parameters: 0
	Flags: Private
	Line Number: 4735
*/
function private function_upgrade_knuckle_crack_begin()
{
	self namespace_zm_utility::function_increment_is_drinking();
	self namespace_zm_utility::function_disable_player_move_states(1);
	var_Primaries = self function_GetWeaponsListPrimaries();
	var_original_weapon = self function_GetCurrentWeapon();
	var_weapon = function_GetWeapon("zombie_knuckle_crack");
	if(var_original_weapon != level.var_weaponNone && !namespace_zm_utility::function_is_placeable_mine(var_original_weapon) && !namespace_zm_equipment::function_is_equipment(var_original_weapon))
	{
		self notify("hash_zmb_lost_knife");
		self function_TakeWeapon(var_original_weapon);
		return;
	}
	else
	{
	}
	self function_GiveWeapon(var_weapon);
	self function_SwitchToWeapon(var_weapon);
}

/*
	Name: function_upgrade_knuckle_crack_end
	Namespace: namespace_5e1f56dc
	Checksum: 0x424F4353
	Offset: 0x10630
	Size: 0x108
	Parameters: 0
	Flags: Private
	Line Number: 4765
*/
function private function_upgrade_knuckle_crack_end()
{
	self namespace_zm_utility::function_enable_player_move_states();
	var_weapon = function_GetWeapon("zombie_knuckle_crack");
	if(self namespace_laststand::function_player_is_in_laststand() || (isdefined(self.var_intermission) && self.var_intermission))
	{
		self function_TakeWeapon(var_weapon);
		return;
	}
	self namespace_zm_utility::function_decrement_is_drinking();
	self function_TakeWeapon(var_weapon);
	var_Primaries = self function_GetWeaponsListPrimaries();
	if(self.var_IS_DRINKING > 0)
	{
		return;
	}
	else
	{
		self namespace_zm_weapons::function_switch_back_primary_weapon();
	}
}

/*
	Name: function_third_person_weapon_upgrade
	Namespace: namespace_5e1f56dc
	Checksum: 0x424F4353
	Offset: 0x10740
	Size: 0x4E8
	Parameters: 5
	Flags: Private
	Line Number: 4797
*/
function private function_third_person_weapon_upgrade(var_current_weapon, var_upgrade_weapon, var_packa_rollers, var_pap_machine, var_trigger)
{
	level endon("hash_Pack_A_Punch_off");
	var_trigger endon("hash_pap_player_disconnected");
	var_current_weapon = self function_GetBuildKitWeapon(var_current_weapon, 0);
	var_upgrade_weapon = self function_GetBuildKitWeapon(var_upgrade_weapon, 1);
	var_trigger.var_7750a3aa = self function_1239e0ad(var_current_weapon);
	var_trigger.var_current_weapon = var_current_weapon;
	var_trigger.var_current_weapon_options = self function_GetBuildKitWeaponOptions(var_trigger.var_current_weapon);
	var_trigger.var_current_weapon_acvi = self function_GetBuildKitAttachmentCosmeticVariantIndexes(var_trigger.var_current_weapon, 0);
	var_trigger.var_upgrade_weapon = var_upgrade_weapon;
	var_upgrade_weapon.var_pap_camo_to_use = namespace_zm_weapons::function_get_pack_a_punch_camo_index(var_upgrade_weapon.var_pap_camo_to_use);
	var_trigger.var_upgrade_weapon_options = self function_GetBuildKitWeaponOptions(var_trigger.var_upgrade_weapon, var_upgrade_weapon.var_pap_camo_to_use);
	var_trigger.var_upgrade_weapon_acvi = self function_GetBuildKitAttachmentCosmeticVariantIndexes(var_trigger.var_upgrade_weapon, 1);
	var_trigger.var_zbarrier function_setWeapon(var_trigger.var_current_weapon);
	var_trigger.var_zbarrier function_SetWeaponOptions(var_trigger.var_current_weapon_options);
	var_trigger.var_zbarrier function_SetAttachmentCosmeticVariantIndexes(var_trigger.var_current_weapon_acvi);
	var_trigger.var_zbarrier function_set_pap_zbarrier_state("take_gun");
	var_rel_entity = var_trigger.var_pap_machine;
	var_origin_offset = (0, 0, 0);
	var_angles_offset = (0, 0, 0);
	var_origin_base = self.var_origin;
	var_angles_base = self.var_angles;
	if(isdefined(var_rel_entity))
	{
		var_origin_offset = (0, 0, level.var_pack_a_punch.var_interaction_height);
		var_angles_offset = VectorScale((0, 1, 0), 90);
		var_origin_base = var_rel_entity.var_origin;
		var_angles_base = var_rel_entity.var_angles;
	}
	else
	{
		var_rel_entity = self;
	}
	var_FORWARD = function_AnglesToForward(var_angles_base + var_angles_offset);
	var_interact_offset = var_origin_offset + var_FORWARD * -25;
	var_offsetdw = VectorScale((1, 1, 1), 3);
	var_pap_machine [[level.var_pack_a_punch.var_move_in_func]](self, var_trigger, var_origin_offset, var_angles_offset);
	self function_playsound("zmb_perks_packa_upgrade");
	wait(0.35);
	wait(3);
	var_trigger.var_zbarrier function_setWeapon(var_upgrade_weapon);
	var_trigger.var_zbarrier function_SetWeaponOptions(var_trigger.var_upgrade_weapon_options);
	var_trigger.var_zbarrier function_SetAttachmentCosmeticVariantIndexes(var_trigger.var_upgrade_weapon_acvi);
	var_trigger.var_zbarrier function_set_pap_zbarrier_state("eject_gun");
	if(isdefined(self))
	{
		self function_playsound("zmb_perks_packa_ready");
		return;
	}
	else
	{
	}
	var_rel_entity thread [[level.var_pack_a_punch.var_move_out_func]](self, var_trigger, var_origin_offset, var_interact_offset);
	return;
	ERROR: Exception occured: Stack empty.
}

/*
	Name: function_wait_for_player_to_take
	Namespace: namespace_5e1f56dc
	Checksum: 0x424F4353
	Offset: 0x10C30
	Size: 0xA28
	Parameters: 5
	Flags: Private
	Line Number: 4865
*/
function private function_wait_for_player_to_take(var_player, var_weapon, var_packa_timer, var_b_weapon_supports_aat, var_isRepack)
{
	var_current_weapon = self.var_current_weapon;
	var_12030910 = self.var_upgrade_weapon;
	/#
		namespace_::function_Assert(isdefined(var_current_weapon), "Dev Block strings are not supported");
	#/
	/#
		namespace_::function_Assert(isdefined(var_12030910), "Dev Block strings are not supported");
	#/
	self endon("hash_pap_timeout");
	level endon("hash_Pack_A_Punch_off");
	while(isdefined(var_player))
	{
		var_packa_timer function_PlayLoopSound("zmb_perks_packa_ticktock");
		self waittill("hash_trigger_activated", var_trigger_player);
		if(level.var_pack_a_punch.var_grabbable_by_anyone)
		{
			var_player = var_trigger_player;
		}
		var_packa_timer function_StopLoopSound(0.05);
		if(var_trigger_player == var_player)
		{
			var_current_weapon = var_player function_GetCurrentWeapon();
			if(namespace_zm_utility::function_is_player_valid(var_player) && !var_player.var_IS_DRINKING > 0 && !namespace_zm_utility::function_is_placeable_mine(var_current_weapon) && !namespace_zm_equipment::function_is_equipment(var_current_weapon) && !var_player namespace_zm_utility::function_is_player_revive_tool(var_current_weapon) && level.var_weaponNone != var_current_weapon && !var_player namespace_zm_equipment::function_hacker_active())
			{
				namespace_demo::function_bookmark("zm_player_grabbed_packapunch", GetTime(), var_player);
				self notify("hash_pap_taken");
				var_player notify("hash_pap_taken");
				var_player.var_pap_used = 1;
				var_weapon_limit = namespace_zm_utility::function_get_player_weapon_limit(var_player);
				var_player namespace_zm_weapons::function_take_fallback_weapon();
				if(isdefined(self.var_7750a3aa))
				{
					var_7750a3aa = self.var_7750a3aa;
				}
				else
				{
					var_7750a3aa = var_player function_1239e0ad(var_12030910);
				}
				var_player function_GiveWeapon(var_12030910, var_player namespace_zm_weapons::function_get_pack_a_punch_weapon_options(var_12030910));
				var_player function_SwitchToWeapon(var_12030910);
				var_ed5e1bff = var_player function_e942fd68(var_12030910);
				if(isdefined(var_7750a3aa))
				{
					if(isdefined(var_7750a3aa.var_a39a2843) && var_7750a3aa.var_a39a2843 < level.var_7ceb1b41)
					{
						var_7750a3aa.var_a39a2843 = var_7750a3aa.var_a39a2843 + 1;
						if(var_player.var_pers["highest_enchantment"] > var_7750a3aa.var_a39a2843)
						{
						}
						else
						{
							var_player.var_pers["highest_enchantment"] = var_7750a3aa.var_a39a2843;
							var_player thread namespace_97ac1184::function_7e18304e("spx_save_data", "highest_enchantment", var_player.var_pers["highest_enchantment"], 0);
						}
						if(var_7750a3aa.var_a39a2843 > var_player.var_ddbf6bf2)
						{
							var_player.var_ddbf6bf2++;
							var_player notify("hash_79ef118b", "milestone_completed_enchantment_" + var_7750a3aa.var_a39a2843, undefined);
						}
						wait(0.05);
						if(level.var_fcee636 == "motd")
						{
							var_player notify("hash_63cf7d21", "map0_motd_pack_a_punched", 1, 1, 75000, 10);
							wait(0.05);
							if(var_player.var_pers["map0_motd_pack_a_punched"] >= 1)
							{
								var_player notify("hash_63cf7d21", "map0_motd_pack_a_punched_multiple", 1, 25, 135000, 250, "motd_camo_0");
								wait(0.05);
								if(var_player.var_pers["map0_motd_pack_a_punched_multiple"] >= 25)
								{
									var_player notify("hash_63cf7d21", "map0_motd_pack_a_punched_multiple_2", 1, 125, 235000, 1000, "motd_camo_1");
									wait(0.05);
								}
							}
						}
						var_player thread namespace_97ac1184::function_b3489bf5("^3" + var_player.var_playerName + "^7 Pack-a-Punched to ^9" + var_7750a3aa function_3ce97289() + " ^7on " + function_MakeLocalizedString(var_7750a3aa.var_stored_weapon.var_displayName));
						var_player function_febfc6ba(var_current_weapon);
					}
				}
				else if(!(isdefined(var_ed5e1bff) && var_ed5e1bff))
				{
					if(isdefined(var_player function_c3370d47(var_12030910)) && var_player function_c3370d47(var_12030910))
					{
						var_de6974d4 = function_spawnstruct();
						var_de6974d4.var_stored_weapon = var_12030910.var_rootweapon;
						var_de6974d4.var_79fe8f18 = 0;
						var_de6974d4.var_4c25c2f2 = 0;
						var_de6974d4.var_pap_camo_to_use = level.var_1e656cc4[var_de6974d4.var_4c25c2f2];
						var_player.var_3818be12[var_player.var_3818be12.size] = var_de6974d4;
					}
				}
				if(!(isdefined(var_7750a3aa) && var_7750a3aa))
				{
					var_d2433c1d = function_spawnstruct();
					var_d2433c1d.var_stored_weapon = var_12030910.var_rootweapon;
					var_a76169e6 = function_49e2047b();
					var_d2433c1d.var_a39a2843 = var_a76169e6;
					var_player.var_fb56a719[var_player.var_fb56a719.size] = var_d2433c1d;
				}
				if(var_12030910.var_start_ammo != var_12030910.var_maxAmmo)
				{
					if(var_player function_hasPerk("specialty_extraammo"))
					{
						var_player function_giveMaxAmmo(var_12030910);
					}
					else
					{
						var_player function_GiveStartAmmo(var_12030910);
					}
				}
				else
				{
					var_player function_giveMaxAmmo(var_12030910);
				}
				var_player thread namespace_97ac1184::function_b3489bf5("^3" + var_player.var_playerName + "^7 Pack-a-Punched to ^9" + var_d2433c1d function_3ce97289() + " ^7on " + function_MakeLocalizedString(var_d2433c1d.var_stored_weapon.var_displayName));
				var_player function_GiveStartAmmo(var_12030910);
				var_player notify("hash_weapon_give", var_12030910);
				var_player namespace_zm_weapons::function_play_weapon_vo(var_12030910);
				wait(0.05);
				if(level.var_fcee636 == "motd")
				{
					var_player notify("hash_63cf7d21", "map0_motd_pack_a_punched", 1, 1, 75000, 10);
					wait(0.05);
					if(var_player.var_pers["map0_motd_pack_a_punched"] >= 1)
					{
						var_player notify("hash_63cf7d21", "map0_motd_pack_a_punched_multiple", 1, 25, 135000, 250, "motd_camo_0");
						wait(0.05);
						if(var_player.var_pers["map0_motd_pack_a_punched_multiple"] >= 25)
						{
							var_player notify("hash_63cf7d21", "map0_motd_pack_a_punched_multiple_2", 1, 125, 235000, 1000, "motd_camo_1");
							wait(0.05);
							return;
						}
					}
				}
			}
		}
		wait(0.05);
	}
}

/*
	Name: function_wait_for_timeout
	Namespace: namespace_5e1f56dc
	Checksum: 0x424F4353
	Offset: 0x11660
	Size: 0xA8
	Parameters: 3
	Flags: Private
	Line Number: 5018
*/
function private function_wait_for_timeout(var_weapon, var_packa_timer, var_player)
{
	self endon("hash_pap_taken");
	self endon("hash_pap_player_disconnected");
	self thread function_wait_for_disconnect(var_player);
	wait(level.var_pack_a_punch.var_timeout);
	self notify("hash_pap_timeout");
	var_packa_timer function_StopLoopSound(0.05);
	var_packa_timer function_playsound("zmb_perks_packa_deny");
}

/*
	Name: function_wait_for_disconnect
	Namespace: namespace_5e1f56dc
	Checksum: 0x424F4353
	Offset: 0x11710
	Size: 0x68
	Parameters: 1
	Flags: Private
	Line Number: 5039
*/
function private function_wait_for_disconnect(var_player)
{
	self endon("hash_pap_taken");
	self endon("hash_pap_timeout");
	while(isdefined(var_player))
	{
		wait(0.1);
	}
	/#
		function_println("Dev Block strings are not supported");
	#/
	self notify("hash_pap_player_disconnected");
	return;
	ERROR: Exception occured: Stack empty.
}

/*
	Name: function_set_pap_zbarrier_state
	Namespace: namespace_5e1f56dc
	Checksum: 0x424F4353
	Offset: 0x11780
	Size: 0x80
	Parameters: 1
	Flags: Private
	Line Number: 5065
*/
function private function_set_pap_zbarrier_state(var_State)
{
	for(var_i = 0; var_i < self function_GetNumZBarrierPieces(); var_i++)
	{
		self function_HideZBarrierPiece(var_i);
	}
	self notify("hash_zbarrier_state_change");
	self [[level.var_pap_zbarrier_state_func]](var_State);
}

/*
	Name: function_is_on
	Namespace: namespace_5e1f56dc
	Checksum: 0x424F4353
	Offset: 0x11808
	Size: 0x22
	Parameters: 0
	Flags: Private
	Line Number: 5085
*/
function private function_is_on()
{
	if(isdefined(self.var_powered))
	{
		return self.var_powered.var_power;
	}
	return 0;
}

