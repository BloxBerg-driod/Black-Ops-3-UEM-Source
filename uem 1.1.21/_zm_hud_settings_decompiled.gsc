#include scripts\codescripts\struct;
#include scripts\shared\ai\zombie_utility;
#include scripts\shared\array_shared;
#include scripts\shared\callbacks_shared;
#include scripts\shared\clientfield_shared;
#include scripts\shared\exploder_shared;
#include scripts\shared\flag_shared;
#include scripts\shared\laststand_shared;
#include scripts\shared\lui_shared;
#include scripts\shared\math_shared;
#include scripts\shared\scene_shared;
#include scripts\shared\system_shared;
#include scripts\shared\util_shared;
#include scripts\sphynx\commands\_zm_commands;
#include scripts\sphynx\leveling\_zm_sphynx_leveling;
#include scripts\zm\_zm_equipment;
#include scripts\zm\_zm_score;
#include scripts\zm\_zm_unitrigger;
#include scripts\zm\_zm_utility;
#include scripts\zm\_zm_weapon_upgrade_system;

#namespace namespace_bb3b4960;

/*
	Name: function___init__sytem__
	Namespace: namespace_bb3b4960
	Checksum: 0x424F4353
	Offset: 0xB00
	Size: 0x40
	Parameters: 0
	Flags: AutoExec
	Line Number: 33
*/
function autoexec function___init__sytem__()
{
	namespace_system::function_register("zm_hud_settings", &function___init__, &function___main__, undefined);
}

/*
	Name: function___init__
	Namespace: namespace_bb3b4960
	Checksum: 0x424F4353
	Offset: 0xB48
	Size: 0x190
	Parameters: 0
	Flags: None
	Line Number: 48
*/
function function___init__()
{
	namespace_callback::function_on_spawned(&function_2fae5cc4);
	namespace_b2e35c83::function_a4869edc("player_settings_favorite_camo", "favorite_camo", "Sets the players Favorite Camo", &function_cbd41def, undefined, "option_on_off", undefined, undefined);
	namespace_b2e35c83::function_a4869edc("player_settings_specified_camo", "specified_camo", "Sets the players Specified Camo", &function_de537751, undefined, "option_on_off", undefined, undefined);
	namespace_b2e35c83::function_a4869edc("player_settings_specified_character", "specified_character", "Sets the players Character", &function_f023ba3c, undefined, "option_on_off", undefined, undefined);
	namespace_b2e35c83::function_a4869edc("player_settings_specified_character_hat", "specified_character_hat", "Sets the players Character Hat", &function_6e328e6e, undefined, "option_on_off", undefined, undefined);
	namespace_b2e35c83::function_a4869edc("player_settings_specified_plushie", "player_plushie", "Sets the players Pet", &function_b85bb002, undefined, "option_on_off", undefined, undefined);
}

/*
	Name: function_cbd41def
	Namespace: namespace_bb3b4960
	Checksum: 0x424F4353
	Offset: 0xCE0
	Size: 0x50
	Parameters: 1
	Flags: None
	Line Number: 68
*/
function function_cbd41def(var_34d37a48)
{
	var_34d37a48["player"].var_fa202141["player_favouritecamo"] = function_Int(var_34d37a48["value"][0]);
	return;
}

/*
	Name: function_de537751
	Namespace: namespace_bb3b4960
	Checksum: 0x424F4353
	Offset: 0xD38
	Size: 0x50
	Parameters: 1
	Flags: None
	Line Number: 84
*/
function function_de537751(var_34d37a48)
{
	var_34d37a48["player"].var_fa202141["player_specifiedcamo"] = function_Int(var_34d37a48["value"][0]);
}

/*
	Name: function_f023ba3c
	Namespace: namespace_bb3b4960
	Checksum: 0x424F4353
	Offset: 0xD90
	Size: 0x50
	Parameters: 1
	Flags: None
	Line Number: 99
*/
function function_f023ba3c(var_34d37a48)
{
	var_34d37a48["player"].var_fa202141["player_character"] = function_Int(var_34d37a48["value"][0]);
	return;
	ERROR: Exception occured: Stack empty.
}

/*
	Name: function_6e328e6e
	Namespace: namespace_bb3b4960
	Checksum: 0x424F4353
	Offset: 0xDE8
	Size: 0x50
	Parameters: 1
	Flags: None
	Line Number: 116
*/
function function_6e328e6e(var_34d37a48)
{
	var_34d37a48["player"].var_fa202141["player_characterhat"] = function_Int(var_34d37a48["value"][0]);
}

