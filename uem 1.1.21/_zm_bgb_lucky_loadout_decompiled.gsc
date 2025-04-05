#include scripts\codescripts\struct;
#include scripts\shared\array_shared;
#include scripts\shared\flag_shared;
#include scripts\shared\system_shared;
#include scripts\shared\util_shared;
#include scripts\sphynx\leveling\_zm_sphynx_leveling;
#include scripts\zm\_zm_bgb;
#include scripts\zm\_zm_powerups;
#include scripts\zm\_zm_utility;
#include scripts\zm\_zm_weapon_upgrade_system;
#include scripts\zm\_zm_weapons;

#namespace namespace_c341bb92;

/*
	Name: function___init__sytem__
	Namespace: namespace_c341bb92
	Checksum: 0x424F4353
	Offset: 0x270
	Size: 0x38
	Parameters: 0
	Flags: AutoExec
	Line Number: 24
*/
function autoexec function___init__sytem__()
{
	namespace_system::function_register("zm_bgb_lucky_loadout", &function___init__, undefined, "bgb");
}

/*
	Name: function___init__
	Namespace: namespace_c341bb92
	Checksum: 0x424F4353
	Offset: 0x2B0
	Size: 0x58
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
	namespace_bgb::function_register("zm_bgb_lucky_loadout", "activated", 1, undefined, undefined, undefined, &function_activation);
}

/*
	Name: function_activation
	Namespace: namespace_c341bb92
	Checksum: 0x424F4353
	Offset: 0x310
	Size: 0x80
	Parameters: 0
	Flags: None
	Line Number: 58
*/
function function_activation()
{
	while(self function_GetCurrentWeapon().var_name == "zombie_bgb_use" || self function_GetCurrentWeapon().var_name == "zombie_bgb_grab")
	{
		wait(0.5);
	}
	self function_4035ce17();
}

/*
	Name: function_4035ce17
	Namespace: namespace_c341bb92
	Checksum: 0x424F4353
	Offset: 0x398
	Size: 0x5A0
	Parameters: 0
	Flags: None
	Line Number: 77
*/
function function_4035ce17()
{
	var_a1772e8c = function_Array();
	var_137e9dc7 = function_Array();
	var_ed7c235e = function_Array();
	foreach(var_weapon in level.var_e6522d0f)
	{
		if(isdefined(level.var_3e85df60) && level.var_3e85df60 && isdefined(var_weapon.var_3c4d7cf6) && var_weapon.var_5a818793 == "false")
		{
			continue;
		}
		if(var_weapon.var_weight == "1" || var_weapon.var_weight == 1)
		{
			function_ArrayInsert(var_a1772e8c, var_weapon.var_name, var_a1772e8c.size);
		}
		if(var_weapon.var_weight == "2" || var_weapon.var_weight == 2)
		{
			function_ArrayInsert(var_137e9dc7, var_weapon.var_name, var_137e9dc7.size);
		}
		if(var_weapon.var_weight == "3" || var_weapon.var_weight == 3)
		{
			function_ArrayInsert(var_ed7c235e, var_weapon.var_name, var_ed7c235e.size);
		}
	}
	var_65ddf7d1 = self function_2a7caadc(var_a1772e8c, var_137e9dc7, var_ed7c235e);
	if(level.var_round_number >= 8 && (!(isdefined(self.var_8217da2b) && self.var_8217da2b)) && isdefined(self.var_d27d944e) && self.var_d27d944e != 0)
	{
		self.var_8217da2b = 1;
		var_65ddf7d1 = level.var_e6522d0f[self.var_d27d944e].var_name;
	}
	var_a0dc0ad9 = function_should_upgrade_weapon();
	if(isdefined(var_a0dc0ad9) && var_a0dc0ad9)
	{
		var_af263d1d = self namespace_5e1f56dc::function_49e2047b();
	}
	if(isdefined(var_af263d1d) && var_af263d1d > 0)
	{
		if(isdefined(self namespace_5e1f56dc::function_92bf1671(function_GetWeapon(var_65ddf7d1))) && self namespace_5e1f56dc::function_92bf1671(function_GetWeapon(var_65ddf7d1)))
		{
			var_12030910 = namespace_zm_weapons::function_get_upgrade_weapon(function_GetWeapon(var_65ddf7d1), 0);
			var_12030910 = self function_GetBuildKitWeapon(var_12030910, 1);
			var_w_give = self namespace_zm_weapons::function_weapon_give(var_12030910, 1, 1);
			self thread namespace_5e1f56dc::function_9c955ddd(var_af263d1d, var_w_give);
			self thread namespace_97ac1184::function_b3489bf5("^3" + self.var_playerName + "^7 acquired a ^9Enchanted " + function_MakeLocalizedString(var_w_give.var_displayName) + " ^7from Lucky Loadout");
		}
		else
		{
			var_w_give = self namespace_zm_weapons::function_weapon_give(function_GetWeapon(var_65ddf7d1), 0, 1);
			self thread namespace_97ac1184::function_b3489bf5("^3" + self.var_playerName + "^7 acquired a ^9" + function_MakeLocalizedString(var_w_give.var_displayName) + " ^7from Lucky Loadout");
		}
	}
	else
	{
		var_w_give = self namespace_zm_weapons::function_weapon_give(function_GetWeapon(var_65ddf7d1), 0, 1);
		self thread namespace_97ac1184::function_b3489bf5("^3" + self.var_playerName + "^7 acquired a ^9" + function_MakeLocalizedString(var_w_give.var_displayName) + " ^7from Lucky Loadout");
	}
}

/*
	Name: function_should_upgrade_weapon
	Namespace: namespace_c341bb92
	Checksum: 0x424F4353
	Offset: 0x940
	Size: 0x90
	Parameters: 0
	Flags: None
	Line Number: 145
*/
function function_should_upgrade_weapon()
{
	if(level.var_round_number >= 20 && level.var_round_number <= 36)
	{
		var_index = level.var_round_number - 19;
		if(function_randomIntRange(0, 100) < var_index * 10)
		{
		}
		else
		{
			return 0;
		}
	}
	else if(level.var_round_number >= 37)
	{
		return 1;
	}
	return 0;
}

/*
	Name: function_2a7caadc
	Namespace: namespace_c341bb92
	Checksum: 0x424F4353
	Offset: 0x9D8
	Size: 0x1DA
	Parameters: 3
	Flags: None
	Line Number: 175
*/
function function_2a7caadc(var_a1772e8c, var_137e9dc7, var_ed7c235e)
{
	var_b190f3eb = function_ArrayCombine(var_a1772e8c, var_137e9dc7, 0, 1);
	var_8b8e7982 = function_ArrayCombine(var_b190f3eb, var_ed7c235e, 0, 1);
	if(level.var_round_number < 5)
	{
		var_53b14f6a = namespace_Array::function_randomize(var_a1772e8c);
	}
	else if(level.var_round_number >= 5)
	{
		var_53b14f6a = namespace_Array::function_randomize(var_b190f3eb);
	}
	else
	{
		var_53b14f6a = namespace_Array::function_randomize(var_8b8e7982);
	}
	foreach(var_weapon in self function_GetWeaponsListPrimaries())
	{
		if(var_53b14f6a == var_weapon[0])
		{
			if(var_53b14f6a == var_weapon[1])
			{
				if(var_53b14f6a == var_weapon[2])
				{
					return var_53b14f6a[3];
				}
				return var_53b14f6a[2];
			}
			return var_53b14f6a[1];
		}
	}
	return var_53b14f6a[0];
}

