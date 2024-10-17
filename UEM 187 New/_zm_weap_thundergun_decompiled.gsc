#include scripts\codescripts\struct;
#include scripts\shared\ai\zombie_death;
#include scripts\shared\ai\zombie_shared;
#include scripts\shared\ai\zombie_utility;
#include scripts\shared\array_shared;
#include scripts\shared\callbacks_shared;
#include scripts\shared\system_shared;
#include scripts\shared\util_shared;
#include scripts\zm\_util;
#include scripts\zm\_zm_audio;
#include scripts\zm\_zm_score;
#include scripts\zm\_zm_utility;
#include scripts\zm\_zm_weapon_upgrade_system;
#include scripts\zm\_zm_weapons;

#namespace zm_weap_thundergun;

/*
	Name: __init__sytem__
	Namespace: zm_weap_thundergun
	Checksum: 0x424F4353
	Offset: 0x588
	Size: 0x40
	Parameters: 0
	Flags: AutoExec
	Line Number: 27
*/
function autoexec __init__sytem__()
{
	system::register("zm_weap_thundergun", &__init__, &__main__, undefined);
}

/*
	Name: __init__
	Namespace: zm_weap_thundergun
	Checksum: 0x424F4353
	Offset: 0x5D0
	Size: 0x48
	Parameters: 0
	Flags: None
	Line Number: 42
*/
function __init__()
{
	level.weaponZMThunderGun = getweapon("thundergun");
	level.weaponZMThunderGunUpgraded = getweapon("thundergun_upgraded");
}

/*
	Name: __main__
	Namespace: zm_weap_thundergun
	Checksum: 0x424F4353
	Offset: 0x620
	Size: 0x1B0
	Parameters: 0
	Flags: None
	Line Number: 58
*/
function __main__()
{
	level._effect["thundergun_knockdown_ground"] = "zombie/fx_thundergun_knockback_ground";
	level._effect["thundergun_smoke_cloud"] = "zombie/fx_thundergun_smoke_cloud";
	zombie_utility::set_zombie_var("thundergun_cylinder_radius", 180);
	zombie_utility::set_zombie_var("thundergun_fling_range", 480);
	zombie_utility::set_zombie_var("thundergun_gib_range", 900);
	zombie_utility::set_zombie_var("thundergun_gib_damage", 75);
	zombie_utility::set_zombie_var("thundergun_knockdown_range", 1200);
	zombie_utility::set_zombie_var("thundergun_knockdown_damage", 15);
	level.thundergun_gib_refs = [];
	level.thundergun_gib_refs[level.thundergun_gib_refs.size] = "guts";
	level.thundergun_gib_refs[level.thundergun_gib_refs.size] = "right_arm";
	level.thundergun_gib_refs[level.thundergun_gib_refs.size] = "left_arm";
	level.basic_zombie_thundergun_knockdown = &zombie_knockdown;
	if(!isdefined(level.override_thundergun_damage_func))
	{
		level.override_thundergun_damage_func = &override_thundergun_damage_func;
	}
	callback::on_connect(&thundergun_on_player_connect);
}

/*
	Name: thundergun_on_player_connect
	Namespace: zm_weap_thundergun
	Checksum: 0x424F4353
	Offset: 0x7D8
	Size: 0x20
	Parameters: 0
	Flags: None
	Line Number: 90
*/
function thundergun_on_player_connect()
{
	self thread wait_for_thundergun_fired();
}

/*
	Name: wait_for_thundergun_fired
	Namespace: zm_weap_thundergun
	Checksum: 0x424F4353
	Offset: 0x800
	Size: 0x148
	Parameters: 0
	Flags: None
	Line Number: 105
*/
function wait_for_thundergun_fired()
{
	self endon("disconnect");
	self waittill("spawned_player");
	for(;;)
	{
		self waittill("weapon_fired");
		currentweapon = self getcurrentweapon();
		if(currentweapon == level.weaponZMThunderGun || currentweapon == level.weaponZMThunderGunUpgraded)
		{
			self thread thundergun_fired(currentweapon);
			view_pos = self gettagorigin("tag_flash") - self GetPlayerViewHeight();
			view_angles = self gettagangles("tag_flash");
			playfx(level._effect["thundergun_smoke_cloud"], view_pos, anglestoforward(view_angles), anglestoup(view_angles));
		}
	}
}

