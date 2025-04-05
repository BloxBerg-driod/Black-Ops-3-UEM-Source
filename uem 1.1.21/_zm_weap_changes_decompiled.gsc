#include scripts\codescripts\struct;
#include scripts\shared\ai\systems\gib;
#include scripts\shared\ai\zombie_death;
#include scripts\shared\ai\zombie_utility;
#include scripts\shared\ai_shared;
#include scripts\shared\array_shared;
#include scripts\shared\callbacks_shared;
#include scripts\shared\clientfield_shared;
#include scripts\shared\flag_shared;
#include scripts\shared\laststand_shared;
#include scripts\shared\math_shared;
#include scripts\shared\scene_shared;
#include scripts\shared\system_shared;
#include scripts\shared\util_shared;
#include scripts\shared\weapons\_weaponobjects;
#include scripts\zm\_util;
#include scripts\zm\_zm;
#include scripts\zm\_zm_audio;
#include scripts\zm\_zm_equipment;
#include scripts\zm\_zm_laststand;
#include scripts\zm\_zm_lightning_chain;
#include scripts\zm\_zm_spawner;
#include scripts\zm\_zm_stats;
#include scripts\zm\_zm_unitrigger;
#include scripts\zm\_zm_utility;
#include scripts\zm\_zm_weapon_upgrade_system;
#include scripts\zm\_zm_weapons;

#namespace namespace_61461ca0;

/*
	Name: function___init__sytem__
	Namespace: namespace_61461ca0
	Checksum: 0x424F4353
	Offset: 0x768
	Size: 0x38
	Parameters: 0
	Flags: AutoExec
	Line Number: 40
*/
function autoexec function___init__sytem__()
{
	namespace_system::function_register("zm_weap_changes", &function___init__, undefined, undefined);
}

/*
	Name: function___init__
	Namespace: namespace_61461ca0
	Checksum: 0x424F4353
	Offset: 0x7A8
	Size: 0x48
	Parameters: 0
	Flags: None
	Line Number: 55
*/
function function___init__()
{
	namespace_callback::function_on_connect(&function_on_player_connect);
	namespace_callback::function_on_spawned(&function_on_player_spawned);
}

/*
	Name: function_on_player_connect
	Namespace: namespace_61461ca0
	Checksum: 0x424F4353
	Offset: 0x7F8
	Size: 0x20
	Parameters: 0
	Flags: None
	Line Number: 71
*/
function function_on_player_connect()
{
	self thread function_31df6805();
}

/*
	Name: function_on_player_spawned
	Namespace: namespace_61461ca0
	Checksum: 0x424F4353
	Offset: 0x820
	Size: 0x8
	Parameters: 0
	Flags: None
	Line Number: 86
*/
function function_on_player_spawned()
{
}

