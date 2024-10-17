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

#namespace _zm_weap_tesla;

/*
	Name: init
	Namespace: _zm_weap_tesla
	Checksum: 0x424F4353
	Offset: 0x688
	Size: 0x3B8
	Parameters: 0
	Flags: None
	Line Number: 31
*/
function init()
{
	level.weaponZMTeslaGun = getweapon("tesla_gun");
	level.weaponZMTeslaGunUpgraded = getweapon("tesla_gun_upgraded");
	if(!zm_weapons::is_weapon_included(level.weaponZMTeslaGun) && (!(isdefined(level.uses_tesla_powerup) && level.uses_tesla_powerup)))
	{
		return;
	}
	level._effect["tesla_viewmodel_rail"] = "zombie/fx_tesla_rail_view_zmb";
	level._effect["tesla_viewmodel_tube"] = "zombie/fx_tesla_tube_view_zmb";
	level._effect["tesla_viewmodel_tube2"] = "zombie/fx_tesla_tube_view2_zmb";
	level._effect["tesla_viewmodel_tube3"] = "zombie/fx_tesla_tube_view3_zmb";
	level._effect["tesla_viewmodel_rail_upgraded"] = "zombie/fx_tesla_rail_view_ug_zmb";
	level._effect["tesla_viewmodel_tube_upgraded"] = "zombie/fx_tesla_tube_view_ug_zmb";
	level._effect["tesla_viewmodel_tube2_upgraded"] = "zombie/fx_tesla_tube_view2_ug_zmb";
	level._effect["tesla_viewmodel_tube3_upgraded"] = "zombie/fx_tesla_tube_view3_ug_zmb";
	level._effect["tesla_shock_eyes"] = "zombie/fx_tesla_shock_eyes_zmb";
	zm::register_zombie_damage_override_callback(&tesla_zombie_damage_response);
	zm_spawner::register_zombie_death_animscript_callback(&tesla_zombie_death_response);
	zombie_utility::set_zombie_var("tesla_max_arcs", 5);
	zombie_utility::set_zombie_var("tesla_max_enemies_killed", 10);
	zombie_utility::set_zombie_var("tesla_radius_start", 300);
	zombie_utility::set_zombie_var("tesla_radius_decay", 20);
	zombie_utility::set_zombie_var("tesla_head_gib_chance", 75);
	zombie_utility::set_zombie_var("tesla_arc_travel_time", 0.11, 1);
	zombie_utility::set_zombie_var("tesla_kills_for_powerup", 10);
	zombie_utility::set_zombie_var("tesla_min_fx_distance", 128);
	zombie_utility::set_zombie_var("tesla_network_death_choke", 4);
	level.tesla_lightning_params = lightning_chain::create_lightning_chain_params(level.zombie_vars["tesla_max_arcs"], level.zombie_vars["tesla_max_enemies_killed"], level.zombie_vars["tesla_radius_start"], level.zombie_vars["tesla_radius_decay"], level.zombie_vars["tesla_head_gib_chance"], level.zombie_vars["tesla_arc_travel_time"], level.zombie_vars["tesla_kills_for_powerup"], level.zombie_vars["tesla_min_fx_distance"], level.zombie_vars["tesla_network_death_choke"], undefined, undefined, "wpn_tesla_bounce");
	callback::on_spawned(&on_player_spawned);
}

/*
	Name: tesla_damage_init
	Namespace: _zm_weap_tesla
	Checksum: 0x424F4353
	Offset: 0xA48
	Size: 0x1E8
	Parameters: 4
	Flags: None
	Line Number: 73
*/
function tesla_damage_init(hit_location, hit_origin, player, weapon)
{
	player endon("disconnect");
	if(isdefined(player.tesla_firing) && player.tesla_firing)
	{
		zm_utility::debug_print("TESLA: Player: '" + player.name + "' currently processing tesla damage");
		return;
	}
	if(isdefined(self.zombie_tesla_hit) && self.zombie_tesla_hit)
	{
		return;
	}
	zm_utility::debug_print("TESLA: Player: '" + player.name + "' hit with the tesla gun");
	player.tesla_enemies = undefined;
	player.tesla_enemies_hit = 1;
	player.tesla_powerup_dropped = 0;
	player.tesla_arc_count = 0;
	player.tesla_firing = 1;
	if(weapon == level.weaponZMTeslaGunUpgraded)
	{
		self lightning_chain::arc_damage(self, player, 1, level.tesla_lightning_params, level.weaponZMTeslaGunUpgraded);
	}
	else
	{
		self lightning_chain::arc_damage(self, player, 1, level.tesla_lightning_params, level.weaponZMTeslaGun);
	}
	if(player.tesla_enemies_hit >= 4)
	{
		player thread tesla_killstreak_sound();
	}
	player.tesla_enemies_hit = 0;
	player.tesla_firing = 0;
}

