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
#include scripts\shared\visionset_mgr_shared;
#include scripts\sphynx\commands\_zm_name_checker;
#include scripts\zm\_util;
#include scripts\zm\_zm;
#include scripts\zm\_zm_audio;
#include scripts\zm\_zm_behavior;
#include scripts\zm\_zm_behavior_utility;
#include scripts\zm\_zm_bgb;
#include scripts\zm\_zm_blockers;
#include scripts\zm\_zm_equipment;
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
#include scripts\zm\_zm_weapons;
#include scripts\zm\_zm_zonemgr;
#include scripts\zm\craftables\_zm_craftables;

#namespace namespace_b2e35c83;

/*
	Name: function___init__sytem__
	Namespace: namespace_b2e35c83
	Checksum: 0x424F4353
	Offset: 0x24E0
	Size: 0x38
	Parameters: 0
	Flags: AutoExec
	Line Number: 63
*/
function autoexec function___init__sytem__()
{
	namespace_system::function_register("zm_commandsgui", &function___init__, undefined, undefined);
	return;
	ERROR: Exception occured: Stack empty.
}

/*
	Name: function___init__
	Namespace: namespace_b2e35c83
	Checksum: 0x424F4353
	Offset: 0x2520
	Size: 0x438
	Parameters: 0
	Flags: None
	Line Number: 80
*/
function function___init__()
{
	if(!isdefined(level.var_84ec6897))
	{
		level.var_84ec6897 = [];
	}
	if(function_ToLower(function_GetDvarString("mapname")) != "zm_castle")
	{
		namespace_clientfield::function_register("scriptmover", "debug_enable_keyline", 1, 1, "int");
		namespace_clientfield::function_register("actor", "debug_zombie_enable_keyline", 1, 1, "int");
	}
	function_8b57c052("versionCommands", "V2.00 - By Sphynx");
	if(!(isdefined(1) && 1))
	{
	}
	else
	{
		level namespace_flag::function_init("dev_console_commands");
		level namespace_flag::function_init("debug_dev");
		level namespace_flag::function_init("silent_dev");
		level namespace_flag::function_init("full_silent_dev");
		function_45e81b43();
		while(!level namespace_flag::function_get("dev_console_commands"))
		{
			wait(1);
		}
		function_SetDvar("sv_cheats", 1);
		level.var_411289a8 = 1;
		thread function_ee09c1b8();
		thread function_7f5d1f3d();
		thread function_d291348c();
		thread function_67752f53();
		thread function_27cdc982();
		thread function_1ab1ece4();
		thread function_3849dbc1();
		thread function_7962a08e();
		thread function_2c6370a9();
		thread function_230a41e7();
		thread function_841abf49();
		thread function_d3b33c79();
		thread function_9d42278d();
		thread function_ac7624f9();
		thread function_f23059d1();
		thread function_9f54f1b9();
		thread function_b2ec648e();
		thread function_e71fb16c();
		thread function_fe46f128();
		thread function_75fbf4d7();
		thread function_de195d8f();
		thread function_439ef9bd();
		thread function_29052cc();
		thread function_8465291f();
		thread function_2d44d863();
		thread function_44a8213d();
		thread function_8e96f735();
		thread function_733d5e3();
		thread function_c9542ee0();
		thread function_fe3fe39b();
		thread function_53447c0f();
		thread function_41967239();
		if(function_ToLower(function_GetDvarString("mapname")) != "zm_castle")
		{
			thread function_1a6da99d();
			thread function_109891a9();
		}
		thread function_6ccccad6();
	}
}

/*
	Name: function_45e81b43
	Namespace: namespace_b2e35c83
	Checksum: 0x424F4353
	Offset: 0x2960
	Size: 0x650
	Parameters: 0
	Flags: Private
	Line Number: 159
*/
function private function_45e81b43()
{
	wait(0.05);
	if(isdefined(1) && 1)
	{
		function_a4869edc("EnableCommands", "enablecommands", "Enables/Disables the Console Commands [Includes Flag]", &function_280d6e2c, &function_cc7982f7, "option_on_off", undefined, function_Array("off", "deactivate", "disable", "0"), 0);
	}
	function_a4869edc("ActiveCommand", "command", "Disables/Enables a specific command", &function_3c1478a0, undefined, "option_on_off", undefined, undefined);
	function_a4869edc("debugmode", "debug", "Enables debug mode for the Console Commands [Debug Flag]", &function_826ee655, &function_4b2b0ac, "option_on_off", function_Array("on", "activate", "enable", "1"), function_Array("off", "deactivate", "disable", "0"));
	function_a4869edc("silentdev", "silent", "Silences the Iprints to only send to host", &function_9cd31ee3, &function_b8c52a6e, "option_on_off", function_Array("on", "activate", "enable", "1"), function_Array("off", "deactivate", "disable", "0"));
	function_a4869edc("fullsilentdev", "full_silent", "Silences the Iprints", &function_448ef885, &function_280bc2dc, "option_on_off", function_Array("on", "activate", "enable", "1"), function_Array("off", "deactivate", "disable", "0"));
	function_a4869edc("testcommand", "testc", "Test Command", undefined, undefined, "option_player_specific", undefined, undefined);
	function_a4869edc("getinfo", "info", "Gets info on a certain thing", &function_22deab76, undefined, "option_player_specific", undefined, undefined);
	function_a4869edc("givepoints", "points", "Gives a set amount of points to the player. Can also use 'Max' as input", &function_712f3d7d, undefined, "option_player_specific", undefined, undefined);
	function_a4869edc("giveweapons", "givew", "Gives the player a weapon. Can use random or random_up for a random weapon", &function_fc027bc0, undefined, "option_player_specific", undefined, undefined);
	function_a4869edc("teleportcommand", "teleport", "Teleports the player to another player or coordinates {random}, {Coordinates}, {Player_index}", &function_1267066b, undefined, "option_player_specific", undefined, undefined);
	function_a4869edc("opensesame", "open", "Opens all Doors and Turns on Power", &function_cb77183e, undefined, "option_enable", undefined, undefined);
	function_a4869edc("spawndog", "dog", "Spawns a dog in a map that has dog spawning enabled", &function_ab68b178, undefined, "option_enable", undefined, undefined);
	function_a4869edc("spawnzombie", "zombie", "Spawns a zombie in a map", &function_cdf3a270, undefined, "option_enable", undefined, undefined);
	function_a4869edc("castleEE", "castle", "Sets up the Castle EE to the Last Step", &function_ee8a81f1, undefined, "option_enable", undefined, undefined);
	function_a4869edc("revEE", "rev", "Sets up the Rev EE to the Last Step", &function_399ad27c, undefined, "option_enable", undefined, undefined);
	function_a4869edc("shadowsEE", "shadows", "Sets up the Shadows of Evil Easter Egg", &function_f7bb44d4, undefined, "option_enable", undefined, undefined);
	function_a4869edc("motdEE", "motd", "Sets up the MOTD Easter Egg", &function_26e723c5, undefined, "option_enable", undefined, undefined);
}

/*
	Name: function_a4869edc
	Namespace: namespace_b2e35c83
	Checksum: 0x424F4353
	Offset: 0x2FB8
	Size: 0x3D8
	Parameters: 10
	Flags: None
	Line Number: 194
*/
function function_a4869edc(var_922b7f26, var_d3065b84, var_description, var_c9ec11af, var_4c3eedfa, var_16315f65, var_42c6f438, var_a09ced63, var_fc7b2b6a, var_1251a95a)
{
	if(!isdefined(var_c9ec11af))
	{
		var_c9ec11af = &function_1f8331d;
	}
	if(!isdefined(var_fc7b2b6a))
	{
		var_fc7b2b6a = 1;
	}
	if(!isdefined(var_1251a95a))
	{
		var_1251a95a = 0;
	}
	/#
		namespace_::function_Assert(isdefined(var_922b7f26), "Dev Block strings are not supported");
	#/
	/#
		namespace_::function_Assert(isdefined(var_d3065b84), "Dev Block strings are not supported");
	#/
	/#
		namespace_::function_Assert(!isdefined(level.var_84ec6897[var_922b7f26]), "Dev Block strings are not supported" + var_922b7f26 + "Dev Block strings are not supported");
	#/
	level.var_84ec6897[var_922b7f26] = function_spawnstruct();
	level.var_84ec6897[var_922b7f26].var_name = var_922b7f26;
	level.var_84ec6897[var_922b7f26].var_dvar = var_d3065b84;
	level.var_84ec6897[var_922b7f26].var_description = var_description;
	level.var_84ec6897[var_922b7f26].var_16315f65 = var_16315f65;
	level.var_84ec6897[var_922b7f26].var_c9ec11af = var_c9ec11af;
	level.var_84ec6897[var_922b7f26].var_4c3eedfa = var_4c3eedfa;
	level.var_84ec6897[var_922b7f26].var_active = 1;
	if(isdefined(var_fc7b2b6a) && var_fc7b2b6a)
	{
		while(!level namespace_flag::function_get("dev_console_commands"))
		{
			wait(0.5);
		}
	}
	else if(isdefined(var_1251a95a) && var_1251a95a)
	{
		while(!level namespace_flag::function_get("debug_dev"))
		{
			wait(0.5);
		}
	}
	switch(var_16315f65)
	{
		case "option_on_off":
		{
			if(isdefined(var_42c6f438))
			{
				level.var_84ec6897[var_922b7f26].var_42c6f438 = var_42c6f438;
			}
			if(isdefined(var_a09ced63))
			{
				level.var_84ec6897[var_922b7f26].var_a09ced63 = var_a09ced63;
			}
			level.var_84ec6897[var_922b7f26] thread function_84a1aa7e(var_922b7f26, var_d3065b84);
			break;
		}
		case "option_player_specific":
		{
			if(isdefined(var_42c6f438))
			{
				level.var_84ec6897[var_922b7f26].var_42c6f438 = var_42c6f438;
			}
			if(isdefined(var_a09ced63))
			{
				level.var_84ec6897[var_922b7f26].var_a09ced63 = var_a09ced63;
			}
			level.var_84ec6897[var_922b7f26] thread function_9ad59eab(var_922b7f26, var_d3065b84);
			break;
		}
		default
		{
			level.var_84ec6897[var_922b7f26] thread function_f7005ce0(var_922b7f26, var_d3065b84);
		}
	}
}

/*
	Name: function_f7005ce0
	Namespace: namespace_b2e35c83
	Checksum: 0x424F4353
	Offset: 0x3398
	Size: 0x268
	Parameters: 2
	Flags: None
	Line Number: 284
*/
function function_f7005ce0(var_922b7f26, var_d3065b84)
{
	function_8b57c052(var_d3065b84, "");
	for(;;)
	{
		wait(0.05);
		if(isdefined(self.var_active) && self.var_active)
		{
			var_dvar_value = function_ToLower(function_GetDvarString(var_d3065b84, ""));
			if(isdefined(var_dvar_value) && var_dvar_value != "")
			{
				function_8b57c052(var_d3065b84, "");
				if(isdefined(self.var_description) && (var_dvar_value == "description" || var_dvar_value == "desc"))
				{
					function_957b7937(self.var_description);
				}
				else
				{
					var_34d37a48 = [];
					var_34d37a48["command"] = self;
					var_34d37a48["value"] = [];
					var_34d37a48["value"][0] = var_dvar_value;
					var_34d37a48["player"] = level.var_players[0];
					var_cde9f622 = function_StrTok(var_dvar_value, " ");
					if(var_cde9f622.size > 1)
					{
						var_value = var_cde9f622[0];
						var_34d37a48["value"][0] = var_value;
						for(var_i = 1; var_i < var_cde9f622.size; var_i++)
						{
							var_34d37a48["value"][var_i] = var_cde9f622[var_i];
						}
					}
					else if(isdefined(self.var_c9ec11af))
					{
						level thread [[self.var_c9ec11af]](var_34d37a48);
					}
					else
					{
						function_957b7937("Dev Command has no function. Please provide one in the script");
					}
				}
			}
		}
	}
}

/*
	Name: function_84a1aa7e
	Namespace: namespace_b2e35c83
	Checksum: 0x424F4353
	Offset: 0x3608
	Size: 0x308
	Parameters: 2
	Flags: None
	Line Number: 341
*/
function function_84a1aa7e(var_922b7f26, var_d3065b84)
{
	function_8b57c052(var_d3065b84, "");
	for(;;)
	{
		wait(0.05);
		if(isdefined(self.var_active) && self.var_active)
		{
			var_dvar_value = function_ToLower(function_GetDvarString(var_d3065b84, ""));
			if(isdefined(var_dvar_value) && var_dvar_value != "")
			{
				function_8b57c052(var_d3065b84, "");
				if(isdefined(self.var_description) && (var_dvar_value == "description" || var_dvar_value == "desc"))
				{
					function_957b7937(self.var_description);
				}
				else
				{
					var_34d37a48 = [];
					var_34d37a48["command"] = self;
					var_34d37a48["value"] = [];
					var_34d37a48["value"][0] = var_dvar_value;
					var_34d37a48["player"] = level.var_players[0];
					var_cde9f622 = function_StrTok(var_dvar_value, " ");
					if(var_cde9f622.size > 1)
					{
						var_value = var_cde9f622[0];
						var_34d37a48["value"][0] = var_value;
						for(var_i = 1; var_i < var_cde9f622.size; var_i++)
						{
							var_34d37a48["value"][var_i] = var_cde9f622[var_i];
						}
					}
					else if(namespace_Array::function_contains(self.var_42c6f438, var_dvar_value) || !isdefined(self.var_42c6f438))
					{
						if(isdefined(self.var_c9ec11af))
						{
							level thread [[self.var_c9ec11af]](var_34d37a48);
						}
						else
						{
							function_957b7937("Dev Command has no function. Please provide one in the script");
						}
					}
					else if(namespace_Array::function_contains(self.var_a09ced63, var_dvar_value) || !isdefined(self.var_a09ced63))
					{
						if(isdefined(self.var_4c3eedfa))
						{
							level thread [[self.var_4c3eedfa]](var_34d37a48);
						}
						else
						{
							function_957b7937("Dev Command has no function. Please provide one in the script");
						}
					}
				}
			}
		}
	}
}

/*
	Name: function_9ad59eab
	Namespace: namespace_b2e35c83
	Checksum: 0x424F4353
	Offset: 0x3918
	Size: 0x418
	Parameters: 2
	Flags: None
	Line Number: 412
*/
function function_9ad59eab(var_922b7f26, var_d3065b84)
{
	function_8b57c052(var_d3065b84, "");
	for(;;)
	{
		wait(0.05);
		if(isdefined(self.var_active) && self.var_active)
		{
			var_dvar_value = function_ToLower(function_GetDvarString(var_d3065b84, ""));
			if(isdefined(var_dvar_value) && var_dvar_value != "")
			{
				function_8b57c052(var_d3065b84, "");
				if(isdefined(self.var_description) && (var_dvar_value == "description" || var_dvar_value == "desc"))
				{
					function_957b7937(self.var_description);
				}
				else
				{
					var_34d37a48 = [];
					var_34d37a48["command"] = self;
					var_34d37a48["value"] = [];
					var_34d37a48["value"][0] = var_dvar_value;
					var_34d37a48["player"] = level.var_players[0];
					var_cde9f622 = function_StrTok(var_dvar_value, " ");
					if(var_cde9f622.size > 1)
					{
						if(var_cde9f622.size > 2)
						{
							var_player_index = function_Int(var_cde9f622[0]);
							var_34d37a48["player"] = level.var_players[var_player_index];
							var_34d37a48["value"][0] = var_cde9f622[0];
							for(var_i = 0; var_i < var_cde9f622.size; var_i++)
							{
								var_34d37a48["value"][var_i] = var_cde9f622[var_i];
							}
						}
						else
						{
							var_player_index = function_Int(var_cde9f622[0]);
							var_34d37a48["player"] = level.var_players[var_player_index];
						}
						if(var_player_index >= 0 && var_player_index <= 7)
						{
							if(isdefined(self.var_c9ec11af))
							{
								level.var_players[var_player_index] thread [[self.var_c9ec11af]](var_34d37a48);
							}
							else
							{
								function_957b7937("Dev Command has no function. Please provide one in the script");
							}
						}
						else if(isdefined(self.var_c9ec11af))
						{
							for(var_i = 0; var_i < level.var_players.size; var_i++)
							{
								var_34d37a48["player"] = level.var_players[var_i];
								level.var_players[var_i] thread [[self.var_c9ec11af]](var_34d37a48);
							}
						}
						else
						{
							function_957b7937("Dev Command has no function. Please provide one in the script");
						}
					}
					else if(isdefined(self.var_c9ec11af))
					{
						for(var_i = 0; var_i < level.var_players.size; var_i++)
						{
							var_34d37a48["player"] = level.var_players[var_i];
							level.var_players[var_i] thread [[self.var_c9ec11af]](var_34d37a48);
						}
					}
					else
					{
						function_957b7937("Dev Command has no function. Please provide one in the script");
					}
				}
			}
		}
	}
}

