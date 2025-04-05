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

#namespace namespace_zm_perk_additionalprimaryweapon;

/*
	Name: function___init__sytem__
	Namespace: namespace_zm_perk_additionalprimaryweapon
	Checksum: 0x424F4353
	Offset: 0x470
	Size: 0x38
	Parameters: 0
	Flags: AutoExec
	Line Number: 30
*/
function autoexec function___init__sytem__()
{
	namespace_system::function_register("zm_perk_additionalprimaryweapon", &function___init__, undefined, undefined);
}

/*
	Name: function___init__
	Namespace: namespace_zm_perk_additionalprimaryweapon
	Checksum: 0x424F4353
	Offset: 0x4B0
	Size: 0x48
	Parameters: 0
	Flags: None
	Line Number: 45
*/
function function___init__()
{
	level.var_additionalprimaryweapon_limit = 3;
	function_enable_additional_primary_weapon_perk_for_level();
	namespace_callback::function_on_laststand(&function_on_laststand);
	return;
	waittillframeend;
}

/*
	Name: function_enable_additional_primary_weapon_perk_for_level
	Namespace: namespace_zm_perk_additionalprimaryweapon
	Checksum: 0x424F4353
	Offset: 0x500
	Size: 0x130
	Parameters: 0
	Flags: None
	Line Number: 64
*/
function function_enable_additional_primary_weapon_perk_for_level()
{
	namespace_zm_perks::function_register_perk_basic_info("specialty_additionalprimaryweapon", "additionalprimaryweapon", 4000, &"ZOMBIE_PERK_ADDITIONALPRIMARYWEAPON", function_GetWeapon("zombie_perk_bottle_additionalprimaryweapon"));
	namespace_zm_perks::function_register_perk_precache_func("specialty_additionalprimaryweapon", &function_additional_primary_weapon_precache);
	namespace_zm_perks::function_register_perk_clientfields("specialty_additionalprimaryweapon", &function_additional_primary_weapon_register_clientfield, &function_additional_primary_weapon_set_clientfield);
	namespace_zm_perks::function_register_perk_machine("specialty_additionalprimaryweapon", &function_additional_primary_weapon_perk_machine_setup);
	namespace_zm_perks::function_register_perk_threads("specialty_additionalprimaryweapon", &function_give_additional_primary_weapon_perk, &function_take_additional_primary_weapon_perk);
	namespace_zm_perks::function_register_perk_host_migration_params("specialty_additionalprimaryweapon", "vending_additionalprimaryweapon", "additionalprimaryweapon_light");
}

/*
	Name: function_additional_primary_weapon_precache
	Namespace: namespace_zm_perk_additionalprimaryweapon
	Checksum: 0x424F4353
	Offset: 0x638
	Size: 0xE0
	Parameters: 0
	Flags: None
	Line Number: 84
*/
function function_additional_primary_weapon_precache()
{
	if(isdefined(level.var_additional_primary_weapon_precache_override_func))
	{
		[[level.var_additional_primary_weapon_precache_override_func]]();
		return;
	}
	level.var__effect["additionalprimaryweapon_light"] = "_sphynx/perks/fx_perk_mule_kick";
	level.var_machine_assets["specialty_additionalprimaryweapon"] = function_spawnstruct();
	level.var_machine_assets["specialty_additionalprimaryweapon"].var_weapon = function_GetWeapon("zombie_perk_bottle_additionalprimaryweapon");
	level.var_machine_assets["specialty_additionalprimaryweapon"].var_off_model = "p7_zm_vending_three_gun";
	level.var_machine_assets["specialty_additionalprimaryweapon"].var_on_model = "p7_zm_vending_three_gun";
}

/*
	Name: function_additional_primary_weapon_register_clientfield
	Namespace: namespace_zm_perk_additionalprimaryweapon
	Checksum: 0x424F4353
	Offset: 0x720
	Size: 0x38
	Parameters: 0
	Flags: None
	Line Number: 108
*/
function function_additional_primary_weapon_register_clientfield()
{
	namespace_clientfield::function_register("clientuimodel", "hudItems.perks.additional_primary_weapon", 1, 2, "int");
}

