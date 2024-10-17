#include scripts\codescripts\struct;
#include scripts\shared\array_shared;
#include scripts\shared\callbacks_shared;
#include scripts\shared\clientfield_shared;
#include scripts\shared\laststand_shared;
#include scripts\shared\system_shared;
#include scripts\shared\util_shared;
#include scripts\shared\visionset_mgr_shared;
#include scripts\zm\_util;
#include scripts\zm\_zm_perks;
#include scripts\zm\_zm_pers_upgrades;
#include scripts\zm\_zm_pers_upgrades_functions;
#include scripts\zm\_zm_pers_upgrades_system;
#include scripts\zm\_zm_stats;
#include scripts\zm\_zm_utility;
#include scripts\zm\_zm_weapon_upgrade_system;
#include scripts\zm\_zm_weapons;

#namespace zm_perk_additionalprimaryweapon;

/*
	Name: __init__sytem__
	Namespace: zm_perk_additionalprimaryweapon
	Checksum: 0x424F4353
	Offset: 0x470
	Size: 0x38
	Parameters: 0
	Flags: AutoExec
	Line Number: 30
*/
function autoexec __init__sytem__()
{
	system::register("zm_perk_additionalprimaryweapon", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: zm_perk_additionalprimaryweapon
	Checksum: 0x424F4353
	Offset: 0x4B0
	Size: 0x48
	Parameters: 0
	Flags: None
	Line Number: 45
*/
function __init__()
{
	level.additionalprimaryweapon_limit = 3;
	enable_additional_primary_weapon_perk_for_level();
	callback::on_laststand(&on_laststand);
}

/*
	Name: enable_additional_primary_weapon_perk_for_level
	Namespace: zm_perk_additionalprimaryweapon
	Checksum: 0x424F4353
	Offset: 0x500
	Size: 0x130
	Parameters: 0
	Flags: None
	Line Number: 62
*/
function enable_additional_primary_weapon_perk_for_level()
{
	zm_perks::register_perk_basic_info("specialty_additionalprimaryweapon", "additionalprimaryweapon", 4000, &"ZOMBIE_PERK_ADDITIONALPRIMARYWEAPON", getweapon("zombie_perk_bottle_additionalprimaryweapon"));
	zm_perks::register_perk_precache_func("specialty_additionalprimaryweapon", &additional_primary_weapon_precache);
	zm_perks::register_perk_clientfields("specialty_additionalprimaryweapon", &additional_primary_weapon_register_clientfield, &additional_primary_weapon_set_clientfield);
	zm_perks::register_perk_machine("specialty_additionalprimaryweapon", &additional_primary_weapon_perk_machine_setup);
	zm_perks::register_perk_threads("specialty_additionalprimaryweapon", &give_additional_primary_weapon_perk, &take_additional_primary_weapon_perk);
	zm_perks::register_perk_host_migration_params("specialty_additionalprimaryweapon", "vending_additionalprimaryweapon", "additionalprimaryweapon_light");
}

/*
	Name: additional_primary_weapon_precache
	Namespace: zm_perk_additionalprimaryweapon
	Checksum: 0x424F4353
	Offset: 0x638
	Size: 0xE0
	Parameters: 0
	Flags: None
	Line Number: 82
*/
function additional_primary_weapon_precache()
{
	if(isdefined(level.additional_primary_weapon_precache_override_func))
	{
		[[level.additional_primary_weapon_precache_override_func]]();
		return;
	}
	level._effect["additionalprimaryweapon_light"] = "_sphynx/perks/fx_perk_mule_kick";
	level.machine_assets["specialty_additionalprimaryweapon"] = spawnstruct();
	level.machine_assets["specialty_additionalprimaryweapon"].weapon = getweapon("zombie_perk_bottle_additionalprimaryweapon");
	level.machine_assets["specialty_additionalprimaryweapon"].off_model = "p7_zm_vending_three_gun";
	level.machine_assets["specialty_additionalprimaryweapon"].on_model = "p7_zm_vending_three_gun";
}

/*
	Name: additional_primary_weapon_register_clientfield
	Namespace: zm_perk_additionalprimaryweapon
	Checksum: 0x424F4353
	Offset: 0x720
	Size: 0x38
	Parameters: 0
	Flags: None
	Line Number: 106
*/
function additional_primary_weapon_register_clientfield()
{
	clientfield::register("clientuimodel", "hudItems.perks.additional_primary_weapon", 1, 2, "int");
}

/*
	Name: additional_primary_weapon_set_clientfield
	Namespace: zm_perk_additionalprimaryweapon
	Checksum: 0x424F4353
	Offset: 0x760
	Size: 0x30
	Parameters: 1
	Flags: None
	Line Number: 121
*/
function additional_primary_weapon_set_clientfield(state)
{
	self clientfield::set_player_uimodel("hudItems.perks.additional_primary_weapon", state);
}

/*
	Name: additional_primary_weapon_perk_machine_setup
	Namespace: zm_perk_additionalprimaryweapon
	Checksum: 0x424F4353
	Offset: 0x798
	Size: 0xC0
	Parameters: 4
	Flags: None
	Line Number: 136
*/
function additional_primary_weapon_perk_machine_setup(use_trigger, perk_machine, bump_trigger, collision)
{
	use_trigger.script_sound = "mus_perks_mulekick_jingle";
	use_trigger.script_string = "tap_perk";
	use_trigger.script_label = "mus_perks_mulekick_sting";
	use_trigger.target = "vending_additionalprimaryweapon";
	perk_machine.script_string = "tap_perk";
	perk_machine.targetname = "vending_additionalprimaryweapon";
	if(isdefined(bump_trigger))
	{
		bump_trigger.script_string = "tap_perk";
	}
}

/*
	Name: give_additional_primary_weapon_perk
	Namespace: zm_perk_additionalprimaryweapon
	Checksum: 0x424F4353
	Offset: 0x860
	Size: 0x58
	Parameters: 0
	Flags: None
	Line Number: 160
*/
function give_additional_primary_weapon_perk()
{
	self endon("hash_930dcc79");
	if(!isdefined(self.var_ff3297ea))
	{
		self.var_ff3297ea = undefined;
	}
	if(isdefined(self.var_ff3297ea))
	{
		self thread function_b99c31c9(self.var_ff3297ea);
	}
}

/*
	Name: take_additional_primary_weapon_perk
	Namespace: zm_perk_additionalprimaryweapon
	Checksum: 0x424F4353
	Offset: 0x8C0
	Size: 0x80
	Parameters: 3
	Flags: None
	Line Number: 183
*/
function take_additional_primary_weapon_perk(b_pause, str_perk, str_result)
{
	self notify("hash_930dcc79");
	if(b_pause || str_result == str_perk)
	{
		wait(0.05);
		if(!self laststand::player_is_in_laststand())
		{
			self.var_ff3297ea = take_additionalprimaryweapon();
		}
	}
}

/*
	Name: function_b99c31c9
	Namespace: zm_perk_additionalprimaryweapon
	Checksum: 0x424F4353
	Offset: 0x948
	Size: 0x320
	Parameters: 1
	Flags: None
	Line Number: 206
*/
function function_b99c31c9(weapondata)
{
	self endon("disconnect");
	if(isdefined(zm_weapons::is_weapon_upgraded(weapondata["weapon"])) && zm_weapons::is_weapon_upgraded(weapondata["weapon"]))
	{
		var_7750a3aa = self namespace_5e1f56dc::function_1239e0ad(weapondata["weapon"]);
		var_ed5e1bff = self namespace_5e1f56dc::function_e942fd68(weapondata["weapon"]);
		if(!(isdefined(var_ed5e1bff) && var_ed5e1bff))
		{
			if(isdefined(self namespace_5e1f56dc::function_c3370d47(weapondata["weapon"])) && self namespace_5e1f56dc::function_c3370d47(weapondata["weapon"]))
			{
				var_de6974d4 = spawnstruct();
				var_de6974d4.stored_weapon = weapondata["weapon"].rootweapon;
				var_de6974d4.var_79fe8f18 = 0;
				var_de6974d4.var_4c25c2f2 = 0;
				var_de6974d4.pap_camo_to_use = level.var_1e656cc4[var_de6974d4.var_4c25c2f2];
				self.var_3818be12[self.var_3818be12.size] = var_de6974d4;
			}
		}
		if(!(isdefined(var_7750a3aa) && var_7750a3aa))
		{
			var_d2433c1d = spawnstruct();
			var_d2433c1d.stored_weapon = weapondata["weapon"].rootweapon;
			if(weapondata["pap_level"] > 0)
			{
				var_d2433c1d.var_a39a2843 = weapondata["pap_level"];
			}
			else
			{
				var_d2433c1d.var_a39a2843 = 1;
			}
			self.var_fb56a719[self.var_fb56a719.size] = var_d2433c1d;
		}
		wait(1);
		while(self.zombie_vars["zombie_powerup_minigun_on"])
		{
			wait(0.1);
		}
		self zm_weapons::weapon_give(weapondata["weapon"]);
		self switchtoweapon(weapondata["weapon"]);
	}
	else
	{
		wait(0.1);
		self zm_weapons::weapon_give(weapondata["weapon"]);
	}
	while(self.zombie_vars["zombie_powerup_minigun_on"])
	{
	}
}

/*
	Name: take_additionalprimaryweapon
	Namespace: zm_perk_additionalprimaryweapon
	Checksum: 0x424F4353
	Offset: 0xC70
	Size: 0x188
	Parameters: 0
	Flags: None
	Line Number: 267
*/
function take_additionalprimaryweapon()
{
	var_e87eb6d6 = [];
	var_6c6831af = self getweaponslistprimaries();
	for(i = 0; i < var_6c6831af.size; i++)
	{
		if(isdefined(self.laststandpistol) && self.laststandpistol == var_6c6831af[i])
		{
			continue;
		}
		var_e87eb6d6[var_e87eb6d6.size] = var_6c6831af[i];
	}
	if(!isdefined(var_e87eb6d6) || !isarray(var_e87eb6d6) || var_e87eb6d6.size < 3)
	{
		return;
	}
	var_1d7eacf9 = var_e87eb6d6[2];
	var_4c4f699a = zm_weapons::get_player_weapondata(self, var_1d7eacf9);
	if(var_1d7eacf9 == self getcurrentweapon() && !self laststand::player_is_in_laststand())
	{
		self switchtoweapon(var_e87eb6d6[0]);
	}
	self takeweapon(var_1d7eacf9);
	return var_4c4f699a;
}

/*
	Name: on_laststand
	Namespace: zm_perk_additionalprimaryweapon
	Checksum: 0x424F4353
	Offset: 0xE00
	Size: 0x48
	Parameters: 0
	Flags: None
	Line Number: 303
*/
function on_laststand()
{
	if(self hasperk("specialty_additionalprimaryweapon"))
	{
		self.var_ff3297ea = take_additionalprimaryweapon();
		return;
	}
	ERROR: Bad function call
}

/*
	Name: return_additionalprimaryweapon
	Namespace: zm_perk_additionalprimaryweapon
	Checksum: 0x424F4353
	Offset: 0xE50
	Size: 0x5C
	Parameters: 1
	Flags: None
	Line Number: 323
*/
function return_additionalprimaryweapon(w_returning)
{
	if(isdefined(self.weapons_taken_by_losing_specialty_additionalprimaryweapon[w_returning]))
	{
		self zm_weapons::weapondata_give(self.weapons_taken_by_losing_specialty_additionalprimaryweapon[w_returning]);
	}
	else
	{
		self zm_weapons::give_build_kit_weapon(w_returning);
	}
}