/*
	Name: function_1f8331d
	Namespace: namespace_b2e35c83
	Checksum: 0x424F4353
	Offset: 0x3D38
	Size: 0xC0
	Parameters: 1
	Flags: None
	Line Number: 505
*/
function function_1f8331d(var_34d37a48)
{
	for(var_i = 0; var_i < var_34d37a48["value"].size; var_i++)
	{
		function_957b7937("Value of " + var_i + ": " + var_34d37a48["value"][var_i]);
	}
	function_957b7937("Command " + var_34d37a48["command"].var_name + " : No function pointer has been set");
}

/*
	Name: function_280d6e2c
	Namespace: namespace_b2e35c83
	Checksum: 0x424F4353
	Offset: 0x3E00
	Size: 0x130
	Parameters: 1
	Flags: None
	Line Number: 524
*/
function function_280d6e2c(var_34d37a48)
{
	switch(var_34d37a48["value"][0])
	{
		case "jh4sd32xd12xxd9":
		{
			level namespace_flag::function_set("dev_console_commands");
			foreach(var_command in level.var_84ec6897)
			{
				level.var_84ec6897[var_command.var_name].var_active = 1;
			}
			function_957b7937("Developer Commands Turned ^8On");
			break;
		}
		default
		{
			function_957b7937("Incorrect Password");
		}
	}
	return;
	ERROR: Bad function call
}

/*
	Name: function_cc7982f7
	Namespace: namespace_b2e35c83
	Checksum: 0x424F4353
	Offset: 0x3F38
	Size: 0xE0
	Parameters: 1
	Flags: None
	Line Number: 557
*/
function function_cc7982f7(var_34d37a48)
{
	level namespace_flag::function_clear("dev_console_commands");
	foreach(var_command in level.var_84ec6897)
	{
		level.var_84ec6897[var_command.var_name].var_active = 0;
	}
	function_957b7937("Developer Commands Turned ^9Off");
}

/*
	Name: function_3c1478a0
	Namespace: namespace_b2e35c83
	Checksum: 0x424F4353
	Offset: 0x4020
	Size: 0x100
	Parameters: 1
	Flags: None
	Line Number: 577
*/
function function_3c1478a0(var_34d37a48)
{
	if(level.var_84ec6897[var_34d37a48["value"][0]].var_active == 0)
	{
		function_957b7937("Turned Command: " + var_34d37a48["value"][0] + " ^8On");
		level.var_84ec6897[var_34d37a48["value"][0]].var_active = 1;
	}
	else
	{
		function_957b7937("Turned Command: " + var_34d37a48["value"][0] + " ^9Off");
		level.var_84ec6897[var_34d37a48["value"][0]].var_active = 0;
	}
}

/*
	Name: function_83b19cbb
	Namespace: namespace_b2e35c83
	Checksum: 0x424F4353
	Offset: 0x4128
	Size: 0x40
	Parameters: 1
	Flags: None
	Line Number: 601
*/
function function_83b19cbb(var_34d37a48)
{
	level.var_84ec6897[var_34d37a48["command"].var_name].var_active = 1;
}

/*
	Name: function_826ee655
	Namespace: namespace_b2e35c83
	Checksum: 0x424F4353
	Offset: 0x4170
	Size: 0x48
	Parameters: 1
	Flags: None
	Line Number: 616
*/
function function_826ee655(var_34d37a48)
{
	level namespace_flag::function_set("debug_dev");
	function_957b7937("Debug Mode Turned ^8On");
	return;
	.var_0 = undefined;
}

/*
	Name: function_4b2b0ac
	Namespace: namespace_b2e35c83
	Checksum: 0x424F4353
	Offset: 0x41C0
	Size: 0x48
	Parameters: 1
	Flags: None
	Line Number: 634
*/
function function_4b2b0ac(var_34d37a48)
{
	level namespace_flag::function_clear("debug_dev");
	function_957b7937("Debug Mode Turned ^9Off");
	return;
}

/*
	Name: function_9cd31ee3
	Namespace: namespace_b2e35c83
	Checksum: 0x424F4353
	Offset: 0x4210
	Size: 0x48
	Parameters: 1
	Flags: None
	Line Number: 651
*/
function function_9cd31ee3(var_34d37a48)
{
	level namespace_flag::function_set("silent_dev");
	function_957b7937("Silent Dev Mode Turned ^8On");
}

/*
	Name: function_b8c52a6e
	Namespace: namespace_b2e35c83
	Checksum: 0x424F4353
	Offset: 0x4260
	Size: 0x48
	Parameters: 1
	Flags: None
	Line Number: 667
*/
function function_b8c52a6e(var_34d37a48)
{
	level namespace_flag::function_clear("silent_dev");
	function_957b7937("Silent Dev Turned ^9Off");
}

/*
	Name: function_448ef885
	Namespace: namespace_b2e35c83
	Checksum: 0x424F4353
	Offset: 0x42B0
	Size: 0x30
	Parameters: 1
	Flags: None
	Line Number: 683
*/
function function_448ef885(var_34d37a48)
{
	level namespace_flag::function_set("full_silent_dev");
	return;
}

/*
	Name: function_280bc2dc
	Namespace: namespace_b2e35c83
	Checksum: 0x424F4353
	Offset: 0x42E8
	Size: 0x48
	Parameters: 1
	Flags: None
	Line Number: 699
*/
function function_280bc2dc(var_34d37a48)
{
	level namespace_flag::function_clear("full_silent_dev");
	function_957b7937("Full Silent Dev Turned ^9Off");
}

/*
	Name: function_fe2dc958
	Namespace: namespace_b2e35c83
	Checksum: 0x424F4353
	Offset: 0x4338
	Size: 0x128
	Parameters: 1
	Flags: None
	Line Number: 715
*/
function function_fe2dc958(var_34d37a48)
{
	if(isdefined(var_34d37a48["player"]))
	{
		switch(var_34d37a48["value"][0])
		{
			case "1":
			{
				function_957b7937("Checked XUID of player " + var_34d37a48["player"].var_playerName + " | XUID: " + var_34d37a48["player"] function_getxuid(1));
				break;
			}
			default
			{
				function_957b7937("Checked XUID of player " + var_34d37a48["player"].var_playerName + " | XUID: " + var_34d37a48["player"] function_getxuid());
			}
		}
	}
	else
	{
		function_957b7937("Player does not exist");
	}
}

/*
	Name: function_22deab76
	Namespace: namespace_b2e35c83
	Checksum: 0x424F4353
	Offset: 0x4468
	Size: 0x3A8
	Parameters: 1
	Flags: None
	Line Number: 748
*/
function function_22deab76(var_34d37a48)
{
	if(isdefined(var_34d37a48["player"]))
	{
		switch(var_34d37a48["value"][0])
		{
			case "weapon":
			{
				function_957b7937("Checked Weapon of Player " + var_34d37a48["player"].var_playerName + " | Weapon Name: " + function_MakeLocalizedString(var_34d37a48["player"] function_GetCurrentWeapon().var_displayName) + " | Weapon Cname: " + var_34d37a48["player"] function_GetCurrentWeapon().var_name);
				function_957b7937("Checked Weapon of Player " + var_34d37a48["player"].var_playerName + " | Weapon Cname: " + var_34d37a48["player"] function_GetCurrentWeapon().var_name);
				break;
			}
			case "xuid":
			{
				if(var_34d37a48["value"][1] == "1")
				{
					function_957b7937("Checked XUID of player " + var_34d37a48["player"].var_playerName + " | XUID: " + var_34d37a48["player"] function_getxuid(1));
				}
				else
				{
					function_957b7937("Checked XUID of player " + var_34d37a48["player"].var_playerName + " | XUID: " + var_34d37a48["player"] function_getxuid());
					break;
				}
			}
			case "coords":
			{
				function_957b7937("Checked Coords of Player " + var_34d37a48["player"].var_playerName + " | Coords {X,Y,Z}: " + var_34d37a48["player"].var_origin);
				function_957b7937("Checked Angles of Player " + var_34d37a48["player"].var_playerName + " | Angles {X,Y,Z}: " + var_34d37a48["player"].var_angles);
				break;
			}
			case "zone":
			{
				function_957b7937("Zone of current Player " + var_34d37a48["player"].var_playerName + " | " + var_34d37a48["player"] namespace_zm_zonemgr::function_get_player_zone());
				break;
			}
			default
			{
				function_957b7937("Add parameter to gain Info: weapon, xuid, coords");
			}
		}
	}
	else
	{
		function_957b7937("Player does not exist");
	}
}

/*
	Name: function_712f3d7d
	Namespace: namespace_b2e35c83
	Checksum: 0x424F4353
	Offset: 0x4818
	Size: 0x268
	Parameters: 1
	Flags: None
	Line Number: 805
*/
function function_712f3d7d(var_34d37a48)
{
	switch(var_34d37a48["value"][0])
	{
		case "max":
		{
			var_34d37a48["player"] namespace_zm_score::function_add_to_player_score(500000000);
			namespace_zm_utility::function_play_sound_at_pos("purchase", var_34d37a48["player"].var_origin);
			function_957b7937("Gave " + var_34d37a48["player"].var_playerName + " " + var_34d37a48["value"][0] + " Points");
			break;
		}
		case "0":
		case "reset":
		{
			var_34d37a48["player"].var_score = function_Int(0);
			namespace_zm_utility::function_play_sound_at_pos("purchase", var_34d37a48["player"].var_origin);
			function_957b7937("Reset Points of " + var_34d37a48["player"].var_playerName);
			break;
		}
		default
		{
			var_34d37a48["player"] namespace_zm_score::function_add_to_player_score(function_Int(var_34d37a48["value"][0]));
			namespace_zm_utility::function_play_sound_at_pos("purchase", var_34d37a48["player"].var_origin);
			function_957b7937("Gave " + var_34d37a48["player"].var_playerName + " " + var_34d37a48["value"][0] + " Points");
		}
	}
	return;
}

/*
	Name: function_fc027bc0
	Namespace: namespace_b2e35c83
	Checksum: 0x424F4353
	Offset: 0x4A88
	Size: 0x2E8
	Parameters: 1
	Flags: None
	Line Number: 844
*/
function function_fc027bc0(var_34d37a48)
{
	switch(var_34d37a48["value"][0])
	{
		case "ammo":
		{
			var_34d37a48["player"] thread function_7265a195();
			break;
		}
		case "random":
		{
			var_random_weapon = namespace_Array::function_random(function_getArrayKeys(level.var_zombie_weapons));
			var_34d37a48["player"] thread namespace_zm_weapons::function_weapon_give(var_random_weapon, 0, 0, 1, 1);
			function_957b7937("Gave " + var_34d37a48["player"].var_playerName + " ^8" + function_MakeLocalizedString(var_random_weapon.var_displayName));
			break;
		}
		case "random_up":
		case "random_upgraded":
		case "up":
		case "upgraded":
		{
			var_ad710c9e = namespace_Array::function_random(function_getArrayKeys(level.var_zombie_weapons_upgraded));
			var_34d37a48["player"] thread namespace_zm_weapons::function_weapon_give(var_ad710c9e, 0, 0, 1, 1);
			function_957b7937("Gave " + var_34d37a48["player"].var_playerName + " ^9" + function_MakeLocalizedString(var_ad710c9e.var_displayName));
			break;
		}
		default
		{
			var_34d37a48["player"] thread namespace_zm_weapons::function_weapon_give(function_GetWeapon(var_34d37a48["value"][0]), 0, 0, 1, 1);
			function_957b7937("Gave " + var_34d37a48["player"].var_playerName + " " + function_MakeLocalizedString(function_GetWeapon(var_34d37a48["value"][0]).var_displayName));
		}
	}
}

/*
	Name: function_1267066b
	Namespace: namespace_b2e35c83
	Checksum: 0x424F4353
	Offset: 0x4D78
	Size: 0x270
	Parameters: 1
	Flags: None
	Line Number: 888
*/
function function_1267066b(var_34d37a48)
{
	switch(var_34d37a48["value"][0])
	{
		case "random":
		{
			level.var_players[function_Int(var_34d37a48["value"][1])] thread function_de2fcf4e();
			function_957b7937("Teleport player to random location");
			break;
		}
		case "coords":
		{
			level.var_players[function_Int(var_34d37a48["value"][1])] thread function_de2fcf4e((function_Int(var_34d37a48["value"][2]), function_Int(var_34d37a48["value"][3]), function_Int(var_34d37a48["value"][4])));
			function_957b7937("Teleport player to coords");
			break;
		}
		case "player":
		{
			level.var_players[function_Int(var_34d37a48["value"][1])] thread function_777705d3(function_Int(var_34d37a48["value"][2]));
			function_957b7937("Teleport " + level.var_players[function_Int(var_34d37a48["value"][1])].var_name + " to other " + level.var_players[function_Int(var_34d37a48["value"][1])]);
			break;
		}
		default
		{
			function_957b7937("Need parameter: {random}, {coords}, {player}");
		}
	}
}

/*
	Name: function_cb77183e
	Namespace: namespace_b2e35c83
	Checksum: 0x424F4353
	Offset: 0x4FF0
	Size: 0x118
	Parameters: 1
	Flags: None
	Line Number: 927
*/
function function_cb77183e(var_34d37a48)
{
	switch(var_34d37a48["value"][0])
	{
		case "close":
		case "closest":
		case "door":
		case "eye":
		case "front":
		case "look":
		case "looking":
		case "this":
		{
			thread function_b5d953ca(var_34d37a48);
			function_957b7937(var_34d37a48["player"].var_playerName + " opened a specific door");
			break;
		}
		default
		{
			thread function_f247d197();
			function_957b7937(var_34d37a48["player"].var_playerName + " opened everything");
		}
	}
}

/*
	Name: function_ab68b178
	Namespace: namespace_b2e35c83
	Checksum: 0x424F4353
	Offset: 0x5110
	Size: 0x50
	Parameters: 1
	Flags: None
	Line Number: 962
*/
function function_ab68b178(var_34d37a48)
{
	if(!isdefined(level.var_dogs_enabled) || (!(isdefined(level.var_dogs_enabled) && level.var_dogs_enabled)))
	{
		function_957b7937("Dogs not enabled in the map");
		return;
		return;
	}
	ERROR: Exception occured: Stack empty.
}

/*
	Name: function_cdf3a270
	Namespace: namespace_b2e35c83
	Checksum: 0x424F4353
	Offset: 0x5168
	Size: 0x70
	Parameters: 1
	Flags: None
	Line Number: 983
*/
function function_cdf3a270(var_34d37a48)
{
	level thread function_c72962f0(var_34d37a48["value"][0]);
	function_957b7937("Spawned " + var_34d37a48["value"][0] + " Zombie(s)");
}

/*
	Name: function_ee8a81f1
	Namespace: namespace_b2e35c83
	Checksum: 0x424F4353
	Offset: 0x51E0
	Size: 0x48
	Parameters: 1
	Flags: None
	Line Number: 999
*/
function function_ee8a81f1(var_34d37a48)
{
	level namespace_flag::function_set("ee_outro");
	function_957b7937("Enabled Castle Last Step EE");
}

/*
	Name: function_399ad27c
	Namespace: namespace_b2e35c83
	Checksum: 0x424F4353
	Offset: 0x5230
	Size: 0x48
	Parameters: 1
	Flags: None
	Line Number: 1015
*/
function function_399ad27c(var_34d37a48)
{
	level namespace_flag::function_set("final_boss_defeated");
	function_957b7937("Enabled Rev Last Step EE");
}

