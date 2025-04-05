#include scripts\codescripts\struct;
#include scripts\shared\ai\zombie_utility;
#include scripts\shared\animation_shared;
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
#include scripts\sphynx\commands\_zm_commands;
#include scripts\sphynx\equipment\_zm_deployment_station;
#include scripts\sphynx\leveling\_zm_sphynx_leveling;
#include scripts\sphynx\weapons\_zm_weapon_drop_system;
#include scripts\zm\_zm;
#include scripts\zm\_zm_audio;
#include scripts\zm\_zm_bgb;
#include scripts\zm\_zm_equipment;
#include scripts\zm\_zm_laststand;
#include scripts\zm\_zm_magicbox;
#include scripts\zm\_zm_net;
#include scripts\zm\_zm_perks;
#include scripts\zm\_zm_powerups;
#include scripts\zm\_zm_score;
#include scripts\zm\_zm_spawner;
#include scripts\zm\_zm_unitrigger;
#include scripts\zm\_zm_utility;
#include scripts\zm\_zm_weapon_upgrade_system;
#include scripts\zm\_zm_weapons;

#namespace namespace_fdf6e22f;

/*
	Name: function___init__sytem__
	Namespace: namespace_fdf6e22f
	Checksum: 0x424F4353
	Offset: 0x1798
	Size: 0x38
	Parameters: 0
	Flags: AutoExec
	Line Number: 46
*/
function autoexec function___init__sytem__()
{
	namespace_system::function_register("zm_loot_mode", &function___init__, undefined, undefined);
}

/*
	Name: function___init__
	Namespace: namespace_fdf6e22f
	Checksum: 0x424F4353
	Offset: 0x17D8
	Size: 0x540
	Parameters: 0
	Flags: None
	Line Number: 61
*/
function function___init__()
{
	if(function_ToLower(function_GetDvarString("mapname")) != "zm_castle")
	{
		namespace_clientfield::function_register("scriptmover", "loot_crate_fx", 1, function_GetMinBitCountForNum(5), "int");
	}
	level namespace_flag::function_init("loot_mode_active");
	wait(0.05);
	level namespace_flag::function_wait_till("allow_loot_mode");
	level thread function_37e1ab3a();
	namespace_callback::function_on_connect(&function_65e33f30);
	namespace_callback::function_on_spawned(&function_on_player_spawned);
	wait(0.05);
	level namespace_flag::function_wait_till("initial_blackscreen_passed");
	level thread function_2d5500a6();
	level.var_68e89529 = function_Array("pistol_standard", "pistol_burst", "pistol_fullauto");
	level.var_ceb658e7 = function_Array("smg_burst", "smg_capacity", "smg_fastfire", "smg_standard");
	level.var_181fb591 = function_Array("ar_damage", "ar_longburst", "ar_marksman", "ar_standard", "ar_cqb", "ar_accurate", "smg_versatile");
	level.var_45a59029 = function_Array("sniper_fastbolt", "sniper_powerbolt", "sniper_fastsemi");
	level.var_df1b28f2 = function_Array("shotgun_pump", "shotgun_precision", "shotgun_fullauto", "shotgun_energy", "shotgun_semiauto");
	level.var_e0580f08 = function_Array("lmg_cqb", "lmg_light", "lmg_heavy");
	level.var_268306a8 = function_Array("launcher_standard");
	level.var_352bfdec = function_Array("melee_jug", "t9_bat_crockiller", "melee_seasonal_pipe");
	level.var_56ed2a00 = function_Array("ray_gun", "thundergun", "idgun_genesis_0", "microwavegundw", "hero_mirg2000", "tesla_gun", "shrink_ray", "raygun_mark2", "raygun_mark3", "t8_shotgun_magmagat", "madgaz_cng_zm", "madgaz_cng2_zm", "madgaz_cng3_zm", "t6_xl_ray_gun", "t8_shotgun_blundergat", "t8_shotgun_acidgat", "t6_xl_raygun_mark2", "t9_gallo_raygun", "t9_crossbow_skull");
	level.var_db13261d = function_Array();
	foreach(var_weapon in level.var_56ed2a00)
	{
		if(isdefined(level.var_zombie_weapons[function_GetWeapon(var_weapon)]))
		{
			function_ArrayInsert(level.var_db13261d, var_weapon, level.var_db13261d.size);
		}
	}
	level thread function_7eb13385();
	level thread function_c2bf8a3e();
	level.var_472cf71c = 1;
	level namespace_flag::function_set("loot_mode_active");
	namespace_zm_spawner::function_register_zombie_death_event_callback(&function_bcd41008);
	thread namespace_b2e35c83::function_a4869edc("loot_mode", "loot", "Loot overall command", &function_f2554709, undefined, "option_player_specific", undefined, undefined, undefined, 1);
}

/*
	Name: function_27ab1413
	Namespace: namespace_fdf6e22f
	Checksum: 0x424F4353
	Offset: 0x1D20
	Size: 0xD0
	Parameters: 2
	Flags: None
	Line Number: 111
*/
function function_27ab1413(var_b6a7b084, var_target_list)
{
	foreach(var_weapon in var_b6a7b084)
	{
		if(isdefined(level.var_zombie_weapons[function_GetWeapon(var_weapon)]))
		{
			function_ArrayInsert(var_target_list, var_weapon, var_target_list.size);
		}
	}
}

/*
	Name: function_e57c5b69
	Namespace: namespace_fdf6e22f
	Checksum: 0x424F4353
	Offset: 0x1DF8
	Size: 0x70
	Parameters: 0
	Flags: None
	Line Number: 132
*/
function function_e57c5b69()
{
	if(function_b400349f())
	{
		var_file = function_ce660824();
		var_66a7154d = function_1556496c(var_file);
		if(var_66a7154d.size < 1)
		{
			return 0;
		}
	}
	return 1;
}

/*
	Name: function_c347a257
	Namespace: namespace_fdf6e22f
	Checksum: 0x424F4353
	Offset: 0x1E70
	Size: 0x308
	Parameters: 0
	Flags: None
	Line Number: 156
*/
function function_c347a257()
{
	level.var_54757b63 = [];
	if(function_b400349f())
	{
		var_file = function_ce660824();
		var_66a7154d = function_1556496c(var_file);
		for(var_i = 0; var_i < var_66a7154d; var_i++)
		{
			var_row = function_TableLookupRow(var_file, var_i);
			var_index = function_Int(function_checkStringValid(var_row[0]));
			var_type = function_checkStringValid(var_row[1]);
			var_origin = (function_float(function_checkStringValid(var_row[2])), function_float(function_checkStringValid(var_row[3])), function_float(function_checkStringValid(var_row[4])));
			var_angles = (function_float(function_checkStringValid(var_row[5])), function_float(function_checkStringValid(var_row[6])), function_float(function_checkStringValid(var_row[7])));
			if(isdefined(var_index) && var_origin)
			{
				level.var_54757b63[var_index] = function_spawnstruct();
				level.var_54757b63[var_index].var_index = var_index;
				level.var_54757b63[var_index].var_type = var_type;
				level.var_54757b63[var_index].var_origin = var_origin;
				level.var_54757b63[var_index].var_angles = var_angles;
			}
		}
	}
	else
	{
		level.var_54757b63 = undefined;
	}
}

/*
	Name: function_ce660824
	Namespace: namespace_fdf6e22f
	Checksum: 0x424F4353
	Offset: 0x2180
	Size: 0x40
	Parameters: 0
	Flags: None
	Line Number: 196
*/
function function_ce660824()
{
	return "gamedata/loot_mode/loot_mode_" + function_ToLower(function_GetDvarString("mapname") + ".csv");
}

/*
	Name: function_b400349f
	Namespace: namespace_fdf6e22f
	Checksum: 0x424F4353
	Offset: 0x21C8
	Size: 0xD8
	Parameters: 0
	Flags: None
	Line Number: 211
*/
function function_b400349f()
{
	switch(function_ToLower(function_GetDvarString("mapname")))
	{
		case "zm_asylum":
		case "zm_castle":
		case "zm_cosmodrome":
		case "zm_factory":
		case "zm_genesis":
		case "zm_island":
		case "zm_moon":
		case "zm_prison":
		case "zm_prototype":
		case "zm_stalingrad":
		case "zm_sumpf":
		case "zm_temple":
		case "zm_theater":
		case "zm_tomb":
		case "zm_town":
		case "zm_town_hd":
		case "zm_zod":
		{
			return 1;
		}
		default
		{
			return 0;
		}
	}
	return 0;
	ERROR: Exception occured: Stack empty.
	continue;
}

/*
	Name: function_checkStringValid
	Namespace: namespace_fdf6e22f
	Checksum: 0x424F4353
	Offset: 0x22A8
	Size: 0x28
	Parameters: 1
	Flags: None
	Line Number: 255
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
	Name: function_37e1ab3a
	Namespace: namespace_fdf6e22f
	Checksum: 0x424F4353
	Offset: 0x22D8
	Size: 0x198
	Parameters: 0
	Flags: None
	Line Number: 274
*/
function function_37e1ab3a()
{
	if(!isdefined(level.var_ff05d2f2))
	{
		level.var_ff05d2f2 = [];
	}
	function_c347a257();
	if(isdefined(level.var_54757b63))
	{
		foreach(var_fc24c98c in level.var_54757b63)
		{
			level.var_ff05d2f2[var_fc24c98c.var_index] = function_spawnstruct();
			level.var_ff05d2f2[var_fc24c98c.var_index].var_origin = var_fc24c98c.var_origin;
			level.var_ff05d2f2[var_fc24c98c.var_index].var_angles = var_fc24c98c.var_angles;
			level.var_ff05d2f2[var_fc24c98c.var_index].var_type = var_fc24c98c.var_type;
			level.var_ff05d2f2[var_fc24c98c.var_index].var_zone = self function_6edb5f14();
		}
	}
}

/*
	Name: function_6edb5f14
	Namespace: namespace_fdf6e22f
	Checksum: 0x424F4353
	Offset: 0x2478
	Size: 0x110
	Parameters: 0
	Flags: None
	Line Number: 304
*/
function function_6edb5f14()
{
	foreach(var_zone in level.var_zones)
	{
		foreach(var_e_volume in var_zone.var_Volumes)
		{
			if(self function_istouching(var_e_volume))
			{
				return var_zone;
			}
		}
	}
	return undefined;
}

/*
	Name: function_7eb13385
	Namespace: namespace_fdf6e22f
	Checksum: 0x424F4353
	Offset: 0x2590
	Size: 0x88
	Parameters: 0
	Flags: None
	Line Number: 329
*/
function function_7eb13385()
{
	level endon("hash_end_game");
	wait(0.05);
	for(;;)
	{
		var_result = level namespace_util::function_waittill_any_return("start_of_round", "end_of_round");
		if(var_result == "start_of_round")
		{
			level thread function_f834b889();
		}
		else
		{
			level notify("hash_52424c4d");
		}
	}
}

