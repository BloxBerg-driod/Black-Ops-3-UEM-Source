#include scripts\shared\callbacks_shared;
#include scripts\shared\clientfield_shared;
#include scripts\shared\math_shared;
#include scripts\shared\system_shared;
#include scripts\shared\util_shared;
#include scripts\zm\_zm_perks;
#include scripts\zm\_zm_powerups;
#include scripts\zm\_zm_score;
#include scripts\zm\_zm_spawner;
#include scripts\zm\_zm_utility;
#include scripts\zm\gametypes\_globallogic;
#include scripts\zm\gametypes\_globallogic_score;

#namespace namespace_6d226c50;

/*
	Name: function___init__sytem__
	Namespace: namespace_6d226c50
	Checksum: 0x424F4353
	Offset: 0x430
	Size: 0x38
	Parameters: 0
	Flags: AutoExec
	Line Number: 25
*/
function autoexec function___init__sytem__()
{
	namespace_system::function_register("zm_perk_death_perception", &function___init__, undefined, undefined);
}

/*
	Name: function___init__
	Namespace: namespace_6d226c50
	Checksum: 0x424F4353
	Offset: 0x470
	Size: 0x38
	Parameters: 0
	Flags: None
	Line Number: 40
*/
function function___init__()
{
	function_3fc3b349();
	namespace_callback::function_on_connect(&function_player_on_connect);
}

/*
	Name: function_3fc3b349
	Namespace: namespace_6d226c50
	Checksum: 0x424F4353
	Offset: 0x4B0
	Size: 0x140
	Parameters: 0
	Flags: None
	Line Number: 56
*/
function function_3fc3b349()
{
	namespace_zm_perks::function_register_perk_basic_info("specialty_tracker", "death_perception", 3000, "Hold ^3[{+activate}]^7 for Death Perception [Cost: &&1] \n ^8Makes the player see zombies through walls and objects", function_GetWeapon("zombie_perk_bottle_death_perception"));
	namespace_zm_perks::function_register_perk_precache_func("specialty_tracker", &function_e6c10593);
	namespace_zm_perks::function_register_perk_clientfields("specialty_tracker", &function_6bee1529, &function_a7d80dae);
	namespace_zm_perks::function_register_perk_machine("specialty_tracker", &function_5ea3f998, &function_450f0786);
	namespace_zm_perks::function_register_perk_threads("specialty_tracker", &function_aa495970, &function_4b7488fe);
	namespace_zm_perks::function_register_perk_host_migration_params("specialty_tracker", "vending_death_perception", "_sphynx/perks/fx_perk_death_perception_light");
	return;
	ERROR: Exception occured: Stack empty.
	ERROR: Bad function call
}

/*
	Name: function_450f0786
	Namespace: namespace_6d226c50
	Checksum: 0x424F4353
	Offset: 0x5F8
	Size: 0x8
	Parameters: 0
	Flags: None
	Line Number: 79
*/
function function_450f0786()
{
	return;
}

/*
	Name: function_player_on_connect
	Namespace: namespace_6d226c50
	Checksum: 0x424F4353
	Offset: 0x608
	Size: 0x28
	Parameters: 0
	Flags: None
	Line Number: 94
*/
function function_player_on_connect()
{
	self namespace_globallogic_score::function_initPersStat("specialty_tracker_drank", 0);
}

/*
	Name: function_e6c10593
	Namespace: namespace_6d226c50
	Checksum: 0x424F4353
	Offset: 0x638
	Size: 0xE0
	Parameters: 0
	Flags: None
	Line Number: 109
*/
function function_e6c10593()
{
	if(isdefined(level.var_2b12c69f))
	{
		[[level.var_2b12c69f]]();
		return;
	}
	level.var__effect["_sphynx/perks/fx_perk_death_perception_light"] = "_sphynx/perks/fx_perk_death_perception_light";
	level.var_machine_assets["specialty_tracker"] = function_spawnstruct();
	level.var_machine_assets["specialty_tracker"].var_weapon = function_GetWeapon("zombie_perk_bottle_death_perception");
	level.var_machine_assets["specialty_tracker"].var_off_model = "p9_sur_machine_death_perception_disabled";
	level.var_machine_assets["specialty_tracker"].var_on_model = "p9_sur_machine_death_perception";
}

/*
	Name: function_6bee1529
	Namespace: namespace_6d226c50
	Checksum: 0x424F4353
	Offset: 0x720
	Size: 0x68
	Parameters: 0
	Flags: None
	Line Number: 133
*/
function function_6bee1529()
{
	namespace_clientfield::function_register("toplayer", "death_perception_perk_toplayer", 1, 1, "int");
	namespace_clientfield::function_register("clientuimodel", "hudItems.perks.death_perception", 1, 2, "int");
}

/*
	Name: function_a7d80dae
	Namespace: namespace_6d226c50
	Checksum: 0x424F4353
	Offset: 0x790
	Size: 0x30
	Parameters: 1
	Flags: None
	Line Number: 149
*/
function function_a7d80dae(var_State)
{
	self namespace_clientfield::function_set_player_uimodel("hudItems.perks.death_perception", var_State);
}

/*
	Name: function_5ea3f998
	Namespace: namespace_6d226c50
	Checksum: 0x424F4353
	Offset: 0x7C8
	Size: 0xC0
	Parameters: 4
	Flags: None
	Line Number: 164
*/
function function_5ea3f998(var_use_trigger, var_perk_machine, var_bump_trigger, var_collision)
{
	var_use_trigger.var_script_sound = "mus_perks_death_perception_jingle";
	var_use_trigger.var_script_string = "death_perception_perk";
	var_use_trigger.var_script_label = "mus_perks_death_perception_sting";
	var_use_trigger.var_target = "vending_death_perception";
	var_perk_machine.var_script_string = "death_perception_perk";
	var_perk_machine.var_targetname = "vending_death_perception";
	if(isdefined(var_bump_trigger))
	{
		var_bump_trigger.var_script_string = "death_perception_perk";
	}
}

/*
	Name: function_aa495970
	Namespace: namespace_6d226c50
	Checksum: 0x424F4353
	Offset: 0x890
	Size: 0x40
	Parameters: 0
	Flags: None
	Line Number: 188
*/
function function_aa495970()
{
	self endon("hash_disconnect");
	self endon("hash_2f738272");
	self namespace_clientfield::function_set_to_player("death_perception_perk_toplayer", 1);
}

/*
	Name: function_4b7488fe
	Namespace: namespace_6d226c50
	Checksum: 0x424F4353
	Offset: 0x8D8
	Size: 0x4C
	Parameters: 3
	Flags: None
	Line Number: 205
*/
function function_4b7488fe(var_b_pause, var_str_perk, var_str_result)
{
	self notify("hash_2f738272");
	self namespace_clientfield::function_set_to_player("death_perception_perk_toplayer", 0);
}

