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

#namespace namespace_zm_perk_doubletap2;

/*
	Name: function___init__sytem__
	Namespace: namespace_zm_perk_doubletap2
	Checksum: 0x424F4353
	Offset: 0x340
	Size: 0x38
	Parameters: 0
	Flags: AutoExec
	Line Number: 26
*/
function autoexec function___init__sytem__()
{
	namespace_system::function_register("zm_perk_doubletap2", &function___init__, undefined, undefined);
}

/*
	Name: function___init__
	Namespace: namespace_zm_perk_doubletap2
	Checksum: 0x424F4353
	Offset: 0x380
	Size: 0x18
	Parameters: 0
	Flags: None
	Line Number: 41
*/
function function___init__()
{
	function_enable_doubletap2_perk_for_level();
}

/*
	Name: function_enable_doubletap2_perk_for_level
	Namespace: namespace_zm_perk_doubletap2
	Checksum: 0x424F4353
	Offset: 0x3A0
	Size: 0xF8
	Parameters: 0
	Flags: None
	Line Number: 56
*/
function function_enable_doubletap2_perk_for_level()
{
	namespace_zm_perks::function_register_perk_basic_info("specialty_doubletap2", "doubletap", 2000, &"ZOMBIE_PERK_DOUBLETAP", function_GetWeapon("zombie_perk_bottle_doubletap"));
	namespace_zm_perks::function_register_perk_precache_func("specialty_doubletap2", &function_doubletap2_precache);
	namespace_zm_perks::function_register_perk_clientfields("specialty_doubletap2", &function_doubletap2_register_clientfield, &function_doubletap2_set_clientfield);
	namespace_zm_perks::function_register_perk_machine("specialty_doubletap2", &function_doubletap2_perk_machine_setup);
	namespace_zm_perks::function_register_perk_host_migration_params("specialty_doubletap2", "vending_doubletap", "doubletap2_light");
}

/*
	Name: function_doubletap2_precache
	Namespace: namespace_zm_perk_doubletap2
	Checksum: 0x424F4353
	Offset: 0x4A0
	Size: 0xE0
	Parameters: 0
	Flags: None
	Line Number: 75
*/
function function_doubletap2_precache()
{
	if(isdefined(level.var_doubletap2_precache_override_func))
	{
		[[level.var_doubletap2_precache_override_func]]();
		return;
	}
	level.var__effect["doubletap2_light"] = "zombie/fx_perk_doubletap2_zmb";
	level.var_machine_assets["specialty_doubletap2"] = function_spawnstruct();
	level.var_machine_assets["specialty_doubletap2"].var_weapon = function_GetWeapon("zombie_perk_bottle_doubletap");
	level.var_machine_assets["specialty_doubletap2"].var_off_model = "p7_zm_vending_doubletap2";
	level.var_machine_assets["specialty_doubletap2"].var_on_model = "p7_zm_vending_doubletap2";
}

/*
	Name: function_doubletap2_register_clientfield
	Namespace: namespace_zm_perk_doubletap2
	Checksum: 0x424F4353
	Offset: 0x588
	Size: 0x38
	Parameters: 0
	Flags: None
	Line Number: 99
*/
function function_doubletap2_register_clientfield()
{
	namespace_clientfield::function_register("clientuimodel", "hudItems.perks.doubletap2", 1, 2, "int");
}

/*
	Name: function_doubletap2_set_clientfield
	Namespace: namespace_zm_perk_doubletap2
	Checksum: 0x424F4353
	Offset: 0x5C8
	Size: 0x30
	Parameters: 1
	Flags: None
	Line Number: 114
*/
function function_doubletap2_set_clientfield(var_State)
{
	self namespace_clientfield::function_set_player_uimodel("hudItems.perks.doubletap2", var_State);
}

/*
	Name: function_doubletap2_perk_machine_setup
	Namespace: namespace_zm_perk_doubletap2
	Checksum: 0x424F4353
	Offset: 0x600
	Size: 0xBC
	Parameters: 4
	Flags: None
	Line Number: 129
*/
function function_doubletap2_perk_machine_setup(var_use_trigger, var_perk_machine, var_bump_trigger, var_collision)
{
	var_use_trigger.var_script_sound = "mus_perks_doubletap_jingle";
	var_use_trigger.var_script_string = "tap_perk";
	var_use_trigger.var_script_label = "mus_perks_doubletap_sting";
	var_use_trigger.var_target = "vending_doubletap";
	var_perk_machine.var_script_string = "tap_perk";
	var_perk_machine.var_targetname = "vending_doubletap";
	if(isdefined(var_bump_trigger))
	{
		var_bump_trigger.var_script_string = "tap_perk";
	}
}