/*
	Name: function_f7bb44d4
	Namespace: namespace_b2e35c83
	Checksum: 0x424F4353
	Offset: 0x5280
	Size: 0x9D8
	Parameters: 1
	Flags: None
	Line Number: 1031
*/
function function_f7bb44d4(var_34d37a48)
{
	switch(var_34d37a48["value"][0])
	{
		case "pack":
		{
			if(isdefined(level.var_c0091dc4["pap"].var_46491092))
			{
				foreach(var_person in function_Array("boxer", "detective", "femme", "magician"))
				{
					level thread [[level.var_c0091dc4[var_person].var_46491092]](var_person);
				}
				foreach(var_c8d6ad34 in function_Array("pap_basin_1", "pap_basin_2", "pap_basin_3", "pap_basin_4"))
				{
					level namespace_flag::function_set(var_c8d6ad34);
				}
				level namespace_flag::function_set("pap_altar");
				level thread [[level.var_c0091dc4["pap"].var_46491092]]("pap");
			}
			function_957b7937("^8[Shadows of Evil Debug]^7 Complete Pack-a-Punch");
			break;
		}
		case "bm_infinite":
		{
			var_34d37a48["player"].var_5e82a563 = 999;
			var_34d37a48["player"].var_39f3c137 = 999;
			foreach(var_8042e4e2 in level.var_8ad0ec05)
			{
				var_8042e4e2.var_b55b4180 = 0;
			}
			function_957b7937("^8[Shadows of Evil Debug]^7 Enable All Beastmode Kiosks and Give unlimited Lives/Mana");
			break;
		}
		case "beastmode":
		{
			if(isdefined(var_34d37a48["player"].var_beastmode) && var_34d37a48["player"].var_beastmode)
			{
				var_34d37a48["player"].var_beastmode = 0;
			}
			else
			{
				var_34d37a48["player"].var_beastmode = 1;
			}
			function_957b7937("^8[Shadows of Evil Debug]^7 Enable Player Beastmode (Just Variable)");
			break;
		}
		case "ritual_items":
		{
			var_1f52906d = function_Array("ritual_boxer", "ritual_detective", "ritual_femme", "ritual_magician", "ritual_pap");
			foreach(var_item in var_1f52906d)
			{
				namespace_zm_craftables::function_complete_craftable(var_item);
			}
			function_957b7937("^8[Shadows of Evil Debug]^7 Complete Ritual Items");
			break;
		}
		case "keeper_door":
		{
			level namespace_flag::function_set("keeper_sword_locker");
			function_957b7937("^8[Shadows of Evil Debug]^7 Remove Sword Keeper Door");
			break;
		}
		case "key":
		{
			level.var_c913a45f = 1;
			function_957b7937("^8[Shadows of Evil Debug]^7 Enable Summoning Key Pickup");
			break;
		}
		case "start":
		{
			level namespace_flag::function_set("ritual_pap_complete");
			wait(1);
			level namespace_flag::function_set("ee_begin");
			function_957b7937("^8[Shadows of Evil Debug]^7 Start SOE EE");
			break;
		}
		case "sword":
		{
			level thread function_3e6a0452(var_34d37a48["player"], "Normal", 1);
			function_957b7937("^8[Shadows of Evil Debug]^7 Enable Sword");
			break;
		}
		case "sword_upgraded":
		{
			level thread function_3e6a0452(var_34d37a48["player"], "Upgraded", 1);
			level namespace_flag::function_set("ee_begin");
			function_957b7937("^8[Shadows of Evil Debug]^7 Enable Upgraded Sword");
			break;
		}
		case "book":
		{
			level namespace_flag::function_set("ee_book");
			function_957b7937("^8[Shadows of Evil Debug]^7 Enable Book Step");
			break;
		}
		case "resurrected":
		{
			foreach(var_d7e2a718 in function_Array("boxer", "detective", "femme", "magician"))
			{
				level namespace_flag::function_set("ee_keeper_" + var_d7e2a718 + "_resurrected");
			}
			break;
		}
		case "armed":
		{
			foreach(var_d7e2a718 in function_Array("boxer", "detective", "femme", "magician"))
			{
				level namespace_flag::function_set("ee_keeper_" + var_d7e2a718 + "_armed");
			}
			break;
		}
		case "flag_step":
		{
			level namespace_flag::function_set("ee_book");
			level namespace_clientfield::function_set("ee_keeper_boxer_state", 1);
			level namespace_clientfield::function_set("ee_keeper_detective_state", 1);
			level namespace_clientfield::function_set("ee_keeper_femme_state", 1);
			level namespace_clientfield::function_set("ee_keeper_magician_state", 1);
			wait(0.25);
			foreach(var_person in function_Array("boxer", "detective", "femme", "magician"))
			{
				level namespace_flag::function_set("ee_keeper_" + var_person + "_resurrected");
				level namespace_clientfield::function_set("ee_keeper_" + var_person + "_state", 3);
			}
			function_957b7937("^8[Shadows of Evil Debug]^7 Enable Flag Step");
			break;
		}
		case "flag_god":
		{
			level.var_ad555b99 = 1;
			function_957b7937("^8[Shadows of Evil Debug]^7 Enable Flag Step God");
			break;
		}
	}
}

/*
	Name: function_26e723c5
	Namespace: namespace_b2e35c83
	Checksum: 0x424F4353
	Offset: 0x5C60
	Size: 0x568
	Parameters: 1
	Flags: None
	Line Number: 1177
*/
function function_26e723c5(var_34d37a48)
{
	switch(var_34d37a48["value"][0])
	{
		case "key":
		{
			function_957b7937("^8[Shadows of Evil Debug]^7 Wardens Key obtained");
			level namespace_flag::function_set("key_obtained");
			var_34d37a48["player"].var_b7824370 = 1;
			break;
		}
		case "key_shocked":
		{
			function_957b7937("^8[Shadows of Evil Debug]^7 Set Key Shocked Completed");
			level notify("hash_ce369d9");
			wait(0.05);
			level notify("hash_f1a0a333");
			var_34d37a48["player"].var_b7824370 = 1;
			break;
		}
		case "cloth":
		{
			function_957b7937("^8[Shadows of Evil Debug]^7 Cloth Part Found");
			var_34d37a48["player"] thread namespace_zm_craftables::function_player_get_craftable_piece("plane_zm", "sails");
			break;
		}
		case "tank":
		{
			function_957b7937("^8[Shadows of Evil Debug]^7 Fuel Tanks Part Found");
			var_34d37a48["player"] thread namespace_zm_craftables::function_player_get_craftable_piece("plane_zm", "tank");
			break;
		}
		case "engine":
		{
			function_957b7937("^8[Shadows of Evil Debug]^7 Engine Part Found");
			var_34d37a48["player"] thread namespace_zm_craftables::function_player_get_craftable_piece("plane_zm", "engine");
			break;
		}
		case "steering":
		{
			function_957b7937("^8[Shadows of Evil Debug]^7 Steering Tanks Part Found");
			var_34d37a48["player"] thread namespace_zm_craftables::function_player_get_craftable_piece("plane_zm", "controls");
			break;
		}
		case "rigging":
		{
			function_957b7937("^8[Shadows of Evil Debug]^7 Rigging Part Found");
			var_34d37a48["player"] thread namespace_zm_craftables::function_player_get_craftable_piece("plane_zm", "rigging");
			break;
		}
		case "parts":
		{
			function_957b7937("^8[Shadows of Evil Debug]^7 Given all Parts");
			var_34d37a48["player"] thread namespace_zm_craftables::function_player_get_craftable_piece("plane_zm", "controls");
			var_34d37a48["player"] thread namespace_zm_craftables::function_player_get_craftable_piece("plane_zm", "rigging");
			var_34d37a48["player"] thread namespace_zm_craftables::function_player_get_craftable_piece("plane_zm", "engine");
			var_34d37a48["player"] thread namespace_zm_craftables::function_player_get_craftable_piece("plane_zm", "tank");
			var_34d37a48["player"] thread namespace_zm_craftables::function_player_get_craftable_piece("plane_zm", "sails");
			break;
		}
		case "hands":
		{
			var_34d37a48["player"] namespace_zm_weapons::function_weapon_give(function_GetWeapon("t6_xl_shockhands"), 0, 0, 1, 1);
			function_957b7937("^8[Shadows of Evil Debug]^7 Given Shock Hands");
			break;
		}
		case "afterlife":
		{
			function_957b7937("^8[Shadows of Evil Debug]^7 Given Shock Hands");
			if(isdefined(var_34d37a48["player"].var_afterlife) && var_34d37a48["player"].var_afterlife)
			{
				var_34d37a48["player"].var_afterlife = 0;
			}
			else
			{
				var_34d37a48["player"].var_afterlife = 1;
				break;
			}
		}
		case "dogs":
		{
			level namespace_flag::function_set("dreamcatchers_filled");
			function_957b7937("^8[Shadows of Evil Debug]^7 Completed Dogs!");
			break;
		}
		case "nixie":
		{
			function_957b7937("^8[Shadows of Evil Debug]^7 Nixie code is: " + level.var_a_nixie_tube_code[1] + " | " + level.var_a_nixie_tube_code[2] + " | " + level.var_a_nixie_tube_code[3]);
			break;
		}
	}
}

/*
	Name: function_c72962f0
	Namespace: namespace_b2e35c83
	Checksum: 0x424F4353
	Offset: 0x61D0
	Size: 0x90
	Parameters: 1
	Flags: None
	Line Number: 1280
*/
function function_c72962f0(var_value)
{
	var_count = 0;
	while(var_count < var_value)
	{
		var_count++;
		var_spawner = namespace_Array::function_random(level.var_zombie_spawners);
		var_zombie = namespace_zombie_utility::function_spawn_zombie(var_spawner);
		wait(level.var_zombie_vars["zombie_spawn_delay"]);
	}
}

/*
	Name: function_de2fcf4e
	Namespace: namespace_b2e35c83
	Checksum: 0x424F4353
	Offset: 0x6268
	Size: 0xF8
	Parameters: 1
	Flags: None
	Line Number: 1302
*/
function function_de2fcf4e(var_coords)
{
	if(isdefined(var_coords))
	{
		self function_2cb3d5c8();
		self function_SetVelocity((0, 0, 0));
		self function_SetOrigin(var_coords);
	}
	else if(isdefined(level.var_2c12d9a6))
	{
		var_68140f76 = self [[level.var_2c12d9a6]]();
	}
	else
	{
		var_68140f76 = self function_728dfe3();
	}
	self function_2cb3d5c8();
	self function_SetVelocity((0, 0, 0));
	self function_SetOrigin(var_68140f76.var_origin);
	return;
}

/*
	Name: function_777705d3
	Namespace: namespace_b2e35c83
	Checksum: 0x424F4353
	Offset: 0x6368
	Size: 0x60
	Parameters: 1
	Flags: None
	Line Number: 1334
*/
function function_777705d3(var_player_destination)
{
	self function_SetOrigin(var_player_destination.var_origin + VectorScale((0, 0, 1), 40));
	self function_SetPlayerAngles(var_player_destination.var_angles);
}

/*
	Name: function_728dfe3
	Namespace: namespace_b2e35c83
	Checksum: 0x424F4353
	Offset: 0x63D0
	Size: 0x2F0
	Parameters: 0
	Flags: None
	Line Number: 1350
*/
function function_728dfe3()
{
	var_a6abcc5d = namespace_zm_zonemgr::function_get_zone_from_position(self.var_origin + VectorScale((0, 0, 1), 32), 0);
	if(!isdefined(var_a6abcc5d))
	{
		var_a6abcc5d = self.var_zone_name;
	}
	if(isdefined(var_a6abcc5d))
	{
		var_c30975d2 = level.var_zones[var_a6abcc5d];
	}
	var_97786609 = namespace_struct::function_get_array("player_respawn_point", "targetname");
	var_bbf77908 = [];
	foreach(var_68140f76 in var_97786609)
	{
		if(namespace_zm_utility::function_is_point_inside_enabled_zone(var_68140f76.var_origin, var_c30975d2))
		{
			if(!isdefined(var_bbf77908))
			{
				var_bbf77908 = [];
			}
			else if(!function_IsArray(var_bbf77908))
			{
				var_bbf77908 = function_Array(var_bbf77908);
			}
			var_bbf77908[var_bbf77908.size] = var_68140f76;
		}
	}
	if(isdefined(level.var_2d4e3645))
	{
		var_bbf77908 = [[level.var_2d4e3645]](var_bbf77908);
	}
	var_59fe7f49 = undefined;
	if(var_bbf77908.size > 0)
	{
		var_90551969 = namespace_Array::function_random(var_bbf77908);
		var_46b9bbf8 = namespace_struct::function_get_array(var_90551969.var_target, "targetname");
		foreach(var_dbd59eb2 in var_46b9bbf8)
		{
			var_n_script_int = self function_GetEntityNumber() + 1;
			if(var_dbd59eb2.var_script_int === var_n_script_int)
			{
				var_59fe7f49 = var_dbd59eb2;
			}
		}
	}
	return var_59fe7f49;
}

/*
	Name: function_d62f9e44
	Namespace: namespace_b2e35c83
	Checksum: 0x424F4353
	Offset: 0x66C8
	Size: 0x180
	Parameters: 1
	Flags: None
	Line Number: 1409
*/
function function_d62f9e44(var_34d37a48)
{
	function_8b57c052("debug", "");
	for(;;)
	{
		wait(0.05);
		var_dvar_value = function_ToLower(function_GetDvarString("debug", ""));
		if(isdefined(var_dvar_value) && var_dvar_value != "")
		{
			function_8b57c052("debug", "");
			if(var_dvar_value == "on" || var_dvar_value == "activate" || var_dvar_value == "1")
			{
				level namespace_flag::function_set("debug_dev");
				function_IPrintLnBold("^8Dev: ^7Debug Mode Turned ^4On");
			}
			else if(var_dvar_value == "off" || var_dvar_value == "deactivate" || var_dvar_value == "0")
			{
				level namespace_flag::function_clear("debug_dev");
				function_IPrintLnBold("^8Dev: ^7Debug Mode Turned ^1Off");
			}
		}
	}
}

/*
	Name: function_41967239
	Namespace: namespace_b2e35c83
	Checksum: 0x424F4353
	Offset: 0x6850
	Size: 0x218
	Parameters: 1
	Flags: None
	Line Number: 1443
*/
function function_41967239(var_34d37a48)
{
	function_8b57c052("getsize", "");
	for(;;)
	{
		wait(0.05);
		var_dvar_value = function_ToLower(function_GetDvarString("getsize", ""));
		if(isdefined(var_dvar_value) && var_dvar_value != "")
		{
			function_8b57c052("getsize", "");
			var_cde9f622 = function_StrTok(var_dvar_value, " ");
			if(var_cde9f622.size > 1)
			{
				var_type = var_cde9f622[0];
				var_1f7056e3 = var_cde9f622[1];
				var_name = var_cde9f622[2];
				if(var_type == "struct")
				{
					var_value = namespace_struct::function_get_array(var_name, var_1f7056e3);
					function_IPrintLnBold("^8Dev: ^7Size of | " + var_name + " | is " + var_value.size);
				}
				else
				{
					var_value = function_GetEntArray(var_name, var_1f7056e3);
					function_IPrintLnBold("^8Dev: ^7Size of | " + var_name + " | is " + var_value.size);
				}
			}
			else
			{
				function_IPrintLnBold("^8Dev: ^7getsize needs parameters /getsize type class name");
			}
		}
	}
}

/*
	Name: function_733d5e3
	Namespace: namespace_b2e35c83
	Checksum: 0x424F4353
	Offset: 0x6A70
	Size: 0x240
	Parameters: 1
	Flags: None
	Line Number: 1488
*/
function function_733d5e3(var_34d37a48)
{
	function_8b57c052("pauseworld", "");
	for(;;)
	{
		wait(0.05);
		var_dvar_value = function_ToLower(function_GetDvarString("pauseworld", ""));
		if(isdefined(var_dvar_value) && var_dvar_value != "")
		{
			function_8b57c052("pauseworld", "");
			if(var_dvar_value == "on" || var_dvar_value == "activate" || var_dvar_value == "1")
			{
				function_SetPauseWorld(1);
				function_SetDvar("timecale", 0.01);
				if(level namespace_flag::function_exists("world_is_paused"))
				{
					level namespace_flag::function_set("world_is_paused");
				}
				function_842ad7f5(undefined, " ^5Dev: Paused World");
			}
			else if(var_dvar_value == "off" || var_dvar_value == "deactivate" || var_dvar_value == "0")
			{
				function_SetPauseWorld(0);
				function_SetDvar("timecale", 1);
				if(level namespace_flag::function_exists("world_is_paused"))
				{
					level namespace_flag::function_clear("world_is_paused");
				}
				function_842ad7f5(undefined, " ^1Dev: Unpaused World");
			}
		}
	}
}

/*
	Name: function_2d44d863
	Namespace: namespace_b2e35c83
	Checksum: 0x424F4353
	Offset: 0x6CB8
	Size: 0x628
	Parameters: 1
	Flags: None
	Line Number: 1532
*/
function function_2d44d863(var_34d37a48)
{
	function_8b57c052("spawn", "");
	for(;;)
	{
		wait(0.05);
		var_dvar_value = function_ToLower(function_GetDvarString("spawn", ""));
		if(isdefined(var_dvar_value) && var_dvar_value != "")
		{
			function_8b57c052("spawn", "");
			var_cde9f622 = function_StrTok(var_dvar_value, " ");
			if(var_cde9f622.size > 1)
			{
				var_type = var_cde9f622[0];
				var_value = function_Int(var_cde9f622[1]);
				var_model = var_cde9f622[2];
				switch(var_type)
				{
					case "spawn":
					{
						if(isdefined(level.var_ca27b6c))
						{
							level.var_ca27b6c function_delete();
						}
						else if(var_model == "p7_zm_vending_packapunch")
						{
							level.var_ca27b6c = namespace_util::function_spawn_model(var_model, level.var_players[0].var_origin, level.var_players[0].var_angles + VectorScale((0, 1, 0), 90));
						}
						else
						{
							level.var_ca27b6c = namespace_util::function_spawn_model(var_model, level.var_players[0].var_origin, level.var_players[0].var_angles);
							break;
						}
					}
					case "movex":
					{
						if(isdefined(level.var_ca27b6c))
						{
							function_IPrintLnBold("Moved Spawned Model " + var_value + " X inches");
							level.var_ca27b6c function_moveto(level.var_ca27b6c.var_origin + (var_value, 0, 0), 0.1);
						}
						else
						{
							function_IPrintLnBold("Spawned Model not defined");
							break;
						}
					}
					case "movey":
					{
						if(isdefined(level.var_ca27b6c))
						{
							function_IPrintLnBold("Moved Spawned Model " + var_value + " Y inches");
							level.var_ca27b6c function_moveto(level.var_ca27b6c.var_origin + (0, var_value, 0), 0.1);
						}
						else
						{
							function_IPrintLnBold("Spawned Model not defined");
							break;
						}
					}
					case "movez":
					{
						if(isdefined(level.var_ca27b6c))
						{
							function_IPrintLnBold("Moved Spawned Model " + var_value + " Z inches");
							level.var_ca27b6c function_moveto(level.var_ca27b6c.var_origin + (0, 0, var_value), 0.1);
						}
						else
						{
							function_IPrintLnBold("Spawned Model not defined");
							break;
						}
					}
					case "angle":
					{
						if(isdefined(level.var_ca27b6c))
						{
							function_IPrintLnBold("Rotate Spawned Model " + var_value + " Z inches");
							level.var_ca27b6c function_RotateTo(level.var_ca27b6c.var_angles + (0, var_value, 0), 0.1);
						}
						else
						{
							function_IPrintLnBold("Spawned Model not defined");
							break;
						}
					}
					case "coords":
					{
						if(isdefined(level.var_ca27b6c))
						{
							function_IPrintLnBold("Origin: " + level.var_ca27b6c.var_origin);
							function_IPrintLnBold("Angles: " + level.var_ca27b6c.var_angles);
						}
						else
						{
							function_IPrintLnBold("Spawned Model not defined");
							break;
						}
					}
				}
			}
			else
			{
				var_value = function_Int(var_cde9f622[0]);
				foreach(var_player in function_GetPlayers())
				{
					var_player function_SetCharacterBodyType(var_value);
				}
				function_842ad7f5(undefined, "^5Dev: ");
			}
		}
	}
}

