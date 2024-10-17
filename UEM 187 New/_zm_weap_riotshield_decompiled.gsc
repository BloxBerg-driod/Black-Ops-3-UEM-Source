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

#namespace riotshield;

/*
	Name: __init__sytem__
	Namespace: riotshield
	Checksum: 0x424F4353
	Offset: 0x570
	Size: 0x40
	Parameters: 0
	Flags: AutoExec
	Line Number: 33
*/
function autoexec __init__sytem__()
{
	system::register("zm_equip_riotshield", &__init__, &__main__, undefined);
	return;
}

/*
	Name: __init__
	Namespace: riotshield
	Checksum: 0x424F4353
	Offset: 0x5B8
	Size: 0x310
	Parameters: 0
	Flags: None
	Line Number: 49
*/
function __init__()
{
	if(!isdefined(level.weaponRiotshield))
	{
		level.weaponRiotshield = getweapon("riotshield");
	}
	clientfield::register("clientuimodel", "zmInventory.shield_health", 11000, 4, "float");
	zombie_utility::set_zombie_var("riotshield_cylinder_radius", 360);
	zombie_utility::set_zombie_var("riotshield_fling_range", 90);
	zombie_utility::set_zombie_var("riotshield_gib_range", 90);
	zombie_utility::set_zombie_var("riotshield_gib_damage", 75);
	zombie_utility::set_zombie_var("riotshield_knockdown_range", 90);
	zombie_utility::set_zombie_var("riotshield_knockdown_damage", 15);
	zombie_utility::set_zombie_var("riotshield_fling_force_melee", 100);
	zombie_utility::set_zombie_var("riotshield_hit_points", 1850);
	zombie_utility::set_zombie_var("riotshield_fling_damage_shield", 100);
	zombie_utility::set_zombie_var("riotshield_knockdown_damage_shield", 15);
	zombie_utility::set_zombie_var("riotshield_juke_damage_shield", 100);
	zombie_utility::set_zombie_var("riotshield_stowed_block_fraction", 1);
	level.riotshield_network_choke_count = 0;
	level.riotshield_gib_refs = [];
	level.riotshield_gib_refs[level.riotshield_gib_refs.size] = "guts";
	level.riotshield_gib_refs[level.riotshield_gib_refs.size] = "right_arm";
	level.riotshield_gib_refs[level.riotshield_gib_refs.size] = "left_arm";
	zm::register_player_damage_callback(&player_damage_override_callback);
	if(!isdefined(level.riotshield_melee))
	{
		level.riotshield_melee = &riotshield_melee;
	}
	if(!isdefined(level.riotshield_melee_power))
	{
		level.riotshield_melee_power = &riotshield_melee;
	}
	if(!isdefined(level.riotshield_damage_callback))
	{
		level.riotshield_damage_callback = &player_damage_shield;
	}
	if(!isdefined(level.should_shield_absorb_damage))
	{
		level.should_shield_absorb_damage = &should_shield_absorb_damage;
	}
	callback::on_connect(&on_player_connect);
}

/*
	Name: __main__
	Namespace: riotshield
	Checksum: 0x424F4353
	Offset: 0x8D0
	Size: 0x8
	Parameters: 0
	Flags: None
	Line Number: 103
*/
function __main__()
{
}

/*
	Name: on_player_connect
	Namespace: riotshield
	Checksum: 0x424F4353
	Offset: 0x8E0
	Size: 0x88
	Parameters: 0
	Flags: None
	Line Number: 117
*/
function on_player_connect()
{
	self.player_shield_reset_health = &player_init_shield_health;
	if(!isdefined(self.player_shield_apply_damage))
	{
		self.player_shield_apply_damage = &player_damage_shield;
	}
	self thread player_watch_weapon_change();
	self thread player_watch_shield_melee();
	self thread player_watch_shield_melee_power();
	return;
	ERROR: Exception occured: Stack empty.
}

/*
	Name: player_init_shield_health
	Namespace: riotshield
	Checksum: 0x424F4353
	Offset: 0x970
	Size: 0x48
	Parameters: 0
	Flags: None
	Line Number: 141
*/
function player_init_shield_health()
{
	self UpdateRiotShieldModel();
	self clientfield::set_player_uimodel("zmInventory.shield_health", 1);
	return 1;
}