/*
	Name: function_7136bbac
	Namespace: namespace_61461ca0
	Checksum: 0x424F4353
	Offset: 0x830
	Size: 0xF98
	Parameters: 0
	Flags: None
	Line Number: 100
*/
function function_7136bbac()
{
	self endon("hash_bled_out");
	self endon("hash_spawned_player");
	self endon("hash_disconnect");
	wait(0.05);
	level namespace_flag::function_wait_till("initial_blackscreen_passed");
	for(;;)
	{
		wait(0.05);
		var_time = 0;
		if(self function_meleeButtonPressed())
		{
			while(self function_meleeButtonPressed())
			{
				var_time = var_time + 0.05;
				if(var_time >= 1)
				{
					if(self function_GetCurrentWeapon() == function_GetWeapon("t9_me_knife_american") || self function_GetCurrentWeapon() == function_GetWeapon("t9_me_knife_american_up"))
					{
					}
					else
					{
						self.var_a936eadf = function_GetWeapon("t9_me_knife_american");
						if(isdefined(self namespace_5e1f56dc::function_1239e0ad(function_GetWeapon("t9_me_knife_american_up"))))
						{
							self.var_a936eadf = function_GetWeapon("t9_me_knife_american_up");
						}
						var_weapon_limit = namespace_zm_utility::function_get_player_weapon_limit(self);
						var_primaryWeapons = self function_GetWeaponsListPrimaries();
						var_current_weapon = self function_GetCurrentWeapon();
						self.var_f81f153 = function_spawnstruct();
						self.var_f81f153.var_stored_weapon = var_current_weapon;
						var_7750a3aa = self namespace_5e1f56dc::function_1239e0ad(var_current_weapon);
						var_ed5e1bff = self namespace_5e1f56dc::function_e942fd68(var_current_weapon);
						function_ArrayRemoveValue(self.var_fb56a719, var_7750a3aa);
						self.var_f81f153.var_a39a2843 = var_7750a3aa.var_a39a2843;
						var_480fed80 = self namespace_5e1f56dc::function_1c1990e8(var_current_weapon);
						var_camo_index = self.var_fa202141["player_favouritecamo"];
						var_camo_index = var_480fed80.var_pap_camo_to_use;
						var_camo_index = var_480fed80.var_pap_camo_to_use;
						var_camo_index = 44;
						break;
						var_camo_index = 42;
						break;
						var_camo_index = 45;
						break;
						var_camo_index = 46;
						break;
						var_camo_index = 47;
						break;
						var_camo_index = 41;
						break;
						var_camo_index = 38;
						break;
						var_camo_index = 43;
						break;
						var_camo_index = 36;
						break;
						var_camo_index = 22;
						break;
						var_camo_index = 48;
						break;
						var_camo_index = 49;
						break;
						var_camo_index = 26;
						break;
						var_camo_index = 25;
						break;
						var_camo_index = 28;
						break;
						var_camo_index = 27;
						break;
						var_camo_index = self.var_fa202141["player_favouritecamo"];
						var_camo_index = var_480fed80.var_pap_camo_to_use;
						var_camo_index = var_480fed80.var_pap_camo_to_use;
					}
					if(var_primaryWeapons.size >= var_weapon_limit)
					{
						if(isdefined(var_7750a3aa))
						{
						}
						if(isdefined(self.var_fa202141["player_specifiedcamo"]) && self.var_fa202141["player_specifiedcamo"] > 0)
						{
							if(isdefined(self.var_fa202141["player_favouritecamo"]) && self.var_fa202141["player_favouritecamo"] > 0)
							{
								if(var_480fed80.var_4c25c2f2 >= self.var_fa202141["player_favouritecamo"])
								{
								}
								else
								{
								}
							}
							else
							{
							}
							switch(self.var_fa202141["player_specifiedcamo"])
							{
								case 2:
								{
									if(self.var_pers["christmas_camo"] == 1)
									{
									}
								}
								case 3:
								{
									if(self.var_pers["halloween_camo"] == 1)
									{
									}
								}
								case 4:
								{
									if(isdefined(level.var_18ffd3f2[self function_getxuid(1)]) && (level.var_18ffd3f2[self function_getxuid(1)].var_rank == "bronze" || level.var_18ffd3f2[self function_getxuid(1)].var_rank == "silver" || level.var_18ffd3f2[self function_getxuid(1)].var_rank == "gold" || level.var_18ffd3f2[self function_getxuid(1)].var_rank == "master" || level.var_18ffd3f2[self function_getxuid(1)].var_rank == "paragon" || level.var_18ffd3f2[self function_getxuid(1)].var_rank == "ultimate"))
									{
									}
								}
								case 5:
								{
									if(isdefined(level.var_18ffd3f2[self function_getxuid(1)]) && (level.var_18ffd3f2[self function_getxuid(1)].var_rank == "silver" || level.var_18ffd3f2[self function_getxuid(1)].var_rank == "gold" || level.var_18ffd3f2[self function_getxuid(1)].var_rank == "master" || level.var_18ffd3f2[self function_getxuid(1)].var_rank == "paragon" || level.var_18ffd3f2[self function_getxuid(1)].var_rank == "ultimate"))
									{
									}
								}
								case 6:
								{
									if(isdefined(level.var_18ffd3f2[self function_getxuid(1)]) && (level.var_18ffd3f2[self function_getxuid(1)].var_rank == "gold" || level.var_18ffd3f2[self function_getxuid(1)].var_rank == "master" || level.var_18ffd3f2[self function_getxuid(1)].var_rank == "paragon" || level.var_18ffd3f2[self function_getxuid(1)].var_rank == "ultimate"))
									{
									}
								}
								case 7:
								{
									if(isdefined(level.var_18ffd3f2[self function_getxuid(1)]) && (level.var_18ffd3f2[self function_getxuid(1)].var_rank == "master" || level.var_18ffd3f2[self function_getxuid(1)].var_rank == "paragon" || level.var_18ffd3f2[self function_getxuid(1)].var_rank == "ultimate"))
									{
									}
								}
								case 8:
								{
									if(isdefined(level.var_18ffd3f2[self function_getxuid(1)]) && (level.var_18ffd3f2[self function_getxuid(1)].var_rank == "paragon" || level.var_18ffd3f2[self function_getxuid(1)].var_rank == "ultimate"))
									{
									}
								}
								case 9:
								{
									if(isdefined(level.var_18ffd3f2[self function_getxuid(1)]) && level.var_18ffd3f2[self function_getxuid(1)].var_rank == "ultimate")
									{
									}
								}
								case 10:
								{
									if(self.var_b74a3cd1["prestige_legend"] >= 1)
									{
									}
								}
								case 11:
								{
									if(self.var_d31d6052 >= 25)
									{
									}
								}
								case 12:
								{
									if(self.var_pers["halloween_camo_2"] >= 1)
									{
									}
								}
								case 13:
								{
									if(self.var_pers["christmas_camo_2"] >= 1)
									{
									}
								}
								case 20:
								{
									if(self.var_pers["motd_camo_0"] >= 1)
									{
									}
								}
								case 21:
								{
									if(self.var_pers["motd_camo_1"] >= 1)
									{
									}
								}
								case 22:
								{
									if(self.var_pers["motd_camo_2"] >= 1)
									{
									}
								}
								case 23:
								{
									if(self.var_pers["motd_camo_3"] >= 1)
									{
									}
								}
								default
								{
									if(isdefined(self.var_fa202141["player_favouritecamo"]) && self.var_fa202141["player_favouritecamo"] > 0)
									{
										if(var_480fed80.var_4c25c2f2 >= self.var_fa202141["player_favouritecamo"])
										{
										}
										else
										{
										}
									}
									else
									{
									}
								}
							}
						}
						else if(isdefined(self.var_fa202141["player_favouritecamo"]) && self.var_fa202141["player_favouritecamo"] > 0)
						{
							if(var_480fed80.var_4c25c2f2 >= self.var_fa202141["player_favouritecamo"])
							{
								var_camo_index = self.var_fa202141["player_favouritecamo"];
							}
							else
							{
								var_camo_index = var_480fed80.var_pap_camo_to_use;
							}
						}
						else if(isdefined(var_480fed80.var_pap_camo_to_use))
						{
							var_camo_index = var_480fed80.var_pap_camo_to_use;
						}
						else
						{
							var_camo_index = namespace_zm_weapons::function_get_pack_a_punch_camo_index(undefined);
						}
						if(isdefined(var_current_weapon))
						{
							var_ammoclip = self function_GetWeaponAmmoClip(var_current_weapon);
							var_b71eaadf = self function_GetWeaponAmmoStock(var_current_weapon);
							var_dw_weapon = var_current_weapon.var_dualWieldWeapon;
							if(var_dw_weapon != level.var_weaponNone && isdefined(var_dw_weapon))
							{
								var_6fa3e4b2 = self function_GetWeaponAmmoClip(var_dw_weapon);
							}
							else
							{
								var_6fa3e4b2 = 0;
							}
						}
						if(var_current_weapon.var_isDualWield)
						{
							var_dweapon = var_current_weapon;
							if(isdefined(var_current_weapon.var_dualWieldWeapon) && var_current_weapon.var_dualWieldWeapon != level.var_weaponNone)
							{
								var_dweapon = var_current_weapon.var_dualWieldWeapon;
							}
							self.var_f81f153.var_ammoclip = var_ammoclip;
							self.var_f81f153.var_b71eaadf = var_b71eaadf;
							self.var_f81f153.var_6fa3e4b2 = var_6fa3e4b2;
						}
						else
						{
							self.var_f81f153.var_ammoclip = var_ammoclip;
							self.var_f81f153.var_b71eaadf = var_b71eaadf;
						}
						self function_TakeWeapon(self.var_f81f153.var_stored_weapon);
					}
					self function_EnableWeaponCycling();
					self namespace_zm_weapons::function_give_build_kit_weapon(self.var_a936eadf);
					self function_SwitchToWeapon(self.var_a936eadf);
					wait(0.5);
					self thread function_105ae987();
					self thread function_ba2444c1();
					break;
				}
				wait(0.05);
			}
		}
	}
}

