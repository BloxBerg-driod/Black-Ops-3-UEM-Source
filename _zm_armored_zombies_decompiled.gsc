#include scripts\codescripts\struct;
#include scripts\shared\_burnplayer;
#include scripts\shared\ai\archetype_utility;
#include scripts\shared\ai\systems\gib;
#include scripts\shared\ai\zombie_death;
#include scripts\shared\ai\zombie_shared;
#include scripts\shared\ai\zombie_utility;
#include scripts\shared\animation_shared;
#include scripts\shared\array_shared;
#include scripts\shared\callbacks_shared;
#include scripts\shared\clientfield_shared;
#include scripts\shared\demo_shared;
#include scripts\shared\exploder_shared;
#include scripts\shared\flag_shared;
#include scripts\shared\hud_shared;
#include scripts\shared\hud_util_shared;
#include scripts\shared\laststand_shared;
#include scripts\shared\lui_shared;
#include scripts\shared\math_shared;
#include scripts\shared\scene_shared;
#include scripts\shared\spawner_shared;
#include scripts\shared\system_shared;
#include scripts\shared\util_shared;
#include scripts\sphynx\leveling\_zm_sphynx_leveling;
#include scripts\zm\_util;
#include scripts\zm\_zm;
#include scripts\zm\_zm_audio;
#include scripts\zm\_zm_equipment;
#include scripts\zm\_zm_lightning_chain;
#include scripts\zm\_zm_magicbox;
#include scripts\zm\_zm_net;
#include scripts\zm\_zm_perks;
#include scripts\zm\_zm_powerups;
#include scripts\zm\_zm_score;
#include scripts\zm\_zm_spawner;
#include scripts\zm\_zm_stats;
#include scripts\zm\_zm_unitrigger;
#include scripts\zm\_zm_utility;
#include scripts\zm\_zm_weapons;
#include scripts\zm\_zm_zonemgr;

#namespace namespace_e483ded;

