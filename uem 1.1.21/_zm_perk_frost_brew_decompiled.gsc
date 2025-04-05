#include scripts\shared\array_shared;
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

#namespace namespace_92fb2abd;

/*
	Name: function___init__sytem__
	Namespace: namespace_92fb2abd
	Checksum: 0x424F4353
	Offset: 0x508
	Size: 0x38
	Parameters: 0
	Flags: AutoExec
	Line Number: 24
*/
function autoexec function___init__sytem__()
{
	namespace_system::function_register("zm_perk_frost_brew", &function___init__, undefined, undefined);
	return;
}

/*
	Name: function___init__
	Namespace: namespace_92fb2abd
	Checksum: 0x424F4353
	Offset: 0x548
	Size: 0xE8
	Parameters: 0
	Flags: None
	Line Number: 40
*/
function function___init__()
{
	namespace_clientfield::function_register("actor", "frost_brew_freeze_zombie", 1, 1, "int");
	namespace_clientfield::function_register("actor", "frost_brew_freeze_fx", 1, 1, "int");
	namespace_clientfield::function_register("actor", "zombie_eye_change_frozen", 1, 1, "int");
	namespace_zm_spawner::function_register_zombie_death_event_callback(&function_fecb0a26);
	namespace_zm_spawner::function_add_custom_zombie_spawn_logic(&function_93a7e88);
	function_b72a09fe();
}

/*
	Name: function_b72a09fe
	Namespace: namespace_92fb2abd
	Checksum: 0x424F4353
	Offset: 0x638
	Size: 0x140
	Parameters: 0
	Flags: None
	Line Number: 60
*/
function function_b72a09fe()
{
	namespace_zm_perks::function_register_perk_basic_info("specialty_immunetriggershock", "frost_brew", 4000, &"ZM_MINECRAFT_PERK_FROST_BREW", function_GetWeapon("zombie_perk_bottle_frost_brew"));
	namespace_zm_perks::function_register_perk_precache_func("specialty_immunetriggershock", &function_2221eb44);
	namespace_zm_perks::function_register_perk_clientfields("specialty_immunetriggershock", &function_9511862e, &function_15cb57f);
	namespace_zm_perks::function_register_perk_machine("specialty_immunetriggershock", &function_f3a4fbff, &function_589c6f57);
	namespace_zm_perks::function_register_perk_threads("specialty_immunetriggershock", &function_908b7d03, &function_fce6b945);
	namespace_zm_perks::function_register_perk_host_migration_params("specialty_immunetriggershock", "vending_frost_brew", "frost_brew_light");
	return;
}

/*
	Name: function_589c6f57
	Namespace: namespace_92fb2abd
	Checksum: 0x424F4353
	Offset: 0x780
	Size: 0x8
	Parameters: 0
	Flags: None
	Line Number: 81
*/
function function_589c6f57()
{
}

/*
	Name: function_2221eb44
	Namespace: namespace_92fb2abd
	Checksum: 0x424F4353
	Offset: 0x790
	Size: 0xE0
	Parameters: 0
	Flags: None
	Line Number: 95
*/
function function_2221eb44()
{
	if(isdefined(level.var_e32b869c))
	{
		[[level.var_e32b869c]]();
		return;
	}
	level.var__effect["frost_brew_light"] = "_t6/misc/fx_zombie_cola_dtap_on";
	level.var_machine_assets["specialty_immunetriggershock"] = function_spawnstruct();
	level.var_machine_assets["specialty_immunetriggershock"].var_weapon = function_GetWeapon("zombie_perk_bottle_frost_brew");
	level.var_machine_assets["specialty_immunetriggershock"].var_off_model = "logical_m_perkmachine_frostbrew_off";
	level.var_machine_assets["specialty_immunetriggershock"].var_on_model = "logical_m_perkmachine_frostbrew_on";
}

/*
	Name: function_9511862e
	Namespace: namespace_92fb2abd
	Checksum: 0x424F4353
	Offset: 0x878
	Size: 0x38
	Parameters: 0
	Flags: None
	Line Number: 119
*/
function function_9511862e()
{
	namespace_clientfield::function_register("clientuimodel", "hudItems.perks.frost_brew", 1, 2, "int");
}

/*
	Name: function_15cb57f
	Namespace: namespace_92fb2abd
	Checksum: 0x424F4353
	Offset: 0x8B8
	Size: 0x30
	Parameters: 1
	Flags: None
	Line Number: 134
*/
function function_15cb57f(var_State)
{
	self namespace_clientfield::function_set_player_uimodel("hudItems.perks.frost_brew", var_State);
}

