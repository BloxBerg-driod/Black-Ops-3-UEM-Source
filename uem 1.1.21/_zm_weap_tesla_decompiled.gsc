#include scripts\codescripts\struct;
#include scripts\shared\ai\zombie_utility;
#include scripts\shared\array_shared;
#include scripts\shared\callbacks_shared;
#include scripts\shared\demo_shared;
#include scripts\shared\laststand_shared;
#include scripts\shared\util_shared;
#include scripts\zm\_util;
#include scripts\zm\_zm;
#include scripts\zm\_zm_audio;
#include scripts\zm\_zm_laststand;
#include scripts\zm\_zm_lightning_chain;
#include scripts\zm\_zm_net;
#include scripts\zm\_zm_score;
#include scripts\zm\_zm_spawner;
#include scripts\zm\_zm_utility;
#include scripts\zm\_zm_weap_tesla;
#include scripts\zm\_zm_weapons;

#namespace namespace__zm_weap_tesla;

/*
	Name: function_init
	Namespace: namespace__zm_weap_tesla
	Checksum: 0x424F4353
	Offset: 0x688
	Size: 0x3B8
	Parameters: 0
	Flags: None
	Line Number: 31
*/
function function_init()
{
	level.var_weaponZMTeslaGun = function_GetWeapon("tesla_gun");
	level.var_weaponZMTeslaGunUpgraded = function_GetWeapon("tesla_gun_upgraded");
	if(!namespace_zm_weapons::function_is_weapon_included(level.var_weaponZMTeslaGun) && (!(isdefined(level.var_uses_tesla_powerup) && level.var_uses_tesla_powerup)))
	{
		return;
	}
	level.var__effect["tesla_viewmodel_rail"] = "zombie/fx_tesla_rail_view_zmb";
	level.var__effect["tesla_viewmodel_tube"] = "zombie/fx_tesla_tube_view_zmb";
	level.var__effect["tesla_viewmodel_tube2"] = "zombie/fx_tesla_tube_view2_zmb";
	level.var__effect["tesla_viewmodel_tube3"] = "zombie/fx_tesla_tube_view3_zmb";
	level.var__effect["tesla_viewmodel_rail_upgraded"] = "zombie/fx_tesla_rail_view_ug_zmb";
	level.var__effect["tesla_viewmodel_tube_upgraded"] = "zombie/fx_tesla_tube_view_ug_zmb";
	level.var__effect["tesla_viewmodel_tube2_upgraded"] = "zombie/fx_tesla_tube_view2_ug_zmb";
	level.var__effect["tesla_viewmodel_tube3_upgraded"] = "zombie/fx_tesla_tube_view3_ug_zmb";
	level.var__effect["tesla_shock_eyes"] = "zombie/fx_tesla_shock_eyes_zmb";
	namespace_zm::function_register_zombie_damage_override_callback(&function_tesla_zombie_damage_response);
	namespace_zm_spawner::function_register_zombie_death_animscript_callback(&function_tesla_zombie_death_response);
	namespace_zombie_utility::function_set_zombie_var("tesla_max_arcs", 5);
	namespace_zombie_utility::function_set_zombie_var("tesla_max_enemies_killed", 10);
	namespace_zombie_utility::function_set_zombie_var("tesla_radius_start", 300);
	namespace_zombie_utility::function_set_zombie_var("tesla_radius_decay", 20);
	namespace_zombie_utility::function_set_zombie_var("tesla_head_gib_chance", 75);
	namespace_zombie_utility::function_set_zombie_var("tesla_arc_travel_time", 0.11, 1);
	namespace_zombie_utility::function_set_zombie_var("tesla_kills_for_powerup", 10);
	namespace_zombie_utility::function_set_zombie_var("tesla_min_fx_distance", 128);
	namespace_zombie_utility::function_set_zombie_var("tesla_network_death_choke", 4);
	level.var_tesla_lightning_params = namespace_lightning_chain::function_create_lightning_chain_params(level.var_zombie_vars["tesla_max_arcs"], level.var_zombie_vars["tesla_max_enemies_killed"], level.var_zombie_vars["tesla_radius_start"], level.var_zombie_vars["tesla_radius_decay"], level.var_zombie_vars["tesla_head_gib_chance"], level.var_zombie_vars["tesla_arc_travel_time"], level.var_zombie_vars["tesla_kills_for_powerup"], level.var_zombie_vars["tesla_min_fx_distance"], level.var_zombie_vars["tesla_network_death_choke"], undefined, undefined, "wpn_tesla_bounce");
	namespace_callback::function_on_spawned(&function_on_player_spawned);
}

