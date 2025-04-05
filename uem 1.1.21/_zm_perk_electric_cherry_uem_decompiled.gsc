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
	Name: function___init__sytem__
	Namespace: namespace_2310fe1d
	Checksum: 0x424F4353
	Offset: 0x588
	Size: 0x38
	Parameters: 0
	Flags: AutoExec
	Line Number: 31
*/
function autoexec function___init__sytem__()
{
	namespace_system::function_register("zm_perk_electric_cherry_uem", &function___init__, undefined, undefined);
}

/*
	Name: function___init__
	Namespace: namespace_2310fe1d
	Checksum: 0x424F4353
	Offset: 0x5C8
	Size: 0x18
	Parameters: 0
	Flags: None
	Line Number: 46
*/
function function___init__()
{
	function_enable_electric_cherry_perk_for_level();
}

/*
	Name: function_enable_electric_cherry_perk_for_level
	Namespace: namespace_2310fe1d
	Checksum: 0x424F4353
	Offset: 0x5E8
	Size: 0x168
	Parameters: 0
	Flags: None
	Line Number: 61
*/
function function_enable_electric_cherry_perk_for_level()
{
	namespace_zm_perks::function_register_perk_basic_info("specialty_electriccherry", "electric_cherry", 2000, &"ZM_MINECRAFT_PERK_CHERRY", function_GetWeapon("zombie_perk_bottle_cherry"));
	namespace_zm_perks::function_register_perk_precache_func("specialty_electriccherry", &function_electric_cherry_precache);
	namespace_zm_perks::function_register_perk_clientfields("specialty_electriccherry", &function_electric_cherry_register_clientfield, &function_electric_cherry_set_clientfield);
	namespace_zm_perks::function_register_perk_machine("specialty_electriccherry", &function_electric_cherry_perk_machine_setup);
	namespace_zm_perks::function_register_perk_host_migration_params("specialty_electriccherry", "p6_zm_vending_electric_cherry", "electric_cherry_light");
	namespace_zm_perks::function_register_perk_threads("specialty_electriccherry", &function_electric_cherry_reload_attack, &function_electric_cherry_perk_lost);
	if(isdefined(level.var_custom_electric_cherry_perk_threads) && level.var_custom_electric_cherry_perk_threads)
	{
		level thread [[level.var_custom_electric_cherry_perk_threads]]();
	}
	function_init_electric_cherry();
}

/*
	Name: function_electric_cherry_precache
	Namespace: namespace_2310fe1d
	Checksum: 0x424F4353
	Offset: 0x758
	Size: 0xE0
	Parameters: 0
	Flags: None
	Line Number: 86
*/
function function_electric_cherry_precache()
{
	if(isdefined(level.var_electric_cherry_precache_override_func))
	{
		[[level.var_electric_cherry_precache_override_func]]();
		return;
	}
	level.var__effect["electric_cherry_light"] = "_t6/misc/fx_zombie_cola_revive_on";
	level.var_machine_assets["specialty_electriccherry"] = function_spawnstruct();
	level.var_machine_assets["specialty_electriccherry"].var_weapon = function_GetWeapon("zombie_perk_bottle_cherry");
	level.var_machine_assets["specialty_electriccherry"].var_off_model = "p6_zm_vending_electric_cherry";
	level.var_machine_assets["specialty_electriccherry"].var_on_model = "p6_zm_vending_electric_cherry";
}

/*
	Name: function_electric_cherry_register_clientfield
	Namespace: namespace_2310fe1d
	Checksum: 0x424F4353
	Offset: 0x840
	Size: 0x38
	Parameters: 0
	Flags: None
	Line Number: 110
*/
function function_electric_cherry_register_clientfield()
{
	namespace_clientfield::function_register("clientuimodel", "hudItems.perks.electric_cherry_uem", 1, 2, "int");
}

/*
	Name: function_electric_cherry_set_clientfield
	Namespace: namespace_2310fe1d
	Checksum: 0x424F4353
	Offset: 0x880
	Size: 0x30
	Parameters: 1
	Flags: None
	Line Number: 125
*/
function function_electric_cherry_set_clientfield(var_State)
{
	self namespace_clientfield::function_set_player_uimodel("hudItems.perks.electric_cherry_uem", var_State);
	return;
	ERROR: Exception occured: Stack empty.
}