/*
	Name: function_f834b889
	Namespace: namespace_fdf6e22f
	Checksum: 0x424F4353
	Offset: 0x2620
	Size: 0x6E8
	Parameters: 2
	Flags: None
	Line Number: 357
*/
function function_f834b889(var_spawn_min, var_spawn_max)
{
	if(!isdefined(var_spawn_min))
	{
		var_spawn_min = 5;
	}
	if(!isdefined(var_spawn_max))
	{
		var_spawn_max = 7;
	}
	if(!isdefined(level.var_46ec74b6))
	{
		level.var_46ec74b6 = 1;
		if(level.var_ff05d2f2.size > 75)
		{
			var_spawn_min = 14;
			var_spawn_max = 20;
		}
		else
		{
			var_spawn_min = 6;
			var_spawn_max = 9;
		}
	}
	var_366d0fb1 = namespace_Array::function_randomize(level.var_ff05d2f2);
	var_spawned = 0;
	foreach(var_fc24c98c in level.var_ff05d2f2)
	{
		if(isdefined(var_fc24c98c.var_spawned) && var_fc24c98c.var_spawned)
		{
			var_spawned++;
			function_ArrayRemoveValue(var_366d0fb1, var_fc24c98c);
		}
	}
	var_active_zones = [];
	var_adjacent_zones = [];
	foreach(var_player in level.var_players)
	{
		if(namespace_zm_utility::function_is_player_valid(var_player))
		{
			var_player_zone = var_player namespace_zm_utility::function_get_current_zone(1);
			if(isdefined(var_player_zone))
			{
				var_85748337 = function_get_adjacencies_to_zone(var_player_zone);
			}
			if(!namespace_Array::function_contains(var_active_zones, var_player_zone))
			{
				var_active_zones[var_active_zones.size] = var_player_zone;
			}
			if(isdefined(var_85748337))
			{
				foreach(var_adjacent_zone in var_85748337)
				{
					if(!namespace_Array::function_contains(var_adjacent_zones, var_adjacent_zone))
					{
						var_adjacent_zones[var_adjacent_zones.size] = var_adjacent_zone;
					}
				}
			}
		}
	}
	var_c5d8b91c = [];
	var_abc32a46 = [];
	var_db4f1348 = [];
	foreach(var_fc24c98c in var_366d0fb1)
	{
		if(namespace_Array::function_contains(var_active_zones, var_fc24c98c.var_zone))
		{
			var_c5d8b91c[var_c5d8b91c.size] = var_fc24c98c;
			continue;
		}
		if(namespace_Array::function_contains(var_adjacent_zones, var_fc24c98c.var_zone))
		{
			var_abc32a46[var_abc32a46.size] = var_fc24c98c;
			continue;
		}
		var_db4f1348[var_db4f1348.size] = var_fc24c98c;
	}
	var_366d0fb1 = [];
	var_366d0fb1 = function_ArrayCombine(var_366d0fb1, var_c5d8b91c, 0, 0);
	var_366d0fb1 = function_ArrayCombine(var_366d0fb1, var_abc32a46, 0, 0);
	var_366d0fb1 = function_ArrayCombine(var_366d0fb1, var_db4f1348, 0, 0);
	var_eaf3f3d5 = function_min(function_randomIntRange(var_spawn_min, var_spawn_max), var_366d0fb1.size);
	if(var_spawned < 50)
	{
		for(var_i = 0; var_i < var_eaf3f3d5; var_i++)
		{
			if(isdefined(var_366d0fb1[var_i]))
			{
				switch(var_366d0fb1[var_i].var_type)
				{
					case "crate":
					{
						var_366d0fb1[var_i] thread function_3bae6a6b("zmu_loot_crate", "loot_crate_open", "Hold ^3&&1^7 to Open Loot Crate", "loot_crate_cache_ambient", "loot_crate_cache_open", "loot_crate_cache_open_legendary", 1);
						break;
					}
					case "ammo":
					{
						var_366d0fb1[var_i] thread function_3bae6a6b("zmu_loot_ammo", "loot_ammo_open", "Hold ^3&&1^7 to Open Ammo Supply", undefined, "loot_locker_ammo_open", undefined, 0, function_Array("ammo"), function_Array(0));
						break;
					}
					case "locker":
					{
						var_366d0fb1[var_i] thread function_3bae6a6b("zmu_loot_locker", "loot_locker_open", "Hold ^3&&1^7 to Open Locker", undefined, "loot_locker_cache_open", undefined, 0, function_Array("cash", "ammo", "weapon", "perk"), function_Array(0, 1, 2));
						break;
					}
				}
			}
		}
	}
}

/*
	Name: function_get_adjacencies_to_zone
	Namespace: namespace_fdf6e22f
	Checksum: 0x424F4353
	Offset: 0x2D10
	Size: 0x120
	Parameters: 1
	Flags: None
	Line Number: 479
*/
function function_get_adjacencies_to_zone(var_str_zone)
{
	var_a_adjacencies = [];
	var_a_adjacencies[0] = var_str_zone;
	var_a_adjacent_zones = function_getArrayKeys(level.var_zones[var_str_zone].var_adjacent_zones);
	for(var_i = 0; var_i < var_a_adjacent_zones.size; var_i++)
	{
		if(level.var_zones[var_str_zone].var_adjacent_zones[var_a_adjacent_zones[var_i]].var_is_connected)
		{
			if(!isdefined(var_a_adjacencies))
			{
				var_a_adjacencies = [];
			}
			else if(!function_IsArray(var_a_adjacencies))
			{
				var_a_adjacencies = function_Array(var_a_adjacencies);
			}
			var_a_adjacencies[var_a_adjacencies.size] = var_a_adjacent_zones[var_i];
		}
	}
	return var_a_adjacencies;
}

/*
	Name: function_3bae6a6b
	Namespace: namespace_fdf6e22f
	Checksum: 0x424F4353
	Offset: 0x2E38
	Size: 0x5C8
	Parameters: 9
	Flags: None
	Line Number: 512
*/
function function_3bae6a6b(var_5a5e0afa, var_2c395376, var_hint_string, var_88ea8a6b, var_51de95c1, var_40798fd3, var_64e56236, var_384a40cb, var_879a3bb)
{
	if(!isdefined(var_64e56236))
	{
		var_64e56236 = 1;
	}
	if(!isdefined(var_879a3bb))
	{
		var_879a3bb = undefined;
	}
	function_a6c913ff("Spawning Loot Object: " + self.var_type + " at " + self.var_origin);
	self.var_spawned = 1;
	self.var_e9e92a5b = namespace_util::function_spawn_model(var_5a5e0afa, self.var_origin, self.var_angles - VectorScale((0, 1, 0), 90));
	self.var_e9e92a5b function_useanimtree(-1);
	self.var_d277f374 = function_7a4f83ef(var_64e56236, var_879a3bb);
	wait(0.05);
	if(self.var_d277f374 == 0)
	{
		self.var_e9e92a5b namespace_clientfield::function_set("weapon_drop_enable_keyline", 1);
	}
	else
	{
		self.var_e9e92a5b namespace_clientfield::function_set("weapon_drop_level_enable_keyline", self.var_d277f374);
	}
	if(self.var_type == "crate")
	{
		self.var_e9e92a5b namespace_clientfield::function_set("loot_crate_fx", self.var_d277f374 + 1);
	}
	if(isdefined(var_88ea8a6b))
	{
		self.var_e9e92a5b function_PlayLoopSound(var_88ea8a6b, 1);
	}
	self.var_c6e950bd = function_spawn("trigger_radius_use", self.var_origin + VectorScale((0, 0, 1), 40), 0, 30, 30);
	self.var_c6e950bd function_TriggerIgnoreTeam();
	self.var_c6e950bd function_SetVisibleToAll();
	self.var_c6e950bd function_SetTeamForTrigger("none");
	self.var_c6e950bd function_UseTriggerRequireLookAt();
	self.var_c6e950bd function_setcursorhint("HINT_NOICON");
	self.var_c6e950bd function_setHintString(var_hint_string);
	while(isdefined(self.var_c6e950bd))
	{
		self.var_c6e950bd waittill("hash_trigger", var_player);
		function_a6c913ff("Opening Loot Object: " + self.var_type);
		self.var_e9e92a5b namespace_clientfield::function_set("weapon_drop_level_enable_keyline", 0);
		self.var_e9e92a5b namespace_clientfield::function_set("weapon_drop_enable_keyline", 0);
		if(self.var_type == "crate")
		{
			self.var_e9e92a5b namespace_clientfield::function_set("loot_crate_fx", 0);
		}
		if(isdefined(var_88ea8a6b))
		{
			self.var_e9e92a5b function_StopLoopSound(5);
		}
		wait(0.05);
		if(isdefined(var_51de95c1) || isdefined(var_40798fd3))
		{
			if(self.var_d277f374 == 4)
			{
				if(isdefined(var_40798fd3))
				{
					function_playsoundatposition(var_40798fd3, self.var_origin);
				}
				else if(isdefined(var_51de95c1))
				{
					function_playsoundatposition(var_51de95c1, self.var_origin);
				}
			}
			else if(isdefined(var_51de95c1))
			{
				function_playsoundatposition(var_51de95c1, self.var_origin);
			}
		}
		self.var_e9e92a5b namespace_scene::function_Play(var_2c395376, self.var_e9e92a5b);
		switch(self.var_type)
		{
			case "crate":
			{
				self thread function_bc36d14(var_player, undefined);
				break;
			}
			case "ammo":
			{
				self thread function_bc36d14(var_player, function_Array("ammo"));
				break;
			}
			case "locker":
			{
				self thread function_bc36d14(var_player, function_Array("cash", "ammo", "weapon", "perk"));
				break;
			}
		}
		self.var_c6e950bd function_delete();
	}
	level waittill("hash_52424c4d");
	if(isdefined(self.var_e9e92a5b))
	{
		self.var_e9e92a5b function_delete();
	}
	self.var_spawned = 0;
}

/*
	Name: function_bc36d14
	Namespace: namespace_fdf6e22f
	Checksum: 0x424F4353
	Offset: 0x3408
	Size: 0x670
	Parameters: 2
	Flags: None
	Line Number: 623
*/
function function_bc36d14(var_player, var_43145009)
{
	if(!isdefined(var_43145009))
	{
		var_43145009 = undefined;
	}
	var_loot = [];
	if(!isdefined(var_43145009))
	{
		var_43145009 = function_Array("cash", "ammo", "scrap", "weapon", "perk", "powerup");
	}
	var_primary_weapons = var_player function_GetWeaponsListPrimaries();
	var_41cc782b = var_primary_weapons.size == 1;
	switch(self.var_d277f374)
	{
		case 0:
		{
			var_3601151b = function_randomIntRange(3, 5);
			break;
		}
		case 1:
		{
			var_3601151b = function_randomIntRange(3, 5);
			break;
		}
		case 2:
		{
			var_3601151b = function_randomIntRange(4, 6);
			break;
		}
		case 3:
		{
			var_3601151b = function_randomIntRange(5, 6);
			break;
		}
		case 4:
		{
			var_3601151b = function_randomIntRange(4, 6);
			break;
		}
		default
		{
			var_3601151b = function_randomIntRange(4, 5);
			break;
		}
	}
	var_has_perk = 0;
	var_a44dcd3d = 0;
	var_cd0d496 = 0;
	var_has_weapon = 0;
	for(var_i = 0; var_i < var_3601151b; var_i++)
	{
		var_loot[var_i] = function_spawnstruct();
		var_loot_type = function_974521e5(self.var_d277f374);
		if(!namespace_Array::function_contains(var_43145009, var_loot_type))
		{
			var_loot_type = namespace_Array::function_random(var_43145009);
		}
		if(self.var_60ac2a75 == "locker")
		{
			if(function_RandomInt(100) < 35)
			{
				var_loot_type = "weapon";
			}
		}
		if(var_41cc782b && function_RandomInt(100) < 40)
		{
			var_loot_type = "weapon";
		}
		if(var_loot_type == "perk" && var_has_perk)
		{
			var_loot_type = "cash";
		}
		if(var_loot_type == "pack_a_punch" && var_a44dcd3d)
		{
			var_loot_type = "ammo";
		}
		if(var_loot_type == "powerup" && var_cd0d496)
		{
			var_loot_type = "scrap";
		}
		if(var_loot_type == "weapon" && var_has_weapon >= 2)
		{
			var_loot_type = "ammo";
		}
		if(var_loot_type == "perk")
		{
			var_has_perk = 1;
		}
		if(var_loot_type == "pack_a_punch")
		{
			var_a44dcd3d = 1;
		}
		if(var_loot_type == "powerup")
		{
			var_cd0d496 = 1;
		}
		if(var_loot_type == "weapon")
		{
			var_has_weapon++;
		}
		switch(var_loot_type)
		{
			case "cash":
			{
				self thread function_41824d55(var_loot[var_i], var_player, self.var_d277f374);
				break;
			}
			case "ammo":
			{
				self thread function_cf9ee226(var_loot[var_i], var_player, self.var_d277f374);
				break;
			}
			case "scrap":
			{
				self thread function_671c2653(var_loot[var_i], var_player, self.var_d277f374);
				break;
			}
			case "weapon":
			{
				self thread function_2568f790(var_loot[var_i], var_player, self.var_d277f374);
				break;
			}
			case "equipment":
			{
				self thread function_93c607c4(var_loot[var_i], var_player, self.var_d277f374);
				break;
			}
			case "perk":
			{
				self thread function_db4f9348(var_loot[var_i], var_player, self.var_d277f374);
				break;
			}
			case "pack_a_punch":
			{
				self thread function_c298a46c(var_loot[var_i], var_player, self.var_d277f374);
				break;
			}
			case "powerup":
			{
				self thread function_f56eab70(var_loot[var_i], var_player, self.var_d277f374);
				break;
			}
			case "aat_mod":
			{
				self thread function_7c36f942(var_loot[var_i], var_player, self.var_d277f374);
				break;
			}
			default
			{
				self thread function_41824d55(var_loot[var_i], var_player, self.var_d277f374);
				break;
			}
		}
		wait(0.14);
	}
}

/*
	Name: function_675d72a5
	Namespace: namespace_fdf6e22f
	Checksum: 0x424F4353
	Offset: 0x3A80
	Size: 0x160
	Parameters: 0
	Flags: None
	Line Number: 791
*/
function function_675d72a5()
{
	var_spawn_origin = self.var_origin;
	var_spawn_angles = self.var_angles;
	for(var_attempts = 10; var_attempts > 0; var_attempts--)
	{
		var_forward_direction = function_AnglesToForward(var_spawn_angles);
		var_right_direction = function_AnglesToRight(var_spawn_angles);
		var_5a09e6d5 = var_spawn_origin + var_forward_direction * function_randomIntRange(30, 45) + var_right_direction * function_randomIntRange(-45, 45);
		if(self function_CanPath(var_5a09e6d5, self.var_origin) && function_IsPointOnNavMesh(var_5a09e6d5))
		{
			return var_5a09e6d5;
		}
		var_spawn_angles = var_spawn_angles + (0, function_randomIntRange(-30, 30), 0);
	}
	return var_spawn_origin;
}