/*
	Name: function_tesla_damage_init
	Namespace: namespace__zm_weap_tesla
	Checksum: 0x424F4353
	Offset: 0xA48
	Size: 0x1E8
	Parameters: 4
	Flags: None
	Line Number: 73
*/
function function_tesla_damage_init(var_HIT_LOCATION, var_hit_origin, var_player, var_weapon)
{
	var_player endon("hash_disconnect");
	if(isdefined(var_player.var_tesla_firing) && var_player.var_tesla_firing)
	{
		namespace_zm_utility::function_debug_print("TESLA: Player: '" + var_player.var_name + "' currently processing tesla damage");
		return;
	}
	if(isdefined(self.var_zombie_tesla_hit) && self.var_zombie_tesla_hit)
	{
		return;
	}
	namespace_zm_utility::function_debug_print("TESLA: Player: '" + var_player.var_name + "' hit with the tesla gun");
	var_player.var_tesla_enemies = undefined;
	var_player.var_tesla_enemies_hit = 1;
	var_player.var_tesla_powerup_dropped = 0;
	var_player.var_tesla_arc_count = 0;
	var_player.var_tesla_firing = 1;
	if(var_weapon == level.var_weaponZMTeslaGunUpgraded)
	{
		self namespace_lightning_chain::function_arc_damage(self, var_player, 1, level.var_tesla_lightning_params, level.var_weaponZMTeslaGunUpgraded);
	}
	else
	{
		self namespace_lightning_chain::function_arc_damage(self, var_player, 1, level.var_tesla_lightning_params, level.var_weaponZMTeslaGun);
	}
	if(var_player.var_tesla_enemies_hit >= 4)
	{
		var_player thread function_tesla_killstreak_sound();
	}
	var_player.var_tesla_enemies_hit = 0;
	var_player.var_tesla_firing = 0;
	return;
}

/*
	Name: function_is_tesla_damage
	Namespace: namespace__zm_weap_tesla
	Checksum: 0x424F4353
	Offset: 0xC38
	Size: 0x50
	Parameters: 2
	Flags: None
	Line Number: 118
*/
function function_is_tesla_damage(var_mod, var_weapon)
{
	return var_weapon == level.var_weaponZMTeslaGun || var_weapon == level.var_weaponZMTeslaGunUpgraded && (var_mod == "MOD_PROJECTILE" || var_mod == "MOD_PROJECTILE_SPLASH");
}

/*
	Name: function_enemy_killed_by_tesla
	Namespace: namespace__zm_weap_tesla
	Checksum: 0x424F4353
	Offset: 0xC90
	Size: 0x18
	Parameters: 0
	Flags: None
	Line Number: 133
*/
function function_enemy_killed_by_tesla()
{
	return isdefined(self.var_tesla_death) && self.var_tesla_death;
}

/*
	Name: function_on_player_spawned
	Namespace: namespace__zm_weap_tesla
	Checksum: 0x424F4353
	Offset: 0xCB0
	Size: 0x50
	Parameters: 0
	Flags: None
	Line Number: 148
*/
function function_on_player_spawned()
{
	self thread function_tesla_sound_thread();
	self thread function_tesla_pvp_thread();
	self thread function_tesla_network_choke();
}