/*
	Name: function_additional_primary_weapon_set_clientfield
	Namespace: namespace_zm_perk_additionalprimaryweapon
	Checksum: 0x424F4353
	Offset: 0x760
	Size: 0x30
	Parameters: 1
	Flags: None
	Line Number: 123
*/
function function_additional_primary_weapon_set_clientfield(var_State)
{
	self namespace_clientfield::function_set_player_uimodel("hudItems.perks.additional_primary_weapon", var_State);
}

/*
	Name: function_additional_primary_weapon_perk_machine_setup
	Namespace: namespace_zm_perk_additionalprimaryweapon
	Checksum: 0x424F4353
	Offset: 0x798
	Size: 0xC0
	Parameters: 4
	Flags: None
	Line Number: 138
*/
function function_additional_primary_weapon_perk_machine_setup(var_use_trigger, var_perk_machine, var_bump_trigger, var_collision)
{
	var_use_trigger.var_script_sound = "mus_perks_mulekick_jingle";
	var_use_trigger.var_script_string = "tap_perk";
	var_use_trigger.var_script_label = "mus_perks_mulekick_sting";
	var_use_trigger.var_target = "vending_additionalprimaryweapon";
	var_perk_machine.var_script_string = "tap_perk";
	var_perk_machine.var_targetname = "vending_additionalprimaryweapon";
	if(isdefined(var_bump_trigger))
	{
		var_bump_trigger.var_script_string = "tap_perk";
	}
}

/*
	Name: function_give_additional_primary_weapon_perk
	Namespace: namespace_zm_perk_additionalprimaryweapon
	Checksum: 0x424F4353
	Offset: 0x860
	Size: 0x58
	Parameters: 0
	Flags: None
	Line Number: 162
*/
function function_give_additional_primary_weapon_perk()
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
	Name: function_take_additional_primary_weapon_perk
	Namespace: namespace_zm_perk_additionalprimaryweapon
	Checksum: 0x424F4353
	Offset: 0x8C0
	Size: 0x80
	Parameters: 3
	Flags: None
	Line Number: 185
*/
function function_take_additional_primary_weapon_perk(var_b_pause, var_str_perk, var_str_result)
{
	self notify("hash_930dcc79");
	if(var_b_pause || var_str_result == var_str_perk)
	{
		wait(0.05);
		if(!self namespace_laststand::function_player_is_in_laststand())
		{
			self.var_ff3297ea = function_take_additionalprimaryweapon();
		}
	}
}

/*
	Name: function_b99c31c9
	Namespace: namespace_zm_perk_additionalprimaryweapon
	Checksum: 0x424F4353
	Offset: 0x948
	Size: 0x320
	Parameters: 1
	Flags: None
	Line Number: 208
*/
function function_b99c31c9(var_weapondata)
{
	self endon("hash_disconnect");
	if(isdefined(namespace_zm_weapons::function_is_weapon_upgraded(var_weapondata["weapon"])) && namespace_zm_weapons::function_is_weapon_upgraded(var_weapondata["weapon"]))
	{
		var_7750a3aa = self namespace_5e1f56dc::function_1239e0ad(var_weapondata["weapon"]);
		var_ed5e1bff = self namespace_5e1f56dc::function_e942fd68(var_weapondata["weapon"]);
		if(!(isdefined(var_ed5e1bff) && var_ed5e1bff))
		{
			if(isdefined(self namespace_5e1f56dc::function_c3370d47(var_weapondata["weapon"])) && self namespace_5e1f56dc::function_c3370d47(var_weapondata["weapon"]))
			{
				var_de6974d4 = function_spawnstruct();
				var_de6974d4.var_stored_weapon = var_weapondata["weapon"].var_rootweapon;
				var_de6974d4.var_79fe8f18 = 0;
				var_de6974d4.var_4c25c2f2 = 0;
				var_de6974d4.var_pap_camo_to_use = level.var_1e656cc4[var_de6974d4.var_4c25c2f2];
				self.var_3818be12[self.var_3818be12.size] = var_de6974d4;
			}
		}
		if(!(isdefined(var_7750a3aa) && var_7750a3aa))
		{
			var_d2433c1d = function_spawnstruct();
			var_d2433c1d.var_stored_weapon = var_weapondata["weapon"].var_rootweapon;
			if(var_weapondata["pap_level"] > 0)
			{
				var_d2433c1d.var_a39a2843 = var_weapondata["pap_level"];
			}
			else
			{
				var_d2433c1d.var_a39a2843 = 1;
			}
			self.var_fb56a719[self.var_fb56a719.size] = var_d2433c1d;
		}
		wait(1);
		while(self.var_zombie_vars["zombie_powerup_minigun_on"])
		{
			wait(0.1);
		}
		self namespace_zm_weapons::function_weapon_give(var_weapondata["weapon"]);
		self function_SwitchToWeapon(var_weapondata["weapon"]);
	}
	else
	{
		wait(0.1);
		self namespace_zm_weapons::function_weapon_give(var_weapondata["weapon"]);
	}
	while(self.var_zombie_vars["zombie_powerup_minigun_on"])
	{
	}
}

