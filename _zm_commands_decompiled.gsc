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
	Name: __init__sytem__
	Namespace: namespace_b2e35c83
	Checksum: 0x424F4353
	Offset: 0x21D0
	Size: 0x38
	Parameters: 0
	Flags: AutoExec
	Line Number: 63
*/
function autoexec __init__sytem__()
{
	system::register("zm_commandsgui", &__init__, undefined, undefined);
	return;
}

/*
	Name: __init__
	Namespace: namespace_b2e35c83
	Checksum: 0x424F4353
	Offset: 0x2210
	Size: 0x428
	Parameters: 0
	Flags: None
	Line Number: 79
*/
function __init__()
{
	if(!isdefined(level.var_84ec6897))
	{
		level.var_84ec6897 = [];
	}
	if(tolower(getdvarstring("mapname")) != "zm_castle")
	{
		clientfield::register("scriptmover", "debug_enable_keyline", 1, 1, "int");
		clientfield::register("actor", "debug_zombie_enable_keyline", 1, 1, "int");
	}
	function_8b57c052("versionCommands", "V2.00 - By Sphynx");
	if(!(isdefined(1) && 1))
	{
	}
	else
	{
		level flag::init("dev_console_commands");
		level flag::init("debug_dev");
		level flag::init("silent_dev");
		level flag::init("full_silent_dev");
		function_45e81b43();
		while(!level flag::get("dev_console_commands"))
		{
			wait(1);
		}
		setdvar("sv_cheats", 1);
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
		if(tolower(getdvarstring("mapname")) != "zm_castle")
		{
			thread function_1a6da99d();
			thread function_109891a9();
		}
		thread function_6ccccad6();
		return;
	}
	ERROR: Exception occured: Stack empty.
}

