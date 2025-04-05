#include scripts\codescripts\struct;
#include scripts\shared\array_shared;
#include scripts\shared\callbacks_shared;
#include scripts\shared\flag_shared;
#include scripts\shared\gameobjects_shared;
#include scripts\shared\math_shared;
#include scripts\shared\system_shared;
#include scripts\shared\util_shared;

#namespace namespace_917c15bb;

/*
	Name: function___init__sytem__
	Namespace: namespace_917c15bb
	Checksum: 0x424F4353
	Offset: 0x208
	Size: 0x38
	Parameters: 0
	Flags: AutoExec
	Line Number: 21
*/
function autoexec function___init__sytem__()
{
	namespace_system::function_register("inspectable", &function_init, undefined, undefined);
	return;
	ERROR: Exception occured: Stack empty.
}

/*
	Name: function_init
	Namespace: namespace_917c15bb
	Checksum: 0x424F4353
	Offset: 0x248
	Size: 0x60
	Parameters: 0
	Flags: None
	Line Number: 38
*/
function function_init()
{
	level.var_1509cd8 = 1;
	level.var_b3744357 = 1;
	namespace_callback::function_on_connect(&function_db8c7c17);
	namespace_callback::function_on_spawned(&function_4681ec99);
}

/*
	Name: function_4681ec99
	Namespace: namespace_917c15bb
	Checksum: 0x424F4353
	Offset: 0x2B0
	Size: 0x10
	Parameters: 0
	Flags: None
	Line Number: 56
*/
function function_4681ec99()
{
	self.var_8ed070f5 = 0;
}

/*
	Name: function_80b825eb
	Namespace: namespace_917c15bb
	Checksum: 0x424F4353
	Offset: 0x2C8
	Size: 0x3C8
	Parameters: 0
	Flags: None
	Line Number: 71
*/
function function_80b825eb()
{
	var_trigs = [];
	if(!isdefined(var_trigs))
	{
		var_trigs = [];
	}
	else if(!function_IsArray(var_trigs))
	{
		var_trigs = function_Array(var_trigs);
	}
	var_trigs[var_trigs.size] = function_GetEntArray("trigger_use", "classname");
	if(!isdefined(var_trigs))
	{
		var_trigs = [];
	}
	else if(!function_IsArray(var_trigs))
	{
		var_trigs = function_Array(var_trigs);
	}
	var_trigs[var_trigs.size] = function_GetEntArray("trigger_radius", "classname");
	if(!isdefined(var_trigs))
	{
		var_trigs = [];
	}
	else if(!function_IsArray(var_trigs))
	{
		var_trigs = function_Array(var_trigs);
	}
	var_trigs[var_trigs.size] = function_GetEntArray("trigger_use_touch", "classname");
	foreach(var_44af1788 in var_trigs)
	{
		foreach(var_trig in var_44af1788)
		{
			if(function_IsSubStr(var_trig.var_classname, "use") || function_IsSubStr(var_trig.var_classname, "exterior_goal") || (isdefined(var_trig.var_aa8e5bd9) && var_trig.var_aa8e5bd9))
			{
				if(self function_istouching(var_trig))
				{
					return 1;
				}
			}
		}
	}
	var_zbarriers = namespace_struct::function_get_array("exterior_goal", "targetname");
	foreach(var_z in var_zbarriers)
	{
		if(function_Distance(self.var_origin, var_z.var_origin) < 100)
		{
			return 1;
		}
	}
	return 0;
}

/*
	Name: function_db8c7c17
	Namespace: namespace_917c15bb
	Checksum: 0x424F4353
	Offset: 0x698
	Size: 0x2C8
	Parameters: 0
	Flags: None
	Line Number: 135
*/
function function_db8c7c17()
{
	self endon("hash_disconnect");
	self.var_f4d01b67["inspect_animations"] = function_Int(0);
	while(self function_ReloadButtonPressed() && self.var_f4d01b67["inspect_animations"] == 0)
	{
		if(level.var_1509cd8)
		{
			if(self function_GetStance() == "prone")
			{
				wait(0.05);
			}
		}
		else
		{
			wait(0.05);
			else if(self function_GamepadUsedLast())
			{
				wait(1.1);
			}
			else
			{
				wait(0.7);
			}
			var_2a37d388 = self function_6516d030();
			if(self function_ReloadButtonPressed() && var_2a37d388 && !self function_IsReloading() && !self function_IsSwitchingWeapons() && !self function_isUsingOffhand() && !self function_IsThrowingGrenade())
			{
				self function_DisableWeaponCycling();
				self thread function_53918d7f();
				self thread function_7cd522b7();
				if(level.var_1509cd8)
				{
					self function_AllowedStances("crouch", "stand");
				}
				self function_c389c47b();
				self function_7af78cbd();
			}
			wait(0.05);
		}
		else if(self function_GetWeaponAmmoClip(self function_GetCurrentWeapon()) != self function_GetCurrentWeapon().var_clipSize || (self function_GetWeaponAmmoClip(self function_GetCurrentWeapon()) == 0 && self function_GetWeaponAmmoStock(self function_GetCurrentWeapon()) != 0))
		{
		}
	}
}