/*
	Name: function_41824d55
	Namespace: namespace_fdf6e22f
	Checksum: 0x424F4353
	Offset: 0x3BE8
	Size: 0x4D0
	Parameters: 4
	Flags: None
	Line Number: 819
*/
function function_41824d55(var_loot, var_player, var_d277f374, var_1e79ca82)
{
	if(!isdefined(var_d277f374))
	{
		var_d277f374 = 0;
	}
	function_a6c913ff("Cash Dropped");
	if(isdefined(var_1e79ca82))
	{
		var_5b141657 = function_round_up_to_ten(var_1e79ca82);
	}
	else
	{
		switch(var_d277f374)
		{
			case 0:
			{
				var_5b141657 = function_round_up_to_ten(function_randomIntRange(150, 250));
				break;
			}
			case 1:
			{
				var_5b141657 = function_round_up_to_ten(function_randomIntRange(250, 500));
				break;
			}
			case 2:
			{
				var_5b141657 = function_round_up_to_ten(function_randomIntRange(500, 1000));
				break;
			}
			case 3:
			{
				var_5b141657 = function_round_up_to_ten(function_randomIntRange(1000, 1500));
				break;
			}
			case 4:
			{
				var_5b141657 = function_round_up_to_ten(function_randomIntRange(1500, 3000));
				break;
			}
		}
	}
	if(var_5b141657 <= 500)
	{
		var_loot_model = "zmu_loot_money_pile_01";
	}
	else if(var_5b141657 <= 1500)
	{
		var_loot_model = "zmu_loot_money_pile_02";
	}
	else if(var_5b141657 <= 3000)
	{
		var_loot_model = "zmu_loot_money_pile_03";
	}
	else
	{
		var_loot_model = "zmu_loot_money_bag_01";
	}
	var_loot.var_loot_model = namespace_util::function_spawn_model(var_loot_model, self.var_origin + VectorScale((0, 0, 1), 30), self.var_angles);
	var_spawn_position = self function_675d72a5();
	var_final_pos = self namespace_ecdf5e21::function_a2b97522(var_spawn_position, 35, var_loot.var_loot_model, 1);
	var_loot.var_loot_model namespace_ecdf5e21::function_a170d6f0(var_final_pos, 15);
	var_loot.var_loot_model namespace_clientfield::function_set("weapon_drop_enable_keyline", 1);
	var_loot.var_loot_model thread function_e1859039();
	var_loot.var_loot_model thread function_d02b4a40("Hold ^3&&1^7 to Pickup Cash [^2$" + var_5b141657 + "^7]", 20);
	var_loot.var_loot_model thread function_c71d30f1(undefined, 24);
	var_loot.var_loot_model thread function_2aa7612d(15);
	var_loot.var_loot_model thread function_8fedabe9();
	var_loot.var_loot_model waittill("hash_81c3a5c2", var_player);
	var_loot.var_loot_model notify("hash_690bf263");
	if(var_player.var_f4d01b67["pickup_ui"] == 0)
	{
		var_player thread namespace_97ac1184::function_8c165b4d("Data", "PickupUI", "+$" + var_5b141657 + ",zmu_ui_pickup_cash", 1, 1);
	}
	var_player function_playsoundtoplayer("iw8_ammo_pickup", var_player);
	var_player namespace_zm_score::function_add_to_player_score(var_5b141657);
	wait(0.05);
	var_loot function_delete();
}

/*
	Name: function_671c2653
	Namespace: namespace_fdf6e22f
	Checksum: 0x424F4353
	Offset: 0x40C0
	Size: 0x190
	Parameters: 3
	Flags: None
	Line Number: 909
*/
function function_671c2653(var_loot, var_player, var_d277f374)
{
	function_a6c913ff("Scrap Dropped");
	switch(var_d277f374)
	{
		case 0:
		{
			var_6883ec27 = 1;
			break;
		}
		case 1:
		{
			var_6883ec27 = function_randomIntRange(1, 3);
			break;
		}
		case 2:
		{
			var_6883ec27 = function_randomIntRange(1, 3);
			break;
		}
		case 3:
		{
			var_6883ec27 = function_randomIntRange(2, 4);
			break;
		}
		case 4:
		{
			function_a6c913ff("No Scrap in Legendary Loot");
			var_loot function_delete();
			return;
		}
	}
	for(var_i = 0; var_i < var_6883ec27; var_i++)
	{
		var_2444f4c9 = [];
		self thread function_e145d209(var_2444f4c9[var_i]);
		wait(0.08);
	}
	var_loot function_delete();
	return;
	ERROR: Exception occured: Stack empty.
}

/*
	Name: function_e145d209
	Namespace: namespace_fdf6e22f
	Checksum: 0x424F4353
	Offset: 0x4258
	Size: 0x2A0
	Parameters: 1
	Flags: None
	Line Number: 962
*/
function function_e145d209(var_2444f4c9)
{
	var_2444f4c9 = function_spawnstruct();
	var_2444f4c9.var_loot_model = namespace_util::function_spawn_model("t10_zm_junk_parts_pile", self.var_origin + VectorScale((0, 0, 1), 30), self.var_angles);
	var_spawn_position = self function_675d72a5();
	var_final_pos = self namespace_ecdf5e21::function_a2b97522(var_spawn_position, 35, var_2444f4c9.var_loot_model, 1);
	var_2444f4c9.var_loot_model namespace_ecdf5e21::function_a170d6f0(var_final_pos, 12);
	var_2444f4c9.var_loot_model namespace_clientfield::function_set("weapon_drop_level_enable_keyline", 1);
	var_2444f4c9.var_loot_model thread function_e1859039();
	var_2444f4c9.var_loot_model thread function_d02b4a40("Hold ^3&&1^7 to Pickup Scrap", 20);
	var_2444f4c9.var_loot_model thread function_c71d30f1(undefined, 24);
	var_2444f4c9.var_loot_model thread function_2aa7612d(15);
	var_2444f4c9.var_loot_model thread function_8fedabe9();
	var_2444f4c9.var_loot_model waittill("hash_81c3a5c2", var_player);
	var_2444f4c9.var_loot_model notify("hash_690bf263");
	if(var_player.var_f4d01b67["pickup_ui"] == 0)
	{
		var_player thread namespace_97ac1184::function_8c165b4d("Data", "PickupUI", "+1 Scrap,zmu_ui_pickup_scrap", 1, 1);
	}
	var_player function_playsoundtoplayer("iw8_ammo_pickup", var_player);
	var_player function_13f2da08(1);
	wait(0.05);
	var_2444f4c9 function_delete();
	return;
	ERROR: Exception occured: Stack empty.
}

/*
	Name: function_93c607c4
	Namespace: namespace_fdf6e22f
	Checksum: 0x424F4353
	Offset: 0x4500
	Size: 0x40
	Parameters: 4
	Flags: None
	Line Number: 999
*/
function function_93c607c4(var_loot, var_player, var_d277f374, var_equipment)
{
	function_a6c913ff("Equipment Dropped");
}

/*
	Name: function_db4f9348
	Namespace: namespace_fdf6e22f
	Checksum: 0x424F4353
	Offset: 0x4548
	Size: 0x3B8
	Parameters: 4
	Flags: None
	Line Number: 1014
*/
function function_db4f9348(var_loot, var_player, var_d277f374, var_perk)
{
	if(!isdefined(var_perk))
	{
		var_perk = undefined;
	}
	function_a6c913ff("Perk Dropped");
	if(var_d277f374 == 0)
	{
		return;
	}
	if(isdefined(var_perk))
	{
		var_87abba1b = var_perk;
	}
	else
	{
		var_87abba1b = function_37c5991e();
	}
	if(isdefined(level.var__custom_perks[var_87abba1b].var_perk_bottle_weapon.var_worldmodel))
	{
		var_loot.var_loot_model = namespace_util::function_spawn_model(level.var__custom_perks[var_87abba1b].var_perk_bottle_weapon.var_worldmodel, self.var_origin + VectorScale((0, 0, 1), 30), self.var_angles);
	}
	else
	{
		var_loot.var_loot_model = namespace_util::function_spawn_model("reward_perk_bottle", self.var_origin + VectorScale((0, 0, 1), 30), self.var_angles);
	}
	var_spawn_position = self function_675d72a5();
	var_final_pos = self namespace_ecdf5e21::function_a2b97522(var_spawn_position, 35, var_loot.var_loot_model, 1);
	var_loot.var_loot_model namespace_ecdf5e21::function_a170d6f0(var_final_pos, 15);
	var_loot.var_loot_model namespace_clientfield::function_set("weapon_drop_level_enable_keyline", 2);
	var_loot.var_loot_model thread function_e1859039();
	var_loot.var_loot_model thread function_d02b4a40("Hold ^3&&1^7 to Pickup " + var_87abba1b, 20);
	var_loot.var_loot_model thread function_2aa7612d(15);
	var_loot.var_loot_model thread function_8fedabe9();
	var_loot.var_loot_model waittill("hash_81c3a5c2", var_player);
	var_loot.var_loot_model notify("hash_690bf263");
	if(var_player.var_f4d01b67["pickup_ui"] == 0)
	{
		var_player thread namespace_97ac1184::function_8c165b4d("Data", "PickupUI", "+ " + var_87abba1b + ",zmu_ui_pickup_perk", 1, 1);
	}
	var_player function_playsoundtoplayer("iw8_perk_pickup", var_player);
	if(var_player function_hasPerk(var_87abba1b))
	{
		var_player namespace_zm_score::function_add_to_player_score(500);
	}
	else
	{
		var_player namespace_zm_perks::function_give_perk(var_87abba1b, 0);
	}
	wait(0.05);
	var_loot function_delete();
}

/*
	Name: function_c298a46c
	Namespace: namespace_fdf6e22f
	Checksum: 0x424F4353
	Offset: 0x4908
	Size: 0x340
	Parameters: 3
	Flags: None
	Line Number: 1078
*/
function function_c298a46c(var_loot, var_player, var_d277f374)
{
	function_a6c913ff("Pack-a-Punch Upgrade Dropped");
	if(var_d277f374 <= 1)
	{
		return;
	}
	var_a39a2843 = 0;
	switch(var_d277f374)
	{
		case 2:
		{
			if(function_RandomInt(100) < 10)
			{
				var_a39a2843 = 1;
				break;
			}
		}
		case 3:
		{
			if(function_RandomInt(100) < 40)
			{
				var_a39a2843 = 1;
				break;
			}
		}
		case 4:
		{
			if(function_RandomInt(100) < 75)
			{
				var_a39a2843 = 1;
				break;
			}
		}
	}
	if(var_a39a2843 == 0)
	{
		return;
	}
	var_loot.var_loot_model = namespace_util::function_spawn_model("reward_pack_a_punch", self.var_origin + VectorScale((0, 0, 1), 30), self.var_angles);
	var_spawn_position = self function_675d72a5();
	var_final_pos = self namespace_ecdf5e21::function_a2b97522(var_spawn_position, 35, var_loot.var_loot_model, 1);
	var_loot.var_loot_model namespace_ecdf5e21::function_a170d6f0(var_final_pos, 15);
	var_loot.var_loot_model namespace_clientfield::function_set("weapon_drop_level_enable_keyline", 4);
	var_loot.var_loot_model thread function_e1859039();
	var_loot.var_loot_model thread function_d02b4a40("Hold ^3&&1^7 to Upgrade Weapon [^2Pack-a-Punch^7]", 20);
	var_loot.var_loot_model thread function_2aa7612d(15);
	var_loot.var_loot_model thread function_8fedabe9();
	var_loot.var_loot_model waittill("hash_81c3a5c2", var_player);
	var_loot.var_loot_model notify("hash_690bf263");
	var_player function_playsoundtoplayer("iw8_pap_upgrade", var_player);
	var_player thread namespace_97ac1184::function_8c165b4d("Data", "PickupUI", "+ Pack-a-Punch Tier " + var_a39a2843 + ",zmu_ui_pickup_pap", 1, 1);
	wait(0.05);
	var_loot function_delete();
}

