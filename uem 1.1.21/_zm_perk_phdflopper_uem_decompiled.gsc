#include scripts\codescripts\struct;
#include scripts\shared\ai\zombie_utility;
#include scripts\shared\array_shared;
#include scripts\shared\callbacks_shared;
#include scripts\shared\clientfield_shared;
#include scripts\shared\system_shared;
#include scripts\shared\util_shared;
#include scripts\shared\visionset_mgr_shared;
#include scripts\zm\_util;
#include scripts\zm\_zm;
#include scripts\zm\_zm_perk_random;
#include scripts\zm\_zm_perks;
#include scripts\zm\_zm_pers_upgrades;
#include scripts\zm\_zm_pers_upgrades_functions;
#include scripts\zm\_zm_pers_upgrades_system;
#include scripts\zm\_zm_stats;
#include scripts\zm\_zm_utility;
#include scripts\zm\gametypes\_globallogic_score;

#namespace namespace_6beed036;

/*
	Name: function___init__sytem__
	Namespace: namespace_6beed036
	Checksum: 0x424F4353
	Offset: 0x498
	Size: 0x38
	Parameters: 0
	Flags: AutoExec
	Line Number: 31
*/
function autoexec function___init__sytem__()
{
	namespace_system::function_register("zm_perk_phdflopper_uem", &function___init__, undefined, undefined);
	return;
}

/*
	Name: function___init__
	Namespace: namespace_6beed036
	Checksum: 0x424F4353
	Offset: 0x4D8
	Size: 0x38
	Parameters: 0
	Flags: None
	Line Number: 47
*/
function function___init__()
{
	function_555fd93f();
	namespace_callback::function_on_spawned(&function_ea8141d2);
}

/*
	Name: function_555fd93f
	Namespace: namespace_6beed036
	Checksum: 0x424F4353
	Offset: 0x518
	Size: 0x140
	Parameters: 0
	Flags: Private
	Line Number: 63
*/
function private function_555fd93f()
{
	namespace_zm_perks::function_register_perk_basic_info("specialty_phdflopper", "phd", 2500, &"ZM_MINECRAFT_PERK_PHDFLOPPER", function_GetWeapon("zombie_perk_bottle_phd"));
	namespace_zm_perks::function_register_perk_precache_func("specialty_phdflopper", &function_f7f52842);
	namespace_zm_perks::function_register_perk_clientfields("specialty_phdflopper", &function_8818abe0, &function_d1668e59);
	namespace_zm_perks::function_register_perk_machine("specialty_phdflopper", &function_e9598115);
	namespace_zm_perks::function_register_perk_host_migration_params("specialty_phdflopper", "vending_phd", "vending_phd_light");
	namespace_zm_perks::function_register_perk_threads("specialty_phdflopper", &function_67e89377, &function_94a6ffae);
	function_476330a8();
}

/*
	Name: function_f7f52842
	Namespace: namespace_6beed036
	Checksum: 0x424F4353
	Offset: 0x660
	Size: 0xE0
	Parameters: 0
	Flags: Private
	Line Number: 84
*/
function private function_f7f52842()
{
	if(isdefined(level.var_fb2fb2b6))
	{
		[[level.var_fb2fb2b6]]();
		return;
	}
	level.var__effect["vending_phd_light"] = "_mikeyray/perks/phd/fx_perk_phd";
	level.var_machine_assets["specialty_phdflopper"] = function_spawnstruct();
	level.var_machine_assets["specialty_phdflopper"].var_weapon = function_GetWeapon("zombie_perk_bottle_phd");
	level.var_machine_assets["specialty_phdflopper"].var_off_model = "p7_zm_vending_phd";
	level.var_machine_assets["specialty_phdflopper"].var_on_model = "p7_zm_vending_phd_active";
}

/*
	Name: function_8818abe0
	Namespace: namespace_6beed036
	Checksum: 0x424F4353
	Offset: 0x748
	Size: 0x38
	Parameters: 0
	Flags: Private
	Line Number: 108
*/
function private function_8818abe0()
{
	namespace_clientfield::function_register("clientuimodel", "hudItems.perks.phdflopper", 1, 2, "int");
}

