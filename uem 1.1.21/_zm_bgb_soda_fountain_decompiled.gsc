#include scripts\codescripts\struct;
#include scripts\shared\array_shared;
#include scripts\shared\flag_shared;
#include scripts\shared\system_shared;
#include scripts\shared\util_shared;
#include scripts\zm\_zm_bgb;
#include scripts\zm\_zm_perks;
#include scripts\zm\_zm_utility;

#namespace namespace_78eb0295;

/*
	Name: function___init__sytem__
	Namespace: namespace_78eb0295
	Checksum: 0x424F4353
	Offset: 0x188
	Size: 0x38
	Parameters: 0
	Flags: AutoExec
	Line Number: 21
*/
function autoexec function___init__sytem__()
{
	namespace_system::function_register("zm_bgb_soda_fountain", &function___init__, undefined, "bgb");
}

/*
	Name: function___init__
	Namespace: namespace_78eb0295
	Checksum: 0x424F4353
	Offset: 0x1C8
	Size: 0x58
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
	namespace_bgb::function_register("zm_bgb_soda_fountain", "event", &function_event, undefined, undefined, undefined);
}

/*
	Name: function_event
	Namespace: namespace_78eb0295
	Checksum: 0x424F4353
	Offset: 0x228
	Size: 0x180
	Parameters: 0
	Flags: None
	Line Number: 55
*/
function function_event()
{
	self endon("hash_disconnect");
	self endon("hash_994d5e9e");
	self.var_76382430 = 5;
	while(self.var_76382430 > 0)
	{
		self waittill("hash_perk_purchased", var_str_perk);
		self namespace_bgb::function_do_one_shot_use();
		var_a_str_perks = function_getArrayKeys(level.var__custom_perks);
		if(function_IsInArray(var_a_str_perks, var_str_perk))
		{
			function_ArrayRemoveValue(var_a_str_perks, var_str_perk);
		}
		var_a_str_perks = namespace_Array::function_randomize(var_a_str_perks);
		for(var_i = 0; var_i < var_a_str_perks.size; var_i++)
		{
			wait(0.5);
			if(!self function_hasPerk(var_a_str_perks[var_i]))
			{
				self namespace_zm_perks::function_give_perk(var_a_str_perks[var_i], 0);
				break;
			}
		}
		self.var_76382430--;
		self namespace_bgb::function_set_timer(self.var_76382430, 5);
	}
}