/*
	Name: function_f56eab70
	Namespace: namespace_fdf6e22f
	Checksum: 0x424F4353
	Offset: 0x4C50
	Size: 0x420
	Parameters: 3
	Flags: None
	Line Number: 1144
*/
function function_f56eab70(var_loot, var_player, var_d277f374)
{
	function_a6c913ff("Powerup Dropped");
	if(var_d277f374 == 0 || var_d277f374 == 4)
	{
		return;
	}
	var_e5674a46 = [];
	switch(var_d277f374)
	{
		case 1:
		{
			if(function_RandomInt(100) < 15)
			{
				var_e5674a46 = function_Array("carpenter", "minigun", "nuke");
				break;
			}
		}
		case 2:
		{
			var_e5674a46 = function_Array("carpenter", "minigun", "insta_kill", "double_points", "storm_surge");
			break;
		}
		case 3:
		{
			var_e5674a46 = function_Array("double_points", "insta_kill", "storm_surge");
			break;
		}
	}
	if(var_e5674a46.size == 0)
	{
		return;
	}
	var_2e37d443 = var_e5674a46[function_RandomInt(var_e5674a46.size)];
	var_6c3b5312 = level.var_zombie_powerups[var_2e37d443];
	var_loot.var_loot_model = namespace_util::function_spawn_model(var_6c3b5312.var_model_name, self.var_origin + VectorScale((0, 0, 1), 30), self.var_angles);
	var_spawn_position = self function_675d72a5();
	var_final_pos = self namespace_ecdf5e21::function_a2b97522(var_spawn_position, 35, var_loot.var_loot_model, 1);
	var_loot.var_loot_model namespace_ecdf5e21::function_a170d6f0(var_final_pos, 15);
	var_loot.var_loot_model namespace_clientfield::function_set("weapon_drop_level_enable_keyline", 1);
	var_loot.var_loot_model thread function_e1859039();
	var_loot.var_loot_model thread function_d02b4a40("Hold ^3&&1^7 to Pickup Powerup [^2" + var_6c3b5312.var_powerup_name + "^7]", 20);
	var_loot.var_loot_model thread function_2aa7612d(15);
	var_loot.var_loot_model thread function_8fedabe9();
	var_loot.var_loot_model waittill("hash_81c3a5c2", var_player);
	var_loot.var_loot_model notify("hash_690bf263");
	level thread namespace_zm_powerups::function_specific_powerup_drop(var_6c3b5312.var_powerup_name, var_player.var_origin, undefined, undefined, undefined, undefined, 0);
	var_player function_playsoundtoplayer("iw8_powerup_pickup", var_player);
	var_player thread namespace_97ac1184::function_8c165b4d("Data", "PickupUI", "+ " + var_6c3b5312.var_powerup_name + ",zmu_ui_pickup_powerup", 1, 1);
	wait(0.05);
	var_loot function_delete();
	return;
	ERROR: Exception occured: Stack empty.
}

/*
	Name: function_7c36f942
	Namespace: namespace_fdf6e22f
	Checksum: 0x424F4353
	Offset: 0x5078
	Size: 0x3F0
	Parameters: 3
	Flags: None
	Line Number: 1209
*/
function function_7c36f942(var_loot, var_player, var_d277f374)
{
	function_a6c913ff("AAT Mod Dropped");
	if(var_d277f374 == 0 || var_d277f374 == 1)
	{
		return;
	}
	var_b8bbacaf = [];
	var_chance = 0;
	switch(var_d277f374)
	{
		case 2:
		{
			if(function_RandomInt(100) < 10)
			{
				var_b8bbacaf = function_Array("aat_deadwire", "aat_firebomb", "aat_cryo");
				break;
			}
		}
		case 3:
		{
			if(function_RandomInt(100) < 40)
			{
				var_b8bbacaf = function_Array("aat_deadwire", "aat_firebomb", "aat_cryo", "aat_brainrot");
				break;
			}
		}
		case 4:
		{
			var_b8bbacaf = function_Array("aat_deadwire", "aat_firebomb", "aat_cryo", "aat_brainrot", "aat_shatterblast");
			break;
		}
	}
	if(var_b8bbacaf.size == 0)
	{
		return;
	}
	var_2848a378 = var_b8bbacaf[function_RandomInt(var_b8bbacaf.size)];
	var_loot.var_loot_model = namespace_util::function_spawn_model("reward_pack_a_punch", self.var_origin + VectorScale((0, 0, 1), 30), self.var_angles);
	var_spawn_position = self function_675d72a5();
	var_final_pos = self namespace_ecdf5e21::function_a2b97522(var_spawn_position, 35, var_loot.var_loot_model, 1);
	var_loot.var_loot_model namespace_ecdf5e21::function_a170d6f0(var_final_pos, 15);
	var_loot.var_loot_model namespace_clientfield::function_set("weapon_drop_level_enable_keyline", 3);
	var_loot.var_loot_model thread function_e1859039();
	var_loot.var_loot_model thread function_d02b4a40("Hold ^3&&1^7 to Pickup AAT Mod [^2" + var_2848a378 + "^7]", 20);
	var_loot.var_loot_model thread function_2aa7612d(15);
	var_loot.var_loot_model thread function_8fedabe9();
	var_loot.var_loot_model waittill("hash_81c3a5c2", var_player);
	var_loot.var_loot_model notify("hash_690bf263");
	var_player function_playsoundtoplayer("iw8_powerup_pickup", var_player);
	var_player thread namespace_97ac1184::function_8c165b4d("Data", "PickupUI", "+ " + var_2848a378 + ",zmu_ui_pickup_aat", 1, 1);
	wait(0.05);
	var_loot function_delete();
}

/*
	Name: function_2568f790
	Namespace: namespace_fdf6e22f
	Checksum: 0x424F4353
	Offset: 0x5470
	Size: 0x118
	Parameters: 4
	Flags: None
	Line Number: 1274
*/
function function_2568f790(var_loot, var_player, var_d277f374, var_weapon)
{
	if(!isdefined(var_weapon))
	{
		var_weapon = undefined;
	}
	function_a6c913ff("Weapon Dropped");
	if(isdefined(var_weapon))
	{
		var_1b0df359 = function_GetWeapon(var_weapon);
	}
	else
	{
		var_1b0df359 = function_GetWeapon(self function_9b1b417f(var_d277f374));
	}
	self thread namespace_ecdf5e21::function_a0e9587e(var_player, var_1b0df359, undefined, var_1b0df359.var_clipSize, 0, 0, 25, 35, function_randomIntRange(5, 15), function_randomIntRange(-30, 30), 15);
}

/*
	Name: function_cf9ee226
	Namespace: namespace_fdf6e22f
	Checksum: 0x424F4353
	Offset: 0x5590
	Size: 0x670
	Parameters: 3
	Flags: None
	Line Number: 1302
*/
function function_cf9ee226(var_loot, var_player, var_d277f374)
{
	if(!isdefined(var_d277f374))
	{
		var_d277f374 = 0;
	}
	function_a6c913ff("Ammo Dropped");
	var_f9809ac8 = function_spawnstruct();
	var_8dbb9cda = function_7ffcfbcf();
	switch(var_8dbb9cda)
	{
		case "smg":
		{
			var_f9809ac8.var_loot_model = namespace_util::function_spawn_model("t10_lm_loot_ammo_pistol_smg_01", self.var_origin + VectorScale((0, 0, 1), 30), self.var_angles);
			break;
		}
		case "ar":
		{
			var_f9809ac8.var_loot_model = namespace_util::function_spawn_model("zmu_ammo_pack", self.var_origin + VectorScale((0, 0, 1), 30), self.var_angles);
			break;
		}
		case "shotgun":
		{
			var_f9809ac8.var_loot_model = namespace_util::function_spawn_model("t10_lm_loot_ammo_shotgun_01", self.var_origin + VectorScale((0, 0, 1), 30), self.var_angles);
			break;
		}
		case "sniper":
		{
			var_f9809ac8.var_loot_model = namespace_util::function_spawn_model("t10_lm_loot_ammo_marksman_sniper_01", self.var_origin + VectorScale((0, 0, 1), 30), self.var_angles);
			break;
		}
		case "launcher":
		{
			var_f9809ac8.var_loot_model = namespace_util::function_spawn_model("t10_lm_loot_ammo_rocket", self.var_origin + VectorScale((0, 0, 1), 30), self.var_angles);
			break;
		}
		case "wonder_low":
		{
			var_f9809ac8.var_loot_model = namespace_util::function_spawn_model("zmu_ammo_pack", self.var_origin + VectorScale((0, 0, 1), 30), self.var_angles);
			break;
		}
		case "wonder_high":
		{
			var_f9809ac8.var_loot_model = namespace_util::function_spawn_model("zmu_ammo_pack", self.var_origin + VectorScale((0, 0, 1), 30), self.var_angles);
			break;
		}
		default
		{
			var_f9809ac8.var_loot_model = namespace_util::function_spawn_model("zmu_ammo_pack", self.var_origin + VectorScale((0, 0, 1), 30), self.var_angles);
		}
	}
	var_spawn_position = self function_675d72a5();
	var_final_pos = self namespace_ecdf5e21::function_a2b97522(var_spawn_position, 35, var_f9809ac8.var_loot_model, 1);
	var_f9809ac8.var_loot_model namespace_ecdf5e21::function_a170d6f0(var_final_pos, 15);
	var_f9809ac8.var_loot_model namespace_clientfield::function_set("weapon_drop_enable_keyline", 1);
	var_f9809ac8.var_loot_model thread function_e1859039();
	var_f9809ac8.var_loot_model thread function_aa0c5645("Hold ^3&&1^7 to Pickup " + var_8dbb9cda + " Ammo", 20, var_8dbb9cda);
	var_f9809ac8.var_loot_model thread function_1051b116(undefined, 24, var_8dbb9cda);
	var_f9809ac8.var_loot_model thread function_2aa7612d(15);
	var_f9809ac8.var_loot_model thread function_8fedabe9();
	var_f9809ac8.var_loot_model waittill("hash_81c3a5c2", var_player);
	function_a6c913ff("Ammo Type: " + var_8dbb9cda + " | Ammo Increase by: " + var_player.var_d79f52bf[var_8dbb9cda].var_d3d8af77);
	var_f9809ac8.var_loot_model notify("hash_690bf263");
	if(var_player.var_f4d01b67["pickup_ui"] == 0)
	{
		var_player thread namespace_97ac1184::function_8c165b4d("Data", "PickupUI", "+" + var_player.var_d79f52bf[var_8dbb9cda].var_d3d8af77 + " " + var_8dbb9cda + " Ammo,zmu_ui_pickup_ammo", 1, 1);
	}
	wait(0.05);
	var_current_weapon = var_player function_GetCurrentWeapon();
	if(isdefined(var_current_weapon function_25b21deb()) && var_current_weapon function_25b21deb())
	{
		function_a6c913ff("Clip weapon; Fix this!");
	}
	else
	{
		var_player function_7c33c3ad(var_8dbb9cda, var_player.var_d79f52bf[var_8dbb9cda].var_d3d8af77, var_current_weapon);
	}
	var_player function_playsoundtoplayer("iw8_ammo_pickup", var_player);
	wait(0.05);
	var_f9809ac8 function_delete();
}

/*
	Name: function_7ffcfbcf
	Namespace: namespace_fdf6e22f
	Checksum: 0x424F4353
	Offset: 0x5C08
	Size: 0xD8
	Parameters: 0
	Flags: None
	Line Number: 1394
*/
function function_7ffcfbcf()
{
	var_rand = function_RandomInt(100);
	if(var_rand < 25)
	{
		return "ar";
	}
	else if(var_rand < 50)
	{
		return "smg";
	}
	else if(var_rand < 75)
	{
		return "shotgun";
	}
	else if(var_rand < 85)
	{
		return "sniper";
	}
	else if(var_rand < 92)
	{
		return "launcher";
	}
	else if(var_rand < 97)
	{
		return "wonder_low";
	}
	else
	{
		return "wonder_high";
	}
}

