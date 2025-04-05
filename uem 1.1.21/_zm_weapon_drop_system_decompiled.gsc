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
#include scripts\shared\math_shared;
#include scripts\shared\scene_shared;
#include scripts\shared\spawner_shared;
#include scripts\shared\system_shared;
#include scripts\shared\util_shared;
#include scripts\sphynx\_zm_loot_mode;
#include scripts\sphynx\leveling\_zm_sphynx_leveling;
#include scripts\zm\_zm;
#include scripts\zm\_zm_audio;
#include scripts\zm\_zm_bgb;
#include scripts\zm\_zm_equipment;
#include scripts\zm\_zm_hero_weapon;
#include scripts\zm\_zm_magicbox;
#include scripts\zm\_zm_score;
#include scripts\zm\_zm_spawner;
#include scripts\zm\_zm_unitrigger;
#include scripts\zm\_zm_utility;
#include scripts\zm\_zm_weapons;

#namespace namespace_ecdf5e21;

/*
	Name: function___init__sytem__
	Namespace: namespace_ecdf5e21
	Checksum: 0x424F4353
	Offset: 0x790
	Size: 0x40
	Parameters: 0
	Flags: AutoExec
	Line Number: 41
*/
function autoexec function___init__sytem__()
{
	namespace_system::function_register("zm_weapon_drop_system", &function___init__, &function___main__, undefined);
}

/*
	Name: function___init__
	Namespace: namespace_ecdf5e21
	Checksum: 0x424F4353
	Offset: 0x7D8
	Size: 0x48
	Parameters: 0
	Flags: None
	Line Number: 56
*/
function function___init__()
{
	namespace_Array::function_thread_all(namespace_struct::function_get_array("_dropped_loot", "targetname"), &function_54faf03e);
	return;
}

/*
	Name: function___main__
	Namespace: namespace_ecdf5e21
	Checksum: 0x424F4353
	Offset: 0x828
	Size: 0x8
	Parameters: 0
	Flags: None
	Line Number: 72
*/
function function___main__()
{
}