/*
	Name: function_b85bb002
	Namespace: namespace_bb3b4960
	Checksum: 0x424F4353
	Offset: 0xE40
	Size: 0x50
	Parameters: 1
	Flags: None
	Line Number: 131
*/
function function_b85bb002(var_34d37a48)
{
	var_34d37a48["player"].var_fa202141["player_pet"] = function_Int(var_34d37a48["value"][0]);
}

/*
	Name: function_48fe87b1
	Namespace: namespace_bb3b4960
	Checksum: 0x424F4353
	Offset: 0xE98
	Size: 0xF0
	Parameters: 1
	Flags: None
	Line Number: 146
*/
function function_48fe87b1(var_34d37a48)
{
	var_34d37a48["player"].var_f4d01b67["third_person_enabled"] = function_Int(0);
	var_34d37a48["player"] function_setDepthOfField(0, 0, 512, 4000, 4, 0);
	var_34d37a48["player"].var_29f6902d.var_alpha = 0;
	var_34d37a48["player"] function_SetClientThirdPerson(0);
	var_34d37a48["player"] function_SetClientThirdPersonAngle(357.4);
}

/*
	Name: function_84a658c8
	Namespace: namespace_bb3b4960
	Checksum: 0x424F4353
	Offset: 0xF90
	Size: 0xF0
	Parameters: 1
	Flags: None
	Line Number: 165
*/
function function_84a658c8(var_34d37a48)
{
	var_34d37a48["player"].var_f4d01b67["third_person_enabled"] = function_Int(1);
	var_34d37a48["player"] function_setDepthOfField(0, 128, 512, 4000, 6, 1.8);
	var_34d37a48["player"].var_29f6902d.var_alpha = 1;
	var_34d37a48["player"] function_SetClientThirdPerson(1);
	var_34d37a48["player"] function_SetClientThirdPersonAngle(357.4);
}

/*
	Name: function_33496f42
	Namespace: namespace_bb3b4960
	Checksum: 0x424F4353
	Offset: 0x1088
	Size: 0x48
	Parameters: 1
	Flags: None
	Line Number: 184
*/
function function_33496f42(var_34d37a48)
{
	var_34d37a48["player"].var_f4d01b67["hitmarkers"] = function_Int(1);
}

/*
	Name: function_8201bb01
	Namespace: namespace_bb3b4960
	Checksum: 0x424F4353
	Offset: 0x10D8
	Size: 0x48
	Parameters: 1
	Flags: None
	Line Number: 199
*/
function function_8201bb01(var_34d37a48)
{
	var_34d37a48["player"].var_f4d01b67["hitmarkers"] = function_Int(0);
	return;
}

/*
	Name: function_a159ac4a
	Namespace: namespace_bb3b4960
	Checksum: 0x424F4353
	Offset: 0x1128
	Size: 0x50
	Parameters: 1
	Flags: None
	Line Number: 215
*/
function function_a159ac4a(var_34d37a48)
{
	var_34d37a48["player"].var_f4d01b67["hitmarker_sounds"] = function_Int(var_34d37a48["value"][0]);
}

/*
	Name: function_96544afc
	Namespace: namespace_bb3b4960
	Checksum: 0x424F4353
	Offset: 0x1180
	Size: 0x48
	Parameters: 1
	Flags: None
	Line Number: 230
*/
function function_96544afc(var_34d37a48)
{
	var_34d37a48["player"].var_f4d01b67["fx_damage"] = function_Int(1);
}

/*
	Name: function_67641fc7
	Namespace: namespace_bb3b4960
	Checksum: 0x424F4353
	Offset: 0x11D0
	Size: 0x48
	Parameters: 1
	Flags: None
	Line Number: 245
*/
function function_67641fc7(var_34d37a48)
{
	var_34d37a48["player"].var_f4d01b67["fx_damage"] = function_Int(0);
	return;
}

/*
	Name: function_6adf47cd
	Namespace: namespace_bb3b4960
	Checksum: 0x424F4353
	Offset: 0x1220
	Size: 0x48
	Parameters: 1
	Flags: None
	Line Number: 261
*/
function function_6adf47cd(var_34d37a48)
{
	var_34d37a48["player"].var_f4d01b67["ping_keybind"] = function_Int(1);
}

