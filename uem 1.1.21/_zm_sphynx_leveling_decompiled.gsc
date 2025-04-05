#include scripts\codescripts\struct;
#include scripts\shared\aat_shared;
#include scripts\shared\ai\systems\gib;
#include scripts\shared\ai\zombie_death;
#include scripts\shared\ai\zombie_shared;
#include scripts\shared\ai\zombie_utility;
#include scripts\shared\animation_shared;
#include scripts\shared\array_shared;
#include scripts\shared\callbacks_shared;
#include scripts\shared\clientfield_shared;
#include scripts\shared\demo_shared;
#include scripts\shared\duplicaterender_mgr;
#include scripts\shared\exploder_shared;
#include scripts\shared\flag_shared;
#include scripts\shared\flagsys_shared;
#include scripts\shared\hud_shared;
#include scripts\shared\hud_util_shared;
#include scripts\shared\laststand_shared;
#include scripts\shared\lui_shared;
#include scripts\shared\math_shared;
#include scripts\shared\scene_shared;
#include scripts\shared\spawner_shared;
#include scripts\shared\system_shared;
#include scripts\shared\util_shared;
#include scripts\zm\_util;
#include scripts\zm\_zm;
#include scripts\zm\_zm_audio;
#include scripts\zm\_zm_behavior;
#include scripts\zm\_zm_behavior_utility;
#include scripts\zm\_zm_bgb;
#include scripts\zm\_zm_blockers;
#include scripts\zm\_zm_equipment;
#include scripts\zm\_zm_hud_settings;
#include scripts\zm\_zm_laststand;
#include scripts\zm\_zm_net;
#include scripts\zm\_zm_perk_additionalprimaryweapon;
#include scripts\zm\_zm_perks;
#include scripts\zm\_zm_pers_upgrades;
#include scripts\zm\_zm_pers_upgrades_functions;
#include scripts\zm\_zm_powerup_nuke;
#include scripts\zm\_zm_powerups;
#include scripts\zm\_zm_puppet;
#include scripts\zm\_zm_score;
#include scripts\zm\_zm_spawner;
#include scripts\zm\_zm_stats;
#include scripts\zm\_zm_unitrigger;
#include scripts\zm\_zm_utility;
#include scripts\zm\_zm_weapon_upgrade_system;
#include scripts\zm\_zm_weapons;
#include scripts\zm\_zm_zonemgr;
#include scripts\zm\gametypes\_globallogic;
#include scripts\zm\gametypes\_globallogic_score;

#namespace namespace_97ac1184;

/*
	Name: function___init__sytem__
	Namespace: namespace_97ac1184
	Checksum: 0x424F4353
	Offset: 0x92B8
	Size: 0x38
	Parameters: 0
	Flags: AutoExec
	Line Number: 65
*/
function autoexec function___init__sytem__()
{
	namespace_system::function_register("zm_sphynx_leveling", &function___init__, undefined, undefined);
}

/*
	Name: function___init__
	Namespace: namespace_97ac1184
	Checksum: 0x424F4353
	Offset: 0x92F8
	Size: 0x5D0
	Parameters: 0
	Flags: None
	Line Number: 80
*/
function function___init__()
{
	namespace_util::function_registerClientSys("UEM.Data");
	switch(function_ToLower(function_GetDvarString("mapname")))
	{
		case "zm_prison":
		{
			break;
		}
		default
		{
			if(!isdefined(level.var_giveCustomLoadout))
			{
				level.var_giveCustomLoadout = &function_65c8a9fb;
			}
		}
	}
	level.var_687cb838 = 1;
	level.var_18ffd3f2 = [];
	level thread function_c92b2b70();
	level.var_ac46587c = [];
	level.var_d824eaa9 = [];
	level thread function_e5da2d1e();
	level.var_c3e446a = [];
	level.var_742cf7b3 = [];
	level.var_d70efd10 = [];
	level thread function_58027f04();
	level.var_79bcc5f3 = [];
	level.var_d04fcc6a = [];
	level.var_f05cf751 = [];
	level thread function_4ad6b691();
	level.var_5e620cb1 = [];
	level.var_7fd3975f = [];
	level.var_204377c = [];
	level thread function_7eb8b937();
	level.var_e6522d0f = [];
	level thread function_952b02b3();
	function_8b57c052("ModVersion", 188);
	function_8b57c052("fast_restart", 0);
	namespace_callback::function_on_connect(&function_8dcb2166);
	namespace_callback::function_on_connect(&function_acab6641);
	namespace_callback::function_on_connect(&function_3b74ce49);
	level.var_411289a8 = 0;
	namespace_callback::function_on_spawned(&function_890b0605);
	thread function_9201588b();
	thread function_554820a1();
	level thread function_87a20e06();
	namespace_zm_spawner::function_register_zombie_death_event_callback(&function_7279da56);
	namespace_zm::function_register_player_damage_callback(&function_87d1927f);
	level thread function_7eb13385();
	level thread function_a485c61f();
	namespace_callback::function_on_connect(&function_e67bbb8);
	level thread function_c72f6f99();
	level thread function_6f50aabc();
	level thread function_6033a0ff();
	level thread function_41a254c();
	namespace_callback::function_on_connect(&function_28bace5f);
	level thread function_329aa7fe();
	level thread function_8de2bd80();
	level thread function_154491fc();
	level thread function_5b223195();
	level thread function_694ca363();
	namespace_callback::function_on_connect(&function_d029f398);
	namespace_callback::function_on_connect(&function_eeb79e2d);
	namespace_callback::function_on_connect(&function_31dfdcd7);
	level thread function_edad2d08(function_ToLower(function_GetDvarString("mapname")));
	namespace_callback::function_on_connect(&function_5e4556db);
	level thread function_57821581();
	level.var_952dabaa = [];
	namespace_callback::function_on_connect(&function_654cb7f5);
	wait(2);
	switch(function_ToLower(function_GetDvarString("mapname")))
	{
		case "zm_prison":
		{
			break;
		}
		default
		{
			if(!isdefined(level.var_giveCustomLoadout))
			{
				level.var_giveCustomLoadout = &function_65c8a9fb;
			}
		}
	}
	level thread function_1894510a();
	return;
}

/*
	Name: function_97f22bf4
	Namespace: namespace_97ac1184
	Checksum: 0x424F4353
	Offset: 0x98D0
	Size: 0x358
	Parameters: 2
	Flags: None
	Line Number: 179
*/
function function_97f22bf4(var_mapname, var_generic)
{
	if(!isdefined(var_generic))
	{
		var_generic = 0;
	}
	var_players = function_GetPlayers();
	if(var_players.size < 2)
	{
		var_players[0] thread function_b3489bf5("^3" + var_players[0].var_playerName + "^7 completed the " + var_mapname + " Easter Egg");
		if(isdefined(var_generic) && var_generic)
		{
			var_players[0] notify("hash_79ef118b", "map_ee_completed", undefined);
		}
		else
		{
			var_players[0] notify("hash_79ef118b", "map_ee_completed_" + level.var_fcee636, undefined);
		}
		level notify("hash_8c3d4295", var_players[0], "solo_easter_eggs_completed", 1, 0);
		wait(1);
		if(level.var_8f1fd1e4 < var_players[0].var_pers[level.var_fcee636 + "_completion_time_solo_ee"] || var_players[0].var_pers[level.var_fcee636 + "_completion_time_solo_ee"] == 0)
		{
			level notify("hash_8c3d4295", var_players[0], "completion_time_solo_ee", level.var_8f1fd1e4, 1);
		}
	}
	else
	{
		foreach(var_player in var_players)
		{
			var_player thread function_b3489bf5("^3" + var_player.var_playerName + "^7 completed the " + var_mapname + " Easter Egg");
			if(isdefined(var_generic) && var_generic)
			{
				var_player notify("hash_79ef118b", "map_ee_completed", undefined);
			}
			else
			{
				var_player notify("hash_79ef118b", "map_ee_completed_" + level.var_fcee636, undefined);
			}
			level notify("hash_8c3d4295", var_player, "easter_eggs_completed", 1, 0);
			wait(1);
			if(level.var_8f1fd1e4 < var_player.var_pers[level.var_fcee636 + "_completion_time_solo_ee"] || var_player.var_pers[level.var_fcee636 + "_completion_time_solo_ee"] == 0)
			{
				level notify("hash_8c3d4295", var_player, "completion_time_ee", level.var_8f1fd1e4, 1);
			}
		}
		return;
	}
	ERROR: Exception occured: Stack empty.
}

/*
	Name: function_edad2d08
	Namespace: namespace_97ac1184
	Checksum: 0x424F4353
	Offset: 0x9C30
	Size: 0x908
	Parameters: 1
	Flags: None
	Line Number: 239
*/
function function_edad2d08(var_map_name)
{
	switch(var_map_name)
	{
		case "zm_zod":
		{
			level thread function_4c32d3b7();
			level.var_fcee636 = "soe";
			level thread function_5c8d8a45();
			wait(0.05);
			level namespace_flag::function_wait_till("ee_complete");
			level thread function_97f22bf4("Shadows of Evil", 0);
			break;
		}
		case "zm_factory":
		{
			level.var_fcee636 = "giant";
			level thread function_5c8d8a45();
			wait(0.05);
			level namespace_flag::function_wait_till("hide_and_seek");
			level namespace_flag::function_wait_till("ee_exp_monkey");
			level namespace_flag::function_wait_till("ee_bowie_bear");
			level namespace_flag::function_wait_till("ee_perk_bear");
			level thread function_97f22bf4("The Giant", 0);
			break;
		}
		case "zm_castle":
		{
			level.var_fcee636 = "castle";
			level thread function_5c8d8a45();
			wait(0.05);
			level waittill("hash_b39ccbbf");
			level thread function_97f22bf4("Der Eisendrache", 0);
			break;
		}
		case "zm_island":
		{
			level.var_fcee636 = "island";
			level thread function_5c8d8a45();
			wait(0.05);
			level namespace_flag::function_wait_till("flag_outro_cutscene_done");
			level thread function_97f22bf4("Zetsubou No Shima", 0);
			break;
		}
		case "zm_stalingrad":
		{
			level.var_fcee636 = "gorod";
			level thread function_5c8d8a45();
			level waittill("hash_45115ebd");
			level thread function_97f22bf4("Gorod Krovi", 0);
			break;
		}
		case "zm_genesis":
		{
			level.var_fcee636 = "rev";
			level thread function_5c8d8a45();
			level waittill("hash_c1471acf");
			level thread function_97f22bf4("Revelations", 0);
			break;
		}
		case "zm_prototype":
		{
			level.var_fcee636 = "nacht";
			level thread function_5c8d8a45();
			wait(0.05);
			level namespace_flag::function_wait_till("snd_zhdegg_activate");
			level thread function_97f22bf4("Nacht der Untoten", 0);
			break;
		}
		case "zm_asylum":
		{
			level.var_fcee636 = "verruckt";
			level thread function_5c8d8a45();
			wait(0.05);
			level namespace_flag::function_wait_till("snd_zhdegg_activate");
			level thread function_97f22bf4("Verruckt", 0);
			break;
		}
		case "zm_sumpf":
		{
			level.var_fcee636 = "shino";
			level thread function_5c8d8a45();
			wait(0.05);
			level namespace_flag::function_wait_till("snd_zhdegg_activate");
			level thread function_97f22bf4("Shi-No Numa", 0);
			break;
		}
		case "zm_theater":
		{
			level.var_fcee636 = "kino";
			level thread function_5c8d8a45();
			wait(0.05);
			level namespace_flag::function_wait_till("snd_zhdegg_activate");
			level thread function_97f22bf4("Kino der toten", 0);
			break;
		}
		case "zm_cosmodrome":
		{
			level thread function_83a09031();
			level.var_fcee636 = "ascension";
			level thread function_5c8d8a45();
			wait(0.05);
			level waittill("hash_e09c6a09");
			wait(10);
			level thread function_97f22bf4("Ascension", 0);
			break;
		}
		case "zm_temple":
		{
			level thread function_3753af4();
			level.var_fcee636 = "shangri";
			level thread function_5c8d8a45();
			break;
		}
		case "zm_moon":
		{
			level.var_fcee636 = "moon";
			level thread function_5c8d8a45();
			level waittill("hash_moon_sidequest_achieved");
			level thread function_97f22bf4("Moon", 0);
			break;
		}
		case "zm_tomb":
		{
			level.var_fcee636 = "origins";
			level thread function_5c8d8a45();
			level waittill("hash_276c2807");
			level thread function_97f22bf4("Origins", 0);
			break;
		}
		case "zm_coast":
		{
			level.var_fcee636 = "cotd";
			level thread function_5c8d8a45();
			wait(0.05);
			level namespace_flag::function_wait_till("quest_complete");
			level thread function_97f22bf4("Call of the Dead", 0);
			break;
		}
		case "zm_mob_bridge":
		{
			level.var_fcee636 = "motdbridge";
			level thread function_5c8d8a45();
			break;
		}
		case "zm_mob":
		{
			level.var_fcee636 = "motdroof";
			level thread function_5c8d8a45();
			break;
		}
		case "zm_sanctuary":
		{
			level.var_fcee636 = "sanctuary";
			level thread function_5c8d8a45();
			level waittill("hash_3d2b3189");
			level thread function_97f22bf4("The Sanctuary", 0);
			break;
		}
		case "zm_twitch_shipment_v2":
		{
			level.var_fcee636 = "shipmenttwitchy";
			level thread function_5c8d8a45();
			break;
		}
		case "zm_iss":
		case "zm_mc_rain":
		{
			level.var_fcee636 = "rainuem";
			level thread function_5c8d8a45();
			break;
		}
		case "zm_last_stand_minecraft":
		{
			level.var_fcee636 = "spxskyblock";
			level thread function_5c8d8a45();
			break;
		}
		case "zm_crazy_place":
		{
			level.var_fcee636 = "crazyplace";
			level thread function_5c8d8a45();
			break;
		}
		case "zm_feddyfazballs3":
		{
			namespace_zm_spawner::function_add_custom_zombie_spawn_logic(&function_95eca5c1);
			break;
		}
		case "zm_prison":
		{
			level.var_fcee636 = "motd";
			level thread function_5c8d8a45();
			level thread function_2e09deb();
			wait(0.05);
			level waittill("hash_pop_goes_the_weasel_achieved");
			level thread function_97f22bf4("MOB OF THE DEAD", 0);
			break;
		}
	}
}

/*
	Name: function_2e09deb
	Namespace: namespace_97ac1184
	Checksum: 0x424F4353
	Offset: 0xA540
	Size: 0xA8
	Parameters: 0
	Flags: None
	Line Number: 451
*/
function function_2e09deb()
{
	namespace_callback::function_on_connect(&function_1c6b795c);
	namespace_callback::function_on_connect(&function_fe1ed0e2);
	namespace_callback::function_on_connect(&function_af61fc2e);
	namespace_callback::function_on_connect(&function_985b57b6);
	namespace_callback::function_on_connect(&function_1a11b56e);
}

/*
	Name: function_985b57b6
	Namespace: namespace_97ac1184
	Checksum: 0x424F4353
	Offset: 0xA5F0
	Size: 0xF8
	Parameters: 0
	Flags: None
	Line Number: 470
*/
function function_985b57b6()
{
	self endon("hash_disconnect");
	wait(0.05);
	level namespace_flag::function_wait_till("initial_blackscreen_passed");
	var_b590295 = function_GetWeapon("falling_hands");
	while(1)
	{
		self waittill("hash_weapon_change", var_newWeapon, var_oldWeapon);
		if(var_newWeapon == var_b590295)
		{
			self namespace_zm_utility::function_disable_player_move_states(1);
			while(self function_GetCurrentWeapon() == var_b590295)
			{
				wait(0.5);
			}
			self namespace_zm_utility::function_enable_player_move_states();
		}
		wait(1);
	}
	return;
	ERROR: Exception occured: Stack empty.
}

/*
	Name: function_fe1ed0e2
	Namespace: namespace_97ac1184
	Checksum: 0x424F4353
	Offset: 0xA6F0
	Size: 0xA0
	Parameters: 0
	Flags: None
	Line Number: 504
*/
function function_fe1ed0e2()
{
	self endon("hash_disconnect");
	wait(0.05);
	level namespace_flag::function_wait_till("initial_blackscreen_passed");
	while(1)
	{
		level waittill("hash_6032f0ac");
		wait(1);
		if(self.var_pers["map0_motd_dog_heads"] < 1)
		{
			self notify("hash_63cf7d21", "map0_motd_dog_heads", 1, 1, 90000, 20);
		}
		wait(1);
	}
}

/*
	Name: function_af61fc2e
	Namespace: namespace_97ac1184
	Checksum: 0x424F4353
	Offset: 0xA798
	Size: 0x80
	Parameters: 0
	Flags: None
	Line Number: 531
*/
function function_af61fc2e()
{
	self endon("hash_disconnect");
	wait(0.05);
	level namespace_flag::function_wait_till("initial_blackscreen_passed");
	while(1)
	{
		self waittill("hash_player_revived");
		self notify("hash_63cf7d21", "map0_motd_revive", 1, 3, 40000, 5);
		wait(1);
	}
}

/*
	Name: function_1c6b795c
	Namespace: namespace_97ac1184
	Checksum: 0x424F4353
	Offset: 0xA820
	Size: 0x130
	Parameters: 0
	Flags: None
	Line Number: 554
*/
function function_1c6b795c()
{
	self endon("hash_disconnect");
	wait(0.05);
	level namespace_flag::function_wait_till("initial_blackscreen_passed");
	self.var_81f3b219 = function_Int(0);
	while(1)
	{
		level waittill("hash_b2f27acd");
		wait(2);
		if(self.var_on_a_plane)
		{
			while(self.var_on_a_plane)
			{
				wait(0.5);
			}
			self.var_81f3b219++;
			self notify("hash_63cf7d21", "map0_motd_escape", 1, 1, 235000, 20);
			wait(0.05);
			level notify("hash_8c3d4295", self, "escapes", 1, 0);
			wait(0.05);
			self notify("hash_63cf7d21", "map0_motd_golden_escape", 1, 3, 235000, 75, "motd_plushie");
		}
	}
}

/*
	Name: function_1a11b56e
	Namespace: namespace_97ac1184
	Checksum: 0x424F4353
	Offset: 0xA958
	Size: 0x80
	Parameters: 0
	Flags: None
	Line Number: 590
*/
function function_1a11b56e()
{
	self endon("hash_disconnect");
	wait(0.05);
	level namespace_flag::function_wait_till("initial_blackscreen_passed");
	while(1)
	{
		level waittill("hash_pop_goes_the_weasel_achieved");
		wait(1);
		self notify("hash_63cf7d21", "map0_motd_complete_ee", 1, 1, 150000, 50);
	}
}

/*
	Name: function_95eca5c1
	Namespace: namespace_97ac1184
	Checksum: 0x424F4353
	Offset: 0xA9E0
	Size: 0x48
	Parameters: 0
	Flags: None
	Line Number: 613
*/
function function_95eca5c1()
{
	self endon("hash_death");
	wait(1);
	var_original_health = self.var_health;
	self.var_health = level.var_6a2a6466;
	self.var_maxhealth = self.var_health;
}

/*
	Name: function_3753af4
	Namespace: namespace_97ac1184
	Checksum: 0x424F4353
	Offset: 0xAA30
	Size: 0x8
	Parameters: 0
	Flags: None
	Line Number: 632
*/
function function_3753af4()
{
	return;
	ERROR: Bad function call
}

/*
	Name: function_61dbe30b
	Namespace: namespace_97ac1184
	Checksum: 0x424F4353
	Offset: 0xAA40
	Size: 0xD8
	Parameters: 0
	Flags: None
	Line Number: 648
*/
function function_61dbe30b()
{
	if(function_GetPlayers().size < 2)
	{
		function_iprintln("^8[Solo Shangri-La EE]^7 Tile Step");
		var_34a397d8 = function_GetEntArray("sq_oafc_tileset1", "targetname");
		var_a6ab0713 = function_GetEntArray("sq_oafc_tileset2", "targetname");
		level.var_a48bfa55 thread function_6e17a256(var_34a397d8, 1);
		level.var_ca8e74be thread function_6e17a256(var_a6ab0713, 2);
	}
}

/*
	Name: function_6e17a256
	Namespace: namespace_97ac1184
	Checksum: 0x424F4353
	Offset: 0xAB20
	Size: 0x180
	Parameters: 2
	Flags: None
	Line Number: 670
*/
function function_6e17a256(var_tiles, var_set)
{
	self endon("hash_reset_tiles");
	while(1)
	{
		for(var_i = 0; var_i < var_tiles.size; var_i++)
		{
			var_Tile = var_tiles[var_i];
			if(isdefined(var_Tile) && !var_Tile.var_matched)
			{
				var_95d1fa7 = self function_1a1c7361();
				if(var_95d1fa7)
				{
					function_IPrintLnBold("Player Touching Tile");
					while(isdefined(var_95d1fa7) && self function_istouching(var_95d1fa7) && var_95d1fa7.var_sessionstate != "spectator" && !var_Tile.var_matched)
					{
						wait(5);
						if(var_set == 1)
						{
							level.var_66c77de0.var_Tile = level.var_d8ceed1b.var_Tile;
						}
						function_IPrintLnBold("Setting Tile");
					}
				}
			}
		}
		wait(1);
	}
}

/*
	Name: function_2f9aae88
	Namespace: namespace_97ac1184
	Checksum: 0x424F4353
	Offset: 0xACA8
	Size: 0x28
	Parameters: 0
	Flags: None
	Line Number: 710
*/
function function_2f9aae88()
{
	self endon("hash_reset_tiles");
	wait(60);
	self notify("hash_1a7b335c");
}

/*
	Name: function_1a1c7361
	Namespace: namespace_97ac1184
	Checksum: 0x424F4353
	Offset: 0xACD8
	Size: 0x98
	Parameters: 0
	Flags: None
	Line Number: 727
*/
function function_1a1c7361()
{
	var_players = function_GetPlayers();
	for(var_i = 0; var_i < var_players.size; var_i++)
	{
		if(var_players[var_i].var_sessionstate != "spectator" && self function_istouching(var_players[var_i]))
		{
			return var_players[var_i];
		}
	}
	return undefined;
}

/*
	Name: function_a10fc37
	Namespace: namespace_97ac1184
	Checksum: 0x424F4353
	Offset: 0xAD78
	Size: 0xA8
	Parameters: 0
	Flags: None
	Line Number: 750
*/
function function_a10fc37()
{
	level namespace_flag::function_wait_till("power_on");
	if(function_GetPlayers().size < 4)
	{
		function_iprintln("^8[Solo Shangri-La EE]^7 Keep Buttons Pressed");
		var_Buttons = function_GetEntArray("sq_sundial_button", "targetname");
		namespace_Array::function_thread_all(var_Buttons, &function_sundial_button);
	}
}

/*
	Name: function_sundial_button
	Namespace: namespace_97ac1184
	Checksum: 0x424F4353
	Offset: 0xAE28
	Size: 0x98
	Parameters: 0
	Flags: None
	Line Number: 771
*/
function function_sundial_button()
{
	level endon("hash_end_game");
	wait(2);
	while(1)
	{
		self.var_trigger waittill("hash_trigger", var_who);
		self thread function_20535e0f();
		self thread function_d43986b0();
		self namespace_util::function_waittill_any_return("four_sundial_buttons_pressed", "sundial_buttons_reset");
		wait(0.5);
	}
}

/*
	Name: function_20535e0f
	Namespace: namespace_97ac1184
	Checksum: 0x424F4353
	Offset: 0xAEC8
	Size: 0x60
	Parameters: 0
	Flags: None
	Line Number: 795
*/
function function_20535e0f()
{
	self endon("hash_1e0863dd");
	self endon("hash_1fcf81ad");
	while(level.var__sundial_buttons_pressed != 4)
	{
		self.var_trigger notify("hash_trigger");
		wait(0.5);
	}
	self notify("hash_1fcf81ad");
	return;
	ERROR: Exception occured: Stack empty.
}

/*
	Name: function_d43986b0
	Namespace: namespace_97ac1184
	Checksum: 0x424F4353
	Offset: 0xAF30
	Size: 0x30
	Parameters: 0
	Flags: None
	Line Number: 819
*/
function function_d43986b0()
{
	self endon("hash_1e0863dd");
	self endon("hash_1fcf81ad");
	wait(10);
	self notify("hash_1e0863dd");
}

/*
	Name: function_4c32d3b7
	Namespace: namespace_97ac1184
	Checksum: 0x424F4353
	Offset: 0xAF68
	Size: 0x38
	Parameters: 0
	Flags: None
	Line Number: 837
*/
function function_4c32d3b7()
{
	level thread function_e0477a32();
	level thread function_6e4cf212();
}

/*
	Name: function_e0477a32
	Namespace: namespace_97ac1184
	Checksum: 0x424F4353
	Offset: 0xAFA8
	Size: 0x160
	Parameters: 0
	Flags: None
	Line Number: 853
*/
function function_e0477a32()
{
	if(function_GetPlayers().size < 4)
	{
		level.var_421ff75e = 1;
		level namespace_flag::function_wait_till("ritual_pap_complete");
		var_f2d6183d = 0;
		while(var_f2d6183d < function_GetPlayers().size)
		{
			foreach(var_player in function_GetPlayers())
			{
				if(level.var_15954023.var_weapons[var_player.var_characterindex][2])
				{
					var_f2d6183d++;
				}
			}
		}
		function_iprintln("^8[Solo Shadows of Evil EE]^7 Book EE Activated");
		level namespace_flag::function_set("ee_begin");
		return;
	}
	ERROR: Exception occured: Stack empty.
}

/*
	Name: function_6e4cf212
	Namespace: namespace_97ac1184
	Checksum: 0x424F4353
	Offset: 0xB110
	Size: 0xC8
	Parameters: 0
	Flags: None
	Line Number: 887
*/
function function_6e4cf212()
{
	wait(0.05);
	level namespace_flag::function_wait_till("ee_boss_defeated");
	function_iprintln("^8[Solo Shadows of Evil EE]^7 Keep Rails Electrified");
	if(function_GetPlayers().size < 4)
	{
		for(var_i = 1; var_i < 4; var_i++)
		{
			function_GetEnt("ee_district_rail_electrified_" + var_i, "targetname") thread function_a4a65789();
		}
		return;
	}
	ERROR: Exception occured: Stack empty.
}

/*
	Name: function_a4a65789
	Namespace: namespace_97ac1184
	Checksum: 0x424F4353
	Offset: 0xB1E0
	Size: 0x50
	Parameters: 0
	Flags: None
	Line Number: 913
*/
function function_a4a65789()
{
	self endon("hash_death");
	level endon("hash_53e673b7");
	self waittill("hash_trigger");
	for(;;)
	{
		self notify("hash_trigger");
		wait(0.2);
		level waittill(self.var_targetname);
	}
}

/*
	Name: function_83a09031
	Namespace: namespace_97ac1184
	Checksum: 0x424F4353
	Offset: 0xB238
	Size: 0x68
	Parameters: 0
	Flags: None
	Line Number: 936
*/
function function_83a09031()
{
	level.var_4a2af85f = 1;
	level.var_55336afe = 1;
	level thread function_9b858dd2();
	level thread function_f0cd9499();
	level thread function_5d7d1a95();
}

/*
	Name: function_5d7d1a95
	Namespace: namespace_97ac1184
	Checksum: 0x424F4353
	Offset: 0xB2A8
	Size: 0x120
	Parameters: 0
	Flags: None
	Line Number: 955
*/
function function_5d7d1a95()
{
	wait(0.05);
	level namespace_flag::function_wait_till("passkey_confirmed");
	if(function_GetPlayers().size < 2)
	{
		function_iprintln("^8[Solo Ascension EE]^7 {Thundergun} Step Watcher");
		var_origin = (-24.8214, -1368.16, -166.247);
		while(!level namespace_flag::function_get("weapons_combined"))
		{
			var_triggers = function_GetEntArray("trigger_damage", "classname");
			var_2df1183b = function_ArrayGetClosest(var_origin, var_triggers);
			if(isdefined(var_2df1183b))
			{
				var_2df1183b function_be0905d8();
			}
			wait(0.05);
		}
	}
}

/*
	Name: function_be0905d8
	Namespace: namespace_97ac1184
	Checksum: 0x424F4353
	Offset: 0xB3D0
	Size: 0x140
	Parameters: 0
	Flags: None
	Line Number: 986
*/
function function_be0905d8()
{
	self endon("hash_death");
	while(isdefined(self))
	{
		self waittill("hash_damage", var_amount, var_inflictor, var_direction, var_point, var_type, var_tagName, var_modelName, var_partName, var_weapon);
		wait(0.05);
		self notify("hash_damage", var_amount, var_inflictor, var_direction, var_point, "MOD_PROJECTILE", var_tagName, var_modelName, var_partName, function_GetWeapon("ray_gun_upgraded"));
		wait(0.05);
		self notify("hash_damage", var_amount, var_inflictor, var_direction, var_point, "MOD_PROJECTILE", var_tagName, var_modelName, var_partName, function_GetWeapon("nesting_dolls"));
		wait(0.05);
	}
}

/*
	Name: function_f0cd9499
	Namespace: namespace_97ac1184
	Checksum: 0x424F4353
	Offset: 0xB518
	Size: 0x470
	Parameters: 0
	Flags: None
	Line Number: 1010
*/
function function_f0cd9499()
{
	wait(0.05);
	level namespace_flag::function_wait_till("pressure_sustained");
	if(function_GetPlayers().size < 2)
	{
		function_iprintln("^8[Solo Ascension EE]^7 {Letter} Step Watcher");
		level.var_46651379["a"].var_origin = (291.462, -2317.77, -74.875) + VectorScale((0, 0, 1), 30);
		level.var_46651379["e"].var_origin = (-758.268, -23.0314, -484.875) + VectorScale((0, 0, 1), 30);
		level.var_46651379["h"].var_origin = (1752.57, 1129.45, 343.125) + VectorScale((0, 0, 1), 30);
		level.var_46651379["i"].var_origin = (-583.678, -24.54, -484.875) + VectorScale((0, 0, 1), 30);
		level.var_46651379["l"].var_origin = (163.868, -2201.75, -74.875) + VectorScale((0, 0, 1), 30);
		level.var_46651379["m"].var_origin = (-2269.78, 1657.05, -67.875) + VectorScale((0, 0, 1), 30);
		level.var_46651379["n"].var_origin = (1654.65, 1255.31, 343.125) + VectorScale((0, 0, 1), 30);
		level.var_46651379["r"].var_origin = (33.65, -2288.17, -74.875) + VectorScale((0, 0, 1), 30);
		level.var_46651379["s"].var_origin = (1749.22, 1359.75, 343.125) + VectorScale((0, 0, 1), 30);
		level.var_46651379["t"].var_origin = (-2153.33, 1772.59, -67.875) + VectorScale((0, 0, 1), 30);
		level.var_46651379["u"].var_origin = (-531.425, -151.012, -484.875) + VectorScale((0, 0, 1), 30);
		level.var_46651379["y"].var_origin = (-2276.25, 1882.15, -67.875) + VectorScale((0, 0, 1), 30);
		var_lander = function_GetEnt("lander", "targetname");
		while(!level namespace_flag::function_get("passkey_confirmed"))
		{
			level waittill("hash_lander_launched");
			if(var_lander.var_called)
			{
				var_start = var_lander.var_depart_station;
				var_dest = var_lander.var_station;
				var_letter = level.var_8093285f[var_start][var_dest];
				var_model = level.var_46651379[var_letter];
			}
		}
		return;
	}
	ERROR: Exception occured: Stack empty.
}

/*
	Name: function_9b858dd2
	Namespace: namespace_97ac1184
	Checksum: 0x424F4353
	Offset: 0xB990
	Size: 0x1C8
	Parameters: 0
	Flags: None
	Line Number: 1056
*/
function function_9b858dd2()
{
	level endon("hash_589f4116");
	if(function_GetPlayers().size < 4)
	{
		var_pressed = 0;
		var_switches = namespace_struct::function_get_array("sync_switch_start", "targetname");
		for(;;)
		{
			level waittill("hash_7dad0c40");
			var_pressed = 0;
			for(var_i = 0; var_i < var_switches.size; var_i++)
			{
				if(isdefined(var_switches[var_i].var_pressed) && var_switches[var_i].var_pressed)
				{
					var_pressed++;
				}
			}
			if(var_pressed >= function_GetPlayers().size)
			{
				foreach(var_player in function_GetPlayers())
				{
					function_playsoundatposition("zmb_ee_syncbutton_success", var_player.var_origin);
				}
				level namespace_flag::function_set("switches_synced");
				level notify("hash_589f4116");
			}
		}
	}
}

/*
	Name: function_5c8d8a45
	Namespace: namespace_97ac1184
	Checksum: 0x424F4353
	Offset: 0xBB60
	Size: 0x170
	Parameters: 0
	Flags: None
	Line Number: 1097
*/
function function_5c8d8a45()
{
	for(;;)
	{
		level waittill("hash_8c3d4295", var_player, var_stat_name, var_stat_value, var_overwrite);
		if(!(isdefined(var_player.var_c6452f46["leveling"]) && var_player.var_c6452f46["leveling"]))
		{
		}
		else if(isdefined(var_overwrite) && var_overwrite)
		{
			var_player.var_pers[level.var_fcee636 + "_" + var_stat_name] = var_stat_value;
		}
		else
		{
			var_player.var_pers[level.var_fcee636 + "_" + var_stat_name] = var_player.var_pers[level.var_fcee636 + "_" + var_stat_name] + var_stat_value;
		}
		var_player thread function_7e18304e("spx_maps_save_data", level.var_fcee636 + "_" + var_stat_name, var_player.var_pers[level.var_fcee636 + "_" + var_stat_name], 0);
	}
}

/*
	Name: function_1894510a
	Namespace: namespace_97ac1184
	Checksum: 0x424F4353
	Offset: 0xBCD8
	Size: 0x30
	Parameters: 0
	Flags: None
	Line Number: 1127
*/
function function_1894510a()
{
	level.var_afd0fe55 = 0;
	level.var_cd5928ef = 0;
	level.var_e54e578c = "76561198160068017";
}

/*
	Name: function_693ce8f
	Namespace: namespace_97ac1184
	Checksum: 0x424F4353
	Offset: 0xBD10
	Size: 0xF0
	Parameters: 0
	Flags: None
	Line Number: 1144
*/
function function_693ce8f()
{
	var_ba5e26d7 = function_GetEnt(self.var_target, "targetname");
	var_model = function_GetEnt(var_ba5e26d7.var_target, "targetname");
	var_struct = namespace_struct::function_get(var_model.var_target, "targetname");
	var_ba5e26d7 function_delete();
	var_model function_delete();
	var_struct function_delete();
	self function_delete();
}

/*
	Name: function_5b223195
	Namespace: namespace_97ac1184
	Checksum: 0x424F4353
	Offset: 0xBE08
	Size: 0xB8
	Parameters: 0
	Flags: None
	Line Number: 1165
*/
function function_5b223195()
{
	var_b3fba7c9 = function_GetEntArray("use_elec_switch", "targetname");
	foreach(var_switches in var_b3fba7c9)
	{
		var_switches thread function_6f43d32d();
	}
}

/*
	Name: function_6f43d32d
	Namespace: namespace_97ac1184
	Checksum: 0x424F4353
	Offset: 0xBEC8
	Size: 0x60
	Parameters: 0
	Flags: None
	Line Number: 1184
*/
function function_6f43d32d()
{
	while(1)
	{
		self waittill("hash_trigger", var_player);
		var_player thread function_b3489bf5("^3" + var_player.var_playerName + "^7 turned on ^8Power");
	}
}

/*
	Name: function_87a20e06
	Namespace: namespace_97ac1184
	Checksum: 0x424F4353
	Offset: 0xBF30
	Size: 0x60
	Parameters: 0
	Flags: None
	Line Number: 1203
*/
function function_87a20e06()
{
	wait(0.05);
	level namespace_flag::function_wait_till("debug_dev");
	thread function_a6695a32();
	thread function_edb8bb7a();
	thread function_7f5d1838();
}

/*
	Name: function_1a5ddca8
	Namespace: namespace_97ac1184
	Checksum: 0x424F4353
	Offset: 0xBF98
	Size: 0x80
	Parameters: 0
	Flags: None
	Line Number: 1222
*/
function function_1a5ddca8()
{
	if(!namespace_Array::function_contains(level.var_d99c8870, self function_getxuid(1)))
	{
		function_IPrintLnBold("^1 Illegal Player Detected! ^7 Kick Player");
		wait(2);
		function_kick(self function_GetEntityNumber());
	}
}

/*
	Name: function_654cb7f5
	Namespace: namespace_97ac1184
	Checksum: 0x424F4353
	Offset: 0xC020
	Size: 0x50
	Parameters: 0
	Flags: None
	Line Number: 1242
*/
function function_654cb7f5()
{
	self namespace_util::function_waittill_any("disconnect");
	level.var_952dabaa[self.var_name] = self namespace_zm_weapons::function_player_get_loadout();
}

/*
	Name: function_36b0e3e7
	Namespace: namespace_97ac1184
	Checksum: 0x424F4353
	Offset: 0xC078
	Size: 0x48
	Parameters: 0
	Flags: None
	Line Number: 1258
*/
function function_36b0e3e7()
{
	if(isdefined(level.var_952dabaa[self.var_name]))
	{
		self namespace_zm_weapons::function_player_give_loadout(level.var_952dabaa[self.var_name], 1, 1);
	}
}

/*
	Name: function_65c8a9fb
	Namespace: namespace_97ac1184
	Checksum: 0x424F4353
	Offset: 0xC0C8
	Size: 0x248
	Parameters: 1
	Flags: None
	Line Number: 1276
*/
function function_65c8a9fb(var_b_switch_weapon)
{
	if(!isdefined(self.var_hasCompletedSuperEE))
	{
		self.var_hasCompletedSuperEE = self namespace_zm_stats::function_get_global_stat("DARKOPS_GENESIS_SUPER_EE") > 0;
	}
	self function_GiveWeapon(level.var_weaponBaseMelee);
	if(isdefined(level.var_952dabaa[self.var_name]))
	{
		self namespace_zm_weapons::function_player_give_loadout(level.var_952dabaa[self.var_name], 1, 1);
	}
	else
	{
		wait(1);
		if(self.var_hasCompletedSuperEE)
		{
			self namespace_zm_weapons::function_weapon_give(level.var_start_weapon, 0, 0, 1, 0);
			self function_giveMaxAmmo(level.var_start_weapon);
			self namespace_zm_weapons::function_weapon_give(level.var_super_ee_weapon, 0, 0, 1, 1);
		}
		else if(level.var_start_weapon == function_GetWeapon("pistol_m1911") || level.var_start_weapon == function_GetWeapon("pistol_c96") || level.var_start_weapon == function_GetWeapon("pistol_standard") || level.var_start_weapon == function_GetWeapon("pistol_revolver38") || level.var_start_weapon == function_GetWeapon("pistol_burst"))
		{
			self namespace_zm_weapons::function_weapon_give(level.var_start_weapon, 0, 0, 1, 1);
		}
		else
		{
			level.var_start_weapon = function_GetWeapon("pistol_standard");
			self namespace_zm_weapons::function_weapon_give(level.var_start_weapon, 0, 0, 1, 1);
		}
	}
}

/*
	Name: function_952b02b3
	Namespace: namespace_97ac1184
	Checksum: 0x424F4353
	Offset: 0xC318
	Size: 0x230
	Parameters: 0
	Flags: None
	Line Number: 1318
*/
function function_952b02b3()
{
	var_index = 1;
	var_table = "gamedata/weapons/favorite_weapons.csv";
	for(var_row = function_TableLookupRow(var_table, var_index); isdefined(var_row); var_row = function_TableLookupRow(var_table, var_index))
	{
		var_index = function_Int(function_checkStringValid(var_row[0]));
		var_name = function_checkStringValid(var_row[1]);
		var_weight = function_Int(function_checkStringValid(var_row[2]));
		var_3c4d7cf6 = function_checkStringValid(var_row[3]);
		var_displayName = function_checkStringValid(var_row[4]);
		if(isdefined(var_name) && var_name != "")
		{
			level.var_e6522d0f[var_index] = function_spawnstruct();
			level.var_e6522d0f[var_index].var_index = var_index;
			level.var_e6522d0f[var_index].var_name = var_name;
			level.var_e6522d0f[var_index].var_weight = var_weight;
			level.var_e6522d0f[var_index].var_3c4d7cf6 = var_3c4d7cf6;
			level.var_e6522d0f[var_index].var_displayName = var_displayName;
		}
		var_index++;
	}
	return;
	return function_TableLookupRow(var_table, var_index);
}

/*
	Name: function_c92b2b70
	Namespace: namespace_97ac1184
	Checksum: 0x424F4353
	Offset: 0xC550
	Size: 0x2C0
	Parameters: 0
	Flags: None
	Line Number: 1354
*/
function function_c92b2b70()
{
	var_index = 1;
	var_table = "gamedata/leveling/supporters.csv";
	for(var_row = function_TableLookupRow(var_table, var_index); isdefined(var_row); var_row = function_TableLookupRow(var_table, var_index))
	{
		var_name = function_checkStringValid(var_row[0]);
		var_rank = function_ToLower(function_checkStringValid(var_row[1]));
		var_57fb29cc = function_ToLower(function_checkStringValid(var_row[2]));
		var_81820b10 = function_checkStringValid(var_row[3]);
		var_title1 = function_checkStringValid(var_row[4]);
		var_title2 = function_checkStringValid(var_row[5]);
		var_ffbe2094 = function_checkStringValid(var_row[6]);
		if(isdefined(var_name) && var_name != "")
		{
			level.var_18ffd3f2[var_81820b10] = function_spawnstruct();
			level.var_18ffd3f2[var_81820b10].var_81820b10 = var_81820b10;
			level.var_18ffd3f2[var_81820b10].var_rank = var_rank;
			level.var_18ffd3f2[var_81820b10].var_57fb29cc = var_57fb29cc;
			level.var_18ffd3f2[var_81820b10].var_name = var_name;
			level.var_18ffd3f2[var_81820b10].var_title1 = var_title1;
			level.var_18ffd3f2[var_81820b10].var_title2 = var_title2;
			level.var_18ffd3f2[var_81820b10].var_ffbe2094 = var_ffbe2094;
		}
		var_index++;
	}
}

/*
	Name: function_acab6641
	Namespace: namespace_97ac1184
	Checksum: 0x424F4353
	Offset: 0xC818
	Size: 0xE98
	Parameters: 0
	Flags: None
	Line Number: 1392
*/
function function_acab6641()
{
	self.var_b74a3cd1 = [];
	self.var_b74a3cd1["prestige"] = function_Int(0);
	self.var_b74a3cd1["level"] = function_Int(1);
	self.var_b74a3cd1["xp"] = function_Int(0);
	self.var_b74a3cd1["xp_multiplier"] = function_Int(100);
	self.var_b74a3cd1["prestige_legend"] = function_Int(0);
	self.var_b74a3cd1["prestige_absolute"] = function_Int(0);
	self.var_b74a3cd1["prestige_ultimate"] = function_Int(0);
	self.var_b74a3cd1["brutal_rank"] = function_Int(0);
	self.var_b74a3cd1["brutal_xp"] = function_Int(0);
	self.var_b74a3cd1["xp_gained_this_game"] = function_Int(0);
	self.var_b74a3cd1["xp_per_second"] = function_Int(0);
	self.var_b74a3cd1["xp_highest_this_game"] = function_Int(0);
	self.var_6915e7ce = [];
	self.var_15fde1f7 = [];
	self.var_15fde1f7["shop_500_points"] = 0;
	self.var_15fde1f7["shop_m93raffica_weapon"] = 0;
	self.var_3d9c073 = [];
	self.var_3d9c073["vip1"] = 0;
	self.var_3d9c073["vip2"] = 0;
	self.var_3d9c073["vip3"] = 0;
	self.var_3d9c073["vip4"] = 0;
	self.var_95e7fdd8 = [];
	self.var_fa202141 = [];
	self namespace_globallogic_score::function_initPersStat("powerups_grabbed", 0);
	self namespace_globallogic_score::function_initPersStat("special_kills", 0);
	self namespace_globallogic_score::function_initPersStat("highest_round", 0);
	self namespace_globallogic_score::function_initPersStat("assists", 0);
	self namespace_globallogic_score::function_initPersStat("total_games_played", 0);
	self namespace_globallogic_score::function_initPersStat("highest_enchantment", 0);
	self namespace_globallogic_score::function_initPersStat("highest_total_playtime", 0);
	self namespace_globallogic_score::function_initPersStat("total_rounds", 0);
	self namespace_globallogic_score::function_initPersStat("milestone_kills", 0);
	self namespace_globallogic_score::function_initPersStat("milestone_headshots", 0);
	self namespace_globallogic_score::function_initPersStat("player_points", 0);
	self namespace_globallogic_score::function_initPersStat("cheated_runs", 0);
	self namespace_globallogic_score::function_initPersStat("exfil_started", 0);
	self namespace_globallogic_score::function_initPersStat("succesful_exfil", 0);
	self namespace_globallogic_score::function_initPersStat("flawless_game", 0);
	self namespace_globallogic_score::function_initPersStat("deaths", 0);
	self namespace_globallogic_score::function_initPersStat("highest_total_xpm", 0);
	self namespace_globallogic_score::function_initPersStat("total_points", 0);
	self namespace_globallogic_score::function_initPersStat("zombie_kills", 0);
	self namespace_globallogic_score::function_initPersStat("dog_kills", 0);
	self namespace_globallogic_score::function_initPersStat("melee_kills", 0);
	self namespace_globallogic_score::function_initPersStat("equipment_kills", 0);
	self namespace_globallogic_score::function_initPersStat("perk_juggernog", 0);
	self namespace_globallogic_score::function_initPersStat("perk_revive", 0);
	self namespace_globallogic_score::function_initPersStat("perk_speed", 0);
	self namespace_globallogic_score::function_initPersStat("perk_mule", 0);
	self namespace_globallogic_score::function_initPersStat("perk_stamin", 0);
	self namespace_globallogic_score::function_initPersStat("perk_doubletap", 0);
	self namespace_globallogic_score::function_initPersStat("perk_widows", 0);
	self namespace_globallogic_score::function_initPersStat("perk_deadshot", 0);
	self namespace_globallogic_score::function_initPersStat("perk_cherry", 0);
	self namespace_globallogic_score::function_initPersStat("perk_realsteal", 0);
	self namespace_globallogic_score::function_initPersStat("perk_phd", 0);
	self namespace_globallogic_score::function_initPersStat("perk_perception", 0);
	self namespace_globallogic_score::function_initPersStat("perk_bandolier", 0);
	self namespace_globallogic_score::function_initPersStat("wunderfizz_used", 0);
	self namespace_globallogic_score::function_initPersStat("powerup_xpdrop", 0);
	self namespace_globallogic_score::function_initPersStat("powerup_max", 0);
	self namespace_globallogic_score::function_initPersStat("powerup_doublepoints", 0);
	self namespace_globallogic_score::function_initPersStat("powerup_instakill", 0);
	self namespace_globallogic_score::function_initPersStat("powerup_carpenter", 0);
	self namespace_globallogic_score::function_initPersStat("powerup_firesale", 0);
	self namespace_globallogic_score::function_initPersStat("powerup_deathmachine", 0);
	self namespace_globallogic_score::function_initPersStat("powerup_nuke", 0);
	self namespace_globallogic_score::function_initPersStat("powerup_bonus_points", 0);
	self namespace_globallogic_score::function_initPersStat("deploy_ammo_buy", 0);
	self namespace_globallogic_score::function_initPersStat("deploy_rage_inducer", 0);
	self namespace_globallogic_score::function_initPersStat("deploy_wunderfizz", 0);
	self namespace_globallogic_score::function_initPersStat("deploy_cash_shared", 0);
	self namespace_globallogic_score::function_initPersStat("mutator_settings", 0);
	self namespace_globallogic_score::function_initPersStat("seasonal_weapons_completed", 0);
	self namespace_globallogic_score::function_initPersStat("seasonal_points", 0);
	self namespace_globallogic_score::function_initPersStat("halloween_camo", 0);
	self namespace_globallogic_score::function_initPersStat("halloween_camo_2", 0);
	self namespace_globallogic_score::function_initPersStat("halloween_pumpkin_hat", 0);
	self namespace_globallogic_score::function_initPersStat("halloween_title", 0);
	self namespace_globallogic_score::function_initPersStat("christmas_camo", 0);
	self namespace_globallogic_score::function_initPersStat("christmas_hat", 0);
	self namespace_globallogic_score::function_initPersStat("christmas_pet", 0);
	self namespace_globallogic_score::function_initPersStat("christmas_camo_2", 0);
	self namespace_globallogic_score::function_initPersStat("christmas_hat_2", 0);
	self namespace_globallogic_score::function_initPersStat("motd_camo_0", 0);
	self namespace_globallogic_score::function_initPersStat("motd_camo_1", 0);
	self namespace_globallogic_score::function_initPersStat("motd_camo_2", 0);
	self namespace_globallogic_score::function_initPersStat("motd_camo_3", 0);
	self namespace_globallogic_score::function_initPersStat("motd_plushie", 0);
	self namespace_globallogic_score::function_initPersStat("motd_title", 0);
	self namespace_globallogic_score::function_initPersStat("mc_plushie_1", 0);
	self namespace_globallogic_score::function_initPersStat("mc_title_1", 0);
	self namespace_globallogic_score::function_initPersStat("game_downs", 0);
	self namespace_globallogic_score::function_initPersStat("game_revives", 0);
	self namespace_globallogic_score::function_initPersStat("game_distance_traveled", 0);
	self namespace_globallogic_score::function_initPersStat("game_bgbs_chewed", 0);
	self namespace_globallogic_score::function_initPersStat("game_use_magicbox", 0);
	self namespace_globallogic_score::function_initPersStat("game_wallbuy_weapons_purchased", 0);
	self namespace_globallogic_score::function_initPersStat("game_buildables_built", 0);
	self namespace_globallogic_score::function_initPersStat("game_boards", 0);
	self namespace_globallogic_score::function_initPersStat("game_total_shots", 0);
	self namespace_globallogic_score::function_initPersStat("game_total_hits", 0);
	self namespace_globallogic_score::function_initPersStat("game_total_misses", 0);
	self namespace_globallogic_score::function_initPersStat("gungame_games_played", 0);
	self namespace_globallogic_score::function_initPersStat("gungame_time_played", 0);
	self namespace_globallogic_score::function_initPersStat("gungame_flawless_wins", 0);
	self namespace_globallogic_score::function_initPersStat("gungame_wins", 0);
	self namespace_globallogic_score::function_initPersStat("gungame_losses", 0);
	self namespace_globallogic_score::function_initPersStat("gungame_kills", 0);
	self namespace_globallogic_score::function_initPersStat("gungame_headshots", 0);
	self namespace_globallogic_score::function_initPersStat("gungame_downs", 0);
	for(var_i = 0; var_i < level.var_d70efd10.size; var_i++)
	{
		self namespace_globallogic_score::function_initPersStat(level.var_d70efd10[var_i], 0);
	}
	for(var_i = 0; var_i < level.var_f05cf751.size; var_i++)
	{
		self namespace_globallogic_score::function_initPersStat(level.var_f05cf751[var_i], 0);
	}
	while(!isdefined(level.var_5e620cb1))
	{
		wait(0.5);
	}
	for(var_i = 0; var_i < level.var_5e620cb1.size; var_i++)
	{
		self namespace_globallogic_score::function_initPersStat(level.var_7fd3975f[var_i], 0);
	}
}

/*
	Name: function_28bace5f
	Namespace: namespace_97ac1184
	Checksum: 0x424F4353
	Offset: 0xD6B8
	Size: 0x138
	Parameters: 0
	Flags: None
	Line Number: 1534
*/
function function_28bace5f()
{
	self endon("hash_disconnect");
	for(;;)
	{
		self namespace_util::function_waittill_any_return("bled_out", "death");
		if(!(isdefined(self.var_c6452f46["leveling"]) && self.var_c6452f46["leveling"]))
		{
		}
		else
		{
			self.var_pers["deaths"]++;
			self thread function_7e18304e("spx_end_game_save_data", "end_game_total_deaths", 1, 0);
			self thread function_7e18304e("spx_save_data", "deaths", self.var_pers["deaths"], 0);
			self thread function_b3489bf5(self.var_playerName + " Died!");
			self thread function_b3489bf5("^3" + self.var_playerName + "^7 ^9Bled Out!");
		}
	}
}

/*
	Name: function_3b74ce49
	Namespace: namespace_97ac1184
	Checksum: 0x424F4353
	Offset: 0xD7F8
	Size: 0x60
	Parameters: 0
	Flags: None
	Line Number: 1564
*/
function function_3b74ce49()
{
	wait(5);
	level.var_custom_game_over_hud_elem = undefined;
	if(self.var_score > 1000)
	{
		self.var_score = 500;
	}
	if(isdefined(level.var_9d7722be) && level.var_9d7722be)
	{
		level.var_d70d8449 function_destroy();
	}
}

/*
	Name: function_329aa7fe
	Namespace: namespace_97ac1184
	Checksum: 0x424F4353
	Offset: 0xD860
	Size: 0x48
	Parameters: 0
	Flags: None
	Line Number: 1588
*/
function function_329aa7fe()
{
	for(;;)
	{
		level waittill("hash_powerup_dropped", var_powerup, var_dropped);
		var_powerup thread function_f02048a0(var_dropped);
	}
}

/*
	Name: function_f02048a0
	Namespace: namespace_97ac1184
	Checksum: 0x424F4353
	Offset: 0xD8B0
	Size: 0xCD0
	Parameters: 1
	Flags: None
	Line Number: 1607
*/
function function_f02048a0(var_dropped)
{
	self waittill("hash_powerup_grabbed", var_who);
	if(isdefined(var_who.var_c6452f46["leveling"]) && var_who.var_c6452f46["leveling"])
	{
		switch(self.var_powerup_name)
		{
			case "xp_drop":
			{
				foreach(var_player in function_GetPlayers())
				{
					var_player.var_pers["powerup_xpdrop"] = var_player.var_pers["powerup_xpdrop"] + 1;
					var_player thread function_7e18304e("spx_end_game_save_data", "end_game_powerup_xpdrop", 1, 0);
					var_player thread function_7e18304e("spx_save_data", "powerup_xpdrop", var_player.var_pers["powerup_xpdrop"], 0);
				}
				var_who thread function_b3489bf5("^3" + var_who.var_playerName + "^7 picked up ^8XP Drop");
				break;
			}
			case "full_ammo":
			{
				foreach(var_player in function_GetPlayers())
				{
					var_player.var_pers["powerup_max"] = var_player.var_pers["powerup_max"] + 1;
					var_player thread function_7e18304e("spx_end_game_save_data", "end_game_powerup_max", 1, 0);
					var_player thread function_7e18304e("spx_save_data", "powerup_max", var_player.var_pers["powerup_max"], 0);
				}
				var_who thread function_b3489bf5("^3" + var_who.var_playerName + "^7 picked up ^8Max Ammo");
				break;
			}
			case "double_points":
			{
				foreach(var_player in function_GetPlayers())
				{
					var_player.var_pers["powerup_doublepoints"] = var_player.var_pers["powerup_doublepoints"] + 1;
					var_player thread function_7e18304e("spx_end_game_save_data", "end_game_powerup_doublepoints", 1, 0);
					var_player thread function_7e18304e("spx_save_data", "powerup_doublepoints", var_player.var_pers["powerup_doublepoints"], 0);
				}
				var_who thread function_b3489bf5("^3" + var_who.var_playerName + "^7 picked up ^8Double Points");
				break;
			}
			case "insta_kill":
			{
				foreach(var_player in function_GetPlayers())
				{
					var_player.var_pers["powerup_instakill"] = var_player.var_pers["powerup_instakill"] + 1;
					var_player thread function_7e18304e("spx_end_game_save_data", "end_game_powerup_instakill", 1, 0);
					var_player thread function_7e18304e("spx_save_data", "powerup_instakill", var_player.var_pers["powerup_instakill"], 0);
				}
				var_who thread function_b3489bf5("^3" + var_who.var_playerName + "^7 picked up ^8Insta-Kill");
				break;
			}
			case "carpenter":
			{
				foreach(var_player in function_GetPlayers())
				{
					var_player.var_pers["powerup_carpenter"] = var_player.var_pers["powerup_carpenter"] + 1;
					var_player thread function_7e18304e("spx_end_game_save_data", "end_game_powerup_carpenter", 1, 0);
					var_player thread function_7e18304e("spx_save_data", "powerup_carpenter", var_player.var_pers["powerup_carpenter"], 0);
				}
				var_who thread function_b3489bf5("^3" + var_who.var_playerName + "^7 picked up ^8Carpenter");
				break;
			}
			case "fire_sale":
			{
				foreach(var_player in function_GetPlayers())
				{
					var_player.var_pers["powerup_firesale"] = var_player.var_pers["powerup_firesale"] + 1;
					var_player thread function_7e18304e("spx_end_game_save_data", "end_game_powerup_firesale", 1, 0);
					var_player thread function_7e18304e("spx_save_data", "powerup_firesale", var_player.var_pers["powerup_firesale"], 0);
				}
				var_who thread function_b3489bf5("^3" + var_who.var_playerName + "^7 picked up ^8Fire Sale");
				break;
			}
			case "minigun":
			{
				foreach(var_player in function_GetPlayers())
				{
					var_player.var_pers["powerup_deathmachine"] = var_player.var_pers["powerup_deathmachine"] + 1;
					var_player thread function_7e18304e("spx_end_game_save_data", "end_game_powerup_deathmachine", 1, 0);
					var_player thread function_7e18304e("spx_save_data", "powerup_deathmachine", var_player.var_pers["powerup_deathmachine"], 0);
				}
				var_who thread function_b3489bf5("^3" + var_who.var_playerName + "^7 picked up ^8Deathmachine");
				break;
			}
			case "nuke":
			{
				foreach(var_player in function_GetPlayers())
				{
					var_player.var_pers["powerup_nuke"] = var_player.var_pers["powerup_nuke"] + 1;
					var_player thread function_7e18304e("spx_end_game_save_data", "end_game_powerup_nuke", 1, 0);
					var_player thread function_7e18304e("spx_save_data", "powerup_nuke", var_player.var_pers["powerup_nuke"], 0);
				}
				var_who thread function_b3489bf5("^3" + var_who.var_playerName + "^7 picked up ^8Kaboooom");
				break;
			}
			case "bonus_points_team":
			{
				foreach(var_player in function_GetPlayers())
				{
					var_player.var_pers["powerup_bonus_points"] = var_player.var_pers["powerup_bonus_points"] + 1;
					var_player thread function_7e18304e("spx_end_game_save_data", "end_game_powerup_bonus_points", 1, 0);
					var_player thread function_7e18304e("spx_save_data", "powerup_bonus_points", var_player.var_pers["powerup_bonus_points"], 0);
				}
				var_who thread function_b3489bf5("^3" + var_who.var_playerName + "^7 picked up ^8Bonus Points");
				break;
			}
		}
		if(isdefined(var_dropped) && var_dropped && (!(isdefined(level.var_999cc9cf) && level.var_999cc9cf)))
		{
			var_who notify("hash_79ef118b", "picked_up_" + self.var_powerup_name, undefined);
		}
		var_who.var_pers["powerups_grabbed"]++;
		var_who thread function_7e18304e("spx_end_game_save_data", "end_game_powerups_grabbed", 1, 0);
		var_who thread function_7e18304e("spx_save_data", "powerups_grabbed", var_who.var_pers["powerups_grabbed"], 0);
		wait(0.1);
	}
}

/*
	Name: function_6f50aabc
	Namespace: namespace_97ac1184
	Checksum: 0x424F4353
	Offset: 0xE588
	Size: 0x100
	Parameters: 0
	Flags: Private
	Line Number: 1735
*/
function private function_6f50aabc()
{
	level waittill("hash_end_game");
	if(isdefined(self.var_c6452f46["leveling"]) && self.var_c6452f46["leveling"])
	{
		level thread function_231f215a();
		if(self.var_fa202141["player_leaderboards"] <= 2)
		{
			self function_SetControllerUIModelValue("UEM.send_leaderboard_data", 1);
		}
		wait(1);
		self function_SetControllerUIModelValue("UEM.send_end_game", 1);
		wait(1);
		self function_SetControllerUIModelValue("UEM.send_leaderboard_data", 0);
		self function_SetControllerUIModelValue("UEM.send_end_game", 0);
	}
}

/*
	Name: function_231f215a
	Namespace: namespace_97ac1184
	Checksum: 0x424F4353
	Offset: 0xE690
	Size: 0xA0
	Parameters: 0
	Flags: None
	Line Number: 1763
*/
function function_231f215a()
{
	if(function_isPlayer(self))
	{
		self thread function_b50a98fc();
	}
	else
	{
		var_players = function_GetPlayers();
		for(var_i = 0; var_i < var_players.size; var_i++)
		{
			var_players[var_i] thread function_b50a98fc();
		}
		return;
	}
	ERROR: Exception occured: Stack empty.
}

/*
	Name: function_b50a98fc
	Namespace: namespace_97ac1184
	Checksum: 0x424F4353
	Offset: 0xE738
	Size: 0x148
	Parameters: 0
	Flags: None
	Line Number: 1791
*/
function function_b50a98fc()
{
	if(isdefined(self.var_c6452f46["leveling"]) && self.var_c6452f46["leveling"])
	{
		self thread function_e35ae7ed(level.var_ac46587c, &"spx_save_data");
	}
	if(isdefined(self.var_c6452f46["map"]) && self.var_c6452f46["map"])
	{
		self thread function_e35ae7ed(level.var_c3e446a, &"spx_maps_save_data");
	}
	if(isdefined(self.var_c6452f46["challenges"]) && self.var_c6452f46["challenges"])
	{
		self thread function_e35ae7ed(level.var_79bcc5f3, &"spx_challenges_save_data");
	}
	if(isdefined(self.var_c6452f46["weapon"]) && self.var_c6452f46["weapon"])
	{
		self thread function_e35ae7ed(level.var_e2a6fd15, &"spx_weapon_save_data");
	}
}

/*
	Name: function_e35ae7ed
	Namespace: namespace_97ac1184
	Checksum: 0x424F4353
	Offset: 0xE888
	Size: 0x2B8
	Parameters: 2
	Flags: Private
	Line Number: 1821
*/
function private function_e35ae7ed(var_6820b605, var_66873ffe)
{
	var_c0d6d88 = 0;
	for(var_i = 0; var_i < function_GetPlayers().size; var_i++)
	{
		if(self function_IsSplitscreen() && self.var_name == level.var_players[var_i].var_name + " 1" || (self function_IsSplitscreen() && self.var_name == level.var_players[var_i].var_name + " 2") || (self function_IsSplitscreen() && self.var_name == level.var_players[var_i].var_name + " 3") || (self function_IsSplitscreen() && self.var_name == level.var_players[var_i].var_name + " 4"))
		{
			var_c0d6d88 = 1;
		}
	}
	if(!(isdefined(var_c0d6d88) && var_c0d6d88))
	{
		function_IPrintLnBold(self.var_name + " is NOT Splitscreen; Save; " + var_6820b605 + " ; " + var_66873ffe);
		self function_LUINotifyEvent(var_66873ffe, 2, var_6820b605["savedata"], 1);
		if(self.var_9ee9bcc6 >= 20 && self.var_dc71288)
		{
			self function_LUINotifyEvent(var_66873ffe, 2, var_6820b605["savedatabackup"], 1);
		}
		if(self.var_9ee9bcc6 == 5 && self.var_dc71288)
		{
			self function_LUINotifyEvent(var_66873ffe, 2, var_6820b605["savedatabackupfirst"], 1);
		}
	}
	else
	{
		function_IPrintLnBold(self.var_name + " is Splitscreen; Do not save");
	}
}

/*
	Name: function_6033a0ff
	Namespace: namespace_97ac1184
	Checksum: 0x424F4353
	Offset: 0xEB48
	Size: 0x1F0
	Parameters: 0
	Flags: Private
	Line Number: 1860
*/
function private function_6033a0ff()
{
	self endon("hash_disconnect");
	for(;;)
	{
		level waittill("hash_door_opened", var_door, var_who, var_b049fc57);
		if(var_door.var_script_noteworthy == "electric_door" || var_door.var_script_noteworthy == "electric_buyable_door" || var_door.var_script_noteworthy == "local_electric_door" || var_door.var_script_noteworthy == "kill_counter_door")
		{
		}
		else
		{
			var_who thread function_b3489bf5("^3" + var_who.var_playerName + "^7 opened ^8Door");
			foreach(var_player in function_GetPlayers())
			{
				if(!(isdefined(var_player.var_c6452f46["leveling"]) && var_player.var_c6452f46["leveling"]))
				{
					continue;
				}
				var_player thread function_7e18304e("spx_end_game_save_data", "end_game_lobby_size", 1, 0);
				var_player notify("hash_79ef118b", "doors_purchased", undefined);
				wait(0.05);
			}
		}
	}
}

/*
	Name: function_41a254c
	Namespace: namespace_97ac1184
	Checksum: 0x424F4353
	Offset: 0xED40
	Size: 0x68
	Parameters: 0
	Flags: Private
	Line Number: 1896
*/
function private function_41a254c()
{
	for(;;)
	{
		level waittill("hash_all_boards_repaired", var_player);
		if(!(isdefined(self.var_c6452f46["leveling"]) && self.var_c6452f46["leveling"]))
		{
		}
		else
		{
			var_player notify("hash_79ef118b", "barrier_repaired", undefined);
		}
	}
}

/*
	Name: function_eeb79e2d
	Namespace: namespace_97ac1184
	Checksum: 0x424F4353
	Offset: 0xEDB0
	Size: 0x1E8
	Parameters: 0
	Flags: None
	Line Number: 1921
*/
function function_eeb79e2d()
{
	self endon("hash_disconnect");
	level.var_8f1fd1e4 = 0;
	self.var_a21a5c9b = 0;
	for(;;)
	{
		wait(1);
		if(!level namespace_flag::function_get("roamer_option_enabled") || (!(isdefined(level.var_e5e729a2) && level.var_e5e729a2)))
		{
			self.var_a21a5c9b++;
			self thread function_8c165b4d("Data", "GameTimer", self.var_a21a5c9b);
			if(!(isdefined(self.var_c6452f46["leveling"]) && self.var_c6452f46["leveling"]))
			{
			}
			else
			{
				level.var_8f1fd1e4++;
				if(level.var_8f1fd1e4 >= self.var_pers["highest_total_playtime"])
				{
					self.var_pers["highest_total_playtime"] = level.var_8f1fd1e4;
					self thread function_7e18304e("spx_save_data", "highest_total_playtime", self.var_pers["highest_total_playtime"], 0);
				}
				self thread function_7e18304e("spx_end_game_save_data", "end_game_time_played", 1, 0);
				if(isdefined(level.var_c181264f) && level.var_c181264f)
				{
					self.var_pers["gungame_time_played"]++;
					self thread function_7e18304e("spx_save_data", "gungame_time_played", self.var_pers["gungame_time_played"], 0);
				}
				level notify("hash_8c3d4295", self, "time_played", 1, 0);
			}
		}
	}
}

/*
	Name: function_634aaa28
	Namespace: namespace_97ac1184
	Checksum: 0x424F4353
	Offset: 0xEFA0
	Size: 0x30
	Parameters: 0
	Flags: None
	Line Number: 1966
*/
function function_634aaa28()
{
	self endon("hash_disconnect");
	level.var_66b5c5f0 = 0;
	for(;;)
	{
		wait(1);
		level.var_66b5c5f0++;
	}
}

/*
	Name: function_57821581
	Namespace: namespace_97ac1184
	Checksum: 0x424F4353
	Offset: 0xEFD8
	Size: 0x28
	Parameters: 0
	Flags: Private
	Line Number: 1987
*/
function private function_57821581()
{
	level.var_66b5c5f0 = 0;
	for(;;)
	{
		wait(1);
		level.var_66b5c5f0++;
	}
	return;
}

/*
	Name: function_694ca363
	Namespace: namespace_97ac1184
	Checksum: 0x424F4353
	Offset: 0xF008
	Size: 0xF0
	Parameters: 0
	Flags: None
	Line Number: 2008
*/
function function_694ca363()
{
	wait(0.05);
	level namespace_flag::function_wait_till("initial_blackscreen_passed");
	level.var_da5a2ab8 = 0;
	level.var_last_round_number = 0;
	level.var_8da257a3 = level.var_round_number;
	for(;;)
	{
		level waittill("hash_start_of_round");
		level.var_8da257a3 = level.var_round_number;
		if(level.var_last_round_number > 0 && level.var_8da257a3 >= level.var_last_round_number + 3)
		{
			function_iprintln("^1Round Skip Detected! Last Round: " + level.var_last_round_number + " â Current Round: " + level.var_8da257a3);
			level.var_da5a2ab8 = 1;
		}
		level.var_last_round_number = level.var_8da257a3;
	}
}

/*
	Name: function_d029f398
	Namespace: namespace_97ac1184
	Checksum: 0x424F4353
	Offset: 0xF100
	Size: 0x748
	Parameters: 0
	Flags: None
	Line Number: 2038
*/
function function_d029f398()
{
	self endon("hash_disconnect");
	self.var_a1a35a4c = 0;
	for(;;)
	{
		level waittill("hash_end_of_round");
		if(!(isdefined(self.var_c6452f46["leveling"]) && self.var_c6452f46["leveling"]))
		{
		}
		else if(self.var_9ee9bcc6 >= 2)
		{
			self.var_97c8c206 = 0;
			switch(self.var_fa202141["player_leaderboards"])
			{
				case 1:
				{
					if(self.var_9ee9bcc6 % 10 === 0)
					{
						function_iprintln("Sending data to leaderboards [Each 10 Rounds]");
						self.var_97c8c206 = 1;
						break;
					}
				}
				case 2:
				{
					function_iprintln("Sending data to leaderboards [Each Round]");
					self.var_97c8c206 = 1;
					break;
				}
			}
			if(isdefined(self.var_97c8c206) && self.var_97c8c206)
			{
				self function_SetControllerUIModelValue("UEM.send_leaderboard_data", 1);
				wait(1);
				self function_SetControllerUIModelValue("UEM.send_leaderboard_data", 0);
			}
			self.var_97c8c206 = 0;
			self.var_pers["total_games_played"] = self.var_pers["total_games_played"] + 1;
			self thread function_7e18304e("spx_save_data", "total_games_played", self.var_pers["total_games_played"], 0);
			wait(0.05);
			level notify("hash_8c3d4295", self, "total_games", 1, 0);
			wait(0.05);
			if(isdefined(level.var_c181264f) && level.var_c181264f)
			{
				self.var_pers["gungame_games_played"]++;
				self thread function_7e18304e("spx_save_data", "gungame_games_played", self.var_pers["gungame_games_played"], 0);
			}
		}
		else if(level.var_66b5c5f0 > self.var_pers["end_game_longest_round_timer"])
		{
			self thread function_7e18304e("spx_end_game_save_data", "end_game_longest_round", level.var_round_number, 0);
			self thread function_7e18304e("spx_end_game_save_data", "end_game_longest_round_timer", level.var_66b5c5f0, 1);
			level.var_66b5c5f0 = 0;
		}
		var_70f288cd = self.var_pers["downs"] - self.var_pers["game_downs"];
		if(var_70f288cd > self.var_pers["end_game_total_downs"])
		{
			self thread function_7e18304e("spx_end_game_save_data", "end_game_total_downs", var_70f288cd, 1);
		}
		var_25103558 = self.var_pers["revives"] - self.var_pers["game_revives"];
		if(var_25103558 > self.var_pers["end_game_total_revives"])
		{
			self thread function_7e18304e("spx_end_game_save_data", "end_game_total_revives", var_25103558, 1);
		}
		var_536940b9 = self.var_pers["distance_traveled"] - self.var_pers["game_distance_traveled"];
		if(var_536940b9 > self.var_pers["end_game_distance_traveled"])
		{
			self thread function_7e18304e("spx_end_game_save_data", "end_game_distance_traveled", var_536940b9, 1);
		}
		var_66c590cb = self.var_pers["bgbs_chewed"] - self.var_pers["game_bgbs_chewed"];
		if(var_66c590cb > self.var_pers["end_game_bgbs_chewed"])
		{
			self thread function_7e18304e("spx_end_game_save_data", "end_game_bgbs_chewed", var_66c590cb, 1);
		}
		var_6b0cc322 = self.var_pers["use_magicbox"] - self.var_pers["game_use_magicbox"];
		if(var_6b0cc322 > self.var_pers["end_game_use_magicbox"])
		{
			self thread function_7e18304e("spx_end_game_save_data", "end_game_use_magicbox", var_6b0cc322, 1);
		}
		var_dd24d7fe = self.var_pers["wallbuy_weapons_purchased"] - self.var_pers["game_wallbuy_weapons_purchased"];
		if(var_dd24d7fe > self.var_pers["end_game_wallbuy_weapons_purchased"])
		{
			self thread function_7e18304e("spx_end_game_save_data", "end_game_wallbuy_weapons_purchased", var_dd24d7fe, 1);
		}
		var_b0515ba4 = self.var_pers["buildables_built"] - self.var_pers["game_buildables_built"];
		if(var_b0515ba4 > self.var_pers["end_game_buildables_built"])
		{
			self thread function_7e18304e("spx_end_game_save_data", "end_game_buildables_built", var_b0515ba4, 1);
		}
		var_659516bd = self.var_pers["boards"] - self.var_pers["game_boards"];
		if(var_659516bd > self.var_pers["end_game_boards"])
		{
			self thread function_7e18304e("spx_end_game_save_data", "end_game_boards", var_659516bd, 1);
		}
		if(isdefined(level namespace_flag::function_get("using_mutator_settings")) && level namespace_flag::function_get("using_mutator_settings"))
		{
			self thread function_7e18304e("spx_end_game_save_data", "end_game_mutator_settings", 1, 1);
		}
		self thread function_7e18304e("spx_end_game_save_data", "end_game_total_rounds", 1, 0);
	}
}

/*
	Name: function_31dfdcd7
	Namespace: namespace_97ac1184
	Checksum: 0x424F4353
	Offset: 0xF850
	Size: 0x198
	Parameters: 0
	Flags: None
	Line Number: 2151
*/
function function_31dfdcd7()
{
	self endon("hash_disconnect");
	self.var_8ff787dc = 0;
	self.var_2288e532 = 0;
	self.var_db653ff8 = 0;
	for(;;)
	{
		self waittill("hash_perk_acquired", var_perk);
		if(!self.var_a1a35a4c)
		{
			self.var_a1a35a4c = 1;
		}
		if(!(isdefined(self.var_c6452f46["leveling"]) && self.var_c6452f46["leveling"]))
		{
		}
		else
		{
			self thread function_354d52aa(var_perk);
			wait(0.05);
			if(level.var_fcee636 == "motd")
			{
				self notify("hash_63cf7d21", "map0_motd_perks", 1, 15, 60000, 15);
			}
			else if(level.var_fcee636 == "spxskyblock")
			{
				self notify("hash_63cf7d21", "map0_skyblock_perks", 1, 30, 60000, 15);
			}
			wait(0.05);
			if(self.var_num_perks == 13 && self.var_pers["cc2_perk_perfectionist"] < 5)
			{
				if(!(isdefined(self.var_8ff787dc) && self.var_8ff787dc))
				{
					self.var_8ff787dc = 1;
				}
			}
		}
	}
}

/*
	Name: function_354d52aa
	Namespace: namespace_97ac1184
	Checksum: 0x424F4353
	Offset: 0xF9F0
	Size: 0xDA0
	Parameters: 1
	Flags: None
	Line Number: 2201
*/
function function_354d52aa(var_perk)
{
	self thread function_7e18304e("spx_end_game_save_data", "end_game_perks_drank", 1, 0);
	self thread function_7e18304e("spx_save_data", "perks_drank", self.var_pers["perks_drank"], 0);
	switch(var_perk)
	{
		case "specialty_armorvest":
		{
			self.var_pers["perk_juggernog"] = self.var_pers["perk_juggernog"] + 1;
			self thread function_7e18304e("spx_end_game_save_data", "end_game_perk_juggernog", 1, 0);
			self thread function_7e18304e("spx_save_data", "perk_juggernog", self.var_pers["perk_juggernog"], 0);
			self function_LUINotifyEvent(&"spx_perk_notification", 2, &"ZM_MINECRAFT_PERK_JUGGERNOG_NOTIFY", 0);
			self thread function_b3489bf5("^3" + self.var_playerName + "^7 drank ^9Juggernog");
			break;
		}
		case "specialty_quickrevive":
		{
			self.var_pers["perk_revive"] = self.var_pers["perk_revive"] + 1;
			self thread function_7e18304e("spx_end_game_save_data", "end_game_perk_revive", 1, 0);
			self thread function_7e18304e("spx_save_data", "perk_revive", self.var_pers["perk_revive"], 0);
			self function_LUINotifyEvent(&"spx_perk_notification", 2, &"ZM_MINECRAFT_PERK_QUICK_REVIVE_NOTIFY", 0);
			self thread function_b3489bf5("^3" + self.var_playerName + "^7 drank ^9Quick Revive");
			break;
		}
		case "specialty_fastreload":
		{
			self.var_pers["perk_speed"] = self.var_pers["perk_speed"] + 1;
			self thread function_7e18304e("spx_end_game_save_data", "end_game_perk_speed", 1, 0);
			self thread function_7e18304e("spx_save_data", "perk_speed", self.var_pers["perk_speed"], 0);
			self function_LUINotifyEvent(&"spx_perk_notification", 2, &"ZM_MINECRAFT_PERK_SPEED_COLA_NOTIFY", 0);
			self thread function_b3489bf5("^3" + self.var_playerName + "^7 drank ^9Speed Cola");
			break;
		}
		case "specialty_doubletap2":
		{
			self.var_pers["perk_doubletap"] = self.var_pers["perk_doubletap"] + 1;
			self thread function_7e18304e("spx_end_game_save_data", "end_game_perk_doubletap", 1, 0);
			self thread function_7e18304e("spx_save_data", "perk_doubletap", self.var_pers["perk_doubletap"], 0);
			self function_LUINotifyEvent(&"spx_perk_notification", 2, &"ZM_MINECRAFT_PERK_DOUBLE_TAP_NOTIFY", 0);
			self thread function_b3489bf5("^3" + self.var_playerName + "^7 drank ^9Double-Tap");
			break;
		}
		case "specialty_staminup":
		{
			self.var_pers["perk_stamin"] = self.var_pers["perk_stamin"] + 1;
			self thread function_7e18304e("spx_end_game_save_data", "end_game_perk_stamin", 1, 0);
			self thread function_7e18304e("spx_save_data", "perk_stamin", self.var_pers["perk_stamin"], 0);
			self function_LUINotifyEvent(&"spx_perk_notification", 2, &"ZM_MINECRAFT_PERK_STAMIN_UP_NOTIFY", 0);
			self thread function_b3489bf5("^3" + self.var_playerName + "^7 drank ^9Stamin-Up");
			break;
		}
		case "specialty_additionalprimaryweapon":
		{
			self.var_pers["perk_mule"] = self.var_pers["perk_mule"] + 1;
			self thread function_7e18304e("spx_end_game_save_data", "end_game_perk_mule", 1, 0);
			self thread function_7e18304e("spx_save_data", "perk_mule", self.var_pers["perk_mule"], 0);
			self function_LUINotifyEvent(&"spx_perk_notification", 2, &"ZM_MINECRAFT_PERK_MULE_KICK_NOTIFY", 0);
			self thread function_b3489bf5("^3" + self.var_playerName + "^7 drank ^9Mule-Kick");
			break;
		}
		case "specialty_deadshot":
		{
			self.var_pers["perk_deadshot"] = self.var_pers["perk_deadshot"] + 1;
			self thread function_7e18304e("spx_end_game_save_data", "end_game_perk_deadshot", 1, 0);
			self thread function_7e18304e("spx_save_data", "perk_deadshot", self.var_pers["perk_deadshot"], 0);
			self function_LUINotifyEvent(&"spx_perk_notification", 2, &"ZM_MINECRAFT_PERK_DEADSHOT_NOTIFY", 0);
			self thread function_b3489bf5("^3" + self.var_playerName + "^7 drank ^9Deadshot");
			break;
		}
		case "specialty_widowswine":
		{
			self.var_pers["perk_widows"] = self.var_pers["perk_widows"] + 1;
			self thread function_7e18304e("spx_end_game_save_data", "end_game_perk_widows", 1, 0);
			self thread function_7e18304e("spx_save_data", "perk_widows", self.var_pers["perk_widows"], 0);
			self function_LUINotifyEvent(&"spx_perk_notification", 2, &"ZM_MINECRAFT_PERK_WIDOWS_WINE_NOTIFY", 0);
			self thread function_b3489bf5("^3" + self.var_playerName + "^7 drank ^9Widows");
			break;
		}
		case "specialty_electriccherry":
		{
			self.var_pers["perk_cherry"] = self.var_pers["perk_cherry"] + 1;
			self thread function_7e18304e("spx_end_game_save_data", "end_game_perk_cherry", 1, 0);
			self thread function_7e18304e("spx_save_data", "perk_cherry", self.var_pers["perk_cherry"], 0);
			self function_LUINotifyEvent(&"spx_perk_notification", 2, &"ZM_MINECRAFT_PERK_CHERRY_NOTIFY", 0);
			self thread function_b3489bf5("^3" + self.var_playerName + "^7 drank ^9Electric Cherry");
			break;
		}
		case "specialty_phdflopper":
		{
			self.var_pers["perk_phd"] = self.var_pers["perk_phd"] + 1;
			self thread function_7e18304e("spx_end_game_save_data", "end_game_perk_phd", 1, 0);
			self thread function_7e18304e("spx_save_data", "perk_phd", self.var_pers["perk_phd"], 0);
			self function_LUINotifyEvent(&"spx_perk_notification", 2, &"ZM_MINECRAFT_PERK_PHD_FLOPPER_NOTIFY", 0);
			self thread function_b3489bf5("^3" + self.var_playerName + "^7 drank ^9PHD-Flopper");
			break;
		}
		case "specialty_tracker":
		{
			self.var_pers["perk_perception"] = self.var_pers["perk_perception"] + 1;
			self thread function_7e18304e("spx_end_game_save_data", "end_game_perk_perception", 1, 0);
			self thread function_7e18304e("spx_save_data", "perk_perception", self.var_pers["perk_perception"], 0);
			self function_LUINotifyEvent(&"spx_perk_notification", 2, &"ZM_MINECRAFT_PERK_DEATH_PERCEPTION_NOTIFY", 0);
			self thread function_b3489bf5("^3" + self.var_playerName + "^7 drank ^9Death Perception");
			break;
		}
		case "specialty_immunetriggerbetty":
		{
			self.var_pers["perk_realsteal"] = self.var_pers["perk_realsteal"] + 1;
			self thread function_7e18304e("spx_end_game_save_data", "end_game_perk_realsteal", 1, 0);
			self thread function_7e18304e("spx_save_data", "perk_realsteal", self.var_pers["perk_realsteal"], 0);
			self function_LUINotifyEvent(&"spx_perk_notification", 2, &"ZM_MINECRAFT_PERK_REAL_STEAL_NOTIFY", 0);
			self thread function_b3489bf5("^3" + self.var_playerName + "^7 drank ^9Real Steal Brew");
			break;
		}
		case "specialty_extraammo":
		{
			self.var_pers["perk_bandolier"] = self.var_pers["perk_bandolier"] + 1;
			self thread function_7e18304e("spx_end_game_save_data", "end_game_perk_bandolier", 1, 0);
			self thread function_7e18304e("spx_save_data", "perk_bandolier", self.var_pers["perk_bandolier"], 0);
			self function_LUINotifyEvent(&"spx_perk_notification", 2, &"ZM_MINECRAFT_PERK_BANDOLIER_BANDIT_NOTIFY", 0);
			self thread function_b3489bf5("^3" + self.var_playerName + "^7 drank ^9Bandolier Bandit");
			break;
		}
		case "specialty_immunetriggershock":
		{
			self.var_pers["perk_frost_brew"] = self.var_pers["perk_frost_brew"] + 1;
			self thread function_7e18304e("spx_end_game_save_data", "end_game_perk_frost_brew", 1, 0);
			self thread function_7e18304e("spx_save_data", "perk_frost_brew", self.var_pers["perk_frost_brew"], 0);
			self function_LUINotifyEvent(&"spx_perk_notification", 2, &"ZM_MINECRAFT_PERK_FROST_BREW_NOTIFY", 0);
			self thread function_b3489bf5("^3" + self.var_playerName + "^7 drank ^9Frost Brew");
			break;
		}
	}
	return;
}

/*
	Name: function_8de2bd80
	Namespace: namespace_97ac1184
	Checksum: 0x424F4353
	Offset: 0x10798
	Size: 0xF8
	Parameters: 0
	Flags: None
	Line Number: 2347
*/
function function_8de2bd80()
{
	for(;;)
	{
		level waittill("hash_earned_points", var_player, var_points);
		if(!(isdefined(var_player.var_c6452f46["leveling"]) && var_player.var_c6452f46["leveling"]))
		{
		}
		else
		{
			var_player.var_pers["total_points"] = var_player.var_pers["total_points"] + var_points;
			var_player thread function_7e18304e("spx_end_game_save_data", "end_game_total_score", var_points, 0);
			var_player thread function_7e18304e("spx_save_data", "total_points", var_player.var_pers["total_points"], 0);
		}
	}
}

/*
	Name: function_154491fc
	Namespace: namespace_97ac1184
	Checksum: 0x424F4353
	Offset: 0x10898
	Size: 0x100
	Parameters: 0
	Flags: None
	Line Number: 2374
*/
function function_154491fc()
{
	for(;;)
	{
		level waittill("hash_spent_points", var_player, var_points);
		if(!(isdefined(var_player.var_c6452f46["leveling"]) && var_player.var_c6452f46["leveling"]))
		{
		}
		else
		{
			wait(0.05);
			var_player.var_pers["total_points"] = var_player.var_pers["total_points"] + var_points;
			var_player thread function_7e18304e("spx_end_game_save_data", "end_game_total_score", var_points, 0);
			var_player thread function_7e18304e("spx_save_data", "total_points", var_player.var_pers["total_points"], 0);
		}
	}
}

/*
	Name: function_9bae2e69
	Namespace: namespace_97ac1184
	Checksum: 0x424F4353
	Offset: 0x109A0
	Size: 0x100
	Parameters: 0
	Flags: None
	Line Number: 2402
*/
function function_9bae2e69()
{
	var_index = 0;
	var_table = "gamedata/leveling/game_settings.csv";
	for(var_row = function_TableLookupRow(var_table, var_index); isdefined(var_row); var_row = function_TableLookupRow(var_table, var_index))
	{
		var_name = function_checkStringValid(var_row[0]);
		var_description = function_checkStringValid(var_row[1]);
		if(isdefined(var_name) && var_name != "")
		{
			level.var_713a7800[var_index] = var_name;
		}
		var_index++;
	}
}

/*
	Name: function_1d39abf6
	Namespace: namespace_97ac1184
	Checksum: 0x424F4353
	Offset: 0x10AA8
	Size: 0xA0
	Parameters: 3
	Flags: None
	Line Number: 2428
*/
function function_1d39abf6(var_bd058c01, var_value, var_overwrite)
{
	if(!isdefined(var_overwrite))
	{
		var_overwrite = 0;
	}
	if(!isdefined(var_value))
	{
		var_value = 0;
	}
	if(isdefined(var_overwrite) && var_overwrite)
	{
		self.var_pers[var_bd058c01] = var_value;
	}
	else
	{
		self.var_pers[var_bd058c01] = self.var_pers[var_bd058c01] + var_value;
	}
	wait(0.05);
	wait(0.05);
}

/*
	Name: function_7eb8b937
	Namespace: namespace_97ac1184
	Checksum: 0x424F4353
	Offset: 0x10B50
	Size: 0x128
	Parameters: 0
	Flags: None
	Line Number: 2460
*/
function function_7eb8b937()
{
	var_index = 1;
	var_table = "gamedata/leveling/save_game_stats_index.csv";
	for(var_row = function_TableLookupRow(var_table, var_index); isdefined(var_row); var_row = function_TableLookupRow(var_table, var_index))
	{
		var_bd058c01 = function_checkStringValid(var_row[0]);
		var_title = function_checkStringValid(var_row[1]);
		if(isdefined(var_bd058c01) && var_bd058c01 != "")
		{
			level.var_5e620cb1[var_bd058c01] = var_index;
			level.var_7fd3975f[var_index] = var_bd058c01;
			level.var_204377c[var_bd058c01] = var_title;
		}
		var_index++;
	}
}

/*
	Name: function_b2ab0b0c
	Namespace: namespace_97ac1184
	Checksum: 0x424F4353
	Offset: 0x10C80
	Size: 0x18
	Parameters: 1
	Flags: None
	Line Number: 2488
*/
function function_b2ab0b0c(var_response)
{
	for(;;)
	{
		wait(2);
	}
}

/*
	Name: function_87c62457
	Namespace: namespace_97ac1184
	Checksum: 0x424F4353
	Offset: 0x10CA0
	Size: 0x58
	Parameters: 0
	Flags: Private
	Line Number: 2506
*/
function private function_87c62457()
{
	self function_SetControllerUIModelValue("UEM.get_leveling_stats", 0);
	self.var_c6452f46["leveling"] = 1;
	self notify("hash_d2bbeae8");
	self notify("hash_7a45ca9b");
	return;
	ERROR: Exception occured: Stack empty.
}

/*
	Name: function_f11f718a
	Namespace: namespace_97ac1184
	Checksum: 0x424F4353
	Offset: 0x10D00
	Size: 0x148
	Parameters: 0
	Flags: None
	Line Number: 2526
*/
function function_f11f718a()
{
	self endon("hash_disconnect");
	self endon("hash_7a45ca9b");
	self function_SetControllerUIModelValue("UEM.get_leveling_stats", 1);
	self waittill("hash_e1081f84");
	wait(0.05);
	self thread function_71db7b7();
	wait(0.05);
	self function_SetControllerUIModelValue("UEM.get_player_settings", 1);
	self namespace_util::function_waittill_any_return("completed_playersettings_stats_loading", "force_completed_rank_stats_loading");
	wait(0.05);
	self thread function_83977a93();
	wait(0.05);
	self function_SetControllerUIModelValue("UEM.get_vip", 1);
	self namespace_util::function_waittill_any_return("completed_vip_loading", "force_completed_rank_stats_loading");
	self.var_c6452f46["leveling"] = 1;
	self notify("hash_d2bbeae8");
}

/*
	Name: function_3a391177
	Namespace: namespace_97ac1184
	Checksum: 0x424F4353
	Offset: 0x10E50
	Size: 0x880
	Parameters: 0
	Flags: None
	Line Number: 2556
*/
function function_3a391177()
{
	self endon("hash_disconnect");
	self endon("hash_7a45ca9b");
	if(!isdefined(self.var_9912cb8d))
	{
		self.var_9912cb8d = 1;
		var_7069805c = 0;
		var_ed5b6ee = [];
		while(1)
		{
			self waittill("hash_menuresponse", var_menu, var_response);
			if(var_menu == "levelingdatamenu")
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
				if(var_b9b0ebb3.size == 2)
				{
					var_dataName = function_ToLower(var_b9b0ebb3[0]);
					var_value = var_b9b0ebb3[1];
					var_abe6703d = function_ToLower(level.var_d824eaa9[var_dataName]);
					if(var_dataName == "tryagain")
					{
						self function_LUINotifyEvent(&"spx_get_save_data", 1, function_Int(level.var_ac46587c[var_value]));
						function_IPrintLnBold("Did not get a proper response; Trying again");
						continue;
					}
					switch(var_abe6703d)
					{
						case "player":
						{
							if(var_dataName == "xuid" && var_value != self function_getxuid(1))
							{
								self function_SetControllerUIModelValue("UEM.get_leveling_stats", 0);
								self notify("hash_e1081f84");
								function_iprintln("[Leveling System] New Player Detected!");
								break;
							}
							else if(var_dataName == "reset_keyword" && function_Int(var_value) != 8351)
							{
								function_IPrintLnBold(self.var_playerName + ": You might be reset! If this is your first time playing, you can ignore this. Otherwise, please PM Sphynx!");
							}
							else
							{
								self.var_3d9c073[var_dataName] = var_value;
								break;
							}
						}
						case "leveling":
						{
							self.var_b74a3cd1[var_dataName] = function_Int(var_value);
							if(var_dataName == "brutal_rank" && self.var_b74a3cd1["brutal_rank"] == 0)
							{
								self.var_b74a3cd1["brutal_rank"] = 1;
							}
							if(var_dataName == "level")
							{
								self.var_pers["end_game_level"] = function_Int(var_value);
							}
							else if(var_dataName == "prestige")
							{
								self.var_pers["end_game_prestige"] = function_Int(var_value);
								break;
							}
						}
						case "pers":
						{
							self.var_pers[var_dataName] = function_Int(var_value);
							if(var_dataName == "downs")
							{
								self.var_pers["game_downs"] = function_Int(var_value);
							}
							else if(var_dataName == "revives")
							{
								self.var_pers["game_revives"] = function_Int(var_value);
							}
							else if(var_dataName == "distance_traveled")
							{
								self.var_pers["game_distance_traveled"] = function_Int(var_value);
							}
							else if(var_dataName == "bgbs_chewed")
							{
								self.var_pers["game_bgbs_chewed"] = function_Int(var_value);
							}
							else if(var_dataName == "use_magicbox")
							{
								self.var_pers["game_use_magicbox"] = function_Int(var_value);
							}
							else if(var_dataName == "wallbuy_weapons_purchased")
							{
								self.var_pers["game_wallbuy_weapons_purchased"] = function_Int(var_value);
							}
							else if(var_dataName == "buildables_built")
							{
								self.var_pers["game_buildables_built"] = function_Int(var_value);
							}
							else if(var_dataName == "boards")
							{
								self.var_pers["game_boards"] = function_Int(var_value);
							}
							else if(var_dataName == "total_shots")
							{
								self.var_pers["end_game_total_shots"] = function_Int(var_value);
							}
							else if(var_dataName == "hits")
							{
								self.var_pers["game_total_hits"] = function_Int(var_value);
							}
							else if(var_dataName == "misses")
							{
								self.var_pers["game_total_misses"] = function_Int(var_value);
								break;
							}
						}
						case "shop":
						{
							self.var_15fde1f7[var_dataName] = function_Int(var_value);
							break;
						}
						case "reward":
						{
							self.var_6915e7ce[var_dataName] = function_spawnstruct();
							self.var_6915e7ce[var_dataName].var_bd058c01 = var_dataName;
							self.var_6915e7ce[var_dataName].var_enabled = var_value;
							break;
						}
					}
				}
			}
		}
		self notify("hash_e1081f84");
	}
}

/*
	Name: function_78aa8ae6
	Namespace: namespace_97ac1184
	Checksum: 0x424F4353
	Offset: 0x116D8
	Size: 0x10
	Parameters: 0
	Flags: None
	Line Number: 2718
*/
function function_78aa8ae6()
{
	level waittill("hash_25a57ce5");
}

/*
	Name: function_83977a93
	Namespace: namespace_97ac1184
	Checksum: 0x424F4353
	Offset: 0x116F0
	Size: 0x418
	Parameters: 0
	Flags: None
	Line Number: 2733
*/
function function_83977a93()
{
	var_7069805c = 0;
	var_ed5b6ee = [];
	while(1)
	{
		self waittill("hash_menuresponse", var_menu, var_response);
		if(var_menu == "vipmenu")
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
			if(var_b9b0ebb3.size == 4)
			{
				var_81820b10 = function_ToLower(var_b9b0ebb3[0]);
				var_rank = function_ToLower(var_b9b0ebb3[1]);
				var_57fb29cc = function_ToLower(var_b9b0ebb3[2]);
				var_name = function_ToLower(var_b9b0ebb3[3]);
				var_title1 = function_ToLower(var_b9b0ebb3[4]);
				var_title2 = function_ToLower(var_b9b0ebb3[5]);
				var_ffbe2094 = function_ToLower(var_b9b0ebb3[6]);
				if(!isdefined(level.var_18ffd3f2))
				{
					level.var_18ffd3f2 = [];
				}
				if(!isdefined(level.var_18ffd3f2[var_81820b10]))
				{
					level.var_18ffd3f2[var_81820b10] = function_spawnstruct();
				}
				level.var_18ffd3f2[var_81820b10].var_81820b10 = var_81820b10;
				level.var_18ffd3f2[var_81820b10].var_rank = var_rank;
				level.var_18ffd3f2[var_81820b10].var_57fb29cc = var_57fb29cc;
				level.var_18ffd3f2[var_81820b10].var_name = var_name;
				level.var_18ffd3f2[var_81820b10].var_title1 = var_title1;
				level.var_18ffd3f2[var_81820b10].var_title2 = var_title2;
				level.var_18ffd3f2[var_81820b10].var_ffbe2094 = var_ffbe2094;
			}
		}
	}
	self notify("hash_9fdb8b1d");
}

/*
	Name: function_71db7b7
	Namespace: namespace_97ac1184
	Checksum: 0x424F4353
	Offset: 0x11B10
	Size: 0x2B8
	Parameters: 0
	Flags: None
	Line Number: 2802
*/
function function_71db7b7()
{
	var_7069805c = 0;
	var_ed5b6ee = [];
	while(1)
	{
		self waittill("hash_menuresponse", var_menu, var_response);
		if(var_menu == "playersettingsmenu")
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
			if(var_b9b0ebb3.size == 2)
			{
				var_dataName = function_ToLower(var_b9b0ebb3[0]);
				var_value = var_b9b0ebb3[1];
				if(!isdefined(self.var_fa202141))
				{
					self.var_fa202141 = [];
				}
				if(isdefined(var_value))
				{
					self.var_fa202141[var_dataName] = function_Int(var_value);
					continue;
				}
				self.var_fa202141[var_dataName] = function_Int(0);
			}
		}
	}
	self thread namespace_bb3b4960::function_68e41a2d(1);
	self notify("hash_b4ed3e");
	return;
	ERROR: Exception occured: Stack empty.
}

/*
	Name: function_60dc220c
	Namespace: namespace_97ac1184
	Checksum: 0x424F4353
	Offset: 0x11DD0
	Size: 0x248
	Parameters: 0
	Flags: None
	Line Number: 2864
*/
function function_60dc220c()
{
	var_e99eb902 = 0;
	while(1)
	{
		self waittill("hash_menuresponse", var_menu, var_response);
		if(var_menu == "gamesettingsmenu")
		{
			if(var_response == "stop_sending")
			{
				self thread namespace_bb3b4960::function_68e41a2d(var_e99eb902);
				self notify("hash_a672345b");
				break;
			}
			var_cde9f622 = function_StrTok(var_response, ",");
			if(!isdefined(var_cde9f622))
			{
				function_IPrintLnBold("tokenized not defined!");
			}
			foreach(var_token in var_cde9f622)
			{
				var_b9b0ebb3 = function_StrTok(var_token, "=");
				if(var_b9b0ebb3.size == 2)
				{
					var_dataName = function_ToLower(var_b9b0ebb3[0]);
					var_value = var_b9b0ebb3[1];
					if(!isdefined(self.var_95e7fdd8))
					{
						self.var_95e7fdd8 = [];
					}
					if(isdefined(var_value))
					{
						var_e99eb902 = 1;
						self.var_95e7fdd8[var_dataName] = function_Int(var_value);
						continue;
					}
					self.var_95e7fdd8[var_dataName] = function_Int(0);
				}
			}
		}
	}
}

/*
	Name: function_8dcb2166
	Namespace: namespace_97ac1184
	Checksum: 0x424F4353
	Offset: 0x12020
	Size: 0x6A8
	Parameters: 0
	Flags: None
	Line Number: 2917
*/
function function_8dcb2166()
{
	self endon("hash_disconnect");
	if(self function_getxuid(1) == "76561198160068017" || self function_getxuid(1) == "76561198228573464" || self function_getxuid(1) == "76561198075603410")
	{
		self thread function_772875d4();
	}
	self.var_d9a9d5d8 = 0;
	self.var_f9d1811b = [];
	self.var_f9d1811b["headshots"] = function_Int(0);
	self.var_c6452f46 = [];
	self.var_c6452f46["leveling"] = 0;
	self.var_c6452f46["weapon"] = 0;
	self.var_c6452f46["map"] = 0;
	self.var_c6452f46["challenges"] = 0;
	if(!isdefined(self.var_9ee9bcc6))
	{
		self.var_9ee9bcc6 = function_Int(0);
	}
	if(!isdefined(self.var_7da5117b))
	{
		self.var_7da5117b = function_Int(0);
	}
	if(!isdefined(self.var_ebc62b1))
	{
		self.var_ebc62b1 = function_Int(0);
	}
	if(!isdefined(self.var_f4d01b67["xp_hud"]))
	{
		self.var_f4d01b67["xp_hud"] = function_Int(0);
	}
	if(!isdefined(self.var_f4d01b67["disabled_leveling_system"]))
	{
		self.var_f4d01b67["disabled_leveling_system"] = function_Int(0);
	}
	if(!isdefined(self.var_b9961962))
	{
		self.var_b9961962 = 1;
	}
	if(!isdefined(self.var_8217da2b))
	{
		self.var_8217da2b = 0;
	}
	wait(0.05);
	level namespace_flag::function_wait_till("initial_blackscreen_passed");
	while(!function_AreTexturesLoaded())
	{
		wait(0.05);
	}
	wait(1);
	while(isdefined(self.var_is_hotjoining) && self.var_is_hotjoining)
	{
		self.var_ef3558a4 = 1;
		wait(1);
	}
	while(self.var_sessionstate != "playing")
	{
		wait(1);
	}
	wait(1);
	self function_enableUsability();
	self thread function_afb49977();
	self thread function_d81f9d2b();
	self thread function_270d24e9();
	wait(0.05);
	self thread function_3a391177();
	wait(0.05);
	self thread function_f11f718a();
	self namespace_util::function_waittill_any_return("completed_rank_stats_loading", "force_completed_rank_stats_loading");
	self thread function_ca15044e();
	wait(0.05);
	self thread function_35da0d5c();
	wait(0.05);
	self thread function_b3489bf5("^3" + self.var_playerName + "^7 loaded their rank");
	if(isdefined(self.var_fa202141["player_playerdifficulty"]) && self.var_fa202141["player_playerdifficulty"] > self.var_b74a3cd1["brutal_rank"])
	{
		self.var_fa202141["player_playerdifficulty"] = self.var_b74a3cd1["brutal_rank"];
	}
	if(isdefined(self.var_fa202141["player_playerdifficulty"]) && self.var_fa202141["player_playerdifficulty"] > 0)
	{
		self function_LUINotifyEvent(&"spx_milestone_notification", 1, &"ZM_MINECRAFT_STARTUP_BRUTAL_MODE");
	}
	if(isdefined(self.var_fa202141["player_favorite_weapon"]) && self.var_fa202141["player_favorite_weapon"] > 0)
	{
		self.var_d27d944e = self.var_fa202141["player_favorite_weapon"];
	}
	self thread function_7e18304e("spx_end_game_save_data", "end_game_lobby_size_started", function_GetPlayers().size, 1);
	self thread function_7e18304e("spx_end_game_save_data", "end_game_map_name", 2, 1);
	if(self.var_b74a3cd1["level"] == 1 && self.var_b74a3cd1["prestige"] < 1)
	{
		self function_LUINotifyEvent(&"spx_milestone_notification", 1, &"ZM_MINECRAFT_WARNING_RANK_ONE");
	}
	self thread function_48c20fe();
	self thread function_f63c5f17();
	wait(3);
	self thread function_1da3a55e();
	self thread function_4ec7be94();
	self thread function_2319c53f();
	self thread function_3fca15b0();
	self thread function_cfcbc6c2();
}

/*
	Name: function_cfcbc6c2
	Namespace: namespace_97ac1184
	Checksum: 0x424F4353
	Offset: 0x126D0
	Size: 0x598
	Parameters: 0
	Flags: None
	Line Number: 3029
*/
function function_cfcbc6c2()
{
	self endon("hash_disconnect");
	for(;;)
	{
		wait(2);
		for(var_i = 0; var_i < level.var_players.size; var_i++)
		{
			if(isdefined(level.var_players[var_i]) && namespace_zm_utility::function_is_player_valid(level.var_players[var_i]))
			{
				self thread function_8c165b4d("Data", "RankUI." + var_i + ".Level", level.var_players[var_i].var_b74a3cd1["level"]);
				self thread function_8c165b4d("Data", "RankUI." + var_i + ".Prestige", level.var_players[var_i].var_b74a3cd1["prestige"]);
				self thread function_8c165b4d("Data", "RankUI." + var_i + ".PrestigeLegend", level.var_players[var_i].var_b74a3cd1["prestige_legend"]);
				self thread function_8c165b4d("Data", "RankUI." + var_i + ".PrestigeAbsolute", level.var_players[var_i].var_b74a3cd1["prestige_absolute"]);
				self thread function_8c165b4d("Data", "RankUI." + var_i + ".PrestigeUltimate", level.var_players[var_i].var_b74a3cd1["prestige_ultimate"]);
				if(isdefined(level.var_18ffd3f2[level.var_players[var_i] function_getxuid(1)]))
				{
					self thread function_8c165b4d("Data", "RankUI." + var_i + ".VIP", level.var_18ffd3f2[level.var_players[var_i] function_getxuid(1)].var_rank);
					switch(level.var_players[var_i].var_fa202141["player_title"])
					{
						case 1:
						{
							var_title = "the Legend";
							break;
						}
						case 2:
						{
							var_title = "the Bronze";
							break;
						}
						case 3:
						{
							var_title = "the Silver";
							break;
						}
						case 4:
						{
							var_title = "the Gold";
							break;
						}
						case 5:
						{
							var_title = "the Master";
							break;
						}
						case 6:
						{
							var_title = "the Paragon";
							break;
						}
						case 7:
						{
							var_title = "the Ultimate";
							break;
						}
						case 8:
						{
							if(isdefined(level.var_18ffd3f2[level.var_players[var_i] function_getxuid(1)].var_title1))
							{
								var_title = level.var_18ffd3f2[level.var_players[var_i] function_getxuid(1)].var_title1;
								break;
							}
						}
						case 9:
						{
							if(isdefined(level.var_18ffd3f2[level.var_players[var_i] function_getxuid(1)].var_title2))
							{
								var_title = level.var_18ffd3f2[level.var_players[var_i] function_getxuid(1)].var_title2;
								break;
							}
						}
						case 10:
						{
							if(isdefined(level.var_18ffd3f2[level.var_players[var_i] function_getxuid(1)].var_ffbe2094))
							{
								var_title = level.var_18ffd3f2[level.var_players[var_i] function_getxuid(1)].var_ffbe2094;
								break;
							}
						}
						case 11:
						{
							var_title = "the Absolute";
							break;
						}
						case 12:
						{
							var_title = "the Ultimate";
							break;
						}
					}
					self thread function_8c165b4d("Data", "RankUI." + var_i + ".Title", var_title);
				}
			}
			wait(0.05);
		}
	}
}

/*
	Name: function_270d24e9
	Namespace: namespace_97ac1184
	Checksum: 0x424F4353
	Offset: 0x12C70
	Size: 0x198
	Parameters: 0
	Flags: None
	Line Number: 3137
*/
function function_270d24e9()
{
	wait(0.05);
	level namespace_flag::function_wait_till("initial_blackscreen_passed");
	wait(1);
	if(level namespace_flag::function_get("loot_mode_active"))
	{
		self function_LUINotifyEvent(&"spx_milestone_notification", 1, &"ZM_MINECRAFT_LOOT_MODE");
	}
	else if(isdefined(level.var_c181264f) && level.var_c181264f)
	{
		self function_LUINotifyEvent(&"spx_milestone_notification", 1, &"ZM_MINECRAFT_GUN_GAME_MODE");
	}
	else
	{
		self function_LUINotifyEvent(&"spx_milestone_notification", 1, &"ZM_MINECRAFT_STARTUP_UEM");
	}
	if(0)
	{
		if(!isdefined(function_GetDvarInt("mutator_seasonalcontent")) || function_GetDvarInt("mutator_seasonalcontent") < 1)
		{
			self function_LUINotifyEvent(&"spx_milestone_notification", 1, &"ZM_MINECRAFT_STARTUP_CHRISTMAS");
		}
	}
	wait(0.05);
	if(isdefined(0) && 0)
	{
		self function_LUINotifyEvent(&"spx_milestone_notification", 1, &"ZM_MINECRAFT_NOTIFICATION_DOUBLE_XP");
	}
}

/*
	Name: function_35da0d5c
	Namespace: namespace_97ac1184
	Checksum: 0x424F4353
	Offset: 0x12E10
	Size: 0x1A8
	Parameters: 0
	Flags: None
	Line Number: 3178
*/
function function_35da0d5c()
{
	while(isdefined(self.var_afterlife) && self.var_afterlife)
	{
		wait(0.5);
	}
	if(self.var_15fde1f7["shop_500_points"] == 1)
	{
		self namespace_zm_score::function_add_to_player_score(500);
	}
	if(self.var_15fde1f7["shop_m93raffica_weapon"] == 1)
	{
		var_primary_weapons = self function_GetWeaponsList(1);
		foreach(var_weapon in var_primary_weapons)
		{
			if(var_weapon == level.var_start_weapon)
			{
				var_start_weapon = var_weapon;
			}
		}
		if(isdefined(var_start_weapon))
		{
			if(self function_GetCurrentWeapon() != var_start_weapon)
			{
				self function_SwitchToWeapon(var_start_weapon);
			}
			self function_TakeWeapon(var_start_weapon);
			self function_GiveWeapon(function_GetWeapon("pistol_burst"));
		}
	}
}

/*
	Name: function_f63c5f17
	Namespace: namespace_97ac1184
	Checksum: 0x424F4353
	Offset: 0x12FC0
	Size: 0x1F0
	Parameters: 0
	Flags: None
	Line Number: 3220
*/
function function_f63c5f17()
{
	self namespace_flag::function_init("completed_maps_stats_loading");
	wait(0.05);
	self thread function_8923385d();
	wait(0.05);
	self function_SetControllerUIModelValue("UEM.get_map_stats", 1);
	self waittill("hash_ef35fa9e");
	self thread function_b3489bf5("^3" + self.var_playerName + "^7 loaded Map Stats");
	self.var_c6452f46["map"] = 1;
	self notify("hash_41157217");
	wait(0.05);
	self namespace_flag::function_set("completed_maps_stats_loading");
	wait(0.05);
	self namespace_flag::function_init("completed_challenges_stats_loading");
	wait(0.05);
	self thread function_20b52f3a();
	wait(0.05);
	self function_SetControllerUIModelValue("UEM.get_challenges_stats", 1);
	wait(0.05);
	wait(0.05);
	self waittill("hash_18f1b430");
	wait(0.05);
	self thread function_b3489bf5("^3" + self.var_playerName + "^7 loaded Challenges Stats");
	self.var_c6452f46["challenges"] = 1;
	self notify("hash_62d89a98");
	self namespace_flag::function_set("completed_challenges_stats_loading");
}

/*
	Name: function_8ef6b19f
	Namespace: namespace_97ac1184
	Checksum: 0x424F4353
	Offset: 0x131B8
	Size: 0x80
	Parameters: 0
	Flags: None
	Line Number: 3259
*/
function function_8ef6b19f()
{
	wait(15);
	if(!(isdefined(self.var_c6452f46["challenges"]) && self.var_c6452f46["challenges"]))
	{
		self notify("hash_18f1b430");
		self function_SetControllerUIModelValue("UEM.get_challenges_stats", 0);
		function_iprintln("Force challenges initialized! Please notify Sphynx if this happens again!");
		return;
	}
}

/*
	Name: function_6dfe54bc
	Namespace: namespace_97ac1184
	Checksum: 0x424F4353
	Offset: 0x13240
	Size: 0x78
	Parameters: 0
	Flags: None
	Line Number: 3281
*/
function function_6dfe54bc()
{
	self endon("hash_disconnect");
	self endon("hash_d95e591d");
	self namespace_flag::function_init("completed_maps_stats_loading");
	self.var_c6452f46["map"] = 1;
	self notify("hash_41157217");
	self namespace_flag::function_set("completed_maps_stats_loading");
}

/*
	Name: function_de3783c
	Namespace: namespace_97ac1184
	Checksum: 0x424F4353
	Offset: 0x132C0
	Size: 0xA8
	Parameters: 0
	Flags: None
	Line Number: 3301
*/
function function_de3783c()
{
	function_IPrintLnBold(self.var_name + ": Resetting Full Maps Stats");
	self function_SetControllerUIModelValue("UEM.get_map_stats", 0);
	self.var_c6452f46["map"] = 1;
	self notify("hash_ef35fa9e");
	wait(0.05);
	self notify("hash_41157217");
	wait(0.05);
	self notify("hash_d95e591d");
	wait(0.05);
}

/*
	Name: function_8923385d
	Namespace: namespace_97ac1184
	Checksum: 0x424F4353
	Offset: 0x13370
	Size: 0x308
	Parameters: 0
	Flags: None
	Line Number: 3324
*/
function function_8923385d()
{
	self endon("hash_disconnect");
	self endon("hash_d95e591d");
	while(1)
	{
		self waittill("hash_menuresponse", var_menu, var_response);
		if(var_menu == "levelingdatamapsmenu")
		{
			if(var_response == "stop_sending")
			{
				self notify("hash_ef35fa9e");
			}
			else
			{
				var_cde9f622 = function_StrTok(var_response, ",");
				foreach(var_token in var_cde9f622)
				{
					var_b9b0ebb3 = function_StrTok(var_token, "=");
					if(var_b9b0ebb3.size != 2)
					{
						continue;
					}
					var_dataName = function_ToLower(var_b9b0ebb3[0]);
					var_value = var_b9b0ebb3[1];
					var_abe6703d = function_ToLower(level.var_742cf7b3[var_dataName]);
					if(var_dataName == "tryagain")
					{
						self function_LUINotifyEvent(&"spx_get_maps_save_data", 1, function_Int(level.var_c3e446a[var_value]));
						function_IPrintLnBold("Did not get a proper response; Trying again");
						continue;
					}
					switch(var_abe6703d)
					{
						case "player":
						{
							if(var_dataName == "xuid" && var_value != self function_getxuid(1))
							{
								self function_de3783c();
							}
							else if(var_dataName == "reset_keyword" && function_Int(var_value) != 8351)
							{
								self function_de3783c();
								break;
							}
						}
						case "pers":
						{
							self.var_pers[var_dataName] = function_Int(var_value);
							break;
						}
					}
				}
			}
		}
	}
}

/*
	Name: function_6e45aed9
	Namespace: namespace_97ac1184
	Checksum: 0x424F4353
	Offset: 0x13680
	Size: 0xA0
	Parameters: 0
	Flags: None
	Line Number: 3392
*/
function function_6e45aed9()
{
	self endon("hash_disconnect");
	self endon("hash_45f32e3c");
	self namespace_flag::function_init("completed_challenges_stats_loading");
	wait(0.05);
	self.var_c6452f46["challenges"] = 1;
	self notify("hash_62d89a98");
	wait(0.05);
	self namespace_flag::function_set("completed_challenges_stats_loading");
	wait(0.05);
	self notify("hash_18f1b430");
	return;
	ERROR: Exception occured: Stack empty.
}

/*
	Name: function_e8e35205
	Namespace: namespace_97ac1184
	Checksum: 0x424F4353
	Offset: 0x13728
	Size: 0xA8
	Parameters: 0
	Flags: None
	Line Number: 3418
*/
function function_e8e35205()
{
	function_IPrintLnBold(self.var_name + ": Resetting Full Challenges Stats");
	self function_SetControllerUIModelValue("UEM.get_challenges_stats", 0);
	wait(0.05);
	self.var_c6452f46["challenges"] = 1;
	self notify("hash_62d89a98");
	wait(0.05);
	self notify("hash_18f1b430");
	wait(0.05);
	self notify("hash_45f32e3c");
	return;
}

/*
	Name: function_20b52f3a
	Namespace: namespace_97ac1184
	Checksum: 0x424F4353
	Offset: 0x137D8
	Size: 0x308
	Parameters: 0
	Flags: None
	Line Number: 3442
*/
function function_20b52f3a()
{
	self endon("hash_disconnect");
	self endon("hash_45f32e3c");
	while(1)
	{
		self waittill("hash_menuresponse", var_menu, var_response);
		if(var_menu == "levelingdatachallengesmenu")
		{
			if(var_response == "stop_sending")
			{
				self notify("hash_18f1b430");
			}
			else
			{
				var_cde9f622 = function_StrTok(var_response, ",");
				foreach(var_token in var_cde9f622)
				{
					var_b9b0ebb3 = function_StrTok(var_token, "=");
					if(var_b9b0ebb3.size != 2)
					{
						continue;
					}
					var_dataName = function_ToLower(var_b9b0ebb3[0]);
					var_value = var_b9b0ebb3[1];
					var_abe6703d = function_ToLower(level.var_d04fcc6a[var_dataName]);
					if(var_dataName == "tryagain")
					{
						self function_LUINotifyEvent(&"spx_get_challenges_save_data", 1, function_Int(level.var_79bcc5f3[var_value]));
						function_IPrintLnBold("Did not get a proper response; Trying again");
						continue;
					}
					switch(var_abe6703d)
					{
						case "player":
						{
							if(var_dataName == "xuid" && var_value != self function_getxuid(1))
							{
								self thread function_e8e35205();
							}
							else if(var_dataName == "reset_keyword" && function_Int(var_value) != 8351)
							{
								self thread function_e8e35205();
								break;
							}
						}
						case "pers":
						{
							self.var_pers[var_dataName] = function_Int(var_value);
							break;
						}
					}
				}
			}
		}
	}
}

/*
	Name: function_e6354944
	Namespace: namespace_97ac1184
	Checksum: 0x424F4353
	Offset: 0x13AE8
	Size: 0x28
	Parameters: 0
	Flags: None
	Line Number: 3510
*/
function function_e6354944()
{
	while(!isdefined(self.var_pers["cc2_gift_collector"]))
	{
		wait(0.5);
	}
}

/*
	Name: function_2319c53f
	Namespace: namespace_97ac1184
	Checksum: 0x424F4353
	Offset: 0x13B18
	Size: 0x488
	Parameters: 0
	Flags: None
	Line Number: 3528
*/
function function_2319c53f()
{
	while(!isdefined(level.var_18ffd3f2))
	{
		wait(1);
	}
	while(!isdefined(self.var_fa202141["player_character"]))
	{
		wait(1);
	}
	while(1)
	{
		if(isdefined(self.var_fa202141["player_character"]) && self.var_fa202141["player_character"] > 0 && isdefined(level.var_18ffd3f2[self function_getxuid(1)]))
		{
			if(self function_GetCharacterBodyType() != 9 || self function_GetCharacterBodyType() != 10 || self function_GetCharacterBodyType() != 11 || self function_GetCharacterBodyType() != 12 || self function_GetCharacterBodyType() != 13)
			{
				switch(self.var_fa202141["player_character"])
				{
					case 1:
					{
						if(level.var_18ffd3f2[self function_getxuid(1)].var_rank == "gold" || level.var_18ffd3f2[self function_getxuid(1)].var_rank == "master" || level.var_18ffd3f2[self function_getxuid(1)].var_rank == "paragon" || level.var_18ffd3f2[self function_getxuid(1)].var_rank == "ultimate")
						{
							self function_SetCharacterBodyType(10);
							break;
						}
					}
					case 2:
					{
						if(level.var_18ffd3f2[self function_getxuid(1)].var_rank == "master" || level.var_18ffd3f2[self function_getxuid(1)].var_rank == "paragon" || level.var_18ffd3f2[self function_getxuid(1)].var_rank == "ultimate")
						{
							self function_SetCharacterBodyType(12);
							break;
						}
					}
					case 3:
					{
						if(level.var_18ffd3f2[self function_getxuid(1)].var_rank == "paragon" || level.var_18ffd3f2[self function_getxuid(1)].var_rank == "ultimate")
						{
							self function_SetCharacterBodyType(11);
							break;
						}
					}
					case 4:
					{
						if(level.var_18ffd3f2[self function_getxuid(1)].var_rank == "ultimate")
						{
							self function_SetCharacterBodyType(13);
							break;
						}
					}
					case 5:
					{
						if(level.var_18ffd3f2[self function_getxuid(1)].var_rank == "ultimate")
						{
							self function_SetCharacterBodyType(9);
							break;
						}
					}
				}
			}
		}
		wait(2);
	}
}

/*
	Name: function_3fca15b0
	Namespace: namespace_97ac1184
	Checksum: 0x424F4353
	Offset: 0x13FA8
	Size: 0xB88
	Parameters: 0
	Flags: None
	Line Number: 3603
*/
function function_3fca15b0()
{
	while(!isdefined(self.var_fa202141["player_characterhat"]))
	{
		wait(1);
	}
	while(!isdefined(level.var_18ffd3f2[self function_getxuid(1)]))
	{
		wait(1);
	}
	if(isdefined(self.var_fa202141["player_characterhat"]) && self.var_fa202141["player_characterhat"] > 0)
	{
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
		else
		{
			switch(self.var_fa202141["player_characterhat"])
			{
				case 1:
				{
					self thread function_2d147fe0("_zmu_paper_bag_hat");
					break;
				}
				case 2:
				{
					if(self.var_pers["christmas_hat"] == 1)
					{
						self thread function_2d147fe0("_zmu_christmas_hat");
						break;
					}
				}
				case 3:
				{
					if(self.var_pers["halloween_pumpkin_hat"] == 1)
					{
						self thread function_2d147fe0("_zmu_halloween_hat");
						break;
					}
				}
				case 4:
				{
					if(isdefined(level.var_18ffd3f2[self function_getxuid(1)]) && (level.var_18ffd3f2[self function_getxuid(1)].var_rank == "bronze" || level.var_18ffd3f2[self function_getxuid(1)].var_rank == "silver" || level.var_18ffd3f2[self function_getxuid(1)].var_rank == "gold" || level.var_18ffd3f2[self function_getxuid(1)].var_rank == "master" || level.var_18ffd3f2[self function_getxuid(1)].var_rank == "paragon" || level.var_18ffd3f2[self function_getxuid(1)].var_rank == "ultimate"))
					{
						self thread function_2d147fe0("_zmu_crown_vip_bronze");
						break;
					}
				}
				case 5:
				{
					if(isdefined(level.var_18ffd3f2[self function_getxuid(1)]) && (level.var_18ffd3f2[self function_getxuid(1)].var_rank == "silver" || level.var_18ffd3f2[self function_getxuid(1)].var_rank == "gold" || level.var_18ffd3f2[self function_getxuid(1)].var_rank == "master" || level.var_18ffd3f2[self function_getxuid(1)].var_rank == "paragon" || level.var_18ffd3f2[self function_getxuid(1)].var_rank == "ultimate"))
					{
						self thread function_2d147fe0("_zmu_crown_vip_silver");
						break;
					}
				}
				case 6:
				{
					if(isdefined(level.var_18ffd3f2[self function_getxuid(1)]) && (level.var_18ffd3f2[self function_getxuid(1)].var_rank == "gold" || level.var_18ffd3f2[self function_getxuid(1)].var_rank == "master" || level.var_18ffd3f2[self function_getxuid(1)].var_rank == "paragon" || level.var_18ffd3f2[self function_getxuid(1)].var_rank == "ultimate"))
					{
						self thread function_2d147fe0("_zmu_crown_vip_gold");
						break;
					}
				}
				case 7:
				{
					if(isdefined(level.var_18ffd3f2[self function_getxuid(1)]) && (level.var_18ffd3f2[self function_getxuid(1)].var_rank == "master" || level.var_18ffd3f2[self function_getxuid(1)].var_rank == "paragon" || level.var_18ffd3f2[self function_getxuid(1)].var_rank == "ultimate"))
					{
						self thread function_2d147fe0("_zmu_crown_vip_master");
						break;
					}
				}
				case 8:
				{
					if(isdefined(level.var_18ffd3f2[self function_getxuid(1)]) && (level.var_18ffd3f2[self function_getxuid(1)].var_rank == "paragon" || level.var_18ffd3f2[self function_getxuid(1)].var_rank == "ultimate"))
					{
						self thread function_2d147fe0("_zmu_crown_vip_paragon");
						break;
					}
				}
				case 9:
				{
					if(isdefined(level.var_18ffd3f2[self function_getxuid(1)]) && level.var_18ffd3f2[self function_getxuid(1)].var_rank == "ultimate")
					{
						self thread function_2d147fe0("_zmu_crown_vip_ultimate");
						break;
					}
				}
				case 10:
				{
					if(isdefined(level.var_18ffd3f2[self function_getxuid(1)]) && (level.var_18ffd3f2[self function_getxuid(1)].var_rank == "master" || level.var_18ffd3f2[self function_getxuid(1)].var_rank == "paragon" || level.var_18ffd3f2[self function_getxuid(1)].var_rank == "ultimate"))
					{
						self thread function_2d147fe0("_zmu_hat_chicken_hat");
						break;
					}
				}
				case 11:
				{
					if(isdefined(level.var_18ffd3f2[self function_getxuid(1)]) && (level.var_18ffd3f2[self function_getxuid(1)].var_rank == "paragon" || level.var_18ffd3f2[self function_getxuid(1)].var_rank == "ultimate"))
					{
						self thread function_2d147fe0("_zmu_hat_tv_hat");
						break;
					}
				}
				case 12:
				{
					if(self.var_pers["christmas_hat_2"] == 1)
					{
						self thread function_2d147fe0("_zmu_hat_christmas_ball");
						break;
					}
				}
				case 999:
				{
					if(self function_getxuid(1) == "76561198160068017")
					{
						self thread function_2d147fe0("_zmu_hat_doge");
						break;
					}
				}
			}
		}
		continue;
	}
	else
	{
		return;
	}
}

/*
	Name: function_2fbda28f
	Namespace: namespace_97ac1184
	Checksum: 0x424F4353
	Offset: 0x14B38
	Size: 0x2B0
	Parameters: 0
	Flags: None
	Line Number: 3765
*/
function function_2fbda28f()
{
	self endon("hash_bled_out");
	self endon("hash_spawned_player");
	self endon("hash_disconnect");
	wait(0.05);
	level namespace_flag::function_wait_till("initial_blackscreen_passed");
	self thread function_95db0c88();
	function_8b57c052("PlaySound", 0);
	for(;;)
	{
		wait(0.05);
		var_dvar_value = function_GetDvarInt("PlaySound");
		if(isdefined(var_dvar_value) && var_dvar_value != 0)
		{
			function_8b57c052("PlaySound", 0);
			switch(self.var_f4d01b67["sound_pack"])
			{
				case 1:
				{
					function_playsoundatposition("player_sounds_windows_shutdown", self.var_origin);
					break;
				}
				case 2:
				{
					function_playsoundatposition("player_sounds_fart", self.var_origin);
					break;
				}
				case 3:
				{
					function_playsoundatposition("player_sounds_i_like_turtles", self.var_origin);
					break;
				}
				case 4:
				{
					function_playsoundatposition("player_sounds_enemy_spotted", self.var_origin);
					break;
				}
				case 5:
				{
					function_playsoundatposition("player_sounds_laugh_scooby", self.var_origin);
					break;
				}
				case 6:
				{
					function_playsoundatposition("player_sounds_fbi_open_up", self.var_origin);
					break;
				}
				case 7:
				{
					function_playsoundatposition("player_sounds_uwu", self.var_origin);
					break;
				}
				case 8:
				{
					function_playsoundatposition("player_sounds_emotional_damage", self.var_origin);
					break;
				}
				case 9:
				{
					function_playsoundatposition("player_sounds_hi_how_are_ya", self.var_origin);
					break;
				}
			}
		}
	}
}

/*
	Name: function_95db0c88
	Namespace: namespace_97ac1184
	Checksum: 0x424F4353
	Offset: 0x14DF0
	Size: 0x88
	Parameters: 0
	Flags: None
	Line Number: 3843
*/
function function_95db0c88()
{
	self waittill("hash_cb55d4d2");
	while(1)
	{
		if(isdefined(self))
		{
			self waittill("hash_menuresponse", var_menu, var_response);
			if(var_menu == "soundpackmenu")
			{
				self.var_f4d01b67["sound_pack"] = function_Int(var_response);
			}
		}
	}
}

/*
	Name: function_2d147fe0
	Namespace: namespace_97ac1184
	Checksum: 0x424F4353
	Offset: 0x14E80
	Size: 0xC0
	Parameters: 1
	Flags: None
	Line Number: 3869
*/
function function_2d147fe0(var_model)
{
	self notify("hash_5f7623c6");
	self endon("hash_5f7623c6");
	self function_Attach(var_model, "j_head");
	self.var_1652177e = var_model;
	wait(0.05);
	self namespace_util::function_waittill_any("player_equip_new_hat", "disconnect");
	if(isdefined(self) && function_isalive(self))
	{
		self function_Detach(var_model, "j_head");
		return;
	}
}

/*
	Name: function_48c20fe
	Namespace: namespace_97ac1184
	Checksum: 0x424F4353
	Offset: 0x14F48
	Size: 0x140
	Parameters: 0
	Flags: None
	Line Number: 3894
*/
function function_48c20fe()
{
	self thread function_790454cd();
	self thread function_7e18304e("spx_save_data", "prestige", self.var_b74a3cd1["prestige"], 0);
	self thread function_7e18304e("spx_save_data", "level", self.var_b74a3cd1["level"], 0);
	self thread function_7e18304e("spx_save_data", "xp", self.var_b74a3cd1["xp"], 0);
	wait(0.05);
	for(var_i = 0; var_i < function_GetDvarInt("com_maxclients"); var_i++)
	{
		self thread function_7e18304e("player_data", var_i, var_i, 0, 1);
	}
	wait(0.05);
}

/*
	Name: function_87d1927f
	Namespace: namespace_97ac1184
	Checksum: 0x424F4353
	Offset: 0x15090
	Size: 0x350
	Parameters: 10
	Flags: None
	Line Number: 3918
*/
function function_87d1927f(var_eInflictor, var_eAttacker, var_iDamage, var_iDFlags, var_sMeansOfDeath, var_weapon, var_vPoint, var_vDir, var_sHitLoc, var_psOffsetTime)
{
	if(function_ToLower(function_GetDvarString("mapname")) == "zm_temple")
	{
		if(function_isPlayer(self) && self function_hasPerk("specialty_phdflopper") && (namespace_zm_utility::function_is_explosive_damage(var_sMeansOfDeath) || var_sMeansOfDeath == "MOD_FALLING" || var_sMeansOfDeath == "MOD_EXPLOSIVE"))
		{
			return 0;
		}
	}
	if(level.var_round_number >= 5 && (!(isdefined(self.var_d9a9d5d8) && self.var_d9a9d5d8)))
	{
		self.var_d9a9d5d8 = 1;
	}
	if(isdefined(var_eAttacker) && var_weapon.var_name == "zombie_ai_defaultmelee")
	{
		if(isdefined(self.var_fa202141["player_playerdifficulty"]) && self.var_fa202141["player_playerdifficulty"] > 0)
		{
			if(level namespace_flag::function_get("classic_enabled") && self.var_fa202141["player_playerdifficulty"] < 10)
			{
				var_92c6979f = 50;
			}
			else if(35 + function_Int(self.var_fa202141["player_playerdifficulty"] * 1.5) > 90 && (isdefined(self.var_fa202141["player_brutalcap"]) && self.var_fa202141["player_brutalcap"] == 0))
			{
				var_92c6979f = 90;
			}
			else
			{
				var_92c6979f = 35 + function_Int(self.var_fa202141["player_playerdifficulty"] * 1.5);
			}
		}
		else if(level namespace_flag::function_get("classic_enabled"))
		{
			var_92c6979f = 50;
		}
		switch(level.var_bdc116e3)
		{
			case 2:
			{
				var_92c6979f = 30;
			}
		}
	}
	if(function_ToLower(function_GetDvarString("mapname")) == "zm_prison" && self.var_health - var_iDamage <= 1)
	{
		return -1;
	}
	else if(isdefined(var_92c6979f))
	{
		return var_92c6979f;
	}
	return -1;
}

/*
	Name: function_592735a9
	Namespace: namespace_97ac1184
	Checksum: 0x424F4353
	Offset: 0x153E8
	Size: 0x80
	Parameters: 0
	Flags: None
	Line Number: 3981
*/
function function_592735a9()
{
	self endon("hash_d2bbeae8");
	self endon("hash_41157217");
	for(var_count = 0; var_count < 30; var_count++)
	{
		wait(1);
	}
	function_IPrintLnBold("Forcing rank loading completion, please notify Sphynx");
	self notify("hash_f505e998");
	self notify("hash_74979e67");
}

/*
	Name: function_182e5a64
	Namespace: namespace_97ac1184
	Checksum: 0x424F4353
	Offset: 0x15470
	Size: 0xD8
	Parameters: 0
	Flags: None
	Line Number: 4004
*/
function function_182e5a64()
{
	while(!isdefined(self.var_6915e7ce["r1"]))
	{
		wait(0.05);
	}
	for(var_i = 1; var_i < self.var_6915e7ce.size; var_i++)
	{
		if(!isdefined(self.var_6915e7ce["r" + var_i]) || self.var_6915e7ce["r" + var_i].var_enabled == 0)
		{
			continue;
		}
		wait(0.05);
		self thread function_bdd58b53(self.var_6915e7ce["r" + var_i]);
	}
	return;
}

/*
	Name: function_bdd58b53
	Namespace: namespace_97ac1184
	Checksum: 0x424F4353
	Offset: 0x15550
	Size: 0x150
	Parameters: 1
	Flags: None
	Line Number: 4032
*/
function function_bdd58b53(var_reward)
{
	function_IPrintLnBold("Gave Reward: " + var_reward.var_description);
	switch(var_reward.var_bd058c01)
	{
		case "r1":
		{
			self function_SetCharacterBodyType(5);
			break;
		}
		case "r2":
		{
			self namespace_zm_weapons::function_weapon_give(function_GetWeapon("melee_jug"), 0, 0, 1, 1);
			break;
		}
		case "r3":
		{
			self namespace_zm_score::function_add_to_player_score(500);
			break;
		}
		case "r4":
		{
			self.var_a29c8301 = function_GetWeapon("t9_1911_midnight");
			break;
		}
		case "r5":
		{
			self namespace_zm_weapons::function_weapon_give(function_GetWeapon("incendiary_grenade"), 0, 0, 1, 0);
			break;
		}
	}
}

/*
	Name: function_ac0dc73f
	Namespace: namespace_97ac1184
	Checksum: 0x424F4353
	Offset: 0x156A8
	Size: 0xB0
	Parameters: 1
	Flags: None
	Line Number: 4075
*/
function function_ac0dc73f(var_type)
{
	switch(var_type)
	{
		case "xp":
		{
			return self.var_b74a3cd1["xp"];
		}
		case "level":
		{
			return self.var_b74a3cd1["level"];
		}
		case "prestige":
		{
			return self.var_b74a3cd1["prestige"];
		}
		case "brutal_rank":
		{
			return self.var_b74a3cd1["brutal_rank"];
		}
		case "brutal_xp":
		{
			return self.var_b74a3cd1["brutal_xp"];
		}
	}
	return 0;
}

/*
	Name: function_ca15044e
	Namespace: namespace_97ac1184
	Checksum: 0x424F4353
	Offset: 0x15760
	Size: 0xFA8
	Parameters: 0
	Flags: None
	Line Number: 4113
*/
function function_ca15044e()
{
	self endon("hash_disconnect");
	self.var_a1d93d72 = function_Int(0);
	for(;;)
	{
		self waittill("hash_79ef118b", var_type, var_amount, var_zombie);
		var_f0780448 = var_amount;
		var_514894 = function_ac0dc73f("xp");
		var_2e8a2b5e = function_ac0dc73f("level");
		var_4ce15837 = function_ac0dc73f("prestige");
		var_2d118321 = function_ac0dc73f("brutal_rank");
		var_9baa3c53 = function_ac0dc73f("brutal_xp");
		if(self.var_f4d01b67["disabled_leveling_system"] == 1)
		{
			wait(0.1);
		}
		else if(isdefined(var_type))
		{
			var_amount = self function_565fd0dc(var_type, var_amount, var_zombie);
		}
		else if(var_amount < function_Int(2501))
		{
			self thread function_score_event(&"ZM_MINECRAFT_SCORE_GENERAL", var_amount);
		}
		var_ca7a8609 = self function_4c2abd48(self.var_b74a3cd1["level"]);
		if(self.var_b74a3cd1["xp"] + var_amount > var_514894 + var_f0780448 * 2.3)
		{
			self thread function_af1952dc("xpcheated", 1);
		}
		else if(self.var_b74a3cd1["xp"] < var_ca7a8609["xp_needed"] && self.var_b74a3cd1["level"] > var_2e8a2b5e)
		{
			self thread function_af1952dc("levelcheated", self.var_b74a3cd1["level"] - var_2e8a2b5e);
		}
		else if(self.var_b74a3cd1["xp"] < var_ca7a8609["xp_needed"] && (self.var_b74a3cd1["level"] < 91 && self.var_b74a3cd1["prestige"] <= 19) && self.var_b74a3cd1["prestige"] > var_4ce15837)
		{
			self thread function_af1952dc("prestigecheated", self.var_b74a3cd1["prestige"] - var_4ce15837);
		}
		else if(isdefined(self.var_fa202141["player_playerdifficulty"]) && self.var_fa202141["player_playerdifficulty"] > 0)
		{
			self thread function_adc67b81(var_amount);
		}
		function_debug_print(0, "Leveling System: ^5 Gained " + var_amount + " XP! of event: " + var_type);
		self.var_b74a3cd1["xp"] = self.var_b74a3cd1["xp"] + function_Int(var_amount);
		if(self.var_b74a3cd1["xp"] < 0)
		{
			self.var_b74a3cd1["xp"] = function_Int(0);
		}
		self.var_b74a3cd1["xp_gained_this_game"] = self.var_b74a3cd1["xp_gained_this_game"] + function_Int(var_amount);
		if(self.var_b74a3cd1["xp_gained_this_game"] > 0)
		{
			self.var_b74a3cd1["xp_per_second"] = self.var_b74a3cd1["xp_gained_this_game"] / function_Int(level.var_8f1fd1e4);
			if(self.var_pers["highest_total_xpm"] > self.var_b74a3cd1["xp_per_second"])
			{
			}
			else
			{
				self.var_pers["highest_total_xpm"] = self.var_b74a3cd1["xp_per_second"];
				self thread function_7e18304e("spx_save_data", "highest_total_xpm", self.var_pers["highest_total_xpm"], 0);
			}
		}
		if(var_amount > self.var_b74a3cd1["xp_highest_this_game"])
		{
			self.var_b74a3cd1["xp_highest_this_game"] = var_amount;
			self thread function_7e18304e("spx_end_game_save_data", "end_game_highest_xp", function_Int(var_amount), 1);
		}
		if(self.var_b74a3cd1["xp_per_second"] > self.var_pers["end_game_highest_xps"])
		{
			self thread function_7e18304e("spx_end_game_save_data", "end_game_highest_xps", self.var_b74a3cd1["xp_per_second"], 1);
		}
		self thread function_7e18304e("spx_end_game_save_data", "end_game_total_xp_gained", function_Int(var_amount), 0);
		if(self.var_b74a3cd1["xp"] >= var_ca7a8609["xp_needed"])
		{
			function_debug_print(0, "Leveling System: ^5 Player has enough xp, reset and level up");
			if(self.var_b74a3cd1["level"] >= 1000)
			{
				self thread function_48c20fe();
			}
			while(1)
			{
				var_ca7a8609 = self function_4c2abd48(self.var_b74a3cd1["level"]);
				var_af7d80a6 = self.var_b74a3cd1["xp"] - var_ca7a8609["xp_needed"];
				self.var_b74a3cd1["xp"] = 0 + var_af7d80a6;
				self.var_b74a3cd1["level"]++;
				self thread function_7e18304e("spx_end_game_save_data", "end_game_levels_gained", 1, 0);
				self thread function_7e18304e("spx_end_game_save_data", "end_game_level", 1, 0);
				self function_71333cee(self.var_b74a3cd1["level"]);
				function_debug_print(0, "Leveling System: ^5 XP is still too much, level up");
				break;
			}
			self thread function_b3489bf5("^3" + self.var_playerName + "^7 leveled up to rank ^9" + self.var_b74a3cd1["level"]);
			self.var_b74a3cd1["xp"] = 0;
			self function_LUINotifyEvent(&"spx_rank_up_notification", 3, 1, self.var_b74a3cd1["prestige"], self.var_b74a3cd1["level"]);
			function_debug_print(0, "Leveling System: ^5 Player has enough levels, Prestige");
			self.var_b74a3cd1["prestige"]++;
			self.var_pers["player_points"] = self.var_pers["player_points"] + 200;
			self.var_b74a3cd1["level"] = 1;
			self thread function_b3489bf5("^3" + self.var_playerName + "^7 prestiged to ^9" + self.var_b74a3cd1["prestige"]);
			self thread function_7e18304e("spx_end_game_save_data", "end_game_prestige_gained", 1, 0);
			self thread function_7e18304e("spx_end_game_save_data", "end_game_prestige", 1, 0);
			var_ca7a8609 = self function_4c2abd48(self.var_b74a3cd1["level"]);
			var_af7d80a6 = var_ca7a8609["xp_needed"] - self.var_b74a3cd1["xp"];
			self.var_b74a3cd1["xp"] = 0 + var_af7d80a6;
			self.var_b74a3cd1["level"]++;
			function_debug_print(0, "Leveling System: ^5 XP is still too much, level up");
			break;
			self thread function_b3489bf5("^3" + self.var_playerName + "^7 leveled up to rank ^9" + self.var_b74a3cd1["level"]);
			self thread function_48c20fe();
			self.var_b74a3cd1["prestige_legend"]++;
			self.var_b74a3cd1["prestige"] = function_Int(0);
			self.var_b74a3cd1["level"] = function_Int(1);
			self.var_b74a3cd1["xp"] = function_Int(0);
			self thread function_b3489bf5("^3" + self.var_playerName + "^7 leveled up to Prestige Legend ^9" + self.var_b74a3cd1["prestige_legend"]);
			self.var_b74a3cd1["prestige_absolute"]++;
			self.var_b74a3cd1["prestige_legend"] = function_Int(0);
			self.var_b74a3cd1["prestige"] = function_Int(0);
			self.var_b74a3cd1["level"] = function_Int(1);
			self.var_b74a3cd1["xp"] = function_Int(0);
			self.var_pers["absolute_camo"] = 1;
			self thread function_b3489bf5("^3" + self.var_playerName + "^7 leveled up to Prestige Absolute ^9" + self.var_b74a3cd1["prestige_absolute"]);
			self.var_b74a3cd1["prestige_ultimate"]++;
			self.var_b74a3cd1["prestige_absolute"] = function_Int(0);
			self.var_b74a3cd1["prestige_legend"] = function_Int(0);
			self.var_b74a3cd1["prestige"] = function_Int(0);
			self.var_b74a3cd1["level"] = function_Int(1);
			self.var_b74a3cd1["xp"] = function_Int(0);
			self thread function_b3489bf5("^3" + self.var_playerName + "^7 leveled up to Prestige Ultimate ^9" + self.var_b74a3cd1["prestige_ultimate"]);
		}
		else
		{
			if(var_af7d80a6 > 0)
			{
			}
			if(self.var_b74a3cd1["xp"] >= var_ca7a8609["xp_needed"])
			{
			}
			else
			{
			}
			if(self.var_b74a3cd1["xp"] < 0)
			{
			}
			if(self.var_b74a3cd1["level"] >= 91 && self.var_b74a3cd1["prestige"] <= 19)
			{
				while(1)
				{
					if(self.var_b74a3cd1["xp"] >= var_ca7a8609["xp_needed"])
					{
					}
					else
					{
					}
				}
			}
			if(self.var_b74a3cd1["prestige"] == 20 && self.var_b74a3cd1["level"] >= 1000)
			{
				if(self.var_b74a3cd1["prestige_legend"] < 10)
				{
				}
				else if(self.var_b74a3cd1["prestige_legend"] == 10 && self.var_b74a3cd1["prestige_absolute"] < 10)
				{
					if(self.var_pers["absolute_camo"] != 0)
					{
					}
				}
				else if(self.var_b74a3cd1["prestige_legend"] == 10 && self.var_b74a3cd1["prestige_absolute"] == 10)
				{
				}
			}
			self thread function_48c20fe();
			function_debug_print(0, "Leveling System: ^5 Level: " + var_ca7a8609["level_index"] + " | XP Needed: " + var_ca7a8609["xp_needed"]);
		}
	}
}

/*
	Name: function_score_event
	Namespace: namespace_97ac1184
	Checksum: 0x424F4353
	Offset: 0x16710
	Size: 0xE8
	Parameters: 3
	Flags: None
	Line Number: 4298
*/
function function_score_event(var_89be7cc4, var_amount, var_cheater)
{
	if(!isdefined(var_cheater))
	{
		var_cheater = 0;
	}
	if(var_cheater)
	{
		self thread function_8c165b4d("Data", "ScoreUI", "+" + var_amount + " [Cheated] " + function_MakeLocalizedString(var_89be7cc4), 1, 1);
	}
	else
	{
		self thread function_8c165b4d("Data", "ScoreUI", "+" + var_amount + " " + function_MakeLocalizedString(var_89be7cc4), 1, 1);
		return;
	}
	var_cheater++;
}

/*
	Name: function_d1935658
	Namespace: namespace_97ac1184
	Checksum: 0x424F4353
	Offset: 0x16800
	Size: 0x38
	Parameters: 0
	Flags: None
	Line Number: 4326
*/
function function_d1935658()
{
	for(;;)
	{
		wait(0.1);
		if(self.var_d1935658 >= 0)
		{
			self.var_d1935658 = self.var_d1935658 - 0.05;
		}
	}
}

/*
	Name: function_e375856c
	Namespace: namespace_97ac1184
	Checksum: 0x424F4353
	Offset: 0x16840
	Size: 0x60
	Parameters: 0
	Flags: None
	Line Number: 4348
*/
function function_e375856c()
{
	while(function_GetPlayers().size > 1)
	{
		wait(0.3);
		continue;
		wait(0.1);
		if(self.var_a1d93d72 >= 0)
		{
			self.var_a1d93d72 = self.var_a1d93d72 - 0.01;
		}
	}
}

/*
	Name: function_adc67b81
	Namespace: namespace_97ac1184
	Checksum: 0x424F4353
	Offset: 0x168A8
	Size: 0x4A0
	Parameters: 1
	Flags: None
	Line Number: 4372
*/
function function_adc67b81(var_93958074)
{
	if(self.var_b74a3cd1["brutal_rank"] == self.var_fa202141["player_playerdifficulty"])
	{
		var_amount = namespace_zm_utility::function_round_up_score(var_93958074 / 80, 1);
	}
	else if(self.var_fa202141["player_playerdifficulty"] == self.var_b74a3cd1["brutal_rank"] - 1)
	{
		var_amount = namespace_zm_utility::function_round_up_score(var_93958074 / 100, 1);
	}
	else if(self.var_fa202141["player_playerdifficulty"] == self.var_b74a3cd1["brutal_rank"] - 2)
	{
		var_amount = namespace_zm_utility::function_round_up_score(var_93958074 / 120, 1);
	}
	else if(self.var_fa202141["player_playerdifficulty"] == self.var_b74a3cd1["brutal_rank"] - 3)
	{
		var_amount = namespace_zm_utility::function_round_up_score(var_93958074 / 160, 1);
	}
	else if(self.var_fa202141["player_playerdifficulty"] < self.var_b74a3cd1["brutal_rank"] - 4)
	{
		var_amount = namespace_zm_utility::function_round_up_score(var_93958074 / 250, 1);
	}
	else
	{
		var_amount = namespace_zm_utility::function_round_up_score(var_93958074 / 300, 1);
	}
	if(0)
	{
		var_amount = namespace_zm_utility::function_round_up_score(var_amount * 1.5, 1);
	}
	if(1 && var_amount > 20)
	{
		var_amount = 20;
	}
	else if(0)
	{
		var_amount = 40;
	}
	self.var_b74a3cd1["brutal_xp"] = self.var_b74a3cd1["brutal_xp"] + var_amount;
	self thread function_7e18304e("spx_save_data", "brutal_xp", self.var_b74a3cd1["brutal_xp"], 0);
	var_ca7a8609 = self function_7da4fcdb(self.var_b74a3cd1["brutal_rank"]);
	if(self.var_b74a3cd1["brutal_xp"] >= var_ca7a8609["xp_needed"] && self.var_b74a3cd1["brutal_rank"] <= 99)
	{
		self.var_b74a3cd1["brutal_rank"]++;
		self thread function_7e18304e("spx_save_data", "brutal_rank", self.var_b74a3cd1["brutal_rank"], 0);
		if(self.var_fa202141["player_playerdifficulty"] == self.var_b74a3cd1["brutal_rank"] - 1)
		{
			self.var_fa202141["player_playerdifficulty"] = self.var_b74a3cd1["brutal_rank"];
		}
		self.var_b74a3cd1["brutal_xp"] = 0;
		self thread function_b3489bf5("^3" + self.var_playerName + "^7 leveled up to brutal rank ^9" + self.var_b74a3cd1["brutal_rank"]);
		self function_LUINotifyEvent(&"spx_rank_up_notification", 2, 2, self.var_b74a3cd1["brutal_rank"]);
	}
	else
	{
		self function_LUINotifyEvent(&"ZMBU_info", 4, &"ZM_MINECRAFT_BRUTAL_RANK", self.var_b74a3cd1["brutal_rank"], self.var_b74a3cd1["brutal_xp"], var_ca7a8609["xp_needed"]);
	}
}

/*
	Name: function_a1d93d72
	Namespace: namespace_97ac1184
	Checksum: 0x424F4353
	Offset: 0x16D50
	Size: 0x50
	Parameters: 0
	Flags: None
	Line Number: 4441
*/
function function_a1d93d72()
{
	self.var_a1d93d72 = 1;
	while(self.var_a1d93d72 >= 0)
	{
		wait(0.01);
		self.var_a1d93d72 = self.var_a1d93d72 - 0.01;
	}
	self.var_a1d93d72 = 0;
}

/*
	Name: function_71333cee
	Namespace: namespace_97ac1184
	Checksum: 0x424F4353
	Offset: 0x16DA8
	Size: 0x2B8
	Parameters: 1
	Flags: None
	Line Number: 4462
*/
function function_71333cee(var_rank)
{
	if(var_rank >= 1 && var_rank <= 10)
	{
		self.var_pers["player_points"] = self.var_pers["player_points"] + 10;
	}
	else if(var_rank >= 11 && var_rank <= 20)
	{
		self.var_pers["player_points"] = self.var_pers["player_points"] + 20;
	}
	else if(var_rank >= 21 && var_rank <= 30)
	{
		self.var_pers["player_points"] = self.var_pers["player_points"] + 30;
	}
	else if(var_rank >= 31 && var_rank <= 40)
	{
		self.var_pers["player_points"] = self.var_pers["player_points"] + 40;
	}
	else if(var_rank >= 41 && var_rank <= 50)
	{
		self.var_pers["player_points"] = self.var_pers["player_points"] + 50;
	}
	else if(var_rank >= 51 && var_rank <= 60)
	{
		self.var_pers["player_points"] = self.var_pers["player_points"] + 60;
	}
	else if(var_rank >= 61 && var_rank <= 70)
	{
		self.var_pers["player_points"] = self.var_pers["player_points"] + 70;
	}
	else if(var_rank >= 71 && var_rank <= 80)
	{
		self.var_pers["player_points"] = self.var_pers["player_points"] + 80;
	}
	else if(var_rank >= 81 && var_rank <= 90)
	{
		self.var_pers["player_points"] = self.var_pers["player_points"] + 90;
	}
}

/*
	Name: function_4c2abd48
	Namespace: namespace_97ac1184
	Checksum: 0x424F4353
	Offset: 0x17068
	Size: 0xD8
	Parameters: 1
	Flags: None
	Line Number: 4512
*/
function function_4c2abd48(var_index)
{
	var_ca7a8609 = [];
	var_row = function_TableLookupRow("gamedata/leveling/leveling_xp.csv", function_Int(var_index));
	var_ca7a8609["level_index"] = function_Int(function_checkStringValid(var_row[0]));
	var_ca7a8609["xp_needed"] = function_Int(function_checkStringValid(var_row[1]));
	return var_ca7a8609;
}

/*
	Name: function_7da4fcdb
	Namespace: namespace_97ac1184
	Checksum: 0x424F4353
	Offset: 0x17148
	Size: 0xD8
	Parameters: 1
	Flags: None
	Line Number: 4531
*/
function function_7da4fcdb(var_index)
{
	var_ca7a8609 = [];
	var_row = function_TableLookupRow("gamedata/leveling/brutal_rank_xp.csv", function_Int(var_index));
	var_ca7a8609["level_index"] = function_Int(function_checkStringValid(var_row[0]));
	var_ca7a8609["xp_needed"] = function_Int(function_checkStringValid(var_row[1]));
	return var_ca7a8609;
}

/*
	Name: function_checkStringValid
	Namespace: namespace_97ac1184
	Checksum: 0x424F4353
	Offset: 0x17228
	Size: 0x28
	Parameters: 1
	Flags: None
	Line Number: 4550
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
	Name: function_debug_print
	Namespace: namespace_97ac1184
	Checksum: 0x424F4353
	Offset: 0x17258
	Size: 0x90
	Parameters: 2
	Flags: None
	Line Number: 4569
*/
function function_debug_print(var_type, var_print)
{
	if(0)
	{
		if(var_type == 0 || var_type == undefined || var_type == "")
		{
			function_IPrintLnBold("^1 Debug: ^7" + var_print);
		}
		else
		{
			function_iprintln("^1 Debug: ^7" + var_print);
			return;
		}
	}
	ERROR: Exception occured: Stack empty.
}

/*
	Name: function_4ec7be94
	Namespace: namespace_97ac1184
	Checksum: 0x424F4353
	Offset: 0x172F0
	Size: 0x68
	Parameters: 0
	Flags: None
	Line Number: 4596
*/
function function_4ec7be94()
{
	self waittill("hash_cb55d4d2");
	if(self.var_d31d6052 >= 25 && self.var_pers["mastery_camo"] != 1)
	{
		self.var_pers["mastery_camo"] = 1;
		self thread function_231f215a();
	}
}

/*
	Name: function_5e4556db
	Namespace: namespace_97ac1184
	Checksum: 0x424F4353
	Offset: 0x17360
	Size: 0x1B8
	Parameters: 0
	Flags: None
	Line Number: 4616
*/
function function_5e4556db()
{
	for(;;)
	{
		wait(1);
		var_accuracy = 0;
		var_total_shots = self.var_pers["total_shots"] - self.var_pers["end_game_total_shots"];
		var_total_hits = self.var_pers["hits"] - self.var_pers["end_game_total_hits"];
		var_acdca88c = self.var_pers["misses"] - self.var_pers["end_game_total_misses"];
		var_4ecb4534 = 0;
		if(var_total_shots > 0)
		{
			var_accuracy = var_total_hits / var_total_shots * 100;
		}
		wait(1);
		self thread function_7e18304e("spx_end_game_save_data", "end_game_total_shots", var_total_shots, 1);
		self thread function_7e18304e("spx_end_game_save_data", "end_game_total_hits", var_total_hits, 1);
		self thread function_7e18304e("spx_end_game_save_data", "end_game_total_misses", var_acdca88c, 1);
		self thread function_7e18304e("spx_end_game_save_data", "end_game_accuracy", function_Int(var_accuracy), 1);
	}
}

/*
	Name: function_7eb13385
	Namespace: namespace_97ac1184
	Checksum: 0x424F4353
	Offset: 0x17520
	Size: 0xF8
	Parameters: 0
	Flags: None
	Line Number: 4648
*/
function function_7eb13385()
{
	level endon("hash_end_game");
	level namespace_flag::function_init("between_round");
	wait(0.05);
	for(;;)
	{
		var_result = level namespace_util::function_waittill_any_return("start_of_round", "end_of_round");
		if(var_result == "start_of_round")
		{
			level.var_974310f = 0;
			level namespace_flag::function_clear("between_round");
		}
		else
		{
			level namespace_flag::function_set("between_round");
			if(level.var_round_number < 255)
			{
				level.var_dc0909ef = level.var_round_number;
			}
			else
			{
				level.var_dc0909ef++;
			}
		}
	}
}

/*
	Name: function_e67bbb8
	Namespace: namespace_97ac1184
	Checksum: 0x424F4353
	Offset: 0x17620
	Size: 0x130
	Parameters: 0
	Flags: None
	Line Number: 4686
*/
function function_e67bbb8()
{
	level endon("hash_end_game");
	self endon("hash_disconnect");
	self thread function_a48f6a30();
	self thread function_72799f99();
	for(;;)
	{
		var_result = level namespace_util::function_waittill_any_return("start_of_round", "end_of_round");
		if(var_result == "start_of_round")
		{
			var_start_time = GetTime();
		}
		else
		{
			self.var_d9a9d5d8 = 0;
			var_end_time = GetTime();
			var_elapsed_time = var_end_time - var_start_time;
			self thread function_8c165b4d("Data", "RoundTimerLast", var_elapsed_time / 1000);
			self thread function_8c165b4d("Data", "roundsPlayed", level.var_dc0909ef + 1);
		}
	}
}

/*
	Name: function_72799f99
	Namespace: namespace_97ac1184
	Checksum: 0x424F4353
	Offset: 0x17758
	Size: 0x30
	Parameters: 0
	Flags: None
	Line Number: 4720
*/
function function_72799f99()
{
	while(!isdefined(level.var_round_number))
	{
		wait(1);
	}
	level.var_dc0909ef = level.var_round_number;
}

/*
	Name: function_a48f6a30
	Namespace: namespace_97ac1184
	Checksum: 0x424F4353
	Offset: 0x17790
	Size: 0x70
	Parameters: 0
	Flags: None
	Line Number: 4739
*/
function function_a48f6a30()
{
	level endon("hash_end_game");
	self endon("hash_disconnect");
	for(;;)
	{
		wait(0.1 * self function_GetEntityNumber() + 1);
		self thread function_8c165b4d("Data", "RoundTimerCurrent", level.var_974310f);
	}
}

/*
	Name: function_a485c61f
	Namespace: namespace_97ac1184
	Checksum: 0x424F4353
	Offset: 0x17808
	Size: 0x48
	Parameters: 0
	Flags: None
	Line Number: 4760
*/
function function_a485c61f()
{
	while(level namespace_flag::function_get("between_round"))
	{
		wait(0.1);
		continue;
		wait(1);
		level.var_974310f++;
	}
}

/*
	Name: function_8c165b4d
	Namespace: namespace_97ac1184
	Checksum: 0x424F4353
	Offset: 0x17858
	Size: 0x1B8
	Parameters: 5
	Flags: None
	Line Number: 4781
*/
function function_8c165b4d(var_type, var_uimodel, var_value, var_priority, var_363c7886)
{
	if(!isdefined(var_priority))
	{
		var_priority = 0;
	}
	if(!isdefined(var_363c7886))
	{
		var_363c7886 = 0;
	}
	if(!isdefined(var_value))
	{
		var_value = 0;
	}
	if(!isdefined(self.var_29ffc8dc))
	{
		self.var_29ffc8dc = [];
	}
	if(!isdefined(self.var_4dd2bcd7))
	{
		self.var_4dd2bcd7 = [];
	}
	var_key = var_uimodel;
	if(isdefined(var_363c7886) && var_363c7886)
	{
		var_key = var_uimodel + function_randomIntRange(0, 1000000);
	}
	var_535f7585 = function_spawnstruct();
	var_535f7585.var_type = var_type;
	var_535f7585.var_uimodel = var_uimodel;
	var_535f7585.var_value = var_value;
	var_535f7585.var_priority = var_priority;
	if(isdefined(var_363c7886) && var_363c7886)
	{
		var_535f7585.var_Randomized = var_key;
	}
	if(isdefined(var_priority) && var_priority)
	{
		self.var_4dd2bcd7[var_key] = var_535f7585;
	}
	else
	{
		self.var_29ffc8dc[var_key] = var_535f7585;
	}
}

/*
	Name: function_d81f9d2b
	Namespace: namespace_97ac1184
	Checksum: 0x424F4353
	Offset: 0x17A18
	Size: 0x4C8
	Parameters: 0
	Flags: None
	Line Number: 4837
*/
function function_d81f9d2b()
{
	self endon("hash_disconnect");
	self.var_f1fce0a6 = 0;
	for(;;)
	{
		wait(0.05);
		while(self.var_4dd2bcd7.size > 0 || self.var_29ffc8dc.size > 0)
		{
			if(!(isdefined(self.var_f1fce0a6) && self.var_f1fce0a6))
			{
				while(self.var_4dd2bcd7.size > 0)
				{
					foreach(var_data in self.var_4dd2bcd7)
					{
						if(!isdefined(var_data.var_type) || !isdefined(var_data.var_uimodel) || !isdefined(var_data.var_value))
						{
							continue;
						}
						namespace_util::function_setClientSysState("UEM." + var_data.var_type, var_data.var_uimodel + "," + var_data.var_value, self);
						if(isdefined(var_data.var_Randomized))
						{
							self.var_4dd2bcd7[var_data.var_Randomized] = undefined;
						}
						else
						{
							self.var_4dd2bcd7[var_data.var_uimodel] = undefined;
						}
						if(isdefined(self.var_is_hotjoining) && self.var_is_hotjoining || function_ToLower(function_GetDvarString("mapname")) == "zm_shoothouse" || function_ToLower(function_GetDvarString("mapname")) == "zm_irondragon")
						{
							wait(0.1 * self function_GetEntityNumber() + 1);
							continue;
						}
						wait(0.07 * self function_GetEntityNumber() + 1);
					}
				}
				foreach(var_data in self.var_29ffc8dc)
				{
					if(self.var_4dd2bcd7.size > 0)
					{
						break;
					}
					if(!isdefined(var_data.var_type) || !isdefined(var_data.var_uimodel) || !isdefined(var_data.var_value))
					{
						continue;
					}
					namespace_util::function_setClientSysState("UEM." + var_data.var_type, var_data.var_uimodel + "," + var_data.var_value, self);
					if(isdefined(var_data.var_Randomized))
					{
						self.var_29ffc8dc[var_data.var_Randomized] = undefined;
					}
					else
					{
						self.var_29ffc8dc[var_data.var_uimodel] = undefined;
					}
					if(isdefined(self.var_is_hotjoining) && self.var_is_hotjoining || function_ToLower(function_GetDvarString("mapname")) == "zm_shoothouse" || function_ToLower(function_GetDvarString("mapname")) == "zm_irondragon")
					{
						wait(0.25 * self function_GetEntityNumber() + 1);
						continue;
					}
					wait(0.06 * self function_GetEntityNumber() + 1);
				}
			}
			else
			{
				wait(1);
			}
		}
	}
}

/*
	Name: function_8ee80db0
	Namespace: namespace_97ac1184
	Checksum: 0x424F4353
	Offset: 0x17EE8
	Size: 0x128
	Parameters: 2
	Flags: Private
	Line Number: 4918
*/
function private function_8ee80db0(var_mode_name, var_d0243e5b)
{
	if(isdefined(level.var_3e85df60) && level.var_3e85df60)
	{
		function_SetDvar("live_steam_server_name", "^8[UEM BAREBONES] | ^9" + var_mode_name + "^7 - ^3Round:^7 " + level.var_round_number);
		function_SetDvar("live_steam_server_description", "^8[UEM BAREBONES]^7 " + var_d0243e5b + " \n^9- " + function_GetPlayers().size + ": Players");
	}
	else
	{
		function_SetDvar("live_steam_server_name", "^8[UEM] | ^9" + var_mode_name + "^7 - ^3Round:^7 " + level.var_round_number);
		function_SetDvar("live_steam_server_description", "^8[UEM]^7 " + var_d0243e5b + " \n^9- " + function_GetPlayers().size + ": Players");
	}
}

/*
	Name: function_c72f6f99
	Namespace: namespace_97ac1184
	Checksum: 0x424F4353
	Offset: 0x18018
	Size: 0x1700
	Parameters: 0
	Flags: Private
	Line Number: 4942
*/
function private function_c72f6f99()
{
	for(;;)
	{
		level waittill("hash_end_of_round");
		if(!isdefined(level.var_d6ab4536))
		{
			level.var_d6ab4536 = [];
		}
		if(level namespace_flag::function_get("classic_enabled"))
		{
			level.var_d6ab4536["mode_name"] = "Classic Mode (BO1/WaW)";
			level.var_d6ab4536["mode_description"] = "Play like in the good old BO1/WaW days!";
			function_SetDvar("motd", "!" + function_ToLower(function_GetDvarString("mapname")) + "; Classic Mode (BO1/WaW);");
		}
		else if(level namespace_flag::function_get("gun_game_active"))
		{
			level.var_d6ab4536["mode_name"] = "Gun Game";
			level.var_d6ab4536["mode_description"] = "Let's play Gun Game!";
			function_SetDvar("motd", "!" + function_ToLower(function_GetDvarString("mapname")) + "; Gun Game;");
		}
		else
		{
			level.var_d6ab4536["mode_name"] = "Regular Mode";
			level.var_d6ab4536["mode_description"] = "Play as usual in regular mode.";
			function_SetDvar("motd", "!" + function_ToLower(function_GetDvarString("mapname")) + "; Regular Mode;");
		}
		level thread function_8ee80db0(level.var_d6ab4536["mode_name"], level.var_d6ab4536["mode_description"]);
		foreach(var_player in function_GetPlayers())
		{
			if(!(isdefined(var_player.var_c6452f46["leveling"]) && var_player.var_c6452f46["leveling"]))
			{
				continue;
			}
			if(function_ToLower(function_GetDvarString("mapname")) == "zm_moon")
			{
				if(isdefined(level.var_ever_been_on_the_moon) && (isdefined(level.var_ever_been_on_the_moon) && level.var_ever_been_on_the_moon))
				{
					var_player.var_9ee9bcc6++;
				}
			}
			else
			{
				var_player.var_9ee9bcc6++;
			}
			wait(0.05);
			if(level.var_fcee636 == "motd")
			{
				var_player notify("hash_63cf7d21", "map0_motd_rounds", 1, 65, 50000, 10);
			}
			else if(level.var_fcee636 == "spxskyblock")
			{
				var_player notify("hash_63cf7d21", "map0_skyblock_rounds", 1, 45, 35000, 20);
			}
			wait(0.05);
			if(var_player.var_9ee9bcc6 >= 35)
			{
				if(!(isdefined(var_player.var_db653ff8) && var_player.var_db653ff8))
				{
					if(var_player.var_pers["cc2_round_grinder"] < 5)
					{
						var_player.var_db653ff8 = 1;
						wait(0.05);
					}
				}
			}
			wait(0.05);
			var_player.var_pers["total_rounds"]++;
			var_player thread function_7e18304e("spx_end_game_save_data", "end_game_total_rounds", 1, 0);
			var_player thread function_7e18304e("spx_save_data", "total_rounds", var_player.var_pers["total_rounds"], 0);
			if(var_player.var_9ee9bcc6 > var_player.var_pers["highest_round"])
			{
				var_player.var_pers["highest_round"] = var_player.var_9ee9bcc6 + 1;
				var_player thread function_7e18304e("spx_save_data", "highest_round", var_player.var_pers["highest_round"], 0);
			}
			level notify("hash_8c3d4295", var_player, "total_rounds", 1, 0);
			wait(0.05);
			if(var_player.var_9ee9bcc6 > var_player.var_pers[level.var_fcee636 + "_highest_round"])
			{
				level notify("hash_8c3d4295", var_player, "highest_round", var_player.var_9ee9bcc6 + 1, 1);
			}
			switch(var_player.var_9ee9bcc6)
			{
				case 9:
				{
					var_player notify("hash_79ef118b", "milestone_completed_round_10", undefined);
					var_player thread function_b3489bf5("^3" + var_player.var_playerName + "^7 achieved ^9Round 10 Milestone");
					break;
				}
				case 14:
				{
					var_player notify("hash_79ef118b", "milestone_completed_round_15", undefined);
					var_player thread function_b3489bf5("^3" + var_player.var_playerName + "^7 achieved ^9Round 15 Milestone");
					break;
				}
				case 19:
				{
					var_player notify("hash_79ef118b", "milestone_completed_round_20", undefined);
					var_player thread function_b3489bf5("^3" + var_player.var_playerName + "^7 achieved ^9Round 20 Milestone");
					break;
				}
				case 24:
				{
					var_player notify("hash_79ef118b", "milestone_completed_round_25", undefined);
					var_player thread function_b3489bf5("^3" + var_player.var_playerName + "^7 achieved ^9Round 25 Milestone");
					break;
				}
				case 29:
				{
					var_player notify("hash_79ef118b", "milestone_completed_round_30", undefined);
					var_player thread function_b3489bf5("^3" + var_player.var_playerName + "^7 achieved ^9Round 30 Milestone");
					break;
				}
				case 34:
				{
					var_player notify("hash_79ef118b", "milestone_completed_round_35", undefined);
					var_player thread function_b3489bf5("^3" + var_player.var_playerName + "^7 achieved ^9Round 35 Milestone");
					break;
				}
				case 39:
				{
					var_player notify("hash_79ef118b", "milestone_completed_round_40", undefined);
					var_player thread function_b3489bf5("^3" + var_player.var_playerName + "^7 achieved ^9Round 40 Milestone");
					break;
				}
				case 44:
				{
					var_player notify("hash_79ef118b", "milestone_completed_round_45", undefined);
					var_player thread function_b3489bf5("^3" + var_player.var_playerName + "^7 achieved ^9Round 45 Milestone");
					break;
				}
				case 49:
				{
					var_player notify("hash_79ef118b", "milestone_completed_round_50", undefined);
					var_player thread function_b3489bf5("^3" + var_player.var_playerName + "^7 achieved ^9Round 50 Milestone");
					break;
				}
				case 54:
				{
					var_player notify("hash_79ef118b", "milestone_completed_round_55", undefined);
					var_player thread function_b3489bf5("^3" + var_player.var_playerName + "^7 achieved ^9Round 55 Milestone");
					break;
				}
				case 59:
				{
					var_player notify("hash_79ef118b", "milestone_completed_round_60", undefined);
					var_player thread function_b3489bf5("^3" + var_player.var_playerName + "^7 achieved ^9Round 60 Milestone");
					break;
				}
				case 64:
				{
					var_player notify("hash_79ef118b", "milestone_completed_round_65", undefined);
					var_player thread function_b3489bf5("^3" + var_player.var_playerName + "^7 achieved ^9Round 65 Milestone");
					break;
				}
				case 69:
				{
					var_player notify("hash_79ef118b", "milestone_completed_round_70", undefined);
					var_player thread function_b3489bf5("^3" + var_player.var_playerName + "^7 achieved ^9Round 70 Milestone");
					break;
				}
				case 74:
				{
					var_player notify("hash_79ef118b", "milestone_completed_round_75", undefined);
					var_player thread function_b3489bf5("^3" + var_player.var_playerName + "^7 achieved ^9Round 75 Milestone");
					break;
				}
				case 79:
				{
					var_player notify("hash_79ef118b", "milestone_completed_round_80", undefined);
					var_player thread function_b3489bf5("^3" + var_player.var_playerName + "^7 achieved ^9Round 80 Milestone");
					break;
				}
				case 84:
				{
					var_player notify("hash_79ef118b", "milestone_completed_round_85", undefined);
					var_player thread function_b3489bf5("^3" + var_player.var_playerName + "^7 achieved ^9Round 85 Milestone");
					break;
				}
				case 89:
				{
					var_player notify("hash_79ef118b", "milestone_completed_round_90", undefined);
					var_player thread function_b3489bf5("^3" + var_player.var_playerName + "^7 achieved ^9Round 90 Milestone");
					break;
				}
				case 94:
				{
					var_player notify("hash_79ef118b", "milestone_completed_round_95", undefined);
					var_player thread function_b3489bf5("^3" + var_player.var_playerName + "^7 achieved ^9Round 95 Milestone");
					break;
				}
				case 99:
				{
					var_player notify("hash_79ef118b", "milestone_completed_round_100", undefined);
					var_player thread function_b3489bf5("^3" + var_player.var_playerName + "^7 achieved ^9Round 100 Milestone");
					break;
				}
				case 104:
				{
					var_player notify("hash_79ef118b", "milestone_completed_round_105", undefined);
					var_player thread function_b3489bf5("^3" + var_player.var_playerName + "^7 achieved ^9Round 105 Milestone");
					break;
				}
				case 109:
				{
					var_player notify("hash_79ef118b", "milestone_completed_round_110", undefined);
					var_player thread function_b3489bf5("^3" + var_player.var_playerName + "^7 achieved ^9Round 110 Milestone");
					break;
				}
				case 114:
				{
					var_player notify("hash_79ef118b", "milestone_completed_round_115", undefined);
					var_player thread function_b3489bf5("^3" + var_player.var_playerName + "^7 achieved ^9Round 115 Milestone");
					break;
				}
				case 119:
				{
					var_player notify("hash_79ef118b", "milestone_completed_round_120", undefined);
					var_player thread function_b3489bf5("^3" + var_player.var_playerName + "^7 achieved ^9Round 120 Milestone");
					break;
				}
				case 124:
				{
					var_player notify("hash_79ef118b", "milestone_completed_round_125", undefined);
					var_player thread function_b3489bf5("^3" + var_player.var_playerName + "^7 achieved ^9Round 125 Milestone");
					break;
				}
				case 129:
				{
					var_player notify("hash_79ef118b", "milestone_completed_round_130", undefined);
					var_player thread function_b3489bf5("^3" + var_player.var_playerName + "^7 achieved ^9Round 130 Milestone");
					break;
				}
				case 134:
				{
					var_player notify("hash_79ef118b", "milestone_completed_round_135", undefined);
					var_player thread function_b3489bf5("^3" + var_player.var_playerName + "^7 achieved ^9Round 135 Milestone");
					break;
				}
				case 139:
				{
					var_player notify("hash_79ef118b", "milestone_completed_round_140", undefined);
					var_player thread function_b3489bf5("^3" + var_player.var_playerName + "^7 achieved ^9Round 140 Milestone");
					break;
				}
				case 144:
				{
					var_player notify("hash_79ef118b", "milestone_completed_round_145", undefined);
					var_player thread function_b3489bf5("^3" + var_player.var_playerName + "^7 achieved ^9Round 145 Milestone");
					break;
				}
				case 149:
				{
					var_player notify("hash_79ef118b", "milestone_completed_round_150", undefined);
					var_player thread function_b3489bf5("^3" + var_player.var_playerName + "^7 achieved ^9Round 150 Milestone");
					break;
				}
				case 154:
				{
					var_player notify("hash_79ef118b", "milestone_completed_round_155", undefined);
					var_player thread function_b3489bf5("^3" + var_player.var_playerName + "^7 achieved ^9Round 155 Milestone");
					break;
				}
				case 159:
				{
					var_player notify("hash_79ef118b", "milestone_completed_round_160", undefined);
					var_player thread function_b3489bf5("^3" + var_player.var_playerName + "^7 achieved ^9Round 160 Milestone");
					break;
				}
				case 164:
				{
					var_player notify("hash_79ef118b", "milestone_completed_round_165", undefined);
					var_player thread function_b3489bf5("^3" + var_player.var_playerName + "^7 achieved ^9Round 165 Milestone");
					break;
				}
				case 169:
				{
					var_player notify("hash_79ef118b", "milestone_completed_round_170", undefined);
					var_player thread function_b3489bf5("^3" + var_player.var_playerName + "^7 achieved ^9Round 170 Milestone");
					break;
				}
				case 174:
				{
					var_player notify("hash_79ef118b", "milestone_completed_round_175", undefined);
					var_player thread function_b3489bf5("^3" + var_player.var_playerName + "^7 achieved ^9Round 175 Milestone");
					break;
				}
				case 179:
				{
					var_player notify("hash_79ef118b", "milestone_completed_round_180", undefined);
					var_player thread function_b3489bf5("^3" + var_player.var_playerName + "^7 achieved ^9Round 180 Milestone");
					break;
				}
				case 184:
				{
					var_player notify("hash_79ef118b", "milestone_completed_round_185", undefined);
					var_player thread function_b3489bf5("^3" + var_player.var_playerName + "^7 achieved ^9Round 185 Milestone");
					break;
				}
				case 189:
				{
					var_player notify("hash_79ef118b", "milestone_completed_round_190", undefined);
					var_player thread function_b3489bf5("^3" + var_player.var_playerName + "^7 achieved ^9Round 190 Milestone");
					break;
				}
				case 194:
				{
					var_player notify("hash_79ef118b", "milestone_completed_round_195", undefined);
					var_player thread function_b3489bf5("^3" + var_player.var_playerName + "^7 achieved ^9Round 195 Milestone");
					break;
				}
				case 199:
				{
					var_player notify("hash_79ef118b", "milestone_completed_round_200", undefined);
					var_player thread function_b3489bf5("^3" + var_player.var_playerName + "^7 achieved ^9Round 200 Milestone");
					break;
				}
				case 204:
				{
					var_player notify("hash_79ef118b", "milestone_completed_round_205", undefined);
					var_player thread function_b3489bf5("^3" + var_player.var_playerName + "^7 achieved ^9Round 205 Milestone");
					break;
				}
				case 209:
				{
					var_player notify("hash_79ef118b", "milestone_completed_round_210", undefined);
					var_player thread function_b3489bf5("^3" + var_player.var_playerName + "^7 achieved ^9Round 210 Milestone");
					break;
				}
				case 214:
				{
					var_player notify("hash_79ef118b", "milestone_completed_round_215", undefined);
					var_player thread function_b3489bf5("^3" + var_player.var_playerName + "^7 achieved ^9Round 215 Milestone");
					break;
				}
				case 219:
				{
					var_player notify("hash_79ef118b", "milestone_completed_round_220", undefined);
					var_player thread function_b3489bf5("^3" + var_player.var_playerName + "^7 achieved ^9Round 220 Milestone");
					break;
				}
				case 224:
				{
					var_player notify("hash_79ef118b", "milestone_completed_round_225", undefined);
					var_player thread function_b3489bf5("^3" + var_player.var_playerName + "^7 achieved ^9Round 225 Milestone");
					break;
				}
				case 229:
				{
					var_player notify("hash_79ef118b", "milestone_completed_round_230", undefined);
					var_player thread function_b3489bf5("^3" + var_player.var_playerName + "^7 achieved ^9Round 230 Milestone");
					break;
				}
				case 244:
				{
					var_player notify("hash_79ef118b", "milestone_completed_round_245", undefined);
					var_player thread function_b3489bf5("^3" + var_player.var_playerName + "^7 achieved ^9Round 245 Milestone");
					break;
				}
				case 249:
				{
					var_player notify("hash_79ef118b", "milestone_completed_round_250", undefined);
					var_player thread function_b3489bf5("^3" + var_player.var_playerName + "^7 achieved ^9Round 250 Milestone");
					break;
				}
				case 254:
				{
					var_player notify("hash_79ef118b", "milestone_completed_round_255", undefined);
					var_player thread function_b3489bf5("^3" + var_player.var_playerName + "^7 achieved ^9Round 255 Milestone");
					break;
				}
			}
			var_player notify("hash_79ef118b", "round_survived", undefined);
			wait(0.05);
			level thread function_231f215a();
		}
	}
}

/*
	Name: function_b3e51832
	Namespace: namespace_97ac1184
	Checksum: 0x424F4353
	Offset: 0x19720
	Size: 0x78
	Parameters: 0
	Flags: None
	Line Number: 5331
*/
function function_b3e51832()
{
	self notify("hash_7bd8175e");
	self endon("hash_7bd8175e");
	if(self.var_ade72574 >= 3)
	{
		self notify("hash_63cf7d21", "cc2_rapid_mayhem", 1, 2500, 60000, 10);
		self.var_ade72574 = 0;
	}
	wait(0.7);
	self.var_ade72574 = 0;
}

/*
	Name: function_9da0752e
	Namespace: namespace_97ac1184
	Checksum: 0x424F4353
	Offset: 0x197A0
	Size: 0x78
	Parameters: 0
	Flags: None
	Line Number: 5354
*/
function function_9da0752e()
{
	self notify("hash_35e4614a");
	self endon("hash_35e4614a");
	if(self.var_39a05cc0 >= 2)
	{
		self notify("hash_63cf7d21", "cc2_consecutive_headshot_master", 1, 1500, 45000, 30);
		self.var_39a05cc0 = 0;
	}
	wait(0.7);
	self.var_39a05cc0 = 0;
}

/*
	Name: function_b01c4441
	Namespace: namespace_97ac1184
	Checksum: 0x424F4353
	Offset: 0x19820
	Size: 0x78
	Parameters: 2
	Flags: None
	Line Number: 5377
*/
function function_b01c4441(var_e_attacker, var_weapClass)
{
	if(level.var_fcee636 == "motd")
	{
		self thread function_eddfc972(var_e_attacker);
	}
	else if(level.var_fcee636 == "spxskyblock")
	{
		self thread function_78664843(var_e_attacker);
		return;
	}
	ERROR: Exception occured: Stack empty.
}

/*
	Name: function_78664843
	Namespace: namespace_97ac1184
	Checksum: 0x424F4353
	Offset: 0x198A0
	Size: 0x318
	Parameters: 1
	Flags: None
	Line Number: 5401
*/
function function_78664843(var_e_attacker)
{
	wait(0.05);
	var_e_attacker notify("hash_63cf7d21", "map0_skyblock_kills", 1, 5000, 125000, 15);
	wait(0.05);
	if(self.var_damagelocation === "head" && (!(isdefined(self.var_isdog) && self.var_isdog)) || (self.var_damagelocation === "helmet" && (!(isdefined(self.var_isdog) && self.var_isdog))) || (self.var_damageMod === "MOD_HEAD_SHOT" && (!(isdefined(self.var_isdog) && self.var_isdog))))
	{
		var_e_attacker notify("hash_63cf7d21", "map0_skyblock_headshots", 1, 1500, 75000, 350);
	}
	wait(0.05);
	var_str_zone = var_e_attacker namespace_zm_zonemgr::function_get_player_zone();
	if(var_str_zone == "player_two_zone")
	{
		var_e_attacker notify("hash_63cf7d21", "map0_skyblock_end_kills", 1, 1500, 25000, 15);
	}
	else if(var_str_zone == "player_five_zone")
	{
		var_e_attacker notify("hash_63cf7d21", "map0_skyblock_desert_kills", 1, 1250, 22500, 15);
	}
	else if(var_str_zone == "pap_zone")
	{
		var_e_attacker notify("hash_63cf7d21", "map0_skyblock_enchantment_ritual_kills", 1, 1000, 20000, 15);
	}
	else if(var_str_zone == "player_seven_zone")
	{
		var_e_attacker notify("hash_63cf7d21", "map0_skyblock_wildlands_kills", 1, 1750, 30000, 15);
	}
	wait(0.05);
	if(function_Distance(self.var_origin, var_e_attacker.var_origin) > 700)
	{
		var_e_attacker notify("hash_63cf7d21", "map0_skyblock_longshots", 1, 1200, 35000, 15);
	}
	wait(0.05);
	if(var_e_attacker function_PlayerAds() >= 0.9)
	{
		var_e_attacker notify("hash_63cf7d21", "map0_skyblock_ads", 1, 1250, 55000, 15);
	}
	wait(0.05);
	if(namespace_zm_weapons::function_is_weapon_upgraded(self.var_damageWeapon))
	{
		var_e_attacker notify("hash_63cf7d21", "map0_skyblock_enchantment", 1, 2500, 60000, 10);
	}
	wait(0.05);
}

/*
	Name: function_eddfc972
	Namespace: namespace_97ac1184
	Checksum: 0x424F4353
	Offset: 0x19BC0
	Size: 0x528
	Parameters: 1
	Flags: None
	Line Number: 5456
*/
function function_eddfc972(var_e_attacker)
{
	wait(0.05);
	var_e_attacker notify("hash_63cf7d21", "map0_motd_kills", 1, 1500, 75000, 15);
	wait(0.05);
	if(self.var_damagelocation === "head" && (!(isdefined(self.var_isdog) && self.var_isdog)) || (self.var_damagelocation === "helmet" && (!(isdefined(self.var_isdog) && self.var_isdog))) || (self.var_damageMod === "MOD_HEAD_SHOT" && (!(isdefined(self.var_isdog) && self.var_isdog))))
	{
		var_e_attacker notify("hash_63cf7d21", "map0_motd_headshots", 1, 750, 75000, 350);
	}
	wait(0.05);
	if(var_e_attacker.var_afterlife)
	{
		level notify("hash_8c3d4295", var_e_attacker, "afterlife_kills", 1, 0);
	}
	wait(0.05);
	if(function_IsSubStr(self.var_damageWeapon.var_name, "t8_blundergat") || function_IsSubStr(self.var_damageWeapon.var_name, "t8_blundersplat") || function_IsSubStr(self.var_damageWeapon.var_name, "t8_magmagat") || function_IsSubStr(self.var_damageWeapon.var_name, "t8_blundersplat_bullet"))
	{
		level notify("hash_8c3d4295", var_e_attacker, "blundergat_kills", 1, 0);
		wait(0.05);
		var_e_attacker notify("hash_63cf7d21", "map0_motd_blundergat", 1, 250, 70000, 15);
	}
	wait(0.05);
	if(function_IsSubStr(self.var_damageWeapon.var_name, "spork_zm_alcatraz"))
	{
		level notify("hash_8c3d4295", var_e_attacker, "golden_spork_kills", 1, 0);
	}
	wait(0.05);
	if(function_IsSubStr(self.var_damageWeapon.var_name, "t6_bouncing_tomahawk") || function_IsSubStr(self.var_damageWeapon.var_name, "t6_upgraded_tomahawk"))
	{
		level notify("hash_8c3d4295", var_e_attacker, "hells_retriever_kills", 1, 0);
		wait(0.05);
		var_e_attacker notify("hash_63cf7d21", "map0_motd_hells_retriever", 1, 100, 50000, 10);
	}
	wait(0.05);
	if(self.var_archetype == "brutus")
	{
		level notify("hash_8c3d4295", var_e_attacker, "warden_kills", 1, 0);
		wait(0.05);
		var_e_attacker notify("hash_63cf7d21", "map0_motd_warden_kills", 1, 10, 80000, 15);
	}
	wait(0.05);
	var_str_zone = var_e_attacker namespace_zm_zonemgr::function_get_player_zone();
	if(var_str_zone == "z_bridge")
	{
		var_e_attacker notify("hash_63cf7d21", "map0_motd_bridge_kills", 1, 500, 95000, 10);
	}
	wait(0.05);
	if(namespace_zm_weapons::function_is_weapon_upgraded(self.var_damageWeapon))
	{
		var_e_attacker notify("hash_63cf7d21", "map0_motd_enchantment_kills", 1, 1500, 75000, 10);
		wait(0.05);
		if(var_e_attacker.var_pers["map0_motd_enchantment_kills"] >= 1500)
		{
			var_e_attacker notify("hash_63cf7d21", "map0_motd_enchantment_kills_2", 1, 10000, 135000, 250, "motd_camo_2");
			wait(0.05);
			if(var_e_attacker.var_pers["map0_motd_enchantment_kills_2"] >= 10000)
			{
				var_e_attacker notify("hash_63cf7d21", "map0_motd_enchantment_kills_3", 1, 235000, 235000, 1000, "motd_camo_3");
				wait(0.05);
			}
		}
	}
	wait(0.05);
}

/*
	Name: function_7279da56
	Namespace: namespace_97ac1184
	Checksum: 0x424F4353
	Offset: 0x1A0F0
	Size: 0x2008
	Parameters: 1
	Flags: Private
	Line Number: 5531
*/
function private function_7279da56(var_e_attacker)
{
	if(!isdefined(var_e_attacker) || !function_isPlayer(var_e_attacker) || (isdefined(self.var_nuked) && self.var_nuked))
	{
		return;
	}
	if(!(isdefined(var_e_attacker.var_c6452f46["leveling"]) && var_e_attacker.var_c6452f46["leveling"]))
	{
		return;
	}
	var_weapClass = namespace_util::function_getWeaponClass(self.var_damageWeapon);
	if(isdefined(self.var_42397ab9))
	{
		foreach(var_player in self.var_42397ab9)
		{
			if(var_player != var_e_attacker)
			{
				var_archetype = 0;
				switch(self.var_archetype)
				{
					case "keeper":
					{
						var_archetype = 1;
						var_player notify("hash_79ef118b", "zombie_keeper_assist", undefined, self);
						break;
					}
					case "keeper_companion":
					{
						var_archetype = 1;
						var_player notify("hash_79ef118b", "zombie_keeper_assist", undefined, self);
						break;
					}
					case "zod_companion":
					{
						var_archetype = 1;
						var_player notify("hash_79ef118b", "zombie_keeper_assist", undefined, self);
						break;
					}
					case "apothicon_fury":
					{
						var_archetype = 1;
						var_player notify("hash_79ef118b", "zombie_apothicon_assist", undefined, self);
						break;
					}
					case "parasite":
					{
						var_archetype = 1;
						var_player notify("hash_79ef118b", "zombie_parasite_assist", undefined, self);
						break;
					}
					case "raps":
					{
						var_archetype = 1;
						var_player notify("hash_79ef118b", "zombie_raps_assist", undefined, self);
						break;
					}
					case "spider":
					{
						var_archetype = 1;
						var_player notify("hash_79ef118b", "zombie_spider_assist", undefined, self);
						break;
					}
					case "mechz":
					{
						var_archetype = 1;
						var_player notify("hash_79ef118b", "zombie_mechz_assist", undefined, self);
						break;
					}
					case "zombie_quad":
					{
						var_archetype = 1;
						var_player notify("hash_79ef118b", "zombie_zombiequad_assist", undefined, self);
						break;
					}
					case "margwa":
					{
						var_archetype = 1;
						var_player notify("hash_79ef118b", "zombie_margwa_assist", undefined, self);
						break;
					}
					case "thrasher":
					{
						var_archetype = 1;
						var_player notify("hash_79ef118b", "zombie_thrasher_assist", undefined, self);
						break;
					}
					case "raz":
					{
						var_archetype = 1;
						var_player notify("hash_79ef118b", "zombie_raz_assist", undefined, self);
						break;
					}
					case "monkey":
					{
						var_archetype = 1;
						var_player notify("hash_79ef118b", "zombie_monkey_assist", undefined, self);
						break;
					}
					case "astronaut":
					{
						var_archetype = 1;
						var_player notify("hash_79ef118b", "zombie_astronaut_assist", undefined, self);
						break;
					}
					case "undead_saint":
					{
						var_archetype = 1;
						var_player notify("hash_79ef118b", "zombie_saint_assist", undefined, self);
						break;
					}
					case "uem_ghost":
					{
						var_archetype = 1;
						var_player notify("hash_79ef118b", "zombie_ghost_assist", undefined, self);
						break;
					}
				}
				if(isdefined(self.var_isdog) && self.var_isdog)
				{
					var_player notify("hash_79ef118b", "zombie_dog_assist", undefined, self);
				}
				else
				{
					var_player notify("hash_79ef118b", "zombie_regular_assist", undefined, self);
				}
				if(self.var_animName == "napalm_zombie")
				{
					var_player notify("hash_79ef118b", "zombie_napalm_assist", undefined, self);
				}
				if(self.var_animName == "sonic_zombie")
				{
					var_player notify("hash_79ef118b", "zombie_shrieker_assist", undefined, self);
				}
				var_player.var_pers["assists"]++;
				var_player thread function_7e18304e("spx_save_data", "assists", var_player.var_pers["assists"], 0);
			}
		}
	}
	var_e_attacker thread function_7e18304e("spx_end_game_save_data", "end_game_total_kills", 1, 0);
	var_e_attacker thread function_7e18304e("spx_save_data", "kills", var_e_attacker.var_pers["kills"], 0);
	level notify("hash_8c3d4295", var_e_attacker, "total_kills", 1, 0);
	wait(0.05);
	if(isdefined(level.var_c181264f) && level.var_c181264f)
	{
		var_e_attacker.var_pers["gungame_kills"]++;
		var_e_attacker thread function_7e18304e("spx_save_data", "gungame_kills", var_e_attacker.var_pers["gungame_kills"], 0);
	}
	self thread function_b01c4441(var_e_attacker, var_weapClass);
	var_e_attacker.var_pers["milestone_kills"]++;
	switch(var_e_attacker.var_pers["milestone_kills"])
	{
		case 500:
		{
			var_e_attacker notify("hash_79ef118b", "milestone_completed_kills_500", undefined);
			break;
		}
		case 750:
		{
			var_e_attacker notify("hash_79ef118b", "milestone_completed_kills_750", undefined);
			break;
		}
		case 1000:
		{
			var_e_attacker notify("hash_79ef118b", "milestone_completed_kills_1000", undefined);
			break;
		}
		case 1500:
		{
			var_e_attacker notify("hash_79ef118b", "milestone_completed_kills_1500", undefined);
			break;
		}
		case 2000:
		{
			var_e_attacker notify("hash_79ef118b", "milestone_completed_kills_2000", undefined);
			break;
		}
		case 3000:
		{
			var_e_attacker notify("hash_79ef118b", "milestone_completed_kills_3000", undefined);
			break;
		}
		case 4000:
		{
			var_e_attacker notify("hash_79ef118b", "milestone_completed_kills_4000", undefined);
			break;
		}
		case 5000:
		{
			var_e_attacker notify("hash_79ef118b", "milestone_completed_kills_5000", undefined);
			break;
		}
		case 7500:
		{
			var_e_attacker notify("hash_79ef118b", "milestone_completed_kills_7500", undefined);
			break;
		}
		case 10000:
		{
			var_e_attacker notify("hash_79ef118b", "milestone_completed_kills_10000", undefined);
			break;
		}
		case 15000:
		{
			var_e_attacker notify("hash_79ef118b", "milestone_completed_kills_15000", undefined);
			break;
		}
		case 20000:
		{
			var_e_attacker notify("hash_79ef118b", "milestone_completed_kills_20000", undefined);
			break;
		}
		case 30000:
		{
			var_e_attacker notify("hash_79ef118b", "milestone_completed_kills_30000", undefined);
			break;
		}
		case 40000:
		{
			var_e_attacker notify("hash_79ef118b", "milestone_completed_kills_40000", undefined);
			break;
		}
		case 50000:
		{
			var_e_attacker notify("hash_79ef118b", "milestone_completed_kills_50000", undefined);
			break;
		}
		case 75000:
		{
			var_e_attacker notify("hash_79ef118b", "milestone_completed_kills_75000", undefined);
			break;
		}
		case 100000:
		{
			var_e_attacker notify("hash_79ef118b", "milestone_completed_kills_100000", undefined);
			break;
		}
	}
	switch(self.var_archetype)
	{
		case "keeper":
		{
			var_e_attacker thread function_7e18304e("spx_end_game_save_data", "end_game_special_kills", 1, 0);
			var_e_attacker.var_pers["special_kills"]++;
			var_e_attacker notify("hash_79ef118b", "zombie_keeper_kill", undefined);
			var_c5f85509 = 1;
			return;
		}
		case "keeper_companion":
		{
			var_e_attacker thread function_7e18304e("spx_end_game_save_data", "end_game_special_kills", 1, 0);
			var_e_attacker.var_pers["special_kills"]++;
			var_archetype = 1;
			var_e_attacker notify("hash_79ef118b", "zombie_keeper_kill", undefined);
			var_c5f85509 = 1;
			break;
		}
		case "zod_companion":
		{
			var_e_attacker thread function_7e18304e("spx_end_game_save_data", "end_game_special_kills", 1, 0);
			var_e_attacker.var_pers["special_kills"]++;
			var_archetype = 1;
			var_e_attacker notify("hash_79ef118b", "zombie_keeper_kill", undefined);
			var_c5f85509 = 1;
			break;
		}
		case "apothicon_fury":
		{
			var_e_attacker thread function_7e18304e("spx_end_game_save_data", "end_game_special_kills", 1, 0);
			var_e_attacker.var_pers["special_kills"]++;
			var_e_attacker notify("hash_79ef118b", "zombie_apothicon_kill", undefined);
			var_c5f85509 = 1;
			return;
		}
		case "parasite":
		{
			var_e_attacker thread function_7e18304e("spx_end_game_save_data", "end_game_special_kills", 1, 0);
			var_e_attacker.var_pers["special_kills"]++;
			var_e_attacker notify("hash_79ef118b", "zombie_parasite_kill", undefined);
			var_c5f85509 = 1;
			return;
		}
		case "raps":
		{
			var_e_attacker thread function_7e18304e("spx_end_game_save_data", "end_game_special_kills", 1, 0);
			var_e_attacker.var_pers["special_kills"]++;
			var_e_attacker notify("hash_79ef118b", "zombie_raps_kill", undefined);
			var_c5f85509 = 1;
			return;
		}
		case "spider":
		{
			var_e_attacker thread function_7e18304e("spx_end_game_save_data", "end_game_special_kills", 1, 0);
			var_e_attacker.var_pers["special_kills"]++;
			var_e_attacker notify("hash_79ef118b", "zombie_spider_kill", undefined);
			var_c5f85509 = 1;
			return;
		}
		case "mechz":
		{
			var_e_attacker thread function_7e18304e("spx_end_game_save_data", "end_game_special_kills", 1, 0);
			var_e_attacker.var_pers["special_kills"]++;
			var_e_attacker notify("hash_79ef118b", "zombie_mechz_kill", undefined);
			var_c5f85509 = 1;
			return;
		}
		case "zombie_quad":
		{
			var_e_attacker thread function_7e18304e("spx_end_game_save_data", "end_game_special_kills", 1, 0);
			var_e_attacker.var_pers["special_kills"]++;
			var_e_attacker notify("hash_79ef118b", "zombie_zombiequad_kill", undefined);
			var_c5f85509 = 1;
			return;
		}
		case "margwa":
		{
			var_e_attacker thread function_7e18304e("spx_end_game_save_data", "end_game_special_kills", 1, 0);
			var_e_attacker.var_pers["special_kills"]++;
			var_e_attacker notify("hash_79ef118b", "zombie_margwa_kill", undefined);
			var_c5f85509 = 1;
			return;
		}
		case "thrasher":
		{
			var_e_attacker thread function_7e18304e("spx_end_game_save_data", "end_game_special_kills", 1, 0);
			var_e_attacker.var_pers["special_kills"]++;
			var_e_attacker notify("hash_79ef118b", "zombie_thrasher_kill", undefined);
			var_c5f85509 = 1;
			return;
		}
		case "raz":
		{
			var_e_attacker thread function_7e18304e("spx_end_game_save_data", "end_game_special_kills", 1, 0);
			var_e_attacker.var_pers["special_kills"]++;
			var_e_attacker notify("hash_79ef118b", "zombie_raz_kill", undefined);
			var_c5f85509 = 1;
			return;
		}
		case "monkey":
		{
			var_e_attacker thread function_7e18304e("spx_end_game_save_data", "end_game_special_kills", 1, 0);
			var_e_attacker.var_pers["special_kills"]++;
			var_e_attacker notify("hash_79ef118b", "zombie_monkey_kill", undefined);
			var_c5f85509 = 1;
			return;
		}
		case "astronaut":
		{
			var_e_attacker thread function_7e18304e("spx_end_game_save_data", "end_game_special_kills", 1, 0);
			var_e_attacker.var_pers["special_kills"]++;
			var_e_attacker notify("hash_79ef118b", "zombie_astronaut_kill", undefined);
			var_c5f85509 = 1;
			return;
		}
		case "undead_saint":
		{
			var_e_attacker thread function_7e18304e("spx_end_game_save_data", "end_game_special_kills", 1, 0);
			var_e_attacker.var_pers["special_kills"]++;
			var_player notify("hash_79ef118b", "zombie_saint_kill", undefined);
			var_c5f85509 = 1;
			break;
		}
		case "uem_ghost":
		{
			var_e_attacker thread function_7e18304e("spx_end_game_save_data", "end_game_special_kills", 1, 0);
			var_e_attacker.var_pers["special_kills"]++;
			var_player notify("hash_79ef118b", "zombie_ghost_kill", undefined);
			var_c5f85509 = 1;
			break;
		}
	}
	if(self.var_animName == "napalm_zombie")
	{
		var_e_attacker.var_pers["special_kills"]++;
		var_e_attacker thread function_7e18304e("spx_end_game_save_data", "end_game_special_kills", 1, 0);
		var_e_attacker notify("hash_79ef118b", "zombie_napalm_kill", undefined);
		var_c5f85509 = 1;
		return;
	}
	if(self.var_animName == "sonic_zombie")
	{
		var_e_attacker.var_pers["special_kills"]++;
		var_e_attacker thread function_7e18304e("spx_end_game_save_data", "end_game_special_kills", 1, 0);
		var_e_attacker notify("hash_79ef118b", "zombie_shrieker_kill", undefined);
		var_c5f85509 = 1;
		return;
	}
	if(self.var_damageMod === "MOD_MELEE" || self.var_damageMod === "MOD_MELEE_ASSASSINATE" || self.var_damageMod === "MOD_MELEE_WEAPON_BUTT")
	{
		var_e_attacker.var_pers["melee_kills"]++;
		var_e_attacker thread function_7e18304e("spx_end_game_save_data", "end_game_melee_kills", 1, 0);
		var_e_attacker thread function_7e18304e("spx_save_data", "melee_kills", var_e_attacker.var_pers["melee_kills"], 0);
		if(!(isdefined(self.var_isdog) && self.var_isdog) || (!(isdefined(var_c5f85509) && var_c5f85509)))
		{
			var_e_attacker notify("hash_79ef118b", "zombie_melee_kill", undefined, self);
		}
		else
		{
			var_e_attacker notify("hash_79ef118b", "zombie_melee_kill", undefined);
			return;
		}
	}
	if(self.var_damageWeapon.var_8c86d7b3 || self.var_damageWeapon.var_7e163cf8 || namespace_zm_equipment::function_is_equipment(self.var_damageWeapon) || namespace_zm_utility::function_is_placeable_mine(self.var_damageWeapon))
	{
		var_e_attacker.var_pers["equipment_kills"]++;
		var_e_attacker thread function_7e18304e("spx_end_game_save_data", "end_game_equipment_kills", 1, 0);
		var_e_attacker thread function_7e18304e("spx_save_data", "equipment_kills", var_e_attacker.var_pers["equipment_kills"], 0);
		if(!(isdefined(self.var_isdog) && self.var_isdog) || (!(isdefined(var_c5f85509) && var_c5f85509)))
		{
			var_e_attacker notify("hash_79ef118b", "zombie_equipment_kill", undefined);
		}
		else
		{
			var_e_attacker notify("hash_79ef118b", "zombie_equipment_kill", undefined);
			return;
		}
	}
	if(self.var_damagelocation === "head" && (!(isdefined(self.var_isdog) && self.var_isdog)) || (self.var_damagelocation === "helmet" && (!(isdefined(self.var_isdog) && self.var_isdog))) || (self.var_damageMod === "MOD_HEAD_SHOT" && (!(isdefined(self.var_isdog) && self.var_isdog))))
	{
		var_e_attacker.var_pers["headshots"]++;
		var_e_attacker thread function_7e18304e("spx_save_data", "headshots", var_e_attacker.var_pers["headshots"], 0);
		if(isdefined(level.var_c181264f) && level.var_c181264f)
		{
			var_e_attacker.var_pers["gungame_headshots"]++;
			var_e_attacker thread function_7e18304e("spx_save_data", "gungame_headshots", var_e_attacker.var_pers["gungame_headshots"], 0);
		}
		wait(0.05);
		level notify("hash_8c3d4295", var_e_attacker, "total_headshots", 1, 0);
		var_e_attacker thread function_7e18304e("spx_end_game_save_data", "end_game_headshot_kills", 1, 0);
		var_e_attacker.var_pers["milestone_headshots"]++;
		switch(var_e_attacker.var_pers["milestone_headshots"])
		{
			case 250:
			{
				var_e_attacker notify("hash_79ef118b", "milestone_completed_headshots_250", undefined);
				break;
			}
			case 500:
			{
				var_e_attacker notify("hash_79ef118b", "milestone_completed_headshots_500", undefined);
				break;
			}
			case 750:
			{
				var_e_attacker notify("hash_79ef118b", "milestone_completed_headshots_750", undefined);
				break;
			}
			case 1000:
			{
				var_e_attacker notify("hash_79ef118b", "milestone_completed_headshots_1000", undefined);
				break;
			}
			case 1250:
			{
				var_e_attacker notify("hash_79ef118b", "milestone_completed_headshots_1250", undefined);
				break;
			}
			case 1500:
			{
				var_e_attacker notify("hash_79ef118b", "milestone_completed_headshots_1500", undefined);
				break;
			}
			case 1750:
			{
				var_e_attacker notify("hash_79ef118b", "milestone_completed_headshots_1750", undefined);
				break;
			}
			case 2000:
			{
				var_e_attacker notify("hash_79ef118b", "milestone_completed_headshots_2000", undefined);
				break;
			}
			case 2500:
			{
				var_e_attacker notify("hash_79ef118b", "milestone_completed_headshots_2500", undefined);
				break;
			}
			case 3000:
			{
				var_e_attacker notify("hash_79ef118b", "milestone_completed_headshots_3000", undefined);
				break;
			}
			case 4000:
			{
				var_e_attacker notify("hash_79ef118b", "milestone_completed_headshots_4000", undefined);
				break;
			}
			case 5000:
			{
				var_e_attacker notify("hash_79ef118b", "milestone_completed_headshots_5000", undefined);
				break;
			}
			case 7500:
			{
				var_e_attacker notify("hash_79ef118b", "milestone_completed_headshots_7500", undefined);
				break;
			}
			case 10000:
			{
				var_e_attacker notify("hash_79ef118b", "milestone_completed_headshots_10000", undefined);
				break;
			}
			case 20000:
			{
				var_e_attacker notify("hash_79ef118b", "milestone_completed_headshots_20000", undefined);
				break;
			}
			case 30000:
			{
				var_e_attacker notify("hash_79ef118b", "milestone_completed_headshots_30000", undefined);
				break;
			}
			case 40000:
			{
				var_e_attacker notify("hash_79ef118b", "milestone_completed_headshots_40000", undefined);
				break;
			}
			case 50000:
			{
				var_e_attacker notify("hash_79ef118b", "milestone_completed_headshots_50000", undefined);
				break;
			}
		}
		if(!(isdefined(self.var_isdog) && self.var_isdog) || (!(isdefined(var_c5f85509) && var_c5f85509)))
		{
			if(isdefined(self.var_fc3ab987) && self.var_fc3ab987)
			{
				if(isdefined(self.var_2a280bef) && self.var_2a280bef)
				{
					if(var_e_attacker function_GetStance() == "prone")
					{
						var_e_attacker notify("hash_79ef118b", "zombie_heavy_armored_prone_critical_kill", undefined, self);
					}
					else if(var_e_attacker function_IsSliding())
					{
						var_e_attacker notify("hash_79ef118b", "zombie_heavy_armored_sliding_critical_kill", undefined, self);
					}
					else if(function_Distance(self.var_origin, var_e_attacker.var_origin) > 700)
					{
						var_e_attacker notify("hash_79ef118b", "zombie_heavy_armored_longshot_critical_kill", undefined, self);
					}
					else
					{
						var_e_attacker notify("hash_79ef118b", "zombie_heavy_armored_critical_kill", undefined, self);
					}
				}
				else if(var_e_attacker function_GetStance() == "prone")
				{
					var_e_attacker notify("hash_79ef118b", "zombie_armored_prone_critical_kill", undefined, self);
				}
				else if(var_e_attacker function_IsSliding())
				{
					var_e_attacker notify("hash_79ef118b", "zombie_armored_sliding_critical_kill", undefined, self);
				}
				else if(function_Distance(self.var_origin, var_e_attacker.var_origin) > 700)
				{
					var_e_attacker notify("hash_79ef118b", "zombie_armored_longshot_critical_kill", undefined, self);
				}
				else
				{
					var_e_attacker notify("hash_79ef118b", "zombie_armored_critical_kill", undefined, self);
				}
			}
			else if(var_e_attacker function_GetStance() == "prone")
			{
				var_e_attacker notify("hash_79ef118b", "zombie_prone_critical_kill", undefined, self);
			}
			else if(var_e_attacker function_IsSliding())
			{
				var_e_attacker notify("hash_79ef118b", "zombie_sliding_critical_kill", undefined, self);
			}
			else if(function_Distance(self.var_origin, var_e_attacker.var_origin) > 700)
			{
				var_e_attacker notify("hash_79ef118b", "zombie_longshot_critical_kill", undefined, self);
			}
			else
			{
				var_e_attacker notify("hash_79ef118b", "zombie_critical_kill", undefined, self);
			}
		}
		else
		{
			var_e_attacker notify("hash_79ef118b", "zombie_critical_kill", undefined);
			return;
		}
	}
	if(isdefined(self.var_isdog) && self.var_isdog)
	{
		var_e_attacker.var_pers["dog_kills"]++;
		var_e_attacker.var_pers["special_kills"]++;
		var_e_attacker thread function_7e18304e("spx_end_game_save_data", "end_game_dog_kills", 1, 0);
		var_e_attacker thread function_7e18304e("spx_end_game_save_data", "end_game_special_kills", 1, 0);
		var_e_attacker thread function_7e18304e("spx_save_data", "dog_kills", var_e_attacker.var_pers["dog_kills"], 0);
		var_e_attacker notify("hash_79ef118b", "zombie_dog_kill", undefined);
		return;
	}
	else
	{
		var_e_attacker.var_pers["zombie_kills"]++;
		var_e_attacker thread function_7e18304e("spx_save_data", "zombie_kills", var_e_attacker.var_pers["zombie_kills"], 0);
		if(isdefined(self.var_fc3ab987) && self.var_fc3ab987)
		{
			if(isdefined(self.var_2a280bef) && self.var_2a280bef)
			{
				if(var_e_attacker function_GetStance() == "prone")
				{
					var_e_attacker notify("hash_79ef118b", "zombie_heavy_armored_prone_kill", undefined, self);
				}
				else if(var_e_attacker function_IsSliding())
				{
					var_e_attacker notify("hash_79ef118b", "zombie_heavy_armored_sliding_kill", undefined, self);
				}
				else if(function_Distance(self.var_origin, var_e_attacker.var_origin) > 700)
				{
					var_e_attacker notify("hash_79ef118b", "zombie_heavy_armored_longshot_kill", undefined, self);
				}
				else
				{
					var_e_attacker notify("hash_79ef118b", "zombie_heavy_armored_kill", undefined, self);
				}
			}
			else if(var_e_attacker function_GetStance() == "prone")
			{
				var_e_attacker notify("hash_79ef118b", "zombie_armored_prone_kill", undefined, self);
			}
			else if(var_e_attacker function_IsSliding())
			{
				var_e_attacker notify("hash_79ef118b", "zombie_armored_sliding_kill", undefined, self);
			}
			else if(function_Distance(self.var_origin, var_e_attacker.var_origin) > 700)
			{
				var_e_attacker notify("hash_79ef118b", "zombie_armored_longshot_kill", undefined, self);
			}
			else
			{
				var_e_attacker notify("hash_79ef118b", "zombie_armored_kill", undefined, self);
			}
		}
		else if(var_e_attacker function_GetStance() == "prone")
		{
			var_e_attacker notify("hash_79ef118b", "zombie_prone_kill", undefined, self);
		}
		else if(var_e_attacker function_IsSliding())
		{
			var_e_attacker notify("hash_79ef118b", "zombie_sliding_kill", undefined, self);
		}
		else if(function_Distance(self.var_origin, var_e_attacker.var_origin) > 700)
		{
			var_e_attacker notify("hash_79ef118b", "zombie_longshot_kill", undefined, self);
		}
		else
		{
			var_e_attacker notify("hash_79ef118b", "zombie_regular_kill", undefined, self);
			return;
		}
	}
	if(var_e_attacker function_hasPerk("specialty_immunetriggerbetty"))
	{
		if(!(isdefined(self.var_no_damage_points) && self.var_no_damage_points) && isdefined(var_e_attacker))
		{
			var_chance = function_randomIntRange(1, 100);
			if(var_chance <= 25)
			{
				var_e_attacker namespace_zm_score::function_player_add_points("death", undefined, undefined, 0, undefined, self.var_damageWeapon);
			}
		}
	}
	var_e_attacker thread function_7e18304e("spx_save_data", "special_kills", var_e_attacker.var_pers["special_kills"], 0);
	return;
	return;
	ERROR: Exception occured: Stack empty.
}

/*
	Name: function_8a7f57f
	Namespace: namespace_97ac1184
	Checksum: 0x424F4353
	Offset: 0x1C100
	Size: 0xA0
	Parameters: 7
	Flags: None
	Line Number: 6213
*/
function function_8a7f57f(var_d7d24b28, var_9105bf5d, var_text1, var_ef8a059e, var_2c50d11e, var_52534b87, var_victim)
{
	if(!isdefined(var_d7d24b28))
	{
		var_d7d24b28 = "Hello";
	}
	if(!isdefined(var_9105bf5d))
	{
		var_9105bf5d = "^7";
	}
	if(!isdefined(var_text1))
	{
		var_text1 = "World";
	}
	if(!isdefined(var_ef8a059e))
	{
		var_ef8a059e = "^7";
	}
}

/*
	Name: function_b3489bf5
	Namespace: namespace_97ac1184
	Checksum: 0x424F4353
	Offset: 0x1C1A8
	Size: 0x28
	Parameters: 1
	Flags: None
	Line Number: 6243
*/
function function_b3489bf5(var_text)
{
	function_iprintln(var_text);
	return;
	ERROR: Exception occured: Stack empty.
}

/*
	Name: function_7e18304e
	Namespace: namespace_97ac1184
	Checksum: 0x424F4353
	Offset: 0x1C1D8
	Size: 0x330
	Parameters: 11
	Flags: None
	Line Number: 6260
*/
function function_7e18304e(var_type, var_bd058c01, var_value, var_overwrite, var_priority, var_363c7886, var_e0ea0acc, var_52f17a07, var_2ceeff9e, var_6ee29b91, var_48e02128)
{
	if(!isdefined(var_overwrite))
	{
		var_overwrite = 0;
	}
	if(!isdefined(var_priority))
	{
		var_priority = 0;
	}
	if(!isdefined(var_363c7886))
	{
		var_363c7886 = 0;
	}
	if(!isdefined(var_e0ea0acc))
	{
		var_e0ea0acc = undefined;
	}
	if(!isdefined(var_52f17a07))
	{
		var_52f17a07 = undefined;
	}
	if(!isdefined(var_2ceeff9e))
	{
		var_2ceeff9e = undefined;
	}
	if(!isdefined(var_6ee29b91))
	{
		var_6ee29b91 = undefined;
	}
	if(!isdefined(var_48e02128))
	{
		var_48e02128 = undefined;
	}
	if(isdefined(self.var_c6452f46["leveling"]) && self.var_c6452f46["leveling"])
	{
		if(!isdefined(var_value))
		{
			var_value = 0;
		}
		if(!isdefined(self.var_84298650))
		{
			self.var_84298650 = [];
		}
		if(!isdefined(self.var_1c3ca2eb))
		{
			self.var_1c3ca2eb = [];
		}
		var_key = var_bd058c01;
		if(isdefined(var_363c7886) && var_363c7886)
		{
			var_key = var_bd058c01 + function_randomIntRange(0, 1000000);
		}
		if(isdefined(self.var_84298650[var_bd058c01]))
		{
			self.var_84298650[var_bd058c01].var_value = var_value;
		}
		else
		{
			var_535f7585 = function_spawnstruct();
			var_535f7585.var_type = var_type;
			var_535f7585.var_bd058c01 = var_bd058c01;
			var_535f7585.var_value = var_value;
			var_535f7585.var_e0ea0acc = var_e0ea0acc;
			var_535f7585.var_52f17a07 = var_52f17a07;
			var_535f7585.var_2ceeff9e = var_2ceeff9e;
			var_535f7585.var_6ee29b91 = var_6ee29b91;
			var_535f7585.var_48e02128 = var_48e02128;
			var_535f7585.var_overwrite = var_overwrite;
			var_535f7585.var_priority = var_priority;
			if(isdefined(var_363c7886) && var_363c7886)
			{
				var_535f7585.var_Randomized = var_key;
			}
			if(isdefined(var_priority) && var_priority)
			{
				self.var_1c3ca2eb[var_key] = var_535f7585;
			}
			else
			{
				self.var_84298650[var_key] = var_535f7585;
			}
		}
	}
}

/*
	Name: function_afb49977
	Namespace: namespace_97ac1184
	Checksum: 0x424F4353
	Offset: 0x1C510
	Size: 0xAF0
	Parameters: 0
	Flags: None
	Line Number: 6356
*/
function function_afb49977()
{
	self endon("hash_disconnect");
	self.var_df17dfe1 = 0;
	for(;;)
	{
		wait(1);
		while(self.var_1c3ca2eb.size > 0 || self.var_84298650.size > 0)
		{
			if(!(isdefined(self.var_df17dfe1) && self.var_df17dfe1))
			{
				while(self.var_1c3ca2eb.size > 0)
				{
					foreach(var_data in self.var_1c3ca2eb)
					{
						if(!isdefined(var_data.var_type) || !isdefined(var_data.var_bd058c01) || !isdefined(var_data.var_value))
						{
							continue;
						}
						if(var_data.var_type == "damage_3d")
						{
							self function_LUINotifyEvent(&"damage_3d", 6, function_Int(var_data.var_value), var_data.var_e0ea0acc, function_Int(var_data.var_52f17a07), function_Int(var_data.var_2ceeff9e), function_Int(var_data.var_6ee29b91), function_Int(var_data.var_48e02128));
						}
						else if(var_data.var_type == "player_data")
						{
							self function_LUINotifyEvent(&"leveling_data", 6, var_data.var_value, function_GetPlayers()[var_data.var_value].var_b74a3cd1["prestige"], function_GetPlayers()[var_data.var_value].var_b74a3cd1["level"], function_GetPlayers()[var_data.var_value].var_b74a3cd1["xp"], function_Int(function_GetPlayers()[var_data.var_value] function_4c2abd48(function_GetPlayers()[var_data.var_value].var_b74a3cd1["level"])["xp_needed"]), function_Int(function_GetPlayers()[var_data.var_value].var_b74a3cd1["xp_multiplier"]));
						}
						if(isdefined(var_data.var_Randomized))
						{
							self.var_1c3ca2eb[var_data.var_Randomized] = undefined;
						}
						else
						{
							self.var_1c3ca2eb[var_data.var_bd058c01] = undefined;
						}
						if(isdefined(self.var_is_hotjoining) && self.var_is_hotjoining || function_ToLower(function_GetDvarString("mapname")) == "zm_shoothouse" || function_ToLower(function_GetDvarString("mapname")) == "zm_irondragon")
						{
							wait(0.25 * self function_GetEntityNumber() + 1);
							continue;
						}
						wait(0.06 * self function_GetEntityNumber() + 1);
					}
				}
				foreach(var_data in self.var_84298650)
				{
					if(self.var_1c3ca2eb.size > 0)
					{
						break;
					}
					if(!isdefined(var_data.var_type) || !isdefined(var_data.var_bd058c01) || !isdefined(var_data.var_value))
					{
						continue;
					}
					if(var_data.var_type == "spx_save_data")
					{
						self function_LUINotifyEvent(&"spx_save_data", 2, function_Int(level.var_ac46587c[var_data.var_bd058c01]), function_Int(var_data.var_value));
					}
					else if(var_data.var_type == "leveling_data")
					{
						var_ca7a8609 = self function_4c2abd48(self.var_b74a3cd1["level"]);
						self function_LUINotifyEvent(&"leveling_data", 5, self function_GetEntityNumber(), self.var_b74a3cd1["prestige"], self.var_b74a3cd1["level"], self.var_b74a3cd1["xp"], function_Int(var_ca7a8609["xp_needed"]));
					}
					else if(var_data.var_type == "ZMBU_info")
					{
						var_ca7a8609 = self function_7da4fcdb(self.var_b74a3cd1["brutal_rank"]);
						self function_LUINotifyEvent(&"ZMBU_info", 4, &"ZM_MINECRAFT_BRUTAL_RANK", self.var_da7682e5, self.var_b74a3cd1["brutal_xp"], function_Int(var_ca7a8609["xp_needed"]));
					}
					else if(var_data.var_type == "spx_end_game_save_data")
					{
						if(isdefined(var_data.var_overwrite) && var_data.var_overwrite)
						{
							self.var_pers[var_data.var_bd058c01] = var_data.var_value;
						}
						else
						{
							self.var_pers[var_data.var_bd058c01] = self.var_pers[var_data.var_bd058c01] + var_data.var_value;
						}
						self function_LUINotifyEvent(&"spx_end_game_save_data", 2, function_Int(level.var_5e620cb1[var_data.var_bd058c01]), function_Int(self.var_pers[var_data.var_bd058c01]));
					}
					else if(var_data.var_type == "spx_maps_save_data")
					{
						self function_LUINotifyEvent(&"spx_maps_save_data", 2, function_Int(level.var_c3e446a[var_data.var_bd058c01]), function_Int(var_data.var_value));
					}
					else if(var_data.var_type == "spx_challenges_save_data")
					{
						self function_LUINotifyEvent(&"spx_challenges_save_data", 2, function_Int(level.var_79bcc5f3[var_data.var_bd058c01]), function_Int(var_data.var_value));
					}
					if(isdefined(var_data.var_Randomized))
					{
						self.var_84298650[var_data.var_Randomized] = undefined;
					}
					else
					{
						self.var_84298650[var_data.var_bd058c01] = undefined;
					}
					if(isdefined(self.var_is_hotjoining) && self.var_is_hotjoining || function_ToLower(function_GetDvarString("mapname")) == "zm_shoothouse" || function_ToLower(function_GetDvarString("mapname")) == "zm_irondragon")
					{
						wait(0.25 * self function_GetEntityNumber() + 1);
						continue;
					}
					wait(0.06 * self function_GetEntityNumber() + 1);
				}
			}
			else
			{
				wait(1);
			}
		}
	}
}

/*
	Name: function_790454cd
	Namespace: namespace_97ac1184
	Checksum: 0x424F4353
	Offset: 0x1D008
	Size: 0x9D0
	Parameters: 0
	Flags: None
	Line Number: 6477
*/
function function_790454cd()
{
	if(self function_IsSplitscreen() && self.var_name == level.var_players[0].var_name + " 1" || (self function_IsSplitscreen() && self.var_name == level.var_players[0].var_name + " 2") || (self function_IsSplitscreen() && self.var_name == level.var_players[0].var_name + " 3") || (self function_IsSplitscreen() && self.var_name == level.var_players[0].var_name + " 4") || (self function_IsSplitscreen() && self.var_name == level.var_players[0].var_name + " 5") || (self function_IsSplitscreen() && self.var_name == level.var_players[0].var_name + " 6") || (self function_IsSplitscreen() && self.var_name == level.var_players[0].var_name + " 7"))
	{
	}
	else
	{
		self thread function_7e18304e("spx_save_data", "xuid", self function_getxuid(1), 0);
		self thread function_7e18304e("spx_maps_save_data", "xuid", self function_getxuid(1), 0);
		self thread function_7e18304e("spx_challenges_save_data", "xuid", self function_getxuid(1), 0);
		self thread function_7e18304e("spx_end_game_save_data", "xuid", self function_getxuid(1), 0);
		self thread function_7e18304e("spx_save_data", "prestige", self.var_b74a3cd1["prestige_ultimate"], 0);
		self thread function_7e18304e("spx_save_data", "prestige_absolute", self.var_b74a3cd1["prestige_absolute"], 0);
		self thread function_7e18304e("spx_save_data", "prestige_legend", self.var_b74a3cd1["prestige_legend"], 0);
		self thread function_7e18304e("spx_save_data", "player_points", self.var_pers["player_points"], 0);
		self thread function_7e18304e("spx_save_data", "cheated_runs", self.var_pers["cheated_runs"], 0);
		self thread function_7e18304e("spx_save_data", "halloween_camo", self.var_pers["halloween_camo"], 0);
		self thread function_7e18304e("spx_save_data", "halloween_camo_2", self.var_pers["halloween_camo_2"], 0);
		self thread function_7e18304e("spx_save_data", "halloween_pumpkin_hat", self.var_pers["halloween_pumpkin_hat"], 0);
		self thread function_7e18304e("spx_save_data", "halloween_title", self.var_pers["halloween_title"], 0);
		self thread function_7e18304e("spx_save_data", "halloween_pet", self.var_pers["halloween_pet"], 0);
		self thread function_7e18304e("spx_save_data", "christmas_hat", self.var_pers["christmas_hat"], 0);
		self thread function_7e18304e("spx_save_data", "christmas_camo", self.var_pers["christmas_camo"], 0);
		self thread function_7e18304e("spx_save_data", "motd_camo_0", self.var_pers["motd_camo_0"], 0);
		self thread function_7e18304e("spx_save_data", "motd_camo_1", self.var_pers["motd_camo_1"], 0);
		self thread function_7e18304e("spx_save_data", "motd_camo_2", self.var_pers["motd_camo_2"], 0);
		self thread function_7e18304e("spx_save_data", "motd_camo_3", self.var_pers["motd_camo_3"], 0);
		self thread function_7e18304e("spx_save_data", "motd_plushie", self.var_pers["motd_plushie"], 0);
		self thread function_7e18304e("spx_save_data", "christmas_camo_2", self.var_pers["christmas_camo_2"], 0);
		self thread function_7e18304e("spx_save_data", "christmas_hat_2", self.var_pers["christmas_hat_2"], 0);
		self thread function_7e18304e("spx_save_data", "mc_title_1", self.var_pers["mc_title_1"], 0);
		self thread function_7e18304e("spx_save_data", "mc_plushie_1", self.var_pers["mc_plushie_1"], 0);
		self thread function_7e18304e("spx_save_data", "time_played_total", self.var_pers["time_played_total"], 0);
		self thread function_7e18304e("spx_save_data", "downs", self.var_pers["downs"], 0);
		self thread function_7e18304e("spx_save_data", "revives", self.var_pers["revives"], 0);
		self thread function_7e18304e("spx_save_data", "total_shots", self.var_pers["total_shots"], 0);
		self thread function_7e18304e("spx_save_data", "hits", self.var_pers["hits"], 0);
		self thread function_7e18304e("spx_save_data", "misses", self.var_pers["misses"], 0);
		self thread function_7e18304e("spx_save_data", "distance_traveled", self.var_pers["distance_traveled"], 0);
		self thread function_7e18304e("spx_save_data", "doors_purchased", self.var_pers["doors_purchased"], 0);
		self thread function_7e18304e("spx_save_data", "bgbs_chewed", self.var_pers["bgbs_chewed"], 0);
		self thread function_7e18304e("spx_save_data", "buildables_built", self.var_pers["buildables_built"], 0);
		self thread function_7e18304e("spx_save_data", "boards", self.var_pers["boards"], 0);
		return;
	}
}

/*
	Name: function_e5da2d1e
	Namespace: namespace_97ac1184
	Checksum: 0x424F4353
	Offset: 0x1D9E0
	Size: 0x118
	Parameters: 0
	Flags: None
	Line Number: 6534
*/
function function_e5da2d1e()
{
	var_index = 1;
	var_table = "gamedata/leveling/saving_data_index.csv";
	for(var_row = function_TableLookupRow(var_table, var_index); isdefined(var_row); var_row = function_TableLookupRow(var_table, var_index))
	{
		var_bd058c01 = function_checkStringValid(var_row[0]);
		var_type = function_checkStringValid(var_row[1]);
		if(isdefined(var_bd058c01) && var_bd058c01 != "")
		{
			level.var_ac46587c[var_bd058c01] = var_index;
			level.var_d824eaa9[var_bd058c01] = var_type;
		}
		var_index++;
	}
}

/*
	Name: function_58027f04
	Namespace: namespace_97ac1184
	Checksum: 0x424F4353
	Offset: 0x1DB00
	Size: 0x150
	Parameters: 0
	Flags: None
	Line Number: 6561
*/
function function_58027f04()
{
	var_index = 1;
	var_table = "gamedata/leveling/saving_data_index_maps.csv";
	for(var_row = function_TableLookupRow(var_table, var_index); isdefined(var_row); var_row = function_TableLookupRow(var_table, var_index))
	{
		var_bd058c01 = function_checkStringValid(var_row[0]);
		var_type = function_checkStringValid(var_row[1]);
		var_description = function_checkStringValid(var_row[2]);
		if(isdefined(var_bd058c01) && var_bd058c01 != "")
		{
			level.var_c3e446a[var_bd058c01] = var_index;
			level.var_742cf7b3[var_bd058c01] = var_type;
			level.var_d70efd10[var_index] = var_bd058c01;
		}
		var_index++;
	}
	return;
	continue;
}

/*
	Name: function_4ad6b691
	Namespace: namespace_97ac1184
	Checksum: 0x424F4353
	Offset: 0x1DC58
	Size: 0x150
	Parameters: 0
	Flags: None
	Line Number: 6592
*/
function function_4ad6b691()
{
	var_index = 1;
	var_table = "gamedata/leveling/saving_data_index_challenges.csv";
	for(var_row = function_TableLookupRow(var_table, var_index); isdefined(var_row); var_row = function_TableLookupRow(var_table, var_index))
	{
		var_bd058c01 = function_checkStringValid(var_row[0]);
		var_type = function_checkStringValid(var_row[1]);
		var_description = function_checkStringValid(var_row[2]);
		if(isdefined(var_bd058c01) && var_bd058c01 != "")
		{
			level.var_79bcc5f3[var_bd058c01] = var_index;
			level.var_d04fcc6a[var_bd058c01] = var_type;
			level.var_f05cf751[var_index] = var_bd058c01;
		}
		var_index++;
	}
}

/*
	Name: function_13b88de9
	Namespace: namespace_97ac1184
	Checksum: 0x424F4353
	Offset: 0x1DDB0
	Size: 0xB08
	Parameters: 3
	Flags: None
	Line Number: 6621
*/
function function_13b88de9(var_value, var_710bf60b, var_zombie)
{
	var_value = var_value * 1.1;
	var_12d93c83 = var_value;
	var_5081bd63 = function_GetEntArray("bgb_machine_use", "targetname");
	if(!(isdefined(level.var_bgb_in_use) && level.var_bgb_in_use) || var_5081bd63.size == 0)
	{
		var_value = var_value * 1.03;
	}
	if(isdefined(level.var_679e1a9e) && level.var_679e1a9e)
	{
		var_value = var_value * 1.05;
	}
	if(isdefined(level namespace_flag::function_get("insane_rage_inducer")) && level namespace_flag::function_get("insane_rage_inducer"))
	{
		var_value = var_value * 1.03;
	}
	if(level namespace_flag::function_get("classic_enabled"))
	{
		var_value = var_value * 1.1;
	}
	if(isdefined(level.var_8aa75b62) && level.var_8aa75b62)
	{
		var_value = var_value * 1.01;
	}
	if(isdefined(level.var_cb03afce) && level.var_cb03afce)
	{
		var_value = var_value * 1.01;
	}
	if(isdefined(level.var_842626f0) && level.var_842626f0 <= 10)
	{
		var_perks_disabled = 10 - level.var_842626f0;
		var_value = var_value * namespace_math::function_clamp(1 + var_perks_disabled * 0.01, 1, 1.05);
	}
	if(isdefined(level.var_919b0320) && level.var_919b0320)
	{
		var_value = var_value * 1.05;
	}
	if(isdefined(level.var_b90077c4) && level.var_b90077c4)
	{
		var_value = var_value * 1.01;
	}
	if(isdefined(level.var_bcf7eaa1) && level.var_bcf7eaa1)
	{
		var_value = var_value * 1.025;
	}
	if(!(isdefined(level.var_22a274bc) && level.var_22a274bc))
	{
		var_value = var_value * 1.01;
	}
	if(!(isdefined(level.var_240d2289) && level.var_240d2289))
	{
		var_value = var_value * 1.01;
	}
	if(!(isdefined(level.var_c127fb71) && level.var_c127fb71))
	{
		var_value = var_value * 1.01;
	}
	if(!(isdefined(level.var_fd6c66c2) && level.var_fd6c66c2))
	{
		var_value = var_value * 1.01;
	}
	if(isdefined(level.var_headshots_only) && level.var_headshots_only)
	{
		var_value = var_value * 1.01;
	}
	if(level.var_842626f0 == 0)
	{
		var_value = var_value * 1.05;
	}
	if(isdefined(level.var_8c94e755) && level.var_8c94e755)
	{
		var_value = var_value * 1.05;
	}
	if(!(isdefined(level.var_147d7517["double_points"]) && level.var_147d7517["double_points"]) && (!(isdefined(level.var_8c94e755) && level.var_8c94e755)))
	{
		var_value = var_value * 1.01;
	}
	if(!(isdefined(level.var_147d7517["storm_surge"]) && level.var_147d7517["storm_surge"]) && (!(isdefined(level.var_8c94e755) && level.var_8c94e755)))
	{
		var_value = var_value * 1.01;
	}
	if(!(isdefined(level.var_147d7517["fire_sale"]) && level.var_147d7517["fire_sale"]) && (!(isdefined(level.var_8c94e755) && level.var_8c94e755)))
	{
		var_value = var_value * 1.01;
	}
	if(!(isdefined(level.var_147d7517["insta_kill"]) && level.var_147d7517["insta_kill"]) && (!(isdefined(level.var_8c94e755) && level.var_8c94e755)))
	{
		var_value = var_value * 1.01;
	}
	if(!(isdefined(level.var_147d7517["full_ammo"]) && level.var_147d7517["full_ammo"]) && (!(isdefined(level.var_8c94e755) && level.var_8c94e755)))
	{
		var_value = var_value * 1.01;
	}
	if(isdefined(self.var_fa202141["player_playerdifficulty"]) && self.var_fa202141["player_playerdifficulty"] > 0)
	{
		if(self.var_fa202141["player_playerdifficulty"] > self.var_b74a3cd1["brutal_rank"])
		{
			function_IPrintLnBold("Brutal Rank too high!");
		}
		else
		{
			var_value = var_value * 1 + self.var_fa202141["player_playerdifficulty"] * 0.005;
		}
	}
	if(self.var_b74a3cd1["prestige_legend"] > 0)
	{
		var_value = var_value * 1 + 0.075 * self.var_b74a3cd1["prestige_legend"];
	}
	if(self.var_b74a3cd1["prestige_absolute"] > 0)
	{
		var_48b21c5b = self.var_b74a3cd1["prestige_absolute"] * 0.2;
		var_value = var_value * 1 + 0.9 * self.var_b74a3cd1["prestige_absolute"] + var_48b21c5b;
	}
	if(self.var_b74a3cd1["prestige_ultimate"] > 0)
	{
		var_f4e31bc7 = self.var_b74a3cd1["prestige_ultimate"] * 3;
		var_value = var_value * 1 + 10 * self.var_b74a3cd1["prestige_ultimate"] + var_f4e31bc7;
	}
	if(!(isdefined(level.var_7f38ec2c) && level.var_7f38ec2c))
	{
		var_value = var_value * 1.02;
	}
	if(isdefined(0) && 0 && (!(isdefined(var_710bf60b) && var_710bf60b)))
	{
		var_value = var_value * 1.5;
	}
	var_window_boards = namespace_struct::function_get_array("exterior_goal", "targetname");
	var_32f79b1d = namespace_struct::function_get_array("riser_location", "script_noteworthy");
	var_ab4a2512 = function_Array();
	foreach(var_loc in var_32f79b1d)
	{
		if(var_loc.var_script_string == "find_flesh")
		{
			function_ArrayInsert(var_ab4a2512, var_loc, var_ab4a2512.size);
		}
	}
	if(var_window_boards.size == 1 || var_window_boards.size == 2 || var_window_boards.size == 3)
	{
		if(var_ab4a2512.size == 0 || var_ab4a2512.size == 1 || var_ab4a2512.size == 2)
		{
			var_value = var_value * 0.4;
		}
	}
	else if(var_window_boards.size == 0)
	{
		if(var_ab4a2512.size == 1 || var_ab4a2512.size == 2)
		{
			var_value = var_value * 0.6;
		}
	}
	if(level.var_da5a2ab8)
	{
		var_value = var_value * 0.2;
	}
	if(level.var_zombie_actor_limit > 56 || level.var_zombie_ai_limit > 56 || level.var_zombie_vars["zombie_between_round_time"] == 0 || (isdefined(level.var_9d7722be) && level.var_9d7722be))
	{
		var_value = var_value * 0.75;
	}
	if(isdefined(level.var_91874529))
	{
		var_value = var_value * 1 - level.var_91874529 * 0.01;
	}
	if(!(isdefined(self function_ae5b65af(var_zombie)) && self function_ae5b65af(var_zombie)))
	{
		var_value = 0;
	}
	if(isdefined(self.var_ed43a11c) && self.var_ed43a11c)
	{
		var_value = 0;
	}
	var_9f433a3b = namespace_zm_utility::function_round_up_score(var_value, 10);
	self.var_b74a3cd1["xp_multiplier"] = var_9f433a3b / var_12d93c83 * 100;
	return var_9f433a3b;
	ERROR: Exception occured: Stack empty.
}

/*
	Name: function_ef10d421
	Namespace: namespace_97ac1184
	Checksum: 0x424F4353
	Offset: 0x1E8C0
	Size: 0x30
	Parameters: 0
	Flags: None
	Line Number: 6808
*/
function function_ef10d421()
{
	self notify("hash_ef10d421");
	self endon("hash_ef10d421");
	wait(6);
	self.var_760a296 = 0;
}

/*
	Name: function_faaa80e7
	Namespace: namespace_97ac1184
	Checksum: 0x424F4353
	Offset: 0x1E8F8
	Size: 0x30
	Parameters: 0
	Flags: None
	Line Number: 6826
*/
function function_faaa80e7()
{
	self notify("hash_1df17abc");
	self endon("hash_1df17abc");
	wait(2);
	self.var_ef742ca1 = 0;
}

/*
	Name: function_ae5b65af
	Namespace: namespace_97ac1184
	Checksum: 0x424F4353
	Offset: 0x1E930
	Size: 0x468
	Parameters: 1
	Flags: None
	Line Number: 6844
*/
function function_ae5b65af(var_zombie)
{
	if(!isdefined(self))
	{
		return 0;
	}
	if(function_IsGodMode(self))
	{
		return 0;
	}
	var_current_weapon = self function_GetCurrentWeapon();
	if(var_current_weapon == level.var_zombie_powerup_weapon["minigun"] && !self.var_zombie_vars["zombie_powerup_minigun_on"] || (function_IsSubStr(var_current_weapon.var_name, "minigun") && !self.var_zombie_vars["zombie_powerup_minigun_on"]))
	{
		return 0;
	}
	if(self.var_ignoreme > 0 && (isdefined(self.var_bgb_idle_eyes_active) && self.var_bgb_idle_eyes_active || (isdefined(self.var_zombie_vars["zombie_powerup_zombie_blood_on"]) && self.var_zombie_vars["zombie_powerup_zombie_blood_on"]) || (isdefined(level.var_c181264f) && level.var_c181264f) || (isdefined(self namespace_laststand::function_player_is_in_laststand()) && self namespace_laststand::function_player_is_in_laststand()) || (isdefined(self.var_bgb_in_plain_sight_active) && self.var_bgb_in_plain_sight_active)))
	{
		return 1;
	}
	else if(self.var_ignoreme > 0)
	{
		return 0;
	}
	var_ae52438a = 0;
	if(isdefined(var_zombie))
	{
		if(var_zombie namespace_zm_utility::function_in_playable_area() && (isdefined(var_zombie.var_completed_emerging_into_playable_area) && var_zombie.var_completed_emerging_into_playable_area))
		{
			if(isdefined(var_zombie.var_5bb6cdc1) && var_zombie.var_5bb6cdc1)
			{
				return 0;
			}
		}
	}
	var_4608cafc = 0;
	var_zombies = function_GetAITeamArray(level.var_zombie_team);
	if(var_zombies.size > 0)
	{
		foreach(var_fe254d59 in var_zombies)
		{
			if(isdefined(var_fe254d59.var_5bb6cdc1) && var_fe254d59.var_5bb6cdc1)
			{
				if(isdefined(var_zombie))
				{
					var_4608cafc++;
				}
			}
		}
	}
	else if(level.var_ec5f9c56 >= 5 && var_4608cafc >= 3)
	{
		self thread function_ef10d421();
		self.var_760a296 = 1;
	}
	else if(level.var_ec5f9c56 < 5 && var_4608cafc >= 1)
	{
		self thread function_ef10d421();
		self.var_760a296 = 1;
	}
	if(isdefined(self.var_760a296) && self.var_760a296)
	{
		return 0;
	}
	if(self.var_health > 300 || self.var_max_health > 300)
	{
		return 0;
	}
	var_playable_area = function_GetEntArray("player_volume", "script_noteworthy");
	var_1c5a0f9d = 0;
	for(var_i = 0; var_i < var_playable_area.size; var_i++)
	{
		if(self function_istouching(var_playable_area[var_i]))
		{
			var_1c5a0f9d = 1;
		}
	}
	if(!(isdefined(var_1c5a0f9d) && var_1c5a0f9d))
	{
		return 0;
	}
	return 1;
}

/*
	Name: function_72690674
	Namespace: namespace_97ac1184
	Checksum: 0x424F4353
	Offset: 0x1EDA0
	Size: 0x1B0
	Parameters: 1
	Flags: None
	Line Number: 6937
*/
function function_72690674(var_bd1ce88)
{
	if(isdefined(var_bd1ce88) && var_bd1ce88 && level.var_round_number <= 20)
	{
		return level.var_round_number * 11;
	}
	else if(isdefined(var_bd1ce88) && var_bd1ce88 && level.var_round_number > 20 && level.var_round_number <= 80)
	{
		return 220 + level.var_round_number - 20 * 7;
	}
	else if(isdefined(var_bd1ce88) && var_bd1ce88 && level.var_round_number > 80 && level.var_round_number <= 110)
	{
		return 640 + level.var_round_number - 80 * 5;
	}
	else if(isdefined(var_bd1ce88) && var_bd1ce88 && level.var_round_number > 110 && level.var_round_number <= 150)
	{
		return 790 + level.var_round_number - 110 * 3;
	}
	else if(isdefined(var_bd1ce88) && var_bd1ce88 && level.var_round_number > 150 && level.var_round_number <= 200)
	{
		return 910 + level.var_round_number - 150 * 2;
	}
	else if(isdefined(var_bd1ce88) && var_bd1ce88)
	{
		return 1010 + level.var_round_number - 200 * 1;
	}
	return 0;
}

/*
	Name: function_e2091339
	Namespace: namespace_97ac1184
	Checksum: 0x424F4353
	Offset: 0x1EF58
	Size: 0x260
	Parameters: 10
	Flags: None
	Line Number: 6976
*/
function function_e2091339(var_27a55984, var_5786e6c1, var_532d340b, var_7d8c01eb, var_89be7cc4, var_c2a37cdf, var_zombie, var_1d39abf6, var_player_points, var_710bf60b)
{
	if(!isdefined(var_27a55984))
	{
		var_27a55984 = 250;
	}
	if(!isdefined(var_5786e6c1))
	{
		var_5786e6c1 = 0;
	}
	if(!isdefined(var_532d340b))
	{
		var_532d340b = 0;
	}
	if(!isdefined(var_7d8c01eb))
	{
		var_7d8c01eb = 0;
	}
	if(!isdefined(var_1d39abf6))
	{
		var_1d39abf6 = undefined;
	}
	if(!isdefined(var_player_points))
	{
		var_player_points = 0;
	}
	if(!isdefined(var_710bf60b))
	{
		var_710bf60b = 0;
	}
	if(!isdefined(var_27a55984))
	{
		function_IPrintLnBold("Base Value needs defining!");
	}
	if(isdefined(var_c2a37cdf))
	{
		var_math = self function_13b88de9(var_c2a37cdf, var_710bf60b, var_zombie);
	}
	else
	{
		var_math = self function_13b88de9(var_27a55984 + level.var_round_number * var_5786e6c1 + self.var_b74a3cd1["level"] * var_532d340b + function_72690674(var_7d8c01eb), var_710bf60b, var_zombie);
	}
	if(self.var_f4d01b67["xp_hud"] == 0)
	{
		self thread function_score_event(var_89be7cc4, function_Int(var_math), self.var_230ba247);
	}
	if(isdefined(var_1d39abf6) && var_1d39abf6)
	{
		self thread function_7e18304e("spx_end_game_save_data", "end_game_milestones", 1, 0);
	}
	if(isdefined(var_player_points))
	{
		self.var_pers["player_points"] = self.var_pers["player_points"] + var_player_points;
	}
	return var_math;
}

/*
	Name: function_565fd0dc
	Namespace: namespace_97ac1184
	Checksum: 0x424F4353
	Offset: 0x1F1C0
	Size: 0x8080
	Parameters: 3
	Flags: None
	Line Number: 7043
*/
function function_565fd0dc(var_type, var_amount, var_zombie)
{
	switch(var_type)
	{
		case "zombie_critical_kill":
		{
			var_c614777a = self function_e2091339(130, undefined, 5, 1, &"ZM_MINECRAFT_SCORE_ZOMBIE_CRITICAL_KILL", undefined, var_zombie);
			return var_c614777a;
		}
		case "zombie_longshot_kill":
		{
			var_c614777a = self function_e2091339(120, undefined, 5, 1, &"ZM_MINECRAFT_SCORE_ZOMBIE_LONGSHOT_KILL", undefined, var_zombie);
			return var_c614777a;
		}
		case "zombie_sliding_kill":
		{
			var_c614777a = self function_e2091339(120, undefined, 5, 1, &"ZM_MINECRAFT_SCORE_ZOMBIE_SLIDING_KILL", undefined, var_zombie);
			return var_c614777a;
		}
		case "zombie_prone_kill":
		{
			var_c614777a = self function_e2091339(120, undefined, 5, 1, &"ZM_MINECRAFT_SCORE_ZOMBIE_PRONE_KILL", undefined, var_zombie);
			return var_c614777a;
		}
		case "zombie_longshot_critical_kill":
		{
			var_c614777a = self function_e2091339(175, undefined, 5, 1, &"ZM_MINECRAFT_SCORE_ZOMBIE_LONGSHOT_CRITICAL_KILL", undefined, var_zombie);
			return var_c614777a;
		}
		case "zombie_sliding_critical_kill":
		{
			var_c614777a = self function_e2091339(160, undefined, 5, 1, &"ZM_MINECRAFT_SCORE_ZOMBIE_SLIDING_CRITICAL_KILL", undefined, var_zombie);
			return var_c614777a;
		}
		case "zombie_prone_critical_kill":
		{
			var_c614777a = self function_e2091339(160, undefined, 5, 1, &"ZM_MINECRAFT_SCORE_ZOMBIE_PRONE_CRITICAL_KILL", undefined, var_zombie);
			return var_c614777a;
		}
		case "zombie_equipment_kill":
		{
			var_c614777a = self function_e2091339(75, undefined, 5, 1, &"ZM_MINECRAFT_SCORE_ZOMBIE_EQUIPMENT_KILL", undefined, var_zombie);
			return var_c614777a;
		}
		case "zombie_melee_kill":
		{
			var_c614777a = self function_e2091339(120, undefined, 5, 1, &"ZM_MINECRAFT_SCORE_ZOMBIE_MELEE_KILL", undefined, var_zombie);
			return var_c614777a;
		}
		case "zombie_regular_kill":
		{
			var_c614777a = self function_e2091339(100, undefined, 5, 1, &"ZM_MINECRAFT_SCORE_ZOMBIE_REGULAR_KILL", undefined, var_zombie);
			return var_c614777a;
		}
		case "zombie_regular_assist":
		{
			var_c614777a = self function_e2091339(50, undefined, 5, 1, &"ZM_MINECRAFT_SCORE_ZOMBIE_REGULAR_ASSIST", undefined, var_zombie);
			return var_c614777a;
		}
		case "zombie_shrieker_kill":
		{
			var_c614777a = self function_e2091339(400, undefined, 5, 1, &"ZM_MINECRAFT_SCORE_ZOMBIE_SHRIEKER_KILL", undefined, var_zombie);
			return var_c614777a;
		}
		case "zombie_shrieker_assist":
		{
			var_c614777a = self function_e2091339(200, undefined, 5, 1, &"ZM_MINECRAFT_SCORE_ZOMBIE_SHRIEKER_KILL", undefined, var_zombie);
			return var_c614777a;
		}
		case "zombie_napalm_kill":
		{
			var_c614777a = self function_e2091339(500, undefined, 5, 1, &"ZM_MINECRAFT_SCORE_ZOMBIE_NAPALM_KILL", undefined, var_zombie);
			return var_c614777a;
		}
		case "zombie_napalm_assist":
		{
			var_c614777a = self function_e2091339(250, undefined, 5, 1, &"ZM_MINECRAFT_SCORE_ZOMBIE_NAPALM_ASSIST", undefined, var_zombie);
			return var_c614777a;
		}
		case "zombie_keeper_kill":
		{
			var_c614777a = self function_e2091339(200, undefined, 5, 1, &"ZM_MINECRAFT_SCORE_ZOMBIE_KEEPER_KILL", undefined, var_zombie);
			return var_c614777a;
		}
		case "zombie_keeper_assist":
		{
			var_c614777a = self function_e2091339(100, undefined, 5, 1, &"ZM_MINECRAFT_SCORE_ZOMBIE_KEEPER_ASSIST", undefined, var_zombie);
			return var_c614777a;
		}
		case "zombie_apothicon_kill":
		{
			var_c614777a = self function_e2091339(100, undefined, 5, 1, &"ZM_MINECRAFT_SCORE_ZOMBIE_APOTHICON_KILL", undefined, var_zombie);
			return var_c614777a;
		}
		case "zombie_apothicon_assist":
		{
			var_c614777a = self function_e2091339(50, undefined, 5, 1, &"ZM_MINECRAFT_SCORE_ZOMBIE_APOTHICON_ASSIST", undefined, var_zombie);
			return var_c614777a;
		}
		case "zombie_parasite_kill":
		{
			var_c614777a = self function_e2091339(100, undefined, 5, 1, &"ZM_MINECRAFT_SCORE_ZOMBIE_PARASITE_KILL", undefined, var_zombie);
			return var_c614777a;
		}
		case "zombie_parasite_assist":
		{
			var_c614777a = self function_e2091339(50, undefined, 5, 1, &"ZM_MINECRAFT_SCORE_ZOMBIE_PARASITE_ASSIST", undefined, var_zombie);
			return var_c614777a;
		}
		case "zombie_raps_kill":
		{
			var_c614777a = self function_e2091339(100, undefined, 5, 1, &"ZM_MINECRAFT_SCORE_ZOMBIE_RAPS_KILL", undefined, var_zombie);
			return var_c614777a;
		}
		case "zombie_raps_assist":
		{
			var_c614777a = self function_e2091339(50, undefined, 5, 1, &"ZM_MINECRAFT_SCORE_ZOMBIE_RAPS_ASSIST", undefined, var_zombie);
			return var_c614777a;
		}
		case "zombie_spider_kill":
		{
			var_c614777a = self function_e2091339(100, undefined, 5, 1, &"ZM_MINECRAFT_SCORE_ZOMBIE_SPIDER_KILL", undefined, var_zombie);
			return var_c614777a;
		}
		case "zombie_spider_assist":
		{
			var_c614777a = self function_e2091339(50, undefined, 5, 1, &"ZM_MINECRAFT_SCORE_ZOMBIE_SPIDER_ASSIST", undefined, var_zombie);
			return var_c614777a;
		}
		case "zombie_monkey_kill":
		{
			var_c614777a = self function_e2091339(150, undefined, 5, 1, &"ZM_MINECRAFT_SCORE_ZOMBIE_MONKEY_KILL", undefined, var_zombie);
			return var_c614777a;
		}
		case "zombie_monkey_assist":
		{
			var_c614777a = self function_e2091339(75, undefined, 5, 1, &"ZM_MINECRAFT_SCORE_ZOMBIE_MONKEY_ASSIST", undefined, var_zombie);
			return var_c614777a;
		}
		case "zombie_mechz_kill":
		{
			var_c614777a = self function_e2091339(500, undefined, 5, 1, &"ZM_MINECRAFT_SCORE_ZOMBIE_MECHZ_KILL", undefined, var_zombie);
			return var_c614777a;
		}
		case "zombie_mechz_assist":
		{
			var_c614777a = self function_e2091339(250, undefined, 5, 1, &"ZM_MINECRAFT_SCORE_ZOMBIE_MECHZ_ASSIST", undefined, var_zombie);
			return var_c614777a;
		}
		case "zombie_zombiequad_kill":
		{
			var_c614777a = self function_e2091339(70, undefined, 5, 1, &"ZM_MINECRAFT_SCORE_ZOMBIE_ZOMBIEQUAD_KILL", undefined, var_zombie);
			return var_c614777a;
		}
		case "zombie_zombiequad_assist":
		{
			var_c614777a = self function_e2091339(35, undefined, 5, 1, &"ZM_MINECRAFT_SCORE_ZOMBIE_ZOMBIEQUAD_ASSIST", undefined, var_zombie);
			return var_c614777a;
		}
		case "zombie_margwa_kill":
		{
			var_c614777a = self function_e2091339(800, undefined, 5, 1, &"ZM_MINECRAFT_SCORE_ZOMBIE_MARGWA_KILL", undefined, var_zombie);
			return var_c614777a;
		}
		case "zombie_margwa_assist":
		{
			var_c614777a = self function_e2091339(400, undefined, 5, 1, &"ZM_MINECRAFT_SCORE_ZOMBIE_MARGWA_ASSIST", undefined, var_zombie);
			return var_c614777a;
		}
		case "zombie_thrasher_kill":
		{
			var_c614777a = self function_e2091339(700, undefined, 5, 1, &"ZM_MINECRAFT_SCORE_ZOMBIE_TRASHER_KILL", undefined, var_zombie);
			return var_c614777a;
		}
		case "zombie_thrasher_assist":
		{
			var_c614777a = self function_e2091339(350, undefined, 5, 1, &"ZM_MINECRAFT_SCORE_ZOMBIE_TRASHER_ASSIST", undefined, var_zombie);
			return var_c614777a;
		}
		case "zombie_raz_kill":
		{
			var_c614777a = self function_e2091339(500, undefined, 5, 1, &"ZM_MINECRAFT_SCORE_ZOMBIE_RAZ_KILL", undefined, var_zombie);
			return var_c614777a;
		}
		case "zombie_raz_assist":
		{
			var_c614777a = self function_e2091339(250, undefined, 5, 1, &"ZM_MINECRAFT_SCORE_ZOMBIE_RAZ_ASSIST", undefined, var_zombie);
			return var_c614777a;
		}
		case "zombie_astronaut_kill":
		{
			var_c614777a = self function_e2091339(400, undefined, 5, 1, &"ZM_MINECRAFT_SCORE_ZOMBIE_ASTRONAUT_KILL", undefined, var_zombie);
			return var_c614777a;
		}
		case "zombie_astronaut_assist":
		{
			var_c614777a = self function_e2091339(200, undefined, 5, 1, &"ZM_MINECRAFT_SCORE_ZOMBIE_ASTRONAUT_ASSIST", undefined, var_zombie);
			return var_c614777a;
		}
		case "zombie_saint_kill":
		{
			var_c614777a = self function_e2091339(1500, undefined, 5, 1, &"ZM_MINECRAFT_SCORE_ZOMBIE_SAINT_KILL", undefined, var_zombie);
			return var_c614777a;
		}
		case "zombie_saint_assist":
		{
			var_c614777a = self function_e2091339(1000, undefined, 5, 1, &"ZM_MINECRAFT_SCORE_ZOMBIE_SAINT_ASSIST", undefined, var_zombie);
			return var_c614777a;
		}
		case "zombie_ghost_kill":
		{
			var_c614777a = self function_e2091339(1500, undefined, 5, 1, &"ZM_MINECRAFT_SCORE_ZOMBIE_GHOST_KILL", undefined, var_zombie);
			return var_c614777a;
		}
		case "zombie_ghost_assist":
		{
			var_c614777a = self function_e2091339(1000, undefined, 5, 1, &"ZM_MINECRAFT_SCORE_ZOMBIE_GHOST_ASSIST", undefined, var_zombie);
			return var_c614777a;
		}
		case "zombie_dog_kill":
		{
			var_c614777a = self function_e2091339(75, undefined, 5, 1, &"ZM_MINECRAFT_SCORE_ZOMBIE_DOG_KILL", undefined, var_zombie);
			return var_c614777a;
		}
		case "zombie_dog_assist":
		{
			var_c614777a = self function_e2091339(35, undefined, 5, 1, &"ZM_MINECRAFT_SCORE_ZOMBIE_DOG_ASSIST", undefined, var_zombie);
			return var_c614777a;
		}
		case "zombie_armored_kill":
		{
			var_c614777a = self function_e2091339(225, undefined, 5, 1, &"ZM_MINECRAFT_SCORE_ZOMBIE_ARMORED_KILL", undefined, var_zombie);
			return var_c614777a;
		}
		case "zombie_armored_assist":
		{
			var_c614777a = self function_e2091339(110, undefined, 5, 1, &"ZM_MINECRAFT_SCORE_ZOMBIE_ARMORED_ASSIST", undefined, var_zombie);
			return var_c614777a;
		}
		case "zombie_armored_prone_kill":
		{
			var_c614777a = self function_e2091339(250, undefined, 5, 1, &"ZM_MINECRAFT_SCORE_ZOMBIE_ARMORED_PRONE_KILL", undefined, var_zombie);
			return var_c614777a;
		}
		case "zombie_armored_sliding_kill":
		{
			var_c614777a = self function_e2091339(260, undefined, 5, 1, &"ZM_MINECRAFT_SCORE_ZOMBIE_ARMORED_SLIDING_KILL", undefined, var_zombie);
			return var_c614777a;
		}
		case "zombie_armored_longshot_kill":
		{
			var_c614777a = self function_e2091339(275, undefined, 5, 1, &"ZM_MINECRAFT_SCORE_ZOMBIE_ARMORED_LONGSHOT_KILL", undefined, var_zombie);
			return var_c614777a;
		}
		case "zombie_armored_critical_kill":
		{
			var_c614777a = self function_e2091339(300, undefined, 5, 1, &"ZM_MINECRAFT_SCORE_ZOMBIE_ARMORED_CRITICAL_KILL", undefined, var_zombie);
			return var_c614777a;
		}
		case "zombie_heavy_armored_kill":
		{
			var_c614777a = self function_e2091339(325, undefined, 10, 1, &"ZM_MINECRAFT_SCORE_ZOMBIE_HEAVY_ARMORED_KILL", undefined, var_zombie);
			return var_c614777a;
		}
		case "zombie_heavy_armored_assist":
		{
			var_c614777a = self function_e2091339(150, undefined, 10, 1, &"ZM_MINECRAFT_SCORE_ZOMBIE_HEAVY_ARMORED_ASSIST", undefined, var_zombie);
			return var_c614777a;
		}
		case "zombie_heavy_armored_prone_kill":
		{
			var_c614777a = self function_e2091339(350, undefined, 10, 1, &"ZM_MINECRAFT_SCORE_ZOMBIE_HEAVY_ARMORED_PRONE_KILL", undefined, var_zombie);
			return var_c614777a;
		}
		case "zombie_heavy_armored_sliding_kill":
		{
			var_c614777a = self function_e2091339(360, undefined, 10, 1, &"ZM_MINECRAFT_SCORE_ZOMBIE_HEAVY_ARMORED_SLIDING_KILL", undefined, var_zombie);
			return var_c614777a;
		}
		case "zombie_heavy_armored_longshot_kill":
		{
			var_c614777a = self function_e2091339(375, undefined, 10, 1, &"ZM_MINECRAFT_SCORE_ZOMBIE_HEAVY_ARMORED_LONGSHOT_KILL", undefined, var_zombie);
			return var_c614777a;
		}
		case "zombie_heavy_armored_critical_kill":
		{
			var_c614777a = self function_e2091339(400, undefined, 10, 1, &"ZM_MINECRAFT_SCORE_ZOMBIE_HEAVY_ARMORED_CRITICAL_KILL", undefined, var_zombie);
			return var_c614777a;
		}
		case "zombie_boss_kill":
		{
			var_c614777a = self function_e2091339(700, undefined, 5, 1, &"ZM_MINECRAFT_SCORE_ZOMBIE_BOSS_KILL", undefined, var_zombie);
			return var_c614777a;
		}
		case "zombie_boss_assist":
		{
			var_c614777a = self function_e2091339(350, undefined, 5, 1, &"ZM_MINECRAFT_SCORE_ZOMBIE_BOSS_KILL", undefined, var_zombie);
			return var_c614777a;
		}
		case "player_revive":
		{
			var_c614777a = self function_e2091339(500, undefined, 5, 1, &"ZM_MINECRAFT_SCORE_PLAYER_REVIVE", undefined, var_zombie);
			return var_c614777a;
		}
		case "round_survived":
		{
			var_c614777a = self function_e2091339(150, 50, 0, 1, &"ZM_MINECRAFT_SCORE_ROUND_SURVIVED", undefined, var_zombie);
			return var_c614777a;
		}
		case "game_ended":
		{
			if(self.var_9ee9bcc6 >= 30)
			{
				var_25b387f9 = 1500;
			}
			else
			{
				var_25b387f9 = self.var_9ee9bcc6 * 50;
			}
			var_c614777a = self function_e2091339(50, 50, 0, 1, &"ZM_MINECRAFT_SCORE_GAME_ENDED", var_25b387f9);
			return var_c614777a;
		}
		case "barrier_repaired":
		{
			var_c614777a = self function_e2091339(25, 0, 0, 0, &"ZM_MINECRAFT_SCORE_BARRIER_REPAIRED", undefined, var_zombie);
			return var_c614777a;
		}
		case "doors_purchased":
		{
			var_c614777a = self function_e2091339(var_amount, 0, 0, 0, &"ZM_MINECRAFT_SCORE_DOOR_PURCHASED", undefined, var_zombie);
			return var_c614777a;
		}
		case "powerup_xp_drop":
		{
			var_c614777a = self function_e2091339(function_cd26638e(), 0, 0, 0, &"ZM_MINECRAFT_SCORE_XP_DROP", undefined, var_zombie);
			return var_c614777a;
		}
		case "milestone_completed_round_10":
		{
			var_c614777a = self function_e2091339(1000, 0, 0, 0, &"ZM_MINECRAFT_SCORE_MILESTONE_COMPLETED_ROUND_10", undefined, var_zombie, 1, 10, 1);
			self function_LUINotifyEvent(&"spx_milestone_notification", 2, &"ZM_MINECRAFT_MILESTONE_ROUNDS", 10);
			return var_c614777a;
		}
		case "milestone_completed_round_15":
		{
			var_c614777a = self function_e2091339(1500, 0, 0, 0, &"ZM_MINECRAFT_SCORE_MILESTONE_COMPLETED_ROUND_15", undefined, var_zombie, 1, 20, 1);
			self function_LUINotifyEvent(&"spx_milestone_notification", 2, &"ZM_MINECRAFT_MILESTONE_ROUNDS", 15);
			return var_c614777a;
		}
		case "milestone_completed_round_20":
		{
			var_c614777a = self function_e2091339(2000, 0, 0, 0, &"ZM_MINECRAFT_SCORE_MILESTONE_COMPLETED_ROUND_20", undefined, var_zombie, 1, 30, 1);
			self function_LUINotifyEvent(&"spx_milestone_notification", 2, &"ZM_MINECRAFT_MILESTONE_ROUNDS", 20);
			return var_c614777a;
		}
		case "milestone_completed_round_25":
		{
			var_c614777a = self function_e2091339(3000, 0, 0, 0, &"ZM_MINECRAFT_SCORE_MILESTONE_COMPLETED_ROUND_25", undefined, var_zombie, 1, 40, 1);
			self function_LUINotifyEvent(&"spx_milestone_notification", 2, &"ZM_MINECRAFT_MILESTONE_ROUNDS", 25);
			return var_c614777a;
		}
		case "milestone_completed_round_30":
		{
			var_c614777a = self function_e2091339(4000, 0, 0, 0, &"ZM_MINECRAFT_SCORE_MILESTONE_COMPLETED_ROUND_30", undefined, var_zombie, 1, 50, 1);
			self function_LUINotifyEvent(&"spx_milestone_notification", 2, &"ZM_MINECRAFT_MILESTONE_ROUNDS", 30);
			return var_c614777a;
		}
		case "milestone_completed_round_35":
		{
			var_c614777a = self function_e2091339(5000, 0, 0, 0, &"ZM_MINECRAFT_SCORE_MILESTONE_COMPLETED_ROUND_35", undefined, var_zombie, 1, 60, 1);
			self function_LUINotifyEvent(&"spx_milestone_notification", 2, &"ZM_MINECRAFT_MILESTONE_ROUNDS", 35);
			return var_c614777a;
		}
		case "milestone_completed_round_40":
		{
			var_c614777a = self function_e2091339(6000, 0, 0, 0, &"ZM_MINECRAFT_SCORE_MILESTONE_COMPLETED_ROUND_40", undefined, var_zombie, 1, 70, 1);
			self function_LUINotifyEvent(&"spx_milestone_notification", 2, &"ZM_MINECRAFT_MILESTONE_ROUNDS", 40);
			return var_c614777a;
		}
		case "milestone_completed_round_45":
		{
			var_c614777a = self function_e2091339(7000, 0, 0, 0, &"ZM_MINECRAFT_SCORE_MILESTONE_COMPLETED_ROUND_45", undefined, var_zombie, 1, 80, 1);
			self function_LUINotifyEvent(&"spx_milestone_notification", 2, &"ZM_MINECRAFT_MILESTONE_ROUNDS", 45);
			return var_c614777a;
		}
		case "milestone_completed_round_50":
		{
			var_c614777a = self function_e2091339(8000, 0, 0, 0, &"ZM_MINECRAFT_SCORE_MILESTONE_COMPLETED_ROUND_50", undefined, var_zombie, 1, 90, 1);
			self function_LUINotifyEvent(&"spx_milestone_notification", 2, &"ZM_MINECRAFT_MILESTONE_ROUNDS", 50);
			return var_c614777a;
		}
		case "milestone_completed_round_55":
		{
			var_c614777a = self function_e2091339(9000, 0, 0, 0, &"ZM_MINECRAFT_SCORE_MILESTONE_COMPLETED_ROUND_55", undefined, var_zombie, 1, 100, 1);
			self function_LUINotifyEvent(&"spx_milestone_notification", 2, &"ZM_MINECRAFT_MILESTONE_ROUNDS", 55);
			return var_c614777a;
		}
		case "milestone_completed_round_60":
		{
			var_c614777a = self function_e2091339(10000, 0, 0, 0, &"ZM_MINECRAFT_SCORE_MILESTONE_COMPLETED_ROUND_60", undefined, var_zombie, 1, 110, 1);
			self function_LUINotifyEvent(&"spx_milestone_notification", 2, &"ZM_MINECRAFT_MILESTONE_ROUNDS", 60);
			return var_c614777a;
		}
		case "milestone_completed_round_65":
		{
			var_c614777a = self function_e2091339(11000, 0, 0, 0, &"ZM_MINECRAFT_SCORE_MILESTONE_COMPLETED_ROUND_65", undefined, var_zombie, 1, 120, 1);
			self function_LUINotifyEvent(&"spx_milestone_notification", 2, &"ZM_MINECRAFT_MILESTONE_ROUNDS", 65);
			return var_c614777a;
		}
		case "milestone_completed_round_70":
		{
			var_c614777a = self function_e2091339(12000, 0, 0, 0, &"ZM_MINECRAFT_SCORE_MILESTONE_COMPLETED_ROUND_70", undefined, var_zombie, 1, 130, 1);
			self function_LUINotifyEvent(&"spx_milestone_notification", 2, &"ZM_MINECRAFT_MILESTONE_ROUNDS", 70);
			return var_c614777a;
		}
		case "milestone_completed_round_75":
		{
			var_c614777a = self function_e2091339(13500, 0, 0, 0, &"ZM_MINECRAFT_SCORE_MILESTONE_COMPLETED_ROUND_75", undefined, var_zombie, 1, 145, 1);
			self function_LUINotifyEvent(&"spx_milestone_notification", 2, &"ZM_MINECRAFT_MILESTONE_ROUNDS", 75);
			return var_c614777a;
		}
		case "milestone_completed_round_80":
		{
			var_c614777a = self function_e2091339(15000, 0, 0, 0, &"ZM_MINECRAFT_SCORE_MILESTONE_COMPLETED_ROUND_80", undefined, var_zombie, 1, 160, 1);
			self function_LUINotifyEvent(&"spx_milestone_notification", 2, &"ZM_MINECRAFT_MILESTONE_ROUNDS", 80);
			return var_c614777a;
		}
		case "milestone_completed_round_85":
		{
			var_c614777a = self function_e2091339(16500, 0, 0, 0, &"ZM_MINECRAFT_SCORE_MILESTONE_COMPLETED_ROUND_85", undefined, var_zombie, 1, 175, 1);
			self function_LUINotifyEvent(&"spx_milestone_notification", 2, &"ZM_MINECRAFT_MILESTONE_ROUNDS", 85);
			return var_c614777a;
		}
		case "milestone_completed_round_90":
		{
			var_c614777a = self function_e2091339(18000, 0, 0, 0, &"ZM_MINECRAFT_SCORE_MILESTONE_COMPLETED_ROUND_90", undefined, var_zombie, 1, 190, 1);
			self function_LUINotifyEvent(&"spx_milestone_notification", 2, &"ZM_MINECRAFT_MILESTONE_ROUNDS", 90);
			return var_c614777a;
		}
		case "milestone_completed_round_95":
		{
			var_c614777a = self function_e2091339(20000, 0, 0, 0, &"ZM_MINECRAFT_SCORE_MILESTONE_COMPLETED_ROUND_95", undefined, var_zombie, 1, 210, 1);
			self function_LUINotifyEvent(&"spx_milestone_notification", 2, &"ZM_MINECRAFT_MILESTONE_ROUNDS", 95);
			return var_c614777a;
		}
		case "milestone_completed_round_100":
		{
			var_c614777a = self function_e2091339(22000, 0, 0, 0, &"ZM_MINECRAFT_SCORE_MILESTONE_COMPLETED_ROUND_100", undefined, var_zombie, 1, 230, 1);
			self function_LUINotifyEvent(&"spx_milestone_notification", 2, &"ZM_MINECRAFT_MILESTONE_ROUNDS", 100);
			return var_c614777a;
		}
		case "milestone_completed_round_105":
		{
			var_c614777a = self function_e2091339(24000, 0, 0, 0, &"ZM_MINECRAFT_SCORE_MILESTONE_COMPLETED_ROUND_105", undefined, var_zombie, 1, 250, 1);
			self function_LUINotifyEvent(&"spx_milestone_notification", 2, &"ZM_MINECRAFT_MILESTONE_ROUNDS", 105);
			return var_c614777a;
		}
		case "milestone_completed_round_110":
		{
			var_c614777a = self function_e2091339(26000, 0, 0, 0, &"ZM_MINECRAFT_SCORE_MILESTONE_COMPLETED_ROUND_110", undefined, var_zombie, 1, 270, 1);
			self function_LUINotifyEvent(&"spx_milestone_notification", 2, &"ZM_MINECRAFT_MILESTONE_ROUNDS", 110);
			return var_c614777a;
		}
		case "milestone_completed_round_115":
		{
			var_c614777a = self function_e2091339(28000, 0, 0, 0, &"ZM_MINECRAFT_SCORE_MILESTONE_COMPLETED_ROUND_115", undefined, var_zombie, 1, 290, 1);
			self function_LUINotifyEvent(&"spx_milestone_notification", 2, &"ZM_MINECRAFT_MILESTONE_ROUNDS", 115);
			return var_c614777a;
		}
		case "milestone_completed_round_120":
		{
			var_c614777a = self function_e2091339(30000, 0, 0, 0, &"ZM_MINECRAFT_SCORE_MILESTONE_COMPLETED_ROUND_120", undefined, var_zombie, 1, 310, 1);
			self function_LUINotifyEvent(&"spx_milestone_notification", 2, &"ZM_MINECRAFT_MILESTONE_ROUNDS", 120);
			return var_c614777a;
		}
		case "milestone_completed_round_125":
		{
			var_c614777a = self function_e2091339(32000, 0, 0, 0, &"ZM_MINECRAFT_SCORE_MILESTONE_COMPLETED_ROUND_125", undefined, var_zombie, 1, 330, 1);
			self function_LUINotifyEvent(&"spx_milestone_notification", 2, &"ZM_MINECRAFT_MILESTONE_ROUNDS", 125);
			return var_c614777a;
		}
		case "milestone_completed_round_130":
		{
			var_c614777a = self function_e2091339(35000, 0, 0, 0, &"ZM_MINECRAFT_SCORE_MILESTONE_COMPLETED_ROUND_130", undefined, var_zombie, 1, 360, 1);
			self function_LUINotifyEvent(&"spx_milestone_notification", 2, &"ZM_MINECRAFT_MILESTONE_ROUNDS", 130);
			return var_c614777a;
		}
		case "milestone_completed_round_135":
		{
			var_c614777a = self function_e2091339(38000, 0, 0, 0, &"ZM_MINECRAFT_SCORE_MILESTONE_COMPLETED_ROUND_135", undefined, var_zombie, 1, 390, 1);
			self function_LUINotifyEvent(&"spx_milestone_notification", 2, &"ZM_MINECRAFT_MILESTONE_ROUNDS", 135);
			return var_c614777a;
		}
		case "milestone_completed_round_140":
		{
			var_c614777a = self function_e2091339(41000, 0, 0, 0, &"ZM_MINECRAFT_SCORE_MILESTONE_COMPLETED_ROUND_140", undefined, var_zombie, 1, 420, 1);
			self function_LUINotifyEvent(&"spx_milestone_notification", 2, &"ZM_MINECRAFT_MILESTONE_ROUNDS", 140);
			return var_c614777a;
		}
		case "milestone_completed_round_145":
		{
			var_c614777a = self function_e2091339(44000, 0, 0, 0, &"ZM_MINECRAFT_SCORE_MILESTONE_COMPLETED_ROUND_145", undefined, var_zombie, 1, 450, 1);
			self function_LUINotifyEvent(&"spx_milestone_notification", 2, &"ZM_MINECRAFT_MILESTONE_ROUNDS", 145);
			return var_c614777a;
		}
		case "milestone_completed_round_150":
		{
			var_c614777a = self function_e2091339(48000, 0, 0, 0, &"ZM_MINECRAFT_SCORE_MILESTONE_COMPLETED_ROUND_150", undefined, var_zombie, 1, 490, 1);
			self function_LUINotifyEvent(&"spx_milestone_notification", 2, &"ZM_MINECRAFT_MILESTONE_ROUNDS", 150);
			return var_c614777a;
		}
		case "milestone_completed_round_155":
		{
			var_c614777a = self function_e2091339(51000, 0, 0, 0, &"ZM_MINECRAFT_SCORE_MILESTONE_COMPLETED_ROUND_155", undefined, var_zombie, 1, 530, 1);
			self function_LUINotifyEvent(&"spx_milestone_notification", 2, &"ZM_MINECRAFT_MILESTONE_ROUNDS", 155);
			return var_c614777a;
		}
		case "milestone_completed_round_160":
		{
			var_c614777a = self function_e2091339(55000, 0, 0, 0, &"ZM_MINECRAFT_SCORE_MILESTONE_COMPLETED_ROUND_160", undefined, var_zombie, 1, 570, 1);
			self function_LUINotifyEvent(&"spx_milestone_notification", 2, &"ZM_MINECRAFT_MILESTONE_ROUNDS", 160);
			return var_c614777a;
		}
		case "milestone_completed_round_165":
		{
			var_c614777a = self function_e2091339(59000, 0, 0, 0, &"ZM_MINECRAFT_SCORE_MILESTONE_COMPLETED_ROUND_165", undefined, var_zombie, 1, 600, 1);
			self function_LUINotifyEvent(&"spx_milestone_notification", 2, &"ZM_MINECRAFT_MILESTONE_ROUNDS", 165);
			return var_c614777a;
		}
		case "milestone_completed_round_170":
		{
			var_c614777a = self function_e2091339(63000, 0, 0, 0, &"ZM_MINECRAFT_SCORE_MILESTONE_COMPLETED_ROUND_170", undefined, var_zombie, 1, 630, 1);
			self function_LUINotifyEvent(&"spx_milestone_notification", 2, &"ZM_MINECRAFT_MILESTONE_ROUNDS", 170);
			return var_c614777a;
		}
		case "milestone_completed_round_175":
		{
			var_c614777a = self function_e2091339(67000, 0, 0, 0, &"ZM_MINECRAFT_SCORE_MILESTONE_COMPLETED_ROUND_175", undefined, var_zombie, 1, 660, 1);
			self function_LUINotifyEvent(&"spx_milestone_notification", 2, &"ZM_MINECRAFT_MILESTONE_ROUNDS", 175);
			return var_c614777a;
		}
		case "milestone_completed_round_180":
		{
			var_c614777a = self function_e2091339(71000, 0, 0, 0, &"ZM_MINECRAFT_SCORE_MILESTONE_COMPLETED_ROUND_180", undefined, var_zombie, 1, 690, 1);
			self function_LUINotifyEvent(&"spx_milestone_notification", 2, &"ZM_MINECRAFT_MILESTONE_ROUNDS", 180);
			return var_c614777a;
		}
		case "milestone_completed_round_185":
		{
			var_c614777a = self function_e2091339(75000, 0, 0, 0, &"ZM_MINECRAFT_SCORE_MILESTONE_COMPLETED_ROUND_185", undefined, var_zombie, 1, 720, 1);
			self function_LUINotifyEvent(&"spx_milestone_notification", 2, &"ZM_MINECRAFT_MILESTONE_ROUNDS", 185);
			return var_c614777a;
		}
		case "milestone_completed_round_190":
		{
			var_c614777a = self function_e2091339(80000, 0, 0, 0, &"ZM_MINECRAFT_SCORE_MILESTONE_COMPLETED_ROUND_190", undefined, var_zombie, 1, 760, 1);
			self function_LUINotifyEvent(&"spx_milestone_notification", 2, &"ZM_MINECRAFT_MILESTONE_ROUNDS", 190);
			return var_c614777a;
		}
		case "milestone_completed_round_195":
		{
			var_c614777a = self function_e2091339(85000, 0, 0, 0, &"ZM_MINECRAFT_SCORE_MILESTONE_COMPLETED_ROUND_195", undefined, var_zombie, 1, 800, 1);
			self function_LUINotifyEvent(&"spx_milestone_notification", 2, &"ZM_MINECRAFT_MILESTONE_ROUNDS", 195);
			return var_c614777a;
		}
		case "milestone_completed_round_200":
		{
			var_c614777a = self function_e2091339(90000, 0, 0, 0, &"ZM_MINECRAFT_SCORE_MILESTONE_COMPLETED_ROUND_200", undefined, var_zombie, 1, 840, 1);
			self function_LUINotifyEvent(&"spx_milestone_notification", 2, &"ZM_MINECRAFT_MILESTONE_ROUNDS", 200);
			return var_c614777a;
		}
		case "milestone_completed_round_205":
		{
			var_c614777a = self function_e2091339(95000, 0, 0, 0, &"ZM_MINECRAFT_SCORE_MILESTONE_COMPLETED_ROUND_205", undefined, var_zombie, 1, 880, 1);
			self function_LUINotifyEvent(&"spx_milestone_notification", 2, &"ZM_MINECRAFT_MILESTONE_ROUNDS", 205);
			return var_c614777a;
		}
		case "milestone_completed_round_210":
		{
			var_c614777a = self function_e2091339(100000, 0, 0, 0, &"ZM_MINECRAFT_SCORE_MILESTONE_COMPLETED_ROUND_210", undefined, var_zombie, 1, 920, 1);
			self function_LUINotifyEvent(&"spx_milestone_notification", 2, &"ZM_MINECRAFT_MILESTONE_ROUNDS", 210);
			return var_c614777a;
		}
		case "milestone_completed_round_215":
		{
			var_c614777a = self function_e2091339(105000, 0, 0, 0, &"ZM_MINECRAFT_SCORE_MILESTONE_COMPLETED_ROUND_215", undefined, var_zombie, 1, 960, 1);
			self function_LUINotifyEvent(&"spx_milestone_notification", 2, &"ZM_MINECRAFT_MILESTONE_ROUNDS", 215);
			return var_c614777a;
		}
		case "milestone_completed_round_220":
		{
			var_c614777a = self function_e2091339(110000, 0, 0, 0, &"ZM_MINECRAFT_SCORE_MILESTONE_COMPLETED_ROUND_220", undefined, var_zombie, 1, 1000, 1);
			self function_LUINotifyEvent(&"spx_milestone_notification", 2, &"ZM_MINECRAFT_MILESTONE_ROUNDS", 220);
			return var_c614777a;
		}
		case "milestone_completed_round_225":
		{
			var_c614777a = self function_e2091339(115000, 0, 0, 0, &"ZM_MINECRAFT_SCORE_MILESTONE_COMPLETED_ROUND_225", undefined, var_zombie, 1, 1040, 1);
			self function_LUINotifyEvent(&"spx_milestone_notification", 2, &"ZM_MINECRAFT_MILESTONE_ROUNDS", 225);
			return var_c614777a;
		}
		case "milestone_completed_round_230":
		{
			var_c614777a = self function_e2091339(120000, 0, 0, 0, &"ZM_MINECRAFT_SCORE_MILESTONE_COMPLETED_ROUND_230", undefined, var_zombie, 1, 1080, 1);
			self function_LUINotifyEvent(&"spx_milestone_notification", 2, &"ZM_MINECRAFT_MILESTONE_ROUNDS", 230);
			return var_c614777a;
		}
		case "milestone_completed_round_235":
		{
			var_c614777a = self function_e2091339(125000, 0, 0, 0, &"ZM_MINECRAFT_SCORE_MILESTONE_COMPLETED_ROUND_235", undefined, var_zombie, 1, 1120, 1);
			self function_LUINotifyEvent(&"spx_milestone_notification", 2, &"ZM_MINECRAFT_MILESTONE_ROUNDS", 235);
			return var_c614777a;
		}
		case "milestone_completed_round_240":
		{
			var_c614777a = self function_e2091339(130000, 0, 0, 0, &"ZM_MINECRAFT_SCORE_MILESTONE_COMPLETED_ROUND_240", undefined, var_zombie, 1, 1160, 1);
			self function_LUINotifyEvent(&"spx_milestone_notification", 2, &"ZM_MINECRAFT_MILESTONE_ROUNDS", 240);
			return var_c614777a;
		}
		case "milestone_completed_round_245":
		{
			var_c614777a = self function_e2091339(135000, 0, 0, 0, &"ZM_MINECRAFT_SCORE_MILESTONE_COMPLETED_ROUND_245", undefined, var_zombie, 1, 1200, 1);
			self function_LUINotifyEvent(&"spx_milestone_notification", 2, &"ZM_MINECRAFT_MILESTONE_ROUNDS", 245);
			return var_c614777a;
		}
		case "milestone_completed_round_250":
		{
			var_c614777a = self function_e2091339(140000, 0, 0, 0, &"ZM_MINECRAFT_SCORE_MILESTONE_COMPLETED_ROUND_250", undefined, var_zombie, 1, 1240, 1);
			self function_LUINotifyEvent(&"spx_milestone_notification", 2, &"ZM_MINECRAFT_MILESTONE_ROUNDS", 200);
			return var_c614777a;
		}
		case "milestone_completed_round_255":
		{
			var_c614777a = self function_e2091339(150000, 0, 0, 0, &"ZM_MINECRAFT_SCORE_MILESTONE_COMPLETED_ROUND_255", undefined, var_zombie, 1, 1300, 1);
			self function_LUINotifyEvent(&"spx_milestone_notification", 2, &"ZM_MINECRAFT_MILESTONE_ROUNDS", 255);
			return var_c614777a;
		}
		case "milestone_completed_kills_500":
		{
			var_c614777a = self function_e2091339(4000, 0, 0, 0, &"ZM_MINECRAFT_SCORE_MILESTONE_COMPLETED_KILLS_500", undefined, var_zombie, 1, 10, 1);
			self function_LUINotifyEvent(&"spx_milestone_notification", 2, &"ZM_MINECRAFT_MILESTONE_KILLS", 500);
			return var_c614777a;
		}
		case "milestone_completed_kills_750":
		{
			var_c614777a = self function_e2091339(5000, 0, 0, 0, &"ZM_MINECRAFT_SCORE_MILESTONE_COMPLETED_KILLS_750", undefined, var_zombie, 1, 15, 1);
			self function_LUINotifyEvent(&"spx_milestone_notification", 2, &"ZM_MINECRAFT_MILESTONE_KILLS", 750);
			return var_c614777a;
		}
		case "milestone_completed_kills_1000":
		{
			var_c614777a = self function_e2091339(6000, 0, 0, 0, &"ZM_MINECRAFT_SCORE_MILESTONE_COMPLETED_KILLS_1000", undefined, var_zombie, 1, 20, 1);
			self function_LUINotifyEvent(&"spx_milestone_notification", 2, &"ZM_MINECRAFT_MILESTONE_KILLS", 1000);
			return var_c614777a;
		}
		case "milestone_completed_kills_1500":
		{
			var_c614777a = self function_e2091339(8000, 0, 0, 0, &"ZM_MINECRAFT_SCORE_MILESTONE_COMPLETED_KILLS_1500", undefined, var_zombie, 1, 30, 1);
			self function_LUINotifyEvent(&"spx_milestone_notification", 2, &"ZM_MINECRAFT_MILESTONE_KILLS", 1500);
			return var_c614777a;
		}
		case "milestone_completed_kills_2000":
		{
			var_c614777a = self function_e2091339(10000, 0, 0, 0, &"ZM_MINECRAFT_SCORE_MILESTONE_COMPLETED_KILLS_2000", undefined, var_zombie, 1, 40, 1);
			self function_LUINotifyEvent(&"spx_milestone_notification", 2, &"ZM_MINECRAFT_MILESTONE_KILLS", 2000);
			return var_c614777a;
		}
		case "milestone_completed_kills_3000":
		{
			var_c614777a = self function_e2091339(12000, 0, 0, 0, &"ZM_MINECRAFT_SCORE_MILESTONE_COMPLETED_KILLS_3000", undefined, var_zombie, 1, 60, 1);
			self function_LUINotifyEvent(&"spx_milestone_notification", 2, &"ZM_MINECRAFT_MILESTONE_KILLS", 3000);
			return var_c614777a;
		}
		case "milestone_completed_kills_4000":
		{
			var_c614777a = self function_e2091339(15000, 0, 0, 0, &"ZM_MINECRAFT_SCORE_MILESTONE_COMPLETED_KILLS_4000", undefined, var_zombie, 1, 80, 1);
			self function_LUINotifyEvent(&"spx_milestone_notification", 2, &"ZM_MINECRAFT_MILESTONE_KILLS", 4000);
			return var_c614777a;
		}
		case "milestone_completed_kills_5000":
		{
			var_c614777a = self function_e2091339(18000, 0, 0, 0, &"ZM_MINECRAFT_SCORE_MILESTONE_COMPLETED_KILLS_5000", undefined, var_zombie, 1, 100, 1);
			self function_LUINotifyEvent(&"spx_milestone_notification", 2, &"ZM_MINECRAFT_MILESTONE_KILLS", 5000);
			return var_c614777a;
		}
		case "milestone_completed_kills_7500":
		{
			var_c614777a = self function_e2091339(21000, 0, 0, 0, &"ZM_MINECRAFT_SCORE_MILESTONE_COMPLETED_KILLS_7500", undefined, var_zombie, 1, 150, 1);
			self function_LUINotifyEvent(&"spx_milestone_notification", 2, &"ZM_MINECRAFT_MILESTONE_KILLS", 7500);
			return var_c614777a;
		}
		case "milestone_completed_kills_10000":
		{
			var_c614777a = self function_e2091339(25000, 0, 0, 0, &"ZM_MINECRAFT_SCORE_MILESTONE_COMPLETED_KILLS_10000", undefined, var_zombie, 1, 200, 1);
			self function_LUINotifyEvent(&"spx_milestone_notification", 2, &"ZM_MINECRAFT_MILESTONE_KILLS", 10000);
			return var_c614777a;
		}
		case "milestone_completed_kills_15000":
		{
			var_c614777a = self function_e2091339(33000, 0, 0, 0, &"ZM_MINECRAFT_SCORE_MILESTONE_COMPLETED_KILLS_15000", undefined, var_zombie, 1, 300, 1);
			self function_LUINotifyEvent(&"spx_milestone_notification", 2, &"ZM_MINECRAFT_MILESTONE_KILLS", 15000);
			return var_c614777a;
		}
		case "milestone_completed_kills_20000":
		{
			var_c614777a = self function_e2091339(43000, 0, 0, 0, &"ZM_MINECRAFT_SCORE_MILESTONE_COMPLETED_KILLS_20000", undefined, var_zombie, 1, 400, 1);
			self function_LUINotifyEvent(&"spx_milestone_notification", 2, &"ZM_MINECRAFT_MILESTONE_KILLS", 20000);
			return var_c614777a;
		}
		case "milestone_completed_kills_30000":
		{
			var_c614777a = self function_e2091339(48000, 0, 0, 0, &"ZM_MINECRAFT_SCORE_MILESTONE_COMPLETED_KILLS_30000", undefined, var_zombie, 1, 500, 1);
			self function_LUINotifyEvent(&"spx_milestone_notification", 2, &"ZM_MINECRAFT_MILESTONE_KILLS", 30000);
			return var_c614777a;
		}
		case "milestone_completed_kills_40000":
		{
			var_c614777a = self function_e2091339(54000, 0, 0, 0, &"ZM_MINECRAFT_SCORE_MILESTONE_COMPLETED_KILLS_40000", undefined, var_zombie, 1, 600, 1);
			self function_LUINotifyEvent(&"spx_milestone_notification", 2, &"ZM_MINECRAFT_MILESTONE_KILLS", 40000);
			return var_c614777a;
		}
		case "milestone_completed_kills_50000":
		{
			var_c614777a = self function_e2091339(60000, 0, 0, 0, &"ZM_MINECRAFT_SCORE_MILESTONE_COMPLETED_KILLS_50000", undefined, var_zombie, 1, 700, 1);
			self function_LUINotifyEvent(&"spx_milestone_notification", 2, &"ZM_MINECRAFT_MILESTONE_KILLS", 50000);
			return var_c614777a;
		}
		case "milestone_completed_kills_75000":
		{
			var_c614777a = self function_e2091339(66000, 0, 0, 0, &"ZM_MINECRAFT_SCORE_MILESTONE_COMPLETED_KILLS_75000", undefined, var_zombie, 1, 1000, 1);
			self function_LUINotifyEvent(&"spx_milestone_notification", 2, &"ZM_MINECRAFT_MILESTONE_KILLS", 75000);
			return var_c614777a;
		}
		case "milestone_completed_kills_100000":
		{
			var_c614777a = self function_e2091339(72000, 0, 0, 0, &"ZM_MINECRAFT_SCORE_MILESTONE_COMPLETED_KILLS_100000", undefined, var_zombie, 1, 1300, 1);
			self function_LUINotifyEvent(&"spx_milestone_notification", 2, &"ZM_MINECRAFT_MILESTONE_KILLS", 100000);
			return var_c614777a;
		}
		case "milestone_completed_headshots_250":
		{
			var_c614777a = self function_e2091339(4000, 0, 0, 0, &"ZM_MINECRAFT_SCORE_MILESTONE_COMPLETED_HEADSHOTS_250", undefined, var_zombie, 1, 10, 1);
			self function_LUINotifyEvent(&"spx_milestone_notification", 2, &"ZM_MINECRAFT_MILESTONE_HEADSHOTS", 250);
			return var_c614777a;
		}
		case "milestone_completed_headshots_500":
		{
			var_c614777a = self function_e2091339(5000, 0, 0, 0, &"ZM_MINECRAFT_SCORE_MILESTONE_COMPLETED_HEADSHOTS_500", undefined, var_zombie, 1, 15, 1);
			self function_LUINotifyEvent(&"spx_milestone_notification", 2, &"ZM_MINECRAFT_MILESTONE_HEADSHOTS", 500);
			return var_c614777a;
		}
		case "milestone_completed_headshots_750":
		{
			var_c614777a = self function_e2091339(6000, 0, 0, 0, &"ZM_MINECRAFT_SCORE_MILESTONE_COMPLETED_HEADSHOTS_750", undefined, var_zombie, 1, 20, 1);
			self function_LUINotifyEvent(&"spx_milestone_notification", 2, &"ZM_MINECRAFT_MILESTONE_HEADSHOTS", 750);
			return var_c614777a;
		}
		case "milestone_completed_headshots_1000":
		{
			var_c614777a = self function_e2091339(7000, 0, 0, 0, &"ZM_MINECRAFT_SCORE_MILESTONE_COMPLETED_HEADSHOTS_1000", undefined, var_zombie, 1, 25, 1);
			self function_LUINotifyEvent(&"spx_milestone_notification", 2, &"ZM_MINECRAFT_MILESTONE_HEADSHOTS", 1000);
			return var_c614777a;
		}
		case "milestone_completed_headshots_1250":
		{
			var_c614777a = self function_e2091339(8000, 0, 0, 0, &"ZM_MINECRAFT_SCORE_MILESTONE_COMPLETED_HEADSHOTS_1250", undefined, var_zombie, 1, 30, 1);
			self function_LUINotifyEvent(&"spx_milestone_notification", 2, &"ZM_MINECRAFT_MILESTONE_HEADSHOTS", 1250);
			return var_c614777a;
		}
		case "milestone_completed_headshots_1500":
		{
			var_c614777a = self function_e2091339(10000, 0, 0, 0, &"ZM_MINECRAFT_SCORE_MILESTONE_COMPLETED_HEADSHOTS_1500", undefined, var_zombie, 1, 40, 1);
			self function_LUINotifyEvent(&"spx_milestone_notification", 2, &"ZM_MINECRAFT_MILESTONE_HEADSHOTS", 1500);
			return var_c614777a;
		}
		case "milestone_completed_headshots_1750":
		{
			var_c614777a = self function_e2091339(12000, 0, 0, 0, &"ZM_MINECRAFT_SCORE_MILESTONE_COMPLETED_HEADSHOTS_1750", undefined, var_zombie, 1, 60, 1);
			self function_LUINotifyEvent(&"spx_milestone_notification", 2, &"ZM_MINECRAFT_MILESTONE_HEADSHOTS", 1750);
			return var_c614777a;
		}
		case "milestone_completed_headshots_2000":
		{
			var_c614777a = self function_e2091339(15000, 0, 0, 0, &"ZM_MINECRAFT_SCORE_MILESTONE_COMPLETED_HEADSHOTS_2000", undefined, var_zombie, 1, 80, 1);
			self function_LUINotifyEvent(&"spx_milestone_notification", 2, &"ZM_MINECRAFT_MILESTONE_HEADSHOTS", 2000);
			return var_c614777a;
		}
		case "milestone_completed_headshots_2500":
		{
			var_c614777a = self function_e2091339(18000, 0, 0, 0, &"ZM_MINECRAFT_SCORE_MILESTONE_COMPLETED_HEADSHOTS_2500", undefined, var_zombie, 1, 100, 1);
			self function_LUINotifyEvent(&"spx_milestone_notification", 2, &"ZM_MINECRAFT_MILESTONE_HEADSHOTS", 2500);
			return var_c614777a;
		}
		case "milestone_completed_headshots_3000":
		{
			var_c614777a = self function_e2091339(21000, 0, 0, 0, &"ZM_MINECRAFT_SCORE_MILESTONE_COMPLETED_HEADSHOTS_3000", undefined, var_zombie, 1, 150, 1);
			self function_LUINotifyEvent(&"spx_milestone_notification", 2, &"ZM_MINECRAFT_MILESTONE_HEADSHOTS", 3000);
			return var_c614777a;
		}
		case "milestone_completed_headshots_4000":
		{
			var_c614777a = self function_e2091339(25000, 0, 0, 0, &"ZM_MINECRAFT_SCORE_MILESTONE_COMPLETED_HEADSHOTS_4000", undefined, var_zombie, 1, 200, 1);
			self function_LUINotifyEvent(&"spx_milestone_notification", 2, &"ZM_MINECRAFT_MILESTONE_HEADSHOTS", 4000);
			return var_c614777a;
		}
		case "milestone_completed_headshots_5000":
		{
			var_c614777a = self function_e2091339(33000, 0, 0, 0, &"ZM_MINECRAFT_SCORE_MILESTONE_COMPLETED_HEADSHOTS_5000", undefined, var_zombie, 1, 300, 1);
			self function_LUINotifyEvent(&"spx_milestone_notification", 2, &"ZM_MINECRAFT_MILESTONE_HEADSHOTS", 5000);
			return var_c614777a;
		}
		case "milestone_completed_headshots_7500":
		{
			var_c614777a = self function_e2091339(43000, 0, 0, 0, &"ZM_MINECRAFT_SCORE_MILESTONE_COMPLETED_HEADSHOTS_7500", undefined, var_zombie, 1, 400, 1);
			self function_LUINotifyEvent(&"spx_milestone_notification", 2, &"ZM_MINECRAFT_MILESTONE_HEADSHOTS", 7500);
			return var_c614777a;
		}
		case "milestone_completed_headshots_10000":
		{
			var_c614777a = self function_e2091339(48000, 0, 0, 0, &"ZM_MINECRAFT_SCORE_MILESTONE_COMPLETED_HEADSHOTS_10000", undefined, var_zombie, 1, 500, 1);
			self function_LUINotifyEvent(&"spx_milestone_notification", 2, &"ZM_MINECRAFT_MILESTONE_HEADSHOTS", 10000);
			return var_c614777a;
		}
		case "milestone_completed_headshots_20000":
		{
			var_c614777a = self function_e2091339(54000, 0, 0, 0, &"ZM_MINECRAFT_SCORE_MILESTONE_COMPLETED_HEADSHOTS_20000", undefined, var_zombie, 1, 600, 1);
			self function_LUINotifyEvent(&"spx_milestone_notification", 2, &"ZM_MINECRAFT_MILESTONE_HEADSHOTS", 20000);
			return var_c614777a;
		}
		case "milestone_completed_headshots_30000":
		{
			var_c614777a = self function_e2091339(60000, 0, 0, 0, &"ZM_MINECRAFT_SCORE_MILESTONE_COMPLETED_HEADSHOTS_30000", undefined, var_zombie, 1, 700, 1);
			self function_LUINotifyEvent(&"spx_milestone_notification", 2, &"ZM_MINECRAFT_MILESTONE_HEADSHOTS", 30000);
			return var_c614777a;
		}
		case "milestone_completed_headshots_40000":
		{
			var_c614777a = self function_e2091339(66000, 0, 0, 0, &"ZM_MINECRAFT_SCORE_MILESTONE_COMPLETED_HEADSHOTS_40000", undefined, var_zombie, 1, 1000, 1);
			self function_LUINotifyEvent(&"spx_milestone_notification", 2, &"ZM_MINECRAFT_MILESTONE_HEADSHOTS", 40000);
			return var_c614777a;
		}
		case "milestone_completed_headshots_50000":
		{
			var_c614777a = self function_e2091339(72000, 0, 0, 0, &"ZM_MINECRAFT_SCORE_MILESTONE_COMPLETED_HEADSHOTS_50000", undefined, var_zombie, 1, 1300, 1);
			self function_LUINotifyEvent(&"spx_milestone_notification", 2, &"ZM_MINECRAFT_MILESTONE_HEADSHOTS", 50000);
			return var_c614777a;
		}
		case "milestone_completed_enchantment_2":
		{
			var_c614777a = self function_e2091339(2000, 0, 0, 0, &"ZM_MINECRAFT_SCORE_MILESTONE_COMPLETED_ENCHANTMENT_RARE", undefined, var_zombie, 1, 10, 1);
			self function_LUINotifyEvent(&"spx_milestone_notification", 3, &"ZM_MINECRAFT_MILESTONE_ENCHANTMENTS", 1, &"ZM_MINECRAFT_MILESTONE_COMPLETED_ENCHANTMENT_RARE");
			return var_c614777a;
		}
		case "milestone_completed_enchantment_3":
		{
			var_c614777a = self function_e2091339(3000, 0, 0, 0, &"ZM_MINECRAFT_SCORE_MILESTONE_COMPLETED_ENCHANTMENT_EPIC", undefined, var_zombie, 1, 20, 1);
			self function_LUINotifyEvent(&"spx_milestone_notification", 3, &"ZM_MINECRAFT_MILESTONE_ENCHANTMENTS", 2, &"ZM_MINECRAFT_MILESTONE_COMPLETED_ENCHANTMENT_EPIC");
			return var_c614777a;
		}
		case "milestone_completed_enchantment_4":
		{
			var_c614777a = self function_e2091339(4000, 0, 0, 0, &"ZM_MINECRAFT_SCORE_MILESTONE_COMPLETED_ENCHANTMENT_LEGENDARY", undefined, var_zombie, 1, 40, 1);
			self function_LUINotifyEvent(&"spx_milestone_notification", 3, &"ZM_MINECRAFT_MILESTONE_ENCHANTMENTS", 3, &"ZM_MINECRAFT_MILESTONE_COMPLETED_ENCHANTMENT_LEGENDARY");
			return var_c614777a;
		}
		case "milestone_completed_enchantment_5":
		{
			var_c614777a = self function_e2091339(6000, 0, 0, 0, &"ZM_MINECRAFT_SCORE_MILESTONE_COMPLETED_ENCHANTMENT_MYTHIC", undefined, var_zombie, 1, 60, 1);
			self function_LUINotifyEvent(&"spx_milestone_notification", 3, &"ZM_MINECRAFT_MILESTONE_ENCHANTMENTS", 4, &"ZM_MINECRAFT_MILESTONE_COMPLETED_ENCHANTMENT_MYTHIC");
			return var_c614777a;
		}
		case "milestone_completed_enchantment_6":
		{
			var_c614777a = self function_e2091339(8000, 0, 0, 0, &"ZM_MINECRAFT_SCORE_MILESTONE_COMPLETED_ENCHANTMENT_EXOTIC", undefined, var_zombie, 1, 80, 1);
			self function_LUINotifyEvent(&"spx_milestone_notification", 3, &"ZM_MINECRAFT_MILESTONE_ENCHANTMENTS", 5, &"ZM_MINECRAFT_MILESTONE_COMPLETED_ENCHANTMENT_EXOTIC");
			return var_c614777a;
		}
		case "milestone_completed_enchantment_7":
		{
			var_c614777a = self function_e2091339(11000, 0, 0, 0, &"ZM_MINECRAFT_SCORE_MILESTONE_COMPLETED_ENCHANTMENT_DIVINE", undefined, var_zombie, 1, 110, 1);
			self function_LUINotifyEvent(&"spx_milestone_notification", 3, &"ZM_MINECRAFT_MILESTONE_ENCHANTMENTS", 6, &"ZM_MINECRAFT_MILESTONE_COMPLETED_ENCHANTMENT_DIVINE");
			return var_c614777a;
		}
		case "milestone_completed_enchantment_8":
		{
			var_c614777a = self function_e2091339(14000, 0, 0, 0, &"ZM_MINECRAFT_SCORE_MILESTONE_COMPLETED_ENCHANTMENT_ETERNAL", undefined, var_zombie, 1, 130, 1);
			self function_LUINotifyEvent(&"spx_milestone_notification", 3, &"ZM_MINECRAFT_MILESTONE_ENCHANTMENTS", 7, &"ZM_MINECRAFT_MILESTONE_COMPLETED_ENCHANTMENT_ETERNAL");
			return var_c614777a;
		}
		case "milestone_completed_enchantment_9":
		{
			var_c614777a = self function_e2091339(18000, 0, 0, 0, &"ZM_MINECRAFT_SCORE_MILESTONE_COMPLETED_ENCHANTMENT_COSMIC", undefined, var_zombie, 1, 160, 1);
			self function_LUINotifyEvent(&"spx_milestone_notification", 3, &"ZM_MINECRAFT_MILESTONE_ENCHANTMENTS", 8, &"ZM_MINECRAFT_MILESTONE_COMPLETED_ENCHANTMENT_COSMIC");
			return var_c614777a;
		}
		case "milestone_completed_enchantment_10":
		{
			var_c614777a = self function_e2091339(22000, 0, 0, 0, &"ZM_MINECRAFT_SCORE_MILESTONE_COMPLETED_ENCHANTMENT_CELESTIAL", undefined, var_zombie, 1, 190, 1);
			self function_LUINotifyEvent(&"spx_milestone_notification", 3, &"ZM_MINECRAFT_MILESTONE_ENCHANTMENTS", 9, &"ZM_MINECRAFT_MILESTONE_COMPLETED_ENCHANTMENT_CELESTIAL");
			return var_c614777a;
		}
		case "milestone_completed_enchantment_11":
		{
			var_c614777a = self function_e2091339(26000, 0, 0, 0, &"ZM_MINECRAFT_SCORE_MILESTONE_COMPLETED_ENCHANTMENT_ULTIMATE", undefined, var_zombie, 1, 240, 1);
			self function_LUINotifyEvent(&"spx_milestone_notification", 3, &"ZM_MINECRAFT_MILESTONE_ENCHANTMENTS", 10, &"ZM_MINECRAFT_MILESTONE_COMPLETED_ENCHANTMENT_ULTIMATE");
			return var_c614777a;
		}
		case "succesful_exfil":
		{
			var_c614777a = self function_e2091339(15000, 500, 0, 0, &"ZM_MINECRAFT_SUCCESFUL_EXFIL", undefined, var_zombie, 0, 25, 1);
			return var_c614777a;
		}
		case "camo_1_obtained":
		{
			var_c614777a = self function_e2091339(2500, 0, 0, 0, &"ZM_MINECRAFT_SCORE_MILESTONE_CAMO_OBTAINED", undefined, var_zombie, 0, undefined, 1);
			return var_c614777a;
		}
		case "camo_2_obtained":
		{
			var_c614777a = self function_e2091339(3000, 0, 0, 0, &"ZM_MINECRAFT_SCORE_MILESTONE_CAMO_OBTAINED", undefined, var_zombie, 0, undefined, 1);
			return var_c614777a;
		}
		case "camo_3_obtained":
		{
			var_c614777a = self function_e2091339(4000, 0, 0, 0, &"ZM_MINECRAFT_SCORE_MILESTONE_CAMO_OBTAINED", undefined, var_zombie, 0, undefined, 1);
			return var_c614777a;
		}
		case "camo_4_obtained":
		{
			var_c614777a = self function_e2091339(5000, 0, 0, 0, &"ZM_MINECRAFT_SCORE_MILESTONE_CAMO_OBTAINED", undefined, var_zombie, 0, undefined, 1);
			return var_c614777a;
		}
		case "camo_5_obtained":
		{
			var_c614777a = self function_e2091339(6000, 0, 0, 0, &"ZM_MINECRAFT_SCORE_MILESTONE_CAMO_OBTAINED", undefined, var_zombie, 0, undefined, 1);
			return var_c614777a;
		}
		case "camo_6_obtained":
		{
			var_c614777a = self function_e2091339(8000, 0, 0, 0, &"ZM_MINECRAFT_SCORE_MILESTONE_CAMO_OBTAINED", undefined, var_zombie, 0, undefined, 1);
			return var_c614777a;
		}
		case "camo_7_obtained":
		{
			var_c614777a = self function_e2091339(10000, 0, 0, 0, &"ZM_MINECRAFT_SCORE_MILESTONE_CAMO_OBTAINED", undefined, var_zombie, 0, undefined, 1);
			return var_c614777a;
		}
		case "camo_8_obtained":
		{
			var_c614777a = self function_e2091339(12000, 0, 0, 0, &"ZM_MINECRAFT_SCORE_MILESTONE_CAMO_OBTAINED", undefined, var_zombie, 0, undefined, 1);
			return var_c614777a;
		}
		case "camo_9_obtained":
		{
			var_c614777a = self function_e2091339(14000, 0, 0, 0, &"ZM_MINECRAFT_SCORE_MILESTONE_CAMO_OBTAINED", undefined, var_zombie, 0, undefined, 1);
			return var_c614777a;
		}
		case "camo_10_obtained":
		{
			var_c614777a = self function_e2091339(16000, 0, 0, 0, &"ZM_MINECRAFT_SCORE_MILESTONE_CAMO_OBTAINED", undefined, var_zombie, 0, undefined, 1);
			return var_c614777a;
		}
		case "camo_11_obtained":
		{
			var_c614777a = self function_e2091339(18000, 0, 0, 0, &"ZM_MINECRAFT_SCORE_MILESTONE_CAMO_OBTAINED", undefined, var_zombie, 0, undefined, 1);
			return var_c614777a;
		}
		case "camo_12_obtained":
		{
			var_c614777a = self function_e2091339(20000, 0, 0, 0, &"ZM_MINECRAFT_SCORE_MILESTONE_CAMO_OBTAINED", undefined, var_zombie, 0, undefined, 1);
			return var_c614777a;
		}
		case "camo_13_obtained":
		{
			var_c614777a = self function_e2091339(22000, 0, 0, 0, &"ZM_MINECRAFT_SCORE_MILESTONE_CAMO_OBTAINED", undefined, var_zombie, 0, undefined, 1);
			return var_c614777a;
		}
		case "camo_14_obtained":
		{
			var_c614777a = self function_e2091339(24000, 0, 0, 0, &"ZM_MINECRAFT_SCORE_MILESTONE_CAMO_OBTAINED", undefined, var_zombie, 0, undefined, 1);
			return var_c614777a;
		}
		case "camo_15_obtained":
		{
			var_c614777a = self function_e2091339(26000, 0, 0, 0, &"ZM_MINECRAFT_SCORE_MILESTONE_CAMO_OBTAINED", undefined, var_zombie, 0, undefined, 1);
			return var_c614777a;
		}
		case "camo_16_obtained":
		{
			var_c614777a = self function_e2091339(28000, 0, 0, 0, &"ZM_MINECRAFT_SCORE_MILESTONE_CAMO_OBTAINED", undefined, var_zombie, 0, undefined, 1);
			return var_c614777a;
		}
		case "camo_17_obtained":
		{
			var_c614777a = self function_e2091339(30000, 0, 0, 0, &"ZM_MINECRAFT_SCORE_MILESTONE_CAMO_OBTAINED", undefined, var_zombie, 0, undefined, 1);
			return var_c614777a;
		}
		case "camo_18_obtained":
		{
			var_c614777a = self function_e2091339(32000, 0, 0, 0, &"ZM_MINECRAFT_SCORE_MILESTONE_CAMO_OBTAINED", undefined, var_zombie, 0, undefined, 1);
			return var_c614777a;
		}
		case "camo_19_obtained":
		{
			var_c614777a = self function_e2091339(34000, 0, 0, 0, &"ZM_MINECRAFT_SCORE_MILESTONE_CAMO_OBTAINED", undefined, var_zombie, 0, undefined, 1);
			return var_c614777a;
		}
		case "camo_20_obtained":
		{
			var_c614777a = self function_e2091339(36000, 0, 0, 0, &"ZM_MINECRAFT_SCORE_MILESTONE_CAMO_OBTAINED", undefined, var_zombie, 0, undefined, 1);
			return var_c614777a;
		}
		case "camo_21_obtained":
		{
			var_c614777a = self function_e2091339(38000, 0, 0, 0, &"ZM_MINECRAFT_SCORE_MILESTONE_CAMO_OBTAINED", undefined, var_zombie, 0, undefined, 1);
			return var_c614777a;
		}
		case "camo_22_obtained":
		{
			var_c614777a = self function_e2091339(40000, 0, 0, 0, &"ZM_MINECRAFT_SCORE_MILESTONE_CAMO_OBTAINED", undefined, var_zombie, 0, undefined, 1);
			return var_c614777a;
		}
		case "map_ee_completed_soe":
		{
			var_c614777a = self function_e2091339(125000, 0, 0, 0, &"ZM_MINECRAFT_SCORE_COMPLETED_SOE_EE", undefined, var_zombie, 0, 50, 1);
			self function_LUINotifyEvent(&"spx_milestone_notification", 2, &"ZM_MINECRAFT_COMPLETED_SOE_EE", 1);
			return var_c614777a;
		}
		case "map_ee_completed_giant":
		{
			var_c614777a = self function_e2091339(35000, 0, 0, 0, &"ZM_MINECRAFT_SCORE_COMPLETED_GIANT_EE", undefined, var_zombie, 0, 5, 1);
			self function_LUINotifyEvent(&"spx_milestone_notification", 2, &"ZM_MINECRAFT_COMPLETED_GIANT_EE", 2);
			return var_c614777a;
		}
		case "map_ee_completed_castle":
		{
			var_c614777a = self function_e2091339(125000, 0, 0, 0, &"ZM_MINECRAFT_SCORE_COMPLETED_CASTLE_EE", undefined, var_zombie, 0, 50, 1);
			self function_LUINotifyEvent(&"spx_milestone_notification", 2, &"ZM_MINECRAFT_COMPLETED_CASTLE_EE", 3);
			return var_c614777a;
		}
		case "map_ee_completed_island":
		{
			var_c614777a = self function_e2091339(125000, 0, 0, 0, &"ZM_MINECRAFT_SCORE_COMPLETED_ISLAND_EE", undefined, var_zombie, 0, 50, 1);
			self function_LUINotifyEvent(&"spx_milestone_notification", 2, &"ZM_MINECRAFT_COMPLETED_ISLAND_EE", 4);
			return var_c614777a;
		}
		case "map_ee_completed_gorod":
		{
			var_c614777a = self function_e2091339(125000, 0, 0, 0, &"ZM_MINECRAFT_SCORE_COMPLETED_GOROD_EE", undefined, var_zombie, 0, 50, 1);
			self function_LUINotifyEvent(&"spx_milestone_notification", 2, &"ZM_MINECRAFT_COMPLETED_GOROD_EE", 5);
			return var_c614777a;
		}
		case "map_ee_completed_rev":
		{
			var_c614777a = self function_e2091339(150000, 0, 0, 0, &"ZM_MINECRAFT_SCORE_COMPLETED_REV_EE", undefined, var_zombie, 0, 50, 1);
			self function_LUINotifyEvent(&"spx_milestone_notification", 2, &"ZM_MINECRAFT_COMPLETED_REV_EE", 6);
			return var_c614777a;
		}
		case "map_ee_completed_nacht":
		{
			var_c614777a = self function_e2091339(2500, 0, 0, 0, &"ZM_MINECRAFT_SCORE_COMPLETED_NACHT_EE", undefined, var_zombie, 0, 5, 1);
			self function_LUINotifyEvent(&"spx_milestone_notification", 2, &"ZM_MINECRAFT_COMPLETED_NACHT_EE", 7);
			return var_c614777a;
		}
		case "map_ee_completed_verruckt":
		{
			var_c614777a = self function_e2091339(2500, 0, 0, 0, &"ZM_MINECRAFT_SCORE_COMPLETED_VERRUCKT_EE", undefined, var_zombie, 0, 5, 1);
			self function_LUINotifyEvent(&"spx_milestone_notification", 2, &"ZM_MINECRAFT_COMPLETED_VERRUCKT_EE", 8);
			return var_c614777a;
		}
		case "map_ee_completed_shino":
		{
			var_c614777a = self function_e2091339(2500, 0, 0, 0, &"ZM_MINECRAFT_SCORE_COMPLETED_SHINO_EE", undefined, var_zombie, 0, 5, 1);
			self function_LUINotifyEvent(&"spx_milestone_notification", 2, &"ZM_MINECRAFT_COMPLETED_SHINO_EE", 9);
			return var_c614777a;
		}
		case "map_ee_completed_kino":
		{
			var_c614777a = self function_e2091339(2500, 0, 0, 0, &"ZM_MINECRAFT_SCORE_COMPLETED_KINO_EE", undefined, var_zombie, 0, 5, 1);
			self function_LUINotifyEvent(&"spx_milestone_notification", 2, &"ZM_MINECRAFT_COMPLETED_KINO_EE", 10);
			return var_c614777a;
		}
		case "map_ee_completed_ascension":
		{
			var_c614777a = self function_e2091339(50000, 0, 0, 0, &"ZM_MINECRAFT_SCORE_COMPLETED_ASCENSION_EE", undefined, var_zombie, 0, 25, 1);
			self function_LUINotifyEvent(&"spx_milestone_notification", 2, &"ZM_MINECRAFT_COMPLETED_ASCENSION_EE", 11);
			return var_c614777a;
		}
		case "map_ee_completed_shangri":
		{
			var_c614777a = self function_e2091339(75000, 0, 0, 0, &"ZM_MINECRAFT_SCORE_COMPLETED_SHANGRI_EE", undefined, var_zombie, 0, 30, 1);
			self function_LUINotifyEvent(&"spx_milestone_notification", 2, &"ZM_MINECRAFT_COMPLETED_SHANGRI_EE", 12);
			return var_c614777a;
		}
		case "map_ee_completed_moon":
		{
			var_c614777a = self function_e2091339(125000, 0, 0, 0, &"ZM_MINECRAFT_SCORE_COMPLETED_MOON_EE", undefined, var_zombie, 0, 40, 1);
			self function_LUINotifyEvent(&"spx_milestone_notification", 2, &"ZM_MINECRAFT_COMPLETED_MOON_EE", 13);
			return var_c614777a;
		}
		case "map_ee_completed_origins":
		{
			var_c614777a = self function_e2091339(150000, 0, 0, 0, &"ZM_MINECRAFT_SCORE_COMPLETED_ORIGINS_EE", undefined, var_zombie, 0, 50, 1);
			self function_LUINotifyEvent(&"spx_milestone_notification", 2, &"ZM_MINECRAFT_COMPLETED_ORIGINS_EE", 14);
			return var_c614777a;
		}
		case "map_ee_completed_cotd":
		{
			var_c614777a = self function_e2091339(75000, 0, 0, 0, &"ZM_MINECRAFT_SCORE_COMPLETED_COTD_EE", undefined, var_zombie, 0, 25, 1);
			self function_LUINotifyEvent(&"spx_milestone_notification", 2, &"ZM_MINECRAFT_COMPLETED_COTD_EE", 15);
			return var_c614777a;
		}
		case "map_ee_completed_sanctuary":
		{
			var_c614777a = self function_e2091339(50000, 0, 0, 0, &"ZM_MINECRAFT_SCORE_COMPLETED_SANCTUARY_EE", undefined, var_zombie, 0, 15, 1);
			self function_LUINotifyEvent(&"spx_milestone_notification", 2, &"ZM_MINECRAFT_COMPLETED_SANCTUARY_EE", 16);
			return var_c614777a;
		}
		case "map_ee_completed_motd":
		{
			var_c614777a = self function_e2091339(12500, 0, 0, 0, &"ZM_MINECRAFT_SCORE_COMPLETED_MOTD_EE", undefined, var_zombie, 0, 15, 1);
			self function_LUINotifyEvent(&"spx_milestone_notification", 2, &"ZM_MINECRAFT_COMPLETED_MOTD_EE", 17);
			return var_c614777a;
		}
		case "map_ee_completed":
		{
			var_c614777a = self function_e2091339(12500, 0, 0, 0, &"ZM_MINECRAFT_SCORE_COMPLETED_GENERIC_EE", undefined, var_zombie, 0, 15, 1);
			self function_LUINotifyEvent(&"spx_milestone_notification", 2, &"ZM_MINECRAFT_COMPLETED_GENERIC_EE", 18);
			return var_c614777a;
		}
		case "daily_challenge":
		{
			var_c614777a = self function_e2091339(var_amount, 0, 0, 0, &"ZM_MINECRAFT_SCORE_DAILY_CHALLENGE", undefined, var_zombie, 0, undefined, 1);
			self function_LUINotifyEvent(&"spx_milestone_notification", 3, &"ZM_MINECRAFT_DAILY_CHALLENGE", 8, &"ZM_MINECRAFT_DAILY_CHALLENGE");
			return var_c614777a;
		}
		case "christmas_present":
		{
			var_c614777a = self function_e2091339(var_amount, 0, 0, 0, &"ZM_MINECRAFT_SCORE_PICKUP_PRESENT", undefined, var_zombie);
			return var_c614777a;
		}
		case "ghost_soul":
		{
			var_c614777a = self function_e2091339(var_amount, 0, 0, 0, &"ZM_MINECRAFT_SCORE_PICKUP_GHOST_SOUL", undefined, var_zombie);
			return var_c614777a;
		}
		case "xp_reward":
		{
			var_c614777a = self function_e2091339(var_amount, 0, 0, 0, &"ZM_MINECRAFT_XP_REWARD", undefined, var_zombie);
			return var_c614777a;
		}
		case "picked_up_full_ammo":
		{
			var_c614777a = self function_e2091339(500, 0, 0, 0, &"ZM_MINECRAFT_POWERUP_MAX_AMMO", undefined, var_zombie);
			return var_c614777a;
		}
		case "picked_up_double_points":
		{
			var_c614777a = self function_e2091339(500, 0, 0, 0, &"ZM_MINECRAFT_POWERUP_DOUBLE_POINTS", undefined, var_zombie);
			return var_c614777a;
		}
		case "picked_up_insta_kill":
		{
			var_c614777a = self function_e2091339(400, 0, 0, 0, &"ZM_MINECRAFT_POWERUP_INSTA_KILL", undefined, var_zombie);
			return var_c614777a;
		}
		case "picked_up_carpenter":
		{
			var_c614777a = self function_e2091339(1000, 0, 0, 0, &"ZM_MINECRAFT_POWERUP_CARPENTER", undefined, var_zombie);
			return var_c614777a;
		}
		case "picked_up_fire_sale":
		{
			var_c614777a = self function_e2091339(500, 0, 0, 0, &"ZM_MINECRAFT_POWERUP_FIRE_SALE", undefined, var_zombie);
			return var_c614777a;
		}
		case "picked_up_minigun":
		{
			var_c614777a = self function_e2091339(400, 0, 0, 0, &"ZM_MINECRAFT_POWERUP_MINIGUN", undefined, var_zombie);
			return var_c614777a;
		}
		case "picked_up_nuke":
		{
			var_c614777a = self function_e2091339(800, 0, 0, 0, &"ZM_MINECRAFT_POWERUP_NUKE", undefined, var_zombie);
			return var_c614777a;
		}
		case "picked_up_bonus_points_team":
		{
			var_c614777a = self function_e2091339(250, 0, 0, 0, &"ZM_MINECRAFT_POWERUP_BONUS_POINTS", undefined, var_zombie);
			return var_c614777a;
		}
	}
	switch(var_type)
	{
		case "challenge_map0_motd_rounds":
		{
			var_c614777a = self function_e2091339(var_amount, 0, 0, 0, &"ZM_MINECRAFT_SCORE_DAILY_CHALLENGE", undefined, var_zombie, 0, undefined, 1);
			self function_LUINotifyEvent(&"spx_milestone_notification", 3, &"ZM_MINECRAFT_CHALLENGE_COMPLETED", 8, 1);
			return var_c614777a;
		}
		case "challenge_map0_motd_kills":
		{
			var_c614777a = self function_e2091339(var_amount, 0, 0, 0, &"ZM_MINECRAFT_SCORE_DAILY_CHALLENGE", undefined, var_zombie, 0, undefined, 1);
			self function_LUINotifyEvent(&"spx_milestone_notification", 3, &"ZM_MINECRAFT_CHALLENGE_COMPLETED", 8, 2);
			return var_c614777a;
		}
		case "challenge_map0_motd_escape":
		{
			var_c614777a = self function_e2091339(var_amount, 0, 0, 0, &"ZM_MINECRAFT_SCORE_DAILY_CHALLENGE", undefined, var_zombie, 0, undefined, 1);
			self function_LUINotifyEvent(&"spx_milestone_notification", 3, &"ZM_MINECRAFT_CHALLENGE_COMPLETED", 8, 3);
			return var_c614777a;
		}
		case "challenge_map0_motd_golden_escape":
		{
			var_c614777a = self function_e2091339(var_amount, 0, 0, 0, &"ZM_MINECRAFT_SCORE_DAILY_CHALLENGE", undefined, var_zombie, 0, undefined, 1);
			self function_LUINotifyEvent(&"spx_milestone_notification", 3, &"ZM_MINECRAFT_CHALLENGE_COMPLETED", 8, 4);
			return var_c614777a;
		}
		case "challenge_map0_motd_headshots":
		{
			var_c614777a = self function_e2091339(var_amount, 0, 0, 0, &"ZM_MINECRAFT_SCORE_DAILY_CHALLENGE", undefined, var_zombie, 0, undefined, 1);
			self function_LUINotifyEvent(&"spx_milestone_notification", 3, &"ZM_MINECRAFT_CHALLENGE_COMPLETED", 8, 5);
			return var_c614777a;
		}
		case "challenge_map0_motd_perks":
		{
			var_c614777a = self function_e2091339(var_amount, 0, 0, 0, &"ZM_MINECRAFT_SCORE_DAILY_CHALLENGE", undefined, var_zombie, 0, undefined, 1);
			self function_LUINotifyEvent(&"spx_milestone_notification", 3, &"ZM_MINECRAFT_CHALLENGE_COMPLETED", 8, 6);
			return var_c614777a;
		}
		case "challenge_map0_motd_revive":
		{
			var_c614777a = self function_e2091339(var_amount, 0, 0, 0, &"ZM_MINECRAFT_SCORE_DAILY_CHALLENGE", undefined, var_zombie, 0, undefined, 1);
			self function_LUINotifyEvent(&"spx_milestone_notification", 3, &"ZM_MINECRAFT_CHALLENGE_COMPLETED", 8, 7);
			return var_c614777a;
		}
		case "challenge_map0_motd_dog_heads":
		{
			var_c614777a = self function_e2091339(var_amount, 0, 0, 0, &"ZM_MINECRAFT_SCORE_DAILY_CHALLENGE", undefined, var_zombie, 0, undefined, 1);
			self function_LUINotifyEvent(&"spx_milestone_notification", 3, &"ZM_MINECRAFT_CHALLENGE_COMPLETED", 8, 8);
			return var_c614777a;
		}
		case "challenge_map0_motd_blundergat":
		{
			var_c614777a = self function_e2091339(var_amount, 0, 0, 0, &"ZM_MINECRAFT_SCORE_DAILY_CHALLENGE", undefined, var_zombie, 0, undefined, 1);
			self function_LUINotifyEvent(&"spx_milestone_notification", 3, &"ZM_MINECRAFT_CHALLENGE_COMPLETED", 8, 9);
			return var_c614777a;
		}
		case "challenge_map0_motd_bridge_kills":
		{
			var_c614777a = self function_e2091339(var_amount, 0, 0, 0, &"ZM_MINECRAFT_SCORE_DAILY_CHALLENGE", undefined, var_zombie, 0, undefined, 1);
			self function_LUINotifyEvent(&"spx_milestone_notification", 3, &"ZM_MINECRAFT_CHALLENGE_COMPLETED", 8, 10);
			return var_c614777a;
		}
		case "challenge_map0_motd_warden_kills":
		{
			var_c614777a = self function_e2091339(var_amount, 0, 0, 0, &"ZM_MINECRAFT_SCORE_DAILY_CHALLENGE", undefined, var_zombie, 0, undefined, 1);
			self function_LUINotifyEvent(&"spx_milestone_notification", 3, &"ZM_MINECRAFT_CHALLENGE_COMPLETED", 8, 11);
			return var_c614777a;
		}
		case "challenge_map0_motd_hells_retriever":
		{
			var_c614777a = self function_e2091339(var_amount, 0, 0, 0, &"ZM_MINECRAFT_SCORE_DAILY_CHALLENGE", undefined, var_zombie, 0, undefined, 1);
			self function_LUINotifyEvent(&"spx_milestone_notification", 3, &"ZM_MINECRAFT_CHALLENGE_COMPLETED", 8, 12);
			return var_c614777a;
		}
		case "challenge_map0_motd_complete_ee":
		{
			var_c614777a = self function_e2091339(var_amount, 0, 0, 0, &"ZM_MINECRAFT_SCORE_DAILY_CHALLENGE", undefined, var_zombie, 0, undefined, 1);
			self function_LUINotifyEvent(&"spx_milestone_notification", 3, &"ZM_MINECRAFT_CHALLENGE_COMPLETED", 8, 98);
			return var_c614777a;
		}
		case "challenge_map0_motd_pack_a_punched":
		{
			var_c614777a = self function_e2091339(var_amount, 0, 0, 0, &"ZM_MINECRAFT_SCORE_DAILY_CHALLENGE", undefined, var_zombie, 0, undefined, 1);
			self function_LUINotifyEvent(&"spx_milestone_notification", 3, &"ZM_MINECRAFT_CHALLENGE_COMPLETED", 8, 13);
			return var_c614777a;
		}
		case "challenge_map0_motd_pack_a_punched_multiple":
		{
			var_c614777a = self function_e2091339(var_amount, 0, 0, 0, &"ZM_MINECRAFT_SCORE_DAILY_CHALLENGE", undefined, var_zombie, 0, undefined, 1);
			self function_LUINotifyEvent(&"spx_milestone_notification", 3, &"ZM_MINECRAFT_CHALLENGE_COMPLETED", 8, 14);
			return var_c614777a;
		}
		case "challenge_map0_motd_pack_a_punched_multiple_2":
		{
			var_c614777a = self function_e2091339(var_amount, 0, 0, 0, &"ZM_MINECRAFT_SCORE_DAILY_CHALLENGE", undefined, var_zombie, 0, undefined, 1);
			self function_LUINotifyEvent(&"spx_milestone_notification", 3, &"ZM_MINECRAFT_CHALLENGE_COMPLETED", 8, 15);
			return var_c614777a;
		}
		case "challenge_map0_motd_enchantment_kills":
		{
			var_c614777a = self function_e2091339(var_amount, 0, 0, 0, &"ZM_MINECRAFT_SCORE_DAILY_CHALLENGE", undefined, var_zombie, 0, undefined, 1);
			self function_LUINotifyEvent(&"spx_milestone_notification", 3, &"ZM_MINECRAFT_CHALLENGE_COMPLETED", 8, 16);
			return var_c614777a;
		}
		case "challenge_map0_motd_enchantment_kills_2":
		{
			var_c614777a = self function_e2091339(var_amount, 0, 0, 0, &"ZM_MINECRAFT_SCORE_DAILY_CHALLENGE", undefined, var_zombie, 0, undefined, 1);
			self function_LUINotifyEvent(&"spx_milestone_notification", 3, &"ZM_MINECRAFT_CHALLENGE_COMPLETED", 8, 17);
			return var_c614777a;
		}
		case "challenge_map0_motd_enchantment_kills_3":
		{
			var_c614777a = self function_e2091339(var_amount, 0, 0, 0, &"ZM_MINECRAFT_SCORE_DAILY_CHALLENGE", undefined, var_zombie, 0, undefined, 1);
			self function_LUINotifyEvent(&"spx_milestone_notification", 3, &"ZM_MINECRAFT_CHALLENGE_COMPLETED", 8, 18);
			return var_c614777a;
		}
		case "challenge_map0_motd_complete_all":
		{
			var_c614777a = self function_e2091339(var_amount, 0, 0, 0, &"ZM_MINECRAFT_SCORE_DAILY_CHALLENGE", undefined, var_zombie, 0, undefined, 1);
			self function_LUINotifyEvent(&"spx_milestone_notification", 3, &"ZM_MINECRAFT_CHALLENGE_COMPLETED", 8, 96);
			return var_c614777a;
		}
		case "challenge_map0_skyblock_rounds":
		{
			var_c614777a = self function_e2091339(var_amount, 0, 0, 0, &"ZM_MINECRAFT_SCORE_DAILY_CHALLENGE", undefined, var_zombie, 0, undefined, 1);
			self function_LUINotifyEvent(&"spx_milestone_notification", 3, &"ZM_MINECRAFT_CHALLENGE_COMPLETED", 8, 19);
			return var_c614777a;
		}
		case "challenge_map0_skyblock_kills":
		{
			var_c614777a = self function_e2091339(var_amount, 0, 0, 0, &"ZM_MINECRAFT_SCORE_DAILY_CHALLENGE", undefined, var_zombie, 0, undefined, 1);
			self function_LUINotifyEvent(&"spx_milestone_notification", 3, &"ZM_MINECRAFT_CHALLENGE_COMPLETED", 8, 20);
			return var_c614777a;
		}
		case "challenge_map0_skyblock_longshots":
		{
			var_c614777a = self function_e2091339(var_amount, 0, 0, 0, &"ZM_MINECRAFT_SCORE_DAILY_CHALLENGE", undefined, var_zombie, 0, undefined, 1);
			self function_LUINotifyEvent(&"spx_milestone_notification", 3, &"ZM_MINECRAFT_CHALLENGE_COMPLETED", 8, 21);
			return var_c614777a;
		}
		case "challenge_map0_skyblock_ads":
		{
			var_c614777a = self function_e2091339(var_amount, 0, 0, 0, &"ZM_MINECRAFT_SCORE_DAILY_CHALLENGE", undefined, var_zombie, 0, undefined, 1);
			self function_LUINotifyEvent(&"spx_milestone_notification", 3, &"ZM_MINECRAFT_CHALLENGE_COMPLETED", 8, 22);
			return var_c614777a;
		}
		case "challenge_map0_skyblock_enchantment":
		{
			var_c614777a = self function_e2091339(var_amount, 0, 0, 0, &"ZM_MINECRAFT_SCORE_DAILY_CHALLENGE", undefined, var_zombie, 0, undefined, 1);
			self function_LUINotifyEvent(&"spx_milestone_notification", 3, &"ZM_MINECRAFT_CHALLENGE_COMPLETED", 8, 23);
			return var_c614777a;
		}
		case "challenge_map0_skyblock_headshots":
		{
			var_c614777a = self function_e2091339(var_amount, 0, 0, 0, &"ZM_MINECRAFT_SCORE_DAILY_CHALLENGE", undefined, var_zombie, 0, undefined, 1);
			self function_LUINotifyEvent(&"spx_milestone_notification", 3, &"ZM_MINECRAFT_CHALLENGE_COMPLETED", 8, 24);
			return var_c614777a;
		}
		case "challenge_map0_skyblock_perks":
		{
			var_c614777a = self function_e2091339(var_amount, 0, 0, 0, &"ZM_MINECRAFT_SCORE_DAILY_CHALLENGE", undefined, var_zombie, 0, undefined, 1);
			self function_LUINotifyEvent(&"spx_milestone_notification", 3, &"ZM_MINECRAFT_CHALLENGE_COMPLETED", 8, 25);
			return var_c614777a;
		}
		case "challenge_map0_skyblock_end_kills":
		{
			var_c614777a = self function_e2091339(var_amount, 0, 0, 0, &"ZM_MINECRAFT_SCORE_DAILY_CHALLENGE", undefined, var_zombie, 0, undefined, 1);
			self function_LUINotifyEvent(&"spx_milestone_notification", 3, &"ZM_MINECRAFT_CHALLENGE_COMPLETED", 8, 91);
			return var_c614777a;
		}
		case "challenge_map0_skyblock_desert_kills":
		{
			var_c614777a = self function_e2091339(var_amount, 0, 0, 0, &"ZM_MINECRAFT_SCORE_DAILY_CHALLENGE", undefined, var_zombie, 0, undefined, 1);
			self function_LUINotifyEvent(&"spx_milestone_notification", 3, &"ZM_MINECRAFT_CHALLENGE_COMPLETED", 8, 92);
			return var_c614777a;
		}
		case "challenge_map0_skyblock_enchantment_ritual_kills":
		{
			var_c614777a = self function_e2091339(var_amount, 0, 0, 0, &"ZM_MINECRAFT_SCORE_DAILY_CHALLENGE", undefined, var_zombie, 0, undefined, 1);
			self function_LUINotifyEvent(&"spx_milestone_notification", 3, &"ZM_MINECRAFT_CHALLENGE_COMPLETED", 8, 93);
			return var_c614777a;
		}
		case "challenge_map0_skyblock_wildlands_kills":
		{
			var_c614777a = self function_e2091339(var_amount, 0, 0, 0, &"ZM_MINECRAFT_SCORE_DAILY_CHALLENGE", undefined, var_zombie, 0, undefined, 1);
			self function_LUINotifyEvent(&"spx_milestone_notification", 3, &"ZM_MINECRAFT_CHALLENGE_COMPLETED", 8, 94);
			return var_c614777a;
		}
		case "challenge_map0_skyblock_complete_all":
		{
			var_c614777a = self function_e2091339(var_amount, 0, 0, 0, &"ZM_MINECRAFT_SCORE_DAILY_CHALLENGE", undefined, var_zombie, 0, undefined, 1);
			self function_LUINotifyEvent(&"spx_milestone_notification", 3, &"ZM_MINECRAFT_CHALLENGE_COMPLETED", 8, 95);
			return var_c614777a;
		}
		case "challenge_map0_verruckt_rounds":
		{
			var_c614777a = self function_e2091339(var_amount, 0, 0, 0, &"ZM_MINECRAFT_SCORE_DAILY_CHALLENGE", undefined, var_zombie, 0, undefined, 1);
			self function_LUINotifyEvent(&"spx_milestone_notification", 3, &"ZM_MINECRAFT_CHALLENGE_COMPLETED", 8, 26);
			return var_c614777a;
		}
		case "challenge_map0_verruckt_kills":
		{
			var_c614777a = self function_e2091339(var_amount, 0, 0, 0, &"ZM_MINECRAFT_SCORE_DAILY_CHALLENGE", undefined, var_zombie, 0, undefined, 1);
			self function_LUINotifyEvent(&"spx_milestone_notification", 3, &"ZM_MINECRAFT_CHALLENGE_COMPLETED", 8, 27);
			return var_c614777a;
		}
		case "challenge_map0_verruckt_headshots":
		{
			var_c614777a = self function_e2091339(var_amount, 0, 0, 0, &"ZM_MINECRAFT_SCORE_DAILY_CHALLENGE", undefined, var_zombie, 0, undefined, 1);
			self function_LUINotifyEvent(&"spx_milestone_notification", 3, &"ZM_MINECRAFT_CHALLENGE_COMPLETED", 8, 28);
			return var_c614777a;
		}
		case "challenge_map0_verruckt_longshots":
		{
			var_c614777a = self function_e2091339(var_amount, 0, 0, 0, &"ZM_MINECRAFT_SCORE_DAILY_CHALLENGE", undefined, var_zombie, 0, undefined, 1);
			self function_LUINotifyEvent(&"spx_milestone_notification", 3, &"ZM_MINECRAFT_CHALLENGE_COMPLETED", 8, 29);
			return var_c614777a;
		}
		case "challenge_map0_verruckt_ads":
		{
			var_c614777a = self function_e2091339(var_amount, 0, 0, 0, &"ZM_MINECRAFT_SCORE_DAILY_CHALLENGE", undefined, var_zombie, 0, undefined, 1);
			self function_LUINotifyEvent(&"spx_milestone_notification", 3, &"ZM_MINECRAFT_CHALLENGE_COMPLETED", 8, 30);
			return var_c614777a;
		}
		case "challenge_map0_verruckt_pack":
		{
			var_c614777a = self function_e2091339(var_amount, 0, 0, 0, &"ZM_MINECRAFT_SCORE_DAILY_CHALLENGE", undefined, var_zombie, 0, undefined, 1);
			self function_LUINotifyEvent(&"spx_milestone_notification", 3, &"ZM_MINECRAFT_CHALLENGE_COMPLETED", 8, 31);
			return var_c614777a;
		}
		case "challenge_map0_verruckt_perks":
		{
			var_c614777a = self function_e2091339(var_amount, 0, 0, 0, &"ZM_MINECRAFT_SCORE_DAILY_CHALLENGE", undefined, var_zombie, 0, undefined, 1);
			self function_LUINotifyEvent(&"spx_milestone_notification", 3, &"ZM_MINECRAFT_CHALLENGE_COMPLETED", 8, 32);
			return var_c614777a;
		}
		case "challenge_map0_shinonuma_rounds":
		{
			var_c614777a = self function_e2091339(var_amount, 0, 0, 0, &"ZM_MINECRAFT_SCORE_DAILY_CHALLENGE", undefined, var_zombie, 0, undefined, 1);
			self function_LUINotifyEvent(&"spx_milestone_notification", 3, &"ZM_MINECRAFT_CHALLENGE_COMPLETED", 8, 33);
			return var_c614777a;
		}
		case "challenge_map0_shinonuma_kills":
		{
			var_c614777a = self function_e2091339(var_amount, 0, 0, 0, &"ZM_MINECRAFT_SCORE_DAILY_CHALLENGE", undefined, var_zombie, 0, undefined, 1);
			self function_LUINotifyEvent(&"spx_milestone_notification", 3, &"ZM_MINECRAFT_CHALLENGE_COMPLETED", 8, 34);
			return var_c614777a;
		}
		case "challenge_map0_shinonuma_headshots":
		{
			var_c614777a = self function_e2091339(var_amount, 0, 0, 0, &"ZM_MINECRAFT_SCORE_DAILY_CHALLENGE", undefined, var_zombie, 0, undefined, 1);
			self function_LUINotifyEvent(&"spx_milestone_notification", 3, &"ZM_MINECRAFT_CHALLENGE_COMPLETED", 8, 35);
			return var_c614777a;
		}
		case "challenge_map0_shinonuma_longshots":
		{
			var_c614777a = self function_e2091339(var_amount, 0, 0, 0, &"ZM_MINECRAFT_SCORE_DAILY_CHALLENGE", undefined, var_zombie, 0, undefined, 1);
			self function_LUINotifyEvent(&"spx_milestone_notification", 3, &"ZM_MINECRAFT_CHALLENGE_COMPLETED", 8, 36);
			return var_c614777a;
		}
		case "challenge_map0_shinonuma_ads":
		{
			var_c614777a = self function_e2091339(var_amount, 0, 0, 0, &"ZM_MINECRAFT_SCORE_DAILY_CHALLENGE", undefined, var_zombie, 0, undefined, 1);
			self function_LUINotifyEvent(&"spx_milestone_notification", 3, &"ZM_MINECRAFT_CHALLENGE_COMPLETED", 8, 37);
			return var_c614777a;
		}
		case "challenge_map0_shinonuma_pack":
		{
			var_c614777a = self function_e2091339(var_amount, 0, 0, 0, &"ZM_MINECRAFT_SCORE_DAILY_CHALLENGE", undefined, var_zombie, 0, undefined, 1);
			self function_LUINotifyEvent(&"spx_milestone_notification", 3, &"ZM_MINECRAFT_CHALLENGE_COMPLETED", 8, 38);
			return var_c614777a;
		}
		case "challenge_map0_shinonuma_perks":
		{
			var_c614777a = self function_e2091339(var_amount, 0, 0, 0, &"ZM_MINECRAFT_SCORE_DAILY_CHALLENGE", undefined, var_zombie, 0, undefined, 1);
			self function_LUINotifyEvent(&"spx_milestone_notification", 3, &"ZM_MINECRAFT_CHALLENGE_COMPLETED", 8, 39);
			return var_c614777a;
		}
		case "challenge_map0_shoothouse_rounds":
		{
			var_c614777a = self function_e2091339(var_amount, 0, 0, 0, &"ZM_MINECRAFT_SCORE_DAILY_CHALLENGE", undefined, var_zombie, 0, undefined, 1);
			self function_LUINotifyEvent(&"spx_milestone_notification", 3, &"ZM_MINECRAFT_CHALLENGE_COMPLETED", 8, 40);
			return var_c614777a;
		}
		case "challenge_map0_shoothouse_kills":
		{
			var_c614777a = self function_e2091339(var_amount, 0, 0, 0, &"ZM_MINECRAFT_SCORE_DAILY_CHALLENGE", undefined, var_zombie, 0, undefined, 1);
			self function_LUINotifyEvent(&"spx_milestone_notification", 3, &"ZM_MINECRAFT_CHALLENGE_COMPLETED", 8, 41);
			return var_c614777a;
		}
		case "challenge_map0_shoothouse_longshots":
		{
			var_c614777a = self function_e2091339(var_amount, 0, 0, 0, &"ZM_MINECRAFT_SCORE_DAILY_CHALLENGE", undefined, var_zombie, 0, undefined, 1);
			self function_LUINotifyEvent(&"spx_milestone_notification", 3, &"ZM_MINECRAFT_CHALLENGE_COMPLETED", 8, 42);
			return var_c614777a;
		}
		case "challenge_map0_shoothouse_ads":
		{
			var_c614777a = self function_e2091339(var_amount, 0, 0, 0, &"ZM_MINECRAFT_SCORE_DAILY_CHALLENGE", undefined, var_zombie, 0, undefined, 1);
			self function_LUINotifyEvent(&"spx_milestone_notification", 3, &"ZM_MINECRAFT_CHALLENGE_COMPLETED", 8, 43);
			return var_c614777a;
		}
		case "challenge_map0_shoothouse_box":
		{
			var_c614777a = self function_e2091339(var_amount, 0, 0, 0, &"ZM_MINECRAFT_SCORE_DAILY_CHALLENGE", undefined, var_zombie, 0, undefined, 1);
			self function_LUINotifyEvent(&"spx_milestone_notification", 3, &"ZM_MINECRAFT_CHALLENGE_COMPLETED", 8, 44);
			return var_c614777a;
		}
		case "challenge_map0_shoothouse_crouch":
		{
			var_c614777a = self function_e2091339(var_amount, 0, 0, 0, &"ZM_MINECRAFT_SCORE_DAILY_CHALLENGE", undefined, var_zombie, 0, undefined, 1);
			self function_LUINotifyEvent(&"spx_milestone_notification", 3, &"ZM_MINECRAFT_CHALLENGE_COMPLETED", 8, 45);
			return var_c614777a;
		}
		case "challenge_map0_shoothouse_headshots":
		{
			var_c614777a = self function_e2091339(var_amount, 0, 0, 0, &"ZM_MINECRAFT_SCORE_DAILY_CHALLENGE", undefined, var_zombie, 0, undefined, 1);
			self function_LUINotifyEvent(&"spx_milestone_notification", 3, &"ZM_MINECRAFT_CHALLENGE_COMPLETED", 8, 46);
			return var_c614777a;
		}
		case "challenge_map0_shoothouse_pack":
		{
			var_c614777a = self function_e2091339(var_amount, 0, 0, 0, &"ZM_MINECRAFT_SCORE_DAILY_CHALLENGE", undefined, var_zombie, 0, undefined, 1);
			self function_LUINotifyEvent(&"spx_milestone_notification", 3, &"ZM_MINECRAFT_CHALLENGE_COMPLETED", 8, 47);
			return var_c614777a;
		}
		case "challenge_cc2_massacre_undead":
		{
			var_c614777a = self function_e2091339(var_amount, 0, 0, 0, &"ZM_MINECRAFT_SCORE_DAILY_CHALLENGE", undefined, var_zombie, 0, undefined, 1);
			self function_LUINotifyEvent(&"spx_milestone_notification", 3, &"ZM_MINECRAFT_CHALLENGE_COMPLETED", 8, 48);
			return var_c614777a;
		}
		case "challenge_cc2_headshot_hunter":
		{
			var_c614777a = self function_e2091339(var_amount, 0, 0, 0, &"ZM_MINECRAFT_SCORE_DAILY_CHALLENGE", undefined, var_zombie, 0, undefined, 1);
			self function_LUINotifyEvent(&"spx_milestone_notification", 3, &"ZM_MINECRAFT_CHALLENGE_COMPLETED", 8, 49);
			return var_c614777a;
		}
		case "challenge_cc2_round_master":
		{
			var_c614777a = self function_e2091339(var_amount, 0, 0, 0, &"ZM_MINECRAFT_SCORE_DAILY_CHALLENGE", undefined, var_zombie, 0, undefined, 1);
			self function_LUINotifyEvent(&"spx_milestone_notification", 3, &"ZM_MINECRAFT_CHALLENGE_COMPLETED", 8, 50);
			return var_c614777a;
		}
		case "challenge_cc2_big_spender":
		{
			var_c614777a = self function_e2091339(var_amount, 0, 0, 0, &"ZM_MINECRAFT_SCORE_DAILY_CHALLENGE", undefined, var_zombie, 0, undefined, 1);
			self function_LUINotifyEvent(&"spx_milestone_notification", 3, &"ZM_MINECRAFT_CHALLENGE_COMPLETED", 8, 51);
			return var_c614777a;
		}
		case "challenge_cc2_box_hoarder":
		{
			var_c614777a = self function_e2091339(var_amount, 0, 0, 0, &"ZM_MINECRAFT_SCORE_DAILY_CHALLENGE", undefined, var_zombie, 0, undefined, 1);
			self function_LUINotifyEvent(&"spx_milestone_notification", 3, &"ZM_MINECRAFT_CHALLENGE_COMPLETED", 8, 52);
			return var_c614777a;
		}
		case "challenge_cc2_perk_enthusiast":
		{
			var_c614777a = self function_e2091339(var_amount, 0, 0, 0, &"ZM_MINECRAFT_SCORE_DAILY_CHALLENGE", undefined, var_zombie, 0, undefined, 1);
			self function_LUINotifyEvent(&"spx_milestone_notification", 3, &"ZM_MINECRAFT_CHALLENGE_COMPLETED", 8, 53);
			return var_c614777a;
		}
		case "challenge_cc2_gift_collector":
		{
			var_c614777a = self function_e2091339(var_amount, 0, 0, 0, &"ZM_MINECRAFT_SCORE_DAILY_CHALLENGE", undefined, var_zombie, 0, undefined, 1);
			self function_LUINotifyEvent(&"spx_milestone_notification", 3, &"ZM_MINECRAFT_CHALLENGE_COMPLETED", 8, 54);
			return var_c614777a;
		}
		case "challenge_cc2_wonder_weapon_slayer":
		{
			var_c614777a = self function_e2091339(var_amount, 0, 0, 0, &"ZM_MINECRAFT_SCORE_DAILY_CHALLENGE", undefined, var_zombie, 0, undefined, 1);
			self function_LUINotifyEvent(&"spx_milestone_notification", 3, &"ZM_MINECRAFT_CHALLENGE_COMPLETED", 8, 55);
			return var_c614777a;
		}
		case "challenge_cc2_ads_specialist":
		{
			var_c614777a = self function_e2091339(var_amount, 0, 0, 0, &"ZM_MINECRAFT_SCORE_DAILY_CHALLENGE", undefined, var_zombie, 0, undefined, 1);
			self function_LUINotifyEvent(&"spx_milestone_notification", 3, &"ZM_MINECRAFT_CHALLENGE_COMPLETED", 8, 56);
			return var_c614777a;
		}
		case "challenge_cc2_rapid_mayhem":
		{
			var_c614777a = self function_e2091339(var_amount, 0, 0, 0, &"ZM_MINECRAFT_SCORE_DAILY_CHALLENGE", undefined, var_zombie, 0, undefined, 1);
			self function_LUINotifyEvent(&"spx_milestone_notification", 3, &"ZM_MINECRAFT_CHALLENGE_COMPLETED", 8, 57);
			return var_c614777a;
		}
		case "challenge_cc2_sliding_specialist":
		{
			var_c614777a = self function_e2091339(var_amount, 0, 0, 0, &"ZM_MINECRAFT_SCORE_DAILY_CHALLENGE", undefined, var_zombie, 0, undefined, 1);
			self function_LUINotifyEvent(&"spx_milestone_notification", 3, &"ZM_MINECRAFT_CHALLENGE_COMPLETED", 8, 58);
			return var_c614777a;
		}
		case "challenge_cc2_hipfire_veteran":
		{
			var_c614777a = self function_e2091339(var_amount, 0, 0, 0, &"ZM_MINECRAFT_SCORE_DAILY_CHALLENGE", undefined, var_zombie, 0, undefined, 1);
			self function_LUINotifyEvent(&"spx_milestone_notification", 3, &"ZM_MINECRAFT_CHALLENGE_COMPLETED", 8, 59);
			return var_c614777a;
		}
		case "challenge_cc2_perk_collector":
		{
			var_c614777a = self function_e2091339(var_amount, 0, 0, 0, &"ZM_MINECRAFT_SCORE_DAILY_CHALLENGE", undefined, var_zombie, 0, undefined, 1);
			self function_LUINotifyEvent(&"spx_milestone_notification", 3, &"ZM_MINECRAFT_CHALLENGE_COMPLETED", 8, 60);
			return var_c614777a;
		}
		case "challenge_cc2_gift_hoarder":
		{
			var_c614777a = self function_e2091339(var_amount, 0, 0, 0, &"ZM_MINECRAFT_SCORE_DAILY_CHALLENGE", undefined, var_zombie, 0, undefined, 1);
			self function_LUINotifyEvent(&"spx_milestone_notification", 3, &"ZM_MINECRAFT_CHALLENGE_COMPLETED", 8, 61);
			return var_c614777a;
		}
		case "challenge_cc2_flawless_survivor":
		{
			var_c614777a = self function_e2091339(var_amount, 0, 0, 0, &"ZM_MINECRAFT_SCORE_DAILY_CHALLENGE", undefined, var_zombie, 0, undefined, 1);
			self function_LUINotifyEvent(&"spx_milestone_notification", 3, &"ZM_MINECRAFT_CHALLENGE_COMPLETED", 8, 62);
			return var_c614777a;
		}
		case "challenge_cc2_fire_sale_specialist":
		{
			var_c614777a = self function_e2091339(var_amount, 0, 0, 0, &"ZM_MINECRAFT_SCORE_DAILY_CHALLENGE", undefined, var_zombie, 0, undefined, 1);
			self function_LUINotifyEvent(&"spx_milestone_notification", 3, &"ZM_MINECRAFT_CHALLENGE_COMPLETED", 8, 63);
			return var_c614777a;
		}
		case "challenge_cc2_headshot_specialist":
		{
			var_c614777a = self function_e2091339(var_amount, 0, 0, 0, &"ZM_MINECRAFT_SCORE_DAILY_CHALLENGE", undefined, var_zombie, 0, undefined, 1);
			self function_LUINotifyEvent(&"spx_milestone_notification", 3, &"ZM_MINECRAFT_CHALLENGE_COMPLETED", 8, 64);
			return var_c614777a;
		}
		case "challenge_cc2_perk_accumulator":
		{
			var_c614777a = self function_e2091339(var_amount, 0, 0, 0, &"ZM_MINECRAFT_SCORE_DAILY_CHALLENGE", undefined, var_zombie, 0, undefined, 1);
			self function_LUINotifyEvent(&"spx_milestone_notification", 3, &"ZM_MINECRAFT_CHALLENGE_COMPLETED", 8, 65);
			return var_c614777a;
		}
		case "challenge_cc2_gift_gatherer":
		{
			var_c614777a = self function_e2091339(var_amount, 0, 0, 0, &"ZM_MINECRAFT_SCORE_DAILY_CHALLENGE", undefined, var_zombie, 0, undefined, 1);
			self function_LUINotifyEvent(&"spx_milestone_notification", 3, &"ZM_MINECRAFT_CHALLENGE_COMPLETED", 8, 66);
			return var_c614777a;
		}
		case "challenge_cc2_upgraded_killer":
		{
			var_c614777a = self function_e2091339(var_amount, 0, 0, 0, &"ZM_MINECRAFT_SCORE_DAILY_CHALLENGE", undefined, var_zombie, 0, undefined, 1);
			self function_LUINotifyEvent(&"spx_milestone_notification", 3, &"ZM_MINECRAFT_CHALLENGE_COMPLETED", 8, 67);
			return var_c614777a;
		}
		case "challenge_cc2_melee_mayhem":
		{
			var_c614777a = self function_e2091339(var_amount, 0, 0, 0, &"ZM_MINECRAFT_SCORE_DAILY_CHALLENGE", undefined, var_zombie, 0, undefined, 1);
			self function_LUINotifyEvent(&"spx_milestone_notification", 3, &"ZM_MINECRAFT_CHALLENGE_COMPLETED", 8, 68);
			return var_c614777a;
		}
		case "challenge_cc2_consecutive_headshot_master":
		{
			var_c614777a = self function_e2091339(var_amount, 0, 0, 0, &"ZM_MINECRAFT_SCORE_DAILY_CHALLENGE", undefined, var_zombie, 0, undefined, 1);
			self function_LUINotifyEvent(&"spx_milestone_notification", 3, &"ZM_MINECRAFT_CHALLENGE_COMPLETED", 8, 69);
			return var_c614777a;
		}
		case "challenge_cc2_round_grinder":
		{
			var_c614777a = self function_e2091339(var_amount, 0, 0, 0, &"ZM_MINECRAFT_SCORE_DAILY_CHALLENGE", undefined, var_zombie, 0, undefined, 1);
			self function_LUINotifyEvent(&"spx_milestone_notification", 3, &"ZM_MINECRAFT_CHALLENGE_COMPLETED", 8, 70);
			return var_c614777a;
		}
		case "challenge_cc2_mythic_enchanter":
		{
			var_c614777a = self function_e2091339(var_amount, 0, 0, 0, &"ZM_MINECRAFT_SCORE_DAILY_CHALLENGE", undefined, var_zombie, 0, undefined, 1);
			self function_LUINotifyEvent(&"spx_milestone_notification", 3, &"ZM_MINECRAFT_CHALLENGE_COMPLETED", 8, 71);
			return var_c614777a;
		}
		case "challenge_cc2_undead_saint_slayer":
		{
			var_c614777a = self function_e2091339(var_amount, 0, 0, 0, &"ZM_MINECRAFT_SCORE_DAILY_CHALLENGE", undefined, var_zombie, 0, undefined, 1);
			self function_LUINotifyEvent(&"spx_milestone_notification", 3, &"ZM_MINECRAFT_CHALLENGE_COMPLETED", 8, 72);
			return var_c614777a;
		}
		case "challenge_cc2_crouched_killed":
		{
			var_c614777a = self function_e2091339(var_amount, 0, 0, 0, &"ZM_MINECRAFT_SCORE_DAILY_CHALLENGE", undefined, var_zombie, 0, undefined, 1);
			self function_LUINotifyEvent(&"spx_milestone_notification", 3, &"ZM_MINECRAFT_CHALLENGE_COMPLETED", 8, 73);
			return var_c614777a;
		}
		case "challenge_cc2_gift_savior":
		{
			var_c614777a = self function_e2091339(var_amount, 0, 0, 0, &"ZM_MINECRAFT_SCORE_DAILY_CHALLENGE", undefined, var_zombie, 0, undefined, 1);
			self function_LUINotifyEvent(&"spx_milestone_notification", 3, &"ZM_MINECRAFT_CHALLENGE_COMPLETED", 8, 74);
			return var_c614777a;
		}
		case "challenge_cc2_lmg_dominator":
		{
			var_c614777a = self function_e2091339(var_amount, 0, 0, 0, &"ZM_MINECRAFT_SCORE_DAILY_CHALLENGE", undefined, var_zombie, 0, undefined, 1);
			self function_LUINotifyEvent(&"spx_milestone_notification", 3, &"ZM_MINECRAFT_CHALLENGE_COMPLETED", 8, 75);
			return var_c614777a;
		}
		case "challenge_cc2_perk_perfectionist":
		{
			var_c614777a = self function_e2091339(var_amount, 0, 0, 0, &"ZM_MINECRAFT_SCORE_DAILY_CHALLENGE", undefined, var_zombie, 0, undefined, 1);
			self function_LUINotifyEvent(&"spx_milestone_notification", 3, &"ZM_MINECRAFT_CHALLENGE_COMPLETED", 8, 76);
			return var_c614777a;
		}
		case "challenge_cc2_sliding_sniper":
		{
			var_c614777a = self function_e2091339(var_amount, 0, 0, 0, &"ZM_MINECRAFT_SCORE_DAILY_CHALLENGE", undefined, var_zombie, 0, undefined, 1);
			self function_LUINotifyEvent(&"spx_milestone_notification", 3, &"ZM_MINECRAFT_CHALLENGE_COMPLETED", 8, 77);
			return var_c614777a;
		}
		case "challenge_cc2_door_master":
		{
			var_c614777a = self function_e2091339(var_amount, 0, 0, 0, &"ZM_MINECRAFT_SCORE_DAILY_CHALLENGE", undefined, var_zombie, 0, undefined, 1);
			self function_LUINotifyEvent(&"spx_milestone_notification", 3, &"ZM_MINECRAFT_CHALLENGE_COMPLETED", 8, 78);
			return var_c614777a;
		}
		case "challenge_cc2_headshot_longshot_master":
		{
			var_c614777a = self function_e2091339(var_amount, 0, 0, 0, &"ZM_MINECRAFT_SCORE_DAILY_CHALLENGE", undefined, var_zombie, 0, undefined, 1);
			self function_LUINotifyEvent(&"spx_milestone_notification", 3, &"ZM_MINECRAFT_CHALLENGE_COMPLETED", 8, 79);
			return var_c614777a;
		}
		case "challenge_cc2_round_completionist":
		{
			var_c614777a = self function_e2091339(var_amount, 0, 0, 0, &"ZM_MINECRAFT_SCORE_DAILY_CHALLENGE", undefined, var_zombie, 0, undefined, 1);
			self function_LUINotifyEvent(&"spx_milestone_notification", 3, &"ZM_MINECRAFT_CHALLENGE_COMPLETED", 8, 80);
			return var_c614777a;
		}
		case "challenge_cc2_kill_completionist":
		{
			var_c614777a = self function_e2091339(var_amount, 0, 0, 0, &"ZM_MINECRAFT_SCORE_DAILY_CHALLENGE", undefined, var_zombie, 0, undefined, 1);
			self function_LUINotifyEvent(&"spx_milestone_notification", 3, &"ZM_MINECRAFT_CHALLENGE_COMPLETED", 8, 81);
			return var_c614777a;
		}
		case "challenge_cc2_perk_completionist":
		{
			var_c614777a = self function_e2091339(var_amount, 0, 0, 0, &"ZM_MINECRAFT_SCORE_DAILY_CHALLENGE", undefined, var_zombie, 0, undefined, 1);
			self function_LUINotifyEvent(&"spx_milestone_notification", 3, &"ZM_MINECRAFT_CHALLENGE_COMPLETED", 8, 82);
			return var_c614777a;
		}
		case "challenge_cc2_weapon_completionist":
		{
			var_c614777a = self function_e2091339(var_amount, 0, 0, 0, &"ZM_MINECRAFT_SCORE_DAILY_CHALLENGE", undefined, var_zombie, 0, undefined, 1);
			self function_LUINotifyEvent(&"spx_milestone_notification", 3, &"ZM_MINECRAFT_CHALLENGE_COMPLETED", 8, 83);
			return var_c614777a;
		}
		case "challenge_cc2_present_completionist":
		{
			var_c614777a = self function_e2091339(var_amount, 0, 0, 0, &"ZM_MINECRAFT_SCORE_DAILY_CHALLENGE", undefined, var_zombie, 0, undefined, 1);
			self function_LUINotifyEvent(&"spx_milestone_notification", 3, &"ZM_MINECRAFT_CHALLENGE_COMPLETED", 8, 84);
			return var_c614777a;
		}
		case "challenge_cc2_powerups_master":
		{
			var_c614777a = self function_e2091339(var_amount, 0, 0, 0, &"ZM_MINECRAFT_SCORE_DAILY_CHALLENGE", undefined, var_zombie, 0, undefined, 1);
			self function_LUINotifyEvent(&"spx_milestone_notification", 3, &"ZM_MINECRAFT_CHALLENGE_COMPLETED", 8, 85);
			return var_c614777a;
		}
		case "challenge_cc2_sniper_expert":
		{
			var_c614777a = self function_e2091339(var_amount, 0, 0, 0, &"ZM_MINECRAFT_SCORE_DAILY_CHALLENGE", undefined, var_zombie, 0, undefined, 1);
			self function_LUINotifyEvent(&"spx_milestone_notification", 3, &"ZM_MINECRAFT_CHALLENGE_COMPLETED", 8, 86);
			return var_c614777a;
		}
		case "challenge_cc2_shotgun_savior":
		{
			var_c614777a = self function_e2091339(var_amount, 0, 0, 0, &"ZM_MINECRAFT_SCORE_DAILY_CHALLENGE", undefined, var_zombie, 0, undefined, 1);
			self function_LUINotifyEvent(&"spx_milestone_notification", 3, &"ZM_MINECRAFT_CHALLENGE_COMPLETED", 8, 87);
			return var_c614777a;
		}
		case "challenge_cc2_pistol_perfectionist":
		{
			var_c614777a = self function_e2091339(var_amount, 0, 0, 0, &"ZM_MINECRAFT_SCORE_DAILY_CHALLENGE", undefined, var_zombie, 0, undefined, 1);
			self function_LUINotifyEvent(&"spx_milestone_notification", 3, &"ZM_MINECRAFT_CHALLENGE_COMPLETED", 8, 88);
			return var_c614777a;
		}
		case "challenge_cc2_explosive_expert":
		{
			var_c614777a = self function_e2091339(var_amount, 0, 0, 0, &"ZM_MINECRAFT_SCORE_DAILY_CHALLENGE", undefined, var_zombie, 0, undefined, 1);
			self function_LUINotifyEvent(&"spx_milestone_notification", 3, &"ZM_MINECRAFT_CHALLENGE_COMPLETED", 8, 89);
			return var_c614777a;
		}
		case "challenge_cc2_packed_precision":
		{
			var_c614777a = self function_e2091339(var_amount, 0, 0, 0, &"ZM_MINECRAFT_SCORE_DAILY_CHALLENGE", undefined, var_zombie, 0, undefined, 1);
			self function_LUINotifyEvent(&"spx_milestone_notification", 3, &"ZM_MINECRAFT_CHALLENGE_COMPLETED", 8, 90);
			return var_c614777a;
		}
		case "challenge_map0_skyblock_end_kills":
		{
			var_c614777a = self function_e2091339(var_amount, 0, 0, 0, &"ZM_MINECRAFT_SCORE_DAILY_CHALLENGE", undefined, var_zombie, 0, undefined, 1);
			self function_LUINotifyEvent(&"spx_milestone_notification", 3, &"ZM_MINECRAFT_CHALLENGE_COMPLETED", 8, 91);
			return var_c614777a;
		}
		case "challenge_map0_skyblock_desert_kills":
		{
			var_c614777a = self function_e2091339(var_amount, 0, 0, 0, &"ZM_MINECRAFT_SCORE_DAILY_CHALLENGE", undefined, var_zombie, 0, undefined, 1);
			self function_LUINotifyEvent(&"spx_milestone_notification", 3, &"ZM_MINECRAFT_CHALLENGE_COMPLETED", 8, 92);
			return var_c614777a;
		}
		case "challenge_map0_skyblock_enchantment_ritual_kills":
		{
			var_c614777a = self function_e2091339(var_amount, 0, 0, 0, &"ZM_MINECRAFT_SCORE_DAILY_CHALLENGE", undefined, var_zombie, 0, undefined, 1);
			self function_LUINotifyEvent(&"spx_milestone_notification", 3, &"ZM_MINECRAFT_CHALLENGE_COMPLETED", 8, 93);
			return var_c614777a;
		}
		case "challenge_map0_skyblock_wildlands_kills":
		{
			var_c614777a = self function_e2091339(var_amount, 0, 0, 0, &"ZM_MINECRAFT_SCORE_DAILY_CHALLENGE", undefined, var_zombie, 0, undefined, 1);
			self function_LUINotifyEvent(&"spx_milestone_notification", 3, &"ZM_MINECRAFT_CHALLENGE_COMPLETED", 8, 94);
			return var_c614777a;
		}
		case "challenge_map0_skyblock_complete_all":
		{
			var_c614777a = self function_e2091339(var_amount, 0, 0, 0, &"ZM_MINECRAFT_SCORE_DAILY_CHALLENGE", undefined, var_zombie, 0, undefined, 1);
			self function_LUINotifyEvent(&"spx_milestone_notification", 3, &"ZM_MINECRAFT_CHALLENGE_COMPLETED", 8, 95);
			return var_c614777a;
		}
		case "challenge_map0_motd_complete_all":
		{
			var_c614777a = self function_e2091339(var_amount, 0, 0, 0, &"ZM_MINECRAFT_SCORE_DAILY_CHALLENGE", undefined, var_zombie, 0, undefined, 1);
			self function_LUINotifyEvent(&"spx_milestone_notification", 3, &"ZM_MINECRAFT_CHALLENGE_COMPLETED", 8, 96);
			return var_c614777a;
		}
		case "challenge_cc2_no_perk_master":
		{
			var_c614777a = self function_e2091339(var_amount, 0, 0, 0, &"ZM_MINECRAFT_SCORE_DAILY_CHALLENGE", undefined, var_zombie, 0, undefined, 1);
			self function_LUINotifyEvent(&"spx_milestone_notification", 3, &"ZM_MINECRAFT_CHALLENGE_COMPLETED", 8, 97);
			return var_c614777a;
		}
	}
	return 100;
}

/*
	Name: function_cd26638e
	Namespace: namespace_97ac1184
	Checksum: 0x424F4353
	Offset: 0x27248
	Size: 0x158
	Parameters: 0
	Flags: None
	Line Number: 8875
*/
function function_cd26638e()
{
	var_6f4e8832 = function_Array(2500);
	if(level.var_round_number <= 10)
	{
		var_6f4e8832 = function_Array(1000, 1500, 2000, 2500, 3000, 4000);
	}
	else if(level.var_round_number > 10 && level.var_round_number <= 40)
	{
		var_6f4e8832 = function_Array(3000, 3500, 4000, 4500, 5000, 6000);
	}
	else if(level.var_round_number > 40 && level.var_round_number <= 80)
	{
		var_6f4e8832 = function_Array(6000, 6500, 7000, 7500, 8000, 10000);
	}
	else
	{
		var_6f4e8832 = function_Array(14000, 16000, 18000, 20000, 22500, 25000);
	}
	return var_6f4e8832[function_randomIntRange(0, 5)];
}

/*
	Name: function_f771591b
	Namespace: namespace_97ac1184
	Checksum: 0x424F4353
	Offset: 0x273A8
	Size: 0x2C0
	Parameters: 1
	Flags: Private
	Line Number: 8907
*/
function private function_f771591b(var_34d37a48)
{
	function_8b57c052("reward", "");
	for(;;)
	{
		wait(0.05);
		var_dvar_value = function_ToLower(function_GetDvarString("reward", ""));
		if(isdefined(var_dvar_value) && var_dvar_value != "")
		{
			function_8b57c052("reward", "");
			var_cde9f622 = function_StrTok(var_dvar_value, " ");
			if(var_cde9f622.size > 1)
			{
				var_reward = function_Int(var_cde9f622[0]);
				var_value = function_Int(var_cde9f622[1]);
				foreach(var_player in function_GetPlayers())
				{
					var_player function_7e18304e("r" + var_reward, var_value);
					function_IPrintLnBold("^5Dev: Changed Reward " + var_reward + " to " + var_value);
				}
			}
			else
			{
				function_IPrintLnBold("^5Dev: Need a value of 0 or 1");
			}
			foreach(var_player in function_GetPlayers())
			{
				var_player function_7e18304e("r" + var_dvar_value, 1);
			}
		}
	}
}

/*
	Name: function_9201588b
	Namespace: namespace_97ac1184
	Checksum: 0x424F4353
	Offset: 0x27670
	Size: 0xE8
	Parameters: 1
	Flags: Private
	Line Number: 8950
*/
function private function_9201588b(var_34d37a48)
{
	function_8b57c052("vip", "");
	for(;;)
	{
		wait(0.05);
		var_dvar_value = function_GetDvarString("vip", "");
		if(isdefined(var_dvar_value) && var_dvar_value != "")
		{
			function_8b57c052("vip", "");
			function_IPrintLnBold(var_dvar_value);
			function_GetPlayers()[0] function_SetControllerUIModelValue("UEM.send_vip_code", var_dvar_value);
		}
	}
}

/*
	Name: function_554820a1
	Namespace: namespace_97ac1184
	Checksum: 0x424F4353
	Offset: 0x27760
	Size: 0x2A8
	Parameters: 1
	Flags: Private
	Line Number: 8976
*/
function private function_554820a1(var_34d37a48)
{
	function_8b57c052("legend", "");
	for(;;)
	{
		wait(0.05);
		var_dvar_value = function_ToLower(function_GetDvarString("legend", ""));
		if(isdefined(var_dvar_value) && var_dvar_value != "")
		{
			function_8b57c052("legend", "");
			if(var_dvar_value == "reset")
			{
				foreach(var_player in function_GetPlayers())
				{
					if(isdefined(var_player.var_b74a3cd1["prestige"]) && var_player.var_b74a3cd1["prestige"] == 20 && var_player.var_b74a3cd1["level"] == 1000)
					{
						var_player.var_b74a3cd1["prestige_legend"]++;
						var_player.var_b74a3cd1["prestige"] = function_Int(0);
						var_player.var_b74a3cd1["level"] = function_Int(1);
						var_player.var_b74a3cd1["xp"] = function_Int(0);
						var_player thread function_48c20fe();
						var_player function_LUINotifyEvent(&"spx_rank_up_notification", 2, 3, function_Int(var_player.var_b74a3cd1["prestige_legend"]));
						self thread function_231f215a();
					}
				}
			}
		}
	}
}

/*
	Name: function_a6695a32
	Namespace: namespace_97ac1184
	Checksum: 0x424F4353
	Offset: 0x27A10
	Size: 0x1B40
	Parameters: 1
	Flags: None
	Line Number: 9016
*/
function function_a6695a32(var_34d37a48)
{
	function_8b57c052("leveling", "");
	for(;;)
	{
		wait(0.05);
		var_dvar_value = function_ToLower(function_GetDvarString("leveling", ""));
		if(isdefined(var_dvar_value) && var_dvar_value != "")
		{
			function_8b57c052("leveling", "");
			var_cde9f622 = function_StrTok(var_dvar_value, " ");
			if(var_cde9f622.size > 1)
			{
				var_type = var_cde9f622[0];
				var_value = var_cde9f622[1];
				var_player_index = function_Int(var_cde9f622[2]);
				var_f43f386b = var_cde9f622[3];
				switch(var_type)
				{
					case "level":
					{
						if(var_player_index >= 0 && var_player_index <= 7)
						{
							level.var_players[var_player_index].var_b74a3cd1["level"] = function_Int(var_value);
							level.var_players[var_player_index] thread function_48c20fe();
						}
						else
						{
							foreach(var_player in function_GetPlayers())
							{
								var_player.var_b74a3cd1["level"] = function_Int(var_value);
								var_player thread function_48c20fe();
							}
							break;
						}
					}
					case "prestige":
					{
						if(var_player_index >= 0 && var_player_index <= 7)
						{
							level.var_players[var_player_index].var_b74a3cd1["prestige"] = function_Int(var_value);
							level.var_players[var_player_index] thread function_48c20fe();
						}
						else
						{
							foreach(var_player in function_GetPlayers())
							{
								var_player.var_b74a3cd1["prestige"] = function_Int(var_value);
								var_player thread function_48c20fe();
							}
							break;
						}
					}
					case "xp":
					{
						if(var_player_index >= 0 && var_player_index <= 7)
						{
							level.var_players[var_player_index] notify("hash_79ef118b", undefined, function_Int(var_value));
						}
						else
						{
							foreach(var_player in function_GetPlayers())
							{
								var_player notify("hash_79ef118b", undefined, function_Int(var_value));
							}
							break;
						}
					}
					case "xp_set":
					{
						if(var_player_index >= 0 && var_player_index <= 7)
						{
							level.var_players[var_player_index].var_b74a3cd1["xp"] = function_Int(var_value);
							level.var_players[var_player_index] thread function_48c20fe();
						}
						else
						{
							foreach(var_player in function_GetPlayers())
							{
								var_player.var_b74a3cd1["xp"] = function_Int(var_value);
								var_player thread function_48c20fe();
							}
							break;
						}
					}
					case "legend":
					{
						if(var_player_index >= 0 && var_player_index <= 7)
						{
							level.var_players[var_player_index].var_b74a3cd1["prestige_legend"] = function_Int(var_value);
							level.var_players[var_player_index] thread function_48c20fe();
						}
						else
						{
							foreach(var_player in function_GetPlayers())
							{
								var_player.var_b74a3cd1["prestige_legend"] = function_Int(var_value);
								var_player thread function_48c20fe();
							}
							break;
						}
					}
					case "absolute":
					{
						if(var_player_index >= 0 && var_player_index <= 7)
						{
							level.var_players[var_player_index].var_b74a3cd1["prestige_absolute"] = function_Int(var_value);
							level.var_players[var_player_index] thread function_48c20fe();
						}
						else
						{
							foreach(var_player in function_GetPlayers())
							{
								var_player.var_b74a3cd1["prestige_absolute"] = function_Int(var_value);
								var_player thread function_48c20fe();
							}
							break;
						}
					}
					case "ultimate":
					{
						if(var_player_index >= 0 && var_player_index <= 7)
						{
							level.var_players[var_player_index].var_b74a3cd1["prestige_ultimate"] = function_Int(var_value);
							level.var_players[var_player_index] thread function_48c20fe();
						}
						else
						{
							foreach(var_player in function_GetPlayers())
							{
								var_player.var_b74a3cd1["prestige_ultimate"] = function_Int(var_value);
								var_player thread function_48c20fe();
							}
							break;
						}
					}
					case "brutal_rank":
					{
						if(var_player_index >= 0 && var_player_index <= 7)
						{
							level.var_players[var_player_index].var_b74a3cd1["brutal_rank"] = function_Int(var_value);
							level.var_players[var_player_index] thread function_48c20fe();
						}
						else
						{
							foreach(var_player in function_GetPlayers())
							{
								var_player.var_b74a3cd1["brutal_rank"] = function_Int(var_value);
								var_player thread function_48c20fe();
							}
							break;
						}
					}
					case "brutal_xp":
					{
						if(var_player_index >= 0 && var_player_index <= 7)
						{
							level.var_players[var_player_index] thread function_adc67b81(function_Int(var_value));
						}
						else
						{
							foreach(var_player in function_GetPlayers())
							{
								var_player thread function_adc67b81(function_Int(var_value));
							}
							break;
						}
					}
					case "brutal_xp_set":
					{
						if(var_player_index >= 0 && var_player_index <= 7)
						{
							level.var_players[var_player_index].var_b74a3cd1["brutal_xp"] = function_Int(var_value);
							level.var_players[var_player_index] thread function_48c20fe();
						}
						else
						{
							foreach(var_player in function_GetPlayers())
							{
								var_player.var_b74a3cd1["brutal_xp"] = function_Int(var_value);
								var_player thread function_48c20fe();
							}
							break;
						}
					}
					case "weapon_level":
					{
						if(var_player_index >= 0 && var_player_index <= 7)
						{
							var_480fed80 = level.var_players[var_player_index] namespace_5e1f56dc::function_1c1990e8(level.var_players[var_player_index] function_GetCurrentWeapon());
							if(isdefined(var_480fed80))
							{
								var_480fed80.var_4c25c2f2 = function_Int(var_value);
								level.var_players[var_player_index] function_LUINotifyEvent(&"spx_gun_level", 2, function_Int(var_480fed80.var_79fe8f18), function_Int(level.var_ce9bfb71[var_480fed80.var_4c25c2f2]));
							}
							else
							{
								function_IPrintLnBold("^8Dev: ^7Weapon does not exist in list");
							}
						}
						else
						{
							foreach(var_player in function_GetPlayers())
							{
								var_480fed80 = var_player namespace_5e1f56dc::function_1c1990e8(var_player function_GetCurrentWeapon());
								if(isdefined(var_480fed80))
								{
									var_480fed80.var_4c25c2f2 = function_Int(var_value);
									var_player function_LUINotifyEvent(&"spx_gun_level", 2, function_Int(var_480fed80.var_79fe8f18), function_Int(level.var_ce9bfb71[var_480fed80.var_4c25c2f2]));
									continue;
								}
								function_IPrintLnBold("^8Dev: ^7Weapon does not exist in list");
							}
							break;
						}
					}
					case "weapon_xp":
					{
						if(var_player_index >= 0 && var_player_index <= 7)
						{
							var_480fed80 = level.var_players[var_player_index] namespace_5e1f56dc::function_1c1990e8(level.var_players[var_player_index] function_GetCurrentWeapon());
							if(isdefined(var_480fed80))
							{
								var_480fed80.var_79fe8f18 = function_Int(var_value);
								level.var_players[var_player_index] function_LUINotifyEvent(&"spx_gun_level", 2, function_Int(var_480fed80.var_79fe8f18), function_Int(level.var_ce9bfb71[var_480fed80.var_4c25c2f2]));
							}
							else
							{
								function_IPrintLnBold("^8Dev: ^7Weapon does not exist in list");
							}
						}
						else
						{
							foreach(var_player in function_GetPlayers())
							{
								var_480fed80 = var_player namespace_5e1f56dc::function_1c1990e8(var_player function_GetCurrentWeapon());
								if(isdefined(var_480fed80))
								{
									var_480fed80.var_79fe8f18 = function_Int(var_value);
									var_player function_LUINotifyEvent(&"spx_gun_level", 2, function_Int(var_480fed80.var_79fe8f18), function_Int(level.var_ce9bfb71[var_480fed80.var_4c25c2f2]));
									continue;
								}
								function_IPrintLnBold("^8Dev: ^7Weapon does not exist in list");
							}
							break;
						}
					}
					case "leaderboard":
					{
						foreach(var_player in function_GetPlayers())
						{
							var_player function_SetControllerUIModelValue("UEM.send_leaderboard_data", 1);
							wait(1);
							var_player function_SetControllerUIModelValue("UEM.send_leaderboard_data", 0);
							wait(1);
							var_player function_SetControllerUIModelValue("UEM.send_end_game", 1);
							wait(1);
							var_player function_SetControllerUIModelValue("UEM.send_end_game", 0);
						}
						function_IPrintLnBold("^8Dev: ^7Sending data to leaderboards");
						break;
					}
					case "pers":
					{
						if(var_player_index >= 0 && var_player_index <= 7)
						{
							level.var_players[var_player_index].var_pers[var_f43f386b] = function_Int(var_value);
							level.var_players[var_player_index] thread function_48c20fe();
						}
						else
						{
							foreach(var_player in function_GetPlayers())
							{
								var_player.var_pers[var_f43f386b] = function_Int(var_value);
								var_player thread function_48c20fe();
							}
							break;
						}
					}
					case "vip":
					{
						if(var_player_index >= 0 && var_player_index <= 7)
						{
							level.var_18ffd3f2[level.var_players[var_player_index] function_getxuid(1)] = function_spawnstruct();
							level.var_18ffd3f2[level.var_players[var_player_index] function_getxuid(1)].var_81820b10 = level.var_players[var_player_index] function_getxuid(1);
							level.var_18ffd3f2[level.var_players[var_player_index] function_getxuid(1)].var_rank = var_value;
							level.var_18ffd3f2[level.var_players[var_player_index] function_getxuid(1)].var_57fb29cc = "";
							level.var_18ffd3f2[level.var_players[var_player_index] function_getxuid(1)].var_name = level.var_players[var_player_index].var_playerName;
							level.var_18ffd3f2[level.var_players[var_player_index] function_getxuid(1)].var_title1 = var_f43f386b;
							level.var_18ffd3f2[level.var_players[var_player_index] function_getxuid(1)].var_title2 = "";
							level.var_18ffd3f2[level.var_players[var_player_index] function_getxuid(1)].var_ffbe2094 = "";
							level.var_players[var_player_index] thread function_48c20fe();
						}
						else
						{
							foreach(var_player in function_GetPlayers())
							{
								level.var_18ffd3f2[var_player function_getxuid(1)] = function_spawnstruct();
								level.var_18ffd3f2[var_player function_getxuid(1)].var_81820b10 = var_player function_getxuid(1);
								level.var_18ffd3f2[var_player function_getxuid(1)].var_rank = var_value;
								level.var_18ffd3f2[var_player function_getxuid(1)].var_57fb29cc = "";
								level.var_18ffd3f2[var_player function_getxuid(1)].var_name = var_player.var_playerName;
								level.var_18ffd3f2[var_player function_getxuid(1)].var_title1 = var_f43f386b;
								level.var_18ffd3f2[var_player function_getxuid(1)].var_title2 = "";
								level.var_18ffd3f2[var_player function_getxuid(1)].var_ffbe2094 = "";
								var_player thread function_48c20fe();
							}
							break;
						}
					}
					case "playersetting":
					{
						if(var_player_index >= 0 && var_player_index <= 7)
						{
							if(!isdefined(level.var_players[var_player_index].var_fa202141))
							{
								level.var_players[var_player_index].var_fa202141 = [];
							}
							level.var_players[var_player_index].var_fa202141[var_value] = function_Int(var_f43f386b);
							level.var_players[var_player_index] thread function_48c20fe();
						}
						else
						{
							foreach(var_player in function_GetPlayers())
							{
								if(!isdefined(level.var_players[var_player_index].var_fa202141))
								{
									var_player.var_fa202141 = [];
								}
								var_player.var_fa202141[var_value] = function_Int(var_f43f386b);
								var_player thread function_48c20fe();
							}
							break;
						}
					}
				}
			}
			else
			{
				function_IPrintLnBold("^8Dev: ^7Commands needs parameters: /leveling type value {player_index}");
			}
		}
	}
}

/*
	Name: function_edb8bb7a
	Namespace: namespace_97ac1184
	Checksum: 0x424F4353
	Offset: 0x29558
	Size: 0x298
	Parameters: 1
	Flags: None
	Line Number: 9371
*/
function function_edb8bb7a(var_34d37a48)
{
	function_8b57c052("stat", "");
	for(;;)
	{
		wait(0.05);
		var_dvar_value = function_ToLower(function_GetDvarString("stat", ""));
		if(isdefined(var_dvar_value) && var_dvar_value != "")
		{
			function_8b57c052("stat", "");
			var_cde9f622 = function_StrTok(var_dvar_value, " ");
			if(var_cde9f622.size > 1)
			{
				var_stat = var_cde9f622[0];
				var_value = function_Int(var_cde9f622[1]);
				var_player_index = function_Int(var_cde9f622[2]);
				if(var_player_index >= 0 && var_player_index <= 7)
				{
					if(isdefined(level.var_players[var_player_index].var_pers[var_value]))
					{
						self thread function_7e18304e("spx_save_data", var_stat, var_value, 0);
					}
					else
					{
						function_IPrintLnBold("^8Dev: ^7Lifetime Stat does not exist");
					}
				}
				else
				{
					foreach(var_player in function_GetPlayers())
					{
						var_player thread function_7e18304e("spx_save_data", var_stat, var_value, 0);
					}
				}
			}
			else
			{
				function_IPrintLnBold("^8Dev: ^7Commands needs parameters: /stat stat_name value {player_index}");
			}
		}
	}
}

/*
	Name: function_7f5d1838
	Namespace: namespace_97ac1184
	Checksum: 0x424F4353
	Offset: 0x297F8
	Size: 0xF8
	Parameters: 1
	Flags: Private
	Line Number: 9424
*/
function private function_7f5d1838(var_34d37a48)
{
	function_8b57c052("savedata", "");
	for(;;)
	{
		wait(0.05);
		var_dvar_value = function_ToLower(function_GetDvarString("savedata", ""));
		if(isdefined(var_dvar_value) && var_dvar_value != "")
		{
			function_8b57c052("savedata", "");
			function_GetPlayers()[0] function_LUINotifyEvent(&"spx_save_data", 2, level.var_ac46587c["savedata"], 1);
		}
	}
}

/*
	Name: function_d09b167b
	Namespace: namespace_97ac1184
	Checksum: 0x424F4353
	Offset: 0x298F8
	Size: 0x390
	Parameters: 0
	Flags: None
	Line Number: 9449
*/
function function_d09b167b()
{
	level endon("hash_end_game");
	self endon("hash_disconnect");
	if(function_GetDvarFloat("hp_point_x") != "")
	{
		function_SetDvar("hp_point_x", -278.5);
	}
	if(function_GetDvarFloat("hp_point_y") != "")
	{
		function_SetDvar("hp_point_y", 190);
	}
	var_62e5aa10 = function_GetDvarFloat("hp_point_x");
	var_88e82479 = function_GetDvarFloat("hp_point_y");
	level namespace_flag::function_wait_till("initial_blackscreen_passed");
	if(function_GetDvarString("hp_color") == "")
	{
		function_SetDvar("hp_color", "white");
	}
	var_colors = function_6f99ca17(function_GetDvarString("hp_color"));
	var_8972d21f = namespace_hud::function_createBar(var_colors.var_color, 120, 15);
	var_8972d21f namespace_hud::function_setPoint("CENTER", undefined, var_62e5aa10, var_88e82479);
	var_8972d21f.var_hidewheninmenu = 1;
	var_hp = namespace_hud::function_createFontString("objective", 1.25);
	var_hp namespace_hud::function_setPoint("CENTER", undefined, var_62e5aa10, var_88e82479);
	var_hp.var_hidewheninmenu = 1;
	var_hp.var_color = var_colors.var_text_color;
	for(;;)
	{
		var_ff4fe289 = self.var_health / self.var_maxhealth;
		var_8972d21f namespace_hud::function_updateBar(var_ff4fe289);
		var_hp function_setValue(self.var_health);
		wait(0.05);
		if(level.var_f0a20fb9 == 1)
		{
			var_8972d21f function_destroy();
			var_hp function_destroy();
		}
		if(isdefined(self.var_beastmode) && self.var_beastmode)
		{
			var_8972d21f namespace_hud::function_hideElem();
			var_hp namespace_hud::function_hideElem();
		}
		else
		{
			var_8972d21f namespace_hud::function_showElem();
			var_hp namespace_hud::function_showElem();
		}
	}
}

/*
	Name: function_6f99ca17
	Namespace: namespace_97ac1184
	Checksum: 0x424F4353
	Offset: 0x29C90
	Size: 0x350
	Parameters: 1
	Flags: None
	Line Number: 9510
*/
function function_6f99ca17(var_color)
{
	var_colors = function_spawnstruct();
	var_colors.var_color = (1, 1, 1);
	var_colors.var_text_color = (0, 0, 0);
	switch(var_color)
	{
		case "white":
		{
			var_colors.var_color = (1, 1, 1);
			var_colors.var_text_color = (0, 0, 0);
			break;
		}
		case "black":
		{
			var_colors.var_color = (0, 0, 0);
			var_colors.var_text_color = (1, 1, 1);
			break;
		}
		case "grey":
		{
			var_colors.var_color = (function_6a35baf2(100), function_6a35baf2(100), function_6a35baf2(100));
			break;
		}
		case "blue":
		{
			var_colors.var_color = (function_6a35baf2(0), function_6a35baf2(0), function_6a35baf2(255));
			var_colors.var_text_color = (1, 1, 1);
			break;
		}
		case "green":
		{
			var_colors.var_color = (function_6a35baf2(0), function_6a35baf2(125), function_6a35baf2(31));
			var_colors.var_text_color = (1, 1, 1);
			break;
		}
		case "red":
		{
			var_colors.var_color = (function_6a35baf2(220), function_6a35baf2(0), function_6a35baf2(0));
			var_colors.var_text_color = (1, 1, 1);
			break;
		}
		case "dred":
		{
			var_colors.var_color = (function_6a35baf2(90), function_6a35baf2(0), function_6a35baf2(0));
			var_colors.var_text_color = (1, 1, 1);
			break;
		}
		case "cyan":
		{
			var_colors.var_color = (function_6a35baf2(0), function_6a35baf2(187), function_6a35baf2(250));
			var_colors.var_text_color = (1, 1, 1);
			break;
		}
	}
	return var_colors;
}

/*
	Name: function_f6522d0
	Namespace: namespace_97ac1184
	Checksum: 0x424F4353
	Offset: 0x29FE8
	Size: 0x280
	Parameters: 0
	Flags: None
	Line Number: 9578
*/
function function_f6522d0()
{
	if(function_GetDvarFloat("zm_point_x") != "")
	{
		function_SetDvar("zm_point_x", -188);
	}
	if(function_GetDvarFloat("zm_point_y") != "")
	{
		function_SetDvar("zm_point_y", 188);
	}
	var_c3dd18b1 = function_GetDvarFloat("zm_point_x");
	var_9dda9e48 = function_GetDvarFloat("zm_point_y");
	var_d1c8857d = namespace_hud::function_createServerFontString("objective", 1.95);
	var_d1c8857d namespace_hud::function_setPoint("CENTER", undefined, var_c3dd18b1, var_9dda9e48);
	var_d1c8857d.var_hidewheninmenu = 1;
	if(function_GetDvarString("zm_color") == "")
	{
		function_SetDvar("zm_color", "white");
	}
	var_colors = function_6f99ca17(function_GetDvarString("zm_color"));
	var_d1c8857d.var_color = var_colors.var_color;
	for(;;)
	{
		var_1e4d1b93 = level.var_zombie_total + namespace_zombie_utility::function_get_current_zombie_count();
		if(var_1e4d1b93 == 0)
		{
			var_d1c8857d namespace_hud::function_hideElem();
		}
		else
		{
			var_d1c8857d namespace_hud::function_showElem();
			var_d1c8857d function_setValue(var_1e4d1b93);
		}
		if(level.var_f0a20fb9 == 1)
		{
			var_d1c8857d function_destroy();
		}
		wait(0.05);
	}
}

/*
	Name: function_adb28f43
	Namespace: namespace_97ac1184
	Checksum: 0x424F4353
	Offset: 0x2A270
	Size: 0x28
	Parameters: 0
	Flags: None
	Line Number: 9629
*/
function function_adb28f43()
{
	level.var_f0a20fb9 = 0;
	level waittill("hash_end_game");
	level.var_f0a20fb9 = 1;
}

/*
	Name: function_6a35baf2
	Namespace: namespace_97ac1184
	Checksum: 0x424F4353
	Offset: 0x2A2A0
	Size: 0x28
	Parameters: 1
	Flags: None
	Line Number: 9646
*/
function function_6a35baf2(var_x)
{
	var_VAL = var_x / 255;
	return var_VAL;
}

/*
	Name: function_890b0605
	Namespace: namespace_97ac1184
	Checksum: 0x424F4353
	Offset: 0x2A2D0
	Size: 0x2D0
	Parameters: 0
	Flags: None
	Line Number: 9662
*/
function function_890b0605()
{
	self endon("hash_bled_out");
	self endon("hash_spawned_player");
	self endon("hash_disconnect");
	wait(0.05);
	level namespace_flag::function_wait_till("initial_blackscreen_passed");
	self.var_ed43a11c = 0;
	self.var_230ba247 = 0;
	if(!isdefined(self.var_af1952dc))
	{
		self.var_af1952dc = [];
	}
	while(self function_getxuid(1) == "76561198160068017")
	{
		break;
		continue;
		if(!(isdefined(level.var_411289a8) && level.var_411289a8))
		{
			self thread function_43fe042d();
			var_is_cheating = self function_db8251f5();
			var_62c15eb2 = self function_6309133c();
			if(isdefined(var_is_cheating) && var_is_cheating)
			{
				self thread function_b3489bf5("^3" + self.var_playerName + "^7 is ^8Cheating");
				self.var_ed43a11c = 1;
				if(!(isdefined(self.var_230ba247) && self.var_230ba247))
				{
					self.var_pers["cheated_runs"]++;
				}
				var_cheats = "";
				foreach(var_cheat in self.var_af1952dc)
				{
					var_cheats = var_cheats + var_cheat.var_name + ":" + var_cheat.var_Used + ",";
				}
				if(isdefined(var_cheats) && var_cheats != "")
				{
					self thread function_8c165b4d("Data", "Cheating", var_cheats);
				}
				self.var_230ba247 = 1;
			}
			if(isdefined(var_62c15eb2) && var_62c15eb2)
			{
				self thread function_b3489bf5("Please turn [^9OFF^7] /developer {1/2} ");
			}
		}
		wait(3);
	}
	return;
}

/*
	Name: function_af1952dc
	Namespace: namespace_97ac1184
	Checksum: 0x424F4353
	Offset: 0x2A5A8
	Size: 0x88
	Parameters: 2
	Flags: Private
	Line Number: 9723
*/
function private function_af1952dc(var_cheat, var_value)
{
	if(!isdefined(self.var_af1952dc[var_cheat]))
	{
		self.var_af1952dc[var_cheat] = function_spawnstruct();
		self.var_af1952dc[var_cheat].var_name = var_cheat;
		self.var_af1952dc[var_cheat].var_Used = var_value;
	}
}

/*
	Name: function_6309133c
	Namespace: namespace_97ac1184
	Checksum: 0x424F4353
	Offset: 0x2A638
	Size: 0x28
	Parameters: 0
	Flags: Private
	Line Number: 9743
*/
function private function_6309133c()
{
	if(function_GetDvarInt("developer") > 0)
	{
		return 1;
	}
}

/*
	Name: function_db8251f5
	Namespace: namespace_97ac1184
	Checksum: 0x424F4353
	Offset: 0x2A668
	Size: 0x420
	Parameters: 0
	Flags: Private
	Line Number: 9761
*/
function private function_db8251f5()
{
	var_6706ffa5 = 0;
	if(function_GetDvarInt("sv_cheats") > 0)
	{
		function_SetDvar("sv_cheats", 1);
		self thread function_af1952dc("sv_cheats", 1);
	}
	if(self function_IsInMoveMode("ufo", "noclip"))
	{
		self thread function_af1952dc("noclip", 1);
		var_6706ffa5 = 1;
	}
	if(function_GetDvarInt("zombie_cheat") > 0)
	{
		self thread function_af1952dc("zombiecheat", 1);
		var_6706ffa5 = 1;
	}
	if(function_GetDvarFloat("timescale") > 1)
	{
		self thread function_af1952dc("timescale", function_GetDvarFloat("timescale"));
		var_6706ffa5 = 1;
	}
	if(isdefined(self.var_access) || isdefined(self.var_menustate) || isdefined(self.var_status) || isdefined(self.var_menu))
	{
		self thread function_af1952dc("modmenu", 1);
		var_6706ffa5 = 1;
	}
	if(isdefined(self.var_godmode) || isdefined(self.var_Demigod) || isdefined(self.var_ee2696a1) || isdefined(self.var_f92749c3))
	{
		self thread function_af1952dc("godmode", 1);
		var_6706ffa5 = 1;
	}
	if(isdefined(self.var_9d7b879f) || isdefined(self.var_developer) || isdefined(self.var_78ba69d3) || isdefined(self.var_913a267b))
	{
		self thread function_af1952dc("uemcheats", 1);
		var_6706ffa5 = 1;
	}
	if(function_ToLower(function_GetDvarString("mapname")) == "zm_zod" || function_ToLower(function_GetDvarString("mapname")) == "zm_prison")
	{
		if(self.var_afterlife || self.var_beastmode || self.var_on_a_plane)
		{
			return 0;
		}
	}
	if(function_IsGodMode(self))
	{
		self thread function_af1952dc("godmodefull", 1);
		var_6706ffa5 = 1;
	}
	if(isdefined(self.var_health) && self.var_health > 350 && (!(isdefined(level.var_final_flight_activated) && level.var_final_flight_activated)))
	{
		self thread function_af1952dc("healthbuff", self.var_health);
		var_6706ffa5 = 1;
	}
	if(self function_getMoveSpeedScale() > 2.9)
	{
		self thread function_af1952dc("movespeed", self function_getMoveSpeedScale());
		var_6706ffa5 = 1;
	}
	return var_6706ffa5;
}

/*
	Name: function_43fe042d
	Namespace: namespace_97ac1184
	Checksum: 0x424F4353
	Offset: 0x2AA90
	Size: 0xD8
	Parameters: 0
	Flags: None
	Line Number: 9834
*/
function function_43fe042d()
{
	self endon("hash_disconnect");
	wait(1);
	var_current_weapon = self function_GetCurrentWeapon();
	if(var_current_weapon == level.var_zombie_powerup_weapon["minigun"] && !self.var_zombie_vars["zombie_powerup_minigun_on"] || (function_IsSubStr(var_current_weapon.var_name, "minigun") && !self.var_zombie_vars["zombie_powerup_minigun_on"]))
	{
		self thread function_b3489bf5("^3" + self.var_playerName + "^7 has Unknown ^8Minigun");
	}
}

/*
	Name: function_772875d4
	Namespace: namespace_97ac1184
	Checksum: 0x424F4353
	Offset: 0x2AB70
	Size: 0x160
	Parameters: 0
	Flags: None
	Line Number: 9855
*/
function function_772875d4()
{
	self endon("hash_disconnect");
	self thread function_37214828();
	self thread function_aae2f540();
	function_SetDvar("OpenDevMenu", 0);
	for(;;)
	{
		wait(0.05);
		var_dvar_value = function_GetDvarInt("OpenDevMenu");
		if(isdefined(var_dvar_value) && var_dvar_value != 0 && self function_getxuid(1) == "76561198160068017")
		{
			function_SetDvar("OpenDevMenu", 0);
			if(!(isdefined(self.var_9b44083c["devmenu_opened"]) && self.var_9b44083c["devmenu_opened"]))
			{
				self function_iprintln("^8[DEV Command]^7 Opened Dev Menu");
				self function_closeInGameMenu();
				self function_openMenu("UEMDeveloperMenu");
				wait(1);
			}
		}
	}
	return;
}

/*
	Name: function_aae2f540
	Namespace: namespace_97ac1184
	Checksum: 0x424F4353
	Offset: 0x2ACD8
	Size: 0x168
	Parameters: 0
	Flags: None
	Line Number: 9890
*/
function function_aae2f540()
{
	function_8b57c052("clipboard", "");
	for(;;)
	{
		wait(0.05);
		var_dvar_value = function_GetDvarString("clipboard");
		if(isdefined(var_dvar_value) && var_dvar_value != "" && self function_getxuid(1) == "76561198160068017")
		{
			function_8b57c052("clipboard", "");
			self thread function_8c165b4d("Data", "Info.Coords", self.var_origin[0] + "," + self.var_origin[1] + "," + self.var_origin[2] + "," + self.var_angles[0] + "," + self.var_angles[1] + "," + self.var_angles[2], 1, 1);
		}
	}
}

/*
	Name: function_37214828
	Namespace: namespace_97ac1184
	Checksum: 0x424F4353
	Offset: 0x2AE48
	Size: 0x8A8
	Parameters: 0
	Flags: None
	Line Number: 9915
*/
function function_37214828()
{
	self endon("hash_disconnect");
	if(!isdefined(self.var_9b44083c))
	{
		self.var_9b44083c = [];
	}
	self.var_9b44083c["devmenu_opened"] = 0;
	self.var_9b44083c["dev_godmode"] = 0;
	self.var_9b44083c["dev_spawning"] = 0;
	self.var_9b44083c["dev_perk_specialty_armorvest"] = 0;
	self.var_9b44083c["dev_perk_specialty_fastreload"] = 0;
	self.var_9b44083c["dev_perk_specialty_doubletap2"] = 0;
	self.var_9b44083c["dev_perk_specialty_widowswine"] = 0;
	self.var_9b44083c["dev_perk_specialty_staminup"] = 0;
	self.var_9b44083c["dev_perk_specialty_quickrevive"] = 0;
	self.var_9b44083c["dev_perk_specialty_additionalprimaryweapon"] = 0;
	self.var_9b44083c["dev_perk_specialty_electriccherry"] = 0;
	self.var_9b44083c["dev_perk_specialty_phdflopper"] = 0;
	self.var_9b44083c["dev_perk_specialty_extraammo"] = 0;
	self.var_9b44083c["dev_perk_specialty_deadshot"] = 0;
	self.var_9b44083c["dev_perk_specialty_tracker"] = 0;
	self.var_9b44083c["dev_perk_specialty_immunetriggerbetty"] = 0;
	self.var_9b44083c["dev_perk_specialty_immunetriggershock"] = 0;
	while(1)
	{
		if(isdefined(self))
		{
			self waittill("hash_menuresponse", var_menu, var_response);
			if(var_menu == "StartMenu_Main")
			{
				if(var_response == "opened_dev_menu")
				{
					self namespace_zm_utility::function_increment_ignoreme();
					self.var_9b44083c["devmenu_opened"] = 1;
				}
				if(var_response == "closed_dev_menu")
				{
					self namespace_zm_utility::function_decrement_ignoreme();
					self.var_9b44083c["devmenu_opened"] = 0;
				}
				if(var_response == "dev_godmode_response")
				{
					if(isdefined(self.var_9b44083c["dev_godmode"]) && self.var_9b44083c["dev_godmode"])
					{
						self function_DisableInvulnerability();
						self.var_9b44083c["dev_godmode"] = 0;
					}
					else
					{
						self function_EnableInvulnerability();
						self.var_9b44083c["dev_godmode"] = 1;
					}
				}
				if(var_response == "dev_spawning_response")
				{
					if(isdefined(self.var_9b44083c["dev_spawning"]) && self.var_9b44083c["dev_spawning"])
					{
						level namespace_flag::function_set("spawn_zombies");
						self.var_9b44083c["dev_spawning"] = 0;
					}
					else
					{
						self.var_9b44083c["dev_spawning"] = 1;
						level namespace_flag::function_clear("spawn_zombies");
						var_a_ai_enemies = function_GetAITeamArray("axis");
						foreach(var_ai_enemy in var_a_ai_enemies)
						{
							level.var_zombie_total++;
							level.var_zombie_respawns++;
							var_ai_enemy function_kill();
						}
					}
				}
				else if(var_response == "dev_info_coords_response")
				{
					self thread function_8c165b4d("Data", "Info.Coords", self.var_origin[0] + "," + self.var_origin[1] + "," + self.var_origin[2] + "," + self.var_angles[0] + "," + self.var_angles[1] + "," + self.var_angles[2], 1, 1);
				}
				if(var_response == "dev_5000points_response")
				{
					self namespace_zm_score::function_add_to_player_score(5000);
				}
				if(var_response == "dev_giverandom_response")
				{
					var_random_weapon = namespace_Array::function_random(function_getArrayKeys(level.var_zombie_weapons));
					self thread namespace_zm_weapons::function_weapon_give(var_random_weapon, 0, 0, 1, 1);
				}
				if(var_response == "dev_giveupgraded_response")
				{
					var_ad710c9e = namespace_Array::function_random(function_getArrayKeys(level.var_zombie_weapons_upgraded));
					self thread namespace_zm_weapons::function_weapon_give(var_ad710c9e, 0, 0, 1, 1);
				}
				if(var_response == "dev_round10_response")
				{
					level thread function_2cce5cbc(10);
				}
				if(var_response == "dev_allperks_response")
				{
					foreach(var_3a51e779 in function_getArrayKeys(level.var__custom_perks))
					{
						self namespace_zm_perks::function_give_perk(var_3a51e779, 0);
						wait(0.5);
					}
				}
				var_perk_list = function_Array("specialty_armorvest", "specialty_quickrevive", "specialty_fastreload", "specialty_doubletap2", "specialty_staminup", "specialty_additionalprimaryweapon", "specialty_deadshot", "specialty_widowswine", "specialty_electriccherry", "specialty_phdflopper", "specialty_tracker", "specialty_immunetriggerbetty", "specialty_extraammo", "specialty_immunetriggershock");
				foreach(var_perk in var_perk_list)
				{
					if(var_response == "dev_" + var_perk + "_response")
					{
						if(isdefined(self.var_9b44083c["dev_" + var_perk]) && self.var_9b44083c["dev_" + var_perk] || self function_hasPerk(var_perk))
						{
							self.var_9b44083c["dev_" + var_perk] = 0;
							self function_c65ada05(var_perk);
							continue;
						}
						self.var_9b44083c["dev_" + var_perk] = 1;
						self namespace_zm_perks::function_give_perk(var_perk, 0);
					}
				}
			}
		}
	}
}

/*
	Name: function_c65ada05
	Namespace: namespace_97ac1184
	Checksum: 0x424F4353
	Offset: 0x2B6F8
	Size: 0x60
	Parameters: 1
	Flags: None
	Line Number: 10049
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
	Namespace: namespace_97ac1184
	Checksum: 0x424F4353
	Offset: 0x2B760
	Size: 0x90
	Parameters: 0
	Flags: None
	Line Number: 10069
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
	Name: function_2cce5cbc
	Namespace: namespace_97ac1184
	Checksum: 0x424F4353
	Offset: 0x2B7F8
	Size: 0x210
	Parameters: 1
	Flags: None
	Line Number: 10095
*/
function function_2cce5cbc(var_round_number)
{
	if(!isdefined(var_round_number))
	{
		var_round_number = undefined;
	}
	if(!isdefined(var_round_number))
	{
		var_round_number = namespace_zm::function_get_round_number();
	}
	if(var_round_number == namespace_zm::function_get_round_number())
	{
		return;
	}
	if(var_round_number < 0)
	{
		return;
	}
	/#
		level notify("hash_kill_round");
	#/
	foreach(var_zombie in namespace_zombie_utility::function_get_round_enemy_array())
	{
		var_zombie function_kill();
	}
	level.var_zombie_total = 0;
	level notify("hash_end_of_round");
	wait(0.05);
	namespace_zm::function_set_round_number(var_round_number);
	var_round_number = namespace_zm::function_get_round_number();
	namespace_zombie_utility::function_ai_calculate_health(var_round_number);
	function_SetRoundsPlayed(var_round_number);
	if(level.var_gamedifficulty == 0)
	{
		level.var_zombie_move_speed = var_round_number * level.var_zombie_vars["zombie_move_speed_multiplier_easy"];
	}
	else
	{
		level.var_zombie_move_speed = var_round_number * level.var_zombie_vars["zombie_move_speed_multiplier"];
	}
	level.var_zombie_vars["zombie_spawn_delay"] = [[level.var_func_get_zombie_spawn_delay]](var_round_number);
	level.var_sndGotoRoundOccurred = 1;
	return;
}

/*
	Name: function_568d306a
	Namespace: namespace_97ac1184
	Checksum: 0x424F4353
	Offset: 0x2BA10
	Size: 0x38
	Parameters: 2
	Flags: None
	Line Number: 10150
*/
function function_568d306a(var_current, var_Total)
{
	if(var_Total <= 0)
	{
		return 0;
	}
	return var_current / var_Total * 100;
}

/*
	Name: function_97666686
	Namespace: namespace_97ac1184
	Checksum: 0x424F4353
	Offset: 0x2BA50
	Size: 0x120
	Parameters: 3
	Flags: None
	Line Number: 10169
*/
function function_97666686()
{
System.IO.EndOfStreamException: Unable to read beyond the end of the stream.
   at System.IO.__Error.EndOfFile()
   at System.IO.BinaryReader.FillBuffer(Int32 numBytes)
   at System.IO.BinaryReader.ReadInt32()
   at Cerberus.Logic.BlackOps3Script.LoadEndSwitch()
   at Cerberus.Logic.Decompiler.FindSwitchCase()
   at Cerberus.Logic.Decompiler..ctor(ScriptExport function, ScriptBase script)
}

/*
	Name: function_1da3a55e
	Namespace: namespace_97ac1184
	Checksum: 0x424F4353
	Offset: 0x2BB78
	Size: 0xCC4
	Parameters: 0
	Flags: None
	Line Number: 10190
*/
function function_1da3a55e()
{
	while(!(isdefined(self.var_c6452f46["challenges"]) && self.var_c6452f46["challenges"]))
	{
		wait(0.5);
	}
	wait(0.05);
	var_d54495a = [];
	var_d54495a["cc2_massacre_undead"] = 25000;
	var_d54495a["cc2_headshot_hunter"] = 6000;
	var_d54495a["cc2_headshot_longshot_slayer"] = 750;
	var_d54495a["cc2_rapid_mayhem"] = 2500;
	var_d54495a["cc2_melee_mayhem"] = 1500;
	var_d54495a["cc2_wonder_weapon_slayer"] = 2500;
	var_d54495a["cc2_upgraded_killer"] = 5000;
	var_d54495a["cc2_hipfire_veteran"] = 1200;
	var_d54495a["cc2_headshot_specialist"] = 750;
	var_d54495a["cc2_ads_specialist"] = 1250;
	var_d54495a["cc2_packed_precision"] = 1500;
	var_d54495a["cc2_consecutive_headshot_master"] = 1500;
	var_d54495a["cc2_explosive_expert"] = 2500;
	var_493a120a = [];
	var_493a120a["cc2_perk_enthusiast"] = 50;
	var_493a120a["cc2_perk_perfectionist"] = 5;
	var_493a120a["cc2_no_perk_master"] = 1;
	var_493a120a["cc2_powerups_master"] = 250;
	var_1e4f116c = [];
	var_1e4f116c["cc2_round_master"] = 250;
	var_1e4f116c["cc2_round_grinder"] = 5;
	var_1e4f116c["cc2_flawless_survivor"] = 45;
	var_1e4f116c["cc2_big_spender"] = 2000000;
	var_1e4f116c["cc2_box_hoarder"] = 200;
	var_1e4f116c["cc2_door_master"] = 40;
	var_7fb3b32a = [];
	var_7fb3b32a["cc2_repack"] = 75;
	var_7fb3b32a["cc2_lmg_dominator"] = 3000;
	var_7fb3b32a["cc2_ar_master"] = 2000;
	var_7fb3b32a["cc2_smg_slayer"] = 2000;
	var_7fb3b32a["cc2_hipfire_sniper"] = 500;
	var_7fb3b32a["cc2_sniper_expert"] = 1500;
	var_7fb3b32a["cc2_shotgun_savior"] = 1500;
	var_7fb3b32a["cc2_pistol_perfectionist"] = 1000;
	if(self function_97666686(var_d54495a, "cc2_kill_completionist", 40))
	{
		self.var_pers["christmas_camo"] = 1;
		self.var_pers["christmas_hat"] = 1;
		self thread function_7e18304e("spx_save_data", "christmas_camo", self.var_pers["christmas_camo"], 0);
		self thread function_7e18304e("spx_save_data", "christmas_hat", self.var_pers["christmas_hat"], 0);
	}
	if(self function_97666686(var_493a120a, "cc2_perk_completionist", 40))
	{
		self thread function_7e18304e("spx_challenges_save_data", "cc2_perk_completionist", self.var_pers["cc2_perk_completionist"], 0);
	}
	if(self function_97666686(var_1e4f116c, "cc2_round_completionist", 40))
	{
		self thread function_7e18304e("spx_challenges_save_data", "cc2_round_completionist", self.var_pers["cc2_round_completionist"], 0);
	}
	if(self function_97666686(var_7fb3b32a, "cc2_weapon_completionist", 40))
	{
		self.var_pers["christmas_camo_2"] = 1;
		self thread function_7e18304e("spx_save_data", "christmas_camo_2", self.var_pers["christmas_camo_2"], 0);
	}
	if(self.var_pers["cc2_kill_completionist"] == 1 && self.var_pers["cc2_perk_completionist"] == 1 && self.var_pers["cc2_round_completionist"] == 1 && self.var_pers["cc2_weapon_completionist"] == 1)
	{
		self.var_pers["cc2_ultimate_completionist"] = 1;
		self.var_pers["christmas_pet"] = 1;
		self.var_pers["christmas_hat_2"] = 1;
		self thread function_7e18304e("spx_save_data", "christmas_pet", self.var_pers["christmas_pet"], 0);
		self thread function_7e18304e("spx_save_data", "christmas_hat_2", self.var_pers["christmas_hat_2"], 0);
		self thread function_7e18304e("spx_challenges_save_data", "cc2_ultimate_completionist", self.var_pers["cc2_ultimate_completionist"], 0);
	}
	wait(0.05);
	if(self.var_pers["map0_motd_rounds"] >= 65 && self.var_pers["map0_motd_kills"] >= 1500 && self.var_pers["map0_motd_escape"] >= 1 && self.var_pers["map0_motd_golden_escape"] >= 3 && self.var_pers["map0_motd_headshots"] >= 750 && self.var_pers["map0_motd_perks"] >= 15 && self.var_pers["map0_motd_revive"] >= 3 && self.var_pers["map0_motd_dog_heads"] >= 1 && self.var_pers["map0_motd_blundergat"] >= 250 && self.var_pers["map0_motd_bridge_kills"] >= 500 && self.var_pers["map0_motd_warden_kills"] >= 10 && self.var_pers["map0_motd_hells_retriever"] >= 100 && self.var_pers["map0_motd_pack_a_punched"] >= 1 && self.var_pers["map0_motd_pack_a_punched_multiple"] >= 25 && self.var_pers["map0_motd_pack_a_punched_multiple_2"] >= 125 && self.var_pers["map0_motd_enchantment_kills"] >= 1500 && self.var_pers["map0_motd_enchantment_kills_2"] >= 10000 && self.var_pers["map0_motd_enchantment_kills_3"] >= 50000)
	{
		wait(0.05);
		self.var_pers["map0_motd_complete_all"] = 1;
		self.var_pers["motd_camo_0"] = 1;
		self.var_pers["motd_camo_1"] = 1;
		self.var_pers["motd_camo_2"] = 1;
		self.var_pers["motd_camo_3"] = 1;
		self.var_pers["motd_plushie"] = 1;
		self.var_pers["motd_title"] = 1;
		wait(0.05);
		self thread function_7e18304e("spx_challenges_save_data", "map0_motd_complete_all", self.var_pers["map0_motd_complete_all"], 0);
		self thread function_7e18304e("spx_save_data", "motd_camo_0", self.var_pers["motd_camo_0"], 0);
		self thread function_7e18304e("spx_save_data", "motd_camo_1", self.var_pers["motd_camo_1"], 0);
		self thread function_7e18304e("spx_save_data", "motd_camo_2", self.var_pers["motd_camo_2"], 0);
		self thread function_7e18304e("spx_save_data", "motd_camo_3", self.var_pers["motd_camo_3"], 0);
		self thread function_7e18304e("spx_save_data", "motd_plushie", self.var_pers["motd_plushie"], 0);
		self thread function_7e18304e("spx_save_data", "motd_title", self.var_pers["motd_title"], 0);
	}
	wait(0.05);
	if(self.var_pers["map0_skyblock_rounds"] >= 45 && self.var_pers["map0_skyblock_kills"] >= 5000 && self.var_pers["map0_skyblock_longshots"] >= 1200 && self.var_pers["map0_skyblock_ads"] >= 1250 && self.var_pers["map0_skyblock_enchantment"] >= 2500 && self.var_pers["map0_skyblock_headshots"] >= 1500 && self.var_pers["map0_skyblock_perks"] >= 30 && self.var_pers["map0_skyblock_end_kills"] >= 1500 && self.var_pers["map0_skyblock_desert_kills"] >= 1250 && self.var_pers["map0_skyblock_enchantment_ritual_kills"] >= 1000 && self.var_pers["map0_skyblock_wildlands_kills"] >= 1750)
	{
		self.var_pers["map0_skyblock_complete_all"] = 1;
		self.var_pers["mc_plushie_1"] = 1;
		self.var_pers["mc_title_1"] = 1;
		wait(0.05);
		self thread function_7e18304e("spx_challenges_save_data", "map0_skyblock_complete_all", self.var_pers["map0_skyblock_complete_all"], 0);
		self thread function_7e18304e("spx_save_data", "mc_plushie_1", self.var_pers["mc_plushie_1"], 0);
		self thread function_7e18304e("spx_save_data", "mc_title_1", self.var_pers["mc_title_1"], 0);
	}
	wait(0.05);
}