/*
	Name: thundergun_network_choke
	Namespace: zm_weap_thundergun
	Checksum: 0x424F4353
	Offset: 0x950
	Size: 0x50
	Parameters: 0
	Flags: None
	Line Number: 133
*/
function thundergun_network_choke()
{
	level.thundergun_network_choke_count++;
	if(!level.thundergun_network_choke_count % 10)
	{
		util::wait_network_frame();
		util::wait_network_frame();
		util::wait_network_frame();
	}
}

/*
	Name: thundergun_fired
	Namespace: zm_weap_thundergun
	Checksum: 0x424F4353
	Offset: 0x9A8
	Size: 0x50
	Parameters: 1
	Flags: None
	Line Number: 154
*/
function thundergun_fired(currentweapon)
{
	PhysicsExplosionCylinder(self.origin, 600, 240, 1);
	self thread thundergun_affect_ais(currentweapon);
	return;
	ERROR: Exception occured: Stack empty.
}

/*
	Name: thundergun_affect_ais
	Namespace: zm_weap_thundergun
	Checksum: 0x424F4353
	Offset: 0xA00
	Size: 0x158
	Parameters: 1
	Flags: None
	Line Number: 172
*/
function thundergun_affect_ais(currentweapon)
{
	if(!isdefined(level.thundergun_knockdown_enemies))
	{
		level.thundergun_knockdown_enemies = [];
		level.thundergun_knockdown_gib = [];
		level.thundergun_fling_enemies = [];
		level.thundergun_fling_vecs = [];
	}
	self thundergun_get_enemies_in_range(currentweapon);
	level.thundergun_network_choke_count = 0;
	for(i = 0; i < level.thundergun_fling_enemies.size; i++)
	{
		level.thundergun_fling_enemies[i] thread thundergun_fling_zombie(self, level.thundergun_fling_vecs[i], i);
	}
	for(i = 0; i < level.thundergun_knockdown_enemies.size; i++)
	{
		level.thundergun_knockdown_enemies[i] thread thundergun_knockdown_zombie(self, level.thundergun_knockdown_gib[i]);
	}
	level.thundergun_knockdown_enemies = [];
	level.thundergun_knockdown_gib = [];
	level.thundergun_fling_enemies = [];
	level.thundergun_fling_vecs = [];
}

