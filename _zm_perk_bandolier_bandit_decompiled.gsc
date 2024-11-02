#include scripts\shared\callbacks_shared;
#include scripts\shared\clientfield_shared;
#include scripts\shared\math_shared;
#include scripts\shared\system_shared;
#include scripts\shared\util_shared;
#include scripts\zm\_zm_perks;
#include scripts\zm\_zm_powerups;
#include scripts\zm\_zm_score;
#include scripts\zm\_zm_spawner;
#include scripts\zm\_zm_utility;

#namespace namespace_388fe139;

/*
	Name: __init__sytem__
	Namespace: namespace_388fe139
	Checksum: 0x424F4353
	Offset: 0x360
	Size: 0x38
	Parameters: 0
	Flags: AutoExec
	Line Number: 23
*/
function autoexec __init__sytem__()
{
	system::register("zm_perk_bandolier_bandit", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: namespace_388fe139
	Checksum: 0x424F4353
	Offset: 0x3A0
	Size: 0x18
	Parameters: 0
	Flags: None
	Line Number: 38
*/
function __init__()
{
	function_abe8684e();
}

/*
	Name: function_abe8684e
	Namespace: namespace_388fe139
	Checksum: 0x424F4353
	Offset: 0x3C0
	Size: 0x140
	Parameters: 0
	Flags: None
	Line Number: 53
*/
function function_abe8684e()
{
	zm_perks::register_perk_basic_info("specialty_extraammo", "bandolier_bandit", 3500, &"ZM_MINECRAFT_PERK_BANDOLIER", getweapon("zombie_perk_bottle_bandolier_bandit"));
	zm_perks::register_perk_precache_func("specialty_extraammo", &function_f347e2d8);
	zm_perks::register_perk_clientfields("specialty_extraammo", &function_66827a7a, &function_638d17e3);
	zm_perks::register_perk_machine("specialty_extraammo", &function_15c29a1b, &function_43c8faef);
	zm_perks::register_perk_threads("specialty_extraammo", &function_7192b7e7, &function_af720f3d);
	zm_perks::register_perk_host_migration_params("specialty_extraammo", "vending_bandolier_bandit", "_sphynx/perks/fx_perk_bandolier");
	return;
	ERROR: Exception occured: Stack empty.
	ERROR: Bad function call
}

/*
	Name: function_43c8faef
	Namespace: namespace_388fe139
	Checksum: 0x424F4353
	Offset: 0x508
	Size: 0x8
	Parameters: 0
	Flags: None
	Line Number: 76
*/
function function_43c8faef()
{
	return;
}

/*
	Name: function_f347e2d8
	Namespace: namespace_388fe139
	Checksum: 0x424F4353
	Offset: 0x518
	Size: 0xE0
	Parameters: 0
	Flags: None
	Line Number: 91
*/
function function_f347e2d8()
{
	if(isdefined(level.var_95d51e20))
	{
		[[level.var_95d51e20]]();
		return;
	}
	level._effect["_sphynx/perks/fx_perk_bandolier"] = "_sphynx/perks/fx_perk_bandolier_bandit";
	level.machine_assets["specialty_extraammo"] = spawnstruct();
	level.machine_assets["specialty_extraammo"].weapon = getweapon("zombie_perk_bottle_bandolier_bandit");
	level.machine_assets["specialty_extraammo"].off_model = "p7_zm_vending_bandolier_bandit_off";
	level.machine_assets["specialty_extraammo"].on_model = "p7_zm_vending_bandolier_bandit_on";
}

/*
	Name: function_66827a7a
	Namespace: namespace_388fe139
	Checksum: 0x424F4353
	Offset: 0x600
	Size: 0x38
	Parameters: 0
	Flags: None
	Line Number: 115
*/
function function_66827a7a()
{
	clientfield::register("clientuimodel", "hudItems.perks.bandolier_bandit", 1, 2, "int");
}

/*
	Name: function_638d17e3
	Namespace: namespace_388fe139
	Checksum: 0x424F4353
	Offset: 0x640
	Size: 0x30
	Parameters: 1
	Flags: None
	Line Number: 130
*/
function function_638d17e3(state)
{
	self clientfield::set_player_uimodel("hudItems.perks.bandolier_bandit", state);
}

/*
	Name: function_15c29a1b
	Namespace: namespace_388fe139
	Checksum: 0x424F4353
	Offset: 0x678
	Size: 0xC0
	Parameters: 4
	Flags: None
	Line Number: 145
*/
function function_15c29a1b(use_trigger, perk_machine, bump_trigger, collision)
{
	use_trigger.script_sound = "mus_perks_bandolier_bandit_jingle";
	use_trigger.script_string = "bandolier_bandit_perk";
	use_trigger.script_label = "mus_perks_bandolier_bandit_sting";
	use_trigger.target = "vending_bandolier_bandit";
	perk_machine.script_string = "bandolier_bandit_perk";
	perk_machine.targetname = "vending_bandolier_bandit";
	if(isdefined(bump_trigger))
	{
		bump_trigger.script_string = "bandolier_bandit_perk";
	}
}

/*
	Name: function_7192b7e7
	Namespace: namespace_388fe139
	Checksum: 0x424F4353
	Offset: 0x740
	Size: 0x170
	Parameters: 0
	Flags: None
	Line Number: 169
*/
function function_7192b7e7()
{
	self endon("disconnect");
	self endon("hash_f5ece3b");
	foreach(weapon in self getweaponslistprimaries())
	{
		var_62589169 = weapon.startammo;
		if(isdefined(weapon.dualWieldWeapon) && weapon.dualWieldWeapon != level.weaponnone)
		{
			var_62589169 = var_62589169 - weapon.dualWieldWeapon.clipsize;
		}
		var_65270020 = weapon.maxAmmo - var_62589169;
		var_e5532822 = self getweaponammostock(weapon);
		self setweaponammostock(weapon, var_e5532822 + var_65270020);
	}
}

/*
	Name: function_af720f3d
	Namespace: namespace_388fe139
	Checksum: 0x424F4353
	Offset: 0x8B8
	Size: 0x19A
	Parameters: 3
	Flags: None
	Line Number: 196
*/
function function_af720f3d(b_pause, str_perk, str_result)
{
	self notify("hash_f5ece3b");
	foreach(weapon in self getweaponslistprimaries())
	{
		var_62589169 = weapon.startammo;
		if(isdefined(weapon.dualWieldWeapon) && weapon.dualWieldWeapon != level.weaponnone)
		{
			var_62589169 = var_62589169 - weapon.dualWieldWeapon.clipsize;
		}
		var_65270020 = weapon.maxAmmo - var_62589169;
		var_e5532822 = self getweaponammostock(weapon);
		if(var_e5532822 >= 0.4 * var_62589169)
		{
			if(var_e5532822 > var_62589169)
			{
				self setweaponammostock(weapon, var_e5532822 - var_65270020);
			}
		}
	}
}