/*
	Name: function_a0e9587e
	Namespace: namespace_ecdf5e21
	Checksum: 0x424F4353
	Offset: 0x838
	Size: 0x890
	Parameters: 11
	Flags: None
	Line Number: 86
*/
function function_a0e9587e(var_current_player, var_current_weapon, var_a39a2843, var_ammoclip, var_b71eaadf, var_6fa3e4b2, var_timer, var_31771afb, var_offsetx, var_offsety, var_offsetz)
{
	if(!isdefined(var_a39a2843))
	{
		var_a39a2843 = 0;
	}
	if(!isdefined(var_timer))
	{
		var_timer = 25;
	}
	if(!isdefined(var_31771afb))
	{
		var_31771afb = 23;
	}
	if(!isdefined(var_offsetx))
	{
		var_offsetx = 0;
	}
	if(!isdefined(var_offsety))
	{
		var_offsety = 0;
	}
	if(!isdefined(var_offsetz))
	{
		var_offsetz = 15;
	}
	var_eb70b91d = function_spawnstruct();
	var_eb70b91d.var_stored_weapon = var_current_weapon;
	var_eb70b91d.var_a39a2843 = var_a39a2843;
	var_spawn_origin = self.var_origin;
	var_spawn_angles = self.var_angles;
	var_forward_direction = function_AnglesToForward(var_spawn_angles);
	var_right_direction = function_AnglesToRight(var_spawn_angles);
	var_spawn_position = var_spawn_origin + var_forward_direction * 30 + var_right_direction * var_offsetx + var_forward_direction * var_offsety + (0, 0, var_offsetz);
	var_eb70b91d.var_e9e92a5b = namespace_zm_utility::function_spawn_buildkit_weapon_model(var_current_player, var_current_weapon, level.var_1e656cc4[0], var_spawn_position);
	var_eb70b91d.var_e9e92a5b.var_script_noteworthy = "dropped_weapon_waypoint";
	var_eb70b91d.var_e9e92a5b.var_stored_weapon = var_current_weapon;
	if(var_current_weapon.var_isDualWield)
	{
		var_dweapon = var_current_weapon;
		if(isdefined(var_current_weapon.var_dualWieldWeapon) && var_current_weapon.var_dualWieldWeapon != level.var_weaponNone)
		{
			var_dweapon = var_current_weapon.var_dualWieldWeapon;
		}
		var_eb70b91d.var_ammoclip = var_ammoclip;
		var_eb70b91d.var_b71eaadf = var_b71eaadf;
		var_eb70b91d.var_6fa3e4b2 = var_6fa3e4b2;
		var_eb70b91d.var_e9e92a5b.var_fce7951c = namespace_zm_utility::function_spawn_buildkit_weapon_model(var_current_player, var_current_weapon, level.var_1e656cc4[0], var_spawn_position);
		var_eb70b91d.var_e9e92a5b.var_fce7951c function_EnableLinkTo();
		var_eb70b91d.var_e9e92a5b.var_fce7951c function_LinkTo(var_eb70b91d.var_e9e92a5b);
	}
	else
	{
		var_eb70b91d.var_ammoclip = var_ammoclip;
		var_eb70b91d.var_b71eaadf = var_b71eaadf;
	}
	var_final_pos = self function_a2b97522(var_spawn_position, var_31771afb, var_eb70b91d.var_e9e92a5b, 1);
	var_eb70b91d.var_e9e92a5b function_a170d6f0(var_final_pos, 10);
	if(isdefined(var_eb70b91d.var_e9e92a5b))
	{
		if(namespace_zm_weapons::function_is_weapon_upgraded(var_eb70b91d.var_stored_weapon))
		{
			if(function_ToLower(function_GetDvarString("mapname")) != "zm_castle")
			{
				var_eb70b91d.var_e9e92a5b namespace_clientfield::function_set("weapon_drop_level_enable_keyline", var_eb70b91d.var_a39a2843);
			}
			else
			{
				var_eb70b91d.var_e9e92a5b namespace_clientfield::function_set("weapon_drop_enable_keyline", 1);
			}
			if(isdefined(var_eb70b91d.var_e9e92a5b.var_fce7951c))
			{
				if(function_ToLower(function_GetDvarString("mapname")) != "zm_castle")
				{
					var_eb70b91d.var_e9e92a5b.var_fce7951c namespace_clientfield::function_set("weapon_drop_level_enable_keyline", var_eb70b91d.var_a39a2843);
				}
				else
				{
					var_eb70b91d.var_e9e92a5b.var_fce7951c namespace_clientfield::function_set("weapon_drop_enable_keyline", 1);
				}
			}
		}
		else if(function_ToLower(function_GetDvarString("mapname")) != "zm_castle")
		{
			var_eb70b91d.var_e9e92a5b namespace_clientfield::function_set("weapon_drop_enable_keyline", 1);
			var_eb70b91d.var_e9e92a5b namespace_clientfield::function_set("weapon_drop_unpacked_fx", 1);
		}
		else
		{
			var_eb70b91d.var_e9e92a5b namespace_clientfield::function_set("weapon_drop_enable_keyline", 1);
		}
		if(isdefined(var_eb70b91d.var_e9e92a5b.var_fce7951c))
		{
			if(function_ToLower(function_GetDvarString("mapname")) != "zm_castle")
			{
				var_eb70b91d.var_e9e92a5b.var_fce7951c namespace_clientfield::function_set("weapon_drop_enable_keyline", 1);
			}
			else
			{
				var_eb70b91d.var_e9e92a5b.var_fce7951c namespace_clientfield::function_set("weapon_drop_enable_keyline", 1);
			}
		}
		var_eb70b91d.var_e9e92a5b thread function_233ac813(var_timer);
		if(isdefined(var_eb70b91d.var_e9e92a5b.var_fce7951c))
		{
			var_eb70b91d.var_e9e92a5b.var_fce7951c thread function_233ac813(var_timer);
		}
		var_eb70b91d.var_e9e92a5b thread function_8d50f4a4();
		if(isdefined(var_eb70b91d.var_e9e92a5b.var_fce7951c))
		{
			var_eb70b91d.var_e9e92a5b thread function_bf229247(var_eb70b91d, var_eb70b91d.var_e9e92a5b.var_fce7951c);
		}
		else
		{
			var_eb70b91d.var_e9e92a5b thread function_bf229247(var_eb70b91d);
		}
		var_eb70b91d.var_e9e92a5b.var_displayName = var_eb70b91d.var_stored_weapon.var_displayName;
		var_eb70b91d.var_e9e92a5b function_create_unitrigger(&"ZM_MINECRAFT_WEAPON_PICKUP_DROPPED", undefined, &function_8d35bc1b);
		var_eb70b91d.var_e9e92a5b thread function_1c800b52(var_eb70b91d);
		return;
	}
}