/*
	Name: function_95334f34
	Namespace: namespace_bb3b4960
	Checksum: 0x424F4353
	Offset: 0x1270
	Size: 0x48
	Parameters: 1
	Flags: None
	Line Number: 276
*/
function function_95334f34(var_34d37a48)
{
	var_34d37a48["player"].var_f4d01b67["ping_keybind"] = function_Int(0);
	return;
	ERROR: Exception occured: Stack empty.
}

/*
	Name: function_db1c39c0
	Namespace: namespace_bb3b4960
	Checksum: 0x424F4353
	Offset: 0x12C0
	Size: 0x48
	Parameters: 1
	Flags: None
	Line Number: 293
*/
function function_db1c39c0(var_34d37a48)
{
	var_34d37a48["player"].var_f4d01b67["ping_keybind"] = function_Int(1);
}

/*
	Name: function_8045805b
	Namespace: namespace_bb3b4960
	Checksum: 0x424F4353
	Offset: 0x1310
	Size: 0x48
	Parameters: 1
	Flags: None
	Line Number: 308
*/
function function_8045805b(var_34d37a48)
{
	var_34d37a48["player"].var_f4d01b67["inspect_animations"] = function_Int(0);
	return;
	var_34d37a48["player"].var_0 = undefined;
}

/*
	Name: function_4316bc28
	Namespace: namespace_bb3b4960
	Checksum: 0x424F4353
	Offset: 0x1360
	Size: 0x48
	Parameters: 1
	Flags: None
	Line Number: 325
*/
function function_4316bc28(var_34d37a48)
{
	var_34d37a48["player"].var_f4d01b67["location_information"] = function_Int(1);
	return;
	ERROR: Exception occured: Stack empty.
}

/*
	Name: function_bc8be653
	Namespace: namespace_bb3b4960
	Checksum: 0x424F4353
	Offset: 0x13B0
	Size: 0x48
	Parameters: 1
	Flags: None
	Line Number: 342
*/
function function_bc8be653(var_34d37a48)
{
	var_34d37a48["player"].var_f4d01b67["location_information"] = function_Int(0);
}

/*
	Name: function_25e27cb8
	Namespace: namespace_bb3b4960
	Checksum: 0x424F4353
	Offset: 0x1400
	Size: 0x48
	Parameters: 1
	Flags: None
	Line Number: 357
*/
function function_25e27cb8(var_34d37a48)
{
	var_34d37a48["player"].var_f4d01b67["xp_hud"] = function_Int(1);
}

/*
	Name: function_a4f4cee3
	Namespace: namespace_bb3b4960
	Checksum: 0x424F4353
	Offset: 0x1450
	Size: 0x48
	Parameters: 1
	Flags: None
	Line Number: 372
*/
function function_a4f4cee3(var_34d37a48)
{
	var_34d37a48["player"].var_f4d01b67["xp_hud"] = function_Int(0);
}

/*
	Name: function_b9191d80
	Namespace: namespace_bb3b4960
	Checksum: 0x424F4353
	Offset: 0x14A0
	Size: 0x48
	Parameters: 1
	Flags: None
	Line Number: 387
*/
function function_b9191d80(var_34d37a48)
{
	var_34d37a48["player"].var_f4d01b67["pickup_ui"] = function_Int(1);
}

/*
	Name: function_61f2301b
	Namespace: namespace_bb3b4960
	Checksum: 0x424F4353
	Offset: 0x14F0
	Size: 0x48
	Parameters: 1
	Flags: None
	Line Number: 402
*/
function function_61f2301b(var_34d37a48)
{
	var_34d37a48["player"].var_f4d01b67["pickup_ui"] = function_Int(0);
}

/*
	Name: function_13ed5423
	Namespace: namespace_bb3b4960
	Checksum: 0x424F4353
	Offset: 0x1540
	Size: 0x48
	Parameters: 1
	Flags: None
	Line Number: 417
*/
function function_13ed5423(var_34d37a48)
{
	var_34d37a48["player"].var_f4d01b67["disabled_leveling_system"] = function_Int(1);
}

/*
	Name: function_5a442ae
	Namespace: namespace_bb3b4960
	Checksum: 0x424F4353
	Offset: 0x1590
	Size: 0x48
	Parameters: 1
	Flags: None
	Line Number: 432
*/
function function_5a442ae(var_34d37a48)
{
	var_34d37a48["player"].var_f4d01b67["disabled_leveling_system"] = function_Int(0);
	return;
	ERROR: Exception occured: Stack empty.
}

