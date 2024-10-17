#include scripts\codescripts\struct;
#include scripts\shared\ai\zombie_utility;
#include scripts\shared\array_shared;
#include scripts\shared\callbacks_shared;
#include scripts\shared\clientfield_shared;
#include scripts\shared\exploder_shared;
#include scripts\shared\flag_shared;
#include scripts\shared\laststand_shared;
#include scripts\shared\lui_shared;
#include scripts\shared\math_shared;
#include scripts\shared\scene_shared;
#include scripts\shared\system_shared;
#include scripts\shared\util_shared;
#include scripts\sphynx\leveling\_zm_sphynx_leveling;
#include scripts\zm\_zm_equipment;
#include scripts\zm\_zm_utility;
#include scripts\zm\_zm_weapon_upgrade_system;
#include scripts\zm\_zm_weapons;

#namespace namespace_456c991e;

/*
	Name: __init__sytem__
	Namespace: namespace_456c991e
	Checksum: 0x424F4353
	Offset: 0x480
	Size: 0x40
	Parameters: 0
	Flags: AutoExec
	Line Number: 31
*/
function autoexec __init__sytem__()
{
	system::register("zm_zombies_ultimate_hud", &__init__, &__main__, undefined);
}

/*
	Name: __init__
	Namespace: namespace_456c991e
	Checksum: 0x424F4353
	Offset: 0x4C8
	Size: 0x98
	Parameters: 0
	Flags: None
	Line Number: 46
*/
function __init__()
{
	clientfield::register("clientuimodel", "ZMBU.MuleKick", 1, 1, "int");
	clientfield::register("clientuimodel", "ZMBU.rage_inducer", 1, 1, "int");
	clientfield::register("clientuimodel", "ZMBU.WeaponPapLevel", 1, 4, "int");
}

/*
	Name: __main__
	Namespace: namespace_456c991e
	Checksum: 0x424F4353
	Offset: 0x568
	Size: 0xA8
	Parameters: 0
	Flags: None
	Line Number: 63
*/
function __main__()
{
	callback::on_spawned(&function_28217684);
	callback::on_spawned(&function_4659d62);
	callback::on_spawned(&function_a6f1e7f0);
	callback::on_spawned(&function_68ebef1d);
	callback::on_spawned(&function_e891e4f9);
}

/*
	Name: function_e891e4f9
	Namespace: namespace_456c991e
	Checksum: 0x424F4353
	Offset: 0x618
	Size: 0x100
	Parameters: 0
	Flags: None
	Line Number: 82
*/
function function_e891e4f9()
{
	self endon("bled_out");
	self endon("spawned_player");
	self endon("disconnect");
	wait(0.05);
	level flag::wait_till("initial_blackscreen_passed");
	var_fb5258da = 0;
	for(;;)
	{
		wait(0.05);
		var_ec5f9c56 = zombie_utility::get_current_zombie_count() + level.zombie_total;
		if(var_fb5258da != var_ec5f9c56)
		{
			if(isdefined(level.zombie_actor_limit) && level.zombie_actor_limit != 0)
			{
				self thread namespace_97ac1184::function_8c165b4d("Data", "ZombiesLeft", var_ec5f9c56 + ":" + level.zombie_actor_limit);
				var_fb5258da = var_ec5f9c56;
			}
		}
	}
}

/*
	Name: function_68ebef1d
	Namespace: namespace_456c991e
	Checksum: 0x424F4353
	Offset: 0x720
	Size: 0x160
	Parameters: 0
	Flags: None
	Line Number: 115
*/
function function_68ebef1d()
{
	self endon("bled_out");
	self endon("spawned_player");
	self endon("disconnect");
	wait(0.05);
	level flag::wait_till("initial_blackscreen_passed");
	while(1)
	{
		if(isdefined(self))
		{
			if(zm_utility::is_player_valid(self))
			{
				w_current = self getcurrentweapon();
				w_current = zm_weapons::get_nonalternate_weapon(w_current);
				if(isdefined(w_current.rootweapon))
				{
					w_current = w_current.rootweapon;
				}
				var_7750a3aa = self namespace_5e1f56dc::function_1239e0ad(w_current);
				if(isdefined(var_7750a3aa))
				{
					self clientfield::set_player_uimodel("ZMBU.WeaponPapLevel", var_7750a3aa.var_a39a2843);
				}
				else
				{
					self clientfield::set_player_uimodel("ZMBU.WeaponPapLevel", 0);
				}
			}
		}
		wait(0.1);
	}
}

