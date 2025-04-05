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
#include scripts\sphynx\weapons\_zm_weapon_drop_system;
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
#include scripts\zm\_zm_weapon_upgrade_system;
#include scripts\zm\_zm_weapons;
#include scripts\zm\_zm_zonemgr;

#namespace namespace_e483ded;

/*
	Name: function___init__sytem__
	Namespace: namespace_e483ded
	Checksum: 0x424F4353
	Offset: 0xE58
	Size: 0x38
	Parameters: 0
	Flags: AutoExec
	Line Number: 55
*/
function autoexec function___init__sytem__()
{
	namespace_system::function_register("zm_armored_zombie", &function___init__, undefined, undefined);
}

/*
	Name: function___init__
	Namespace: namespace_e483ded
	Checksum: 0x424F4353
	Offset: 0xE98
	Size: 0xE0
	Parameters: 0
	Flags: None
	Line Number: 70
*/
function function___init__()
{
	level.var__effect["armored_zombie_break"] = "_sphynx/_zm_armored_zombie_explode_piece";
	level thread function_7e77ed86();
	level thread function_87a20e06();
	namespace_spawner::function_add_archetype_spawn_function("zombie", &function_763e8450);
	wait(0.05);
	level namespace_flag::function_wait_till("allow_elemental_zombies");
	level.var_1a450322 = 0;
	level.var_f93c0c9e = 0;
	namespace_spawner::function_add_archetype_spawn_function("zombie", &function_e0a13953);
}

/*
	Name: function_87a20e06
	Namespace: namespace_e483ded
	Checksum: 0x424F4353
	Offset: 0xF80
	Size: 0x40
	Parameters: 0
	Flags: None
	Line Number: 93
*/
function function_87a20e06()
{
	wait(0.05);
	level namespace_flag::function_wait_till("debug_dev");
	thread function_232fd7a0();
}

/*
	Name: function_7e77ed86
	Namespace: namespace_e483ded
	Checksum: 0x424F4353
	Offset: 0xFC8
	Size: 0x58
	Parameters: 0
	Flags: None
	Line Number: 110
*/
function function_7e77ed86()
{
	while(isdefined(level.var_f93c0c9e) && level.var_f93c0c9e > 0)
	{
		level.var_f93c0c9e--;
		if(isdefined(level.var_8aa0ec6f) && level.var_8aa0ec6f > 0)
		{
			level.var_8aa0ec6f--;
		}
		wait(1);
	}
	return;
	ERROR: Bad function call
}

/*
	Name: function_e0a13953
	Namespace: namespace_e483ded
	Checksum: 0x424F4353
	Offset: 0x1028
	Size: 0x98
	Parameters: 0
	Flags: Private
	Line Number: 135
*/
function private function_e0a13953()
{
	if(level.var_round_number >= 12 && function_randomIntRange(1, 100) < 10)
	{
		if(level.var_1a450322 <= 3 && level.var_f93c0c9e == 0)
		{
			level.var_1a450322++;
			level.var_f93c0c9e = 30;
			self function_EnableLinkTo();
			self thread function_e4e397d9();
			return;
		}
	}
}

