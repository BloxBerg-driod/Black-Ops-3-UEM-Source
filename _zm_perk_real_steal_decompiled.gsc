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
	Name: __init__sytem__
	Namespace: namespace_5e129e78
	Checksum: 0x424F4353
	Offset: 0x318
	Size: 0x38
	Parameters: 0
	Flags: AutoExec
	Line Number: 23
*/
function autoexec __init__sytem__()
{
	system::register("zm_perk_real_steal", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: namespace_5e129e78
	Checksum: 0x424F4353
	Offset: 0x358
	Size: 0x18
	Parameters: 0
	Flags: None
	Line Number: 38
*/
function __init__()
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
	zm_perks::register_perk_basic_info("specialty_immunetriggerbetty", "real_steal", 4500, &"ZM_MINECRAFT_PERK_REAL_STEAL", getweapon("zombie_perk_bottle_real_steal"));
	zm_perks::register_perk_precache_func("specialty_immunetriggerbetty", &function_1d0302d3);
	zm_perks::register_perk_clientfields("specialty_immunetriggerbetty", &function_75d7e69, &function_b88662ee);
	zm_perks::register_perk_machine("specialty_immunetriggerbetty", &function_c3987cd8, &function_e34ecc5e);
	zm_perks::register_perk_threads("specialty_immunetriggerbetty", &function_5a38e268, &function_56708896);
	zm_perks::register_perk_host_migration_params("specialty_immunetriggerbetty", "vending_real_steal", "_sphynx/perks/fx_perk_real_steal");
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
}

/*
	Name: function_1d0302d3
	Namespace: namespace_5e129e78
	Checksum: 0x424F4353
	Offset: 0x4D0
	Size: 0xE0
	Parameters: 0
	Flags: None
	Line Number: 87
*/
function function_1d0302d3()
{
	if(isdefined(level.var_8d39c0df))
	{
		[[level.var_8d39c0df]]();
		return;
	}
	level._effect["_sphynx/perks/fx_perk_real_steal"] = "_sphynx/perks/fx_perk_real_steal";
	level.machine_assets["specialty_immunetriggerbetty"] = spawnstruct();
	level.machine_assets["specialty_immunetriggerbetty"].weapon = getweapon("zombie_perk_bottle_real_steal");
	level.machine_assets["specialty_immunetriggerbetty"].off_model = "logical_m_perkmachine_realstealbrew_off";
	level.machine_assets["specialty_immunetriggerbetty"].on_model = "logical_m_perkmachine_realstealbrew_on";
}

/*
	Name: function_75d7e69
	Namespace: namespace_5e129e78
	Checksum: 0x424F4353
	Offset: 0x5B8
	Size: 0x38
	Parameters: 0
	Flags: None
	Line Number: 111
*/
function function_75d7e69()
{
	clientfield::register("clientuimodel", "hudItems.perks.real_steal", 1, 2, "int");
	return;
	ERROR: Bad function call
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
function function_b88662ee(state)
{
	self clientfield::set_player_uimodel("hudItems.perks.real_steal", state);
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
function function_c3987cd8(use_trigger, perk_machine, bump_trigger, collision)
{
	use_trigger.script_sound = "mus_perks_real_steal_jingle";
	use_trigger.script_string = "real_steal_perk";
	use_trigger.script_label = "mus_perks_real_steal_sting";
	use_trigger.target = "vending_real_steal";
	perk_machine.script_string = "real_steal_perk";
	perk_machine.targetname = "vending_real_steal";
	if(isdefined(bump_trigger))
	{
		bump_trigger.script_string = "real_steal_perk";
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
	self endon("disconnect");
	self endon("hash_d787eb42");
	while(self hasperk("specialty_immunetriggerbetty"))
	{
		level waittill("spent_points", player, points);
		if(player == self && player hasperk("specialty_immunetriggerbetty"))
		{
			value = floor(points * 0.1);
			player zm_score::add_to_player_score(value);
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
function function_56708896(b_pause, str_perk, str_result)
{
	self notify("hash_d787eb42");
}