/*
	Name: function_electric_cherry_perk_machine_setup
	Namespace: namespace_2310fe1d
	Checksum: 0x424F4353
	Offset: 0x8B8
	Size: 0xC0
	Parameters: 4
	Flags: None
	Line Number: 142
*/
function function_electric_cherry_perk_machine_setup(var_use_trigger, var_perk_machine, var_bump_trigger, var_collision)
{
	var_use_trigger.var_script_sound = "mus_perks_ec_jingle";
	var_use_trigger.var_script_string = "electriccherry_perk";
	var_use_trigger.var_script_label = "mus_perks_ec_sting";
	var_use_trigger.var_target = "vending_electriccherry";
	var_perk_machine.var_script_string = "electriccherry_perk";
	var_perk_machine.var_targetname = "vending_electriccherry";
	if(isdefined(var_bump_trigger))
	{
		var_bump_trigger.var_script_string = "electriccherry_perk";
	}
}

/*
	Name: function_init_electric_cherry
	Namespace: namespace_2310fe1d
	Checksum: 0x424F4353
	Offset: 0x980
	Size: 0x148
	Parameters: 0
	Flags: None
	Line Number: 166
*/
function function_init_electric_cherry()
{
	level.var__effect["electric_cherry_explode"] = "dlc1/castle/fx_castle_electric_cherry_down";
	level.var_custom_laststand_func = &function_electric_cherry_laststand;
	namespace_zombie_utility::function_set_zombie_var("tesla_head_gib_chance", 50);
	namespace_clientfield::function_register("allplayers", "electric_cherry_reload_fx", 1, 2, "int");
	namespace_clientfield::function_register("actor", "tesla_death_fx", 1, 1, "int");
	namespace_clientfield::function_register("vehicle", "tesla_death_fx_veh", 10000, 1, "int");
	namespace_clientfield::function_register("actor", "tesla_shock_eyes_fx", 1, 1, "int");
	namespace_clientfield::function_register("vehicle", "tesla_shock_eyes_fx_veh", 10000, 1, "int");
}

/*
	Name: function_electric_cherry_laststand
	Namespace: namespace_2310fe1d
	Checksum: 0x424F4353
	Offset: 0xAD0
	Size: 0x238
	Parameters: 0
	Flags: None
	Line Number: 188
*/
function function_electric_cherry_laststand()
{
	function_VisionSetLastStand("zombie_last_stand", 1);
	if(isdefined(self))
	{
		function_playFX(level.var__effect["electric_cherry_explode"], self.var_origin);
		self function_playsound("zmb_cherry_explode");
		self notify("hash_electric_cherry_start");
		wait(0.05);
		var_a_zombies = namespace_zombie_utility::function_get_round_enemy_array();
		var_a_zombies = namespace_util::function_get_array_of_closest(self.var_origin, var_a_zombies, undefined, undefined, 500);
		for(var_i = 0; var_i < var_a_zombies.size; var_i++)
		{
			if(function_isalive(self) && function_isalive(var_a_zombies[var_i]))
			{
				if(var_a_zombies[var_i].var_health <= 1000)
				{
					var_a_zombies[var_i] thread function_electric_cherry_death_fx();
					if(isdefined(self.var_cherry_kills))
					{
						self.var_cherry_kills++;
					}
					self namespace_zm_score::function_add_to_player_score(40);
				}
				else
				{
					var_a_zombies[var_i] thread function_electric_cherry_stun();
					var_a_zombies[var_i] thread function_electric_cherry_shock_fx();
				}
				wait(0.1);
				var_a_zombies[var_i] function_DoDamage(1000, self.var_origin, self, self, "none");
			}
		}
		self notify("hash_electric_cherry_end");
	}
}

/*
	Name: function_electric_cherry_death_fx
	Namespace: namespace_2310fe1d
	Checksum: 0x424F4353
	Offset: 0xD10
	Size: 0x100
	Parameters: 0
	Flags: None
	Line Number: 235
*/
function function_electric_cherry_death_fx()
{
	self endon("hash_death");
	self function_playsound("zmb_elec_jib_zombie");
	if(!(isdefined(self.var_head_gibbed) && self.var_head_gibbed))
	{
		if(function_isVehicle(self))
		{
			self namespace_clientfield::function_set("tesla_shock_eyes_fx_veh", 1);
		}
		else
		{
			self namespace_clientfield::function_set("tesla_shock_eyes_fx", 1);
		}
	}
	else if(function_isVehicle(self))
	{
		self namespace_clientfield::function_set("tesla_death_fx_veh", 1);
	}
	else
	{
		self namespace_clientfield::function_set("tesla_death_fx", 1);
		return;
	}
}