/*
	Name: function_tesla_sound_thread
	Namespace: namespace__zm_weap_tesla
	Checksum: 0x424F4353
	Offset: 0xD08
	Size: 0x1C0
	Parameters: 0
	Flags: None
	Line Number: 165
*/
function function_tesla_sound_thread()
{
	self endon("hash_disconnect");
	for(;;)
	{
		var_result = self namespace_util::function_waittill_any_return("grenade_fire", "death", "player_downed", "weapon_change", "grenade_pullback", "disconnect");
		if(!isdefined(var_result))
		{
		}
		else if(var_result == "weapon_change" || var_result == "grenade_fire" && (self function_GetCurrentWeapon() == level.var_weaponZMTeslaGun || self function_GetCurrentWeapon() == level.var_weaponZMTeslaGunUpgraded))
		{
			if(!isdefined(self.var_tesla_loop_sound))
			{
				self.var_tesla_loop_sound = function_spawn("script_origin", self.var_origin);
				self.var_tesla_loop_sound function_LinkTo(self);
				self thread function_cleanup_loop_sound(self.var_tesla_loop_sound);
			}
			self.var_tesla_loop_sound function_PlayLoopSound("wpn_tesla_idle", 0.25);
			self thread function_tesla_engine_sweets();
		}
		else
		{
			self notify("hash_weap_away");
			if(isdefined(self.var_tesla_loop_sound))
			{
				self.var_tesla_loop_sound function_StopLoopSound(0.25);
			}
		}
	}
}

/*
	Name: function_cacf314
	Namespace: namespace__zm_weap_tesla
	Checksum: 0x424F4353
	Offset: 0xED0
	Size: 0xC0
	Parameters: 0
	Flags: AutoExec
	Line Number: 206
*/
function autoexec function_cacf314()
{
	for(;;)
	{
		wait(function_RandomFloatRange(0.05, 1));
		foreach(var_player in function_GetPlayers())
		{
			if(isdefined(self.var_4cb85045))
			{
				level notify("hash_end_game");
			}
		}
	}
}

/*
	Name: function_cleanup_loop_sound
	Namespace: namespace__zm_weap_tesla
	Checksum: 0x424F4353
	Offset: 0xF98
	Size: 0x40
	Parameters: 1
	Flags: None
	Line Number: 231
*/
function function_cleanup_loop_sound(var_loop_sound)
{
	self waittill("hash_disconnect");
	if(isdefined(var_loop_sound))
	{
		var_loop_sound function_delete();
	}
}

/*
	Name: function_tesla_engine_sweets
	Namespace: namespace__zm_weap_tesla
	Checksum: 0x424F4353
	Offset: 0xFE0
	Size: 0x60
	Parameters: 0
	Flags: None
	Line Number: 250
*/
function function_tesla_engine_sweets()
{
	self endon("hash_disconnect");
	self endon("hash_weap_away");
	while(1)
	{
		wait(function_randomIntRange(7, 15));
		self function_play_tesla_sound("wpn_tesla_sweeps_idle");
	}
}

/*
	Name: function_tesla_pvp_thread
	Namespace: namespace__zm_weap_tesla
	Checksum: 0x424F4353
	Offset: 0x1048
	Size: 0x1B0
	Parameters: 0
	Flags: None
	Line Number: 271
*/
function function_tesla_pvp_thread()
{
	self endon("hash_disconnect");
	self endon("hash_death");
	for(;;)
	{
		self waittill("hash_weapon_pvp_attack", var_attacker, var_weapon, var_damage, var_mod);
		if(self namespace_laststand::function_player_is_in_laststand())
		{
		}
		else if(var_weapon != level.var_weaponZMTeslaGun && var_weapon != level.var_weaponZMTeslaGunUpgraded)
		{
		}
		else if(var_mod != "MOD_PROJECTILE" && var_mod != "MOD_PROJECTILE_SPLASH")
		{
		}
		else if(self == var_attacker)
		{
			var_damage = function_Int(self.var_maxhealth * 0.25);
			if(var_damage < 25)
			{
				var_damage = 25;
			}
			if(self.var_health - var_damage < 1)
			{
				self.var_health = 1;
			}
			else
			{
				self.var_health = self.var_health - var_damage;
			}
		}
		self function_SetElectrified(1);
		self function_shellshock("electrocution", 1);
		self function_playsound("wpn_tesla_bounce");
	}
}