/*
	Name: function_8465291f
	Namespace: namespace_b2e35c83
	Checksum: 0x424F4353
	Offset: 0x72E8
	Size: 0x330
	Parameters: 1
	Flags: None
	Line Number: 1656
*/
function function_8465291f(var_34d37a48)
{
	function_8b57c052("character", "");
	for(;;)
	{
		wait(0.05);
		var_dvar_value = function_ToLower(function_GetDvarString("character", ""));
		if(isdefined(var_dvar_value) && var_dvar_value != "")
		{
			function_8b57c052("character", "");
			var_cde9f622 = function_StrTok(var_dvar_value, " ");
			if(var_cde9f622.size > 1)
			{
				var_player_index = function_Int(var_cde9f622[0]);
				var_value = function_Int(var_cde9f622[1]);
				function_842ad7f5(level.var_players[var_player_index], "^5Dev: Changed Character for " + level.var_players[var_player_index].var_playerName);
				if(var_player_index >= 0 && var_player_index <= 7)
				{
					level.var_players[var_player_index] function_SetCharacterBodyType(var_value);
				}
				else
				{
					foreach(var_player in function_GetPlayers())
					{
						var_player function_SetCharacterBodyType(var_value);
					}
				}
			}
			else
			{
				var_value = function_Int(var_cde9f622[0]);
				foreach(var_player in function_GetPlayers())
				{
					var_player function_SetCharacterBodyType(var_value);
				}
				function_842ad7f5(undefined, "^5Dev: Changed Character for everyone");
			}
		}
	}
}

/*
	Name: function_29052cc
	Namespace: namespace_b2e35c83
	Checksum: 0x424F4353
	Offset: 0x7620
	Size: 0x330
	Parameters: 1
	Flags: None
	Line Number: 1707
*/
function function_29052cc(var_34d37a48)
{
	function_8b57c052("vision", "");
	for(;;)
	{
		wait(0.05);
		var_dvar_value = function_ToLower(function_GetDvarString("vision", ""));
		if(isdefined(var_dvar_value) && var_dvar_value != "")
		{
			function_8b57c052("vision", "");
			var_cde9f622 = function_StrTok(var_dvar_value, " ");
			if(var_cde9f622.size > 1)
			{
				var_player_index = function_Int(var_cde9f622[0]);
				var_value = function_Int(var_cde9f622[1]);
				function_842ad7f5(level.var_players[var_player_index], "^5Dev: Enabled Vision for " + level.var_players[var_player_index].var_playerName);
				if(var_player_index >= 0 && var_player_index <= 7)
				{
					namespace_visionset_mgr::function_activate("visionset", var_value, level.var_players[var_player_index]);
				}
				else
				{
					foreach(var_player in function_GetPlayers())
					{
						namespace_visionset_mgr::function_activate("visionset", var_value, var_player);
					}
				}
			}
			else
			{
				var_value = function_Int(var_cde9f622[0]);
				foreach(var_player in function_GetPlayers())
				{
					namespace_visionset_mgr::function_activate("visionset", var_value, var_player);
				}
				function_842ad7f5(undefined, "^5Dev: Enabled Vision for everyone");
			}
		}
	}
}

/*
	Name: function_1d8cf21f
	Namespace: namespace_b2e35c83
	Checksum: 0x424F4353
	Offset: 0x7958
	Size: 0x3B0
	Parameters: 1
	Flags: None
	Line Number: 1758
*/
function function_1d8cf21f(var_34d37a48)
{
	function_8b57c052("getxuid", "");
	for(;;)
	{
		wait(0.05);
		var_dvar_value = function_ToLower(function_GetDvarString("getxuid", ""));
		if(isdefined(var_dvar_value) && var_dvar_value != "")
		{
			function_8b57c052("getxuid", "");
			var_cde9f622 = function_StrTok(var_dvar_value, " ");
			if(var_cde9f622.size > 1)
			{
				var_player_index = function_Int(var_cde9f622[0]);
				var_value = function_Int(var_cde9f622[1]);
				function_842ad7f5(level.var_players[var_player_index], "^5Dev: Checked XUID of " + level.var_players[var_player_index].var_playerName);
				if(var_player_index >= 0 && var_player_index <= 7)
				{
					function_IPrintLnBold("Checked XUID of player " + level.var_players[var_player_index].var_playerName + " | XUID: " + level.var_players[var_player_index] function_getxuid(1));
				}
				else
				{
					foreach(var_player in function_GetPlayers())
					{
						function_IPrintLnBold("Checked XUID of player " + var_player + " | XUID: " + var_player function_getxuid(1));
					}
				}
			}
			else
			{
				var_value = function_Int(var_cde9f622[0]);
				foreach(var_player in function_GetPlayers())
				{
					function_IPrintLnBold("Checked XUID of player " + var_player.var_playerName + " | XUID: " + var_player function_getxuid(1));
				}
				function_842ad7f5(undefined, "^5Dev: Checked XUID of everyone");
			}
		}
	}
}

/*
	Name: function_8e96f735
	Namespace: namespace_b2e35c83
	Checksum: 0x424F4353
	Offset: 0x7D10
	Size: 0xC8
	Parameters: 1
	Flags: None
	Line Number: 1809
*/
function function_8e96f735(var_34d37a48)
{
	function_8b57c052("zone", "");
	for(;;)
	{
		wait(0.05);
		var_dvar_value = function_ToLower(function_GetDvarString("zone", ""));
		if(isdefined(var_dvar_value) && var_dvar_value != "")
		{
			function_8b57c052("zone", "");
			namespace_zm_zonemgr::function_enable_zone(var_dvar_value);
		}
	}
}

/*
	Name: function_44a8213d
	Namespace: namespace_b2e35c83
	Checksum: 0x424F4353
	Offset: 0x7DE0
	Size: 0xF0
	Parameters: 1
	Flags: None
	Line Number: 1834
*/
function function_44a8213d(var_34d37a48)
{
	function_8b57c052("perklimit", "");
	for(;;)
	{
		wait(0.05);
		var_dvar_value = function_ToLower(function_GetDvarString("perklimit", ""));
		if(isdefined(var_dvar_value) && var_dvar_value != "")
		{
			function_8b57c052("perklimit", "");
			function_842ad7f5(0, "^5Dev: Changed Perk Limit to " + var_dvar_value);
			level.var_perk_purchase_limit = function_Int(var_dvar_value);
		}
	}
}

/*
	Name: function_94992741
	Namespace: namespace_b2e35c83
	Checksum: 0x424F4353
	Offset: 0x7ED8
	Size: 0x1D0
	Parameters: 1
	Flags: None
	Line Number: 1860
*/
function function_94992741(var_34d37a48)
{
	function_8b57c052("teleport", "");
	for(;;)
	{
		wait(0.05);
		var_dvar_value = function_ToLower(function_GetDvarString("teleport", ""));
		if(isdefined(var_dvar_value) && var_dvar_value != "")
		{
			function_8b57c052("teleport", "");
			var_cde9f622 = function_StrTok(var_dvar_value, " ");
			if(var_cde9f622.size > 1)
			{
				var_player_index = function_Int(var_cde9f622[0]);
				var_57024f52 = function_Int(var_cde9f622[1]);
				function_842ad7f5(level.var_players[var_player_index], "^5Dev: Teleported " + level.var_players[var_player_index].var_playerName + " to " + level.var_players[var_57024f52].var_playerName);
				level.var_players[var_player_index] function_777705d3(level.var_players[var_57024f52]);
			}
		}
	}
}

/*
	Name: function_d98cafff
	Namespace: namespace_b2e35c83
	Checksum: 0x424F4353
	Offset: 0x80B0
	Size: 0x498
	Parameters: 1
	Flags: None
	Line Number: 1892
*/
function function_d98cafff(var_34d37a48)
{
	function_8b57c052("points", "");
	for(;;)
	{
		wait(0.05);
		var_dvar_value = function_ToLower(function_GetDvarString("points", ""));
		if(isdefined(var_dvar_value) && var_dvar_value != "")
		{
			function_8b57c052("points", "");
			var_cde9f622 = function_StrTok(var_dvar_value, " ");
			if(var_cde9f622.size > 1)
			{
				var_player_index = function_Int(var_cde9f622[0]);
				var_value = var_cde9f622[1];
				function_842ad7f5(level.var_players[var_player_index], "^5Dev: added " + var_value + " points to " + level.var_players[var_player_index].var_playerName);
				if(var_player_index >= 0 && var_player_index <= 7)
				{
					if(var_value == "max")
					{
						level.var_players[var_player_index] namespace_zm_score::function_add_to_player_score(500000000);
						namespace_zm_utility::function_play_sound_at_pos("purchase", level.var_players[var_player_index].var_origin);
					}
					else
					{
						level.var_players[var_player_index] namespace_zm_score::function_add_to_player_score(function_Int(var_value));
						namespace_zm_utility::function_play_sound_at_pos("purchase", level.var_players[var_player_index].var_origin);
					}
				}
				else
				{
					foreach(var_player in function_GetPlayers())
					{
						var_player namespace_zm_score::function_add_to_player_score(function_Int(var_value));
						namespace_zm_utility::function_play_sound_at_pos("purchase", var_player.var_origin);
					}
				}
			}
			else
			{
				var_value = var_cde9f622[0];
				foreach(var_player in function_GetPlayers())
				{
					if(var_value == "max")
					{
						var_player namespace_zm_score::function_add_to_player_score(500000000);
						namespace_zm_utility::function_play_sound_at_pos("purchase", var_player.var_origin);
						continue;
					}
					var_player namespace_zm_score::function_add_to_player_score(function_Int(var_value));
					namespace_zm_utility::function_play_sound_at_pos("purchase", var_player.var_origin);
				}
				function_842ad7f5(undefined, "^5Dev: added " + var_value + " points to all players");
			}
		}
	}
}

/*
	Name: function_3cbc2a7e
	Namespace: namespace_b2e35c83
	Checksum: 0x424F4353
	Offset: 0x8550
	Size: 0x8C0
	Parameters: 1
	Flags: None
	Line Number: 1960
*/
function function_3cbc2a7e(var_34d37a48)
{
	function_8b57c052("givew", "");
	for(;;)
	{
		wait(0.05);
		var_dvar_value = function_ToLower(function_GetDvarString("givew", ""));
		if(isdefined(var_dvar_value) && var_dvar_value != "")
		{
			function_8b57c052("givew", "");
			var_cde9f622 = function_StrTok(var_dvar_value, " ");
			if(var_cde9f622.size > 1)
			{
				var_player_index = function_Int(var_cde9f622[0]);
				var_weapon_name = var_cde9f622[1];
				function_842ad7f5(level.var_players[var_player_index], "^5Dev: Weapon " + var_weapon_name + " given to " + level.var_players[var_player_index].var_playerName);
				if(var_weapon_name == "ammo")
				{
					if(var_player_index >= 0 && var_player_index <= 7)
					{
						level.var_players[var_player_index] thread function_7265a195();
					}
					else
					{
						foreach(var_player in function_GetPlayers())
						{
							var_player thread function_7265a195();
						}
					}
				}
				else if(var_weapon_name == "random")
				{
					if(var_player_index >= 0 && var_player_index <= 7)
					{
						level.var_players[var_player_index] namespace_zm_weapons::function_weapon_give(namespace_Array::function_random(function_getArrayKeys(level.var_zombie_weapons)), 0, 0, 1, 1);
					}
					else
					{
						foreach(var_player in function_GetPlayers())
						{
							var_player namespace_zm_weapons::function_weapon_give(namespace_Array::function_random(function_getArrayKeys(level.var_zombie_weapons)), 0, 0, 1, 1);
						}
					}
				}
				else if(var_weapon_name == "random_up")
				{
					if(var_player_index >= 0 && var_player_index <= 7)
					{
						level.var_players[var_player_index] namespace_zm_weapons::function_weapon_give(namespace_Array::function_random(function_getArrayKeys(level.var_zombie_weapons_upgraded)), 0, 0, 1, 1);
					}
					else
					{
						foreach(var_player in function_GetPlayers())
						{
							var_player namespace_zm_weapons::function_weapon_give(namespace_Array::function_random(function_getArrayKeys(level.var_zombie_weapons)), 0, 0, 1, 1);
						}
					}
				}
				else if(var_player_index >= 0 && var_player_index <= 7)
				{
					level.var_players[var_player_index] namespace_zm_weapons::function_weapon_give(function_GetWeapon(var_weapon_name), 0, 0, 1, 1);
				}
				else
				{
					foreach(var_player in function_GetPlayers())
					{
						var_player namespace_zm_weapons::function_weapon_give(function_GetWeapon(var_weapon_name), 0, 0, 1, 1);
					}
				}
			}
			else
			{
				var_weapon_name = var_cde9f622[0];
				if(var_weapon_name == "ammo")
				{
					namespace_Array::function_thread_all(function_GetPlayers(), &function_7265a195);
				}
				else if(var_weapon_name == "random")
				{
					foreach(var_player in function_GetPlayers())
					{
						var_player namespace_zm_weapons::function_weapon_give(namespace_Array::function_random(function_getArrayKeys(level.var_zombie_weapons)), 0, 0, 1, 1);
					}
				}
				else if(var_weapon_name == "random_up")
				{
					foreach(var_player in function_GetPlayers())
					{
						var_player namespace_zm_weapons::function_weapon_give(namespace_Array::function_random(function_getArrayKeys(level.var_zombie_weapons_upgraded)), 0, 0, 1, 1);
					}
				}
				else
				{
					foreach(var_player in function_GetPlayers())
					{
						var_player namespace_zm_weapons::function_weapon_give(function_GetWeapon(var_weapon_name), 0, 0, 1, 1);
					}
				}
				function_842ad7f5(undefined, "^5Dev: given " + var_weapon_name + " weapon to all players");
			}
		}
	}
}

/*
	Name: function_7265a195
	Namespace: namespace_b2e35c83
	Checksum: 0x424F4353
	Offset: 0x8E18
	Size: 0x188
	Parameters: 0
	Flags: None
	Line Number: 2074
*/
function function_7265a195()
{
	var_weapons_list = self function_GetWeaponsList(1);
	foreach(var_weapon in var_weapons_list)
	{
		if(var_weapon != level.var_weaponNone)
		{
			self function_SetWeaponOverheating(0, 0);
			var_max = var_weapon.var_maxAmmo;
			if(isdefined(var_max))
			{
				self function_SetWeaponAmmoStock(var_weapon, var_max);
			}
			if(isdefined(self namespace_zm_utility::function_get_player_tactical_grenade()))
			{
				self function_giveMaxAmmo(self namespace_zm_utility::function_get_player_tactical_grenade());
			}
			if(isdefined(self namespace_zm_utility::function_get_player_lethal_grenade()))
			{
				self function_giveMaxAmmo(self namespace_zm_utility::function_get_player_lethal_grenade());
			}
		}
	}
}