/*
	Name: function_2c7c9792
	Namespace: namespace_bb3b4960
	Checksum: 0x424F4353
	Offset: 0x15E0
	Size: 0x48
	Parameters: 1
	Flags: None
	Line Number: 449
*/
function function_2c7c9792(var_34d37a48)
{
	var_34d37a48["player"].var_f4d01b67["damage_numbers"] = function_Int(1);
}

/*
	Name: function_bb097751
	Namespace: namespace_bb3b4960
	Checksum: 0x424F4353
	Offset: 0x1630
	Size: 0x48
	Parameters: 1
	Flags: None
	Line Number: 464
*/
function function_bb097751(var_34d37a48)
{
	var_34d37a48["player"].var_f4d01b67["damage_numbers"] = function_Int(0);
	return;
}

/*
	Name: function___main__
	Namespace: namespace_bb3b4960
	Checksum: 0x424F4353
	Offset: 0x1680
	Size: 0x8
	Parameters: 0
	Flags: None
	Line Number: 480
*/
function function___main__()
{
}

/*
	Name: function_964d9783
	Namespace: namespace_bb3b4960
	Checksum: 0x424F4353
	Offset: 0x1690
	Size: 0xD0
	Parameters: 0
	Flags: None
	Line Number: 494
*/
function function_964d9783()
{
	self endon("hash_bled_out");
	self endon("hash_disconnect");
	wait(0.5);
	while(self.var_f4d01b67["third_person_enabled"] == 1)
	{
		self function_setDepthOfField(0, 128, 512, 4000, 6, 1.8);
		self.var_29f6902d.var_alpha = 1;
		self function_SetClientThirdPerson(1);
		self function_SetClientThirdPersonAngle(357.4);
		wait(1);
		continue;
		wait(1);
	}
}

/*
	Name: function_68e41a2d
	Namespace: namespace_bb3b4960
	Checksum: 0x424F4353
	Offset: 0x1768
	Size: 0x358
	Parameters: 1
	Flags: None
	Line Number: 521
*/
function function_68e41a2d(var_should_update)
{
	if(!isdefined(var_should_update))
	{
		var_should_update = 0;
	}
	if(isdefined(var_should_update) && var_should_update)
	{
		self.var_f4d01b67["third_person_enabled"] = function_Int(self.var_fa202141["game_third_person"]);
		self.var_f4d01b67["hitmarkers"] = function_Int(self.var_fa202141["game_hitmarkers"]);
		self.var_f4d01b67["hitmarker_sounds"] = function_Int(self.var_fa202141["game_hitmarker_sounds"]);
		self.var_f4d01b67["fx_damage"] = function_Int(self.var_fa202141["game_fx_damage"]);
		self.var_f4d01b67["ping_keybind"] = function_Int(self.var_fa202141["game_ping_keybind"]);
		self.var_f4d01b67["inspect_animations"] = function_Int(self.var_fa202141["game_inspect_animations"]);
		self.var_f4d01b67["location_information"] = function_Int(self.var_fa202141["game_location_hud"]);
		self.var_f4d01b67["xp_hud"] = function_Int(self.var_fa202141["game_xp_hud"]);
		self.var_f4d01b67["pickup_ui"] = function_Int(self.var_fa202141["game_pickup_ui"]);
		self.var_f4d01b67["disabled_leveling_system"] = function_Int(self.var_fa202141["game_xp_gain"]);
		self.var_f4d01b67["damage_numbers"] = function_Int(self.var_fa202141["game_damage_numbers"]);
		self.var_f4d01b67["blood_splatter"] = function_Int(self.var_fa202141["game_blood_splatter"]);
		self.var_f4d01b67["sound_pack"] = function_Int(self.var_fa202141["game_sound_pack"]);
		self.var_f4d01b67["healthbars"] = function_Int(self.var_fa202141["game_healthbars"]);
	}
	self thread function_c9829496();
	return;
	ERROR: Exception occured: Stack empty.
}

