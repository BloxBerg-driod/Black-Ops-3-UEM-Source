#include scripts\codescripts\struct;
#include scripts\shared\array_shared;
#include scripts\shared\clientfield_shared;
#include scripts\shared\flag_shared;
#include scripts\shared\system_shared;
#include scripts\shared\util_shared;
#include scripts\sphynx\leveling\_zm_sphynx_leveling;
#include scripts\zm\_zm_bgb;
#include scripts\zm\_zm_powerups;
#include scripts\zm\_zm_utility;
#include scripts\zm\_zm_weapon_upgrade_system;
#include scripts\zm\_zm_weapons;

#namespace namespace_4a456e31;

/*
	Name: function___init__sytem__
	Namespace: namespace_4a456e31
	Checksum: 0x424F4353
	Offset: 0x278
	Size: 0x38
	Parameters: 0
	Flags: AutoExec
	Line Number: 25
*/
function autoexec function___init__sytem__()
{
	namespace_system::function_register("zm_bgb_locksmith", &function___init__, undefined, "bgb");
}

/*
	Name: function___init__
	Namespace: namespace_4a456e31
	Checksum: 0x424F4353
	Offset: 0x2B8
	Size: 0x58
	Parameters: 0
	Flags: None
	Line Number: 40
*/
function function___init__()
{
	if(!(isdefined(level.var_bgb_in_use) && level.var_bgb_in_use))
	{
		return;
	}
	namespace_bgb::function_register("zm_bgb_locksmith", "event", &function_event, undefined, undefined, undefined);
	return;
}

/*
	Name: function_event
	Namespace: namespace_4a456e31
	Checksum: 0x424F4353
	Offset: 0x318
	Size: 0x3AA
	Parameters: 0
	Flags: None
	Line Number: 60
*/
function function_event()
{
	level namespace_flag::function_set("power_on");
	level namespace_clientfield::function_set("zombie_power_on", 0);
	var_power_trigs = function_GetEntArray("use_elec_switch", "targetname");
	foreach(var_trig in var_power_trigs)
	{
		if(isdefined(var_trig.var_script_int))
		{
			level namespace_flag::function_set("power_on" + var_trig.var_script_int);
			level namespace_clientfield::function_set("zombie_power_on", var_trig.var_script_int);
		}
	}
	var_zombie_doors = function_GetEntArray("zombie_door", "targetname");
	for(var_i = 0; var_i < 15; var_i++)
	{
		if(var_zombie_doors[var_i].var_zombie_cost <= 4000 && (!(isdefined(var_zombie_doors[var_i].var_has_been_opened) && var_zombie_doors[var_i].var_has_been_opened)))
		{
			var_zombie_doors[var_i] notify("hash_trigger", undefined, 1);
		}
		if(isdefined(var_zombie_doors[var_i].var_power_door_ignore_flag_wait) && var_zombie_doors[var_i].var_power_door_ignore_flag_wait)
		{
			var_zombie_doors[var_i] notify("hash_power_on");
		}
		wait(0.05);
	}
	var_zombie_airlock_doors = function_GetEntArray("zombie_airlock_buy", "targetname");
	for(var_i = 0; var_i < var_zombie_airlock_doors.size; var_i++)
	{
		if(!(isdefined(var_zombie_airlock_doors[var_i].var_has_been_opened) && var_zombie_airlock_doors[var_i].var_has_been_opened))
		{
			var_zombie_airlock_doors[var_i] notify("hash_trigger", undefined, 1);
		}
		wait(0.05);
	}
	var_zombie_debris = function_GetEntArray("zombie_debris", "targetname");
	for(var_i = 0; var_i < var_zombie_debris.size; var_i++)
	{
		if(isdefined(var_zombie_debris[var_i]) && (!(isdefined(var_zombie_debris[var_i].var_has_been_opened) && var_zombie_debris[var_i].var_has_been_opened)))
		{
			var_zombie_debris[var_i] notify("hash_trigger", undefined, 1);
		}
		wait(0.05);
	}
	level notify("hash_open_sesame");
}

