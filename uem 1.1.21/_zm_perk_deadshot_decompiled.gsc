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

#namespace namespace_zm_perk_deadshot;

/*
	Name: function___init__sytem__
	Namespace: namespace_zm_perk_deadshot
	Checksum: 0x424F4353
	Offset: 0x350
	Size: 0x38
	Parameters: 0
	Flags: AutoExec
	Line Number: 26
*/
function autoexec function___init__sytem__()
{
	namespace_system::function_register("zm_perk_deadshot", &function___init__, undefined, undefined);
	return;
	ERROR: Exception occured: Stack empty.
}

/*
	Name: function___init__
	Namespace: namespace_zm_perk_deadshot
	Checksum: 0x424F4353
	Offset: 0x390
	Size: 0x18
	Parameters: 0
	Flags: None
	Line Number: 43
*/
function function___init__()
{
	function_enable_deadshot_perk_for_level();
}

/*
	Name: function_enable_deadshot_perk_for_level
	Namespace: namespace_zm_perk_deadshot
	Checksum: 0x424F4353
	Offset: 0x3B0
	Size: 0x130
	Parameters: 0
	Flags: None
	Line Number: 58
*/
function function_enable_deadshot_perk_for_level()
{
	namespace_zm_perks::function_register_perk_basic_info("specialty_deadshot", "deadshot", 1500, &"ZOMBIE_PERK_DEADSHOT", function_GetWeapon("zombie_perk_bottle_deadshot"));
	namespace_zm_perks::function_register_perk_precache_func("specialty_deadshot", &function_deadshot_precache);
	namespace_zm_perks::function_register_perk_clientfields("specialty_deadshot", &function_deadshot_register_clientfield, &function_deadshot_set_clientfield);
	namespace_zm_perks::function_register_perk_machine("specialty_deadshot", &function_deadshot_perk_machine_setup);
	namespace_zm_perks::function_register_perk_threads("specialty_deadshot", &function_give_deadshot_perk, &function_take_deadshot_perk);
	namespace_zm_perks::function_register_perk_host_migration_params("specialty_deadshot", "vending_deadshot", "deadshot_light");
}

/*
	Name: function_deadshot_precache
	Namespace: namespace_zm_perk_deadshot
	Checksum: 0x424F4353
	Offset: 0x4E8
	Size: 0xE0
	Parameters: 0
	Flags: None
	Line Number: 78
*/
function function_deadshot_precache()
{
	if(isdefined(level.var_deadshot_precache_override_func))
	{
		[[level.var_deadshot_precache_override_func]]();
		return;
	}
	level.var__effect["deadshot_light"] = "_t6/misc/fx_zombie_cola_dtap_on";
	level.var_machine_assets["specialty_deadshot"] = function_spawnstruct();
	level.var_machine_assets["specialty_deadshot"].var_weapon = function_GetWeapon("zombie_perk_bottle_deadshot");
	level.var_machine_assets["specialty_deadshot"].var_off_model = "p7_zm_vending_ads";
	level.var_machine_assets["specialty_deadshot"].var_on_model = "p7_zm_vending_ads";
}

/*
	Name: function_deadshot_register_clientfield
	Namespace: namespace_zm_perk_deadshot
	Checksum: 0x424F4353
	Offset: 0x5D0
	Size: 0x68
	Parameters: 0
	Flags: None
	Line Number: 102
*/
function function_deadshot_register_clientfield()
{
	namespace_clientfield::function_register("toplayer", "deadshot_perk", 1, 1, "int");
	namespace_clientfield::function_register("clientuimodel", "hudItems.perks.dead_shot", 1, 2, "int");
}

/*
	Name: function_deadshot_set_clientfield
	Namespace: namespace_zm_perk_deadshot
	Checksum: 0x424F4353
	Offset: 0x640
	Size: 0x30
	Parameters: 1
	Flags: None
	Line Number: 118
*/
function function_deadshot_set_clientfield(var_State)
{
	self namespace_clientfield::function_set_player_uimodel("hudItems.perks.dead_shot", var_State);
}

/*
	Name: function_deadshot_perk_machine_setup
	Namespace: namespace_zm_perk_deadshot
	Checksum: 0x424F4353
	Offset: 0x678
	Size: 0xC0
	Parameters: 4
	Flags: None
	Line Number: 133
*/
function function_deadshot_perk_machine_setup(var_use_trigger, var_perk_machine, var_bump_trigger, var_collision)
{
	var_use_trigger.var_script_sound = "mus_perks_deadshot_jingle";
	var_use_trigger.var_script_string = "deadshot_perk";
	var_use_trigger.var_script_label = "mus_perks_deadshot_sting";
	var_use_trigger.var_target = "vending_deadshot";
	var_perk_machine.var_script_string = "deadshot_vending";
	var_perk_machine.var_targetname = "vending_deadshot";
	if(isdefined(var_bump_trigger))
	{
		var_bump_trigger.var_script_string = "deadshot_vending";
	}
}

/*
	Name: function_give_deadshot_perk
	Namespace: namespace_zm_perk_deadshot
	Checksum: 0x424F4353
	Offset: 0x740
	Size: 0x28
	Parameters: 0
	Flags: None
	Line Number: 157
*/
function function_give_deadshot_perk()
{
	self namespace_clientfield::function_set_to_player("deadshot_perk", 1);
}

/*
	Name: function_take_deadshot_perk
	Namespace: namespace_zm_perk_deadshot
	Checksum: 0x424F4353
	Offset: 0x770
	Size: 0x3C
	Parameters: 3
	Flags: None
	Line Number: 172
*/
function function_take_deadshot_perk(var_b_pause, var_str_perk, var_str_result)
{
	self namespace_clientfield::function_set_to_player("deadshot_perk", 0);
}

