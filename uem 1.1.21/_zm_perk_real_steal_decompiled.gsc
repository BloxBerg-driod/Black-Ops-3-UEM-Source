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

#namespace namespace_5e129e78;

/*
	Name: function___init__sytem__
	Namespace: namespace_5e129e78
	Checksum: 0x424F4353
	Offset: 0x318
	Size: 0x38
	Parameters: 0
	Flags: AutoExec
	Line Number: 23
*/
function autoexec function___init__sytem__()
{
	namespace_system::function_register("zm_perk_real_steal", &function___init__, undefined, undefined);
}

/*
	Name: function___init__
	Namespace: namespace_5e129e78
	Checksum: 0x424F4353
	Offset: 0x358
	Size: 0x18
	Parameters: 0
	Flags: None
	Line Number: 38
*/
function function___init__()
{
	function_7694a3f9();
}

/*
	Name: function_7694a3f9
	Namespace: namespace_5e129e78
	Checksum: 0x424F4353
	Offset: 0x378
	Size: 0x140
	Parameters: 0
	Flags: None
	Line Number: 53
*/
function function_7694a3f9()
{
	namespace_zm_perks::function_register_perk_basic_info("specialty_immunetriggerbetty", "real_steal", 4500, &"ZM_MINECRAFT_PERK_REAL_STEAL", function_GetWeapon("zombie_perk_bottle_real_steal"));
	namespace_zm_perks::function_register_perk_precache_func("specialty_immunetriggerbetty", &function_1d0302d3);
	namespace_zm_perks::function_register_perk_clientfields("specialty_immunetriggerbetty", &function_75d7e69, &function_b88662ee);
	namespace_zm_perks::function_register_perk_machine("specialty_immunetriggerbetty", &function_c3987cd8, &function_e34ecc5e);
	namespace_zm_perks::function_register_perk_threads("specialty_immunetriggerbetty", &function_5a38e268, &function_56708896);
	namespace_zm_perks::function_register_perk_host_migration_params("specialty_immunetriggerbetty", "vending_real_steal", "_sphynx/perks/fx_perk_real_steal");
}

/*
	Name: function_e34ecc5e
	Namespace: namespace_5e129e78
	Checksum: 0x424F4353
	Offset: 0x4C0
	Size: 0x8
	Parameters: 0
	Flags: None
	Line Number: 73
*/
function function_e34ecc5e()
{
	return;
	continue;
}

/*
	Name: function_1d0302d3
	Namespace: namespace_5e129e78
	Checksum: 0x424F4353
	Offset: 0x4D0
	Size: 0xE0
	Parameters: 0
	Flags: None
	Line Number: 89
*/
function function_1d0302d3()
{
	if(isdefined(level.var_8d39c0df))
	{
		[[level.var_8d39c0df]]();
		return;
	}
	level.var__effect["_sphynx/perks/fx_perk_real_steal"] = "_sphynx/perks/fx_perk_real_steal";
	level.var_machine_assets["specialty_immunetriggerbetty"] = function_spawnstruct();
	level.var_machine_assets["specialty_immunetriggerbetty"].var_weapon = function_GetWeapon("zombie_perk_bottle_real_steal");
	level.var_machine_assets["specialty_immunetriggerbetty"].var_off_model = "logical_m_perkmachine_realstealbrew_off";
	level.var_machine_assets["specialty_immunetriggerbetty"].var_on_model = "logical_m_perkmachine_realstealbrew_on";
}

/*
	Name: function_75d7e69
	Namespace: namespace_5e129e78
	Checksum: 0x424F4353
	Offset: 0x5B8
	Size: 0x38
	Parameters: 0
	Flags: None
	Line Number: 113
*/
function function_75d7e69()
{
	namespace_clientfield::function_register("clientuimodel", "hudItems.perks.real_steal", 1, 2, "int");
}

/*
	Name: function_b88662ee
	Namespace: namespace_5e129e78
	Checksum: 0x424F4353
	Offset: 0x5F8
	Size: 0x30
	Parameters: 1
	Flags: None
	Line Number: 128
*/
function function_b88662ee(var_State)
{
	self namespace_clientfield::function_set_player_uimodel("hudItems.perks.real_steal", var_State);
}

/*
	Name: function_c3987cd8
	Namespace: namespace_5e129e78
	Checksum: 0x424F4353
	Offset: 0x630
	Size: 0xC0
	Parameters: 4
	Flags: None
	Line Number: 143
*/
function function_c3987cd8(var_use_trigger, var_perk_machine, var_bump_trigger, var_collision)
{
	var_use_trigger.var_script_sound = "mus_perks_real_steal_jingle";
	var_use_trigger.var_script_string = "real_steal_perk";
	var_use_trigger.var_script_label = "mus_perks_real_steal_sting";
	var_use_trigger.var_target = "vending_real_steal";
	var_perk_machine.var_script_string = "real_steal_perk";
	var_perk_machine.var_targetname = "vending_real_steal";
	if(isdefined(var_bump_trigger))
	{
		var_bump_trigger.var_script_string = "real_steal_perk";
	}
}

/*
	Name: function_5a38e268
	Namespace: namespace_5e129e78
	Checksum: 0x424F4353
	Offset: 0x6F8
	Size: 0xD8
	Parameters: 0
	Flags: None
	Line Number: 167
*/
function function_5a38e268()
{
	self endon("hash_disconnect");
	self endon("hash_d787eb42");
	while(self function_hasPerk("specialty_immunetriggerbetty"))
	{
		level waittill("hash_spent_points", var_player, var_points);
		if(var_player == self && var_player function_hasPerk("specialty_immunetriggerbetty"))
		{
			var_value = function_floor(var_points * 0.1);
			var_player namespace_zm_score::function_add_to_player_score(var_value);
			wait(0.1);
		}
	}
}

/*
	Name: function_56708896
	Namespace: namespace_5e129e78
	Checksum: 0x424F4353
	Offset: 0x7D8
	Size: 0x2A
	Parameters: 3
	Flags: None
	Line Number: 193
*/
function function_56708896(var_b_pause, var_str_perk, var_str_result)
{
	self notify("hash_d787eb42");
}