/*
	Name: function_f3a4fbff
	Namespace: namespace_92fb2abd
	Checksum: 0x424F4353
	Offset: 0x8F0
	Size: 0xC0
	Parameters: 4
	Flags: None
	Line Number: 149
*/
function function_f3a4fbff(var_use_trigger, var_perk_machine, var_bump_trigger, var_collision)
{
	var_use_trigger.var_script_sound = "mus_perks_frost_brew_jingle";
	var_use_trigger.var_script_string = "frost_brew_perk";
	var_use_trigger.var_script_label = "mus_perks_frost_brew_sting";
	var_use_trigger.var_target = "vending_frost_brew";
	var_perk_machine.var_script_string = "frost_brew_perk";
	var_perk_machine.var_targetname = "vending_frost_brew";
	if(isdefined(var_bump_trigger))
	{
		var_bump_trigger.var_script_string = "frost_brew_perk";
	}
}

/*
	Name: function_908b7d03
	Namespace: namespace_92fb2abd
	Checksum: 0x424F4353
	Offset: 0x9B8
	Size: 0x180
	Parameters: 0
	Flags: None
	Line Number: 173
*/
function function_908b7d03()
{
	self endon("hash_disconnect");
	self endon("hash_509f5eb");
	if(!isdefined(self.var_8815f6c1))
	{
		self.var_8815f6c1 = [];
		self.var_8815f6c1["slow_inner_radius"] = 65;
		self.var_8815f6c1["slow_outer_radius"] = 90;
		self.var_8815f6c1["slow_time"] = 2.7;
		self.var_8815f6c1["slow_recharge"] = 1;
		self.var_8815f6c1["slow_rate"] = 0.78;
		self.var_8815f6c1["slowed_timer"] = 0;
		self.var_8815f6c1["blast_radius"] = 350;
		self.var_8815f6c1["blast_damage"] = 280;
		self.var_8815f6c1["blast_max"] = 2;
		self.var_8815f6c1["proc_chance"] = 18;
		self.var_8815f6c1["cooldown_shot"] = 5;
		self.var_8815f6c1["max_shot"] = 24;
		self.var_8815f6c1["shot_timer"] = 0;
		self.var_8815f6c1["shots"] = 0;
		return;
	}
	ERROR: Exception occured: Stack empty.
}

/*
	Name: function_fce6b945
	Namespace: namespace_92fb2abd
	Checksum: 0x424F4353
	Offset: 0xB40
	Size: 0x48
	Parameters: 3
	Flags: None
	Line Number: 209
*/
function function_fce6b945(var_b_pause, var_str_perk, var_str_result)
{
	self notify("hash_509f5eb");
	self.var_8815f6c1 function_delete();
}

/*
	Name: function_3b87d567
	Namespace: namespace_92fb2abd
	Checksum: 0x424F4353
	Offset: 0xB90
	Size: 0xB8
	Parameters: 1
	Flags: None
	Line Number: 225
*/
function function_3b87d567(var_original_health)
{
	self endon("hash_death");
	self endon("hash_delete");
	self.var_9d0ff8d7 = 5;
	while(isdefined(self) && function_isalive(self) && self.var_9d0ff8d7 > 0)
	{
		wait(1);
		self.var_9d0ff8d7--;
	}
	if(isdefined(self) && function_isalive(self))
	{
		self.var_health = var_original_health;
		self.var_d229f756 = 0;
		self.var_9d0ff8d7 = 0;
		return;
	}
	waittillframeend;
}

/*
	Name: function_11c25256
	Namespace: namespace_92fb2abd
	Checksum: 0x424F4353
	Offset: 0xC50
	Size: 0x98
	Parameters: 0
	Flags: None
	Line Number: 255
*/
function function_11c25256()
{
	self endon("hash_death");
	self endon("hash_delete");
	self.var_8815f6c1["shot_timer"] = self.var_8815f6c1["cooldown_shot"];
	while(isdefined(self) && self.var_8815f6c1["shot_timer"] > 0)
	{
		wait(1);
		self.var_8815f6c1["shot_timer"]--;
	}
	self.var_8815f6c1["shot_timer"] = 0;
	return;
	ERROR: Bad function call
}

