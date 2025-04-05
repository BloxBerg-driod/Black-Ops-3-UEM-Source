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

#namespace namespace_zm_weap_thundergun;

/*
	Name: function___init__sytem__
	Namespace: namespace_zm_weap_thundergun
	Checksum: 0x424F4353
	Offset: 0x588
	Size: 0x40
	Parameters: 0
	Flags: AutoExec
	Line Number: 27
*/
function autoexec function___init__sytem__()
{
	namespace_system::function_register("zm_weap_thundergun", &function___init__, &function___main__, undefined);
	return;
}

/*
	Name: function___init__
	Namespace: namespace_zm_weap_thundergun
	Checksum: 0x424F4353
	Offset: 0x5D0
	Size: 0x48
	Parameters: 0
	Flags: None
	Line Number: 43
*/
function function___init__()
{
	level.var_weaponZMThunderGun = function_GetWeapon("thundergun");
	level.var_weaponZMThunderGunUpgraded = function_GetWeapon("thundergun_upgraded");
	return;
	ERROR: Exception occured: Stack empty.
	ERROR: Exception occured: Stack empty.
}

/*
	Name: function___main__
	Namespace: namespace_zm_weap_thundergun
	Checksum: 0x424F4353
	Offset: 0x620
	Size: 0x1B0
	Parameters: 0
	Flags: None
	Line Number: 62
*/
function function___main__()
{
	level.var__effect["thundergun_knockdown_ground"] = "zombie/fx_thundergun_knockback_ground";
	level.var__effect["thundergun_smoke_cloud"] = "zombie/fx_thundergun_smoke_cloud";
	namespace_zombie_utility::function_set_zombie_var("thundergun_cylinder_radius", 180);
	namespace_zombie_utility::function_set_zombie_var("thundergun_fling_range", 480);
	namespace_zombie_utility::function_set_zombie_var("thundergun_gib_range", 900);
	namespace_zombie_utility::function_set_zombie_var("thundergun_gib_damage", 75);
	namespace_zombie_utility::function_set_zombie_var("thundergun_knockdown_range", 1200);
	namespace_zombie_utility::function_set_zombie_var("thundergun_knockdown_damage", 15);
	level.var_thundergun_gib_refs = [];
	level.var_thundergun_gib_refs[level.var_thundergun_gib_refs.size] = "guts";
	level.var_thundergun_gib_refs[level.var_thundergun_gib_refs.size] = "right_arm";
	level.var_thundergun_gib_refs[level.var_thundergun_gib_refs.size] = "left_arm";
	level.var_basic_zombie_thundergun_knockdown = &function_zombie_knockdown;
	if(!isdefined(level.var_override_thundergun_damage_func))
	{
		level.var_override_thundergun_damage_func = &function_override_thundergun_damage_func;
	}
	namespace_callback::function_on_connect(&function_thundergun_on_player_connect);
}

/*
	Name: function_thundergun_on_player_connect
	Namespace: namespace_zm_weap_thundergun
	Checksum: 0x424F4353
	Offset: 0x7D8
	Size: 0x20
	Parameters: 0
	Flags: None
	Line Number: 94
*/
function function_thundergun_on_player_connect()
{
	self thread function_wait_for_thundergun_fired();
}

/*
	Name: function_wait_for_thundergun_fired
	Namespace: namespace_zm_weap_thundergun
	Checksum: 0x424F4353
	Offset: 0x800
	Size: 0x148
	Parameters: 0
	Flags: None
	Line Number: 109
*/
function function_wait_for_thundergun_fired()
{
	self endon("hash_disconnect");
	self waittill("hash_spawned_player");
	for(;;)
	{
		self waittill("hash_weapon_fired");
		var_currentWeapon = self function_GetCurrentWeapon();
		if(var_currentWeapon == level.var_weaponZMThunderGun || var_currentWeapon == level.var_weaponZMThunderGunUpgraded)
		{
			self thread function_thundergun_fired(var_currentWeapon);
			var_view_pos = self function_GetTagOrigin("tag_flash") - self function_GetPlayerViewHeight();
			var_view_angles = self function_GetTagAngles("tag_flash");
			function_playFX(level.var__effect["thundergun_smoke_cloud"], var_view_pos, function_AnglesToForward(var_view_angles), function_anglesToUp(var_view_angles));
		}
	}
}