/*
	Name: function_45e81b43
	Namespace: namespace_b2e35c83
	Checksum: 0x424F4353
	Offset: 0x2640
	Size: 0x658
	Parameters: 0
	Flags: Private
	Line Number: 159
*/
function function_45e81b43()
{
System.InvalidOperationException: Stack empty.
   at System.ThrowHelper.ThrowInvalidOperationException(ExceptionResource resource)
   at System.Collections.Generic.Stack`1.Pop()
   at Cerberus.Logic.Decompiler.BuildCondition(Int32 startIndex)
   at Cerberus.Logic.Decompiler.FindIfStatements()
   at Cerberus.Logic.Decompiler..ctor(ScriptExport function, ScriptBase script)
}

/*
	Name: function_a4869edc
	Namespace: namespace_b2e35c83
	Checksum: 0x424F4353
	Offset: 0x2CA0
	Size: 0x340
	Parameters: 9
	Flags: None
	Line Number: 179
*/
function function_a4869edc(var_922b7f26, var_d3065b84, description, var_c9ec11af, var_4c3eedfa, var_16315f65, var_42c6f438, var_a09ced63, var_a515af13)
{
	if(!isdefined(var_c9ec11af))
	{
		var_c9ec11af = &function_1f8331d;
	}
	if(!isdefined(var_a515af13))
	{
		var_a515af13 = 0;
	}
	/#
		Assert(isdefined(var_922b7f26), "Dev Block strings are not supported");
	#/
	/#
		Assert(isdefined(var_d3065b84), "Dev Block strings are not supported");
	#/
	/#
		Assert(!isdefined(level.var_84ec6897[var_922b7f26]), "Dev Block strings are not supported" + var_922b7f26 + "Dev Block strings are not supported");
	#/
	level.var_84ec6897[var_922b7f26] = spawnstruct();
	level.var_84ec6897[var_922b7f26].name = var_922b7f26;
	level.var_84ec6897[var_922b7f26].dvar = var_d3065b84;
	level.var_84ec6897[var_922b7f26].description = description;
	level.var_84ec6897[var_922b7f26].var_16315f65 = var_16315f65;
	level.var_84ec6897[var_922b7f26].var_c9ec11af = var_c9ec11af;
	level.var_84ec6897[var_922b7f26].var_4c3eedfa = var_4c3eedfa;
	level.var_84ec6897[var_922b7f26].active = 1;
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
	return;
	ERROR: Exception occured: Stack empty.
}

/*
	Name: function_f7005ce0
	Namespace: namespace_b2e35c83
	Checksum: 0x424F4353
	Offset: 0x2FE8
	Size: 0x268
	Parameters: 2
	Flags: None
	Line Number: 253
*/
function function_f7005ce0(var_922b7f26, var_d3065b84)
{
	function_8b57c052(var_d3065b84, "");
	for(;;)
	{
		wait(0.05);
		if(isdefined(self.active) && self.active)
		{
			dvar_value = tolower(getdvarstring(var_d3065b84, ""));
			if(isdefined(dvar_value) && dvar_value != "")
			{
				function_8b57c052(var_d3065b84, "");
				if(isdefined(self.description) && (dvar_value == "description" || dvar_value == "desc"))
				{
					function_957b7937(self.description);
				}
				else
				{
					var_34d37a48 = [];
					var_34d37a48["command"] = self;
					var_34d37a48["value"] = [];
					var_34d37a48["value"][0] = dvar_value;
					var_34d37a48["player"] = level.players[0];
					var_cde9f622 = strtok(dvar_value, " ");
					if(var_cde9f622.size > 1)
					{
						value = var_cde9f622[0];
						var_34d37a48["value"][0] = value;
						for(i = 1; i < var_cde9f622.size; i++)
						{
							var_34d37a48["value"][i] = var_cde9f622[i];
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
	Offset: 0x3258
	Size: 0x308
	Parameters: 2
	Flags: None
	Line Number: 310
*/
function function_84a1aa7e(var_922b7f26, var_d3065b84)
{
	function_8b57c052(var_d3065b84, "");
	for(;;)
	{
		wait(0.05);
		if(isdefined(self.active) && self.active)
		{
			dvar_value = tolower(getdvarstring(var_d3065b84, ""));
			if(isdefined(dvar_value) && dvar_value != "")
			{
				function_8b57c052(var_d3065b84, "");
				if(isdefined(self.description) && (dvar_value == "description" || dvar_value == "desc"))
				{
					function_957b7937(self.description);
				}
				else
				{
					var_34d37a48 = [];
					var_34d37a48["command"] = self;
					var_34d37a48["value"] = [];
					var_34d37a48["value"][0] = dvar_value;
					var_34d37a48["player"] = level.players[0];
					var_cde9f622 = strtok(dvar_value, " ");
					if(var_cde9f622.size > 1)
					{
						value = var_cde9f622[0];
						var_34d37a48["value"][0] = value;
						for(i = 1; i < var_cde9f622.size; i++)
						{
							var_34d37a48["value"][i] = var_cde9f622[i];
						}
					}
					else if(array::contains(self.var_42c6f438, dvar_value) || !isdefined(self.var_42c6f438))
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
					else if(array::contains(self.var_a09ced63, dvar_value) || !isdefined(self.var_a09ced63))
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
	Offset: 0x3568
	Size: 0x418
	Parameters: 2
	Flags: None
	Line Number: 381
*/
function function_9ad59eab(var_922b7f26, var_d3065b84)
{
	function_8b57c052(var_d3065b84, "");
	for(;;)
	{
		wait(0.05);
		if(isdefined(self.active) && self.active)
		{
			dvar_value = tolower(getdvarstring(var_d3065b84, ""));
			if(isdefined(dvar_value) && dvar_value != "")
			{
				function_8b57c052(var_d3065b84, "");
				if(isdefined(self.description) && (dvar_value == "description" || dvar_value == "desc"))
				{
					function_957b7937(self.description);
				}
				else
				{
					var_34d37a48 = [];
					var_34d37a48["command"] = self;
					var_34d37a48["value"] = [];
					var_34d37a48["value"][0] = dvar_value;
					var_34d37a48["player"] = level.players[0];
					var_cde9f622 = strtok(dvar_value, " ");
					if(var_cde9f622.size > 1)
					{
						if(var_cde9f622.size > 2)
						{
							player_index = int(var_cde9f622[0]);
							var_34d37a48["player"] = level.players[player_index];
							var_34d37a48["value"][0] = var_cde9f622[0];
							for(i = 0; i < var_cde9f622.size; i++)
							{
								var_34d37a48["value"][i] = var_cde9f622[i];
							}
						}
						else
						{
							player_index = int(var_cde9f622[0]);
							var_34d37a48["player"] = level.players[player_index];
						}
						if(player_index >= 0 && player_index <= 7)
						{
							if(isdefined(self.var_c9ec11af))
							{
								level.players[player_index] thread [[self.var_c9ec11af]](var_34d37a48);
							}
							else
							{
								function_957b7937("Dev Command has no function. Please provide one in the script");
							}
						}
						else if(isdefined(self.var_c9ec11af))
						{
							for(i = 0; i < level.players.size; i++)
							{
								var_34d37a48["player"] = level.players[i];
								level.players[i] thread [[self.var_c9ec11af]](var_34d37a48);
							}
						}
						else
						{
							function_957b7937("Dev Command has no function. Please provide one in the script");
						}
					}
					else if(isdefined(self.var_c9ec11af))
					{
						for(i = 0; i < level.players.size; i++)
						{
							var_34d37a48["player"] = level.players[i];
							level.players[i] thread [[self.var_c9ec11af]](var_34d37a48);
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
	Offset: 0x3988
	Size: 0xC0
	Parameters: 1
	Flags: None
	Line Number: 474
*/
function function_1f8331d(var_34d37a48)
{
	for(i = 0; i < var_34d37a48["value"].size; i++)
	{
		function_957b7937("Value of " + i + ": " + var_34d37a48["value"][i]);
	}
	function_957b7937("Command " + var_34d37a48["command"].name + " : No function pointer has been set");
}

/*
	Name: function_280d6e2c
	Namespace: namespace_b2e35c83
	Checksum: 0x424F4353
	Offset: 0x3A50
	Size: 0x130
	Parameters: 1
	Flags: None
	Line Number: 493
*/
function function_280d6e2c(var_34d37a48)
{
	switch(var_34d37a48["value"][0])
	{
		case "jh4sd32xd12xxd9":
		{
			level flag::set("dev_console_commands");
			foreach(command in level.var_84ec6897)
			{
				level.var_84ec6897[command.name].active = 1;
			}
			function_957b7937("Developer Commands Turned ^8On");
			break;
		}
		default
		{
			function_957b7937("Incorrect Password");
		}
	}
}

/*
	Name: function_cc7982f7
	Namespace: namespace_b2e35c83
	Checksum: 0x424F4353
	Offset: 0x3B88
	Size: 0xE0
	Parameters: 1
	Flags: None
	Line Number: 524
*/
function function_cc7982f7(var_34d37a48)
{
	level flag::clear("dev_console_commands");
	foreach(command in level.var_84ec6897)
	{
		level.var_84ec6897[command.name].active = 0;
	}
	function_957b7937("Developer Commands Turned ^9Off");
	return;
}

/*
	Name: function_3c1478a0
	Namespace: namespace_b2e35c83
	Checksum: 0x424F4353
	Offset: 0x3C70
	Size: 0x100
	Parameters: 1
	Flags: None
	Line Number: 545
*/
function function_3c1478a0(var_34d37a48)
{
	if(level.var_84ec6897[var_34d37a48["value"][0]].active == 0)
	{
		function_957b7937("Turned Command: " + var_34d37a48["value"][0] + " ^8On");
		level.var_84ec6897[var_34d37a48["value"][0]].active = 1;
	}
	else
	{
		function_957b7937("Turned Command: " + var_34d37a48["value"][0] + " ^9Off");
		level.var_84ec6897[var_34d37a48["value"][0]].active = 0;
	}
}

/*
	Name: function_83b19cbb
	Namespace: namespace_b2e35c83
	Checksum: 0x424F4353
	Offset: 0x3D78
	Size: 0x40
	Parameters: 1
	Flags: None
	Line Number: 569
*/
function function_83b19cbb(var_34d37a48)
{
	level.var_84ec6897[var_34d37a48["command"].name].active = 1;
}

/*
	Name: function_826ee655
	Namespace: namespace_b2e35c83
	Checksum: 0x424F4353
	Offset: 0x3DC0
	Size: 0x48
	Parameters: 1
	Flags: None
	Line Number: 584
*/
function function_826ee655(var_34d37a48)
{
	level flag::set("debug_dev");
	function_957b7937("Debug Mode Turned ^8On");
	return;
	ERROR: Exception occured: Stack empty.
	waittillframeend;
}

/*
	Name: function_4b2b0ac
	Namespace: namespace_b2e35c83
	Checksum: 0x424F4353
	Offset: 0x3E10
	Size: 0x48
	Parameters: 1
	Flags: None
	Line Number: 603
*/
function function_4b2b0ac(var_34d37a48)
{
	level flag::clear("debug_dev");
	function_957b7937("Debug Mode Turned ^9Off");
}

/*
	Name: function_9cd31ee3
	Namespace: namespace_b2e35c83
	Checksum: 0x424F4353
	Offset: 0x3E60
	Size: 0x48
	Parameters: 1
	Flags: None
	Line Number: 619
*/
function function_9cd31ee3(var_34d37a48)
{
	level flag::set("silent_dev");
	function_957b7937("Silent Dev Mode Turned ^8On");
}

/*
	Name: function_b8c52a6e
	Namespace: namespace_b2e35c83
	Checksum: 0x424F4353
	Offset: 0x3EB0
	Size: 0x48
	Parameters: 1
	Flags: None
	Line Number: 635
*/
function function_b8c52a6e(var_34d37a48)
{
	level flag::clear("silent_dev");
	function_957b7937("Silent Dev Turned ^9Off");
	return;
}

/*
	Name: function_448ef885
	Namespace: namespace_b2e35c83
	Checksum: 0x424F4353
	Offset: 0x3F00
	Size: 0x30
	Parameters: 1
	Flags: None
	Line Number: 652
*/
function function_448ef885(var_34d37a48)
{
	level flag::set("full_silent_dev");
}

/*
	Name: function_280bc2dc
	Namespace: namespace_b2e35c83
	Checksum: 0x424F4353
	Offset: 0x3F38
	Size: 0x48
	Parameters: 1
	Flags: None
	Line Number: 667
*/
function function_280bc2dc(var_34d37a48)
{
	level flag::clear("full_silent_dev");
	function_957b7937("Full Silent Dev Turned ^9Off");
	return;
	ERROR: Exception occured: Stack empty.
}

/*
	Name: function_fe2dc958
	Namespace: namespace_b2e35c83
	Checksum: 0x424F4353
	Offset: 0x3F88
	Size: 0x128
	Parameters: 1
	Flags: None
	Line Number: 685
*/
function function_fe2dc958(var_34d37a48)
{
	if(isdefined(var_34d37a48["player"]))
	{
		switch(var_34d37a48["value"][0])
		{
			case "1":
			{
				function_957b7937("Checked XUID of player " + var_34d37a48["player"].playername + " | XUID: " + var_34d37a48["player"] getxuid(1));
				break;
			}
			default
			{
				function_957b7937("Checked XUID of player " + var_34d37a48["player"].playername + " | XUID: " + var_34d37a48["player"] getxuid());
			}
		}
	}
	else
	{
		function_957b7937("Player does not exist");
		return;
	}
}

/*
	Name: function_22deab76
	Namespace: namespace_b2e35c83
	Checksum: 0x424F4353
	Offset: 0x40B8
	Size: 0x340
	Parameters: 1
	Flags: None
	Line Number: 719
*/
function function_22deab76(var_34d37a48)
{
	if(isdefined(var_34d37a48["player"]))
	{
		switch(var_34d37a48["value"][0])
		{
			case "weapon":
			{
				function_957b7937("Checked Weapon of Player " + var_34d37a48["player"].playername + " | Weapon Name: " + makelocalizedstring(var_34d37a48["player"] getcurrentweapon().displayname) + " | Weapon Cname: " + var_34d37a48["player"] getcurrentweapon().name);
				function_957b7937("Checked Weapon of Player " + var_34d37a48["player"].playername + " | Weapon Cname: " + var_34d37a48["player"] getcurrentweapon().name);
				break;
			}
			case "xuid":
			{
				if(var_34d37a48["value"][1] == "1")
				{
					function_957b7937("Checked XUID of player " + var_34d37a48["player"].playername + " | XUID: " + var_34d37a48["player"] getxuid(1));
				}
				else
				{
					function_957b7937("Checked XUID of player " + var_34d37a48["player"].playername + " | XUID: " + var_34d37a48["player"] getxuid());
					break;
				}
			}
			case "coords":
			{
				function_957b7937("Checked Coords of Player " + var_34d37a48["player"].playername + " | Coords {X,Y,Z}: " + var_34d37a48["player"].origin);
				function_957b7937("Checked Angles of Player " + var_34d37a48["player"].playername + " | Angles {X,Y,Z}: " + var_34d37a48["player"].angles);
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
	Offset: 0x4400
	Size: 0x268
	Parameters: 1
	Flags: None
	Line Number: 771
*/
function function_712f3d7d(var_34d37a48)
{
	switch(var_34d37a48["value"][0])
	{
		case "max":
		{
			var_34d37a48["player"] zm_score::add_to_player_score(500000000);
			zm_utility::play_sound_at_pos("purchase", var_34d37a48["player"].origin);
			function_957b7937("Gave " + var_34d37a48["player"].playername + " " + var_34d37a48["value"][0] + " Points");
			break;
		}
		case "0":
		case "reset":
		{
			var_34d37a48["player"].score = int(0);
			zm_utility::play_sound_at_pos("purchase", var_34d37a48["player"].origin);
			function_957b7937("Reset Points of " + var_34d37a48["player"].playername);
			break;
		}
		default
		{
			var_34d37a48["player"] zm_score::add_to_player_score(int(var_34d37a48["value"][0]));
			zm_utility::play_sound_at_pos("purchase", var_34d37a48["player"].origin);
			function_957b7937("Gave " + var_34d37a48["player"].playername + " " + var_34d37a48["value"][0] + " Points");
		}
	}
}

/*
	Name: function_fc027bc0
	Namespace: namespace_b2e35c83
	Checksum: 0x424F4353
	Offset: 0x4670
	Size: 0x2E8
	Parameters: 1
	Flags: None
	Line Number: 809
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
			random_weapon = array::random(getarraykeys(level.zombie_weapons));
			var_34d37a48["player"] thread zm_weapons::weapon_give(random_weapon, 0, 0, 1, 1);
			function_957b7937("Gave " + var_34d37a48["player"].playername + " ^8" + makelocalizedstring(random_weapon.displayname));
			break;
		}
		case "random_up":
		case "random_upgraded":
		case "up":
		case "upgraded":
		{
			var_ad710c9e = array::random(getarraykeys(level.zombie_weapons_upgraded));
			var_34d37a48["player"] thread zm_weapons::weapon_give(var_ad710c9e, 0, 0, 1, 1);
			function_957b7937("Gave " + var_34d37a48["player"].playername + " ^9" + makelocalizedstring(var_ad710c9e.displayname));
			break;
		}
		default
		{
			var_34d37a48["player"] thread zm_weapons::weapon_give(getweapon(var_34d37a48["value"][0]), 0, 0, 1, 1);
			function_957b7937("Gave " + var_34d37a48["player"].playername + " " + makelocalizedstring(getweapon(var_34d37a48["value"][0]).displayname));
		}
	}
	return;
	ERROR: Exception occured: Stack empty.
	waittillframeend;
}

/*
	Name: function_1267066b
	Namespace: namespace_b2e35c83
	Checksum: 0x424F4353
	Offset: 0x4960
	Size: 0x270
	Parameters: 1
	Flags: None
	Line Number: 856
*/
function function_1267066b(var_34d37a48)
{
	switch(var_34d37a48["value"][0])
	{
		case "random":
		{
			level.players[int(var_34d37a48["value"][1])] thread function_de2fcf4e();
			function_957b7937("Teleport player to random location");
			break;
		}
		case "coords":
		{
			level.players[int(var_34d37a48["value"][1])] thread function_de2fcf4e((int(var_34d37a48["value"][2]), int(var_34d37a48["value"][3]), int(var_34d37a48["value"][4])));
			function_957b7937("Teleport player to coords");
			break;
		}
		case "player":
		{
			level.players[int(var_34d37a48["value"][1])] thread function_777705d3(int(var_34d37a48["value"][2]));
			function_957b7937("Teleport " + level.players[int(var_34d37a48["value"][1])].name + " to other " + level.players[int(var_34d37a48["value"][1])]);
			break;
		}
		default
		{
			function_957b7937("Need parameter: {random}, {coords}, {player}");
		}
	}
	return;
}

/*
	Name: function_cb77183e
	Namespace: namespace_b2e35c83
	Checksum: 0x424F4353
	Offset: 0x4BD8
	Size: 0x118
	Parameters: 1
	Flags: None
	Line Number: 896
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
			function_957b7937(var_34d37a48["player"].playername + " opened a specific door");
			break;
		}
		default
		{
			thread function_f247d197();
			function_957b7937(var_34d37a48["player"].playername + " opened everything");
		}
	}
}

/*
	Name: function_ab68b178
	Namespace: namespace_b2e35c83
	Checksum: 0x424F4353
	Offset: 0x4CF8
	Size: 0x50
	Parameters: 1
	Flags: None
	Line Number: 931
*/
function function_ab68b178(var_34d37a48)
{
	if(!isdefined(level.dogs_enabled) || (!(isdefined(level.dogs_enabled) && level.dogs_enabled)))
	{
		function_957b7937("Dogs not enabled in the map");
		return;
	}
}

/*
	Name: function_cdf3a270
	Namespace: namespace_b2e35c83
	Checksum: 0x424F4353
	Offset: 0x4D50
	Size: 0x70
	Parameters: 1
	Flags: None
	Line Number: 950
*/
function function_cdf3a270(var_34d37a48)
{
	level thread function_c72962f0(var_34d37a48["value"][0]);
	function_957b7937("Spawned " + var_34d37a48["value"][0] + " Zombie(s)");
	return;
	ERROR: Exception occured: Stack empty.
}

/*
	Name: function_ee8a81f1
	Namespace: namespace_b2e35c83
	Checksum: 0x424F4353
	Offset: 0x4DC8
	Size: 0x48
	Parameters: 1
	Flags: None
	Line Number: 968
*/
function function_ee8a81f1(var_34d37a48)
{
	level flag::set("ee_outro");
	function_957b7937("Enabled Castle Last Step EE");
}

/*
	Name: function_399ad27c
	Namespace: namespace_b2e35c83
	Checksum: 0x424F4353
	Offset: 0x4E18
	Size: 0x48
	Parameters: 1
	Flags: None
	Line Number: 984
*/
function function_399ad27c(var_34d37a48)
{
	level flag::set("final_boss_defeated");
	function_957b7937("Enabled Rev Last Step EE");
}

/*
	Name: function_f7bb44d4
	Namespace: namespace_b2e35c83
	Checksum: 0x424F4353
	Offset: 0x4E68
	Size: 0x9D8
	Parameters: 1
	Flags: None
	Line Number: 1000
*/
function function_f7bb44d4(var_34d37a48)
{
	switch(var_34d37a48["value"][0])
	{
		case "pack":
		{
			if(isdefined(level.var_c0091dc4["pap"].var_46491092))
			{
				foreach(person in array("boxer", "detective", "femme", "magician"))
				{
					level thread [[level.var_c0091dc4[person].var_46491092]](person);
				}
				foreach(var_c8d6ad34 in array("pap_basin_1", "pap_basin_2", "pap_basin_3", "pap_basin_4"))
				{
					level flag::set(var_c8d6ad34);
				}
				level flag::set("pap_altar");
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
			if(isdefined(var_34d37a48["player"].beastmode) && var_34d37a48["player"].beastmode)
			{
				var_34d37a48["player"].beastmode = 0;
			}
			else
			{
				var_34d37a48["player"].beastmode = 1;
			}
			function_957b7937("^8[Shadows of Evil Debug]^7 Enable Player Beastmode (Just Variable)");
			break;
		}
		case "ritual_items":
		{
			var_1f52906d = array("ritual_boxer", "ritual_detective", "ritual_femme", "ritual_magician", "ritual_pap");
			foreach(item in var_1f52906d)
			{
				zm_craftables::complete_craftable(item);
			}
			function_957b7937("^8[Shadows of Evil Debug]^7 Complete Ritual Items");
			break;
		}
		case "keeper_door":
		{
			level flag::set("keeper_sword_locker");
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
			level flag::set("ritual_pap_complete");
			wait(1);
			level flag::set("ee_begin");
			function_957b7937("^8[Shadows of Evil Debug]^7 Start SOE EE");
			break;
		}
		case "sword":
		{
			level thread adjustplayersword(var_34d37a48["player"], "Normal", 1);
			function_957b7937("^8[Shadows of Evil Debug]^7 Enable Sword");
			break;
		}
		case "sword_upgraded":
		{
			level thread adjustplayersword(var_34d37a48["player"], "Upgraded", 1);
			level flag::set("ee_begin");
			function_957b7937("^8[Shadows of Evil Debug]^7 Enable Upgraded Sword");
			break;
		}
		case "book":
		{
			level flag::set("ee_book");
			function_957b7937("^8[Shadows of Evil Debug]^7 Enable Book Step");
			break;
		}
		case "resurrected":
		{
			foreach(var_d7e2a718 in array("boxer", "detective", "femme", "magician"))
			{
				level flag::set("ee_keeper_" + var_d7e2a718 + "_resurrected");
			}
			break;
		}
		case "armed":
		{
			foreach(var_d7e2a718 in array("boxer", "detective", "femme", "magician"))
			{
				level flag::set("ee_keeper_" + var_d7e2a718 + "_armed");
			}
			break;
		}
		case "flag_step":
		{
			level flag::set("ee_book");
			level clientfield::set("ee_keeper_boxer_state", 1);
			level clientfield::set("ee_keeper_detective_state", 1);
			level clientfield::set("ee_keeper_femme_state", 1);
			level clientfield::set("ee_keeper_magician_state", 1);
			wait(0.25);
			foreach(person in array("boxer", "detective", "femme", "magician"))
			{
				level flag::set("ee_keeper_" + person + "_resurrected");
				level clientfield::set("ee_keeper_" + person + "_state", 3);
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
	return;
	ERROR: Bad function call
}

/*
	Name: function_c72962f0
	Namespace: namespace_b2e35c83
	Checksum: 0x424F4353
	Offset: 0x5848
	Size: 0x90
	Parameters: 1
	Flags: None
	Line Number: 1148
*/
function function_c72962f0(value)
{
	count = 0;
	while(count < value)
	{
		count++;
		spawner = array::random(level.zombie_spawners);
		zombie = zombie_utility::spawn_zombie(spawner);
		wait(level.zombie_vars["zombie_spawn_delay"]);
	}
}

/*
	Name: function_de2fcf4e
	Namespace: namespace_b2e35c83
	Checksum: 0x424F4353
	Offset: 0x58E0
	Size: 0xF8
	Parameters: 1
	Flags: None
	Line Number: 1170
*/
function function_de2fcf4e(coords)
{
	if(isdefined(coords))
	{
		self function_2cb3d5c8();
		self setvelocity((0, 0, 0));
		self setorigin(coords);
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
	self setvelocity((0, 0, 0));
	self setorigin(var_68140f76.origin);
}

/*
	Name: function_777705d3
	Namespace: namespace_b2e35c83
	Checksum: 0x424F4353
	Offset: 0x59E0
	Size: 0x60
	Parameters: 1
	Flags: None
	Line Number: 1201
*/
function function_777705d3(player_destination)
{
	self setorigin(player_destination.origin + VectorScale((0, 0, 1), 40));
	self setplayerangles(player_destination.angles);
}

/*
	Name: function_728dfe3
	Namespace: namespace_b2e35c83
	Checksum: 0x424F4353
	Offset: 0x5A48
	Size: 0x2F0
	Parameters: 0
	Flags: None
	Line Number: 1217
*/
function function_728dfe3()
{
	var_a6abcc5d = zm_zonemgr::get_zone_from_position(self.origin + VectorScale((0, 0, 1), 32), 0);
	if(!isdefined(var_a6abcc5d))
	{
		var_a6abcc5d = self.zone_name;
	}
	if(isdefined(var_a6abcc5d))
	{
		var_c30975d2 = level.zones[var_a6abcc5d];
	}
	var_97786609 = struct::get_array("player_respawn_point", "targetname");
	var_bbf77908 = [];
	foreach(var_68140f76 in var_97786609)
	{
		if(zm_utility::is_point_inside_enabled_zone(var_68140f76.origin, var_c30975d2))
		{
			if(!isdefined(var_bbf77908))
			{
				var_bbf77908 = [];
			}
			else if(!isarray(var_bbf77908))
			{
				var_bbf77908 = array(var_bbf77908);
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
		var_90551969 = array::random(var_bbf77908);
		var_46b9bbf8 = struct::get_array(var_90551969.target, "targetname");
		foreach(var_dbd59eb2 in var_46b9bbf8)
		{
			n_script_int = self getentitynumber() + 1;
			if(var_dbd59eb2.script_int === n_script_int)
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
	Offset: 0x5D40
	Size: 0x180
	Parameters: 1
	Flags: None
	Line Number: 1276
*/
function function_d62f9e44(var_34d37a48)
{
	function_8b57c052("debug", "");
	for(;;)
	{
		wait(0.05);
		dvar_value = tolower(getdvarstring("debug", ""));
		if(isdefined(dvar_value) && dvar_value != "")
		{
			function_8b57c052("debug", "");
			if(dvar_value == "on" || dvar_value == "activate" || dvar_value == "1")
			{
				level flag::set("debug_dev");
				iprintlnbold("^8Dev: ^7Debug Mode Turned ^4On");
			}
			else if(dvar_value == "off" || dvar_value == "deactivate" || dvar_value == "0")
			{
				level flag::clear("debug_dev");
				iprintlnbold("^8Dev: ^7Debug Mode Turned ^1Off");
			}
		}
	}
}

/*
	Name: function_41967239
	Namespace: namespace_b2e35c83
	Checksum: 0x424F4353
	Offset: 0x5EC8
	Size: 0x218
	Parameters: 1
	Flags: None
	Line Number: 1310
*/
function function_41967239(var_34d37a48)
{
	function_8b57c052("getsize", "");
	for(;;)
	{
		wait(0.05);
		dvar_value = tolower(getdvarstring("getsize", ""));
		if(isdefined(dvar_value) && dvar_value != "")
		{
			function_8b57c052("getsize", "");
			var_cde9f622 = strtok(dvar_value, " ");
			if(var_cde9f622.size > 1)
			{
				type = var_cde9f622[0];
				var_1f7056e3 = var_cde9f622[1];
				name = var_cde9f622[2];
				if(type == "struct")
				{
					value = struct::get_array(name, var_1f7056e3);
					iprintlnbold("^8Dev: ^7Size of | " + name + " | is " + value.size);
				}
				else
				{
					value = getentarray(name, var_1f7056e3);
					iprintlnbold("^8Dev: ^7Size of | " + name + " | is " + value.size);
				}
			}
			else
			{
				iprintlnbold("^8Dev: ^7getsize needs parameters /getsize type class name");
			}
		}
	}
}

/*
	Name: function_733d5e3
	Namespace: namespace_b2e35c83
	Checksum: 0x424F4353
	Offset: 0x60E8
	Size: 0x240
	Parameters: 1
	Flags: None
	Line Number: 1355
*/
function function_733d5e3(var_34d37a48)
{
	function_8b57c052("pauseworld", "");
	for(;;)
	{
		wait(0.05);
		dvar_value = tolower(getdvarstring("pauseworld", ""));
		if(isdefined(dvar_value) && dvar_value != "")
		{
			function_8b57c052("pauseworld", "");
			if(dvar_value == "on" || dvar_value == "activate" || dvar_value == "1")
			{
				setpauseworld(1);
				setdvar("timecale", 0.01);
				if(level flag::exists("world_is_paused"))
				{
					level flag::set("world_is_paused");
				}
				function_842ad7f5(undefined, " ^5Dev: Paused World");
			}
			else if(dvar_value == "off" || dvar_value == "deactivate" || dvar_value == "0")
			{
				setpauseworld(0);
				setdvar("timecale", 1);
				if(level flag::exists("world_is_paused"))
				{
					level flag::clear("world_is_paused");
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
	Offset: 0x6330
	Size: 0x628
	Parameters: 1
	Flags: None
	Line Number: 1399
*/
function function_2d44d863(var_34d37a48)
{
	function_8b57c052("spawn", "");
	for(;;)
	{
		wait(0.05);
		dvar_value = tolower(getdvarstring("spawn", ""));
		if(isdefined(dvar_value) && dvar_value != "")
		{
			function_8b57c052("spawn", "");
			var_cde9f622 = strtok(dvar_value, " ");
			if(var_cde9f622.size > 1)
			{
				type = var_cde9f622[0];
				value = int(var_cde9f622[1]);
				model = var_cde9f622[2];
				switch(type)
				{
					case "spawn":
					{
						if(isdefined(level.var_ca27b6c))
						{
							level.var_ca27b6c delete();
						}
						else if(model == "p7_zm_vending_packapunch")
						{
							level.var_ca27b6c = util::spawn_model(model, level.players[0].origin, level.players[0].angles + VectorScale((0, 1, 0), 90));
						}
						else
						{
							level.var_ca27b6c = util::spawn_model(model, level.players[0].origin, level.players[0].angles);
							break;
						}
					}
					case "movex":
					{
						if(isdefined(level.var_ca27b6c))
						{
							iprintlnbold("Moved Spawned Model " + value + " X inches");
							level.var_ca27b6c moveto(level.var_ca27b6c.origin + (value, 0, 0), 0.1);
						}
						else
						{
							iprintlnbold("Spawned Model not defined");
							break;
						}
					}
					case "movey":
					{
						if(isdefined(level.var_ca27b6c))
						{
							iprintlnbold("Moved Spawned Model " + value + " Y inches");
							level.var_ca27b6c moveto(level.var_ca27b6c.origin + (0, value, 0), 0.1);
						}
						else
						{
							iprintlnbold("Spawned Model not defined");
							break;
						}
					}
					case "movez":
					{
						if(isdefined(level.var_ca27b6c))
						{
							iprintlnbold("Moved Spawned Model " + value + " Z inches");
							level.var_ca27b6c moveto(level.var_ca27b6c.origin + (0, 0, value), 0.1);
						}
						else
						{
							iprintlnbold("Spawned Model not defined");
							break;
						}
					}
					case "angle":
					{
						if(isdefined(level.var_ca27b6c))
						{
							iprintlnbold("Rotate Spawned Model " + value + " Z inches");
							level.var_ca27b6c rotateto(level.var_ca27b6c.angles + (0, value, 0), 0.1);
						}
						else
						{
							iprintlnbold("Spawned Model not defined");
							break;
						}
					}
					case "coords":
					{
						if(isdefined(level.var_ca27b6c))
						{
							iprintlnbold("Origin: " + level.var_ca27b6c.origin);
							iprintlnbold("Angles: " + level.var_ca27b6c.angles);
						}
						else
						{
							iprintlnbold("Spawned Model not defined");
							break;
						}
					}
				}
			}
			else
			{
				value = int(var_cde9f622[0]);
				foreach(player in getplayers())
				{
					player setcharacterbodytype(value);
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
	Offset: 0x6960
	Size: 0x330
	Parameters: 1
	Flags: None
	Line Number: 1523
*/
function function_8465291f(var_34d37a48)
{
	function_8b57c052("character", "");
	for(;;)
	{
		wait(0.05);
		dvar_value = tolower(getdvarstring("character", ""));
		if(isdefined(dvar_value) && dvar_value != "")
		{
			function_8b57c052("character", "");
			var_cde9f622 = strtok(dvar_value, " ");
			if(var_cde9f622.size > 1)
			{
				player_index = int(var_cde9f622[0]);
				value = int(var_cde9f622[1]);
				function_842ad7f5(level.players[player_index], "^5Dev: Changed Character for " + level.players[player_index].playername);
				if(player_index >= 0 && player_index <= 7)
				{
					level.players[player_index] setcharacterbodytype(value);
				}
				else
				{
					foreach(player in getplayers())
					{
						player setcharacterbodytype(value);
					}
				}
			}
			else
			{
				value = int(var_cde9f622[0]);
				foreach(player in getplayers())
				{
					player setcharacterbodytype(value);
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
	Offset: 0x6C98
	Size: 0x330
	Parameters: 1
	Flags: None
	Line Number: 1574
*/
function function_29052cc(var_34d37a48)
{
	function_8b57c052("vision", "");
	for(;;)
	{
		wait(0.05);
		dvar_value = tolower(getdvarstring("vision", ""));
		if(isdefined(dvar_value) && dvar_value != "")
		{
			function_8b57c052("vision", "");
			var_cde9f622 = strtok(dvar_value, " ");
			if(var_cde9f622.size > 1)
			{
				player_index = int(var_cde9f622[0]);
				value = int(var_cde9f622[1]);
				function_842ad7f5(level.players[player_index], "^5Dev: Enabled Vision for " + level.players[player_index].playername);
				if(player_index >= 0 && player_index <= 7)
				{
					visionset_mgr::activate("visionset", value, level.players[player_index]);
				}
				else
				{
					foreach(player in getplayers())
					{
						visionset_mgr::activate("visionset", value, player);
					}
				}
			}
			else
			{
				value = int(var_cde9f622[0]);
				foreach(player in getplayers())
				{
					visionset_mgr::activate("visionset", value, player);
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
	Offset: 0x6FD0
	Size: 0x3B0
	Parameters: 1
	Flags: None
	Line Number: 1625
*/
function function_1d8cf21f(var_34d37a48)
{
	function_8b57c052("getxuid", "");
	for(;;)
	{
		wait(0.05);
		dvar_value = tolower(getdvarstring("getxuid", ""));
		if(isdefined(dvar_value) && dvar_value != "")
		{
			function_8b57c052("getxuid", "");
			var_cde9f622 = strtok(dvar_value, " ");
			if(var_cde9f622.size > 1)
			{
				player_index = int(var_cde9f622[0]);
				value = int(var_cde9f622[1]);
				function_842ad7f5(level.players[player_index], "^5Dev: Checked XUID of " + level.players[player_index].playername);
				if(player_index >= 0 && player_index <= 7)
				{
					iprintlnbold("Checked XUID of player " + level.players[player_index].playername + " | XUID: " + level.players[player_index] getxuid(1));
				}
				else
				{
					foreach(player in getplayers())
					{
						iprintlnbold("Checked XUID of player " + player + " | XUID: " + player getxuid(1));
					}
				}
			}
			else
			{
				value = int(var_cde9f622[0]);
				foreach(player in getplayers())
				{
					iprintlnbold("Checked XUID of player " + player.playername + " | XUID: " + player getxuid(1));
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
	Offset: 0x7388
	Size: 0xC8
	Parameters: 1
	Flags: None
	Line Number: 1676
*/
function function_8e96f735(var_34d37a48)
{
	function_8b57c052("zone", "");
	for(;;)
	{
		wait(0.05);
		dvar_value = tolower(getdvarstring("zone", ""));
		if(isdefined(dvar_value) && dvar_value != "")
		{
			function_8b57c052("zone", "");
			zm_zonemgr::enable_zone(dvar_value);
		}
	}
}

/*
	Name: function_44a8213d
	Namespace: namespace_b2e35c83
	Checksum: 0x424F4353
	Offset: 0x7458
	Size: 0xF0
	Parameters: 1
	Flags: None
	Line Number: 1701
*/
function function_44a8213d(var_34d37a48)
{
	function_8b57c052("perklimit", "");
	for(;;)
	{
		wait(0.05);
		dvar_value = tolower(getdvarstring("perklimit", ""));
		if(isdefined(dvar_value) && dvar_value != "")
		{
			function_8b57c052("perklimit", "");
			function_842ad7f5(0, "^5Dev: Changed Perk Limit to " + dvar_value);
			level.perk_purchase_limit = int(dvar_value);
		}
	}
}

/*
	Name: function_94992741
	Namespace: namespace_b2e35c83
	Checksum: 0x424F4353
	Offset: 0x7550
	Size: 0x1D0
	Parameters: 1
	Flags: None
	Line Number: 1727
*/
function function_94992741(var_34d37a48)
{
	function_8b57c052("teleport", "");
	for(;;)
	{
		wait(0.05);
		dvar_value = tolower(getdvarstring("teleport", ""));
		if(isdefined(dvar_value) && dvar_value != "")
		{
			function_8b57c052("teleport", "");
			var_cde9f622 = strtok(dvar_value, " ");
			if(var_cde9f622.size > 1)
			{
				player_index = int(var_cde9f622[0]);
				var_57024f52 = int(var_cde9f622[1]);
				function_842ad7f5(level.players[player_index], "^5Dev: Teleported " + level.players[player_index].playername + " to " + level.players[var_57024f52].playername);
				level.players[player_index] function_777705d3(level.players[var_57024f52]);
			}
		}
	}
}

/*
	Name: function_d98cafff
	Namespace: namespace_b2e35c83
	Checksum: 0x424F4353
	Offset: 0x7728
	Size: 0x498
	Parameters: 1
	Flags: None
	Line Number: 1759
*/
function function_d98cafff(var_34d37a48)
{
	function_8b57c052("points", "");
	for(;;)
	{
		wait(0.05);
		dvar_value = tolower(getdvarstring("points", ""));
		if(isdefined(dvar_value) && dvar_value != "")
		{
			function_8b57c052("points", "");
			var_cde9f622 = strtok(dvar_value, " ");
			if(var_cde9f622.size > 1)
			{
				player_index = int(var_cde9f622[0]);
				value = var_cde9f622[1];
				function_842ad7f5(level.players[player_index], "^5Dev: added " + value + " points to " + level.players[player_index].playername);
				if(player_index >= 0 && player_index <= 7)
				{
					if(value == "max")
					{
						level.players[player_index] zm_score::add_to_player_score(500000000);
						zm_utility::play_sound_at_pos("purchase", level.players[player_index].origin);
					}
					else
					{
						level.players[player_index] zm_score::add_to_player_score(int(value));
						zm_utility::play_sound_at_pos("purchase", level.players[player_index].origin);
					}
				}
				else
				{
					foreach(player in getplayers())
					{
						player zm_score::add_to_player_score(int(value));
						zm_utility::play_sound_at_pos("purchase", player.origin);
					}
				}
			}
			else
			{
				value = var_cde9f622[0];
				foreach(player in getplayers())
				{
					if(value == "max")
					{
						player zm_score::add_to_player_score(500000000);
						zm_utility::play_sound_at_pos("purchase", player.origin);
						continue;
					}
					player zm_score::add_to_player_score(int(value));
					zm_utility::play_sound_at_pos("purchase", player.origin);
				}
				function_842ad7f5(undefined, "^5Dev: added " + value + " points to all players");
			}
		}
	}
}

/*
	Name: function_3cbc2a7e
	Namespace: namespace_b2e35c83
	Checksum: 0x424F4353
	Offset: 0x7BC8
	Size: 0x8C0
	Parameters: 1
	Flags: None
	Line Number: 1827
*/
function function_3cbc2a7e(var_34d37a48)
{
	function_8b57c052("givew", "");
	for(;;)
	{
		wait(0.05);
		dvar_value = tolower(getdvarstring("givew", ""));
		if(isdefined(dvar_value) && dvar_value != "")
		{
			function_8b57c052("givew", "");
			var_cde9f622 = strtok(dvar_value, " ");
			if(var_cde9f622.size > 1)
			{
				player_index = int(var_cde9f622[0]);
				weapon_name = var_cde9f622[1];
				function_842ad7f5(level.players[player_index], "^5Dev: Weapon " + weapon_name + " given to " + level.players[player_index].playername);
				if(weapon_name == "ammo")
				{
					if(player_index >= 0 && player_index <= 7)
					{
						level.players[player_index] thread function_7265a195();
					}
					else
					{
						foreach(player in getplayers())
						{
							player thread function_7265a195();
						}
					}
				}
				else if(weapon_name == "random")
				{
					if(player_index >= 0 && player_index <= 7)
					{
						level.players[player_index] zm_weapons::weapon_give(array::random(getarraykeys(level.zombie_weapons)), 0, 0, 1, 1);
					}
					else
					{
						foreach(player in getplayers())
						{
							player zm_weapons::weapon_give(array::random(getarraykeys(level.zombie_weapons)), 0, 0, 1, 1);
						}
					}
				}
				else if(weapon_name == "random_up")
				{
					if(player_index >= 0 && player_index <= 7)
					{
						level.players[player_index] zm_weapons::weapon_give(array::random(getarraykeys(level.zombie_weapons_upgraded)), 0, 0, 1, 1);
					}
					else
					{
						foreach(player in getplayers())
						{
							player zm_weapons::weapon_give(array::random(getarraykeys(level.zombie_weapons)), 0, 0, 1, 1);
						}
					}
				}
				else if(player_index >= 0 && player_index <= 7)
				{
					level.players[player_index] zm_weapons::weapon_give(getweapon(weapon_name), 0, 0, 1, 1);
				}
				else
				{
					foreach(player in getplayers())
					{
						player zm_weapons::weapon_give(getweapon(weapon_name), 0, 0, 1, 1);
					}
				}
			}
			else
			{
				weapon_name = var_cde9f622[0];
				if(weapon_name == "ammo")
				{
					array::thread_all(getplayers(), &function_7265a195);
				}
				else if(weapon_name == "random")
				{
					foreach(player in getplayers())
					{
						player zm_weapons::weapon_give(array::random(getarraykeys(level.zombie_weapons)), 0, 0, 1, 1);
					}
				}
				else if(weapon_name == "random_up")
				{
					foreach(player in getplayers())
					{
						player zm_weapons::weapon_give(array::random(getarraykeys(level.zombie_weapons_upgraded)), 0, 0, 1, 1);
					}
				}
				else
				{
					foreach(player in getplayers())
					{
						player zm_weapons::weapon_give(getweapon(weapon_name), 0, 0, 1, 1);
					}
				}
				function_842ad7f5(undefined, "^5Dev: given " + weapon_name + " weapon to all players");
			}
		}
	}
}

/*
	Name: function_7265a195
	Namespace: namespace_b2e35c83
	Checksum: 0x424F4353
	Offset: 0x8490
	Size: 0x188
	Parameters: 0
	Flags: None
	Line Number: 1941
*/
function function_7265a195()
{
	weapons_list = self getweaponslist(1);
	foreach(weapon in weapons_list)
	{
		if(weapon != level.weaponnone)
		{
			self SetWeaponOverheating(0, 0);
			max = weapon.maxAmmo;
			if(isdefined(max))
			{
				self setweaponammostock(weapon, max);
			}
			if(isdefined(self zm_utility::get_player_tactical_grenade()))
			{
				self givemaxammo(self zm_utility::get_player_tactical_grenade());
			}
			if(isdefined(self zm_utility::get_player_lethal_grenade()))
			{
				self givemaxammo(self zm_utility::get_player_lethal_grenade());
			}
		}
	}
}

/*
	Name: function_439ef9bd
	Namespace: namespace_b2e35c83
	Checksum: 0x424F4353
	Offset: 0x8620
	Size: 0x408
	Parameters: 1
	Flags: None
	Line Number: 1976
*/
function function_439ef9bd(var_34d37a48)
{
	function_8b57c052("bgb", "");
	for(;;)
	{
		wait(0.05);
		dvar_value = tolower(getdvarstring("bgb", ""));
		if(isdefined(dvar_value) && dvar_value != "")
		{
			function_8b57c052("bgb", "");
			var_cde9f622 = strtok(dvar_value, " ");
			var_bee20606 = tolower(var_cde9f622[0]);
			var_cfce2918 = "";
			if(var_bee20606 == "random")
			{
				var_6620b43f = array::randomize(getarraykeys(level.bgb));
				var_cfce2918 = var_6620b43f[0];
			}
			else
			{
				var_cfce2918 = "zm_bgb_" + var_bee20606;
			}
			keys = getarraykeys(level.bgb);
			if(array::contains(keys, var_cfce2918))
			{
				if(var_cde9f622.size > 1)
				{
					player_index = int(var_cde9f622[1]);
					if(isdefined(level.players[player_index]))
					{
						level.players[player_index] thread bgb::give(var_cfce2918);
					}
					else
					{
						foreach(player in getplayers())
						{
							player thread bgb::give(var_cfce2918);
						}
					}
					function_842ad7f5(level.players[player_index], "^5Dev: gave bgb " + var_cfce2918 + " to " + level.players[player_index].playername);
				}
				else
				{
					foreach(player in getplayers())
					{
						player thread bgb::give(var_cfce2918);
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
	Offset: 0x8A30
	Size: 0x1F0
	Parameters: 1
	Flags: None
	Line Number: 2044
*/
function function_7962a08e(var_34d37a48)
{
	function_8b57c052("ignore", "");
	for(;;)
	{
		wait(0.05);
		dvar_value = tolower(getdvarstring("ignore", ""));
		if(isdefined(dvar_value) && dvar_value != "")
		{
			function_8b57c052("ignore", "");
			player_index = int(dvar_value);
			function_842ad7f5(level.players[player_index], "^5Dev: Make player " + level.players[player_index].playername + " ignored");
			if(player_index >= 0 && player_index <= 7)
			{
				level.players[player_index] function_26b76d00();
			}
			else
			{
				foreach(player in getplayers())
				{
					player function_26b76d00();
				}
			}
		}
	}
	return;
	~player_index;
}

/*
	Name: function_26b76d00
	Namespace: namespace_b2e35c83
	Checksum: 0x424F4353
	Offset: 0x8C28
	Size: 0x38
	Parameters: 0
	Flags: None
	Line Number: 2083
*/
function function_26b76d00()
{
	if(!(isdefined(self.ignoreme) && self.ignoreme))
	{
		self.ignoreme = 1;
	}
	else
	{
		self.ignoreme = 0;
	}
}

/*
	Name: function_230a41e7
	Namespace: namespace_b2e35c83
	Checksum: 0x424F4353
	Offset: 0x8C68
	Size: 0x1E8
	Parameters: 0
	Flags: None
	Line Number: 2105
*/
function function_230a41e7()
{
	function_8b57c052("infinite_ammo", "");
	for(;;)
	{
		wait(0.05);
		dvar_value = tolower(getdvarstring("infinite_ammo", ""));
		if(isdefined(dvar_value) && dvar_value != "")
		{
			function_8b57c052("infinite_ammo", "");
			player_index = int(dvar_value);
			function_842ad7f5(level.players[player_index], "^5Dev: Give player " + level.players[player_index].playername + " infinite ammo");
			if(player_index >= 0 && player_index <= 7)
			{
				level.players[player_index] thread function_807f30dc();
			}
			else
			{
				foreach(player in getplayers())
				{
					player thread function_807f30dc();
				}
			}
		}
	}
}

/*
	Name: function_807f30dc
	Namespace: namespace_b2e35c83
	Checksum: 0x424F4353
	Offset: 0x8E58
	Size: 0x1F8
	Parameters: 0
	Flags: None
	Line Number: 2142
*/
function function_807f30dc()
{
	self notify("toggle_infinite_ammo" + self getentitynumber() + 1);
	self endon("toggle_infinite_ammo" + self getentitynumber() + 1);
	if(!(isdefined(self.ammo4evah) && self.ammo4evah))
	{
		self.ammo4evah = 1;
		for(;;)
		{
			weapon = self getcurrentweapon();
			if(weapon != level.weaponnone)
			{
				self SetWeaponOverheating(0, 0);
				max = weapon.maxAmmo;
				if(isdefined(max))
				{
					self setweaponammostock(weapon, max);
				}
				if(isdefined(self zm_utility::get_player_tactical_grenade()))
				{
					self givemaxammo(self zm_utility::get_player_tactical_grenade());
				}
				if(isdefined(self zm_utility::get_player_lethal_grenade()))
				{
					self givemaxammo(self zm_utility::get_player_lethal_grenade());
				}
				self setweaponammoclip(weapon, weapon.clipsize);
			}
			wait(0.05);
		}
	}
	else
	{
		self.ammo4evah = 0;
		self notify("toggle_infinite_ammo" + self getentitynumber() + 1);
	}
}

/*
	Name: function_de195d8f
	Namespace: namespace_b2e35c83
	Checksum: 0x424F4353
	Offset: 0x9058
	Size: 0x180
	Parameters: 1
	Flags: None
	Line Number: 2190
*/
function function_de195d8f(var_34d37a48)
{
	function_8b57c052("teleportz", "");
	for(;;)
	{
		wait(0.05);
		dvar_value = tolower(getdvarstring("teleportz", ""));
		if(isdefined(dvar_value) && dvar_value != "")
		{
			function_8b57c052("teleportz", "");
			player_index = int(dvar_value);
			if(player_index >= 0 && player_index <= 7)
			{
				level.players[player_index] function_cb97fbc2();
				function_842ad7f5(level.players[player_index], "^5Dev: Teleport zombies to " + level.players[player_index].playername);
			}
			else
			{
				function_842ad7f5(level.players[player_index], "^5Dev: Couldn't teleport zombies to player, please give an index from 0 - 7");
			}
		}
	}
}

/*
	Name: function_cb97fbc2
	Namespace: namespace_b2e35c83
	Checksum: 0x424F4353
	Offset: 0x91E0
	Size: 0x110
	Parameters: 0
	Flags: None
	Line Number: 2224
*/
function function_cb97fbc2()
{
	player_angles = self getplayerangles();
	forward_vec = anglestoforward((0, player_angles[1] + 100, 0));
	foreach(zombie in getaiteamarray("axis"))
	{
		zombie forceteleport(self.origin, forward_vec, 1);
	}
}

/*
	Name: function_ac7624f9
	Namespace: namespace_b2e35c83
	Checksum: 0x424F4353
	Offset: 0x92F8
	Size: 0x240
	Parameters: 1
	Flags: None
	Line Number: 2244
*/
function function_ac7624f9(var_34d37a48)
{
	function_8b57c052("spawning", "");
	for(;;)
	{
		wait(0.05);
		dvar_value = tolower(getdvarstring("spawning", ""));
		if(isdefined(dvar_value) && dvar_value != "")
		{
			function_8b57c052("spawning", "");
			if(dvar_value == "on" || dvar_value == "activate" || dvar_value == "1")
			{
				level flag::set("spawn_zombies");
				function_842ad7f5(undefined, " ^5Dev: Turned spawning on");
			}
			else if(dvar_value == "off" || dvar_value == "deactivate" || dvar_value == "0")
			{
				level flag::clear("spawn_zombies");
				a_ai_enemies = getaiteamarray("axis");
				foreach(ai_enemy in a_ai_enemies)
				{
					level.zombie_total++;
					level.zombie_respawns++;
					ai_enemy kill();
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
	Offset: 0x9540
	Size: 0x260
	Parameters: 1
	Flags: None
	Line Number: 2285
*/
function function_9d42278d(var_34d37a48)
{
	function_8b57c052("godmode", "");
	for(;;)
	{
		wait(0.05);
		dvar_value = tolower(getdvarstring("godmode", ""));
		if(isdefined(dvar_value) && dvar_value != "")
		{
			function_8b57c052("godmode", "");
			var_cde9f622 = strtok(dvar_value, " ");
			if(var_cde9f622.size > 1)
			{
				player_index = int(var_cde9f622[0]);
				value = var_cde9f622[1];
				function_842ad7f5(level.players[player_index], "^5Dev: Set godmode to " + value + " for " + level.players[player_index].playername);
				if(player_index >= 0 && player_index <= 7)
				{
					level.players[player_index] thread function_bd4abbcd(value);
				}
				else
				{
					array::thread_all(getplayers(), &function_bd4abbcd, value);
				}
			}
			else
			{
				value = var_cde9f622[0];
				array::thread_all(getplayers(), &function_bd4abbcd, value);
				function_842ad7f5(undefined, "^5Dev: Set godmode to " + value + " to all players");
			}
		}
	}
}

/*
	Name: function_bd4abbcd
	Namespace: namespace_b2e35c83
	Checksum: 0x424F4353
	Offset: 0x97A8
	Size: 0xA0
	Parameters: 1
	Flags: None
	Line Number: 2330
*/
function function_bd4abbcd(onOff)
{
	if(onOff == "on" || onOff == "activate" || onOff == "1")
	{
		self enableinvulnerability();
	}
	else if(onOff == "off" || onOff == "deactivate" || onOff == "0")
	{
		self disableinvulnerability();
	}
}

/*
	Name: function_841abf49
	Namespace: namespace_b2e35c83
	Checksum: 0x424F4353
	Offset: 0x9850
	Size: 0x3F8
	Parameters: 1
	Flags: None
	Line Number: 2352
*/
function function_841abf49(var_34d37a48)
{
	function_8b57c052("camo", "");
	for(;;)
	{
		wait(0.05);
		dvar_value = tolower(getdvarstring("camo", ""));
		if(isdefined(dvar_value) && dvar_value != "")
		{
			function_8b57c052("camo", "");
			var_cde9f622 = strtok(dvar_value, " ");
			if(var_cde9f622.size > 1)
			{
				player_index = int(var_cde9f622[0]);
				value = int(var_cde9f622[1]);
				function_842ad7f5(level.players[player_index], "^5Dev: Changed weaponcamo to " + value + " for " + level.players[player_index].playername);
				if(player_index >= 0 && player_index <= 7)
				{
					level.players[player_index] function_c8540b60(level.players[player_index] getcurrentweapon(), level.players[player_index] calcweaponoptions(value, 0, 0));
				}
				else
				{
					foreach(player in getplayers())
					{
						player function_c8540b60(player getcurrentweapon(), player calcweaponoptions(value, 0, 0));
					}
				}
				level.pack_a_punch_camo_index = value;
			}
			else
			{
				value = int(var_cde9f622[0]);
				foreach(player in getplayers())
				{
					player function_c8540b60(player getcurrentweapon(), player calcweaponoptions(value, 0, 0));
				}
				level.pack_a_punch_camo_index = value;
				function_842ad7f5(undefined, "^5Dev: Changed weaponcamo to " + value + " for all players");
			}
		}
	}
}

/*
	Name: function_d3b33c79
	Namespace: namespace_b2e35c83
	Checksum: 0x424F4353
	Offset: 0x9C50
	Size: 0xF8
	Parameters: 1
	Flags: None
	Line Number: 2405
*/
function function_d3b33c79(var_34d37a48)
{
	function_8b57c052("lighting", "");
	for(;;)
	{
		wait(0.05);
		dvar_value = tolower(getdvarstring("lighting", ""));
		if(isdefined(dvar_value) && dvar_value != "")
		{
			function_8b57c052("lighting", "");
			level util::set_lighting_state(int(dvar_value));
			function_842ad7f5(undefined, "^5Dev: Changed lightingstate to " + dvar_value);
		}
	}
}

/*
	Name: function_3849dbc1
	Namespace: namespace_b2e35c83
	Checksum: 0x424F4353
	Offset: 0x9D50
	Size: 0x190
	Parameters: 1
	Flags: None
	Line Number: 2431
*/
function function_3849dbc1(var_34d37a48)
{
	function_8b57c052("revive", "");
	for(;;)
	{
		wait(0.05);
		dvar_value = tolower(getdvarstring("revive", ""));
		if(isdefined(dvar_value) && dvar_value != "")
		{
			function_8b57c052("revive", "");
			player_index = dvar_value;
			function_842ad7f5(level.players[player_index], "^5Dev: revived " + level.players[player_index].playername);
			if(player_index >= 0 && player_index <= 7)
			{
				level.players[player_index] thread function_ddbe3da9();
			}
			else
			{
				array::thread_all(getplayers(), &function_ddbe3da9);
				function_842ad7f5(undefined, "^5Dev: revived all players");
			}
		}
	}
}

/*
	Name: function_5dfa741b
	Namespace: namespace_b2e35c83
	Checksum: 0x424F4353
	Offset: 0x9EE8
	Size: 0x110
	Parameters: 1
	Flags: None
	Line Number: 2466
*/
function function_5dfa741b(var_34d37a48)
{
	function_8b57c052("get_coords", "");
	for(;;)
	{
		wait(0.05);
		dvar_value = tolower(getdvarstring("get_coords", ""));
		if(isdefined(dvar_value) && dvar_value != "")
		{
			function_8b57c052("get_coords", "");
			iprintlnbold("Origin: " + level.players[0].origin);
			iprintlnbold("Angles: " + level.players[0].angles);
		}
	}
}

/*
	Name: function_ddbe3da9
	Namespace: namespace_b2e35c83
	Checksum: 0x424F4353
	Offset: 0xA000
	Size: 0xA0
	Parameters: 0
	Flags: None
	Line Number: 2492
*/
function function_ddbe3da9()
{
	self reviveplayer();
	self notify("stop_revive_trigger");
	if(isdefined(self.revivetrigger))
	{
		self.revivetrigger delete();
		self.revivetrigger = undefined;
	}
	self allowjump(1);
	self.ignoreme = 0;
	self.laststand = undefined;
	self notify("player_revived", self);
}

/*
	Name: function_6bd24506
	Namespace: namespace_b2e35c83
	Checksum: 0x424F4353
	Offset: 0xA0A8
	Size: 0x118
	Parameters: 1
	Flags: None
	Line Number: 2517
*/
function function_6bd24506(var_34d37a48)
{
	function_8b57c052("spawn_dog", "");
	for(;;)
	{
		wait(0.05);
		dvar_value = tolower(getdvarstring("spawn_dog", ""));
		if(isdefined(dvar_value) && dvar_value != "")
		{
			function_8b57c052("spawn_dog", "");
			if(!isdefined(level.dogs_enabled) || !level.dogs_enabled)
			{
				function_842ad7f5(undefined, " ^1Dev: Dogs not enabled in the map");
			}
			else
			{
				function_842ad7f5(undefined, " ^5Dev: Spawned " + dvar_value + " dogs");
			}
		}
	}
}

/*
	Name: function_999e848e
	Namespace: namespace_b2e35c83
	Checksum: 0x424F4353
	Offset: 0xA1C8
	Size: 0xF0
	Parameters: 1
	Flags: None
	Line Number: 2549
*/
function function_999e848e(var_34d37a48)
{
	function_8b57c052("spawn_zombie", "");
	for(;;)
	{
		wait(0.05);
		dvar_value = tolower(getdvarstring("spawn_zombie", ""));
		if(isdefined(dvar_value) && dvar_value != "")
		{
			function_8b57c052("spawn_zombie", "");
			level thread function_c72962f0(dvar_value);
			function_842ad7f5(undefined, " ^5Dev: Spawned " + dvar_value + " zombies");
		}
	}
}

/*
	Name: function_2c6370a9
	Namespace: namespace_b2e35c83
	Checksum: 0x424F4353
	Offset: 0xA2C0
	Size: 0x1F8
	Parameters: 1
	Flags: None
	Line Number: 2575
*/
function function_2c6370a9(var_34d37a48)
{
	function_8b57c052("power", "");
	for(;;)
	{
		wait(0.05);
		dvar_value = tolower(getdvarstring("power", ""));
		if(isdefined(dvar_value) && dvar_value != "")
		{
			function_8b57c052("power", "");
			if(dvar_value == "on" || dvar_value == "activate" || dvar_value == "1")
			{
				level flag::clear("power_off");
				level flag::set("power_on");
				function_842ad7f5(undefined, " ^5Dev: power turned on");
			}
			else if(dvar_value == "off" || dvar_value == "deactivate" || dvar_value == "0")
			{
				level flag::clear("power_on");
				level flag::set("power_off");
				level clientfield::set("zombie_power_off", 0);
				level notify("power_off");
				function_842ad7f5(undefined, " ^1Dev: power turned off");
			}
		}
	}
}

/*
	Name: function_fe3fe39b
	Namespace: namespace_b2e35c83
	Checksum: 0x424F4353
	Offset: 0xA4C0
	Size: 0xB8
	Parameters: 1
	Flags: None
	Line Number: 2613
*/
function function_fe3fe39b(var_34d37a48)
{
	function_8b57c052("print", "");
	for(;;)
	{
		wait(0.05);
		dvar_value = getdvarstring("print", "");
		if(isdefined(dvar_value) && dvar_value != "")
		{
			function_8b57c052("print", "");
			iprintlnbold(dvar_value);
		}
	}
}

/*
	Name: function_53447c0f
	Namespace: namespace_b2e35c83
	Checksum: 0x424F4353
	Offset: 0xA580
	Size: 0xB8
	Parameters: 1
	Flags: None
	Line Number: 2638
*/
function function_53447c0f(var_34d37a48)
{
	function_8b57c052("printsmall", "");
	for(;;)
	{
		wait(0.05);
		dvar_value = getdvarstring("printsmall", "");
		if(isdefined(dvar_value) && dvar_value != "")
		{
			function_8b57c052("printsmall", "");
			iprintln(dvar_value);
		}
	}
}

/*
	Name: function_c9542ee0
	Namespace: namespace_b2e35c83
	Checksum: 0x424F4353
	Offset: 0xA640
	Size: 0x1A8
	Parameters: 1
	Flags: None
	Line Number: 2663
*/
function function_c9542ee0(var_34d37a48)
{
	function_8b57c052("show_healthbar", "");
	for(;;)
	{
		wait(0.05);
		dvar_value = tolower(getdvarstring("show_healthbar", ""));
		if(isdefined(dvar_value) && dvar_value != "")
		{
			function_8b57c052("show_healthbar", "");
			if(dvar_value == "on" || dvar_value == "activate" || dvar_value == "1")
			{
				getplayers()[0] thread function_c3b27b45(1);
				function_842ad7f5(undefined, " ^5Dev: Show zombies Healthbar");
			}
			else if(dvar_value == "off" || dvar_value == "deactivate" || dvar_value == "0")
			{
				getplayers()[0] thread function_c3b27b45(0);
				function_842ad7f5(undefined, " ^5Dev: Hide zombies Healthbar");
			}
		}
	}
}

/*
	Name: function_c3b27b45
	Namespace: namespace_b2e35c83
	Checksum: 0x424F4353
	Offset: 0xA7F0
	Size: 0x210
	Parameters: 1
	Flags: Private
	Line Number: 2697
*/
function private function_c3b27b45(activate)
{
	self notify("end_zombie_healthbar" + self getentitynumber() + 1);
	self endon("end_zombie_healthbar" + self getentitynumber() + 1);
	if(isdefined(activate) && activate)
	{
		while(1)
		{
			lp = getplayers()[0];
			zombies = getaispeciesarray(level.zombie_team);
			if(isdefined(zombies))
			{
				foreach(zombie in zombies)
				{
					zombie zombie_healthbar(lp.origin, 360000);
				}
			}
			wait(0.05);
		}
	}
	foreach(zombie in getaiteamarray(level.zombie_team))
	{
		zombie clientfield::set("debug_zombie_enable_keyline", 0);
	}
	return;
	ERROR: Exception occured: Stack empty.
}

/*
	Name: zombie_healthbar
	Namespace: namespace_b2e35c83
	Checksum: 0x424F4353
	Offset: 0xAA08
	Size: 0x108
	Parameters: 2
	Flags: None
	Line Number: 2735
*/
function zombie_healthbar(pos, dsquared)
{
	/#
		if(distancesquared(pos, self.origin) > dsquared)
		{
			return;
		}
		rate = 1;
		if(isdefined(self.maxhealth))
		{
			rate = self.health / self.maxhealth;
		}
		color = (1 - rate, rate, 0);
		text = "Dev Block strings are not supported" + int(self.health);
		print3d(self.origin + VectorScale((0, 0, 1), 70), text, color, 1, 0.5, 1);
		return;
	#/
}

/*
	Name: function_109891a9
	Namespace: namespace_b2e35c83
	Checksum: 0x424F4353
	Offset: 0xAB18
	Size: 0x1A8
	Parameters: 1
	Flags: None
	Line Number: 2764
*/
function function_109891a9(var_34d37a48)
{
	function_8b57c052("show_zombies", "");
	for(;;)
	{
		wait(0.05);
		dvar_value = tolower(getdvarstring("show_zombies", ""));
		if(isdefined(dvar_value) && dvar_value != "")
		{
			function_8b57c052("show_zombies", "");
			if(dvar_value == "on" || dvar_value == "activate" || dvar_value == "1")
			{
				getplayers()[0] thread function_8ca7779f(1);
				function_842ad7f5(undefined, " ^5Dev: Show zombies outline through walls");
			}
			else if(dvar_value == "off" || dvar_value == "deactivate" || dvar_value == "0")
			{
				getplayers()[0] thread function_8ca7779f(0);
				function_842ad7f5(undefined, " ^5Dev: Hide zombies outline through walls");
			}
		}
	}
}

/*
	Name: function_8ca7779f
	Namespace: namespace_b2e35c83
	Checksum: 0x424F4353
	Offset: 0xACC8
	Size: 0x1D0
	Parameters: 1
	Flags: None
	Line Number: 2798
*/
function function_8ca7779f(activate)
{
	self notify("end_zombie_outlining" + self getentitynumber() + 1);
	self endon("end_zombie_outlining" + self getentitynumber() + 1);
	if(isdefined(activate) && activate)
	{
		for(;;)
		{
			foreach(zombie in getaiteamarray(level.zombie_team))
			{
				zombie clientfield::set("debug_zombie_enable_keyline", 1);
				zombie thread function_d312afc4();
			}
			wait(2);
		}
	}
	foreach(zombie in getaiteamarray(level.zombie_team))
	{
		zombie clientfield::set("debug_zombie_enable_keyline", 0);
	}
}

/*
	Name: function_d312afc4
	Namespace: namespace_b2e35c83
	Checksum: 0x424F4353
	Offset: 0xAEA0
	Size: 0x48
	Parameters: 0
	Flags: None
	Line Number: 2830
*/
function function_d312afc4()
{
	self util::waittill_any_return("death");
	self clientfield::set("debug_zombie_enable_keyline", 0);
}

/*
	Name: function_1a6da99d
	Namespace: namespace_b2e35c83
	Checksum: 0x424F4353
	Offset: 0xAEF0
	Size: 0x4A0
	Parameters: 1
	Flags: None
	Line Number: 2846
*/
function function_1a6da99d(var_34d37a48)
{
	function_8b57c052("outline", "");
	for(;;)
	{
		wait(0.05);
		dvar_value = tolower(getdvarstring("outline", ""));
		if(isdefined(dvar_value) && dvar_value != "")
		{
			function_8b57c052("outline", "");
			var_cde9f622 = strtok(dvar_value, " ");
			if(var_cde9f622.size > 2)
			{
				type = var_cde9f622[0];
				model_list = var_cde9f622[1];
				value = var_cde9f622[2];
				if(value == "on" || value == "activate" || value == "1")
				{
					if(type == "struct")
					{
						foreach(struct in struct::get_array(model_list))
						{
							struct.model clientfield::set("debug_enable_keyline", 1);
						}
					}
					else
					{
						foreach(model in getentarray(model_list, "targetname"))
						{
							model clientfield::set("debug_enable_keyline", 1);
						}
					}
					function_842ad7f5(undefined, " ^5Dev: Turned outline on for models: " + model_list);
				}
				else if(value == "off" || value == "deactivate" || value == "0")
				{
					if(type == "struct")
					{
						foreach(struct in struct::get_array(model_list))
						{
							struct.model clientfield::set("debug_enable_keyline", 0);
						}
					}
					else
					{
						foreach(model in getentarray(model_list, "targetname"))
						{
							model clientfield::set("debug_enable_keyline", 0);
						}
					}
					function_842ad7f5(undefined, " ^1Dev: Turned outline off for models: " + model_list);
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
	Offset: 0xB398
	Size: 0x288
	Parameters: 1
	Flags: None
	Line Number: 2917
*/
function function_27cdc982(var_34d37a48)
{
	function_8b57c052("perk", "");
	for(;;)
	{
		wait(0.05);
		dvar_value = tolower(getdvarstring("perk", ""));
		if(isdefined(dvar_value) && dvar_value != "")
		{
			function_8b57c052("perk", "");
			var_cde9f622 = strtok(dvar_value, " ");
			if(var_cde9f622.size > 1)
			{
				player_index = int(var_cde9f622[0]);
				perk = namespace_71d987dc::function_2f134368(var_cde9f622[1]);
				function_842ad7f5(level.players[player_index], "^5Dev: added " + var_cde9f622[1] + " perk to " + level.players[player_index].playername);
				if(player_index >= 0 && player_index <= 7)
				{
					level.players[player_index] function_1b77d2aa(perk);
				}
				else
				{
					array::thread_all(getplayers(), &function_1b77d2aa, perk);
				}
			}
			else
			{
				array::thread_all(getplayers(), &function_1b77d2aa, namespace_71d987dc::function_2f134368(var_cde9f622[0]));
				function_842ad7f5(undefined, "^5Dev: added " + var_cde9f622[0] + " perk to all players");
			}
		}
	}
}

/*
	Name: function_1ab1ece4
	Namespace: namespace_b2e35c83
	Checksum: 0x424F4353
	Offset: 0xB628
	Size: 0x280
	Parameters: 1
	Flags: None
	Line Number: 2961
*/
function function_1ab1ece4(var_34d37a48)
{
	function_8b57c052("take_perk", "");
	for(;;)
	{
		wait(0.05);
		dvar_value = tolower(getdvarstring("take_perk", ""));
		if(isdefined(dvar_value) && dvar_value != "")
		{
			function_8b57c052("take_perk", "");
			var_cde9f622 = strtok(dvar_value, " ");
			if(var_cde9f622.size > 1)
			{
				player_index = int(var_cde9f622[0]);
				value = var_cde9f622[1];
				perk = namespace_71d987dc::function_2f134368(value);
				function_842ad7f5(level.players[player_index], "^5Dev: taken " + perk + " perk from " + level.players[player_index].playername);
				if(player_index >= 0 && player_index <= 7)
				{
					level.players[player_index] function_2a988850(perk);
				}
				else
				{
					array::thread_all(getplayers(), &function_2a988850, perk);
				}
			}
			else
			{
				array::thread_all(getplayers(), &function_2a988850, var_cde9f622[0]);
				function_842ad7f5(undefined, "^5Dev: taken " + var_cde9f622[0] + " perk from all players");
			}
		}
	}
}

/*
	Name: function_93d18f76
	Namespace: namespace_b2e35c83
	Checksum: 0x424F4353
	Offset: 0xB8B0
	Size: 0xF0
	Parameters: 1
	Flags: None
	Line Number: 3006
*/
function function_93d18f76(var_34d37a48)
{
	function_8b57c052("next_round", "");
	for(;;)
	{
		wait(0.05);
		dvar_value = tolower(getdvarstring("next_round", ""));
		if(isdefined(dvar_value) && dvar_value != "")
		{
			function_8b57c052("next_round", "");
			thread function_2cce5cbc(level.round_number + 1);
			function_842ad7f5(undefined, " ^5Dev: Next round");
		}
	}
}

/*
	Name: function_f5efc0ba
	Namespace: namespace_b2e35c83
	Checksum: 0x424F4353
	Offset: 0xB9A8
	Size: 0xF0
	Parameters: 1
	Flags: None
	Line Number: 3032
*/
function function_f5efc0ba(var_34d37a48)
{
	function_8b57c052("previous_round", "");
	for(;;)
	{
		wait(0.05);
		dvar_value = tolower(getdvarstring("previous_round", ""));
		if(isdefined(dvar_value) && dvar_value != "")
		{
			function_8b57c052("previous_round", "");
			thread function_2cce5cbc(level.round_number - 1);
			function_842ad7f5(undefined, " ^5Dev: Previous round");
		}
	}
}

/*
	Name: function_67752f53
	Namespace: namespace_b2e35c83
	Checksum: 0x424F4353
	Offset: 0xBAA0
	Size: 0x1C0
	Parameters: 1
	Flags: None
	Line Number: 3058
*/
function function_67752f53(var_34d37a48)
{
	function_8b57c052("round", "");
	for(;;)
	{
		wait(0.05);
		dvar_value = tolower(getdvarstring("round", ""));
		if(isdefined(dvar_value) && dvar_value != "")
		{
			function_8b57c052("round", "");
			round = dvar_value;
			if(round == "next")
			{
				thread function_2cce5cbc(level.round_number + 1);
				function_842ad7f5(undefined, " ^5Dev: Changed round to " + round);
			}
			else if(round == "previous")
			{
				thread function_2cce5cbc(level.round_number - 1);
				function_842ad7f5(undefined, " ^5Dev: Changed round to " + round);
			}
			else
			{
				thread function_2cce5cbc(int(round));
				function_842ad7f5(undefined, " ^5Dev: Changed round to " + round);
			}
		}
	}
}

/*
	Name: function_d6fe1935
	Namespace: namespace_b2e35c83
	Checksum: 0x424F4353
	Offset: 0xBC68
	Size: 0x118
	Parameters: 1
	Flags: None
	Line Number: 3098
*/
function function_d6fe1935(var_34d37a48)
{
	function_8b57c052("doground", "");
	for(;;)
	{
		wait(0.05);
		dvar_value = tolower(getdvarstring("doground", ""));
		if(isdefined(dvar_value) && dvar_value != "")
		{
			function_8b57c052("doground", "");
			switch(dvar_value)
			{
				case "1":
				case "activate":
				case "on":
				{
					thread function_2cce5cbc(level.next_dog_round);
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
	Offset: 0xBD88
	Size: 0x5A8
	Parameters: 1
	Flags: None
	Line Number: 3133
*/
function function_ee09c1b8(var_34d37a48)
{
	function_8b57c052("powerup", "");
	for(;;)
	{
		wait(0.05);
		dvar_value = tolower(getdvarstring("powerup", ""));
		if(isdefined(dvar_value) && dvar_value != "")
		{
			function_8b57c052("powerup", "");
			var_cde9f622 = strtok(dvar_value, " ");
			if(var_cde9f622.size > 1)
			{
				player_index = int(var_cde9f622[0]);
				powerup_name = var_cde9f622[1];
				powerup = namespace_71d987dc::function_e350ab20(powerup_name);
				if(powerup != "all")
				{
					for(i = 0; i < level.zombie_powerup_array.size; i++)
					{
						if(level.zombie_powerup_array[i] == powerup)
						{
							level.zombie_powerup_index = i;
							found = 1;
							break;
						}
					}
				}
				else
				{
					found = 1;
				}
				if(!found)
				{
					function_842ad7f5(undefined, " ^1Dev: Powerup: " + powerup + " does not exist!");
				}
				function_842ad7f5(level.players[player_index], " ^5Dev: Spawned " + powerup + " powerup to " + level.players[player_index].playername);
				origin = level.players[player_index] function_c3ff634();
				level.players[player_index] function_a62cead3();
				level thread zm_powerups::specific_powerup_drop(powerup, origin, undefined, undefined, undefined, undefined, 0);
				origin = player function_c3ff634();
				player function_a62cead3();
				continue;
				level thread zm_powerups::specific_powerup_drop(powerup, origin, undefined, undefined, undefined, undefined, 0);
			}
			else
			{
				if(player_index >= 0 && player_index <= 7)
				{
					if(powerup == "all")
					{
					}
					else
					{
					}
				}
				else
				{
					foreach(player in getplayers())
					{
						if(powerup == "all")
						{
						}
					}
				}
				else
				{
					powerup = namespace_71d987dc::function_e350ab20(var_cde9f622[0]);
					if(powerup != "all")
					{
						for(i = 0; i < level.zombie_powerup_array.size; i++)
						{
							if(level.zombie_powerup_array[i] == powerup)
							{
								level.zombie_powerup_index = i;
								found = 1;
								break;
							}
						}
					}
					else
					{
						found = 1;
					}
					if(!found)
					{
						function_842ad7f5(undefined, " ^1Dev: Powerup: " + powerup + " does not exist!");
					}
					else
					{
						foreach(player in getplayers())
						{
							origin = player function_c3ff634();
							if(powerup == "all")
							{
								player function_a62cead3();
								continue;
							}
							level thread zm_powerups::specific_powerup_drop(powerup, origin, undefined, undefined, undefined, undefined, 0);
						}
						function_842ad7f5(undefined, " ^5Dev: Spawned " + powerup + " powerup to all players");
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
	Offset: 0xC338
	Size: 0x188
	Parameters: 0
	Flags: None
	Line Number: 3251
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
	Offset: 0xC4C8
	Size: 0x2E0
	Parameters: 1
	Flags: None
	Line Number: 3273
*/
function function_7f5d1f3d(var_34d37a48)
{
	function_8b57c052("upgrade_weapon", "none");
	for(;;)
	{
		wait(0.05);
		dvar_value = tolower(getdvarstring("upgrade_weapon", "none"));
		if(isdefined(dvar_value) && dvar_value != "none")
		{
			function_8b57c052("upgrade_weapon", "none");
			if(dvar_value == "")
			{
				foreach(player in getplayers())
				{
					player function_9c955ddd();
				}
			}
			var_cde9f622 = strtok(dvar_value, " ");
			if(var_cde9f622.size > 1)
			{
				player_index = int(var_cde9f622[0]);
				value = int(var_cde9f622[1]);
				function_842ad7f5(level.players[player_index], "^5Dev: upgraded weapon of " + level.players[player_index].playername);
				if(player_index >= 0 && player_index <= 7)
				{
					level.players[player_index] function_9c955ddd();
				}
				else
				{
					array::thread_all(getplayers(), &function_9c955ddd);
				}
			}
			else
			{
				array::thread_all(getplayers(), &function_9c955ddd);
				function_842ad7f5(undefined, "^5Dev: upgraded weapon of all players");
			}
		}
	}
}

/*
	Name: function_9c955ddd
	Namespace: namespace_b2e35c83
	Checksum: 0x424F4353
	Offset: 0xC7B0
	Size: 0x170
	Parameters: 0
	Flags: None
	Line Number: 3324
*/
function function_9c955ddd()
{
	weap = self getcurrentweapon();
	weapon = zm_weapons::get_upgrade_weapon(weap, 0);
	if(isdefined(level.aat_in_use) && level.aat_in_use)
	{
		self thread aat::acquire(weapon);
	}
	weapon.camo_index = self zm_weapons::get_pack_a_punch_weapon_options(weapon);
	self takeweapon(weap);
	self giveweapon(weapon, weapon.camo_index);
	if(self hasperk("specialty_extraammo"))
	{
		self givemaxammo(weapon);
	}
	else
	{
		self givestartammo(weapon);
	}
	self switchtoweapon(weapon);
	zm_utility::play_sound_at_pos("zmb_perks_packa_ready", self);
}

/*
	Name: function_d291348c
	Namespace: namespace_b2e35c83
	Checksum: 0x424F4353
	Offset: 0xC928
	Size: 0x268
	Parameters: 1
	Flags: None
	Line Number: 3357
*/
function function_d291348c(var_34d37a48)
{
	function_8b57c052("downgrade_weapon", "");
	for(;;)
	{
		wait(0.05);
		dvar_value = tolower(getdvarstring("downgrade_weapon", ""));
		if(isdefined(dvar_value) && dvar_value != "")
		{
			function_8b57c052("downgrade_weapon", "");
			var_cde9f622 = strtok(dvar_value, " ");
			if(var_cde9f622.size > 1)
			{
				player_index = int(var_cde9f622[0]);
				value = int(var_cde9f622[1]);
				function_842ad7f5(level.players[player_index], "^5Dev: Downgraded weapon of " + level.players[player_index].playername);
				if(player_index >= 0 && player_index <= 7)
				{
					level.players[player_index] function_ddf02bd7();
				}
				else
				{
					array::thread_all(getplayers(), &function_ddf02bd7);
				}
			}
			else
			{
				value = int(var_cde9f622[0]);
				array::thread_all(getplayers(), &function_ddf02bd7);
				function_842ad7f5(undefined, " ^5Dev: Downgraded all players' weapon");
			}
		}
	}
}

/*
	Name: function_b7729c82
	Namespace: namespace_b2e35c83
	Checksum: 0x424F4353
	Offset: 0xCB98
	Size: 0xE0
	Parameters: 1
	Flags: None
	Line Number: 3402
*/
function function_b7729c82(var_34d37a48)
{
	function_8b57c052("open", "");
	for(;;)
	{
		wait(0.05);
		dvar_value = tolower(getdvarstring("open", ""));
		if(isdefined(dvar_value) && dvar_value != "")
		{
			function_8b57c052("open", "");
			thread function_f247d197();
			function_842ad7f5(undefined, " ^5Dev: Opened all " + dvar_value);
		}
	}
}

/*
	Name: function_f247d197
	Namespace: namespace_b2e35c83
	Checksum: 0x424F4353
	Offset: 0xCC80
	Size: 0x448
	Parameters: 0
	Flags: None
	Line Number: 3428
*/
function function_f247d197()
{
	setdvar("zombie_unlock_all", 1);
	level flag::set("power_on");
	level clientfield::set("zombie_power_on", 0);
	power_trigs = getentarray("use_elec_switch", "targetname");
	foreach(trig in power_trigs)
	{
		if(isdefined(trig.script_int))
		{
			level flag::set("power_on" + trig.script_int);
			level clientfield::set("zombie_power_on", trig.script_int);
		}
	}
	zombie_doors = getentarray("zombie_door", "targetname");
	for(i = 0; i < zombie_doors.size; i++)
	{
		zombie_doors[i] notify("trigger", level.players[0]);
		if(isdefined(zombie_doors[i].power_door_ignore_flag_wait) && zombie_doors[i].power_door_ignore_flag_wait)
		{
			zombie_doors[i] notify("power_on");
		}
		wait(0.05);
	}
	zombie_airlock_doors = getentarray("zombie_airlock_buy", "targetname");
	for(i = 0; i < zombie_airlock_doors.size; i++)
	{
		zombie_airlock_doors[i] notify("trigger", level.players[0]);
		wait(0.05);
	}
	zombie_debris = getentarray("zombie_debris", "targetname");
	for(i = 0; i < zombie_debris.size; i++)
	{
		if(isdefined(zombie_debris[i]))
		{
			zombie_debris[i] notify("trigger", level.players[0]);
		}
		wait(0.05);
	}
	foreach(uts_craftable in level.a_uts_craftables)
	{
		player = getplayers()[0];
		player zm_craftables::player_finish_craftable(uts_craftable.craftableSpawn);
		if(isdefined(uts_craftable.craftablestub.onfullycrafted))
		{
			uts_craftable [[uts_craftable.craftablestub.onfullycrafted]]();
		}
	}
	level notify("open_sesame");
	wait(1);
	setdvar("zombie_unlock_all", 0);
}

/*
	Name: function_b5d953ca
	Namespace: namespace_b2e35c83
	Checksum: 0x424F4353
	Offset: 0xD0D0
	Size: 0x2A0
	Parameters: 1
	Flags: None
	Line Number: 3491
*/
function function_b5d953ca(var_34d37a48)
{
	origin = var_34d37a48["player"] function_31565f46();
	var_248bbf85 = [];
	if(isdefined(getentarray("zombie_debris", "targetname")[0]) || isdefined(getentarray("zombie_door", "targetname")[0]) || isdefined(getentarray("zombie_airlock_buy", "targetname")[0]))
	{
		potential_targets = [];
		if(getentarray("zombie_door", "targetname").size > 0)
		{
			potential_targets = arraycombine(potential_targets, getentarray("zombie_door", "targetname"), 0, 0);
		}
		if(getentarray("zombie_debris", "targetname").size > 0)
		{
			potential_targets = arraycombine(potential_targets, getentarray("zombie_debris", "targetname"), 0, 0);
		}
		if(getentarray("zombie_airlock_buy", "targetname").size > 0)
		{
			potential_targets = arraycombine(potential_targets, getentarray("zombie_airlock_buy", "targetname"), 0, 0);
		}
		wait(0.05);
		var_6f45c771 = arraysortclosest(potential_targets, origin);
		wait(0.05);
		var_6f45c771[0] notify("trigger", level.players[0]);
		if(isdefined(var_6f45c771[0].power_door_ignore_flag_wait) && var_6f45c771[0].power_door_ignore_flag_wait)
		{
			var_6f45c771[0] notify("power_on");
		}
	}
}

/*
	Name: function_31565f46
	Namespace: namespace_b2e35c83
	Checksum: 0x424F4353
	Offset: 0xD378
	Size: 0x220
	Parameters: 0
	Flags: None
	Line Number: 3531
*/
function function_31565f46()
{
	wait(0.05);
	start = self getweaponmuzzlepoint();
	forward_dir = self getweaponforwarddir();
	end = start + forward_dir * 5000;
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
		return trace["position"];
	}
}

/*
	Name: function_f23059d1
	Namespace: namespace_b2e35c83
	Checksum: 0x424F4353
	Offset: 0xD5A0
	Size: 0x1B8
	Parameters: 0
	Flags: None
	Line Number: 3563
*/
function function_f23059d1()
{
	function_8b57c052("difficulty", "");
	for(;;)
	{
		wait(0.05);
		dvar_value = tolower(getdvarstring("difficulty", ""));
		if(isdefined(dvar_value) && dvar_value != "")
		{
			function_8b57c052("difficulty", "");
			var_b98e93fb = int(dvar_value);
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
			thread function_2cce5cbc(level.round_number);
			function_842ad7f5(undefined, " ^5Dev: Changed difficulty to " + var_b98e93fb);
		}
	}
}

/*
	Name: function_22ac2766
	Namespace: namespace_b2e35c83
	Checksum: 0x424F4353
	Offset: 0xD760
	Size: 0x80
	Parameters: 3
	Flags: None
	Line Number: 3613
*/
function function_22ac2766(multiplier, var_87c4fb18, DOG_HEALTH)
{
	zombie_utility::set_zombie_var("zombie_move_speed_multiplier", multiplier, 0);
	zombie_utility::set_zombie_var("zombie_move_speed_multiplier_easy", multiplier, 0);
	level.zombie_actor_limit = var_87c4fb18;
	level.zombie_ai_limit = var_87c4fb18;
	level.DOG_HEALTH = DOG_HEALTH;
}

/*
	Name: function_9f54f1b9
	Namespace: namespace_b2e35c83
	Checksum: 0x424F4353
	Offset: 0xD7E8
	Size: 0x2D8
	Parameters: 1
	Flags: None
	Line Number: 3632
*/
function function_9f54f1b9(var_34d37a48)
{
	function_8b57c052("notify", "");
	for(;;)
	{
		wait(0.05);
		dvar_value = tolower(getdvarstring("notify", ""));
		if(isdefined(dvar_value) && dvar_value != "")
		{
			function_8b57c052("notify", "");
			var_cde9f622 = strtok(dvar_value, " ");
			if(var_cde9f622.size > 1)
			{
				target = int(var_cde9f622[0]);
				value = int(var_cde9f622[1]);
				if(var_cde9f622.size > 2)
				{
					value2 = int(var_cde9f622[2]);
					foreach(targ in getentarray(target, "targetname"))
					{
						targ notify(value, value2);
					}
				}
				else
				{
					foreach(targ in getentarray(target, "targetname"))
					{
						targ notify(value);
					}
				}
			}
			else
			{
				value = int(var_cde9f622[0]);
				level notify(value);
			}
			function_842ad7f5(undefined, " ^1Dev: Turned spawning off");
		}
	}
}

/*
	Name: function_b2ec648e
	Namespace: namespace_b2e35c83
	Checksum: 0x424F4353
	Offset: 0xDAC8
	Size: 0x240
	Parameters: 1
	Flags: None
	Line Number: 3683
*/
function function_b2ec648e(var_34d37a48)
{
	function_8b57c052("flag", "");
	for(;;)
	{
		wait(0.05);
		dvar_value = tolower(getdvarstring("flag", ""));
		if(isdefined(dvar_value) && dvar_value != "")
		{
			function_8b57c052("flag", "");
			var_cde9f622 = strtok(dvar_value, " ");
			if(var_cde9f622.size > 1)
			{
				target = int(var_cde9f622[0]);
				value = int(var_cde9f622[1]);
				foreach(targ in getentarray(target, "targetname"))
				{
					targ flag::set(value);
				}
			}
			else
			{
				value = int(var_cde9f622[0]);
				level flag::set(value);
			}
			function_842ad7f5(undefined, " ^1Dev: Turned spawning off");
		}
	}
}

/*
	Name: function_fe46f128
	Namespace: namespace_b2e35c83
	Checksum: 0x424F4353
	Offset: 0xDD10
	Size: 0x238
	Parameters: 1
	Flags: None
	Line Number: 3723
*/
function function_fe46f128(var_34d37a48)
{
	function_8b57c052("play", "");
	for(;;)
	{
		wait(0.05);
		dvar_value = tolower(getdvarstring("play", ""));
		if(isdefined(dvar_value) && dvar_value != "")
		{
			function_8b57c052("play", "");
			alias = dvar_value;
			time = soundgetplaybacktime(alias) * 0.001;
			foreach(player in getplayers())
			{
				player playsoundtoplayer(alias, player);
			}
			wait(time);
			foreach(player in getplayers())
			{
				player stopsounds();
			}
			function_842ad7f5(undefined, " ^1Dev: Played sound: " + alias);
		}
	}
}

/*
	Name: function_75fbf4d7
	Namespace: namespace_b2e35c83
	Checksum: 0x424F4353
	Offset: 0xDF50
	Size: 0x318
	Parameters: 1
	Flags: None
	Line Number: 3759
*/
function function_75fbf4d7(var_34d37a48)
{
	function_8b57c052("stop", "");
	for(;;)
	{
		wait(0.05);
		dvar_value = tolower(getdvarstring("stop", ""));
		if(isdefined(dvar_value) && dvar_value != "")
		{
			function_8b57c052("stop", "");
			var_cde9f622 = strtok(dvar_value, " ");
			if(var_cde9f622.size > 1)
			{
				player_index = int(var_cde9f622[0]);
				value = int(var_cde9f622[1]);
				function_842ad7f5(level.players[player_index], "^5Dev: Stopped all sounds from playing on player: " + level.players[player_index].playername);
				if(player_index >= 0 && player_index <= 7)
				{
					level.players[player_index] stopsounds();
				}
				else
				{
					foreach(player in getplayers())
					{
						player stopsounds();
					}
				}
			}
			else
			{
				value = int(var_cde9f622[0]);
				foreach(player in getplayers())
				{
					player stopsounds();
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
	Offset: 0xE270
	Size: 0x608
	Parameters: 0
	Flags: None
	Line Number: 3810
*/
function function_6ccccad6()
{
	function_8b57c052("aimbot", "");
	for(;;)
	{
		wait(0.05);
		dvar_value = tolower(getdvarstring("aimbot", ""));
		if(isdefined(dvar_value) && dvar_value != "")
		{
			function_8b57c052("aimbot", "");
			var_cde9f622 = strtok(dvar_value, " ");
			if(var_cde9f622.size > 1)
			{
				player_index = int(var_cde9f622[0]);
				value = int(var_cde9f622[1]);
				if(dvar_value == "on" || dvar_value == "activate" || dvar_value == "1")
				{
					if(player_index >= 0 && player_index <= 7)
					{
						level.players[player_index] thread function_95700477(1);
					}
					else
					{
						foreach(e_player in getplayers())
						{
							e_player thread function_95700477(1);
						}
					}
					function_842ad7f5(level.players[player_index], "^5Dev: Activated aimbot to " + level.players[player_index].playername);
				}
				else if(dvar_value == "off" || dvar_value == "deactivate" || dvar_value == "0")
				{
					if(player_index >= 0 && player_index <= 7)
					{
						level.players[player_index] thread function_95700477(0);
					}
					else
					{
						foreach(e_player in getplayers())
						{
							e_player thread function_95700477(0);
						}
					}
					function_842ad7f5(level.players[player_index], "^5Dev: Deactivated aimbot to " + level.players[player_index].playername);
				}
			}
			else
			{
				value = int(var_cde9f622[0]);
				if(dvar_value == "on" || dvar_value == "activate" || dvar_value == "1")
				{
					foreach(e_player in getplayers())
					{
						e_player thread function_95700477(1);
					}
					function_842ad7f5(level.players[player_index], "^5Dev: Activated aimbot to " + level.players[player_index].playername);
				}
				else if(dvar_value == "off" || dvar_value == "deactivate" || dvar_value == "0")
				{
					foreach(e_player in getplayers())
					{
						e_player thread function_95700477(0);
					}
					function_842ad7f5(level.players[player_index], "^5Dev: Deactivated aimbot to " + level.players[player_index].playername);
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
	Offset: 0xE880
	Size: 0x250
	Parameters: 1
	Flags: None
	Line Number: 3891
*/
function function_95700477(activate)
{
	self notify("stop_aimbot" + self getentitynumber() + 1);
	self endon("stop_aimbot" + self getentitynumber() + 1);
	if(isdefined(activate) && activate)
	{
		while(self playerads() >= 0.3)
		{
			var_30f6d9cd = array();
			foreach(enemy in getaiteamarray(level.zombie_team))
			{
				if(enemy cansee(self))
				{
					if(!isdefined(var_30f6d9cd))
					{
						var_30f6d9cd = [];
					}
					else if(!isarray(var_30f6d9cd))
					{
						var_30f6d9cd = array(var_30f6d9cd);
					}
					var_30f6d9cd[var_30f6d9cd.size] = enemy;
				}
			}
			var_619885ab = arraygetclosest(self.origin, var_30f6d9cd);
			self setplayerangles(vectortoangles(var_619885ab gettagorigin("j_head") - self geteye()));
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
	Offset: 0xEAD8
	Size: 0xE0
	Parameters: 0
	Flags: None
	Line Number: 3935
*/
function function_ddf02bd7()
{
	weap = self getcurrentweapon();
	weapon = zm_weapons::get_base_weapon(weap);
	self takeweapon(weap);
	self giveweapon(weapon, self zm_weapons::get_pack_a_punch_weapon_options(weapon));
	self givestartammo(weapon);
	self switchtoweapon(weapon);
	zm_utility::play_sound_at_pos("zmb_perks_packa_ready", self);
}

/*
	Name: function_c3ff634
	Namespace: namespace_b2e35c83
	Checksum: 0x424F4353
	Offset: 0xEBC0
	Size: 0x100
	Parameters: 0
	Flags: None
	Line Number: 3956
*/
function function_c3ff634()
{
	direction = self getplayerangles();
	direction_vec = anglestoforward(direction);
	eye = self geteye();
	scale = 8000;
	direction_vec = (direction_vec[0] * scale, direction_vec[1] * scale, direction_vec[2] * scale);
	trace = bullettrace(eye, eye + direction_vec, 0, undefined);
	final_pos = trace["position"];
	return final_pos;
	ERROR: Exception occured: Stack empty.
}

/*
	Name: function_2cce5cbc
	Namespace: namespace_b2e35c83
	Checksum: 0x424F4353
	Offset: 0xECC8
	Size: 0x210
	Parameters: 1
	Flags: None
	Line Number: 3979
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

/*
	Name: function_1b77d2aa
	Namespace: namespace_b2e35c83
	Checksum: 0x424F4353
	Offset: 0xEEE0
	Size: 0x250
	Parameters: 1
	Flags: None
	Line Number: 4033
*/
function function_1b77d2aa(perk)
{
	vending_triggers = getentarray("zombie_vending", "targetname");
	if(vending_triggers.size < 1)
	{
		function_842ad7f5(self, " ^1Dev: No perk machines found in map");
		return;
	}
	if(perk == "all")
	{
		foreach(var_3a51e779 in getarraykeys(level._custom_perks))
		{
			self zm_perks::give_perk(var_3a51e779, 0);
			wait(0.5);
		}
	}
	else if(StrEndsWith(perk, ";"))
	{
		var_cde9f622 = strtok(perk, " ");
		for(i = 0; i < var_cde9f622.size; i++)
		{
			self zm_perks::give_perk(var_cde9f622[i], 0);
		}
	}
	else if(StrIsInt(perk))
	{
		perk = int(perk);
		for(i = 0; i < perk; i++)
		{
			self zm_perks::give_random_perk();
		}
	}
	else
	{
		self zm_perks::give_perk(perk, 0);
	}
}

/*
	Name: function_2a988850
	Namespace: namespace_b2e35c83
	Checksum: 0x424F4353
	Offset: 0xF138
	Size: 0x190
	Parameters: 1
	Flags: None
	Line Number: 4081
*/
function function_2a988850(perk)
{
	if(self.perks_active.size < 1)
	{
		function_842ad7f5(self, " ^1Dev: Player has no active perks");
		return;
	}
	perks = self.perks_active;
	if(perk == "all")
	{
		foreach(var_3a51e779 in perks)
		{
			self function_c65ada05(var_3a51e779);
			wait(1);
		}
	}
	else if(StrIsInt(perk))
	{
		perk = int(perk);
		for(i = 0; i < perk; i++)
		{
			self zm_perks::lose_random_perk();
			wait(1);
		}
	}
	else
	{
		self function_c65ada05(perk);
	}
}

/*
	Name: function_842ad7f5
	Namespace: namespace_b2e35c83
	Checksum: 0x424F4353
	Offset: 0xF2D0
	Size: 0xF0
	Parameters: 2
	Flags: None
	Line Number: 4122
*/
function function_842ad7f5(player, message)
{
	if(isdefined(player))
	{
		player util::setclientsysstate("subtitleMessage", message, player);
	}
	else
	{
		foreach(var_2d4cbd56 in getplayers())
		{
			var_2d4cbd56 util::setclientsysstate("subtitleMessage", message, var_2d4cbd56);
		}
	}
}

/*
	Name: function_c65ada05
	Namespace: namespace_b2e35c83
	Checksum: 0x424F4353
	Offset: 0xF3C8
	Size: 0x60
	Parameters: 1
	Flags: None
	Line Number: 4147
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
	Namespace: namespace_b2e35c83
	Checksum: 0x424F4353
	Offset: 0xF430
	Size: 0x90
	Parameters: 0
	Flags: None
	Line Number: 4167
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
	Name: function_957b7937
	Namespace: namespace_b2e35c83
	Checksum: 0x424F4353
	Offset: 0xF4C8
	Size: 0xC0
	Parameters: 1
	Flags: None
	Line Number: 4193
*/
function function_957b7937(message)
{
	if(!isdefined(message))
	{
		message = "No Message";
	}
	if(!level flag::get("full_silent_dev"))
	{
		if(level flag::get("silent_dev"))
		{
			level.players[0] iprintln("^8[DEV Command]^7 " + message);
		}
		else
		{
			iprintln("^8[DEV Command]^7 " + message);
		}
	}
}

/*
	Name: adjustplayersword
	Namespace: namespace_b2e35c83
	Checksum: 0x424F4353
	Offset: 0xF590
	Size: 0x2D0
	Parameters: 3
	Flags: None
	Line Number: 4222
*/
function adjustplayersword(player, type, noprint)
{
	if(!isdefined(noprint))
	{
		noprint = 0;
	}
	if(!isdefined(level.var_15954023.weapons))
	{
		level.var_15954023.weapons = [];
	}
	if(!isdefined(level.var_15954023.weapons[player.originalindex]))
	{
		return;
	}
	weapon = level.var_15954023.weapons[player.originalindex][1];
	switch(type)
	{
		case "Normal":
		{
			weapon = level.var_15954023.weapons[player.originalindex][1];
			break;
		}
		case "Upgraded":
		{
			weapon = level.var_15954023.weapons[player.originalindex][2];
			break;
		}
		default
		{
			player takeweapon(level.var_15954023.weapons[player.originalindex][1]);
			player takeweapon(level.var_15954023.weapons[player.originalindex][2]);
			if(!noprint)
			{
				self iprintlnbold("Sword Updated");
				return;
			}
		}
	}
	player.sword_power = 1;
	player notify("hash_2089e51");
	if(isdefined(player.var_c0d25105))
	{
		player.var_c0d25105 notify("returned_to_owner");
	}
	player.var_86a785ad = 1;
	player notify("hash_2089e51");
	player zm_weapons::weapon_give(weapon, 0, 0, 1);
	player gadgetpowerset(0, 100);
	player.current_sword = player.current_hero_weapon;
	if(!noprint)
	{
		self iprintlnbold("Sword Updated");
	}
}

/*
	Name: finishbossfight
	Namespace: namespace_b2e35c83
	Checksum: 0x424F4353
	Offset: 0xF868
	Size: 0x19A
	Parameters: 0
	Flags: None
	Line Number: 4287
*/
function finishbossfight()
{
	level flag::set("ee_boss_defeated");
	level notify("hash_e0eab469");
	level notify("hash_83bb0170");
	if(isdefined(level.var_dbc3a0ef) && isdefined(level.var_dbc3a0ef.var_93dad597))
	{
		level.var_dbc3a0ef.var_93dad597 delete();
	}
	foreach(person in array("boxer", "detective", "femme", "magician"))
	{
		if(isdefined(level.var_f86952c7["boss_1_" + person]))
		{
			zm_unitrigger::unregister_unitrigger(level.var_f86952c7["boss_1_" + person]);
		}
		level clientfield::set("ee_keeper_" + person + "_state", 7);
		wait(0.1);
	}
}