/*
	Name: function_d1668e59
	Namespace: namespace_6beed036
	Checksum: 0x424F4353
	Offset: 0x788
	Size: 0x30
	Parameters: 1
	Flags: Private
	Line Number: 123
*/
function private function_d1668e59(var_State)
{
	self namespace_clientfield::function_set_player_uimodel("hudItems.perks.phdflopper", var_State);
}

/*
	Name: function_e9598115
	Namespace: namespace_6beed036
	Checksum: 0x424F4353
	Offset: 0x7C0
	Size: 0xC0
	Parameters: 4
	Flags: Private
	Line Number: 138
*/
function private function_e9598115(var_use_trigger, var_perk_machine, var_bump_trigger, var_collision)
{
	var_use_trigger.var_script_sound = "mus_perks_phdflopper_jingle";
	var_use_trigger.var_script_string = "phdflopper_perk";
	var_use_trigger.var_script_label = "mus_perks_phdflopper_sting";
	var_use_trigger.var_target = "vending_phd";
	var_perk_machine.var_script_string = "phdflopper_perk";
	var_perk_machine.var_targetname = "vending_phd";
	if(isdefined(var_bump_trigger))
	{
		var_bump_trigger.var_script_string = "phdflopper_perk";
	}
}

/*
	Name: function_476330a8
	Namespace: namespace_6beed036
	Checksum: 0x424F4353
	Offset: 0x888
	Size: 0xC8
	Parameters: 0
	Flags: None
	Line Number: 162
*/
function function_476330a8()
{
	level.var__effect["phdflopper_explode"] = "explosions/fx_exp_grenade_default";
	if(isdefined(1) && 1)
	{
		namespace_zm::function_register_player_damage_callback(&function_d2f3568f);
	}
	if(isdefined(0) && 0)
	{
		namespace_zm::function_register_actor_damage_callback(&function_463b4d36);
		namespace_zm::function_register_vehicle_damage_callback(&function_ad0ee016);
	}
	wait(0.05);
	namespace_zm_perk_random::function_include_perk_in_random_rotation("specialty_phdflopper");
	return;
}

/*
	Name: function_d2f3568f
	Namespace: namespace_6beed036
	Checksum: 0x424F4353
	Offset: 0x958
	Size: 0xE8
	Parameters: 12
	Flags: Private
	Line Number: 189
*/
function private function_d2f3568f(var_inflictor, var_attacker, var_damage, var_flags, var_mod, var_weapon, var_vPoint, var_vDir, var_sHitLoc, var_psOffsetTime, var_boneIndex, var_surfaceType)
{
	if(function_isPlayer(self) && self function_hasPerk("specialty_phdflopper") && (namespace_zm_utility::function_is_explosive_damage(var_mod) || var_mod == "MOD_FALLING"))
	{
		return 0;
	}
	if(var_mod == "MOD_EXPLOSIVE")
	{
		return 0;
	}
	return -1;
}

/*
	Name: function_463b4d36
	Namespace: namespace_6beed036
	Checksum: 0x424F4353
	Offset: 0xA48
	Size: 0xD0
	Parameters: 12
	Flags: Private
	Line Number: 212
*/
function private function_463b4d36(var_inflictor, var_attacker, var_damage, var_flags, var_mod, var_weapon, var_vPoint, var_vDir, var_sHitLoc, var_psOffsetTime, var_boneIndex, var_surfaceType)
{
	if(function_isPlayer(var_attacker) && var_attacker function_hasPerk("specialty_phdflopper") && namespace_zm_utility::function_is_explosive_damage(var_mod))
	{
		return var_damage * 1.75;
	}
	return -1;
}

/*
	Name: function_ad0ee016
	Namespace: namespace_6beed036
	Checksum: 0x424F4353
	Offset: 0xB20
	Size: 0xE0
	Parameters: 15
	Flags: Private
	Line Number: 231
*/
function private function_ad0ee016(var_eInflictor, var_eAttacker, var_iDamage, var_iDFlags, var_sMeansOfDeath, var_weapon, var_vPoint, var_vDir, var_sHitLoc, var_vDamageOrigin, var_psOffsetTime, var_damageFromUnderneath, var_modelIndex, var_partName, var_vSurfaceNormal)
{
	if(function_isPlayer(var_eAttacker) && var_eAttacker function_hasPerk("specialty_phdflopper") && namespace_zm_utility::function_is_explosive_damage(var_sMeansOfDeath))
	{
		return var_iDamage * 1.75;
	}
	return 0;
}