/*
	Name: function_a170d6f0
	Namespace: namespace_ecdf5e21
	Checksum: 0x424F4353
	Offset: 0x10D0
	Size: 0x128
	Parameters: 3
	Flags: None
	Line Number: 219
*/
function function_a170d6f0(var_final_pos, var_n_ground_offset, var_28cfafc2)
{
	if(!isdefined(var_28cfafc2))
	{
		var_28cfafc2 = 12;
	}
	if(!isdefined(self))
	{
		return var_final_pos;
	}
	var_8f7442a5 = namespace_util::function_ground_position(var_final_pos, 5000, var_n_ground_offset);
	var_distance_factor = function_max(function_length(var_final_pos - var_8f7442a5), 10);
	var_2374f197 = namespace_math::function_clamp(var_distance_factor * var_28cfafc2, 30, 250);
	var_drop_time = self namespace_zm_utility::function_fake_physicslaunch(var_8f7442a5, var_2374f197);
	self waittill("hash_movedone");
	self.var_origin = self.var_origin + (0, 0, var_n_ground_offset);
}

/*
	Name: function_b4c587b5
	Namespace: namespace_ecdf5e21
	Checksum: 0x424F4353
	Offset: 0x1200
	Size: 0x120
	Parameters: 1
	Flags: None
	Line Number: 247
*/
function function_b4c587b5(var_origin)
{
	var_offsetx = function_randomIntRange(-3, 3) * 2;
	var_offsety = function_randomIntRange(-3, 3) * 2;
	if(var_offsetx == 0 && var_offsety == 0)
	{
		if(function_RandomInt(2) == 0)
		{
		}
		else
		{
		}
		var_offsetx = 1 * -1;
	}
	var_offsetz = 0;
	if(function_RandomInt(2) == 0)
	{
		var_offsetz = function_randomIntRange(-1, 1) * 2;
	}
	return var_origin + (var_offsetx, var_offsety, var_offsetz);
}

