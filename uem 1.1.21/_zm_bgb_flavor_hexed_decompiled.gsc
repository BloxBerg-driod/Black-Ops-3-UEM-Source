#include scripts\codescripts\struct;
#include scripts\shared\ai\zombie_utility;
#include scripts\shared\array_shared;
#include scripts\shared\clientfield_shared;
#include scripts\shared\flag_shared;
#include scripts\shared\system_shared;
#include scripts\shared\util_shared;
#include scripts\zm\_zm;
#include scripts\zm\_zm_bgb;
#include scripts\zm\_zm_magicbox;
#include scripts\zm\_zm_unitrigger;
#include scripts\zm\_zm_utility;

#namespace namespace_3ecfcb30;

/*
	Name: function___init__sytem__
	Namespace: namespace_3ecfcb30
	Checksum: 0x424F4353
	Offset: 0x240
	Size: 0x38
	Parameters: 0
	Flags: AutoExec
	Line Number: 25
*/
function autoexec function___init__sytem__()
{
	namespace_system::function_register("zm_bgb_flavor_hexed", &function___init__, undefined, "bgb");
}

/*
	Name: function___init__
	Namespace: namespace_3ecfcb30
	Checksum: 0x424F4353
	Offset: 0x280
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
	namespace_bgb::function_register("zm_bgb_flavor_hexed", "event", &function_event, undefined, undefined, undefined);
	return;
	ERROR: Bad function call
}

/*
	Name: function_event
	Namespace: namespace_3ecfcb30
	Checksum: 0x424F4353
	Offset: 0x2E0
	Size: 0x1B0
	Parameters: 0
	Flags: None
	Line Number: 61
*/
function function_event()
{
	self endon("hash_disconnect");
	self endon("hash_bled_out");
	self.var_c3a5a8 = [];
	var_2cf032a6 = self.var_98ba48a2;
	foreach(var_410edbc8 in level.var_bgb)
	{
		if(!function_IsInArray(var_2cf032a6, var_23359ff6) && var_23359ff6 != "zm_bgb_flavor_hexed")
		{
			if(!isdefined(self.var_c3a5a8))
			{
				self.var_c3a5a8 = [];
			}
			else if(!function_IsArray(self.var_c3a5a8))
			{
				self.var_c3a5a8 = function_Array(self.var_c3a5a8);
			}
			self.var_c3a5a8[self.var_c3a5a8.size] = var_23359ff6;
		}
	}
	/#
		/#
			namespace_::function_Assert(self.var_c3a5a8.size, "Dev Block strings are not supported");
		#/
	#/
	var_50f0f8bb = namespace_Array::function_random(var_2cf032a6);
	self thread function_9a45adfb(var_50f0f8bb);
}

/*
	Name: function_9a45adfb
	Namespace: namespace_3ecfcb30
	Checksum: 0x424F4353
	Offset: 0x498
	Size: 0x88
	Parameters: 1
	Flags: None
	Line Number: 101
*/
function function_9a45adfb(var_50f0f8bb)
{
	wait(1);
	self thread function_655e0571(var_50f0f8bb);
	self function_playsoundtoplayer("zmb_bgb_flavorhex", self);
	self thread namespace_bgb::function_give(var_50f0f8bb);
	function_ArrayRemoveValue(self.var_c3a5a8, var_50f0f8bb);
}

/*
	Name: function_655e0571
	Namespace: namespace_3ecfcb30
	Checksum: 0x424F4353
	Offset: 0x528
	Size: 0x108
	Parameters: 1
	Flags: None
	Line Number: 120
*/
function function_655e0571(var_50f0f8bb)
{
	self endon("hash_disconnect");
	self endon("hash_bled_out");
	self endon("hash_fcbbef99");
	self waittill("bgb_update_give_" + var_50f0f8bb);
	self notify("bgb_flavor_hexed_give_" + var_50f0f8bb);
	self waittill("hash_994d5e9e", var_1531e8c4, var_9a4acf7);
	if(var_9a4acf7 === var_50f0f8bb && self.var_c3a5a8.size)
	{
		var_df8558a0 = namespace_Array::function_random(self.var_c3a5a8);
		self function_playsoundtoplayer("zmb_bgb_flavorhex", self);
		self thread function_21f6c6f5(var_df8558a0);
		self namespace_bgb::function_give(var_df8558a0);
		return;
	}
	ERROR: Exception occured: Index was out of range. Must be non-negative and less than the size of the collection.
Parameter name: index
}

/*
	Name: function_21f6c6f5
	Namespace: namespace_3ecfcb30
	Checksum: 0x424F4353
	Offset: 0x638
	Size: 0x48
	Parameters: 1
	Flags: None
	Line Number: 150
*/
function function_21f6c6f5(var_50f0f8bb)
{
	self endon("hash_disconnect");
	self endon("hash_bled_out");
	self waittill("bgb_update_give_" + var_50f0f8bb);
	self notify("bgb_flavor_hexed_give_" + var_50f0f8bb);
}