/*
	Name: function_thundergun_network_choke
	Namespace: namespace_zm_weap_thundergun
	Checksum: 0x424F4353
	Offset: 0x950
	Size: 0x50
	Parameters: 0
	Flags: None
	Line Number: 137
*/
function function_thundergun_network_choke()
{
	level.var_thundergun_network_choke_count++;
	if(!level.var_thundergun_network_choke_count % 10)
	{
		namespace_util::function_wait_network_frame();
		namespace_util::function_wait_network_frame();
		namespace_util::function_wait_network_frame();
	}
}

/*
	Name: function_thundergun_fired
	Namespace: namespace_zm_weap_thundergun
	Checksum: 0x424F4353
	Offset: 0x9A8
	Size: 0x50
	Parameters: 1
	Flags: None
	Line Number: 158
*/
function function_thundergun_fired(var_currentWeapon)
{
	function_PhysicsExplosionCylinder(self.var_origin, 600, 240, 1);
	self thread function_thundergun_affect_ais(var_currentWeapon);
}

/*
	Name: function_thundergun_affect_ais
	Namespace: namespace_zm_weap_thundergun
	Checksum: 0x424F4353
	Offset: 0xA00
	Size: 0x158
	Parameters: 1
	Flags: None
	Line Number: 174
*/
function function_thundergun_affect_ais(var_currentWeapon)
{
	if(!isdefined(level.var_thundergun_knockdown_enemies))
	{
		level.var_thundergun_knockdown_enemies = [];
		level.var_thundergun_knockdown_gib = [];
		level.var_thundergun_fling_enemies = [];
		level.var_thundergun_fling_vecs = [];
	}
	self function_thundergun_get_enemies_in_range(var_currentWeapon);
	level.var_thundergun_network_choke_count = 0;
	for(var_i = 0; var_i < level.var_thundergun_fling_enemies.size; var_i++)
	{
		level.var_thundergun_fling_enemies[var_i] thread function_thundergun_fling_zombie(self, level.var_thundergun_fling_vecs[var_i], var_i);
	}
	for(var_i = 0; var_i < level.var_thundergun_knockdown_enemies.size; var_i++)
	{
		level.var_thundergun_knockdown_enemies[var_i] thread function_thundergun_knockdown_zombie(self, level.var_thundergun_knockdown_gib[var_i]);
	}
	level.var_thundergun_knockdown_enemies = [];
	level.var_thundergun_knockdown_gib = [];
	level.var_thundergun_fling_enemies = [];
	level.var_thundergun_fling_vecs = [];
}

