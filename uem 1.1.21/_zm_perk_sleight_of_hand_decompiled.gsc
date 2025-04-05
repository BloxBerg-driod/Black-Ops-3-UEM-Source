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

#namespace namespace_zm_perk_sleight_of_hand;

/*
	Name: function___init__sytem__
	Namespace: namespace_zm_perk_sleight_of_hand
	Checksum: 0x424F4353
	Offset: 0x348
	Size: 0x38
	Parameters: 0
	Flags: AutoExec
	Line Number: 26
*/
function autoexec function___init__sytem__()
{
	namespace_system::function_register("zm_perk_sleight_of_hand", &function___init__, undefined, undefined);
}

/*
	Name: function___init__
	Namespace: namespace_zm_perk_sleight_of_hand
	Checksum: 0x424F4353
	Offset: 0x388
	Size: 0x18
	Parameters: 0
	Flags: None
	Line Number: 41
*/
function function___init__()
{
	function_enable_sleight_of_hand_perk_for_level();
}

/*
	Name: function_enable_sleight_of_hand_perk_for_level
	Namespace: namespace_zm_perk_sleight_of_hand
	Checksum: 0x424F4353
	Offset: 0x3A8
	Size: 0xF8
	Parameters: 0
	Flags: None
	Line Number: 56
*/
function function_enable_sleight_of_hand_perk_for_level()
{
	namespace_zm_perks::function_register_perk_basic_info("specialty_fastreload", "sleight", 3000, &"ZOMBIE_PERK_FASTRELOAD", function_GetWeapon("zombie_perk_bottle_sleight"));
	namespace_zm_perks::function_register_perk_precache_func("specialty_fastreload", &function_sleight_of_hand_precache);
	namespace_zm_perks::function_register_perk_clientfields("specialty_fastreload", &function_sleight_of_hand_register_clientfield, &function_sleight_of_hand_set_clientfield);
	namespace_zm_perks::function_register_perk_machine("specialty_fastreload", &function_sleight_of_hand_perk_machine_setup);
	namespace_zm_perks::function_register_perk_host_migration_params("specialty_fastreload", "vending_sleight", "sleight_light");
}

/*
	Name: function_sleight_of_hand_precache
	Namespace: namespace_zm_perk_sleight_of_hand
	Checksum: 0x424F4353
	Offset: 0x4A8
	Size: 0xE0
	Parameters: 0
	Flags: None
	Line Number: 75
*/
function function_sleight_of_hand_precache()
{
	if(isdefined(level.var_sleight_of_hand_precache_override_func))
	{
		[[level.var_sleight_of_hand_precache_override_func]]();
		return;
	}
	level.var__effect["sleight_light"] = "zombie/fx_perk_sleight_of_hand_zmb";
	level.var_machine_assets["specialty_fastreload"] = function_spawnstruct();
	level.var_machine_assets["specialty_fastreload"].var_weapon = function_GetWeapon("zombie_perk_bottle_sleight");
	level.var_machine_assets["specialty_fastreload"].var_off_model = "p7_zm_vending_sleight";
	level.var_machine_assets["specialty_fastreload"].var_on_model = "p7_zm_vending_sleight";
}

/*
	Name: function_sleight_of_hand_register_clientfield
	Namespace: namespace_zm_perk_sleight_of_hand
	Checksum: 0x424F4353
	Offset: 0x590
	Size: 0x38
	Parameters: 0
	Flags: None
	Line Number: 99
*/
function function_sleight_of_hand_register_clientfield()
{
	namespace_clientfield::function_register("clientuimodel", "hudItems.perks.sleight_of_hand", 1, 2, "int");
}

/*
	Name: function_sleight_of_hand_set_clientfield
	Namespace: namespace_zm_perk_sleight_of_hand
	Checksum: 0x424F4353
	Offset: 0x5D0
	Size: 0x30
	Parameters: 1
	Flags: None
	Line Number: 114
*/
function function_sleight_of_hand_set_clientfield(var_State)
{
	self namespace_clientfield::function_set_player_uimodel("hudItems.perks.sleight_of_hand", var_State);
}

/*
	Name: function_sleight_of_hand_perk_machine_setup
	Namespace: namespace_zm_perk_sleight_of_hand
	Checksum: 0x424F4353
	Offset: 0x608
	Size: 0xBC
	Parameters: 4
	Flags: None
	Line Number: 129
*/
function function_sleight_of_hand_perk_machine_setup(var_use_trigger, var_perk_machine, var_bump_trigger, var_collision)
{
	var_use_trigger.var_script_sound = "mus_perks_speed_jingle";
	var_use_trigger.var_script_string = "speedcola_perk";
	var_use_trigger.var_script_label = "mus_perks_speed_sting";
	var_use_trigger.var_target = "vending_sleight";
	var_perk_machine.var_script_string = "speedcola_perk";
	var_perk_machine.var_targetname = "vending_sleight";
	if(isdefined(var_bump_trigger))
	{
		var_bump_trigger.var_script_string = "speedcola_perk";
	}
}

