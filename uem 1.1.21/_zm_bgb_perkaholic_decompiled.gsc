#include scripts\codescripts\struct;
#include scripts\shared\flag_shared;
#include scripts\shared\system_shared;
#include scripts\shared\util_shared;
#include scripts\zm\_zm_bgb;
#include scripts\zm\_zm_perks;
#include scripts\zm\_zm_powerups;
#include scripts\zm\_zm_utility;

#namespace namespace_1b7b1237;

/*
	Name: function___init__sytem__
	Namespace: namespace_1b7b1237
	Checksum: 0x424F4353
	Offset: 0x178
	Size: 0x38
	Parameters: 0
	Flags: AutoExec
	Line Number: 21
*/
function autoexec function___init__sytem__()
{
	namespace_system::function_register("zm_bgb_perkaholic", &function___init__, undefined, "bgb");
}

/*
	Name: function___init__
	Namespace: namespace_1b7b1237
	Checksum: 0x424F4353
	Offset: 0x1B8
	Size: 0x20
	Parameters: 0
	Flags: None
	Line Number: 36
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
	Namespace: namespace_1b7b1237
	Checksum: 0x424F4353
	Offset: 0x1E0
	Size: 0x4C
	Parameters: 0
	Flags: None
	Line Number: 54
*/
function function_event()
{
	self endon("hash_82223b0f");
	self endon("hash_bae9baf2");
	self namespace_zm_utility::function_give_player_all_perks();
	self namespace_bgb::function_do_one_shot_use(1);
	wait(0.05);
}