/*
	Name: function_a2b97522
	Namespace: namespace_ecdf5e21
	Checksum: 0x424F4353
	Offset: 0x1328
	Size: 0x5A8
	Parameters: 4
	Flags: None
	Line Number: 279
*/
function function_a2b97522(var_origin, var_31771afb, var_weapon_model, var_Randomized)
{
	if(!isdefined(var_Randomized))
	{
		var_Randomized = 0;
	}
	if(isdefined(var_origin))
	{
		var_start = var_origin;
	}
	else
	{
		var_start = self.var_origin;
	}
	var_forward_dir = function_AnglesToForward(self.var_angles);
	var_end = var_start + var_forward_dir * var_31771afb;
	var_final_pos = namespace_util::function_ground_position(var_end, 5000, 0);
	var_final_pos = function_b4c587b5(var_final_pos);
	if(var_final_pos[2] > var_start.var_origin[2] + 40 || var_final_pos[2] > var_start.var_origin[2] - 40)
	{
		var_final_pos[2] = var_start.var_origin[2];
	}
	if(var_weapon_model function_3680e113(var_start, var_final_pos) && (!(isdefined(var_Randomized) && var_Randomized)))
	{
		return var_final_pos;
	}
	var_ba048795 = [];
	var_dc099ef8 = [];
	var_dc099ef8[var_dc099ef8.size] = (0, function_randomIntRange(7, 10) * 5, 0);
	var_dc099ef8[var_dc099ef8.size] = (0, function_randomIntRange(7, 10) * -5, 0);
	var_dc099ef8[var_dc099ef8.size] = (0, 0, 0);
	var_dc099ef8 = namespace_Array::function_randomize(var_dc099ef8);
	foreach(var_offset in var_dc099ef8)
	{
		var_ba048795[var_ba048795.size] = var_offset;
	}
	var_ba048795[var_ba048795.size] = (0, function_randomIntRange(7, 10) * 10, 0);
	var_ba048795[var_ba048795.size] = (0, function_randomIntRange(7, 10) * -10, 0);
	var_ba048795[var_ba048795.size] = VectorScale((0, 1, 0), 135);
	var_ba048795[var_ba048795.size] = VectorScale((0, -1, 0), 135);
	foreach(var_offset in var_ba048795)
	{
		var_cc6cc9e7 = function_AnglesToForward(self.var_angles + var_offset);
		var_end = var_start + var_cc6cc9e7 * var_31771afb;
		var_trace = function_bullettrace(var_start, var_end, 0, undefined);
		var_final_pos = var_trace["position"];
		var_final_pos = function_b4c587b5(var_final_pos);
		if(var_final_pos[2] > var_start.var_origin[2] + 40 || var_final_pos[2] > var_start.var_origin[2] - 40)
		{
			var_final_pos[2] = var_start.var_origin[2];
		}
		if(var_weapon_model function_3680e113(var_start, var_final_pos))
		{
			return var_final_pos;
		}
	}
	var_final_pos = function_b4c587b5(var_start);
	if(var_final_pos[2] > var_start.var_origin[2] + 40 || var_final_pos[2] > var_start.var_origin[2] - 40)
	{
		var_final_pos[2] = var_start.var_origin[2];
	}
	if(var_weapon_model function_3680e113(var_start, var_final_pos))
	{
		return var_final_pos;
	}
	return var_start;
}

/*
	Name: function_3680e113
	Namespace: namespace_ecdf5e21
	Checksum: 0x424F4353
	Offset: 0x18D8
	Size: 0x98
	Parameters: 2
	Flags: None
	Line Number: 357
*/
function function_3680e113(var_start, var_final_pos)
{
	if(level.var_chests.size > 0)
	{
		var_box = function_ArrayGetClosest(var_final_pos, level.var_chests);
		if(isdefined(var_box) && function_Distance2DSquared(var_final_pos, var_box.var_origin) < 1800)
		{
			return 0;
		}
	}
	return 1;
}

/*
	Name: function_8d35bc1b
	Namespace: namespace_ecdf5e21
	Checksum: 0x424F4353
	Offset: 0x1978
	Size: 0x168
	Parameters: 1
	Flags: None
	Line Number: 380
*/
function function_8d35bc1b(var_player)
{
	if(var_player function_53799f52(self.var_stub.var_related_parent.var_origin, 35, 0))
	{
		self function_setcursorhint("HINT_WEAPON", self.var_stub.var_related_parent.var_stored_weapon);
		self function_SetVisibleToPlayer(var_player);
		if(isdefined(var_player function_ca858703()) && var_player function_ca858703())
		{
			self function_setHintString(&"ZM_MINECRAFT_WEAPON_PICKUP_DROPPED");
			return 1;
		}
		else
		{
			self function_setHintString(&"ZM_MINECRAFT_WEAPON_CANNOT_PICKUP_DROPPED");
			return 0;
		}
	}
	else
	{
		self function_setcursorhint("HINT_NOICON");
		self function_SetInvisibleToPlayer(var_player);
		self function_setHintString("");
		return 0;
	}
}

/*
	Name: function_53799f52
	Namespace: namespace_ecdf5e21
	Checksum: 0x424F4353
	Offset: 0x1AE8
	Size: 0xB0
	Parameters: 4
	Flags: None
	Line Number: 416
*/
function function_53799f52(var_origin, var_a0fa82de, var_do_trace, var_e_ignore)
{
	if(!isdefined(var_a0fa82de))
	{
		var_a0fa82de = 180;
	}
	var_a0fa82de = function_AbsAngleClamp360(var_a0fa82de);
	var_303bd275 = function_cos(var_a0fa82de * 0.7);
	if(self namespace_util::function_is_player_looking_at(var_origin, var_303bd275, var_do_trace, var_e_ignore))
	{
		return 1;
	}
	return 0;
}