/*
	Name: function_25b21deb
	Namespace: namespace_fdf6e22f
	Checksum: 0x424F4353
	Offset: 0x5CE8
	Size: 0x98
	Parameters: 0
	Flags: None
	Line Number: 1437
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
	ERROR: Bad function call
}

/*
	Name: function_6bf2aeab
	Namespace: namespace_fdf6e22f
	Checksum: 0x424F4353
	Offset: 0x5D88
	Size: 0x9F0
	Parameters: 1
	Flags: None
	Line Number: 1476
*/
function function_6bf2aeab(var_player)
{
	if(namespace_Array::function_contains(level.var_68e89529, self.var_name))
	{
		return "smg";
	}
	else if(namespace_Array::function_contains(level.var_ceb658e7, self.var_name))
	{
		return "smg";
	}
	else if(namespace_Array::function_contains(level.var_181fb591, self.var_name))
	{
		return "ar";
	}
	else if(namespace_Array::function_contains(level.var_45a59029, self.var_name))
	{
		return "sniper";
	}
	else if(namespace_Array::function_contains(level.var_df1b28f2, self.var_name))
	{
		return "shotgun";
	}
	else if(namespace_Array::function_contains(level.var_e0580f08, self.var_name))
	{
		return "ar";
	}
	else if(namespace_Array::function_contains(level.var_268306a8, self.var_name))
	{
		return "launcher";
	}
	else if(namespace_Array::function_contains(level.var_56ed2a00, self.var_name))
	{
		if(self.var_name == "ray_gun" || self.var_name == "raygun_mark2" || self.var_name == "raygun_mark3" || self.var_name == "t9_gallo_raygun" || self.var_name == "t9_crossbow_skull" || self.var_name == "t6_xl_raygun_mark2")
		{
			return "wonder_high";
		}
		else
		{
			return "wonder_low";
		}
	}
	else
	{
		function_a6c913ff("Unknown weapon category for: " + self.var_name);
	}
	if(self.var_rootweapon.var_name == "ray_gun" || self.var_rootweapon.var_name == "ray_gun_up" || self.var_rootweapon.var_name == "raygun_mark2" || self.var_rootweapon.var_name == "raygun_mark3" || self.var_rootweapon.var_name == "t9_gallo_raygun" || self.var_rootweapon.var_name == "raygun_mark2_up" || self.var_rootweapon.var_name == "ray_gun_upgraded" || self.var_rootweapon.var_name == "raygun_mark2_upgraded" || self.var_rootweapon.var_name == "raygun_mark3_up" || self.var_rootweapon.var_name == "raygun_mark3_upgraded" || self.var_rootweapon.var_name == "t9_gallo_raygun_up" || self.var_rootweapon.var_name == "t7_microwavegundw" || self.var_rootweapon.var_name == "microwavegundw" || self.var_rootweapon.var_name == "t6_xl_slipgun" || self.var_rootweapon.var_name == "t8_shotgun_blundergat" || self.var_rootweapon.var_name == "t8_shotgun_acidgat" || self.var_rootweapon.var_name == "t8_shotgun_magmagat" || self.var_rootweapon.var_name == "t7_staff_air" || self.var_rootweapon.var_name == "t7_staff_fire" || self.var_rootweapon.var_name == "t7_staff_lightning" || self.var_rootweapon.var_name == "t7_staff_water" || self.var_rootweapon.var_name == "t7_hero_mirg2000" || self.var_rootweapon.var_name == "hero_mirg2000" || self.var_rootweapon.var_name == "t6_xl_slipgun_up" || self.var_rootweapon.var_name == "t7_staff_air_upgraded" || self.var_rootweapon.var_name == "t7_staff_fire_upgraded" || self.var_rootweapon.var_name == "t7_staff_lightning_upgraded" || self.var_rootweapon.var_name == "t7_staff_water_upgraded" || self.var_rootweapon.var_name == "t7_hero_mirg2000_upgraded" || self.var_rootweapon.var_name == "hero_mirg2000_upgraded" || self.var_rootweapon.var_name == "t8_shotgun_blundergat_upgraded" || self.var_rootweapon.var_name == "t8_shotgun_acidgat_upgraded" || self.var_rootweapon.var_name == "t8_shotgun_magmagat_upgraded" || self.var_rootweapon.var_name == "t7_shrink_ray_upgraded" || self.var_rootweapon.var_name == "t7_microwavegundw_upgraded" || self.var_rootweapon.var_name == "microwavegundw_upgraded")
	{
		return "wonder_high";
	}
	if(self.var_rootweapon.var_name == "thundergun" || self.var_rootweapon.var_name == "idgun_0" || self.var_rootweapon.var_name == "idgun_1" || self.var_rootweapon.var_name == "idgun_2" || self.var_rootweapon.var_name == "idgun_3" || self.var_rootweapon.var_name == "idgun_upgraded_0" || self.var_rootweapon.var_name == "idgun_upgraded_1" || self.var_rootweapon.var_name == "idgun_upgraded_2" || self.var_rootweapon.var_name == "idgun_upgraded_3" || self.var_rootweapon.var_name == "t7_idgun_genesis_0" || self.var_rootweapon.var_name == "t7_idgun_genesis_0_upgraded" || self.var_rootweapon.var_name == "shrink_ray" || self.var_rootweapon.var_name == "madgaz_cng_zm" || self.var_rootweapon.var_name == "madgaz_cng2_zm" || self.var_rootweapon.var_name == "madgaz_cng3_zm" || self.var_rootweapon.var_name == "tesla_gun" || self.var_rootweapon.var_name == "t9_crossbow_skull_up" || self.var_rootweapon.var_name == "idgun_genesis_0" || self.var_rootweapon.var_name == "idgun_genesis_0_upgraded" || self.var_rootweapon.var_name == "thundergun_upgraded" || self.var_rootweapon.var_name == "shrink_ray_upgraded" || self.var_rootweapon.var_name == "madgaz_cng_upgraded_zm" || self.var_rootweapon.var_name == "madgaz_cng2_upgraded_zm" || self.var_rootweapon.var_name == "madgaz_cng3_upgraded_zm" || self.var_rootweapon.var_name == "tesla_gun_upgraded" || self.var_rootweapon.var_name == "t9_crossbow_skull" || self.var_rootweapon.var_name == "t7_shrink_ray")
	{
		return "wonder_low";
	}
	if(self.var_weapClass == "shotgun")
	{
		return "shotgun";
	}
	else if(self.var_weapClass == "rifle")
	{
		return "ar";
	}
	else if(self.var_weapClass == "pistol")
	{
		return "smg";
	}
	else if(self.var_weapClass == "lmg")
	{
		return "lmg";
	}
	else if(self.var_weapClass == "launcher")
	{
		return "launcher";
	}
	else if(self.var_weapClass == "smg")
	{
		return "smg";
	}
	return "unknown";
}

/*
	Name: function_f85156b0
	Namespace: namespace_fdf6e22f
	Checksum: 0x424F4353
	Offset: 0x6780
	Size: 0x110
	Parameters: 1
	Flags: Private
	Line Number: 1566
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
	Name: function_9b1b417f
	Namespace: namespace_fdf6e22f
	Checksum: 0x424F4353
	Offset: 0x6898
	Size: 0x2D0
	Parameters: 1
	Flags: None
	Line Number: 1589
*/
function function_9b1b417f(var_d277f374)
{
	var_weapon_list = function_Array();
	switch(var_d277f374)
	{
		case 0:
		case 1:
		case 2:
		{
			var_weapon_list = function_ArrayCombine(var_weapon_list, level.var_ceb658e7, 0, 0);
			var_weapon_list = function_ArrayCombine(var_weapon_list, level.var_68e89529, 0, 0);
			var_weapon_list = function_ArrayCombine(var_weapon_list, level.var_181fb591, 0, 0);
			var_weapon_list = function_ArrayCombine(var_weapon_list, level.var_df1b28f2, 0, 0);
			var_weapon_list = function_ArrayCombine(var_weapon_list, level.var_45a59029, 0, 0);
			break;
		}
		case 3:
		{
			var_weapon_list = function_ArrayCombine(var_weapon_list, level.var_181fb591, 0, 0);
			var_weapon_list = function_ArrayCombine(var_weapon_list, level.var_df1b28f2, 0, 0);
			var_weapon_list = function_ArrayCombine(var_weapon_list, level.var_45a59029, 0, 0);
			var_weapon_list = function_ArrayCombine(var_weapon_list, level.var_268306a8, 0, 0);
			if(function_RandomInt(100) < 10)
			{
				var_weapon_list = function_ArrayCombine(var_weapon_list, level.var_db13261d, 0, 0);
				break;
			}
		}
		case 4:
		{
			if(function_RandomInt(100) < 90)
			{
				var_weapon_list = level.var_db13261d;
			}
			else
			{
				var_weapon_list = function_ArrayCombine(var_weapon_list, level.var_ceb658e7, 0, 0);
				var_weapon_list = function_ArrayCombine(var_weapon_list, level.var_df1b28f2, 0, 0);
				var_weapon_list = function_ArrayCombine(var_weapon_list, level.var_352bfdec, 0, 0);
				break;
			}
		}
	}
	return namespace_Array::function_random(var_weapon_list);
	ERROR: Exception occured: Stack empty.
}

/*
	Name: function_7a4f83ef
	Namespace: namespace_fdf6e22f
	Checksum: 0x424F4353
	Offset: 0x6B70
	Size: 0x2A0
	Parameters: 2
	Flags: None
	Line Number: 1646
*/
function function_7a4f83ef(var_64e56236, var_879a3bb)
{
	if(!isdefined(var_64e56236))
	{
		var_64e56236 = 1;
	}
	if(!isdefined(var_879a3bb))
	{
		var_879a3bb = undefined;
	}
	if(!isdefined(var_879a3bb) || var_879a3bb.size == 0)
	{
		var_879a3bb = function_Array(0, 1, 2, 3, 4);
	}
	var_6b763229 = function_d5ad13d3();
	var_rand = function_RandomInt(100);
	var_4ec67715 = [];
	foreach(var_d277f374 in var_879a3bb)
	{
		if(var_d277f374 <= var_6b763229)
		{
			var_4ec67715[var_4ec67715.size] = var_d277f374;
		}
	}
	if(var_4ec67715.size == 0)
	{
		return namespace_Array::function_random(var_879a3bb);
	}
	foreach(var_d277f374 in var_4ec67715)
	{
		switch(var_d277f374)
		{
			case 0:
			{
				if(var_rand < 30)
				{
					return 0;
					break;
				}
			}
			case 1:
			{
				if(var_rand < 60)
				{
					return 1;
					break;
				}
			}
			case 2:
			{
				if(var_rand < 80)
				{
					return 2;
					break;
				}
			}
			case 3:
			{
				if(var_rand < 95)
				{
					return 3;
					break;
				}
			}
			case 4:
			{
				return 4;
			}
		}
	}
	return namespace_Array::function_random(var_4ec67715);
}

/*
	Name: function_d5ad13d3
	Namespace: namespace_fdf6e22f
	Checksum: 0x424F4353
	Offset: 0x6E18
	Size: 0x58
	Parameters: 0
	Flags: None
	Line Number: 1729
*/
function function_d5ad13d3()
{
	var_round_number = level.var_round_number;
	if(var_round_number < 14)
	{
		return 1;
	}
	if(var_round_number < 20)
	{
		return 2;
	}
	if(var_round_number < 35)
	{
		return 3;
	}
	return 4;
}

/*
	Name: function_974521e5
	Namespace: namespace_fdf6e22f
	Checksum: 0x424F4353
	Offset: 0x6E78
	Size: 0x390
	Parameters: 1
	Flags: None
	Line Number: 1757
*/
function function_974521e5(var_d277f374)
{
	var_rand = function_RandomInt(100);
	switch(var_d277f374)
	{
		case 0:
		{
			if(var_rand < 15)
			{
				return "scrap";
			}
			else if(var_rand < 35)
			{
				return "cash";
			}
			else if(var_rand < 60)
			{
				return "ammo";
			}
			else if(var_rand < 65)
			{
				return "equipment";
			}
			else
			{
				return "weapon";
				break;
			}
		}
		case 1:
		{
			if(var_rand < 10)
			{
				return "scrap";
			}
			else if(var_rand < 30)
			{
				return "cash";
			}
			else if(var_rand < 55)
			{
				return "ammo";
			}
			else if(var_rand < 68)
			{
				return "equipment";
			}
			else if(var_rand < 75)
			{
				return "powerup";
			}
			else
			{
				return "weapon";
				break;
			}
		}
		case 2:
		{
			if(var_rand < 10)
			{
				return "scrap";
			}
			else if(var_rand < 45)
			{
				return "cash";
			}
			else if(var_rand < 65)
			{
				return "ammo";
			}
			else if(var_rand < 75)
			{
				return "equipment";
			}
			else if(var_rand < 80)
			{
				return "perk";
			}
			else if(var_rand < 85)
			{
				return "pack_a_punch";
			}
			else
			{
				return "weapon";
				break;
			}
		}
		case 3:
		{
			if(var_rand < 15)
			{
				return "scrap";
			}
			else if(var_rand < 40)
			{
				return "cash";
			}
			else if(var_rand < 55)
			{
				return "weapon";
			}
			else if(var_rand < 65)
			{
				return "ammo";
			}
			else if(var_rand < 75)
			{
				return "equipment";
			}
			else if(var_rand < 85)
			{
				return "perk";
			}
			else if(var_rand < 95)
			{
				return "pack_a_punch";
			}
			else
			{
				return "aat_mod";
				break;
			}
		}
		case 4:
		{
			if(var_rand < 10)
			{
				return "cash";
			}
			else if(var_rand < 40)
			{
				return "weapon";
			}
			else if(var_rand < 70)
			{
				return "perk";
			}
			else if(var_rand < 90)
			{
				return "pack_a_punch";
			}
			else
			{
				return "aat_mod";
				break;
			}
		}
		default
		{
			return "cash";
		}
	}
}

