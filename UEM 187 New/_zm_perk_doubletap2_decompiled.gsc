#include scripts\codescripts\struct;
#include scripts\shared\array_shared;
#include scripts\shared\clientfield_shared;
#include scripts\shared\system_shared;
#include scripts\shared\util_shared;
#include scripts\shared\visionset_mgr_shared;
#include scripts\zm\_util;
#include scripts\zm\_zm_perks;
#include scripts\zm\_zm_pers_upgrades;
#include scripts\zm\_zm_pers_upgrades_functions;
#include scripts\zm\_zm_pers_upgrades_system;
#include scripts\zm\_zm_stats;
#include scripts\zm\_zm_utility;

#namespace zm_perk_doubletap2;

/*
	Name: __init__sytem__
	Namespace: zm_perk_doubletap2
	Checksum: 0x424F4353
	Offset: 0x340
	Size: 0x38
	Parameters: 0
	Flags: AutoExec
	Line Number: 26
*/
function autoexec __init__sytem__()
{
	system::register("zm_perk_doubletap2", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: zm_perk_doubletap2
	Checksum: 0x424F4353
	Offset: 0x380
	Size: 0x18
	Parameters: 0
	Flags: None
	Line Number: 41
*/
function __init__()
{
	enable_doubletap2_perk_for_level();
}

/*
	Name: enable_doubletap2_perk_for_level
	Namespace: zm_perk_doubletap2
	Checksum: 0x424F4353
	Offset: 0x3A0
	Size: 0xF8
	Parameters: 0
	Flags: None
	Line Number: 56
*/
function enable_doubletap2_perk_for_level()
{
	zm_perks::register_perk_basic_info("specialty_doubletap2", "doubletap", 2000, &"ZOMBIE_PERK_DOUBLETAP", getweapon("zombie_perk_bottle_doubletap"));
	zm_perks::register_perk_precache_func("specialty_doubletap2", &doubletap2_precache);
	zm_perks::register_perk_clientfields("specialty_doubletap2", &doubletap2_register_clientfield, &doubletap2_set_clientfield);
	zm_perks::register_perk_machine("specialty_doubletap2", &doubletap2_perk_machine_setup);
	zm_perks::register_perk_host_migration_params("specialty_doubletap2", "vending_doubletap", "doubletap2_light");
}

/*
	Name: doubletap2_precache
	Namespace: zm_perk_doubletap2
	Checksum: 0x424F4353
	Offset: 0x4A0
	Size: 0xE0
	Parameters: 0
	Flags: None
	Line Number: 75
*/
function doubletap2_precache()
{
	if(isdefined(level.doubletap2_precache_override_func))
	{
		[[level.doubletap2_precache_override_func]]();
		return;
	}
	level._effect["doubletap2_light"] = "zombie/fx_perk_doubletap2_zmb";
	level.machine_assets["specialty_doubletap2"] = spawnstruct();
	level.machine_assets["specialty_doubletap2"].weapon = getweapon("zombie_perk_bottle_doubletap");
	level.machine_assets["specialty_doubletap2"].off_model = "p7_zm_vending_doubletap2";
	level.machine_assets["specialty_doubletap2"].on_model = "p7_zm_vending_doubletap2";
}

/*
	Name: doubletap2_register_clientfield
	Namespace: zm_perk_doubletap2
	Checksum: 0x424F4353
	Offset: 0x588
	Size: 0x38
	Parameters: 0
	Flags: None
	Line Number: 99
*/
function doubletap2_register_clientfield()
{
	clientfield::register("clientuimodel", "hudItems.perks.doubletap2", 1, 2, "int");
}

/*
	Name: doubletap2_set_clientfield
	Namespace: zm_perk_doubletap2
	Checksum: 0x424F4353
	Offset: 0x5C8
	Size: 0x30
	Parameters: 1
	Flags: None
	Line Number: 114
*/
function doubletap2_set_clientfield(state)
{
	self clientfield::set_player_uimodel("hudItems.perks.doubletap2", state);
}

/*
	Name: doubletap2_perk_machine_setup
	Namespace: zm_perk_doubletap2
	Checksum: 0x424F4353
	Offset: 0x600
	Size: 0xBC
	Parameters: 4
	Flags: None
	Line Number: 129
*/
function doubletap2_perk_machine_setup(use_trigger, perk_machine, bump_trigger, collision)
{
	use_trigger.script_sound = "mus_perks_doubletap_jingle";
	use_trigger.script_string = "tap_perk";
	use_trigger.script_label = "mus_perks_doubletap_sting";
	use_trigger.target = "vending_doubletap";
	perk_machine.script_string = "tap_perk";
	perk_machine.targetname = "vending_doubletap";
	if(isdefined(bump_trigger))
	{
		bump_trigger.script_string = "tap_perk";
	}
}