/*
	Name: function_105ae987
	Namespace: namespace_61461ca0
	Checksum: 0x424F4353
	Offset: 0x17D0
	Size: 0xD8
	Parameters: 0
	Flags: None
	Line Number: 386
*/
function function_105ae987()
{
	self endon("hash_death");
	self endon("hash_disconnect");
	self endon("hash_player_downed");
	self endon("hash_76e3c5b0");
	for(;;)
	{
		wait(0.05);
		self waittill("hash_weapon_change", var_newWeapon, var_oldWeapon);
		var_12030910 = namespace_zm_weapons::function_get_upgrade_weapon(var_newWeapon, 0);
		if(var_newWeapon != level.var_weaponNone && var_newWeapon != self.var_a936eadf && var_newWeapon != var_12030910)
		{
		}
	}
	else
	{
	}
	self thread function_79f79d20();
}

/*
	Name: function_ba2444c1
	Namespace: namespace_61461ca0
	Checksum: 0x424F4353
	Offset: 0x18B0
	Size: 0x58
	Parameters: 0
	Flags: None
	Line Number: 417
*/
function function_ba2444c1()
{
	self endon("hash_76e3c5b0");
	self namespace_util::function_waittill_any_return("fake_death", "death", "player_downed");
	self thread function_79f79d20();
}