/*
	Name: function_electric_cherry_shock_fx
	Namespace: namespace_2310fe1d
	Checksum: 0x424F4353
	Offset: 0xE18
	Size: 0xF0
	Parameters: 0
	Flags: None
	Line Number: 271
*/
function function_electric_cherry_shock_fx()
{
	self endon("hash_death");
	if(function_isVehicle(self))
	{
		self namespace_clientfield::function_set("tesla_shock_eyes_fx_veh", 1);
	}
	else
	{
		self namespace_clientfield::function_set("tesla_shock_eyes_fx", 1);
	}
	self function_playsound("zmb_elec_jib_zombie");
	self waittill("hash_stun_fx_end");
	if(function_isVehicle(self))
	{
		self namespace_clientfield::function_set("tesla_shock_eyes_fx_veh", 0);
	}
	else
	{
		self namespace_clientfield::function_set("tesla_shock_eyes_fx", 0);
	}
}

/*
	Name: function_electric_cherry_stun
	Namespace: namespace_2310fe1d
	Checksum: 0x424F4353
	Offset: 0xF10
	Size: 0xA0
	Parameters: 0
	Flags: None
	Line Number: 304
*/
function function_electric_cherry_stun()
{
	self endon("hash_death");
	self notify("hash_stun_zombie");
	self endon("hash_stun_zombie");
	if(self.var_health <= 0)
	{
		return;
	}
	if(self.var_ai_state !== "zombie_think")
	{
		return;
	}
	self.var_zombie_tesla_hit = 1;
	self.var_ignoreall = 1;
	wait(4);
	if(isdefined(self))
	{
		self.var_zombie_tesla_hit = 0;
		self.var_ignoreall = 0;
		self notify("hash_stun_fx_end");
	}
}

/*
	Name: function_electric_cherry_reload_attack
	Namespace: namespace_2310fe1d
	Checksum: 0x424F4353
	Offset: 0xFB8
	Size: 0x4A8
	Parameters: 0
	Flags: None
	Line Number: 338
*/
function function_electric_cherry_reload_attack()
{
	self endon("hash_death");
	self endon("hash_disconnect");
	self endon("specialty_electriccherry" + "_stop");
	self.var_wait_on_reload = [];
	self.var_consecutive_electric_cherry_attacks = 0;
	while(1)
	{
		self waittill("hash_reload_start");
		var_current_weapon = self function_GetCurrentWeapon();
		if(function_IsInArray(self.var_wait_on_reload, var_current_weapon))
		{
			continue;
		}
		self.var_wait_on_reload[self.var_wait_on_reload.size] = var_current_weapon;
		self.var_consecutive_electric_cherry_attacks++;
		var_n_clip_current = 1;
		var_n_clip_max = 10;
		var_n_fraction = var_n_clip_current / var_n_clip_max;
		var_perk_radius = namespace_math::function_linear_map(var_n_fraction, 1, 0, 32, 128);
		var_perk_dmg = namespace_math::function_linear_map(var_n_fraction, 1, 0, 1, 1045);
		self thread function_check_for_reload_complete(var_current_weapon);
		if(isdefined(self))
		{
			switch(self.var_consecutive_electric_cherry_attacks)
			{
				case 0:
				case 1:
				{
					var_n_zombie_limit = undefined;
					break;
				}
				case 2:
				{
					var_n_zombie_limit = 8;
					break;
				}
				case 3:
				{
					var_n_zombie_limit = 4;
					break;
				}
				case 4:
				{
					var_n_zombie_limit = 2;
					break;
				}
				default
				{
					var_n_zombie_limit = 0;
				}
			}
			self thread function_electric_cherry_cooldown_timer(var_current_weapon);
			if(isdefined(var_n_zombie_limit) && var_n_zombie_limit == 0)
			{
				continue;
			}
			self thread function_electric_cherry_reload_fx(var_n_fraction);
			self notify("hash_electric_cherry_start");
			self function_playsound("zmb_cherry_explode");
			var_a_zombies = namespace_zombie_utility::function_get_round_enemy_array();
			var_a_zombies = namespace_util::function_get_array_of_closest(self.var_origin, var_a_zombies, undefined, undefined, var_perk_radius);
			var_n_zombies_hit = 0;
			for(var_i = 0; var_i < var_a_zombies.size; var_i++)
			{
				if(function_isalive(self) && function_isalive(var_a_zombies[var_i]))
				{
					if(isdefined(var_n_zombie_limit))
					{
						if(var_n_zombies_hit < var_n_zombie_limit)
						{
							var_n_zombies_hit++;
							break;
						}
						else
						{
						}
					}
					if(var_a_zombies[var_i].var_health <= var_perk_dmg)
					{
						var_a_zombies[var_i] thread function_electric_cherry_death_fx();
						if(isdefined(self.var_cherry_kills))
						{
							self.var_cherry_kills++;
						}
						self namespace_zm_score::function_add_to_player_score(40);
					}
					else if(!isdefined(var_a_zombies[var_i].var_is_brutus))
					{
						var_a_zombies[var_i] thread function_electric_cherry_stun();
					}
					var_a_zombies[var_i] thread function_electric_cherry_shock_fx();
					wait(0.1);
					if(isdefined(var_a_zombies[var_i]) && function_isalive(var_a_zombies[var_i]))
					{
						var_a_zombies[var_i] function_DoDamage(var_perk_dmg, self.var_origin, self, self, "none");
					}
				}
			}
			self notify("hash_electric_cherry_end");
		}
	}
}