/*
	Name: function_bcd41008
	Namespace: namespace_fdf6e22f
	Checksum: 0x424F4353
	Offset: 0x7210
	Size: 0x168
	Parameters: 1
	Flags: Private
	Line Number: 1923
*/
function private function_bcd41008(var_e_attacker)
{
	if(!isdefined(var_e_attacker) || !function_isPlayer(var_e_attacker) || (isdefined(self.var_nuked) && self.var_nuked))
	{
		return;
	}
	if(!self function_99cadd10())
	{
		return;
	}
	if(function_RandomInt(100) >= 35)
	{
		return;
	}
	var_bd82c469 = function_RandomInt(100);
	if(var_bd82c469 < 33)
	{
		self thread function_671c2653(function_spawnstruct(), var_e_attacker, 0);
	}
	else if(var_bd82c469 < 66)
	{
		self thread function_cf9ee226(function_spawnstruct(), var_e_attacker, 0);
	}
	else
	{
		self thread function_41824d55(function_spawnstruct(), var_e_attacker, 0, function_randomIntRange(90, 150));
		return;
	}
	.var_0 = undefined;
}

/*
	Name: function_99cadd10
	Namespace: namespace_fdf6e22f
	Checksum: 0x424F4353
	Offset: 0x7380
	Size: 0x98
	Parameters: 0
	Flags: None
	Line Number: 1964
*/
function function_99cadd10()
{
	if(!isdefined(self))
	{
		return 0;
	}
	var_playable_area = function_GetEntArray("player_volume", "script_noteworthy");
	for(var_i = 0; var_i < var_playable_area.size; var_i++)
	{
		if(self function_istouching(var_playable_area[var_i]))
		{
			return 1;
			break;
		}
	}
	return 0;
}

/*
	Name: function_e1859039
	Namespace: namespace_fdf6e22f
	Checksum: 0x424F4353
	Offset: 0x7420
	Size: 0x120
	Parameters: 5
	Flags: None
	Line Number: 1992
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
}

/*
	Name: function_d02b4a40
	Namespace: namespace_fdf6e22f
	Checksum: 0x424F4353
	Offset: 0x7548
	Size: 0x178
	Parameters: 2
	Flags: None
	Line Number: 2034
*/
function function_d02b4a40(var_hint_string, var_radius)
{
	self endon("hash_death");
	self.var_trigger_use = function_spawn("trigger_radius_use", self.var_origin, 0, var_radius, var_radius);
	self.var_trigger_use function_TriggerIgnoreTeam();
	self.var_trigger_use function_SetVisibleToAll();
	self.var_trigger_use function_SetTeamForTrigger("none");
	self.var_trigger_use function_UseTriggerRequireLookAt();
	self.var_trigger_use function_setcursorhint("HINT_NOICON");
	self.var_trigger_use function_setHintString(var_hint_string);
	while(isdefined(self.var_trigger_use))
	{
		self.var_trigger_use waittill("hash_trigger", var_player);
		if(!namespace_zm_utility::function_is_player_valid(var_player) || var_player namespace_laststand::function_player_is_in_laststand())
		{
			continue;
		}
		self notify("hash_81c3a5c2", var_player);
		break;
	}
	return;
	waittillframeend;
}

/*
	Name: function_c71d30f1
	Namespace: namespace_fdf6e22f
	Checksum: 0x424F4353
	Offset: 0x76C8
	Size: 0x140
	Parameters: 2
	Flags: None
	Line Number: 2068
*/
function function_c71d30f1(var_hint_string, var_radius)
{
	self endon("hash_death");
	self.var_ba5e26d7 = function_spawn("trigger_radius", self.var_origin, 0, var_radius, var_radius);
	self.var_ba5e26d7 function_TriggerIgnoreTeam();
	self.var_ba5e26d7 function_SetVisibleToAll();
	self.var_ba5e26d7 function_SetTeamForTrigger("none");
	self.var_ba5e26d7 function_setcursorhint("HINT_NOICON");
	while(isdefined(self.var_ba5e26d7))
	{
		self.var_ba5e26d7 waittill("hash_trigger", var_player);
		if(!namespace_zm_utility::function_is_player_valid(var_player) || var_player namespace_laststand::function_player_is_in_laststand())
		{
			continue;
		}
		self notify("hash_81c3a5c2", var_player);
		break;
	}
	return;
}

/*
	Name: function_8fedabe9
	Namespace: namespace_fdf6e22f
	Checksum: 0x424F4353
	Offset: 0x7810
	Size: 0x78
	Parameters: 0
	Flags: None
	Line Number: 2099
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
	Namespace: namespace_fdf6e22f
	Checksum: 0x424F4353
	Offset: 0x7890
	Size: 0xE0
	Parameters: 1
	Flags: None
	Line Number: 2124
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
	Name: function_round_up_to_ten
	Namespace: namespace_fdf6e22f
	Checksum: 0x424F4353
	Offset: 0x7978
	Size: 0x50
	Parameters: 1
	Flags: None
	Line Number: 2164
*/
function function_round_up_to_ten(var_score)
{
	var_new_score = var_score - var_score % 10;
	if(var_new_score < var_score)
	{
		var_new_score = var_new_score + 10;
	}
	return var_new_score;
}

/*
	Name: function_37c5991e
	Namespace: namespace_fdf6e22f
	Checksum: 0x424F4353
	Offset: 0x79D0
	Size: 0x210
	Parameters: 0
	Flags: None
	Line Number: 2184
*/
function function_37c5991e()
{
	var_a_str_perks = function_getArrayKeys(level.var__custom_perks);
	var_PERKS = [];
	for(var_i = 0; var_i < var_a_str_perks.size; var_i++)
	{
		var_perk = var_a_str_perks[var_i];
		if(isdefined(self.var_perk_purchased) && self.var_perk_purchased == var_perk)
		{
			continue;
		}
		if(!self function_hasPerk(var_perk) && !self namespace_zm_perks::function_has_perk_paused(var_perk))
		{
			var_PERKS[var_PERKS.size] = var_perk;
		}
	}
	if(var_PERKS.size > 0)
	{
		var_PERKS = namespace_Array::function_randomize(var_PERKS);
		var_random_perk = var_PERKS[0];
	}
	else
	{
		var_PERKS = [];
		for(var_i = 0; var_i < var_a_str_perks.size; var_i++)
		{
			var_perk = var_a_str_perks[var_i];
			if(isdefined(self.var_perk_purchased) && self.var_perk_purchased == var_perk)
			{
				continue;
			}
			if(!self function_hasPerk(var_perk) && !self namespace_zm_perks::function_has_perk_paused(var_perk))
			{
				var_PERKS[var_PERKS.size] = var_perk;
			}
		}
		var_PERKS = namespace_Array::function_randomize(var_PERKS);
		var_random_perk = var_PERKS[0];
	}
	return var_random_perk;
}

/*
	Name: function_2d5500a6
	Namespace: namespace_fdf6e22f
	Checksum: 0x424F4353
	Offset: 0x7BE8
	Size: 0x1D8
	Parameters: 0
	Flags: None
	Line Number: 2236
*/
function function_2d5500a6()
{
	level.var_func_override_wallbuy_prompt = &function_f431efcb;
	level thread function_delete_triggers();
	level thread function_92ffc93e();
	for(;;)
	{
		level.var_fd6c66c2 = 0;
		level.var_8c94e755 = 1;
		level namespace_flag::function_clear("zombie_drop_powerups");
		namespace_zombie_utility::function_set_zombie_var("zombie_score_kill_4player", 10);
		namespace_zombie_utility::function_set_zombie_var("zombie_score_kill_3player", 10);
		namespace_zombie_utility::function_set_zombie_var("zombie_score_kill_2player", 10);
		namespace_zombie_utility::function_set_zombie_var("zombie_score_kill_1player", 10);
		namespace_zombie_utility::function_set_zombie_var("zombie_score_damage_normal", 0);
		namespace_zombie_utility::function_set_zombie_var("zombie_score_damage_light", 0);
		namespace_zombie_utility::function_set_zombie_var("zombie_score_bonus_melee", 10);
		namespace_zombie_utility::function_set_zombie_var("zombie_score_bonus_head", 10);
		namespace_zombie_utility::function_set_zombie_var("zombie_score_bonus_neck", 10);
		namespace_zombie_utility::function_set_zombie_var("zombie_score_bonus_torso", 10);
		namespace_zombie_utility::function_set_zombie_var("zombie_score_bonus_burn", 0);
		wait(4);
	}
}

/*
	Name: function_c2bf8a3e
	Namespace: namespace_fdf6e22f
	Checksum: 0x424F4353
	Offset: 0x7DC8
	Size: 0x30
	Parameters: 0
	Flags: None
	Line Number: 2271
*/
function function_c2bf8a3e()
{
	self endon("hash_disconnect");
	var_total_time = 0;
	for(;;)
	{
		wait(1);
		var_total_time++;
	}
}

/*
	Name: function_65e33f30
	Namespace: namespace_fdf6e22f
	Checksum: 0x424F4353
	Offset: 0x7E00
	Size: 0x30
	Parameters: 0
	Flags: None
	Line Number: 2292
*/
function function_65e33f30()
{
	self endon("hash_disconnect");
	self.var_loot = [];
	self.var_loot["scrap"] = 0;
	return;
	~self.var_loot["scrap"];
}

/*
	Name: function_13f2da08
	Namespace: namespace_fdf6e22f
	Checksum: 0x424F4353
	Offset: 0x7E38
	Size: 0x38
	Parameters: 1
	Flags: None
	Line Number: 2311
*/
function function_13f2da08(var_d3d8af77)
{
	self.var_loot["scrap"] = self.var_loot["scrap"] + var_d3d8af77;
}

/*
	Name: function_997c5779
	Namespace: namespace_fdf6e22f
	Checksum: 0x424F4353
	Offset: 0x7E78
	Size: 0x38
	Parameters: 1
	Flags: None
	Line Number: 2326
*/
function function_997c5779(var_a05e4c59)
{
	self.var_loot["scrap"] = self.var_loot["scrap"] - var_a05e4c59;
}

/*
	Name: function_on_player_spawned
	Namespace: namespace_fdf6e22f
	Checksum: 0x424F4353
	Offset: 0x7EB8
	Size: 0x400
	Parameters: 0
	Flags: None
	Line Number: 2341
*/
function function_on_player_spawned()
{
	if(!isdefined(self.var_d79f52bf))
	{
		self.var_d79f52bf = [];
	}
	self.var_d79f52bf["smg"] = function_spawnstruct();
	self.var_d79f52bf["smg"].var_b3d53eb1 = 440;
	self.var_d79f52bf["smg"].var_stock = 0;
	self.var_d79f52bf["smg"].var_d3d8af77 = 28;
	self.var_d79f52bf["ar"] = function_spawnstruct();
	self.var_d79f52bf["ar"].var_b3d53eb1 = 600;
	self.var_d79f52bf["ar"].var_stock = 0;
	self.var_d79f52bf["ar"].var_d3d8af77 = 24;
	self.var_d79f52bf["shotgun"] = function_spawnstruct();
	self.var_d79f52bf["shotgun"].var_b3d53eb1 = 160;
	self.var_d79f52bf["shotgun"].var_stock = 0;
	self.var_d79f52bf["shotgun"].var_d3d8af77 = 8;
	self.var_d79f52bf["sniper"] = function_spawnstruct();
	self.var_d79f52bf["sniper"].var_b3d53eb1 = 110;
	self.var_d79f52bf["sniper"].var_stock = 0;
	self.var_d79f52bf["sniper"].var_d3d8af77 = 10;
	self.var_d79f52bf["launcher"] = function_spawnstruct();
	self.var_d79f52bf["launcher"].var_b3d53eb1 = 18;
	self.var_d79f52bf["launcher"].var_stock = 0;
	self.var_d79f52bf["launcher"].var_d3d8af77 = 2;
	self.var_d79f52bf["wonder_high"] = function_spawnstruct();
	self.var_d79f52bf["wonder_high"].var_b3d53eb1 = 160;
	self.var_d79f52bf["wonder_high"].var_stock = 0;
	self.var_d79f52bf["wonder_high"].var_d3d8af77 = 10;
	self.var_d79f52bf["wonder_low"] = function_spawnstruct();
	self.var_d79f52bf["wonder_low"].var_b3d53eb1 = 30;
	self.var_d79f52bf["wonder_low"].var_stock = 0;
	self.var_d79f52bf["wonder_low"].var_d3d8af77 = 4;
	self thread function_86dbdcfa();
	self thread function_5129dd11();
}