/*
	Name: function_79f79d20
	Namespace: namespace_61461ca0
	Checksum: 0x424F4353
	Offset: 0x1910
	Size: 0x228
	Parameters: 0
	Flags: None
	Line Number: 434
*/
function function_79f79d20()
{
	self endon("hash_death");
	self endon("hash_player_downed");
	self function_TakeWeapon(self.var_a936eadf);
	self notify("hash_76e3c5b0");
	if(isdefined(self.var_f81f153.var_stored_weapon))
	{
		var_weapon = self namespace_zm_weapons::function_give_build_kit_weapon(self.var_f81f153.var_stored_weapon, self.var_f81f153);
		if(isdefined(self.var_f81f153) && isdefined(self.var_f81f153.var_ammoclip) || (isdefined(self.var_f81f153) && isdefined(self.var_f81f153.var_b71eaadf)) || (isdefined(self.var_f81f153) && isdefined(self.var_f81f153.var_6fa3e4b2)))
		{
			self function_SetWeaponAmmoClip(var_weapon, self.var_f81f153.var_ammoclip);
			self function_SetWeaponAmmoStock(var_weapon, self.var_f81f153.var_b71eaadf);
			if(isdefined(var_weapon.var_dualWieldWeapon))
			{
				var_dw_weapon = var_weapon.var_dualWieldWeapon;
				if(var_dw_weapon != level.var_weaponNone)
				{
					self function_SetWeaponAmmoClip(var_dw_weapon, self.var_f81f153.var_6fa3e4b2);
				}
			}
		}
		else if(self function_hasPerk("specialty_extraammo"))
		{
			self function_giveMaxAmmo(var_weapon);
		}
		else
		{
			self function_GiveStartAmmo(var_weapon);
		}
	}
	else
	{
		self namespace_zm_weapons::function_switch_back_primary_weapon();
	}
	self.var_f81f153 = undefined;
}

/*
	Name: function_7418fa1a
	Namespace: namespace_61461ca0
	Checksum: 0x424F4353
	Offset: 0x1B40
	Size: 0x1D0
	Parameters: 3
	Flags: None
	Line Number: 482
*/
function function_7418fa1a(var_8478c26e, var_f599c2cc, var_e38d48a9)
{
	self endon("hash_death");
	while(1)
	{
		self waittill("hash_projectile_impact", var_w_weapon, var_v_position, var_n_radius, var_e_projectile, var_v_normal);
		if(var_w_weapon.var_name == var_8478c26e || var_w_weapon.var_name == var_f599c2cc || var_w_weapon.var_name == var_e38d48a9)
		{
			if(var_w_weapon.var_name == var_8478c26e || var_w_weapon.var_name == var_f599c2cc)
			{
				if(isdefined(var_e_projectile))
				{
					function_PlayFXOnTag(level.var__effect["quantum_raygun_explode"], var_e_projectile, "tag_origin");
				}
				function_RadiusDamage(var_v_position, 128, level.var_zombie_health, level.var_zombie_health, self, "MOD_UNKNOWN", var_w_weapon);
			}
			else
			{
				var_pos = namespace_zm_utility::function_GROUNDPOS(var_v_position.var_origin) + VectorScale((0, 0, 1), 8);
				self thread function_120ea33f(var_w_weapon, var_v_position, var_pos, var_n_radius, var_e_projectile, var_v_normal);
			}
		}
	}
}

/*
	Name: function_120ea33f
	Namespace: namespace_61461ca0
	Checksum: 0x424F4353
	Offset: 0x1D18
	Size: 0x248
	Parameters: 6
	Flags: None
	Line Number: 517
*/
function function_120ea33f(var_w_weapon, var_v_pos, var_v_pos_final, var_n_radius, var_e_projectile, var_v_normal)
{
	self endon("hash_disconnect");
	namespace_util::function_wait_network_frame();
	var_model = namespace_util::function_spawn_model("tag_origin", var_e_projectile.var_origin, (0, 0, 0));
	namespace_util::function_wait_network_frame();
	if(isdefined(var_model))
	{
		var_valid_poi = namespace_zm_utility::function_check_point_in_enabled_zone(var_model.var_origin, undefined, undefined);
		var_valid_poi = var_model function_move_valid_poi_to_navmesh(var_valid_poi);
		var_valid_poi = var_model [[level.var_check_valid_poi]](var_valid_poi);
		if(var_valid_poi)
		{
			var_691d0760 = namespace_util::function_spawn_model("tag_origin", var_model.var_origin + VectorScale((0, 0, 1), 50), var_model.var_angles);
			var_691d0760 = function_PlayFXOnTag(level.var__effect["quantum_raygun_blackhole_loop"], var_691d0760, "tag_origin");
			wait(0.5);
			var_model thread function_e3372167(self, var_w_weapon);
			if(isdefined(var_691d0760))
			{
				var_691d0760 function_delete();
			}
		}
	}
	else
	{
		var_model.var_script_noteworthy = undefined;
		function_PlayFXOnTag(level.var__effect["grenade_samantha_steal"], var_model, "tag_origin");
		if(isdefined(var_model))
		{
			var_model function_delete();
		}
	}
}