/*
	Name: function_762bdac0
	Namespace: namespace_456c991e
	Checksum: 0x424F4353
	Offset: 0x888
	Size: 0x118
	Parameters: 0
	Flags: None
	Line Number: 159
*/
function function_762bdac0()
{
	self endon("bled_out");
	self endon("spawned_player");
	self endon("disconnect");
	wait(0.05);
	level flag::wait_till("initial_blackscreen_passed");
	while(1)
	{
		if(isdefined(self))
		{
			if(zm_utility::is_player_valid(self))
			{
				if(!self clientfield::get_player_uimodel("ZMBU.Health") === self.health)
				{
					self clientfield::set_player_uimodel("ZMBU.Health", self.health);
				}
			}
			else if(!self clientfield::get_player_uimodel("ZMBU.Health") === 0)
			{
				self clientfield::set_player_uimodel("ZMBU.Health", 0);
			}
		}
		wait(0.05);
	}
}

/*
	Name: function_28217684
	Namespace: namespace_456c991e
	Checksum: 0x424F4353
	Offset: 0x9A8
	Size: 0x1E0
	Parameters: 0
	Flags: None
	Line Number: 196
*/
function function_28217684()
{
	self endon("bled_out");
	self endon("spawned_player");
	self endon("disconnect");
	wait(0.05);
	level flag::wait_till("initial_blackscreen_passed");
	while(1)
	{
		if(isdefined(self))
		{
			if(zm_utility::is_player_valid(self) && !zm_utility::is_placeable_mine(self getcurrentweapon()) && !zm_equipment::is_equipment(self getcurrentweapon()) && !self zm_utility::is_player_revive_tool(self getcurrentweapon()) && level.zombie_powerup_weapon["minigun"] != self getcurrentweapon() && level.weaponnone != self getcurrentweapon() && isdefined(self getweaponslistprimaries()[2]) && self getweaponslistprimaries()[2] == self getcurrentweapon())
			{
				self clientfield::set_player_uimodel("ZMBU.MuleKick", 1);
			}
			else
			{
				self clientfield::set_player_uimodel("ZMBU.MuleKick", 0);
			}
		}
		wait(0.05);
	}
}

/*
	Name: function_4659d62
	Namespace: namespace_456c991e
	Checksum: 0x424F4353
	Offset: 0xB90
	Size: 0x108
	Parameters: 0
	Flags: None
	Line Number: 230
*/
function function_4659d62()
{
	self endon("bled_out");
	self endon("spawned_player");
	self endon("disconnect");
	wait(0.05);
	level flag::wait_till("initial_blackscreen_passed");
	var_a239db2d = 0;
	while(1)
	{
		if(isdefined(self))
		{
			if(isdefined(level.var_679e1a9e) && level.var_679e1a9e)
			{
				if(!(isdefined(var_a239db2d) && var_a239db2d))
				{
					self clientfield::set_player_uimodel("ZMBU.rage_inducer", 1);
					var_a239db2d = 1;
				}
			}
			else if(isdefined(var_a239db2d) && var_a239db2d)
			{
				self clientfield::set_player_uimodel("ZMBU.rage_inducer", 0);
				var_a239db2d = 0;
			}
		}
		wait(1);
	}
}