/*
	Name: function_ca858703
	Namespace: namespace_ecdf5e21
	Checksum: 0x424F4353
	Offset: 0x1BA0
	Size: 0x268
	Parameters: 0
	Flags: None
	Line Number: 441
*/
function function_ca858703()
{
	var_current_weapon = self function_GetCurrentWeapon();
	if(self namespace_laststand::function_player_is_in_laststand() || (isdefined(self.var_intermission) && self.var_intermission) || self function_IsThrowingGrenade())
	{
		return 0;
	}
	if(!self namespace_zm_magicbox::function_can_buy_weapon() || self namespace_bgb::function_is_enabled("zm_bgb_disorderly_combat"))
	{
		return 0;
	}
	if(self namespace_zm_equipment::function_hacker_active())
	{
		return 0;
	}
	if(var_current_weapon.var_isRiotShield || namespace_zm_utility::function_is_hero_weapon(var_current_weapon))
	{
		return 0;
	}
	if(!namespace_zm_utility::function_is_player_valid(self) || self.var_IS_DRINKING > 0 || namespace_zm_utility::function_is_placeable_mine(var_current_weapon) || namespace_zm_equipment::function_is_equipment(var_current_weapon) || self namespace_zm_utility::function_is_player_revive_tool(var_current_weapon) || level.var_weaponNone == var_current_weapon || self namespace_zm_equipment::function_hacker_active())
	{
		return 0;
	}
	switch(var_current_weapon.var_name)
	{
		case "elemental_bow":
		case "elemental_bow_demongate":
		case "elemental_bow_rune_prison":
		case "elemental_bow_storm":
		case "elemental_bow_wolf":
		case "staff_air":
		case "staff_air_upgraded":
		case "staff_fire":
		case "staff_fire_upgraded":
		case "staff_lightning":
		case "staff_lightning_upgraded":
		case "staff_water":
		case "staff_water_upgraded":
		case "t7_staff_air":
		case "t7_staff_air_upgraded":
		case "t7_staff_fire":
		case "t7_staff_fire_upgraded":
		case "t7_staff_lightning":
		case "t7_staff_lightning_upgraded":
		case "t7_staff_water":
		case "t7_staff_water_upgraded":
		case "t8_zombie_tomahawk":
		{
			return 0;
			break;
		}
	}
	return 1;
}