/*
	Name: function_e3372167
	Namespace: namespace_61461ca0
	Checksum: 0x424F4353
	Offset: 0x1F68
	Size: 0x490
	Parameters: 2
	Flags: None
	Line Number: 561
*/
function function_e3372167(var_owner, var_w_weapon)
{
	if(!isdefined(self))
	{
		return;
	}
	self function_StopLoopSound(0.05);
	self function_playsound("crossbow_blast_pre_explosion");
	var_5cb0b0e8 = namespace_util::function_spawn_model("tag_origin", self.var_origin + VectorScale((0, 0, 1), 50), self.var_angles);
	var_5cb0b0e8 = function_PlayFXOnTag(level.var__effect["quantum_raygun_blackhole_sm"], var_5cb0b0e8, "tag_origin");
	wait(0.6);
	if(isdefined(var_5cb0b0e8))
	{
		var_5cb0b0e8 function_delete();
	}
	var_441797b1 = namespace_util::function_spawn_model("tag_origin", self.var_origin + VectorScale((0, 0, 1), 50), self.var_angles);
	var_441797b1 = function_PlayFXOnTag(level.var__effect["quantum_raygun_blackhole_explode"], var_441797b1, "tag_origin");
	self function_playsound("crossbow_blast_main");
	wait(0.05);
	self function_Hide();
	if(var_w_weapon.var_name == "ray_gun_elemental_2_upgraded")
	{
		var_480fed80 = var_owner namespace_5e1f56dc::function_1239e0ad(var_w_weapon);
		if(isdefined(var_480fed80))
		{
			if(var_480fed80.var_a39a2843 >= 1)
			{
				var_max_zombies = 12 + 2 * var_480fed80.var_a39a2843;
			}
		}
		else
		{
			var_max_zombies = 12;
		}
	}
	else
	{
		var_max_zombies = 10;
	}
	var_zombies = namespace_Array::function_get_all_closest(self.var_origin, function_GetAITeamArray(level.var_zombie_team), undefined, undefined, 240);
	for(var_i = 0; var_i < var_max_zombies; var_i++)
	{
		if(!isdefined(var_zombies[var_i]) || !function_isalive(var_zombies[var_i]))
		{
			continue;
		}
		var_dist_sq = function_DistanceSquared(self.var_origin, var_zombies[var_i].var_origin);
		if(var_w_weapon.var_name == "ray_gun_elemental_2_upgraded")
		{
			if(var_dist_sq < 193600)
			{
				var_owner thread function_8d5b17df(var_zombies[var_i], var_w_weapon);
				continue;
			}
			if(var_dist_sq > 193600)
			{
				continue;
			}
		}
		else if(var_dist_sq < 90000)
		{
			var_owner thread function_8d5b17df(var_zombies[var_i], var_w_weapon);
			continue;
		}
		if(var_dist_sq > 90000)
		{
			continue;
		}
		if(0 == var_zombies[var_i] function_damageConeTrace(self.var_origin, self))
		{
			continue;
		}
		var_owner thread function_8d5b17df(var_zombies[var_i], var_w_weapon);
	}
	if(isdefined(var_441797b1))
	{
		var_441797b1 function_delete();
	}
	self function_delete();
}

/*
	Name: function_8d5b17df
	Namespace: namespace_61461ca0
	Checksum: 0x424F4353
	Offset: 0x2400
	Size: 0x68
	Parameters: 2
	Flags: None
	Line Number: 652
*/
function function_8d5b17df(var_ai, var_w_weapon)
{
	self endon("hash_disconnect");
	if(!isdefined(var_ai) || !function_isalive(var_ai))
	{
		return;
	}
	var_ai thread function_a541545(self, var_w_weapon);
}

/*
	Name: function_a541545
	Namespace: namespace_61461ca0
	Checksum: 0x424F4353
	Offset: 0x2470
	Size: 0x220
	Parameters: 2
	Flags: None
	Line Number: 672
*/
function function_a541545(var_player, var_w_weapon)
{
	self endon("hash_death");
	var_player thread namespace_zm_audio::function_create_and_play_dialog("kill", "sword_slam");
	wait(0.05);
	if(var_w_weapon.var_name == "ray_gun_elemental_2_upgraded")
	{
		var_n_damage = namespace_5e1f56dc::function_bcb41215(undefined, var_player, 1140, undefined, undefined, var_w_weapon);
		if(var_n_damage > self.var_health)
		{
			function_PlayFXOnTag(level.var__effect["crossbow_skull_zombie_explode"], self, "j_head");
			if(isdefined(self) && function_IsActor(self))
			{
				namespace_GibServerUtils::function_GibHead(self);
			}
		}
		self function_DoDamage(var_n_damage, self.var_origin, var_player, undefined, "none", "MOD_EXPLOSIVE", 0, var_w_weapon);
	}
	else
	{
		var_n_damage = namespace_5e1f56dc::function_bcb41215(undefined, var_player, 800, undefined, undefined, var_w_weapon);
		if(var_n_damage > self.var_health)
		{
			function_PlayFXOnTag(level.var__effect["crossbow_skull_zombie_explode"], self, "j_head");
			if(isdefined(self) && function_IsActor(self))
			{
				namespace_GibServerUtils::function_GibHead(self);
			}
		}
		self function_DoDamage(var_n_damage, self.var_origin, var_player, undefined, "none", "MOD_EXPLOSIVE", 0, var_w_weapon);
		return;
	}
}

