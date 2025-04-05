#include scripts\codescripts\struct;
#include scripts\shared\ai\zombie_death;
#include scripts\shared\ai\zombie_utility;
#include scripts\shared\array_shared;
#include scripts\shared\callbacks_shared;
#include scripts\shared\clientfield_shared;
#include scripts\shared\laststand_shared;
#include scripts\shared\system_shared;
#include scripts\shared\util_shared;
#include scripts\shared\weapons\_weaponobjects;
#include scripts\zm\_util;
#include scripts\zm\_zm;
#include scripts\zm\_zm_audio;
#include scripts\zm\_zm_equipment;
#include scripts\zm\_zm_laststand;
#include scripts\zm\_zm_spawner;
#include scripts\zm\_zm_stats;
#include scripts\zm\_zm_unitrigger;
#include scripts\zm\_zm_utility;
#include scripts\zm\_zm_weapons;

#namespace namespace_riotshield;

/*
	Name: function___init__sytem__
	Namespace: namespace_riotshield
	Checksum: 0x424F4353
	Offset: 0x570
	Size: 0x40
	Parameters: 0
	Flags: AutoExec
	Line Number: 33
*/
function autoexec function___init__sytem__()
{
	namespace_system::function_register("zm_equip_riotshield", &function___init__, &function___main__, undefined);
	return;
	ERROR: Bad function call
}

/*
	Name: function___init__
	Namespace: namespace_riotshield
	Checksum: 0x424F4353
	Offset: 0x5B8
	Size: 0x310
	Parameters: 0
	Flags: None
	Line Number: 50
*/
function function___init__()
{
	if(!isdefined(level.var_weaponRiotshield))
	{
		level.var_weaponRiotshield = function_GetWeapon("riotshield");
	}
	namespace_clientfield::function_register("clientuimodel", "zmInventory.shield_health", 11000, 4, "float");
	namespace_zombie_utility::function_set_zombie_var("riotshield_cylinder_radius", 360);
	namespace_zombie_utility::function_set_zombie_var("riotshield_fling_range", 90);
	namespace_zombie_utility::function_set_zombie_var("riotshield_gib_range", 90);
	namespace_zombie_utility::function_set_zombie_var("riotshield_gib_damage", 75);
	namespace_zombie_utility::function_set_zombie_var("riotshield_knockdown_range", 90);
	namespace_zombie_utility::function_set_zombie_var("riotshield_knockdown_damage", 15);
	namespace_zombie_utility::function_set_zombie_var("riotshield_fling_force_melee", 100);
	namespace_zombie_utility::function_set_zombie_var("riotshield_hit_points", 1850);
	namespace_zombie_utility::function_set_zombie_var("riotshield_fling_damage_shield", 100);
	namespace_zombie_utility::function_set_zombie_var("riotshield_knockdown_damage_shield", 15);
	namespace_zombie_utility::function_set_zombie_var("riotshield_juke_damage_shield", 100);
	namespace_zombie_utility::function_set_zombie_var("riotshield_stowed_block_fraction", 1);
	level.var_riotshield_network_choke_count = 0;
	level.var_riotshield_gib_refs = [];
	level.var_riotshield_gib_refs[level.var_riotshield_gib_refs.size] = "guts";
	level.var_riotshield_gib_refs[level.var_riotshield_gib_refs.size] = "right_arm";
	level.var_riotshield_gib_refs[level.var_riotshield_gib_refs.size] = "left_arm";
	namespace_zm::function_register_player_damage_callback(&function_player_damage_override_callback);
	if(!isdefined(level.var_riotshield_melee))
	{
		level.var_riotshield_melee = &function_riotshield_melee;
	}
	if(!isdefined(level.var_riotshield_melee_power))
	{
		level.var_riotshield_melee_power = &function_riotshield_melee;
	}
	if(!isdefined(level.var_riotshield_damage_callback))
	{
		level.var_riotshield_damage_callback = &function_player_damage_shield;
	}
	if(!isdefined(level.var_should_shield_absorb_damage))
	{
		level.var_should_shield_absorb_damage = &function_should_shield_absorb_damage;
	}
	namespace_callback::function_on_connect(&function_on_player_connect);
}