/*
	Name: function_7c33c3ad
	Namespace: namespace_fdf6e22f
	Checksum: 0x424F4353
	Offset: 0x82C0
	Size: 0x198
	Parameters: 3
	Flags: None
	Line Number: 2389
*/
function function_7c33c3ad(var_type, var_d3d8af77, var_current_weapon)
{
	if(!isdefined(var_type))
	{
		function_iprintln("No Type Defined");
	}
	if(!isdefined(var_d3d8af77))
	{
		function_iprintln("No increase_by Defined");
	}
	self.var_d79f52bf[var_type].var_stock = self.var_d79f52bf[var_type].var_stock + var_d3d8af77;
	wait(0.05);
	if(!isdefined(var_current_weapon) || var_current_weapon == level.var_weaponNone)
	{
		function_iprintln("No Weapon Defined!");
	}
	if(isdefined(var_current_weapon))
	{
		var_weapon_type = var_current_weapon function_6bf2aeab();
		if(isdefined(self.var_d79f52bf[var_weapon_type]))
		{
			var_5199ca37 = self.var_d79f52bf[var_weapon_type].var_stock;
			var_82389a62 = self.var_d79f52bf[var_weapon_type].var_b3d53eb1;
			var_e332d618 = function_min(var_5199ca37, var_82389a62);
			self function_SetWeaponAmmoStock(var_current_weapon, var_e332d618);
		}
	}
}

/*
	Name: function_2791ccdb
	Namespace: namespace_fdf6e22f
	Checksum: 0x424F4353
	Offset: 0x8460
	Size: 0x88
	Parameters: 2
	Flags: None
	Line Number: 2428
*/
function function_2791ccdb(var_type, var_a05e4c59)
{
	if(!isdefined(var_type))
	{
		function_iprintln("No Type Defined");
	}
	if(!isdefined(var_a05e4c59))
	{
		function_iprintln("No increase_by Defined");
	}
	self.var_d79f52bf[var_type].var_stock = self.var_d79f52bf[var_type].var_stock - var_a05e4c59;
}

/*
	Name: function_86dbdcfa
	Namespace: namespace_fdf6e22f
	Checksum: 0x424F4353
	Offset: 0x84F0
	Size: 0x4E0
	Parameters: 0
	Flags: None
	Line Number: 2451
*/
function function_86dbdcfa()
{
	self endon("hash_bled_out");
	self endon("hash_spawned_player");
	self endon("hash_disconnect");
	for(;;)
	{
		self waittill("hash_weapon_change", var_newWeapon, var_oldWeapon);
		if(!isdefined(var_newWeapon) || var_newWeapon == level.var_weaponNone)
		{
		}
		else if(namespace_Array::function_contains(level.var_68e89529, var_newWeapon.var_name))
		{
			self function_SetWeaponAmmoStock(var_newWeapon, self.var_d79f52bf["smg"].var_stock);
			function_a6c913ff("New Weapon; Set to SMG Stock");
		}
		else if(namespace_Array::function_contains(level.var_ceb658e7, var_newWeapon.var_name))
		{
			self function_SetWeaponAmmoStock(var_newWeapon, self.var_d79f52bf["smg"].var_stock);
			function_a6c913ff("New Weapon; Set to SMG Stock");
		}
		else if(namespace_Array::function_contains(level.var_181fb591, var_newWeapon.var_name))
		{
			self function_SetWeaponAmmoStock(var_newWeapon, self.var_d79f52bf["ar"].var_stock);
			function_a6c913ff("New Weapon; Set to AR Stock");
		}
		else if(namespace_Array::function_contains(level.var_45a59029, var_newWeapon.var_name))
		{
			self function_SetWeaponAmmoStock(var_newWeapon, self.var_d79f52bf["sniper"].var_stock);
			function_a6c913ff("New Weapon; Set to Sniper Stock");
		}
		else if(namespace_Array::function_contains(level.var_df1b28f2, var_newWeapon.var_name))
		{
			self function_SetWeaponAmmoStock(var_newWeapon, self.var_d79f52bf["shotgun"].var_stock);
		}
		else if(namespace_Array::function_contains(level.var_e0580f08, var_newWeapon.var_name))
		{
			self function_SetWeaponAmmoStock(var_newWeapon, self.var_d79f52bf["ar"].var_stock);
		}
		else if(namespace_Array::function_contains(level.var_268306a8, var_newWeapon.var_name))
		{
			self function_SetWeaponAmmoStock(var_newWeapon, self.var_d79f52bf["launcher"].var_stock);
		}
		else if(namespace_Array::function_contains(level.var_56ed2a00, var_newWeapon.var_name))
		{
			if(var_newWeapon == "ray_gun" || var_newWeapon == "raygun_mark2" || var_newWeapon == "raygun_mark3" || var_newWeapon == "t9_gallo_raygun" || var_newWeapon == "t9_crossbow_skull" || var_newWeapon == "t6_xl_raygun_mark2")
			{
				self function_SetWeaponAmmoStock(var_newWeapon, self.var_d79f52bf["wonder_high"].var_stock);
			}
			else
			{
				self function_SetWeaponAmmoStock(var_newWeapon, self.var_d79f52bf["wonder_low"].var_stock);
			}
		}
		else
		{
			function_a6c913ff("Unknown weapon category for: " + var_newWeapon.var_displayName);
		}
		function_a6c913ff("Updated ammo stock for " + var_newWeapon.var_displayName + " to " + self function_GetWeaponAmmoStock(var_newWeapon));
	}
}

/*
	Name: function_5129dd11
	Namespace: namespace_fdf6e22f
	Checksum: 0x424F4353
	Offset: 0x89D8
	Size: 0x4E0
	Parameters: 0
	Flags: None
	Line Number: 2523
*/
function function_5129dd11()
{
	self endon("hash_bled_out");
	self endon("hash_spawned_player");
	self endon("hash_disconnect");
	for(;;)
	{
		self waittill("hash_reload");
		var_current_weapon = self function_GetCurrentWeapon();
		if(!isdefined(var_current_weapon) || var_current_weapon == level.var_weaponNone)
		{
		}
		else if(namespace_Array::function_contains(level.var_68e89529, var_current_weapon.var_name))
		{
			self.var_d79f52bf["smg"].var_stock = self function_GetWeaponAmmoStock(var_current_weapon);
			function_a6c913ff("Weapon is Pistol, SMG, reloaded");
		}
		else if(namespace_Array::function_contains(level.var_ceb658e7, var_current_weapon.var_name))
		{
			self.var_d79f52bf["smg"].var_stock = self function_GetWeaponAmmoStock(var_current_weapon);
			function_a6c913ff("Weapon is SMG, reloaded");
		}
		else if(namespace_Array::function_contains(level.var_181fb591, var_current_weapon.var_name))
		{
			self.var_d79f52bf["ar"].var_stock = self function_GetWeaponAmmoStock(var_current_weapon);
			function_a6c913ff("Weapon is AR, reloaded");
		}
		else if(namespace_Array::function_contains(level.var_45a59029, var_current_weapon.var_name))
		{
			self.var_d79f52bf["sniper"].var_stock = self function_GetWeaponAmmoStock(var_current_weapon);
			function_a6c913ff("Weapon is SNIPER, reloaded");
		}
		else if(namespace_Array::function_contains(level.var_df1b28f2, var_current_weapon.var_name))
		{
			self.var_d79f52bf["shotgun"].var_stock = self function_GetWeaponAmmoStock(var_current_weapon);
		}
		else if(namespace_Array::function_contains(level.var_e0580f08, var_current_weapon.var_name))
		{
			self.var_d79f52bf["ar"].var_stock = self function_GetWeaponAmmoStock(var_current_weapon);
		}
		else if(namespace_Array::function_contains(level.var_268306a8, var_current_weapon.var_name))
		{
			self.var_d79f52bf["launcher"].var_stock = self function_GetWeaponAmmoStock(var_current_weapon);
		}
		else if(namespace_Array::function_contains(level.var_56ed2a00, var_current_weapon.var_name))
		{
			if(var_current_weapon.var_name == "ray_gun" || var_current_weapon.var_name == "raygun_mark2" || var_current_weapon.var_name == "raygun_mark3" || var_current_weapon.var_name == "t9_gallo_raygun" || var_current_weapon.var_name == "t9_crossbow_skull" || var_current_weapon.var_name == "t6_xl_raygun_mark2")
			{
				self.var_d79f52bf["wonder_high"].var_stock = self function_GetWeaponAmmoStock(var_current_weapon);
			}
			else
			{
				self.var_d79f52bf["wonder_low"].var_stock = self function_GetWeaponAmmoStock(var_current_weapon);
			}
		}
		else
		{
			function_a6c913ff("Unknown weapon category for: " + var_current_weapon.var_name);
		}
	}
}

/*
	Name: function_f431efcb
	Namespace: namespace_fdf6e22f
	Checksum: 0x424F4353
	Offset: 0x8EC0
	Size: 0x40
	Parameters: 1
	Flags: None
	Line Number: 2595
*/
function function_f431efcb(var_player)
{
	self.var_stub.var_hint_string = "Guns cannot be bought during Loot Mode";
	self.var_stub.var_cursor_hint = "HINT_NOICON";
	return 0;
}

/*
	Name: function_delete_triggers
	Namespace: namespace_fdf6e22f
	Checksum: 0x424F4353
	Offset: 0x8F08
	Size: 0x138
	Parameters: 0
	Flags: None
	Line Number: 2612
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
}

/*
	Name: function_aa0c5645
	Namespace: namespace_fdf6e22f
	Checksum: 0x424F4353
	Offset: 0x9048
	Size: 0x318
	Parameters: 3
	Flags: None
	Line Number: 2635
*/
function function_aa0c5645(var_hint_string, var_radius, var_8dbb9cda)
{
	self endon("hash_death");
	self.var_trigger_use = function_spawn("trigger_radius_use", self.var_origin, 0, var_radius, var_radius);
	self.var_trigger_use function_TriggerIgnoreTeam();
	self.var_trigger_use function_SetVisibleToAll();
	self.var_trigger_use function_SetTeamForTrigger("none");
	self.var_trigger_use function_UseTriggerRequireLookAt();
	self.var_trigger_use function_setcursorhint("HINT_NOICON");
	self.var_trigger_use function_setHintString(var_hint_string);
	while(isdefined(self.var_trigger_use))
	{
		self.var_trigger_use waittill("hash_trigger", var_player);
		if(!namespace_zm_utility::function_is_player_valid(var_player) || var_player namespace_laststand::function_player_is_in_laststand())
		{
			continue;
		}
		var_current_weapon = var_player function_GetCurrentWeapon();
		if(var_current_weapon.var_isRiotShield && (var_current_weapon == level.var_zombie_powerup_weapon["minigun"] || namespace_zm_utility::function_is_hero_weapon(var_current_weapon) || var_current_weapon.var_name == "none" || var_current_weapon.var_name == "zombie_bgb_grab" || var_current_weapon.var_name == "zombie_bgb_use" || var_current_weapon.var_name == "zombie_beast_grapple_dwr" || var_current_weapon.var_name == "staff_revive"))
		{
			continue;
		}
		if(!(isdefined(var_player function_f85156b0(var_current_weapon)) && var_player function_f85156b0(var_current_weapon)))
		{
			continue;
		}
		if(var_player.var_d79f52bf[var_8dbb9cda].var_stock + var_player.var_d79f52bf[var_8dbb9cda].var_d3d8af77 >= var_player.var_d79f52bf[var_8dbb9cda].var_b3d53eb1)
		{
			continue;
		}
		self notify("hash_81c3a5c2", var_player);
		break;
	}
}

/*
	Name: function_1051b116
	Namespace: namespace_fdf6e22f
	Checksum: 0x424F4353
	Offset: 0x9368
	Size: 0x2E0
	Parameters: 3
	Flags: None
	Line Number: 2680
*/
function function_1051b116(var_hint_string, var_radius, var_8dbb9cda)
{
	self endon("hash_death");
	self.var_ba5e26d7 = function_spawn("trigger_radius", self.var_origin, 0, var_radius, var_radius);
	self.var_ba5e26d7 function_TriggerIgnoreTeam();
	self.var_ba5e26d7 function_SetVisibleToAll();
	self.var_ba5e26d7 function_SetTeamForTrigger("none");
	self.var_ba5e26d7 function_setcursorhint("HINT_NOICON");
	while(isdefined(self.var_ba5e26d7))
	{
		self.var_ba5e26d7 waittill("hash_trigger", var_player);
		if(!namespace_zm_utility::function_is_player_valid(var_player) || var_player namespace_laststand::function_player_is_in_laststand())
		{
			continue;
		}
		var_current_weapon = var_player function_GetCurrentWeapon();
		if(var_current_weapon.var_isRiotShield && (var_current_weapon == level.var_zombie_powerup_weapon["minigun"] || namespace_zm_utility::function_is_hero_weapon(var_current_weapon) || var_current_weapon.var_name == "none" || var_current_weapon.var_name == "zombie_bgb_grab" || var_current_weapon.var_name == "zombie_bgb_use" || var_current_weapon.var_name == "zombie_beast_grapple_dwr" || var_current_weapon.var_name == "staff_revive"))
		{
			continue;
		}
		if(!(isdefined(var_player function_f85156b0(var_current_weapon)) && var_player function_f85156b0(var_current_weapon)))
		{
			continue;
		}
		if(var_player.var_d79f52bf[var_8dbb9cda].var_stock + var_player.var_d79f52bf[var_8dbb9cda].var_d3d8af77 >= var_player.var_d79f52bf[var_8dbb9cda].var_b3d53eb1)
		{
			continue;
		}
		self notify("hash_81c3a5c2", var_player);
		break;
	}
}