/*
	Name: function_862aadab
	Namespace: namespace_61461ca0
	Checksum: 0x424F4353
	Offset: 0x2698
	Size: 0x150
	Parameters: 1
	Flags: None
	Line Number: 716
*/
function function_862aadab(var_random_gibs)
{
	if(isdefined(self) && function_IsActor(self))
	{
		if(!var_random_gibs || function_RandomInt(100) < 50)
		{
			namespace_GibServerUtils::function_GibHead(self);
			return 1;
		}
		if(!var_random_gibs || function_RandomInt(100) < 50)
		{
			namespace_GibServerUtils::function_GibLeftArm(self);
			return 0;
		}
		if(!var_random_gibs || function_RandomInt(100) < 50)
		{
			namespace_GibServerUtils::function_GibRightArm(self);
			return 0;
		}
		if(!var_random_gibs || function_RandomInt(100) < 50)
		{
			namespace_GibServerUtils::function_GibLegs(self);
			return 0;
		}
		return 0;
	}
	return 0;
}

/*
	Name: function_83f44f5
	Namespace: namespace_61461ca0
	Checksum: 0x424F4353
	Offset: 0x27F0
	Size: 0x98
	Parameters: 2
	Flags: None
	Line Number: 755
*/
function function_83f44f5(var_ai_enemy, var_289e02fc)
{
	return function_isalive(var_ai_enemy) && (!(isdefined(var_ai_enemy.var_98056717) && var_ai_enemy.var_98056717)) && function_BulletTracePassed(var_ai_enemy function_GetCentroid(), var_289e02fc + VectorScale((0, 0, 1), 48), 0, undefined);
}

/*
	Name: function_c361c061
	Namespace: namespace_61461ca0
	Checksum: 0x424F4353
	Offset: 0x2890
	Size: 0x190
	Parameters: 1
	Flags: None
	Line Number: 770
*/
function function_c361c061(var_w_weapon)
{
	self endon("hash_death");
	var_6b9db46d = function_GetWeapon(var_w_weapon);
	while(1)
	{
		self waittill("hash_weapon_change", var_9f85aad5, var_prev_weapon);
		if(var_9f85aad5 == var_6b9db46d)
		{
			if(!(isdefined(self.var_cea033bb) && self.var_cea033bb))
			{
				if(isdefined(self.var_hintelem))
				{
					self.var_hintelem function_setText("");
					self.var_hintelem function_destroy();
				}
				if(self function_IsSplitscreen())
				{
					self thread namespace_zm_equipment::function_show_hint_text("Press ^3[{+attack}]^7 to shoot\nHold ^3[{+attack}]^7 to shoot a charged shot\nCharged shots use extra ammo", 8, 1, 150);
				}
				else
				{
					self thread namespace_zm_equipment::function_show_hint_text("Press ^3[{+attack}]^7 to shoot\nHold ^3[{+attack}]^7 to shoot a charged shot\nCharged shots use extra ammo", 8);
				}
				self.var_cea033bb = 1;
			}
			self namespace_util::function_waittill_any_timeout(1, "weapon_change_complete", "death");
		}
		else
		{
		}
	}
}

/*
	Name: function_c73ca1b9
	Namespace: namespace_61461ca0
	Checksum: 0x424F4353
	Offset: 0x2A28
	Size: 0x2F8
	Parameters: 1
	Flags: None
	Line Number: 814
*/
function function_c73ca1b9(var_w_weapon)
{
	self endon("hash_death");
	var_6b9db46d = function_GetWeapon(var_w_weapon);
	for(;;)
	{
		var_current_weapon = self function_GetCurrentWeapon();
		while(self function_PlayerAds() && function_IsSubStr(var_6b9db46d.var_name, var_current_weapon.var_name) && self function_GetWeaponAmmoClip(var_current_weapon) != var_current_weapon.var_clipSize)
		{
			var_480fed80 = self namespace_5e1f56dc::function_1239e0ad(var_current_weapon);
			if(isdefined(var_480fed80))
			{
				if(var_480fed80.var_a39a2843 >= 1)
				{
					var_max_zombies = 5 + 1 * var_480fed80.var_a39a2843;
				}
			}
			else
			{
				var_max_zombies = 5;
			}
			var_zombies = namespace_Array::function_get_all_closest(self.var_origin, function_GetAITeamArray(level.var_zombie_team), undefined, undefined, 300);
			if(var_zombies.size > 0)
			{
				for(var_i = 0; var_i < var_max_zombies; var_i++)
				{
					if(namespace_util::function_within_fov(self.var_origin, self.var_angles, var_zombies[var_i].var_origin + (0, 0, self.var_origin[2] - var_zombies[var_i].var_origin[2]), function_cos(30)))
					{
						var_45fe5452 = var_zombies[var_i] thread function_7c3b456a(self, var_6b9db46d, var_480fed80.var_a39a2843);
					}
				}
				if(isdefined(var_45fe5452) && var_45fe5452)
				{
					function_PlayFXOnTag(level.var__effect["quantum_raygun_sucking"], var_current_weapon, "tag_flash");
					self function_SetWeaponAmmoClip(var_current_weapon, self function_GetWeaponAmmoClip(var_current_weapon) + 1);
				}
			}
			wait(1);
		}
		wait(1);
	}
}