/*
	Name: function_e4e397d9
	Namespace: namespace_e483ded
	Checksum: 0x424F4353
	Offset: 0x10C8
	Size: 0x110
	Parameters: 1
	Flags: None
	Line Number: 160
*/
function function_e4e397d9(var_4df9307b)
{
	self.var_Elemental = 1;
	if(isdefined(var_4df9307b))
	{
		self.var_4df9307b = var_4df9307b;
	}
	else
	{
		self.var_4df9307b = self function_86821e50();
	}
	self.var_team = level.var_zombie_team;
	self.var_health = level.var_zombie_health * 3;
	if(isdefined(self.var_script_string) && self.var_script_string == "riser")
	{
		while(isdefined(self.var_in_the_ground) && self.var_in_the_ground)
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
	Offset: 0x11E0
	Size: 0x438
	Parameters: 0
	Flags: None
	Line Number: 205
*/
function function_1514ccd7()
{
	if(function_isalive(self))
	{
		var_44c49629 = namespace_util::function_spawn_model("tag_origin", self.var_origin + VectorScale((0, 0, 1), 42));
		var_44c49629 = function_PlayFXOnTag("electric/fx_ability_elec_surge_short_robot_optim", var_44c49629, "tag_origin");
		var_44c49629 function_LinkTo(self);
		self waittill("hash_death", var_attacker, var_damageType);
		level.var_1a450322--;
		var_55d9ee3b = namespace_util::function_spawn_model("tag_origin", self.var_origin + VectorScale((0, 0, 1), 55));
		var_55d9ee3b = function_PlayFXOnTag("explosions/fx_exp_grenade_emp", self, "tag_origin");
		var_zombies = namespace_Array::function_get_all_closest(self.var_origin, function_GetAITeamArray(level.var_zombie_team), undefined, undefined, 240);
		for(var_i = 0; var_i < 6; var_i++)
		{
			if(!isdefined(var_zombies[var_i]) || !function_isalive(var_zombies[var_i]))
			{
				continue;
			}
			var_dist_sq = function_DistanceSquared(self.var_origin, var_zombies[var_i].var_origin);
			if(var_dist_sq < 10000)
			{
				var_zombies[var_i] function_DoDamage(level.var_zombie_health + 666, self.var_origin);
				continue;
			}
			if(var_dist_sq > 10000)
			{
				continue;
			}
			if(0 == var_zombies[var_i] function_damageConeTrace(self.var_origin, self))
			{
				continue;
			}
			var_zombies[var_i] function_DoDamage(level.var_zombie_health + 666, self.var_origin);
		}
		var_players = namespace_Array::function_get_all_closest(self.var_origin, function_GetPlayers(), undefined, undefined, 280);
		foreach(var_player in function_GetPlayers())
		{
			if(function_Distance(var_44c49629.var_origin, var_player.var_origin) < 280)
			{
				var_player thread function_damage_player();
			}
		}
		wait(0.8);
		if(isdefined(var_44c49629))
		{
			var_44c49629 function_delete();
		}
		if(isdefined(var_55d9ee3b))
		{
			var_55d9ee3b function_delete();
		}
		var_attacker namespace_zm_score::function_add_to_player_score(200);
	}
}

/*
	Name: function_32d26a34
	Namespace: namespace_e483ded
	Checksum: 0x424F4353
	Offset: 0x1620
	Size: 0x430
	Parameters: 0
	Flags: None
	Line Number: 270
*/
function function_32d26a34()
{
	if(function_isalive(self))
	{
		var_a78ce442 = namespace_util::function_spawn_model("tag_origin", self.var_origin + VectorScale((0, 0, 1), 42));
		var_a78ce442 = function_PlayFXOnTag("fire/fx_fire_ai_human_torso_loop_optim", var_a78ce442, "tag_origin");
		var_a78ce442 function_LinkTo(self);
		self waittill("hash_death", var_attacker, var_damageType);
		level.var_1a450322--;
		var_7f127a14 = namespace_util::function_spawn_model("tag_origin", self.var_origin + VectorScale((0, 0, 1), 55));
		var_7f127a14 = function_PlayFXOnTag("dlc5/temple/fx_ztem_napalm_zombie_exp", self, "tag_origin");
		var_zombies = namespace_Array::function_get_all_closest(self.var_origin, function_GetAITeamArray(level.var_zombie_team), undefined, undefined, 250);
		for(var_i = 0; var_i < 12; var_i++)
		{
			if(!isdefined(var_zombies[var_i]) || !function_isalive(var_zombies[var_i]))
			{
				continue;
			}
			var_dist_sq = function_DistanceSquared(self.var_origin, var_zombies[var_i].var_origin);
			if(var_dist_sq > 30625)
			{
				continue;
			}
			var_zombies[var_i] function_DoDamage(level.var_zombie_health / 5, self.var_origin);
		}
		var_players = namespace_Array::function_get_all_closest(self.var_origin, function_GetPlayers(), undefined, undefined, 250);
		foreach(var_player in function_GetPlayers())
		{
			if(function_Distance(self.var_origin, var_player.var_origin) < 100)
			{
				var_player thread function_1e61c259();
			}
		}
		wait(0.5);
		var_817b4cfc = namespace_util::function_spawn_model("tag_origin", self.var_origin);
		var_817b4cfc = function_PlayFXOnTag("_sphynx/_zm_fire_ground", var_817b4cfc, "tag_origin");
		var_817b4cfc thread function_701a2943();
		wait(0.8);
		if(isdefined(var_a78ce442))
		{
			var_a78ce442 function_delete();
		}
		if(isdefined(var_7f127a14))
		{
			var_7f127a14 function_delete();
		}
		var_attacker namespace_zm_score::function_add_to_player_score(200);
	}
}

/*
	Name: function_701a2943
	Namespace: namespace_e483ded
	Checksum: 0x424F4353
	Offset: 0x1A58
	Size: 0x218
	Parameters: 0
	Flags: None
	Line Number: 330
*/
function function_701a2943()
{
	self thread function_c629df9b();
	self.var_trig = function_spawn("trigger_radius", self.var_origin, 0, 128, 64);
	while(isdefined(self))
	{
		foreach(var_player in function_GetPlayers())
		{
			if(var_player function_istouching(self.var_trig))
			{
				function_IPrintLnBold("Triggered fire [Player]");
				var_player thread function_55773d55();
			}
		}
		var_zombies = namespace_Array::function_get_all_closest(self.var_trig.var_origin, function_GetAITeamArray(level.var_zombie_team), undefined, undefined, 100);
		foreach(var_zombie in var_zombies)
		{
			function_IPrintLnBold("Triggered fire [Zombie]");
			var_zombie thread function_55773d55();
		}
		wait(1);
	}
}

/*
	Name: function_c629df9b
	Namespace: namespace_e483ded
	Checksum: 0x424F4353
	Offset: 0x1C78
	Size: 0x50
	Parameters: 0
	Flags: None
	Line Number: 364
*/
function function_c629df9b()
{
	wait(14);
	if(isdefined(self.var_trig))
	{
		self.var_trig function_delete();
	}
	self function_delete();
}

/*
	Name: function_55773d55
	Namespace: namespace_e483ded
	Checksum: 0x424F4353
	Offset: 0x1CD0
	Size: 0x1C0
	Parameters: 1
	Flags: None
	Line Number: 384
*/
function function_55773d55(var_trig)
{
	self endon("hash_zombified");
	self endon("hash_death");
	self endon("hash_disconnect");
	if(isdefined(self.var_is_zombie) && self.var_is_zombie)
	{
		self endon("hash_death");
		var_zombie_dmg = 25;
		if(!isdefined(self.var_is_on_fire) || !self.var_is_on_fire)
		{
			if(level.var_burning_zombies.size < 6 && var_zombie_dmg >= 25)
			{
				level.var_burning_zombies[level.var_burning_zombies.size] = self;
				self function_playsound("zmb_ignite");
				self thread function_zombie_burning_fx();
				self thread function_zombie_burning_watch();
				self thread function_zombie_burning_dmg();
				self thread function_zombie_exploding_death(var_zombie_dmg, self);
				wait(function_RandomFloat(1.25));
			}
		}
		if(self.var_health > level.var_zombie_health / 2 && self.var_health > var_zombie_dmg)
		{
			self function_DoDamage(var_zombie_dmg, self.var_origin, self);
			continue;
		}
	}
	else
	{
		self thread function_1e61c259();
	}
}

/*
	Name: function_1e61c259
	Namespace: namespace_e483ded
	Checksum: 0x424F4353
	Offset: 0x1E98
	Size: 0x1A0
	Parameters: 0
	Flags: None
	Line Number: 428
*/
function function_1e61c259()
{
	var_max_dmg = 15;
	var_min_dmg = 5;
	var_burn_time = 1;
	self thread function_player_stop_burning();
	if(!isdefined(self.var_is_burning) && namespace_zm_utility::function_is_player_valid(self))
	{
		self.var_is_burning = 1;
		self thread function_5c5faa65();
		self notify("hash_burned");
		self thread function_player_burning_fx();
		if(!self function_hasPerk("specialty_armorvest") || self.var_health - 100 < 1)
		{
			function_RadiusDamage(self.var_origin, 10, var_max_dmg, var_min_dmg);
			wait(0.5);
			self.var_is_burning = undefined;
		}
		else if(self function_hasPerk("specialty_armorvest"))
		{
			self function_DoDamage(15, self.var_origin);
		}
		else
		{
			self function_DoDamage(1, self.var_origin);
		}
		wait(0.5);
		self.var_is_burning = undefined;
	}
}

/*
	Name: function_5c5faa65
	Namespace: namespace_e483ded
	Checksum: 0x424F4353
	Offset: 0x2040
	Size: 0x88
	Parameters: 0
	Flags: None
	Line Number: 469
*/
function function_5c5faa65()
{
	self namespace_clientfield::function_set("burn", 1);
	self namespace_util::function_waittill_any_timeout(level.var_zm_transit_burn_max_duration, "death", "disconnect", "bled_out", "player_stop_burning");
	self namespace_clientfield::function_set("burn", 0);
}

/*
	Name: function_player_stop_burning
	Namespace: namespace_e483ded
	Checksum: 0x424F4353
	Offset: 0x20D0
	Size: 0x68
	Parameters: 0
	Flags: None
	Line Number: 486
*/
function function_player_stop_burning()
{
	self notify("hash_player_stop_burning");
	self endon("hash_player_stop_burning");
	self endon("hash_death_or_disconnect");
	self waittill("hash_zombified");
	self notify("hash_stop_flame_damage");
	self namespace_clientfield::function_set("burn", 0);
}

/*
	Name: function_zombie_burning_fx
	Namespace: namespace_e483ded
	Checksum: 0x424F4353
	Offset: 0x2140
	Size: 0x270
	Parameters: 0
	Flags: None
	Line Number: 506
*/
function function_zombie_burning_fx()
{
	self endon("hash_death");
	if(isdefined(self.var_is_on_fire) && self.var_is_on_fire)
	{
		return;
	}
	self.var_is_on_fire = 1;
	self thread namespace_zombie_death::function_on_fire_timeout();
	if(isdefined(level.var__effect) && isdefined(level.var__effect["lava_burning"]))
	{
		if(!self.var_isdog)
		{
			function_PlayFXOnTag(level.var__effect["lava_burning"], self, "J_SpineLower");
			self thread function_zombie_burning_audio();
		}
	}
	if(isdefined(level.var__effect) && isdefined(level.var__effect["character_fire_death_sm"]))
	{
		wait(1);
		if(function_RandomInt(2) > 1)
		{
			var_tagArray = [];
			var_tagArray[0] = "J_Elbow_LE";
			var_tagArray[1] = "J_Elbow_RI";
			var_tagArray[2] = "J_Knee_RI";
			var_tagArray[3] = "J_Knee_LE";
			var_tagArray = namespace_Array::function_randomize(var_tagArray);
			function_PlayFXOnTag(level.var__effect["character_fire_death_sm"], self, var_tagArray[0]);
		}
		else
		{
			var_tagArray[0] = "J_Wrist_RI";
			var_tagArray[1] = "J_Wrist_LE";
			if(!isdefined(self.var_a.var_gib_ref) || self.var_a.var_gib_ref != "no_legs")
			{
				var_tagArray[2] = "J_Ankle_RI";
				var_tagArray[3] = "J_Ankle_LE";
			}
			var_tagArray = namespace_Array::function_randomize(var_tagArray);
			function_PlayFXOnTag(level.var__effect["character_fire_death_sm"], self, var_tagArray[0]);
			return;
		}
	}
}

/*
	Name: function_zombie_burning_audio
	Namespace: namespace_e483ded
	Checksum: 0x424F4353
	Offset: 0x23B8
	Size: 0x90
	Parameters: 0
	Flags: None
	Line Number: 562
*/
function function_zombie_burning_audio()
{
	self function_PlayLoopSound("zmb_fire_loop");
	self namespace_util::function_waittill_either("stop_flame_damage", "death");
	if(isdefined(self) && function_isalive(self))
	{
		self function_StopLoopSound(0.25);
	}
}

/*
	Name: function_player_burning_fx
	Namespace: namespace_e483ded
	Checksum: 0x424F4353
	Offset: 0x2450
	Size: 0xC8
	Parameters: 0
	Flags: None
	Line Number: 582
*/
function function_player_burning_fx()
{
	self endon("hash_death");
	if(isdefined(self.var_is_on_fire) && self.var_is_on_fire)
	{
		return;
	}
	if(!(isdefined(self.var_no_burning_sfx) && self.var_no_burning_sfx))
	{
		self thread function_player_burning_audio();
	}
	self.var_is_on_fire = 1;
	self thread namespace_zombie_death::function_on_fire_timeout();
	if(isdefined(level.var__effect) && isdefined(level.var__effect["character_fire_death_sm"]))
	{
		function_PlayFXOnTag(level.var__effect["character_fire_death_sm"], self, "J_SpineLower");
	}
}

/*
	Name: function_player_burning_audio
	Namespace: namespace_e483ded
	Checksum: 0x424F4353
	Offset: 0x2520
	Size: 0xD0
	Parameters: 0
	Flags: None
	Line Number: 611
*/
function function_player_burning_audio()
{
	var_fire_ent = function_spawn("script_model", self.var_origin);
	namespace_util::function_wait_network_frame();
	var_fire_ent function_LinkTo(self);
	var_fire_ent function_PlayLoopSound("evt_plr_fire_loop");
	self namespace_util::function_waittill_any("stop_flame_damage", "stop_flame_sounds", "death", "disconnect");
	var_fire_ent function_delete();
	return;
	ERROR: Exception occured: Stack empty.
	waittillframeend;
}

/*
	Name: function_zombie_burning_watch
	Namespace: namespace_e483ded
	Checksum: 0x424F4353
	Offset: 0x25F8
	Size: 0x48
	Parameters: 0
	Flags: None
	Line Number: 634
*/
function function_zombie_burning_watch()
{
	self namespace_util::function_waittill_any("stop_flame_damage", "death");
	function_ArrayRemoveValue(level.var_burning_zombies, self);
}

/*
	Name: function_zombie_exploding_death
	Namespace: namespace_e483ded
	Checksum: 0x424F4353
	Offset: 0x2648
	Size: 0x1E8
	Parameters: 2
	Flags: None
	Line Number: 650
*/
function function_zombie_exploding_death(var_zombie_dmg, var_trap)
{
	self endon("hash_stop_flame_damage");
	if(isdefined(self.var_isdog) && self.var_isdog && isdefined(self.var_a.var_nodeath))
	{
		return;
	}
	while(isdefined(self) && self.var_health >= var_zombie_dmg && (isdefined(self.var_is_on_fire) && self.var_is_on_fire))
	{
		wait(0.5);
	}
	if(!isdefined(self) || (!isdefined(self.var_is_on_fire) && self.var_is_on_fire) || (isdefined(self.var_damageWeapon) && (self.var_damageWeapon.var_name == "t6_tazer_knuckles" || self.var_damageWeapon.var_name == "t6_jetgun")) || (isdefined(self.var_knuckles_extinguish_flames) && self.var_knuckles_extinguish_flames))
	{
		return;
	}
	self thread namespace_zombie_utility::function_zombie_gut_explosion();
	self function_playsound("wpn_grenade_explode_close");
	self function_RadiusDamage(self.var_origin, 128, 30, 15, undefined, "MOD_EXPLOSIVE");
	self function_ghost();
	if(isdefined(self.var_isdog) && self.var_isdog)
	{
		self function_Hide();
	}
	else
	{
		self namespace_util::function_delay(1, &function_delete);
	}
}

/*
	Name: function_zombie_burning_dmg
	Namespace: namespace_e483ded
	Checksum: 0x424F4353
	Offset: 0x2838
	Size: 0x170
	Parameters: 0
	Flags: None
	Line Number: 689
*/
function function_zombie_burning_dmg()
{
	self endon("hash_death");
	var_damageradius = 25;
	var_damage = 2;
	while(isdefined(self.var_is_on_fire) && self.var_is_on_fire)
	{
		var_eyeOrigin = self function_GetEye();
		var_players = function_GetPlayers();
		for(var_i = 0; var_i < var_players.size; var_i++)
		{
			if(namespace_zm_utility::function_is_player_valid(var_players[var_i]))
			{
				var_playerEye = var_players[var_i] function_GetEye();
				if(function_DistanceSquared(var_eyeOrigin, var_playerEye) < var_damageradius * var_damageradius)
				{
					var_players[var_i] function_DoDamage(var_damage, self.var_origin, self);
					var_players[var_i] notify("hash_burned");
				}
			}
		}
		wait(1);
	}
}

/*
	Name: function_damage_player
	Namespace: namespace_e483ded
	Checksum: 0x424F4353
	Offset: 0x29B0
	Size: 0xF8
	Parameters: 0
	Flags: None
	Line Number: 724
*/
function function_damage_player()
{
	function_Earthquake(0.7, 1, self.var_origin, 150);
	self function_DoDamage(20, self.var_origin);
	self function_shellshock("shock_field", 1);
	if(isdefined(self namespace_clientfield::function_get("shock_field")))
	{
		self namespace_clientfield::function_set("shock_field", 1);
	}
	wait(1);
	if(isdefined(self namespace_clientfield::function_get("shock_field")))
	{
		self namespace_clientfield::function_set("shock_field", 0);
	}
}

/*
	Name: function_c01d2cb2
	Namespace: namespace_e483ded
	Checksum: 0x424F4353
	Offset: 0x2AB0
	Size: 0x100
	Parameters: 12
	Flags: None
	Line Number: 750
*/
function function_c01d2cb2(var_inflictor, var_attacker, var_damage, var_dFlags, var_mod, var_weapon, var_point, var_dir, var_hitLoc, var_offsetTime, var_boneIndex, var_modelIndex)
{
	if(isdefined(var_attacker) && function_isPlayer(var_attacker) && function_isalive(var_attacker) && (level.var_zombie_vars[var_attacker.var_team]["zombie_insta_kill"] || (isdefined(var_attacker.var_personal_instakill) && var_attacker.var_personal_instakill)))
	{
		var_damage = var_damage * 2;
	}
	return var_damage;
}

/*
	Name: function_86821e50
	Namespace: namespace_e483ded
	Checksum: 0x424F4353
	Offset: 0x2BB8
	Size: 0x10
	Parameters: 0
	Flags: None
	Line Number: 769
*/
function function_86821e50()
{
	return "electricity";
}

/*
	Name: function_33a6158a
	Namespace: namespace_e483ded
	Checksum: 0x424F4353
	Offset: 0x2BD0
	Size: 0x350
	Parameters: 0
	Flags: Private
	Line Number: 784
*/
function private function_33a6158a()
{
	if(function_randomIntRange(1, 100) < 5 && !level namespace_flag::function_get("speedrun_enabled") && !level namespace_flag::function_get("seasonal_content_disabled"))
	{
		if(level.var_e5ed6b73 <= 1 && level.var_8aa0ec6f == 0)
		{
			self.var_4116bb49 = 1;
			self.var_no_powerups = 1;
			level.var_8aa0ec6f = 40;
			self function_Attach("_zmu_christmas_hat", "j_head");
			level.var_e5ed6b73++;
			self.var_ec7527e0 = 1;
			if(function_isalive(self))
			{
				self waittill("hash_death", var_attacker, var_damageType);
				var_162e1c19 = namespace_util::function_spawn_model("tag_origin", self.var_origin + VectorScale((0, 0, 1), 35), self.var_angles);
				var_playable_area = function_GetEntArray("player_volume", "script_noteworthy");
				var_valid_drop = 0;
				for(var_i = 0; var_i < var_playable_area.size; var_i++)
				{
					if(var_162e1c19 function_istouching(var_playable_area[var_i]))
					{
						var_valid_drop = 1;
						break;
					}
				}
				if(isdefined(var_valid_drop) && var_valid_drop)
				{
					var_162e1c19 function_SetModel("zmu_christmas_present");
					var_cff75e45 = namespace_ecdf5e21::function_b4c587b5(self.var_origin);
					var_final_pos = namespace_ecdf5e21::function_a2b97522(self, 50, var_162e1c19, 1);
					var_8f7442a5 = namespace_util::function_ground_position(var_final_pos, 5000, 25);
					var_2374f197 = function_length(var_final_pos - var_8f7442a5) * 2;
					var_drop_time = var_162e1c19 namespace_zm_utility::function_fake_physicslaunch(var_8f7442a5, var_2374f197);
					var_162e1c19 thread function_d5f8a2b2();
				}
				else
				{
					var_162e1c19 function_delete();
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
	Offset: 0x2F28
	Size: 0x2A0
	Parameters: 0
	Flags: None
	Line Number: 840
*/
function function_d5f8a2b2()
{
	self endon("hash_powerup_grabbed");
	self endon("hash_powerup_timedout");
	self thread function_2aa7612d(20);
	self thread function_8fedabe9();
	self thread function_e1859039();
	self function_EnableLinkTo();
	self.var_1785a8a8 = namespace_util::function_spawn_model("tag_origin", self.var_origin, self.var_angles);
	self.var_1785a8a8 = function_PlayFXOnTag("_sphynx/_zm_christmas_powerup", self.var_1785a8a8, "tag_origin");
	self.var_1785a8a8 function_LinkTo(self);
	self.var_trigger_use = function_spawn("trigger_radius_use", self.var_origin, 0, 50, 50);
	self.var_trigger_use function_TriggerIgnoreTeam();
	self.var_trigger_use function_SetVisibleToAll();
	self.var_trigger_use function_SetTeamForTrigger("none");
	self.var_trigger_use function_UseTriggerRequireLookAt();
	self.var_trigger_use function_setcursorhint("HINT_NOICON");
	self.var_trigger_use function_setHintString(&"ZM_MINECRAFT_CHRISTMAS_PRESENT_PICKUP");
	while(isdefined(self))
	{
		self.var_trigger_use waittill("hash_trigger", var_player);
		self thread function_916e719a(var_player);
		var_player notify("hash_63cf7d21", "cc2_gift_collector", 1, 50, 25000, 50);
		wait(0.05);
		if(var_player.var_pers["cc2_gift_collector"] >= 50)
		{
			var_player notify("hash_63cf7d21", "cc2_gift_hoarder", 1, 100, 50000, 100);
		}
		wait(0.05);
		self notify("hash_690bf263");
	}
	return;
}

/*
	Name: function_bd226691
	Namespace: namespace_e483ded
	Checksum: 0x424F4353
	Offset: 0x31D0
	Size: 0x2D8
	Parameters: 0
	Flags: Private
	Line Number: 884
*/
function private function_bd226691()
{
	if(function_randomIntRange(1, 100) < 7)
	{
		if(level.var_317e7556 <= 1 && level.var_c806dee2 == 0 && !level namespace_flag::function_get("speedrun_enabled") && !level namespace_flag::function_get("seasonal_content_disabled"))
		{
			self.var_4116bb49 = 1;
			self.var_no_powerups = 1;
			level.var_c806dee2 = 40;
			self function_Attach("_zmu_halloween_hat", "j_head");
			level.var_317e7556++;
			if(function_isalive(self))
			{
				self waittill("hash_death", var_attacker, var_damageType);
				function_PlayFXOnTag("_sphynx/_zm_halloween_pumpkin_explosion", self, "j_head");
				var_162e1c19 = namespace_util::function_spawn_model("tag_origin", self.var_origin + VectorScale((0, 0, 1), 35), self.var_angles);
				var_playable_area = function_GetEntArray("player_volume", "script_noteworthy");
				var_valid_drop = 0;
				for(var_i = 0; var_i < var_playable_area.size; var_i++)
				{
					if(var_162e1c19 function_istouching(var_playable_area[var_i]))
					{
						var_valid_drop = 1;
						break;
					}
				}
				if(isdefined(var_valid_drop) && var_valid_drop)
				{
					var_162e1c19 function_SetModel("_zmu_halloween_drop");
					var_final_pos = self namespace_ecdf5e21::function_a2b97522(undefined, 50, var_162e1c19, 1);
					var_162e1c19 namespace_ecdf5e21::function_a170d6f0(var_final_pos, 25);
					var_162e1c19 thread function_34cead27();
				}
				else
				{
					var_162e1c19 function_delete();
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
	Offset: 0x34B0
	Size: 0x2A0
	Parameters: 0
	Flags: None
	Line Number: 937
*/
function function_34cead27()
{
	self endon("hash_powerup_grabbed");
	self endon("hash_powerup_timedout");
	self thread function_2aa7612d(20);
	self thread function_8fedabe9();
	self thread function_e1859039();
	self function_EnableLinkTo();
	self.var_1785a8a8 = namespace_util::function_spawn_model("tag_origin", self.var_origin, self.var_angles);
	self.var_1785a8a8 = function_PlayFXOnTag("_sphynx/_zm_halloween_powerup", self.var_1785a8a8, "tag_origin");
	self.var_1785a8a8 function_LinkTo(self);
	self.var_trigger_use = function_spawn("trigger_radius_use", self.var_origin, 0, 50, 50);
	self.var_trigger_use function_TriggerIgnoreTeam();
	self.var_trigger_use function_SetVisibleToAll();
	self.var_trigger_use function_SetTeamForTrigger("none");
	self.var_trigger_use function_UseTriggerRequireLookAt();
	self.var_trigger_use function_setcursorhint("HINT_NOICON");
	self.var_trigger_use function_setHintString(&"ZM_MINECRAFT_HALLOWEEN_TRICK_OR_TREAT");
	while(isdefined(self))
	{
		self.var_trigger_use waittill("hash_trigger", var_player);
		var_player function_playsoundtoplayer("halloween_pumpkin_pickup", var_player);
		self thread function_916e719a(var_player);
		var_player notify("hash_63cf7d21", "hc2_trick_or_treat", 1, 150, 100000, "halloween_pumpkin_hat");
		wait(0.05);
		var_player notify("hash_63cf7d21", "hc2_trick_or_treat_single_game", 1, 10, 100000);
		self notify("hash_690bf263");
	}
	return;
}

/*
	Name: function_8fedabe9
	Namespace: namespace_e483ded
	Checksum: 0x424F4353
	Offset: 0x3758
	Size: 0x78
	Parameters: 0
	Flags: None
	Line Number: 978
*/
function function_8fedabe9()
{
	self waittill("hash_690bf263");
	if(isdefined(self.var_trigger_use))
	{
		self.var_trigger_use function_delete();
	}
	if(isdefined(self.var_1785a8a8))
	{
		self.var_1785a8a8 function_delete();
	}
	self function_delete();
}

/*
	Name: function_2aa7612d
	Namespace: namespace_e483ded
	Checksum: 0x424F4353
	Offset: 0x37D8
	Size: 0xE0
	Parameters: 1
	Flags: None
	Line Number: 1002
*/
function function_2aa7612d(var_fadetime)
{
	self endon("hash_690bf263");
	self endon("hash_death");
	wait(var_fadetime);
	for(var_i = 0; var_i < 40; var_i++)
	{
		if(var_i % 2)
		{
			self function_Hide();
		}
		else
		{
			self function_show();
		}
		if(var_i < 15)
		{
			wait(0.5);
			continue;
		}
		if(var_i < 25)
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
	Offset: 0x38C0
	Size: 0x120
	Parameters: 5
	Flags: None
	Line Number: 1042
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
	self function_Bobbing((0, 0, 1), var_466503ff, function_randomIntRange(var_278b47c3, var_aa7689cd));
	while(isdefined(self))
	{
		var_ec3f8524 = function_randomIntRange(var_df20f103, var_620c330d);
		self function_RotateYaw(360, var_ec3f8524);
		wait(var_ec3f8524);
	}
	return;
	ERROR: Exception occured: Stack empty.
}

/*
	Name: function_916e719a
	Namespace: namespace_e483ded
	Checksum: 0x424F4353
	Offset: 0x39E8
	Size: 0x8D0
	Parameters: 1
	Flags: None
	Line Number: 1085
*/
function function_916e719a(var_player)
{
	var_index = function_randomIntRange(0, 13);
	switch(var_index)
	{
		case 0:
		{
			if(var_player.var_pers["halloween_pumpkin_hat"])
			{
				var_points = function_randomIntRange(10, 50) * 50;
			}
			else
			{
				var_points = function_randomIntRange(10, 50) * 25;
			}
			var_player namespace_zm_score::function_add_to_player_score(var_points);
			namespace_zm_utility::function_play_sound_at_pos("purchase", var_player.var_origin);
			var_player function_LUINotifyEvent(&"spx_milestone_notification", 3, &"ZM_MINECRAFT_PICKUP_UI", 0, function_Int(var_points));
			break;
		}
		case 1:
		{
			var_points = function_randomIntRange(5, 25) * 50;
			var_player namespace_zm_score::function_minus_to_player_score(var_points);
			function_playsoundatposition("halloween_laugh", self.var_origin);
			var_player function_LUINotifyEvent(&"spx_milestone_notification", 3, &"ZM_MINECRAFT_PICKUP_UI", 1, function_Int(var_points));
			break;
		}
		case 2:
		{
			self thread function_dig_up_powerup(undefined, var_player);
			var_player function_LUINotifyEvent(&"spx_milestone_notification", 2, &"ZM_MINECRAFT_PICKUP_UI", 2);
			break;
		}
		case 3:
		{
			if(!(isdefined(level.var_c181264f) && level.var_c181264f))
			{
				self thread function_dig_up_weapon(var_player);
				var_player function_LUINotifyEvent(&"spx_milestone_notification", 2, &"ZM_MINECRAFT_PICKUP_UI", 3);
			}
			else
			{
				self thread function_916e719a(var_player);
				break;
			}
		}
		case 4:
		{
			var_XP = function_randomIntRange(5, 25) * 100;
			var_player notify("hash_79ef118b", "christmas_present", var_XP);
			var_player function_LUINotifyEvent(&"spx_milestone_notification", 3, &"ZM_MINECRAFT_PICKUP_UI", 4, function_Int(var_XP));
			break;
		}
		case 5:
		{
			function_playsoundatposition("halloween_laugh", self.var_origin);
			var_player function_LUINotifyEvent(&"spx_milestone_notification", 2, &"ZM_MINECRAFT_PICKUP_UI", 5);
			break;
		}
		case 6:
		{
			if(function_ToLower(function_GetDvarString("mapname")) != "zm_moon")
			{
				self thread function_916e719a(var_player);
			}
			else
			{
				self thread function_916e719a(var_player);
				break;
			}
		}
		case 7:
		{
			if(function_randomIntRange(0, 100) < 8)
			{
				var_player namespace_zm_perks::function_give_random_perk();
				var_player function_LUINotifyEvent(&"spx_milestone_notification", 2, &"ZM_MINECRAFT_PICKUP_UI", 8);
			}
			else
			{
				self thread function_916e719a(var_player);
				break;
			}
		}
		case 8:
		{
			if(function_randomIntRange(0, 100) < 25)
			{
				self thread function_cc8bb27e(var_player);
				var_player function_LUINotifyEvent(&"spx_milestone_notification", 2, &"ZM_MINECRAFT_PICKUP_UI", 9);
			}
			else
			{
				self thread function_916e719a(var_player);
				break;
			}
		}
		case 9:
		{
			if(level.var_zombie_vars["zombie_powerup_fire_sale_on"] == 1 || level.var_chest_moves < 1 || (isdefined(level.var_disable_firesale_drop) && level.var_disable_firesale_drop) || (isdefined(level.var_c181264f) && level.var_c181264f))
			{
				self thread function_916e719a(var_player);
			}
			else
			{
				self thread function_dig_up_powerup("fire_sale", var_player);
				var_player function_LUINotifyEvent(&"spx_milestone_notification", 2, &"ZM_MINECRAFT_PICKUP_UI", 10);
				break;
			}
		}
		case 10:
		{
			if(function_randomIntRange(0, 100) < 15 && (!(isdefined(function_ed557e20()) && function_ed557e20())))
			{
				function_playsoundatposition("halloween_laugh", self.var_origin);
				function_8824774d(level.var_round_number + 1);
				var_player function_LUINotifyEvent(&"spx_milestone_notification", 2, &"ZM_MINECRAFT_PICKUP_UI", 11);
			}
			else
			{
				self thread function_916e719a(var_player);
				break;
			}
		}
		case 11:
		{
			if(function_randomIntRange(0, 100) < 25)
			{
				self thread function_6f1d3e09();
				var_player function_LUINotifyEvent(&"spx_milestone_notification", 2, &"ZM_MINECRAFT_PICKUP_UI", 12);
			}
			else
			{
				self thread function_916e719a(var_player);
				break;
			}
		}
		case 12:
		{
			function_playsoundatposition("halloween_laugh", self.var_origin);
			self thread function_dig_up_grenade(var_player);
			var_player function_LUINotifyEvent(&"spx_milestone_notification", 2, &"ZM_MINECRAFT_PICKUP_UI", 6);
			break;
		}
		case 13:
		{
			function_playsoundatposition("halloween_laugh", self.var_origin);
			self thread function_7ea6d147();
			var_player function_LUINotifyEvent(&"spx_milestone_notification", 2, &"ZM_MINECRAFT_PICKUP_UI", 6);
			break;
		}
	}
	wait(0.1);
}

/*
	Name: function_7ea6d147
	Namespace: namespace_e483ded
	Checksum: 0x424F4353
	Offset: 0x42C0
	Size: 0x178
	Parameters: 0
	Flags: None
	Line Number: 1251
*/
function function_7ea6d147()
{
	level endon("hash_end_game");
	var_count = 0;
	while(var_count < 10)
	{
		wait(1);
		var_count++;
		foreach(var_zombie in function_GetAITeamArray(level.var_zombie_team))
		{
			var_zombie function_ASMSetAnimationRate(0.3);
		}
	}
	foreach(var_zombie in function_GetAITeamArray(level.var_zombie_team))
	{
		var_zombie function_ASMSetAnimationRate(1);
	}
}

/*
	Name: function_ed557e20
	Namespace: namespace_e483ded
	Checksum: 0x424F4353
	Offset: 0x4440
	Size: 0x98
	Parameters: 0
	Flags: None
	Line Number: 1280
*/
function function_ed557e20()
{
	var_c4fa626b = level.var_round_number + 1;
	if(var_c4fa626b != level.var_n_next_raps_round)
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
	if(var_c4fa626b != level.var_next_wasp_round)
	{
		return 1;
	}
	if(var_c4fa626b != level.var_next_dog_round)
	{
		return 1;
	}
	return 0;
}

/*
	Name: function_6f1d3e09
	Namespace: namespace_e483ded
	Checksum: 0x424F4353
	Offset: 0x44E0
	Size: 0x118
	Parameters: 0
	Flags: None
	Line Number: 1316
*/
function function_6f1d3e09()
{
	var_a_ai = function_GetAIArray();
	for(var_i = 0; var_i < var_a_ai.size; var_i++)
	{
		if(isdefined(var_a_ai[var_i]) && function_isalive(var_a_ai[var_i]) && var_a_ai[var_i].var_archetype === "zombie" && isdefined(var_a_ai[var_i].var_gibdef))
		{
			var_5a3ad5d6 = function_DistanceSquared(self.var_origin, var_a_ai[var_i].var_origin);
			if(var_5a3ad5d6 < 360000)
			{
				var_a_ai[var_i] namespace_zombie_utility::function_makeZombieCrawler();
			}
		}
	}
}

/*
	Name: function_8824774d
	Namespace: namespace_e483ded
	Checksum: 0x424F4353
	Offset: 0x4600
	Size: 0x2E8
	Parameters: 1
	Flags: None
	Line Number: 1342
*/
function function_8824774d(var_target_round)
{
	if(var_target_round < 1)
	{
		var_target_round = 1;
	}
	level.var_zombie_total = 0;
	namespace_zombie_utility::function_ai_calculate_health(var_target_round);
	level.var_round_number = var_target_round - 1;
	level notify("hash_kill_round");
	function_playsoundatposition("zmb_bgb_round_robbin", (0, 0, 0));
	wait(0.1);
	var_zombies = function_GetAITeamArray(level.var_zombie_team);
	for(var_i = 0; var_i < var_zombies.size; var_i++)
	{
		if(isdefined(var_zombies[var_i].var_ignore_round_robbin_death) && var_zombies[var_i].var_ignore_round_robbin_death)
		{
			function_ArrayRemoveValue(var_zombies, var_zombies[var_i]);
		}
	}
	if(isdefined(var_zombies))
	{
		var_e_last = undefined;
		foreach(var_zombie in var_zombies)
		{
			if(function_b10a9b0c(var_zombie))
			{
				var_e_last = var_zombie;
			}
		}
		if(isdefined(var_e_last))
		{
			level.var_last_ai_origin = var_e_last.var_origin;
			level notify("hash_last_ai_down", var_e_last);
		}
	}
	namespace_util::function_wait_network_frame();
	if(isdefined(var_zombies))
	{
		foreach(var_zombie in var_zombies)
		{
			if(!function_b10a9b0c(var_zombie))
			{
				continue;
			}
			var_zombie function_DoDamage(var_zombie.var_health + 666, var_zombie.var_origin);
		}
	}
	level.var_dfd95560 = undefined;
}

/*
	Name: function_b10a9b0c
	Namespace: namespace_e483ded
	Checksum: 0x424F4353
	Offset: 0x48F0
	Size: 0x88
	Parameters: 1
	Flags: None
	Line Number: 1403
*/
function function_b10a9b0c(var_zombie)
{
	if(!isdefined(var_zombie))
	{
		return 0;
	}
	if(isdefined(var_zombie.var_ignore_round_robbin_death) && var_zombie.var_ignore_round_robbin_death || (isdefined(var_zombie.var_marked_for_death) && var_zombie.var_marked_for_death) || namespace_zm_utility::function_is_magic_bullet_shield_enabled(var_zombie))
	{
		return 0;
	}
	return 1;
}

/*
	Name: function_cc8bb27e
	Namespace: namespace_e483ded
	Checksum: 0x424F4353
	Offset: 0x4980
	Size: 0x1D0
	Parameters: 1
	Flags: None
	Line Number: 1426
*/
function function_cc8bb27e(var_player)
{
	var_bd6badee = 1440000;
	var_allai = function_GetAIArray();
	foreach(var_ai in var_allai)
	{
		if(isdefined(var_ai.var_5691b7d8) && var_ai [[var_ai.var_5691b7d8]]())
		{
			continue;
		}
		if(function_Distance2DSquared(var_ai.var_origin, self.var_origin) >= var_bd6badee)
		{
			continue;
		}
		if(function_isalive(var_ai) && !var_ai function_IsPaused() && var_ai.var_team == level.var_zombie_team && var_ai.var_archetype === "zombie" && !var_ai function_ishidden() && (!(isdefined(var_ai.var_85934541) && var_ai.var_85934541)))
		{
			thread function_1bb7ee0(var_ai);
		}
	}
}

/*
	Name: function_1bb7ee0
	Namespace: namespace_e483ded
	Checksum: 0x424F4353
	Offset: 0x4B58
	Size: 0xA8
	Parameters: 1
	Flags: None
	Line Number: 1457
*/
function function_1bb7ee0(var_ai)
{
	var_ai.var_marked_for_death = 1;
	var_ai.var_85934541 = 1;
	var_ai.var_no_powerups = 1;
	var_ai.var_deathpoints_already_given = 1;
	var_ai.var_tesla_head_gib_func = &function_zombie_head_gib;
	var_ai namespace_lightning_chain::function_arc_damage(var_ai, self, 1, level.var_3e825919);
}

/*
	Name: function_zombie_head_gib
	Namespace: namespace_e483ded
	Checksum: 0x424F4353
	Offset: 0x4C08
	Size: 0xB0
	Parameters: 0
	Flags: None
	Line Number: 1477
*/
function function_zombie_head_gib()
{
	self endon("hash_death");
	self namespace_clientfield::function_set("zm_bgb_mind_ray_fx", 1);
	wait(function_RandomFloatRange(0.65, 2.5));
	self namespace_clientfield::function_set("zm_bgb_mind_pop_fx", 1);
	self function_PlaySoundOnTag("zmb_bgb_mindblown_pop", "tag_eye");
	self namespace_zombie_utility::function_zombie_head_gib();
}

/*
	Name: function_9d27c73a
	Namespace: namespace_e483ded
	Checksum: 0x424F4353
	Offset: 0x4CC0
	Size: 0x530
	Parameters: 0
	Flags: None
	Line Number: 1497
*/
function function_9d27c73a()
{
	namespace_zm_utility::function_increment_ignoreme();
	function_playsoundatposition("zmb_bgb_abh_teleport_out", self.var_origin);
	if(isdefined(level.var_2c12d9a6))
	{
		var_68140f76 = self [[level.var_2c12d9a6]]();
	}
	else
	{
		var_68140f76 = self function_728dfe3();
	}
	self function_2cb3d5c8();
	self function_SetVelocity((0, 0, 0));
	self function_SetOrigin(var_68140f76.var_origin);
	self function_FreezeControls(1);
	var_3c5e6535 = self.var_origin + VectorScale((0, 0, 1), 60);
	var_a_ai = function_GetAITeamArray(level.var_zombie_team);
	var_a_closest = [];
	var_ai_closest = undefined;
	if(var_a_ai.size)
	{
		var_a_closest = function_ArraySortClosest(var_a_ai, self.var_origin);
		foreach(var_ai in var_a_closest)
		{
			var_9518d12f = var_ai function_SightConeTrace(var_3c5e6535, self);
			if(var_9518d12f > 0.2)
			{
				var_ai_closest = var_ai;
				break;
			}
		}
		if(isdefined(var_ai_closest))
		{
			self function_SetPlayerAngles(function_VectorToAngles(var_ai_closest function_GetCentroid() - var_3c5e6535));
		}
	}
	self function_playsound("zmb_bgb_abh_teleport_in");
	if(isdefined(level.var_2300a8ad))
	{
		self [[level.var_2300a8ad]]();
	}
	wait(0.5);
	self function_show();
	function_playFX(level.var__effect["teleport_splash"], self.var_origin);
	function_playFX(level.var__effect["teleport_aoe"], self.var_origin);
	var_a_ai = function_GetAIArray();
	var_aca0d7c7 = function_ArraySortClosest(var_a_ai, self.var_origin, var_a_ai.size, 0, 200);
	foreach(var_ai in var_aca0d7c7)
	{
		if(function_IsActor(var_ai))
		{
			if(var_ai.var_archetype === "zombie")
			{
				function_playFX(level.var__effect["teleport_aoe_kill"], var_ai function_GetTagOrigin("j_spineupper"));
			}
			else
			{
				function_playFX(level.var__effect["teleport_aoe_kill"], var_ai.var_origin);
			}
			var_ai.var_marked_for_recycle = 1;
			var_ai.var_has_been_damaged_by_player = 0;
			var_ai function_DoDamage(var_ai.var_health + 1000, self.var_origin, self);
		}
	}
	wait(0.2);
	self function_FreezeControls(0);
	self namespace_zm_stats::function_increment_challenge_stat("GUM_GOBBLER_ANYWHERE_BUT_HERE");
	wait(3);
	namespace_zm_utility::function_decrement_ignoreme();
}

/*
	Name: function_dig_up_grenade
	Namespace: namespace_e483ded
	Checksum: 0x424F4353
	Offset: 0x51F8
	Size: 0x118
	Parameters: 1
	Flags: None
	Line Number: 1579
*/
function function_dig_up_grenade(var_player)
{
	var_player endon("hash_disconnect");
	var_v_spawnpt = self.var_origin;
	var_w_grenade = function_GetWeapon("frag_grenade");
	var_n_rand = function_randomIntRange(0, 4);
	var_player function_MagicGrenadeType(var_w_grenade, var_v_spawnpt, VectorScale((0, 0, 1), 300), 3);
	var_player function_playsound("evt_grenade_digup");
	if(var_n_rand)
	{
		wait(0.3);
		if(namespace_math::function_cointoss())
		{
			var_player function_MagicGrenadeType(var_w_grenade, var_v_spawnpt, (50, 50, 300), 3);
			return;
		}
	}
	ERROR: Bad function call
}

/*
	Name: function_dig_up_weapon
	Namespace: namespace_e483ded
	Checksum: 0x424F4353
	Offset: 0x5318
	Size: 0x4C0
	Parameters: 1
	Flags: None
	Line Number: 1609
*/
function function_dig_up_weapon(var_digger)
{
	var_43f586fe = function_Array(function_GetWeapon("pistol_standard"), function_GetWeapon("ar_marksman"), function_GetWeapon("shotgun_pump"));
	var_63eba41d = function_Array(function_GetWeapon("sniper_fastsemi"), function_GetWeapon("shotgun_fullauto"));
	if(var_digger.var_pers["halloween_pumpkin_hat"])
	{
		var_63eba41d = function_ArrayCombine(var_63eba41d, function_Array(function_GetWeapon("ar_galil"), function_GetWeapon("smg_standard"), function_GetWeapon("smg_mp40_1940"), function_GetWeapon("shotgun_precision")), 0, 0);
	}
	var_59d5868d = undefined;
	if(function_RandomInt(100) < 90)
	{
		var_59d5868d = var_43f586fe[function_getArrayKeys(var_43f586fe)[function_RandomInt(function_getArrayKeys(var_43f586fe).size)]];
	}
	else
	{
		var_59d5868d = var_63eba41d[function_getArrayKeys(var_63eba41d)[function_RandomInt(function_getArrayKeys(var_63eba41d).size)]];
	}
	var_v_spawnpt = self.var_origin + VectorScale((0, 0, 1), 10);
	var_v_spawnang = (0, 0, 0);
	var_v_angles = var_digger function_getPlayerAngles();
	var_v_angles = (0, var_v_angles[1], 0) + VectorScale((0, 1, 0), 90) + var_v_spawnang;
	var_m_weapon = namespace_zm_utility::function_spawn_buildkit_weapon_model(var_digger, var_59d5868d, undefined, var_v_spawnpt, var_v_angles);
	var_m_weapon.var_angles = var_v_angles;
	var_m_weapon function_PlayLoopSound("evt_weapon_digup");
	var_m_weapon thread function_timer_til_despawn(var_v_spawnpt, -40);
	var_m_weapon endon("hash_dig_up_weapon_timed_out");
	function_PlayFXOnTag(level.var__effect["powerup_on_solo"], var_m_weapon, "tag_origin");
	var_m_weapon.var_trigger = function_tomb_spawn_trigger_radius(var_v_spawnpt, 100, 1, undefined, &function_3674f451);
	var_m_weapon.var_trigger.var_cursor_hint = "HINT_WEAPON";
	var_m_weapon.var_trigger.var_cursor_hint_weapon = var_59d5868d;
	var_m_weapon.var_trigger waittill("hash_trigger", var_player);
	var_m_weapon.var_trigger notify("hash_weapon_grabbed");
	var_m_weapon.var_trigger thread function_swap_weapon(var_59d5868d, var_player);
	if(isdefined(var_m_weapon.var_trigger))
	{
		namespace_zm_unitrigger::function_unregister_unitrigger(var_m_weapon.var_trigger);
		var_m_weapon.var_trigger = undefined;
	}
	if(isdefined(var_m_weapon))
	{
		var_m_weapon function_delete();
	}
	if(var_player != var_digger)
	{
		var_digger notify("hash_dig_up_weapon_shared");
	}
}

/*
	Name: function_tomb_spawn_trigger_radius
	Namespace: namespace_e483ded
	Checksum: 0x424F4353
	Offset: 0x57E0
	Size: 0x148
	Parameters: 5
	Flags: None
	Line Number: 1667
*/
function function_tomb_spawn_trigger_radius(var_origin, var_radius, var_use_trigger, var_3fe858d9, var_2d6ca912)
{
	if(!isdefined(var_use_trigger))
	{
		var_use_trigger = 0;
	}
	var_trigger_stub = function_spawnstruct();
	var_trigger_stub.var_origin = var_origin;
	var_trigger_stub.var_radius = var_radius;
	if(var_use_trigger)
	{
		var_trigger_stub.var_cursor_hint = "HINT_NOICON";
		var_trigger_stub.var_script_unitrigger_type = "unitrigger_radius_use";
	}
	else
	{
		var_trigger_stub.var_script_unitrigger_type = "unitrigger_radius";
	}
	if(isdefined(var_3fe858d9))
	{
		var_trigger_stub.var_func_update_msg = var_3fe858d9;
		namespace_zm_unitrigger::function_unitrigger_force_per_player_triggers(var_trigger_stub, 1);
	}
	if(isdefined(var_2d6ca912))
	{
		var_trigger_stub.var_prompt_and_visibility_func = var_2d6ca912;
	}
	namespace_zm_unitrigger::function_register_unitrigger(var_trigger_stub, &function_tomb_unitrigger_think);
	return var_trigger_stub;
}

/*
	Name: function_tomb_unitrigger_think
	Namespace: namespace_e483ded
	Checksum: 0x424F4353
	Offset: 0x5930
	Size: 0x88
	Parameters: 0
	Flags: None
	Line Number: 1708
*/
function function_tomb_unitrigger_think()
{
	self endon("hash_kill_trigger");
	if(isdefined(self.var_stub.var_func_update_msg))
	{
		self thread function_tomb_trigger_update_message(self.var_stub.var_func_update_msg);
	}
	while(1)
	{
		self waittill("hash_trigger", var_player);
		self.var_stub notify("hash_trigger", var_player);
	}
}

/*
	Name: function_tomb_trigger_update_message
	Namespace: namespace_e483ded
	Checksum: 0x424F4353
	Offset: 0x59C0
	Size: 0x148
	Parameters: 1
	Flags: None
	Line Number: 1732
*/
function function_tomb_trigger_update_message(var_func_per_player_msg)
{
	var_a_players = function_GetPlayers();
	foreach(var_e_player in var_a_players)
	{
		var_n_player = var_e_player function_GetEntityNumber();
		if(!isdefined(self.var_stub.var_playertrigger[var_n_player]))
		{
			continue;
		}
		var_new_msg = self [[var_func_per_player_msg]](var_e_player);
		self.var_stub.var_playertrigger[var_n_player].var_stored_hint_string = var_new_msg;
		self.var_stub.var_playertrigger[var_n_player] function_setHintString(var_new_msg);
	}
	return;
	ERROR: Exception occured: Stack empty.
}

/*
	Name: function_3674f451
	Namespace: namespace_e483ded
	Checksum: 0x424F4353
	Offset: 0x5B10
	Size: 0xD0
	Parameters: 1
	Flags: None
	Line Number: 1760
*/
function function_3674f451(var_player)
{
	if(!namespace_zm_utility::function_is_player_valid(var_player) || var_player.var_IS_DRINKING > 0 || !var_player namespace_zm_magicbox::function_can_buy_weapon() || var_player function_GetCurrentWeapon() == level.var_zombie_powerup_weapon["minigun"])
	{
		self function_setcursorhint("HINT_NOICON");
		return 0;
	}
	self function_setcursorhint("HINT_WEAPON", self.var_stub.var_cursor_hint_weapon);
	return 1;
}

/*
	Name: function_swap_weapon
	Namespace: namespace_e483ded
	Checksum: 0x424F4353
	Offset: 0x5BE8
	Size: 0x240
	Parameters: 2
	Flags: None
	Line Number: 1781
*/
function function_swap_weapon(var_375664a9, var_e_player)
{
	var_1bcd223d = var_e_player function_GetCurrentWeapon();
	if(!namespace_zombie_utility::function_is_player_valid(var_e_player) || (isdefined(var_e_player.var_IS_DRINKING) && var_e_player.var_IS_DRINKING) || namespace_zm_utility::function_is_placeable_mine(var_1bcd223d) || namespace_zm_equipment::function_is_equipment(var_1bcd223d) || var_1bcd223d == function_GetWeapon("none") || var_e_player namespace_zm_equipment::function_hacker_active() || var_1bcd223d == level.var_zombie_powerup_weapon["minigun"])
	{
		return;
	}
	if(isdefined(level.var_revive_tool) && level.var_revive_tool == var_1bcd223d)
	{
		return;
	}
	var_6c6831af = var_e_player function_GetWeaponsList(1);
	foreach(var_weapon in var_6c6831af)
	{
		var_w_base = namespace_zm_weapons::function_get_base_weapon(var_weapon);
		var_7321b53b = namespace_zm_weapons::function_get_upgrade_weapon(var_weapon);
		if(var_375664a9 === var_w_base || var_375664a9 === var_7321b53b)
		{
			var_e_player function_giveMaxAmmo(var_weapon);
			return;
		}
	}
	var_e_player namespace_zm_weapons::function_weapon_give(var_375664a9);
	return;
	continue;
}

/*
	Name: function_timer_til_despawn
	Namespace: namespace_e483ded
	Checksum: 0x424F4353
	Offset: 0x5E30
	Size: 0xC8
	Parameters: 2
	Flags: None
	Line Number: 1818
*/
function function_timer_til_despawn(var_v_float, var_n_dist)
{
	self endon("hash_weapon_grabbed");
	var_putBackTime = 12;
	self function_MoveZ(var_n_dist, var_putBackTime, var_putBackTime * 0.5);
	self waittill("hash_movedone");
	self notify("hash_dig_up_weapon_timed_out");
	if(isdefined(self.var_trigger))
	{
		namespace_zm_unitrigger::function_unregister_unitrigger(self.var_trigger);
		self.var_trigger = undefined;
	}
	if(isdefined(self))
	{
		self function_delete();
		return;
	}
	ERROR: Exception occured: Stack empty.
}

/*
	Name: function_dig_up_powerup
	Namespace: namespace_e483ded
	Checksum: 0x424F4353
	Offset: 0x5F00
	Size: 0x140
	Parameters: 2
	Flags: None
	Line Number: 1848
*/
function function_dig_up_powerup(var_32f5f718, var_player)
{
	if(!isdefined(var_32f5f718))
	{
		var_32f5f718 = undefined;
	}
	var_powerup = function_spawn("script_model", self.var_origin);
	var_powerup endon("hash_powerup_grabbed");
	var_powerup endon("hash_powerup_timedout");
	if(isdefined(var_32f5f718))
	{
		var_powerup_item = var_32f5f718;
	}
	else
	{
		var_a_rare_powerups = function_dig_get_rare_powerups(var_player);
		var_powerup_item = var_a_rare_powerups[function_RandomInt(var_a_rare_powerups.size)];
	}
	var_powerup namespace_zm_powerups::function_powerup_setup(var_powerup_item);
	wait(0.2);
	var_powerup thread namespace_zm_powerups::function_powerup_timeout();
	var_powerup thread namespace_zm_powerups::function_powerup_wobble();
	var_powerup thread namespace_zm_powerups::function_powerup_grab();
	return;
}

/*
	Name: function_dig_get_rare_powerups
	Namespace: namespace_e483ded
	Checksum: 0x424F4353
	Offset: 0x6048
	Size: 0x130
	Parameters: 1
	Flags: None
	Line Number: 1884
*/
function function_dig_get_rare_powerups(var_player)
{
	var_a_rare_powerups = [];
	var_a_possible_powerups = function_Array("nuke", "minigun", "insta_kill");
	if(var_player.var_pers["halloween_pumpkin_hat"])
	{
		var_a_possible_powerups = function_ArrayCombine(var_a_possible_powerups, function_Array("full_ammo", "xp_drop", "double_points"), 0, 0);
	}
	foreach(var_powerup in var_a_possible_powerups)
	{
		var_a_rare_powerups[var_a_rare_powerups.size] = var_powerup;
	}
	return var_a_rare_powerups;
}

/*
	Name: function_dig_has_powerup_spawned
	Namespace: namespace_e483ded
	Checksum: 0x424F4353
	Offset: 0x6180
	Size: 0x40
	Parameters: 1
	Flags: None
	Line Number: 1909
*/
function function_dig_has_powerup_spawned(var_str_powerup)
{
	if(!isdefined(level.var_dig_powerups_tracking[var_str_powerup]))
	{
		level.var_dig_powerups_tracking[var_str_powerup] = 0;
	}
	return level.var_dig_powerups_tracking[var_str_powerup];
}

/*
	Name: function_2da76386
	Namespace: namespace_e483ded
	Checksum: 0x424F4353
	Offset: 0x61C8
	Size: 0x130
	Parameters: 0
	Flags: Private
	Line Number: 1928
*/
function private function_2da76386()
{
	self endon("hash_death");
	if(!isdefined(self.var_completed_emerging_into_playable_area))
	{
		self namespace_util::function_waittill_any("completed_emerging_into_playable_area", "death");
	}
	if(function_isalive(self))
	{
		while(function_isalive(self))
		{
			if(isdefined(level.var_b83ee546) && level.var_b83ee546)
			{
				if(!(isdefined(self.var_a5b49611) && self.var_a5b49611))
				{
					self.var_a5b49611 = 1;
				}
				if(isdefined(self.var_a5b49611) && self.var_a5b49611)
				{
					self function_ASMSetAnimationRate(1.1);
				}
			}
			else if(isdefined(self.var_a5b49611) && self.var_a5b49611)
			{
				self function_ASMSetAnimationRate(1);
				self.var_a5b49611 = 0;
			}
			wait(3);
		}
	}
}

/*
	Name: function_bdbcaf72
	Namespace: namespace_e483ded
	Checksum: 0x424F4353
	Offset: 0x6300
	Size: 0x8
	Parameters: 0
	Flags: None
	Line Number: 1970
*/
function function_bdbcaf72()
{
}

/*
	Name: function_763e8450
	Namespace: namespace_e483ded
	Checksum: 0x424F4353
	Offset: 0x6310
	Size: 0x268
	Parameters: 0
	Flags: Private
	Line Number: 1984
*/
function private function_763e8450()
{
	self endon("hash_death");
	if(level.var_round_number < 35)
	{
	}
	else if(function_randomIntRange(1, 100) < 13 && self.var_archetype == "zombie" && (!(isdefined(self.var_4116bb49) && self.var_4116bb49)) && !level namespace_flag::function_get("disable_armored_zombies"))
	{
		namespace_AiUtility::function_AddAIOverrideDamageCallback(self, &function_614b2a7b);
		self.var_fc3ab987 = 1;
		self.var_team = level.var_zombie_team;
		self.var_noCrawler = 1;
		if(level.var_round_number >= 30 && function_randomIntRange(1, 100) <= 10 && 1)
		{
			self.var_2a280bef = 1;
		}
		wait(1);
		if(isdefined(self.var_2a280bef) && self.var_2a280bef)
		{
			self.var_health = level.var_zombie_health * 8.5;
		}
		else
		{
			self.var_health = level.var_zombie_health * 4.5;
		}
		self.var_maxhealth = self.var_health;
		self function_Attach("zmu_armor_helmet", "j_head");
		self.var_29bc72fa = function_spawnstruct();
		self.var_29bc72fa.var_health = self.var_health * 0.7;
		self function_Attach("zmu_armor_vest", "j_spine4");
		self.var_4b42e223 = function_spawnstruct();
		self.var_4b42e223.var_health = self.var_health * 0.8;
	}
}

/*
	Name: function_614b2a7b
	Namespace: namespace_e483ded
	Checksum: 0x424F4353
	Offset: 0x6580
	Size: 0x4E8
	Parameters: 12
	Flags: None
	Line Number: 2029
*/
function function_614b2a7b(var_inflictor, var_attacker, var_damage, var_dFlags, var_mod, var_weapon, var_point, var_dir, var_hitLoc, var_offsetTime, var_boneIndex, var_modelIndex)
{
	if(var_hitLoc == "head" || var_hitLoc == "helmet" && self.var_29bc72fa && self.var_29bc72fa.var_health > 0)
	{
		self.var_29bc72fa.var_health = self.var_29bc72fa.var_health - var_damage * 0.6;
		if(self.var_29bc72fa.var_health <= 0)
		{
			var_attacker namespace_zm_score::function_add_to_player_score(25);
			self function_Detach("zmu_armor_helmet", "j_head");
			self.var_29bc72fa function_delete();
			function_PlayFXOnTag(level.var__effect["armored_zombie_break"], self, "j_head");
		}
		if(isdefined(var_weapon.var_is_wonder_weapon) && var_weapon.var_is_wonder_weapon || namespace_Array::function_contains(level.var_e33eb0d5, var_weapon.var_name) || (isdefined(var_attacker.var_afterlife) && var_attacker.var_afterlife) || function_IsSubStr(self.var_damageWeapon.var_name, "t6_bouncing_tomahawk") || function_IsSubStr(self.var_damageWeapon.var_name, "t6_upgraded_tomahawk"))
		{
			return var_damage;
		}
		else
		{
			return var_damage * 0.5;
		}
	}
	else if(var_hitLoc == "torso_upper" || var_hitLoc == "torso_lower" && self.var_4b42e223 && self.var_4b42e223.var_health > 0)
	{
		self.var_4b42e223.var_health = self.var_4b42e223.var_health - var_damage * 0.7;
		if(self.var_4b42e223.var_health <= 0)
		{
			var_attacker namespace_zm_score::function_add_to_player_score(25);
			self function_Detach("zmu_armor_vest", "j_spine4");
			self.var_4b42e223 function_delete();
			function_PlayFXOnTag(level.var__effect["armored_zombie_break"], self, "j_spine4");
		}
		if(isdefined(var_weapon.var_is_wonder_weapon) && var_weapon.var_is_wonder_weapon || namespace_Array::function_contains(level.var_e33eb0d5, var_weapon.var_name) || (isdefined(var_attacker.var_afterlife) && var_attacker.var_afterlife) || function_IsSubStr(self.var_damageWeapon.var_name, "t6_bouncing_tomahawk") || function_IsSubStr(self.var_damageWeapon.var_name, "t6_upgraded_tomahawk"))
		{
			return var_damage;
		}
		else
		{
			return var_damage * 0.4;
		}
	}
	if(isdefined(self.var_4b42e223) && isdefined(self.var_29bc72fa))
	{
		if(isdefined(var_weapon.var_is_wonder_weapon) && var_weapon.var_is_wonder_weapon || namespace_Array::function_contains(level.var_e33eb0d5, var_weapon.var_name))
		{
			return var_damage;
		}
		else
		{
			return var_damage * 0.5;
		}
	}
	else
	{
		return var_damage;
	}
}

/*
	Name: function_cf7b8e86
	Namespace: namespace_e483ded
	Checksum: 0x424F4353
	Offset: 0x6A70
	Size: 0x168
	Parameters: 4
	Flags: None
	Line Number: 2096
*/
function function_cf7b8e86(var_attacker, var_damage, var_type, var_location)
{
	if(var_location == "head" || var_location == "helmet")
	{
		if(isdefined(self.var_29bc72fa))
		{
			self thread namespace_5e1f56dc::function_d2b0307(var_attacker, var_damage, var_type, undefined, 1, 1);
			var_attacker namespace_zm_score::function_add_to_player_score(25);
			self function_Detach("zmu_armor_helmet", "j_head");
			self.var_29bc72fa function_delete();
			return;
		}
	}
	if(isdefined(self.var_4b42e223))
	{
		self thread namespace_5e1f56dc::function_d2b0307(var_attacker, var_damage, var_type, undefined, 1, 1);
		var_attacker namespace_zm_score::function_add_to_player_score(25);
		self function_Detach("zmu_armor_vest", "j_spine4");
		self.var_4b42e223 function_delete();
	}
}

/*
	Name: function_728dfe3
	Namespace: namespace_e483ded
	Checksum: 0x424F4353
	Offset: 0x6BE0
	Size: 0x2F0
	Parameters: 0
	Flags: None
	Line Number: 2128
*/
function function_728dfe3()
{
	var_a6abcc5d = namespace_zm_zonemgr::function_get_zone_from_position(self.var_origin + VectorScale((0, 0, 1), 32), 0);
	if(!isdefined(var_a6abcc5d))
	{
		var_a6abcc5d = self.var_zone_name;
	}
	if(isdefined(var_a6abcc5d))
	{
		var_c30975d2 = level.var_zones[var_a6abcc5d];
	}
	var_97786609 = namespace_struct::function_get_array("player_respawn_point", "targetname");
	var_bbf77908 = [];
	foreach(var_68140f76 in var_97786609)
	{
		if(namespace_zm_utility::function_is_point_inside_enabled_zone(var_68140f76.var_origin, var_c30975d2))
		{
			if(!isdefined(var_bbf77908))
			{
				var_bbf77908 = [];
			}
			else if(!function_IsArray(var_bbf77908))
			{
				var_bbf77908 = function_Array(var_bbf77908);
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
		var_90551969 = namespace_Array::function_random(var_bbf77908);
		var_46b9bbf8 = namespace_struct::function_get_array(var_90551969.var_target, "targetname");
		foreach(var_dbd59eb2 in var_46b9bbf8)
		{
			var_n_script_int = self function_GetEntityNumber() + 1;
			if(var_dbd59eb2.var_script_int === var_n_script_int)
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
	Offset: 0x6ED8
	Size: 0xC8
	Parameters: 1
	Flags: None
	Line Number: 2187
*/
function function_232fd7a0(var_34d37a48)
{
	function_8b57c052("spawn_elemental", "");
	for(;;)
	{
		wait(0.05);
		var_dvar_value = function_ToLower(function_GetDvarString("spawn_elemental", ""));
		if(isdefined(var_dvar_value) && var_dvar_value != "")
		{
			function_8b57c052("spawn_elemental", "");
			level thread function_ede843e2(var_dvar_value);
		}
	}
}

/*
	Name: function_ede843e2
	Namespace: namespace_e483ded
	Checksum: 0x424F4353
	Offset: 0x6FA8
	Size: 0x74
	Parameters: 1
	Flags: None
	Line Number: 2212
*/
function function_ede843e2(var_dvar_value)
{
	var_spawner = namespace_Array::function_random(level.var_zombie_spawners);
	var_zombie = namespace_zombie_utility::function_spawn_zombie(var_spawner);
	wait(0.05);
	var_zombie thread function_e4e397d9(var_dvar_value);
}