/*
	Name: function_7cd522b7
	Namespace: namespace_917c15bb
	Checksum: 0x424F4353
	Offset: 0x968
	Size: 0x68
	Parameters: 0
	Flags: None
	Line Number: 190
*/
function function_7cd522b7()
{
	self endon("hash_disconnect");
	self endon("hash_39c443be");
	self endon("hash_cb505dfb");
	self endon("hash_death");
	self endon("hash_fake_death");
	self endon("hash_player_downed");
	self waittill("hash_weapon_change");
	self notify("hash_cb505dfb");
}

/*
	Name: function_53918d7f
	Namespace: namespace_917c15bb
	Checksum: 0x424F4353
	Offset: 0x9D8
	Size: 0xA8
	Parameters: 0
	Flags: None
	Line Number: 212
*/
function function_53918d7f()
{
	self endon("hash_disconnect");
	self endon("hash_39c443be");
	self endon("hash_cb505dfb");
	self endon("hash_death");
	self endon("hash_fake_death");
	self endon("hash_player_downed");
	while(self function_AttackButtonPressed() || self function_SprintButtonPressed() || self function_meleeButtonPressed())
	{
		self notify("hash_cb505dfb");
		wait(0.05);
	}
}

/*
	Name: function_c389c47b
	Namespace: namespace_917c15bb
	Checksum: 0x424F4353
	Offset: 0xA88
	Size: 0x90
	Parameters: 0
	Flags: None
	Line Number: 237
*/
function function_c389c47b()
{
	self endon("hash_disconnect");
	self endon("hash_cb505dfb");
	self endon("hash_death");
	self endon("hash_fake_death");
	self endon("hash_player_downed");
	self.var_8ed070f5 = 1;
	self function_SetLowReady(1);
	wait(function_9d7def6a(self function_GetCurrentWeapon()));
	return;
	~self.var_8ed070f5;
}

/*
	Name: function_7af78cbd
	Namespace: namespace_917c15bb
	Checksum: 0x424F4353
	Offset: 0xB20
	Size: 0x90
	Parameters: 0
	Flags: None
	Line Number: 261
*/
function function_7af78cbd()
{
	self endon("hash_disconnect");
	self notify("hash_39c443be");
	self.var_8ed070f5 = 0;
	self function_SetLowReady(0);
	self function_EnableWeaponCycling();
	if(level.var_1509cd8)
	{
		self function_AllowedStances("crouch", "stand", "prone");
		return;
	}
	ERROR: Exception occured: Stack empty.
}

/*
	Name: function_f3798296
	Namespace: namespace_917c15bb
	Checksum: 0x424F4353
	Offset: 0xBB8
	Size: 0x1A0
	Parameters: 2
	Flags: None
	Line Number: 286
*/
function function_f3798296(var_4d304636, var_iTime)
{
	if(!isdefined(var_4d304636) || !isdefined(var_iTime))
	{
		return;
	}
	if(!isdefined(level.var_3f8c8095))
	{
		level.var_3f8c8095 = [];
	}
	foreach(var_3f8c8095 in level.var_3f8c8095)
	{
		if(var_4d304636.var_rootweapon.var_name == var_3f8c8095.var_weapon.var_name)
		{
			return;
		}
	}
	var_struct = function_spawnstruct();
	var_struct.var_weapon = var_4d304636;
	var_struct.var_iTime = var_iTime;
	if(!isdefined(level.var_3f8c8095))
	{
		level.var_3f8c8095 = [];
	}
	else if(!function_IsArray(level.var_3f8c8095))
	{
		level.var_3f8c8095 = function_Array(level.var_3f8c8095);
	}
	level.var_3f8c8095[level.var_3f8c8095.size] = var_struct;
}

/*
	Name: function_9d7def6a
	Namespace: namespace_917c15bb
	Checksum: 0x424F4353
	Offset: 0xD60
	Size: 0xC0
	Parameters: 1
	Flags: None
	Line Number: 327
*/
function function_9d7def6a(var_4d304636)
{
	foreach(var_3f8c8095 in level.var_3f8c8095)
	{
		if(var_4d304636.var_rootweapon.var_name == var_3f8c8095.var_weapon.var_name)
		{
			return var_3f8c8095.var_iTime;
		}
	}
	return 0;
}

/*
	Name: function_6516d030
	Namespace: namespace_917c15bb
	Checksum: 0x424F4353
	Offset: 0xE28
	Size: 0xCE
	Parameters: 0
	Flags: None
	Line Number: 349
*/
function function_6516d030()
{
	var_4d304636 = self function_GetCurrentWeapon();
	foreach(var_3f8c8095 in level.var_3f8c8095)
	{
		if(var_4d304636.var_rootweapon.var_name == var_3f8c8095.var_weapon.var_name)
		{
			return 1;
		}
	}
	return 0;
}

