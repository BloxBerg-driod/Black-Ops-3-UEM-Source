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

#namespace zm_perk_deadshot;

/*
	Name: __init__sytem__
	Namespace: zm_perk_deadshot
	Checksum: 0x424F4353
	Offset: 0x350
	Size: 0x38
	Parameters: 0
	Flags: AutoExec
	Line Number: 26
*/
function autoexec __init__sytem__()
{
	system::register("zm_perk_deadshot", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: zm_perk_deadshot
	Checksum: 0x424F4353
	Offset: 0x390
	Size: 0x18
	Parameters: 0
	Flags: None
	Line Number: 41
*/
function __init__()
{
	enable_deadshot_perk_for_level();
}

/*
	Name: enable_deadshot_perk_for_level
	Namespace: zm_perk_deadshot
	Checksum: 0x424F4353
	Offset: 0x3B0
	Size: 0x130
	Parameters: 0
	Flags: None
	Line Number: 56
*/
function enable_deadshot_perk_for_level()
{
	zm_perks::register_perk_basic_info("specialty_deadshot", "deadshot", 1500, &"ZOMBIE_PERK_DEADSHOT", getweapon("zombie_perk_bottle_deadshot"));
	zm_perks::register_perk_precache_func("specialty_deadshot", &deadshot_precache);
	zm_perks::register_perk_clientfields("specialty_deadshot", &deadshot_register_clientfield, &deadshot_set_clientfield);
	zm_perks::register_perk_machine("specialty_deadshot", &deadshot_perk_machine_setup);
	zm_perks::register_perk_threads("specialty_deadshot", &give_deadshot_perk, &take_deadshot_perk);
	zm_perks::register_perk_host_migration_params("specialty_deadshot", "vending_deadshot", "deadshot_light");
}

/*
	Name: deadshot_precache
	Namespace: zm_perk_deadshot
	Checksum: 0x424F4353
	Offset: 0x4E8
	Size: 0xE0
	Parameters: 0
	Flags: None
	Line Number: 76
*/
function deadshot_precache()
{
	if(isdefined(level.deadshot_precache_override_func))
	{
		[[level.deadshot_precache_override_func]]();
		return;
	}
	level._effect["deadshot_light"] = "_t6/misc/fx_zombie_cola_dtap_on";
	level.machine_assets["specialty_deadshot"] = spawnstruct();
	level.machine_assets["specialty_deadshot"].weapon = getweapon("zombie_perk_bottle_deadshot");
	level.machine_assets["specialty_deadshot"].off_model = "p7_zm_vending_ads";
	level.machine_assets["specialty_deadshot"].on_model = "p7_zm_vending_ads";
}

/*
	Name: deadshot_register_clientfield
	Namespace: zm_perk_deadshot
	Checksum: 0x424F4353
	Offset: 0x5D0
	Size: 0x68
	Parameters: 0
	Flags: None
	Line Number: 100
*/
function deadshot_register_clientfield()
{
	clientfield::register("toplayer", "deadshot_perk", 1, 1, "int");
	clientfield::register("clientuimodel", "hudItems.perks.dead_shot", 1, 2, "int");
	return;
	ERROR: Bad function call
}

/*
	Name: deadshot_set_clientfield
	Namespace: zm_perk_deadshot
	Checksum: 0x424F4353
	Offset: 0x640
	Size: 0x30
	Parameters: 1
	Flags: None
	Line Number: 118
*/
function deadshot_set_clientfield(state)
{
	self clientfield::set_player_uimodel("hudItems.perks.dead_shot", state);
}

/*
	Name: deadshot_perk_machine_setup
	Namespace: zm_perk_deadshot
	Checksum: 0x424F4353
	Offset: 0x678
	Size: 0xC0
	Parameters: 4
	Flags: None
	Line Number: 133
*/
function deadshot_perk_machine_setup(use_trigger, perk_machine, bump_trigger, collision)
{
	use_trigger.script_sound = "mus_perks_deadshot_jingle";
	use_trigger.script_string = "deadshot_perk";
	use_trigger.script_label = "mus_perks_deadshot_sting";
	use_trigger.target = "vending_deadshot";
	perk_machine.script_string = "deadshot_vending";
	perk_machine.targetname = "vending_deadshot";
	if(isdefined(bump_trigger))
	{
		bump_trigger.script_string = "deadshot_vending";
		return;
	}
}

/*
	Name: give_deadshot_perk
	Namespace: zm_perk_deadshot
	Checksum: 0x424F4353
	Offset: 0x740
	Size: 0x28
	Parameters: 0
	Flags: None
	Line Number: 158
*/
function give_deadshot_perk()
{
	self clientfield::set_to_player("deadshot_perk", 1);
}

/*
	Name: take_deadshot_perk
	Namespace: zm_perk_deadshot
	Checksum: 0x424F4353
	Offset: 0x770
	Size: 0x3C
	Parameters: 3
	Flags: None
	Line Number: 173
*/
function take_deadshot_perk(b_pause, str_perk, str_result)
{
	self clientfield::set_to_player("deadshot_perk", 0);
}