/*
	Name: function_7c3b456a
	Namespace: namespace_61461ca0
	Checksum: 0x424F4353
	Offset: 0x2D28
	Size: 0x280
	Parameters: 3
	Flags: None
	Line Number: 867
*/
function function_7c3b456a(var_e_player, var_w_weapon, var_a39a2843)
{
	if(function_isalive(self))
	{
		if(isdefined(var_a39a2843))
		{
			switch(var_a39a2843)
			{
				case 1:
				case 2:
				case 3:
				{
					self function_ASMSetAnimationRate(0.9);
					self function_DoDamage(self.var_maxhealth / 5, self.var_origin, var_e_player, var_e_player, undefined, "MOD_PROJECTILE_SPLASH", 0, var_w_weapon);
					break;
				}
				case 4:
				case 5:
				case 6:
				{
					self function_ASMSetAnimationRate(0.8);
					self function_DoDamage(self.var_maxhealth / 4, self.var_origin, var_e_player, var_e_player, undefined, "MOD_PROJECTILE_SPLASH", 0, var_w_weapon);
					break;
				}
				case 7:
				case 8:
				case 9:
				{
					self function_ASMSetAnimationRate(0.7);
					self function_DoDamage(self.var_maxhealth / 3, self.var_origin, var_e_player, var_e_player, undefined, "MOD_PROJECTILE_SPLASH", 0, var_w_weapon);
					break;
				}
				case 10:
				case 11:
				case 12:
				{
					self function_ASMSetAnimationRate(0.6);
					self function_DoDamage(self.var_maxhealth / 2, self.var_origin, var_e_player, var_e_player, undefined, "MOD_PROJECTILE_SPLASH", 0, var_w_weapon);
					break;
				}
			}
		}
		else
		{
			self function_DoDamage(self.var_maxhealth / 12, self.var_origin, var_e_player, var_e_player, undefined, "MOD_PROJECTILE_SPLASH", 0, var_w_weapon);
		}
		return 1;
	}
	return 0;
}

/*
	Name: function_1f6a7f03
	Namespace: namespace_61461ca0
	Checksum: 0x424F4353
	Offset: 0x2FB0
	Size: 0x20
	Parameters: 3
	Flags: None
	Line Number: 928
*/
function function_1f6a7f03(var_v_detonate, var_v_angles, var_w_weapon)
{
}

/*
	Name: function_5afe67f4
	Namespace: namespace_61461ca0
	Checksum: 0x424F4353
	Offset: 0x2FD8
	Size: 0x48
	Parameters: 1
	Flags: None
	Line Number: 942
*/
function function_5afe67f4(var_weapon)
{
	return isdefined(var_weapon) && (var_weapon.var_name == "ray_gun_elemental" || var_weapon.var_name == "ray_gun_elemental_upgraded");
}

/*
	Name: function_8dc110d1
	Namespace: namespace_61461ca0
	Checksum: 0x424F4353
	Offset: 0x3028
	Size: 0x170
	Parameters: 0
	Flags: None
	Line Number: 957
*/
function function_8dc110d1()
{
	self notify("hash_8dc110d1");
	self endon("hash_8dc110d1");
	self endon("hash_disconnect");
	while(1)
	{
		self waittill("hash_weapon_change", var_weapon);
		var_5058e7e9 = 0;
		var_d63082b2 = function_b3d16542(var_weapon);
		var_250ccd23 = undefined;
		var_a_str_weapons = self function_GetWeaponsList();
		foreach(var_str_weapon in var_a_str_weapons)
		{
			if(function_b3d16542(var_str_weapon))
			{
				var_5058e7e9 = 1;
				var_250ccd23 = var_str_weapon;
			}
		}
		if(var_d63082b2)
		{
			self thread function_3bc22848(var_weapon);
		}
	}
}

/*
	Name: function_3bc22848
	Namespace: namespace_61461ca0
	Checksum: 0x424F4353
	Offset: 0x31A0
	Size: 0x88
	Parameters: 1
	Flags: None
	Line Number: 994
*/
function function_3bc22848(var_weapon)
{
	self notify("hash_3bc22848");
	self endon("hash_3bc22848");
	self endon("hash_disconnect");
	while(function_b3d16542(var_weapon))
	{
		self function_fe30696c();
		var_weapon = self function_GetCurrentWeapon();
	}
}

