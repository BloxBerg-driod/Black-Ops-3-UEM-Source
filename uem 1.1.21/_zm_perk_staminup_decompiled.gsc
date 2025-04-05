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

#namespace namespace_zm_perk_staminup;

/*
	Name: function___init__sytem__
	Namespace: namespace_zm_perk_staminup
	Checksum: 0x424F4353
	Offset: 0x330
	Size: 0x38
	Parameters: 0
	Flags: AutoExec
	Line Number: 26
*/
function autoexec function___init__sytem__()
{
	namespace_system::function_register("zm_perk_staminup", &function___init__, undefined, undefined);
	return;
	ERROR: Exception occured: Stack empty.
}

/*
	Name: function___init__
	Namespace: namespace_zm_perk_staminup
	Checksum: 0x424F4353
	Offset: 0x370
	Size: 0x18
	Parameters: 0
	Flags: None
	Line Number: 43
*/
function function___init__()
{
	function_enable_staminup_perk_for_level();
}

/*
	Name: function_enable_staminup_perk_for_level
	Namespace: namespace_zm_perk_staminup
	Checksum: 0x424F4353
	Offset: 0x390
	Size: 0xF8
	Parameters: 0
	Flags: None
	Line Number: 58
*/
function function_enable_staminup_perk_for_level()
{
	namespace_zm_perks::function_register_perk_basic_info("specialty_staminup", "marathon", 2000, &"ZOMBIE_PERK_MARATHON", function_GetWeapon("zombie_perk_bottle_marathon"));
	namespace_zm_perks::function_register_perk_precache_func("specialty_staminup", &function_staminup_precache);
	namespace_zm_perks::function_register_perk_clientfields("specialty_staminup", &function_staminup_register_clientfield, &function_staminup_set_clientfield);
	namespace_zm_perks::function_register_perk_machine("specialty_staminup", &function_staminup_perk_machine_setup);
	namespace_zm_perks::function_register_perk_host_migration_params("specialty_staminup", "vending_marathon", "marathon_light");
}

/*
	Name: function_staminup_precache
	Namespace: namespace_zm_perk_staminup
	Checksum: 0x424F4353
	Offset: 0x490
	Size: 0xE0
	Parameters: 0
	Flags: None
	Line Number: 77
*/
function function_staminup_precache()
{
	if(isdefined(level.var_staminup_precache_override_func))
	{
		[[level.var_staminup_precache_override_func]]();
		return;
	}
	level.var__effect["marathon_light"] = "zombie/fx_perk_stamin_up_zmb";
	level.var_machine_assets["specialty_staminup"] = function_spawnstruct();
	level.var_machine_assets["specialty_staminup"].var_weapon = function_GetWeapon("zombie_perk_bottle_marathon");
	level.var_machine_assets["specialty_staminup"].var_off_model = "p7_zm_vending_marathon";
	level.var_machine_assets["specialty_staminup"].var_on_model = "p7_zm_vending_marathon";
}

/*
	Name: function_staminup_register_clientfield
	Namespace: namespace_zm_perk_staminup
	Checksum: 0x424F4353
	Offset: 0x578
	Size: 0x38
	Parameters: 0
	Flags: None
	Line Number: 101
*/
function function_staminup_register_clientfield()
{
	namespace_clientfield::function_register("clientuimodel", "hudItems.perks.marathon", 1, 2, "int");
	return;
	ERROR: Bad function call
}

/*
	Name: function_staminup_set_clientfield
	Namespace: namespace_zm_perk_staminup
	Checksum: 0x424F4353
	Offset: 0x5B8
	Size: 0x30
	Parameters: 1
	Flags: None
	Line Number: 118
*/
function function_staminup_set_clientfield(var_State)
{
	self namespace_clientfield::function_set_player_uimodel("hudItems.perks.marathon", var_State);
}

/*
	Name: function_staminup_perk_machine_setup
	Namespace: namespace_zm_perk_staminup
	Checksum: 0x424F4353
	Offset: 0x5F0
	Size: 0xBC
	Parameters: 4
	Flags: None
	Line Number: 133
*/
function function_staminup_perk_machine_setup(var_use_trigger, var_perk_machine, var_bump_trigger, var_collision)
{
	var_use_trigger.var_script_sound = "mus_perks_stamin_jingle";
	var_use_trigger.var_script_string = "marathon_perk";
	var_use_trigger.var_script_label = "mus_perks_stamin_sting";
	var_use_trigger.var_target = "vending_marathon";
	var_perk_machine.var_script_string = "marathon_perk";
	var_perk_machine.var_targetname = "vending_marathon";
	if(isdefined(var_bump_trigger))
	{
		var_bump_trigger.var_script_string = "marathon_perk";
	}
}

