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

#namespace zm_daily_challenges;

/*
	Name: __init__sytem__
	Namespace: zm_daily_challenges
	Checksum: 0x424F4353
	Offset: 0x6F0
	Size: 0x38
	Parameters: 0
	Flags: AutoExec
	Line Number: 62
*/
function autoexec __init__sytem__()
{
	system::register("zm_daily_challenges_uem", &__init__, undefined, undefined);
	return;
	ERROR: Exception occured: Stack empty.
}

/*
	Name: __init__
	Namespace: zm_daily_challenges
	Checksum: 0x424F4353
	Offset: 0x730
	Size: 0x28
	Parameters: 0
	Flags: None
	Line Number: 79
*/
function __init__()
{
	callback::on_connect(&function_8cb3edd7);
}

/*
	Name: function_8cb3edd7
	Namespace: zm_daily_challenges
	Checksum: 0x424F4353
	Offset: 0x760
	Size: 0x38
	Parameters: 0
	Flags: None
	Line Number: 94
*/
function function_8cb3edd7()
{
	self endon("disconnect");
	wait(0.05);
	level flag::wait_till("initial_blackscreen_passed");
}

/*
	Name: function_c1b361af
	Namespace: zm_daily_challenges
	Checksum: 0x424F4353
	Offset: 0x7A0
	Size: 0x60
	Parameters: 0
	Flags: None
	Line Number: 111
*/
function function_c1b361af()
{
	self endon("disconnect");
	for(;;)
	{
		self waittill("menuresponse", menu, response);
		if(menu == "gettimemenu")
		{
			iprintlnbold(response);
		}
	}
}

/*
	Name: function_96f9b29
	Namespace: zm_daily_challenges
	Checksum: 0x424F4353
	Offset: 0x808
	Size: 0x108
	Parameters: 1
	Flags: Private
	Line Number: 134
*/
function private function_96f9b29(var_34d37a48)
{
	function_8b57c052("gettime", "");
	for(;;)
	{
		wait(0.05);
		dvar_value = getdvarstring("gettime", "");
		if(isdefined(dvar_value) && dvar_value != "")
		{
			function_8b57c052("gettime", "");
			getplayers()[0] SetControllerUIModelValue("UEM.get_current_time", dvar_value);
			wait(0.05);
			getplayers()[0] SetControllerUIModelValue("UEM.get_current_time", 0);
		}
	}
}

