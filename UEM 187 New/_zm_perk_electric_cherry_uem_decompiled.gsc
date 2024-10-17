#include scripts\codescripts\struct;
#include scripts\shared\ai\zombie_utility;
#include scripts\shared\array_shared;
#include scripts\shared\clientfield_shared;
#include scripts\shared\math_shared;
#include scripts\shared\system_shared;
#include scripts\shared\util_shared;
#include scripts\shared\visionset_mgr_shared;
#include scripts\zm\_util;
#include scripts\zm\_zm;
#include scripts\zm\_zm_net;
#include scripts\zm\_zm_perks;
#include scripts\zm\_zm_pers_upgrades;
#include scripts\zm\_zm_pers_upgrades_functions;
#include scripts\zm\_zm_pers_upgrades_system;
#include scripts\zm\_zm_score;
#include scripts\zm\_zm_stats;
#include scripts\zm\_zm_utility;

#namespace namespace_2310fe1d;

/*
	Name: __init__sytem__
	Namespace: namespace_2310fe1d
	Checksum: 0x424F4353
	Offset: 0x5D0
	Size: 0x38
	Parameters: 0
	Flags: AutoExec
	Line Number: 31
*/
function autoexec __init__sytem__()
{
	system::register("zm_perk_electric_cherry_uem", &__init__, undefined, undefined);
	return;
	ERROR: Exception occured: Stack empty.
}

/*
	Name: __init__
	Namespace: namespace_2310fe1d
	Checksum: 0x424F4353
	Offset: 0x610
	Size: 0x18
	Parameters: 0
	Flags: None
	Line Number: 48
*/
function __init__()
{
	enable_electric_cherry_perk_for_level();
}

