#include scripts\codescripts\struct;
#include scripts\shared\array_shared;
#include scripts\shared\clientfield_shared;
#include scripts\shared\flag_shared;
#include scripts\shared\system_shared;
#include scripts\shared\util_shared;
#include scripts\zm\_zm_bgb;
#include scripts\zm\_zm_score;
#include scripts\zm\_zm_utility;

#namespace namespace_19b2be8a;

/*
	Name: function___init__sytem__
	Namespace: namespace_19b2be8a
	Checksum: 0x424F4353
	Offset: 0x230
	Size: 0x38
	Parameters: 0
	Flags: AutoExec
	Line Number: 22
*/
function autoexec function___init__sytem__()
{
	namespace_system::function_register("zm_bgb_profit_sharing", &function___init__, undefined, "bgb");
}

/*
	Name: function___init__
	Namespace: namespace_19b2be8a
	Checksum: 0x424F4353
	Offset: 0x270
	Size: 0x20
	Parameters: 0
	Flags: None
	Line Number: 37
*/
function function___init__()
{
	if(!(isdefined(level.var_bgb_in_use) && level.var_bgb_in_use))
	{
		return;
	}
}

/*
	Name: function_enable
	Namespace: namespace_19b2be8a
	Checksum: 0x424F4353
	Offset: 0x298
	Size: 0x40
	Parameters: 0
	Flags: None
	Line Number: 55
*/
function function_enable()
{
	self endon("hash_82223b0f");
	self endon("hash_59590333");
	self endon("hash_bae9baf2");
	self thread function_677e212b();
}

/*
	Name: function_disable
	Namespace: namespace_19b2be8a
	Checksum: 0x424F4353
	Offset: 0x2E0
	Size: 0x8
	Parameters: 0
	Flags: None
	Line Number: 73
*/
function function_disable()
{
	return;
	waittillframeend;
}

/*
	Name: function_677e212b
	Namespace: namespace_19b2be8a
	Checksum: 0x424F4353
	Offset: 0x2F0
	Size: 0x88
	Parameters: 0
	Flags: None
	Line Number: 89
*/
function function_677e212b()
{
	self endon("hash_82223b0f");
	self namespace_clientfield::function_set("zm_bgb_profit_sharing_3p_fx", 1);
	self namespace_util::function_waittill_either("bled_out", "bgb_update");
	self namespace_clientfield::function_set("zm_bgb_profit_sharing_3p_fx", 0);
	self notify("hash_dd33a9fc");
	return;
	ERROR: Exception occured: Stack empty.
}

/*
	Name: function_ff41ae2d
	Namespace: namespace_19b2be8a
	Checksum: 0x424F4353
	Offset: 0x380
	Size: 0xE0
	Parameters: 1
	Flags: None
	Line Number: 110
*/
function function_ff41ae2d(var_e_player)
{
	self function_d1d595b5();
	var_e_player function_d1d595b5();
	var_str_notify = "profit_sharing_fx_stop_" + self function_GetEntityNumber();
	level namespace_util::function_waittill_any_ents(var_e_player, "disconnect", var_e_player, var_str_notify, self, "disconnect", self, "profit_sharing_complete");
	if(isdefined(self))
	{
		self function_c0b35f9d();
	}
	if(isdefined(var_e_player))
	{
		var_e_player function_c0b35f9d();
		return;
	}
}

/*
	Name: function_3c1690be
	Namespace: namespace_19b2be8a
	Checksum: 0x424F4353
	Offset: 0x468
	Size: 0x40
	Parameters: 1
	Flags: None
	Line Number: 137
*/
function function_3c1690be(var_e_player)
{
	var_str_notify = "profit_sharing_fx_stop_" + self function_GetEntityNumber();
	var_e_player notify(var_str_notify);
	return;
}

/*
	Name: function_d1d595b5
	Namespace: namespace_19b2be8a
	Checksum: 0x424F4353
	Offset: 0x4B0
	Size: 0x60
	Parameters: 0
	Flags: None
	Line Number: 154
*/
function function_d1d595b5()
{
	if(!isdefined(self.var_95b54) || self.var_95b54 == 0)
	{
		self.var_95b54 = 1;
		self namespace_clientfield::function_set_to_player("zm_bgb_profit_sharing_1p_fx", 1);
	}
	else
	{
		self.var_95b54++;
	}
}

/*
	Name: function_c0b35f9d
	Namespace: namespace_19b2be8a
	Checksum: 0x424F4353
	Offset: 0x518
	Size: 0x3C
	Parameters: 0
	Flags: None
	Line Number: 177
*/
function function_c0b35f9d()
{
	self.var_95b54--;
	if(self.var_95b54 == 0)
	{
		self namespace_clientfield::function_set_to_player("zm_bgb_profit_sharing_1p_fx", 0);
	}
}

