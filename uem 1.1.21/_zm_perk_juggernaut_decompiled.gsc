#include scripts\codescripts\struct;
#include scripts\shared\ai\zombie_utility;
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

#namespace namespace_zm_perk_juggernaut;

/*
	Name: function___init__sytem__
	Namespace: namespace_zm_perk_juggernaut
	Checksum: 0x424F4353
	Offset: 0x3A8
	Size: 0x38
	Parameters: 0
	Flags: AutoExec
	Line Number: 27
*/
function autoexec function___init__sytem__()
{
	namespace_system::function_register("zm_perk_juggernaut", &function___init__, undefined, undefined);
}

/*
	Name: function___init__
	Namespace: namespace_zm_perk_juggernaut
	Checksum: 0x424F4353
	Offset: 0x3E8
	Size: 0x18
	Parameters: 0
	Flags: None
	Line Number: 42
*/
function function___init__()
{
	function_enable_juggernaut_perk_for_level();
}

/*
	Name: function_enable_juggernaut_perk_for_level
	Namespace: namespace_zm_perk_juggernaut
	Checksum: 0x424F4353
	Offset: 0x408
	Size: 0x140
	Parameters: 0
	Flags: None
	Line Number: 57
*/
function function_enable_juggernaut_perk_for_level()
{
	namespace_zm_perks::function_register_perk_basic_info("specialty_armorvest", "juggernog", 2500, &"ZOMBIE_PERK_JUGGERNAUT", function_GetWeapon("zombie_perk_bottle_jugg"));
	namespace_zm_perks::function_register_perk_precache_func("specialty_armorvest", &function_juggernaut_precache);
	namespace_zm_perks::function_register_perk_clientfields("specialty_armorvest", &function_juggernaut_register_clientfield, &function_juggernaut_set_clientfield);
	namespace_zm_perks::function_register_perk_machine("specialty_armorvest", &function_juggernaut_perk_machine_setup, &function_init_juggernaut);
	namespace_zm_perks::function_register_perk_threads("specialty_armorvest", &function_give_juggernaut_perk, &function_take_juggernaut_perk);
	namespace_zm_perks::function_register_perk_host_migration_params("specialty_armorvest", "vending_jugg", "jugger_light");
}

/*
	Name: function_init_juggernaut
	Namespace: namespace_zm_perk_juggernaut
	Checksum: 0x424F4353
	Offset: 0x550
	Size: 0x48
	Parameters: 0
	Flags: None
	Line Number: 77
*/
function function_init_juggernaut()
{
	namespace_zombie_utility::function_set_zombie_var("zombie_perk_juggernaut_health", 100);
	namespace_zombie_utility::function_set_zombie_var("zombie_perk_juggernaut_health_upgrade", 150);
	return;
	~;
	ERROR: Exception occured: Stack empty.
}

/*
	Name: function_juggernaut_precache
	Namespace: namespace_zm_perk_juggernaut
	Checksum: 0x424F4353
	Offset: 0x5A0
	Size: 0xE0
	Parameters: 0
	Flags: None
	Line Number: 96
*/
function function_juggernaut_precache()
{
	if(isdefined(level.var_juggernaut_precache_override_func))
	{
		[[level.var_juggernaut_precache_override_func]]();
		return;
	}
	level.var__effect["jugger_light"] = "zombie/fx_perk_juggernaut_zmb";
	level.var_machine_assets["specialty_armorvest"] = function_spawnstruct();
	level.var_machine_assets["specialty_armorvest"].var_weapon = function_GetWeapon("zombie_perk_bottle_jugg");
	level.var_machine_assets["specialty_armorvest"].var_off_model = "p7_zm_vending_jugg";
	level.var_machine_assets["specialty_armorvest"].var_on_model = "p7_zm_vending_jugg";
}

/*
	Name: function_juggernaut_register_clientfield
	Namespace: namespace_zm_perk_juggernaut
	Checksum: 0x424F4353
	Offset: 0x688
	Size: 0x38
	Parameters: 0
	Flags: None
	Line Number: 120
*/
function function_juggernaut_register_clientfield()
{
	namespace_clientfield::function_register("clientuimodel", "hudItems.perks.juggernaut", 1, 2, "int");
}

/*
	Name: function_juggernaut_set_clientfield
	Namespace: namespace_zm_perk_juggernaut
	Checksum: 0x424F4353
	Offset: 0x6C8
	Size: 0x30
	Parameters: 1
	Flags: None
	Line Number: 135
*/
function function_juggernaut_set_clientfield(var_State)
{
	self namespace_clientfield::function_set_player_uimodel("hudItems.perks.juggernaut", var_State);
}

/*
	Name: function_juggernaut_perk_machine_setup
	Namespace: namespace_zm_perk_juggernaut
	Checksum: 0x424F4353
	Offset: 0x700
	Size: 0xD0
	Parameters: 4
	Flags: None
	Line Number: 150
*/
function function_juggernaut_perk_machine_setup(var_use_trigger, var_perk_machine, var_bump_trigger, var_collision)
{
	var_use_trigger.var_script_sound = "mus_perks_jugganog_jingle";
	var_use_trigger.var_script_string = "jugg_perk";
	var_use_trigger.var_script_label = "mus_perks_jugganog_sting";
	var_use_trigger.var_longJingleWait = 1;
	var_use_trigger.var_target = "vending_jugg";
	var_perk_machine.var_script_string = "jugg_perk";
	var_perk_machine.var_targetname = "vending_jugg";
	if(isdefined(var_bump_trigger))
	{
		var_bump_trigger.var_script_string = "jugg_perk";
	}
}

/*
	Name: function_give_juggernaut_perk
	Namespace: namespace_zm_perk_juggernaut
	Checksum: 0x424F4353
	Offset: 0x7D8
	Size: 0x28
	Parameters: 0
	Flags: None
	Line Number: 175
*/
function function_give_juggernaut_perk()
{
	self namespace_zm_perks::function_perk_set_max_health_if_jugg("specialty_armorvest", 1, 0);
}

/*
	Name: function_take_juggernaut_perk
	Namespace: namespace_zm_perk_juggernaut
	Checksum: 0x424F4353
	Offset: 0x808
	Size: 0x44
	Parameters: 3
	Flags: None
	Line Number: 190
*/
function function_take_juggernaut_perk(var_b_pause, var_str_perk, var_str_result)
{
	self namespace_zm_perks::function_perk_set_max_health_if_jugg("health_reboot", 1, 1);
}