/*
	Name: player_set_shield_health
	Namespace: riotshield
	Checksum: 0x424F4353
	Offset: 0x9C0
	Size: 0x58
	Parameters: 2
	Flags: None
	Line Number: 158
*/
function player_set_shield_health(damage, max_damage)
{
	self UpdateRiotShieldModel();
	self clientfield::set_player_uimodel("zmInventory.shield_health", damage / max_damage);
}

/*
	Name: player_shield_absorb_damage
	Namespace: riotshield
	Checksum: 0x424F4353
	Offset: 0xA20
	Size: 0x28
	Parameters: 4
	Flags: None
	Line Number: 174
*/
function player_shield_absorb_damage(eattacker, idamage, shitloc, smeansofdeath)
{
}

/*
	Name: player_shield_facing_attacker
	Namespace: riotshield
	Checksum: 0x424F4353
	Offset: 0xA50
	Size: 0x138
	Parameters: 2
	Flags: None
	Line Number: 188
*/
function player_shield_facing_attacker(vdir, limit)
{
	orientation = self getplayerangles();
	forwardVec = anglestoforward(orientation);
	forwardVec2D = (forwardVec[0], forwardVec[1], 0);
	unitForwardVec2D = vectornormalize(forwardVec2D);
	toFaceeVec = vdir * -1;
	toFaceeVec2D = (toFaceeVec[0], toFaceeVec[1], 0);
	unitToFaceeVec2D = vectornormalize(toFaceeVec2D);
	dotProduct = vectordot(unitForwardVec2D, unitToFaceeVec2D);
	return dotProduct > limit;
	ERROR: Exception occured: Stack empty.
}

/*
	Name: should_shield_absorb_damage
	Namespace: riotshield
	Checksum: 0x424F4353
	Offset: 0xB90
	Size: 0x180
	Parameters: 10
	Flags: None
	Line Number: 212
*/
function should_shield_absorb_damage(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime)
{
	if(isdefined(self.hasRiotShield) && self.hasRiotShield && isdefined(vdir))
	{
		if(isdefined(eattacker) && (isdefined(eattacker.is_zombie) && eattacker.is_zombie || isplayer(eattacker)))
		{
			if(isdefined(self.hasRiotShieldEquipped) && self.hasRiotShieldEquipped)
			{
				if(self player_shield_facing_attacker(vdir, 0.2))
				{
					return 1;
				}
			}
			else if(!isdefined(self.riotshieldEntity))
			{
				if(!self player_shield_facing_attacker(vdir, -0.2))
				{
					return level.zombie_vars["riotshield_stowed_block_fraction"];
				}
			}
			else
			{
				Assert(!isdefined(self.riotshieldEntity), "Dev Block strings are not supported");
			}
			/#
			#/
		}
	}
	return 0;
}

/*
	Name: player_damage_override_callback
	Namespace: riotshield
	Checksum: 0x424F4353
	Offset: 0xD18
	Size: 0x1B8
	Parameters: 10
	Flags: None
	Line Number: 253
*/
function player_damage_override_callback(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime)
{
	friendly_fire = isdefined(eattacker) && eattacker.team === self.team;
	if(isdefined(self.hasRiotShield) && self.hasRiotShield && !friendly_fire)
	{
		fBlockFraction = self [[level.should_shield_absorb_damage]](einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime);
		if(fBlockFraction > 0 && isdefined(self.player_shield_apply_damage))
		{
			iBlocked = int(fBlockFraction * idamage);
			iUnblocked = idamage - iBlocked;
			if(isdefined(self.player_shield_apply_damage))
			{
				self [[self.player_shield_apply_damage]](iBlocked, 0, shitloc == "riotshield", smeansofdeath);
				if(isdefined(self.riotshield_damage_absorb_callback))
				{
					self [[self.riotshield_damage_absorb_callback]](eattacker, iBlocked, shitloc, smeansofdeath);
				}
			}
			return iUnblocked;
		}
	}
	return -1;
}

