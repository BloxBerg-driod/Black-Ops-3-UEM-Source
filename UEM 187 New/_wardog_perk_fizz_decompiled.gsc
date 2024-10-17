#include scripts\codescripts\struct;
#include scripts\shared\ai\zombie_utility;
#include scripts\shared\array_shared;
#include scripts\shared\callbacks_shared;
#include scripts\shared\clientfield_shared;
#include scripts\shared\flag_shared;
#include scripts\shared\laststand_shared;
#include scripts\shared\math_shared;
#include scripts\shared\util_shared;
#include scripts\shared\visionset_mgr_shared;
#include scripts\zm\_zm_audio;
#include scripts\zm\_zm_equipment;
#include scripts\zm\_zm_pack_a_punch_util;
#include scripts\zm\_zm_perks;
#include scripts\zm\_zm_power;
#include scripts\zm\_zm_score;
#include scripts\zm\_zm_spawner;
#include scripts\zm\_zm_stats;
#include scripts\zm\_zm_unitrigger;
#include scripts\zm\_zm_utility;
#include scripts\zm\_zm_zonemgr;

#namespace namespace_298acf2c;

/*
	Name: main
	Namespace: namespace_298acf2c
	Checksum: 0x424F4353
	Offset: 0x320
	Size: 0x24
	Parameters: 0
	Flags: AutoExec
	Line Number: 34
*/
function autoexec main()
{
	level flag::init("machine_can_reset");
}

