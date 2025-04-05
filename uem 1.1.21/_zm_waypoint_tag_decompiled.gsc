#include scripts\codescripts\struct;
#include scripts\shared\array_shared;
#include scripts\shared\callbacks_shared;
#include scripts\shared\clientfield_shared;
#include scripts\shared\flag_shared;
#include scripts\shared\gameobjects_shared;
#include scripts\shared\math_shared;
#include scripts\shared\objpoints_shared;
#include scripts\shared\system_shared;
#include scripts\shared\util_shared;
#include scripts\zm\_zm;
#include scripts\zm\_zm_equipment;
#include scripts\zm\_zm_powerups;
#include scripts\zm\_zm_utility;
#include scripts\zm\_zm_weapons;

#namespace namespace_d747dc75;

/*
	Name: function___init__sytem__
	Namespace: namespace_d747dc75
	Checksum: 0x424F4353
	Offset: 0xD80
	Size: 0x38
	Parameters: 0
	Flags: AutoExec
	Line Number: 28
*/
function autoexec function___init__sytem__()
{
	namespace_system::function_register("zm_waypoint_tag", &function___init__, undefined, undefined);
	return;
	ERROR: Bad function call
}

/*
	Name: function___init__
	Namespace: namespace_d747dc75
	Checksum: 0x424F4353
	Offset: 0xDC0
	Size: 0x28
	Parameters: 0
	Flags: None
	Line Number: 45
*/
function function___init__()
{
	namespace_callback::function_on_spawned(&function_on_player_spawned);
}