/*
	Name: function_67e89377
	Namespace: namespace_6beed036
	Checksum: 0x424F4353
	Offset: 0xC08
	Size: 0x78
	Parameters: 0
	Flags: None
	Line Number: 250
*/
function function_67e89377()
{
	self endon("hash_death");
	self endon("hash_disconnect");
	self endon("specialty_phdflopper" + "_stop");
	if(isdefined(0) && 0)
	{
		self thread function_b7b929aa();
	}
	if(isdefined(0) && 0)
	{
		self thread function_ad30eb10();
	}
}

/*
	Name: function_b7b929aa
	Namespace: namespace_6beed036
	Checksum: 0x424F4353
	Offset: 0xC88
	Size: 0x120
	Parameters: 0
	Flags: None
	Line Number: 275
*/
function function_b7b929aa()
{
	self endon("hash_death");
	self endon("hash_disconnect");
	self endon("specialty_phdflopper" + "_stop");
	for(;;)
	{
		self namespace_util::function_waittill_any_return("jump_begin", "slide_begin");
		var_startPos = self.var_origin[2];
		while(self function_IsSliding())
		{
			wait(0.1);
		}
		while(!self function_IsOnGround())
		{
			wait(0.1);
		}
		var_endPos = self.var_origin[2];
		var_heightDiff = var_startPos - var_endPos;
		if(var_heightDiff > 48)
		{
			self function_eda743ac();
			wait(3);
		}
	}
}

/*
	Name: function_ad30eb10
	Namespace: namespace_6beed036
	Checksum: 0x424F4353
	Offset: 0xDB0
	Size: 0xA8
	Parameters: 0
	Flags: None
	Line Number: 312
*/
function function_ad30eb10()
{
	self endon("hash_death");
	self endon("hash_disconnect");
	self endon("specialty_phdflopper" + "_stop");
	while(self function_IsSliding())
	{
		self thread function_eda743ac();
		self.var_7607af34 = 1;
		wait(0.2);
		continue;
		if(isdefined(self.var_7607af34) && self.var_7607af34)
		{
			wait(5);
			self.var_7607af34 = 0;
		}
		wait(0.05);
	}
}

/*
	Name: function_eda743ac
	Namespace: namespace_6beed036
	Checksum: 0x424F4353
	Offset: 0xE60
	Size: 0x138
	Parameters: 0
	Flags: None
	Line Number: 342
*/
function function_eda743ac()
{
	var_fxModel = namespace_util::function_spawn_model("tag_origin", self.var_origin);
	var_FX = function_PlayFXOnTag(level.var__effect["phdflopper_explode"], var_fxModel, "tag_origin");
	var_fxModel function_playsound("wpn_grenade_explode");
	if(isdefined(1) && 1)
	{
		function_Earthquake(0.42, 1, self.var_origin, 300);
	}
	function_RadiusDamage(self.var_origin, 300, 5000, 1000, self, "MOD_EXPLOSIVE");
	wait(2);
	var_fxModel function_delete();
	if(isdefined(var_FX))
	{
		var_FX function_delete();
	}
}

/*
	Name: function_94a6ffae
	Namespace: namespace_6beed036
	Checksum: 0x424F4353
	Offset: 0xFA0
	Size: 0x38
	Parameters: 3
	Flags: None
	Line Number: 370
*/
function function_94a6ffae(var_b_pause, var_str_perk, var_str_result)
{
	self notify("specialty_phdflopper" + "_stop");
}

/*
	Name: function_ea8141d2
	Namespace: namespace_6beed036
	Checksum: 0x424F4353
	Offset: 0xFE0
	Size: 0x2C
	Parameters: 0
	Flags: None
	Line Number: 385
*/
function function_ea8141d2()
{
	self namespace_globallogic_score::function_initPersStat("specialty_phdflopper" + "_drank", 0);
}