/*
	Name: function_2fae5cc4
	Namespace: namespace_bb3b4960
	Checksum: 0x424F4353
	Offset: 0x1AC8
	Size: 0x11F0
	Parameters: 0
	Flags: None
	Line Number: 559
*/
function function_2fae5cc4()
{
	self notify("hash_98ff4ed9");
	self endon("hash_98ff4ed9");
	self endon("hash_bled_out");
	self endon("hash_disconnect");
	self.var_f4d01b67["current_character"] = function_spawnstruct();
	self.var_f4d01b67["current_character"].var_current = function_Int(5);
	self.var_f4d01b67["current_character"].var_original = self function_GetCharacterBodyType();
	self thread function_c9829496();
	self.var_f4d01b67["inspect_animations"] = function_Int(0);
	self.var_f4d01b67["current_favourite_camo"] = function_Int(0);
	self.var_f4d01b67["godmode"] = function_Int(0);
	self.var_f4d01b67["third_person_enabled"] = function_Int(0);
	self.var_29f6902d = function_newdamageindicatorhudelem(self);
	self.var_29f6902d.var_horzAlign = "center";
	self.var_29f6902d.var_vertAlign = "middle";
	self.var_29f6902d.var_x = -11;
	self.var_29f6902d.var_y = -11;
	self.var_29f6902d.var_alpha = 0;
	self.var_29f6902d.var_archived = 1;
	self.var_29f6902d function_SetShader("damage_feedback", 24, 48);
	self thread function_964d9783();
	while(1)
	{
		if(isdefined(self))
		{
			self waittill("hash_menuresponse", var_menu, var_response);
			if(var_menu == "StartMenu_Main")
			{
				if(var_response == "opened_start_menu")
				{
					if(function_GetPlayers().size > 1)
					{
						function_SetPauseWorld(1);
						function_SetDvar("timescale", 0.1);
						function_SetDvar("cl_paused", 1);
						function_SetDvar("sv_paused", 1);
						if(level namespace_flag::function_exists("world_is_paused"))
						{
							level namespace_flag::function_set("world_is_paused");
						}
						foreach(var_player in function_GetPlayers())
						{
							if(!var_player function_IsHost())
							{
								var_player thread namespace_zm_equipment::function_show_hint_text("Game has been Paused by Host", 9999999, 1.25, 280);
								var_player function_SetEntityPaused(1);
								var_player function_EnableInvulnerability();
								var_player function_SetStance("stand");
								var_player function_AllowedStances("stand");
								var_player function_FreezeControlsAllowLook(1);
								var_player.var_5da8db1f = namespace_util::function_spawn_model("tag_origin", var_player.var_origin, var_player.var_angles);
								var_player function_playerLinkTo(var_player.var_5da8db1f, "tag_origin", 0, 0, 0, 0, 0);
								var_player function_setblur(7, 0.25);
								if(var_player namespace_laststand::function_player_is_in_laststand())
								{
									var_player.var_fe2798da = var_player.var_bleedout_time;
									var_player.var_bleedout_time = 99999;
								}
							}
						}
					}
				}
				else if(var_response == "closed_start_menu")
				{
					if(function_GetPlayers().size > 1)
					{
						function_SetPauseWorld(0);
						function_SetDvar("timescale", 1);
						function_SetDvar("cl_paused", 0);
						function_SetDvar("sv_paused", 0);
						if(level namespace_flag::function_exists("world_is_paused"))
						{
							level namespace_flag::function_clear("world_is_paused");
						}
						foreach(var_player in function_GetPlayers())
						{
							if(isdefined(var_player.var_hintelem))
							{
								var_player.var_hintelem function_destroy();
								var_player function_SetEntityPaused(0);
								var_player function_DisableInvulnerability();
								if(isdefined(var_player.var_5da8db1f))
								{
									var_player.var_5da8db1f function_delete();
								}
								var_player function_FreezeControlsAllowLook(0);
								var_player function_AllowedStances("stand", "crouch", "prone");
								var_player function_setblur(0, 0.25);
								if(var_player namespace_laststand::function_player_is_in_laststand())
								{
									var_player.var_bleedout_time = var_player.var_fe2798da;
								}
							}
						}
					}
				}
				else if(var_response == "PlayerCharacterResponse")
				{
					self thread function_c9829496(1);
				}
				if(var_response == "HitmarkerMenuResponse")
				{
					if(self.var_f4d01b67["hitmarkers"] == 1)
					{
						self.var_f4d01b67["hitmarkers"] = function_Int(0);
					}
					else
					{
						self.var_f4d01b67["hitmarkers"] = function_Int(1);
					}
				}
				if(var_response == "HitmarkerSoundsMenuResponse")
				{
					if(self.var_f4d01b67["hitmarker_sounds"] == 1)
					{
						self.var_f4d01b67["hitmarker_sounds"] = function_Int(0);
					}
					else if(self.var_f4d01b67["hitmarker_sounds"] == 2)
					{
						self.var_f4d01b67["hitmarker_sounds"] = function_Int(0);
					}
					else
					{
						self.var_f4d01b67["hitmarker_sounds"] = function_Int(1);
					}
				}
				if(var_response == "FxDamageMenuResponse")
				{
					if(self.var_f4d01b67["fx_damage"] == 1)
					{
						self.var_f4d01b67["fx_damage"] = function_Int(0);
					}
					else
					{
						self.var_f4d01b67["fx_damage"] = function_Int(1);
					}
				}
				if(var_response == "XpHudMenuResponse")
				{
					if(self.var_f4d01b67["xp_hud"] == 1)
					{
						self.var_f4d01b67["xp_hud"] = function_Int(0);
					}
					else
					{
						self.var_f4d01b67["xp_hud"] = function_Int(1);
					}
				}
				if(var_response == "PickupUIMenuResponse")
				{
					if(self.var_f4d01b67["pickup_ui"] == 1)
					{
						self.var_f4d01b67["pickup_ui"] = function_Int(0);
					}
					else
					{
						self.var_f4d01b67["pickup_ui"] = function_Int(1);
					}
				}
				if(var_response == "PingMenuResponse")
				{
					if(self.var_f4d01b67["ping_keybind"] == 1)
					{
						self.var_f4d01b67["ping_keybind"] = function_Int(0);
					}
					else
					{
						self.var_f4d01b67["ping_keybind"] = function_Int(1);
					}
				}
				if(var_response == "InspectMenuResponse")
				{
					if(self.var_f4d01b67["inspect_animations"] == 1)
					{
						self.var_f4d01b67["inspect_animations"] = function_Int(0);
					}
					else
					{
						self.var_f4d01b67["inspect_animations"] = function_Int(1);
					}
				}
				if(var_response == "LocationMenuResponse")
				{
					if(self.var_f4d01b67["location_information"] == 1)
					{
						self.var_f4d01b67["location_information"] = function_Int(0);
					}
					else
					{
						self.var_f4d01b67["location_information"] = function_Int(1);
					}
				}
				if(var_response == "PlayerHatResponse")
				{
					self.var_f4d01b67["current_hat"]++;
					if(self.var_f4d01b67["current_hat"] == 4)
					{
						self.var_f4d01b67["current_hat"] = function_Int(0);
					}
					self thread function_39c01094();
				}
				if(var_response == "FavouriteCamoResponse")
				{
					self.var_f4d01b67["current_favourite_camo"]++;
					if(self.var_f4d01b67["current_favourite_camo"] == 21)
					{
						self.var_f4d01b67["current_favourite_camo"] = function_Int(0);
					}
					self thread function_d3a758f5();
				}
				if(var_response == "DisableXPMenuResponse")
				{
					if(self.var_f4d01b67["disabled_leveling_system"] == 1)
					{
						self.var_f4d01b67["disabled_leveling_system"] = function_Int(0);
					}
					else
					{
						self.var_f4d01b67["disabled_leveling_system"] = function_Int(1);
					}
				}
				if(var_response == "DamageNumbersModelResponse")
				{
					if(self.var_f4d01b67["damage_numbers"] == 1)
					{
						self.var_f4d01b67["damage_numbers"] = function_Int(0);
					}
					else
					{
						self.var_f4d01b67["damage_numbers"] = function_Int(1);
					}
				}
				if(var_response == "HealthBarModelResponse")
				{
					if(self.var_f4d01b67["healthbars"] == 1)
					{
						self.var_f4d01b67["healthbars"] = function_Int(2);
					}
					else if(self.var_f4d01b67["healthbars"] == 2)
					{
						self.var_f4d01b67["healthbars"] = function_Int(0);
					}
					else
					{
						self.var_f4d01b67["healthbars"] = function_Int(1);
					}
				}
				if(var_response == "BloodsplatterMenuResponse")
				{
					if(self.var_f4d01b67["blood_splatter"] == 1)
					{
						self.var_f4d01b67["blood_splatter"] = function_Int(0);
					}
					else
					{
						self.var_f4d01b67["blood_splatter"] = function_Int(1);
					}
				}
				if(var_response == "ThirdPersonMenuResponse")
				{
					if(self.var_f4d01b67["third_person_enabled"] == 1)
					{
						self.var_f4d01b67["third_person_enabled"] = function_Int(0);
						self function_setDepthOfField(0, 0, 512, 4000, 4, 0);
						self.var_29f6902d.var_alpha = 0;
						self function_SetClientThirdPerson(0);
						self function_SetClientThirdPersonAngle(357.4);
					}
					else
					{
						self.var_f4d01b67["third_person_enabled"] = function_Int(1);
						self function_setDepthOfField(0, 128, 512, 4000, 6, 1.8);
						self.var_29f6902d.var_alpha = 1;
						self function_SetClientThirdPerson(1);
						self function_SetClientThirdPersonAngle(357.4);
					}
				}
				if(var_response == "SupporterHudResponse")
				{
					var_ca7a8609 = self namespace_97ac1184::function_4c2abd48(self.var_b74a3cd1["level"]);
					self function_LUINotifyEvent(&"leveling_data", 4, self.var_b74a3cd1["prestige"], self.var_b74a3cd1["level"], self.var_b74a3cd1["xp"], function_Int(var_ca7a8609["xp_needed"]));
				}
			}
		}
		wait(0.05);
	}
}

