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
	Name: __init__sytem__
	Namespace: namespace_92fb2abd
	Checksum: 0x424F4353
	Offset: 0x500
	Size: 0x38
	Parameters: 0
	Flags: AutoExec
	Line Number: 24
*/
function autoexec __init__sytem__()
{
	system::register("zm_perk_frost_brew", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: namespace_92fb2abd
	Checksum: 0x424F4353
	Offset: 0x540
	Size: 0xE8
	Parameters: 0
	Flags: None
	Line Number: 39
*/
function __init__()
{
	clientfield::register("actor", "frost_brew_freeze_zombie", 1, 1, "int");
	clientfield::register("actor", "frost_brew_freeze_fx", 1, 1, "int");
	clientfield::register("actor", "zombie_eye_change_frozen", 1, 1, "int");
	zm_spawner::register_zombie_death_event_callback(&function_fecb0a26);
	zm_spawner::add_custom_zombie_spawn_logic(&function_93a7e88);
	function_b72a09fe();
}

/*
	Name: function_b72a09fe
	Namespace: namespace_92fb2abd
	Checksum: 0x424F4353
	Offset: 0x630
	Size: 0x140
	Parameters: 0
	Flags: None
	Line Number: 59
*/
function function_b72a09fe()
{
	zm_perks::register_perk_basic_info("specialty_immunetriggershock", "frost_brew", 4000, &"ZM_MINECRAFT_PERK_FROST_BREW", getweapon("zombie_perk_bottle_frost_brew"));
	zm_perks::register_perk_precache_func("specialty_immunetriggershock", &function_2221eb44);
	zm_perks::register_perk_clientfields("specialty_immunetriggershock", &function_9511862e, &function_15cb57f);
	zm_perks::register_perk_machine("specialty_immunetriggershock", &function_f3a4fbff, &function_589c6f57);
	zm_perks::register_perk_threads("specialty_immunetriggershock", &function_908b7d03, &function_fce6b945);
	zm_perks::register_perk_host_migration_params("specialty_immunetriggershock", "vending_frost_brew", "frost_brew_light");
	return;
}

/*
	Name: function_589c6f57
	Namespace: namespace_92fb2abd
	Checksum: 0x424F4353
	Offset: 0x778
	Size: 0x8
	Parameters: 0
	Flags: None
	Line Number: 80
*/
function function_589c6f57()
{
}

/*
	Name: function_2221eb44
	Namespace: namespace_92fb2abd
	Checksum: 0x424F4353
	Offset: 0x788
	Size: 0xE0
	Parameters: 0
	Flags: None
	Line Number: 94
*/
function function_2221eb44()
{
	if(isdefined(level.var_e32b869c))
	{
		[[level.var_e32b869c]]();
		return;
	}
	level._effect["frost_brew_light"] = "_t6/misc/fx_zombie_cola_dtap_on";
	level.machine_assets["specialty_immunetriggershock"] = spawnstruct();
	level.machine_assets["specialty_immunetriggershock"].weapon = getweapon("zombie_perk_bottle_frost_brew");
	level.machine_assets["specialty_immunetriggershock"].off_model = "logical_m_perkmachine_frostbrew_off";
	level.machine_assets["specialty_immunetriggershock"].on_model = "logical_m_perkmachine_frostbrew_on";
}

/*
	Name: function_9511862e
	Namespace: namespace_92fb2abd
	Checksum: 0x424F4353
	Offset: 0x870
	Size: 0x38
	Parameters: 0
	Flags: None
	Line Number: 118
*/
function function_9511862e()
{
	clientfield::register("clientuimodel", "hudItems.perks.frost_brew", 1, 2, "int");
}

/*
	Name: function_15cb57f
	Namespace: namespace_92fb2abd
	Checksum: 0x424F4353
	Offset: 0x8B0
	Size: 0x30
	Parameters: 1
	Flags: None
	Line Number: 133
*/
function function_15cb57f(state)
{
	self clientfield::set_player_uimodel("hudItems.perks.frost_brew", state);
}

/*
	Name: function_f3a4fbff
	Namespace: namespace_92fb2abd
	Checksum: 0x424F4353
	Offset: 0x8E8
	Size: 0xC0
	Parameters: 4
	Flags: None
	Line Number: 148
*/
function function_f3a4fbff(use_trigger, perk_machine, bump_trigger, collision)
{
	use_trigger.script_sound = "mus_perks_frost_brew_jingle";
	use_trigger.script_string = "frost_brew_perk";
	use_trigger.script_label = "mus_perks_frost_brew_sting";
	use_trigger.target = "vending_frost_brew";
	perk_machine.script_string = "frost_brew_perk";
	perk_machine.targetname = "vending_frost_brew";
	if(isdefined(bump_trigger))
	{
		bump_trigger.script_string = "frost_brew_perk";
	}
}

/*
	Name: function_908b7d03
	Namespace: namespace_92fb2abd
	Checksum: 0x424F4353
	Offset: 0x9B0
	Size: 0x180
	Parameters: 0
	Flags: None
	Line Number: 172
*/
function function_908b7d03()
{
	self endon("disconnect");
	self endon("hash_509f5eb");
	if(!isdefined(self.var_8815f6c1))
	{
		self.var_8815f6c1 = [];
		self.var_8815f6c1["slow_inner_radius"] = 60;
		self.var_8815f6c1["slow_outer_radius"] = 100;
		self.var_8815f6c1["slow_time"] = 3;
		self.var_8815f6c1["slow_recharge"] = 1;
		self.var_8815f6c1["slow_rate"] = 0.75;
		self.var_8815f6c1["slowed_timer"] = 0;
		self.var_8815f6c1["blast_radius"] = 350;
		self.var_8815f6c1["blast_damage"] = 280;
		self.var_8815f6c1["blast_max"] = 2;
		self.var_8815f6c1["proc_chance"] = 20;
		self.var_8815f6c1["cooldown_shot"] = 2;
		self.var_8815f6c1["max_shot"] = 24;
		self.var_8815f6c1["shot_timer"] = 0;
		self.var_8815f6c1["shots"] = 0;
	}
}

/*
	Name: function_fce6b945
	Namespace: namespace_92fb2abd
	Checksum: 0x424F4353
	Offset: 0xB38
	Size: 0x48
	Parameters: 3
	Flags: None
	Line Number: 206
*/
function function_fce6b945(b_pause, str_perk, str_result)
{
	self notify("hash_509f5eb");
	self.var_8815f6c1 delete();
	return;
	ERROR: Exception occured: Stack empty.
}

/*
	Name: function_3b87d567
	Namespace: namespace_92fb2abd
	Checksum: 0x424F4353
	Offset: 0xB88
	Size: 0xB8
	Parameters: 1
	Flags: None
	Line Number: 224
*/
function function_3b87d567(original_health)
{
	self endon("death");
	self endon("delete");
	self.var_9d0ff8d7 = 5;
	while(isdefined(self) && isalive(self) && self.var_9d0ff8d7 > 0)
	{
		wait(1);
		self.var_9d0ff8d7--;
	}
	if(isdefined(self) && isalive(self))
	{
		self.health = original_health;
		self.var_d229f756 = 0;
		self.var_9d0ff8d7 = 0;
	}
}

/*
	Name: function_11c25256
	Namespace: namespace_92fb2abd
	Checksum: 0x424F4353
	Offset: 0xC48
	Size: 0xB0
	Parameters: 0
	Flags: None
	Line Number: 252
*/
function function_11c25256()
{
	self endon("death");
	self endon("delete");
	self.var_8815f6c1["shot_timer"] = self.var_8815f6c1["cooldown_shot"];
	while(isdefined(self) && isalive(self) && self.var_8815f6c1["shot_timer"] > 0)
	{
		wait(1);
		self.var_8815f6c1["shot_timer"]--;
	}
	self.var_8815f6c1["shot_timer"] = 0;
	return;
}

/*
	Name: function_859f0d29
	Namespace: namespace_92fb2abd
	Checksum: 0x424F4353
	Offset: 0xD00
	Size: 0x2A0
	Parameters: 13
	Flags: None
	Line Number: 276
*/
function function_859f0d29(str_means_of_death, str_hit_location, v_hit_origin, e_player, n_amount, w_weapon, direction_vec, tagname, modelname, partname, dflags, inflictor, chargelevel)
{
	if(!isdefined(e_player) || !isplayer(e_player))
	{
		return 0;
	}
	if(str_means_of_death == "MOD_MELEE" || str_means_of_death == "MOD_GRENADE" || str_means_of_death == "MOD_GRENADE_SPLASH" || str_means_of_death == "MOD_EXPLOSIVE" || str_means_of_death == "MOD_EXPLOSIVE_SPLASH" || str_means_of_death == "MOD_ELECTROCUTED")
	{
		iprintlnbold("Bullshit here");
		return 0;
	}
	if(isdefined(w_weapon.is_wonder_weapon) && w_weapon.is_wonder_weapon || array::contains(level.var_e33eb0d5, w_weapon.name))
	{
		iprintlnbold("Wonder Weapon");
		return 0;
	}
	if(e_player hasperk("specialty_immunetriggershock") && isdefined(e_player.var_8815f6c1))
	{
		proc = randomintrange(0, 100);
		if(e_player.var_8815f6c1["shot_timer"] < 1 && (!(isdefined(self.var_d229f756) && self.var_d229f756)) && proc < e_player.var_8815f6c1["proc_chance"])
		{
			self.var_d229f756 = 1;
			original_health = self.health;
			self.health = 1;
			self thread function_8224092f();
			self thread function_3b87d567();
			e_player thread function_11c25256();
		}
	}
	return 1;
}

/*
	Name: zombie_gib_all
	Namespace: namespace_92fb2abd
	Checksum: 0x424F4353
	Offset: 0xFA8
	Size: 0xB0
	Parameters: 0
	Flags: None
	Line Number: 318
*/
function zombie_gib_all()
{
	if(!isdefined(self))
	{
		return;
	}
	if(isdefined(self.is_mechz) && self.is_mechz)
	{
		return;
	}
	a_gib_ref = [];
	a_gib_ref[0] = level._ZOMBIE_GIB_PIECE_INDEX_ALL;
	self gib("normal", a_gib_ref);
	self ghost();
	wait(0.4);
	if(isdefined(self))
	{
		self delete();
		return;
	}
	ERROR: Exception occured: Stack empty.
}

/*
	Name: function_8224092f
	Namespace: namespace_92fb2abd
	Checksum: 0x424F4353
	Offset: 0x1060
	Size: 0x290
	Parameters: 2
	Flags: None
	Line Number: 351
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
	self clientfield::set("frost_brew_freeze_zombie", 1);
	self clientfield::set("frost_brew_freeze_fx", 1);
	i = 1;
	while(i > 0.03)
	{
		if(!isdefined(self))
		{
			return;
		}
		i = i - 0.1;
		self asmsetanimationrate(i);
		wait(0.1);
	}
	self asmsetanimationrate(0.4);
	self setentitypaused(1);
	self util::waittill_any_timeout(randomfloatrange(2.8, 3.7), "stop_frozen_frost_brew");
	if(!isdefined(self))
	{
		return;
	}
	if(isdefined(var_f2c60ac) && var_f2c60ac)
	{
		return;
	}
	self notify("hash_9330cd43", 0);
	self clientfield::set("frost_brew_freeze_zombie", 0);
	self clientfield::set("frost_brew_freeze_fx", 0);
	i = 0;
	while(i < 1)
	{
		if(!isdefined(self))
		{
			return;
		}
		i = i + 0.1;
		self asmsetanimationrate(i);
		wait(0.1);
	}
	self asmsetanimationrate(1);
	self setentitypaused(0);
	self.var_8b9eeef0 = undefined;
}

/*
	Name: function_fecb0a26
	Namespace: namespace_92fb2abd
	Checksum: 0x424F4353
	Offset: 0x12F8
	Size: 0x110
	Parameters: 1
	Flags: Private
	Line Number: 424
*/
function private function_fecb0a26(e_attacker)
{
	if(e_attacker hasperk("specialty_immunetriggershock") && isdefined(e_attacker.var_8815f6c1))
	{
		if(isdefined(self.var_d229f756) && self.var_d229f756)
		{
			if(isdefined(self))
			{
				if(isdefined(self.var_29a68cca))
				{
				}
				else
				{
				}
				playfx("_sphynx/perks/frost_brew_explode", self gettagorigin("j_spinelower"), self.var_29a68cca);
				self clientfield::set("frost_brew_freeze_fx", 0);
				self thread zombie_gib_all();
			}
		}
	}
}

/*
	Name: function_e715d10c
	Namespace: namespace_92fb2abd
	Checksum: 0x424F4353
	Offset: 0x1410
	Size: 0xC0
	Parameters: 0
	Flags: None
	Line Number: 456
*/
function function_e715d10c()
{
	self endon("death");
	self endon("delete");
	while(isdefined(self) && isalive(self))
	{
		self waittill("hash_9330cd43", activate);
		if(isdefined(activate) && activate)
		{
			self clientfield::set("zombie_eye_change_frozen", 1);
		}
		else if(!(isdefined(self.var_d229f756) && self.var_d229f756))
		{
			self clientfield::set("zombie_eye_change_frozen", 0);
		}
	}
}

/*
	Name: function_93a7e88
	Namespace: namespace_92fb2abd
	Checksum: 0x424F4353
	Offset: 0x14D8
	Size: 0x120
	Parameters: 0
	Flags: None
	Line Number: 484
*/
function function_93a7e88()
{
	self endon("death");
	self endon("delete");
	self thread function_e715d10c();
	self.var_9330cd43 = 0;
	while(isdefined(self) && isalive(self))
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
	Offset: 0x1600
	Size: 0x110
	Parameters: 0
	Flags: None
	Line Number: 514
*/
function function_af363fd1()
{
	foreach(player in getplayers())
	{
		if(player hasperk("specialty_immunetriggershock"))
		{
			dist = distance2d(self.origin, player.origin);
			if(dist < 100 && dist >= 60 && (!(isdefined(self.var_2dce8d67) && self.var_2dce8d67)))
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
	Offset: 0x1718
	Size: 0x90
	Parameters: 0
	Flags: None
	Line Number: 540
*/
function function_f609a7de()
{
	if(!(isdefined(self.var_9330cd43) && self.var_9330cd43) && (!(isdefined(self.b_widows_wine_cocoon) && self.b_widows_wine_cocoon)) && (!(isdefined(level.var_9d2e4d70) && level.var_9d2e4d70)))
	{
		self asmsetanimationrate(0.75);
		self.var_9330cd43 = 1;
		self notify("hash_9330cd43", 1);
	}
}

/*
	Name: function_7a915bd6
	Namespace: namespace_92fb2abd
	Checksum: 0x424F4353
	Offset: 0x17B0
	Size: 0x7E
	Parameters: 0
	Flags: None
	Line Number: 560
*/
function function_7a915bd6()
{
	if(isdefined(self.var_9330cd43) && self.var_9330cd43 && (!(isdefined(self.b_widows_wine_cocoon) && self.b_widows_wine_cocoon)) && (!(isdefined(level.var_9d2e4d70) && level.var_9d2e4d70)))
	{
		self asmsetanimationrate(1);
		self.var_9330cd43 = 0;
		self notify("hash_9330cd43", 0);
	}
}

