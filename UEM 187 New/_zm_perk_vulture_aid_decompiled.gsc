#include scripts\codescripts\struct;
#include scripts\shared\array_shared;
#include scripts\shared\callbacks_shared;
#include scripts\shared\clientfield_shared;
#include scripts\shared\laststand_shared;
#include scripts\shared\system_shared;
#include scripts\shared\util_shared;
#include scripts\zm\_zm;
#include scripts\zm\_zm_laststand;
#include scripts\zm\_zm_perks;
#include scripts\zm\_zm_score;
#include scripts\zm\_zm_spawner;
#include scripts\zm\_zm_utility;
#include scripts\zm\gametypes\_globallogic_score;

#namespace namespace_d7595b00;

/*
	Name: __init__sytem__
	Namespace: namespace_d7595b00
	Checksum: 0x424F4353
	Offset: 0x240
	Size: 0x40
	Parameters: 0
	Flags: AutoExec
	Line Number: 27
*/
function autoexec __init__sytem__()
{
	system::register("zm_perk_vulture_aid", &__init__, &__main__, undefined);
}

/*
	Name: __init__
	Namespace: namespace_d7595b00
	Checksum: 0x424F4353
	Offset: 0x288
	Size: 0x8
	Parameters: 0
	Flags: None
	Line Number: 42
*/
function __init__()
{
}

/*
	Name: __main__
	Namespace: namespace_d7595b00
	Checksum: 0x424F4353
	Offset: 0x298
	Size: 0x4
	Parameters: 0
	Flags: None
	Line Number: 56
*/
function __main__()
{
}