/*
	Name: __init__sytem__
	Namespace: namespace_e483ded
	Checksum: 0x424F4353
	Offset: 0xDD8
	Size: 0x38
	Parameters: 0
	Flags: AutoExec
	Line Number: 53
*/
function autoexec __init__sytem__()
{
	system::register("zm_armored_zombie", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: namespace_e483ded
	Checksum: 0x424F4353
	Offset: 0xE18
	Size: 0xE0
	Parameters: 0
	Flags: None
	Line Number: 68
*/
function __init__()
{
	spawner::add_archetype_spawn_function("zombie", &function_bd226691);
	level.var_317e7556 = 0;
	level.var_c806dee2 = 0;
	level thread function_7e77ed86();
	level thread function_87a20e06();
	wait(0.05);
	level flag::wait_till("allow_elemental_zombies");
	level.var_1a450322 = 0;
	level.var_f93c0c9e = 0;
	spawner::add_archetype_spawn_function("zombie", &function_e0a13953);
}

/*
	Name: function_87a20e06
	Namespace: namespace_e483ded
	Checksum: 0x424F4353
	Offset: 0xF00
	Size: 0x40
	Parameters: 0
	Flags: None
	Line Number: 92
*/
function function_87a20e06()
{
	wait(0.05);
	level flag::wait_till("debug_dev");
	thread function_232fd7a0();
}

/*
	Name: function_7e77ed86
	Namespace: namespace_e483ded
	Checksum: 0x424F4353
	Offset: 0xF48
	Size: 0x58
	Parameters: 0
	Flags: None
	Line Number: 109
*/
function function_7e77ed86()
{
	while(isdefined(level.var_f93c0c9e) && level.var_f93c0c9e > 0)
	{
		level.var_f93c0c9e--;
		if(isdefined(level.var_c806dee2) && level.var_c806dee2 > 0)
		{
			level.var_c806dee2--;
		}
		wait(1);
	}
}

/*
	Name: function_e0a13953
	Namespace: namespace_e483ded
	Checksum: 0x424F4353
	Offset: 0xFA8
	Size: 0x98
	Parameters: 0
	Flags: Private
	Line Number: 132
*/
function private function_e0a13953()
{
	if(level.round_number >= 12 && randomintrange(1, 100) < 10)
	{
		if(level.var_1a450322 <= 3 && level.var_f93c0c9e == 0)
		{
			level.var_1a450322++;
			level.var_f93c0c9e = 30;
			self EnableLinkTo();
			self thread function_e4e397d9();
			return;
		}
	}
	ERROR: Exception occured: Stack empty.
}

/*
	Name: function_e4e397d9
	Namespace: namespace_e483ded
	Checksum: 0x424F4353
	Offset: 0x1048
	Size: 0x110
	Parameters: 1
	Flags: None
	Line Number: 158
*/
function function_e4e397d9(var_4df9307b)
{
	self.Elemental = 1;
	if(isdefined(var_4df9307b))
	{
		self.var_4df9307b = var_4df9307b;
	}
	else
	{
		self.var_4df9307b = self function_86821e50();
	}
	self.team = level.zombie_team;
	self.health = level.zombie_health * 3;
	if(isdefined(self.script_string) && self.script_string == "riser")
	{
		while(isdefined(self.in_the_ground) && self.in_the_ground)
		{
			wait(0.05);
		}
	}
	switch(self.var_4df9307b)
	{
		case "electricity":
		{
			self thread function_1514ccd7();
			break;
		}
		case "fire":
		{
			self thread function_32d26a34();
			break;
		}
	}
}

/*
	Name: function_1514ccd7
	Namespace: namespace_e483ded
	Checksum: 0x424F4353
	Offset: 0x1160
	Size: 0x438
	Parameters: 0
	Flags: None
	Line Number: 203
*/
function function_1514ccd7()
{
	if(isalive(self))
	{
		var_44c49629 = util::spawn_model("tag_origin", self.origin + VectorScale((0, 0, 1), 42));
		var_44c49629 = playfxontag("electric/fx_ability_elec_surge_short_robot_optim", var_44c49629, "tag_origin");
		var_44c49629 linkto(self);
		self waittill("death", attacker, damageType);
		level.var_1a450322--;
		var_55d9ee3b = util::spawn_model("tag_origin", self.origin + VectorScale((0, 0, 1), 55));
		var_55d9ee3b = playfxontag("explosions/fx_exp_grenade_emp", self, "tag_origin");
		zombies = array::get_all_closest(self.origin, getaiteamarray(level.zombie_team), undefined, undefined, 240);
		for(i = 0; i < 6; i++)
		{
			if(!isdefined(zombies[i]) || !isalive(zombies[i]))
			{
				continue;
			}
			dist_sq = distancesquared(self.origin, zombies[i].origin);
			if(dist_sq < 10000)
			{
				zombies[i] dodamage(level.zombie_health + 666, self.origin);
				continue;
			}
			if(dist_sq > 10000)
			{
				continue;
			}
			if(0 == zombies[i] damageconetrace(self.origin, self))
			{
				continue;
			}
			zombies[i] dodamage(level.zombie_health + 666, self.origin);
		}
		players = array::get_all_closest(self.origin, getplayers(), undefined, undefined, 280);
		foreach(player in getplayers())
		{
			if(distance(var_44c49629.origin, player.origin) < 280)
			{
				player thread damage_player();
			}
		}
		wait(0.8);
		if(isdefined(var_44c49629))
		{
			var_44c49629 delete();
		}
		if(isdefined(var_55d9ee3b))
		{
			var_55d9ee3b delete();
		}
		attacker zm_score::add_to_player_score(200);
		return;
	}
}

/*
	Name: function_32d26a34
	Namespace: namespace_e483ded
	Checksum: 0x424F4353
	Offset: 0x15A0
	Size: 0x430
	Parameters: 0
	Flags: None
	Line Number: 269
*/
function function_32d26a34()
{
	if(isalive(self))
	{
		var_a78ce442 = util::spawn_model("tag_origin", self.origin + VectorScale((0, 0, 1), 42));
		var_a78ce442 = playfxontag("fire/fx_fire_ai_human_torso_loop_optim", var_a78ce442, "tag_origin");
		var_a78ce442 linkto(self);
		self waittill("death", attacker, damageType);
		level.var_1a450322--;
		var_7f127a14 = util::spawn_model("tag_origin", self.origin + VectorScale((0, 0, 1), 55));
		var_7f127a14 = playfxontag("dlc5/temple/fx_ztem_napalm_zombie_exp", self, "tag_origin");
		zombies = array::get_all_closest(self.origin, getaiteamarray(level.zombie_team), undefined, undefined, 250);
		for(i = 0; i < 12; i++)
		{
			if(!isdefined(zombies[i]) || !isalive(zombies[i]))
			{
				continue;
			}
			dist_sq = distancesquared(self.origin, zombies[i].origin);
			if(dist_sq > 30625)
			{
				continue;
			}
			zombies[i] dodamage(level.zombie_health / 5, self.origin);
		}
		players = array::get_all_closest(self.origin, getplayers(), undefined, undefined, 250);
		foreach(player in getplayers())
		{
			if(distance(self.origin, player.origin) < 100)
			{
				player thread function_1e61c259();
			}
		}
		wait(0.5);
		var_817b4cfc = util::spawn_model("tag_origin", self.origin);
		var_817b4cfc = playfxontag("_sphynx/_zm_fire_ground", var_817b4cfc, "tag_origin");
		var_817b4cfc thread function_701a2943();
		wait(0.8);
		if(isdefined(var_a78ce442))
		{
			var_a78ce442 delete();
		}
		if(isdefined(var_7f127a14))
		{
			var_7f127a14 delete();
		}
		attacker zm_score::add_to_player_score(200);
	}
}

/*
	Name: function_701a2943
	Namespace: namespace_e483ded
	Checksum: 0x424F4353
	Offset: 0x19D8
	Size: 0x218
	Parameters: 0
	Flags: None
	Line Number: 329
*/
function function_701a2943()
{
	self thread function_c629df9b();
	self.trig = spawn("trigger_radius", self.origin, 0, 128, 64);
	while(isdefined(self))
	{
		foreach(player in getplayers())
		{
			if(player istouching(self.trig))
			{
				iprintlnbold("Triggered fire [Player]");
				player thread function_55773d55();
			}
		}
		zombies = array::get_all_closest(self.trig.origin, getaiteamarray(level.zombie_team), undefined, undefined, 100);
		foreach(zombie in zombies)
		{
			iprintlnbold("Triggered fire [Zombie]");
			zombie thread function_55773d55();
		}
		wait(1);
	}
	return;
	ERROR: Exception occured: Stack empty.
}

/*
	Name: function_c629df9b
	Namespace: namespace_e483ded
	Checksum: 0x424F4353
	Offset: 0x1BF8
	Size: 0x50
	Parameters: 0
	Flags: None
	Line Number: 365
*/
function function_c629df9b()
{
	wait(14);
	if(isdefined(self.trig))
	{
		self.trig delete();
	}
	self delete();
}

/*
	Name: function_55773d55
	Namespace: namespace_e483ded
	Checksum: 0x424F4353
	Offset: 0x1C50
	Size: 0x1C0
	Parameters: 1
	Flags: None
	Line Number: 385
*/
function function_55773d55(trig)
{
	self endon("zombified");
	self endon("death");
	self endon("disconnect");
	if(isdefined(self.is_zombie) && self.is_zombie)
	{
		self endon("death");
		zombie_dmg = 25;
		if(!isdefined(self.is_on_fire) || !self.is_on_fire)
		{
			if(level.burning_zombies.size < 6 && zombie_dmg >= 25)
			{
				level.burning_zombies[level.burning_zombies.size] = self;
				self playsound("zmb_ignite");
				self thread zombie_burning_fx();
				self thread zombie_burning_watch();
				self thread zombie_burning_dmg();
				self thread zombie_exploding_death(zombie_dmg, self);
				wait(randomfloat(1.25));
			}
		}
		if(self.health > level.zombie_health / 2 && self.health > zombie_dmg)
		{
			self dodamage(zombie_dmg, self.origin, self);
			continue;
		}
	}
	else
	{
		self thread function_1e61c259();
		return;
	}
	waittillframeend;
}

/*
	Name: function_1e61c259
	Namespace: namespace_e483ded
	Checksum: 0x424F4353
	Offset: 0x1E18
	Size: 0x1A0
	Parameters: 0
	Flags: None
	Line Number: 431
*/
function function_1e61c259()
{
	max_dmg = 15;
	min_dmg = 5;
	burn_time = 1;
	self thread player_stop_burning();
	if(!isdefined(self.is_burning) && zm_utility::is_player_valid(self))
	{
		self.is_burning = 1;
		self thread function_5c5faa65();
		self notify("burned");
		self thread player_burning_fx();
		if(!self hasperk("specialty_armorvest") || self.health - 100 < 1)
		{
			radiusdamage(self.origin, 10, max_dmg, min_dmg);
			wait(0.5);
			self.is_burning = undefined;
		}
		else if(self hasperk("specialty_armorvest"))
		{
			self dodamage(15, self.origin);
		}
		else
		{
			self dodamage(1, self.origin);
		}
		wait(0.5);
		self.is_burning = undefined;
	}
}

/*
	Name: function_5c5faa65
	Namespace: namespace_e483ded
	Checksum: 0x424F4353
	Offset: 0x1FC0
	Size: 0x88
	Parameters: 0
	Flags: None
	Line Number: 472
*/
function function_5c5faa65()
{
	self clientfield::set("burn", 1);
	self util::waittill_any_timeout(level.zm_transit_burn_max_duration, "death", "disconnect", "bled_out", "player_stop_burning");
	self clientfield::set("burn", 0);
}

/*
	Name: player_stop_burning
	Namespace: namespace_e483ded
	Checksum: 0x424F4353
	Offset: 0x2050
	Size: 0x68
	Parameters: 0
	Flags: None
	Line Number: 489
*/
function player_stop_burning()
{
	self notify("player_stop_burning");
	self endon("player_stop_burning");
	self endon("death_or_disconnect");
	self waittill("zombified");
	self notify("stop_flame_damage");
	self clientfield::set("burn", 0);
}

/*
	Name: zombie_burning_fx
	Namespace: namespace_e483ded
	Checksum: 0x424F4353
	Offset: 0x20C0
	Size: 0x270
	Parameters: 0
	Flags: None
	Line Number: 509
*/
function zombie_burning_fx()
{
	self endon("death");
	if(isdefined(self.is_on_fire) && self.is_on_fire)
	{
		return;
	}
	self.is_on_fire = 1;
	self thread zombie_death::on_fire_timeout();
	if(isdefined(level._effect) && isdefined(level._effect["lava_burning"]))
	{
		if(!self.isdog)
		{
			playfxontag(level._effect["lava_burning"], self, "J_SpineLower");
			self thread zombie_burning_audio();
		}
	}
	if(isdefined(level._effect) && isdefined(level._effect["character_fire_death_sm"]))
	{
		wait(1);
		if(randomint(2) > 1)
		{
			tagArray = [];
			tagArray[0] = "J_Elbow_LE";
			tagArray[1] = "J_Elbow_RI";
			tagArray[2] = "J_Knee_RI";
			tagArray[3] = "J_Knee_LE";
			tagArray = array::randomize(tagArray);
			playfxontag(level._effect["character_fire_death_sm"], self, tagArray[0]);
		}
		else
		{
			tagArray[0] = "J_Wrist_RI";
			tagArray[1] = "J_Wrist_LE";
			if(!isdefined(self.a.gib_ref) || self.a.gib_ref != "no_legs")
			{
				tagArray[2] = "J_Ankle_RI";
				tagArray[3] = "J_Ankle_LE";
			}
			tagArray = array::randomize(tagArray);
			playfxontag(level._effect["character_fire_death_sm"], self, tagArray[0]);
		}
	}
}

/*
	Name: zombie_burning_audio
	Namespace: namespace_e483ded
	Checksum: 0x424F4353
	Offset: 0x2338
	Size: 0x90
	Parameters: 0
	Flags: None
	Line Number: 564
*/
function zombie_burning_audio()
{
	self playloopsound("zmb_fire_loop");
	self util::waittill_either("stop_flame_damage", "death");
	if(isdefined(self) && isalive(self))
	{
		self stoploopsound(0.25);
	}
}

/*
	Name: player_burning_fx
	Namespace: namespace_e483ded
	Checksum: 0x424F4353
	Offset: 0x23D0
	Size: 0xC8
	Parameters: 0
	Flags: None
	Line Number: 584
*/
function player_burning_fx()
{
	self endon("death");
	if(isdefined(self.is_on_fire) && self.is_on_fire)
	{
		return;
	}
	if(!(isdefined(self.no_burning_sfx) && self.no_burning_sfx))
	{
		self thread player_burning_audio();
	}
	self.is_on_fire = 1;
	self thread zombie_death::on_fire_timeout();
	if(isdefined(level._effect) && isdefined(level._effect["character_fire_death_sm"]))
	{
		playfxontag(level._effect["character_fire_death_sm"], self, "J_SpineLower");
		return;
	}
	ERROR: Exception occured: Stack empty.
}

/*
	Name: player_burning_audio
	Namespace: namespace_e483ded
	Checksum: 0x424F4353
	Offset: 0x24A0
	Size: 0xD0
	Parameters: 0
	Flags: None
	Line Number: 615
*/
function player_burning_audio()
{
	fire_ent = spawn("script_model", self.origin);
	util::wait_network_frame();
	fire_ent linkto(self);
	fire_ent playloopsound("evt_plr_fire_loop");
	self util::waittill_any("stop_flame_damage", "stop_flame_sounds", "death", "disconnect");
	fire_ent delete();
	return;
	ERROR: Exception occured: Stack empty.
}

/*
	Name: zombie_burning_watch
	Namespace: namespace_e483ded
	Checksum: 0x424F4353
	Offset: 0x2578
	Size: 0x48
	Parameters: 0
	Flags: None
	Line Number: 637
*/
function zombie_burning_watch()
{
	self util::waittill_any("stop_flame_damage", "death");
	arrayremovevalue(level.burning_zombies, self);
}

/*
	Name: zombie_exploding_death
	Namespace: namespace_e483ded
	Checksum: 0x424F4353
	Offset: 0x25C8
	Size: 0x1E8
	Parameters: 2
	Flags: None
	Line Number: 653
*/
function zombie_exploding_death(zombie_dmg, trap)
{
	self endon("stop_flame_damage");
	if(isdefined(self.isdog) && self.isdog && isdefined(self.a.nodeath))
	{
		return;
	}
	while(isdefined(self) && self.health >= zombie_dmg && (isdefined(self.is_on_fire) && self.is_on_fire))
	{
		wait(0.5);
	}
	if(!isdefined(self) || (!isdefined(self.is_on_fire) && self.is_on_fire) || (isdefined(self.damageWeapon) && (self.damageWeapon.name == "t6_tazer_knuckles" || self.damageWeapon.name == "t6_jetgun")) || (isdefined(self.knuckles_extinguish_flames) && self.knuckles_extinguish_flames))
	{
		return;
	}
	self thread zombie_utility::zombie_gut_explosion();
	self playsound("wpn_grenade_explode_close");
	self radiusdamage(self.origin, 128, 30, 15, undefined, "MOD_EXPLOSIVE");
	self ghost();
	if(isdefined(self.isdog) && self.isdog)
	{
		self hide();
	}
	else
	{
		self util::delay(1, &delete);
	}
}

/*
	Name: zombie_burning_dmg
	Namespace: namespace_e483ded
	Checksum: 0x424F4353
	Offset: 0x27B8
	Size: 0x170
	Parameters: 0
	Flags: None
	Line Number: 692
*/
function zombie_burning_dmg()
{
	self endon("death");
	damageradius = 25;
	damage = 2;
	while(isdefined(self.is_on_fire) && self.is_on_fire)
	{
		eyeOrigin = self geteye();
		players = getplayers();
		for(i = 0; i < players.size; i++)
		{
			if(zm_utility::is_player_valid(players[i]))
			{
				playerEye = players[i] geteye();
				if(distancesquared(eyeOrigin, playerEye) < damageradius * damageradius)
				{
					players[i] dodamage(damage, self.origin, self);
					players[i] notify("burned");
				}
			}
		}
		wait(1);
	}
}

/*
	Name: damage_player
	Namespace: namespace_e483ded
	Checksum: 0x424F4353
	Offset: 0x2930
	Size: 0xF8
	Parameters: 0
	Flags: None
	Line Number: 727
*/
function damage_player()
{
	earthquake(0.7, 1, self.origin, 150);
	self dodamage(20, self.origin);
	self shellshock("shock_field", 1);
	if(isdefined(self clientfield::get("shock_field")))
	{
		self clientfield::set("shock_field", 1);
	}
	wait(1);
	if(isdefined(self clientfield::get("shock_field")))
	{
		self clientfield::set("shock_field", 0);
	}
}

/*
	Name: function_c01d2cb2
	Namespace: namespace_e483ded
	Checksum: 0x424F4353
	Offset: 0x2A30
	Size: 0x100
	Parameters: 12
	Flags: None
	Line Number: 753
*/
function function_c01d2cb2(inflictor, attacker, damage, dflags, mod, weapon, point, dir, hitloc, offsettime, boneindex, modelindex)
{
	if(isdefined(attacker) && isplayer(attacker) && isalive(attacker) && (level.zombie_vars[attacker.team]["zombie_insta_kill"] || (isdefined(attacker.personal_instakill) && attacker.personal_instakill)))
	{
		damage = damage * 2;
	}
	return damage;
}

/*
	Name: function_86821e50
	Namespace: namespace_e483ded
	Checksum: 0x424F4353
	Offset: 0x2B38
	Size: 0x10
	Parameters: 0
	Flags: None
	Line Number: 772
*/
function function_86821e50()
{
	return "electricity";
}

/*
	Name: function_33a6158a
	Namespace: namespace_e483ded
	Checksum: 0x424F4353
	Offset: 0x2B50
	Size: 0x2D0
	Parameters: 0
	Flags: Private
	Line Number: 787
*/
function private function_33a6158a()
{
	if(randomintrange(1, 100) < 60 && !level flag::get("speedrun_enabled"))
	{
		if(level.var_e5ed6b73 <= 1 && level.var_8aa0ec6f == 0)
		{
			self.no_powerups = 1;
			level.var_8aa0ec6f = 40;
			self attach("_zmu_christmas_hat", "j_head");
			level.var_e5ed6b73++;
			if(isalive(self))
			{
				self waittill("death", attacker, damageType);
				var_162e1c19 = util::spawn_model("tag_origin", self.origin + VectorScale((0, 0, 1), 35), self.angles);
				playable_area = getentarray("player_volume", "script_noteworthy");
				valid_drop = 0;
				for(i = 0; i < playable_area.size; i++)
				{
					if(var_162e1c19 istouching(playable_area[i]))
					{
						valid_drop = 1;
						break;
					}
				}
				if(isdefined(valid_drop) && valid_drop)
				{
					var_162e1c19 setmodel("zmu_christmas_present");
					final_pos = zm_weapons::function_a2b97522(self, 50, var_162e1c19, 1);
					var_8f7442a5 = util::ground_position(final_pos, 500, 25);
					var_162e1c19 zm_utility::fake_physicslaunch(var_8f7442a5, randomintrange(50, 100));
					var_162e1c19 thread function_d5f8a2b2();
				}
				else
				{
					var_162e1c19 delete();
				}
				level.var_e5ed6b73--;
			}
		}
	}
}

/*
	Name: function_d5f8a2b2
	Namespace: namespace_e483ded
	Checksum: 0x424F4353
	Offset: 0x2E28
	Size: 0x2C8
	Parameters: 0
	Flags: None
	Line Number: 839
*/
function function_d5f8a2b2()
{
	self endon("powerup_grabbed");
	self endon("powerup_timedout");
	self thread function_2aa7612d(20);
	self thread function_8fedabe9();
	self thread function_e1859039();
	self EnableLinkTo();
	self.var_1785a8a8 = util::spawn_model("tag_origin", self.origin, self.angles);
	self.var_1785a8a8 = playfxontag("_sphynx/_zm_christmas_powerup", self.var_1785a8a8, "tag_origin");
	self.var_1785a8a8 linkto(self);
	self.trigger_use = spawn("trigger_radius_use", self.origin, 0, 50, 50);
	self.trigger_use triggerignoreteam();
	self.trigger_use setvisibletoall();
	self.trigger_use setteamfortrigger("none");
	self.trigger_use usetriggerrequirelookat();
	self.trigger_use setcursorhint("HINT_NOICON");
	self.trigger_use sethintstring(&"ZM_MINECRAFT_CHRISTMAS_PRESENT_PICKUP");
	while(isdefined(self))
	{
		self.trigger_use waittill("trigger", player);
		self thread function_916e719a(player);
		if(player.pers["cc_christmaspresents"] < 151)
		{
			player.pers["cc_christmaspresents"]++;
			if(player.pers["cc_christmaspresents"] >= 150)
			{
				player.pers["cc_christmaspresents"] = 150;
				player.pers["christmas_hat"] = 1;
				player thread namespace_97ac1184::function_1da3a55e();
			}
		}
		self notify("hash_690bf263");
	}
	return;
	ERROR: Exception occured: Stack empty.
}

/*
	Name: function_bd226691
	Namespace: namespace_e483ded
	Checksum: 0x424F4353
	Offset: 0x30F8
	Size: 0x2E8
	Parameters: 0
	Flags: Private
	Line Number: 887
*/
function private function_bd226691()
{
	if(randomintrange(1, 100) < 7)
	{
		if(level.var_317e7556 <= 1 && level.var_c806dee2 == 0 && !level flag::get("speedrun_enabled"))
		{
			self.no_powerups = 1;
			level.var_c806dee2 = 40;
			self attach("_zmu_halloween_hat", "j_head");
			level.var_317e7556++;
			if(isalive(self))
			{
				self waittill("death", attacker, damageType);
				playfxontag("_sphynx/_zm_halloween_pumpkin_explosion", self, "j_head");
				var_162e1c19 = util::spawn_model("tag_origin", self.origin + VectorScale((0, 0, 1), 35), self.angles);
				playable_area = getentarray("player_volume", "script_noteworthy");
				valid_drop = 0;
				for(i = 0; i < playable_area.size; i++)
				{
					if(var_162e1c19 istouching(playable_area[i]))
					{
						valid_drop = 1;
						break;
					}
				}
				if(isdefined(valid_drop) && valid_drop)
				{
					var_162e1c19 setmodel("_zmu_halloween_drop");
					final_pos = zm_weapons::function_a2b97522(self, 50, var_162e1c19, 1);
					var_8f7442a5 = util::ground_position(final_pos, 500, 25);
					var_162e1c19 zm_utility::fake_physicslaunch(var_8f7442a5, randomintrange(50, 100));
					var_162e1c19 thread function_34cead27();
				}
				else
				{
					var_162e1c19 delete();
				}
				level.var_317e7556--;
			}
		}
	}
}

/*
	Name: function_34cead27
	Namespace: namespace_e483ded
	Checksum: 0x424F4353
	Offset: 0x33E8
	Size: 0x2A0
	Parameters: 0
	Flags: None
	Line Number: 940
*/
function function_34cead27()
{
	self endon("powerup_grabbed");
	self endon("powerup_timedout");
	self thread function_2aa7612d(20);
	self thread function_8fedabe9();
	self thread function_e1859039();
	self EnableLinkTo();
	self.var_1785a8a8 = util::spawn_model("tag_origin", self.origin, self.angles);
	self.var_1785a8a8 = playfxontag("_sphynx/_zm_halloween_powerup", self.var_1785a8a8, "tag_origin");
	self.var_1785a8a8 linkto(self);
	self.trigger_use = spawn("trigger_radius_use", self.origin, 0, 50, 50);
	self.trigger_use triggerignoreteam();
	self.trigger_use setvisibletoall();
	self.trigger_use setteamfortrigger("none");
	self.trigger_use usetriggerrequirelookat();
	self.trigger_use setcursorhint("HINT_NOICON");
	self.trigger_use sethintstring(&"ZM_MINECRAFT_HALLOWEEN_TRICK_OR_TREAT");
	while(isdefined(self))
	{
		self.trigger_use waittill("trigger", player);
		player playsoundtoplayer("halloween_pumpkin_pickup", player);
		self thread function_916e719a(player);
		player notify("hash_63cf7d21", "hc2_trick_or_treat", 1, 150, 100000, "halloween_pumpkin_hat");
		wait(0.05);
		player notify("hash_63cf7d21", "hc2_trick_or_treat_single_game", 1, 10, 100000);
		self notify("hash_690bf263");
	}
}

/*
	Name: function_8fedabe9
	Namespace: namespace_e483ded
	Checksum: 0x424F4353
	Offset: 0x3690
	Size: 0x78
	Parameters: 0
	Flags: None
	Line Number: 980
*/
function function_8fedabe9()
{
	self waittill("hash_690bf263");
	if(isdefined(self.trigger_use))
	{
		self.trigger_use delete();
	}
	if(isdefined(self.var_1785a8a8))
	{
		self.var_1785a8a8 delete();
	}
	self delete();
	return;
	ERROR: Bad function call
}

/*
	Name: function_2aa7612d
	Namespace: namespace_e483ded
	Checksum: 0x424F4353
	Offset: 0x3710
	Size: 0xE0
	Parameters: 1
	Flags: None
	Line Number: 1006
*/
function function_2aa7612d(fadetime)
{
	self endon("hash_690bf263");
	self endon("death");
	wait(fadetime);
	for(i = 0; i < 40; i++)
	{
		if(i % 2)
		{
			self hide();
		}
		else
		{
			self show();
		}
		if(i < 15)
		{
			wait(0.5);
			continue;
		}
		if(i < 25)
		{
			wait(0.25);
			continue;
		}
		wait(0.1);
	}
	self notify("hash_690bf263");
}

/*
	Name: function_e1859039
	Namespace: namespace_e483ded
	Checksum: 0x424F4353
	Offset: 0x37F8
	Size: 0x120
	Parameters: 5
	Flags: None
	Line Number: 1046
*/
function function_e1859039(var_466503ff, var_278b47c3, var_aa7689cd, var_df20f103, var_620c330d)
{
	if(!isdefined(var_466503ff))
	{
		var_466503ff = 3.5;
	}
	if(!isdefined(var_278b47c3))
	{
		var_278b47c3 = 6;
	}
	if(!isdefined(var_aa7689cd))
	{
		var_aa7689cd = 9;
	}
	if(!isdefined(var_df20f103))
	{
		var_df20f103 = 6;
	}
	if(!isdefined(var_620c330d))
	{
		var_620c330d = 7;
	}
	self Bobbing((0, 0, 1), var_466503ff, randomintrange(var_278b47c3, var_aa7689cd));
	while(isdefined(self))
	{
		var_ec3f8524 = randomintrange(var_df20f103, var_620c330d);
		self rotateyaw(360, var_ec3f8524);
		wait(var_ec3f8524);
	}
}

/*
	Name: function_916e719a
	Namespace: namespace_e483ded
	Checksum: 0x424F4353
	Offset: 0x3920
	Size: 0x8D0
	Parameters: 1
	Flags: None
	Line Number: 1087
*/
function function_916e719a(player)
{
	index = randomintrange(0, 13);
	switch(index)
	{
		case 0:
		{
			if(player.pers["halloween_pumpkin_hat"])
			{
				points = randomintrange(10, 50) * 50;
			}
			else
			{
				points = randomintrange(10, 50) * 25;
			}
			player zm_score::add_to_player_score(points);
			zm_utility::play_sound_at_pos("purchase", player.origin);
			player luinotifyevent(&"spx_milestone_notification", 3, &"ZM_MINECRAFT_PICKUP_UI", 0, int(points));
			break;
		}
		case 1:
		{
			points = randomintrange(5, 25) * 50;
			player zm_score::minus_to_player_score(points);
			playsoundatposition("halloween_laugh", self.origin);
			player luinotifyevent(&"spx_milestone_notification", 3, &"ZM_MINECRAFT_PICKUP_UI", 1, int(points));
			break;
		}
		case 2:
		{
			self thread dig_up_powerup(undefined, player);
			player luinotifyevent(&"spx_milestone_notification", 2, &"ZM_MINECRAFT_PICKUP_UI", 2);
			break;
		}
		case 3:
		{
			if(!(isdefined(level.var_c181264f) && level.var_c181264f))
			{
				self thread dig_up_weapon(player);
				player luinotifyevent(&"spx_milestone_notification", 2, &"ZM_MINECRAFT_PICKUP_UI", 3);
			}
			else
			{
				self thread function_916e719a(player);
				break;
			}
		}
		case 4:
		{
			XP = randomintrange(5, 25) * 100;
			player notify("hash_79ef118b", "ghost_soul", XP);
			player luinotifyevent(&"spx_milestone_notification", 3, &"ZM_MINECRAFT_PICKUP_UI", 4, int(XP));
			break;
		}
		case 5:
		{
			playsoundatposition("halloween_laugh", self.origin);
			player luinotifyevent(&"spx_milestone_notification", 2, &"ZM_MINECRAFT_PICKUP_UI", 5);
			break;
		}
		case 6:
		{
			if(tolower(getdvarstring("mapname")) != "zm_moon")
			{
				self thread function_916e719a(player);
			}
			else
			{
				self thread function_916e719a(player);
				break;
			}
		}
		case 7:
		{
			if(randomintrange(0, 100) < 8)
			{
				player zm_perks::give_random_perk();
				player luinotifyevent(&"spx_milestone_notification", 2, &"ZM_MINECRAFT_PICKUP_UI", 8);
			}
			else
			{
				self thread function_916e719a(player);
				break;
			}
		}
		case 8:
		{
			if(randomintrange(0, 100) < 25)
			{
				self thread function_cc8bb27e(player);
				player luinotifyevent(&"spx_milestone_notification", 2, &"ZM_MINECRAFT_PICKUP_UI", 9);
			}
			else
			{
				self thread function_916e719a(player);
				break;
			}
		}
		case 9:
		{
			if(level.zombie_vars["zombie_powerup_fire_sale_on"] == 1 || level.chest_moves < 1 || (isdefined(level.disable_firesale_drop) && level.disable_firesale_drop) || (isdefined(level.var_c181264f) && level.var_c181264f))
			{
				self thread function_916e719a(player);
			}
			else
			{
				self thread dig_up_powerup("fire_sale", player);
				player luinotifyevent(&"spx_milestone_notification", 2, &"ZM_MINECRAFT_PICKUP_UI", 10);
				break;
			}
		}
		case 10:
		{
			if(randomintrange(0, 100) < 15 && (!(isdefined(function_ed557e20()) && function_ed557e20())))
			{
				playsoundatposition("halloween_laugh", self.origin);
				function_8824774d(level.round_number + 1);
				player luinotifyevent(&"spx_milestone_notification", 2, &"ZM_MINECRAFT_PICKUP_UI", 11);
			}
			else
			{
				self thread function_916e719a(player);
				break;
			}
		}
		case 11:
		{
			if(randomintrange(0, 100) < 25)
			{
				self thread function_6f1d3e09();
				player luinotifyevent(&"spx_milestone_notification", 2, &"ZM_MINECRAFT_PICKUP_UI", 12);
			}
			else
			{
				self thread function_916e719a(player);
				break;
			}
		}
		case 12:
		{
			playsoundatposition("halloween_laugh", self.origin);
			self thread dig_up_grenade(player);
			player luinotifyevent(&"spx_milestone_notification", 2, &"ZM_MINECRAFT_PICKUP_UI", 6);
			break;
		}
		case 13:
		{
			playsoundatposition("halloween_laugh", self.origin);
			self thread function_7ea6d147();
			player luinotifyevent(&"spx_milestone_notification", 2, &"ZM_MINECRAFT_PICKUP_UI", 6);
			break;
		}
	}
	wait(0.1);
}

/*
	Name: function_7ea6d147
	Namespace: namespace_e483ded
	Checksum: 0x424F4353
	Offset: 0x41F8
	Size: 0x178
	Parameters: 0
	Flags: None
	Line Number: 1253
*/
function function_7ea6d147()
{
	level endon("end_game");
	count = 0;
	while(count < 10)
	{
		wait(1);
		count++;
		foreach(zombie in getaiteamarray(level.zombie_team))
		{
			zombie asmsetanimationrate(0.3);
		}
	}
	foreach(zombie in getaiteamarray(level.zombie_team))
	{
		zombie asmsetanimationrate(1);
	}
}

/*
	Name: function_ed557e20
	Namespace: namespace_e483ded
	Checksum: 0x424F4353
	Offset: 0x4378
	Size: 0x98
	Parameters: 0
	Flags: None
	Line Number: 1282
*/
function function_ed557e20()
{
	var_c4fa626b = level.round_number + 1;
	if(var_c4fa626b != level.n_next_raps_round)
	{
		return 1;
	}
	if(var_c4fa626b != level.var_3013498)
	{
		return 1;
	}
	if(var_c4fa626b != level.var_a78effc7)
	{
		return 1;
	}
	if(var_c4fa626b != level.next_wasp_round)
	{
		return 1;
	}
	if(var_c4fa626b != level.next_dog_round)
	{
		return 1;
	}
	return 0;
}

/*
	Name: function_6f1d3e09
	Namespace: namespace_e483ded
	Checksum: 0x424F4353
	Offset: 0x4418
	Size: 0x118
	Parameters: 0
	Flags: None
	Line Number: 1318
*/
function function_6f1d3e09()
{
	a_ai = getaiarray();
	for(i = 0; i < a_ai.size; i++)
	{
		if(isdefined(a_ai[i]) && isalive(a_ai[i]) && a_ai[i].archetype === "zombie" && isdefined(a_ai[i].gibdef))
		{
			var_5a3ad5d6 = distancesquared(self.origin, a_ai[i].origin);
			if(var_5a3ad5d6 < 360000)
			{
				a_ai[i] zombie_utility::makezombiecrawler();
			}
		}
	}
}

/*
	Name: function_8824774d
	Namespace: namespace_e483ded
	Checksum: 0x424F4353
	Offset: 0x4538
	Size: 0x2E8
	Parameters: 1
	Flags: None
	Line Number: 1344
*/
function function_8824774d(target_round)
{
	if(target_round < 1)
	{
		target_round = 1;
	}
	level.zombie_total = 0;
	zombie_utility::ai_calculate_health(target_round);
	level.round_number = target_round - 1;
	level notify("kill_round");
	playsoundatposition("zmb_bgb_round_robbin", (0, 0, 0));
	wait(0.1);
	zombies = getaiteamarray(level.zombie_team);
	for(i = 0; i < zombies.size; i++)
	{
		if(isdefined(zombies[i].ignore_round_robbin_death) && zombies[i].ignore_round_robbin_death)
		{
			arrayremovevalue(zombies, zombies[i]);
		}
	}
	if(isdefined(zombies))
	{
		e_last = undefined;
		foreach(zombie in zombies)
		{
			if(function_b10a9b0c(zombie))
			{
				e_last = zombie;
			}
		}
		if(isdefined(e_last))
		{
			level.last_ai_origin = e_last.origin;
			level notify("last_ai_down", e_last);
		}
	}
	util::wait_network_frame();
	if(isdefined(zombies))
	{
		foreach(zombie in zombies)
		{
			if(!function_b10a9b0c(zombie))
			{
				continue;
			}
			zombie dodamage(zombie.health + 666, zombie.origin);
		}
	}
	level.var_dfd95560 = undefined;
}

/*
	Name: function_b10a9b0c
	Namespace: namespace_e483ded
	Checksum: 0x424F4353
	Offset: 0x4828
	Size: 0x88
	Parameters: 1
	Flags: None
	Line Number: 1405
*/
function function_b10a9b0c(zombie)
{
	if(!isdefined(zombie))
	{
		return 0;
	}
	if(isdefined(zombie.ignore_round_robbin_death) && zombie.ignore_round_robbin_death || (isdefined(zombie.marked_for_death) && zombie.marked_for_death) || zm_utility::is_magic_bullet_shield_enabled(zombie))
	{
		return 0;
	}
	return 1;
}

/*
	Name: function_cc8bb27e
	Namespace: namespace_e483ded
	Checksum: 0x424F4353
	Offset: 0x48B8
	Size: 0x1D0
	Parameters: 1
	Flags: None
	Line Number: 1428
*/
function function_cc8bb27e(player)
{
	var_bd6badee = 1440000;
	allai = getaiarray();
	foreach(ai in allai)
	{
		if(isdefined(ai.var_5691b7d8) && ai [[ai.var_5691b7d8]]())
		{
			continue;
		}
		if(distance2dsquared(ai.origin, self.origin) >= var_bd6badee)
		{
			continue;
		}
		if(isalive(ai) && !ai ispaused() && ai.team == level.zombie_team && ai.archetype === "zombie" && !ai ishidden() && (!(isdefined(ai.var_85934541) && ai.var_85934541)))
		{
			thread function_1bb7ee0(ai);
		}
	}
}

/*
	Name: function_1bb7ee0
	Namespace: namespace_e483ded
	Checksum: 0x424F4353
	Offset: 0x4A90
	Size: 0xA8
	Parameters: 1
	Flags: None
	Line Number: 1459
*/
function function_1bb7ee0(ai)
{
	ai.marked_for_death = 1;
	ai.var_85934541 = 1;
	ai.no_powerups = 1;
	ai.deathpoints_already_given = 1;
	ai.tesla_head_gib_func = &zombie_head_gib;
	ai lightning_chain::arc_damage(ai, self, 1, level.var_3e825919);
	return;
}

/*
	Name: zombie_head_gib
	Namespace: namespace_e483ded
	Checksum: 0x424F4353
	Offset: 0x4B40
	Size: 0xB0
	Parameters: 0
	Flags: None
	Line Number: 1480
*/
function zombie_head_gib()
{
	self endon("death");
	self clientfield::set("zm_bgb_mind_ray_fx", 1);
	wait(randomfloatrange(0.65, 2.5));
	self clientfield::set("zm_bgb_mind_pop_fx", 1);
	self playsoundontag("zmb_bgb_mindblown_pop", "tag_eye");
	self zombie_utility::zombie_head_gib();
}

/*
	Name: function_9d27c73a
	Namespace: namespace_e483ded
	Checksum: 0x424F4353
	Offset: 0x4BF8
	Size: 0x530
	Parameters: 0
	Flags: None
	Line Number: 1500
*/
function function_9d27c73a()
{
	zm_utility::increment_ignoreme();
	playsoundatposition("zmb_bgb_abh_teleport_out", self.origin);
	if(isdefined(level.var_2c12d9a6))
	{
		var_68140f76 = self [[level.var_2c12d9a6]]();
	}
	else
	{
		var_68140f76 = self function_728dfe3();
	}
	self function_2cb3d5c8();
	self setvelocity((0, 0, 0));
	self setorigin(var_68140f76.origin);
	self freezecontrols(1);
	var_3c5e6535 = self.origin + VectorScale((0, 0, 1), 60);
	a_ai = getaiteamarray(level.zombie_team);
	a_closest = [];
	ai_closest = undefined;
	if(a_ai.size)
	{
		a_closest = arraysortclosest(a_ai, self.origin);
		foreach(ai in a_closest)
		{
			var_9518d12f = ai SightConeTrace(var_3c5e6535, self);
			if(var_9518d12f > 0.2)
			{
				ai_closest = ai;
				break;
			}
		}
		if(isdefined(ai_closest))
		{
			self setplayerangles(vectortoangles(ai_closest getcentroid() - var_3c5e6535));
		}
	}
	self playsound("zmb_bgb_abh_teleport_in");
	if(isdefined(level.var_2300a8ad))
	{
		self [[level.var_2300a8ad]]();
	}
	wait(0.5);
	self show();
	playfx(level._effect["teleport_splash"], self.origin);
	playfx(level._effect["teleport_aoe"], self.origin);
	a_ai = getaiarray();
	var_aca0d7c7 = arraysortclosest(a_ai, self.origin, a_ai.size, 0, 200);
	foreach(ai in var_aca0d7c7)
	{
		if(IsActor(ai))
		{
			if(ai.archetype === "zombie")
			{
				playfx(level._effect["teleport_aoe_kill"], ai gettagorigin("j_spineupper"));
			}
			else
			{
				playfx(level._effect["teleport_aoe_kill"], ai.origin);
			}
			ai.marked_for_recycle = 1;
			ai.has_been_damaged_by_player = 0;
			ai dodamage(ai.health + 1000, self.origin, self);
		}
	}
	wait(0.2);
	self freezecontrols(0);
	self zm_stats::increment_challenge_stat("GUM_GOBBLER_ANYWHERE_BUT_HERE");
	wait(3);
	zm_utility::decrement_ignoreme();
}

/*
	Name: dig_up_grenade
	Namespace: namespace_e483ded
	Checksum: 0x424F4353
	Offset: 0x5130
	Size: 0x118
	Parameters: 1
	Flags: None
	Line Number: 1582
*/
function dig_up_grenade(player)
{
	player endon("disconnect");
	v_spawnpt = self.origin;
	w_grenade = getweapon("frag_grenade");
	n_rand = randomintrange(0, 4);
	player magicgrenadetype(w_grenade, v_spawnpt, VectorScale((0, 0, 1), 300), 3);
	player playsound("evt_grenade_digup");
	if(n_rand)
	{
		wait(0.3);
		if(math::cointoss())
		{
			player magicgrenadetype(w_grenade, v_spawnpt, (50, 50, 300), 3);
		}
	}
}

/*
	Name: dig_up_weapon
	Namespace: namespace_e483ded
	Checksum: 0x424F4353
	Offset: 0x5250
	Size: 0x4C0
	Parameters: 1
	Flags: None
	Line Number: 1610
*/
function dig_up_weapon(digger)
{
	var_43f586fe = array(getweapon("pistol_standard"), getweapon("ar_marksman"), getweapon("shotgun_pump"));
	var_63eba41d = array(getweapon("sniper_fastsemi"), getweapon("shotgun_fullauto"));
	if(digger.pers["halloween_pumpkin_hat"])
	{
		var_63eba41d = arraycombine(var_63eba41d, array(getweapon("ar_galil"), getweapon("smg_standard"), getweapon("smg_mp40_1940"), getweapon("shotgun_precision")), 0, 0);
	}
	var_59d5868d = undefined;
	if(randomint(100) < 90)
	{
		var_59d5868d = var_43f586fe[getarraykeys(var_43f586fe)[randomint(getarraykeys(var_43f586fe).size)]];
	}
	else
	{
		var_59d5868d = var_63eba41d[getarraykeys(var_63eba41d)[randomint(getarraykeys(var_63eba41d).size)]];
	}
	v_spawnpt = self.origin + VectorScale((0, 0, 1), 10);
	v_spawnang = (0, 0, 0);
	v_angles = digger getplayerangles();
	v_angles = (0, v_angles[1], 0) + VectorScale((0, 1, 0), 90) + v_spawnang;
	m_weapon = zm_utility::spawn_buildkit_weapon_model(digger, var_59d5868d, undefined, v_spawnpt, v_angles);
	m_weapon.angles = v_angles;
	m_weapon playloopsound("evt_weapon_digup");
	m_weapon thread timer_til_despawn(v_spawnpt, -40);
	m_weapon endon("dig_up_weapon_timed_out");
	playfxontag(level._effect["powerup_on_solo"], m_weapon, "tag_origin");
	m_weapon.trigger = tomb_spawn_trigger_radius(v_spawnpt, 100, 1, undefined, &function_3674f451);
	m_weapon.trigger.cursor_hint = "HINT_WEAPON";
	m_weapon.trigger.cursor_hint_weapon = var_59d5868d;
	m_weapon.trigger waittill("trigger", player);
	m_weapon.trigger notify("weapon_grabbed");
	m_weapon.trigger thread swap_weapon(var_59d5868d, player);
	if(isdefined(m_weapon.trigger))
	{
		zm_unitrigger::unregister_unitrigger(m_weapon.trigger);
		m_weapon.trigger = undefined;
	}
	if(isdefined(m_weapon))
	{
		m_weapon delete();
	}
	if(player != digger)
	{
		digger notify("dig_up_weapon_shared");
	}
}

/*
	Name: tomb_spawn_trigger_radius
	Namespace: namespace_e483ded
	Checksum: 0x424F4353
	Offset: 0x5718
	Size: 0x148
	Parameters: 5
	Flags: None
	Line Number: 1668
*/
function tomb_spawn_trigger_radius(origin, radius, use_trigger, var_3fe858d9, var_2d6ca912)
{
	if(!isdefined(use_trigger))
	{
		use_trigger = 0;
	}
	trigger_stub = spawnstruct();
	trigger_stub.origin = origin;
	trigger_stub.radius = radius;
	if(use_trigger)
	{
		trigger_stub.cursor_hint = "HINT_NOICON";
		trigger_stub.script_unitrigger_type = "unitrigger_radius_use";
	}
	else
	{
		trigger_stub.script_unitrigger_type = "unitrigger_radius";
	}
	if(isdefined(var_3fe858d9))
	{
		trigger_stub.func_update_msg = var_3fe858d9;
		zm_unitrigger::unitrigger_force_per_player_triggers(trigger_stub, 1);
	}
	if(isdefined(var_2d6ca912))
	{
		trigger_stub.prompt_and_visibility_func = var_2d6ca912;
	}
	zm_unitrigger::register_unitrigger(trigger_stub, &tomb_unitrigger_think);
	return trigger_stub;
}

/*
	Name: tomb_unitrigger_think
	Namespace: namespace_e483ded
	Checksum: 0x424F4353
	Offset: 0x5868
	Size: 0x88
	Parameters: 0
	Flags: None
	Line Number: 1709
*/
function tomb_unitrigger_think()
{
	self endon("kill_trigger");
	if(isdefined(self.stub.func_update_msg))
	{
		self thread tomb_trigger_update_message(self.stub.func_update_msg);
	}
	while(1)
	{
		self waittill("trigger", player);
		self.stub notify("trigger", player);
	}
}

/*
	Name: tomb_trigger_update_message
	Namespace: namespace_e483ded
	Checksum: 0x424F4353
	Offset: 0x58F8
	Size: 0x148
	Parameters: 1
	Flags: None
	Line Number: 1733
*/
function tomb_trigger_update_message(func_per_player_msg)
{
	a_players = getplayers();
	foreach(e_player in a_players)
	{
		n_player = e_player getentitynumber();
		if(!isdefined(self.stub.playertrigger[n_player]))
		{
			continue;
		}
		new_msg = self [[func_per_player_msg]](e_player);
		self.stub.playertrigger[n_player].stored_hint_string = new_msg;
		self.stub.playertrigger[n_player] sethintstring(new_msg);
	}
}

/*
	Name: function_3674f451
	Namespace: namespace_e483ded
	Checksum: 0x424F4353
	Offset: 0x5A48
	Size: 0xD0
	Parameters: 1
	Flags: None
	Line Number: 1759
*/
function function_3674f451(player)
{
	if(!zm_utility::is_player_valid(player) || player.is_drinking > 0 || !player zm_magicbox::can_buy_weapon() || player getcurrentweapon() == level.zombie_powerup_weapon["minigun"])
	{
		self setcursorhint("HINT_NOICON");
		return 0;
	}
	self setcursorhint("HINT_WEAPON", self.stub.cursor_hint_weapon);
	return 1;
}

/*
	Name: swap_weapon
	Namespace: namespace_e483ded
	Checksum: 0x424F4353
	Offset: 0x5B20
	Size: 0x240
	Parameters: 2
	Flags: None
	Line Number: 1780
*/
function swap_weapon(var_375664a9, e_player)
{
	var_1bcd223d = e_player getcurrentweapon();
	if(!zombie_utility::is_player_valid(e_player) || (isdefined(e_player.is_drinking) && e_player.is_drinking) || zm_utility::is_placeable_mine(var_1bcd223d) || zm_equipment::is_equipment(var_1bcd223d) || var_1bcd223d == getweapon("none") || e_player zm_equipment::hacker_active() || var_1bcd223d == level.zombie_powerup_weapon["minigun"])
	{
		return;
	}
	if(isdefined(level.revive_tool) && level.revive_tool == var_1bcd223d)
	{
		return;
	}
	var_6c6831af = e_player getweaponslist(1);
	foreach(weapon in var_6c6831af)
	{
		w_base = zm_weapons::get_base_weapon(weapon);
		var_7321b53b = zm_weapons::get_upgrade_weapon(weapon);
		if(var_375664a9 === w_base || var_375664a9 === var_7321b53b)
		{
			e_player givemaxammo(weapon);
			return;
		}
	}
	e_player zm_weapons::weapon_give(var_375664a9);
}

/*
	Name: timer_til_despawn
	Namespace: namespace_e483ded
	Checksum: 0x424F4353
	Offset: 0x5D68
	Size: 0xC8
	Parameters: 2
	Flags: None
	Line Number: 1815
*/
function timer_til_despawn(v_float, n_dist)
{
	self endon("weapon_grabbed");
	putBackTime = 12;
	self movez(n_dist, putBackTime, putBackTime * 0.5);
	self waittill("movedone");
	self notify("dig_up_weapon_timed_out");
	if(isdefined(self.trigger))
	{
		zm_unitrigger::unregister_unitrigger(self.trigger);
		self.trigger = undefined;
	}
	if(isdefined(self))
	{
		self delete();
		return;
	}
	ERROR: Exception occured: Stack empty.
	ERROR: Exception occured: Stack empty.
}

/*
	Name: dig_up_powerup
	Namespace: namespace_e483ded
	Checksum: 0x424F4353
	Offset: 0x5E38
	Size: 0x140
	Parameters: 2
	Flags: None
	Line Number: 1846
*/
function dig_up_powerup(var_32f5f718, player)
{
	if(!isdefined(var_32f5f718))
	{
		var_32f5f718 = undefined;
	}
	powerup = spawn("script_model", self.origin);
	powerup endon("powerup_grabbed");
	powerup endon("powerup_timedout");
	if(isdefined(var_32f5f718))
	{
		powerup_item = var_32f5f718;
	}
	else
	{
		a_rare_powerups = dig_get_rare_powerups(player);
		powerup_item = a_rare_powerups[randomint(a_rare_powerups.size)];
	}
	powerup zm_powerups::powerup_setup(powerup_item);
	wait(0.2);
	powerup thread zm_powerups::powerup_timeout();
	powerup thread zm_powerups::powerup_wobble();
	powerup thread zm_powerups::powerup_grab();
}

/*
	Name: dig_get_rare_powerups
	Namespace: namespace_e483ded
	Checksum: 0x424F4353
	Offset: 0x5F80
	Size: 0x130
	Parameters: 1
	Flags: None
	Line Number: 1881
*/
function dig_get_rare_powerups(player)
{
	a_rare_powerups = [];
	a_possible_powerups = array("nuke", "minigun", "insta_kill");
	if(player.pers["halloween_pumpkin_hat"])
	{
		a_possible_powerups = arraycombine(a_possible_powerups, array("full_ammo", "xp_drop", "double_points"), 0, 0);
	}
	foreach(powerup in a_possible_powerups)
	{
		a_rare_powerups[a_rare_powerups.size] = powerup;
	}
	return a_rare_powerups;
}

/*
	Name: dig_has_powerup_spawned
	Namespace: namespace_e483ded
	Checksum: 0x424F4353
	Offset: 0x60B8
	Size: 0x40
	Parameters: 1
	Flags: None
	Line Number: 1906
*/
function dig_has_powerup_spawned(str_powerup)
{
	if(!isdefined(level.dig_powerups_tracking[str_powerup]))
	{
		level.dig_powerups_tracking[str_powerup] = 0;
	}
	return level.dig_powerups_tracking[str_powerup];
	ERROR: Exception occured: Stack empty.
	continue;
}

/*
	Name: function_763e8450
	Namespace: namespace_e483ded
	Checksum: 0x424F4353
	Offset: 0x6100
	Size: 0x260
	Parameters: 0
	Flags: Private
	Line Number: 1927
*/
function private function_763e8450()
{
	if(level.round_number >= 1 && randomintrange(1, 100) < 25)
	{
		AiUtility::AddAIOverrideDamageCallback(self, &function_614b2a7b);
		self.armored = 1;
		self.team = level.zombie_team;
		self.health = level.zombie_health;
		self.armor = [];
		self.armor["armor"].helmet = util::spawn_model("wolf_helmet_rev", self gettagorigin("j_head"), self gettagangles("j_head"));
		self.armor["armor"].helmet linkto(self, "j_head");
		self.armor["armor"].vest = util::spawn_model("p7_54i_gear_vest", self gettagorigin("j_spine4"), self gettagangles("j_spine4") - VectorScale((0, 0, 1), 90));
		self.armor["armor"].vest linkto(self, "j_spine4");
		self.armor.health = level.zombie_health / 2;
		self waittill("death", attacker, damageType);
		attacker zm_score::add_to_player_score(250);
		if(isdefined(self.armor))
		{
			self.armor delete();
			return;
		}
	}
	ERROR: Exception occured: Stack empty.
	waittillframeend;
}

/*
	Name: function_614b2a7b
	Namespace: namespace_e483ded
	Checksum: 0x424F4353
	Offset: 0x6368
	Size: 0x1D8
	Parameters: 12
	Flags: None
	Line Number: 1963
*/
function function_614b2a7b(inflictor, attacker, damage, dflags, mod, weapon, point, dir, hitloc, offsettime, boneindex, modelindex)
{
	if(isdefined(attacker) && isplayer(attacker) && isalive(attacker) && (level.zombie_vars[attacker.team]["zombie_insta_kill"] || (isdefined(attacker.personal_instakill) && attacker.personal_instakill)))
	{
		damage = damage * 2;
	}
	if(isdefined(self.armor))
	{
		self.armor.health = self.armor.health - damage;
		if(self.armor.health <= 0)
		{
			attacker playsoundtoplayer("damage_feedback_armor_break", attacker);
			self.armor["helmet"] delete();
			self.armor["vest"] delete();
			self.armor delete();
		}
		return -1;
	}
	else
	{
		return damage;
	}
}

/*
	Name: function_fb8cdeae
	Namespace: namespace_e483ded
	Checksum: 0x424F4353
	Offset: 0x6548
	Size: 0x1D8
	Parameters: 0
	Flags: None
	Line Number: 1997
*/
function function_fb8cdeae()
{
	level endon("intermission");
	var_b8e9c7da = 12;
	spawner = getentarray("armored_zombie_spawner", "script_noteworthy");
	while(1)
	{
		level waittill("start_of_round");
		if(!isdefined(level.round_number) || level.round_number < var_b8e9c7da || (level flag::exists("dog_round") && level flag::get("dog_round")) || !isdefined(level.zombie_total))
		{
			continue;
		}
		spawner[0].script_forcespawn = 1;
		spawner[0].script_disable_bleeder = 1;
		switch(level.round_number)
		{
			case 12:
			{
				spawner[0].count = 1;
				break;
			}
			case 15:
			{
				spawner[0].count = 3;
				break;
			}
			case 20:
			{
				spawner[0].count = 5;
				break;
			}
			case 25:
			{
				spawner[0].count = 7;
				break;
			}
			case 30:
			{
				spawner[0].count = 10;
				break;
			}
		}
	}
}

/*
	Name: function_e62e50fe
	Namespace: namespace_e483ded
	Checksum: 0x424F4353
	Offset: 0x6728
	Size: 0x160
	Parameters: 1
	Flags: None
	Line Number: 2052
*/
function function_e62e50fe(health)
{
	structs = struct::get_array("riser_location", "script_noteworthy");
	s_location = arraygetclosest(level.players[0].origin, structs);
	if(!isdefined(s_location))
	{
		iprintlnbold("Nah mate");
	}
	spawner = getentarray("armored_zombie_spawner", "script_noteworthy");
	spawner[0].script_forcespawn = 1;
	e_ai = zombie_utility::spawn_zombie(spawner[0], "raz", s_location);
	e_ai thread zombie_spawn_init();
	e_ai endon("death");
	e_ai.health = health;
	if(!isdefined(health))
	{
		e_ai.health = 250;
	}
	return e_ai;
}

/*
	Name: zombie_spawn_init
	Namespace: namespace_e483ded
	Checksum: 0x424F4353
	Offset: 0x6890
	Size: 0x438
	Parameters: 0
	Flags: None
	Line Number: 2083
*/
function zombie_spawn_init()
{
	self.targetname = "zombie_boss";
	self.script_noteworthy = undefined;
	zm_utility::recalc_zombie_array();
	self.animname = "zombie_boss";
	self.ignoreme = 0;
	self.allowdeath = 1;
	self.force_gib = 1;
	self.is_zombie = 1;
	self AllowedStances("stand");
	self.attackerCountThreatScale = 0;
	self.currentEnemyThreatScale = 0;
	self.recentAttackerThreatScale = 0;
	self.coverThreatScale = 0;
	self.fovcosine = 0;
	self.fovcosinebusy = 0;
	self.zombie_damaged_by_bar_knockdown = 0;
	self.gibbed = 0;
	self.head_gibbed = 0;
	self setphysparams(15, 0, 72);
	self.goalradius = 32;
	self.disablearrivals = 1;
	self.disableexits = 1;
	self.grenadeawareness = 0;
	self.badplaceawareness = 0;
	self.ignoreSuppression = 1;
	self.suppressionThreshold = 1;
	self.noDodgeMove = 1;
	self.dontShootWhileMoving = 1;
	self.pathenemylookahead = 0;
	self.holdfire = 1;
	self.badplaceawareness = 0;
	self.chatInitialized = 0;
	self.missingLegs = 0;
	if(!isdefined(self.zombie_arms_position))
	{
		if(randomint(2) == 0)
		{
			self.zombie_arms_position = "up";
		}
		else
		{
			self.zombie_arms_position = "down";
		}
	}
	self.a.disablePain = 1;
	self zm_utility::disable_react();
	self.freezegun_damage = 0;
	self SetAvoidanceMask("avoid none");
	self pathmode("dont move");
	self zm_utility::init_zombie_run_cycle();
	self thread zombie_think();
	self thread zm_spawner::zombie_damage_failsafe();
	self thread zm_spawner::enemy_death_detection();
	if(isdefined(level._zombie_custom_spawn_logic))
	{
		if(isarray(level._zombie_custom_spawn_logic))
		{
			for(i = 0; i < level._zombie_custom_spawn_logic.size; i++)
			{
				self thread [[level._zombie_custom_spawn_logic[i]]]();
			}
		}
		else
		{
			self thread [[level._zombie_custom_spawn_logic]]();
		}
	}
	self.deathfunction = &zm_spawner::zombie_death_animscript;
	self.flame_damage_time = 0;
	self.meleedamage = 60;
	self.no_powerups = 1;
	self.thundergun_knockdown_func = level.basic_zombie_thundergun_knockdown;
	self.tesla_head_gib_func = &zm_spawner::zombie_tesla_head_gib;
	self.team = level.zombie_team;
	self.updateSight = 0;
	if(isdefined(level.achievement_monitor_func))
	{
		self [[level.achievement_monitor_func]]();
	}
	if(isdefined(level.zombie_init_done))
	{
		self [[level.zombie_init_done]]();
	}
	self.zombie_init_done = 1;
	self notify("zombie_init_done");
	return;
	ERROR: Exception occured: Stack empty.
	continue;
}

/*
	Name: zombie_think
	Namespace: namespace_e483ded
	Checksum: 0x424F4353
	Offset: 0x6CD0
	Size: 0x98
	Parameters: 0
	Flags: None
	Line Number: 2185
*/
function zombie_think()
{
	self endon("death");
	/#
		Assert(!self.isdog);
	#/
	self.ai_state = "zombie_think";
	self.find_flesh_struct_string = "find_flesh";
	self setgoal(self.origin);
	self pathmode("move allowed");
	self.zombie_think_done = 1;
}

/*
	Name: function_728dfe3
	Namespace: namespace_e483ded
	Checksum: 0x424F4353
	Offset: 0x6D70
	Size: 0x2F0
	Parameters: 0
	Flags: None
	Line Number: 2208
*/
function function_728dfe3()
{
	var_a6abcc5d = zm_zonemgr::get_zone_from_position(self.origin + VectorScale((0, 0, 1), 32), 0);
	if(!isdefined(var_a6abcc5d))
	{
		var_a6abcc5d = self.zone_name;
	}
	if(isdefined(var_a6abcc5d))
	{
		var_c30975d2 = level.zones[var_a6abcc5d];
	}
	var_97786609 = struct::get_array("player_respawn_point", "targetname");
	var_bbf77908 = [];
	foreach(var_68140f76 in var_97786609)
	{
		if(zm_utility::is_point_inside_enabled_zone(var_68140f76.origin, var_c30975d2))
		{
			if(!isdefined(var_bbf77908))
			{
				var_bbf77908 = [];
			}
			else if(!isarray(var_bbf77908))
			{
				var_bbf77908 = array(var_bbf77908);
			}
			var_bbf77908[var_bbf77908.size] = var_68140f76;
		}
	}
	if(isdefined(level.var_2d4e3645))
	{
		var_bbf77908 = [[level.var_2d4e3645]](var_bbf77908);
	}
	var_59fe7f49 = undefined;
	if(var_bbf77908.size > 0)
	{
		var_90551969 = array::random(var_bbf77908);
		var_46b9bbf8 = struct::get_array(var_90551969.target, "targetname");
		foreach(var_dbd59eb2 in var_46b9bbf8)
		{
			n_script_int = self getentitynumber() + 1;
			if(var_dbd59eb2.script_int === n_script_int)
			{
				var_59fe7f49 = var_dbd59eb2;
			}
		}
	}
	return var_59fe7f49;
}

/*
	Name: function_232fd7a0
	Namespace: namespace_e483ded
	Checksum: 0x424F4353
	Offset: 0x7068
	Size: 0xC8
	Parameters: 1
	Flags: None
	Line Number: 2267
*/
function function_232fd7a0(var_34d37a48)
{
	function_8b57c052("spawn_elemental", "");
	for(;;)
	{
		wait(0.05);
		dvar_value = tolower(getdvarstring("spawn_elemental", ""));
		if(isdefined(dvar_value) && dvar_value != "")
		{
			function_8b57c052("spawn_elemental", "");
			level thread function_ede843e2(dvar_value);
		}
	}
}

/*
	Name: function_ede843e2
	Namespace: namespace_e483ded
	Checksum: 0x424F4353
	Offset: 0x7138
	Size: 0x74
	Parameters: 1
	Flags: None
	Line Number: 2292
*/
function function_ede843e2(dvar_value)
{
	spawner = array::random(level.zombie_spawners);
	zombie = zombie_utility::spawn_zombie(spawner);
	wait(0.05);
	zombie thread function_e4e397d9(dvar_value);
}

