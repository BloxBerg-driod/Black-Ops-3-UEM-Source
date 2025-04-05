#include scripts\codescripts\struct;
#include scripts\shared\aat_shared;
#include scripts\shared\flag_shared;
#include scripts\shared\laststand_shared;
#include scripts\shared\system_shared;
#include scripts\shared\util_shared;
#include scripts\zm\_zm_bgb;
#include scripts\zm\_zm_powerups;
#include scripts\zm\_zm_stats;
#include scripts\zm\_zm_utility;
#include scripts\zm\_zm_weapons;

#namespace namespace_6d4de49;

/*
	Name: function___init__sytem__
	Namespace: namespace_6d4de49
	Checksum: 0x424F4353
	Offset: 0x1E8
	Size: 0x38
	Parameters: 0
	Flags: AutoExec
	Line Number: 24
*/
function autoexec function___init__sytem__()
{
	namespace_system::function_register("zm_bgb_ephemeral_enhancement", &function___init__, undefined, "bgb");
}

/*
	Name: function___init__
	Namespace: namespace_6d4de49
	Checksum: 0x424F4353
	Offset: 0x228
	Size: 0x20
	Parameters: 0
	Flags: None
	Line Number: 39
*/
function function___init__()
{
	if(!(isdefined(level.var_bgb_in_use) && level.var_bgb_in_use))
	{
		return;
	}
}

/*
	Name: function_79585675
	Namespace: namespace_6d4de49
	Checksum: 0x424F4353
	Offset: 0x250
	Size: 0x88
	Parameters: 1
	Flags: None
	Line Number: 57
*/
function function_79585675(var_19dc14f6)
{
	self endon("hash_f49a0cb");
	self endon("hash_82223b0f");
	self endon("hash_bae9baf2");
	self endon("hash_a059367d");
	while(1)
	{
		self waittill("hash_bfef13ac");
		if(!self namespace_zm_weapons::function_has_weapon_or_attachments(var_19dc14f6))
		{
			self notify("hash_bc599fd9");
			self.var_fb11234e = undefined;
			return;
		}
	}
}