/*
	Name: function_439ef9bd
	Namespace: namespace_b2e35c83
	Checksum: 0x424F4353
	Offset: 0x8FA8
	Size: 0x408
	Parameters: 1
	Flags: None
	Line Number: 2109
*/
function function_439ef9bd(var_34d37a48)
{
	function_8b57c052("bgb", "");
	for(;;)
	{
		wait(0.05);
		var_dvar_value = function_ToLower(function_GetDvarString("bgb", ""));
		if(isdefined(var_dvar_value) && var_dvar_value != "")
		{
			function_8b57c052("bgb", "");
			var_cde9f622 = function_StrTok(var_dvar_value, " ");
			var_bee20606 = function_ToLower(var_cde9f622[0]);
			var_cfce2918 = "";
			if(var_bee20606 == "random")
			{
				var_6620b43f = namespace_Array::function_randomize(function_getArrayKeys(level.var_bgb));
				var_cfce2918 = var_6620b43f[0];
			}
			else
			{
				var_cfce2918 = "zm_bgb_" + var_bee20606;
			}
			var_keys = function_getArrayKeys(level.var_bgb);
			if(namespace_Array::function_contains(var_keys, var_cfce2918))
			{
				if(var_cde9f622.size > 1)
				{
					var_player_index = function_Int(var_cde9f622[1]);
					if(isdefined(level.var_players[var_player_index]))
					{
						level.var_players[var_player_index] thread namespace_bgb::function_give(var_cfce2918);
					}
					else
					{
						foreach(var_player in function_GetPlayers())
						{
							var_player thread namespace_bgb::function_give(var_cfce2918);
						}
					}
					function_842ad7f5(level.var_players[var_player_index], "^5Dev: gave bgb " + var_cfce2918 + " to " + level.var_players[var_player_index].var_playerName);
				}
				else
				{
					foreach(var_player in function_GetPlayers())
					{
						var_player thread namespace_bgb::function_give(var_cfce2918);
					}
					function_842ad7f5(undefined, "^5Dev: gave " + var_cfce2918 + " points to all players");
				}
			}
			else
			{
				function_842ad7f5(undefined, "^5Dev: bgb " + var_cfce2918 + " not found");
			}
		}
	}
}

/*
	Name: function_7962a08e
	Namespace: namespace_b2e35c83
	Checksum: 0x424F4353
	Offset: 0x93B8
	Size: 0x1F0
	Parameters: 1
	Flags: None
	Line Number: 2177
*/
function function_7962a08e(var_34d37a48)
{
	function_8b57c052("ignore", "");
	for(;;)
	{
		wait(0.05);
		var_dvar_value = function_ToLower(function_GetDvarString("ignore", ""));
		if(isdefined(var_dvar_value) && var_dvar_value != "")
		{
			function_8b57c052("ignore", "");
			var_player_index = function_Int(var_dvar_value);
			function_842ad7f5(level.var_players[var_player_index], "^5Dev: Make player " + level.var_players[var_player_index].var_playerName + " ignored");
			if(var_player_index >= 0 && var_player_index <= 7)
			{
				level.var_players[var_player_index] function_26b76d00();
			}
			else
			{
				foreach(var_player in function_GetPlayers())
				{
					var_player function_26b76d00();
				}
			}
		}
	}
}

/*
	Name: function_26b76d00
	Namespace: namespace_b2e35c83
	Checksum: 0x424F4353
	Offset: 0x95B0
	Size: 0x38
	Parameters: 0
	Flags: None
	Line Number: 2214
*/
function function_26b76d00()
{
	if(!(isdefined(self.var_ignoreme) && self.var_ignoreme))
	{
		self.var_ignoreme = 1;
	}
	else
	{
		self.var_ignoreme = 0;
	}
}

/*
	Name: function_230a41e7
	Namespace: namespace_b2e35c83
	Checksum: 0x424F4353
	Offset: 0x95F0
	Size: 0x1E8
	Parameters: 0
	Flags: None
	Line Number: 2236
*/
function function_230a41e7()
{
	function_8b57c052("infinite_ammo", "");
	for(;;)
	{
		wait(0.05);
		var_dvar_value = function_ToLower(function_GetDvarString("infinite_ammo", ""));
		if(isdefined(var_dvar_value) && var_dvar_value != "")
		{
			function_8b57c052("infinite_ammo", "");
			var_player_index = function_Int(var_dvar_value);
			function_842ad7f5(level.var_players[var_player_index], "^5Dev: Give player " + level.var_players[var_player_index].var_playerName + " infinite ammo");
			if(var_player_index >= 0 && var_player_index <= 7)
			{
				level.var_players[var_player_index] thread function_807f30dc();
			}
			else
			{
				foreach(var_player in function_GetPlayers())
				{
					var_player thread function_807f30dc();
				}
			}
		}
	}
}

/*
	Name: function_807f30dc
	Namespace: namespace_b2e35c83
	Checksum: 0x424F4353
	Offset: 0x97E0
	Size: 0x1F8
	Parameters: 0
	Flags: None
	Line Number: 2273
*/
function function_807f30dc()
{
	self notify("toggle_infinite_ammo" + self function_GetEntityNumber() + 1);
	self endon("toggle_infinite_ammo" + self function_GetEntityNumber() + 1);
	if(!(isdefined(self.var_ammo4evah) && self.var_ammo4evah))
	{
		self.var_ammo4evah = 1;
		for(;;)
		{
			var_weapon = self function_GetCurrentWeapon();
			if(var_weapon != level.var_weaponNone)
			{
				self function_SetWeaponOverheating(0, 0);
				var_max = var_weapon.var_maxAmmo;
				if(isdefined(var_max))
				{
					self function_SetWeaponAmmoStock(var_weapon, var_max);
				}
				if(isdefined(self namespace_zm_utility::function_get_player_tactical_grenade()))
				{
					self function_giveMaxAmmo(self namespace_zm_utility::function_get_player_tactical_grenade());
				}
				if(isdefined(self namespace_zm_utility::function_get_player_lethal_grenade()))
				{
					self function_giveMaxAmmo(self namespace_zm_utility::function_get_player_lethal_grenade());
				}
				self function_SetWeaponAmmoClip(var_weapon, var_weapon.var_clipSize);
			}
			wait(0.05);
		}
	}
	else
	{
		self.var_ammo4evah = 0;
		self notify("toggle_infinite_ammo" + self function_GetEntityNumber() + 1);
	}
}

/*
	Name: function_de195d8f
	Namespace: namespace_b2e35c83
	Checksum: 0x424F4353
	Offset: 0x99E0
	Size: 0x180
	Parameters: 1
	Flags: None
	Line Number: 2321
*/
function function_de195d8f(var_34d37a48)
{
	function_8b57c052("teleportz", "");
	for(;;)
	{
		wait(0.05);
		var_dvar_value = function_ToLower(function_GetDvarString("teleportz", ""));
		if(isdefined(var_dvar_value) && var_dvar_value != "")
		{
			function_8b57c052("teleportz", "");
			var_player_index = function_Int(var_dvar_value);
			if(var_player_index >= 0 && var_player_index <= 7)
			{
				level.var_players[var_player_index] function_cb97fbc2();
				function_842ad7f5(level.var_players[var_player_index], "^5Dev: Teleport zombies to " + level.var_players[var_player_index].var_playerName);
			}
			else
			{
				function_842ad7f5(level.var_players[var_player_index], "^5Dev: Couldn't teleport zombies to player, please give an index from 0 - 7");
			}
		}
	}
}

/*
	Name: function_cb97fbc2
	Namespace: namespace_b2e35c83
	Checksum: 0x424F4353
	Offset: 0x9B68
	Size: 0x110
	Parameters: 0
	Flags: None
	Line Number: 2355
*/
function function_cb97fbc2()
{
	var_player_angles = self function_getPlayerAngles();
	var_forward_vec = function_AnglesToForward((0, var_player_angles[1] + 100, 0));
	foreach(var_zombie in function_GetAITeamArray("axis"))
	{
		var_zombie function_ForceTeleport(self.var_origin, var_forward_vec, 1);
	}
}

/*
	Name: function_ac7624f9
	Namespace: namespace_b2e35c83
	Checksum: 0x424F4353
	Offset: 0x9C80
	Size: 0x240
	Parameters: 1
	Flags: None
	Line Number: 2375
*/
function function_ac7624f9(var_34d37a48)
{
	function_8b57c052("spawning", "");
	for(;;)
	{
		wait(0.05);
		var_dvar_value = function_ToLower(function_GetDvarString("spawning", ""));
		if(isdefined(var_dvar_value) && var_dvar_value != "")
		{
			function_8b57c052("spawning", "");
			if(var_dvar_value == "on" || var_dvar_value == "activate" || var_dvar_value == "1")
			{
				level namespace_flag::function_set("spawn_zombies");
				function_842ad7f5(undefined, " ^5Dev: Turned spawning on");
			}
			else if(var_dvar_value == "off" || var_dvar_value == "deactivate" || var_dvar_value == "0")
			{
				level namespace_flag::function_clear("spawn_zombies");
				var_a_ai_enemies = function_GetAITeamArray("axis");
				foreach(var_ai_enemy in var_a_ai_enemies)
				{
					level.var_zombie_total++;
					level.var_zombie_respawns++;
					var_ai_enemy function_kill();
				}
				function_842ad7f5(undefined, " ^1Dev: Turned spawning off");
			}
		}
	}
}

/*
	Name: function_9d42278d
	Namespace: namespace_b2e35c83
	Checksum: 0x424F4353
	Offset: 0x9EC8
	Size: 0x260
	Parameters: 1
	Flags: None
	Line Number: 2416
*/
function function_9d42278d(var_34d37a48)
{
	function_8b57c052("godmode", "");
	for(;;)
	{
		wait(0.05);
		var_dvar_value = function_ToLower(function_GetDvarString("godmode", ""));
		if(isdefined(var_dvar_value) && var_dvar_value != "")
		{
			function_8b57c052("godmode", "");
			var_cde9f622 = function_StrTok(var_dvar_value, " ");
			if(var_cde9f622.size > 1)
			{
				var_player_index = function_Int(var_cde9f622[0]);
				var_value = var_cde9f622[1];
				function_842ad7f5(level.var_players[var_player_index], "^5Dev: Set godmode to " + var_value + " for " + level.var_players[var_player_index].var_playerName);
				if(var_player_index >= 0 && var_player_index <= 7)
				{
					level.var_players[var_player_index] thread function_bd4abbcd(var_value);
				}
				else
				{
					namespace_Array::function_thread_all(function_GetPlayers(), &function_bd4abbcd, var_value);
				}
			}
			else
			{
				var_value = var_cde9f622[0];
				namespace_Array::function_thread_all(function_GetPlayers(), &function_bd4abbcd, var_value);
				function_842ad7f5(undefined, "^5Dev: Set godmode to " + var_value + " to all players");
			}
		}
	}
}

/*
	Name: function_bd4abbcd
	Namespace: namespace_b2e35c83
	Checksum: 0x424F4353
	Offset: 0xA130
	Size: 0xA0
	Parameters: 1
	Flags: None
	Line Number: 2461
*/
function function_bd4abbcd(var_onOff)
{
	if(var_onOff == "on" || var_onOff == "activate" || var_onOff == "1")
	{
		self function_EnableInvulnerability();
	}
	else if(var_onOff == "off" || var_onOff == "deactivate" || var_onOff == "0")
	{
		self function_DisableInvulnerability();
	}
}

/*
	Name: function_841abf49
	Namespace: namespace_b2e35c83
	Checksum: 0x424F4353
	Offset: 0xA1D8
	Size: 0x3F8
	Parameters: 1
	Flags: None
	Line Number: 2483
*/
function function_841abf49(var_34d37a48)
{
	function_8b57c052("camo", "");
	for(;;)
	{
		wait(0.05);
		var_dvar_value = function_ToLower(function_GetDvarString("camo", ""));
		if(isdefined(var_dvar_value) && var_dvar_value != "")
		{
			function_8b57c052("camo", "");
			var_cde9f622 = function_StrTok(var_dvar_value, " ");
			if(var_cde9f622.size > 1)
			{
				var_player_index = function_Int(var_cde9f622[0]);
				var_value = function_Int(var_cde9f622[1]);
				function_842ad7f5(level.var_players[var_player_index], "^5Dev: Changed weaponcamo to " + var_value + " for " + level.var_players[var_player_index].var_playerName);
				if(var_player_index >= 0 && var_player_index <= 7)
				{
					level.var_players[var_player_index] function_c8540b60(level.var_players[var_player_index] function_GetCurrentWeapon(), level.var_players[var_player_index] function_CalcWeaponOptions(var_value, 0, 0));
				}
				else
				{
					foreach(var_player in function_GetPlayers())
					{
						var_player function_c8540b60(var_player function_GetCurrentWeapon(), var_player function_CalcWeaponOptions(var_value, 0, 0));
					}
				}
				level.var_pack_a_punch_camo_index = var_value;
			}
			else
			{
				var_value = function_Int(var_cde9f622[0]);
				foreach(var_player in function_GetPlayers())
				{
					var_player function_c8540b60(var_player function_GetCurrentWeapon(), var_player function_CalcWeaponOptions(var_value, 0, 0));
				}
				level.var_pack_a_punch_camo_index = var_value;
				function_842ad7f5(undefined, "^5Dev: Changed weaponcamo to " + var_value + " for all players");
			}
		}
	}
}

/*
	Name: function_d3b33c79
	Namespace: namespace_b2e35c83
	Checksum: 0x424F4353
	Offset: 0xA5D8
	Size: 0xF8
	Parameters: 1
	Flags: None
	Line Number: 2536
*/
function function_d3b33c79(var_34d37a48)
{
	function_8b57c052("lighting", "");
	for(;;)
	{
		wait(0.05);
		var_dvar_value = function_ToLower(function_GetDvarString("lighting", ""));
		if(isdefined(var_dvar_value) && var_dvar_value != "")
		{
			function_8b57c052("lighting", "");
			level namespace_util::function_set_lighting_state(function_Int(var_dvar_value));
			function_842ad7f5(undefined, "^5Dev: Changed lightingstate to " + var_dvar_value);
		}
	}
}

/*
	Name: function_3849dbc1
	Namespace: namespace_b2e35c83
	Checksum: 0x424F4353
	Offset: 0xA6D8
	Size: 0x190
	Parameters: 1
	Flags: None
	Line Number: 2562
*/
function function_3849dbc1(var_34d37a48)
{
	function_8b57c052("revive", "");
	for(;;)
	{
		wait(0.05);
		var_dvar_value = function_ToLower(function_GetDvarString("revive", ""));
		if(isdefined(var_dvar_value) && var_dvar_value != "")
		{
			function_8b57c052("revive", "");
			var_player_index = var_dvar_value;
			function_842ad7f5(level.var_players[var_player_index], "^5Dev: revived " + level.var_players[var_player_index].var_playerName);
			if(var_player_index >= 0 && var_player_index <= 7)
			{
				level.var_players[var_player_index] thread function_ddbe3da9();
			}
			else
			{
				namespace_Array::function_thread_all(function_GetPlayers(), &function_ddbe3da9);
				function_842ad7f5(undefined, "^5Dev: revived all players");
			}
		}
	}
}

/*
	Name: function_5dfa741b
	Namespace: namespace_b2e35c83
	Checksum: 0x424F4353
	Offset: 0xA870
	Size: 0x110
	Parameters: 1
	Flags: None
	Line Number: 2597
*/
function function_5dfa741b(var_34d37a48)
{
	function_8b57c052("get_coords", "");
	for(;;)
	{
		wait(0.05);
		var_dvar_value = function_ToLower(function_GetDvarString("get_coords", ""));
		if(isdefined(var_dvar_value) && var_dvar_value != "")
		{
			function_8b57c052("get_coords", "");
			function_IPrintLnBold("Origin: " + level.var_players[0].var_origin);
			function_IPrintLnBold("Angles: " + level.var_players[0].var_angles);
		}
	}
}

/*
	Name: function_ddbe3da9
	Namespace: namespace_b2e35c83
	Checksum: 0x424F4353
	Offset: 0xA988
	Size: 0xA0
	Parameters: 0
	Flags: None
	Line Number: 2623
*/
function function_ddbe3da9()
{
	self function_RevivePlayer();
	self notify("hash_stop_revive_trigger");
	if(isdefined(self.var_reviveTrigger))
	{
		self.var_reviveTrigger function_delete();
		self.var_reviveTrigger = undefined;
	}
	self function_AllowJump(1);
	self.var_ignoreme = 0;
	self.var_laststand = undefined;
	self notify("hash_player_revived", self);
}

/*
	Name: function_6bd24506
	Namespace: namespace_b2e35c83
	Checksum: 0x424F4353
	Offset: 0xAA30
	Size: 0x118
	Parameters: 1
	Flags: None
	Line Number: 2648
*/
function function_6bd24506(var_34d37a48)
{
	function_8b57c052("spawn_dog", "");
	for(;;)
	{
		wait(0.05);
		var_dvar_value = function_ToLower(function_GetDvarString("spawn_dog", ""));
		if(isdefined(var_dvar_value) && var_dvar_value != "")
		{
			function_8b57c052("spawn_dog", "");
			if(!isdefined(level.var_dogs_enabled) || !level.var_dogs_enabled)
			{
				function_842ad7f5(undefined, " ^1Dev: Dogs not enabled in the map");
			}
			else
			{
				function_842ad7f5(undefined, " ^5Dev: Spawned " + var_dvar_value + " dogs");
			}
		}
	}
}

/*
	Name: function_999e848e
	Namespace: namespace_b2e35c83
	Checksum: 0x424F4353
	Offset: 0xAB50
	Size: 0xF0
	Parameters: 1
	Flags: None
	Line Number: 2680
*/
function function_999e848e(var_34d37a48)
{
	function_8b57c052("spawn_zombie", "");
	for(;;)
	{
		wait(0.05);
		var_dvar_value = function_ToLower(function_GetDvarString("spawn_zombie", ""));
		if(isdefined(var_dvar_value) && var_dvar_value != "")
		{
			function_8b57c052("spawn_zombie", "");
			level thread function_c72962f0(var_dvar_value);
			function_842ad7f5(undefined, " ^5Dev: Spawned " + var_dvar_value + " zombies");
		}
	}
}