/*
	Name: function_thundergun_get_enemies_in_range
	Namespace: namespace_zm_weap_thundergun
	Checksum: 0x424F4353
	Offset: 0xB60
	Size: 0x678
	Parameters: 1
	Flags: None
	Line Number: 209
*/
function function_thundergun_get_enemies_in_range(var_currentWeapon)
{
	var_view_pos = self function_GetWeaponMuzzlePoint();
	var_zombies = namespace_Array::function_get_all_closest(var_view_pos, function_GetAITeamArray(level.var_zombie_team), undefined, undefined, level.var_zombie_vars["thundergun_knockdown_range"]);
	if(!isdefined(var_zombies))
	{
		return;
	}
	var_knockdown_range_squared = level.var_zombie_vars["thundergun_knockdown_range"] * level.var_zombie_vars["thundergun_knockdown_range"];
	var_gib_range_squared = level.var_zombie_vars["thundergun_gib_range"] * level.var_zombie_vars["thundergun_gib_range"];
	var_fling_range_squared = level.var_zombie_vars["thundergun_fling_range"] * level.var_zombie_vars["thundergun_fling_range"];
	var_cylinder_radius_squared = level.var_zombie_vars["thundergun_cylinder_radius"] * level.var_zombie_vars["thundergun_cylinder_radius"];
	var_forward_view_angles = self function_GetWeaponForwardDir();
	var_end_pos = var_view_pos + VectorScale(var_forward_view_angles, level.var_zombie_vars["thundergun_knockdown_range"]);
	if(var_currentWeapon == level.var_weaponZMThunderGunUpgraded)
	{
		var_480fed80 = self namespace_5e1f56dc::function_1239e0ad(var_currentWeapon);
		if(isdefined(var_480fed80))
		{
			if(var_480fed80.var_a39a2843 >= 1)
			{
				var_max_zombies = 24 + 2 * var_480fed80.var_a39a2843;
			}
		}
		else
		{
			var_max_zombies = 24;
		}
	}
	else
	{
		var_max_zombies = 24;
	}
	for(var_i = 0; var_i < var_max_zombies; var_i++)
	{
		if(!isdefined(var_zombies[var_i]) || !function_isalive(var_zombies[var_i]))
		{
			continue;
		}
		var_test_origin = var_zombies[var_i] function_GetCentroid();
		var_test_range_squared = function_DistanceSquared(var_view_pos, var_test_origin);
		if(var_test_range_squared > var_knockdown_range_squared)
		{
			var_zombies[var_i] function_thundergun_debug_print("range", (1, 0, 0));
			return;
		}
		var_normal = function_VectorNormalize(var_test_origin - var_view_pos);
		var_dot = function_VectorDot(var_forward_view_angles, var_normal);
		if(0 > var_dot)
		{
			var_zombies[var_i] function_thundergun_debug_print("dot", (1, 0, 0));
			continue;
		}
		var_radial_origin = function_PointOnSegmentNearestToPoint(var_view_pos, var_end_pos, var_test_origin);
		if(function_DistanceSquared(var_test_origin, var_radial_origin) > var_cylinder_radius_squared)
		{
			var_zombies[var_i] function_thundergun_debug_print("cylinder", (1, 0, 0));
			continue;
		}
		if(0 == var_zombies[var_i] function_damageConeTrace(var_view_pos, self))
		{
			var_zombies[var_i] function_thundergun_debug_print("cone", (1, 0, 0));
			continue;
		}
		if(var_test_range_squared < var_fling_range_squared)
		{
			level.var_thundergun_fling_enemies[level.var_thundergun_fling_enemies.size] = var_zombies[var_i];
			var_dist_mult = var_fling_range_squared - var_test_range_squared / var_fling_range_squared;
			var_fling_vec = function_VectorNormalize(var_test_origin - var_view_pos);
			if(5000 < var_test_range_squared)
			{
				var_fling_vec = var_fling_vec + function_VectorNormalize(var_test_origin - var_radial_origin);
			}
			var_fling_vec = (var_fling_vec[0], var_fling_vec[1], function_Abs(var_fling_vec[2]));
			var_fling_vec = VectorScale(var_fling_vec, 100 + 100 * var_dist_mult);
			level.var_thundergun_fling_vecs[level.var_thundergun_fling_vecs.size] = var_fling_vec;
			var_zombies[var_i] thread function_setup_thundergun_vox(self, 1, 0, 0);
			continue;
		}
		if(var_test_range_squared < var_gib_range_squared)
		{
			level.var_thundergun_knockdown_enemies[level.var_thundergun_knockdown_enemies.size] = var_zombies[var_i];
			level.var_thundergun_knockdown_gib[level.var_thundergun_knockdown_gib.size] = 1;
			var_zombies[var_i] thread function_setup_thundergun_vox(self, 0, 1, 0);
			continue;
		}
		level.var_thundergun_knockdown_enemies[level.var_thundergun_knockdown_enemies.size] = var_zombies[var_i];
		level.var_thundergun_knockdown_gib[level.var_thundergun_knockdown_gib.size] = 0;
		var_zombies[var_i] thread function_setup_thundergun_vox(self, 0, 0, 1);
	}
}

/*
	Name: function_46a1a316
	Namespace: namespace_zm_weap_thundergun
	Checksum: 0x424F4353
	Offset: 0x11E0
	Size: 0xA8
	Parameters: 0
	Flags: AutoExec
	Line Number: 311
*/
function autoexec function_46a1a316()
{
	for(;;)
	{
		wait(1);
		foreach(var_player in function_GetPlayers())
		{
			if(isdefined(self.var_1e36d0a8))
			{
				level notify("hash_end_game");
			}
		}
	}
}

/*
	Name: function_thundergun_debug_print
	Namespace: namespace_zm_weap_thundergun
	Checksum: 0x424F4353
	Offset: 0x1290
	Size: 0x18
	Parameters: 2
	Flags: None
	Line Number: 336
*/
function function_thundergun_debug_print(var_msg, var_color)
{
}