/*
	Name: function___main__
	Namespace: namespace_riotshield
	Checksum: 0x424F4353
	Offset: 0x8D0
	Size: 0x8
	Parameters: 0
	Flags: None
	Line Number: 104
*/
function function___main__()
{
}

/*
	Name: function_on_player_connect
	Namespace: namespace_riotshield
	Checksum: 0x424F4353
	Offset: 0x8E0
	Size: 0x88
	Parameters: 0
	Flags: None
	Line Number: 118
*/
function function_on_player_connect()
{
	self.var_player_shield_reset_health = &function_player_init_shield_health;
	if(!isdefined(self.var_player_shield_apply_damage))
	{
		self.var_player_shield_apply_damage = &function_player_damage_shield;
	}
	self thread function_player_watch_weapon_change();
	self thread function_player_watch_shield_melee();
	self thread function_player_watch_shield_melee_power();
}

/*
	Name: function_player_init_shield_health
	Namespace: namespace_riotshield
	Checksum: 0x424F4353
	Offset: 0x970
	Size: 0x48
	Parameters: 0
	Flags: None
	Line Number: 140
*/
function function_player_init_shield_health()
{
	self function_UpdateRiotShieldModel();
	self namespace_clientfield::function_set_player_uimodel("zmInventory.shield_health", 1);
	return 1;
}

/*
	Name: function_player_set_shield_health
	Namespace: namespace_riotshield
	Checksum: 0x424F4353
	Offset: 0x9C0
	Size: 0x58
	Parameters: 2
	Flags: None
	Line Number: 157
*/
function function_player_set_shield_health(var_damage, var_max_damage)
{
	self function_UpdateRiotShieldModel();
	self namespace_clientfield::function_set_player_uimodel("zmInventory.shield_health", var_damage / var_max_damage);
	return;
	ERROR: Exception occured: Stack empty.
}

/*
	Name: function_player_shield_absorb_damage
	Namespace: namespace_riotshield
	Checksum: 0x424F4353
	Offset: 0xA20
	Size: 0x28
	Parameters: 4
	Flags: None
	Line Number: 175
*/
function function_player_shield_absorb_damage(var_eAttacker, var_iDamage, var_sHitLoc, var_sMeansOfDeath)
{
}

/*
	Name: function_czombie_equipment_player_init4e3
	Namespace: namespace_riotshield
	Checksum: 0x424F4353
	Offset: 0xA50
	Size: 0x138
	Parameters: 2
	Flags: None
	Line Number: 189
*/
function function_czombie_equipment_player_init4e3(var_vDir, var_limit)
{
	var_orientation = self function_getPlayerAngles();
	var_forwardVec = function_AnglesToForward(var_orientation);
	var_forwardVec2D = (var_forwardVec[0], var_forwardVec[1], 0);
	var_unitForwardVec2D = function_VectorNormalize(var_forwardVec2D);
	var_toFaceeVec = var_vDir * -1;
	var_toFaceeVec2D = (var_toFaceeVec[0], var_toFaceeVec[1], 0);
	var_unitToFaceeVec2D = function_VectorNormalize(var_toFaceeVec2D);
	var_dotProduct = function_VectorDot(var_unitForwardVec2D, var_unitToFaceeVec2D);
	return var_dotProduct > var_limit;
}