/*
	Name: function_2c6370a9
	Namespace: namespace_b2e35c83
	Checksum: 0x424F4353
	Offset: 0xAC48
	Size: 0x1F8
	Parameters: 1
	Flags: None
	Line Number: 2706
*/
function function_2c6370a9(var_34d37a48)
{
	function_8b57c052("power", "");
	for(;;)
	{
		wait(0.05);
		var_dvar_value = function_ToLower(function_GetDvarString("power", ""));
		if(isdefined(var_dvar_value) && var_dvar_value != "")
		{
			function_8b57c052("power", "");
			if(var_dvar_value == "on" || var_dvar_value == "activate" || var_dvar_value == "1")
			{
				level namespace_flag::function_clear("power_off");
				level namespace_flag::function_set("power_on");
				function_842ad7f5(undefined, " ^5Dev: power turned on");
			}
			else if(var_dvar_value == "off" || var_dvar_value == "deactivate" || var_dvar_value == "0")
			{
				level namespace_flag::function_clear("power_on");
				level namespace_flag::function_set("power_off");
				level namespace_clientfield::function_set("zombie_power_off", 0);
				level notify("hash_power_off");
				function_842ad7f5(undefined, " ^1Dev: power turned off");
			}
		}
	}
}

/*
	Name: function_fe3fe39b
	Namespace: namespace_b2e35c83
	Checksum: 0x424F4353
	Offset: 0xAE48
	Size: 0xB8
	Parameters: 1
	Flags: None
	Line Number: 2744
*/
function function_fe3fe39b(var_34d37a48)
{
	function_8b57c052("print", "");
	for(;;)
	{
		wait(0.05);
		var_dvar_value = function_GetDvarString("print", "");
		if(isdefined(var_dvar_value) && var_dvar_value != "")
		{
			function_8b57c052("print", "");
			function_IPrintLnBold(var_dvar_value);
		}
	}
}

/*
	Name: function_53447c0f
	Namespace: namespace_b2e35c83
	Checksum: 0x424F4353
	Offset: 0xAF08
	Size: 0xB8
	Parameters: 1
	Flags: None
	Line Number: 2769
*/
function function_53447c0f(var_34d37a48)
{
	function_8b57c052("printsmall", "");
	for(;;)
	{
		wait(0.05);
		var_dvar_value = function_GetDvarString("printsmall", "");
		if(isdefined(var_dvar_value) && var_dvar_value != "")
		{
			function_8b57c052("printsmall", "");
			function_iprintln(var_dvar_value);
		}
	}
}

/*
	Name: function_c9542ee0
	Namespace: namespace_b2e35c83
	Checksum: 0x424F4353
	Offset: 0xAFC8
	Size: 0x1A8
	Parameters: 1
	Flags: None
	Line Number: 2794
*/
function function_c9542ee0(var_34d37a48)
{
	function_8b57c052("show_healthbar", "");
	for(;;)
	{
		wait(0.05);
		var_dvar_value = function_ToLower(function_GetDvarString("show_healthbar", ""));
		if(isdefined(var_dvar_value) && var_dvar_value != "")
		{
			function_8b57c052("show_healthbar", "");
			if(var_dvar_value == "on" || var_dvar_value == "activate" || var_dvar_value == "1")
			{
				function_GetPlayers()[0] thread function_c3b27b45(1);
				function_842ad7f5(undefined, " ^5Dev: Show zombies Healthbar");
			}
			else if(var_dvar_value == "off" || var_dvar_value == "deactivate" || var_dvar_value == "0")
			{
				function_GetPlayers()[0] thread function_c3b27b45(0);
				function_842ad7f5(undefined, " ^5Dev: Hide zombies Healthbar");
			}
		}
	}
}

/*
	Name: function_c3b27b45
	Namespace: namespace_b2e35c83
	Checksum: 0x424F4353
	Offset: 0xB178
	Size: 0x210
	Parameters: 1
	Flags: Private
	Line Number: 2828
*/
function private function_c3b27b45(var_activate)
{
	self notify("end_zombie_healthbar" + self function_GetEntityNumber() + 1);
	self endon("end_zombie_healthbar" + self function_GetEntityNumber() + 1);
	if(isdefined(var_activate) && var_activate)
	{
		while(1)
		{
			var_lp = function_GetPlayers()[0];
			var_zombies = function_GetAISpeciesArray(level.var_zombie_team);
			if(isdefined(var_zombies))
			{
				foreach(var_zombie in var_zombies)
				{
					var_zombie function_zombie_healthbar(var_lp.var_origin, 360000);
				}
			}
			wait(0.05);
		}
	}
	foreach(var_zombie in function_GetAITeamArray(level.var_zombie_team))
	{
		var_zombie namespace_clientfield::function_set("debug_zombie_enable_keyline", 0);
	}
}

/*
	Name: function_zombie_healthbar
	Namespace: namespace_b2e35c83
	Checksum: 0x424F4353
	Offset: 0xB390
	Size: 0x108
	Parameters: 2
	Flags: None
	Line Number: 2864
*/
function function_zombie_healthbar(var_pos, var_dsquared)
{
	/#
		if(function_DistanceSquared(var_pos, self.var_origin) > var_dsquared)
		{
			return;
		}
		var_rate = 1;
		if(isdefined(self.var_maxhealth))
		{
			var_rate = self.var_health / self.var_maxhealth;
		}
		var_color = (1 - var_rate, var_rate, 0);
		var_text = "Dev Block strings are not supported" + function_Int(self.var_health);
		function_print3d(self.var_origin + VectorScale((0, 0, 1), 70), var_text, var_color, 1, 0.5, 1);
	#/
}

/*
	Name: function_109891a9
	Namespace: namespace_b2e35c83
	Checksum: 0x424F4353
	Offset: 0xB4A0
	Size: 0x1A8
	Parameters: 1
	Flags: None
	Line Number: 2892
*/
function function_109891a9(var_34d37a48)
{
	function_8b57c052("show_zombies", "");
	for(;;)
	{
		wait(0.05);
		var_dvar_value = function_ToLower(function_GetDvarString("show_zombies", ""));
		if(isdefined(var_dvar_value) && var_dvar_value != "")
		{
			function_8b57c052("show_zombies", "");
			if(var_dvar_value == "on" || var_dvar_value == "activate" || var_dvar_value == "1")
			{
				function_GetPlayers()[0] thread function_8ca7779f(1);
				function_842ad7f5(undefined, " ^5Dev: Show zombies outline through walls");
			}
			else if(var_dvar_value == "off" || var_dvar_value == "deactivate" || var_dvar_value == "0")
			{
				function_GetPlayers()[0] thread function_8ca7779f(0);
				function_842ad7f5(undefined, " ^5Dev: Hide zombies outline through walls");
			}
		}
	}
}

/*
	Name: function_8ca7779f
	Namespace: namespace_b2e35c83
	Checksum: 0x424F4353
	Offset: 0xB650
	Size: 0x1D0
	Parameters: 1
	Flags: None
	Line Number: 2926
*/
function function_8ca7779f(var_activate)
{
	self notify("end_zombie_outlining" + self function_GetEntityNumber() + 1);
	self endon("end_zombie_outlining" + self function_GetEntityNumber() + 1);
	if(isdefined(var_activate) && var_activate)
	{
		for(;;)
		{
			foreach(var_zombie in function_GetAITeamArray(level.var_zombie_team))
			{
				var_zombie namespace_clientfield::function_set("debug_zombie_enable_keyline", 1);
				var_zombie thread function_d312afc4();
			}
			wait(2);
		}
	}
	foreach(var_zombie in function_GetAITeamArray(level.var_zombie_team))
	{
		var_zombie namespace_clientfield::function_set("debug_zombie_enable_keyline", 0);
	}
}

/*
	Name: function_d312afc4
	Namespace: namespace_b2e35c83
	Checksum: 0x424F4353
	Offset: 0xB828
	Size: 0x48
	Parameters: 0
	Flags: None
	Line Number: 2958
*/
function function_d312afc4()
{
	self namespace_util::function_waittill_any_return("death");
	self namespace_clientfield::function_set("debug_zombie_enable_keyline", 0);
}

/*
	Name: function_1a6da99d
	Namespace: namespace_b2e35c83
	Checksum: 0x424F4353
	Offset: 0xB878
	Size: 0x498
	Parameters: 1
	Flags: None
	Line Number: 2974
*/
function function_1a6da99d(var_34d37a48)
{
	function_8b57c052("outline", "");
	for(;;)
	{
		wait(0.05);
		var_dvar_value = function_ToLower(function_GetDvarString("outline", ""));
		if(isdefined(var_dvar_value) && var_dvar_value != "")
		{
			function_8b57c052("outline", "");
			var_cde9f622 = function_StrTok(var_dvar_value, " ");
			if(var_cde9f622.size > 2)
			{
				var_type = var_cde9f622[0];
				var_model_list = var_cde9f622[1];
				var_value = var_cde9f622[2];
				if(var_value == "on" || var_value == "activate" || var_value == "1")
				{
					if(var_type == "struct")
					{
						foreach(var_struct in namespace_struct::function_get_array(var_model_list))
						{
							var_struct.var_model namespace_clientfield::function_set("debug_enable_keyline", 1);
						}
					}
					else
					{
						foreach(var_model in function_GetEntArray(var_model_list, "targetname"))
						{
							var_model namespace_clientfield::function_set("debug_enable_keyline", 1);
						}
					}
					function_842ad7f5(undefined, " ^5Dev: Turned outline on for models");
				}
				else if(var_value == "off" || var_value == "deactivate" || var_value == "0")
				{
					if(var_type == "struct")
					{
						foreach(var_struct in namespace_struct::function_get_array(var_model_list))
						{
							var_struct.var_model namespace_clientfield::function_set("debug_enable_keyline", 0);
						}
					}
					else
					{
						foreach(var_model in function_GetEntArray(var_model_list, "targetname"))
						{
							var_model namespace_clientfield::function_set("debug_enable_keyline", 0);
						}
					}
					function_842ad7f5(undefined, " ^1Dev: Turned outline off for models: " + var_model_list);
				}
			}
			else
			{
				function_842ad7f5(undefined, " ^1Dev: Please provide information!: /outline type models on");
			}
		}
	}
}

/*
	Name: function_27cdc982
	Namespace: namespace_b2e35c83
	Checksum: 0x424F4353
	Offset: 0xBD18
	Size: 0x288
	Parameters: 1
	Flags: None
	Line Number: 3045
*/
function function_27cdc982(var_34d37a48)
{
	function_8b57c052("perk", "");
	for(;;)
	{
		wait(0.05);
		var_dvar_value = function_ToLower(function_GetDvarString("perk", ""));
		if(isdefined(var_dvar_value) && var_dvar_value != "")
		{
			function_8b57c052("perk", "");
			var_cde9f622 = function_StrTok(var_dvar_value, " ");
			if(var_cde9f622.size > 1)
			{
				var_player_index = function_Int(var_cde9f622[0]);
				var_perk = namespace_71d987dc::function_2f134368(var_cde9f622[1]);
				function_842ad7f5(level.var_players[var_player_index], "^5Dev: added " + var_cde9f622[1] + " perk to " + level.var_players[var_player_index].var_playerName);
				if(var_player_index >= 0 && var_player_index <= 7)
				{
					level.var_players[var_player_index] function_1b77d2aa(var_perk);
				}
				else
				{
					namespace_Array::function_thread_all(function_GetPlayers(), &function_1b77d2aa, var_perk);
				}
			}
			else
			{
				namespace_Array::function_thread_all(function_GetPlayers(), &function_1b77d2aa, namespace_71d987dc::function_2f134368(var_cde9f622[0]));
				function_842ad7f5(undefined, "^5Dev: added " + var_cde9f622[0] + " perk to all players");
			}
		}
	}
}

/*
	Name: function_1ab1ece4
	Namespace: namespace_b2e35c83
	Checksum: 0x424F4353
	Offset: 0xBFA8
	Size: 0x280
	Parameters: 1
	Flags: None
	Line Number: 3089
*/
function function_1ab1ece4(var_34d37a48)
{
	function_8b57c052("take_perk", "");
	for(;;)
	{
		wait(0.05);
		var_dvar_value = function_ToLower(function_GetDvarString("take_perk", ""));
		if(isdefined(var_dvar_value) && var_dvar_value != "")
		{
			function_8b57c052("take_perk", "");
			var_cde9f622 = function_StrTok(var_dvar_value, " ");
			if(var_cde9f622.size > 1)
			{
				var_player_index = function_Int(var_cde9f622[0]);
				var_value = var_cde9f622[1];
				var_perk = namespace_71d987dc::function_2f134368(var_value);
				function_842ad7f5(level.var_players[var_player_index], "^5Dev: taken " + var_perk + " perk from " + level.var_players[var_player_index].var_playerName);
				if(var_player_index >= 0 && var_player_index <= 7)
				{
					level.var_players[var_player_index] function_2a988850(var_perk);
				}
				else
				{
					namespace_Array::function_thread_all(function_GetPlayers(), &function_2a988850, var_perk);
				}
			}
			else
			{
				namespace_Array::function_thread_all(function_GetPlayers(), &function_2a988850, var_cde9f622[0]);
				function_842ad7f5(undefined, "^5Dev: taken " + var_cde9f622[0] + " perk from all players");
			}
		}
	}
}

/*
	Name: function_93d18f76
	Namespace: namespace_b2e35c83
	Checksum: 0x424F4353
	Offset: 0xC230
	Size: 0xF0
	Parameters: 1
	Flags: None
	Line Number: 3134
*/
function function_93d18f76(var_34d37a48)
{
	function_8b57c052("next_round", "");
	for(;;)
	{
		wait(0.05);
		var_dvar_value = function_ToLower(function_GetDvarString("next_round", ""));
		if(isdefined(var_dvar_value) && var_dvar_value != "")
		{
			function_8b57c052("next_round", "");
			thread function_2cce5cbc(level.var_round_number + 1);
			function_842ad7f5(undefined, " ^5Dev: Next round");
		}
	}
}

/*
	Name: function_f5efc0ba
	Namespace: namespace_b2e35c83
	Checksum: 0x424F4353
	Offset: 0xC328
	Size: 0xF0
	Parameters: 1
	Flags: None
	Line Number: 3160
*/
function function_f5efc0ba(var_34d37a48)
{
	function_8b57c052("previous_round", "");
	for(;;)
	{
		wait(0.05);
		var_dvar_value = function_ToLower(function_GetDvarString("previous_round", ""));
		if(isdefined(var_dvar_value) && var_dvar_value != "")
		{
			function_8b57c052("previous_round", "");
			thread function_2cce5cbc(level.var_round_number - 1);
			function_842ad7f5(undefined, " ^5Dev: Previous round");
		}
	}
}

/*
	Name: function_67752f53
	Namespace: namespace_b2e35c83
	Checksum: 0x424F4353
	Offset: 0xC420
	Size: 0x1C0
	Parameters: 1
	Flags: None
	Line Number: 3186
*/
function function_67752f53(var_34d37a48)
{
	function_8b57c052("round", "");
	for(;;)
	{
		wait(0.05);
		var_dvar_value = function_ToLower(function_GetDvarString("round", ""));
		if(isdefined(var_dvar_value) && var_dvar_value != "")
		{
			function_8b57c052("round", "");
			var_round = var_dvar_value;
			if(var_round == "next")
			{
				thread function_2cce5cbc(level.var_round_number + 1);
				function_842ad7f5(undefined, " ^5Dev: Changed round to " + var_round);
			}
			else if(var_round == "previous")
			{
				thread function_2cce5cbc(level.var_round_number - 1);
				function_842ad7f5(undefined, " ^5Dev: Changed round to " + var_round);
			}
			else
			{
				thread function_2cce5cbc(function_Int(var_round));
				function_842ad7f5(undefined, " ^5Dev: Changed round to " + var_round);
			}
		}
	}
}

/*
	Name: function_d6fe1935
	Namespace: namespace_b2e35c83
	Checksum: 0x424F4353
	Offset: 0xC5E8
	Size: 0x118
	Parameters: 1
	Flags: None
	Line Number: 3226
*/
function function_d6fe1935(var_34d37a48)
{
	function_8b57c052("doground", "");
	for(;;)
	{
		wait(0.05);
		var_dvar_value = function_ToLower(function_GetDvarString("doground", ""));
		if(isdefined(var_dvar_value) && var_dvar_value != "")
		{
			function_8b57c052("doground", "");
			switch(var_dvar_value)
			{
				case "1":
				case "activate":
				case "on":
				{
					thread function_2cce5cbc(level.var_next_dog_round);
					function_842ad7f5(undefined, " ^5Dev: Changed round to Dog Round");
					break;
				}
			}
		}
	}
}