/*
	Name: function_create_unitrigger
	Namespace: namespace_ecdf5e21
	Checksum: 0x424F4353
	Offset: 0x1E10
	Size: 0x210
	Parameters: 5
	Flags: None
	Line Number: 506
*/
function function_create_unitrigger(var_str_hint, var_n_radius, var_func_prompt_and_visibility, var_func_unitrigger_logic, var_s_trigger_type)
{
	if(!isdefined(var_n_radius))
	{
		var_n_radius = 15;
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
	self.var_s_unitrigger.var_script_width = 15;
	self.var_s_unitrigger.var_script_height = 15;
	self.var_s_unitrigger.var_script_length = 15;
	self.var_s_unitrigger.var_require_look_at = 1;
	self.var_s_unitrigger function_SetHintLowPriority(1);
	self.var_s_unitrigger.var_related_parent = self;
	self.var_s_unitrigger.var_radius = var_n_radius;
	namespace_zm_unitrigger::function_unitrigger_force_per_player_triggers(self.var_s_unitrigger, 1);
	self.var_s_unitrigger.var_prompt_and_visibility_func = var_func_prompt_and_visibility;
	namespace_zm_unitrigger::function_register_static_unitrigger(self.var_s_unitrigger, var_func_unitrigger_logic);
}

/*
	Name: function_unitrigger_logic
	Namespace: namespace_ecdf5e21
	Checksum: 0x424F4353
	Offset: 0x2028
	Size: 0xA8
	Parameters: 0
	Flags: None
	Line Number: 552
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
	Name: function_bf229247
	Namespace: namespace_ecdf5e21
	Checksum: 0x424F4353
	Offset: 0x20D8
	Size: 0x110
	Parameters: 2
	Flags: None
	Line Number: 584
*/
function function_bf229247(var_eb70b91d, var_dw_weapon)
{
	self waittill("hash_690bf263");
	if(isdefined(var_dw_weapon))
	{
		var_dw_weapon.var_ammoclip = undefined;
		var_dw_weapon.var_b71eaadf = undefined;
		var_dw_weapon.var_a39a2843 = undefined;
		var_dw_weapon function_delete();
	}
	var_eb70b91d.var_ammoclip = undefined;
	var_eb70b91d.var_b71eaadf = undefined;
	var_eb70b91d.var_a39a2843 = undefined;
	var_eb70b91d function_delete();
	if(isdefined(self.var_e9e92a5b.var_fce7951c))
	{
		self.var_e9e92a5b.var_fce7951c function_delete();
	}
	namespace_zm_unitrigger::function_unregister_unitrigger(self.var_s_unitrigger);
	self function_delete();
}

/*
	Name: function_1c800b52
	Namespace: namespace_ecdf5e21
	Checksum: 0x424F4353
	Offset: 0x21F0
	Size: 0x180
	Parameters: 1
	Flags: None
	Line Number: 616
*/
function function_1c800b52(var_eb70b91d)
{
	self endon("hash_690bf263");
	while(isdefined(self))
	{
		self waittill("hash_trigger_activated", var_player);
		if(!namespace_zm_utility::function_is_player_valid(var_player) || var_player namespace_laststand::function_player_is_in_laststand())
		{
			continue;
		}
		if(level namespace_flag::function_get("loot_mode_active"))
		{
			var_8dbb9cda = var_eb70b91d.var_stored_weapon namespace_fdf6e22f::function_6bf2aeab();
			var_eb70b91d.var_b71eaadf = var_player.var_d79f52bf[var_8dbb9cda].var_stock;
		}
		var_player namespace_zm_weapons::function_weapon_give(var_eb70b91d, 0, 0, 1, 1);
		if(var_player.var_f4d01b67["pickup_ui"] == 0)
		{
			var_player thread namespace_97ac1184::function_8c165b4d("Data", "PickupUI", "Weapon,zmu_ui_pickup_weapon", 1, 1);
		}
		namespace_zm_unitrigger::function_unregister_unitrigger(self.var_s_unitrigger);
		self notify("hash_690bf263");
	}
}

/*
	Name: function_233ac813
	Namespace: namespace_ecdf5e21
	Checksum: 0x424F4353
	Offset: 0x2378
	Size: 0xF0
	Parameters: 1
	Flags: None
	Line Number: 651
*/
function function_233ac813(var_fadetime)
{
	if(var_fadetime == 0)
	{
	}
	else
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
}

/*
	Name: function_8d50f4a4
	Namespace: namespace_ecdf5e21
	Checksum: 0x424F4353
	Offset: 0x2470
	Size: 0x90
	Parameters: 0
	Flags: None
	Line Number: 697
*/
function function_8d50f4a4()
{
	self function_Bobbing((0, 0, 1), 3.5, function_randomIntRange(6, 9));
	while(isdefined(self))
	{
		self function_RotateYaw(360, function_randomIntRange(6, 7));
		wait(6);
	}
}

/*
	Name: function_54faf03e
	Namespace: namespace_ecdf5e21
	Checksum: 0x424F4353
	Offset: 0x2508
	Size: 0x5E4
	Parameters: 4
	Flags: None
	Line Number: 717
*/
function function_54faf03e(var_weapon, var_a39a2843, var_timer, var_camo)
{
	wait(0.05);
	level namespace_flag::function_wait_till("initial_blackscreen_passed");
	if(!isdefined(self.var_script_label))
	{
		self.var_script_label = "smg_standard";
	}
	if(!isdefined(self.var_script_noteworthy))
	{
		self.var_script_noteworthy = 0;
	}
	if(!isdefined(self.var_script_wait))
	{
		self.var_script_wait = 0;
	}
	if(!isdefined(self.var_script_int))
	{
		self.var_script_int = 15;
	}
	var_eb70b91d = function_spawnstruct();
	var_eb70b91d.var_stored_weapon = function_GetWeapon(var_weapon);
	var_eb70b91d.var_7bf88f47 = var_a39a2843;
	var_eb70b91d.var_e9e92a5b = namespace_zm_utility::function_spawn_buildkit_weapon_model(function_GetPlayers()[0], var_eb70b91d.var_stored_weapon, var_camo, self.var_origin + VectorScale((0, 0, 1), 15));
	var_eb70b91d.var_e9e92a5b.var_script_noteworthy = "dropped_weapon_waypoint";
	var_eb70b91d.var_e9e92a5b.var_stored_weapon = var_eb70b91d.var_stored_weapon;
	var_eb70b91d.var_e9e92a5b function_EnableLinkTo();
	if(var_eb70b91d.var_stored_weapon.var_isDualWield)
	{
		var_dweapon = var_eb70b91d.var_stored_weapon;
		if(isdefined(var_eb70b91d.var_stored_weapon.var_dualWieldWeapon) && var_eb70b91d.var_stored_weapon.var_dualWieldWeapon != level.var_weaponNone)
		{
			var_dweapon = var_eb70b91d.var_stored_weapon.var_dualWieldWeapon;
		}
		var_eb70b91d.var_e9e92a5b.var_fce7951c = namespace_zm_utility::function_spawn_buildkit_weapon_model(function_GetPlayers()[0], var_dweapon, var_camo, self.var_origin + (-3, -3, 12));
		var_eb70b91d.var_e9e92a5b.var_fce7951c function_LinkTo(var_eb70b91d.var_e9e92a5b);
	}
	wait(0.8);
	if(isdefined(var_eb70b91d.var_e9e92a5b))
	{
		if(namespace_zm_weapons::function_is_weapon_upgraded(var_eb70b91d.var_stored_weapon))
		{
			var_eb70b91d.var_e9e92a5b namespace_clientfield::function_set("weapon_drop_level" + var_eb70b91d.var_7bf88f47 + "_enable_keyline", 1);
			var_eb70b91d.var_e9e92a5b namespace_clientfield::function_set("weapon_drop_level" + var_eb70b91d.var_7bf88f47 + "_fx", 1);
			if(isdefined(var_eb70b91d.var_e9e92a5b.var_fce7951c))
			{
				var_eb70b91d.var_e9e92a5b.var_fce7951c namespace_clientfield::function_set("weapon_drop_level" + var_eb70b91d.var_7bf88f47 + "_enable_keyline", 1);
			}
		}
		else
		{
			var_eb70b91d.var_e9e92a5b namespace_clientfield::function_set("weapon_drop_enable_keyline", 1);
			var_eb70b91d.var_e9e92a5b namespace_clientfield::function_set("weapon_drop_unpacked_fx", 1);
			if(isdefined(var_eb70b91d.var_e9e92a5b.var_fce7951c))
			{
				var_eb70b91d.var_e9e92a5b.var_fce7951c namespace_clientfield::function_set("weapon_drop_enable_keyline", 1);
			}
		}
		var_eb70b91d.var_e9e92a5b thread function_233ac813(var_timer);
		if(isdefined(var_eb70b91d.var_e9e92a5b.var_fce7951c))
		{
			var_eb70b91d.var_e9e92a5b.var_fce7951c thread function_233ac813(var_timer);
		}
	}
	var_eb70b91d.var_e9e92a5b thread function_8d50f4a4();
	var_eb70b91d.var_e9e92a5b thread function_bf229247(var_eb70b91d);
	var_eb70b91d.var_e9e92a5b.var_displayName = var_eb70b91d.var_stored_weapon.var_displayName;
	var_eb70b91d.var_e9e92a5b function_create_unitrigger("Hold ^3&&1^7 to Pickup " + var_eb70b91d.var_e9e92a5b.var_displayName, undefined, &function_8d35bc1b);
	var_eb70b91d.var_e9e92a5b thread function_1c800b52(var_eb70b91d);
}