/*
	Name: function_859f0d29
	Namespace: namespace_92fb2abd
	Checksum: 0x424F4353
	Offset: 0xCF0
	Size: 0x2B8
	Parameters: 13
	Flags: None
	Line Number: 280
*/
function function_859f0d29(var_str_means_of_death, var_str_hit_location, var_v_hit_origin, var_e_player, var_n_amount, var_w_weapon, var_direction_vec, var_tagName, var_modelName, var_partName, var_dFlags, var_inflictor, var_chargeLevel)
{
	if(!isdefined(var_e_player) || !function_isPlayer(var_e_player))
	{
		return 0;
	}
	if(var_str_means_of_death == "MOD_MELEE" || var_str_means_of_death == "MOD_GRENADE" || var_str_means_of_death == "MOD_GRENADE_SPLASH" || var_str_means_of_death == "MOD_EXPLOSIVE" || var_str_means_of_death == "MOD_EXPLOSIVE_SPLASH" || var_str_means_of_death == "MOD_ELECTROCUTED")
	{
		function_IPrintLnBold("Bullshit here");
		return 0;
	}
	if(isdefined(var_w_weapon.var_is_wonder_weapon) && var_w_weapon.var_is_wonder_weapon || namespace_Array::function_contains(level.var_e33eb0d5, var_w_weapon.var_name))
	{
		function_IPrintLnBold("Wonder Weapon");
		return 0;
	}
	if(var_e_player function_hasPerk("specialty_immunetriggershock") && isdefined(var_e_player.var_8815f6c1))
	{
		var_proc = function_randomIntRange(0, 100);
		if(var_e_player.var_8815f6c1["shot_timer"] < 1 && (!(isdefined(self.var_d229f756) && self.var_d229f756)) && var_proc < var_e_player.var_8815f6c1["proc_chance"])
		{
			self.var_d229f756 = 1;
			function_iprintln("proc frost");
			var_original_health = self.var_health;
			self.var_health = 1;
			self thread function_8224092f();
			self thread function_3b87d567();
			var_e_player thread function_11c25256();
		}
	}
	return 1;
}

/*
	Name: function_zombie_gib_all
	Namespace: namespace_92fb2abd
	Checksum: 0x424F4353
	Offset: 0xFB0
	Size: 0xB0
	Parameters: 0
	Flags: None
	Line Number: 323
*/
function function_zombie_gib_all()
{
	if(!isdefined(self))
	{
		return;
	}
	if(isdefined(self.var_is_mechz) && self.var_is_mechz)
	{
		return;
	}
	var_a_gib_ref = [];
	var_a_gib_ref[0] = level.var__ZOMBIE_GIB_PIECE_INDEX_ALL;
	self function_gib("normal", var_a_gib_ref);
	self function_ghost();
	wait(0.4);
	if(isdefined(self))
	{
		self function_delete();
		return;
	}
}

/*
	Name: function_8224092f
	Namespace: namespace_92fb2abd
	Checksum: 0x424F4353
	Offset: 0x1068
	Size: 0x2E8
	Parameters: 2
	Flags: None
	Line Number: 355
*/
function function_8224092f(var_235f6429, var_f2c60ac)
{
	if(!isdefined(var_235f6429))
	{
		var_235f6429 = 0;
	}
	if(!isdefined(var_f2c60ac))
	{
		var_f2c60ac = 0;
	}
	if(!isdefined(self))
	{
		return;
	}
	if(isdefined(self.var_8b9eeef0) && self.var_8b9eeef0)
	{
		return;
	}
	self.var_8b9eeef0 = 1;
	self notify("hash_9330cd43", 1);
	self namespace_clientfield::function_set("frost_brew_freeze_zombie", 1);
	self namespace_clientfield::function_set("frost_brew_freeze_fx", 1);
	var_i = 1;
	while(var_i > 0.03)
	{
		if(!isdefined(self))
		{
			return;
		}
		var_i = var_i - 0.1;
		self function_ASMSetAnimationRate(var_i);
		wait(0.1);
	}
	self function_ASMSetAnimationRate(0.4);
	self function_SetEntityPaused(1);
	self namespace_util::function_waittill_any_timeout(function_RandomFloatRange(2.8, 3.7), "stop_frozen_frost_brew");
	if(!isdefined(self))
	{
		return;
	}
	if(isdefined(var_f2c60ac) && var_f2c60ac)
	{
		return;
	}
	self notify("hash_9330cd43", 0);
	self namespace_clientfield::function_set("frost_brew_freeze_zombie", 0);
	self namespace_clientfield::function_set("frost_brew_freeze_fx", 0);
	var_i = 0;
	while(var_i < 1)
	{
		if(!isdefined(self))
		{
			return;
		}
		var_i = var_i + 0.1;
		self function_ASMSetAnimationRate(var_i);
		wait(0.1);
	}
	if(self.var_a5b49611)
	{
		if(isdefined(self.var_completed_emerging_into_playable_area))
		{
			self function_ASMSetAnimationRate(1.1);
		}
		else
		{
			self function_ASMSetAnimationRate(1);
		}
	}
	else
	{
		self function_ASMSetAnimationRate(1);
	}
	self function_SetEntityPaused(0);
	self.var_8b9eeef0 = undefined;
}