/*
	Name: function_ee09c1b8
	Namespace: namespace_b2e35c83
	Checksum: 0x424F4353
	Offset: 0xC708
	Size: 0x5A8
	Parameters: 1
	Flags: None
	Line Number: 3261
*/
function function_ee09c1b8(var_34d37a48)
{
	function_8b57c052("powerup", "");
	for(;;)
	{
		wait(0.05);
		var_dvar_value = function_ToLower(function_GetDvarString("powerup", ""));
		if(isdefined(var_dvar_value) && var_dvar_value != "")
		{
			function_8b57c052("powerup", "");
			var_cde9f622 = function_StrTok(var_dvar_value, " ");
			if(var_cde9f622.size > 1)
			{
				var_player_index = function_Int(var_cde9f622[0]);
				var_powerup_name = var_cde9f622[1];
				var_powerup = namespace_71d987dc::function_e350ab20(var_powerup_name);
				if(var_powerup != "all")
				{
					for(var_i = 0; var_i < level.var_zombie_powerup_array.size; var_i++)
					{
						if(level.var_zombie_powerup_array[var_i] == var_powerup)
						{
							level.var_zombie_powerup_index = var_i;
							var_found = 1;
							break;
						}
					}
				}
				else
				{
					var_found = 1;
				}
				if(!var_found)
				{
					function_842ad7f5(undefined, " ^1Dev: Powerup: " + var_powerup + " does not exist!");
				}
				function_842ad7f5(level.var_players[var_player_index], " ^5Dev: Spawned " + var_powerup + " powerup to " + level.var_players[var_player_index].var_playerName);
				var_origin = level.var_players[var_player_index] function_c3ff634();
				level.var_players[var_player_index] function_a62cead3();
				level thread namespace_zm_powerups::function_specific_powerup_drop(var_powerup, var_origin, undefined, undefined, undefined, undefined, 0);
				var_origin = var_player function_c3ff634();
				var_player function_a62cead3();
				continue;
				level thread namespace_zm_powerups::function_specific_powerup_drop(var_powerup, var_origin, undefined, undefined, undefined, undefined, 0);
			}
			else
			{
				if(var_player_index >= 0 && var_player_index <= 7)
				{
					if(var_powerup == "all")
					{
					}
					else
					{
					}
				}
				else
				{
					foreach(var_player in function_GetPlayers())
					{
						if(var_powerup == "all")
						{
						}
					}
				}
				else
				{
					var_powerup = namespace_71d987dc::function_e350ab20(var_cde9f622[0]);
					if(var_powerup != "all")
					{
						for(var_i = 0; var_i < level.var_zombie_powerup_array.size; var_i++)
						{
							if(level.var_zombie_powerup_array[var_i] == var_powerup)
							{
								level.var_zombie_powerup_index = var_i;
								var_found = 1;
								break;
							}
						}
					}
					else
					{
						var_found = 1;
					}
					if(!var_found)
					{
						function_842ad7f5(undefined, " ^1Dev: Powerup: " + var_powerup + " does not exist!");
					}
					else
					{
						foreach(var_player in function_GetPlayers())
						{
							var_origin = var_player function_c3ff634();
							if(var_powerup == "all")
							{
								var_player function_a62cead3();
								continue;
							}
							level thread namespace_zm_powerups::function_specific_powerup_drop(var_powerup, var_origin, undefined, undefined, undefined, undefined, 0);
						}
						function_842ad7f5(undefined, " ^5Dev: Spawned " + var_powerup + " powerup to all players");
					}
				}
			}
		}
	}
}

/*
	Name: function_a62cead3
	Namespace: namespace_b2e35c83
	Checksum: 0x424F4353
	Offset: 0xCCB8
	Size: 0x188
	Parameters: 0
	Flags: None
	Line Number: 3379
*/
function function_a62cead3()
{
	level thread namespace_71d987dc::function_a2ccecad("minigun", self namespace_71d987dc::function_7248d053(1));
	level thread namespace_71d987dc::function_a2ccecad("nuke", self namespace_71d987dc::function_7248d053(2));
	level thread namespace_71d987dc::function_a2ccecad("carpenter", self namespace_71d987dc::function_7248d053(3));
	level thread namespace_71d987dc::function_a2ccecad("free_perk", self namespace_71d987dc::function_7248d053(4));
	level thread namespace_71d987dc::function_a2ccecad("fire_sale", self namespace_71d987dc::function_7248d053(5));
	level thread namespace_71d987dc::function_a2ccecad("insta_kill", self namespace_71d987dc::function_7248d053(6));
	level thread namespace_71d987dc::function_a2ccecad("full_ammo", self namespace_71d987dc::function_7248d053(7));
	level thread namespace_71d987dc::function_a2ccecad("double_points", self namespace_71d987dc::function_7248d053(8));
}

/*
	Name: function_7f5d1f3d
	Namespace: namespace_b2e35c83
	Checksum: 0x424F4353
	Offset: 0xCE48
	Size: 0x2E0
	Parameters: 1
	Flags: None
	Line Number: 3401
*/
function function_7f5d1f3d(var_34d37a48)
{
	function_8b57c052("upgrade_weapon", "none");
	for(;;)
	{
		wait(0.05);
		var_dvar_value = function_ToLower(function_GetDvarString("upgrade_weapon", "none"));
		if(isdefined(var_dvar_value) && var_dvar_value != "none")
		{
			function_8b57c052("upgrade_weapon", "none");
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
				function_842ad7f5(level.var_players[var_player_index], "^5Dev: upgraded weapon of " + level.var_players[var_player_index].var_playerName);
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
				function_842ad7f5(undefined, "^5Dev: upgraded weapon of all players");
			}
		}
	}
}

/*
	Name: function_9c955ddd
	Namespace: namespace_b2e35c83
	Checksum: 0x424F4353
	Offset: 0xD130
	Size: 0x170
	Parameters: 0
	Flags: None
	Line Number: 3452
*/
function function_9c955ddd()
{
	var_weap = self function_GetCurrentWeapon();
	var_weapon = namespace_zm_weapons::function_get_upgrade_weapon(var_weap, 0);
	if(isdefined(level.var_aat_in_use) && level.var_aat_in_use)
	{
		self thread namespace_AAT::function_acquire(var_weapon);
	}
	var_weapon.var_camo_index = self namespace_zm_weapons::function_get_pack_a_punch_weapon_options(var_weapon);
	self function_TakeWeapon(var_weap);
	self function_GiveWeapon(var_weapon, var_weapon.var_camo_index);
	if(self function_hasPerk("specialty_extraammo"))
	{
		self function_giveMaxAmmo(var_weapon);
	}
	else
	{
		self function_GiveStartAmmo(var_weapon);
	}
	self function_SwitchToWeapon(var_weapon);
	namespace_zm_utility::function_play_sound_at_pos("zmb_perks_packa_ready", self);
}

/*
	Name: function_d291348c
	Namespace: namespace_b2e35c83
	Checksum: 0x424F4353
	Offset: 0xD2A8
	Size: 0x268
	Parameters: 1
	Flags: None
	Line Number: 3485
*/
function function_d291348c(var_34d37a48)
{
	function_8b57c052("downgrade_weapon", "");
	for(;;)
	{
		wait(0.05);
		var_dvar_value = function_ToLower(function_GetDvarString("downgrade_weapon", ""));
		if(isdefined(var_dvar_value) && var_dvar_value != "")
		{
			function_8b57c052("downgrade_weapon", "");
			var_cde9f622 = function_StrTok(var_dvar_value, " ");
			if(var_cde9f622.size > 1)
			{
				var_player_index = function_Int(var_cde9f622[0]);
				var_value = function_Int(var_cde9f622[1]);
				function_842ad7f5(level.var_players[var_player_index], "^5Dev: Downgraded weapon of " + level.var_players[var_player_index].var_playerName);
				if(var_player_index >= 0 && var_player_index <= 7)
				{
					level.var_players[var_player_index] function_ddf02bd7();
				}
				else
				{
					namespace_Array::function_thread_all(function_GetPlayers(), &function_ddf02bd7);
				}
			}
			else
			{
				var_value = function_Int(var_cde9f622[0]);
				namespace_Array::function_thread_all(function_GetPlayers(), &function_ddf02bd7);
				function_842ad7f5(undefined, " ^5Dev: Downgraded all players' weapon");
			}
		}
	}
}

/*
	Name: function_b7729c82
	Namespace: namespace_b2e35c83
	Checksum: 0x424F4353
	Offset: 0xD518
	Size: 0xE0
	Parameters: 1
	Flags: None
	Line Number: 3530
*/
function function_b7729c82(var_34d37a48)
{
	function_8b57c052("open", "");
	for(;;)
	{
		wait(0.05);
		var_dvar_value = function_ToLower(function_GetDvarString("open", ""));
		if(isdefined(var_dvar_value) && var_dvar_value != "")
		{
			function_8b57c052("open", "");
			thread function_f247d197();
			function_842ad7f5(undefined, " ^5Dev: Opened all " + var_dvar_value);
		}
	}
}

/*
	Name: function_f247d197
	Namespace: namespace_b2e35c83
	Checksum: 0x424F4353
	Offset: 0xD600
	Size: 0x448
	Parameters: 0
	Flags: None
	Line Number: 3556
*/
function function_f247d197()
{
	function_SetDvar("zombie_unlock_all", 1);
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
	for(var_i = 0; var_i < var_zombie_doors.size; var_i++)
	{
		var_zombie_doors[var_i] notify("hash_trigger", level.var_players[0]);
		if(isdefined(var_zombie_doors[var_i].var_power_door_ignore_flag_wait) && var_zombie_doors[var_i].var_power_door_ignore_flag_wait)
		{
			var_zombie_doors[var_i] notify("hash_power_on");
		}
		wait(0.05);
	}
	var_zombie_airlock_doors = function_GetEntArray("zombie_airlock_buy", "targetname");
	for(var_i = 0; var_i < var_zombie_airlock_doors.size; var_i++)
	{
		var_zombie_airlock_doors[var_i] notify("hash_trigger", level.var_players[0]);
		wait(0.05);
	}
	var_zombie_debris = function_GetEntArray("zombie_debris", "targetname");
	for(var_i = 0; var_i < var_zombie_debris.size; var_i++)
	{
		if(isdefined(var_zombie_debris[var_i]))
		{
			var_zombie_debris[var_i] notify("hash_trigger", level.var_players[0]);
		}
		wait(0.05);
	}
	foreach(var_uts_craftable in level.var_a_uts_craftables)
	{
		var_player = function_GetPlayers()[0];
		var_player namespace_zm_craftables::function_player_finish_craftable(var_uts_craftable.var_craftableSpawn);
		if(isdefined(var_uts_craftable.var_craftableStub.var_onFullyCrafted))
		{
			var_uts_craftable [[var_uts_craftable.var_craftableStub.var_onFullyCrafted]]();
		}
	}
	level notify("hash_open_sesame");
	wait(1);
	function_SetDvar("zombie_unlock_all", 0);
}

/*
	Name: function_b5d953ca
	Namespace: namespace_b2e35c83
	Checksum: 0x424F4353
	Offset: 0xDA50
	Size: 0x2A0
	Parameters: 1
	Flags: None
	Line Number: 3619
*/
function function_b5d953ca(var_34d37a48)
{
	var_origin = var_34d37a48["player"] function_31565f46();
	var_248bbf85 = [];
	if(isdefined(function_GetEntArray("zombie_debris", "targetname")[0]) || isdefined(function_GetEntArray("zombie_door", "targetname")[0]) || isdefined(function_GetEntArray("zombie_airlock_buy", "targetname")[0]))
	{
		var_potential_targets = [];
		if(function_GetEntArray("zombie_door", "targetname").size > 0)
		{
			var_potential_targets = function_ArrayCombine(var_potential_targets, function_GetEntArray("zombie_door", "targetname"), 0, 0);
		}
		if(function_GetEntArray("zombie_debris", "targetname").size > 0)
		{
			var_potential_targets = function_ArrayCombine(var_potential_targets, function_GetEntArray("zombie_debris", "targetname"), 0, 0);
		}
		if(function_GetEntArray("zombie_airlock_buy", "targetname").size > 0)
		{
			var_potential_targets = function_ArrayCombine(var_potential_targets, function_GetEntArray("zombie_airlock_buy", "targetname"), 0, 0);
		}
		wait(0.05);
		var_6f45c771 = function_ArraySortClosest(var_potential_targets, var_origin);
		wait(0.05);
		var_6f45c771[0] notify("hash_trigger", level.var_players[0]);
		if(isdefined(var_6f45c771[0].var_power_door_ignore_flag_wait) && var_6f45c771[0].var_power_door_ignore_flag_wait)
		{
			var_6f45c771[0] notify("hash_power_on");
		}
	}
}

/*
	Name: function_31565f46
	Namespace: namespace_b2e35c83
	Checksum: 0x424F4353
	Offset: 0xDCF8
	Size: 0x220
	Parameters: 0
	Flags: None
	Line Number: 3659
*/
function function_31565f46()
{
	wait(0.05);
	var_start = self function_GetWeaponMuzzlePoint();
	var_forward_dir = self function_GetWeaponForwardDir();
	var_end = var_start + var_forward_dir * 5000;
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
		return var_trace["position"];
	}
}

/*
	Name: function_f23059d1
	Namespace: namespace_b2e35c83
	Checksum: 0x424F4353
	Offset: 0xDF20
	Size: 0x1B8
	Parameters: 0
	Flags: None
	Line Number: 3691
*/
function function_f23059d1()
{
	function_8b57c052("difficulty", "");
	for(;;)
	{
		wait(0.05);
		var_dvar_value = function_ToLower(function_GetDvarString("difficulty", ""));
		if(isdefined(var_dvar_value) && var_dvar_value != "")
		{
			function_8b57c052("difficulty", "");
			var_b98e93fb = function_Int(var_dvar_value);
			switch(var_b98e93fb)
			{
				case 1:
				{
					thread function_22ac2766(1, 24, 8);
					break;
				}
				case 2:
				{
					thread function_22ac2766(5, 48, 500);
					break;
				}
				case 3:
				{
					thread function_22ac2766(50, 64, 2500);
					break;
				}
				case 4:
				{
					thread function_22ac2766(100, 64, 3500);
					break;
				}
			}
			thread function_2cce5cbc(level.var_round_number);
			function_842ad7f5(undefined, " ^5Dev: Changed difficulty to " + var_b98e93fb);
		}
	}
}

/*
	Name: function_22ac2766
	Namespace: namespace_b2e35c83
	Checksum: 0x424F4353
	Offset: 0xE0E0
	Size: 0x80
	Parameters: 3
	Flags: None
	Line Number: 3741
*/
function function_22ac2766(var_multiplier, var_87c4fb18, var_DOG_HEALTH)
{
	namespace_zombie_utility::function_set_zombie_var("zombie_move_speed_multiplier", var_multiplier, 0);
	namespace_zombie_utility::function_set_zombie_var("zombie_move_speed_multiplier_easy", var_multiplier, 0);
	level.var_zombie_actor_limit = var_87c4fb18;
	level.var_zombie_ai_limit = var_87c4fb18;
	level.var_DOG_HEALTH = var_DOG_HEALTH;
}

/*
	Name: function_9f54f1b9
	Namespace: namespace_b2e35c83
	Checksum: 0x424F4353
	Offset: 0xE168
	Size: 0x2D8
	Parameters: 1
	Flags: None
	Line Number: 3760
*/
function function_9f54f1b9(var_34d37a48)
{
	function_8b57c052("notify", "");
	for(;;)
	{
		wait(0.05);
		var_dvar_value = function_ToLower(function_GetDvarString("notify", ""));
		if(isdefined(var_dvar_value) && var_dvar_value != "")
		{
			function_8b57c052("notify", "");
			var_cde9f622 = function_StrTok(var_dvar_value, " ");
			if(var_cde9f622.size > 1)
			{
				var_target = function_Int(var_cde9f622[0]);
				var_value = function_Int(var_cde9f622[1]);
				if(var_cde9f622.size > 2)
				{
					var_value2 = function_Int(var_cde9f622[2]);
					foreach(var_targ in function_GetEntArray(var_target, "targetname"))
					{
						var_targ notify(var_value, var_value2);
					}
				}
				else
				{
					foreach(var_targ in function_GetEntArray(var_target, "targetname"))
					{
						var_targ notify(var_value);
					}
				}
			}
			else
			{
				var_value = function_Int(var_cde9f622[0]);
				level notify(var_value);
			}
			function_842ad7f5(undefined, " ^1Dev: Turned spawning off");
		}
	}
}

/*
	Name: function_b2ec648e
	Namespace: namespace_b2e35c83
	Checksum: 0x424F4353
	Offset: 0xE448
	Size: 0x230
	Parameters: 1
	Flags: None
	Line Number: 3811
*/
function function_b2ec648e(var_34d37a48)
{
	function_8b57c052("flag", "");
	for(;;)
	{
		wait(0.05);
		var_dvar_value = function_ToLower(function_GetDvarString("flag", ""));
		if(isdefined(var_dvar_value) && var_dvar_value != "")
		{
			function_8b57c052("flag", "");
			var_cde9f622 = function_StrTok(var_dvar_value, " ");
			if(var_cde9f622.size > 1)
			{
				var_target = var_cde9f622[0];
				var_value = var_cde9f622[1];
				foreach(var_targ in function_GetEntArray(var_target, "targetname"))
				{
					var_targ namespace_flag::function_set(var_value);
				}
				function_842ad7f5(undefined, " ^1Dev: Turned flag: " + var_value + " On");
			}
			else
			{
				level namespace_flag::function_set(var_dvar_value);
				function_842ad7f5(undefined, " ^1Dev: Turned flag: " + var_dvar_value + " On");
			}
		}
	}
}