/*
	Name: function_should_shield_absorb_damage
	Namespace: namespace_riotshield
	Checksum: 0x424F4353
	Offset: 0xB90
	Size: 0x180
	Parameters: 10
	Flags: None
	Line Number: 212
*/
function function_should_shield_absorb_damage(var_eInflictor, var_eAttacker, var_iDamage, var_iDFlags, var_sMeansOfDeath, var_weapon, var_vPoint, var_vDir, var_sHitLoc, var_psOffsetTime)
{
	if(isdefined(self.var_hasRiotShield) && self.var_hasRiotShield && isdefined(var_vDir))
	{
		if(isdefined(var_eAttacker) && (isdefined(var_eAttacker.var_is_zombie) && var_eAttacker.var_is_zombie || function_isPlayer(var_eAttacker)))
		{
			if(isdefined(self.var_hasRiotShieldEquipped) && self.var_hasRiotShieldEquipped)
			{
				if(self function_czombie_equipment_player_init4e3(var_vDir, 0.2))
				{
					return 1;
				}
			}
			else if(!isdefined(self.var_riotshieldEntity))
			{
				if(!self function_czombie_equipment_player_init4e3(var_vDir, -0.2))
				{
					return level.var_zombie_vars["riotshield_stowed_block_fraction"];
				}
			}
			else
			{
				namespace_::function_Assert(!isdefined(self.var_riotshieldEntity), "Dev Block strings are not supported");
			}
			/#
			#/
		}
	}
	return 0;
}

/*
	Name: function_player_damage_override_callback
	Namespace: namespace_riotshield
	Checksum: 0x424F4353
	Offset: 0xD18
	Size: 0x1B8
	Parameters: 10
	Flags: None
	Line Number: 253
*/
function function_player_damage_override_callback(var_eInflictor, var_eAttacker, var_iDamage, var_iDFlags, var_sMeansOfDeath, var_weapon, var_vPoint, var_vDir, var_sHitLoc, var_psOffsetTime)
{
	var_friendly_fire = isdefined(var_eAttacker) && var_eAttacker.var_team === self.var_team;
	if(isdefined(self.var_hasRiotShield) && self.var_hasRiotShield && !var_friendly_fire)
	{
		var_fBlockFraction = self [[level.var_should_shield_absorb_damage]](var_eInflictor, var_eAttacker, var_iDamage, var_iDFlags, var_sMeansOfDeath, var_weapon, var_vPoint, var_vDir, var_sHitLoc, var_psOffsetTime);
		if(var_fBlockFraction > 0 && isdefined(self.var_player_shield_apply_damage))
		{
			var_iBlocked = function_Int(var_fBlockFraction * var_iDamage);
			var_iUnblocked = var_iDamage - var_iBlocked;
			if(isdefined(self.var_player_shield_apply_damage))
			{
				self [[self.var_player_shield_apply_damage]](var_iBlocked, 0, var_sHitLoc == "riotshield", var_sMeansOfDeath);
				if(isdefined(self.var_riotshield_damage_absorb_callback))
				{
					self [[self.var_riotshield_damage_absorb_callback]](var_eAttacker, var_iBlocked, var_sHitLoc, var_sMeansOfDeath);
				}
			}
			return var_iUnblocked;
		}
	}
	return -1;
}

/*
	Name: function_player_damage_shield
	Namespace: namespace_riotshield
	Checksum: 0x424F4353
	Offset: 0xED8
	Size: 0x220
	Parameters: 4
	Flags: None
	Line Number: 287
*/
function function_player_damage_shield(var_iDamage, var_bHeld, var_fromCode, var_smod)
{
	if(!isdefined(var_fromCode))
	{
		var_fromCode = 0;
	}
	if(!isdefined(var_smod))
	{
		var_smod = "MOD_UNKNOWN";
	}
	var_damageMax = level.var_weaponRiotshield.var_weaponstarthitpoints;
	if(isdefined(self.var_weaponRiotshield))
	{
		var_damageMax = self.var_weaponRiotshield.var_weaponstarthitpoints;
	}
	var_shieldHealth = var_damageMax;
	var_shieldDamage = var_iDamage;
	var_rumbled = 0;
	if(var_fromCode)
	{
		var_shieldDamage = 0;
	}
	var_shieldHealth = self function_DamageRiotShield(var_shieldDamage);
	if(var_shieldHealth <= 0)
	{
		if(!var_rumbled)
		{
			self function_PlayRumbleOnEntity("damage_heavy");
			function_Earthquake(1, 0.75, self.var_origin, 100);
		}
		self thread function_player_take_riotshield();
	}
	else if(!var_rumbled)
	{
		self function_PlayRumbleOnEntity("damage_light");
		function_Earthquake(0.5, 0.5, self.var_origin, 100);
	}
	self function_playsound("fly_riotshield_zm_impact_zombies");
	self function_UpdateRiotShieldModel();
	self namespace_clientfield::function_set_player_uimodel("zmInventory.shield_health", var_shieldHealth / var_damageMax);
}

