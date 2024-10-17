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

#namespace zm_perk_staminup;

/*
	Name: __init__sytem__
	Namespace: zm_perk_staminup
	Checksum: 0x424F4353
	Offset: 0x330
	Size: 0x38
	Parameters: 0
	Flags: AutoExec
	Line Number: 26
*/
function autoexec __init__sytem__()
{
	system::register("zm_perk_staminup", &__init__, undefined, undefined);
	return;
	ERROR: Exception occured: Stack empty.
	waittillframeend;
}

/*
	Name: __init__
	Namespace: zm_perk_staminup
	Checksum: 0x424F4353
	Offset: 0x370
	Size: 0x18
	Parameters: 0
	Flags: None
	Line Number: 44
*/
function __init__()
{
	enable_staminup_perk_for_level();
}

/*
	Name: enable_staminup_perk_for_level
	Namespace: zm_perk_staminup
	Checksum: 0x424F4353
	Offset: 0x390
	Size: 0xF8
	Parameters: 0
	Flags: None
	Line Number: 59
*/
function enable_staminup_perk_for_level()
{
	zm_perks::register_perk_basic_info("specialty_staminup", "marathon", 2000, &"ZOMBIE_PERK_MARATHON", getweapon("zombie_perk_bottle_marathon"));
	zm_perks::register_perk_precache_func("specialty_staminup", &staminup_precache);
	zm_perks::register_perk_clientfields("specialty_staminup", &staminup_register_clientfield, &staminup_set_clientfield);
	zm_perks::register_perk_machine("specialty_staminup", &staminup_perk_machine_setup);
	zm_perks::register_perk_host_migration_params("specialty_staminup", "vending_marathon", "marathon_light");
}

/*
	Name: staminup_precache
	Namespace: zm_perk_staminup
	Checksum: 0x424F4353
	Offset: 0x490
	Size: 0xE0
	Parameters: 0
	Flags: None
	Line Number: 78
*/
function staminup_precache()
{
	if(isdefined(level.staminup_precache_override_func))
	{
		[[level.staminup_precache_override_func]]();
		return;
	}
	level._effect["marathon_light"] = "zombie/fx_perk_stamin_up_zmb";
	level.machine_assets["specialty_staminup"] = spawnstruct();
	level.machine_assets["specialty_staminup"].weapon = getweapon("zombie_perk_bottle_marathon");
	level.machine_assets["specialty_staminup"].off_model = "p7_zm_vending_marathon";
	level.machine_assets["specialty_staminup"].on_model = "p7_zm_vending_marathon";
}

/*
	Name: staminup_register_clientfield
	Namespace: zm_perk_staminup
	Checksum: 0x424F4353
	Offset: 0x578
	Size: 0x38
	Parameters: 0
	Flags: None
	Line Number: 102
*/
function staminup_register_clientfield()
{
	clientfield::register("clientuimodel", "hudItems.perks.marathon", 1, 2, "int");
}

/*
	Name: staminup_set_clientfield
	Namespace: zm_perk_staminup
	Checksum: 0x424F4353
	Offset: 0x5B8
	Size: 0x30
	Parameters: 1
	Flags: None
	Line Number: 117
*/
function staminup_set_clientfield(state)
{
	self clientfield::set_player_uimodel("hudItems.perks.marathon", state);
}

/*
	Name: staminup_perk_machine_setup
	Namespace: zm_perk_staminup
	Checksum: 0x424F4353
	Offset: 0x5F0
	Size: 0xBC
	Parameters: 4
	Flags: None
	Line Number: 132
*/
function staminup_perk_machine_setup(use_trigger, perk_machine, bump_trigger, collision)
{
	use_trigger.script_sound = "mus_perks_stamin_jingle";
	use_trigger.script_string = "marathon_perk";
	use_trigger.script_label = "mus_perks_stamin_sting";
	use_trigger.target = "vending_marathon";
	perk_machine.script_string = "marathon_perk";
	perk_machine.targetname = "vending_marathon";
	if(isdefined(bump_trigger))
	{
		bump_trigger.script_string = "marathon_perk";
	}
}

