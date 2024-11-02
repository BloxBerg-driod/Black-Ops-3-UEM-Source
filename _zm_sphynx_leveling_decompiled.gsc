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
	Name: __init__sytem__
	Namespace: namespace_97ac1184
	Checksum: 0x424F4353
	Offset: 0x7F40
	Size: 0x38
	Parameters: 0
	Flags: AutoExec
	Line Number: 64
*/
function autoexec __init__sytem__()
{
	system::register("zm_sphynx_leveling", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: namespace_97ac1184
	Checksum: 0x424F4353
	Offset: 0x7F80
	Size: 0x5A8
	Parameters: 0
	Flags: None
	Line Number: 79
*/
function __init__()
{
	util::registerClientSys("UEM.Data");
	switch(tolower(getdvarstring("mapname")))
	{
		case "zm_prison":
		{
			break;
		}
		default
		{
			if(!isdefined(level.giveCustomLoadout))
			{
				level.giveCustomLoadout = &function_65c8a9fb;
			}
		}
	}
	level.var_687cb838 = 1;
	level.var_18ffd3f2 = [];
	level thread function_c92b2b70();
	level.var_ac46587c = [];
	level.var_d824eaa9 = [];
	level.var_ed3d349f = [];
	level thread function_e5da2d1e();
	level.var_c3e446a = [];
	level.var_742cf7b3 = [];
	level.var_d70efd10 = [];
	level thread function_58027f04();
	level.var_5e620cb1 = [];
	level.var_7fd3975f = [];
	level.var_204377c = [];
	level thread function_7eb8b937();
	level.var_e6522d0f = [];
	level thread function_952b02b3();
	level.var_713a7800 = [];
	level thread function_9bae2e69();
	function_8b57c052("ModVersion", 188);
	function_8b57c052("fast_restart", 0);
	callback::on_connect(&function_8dcb2166);
	callback::on_connect(&function_acab6641);
	callback::on_connect(&function_3b74ce49);
	level.var_411289a8 = 0;
	callback::on_connect(&function_890b0605);
	thread function_9201588b();
	thread function_554820a1();
	level thread function_87a20e06();
	zm_spawner::register_zombie_death_event_callback(&function_7279da56);
	zm::register_player_damage_callback(&function_87d1927f);
	level thread function_7eb13385();
	level thread function_a485c61f();
	callback::on_connect(&function_e67bbb8);
	level thread function_c72f6f99();
	level thread function_6f50aabc();
	level thread function_6033a0ff();
	level thread function_41a254c();
	callback::on_connect(&function_28bace5f);
	level thread function_329aa7fe();
	level thread function_8de2bd80();
	level thread function_154491fc();
	level thread function_5b223195();
	callback::on_connect(&function_d029f398);
	callback::on_connect(&function_eeb79e2d);
	callback::on_connect(&function_31dfdcd7);
	level thread function_edad2d08(tolower(getdvarstring("mapname")));
	callback::on_connect(&function_5e4556db);
	level thread function_57821581();
	level.var_952dabaa = [];
	callback::on_connect(&function_654cb7f5);
	wait(2);
	switch(tolower(getdvarstring("mapname")))
	{
		case "zm_prison":
		{
			break;
		}
		default
		{
			if(!isdefined(level.giveCustomLoadout))
			{
				level.giveCustomLoadout = &function_65c8a9fb;
			}
		}
	}
	level thread function_1894510a();
	return;
	ERROR: Exception occured: Stack empty.
}

/*
	Name: function_97f22bf4
	Namespace: namespace_97ac1184
	Checksum: 0x424F4353
	Offset: 0x8530
	Size: 0x358
	Parameters: 2
	Flags: None
	Line Number: 177
*/
function function_97f22bf4(mapname, generic)
{
	if(!isdefined(generic))
	{
		generic = 0;
	}
	players = getplayers();
	if(players.size < 2)
	{
		players[0] thread function_b3489bf5("^3" + players[0].playername + "^7 completed the " + mapname + " Easter Egg");
		if(isdefined(generic) && generic)
		{
			players[0] notify("hash_79ef118b", "map_ee_completed", undefined);
		}
		else
		{
			players[0] notify("hash_79ef118b", "map_ee_completed_" + level.var_fcee636, undefined);
		}
		level notify("hash_8c3d4295", players[0], "solo_easter_eggs_completed", 1, 0);
		wait(1);
		if(level.var_8f1fd1e4 < players[0].pers[level.var_fcee636 + "_completion_time_solo_ee"] || players[0].pers[level.var_fcee636 + "_completion_time_solo_ee"] == 0)
		{
			level notify("hash_8c3d4295", players[0], "completion_time_solo_ee", level.var_8f1fd1e4, 1);
		}
	}
	else
	{
		foreach(player in players)
		{
			player thread function_b3489bf5("^3" + player.playername + "^7 completed the " + mapname + " Easter Egg");
			if(isdefined(generic) && generic)
			{
				player notify("hash_79ef118b", "map_ee_completed", undefined);
			}
			else
			{
				player notify("hash_79ef118b", "map_ee_completed_" + level.var_fcee636, undefined);
			}
			level notify("hash_8c3d4295", player, "easter_eggs_completed", 1, 0);
			wait(1);
			if(level.var_8f1fd1e4 < player.pers[level.var_fcee636 + "_completion_time_solo_ee"] || player.pers[level.var_fcee636 + "_completion_time_solo_ee"] == 0)
			{
				level notify("hash_8c3d4295", player, "completion_time_ee", level.var_8f1fd1e4, 1);
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
	Offset: 0x8890
	Size: 0x8A8
	Parameters: 1
	Flags: None
	Line Number: 237
*/
function function_edad2d08(map_name)
{
	switch(map_name)
	{
		case "zm_zod":
		{
			level thread function_4c32d3b7();
			level.var_fcee636 = "soe";
			level thread function_5c8d8a45();
			wait(0.05);
			level flag::wait_till("ee_complete");
			level thread function_97f22bf4("Shadows of Evil", 0);
			break;
		}
		case "zm_factory":
		{
			level.var_fcee636 = "giant";
			level thread function_5c8d8a45();
			wait(0.05);
			level flag::wait_till("hide_and_seek");
			level flag::wait_till("ee_exp_monkey");
			level flag::wait_till("ee_bowie_bear");
			level flag::wait_till("ee_perk_bear");
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
			level flag::wait_till("flag_outro_cutscene_done");
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
			level flag::wait_till("snd_zhdegg_activate");
			level thread function_97f22bf4("Nacht der Untoten", 0);
			break;
		}
		case "zm_asylum":
		{
			level.var_fcee636 = "verruckt";
			level thread function_5c8d8a45();
			wait(0.05);
			level flag::wait_till("snd_zhdegg_activate");
			level thread function_97f22bf4("Verruckt", 0);
			break;
		}
		case "zm_sumpf":
		{
			level.var_fcee636 = "shino";
			level thread function_5c8d8a45();
			wait(0.05);
			level flag::wait_till("snd_zhdegg_activate");
			level thread function_97f22bf4("Shi-No Numa", 0);
			break;
		}
		case "zm_theater":
		{
			level.var_fcee636 = "kino";
			level thread function_5c8d8a45();
			wait(0.05);
			level flag::wait_till("snd_zhdegg_activate");
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
			level waittill("moon_sidequest_achieved");
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
			level flag::wait_till("quest_complete");
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
		case "zm_prison":
		{
			level.var_fcee636 = "prison";
			break;
		}
		case "zm_feddyfazballs3":
		{
			zm_spawner::add_custom_zombie_spawn_logic(&function_95eca5c1);
			break;
		}
	}
}

/*
	Name: function_95eca5c1
	Namespace: namespace_97ac1184
	Checksum: 0x424F4353
	Offset: 0x9140
	Size: 0x48
	Parameters: 0
	Flags: None
	Line Number: 444
*/
function function_95eca5c1()
{
	self endon("death");
	wait(1);
	original_health = self.health;
	self.health = level.var_6a2a6466;
	self.maxhealth = self.health;
}

/*
	Name: function_3753af4
	Namespace: namespace_97ac1184
	Checksum: 0x424F4353
	Offset: 0x9190
	Size: 0x8
	Parameters: 0
	Flags: None
	Line Number: 463
*/
function function_3753af4()
{
	return;
}

/*
	Name: function_61dbe30b
	Namespace: namespace_97ac1184
	Checksum: 0x424F4353
	Offset: 0x91A0
	Size: 0xD8
	Parameters: 0
	Flags: None
	Line Number: 478
*/
function function_61dbe30b()
{
	if(getplayers().size < 2)
	{
		iprintln("^8[Solo Shangri-La EE]^7 Tile Step");
		tileset1 = getentarray("sq_oafc_tileset1", "targetname");
		tileset2 = getentarray("sq_oafc_tileset2", "targetname");
		level.var_a48bfa55 thread function_6e17a256(tileset1, 1);
		level.var_ca8e74be thread function_6e17a256(tileset2, 2);
	}
}

/*
	Name: function_6e17a256
	Namespace: namespace_97ac1184
	Checksum: 0x424F4353
	Offset: 0x9280
	Size: 0x180
	Parameters: 2
	Flags: None
	Line Number: 500
*/
function function_6e17a256(tiles, set)
{
	self endon("reset_tiles");
	while(1)
	{
		for(i = 0; i < tiles.size; i++)
		{
			tile = tiles[i];
			if(isdefined(tile) && !tile.matched)
			{
				var_95d1fa7 = self function_1a1c7361();
				if(var_95d1fa7)
				{
					iprintlnbold("Player Touching Tile");
					while(isdefined(var_95d1fa7) && self istouching(var_95d1fa7) && var_95d1fa7.sessionstate != "spectator" && !tile.matched)
					{
						wait(5);
						if(set == 1)
						{
							level.var_66c77de0.tile = level.var_d8ceed1b.tile;
						}
						iprintlnbold("Setting Tile");
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
	Offset: 0x9408
	Size: 0x28
	Parameters: 0
	Flags: None
	Line Number: 540
*/
function function_2f9aae88()
{
	self endon("reset_tiles");
	wait(60);
	self notify("hash_1a7b335c");
	return;
	ERROR: Exception occured: Stack empty.
}

/*
	Name: function_1a1c7361
	Namespace: namespace_97ac1184
	Checksum: 0x424F4353
	Offset: 0x9438
	Size: 0x98
	Parameters: 0
	Flags: None
	Line Number: 559
*/
function function_1a1c7361()
{
	players = getplayers();
	for(i = 0; i < players.size; i++)
	{
		if(players[i].sessionstate != "spectator" && self istouching(players[i]))
		{
			return players[i];
		}
	}
	return undefined;
}

/*
	Name: function_a10fc37
	Namespace: namespace_97ac1184
	Checksum: 0x424F4353
	Offset: 0x94D8
	Size: 0xA8
	Parameters: 0
	Flags: None
	Line Number: 582
*/
function function_a10fc37()
{
	level flag::wait_till("power_on");
	if(getplayers().size < 4)
	{
		iprintln("^8[Solo Shangri-La EE]^7 Keep Buttons Pressed");
		Buttons = getentarray("sq_sundial_button", "targetname");
		array::thread_all(Buttons, &sundial_button);
		return;
	}
}

/*
	Name: sundial_button
	Namespace: namespace_97ac1184
	Checksum: 0x424F4353
	Offset: 0x9588
	Size: 0x98
	Parameters: 0
	Flags: None
	Line Number: 604
*/
function sundial_button()
{
	level endon("end_game");
	wait(2);
	while(1)
	{
		self.trigger waittill("trigger", who);
		self thread function_20535e0f();
		self thread function_d43986b0();
		self util::waittill_any_return("four_sundial_buttons_pressed", "sundial_buttons_reset");
		wait(0.5);
	}
}

/*
	Name: function_20535e0f
	Namespace: namespace_97ac1184
	Checksum: 0x424F4353
	Offset: 0x9628
	Size: 0x60
	Parameters: 0
	Flags: None
	Line Number: 628
*/
function function_20535e0f()
{
	self endon("hash_1e0863dd");
	self endon("hash_1fcf81ad");
	while(level._sundial_buttons_pressed != 4)
	{
		self.trigger notify("trigger");
		wait(0.5);
	}
	self notify("hash_1fcf81ad");
	return;
	ERROR: Bad function call
}

/*
	Name: function_d43986b0
	Namespace: namespace_97ac1184
	Checksum: 0x424F4353
	Offset: 0x9690
	Size: 0x30
	Parameters: 0
	Flags: None
	Line Number: 652
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
	Offset: 0x96C8
	Size: 0x38
	Parameters: 0
	Flags: None
	Line Number: 670
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
	Offset: 0x9708
	Size: 0x160
	Parameters: 0
	Flags: None
	Line Number: 686
*/
function function_e0477a32()
{
	if(getplayers().size < 4)
	{
		level.var_421ff75e = 1;
		level flag::wait_till("ritual_pap_complete");
		var_f2d6183d = 0;
		while(var_f2d6183d < getplayers().size)
		{
			foreach(player in getplayers())
			{
				if(level.var_15954023.weapons[player.characterindex][2])
				{
					var_f2d6183d++;
				}
			}
		}
		iprintln("^8[Solo Shadows of Evil EE]^7 Book EE Activated");
		level flag::set("ee_begin");
	}
}

/*
	Name: function_6e4cf212
	Namespace: namespace_97ac1184
	Checksum: 0x424F4353
	Offset: 0x9870
	Size: 0xC8
	Parameters: 0
	Flags: None
	Line Number: 718
*/
function function_6e4cf212()
{
	wait(0.05);
	level flag::wait_till("ee_boss_defeated");
	iprintln("^8[Solo Shadows of Evil EE]^7 Keep Rails Electrified");
	if(getplayers().size < 4)
	{
		for(i = 1; i < 4; i++)
		{
			getent("ee_district_rail_electrified_" + i, "targetname") thread function_a4a65789();
		}
	}
}

/*
	Name: function_a4a65789
	Namespace: namespace_97ac1184
	Checksum: 0x424F4353
	Offset: 0x9940
	Size: 0x50
	Parameters: 0
	Flags: None
	Line Number: 742
*/
function function_a4a65789()
{
	self endon("death");
	level endon("hash_53e673b7");
	self waittill("trigger");
	for(;;)
	{
		self notify("trigger");
		wait(0.2);
		level waittill(self.targetname);
	}
}

/*
	Name: function_83a09031
	Namespace: namespace_97ac1184
	Checksum: 0x424F4353
	Offset: 0x9998
	Size: 0x68
	Parameters: 0
	Flags: None
	Line Number: 765
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
	Offset: 0x9A08
	Size: 0x120
	Parameters: 0
	Flags: None
	Line Number: 784
*/
function function_5d7d1a95()
{
	wait(0.05);
	level flag::wait_till("passkey_confirmed");
	if(getplayers().size < 2)
	{
		iprintln("^8[Solo Ascension EE]^7 {Thundergun} Step Watcher");
		origin = (-24.8214, -1368.16, -166.247);
		while(!level flag::get("weapons_combined"))
		{
			triggers = getentarray("trigger_damage", "classname");
			var_2df1183b = arraygetclosest(origin, triggers);
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
	Offset: 0x9B30
	Size: 0x140
	Parameters: 0
	Flags: None
	Line Number: 815
*/
function function_be0905d8()
{
	self endon("death");
	while(isdefined(self))
	{
		self waittill("damage", amount, inflictor, direction, point, type, tagname, modelname, partname, weapon);
		wait(0.05);
		self notify("damage", amount, inflictor, direction, point, "MOD_PROJECTILE", tagname, modelname, partname, getweapon("ray_gun_upgraded"));
		wait(0.05);
		self notify("damage", amount, inflictor, direction, point, "MOD_PROJECTILE", tagname, modelname, partname, getweapon("nesting_dolls"));
		wait(0.05);
	}
}

/*
	Name: function_f0cd9499
	Namespace: namespace_97ac1184
	Checksum: 0x424F4353
	Offset: 0x9C78
	Size: 0x470
	Parameters: 0
	Flags: None
	Line Number: 839
*/
function function_f0cd9499()
{
	wait(0.05);
	level flag::wait_till("pressure_sustained");
	if(getplayers().size < 2)
	{
		iprintln("^8[Solo Ascension EE]^7 {Letter} Step Watcher");
		level.var_46651379["a"].origin = (291.462, -2317.77, -74.875) + VectorScale((0, 0, 1), 30);
		level.var_46651379["e"].origin = (-758.268, -23.0314, -484.875) + VectorScale((0, 0, 1), 30);
		level.var_46651379["h"].origin = (1752.57, 1129.45, 343.125) + VectorScale((0, 0, 1), 30);
		level.var_46651379["i"].origin = (-583.678, -24.54, -484.875) + VectorScale((0, 0, 1), 30);
		level.var_46651379["l"].origin = (163.868, -2201.75, -74.875) + VectorScale((0, 0, 1), 30);
		level.var_46651379["m"].origin = (-2269.78, 1657.05, -67.875) + VectorScale((0, 0, 1), 30);
		level.var_46651379["n"].origin = (1654.65, 1255.31, 343.125) + VectorScale((0, 0, 1), 30);
		level.var_46651379["r"].origin = (33.65, -2288.17, -74.875) + VectorScale((0, 0, 1), 30);
		level.var_46651379["s"].origin = (1749.22, 1359.75, 343.125) + VectorScale((0, 0, 1), 30);
		level.var_46651379["t"].origin = (-2153.33, 1772.59, -67.875) + VectorScale((0, 0, 1), 30);
		level.var_46651379["u"].origin = (-531.425, -151.012, -484.875) + VectorScale((0, 0, 1), 30);
		level.var_46651379["y"].origin = (-2276.25, 1882.15, -67.875) + VectorScale((0, 0, 1), 30);
		lander = getent("lander", "targetname");
		while(!level flag::get("passkey_confirmed"))
		{
			level waittill("lander_launched");
			if(lander.called)
			{
				start = lander.depart_station;
				dest = lander.station;
				letter = level.var_8093285f[start][dest];
				model = level.var_46651379[letter];
			}
		}
	}
}

/*
	Name: function_9b858dd2
	Namespace: namespace_97ac1184
	Checksum: 0x424F4353
	Offset: 0xA0F0
	Size: 0x1C8
	Parameters: 0
	Flags: None
	Line Number: 883
*/
function function_9b858dd2()
{
	level endon("hash_589f4116");
	if(getplayers().size < 4)
	{
		pressed = 0;
		switches = struct::get_array("sync_switch_start", "targetname");
		for(;;)
		{
			level waittill("hash_7dad0c40");
			pressed = 0;
			for(i = 0; i < switches.size; i++)
			{
				if(isdefined(switches[i].pressed) && switches[i].pressed)
				{
					pressed++;
				}
			}
			if(pressed >= getplayers().size)
			{
				foreach(player in getplayers())
				{
					playsoundatposition("zmb_ee_syncbutton_success", player.origin);
				}
				level flag::set("switches_synced");
				level notify("hash_589f4116");
			}
		}
	}
}

/*
	Name: function_5c8d8a45
	Namespace: namespace_97ac1184
	Checksum: 0x424F4353
	Offset: 0xA2C0
	Size: 0x170
	Parameters: 0
	Flags: None
	Line Number: 924
*/
function function_5c8d8a45()
{
	for(;;)
	{
		level waittill("hash_8c3d4295", player, stat_name, stat_value, overwrite);
		if(!(isdefined(player.var_c6452f46["leveling"]) && player.var_c6452f46["leveling"]))
		{
		}
		else if(isdefined(overwrite) && overwrite)
		{
			player.pers[level.var_fcee636 + "_" + stat_name] = stat_value;
		}
		else
		{
			player.pers[level.var_fcee636 + "_" + stat_name] = player.pers[level.var_fcee636 + "_" + stat_name] + stat_value;
		}
		player thread function_7e18304e("spx_maps_save_data", level.var_fcee636 + "_" + stat_name, player.pers[level.var_fcee636 + "_" + stat_name], 0);
	}
}

/*
	Name: function_1894510a
	Namespace: namespace_97ac1184
	Checksum: 0x424F4353
	Offset: 0xA438
	Size: 0x30
	Parameters: 0
	Flags: None
	Line Number: 954
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
	Offset: 0xA470
	Size: 0xF0
	Parameters: 0
	Flags: None
	Line Number: 971
*/
function function_693ce8f()
{
	var_ba5e26d7 = getent(self.target, "targetname");
	model = getent(var_ba5e26d7.target, "targetname");
	struct = struct::get(model.target, "targetname");
	var_ba5e26d7 delete();
	model delete();
	struct delete();
	self delete();
	return;
	ERROR: Exception occured: Stack empty.
}

/*
	Name: function_5b223195
	Namespace: namespace_97ac1184
	Checksum: 0x424F4353
	Offset: 0xA568
	Size: 0xB8
	Parameters: 0
	Flags: None
	Line Number: 994
*/
function function_5b223195()
{
	var_b3fba7c9 = getentarray("use_elec_switch", "targetname");
	foreach(switches in var_b3fba7c9)
	{
		switches thread function_6f43d32d();
	}
	return;
	ERROR: Exception occured: Stack empty.
}

/*
	Name: function_6f43d32d
	Namespace: namespace_97ac1184
	Checksum: 0x424F4353
	Offset: 0xA628
	Size: 0x60
	Parameters: 0
	Flags: None
	Line Number: 1015
*/
function function_6f43d32d()
{
	while(1)
	{
		self waittill("trigger", player);
		player thread function_b3489bf5("^3" + player.playername + "^7 turned on ^8Power");
	}
}

/*
	Name: function_87a20e06
	Namespace: namespace_97ac1184
	Checksum: 0x424F4353
	Offset: 0xA690
	Size: 0x60
	Parameters: 0
	Flags: None
	Line Number: 1034
*/
function function_87a20e06()
{
	wait(0.05);
	level flag::wait_till("debug_dev");
	thread function_a6695a32();
	thread function_edb8bb7a();
	thread function_7f5d1838();
}

/*
	Name: function_1a5ddca8
	Namespace: namespace_97ac1184
	Checksum: 0x424F4353
	Offset: 0xA6F8
	Size: 0x80
	Parameters: 0
	Flags: None
	Line Number: 1053
*/
function function_1a5ddca8()
{
	if(!array::contains(level.var_d99c8870, self getxuid(1)))
	{
		iprintlnbold("^1 Illegal Player Detected! ^7 Kick Player");
		wait(2);
		kick(self getentitynumber());
	}
}

/*
	Name: function_654cb7f5
	Namespace: namespace_97ac1184
	Checksum: 0x424F4353
	Offset: 0xA780
	Size: 0x50
	Parameters: 0
	Flags: None
	Line Number: 1073
*/
function function_654cb7f5()
{
	self util::waittill_any("disconnect");
	level.var_952dabaa[self.name] = self zm_weapons::player_get_loadout();
}

/*
	Name: function_36b0e3e7
	Namespace: namespace_97ac1184
	Checksum: 0x424F4353
	Offset: 0xA7D8
	Size: 0x48
	Parameters: 0
	Flags: None
	Line Number: 1089
*/
function function_36b0e3e7()
{
	if(isdefined(level.var_952dabaa[self.name]))
	{
		self zm_weapons::player_give_loadout(level.var_952dabaa[self.name], 1, 1);
		return;
	}
	ERROR: Bad function call
}

/*
	Name: function_65c8a9fb
	Namespace: namespace_97ac1184
	Checksum: 0x424F4353
	Offset: 0xA828
	Size: 0x228
	Parameters: 1
	Flags: None
	Line Number: 1109
*/
function function_65c8a9fb(b_switch_weapon)
{
	if(!isdefined(self.hasCompletedSuperEE))
	{
		self.hasCompletedSuperEE = self zm_stats::get_global_stat("DARKOPS_GENESIS_SUPER_EE") > 0;
	}
	self giveweapon(level.weaponBaseMelee);
	if(isdefined(level.var_952dabaa[self.name]))
	{
		self zm_weapons::player_give_loadout(level.var_952dabaa[self.name], 1, 1);
	}
	else
	{
		wait(1);
		if(self.hasCompletedSuperEE)
		{
			self zm_weapons::weapon_give(level.start_weapon, 0, 0, 1, 0);
			self givemaxammo(level.start_weapon);
			self zm_weapons::weapon_give(level.super_ee_weapon, 0, 0, 1, 1);
		}
		else if(level.start_weapon == getweapon("pistol_m1911") || level.start_weapon == getweapon("pistol_standard") || level.start_weapon == getweapon("pistol_revolver38") || level.start_weapon == getweapon("pistol_burst"))
		{
			self zm_weapons::weapon_give(level.start_weapon, 0, 0, 1, 1);
		}
		else
		{
			level.start_weapon = getweapon("pistol_standard");
			self zm_weapons::weapon_give(level.start_weapon, 0, 0, 1, 1);
		}
	}
}

/*
	Name: function_952b02b3
	Namespace: namespace_97ac1184
	Checksum: 0x424F4353
	Offset: 0xAA58
	Size: 0x230
	Parameters: 0
	Flags: None
	Line Number: 1151
*/
function function_952b02b3()
{
	index = 1;
	table = "gamedata/weapons/favorite_weapons.csv";
	for(row = tablelookuprow(table, index); isdefined(row); row = tablelookuprow(table, index))
	{
		index = int(checkStringValid(row[0]));
		name = checkStringValid(row[1]);
		weight = int(checkStringValid(row[2]));
		var_3c4d7cf6 = checkStringValid(row[3]);
		displayname = checkStringValid(row[4]);
		if(isdefined(name) && name != "")
		{
			level.var_e6522d0f[index] = spawnstruct();
			level.var_e6522d0f[index].index = index;
			level.var_e6522d0f[index].name = name;
			level.var_e6522d0f[index].weight = weight;
			level.var_e6522d0f[index].var_3c4d7cf6 = var_3c4d7cf6;
			level.var_e6522d0f[index].displayname = displayname;
		}
		index++;
	}
}

/*
	Name: function_c92b2b70
	Namespace: namespace_97ac1184
	Checksum: 0x424F4353
	Offset: 0xAC90
	Size: 0x1F0
	Parameters: 0
	Flags: None
	Line Number: 1185
*/
function function_c92b2b70()
{
	index = 1;
	table = "gamedata/leveling/supporters.csv";
	for(row = tablelookuprow(table, index); isdefined(row); row = tablelookuprow(table, index))
	{
		name = checkStringValid(row[0]);
		rank = tolower(checkStringValid(row[1]));
		var_57fb29cc = tolower(checkStringValid(row[2]));
		var_81820b10 = checkStringValid(row[3]);
		if(isdefined(name) && name != "")
		{
			level.var_18ffd3f2[var_81820b10] = spawnstruct();
			level.var_18ffd3f2[var_81820b10].var_81820b10 = var_81820b10;
			level.var_18ffd3f2[var_81820b10].rank = rank;
			level.var_18ffd3f2[var_81820b10].var_57fb29cc = var_57fb29cc;
			level.var_18ffd3f2[var_81820b10].name = name;
		}
		index++;
	}
}

/*
	Name: function_acab6641
	Namespace: namespace_97ac1184
	Checksum: 0x424F4353
	Offset: 0xAE88
	Size: 0xCF0
	Parameters: 0
	Flags: None
	Line Number: 1217
*/
function function_acab6641()
{
	self.var_b74a3cd1 = [];
	self.var_b74a3cd1["prestige"] = int(0);
	self.var_b74a3cd1["level"] = int(1);
	self.var_b74a3cd1["xp"] = int(0);
	self.var_b74a3cd1["xp_multiplier"] = int(100);
	self.var_b74a3cd1["prestige_legend"] = int(0);
	self.var_b74a3cd1["prestige_absolute"] = int(0);
	self.var_b74a3cd1["prestige_ultimate"] = int(0);
	self.var_b74a3cd1["brutal_rank"] = int(0);
	self.var_b74a3cd1["brutal_xp"] = int(0);
	self.var_b74a3cd1["xp_gained_this_game"] = int(0);
	self.var_b74a3cd1["xp_per_second"] = int(0);
	self.var_b74a3cd1["xp_highest_this_game"] = int(0);
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
	self globallogic_score::initPersStat("powerups_grabbed", 0);
	self globallogic_score::initPersStat("special_kills", 0);
	self globallogic_score::initPersStat("highest_round", 0);
	self globallogic_score::initPersStat("assists", 0);
	self globallogic_score::initPersStat("total_games_played", 0);
	self globallogic_score::initPersStat("highest_enchantment", 0);
	self globallogic_score::initPersStat("highest_total_playtime", 0);
	self globallogic_score::initPersStat("total_rounds", 0);
	self globallogic_score::initPersStat("milestone_kills", 0);
	self globallogic_score::initPersStat("milestone_headshots", 0);
	self globallogic_score::initPersStat("player_points", 0);
	self globallogic_score::initPersStat("cheated_runs", 0);
	self globallogic_score::initPersStat("exfil_started", 0);
	self globallogic_score::initPersStat("succesful_exfil", 0);
	self globallogic_score::initPersStat("flawless_game", 0);
	self globallogic_score::initPersStat("deaths", 0);
	self globallogic_score::initPersStat("highest_total_xpm", 0);
	self globallogic_score::initPersStat("total_points", 0);
	self globallogic_score::initPersStat("zombie_kills", 0);
	self globallogic_score::initPersStat("dog_kills", 0);
	self globallogic_score::initPersStat("melee_kills", 0);
	self globallogic_score::initPersStat("equipment_kills", 0);
	self globallogic_score::initPersStat("perk_juggernog", 0);
	self globallogic_score::initPersStat("perk_revive", 0);
	self globallogic_score::initPersStat("perk_speed", 0);
	self globallogic_score::initPersStat("perk_mule", 0);
	self globallogic_score::initPersStat("perk_stamin", 0);
	self globallogic_score::initPersStat("perk_doubletap", 0);
	self globallogic_score::initPersStat("perk_widows", 0);
	self globallogic_score::initPersStat("perk_deadshot", 0);
	self globallogic_score::initPersStat("perk_cherry", 0);
	self globallogic_score::initPersStat("perk_realsteal", 0);
	self globallogic_score::initPersStat("perk_phd", 0);
	self globallogic_score::initPersStat("perk_perception", 0);
	self globallogic_score::initPersStat("perk_bandolier", 0);
	self globallogic_score::initPersStat("wunderfizz_used", 0);
	self globallogic_score::initPersStat("powerup_xpdrop", 0);
	self globallogic_score::initPersStat("powerup_max", 0);
	self globallogic_score::initPersStat("powerup_doublepoints", 0);
	self globallogic_score::initPersStat("powerup_instakill", 0);
	self globallogic_score::initPersStat("powerup_carpenter", 0);
	self globallogic_score::initPersStat("powerup_firesale", 0);
	self globallogic_score::initPersStat("powerup_deathmachine", 0);
	self globallogic_score::initPersStat("powerup_nuke", 0);
	self globallogic_score::initPersStat("powerup_bonus_points", 0);
	self globallogic_score::initPersStat("deploy_ammo_buy", 0);
	self globallogic_score::initPersStat("deploy_rage_inducer", 0);
	self globallogic_score::initPersStat("deploy_wunderfizz", 0);
	self globallogic_score::initPersStat("deploy_cash_shared", 0);
	self globallogic_score::initPersStat("mutator_settings", 0);
	self globallogic_score::initPersStat("seasonal_weapons_completed", 0);
	self globallogic_score::initPersStat("seasonal_points", 0);
	self globallogic_score::initPersStat("halloween_camo", 0);
	self globallogic_score::initPersStat("halloween_camo_2", 0);
	self globallogic_score::initPersStat("halloween_pumpkin_hat", 0);
	self globallogic_score::initPersStat("halloween_title", 0);
	self globallogic_score::initPersStat("christmas_camo", 0);
	self globallogic_score::initPersStat("christmas_hat", 0);
	self globallogic_score::initPersStat("game_downs", 0);
	self globallogic_score::initPersStat("game_revives", 0);
	self globallogic_score::initPersStat("game_distance_traveled", 0);
	self globallogic_score::initPersStat("game_bgbs_chewed", 0);
	self globallogic_score::initPersStat("game_use_magicbox", 0);
	self globallogic_score::initPersStat("game_wallbuy_weapons_purchased", 0);
	self globallogic_score::initPersStat("game_buildables_built", 0);
	self globallogic_score::initPersStat("game_boards", 0);
	self globallogic_score::initPersStat("game_total_shots", 0);
	self globallogic_score::initPersStat("game_total_hits", 0);
	self globallogic_score::initPersStat("game_total_misses", 0);
	self globallogic_score::initPersStat("gungame_games_played", 0);
	self globallogic_score::initPersStat("gungame_time_played", 0);
	self globallogic_score::initPersStat("gungame_flawless_wins", 0);
	self globallogic_score::initPersStat("gungame_wins", 0);
	self globallogic_score::initPersStat("gungame_losses", 0);
	self globallogic_score::initPersStat("gungame_kills", 0);
	self globallogic_score::initPersStat("gungame_headshots", 0);
	self globallogic_score::initPersStat("gungame_downs", 0);
	for(i = 0; i < level.var_d70efd10.size; i++)
	{
		self globallogic_score::initPersStat(level.var_d70efd10[i], 0);
	}
	while(!isdefined(level.var_5e620cb1))
	{
		wait(0.5);
	}
	for(i = 0; i < level.var_5e620cb1.size; i++)
	{
		self globallogic_score::initPersStat(level.var_7fd3975f[i], 0);
	}
}

/*
	Name: function_28bace5f
	Namespace: namespace_97ac1184
	Checksum: 0x424F4353
	Offset: 0xBB80
	Size: 0x138
	Parameters: 0
	Flags: None
	Line Number: 1344
*/
function function_28bace5f()
{
	self endon("disconnect");
	for(;;)
	{
		self util::waittill_any_return("bled_out", "death");
		if(!(isdefined(self.var_c6452f46["leveling"]) && self.var_c6452f46["leveling"]))
		{
		}
		else
		{
			self.pers["deaths"]++;
			self thread function_7e18304e("spx_end_game_save_data", "end_game_total_deaths", 1, 0);
			self thread function_7e18304e("spx_save_data", "deaths", self.pers["deaths"], 0);
			self thread function_b3489bf5(self.playername + " Died!");
			self thread function_b3489bf5("^3" + self.playername + "^7 ^9Bled Out!");
		}
	}
}

/*
	Name: function_3b74ce49
	Namespace: namespace_97ac1184
	Checksum: 0x424F4353
	Offset: 0xBCC0
	Size: 0x60
	Parameters: 0
	Flags: None
	Line Number: 1374
*/
function function_3b74ce49()
{
	wait(5);
	level.custom_game_over_hud_elem = undefined;
	if(self.score > 1000)
	{
		self.score = 500;
	}
	if(isdefined(level.var_9d7722be) && level.var_9d7722be)
	{
		level.var_d70d8449 destroy();
	}
}

/*
	Name: function_329aa7fe
	Namespace: namespace_97ac1184
	Checksum: 0x424F4353
	Offset: 0xBD28
	Size: 0x48
	Parameters: 0
	Flags: None
	Line Number: 1398
*/
function function_329aa7fe()
{
	for(;;)
	{
		level waittill("powerup_dropped", powerup, dropped);
		powerup thread function_f02048a0(dropped);
	}
}

/*
	Name: function_f02048a0
	Namespace: namespace_97ac1184
	Checksum: 0x424F4353
	Offset: 0xBD78
	Size: 0xCC8
	Parameters: 1
	Flags: None
	Line Number: 1417
*/
function function_f02048a0(dropped)
{
	self waittill("powerup_grabbed", who);
	if(isdefined(who.var_c6452f46["leveling"]) && who.var_c6452f46["leveling"])
	{
		switch(self.powerup_name)
		{
			case "xp_drop":
			{
				foreach(player in getplayers())
				{
					player.pers["powerup_xpdrop"] = player.pers["powerup_xpdrop"] + 1;
					player thread function_7e18304e("spx_end_game_save_data", "end_game_powerup_xpdrop", 1, 0);
					player thread function_7e18304e("spx_save_data", "powerup_xpdrop", player.pers["powerup_xpdrop"], 0);
				}
				who thread function_b3489bf5("^3" + who.playername + "^7 picked up ^8XP Drop");
				break;
			}
			case "full_ammo":
			{
				foreach(player in getplayers())
				{
					player.pers["powerup_max"] = player.pers["powerup_max"] + 1;
					player thread function_7e18304e("spx_end_game_save_data", "end_game_powerup_max", 1, 0);
					player thread function_7e18304e("spx_save_data", "powerup_max", player.pers["powerup_max"], 0);
				}
				who thread function_b3489bf5("^3" + who.playername + "^7 picked up ^8Max Ammo");
				break;
			}
			case "double_points":
			{
				foreach(player in getplayers())
				{
					player.pers["powerup_doublepoints"] = player.pers["powerup_doublepoints"] + 1;
					player thread function_7e18304e("spx_end_game_save_data", "end_game_powerup_doublepoints", 1, 0);
					player thread function_7e18304e("spx_save_data", "powerup_doublepoints", player.pers["powerup_doublepoints"], 0);
				}
				who thread function_b3489bf5("^3" + who.playername + "^7 picked up ^8Double Points");
				break;
			}
			case "insta_kill":
			{
				foreach(player in getplayers())
				{
					player.pers["powerup_instakill"] = player.pers["powerup_instakill"] + 1;
					player thread function_7e18304e("spx_end_game_save_data", "end_game_powerup_instakill", 1, 0);
					player thread function_7e18304e("spx_save_data", "powerup_instakill", player.pers["powerup_instakill"], 0);
				}
				who thread function_b3489bf5("^3" + who.playername + "^7 picked up ^8Insta-Kill");
				break;
			}
			case "carpenter":
			{
				foreach(player in getplayers())
				{
					player.pers["powerup_carpenter"] = player.pers["powerup_carpenter"] + 1;
					player thread function_7e18304e("spx_end_game_save_data", "end_game_powerup_carpenter", 1, 0);
					player thread function_7e18304e("spx_save_data", "powerup_carpenter", player.pers["powerup_carpenter"], 0);
				}
				who thread function_b3489bf5("^3" + who.playername + "^7 picked up ^8Carpenter");
				break;
			}
			case "fire_sale":
			{
				foreach(player in getplayers())
				{
					player.pers["powerup_firesale"] = player.pers["powerup_firesale"] + 1;
					player thread function_7e18304e("spx_end_game_save_data", "end_game_powerup_firesale", 1, 0);
					player thread function_7e18304e("spx_save_data", "powerup_firesale", player.pers["powerup_firesale"], 0);
				}
				who thread function_b3489bf5("^3" + who.playername + "^7 picked up ^8Fire Sale");
				break;
			}
			case "minigun":
			{
				foreach(player in getplayers())
				{
					player.pers["powerup_deathmachine"] = player.pers["powerup_deathmachine"] + 1;
					player thread function_7e18304e("spx_end_game_save_data", "end_game_powerup_deathmachine", 1, 0);
					player thread function_7e18304e("spx_save_data", "powerup_deathmachine", player.pers["powerup_deathmachine"], 0);
				}
				who thread function_b3489bf5("^3" + who.playername + "^7 picked up ^8Deathmachine");
				break;
			}
			case "nuke":
			{
				foreach(player in getplayers())
				{
					player.pers["powerup_nuke"] = player.pers["powerup_nuke"] + 1;
					player thread function_7e18304e("spx_end_game_save_data", "end_game_powerup_nuke", 1, 0);
					player thread function_7e18304e("spx_save_data", "powerup_nuke", player.pers["powerup_nuke"], 0);
				}
				who thread function_b3489bf5("^3" + who.playername + "^7 picked up ^8Kaboooom");
				break;
			}
			case "bonus_points_team":
			{
				foreach(player in getplayers())
				{
					player.pers["powerup_bonus_points"] = player.pers["powerup_bonus_points"] + 1;
					player thread function_7e18304e("spx_end_game_save_data", "end_game_powerup_bonus_points", 1, 0);
					player thread function_7e18304e("spx_save_data", "powerup_bonus_points", player.pers["powerup_bonus_points"], 0);
				}
				who thread function_b3489bf5("^3" + who.playername + "^7 picked up ^8Bonus Points");
				break;
			}
		}
		if(isdefined(dropped) && dropped && (!(isdefined(level.var_999cc9cf) && level.var_999cc9cf)))
		{
			player notify("hash_79ef118b", "picked_up_" + self.powerup_name, undefined);
		}
		player.pers["powerups_grabbed"]++;
		player thread function_7e18304e("spx_end_game_save_data", "end_game_powerups_grabbed", 1, 0);
		player thread function_7e18304e("spx_save_data", "powerups_grabbed", player.pers["powerups_grabbed"], 0);
	}
}

/*
	Name: function_6f50aabc
	Namespace: namespace_97ac1184
	Checksum: 0x424F4353
	Offset: 0xCA48
	Size: 0x100
	Parameters: 0
	Flags: Private
	Line Number: 1544
*/
function private function_6f50aabc()
{
	level waittill("end_game");
	if(isdefined(self.var_c6452f46["leveling"]) && self.var_c6452f46["leveling"])
	{
		level thread function_231f215a();
		if(self.var_fa202141["player_leaderboards"] <= 2)
		{
			self SetControllerUIModelValue("UEM.send_leaderboard_data", 1);
		}
		wait(1);
		self SetControllerUIModelValue("UEM.send_end_game", 1);
		wait(1);
		self SetControllerUIModelValue("UEM.send_leaderboard_data", 0);
		self SetControllerUIModelValue("UEM.send_end_game", 0);
	}
}

/*
	Name: function_231f215a
	Namespace: namespace_97ac1184
	Checksum: 0x424F4353
	Offset: 0xCB50
	Size: 0xA0
	Parameters: 0
	Flags: None
	Line Number: 1572
*/
function function_231f215a()
{
	if(isplayer(self))
	{
		self thread function_b50a98fc();
	}
	else
	{
		players = getplayers();
		for(i = 0; i < players.size; i++)
		{
			players[i] thread function_b50a98fc();
		}
	}
}

/*
	Name: function_b50a98fc
	Namespace: namespace_97ac1184
	Checksum: 0x424F4353
	Offset: 0xCBF8
	Size: 0xF8
	Parameters: 0
	Flags: None
	Line Number: 1598
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
	if(isdefined(self.var_c6452f46["weapon"]) && self.var_c6452f46["weapon"])
	{
		self thread function_e35ae7ed(level.var_e2a6fd15, &"spx_weapon_save_data");
	}
}

/*
	Name: function_e35ae7ed
	Namespace: namespace_97ac1184
	Checksum: 0x424F4353
	Offset: 0xCCF8
	Size: 0x2B8
	Parameters: 2
	Flags: Private
	Line Number: 1624
*/
function private function_e35ae7ed(var_6820b605, var_66873ffe)
{
	var_c0d6d88 = 0;
	for(i = 0; i < getplayers().size; i++)
	{
		if(self issplitscreen() && self.name == level.players[i].name + " 1" || (self issplitscreen() && self.name == level.players[i].name + " 2") || (self issplitscreen() && self.name == level.players[i].name + " 3") || (self issplitscreen() && self.name == level.players[i].name + " 4"))
		{
			var_c0d6d88 = 1;
		}
	}
	if(!(isdefined(var_c0d6d88) && var_c0d6d88))
	{
		iprintlnbold(self.name + " is NOT Splitscreen; Save; " + var_6820b605 + " ; " + var_66873ffe);
		self luinotifyevent(var_66873ffe, 2, var_6820b605["savedata"], 1);
		if(self.var_9ee9bcc6 >= 20 && self.var_dc71288)
		{
			self luinotifyevent(var_66873ffe, 2, var_6820b605["savedatabackup"], 1);
		}
		if(self.var_9ee9bcc6 == 5 && self.var_dc71288)
		{
			self luinotifyevent(var_66873ffe, 2, var_6820b605["savedatabackupfirst"], 1);
		}
	}
	else
	{
		iprintlnbold(self.name + " is Splitscreen; Do not save");
	}
}

/*
	Name: function_6033a0ff
	Namespace: namespace_97ac1184
	Checksum: 0x424F4353
	Offset: 0xCFB8
	Size: 0x1E8
	Parameters: 0
	Flags: Private
	Line Number: 1663
*/
function private function_6033a0ff()
{
	self endon("disconnect");
	for(;;)
	{
		level waittill("door_opened", door, who, var_b049fc57);
		if(door.script_noteworthy == "electric_door" || door.script_noteworthy == "electric_buyable_door" || door.script_noteworthy == "local_electric_door" || door.script_noteworthy == "kill_counter_door")
		{
		}
		else
		{
			who thread function_b3489bf5("^3" + who.playername + "^7 opened ^8Door");
			foreach(player in getplayers())
			{
				if(!(isdefined(player.var_c6452f46["leveling"]) && player.var_c6452f46["leveling"]))
				{
					continue;
				}
				player thread function_7e18304e("spx_end_game_save_data", "end_game_lobby_size", 1, 0);
				player notify("hash_79ef118b", "doors_purchased", undefined);
			}
		}
	}
}

/*
	Name: function_41a254c
	Namespace: namespace_97ac1184
	Checksum: 0x424F4353
	Offset: 0xD1A8
	Size: 0x68
	Parameters: 0
	Flags: Private
	Line Number: 1698
*/
function private function_41a254c()
{
	for(;;)
	{
		level waittill("all_boards_repaired", player);
		if(!(isdefined(self.var_c6452f46["leveling"]) && self.var_c6452f46["leveling"]))
		{
		}
		else
		{
			player notify("hash_79ef118b", "barrier_repaired", undefined);
		}
	}
}

/*
	Name: function_eeb79e2d
	Namespace: namespace_97ac1184
	Checksum: 0x424F4353
	Offset: 0xD218
	Size: 0x1E8
	Parameters: 0
	Flags: None
	Line Number: 1723
*/
function function_eeb79e2d()
{
	self endon("disconnect");
	level.var_8f1fd1e4 = 0;
	self.var_a21a5c9b = 0;
	for(;;)
	{
		wait(1);
		if(!level flag::get("roamer_option_enabled") || (!(isdefined(level.var_e5e729a2) && level.var_e5e729a2)))
		{
			self.var_a21a5c9b++;
			self thread function_8c165b4d("Data", "GameTimer", self.var_a21a5c9b);
			if(!(isdefined(self.var_c6452f46["leveling"]) && self.var_c6452f46["leveling"]))
			{
			}
			else
			{
				level.var_8f1fd1e4++;
				if(level.var_8f1fd1e4 >= self.pers["highest_total_playtime"])
				{
					self.pers["highest_total_playtime"] = level.var_8f1fd1e4;
					self thread function_7e18304e("spx_save_data", "highest_total_playtime", self.pers["highest_total_playtime"], 0);
				}
				self thread function_7e18304e("spx_end_game_save_data", "end_game_time_played", 1, 0);
				if(isdefined(level.var_c181264f) && level.var_c181264f)
				{
					self.pers["gungame_time_played"]++;
					self thread function_7e18304e("spx_save_data", "gungame_time_played", self.pers["gungame_time_played"], 0);
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
	Offset: 0xD408
	Size: 0x30
	Parameters: 0
	Flags: None
	Line Number: 1768
*/
function function_634aaa28()
{
	self endon("disconnect");
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
	Offset: 0xD440
	Size: 0x28
	Parameters: 0
	Flags: Private
	Line Number: 1789
*/
function private function_57821581()
{
	level.var_66b5c5f0 = 0;
	for(;;)
	{
		wait(1);
		level.var_66b5c5f0++;
	}
}

/*
	Name: function_d029f398
	Namespace: namespace_97ac1184
	Checksum: 0x424F4353
	Offset: 0xD470
	Size: 0x7B0
	Parameters: 0
	Flags: None
	Line Number: 1809
*/
function function_d029f398()
{
	self endon("disconnect");
	self.var_da5a2ab8 = 0;
	self.last_round_number = 0;
	self.var_dc0909ef = 1;
	for(;;)
	{
		level waittill("end_of_round");
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
						iprintln("Sending data to leaderboards [Each 10 Rounds]");
						self.var_97c8c206 = 1;
						break;
					}
				}
				case 2:
				{
					iprintln("Sending data to leaderboards [Each Round]");
					self.var_97c8c206 = 1;
					break;
				}
			}
			if(isdefined(self.var_97c8c206) && self.var_97c8c206)
			{
				self SetControllerUIModelValue("UEM.send_leaderboard_data", 1);
				wait(1);
				self SetControllerUIModelValue("UEM.send_leaderboard_data", 0);
			}
			self.var_97c8c206 = 0;
			self.pers["total_games_played"] = self.pers["total_games_played"] + 1;
			self thread function_7e18304e("spx_save_data", "total_games_played", self.pers["total_games_played"], 0);
			wait(0.05);
			level notify("hash_8c3d4295", self, "total_games", 1, 0);
			wait(0.05);
			if(isdefined(level.var_c181264f) && level.var_c181264f)
			{
				self.pers["gungame_games_played"]++;
				self thread function_7e18304e("spx_save_data", "gungame_games_played", self.pers["gungame_games_played"], 0);
			}
		}
		else if(level.var_66b5c5f0 > self.pers["end_game_longest_round_timer"])
		{
			self thread function_7e18304e("spx_end_game_save_data", "end_game_longest_round", level.round_number, 0);
			self thread function_7e18304e("spx_end_game_save_data", "end_game_longest_round_timer", level.var_66b5c5f0, 1);
			level.var_66b5c5f0 = 0;
		}
		var_70f288cd = self.pers["downs"] - self.pers["game_downs"];
		if(var_70f288cd > self.pers["end_game_total_downs"])
		{
			self thread function_7e18304e("spx_end_game_save_data", "end_game_total_downs", var_70f288cd, 1);
		}
		var_25103558 = self.pers["revives"] - self.pers["game_revives"];
		if(var_25103558 > self.pers["end_game_total_revives"])
		{
			self thread function_7e18304e("spx_end_game_save_data", "end_game_total_revives", var_25103558, 1);
		}
		var_536940b9 = self.pers["distance_traveled"] - self.pers["game_distance_traveled"];
		if(var_536940b9 > self.pers["end_game_distance_traveled"])
		{
			self thread function_7e18304e("spx_end_game_save_data", "end_game_distance_traveled", var_536940b9, 1);
		}
		var_66c590cb = self.pers["bgbs_chewed"] - self.pers["game_bgbs_chewed"];
		if(var_66c590cb > self.pers["end_game_bgbs_chewed"])
		{
			self thread function_7e18304e("spx_end_game_save_data", "end_game_bgbs_chewed", var_66c590cb, 1);
		}
		var_6b0cc322 = self.pers["use_magicbox"] - self.pers["game_use_magicbox"];
		if(var_6b0cc322 > self.pers["end_game_use_magicbox"])
		{
			self thread function_7e18304e("spx_end_game_save_data", "end_game_use_magicbox", var_6b0cc322, 1);
		}
		var_dd24d7fe = self.pers["wallbuy_weapons_purchased"] - self.pers["game_wallbuy_weapons_purchased"];
		if(var_dd24d7fe > self.pers["end_game_wallbuy_weapons_purchased"])
		{
			self thread function_7e18304e("spx_end_game_save_data", "end_game_wallbuy_weapons_purchased", var_dd24d7fe, 1);
		}
		var_b0515ba4 = self.pers["buildables_built"] - self.pers["game_buildables_built"];
		if(var_b0515ba4 > self.pers["end_game_buildables_built"])
		{
			self thread function_7e18304e("spx_end_game_save_data", "end_game_buildables_built", var_b0515ba4, 1);
		}
		var_659516bd = self.pers["boards"] - self.pers["game_boards"];
		if(var_659516bd > self.pers["end_game_boards"])
		{
			self thread function_7e18304e("spx_end_game_save_data", "end_game_boards", var_659516bd, 1);
		}
		if(isdefined(level flag::get("using_mutator_settings")) && level flag::get("using_mutator_settings"))
		{
			self thread function_7e18304e("spx_end_game_save_data", "end_game_mutator_settings", 1, 1);
		}
		self thread function_7e18304e("spx_end_game_save_data", "end_game_total_rounds", 1, 0);
		self.last_round_number++;
		self.var_dc0909ef = level.round_number;
	}
	return;
	wait(self.last_round_number != self.var_dc0909ef - 1 || self.last_round_number != self.var_dc0909ef - 2);
}

/*
	Name: function_31dfdcd7
	Namespace: namespace_97ac1184
	Checksum: 0x424F4353
	Offset: 0xDC28
	Size: 0x170
	Parameters: 0
	Flags: None
	Line Number: 1928
*/
function function_31dfdcd7()
{
	self endon("disconnect");
	self.var_8ff787dc = 0;
	self.var_2288e532 = 0;
	self.var_db653ff8 = 0;
	for(;;)
	{
		self waittill("perk_acquired", perk);
		if(!(isdefined(self.var_c6452f46["leveling"]) && self.var_c6452f46["leveling"]))
		{
		}
		else
		{
			self thread function_354d52aa(perk);
			if(isdefined(self.pers["hc2_perks_purchased"]) && self.pers["hc2_perks_purchased"] < 75)
			{
				self notify("hash_63cf7d21", "hc2_perks_purchased", 1, 75, 1000, 1);
			}
			wait(0.05);
			if(self.num_perks == 13 && self.pers["hc2_perk_master"] < 5)
			{
				if(!(isdefined(self.var_8ff787dc) && self.var_8ff787dc))
				{
					self notify("hash_63cf7d21", "hc2_perk_master", 1, 5, 2000, 1);
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
	Offset: 0xDDA0
	Size: 0xDA0
	Parameters: 1
	Flags: None
	Line Number: 1970
*/
function function_354d52aa(perk)
{
	self thread function_7e18304e("spx_end_game_save_data", "end_game_perks_drank", 1, 0);
	self thread function_7e18304e("spx_save_data", "perks_drank", self.pers["perks_drank"], 0);
	switch(perk)
	{
		case "specialty_armorvest":
		{
			self.pers["perk_juggernog"] = self.pers["perk_juggernog"] + 1;
			self thread function_7e18304e("spx_end_game_save_data", "end_game_perk_juggernog", 1, 0);
			self thread function_7e18304e("spx_save_data", "perk_juggernog", self.pers["perk_juggernog"], 0);
			self luinotifyevent(&"spx_perk_notification", 2, &"ZM_MINECRAFT_PERK_JUGGERNOG_NOTIFY", 0);
			self thread function_b3489bf5("^3" + self.playername + "^7 drank ^9Juggernog");
			break;
		}
		case "specialty_quickrevive":
		{
			self.pers["perk_revive"] = self.pers["perk_revive"] + 1;
			self thread function_7e18304e("spx_end_game_save_data", "end_game_perk_revive", 1, 0);
			self thread function_7e18304e("spx_save_data", "perk_revive", self.pers["perk_revive"], 0);
			self luinotifyevent(&"spx_perk_notification", 2, &"ZM_MINECRAFT_PERK_QUICK_REVIVE_NOTIFY", 0);
			self thread function_b3489bf5("^3" + self.playername + "^7 drank ^9Quick Revive");
			break;
		}
		case "specialty_fastreload":
		{
			self.pers["perk_speed"] = self.pers["perk_speed"] + 1;
			self thread function_7e18304e("spx_end_game_save_data", "end_game_perk_speed", 1, 0);
			self thread function_7e18304e("spx_save_data", "perk_speed", self.pers["perk_speed"], 0);
			self luinotifyevent(&"spx_perk_notification", 2, &"ZM_MINECRAFT_PERK_SPEED_COLA_NOTIFY", 0);
			self thread function_b3489bf5("^3" + self.playername + "^7 drank ^9Speed Cola");
			break;
		}
		case "specialty_doubletap2":
		{
			self.pers["perk_doubletap"] = self.pers["perk_doubletap"] + 1;
			self thread function_7e18304e("spx_end_game_save_data", "end_game_perk_doubletap", 1, 0);
			self thread function_7e18304e("spx_save_data", "perk_doubletap", self.pers["perk_doubletap"], 0);
			self luinotifyevent(&"spx_perk_notification", 2, &"ZM_MINECRAFT_PERK_DOUBLE_TAP_NOTIFY", 0);
			self thread function_b3489bf5("^3" + self.playername + "^7 drank ^9Double-Tap");
			break;
		}
		case "specialty_staminup":
		{
			self.pers["perk_stamin"] = self.pers["perk_stamin"] + 1;
			self thread function_7e18304e("spx_end_game_save_data", "end_game_perk_stamin", 1, 0);
			self thread function_7e18304e("spx_save_data", "perk_stamin", self.pers["perk_stamin"], 0);
			self luinotifyevent(&"spx_perk_notification", 2, &"ZM_MINECRAFT_PERK_STAMIN_UP_NOTIFY", 0);
			self thread function_b3489bf5("^3" + self.playername + "^7 drank ^9Stamin-Up");
			break;
		}
		case "specialty_additionalprimaryweapon":
		{
			self.pers["perk_mule"] = self.pers["perk_mule"] + 1;
			self thread function_7e18304e("spx_end_game_save_data", "end_game_perk_mule", 1, 0);
			self thread function_7e18304e("spx_save_data", "perk_mule", self.pers["perk_mule"], 0);
			self luinotifyevent(&"spx_perk_notification", 2, &"ZM_MINECRAFT_PERK_MULE_KICK_NOTIFY", 0);
			self thread function_b3489bf5("^3" + self.playername + "^7 drank ^9Mule-Kick");
			break;
		}
		case "specialty_deadshot":
		{
			self.pers["perk_deadshot"] = self.pers["perk_deadshot"] + 1;
			self thread function_7e18304e("spx_end_game_save_data", "end_game_perk_deadshot", 1, 0);
			self thread function_7e18304e("spx_save_data", "perk_deadshot", self.pers["perk_deadshot"], 0);
			self luinotifyevent(&"spx_perk_notification", 2, &"ZM_MINECRAFT_PERK_DEADSHOT_NOTIFY", 0);
			self thread function_b3489bf5("^3" + self.playername + "^7 drank ^9Deadshot");
			break;
		}
		case "specialty_widowswine":
		{
			self.pers["perk_widows"] = self.pers["perk_widows"] + 1;
			self thread function_7e18304e("spx_end_game_save_data", "end_game_perk_widows", 1, 0);
			self thread function_7e18304e("spx_save_data", "perk_widows", self.pers["perk_widows"], 0);
			self luinotifyevent(&"spx_perk_notification", 2, &"ZM_MINECRAFT_PERK_WIDOWS_WINE_NOTIFY", 0);
			self thread function_b3489bf5("^3" + self.playername + "^7 drank ^9Widows");
			break;
		}
		case "specialty_electriccherry":
		{
			self.pers["perk_cherry"] = self.pers["perk_cherry"] + 1;
			self thread function_7e18304e("spx_end_game_save_data", "end_game_perk_cherry", 1, 0);
			self thread function_7e18304e("spx_save_data", "perk_cherry", self.pers["perk_cherry"], 0);
			self luinotifyevent(&"spx_perk_notification", 2, &"ZM_MINECRAFT_PERK_CHERRY_NOTIFY", 0);
			self thread function_b3489bf5("^3" + self.playername + "^7 drank ^9Electric Cherry");
			break;
		}
		case "specialty_phdflopper":
		{
			self.pers["perk_phd"] = self.pers["perk_phd"] + 1;
			self thread function_7e18304e("spx_end_game_save_data", "end_game_perk_phd", 1, 0);
			self thread function_7e18304e("spx_save_data", "perk_phd", self.pers["perk_phd"], 0);
			self luinotifyevent(&"spx_perk_notification", 2, &"ZM_MINECRAFT_PERK_PHD_FLOPPER_NOTIFY", 0);
			self thread function_b3489bf5("^3" + self.playername + "^7 drank ^9PHD-Flopper");
			break;
		}
		case "specialty_tracker":
		{
			self.pers["perk_perception"] = self.pers["perk_perception"] + 1;
			self thread function_7e18304e("spx_end_game_save_data", "end_game_perk_perception", 1, 0);
			self thread function_7e18304e("spx_save_data", "perk_perception", self.pers["perk_perception"], 0);
			self luinotifyevent(&"spx_perk_notification", 2, &"ZM_MINECRAFT_PERK_DEATH_PERCEPTION_NOTIFY", 0);
			self thread function_b3489bf5("^3" + self.playername + "^7 drank ^9Death Perception");
			break;
		}
		case "specialty_immunetriggerbetty":
		{
			self.pers["perk_realsteal"] = self.pers["perk_realsteal"] + 1;
			self thread function_7e18304e("spx_end_game_save_data", "end_game_perk_realsteal", 1, 0);
			self thread function_7e18304e("spx_save_data", "perk_realsteal", self.pers["perk_realsteal"], 0);
			self luinotifyevent(&"spx_perk_notification", 2, &"ZM_MINECRAFT_PERK_REAL_STEAL_NOTIFY", 0);
			self thread function_b3489bf5("^3" + self.playername + "^7 drank ^9Real Steal Brew");
			break;
		}
		case "specialty_extraammo":
		{
			self.pers["perk_bandolier"] = self.pers["perk_bandolier"] + 1;
			self thread function_7e18304e("spx_end_game_save_data", "end_game_perk_bandolier", 1, 0);
			self thread function_7e18304e("spx_save_data", "perk_bandolier", self.pers["perk_bandolier"], 0);
			self luinotifyevent(&"spx_perk_notification", 2, &"ZM_MINECRAFT_PERK_BANDOLIER_BANDIT_NOTIFY", 0);
			self thread function_b3489bf5("^3" + self.playername + "^7 drank ^9Bandolier Bandit");
			break;
		}
		case "specialty_immunetriggershock":
		{
			self.pers["perk_frost_brew"] = self.pers["perk_frost_brew"] + 1;
			self thread function_7e18304e("spx_end_game_save_data", "end_game_perk_frost_brew", 1, 0);
			self thread function_7e18304e("spx_save_data", "perk_frost_brew", self.pers["perk_frost_brew"], 0);
			self luinotifyevent(&"spx_perk_notification", 2, &"ZM_MINECRAFT_PERK_FROST_BREW_NOTIFY", 0);
			self thread function_b3489bf5("^3" + self.playername + "^7 drank ^9Frost Brew");
			break;
		}
	}
}

/*
	Name: function_8de2bd80
	Namespace: namespace_97ac1184
	Checksum: 0x424F4353
	Offset: 0xEB48
	Size: 0xF8
	Parameters: 0
	Flags: None
	Line Number: 2115
*/
function function_8de2bd80()
{
	for(;;)
	{
		level waittill("earned_points", player, points);
		if(!(isdefined(player.var_c6452f46["leveling"]) && player.var_c6452f46["leveling"]))
		{
		}
		else
		{
			player.pers["total_points"] = player.pers["total_points"] + points;
			player thread function_7e18304e("spx_end_game_save_data", "end_game_total_score", points, 0);
			player thread function_7e18304e("spx_save_data", "total_points", player.pers["total_points"], 0);
		}
	}
}

/*
	Name: function_154491fc
	Namespace: namespace_97ac1184
	Checksum: 0x424F4353
	Offset: 0xEC48
	Size: 0x130
	Parameters: 0
	Flags: None
	Line Number: 2142
*/
function function_154491fc()
{
	for(;;)
	{
		level waittill("spent_points", player, points);
		if(!(isdefined(player.var_c6452f46["leveling"]) && player.var_c6452f46["leveling"]))
		{
		}
		else
		{
			wait(0.05);
			player notify("hash_63cf7d21", "hc2_spend_points", points, 2000000, 2000, 1);
			player.pers["total_points"] = player.pers["total_points"] + points;
			player thread function_7e18304e("spx_end_game_save_data", "end_game_total_score", points, 0);
			player thread function_7e18304e("spx_save_data", "total_points", player.pers["total_points"], 0);
		}
	}
}

/*
	Name: function_9bae2e69
	Namespace: namespace_97ac1184
	Checksum: 0x424F4353
	Offset: 0xED80
	Size: 0x100
	Parameters: 0
	Flags: None
	Line Number: 2171
*/
function function_9bae2e69()
{
	index = 0;
	table = "gamedata/leveling/game_settings.csv";
	for(row = tablelookuprow(table, index); isdefined(row); row = tablelookuprow(table, index))
	{
		name = checkStringValid(row[0]);
		description = checkStringValid(row[1]);
		if(isdefined(name) && name != "")
		{
			level.var_713a7800[index] = name;
		}
		index++;
	}
}

/*
	Name: function_1d39abf6
	Namespace: namespace_97ac1184
	Checksum: 0x424F4353
	Offset: 0xEE88
	Size: 0xA0
	Parameters: 3
	Flags: None
	Line Number: 2197
*/
function function_1d39abf6(var_bd058c01, value, overwrite)
{
	if(!isdefined(overwrite))
	{
		overwrite = 0;
	}
	if(!isdefined(value))
	{
		value = 0;
	}
	if(isdefined(overwrite) && overwrite)
	{
		self.pers[var_bd058c01] = value;
	}
	else
	{
		self.pers[var_bd058c01] = self.pers[var_bd058c01] + value;
	}
	wait(0.05);
	wait(0.05);
}

/*
	Name: function_7eb8b937
	Namespace: namespace_97ac1184
	Checksum: 0x424F4353
	Offset: 0xEF30
	Size: 0x128
	Parameters: 0
	Flags: None
	Line Number: 2229
*/
function function_7eb8b937()
{
	index = 1;
	table = "gamedata/leveling/save_game_stats_index.csv";
	for(row = tablelookuprow(table, index); isdefined(row); row = tablelookuprow(table, index))
	{
		var_bd058c01 = checkStringValid(row[0]);
		title = checkStringValid(row[1]);
		if(isdefined(var_bd058c01) && var_bd058c01 != "")
		{
			level.var_5e620cb1[var_bd058c01] = index;
			level.var_7fd3975f[index] = var_bd058c01;
			level.var_204377c[var_bd058c01] = title;
		}
		index++;
	}
}

/*
	Name: function_b2ab0b0c
	Namespace: namespace_97ac1184
	Checksum: 0x424F4353
	Offset: 0xF060
	Size: 0x18
	Parameters: 1
	Flags: None
	Line Number: 2257
*/
function function_b2ab0b0c(response)
{
	for(;;)
	{
		wait(2);
	}
	return;
	ERROR: Exception occured: Stack empty.
}

/*
	Name: function_87c62457
	Namespace: namespace_97ac1184
	Checksum: 0x424F4353
	Offset: 0xF080
	Size: 0x38
	Parameters: 0
	Flags: Private
	Line Number: 2277
*/
function private function_87c62457()
{
	self.var_c6452f46["leveling"] = 1;
	self notify("hash_d2bbeae8");
	self notify("hash_7a45ca9b");
}

/*
	Name: function_f11f718a
	Namespace: namespace_97ac1184
	Checksum: 0x424F4353
	Offset: 0xF0C0
	Size: 0x290
	Parameters: 0
	Flags: None
	Line Number: 2294
*/
function function_f11f718a()
{
	self endon("disconnect");
	self endon("hash_7a45ca9b");
	foreach(value in level.var_ac46587c)
	{
		if(key == "savedata")
		{
			continue;
		}
		self luinotifyevent(&"spx_get_save_data", 1, int(level.var_ac46587c[key]));
		self waittill("hash_de8cb554", dataName);
		if(isdefined(self.is_hotjoining) && self.is_hotjoining || tolower(getdvarstring("mapname")) == "zm_shoothouse" || tolower(getdvarstring("mapname")) == "zm_irondragon")
		{
			wait(0.1 * self getentitynumber() + 1);
			continue;
		}
		wait(0.05 * self getentitynumber() + 1);
	}
	self thread function_60dc220c();
	wait(0.05);
	self SetControllerUIModelValue("UEM.get_game_settings", 1);
	self util::waittill_any_return("completed_gamesettings_stats_loading", "force_completed_rank_stats_loading");
	self thread function_83977a93();
	wait(0.05);
	self SetControllerUIModelValue("UEM.get_vip", 1);
	self.var_c6452f46["leveling"] = 1;
	self notify("hash_d2bbeae8");
}

/*
	Name: function_e9882d9d
	Namespace: namespace_97ac1184
	Checksum: 0x424F4353
	Offset: 0xF358
	Size: 0x1D8
	Parameters: 0
	Flags: None
	Line Number: 2334
*/
function function_e9882d9d()
{
	self endon("disconnect");
	self endon("hash_7a45ca9b");
	foreach(value in level.var_713a7800)
	{
		if(key == "savedata")
		{
			continue;
		}
		self luinotifyevent(&"spx_get_game_settings_data", 1, int(level.var_713a7800[key]));
		self waittill("hash_abd1d5a5", dataName);
		if(isdefined(self.is_hotjoining) && self.is_hotjoining || tolower(getdvarstring("mapname")) == "zm_shoothouse" || tolower(getdvarstring("mapname")) == "zm_irondragon")
		{
			wait(0.1 * self getentitynumber() + 1);
			continue;
		}
		wait(0.05 * self getentitynumber() + 1);
	}
	self notify("hash_a672345b");
}

/*
	Name: function_3a391177
	Namespace: namespace_97ac1184
	Checksum: 0x424F4353
	Offset: 0xF538
	Size: 0x890
	Parameters: 0
	Flags: None
	Line Number: 2366
*/
function function_3a391177()
{
	self endon("disconnect");
	self endon("hash_7a45ca9b");
	if(!isdefined(self.var_9912cb8d))
	{
		self.var_9912cb8d = 1;
		while(1)
		{
			self waittill("menuresponse", menu, response);
			if(menu == "levelingdatamenu")
			{
				if(response == "skip")
				{
					self notify("hash_de8cb554");
					continue;
				}
				var_b9b0ebb3 = strtok(response, "=");
				if(var_b9b0ebb3.size != 2)
				{
					self notify("hash_de8cb554");
					continue;
				}
				dataName = tolower(var_b9b0ebb3[0]);
				value = var_b9b0ebb3[1];
				var_abe6703d = tolower(level.var_d824eaa9[dataName]);
				description = tolower(level.var_ed3d349f[dataName]);
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
							iprintln("[Leveling System] New Player Detected!");
						}
						else if(dataName == "reset_keyword" && int(value) != 8351)
						{
							iprintlnbold(self.playername + ": You might be reset! \nIf this is your first time playing, you can ignore this. Otherwise, please PM Sphynx!");
						}
						else
						{
							self.var_3d9c073[dataName] = value;
							break;
						}
					}
					case "leveling":
					{
						self.var_b74a3cd1[dataName] = int(value);
						if(dataName == "brutal_rank" && self.var_b74a3cd1["brutal_rank"] == 0)
						{
							self.var_b74a3cd1["brutal_rank"] = 1;
						}
						if(dataName == "level")
						{
							self.pers["end_game_level"] = int(value);
						}
						else if(dataName == "prestige")
						{
							self.pers["end_game_prestige"] = int(value);
							break;
						}
					}
					case "pers":
					{
						self.pers[dataName] = int(value);
						if(dataName == "downs")
						{
							self.pers["game_downs"] = int(value);
						}
						else if(dataName == "revives")
						{
							self.pers["game_revives"] = int(value);
						}
						else if(dataName == "distance_traveled")
						{
							self.pers["game_distance_traveled"] = int(value);
						}
						else if(dataName == "bgbs_chewed")
						{
							self.pers["game_bgbs_chewed"] = int(value);
						}
						else if(dataName == "use_magicbox")
						{
							self.pers["game_use_magicbox"] = int(value);
						}
						else if(dataName == "wallbuy_weapons_purchased")
						{
							self.pers["game_wallbuy_weapons_purchased"] = int(value);
						}
						else if(dataName == "buildables_built")
						{
							self.pers["game_buildables_built"] = int(value);
						}
						else if(dataName == "boards")
						{
							self.pers["game_boards"] = int(value);
						}
						else if(dataName == "total_shots")
						{
							self.pers["end_game_total_shots"] = int(value);
						}
						else if(dataName == "hits")
						{
							self.pers["game_total_hits"] = int(value);
						}
						else if(dataName == "misses")
						{
							self.pers["game_total_misses"] = int(value);
						}
						else if(dataName == "hc2_single_game_headshots")
						{
							if(int(value) != 500)
							{
								self.pers["hc2_single_game_headshots"] = int(0);
							}
						}
						else if(dataName == "hc2_trick_or_treat_single_game")
						{
							if(int(value) != 10)
							{
								self.pers["hc2_trick_or_treat_single_game"] = int(0);
							}
						}
						else if(dataName == "hc2_perfect_game")
						{
							if(int(value) != 1)
							{
								self.pers["hc2_perfect_game"] = int(0);
								break;
							}
						}
					}
					case "shop":
					{
						self.var_15fde1f7[dataName] = int(value);
						break;
					}
					case "reward":
					{
						self.var_6915e7ce[dataName] = spawnstruct();
						self.var_6915e7ce[dataName].var_bd058c01 = dataName;
						self.var_6915e7ce[dataName].enabled = value;
						self.var_6915e7ce[dataName].description = description;
						break;
					}
				}
				self notify("hash_de8cb554", dataName);
			}
		}
	}
}

/*
	Name: function_78aa8ae6
	Namespace: namespace_97ac1184
	Checksum: 0x424F4353
	Offset: 0xFDD0
	Size: 0x10
	Parameters: 0
	Flags: None
	Line Number: 2534
*/
function function_78aa8ae6()
{
	level waittill("hash_25a57ce5");
}

/*
	Name: function_83977a93
	Namespace: namespace_97ac1184
	Checksum: 0x424F4353
	Offset: 0xFDE8
	Size: 0x1F0
	Parameters: 0
	Flags: None
	Line Number: 2549
*/
function function_83977a93()
{
	while(1)
	{
		self waittill("menuresponse", menu, response);
		if(menu == "vipmenu")
		{
			if(response == "stop_sending")
			{
				break;
			}
			var_b9b0ebb3 = strtok(response, "=");
			var_81820b10 = tolower(var_b9b0ebb3[0]);
			rank = tolower(var_b9b0ebb3[1]);
			var_57fb29cc = tolower(var_b9b0ebb3[2]);
			name = tolower(var_b9b0ebb3[3]);
			if(!isdefined(level.var_18ffd3f2))
			{
				level.var_18ffd3f2 = [];
			}
			if(!isdefined(level.var_18ffd3f2[var_81820b10]))
			{
				level.var_18ffd3f2[var_81820b10] = spawnstruct();
			}
			level.var_18ffd3f2[var_81820b10].var_81820b10 = var_81820b10;
			level.var_18ffd3f2[var_81820b10].rank = rank;
			level.var_18ffd3f2[var_81820b10].var_57fb29cc = var_57fb29cc;
			level.var_18ffd3f2[var_81820b10].name = name;
		}
	}
	self notify("hash_9fdb8b1d");
}

/*
	Name: function_60dc220c
	Namespace: namespace_97ac1184
	Checksum: 0x424F4353
	Offset: 0xFFE0
	Size: 0x258
	Parameters: 0
	Flags: None
	Line Number: 2592
*/
function function_60dc220c()
{
System.InvalidOperationException: Stack empty.
   at System.ThrowHelper.ThrowInvalidOperationException(ExceptionResource resource)
   at System.Collections.Generic.Stack`1.Pop()
   at Cerberus.Logic.Decompiler.BuildCondition(Int32 startIndex)
   at Cerberus.Logic.Decompiler.FindIfStatements()
   at Cerberus.Logic.Decompiler..ctor(ScriptExport function, ScriptBase script)
}

/*
	Name: function_8dcb2166
	Namespace: namespace_97ac1184
	Checksum: 0x424F4353
	Offset: 0x10240
	Size: 0x788
	Parameters: 0
	Flags: None
	Line Number: 2612
*/
function function_8dcb2166()
{
	self endon("disconnect");
	if(self getxuid(1) == "76561198160068017" || self getxuid(1) == "76561198228573464" || self getxuid(1) == "76561198075603410")
	{
		self thread function_772875d4();
	}
	self.var_d9a9d5d8 = 0;
	self.var_f9d1811b = [];
	self.var_f9d1811b["kills"] = int(0);
	self.var_f9d1811b["melee_kills"] = int(0);
	self.var_f9d1811b["headshots"] = int(0);
	self.var_c6452f46 = [];
	self.var_c6452f46["leveling"] = 0;
	self.var_c6452f46["weapon"] = 0;
	self.var_c6452f46["map"] = 0;
	if(!isdefined(self.var_9ee9bcc6))
	{
		self.var_9ee9bcc6 = int(0);
	}
	if(!isdefined(self.var_7da5117b))
	{
		self.var_7da5117b = int(0);
	}
	if(!isdefined(self.var_ebc62b1))
	{
		self.var_ebc62b1 = int(0);
	}
	if(!isdefined(self.var_f4d01b67["xp_hud"]))
	{
		self.var_f4d01b67["xp_hud"] = int(0);
	}
	if(!isdefined(self.var_f4d01b67["disabled_leveling_system"]))
	{
		self.var_f4d01b67["disabled_leveling_system"] = int(0);
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
	level flag::wait_till("initial_blackscreen_passed");
	while(!AreTexturesLoaded())
	{
		wait(0.05);
	}
	while(isdefined(self.is_hotjoining) && self.is_hotjoining)
	{
		self.var_ef3558a4 = 1;
		wait(1);
	}
	while(self.sessionstate != "playing")
	{
		wait(1);
	}
	wait(7);
	self thread function_afb49977();
	self thread function_d81f9d2b();
	wait(0.05);
	self luinotifyevent(&"spx_milestone_notification", 1, &"ZM_MINECRAFT_STARTUP_UEM");
	self luinotifyevent(&"spx_milestone_notification", 1, &"ZM_MINECRAFT_STARTUP_HALLOWEEN");
	wait(0.05);
	if(isdefined(1) && 1)
	{
		self luinotifyevent(&"spx_milestone_notification", 1, &"ZM_MINECRAFT_NOTIFICATION_DOUBLE_XP");
	}
	wait(0.05);
	if(isdefined(level.var_c181264f) && level.var_c181264f)
	{
		self luinotifyevent(&"spx_milestone_notification", 1, &"ZM_MINECRAFT_GUN_GAME_MODE");
	}
	wait(0.05);
	self thread function_3a391177();
	wait(0.05);
	self thread function_f11f718a();
	self util::waittill_any_return("completed_rank_stats_loading", "force_completed_rank_stats_loading");
	self thread function_35da0d5c();
	self thread function_f63c5f17();
	wait(0.05);
	self thread function_b3489bf5("^3" + self.playername + "^7 loaded their rank");
	if(isdefined(self.var_fa202141["player_playerdifficulty"]) && self.var_fa202141["player_playerdifficulty"] > self.var_b74a3cd1["brutal_rank"])
	{
		self.var_fa202141["player_playerdifficulty"] = self.var_b74a3cd1["brutal_rank"];
	}
	if(isdefined(self.var_fa202141["player_playerdifficulty"]) && self.var_fa202141["player_playerdifficulty"] > 0)
	{
		self luinotifyevent(&"spx_milestone_notification", 1, &"ZM_MINECRAFT_STARTUP_BRUTAL_MODE");
	}
	if(isdefined(self.var_fa202141["player_favorite_weapon"]) && self.var_fa202141["player_favorite_weapon"] > 0)
	{
		self.var_d27d944e = self.var_fa202141["player_favorite_weapon"];
	}
	self thread function_7e18304e("spx_end_game_save_data", "end_game_lobby_size_started", getplayers().size, 1);
	self thread function_7e18304e("spx_end_game_save_data", "end_game_map_name", 2, 1);
	if(self.var_b74a3cd1["level"] == 1 && self.var_b74a3cd1["prestige"] < 1)
	{
		self luinotifyevent(&"spx_milestone_notification", 1, &"ZM_MINECRAFT_WARNING_RANK_ONE");
	}
	self thread function_ca15044e();
	self thread function_48c20fe();
	self thread function_e6354944();
	self thread function_1da3a55e();
	self thread function_4ec7be94();
	self thread function_2319c53f();
	self thread function_3fca15b0();
}

/*
	Name: function_35da0d5c
	Namespace: namespace_97ac1184
	Checksum: 0x424F4353
	Offset: 0x109D0
	Size: 0x180
	Parameters: 0
	Flags: None
	Line Number: 2733
*/
function function_35da0d5c()
{
	if(self.var_15fde1f7["shop_500_points"] == 1)
	{
		self zm_score::add_to_player_score(500);
	}
	if(self.var_15fde1f7["shop_m93raffica_weapon"] == 1)
	{
		primary_weapons = self getweaponslist(1);
		foreach(weapon in primary_weapons)
		{
			if(weapon == level.start_weapon)
			{
				start_weapon = weapon;
			}
		}
		if(isdefined(start_weapon))
		{
			if(self getcurrentweapon() != start_weapon)
			{
				self switchtoweapon(start_weapon);
			}
			self takeweapon(start_weapon);
			self giveweapon(getweapon("pistol_burst"));
		}
	}
}

/*
	Name: function_f63c5f17
	Namespace: namespace_97ac1184
	Checksum: 0x424F4353
	Offset: 0x10B58
	Size: 0x48
	Parameters: 0
	Flags: None
	Line Number: 2771
*/
function function_f63c5f17()
{
	wait(0.05);
	self thread function_8923385d();
	wait(0.05);
	self thread function_6dfe54bc();
}

/*
	Name: function_6dfe54bc
	Namespace: namespace_97ac1184
	Checksum: 0x424F4353
	Offset: 0x10BA8
	Size: 0x228
	Parameters: 0
	Flags: None
	Line Number: 2789
*/
function function_6dfe54bc()
{
	self endon("disconnect");
	self endon("hash_d95e591d");
	self flag::init("completed_maps_stats_loading");
	foreach(value in level.var_c3e446a)
	{
		if(key == "savedata")
		{
			continue;
		}
		self luinotifyevent(&"spx_get_maps_save_data", 1, int(level.var_c3e446a[key]));
		self waittill("hash_5d94130e", dataName);
		if(isdefined(self.is_hotjoining) && self.is_hotjoining || tolower(getdvarstring("mapname")) == "zm_shoothouse" || tolower(getdvarstring("mapname")) == "zm_irondragon")
		{
			wait(0.1 * self getentitynumber() + 1);
			continue;
		}
		wait(0.06 * self getentitynumber() + 1);
	}
	self.var_c6452f46["map"] = 1;
	self notify("hash_41157217");
	self flag::set("completed_maps_stats_loading");
}

/*
	Name: function_de3783c
	Namespace: namespace_97ac1184
	Checksum: 0x424F4353
	Offset: 0x10DD8
	Size: 0x60
	Parameters: 0
	Flags: None
	Line Number: 2824
*/
function function_de3783c()
{
	iprintlnbold(self.name + ": Resetting Full Maps Stats");
	self.var_c6452f46["map"] = 1;
	self notify("hash_41157217");
	self notify("hash_d95e591d");
}

/*
	Name: function_8923385d
	Namespace: namespace_97ac1184
	Checksum: 0x424F4353
	Offset: 0x10E40
	Size: 0x2C0
	Parameters: 0
	Flags: None
	Line Number: 2842
*/
function function_8923385d()
{
	self endon("disconnect");
	self endon("hash_d95e591d");
	while(1)
	{
		self waittill("menuresponse", menu, response);
		if(menu == "levelingdatamapsmenu")
		{
			if(response == "reset")
			{
				self function_de3783c();
			}
			else if(response == "skip")
			{
				self notify("hash_5d94130e");
				continue;
			}
			var_b9b0ebb3 = strtok(response, "=");
			if(var_b9b0ebb3.size != 2)
			{
				self notify("hash_5d94130e");
				continue;
			}
			dataName = tolower(var_b9b0ebb3[0]);
			value = var_b9b0ebb3[1];
			var_abe6703d = tolower(level.var_742cf7b3[dataName]);
			if(dataName == "tryagain")
			{
				self luinotifyevent(&"spx_get_maps_save_data", 1, int(level.var_c3e446a[value]));
				iprintlnbold("Did not get a proper response; Trying again");
				continue;
			}
			switch(var_abe6703d)
			{
				case "player":
				{
					if(dataName == "xuid" && value != self getxuid(1))
					{
						self function_de3783c();
					}
					else if(dataName == "reset_keyword" && int(value) != 8351)
					{
						self function_de3783c();
						break;
					}
				}
				case "pers":
				{
					self.pers[dataName] = int(value);
					break;
				}
			}
			self notify("hash_5d94130e", dataName);
		}
	}
	return;
	ERROR: Exception occured: Stack empty.
}

/*
	Name: function_e6354944
	Namespace: namespace_97ac1184
	Checksum: 0x424F4353
	Offset: 0x11108
	Size: 0x40
	Parameters: 0
	Flags: None
	Line Number: 2912
*/
function function_e6354944()
{
	while(!isdefined(self.pers["hc2_trick_or_treat"]))
	{
		wait(0.5);
	}
	self thread function_ec5385f9();
}

/*
	Name: function_2319c53f
	Namespace: namespace_97ac1184
	Checksum: 0x424F4353
	Offset: 0x11150
	Size: 0x488
	Parameters: 0
	Flags: None
	Line Number: 2931
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
		if(isdefined(self.var_fa202141["player_character"]) && self.var_fa202141["player_character"] > 0 && isdefined(level.var_18ffd3f2[self getxuid(1)]))
		{
			if(self GetCharacterBodyType() != 9 || self GetCharacterBodyType() != 10 || self GetCharacterBodyType() != 11 || self GetCharacterBodyType() != 12 || self GetCharacterBodyType() != 13)
			{
				switch(self.var_fa202141["player_character"])
				{
					case 1:
					{
						if(level.var_18ffd3f2[self getxuid(1)].rank == "gold" || level.var_18ffd3f2[self getxuid(1)].rank == "master" || level.var_18ffd3f2[self getxuid(1)].rank == "paragon" || level.var_18ffd3f2[self getxuid(1)].rank == "ultimate")
						{
							self setcharacterbodytype(10);
							break;
						}
					}
					case 2:
					{
						if(level.var_18ffd3f2[self getxuid(1)].rank == "master" || level.var_18ffd3f2[self getxuid(1)].rank == "paragon" || level.var_18ffd3f2[self getxuid(1)].rank == "ultimate")
						{
							self setcharacterbodytype(12);
							break;
						}
					}
					case 3:
					{
						if(level.var_18ffd3f2[self getxuid(1)].rank == "paragon" || level.var_18ffd3f2[self getxuid(1)].rank == "ultimate")
						{
							self setcharacterbodytype(11);
							break;
						}
					}
					case 4:
					{
						if(level.var_18ffd3f2[self getxuid(1)].rank == "ultimate")
						{
							self setcharacterbodytype(13);
							break;
						}
					}
					case 5:
					{
						if(level.var_18ffd3f2[self getxuid(1)].rank == "ultimate")
						{
							self setcharacterbodytype(9);
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
	Offset: 0x115E0
	Size: 0xB48
	Parameters: 0
	Flags: None
	Line Number: 3006
*/
function function_3fca15b0()
{
	while(!isdefined(self.var_fa202141["player_characterhat"]))
	{
		wait(1);
	}
	while(!isdefined(level.var_18ffd3f2[self getxuid(1)]))
	{
		wait(1);
	}
	if(isdefined(self.var_fa202141["player_characterhat"]) && self.var_fa202141["player_characterhat"] > 0)
	{
		if(self getxuid(1) == "76561198075603410")
		{
			self thread function_2d147fe0("_zmu_hat_chicken_hat");
		}
		else if(self getxuid(1) == "76561198057632928" || self getxuid(1) == "76561198029188429")
		{
			switch(randomintrange(0, 2))
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
					if(self.pers["christmas_hat"] == 1)
					{
						self thread function_2d147fe0("_zmu_christmas_hat");
						break;
					}
				}
				case 3:
				{
					if(self.pers["halloween_pumpkin_hat"] == 1)
					{
						self thread function_2d147fe0("_zmu_halloween_hat");
						break;
					}
				}
				case 4:
				{
					if(isdefined(level.var_18ffd3f2[self getxuid(1)]) && (level.var_18ffd3f2[self getxuid(1)].rank == "bronze" || level.var_18ffd3f2[self getxuid(1)].rank == "silver" || level.var_18ffd3f2[self getxuid(1)].rank == "gold" || level.var_18ffd3f2[self getxuid(1)].rank == "master" || level.var_18ffd3f2[self getxuid(1)].rank == "paragon" || level.var_18ffd3f2[self getxuid(1)].rank == "ultimate"))
					{
						self thread function_2d147fe0("_zmu_crown_vip_bronze");
						break;
					}
				}
				case 5:
				{
					if(isdefined(level.var_18ffd3f2[self getxuid(1)]) && (level.var_18ffd3f2[self getxuid(1)].rank == "silver" || level.var_18ffd3f2[self getxuid(1)].rank == "gold" || level.var_18ffd3f2[self getxuid(1)].rank == "master" || level.var_18ffd3f2[self getxuid(1)].rank == "paragon" || level.var_18ffd3f2[self getxuid(1)].rank == "ultimate"))
					{
						self thread function_2d147fe0("_zmu_crown_vip_silver");
						break;
					}
				}
				case 6:
				{
					if(isdefined(level.var_18ffd3f2[self getxuid(1)]) && (level.var_18ffd3f2[self getxuid(1)].rank == "gold" || level.var_18ffd3f2[self getxuid(1)].rank == "master" || level.var_18ffd3f2[self getxuid(1)].rank == "paragon" || level.var_18ffd3f2[self getxuid(1)].rank == "ultimate"))
					{
						self thread function_2d147fe0("_zmu_crown_vip_gold");
						break;
					}
				}
				case 7:
				{
					if(isdefined(level.var_18ffd3f2[self getxuid(1)]) && (level.var_18ffd3f2[self getxuid(1)].rank == "master" || level.var_18ffd3f2[self getxuid(1)].rank == "paragon" || level.var_18ffd3f2[self getxuid(1)].rank == "ultimate"))
					{
						self thread function_2d147fe0("_zmu_crown_vip_master");
						break;
					}
				}
				case 8:
				{
					if(isdefined(level.var_18ffd3f2[self getxuid(1)]) && (level.var_18ffd3f2[self getxuid(1)].rank == "paragon" || level.var_18ffd3f2[self getxuid(1)].rank == "ultimate"))
					{
						self thread function_2d147fe0("_zmu_crown_vip_paragon");
						break;
					}
				}
				case 9:
				{
					if(isdefined(level.var_18ffd3f2[self getxuid(1)]) && level.var_18ffd3f2[self getxuid(1)].rank == "ultimate")
					{
						self thread function_2d147fe0("_zmu_crown_vip_ultimate");
						break;
					}
				}
				case 10:
				{
					if(isdefined(level.var_18ffd3f2[self getxuid(1)]) && (level.var_18ffd3f2[self getxuid(1)].rank == "master" || level.var_18ffd3f2[self getxuid(1)].rank == "paragon" || level.var_18ffd3f2[self getxuid(1)].rank == "ultimate"))
					{
						self thread function_2d147fe0("_zmu_hat_chicken_hat");
						break;
					}
				}
				case 11:
				{
					if(isdefined(level.var_18ffd3f2[self getxuid(1)]) && (level.var_18ffd3f2[self getxuid(1)].rank == "paragon" || level.var_18ffd3f2[self getxuid(1)].rank == "ultimate"))
					{
						self thread function_2d147fe0("_zmu_hat_tv_hat");
						break;
					}
				}
				case 999:
				{
					if(self getxuid(1) == "76561198160068017")
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
	ERROR: Exception occured: Stack empty.
}

/*
	Name: function_2fbda28f
	Namespace: namespace_97ac1184
	Checksum: 0x424F4353
	Offset: 0x12130
	Size: 0x2B0
	Parameters: 0
	Flags: None
	Line Number: 3161
*/
function function_2fbda28f()
{
	self endon("bled_out");
	self endon("spawned_player");
	self endon("disconnect");
	wait(0.05);
	level flag::wait_till("initial_blackscreen_passed");
	self thread function_95db0c88();
	function_8b57c052("PlaySound", 0);
	for(;;)
	{
		wait(0.05);
		dvar_value = getdvarint("PlaySound");
		if(isdefined(dvar_value) && dvar_value != 0)
		{
			function_8b57c052("PlaySound", 0);
			switch(self.var_f4d01b67["sound_pack"])
			{
				case 1:
				{
					playsoundatposition("player_sounds_windows_shutdown", self.origin);
					break;
				}
				case 2:
				{
					playsoundatposition("player_sounds_fart", self.origin);
					break;
				}
				case 3:
				{
					playsoundatposition("player_sounds_i_like_turtles", self.origin);
					break;
				}
				case 4:
				{
					playsoundatposition("player_sounds_enemy_spotted", self.origin);
					break;
				}
				case 5:
				{
					playsoundatposition("player_sounds_laugh_scooby", self.origin);
					break;
				}
				case 6:
				{
					playsoundatposition("player_sounds_fbi_open_up", self.origin);
					break;
				}
				case 7:
				{
					playsoundatposition("player_sounds_uwu", self.origin);
					break;
				}
				case 8:
				{
					playsoundatposition("player_sounds_emotional_damage", self.origin);
					break;
				}
				case 9:
				{
					playsoundatposition("player_sounds_hi_how_are_ya", self.origin);
					break;
				}
			}
		}
	}
	return;
}

/*
	Name: function_95db0c88
	Namespace: namespace_97ac1184
	Checksum: 0x424F4353
	Offset: 0x123E8
	Size: 0x78
	Parameters: 0
	Flags: None
	Line Number: 3240
*/
function function_95db0c88()
{
	while(1)
	{
		if(isdefined(self))
		{
			self waittill("menuresponse", menu, response);
			if(menu == "soundpackmenu")
			{
				self.var_f4d01b67["sound_pack"] = int(response);
			}
		}
	}
	return;
	ERROR: Exception occured: Stack empty.
}

/*
	Name: function_2d147fe0
	Namespace: namespace_97ac1184
	Checksum: 0x424F4353
	Offset: 0x12468
	Size: 0xC0
	Parameters: 1
	Flags: None
	Line Number: 3267
*/
function function_2d147fe0(model)
{
	self notify("hash_5f7623c6");
	self endon("hash_5f7623c6");
	self attach(model, "j_head");
	self.var_1652177e = model;
	wait(0.05);
	self util::waittill_any("player_equip_new_hat", "disconnect");
	if(isdefined(self) && isalive(self))
	{
		self detach(model, "j_head");
		return;
	}
	.var_0 = undefined;
}

/*
	Name: function_48c20fe
	Namespace: namespace_97ac1184
	Checksum: 0x424F4353
	Offset: 0x12530
	Size: 0x140
	Parameters: 0
	Flags: None
	Line Number: 3293
*/
function function_48c20fe()
{
	self thread function_790454cd();
	self thread function_7e18304e("spx_save_data", "prestige", self.var_b74a3cd1["prestige"], 0);
	self thread function_7e18304e("spx_save_data", "level", self.var_b74a3cd1["level"], 0);
	self thread function_7e18304e("spx_save_data", "xp", self.var_b74a3cd1["xp"], 0);
	wait(0.05);
	for(i = 0; i < getdvarint("com_maxclients"); i++)
	{
		self thread function_7e18304e("player_data", i, i, 0, 1);
	}
	wait(0.05);
}

/*
	Name: function_87d1927f
	Namespace: namespace_97ac1184
	Checksum: 0x424F4353
	Offset: 0x12678
	Size: 0x2C8
	Parameters: 10
	Flags: None
	Line Number: 3317
*/
function function_87d1927f(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime)
{
	if(tolower(getdvarstring("mapname")) == "zm_temple")
	{
		if(isplayer(self) && self hasperk("specialty_phdflopper") && (zm_utility::is_explosive_damage(smeansofdeath) || smeansofdeath == "MOD_FALLING" || smeansofdeath == "MOD_EXPLOSIVE"))
		{
			return 0;
		}
	}
	if(level.round_number >= 5 && (!(isdefined(self.var_d9a9d5d8) && self.var_d9a9d5d8)))
	{
		self.var_d9a9d5d8 = 1;
	}
	if(isdefined(eattacker) && weapon.name == "zombie_ai_defaultmelee")
	{
		if(isdefined(self.var_fa202141["player_playerdifficulty"]) && self.var_fa202141["player_playerdifficulty"] > 0)
		{
			if(level flag::get("classic_enabled") && self.var_fa202141["player_playerdifficulty"] < 10)
			{
				return 50;
			}
			else if(35 + int(self.var_fa202141["player_playerdifficulty"] * 1.5) > 90 && (isdefined(self.var_fa202141["player_brutalcap"]) && self.var_fa202141["player_brutalcap"] == 0))
			{
				return 90;
			}
			else
			{
				return 35 + int(self.var_fa202141["player_playerdifficulty"] * 1.5);
			}
		}
		else if(level flag::get("classic_enabled"))
		{
			return 50;
		}
		switch(level.var_bdc116e3)
		{
			case 2:
			{
				return 30;
			}
		}
	}
	return -1;
}

/*
	Name: function_592735a9
	Namespace: namespace_97ac1184
	Checksum: 0x424F4353
	Offset: 0x12948
	Size: 0x80
	Parameters: 0
	Flags: None
	Line Number: 3372
*/
function function_592735a9()
{
	self endon("hash_d2bbeae8");
	self endon("hash_41157217");
	for(count = 0; count < 30; count++)
	{
		wait(1);
	}
	iprintlnbold("Forcing rank loading completion, please notify Sphynx");
	self notify("hash_f505e998");
	self notify("hash_74979e67");
}

/*
	Name: function_182e5a64
	Namespace: namespace_97ac1184
	Checksum: 0x424F4353
	Offset: 0x129D0
	Size: 0xD8
	Parameters: 0
	Flags: None
	Line Number: 3395
*/
function function_182e5a64()
{
	while(!isdefined(self.var_6915e7ce["r1"]))
	{
		wait(0.05);
	}
	for(i = 1; i < self.var_6915e7ce.size; i++)
	{
		if(!isdefined(self.var_6915e7ce["r" + i]) || self.var_6915e7ce["r" + i].enabled == 0)
		{
			continue;
		}
		wait(0.05);
		self thread function_bdd58b53(self.var_6915e7ce["r" + i]);
	}
}

/*
	Name: function_bdd58b53
	Namespace: namespace_97ac1184
	Checksum: 0x424F4353
	Offset: 0x12AB0
	Size: 0x150
	Parameters: 1
	Flags: None
	Line Number: 3422
*/
function function_bdd58b53(reward)
{
	iprintlnbold("Gave Reward: " + reward.description);
	switch(reward.var_bd058c01)
	{
		case "r1":
		{
			self setcharacterbodytype(5);
			break;
		}
		case "r2":
		{
			self zm_weapons::weapon_give(getweapon("melee_jug"), 0, 0, 1, 1);
			break;
		}
		case "r3":
		{
			self zm_score::add_to_player_score(500);
			break;
		}
		case "r4":
		{
			self.var_a29c8301 = getweapon("t9_1911_midnight");
			break;
		}
		case "r5":
		{
			self zm_weapons::weapon_give(getweapon("incendiary_grenade"), 0, 0, 1, 0);
			break;
		}
	}
}

/*
	Name: function_ac0dc73f
	Namespace: namespace_97ac1184
	Checksum: 0x424F4353
	Offset: 0x12C08
	Size: 0xB0
	Parameters: 1
	Flags: None
	Line Number: 3465
*/
function function_ac0dc73f(type)
{
	switch(type)
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
	Offset: 0x12CC0
	Size: 0x1028
	Parameters: 0
	Flags: None
	Line Number: 3503
*/
function function_ca15044e()
{
	self endon("disconnect");
	self.var_a1d93d72 = int(0);
	for(;;)
	{
		self waittill("hash_79ef118b", type, amount, zombie);
		var_f0780448 = amount;
		var_514894 = function_ac0dc73f("xp");
		var_2e8a2b5e = function_ac0dc73f("level");
		var_4ce15837 = function_ac0dc73f("prestige");
		var_2d118321 = function_ac0dc73f("brutal_rank");
		var_9baa3c53 = function_ac0dc73f("brutal_xp");
		if(self.var_f4d01b67["disabled_leveling_system"] == 1)
		{
			wait(0.1);
		}
		else if(isdefined(type))
		{
			amount = self function_565fd0dc(type, amount, zombie);
		}
		else if(amount < int(2501))
		{
			self thread score_event(&"ZM_MINECRAFT_SCORE_GENERAL", amount);
		}
		var_ca7a8609 = self function_4c2abd48(self.var_b74a3cd1["level"]);
		if(self.var_b74a3cd1["xp"] + amount > var_514894 + var_f0780448 * 2.3)
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
			self thread function_adc67b81(amount);
		}
		debug_print(0, "Leveling System: ^5 Gained " + amount + " XP! of event: " + type);
		self.var_b74a3cd1["xp"] = self.var_b74a3cd1["xp"] + int(amount);
		if(self.var_b74a3cd1["xp"] < 0)
		{
			self.var_b74a3cd1["xp"] = int(0);
		}
		self.var_b74a3cd1["xp_gained_this_game"] = self.var_b74a3cd1["xp_gained_this_game"] + int(amount);
		if(self.var_b74a3cd1["xp_gained_this_game"] > 0)
		{
			self.var_b74a3cd1["xp_per_second"] = self.var_b74a3cd1["xp_gained_this_game"] / int(level.var_8f1fd1e4);
			if(self.pers["highest_total_xpm"] > self.var_b74a3cd1["xp_per_second"])
			{
			}
			else
			{
				self.pers["highest_total_xpm"] = self.var_b74a3cd1["xp_per_second"];
				self thread function_7e18304e("spx_save_data", "highest_total_xpm", self.pers["highest_total_xpm"], 0);
			}
		}
		if(amount > self.var_b74a3cd1["xp_highest_this_game"])
		{
			self.var_b74a3cd1["xp_highest_this_game"] = amount;
			self thread function_7e18304e("spx_end_game_save_data", "end_game_highest_xp", int(amount), 1);
		}
		if(self.var_b74a3cd1["xp_per_second"] > self.pers["end_game_highest_xps"])
		{
			self thread function_7e18304e("spx_end_game_save_data", "end_game_highest_xps", self.var_b74a3cd1["xp_per_second"], 1);
		}
		self thread function_7e18304e("spx_end_game_save_data", "end_game_total_xp_gained", int(amount), 0);
		if(self.var_b74a3cd1["xp"] >= var_ca7a8609["xp_needed"])
		{
			debug_print(0, "Leveling System: ^5 Player has enough xp, reset and level up");
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
				debug_print(0, "Leveling System: ^5 XP is still too much, level up");
				break;
			}
			self thread function_b3489bf5("^3" + self.playername + "^7 leveled up to rank ^9" + self.var_b74a3cd1["level"]);
			self.var_b74a3cd1["xp"] = 0;
			self luinotifyevent(&"spx_rank_up_notification", 3, 1, self.var_b74a3cd1["prestige"], self.var_b74a3cd1["level"]);
			debug_print(0, "Leveling System: ^5 Player has enough levels, Prestige");
			self.var_b74a3cd1["prestige"]++;
			self.pers["player_points"] = self.pers["player_points"] + 200;
			self.var_b74a3cd1["level"] = 1;
			self thread function_b3489bf5("^3" + self.playername + "^7 prestiged to ^9" + self.var_b74a3cd1["prestige"]);
			self thread function_7e18304e("spx_end_game_save_data", "end_game_prestige_gained", 1, 0);
			self thread function_7e18304e("spx_end_game_save_data", "end_game_prestige", 1, 0);
			var_ca7a8609 = self function_4c2abd48(self.var_b74a3cd1["level"]);
			var_af7d80a6 = var_ca7a8609["xp_needed"] - self.var_b74a3cd1["xp"];
			self.var_b74a3cd1["xp"] = 0 + var_af7d80a6;
			self.var_b74a3cd1["level"]++;
			debug_print(0, "Leveling System: ^5 XP is still too much, level up");
			break;
			self thread function_b3489bf5("^3" + self.playername + "^7 leveled up to rank ^9" + self.var_b74a3cd1["level"]);
			self thread function_48c20fe();
			self.var_b74a3cd1["prestige_legend"]++;
			self.var_b74a3cd1["prestige"] = int(0);
			self.var_b74a3cd1["level"] = int(1);
			self.var_b74a3cd1["xp"] = int(0);
			self thread function_b3489bf5("^3" + self.playername + "^7 leveled up to Prestige Legend ^9" + self.var_b74a3cd1["prestige_legend"]);
			self.var_b74a3cd1["prestige_absolute"]++;
			self.var_b74a3cd1["prestige_legend"] = int(0);
			self.var_b74a3cd1["prestige"] = int(0);
			self.var_b74a3cd1["level"] = int(1);
			self.var_b74a3cd1["xp"] = int(0);
			self.pers["absolute_camo"] = 1;
			self thread function_b3489bf5("^3" + self.playername + "^7 leveled up to Prestige Absolute ^9" + self.var_b74a3cd1["prestige_legend"]);
			self.var_b74a3cd1["prestige_ultimate"]++;
			self.var_b74a3cd1["prestige_absolute"] = int(0);
			self.var_b74a3cd1["prestige_legend"] = int(0);
			self.var_b74a3cd1["prestige"] = int(0);
			self.var_b74a3cd1["level"] = int(1);
			self.var_b74a3cd1["xp"] = int(0);
			self.pers["absolute_camo"] = 1;
			self thread function_b3489bf5("^3" + self.playername + "^7 leveled up to Prestige Absolute ^9" + self.var_b74a3cd1["prestige_legend"]);
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
			if(self.var_b74a3cd1["prestige"] == 20 && self.var_b74a3cd1["level"] >= 1000 && self.var_b74a3cd1["prestige_legend"] < 10)
			{
			}
			if(self.var_b74a3cd1["prestige"] == 20 && self.var_b74a3cd1["level"] >= 1000 && self.var_b74a3cd1["prestige_legend"] >= 10)
			{
				if(self.pers["absolute_camo"] != 0)
				{
				}
			}
			if(self.var_b74a3cd1["prestige"] == 20 && self.var_b74a3cd1["level"] >= 1000 && self.var_b74a3cd1["prestige_legend"] >= 10 && self.var_b74a3cd1["prestige_absolute"] >= 10)
			{
				if(self.pers["absolute_camo"] != 0)
				{
				}
			}
			self thread function_48c20fe();
			debug_print(0, "Leveling System: ^5 Level: " + var_ca7a8609["level_index"] + " | XP Needed: " + var_ca7a8609["xp_needed"]);
		}
	}
}

/*
	Name: score_event
	Namespace: namespace_97ac1184
	Checksum: 0x424F4353
	Offset: 0x13CF0
	Size: 0xE8
	Parameters: 3
	Flags: None
	Line Number: 3689
*/
function score_event(var_89be7cc4, amount, cheater)
{
	if(!isdefined(cheater))
	{
		cheater = 0;
	}
	if(cheater)
	{
		self thread function_8c165b4d("Data", "ScoreUI", "+" + amount + " [Cheated] " + makelocalizedstring(var_89be7cc4), 1, 1);
	}
	else
	{
		self thread function_8c165b4d("Data", "ScoreUI", "+" + amount + " " + makelocalizedstring(var_89be7cc4), 1, 1);
		return;
	}
	cheater++;
}

/*
	Name: function_d1935658
	Namespace: namespace_97ac1184
	Checksum: 0x424F4353
	Offset: 0x13DE0
	Size: 0x38
	Parameters: 0
	Flags: None
	Line Number: 3717
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
	Offset: 0x13E20
	Size: 0x60
	Parameters: 0
	Flags: None
	Line Number: 3739
*/
function function_e375856c()
{
	while(getplayers().size > 1)
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
	Offset: 0x13E88
	Size: 0x468
	Parameters: 1
	Flags: None
	Line Number: 3763
*/
function function_adc67b81(var_93958074)
{
	if(self.var_b74a3cd1["brutal_rank"] == self.var_fa202141["player_playerdifficulty"])
	{
		amount = zm_utility::round_up_score(var_93958074 / 80, 1);
	}
	else if(self.var_fa202141["player_playerdifficulty"] == self.var_b74a3cd1["brutal_rank"] - 1)
	{
		amount = zm_utility::round_up_score(var_93958074 / 100, 1);
	}
	else if(self.var_fa202141["player_playerdifficulty"] == self.var_b74a3cd1["brutal_rank"] - 2)
	{
		amount = zm_utility::round_up_score(var_93958074 / 120, 1);
	}
	else if(self.var_fa202141["player_playerdifficulty"] == self.var_b74a3cd1["brutal_rank"] - 3)
	{
		amount = zm_utility::round_up_score(var_93958074 / 160, 1);
	}
	else if(self.var_fa202141["player_playerdifficulty"] < self.var_b74a3cd1["brutal_rank"] - 4)
	{
		amount = zm_utility::round_up_score(var_93958074 / 250, 1);
	}
	else if(self.var_fa202141["player_playerdifficulty"] < self.var_b74a3cd1["brutal_rank"] - 5)
	{
		amount = 0;
	}
	if(amount > 20)
	{
		amount = 20;
	}
	self.var_b74a3cd1["brutal_xp"] = self.var_b74a3cd1["brutal_xp"] + amount;
	self thread function_7e18304e("spx_save_data", "brutal_xp", self.var_b74a3cd1["brutal_xp"], 0);
	var_ca7a8609 = self function_7da4fcdb(self.var_b74a3cd1["brutal_rank"]);
	if(self.var_b74a3cd1["brutal_xp"] >= var_ca7a8609["xp_needed"] && self.var_b74a3cd1["brutal_rank"] <= 74)
	{
		self.var_b74a3cd1["brutal_rank"]++;
		self thread function_7e18304e("spx_save_data", "brutal_rank", self.var_b74a3cd1["brutal_rank"], 0);
		if(self.var_fa202141["player_playerdifficulty"] == self.var_b74a3cd1["brutal_rank"] - 1)
		{
			self.var_fa202141["player_playerdifficulty"] = self.var_b74a3cd1["brutal_rank"];
		}
		self.var_b74a3cd1["brutal_xp"] = 0;
		self thread function_b3489bf5("^3" + self.playername + "^7 leveled up to brutal rank ^9" + self.var_b74a3cd1["brutal_rank"]);
		self luinotifyevent(&"spx_rank_up_notification", 2, 2, self.var_b74a3cd1["brutal_rank"]);
	}
	else
	{
		self luinotifyevent(&"ZMBU_info", 4, &"ZM_MINECRAFT_BRUTAL_RANK", self.var_b74a3cd1["brutal_rank"], self.var_b74a3cd1["brutal_xp"], var_ca7a8609["xp_needed"]);
		return;
	}
	continue;
}

/*
	Name: function_a1d93d72
	Namespace: namespace_97ac1184
	Checksum: 0x424F4353
	Offset: 0x142F8
	Size: 0x50
	Parameters: 0
	Flags: None
	Line Number: 3826
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
	Offset: 0x14350
	Size: 0x2B8
	Parameters: 1
	Flags: None
	Line Number: 3847
*/
function function_71333cee(rank)
{
	if(rank >= 1 && rank <= 10)
	{
		self.pers["player_points"] = self.pers["player_points"] + 10;
	}
	else if(rank >= 11 && rank <= 20)
	{
		self.pers["player_points"] = self.pers["player_points"] + 20;
	}
	else if(rank >= 21 && rank <= 30)
	{
		self.pers["player_points"] = self.pers["player_points"] + 30;
	}
	else if(rank >= 31 && rank <= 40)
	{
		self.pers["player_points"] = self.pers["player_points"] + 40;
	}
	else if(rank >= 41 && rank <= 50)
	{
		self.pers["player_points"] = self.pers["player_points"] + 50;
	}
	else if(rank >= 51 && rank <= 60)
	{
		self.pers["player_points"] = self.pers["player_points"] + 60;
	}
	else if(rank >= 61 && rank <= 70)
	{
		self.pers["player_points"] = self.pers["player_points"] + 70;
	}
	else if(rank >= 71 && rank <= 80)
	{
		self.pers["player_points"] = self.pers["player_points"] + 80;
	}
	else if(rank >= 81 && rank <= 90)
	{
		self.pers["player_points"] = self.pers["player_points"] + 90;
	}
}

/*
	Name: function_4c2abd48
	Namespace: namespace_97ac1184
	Checksum: 0x424F4353
	Offset: 0x14610
	Size: 0xD8
	Parameters: 1
	Flags: None
	Line Number: 3897
*/
function function_4c2abd48(index)
{
	var_ca7a8609 = [];
	row = tablelookuprow("gamedata/leveling/leveling_xp.csv", int(index));
	var_ca7a8609["level_index"] = int(checkStringValid(row[0]));
	var_ca7a8609["xp_needed"] = int(checkStringValid(row[1]));
	return var_ca7a8609;
}

/*
	Name: function_7da4fcdb
	Namespace: namespace_97ac1184
	Checksum: 0x424F4353
	Offset: 0x146F0
	Size: 0xD8
	Parameters: 1
	Flags: None
	Line Number: 3916
*/
function function_7da4fcdb(index)
{
	var_ca7a8609 = [];
	row = tablelookuprow("gamedata/leveling/brutal_rank_xp.csv", int(index));
	var_ca7a8609["level_index"] = int(checkStringValid(row[0]));
	var_ca7a8609["xp_needed"] = int(checkStringValid(row[1]));
	return var_ca7a8609;
}

/*
	Name: checkStringValid
	Namespace: namespace_97ac1184
	Checksum: 0x424F4353
	Offset: 0x147D0
	Size: 0x28
	Parameters: 1
	Flags: None
	Line Number: 3935
*/
function checkStringValid(str)
{
	if(str != "")
	{
		return str;
	}
	return undefined;
	ERROR: Exception occured: Stack empty.
}

/*
	Name: debug_print
	Namespace: namespace_97ac1184
	Checksum: 0x424F4353
	Offset: 0x14800
	Size: 0x90
	Parameters: 2
	Flags: None
	Line Number: 3955
*/
function debug_print(type, print)
{
	if(0)
	{
		if(type == 0 || type == undefined || type == "")
		{
			iprintlnbold("^1 Debug: ^7" + print);
		}
		else
		{
			iprintln("^1 Debug: ^7" + print);
		}
	}
}

/*
	Name: function_4ec7be94
	Namespace: namespace_97ac1184
	Checksum: 0x424F4353
	Offset: 0x14898
	Size: 0x68
	Parameters: 0
	Flags: None
	Line Number: 3980
*/
function function_4ec7be94()
{
	self waittill("hash_cb55d4d2");
	if(self.var_d31d6052 >= 25 && self.pers["mastery_camo"] != 1)
	{
		self.pers["mastery_camo"] = 1;
		self thread function_231f215a();
		return;
	}
	ERROR: Exception occured: Stack empty.
}

/*
	Name: function_1da3a55e
	Namespace: namespace_97ac1184
	Checksum: 0x424F4353
	Offset: 0x14908
	Size: 0x128
	Parameters: 0
	Flags: None
	Line Number: 4002
*/
function function_1da3a55e()
{
	if(self.pers["cc_kills"] >= 20000 && self.pers["cc_headshots"] >= 4000 && self.pers["cc_packed_kills"] >= 5000 && self.pers["cc_rounds_progressed"] >= 250 && self.pers["cc_exfil"] >= 5 && self.pers["cc_christmaspresents"] >= 125 && self.pers["cc_mystery_box"] >= 150 && self.pers["cc_reach_round"] >= 3)
	{
		self.pers["cc_all_challenges"] = 1;
		self.pers["christmas_camo"] = 1;
		self thread function_231f215a();
	}
}

/*
	Name: function_ec5385f9
	Namespace: namespace_97ac1184
	Checksum: 0x424F4353
	Offset: 0x14A38
	Size: 0x970
	Parameters: 0
	Flags: None
	Line Number: 4022
*/
function function_ec5385f9()
{
	wait(0.05);
	if(self.pers["hc2_trick_or_treat"] >= 150 && self.pers["halloween_pumpkin_hat"] != 1)
	{
		self.pers["halloween_pumpkin_hat"] = 1;
	}
	wait(0.05);
	if(self.pers["hc2_rounds"] >= 250 && self.pers["hc2_round_35_five_times"] >= 5 && self.pers["hc2_no_damage_rounds"] >= 35 && self.pers["hc2_trick_or_treat_single_game"] >= 10 && self.pers["hc2_perk_master"] >= 5 && self.pers["hc2_perfect_game"] >= 1 && self.pers["hc2_complete_round_challenges"] < 1)
	{
		self.pers["hc2_complete_round_challenges"] = 1;
		self.pers["halloween_pet"] = 1;
		self thread function_7e18304e("spx_save_data", "hc2_complete_round_challenges", self.pers["hc2_complete_round_challenges"], 0);
		self thread function_7e18304e("spx_save_data", "halloween_pet", self.pers["halloween_pet"], 0);
	}
	wait(0.05);
	if(self.pers["hc2_kills"] >= 25000 && self.pers["hc2_headshots"] >= 6000 && self.pers["hc2_repack"] >= 75 && self.pers["hc2_rapidkills"] >= 2500 && self.pers["hc2_melee_kills"] >= 1500 && self.pers["hc2_ghost_kills"] >= 12 && self.pers["hc2_ads_kills"] >= 1000 && self.pers["hc2_crouch_kills"] >= 750 && self.pers["hc2_sniper_kills"] >= 1500 && self.pers["hc2_pistol_kills"] >= 1000 && self.pers["hc2_ar_kills"] >= 2500 && self.pers["hc2_shotgun_kills"] >= 1500 && self.pers["hc2_smg_kills"] >= 2500 && self.pers["hc2_lmg_kills"] >= 3000 && self.pers["hc2_hipfire_kills"] >= 450 && self.pers["hc2_explosive_kills"] >= 2500 && self.pers["hc2_longshot_pap_kills"] >= 1500 && self.pers["hc2_consecutive_headshots"] >= 1500 && self.pers["hc2_upgraded_kills"] >= 5000 && self.pers["hc2_kill_challenges_complete"] < 1)
	{
		self.pers["hc2_kill_challenges_complete"] = 1;
		self.pers["halloween_camo"] = 1;
		self thread function_7e18304e("spx_save_data", "hc2_kill_challenges_complete", self.pers["hc2_kill_challenges_complete"], 0);
		self thread function_7e18304e("spx_save_data", "halloween_camo", self.pers["halloween_camo"], 0);
	}
	wait(0.05);
	if(self.pers["hc2_kills"] >= 25000 && self.pers["hc2_headshots"] >= 6000 && self.pers["hc2_rounds"] >= 250 && self.pers["hc2_repack"] >= 75 && self.pers["hc2_trick_or_treat"] >= 150 && self.pers["hc2_random_box"] >= 175 && self.pers["hc2_rapidkills"] >= 2500 && self.pers["hc2_melee_kills"] >= 1500 && self.pers["hc2_perks_purchased"] >= 75 && self.pers["hc2_ghost_kills"] >= 12 && self.pers["hc2_spend_points"] >= 2000000 && self.pers["hc2_ads_kills"] >= 1000 && self.pers["hc2_crouch_kills"] >= 750 && self.pers["hc2_round_35_five_times"] >= 5 && self.pers["hc2_single_game_headshots"] >= 500 && self.pers["hc2_sniper_kills"] >= 1500 && self.pers["hc2_pistol_kills"] >= 1000 && self.pers["hc2_ar_kills"] >= 2500 && self.pers["hc2_shotgun_kills"] >= 1500 && self.pers["hc2_smg_kills"] >= 2500 && self.pers["hc2_lmg_kills"] >= 3000 && self.pers["hc2_hipfire_kills"] >= 450 && self.pers["hc2_no_damage_rounds"] >= 35 && self.pers["hc2_fire_sale_weapons"] >= 35 && self.pers["hc2_trick_or_treat_single_game"] >= 10 && self.pers["hc2_perk_master"] >= 5 && self.pers["hc2_explosive_kills"] >= 2500 && self.pers["hc2_consecutive_headshots"] >= 1500 && self.pers["hc2_longshot_pap_kills"] >= 1500 && self.pers["hc2_upgraded_kills"] >= 5000 && self.pers["hc2_perfect_game"] >= 1 && self.pers["hc2_complete_round_challenges"] >= 1 && self.pers["hc2_kill_challenges_complete"] >= 1 && self.pers["hc2_all_challenges"] < 1)
	{
		self.pers["hc2_all_challenges"] = 1;
		self.pers["halloween_camo_2"] = 1;
		self.pers["halloween_title"] = 1;
		self thread function_7e18304e("spx_save_data", "hc2_all_challenges", self.pers["hc2_all_challenges"], 0);
		self thread function_7e18304e("spx_save_data", "halloween_camo_2", self.pers["halloween_camo_2"], 0);
		self thread function_7e18304e("spx_save_data", "halloween_title", self.pers["halloween_title"], 0);
	}
	wait(0.05);
	self thread function_231f215a();
	return;
}

/*
	Name: function_5e4556db
	Namespace: namespace_97ac1184
	Checksum: 0x424F4353
	Offset: 0x153B0
	Size: 0x1B8
	Parameters: 0
	Flags: None
	Line Number: 4070
*/
function function_5e4556db()
{
	for(;;)
	{
		wait(1);
		accuracy = 0;
		total_shots = self.pers["total_shots"] - self.pers["end_game_total_shots"];
		total_hits = self.pers["hits"] - self.pers["end_game_total_hits"];
		var_acdca88c = self.pers["misses"] - self.pers["end_game_total_misses"];
		var_4ecb4534 = 0;
		if(total_shots > 0)
		{
			accuracy = total_hits / total_shots * 100;
		}
		wait(1);
		self thread function_7e18304e("spx_end_game_save_data", "end_game_total_shots", total_shots, 1);
		self thread function_7e18304e("spx_end_game_save_data", "end_game_total_hits", total_hits, 1);
		self thread function_7e18304e("spx_end_game_save_data", "end_game_total_misses", var_acdca88c, 1);
		self thread function_7e18304e("spx_end_game_save_data", "end_game_accuracy", int(accuracy), 1);
	}
}

/*
	Name: function_7eb13385
	Namespace: namespace_97ac1184
	Checksum: 0x424F4353
	Offset: 0x15570
	Size: 0xF8
	Parameters: 0
	Flags: None
	Line Number: 4102
*/
function function_7eb13385()
{
	level endon("end_game");
	level flag::init("between_round");
	wait(0.05);
	for(;;)
	{
		result = level util::waittill_any_return("start_of_round", "end_of_round");
		if(result == "start_of_round")
		{
			level.var_974310f = 0;
			level flag::clear("between_round");
		}
		else
		{
			level flag::set("between_round");
			if(level.round_number < 255)
			{
				level.var_dc0909ef = level.round_number;
			}
			else
			{
				level.var_dc0909ef++;
			}
		}
	}
	return;
}

/*
	Name: function_e67bbb8
	Namespace: namespace_97ac1184
	Checksum: 0x424F4353
	Offset: 0x15670
	Size: 0x188
	Parameters: 0
	Flags: None
	Line Number: 4141
*/
function function_e67bbb8()
{
	level endon("end_game");
	self endon("disconnect");
	self thread function_a48f6a30();
	self thread function_72799f99();
	for(;;)
	{
		result = level util::waittill_any_return("start_of_round", "end_of_round");
		if(result == "start_of_round")
		{
			start_time = GetTime();
		}
		else if(level.round_number >= 5 && (!(isdefined(self.var_d9a9d5d8) && self.var_d9a9d5d8)))
		{
			wait(0.05);
			self notify("hash_63cf7d21", "hc2_no_damage_rounds", 1, 35, 100000);
		}
		self.var_d9a9d5d8 = 0;
		end_time = GetTime();
		elapsed_time = end_time - start_time;
		self thread function_8c165b4d("Data", "RoundTimerLast", elapsed_time / 1000);
		self thread function_8c165b4d("Data", "roundsPlayed", level.var_dc0909ef + 1);
	}
}

/*
	Name: function_72799f99
	Namespace: namespace_97ac1184
	Checksum: 0x424F4353
	Offset: 0x15800
	Size: 0x30
	Parameters: 0
	Flags: None
	Line Number: 4177
*/
function function_72799f99()
{
	while(!isdefined(level.round_number))
	{
		wait(1);
	}
	level.var_dc0909ef = level.round_number;
	return;
	~level.var_dc0909ef;
}

/*
	Name: function_a48f6a30
	Namespace: namespace_97ac1184
	Checksum: 0x424F4353
	Offset: 0x15838
	Size: 0x70
	Parameters: 0
	Flags: None
	Line Number: 4198
*/
function function_a48f6a30()
{
	level endon("end_game");
	self endon("disconnect");
	for(;;)
	{
		wait(0.1 * self getentitynumber() + 1);
		self thread function_8c165b4d("Data", "RoundTimerCurrent", level.var_974310f);
	}
}

/*
	Name: function_a485c61f
	Namespace: namespace_97ac1184
	Checksum: 0x424F4353
	Offset: 0x158B0
	Size: 0x48
	Parameters: 0
	Flags: None
	Line Number: 4219
*/
function function_a485c61f()
{
	while(level flag::get("between_round"))
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
	Offset: 0x15900
	Size: 0x1B8
	Parameters: 5
	Flags: None
	Line Number: 4240
*/
function function_8c165b4d(type, uimodel, value, priority, var_363c7886)
{
	if(!isdefined(priority))
	{
		priority = 0;
	}
	if(!isdefined(var_363c7886))
	{
		var_363c7886 = 0;
	}
	if(!isdefined(value))
	{
		value = 0;
	}
	if(!isdefined(self.var_29ffc8dc))
	{
		self.var_29ffc8dc = [];
	}
	if(!isdefined(self.var_4dd2bcd7))
	{
		self.var_4dd2bcd7 = [];
	}
	key = uimodel;
	if(isdefined(var_363c7886) && var_363c7886)
	{
		key = uimodel + randomintrange(0, 1000000);
	}
	var_535f7585 = spawnstruct();
	var_535f7585.type = type;
	var_535f7585.uimodel = uimodel;
	var_535f7585.value = value;
	var_535f7585.priority = priority;
	if(isdefined(var_363c7886) && var_363c7886)
	{
		var_535f7585.Randomized = key;
	}
	if(isdefined(priority) && priority)
	{
		self.var_4dd2bcd7[key] = var_535f7585;
	}
	else
	{
		self.var_29ffc8dc[key] = var_535f7585;
	}
}

/*
	Name: function_d81f9d2b
	Namespace: namespace_97ac1184
	Checksum: 0x424F4353
	Offset: 0x15AC0
	Size: 0x4C8
	Parameters: 0
	Flags: None
	Line Number: 4296
*/
function function_d81f9d2b()
{
	self endon("disconnect");
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
					foreach(data in self.var_4dd2bcd7)
					{
						if(!isdefined(data.type) || !isdefined(data.uimodel) || !isdefined(data.value))
						{
							continue;
						}
						util::setclientsysstate("UEM." + data.type, data.uimodel + "," + data.value, self);
						if(isdefined(data.Randomized))
						{
							self.var_4dd2bcd7[data.Randomized] = undefined;
						}
						else
						{
							self.var_4dd2bcd7[data.uimodel] = undefined;
						}
						if(isdefined(self.is_hotjoining) && self.is_hotjoining || tolower(getdvarstring("mapname")) == "zm_shoothouse" || tolower(getdvarstring("mapname")) == "zm_irondragon")
						{
							wait(0.1 * self getentitynumber() + 1);
							continue;
						}
						wait(0.07 * self getentitynumber() + 1);
					}
				}
				foreach(data in self.var_29ffc8dc)
				{
					if(self.var_4dd2bcd7.size > 0)
					{
						break;
					}
					if(!isdefined(data.type) || !isdefined(data.uimodel) || !isdefined(data.value))
					{
						continue;
					}
					util::setclientsysstate("UEM." + data.type, data.uimodel + "," + data.value, self);
					if(isdefined(data.Randomized))
					{
						self.var_29ffc8dc[data.Randomized] = undefined;
					}
					else
					{
						self.var_29ffc8dc[data.uimodel] = undefined;
					}
					if(isdefined(self.is_hotjoining) && self.is_hotjoining || tolower(getdvarstring("mapname")) == "zm_shoothouse" || tolower(getdvarstring("mapname")) == "zm_irondragon")
					{
						wait(0.25 * self getentitynumber() + 1);
						continue;
					}
					wait(0.06 * self getentitynumber() + 1);
				}
			}
			else
			{
				wait(1);
			}
		}
	}
	return;
	ERROR: Exception occured: Stack empty.
}

/*
	Name: function_8ee80db0
	Namespace: namespace_97ac1184
	Checksum: 0x424F4353
	Offset: 0x15F90
	Size: 0x128
	Parameters: 2
	Flags: Private
	Line Number: 4379
*/
function private function_8ee80db0(mode_name, var_d0243e5b)
{
	if(isdefined(level.var_3e85df60) && level.var_3e85df60)
	{
		setdvar("live_steam_server_name", "^8[UEM BAREBONES] | ^9" + mode_name + "^7 - ^3Round:^7 " + level.round_number);
		setdvar("live_steam_server_description", "^8[UEM BAREBONES]^7 " + var_d0243e5b + " \n^9- " + getplayers().size + ": Players");
	}
	else
	{
		setdvar("live_steam_server_name", "^8[UEM] | ^9" + mode_name + "^7 - ^3Round:^7 " + level.round_number);
		setdvar("live_steam_server_description", "^8[UEM]^7 " + var_d0243e5b + " \n^9- " + getplayers().size + ": Players");
	}
}

/*
	Name: function_c72f6f99
	Namespace: namespace_97ac1184
	Checksum: 0x424F4353
	Offset: 0x160C0
	Size: 0x16B8
	Parameters: 0
	Flags: Private
	Line Number: 4403
*/
function private function_c72f6f99()
{
	for(;;)
	{
		level waittill("end_of_round");
		if(!isdefined(level.var_d6ab4536))
		{
			level.var_d6ab4536 = [];
		}
		if(level flag::get("classic_enabled"))
		{
			level.var_d6ab4536["mode_name"] = "Classic Mode (BO1/WaW)";
			level.var_d6ab4536["mode_description"] = "Play like in the good old BO1/WaW days!";
			setdvar("motd", "!" + tolower(getdvarstring("mapname")) + "; Classic Mode (BO1/WaW);");
		}
		else if(level flag::get("gun_game_active"))
		{
			level.var_d6ab4536["mode_name"] = "Gun Game";
			level.var_d6ab4536["mode_description"] = "Let's play Gun Game!";
			setdvar("motd", "!" + tolower(getdvarstring("mapname")) + "; Gun Game;");
		}
		else
		{
			level.var_d6ab4536["mode_name"] = "Regular Mode";
			level.var_d6ab4536["mode_description"] = "Play as usual in regular mode.";
			setdvar("motd", "!" + tolower(getdvarstring("mapname")) + "; Regular Mode;");
		}
		level thread function_8ee80db0(level.var_d6ab4536["mode_name"], level.var_d6ab4536["mode_description"]);
		foreach(player in getplayers())
		{
			if(!(isdefined(player.var_c6452f46["leveling"]) && player.var_c6452f46["leveling"]))
			{
				continue;
			}
			if(tolower(getdvarstring("mapname")) == "zm_moon")
			{
				if(isdefined(level.ever_been_on_the_moon) && (isdefined(level.ever_been_on_the_moon) && level.ever_been_on_the_moon))
				{
					player.var_9ee9bcc6++;
				}
			}
			else
			{
				player.var_9ee9bcc6++;
			}
			player notify("hash_63cf7d21", "hc2_rounds", 1, 250, 100000);
			wait(0.05);
			if(player.var_9ee9bcc6 >= 35)
			{
				if(!(isdefined(player.var_db653ff8) && player.var_db653ff8))
				{
					if(player.pers["hc2_round_35_five_times"] < 5)
					{
						player.var_db653ff8 = 1;
						wait(0.05);
						player notify("hash_63cf7d21", "hc2_round_35_five_times", 1, 5, 1250, 1);
					}
				}
			}
			player.pers["total_rounds"]++;
			player thread function_7e18304e("spx_end_game_save_data", "end_game_total_rounds", 1, 0);
			player thread function_7e18304e("spx_save_data", "total_rounds", player.pers["total_rounds"], 0);
			if(player.var_9ee9bcc6 > player.pers["highest_round"])
			{
				player.pers["highest_round"] = player.var_9ee9bcc6 + 1;
				player thread function_7e18304e("spx_save_data", "highest_round", player.pers["highest_round"], 0);
			}
			level notify("hash_8c3d4295", player, "total_rounds", 1, 0);
			wait(0.05);
			if(player.var_9ee9bcc6 > player.pers[level.var_fcee636 + "_highest_round"])
			{
				level notify("hash_8c3d4295", player, "highest_round", player.var_9ee9bcc6 + 1, 1);
			}
			switch(player.var_9ee9bcc6)
			{
				case 9:
				{
					player notify("hash_79ef118b", "milestone_completed_round_10", undefined);
					player thread function_b3489bf5("^3" + player.playername + "^7 achieved ^9Round 10 Milestone");
					break;
				}
				case 14:
				{
					player notify("hash_79ef118b", "milestone_completed_round_15", undefined);
					player thread function_b3489bf5("^3" + player.playername + "^7 achieved ^9Round 15 Milestone");
					break;
				}
				case 19:
				{
					player notify("hash_79ef118b", "milestone_completed_round_20", undefined);
					player thread function_b3489bf5("^3" + player.playername + "^7 achieved ^9Round 20 Milestone");
					break;
				}
				case 24:
				{
					player notify("hash_79ef118b", "milestone_completed_round_25", undefined);
					player thread function_b3489bf5("^3" + player.playername + "^7 achieved ^9Round 25 Milestone");
					break;
				}
				case 29:
				{
					player notify("hash_79ef118b", "milestone_completed_round_30", undefined);
					player thread function_b3489bf5("^3" + player.playername + "^7 achieved ^9Round 30 Milestone");
					break;
				}
				case 34:
				{
					player notify("hash_79ef118b", "milestone_completed_round_35", undefined);
					player thread function_b3489bf5("^3" + player.playername + "^7 achieved ^9Round 35 Milestone");
					break;
				}
				case 39:
				{
					player notify("hash_79ef118b", "milestone_completed_round_40", undefined);
					player thread function_b3489bf5("^3" + player.playername + "^7 achieved ^9Round 40 Milestone");
					break;
				}
				case 44:
				{
					player notify("hash_79ef118b", "milestone_completed_round_45", undefined);
					player thread function_b3489bf5("^3" + player.playername + "^7 achieved ^9Round 45 Milestone");
					break;
				}
				case 49:
				{
					player notify("hash_79ef118b", "milestone_completed_round_50", undefined);
					player thread function_b3489bf5("^3" + player.playername + "^7 achieved ^9Round 50 Milestone");
					break;
				}
				case 54:
				{
					player notify("hash_79ef118b", "milestone_completed_round_55", undefined);
					player thread function_b3489bf5("^3" + player.playername + "^7 achieved ^9Round 55 Milestone");
					break;
				}
				case 59:
				{
					player notify("hash_79ef118b", "milestone_completed_round_60", undefined);
					player thread function_b3489bf5("^3" + player.playername + "^7 achieved ^9Round 60 Milestone");
					break;
				}
				case 64:
				{
					player notify("hash_79ef118b", "milestone_completed_round_65", undefined);
					player thread function_b3489bf5("^3" + player.playername + "^7 achieved ^9Round 65 Milestone");
					break;
				}
				case 69:
				{
					player notify("hash_79ef118b", "milestone_completed_round_70", undefined);
					player thread function_b3489bf5("^3" + player.playername + "^7 achieved ^9Round 70 Milestone");
					break;
				}
				case 74:
				{
					player notify("hash_79ef118b", "milestone_completed_round_75", undefined);
					player thread function_b3489bf5("^3" + player.playername + "^7 achieved ^9Round 75 Milestone");
					break;
				}
				case 79:
				{
					player notify("hash_79ef118b", "milestone_completed_round_80", undefined);
					player thread function_b3489bf5("^3" + player.playername + "^7 achieved ^9Round 80 Milestone");
					break;
				}
				case 84:
				{
					player notify("hash_79ef118b", "milestone_completed_round_85", undefined);
					player thread function_b3489bf5("^3" + player.playername + "^7 achieved ^9Round 85 Milestone");
					break;
				}
				case 89:
				{
					player notify("hash_79ef118b", "milestone_completed_round_90", undefined);
					player thread function_b3489bf5("^3" + player.playername + "^7 achieved ^9Round 90 Milestone");
					break;
				}
				case 94:
				{
					player notify("hash_79ef118b", "milestone_completed_round_95", undefined);
					player thread function_b3489bf5("^3" + player.playername + "^7 achieved ^9Round 95 Milestone");
					break;
				}
				case 99:
				{
					player notify("hash_79ef118b", "milestone_completed_round_100", undefined);
					player thread function_b3489bf5("^3" + player.playername + "^7 achieved ^9Round 100 Milestone");
					break;
				}
				case 104:
				{
					player notify("hash_79ef118b", "milestone_completed_round_105", undefined);
					player thread function_b3489bf5("^3" + player.playername + "^7 achieved ^9Round 105 Milestone");
					break;
				}
				case 109:
				{
					player notify("hash_79ef118b", "milestone_completed_round_110", undefined);
					player thread function_b3489bf5("^3" + player.playername + "^7 achieved ^9Round 110 Milestone");
					break;
				}
				case 114:
				{
					player notify("hash_79ef118b", "milestone_completed_round_115", undefined);
					player thread function_b3489bf5("^3" + player.playername + "^7 achieved ^9Round 115 Milestone");
					break;
				}
				case 119:
				{
					player notify("hash_79ef118b", "milestone_completed_round_120", undefined);
					player thread function_b3489bf5("^3" + player.playername + "^7 achieved ^9Round 120 Milestone");
					break;
				}
				case 124:
				{
					player notify("hash_79ef118b", "milestone_completed_round_125", undefined);
					player thread function_b3489bf5("^3" + player.playername + "^7 achieved ^9Round 125 Milestone");
					break;
				}
				case 129:
				{
					player notify("hash_79ef118b", "milestone_completed_round_130", undefined);
					player thread function_b3489bf5("^3" + player.playername + "^7 achieved ^9Round 130 Milestone");
					break;
				}
				case 134:
				{
					player notify("hash_79ef118b", "milestone_completed_round_135", undefined);
					player thread function_b3489bf5("^3" + player.playername + "^7 achieved ^9Round 135 Milestone");
					break;
				}
				case 139:
				{
					player notify("hash_79ef118b", "milestone_completed_round_140", undefined);
					player thread function_b3489bf5("^3" + player.playername + "^7 achieved ^9Round 140 Milestone");
					break;
				}
				case 144:
				{
					player notify("hash_79ef118b", "milestone_completed_round_145", undefined);
					player thread function_b3489bf5("^3" + player.playername + "^7 achieved ^9Round 145 Milestone");
					break;
				}
				case 149:
				{
					player notify("hash_79ef118b", "milestone_completed_round_150", undefined);
					player thread function_b3489bf5("^3" + player.playername + "^7 achieved ^9Round 150 Milestone");
					break;
				}
				case 154:
				{
					player notify("hash_79ef118b", "milestone_completed_round_155", undefined);
					player thread function_b3489bf5("^3" + player.playername + "^7 achieved ^9Round 155 Milestone");
					break;
				}
				case 159:
				{
					player notify("hash_79ef118b", "milestone_completed_round_160", undefined);
					player thread function_b3489bf5("^3" + player.playername + "^7 achieved ^9Round 160 Milestone");
					break;
				}
				case 164:
				{
					player notify("hash_79ef118b", "milestone_completed_round_165", undefined);
					player thread function_b3489bf5("^3" + player.playername + "^7 achieved ^9Round 165 Milestone");
					break;
				}
				case 169:
				{
					player notify("hash_79ef118b", "milestone_completed_round_170", undefined);
					player thread function_b3489bf5("^3" + player.playername + "^7 achieved ^9Round 170 Milestone");
					break;
				}
				case 174:
				{
					player notify("hash_79ef118b", "milestone_completed_round_175", undefined);
					player thread function_b3489bf5("^3" + player.playername + "^7 achieved ^9Round 175 Milestone");
					break;
				}
				case 179:
				{
					player notify("hash_79ef118b", "milestone_completed_round_180", undefined);
					player thread function_b3489bf5("^3" + player.playername + "^7 achieved ^9Round 180 Milestone");
					break;
				}
				case 184:
				{
					player notify("hash_79ef118b", "milestone_completed_round_185", undefined);
					player thread function_b3489bf5("^3" + player.playername + "^7 achieved ^9Round 185 Milestone");
					break;
				}
				case 189:
				{
					player notify("hash_79ef118b", "milestone_completed_round_190", undefined);
					player thread function_b3489bf5("^3" + player.playername + "^7 achieved ^9Round 190 Milestone");
					break;
				}
				case 194:
				{
					player notify("hash_79ef118b", "milestone_completed_round_195", undefined);
					player thread function_b3489bf5("^3" + player.playername + "^7 achieved ^9Round 195 Milestone");
					break;
				}
				case 199:
				{
					player notify("hash_79ef118b", "milestone_completed_round_200", undefined);
					player thread function_b3489bf5("^3" + player.playername + "^7 achieved ^9Round 200 Milestone");
					break;
				}
				case 204:
				{
					player notify("hash_79ef118b", "milestone_completed_round_205", undefined);
					player thread function_b3489bf5("^3" + player.playername + "^7 achieved ^9Round 205 Milestone");
					break;
				}
				case 209:
				{
					player notify("hash_79ef118b", "milestone_completed_round_210", undefined);
					player thread function_b3489bf5("^3" + player.playername + "^7 achieved ^9Round 210 Milestone");
					break;
				}
				case 214:
				{
					player notify("hash_79ef118b", "milestone_completed_round_215", undefined);
					player thread function_b3489bf5("^3" + player.playername + "^7 achieved ^9Round 215 Milestone");
					break;
				}
				case 219:
				{
					player notify("hash_79ef118b", "milestone_completed_round_220", undefined);
					player thread function_b3489bf5("^3" + player.playername + "^7 achieved ^9Round 220 Milestone");
					break;
				}
				case 224:
				{
					player notify("hash_79ef118b", "milestone_completed_round_225", undefined);
					player thread function_b3489bf5("^3" + player.playername + "^7 achieved ^9Round 225 Milestone");
					break;
				}
				case 229:
				{
					player notify("hash_79ef118b", "milestone_completed_round_230", undefined);
					player thread function_b3489bf5("^3" + player.playername + "^7 achieved ^9Round 230 Milestone");
					break;
				}
				case 244:
				{
					player notify("hash_79ef118b", "milestone_completed_round_245", undefined);
					player thread function_b3489bf5("^3" + player.playername + "^7 achieved ^9Round 245 Milestone");
					break;
				}
				case 249:
				{
					player notify("hash_79ef118b", "milestone_completed_round_250", undefined);
					player thread function_b3489bf5("^3" + player.playername + "^7 achieved ^9Round 250 Milestone");
					break;
				}
				case 254:
				{
					player notify("hash_79ef118b", "milestone_completed_round_255", undefined);
					player thread function_b3489bf5("^3" + player.playername + "^7 achieved ^9Round 255 Milestone");
					break;
				}
			}
			player notify("hash_79ef118b", "round_survived", undefined);
			wait(0.05);
			level thread function_231f215a();
		}
	}
}

/*
	Name: function_b3e51832
	Namespace: namespace_97ac1184
	Checksum: 0x424F4353
	Offset: 0x17780
	Size: 0x78
	Parameters: 0
	Flags: None
	Line Number: 4784
*/
function function_b3e51832()
{
	self notify("hash_7bd8175e");
	self endon("hash_7bd8175e");
	if(self.var_ade72574 >= 3)
	{
		self notify("hash_63cf7d21", "hc2_rapidkills", 1, 2500, 75000);
		self.var_ade72574 = 0;
	}
	wait(0.7);
	self.var_ade72574 = 0;
}

/*
	Name: function_9da0752e
	Namespace: namespace_97ac1184
	Checksum: 0x424F4353
	Offset: 0x17800
	Size: 0x78
	Parameters: 0
	Flags: None
	Line Number: 4807
*/
function function_9da0752e()
{
	self notify("hash_35e4614a");
	self endon("hash_35e4614a");
	if(self.var_39a05cc0 >= 2)
	{
		self notify("hash_63cf7d21", "hc2_consecutive_headshots", 1, 1500, 75000);
		self.var_39a05cc0 = 0;
	}
	wait(0.7);
	self.var_39a05cc0 = 0;
}

/*
	Name: function_b01c4441
	Namespace: namespace_97ac1184
	Checksum: 0x424F4353
	Offset: 0x17880
	Size: 0x8F8
	Parameters: 1
	Flags: None
	Line Number: 4830
*/
function function_b01c4441(e_attacker)
{
	e_attacker notify("hash_63cf7d21", "hc2_kills", 1, 25000, 100000);
	if(isdefined(e_attacker.var_f9d1811b["kills"]))
	{
		e_attacker.var_f9d1811b["kills"]++;
	}
	wait(0.05);
	if(e_attacker playerads() >= 0.9)
	{
		e_attacker notify("hash_63cf7d21", "hc2_ads_kills", 1, 2500, 50000);
	}
	wait(0.05);
	if(e_attacker getstance() == "crouch" || e_attacker getstance() == "prone")
	{
		e_attacker notify("hash_63cf7d21", "hc2_crouch_kills", 1, 750, 50000);
	}
	wait(0.05);
	if(!isdefined(e_attacker.var_ade72574))
	{
		e_attacker.var_ade72574 = 0;
	}
	wait(0.05);
	if(isdefined(e_attacker.var_ade72574))
	{
		e_attacker.var_ade72574++;
		e_attacker thread function_b3e51832();
	}
	if(issubstr(self.damageWeapon.name, "sniper_"))
	{
		e_attacker notify("hash_63cf7d21", "hc2_sniper_kills", 1, 1500, 75000);
	}
	wait(0.05);
	if(issubstr(self.damageWeapon.name, "pistol_"))
	{
		e_attacker notify("hash_63cf7d21", "hc2_pistol_kills", 1, 1000, 50000);
	}
	wait(0.05);
	if(issubstr(self.damageWeapon.name, "ar_") || (self.damageWeapon.name == "smg_versatile" || self.damageWeapon.name == "smg_versatile_upgraded"))
	{
		e_attacker notify("hash_63cf7d21", "hc2_ar_kills", 1, 2500, 75000);
	}
	wait(0.05);
	if(issubstr(self.damageWeapon.name, "shotgun_"))
	{
		e_attacker notify("hash_63cf7d21", "hc2_shotgun_kills", 1, 1500, 75000);
	}
	wait(0.05);
	if(issubstr(self.damageWeapon.name, "smg_") && (self.damageWeapon.name != "smg_versatile" || self.damageWeapon.name != "smg_versatile_upgraded"))
	{
		e_attacker notify("hash_63cf7d21", "hc2_smg_kills", 1, 2500, 750, 1);
	}
	wait(0.05);
	if(issubstr(self.damageWeapon.name, "launcher_"))
	{
		e_attacker notify("hash_63cf7d21", "hc2_explosive_kills", 1, 2500, 750, 1);
	}
	wait(0.05);
	if(issubstr(self.damageWeapon.name, "lmg_"))
	{
		e_attacker notify("hash_63cf7d21", "hc2_lmg_kills", 1, 3000, 75000);
	}
	wait(0.05);
	if(e_attacker playerads() <= 0.1 && (self.damageWeapon != level.zombie_powerup_weapon["minigun"] || issubstr(self.damageWeapon.name, "minigun")))
	{
		e_attacker notify("hash_63cf7d21", "hc2_hipfire_kills", 1, 450, 75000);
	}
	wait(0.05);
	if(self.damageWeapon.var_8c86d7b3 || self.damageWeapon.var_7e163cf8 || zm_equipment::is_equipment(self.damageWeapon) || zm_utility::is_placeable_mine(self.damageWeapon))
	{
		e_attacker notify("hash_63cf7d21", "hc2_explosive_kills", 1, 2500, 10000);
		wait(0.05);
		return;
	}
	if(self.damageMod === "MOD_MELEE" || self.damageMod === "MOD_MELEE_ASSASSINATE" || self.damageMod === "MOD_MELEE_WEAPON_BUTT")
	{
		e_attacker notify("hash_63cf7d21", "hc2_melee_kills", 1, 1500, 50000);
		if(isdefined(e_attacker.var_f9d1811b["melee_kills"]))
		{
			e_attacker.var_f9d1811b["melee_kills"]++;
		}
	}
	wait(0.05);
	if(self.damagelocation === "head" && (!(isdefined(self.isdog) && self.isdog)) || (self.damagelocation === "helmet" && (!(isdefined(self.isdog) && self.isdog))) || (self.damageMod === "MOD_HEAD_SHOT" && (!(isdefined(self.isdog) && self.isdog))))
	{
		e_attacker notify("hash_63cf7d21", "hc2_headshots", 1, 6000, 75000);
		wait(0.05);
		e_attacker notify("hash_63cf7d21", "hc2_single_game_headshots", 1, 500, 75000);
		if(isdefined(e_attacker.var_f9d1811b["headshots"]))
		{
			e_attacker.var_f9d1811b["headshots"]++;
		}
		if(!isdefined(e_attacker.var_39a05cc0))
		{
			e_attacker.var_39a05cc0 = 0;
		}
		wait(0.05);
		if(isdefined(e_attacker.var_39a05cc0))
		{
			e_attacker.var_39a05cc0++;
			e_attacker thread function_9da0752e();
		}
	}
	wait(0.05);
	if(zm_weapons::is_weapon_upgraded(self.damageWeapon))
	{
		e_attacker notify("hash_63cf7d21", "hc2_upgraded_kills", 1, 5000, 75000);
	}
	wait(0.05);
	if(distance(self.origin, e_attacker.origin) > 700 && zm_weapons::is_weapon_upgraded(self.damageWeapon))
	{
		e_attacker notify("hash_63cf7d21", "hc2_longshot_pap_kills", 1, 1500, 75000);
	}
	wait(0.05);
	if(e_attacker.var_f9d1811b["kills"] >= 1000 && e_attacker.var_f9d1811b["melee_kills"] >= 100 && e_attacker.var_f9d1811b["headshots"] >= 250)
	{
		e_attacker notify("hash_63cf7d21", "hc2_perfect_game", 1, 1, 75000);
	}
}

/*
	Name: function_7279da56
	Namespace: namespace_97ac1184
	Checksum: 0x424F4353
	Offset: 0x18180
	Size: 0x1BE0
	Parameters: 1
	Flags: Private
	Line Number: 4960
*/
function private function_7279da56(e_attacker)
{
	if(!isdefined(e_attacker) || !isplayer(e_attacker) || (isdefined(self.nuked) && self.nuked))
	{
		return;
	}
	if(!(isdefined(e_attacker.var_c6452f46["leveling"]) && e_attacker.var_c6452f46["leveling"]))
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
					case "keeper":
					{
						archetype = 1;
						player notify("hash_79ef118b", "zombie_keeper_assist", undefined, self);
						break;
					}
					case "keeper_companion":
					{
						archetype = 1;
						player notify("hash_79ef118b", "zombie_keeper_assist", undefined, self);
						break;
					}
					case "zod_companion":
					{
						archetype = 1;
						player notify("hash_79ef118b", "zombie_keeper_assist", undefined, self);
						break;
					}
					case "apothicon_fury":
					{
						archetype = 1;
						player notify("hash_79ef118b", "zombie_apothicon_assist", undefined, self);
						break;
					}
					case "parasite":
					{
						archetype = 1;
						player notify("hash_79ef118b", "zombie_parasite_assist", undefined, self);
						break;
					}
					case "raps":
					{
						archetype = 1;
						player notify("hash_79ef118b", "zombie_raps_assist", undefined, self);
						break;
					}
					case "spider":
					{
						archetype = 1;
						player notify("hash_79ef118b", "zombie_spider_assist", undefined, self);
						break;
					}
					case "mechz":
					{
						archetype = 1;
						player notify("hash_79ef118b", "zombie_mechz_assist", undefined, self);
						break;
					}
					case "zombie_quad":
					{
						archetype = 1;
						player notify("hash_79ef118b", "zombie_zombiequad_assist", undefined, self);
						break;
					}
					case "margwa":
					{
						archetype = 1;
						player notify("hash_79ef118b", "zombie_margwa_assist", undefined, self);
						break;
					}
					case "thrasher":
					{
						archetype = 1;
						player notify("hash_79ef118b", "zombie_thrasher_assist", undefined, self);
						break;
					}
					case "raz":
					{
						archetype = 1;
						player notify("hash_79ef118b", "zombie_raz_assist", undefined, self);
						break;
					}
					case "monkey":
					{
						archetype = 1;
						player notify("hash_79ef118b", "zombie_monkey_assist", undefined, self);
						break;
					}
					case "astronaut":
					{
						archetype = 1;
						player notify("hash_79ef118b", "zombie_astronaut_assist", undefined, self);
						break;
					}
					case "undead_saint":
					{
						archetype = 1;
						player notify("hash_79ef118b", "zombie_saint_assist", undefined, self);
						break;
					}
					case "uem_ghost":
					{
						archetype = 1;
						player notify("hash_79ef118b", "zombie_ghost_assist", undefined, self);
						break;
					}
				}
				if(isdefined(self.isdog) && self.isdog)
				{
					player notify("hash_79ef118b", "zombie_dog_assist", undefined, self);
				}
				else
				{
					player notify("hash_79ef118b", "zombie_regular_assist", undefined, self);
				}
				if(self.animname == "napalm_zombie")
				{
					player notify("hash_79ef118b", "zombie_napalm_assist", undefined, self);
				}
				if(self.animname == "sonic_zombie")
				{
					player notify("hash_79ef118b", "zombie_shrieker_assist", undefined, self);
				}
				player.pers["assists"]++;
				player thread function_7e18304e("spx_save_data", "assists", player.pers["assists"], 0);
			}
		}
	}
	e_attacker thread function_7e18304e("spx_end_game_save_data", "end_game_total_kills", 1, 0);
	e_attacker thread function_7e18304e("spx_save_data", "kills", e_attacker.pers["kills"], 0);
	level notify("hash_8c3d4295", e_attacker, "total_kills", 1, 0);
	wait(0.05);
	if(isdefined(level.var_c181264f) && level.var_c181264f)
	{
		e_attacker.pers["gungame_kills"]++;
		e_attacker thread function_7e18304e("spx_save_data", "gungame_kills", e_attacker.pers["gungame_kills"], 0);
	}
	self thread function_b01c4441(e_attacker);
	e_attacker.pers["milestone_kills"]++;
	switch(e_attacker.pers["milestone_kills"])
	{
		case 500:
		{
			e_attacker notify("hash_79ef118b", "milestone_completed_kills_500", undefined);
			break;
		}
		case 750:
		{
			e_attacker notify("hash_79ef118b", "milestone_completed_kills_750", undefined);
			break;
		}
		case 1000:
		{
			e_attacker notify("hash_79ef118b", "milestone_completed_kills_1000", undefined);
			break;
		}
		case 1500:
		{
			e_attacker notify("hash_79ef118b", "milestone_completed_kills_1500", undefined);
			break;
		}
		case 2000:
		{
			e_attacker notify("hash_79ef118b", "milestone_completed_kills_2000", undefined);
			break;
		}
		case 3000:
		{
			e_attacker notify("hash_79ef118b", "milestone_completed_kills_3000", undefined);
			break;
		}
		case 4000:
		{
			e_attacker notify("hash_79ef118b", "milestone_completed_kills_4000", undefined);
			break;
		}
		case 5000:
		{
			e_attacker notify("hash_79ef118b", "milestone_completed_kills_5000", undefined);
			break;
		}
		case 7500:
		{
			e_attacker notify("hash_79ef118b", "milestone_completed_kills_7500", undefined);
			break;
		}
		case 10000:
		{
			e_attacker notify("hash_79ef118b", "milestone_completed_kills_10000", undefined);
			break;
		}
		case 15000:
		{
			e_attacker notify("hash_79ef118b", "milestone_completed_kills_15000", undefined);
			break;
		}
		case 20000:
		{
			e_attacker notify("hash_79ef118b", "milestone_completed_kills_20000", undefined);
			break;
		}
		case 30000:
		{
			e_attacker notify("hash_79ef118b", "milestone_completed_kills_30000", undefined);
			break;
		}
		case 40000:
		{
			e_attacker notify("hash_79ef118b", "milestone_completed_kills_40000", undefined);
			break;
		}
		case 50000:
		{
			e_attacker notify("hash_79ef118b", "milestone_completed_kills_50000", undefined);
			break;
		}
		case 75000:
		{
			e_attacker notify("hash_79ef118b", "milestone_completed_kills_75000", undefined);
			break;
		}
		case 100000:
		{
			e_attacker notify("hash_79ef118b", "milestone_completed_kills_100000", undefined);
			break;
		}
	}
	switch(self.archetype)
	{
		case "keeper":
		{
			e_attacker thread function_7e18304e("spx_end_game_save_data", "end_game_special_kills", 1, 0);
			e_attacker.pers["special_kills"]++;
			e_attacker notify("hash_79ef118b", "zombie_keeper_kill", undefined);
			var_c5f85509 = 1;
			return;
		}
		case "keeper_companion":
		{
			e_attacker thread function_7e18304e("spx_end_game_save_data", "end_game_special_kills", 1, 0);
			e_attacker.pers["special_kills"]++;
			archetype = 1;
			e_attacker notify("hash_79ef118b", "zombie_keeper_kill", undefined);
			var_c5f85509 = 1;
			break;
		}
		case "zod_companion":
		{
			e_attacker thread function_7e18304e("spx_end_game_save_data", "end_game_special_kills", 1, 0);
			e_attacker.pers["special_kills"]++;
			archetype = 1;
			e_attacker notify("hash_79ef118b", "zombie_keeper_kill", undefined);
			var_c5f85509 = 1;
			break;
		}
		case "apothicon_fury":
		{
			e_attacker thread function_7e18304e("spx_end_game_save_data", "end_game_special_kills", 1, 0);
			e_attacker.pers["special_kills"]++;
			e_attacker notify("hash_79ef118b", "zombie_apothicon_kill", undefined);
			var_c5f85509 = 1;
			return;
		}
		case "parasite":
		{
			e_attacker thread function_7e18304e("spx_end_game_save_data", "end_game_special_kills", 1, 0);
			e_attacker.pers["special_kills"]++;
			e_attacker notify("hash_79ef118b", "zombie_parasite_kill", undefined);
			var_c5f85509 = 1;
			return;
		}
		case "raps":
		{
			e_attacker thread function_7e18304e("spx_end_game_save_data", "end_game_special_kills", 1, 0);
			e_attacker.pers["special_kills"]++;
			e_attacker notify("hash_79ef118b", "zombie_raps_kill", undefined);
			var_c5f85509 = 1;
			return;
		}
		case "spider":
		{
			e_attacker thread function_7e18304e("spx_end_game_save_data", "end_game_special_kills", 1, 0);
			e_attacker.pers["special_kills"]++;
			e_attacker notify("hash_79ef118b", "zombie_spider_kill", undefined);
			var_c5f85509 = 1;
			return;
		}
		case "mechz":
		{
			e_attacker thread function_7e18304e("spx_end_game_save_data", "end_game_special_kills", 1, 0);
			e_attacker.pers["special_kills"]++;
			e_attacker notify("hash_79ef118b", "zombie_mechz_kill", undefined);
			var_c5f85509 = 1;
			return;
		}
		case "zombie_quad":
		{
			e_attacker thread function_7e18304e("spx_end_game_save_data", "end_game_special_kills", 1, 0);
			e_attacker.pers["special_kills"]++;
			e_attacker notify("hash_79ef118b", "zombie_zombiequad_kill", undefined);
			var_c5f85509 = 1;
			return;
		}
		case "margwa":
		{
			e_attacker thread function_7e18304e("spx_end_game_save_data", "end_game_special_kills", 1, 0);
			e_attacker.pers["special_kills"]++;
			e_attacker notify("hash_79ef118b", "zombie_margwa_kill", undefined);
			var_c5f85509 = 1;
			return;
		}
		case "thrasher":
		{
			e_attacker thread function_7e18304e("spx_end_game_save_data", "end_game_special_kills", 1, 0);
			e_attacker.pers["special_kills"]++;
			e_attacker notify("hash_79ef118b", "zombie_thrasher_kill", undefined);
			var_c5f85509 = 1;
			return;
		}
		case "raz":
		{
			e_attacker thread function_7e18304e("spx_end_game_save_data", "end_game_special_kills", 1, 0);
			e_attacker.pers["special_kills"]++;
			e_attacker notify("hash_79ef118b", "zombie_raz_kill", undefined);
			var_c5f85509 = 1;
			return;
		}
		case "monkey":
		{
			e_attacker thread function_7e18304e("spx_end_game_save_data", "end_game_special_kills", 1, 0);
			e_attacker.pers["special_kills"]++;
			e_attacker notify("hash_79ef118b", "zombie_monkey_kill", undefined);
			var_c5f85509 = 1;
			return;
		}
		case "astronaut":
		{
			e_attacker thread function_7e18304e("spx_end_game_save_data", "end_game_special_kills", 1, 0);
			e_attacker.pers["special_kills"]++;
			e_attacker notify("hash_79ef118b", "zombie_astronaut_kill", undefined);
			var_c5f85509 = 1;
			return;
		}
		case "undead_saint":
		{
			e_attacker thread function_7e18304e("spx_end_game_save_data", "end_game_special_kills", 1, 0);
			e_attacker.pers["special_kills"]++;
			player notify("hash_79ef118b", "zombie_saint_kill", undefined);
			var_c5f85509 = 1;
			break;
		}
		case "uem_ghost":
		{
			e_attacker thread function_7e18304e("spx_end_game_save_data", "end_game_special_kills", 1, 0);
			e_attacker.pers["special_kills"]++;
			player notify("hash_79ef118b", "zombie_ghost_kill", undefined);
			var_c5f85509 = 1;
			break;
		}
	}
	if(self.animname == "napalm_zombie")
	{
		e_attacker.pers["special_kills"]++;
		e_attacker thread function_7e18304e("spx_end_game_save_data", "end_game_special_kills", 1, 0);
		e_attacker notify("hash_79ef118b", "zombie_napalm_kill", undefined);
		var_c5f85509 = 1;
		return;
	}
	if(self.animname == "sonic_zombie")
	{
		e_attacker.pers["special_kills"]++;
		e_attacker thread function_7e18304e("spx_end_game_save_data", "end_game_special_kills", 1, 0);
		e_attacker notify("hash_79ef118b", "zombie_shrieker_kill", undefined);
		var_c5f85509 = 1;
		return;
	}
	if(self.damageMod === "MOD_MELEE" || self.damageMod === "MOD_MELEE_ASSASSINATE" || self.damageMod === "MOD_MELEE_WEAPON_BUTT")
	{
		e_attacker.pers["melee_kills"]++;
		e_attacker thread function_7e18304e("spx_end_game_save_data", "end_game_melee_kills", 1, 0);
		e_attacker thread function_7e18304e("spx_save_data", "melee_kills", e_attacker.pers["melee_kills"], 0);
		if(!(isdefined(self.isdog) && self.isdog) || (!(isdefined(var_c5f85509) && var_c5f85509)))
		{
			e_attacker notify("hash_79ef118b", "zombie_melee_kill", undefined, self);
		}
		else
		{
			e_attacker notify("hash_79ef118b", "zombie_melee_kill", undefined);
			return;
		}
	}
	if(self.damageWeapon.var_8c86d7b3 || self.damageWeapon.var_7e163cf8 || zm_equipment::is_equipment(self.damageWeapon) || zm_utility::is_placeable_mine(self.damageWeapon))
	{
		e_attacker.pers["equipment_kills"]++;
		e_attacker thread function_7e18304e("spx_end_game_save_data", "end_game_equipment_kills", 1, 0);
		e_attacker thread function_7e18304e("spx_save_data", "equipment_kills", e_attacker.pers["equipment_kills"], 0);
		if(!(isdefined(self.isdog) && self.isdog) || (!(isdefined(var_c5f85509) && var_c5f85509)))
		{
			e_attacker notify("hash_79ef118b", "zombie_equipment_kill", undefined);
		}
		else
		{
			e_attacker notify("hash_79ef118b", "zombie_equipment_kill", undefined);
			return;
		}
	}
	if(self.damagelocation === "head" && (!(isdefined(self.isdog) && self.isdog)) || (self.damagelocation === "helmet" && (!(isdefined(self.isdog) && self.isdog))) || (self.damageMod === "MOD_HEAD_SHOT" && (!(isdefined(self.isdog) && self.isdog))))
	{
		e_attacker.pers["headshots"]++;
		e_attacker thread function_7e18304e("spx_save_data", "headshots", e_attacker.pers["headshots"], 0);
		if(isdefined(level.var_c181264f) && level.var_c181264f)
		{
			e_attacker.pers["gungame_headshots"]++;
			e_attacker thread function_7e18304e("spx_save_data", "gungame_headshots", e_attacker.pers["gungame_headshots"], 0);
		}
		wait(0.05);
		level notify("hash_8c3d4295", e_attacker, "total_headshots", 1, 0);
		e_attacker thread function_7e18304e("spx_end_game_save_data", "end_game_headshot_kills", 1, 0);
		e_attacker.pers["milestone_headshots"]++;
		switch(e_attacker.pers["milestone_headshots"])
		{
			case 250:
			{
				e_attacker notify("hash_79ef118b", "milestone_completed_headshots_250", undefined);
				break;
			}
			case 500:
			{
				e_attacker notify("hash_79ef118b", "milestone_completed_headshots_500", undefined);
				break;
			}
			case 750:
			{
				e_attacker notify("hash_79ef118b", "milestone_completed_headshots_750", undefined);
				break;
			}
			case 1000:
			{
				e_attacker notify("hash_79ef118b", "milestone_completed_headshots_1000", undefined);
				break;
			}
			case 1250:
			{
				e_attacker notify("hash_79ef118b", "milestone_completed_headshots_1250", undefined);
				break;
			}
			case 1500:
			{
				e_attacker notify("hash_79ef118b", "milestone_completed_headshots_1500", undefined);
				break;
			}
			case 1750:
			{
				e_attacker notify("hash_79ef118b", "milestone_completed_headshots_1750", undefined);
				break;
			}
			case 2000:
			{
				e_attacker notify("hash_79ef118b", "milestone_completed_headshots_2000", undefined);
				break;
			}
			case 2500:
			{
				e_attacker notify("hash_79ef118b", "milestone_completed_headshots_2500", undefined);
				break;
			}
			case 3000:
			{
				e_attacker notify("hash_79ef118b", "milestone_completed_headshots_3000", undefined);
				break;
			}
			case 4000:
			{
				e_attacker notify("hash_79ef118b", "milestone_completed_headshots_4000", undefined);
				break;
			}
			case 5000:
			{
				e_attacker notify("hash_79ef118b", "milestone_completed_headshots_5000", undefined);
				break;
			}
			case 7500:
			{
				e_attacker notify("hash_79ef118b", "milestone_completed_headshots_7500", undefined);
				break;
			}
			case 10000:
			{
				e_attacker notify("hash_79ef118b", "milestone_completed_headshots_10000", undefined);
				break;
			}
			case 20000:
			{
				e_attacker notify("hash_79ef118b", "milestone_completed_headshots_20000", undefined);
				break;
			}
			case 30000:
			{
				e_attacker notify("hash_79ef118b", "milestone_completed_headshots_30000", undefined);
				break;
			}
			case 40000:
			{
				e_attacker notify("hash_79ef118b", "milestone_completed_headshots_40000", undefined);
				break;
			}
			case 50000:
			{
				e_attacker notify("hash_79ef118b", "milestone_completed_headshots_50000", undefined);
				break;
			}
		}
		if(!(isdefined(self.isdog) && self.isdog) || (!(isdefined(var_c5f85509) && var_c5f85509)))
		{
			if(e_attacker getstance() == "prone")
			{
				e_attacker notify("hash_79ef118b", "zombie_prone_critical_kill", undefined, self);
			}
			else if(e_attacker IsSliding())
			{
				e_attacker notify("hash_79ef118b", "zombie_sliding_critical_kill", undefined, self);
			}
			else if(distance(self.origin, e_attacker.origin) > 700)
			{
				e_attacker notify("hash_79ef118b", "zombie_longshot_critical_kill", undefined, self);
			}
			else
			{
				e_attacker notify("hash_79ef118b", "zombie_critical_kill", undefined, self);
			}
		}
		else
		{
			e_attacker notify("hash_79ef118b", "zombie_critical_kill", undefined);
			return;
		}
	}
	if(isdefined(self.isdog) && self.isdog)
	{
		e_attacker.pers["dog_kills"]++;
		e_attacker.pers["special_kills"]++;
		e_attacker thread function_7e18304e("spx_end_game_save_data", "end_game_dog_kills", 1, 0);
		e_attacker thread function_7e18304e("spx_end_game_save_data", "end_game_special_kills", 1, 0);
		e_attacker thread function_7e18304e("spx_save_data", "dog_kills", e_attacker.pers["dog_kills"], 0);
		e_attacker notify("hash_79ef118b", "zombie_dog_kill", undefined);
		return;
	}
	else
	{
		e_attacker.pers["zombie_kills"]++;
		e_attacker thread function_7e18304e("spx_save_data", "zombie_kills", e_attacker.pers["zombie_kills"], 0);
		if(e_attacker getstance() == "prone")
		{
			e_attacker notify("hash_79ef118b", "zombie_prone_kill", undefined, self);
		}
		else if(e_attacker IsSliding())
		{
			e_attacker notify("hash_79ef118b", "zombie_sliding_kill", undefined, self);
		}
		else if(distance(self.origin, e_attacker.origin) > 700)
		{
			e_attacker notify("hash_79ef118b", "zombie_longshot_kill", undefined, self);
		}
		else
		{
			e_attacker notify("hash_79ef118b", "zombie_regular_kill", undefined, self);
			return;
		}
	}
	if(e_attacker hasperk("specialty_immunetriggerbetty"))
	{
		if(!(isdefined(self.no_damage_points) && self.no_damage_points) && isdefined(e_attacker))
		{
			chance = randomintrange(1, 100);
			if(chance <= 25)
			{
				e_attacker zm_score::player_add_points("death", undefined, undefined, 0, undefined, self.damageWeapon);
			}
		}
	}
	e_attacker thread function_7e18304e("spx_save_data", "special_kills", e_attacker.pers["special_kills"], 0);
	return;
}

/*
	Name: function_8a7f57f
	Namespace: namespace_97ac1184
	Checksum: 0x424F4353
	Offset: 0x19D68
	Size: 0xA0
	Parameters: 7
	Flags: None
	Line Number: 5563
*/
function function_8a7f57f(var_d7d24b28, var_9105bf5d, text1, var_ef8a059e, var_2c50d11e, var_52534b87, victim)
{
	if(!isdefined(var_d7d24b28))
	{
		var_d7d24b28 = "Hello";
	}
	if(!isdefined(var_9105bf5d))
	{
		var_9105bf5d = "^7";
	}
	if(!isdefined(text1))
	{
		text1 = "World";
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
	Offset: 0x19E10
	Size: 0x28
	Parameters: 1
	Flags: None
	Line Number: 5593
*/
function function_b3489bf5(text)
{
	iprintln(text);
}

/*
	Name: function_7e18304e
	Namespace: namespace_97ac1184
	Checksum: 0x424F4353
	Offset: 0x19E40
	Size: 0x330
	Parameters: 11
	Flags: None
	Line Number: 5608
*/
function function_7e18304e(type, var_bd058c01, value, overwrite, priority, var_363c7886, var_e0ea0acc, var_52f17a07, var_2ceeff9e, var_6ee29b91, var_48e02128)
{
	if(!isdefined(overwrite))
	{
		overwrite = 0;
	}
	if(!isdefined(priority))
	{
		priority = 0;
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
		if(!isdefined(value))
		{
			value = 0;
		}
		if(!isdefined(self.var_84298650))
		{
			self.var_84298650 = [];
		}
		if(!isdefined(self.var_1c3ca2eb))
		{
			self.var_1c3ca2eb = [];
		}
		key = var_bd058c01;
		if(isdefined(var_363c7886) && var_363c7886)
		{
			key = var_bd058c01 + randomintrange(0, 1000000);
		}
		if(isdefined(self.var_84298650[var_bd058c01]))
		{
			self.var_84298650[var_bd058c01].value = value;
		}
		else
		{
			var_535f7585 = spawnstruct();
			var_535f7585.type = type;
			var_535f7585.var_bd058c01 = var_bd058c01;
			var_535f7585.value = value;
			var_535f7585.var_e0ea0acc = var_e0ea0acc;
			var_535f7585.var_52f17a07 = var_52f17a07;
			var_535f7585.var_2ceeff9e = var_2ceeff9e;
			var_535f7585.var_6ee29b91 = var_6ee29b91;
			var_535f7585.var_48e02128 = var_48e02128;
			var_535f7585.overwrite = overwrite;
			var_535f7585.priority = priority;
			if(isdefined(var_363c7886) && var_363c7886)
			{
				var_535f7585.Randomized = key;
			}
			if(isdefined(priority) && priority)
			{
				self.var_1c3ca2eb[key] = var_535f7585;
			}
			else
			{
				self.var_84298650[key] = var_535f7585;
			}
		}
	}
}

/*
	Name: function_afb49977
	Namespace: namespace_97ac1184
	Checksum: 0x424F4353
	Offset: 0x1A178
	Size: 0xA88
	Parameters: 0
	Flags: None
	Line Number: 5704
*/
function function_afb49977()
{
	self endon("disconnect");
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
					foreach(data in self.var_1c3ca2eb)
					{
						if(!isdefined(data.type) || !isdefined(data.var_bd058c01) || !isdefined(data.value))
						{
							continue;
						}
						if(data.type == "damage_3d")
						{
							self luinotifyevent(&"damage_3d", 6, int(data.value), data.var_e0ea0acc, int(data.var_52f17a07), int(data.var_2ceeff9e), int(data.var_6ee29b91), int(data.var_48e02128));
						}
						else if(data.type == "player_data")
						{
							self luinotifyevent(&"leveling_data", 6, data.value, getplayers()[data.value].var_b74a3cd1["prestige"], getplayers()[data.value].var_b74a3cd1["level"], getplayers()[data.value].var_b74a3cd1["xp"], int(getplayers()[data.value] function_4c2abd48(getplayers()[data.value].var_b74a3cd1["level"])["xp_needed"]), int(getplayers()[data.value].var_b74a3cd1["xp_multiplier"]));
						}
						if(isdefined(data.Randomized))
						{
							self.var_1c3ca2eb[data.Randomized] = undefined;
						}
						else
						{
							self.var_1c3ca2eb[data.var_bd058c01] = undefined;
						}
						if(isdefined(self.is_hotjoining) && self.is_hotjoining || tolower(getdvarstring("mapname")) == "zm_shoothouse" || tolower(getdvarstring("mapname")) == "zm_irondragon")
						{
							wait(0.25 * self getentitynumber() + 1);
							continue;
						}
						wait(0.06 * self getentitynumber() + 1);
					}
				}
				foreach(data in self.var_84298650)
				{
					if(self.var_1c3ca2eb.size > 0)
					{
						break;
					}
					if(!isdefined(data.type) || !isdefined(data.var_bd058c01) || !isdefined(data.value))
					{
						continue;
					}
					if(data.type == "spx_save_data")
					{
						self luinotifyevent(&"spx_save_data", 2, int(level.var_ac46587c[data.var_bd058c01]), int(data.value));
					}
					else if(data.type == "leveling_data")
					{
						var_ca7a8609 = self function_4c2abd48(self.var_b74a3cd1["level"]);
						self luinotifyevent(&"leveling_data", 5, self getentitynumber(), self.var_b74a3cd1["prestige"], self.var_b74a3cd1["level"], self.var_b74a3cd1["xp"], int(var_ca7a8609["xp_needed"]));
					}
					else if(data.type == "team_leveling_data")
					{
					}
					else if(data.type == "ZMBU_info")
					{
						var_ca7a8609 = self function_7da4fcdb(self.var_b74a3cd1["brutal_rank"]);
						self luinotifyevent(&"ZMBU_info", 4, &"ZM_MINECRAFT_BRUTAL_RANK", self.var_da7682e5, self.var_b74a3cd1["brutal_xp"], int(var_ca7a8609["xp_needed"]));
					}
					else if(data.type == "spx_end_game_save_data")
					{
						if(isdefined(data.overwrite) && data.overwrite)
						{
							self.pers[data.var_bd058c01] = data.value;
						}
						else
						{
							self.pers[data.var_bd058c01] = self.pers[data.var_bd058c01] + data.value;
						}
						self luinotifyevent(&"spx_end_game_save_data", 2, int(level.var_5e620cb1[data.var_bd058c01]), int(self.pers[data.var_bd058c01]));
					}
					else if(data.type == "spx_maps_save_data")
					{
						self luinotifyevent(&"spx_maps_save_data", 2, int(level.var_c3e446a[data.var_bd058c01]), int(data.value));
					}
					if(isdefined(data.Randomized))
					{
						self.var_84298650[data.Randomized] = undefined;
					}
					else
					{
						self.var_84298650[data.var_bd058c01] = undefined;
					}
					if(isdefined(self.is_hotjoining) && self.is_hotjoining || tolower(getdvarstring("mapname")) == "zm_shoothouse" || tolower(getdvarstring("mapname")) == "zm_irondragon")
					{
						wait(0.25 * self getentitynumber() + 1);
						continue;
					}
					wait(0.06 * self getentitynumber() + 1);
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
	Offset: 0x1AC08
	Size: 0x888
	Parameters: 0
	Flags: None
	Line Number: 5824
*/
function function_790454cd()
{
	if(self issplitscreen() && self.name == level.players[0].name + " 1" || (self issplitscreen() && self.name == level.players[0].name + " 2") || (self issplitscreen() && self.name == level.players[0].name + " 3") || (self issplitscreen() && self.name == level.players[0].name + " 4") || (self issplitscreen() && self.name == level.players[0].name + " 5") || (self issplitscreen() && self.name == level.players[0].name + " 6") || (self issplitscreen() && self.name == level.players[0].name + " 7"))
	{
	}
	else
	{
		self thread function_7e18304e("spx_maps_save_data", "xuid", self getxuid(1), 0);
		self thread function_7e18304e("spx_save_data", "xuid", self getxuid(1), 0);
		self thread function_7e18304e("spx_save_data", "vip1", self.var_3d9c073["vip1"], 0);
		self thread function_7e18304e("spx_save_data", "vip2", self.var_3d9c073["vip2"], 0);
		self thread function_7e18304e("spx_save_data", "vip3", self.var_3d9c073["vip3"], 0);
		self thread function_7e18304e("spx_save_data", "vip4", self.var_3d9c073["vip4"], 0);
		self thread function_7e18304e("spx_save_data", "prestige_legend", self.var_b74a3cd1["prestige_legend"], 0);
		self thread function_7e18304e("spx_save_data", "prestige_absolute", self.var_b74a3cd1["prestige_absolute"], 0);
		self thread function_7e18304e("spx_save_data", "prestige_ultimate", self.var_b74a3cd1["prestige_ultimate"], 0);
		self thread function_7e18304e("spx_save_data", "level_version", 188, 0);
		self thread function_7e18304e("spx_save_data", "reset_keyword", 8351, 0);
		self thread function_7e18304e("spx_save_data", "player_points", self.pers["player_points"], 0);
		self thread function_7e18304e("spx_save_data", "cheated_runs", self.pers["cheated_runs"], 0);
		self thread function_7e18304e("spx_save_data", "halloween_camo", self.pers["halloween_camo"], 0);
		self thread function_7e18304e("spx_save_data", "halloween_camo_2", self.pers["halloween_camo_2"], 0);
		self thread function_7e18304e("spx_save_data", "halloween_pumpkin_hat", self.pers["halloween_pumpkin_hat"], 0);
		self thread function_7e18304e("spx_save_data", "halloween_title", self.pers["halloween_title"], 0);
		self thread function_7e18304e("spx_save_data", "halloween_pet", self.pers["halloween_pet"], 0);
		self thread function_7e18304e("spx_save_data", "christmas_hat", self.pers["christmas_hat"], 0);
		self thread function_7e18304e("spx_save_data", "christmas_camo", self.pers["christmas_camo"], 0);
		self thread function_7e18304e("spx_save_data", "time_played_total", self.pers["time_played_total"], 0);
		self thread function_7e18304e("spx_save_data", "downs", self.pers["downs"], 0);
		self thread function_7e18304e("spx_save_data", "revives", self.pers["revives"], 0);
		self thread function_7e18304e("spx_save_data", "total_shots", self.pers["total_shots"], 0);
		self thread function_7e18304e("spx_save_data", "hits", self.pers["hits"], 0);
		self thread function_7e18304e("spx_save_data", "misses", self.pers["misses"], 0);
		self thread function_7e18304e("spx_save_data", "distance_traveled", self.pers["distance_traveled"], 0);
		self thread function_7e18304e("spx_save_data", "doors_purchased", self.pers["doors_purchased"], 0);
		self thread function_7e18304e("spx_save_data", "bgbs_chewed", self.pers["bgbs_chewed"], 0);
		self thread function_7e18304e("spx_save_data", "buildables_built", self.pers["buildables_built"], 0);
		self thread function_7e18304e("spx_save_data", "boards", self.pers["boards"], 0);
	}
}

/*
	Name: function_e5da2d1e
	Namespace: namespace_97ac1184
	Checksum: 0x424F4353
	Offset: 0x1B498
	Size: 0x150
	Parameters: 0
	Flags: None
	Line Number: 5875
*/
function function_e5da2d1e()
{
	index = 1;
	table = "gamedata/leveling/saving_data_index.csv";
	for(row = tablelookuprow(table, index); isdefined(row); row = tablelookuprow(table, index))
	{
		var_bd058c01 = checkStringValid(row[0]);
		type = checkStringValid(row[1]);
		description = checkStringValid(row[2]);
		if(isdefined(var_bd058c01) && var_bd058c01 != "")
		{
			level.var_ac46587c[var_bd058c01] = index;
			level.var_d824eaa9[var_bd058c01] = type;
			level.var_ed3d349f[var_bd058c01] = description;
		}
		index++;
	}
	return;
	ERROR: Exception occured: Stack empty.
	ERROR: Exception occured: Stack empty.
}

/*
	Name: function_58027f04
	Namespace: namespace_97ac1184
	Checksum: 0x424F4353
	Offset: 0x1B5F0
	Size: 0x150
	Parameters: 0
	Flags: None
	Line Number: 5907
*/
function function_58027f04()
{
	index = 1;
	table = "gamedata/leveling/saving_data_index_maps.csv";
	for(row = tablelookuprow(table, index); isdefined(row); row = tablelookuprow(table, index))
	{
		var_bd058c01 = checkStringValid(row[0]);
		type = checkStringValid(row[1]);
		description = checkStringValid(row[2]);
		if(isdefined(var_bd058c01) && var_bd058c01 != "")
		{
			level.var_c3e446a[var_bd058c01] = index;
			level.var_742cf7b3[var_bd058c01] = type;
			level.var_d70efd10[index] = var_bd058c01;
		}
		index++;
	}
}

/*
	Name: function_13b88de9
	Namespace: namespace_97ac1184
	Checksum: 0x424F4353
	Offset: 0x1B748
	Size: 0x590
	Parameters: 3
	Flags: None
	Line Number: 5936
*/
function function_13b88de9(value, var_710bf60b, zombie)
{
	value = value * 1.1;
	var_12d93c83 = value;
	if(level.zombie_actor_limit > 56 || level.zombie_ai_limit > 56 || level.zombie_vars["zombie_between_round_time"] == 0 || (isdefined(level.var_9d7722be) && level.var_9d7722be))
	{
		value = value * 0.8;
	}
	if(!(isdefined(level.bgb_in_use) && level.bgb_in_use))
	{
		value = value * 1.03;
	}
	if(isdefined(level.var_679e1a9e) && level.var_679e1a9e)
	{
		value = value * 1.05;
	}
	window_boards = struct::get_array("exterior_goal", "targetname");
	var_32f79b1d = struct::get_array("riser_location", "script_noteworthy");
	var_ab4a2512 = array();
	foreach(loc in var_32f79b1d)
	{
		if(loc.script_string == "find_flesh")
		{
			ArrayInsert(var_ab4a2512, loc, var_ab4a2512.size);
		}
	}
	if(window_boards.size == 1 || window_boards.size == 2 || window_boards.size == 3)
	{
		if(var_ab4a2512.size == 0 || var_ab4a2512.size == 1 || var_ab4a2512.size == 2)
		{
			value = value * 0.4;
		}
	}
	else if(window_boards.size == 0)
	{
		if(var_ab4a2512.size == 1 || var_ab4a2512.size == 2)
		{
			value = value * 0.6;
		}
	}
	if(isdefined(self.var_fa202141["player_playerdifficulty"]) && self.var_fa202141["player_playerdifficulty"] > 0)
	{
		if(self.var_fa202141["player_playerdifficulty"] > self.var_b74a3cd1["brutal_rank"])
		{
			iprintlnbold("Brutal Rank too high!");
		}
		else
		{
			value = value * 1 + self.var_fa202141["player_playerdifficulty"] * 0.005;
		}
	}
	if(self.var_b74a3cd1["prestige_legend"] > 0)
	{
		value = value * 1 + 0.075 * self.var_b74a3cd1["prestige_legend"];
	}
	if(self.var_b74a3cd1["prestige_absolute"] > 0)
	{
		value = value * 1 + 0.9 * self.var_b74a3cd1["prestige_absolute"];
	}
	if(self.var_b74a3cd1["prestige_ultimate"] > 0)
	{
		value = value * 1 + 10 * self.var_b74a3cd1["prestige_ultimate"];
	}
	if(level flag::get("classic_enabled"))
	{
		value = value * 1.15;
	}
	if(isdefined(1) && 1 && (!(isdefined(var_710bf60b) && var_710bf60b)))
	{
		value = value * 1.5;
	}
	if(isdefined(level.var_91874529))
	{
		value = value * 1 - level.var_91874529 * 0.01;
	}
	if(!(isdefined(self function_ae5b65af(zombie)) && self function_ae5b65af(zombie)))
	{
		value = 0;
	}
	if(isdefined(self.var_ed43a11c) && self.var_ed43a11c)
	{
		value = 0;
	}
	var_9f433a3b = zm_utility::round_up_score(value, 10);
	self.var_b74a3cd1["xp_multiplier"] = var_9f433a3b / var_12d93c83 * 100;
	return var_9f433a3b;
}

/*
	Name: function_ef10d421
	Namespace: namespace_97ac1184
	Checksum: 0x424F4353
	Offset: 0x1BCE0
	Size: 0x30
	Parameters: 0
	Flags: None
	Line Number: 6034
*/
function function_ef10d421()
{
	self notify("hash_ef10d421");
	self endon("hash_ef10d421");
	wait(6);
	self.var_760a296 = 0;
}

/*
	Name: function_ae5b65af
	Namespace: namespace_97ac1184
	Checksum: 0x424F4353
	Offset: 0x1BD18
	Size: 0x408
	Parameters: 1
	Flags: None
	Line Number: 6052
*/
function function_ae5b65af(zombie)
{
	if(!isdefined(self))
	{
		return 0;
	}
	if(IsGodMode(self))
	{
		return 0;
	}
	current_weapon = self getcurrentweapon();
	if(current_weapon == level.zombie_powerup_weapon["minigun"] && !self.zombie_vars["zombie_powerup_minigun_on"] || (issubstr(current_weapon.name, "minigun") && !self.zombie_vars["zombie_powerup_minigun_on"]))
	{
		return 0;
	}
	if(self.ignoreme > 0 && (isdefined(self.bgb_idle_eyes_active) && self.bgb_idle_eyes_active || (isdefined(self.zombie_vars["zombie_powerup_zombie_blood_on"]) && self.zombie_vars["zombie_powerup_zombie_blood_on"]) || (isdefined(level.var_c181264f) && level.var_c181264f) || (isdefined(self laststand::player_is_in_laststand()) && self laststand::player_is_in_laststand()) || (isdefined(self.bgb_in_plain_sight_active) && self.bgb_in_plain_sight_active)))
	{
		return 1;
	}
	else if(self.ignoreme > 0)
	{
		return 0;
	}
	if(isdefined(zombie))
	{
		if(zombie zm_utility::in_playable_area() && (isdefined(zombie.completed_emerging_into_playable_area) && zombie.completed_emerging_into_playable_area))
		{
			if(isdefined(zombie.var_5bb6cdc1) && zombie.var_5bb6cdc1)
			{
				return 0;
			}
		}
	}
	var_4608cafc = 0;
	zombies = getaiteamarray(level.zombie_team);
	if(zombies.size > 0)
	{
		foreach(var_fe254d59 in zombies)
		{
			if(isdefined(var_fe254d59.var_5bb6cdc1) && var_fe254d59.var_5bb6cdc1)
			{
				if(isdefined(zombie))
				{
					var_4608cafc++;
				}
			}
		}
	}
	else if(var_4608cafc >= 5)
	{
		self thread function_ef10d421();
		self.var_760a296 = 1;
	}
	if(isdefined(self.var_760a296) && self.var_760a296)
	{
		return 0;
	}
	if(self.health > 300 || self.max_health > 300)
	{
		return 0;
	}
	playable_area = getentarray("player_volume", "script_noteworthy");
	var_1c5a0f9d = 0;
	for(i = 0; i < playable_area.size; i++)
	{
		if(self istouching(playable_area[i]))
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
	Offset: 0x1C128
	Size: 0x1B0
	Parameters: 1
	Flags: None
	Line Number: 6139
*/
function function_72690674(var_bd1ce88)
{
	if(isdefined(var_bd1ce88) && var_bd1ce88 && level.round_number <= 20)
	{
		return level.round_number * 11;
	}
	else if(isdefined(var_bd1ce88) && var_bd1ce88 && level.round_number > 20 && level.round_number <= 80)
	{
		return 220 + level.round_number - 20 * 7;
	}
	else if(isdefined(var_bd1ce88) && var_bd1ce88 && level.round_number > 80 && level.round_number <= 110)
	{
		return 640 + level.round_number - 80 * 5;
	}
	else if(isdefined(var_bd1ce88) && var_bd1ce88 && level.round_number > 110 && level.round_number <= 150)
	{
		return 790 + level.round_number - 110 * 3;
	}
	else if(isdefined(var_bd1ce88) && var_bd1ce88 && level.round_number > 150 && level.round_number <= 200)
	{
		return 910 + level.round_number - 150 * 2;
	}
	else if(isdefined(var_bd1ce88) && var_bd1ce88)
	{
		return 1010 + level.round_number - 200 * 1;
	}
	return 0;
}

/*
	Name: function_e2091339
	Namespace: namespace_97ac1184
	Checksum: 0x424F4353
	Offset: 0x1C2E0
	Size: 0x260
	Parameters: 10
	Flags: None
	Line Number: 6178
*/
function function_e2091339(var_27a55984, var_5786e6c1, var_532d340b, var_7d8c01eb, var_89be7cc4, var_c2a37cdf, zombie, var_1d39abf6, player_points, var_710bf60b)
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
	if(!isdefined(player_points))
	{
		player_points = 0;
	}
	if(!isdefined(var_710bf60b))
	{
		var_710bf60b = 0;
	}
	if(!isdefined(var_27a55984))
	{
		iprintlnbold("Base Value needs defining!");
	}
	if(isdefined(var_c2a37cdf))
	{
		math = self function_13b88de9(var_c2a37cdf, var_710bf60b, zombie);
	}
	else
	{
		math = self function_13b88de9(var_27a55984 + level.round_number * var_5786e6c1 + self.var_b74a3cd1["level"] * var_532d340b + function_72690674(var_7d8c01eb), var_710bf60b, zombie);
	}
	if(self.var_f4d01b67["xp_hud"] == 0)
	{
		self thread score_event(var_89be7cc4, int(math), self.var_230ba247);
	}
	if(isdefined(var_1d39abf6) && var_1d39abf6)
	{
		self thread function_7e18304e("spx_end_game_save_data", "end_game_milestones", 1, 0);
	}
	if(isdefined(player_points))
	{
		self.pers["player_points"] = self.pers["player_points"] + player_points;
	}
	return math;
}

/*
	Name: function_565fd0dc
	Namespace: namespace_97ac1184
	Checksum: 0x424F4353
	Offset: 0x1C548
	Size: 0x5CB0
	Parameters: 3
	Flags: None
	Line Number: 6245
*/
function function_565fd0dc(type, amount, zombie)
{
	switch(type)
	{
		case "zombie_critical_kill":
		{
			var_c614777a = self function_e2091339(100, undefined, 5, 1, &"ZM_MINECRAFT_SCORE_ZOMBIE_CRITICAL_KILL", undefined, zombie);
			return var_c614777a;
		}
		case "zombie_longshot_kill":
		{
			var_c614777a = self function_e2091339(100, undefined, 5, 1, &"ZM_MINECRAFT_SCORE_ZOMBIE_LONGSHOT_KILL", undefined, zombie);
			return var_c614777a;
		}
		case "zombie_sliding_kill":
		{
			var_c614777a = self function_e2091339(100, undefined, 5, 1, &"ZM_MINECRAFT_SCORE_ZOMBIE_SLIDING_KILL", undefined, zombie);
			return var_c614777a;
		}
		case "zombie_prone_kill":
		{
			var_c614777a = self function_e2091339(100, undefined, 5, 1, &"ZM_MINECRAFT_SCORE_ZOMBIE_PRONE_KILL", undefined, zombie);
			return var_c614777a;
		}
		case "zombie_longshot_critical_kill":
		{
			var_c614777a = self function_e2091339(100, undefined, 5, 1, &"ZM_MINECRAFT_SCORE_ZOMBIE_LONGSHOT_CRITICAL_KILL", undefined, zombie);
			return var_c614777a;
		}
		case "zombie_sliding_critical_kill":
		{
			var_c614777a = self function_e2091339(100, undefined, 5, 1, &"ZM_MINECRAFT_SCORE_ZOMBIE_SLIDING_CRITICAL_KILL", undefined, zombie);
			return var_c614777a;
		}
		case "zombie_prone_critical_kill":
		{
			var_c614777a = self function_e2091339(100, undefined, 5, 1, &"ZM_MINECRAFT_SCORE_ZOMBIE_PRONE_CRITICAL_KILL", undefined, zombie);
			return var_c614777a;
		}
		case "zombie_equipment_kill":
		{
			var_c614777a = self function_e2091339(50, undefined, 5, 1, &"ZM_MINECRAFT_SCORE_ZOMBIE_EQUIPMENT_KILL", undefined, zombie);
			return var_c614777a;
		}
		case "zombie_melee_kill":
		{
			var_c614777a = self function_e2091339(130, undefined, 5, 1, &"ZM_MINECRAFT_SCORE_ZOMBIE_MELEE_KILL", undefined, zombie);
			return var_c614777a;
		}
		case "zombie_regular_kill":
		{
			var_c614777a = self function_e2091339(70, undefined, 5, 1, &"ZM_MINECRAFT_SCORE_ZOMBIE_REGULAR_KILL", undefined, zombie);
			return var_c614777a;
		}
		case "zombie_regular_assist":
		{
			var_c614777a = self function_e2091339(35, undefined, 5, 1, &"ZM_MINECRAFT_SCORE_ZOMBIE_REGULAR_ASSIST", undefined, zombie);
			return var_c614777a;
		}
		case "zombie_shrieker_kill":
		{
			var_c614777a = self function_e2091339(250, undefined, 5, 1, &"ZM_MINECRAFT_SCORE_ZOMBIE_SHRIEKER_KILL", undefined, zombie);
			return var_c614777a;
		}
		case "zombie_shrieker_assist":
		{
			var_c614777a = self function_e2091339(125, undefined, 5, 1, &"ZM_MINECRAFT_SCORE_ZOMBIE_SHRIEKER_KILL", undefined, zombie);
			return var_c614777a;
		}
		case "zombie_napalm_kill":
		{
			var_c614777a = self function_e2091339(250, undefined, 5, 1, &"ZM_MINECRAFT_SCORE_ZOMBIE_NAPALM_KILL", undefined, zombie);
			return var_c614777a;
		}
		case "zombie_napalm_assist":
		{
			var_c614777a = self function_e2091339(125, undefined, 5, 1, &"ZM_MINECRAFT_SCORE_ZOMBIE_NAPALM_ASSIST", undefined, zombie);
			return var_c614777a;
		}
		case "zombie_keeper_kill":
		{
			var_c614777a = self function_e2091339(100, undefined, 5, 1, &"ZM_MINECRAFT_SCORE_ZOMBIE_KEEPER_KILL", undefined, zombie);
			return var_c614777a;
		}
		case "zombie_keeper_assist":
		{
			var_c614777a = self function_e2091339(125, undefined, 5, 1, &"ZM_MINECRAFT_SCORE_ZOMBIE_KEEPER_ASSIST", undefined, zombie);
			return var_c614777a;
		}
		case "zombie_apothicon_kill":
		{
			var_c614777a = self function_e2091339(100, undefined, 5, 1, &"ZM_MINECRAFT_SCORE_ZOMBIE_APOTHICON_KILL", undefined, zombie);
			return var_c614777a;
		}
		case "zombie_apothicon_assist":
		{
			var_c614777a = self function_e2091339(50, undefined, 5, 1, &"ZM_MINECRAFT_SCORE_ZOMBIE_APOTHICON_ASSIST", undefined, zombie);
			return var_c614777a;
		}
		case "zombie_parasite_kill":
		{
			var_c614777a = self function_e2091339(100, undefined, 5, 1, &"ZM_MINECRAFT_SCORE_ZOMBIE_PARASITE_KILL", undefined, zombie);
			return var_c614777a;
		}
		case "zombie_parasite_assist":
		{
			var_c614777a = self function_e2091339(50, undefined, 5, 1, &"ZM_MINECRAFT_SCORE_ZOMBIE_PARASITE_ASSIST", undefined, zombie);
			return var_c614777a;
		}
		case "zombie_raps_kill":
		{
			var_c614777a = self function_e2091339(100, undefined, 5, 1, &"ZM_MINECRAFT_SCORE_ZOMBIE_RAPS_KILL", undefined, zombie);
			return var_c614777a;
		}
		case "zombie_raps_assist":
		{
			var_c614777a = self function_e2091339(50, undefined, 5, 1, &"ZM_MINECRAFT_SCORE_ZOMBIE_RAPS_ASSIST", undefined, zombie);
			return var_c614777a;
		}
		case "zombie_spider_kill":
		{
			var_c614777a = self function_e2091339(100, undefined, 5, 1, &"ZM_MINECRAFT_SCORE_ZOMBIE_SPIDER_KILL", undefined, zombie);
			return var_c614777a;
		}
		case "zombie_spider_assist":
		{
			var_c614777a = self function_e2091339(50, undefined, 5, 1, &"ZM_MINECRAFT_SCORE_ZOMBIE_SPIDER_ASSIST", undefined, zombie);
			return var_c614777a;
		}
		case "zombie_monkey_kill":
		{
			var_c614777a = self function_e2091339(150, undefined, 5, 1, &"ZM_MINECRAFT_SCORE_ZOMBIE_MONKEY_KILL", undefined, zombie);
			return var_c614777a;
		}
		case "zombie_monkey_assist":
		{
			var_c614777a = self function_e2091339(75, undefined, 5, 1, &"ZM_MINECRAFT_SCORE_ZOMBIE_MONKEY_ASSIST", undefined, zombie);
			return var_c614777a;
		}
		case "zombie_mechz_kill":
		{
			var_c614777a = self function_e2091339(250, undefined, 5, 1, &"ZM_MINECRAFT_SCORE_ZOMBIE_MECHZ_KILL", undefined, zombie);
			return var_c614777a;
		}
		case "zombie_mechz_assist":
		{
			var_c614777a = self function_e2091339(125, undefined, 5, 1, &"ZM_MINECRAFT_SCORE_ZOMBIE_MECHZ_ASSIST", undefined, zombie);
			return var_c614777a;
		}
		case "zombie_zombiequad_kill":
		{
			var_c614777a = self function_e2091339(70, undefined, 5, 1, &"ZM_MINECRAFT_SCORE_ZOMBIE_ZOMBIEQUAD_KILL", undefined, zombie);
			return var_c614777a;
		}
		case "zombie_zombiequad_assist":
		{
			var_c614777a = self function_e2091339(50, undefined, 5, 1, &"ZM_MINECRAFT_SCORE_ZOMBIE_ZOMBIEQUAD_ASSIST", undefined, zombie);
			return var_c614777a;
		}
		case "zombie_margwa_kill":
		{
			var_c614777a = self function_e2091339(400, undefined, 5, 1, &"ZM_MINECRAFT_SCORE_ZOMBIE_MARGWA_KILL", undefined, zombie);
			return var_c614777a;
		}
		case "zombie_margwa_assist":
		{
			var_c614777a = self function_e2091339(200, undefined, 5, 1, &"ZM_MINECRAFT_SCORE_ZOMBIE_MARGWA_ASSIST", undefined, zombie);
			return var_c614777a;
		}
		case "zombie_thrasher_kill":
		{
			var_c614777a = self function_e2091339(350, undefined, 5, 1, &"ZM_MINECRAFT_SCORE_ZOMBIE_TRASHER_KILL", undefined, zombie);
			return var_c614777a;
		}
		case "zombie_thrasher_assist":
		{
			var_c614777a = self function_e2091339(175, undefined, 5, 1, &"ZM_MINECRAFT_SCORE_ZOMBIE_TRASHER_ASSIST", undefined, zombie);
			return var_c614777a;
		}
		case "zombie_raz_kill":
		{
			var_c614777a = self function_e2091339(250, undefined, 5, 1, &"ZM_MINECRAFT_SCORE_ZOMBIE_RAZ_KILL", undefined, zombie);
			return var_c614777a;
		}
		case "zombie_raz_assist":
		{
			var_c614777a = self function_e2091339(125, undefined, 5, 1, &"ZM_MINECRAFT_SCORE_ZOMBIE_RAZ_ASSIST", undefined, zombie);
			return var_c614777a;
		}
		case "zombie_astronaut_kill":
		{
			var_c614777a = self function_e2091339(200, undefined, 5, 1, &"ZM_MINECRAFT_SCORE_ZOMBIE_ASTRONAUT_KILL", undefined, zombie);
			return var_c614777a;
		}
		case "zombie_astronaut_assist":
		{
			var_c614777a = self function_e2091339(100, undefined, 5, 1, &"ZM_MINECRAFT_SCORE_ZOMBIE_ASTRONAUT_ASSIST", undefined, zombie);
			return var_c614777a;
		}
		case "zombie_saint_kill":
		{
			var_c614777a = self function_e2091339(1500, undefined, 5, 1, &"ZM_MINECRAFT_SCORE_ZOMBIE_SAINT_KILL", undefined, zombie);
			return var_c614777a;
		}
		case "zombie_saint_assist":
		{
			var_c614777a = self function_e2091339(1000, undefined, 5, 1, &"ZM_MINECRAFT_SCORE_ZOMBIE_SAINT_ASSIST", undefined, zombie);
			return var_c614777a;
		}
		case "zombie_ghost_kill":
		{
			var_c614777a = self function_e2091339(1500, undefined, 5, 1, &"ZM_MINECRAFT_SCORE_ZOMBIE_GHOST_KILL", undefined, zombie);
			return var_c614777a;
		}
		case "zombie_ghost_assist":
		{
			var_c614777a = self function_e2091339(1000, undefined, 5, 1, &"ZM_MINECRAFT_SCORE_ZOMBIE_GHOST_ASSIST", undefined, zombie);
			return var_c614777a;
		}
		case "zombie_dog_kill":
		{
			var_c614777a = self function_e2091339(50, undefined, 5, 1, &"ZM_MINECRAFT_SCORE_ZOMBIE_DOG_KILL", undefined, zombie);
			return var_c614777a;
		}
		case "zombie_dog_assist":
		{
			var_c614777a = self function_e2091339(25, undefined, 5, 1, &"ZM_MINECRAFT_SCORE_ZOMBIE_DOG_ASSIST", undefined, zombie);
			return var_c614777a;
		}
		case "zombie_armored_kill":
		{
			var_c614777a = self function_e2091339(225, undefined, 5, 1, &"ZM_MINECRAFT_SCORE_ZOMBIE_ARMORED_KILL", undefined, zombie);
			return var_c614777a;
		}
		case "zombie_armored_assist":
		{
			var_c614777a = self function_e2091339(110, undefined, 5, 1, &"ZM_MINECRAFT_SCORE_ZOMBIE_ARMORED_ASSIST", undefined, zombie);
			return var_c614777a;
		}
		case "zombie_boss_kill":
		{
			var_c614777a = self function_e2091339(500, undefined, 5, 1, &"ZM_MINECRAFT_SCORE_ZOMBIE_BOSS_KILL", undefined, zombie);
			return var_c614777a;
		}
		case "zombie_boss_assist":
		{
			var_c614777a = self function_e2091339(500, undefined, 5, 1, &"ZM_MINECRAFT_SCORE_ZOMBIE_BOSS_KILL", undefined, zombie);
			return var_c614777a;
		}
		case "player_revive":
		{
			var_c614777a = self function_e2091339(500, undefined, 5, 1, &"ZM_MINECRAFT_SCORE_PLAYER_REVIVE", undefined, zombie);
			return var_c614777a;
		}
		case "round_survived":
		{
			var_c614777a = self function_e2091339(150, 50, 0, 1, &"ZM_MINECRAFT_SCORE_ROUND_SURVIVED", undefined, zombie);
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
			var_c614777a = self function_e2091339(25, 0, 0, 0, &"ZM_MINECRAFT_SCORE_BARRIER_REPAIRED", undefined, zombie);
			return var_c614777a;
		}
		case "doors_purchased":
		{
			var_c614777a = self function_e2091339(amount, 0, 0, 0, &"ZM_MINECRAFT_SCORE_DOOR_PURCHASED", undefined, zombie);
			return var_c614777a;
		}
		case "powerup_xp_drop":
		{
			var_c614777a = self function_e2091339(function_cd26638e(), 0, 0, 0, &"ZM_MINECRAFT_SCORE_XP_DROP", undefined, zombie);
			return var_c614777a;
		}
		case "milestone_completed_round_10":
		{
			var_c614777a = self function_e2091339(1000, 0, 0, 0, &"ZM_MINECRAFT_SCORE_MILESTONE_COMPLETED_ROUND_10", undefined, zombie, 1, 10, 1);
			self luinotifyevent(&"spx_milestone_notification", 2, &"ZM_MINECRAFT_MILESTONE_ROUNDS", 10);
			return var_c614777a;
		}
		case "milestone_completed_round_15":
		{
			var_c614777a = self function_e2091339(1500, 0, 0, 0, &"ZM_MINECRAFT_SCORE_MILESTONE_COMPLETED_ROUND_15", undefined, zombie, 1, 20, 1);
			self luinotifyevent(&"spx_milestone_notification", 2, &"ZM_MINECRAFT_MILESTONE_ROUNDS", 15);
			return var_c614777a;
		}
		case "milestone_completed_round_20":
		{
			var_c614777a = self function_e2091339(2000, 0, 0, 0, &"ZM_MINECRAFT_SCORE_MILESTONE_COMPLETED_ROUND_20", undefined, zombie, 1, 30, 1);
			self luinotifyevent(&"spx_milestone_notification", 2, &"ZM_MINECRAFT_MILESTONE_ROUNDS", 20);
			return var_c614777a;
		}
		case "milestone_completed_round_25":
		{
			var_c614777a = self function_e2091339(3000, 0, 0, 0, &"ZM_MINECRAFT_SCORE_MILESTONE_COMPLETED_ROUND_25", undefined, zombie, 1, 40, 1);
			self luinotifyevent(&"spx_milestone_notification", 2, &"ZM_MINECRAFT_MILESTONE_ROUNDS", 25);
			return var_c614777a;
		}
		case "milestone_completed_round_30":
		{
			var_c614777a = self function_e2091339(4000, 0, 0, 0, &"ZM_MINECRAFT_SCORE_MILESTONE_COMPLETED_ROUND_30", undefined, zombie, 1, 50, 1);
			self luinotifyevent(&"spx_milestone_notification", 2, &"ZM_MINECRAFT_MILESTONE_ROUNDS", 30);
			return var_c614777a;
		}
		case "milestone_completed_round_35":
		{
			var_c614777a = self function_e2091339(5000, 0, 0, 0, &"ZM_MINECRAFT_SCORE_MILESTONE_COMPLETED_ROUND_35", undefined, zombie, 1, 60, 1);
			self luinotifyevent(&"spx_milestone_notification", 2, &"ZM_MINECRAFT_MILESTONE_ROUNDS", 35);
			return var_c614777a;
		}
		case "milestone_completed_round_40":
		{
			var_c614777a = self function_e2091339(6000, 0, 0, 0, &"ZM_MINECRAFT_SCORE_MILESTONE_COMPLETED_ROUND_40", undefined, zombie, 1, 70, 1);
			self luinotifyevent(&"spx_milestone_notification", 2, &"ZM_MINECRAFT_MILESTONE_ROUNDS", 40);
			return var_c614777a;
		}
		case "milestone_completed_round_45":
		{
			var_c614777a = self function_e2091339(7000, 0, 0, 0, &"ZM_MINECRAFT_SCORE_MILESTONE_COMPLETED_ROUND_45", undefined, zombie, 1, 80, 1);
			self luinotifyevent(&"spx_milestone_notification", 2, &"ZM_MINECRAFT_MILESTONE_ROUNDS", 45);
			return var_c614777a;
		}
		case "milestone_completed_round_50":
		{
			var_c614777a = self function_e2091339(8000, 0, 0, 0, &"ZM_MINECRAFT_SCORE_MILESTONE_COMPLETED_ROUND_50", undefined, zombie, 1, 90, 1);
			self luinotifyevent(&"spx_milestone_notification", 2, &"ZM_MINECRAFT_MILESTONE_ROUNDS", 50);
			return var_c614777a;
		}
		case "milestone_completed_round_55":
		{
			var_c614777a = self function_e2091339(9000, 0, 0, 0, &"ZM_MINECRAFT_SCORE_MILESTONE_COMPLETED_ROUND_55", undefined, zombie, 1, 100, 1);
			self luinotifyevent(&"spx_milestone_notification", 2, &"ZM_MINECRAFT_MILESTONE_ROUNDS", 55);
			return var_c614777a;
		}
		case "milestone_completed_round_60":
		{
			var_c614777a = self function_e2091339(10000, 0, 0, 0, &"ZM_MINECRAFT_SCORE_MILESTONE_COMPLETED_ROUND_60", undefined, zombie, 1, 110, 1);
			self luinotifyevent(&"spx_milestone_notification", 2, &"ZM_MINECRAFT_MILESTONE_ROUNDS", 60);
			return var_c614777a;
		}
		case "milestone_completed_round_65":
		{
			var_c614777a = self function_e2091339(11000, 0, 0, 0, &"ZM_MINECRAFT_SCORE_MILESTONE_COMPLETED_ROUND_65", undefined, zombie, 1, 120, 1);
			self luinotifyevent(&"spx_milestone_notification", 2, &"ZM_MINECRAFT_MILESTONE_ROUNDS", 65);
			return var_c614777a;
		}
		case "milestone_completed_round_70":
		{
			var_c614777a = self function_e2091339(12000, 0, 0, 0, &"ZM_MINECRAFT_SCORE_MILESTONE_COMPLETED_ROUND_70", undefined, zombie, 1, 130, 1);
			self luinotifyevent(&"spx_milestone_notification", 2, &"ZM_MINECRAFT_MILESTONE_ROUNDS", 70);
			return var_c614777a;
		}
		case "milestone_completed_round_75":
		{
			var_c614777a = self function_e2091339(13500, 0, 0, 0, &"ZM_MINECRAFT_SCORE_MILESTONE_COMPLETED_ROUND_75", undefined, zombie, 1, 145, 1);
			self luinotifyevent(&"spx_milestone_notification", 2, &"ZM_MINECRAFT_MILESTONE_ROUNDS", 75);
			return var_c614777a;
		}
		case "milestone_completed_round_80":
		{
			var_c614777a = self function_e2091339(15000, 0, 0, 0, &"ZM_MINECRAFT_SCORE_MILESTONE_COMPLETED_ROUND_80", undefined, zombie, 1, 160, 1);
			self luinotifyevent(&"spx_milestone_notification", 2, &"ZM_MINECRAFT_MILESTONE_ROUNDS", 80);
			return var_c614777a;
		}
		case "milestone_completed_round_85":
		{
			var_c614777a = self function_e2091339(16500, 0, 0, 0, &"ZM_MINECRAFT_SCORE_MILESTONE_COMPLETED_ROUND_85", undefined, zombie, 1, 175, 1);
			self luinotifyevent(&"spx_milestone_notification", 2, &"ZM_MINECRAFT_MILESTONE_ROUNDS", 85);
			return var_c614777a;
		}
		case "milestone_completed_round_90":
		{
			var_c614777a = self function_e2091339(18000, 0, 0, 0, &"ZM_MINECRAFT_SCORE_MILESTONE_COMPLETED_ROUND_90", undefined, zombie, 1, 190, 1);
			self luinotifyevent(&"spx_milestone_notification", 2, &"ZM_MINECRAFT_MILESTONE_ROUNDS", 90);
			return var_c614777a;
		}
		case "milestone_completed_round_95":
		{
			var_c614777a = self function_e2091339(20000, 0, 0, 0, &"ZM_MINECRAFT_SCORE_MILESTONE_COMPLETED_ROUND_95", undefined, zombie, 1, 210, 1);
			self luinotifyevent(&"spx_milestone_notification", 2, &"ZM_MINECRAFT_MILESTONE_ROUNDS", 95);
			return var_c614777a;
		}
		case "milestone_completed_round_100":
		{
			var_c614777a = self function_e2091339(22000, 0, 0, 0, &"ZM_MINECRAFT_SCORE_MILESTONE_COMPLETED_ROUND_100", undefined, zombie, 1, 230, 1);
			self luinotifyevent(&"spx_milestone_notification", 2, &"ZM_MINECRAFT_MILESTONE_ROUNDS", 100);
			return var_c614777a;
		}
		case "milestone_completed_round_105":
		{
			var_c614777a = self function_e2091339(24000, 0, 0, 0, &"ZM_MINECRAFT_SCORE_MILESTONE_COMPLETED_ROUND_105", undefined, zombie, 1, 250, 1);
			self luinotifyevent(&"spx_milestone_notification", 2, &"ZM_MINECRAFT_MILESTONE_ROUNDS", 105);
			return var_c614777a;
		}
		case "milestone_completed_round_110":
		{
			var_c614777a = self function_e2091339(26000, 0, 0, 0, &"ZM_MINECRAFT_SCORE_MILESTONE_COMPLETED_ROUND_110", undefined, zombie, 1, 270, 1);
			self luinotifyevent(&"spx_milestone_notification", 2, &"ZM_MINECRAFT_MILESTONE_ROUNDS", 110);
			return var_c614777a;
		}
		case "milestone_completed_round_115":
		{
			var_c614777a = self function_e2091339(28000, 0, 0, 0, &"ZM_MINECRAFT_SCORE_MILESTONE_COMPLETED_ROUND_115", undefined, zombie, 1, 290, 1);
			self luinotifyevent(&"spx_milestone_notification", 2, &"ZM_MINECRAFT_MILESTONE_ROUNDS", 115);
			return var_c614777a;
		}
		case "milestone_completed_round_120":
		{
			var_c614777a = self function_e2091339(30000, 0, 0, 0, &"ZM_MINECRAFT_SCORE_MILESTONE_COMPLETED_ROUND_120", undefined, zombie, 1, 310, 1);
			self luinotifyevent(&"spx_milestone_notification", 2, &"ZM_MINECRAFT_MILESTONE_ROUNDS", 120);
			return var_c614777a;
		}
		case "milestone_completed_round_125":
		{
			var_c614777a = self function_e2091339(32000, 0, 0, 0, &"ZM_MINECRAFT_SCORE_MILESTONE_COMPLETED_ROUND_125", undefined, zombie, 1, 330, 1);
			self luinotifyevent(&"spx_milestone_notification", 2, &"ZM_MINECRAFT_MILESTONE_ROUNDS", 125);
			return var_c614777a;
		}
		case "milestone_completed_round_130":
		{
			var_c614777a = self function_e2091339(35000, 0, 0, 0, &"ZM_MINECRAFT_SCORE_MILESTONE_COMPLETED_ROUND_130", undefined, zombie, 1, 360, 1);
			self luinotifyevent(&"spx_milestone_notification", 2, &"ZM_MINECRAFT_MILESTONE_ROUNDS", 130);
			return var_c614777a;
		}
		case "milestone_completed_round_135":
		{
			var_c614777a = self function_e2091339(38000, 0, 0, 0, &"ZM_MINECRAFT_SCORE_MILESTONE_COMPLETED_ROUND_135", undefined, zombie, 1, 390, 1);
			self luinotifyevent(&"spx_milestone_notification", 2, &"ZM_MINECRAFT_MILESTONE_ROUNDS", 135);
			return var_c614777a;
		}
		case "milestone_completed_round_140":
		{
			var_c614777a = self function_e2091339(41000, 0, 0, 0, &"ZM_MINECRAFT_SCORE_MILESTONE_COMPLETED_ROUND_140", undefined, zombie, 1, 420, 1);
			self luinotifyevent(&"spx_milestone_notification", 2, &"ZM_MINECRAFT_MILESTONE_ROUNDS", 140);
			return var_c614777a;
		}
		case "milestone_completed_round_145":
		{
			var_c614777a = self function_e2091339(44000, 0, 0, 0, &"ZM_MINECRAFT_SCORE_MILESTONE_COMPLETED_ROUND_145", undefined, zombie, 1, 450, 1);
			self luinotifyevent(&"spx_milestone_notification", 2, &"ZM_MINECRAFT_MILESTONE_ROUNDS", 145);
			return var_c614777a;
		}
		case "milestone_completed_round_150":
		{
			var_c614777a = self function_e2091339(48000, 0, 0, 0, &"ZM_MINECRAFT_SCORE_MILESTONE_COMPLETED_ROUND_150", undefined, zombie, 1, 490, 1);
			self luinotifyevent(&"spx_milestone_notification", 2, &"ZM_MINECRAFT_MILESTONE_ROUNDS", 150);
			return var_c614777a;
		}
		case "milestone_completed_round_155":
		{
			var_c614777a = self function_e2091339(51000, 0, 0, 0, &"ZM_MINECRAFT_SCORE_MILESTONE_COMPLETED_ROUND_155", undefined, zombie, 1, 530, 1);
			self luinotifyevent(&"spx_milestone_notification", 2, &"ZM_MINECRAFT_MILESTONE_ROUNDS", 155);
			return var_c614777a;
		}
		case "milestone_completed_round_160":
		{
			var_c614777a = self function_e2091339(55000, 0, 0, 0, &"ZM_MINECRAFT_SCORE_MILESTONE_COMPLETED_ROUND_160", undefined, zombie, 1, 570, 1);
			self luinotifyevent(&"spx_milestone_notification", 2, &"ZM_MINECRAFT_MILESTONE_ROUNDS", 160);
			return var_c614777a;
		}
		case "milestone_completed_round_165":
		{
			var_c614777a = self function_e2091339(59000, 0, 0, 0, &"ZM_MINECRAFT_SCORE_MILESTONE_COMPLETED_ROUND_165", undefined, zombie, 1, 600, 1);
			self luinotifyevent(&"spx_milestone_notification", 2, &"ZM_MINECRAFT_MILESTONE_ROUNDS", 165);
			return var_c614777a;
		}
		case "milestone_completed_round_170":
		{
			var_c614777a = self function_e2091339(63000, 0, 0, 0, &"ZM_MINECRAFT_SCORE_MILESTONE_COMPLETED_ROUND_170", undefined, zombie, 1, 630, 1);
			self luinotifyevent(&"spx_milestone_notification", 2, &"ZM_MINECRAFT_MILESTONE_ROUNDS", 170);
			return var_c614777a;
		}
		case "milestone_completed_round_175":
		{
			var_c614777a = self function_e2091339(67000, 0, 0, 0, &"ZM_MINECRAFT_SCORE_MILESTONE_COMPLETED_ROUND_175", undefined, zombie, 1, 660, 1);
			self luinotifyevent(&"spx_milestone_notification", 2, &"ZM_MINECRAFT_MILESTONE_ROUNDS", 175);
			return var_c614777a;
		}
		case "milestone_completed_round_180":
		{
			var_c614777a = self function_e2091339(71000, 0, 0, 0, &"ZM_MINECRAFT_SCORE_MILESTONE_COMPLETED_ROUND_180", undefined, zombie, 1, 690, 1);
			self luinotifyevent(&"spx_milestone_notification", 2, &"ZM_MINECRAFT_MILESTONE_ROUNDS", 180);
			return var_c614777a;
		}
		case "milestone_completed_round_185":
		{
			var_c614777a = self function_e2091339(75000, 0, 0, 0, &"ZM_MINECRAFT_SCORE_MILESTONE_COMPLETED_ROUND_185", undefined, zombie, 1, 720, 1);
			self luinotifyevent(&"spx_milestone_notification", 2, &"ZM_MINECRAFT_MILESTONE_ROUNDS", 185);
			return var_c614777a;
		}
		case "milestone_completed_round_190":
		{
			var_c614777a = self function_e2091339(80000, 0, 0, 0, &"ZM_MINECRAFT_SCORE_MILESTONE_COMPLETED_ROUND_190", undefined, zombie, 1, 760, 1);
			self luinotifyevent(&"spx_milestone_notification", 2, &"ZM_MINECRAFT_MILESTONE_ROUNDS", 190);
			return var_c614777a;
		}
		case "milestone_completed_round_195":
		{
			var_c614777a = self function_e2091339(85000, 0, 0, 0, &"ZM_MINECRAFT_SCORE_MILESTONE_COMPLETED_ROUND_195", undefined, zombie, 1, 800, 1);
			self luinotifyevent(&"spx_milestone_notification", 2, &"ZM_MINECRAFT_MILESTONE_ROUNDS", 195);
			return var_c614777a;
		}
		case "milestone_completed_round_200":
		{
			var_c614777a = self function_e2091339(90000, 0, 0, 0, &"ZM_MINECRAFT_SCORE_MILESTONE_COMPLETED_ROUND_200", undefined, zombie, 1, 840, 1);
			self luinotifyevent(&"spx_milestone_notification", 2, &"ZM_MINECRAFT_MILESTONE_ROUNDS", 200);
			return var_c614777a;
		}
		case "milestone_completed_round_205":
		{
			var_c614777a = self function_e2091339(95000, 0, 0, 0, &"ZM_MINECRAFT_SCORE_MILESTONE_COMPLETED_ROUND_205", undefined, zombie, 1, 880, 1);
			self luinotifyevent(&"spx_milestone_notification", 2, &"ZM_MINECRAFT_MILESTONE_ROUNDS", 205);
			return var_c614777a;
		}
		case "milestone_completed_round_210":
		{
			var_c614777a = self function_e2091339(100000, 0, 0, 0, &"ZM_MINECRAFT_SCORE_MILESTONE_COMPLETED_ROUND_210", undefined, zombie, 1, 920, 1);
			self luinotifyevent(&"spx_milestone_notification", 2, &"ZM_MINECRAFT_MILESTONE_ROUNDS", 210);
			return var_c614777a;
		}
		case "milestone_completed_round_215":
		{
			var_c614777a = self function_e2091339(105000, 0, 0, 0, &"ZM_MINECRAFT_SCORE_MILESTONE_COMPLETED_ROUND_215", undefined, zombie, 1, 960, 1);
			self luinotifyevent(&"spx_milestone_notification", 2, &"ZM_MINECRAFT_MILESTONE_ROUNDS", 215);
			return var_c614777a;
		}
		case "milestone_completed_round_220":
		{
			var_c614777a = self function_e2091339(110000, 0, 0, 0, &"ZM_MINECRAFT_SCORE_MILESTONE_COMPLETED_ROUND_220", undefined, zombie, 1, 1000, 1);
			self luinotifyevent(&"spx_milestone_notification", 2, &"ZM_MINECRAFT_MILESTONE_ROUNDS", 220);
			return var_c614777a;
		}
		case "milestone_completed_round_225":
		{
			var_c614777a = self function_e2091339(115000, 0, 0, 0, &"ZM_MINECRAFT_SCORE_MILESTONE_COMPLETED_ROUND_225", undefined, zombie, 1, 1040, 1);
			self luinotifyevent(&"spx_milestone_notification", 2, &"ZM_MINECRAFT_MILESTONE_ROUNDS", 225);
			return var_c614777a;
		}
		case "milestone_completed_round_230":
		{
			var_c614777a = self function_e2091339(120000, 0, 0, 0, &"ZM_MINECRAFT_SCORE_MILESTONE_COMPLETED_ROUND_230", undefined, zombie, 1, 1080, 1);
			self luinotifyevent(&"spx_milestone_notification", 2, &"ZM_MINECRAFT_MILESTONE_ROUNDS", 230);
			return var_c614777a;
		}
		case "milestone_completed_round_235":
		{
			var_c614777a = self function_e2091339(125000, 0, 0, 0, &"ZM_MINECRAFT_SCORE_MILESTONE_COMPLETED_ROUND_235", undefined, zombie, 1, 1120, 1);
			self luinotifyevent(&"spx_milestone_notification", 2, &"ZM_MINECRAFT_MILESTONE_ROUNDS", 235);
			return var_c614777a;
		}
		case "milestone_completed_round_240":
		{
			var_c614777a = self function_e2091339(130000, 0, 0, 0, &"ZM_MINECRAFT_SCORE_MILESTONE_COMPLETED_ROUND_240", undefined, zombie, 1, 1160, 1);
			self luinotifyevent(&"spx_milestone_notification", 2, &"ZM_MINECRAFT_MILESTONE_ROUNDS", 240);
			return var_c614777a;
		}
		case "milestone_completed_round_245":
		{
			var_c614777a = self function_e2091339(135000, 0, 0, 0, &"ZM_MINECRAFT_SCORE_MILESTONE_COMPLETED_ROUND_245", undefined, zombie, 1, 1200, 1);
			self luinotifyevent(&"spx_milestone_notification", 2, &"ZM_MINECRAFT_MILESTONE_ROUNDS", 245);
			return var_c614777a;
		}
		case "milestone_completed_round_250":
		{
			var_c614777a = self function_e2091339(140000, 0, 0, 0, &"ZM_MINECRAFT_SCORE_MILESTONE_COMPLETED_ROUND_250", undefined, zombie, 1, 1240, 1);
			self luinotifyevent(&"spx_milestone_notification", 2, &"ZM_MINECRAFT_MILESTONE_ROUNDS", 200);
			return var_c614777a;
		}
		case "milestone_completed_round_255":
		{
			var_c614777a = self function_e2091339(150000, 0, 0, 0, &"ZM_MINECRAFT_SCORE_MILESTONE_COMPLETED_ROUND_255", undefined, zombie, 1, 1300, 1);
			self luinotifyevent(&"spx_milestone_notification", 2, &"ZM_MINECRAFT_MILESTONE_ROUNDS", 255);
			return var_c614777a;
		}
		case "milestone_completed_kills_500":
		{
			var_c614777a = self function_e2091339(4000, 0, 0, 0, &"ZM_MINECRAFT_SCORE_MILESTONE_COMPLETED_KILLS_500", undefined, zombie, 1, 10, 1);
			self luinotifyevent(&"spx_milestone_notification", 2, &"ZM_MINECRAFT_MILESTONE_KILLS", 500);
			return var_c614777a;
		}
		case "milestone_completed_kills_750":
		{
			var_c614777a = self function_e2091339(5000, 0, 0, 0, &"ZM_MINECRAFT_SCORE_MILESTONE_COMPLETED_KILLS_750", undefined, zombie, 1, 15, 1);
			self luinotifyevent(&"spx_milestone_notification", 2, &"ZM_MINECRAFT_MILESTONE_KILLS", 750);
			return var_c614777a;
		}
		case "milestone_completed_kills_1000":
		{
			var_c614777a = self function_e2091339(6000, 0, 0, 0, &"ZM_MINECRAFT_SCORE_MILESTONE_COMPLETED_KILLS_1000", undefined, zombie, 1, 20, 1);
			self luinotifyevent(&"spx_milestone_notification", 2, &"ZM_MINECRAFT_MILESTONE_KILLS", 1000);
			return var_c614777a;
		}
		case "milestone_completed_kills_1500":
		{
			var_c614777a = self function_e2091339(8000, 0, 0, 0, &"ZM_MINECRAFT_SCORE_MILESTONE_COMPLETED_KILLS_1500", undefined, zombie, 1, 30, 1);
			self luinotifyevent(&"spx_milestone_notification", 2, &"ZM_MINECRAFT_MILESTONE_KILLS", 1500);
			return var_c614777a;
		}
		case "milestone_completed_kills_2000":
		{
			var_c614777a = self function_e2091339(10000, 0, 0, 0, &"ZM_MINECRAFT_SCORE_MILESTONE_COMPLETED_KILLS_2000", undefined, zombie, 1, 40, 1);
			self luinotifyevent(&"spx_milestone_notification", 2, &"ZM_MINECRAFT_MILESTONE_KILLS", 2000);
			return var_c614777a;
		}
		case "milestone_completed_kills_3000":
		{
			var_c614777a = self function_e2091339(12000, 0, 0, 0, &"ZM_MINECRAFT_SCORE_MILESTONE_COMPLETED_KILLS_3000", undefined, zombie, 1, 60, 1);
			self luinotifyevent(&"spx_milestone_notification", 2, &"ZM_MINECRAFT_MILESTONE_KILLS", 3000);
			return var_c614777a;
		}
		case "milestone_completed_kills_4000":
		{
			var_c614777a = self function_e2091339(15000, 0, 0, 0, &"ZM_MINECRAFT_SCORE_MILESTONE_COMPLETED_KILLS_4000", undefined, zombie, 1, 80, 1);
			self luinotifyevent(&"spx_milestone_notification", 2, &"ZM_MINECRAFT_MILESTONE_KILLS", 4000);
			return var_c614777a;
		}
		case "milestone_completed_kills_5000":
		{
			var_c614777a = self function_e2091339(18000, 0, 0, 0, &"ZM_MINECRAFT_SCORE_MILESTONE_COMPLETED_KILLS_5000", undefined, zombie, 1, 100, 1);
			self luinotifyevent(&"spx_milestone_notification", 2, &"ZM_MINECRAFT_MILESTONE_KILLS", 5000);
			return var_c614777a;
		}
		case "milestone_completed_kills_7500":
		{
			var_c614777a = self function_e2091339(21000, 0, 0, 0, &"ZM_MINECRAFT_SCORE_MILESTONE_COMPLETED_KILLS_7500", undefined, zombie, 1, 150, 1);
			self luinotifyevent(&"spx_milestone_notification", 2, &"ZM_MINECRAFT_MILESTONE_KILLS", 7500);
			return var_c614777a;
		}
		case "milestone_completed_kills_10000":
		{
			var_c614777a = self function_e2091339(25000, 0, 0, 0, &"ZM_MINECRAFT_SCORE_MILESTONE_COMPLETED_KILLS_10000", undefined, zombie, 1, 200, 1);
			self luinotifyevent(&"spx_milestone_notification", 2, &"ZM_MINECRAFT_MILESTONE_KILLS", 10000);
			return var_c614777a;
		}
		case "milestone_completed_kills_15000":
		{
			var_c614777a = self function_e2091339(33000, 0, 0, 0, &"ZM_MINECRAFT_SCORE_MILESTONE_COMPLETED_KILLS_15000", undefined, zombie, 1, 300, 1);
			self luinotifyevent(&"spx_milestone_notification", 2, &"ZM_MINECRAFT_MILESTONE_KILLS", 15000);
			return var_c614777a;
		}
		case "milestone_completed_kills_20000":
		{
			var_c614777a = self function_e2091339(43000, 0, 0, 0, &"ZM_MINECRAFT_SCORE_MILESTONE_COMPLETED_KILLS_20000", undefined, zombie, 1, 400, 1);
			self luinotifyevent(&"spx_milestone_notification", 2, &"ZM_MINECRAFT_MILESTONE_KILLS", 20000);
			return var_c614777a;
		}
		case "milestone_completed_kills_30000":
		{
			var_c614777a = self function_e2091339(48000, 0, 0, 0, &"ZM_MINECRAFT_SCORE_MILESTONE_COMPLETED_KILLS_30000", undefined, zombie, 1, 500, 1);
			self luinotifyevent(&"spx_milestone_notification", 2, &"ZM_MINECRAFT_MILESTONE_KILLS", 30000);
			return var_c614777a;
		}
		case "milestone_completed_kills_40000":
		{
			var_c614777a = self function_e2091339(54000, 0, 0, 0, &"ZM_MINECRAFT_SCORE_MILESTONE_COMPLETED_KILLS_40000", undefined, zombie, 1, 600, 1);
			self luinotifyevent(&"spx_milestone_notification", 2, &"ZM_MINECRAFT_MILESTONE_KILLS", 40000);
			return var_c614777a;
		}
		case "milestone_completed_kills_50000":
		{
			var_c614777a = self function_e2091339(60000, 0, 0, 0, &"ZM_MINECRAFT_SCORE_MILESTONE_COMPLETED_KILLS_50000", undefined, zombie, 1, 700, 1);
			self luinotifyevent(&"spx_milestone_notification", 2, &"ZM_MINECRAFT_MILESTONE_KILLS", 50000);
			return var_c614777a;
		}
		case "milestone_completed_kills_75000":
		{
			var_c614777a = self function_e2091339(66000, 0, 0, 0, &"ZM_MINECRAFT_SCORE_MILESTONE_COMPLETED_KILLS_75000", undefined, zombie, 1, 1000, 1);
			self luinotifyevent(&"spx_milestone_notification", 2, &"ZM_MINECRAFT_MILESTONE_KILLS", 75000);
			return var_c614777a;
		}
		case "milestone_completed_kills_100000":
		{
			var_c614777a = self function_e2091339(72000, 0, 0, 0, &"ZM_MINECRAFT_SCORE_MILESTONE_COMPLETED_KILLS_100000", undefined, zombie, 1, 1300, 1);
			self luinotifyevent(&"spx_milestone_notification", 2, &"ZM_MINECRAFT_MILESTONE_KILLS", 100000);
			return var_c614777a;
		}
		case "milestone_completed_headshots_250":
		{
			var_c614777a = self function_e2091339(4000, 0, 0, 0, &"ZM_MINECRAFT_SCORE_MILESTONE_COMPLETED_HEADSHOTS_250", undefined, zombie, 1, 10, 1);
			self luinotifyevent(&"spx_milestone_notification", 2, &"ZM_MINECRAFT_MILESTONE_HEADSHOTS", 250);
			return var_c614777a;
		}
		case "milestone_completed_headshots_500":
		{
			var_c614777a = self function_e2091339(5000, 0, 0, 0, &"ZM_MINECRAFT_SCORE_MILESTONE_COMPLETED_HEADSHOTS_500", undefined, zombie, 1, 15, 1);
			self luinotifyevent(&"spx_milestone_notification", 2, &"ZM_MINECRAFT_MILESTONE_HEADSHOTS", 500);
			return var_c614777a;
		}
		case "milestone_completed_headshots_750":
		{
			var_c614777a = self function_e2091339(6000, 0, 0, 0, &"ZM_MINECRAFT_SCORE_MILESTONE_COMPLETED_HEADSHOTS_750", undefined, zombie, 1, 20, 1);
			self luinotifyevent(&"spx_milestone_notification", 2, &"ZM_MINECRAFT_MILESTONE_HEADSHOTS", 750);
			return var_c614777a;
		}
		case "milestone_completed_headshots_1000":
		{
			var_c614777a = self function_e2091339(7000, 0, 0, 0, &"ZM_MINECRAFT_SCORE_MILESTONE_COMPLETED_HEADSHOTS_1000", undefined, zombie, 1, 25, 1);
			self luinotifyevent(&"spx_milestone_notification", 2, &"ZM_MINECRAFT_MILESTONE_HEADSHOTS", 1000);
			return var_c614777a;
		}
		case "milestone_completed_headshots_1250":
		{
			var_c614777a = self function_e2091339(8000, 0, 0, 0, &"ZM_MINECRAFT_SCORE_MILESTONE_COMPLETED_HEADSHOTS_1250", undefined, zombie, 1, 30, 1);
			self luinotifyevent(&"spx_milestone_notification", 2, &"ZM_MINECRAFT_MILESTONE_HEADSHOTS", 1250);
			return var_c614777a;
		}
		case "milestone_completed_headshots_1500":
		{
			var_c614777a = self function_e2091339(10000, 0, 0, 0, &"ZM_MINECRAFT_SCORE_MILESTONE_COMPLETED_HEADSHOTS_1500", undefined, zombie, 1, 40, 1);
			self luinotifyevent(&"spx_milestone_notification", 2, &"ZM_MINECRAFT_MILESTONE_HEADSHOTS", 1500);
			return var_c614777a;
		}
		case "milestone_completed_headshots_1750":
		{
			var_c614777a = self function_e2091339(12000, 0, 0, 0, &"ZM_MINECRAFT_SCORE_MILESTONE_COMPLETED_HEADSHOTS_1750", undefined, zombie, 1, 60, 1);
			self luinotifyevent(&"spx_milestone_notification", 2, &"ZM_MINECRAFT_MILESTONE_HEADSHOTS", 1750);
			return var_c614777a;
		}
		case "milestone_completed_headshots_2000":
		{
			var_c614777a = self function_e2091339(15000, 0, 0, 0, &"ZM_MINECRAFT_SCORE_MILESTONE_COMPLETED_HEADSHOTS_2000", undefined, zombie, 1, 80, 1);
			self luinotifyevent(&"spx_milestone_notification", 2, &"ZM_MINECRAFT_MILESTONE_HEADSHOTS", 2000);
			return var_c614777a;
		}
		case "milestone_completed_headshots_2500":
		{
			var_c614777a = self function_e2091339(18000, 0, 0, 0, &"ZM_MINECRAFT_SCORE_MILESTONE_COMPLETED_HEADSHOTS_2500", undefined, zombie, 1, 100, 1);
			self luinotifyevent(&"spx_milestone_notification", 2, &"ZM_MINECRAFT_MILESTONE_HEADSHOTS", 2500);
			return var_c614777a;
		}
		case "milestone_completed_headshots_3000":
		{
			var_c614777a = self function_e2091339(21000, 0, 0, 0, &"ZM_MINECRAFT_SCORE_MILESTONE_COMPLETED_HEADSHOTS_3000", undefined, zombie, 1, 150, 1);
			self luinotifyevent(&"spx_milestone_notification", 2, &"ZM_MINECRAFT_MILESTONE_HEADSHOTS", 3000);
			return var_c614777a;
		}
		case "milestone_completed_headshots_4000":
		{
			var_c614777a = self function_e2091339(25000, 0, 0, 0, &"ZM_MINECRAFT_SCORE_MILESTONE_COMPLETED_HEADSHOTS_4000", undefined, zombie, 1, 200, 1);
			self luinotifyevent(&"spx_milestone_notification", 2, &"ZM_MINECRAFT_MILESTONE_HEADSHOTS", 4000);
			return var_c614777a;
		}
		case "milestone_completed_headshots_5000":
		{
			var_c614777a = self function_e2091339(33000, 0, 0, 0, &"ZM_MINECRAFT_SCORE_MILESTONE_COMPLETED_HEADSHOTS_5000", undefined, zombie, 1, 300, 1);
			self luinotifyevent(&"spx_milestone_notification", 2, &"ZM_MINECRAFT_MILESTONE_HEADSHOTS", 5000);
			return var_c614777a;
		}
		case "milestone_completed_headshots_7500":
		{
			var_c614777a = self function_e2091339(43000, 0, 0, 0, &"ZM_MINECRAFT_SCORE_MILESTONE_COMPLETED_HEADSHOTS_7500", undefined, zombie, 1, 400, 1);
			self luinotifyevent(&"spx_milestone_notification", 2, &"ZM_MINECRAFT_MILESTONE_HEADSHOTS", 7500);
			return var_c614777a;
		}
		case "milestone_completed_headshots_10000":
		{
			var_c614777a = self function_e2091339(48000, 0, 0, 0, &"ZM_MINECRAFT_SCORE_MILESTONE_COMPLETED_HEADSHOTS_10000", undefined, zombie, 1, 500, 1);
			self luinotifyevent(&"spx_milestone_notification", 2, &"ZM_MINECRAFT_MILESTONE_HEADSHOTS", 10000);
			return var_c614777a;
		}
		case "milestone_completed_headshots_20000":
		{
			var_c614777a = self function_e2091339(54000, 0, 0, 0, &"ZM_MINECRAFT_SCORE_MILESTONE_COMPLETED_HEADSHOTS_20000", undefined, zombie, 1, 600, 1);
			self luinotifyevent(&"spx_milestone_notification", 2, &"ZM_MINECRAFT_MILESTONE_HEADSHOTS", 20000);
			return var_c614777a;
		}
		case "milestone_completed_headshots_30000":
		{
			var_c614777a = self function_e2091339(60000, 0, 0, 0, &"ZM_MINECRAFT_SCORE_MILESTONE_COMPLETED_HEADSHOTS_30000", undefined, zombie, 1, 700, 1);
			self luinotifyevent(&"spx_milestone_notification", 2, &"ZM_MINECRAFT_MILESTONE_HEADSHOTS", 30000);
			return var_c614777a;
		}
		case "milestone_completed_headshots_40000":
		{
			var_c614777a = self function_e2091339(66000, 0, 0, 0, &"ZM_MINECRAFT_SCORE_MILESTONE_COMPLETED_HEADSHOTS_40000", undefined, zombie, 1, 1000, 1);
			self luinotifyevent(&"spx_milestone_notification", 2, &"ZM_MINECRAFT_MILESTONE_HEADSHOTS", 40000);
			return var_c614777a;
		}
		case "milestone_completed_headshots_50000":
		{
			var_c614777a = self function_e2091339(72000, 0, 0, 0, &"ZM_MINECRAFT_SCORE_MILESTONE_COMPLETED_HEADSHOTS_50000", undefined, zombie, 1, 1300, 1);
			self luinotifyevent(&"spx_milestone_notification", 2, &"ZM_MINECRAFT_MILESTONE_HEADSHOTS", 50000);
			return var_c614777a;
		}
		case "milestone_completed_enchantment_2":
		{
			var_c614777a = self function_e2091339(2000, 0, 0, 0, &"ZM_MINECRAFT_SCORE_MILESTONE_COMPLETED_ENCHANTMENT_RARE", undefined, zombie, 1, 10, 1);
			self luinotifyevent(&"spx_milestone_notification", 3, &"ZM_MINECRAFT_MILESTONE_ENCHANTMENTS", 1, &"ZM_MINECRAFT_MILESTONE_COMPLETED_ENCHANTMENT_RARE");
			return var_c614777a;
		}
		case "milestone_completed_enchantment_3":
		{
			var_c614777a = self function_e2091339(3000, 0, 0, 0, &"ZM_MINECRAFT_SCORE_MILESTONE_COMPLETED_ENCHANTMENT_EPIC", undefined, zombie, 1, 20, 1);
			self luinotifyevent(&"spx_milestone_notification", 3, &"ZM_MINECRAFT_MILESTONE_ENCHANTMENTS", 2, &"ZM_MINECRAFT_MILESTONE_COMPLETED_ENCHANTMENT_EPIC");
			return var_c614777a;
		}
		case "milestone_completed_enchantment_4":
		{
			var_c614777a = self function_e2091339(4000, 0, 0, 0, &"ZM_MINECRAFT_SCORE_MILESTONE_COMPLETED_ENCHANTMENT_LEGENDARY", undefined, zombie, 1, 40, 1);
			self luinotifyevent(&"spx_milestone_notification", 3, &"ZM_MINECRAFT_MILESTONE_ENCHANTMENTS", 3, &"ZM_MINECRAFT_MILESTONE_COMPLETED_ENCHANTMENT_LEGENDARY");
			return var_c614777a;
		}
		case "milestone_completed_enchantment_5":
		{
			var_c614777a = self function_e2091339(6000, 0, 0, 0, &"ZM_MINECRAFT_SCORE_MILESTONE_COMPLETED_ENCHANTMENT_MYTHIC", undefined, zombie, 1, 60, 1);
			self luinotifyevent(&"spx_milestone_notification", 3, &"ZM_MINECRAFT_MILESTONE_ENCHANTMENTS", 4, &"ZM_MINECRAFT_MILESTONE_COMPLETED_ENCHANTMENT_MYTHIC");
			return var_c614777a;
		}
		case "milestone_completed_enchantment_6":
		{
			var_c614777a = self function_e2091339(8000, 0, 0, 0, &"ZM_MINECRAFT_SCORE_MILESTONE_COMPLETED_ENCHANTMENT_EXOTIC", undefined, zombie, 1, 80, 1);
			self luinotifyevent(&"spx_milestone_notification", 3, &"ZM_MINECRAFT_MILESTONE_ENCHANTMENTS", 5, &"ZM_MINECRAFT_MILESTONE_COMPLETED_ENCHANTMENT_EXOTIC");
			return var_c614777a;
		}
		case "milestone_completed_enchantment_7":
		{
			var_c614777a = self function_e2091339(11000, 0, 0, 0, &"ZM_MINECRAFT_SCORE_MILESTONE_COMPLETED_ENCHANTMENT_DIVINE", undefined, zombie, 1, 110, 1);
			self luinotifyevent(&"spx_milestone_notification", 3, &"ZM_MINECRAFT_MILESTONE_ENCHANTMENTS", 6, &"ZM_MINECRAFT_MILESTONE_COMPLETED_ENCHANTMENT_DIVINE");
			return var_c614777a;
		}
		case "milestone_completed_enchantment_8":
		{
			var_c614777a = self function_e2091339(14000, 0, 0, 0, &"ZM_MINECRAFT_SCORE_MILESTONE_COMPLETED_ENCHANTMENT_ETERNAL", undefined, zombie, 1, 130, 1);
			self luinotifyevent(&"spx_milestone_notification", 3, &"ZM_MINECRAFT_MILESTONE_ENCHANTMENTS", 7, &"ZM_MINECRAFT_MILESTONE_COMPLETED_ENCHANTMENT_ETERNAL");
			return var_c614777a;
		}
		case "milestone_completed_enchantment_9":
		{
			var_c614777a = self function_e2091339(18000, 0, 0, 0, &"ZM_MINECRAFT_SCORE_MILESTONE_COMPLETED_ENCHANTMENT_COSMIC", undefined, zombie, 1, 160, 1);
			self luinotifyevent(&"spx_milestone_notification", 3, &"ZM_MINECRAFT_MILESTONE_ENCHANTMENTS", 8, &"ZM_MINECRAFT_MILESTONE_COMPLETED_ENCHANTMENT_COSMIC");
			return var_c614777a;
		}
		case "milestone_completed_enchantment_10":
		{
			var_c614777a = self function_e2091339(22000, 0, 0, 0, &"ZM_MINECRAFT_SCORE_MILESTONE_COMPLETED_ENCHANTMENT_CELESTIAL", undefined, zombie, 1, 190, 1);
			self luinotifyevent(&"spx_milestone_notification", 3, &"ZM_MINECRAFT_MILESTONE_ENCHANTMENTS", 9, &"ZM_MINECRAFT_MILESTONE_COMPLETED_ENCHANTMENT_CELESTIAL");
			return var_c614777a;
		}
		case "milestone_completed_enchantment_11":
		{
			var_c614777a = self function_e2091339(26000, 0, 0, 0, &"ZM_MINECRAFT_SCORE_MILESTONE_COMPLETED_ENCHANTMENT_ULTIMATE", undefined, zombie, 1, 240, 1);
			self luinotifyevent(&"spx_milestone_notification", 3, &"ZM_MINECRAFT_MILESTONE_ENCHANTMENTS", 10, &"ZM_MINECRAFT_MILESTONE_COMPLETED_ENCHANTMENT_ULTIMATE");
			return var_c614777a;
		}
		case "succesful_exfil":
		{
			var_c614777a = self function_e2091339(15000, 500, 0, 0, &"ZM_MINECRAFT_SUCCESFUL_EXFIL", undefined, zombie, 0, 25, 1);
			return var_c614777a;
		}
		case "camo_1_obtained":
		{
			var_c614777a = self function_e2091339(2500, 0, 0, 0, &"ZM_MINECRAFT_SCORE_MILESTONE_CAMO_OBTAINED", undefined, zombie, 0, undefined, 1);
			return var_c614777a;
		}
		case "camo_2_obtained":
		{
			var_c614777a = self function_e2091339(3000, 0, 0, 0, &"ZM_MINECRAFT_SCORE_MILESTONE_CAMO_OBTAINED", undefined, zombie, 0, undefined, 1);
			return var_c614777a;
		}
		case "camo_3_obtained":
		{
			var_c614777a = self function_e2091339(4000, 0, 0, 0, &"ZM_MINECRAFT_SCORE_MILESTONE_CAMO_OBTAINED", undefined, zombie, 0, undefined, 1);
			return var_c614777a;
		}
		case "camo_4_obtained":
		{
			var_c614777a = self function_e2091339(5000, 0, 0, 0, &"ZM_MINECRAFT_SCORE_MILESTONE_CAMO_OBTAINED", undefined, zombie, 0, undefined, 1);
			return var_c614777a;
		}
		case "camo_5_obtained":
		{
			var_c614777a = self function_e2091339(6000, 0, 0, 0, &"ZM_MINECRAFT_SCORE_MILESTONE_CAMO_OBTAINED", undefined, zombie, 0, undefined, 1);
			return var_c614777a;
		}
		case "camo_6_obtained":
		{
			var_c614777a = self function_e2091339(8000, 0, 0, 0, &"ZM_MINECRAFT_SCORE_MILESTONE_CAMO_OBTAINED", undefined, zombie, 0, undefined, 1);
			return var_c614777a;
		}
		case "camo_7_obtained":
		{
			var_c614777a = self function_e2091339(10000, 0, 0, 0, &"ZM_MINECRAFT_SCORE_MILESTONE_CAMO_OBTAINED", undefined, zombie, 0, undefined, 1);
			return var_c614777a;
		}
		case "camo_8_obtained":
		{
			var_c614777a = self function_e2091339(12000, 0, 0, 0, &"ZM_MINECRAFT_SCORE_MILESTONE_CAMO_OBTAINED", undefined, zombie, 0, undefined, 1);
			return var_c614777a;
		}
		case "camo_9_obtained":
		{
			var_c614777a = self function_e2091339(14000, 0, 0, 0, &"ZM_MINECRAFT_SCORE_MILESTONE_CAMO_OBTAINED", undefined, zombie, 0, undefined, 1);
			return var_c614777a;
		}
		case "camo_10_obtained":
		{
			var_c614777a = self function_e2091339(16000, 0, 0, 0, &"ZM_MINECRAFT_SCORE_MILESTONE_CAMO_OBTAINED", undefined, zombie, 0, undefined, 1);
			return var_c614777a;
		}
		case "camo_11_obtained":
		{
			var_c614777a = self function_e2091339(18000, 0, 0, 0, &"ZM_MINECRAFT_SCORE_MILESTONE_CAMO_OBTAINED", undefined, zombie, 0, undefined, 1);
			return var_c614777a;
		}
		case "camo_12_obtained":
		{
			var_c614777a = self function_e2091339(20000, 0, 0, 0, &"ZM_MINECRAFT_SCORE_MILESTONE_CAMO_OBTAINED", undefined, zombie, 0, undefined, 1);
			return var_c614777a;
		}
		case "camo_13_obtained":
		{
			var_c614777a = self function_e2091339(22000, 0, 0, 0, &"ZM_MINECRAFT_SCORE_MILESTONE_CAMO_OBTAINED", undefined, zombie, 0, undefined, 1);
			return var_c614777a;
		}
		case "camo_14_obtained":
		{
			var_c614777a = self function_e2091339(24000, 0, 0, 0, &"ZM_MINECRAFT_SCORE_MILESTONE_CAMO_OBTAINED", undefined, zombie, 0, undefined, 1);
			return var_c614777a;
		}
		case "camo_15_obtained":
		{
			var_c614777a = self function_e2091339(26000, 0, 0, 0, &"ZM_MINECRAFT_SCORE_MILESTONE_CAMO_OBTAINED", undefined, zombie, 0, undefined, 1);
			return var_c614777a;
		}
		case "camo_16_obtained":
		{
			var_c614777a = self function_e2091339(28000, 0, 0, 0, &"ZM_MINECRAFT_SCORE_MILESTONE_CAMO_OBTAINED", undefined, zombie, 0, undefined, 1);
			return var_c614777a;
		}
		case "camo_17_obtained":
		{
			var_c614777a = self function_e2091339(30000, 0, 0, 0, &"ZM_MINECRAFT_SCORE_MILESTONE_CAMO_OBTAINED", undefined, zombie, 0, undefined, 1);
			return var_c614777a;
		}
		case "camo_18_obtained":
		{
			var_c614777a = self function_e2091339(32000, 0, 0, 0, &"ZM_MINECRAFT_SCORE_MILESTONE_CAMO_OBTAINED", undefined, zombie, 0, undefined, 1);
			return var_c614777a;
		}
		case "camo_19_obtained":
		{
			var_c614777a = self function_e2091339(34000, 0, 0, 0, &"ZM_MINECRAFT_SCORE_MILESTONE_CAMO_OBTAINED", undefined, zombie, 0, undefined, 1);
			return var_c614777a;
		}
		case "camo_20_obtained":
		{
			var_c614777a = self function_e2091339(36000, 0, 0, 0, &"ZM_MINECRAFT_SCORE_MILESTONE_CAMO_OBTAINED", undefined, zombie, 0, undefined, 1);
			return var_c614777a;
		}
		case "camo_21_obtained":
		{
			var_c614777a = self function_e2091339(38000, 0, 0, 0, &"ZM_MINECRAFT_SCORE_MILESTONE_CAMO_OBTAINED", undefined, zombie, 0, undefined, 1);
			return var_c614777a;
		}
		case "camo_22_obtained":
		{
			var_c614777a = self function_e2091339(40000, 0, 0, 0, &"ZM_MINECRAFT_SCORE_MILESTONE_CAMO_OBTAINED", undefined, zombie, 0, undefined, 1);
			return var_c614777a;
		}
		case "map_ee_completed_soe":
		{
			var_c614777a = self function_e2091339(125000, 0, 0, 0, &"ZM_MINECRAFT_SCORE_COMPLETED_SOE_EE", undefined, zombie, 0, 50, 1);
			self luinotifyevent(&"spx_milestone_notification", 2, &"ZM_MINECRAFT_COMPLETED_SOE_EE", 1);
			return var_c614777a;
		}
		case "map_ee_completed_giant":
		{
			var_c614777a = self function_e2091339(35000, 0, 0, 0, &"ZM_MINECRAFT_SCORE_COMPLETED_GIANT_EE", undefined, zombie, 0, 5, 1);
			self luinotifyevent(&"spx_milestone_notification", 2, &"ZM_MINECRAFT_COMPLETED_GIANT_EE", 2);
			return var_c614777a;
		}
		case "map_ee_completed_castle":
		{
			var_c614777a = self function_e2091339(125000, 0, 0, 0, &"ZM_MINECRAFT_SCORE_COMPLETED_CASTLE_EE", undefined, zombie, 0, 50, 1);
			self luinotifyevent(&"spx_milestone_notification", 2, &"ZM_MINECRAFT_COMPLETED_CASTLE_EE", 3);
			return var_c614777a;
		}
		case "map_ee_completed_island":
		{
			var_c614777a = self function_e2091339(125000, 0, 0, 0, &"ZM_MINECRAFT_SCORE_COMPLETED_ISLAND_EE", undefined, zombie, 0, 50, 1);
			self luinotifyevent(&"spx_milestone_notification", 2, &"ZM_MINECRAFT_COMPLETED_ISLAND_EE", 4);
			return var_c614777a;
		}
		case "map_ee_completed_gorod":
		{
			var_c614777a = self function_e2091339(125000, 0, 0, 0, &"ZM_MINECRAFT_SCORE_COMPLETED_GOROD_EE", undefined, zombie, 0, 50, 1);
			self luinotifyevent(&"spx_milestone_notification", 2, &"ZM_MINECRAFT_COMPLETED_GOROD_EE", 5);
			return var_c614777a;
		}
		case "map_ee_completed_rev":
		{
			var_c614777a = self function_e2091339(150000, 0, 0, 0, &"ZM_MINECRAFT_SCORE_COMPLETED_REV_EE", undefined, zombie, 0, 50, 1);
			self luinotifyevent(&"spx_milestone_notification", 2, &"ZM_MINECRAFT_COMPLETED_REV_EE", 6);
			return var_c614777a;
		}
		case "map_ee_completed_nacht":
		{
			var_c614777a = self function_e2091339(2500, 0, 0, 0, &"ZM_MINECRAFT_SCORE_COMPLETED_NACHT_EE", undefined, zombie, 0, 5, 1);
			self luinotifyevent(&"spx_milestone_notification", 2, &"ZM_MINECRAFT_COMPLETED_NACHT_EE", 7);
			return var_c614777a;
		}
		case "map_ee_completed_verruckt":
		{
			var_c614777a = self function_e2091339(2500, 0, 0, 0, &"ZM_MINECRAFT_SCORE_COMPLETED_VERRUCKT_EE", undefined, zombie, 0, 5, 1);
			self luinotifyevent(&"spx_milestone_notification", 2, &"ZM_MINECRAFT_COMPLETED_VERRUCKT_EE", 8);
			return var_c614777a;
		}
		case "map_ee_completed_shino":
		{
			var_c614777a = self function_e2091339(2500, 0, 0, 0, &"ZM_MINECRAFT_SCORE_COMPLETED_SHINO_EE", undefined, zombie, 0, 5, 1);
			self luinotifyevent(&"spx_milestone_notification", 2, &"ZM_MINECRAFT_COMPLETED_SHINO_EE", 9);
			return var_c614777a;
		}
		case "map_ee_completed_kino":
		{
			var_c614777a = self function_e2091339(2500, 0, 0, 0, &"ZM_MINECRAFT_SCORE_COMPLETED_KINO_EE", undefined, zombie, 0, 5, 1);
			self luinotifyevent(&"spx_milestone_notification", 2, &"ZM_MINECRAFT_COMPLETED_KINO_EE", 10);
			return var_c614777a;
		}
		case "map_ee_completed_ascension":
		{
			var_c614777a = self function_e2091339(50000, 0, 0, 0, &"ZM_MINECRAFT_SCORE_COMPLETED_ASCENSION_EE", undefined, zombie, 0, 25, 1);
			self luinotifyevent(&"spx_milestone_notification", 2, &"ZM_MINECRAFT_COMPLETED_ASCENSION_EE", 11);
			return var_c614777a;
		}
		case "map_ee_completed_shangri":
		{
			var_c614777a = self function_e2091339(75000, 0, 0, 0, &"ZM_MINECRAFT_SCORE_COMPLETED_SHANGRI_EE", undefined, zombie, 0, 30, 1);
			self luinotifyevent(&"spx_milestone_notification", 2, &"ZM_MINECRAFT_COMPLETED_SHANGRI_EE", 12);
			return var_c614777a;
		}
		case "map_ee_completed_moon":
		{
			var_c614777a = self function_e2091339(125000, 0, 0, 0, &"ZM_MINECRAFT_SCORE_COMPLETED_MOON_EE", undefined, zombie, 0, 40, 1);
			self luinotifyevent(&"spx_milestone_notification", 2, &"ZM_MINECRAFT_COMPLETED_MOON_EE", 13);
			return var_c614777a;
		}
		case "map_ee_completed_origins":
		{
			var_c614777a = self function_e2091339(150000, 0, 0, 0, &"ZM_MINECRAFT_SCORE_COMPLETED_ORIGINS_EE", undefined, zombie, 0, 50, 1);
			self luinotifyevent(&"spx_milestone_notification", 2, &"ZM_MINECRAFT_COMPLETED_ORIGINS_EE", 14);
			return var_c614777a;
		}
		case "map_ee_completed_cotd":
		{
			var_c614777a = self function_e2091339(75000, 0, 0, 0, &"ZM_MINECRAFT_SCORE_COMPLETED_COTD_EE", undefined, zombie, 0, 25, 1);
			self luinotifyevent(&"spx_milestone_notification", 2, &"ZM_MINECRAFT_COMPLETED_COTD_EE", 15);
			return var_c614777a;
		}
		case "map_ee_completed_sanctuary":
		{
			var_c614777a = self function_e2091339(50000, 0, 0, 0, &"ZM_MINECRAFT_SCORE_COMPLETED_SANCTUARY_EE", undefined, zombie, 0, 15, 1);
			self luinotifyevent(&"spx_milestone_notification", 2, &"ZM_MINECRAFT_COMPLETED_SANCTUARY_EE", 16);
			return var_c614777a;
		}
		case "map_ee_completed":
		{
			var_c614777a = self function_e2091339(12500, 0, 0, 0, &"ZM_MINECRAFT_SCORE_COMPLETED_GENERIC_EE", undefined, zombie, 0, 15, 1);
			self luinotifyevent(&"spx_milestone_notification", 2, &"ZM_MINECRAFT_COMPLETED_GENERIC_EE", 16);
			return var_c614777a;
		}
		case "daily_challenge":
		{
			var_c614777a = self function_e2091339(amount, 0, 0, 0, &"ZM_MINECRAFT_SCORE_DAILY_CHALLENGE", undefined, zombie, 0, undefined, 1);
			self luinotifyevent(&"spx_milestone_notification", 3, &"ZM_MINECRAFT_DAILY_CHALLENGE", 8, &"ZM_MINECRAFT_DAILY_CHALLENGE");
			return var_c614777a;
		}
		case "christmas_present":
		{
			var_c614777a = self function_e2091339(amount, 0, 0, 0, &"ZM_MINECRAFT_SCORE_PICKUP_PRESENT", undefined, zombie);
			return var_c614777a;
		}
		case "ghost_soul":
		{
			var_c614777a = self function_e2091339(amount, 0, 0, 0, &"ZM_MINECRAFT_SCORE_PICKUP_GHOST_SOUL", undefined, zombie);
			return var_c614777a;
		}
		case "xp_reward":
		{
			var_c614777a = self function_e2091339(amount, 0, 0, 0, &"ZM_MINECRAFT_XP_REWARD", undefined, zombie);
			return var_c614777a;
		}
		case "picked_up_full_ammo":
		{
			var_c614777a = self function_e2091339(500, 0, 0, 0, &"ZM_MINECRAFT_POWERUP_MAX_AMMO", undefined, zombie);
			return var_c614777a;
		}
		case "picked_up_double_points":
		{
			var_c614777a = self function_e2091339(500, 0, 0, 0, &"ZM_MINECRAFT_POWERUP_DOUBLE_POINTS", undefined, zombie);
			return var_c614777a;
		}
		case "picked_up_insta_kill":
		{
			var_c614777a = self function_e2091339(400, 0, 0, 0, &"ZM_MINECRAFT_POWERUP_INSTA_KILL", undefined, zombie);
			return var_c614777a;
		}
		case "picked_up_carpenter":
		{
			var_c614777a = self function_e2091339(1000, 0, 0, 0, &"ZM_MINECRAFT_POWERUP_CARPENTER", undefined, zombie);
			return var_c614777a;
		}
		case "picked_up_fire_sale":
		{
			var_c614777a = self function_e2091339(500, 0, 0, 0, &"ZM_MINECRAFT_POWERUP_FIRE_SALE", undefined, zombie);
			return var_c614777a;
		}
		case "picked_up_minigun":
		{
			var_c614777a = self function_e2091339(400, 0, 0, 0, &"ZM_MINECRAFT_POWERUP_MINIGUN", undefined, zombie);
			return var_c614777a;
		}
		case "picked_up_nuke":
		{
			var_c614777a = self function_e2091339(800, 0, 0, 0, &"ZM_MINECRAFT_POWERUP_NUKE", undefined, zombie);
			return var_c614777a;
		}
		case "picked_up_bonus_points_team":
		{
			var_c614777a = self function_e2091339(250, 0, 0, 0, &"ZM_MINECRAFT_POWERUP_BONUS_POINTS", undefined, zombie);
			return var_c614777a;
		}
		case "halloween_challenge_hc2_kills":
		{
			var_c614777a = self function_e2091339(amount, 0, 0, 0, &"ZM_MINECRAFT_SCORE_DAILY_CHALLENGE", undefined, zombie, 0, undefined, 1);
			self luinotifyevent(&"spx_milestone_notification", 3, &"ZM_MINECRAFT_HALLOWEEN_CHALLENGE", 8, 1);
			return var_c614777a;
		}
		case "halloween_challenge_hc2_headshots":
		{
			var_c614777a = self function_e2091339(amount, 0, 0, 0, &"ZM_MINECRAFT_SCORE_DAILY_CHALLENGE", undefined, zombie, 0, undefined, 1);
			self luinotifyevent(&"spx_milestone_notification", 3, &"ZM_MINECRAFT_HALLOWEEN_CHALLENGE", 8, 2);
			return var_c614777a;
		}
		case "halloween_challenge_hc2_rounds":
		{
			var_c614777a = self function_e2091339(amount, 0, 0, 0, &"ZM_MINECRAFT_SCORE_DAILY_CHALLENGE", undefined, zombie, 0, undefined, 1);
			self luinotifyevent(&"spx_milestone_notification", 3, &"ZM_MINECRAFT_HALLOWEEN_CHALLENGE", 8, 3);
			return var_c614777a;
		}
		case "halloween_challenge_hc2_trick_or_treat":
		{
			var_c614777a = self function_e2091339(amount, 0, 0, 0, &"ZM_MINECRAFT_SCORE_DAILY_CHALLENGE", undefined, zombie, 0, undefined, 1);
			self luinotifyevent(&"spx_milestone_notification", 3, &"ZM_MINECRAFT_HALLOWEEN_CHALLENGE", 8, 4);
			return var_c614777a;
		}
		case "halloween_challenge_hc2_ghost_kills":
		{
			var_c614777a = self function_e2091339(amount, 0, 0, 0, &"ZM_MINECRAFT_SCORE_DAILY_CHALLENGE", undefined, zombie, 0, undefined, 1);
			self luinotifyevent(&"spx_milestone_notification", 3, &"ZM_MINECRAFT_HALLOWEEN_CHALLENGE", 8, 5);
			return var_c614777a;
		}
		case "halloween_challenge_hc2_spend_points":
		{
			var_c614777a = self function_e2091339(amount, 0, 0, 0, &"ZM_MINECRAFT_SCORE_DAILY_CHALLENGE", undefined, zombie, 0, undefined, 1);
			self luinotifyevent(&"spx_milestone_notification", 3, &"ZM_MINECRAFT_HALLOWEEN_CHALLENGE", 8, 6);
			return var_c614777a;
		}
		case "halloween_challenge_hc2_repack":
		{
			var_c614777a = self function_e2091339(amount, 0, 0, 0, &"ZM_MINECRAFT_SCORE_DAILY_CHALLENGE", undefined, zombie, 0, undefined, 1);
			self luinotifyevent(&"spx_milestone_notification", 3, &"ZM_MINECRAFT_HALLOWEEN_CHALLENGE", 8, 7);
			return var_c614777a;
		}
		case "halloween_challenge_hc2_random_box":
		{
			var_c614777a = self function_e2091339(amount, 0, 0, 0, &"ZM_MINECRAFT_SCORE_DAILY_CHALLENGE", undefined, zombie, 0, undefined, 1);
			self luinotifyevent(&"spx_milestone_notification", 3, &"ZM_MINECRAFT_HALLOWEEN_CHALLENGE", 8, 8);
			return var_c614777a;
		}
		case "halloween_challenge_hc2_rapidkills":
		{
			var_c614777a = self function_e2091339(amount, 0, 0, 0, &"ZM_MINECRAFT_SCORE_DAILY_CHALLENGE", undefined, zombie, 0, undefined, 1);
			self luinotifyevent(&"spx_milestone_notification", 3, &"ZM_MINECRAFT_HALLOWEEN_CHALLENGE", 8, 9);
			return var_c614777a;
		}
		case "halloween_challenge_hc2_melee_kills":
		{
			var_c614777a = self function_e2091339(amount, 0, 0, 0, &"ZM_MINECRAFT_SCORE_DAILY_CHALLENGE", undefined, zombie, 0, undefined, 1);
			self luinotifyevent(&"spx_milestone_notification", 3, &"ZM_MINECRAFT_HALLOWEEN_CHALLENGE", 8, 10);
			return var_c614777a;
		}
		case "halloween_challenge_hc2_perks_purchased":
		{
			var_c614777a = self function_e2091339(amount, 0, 0, 0, &"ZM_MINECRAFT_SCORE_DAILY_CHALLENGE", undefined, zombie, 0, undefined, 1);
			self luinotifyevent(&"spx_milestone_notification", 3, &"ZM_MINECRAFT_HALLOWEEN_CHALLENGE", 8, 11);
			return var_c614777a;
		}
		case "halloween_challenge_hc2_ads_kills":
		{
			var_c614777a = self function_e2091339(amount, 0, 0, 0, &"ZM_MINECRAFT_SCORE_DAILY_CHALLENGE", undefined, zombie, 0, undefined, 1);
			self luinotifyevent(&"spx_milestone_notification", 3, &"ZM_MINECRAFT_HALLOWEEN_CHALLENGE", 8, 12);
			return var_c614777a;
		}
		case "halloween_challenge_hc2_crouch_kills":
		{
			var_c614777a = self function_e2091339(amount, 0, 0, 0, &"ZM_MINECRAFT_SCORE_DAILY_CHALLENGE", undefined, zombie, 0, undefined, 1);
			self luinotifyevent(&"spx_milestone_notification", 3, &"ZM_MINECRAFT_HALLOWEEN_CHALLENGE", 8, 13);
			return var_c614777a;
		}
		case "halloween_challenge_hc2_round_35_five_times":
		{
			var_c614777a = self function_e2091339(amount, 0, 0, 0, &"ZM_MINECRAFT_SCORE_DAILY_CHALLENGE", undefined, zombie, 0, undefined, 1);
			self luinotifyevent(&"spx_milestone_notification", 3, &"ZM_MINECRAFT_HALLOWEEN_CHALLENGE", 8, 14);
			return var_c614777a;
		}
		case "halloween_challenge_hc2_single_game_headshots":
		{
			var_c614777a = self function_e2091339(amount, 0, 0, 0, &"ZM_MINECRAFT_SCORE_DAILY_CHALLENGE", undefined, zombie, 0, undefined, 1);
			self luinotifyevent(&"spx_milestone_notification", 3, &"ZM_MINECRAFT_HALLOWEEN_CHALLENGE", 8, 15);
			return var_c614777a;
		}
		case "halloween_challenge_hc2_sniper_kills":
		{
			var_c614777a = self function_e2091339(amount, 0, 0, 0, &"ZM_MINECRAFT_SCORE_DAILY_CHALLENGE", undefined, zombie, 0, undefined, 1);
			self luinotifyevent(&"spx_milestone_notification", 3, &"ZM_MINECRAFT_HALLOWEEN_CHALLENGE", 8, 16);
			return var_c614777a;
		}
		case "halloween_challenge_hc2_pistol_kills":
		{
			var_c614777a = self function_e2091339(amount, 0, 0, 0, &"ZM_MINECRAFT_SCORE_DAILY_CHALLENGE", undefined, zombie, 0, undefined, 1);
			self luinotifyevent(&"spx_milestone_notification", 3, &"ZM_MINECRAFT_HALLOWEEN_CHALLENGE", 8, 17);
			return var_c614777a;
		}
		case "halloween_challenge_hc2_ar_kills":
		{
			var_c614777a = self function_e2091339(amount, 0, 0, 0, &"ZM_MINECRAFT_SCORE_DAILY_CHALLENGE", undefined, zombie, 0, undefined, 1);
			self luinotifyevent(&"spx_milestone_notification", 3, &"ZM_MINECRAFT_HALLOWEEN_CHALLENGE", 8, 18);
			return var_c614777a;
		}
		case "halloween_challenge_hc2_shotgun_kills":
		{
			var_c614777a = self function_e2091339(amount, 0, 0, 0, &"ZM_MINECRAFT_SCORE_DAILY_CHALLENGE", undefined, zombie, 0, undefined, 1);
			self luinotifyevent(&"spx_milestone_notification", 3, &"ZM_MINECRAFT_HALLOWEEN_CHALLENGE", 8, 19);
			return var_c614777a;
		}
		case "halloween_challenge_hc2_smg_kills":
		{
			var_c614777a = self function_e2091339(amount, 0, 0, 0, &"ZM_MINECRAFT_SCORE_DAILY_CHALLENGE", undefined, zombie, 0, undefined, 1);
			self luinotifyevent(&"spx_milestone_notification", 3, &"ZM_MINECRAFT_HALLOWEEN_CHALLENGE", 8, 20);
			return var_c614777a;
		}
		case "halloween_challenge_hc2_hipfire_kills":
		{
			var_c614777a = self function_e2091339(amount, 0, 0, 0, &"ZM_MINECRAFT_SCORE_DAILY_CHALLENGE", undefined, zombie, 0, undefined, 1);
			self luinotifyevent(&"spx_milestone_notification", 3, &"ZM_MINECRAFT_HALLOWEEN_CHALLENGE", 8, 21);
			return var_c614777a;
		}
		case "halloween_challenge_hc2_no_damage_rounds":
		{
			var_c614777a = self function_e2091339(amount, 0, 0, 0, &"ZM_MINECRAFT_SCORE_DAILY_CHALLENGE", undefined, zombie, 0, undefined, 1);
			self luinotifyevent(&"spx_milestone_notification", 3, &"ZM_MINECRAFT_HALLOWEEN_CHALLENGE", 8, 22);
			return var_c614777a;
		}
		case "halloween_challenge_hc2_fire_sale_weapons":
		{
			var_c614777a = self function_e2091339(amount, 0, 0, 0, &"ZM_MINECRAFT_SCORE_DAILY_CHALLENGE", undefined, zombie, 0, undefined, 1);
			self luinotifyevent(&"spx_milestone_notification", 3, &"ZM_MINECRAFT_HALLOWEEN_CHALLENGE", 8, 23);
			return var_c614777a;
		}
		case "halloween_challenge_hc2_trick_or_treat_single_game":
		{
			var_c614777a = self function_e2091339(amount, 0, 0, 0, &"ZM_MINECRAFT_SCORE_DAILY_CHALLENGE", undefined, zombie, 0, undefined, 1);
			self luinotifyevent(&"spx_milestone_notification", 3, &"ZM_MINECRAFT_HALLOWEEN_CHALLENGE", 8, 24);
			return var_c614777a;
		}
		case "halloween_challenge_hc2_perk_master":
		{
			var_c614777a = self function_e2091339(amount, 0, 0, 0, &"ZM_MINECRAFT_SCORE_DAILY_CHALLENGE", undefined, zombie, 0, undefined, 1);
			self luinotifyevent(&"spx_milestone_notification", 3, &"ZM_MINECRAFT_HALLOWEEN_CHALLENGE", 8, 25);
			return var_c614777a;
		}
		case "halloween_challenge_hc2_explosive_kills":
		{
			var_c614777a = self function_e2091339(amount, 0, 0, 0, &"ZM_MINECRAFT_SCORE_DAILY_CHALLENGE", undefined, zombie, 0, undefined, 1);
			self luinotifyevent(&"spx_milestone_notification", 3, &"ZM_MINECRAFT_HALLOWEEN_CHALLENGE", 8, 26);
			return var_c614777a;
		}
		case "halloween_challenge_hc2_lmg_kills":
		{
			var_c614777a = self function_e2091339(amount, 0, 0, 0, &"ZM_MINECRAFT_SCORE_DAILY_CHALLENGE", undefined, zombie, 0, undefined, 1);
			self luinotifyevent(&"spx_milestone_notification", 3, &"ZM_MINECRAFT_HALLOWEEN_CHALLENGE", 8, 27);
			return var_c614777a;
		}
		case "halloween_challenge_hc2_consecutive_headshots":
		{
			var_c614777a = self function_e2091339(amount, 0, 0, 0, &"ZM_MINECRAFT_SCORE_DAILY_CHALLENGE", undefined, zombie, 0, undefined, 1);
			self luinotifyevent(&"spx_milestone_notification", 3, &"ZM_MINECRAFT_HALLOWEEN_CHALLENGE", 8, 28);
			return var_c614777a;
		}
		case "halloween_challenge_hc2_longshot_pap_kills":
		{
			var_c614777a = self function_e2091339(amount, 0, 0, 0, &"ZM_MINECRAFT_SCORE_DAILY_CHALLENGE", undefined, zombie, 0, undefined, 1);
			self luinotifyevent(&"spx_milestone_notification", 3, &"ZM_MINECRAFT_HALLOWEEN_CHALLENGE", 8, 29);
			return var_c614777a;
		}
		case "halloween_challenge_hc2_upgraded_kills":
		{
			var_c614777a = self function_e2091339(amount, 0, 0, 0, &"ZM_MINECRAFT_SCORE_DAILY_CHALLENGE", undefined, zombie, 0, undefined, 1);
			self luinotifyevent(&"spx_milestone_notification", 3, &"ZM_MINECRAFT_HALLOWEEN_CHALLENGE", 8, 30);
			return var_c614777a;
		}
		case "halloween_challenge_hc2_perfect_game":
		{
			var_c614777a = self function_e2091339(amount, 0, 0, 0, &"ZM_MINECRAFT_SCORE_DAILY_CHALLENGE", undefined, zombie, 0, undefined, 1);
			self luinotifyevent(&"spx_milestone_notification", 3, &"ZM_MINECRAFT_HALLOWEEN_CHALLENGE", 8, 31);
			return var_c614777a;
		}
		case "halloween_challenge_hc2_complete_round_challenges":
		{
			var_c614777a = self function_e2091339(amount, 0, 0, 0, &"ZM_MINECRAFT_SCORE_DAILY_CHALLENGE", undefined, zombie, 0, undefined, 1);
			self luinotifyevent(&"spx_milestone_notification", 3, &"ZM_MINECRAFT_HALLOWEEN_CHALLENGE", 8, 32);
			return var_c614777a;
		}
		case "halloween_challenge_hc2_kill_challenges_complete":
		{
			var_c614777a = self function_e2091339(amount, 0, 0, 0, &"ZM_MINECRAFT_SCORE_DAILY_CHALLENGE", undefined, zombie, 0, undefined, 1);
			self luinotifyevent(&"spx_milestone_notification", 3, &"ZM_MINECRAFT_HALLOWEEN_CHALLENGE", 8, 33);
			return var_c614777a;
		}
		case "halloween_challenge_hc2_all_challenges":
		{
			var_c614777a = self function_e2091339(amount, 0, 0, 0, &"ZM_MINECRAFT_SCORE_DAILY_CHALLENGE", undefined, zombie, 0, undefined, 1);
			self luinotifyevent(&"spx_milestone_notification", 3, &"ZM_MINECRAFT_HALLOWEEN_CHALLENGE", 8, 34);
			return var_c614777a;
		}
	}
	return 100;
}

/*
	Name: function_cd26638e
	Namespace: namespace_97ac1184
	Checksum: 0x424F4353
	Offset: 0x22200
	Size: 0x158
	Parameters: 0
	Flags: None
	Line Number: 7598
*/
function function_cd26638e()
{
	var_6f4e8832 = array(2500);
	if(level.round_number <= 10)
	{
		var_6f4e8832 = array(1000, 1500, 2000, 2500, 3000, 4000);
	}
	else if(level.round_number > 10 && level.round_number <= 40)
	{
		var_6f4e8832 = array(3000, 3500, 4000, 4500, 5000, 6000);
	}
	else if(level.round_number > 40 && level.round_number <= 80)
	{
		var_6f4e8832 = array(6000, 6500, 7000, 7500, 8000, 10000);
	}
	else
	{
		var_6f4e8832 = array(14000, 16000, 18000, 20000, 22500, 25000);
	}
	return var_6f4e8832[randomintrange(0, 5)];
}

/*
	Name: function_f771591b
	Namespace: namespace_97ac1184
	Checksum: 0x424F4353
	Offset: 0x22360
	Size: 0x2C0
	Parameters: 1
	Flags: Private
	Line Number: 7630
*/
function private function_f771591b(var_34d37a48)
{
	function_8b57c052("reward", "");
	for(;;)
	{
		wait(0.05);
		dvar_value = tolower(getdvarstring("reward", ""));
		if(isdefined(dvar_value) && dvar_value != "")
		{
			function_8b57c052("reward", "");
			var_cde9f622 = strtok(dvar_value, " ");
			if(var_cde9f622.size > 1)
			{
				reward = int(var_cde9f622[0]);
				value = int(var_cde9f622[1]);
				foreach(player in getplayers())
				{
					player function_7e18304e("r" + reward, value);
					iprintlnbold("^5Dev: Changed Reward " + reward + " to " + value);
				}
			}
			else
			{
				iprintlnbold("^5Dev: Need a value of 0 or 1");
			}
			foreach(player in getplayers())
			{
				player function_7e18304e("r" + dvar_value, 1);
			}
		}
	}
}

/*
	Name: function_9201588b
	Namespace: namespace_97ac1184
	Checksum: 0x424F4353
	Offset: 0x22628
	Size: 0xE8
	Parameters: 1
	Flags: Private
	Line Number: 7673
*/
function private function_9201588b(var_34d37a48)
{
	function_8b57c052("vip", "");
	for(;;)
	{
		wait(0.05);
		dvar_value = getdvarstring("vip", "");
		if(isdefined(dvar_value) && dvar_value != "")
		{
			function_8b57c052("vip", "");
			iprintlnbold(dvar_value);
			getplayers()[0] SetControllerUIModelValue("UEM.send_vip_code", dvar_value);
		}
	}
}

/*
	Name: function_554820a1
	Namespace: namespace_97ac1184
	Checksum: 0x424F4353
	Offset: 0x22718
	Size: 0x2A8
	Parameters: 1
	Flags: Private
	Line Number: 7699
*/
function private function_554820a1(var_34d37a48)
{
	function_8b57c052("legend", "");
	for(;;)
	{
		wait(0.05);
		dvar_value = tolower(getdvarstring("legend", ""));
		if(isdefined(dvar_value) && dvar_value != "")
		{
			function_8b57c052("legend", "");
			if(dvar_value == "reset")
			{
				foreach(player in getplayers())
				{
					if(isdefined(player.var_b74a3cd1["prestige"]) && player.var_b74a3cd1["prestige"] == 20 && player.var_b74a3cd1["level"] == 1000)
					{
						player.var_b74a3cd1["prestige_legend"]++;
						player.var_b74a3cd1["prestige"] = int(0);
						player.var_b74a3cd1["level"] = int(1);
						player.var_b74a3cd1["xp"] = int(0);
						player thread function_48c20fe();
						player luinotifyevent(&"spx_rank_up_notification", 2, 3, int(player.var_b74a3cd1["prestige_legend"]));
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
	Offset: 0x229C8
	Size: 0x13A0
	Parameters: 1
	Flags: None
	Line Number: 7739
*/
function function_a6695a32(var_34d37a48)
{
	function_8b57c052("leveling", "");
	for(;;)
	{
		wait(0.05);
		dvar_value = tolower(getdvarstring("leveling", ""));
		if(isdefined(dvar_value) && dvar_value != "")
		{
			function_8b57c052("leveling", "");
			var_cde9f622 = strtok(dvar_value, " ");
			if(var_cde9f622.size > 1)
			{
				type = var_cde9f622[0];
				value = int(var_cde9f622[1]);
				player_index = int(var_cde9f622[2]);
				switch(type)
				{
					case "level":
					{
						if(player_index >= 0 && player_index <= 7)
						{
							level.players[player_index].var_b74a3cd1["level"] = int(value);
							level.players[player_index] thread function_48c20fe();
						}
						else
						{
							foreach(player in getplayers())
							{
								player.var_b74a3cd1["level"] = int(value);
								player thread function_48c20fe();
							}
							break;
						}
					}
					case "prestige":
					{
						if(player_index >= 0 && player_index <= 7)
						{
							level.players[player_index].var_b74a3cd1["prestige"] = int(value);
							level.players[player_index] thread function_48c20fe();
						}
						else
						{
							foreach(player in getplayers())
							{
								player.var_b74a3cd1["prestige"] = int(value);
								player thread function_48c20fe();
							}
							break;
						}
					}
					case "xp":
					{
						if(player_index >= 0 && player_index <= 7)
						{
							level.players[player_index] notify("hash_79ef118b", undefined, int(value));
						}
						else
						{
							foreach(player in getplayers())
							{
								player notify("hash_79ef118b", undefined, int(value));
							}
							break;
						}
					}
					case "xp_set":
					{
						if(player_index >= 0 && player_index <= 7)
						{
							level.players[player_index].var_b74a3cd1["xp"] = int(value);
							level.players[player_index] thread function_48c20fe();
						}
						else
						{
							foreach(player in getplayers())
							{
								player.var_b74a3cd1["xp"] = int(value);
								player thread function_48c20fe();
							}
							break;
						}
					}
					case "legend":
					{
						if(player_index >= 0 && player_index <= 7)
						{
							level.players[player_index].var_b74a3cd1["prestige_legend"] = int(value);
							level.players[player_index] thread function_48c20fe();
						}
						else
						{
							foreach(player in getplayers())
							{
								player.var_b74a3cd1["prestige_legend"] = int(value);
								player thread function_48c20fe();
							}
							break;
						}
					}
					case "absolute":
					{
						if(player_index >= 0 && player_index <= 7)
						{
							level.players[player_index].var_b74a3cd1["prestige_absolute"] = int(value);
							level.players[player_index] thread function_48c20fe();
						}
						else
						{
							foreach(player in getplayers())
							{
								player.var_b74a3cd1["prestige_absolute"] = int(value);
								player thread function_48c20fe();
							}
							break;
						}
					}
					case "ultimate":
					{
						if(player_index >= 0 && player_index <= 7)
						{
							level.players[player_index].var_b74a3cd1["prestige_ultimate"] = int(value);
							level.players[player_index] thread function_48c20fe();
						}
						else
						{
							foreach(player in getplayers())
							{
								player.var_b74a3cd1["prestige_ultimate"] = int(value);
								player thread function_48c20fe();
							}
							break;
						}
					}
					case "brutal_rank":
					{
						if(player_index >= 0 && player_index <= 7)
						{
							level.players[player_index].var_b74a3cd1["brutal_rank"] = int(value);
							level.players[player_index] thread function_48c20fe();
						}
						else
						{
							foreach(player in getplayers())
							{
								player.var_b74a3cd1["brutal_rank"] = int(value);
								player thread function_48c20fe();
							}
							break;
						}
					}
					case "brutal_xp":
					{
						if(player_index >= 0 && player_index <= 7)
						{
							level.players[player_index] thread function_adc67b81(int(value));
						}
						else
						{
							foreach(player in getplayers())
							{
								player thread function_adc67b81(int(value));
							}
							break;
						}
					}
					case "brutal_xp_set":
					{
						if(player_index >= 0 && player_index <= 7)
						{
							level.players[player_index].var_b74a3cd1["brutal_xp"] = int(value);
							level.players[player_index] thread function_48c20fe();
						}
						else
						{
							foreach(player in getplayers())
							{
								player.var_b74a3cd1["brutal_xp"] = int(value);
								player thread function_48c20fe();
							}
							break;
						}
					}
					case "weapon_level":
					{
						if(player_index >= 0 && player_index <= 7)
						{
							var_480fed80 = level.players[player_index] namespace_5e1f56dc::function_1c1990e8(level.players[player_index] getcurrentweapon());
							if(isdefined(var_480fed80))
							{
								var_480fed80.var_4c25c2f2 = int(value);
								level.players[player_index] luinotifyevent(&"spx_gun_level", 2, int(var_480fed80.var_79fe8f18), int(level.var_ce9bfb71[var_480fed80.var_4c25c2f2]));
							}
							else
							{
								iprintlnbold("^8Dev: ^7Weapon does not exist in list");
							}
						}
						else
						{
							foreach(player in getplayers())
							{
								var_480fed80 = player namespace_5e1f56dc::function_1c1990e8(player getcurrentweapon());
								if(isdefined(var_480fed80))
								{
									var_480fed80.var_4c25c2f2 = int(value);
									player luinotifyevent(&"spx_gun_level", 2, int(var_480fed80.var_79fe8f18), int(level.var_ce9bfb71[var_480fed80.var_4c25c2f2]));
									continue;
								}
								iprintlnbold("^8Dev: ^7Weapon does not exist in list");
							}
							break;
						}
					}
					case "weapon_xp":
					{
						if(player_index >= 0 && player_index <= 7)
						{
							var_480fed80 = level.players[player_index] namespace_5e1f56dc::function_1c1990e8(level.players[player_index] getcurrentweapon());
							if(isdefined(var_480fed80))
							{
								var_480fed80.var_79fe8f18 = int(value);
								level.players[player_index] luinotifyevent(&"spx_gun_level", 2, int(var_480fed80.var_79fe8f18), int(level.var_ce9bfb71[var_480fed80.var_4c25c2f2]));
							}
							else
							{
								iprintlnbold("^8Dev: ^7Weapon does not exist in list");
							}
						}
						else
						{
							foreach(player in getplayers())
							{
								var_480fed80 = player namespace_5e1f56dc::function_1c1990e8(player getcurrentweapon());
								if(isdefined(var_480fed80))
								{
									var_480fed80.var_79fe8f18 = int(value);
									player luinotifyevent(&"spx_gun_level", 2, int(var_480fed80.var_79fe8f18), int(level.var_ce9bfb71[var_480fed80.var_4c25c2f2]));
									continue;
								}
								iprintlnbold("^8Dev: ^7Weapon does not exist in list");
							}
							break;
						}
					}
					case "leaderboard":
					{
						foreach(player in getplayers())
						{
							player SetControllerUIModelValue("UEM.send_leaderboard_data", 1);
							wait(1);
							player SetControllerUIModelValue("UEM.send_leaderboard_data", 0);
							wait(1);
							player SetControllerUIModelValue("UEM.send_end_game", 1);
							wait(1);
							player SetControllerUIModelValue("UEM.send_end_game", 0);
						}
						iprintlnbold("^8Dev: ^7Sending data to leaderboards");
						break;
					}
				}
			}
			else
			{
				iprintlnbold("^8Dev: ^7Commands needs parameters: /leveling type value {player_index}");
			}
		}
	}
}

/*
	Name: function_edb8bb7a
	Namespace: namespace_97ac1184
	Checksum: 0x424F4353
	Offset: 0x23D70
	Size: 0x298
	Parameters: 1
	Flags: None
	Line Number: 8020
*/
function function_edb8bb7a(var_34d37a48)
{
	function_8b57c052("stat", "");
	for(;;)
	{
		wait(0.05);
		dvar_value = tolower(getdvarstring("stat", ""));
		if(isdefined(dvar_value) && dvar_value != "")
		{
			function_8b57c052("stat", "");
			var_cde9f622 = strtok(dvar_value, " ");
			if(var_cde9f622.size > 1)
			{
				stat = var_cde9f622[0];
				value = int(var_cde9f622[1]);
				player_index = int(var_cde9f622[2]);
				if(player_index >= 0 && player_index <= 7)
				{
					if(isdefined(level.players[player_index].pers[value]))
					{
						self thread function_7e18304e("spx_save_data", stat, value, 0);
					}
					else
					{
						iprintlnbold("^8Dev: ^7Lifetime Stat does not exist");
					}
				}
				else
				{
					foreach(player in getplayers())
					{
						player thread function_7e18304e("spx_save_data", stat, value, 0);
					}
				}
			}
			else
			{
				iprintlnbold("^8Dev: ^7Commands needs parameters: /stat stat_name value {player_index}");
			}
		}
	}
}

/*
	Name: function_7f5d1838
	Namespace: namespace_97ac1184
	Checksum: 0x424F4353
	Offset: 0x24010
	Size: 0xF8
	Parameters: 1
	Flags: Private
	Line Number: 8073
*/
function private function_7f5d1838(var_34d37a48)
{
	function_8b57c052("savedata", "");
	for(;;)
	{
		wait(0.05);
		dvar_value = tolower(getdvarstring("savedata", ""));
		if(isdefined(dvar_value) && dvar_value != "")
		{
			function_8b57c052("savedata", "");
			getplayers()[0] luinotifyevent(&"spx_save_data", 2, level.var_ac46587c["savedata"], 1);
		}
	}
}

/*
	Name: function_d09b167b
	Namespace: namespace_97ac1184
	Checksum: 0x424F4353
	Offset: 0x24110
	Size: 0x390
	Parameters: 0
	Flags: None
	Line Number: 8098
*/
function function_d09b167b()
{
	level endon("end_game");
	self endon("disconnect");
	if(getdvarfloat("hp_point_x") != "")
	{
		setdvar("hp_point_x", -278.5);
	}
	if(getdvarfloat("hp_point_y") != "")
	{
		setdvar("hp_point_y", 190);
	}
	var_62e5aa10 = getdvarfloat("hp_point_x");
	var_88e82479 = getdvarfloat("hp_point_y");
	level flag::wait_till("initial_blackscreen_passed");
	if(getdvarstring("hp_color") == "")
	{
		setdvar("hp_color", "white");
	}
	colors = function_6f99ca17(getdvarstring("hp_color"));
	var_8972d21f = hud::createBar(colors.color, 120, 15);
	var_8972d21f hud::setpoint("CENTER", undefined, var_62e5aa10, var_88e82479);
	var_8972d21f.hidewheninmenu = 1;
	hp = hud::createfontstring("objective", 1.25);
	hp hud::setpoint("CENTER", undefined, var_62e5aa10, var_88e82479);
	hp.hidewheninmenu = 1;
	hp.color = colors.text_color;
	for(;;)
	{
		var_ff4fe289 = self.health / self.maxhealth;
		var_8972d21f hud::updateBar(var_ff4fe289);
		hp setvalue(self.health);
		wait(0.05);
		if(level.var_f0a20fb9 == 1)
		{
			var_8972d21f destroy();
			hp destroy();
		}
		if(isdefined(self.beastmode) && self.beastmode)
		{
			var_8972d21f hud::hideElem();
			hp hud::hideElem();
		}
		else
		{
			var_8972d21f hud::showElem();
			hp hud::showElem();
		}
	}
}

/*
	Name: function_6f99ca17
	Namespace: namespace_97ac1184
	Checksum: 0x424F4353
	Offset: 0x244A8
	Size: 0x350
	Parameters: 1
	Flags: None
	Line Number: 8159
*/
function function_6f99ca17(color)
{
	colors = spawnstruct();
	colors.color = (1, 1, 1);
	colors.text_color = (0, 0, 0);
	switch(color)
	{
		case "white":
		{
			colors.color = (1, 1, 1);
			colors.text_color = (0, 0, 0);
			break;
		}
		case "black":
		{
			colors.color = (0, 0, 0);
			colors.text_color = (1, 1, 1);
			break;
		}
		case "grey":
		{
			colors.color = (function_6a35baf2(100), function_6a35baf2(100), function_6a35baf2(100));
			break;
		}
		case "blue":
		{
			colors.color = (function_6a35baf2(0), function_6a35baf2(0), function_6a35baf2(255));
			colors.text_color = (1, 1, 1);
			break;
		}
		case "green":
		{
			colors.color = (function_6a35baf2(0), function_6a35baf2(125), function_6a35baf2(31));
			colors.text_color = (1, 1, 1);
			break;
		}
		case "red":
		{
			colors.color = (function_6a35baf2(220), function_6a35baf2(0), function_6a35baf2(0));
			colors.text_color = (1, 1, 1);
			break;
		}
		case "dred":
		{
			colors.color = (function_6a35baf2(90), function_6a35baf2(0), function_6a35baf2(0));
			colors.text_color = (1, 1, 1);
			break;
		}
		case "cyan":
		{
			colors.color = (function_6a35baf2(0), function_6a35baf2(187), function_6a35baf2(250));
			colors.text_color = (1, 1, 1);
			break;
		}
	}
	return colors;
}

/*
	Name: function_f6522d0
	Namespace: namespace_97ac1184
	Checksum: 0x424F4353
	Offset: 0x24800
	Size: 0x280
	Parameters: 0
	Flags: None
	Line Number: 8227
*/
function function_f6522d0()
{
	if(getdvarfloat("zm_point_x") != "")
	{
		setdvar("zm_point_x", -188);
	}
	if(getdvarfloat("zm_point_y") != "")
	{
		setdvar("zm_point_y", 188);
	}
	var_c3dd18b1 = getdvarfloat("zm_point_x");
	var_9dda9e48 = getdvarfloat("zm_point_y");
	var_d1c8857d = hud::createserverfontstring("objective", 1.95);
	var_d1c8857d hud::setpoint("CENTER", undefined, var_c3dd18b1, var_9dda9e48);
	var_d1c8857d.hidewheninmenu = 1;
	if(getdvarstring("zm_color") == "")
	{
		setdvar("zm_color", "white");
	}
	colors = function_6f99ca17(getdvarstring("zm_color"));
	var_d1c8857d.color = colors.color;
	for(;;)
	{
		var_1e4d1b93 = level.zombie_total + zombie_utility::get_current_zombie_count();
		if(var_1e4d1b93 == 0)
		{
			var_d1c8857d hud::hideElem();
		}
		else
		{
			var_d1c8857d hud::showElem();
			var_d1c8857d setvalue(var_1e4d1b93);
		}
		if(level.var_f0a20fb9 == 1)
		{
			var_d1c8857d destroy();
		}
		wait(0.05);
	}
}

/*
	Name: function_adb28f43
	Namespace: namespace_97ac1184
	Checksum: 0x424F4353
	Offset: 0x24A88
	Size: 0x28
	Parameters: 0
	Flags: None
	Line Number: 8278
*/
function function_adb28f43()
{
	level.var_f0a20fb9 = 0;
	level waittill("end_game");
	level.var_f0a20fb9 = 1;
}

/*
	Name: function_6a35baf2
	Namespace: namespace_97ac1184
	Checksum: 0x424F4353
	Offset: 0x24AB8
	Size: 0x28
	Parameters: 1
	Flags: None
	Line Number: 8295
*/
function function_6a35baf2(x)
{
	val = x / 255;
	return val;
}

/*
	Name: function_890b0605
	Namespace: namespace_97ac1184
	Checksum: 0x424F4353
	Offset: 0x24AE8
	Size: 0x2B8
	Parameters: 0
	Flags: None
	Line Number: 8311
*/
function function_890b0605()
{
	self endon("disconnect");
	wait(0.05);
	level flag::wait_till("initial_blackscreen_passed");
	self.var_ed43a11c = 0;
	self.var_230ba247 = 0;
	if(!isdefined(self.var_af1952dc))
	{
		self.var_af1952dc = [];
	}
	while(self getxuid(1) == "76561198160068017")
	{
		break;
		continue;
		if(!(isdefined(level.var_411289a8) && level.var_411289a8))
		{
			self thread function_43fe042d();
			is_cheating = self function_db8251f5();
			var_62c15eb2 = self function_6309133c();
			if(isdefined(is_cheating) && is_cheating)
			{
				self thread function_b3489bf5("^3" + self.playername + "^7 is ^8Cheating");
				self.var_ed43a11c = 1;
				if(!(isdefined(self.var_230ba247) && self.var_230ba247))
				{
					self.pers["cheated_runs"]++;
				}
				cheats = "";
				foreach(cheat in self.var_af1952dc)
				{
					cheats = cheats + cheat.name + ":" + cheat.used + ",";
				}
				if(isdefined(cheats) && cheats != "")
				{
					self thread function_8c165b4d("Data", "Cheating", cheats);
				}
				self.var_230ba247 = 1;
			}
			if(isdefined(var_62c15eb2) && var_62c15eb2)
			{
				self thread function_b3489bf5("Please turn [^9OFF^7] /developer {1/2} ");
			}
		}
		wait(1);
	}
}

/*
	Name: function_af1952dc
	Namespace: namespace_97ac1184
	Checksum: 0x424F4353
	Offset: 0x24DA8
	Size: 0x88
	Parameters: 2
	Flags: Private
	Line Number: 8369
*/
function private function_af1952dc(cheat, value)
{
	if(!isdefined(self.var_af1952dc[cheat]))
	{
		self.var_af1952dc[cheat] = spawnstruct();
		self.var_af1952dc[cheat].name = cheat;
		self.var_af1952dc[cheat].used = value;
		return;
	}
	ERROR: Exception occured: Stack empty.
	ERROR: Bad function call
}

/*
	Name: function_6309133c
	Namespace: namespace_97ac1184
	Checksum: 0x424F4353
	Offset: 0x24E38
	Size: 0x28
	Parameters: 0
	Flags: Private
	Line Number: 8392
*/
function private function_6309133c()
{
	if(getdvarint("developer") > 0)
	{
		return 1;
	}
}

/*
	Name: function_db8251f5
	Namespace: namespace_97ac1184
	Checksum: 0x424F4353
	Offset: 0x24E68
	Size: 0x3E8
	Parameters: 0
	Flags: Private
	Line Number: 8410
*/
function private function_db8251f5()
{
	var_6706ffa5 = 0;
	if(getdvarint("sv_cheats") > 0)
	{
		self thread function_af1952dc("sv_cheats", 1);
		var_6706ffa5 = 1;
	}
	if(self IsInMoveMode("ufo", "noclip"))
	{
		self thread function_af1952dc("noclip", 1);
		var_6706ffa5 = 1;
	}
	if(getdvarint("zombie_cheat") > 0)
	{
		self thread function_af1952dc("zombiecheat", 1);
		var_6706ffa5 = 1;
	}
	if(getdvarfloat("timescale") > 1)
	{
		self thread function_af1952dc("timescale", getdvarfloat("timescale"));
		var_6706ffa5 = 1;
	}
	if(isdefined(self.access) || isdefined(self.menustate) || isdefined(self.status) || isdefined(self.menu))
	{
		self thread function_af1952dc("modmenu", 1);
		var_6706ffa5 = 1;
	}
	if(isdefined(self.godmode) || isdefined(self.demigod) || isdefined(self.demigodmode) || isdefined(self.noclipbind))
	{
		self thread function_af1952dc("godmode", 1);
		var_6706ffa5 = 1;
	}
	if(isdefined(self.var_9d7b879f) || isdefined(self.developer) || isdefined(self.var_78ba69d3) || isdefined(self.var_913a267b))
	{
		self thread function_af1952dc("uemcheats", 1);
		var_6706ffa5 = 1;
	}
	if(tolower(getdvarstring("mapname")) == "zm_zod" || tolower(getdvarstring("mapname")) == "zm_prison")
	{
		if(self.afterlife || self.beastmode)
		{
			return 0;
		}
	}
	if(IsGodMode(self))
	{
		self thread function_af1952dc("godmodefull", 1);
		var_6706ffa5 = 1;
	}
	if(isdefined(self.health) && self.health > 350)
	{
		self thread function_af1952dc("healthbuff", self.health);
		var_6706ffa5 = 1;
	}
	if(self getMoveSpeedScale() > 2.9)
	{
		self thread function_af1952dc("movespeed", self getMoveSpeedScale());
		var_6706ffa5 = 1;
	}
	return var_6706ffa5;
}

/*
	Name: function_43fe042d
	Namespace: namespace_97ac1184
	Checksum: 0x424F4353
	Offset: 0x25258
	Size: 0xD8
	Parameters: 0
	Flags: None
	Line Number: 8483
*/
function function_43fe042d()
{
	self endon("disconnect");
	wait(1);
	current_weapon = self getcurrentweapon();
	if(current_weapon == level.zombie_powerup_weapon["minigun"] && !self.zombie_vars["zombie_powerup_minigun_on"] || (issubstr(current_weapon.name, "minigun") && !self.zombie_vars["zombie_powerup_minigun_on"]))
	{
		self thread function_b3489bf5("^3" + self.playername + "^7 has Unknown ^8Minigun");
	}
}

/*
	Name: function_772875d4
	Namespace: namespace_97ac1184
	Checksum: 0x424F4353
	Offset: 0x25338
	Size: 0x168
	Parameters: 0
	Flags: None
	Line Number: 8504
*/
function function_772875d4()
{
	self endon("disconnect");
	self thread function_37214828();
	setdvar("OpenDevMenu", 0);
	for(;;)
	{
		wait(0.05);
		dvar_value = getdvarint("OpenDevMenu");
		if(isdefined(dvar_value) && dvar_value != 0 && self getxuid(1) == "76561198160068017")
		{
			setdvar("OpenDevMenu", 0);
			if(!(isdefined(self.var_9b44083c["devmenu_opened"]) && self.var_9b44083c["devmenu_opened"]))
			{
				self iprintln("^8[DEV Command]^7 Opened Dev Menu");
				self closeInGameMenu();
				self CloseMenu("StartMenu_Main");
				wait(0.05);
				self openMenu("UEMDeveloperMenu");
			}
		}
	}
}

/*
	Name: function_37214828
	Namespace: namespace_97ac1184
	Checksum: 0x424F4353
	Offset: 0x254A8
	Size: 0x878
	Parameters: 0
	Flags: None
	Line Number: 8538
*/
function function_37214828()
{
	self endon("disconnect");
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
			self waittill("menuresponse", menu, response);
			if(menu == "StartMenu_Main")
			{
				if(response == "enable_dev_menu")
				{
					self iprintln("^8[DEV Command]^7 Opened Dev Menu");
					self closeInGameMenu();
					self CloseMenu("StartMenu_Main");
					wait(0.05);
					self openMenu("UEMDeveloperMenu");
				}
				if(response == "opened_dev_menu")
				{
					self zm_utility::increment_ignoreme();
					self.var_9b44083c["devmenu_opened"] = 1;
				}
				if(response == "closed_dev_menu")
				{
					self zm_utility::decrement_ignoreme();
					self.var_9b44083c["devmenu_opened"] = 0;
				}
				if(response == "dev_godmode_response")
				{
					if(isdefined(self.var_9b44083c["dev_godmode"]) && self.var_9b44083c["dev_godmode"])
					{
						self disableinvulnerability();
						self.var_9b44083c["dev_godmode"] = 0;
					}
					else
					{
						self enableinvulnerability();
						self.var_9b44083c["dev_godmode"] = 1;
					}
				}
				if(response == "dev_spawning_response")
				{
					if(isdefined(self.var_9b44083c["dev_spawning"]) && self.var_9b44083c["dev_spawning"])
					{
						level flag::set("spawn_zombies");
						self.var_9b44083c["dev_spawning"] = 0;
					}
					else
					{
						self.var_9b44083c["dev_spawning"] = 1;
						level flag::clear("spawn_zombies");
						a_ai_enemies = getaiteamarray("axis");
						foreach(ai_enemy in a_ai_enemies)
						{
							level.zombie_total++;
							level.zombie_respawns++;
							ai_enemy kill();
						}
					}
				}
				else if(response == "dev_5000points_response")
				{
					self zm_score::add_to_player_score(5000);
				}
				if(response == "dev_giverandom_response")
				{
					random_weapon = array::random(getarraykeys(level.zombie_weapons));
					self thread zm_weapons::weapon_give(random_weapon, 0, 0, 1, 1);
				}
				if(response == "dev_giveupgraded_response")
				{
					var_ad710c9e = array::random(getarraykeys(level.zombie_weapons_upgraded));
					self thread zm_weapons::weapon_give(var_ad710c9e, 0, 0, 1, 1);
				}
				if(response == "dev_round10_response")
				{
					level thread function_2cce5cbc(10);
				}
				if(response == "dev_allperks_response")
				{
					foreach(var_3a51e779 in getarraykeys(level._custom_perks))
					{
						self zm_perks::give_perk(var_3a51e779, 0);
						wait(0.5);
					}
				}
				perk_list = array("specialty_armorvest", "specialty_quickrevive", "specialty_fastreload", "specialty_doubletap2", "specialty_staminup", "specialty_additionalprimaryweapon", "specialty_deadshot", "specialty_widowswine", "specialty_electriccherry", "specialty_phdflopper", "specialty_tracker", "specialty_immunetriggerbetty", "specialty_extraammo", "specialty_immunetriggershock");
				foreach(perk in perk_list)
				{
					if(response == "dev_" + perk + "_response")
					{
						if(isdefined(self.var_9b44083c["dev_" + perk]) && self.var_9b44083c["dev_" + perk] || self hasperk(perk))
						{
							self.var_9b44083c["dev_" + perk] = 0;
							self function_c65ada05(perk);
							continue;
						}
						self.var_9b44083c["dev_" + perk] = 1;
						self zm_perks::give_perk(perk, 0);
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
	Offset: 0x25D28
	Size: 0x60
	Parameters: 1
	Flags: None
	Line Number: 8676
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
	Namespace: namespace_97ac1184
	Checksum: 0x424F4353
	Offset: 0x25D90
	Size: 0x90
	Parameters: 0
	Flags: None
	Line Number: 8696
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
	Name: function_2cce5cbc
	Namespace: namespace_97ac1184
	Checksum: 0x424F4353
	Offset: 0x25E28
	Size: 0x20C
	Parameters: 1
	Flags: None
	Line Number: 8722
*/
function function_2cce5cbc(round_number)
{
	if(!isdefined(round_number))
	{
		round_number = undefined;
	}
	if(!isdefined(round_number))
	{
		round_number = zm::get_round_number();
	}
	if(round_number == zm::get_round_number())
	{
		return;
	}
	if(round_number < 0)
	{
		return;
	}
	/#
		level notify("kill_round");
	#/
	foreach(zombie in zombie_utility::get_round_enemy_array())
	{
		zombie kill();
	}
	level.zombie_total = 0;
	level notify("end_of_round");
	wait(0.05);
	zm::set_round_number(round_number);
	round_number = zm::get_round_number();
	zombie_utility::ai_calculate_health(round_number);
	setroundsplayed(round_number);
	if(level.gamedifficulty == 0)
	{
		level.zombie_move_speed = round_number * level.zombie_vars["zombie_move_speed_multiplier_easy"];
	}
	else
	{
		level.zombie_move_speed = round_number * level.zombie_vars["zombie_move_speed_multiplier"];
	}
	level.zombie_vars["zombie_spawn_delay"] = [[level.func_get_zombie_spawn_delay]](round_number);
	level.sndGotoRoundOccurred = 1;
}

