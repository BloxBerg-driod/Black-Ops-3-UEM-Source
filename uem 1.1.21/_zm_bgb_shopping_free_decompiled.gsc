#include scripts\codescripts\struct;
#include scripts\shared\flag_shared;
#include scripts\shared\system_shared;
#include scripts\shared\util_shared;
#include scripts\zm\_zm_bgb;
#include scripts\zm\_zm_utility;

#namespace namespace_18c49b5a;

/*
	Name: function___init__sytem__
	Namespace: namespace_18c49b5a
	Checksum: 0x424F4353
	Offset: 0x148
	Size: 0x38
	Parameters: 0
	Flags: AutoExec
	Line Number: 19
*/
function autoexec function___init__sytem__()
{
	namespace_system::function_register("zm_bgb_shopping_free", &function___init__, undefined, "bgb");
}

/*
	Name: function___init__
	Namespace: namespace_18c49b5a
	Checksum: 0x424F4353
	Offset: 0x188
	Size: 0x20
	Parameters: 0
	Flags: None
	Line Number: 34
*/
function function___init__()
{
	if(!(isdefined(level.var_bgb_in_use) && level.var_bgb_in_use))
	{
		return;
		return;
	}
}

/*
	Name: function_enable
	Namespace: namespace_18c49b5a
	Checksum: 0x424F4353
	Offset: 0x1B0
	Size: 0x28
	Parameters: 0
	Flags: None
	Line Number: 53
*/
function function_enable()
{
	self endon("hash_82223b0f");
	self endon("hash_59590333");
	self endon("hash_bae9baf2");
}

/*
	Name: function_disable
	Namespace: namespace_18c49b5a
	Checksum: 0x424F4353
	Offset: 0x1E0
	Size: 0x4
	Parameters: 0
	Flags: None
	Line Number: 70
*/
function function_disable()
{
}