/*
	Name: function_d3a758f5
	Namespace: namespace_bb3b4960
	Checksum: 0x424F4353
	Offset: 0x2CC0
	Size: 0x1E0
	Parameters: 0
	Flags: None
	Line Number: 859
*/
function function_d3a758f5()
{
	foreach(var_w_weapon in self function_GetWeaponsList(1))
	{
		var_480fed80 = self namespace_5e1f56dc::function_1c1990e8(var_w_weapon);
		if(isdefined(var_480fed80))
		{
			if(isdefined(self.var_f4d01b67["current_favourite_camo"]) && self.var_f4d01b67["current_favourite_camo"] > 0)
			{
				if(var_480fed80.var_4c25c2f2 >= self.var_f4d01b67["current_favourite_camo"])
				{
					self function_c8540b60(var_w_weapon, self function_CalcWeaponOptions(self.var_f4d01b67["current_favourite_camo"], 0, 0));
				}
				else
				{
					self function_c8540b60(var_w_weapon, self function_CalcWeaponOptions(var_480fed80.var_pap_camo_to_use, 0, 0));
					continue;
				}
			}
			self function_c8540b60(var_w_weapon, self function_CalcWeaponOptions(var_480fed80.var_pap_camo_to_use, 0, 0));
		}
	}
}