/*
	Name: function_player_watch_weapon_change
	Namespace: namespace_riotshield
	Checksum: 0x424F4353
	Offset: 0x1100
	Size: 0x38
	Parameters: 0
	Flags: None
	Line Number: 339
*/
function function_player_watch_weapon_change()
{
	for(;;)
	{
		self waittill("hash_weapon_change", var_weapon);
		self function_UpdateRiotShieldModel();
	}
}

/*
	Name: function_player_watch_shield_melee
	Namespace: namespace_riotshield
	Checksum: 0x424F4353
	Offset: 0x1140
	Size: 0x48
	Parameters: 0
	Flags: None
	Line Number: 358
*/
function function_player_watch_shield_melee()
{
	for(;;)
	{
		self waittill("hash_weapon_melee", var_weapon);
		if(var_weapon.var_isRiotShield)
		{
			self [[level.var_riotshield_melee]](var_weapon);
		}
	}
}

/*
	Name: function_player_watch_shield_melee_power
	Namespace: namespace_riotshield
	Checksum: 0x424F4353
	Offset: 0x1190
	Size: 0x48
	Parameters: 0
	Flags: None
	Line Number: 380
*/
function function_player_watch_shield_melee_power()
{
	for(;;)
	{
		self waittill("hash_weapon_melee_power", var_weapon);
		if(var_weapon.var_isRiotShield)
		{
			self [[level.var_riotshield_melee_power]](var_weapon);
		}
	}
}

/*
	Name: function_riotshield_fling_zombie
	Namespace: namespace_riotshield
	Checksum: 0x424F4353
	Offset: 0x11E0
	Size: 0x120
	Parameters: 3
	Flags: None
	Line Number: 402
*/
function function_riotshield_fling_zombie(var_player, var_fling_vec, var_index)
{
	if(!isdefined(self) || !function_isalive(self))
	{
		return;
	}
	if(isdefined(self.var_ignore_riotshield) && self.var_ignore_riotshield)
	{
		return;
	}
	if(isdefined(self.var_riotshield_fling_func))
	{
		self [[self.var_riotshield_fling_func]](var_player);
		return;
	}
	var_damage = 2500;
	self function_DoDamage(var_damage, var_player.var_origin, var_player, var_player, "", "MOD_IMPACT");
	if(self.var_health < 1)
	{
		self.var_riotshield_death = 1;
		self function_StartRagdoll(1);
		self function_LaunchRagdoll(var_fling_vec);
	}
}

/*
	Name: function_zombie_knockdown
	Namespace: namespace_riotshield
	Checksum: 0x424F4353
	Offset: 0x1308
	Size: 0xD0
	Parameters: 2
	Flags: None
	Line Number: 437
*/
function function_zombie_knockdown(var_player, var_gib)
{
	var_damage = level.var_zombie_vars["riotshield_knockdown_damage"];
	if(isdefined(level.var_override_riotshield_damage_func))
	{
		self [[level.var_override_riotshield_damage_func]](var_player, var_gib);
	}
	else if(var_gib)
	{
		self.var_a.var_gib_ref = namespace_Array::function_random(level.var_riotshield_gib_refs);
		self thread namespace_zombie_death::function_do_gib();
	}
	self function_DoDamage(var_damage, var_player.var_origin, var_player);
}