/*
	Name: enable_electric_cherry_perk_for_level
	Namespace: namespace_2310fe1d
	Checksum: 0x424F4353
	Offset: 0x630
	Size: 0x168
	Parameters: 0
	Flags: None
	Line Number: 63
*/
function enable_electric_cherry_perk_for_level()
{
System.InvalidOperationException: Stack empty.
   at System.ThrowHelper.ThrowInvalidOperationException(ExceptionResource resource)
   at System.Collections.Generic.Stack`1.Pop()
   at Cerberus.Logic.Decompiler.BuildCondition(Int32 startIndex)
   at Cerberus.Logic.Decompiler.FindIfStatements()
   at Cerberus.Logic.Decompiler..ctor(ScriptExport function, ScriptBase script)
}

/*
	Name: electric_cherry_precache
	Namespace: namespace_2310fe1d
	Checksum: 0x424F4353
	Offset: 0x7A0
	Size: 0xE0
	Parameters: 0
	Flags: None
	Line Number: 83
*/
function electric_cherry_precache()
{
	if(isdefined(level.electric_cherry_precache_override_func))
	{
		[[level.electric_cherry_precache_override_func]]();
		return;
	}
	level._effect["electric_cherry_light"] = "_t6/misc/fx_zombie_cola_revive_on";
	level.machine_assets["specialty_electriccherry"] = spawnstruct();
	level.machine_assets["specialty_electriccherry"].weapon = getweapon("zombie_perk_bottle_cherry");
	level.machine_assets["specialty_electriccherry"].off_model = "p6_zm_vending_electric_cherry";
	level.machine_assets["specialty_electriccherry"].on_model = "p6_zm_vending_electric_cherry";
}

/*
	Name: electric_cherry_register_clientfield
	Namespace: namespace_2310fe1d
	Checksum: 0x424F4353
	Offset: 0x888
	Size: 0x38
	Parameters: 0
	Flags: None
	Line Number: 107
*/
function electric_cherry_register_clientfield()
{
	clientfield::register("clientuimodel", "hudItems.perks.electric_cherry_uem", 1, 2, "int");
}

/*
	Name: electric_cherry_set_clientfield
	Namespace: namespace_2310fe1d
	Checksum: 0x424F4353
	Offset: 0x8C8
	Size: 0x30
	Parameters: 1
	Flags: None
	Line Number: 122
*/
function electric_cherry_set_clientfield(state)
{
	self clientfield::set_player_uimodel("hudItems.perks.electric_cherry_uem", state);
}

/*
	Name: electric_cherry_perk_machine_setup
	Namespace: namespace_2310fe1d
	Checksum: 0x424F4353
	Offset: 0x900
	Size: 0xC0
	Parameters: 4
	Flags: None
	Line Number: 137
*/
function electric_cherry_perk_machine_setup(use_trigger, perk_machine, bump_trigger, collision)
{
	use_trigger.script_sound = "mus_perks_ec_jingle";
	use_trigger.script_string = "electriccherry_perk";
	use_trigger.script_label = "mus_perks_ec_sting";
	use_trigger.target = "vending_electriccherry";
	perk_machine.script_string = "electriccherry_perk";
	perk_machine.targetname = "vending_electriccherry";
	if(isdefined(bump_trigger))
	{
		bump_trigger.script_string = "electriccherry_perk";
		return;
	}
	ERROR: Exception occured: Stack empty.
	ERROR: Bad function call
}

/*
	Name: init_electric_cherry
	Namespace: namespace_2310fe1d
	Checksum: 0x424F4353
	Offset: 0x9C8
	Size: 0x148
	Parameters: 0
	Flags: None
	Line Number: 164
*/
function init_electric_cherry()
{
	level._effect["electric_cherry_explode"] = "dlc1/castle/fx_castle_electric_cherry_down";
	level.custom_laststand_func = &electric_cherry_laststand;
	zombie_utility::set_zombie_var("tesla_head_gib_chance", 50);
	clientfield::register("allplayers", "electric_cherry_reload_fx", 1, 2, "int");
	clientfield::register("actor", "tesla_death_fx", 1, 1, "int");
	clientfield::register("vehicle", "tesla_death_fx_veh", 10000, 1, "int");
	clientfield::register("actor", "tesla_shock_eyes_fx", 1, 1, "int");
	clientfield::register("vehicle", "tesla_shock_eyes_fx_veh", 10000, 1, "int");
}

/*
	Name: electric_cherry_perk_machine_think
	Namespace: namespace_2310fe1d
	Checksum: 0x424F4353
	Offset: 0xB18
	Size: 0x268
	Parameters: 0
	Flags: None
	Line Number: 186
*/
function electric_cherry_perk_machine_think()
{
	init_electric_cherry();
	while(1)
	{
		machine = getentarray("vendingelectric_cherry", "targetname");
		machine_triggers = getentarray("vending_electriccherry", "target");
		for(i = 0; i < machine.size; i++)
		{
			machine[i] setmodel("p6_zm_vending_electric_cherry");
		}
		level thread zm_perks::do_initial_power_off_callback(machine, "electriccherry");
		array::thread_all(machine_triggers, &zm_perks::set_power_on, 0);
		level waittill("electric_cherry_on");
		for(i = 0; i < machine.size; i++)
		{
			machine[i] setmodel("p6_zm_vending_electric_cherry");
			machine[i] vibrate(VectorScale((0, -1, 0), 100), 0.3, 0.4, 3);
			machine[i] playsound("zmb_perks_power_on");
			machine[i] thread zm_perks::perk_fx("electriccherry");
			machine[i] thread zm_perks::play_loop_on_machine();
		}
		level notify("specialty_grenadepulldeath_power_on");
		array::thread_all(machine_triggers, &zm_perks::set_power_on, 1);
		level waittill("electric_cherry_off");
		array::thread_all(machine_triggers, &zm_perks::turn_perk_off);
	}
}

/*
	Name: electric_cherry_host_migration_func
	Namespace: namespace_2310fe1d
	Checksum: 0x424F4353
	Offset: 0xD88
	Size: 0x110
	Parameters: 0
	Flags: None
	Line Number: 225
*/
function electric_cherry_host_migration_func()
{
	a_electric_cherry_perk_machines = getentarray("vending_electriccherry", "targetname");
	foreach(perk_machine in a_electric_cherry_perk_machines)
	{
		if(isdefined(perk_machine.model) && perk_machine.model == "p6_zm_vending_electric_cherry")
		{
			perk_machine zm_perks::perk_fx(undefined, 1);
			perk_machine thread zm_perks::perk_fx("electriccherry");
		}
	}
}

/*
	Name: electric_cherry_laststand
	Namespace: namespace_2310fe1d
	Checksum: 0x424F4353
	Offset: 0xEA0
	Size: 0x238
	Parameters: 0
	Flags: None
	Line Number: 248
*/
function electric_cherry_laststand()
{
	VisionSetLastStand("zombie_last_stand", 1);
	if(isdefined(self))
	{
		playfx(level._effect["electric_cherry_explode"], self.origin);
		self playsound("zmb_cherry_explode");
		self notify("electric_cherry_start");
		wait(0.05);
		a_zombies = zombie_utility::get_round_enemy_array();
		a_zombies = util::get_array_of_closest(self.origin, a_zombies, undefined, undefined, 500);
		for(i = 0; i < a_zombies.size; i++)
		{
			if(isalive(self) && isalive(a_zombies[i]))
			{
				if(a_zombies[i].health <= 1000)
				{
					a_zombies[i] thread electric_cherry_death_fx();
					if(isdefined(self.cherry_kills))
					{
						self.cherry_kills++;
					}
					self zm_score::add_to_player_score(40);
				}
				else
				{
					a_zombies[i] thread electric_cherry_stun();
					a_zombies[i] thread electric_cherry_shock_fx();
				}
				wait(0.1);
				a_zombies[i] dodamage(1000, self.origin, self, self, "none");
			}
		}
		self notify("electric_cherry_end");
	}
}

/*
	Name: electric_cherry_death_fx
	Namespace: namespace_2310fe1d
	Checksum: 0x424F4353
	Offset: 0x10E0
	Size: 0x100
	Parameters: 0
	Flags: None
	Line Number: 295
*/
function electric_cherry_death_fx()
{
	self endon("death");
	self playsound("zmb_elec_jib_zombie");
	if(!(isdefined(self.head_gibbed) && self.head_gibbed))
	{
		if(isVehicle(self))
		{
			self clientfield::set("tesla_shock_eyes_fx_veh", 1);
		}
		else
		{
			self clientfield::set("tesla_shock_eyes_fx", 1);
		}
	}
	else if(isVehicle(self))
	{
		self clientfield::set("tesla_death_fx_veh", 1);
	}
	else
	{
		self clientfield::set("tesla_death_fx", 1);
	}
}

/*
	Name: electric_cherry_shock_fx
	Namespace: namespace_2310fe1d
	Checksum: 0x424F4353
	Offset: 0x11E8
	Size: 0xF0
	Parameters: 0
	Flags: None
	Line Number: 330
*/
function electric_cherry_shock_fx()
{
	self endon("death");
	if(isVehicle(self))
	{
		self clientfield::set("tesla_shock_eyes_fx_veh", 1);
	}
	else
	{
		self clientfield::set("tesla_shock_eyes_fx", 1);
	}
	self playsound("zmb_elec_jib_zombie");
	self waittill("stun_fx_end");
	if(isVehicle(self))
	{
		self clientfield::set("tesla_shock_eyes_fx_veh", 0);
	}
	else
	{
		self clientfield::set("tesla_shock_eyes_fx", 0);
	}
}

/*
	Name: electric_cherry_stun
	Namespace: namespace_2310fe1d
	Checksum: 0x424F4353
	Offset: 0x12E0
	Size: 0xA0
	Parameters: 0
	Flags: None
	Line Number: 363
*/
function electric_cherry_stun()
{
	self endon("death");
	self notify("stun_zombie");
	self endon("stun_zombie");
	if(self.health <= 0)
	{
		return;
	}
	if(self.ai_state !== "zombie_think")
	{
		return;
	}
	self.zombie_tesla_hit = 1;
	self.ignoreall = 1;
	wait(4);
	if(isdefined(self))
	{
		self.zombie_tesla_hit = 0;
		self.ignoreall = 0;
		self notify("stun_fx_end");
	}
}

/*
	Name: electric_cherry_reload_attack
	Namespace: namespace_2310fe1d
	Checksum: 0x424F4353
	Offset: 0x1388
	Size: 0x4A8
	Parameters: 0
	Flags: None
	Line Number: 397
*/
function electric_cherry_reload_attack()
{
	self endon("death");
	self endon("disconnect");
	self endon("specialty_electriccherry" + "_stop");
	self.wait_on_reload = [];
	self.consecutive_electric_cherry_attacks = 0;
	while(1)
	{
		self waittill("reload_start");
		current_weapon = self getcurrentweapon();
		if(isinarray(self.wait_on_reload, current_weapon))
		{
			continue;
		}
		self.wait_on_reload[self.wait_on_reload.size] = current_weapon;
		self.consecutive_electric_cherry_attacks++;
		n_clip_current = 1;
		n_clip_max = 10;
		n_fraction = n_clip_current / n_clip_max;
		perk_radius = math::linear_map(n_fraction, 1, 0, 32, 128);
		perk_dmg = math::linear_map(n_fraction, 1, 0, 1, 1045);
		self thread check_for_reload_complete(current_weapon);
		if(isdefined(self))
		{
			switch(self.consecutive_electric_cherry_attacks)
			{
				case 0:
				case 1:
				{
					n_zombie_limit = undefined;
					break;
				}
				case 2:
				{
					n_zombie_limit = 8;
					break;
				}
				case 3:
				{
					n_zombie_limit = 4;
					break;
				}
				case 4:
				{
					n_zombie_limit = 2;
					break;
				}
				default
				{
					n_zombie_limit = 0;
				}
			}
			self thread electric_cherry_cooldown_timer(current_weapon);
			if(isdefined(n_zombie_limit) && n_zombie_limit == 0)
			{
				continue;
			}
			self thread electric_cherry_reload_fx(n_fraction);
			self notify("electric_cherry_start");
			self playsound("zmb_cherry_explode");
			a_zombies = zombie_utility::get_round_enemy_array();
			a_zombies = util::get_array_of_closest(self.origin, a_zombies, undefined, undefined, perk_radius);
			n_zombies_hit = 0;
			for(i = 0; i < a_zombies.size; i++)
			{
				if(isalive(self) && isalive(a_zombies[i]))
				{
					if(isdefined(n_zombie_limit))
					{
						if(n_zombies_hit < n_zombie_limit)
						{
							n_zombies_hit++;
							break;
						}
						else
						{
						}
					}
					if(a_zombies[i].health <= perk_dmg)
					{
						a_zombies[i] thread electric_cherry_death_fx();
						if(isdefined(self.cherry_kills))
						{
							self.cherry_kills++;
						}
						self zm_score::add_to_player_score(40);
					}
					else if(!isdefined(a_zombies[i].is_brutus))
					{
						a_zombies[i] thread electric_cherry_stun();
					}
					a_zombies[i] thread electric_cherry_shock_fx();
					wait(0.1);
					if(isdefined(a_zombies[i]) && isalive(a_zombies[i]))
					{
						a_zombies[i] dodamage(perk_dmg, self.origin, self, self, "none");
					}
				}
			}
			self notify("electric_cherry_end");
		}
	}
	return;
	ERROR: Exception occured: Stack empty.
}

/*
	Name: electric_cherry_cooldown_timer
	Namespace: namespace_2310fe1d
	Checksum: 0x424F4353
	Offset: 0x1838
	Size: 0xC8
	Parameters: 1
	Flags: None
	Line Number: 514
*/
function electric_cherry_cooldown_timer(current_weapon)
{
	self notify("electric_cherry_cooldown_started");
	self endon("electric_cherry_cooldown_started");
	self endon("death");
	self endon("disconnect");
	n_reload_time = 0.25;
	if(self hasperk("specialty_fastreload"))
	{
		n_reload_time = n_reload_time * getdvarfloat("perk_weapReloadMultiplier");
	}
	n_cooldown_time = n_reload_time + 3;
	wait(n_cooldown_time);
	self.consecutive_electric_cherry_attacks = 0;
}

/*
	Name: check_for_reload_complete
	Namespace: namespace_2310fe1d
	Checksum: 0x424F4353
	Offset: 0x1908
	Size: 0xD8
	Parameters: 1
	Flags: None
	Line Number: 540
*/
function check_for_reload_complete(weapon)
{
	self endon("death");
	self endon("disconnect");
	self endon("player_lost_weapon_" + weapon.name);
	self thread weapon_replaced_monitor(weapon);
	while(1)
	{
		self waittill("reload");
		current_weapon = self getcurrentweapon();
		if(current_weapon == weapon)
		{
			arrayremovevalue(self.wait_on_reload, weapon);
			self notify("weapon_reload_complete_" + weapon.name);
			break;
		}
	}
}

/*
	Name: weapon_replaced_monitor
	Namespace: namespace_2310fe1d
	Checksum: 0x424F4353
	Offset: 0x19E8
	Size: 0xD0
	Parameters: 1
	Flags: None
	Line Number: 569
*/
function weapon_replaced_monitor(weapon)
{
	self endon("death");
	self endon("disconnect");
	self endon("weapon_reload_complete_" + weapon.name);
	while(1)
	{
		self waittill("weapon_change");
		primaryWeapons = self getweaponslistprimaries();
		if(!isinarray(primaryWeapons, weapon))
		{
			self notify("player_lost_weapon_" + weapon.name);
			arrayremovevalue(self.wait_on_reload, weapon);
			break;
		}
	}
	return;
	ERROR: Bad function call
}

/*
	Name: electric_cherry_reload_fx
	Namespace: namespace_2310fe1d
	Checksum: 0x424F4353
	Offset: 0x1AC0
	Size: 0xD8
	Parameters: 1
	Flags: None
	Line Number: 599
*/
function electric_cherry_reload_fx(n_fraction)
{
	if(n_fraction >= 0.67)
	{
		codesetclientfield(self, "electric_cherry_reload_fx", 1);
	}
	else if(n_fraction >= 0.33 && n_fraction < 0.67)
	{
		codesetclientfield(self, "electric_cherry_reload_fx", 2);
	}
	else
	{
		codesetclientfield(self, "electric_cherry_reload_fx", 3);
	}
	wait(1);
	codesetclientfield(self, "electric_cherry_reload_fx", 0);
}

/*
	Name: electric_cherry_perk_lost
	Namespace: namespace_2310fe1d
	Checksum: 0x424F4353
	Offset: 0x1BA0
	Size: 0x34
	Parameters: 3
	Flags: None
	Line Number: 627
*/
function electric_cherry_perk_lost(b_pause, str_perk, str_result)
{
	self notify("specialty_electriccherry" + "_stop");
}