/*
	Name: function_electric_cherry_cooldown_timer
	Namespace: namespace_2310fe1d
	Checksum: 0x424F4353
	Offset: 0x1468
	Size: 0xC8
	Parameters: 1
	Flags: None
	Line Number: 453
*/
function function_electric_cherry_cooldown_timer(var_current_weapon)
{
	self notify("hash_electric_cherry_cooldown_started");
	self endon("hash_electric_cherry_cooldown_started");
	self endon("hash_death");
	self endon("hash_disconnect");
	var_n_reload_time = 0.25;
	if(self function_hasPerk("specialty_fastreload"))
	{
		var_n_reload_time = var_n_reload_time * function_GetDvarFloat("perk_weapReloadMultiplier");
	}
	var_n_cooldown_time = var_n_reload_time + 3;
	wait(var_n_cooldown_time);
	self.var_consecutive_electric_cherry_attacks = 0;
	return;
}

/*
	Name: function_check_for_reload_complete
	Namespace: namespace_2310fe1d
	Checksum: 0x424F4353
	Offset: 0x1538
	Size: 0xD8
	Parameters: 1
	Flags: None
	Line Number: 480
*/
function function_check_for_reload_complete(var_weapon)
{
	self endon("hash_death");
	self endon("hash_disconnect");
	self endon("player_lost_weapon_" + var_weapon.var_name);
	self thread function_weapon_replaced_monitor(var_weapon);
	while(1)
	{
		self waittill("hash_reload");
		var_current_weapon = self function_GetCurrentWeapon();
		if(var_current_weapon == var_weapon)
		{
			function_ArrayRemoveValue(self.var_wait_on_reload, var_weapon);
			self notify("weapon_reload_complete_" + var_weapon.var_name);
			break;
		}
	}
}

/*
	Name: function_weapon_replaced_monitor
	Namespace: namespace_2310fe1d
	Checksum: 0x424F4353
	Offset: 0x1618
	Size: 0xD0
	Parameters: 1
	Flags: None
	Line Number: 509
*/
function function_weapon_replaced_monitor(var_weapon)
{
	self endon("hash_death");
	self endon("hash_disconnect");
	self endon("weapon_reload_complete_" + var_weapon.var_name);
	while(1)
	{
		self waittill("hash_weapon_change");
		var_primaryWeapons = self function_GetWeaponsListPrimaries();
		if(!function_IsInArray(var_primaryWeapons, var_weapon))
		{
			self notify("player_lost_weapon_" + var_weapon.var_name);
			function_ArrayRemoveValue(self.var_wait_on_reload, var_weapon);
			break;
		}
	}
}

/*
	Name: function_electric_cherry_reload_fx
	Namespace: namespace_2310fe1d
	Checksum: 0x424F4353
	Offset: 0x16F0
	Size: 0xD8
	Parameters: 1
	Flags: None
	Line Number: 537
*/
function function_electric_cherry_reload_fx(var_n_fraction)
{
	if(var_n_fraction >= 0.67)
	{
		function_CodeSetClientField(self, "electric_cherry_reload_fx", 1);
	}
	else if(var_n_fraction >= 0.33 && var_n_fraction < 0.67)
	{
		function_CodeSetClientField(self, "electric_cherry_reload_fx", 2);
	}
	else
	{
		function_CodeSetClientField(self, "electric_cherry_reload_fx", 3);
	}
	wait(1);
	function_CodeSetClientField(self, "electric_cherry_reload_fx", 0);
}

/*
	Name: function_electric_cherry_perk_lost
	Namespace: namespace_2310fe1d
	Checksum: 0x424F4353
	Offset: 0x17D0
	Size: 0x34
	Parameters: 3
	Flags: None
	Line Number: 565
*/
function function_electric_cherry_perk_lost(var_b_pause, var_str_perk, var_str_result)
{
	self notify("specialty_electriccherry" + "_stop");
}