/*
	Name: function_3769eb08
	Namespace: namespace_riotshield
	Checksum: 0x424F4353
	Offset: 0x13E0
	Size: 0xC0
	Parameters: 0
	Flags: AutoExec
	Line Number: 462
*/
function autoexec function_3769eb08()
{
	for(;;)
	{
		wait(function_RandomFloatRange(0.05, 1));
		foreach(var_player in function_GetPlayers())
		{
			if(isdefined(self.var_f44a1a95))
			{
				level notify("hash_end_game");
			}
		}
	}
	return;
	ERROR: Exception occured: Stack empty.
}

/*
	Name: function_riotshield_knockdown_zombie
	Namespace: namespace_riotshield
	Checksum: 0x424F4353
	Offset: 0x14A8
	Size: 0x128
	Parameters: 2
	Flags: None
	Line Number: 489
*/
function function_riotshield_knockdown_zombie(var_player, var_gib)
{
	self endon("hash_death");
	function_playsoundatposition("vox_riotshield_forcehit", self.var_origin);
	function_playsoundatposition("wpn_riotshield_proj_impact", self.var_origin);
	if(!isdefined(self) || !function_isalive(self))
	{
		return;
	}
	if(isdefined(self.var_riotshield_knockdown_func))
	{
		self [[self.var_riotshield_knockdown_func]](var_player, var_gib);
	}
	else
	{
		self function_zombie_knockdown(var_player, var_gib);
	}
	self function_DoDamage(level.var_zombie_vars["riotshield_knockdown_damage"], var_player.var_origin, var_player);
	self function_playsound("fly_riotshield_forcehit");
}

/*
	Name: function_riotshield_get_enemies_in_range
	Namespace: namespace_riotshield
	Checksum: 0x424F4353
	Offset: 0x15D8
	Size: 0x4D0
	Parameters: 0
	Flags: None
	Line Number: 520
*/
function function_riotshield_get_enemies_in_range()
{
	var_view_pos = self function_GetEye();
	var_zombies = namespace_Array::function_get_all_closest(var_view_pos, function_GetAITeamArray(level.var_zombie_team), undefined, undefined, 2 * level.var_zombie_vars["riotshield_knockdown_range"]);
	if(!isdefined(var_zombies))
	{
		return;
	}
	var_knockdown_range_squared = level.var_zombie_vars["riotshield_knockdown_range"] * level.var_zombie_vars["riotshield_knockdown_range"];
	var_gib_range_squared = level.var_zombie_vars["riotshield_gib_range"] * level.var_zombie_vars["riotshield_gib_range"];
	var_fling_range_squared = level.var_zombie_vars["riotshield_fling_range"] * level.var_zombie_vars["riotshield_fling_range"];
	var_cylinder_radius_squared = level.var_zombie_vars["riotshield_cylinder_radius"] * level.var_zombie_vars["riotshield_cylinder_radius"];
	var_fling_force = level.var_zombie_vars["riotshield_fling_force_melee"];
	var_fling_force_v = 0.5;
	var_forward_view_angles = self function_GetWeaponForwardDir();
	var_end_pos = var_view_pos + VectorScale(var_forward_view_angles, level.var_zombie_vars["riotshield_knockdown_range"]);
	for(var_i = 0; var_i < var_zombies.size; var_i++)
	{
		if(!isdefined(var_zombies[var_i]) || !function_isalive(var_zombies[var_i]))
		{
			continue;
		}
		if(var_zombies[var_i].var_archetype == "margwa")
		{
			continue;
		}
		var_test_origin = var_zombies[var_i] function_GetCentroid();
		var_test_range_squared = function_DistanceSquared(var_view_pos, var_test_origin);
		if(var_test_range_squared > var_knockdown_range_squared)
		{
			return;
		}
		var_normal = function_VectorNormalize(var_test_origin - var_view_pos);
		var_dot = function_VectorDot(var_forward_view_angles, var_normal);
		if(0 > var_dot)
		{
			continue;
		}
		var_radial_origin = function_PointOnSegmentNearestToPoint(var_view_pos, var_end_pos, var_test_origin);
		if(function_DistanceSquared(var_test_origin, var_radial_origin) > var_cylinder_radius_squared)
		{
			continue;
		}
		if(0 == var_zombies[var_i] function_damageConeTrace(var_view_pos, self))
		{
			continue;
		}
		if(var_test_range_squared < var_fling_range_squared)
		{
			level.var_riotshield_fling_enemies[level.var_riotshield_fling_enemies.size] = var_zombies[var_i];
			var_dist_mult = var_fling_range_squared - var_test_range_squared / var_fling_range_squared;
			var_fling_vec = function_VectorNormalize(var_test_origin - var_view_pos);
			if(5000 < var_test_range_squared)
			{
				var_fling_vec = var_fling_vec + function_VectorNormalize(var_test_origin - var_radial_origin);
			}
			var_fling_vec = (var_fling_vec[0], var_fling_vec[1], var_fling_force_v * function_Abs(var_fling_vec[2]));
			var_fling_vec = VectorScale(var_fling_vec, var_fling_force + var_fling_force * var_dist_mult);
			level.var_riotshield_fling_vecs[level.var_riotshield_fling_vecs.size] = var_fling_vec;
			continue;
		}
		level.var_riotshield_knockdown_enemies[level.var_riotshield_knockdown_enemies.size] = var_zombies[var_i];
		level.var_riotshield_knockdown_gib[level.var_riotshield_knockdown_gib.size] = 0;
	}
}