/*
	Name: player_damage_shield
	Namespace: riotshield
	Checksum: 0x424F4353
	Offset: 0xED8
	Size: 0x220
	Parameters: 4
	Flags: None
	Line Number: 287
*/
function player_damage_shield(idamage, bHeld, fromCode, smod)
{
	if(!isdefined(fromCode))
	{
		fromCode = 0;
	}
	if(!isdefined(smod))
	{
		smod = "MOD_UNKNOWN";
	}
	damageMax = level.weaponRiotshield.weaponstarthitpoints;
	if(isdefined(self.weaponRiotshield))
	{
		damageMax = self.weaponRiotshield.weaponstarthitpoints;
	}
	shieldHealth = damageMax;
	shieldDamage = idamage;
	rumbled = 0;
	if(fromCode)
	{
		shieldDamage = 0;
	}
	shieldHealth = self DamageRiotShield(shieldDamage);
	if(shieldHealth <= 0)
	{
		if(!rumbled)
		{
			self playrumbleonentity("damage_heavy");
			earthquake(1, 0.75, self.origin, 100);
		}
		self thread player_take_riotshield();
	}
	else if(!rumbled)
	{
		self playrumbleonentity("damage_light");
		earthquake(0.5, 0.5, self.origin, 100);
	}
	self playsound("fly_riotshield_zm_impact_zombies");
	self UpdateRiotShieldModel();
	self clientfield::set_player_uimodel("zmInventory.shield_health", shieldHealth / damageMax);
}

/*
	Name: player_watch_weapon_change
	Namespace: riotshield
	Checksum: 0x424F4353
	Offset: 0x1100
	Size: 0x38
	Parameters: 0
	Flags: None
	Line Number: 339
*/
function player_watch_weapon_change()
{
	for(;;)
	{
		self waittill("weapon_change", weapon);
		self UpdateRiotShieldModel();
	}
}

/*
	Name: player_watch_shield_melee
	Namespace: riotshield
	Checksum: 0x424F4353
	Offset: 0x1140
	Size: 0x48
	Parameters: 0
	Flags: None
	Line Number: 358
*/
function player_watch_shield_melee()
{
	for(;;)
	{
		self waittill("weapon_melee", weapon);
		if(weapon.isRiotShield)
		{
			self [[level.riotshield_melee]](weapon);
		}
	}
}

/*
	Name: player_watch_shield_melee_power
	Namespace: riotshield
	Checksum: 0x424F4353
	Offset: 0x1190
	Size: 0x48
	Parameters: 0
	Flags: None
	Line Number: 380
*/
function player_watch_shield_melee_power()
{
	for(;;)
	{
		self waittill("weapon_melee_power", weapon);
		if(weapon.isRiotShield)
		{
			self [[level.riotshield_melee_power]](weapon);
		}
	}
}

/*
	Name: riotshield_fling_zombie
	Namespace: riotshield
	Checksum: 0x424F4353
	Offset: 0x11E0
	Size: 0x120
	Parameters: 3
	Flags: None
	Line Number: 402
*/
function riotshield_fling_zombie(player, fling_vec, index)
{
	if(!isdefined(self) || !isalive(self))
	{
		return;
	}
	if(isdefined(self.ignore_riotshield) && self.ignore_riotshield)
	{
		return;
	}
	if(isdefined(self.riotshield_fling_func))
	{
		self [[self.riotshield_fling_func]](player);
		return;
	}
	damage = 2500;
	self dodamage(damage, player.origin, player, player, "", "MOD_IMPACT");
	if(self.health < 1)
	{
		self.riotshield_death = 1;
		self startragdoll(1);
		self launchragdoll(fling_vec);
	}
}

/*
	Name: zombie_knockdown
	Namespace: riotshield
	Checksum: 0x424F4353
	Offset: 0x1308
	Size: 0xD0
	Parameters: 2
	Flags: None
	Line Number: 437
*/
function zombie_knockdown(player, gib)
{
	damage = level.zombie_vars["riotshield_knockdown_damage"];
	if(isdefined(level.override_riotshield_damage_func))
	{
		self [[level.override_riotshield_damage_func]](player, gib);
	}
	else if(gib)
	{
		self.a.gib_ref = array::random(level.riotshield_gib_refs);
		self thread zombie_death::do_gib();
	}
	self dodamage(damage, player.origin, player);
}