/*
	Name: function_c9829496
	Namespace: namespace_bb3b4960
	Checksum: 0x424F4353
	Offset: 0x2EA8
	Size: 0x688
	Parameters: 1
	Flags: None
	Line Number: 893
*/
function function_c9829496(var_Increase)
{
	if(!isdefined(var_Increase))
	{
		var_Increase = 0;
	}
	wait(0.05);
	while(!isdefined(self.var_fa202141["player_character"]))
	{
		wait(1);
	}
	if(isdefined(var_Increase) && var_Increase)
	{
		self.var_f4d01b67["current_character"].var_current++;
	}
	if(isdefined(level.var_18ffd3f2[self function_getxuid(1)]))
	{
		if(self.var_f4d01b67["current_character"].var_current == 0)
		{
			if(level.var_18ffd3f2[self function_getxuid(1)].var_rank == "bronze" || level.var_18ffd3f2[self function_getxuid(1)].var_rank == "silver" || level.var_18ffd3f2[self function_getxuid(1)].var_rank == "gold" || level.var_18ffd3f2[self function_getxuid(1)].var_rank == "master" || level.var_18ffd3f2[self function_getxuid(1)].var_rank == "paragon")
			{
				self function_SetCharacterBodyType(10);
			}
		}
		else if(self.var_f4d01b67["current_character"].var_current == 1)
		{
			if(level.var_18ffd3f2[self function_getxuid(1)].var_rank == "silver" || level.var_18ffd3f2[self function_getxuid(1)].var_rank == "gold" || level.var_18ffd3f2[self function_getxuid(1)].var_rank == "master" || level.var_18ffd3f2[self function_getxuid(1)].var_rank == "paragon")
			{
				self function_SetCharacterBodyType(11);
			}
		}
		else if(self.var_f4d01b67["current_character"].var_current == 2)
		{
			if(level.var_18ffd3f2[self function_getxuid(1)].var_rank == "gold" || level.var_18ffd3f2[self function_getxuid(1)].var_rank == "master" || level.var_18ffd3f2[self function_getxuid(1)].var_rank == "paragon")
			{
				self function_SetCharacterBodyType(12);
			}
		}
		else if(self.var_f4d01b67["current_character"].var_current == 3)
		{
			if(level.var_18ffd3f2[self function_getxuid(1)].var_rank == "master" || level.var_18ffd3f2[self function_getxuid(1)].var_rank == "paragon")
			{
				self function_SetCharacterBodyType(13);
			}
		}
		else if(self.var_f4d01b67["current_character"].var_current == 4)
		{
			if(level.var_18ffd3f2[self function_getxuid(1)].var_rank == "paragon")
			{
				self function_SetCharacterBodyType(14);
			}
		}
		else if(self.var_f4d01b67["current_character"].var_current == 5)
		{
			if(level.var_18ffd3f2[self function_getxuid(1)].var_57fb29cc == "legendary" || level.var_18ffd3f2[self function_getxuid(1)].var_57fb29cc == "ultimate")
			{
				self function_SetCharacterBodyType(9);
			}
		}
		else
		{
			self function_SetCharacterBodyType(self.var_f4d01b67["current_character"].var_original);
		}
	}
	else
	{
		self function_SetCharacterBodyType(self.var_f4d01b67["current_character"].var_original);
	}
	if(self.var_f4d01b67["current_character"].var_current == 5)
	{
		self.var_f4d01b67["current_character"].var_current = -1;
	}
}