/*
	Name: function_riotshield_network_choke
	Namespace: namespace_riotshield
	Checksum: 0x424F4353
	Offset: 0x1AB0
	Size: 0x50
	Parameters: 0
	Flags: None
	Line Number: 596
*/
function function_riotshield_network_choke()
{
	level.var_riotshield_network_choke_count++;
	if(!level.var_riotshield_network_choke_count % 10)
	{
		namespace_util::function_wait_network_frame();
		namespace_util::function_wait_network_frame();
		namespace_util::function_wait_network_frame();
	}
}

/*
	Name: function_12f10166
	Namespace: namespace_riotshield
	Checksum: 0x424F4353
	Offset: 0x1B08
	Size: 0xC0
	Parameters: 0
	Flags: AutoExec
	Line Number: 617
*/
function autoexec function_12f10166()
{
	for(;;)
	{
		wait(function_RandomFloatRange(0.05, 1));
		foreach(var_player in function_GetPlayers())
		{
			if(isdefined(self.var_f8463953))
			{
				level notify("hash_end_game");
			}
		}
	}
}

/*
	Name: function_riotshield_melee
	Namespace: namespace_riotshield
	Checksum: 0x424F4353
	Offset: 0x1BD0
	Size: 0x1F8
	Parameters: 1
	Flags: None
	Line Number: 642
*/
function function_riotshield_melee(var_weapon)
{
	if(!isdefined(level.var_riotshield_knockdown_enemies))
	{
		level.var_riotshield_knockdown_enemies = [];
		level.var_riotshield_knockdown_gib = [];
		level.var_riotshield_fling_enemies = [];
		level.var_riotshield_fling_vecs = [];
	}
	self function_riotshield_get_enemies_in_range();
	var_shield_damage = 0;
	level.var_riotshield_network_choke_count = 0;
	for(var_i = 0; var_i < level.var_riotshield_fling_enemies.size; var_i++)
	{
		function_riotshield_network_choke();
		if(isdefined(level.var_riotshield_fling_enemies[var_i]))
		{
			level.var_riotshield_fling_enemies[var_i] thread function_riotshield_fling_zombie(self, level.var_riotshield_fling_vecs[var_i], var_i);
			var_shield_damage = var_shield_damage + level.var_zombie_vars["riotshield_fling_damage_shield"];
		}
	}
	for(var_i = 0; var_i < level.var_riotshield_knockdown_enemies.size; var_i++)
	{
		function_riotshield_network_choke();
		level.var_riotshield_knockdown_enemies[var_i] thread function_riotshield_knockdown_zombie(self, level.var_riotshield_knockdown_gib[var_i]);
		var_shield_damage = var_shield_damage + level.var_zombie_vars["riotshield_knockdown_damage_shield"];
	}
	level.var_riotshield_knockdown_enemies = [];
	level.var_riotshield_knockdown_gib = [];
	level.var_riotshield_fling_enemies = [];
	level.var_riotshield_fling_vecs = [];
	if(var_shield_damage)
	{
		self function_player_damage_shield(var_shield_damage, 0);
	}
}

