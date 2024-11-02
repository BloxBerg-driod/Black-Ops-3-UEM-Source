#include scripts\codescripts\struct;
#include scripts\shared\ai\systems\gib;
#include scripts\shared\ai\zombie_death;
#include scripts\shared\ai\zombie_utility;
#include scripts\shared\ai_shared;
#include scripts\shared\array_shared;
#include scripts\shared\callbacks_shared;
#include scripts\shared\clientfield_shared;
#include scripts\shared\laststand_shared;
#include scripts\shared\math_shared;
#include scripts\shared\scene_shared;
#include scripts\shared\system_shared;
#include scripts\shared\util_shared;
#include scripts\shared\weapons\_weaponobjects;
#include scripts\zm\_util;
#include scripts\zm\_zm;
#include scripts\zm\_zm_audio;
#include scripts\zm\_zm_equipment;
#include scripts\zm\_zm_laststand;
#include scripts\zm\_zm_lightning_chain;
#include scripts\zm\_zm_spawner;
#include scripts\zm\_zm_stats;
#include scripts\zm\_zm_unitrigger;
#include scripts\zm\_zm_utility;
#include scripts\zm\_zm_weapon_upgrade_system;
#include scripts\zm\_zm_weapons;

#namespace namespace_61461ca0;

/*
	Name: __init__sytem__
	Namespace: namespace_61461ca0
	Checksum: 0x424F4353
	Offset: 0x628
	Size: 0x38
	Parameters: 0
	Flags: AutoExec
	Line Number: 39
*/
function autoexec __init__sytem__()
{
	system::register("zm_weap_changes", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: namespace_61461ca0
	Checksum: 0x424F4353
	Offset: 0x668
	Size: 0x8
	Parameters: 0
	Flags: None
	Line Number: 54
*/
function __init__()
{
}

/*
	Name: on_player_connect
	Namespace: namespace_61461ca0
	Checksum: 0x424F4353
	Offset: 0x678
	Size: 0x70
	Parameters: 0
	Flags: None
	Line Number: 68
*/
function on_player_connect()
{
	self thread function_31df6805();
	self thread function_c361c061("ray_gun_elemental");
	self thread function_7418fa1a("ray_gun_elemental", "ray_gun_elemental_1", "ray_gun_elemental_2");
}

/*
	Name: on_player_spawned
	Namespace: namespace_61461ca0
	Checksum: 0x424F4353
	Offset: 0x6F0
	Size: 0x8
	Parameters: 0
	Flags: None
	Line Number: 85
*/
function on_player_spawned()
{
	return;
	ERROR: Bad function call
}

/*
	Name: function_7418fa1a
	Namespace: namespace_61461ca0
	Checksum: 0x424F4353
	Offset: 0x700
	Size: 0x1D0
	Parameters: 3
	Flags: None
	Line Number: 101
*/
function function_7418fa1a(var_8478c26e, var_f599c2cc, var_e38d48a9)
{
	self endon("death");
	while(1)
	{
		self waittill("projectile_impact", w_weapon, v_position, n_radius, e_projectile, v_normal);
		if(w_weapon.name == var_8478c26e || w_weapon.name == var_f599c2cc || w_weapon.name == var_e38d48a9)
		{
			if(w_weapon.name == var_8478c26e || w_weapon.name == var_f599c2cc)
			{
				if(isdefined(e_projectile))
				{
					playfxontag(level._effect["quantum_raygun_explode"], e_projectile, "tag_origin");
				}
				radiusdamage(v_position, 128, level.zombie_health, level.zombie_health, self, "MOD_UNKNOWN", w_weapon);
			}
			else
			{
				pos = zm_utility::GROUNDPOS(v_position.origin) + VectorScale((0, 0, 1), 8);
				self thread function_120ea33f(w_weapon, v_position, pos, n_radius, e_projectile, v_normal);
			}
		}
	}
}

/*
	Name: function_120ea33f
	Namespace: namespace_61461ca0
	Checksum: 0x424F4353
	Offset: 0x8D8
	Size: 0x248
	Parameters: 6
	Flags: None
	Line Number: 136
*/
function function_120ea33f(w_weapon, v_pos, v_pos_final, n_radius, e_projectile, v_normal)
{
	self endon("disconnect");
	util::wait_network_frame();
	model = util::spawn_model("tag_origin", e_projectile.origin, (0, 0, 0));
	util::wait_network_frame();
	if(isdefined(model))
	{
		valid_poi = zm_utility::check_point_in_enabled_zone(model.origin, undefined, undefined);
		valid_poi = model move_valid_poi_to_navmesh(valid_poi);
		valid_poi = model [[level.check_valid_poi]](valid_poi);
		if(valid_poi)
		{
			var_691d0760 = util::spawn_model("tag_origin", model.origin + VectorScale((0, 0, 1), 50), model.angles);
			var_691d0760 = playfxontag(level._effect["quantum_raygun_blackhole_loop"], var_691d0760, "tag_origin");
			wait(0.5);
			model thread function_e3372167(self, w_weapon);
			if(isdefined(var_691d0760))
			{
				var_691d0760 delete();
			}
		}
	}
	else
	{
		model.script_noteworthy = undefined;
		playfxontag(level._effect["grenade_samantha_steal"], model, "tag_origin");
		if(isdefined(model))
		{
			model delete();
		}
	}
}

/*
	Name: function_e3372167
	Namespace: namespace_61461ca0
	Checksum: 0x424F4353
	Offset: 0xB28
	Size: 0x490
	Parameters: 2
	Flags: None
	Line Number: 180
*/
function function_e3372167(owner, w_weapon)
{
	if(!isdefined(self))
	{
		return;
	}
	self stoploopsound(0.05);
	self playsound("crossbow_blast_pre_explosion");
	var_5cb0b0e8 = util::spawn_model("tag_origin", self.origin + VectorScale((0, 0, 1), 50), self.angles);
	var_5cb0b0e8 = playfxontag(level._effect["quantum_raygun_blackhole_sm"], var_5cb0b0e8, "tag_origin");
	wait(0.6);
	if(isdefined(var_5cb0b0e8))
	{
		var_5cb0b0e8 delete();
	}
	var_441797b1 = util::spawn_model("tag_origin", self.origin + VectorScale((0, 0, 1), 50), self.angles);
	var_441797b1 = playfxontag(level._effect["quantum_raygun_blackhole_explode"], var_441797b1, "tag_origin");
	self playsound("crossbow_blast_main");
	wait(0.05);
	self hide();
	if(w_weapon.name == "ray_gun_elemental_2_upgraded")
	{
		var_480fed80 = owner namespace_5e1f56dc::function_1239e0ad(w_weapon);
		if(isdefined(var_480fed80))
		{
			if(var_480fed80.var_a39a2843 >= 1)
			{
				max_zombies = 12 + 2 * var_480fed80.var_a39a2843;
			}
		}
		else
		{
			max_zombies = 12;
		}
	}
	else
	{
		max_zombies = 10;
	}
	zombies = array::get_all_closest(self.origin, getaiteamarray(level.zombie_team), undefined, undefined, 240);
	for(i = 0; i < max_zombies; i++)
	{
		if(!isdefined(zombies[i]) || !isalive(zombies[i]))
		{
			continue;
		}
		dist_sq = distancesquared(self.origin, zombies[i].origin);
		if(w_weapon.name == "ray_gun_elemental_2_upgraded")
		{
			if(dist_sq < 193600)
			{
				owner thread function_8d5b17df(zombies[i], w_weapon);
				continue;
			}
			if(dist_sq > 193600)
			{
				continue;
			}
		}
		else if(dist_sq < 90000)
		{
			owner thread function_8d5b17df(zombies[i], w_weapon);
			continue;
		}
		if(dist_sq > 90000)
		{
			continue;
		}
		if(0 == zombies[i] damageconetrace(self.origin, self))
		{
			continue;
		}
		owner thread function_8d5b17df(zombies[i], w_weapon);
	}
	if(isdefined(var_441797b1))
	{
		var_441797b1 delete();
	}
	self delete();
}

/*
	Name: function_8d5b17df
	Namespace: namespace_61461ca0
	Checksum: 0x424F4353
	Offset: 0xFC0
	Size: 0x68
	Parameters: 2
	Flags: None
	Line Number: 271
*/
function function_8d5b17df(ai, w_weapon)
{
	self endon("disconnect");
	if(!isdefined(ai) || !isalive(ai))
	{
		return;
	}
	ai thread function_a541545(self, w_weapon);
}

/*
	Name: function_a541545
	Namespace: namespace_61461ca0
	Checksum: 0x424F4353
	Offset: 0x1030
	Size: 0x220
	Parameters: 2
	Flags: None
	Line Number: 291
*/
function function_a541545(player, w_weapon)
{
	self endon("death");
	player thread zm_audio::create_and_play_dialog("kill", "sword_slam");
	wait(0.05);
	if(w_weapon.name == "ray_gun_elemental_2_upgraded")
	{
		n_damage = namespace_5e1f56dc::function_bcb41215(undefined, player, 1140, undefined, undefined, w_weapon);
		if(n_damage > self.health)
		{
			playfxontag(level._effect["crossbow_skull_zombie_explode"], self, "j_head");
			if(isdefined(self) && IsActor(self))
			{
				gibserverutils::gibhead(self);
			}
		}
		self dodamage(n_damage, self.origin, player, undefined, "none", "MOD_EXPLOSIVE", 0, w_weapon);
	}
	else
	{
		n_damage = namespace_5e1f56dc::function_bcb41215(undefined, player, 800, undefined, undefined, w_weapon);
		if(n_damage > self.health)
		{
			playfxontag(level._effect["crossbow_skull_zombie_explode"], self, "j_head");
			if(isdefined(self) && IsActor(self))
			{
				gibserverutils::gibhead(self);
			}
		}
		self dodamage(n_damage, self.origin, player, undefined, "none", "MOD_EXPLOSIVE", 0, w_weapon);
		return;
	}
	ERROR: Exception occured: Stack empty.
}

/*
	Name: function_862aadab
	Namespace: namespace_61461ca0
	Checksum: 0x424F4353
	Offset: 0x1258
	Size: 0x150
	Parameters: 1
	Flags: None
	Line Number: 336
*/
function function_862aadab(random_gibs)
{
	if(isdefined(self) && IsActor(self))
	{
		if(!random_gibs || randomint(100) < 50)
		{
			gibserverutils::gibhead(self);
			return 1;
		}
		if(!random_gibs || randomint(100) < 50)
		{
			gibserverutils::gibleftarm(self);
			return 0;
		}
		if(!random_gibs || randomint(100) < 50)
		{
			gibserverutils::gibrightarm(self);
			return 0;
		}
		if(!random_gibs || randomint(100) < 50)
		{
			gibserverutils::giblegs(self);
			return 0;
		}
		return 0;
	}
	return 0;
}

/*
	Name: function_83f44f5
	Namespace: namespace_61461ca0
	Checksum: 0x424F4353
	Offset: 0x13B0
	Size: 0x98
	Parameters: 2
	Flags: None
	Line Number: 375
*/
function function_83f44f5(ai_enemy, var_289e02fc)
{
	return isalive(ai_enemy) && (!(isdefined(ai_enemy.var_98056717) && ai_enemy.var_98056717)) && bullettracepassed(ai_enemy getcentroid(), var_289e02fc + VectorScale((0, 0, 1), 48), 0, undefined);
}

/*
	Name: function_c361c061
	Namespace: namespace_61461ca0
	Checksum: 0x424F4353
	Offset: 0x1450
	Size: 0x190
	Parameters: 1
	Flags: None
	Line Number: 390
*/
function function_c361c061(w_weapon)
{
	self endon("death");
	var_6b9db46d = getweapon(w_weapon);
	while(1)
	{
		self waittill("weapon_change", var_9f85aad5, prev_weapon);
		if(var_9f85aad5 == var_6b9db46d)
		{
			if(!(isdefined(self.var_cea033bb) && self.var_cea033bb))
			{
				if(isdefined(self.hintelem))
				{
					self.hintelem settext("");
					self.hintelem destroy();
				}
				if(self issplitscreen())
				{
					self thread zm_equipment::show_hint_text("Press ^3[{+attack}]^7 to shoot\nHold ^3[{+attack}]^7 to shoot a charged shot\nCharged shots use extra ammo", 8, 1, 150);
				}
				else
				{
					self thread zm_equipment::show_hint_text("Press ^3[{+attack}]^7 to shoot\nHold ^3[{+attack}]^7 to shoot a charged shot\nCharged shots use extra ammo", 8);
				}
				self.var_cea033bb = 1;
			}
			self util::waittill_any_timeout(1, "weapon_change_complete", "death");
		}
		else
		{
		}
	}
}

/*
	Name: function_c73ca1b9
	Namespace: namespace_61461ca0
	Checksum: 0x424F4353
	Offset: 0x15E8
	Size: 0x2F8
	Parameters: 1
	Flags: None
	Line Number: 434
*/
function function_c73ca1b9(w_weapon)
{
	self endon("death");
	var_6b9db46d = getweapon(w_weapon);
	for(;;)
	{
		current_weapon = self getcurrentweapon();
		while(self playerads() && issubstr(var_6b9db46d.name, current_weapon.name) && self getweaponammoclip(current_weapon) != current_weapon.clipsize)
		{
			var_480fed80 = self namespace_5e1f56dc::function_1239e0ad(current_weapon);
			if(isdefined(var_480fed80))
			{
				if(var_480fed80.var_a39a2843 >= 1)
				{
					max_zombies = 5 + 1 * var_480fed80.var_a39a2843;
				}
			}
			else
			{
				max_zombies = 5;
			}
			zombies = array::get_all_closest(self.origin, getaiteamarray(level.zombie_team), undefined, undefined, 300);
			if(zombies.size > 0)
			{
				for(i = 0; i < max_zombies; i++)
				{
					if(util::within_fov(self.origin, self.angles, zombies[i].origin + (0, 0, self.origin[2] - zombies[i].origin[2]), cos(30)))
					{
						var_45fe5452 = zombies[i] thread function_7c3b456a(self, var_6b9db46d, var_480fed80.var_a39a2843);
					}
				}
				if(isdefined(var_45fe5452) && var_45fe5452)
				{
					playfxontag(level._effect["quantum_raygun_sucking"], current_weapon, "tag_flash");
					self setweaponammoclip(current_weapon, self getweaponammoclip(current_weapon) + 1);
				}
			}
			wait(1);
		}
		wait(1);
	}
}

/*
	Name: function_7c3b456a
	Namespace: namespace_61461ca0
	Checksum: 0x424F4353
	Offset: 0x18E8
	Size: 0x280
	Parameters: 3
	Flags: None
	Line Number: 487
*/
function function_7c3b456a(e_player, w_weapon, var_a39a2843)
{
	if(isalive(self))
	{
		if(isdefined(var_a39a2843))
		{
			switch(var_a39a2843)
			{
				case 1:
				case 2:
				case 3:
				{
					self asmsetanimationrate(0.9);
					self dodamage(self.maxhealth / 5, self.origin, e_player, e_player, undefined, "MOD_PROJECTILE_SPLASH", 0, w_weapon);
					break;
				}
				case 4:
				case 5:
				case 6:
				{
					self asmsetanimationrate(0.8);
					self dodamage(self.maxhealth / 4, self.origin, e_player, e_player, undefined, "MOD_PROJECTILE_SPLASH", 0, w_weapon);
					break;
				}
				case 7:
				case 8:
				case 9:
				{
					self asmsetanimationrate(0.7);
					self dodamage(self.maxhealth / 3, self.origin, e_player, e_player, undefined, "MOD_PROJECTILE_SPLASH", 0, w_weapon);
					break;
				}
				case 10:
				case 11:
				case 12:
				{
					self asmsetanimationrate(0.6);
					self dodamage(self.maxhealth / 2, self.origin, e_player, e_player, undefined, "MOD_PROJECTILE_SPLASH", 0, w_weapon);
					break;
				}
			}
		}
		else
		{
			self dodamage(self.maxhealth / 12, self.origin, e_player, e_player, undefined, "MOD_PROJECTILE_SPLASH", 0, w_weapon);
		}
		return 1;
	}
	return 0;
}

/*
	Name: function_1f6a7f03
	Namespace: namespace_61461ca0
	Checksum: 0x424F4353
	Offset: 0x1B70
	Size: 0x20
	Parameters: 3
	Flags: None
	Line Number: 548
*/
function function_1f6a7f03()
{
System.InvalidOperationException: Stack empty.
   at System.ThrowHelper.ThrowInvalidOperationException(ExceptionResource resource)
   at System.Collections.Generic.Stack`1.Pop()
   at Cerberus.Logic.Decompiler.BuildCondition(Int32 startIndex)
   at Cerberus.Logic.Decompiler.FindIfStatements()
   at Cerberus.Logic.Decompiler..ctor(ScriptExport function, ScriptBase script)
}

/*
	Name: function_5afe67f4
	Namespace: namespace_61461ca0
	Checksum: 0x424F4353
	Offset: 0x1B98
	Size: 0x48
	Parameters: 1
	Flags: None
	Line Number: 568
*/
function function_5afe67f4(weapon)
{
	return isdefined(weapon) && (weapon.name == "ray_gun_elemental" || weapon.name == "ray_gun_elemental_upgraded");
}

/*
	Name: function_8dc110d1
	Namespace: namespace_61461ca0
	Checksum: 0x424F4353
	Offset: 0x1BE8
	Size: 0x170
	Parameters: 0
	Flags: None
	Line Number: 583
*/
function function_8dc110d1()
{
	self notify("hash_8dc110d1");
	self endon("hash_8dc110d1");
	self endon("disconnect");
	while(1)
	{
		self waittill("weapon_change", weapon);
		var_5058e7e9 = 0;
		var_d63082b2 = function_b3d16542(weapon);
		var_250ccd23 = undefined;
		a_str_weapons = self getweaponslist();
		foreach(str_weapon in a_str_weapons)
		{
			if(function_b3d16542(str_weapon))
			{
				var_5058e7e9 = 1;
				var_250ccd23 = str_weapon;
			}
		}
		if(var_d63082b2)
		{
			self thread function_3bc22848(weapon);
		}
	}
}

/*
	Name: function_3bc22848
	Namespace: namespace_61461ca0
	Checksum: 0x424F4353
	Offset: 0x1D60
	Size: 0x88
	Parameters: 1
	Flags: None
	Line Number: 620
*/
function function_3bc22848(weapon)
{
	self notify("hash_3bc22848");
	self endon("hash_3bc22848");
	self endon("disconnect");
	while(function_b3d16542(weapon))
	{
		self function_fe30696c();
		weapon = self getcurrentweapon();
	}
}

/*
	Name: function_fe30696c
	Namespace: namespace_61461ca0
	Checksum: 0x424F4353
	Offset: 0x1DF0
	Size: 0xC0
	Parameters: 0
	Flags: None
	Line Number: 642
*/
function function_fe30696c()
{
	self endon("disconnect");
	self endon("player_downed");
	self endon("weapon_change");
	self endon("weapon_fired");
	while(!self attackbuttonpressed())
	{
		wait(0.05);
	}
	n_old_charge = 0;
	while(1)
	{
		if(n_old_charge != self.chargeShotLevel)
		{
			self clientfield::set_to_player("player_quantum_raygun_charge", self.chargeShotLevel);
			n_old_charge = self.chargeShotLevel;
		}
		wait(0.1);
	}
}

/*
	Name: function_b3d16542
	Namespace: namespace_61461ca0
	Checksum: 0x424F4353
	Offset: 0x1EB8
	Size: 0x48
	Parameters: 1
	Flags: None
	Line Number: 674
*/
function function_b3d16542(w_weapon)
{
	switch(w_weapon.name)
	{
		case "ray_gun_elemental_upgraded":
		{
			return 1;
		}
		default
		{
			return 0;
		}
	}
	return;
	ERROR: Exception occured: Stack empty.
}

/*
	Name: function_9b1a371f
	Namespace: namespace_61461ca0
	Checksum: 0x424F4353
	Offset: 0x1F08
	Size: 0x30
	Parameters: 1
	Flags: None
	Line Number: 701
*/
function function_9b1a371f(w_weapon)
{
	iprintlnbold("Weapon: " + w_weapon);
}

/*
	Name: move_valid_poi_to_navmesh
	Namespace: namespace_61461ca0
	Checksum: 0x424F4353
	Offset: 0x1F40
	Size: 0x1F0
	Parameters: 1
	Flags: None
	Line Number: 716
*/
function move_valid_poi_to_navmesh(valid_poi)
{
	if(!(isdefined(valid_poi) && valid_poi))
	{
		return 0;
	}
	if(ispointonnavmesh(self.origin))
	{
		return 1;
	}
	v_orig = self.origin;
	queryresult = positionquery_source_navigation(self.origin, 0, level.VALID_POI_MAX_RADIUS, level.VALID_POI_HALF_HEIGHT, level.VALID_POI_INNER_SPACING, level.VALID_POI_RADIUS_FROM_EDGES);
	if(queryresult.data.size)
	{
		foreach(point in queryresult.data)
		{
			height_offset = abs(self.origin[2] - point.origin[2]);
			if(height_offset > level.VALID_POI_HEIGHT)
			{
				continue;
			}
			if(bullettracepassed(point.origin + VectorScale((0, 0, 1), 20), v_orig + VectorScale((0, 0, 1), 20), 0, self, undefined, 0, 0))
			{
				self.origin = point.origin;
				return 1;
			}
		}
	}
	return 0;
	ERROR: Exception occured: Stack empty.
}

/*
	Name: function_31df6805
	Namespace: namespace_61461ca0
	Checksum: 0x424F4353
	Offset: 0x2138
	Size: 0x50
	Parameters: 0
	Flags: None
	Line Number: 758
*/
function function_31df6805()
{
	self endon("death");
	self endon("disconnect");
	for(;;)
	{
		self waittill("grenade_pullback", weapon);
		self thread beginGrenadeTracking();
	}
}

/*
	Name: beginGrenadeTracking
	Namespace: namespace_61461ca0
	Checksum: 0x424F4353
	Offset: 0x2190
	Size: 0x78
	Parameters: 0
	Flags: None
	Line Number: 779
*/
function beginGrenadeTracking()
{
	self endon("disconnect");
	startTime = GetTime();
	self thread watchGrenadeCancel();
	self waittill("grenade_fire", grenade, weapon);
	self.cookedTime = GetTime() - startTime;
	wait(2);
	self.cookedTime = undefined;
}

/*
	Name: watchGrenadeCancel
	Namespace: namespace_61461ca0
	Checksum: 0x424F4353
	Offset: 0x2210
	Size: 0xA0
	Parameters: 0
	Flags: None
	Line Number: 800
*/
function watchGrenadeCancel()
{
	self endon("death");
	self endon("disconnect");
	self endon("grenade_fire");
	waittillframeend;
	weapon = level.weaponnone;
	while(self IsThrowingGrenade() && weapon == level.weaponnone)
	{
		self waittill("weapon_change", weapon);
	}
	self.cookedTime = undefined;
	self.throwingGrenade = 0;
	self.gotPullbackNotify = 0;
}

/*
	Name: watchMissileDeath
	Namespace: namespace_61461ca0
	Checksum: 0x424F4353
	Offset: 0x22B8
	Size: 0x2C
	Parameters: 0
	Flags: None
	Line Number: 826
*/
function watchMissileDeath()
{
	self waittill("death");
	arrayremovevalue(level.MissileEntities, self);
}

