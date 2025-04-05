#include scripts\codescripts\struct;
#include scripts\shared\flag_shared;
#include scripts\shared\system_shared;
#include scripts\shared\util_shared;
#include scripts\zm\_zm_bgb;
#include scripts\zm\_zm_utility;

#namespace namespace_350615e2;

/*
	Name: function___init__sytem__
	Namespace: namespace_350615e2
	Checksum: 0x424F4353
	Offset: 0x148
	Size: 0x38
	Parameters: 0
	Flags: AutoExec
	Line Number: 19
*/
function autoexec function___init__sytem__()
{
	namespace_system::function_register("zm_bgb_unquenchable", &function___init__, undefined, "bgb");
}

/*
	Name: function___init__
	Namespace: namespace_350615e2
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
	}
}

/*
	Name: function_event
	Namespace: namespace_350615e2
	Checksum: 0x424F4353
	Offset: 0x1B0
	Size: 0x64
	Parameters: 0
	Flags: None
	Line Number: 52
*/
function function_event()
{
	self endon("hash_82223b0f");
	self endon("hash_bae9baf2");
	do
	{
		self waittill("hash_797fbdf5");
	}
	while(!self.var_num_perks < self namespace_zm_utility::function_get_player_perk_purchase_limit());
	self namespace_bgb::function_do_one_shot_use(1);
}