/*
	Name: thundergun_get_enemies_in_range
	Namespace: zm_weap_thundergun
	Checksum: 0x424F4353
	Offset: 0xB60
	Size: 0x678
	Parameters: 1
	Flags: None
	Line Number: 207
*/
function thundergun_get_enemies_in_range(currentweapon)
{
	view_pos = self getweaponmuzzlepoint();
	zombies = array::get_all_closest(view_pos, getaiteamarray(level.zombie_team), undefined, undefined, level.zombie_vars["thundergun_knockdown_range"]);
	if(!isdefined(zombies))
	{
		return;
	}
	knockdown_range_squared = level.zombie_vars["thundergun_knockdown_range"] * level.zombie_vars["thundergun_knockdown_range"];
	gib_range_squared = level.zombie_vars["thundergun_gib_range"] * level.zombie_vars["thundergun_gib_range"];
	fling_range_squared = level.zombie_vars["thundergun_fling_range"] * level.zombie_vars["thundergun_fling_range"];
	cylinder_radius_squared = level.zombie_vars["thundergun_cylinder_radius"] * level.zombie_vars["thundergun_cylinder_radius"];
	forward_view_angles = self getweaponforwarddir();
	end_pos = view_pos + VectorScale(forward_view_angles, level.zombie_vars["thundergun_knockdown_range"]);
	if(currentweapon == level.weaponZMThunderGunUpgraded)
	{
		var_480fed80 = self namespace_5e1f56dc::function_1239e0ad(currentweapon);
		if(isdefined(var_480fed80))
		{
			if(var_480fed80.var_a39a2843 >= 1)
			{
				max_zombies = 24 + 2 * var_480fed80.var_a39a2843;
			}
		}
		else
		{
			max_zombies = 24;
		}
	}
	else
	{
		max_zombies = 24;
	}
	for(i = 0; i < max_zombies; i++)
	{
		if(!isdefined(zombies[i]) || !isalive(zombies[i]))
		{
			continue;
		}
		test_origin = zombies[i] getcentroid();
		test_range_squared = distancesquared(view_pos, test_origin);
		if(test_range_squared > knockdown_range_squared)
		{
			zombies[i] thundergun_debug_print("range", (1, 0, 0));
			return;
		}
		normal = vectornormalize(test_origin - view_pos);
		dot = vectordot(forward_view_angles, normal);
		if(0 > dot)
		{
			zombies[i] thundergun_debug_print("dot", (1, 0, 0));
			continue;
		}
		radial_origin = PointOnSegmentNearestToPoint(view_pos, end_pos, test_origin);
		if(distancesquared(test_origin, radial_origin) > cylinder_radius_squared)
		{
			zombies[i] thundergun_debug_print("cylinder", (1, 0, 0));
			continue;
		}
		if(0 == zombies[i] damageconetrace(view_pos, self))
		{
			zombies[i] thundergun_debug_print("cone", (1, 0, 0));
			continue;
		}
		if(test_range_squared < fling_range_squared)
		{
			level.thundergun_fling_enemies[level.thundergun_fling_enemies.size] = zombies[i];
			dist_mult = fling_range_squared - test_range_squared / fling_range_squared;
			fling_vec = vectornormalize(test_origin - view_pos);
			if(5000 < test_range_squared)
			{
				fling_vec = fling_vec + vectornormalize(test_origin - radial_origin);
			}
			fling_vec = (fling_vec[0], fling_vec[1], abs(fling_vec[2]));
			fling_vec = VectorScale(fling_vec, 100 + 100 * dist_mult);
			level.thundergun_fling_vecs[level.thundergun_fling_vecs.size] = fling_vec;
			zombies[i] thread setup_thundergun_vox(self, 1, 0, 0);
			continue;
		}
		if(test_range_squared < gib_range_squared)
		{
			level.thundergun_knockdown_enemies[level.thundergun_knockdown_enemies.size] = zombies[i];
			level.thundergun_knockdown_gib[level.thundergun_knockdown_gib.size] = 1;
			zombies[i] thread setup_thundergun_vox(self, 0, 1, 0);
			continue;
		}
		level.thundergun_knockdown_enemies[level.thundergun_knockdown_enemies.size] = zombies[i];
		level.thundergun_knockdown_gib[level.thundergun_knockdown_gib.size] = 0;
		zombies[i] thread setup_thundergun_vox(self, 0, 0, 1);
	}
}

/*
	Name: thundergun_debug_print
	Namespace: zm_weap_thundergun
	Checksum: 0x424F4353
	Offset: 0x11E0
	Size: 0x18
	Parameters: 2
	Flags: None
	Line Number: 309
*/
function thundergun_debug_print(msg, color)
{
	return;
	ERROR: Exception occured: Stack empty.
}