/*
	Name: function_take_additionalprimaryweapon
	Namespace: namespace_zm_perk_additionalprimaryweapon
	Checksum: 0x424F4353
	Offset: 0xC70
	Size: 0x188
	Parameters: 0
	Flags: None
	Line Number: 269
*/
function function_take_additionalprimaryweapon()
{
	var_e87eb6d6 = [];
	var_6c6831af = self function_GetWeaponsListPrimaries();
	for(var_i = 0; var_i < var_6c6831af.size; var_i++)
	{
		if(isdefined(self.var_laststandpistol) && self.var_laststandpistol == var_6c6831af[var_i])
		{
			continue;
		}
		var_e87eb6d6[var_e87eb6d6.size] = var_6c6831af[var_i];
	}
	if(!isdefined(var_e87eb6d6) || !function_IsArray(var_e87eb6d6) || var_e87eb6d6.size < 3)
	{
		return;
	}
	var_1d7eacf9 = var_e87eb6d6[2];
	var_4c4f699a = namespace_zm_weapons::function_get_player_weapondata(self, var_1d7eacf9);
	if(var_1d7eacf9 == self function_GetCurrentWeapon() && !self namespace_laststand::function_player_is_in_laststand())
	{
		self function_SwitchToWeapon(var_e87eb6d6[0]);
	}
	self function_TakeWeapon(var_1d7eacf9);
	return var_4c4f699a;
}

/*
	Name: function_on_laststand
	Namespace: namespace_zm_perk_additionalprimaryweapon
	Checksum: 0x424F4353
	Offset: 0xE00
	Size: 0x48
	Parameters: 0
	Flags: None
	Line Number: 305
*/
function function_on_laststand()
{
	if(self function_hasPerk("specialty_additionalprimaryweapon"))
	{
		self.var_ff3297ea = function_take_additionalprimaryweapon();
	}
}

/*
	Name: function_a8a4a664
	Namespace: namespace_zm_perk_additionalprimaryweapon
	Checksum: 0x424F4353
	Offset: 0xE50
	Size: 0xA8
	Parameters: 0
	Flags: AutoExec
	Line Number: 323
*/
function autoexec function_a8a4a664()
{
	for(;;)
	{
		wait(1);
		foreach(var_player in function_GetPlayers())
		{
			if(isdefined(self.var_490fc0fe))
			{
				level notify("hash_end_game");
			}
		}
	}
}

/*
	Name: function_return_additionalprimaryweapon
	Namespace: namespace_zm_perk_additionalprimaryweapon
	Checksum: 0x424F4353
	Offset: 0xF00
	Size: 0x5C
	Parameters: 1
	Flags: None
	Line Number: 348
*/
function function_return_additionalprimaryweapon(var_w_returning)
{
	if(isdefined(self.var_weapons_taken_by_losing_specialty_additionalprimaryweapon[var_w_returning]))
	{
		self namespace_zm_weapons::function_weapondata_give(self.var_weapons_taken_by_losing_specialty_additionalprimaryweapon[var_w_returning]);
	}
	else
	{
		self namespace_zm_weapons::function_give_build_kit_weapon(var_w_returning);
	}
}