/*
	Name: function_39c01094
	Namespace: namespace_bb3b4960
	Checksum: 0x424F4353
	Offset: 0x3538
	Size: 0x428
	Parameters: 0
	Flags: None
	Line Number: 977
*/
function function_39c01094()
{
	wait(0.05);
	while(!isdefined(self.var_fa202141["player_hat"]))
	{
		wait(1);
	}
	if(isdefined(self.var_1652177e))
	{
		self function_Detach(self.var_1652177e, "j_head");
	}
	if(self function_getxuid(1) == "76561198075603410")
	{
		self thread function_2d147fe0("_zmu_hat_chicken_hat");
	}
	else if(self function_getxuid(1) == "76561198057632928" || self function_getxuid(1) == "76561198029188429")
	{
		switch(function_randomIntRange(0, 2))
		{
			case 0:
			{
				self thread function_2d147fe0("_zmu_hat_tv_hat");
				break;
			}
			case 1:
			{
				self thread function_2d147fe0("_zmu_hat_chicken_hat");
				break;
			}
			case 2:
			{
				self thread function_2d147fe0("_zmu_paper_bag_hat");
				break;
			}
		}
	}
	else if(self.var_f4d01b67["current_hat"] == 0)
	{
		if(self.var_pers["halloween_pumpkin_hat"] == 1)
		{
			self thread function_2d147fe0("_zmu_halloween_hat");
		}
	}
	else if(isdefined(level.var_18ffd3f2[self function_getxuid(1)]) && self.var_f4d01b67["current_hat"] == 1)
	{
		switch(level.var_18ffd3f2[self function_getxuid(1)].var_rank)
		{
			case "bronze":
			{
				self thread function_2d147fe0("_zmu_crown_vip_bronze");
				break;
			}
			case "silver":
			{
				self thread function_2d147fe0("_zmu_crown_vip_silver");
				break;
			}
			case "gold":
			{
				self thread function_2d147fe0("_zmu_crown_vip_gold");
				break;
			}
			case "master":
			{
				self thread function_2d147fe0("_zmu_crown_vip_master");
				break;
			}
			case "paragon":
			{
				self thread function_2d147fe0("_zmu_crown_vip_paragon");
				break;
			}
		}
	}
	else if(isdefined(level.var_18ffd3f2[self function_getxuid(1)]) && self.var_f4d01b67["current_hat"] == 2)
	{
		switch(level.var_18ffd3f2[self function_getxuid(1)].var_57fb29cc)
		{
			case "undead":
			{
				self thread function_2d147fe0("_zmu_hat_tv_hat");
				break;
			}
			case "legendary":
			{
				self thread function_2d147fe0("_zmu_hat_tv_hat");
				break;
			}
			case "ultimate":
			{
				self thread function_2d147fe0("_zmu_hat_tv_hat");
				break;
			}
		}
	}
}

/*
	Name: function_2d147fe0
	Namespace: namespace_bb3b4960
	Checksum: 0x424F4353
	Offset: 0x3968
	Size: 0xC4
	Parameters: 1
	Flags: None
	Line Number: 1084
*/
function function_2d147fe0(var_model)
{
	self notify("hash_5f7623c6");
	self endon("hash_5f7623c6");
	self function_Attach(var_model, "j_head");
	self.var_1652177e = var_model;
	wait(0.05);
	self namespace_util::function_waittill_any("player_equip_new_hat", "death", "disconnect");
	if(isdefined(self) && function_isalive(self))
	{
		self function_Detach(var_model, "j_head");
	}
}