/*
	Name: thundergun_fling_zombie
	Namespace: zm_weap_thundergun
	Checksum: 0x424F4353
	Offset: 0x1200
	Size: 0x188
	Parameters: 3
	Flags: None
	Line Number: 325
*/
function thundergun_fling_zombie(player, fling_vec, index)
{
	if(!isdefined(self) || !isalive(self))
	{
		return;
	}
	if(isdefined(self.thundergun_fling_func))
	{
		self [[self.thundergun_fling_func]](player);
		return;
	}
	self.deathpoints_already_given = 1;
	self dodamage(self.health + 666, player.origin, player);
	if(self.health <= 0)
	{
		if(isdefined(player) && isdefined(level.hero_power_update))
		{
			level thread [[level.hero_power_update]](player, self);
		}
		points = 10;
		if(!index)
		{
			points = zm_score::get_zombie_death_player_points();
		}
		else if(1 == index)
		{
			points = 30;
		}
		player zm_score::player_add_points("thundergun_fling", points);
		self startragdoll();
		self launchragdoll(fling_vec);
		self.thundergun_death = 1;
	}
}

/*
	Name: zombie_knockdown
	Namespace: zm_weap_thundergun
	Checksum: 0x424F4353
	Offset: 0x1390
	Size: 0x130
	Parameters: 2
	Flags: None
	Line Number: 370
*/
function zombie_knockdown(player, gib)
{
	if(gib && !self.gibbed)
	{
		self.a.gib_ref = array::random(level.thundergun_gib_refs);
		self thread zombie_death::do_gib();
	}
	if(isdefined(level.override_thundergun_damage_func))
	{
		self [[level.override_thundergun_damage_func]](player, gib);
	}
	else
	{
		damage = level.zombie_vars["thundergun_knockdown_damage"];
		self playsound("fly_thundergun_forcehit");
		self.thundergun_handle_pain_notetracks = &handle_thundergun_pain_notetracks;
		self dodamage(damage, player.origin, player);
		self animcustom(&playThundergunPainAnim);
		return;
	}
	ERROR: Exception occured: Index was out of range. Must be non-negative and less than the size of the collection.
Parameter name: index
}

/*
	Name: playThundergunPainAnim
	Namespace: zm_weap_thundergun
	Checksum: 0x424F4353
	Offset: 0x14C8
	Size: 0x240
	Parameters: 0
	Flags: None
	Line Number: 404
*/
function playThundergunPainAnim()
{
	self notify("end_play_thundergun_pain_anim");
	self endon("killanimscript");
	self endon("death");
	self endon("end_play_thundergun_pain_anim");
	if(isdefined(self.marked_for_death) && self.marked_for_death)
	{
		return;
	}
	if(self.damageyaw <= -135 || self.damageyaw >= 135)
	{
		if(self.missingLegs)
		{
			fallAnim = "zm_thundergun_fall_front_crawl";
		}
		else
		{
			fallAnim = "zm_thundergun_fall_front";
		}
		getupAnim = "zm_thundergun_getup_belly_early";
	}
	else if(self.damageyaw > -135 && self.damageyaw < -45)
	{
		fallAnim = "zm_thundergun_fall_left";
		getupAnim = "zm_thundergun_getup_belly_early";
	}
	else if(self.damageyaw > 45 && self.damageyaw < 135)
	{
		fallAnim = "zm_thundergun_fall_right";
		getupAnim = "zm_thundergun_getup_belly_early";
	}
	else
	{
		fallAnim = "zm_thundergun_fall_back";
		if(randomint(100) < 50)
		{
			getupAnim = "zm_thundergun_getup_back_early";
		}
		else
		{
			getupAnim = "zm_thundergun_getup_back_late";
		}
	}
	self SetAnimStateFromASD(fallAnim);
	self zombie_shared::DoNoteTracks("thundergun_fall_anim", self.thundergun_handle_pain_notetracks);
	if(!isdefined(self) || !isalive(self) || self.missingLegs || (isdefined(self.marked_for_death) && self.marked_for_death))
	{
		return;
	}
	self SetAnimStateFromASD(getupAnim);
	self zombie_shared::DoNoteTracks("thundergun_getup_anim");
	return;
}