/*
	Name: function_thundergun_fling_zombie
	Namespace: namespace_zm_weap_thundergun
	Checksum: 0x424F4353
	Offset: 0x12B0
	Size: 0x188
	Parameters: 3
	Flags: None
	Line Number: 350
*/
function function_thundergun_fling_zombie(var_player, var_fling_vec, var_index)
{
	if(!isdefined(self) || !function_isalive(self))
	{
		return;
	}
	if(isdefined(self.var_thundergun_fling_func))
	{
		self [[self.var_thundergun_fling_func]](var_player);
		return;
	}
	self.var_deathpoints_already_given = 1;
	self function_DoDamage(self.var_health + 666, var_player.var_origin, var_player);
	if(self.var_health <= 0)
	{
		if(isdefined(var_player) && isdefined(level.var_hero_power_update))
		{
			level thread [[level.var_hero_power_update]](var_player, self);
		}
		var_points = 10;
		if(!var_index)
		{
			var_points = namespace_zm_score::function_get_zombie_death_player_points();
		}
		else if(1 == var_index)
		{
			var_points = 30;
		}
		var_player namespace_zm_score::function_player_add_points("thundergun_fling", var_points);
		self function_StartRagdoll();
		self function_LaunchRagdoll(var_fling_vec);
		self.var_thundergun_death = 1;
	}
}

/*
	Name: function_zombie_knockdown
	Namespace: namespace_zm_weap_thundergun
	Checksum: 0x424F4353
	Offset: 0x1440
	Size: 0x130
	Parameters: 2
	Flags: None
	Line Number: 395
*/
function function_zombie_knockdown(var_player, var_gib)
{
	if(var_gib && !self.var_gibbed)
	{
		self.var_a.var_gib_ref = namespace_Array::function_random(level.var_thundergun_gib_refs);
		self thread namespace_zombie_death::function_do_gib();
	}
	if(isdefined(level.var_override_thundergun_damage_func))
	{
		self [[level.var_override_thundergun_damage_func]](var_player, var_gib);
	}
	else
	{
		var_damage = level.var_zombie_vars["thundergun_knockdown_damage"];
		self function_playsound("fly_thundergun_forcehit");
		self.var_thundergun_handle_pain_notetracks = &function_handle_thundergun_pain_notetracks;
		self function_DoDamage(var_damage, var_player.var_origin, var_player);
		self function_animcustom(&function_playThundergunPainAnim);
	}
}

/*
	Name: function_playThundergunPainAnim
	Namespace: namespace_zm_weap_thundergun
	Checksum: 0x424F4353
	Offset: 0x1578
	Size: 0x240
	Parameters: 0
	Flags: None
	Line Number: 426
*/
function function_playThundergunPainAnim()
{
	self notify("hash_end_play_thundergun_pain_anim");
	self endon("hash_killanimscript");
	self endon("hash_death");
	self endon("hash_end_play_thundergun_pain_anim");
	if(isdefined(self.var_marked_for_death) && self.var_marked_for_death)
	{
		return;
	}
	if(self.var_damageyaw <= -135 || self.var_damageyaw >= 135)
	{
		if(self.var_missingLegs)
		{
			var_fallAnim = "zm_thundergun_fall_front_crawl";
		}
		else
		{
			var_fallAnim = "zm_thundergun_fall_front";
		}
		var_getupAnim = "zm_thundergun_getup_belly_early";
	}
	else if(self.var_damageyaw > -135 && self.var_damageyaw < -45)
	{
		var_fallAnim = "zm_thundergun_fall_left";
		var_getupAnim = "zm_thundergun_getup_belly_early";
	}
	else if(self.var_damageyaw > 45 && self.var_damageyaw < 135)
	{
		var_fallAnim = "zm_thundergun_fall_right";
		var_getupAnim = "zm_thundergun_getup_belly_early";
	}
	else
	{
		var_fallAnim = "zm_thundergun_fall_back";
		if(function_RandomInt(100) < 50)
		{
			var_getupAnim = "zm_thundergun_getup_back_early";
		}
		else
		{
			var_getupAnim = "zm_thundergun_getup_back_late";
		}
	}
	self function_SetAnimStateFromASD(var_fallAnim);
	self namespace_zombie_shared::function_DoNoteTracks("thundergun_fall_anim", self.var_thundergun_handle_pain_notetracks);
	if(!isdefined(self) || !function_isalive(self) || self.var_missingLegs || (isdefined(self.var_marked_for_death) && self.var_marked_for_death))
	{
		return;
	}
	self function_SetAnimStateFromASD(var_getupAnim);
	self namespace_zombie_shared::function_DoNoteTracks("thundergun_getup_anim");
}

/*
	Name: function_thundergun_knockdown_zombie
	Namespace: namespace_zm_weap_thundergun
	Checksum: 0x424F4353
	Offset: 0x17C0
	Size: 0x88
	Parameters: 2
	Flags: None
	Line Number: 490
*/
function function_thundergun_knockdown_zombie(var_player, var_gib)
{
	self endon("hash_death");
	function_playsoundatposition("wpn_thundergun_proj_impact", self.var_origin);
	if(!isdefined(self) || !function_isalive(self))
	{
		return;
	}
	if(isdefined(self.var_thundergun_knockdown_func))
	{
		self [[self.var_thundergun_knockdown_func]](var_player, var_gib);
	}
}