/*
	Name: function_92ffc93e
	Namespace: namespace_fdf6e22f
	Checksum: 0x424F4353
	Offset: 0x9650
	Size: 0x3B0
	Parameters: 0
	Flags: None
	Line Number: 2723
*/
function function_92ffc93e()
{
	wait(5);
	level namespace_flag::function_set("power_on");
	level namespace_clientfield::function_set("zombie_power_on", 0);
	var_power_trigs = function_GetEntArray("use_elec_switch", "targetname");
	foreach(var_trig in var_power_trigs)
	{
		if(isdefined(var_trig.var_script_int))
		{
			level namespace_flag::function_set("power_on" + var_trig.var_script_int);
			level namespace_clientfield::function_set("zombie_power_on", var_trig.var_script_int);
		}
	}
	var_zombie_doors = function_GetEntArray("zombie_door", "targetname");
	for(var_i = 0; var_i < 15; var_i++)
	{
		if(var_zombie_doors[var_i].var_zombie_cost <= 4000 && (!(isdefined(var_zombie_doors[var_i].var_has_been_opened) && var_zombie_doors[var_i].var_has_been_opened)))
		{
			var_zombie_doors[var_i] notify("hash_trigger", undefined, 1);
		}
		if(isdefined(var_zombie_doors[var_i].var_power_door_ignore_flag_wait) && var_zombie_doors[var_i].var_power_door_ignore_flag_wait)
		{
			var_zombie_doors[var_i] notify("hash_power_on");
		}
		wait(0.05);
	}
	var_zombie_airlock_doors = function_GetEntArray("zombie_airlock_buy", "targetname");
	for(var_i = 0; var_i < var_zombie_airlock_doors.size; var_i++)
	{
		if(!(isdefined(var_zombie_airlock_doors[var_i].var_has_been_opened) && var_zombie_airlock_doors[var_i].var_has_been_opened))
		{
			var_zombie_airlock_doors[var_i] notify("hash_trigger", undefined, 1);
		}
		wait(0.05);
	}
	var_zombie_debris = function_GetEntArray("zombie_debris", "targetname");
	for(var_i = 0; var_i < var_zombie_debris.size; var_i++)
	{
		if(isdefined(var_zombie_debris[var_i]) && (!(isdefined(var_zombie_debris[var_i].var_has_been_opened) && var_zombie_debris[var_i].var_has_been_opened)))
		{
			var_zombie_debris[var_i] notify("hash_trigger", undefined, 1);
		}
		wait(0.05);
	}
	level notify("hash_open_sesame");
}

/*
	Name: function_a6c913ff
	Namespace: namespace_fdf6e22f
	Checksum: 0x424F4353
	Offset: 0x9A08
	Size: 0x38
	Parameters: 1
	Flags: None
	Line Number: 2781
*/
function function_a6c913ff(var_message)
{
	if(0)
	{
		function_iprintln("^8[Loot Mode]^7 " + var_message);
	}
}

/*
	Name: function_f2554709
	Namespace: namespace_fdf6e22f
	Checksum: 0x424F4353
	Offset: 0x9A48
	Size: 0x1204
	Parameters: 1
	Flags: None
	Line Number: 2799
*/
function function_f2554709(var_34d37a48)
{
	if(isdefined(var_34d37a48["player"]))
	{
		switch(var_34d37a48["value"][0])
		{
			case "spawn":
			{
				switch(var_34d37a48["value"][1])
				{
					case "cash":
					{
						for(var_i = 0; var_i < function_Int(var_34d37a48["value"][2]); var_i++)
						{
							if(isdefined(var_34d37a48["value"][3]))
							{
								if(isdefined(var_34d37a48["value"][4]))
								{
									var_34d37a48["player"] thread function_41824d55(function_spawnstruct(), var_34d37a48["player"], var_34d37a48["value"][3], var_34d37a48["value"][4]);
								}
								else
								{
									var_34d37a48["player"] thread function_41824d55(function_spawnstruct(), var_34d37a48["player"], var_34d37a48["value"][3]);
									continue;
								}
							}
							var_34d37a48["player"] thread function_41824d55(function_spawnstruct(), var_34d37a48["player"], function_randomIntRange(0, 4));
						}
						break;
					}
					case "ammo":
					{
						for(var_i = 0; var_i < function_Int(var_34d37a48["value"][2]); var_i++)
						{
							var_34d37a48["player"] thread function_cf9ee226(function_spawnstruct(), var_34d37a48["player"]);
						}
						break;
					}
					case "scrap":
					{
						for(var_i = 0; var_i < function_Int(var_34d37a48["value"][2]); var_i++)
						{
							if(isdefined(var_34d37a48["value"][3]))
							{
								var_34d37a48["player"] thread function_671c2653(function_spawnstruct(), var_34d37a48["player"], var_34d37a48["value"][3]);
								continue;
							}
							var_34d37a48["player"] thread function_671c2653(function_spawnstruct(), var_34d37a48["player"], 0);
						}
						break;
					}
					case "weapon":
					{
						for(var_i = 0; var_i < function_Int(var_34d37a48["value"][2]); var_i++)
						{
							if(isdefined(var_34d37a48["value"][3]))
							{
								if(isdefined(var_34d37a48["value"][4]))
								{
									var_34d37a48["player"] thread function_2568f790(function_spawnstruct(), var_34d37a48["player"], var_34d37a48["value"][3], var_34d37a48["value"][4]);
								}
								else
								{
									var_34d37a48["player"] thread function_2568f790(function_spawnstruct(), var_34d37a48["player"], 0, var_34d37a48["value"][4]);
									continue;
								}
							}
							var_34d37a48["player"] thread function_2568f790(function_spawnstruct(), var_34d37a48["player"], 0);
						}
						break;
					}
					case "equipment":
					{
						for(var_i = 0; var_i < function_Int(var_34d37a48["value"][2]); var_i++)
						{
							var_34d37a48["player"] thread function_93c607c4(function_spawnstruct(), var_34d37a48["player"]);
						}
						break;
					}
					case "perk":
					{
						for(var_i = 0; var_i < function_Int(var_34d37a48["value"][2]); var_i++)
						{
							if(isdefined(var_34d37a48["value"][3]))
							{
								var_34d37a48["player"] thread function_db4f9348(function_spawnstruct(), var_34d37a48["player"], var_34d37a48["value"][4]);
								continue;
							}
							var_34d37a48["player"] thread function_db4f9348(function_spawnstruct(), var_34d37a48["player"]);
						}
						break;
					}
					case "crate":
					{
						var_d419d1ab = function_spawnstruct();
						var_d419d1ab.var_origin = var_34d37a48["player"].var_origin;
						var_d419d1ab.var_angles = var_34d37a48["player"].var_angles;
						var_d419d1ab.var_type = "crate";
						if(isdefined(var_34d37a48["value"][2]))
						{
							var_tokenize = function_StrTok(var_34d37a48["value"][2], ",");
							if(var_tokenize.size > 1)
							{
								var_2f4801e4 = function_Array();
								foreach(var_token in var_tokenize)
								{
									function_ArrayInsert(var_2f4801e4, function_Int(var_token), var_2f4801e4.size);
								}
							}
							else
							{
								var_2f4801e4 = function_Array(function_Int(var_34d37a48["value"][2]));
							}
						}
						else
						{
							var_2f4801e4 = function_Array(0, 1, 2, 3, 4);
						}
						if(isdefined(var_34d37a48["value"][3]))
						{
							var_tokenize = function_StrTok(var_34d37a48["value"][3], ",");
							if(var_tokenize.size > 1)
							{
								var_384a40cb = function_Array();
								foreach(var_token in var_tokenize)
								{
									function_ArrayInsert(var_384a40cb, var_token, var_384a40cb.size);
								}
							}
							else
							{
								var_384a40cb = function_Array(var_34d37a48["value"][3]);
							}
						}
						else
						{
							var_384a40cb = function_Array("cash", "ammo", "scrap", "weapon", "perk", "equipment", "pack_a_punch", "powerup", "aat_mod");
						}
						var_d419d1ab thread function_3bae6a6b("zmu_loot_crate", "loot_crate_open", "Hold ^3&&1^7 to Open Loot Crate", "loot_crate_cache_ambient", "loot_crate_cache_open", "loot_crate_cache_open_legendary", 0, var_384a40cb, var_2f4801e4);
						break;
					}
					case "locker":
					{
						var_1dca780a = function_spawnstruct();
						var_1dca780a.var_origin = var_34d37a48["player"].var_origin;
						var_1dca780a.var_angles = var_34d37a48["player"].var_angles;
						var_1dca780a.var_type = "locker";
						if(isdefined(var_34d37a48["value"][2]))
						{
							var_tokenize = function_StrTok(var_34d37a48["value"][2], ",");
							if(var_tokenize.size > 1)
							{
								var_2f4801e4 = function_Array();
								foreach(var_token in var_tokenize)
								{
									function_ArrayInsert(var_2f4801e4, function_Int(var_token), var_2f4801e4.size);
								}
							}
							else
							{
								var_2f4801e4 = function_Array(function_Int(var_34d37a48["value"][2]));
							}
						}
						else
						{
							var_2f4801e4 = function_Array(0, 1, 2);
						}
						if(isdefined(var_34d37a48["value"][3]))
						{
							var_tokenize = function_StrTok(var_34d37a48["value"][3], ",");
							if(var_tokenize.size > 1)
							{
								var_384a40cb = function_Array();
								foreach(var_token in var_tokenize)
								{
									function_ArrayInsert(var_384a40cb, var_token, var_384a40cb.size);
								}
							}
							else
							{
								var_384a40cb = function_Array(var_34d37a48["value"][3]);
							}
						}
						else
						{
							var_384a40cb = function_Array("cash", "ammo", "weapon", "perk");
						}
						var_1dca780a thread function_3bae6a6b("zmu_loot_locker", "loot_locker_open", "Hold ^3&&1^7 to Open Locker", undefined, undefined, undefined, 0, var_384a40cb, var_2f4801e4);
						break;
					}
					case "ammobox":
					{
						var_ea78f13c = function_spawnstruct();
						var_ea78f13c.var_origin = var_34d37a48["player"].var_origin;
						var_ea78f13c.var_angles = var_34d37a48["player"].var_angles;
						var_ea78f13c.var_type = "ammo";
						if(isdefined(var_34d37a48["value"][2]))
						{
							var_tokenize = function_StrTok(var_34d37a48["value"][2], ",");
							if(var_tokenize.size > 1)
							{
								var_2f4801e4 = function_Array();
								foreach(var_token in var_tokenize)
								{
									function_ArrayInsert(var_2f4801e4, function_Int(var_token), var_2f4801e4.size);
								}
							}
							else
							{
								var_2f4801e4 = function_Array(function_Int(var_34d37a48["value"][2]));
							}
						}
						else
						{
							var_2f4801e4 = function_Array(0);
						}
						if(isdefined(var_34d37a48["value"][3]))
						{
							var_tokenize = function_StrTok(var_34d37a48["value"][3], ",");
							if(var_tokenize.size > 1)
							{
								var_384a40cb = function_Array();
								foreach(var_token in var_tokenize)
								{
									function_ArrayInsert(var_384a40cb, var_token, var_384a40cb.size);
								}
							}
							else
							{
								var_384a40cb = function_Array(var_34d37a48["value"][3]);
							}
						}
						else
						{
							var_384a40cb = function_Array("ammo", "equipment");
						}
						var_ea78f13c thread function_3bae6a6b("zmu_loot_ammo", "loot_ammo_open", "Hold ^3&&1^7 to Open Ammo Supply", undefined, undefined, undefined, 0, var_384a40cb, var_2f4801e4);
						break;
					}
					case "force_spawn":
					{
						level thread function_f834b889();
						break;
					}
				}
			}
			default
			{
				namespace_b2e35c83::function_957b7937("Add parameters {spawn} {type}");
			}
		}
	}
	else
	{
		namespace_b2e35c83::function_957b7937("Player does not exist");
	}
}

