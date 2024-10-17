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
	Name: __init__sytem__
	Namespace: namespace_917c15bb
	Checksum: 0x424F4353
	Offset: 0x208
	Size: 0x38
	Parameters: 0
	Flags: AutoExec
	Line Number: 21
*/
function autoexec __init__sytem__()
{
	system::register("inspectable", &init, undefined, undefined);
}

/*
	Name: init
	Namespace: namespace_917c15bb
	Checksum: 0x424F4353
	Offset: 0x248
	Size: 0x60
	Parameters: 0
	Flags: None
	Line Number: 36
*/
function init()
{
	level.var_1509cd8 = 1;
	level.var_b3744357 = 1;
	callback::on_connect(&function_db8c7c17);
	callback::on_spawned(&function_4681ec99);
	return;
	ERROR: Exception occured: Stack empty.
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
	trigs = [];
	if(!isdefined(trigs))
	{
		trigs = [];
	}
	else if(!isarray(trigs))
	{
		trigs = array(trigs);
	}
	trigs[trigs.size] = getentarray("trigger_use", "classname");
	if(!isdefined(trigs))
	{
		trigs = [];
	}
	else if(!isarray(trigs))
	{
		trigs = array(trigs);
	}
	trigs[trigs.size] = getentarray("trigger_radius", "classname");
	if(!isdefined(trigs))
	{
		trigs = [];
	}
	else if(!isarray(trigs))
	{
		trigs = array(trigs);
	}
	trigs[trigs.size] = getentarray("trigger_use_touch", "classname");
	foreach(var_44af1788 in trigs)
	{
		foreach(trig in var_44af1788)
		{
			if(issubstr(trig.classname, "use") || issubstr(trig.classname, "exterior_goal") || (isdefined(trig.var_aa8e5bd9) && trig.var_aa8e5bd9))
			{
				if(self istouching(trig))
				{
					return 1;
				}
			}
		}
	}
	zbarriers = struct::get_array("exterior_goal", "targetname");
	foreach(z in zbarriers)
	{
		if(distance(self.origin, z.origin) < 100)
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
	self endon("disconnect");
	self.var_f4d01b67["inspect_animations"] = int(0);
	while(self ReloadButtonPressed() && self.var_f4d01b67["inspect_animations"] == 0)
	{
		if(level.var_1509cd8)
		{
			if(self getstance() == "prone")
			{
				wait(0.05);
			}
		}
		else
		{
			wait(0.05);
			else if(self GamepadUsedLast())
			{
				wait(1.1);
			}
			else
			{
				wait(0.7);
			}
			var_2a37d388 = self function_6516d030();
			if(self ReloadButtonPressed() && var_2a37d388 && !self isreloading() && !self isswitchingweapons() && !self isusingoffhand() && !self IsThrowingGrenade())
			{
				self disableweaponcycling();
				self thread function_53918d7f();
				self thread function_7cd522b7();
				if(level.var_1509cd8)
				{
					self AllowedStances("crouch", "stand");
				}
				self function_c389c47b();
				self function_7af78cbd();
			}
			wait(0.05);
		}
		else if(self getweaponammoclip(self getcurrentweapon()) != self getcurrentweapon().clipsize || (self getweaponammoclip(self getcurrentweapon()) == 0 && self getweaponammostock(self getcurrentweapon()) != 0))
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
	self endon("disconnect");
	self endon("hash_39c443be");
	self endon("hash_cb505dfb");
	self endon("death");
	self endon("fake_death");
	self endon("player_downed");
	self waittill("weapon_change");
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
	self endon("disconnect");
	self endon("hash_39c443be");
	self endon("hash_cb505dfb");
	self endon("death");
	self endon("fake_death");
	self endon("player_downed");
	while(self attackbuttonpressed() || self SprintButtonPressed() || self meleebuttonpressed())
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
	self endon("disconnect");
	self endon("hash_cb505dfb");
	self endon("death");
	self endon("fake_death");
	self endon("player_downed");
	self.var_8ed070f5 = 1;
	self setlowready(1);
	wait(function_9d7def6a(self getcurrentweapon()));
}

/*
	Name: function_7af78cbd
	Namespace: namespace_917c15bb
	Checksum: 0x424F4353
	Offset: 0xB20
	Size: 0x90
	Parameters: 0
	Flags: None
	Line Number: 259
*/
function function_7af78cbd()
{
	self endon("disconnect");
	self notify("hash_39c443be");
	self.var_8ed070f5 = 0;
	self setlowready(0);
	self enableweaponcycling();
	if(level.var_1509cd8)
	{
		self AllowedStances("crouch", "stand", "prone");
	}
}

/*
	Name: function_f3798296
	Namespace: namespace_917c15bb
	Checksum: 0x424F4353
	Offset: 0xBB8
	Size: 0x1A0
	Parameters: 2
	Flags: None
	Line Number: 282
*/
function function_f3798296(var_4d304636, iTime)
{
	if(!isdefined(var_4d304636) || !isdefined(iTime))
	{
		return;
	}
	if(!isdefined(level.var_3f8c8095))
	{
		level.var_3f8c8095 = [];
	}
	foreach(var_3f8c8095 in level.var_3f8c8095)
	{
		if(var_4d304636.rootweapon.name == var_3f8c8095.weapon.name)
		{
			return;
		}
	}
	struct = spawnstruct();
	struct.weapon = var_4d304636;
	struct.iTime = iTime;
	if(!isdefined(level.var_3f8c8095))
	{
		level.var_3f8c8095 = [];
	}
	else if(!isarray(level.var_3f8c8095))
	{
		level.var_3f8c8095 = array(level.var_3f8c8095);
	}
	level.var_3f8c8095[level.var_3f8c8095.size] = struct;
}

/*
	Name: function_9d7def6a
	Namespace: namespace_917c15bb
	Checksum: 0x424F4353
	Offset: 0xD60
	Size: 0xC0
	Parameters: 1
	Flags: None
	Line Number: 323
*/
function function_9d7def6a(var_4d304636)
{
	foreach(var_3f8c8095 in level.var_3f8c8095)
	{
		if(var_4d304636.rootweapon.name == var_3f8c8095.weapon.name)
		{
			return var_3f8c8095.iTime;
		}
	}
	return 0;
	ERROR: Exception occured: Stack empty.
}

/*
	Name: function_6516d030
	Namespace: namespace_917c15bb
	Checksum: 0x424F4353
	Offset: 0xE28
	Size: 0xCE
	Parameters: 0
	Flags: None
	Line Number: 346
*/
function function_6516d030()
{
	var_4d304636 = self getcurrentweapon();
	foreach(var_3f8c8095 in level.var_3f8c8095)
	{
		if(var_4d304636.rootweapon.name == var_3f8c8095.weapon.name)
		{
			return 1;
		}
	}
	return 0;
}