/*
	Name: function_e71fb16c
	Namespace: namespace_b2e35c83
	Checksum: 0x424F4353
	Offset: 0xE680
	Size: 0x230
	Parameters: 1
	Flags: None
	Line Number: 3851
*/
function function_e71fb16c(var_34d37a48)
{
	function_8b57c052("flag_clear", "");
	for(;;)
	{
		wait(0.05);
		var_dvar_value = function_ToLower(function_GetDvarString("flag_clear", ""));
		if(isdefined(var_dvar_value) && var_dvar_value != "")
		{
			function_8b57c052("flag_clear", "");
			var_cde9f622 = function_StrTok(var_dvar_value, " ");
			if(var_cde9f622.size > 1)
			{
				var_target = var_cde9f622[0];
				var_value = var_cde9f622[1];
				foreach(var_targ in function_GetEntArray(var_target, "targetname"))
				{
					var_targ namespace_flag::function_clear(var_value);
				}
				function_842ad7f5(undefined, " ^1Dev: Turned flag: " + var_value + " Off");
			}
			else
			{
				level namespace_flag::function_clear(var_dvar_value);
				function_842ad7f5(undefined, " ^1Dev: Turned flag: " + var_dvar_value + " Off");
			}
		}
	}
}

/*
	Name: function_fe46f128
	Namespace: namespace_b2e35c83
	Checksum: 0x424F4353
	Offset: 0xE8B8
	Size: 0x238
	Parameters: 1
	Flags: None
	Line Number: 3891
*/
function function_fe46f128(var_34d37a48)
{
	function_8b57c052("play", "");
	for(;;)
	{
		wait(0.05);
		var_dvar_value = function_ToLower(function_GetDvarString("play", ""));
		if(isdefined(var_dvar_value) && var_dvar_value != "")
		{
			function_8b57c052("play", "");
			var_alias = var_dvar_value;
			var_time = function_soundgetplaybacktime(var_alias) * 0.001;
			foreach(var_player in function_GetPlayers())
			{
				var_player function_playsoundtoplayer(var_alias, var_player);
			}
			wait(var_time);
			foreach(var_player in function_GetPlayers())
			{
				var_player function_stopsounds();
			}
			function_842ad7f5(undefined, " ^1Dev: Played sound: " + var_alias);
		}
	}
}

/*
	Name: function_75fbf4d7
	Namespace: namespace_b2e35c83
	Checksum: 0x424F4353
	Offset: 0xEAF8
	Size: 0x318
	Parameters: 1
	Flags: None
	Line Number: 3927
*/
function function_75fbf4d7(var_34d37a48)
{
	function_8b57c052("stop", "");
	for(;;)
	{
		wait(0.05);
		var_dvar_value = function_ToLower(function_GetDvarString("stop", ""));
		if(isdefined(var_dvar_value) && var_dvar_value != "")
		{
			function_8b57c052("stop", "");
			var_cde9f622 = function_StrTok(var_dvar_value, " ");
			if(var_cde9f622.size > 1)
			{
				var_player_index = function_Int(var_cde9f622[0]);
				var_value = function_Int(var_cde9f622[1]);
				function_842ad7f5(level.var_players[var_player_index], "^5Dev: Stopped all sounds from playing on player: " + level.var_players[var_player_index].var_playerName);
				if(var_player_index >= 0 && var_player_index <= 7)
				{
					level.var_players[var_player_index] function_stopsounds();
				}
				else
				{
					foreach(var_player in function_GetPlayers())
					{
						var_player function_stopsounds();
					}
				}
			}
			else
			{
				var_value = function_Int(var_cde9f622[0]);
				foreach(var_player in function_GetPlayers())
				{
					var_player function_stopsounds();
				}
				function_842ad7f5(undefined, " ^5Dev: Stopped all sounds from playing for all players");
			}
		}
	}
}

/*
	Name: function_6ccccad6
	Namespace: namespace_b2e35c83
	Checksum: 0x424F4353
	Offset: 0xEE18
	Size: 0x608
	Parameters: 0
	Flags: None
	Line Number: 3978
*/
function function_6ccccad6()
{
	function_8b57c052("aimbot", "");
	for(;;)
	{
		wait(0.05);
		var_dvar_value = function_ToLower(function_GetDvarString("aimbot", ""));
		if(isdefined(var_dvar_value) && var_dvar_value != "")
		{
			function_8b57c052("aimbot", "");
			var_cde9f622 = function_StrTok(var_dvar_value, " ");
			if(var_cde9f622.size > 1)
			{
				var_player_index = function_Int(var_cde9f622[0]);
				var_value = function_Int(var_cde9f622[1]);
				if(var_dvar_value == "on" || var_dvar_value == "activate" || var_dvar_value == "1")
				{
					if(var_player_index >= 0 && var_player_index <= 7)
					{
						level.var_players[var_player_index] thread function_95700477(1);
					}
					else
					{
						foreach(var_e_player in function_GetPlayers())
						{
							var_e_player thread function_95700477(1);
						}
					}
					function_842ad7f5(level.var_players[var_player_index], "^5Dev: Activated aimbot to " + level.var_players[var_player_index].var_playerName);
				}
				else if(var_dvar_value == "off" || var_dvar_value == "deactivate" || var_dvar_value == "0")
				{
					if(var_player_index >= 0 && var_player_index <= 7)
					{
						level.var_players[var_player_index] thread function_95700477(0);
					}
					else
					{
						foreach(var_e_player in function_GetPlayers())
						{
							var_e_player thread function_95700477(0);
						}
					}
					function_842ad7f5(level.var_players[var_player_index], "^5Dev: Deactivated aimbot to " + level.var_players[var_player_index].var_playerName);
				}
			}
			else
			{
				var_value = function_Int(var_cde9f622[0]);
				if(var_dvar_value == "on" || var_dvar_value == "activate" || var_dvar_value == "1")
				{
					foreach(var_e_player in function_GetPlayers())
					{
						var_e_player thread function_95700477(1);
					}
					function_842ad7f5(level.var_players[var_player_index], "^5Dev: Activated aimbot to " + level.var_players[var_player_index].var_playerName);
				}
				else if(var_dvar_value == "off" || var_dvar_value == "deactivate" || var_dvar_value == "0")
				{
					foreach(var_e_player in function_GetPlayers())
					{
						var_e_player thread function_95700477(0);
					}
					function_842ad7f5(level.var_players[var_player_index], "^5Dev: Deactivated aimbot to " + level.var_players[var_player_index].var_playerName);
				}
				function_842ad7f5(undefined, "^5Dev: Activated aimbot to all players");
			}
		}
	}
}

/*
	Name: function_95700477
	Namespace: namespace_b2e35c83
	Checksum: 0x424F4353
	Offset: 0xF428
	Size: 0x250
	Parameters: 1
	Flags: None
	Line Number: 4059
*/
function function_95700477(var_activate)
{
	self notify("stop_aimbot" + self function_GetEntityNumber() + 1);
	self endon("stop_aimbot" + self function_GetEntityNumber() + 1);
	if(isdefined(var_activate) && var_activate)
	{
		while(self function_PlayerAds() >= 0.3)
		{
			var_30f6d9cd = function_Array();
			foreach(var_enemy in function_GetAITeamArray(level.var_zombie_team))
			{
				if(var_enemy function_cansee(self))
				{
					if(!isdefined(var_30f6d9cd))
					{
						var_30f6d9cd = [];
					}
					else if(!function_IsArray(var_30f6d9cd))
					{
						var_30f6d9cd = function_Array(var_30f6d9cd);
					}
					var_30f6d9cd[var_30f6d9cd.size] = var_enemy;
				}
			}
			var_619885ab = function_ArrayGetClosest(self.var_origin, var_30f6d9cd);
			self function_SetPlayerAngles(function_VectorToAngles(var_619885ab function_GetTagOrigin("j_head") - self function_GetEye()));
			wait(0.05);
			continue;
			wait(0.05);
		}
	}
	self notify("hash_89411d46");
}

/*
	Name: function_ddf02bd7
	Namespace: namespace_b2e35c83
	Checksum: 0x424F4353
	Offset: 0xF680
	Size: 0xE0
	Parameters: 0
	Flags: None
	Line Number: 4103
*/
function function_ddf02bd7()
{
	var_weap = self function_GetCurrentWeapon();
	var_weapon = namespace_zm_weapons::function_get_base_weapon(var_weap);
	self function_TakeWeapon(var_weap);
	self function_GiveWeapon(var_weapon, self namespace_zm_weapons::function_get_pack_a_punch_weapon_options(var_weapon));
	self function_GiveStartAmmo(var_weapon);
	self function_SwitchToWeapon(var_weapon);
	namespace_zm_utility::function_play_sound_at_pos("zmb_perks_packa_ready", self);
}

/*
	Name: function_c3ff634
	Namespace: namespace_b2e35c83
	Checksum: 0x424F4353
	Offset: 0xF768
	Size: 0x100
	Parameters: 0
	Flags: None
	Line Number: 4124
*/
function function_c3ff634()
{
	var_direction = self function_getPlayerAngles();
	var_direction_vec = function_AnglesToForward(var_direction);
	var_eye = self function_GetEye();
	var_scale = 8000;
	var_direction_vec = (var_direction_vec[0] * var_scale, var_direction_vec[1] * var_scale, var_direction_vec[2] * var_scale);
	var_trace = function_bullettrace(var_eye, var_eye + var_direction_vec, 0, undefined);
	var_final_pos = var_trace["position"];
	return var_final_pos;
}

/*
	Name: function_2cce5cbc
	Namespace: namespace_b2e35c83
	Checksum: 0x424F4353
	Offset: 0xF870
	Size: 0x210
	Parameters: 1
	Flags: None
	Line Number: 4146
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
}

/*
	Name: function_1b77d2aa
	Namespace: namespace_b2e35c83
	Checksum: 0x424F4353
	Offset: 0xFA88
	Size: 0x250
	Parameters: 1
	Flags: None
	Line Number: 4200
*/
function function_1b77d2aa(var_perk)
{
	var_vending_triggers = function_GetEntArray("zombie_vending", "targetname");
	if(var_vending_triggers.size < 1)
	{
		function_842ad7f5(self, " ^1Dev: No perk machines found in map");
		return;
	}
	if(var_perk == "all")
	{
		foreach(var_3a51e779 in function_getArrayKeys(level.var__custom_perks))
		{
			self namespace_zm_perks::function_give_perk(var_3a51e779, 0);
			wait(0.5);
		}
	}
	else if(function_StrEndsWith(var_perk, ";"))
	{
		var_cde9f622 = function_StrTok(var_perk, " ");
		for(var_i = 0; var_i < var_cde9f622.size; var_i++)
		{
			self namespace_zm_perks::function_give_perk(var_cde9f622[var_i], 0);
		}
	}
	else if(function_StrIsInt(var_perk))
	{
		var_perk = function_Int(var_perk);
		for(var_i = 0; var_i < var_perk; var_i++)
		{
			self namespace_zm_perks::function_give_random_perk();
		}
	}
	else
	{
		self namespace_zm_perks::function_give_perk(var_perk, 0);
	}
}

/*
	Name: function_2a988850
	Namespace: namespace_b2e35c83
	Checksum: 0x424F4353
	Offset: 0xFCE0
	Size: 0x190
	Parameters: 1
	Flags: None
	Line Number: 4248
*/
function function_2a988850(var_perk)
{
	if(self.var_perks_active.size < 1)
	{
		function_842ad7f5(self, " ^1Dev: Player has no active perks");
		return;
	}
	var_PERKS = self.var_perks_active;
	if(var_perk == "all")
	{
		foreach(var_3a51e779 in var_PERKS)
		{
			self function_c65ada05(var_3a51e779);
			wait(1);
		}
	}
	else if(function_StrIsInt(var_perk))
	{
		var_perk = function_Int(var_perk);
		for(var_i = 0; var_i < var_perk; var_i++)
		{
			self namespace_zm_perks::function_lose_random_perk();
			wait(1);
		}
	}
	else
	{
		self function_c65ada05(var_perk);
		return;
	}
	ERROR: Exception occured: Stack empty.
}

/*
	Name: function_842ad7f5
	Namespace: namespace_b2e35c83
	Checksum: 0x424F4353
	Offset: 0xFE78
	Size: 0xF0
	Parameters: 2
	Flags: None
	Line Number: 4291
*/
function function_842ad7f5(var_player, var_message)
{
	if(isdefined(var_player))
	{
		var_player namespace_util::function_setClientSysState("subtitleMessage", var_message, var_player);
	}
	else
	{
		foreach(var_2d4cbd56 in function_GetPlayers())
		{
			var_2d4cbd56 namespace_util::function_setClientSysState("subtitleMessage", var_message, var_2d4cbd56);
		}
	}
}

/*
	Name: function_c65ada05
	Namespace: namespace_b2e35c83
	Checksum: 0x424F4353
	Offset: 0xFF70
	Size: 0x60
	Parameters: 1
	Flags: None
	Line Number: 4316
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
	Namespace: namespace_b2e35c83
	Checksum: 0x424F4353
	Offset: 0xFFD8
	Size: 0x90
	Parameters: 0
	Flags: None
	Line Number: 4336
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
	Name: function_957b7937
	Namespace: namespace_b2e35c83
	Checksum: 0x424F4353
	Offset: 0x10070
	Size: 0xC0
	Parameters: 1
	Flags: None
	Line Number: 4362
*/
function function_957b7937(var_message)
{
	if(!isdefined(var_message))
	{
		var_message = "No Message";
	}
	if(!level namespace_flag::function_get("full_silent_dev"))
	{
		if(level namespace_flag::function_get("silent_dev"))
		{
			level.var_players[0] function_iprintln("^8[DEV Command]^7 " + var_message);
		}
		else
		{
			function_iprintln("^8[DEV Command]^7 " + var_message);
		}
	}
}

/*
	Name: function_3e6a0452
	Namespace: namespace_b2e35c83
	Checksum: 0x424F4353
	Offset: 0x10138
	Size: 0x2D0
	Parameters: 3
	Flags: None
	Line Number: 4391
*/
function function_3e6a0452(var_player, var_type, var_7f36bdb9)
{
	if(!isdefined(var_7f36bdb9))
	{
		var_7f36bdb9 = 0;
	}
	if(!isdefined(level.var_15954023.var_weapons))
	{
		level.var_15954023.var_weapons = [];
	}
	if(!isdefined(level.var_15954023.var_weapons[var_player.var_6aa7a7c0]))
	{
		return;
	}
	var_weapon = level.var_15954023.var_weapons[var_player.var_6aa7a7c0][1];
	switch(var_type)
	{
		case "Normal":
		{
			var_weapon = level.var_15954023.var_weapons[var_player.var_6aa7a7c0][1];
			break;
		}
		case "Upgraded":
		{
			var_weapon = level.var_15954023.var_weapons[var_player.var_6aa7a7c0][2];
			break;
		}
		default
		{
			var_player function_TakeWeapon(level.var_15954023.var_weapons[var_player.var_6aa7a7c0][1]);
			var_player function_TakeWeapon(level.var_15954023.var_weapons[var_player.var_6aa7a7c0][2]);
			if(!var_7f36bdb9)
			{
				self function_IPrintLnBold("Sword Updated");
				return;
			}
		}
	}
	var_player.var_sword_power = 1;
	var_player notify("hash_2089e51");
	if(isdefined(var_player.var_c0d25105))
	{
		var_player.var_c0d25105 notify("hash_returned_to_owner");
	}
	var_player.var_86a785ad = 1;
	var_player notify("hash_2089e51");
	var_player namespace_zm_weapons::function_weapon_give(var_weapon, 0, 0, 1);
	var_player function_GadgetPowerSet(0, 100);
	var_player.var_current_sword = var_player.var_current_hero_weapon;
	if(!var_7f36bdb9)
	{
		self function_IPrintLnBold("Sword Updated");
	}
}

/*
	Name: function_68126c27
	Namespace: namespace_b2e35c83
	Checksum: 0x424F4353
	Offset: 0x10410
	Size: 0x19A
	Parameters: 0
	Flags: None
	Line Number: 4456
*/
function function_68126c27()
{
	level namespace_flag::function_set("ee_boss_defeated");
	level notify("hash_e0eab469");
	level notify("hash_83bb0170");
	if(isdefined(level.var_dbc3a0ef) && isdefined(level.var_dbc3a0ef.var_93dad597))
	{
		level.var_dbc3a0ef.var_93dad597 function_delete();
	}
	foreach(var_person in function_Array("boxer", "detective", "femme", "magician"))
	{
		if(isdefined(level.var_f86952c7["boss_1_" + var_person]))
		{
			namespace_zm_unitrigger::function_unregister_unitrigger(level.var_f86952c7["boss_1_" + var_person]);
		}
		level namespace_clientfield::function_set("ee_keeper_" + var_person + "_state", 7);
		wait(0.1);
	}
}

