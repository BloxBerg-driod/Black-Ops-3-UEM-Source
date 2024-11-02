#include scripts\codescripts\struct;
#include scripts\shared\array_shared;
#include scripts\shared\callbacks_shared;
#include scripts\shared\clientfield_shared;
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
	Name: __init__sytem__
	Namespace: namespace_d747dc75
	Checksum: 0x424F4353
	Offset: 0xD28
	Size: 0x38
	Parameters: 0
	Flags: AutoExec
	Line Number: 27
*/
function autoexec __init__sytem__()
{
	system::register("zm_waypoint_tag", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: namespace_d747dc75
	Checksum: 0x424F4353
	Offset: 0xD68
	Size: 0x28
	Parameters: 0
	Flags: None
	Line Number: 42
*/
function __init__()
{
	callback::on_spawned(&on_player_spawned);
}

/*
	Name: on_player_spawned
	Namespace: namespace_d747dc75
	Checksum: 0x424F4353
	Offset: 0xD98
	Size: 0x1450
	Parameters: 0
	Flags: None
	Line Number: 57
*/
function on_player_spawned()
{
	self.var_f4d01b67["ping_keybind"] = int(0);
	self endon("disconnect");
	self thread zm_equipment::show_hint_text(&"ZM_MINECRAFT_PING_SYSTEM_HOW_TO", 10);
	while(self actionslotthreebuttonpressed() && self.var_f4d01b67["ping_keybind"] == 0)
	{
		if(isdefined(self.var_4a1d4e18))
		{
			objective_delete(self.var_4a1d4e18);
			self notify("hash_740302d5");
			if(isdefined(self.var_c3714669))
			{
				if(tolower(getdvarstring("mapname")) != "zm_castle")
				{
					self.var_c3714669 clientfield::set("weapon_drop_level_enable_keyline", 0);
				}
				else
				{
					self.var_c3714669 clientfield::set("weapon_drop_enable_keyline", 0);
				}
			}
		}
		wait(0.05);
		start = self getweaponmuzzlepoint();
		forward_dir = self getweaponforwarddir();
		end = start + forward_dir * 20000;
		player_angles = self getplayerangles();
		forward_vec = anglestoforward((0, player_angles[1], 0));
		forward_right_45_vec = RotatePoint(forward_vec, VectorScale((0, 1, 0), 45));
		forward_left_45_vec = RotatePoint(forward_vec, VectorScale((0, -1, 0), 45));
		right_vec = anglestoright(player_angles);
		end_radius = 30;
		trace_end_points[0] = end + VectorScale(forward_right_45_vec, end_radius);
		trace_end_points[1] = end + VectorScale(forward_left_45_vec, end_radius);
		trace_end_points[2] = end - VectorScale(forward_vec, end_radius);
		for(i = 0; i < 3; i++)
		{
			trace = bullettrace(start, trace_end_points[i], 1, self);
			if(trace["fraction"] < 1)
			{
				if(IsActor(trace["entity"]) && trace["entity"].health > 0)
				{
					origin = trace["entity"].origin;
					entity = trace["entity"];
					if(isdefined(trace["entity"].missingLegs) && trace["entity"].missingLegs || (isdefined(trace["entity"].isdog) && trace["entity"].isdog))
					{
						target = "crawler";
					}
					else if(isdefined(trace["entity"].var_a44ca904) && trace["entity"].var_a44ca904)
					{
						target = "boss";
					}
					else
					{
						target = "zombie";
						continue;
					}
				}
				origin = trace["position"];
				var_248bbf85 = [];
				if(isdefined(level.chests))
				{
					box = arraygetclosest(origin, level.chests);
					box.type = "random_box";
					var_248bbf85["box"] = box;
				}
				if(isdefined(getentarray("zombie_vending", "targetname")[0]))
				{
					perk = arraygetclosest(origin, getentarray("zombie_vending", "targetname"));
					perk.type = "perk_machine";
					var_248bbf85["perk"] = perk;
				}
				if(isdefined(getentarray("bgb_machine_use", "targetname")[0]))
				{
					bgb = arraygetclosest(origin, getentarray("bgb_machine_use", "targetname"));
					bgb.type = "gobblegum_machine";
					var_248bbf85["bgb"] = bgb;
				}
				if(isdefined(level.active_powerups[0]))
				{
					powerup = arraygetclosest(origin, zm_powerups::get_powerups(origin, 400));
					powerup.type = "powerup";
					var_248bbf85["powerup"] = powerup;
				}
				if(isdefined(level.a_uts_craftables[0]) || isdefined(getentarray("open_craftable_trigger", "targetname")[0]))
				{
					craftables = [];
					if(isdefined(level.a_uts_craftables[0]))
					{
						craftables["specific_craftable_table"] = arraygetclosest(origin, level.a_uts_craftables);
					}
					if(isdefined(getentarray("open_craftable_trigger", "targetname")[0]))
					{
						craftables["open_craftable_table"] = arraygetclosest(origin, getentarray("open_craftable_trigger", "targetname"));
					}
					var_bfefc258 = arraygetclosest(origin, craftables);
					craftable_table = var_bfefc258;
					craftable_table.type = "craftable_table";
					var_248bbf85["craftable_table"] = craftable_table;
				}
				if(isdefined(struct::get_array("weapon_upgrade", "targetname")))
				{
					wallbuy = arraygetclosest(origin, struct::get_array("weapon_upgrade", "targetname"));
					wallbuy.type = "wallbuy";
					var_248bbf85["wallbuy"] = wallbuy;
				}
				if(isdefined(getentarray("use_elec_switch", "targetname")))
				{
					PowerSwitch = arraygetclosest(origin, getentarray("use_elec_switch", "targetname"));
					PowerSwitch.type = "powerswitch";
					var_248bbf85["powerswitch"] = PowerSwitch;
				}
				if(isdefined(level.pack_a_punch.triggers) || isdefined(getentarray("_mc_enchanting_table_pap", "targetname")))
				{
					var_b8481387 = [];
					var_b8481387["original"] = arraygetclosest(origin, level.pack_a_punch.triggers);
					var_b8481387["custom"] = arraygetclosest(origin, getentarray("_mc_enchanting_table_pap", "targetname"));
					PaP = arraygetclosest(origin, var_b8481387);
					PaP.type = "pack_a_punch";
					var_248bbf85["pap"] = PaP;
				}
				if(isdefined(getentarray("zombie_debris", "targetname")[0]) || isdefined(getentarray("zombie_door", "targetname")[0]))
				{
					doors = [];
					doors["door"] = arraygetclosest(origin, getentarray("zombie_door", "targetname"));
					doors["debris"] = arraygetclosest(origin, getentarray("zombie_debris", "targetname"));
					var_6f45c771 = arraygetclosest(origin, doors);
					if(var_6f45c771.script_noteworthy == "electric_door" || var_6f45c771.script_noteworthy == "electric_buyable_door" || var_6f45c771.script_noteworthy == "local_electric_door")
					{
						var_b68bf43 = var_6f45c771;
						var_b68bf43.type = "power_door";
						var_248bbf85["power_door"] = var_b68bf43;
					}
					else
					{
						var_9bc7e65 = var_6f45c771;
						var_9bc7e65.type = "obstruction";
						var_248bbf85["obstruction"] = var_9bc7e65;
					}
				}
				if(isdefined(struct::get_array("exterior_goal", "targetname")))
				{
					barricade = arraygetclosest(origin, struct::get_array("exterior_goal", "targetname"));
					barricade.type = "barricade";
					var_248bbf85["barricade"] = barricade;
				}
				if(isdefined(struct::get_array("_buyable_ammo_crate", "targetname")))
				{
					var_93c2768f = arraygetclosest(origin, struct::get_array("_buyable_ammo_crate", "targetname"));
					var_93c2768f.type = "ammo_cache";
					var_248bbf85["ammocache"] = var_93c2768f;
				}
				if(isdefined(getentarray("dropped_weapon_waypoint", "script_noteworthy")))
				{
					var_f80e9fc8 = arraygetclosest(origin, getentarray("dropped_weapon_waypoint", "script_noteworthy"));
					var_f80e9fc8.type = "dropped_weapon";
					var_248bbf85["dropped_weapon"] = var_f80e9fc8;
				}
				if(isdefined(getentarray("lich_king_boss", "script_noteworthy")))
				{
					boss = arraygetclosest(origin, getentarray("lich_king_boss", "script_noteworthy"));
					boss.type = "boss";
					var_248bbf85["boss"] = boss;
				}
				closest = arraygetclosest(origin, var_248bbf85);
				var_3c82248d = 1500;
				dist = distance2dsquared(origin, closest.origin);
				if(dist < var_3c82248d)
				{
					switch(closest.type)
					{
						case "random_box":
						{
							entity = box;
							target = "box";
							origin = box.origin + VectorScale((0, 0, 1), 30);
							break;
						}
						case "perk_machine":
						{
							entity = perk;
							target = "perk";
							origin = perk.origin + VectorScale((0, 0, 1), 40);
							break;
						}
						case "gobblegum_machine":
						{
							entity = bgb;
							target = "bgb";
							origin = bgb.origin + VectorScale((0, 0, 1), 60);
							break;
						}
						case "powerup":
						{
							entity = powerup;
							target = "powerup";
							origin = powerup.origin + VectorScale((0, 0, 1), 20);
							break;
						}
						case "powerswitch":
						{
							entity = PowerSwitch;
							target = "powerswitch";
							origin = PowerSwitch.origin + VectorScale((0, 0, 1), 40);
							break;
						}
						case "wallbuy":
						{
							entity = wallbuy;
							target = "wallbuy";
							origin = wallbuy.origin + VectorScale((0, 0, 1), 5);
							break;
						}
						case "craftable_table":
						{
							entity = craftable_table;
							target = "craftable_table";
							origin = craftable_table.origin + VectorScale((0, 0, 1), 40);
							break;
						}
						case "pack_a_punch":
						{
							entity = PaP;
							target = "packapunch";
							origin = PaP.origin + VectorScale((0, 0, 1), 40);
							break;
						}
						case "power_door":
						{
							entity = var_b68bf43;
							target = "powerdoor";
							origin = var_b68bf43.origin + VectorScale((0, 0, 1), 50);
							break;
						}
						case "obstruction":
						{
							entity = var_9bc7e65;
							target = "obstruction";
							origin = var_9bc7e65.origin + VectorScale((0, 0, 1), 50);
							break;
						}
						case "barricade":
						{
							entity = barricade;
							target = "barricade";
							origin = barricade.origin + VectorScale((0, 0, 1), 30);
							break;
						}
						case "ammo_cache":
						{
							entity = var_93c2768f;
							target = "ammocache";
							origin = var_93c2768f.origin + VectorScale((0, 0, 1), 30);
							break;
						}
						case "dropped_weapon":
						{
							entity = var_f80e9fc8;
							target = "droppedweapon";
							origin = var_f80e9fc8.origin + VectorScale((0, 0, 1), 25);
							break;
						}
						case "boss":
						{
							entity = boss;
							target = "boss";
							origin = boss.origin + VectorScale((0, 0, 1), 25);
							break;
						}
					}
					continue;
				}
				entity = undefined;
				target = "floor_position";
				origin = origin;
			}
		}
		var_4b715429 = 600;
		var_6620c5b2 = distance2dsquared(self.var_f651e1, origin);
		if(var_6620c5b2 < var_4b715429)
		{
			self.var_f651e1 = undefined;
			objective_delete(self.var_4a1d4e18);
			if(isdefined(self.var_c3714669))
			{
				if(tolower(getdvarstring("mapname")) != "zm_castle")
				{
					self.var_c3714669 clientfield::set("weapon_drop_level_enable_keyline", 0);
				}
				else
				{
					self.var_c3714669 clientfield::set("weapon_drop_enable_keyline", 0);
				}
			}
			self notify("hash_740302d5");
			self playsoundtoplayer("waypoint_cancel", self);
		}
		else
		{
			self thread function_6b8387f5(origin, target, entity);
		}
		wait(0.1);
		wait(0.05);
	}
}

/*
	Name: function_6b8387f5
	Namespace: namespace_d747dc75
	Checksum: 0x424F4353
	Offset: 0x21F0
	Size: 0x5D8
	Parameters: 3
	Flags: None
	Line Number: 374
*/
function function_6b8387f5(origin, target, entity)
{
	self endon("hash_740302d5");
	switch(target)
	{
		case "boss":
		case "special":
		{
			self thread function_7f2a4b03(origin + VectorScale((0, 0, 1), 75), entity, target, 1, "uie_t7_zm_hud_waypoint_boss", 128, "waypoint_enemy");
			break;
		}
		case "armored":
		{
			self thread function_7f2a4b03(origin + VectorScale((0, 0, 1), 70), entity, target, 1, "uie_t7_zm_hud_waypoint_armored", 128, "waypoint_enemy");
			break;
		}
		case "crawler":
		{
			self thread function_7f2a4b03(origin + VectorScale((0, 0, 1), 10), entity, target, 1, "uie_t7_zm_hud_waypoint_enemy", 128, "waypoint_enemy");
			break;
		}
		case "zombie":
		{
			self thread function_7f2a4b03(origin + VectorScale((0, 0, 1), 70), entity, target, 1, "uie_t7_zm_hud_waypoint_enemy", 128, "waypoint_enemy");
			break;
		}
		case "perk":
		{
			var_ff36e2af = function_2f134368(entity.script_noteworthy);
			self thread function_7f2a4b03(origin, entity, target, 0, var_ff36e2af, 128, "waypoint_item");
			break;
		}
		case "box":
		{
			self thread function_7f2a4b03(origin, entity, target, 0, "ui_icon_poi_random_box", 128, "waypoint_item");
			break;
		}
		case "bgb":
		{
			self thread function_7f2a4b03(origin, entity, target, 0, "ui_icon_poi_gobblegums", 128, "waypoint_item");
			break;
		}
		case "powerswitch":
		{
			self thread function_7f2a4b03(origin, entity, target, 0, "ui_icon_poi_powerswitch_alternative", 128, "waypoint_item");
			break;
		}
		case "packapunch":
		{
			self thread function_7f2a4b03(origin, entity, target, 0, "ui_icon_poi_pap", 128, "waypoint_item");
			break;
		}
		case "wallbuy":
		{
			self thread function_7f2a4b03(origin, entity, target, 0, "ui_icon_poi_wallbuy", 128, "waypoint_item");
			break;
		}
		case "craftable_table":
		{
			self thread function_7f2a4b03(origin, entity, target, 0, "ui_icon_poi_crafting_table", 128, "waypoint_item");
			break;
		}
		case "barricade":
		{
			self thread function_7f2a4b03(origin, entity, target, 0, "ui_icon_poi_barricade", 128, "waypoint_item");
			break;
		}
		case "ammocache":
		{
			self thread function_7f2a4b03(origin, entity, target, 0, "ui_icon_poi_ammo_cache", 128, "waypoint_item");
			break;
		}
		case "powerdoor":
		{
			self thread function_7f2a4b03(origin, entity, target, 0, "ui_icon_poi_door_electric", 128, "waypoint_item");
			break;
		}
		case "obstruction":
		{
			self thread function_7f2a4b03(origin, entity, target, 0, "ui_icon_poi_door", 128, "waypoint_item");
			break;
		}
		case "droppedweapon":
		{
			weaponClass = entity.stored_weapon get_weapon_type();
			self thread function_7f2a4b03(origin, entity, target, 0, "ui_icon_weapon_" + weaponClass, 128, "waypoint_item");
			break;
		}
		case "powerup":
		{
			var_bfdb4375 = function_e350ab20(entity.powerup_name);
			self thread function_7f2a4b03(origin, entity, target, 0, var_bfdb4375, 128, "waypoint_item");
			break;
		}
		case "floor_position":
		{
			self thread function_7f2a4b03(origin, entity, target, 0, "uie_t7_zm_hud_waypoint_player_" + self getentitynumber() + 1, 128, "waypoint_position");
			break;
		}
	}
	self thread function_549fbbec();
}

/*
	Name: get_weapon_type
	Namespace: namespace_d747dc75
	Checksum: 0x424F4353
	Offset: 0x27D0
	Size: 0x648
	Parameters: 0
	Flags: None
	Line Number: 487
*/
function get_weapon_type()
{
	weapon = zm_weapons::get_base_weapon(self);
	index = 1;
	for(row = tablelookuprow("gamedata/weapons/zm/zm_qol_weapons.csv", index); isdefined(row); row = tablelookuprow("gamedata/weapons/zm/zm_qol_weapons.csv", index))
	{
		if(checkStringValid(row[0]) === strtok(weapon.name, "+")[0])
		{
			if(checkStringValid(row[16]) === "rifle" || issubstr(weapon.name, "ar_"))
			{
				return "assault";
			}
			else if(checkStringValid(row[16]) === "pistol" || issubstr(weapon.name, "pistol_"))
			{
				return "pistol";
			}
			else if(checkStringValid(row[16]) === "smg" || issubstr(weapon.name, "smg_"))
			{
				return "smg";
			}
			else if(checkStringValid(row[16]) === "lmg" || issubstr(weapon.name, "lmg_"))
			{
				return "lmg";
			}
			else if(checkStringValid(row[16]) === "shotgun" || issubstr(weapon.name, "shotgun_"))
			{
				return "shotgun";
			}
			else if(checkStringValid(row[16]) === "sniper" || issubstr(weapon.name, "sniper_"))
			{
				return "sniper";
			}
			else if(checkStringValid(row[16]) === "special" || issubstr(weapon.name, "special_"))
			{
				if(isdefined(weapon.is_wonder_weapon) && weapon.is_wonder_weapon || array::contains(level.var_e33eb0d5, weapon.name))
				{
					return "wonder_weapon";
				}
				else if(weapon.isLauncher || weapon.isRocketLauncher)
				{
					return "rocket";
				}
				else
				{
					return "undefined";
				}
			}
			else if(checkStringValid(row[16]) === "launcher" || issubstr(weapon.name, "launcher_"))
			{
				return "rocket";
			}
			else if(checkStringValid(row[16]) === "grenade" || issubstr(weapon.name, "grenade"))
			{
				return "grenade";
			}
			else if(checkStringValid(row[16]) === "tactical" || issubstr(weapon.name, "tactical"))
			{
				return "flash";
			}
			else if(checkStringValid(row[16]) === "melee" || issubstr(weapon.name, "melee"))
			{
				return "melee";
			}
			else if(checkStringValid(row[16]) === "shield" || issubstr(weapon.name, "shield"))
			{
				return "shield";
			}
			else if(checkStringValid(row[16]) === "betty" || issubstr(weapon.name, "smg_"))
			{
				return "undefined";
			}
		}
		index++;
	}
	return "undefined";
}

/*
	Name: checkStringValid
	Namespace: namespace_d747dc75
	Checksum: 0x424F4353
	Offset: 0x2E20
	Size: 0x28
	Parameters: 1
	Flags: None
	Line Number: 574
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
	Name: function_549fbbec
	Namespace: namespace_d747dc75
	Checksum: 0x424F4353
	Offset: 0x2E50
	Size: 0x120
	Parameters: 0
	Flags: None
	Line Number: 593
*/
function function_549fbbec()
{
	self endon("hash_740302d5");
	self endon("death");
	self endon("disconnect");
	count = 0;
	while(isdefined(self.var_4a1d4e18))
	{
		count++;
		if(count >= 60)
		{
			objective_delete(self.var_4a1d4e18);
			if(isdefined(self.var_c3714669))
			{
				if(tolower(getdvarstring("mapname")) != "zm_castle")
				{
					self.var_c3714669 clientfield::set("weapon_drop_level_enable_keyline", 0);
				}
				else
				{
					self.var_c3714669 clientfield::set("weapon_drop_enable_keyline", 0);
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
	Offset: 0x2F78
	Size: 0x240
	Parameters: 7
	Flags: None
	Line Number: 633
*/
function function_7f2a4b03(origin, entity, target, follow, objective_name, scale, sound)
{
	self playsoundtoplayer(sound, self);
	self.var_4a1d4e18 = gameobjects::get_next_obj_id();
	self.var_f651e1 = origin;
	if(isdefined(follow) && follow)
	{
		objective_add(self.var_4a1d4e18, "active", entity, istring(objective_name));
	}
	else
	{
		objective_add(self.var_4a1d4e18, "active", origin, istring(objective_name));
	}
	if(tolower(getdvarstring("mapname")) != "zm_castle")
	{
		entity clientfield::set("weapon_drop_level_enable_keyline", 1);
		player.var_c3714669 = entity;
	}
	else
	{
		entity clientfield::set("weapon_drop_enable_keyline", 2);
		player.var_c3714669 = entity;
	}
	Objective_Set3D(self.var_4a1d4e18, 0);
	objective_team(self.var_4a1d4e18, "allies");
	if(self issplitscreen())
	{
		scale = scale * 1.5;
	}
	function_5834f0c4(self.var_4a1d4e18, scale, scale);
	return;
	ERROR: Exception occured: Stack empty.
}

/*
	Name: function_209679ce
	Namespace: namespace_d747dc75
	Checksum: 0x424F4353
	Offset: 0x31C0
	Size: 0x100
	Parameters: 3
	Flags: None
	Line Number: 677
*/
function function_209679ce(waypoint, entity, target)
{
	entity endon("death");
	entity thread wait_for_death(self);
	while(1)
	{
		switch(target)
		{
			case "armored":
			case "boss":
			case "special":
			case "zombie":
			{
				origin = entity.origin + VectorScale((0, 0, 1), 70);
				break;
			}
			case "crawler":
			{
				origin = entity.origin + VectorScale((0, 0, 1), 10);
				break;
			}
		}
		objective_position(waypoint, origin);
		wait(0.05);
	}
}

/*
	Name: get_by_name
	Namespace: namespace_d747dc75
	Checksum: 0x424F4353
	Offset: 0x32C8
	Size: 0x38
	Parameters: 1
	Flags: None
	Line Number: 714
*/
function get_by_name(name)
{
	if(isdefined(level.objPoints[name]))
	{
		return level.objPoints[name];
	}
	else
	{
		return undefined;
	}
}

/*
	Name: wait_for_death
	Namespace: namespace_d747dc75
	Checksum: 0x424F4353
	Offset: 0x3308
	Size: 0x108
	Parameters: 1
	Flags: None
	Line Number: 736
*/
function wait_for_death(player)
{
	while(isalive(self))
	{
		wait(1);
	}
	player.var_f651e1 = undefined;
	objective_delete(player.var_4a1d4e18);
	if(isdefined(player.var_c3714669))
	{
		if(tolower(getdvarstring("mapname")) != "zm_castle")
		{
			player.var_c3714669 clientfield::set("weapon_drop_level_enable_keyline", 0);
		}
		else
		{
			player.var_c3714669 clientfield::set("weapon_drop_enable_keyline", 0);
		}
	}
	player notify("hash_740302d5");
	return;
	ERROR: Exception occured: Stack empty.
}

/*
	Name: function_2f134368
	Namespace: namespace_d747dc75
	Checksum: 0x424F4353
	Offset: 0x3418
	Size: 0x170
	Parameters: 1
	Flags: None
	Line Number: 770
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
	Offset: 0x3590
	Size: 0x1AA
	Parameters: 1
	Flags: None
	Line Number: 871
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

