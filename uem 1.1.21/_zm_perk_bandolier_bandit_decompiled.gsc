#include scripts\shared\callbacks_shared;
#include scripts\shared\clientfield_shared;
#include scripts\shared\flag_shared;
#include scripts\shared\math_shared;
#include scripts\shared\system_shared;
#include scripts\shared\util_shared;
#include scripts\sphynx\_zm_loot_mode;
#include scripts\zm\_zm_perks;
#include scripts\zm\_zm_powerups;
#include scripts\zm\_zm_score;
#include scripts\zm\_zm_spawner;
#include scripts\zm\_zm_utility;

#namespace namespace_388fe139;

/*
	Name: function___init__sytem__
	Namespace: namespace_388fe139
	Checksum: 0x424F4353
	Offset: 0x3E8
	Size: 0x38
	Parameters: 0
	Flags: AutoExec
	Line Number: 25
*/
function autoexec function___init__sytem__()
{
	namespace_system::function_register("zm_perk_bandolier_bandit", &function___init__, undefined, undefined);
	return;
	.var_0 = undefined;
}

/*
	Name: function___init__
	Namespace: namespace_388fe139
	Checksum: 0x424F4353
	Offset: 0x428
	Size: 0x18
	Parameters: 0
	Flags: None
	Line Number: 42
*/
function function___init__()
{
	function_abe8684e();
}

/*
	Name: function_abe8684e
	Namespace: namespace_388fe139
	Checksum: 0x424F4353
	Offset: 0x448
	Size: 0x140
	Parameters: 0
	Flags: None
	Line Number: 57
*/
function function_abe8684e()
{
	namespace_zm_perks::function_register_perk_basic_info("specialty_extraammo", "bandolier_bandit", 3500, &"ZM_MINECRAFT_PERK_BANDOLIER", function_GetWeapon("zombie_perk_bottle_bandolier_bandit"));
	namespace_zm_perks::function_register_perk_precache_func("specialty_extraammo", &function_f347e2d8);
	namespace_zm_perks::function_register_perk_clientfields("specialty_extraammo", &function_66827a7a, &function_638d17e3);
	namespace_zm_perks::function_register_perk_machine("specialty_extraammo", &function_15c29a1b, &function_43c8faef);
	namespace_zm_perks::function_register_perk_threads("specialty_extraammo", &function_7192b7e7, &function_af720f3d);
	namespace_zm_perks::function_register_perk_host_migration_params("specialty_extraammo", "vending_bandolier_bandit", "_sphynx/perks/fx_perk_bandolier");
	return;
	ERROR: Exception occured: Stack empty.
}

/*
	Name: function_43c8faef
	Namespace: namespace_388fe139
	Checksum: 0x424F4353
	Offset: 0x590
	Size: 0x8
	Parameters: 0
	Flags: None
	Line Number: 79
*/
function function_43c8faef()
{
}

/*
	Name: function_f347e2d8
	Namespace: namespace_388fe139
	Checksum: 0x424F4353
	Offset: 0x5A0
	Size: 0xE0
	Parameters: 0
	Flags: None
	Line Number: 93
*/
function function_f347e2d8()
{
	if(isdefined(level.var_95d51e20))
	{
		[[level.var_95d51e20]]();
		return;
	}
	level.var__effect["_sphynx/perks/fx_perk_bandolier"] = "_sphynx/perks/fx_perk_bandolier_bandit";
	level.var_machine_assets["specialty_extraammo"] = function_spawnstruct();
	level.var_machine_assets["specialty_extraammo"].var_weapon = function_GetWeapon("zombie_perk_bottle_bandolier_bandit");
	level.var_machine_assets["specialty_extraammo"].var_off_model = "p7_zm_vending_bandolier_bandit_off";
	level.var_machine_assets["specialty_extraammo"].var_on_model = "p7_zm_vending_bandolier_bandit_on";
}

/*
	Name: function_66827a7a
	Namespace: namespace_388fe139
	Checksum: 0x424F4353
	Offset: 0x688
	Size: 0x38
	Parameters: 0
	Flags: None
	Line Number: 117
*/
function function_66827a7a()
{
	namespace_clientfield::function_register("clientuimodel", "hudItems.perks.bandolier_bandit", 1, 2, "int");
}

/*
	Name: function_638d17e3
	Namespace: namespace_388fe139
	Checksum: 0x424F4353
	Offset: 0x6C8
	Size: 0x30
	Parameters: 1
	Flags: None
	Line Number: 132
*/
function function_638d17e3(var_State)
{
	self namespace_clientfield::function_set_player_uimodel("hudItems.perks.bandolier_bandit", var_State);
}