/*
	Name: riotshield_knockdown_zombie
	Namespace: riotshield
	Checksum: 0x424F4353
	Offset: 0x13E0
	Size: 0x128
	Parameters: 2
	Flags: None
	Line Number: 462
*/
function riotshield_knockdown_zombie(player, gib)
{
	self endon("death");
	playsoundatposition("vox_riotshield_forcehit", self.origin);
	playsoundatposition("wpn_riotshield_proj_impact", self.origin);
	if(!isdefined(self) || !isalive(self))
	{
		return;
	}
	if(isdefined(self.riotshield_knockdown_func))
	{
		self [[self.riotshield_knockdown_func]](player, gib);
	}
	else
	{
		self zombie_knockdown(player, gib);
	}
	self dodamage(level.zombie_vars["riotshield_knockdown_damage"], player.origin, player);
	self playsound("fly_riotshield_forcehit");
	return;
}

/*
	Name: riotshield_get_enemies_in_range
	Namespace: riotshield
	Checksum: 0x424F4353
	Offset: 0x1510
	Size: 0x4D0
	Parameters: 0
	Flags: None
	Line Number: 494
*/
function riotshield_get_enemies_in_range()
{
	view_pos = self geteye();
	zombies = array::get_all_closest(view_pos, getaiteamarray(level.zombie_team), undefined, undefined, 2 * level.zombie_vars["riotshield_knockdown_range"]);
	if(!isdefined(zombies))
	{
		return;
	}
	knockdown_range_squared = level.zombie_vars["riotshield_knockdown_range"] * level.zombie_vars["riotshield_knockdown_range"];
	gib_range_squared = level.zombie_vars["riotshield_gib_range"] * level.zombie_vars["riotshield_gib_range"];
	fling_range_squared = level.zombie_vars["riotshield_fling_range"] * level.zombie_vars["riotshield_fling_range"];
	cylinder_radius_squared = level.zombie_vars["riotshield_cylinder_radius"] * level.zombie_vars["riotshield_cylinder_radius"];
	fling_force = level.zombie_vars["riotshield_fling_force_melee"];
	fling_force_v = 0.5;
	forward_view_angles = self getweaponforwarddir();
	end_pos = view_pos + VectorScale(forward_view_angles, level.zombie_vars["riotshield_knockdown_range"]);
	for(i = 0; i < zombies.size; i++)
	{
		if(!isdefined(zombies[i]) || !isalive(zombies[i]))
		{
			continue;
		}
		if(zombies[i].archetype == "margwa")
		{
			continue;
		}
		test_origin = zombies[i] getcentroid();
		test_range_squared = distancesquared(view_pos, test_origin);
		if(test_range_squared > knockdown_range_squared)
		{
			return;
		}
		normal = vectornormalize(test_origin - view_pos);
		dot = vectordot(forward_view_angles, normal);
		if(0 > dot)
		{
			continue;
		}
		radial_origin = PointOnSegmentNearestToPoint(view_pos, end_pos, test_origin);
		if(distancesquared(test_origin, radial_origin) > cylinder_radius_squared)
		{
			continue;
		}
		if(0 == zombies[i] damageconetrace(view_pos, self))
		{
			continue;
		}
		if(test_range_squared < fling_range_squared)
		{
			level.riotshield_fling_enemies[level.riotshield_fling_enemies.size] = zombies[i];
			dist_mult = fling_range_squared - test_range_squared / fling_range_squared;
			fling_vec = vectornormalize(test_origin - view_pos);
			if(5000 < test_range_squared)
			{
				fling_vec = fling_vec + vectornormalize(test_origin - radial_origin);
			}
			fling_vec = (fling_vec[0], fling_vec[1], fling_force_v * abs(fling_vec[2]));
			fling_vec = VectorScale(fling_vec, fling_force + fling_force * dist_mult);
			level.riotshield_fling_vecs[level.riotshield_fling_vecs.size] = fling_vec;
			continue;
		}
		level.riotshield_knockdown_enemies[level.riotshield_knockdown_enemies.size] = zombies[i];
		level.riotshield_knockdown_gib[level.riotshield_knockdown_gib.size] = 0;
	}
}

/*
	Name: riotshield_network_choke
	Namespace: riotshield
	Checksum: 0x424F4353
	Offset: 0x19E8
	Size: 0x50
	Parameters: 0
	Flags: None
	Line Number: 570
*/
function riotshield_network_choke()
{
	level.riotshield_network_choke_count++;
	if(!level.riotshield_network_choke_count % 10)
	{
		util::wait_network_frame();
		util::wait_network_frame();
		util::wait_network_frame();
	}
}