/*
	Name: thundergun_knockdown_zombie
	Namespace: zm_weap_thundergun
	Checksum: 0x424F4353
	Offset: 0x1710
	Size: 0x88
	Parameters: 2
	Flags: None
	Line Number: 469
*/
function thundergun_knockdown_zombie(player, gib)
{
	self endon("death");
	playsoundatposition("wpn_thundergun_proj_impact", self.origin);
	if(!isdefined(self) || !isalive(self))
	{
		return;
	}
	if(isdefined(self.thundergun_knockdown_func))
	{
		self [[self.thundergun_knockdown_func]](player, gib);
	}
}

/*
	Name: handle_thundergun_pain_notetracks
	Namespace: zm_weap_thundergun
	Checksum: 0x424F4353
	Offset: 0x17A0
	Size: 0x98
	Parameters: 1
	Flags: None
	Line Number: 493
*/
function handle_thundergun_pain_notetracks(note)
{
	if(note == "zombie_knockdown_ground_impact")
	{
		playfx(level._effect["thundergun_knockdown_ground"], self.origin, anglestoforward(self.angles), anglestoup(self.angles));
		self playsound("fly_thundergun_forcehit");
	}
}

/*
	Name: is_thundergun_damage
	Namespace: zm_weap_thundergun
	Checksum: 0x424F4353
	Offset: 0x1840
	Size: 0x50
	Parameters: 0
	Flags: None
	Line Number: 512
*/
function is_thundergun_damage()
{
	return self.damageWeapon == level.weaponZMThunderGun || self.damageWeapon == level.weaponZMThunderGunUpgraded && (self.damageMod != "MOD_GRENADE" && self.damageMod != "MOD_GRENADE_SPLASH");
}

/*
	Name: enemy_killed_by_thundergun
	Namespace: zm_weap_thundergun
	Checksum: 0x424F4353
	Offset: 0x1898
	Size: 0x18
	Parameters: 0
	Flags: None
	Line Number: 527
*/
function enemy_killed_by_thundergun()
{
	return isdefined(self.thundergun_death) && self.thundergun_death;
}

/*
	Name: thundergun_sound_thread
	Namespace: zm_weap_thundergun
	Checksum: 0x424F4353
	Offset: 0x18B8
	Size: 0x118
	Parameters: 0
	Flags: None
	Line Number: 542
*/
function thundergun_sound_thread()
{
	self endon("disconnect");
	self waittill("spawned_player");
	for(;;)
	{
		result = self util::waittill_any_return("grenade_fire", "death", "player_downed", "weapon_change", "grenade_pullback", "disconnect");
		if(!isdefined(result))
		{
		}
		else if(result == "weapon_change" || result == "grenade_fire" && self getcurrentweapon() == level.weaponZMThunderGun)
		{
			self playloopsound("tesla_idle", 0.25);
		}
		else
		{
			self notify("weap_away");
			self stoploopsound(0.25);
		}
	}
}

/*
	Name: setup_thundergun_vox
	Namespace: zm_weap_thundergun
	Checksum: 0x424F4353
	Offset: 0x19D8
	Size: 0xD8
	Parameters: 4
	Flags: None
	Line Number: 574
*/
function setup_thundergun_vox(player, fling, gib, knockdown)
{
	if(!isdefined(self) || !isalive(self))
	{
		return;
	}
	if(!fling && (gib || knockdown))
	{
	}
	if(fling)
	{
		if(30 > randomintrange(1, 100))
		{
			player zm_audio::create_and_play_dialog("kill", "thundergun");
		}
	}
}

/*
	Name: override_thundergun_damage_func
	Namespace: zm_weap_thundergun
	Checksum: 0x424F4353
	Offset: 0x1AB8
	Size: 0x2C
	Parameters: 2
	Flags: None
	Line Number: 602
*/
function override_thundergun_damage_func(player, gib)
{
	self zombie_utility::setup_zombie_knockdown(player);
}