/*
	Name: function_fecb0a26
	Namespace: namespace_92fb2abd
	Checksum: 0x424F4353
	Offset: 0x1358
	Size: 0x128
	Parameters: 1
	Flags: Private
	Line Number: 442
*/
function private function_fecb0a26(var_e_attacker)
{
	if(var_e_attacker function_hasPerk("specialty_immunetriggershock") && isdefined(var_e_attacker.var_8815f6c1))
	{
		if(isdefined(self.var_d229f756) && self.var_d229f756)
		{
			if(isdefined(self))
			{
				self function_ASMSetAnimationRate(1);
				if(isdefined(self.var_29a68cca))
				{
				}
				else
				{
				}
				function_playFX("_sphynx/perks/frost_brew_explode", self function_GetTagOrigin("j_spinelower"), self.var_29a68cca);
				self namespace_clientfield::function_set("frost_brew_freeze_fx", 0);
				self thread function_zombie_gib_all();
			}
		}
	}
}

/*
	Name: function_e715d10c
	Namespace: namespace_92fb2abd
	Checksum: 0x424F4353
	Offset: 0x1488
	Size: 0xC0
	Parameters: 0
	Flags: None
	Line Number: 475
*/
function function_e715d10c()
{
	self endon("hash_death");
	self endon("hash_delete");
	while(isdefined(self) && function_isalive(self))
	{
		self waittill("hash_9330cd43", var_activate);
		if(isdefined(var_activate) && var_activate)
		{
			self namespace_clientfield::function_set("zombie_eye_change_frozen", 1);
		}
		else if(!(isdefined(self.var_d229f756) && self.var_d229f756))
		{
			self namespace_clientfield::function_set("zombie_eye_change_frozen", 0);
		}
	}
}

/*
	Name: function_93a7e88
	Namespace: namespace_92fb2abd
	Checksum: 0x424F4353
	Offset: 0x1550
	Size: 0x120
	Parameters: 0
	Flags: None
	Line Number: 503
*/
function function_93a7e88()
{
	self endon("hash_death");
	self endon("hash_delete");
	self thread function_e715d10c();
	self.var_9330cd43 = 0;
	while(isdefined(self) && function_isalive(self))
	{
		if(isdefined(self function_af363fd1()) && self function_af363fd1() && (!(isdefined(self.var_9330cd43) && self.var_9330cd43)))
		{
			self thread function_f609a7de();
		}
		else if(!(isdefined(self function_af363fd1()) && self function_af363fd1()) && (isdefined(self.var_9330cd43) && self.var_9330cd43))
		{
			self thread function_7a915bd6();
		}
		wait(0.05);
	}
}

/*
	Name: function_af363fd1
	Namespace: namespace_92fb2abd
	Checksum: 0x424F4353
	Offset: 0x1678
	Size: 0x110
	Parameters: 0
	Flags: None
	Line Number: 533
*/
function function_af363fd1()
{
	foreach(var_player in function_GetPlayers())
	{
		if(var_player function_hasPerk("specialty_immunetriggershock"))
		{
			var_dist = function_Distance2D(self.var_origin, var_player.var_origin);
			if(var_dist < 90 && var_dist >= 65 && (!(isdefined(self.var_2dce8d67) && self.var_2dce8d67)))
			{
				return 1;
			}
		}
	}
	return 0;
}

/*
	Name: function_f609a7de
	Namespace: namespace_92fb2abd
	Checksum: 0x424F4353
	Offset: 0x1790
	Size: 0x90
	Parameters: 0
	Flags: None
	Line Number: 559
*/
function function_f609a7de()
{
	if(!(isdefined(self.var_9330cd43) && self.var_9330cd43) && (!(isdefined(self.var_b_widows_wine_cocoon) && self.var_b_widows_wine_cocoon)) && (!(isdefined(level.var_9d2e4d70) && level.var_9d2e4d70)))
	{
		self function_ASMSetAnimationRate(0.78);
		self.var_9330cd43 = 1;
		self notify("hash_9330cd43", 1);
		return;
	}
	ERROR: Bad function call
}

/*
	Name: function_7a915bd6
	Namespace: namespace_92fb2abd
	Checksum: 0x424F4353
	Offset: 0x1828
	Size: 0x7E
	Parameters: 0
	Flags: None
	Line Number: 581
*/
function function_7a915bd6()
{
	if(isdefined(self.var_9330cd43) && self.var_9330cd43 && (!(isdefined(self.var_b_widows_wine_cocoon) && self.var_b_widows_wine_cocoon)) && (!(isdefined(level.var_9d2e4d70) && level.var_9d2e4d70)))
	{
		self function_ASMSetAnimationRate(1);
		self.var_9330cd43 = 0;
		self notify("hash_9330cd43", 0);
	}
}