/*
	Name: riotshield_melee
	Namespace: riotshield
	Checksum: 0x424F4353
	Offset: 0x1A40
	Size: 0x1F8
	Parameters: 1
	Flags: None
	Line Number: 591
*/
function riotshield_melee(weapon)
{
	if(!isdefined(level.riotshield_knockdown_enemies))
	{
		level.riotshield_knockdown_enemies = [];
		level.riotshield_knockdown_gib = [];
		level.riotshield_fling_enemies = [];
		level.riotshield_fling_vecs = [];
	}
	self riotshield_get_enemies_in_range();
	shield_damage = 0;
	level.riotshield_network_choke_count = 0;
	for(i = 0; i < level.riotshield_fling_enemies.size; i++)
	{
		riotshield_network_choke();
		if(isdefined(level.riotshield_fling_enemies[i]))
		{
			level.riotshield_fling_enemies[i] thread riotshield_fling_zombie(self, level.riotshield_fling_vecs[i], i);
			shield_damage = shield_damage + level.zombie_vars["riotshield_fling_damage_shield"];
		}
	}
	for(i = 0; i < level.riotshield_knockdown_enemies.size; i++)
	{
		riotshield_network_choke();
		level.riotshield_knockdown_enemies[i] thread riotshield_knockdown_zombie(self, level.riotshield_knockdown_gib[i]);
		shield_damage = shield_damage + level.zombie_vars["riotshield_knockdown_damage_shield"];
	}
	level.riotshield_knockdown_enemies = [];
	level.riotshield_knockdown_gib = [];
	level.riotshield_fling_enemies = [];
	level.riotshield_fling_vecs = [];
	if(shield_damage)
	{
		self player_damage_shield(shield_damage, 0);
	}
}

/*
	Name: UpdateRiotShieldModel
	Namespace: riotshield
	Checksum: 0x424F4353
	Offset: 0x1C40
	Size: 0x1D8
	Parameters: 0
	Flags: None
	Line Number: 638
*/
function UpdateRiotShieldModel()
{
	wait(0.05);
	self.hasRiotShield = 0;
	self.weaponRiotshield = level.weaponnone;
	foreach(weapon in self getweaponslist(1))
	{
		if(weapon.isRiotShield)
		{
			self.hasRiotShield = 1;
			self.weaponRiotshield = weapon;
		}
	}
	current = self getcurrentweapon();
	self.hasRiotShieldEquipped = current.isRiotShield;
	if(self.hasRiotShield)
	{
		self clientfield::set_player_uimodel("hudItems.showDpadDown", 1);
		if(self.hasRiotShieldEquipped)
		{
			self zm_weapons::clear_stowed_weapon();
		}
		else
		{
			self zm_weapons::set_stowed_weapon(self.weaponRiotshield);
		}
	}
	else
	{
		self clientfield::set_player_uimodel("hudItems.showDpadDown", 0);
		self SetStowedWeapon(level.weaponnone);
	}
	self RefreshShieldAttachment();
}

/*
	Name: player_take_riotshield
	Namespace: riotshield
	Checksum: 0x424F4353
	Offset: 0x1E20
	Size: 0x204
	Parameters: 0
	Flags: None
	Line Number: 683
*/
function player_take_riotshield()
{
	self notify("destroy_riotshield");
	current = self getcurrentweapon();
	if(current.isRiotShield)
	{
		if(!self laststand::player_is_in_laststand())
		{
			new_primary = level.weaponnone;
			primaryWeapons = self getweaponslistprimaries();
			for(i = 0; i < primaryWeapons.size; i++)
			{
				if(!primaryWeapons[i].isRiotShield)
				{
					new_primary = primaryWeapons[i];
					break;
				}
			}
			if(new_primary == level.weaponnone)
			{
				self zm_weapons::give_fallback_weapon();
				self switchtoweaponimmediate();
				self playsound("wpn_riotshield_zm_destroy");
			}
			else
			{
				self switchtoweaponimmediate();
				self playsound("wpn_riotshield_zm_destroy");
				self waittill("weapon_change");
			}
		}
	}
	self playsound("zmb_rocketshield_break");
	if(isdefined(self.weaponRiotshield))
	{
		self zm_equipment::take(self.weaponRiotshield);
	}
	else
	{
		self zm_equipment::take(level.weaponRiotshield);
	}
	self.hasRiotShield = 0;
	self.hasRiotShieldEquipped = 0;
}