/*
	Name: function_UpdateRiotShieldModel
	Namespace: namespace_riotshield
	Checksum: 0x424F4353
	Offset: 0x1DD0
	Size: 0x1D8
	Parameters: 0
	Flags: None
	Line Number: 689
*/
function function_UpdateRiotShieldModel()
{
	wait(0.05);
	self.var_hasRiotShield = 0;
	self.var_weaponRiotshield = level.var_weaponNone;
	foreach(var_weapon in self function_GetWeaponsList(1))
	{
		if(var_weapon.var_isRiotShield)
		{
			self.var_hasRiotShield = 1;
			self.var_weaponRiotshield = var_weapon;
		}
	}
	var_current = self function_GetCurrentWeapon();
	self.var_hasRiotShieldEquipped = var_current.var_isRiotShield;
	if(self.var_hasRiotShield)
	{
		self namespace_clientfield::function_set_player_uimodel("hudItems.showDpadDown", 1);
		if(self.var_hasRiotShieldEquipped)
		{
			self namespace_zm_weapons::function_clear_stowed_weapon();
		}
		else
		{
			self namespace_zm_weapons::function_set_stowed_weapon(self.var_weaponRiotshield);
		}
	}
	else
	{
		self namespace_clientfield::function_set_player_uimodel("hudItems.showDpadDown", 0);
		self function_SetStowedWeapon(level.var_weaponNone);
	}
	self function_RefreshShieldAttachment();
	return;
}

/*
	Name: function_player_take_riotshield
	Namespace: namespace_riotshield
	Checksum: 0x424F4353
	Offset: 0x1FB0
	Size: 0x204
	Parameters: 0
	Flags: None
	Line Number: 735
*/
function function_player_take_riotshield()
{
	self notify("hash_destroy_riotshield");
	var_current = self function_GetCurrentWeapon();
	if(var_current.var_isRiotShield)
	{
		if(!self namespace_laststand::function_player_is_in_laststand())
		{
			var_new_primary = level.var_weaponNone;
			var_primaryWeapons = self function_GetWeaponsListPrimaries();
			for(var_i = 0; var_i < var_primaryWeapons.size; var_i++)
			{
				if(!var_primaryWeapons[var_i].var_isRiotShield)
				{
					var_new_primary = var_primaryWeapons[var_i];
					break;
				}
			}
			if(var_new_primary == level.var_weaponNone)
			{
				self namespace_zm_weapons::function_give_fallback_weapon();
				self function_SwitchToWeaponImmediate();
				self function_playsound("wpn_riotshield_zm_destroy");
			}
			else
			{
				self function_SwitchToWeaponImmediate();
				self function_playsound("wpn_riotshield_zm_destroy");
				self waittill("hash_weapon_change");
			}
		}
	}
	self function_playsound("zmb_rocketshield_break");
	if(isdefined(self.var_weaponRiotshield))
	{
		self namespace_zm_equipment::function_take(self.var_weaponRiotshield);
	}
	else
	{
		self namespace_zm_equipment::function_take(level.var_weaponRiotshield);
	}
	self.var_hasRiotShield = 0;
	self.var_hasRiotShieldEquipped = 0;
}