/*
	Name: function_cf03d3ae
	Namespace: namespace_d747dc75
	Checksum: 0x424F4353
	Offset: 0xDF0
	Size: 0x70
	Parameters: 0
	Flags: None
	Line Number: 60
*/
function function_cf03d3ae()
{
System.InvalidOperationException: Stack empty.
   at System.ThrowHelper.ThrowInvalidOperationException(ExceptionResource resource)
   at System.Collections.Generic.Stack`1.Pop()
   at Cerberus.Logic.Decompiler.BuildCondition(Int32 startIndex)
   at Cerberus.Logic.Decompiler.FindIfStatements()
   at Cerberus.Logic.Decompiler..ctor(ScriptExport function, ScriptBase script)
}

/*
	Name: function_on_player_spawned
	Namespace: namespace_d747dc75
	Checksum: 0x424F4353
	Offset: 0xE68
	Size: 0x14A8
	Parameters: 0
	Flags: None
	Line Number: 80
*/
function function_on_player_spawned()
{
	self endon("hash_disconnect");
	wait(0.05);
	level namespace_flag::function_wait_till("initial_blackscreen_passed");
	self.var_f4d01b67["ping_keybind"] = function_Int(0);
	self thread namespace_zm_equipment::function_show_hint_text(&"ZM_MINECRAFT_PING_SYSTEM_HOW_TO", 10);
	while(self function_ActionSlotThreeButtonPressed() && self.var_f4d01b67["ping_keybind"] == 0)
	{
		wait(0.05);
		var_c963c671 = 0;
		var_c963c671 = self function_cf03d3ae();
		if(isdefined(self.var_4a1d4e18))
		{
			function_objective_delete(self.var_4a1d4e18);
			self notify("hash_740302d5");
			if(isdefined(self.var_c3714669))
			{
				if(function_ToLower(function_GetDvarString("mapname")) != "zm_castle")
				{
					self.var_c3714669 namespace_clientfield::function_set("weapon_drop_level_enable_keyline", 0);
				}
				else
				{
					self.var_c3714669 namespace_clientfield::function_set("weapon_drop_enable_keyline", 0);
				}
			}
		}
		wait(0.05);
		var_start = self function_GetWeaponMuzzlePoint();
		var_forward_dir = self function_GetWeaponForwardDir();
		var_end = var_start + var_forward_dir * 20000;
		var_player_angles = self function_getPlayerAngles();
		var_forward_vec = function_AnglesToForward((0, var_player_angles[1], 0));
		var_forward_right_45_vec = function_RotatePoint(var_forward_vec, VectorScale((0, 1, 0), 45));
		var_forward_left_45_vec = function_RotatePoint(var_forward_vec, VectorScale((0, -1, 0), 45));
		var_right_vec = function_AnglesToRight(var_player_angles);
		var_end_radius = 30;
		var_trace_end_points[0] = var_end + VectorScale(var_forward_right_45_vec, var_end_radius);
		var_trace_end_points[1] = var_end + VectorScale(var_forward_left_45_vec, var_end_radius);
		var_trace_end_points[2] = var_end - VectorScale(var_forward_vec, var_end_radius);
		for(var_i = 0; var_i < 3; var_i++)
		{
			var_trace = function_bullettrace(var_start, var_trace_end_points[var_i], 1, self);
			if(var_trace["fraction"] < 1)
			{
				if(function_IsActor(var_trace["entity"]) && var_trace["entity"].var_health > 0)
				{
					var_origin = var_trace["entity"].var_origin;
					var_entity = var_trace["entity"];
					if(isdefined(var_trace["entity"].var_missingLegs) && var_trace["entity"].var_missingLegs || (isdefined(var_trace["entity"].var_isdog) && var_trace["entity"].var_isdog))
					{
						var_target = "crawler";
					}
					else if(isdefined(var_trace["entity"].var_a44ca904) && var_trace["entity"].var_a44ca904)
					{
						var_target = "boss";
					}
					else
					{
						var_target = "zombie";
						continue;
					}
				}
				var_origin = var_trace["position"];
				var_248bbf85 = [];
				if(isdefined(level.var_chests))
				{
					var_box = function_ArrayGetClosest(var_origin, level.var_chests);
					var_box.var_type = "random_box";
					var_248bbf85["box"] = var_box;
				}
				if(isdefined(function_GetEntArray("zombie_vending", "targetname")[0]))
				{
					var_perk = function_ArrayGetClosest(var_origin, function_GetEntArray("zombie_vending", "targetname"));
					var_perk.var_type = "perk_machine";
					var_248bbf85["perk"] = var_perk;
				}
				if(isdefined(function_GetEntArray("bgb_machine_use", "targetname")[0]))
				{
					var_bgb = function_ArrayGetClosest(var_origin, function_GetEntArray("bgb_machine_use", "targetname"));
					var_bgb.var_type = "gobblegum_machine";
					var_248bbf85["bgb"] = var_bgb;
				}
				if(isdefined(level.var_active_powerups[0]))
				{
					var_powerup = function_ArrayGetClosest(var_origin, namespace_zm_powerups::function_get_powerups(var_origin, 400));
					var_powerup.var_type = "powerup";
					var_248bbf85["powerup"] = var_powerup;
				}
				if(isdefined(level.var_a_uts_craftables[0]) || isdefined(function_GetEntArray("open_craftable_trigger", "targetname")[0]))
				{
					var_craftables = [];
					if(isdefined(level.var_a_uts_craftables[0]))
					{
						var_craftables["specific_craftable_table"] = function_ArrayGetClosest(var_origin, level.var_a_uts_craftables);
					}
					if(isdefined(function_GetEntArray("open_craftable_trigger", "targetname")[0]))
					{
						var_craftables["open_craftable_table"] = function_ArrayGetClosest(var_origin, function_GetEntArray("open_craftable_trigger", "targetname"));
					}
					var_bfefc258 = function_ArrayGetClosest(var_origin, var_craftables);
					var_craftable_table = var_bfefc258;
					var_craftable_table.var_type = "craftable_table";
					var_248bbf85["craftable_table"] = var_craftable_table;
				}
				if(isdefined(namespace_struct::function_get_array("weapon_upgrade", "targetname")))
				{
					var_wallbuy = function_ArrayGetClosest(var_origin, namespace_struct::function_get_array("weapon_upgrade", "targetname"));
					var_wallbuy.var_type = "wallbuy";
					var_248bbf85["wallbuy"] = var_wallbuy;
				}
				if(isdefined(function_GetEntArray("use_elec_switch", "targetname")))
				{
					var_PowerSwitch = function_ArrayGetClosest(var_origin, function_GetEntArray("use_elec_switch", "targetname"));
					var_PowerSwitch.var_type = "powerswitch";
					var_248bbf85["powerswitch"] = var_PowerSwitch;
				}
				if(isdefined(level.var_pack_a_punch.var_triggers) || isdefined(function_GetEntArray("_mc_enchanting_table_pap", "targetname")))
				{
					var_b8481387 = [];
					var_b8481387["original"] = function_ArrayGetClosest(var_origin, level.var_pack_a_punch.var_triggers);
					var_b8481387["custom"] = function_ArrayGetClosest(var_origin, function_GetEntArray("_mc_enchanting_table_pap", "targetname"));
					var_PaP = function_ArrayGetClosest(var_origin, var_b8481387);
					var_PaP.var_type = "pack_a_punch";
					var_248bbf85["pap"] = var_PaP;
				}
				if(isdefined(function_GetEntArray("zombie_debris", "targetname")[0]) || isdefined(function_GetEntArray("zombie_door", "targetname")[0]))
				{
					var_doors = [];
					var_doors["door"] = function_ArrayGetClosest(var_origin, function_GetEntArray("zombie_door", "targetname"));
					var_doors["debris"] = function_ArrayGetClosest(var_origin, function_GetEntArray("zombie_debris", "targetname"));
					var_6f45c771 = function_ArrayGetClosest(var_origin, var_doors);
					if(var_6f45c771.var_script_noteworthy == "electric_door" || var_6f45c771.var_script_noteworthy == "electric_buyable_door" || var_6f45c771.var_script_noteworthy == "local_electric_door")
					{
						var_b68bf43 = var_6f45c771;
						var_b68bf43.var_type = "power_door";
						var_248bbf85["power_door"] = var_b68bf43;
					}
					else
					{
						var_9bc7e65 = var_6f45c771;
						var_9bc7e65.var_type = "obstruction";
						var_248bbf85["obstruction"] = var_9bc7e65;
					}
				}
				if(isdefined(namespace_struct::function_get_array("exterior_goal", "targetname")))
				{
					var_barricade = function_ArrayGetClosest(var_origin, namespace_struct::function_get_array("exterior_goal", "targetname"));
					var_barricade.var_type = "barricade";
					var_248bbf85["barricade"] = var_barricade;
				}
				if(isdefined(namespace_struct::function_get_array("_buyable_ammo_crate", "targetname")))
				{
					var_93c2768f = function_ArrayGetClosest(var_origin, namespace_struct::function_get_array("_buyable_ammo_crate", "targetname"));
					var_93c2768f.var_type = "ammo_cache";
					var_248bbf85["ammocache"] = var_93c2768f;
				}
				if(isdefined(function_GetEntArray("dropped_weapon_waypoint", "script_noteworthy")))
				{
					var_f80e9fc8 = function_ArrayGetClosest(var_origin, function_GetEntArray("dropped_weapon_waypoint", "script_noteworthy"));
					var_f80e9fc8.var_type = "dropped_weapon";
					var_248bbf85["dropped_weapon"] = var_f80e9fc8;
				}
				if(isdefined(function_GetEntArray("lich_king_boss", "script_noteworthy")))
				{
					var_boss = function_ArrayGetClosest(var_origin, function_GetEntArray("lich_king_boss", "script_noteworthy"));
					var_boss.var_type = "boss";
					var_248bbf85["boss"] = var_boss;
				}
				var_closest = function_ArrayGetClosest(var_origin, var_248bbf85);
				var_3c82248d = 1500;
				var_dist = function_Distance2DSquared(var_origin, var_closest.var_origin);
				if(var_dist < var_3c82248d)
				{
					switch(var_closest.var_type)
					{
						case "random_box":
						{
							var_entity = var_box;
							var_target = "box";
							var_origin = var_box.var_origin + VectorScale((0, 0, 1), 30);
							break;
						}
						case "perk_machine":
						{
							var_entity = var_perk;
							var_target = "perk";
							var_origin = var_perk.var_origin + VectorScale((0, 0, 1), 40);
							break;
						}
						case "gobblegum_machine":
						{
							var_entity = var_bgb;
							var_target = "bgb";
							var_origin = var_bgb.var_origin + VectorScale((0, 0, 1), 60);
							break;
						}
						case "powerup":
						{
							var_entity = var_powerup;
							var_target = "powerup";
							var_origin = var_powerup.var_origin + VectorScale((0, 0, 1), 20);
							break;
						}
						case "powerswitch":
						{
							var_entity = var_PowerSwitch;
							var_target = "powerswitch";
							var_origin = var_PowerSwitch.var_origin + VectorScale((0, 0, 1), 40);
							break;
						}
						case "wallbuy":
						{
							var_entity = var_wallbuy;
							var_target = "wallbuy";
							var_origin = var_wallbuy.var_origin + VectorScale((0, 0, 1), 5);
							break;
						}
						case "craftable_table":
						{
							var_entity = var_craftable_table;
							var_target = "craftable_table";
							var_origin = var_craftable_table.var_origin + VectorScale((0, 0, 1), 40);
							break;
						}
						case "pack_a_punch":
						{
							var_entity = var_PaP;
							var_target = "packapunch";
							var_origin = var_PaP.var_origin + VectorScale((0, 0, 1), 40);
							break;
						}
						case "power_door":
						{
							var_entity = var_b68bf43;
							var_target = "powerdoor";
							var_origin = var_b68bf43.var_origin + VectorScale((0, 0, 1), 50);
							break;
						}
						case "obstruction":
						{
							var_entity = var_9bc7e65;
							var_target = "obstruction";
							var_origin = var_9bc7e65.var_origin + VectorScale((0, 0, 1), 50);
							break;
						}
						case "barricade":
						{
							var_entity = var_barricade;
							var_target = "barricade";
							var_origin = var_barricade.var_origin + VectorScale((0, 0, 1), 30);
							break;
						}
						case "ammo_cache":
						{
							var_entity = var_93c2768f;
							var_target = "ammocache";
							var_origin = var_93c2768f.var_origin + VectorScale((0, 0, 1), 30);
							break;
						}
						case "dropped_weapon":
						{
							var_entity = var_f80e9fc8;
							var_target = "droppedweapon";
							var_origin = var_f80e9fc8.var_origin + VectorScale((0, 0, 1), 25);
							break;
						}
						case "boss":
						{
							var_entity = var_boss;
							var_target = "boss";
							var_origin = var_boss.var_origin + VectorScale((0, 0, 1), 25);
							break;
						}
					}
					continue;
				}
				var_entity = undefined;
				var_target = "floor_position";
				var_origin = var_origin;
			}
		}
		wait(0.4);
		var_4b715429 = 600;
		var_6620c5b2 = function_Distance2DSquared(self.var_f651e1, var_origin);
		if(var_6620c5b2 < var_4b715429)
		{
			self.var_f651e1 = undefined;
			function_objective_delete(self.var_4a1d4e18);
			if(isdefined(self.var_c3714669))
			{
				if(function_ToLower(function_GetDvarString("mapname")) != "zm_castle")
				{
					self.var_c3714669 namespace_clientfield::function_set("weapon_drop_level_enable_keyline", 0);
				}
				else
				{
					self.var_c3714669 namespace_clientfield::function_set("weapon_drop_enable_keyline", 0);
				}
			}
			self notify("hash_740302d5");
			self function_playsoundtoplayer("waypoint_cancel", self);
		}
		else
		{
			self thread function_6b8387f5(var_origin, var_target, var_entity, var_c963c671);
		}
		wait(0.1);
		wait(0.05);
	}
}

/*
	Name: function_6b8387f5
	Namespace: namespace_d747dc75
	Checksum: 0x424F4353
	Offset: 0x2318
	Size: 0x638
	Parameters: 4
	Flags: None
	Line Number: 403
*/
function function_6b8387f5(var_origin, var_target, var_entity, var_c963c671)
{
	if(!isdefined(var_c963c671))
	{
		var_c963c671 = 0;
	}
	self endon("hash_740302d5");
	switch(var_target)
	{
		case "boss":
		case "special":
		{
			self thread function_7f2a4b03(var_origin + VectorScale((0, 0, 1), 75), var_entity, var_target, 1, "uie_t7_zm_hud_waypoint_boss", 128, "waypoint_enemy");
			break;
		}
		case "armored":
		{
			self thread function_7f2a4b03(var_origin + VectorScale((0, 0, 1), 70), var_entity, var_target, 1, "uie_t7_zm_hud_waypoint_armored", 128, "waypoint_enemy");
			break;
		}
		case "crawler":
		{
			self thread function_7f2a4b03(var_origin + VectorScale((0, 0, 1), 10), var_entity, var_target, 1, "uie_t7_zm_hud_waypoint_enemy", 128, "waypoint_enemy");
			break;
		}
		case "zombie":
		{
			self thread function_7f2a4b03(var_origin + VectorScale((0, 0, 1), 70), var_entity, var_target, 1, "uie_t7_zm_hud_waypoint_enemy", 128, "waypoint_enemy");
			break;
		}
		case "perk":
		{
			var_ff36e2af = function_2f134368(var_entity.var_script_noteworthy);
			self thread function_7f2a4b03(var_origin, var_entity, var_target, 0, var_ff36e2af, 128, "waypoint_item");
			break;
		}
		case "box":
		{
			self thread function_7f2a4b03(var_origin, var_entity, var_target, 0, "ui_icon_poi_random_box", 128, "waypoint_item");
			break;
		}
		case "bgb":
		{
			self thread function_7f2a4b03(var_origin, var_entity, var_target, 0, "ui_icon_poi_gobblegums", 128, "waypoint_item");
			break;
		}
		case "powerswitch":
		{
			self thread function_7f2a4b03(var_origin, var_entity, var_target, 0, "ui_icon_poi_powerswitch_alternative", 128, "waypoint_item");
			break;
		}
		case "packapunch":
		{
			self thread function_7f2a4b03(var_origin, var_entity, var_target, 0, "ui_icon_poi_pap", 128, "waypoint_item");
			break;
		}
		case "wallbuy":
		{
			self thread function_7f2a4b03(var_origin, var_entity, var_target, 0, "ui_icon_poi_wallbuy", 128, "waypoint_item");
			break;
		}
		case "craftable_table":
		{
			self thread function_7f2a4b03(var_origin, var_entity, var_target, 0, "ui_icon_poi_crafting_table", 128, "waypoint_item");
			break;
		}
		case "barricade":
		{
			self thread function_7f2a4b03(var_origin, var_entity, var_target, 0, "ui_icon_poi_barricade", 128, "waypoint_item");
			break;
		}
		case "ammocache":
		{
			self thread function_7f2a4b03(var_origin, var_entity, var_target, 0, "ui_icon_poi_ammo_cache", 128, "waypoint_item");
			break;
		}
		case "powerdoor":
		{
			self thread function_7f2a4b03(var_origin, var_entity, var_target, 0, "ui_icon_poi_door_electric", 128, "waypoint_item");
			break;
		}
		case "obstruction":
		{
			self thread function_7f2a4b03(var_origin, var_entity, var_target, 0, "ui_icon_poi_door", 128, "waypoint_item");
			break;
		}
		case "droppedweapon":
		{
			var_weaponClass = var_entity.var_stored_weapon function_get_weapon_type();
			self thread function_7f2a4b03(var_origin, var_entity, var_target, 0, "ui_icon_weapon_" + var_weaponClass, 128, "waypoint_item");
			break;
		}
		case "powerup":
		{
			var_bfdb4375 = function_e350ab20(var_entity.var_powerup_name);
			self thread function_7f2a4b03(var_origin, var_entity, var_target, 0, var_bfdb4375, 128, "waypoint_item");
			break;
		}
		case "floor_position":
		{
			if(isdefined(var_c963c671) && var_c963c671)
			{
				self thread function_7f2a4b03(var_origin, var_entity, var_target, 0, "uie_t7_zm_hud_waypoint_danger", 256, "waypoint_position");
			}
			else
			{
				self thread function_7f2a4b03(var_origin, var_entity, var_target, 0, "uie_t7_zm_hud_waypoint_player_" + self function_GetEntityNumber() + 1, 128, "waypoint_position");
				break;
			}
		}
	}
	self thread function_549fbbec();
}

/*
	Name: function_get_weapon_type
	Namespace: namespace_d747dc75
	Checksum: 0x424F4353
	Offset: 0x2958
	Size: 0x648
	Parameters: 0
	Flags: None
	Line Number: 527
*/
function function_get_weapon_type()
{
	var_weapon = namespace_zm_weapons::function_get_base_weapon(self);
	var_index = 1;
	for(var_row = function_TableLookupRow("gamedata/weapons/zm/zm_qol_weapons.csv", var_index); isdefined(var_row); var_row = function_TableLookupRow("gamedata/weapons/zm/zm_qol_weapons.csv", var_index))
	{
		if(function_checkStringValid(var_row[0]) === function_StrTok(var_weapon.var_name, "+")[0])
		{
			if(function_checkStringValid(var_row[16]) === "rifle" || function_IsSubStr(var_weapon.var_name, "ar_"))
			{
				return "assault";
			}
			else if(function_checkStringValid(var_row[16]) === "pistol" || function_IsSubStr(var_weapon.var_name, "pistol_"))
			{
				return "pistol";
			}
			else if(function_checkStringValid(var_row[16]) === "smg" || function_IsSubStr(var_weapon.var_name, "smg_"))
			{
				return "smg";
			}
			else if(function_checkStringValid(var_row[16]) === "lmg" || function_IsSubStr(var_weapon.var_name, "lmg_"))
			{
				return "lmg";
			}
			else if(function_checkStringValid(var_row[16]) === "shotgun" || function_IsSubStr(var_weapon.var_name, "shotgun_"))
			{
				return "shotgun";
			}
			else if(function_checkStringValid(var_row[16]) === "sniper" || function_IsSubStr(var_weapon.var_name, "sniper_"))
			{
				return "sniper";
			}
			else if(function_checkStringValid(var_row[16]) === "special" || function_IsSubStr(var_weapon.var_name, "special_"))
			{
				if(isdefined(var_weapon.var_is_wonder_weapon) && var_weapon.var_is_wonder_weapon || namespace_Array::function_contains(level.var_e33eb0d5, var_weapon.var_name))
				{
					return "wonder_weapon";
				}
				else if(var_weapon.var_isLauncher || var_weapon.var_isRocketLauncher)
				{
					return "rocket";
				}
				else
				{
					return "undefined";
				}
			}
			else if(function_checkStringValid(var_row[16]) === "launcher" || function_IsSubStr(var_weapon.var_name, "launcher_"))
			{
				return "rocket";
			}
			else if(function_checkStringValid(var_row[16]) === "grenade" || function_IsSubStr(var_weapon.var_name, "grenade"))
			{
				return "grenade";
			}
			else if(function_checkStringValid(var_row[16]) === "tactical" || function_IsSubStr(var_weapon.var_name, "tactical"))
			{
				return "flash";
			}
			else if(function_checkStringValid(var_row[16]) === "melee" || function_IsSubStr(var_weapon.var_name, "melee"))
			{
				return "melee";
			}
			else if(function_checkStringValid(var_row[16]) === "shield" || function_IsSubStr(var_weapon.var_name, "shield"))
			{
				return "shield";
			}
			else if(function_checkStringValid(var_row[16]) === "betty" || function_IsSubStr(var_weapon.var_name, "smg_"))
			{
				return "undefined";
			}
		}
		var_index++;
	}
	return "undefined";
}

/*
	Name: function_checkStringValid
	Namespace: namespace_d747dc75
	Checksum: 0x424F4353
	Offset: 0x2FA8
	Size: 0x28
	Parameters: 1
	Flags: None
	Line Number: 614
*/
function function_checkStringValid(var_STR)
{
	if(var_STR != "")
	{
		return var_STR;
	}
	return undefined;
	ERROR: Exception occured: Stack empty.
}

/*
	Name: function_549fbbec
	Namespace: namespace_d747dc75
	Checksum: 0x424F4353
	Offset: 0x2FD8
	Size: 0x120
	Parameters: 0
	Flags: None
	Line Number: 634
*/
function function_549fbbec()
{
	self endon("hash_740302d5");
	self endon("hash_death");
	self endon("hash_disconnect");
	var_count = 0;
	while(isdefined(self.var_4a1d4e18))
	{
		var_count++;
		if(var_count >= 60)
		{
			function_objective_delete(self.var_4a1d4e18);
			if(isdefined(self.var_c3714669))
			{
				if(function_ToLower(function_GetDvarString("mapname")) != "zm_castle")
				{
					self.var_c3714669 namespace_clientfield::function_set("weapon_drop_level_enable_keyline", 0);
				}
				else
				{
					self.var_c3714669 namespace_clientfield::function_set("weapon_drop_enable_keyline", 0);
				}
			}
			self notify("hash_740302d5");
			break;
		}
		wait(1);
	}
}

/*
	Name: function_7f2a4b03
	Namespace: namespace_d747dc75
	Checksum: 0x424F4353
	Offset: 0x3100
	Size: 0x240
	Parameters: 7
	Flags: None
	Line Number: 674
*/
function function_7f2a4b03(var_origin, var_entity, var_target, var_follow, var_objective_name, var_scale, var_sound)
{
	self function_playsoundtoplayer(var_sound, self);
	self.var_4a1d4e18 = namespace_gameobjects::function_get_next_obj_id();
	self.var_f651e1 = var_origin;
	if(isdefined(var_follow) && var_follow)
	{
		function_objective_add(self.var_4a1d4e18, "active", var_entity, function_istring(var_objective_name));
	}
	else
	{
		function_objective_add(self.var_4a1d4e18, "active", var_origin, function_istring(var_objective_name));
	}
	if(function_ToLower(function_GetDvarString("mapname")) != "zm_castle")
	{
		var_entity namespace_clientfield::function_set("weapon_drop_level_enable_keyline", 1);
		var_player.var_c3714669 = var_entity;
	}
	else
	{
		var_entity namespace_clientfield::function_set("weapon_drop_enable_keyline", 2);
		var_player.var_c3714669 = var_entity;
	}
	function_Objective_Set3D(self.var_4a1d4e18, 0);
	function_objective_team(self.var_4a1d4e18, "allies");
	if(self function_IsSplitscreen())
	{
		var_scale = var_scale * 1.5;
	}
	function_5834f0c4(self.var_4a1d4e18, var_scale, var_scale);
}

/*
	Name: function_209679ce
	Namespace: namespace_d747dc75
	Checksum: 0x424F4353
	Offset: 0x3348
	Size: 0x100
	Parameters: 3
	Flags: None
	Line Number: 716
*/
function function_209679ce(var_waypoint, var_entity, var_target)
{
	var_entity endon("hash_death");
	var_entity thread function_wait_for_death(self);
	while(1)
	{
		switch(var_target)
		{
			case "armored":
			case "boss":
			case "special":
			case "zombie":
			{
				var_origin = var_entity.var_origin + VectorScale((0, 0, 1), 70);
				break;
			}
			case "crawler":
			{
				var_origin = var_entity.var_origin + VectorScale((0, 0, 1), 10);
				break;
			}
		}
		function_objective_position(var_waypoint, var_origin);
		wait(0.05);
	}
}

/*
	Name: function_get_by_name
	Namespace: namespace_d747dc75
	Checksum: 0x424F4353
	Offset: 0x3450
	Size: 0x38
	Parameters: 1
	Flags: None
	Line Number: 753
*/
function function_get_by_name(var_name)
{
	if(isdefined(level.var_objPoints[var_name]))
	{
		return level.var_objPoints[var_name];
	}
	else
	{
		return undefined;
	}
}

/*
	Name: function_wait_for_death
	Namespace: namespace_d747dc75
	Checksum: 0x424F4353
	Offset: 0x3490
	Size: 0x108
	Parameters: 1
	Flags: None
	Line Number: 775
*/
function function_wait_for_death(var_player)
{
	while(function_isalive(self))
	{
		wait(1);
	}
	var_player.var_f651e1 = undefined;
	function_objective_delete(var_player.var_4a1d4e18);
	if(isdefined(var_player.var_c3714669))
	{
		if(function_ToLower(function_GetDvarString("mapname")) != "zm_castle")
		{
			var_player.var_c3714669 namespace_clientfield::function_set("weapon_drop_level_enable_keyline", 0);
		}
		else
		{
			var_player.var_c3714669 namespace_clientfield::function_set("weapon_drop_enable_keyline", 0);
		}
	}
	var_player notify("hash_740302d5");
}

/*
	Name: function_2f134368
	Namespace: namespace_d747dc75
	Checksum: 0x424F4353
	Offset: 0x35A0
	Size: 0x170
	Parameters: 1
	Flags: None
	Line Number: 807
*/
function function_2f134368(var_84893f3)
{
	if(!isdefined(var_84893f3))
	{
		return;
	}
	switch(var_84893f3)
	{
		case "specialty_armorvest":
		{
			return "ui_icon_perk_juggernog";
		}
		case "specialty_quickrevive":
		{
			return "ui_icon_perk_quick_revive";
		}
		case "specialty_fastreload":
		{
			return "ui_icon_perk_speed_cola";
		}
		case "specialty_doubletap2":
		{
			return "ui_icon_perk_doubletap";
		}
		case "specialty_staminup":
		{
			return "ui_icon_perk_staminup";
		}
		case "specialty_phdflopper":
		{
			return "ui_icon_perk_phd";
		}
		case "specialty_deadshot":
		{
			return "ui_icon_perk_deadshot";
		}
		case "specialty_tracker":
		{
			return "ui_icon_perk_death_perception";
		}
		case "specialty_additionalprimaryweapon":
		{
			return "ui_icon_perk_mulekick";
		}
		case "specialty_electriccherry":
		{
			return "ui_icon_perk_cherry";
		}
		case "specialty_tombstone":
		{
			return "ui_icon_perk_tombstone";
		}
		case "specialty_whoswho":
		{
			return "ui_icon_perk_whos_who";
		}
		case "specialty_vultureaid":
		{
			return "ui_icon_perk_vulture_aid";
		}
		case "specialty_widowswine":
		{
			return "ui_icon_perk_widows_wine";
		}
		case "specialty_flakjacket":
		{
			return "ui_icon_perk_vigor_rush";
		}
		case "specialty_flashprotection":
		{
			return "ui_icon_perk_banana_colada";
		}
		case "specialty_proximityprotection":
		{
			return "ui_icon_perk_juggernog";
		}
		case "specialty_immunecounteruav":
		{
			return "ui_icon_perk_juggernog";
		}
		case "specialty_directionalfire":
		{
			return "ui_icon_perk_juggernog";
		}
		default
		{
			return "ui_icon_undefined";
		}
	}
}

/*
	Name: function_e350ab20
	Namespace: namespace_d747dc75
	Checksum: 0x424F4353
	Offset: 0x3718
	Size: 0x1AA
	Parameters: 1
	Flags: None
	Line Number: 908
*/
function function_e350ab20(var_36e03f75)
{
	if(!isdefined(var_36e03f75))
	{
		return;
	}
	switch(var_36e03f75)
	{
		case "full_ammo":
		{
			return "ui_icon_powerup_maxammo";
		}
		case "nuke":
		{
			return "ui_icon_powerup_nuke";
		}
		case "insta_kill":
		{
			return "ui_icon_powerup_instakill";
		}
		case "double_points":
		{
			return "ui_icon_powerup_doublepoints";
		}
		case "carpenter":
		{
			return "ui_icon_powerup_carpenter";
		}
		case "fire_sale":
		{
			return "ui_icon_powerup_firesale";
		}
		case "bonfire_sale":
		{
			return "bonfire_sale";
		}
		case "minigun":
		{
			return "minigun";
		}
		case "free_perk":
		{
			return "uie_icon_zombie_powerup_random_perk_can_large";
		}
		case "random_weapon":
		{
			return "random_weapon";
		}
		case "bonus_points_player":
		{
			return "ui_icon_powerup_points";
		}
		case "bonus_points_team":
		{
			return "ui_icon_powerup_points";
		}
		case "lose_perk":
		{
			return "lose_perk";
		}
		case "empty_clip":
		{
			return "empty_clip";
		}
		case "zombie_blood":
		{
			return "zombie_blood";
		}
		case "ww_grenade":
		{
			return "ww_grenade";
		}
		case "shield_charge":
		{
			return "shield_charge";
		}
		case "perk_slot":
		{
			return "perk_slot";
		}
		case "full_power":
		{
			return "full_power";
		}
		case "blood_money":
		{
			return "blood_money";
		}
		case "bottomless_clip":
		{
			return "bottomless_clip";
		}
		case "fast_feet":
		{
			return "fast_feet";
		}
		case "xp_drop":
		{
			return "ui_icon_powerup_xp_drop";
		}
		default
		{
			return "ui_icon_undefined";
		}
	}
}