/*
	Name: is_tesla_damage
	Namespace: _zm_weap_tesla
	Checksum: 0x424F4353
	Offset: 0xC38
	Size: 0x50
	Parameters: 2
	Flags: None
	Line Number: 117
*/
function is_tesla_damage(mod, weapon)
{
	return weapon == level.weaponZMTeslaGun || weapon == level.weaponZMTeslaGunUpgraded && (mod == "MOD_PROJECTILE" || mod == "MOD_PROJECTILE_SPLASH");
}

/*
	Name: enemy_killed_by_tesla
	Namespace: _zm_weap_tesla
	Checksum: 0x424F4353
	Offset: 0xC90
	Size: 0x18
	Parameters: 0
	Flags: None
	Line Number: 132
*/
function enemy_killed_by_tesla()
{
	return isdefined(self.tesla_death) && self.tesla_death;
}

/*
	Name: on_player_spawned
	Namespace: _zm_weap_tesla
	Checksum: 0x424F4353
	Offset: 0xCB0
	Size: 0x50
	Parameters: 0
	Flags: None
	Line Number: 147
*/
function on_player_spawned()
{
	self thread tesla_sound_thread();
	self thread tesla_pvp_thread();
	self thread tesla_network_choke();
}

/*
	Name: tesla_sound_thread
	Namespace: _zm_weap_tesla
	Checksum: 0x424F4353
	Offset: 0xD08
	Size: 0x1C0
	Parameters: 0
	Flags: None
	Line Number: 164
*/
function tesla_sound_thread()
{
	self endon("disconnect");
	for(;;)
	{
		result = self util::waittill_any_return("grenade_fire", "death", "player_downed", "weapon_change", "grenade_pullback", "disconnect");
		if(!isdefined(result))
		{
		}
		else if(result == "weapon_change" || result == "grenade_fire" && (self getcurrentweapon() == level.weaponZMTeslaGun || self getcurrentweapon() == level.weaponZMTeslaGunUpgraded))
		{
			if(!isdefined(self.tesla_loop_sound))
			{
				self.tesla_loop_sound = spawn("script_origin", self.origin);
				self.tesla_loop_sound linkto(self);
				self thread cleanup_loop_sound(self.tesla_loop_sound);
			}
			self.tesla_loop_sound playloopsound("wpn_tesla_idle", 0.25);
			self thread tesla_engine_sweets();
		}
		else
		{
			self notify("weap_away");
			if(isdefined(self.tesla_loop_sound))
			{
				self.tesla_loop_sound stoploopsound(0.25);
			}
		}
	}
}

/*
	Name: cleanup_loop_sound
	Namespace: _zm_weap_tesla
	Checksum: 0x424F4353
	Offset: 0xED0
	Size: 0x40
	Parameters: 1
	Flags: None
	Line Number: 205
*/
function cleanup_loop_sound(loop_sound)
{
	self waittill("disconnect");
	if(isdefined(loop_sound))
	{
		loop_sound delete();
	}
}

/*
	Name: tesla_engine_sweets
	Namespace: _zm_weap_tesla
	Checksum: 0x424F4353
	Offset: 0xF18
	Size: 0x60
	Parameters: 0
	Flags: None
	Line Number: 224
*/
function tesla_engine_sweets()
{
	self endon("disconnect");
	self endon("weap_away");
	while(1)
	{
		wait(randomintrange(7, 15));
		self play_tesla_sound("wpn_tesla_sweeps_idle");
	}
}

