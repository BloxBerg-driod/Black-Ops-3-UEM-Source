#include scripts\codescripts\struct;
#include scripts\shared\flag_shared;
#include scripts\shared\system_shared;
#include scripts\shared\util_shared;
#include scripts\zm\_zm_bgb;
#include scripts\zm\_zm_powerups;
#include scripts\zm\_zm_utility;

#namespace namespace_6cf54cb6;

/*
	Name: function___init__sytem__
	Namespace: namespace_6cf54cb6
	Checksum: 0x424F4353
	Offset: 0x168
	Size: 0x38
	Parameters: 0
	Flags: AutoExec
	Line Number: 20
*/
function autoexec function___init__sytem__()
{
	namespace_system::function_register("zm_bgb_power_vacuum", &function___init__, undefined, "bgb");
}

/*
	Name: function___init__
	Namespace: namespace_6cf54cb6
	Checksum: 0x424F4353
	Offset: 0x1A8
	Size: 0x60
	Parameters: 0
	Flags: None
	Line Number: 35
*/
function function___init__()
{
	if(!(isdefined(level.var_bgb_in_use) && level.var_bgb_in_use))
	{
		return;
	}
	namespace_bgb::function_register("zm_bgb_power_vacuum", "time", 300, &function_enable, &function_disable, undefined);
}

/*
	Name: function_enable
	Namespace: namespace_6cf54cb6
	Checksum: 0x424F4353
	Offset: 0x210
	Size: 0x70
	Parameters: 0
	Flags: None
	Line Number: 54
*/
function function_enable()
{
	self endon("hash_disconnect");
	self endon("hash_bled_out");
	self endon("hash_994d5e9e");
	level.var_powerup_drop_count = 0;
	while(1)
	{
		level waittill("hash_powerup_dropped");
		self namespace_bgb::function_do_one_shot_use();
		level.var_powerup_drop_count = 0;
	}
}

/*
	Name: function_disable
	Namespace: namespace_6cf54cb6
	Checksum: 0x424F4353
	Offset: 0x288
	Size: 0x4
	Parameters: 0
	Flags: None
	Line Number: 78
*/
function function_disable()
{
}