/*
	Name: function_fe30696c
	Namespace: namespace_61461ca0
	Checksum: 0x424F4353
	Offset: 0x3230
	Size: 0xC0
	Parameters: 0
	Flags: None
	Line Number: 1016
*/
function function_fe30696c()
{
	self endon("hash_disconnect");
	self endon("hash_player_downed");
	self endon("hash_weapon_change");
	self endon("hash_weapon_fired");
	while(!self function_AttackButtonPressed())
	{
		wait(0.05);
	}
	var_n_old_charge = 0;
	while(1)
	{
		if(var_n_old_charge != self.var_chargeShotLevel)
		{
			self namespace_clientfield::function_set_to_player("player_quantum_raygun_charge", self.var_chargeShotLevel);
			var_n_old_charge = self.var_chargeShotLevel;
		}
		wait(0.1);
	}
	return;
}

/*
	Name: function_b3d16542
	Namespace: namespace_61461ca0
	Checksum: 0x424F4353
	Offset: 0x32F8
	Size: 0x48
	Parameters: 1
	Flags: None
	Line Number: 1049
*/
function function_b3d16542(var_w_weapon)
{
	switch(var_w_weapon.var_name)
	{
		case "ray_gun_elemental_upgraded":
		{
			return 1;
		}
		default
		{
			return 0;
		}
	}
}

/*
	Name: function_9b1a371f
	Namespace: namespace_61461ca0
	Checksum: 0x424F4353
	Offset: 0x3348
	Size: 0x30
	Parameters: 1
	Flags: None
	Line Number: 1074
*/
function function_9b1a371f(var_w_weapon)
{
	function_IPrintLnBold("Weapon: " + var_w_weapon);
}

/*
	Name: function_move_valid_poi_to_navmesh
	Namespace: namespace_61461ca0
	Checksum: 0x424F4353
	Offset: 0x3380
	Size: 0x1F0
	Parameters: 1
	Flags: None
	Line Number: 1089
*/
function function_move_valid_poi_to_navmesh(var_valid_poi)
{
	if(!(isdefined(var_valid_poi) && var_valid_poi))
	{
		return 0;
	}
	if(function_IsPointOnNavMesh(self.var_origin))
	{
		return 1;
	}
	var_v_orig = self.var_origin;
	var_queryResult = function_PositionQuery_Source_Navigation(self.var_origin, 0, level.var_VALID_POI_MAX_RADIUS, level.var_VALID_POI_HALF_HEIGHT, level.var_VALID_POI_INNER_SPACING, level.var_VALID_POI_RADIUS_FROM_EDGES);
	if(var_queryResult.var_data.size)
	{
		foreach(var_point in var_queryResult.var_data)
		{
			var_height_offset = function_Abs(self.var_origin[2] - var_point.var_origin[2]);
			if(var_height_offset > level.var_VALID_POI_HEIGHT)
			{
				continue;
			}
			if(function_BulletTracePassed(var_point.var_origin + VectorScale((0, 0, 1), 20), var_v_orig + VectorScale((0, 0, 1), 20), 0, self, undefined, 0, 0))
			{
				self.var_origin = var_point.var_origin;
				return 1;
			}
		}
	}
	return 0;
}

/*
	Name: function_31df6805
	Namespace: namespace_61461ca0
	Checksum: 0x424F4353
	Offset: 0x3578
	Size: 0x50
	Parameters: 0
	Flags: None
	Line Number: 1130
*/
function function_31df6805()
{
	self endon("hash_death");
	self endon("hash_disconnect");
	for(;;)
	{
		self waittill("hash_grenade_pullback", var_weapon);
		self thread function_beginGrenadeTracking();
	}
}

/*
	Name: function_beginGrenadeTracking
	Namespace: namespace_61461ca0
	Checksum: 0x424F4353
	Offset: 0x35D0
	Size: 0x78
	Parameters: 0
	Flags: None
	Line Number: 1151
*/
function function_beginGrenadeTracking()
{
	self endon("hash_disconnect");
	var_startTime = GetTime();
	self thread function_watchGrenadeCancel();
	self waittill("hash_grenade_fire", var_grenade, var_weapon);
	self.var_cookedTime = GetTime() - var_startTime;
	wait(2);
	self.var_cookedTime = undefined;
}

/*
	Name: function_watchGrenadeCancel
	Namespace: namespace_61461ca0
	Checksum: 0x424F4353
	Offset: 0x3650
	Size: 0xA0
	Parameters: 0
	Flags: None
	Line Number: 1172
*/
function function_watchGrenadeCancel()
{
	self endon("hash_death");
	self endon("hash_disconnect");
	self endon("hash_grenade_fire");
	waittillframeend;
	var_weapon = level.var_weaponNone;
	while(self function_IsThrowingGrenade() && var_weapon == level.var_weaponNone)
	{
		self waittill("hash_weapon_change", var_weapon);
	}
	self.var_cookedTime = undefined;
	self.var_throwingGrenade = 0;
	self.var_gotPullbackNotify = 0;
}

/*
	Name: function_watchMissileDeath
	Namespace: namespace_61461ca0
	Checksum: 0x424F4353
	Offset: 0x36F8
	Size: 0x2C
	Parameters: 0
	Flags: None
	Line Number: 1198
*/
function function_watchMissileDeath()
{
	self waittill("hash_death");
	function_ArrayRemoveValue(level.var_MissileEntities, self);
}