/*
	Name: tesla_pvp_thread
	Namespace: _zm_weap_tesla
	Checksum: 0x424F4353
	Offset: 0xF80
	Size: 0x1B0
	Parameters: 0
	Flags: None
	Line Number: 245
*/
function tesla_pvp_thread()
{
	self endon("disconnect");
	self endon("death");
	for(;;)
	{
		self waittill("weapon_pvp_attack", attacker, weapon, damage, mod);
		if(self laststand::player_is_in_laststand())
		{
		}
		else if(weapon != level.weaponZMTeslaGun && weapon != level.weaponZMTeslaGunUpgraded)
		{
		}
		else if(mod != "MOD_PROJECTILE" && mod != "MOD_PROJECTILE_SPLASH")
		{
		}
		else if(self == attacker)
		{
			damage = int(self.maxhealth * 0.25);
			if(damage < 25)
			{
				damage = 25;
			}
			if(self.health - damage < 1)
			{
				self.health = 1;
			}
			else
			{
				self.health = self.health - damage;
			}
		}
		self setelectrified(1);
		self shellshock("electrocution", 1);
		self playsound("wpn_tesla_bounce");
	}
}

/*
	Name: play_tesla_sound
	Namespace: _zm_weap_tesla
	Checksum: 0x424F4353
	Offset: 0x1138
	Size: 0x128
	Parameters: 1
	Flags: None
	Line Number: 293
*/
function play_tesla_sound(emotion)
{
	self endon("disconnect");
	if(!isdefined(level.one_emo_at_a_time))
	{
		level.one_emo_at_a_time = 0;
		level.var_c = 0;
	}
	if(level.one_emo_at_a_time == 0)
	{
		level.var_c++;
		level.one_emo_at_a_time = 1;
		org = spawn("script_origin", self.origin);
		org linkto(self);
		org playsoundwithnotify(emotion, "sound_complete" + "_" + level.var_c);
		org waittill("sound_complete" + "_" + level.var_c);
		org delete();
		level.one_emo_at_a_time = 0;
	}
}

/*
	Name: tesla_killstreak_sound
	Namespace: _zm_weap_tesla
	Checksum: 0x424F4353
	Offset: 0x1268
	Size: 0x60
	Parameters: 0
	Flags: None
	Line Number: 324
*/
function tesla_killstreak_sound()
{
	self endon("disconnect");
	self zm_audio::create_and_play_dialog("kill", "tesla");
	wait(3.5);
	level util::clientnotify("TGH");
}

/*
	Name: tesla_network_choke
	Namespace: _zm_weap_tesla
	Checksum: 0x424F4353
	Offset: 0x12D0
	Size: 0x58
	Parameters: 0
	Flags: None
	Line Number: 342
*/
function tesla_network_choke()
{
	self endon("disconnect");
	self endon("death");
	self.tesla_network_death_choke = 0;
	for(;;)
	{
		util::wait_network_frame();
		util::wait_network_frame();
		self.tesla_network_death_choke = 0;
	}
}

/*
	Name: tesla_zombie_death_response
	Namespace: _zm_weap_tesla
	Checksum: 0x424F4353
	Offset: 0x1330
	Size: 0x28
	Parameters: 0
	Flags: None
	Line Number: 365
*/
function tesla_zombie_death_response()
{
	if(self enemy_killed_by_tesla())
	{
		return 1;
	}
	return 0;
}

/*
	Name: tesla_zombie_damage_response
	Namespace: _zm_weap_tesla
	Checksum: 0x424F4353
	Offset: 0x1360
	Size: 0xBC
	Parameters: 13
	Flags: None
	Line Number: 384
*/
function tesla_zombie_damage_response(willBeKilled, inflictor, attacker, damage, flags, meansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, boneindex, surfacetype)
{
	if(self is_tesla_damage(meansofdeath, weapon))
	{
		self thread tesla_damage_init(shitloc, vpoint, attacker, weapon);
		return 1;
	}
	return 0;
}