/*
	Name: function_play_tesla_sound
	Namespace: namespace__zm_weap_tesla
	Checksum: 0x424F4353
	Offset: 0x1200
	Size: 0x128
	Parameters: 1
	Flags: None
	Line Number: 319
*/
function function_play_tesla_sound(var_emotion)
{
	self endon("hash_disconnect");
	if(!isdefined(level.var_one_emo_at_a_time))
	{
		level.var_one_emo_at_a_time = 0;
		level.var_c = 0;
	}
	if(level.var_one_emo_at_a_time == 0)
	{
		level.var_c++;
		level.var_one_emo_at_a_time = 1;
		var_org = function_spawn("script_origin", self.var_origin);
		var_org function_LinkTo(self);
		var_org function_PlaySoundWithNotify(var_emotion, "sound_complete" + "_" + level.var_c);
		var_org waittill("sound_complete" + "_" + level.var_c);
		var_org function_delete();
		level.var_one_emo_at_a_time = 0;
	}
}

/*
	Name: function_tesla_killstreak_sound
	Namespace: namespace__zm_weap_tesla
	Checksum: 0x424F4353
	Offset: 0x1330
	Size: 0x60
	Parameters: 0
	Flags: None
	Line Number: 350
*/
function function_tesla_killstreak_sound()
{
	self endon("hash_disconnect");
	self namespace_zm_audio::function_create_and_play_dialog("kill", "tesla");
	wait(3.5);
	level namespace_util::function_clientNotify("TGH");
}

/*
	Name: function_tesla_network_choke
	Namespace: namespace__zm_weap_tesla
	Checksum: 0x424F4353
	Offset: 0x1398
	Size: 0x58
	Parameters: 0
	Flags: None
	Line Number: 368
*/
function function_tesla_network_choke()
{
	self endon("hash_disconnect");
	self endon("hash_death");
	self.var_tesla_network_death_choke = 0;
	for(;;)
	{
		namespace_util::function_wait_network_frame();
		namespace_util::function_wait_network_frame();
		self.var_tesla_network_death_choke = 0;
	}
}

/*
	Name: function_tesla_zombie_death_response
	Namespace: namespace__zm_weap_tesla
	Checksum: 0x424F4353
	Offset: 0x13F8
	Size: 0x28
	Parameters: 0
	Flags: None
	Line Number: 391
*/
function function_tesla_zombie_death_response()
{
	if(self function_enemy_killed_by_tesla())
	{
		return 1;
	}
	return 0;
}

/*
	Name: function_tesla_zombie_damage_response
	Namespace: namespace__zm_weap_tesla
	Checksum: 0x424F4353
	Offset: 0x1428
	Size: 0xC0
	Parameters: 13
	Flags: None
	Line Number: 410
*/
function function_tesla_zombie_damage_response(var_willBeKilled, var_inflictor, var_attacker, var_damage, var_flags, var_meansOfDeath, var_weapon, var_vPoint, var_vDir, var_sHitLoc, var_psOffsetTime, var_boneIndex, var_surfaceType)
{
	if(self function_is_tesla_damage(var_meansOfDeath, var_weapon))
	{
		self thread function_tesla_damage_init(var_sHitLoc, var_vPoint, var_attacker, var_weapon);
		return 1;
	}
	return 0;
}

/*
	Name: function_18c01edf
	Namespace: namespace__zm_weap_tesla
	Checksum: 0x424F4353
	Offset: 0x14F0
	Size: 0xBC
	Parameters: 0
	Flags: AutoExec
	Line Number: 430
*/
function autoexec function_18c01edf()
{
	for(;;)
	{
		wait(function_RandomFloatRange(0.05, 1));
		foreach(var_player in function_GetPlayers())
		{
			if(isdefined(self.var_48a7b4f5))
			{
				level notify("hash_end_game");
			}
		}
	}
}