/*
	Name: function_15c29a1b
	Namespace: namespace_388fe139
	Checksum: 0x424F4353
	Offset: 0x700
	Size: 0xC0
	Parameters: 4
	Flags: None
	Line Number: 147
*/
function function_15c29a1b(var_use_trigger, var_perk_machine, var_bump_trigger, var_collision)
{
	var_use_trigger.var_script_sound = "mus_perks_bandolier_bandit_jingle";
	var_use_trigger.var_script_string = "bandolier_bandit_perk";
	var_use_trigger.var_script_label = "mus_perks_bandolier_bandit_sting";
	var_use_trigger.var_target = "vending_bandolier_bandit";
	var_perk_machine.var_script_string = "bandolier_bandit_perk";
	var_perk_machine.var_targetname = "vending_bandolier_bandit";
	if(isdefined(var_bump_trigger))
	{
		var_bump_trigger.var_script_string = "bandolier_bandit_perk";
	}
}

/*
	Name: function_7192b7e7
	Namespace: namespace_388fe139
	Checksum: 0x424F4353
	Offset: 0x7C8
	Size: 0x278
	Parameters: 0
	Flags: None
	Line Number: 171
*/
function function_7192b7e7()
{
	self endon("hash_disconnect");
	self endon("hash_f5ece3b");
	if(level namespace_flag::function_get("loot_mode_active"))
	{
		self.var_d79f52bf["smg"].var_b3d53eb1 = 530;
		self.var_d79f52bf["ar"].var_b3d53eb1 = 720;
		self.var_d79f52bf["shotgun"].var_b3d53eb1 = 190;
		self.var_d79f52bf["sniper"].var_b3d53eb1 = 130;
		self.var_d79f52bf["launcher"].var_b3d53eb1 = 22;
		self.var_d79f52bf["wonder_high"].var_b3d53eb1 = 190;
		self.var_d79f52bf["wonder_low"].var_b3d53eb1 = 36;
	}
	else
	{
		foreach(var_weapon in self function_GetWeaponsListPrimaries())
		{
			var_62589169 = var_weapon.var_startammo;
			if(isdefined(var_weapon.var_dualWieldWeapon) && var_weapon.var_dualWieldWeapon != level.var_weaponNone)
			{
				var_62589169 = var_62589169 - var_weapon.var_dualWieldWeapon.var_clipSize;
			}
			var_65270020 = var_weapon.var_maxAmmo - var_62589169;
			var_e5532822 = self function_GetWeaponAmmoStock(var_weapon);
			self function_SetWeaponAmmoStock(var_weapon, var_e5532822 + var_65270020);
		}
	}
}

/*
	Name: function_af720f3d
	Namespace: namespace_388fe139
	Checksum: 0x424F4353
	Offset: 0xA48
	Size: 0x3D2
	Parameters: 3
	Flags: None
	Line Number: 211
*/
function function_af720f3d(var_b_pause, var_str_perk, var_str_result)
{
	self notify("hash_f5ece3b");
	if(level namespace_flag::function_get("loot_mode_active"))
	{
		self.var_d79f52bf["smg"].var_b3d53eb1 = 440;
		self.var_d79f52bf["ar"].var_b3d53eb1 = 600;
		self.var_d79f52bf["shotgun"].var_b3d53eb1 = 160;
		self.var_d79f52bf["sniper"].var_b3d53eb1 = 110;
		self.var_d79f52bf["launcher"].var_b3d53eb1 = 18;
		self.var_d79f52bf["wonder_high"].var_b3d53eb1 = 160;
		self.var_d79f52bf["wonder_low"].var_b3d53eb1 = 30;
		foreach(var_weapon in self function_GetWeaponsListPrimaries())
		{
			if(isdefined(var_weapon))
			{
				var_weapon_type = var_weapon namespace_fdf6e22f::function_6bf2aeab();
				if(isdefined(self.var_d79f52bf[var_weapon_type]))
				{
					var_5199ca37 = self.var_d79f52bf[var_weapon_type].var_stock;
					var_82389a62 = self.var_d79f52bf[var_weapon_type].var_b3d53eb1;
					if(var_5199ca37 > var_82389a62)
					{
						var_5199ca37 = var_82389a62;
					}
					self function_SetWeaponAmmoStock(var_weapon, var_5199ca37);
				}
			}
		}
	}
	else
	{
		foreach(var_weapon in self function_GetWeaponsListPrimaries())
		{
			var_62589169 = var_weapon.var_startammo;
			if(isdefined(var_weapon.var_dualWieldWeapon) && var_weapon.var_dualWieldWeapon != level.var_weaponNone)
			{
				var_62589169 = var_62589169 - var_weapon.var_dualWieldWeapon.var_clipSize;
			}
			var_65270020 = var_weapon.var_maxAmmo - var_62589169;
			var_e5532822 = self function_GetWeaponAmmoStock(var_weapon);
			if(var_e5532822 >= 0.4 * var_62589169)
			{
				if(var_e5532822 > var_62589169)
				{
					self function_SetWeaponAmmoStock(var_weapon, var_e5532822 - var_65270020);
				}
			}
		}
	}
}