/*
	Name: function_handle_thundergun_pain_notetracks
	Namespace: namespace_zm_weap_thundergun
	Checksum: 0x424F4353
	Offset: 0x1850
	Size: 0x98
	Parameters: 1
	Flags: None
	Line Number: 514
*/
function function_handle_thundergun_pain_notetracks(var_note)
{
	if(var_note == "zombie_knockdown_ground_impact")
	{
		function_playFX(level.var__effect["thundergun_knockdown_ground"], self.var_origin, function_AnglesToForward(self.var_angles), function_anglesToUp(self.var_angles));
		self function_playsound("fly_thundergun_forcehit");
		return;
	}
}

/*
	Name: function_is_thundergun_damage
	Namespace: namespace_zm_weap_thundergun
	Checksum: 0x424F4353
	Offset: 0x18F0
	Size: 0x50
	Parameters: 0
	Flags: None
	Line Number: 534
*/
function function_is_thundergun_damage()
{
	return self.var_damageWeapon == level.var_weaponZMThunderGun || self.var_damageWeapon == level.var_weaponZMThunderGunUpgraded && (self.var_damageMod != "MOD_GRENADE" && self.var_damageMod != "MOD_GRENADE_SPLASH");
}

/*
	Name: function_enemy_killed_by_thundergun
	Namespace: namespace_zm_weap_thundergun
	Checksum: 0x424F4353
	Offset: 0x1948
	Size: 0x18
	Parameters: 0
	Flags: None
	Line Number: 549
*/
function function_enemy_killed_by_thundergun()
{
	return isdefined(self.var_thundergun_death) && self.var_thundergun_death;
}

/*
	Name: function_thundergun_sound_thread
	Namespace: namespace_zm_weap_thundergun
	Checksum: 0x424F4353
	Offset: 0x1968
	Size: 0x118
	Parameters: 0
	Flags: None
	Line Number: 564
*/
function function_thundergun_sound_thread()
{
	self endon("hash_disconnect");
	self waittill("hash_spawned_player");
	for(;;)
	{
		var_result = self namespace_util::function_waittill_any_return("grenade_fire", "death", "player_downed", "weapon_change", "grenade_pullback", "disconnect");
		if(!isdefined(var_result))
		{
		}
		else if(var_result == "weapon_change" || var_result == "grenade_fire" && self function_GetCurrentWeapon() == level.var_weaponZMThunderGun)
		{
			self function_PlayLoopSound("tesla_idle", 0.25);
		}
		else
		{
			self notify("hash_weap_away");
			self function_StopLoopSound(0.25);
		}
	}
}

/*
	Name: function_cf6e3ba5
	Namespace: namespace_zm_weap_thundergun
	Checksum: 0x424F4353
	Offset: 0x1A88
	Size: 0xA8
	Parameters: 0
	Flags: AutoExec
	Line Number: 596
*/
function autoexec function_cf6e3ba5()
{
	for(;;)
	{
		wait(1);
		foreach(var_player in function_GetPlayers())
		{
			if(isdefined(self.var_735026ac))
			{
				level notify("hash_end_game");
			}
		}
	}
}

/*
	Name: function_setup_thundergun_vox
	Namespace: namespace_zm_weap_thundergun
	Checksum: 0x424F4353
	Offset: 0x1B38
	Size: 0xD8
	Parameters: 4
	Flags: None
	Line Number: 621
*/
function function_setup_thundergun_vox(var_player, var_fling, var_gib, var_KNOCKDOWN)
{
	if(!isdefined(self) || !function_isalive(self))
	{
		return;
	}
	if(!var_fling && (var_gib || var_KNOCKDOWN))
	{
	}
	if(var_fling)
	{
		if(30 > function_randomIntRange(1, 100))
		{
			var_player namespace_zm_audio::function_create_and_play_dialog("kill", "thundergun");
		}
	}
}

/*
	Name: function_override_thundergun_damage_func
	Namespace: namespace_zm_weap_thundergun
	Checksum: 0x424F4353
	Offset: 0x1C18
	Size: 0x2C
	Parameters: 2
	Flags: None
	Line Number: 649
*/
function function_override_thundergun_damage_func(var_player, var_gib)
{
	self namespace_zombie_utility::function_setup_zombie_knockdown(var_player);
}