/*
	Name: function_a6f1e7f0
	Namespace: namespace_456c991e
	Checksum: 0x424F4353
	Offset: 0xCA0
	Size: 0x228
	Parameters: 0
	Flags: None
	Line Number: 270
*/
function function_a6f1e7f0()
{
	self endon("bled_out");
	self endon("spawned_player");
	self endon("disconnect");
	wait(0.05);
	level flag::wait_till("initial_blackscreen_passed");
	self.var_f4d01b67["location_information"] = int(0);
	self.zone = self zm_utility::get_current_zone(1);
	while(3)
	{
		if(isdefined(self))
		{
			self.zone = self zm_utility::get_current_zone(1);
			if(function_b400349f())
			{
				zone_name = self function_6df56a67(self.zone);
			}
			else
			{
				zone_name = self zone_name(self.zone);
			}
			if(isdefined(zone_name))
			{
				if(!self function_d7f04f83("ZMBU.zone_name") === zone_name)
				{
					if(self.var_f4d01b67["location_information"] == 0)
					{
						self SetControllerUIModelValue("ZMBU.zone_name", zone_name);
					}
					else
					{
						self SetControllerUIModelValue("ZMBU.zone_name", "");
					}
				}
			}
			else if(self.var_f4d01b67["location_information"] == 0)
			{
				self SetControllerUIModelValue("ZMBU.zone_name", "Unknown Location");
			}
			else
			{
				self SetControllerUIModelValue("ZMBU.zone_name", "");
			}
		}
		wait(0.05);
	}
}

/*
	Name: zone_name
	Namespace: namespace_456c991e
	Checksum: 0x424F4353
	Offset: 0xED0
	Size: 0xB0
	Parameters: 1
	Flags: None
	Line Number: 329
*/
function zone_name(zone)
{
	if(!isdefined(zone))
	{
		value = "Unknown Location";
	}
	zones = zone.Volumes;
	for(i = 0; i < zones.size; i++)
	{
		if(self istouching(zones[i]))
		{
			value = zones[i].script_string;
		}
	}
	return value;
	ERROR: Bad function call
}

/*
	Name: function_6df56a67
	Namespace: namespace_456c991e
	Checksum: 0x424F4353
	Offset: 0xF88
	Size: 0xE0
	Parameters: 1
	Flags: None
	Line Number: 357
*/
function function_6df56a67(zone)
{
	if(!isdefined(zone))
	{
		value = "Unknown Location";
	}
	zones = zone.Volumes;
	for(i = 0; i < zones.size; i++)
	{
		if(self istouching(zones[i]))
		{
			file = function_ce660824();
			value = function_b036e24c(file, zones[i]);
		}
	}
	return value;
}

/*
	Name: function_b036e24c
	Namespace: namespace_456c991e
	Checksum: 0x424F4353
	Offset: 0x1070
	Size: 0x100
	Parameters: 2
	Flags: None
	Line Number: 385
*/
function function_b036e24c(file, zone)
{
	var_66a7154d = function_1556496c(file);
	for(i = 0; i < var_66a7154d; i++)
	{
		row = tablelookuprow(file, i);
		var_f8a0eae0 = checkStringValid(row[1]);
		zone_name = checkStringValid(row[2]);
		if(var_f8a0eae0 == zone.targetname)
		{
			return zone_name;
		}
	}
	return "Unknown Location";
}

/*
	Name: function_ce660824
	Namespace: namespace_456c991e
	Checksum: 0x424F4353
	Offset: 0x1178
	Size: 0x40
	Parameters: 0
	Flags: None
	Line Number: 411
*/
function function_ce660824()
{
	return "gamedata/zone_names/zone_names_" + tolower(getdvarstring("mapname") + ".csv");
}

/*
	Name: function_b400349f
	Namespace: namespace_456c991e
	Checksum: 0x424F4353
	Offset: 0x11C0
	Size: 0xD0
	Parameters: 0
	Flags: None
	Line Number: 426
*/
function function_b400349f()
{
	switch(tolower(getdvarstring("mapname")))
	{
		case "zm_asylum":
		case "zm_castle":
		case "zm_cosmodrome":
		case "zm_factory":
		case "zm_genesis":
		case "zm_island":
		case "zm_moon":
		case "zm_prototype":
		case "zm_stalingrad":
		case "zm_sumpf":
		case "zm_temple":
		case "zm_theater":
		case "zm_tomb":
		case "zm_town":
		case "zm_town_hd":
		case "zm_zod":
		{
			return 1;
		}
		default
		{
			return 0;
		}
	}
	return 0;
}

/*
	Name: checkStringValid
	Namespace: namespace_456c991e
	Checksum: 0x424F4353
	Offset: 0x1298
	Size: 0x24
	Parameters: 1
	Flags: None
	Line Number: 467
*/
function checkStringValid(str)
{
	if(str != "")
	{
		return str;
	}
	return undefined;
}

