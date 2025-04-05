#include scripts\codescripts\struct;
#include scripts\shared\aat_shared;
#include scripts\shared\array_shared;
#include scripts\shared\callbacks_shared;
#include scripts\shared\clientfield_shared;
#include scripts\shared\flag_shared;
#include scripts\shared\laststand_shared;
#include scripts\shared\util_shared;
#include scripts\shared\weapons\_weaponobjects;
#include scripts\sphynx\_zm_loot_mode;
#include scripts\sphynx\leveling\_zm_sphynx_leveling;
#include scripts\sphynx\weapons\_zm_weap_changes;
#include scripts\sphynx\weapons\_zm_weapon_drop_system;
#include scripts\zm\_util;
#include scripts\zm\_zm_audio;
#include scripts\zm\_zm_bgb;
#include scripts\zm\_zm_equipment;
#include scripts\zm\_zm_magicbox;
#include scripts\zm\_zm_melee_weapon;
#include scripts\zm\_zm_pack_a_punch_util;
#include scripts\zm\_zm_pers_upgrades_functions;
#include scripts\zm\_zm_placeable_mine;
#include scripts\zm\_zm_score;
#include scripts\zm\_zm_stats;
#include scripts\zm\_zm_unitrigger;
#include scripts\zm\_zm_utility;
#include scripts\zm\_zm_weap_ballistic_knife;
#include scripts\zm\_zm_weapon_upgrade_system;
#include scripts\zm\gametypes\_weapons;

#namespace namespace_zm_weapons;

/*
	Name: function_init
	Namespace: namespace_zm_weapons
	Checksum: 0x424F4353
	Offset: 0x11E0
	Size: 0x770
	Parameters: 0
	Flags: None
	Line Number: 42
*/
function function_init()
{
	level.var_47a8a2a5 = function_Array(function_GetWeapon("cymbal_monkey"), function_GetWeapon("ray_gun"), function_GetWeapon("elemental_bow_wolf_howl4"), function_GetWeapon("elemental_bow_wolf_howl3"), function_GetWeapon("elemental_bow_wolf_howl2"), function_GetWeapon("elemental_bow_wolf_howl1"), function_GetWeapon("elemental_bow_wolf_howl"), function_GetWeapon("elemental_bow_wolf4"), function_GetWeapon("elemental_bow_wolf3"), function_GetWeapon("elemental_bow_wolf2"), function_GetWeapon("elemental_bow_wolf1"), function_GetWeapon("elemental_bow_wolf"), function_GetWeapon("elemental_bow_rune_prison"), function_GetWeapon("elemental_bow_demongate"), function_GetWeapon("elemental_bow_storm"), function_GetWeapon("elemental_bow"), function_GetWeapon("t7_staff_water_upgraded"), function_GetWeapon("t7_staff_lightning_upgraded"), function_GetWeapon("t7_staff_fire_upgraded"), function_GetWeapon("t7_staff_air_upgraded"), function_GetWeapon("t7_staff_water"), function_GetWeapon("t7_staff_lightning"), function_GetWeapon("t7_staff_fire"), function_GetWeapon("t7_staff_air"), function_GetWeapon("staff_air"), function_GetWeapon("staff_lightning"), function_GetWeapon("staff_water"), function_GetWeapon("staff_fire"), function_GetWeapon("t7_shrink_ray_upgraded"), function_GetWeapon("t7_shrink_ray"), function_GetWeapon("t7_hero_mirg2000_upgraded"), function_GetWeapon("t7_hero_mirg2000"), function_GetWeapon("microwavegundw"), function_GetWeapon("microwavegundw_upgraded"), function_GetWeapon("microwavegun"), function_GetWeapon("microwavegun_upgraded"), function_GetWeapon("idgun_genesis_0_upgraded"), function_GetWeapon("idgun_genesis_0"), function_GetWeapon("t7_idgun_genesis_0_upgraded"), function_GetWeapon("t7_idgun_genesis_0"), function_GetWeapon("idgun_upgraded_4"), function_GetWeapon("idgun_4"), function_GetWeapon("idgun_upgraded_3"), function_GetWeapon("idgun_3"), function_GetWeapon("idgun_upgraded_2"), function_GetWeapon("idgun_2"), function_GetWeapon("idgun_upgraded_1"), function_GetWeapon("idgun_1"), function_GetWeapon("idgun_upgraded_0"), function_GetWeapon("idgun_0"), function_GetWeapon("idgun_upgraded"), function_GetWeapon("thundergun_upgraded"), function_GetWeapon("thundergun"), function_GetWeapon("skull_gun"), function_GetWeapon("hero_mirg2000"), function_GetWeapon("glaive_apothicon_3"), function_GetWeapon("glaive_apothicon_2"), function_GetWeapon("glaive_apothicon_1"), function_GetWeapon("glaive_apothicon_0"), function_GetWeapon("raygun_mark2"), function_GetWeapon("tesla_gun"), function_GetWeapon("raygun_mark3"), function_GetWeapon("ray_gun"), function_GetWeapon("hero_annihilator"), function_GetWeapon("hero_gravityspikes_melee"), function_GetWeapon("zod_riotshield"), function_GetWeapon("octobomb"), function_GetWeapon("cymbal_monkey"), function_GetWeapon("bouncingbetty"));
	if(!isdefined(level.var_pack_a_punch_camo_index))
	{
		level.var_pack_a_punch_camo_index = 42;
	}
	if(!isdefined(level.var_weapon_cost_client_filled))
	{
		level.var_weapon_cost_client_filled = 1;
	}
	if(!isdefined(level.var_obsolete_prompt_format_needed))
	{
		level.var_obsolete_prompt_format_needed = 0;
	}
	function_init_weapons();
	function_init_weapon_upgrade();
	level.var__weaponobjects_on_player_connect_override = &function_weaponobjects_on_player_connect_override;
	level.var__zombiemode_check_firesale_loc_valid_func = &function_default_check_firesale_loc_valid_func;
	level.var_MissileEntities = [];
	level thread function_onPlayerConnect();
	level.var_256c9d48 = function_Array();
	level.var_7f7e3195 = 1;
}

/*
	Name: function_onPlayerConnect
	Namespace: namespace_zm_weapons
	Checksum: 0x424F4353
	Offset: 0x1958
	Size: 0x38
	Parameters: 0
	Flags: None
	Line Number: 77
*/
function function_onPlayerConnect()
{
	for(;;)
	{
		level waittill("hash_connecting", var_player);
		var_player thread function_onPlayerSpawned();
	}
}

/*
	Name: function_onPlayerSpawned
	Namespace: namespace_zm_weapons
	Checksum: 0x424F4353
	Offset: 0x1998
	Size: 0x60
	Parameters: 0
	Flags: None
	Line Number: 96
*/
function function_onPlayerSpawned()
{
	self endon("hash_disconnect");
	for(;;)
	{
		self waittill("hash_spawned_player");
		self thread function_watchForGrenadeDuds();
		self thread function_watchForGrenadeLauncherDuds();
		self.var_staticWeaponsStartTime = GetTime();
	}
	return;
}

/*
	Name: function_watchForGrenadeDuds
	Namespace: namespace_zm_weapons
	Checksum: 0x424F4353
	Offset: 0x1A00
	Size: 0xC0
	Parameters: 0
	Flags: None
	Line Number: 119
*/
function function_watchForGrenadeDuds()
{
	self endon("hash_spawned_player");
	self endon("hash_disconnect");
	while(1)
	{
		self waittill("hash_grenade_fire", var_grenade, var_weapon);
		if(!namespace_zm_equipment::function_is_equipment(var_weapon) && !namespace_zm_utility::function_is_placeable_mine(var_weapon))
		{
			var_grenade thread function_checkGrenadeForDud(var_weapon, 1, self);
			var_grenade thread function_watchForScriptExplosion(var_weapon, 1, self);
		}
	}
}

/*
	Name: function_watchForGrenadeLauncherDuds
	Namespace: namespace_zm_weapons
	Checksum: 0x424F4353
	Offset: 0x1AC8
	Size: 0x88
	Parameters: 0
	Flags: None
	Line Number: 144
*/
function function_watchForGrenadeLauncherDuds()
{
	self endon("hash_spawned_player");
	self endon("hash_disconnect");
	while(1)
	{
		self waittill("hash_grenade_launcher_fire", var_grenade, var_weapon);
		var_grenade thread function_checkGrenadeForDud(var_weapon, 0, self);
		var_grenade thread function_watchForScriptExplosion(var_weapon, 0, self);
	}
}

/*
	Name: function_grenade_safe_to_throw
	Namespace: namespace_zm_weapons
	Checksum: 0x424F4353
	Offset: 0x1B58
	Size: 0x40
	Parameters: 2
	Flags: None
	Line Number: 166
*/
function function_grenade_safe_to_throw(var_player, var_weapon)
{
	if(isdefined(level.var_grenade_safe_to_throw))
	{
		return self [[level.var_grenade_safe_to_throw]](var_player, var_weapon);
	}
	return 1;
}

/*
	Name: function_grenade_safe_to_bounce
	Namespace: namespace_zm_weapons
	Checksum: 0x424F4353
	Offset: 0x1BA0
	Size: 0x40
	Parameters: 2
	Flags: None
	Line Number: 185
*/
function function_grenade_safe_to_bounce(var_player, var_weapon)
{
	if(isdefined(level.var_grenade_safe_to_bounce))
	{
		return self [[level.var_grenade_safe_to_bounce]](var_player, var_weapon);
	}
	return 1;
}

/*
	Name: function_makeGrenadeDudAndDestroy
	Namespace: namespace_zm_weapons
	Checksum: 0x424F4353
	Offset: 0x1BE8
	Size: 0x50
	Parameters: 0
	Flags: None
	Line Number: 204
*/
function function_makeGrenadeDudAndDestroy()
{
	self endon("hash_death");
	self notify("hash_grenade_dud");
	self function_makeGrenadeDud();
	wait(3);
	if(isdefined(self))
	{
		self function_delete();
	}
}

/*
	Name: function_checkGrenadeForDud
	Namespace: namespace_zm_weapons
	Checksum: 0x424F4353
	Offset: 0x1C40
	Size: 0xF8
	Parameters: 3
	Flags: None
	Line Number: 226
*/
function function_checkGrenadeForDud(var_weapon, var_isThrownGrenade, var_player)
{
	self endon("hash_death");
	var_player endon("hash_zombify");
	if(!isdefined(self))
	{
		return;
	}
	if(!self function_grenade_safe_to_throw(var_player, var_weapon))
	{
		self thread function_makeGrenadeDudAndDestroy();
		return;
	}
	for(;;)
	{
		self namespace_util::function_waittill_any_ex(0.25, "grenade_bounce", "stationary", "death", var_player, "zombify");
		if(!self function_grenade_safe_to_bounce(var_player, var_weapon))
		{
			self thread function_makeGrenadeDudAndDestroy();
			return;
		}
	}
}

/*
	Name: function_wait_explode
	Namespace: namespace_zm_weapons
	Checksum: 0x424F4353
	Offset: 0x1D40
	Size: 0x60
	Parameters: 0
	Flags: None
	Line Number: 260
*/
function function_wait_explode()
{
	self endon("hash_grenade_dud");
	self endon("hash_done");
	self waittill("hash_explode", var_position);
	level.var_explode_position = var_position;
	level.var_explode_position_valid = 1;
	self notify("hash_done");
}

/*
	Name: function_wait_timeout
	Namespace: namespace_zm_weapons
	Checksum: 0x424F4353
	Offset: 0x1DA8
	Size: 0x50
	Parameters: 1
	Flags: None
	Line Number: 280
*/
function function_wait_timeout(var_time)
{
	self endon("hash_grenade_dud");
	self endon("hash_done");
	self endon("hash_explode");
	wait(var_time);
	if(isdefined(self))
	{
		self notify("hash_done");
		return;
	}
	~;
}

/*
	Name: function_wait_for_explosion
	Namespace: namespace_zm_weapons
	Checksum: 0x424F4353
	Offset: 0x1E00
	Size: 0x80
	Parameters: 1
	Flags: None
	Line Number: 304
*/
function function_wait_for_explosion(var_time)
{
	level.var_explode_position = (0, 0, 0);
	level.var_explode_position_valid = 0;
	self thread function_wait_explode();
	self thread function_wait_timeout(var_time);
	self waittill("hash_done");
	self notify("hash_death_or_explode", level.var_explode_position_valid, level.var_explode_position);
	return;
}

/*
	Name: function_watchForScriptExplosion
	Namespace: namespace_zm_weapons
	Checksum: 0x424F4353
	Offset: 0x1E88
	Size: 0xB0
	Parameters: 3
	Flags: None
	Line Number: 325
*/
function function_watchForScriptExplosion(var_weapon, var_isThrownGrenade, var_player)
{
	self endon("hash_grenade_dud");
	if(namespace_zm_utility::function_is_lethal_grenade(var_weapon) || var_weapon.var_isLauncher)
	{
		self thread function_wait_for_explosion(20);
		self waittill("hash_death_or_explode", var_exploded, var_position);
		if(var_exploded)
		{
			level notify("hash_grenade_exploded", var_position, 256, 300, 75);
		}
	}
}

/*
	Name: function_get_nonalternate_weapon
	Namespace: namespace_zm_weapons
	Checksum: 0x424F4353
	Offset: 0x1F40
	Size: 0x30
	Parameters: 1
	Flags: None
	Line Number: 349
*/
function function_get_nonalternate_weapon(var_weapon)
{
	if(var_weapon.var_isAltMode)
	{
		return var_weapon.var_altweapon;
	}
	return var_weapon;
}

/*
	Name: function_switch_from_alt_weapon
	Namespace: namespace_zm_weapons
	Checksum: 0x424F4353
	Offset: 0x1F78
	Size: 0xB8
	Parameters: 1
	Flags: None
	Line Number: 368
*/
function function_switch_from_alt_weapon(var_weapon)
{
	if(var_weapon.var_ischargeshot)
	{
		return var_weapon;
	}
	var_alt = function_get_nonalternate_weapon(var_weapon);
	if(var_alt != var_weapon)
	{
		if(!function_WeaponHasAttachment(var_weapon, "dualoptic"))
		{
			self function_SwitchToWeaponImmediate(var_alt);
			self namespace_util::function_waittill_any_timeout(1, "weapon_change_complete");
		}
		return var_alt;
	}
	return var_weapon;
}

/*
	Name: function_give_start_weapons
	Namespace: namespace_zm_weapons
	Checksum: 0x424F4353
	Offset: 0x2038
	Size: 0x50
	Parameters: 2
	Flags: None
	Line Number: 397
*/
function function_give_start_weapons(var_TakeAllWeapons, var_alreadySpawned)
{
	self function_GiveWeapon(level.var_weaponBaseMelee);
	self namespace_zm_utility::function_give_start_weapon(1);
}

/*
	Name: function_give_fallback_weapon
	Namespace: namespace_zm_weapons
	Checksum: 0x424F4353
	Offset: 0x2090
	Size: 0x38
	Parameters: 1
	Flags: None
	Line Number: 413
*/
function function_give_fallback_weapon(var_immediate)
{
	if(!isdefined(var_immediate))
	{
		var_immediate = 0;
	}
	namespace_zm_melee_weapon::function_give_fallback_weapon(var_immediate);
}

/*
	Name: function_take_fallback_weapon
	Namespace: namespace_zm_weapons
	Checksum: 0x424F4353
	Offset: 0x20D0
	Size: 0x18
	Parameters: 0
	Flags: None
	Line Number: 432
*/
function function_take_fallback_weapon()
{
	namespace_zm_melee_weapon::function_take_fallback_weapon();
}

/*
	Name: function_switch_back_primary_weapon
	Namespace: namespace_zm_weapons
	Checksum: 0x424F4353
	Offset: 0x20F0
	Size: 0x228
	Parameters: 2
	Flags: None
	Line Number: 447
*/
function function_switch_back_primary_weapon(var_oldprimary, var_immediate)
{
	if(!isdefined(var_immediate))
	{
		var_immediate = 0;
	}
	if(isdefined(self.var_laststand) && self.var_laststand)
	{
		return;
	}
	if(!isdefined(var_oldprimary) || var_oldprimary == level.var_weaponNone || var_oldprimary.var_isFlourishWeapon || namespace_zm_utility::function_is_melee_weapon(var_oldprimary) || namespace_zm_utility::function_is_placeable_mine(var_oldprimary) || namespace_zm_utility::function_is_lethal_grenade(var_oldprimary) || namespace_zm_utility::function_is_tactical_grenade(var_oldprimary) || !self function_HasWeapon(var_oldprimary))
	{
		var_oldprimary = undefined;
	}
	else if(var_oldprimary.var_isHeroWeapon || var_oldprimary.var_isgadget && (!isdefined(self.var_hero_power) || self.var_hero_power <= 0))
	{
		var_oldprimary = undefined;
	}
	var_primaryWeapons = self function_GetWeaponsListPrimaries();
	if(isdefined(var_oldprimary) && function_IsInArray(var_primaryWeapons, var_oldprimary))
	{
		if(var_immediate)
		{
			self function_SwitchToWeaponImmediate(var_oldprimary);
		}
		else
		{
			self function_SwitchToWeapon(var_oldprimary);
		}
	}
	else if(var_primaryWeapons.size > 0)
	{
		if(var_immediate)
		{
			self function_SwitchToWeaponImmediate();
		}
		else
		{
			self function_SwitchToWeapon();
		}
	}
	else
	{
		function_give_fallback_weapon(var_immediate);
	}
}

/*
	Name: function_add_retrievable_knife_init_name
	Namespace: namespace_zm_weapons
	Checksum: 0x424F4353
	Offset: 0x2320
	Size: 0x40
	Parameters: 1
	Flags: None
	Line Number: 504
*/
function function_add_retrievable_knife_init_name(var_name)
{
	if(!isdefined(level.var_retrievable_knife_init_names))
	{
		level.var_retrievable_knife_init_names = [];
	}
	level.var_retrievable_knife_init_names[level.var_retrievable_knife_init_names.size] = var_name;
}

/*
	Name: function_watchWeaponUsageZM
	Namespace: namespace_zm_weapons
	Checksum: 0x424F4353
	Offset: 0x2368
	Size: 0x118
	Parameters: 0
	Flags: None
	Line Number: 523
*/
function function_watchWeaponUsageZM()
{
	self endon("hash_death");
	self endon("hash_disconnect");
	level endon("hash_game_ended");
	for(;;)
	{
		self waittill("hash_weapon_fired", var_curWeapon);
		self.var_lastFireTime = GetTime();
		self.var_hasDoneCombat = 1;
		switch(var_curWeapon.var_weapClass)
		{
			case "mg":
			case "pistol":
			case "pistol spread":
			case "pistolspread":
			case "rifle":
			case "smg":
			case "spread":
			{
				self namespace_weapons::function_trackWeaponFire(var_curWeapon);
				level.var_globalShotsFired++;
				break;
			}
			case "grenade":
			case "rocketlauncher":
			{
				self function_addweaponstat(var_curWeapon, "shots", 1);
				break;
				break;
			}
			default
			{
			}
		}
	}
}

/*
	Name: function_trackWeaponZM
	Namespace: namespace_zm_weapons
	Checksum: 0x424F4353
	Offset: 0x2488
	Size: 0x168
	Parameters: 0
	Flags: None
	Line Number: 571
*/
function function_trackWeaponZM()
{
	self.var_currentWeapon = self function_GetCurrentWeapon();
	self.var_currentTime = GetTime();
	var_spawnid = function_getplayerspawnid(self);
	while(1)
	{
		var_event = self namespace_util::function_waittill_any_return("weapon_change", "death", "disconnect", "bled_out");
		var_newTime = GetTime();
		if(var_event == "weapon_change")
		{
			var_newWeapon = self function_GetCurrentWeapon();
			if(var_newWeapon != level.var_weaponNone && var_newWeapon != self.var_currentWeapon)
			{
				function_updateLastHeldWeaponTimingsZM(var_newTime);
				self.var_currentWeapon = var_newWeapon;
				self.var_currentTime = var_newTime;
			}
		}
		else if(var_event != "death" && var_event != "disconnect")
		{
			function_updateWeaponTimingsZM(var_newTime);
			return;
		}
	}
}

/*
	Name: function_updateLastHeldWeaponTimingsZM
	Namespace: namespace_zm_weapons
	Checksum: 0x424F4353
	Offset: 0x25F8
	Size: 0xA0
	Parameters: 1
	Flags: None
	Line Number: 608
*/
function function_updateLastHeldWeaponTimingsZM(var_newTime)
{
	if(isdefined(self.var_currentWeapon) && isdefined(self.var_currentTime))
	{
		var_curWeapon = self.var_currentWeapon;
		var_totalTime = function_Int(var_newTime - self.var_currentTime / 1000);
		if(var_totalTime > 0)
		{
			self function_addweaponstat(var_curWeapon, "timeUsed", var_totalTime);
		}
	}
}

/*
	Name: function_updateWeaponTimingsZM
	Namespace: namespace_zm_weapons
	Checksum: 0x424F4353
	Offset: 0x26A0
	Size: 0x98
	Parameters: 1
	Flags: None
	Line Number: 631
*/
function function_updateWeaponTimingsZM(var_newTime)
{
	if(self namespace_util::function_is_bot())
	{
		return;
	}
	function_updateLastHeldWeaponTimingsZM(var_newTime);
	if(!isdefined(self.var_staticWeaponsStartTime))
	{
		return;
	}
	var_totalTime = function_Int(var_newTime - self.var_staticWeaponsStartTime / 1000);
	if(var_totalTime < 0)
	{
		return;
	}
	self.var_staticWeaponsStartTime = var_newTime;
}

/*
	Name: function_watchWeaponChangeZM
	Namespace: namespace_zm_weapons
	Checksum: 0x424F4353
	Offset: 0x2740
	Size: 0xC8
	Parameters: 0
	Flags: None
	Line Number: 660
*/
function function_watchWeaponChangeZM()
{
	self endon("hash_death");
	self endon("hash_disconnect");
	self.var_lastdroppableweapon = self function_GetCurrentWeapon();
	self.var_hitsThisMag = [];
	var_weapon = self function_GetCurrentWeapon();
	while(1)
	{
		var_previous_weapon = self function_GetCurrentWeapon();
		self waittill("hash_weapon_change", var_newWeapon);
		if(namespace_weapons::function_mayDropWeapon(var_newWeapon))
		{
			self.var_lastdroppableweapon = var_newWeapon;
		}
	}
}

/*
	Name: function_weaponobjects_on_player_connect_override_internal
	Namespace: namespace_zm_weapons
	Checksum: 0x424F4353
	Offset: 0x2810
	Size: 0x158
	Parameters: 0
	Flags: None
	Line Number: 688
*/
function function_weaponobjects_on_player_connect_override_internal()
{
	self namespace_weaponobjects::function_createBaseWatchers();
	self namespace_zm_placeable_mine::function_setup_watchers();
	for(var_i = 0; var_i < level.var_retrievable_knife_init_names.size; var_i++)
	{
		self function_createBallisticKnifeWatcher_zm(level.var_retrievable_knife_init_names[var_i]);
	}
	self namespace_weaponobjects::function_setupRetrievableWatcher();
	if(!isdefined(self.var_weaponObjectWatcherArray))
	{
		self.var_weaponObjectWatcherArray = [];
	}
	self.var_concussionEndTime = 0;
	self.var_hasDoneCombat = 0;
	self.var_lastFireTime = 0;
	self thread function_watchWeaponUsageZM();
	self thread namespace_weapons::function_watchGrenadeUsage();
	self thread namespace_weapons::function_watchMissileUsage();
	self thread function_watchWeaponChangeZM();
	self thread function_trackWeaponZM();
	self notify("hash_weapon_watchers_created");
}

/*
	Name: function_weaponobjects_on_player_connect_override
	Namespace: namespace_zm_weapons
	Checksum: 0x424F4353
	Offset: 0x2970
	Size: 0x58
	Parameters: 0
	Flags: None
	Line Number: 722
*/
function function_weaponobjects_on_player_connect_override()
{
	function_add_retrievable_knife_init_name("knife_ballistic");
	function_add_retrievable_knife_init_name("knife_ballistic_upgraded");
	namespace_callback::function_on_connect(&function_weaponobjects_on_player_connect_override_internal);
}

/*
	Name: function_createBallisticKnifeWatcher_zm
	Namespace: namespace_zm_weapons
	Checksum: 0x424F4353
	Offset: 0x29D0
	Size: 0x90
	Parameters: 1
	Flags: None
	Line Number: 739
*/
function function_createBallisticKnifeWatcher_zm(var_weaponName)
{
	var_watcher = self namespace_weaponobjects::function_createUseWeaponObjectWatcher(var_weaponName, self.var_team);
	var_watcher.var_onSpawn = &namespace__zm_weap_ballistic_knife::function_on_spawn;
	var_watcher.var_onSpawnRetrieveTriggers = &namespace__zm_weap_ballistic_knife::function_on_spawn_retrieve_trigger;
	var_watcher.var_storeDifferentObject = 1;
	var_watcher.var_headicon = 0;
	return;
	ERROR: Exception occured: Stack empty.
}

/*
	Name: function_default_check_firesale_loc_valid_func
	Namespace: namespace_zm_weapons
	Checksum: 0x424F4353
	Offset: 0x2A68
	Size: 0x8
	Parameters: 0
	Flags: None
	Line Number: 760
*/
function function_default_check_firesale_loc_valid_func()
{
	return 1;
}

/*
	Name: function_add_zombie_weapon
	Namespace: namespace_zm_weapons
	Checksum: 0x424F4353
	Offset: 0x2A78
	Size: 0x470
	Parameters: 10
	Flags: None
	Line Number: 775
*/
function function_add_zombie_weapon(var_weapon_name, var_upgrade_name, var_hint, var_cost, var_weaponVO, var_weaponVOresp, var_ammo_cost, var_create_vox, var_is_wonder_weapon, var_force_attachments)
{
	var_weapon = function_GetWeapon(var_weapon_name);
	var_upgrade = undefined;
	if(isdefined(var_upgrade_name))
	{
		var_upgrade = function_GetWeapon(var_upgrade_name);
	}
	if(isdefined(level.var_zombie_include_weapons) && !isdefined(level.var_zombie_include_weapons[var_weapon]))
	{
		return;
	}
	var_struct = function_spawnstruct();
	if(!isdefined(level.var_zombie_weapons))
	{
		level.var_zombie_weapons = [];
	}
	if(!isdefined(level.var_zombie_weapons_upgraded))
	{
		level.var_zombie_weapons_upgraded = [];
	}
	if(isdefined(var_upgrade_name))
	{
		level.var_zombie_weapons_upgraded[var_upgrade] = var_weapon;
	}
	var_struct.var_weapon = var_weapon;
	var_struct.var_upgrade = var_upgrade;
	var_struct.var_weapon_classname = "weapon_" + var_weapon_name + "_zm";
	if(isdefined(level.var_weapon_cost_client_filled) && level.var_weapon_cost_client_filled)
	{
		var_struct.var_hint = &"ZOMBIE_WEAPONCOSTONLY_CFILL";
	}
	else
	{
		var_struct.var_hint = &"ZOMBIE_WEAPONCOSTONLYFILL";
	}
	var_struct.var_cost = var_cost;
	var_struct.var_vox = var_weaponVO;
	var_struct.var_vox_response = var_weaponVOresp;
	var_struct.var_is_wonder_weapon = var_is_wonder_weapon;
	var_struct.var_force_attachments = [];
	if("" != var_force_attachments)
	{
		var_force_attachments_list = function_StrTok(var_force_attachments, " ");
		/#
			namespace_::function_Assert(6 >= var_force_attachments_list.size, var_weapon_name + "Dev Block strings are not supported");
		#/
		foreach(var_attachment in var_force_attachments_list)
		{
			var_struct.var_force_attachments[var_struct.var_force_attachments.size] = var_attachment;
		}
	}
	var_struct.var_is_in_box = level.var_zombie_include_weapons[var_weapon];
	if(!isdefined(var_ammo_cost))
	{
		var_ammo_cost = namespace_zm_utility::function_round_up_to_ten(function_Int(var_cost * 0.5));
	}
	var_struct.var_ammo_cost = var_ammo_cost;
	if(var_weapon.var_isEmp || (isdefined(var_upgrade) && var_upgrade.var_isEmp))
	{
		level.var_should_watch_for_emp = 1;
	}
	level.var_zombie_weapons[var_weapon] = var_struct;
	if(namespace_zm_pap_util::function_can_swap_attachments() && isdefined(var_upgrade_name))
	{
		function_add_attachments(var_weapon_name, var_upgrade_name);
	}
	if(isdefined(var_create_vox))
	{
		level.var_vox namespace_zm_audio::function_zmbVoxAdd("player", "weapon_pickup", var_weapon, var_weaponVO, undefined);
	}
}

/*
	Name: function_add_attachments
	Namespace: namespace_zm_weapons
	Checksum: 0x424F4353
	Offset: 0x2EF0
	Size: 0x1A8
	Parameters: 2
	Flags: None
	Line Number: 858
*/
function function_add_attachments(var_weapon, var_upgrade)
{
	var_table = "gamedata/weapons/zm/pap_attach.csv";
	if(isdefined(level.var_weapon_attachment_table))
	{
		var_table = level.var_weapon_attachment_table;
	}
	var_row = function_TableLookupRowNum(var_table, 0, var_upgrade);
	if(var_row > -1)
	{
		level.var_zombie_weapons[var_weapon].var_default_attachment = function_tableLookup(var_table, 0, var_upgrade.var_name, 1);
		level.var_zombie_weapons[var_weapon].var_addon_attachments = [];
		var_index = 2;
		for(var_next_addon = function_tableLookup(var_table, 0, var_upgrade.var_name, var_index); isdefined(var_next_addon) && var_next_addon.size > 0; var_next_addon = function_tableLookup(var_table, 0, var_upgrade.var_name, var_index))
		{
			level.var_zombie_weapons[var_weapon].var_addon_attachments[level.var_zombie_weapons[var_weapon].var_addon_attachments.size] = var_next_addon;
			var_index++;
		}
	}
}

/*
	Name: function_is_weapon_included
	Namespace: namespace_zm_weapons
	Checksum: 0x424F4353
	Offset: 0x30A0
	Size: 0x58
	Parameters: 1
	Flags: None
	Line Number: 889
*/
function function_is_weapon_included(var_weapon)
{
	if(!isdefined(level.var_zombie_weapons))
	{
		return 0;
	}
	var_weapon = function_get_nonalternate_weapon(var_weapon);
	return isdefined(level.var_zombie_weapons[var_weapon.var_rootweapon]);
	var_weapon++;
}

/*
	Name: function_is_weapon_or_base_included
	Namespace: namespace_zm_weapons
	Checksum: 0x424F4353
	Offset: 0x3100
	Size: 0x68
	Parameters: 1
	Flags: None
	Line Number: 910
*/
function function_is_weapon_or_base_included(var_weapon)
{
	var_weapon = function_get_nonalternate_weapon(var_weapon);
	return isdefined(level.var_zombie_weapons[var_weapon.var_rootweapon]) || isdefined(level.var_zombie_weapons[function_get_base_weapon(var_weapon)]);
}

/*
	Name: function_include_zombie_weapon
	Namespace: namespace_zm_weapons
	Checksum: 0x424F4353
	Offset: 0x3170
	Size: 0x68
	Parameters: 2
	Flags: None
	Line Number: 926
*/
function function_include_zombie_weapon(var_weapon_name, var_in_box)
{
	if(!isdefined(level.var_zombie_include_weapons))
	{
		level.var_zombie_include_weapons = [];
	}
	if(!isdefined(var_in_box))
	{
		var_in_box = 1;
	}
	level.var_zombie_include_weapons[function_GetWeapon(var_weapon_name)] = var_in_box;
}

/*
	Name: function_init_weapons
	Namespace: namespace_zm_weapons
	Checksum: 0x424F4353
	Offset: 0x31E0
	Size: 0x20
	Parameters: 0
	Flags: None
	Line Number: 949
*/
function function_init_weapons()
{
	if(isdefined(level.var__zombie_custom_add_weapons))
	{
		[[level.var__zombie_custom_add_weapons]]();
	}
}

/*
	Name: function_add_limited_weapon
	Namespace: namespace_zm_weapons
	Checksum: 0x424F4353
	Offset: 0x3208
	Size: 0x50
	Parameters: 2
	Flags: None
	Line Number: 967
*/
function function_add_limited_weapon(var_weapon_name, var_amount)
{
	if(!isdefined(level.var_limited_weapons))
	{
		level.var_limited_weapons = [];
	}
	level.var_limited_weapons[function_GetWeapon(var_weapon_name)] = var_amount;
}

/*
	Name: function_limited_weapon_below_quota
	Namespace: namespace_zm_weapons
	Checksum: 0x424F4353
	Offset: 0x3260
	Size: 0x3F8
	Parameters: 3
	Flags: None
	Line Number: 986
*/
function function_limited_weapon_below_quota(var_weapon, var_ignore_player, var_pap_triggers)
{
	if(isdefined(level.var_limited_weapons[var_weapon]))
	{
		if(!isdefined(var_pap_triggers))
		{
			var_pap_triggers = namespace_zm_pap_util::function_get_triggers();
		}
		if(isdefined(level.var_no_limited_weapons) && level.var_no_limited_weapons)
		{
			return 0;
		}
		var_upgradedweapon = var_weapon;
		if(isdefined(level.var_zombie_weapons[var_weapon]) && isdefined(level.var_zombie_weapons[var_weapon].var_upgrade))
		{
			var_upgradedweapon = level.var_zombie_weapons[var_weapon].var_upgrade;
		}
		var_players = function_GetPlayers();
		var_count = 0;
		var_limit = level.var_limited_weapons[var_weapon];
		for(var_i = 0; var_i < var_players.size; var_i++)
		{
			if(isdefined(var_ignore_player) && var_ignore_player == var_players[var_i])
			{
				continue;
			}
			if(var_players[var_i] function_has_weapon_or_upgrade(var_weapon))
			{
				var_count++;
				if(var_count >= var_limit)
				{
					return 0;
				}
			}
		}
		for(var_K = 0; var_K < var_pap_triggers.size; var_K++)
		{
			if(isdefined(var_pap_triggers[var_K].var_current_weapon) && (var_pap_triggers[var_K].var_current_weapon == var_weapon || var_pap_triggers[var_K].var_current_weapon == var_upgradedweapon))
			{
				var_count++;
				if(var_count >= var_limit)
				{
					return 0;
				}
			}
		}
		for(var_chestIndex = 0; var_chestIndex < level.var_chests.size; var_chestIndex++)
		{
			if(isdefined(level.var_chests[var_chestIndex].var_zbarrier.var_weapon) && level.var_chests[var_chestIndex].var_zbarrier.var_weapon == var_weapon)
			{
				var_count++;
				if(var_count >= var_limit)
				{
					return 0;
				}
			}
		}
		if(isdefined(level.var_custom_limited_weapon_checks))
		{
			foreach(var_Check in level.var_custom_limited_weapon_checks)
			{
				var_count = var_count + [[var_Check]](var_weapon);
			}
			if(var_count >= var_limit)
			{
				return 0;
			}
		}
		if(isdefined(level.var_random_weapon_powerups))
		{
			for(var_powerupIndex = 0; var_powerupIndex < level.var_random_weapon_powerups.size; var_powerupIndex++)
			{
				if(isdefined(level.var_random_weapon_powerups[var_powerupIndex]) && level.var_random_weapon_powerups[var_powerupIndex].var_base_weapon == var_weapon)
				{
					var_count++;
					if(var_count >= var_limit)
					{
						return 0;
					}
				}
			}
		}
	}
	return 1;
}

/*
	Name: function_add_custom_limited_weapon_check
	Namespace: namespace_zm_weapons
	Checksum: 0x424F4353
	Offset: 0x3660
	Size: 0x40
	Parameters: 1
	Flags: None
	Line Number: 1082
*/
function function_add_custom_limited_weapon_check(var_callback)
{
	if(!isdefined(level.var_custom_limited_weapon_checks))
	{
		level.var_custom_limited_weapon_checks = [];
	}
	level.var_custom_limited_weapon_checks[level.var_custom_limited_weapon_checks.size] = var_callback;
}

/*
	Name: function_add_weapon_to_content
	Namespace: namespace_zm_weapons
	Checksum: 0x424F4353
	Offset: 0x36A8
	Size: 0x50
	Parameters: 2
	Flags: None
	Line Number: 1101
*/
function function_add_weapon_to_content(var_weapon_name, var_package)
{
	if(!isdefined(level.var_content_weapons))
	{
		level.var_content_weapons = [];
	}
	level.var_content_weapons[function_GetWeapon(var_weapon_name)] = var_package;
}

/*
	Name: function_player_can_use_content
	Namespace: namespace_zm_weapons
	Checksum: 0x424F4353
	Offset: 0x3700
	Size: 0x50
	Parameters: 1
	Flags: None
	Line Number: 1120
*/
function function_player_can_use_content(var_weapon)
{
	if(isdefined(level.var_content_weapons))
	{
		if(isdefined(level.var_content_weapons[var_weapon]))
		{
			return self function_HasDLCAvailable(level.var_content_weapons[var_weapon]);
		}
	}
	return 1;
}

/*
	Name: function_init_spawnable_weapon_upgrade
	Namespace: namespace_zm_weapons
	Checksum: 0x424F4353
	Offset: 0x3758
	Size: 0xC68
	Parameters: 0
	Flags: None
	Line Number: 1142
*/
function function_init_spawnable_weapon_upgrade()
{
	var_spawn_list = [];
	var_spawnable_weapon_spawns = namespace_struct::function_get_array("weapon_upgrade", "targetname");
	var_spawnable_weapon_spawns = function_ArrayCombine(var_spawnable_weapon_spawns, namespace_struct::function_get_array("bowie_upgrade", "targetname"), 1, 0);
	var_spawnable_weapon_spawns = function_ArrayCombine(var_spawnable_weapon_spawns, namespace_struct::function_get_array("sickle_upgrade", "targetname"), 1, 0);
	var_spawnable_weapon_spawns = function_ArrayCombine(var_spawnable_weapon_spawns, namespace_struct::function_get_array("tazer_upgrade", "targetname"), 1, 0);
	var_spawnable_weapon_spawns = function_ArrayCombine(var_spawnable_weapon_spawns, namespace_struct::function_get_array("buildable_wallbuy", "targetname"), 1, 0);
	if(isdefined(level.var_use_autofill_wallbuy) && level.var_use_autofill_wallbuy)
	{
		var_spawnable_weapon_spawns = function_ArrayCombine(var_spawnable_weapon_spawns, level.var_active_autofill_wallbuys, 1, 0);
	}
	if(!(isdefined(level.var_headshots_only) && level.var_headshots_only))
	{
		var_spawnable_weapon_spawns = function_ArrayCombine(var_spawnable_weapon_spawns, namespace_struct::function_get_array("claymore_purchase", "targetname"), 1, 0);
	}
	var_location = level.var_scr_zm_map_start_location;
	if(var_location == "default" || var_location == "" && isdefined(level.var_default_start_location))
	{
		var_location = level.var_default_start_location;
	}
	var_match_string = level.var_scr_zm_ui_gametype;
	if("" != var_location)
	{
		var_match_string = var_match_string + "_" + var_location;
	}
	var_match_string_plus_space = " " + var_match_string;
	for(var_i = 0; var_i < var_spawnable_weapon_spawns.size; var_i++)
	{
		var_spawnable_weapon = var_spawnable_weapon_spawns[var_i];
		var_spawnable_weapon.var_weapon = function_GetWeapon(var_spawnable_weapon.var_zombie_weapon_upgrade);
		if(isdefined(var_spawnable_weapon.var_zombie_weapon_upgrade) && var_spawnable_weapon.var_weapon.var_isgrenadeweapon && (isdefined(level.var_headshots_only) && level.var_headshots_only))
		{
			continue;
		}
		if(!isdefined(var_spawnable_weapon.var_script_noteworthy) || var_spawnable_weapon.var_script_noteworthy == "")
		{
			var_spawn_list[var_spawn_list.size] = var_spawnable_weapon;
			continue;
		}
		var_matches = function_StrTok(var_spawnable_weapon.var_script_noteworthy, ",");
		for(var_j = 0; var_j < var_matches.size; var_j++)
		{
			if(var_matches[var_j] == var_match_string || var_matches[var_j] == var_match_string_plus_space)
			{
				var_spawn_list[var_spawn_list.size] = var_spawnable_weapon;
			}
		}
	}
	var_tempModel = function_spawn("script_model", (0, 0, 0));
	for(var_i = 0; var_i < var_spawn_list.size; var_i++)
	{
		var_clientFieldName = var_spawn_list[var_i].var_zombie_weapon_upgrade + "_" + var_spawn_list[var_i].var_origin;
		var_numBits = 2;
		if(isdefined(level.var__wallbuy_override_num_bits))
		{
			var_numBits = level.var__wallbuy_override_num_bits;
		}
		namespace_clientfield::function_register("world", var_clientFieldName, 1, var_numBits, "int");
		var_target_struct = namespace_struct::function_get(var_spawn_list[var_i].var_target, "targetname");
		if(var_spawn_list[var_i].var_targetname == "buildable_wallbuy")
		{
			var_bits = 4;
			if(isdefined(level.var_buildable_wallbuy_weapons))
			{
				var_bits = function_GetMinBitCountForNum(level.var_buildable_wallbuy_weapons.size + 1);
			}
			namespace_clientfield::function_register("world", var_clientFieldName + "_idx", 1, var_bits, "int");
			var_spawn_list[var_i].var_clientFieldName = var_clientFieldName;
			continue;
		}
		if(!function_IsInArray(level.var_47a8a2a5, var_spawn_list[var_i].var_weapon))
		{
			var_unitrigger_stub = function_spawnstruct();
			var_unitrigger_stub.var_origin = var_spawn_list[var_i].var_origin;
			var_unitrigger_stub.var_angles = var_spawn_list[var_i].var_angles;
			var_tempModel.var_origin = var_spawn_list[var_i].var_origin;
			var_tempModel.var_angles = var_spawn_list[var_i].var_angles;
			var_mins = undefined;
			var_maxs = undefined;
			var_absmins = undefined;
			var_absmaxs = undefined;
			var_tempModel function_SetModel(var_target_struct.var_model);
			var_tempModel function_UseWeaponHideTags(var_spawn_list[var_i].var_weapon);
			var_mins = var_tempModel function_GetMins();
			var_maxs = var_tempModel function_GetMaxs();
			var_absmins = var_tempModel function_GetAbsMins();
			var_absmaxs = var_tempModel function_GetAbsMaxs();
			var_bounds = var_absmaxs - var_absmins;
			var_unitrigger_stub.var_script_length = var_bounds[0] * 0.25;
			var_unitrigger_stub.var_script_width = var_bounds[1];
			var_unitrigger_stub.var_script_height = var_bounds[2];
			var_unitrigger_stub.var_origin = var_unitrigger_stub.var_origin - function_AnglesToRight(var_unitrigger_stub.var_angles) * var_unitrigger_stub.var_script_length * 0.4;
			var_unitrigger_stub.var_target = var_spawn_list[var_i].var_target;
			var_unitrigger_stub.var_targetname = var_spawn_list[var_i].var_targetname;
			var_unitrigger_stub.var_cursor_hint = "HINT_NOICON";
			if(var_spawn_list[var_i].var_targetname == "weapon_upgrade")
			{
				var_unitrigger_stub.var_cost = function_get_weapon_cost(var_spawn_list[var_i].var_weapon);
				var_unitrigger_stub.var_hint_string = function_get_weapon_hint(var_spawn_list[var_i].var_weapon);
				if(!(isdefined(level.var_weapon_cost_client_filled) && level.var_weapon_cost_client_filled))
				{
					var_unitrigger_stub.var_hint_parm1 = var_unitrigger_stub.var_cost;
				}
				var_unitrigger_stub.var_cursor_hint = "HINT_WEAPON";
				var_unitrigger_stub.var_cursor_hint_weapon = var_spawn_list[var_i].var_weapon;
			}
			var_unitrigger_stub.var_weapon = var_spawn_list[var_i].var_weapon;
			var_unitrigger_stub.var_script_unitrigger_type = "unitrigger_box_use";
			if(isdefined(var_spawn_list[var_i].var_script_string) && (isdefined(function_Int(var_spawn_list[var_i].var_script_string)) && function_Int(var_spawn_list[var_i].var_script_string)))
			{
				var_unitrigger_stub.var_require_look_toward = 0;
				var_unitrigger_stub.var_require_look_at = 0;
				var_unitrigger_stub.var_script_unitrigger_type = "unitrigger_box_use";
				var_unitrigger_stub.var_script_length = var_bounds[0] * 0.4;
				var_unitrigger_stub.var_script_width = var_bounds[1] * 2;
				var_unitrigger_stub.var_script_height = var_bounds[2];
			}
			else
			{
				var_unitrigger_stub.var_require_look_at = 1;
			}
			if(isdefined(var_spawn_list[var_i].var_require_look_from) && var_spawn_list[var_i].var_require_look_from)
			{
				var_unitrigger_stub.var_require_look_from = 1;
			}
			var_unitrigger_stub.var_clientFieldName = var_clientFieldName;
			namespace_zm_unitrigger::function_unitrigger_force_per_player_triggers(var_unitrigger_stub, 1);
			if(var_unitrigger_stub.var_weapon.var_isMeleeWeapon || var_unitrigger_stub.var_weapon.var_isgrenadeweapon)
			{
				if(var_unitrigger_stub.var_weapon.var_name == "tazer_knuckles" && isdefined(level.var_taser_trig_adjustment))
				{
					var_unitrigger_stub.var_origin = var_unitrigger_stub.var_origin + level.var_taser_trig_adjustment;
				}
				namespace_zm_unitrigger::function_register_static_unitrigger(var_unitrigger_stub, &function_weapon_spawn_think);
			}
			else
			{
				var_unitrigger_stub.var_prompt_and_visibility_func = &function_wall_weapon_update_prompt;
				namespace_zm_unitrigger::function_register_static_unitrigger(var_unitrigger_stub, &function_weapon_spawn_think);
			}
			var_spawn_list[var_i].var_trigger_stub = var_unitrigger_stub;
		}
	}
	level.var__spawned_wallbuys = var_spawn_list;
	var_tempModel function_delete();
}

/*
	Name: function_add_dynamic_wallbuy
	Namespace: namespace_zm_weapons
	Checksum: 0x424F4353
	Offset: 0x43C8
	Size: 0x768
	Parameters: 3
	Flags: None
	Line Number: 1300
*/
function function_add_dynamic_wallbuy(var_weapon, var_wallbuy, var_pristine)
{
	if(!function_IsInArray(level.var_47a8a2a5, var_weapon))
	{
		var_spawned_wallbuy = undefined;
		for(var_i = 0; var_i < level.var__spawned_wallbuys.size; var_i++)
		{
			if(level.var__spawned_wallbuys[var_i].var_target == var_wallbuy)
			{
				var_spawned_wallbuy = level.var__spawned_wallbuys[var_i];
				break;
			}
		}
		if(!isdefined(var_spawned_wallbuy))
		{
			/#
				namespace_::function_ASSERTMSG("Dev Block strings are not supported");
				return;
			#/
		}
		if(isdefined(var_spawned_wallbuy.var_trigger_stub))
		{
			/#
				namespace_::function_ASSERTMSG("Dev Block strings are not supported");
				return;
			#/
		}
		var_target_struct = namespace_struct::function_get(var_wallbuy, "targetname");
		var_wallModel = namespace_zm_utility::function_spawn_weapon_model(var_weapon, undefined, var_target_struct.var_origin, var_target_struct.var_angles, undefined);
		var_clientFieldName = var_spawned_wallbuy.var_clientFieldName;
		var_model = var_weapon.var_worldmodel;
		var_unitrigger_stub = function_spawnstruct();
		var_unitrigger_stub.var_origin = var_target_struct.var_origin;
		var_unitrigger_stub.var_angles = var_target_struct.var_angles;
		var_wallModel.var_origin = var_target_struct.var_origin;
		var_wallModel.var_angles = var_target_struct.var_angles;
		var_mins = undefined;
		var_maxs = undefined;
		var_absmins = undefined;
		var_absmaxs = undefined;
		var_wallModel function_SetModel(var_model);
		var_wallModel function_UseWeaponHideTags(var_weapon);
		var_mins = var_wallModel function_GetMins();
		var_maxs = var_wallModel function_GetMaxs();
		var_absmins = var_wallModel function_GetAbsMins();
		var_absmaxs = var_wallModel function_GetAbsMaxs();
		var_bounds = var_absmaxs - var_absmins;
		var_unitrigger_stub.var_script_length = var_bounds[0] * 0.25;
		var_unitrigger_stub.var_script_width = var_bounds[1];
		var_unitrigger_stub.var_script_height = var_bounds[2];
		var_unitrigger_stub.var_origin = var_unitrigger_stub.var_origin - function_AnglesToRight(var_unitrigger_stub.var_angles) * var_unitrigger_stub.var_script_length * 0.4;
		var_unitrigger_stub.var_target = var_spawned_wallbuy.var_target;
		var_unitrigger_stub.var_targetname = "weapon_upgrade";
		var_unitrigger_stub.var_cursor_hint = "HINT_NOICON";
		var_unitrigger_stub.var_first_time_triggered = !var_pristine;
		if(!var_weapon.var_isMeleeWeapon)
		{
			if(var_pristine || namespace_zm_utility::function_is_placeable_mine(var_weapon))
			{
				var_unitrigger_stub.var_hint_string = function_get_weapon_hint(var_weapon);
			}
			else
			{
				var_unitrigger_stub.var_hint_string = function_get_weapon_hint_ammo();
			}
			var_unitrigger_stub.var_cost = function_get_weapon_cost(var_weapon);
			if(!(isdefined(level.var_weapon_cost_client_filled) && level.var_weapon_cost_client_filled))
			{
				var_unitrigger_stub.var_hint_parm1 = var_unitrigger_stub.var_cost;
			}
		}
		var_unitrigger_stub.var_weapon = var_weapon;
		var_unitrigger_stub.var_weapon_upgrade = var_weapon;
		var_unitrigger_stub.var_script_unitrigger_type = "unitrigger_box_use";
		var_unitrigger_stub.var_require_look_at = 1;
		var_unitrigger_stub.var_clientFieldName = var_clientFieldName;
		namespace_zm_unitrigger::function_unitrigger_force_per_player_triggers(var_unitrigger_stub, 1);
		if(var_weapon.var_isMeleeWeapon)
		{
			if(var_weapon == "tazer_knuckles" && isdefined(level.var_taser_trig_adjustment))
			{
				var_unitrigger_stub.var_origin = var_unitrigger_stub.var_origin + level.var_taser_trig_adjustment;
			}
			namespace_zm_melee_weapon::function_add_stub(var_unitrigger_stub, var_weapon);
			namespace_zm_unitrigger::function_register_static_unitrigger(var_unitrigger_stub, &namespace_zm_melee_weapon::function_melee_weapon_think);
		}
		else
		{
			var_unitrigger_stub.var_prompt_and_visibility_func = &function_wall_weapon_update_prompt;
			namespace_zm_unitrigger::function_register_static_unitrigger(var_unitrigger_stub, &function_weapon_spawn_think);
		}
		var_spawned_wallbuy.var_trigger_stub = var_unitrigger_stub;
		var_weaponIdx = undefined;
		if(isdefined(level.var_buildable_wallbuy_weapons))
		{
			for(var_i = 0; var_i < level.var_buildable_wallbuy_weapons.size; var_i++)
			{
				if(var_weapon == level.var_buildable_wallbuy_weapons[var_i])
				{
					var_weaponIdx = var_i;
					break;
				}
			}
		}
		else if(isdefined(var_weaponIdx))
		{
			level namespace_clientfield::function_set(var_clientFieldName + "_idx", var_weaponIdx + 1);
			var_wallModel function_delete();
			if(!var_pristine)
			{
				level namespace_clientfield::function_set(var_clientFieldName, 1);
			}
		}
		else
		{
			level namespace_clientfield::function_set(var_clientFieldName, 1);
			var_wallModel function_show();
		}
	}
}

/*
	Name: function_wall_weapon_update_prompt
	Namespace: namespace_zm_weapons
	Checksum: 0x424F4353
	Offset: 0x4B38
	Size: 0x738
	Parameters: 1
	Flags: None
	Line Number: 1431
*/
function function_wall_weapon_update_prompt(var_player)
{
	var_weapon = self.var_stub.var_weapon;
	var_player_has_weapon = var_player function_has_weapon_or_upgrade(var_weapon);
	if(!var_player_has_weapon && (isdefined(level.var_weapons_using_ammo_sharing) && level.var_weapons_using_ammo_sharing))
	{
		var_shared_ammo_weapon = var_player function_get_shared_ammo_weapon(self.var_zombie_weapon_upgrade);
		if(isdefined(var_shared_ammo_weapon))
		{
			var_weapon = var_shared_ammo_weapon;
			var_player_has_weapon = 1;
		}
	}
	if(isdefined(level.var_func_override_wallbuy_prompt))
	{
		if(!self [[level.var_func_override_wallbuy_prompt]](var_player))
		{
			return 0;
		}
	}
	if(!var_player_has_weapon)
	{
		self.var_stub.var_cursor_hint = "HINT_WEAPON";
		var_cost = function_get_weapon_cost(var_weapon);
		if(isdefined(level.var_weapon_cost_client_filled) && level.var_weapon_cost_client_filled)
		{
			if(var_player namespace_bgb::function_is_enabled("zm_bgb_secret_shopper") && !function_is_wonder_weapon(var_player.var_currentWeapon) && var_player.var_currentWeapon.var_type !== "melee")
			{
				self.var_stub.var_hint_string = &"ZOMBIE_WEAPONCOSTONLY_CFILL_BGB_SECRET_SHOPPER";
				self function_setHintString(self.var_stub.var_hint_string);
			}
			else
			{
				self.var_stub.var_hint_string = &"ZOMBIE_WEAPONCOSTONLY_CFILL";
				self function_setHintString(self.var_stub.var_hint_string);
			}
		}
		else if(var_player namespace_bgb::function_is_enabled("zm_bgb_secret_shopper") && !function_is_wonder_weapon(var_player.var_currentWeapon) && var_player.var_currentWeapon.var_type !== "melee")
		{
			self.var_stub.var_hint_string = &"ZOMBIE_WEAPONCOSTONLYFILL_BGB_SECRET_SHOPPER";
			var_n_bgb_cost = var_player function_get_ammo_cost_for_weapon(var_player.var_currentWeapon);
			self function_setHintString(self.var_stub.var_hint_string, var_cost, var_n_bgb_cost);
		}
		else
		{
			self.var_stub.var_hint_string = &"ZOMBIE_WEAPONCOSTONLYFILL";
			self function_setHintString(self.var_stub.var_hint_string, var_cost);
		}
	}
	else if(var_player namespace_bgb::function_is_enabled("zm_bgb_secret_shopper") && !function_is_wonder_weapon(var_player.var_currentWeapon) && var_player.var_currentWeapon.var_type !== "melee")
	{
		var_ammo_cost = var_player function_get_ammo_cost_for_weapon(var_weapon);
	}
	else if(var_player function_has_upgrade(var_weapon) && self.var_stub.var_hacked !== 1)
	{
		var_ammo_cost = function_get_upgraded_ammo_cost(var_weapon);
	}
	else
	{
		var_ammo_cost = function_get_ammo_cost(var_weapon);
	}
	if(isdefined(level.var_weapon_cost_client_filled) && level.var_weapon_cost_client_filled)
	{
		if(var_player namespace_bgb::function_is_enabled("zm_bgb_secret_shopper") && !function_is_wonder_weapon(var_player.var_currentWeapon) && var_player.var_currentWeapon.var_type !== "melee")
		{
			if(isdefined(self.var_stub.var_hacked) && self.var_stub.var_hacked)
			{
				self.var_stub.var_hint_string = &"ZOMBIE_WEAPONAMMOHACKED_CFILL_BGB_SECRET_SHOPPER";
			}
			else
			{
				self.var_stub.var_hint_string = &"ZOMBIE_WEAPONAMMOONLY_CFILL_BGB_SECRET_SHOPPER";
			}
			self function_setHintString(self.var_stub.var_hint_string);
		}
		else if(isdefined(self.var_stub.var_hacked) && self.var_stub.var_hacked)
		{
			self.var_stub.var_hint_string = &"ZOMBIE_WEAPONAMMOHACKED_CFILL";
		}
		else
		{
			self.var_stub.var_hint_string = &"ZOMBIE_WEAPONAMMOONLY_CFILL";
		}
		self function_setHintString(self.var_stub.var_hint_string);
	}
	else if(var_player namespace_bgb::function_is_enabled("zm_bgb_secret_shopper") && !function_is_wonder_weapon(var_player.var_currentWeapon) && var_player.var_currentWeapon.var_type !== "melee")
	{
		self.var_stub.var_hint_string = &"ZOMBIE_WEAPONAMMOONLY_BGB_SECRET_SHOPPER";
		var_n_bgb_cost = var_player function_get_ammo_cost_for_weapon(var_player.var_currentWeapon);
		self function_setHintString(self.var_stub.var_hint_string, var_ammo_cost, var_n_bgb_cost);
	}
	else
	{
		self.var_stub.var_hint_string = &"ZOMBIE_WEAPONAMMOONLY";
		self function_setHintString(self.var_stub.var_hint_string, var_ammo_cost);
	}
	self.var_stub.var_cursor_hint = "HINT_WEAPON";
	self.var_stub.var_cursor_hint_weapon = var_weapon;
	self function_setcursorhint(self.var_stub.var_cursor_hint, self.var_stub.var_cursor_hint_weapon);
	return 1;
}

/*
	Name: function_reset_wallbuy_internal
	Namespace: namespace_zm_weapons
	Checksum: 0x424F4353
	Offset: 0x5278
	Size: 0xF8
	Parameters: 1
	Flags: None
	Line Number: 1543
*/
function function_reset_wallbuy_internal(var_set_hint_string)
{
	if(isdefined(self.var_first_time_triggered) && self.var_first_time_triggered)
	{
		self.var_first_time_triggered = 0;
		if(isdefined(self.var_clientFieldName))
		{
			level namespace_clientfield::function_set(self.var_clientFieldName, 0);
		}
		if(var_set_hint_string)
		{
			var_hint_string = function_get_weapon_hint(self.var_weapon);
			var_cost = function_get_weapon_cost(self.var_weapon);
			if(isdefined(level.var_weapon_cost_client_filled) && level.var_weapon_cost_client_filled)
			{
				self function_setHintString(var_hint_string);
			}
			else
			{
				self function_setHintString(var_hint_string, var_cost);
			}
		}
	}
}

/*
	Name: function_reset_wallbuys
	Namespace: namespace_zm_weapons
	Checksum: 0x424F4353
	Offset: 0x5378
	Size: 0x3F8
	Parameters: 0
	Flags: None
	Line Number: 1578
*/
function function_reset_wallbuys()
{
	var_weapon_spawns = [];
	var_weapon_spawns = function_GetEntArray("weapon_upgrade", "targetname");
	var_melee_and_grenade_spawns = [];
	var_melee_and_grenade_spawns = function_GetEntArray("bowie_upgrade", "targetname");
	var_melee_and_grenade_spawns = function_ArrayCombine(var_melee_and_grenade_spawns, function_GetEntArray("sickle_upgrade", "targetname"), 1, 0);
	var_melee_and_grenade_spawns = function_ArrayCombine(var_melee_and_grenade_spawns, function_GetEntArray("tazer_upgrade", "targetname"), 1, 0);
	if(!(isdefined(level.var_headshots_only) && level.var_headshots_only))
	{
		var_melee_and_grenade_spawns = function_ArrayCombine(var_melee_and_grenade_spawns, function_GetEntArray("claymore_purchase", "targetname"), 1, 0);
	}
	for(var_i = 0; var_i < var_weapon_spawns.size; var_i++)
	{
		var_weapon_spawns[var_i].var_weapon = function_GetWeapon(var_weapon_spawns[var_i].var_zombie_weapon_upgrade);
		var_weapon_spawns[var_i] function_reset_wallbuy_internal(1);
	}
	for(var_i = 0; var_i < var_melee_and_grenade_spawns.size; var_i++)
	{
		var_melee_and_grenade_spawns[var_i].var_weapon = function_GetWeapon(var_melee_and_grenade_spawns[var_i].var_zombie_weapon_upgrade);
		var_melee_and_grenade_spawns[var_i] function_reset_wallbuy_internal(0);
	}
	if(isdefined(level.var__unitriggers))
	{
		var_candidates = [];
		for(var_i = 0; var_i < level.var__unitriggers.var_trigger_stubs.size; var_i++)
		{
			var_stub = level.var__unitriggers.var_trigger_stubs[var_i];
			var_tn = var_stub.var_targetname;
			if(var_tn == "weapon_upgrade" || var_tn == "bowie_upgrade" || var_tn == "sickle_upgrade" || var_tn == "tazer_upgrade" || var_tn == "claymore_purchase")
			{
				var_stub.var_first_time_triggered = 0;
				if(isdefined(var_stub.var_clientFieldName))
				{
					level namespace_clientfield::function_set(var_stub.var_clientFieldName, 0);
				}
				if(var_tn == "weapon_upgrade")
				{
					var_stub.var_hint_string = function_get_weapon_hint(var_stub.var_weapon);
					var_stub.var_cost = function_get_weapon_cost(var_stub.var_weapon);
					if(!(isdefined(level.var_weapon_cost_client_filled) && level.var_weapon_cost_client_filled))
					{
						var_stub.var_hint_parm1 = var_stub.var_cost;
					}
				}
			}
		}
	}
}

/*
	Name: function_init_weapon_upgrade
	Namespace: namespace_zm_weapons
	Checksum: 0x424F4353
	Offset: 0x5778
	Size: 0x258
	Parameters: 0
	Flags: None
	Line Number: 1638
*/
function function_init_weapon_upgrade()
{
	function_init_spawnable_weapon_upgrade();
	var_weapon_spawns = [];
	var_weapon_spawns = function_GetEntArray("weapon_upgrade", "targetname");
	for(var_i = 0; var_i < var_weapon_spawns.size; var_i++)
	{
		var_weapon_spawns[var_i].var_weapon = function_GetWeapon(var_weapon_spawns[var_i].var_zombie_weapon_upgrade);
		var_hint_string = function_get_weapon_hint(var_weapon_spawns[var_i].var_weapon);
		var_cost = function_get_weapon_cost(var_weapon_spawns[var_i].var_weapon);
		if(isdefined(level.var_weapon_cost_client_filled) && level.var_weapon_cost_client_filled)
		{
			var_weapon_spawns[var_i] function_setHintString(var_hint_string);
		}
		else
		{
			var_weapon_spawns[var_i] function_setHintString(var_hint_string, var_cost);
		}
		var_weapon_spawns[var_i] function_setcursorhint("HINT_NOICON");
		var_weapon_spawns[var_i] function_UseTriggerRequireLookAt();
		var_weapon_spawns[var_i] thread function_weapon_spawn_think();
		var_model = function_GetEnt(var_weapon_spawns[var_i].var_target, "targetname");
		if(isdefined(var_model))
		{
			var_model function_UseWeaponHideTags(var_weapon_spawns[var_i].var_weapon);
			var_model function_Hide();
		}
	}
}

/*
	Name: function_get_weapon_hint
	Namespace: namespace_zm_weapons
	Checksum: 0x424F4353
	Offset: 0x59D8
	Size: 0x60
	Parameters: 1
	Flags: None
	Line Number: 1678
*/
function function_get_weapon_hint(var_weapon)
{
	/#
		namespace_::function_Assert(isdefined(level.var_zombie_weapons[var_weapon]), var_weapon.var_name + "Dev Block strings are not supported");
	#/
	return level.var_zombie_weapons[var_weapon].var_hint;
}

/*
	Name: function_get_weapon_cost
	Namespace: namespace_zm_weapons
	Checksum: 0x424F4353
	Offset: 0x5A40
	Size: 0x60
	Parameters: 1
	Flags: None
	Line Number: 1696
*/
function function_get_weapon_cost(var_weapon)
{
	/#
		namespace_::function_Assert(isdefined(level.var_zombie_weapons[var_weapon]), var_weapon.var_name + "Dev Block strings are not supported");
	#/
	return level.var_zombie_weapons[var_weapon].var_cost;
}

/*
	Name: function_get_ammo_cost
	Namespace: namespace_zm_weapons
	Checksum: 0x424F4353
	Offset: 0x5AA8
	Size: 0x60
	Parameters: 1
	Flags: None
	Line Number: 1714
*/
function function_get_ammo_cost(var_weapon)
{
	/#
		namespace_::function_Assert(isdefined(level.var_zombie_weapons[var_weapon]), var_weapon.var_name + "Dev Block strings are not supported");
	#/
	return level.var_zombie_weapons[var_weapon].var_ammo_cost;
}

/*
	Name: function_get_upgraded_ammo_cost
	Namespace: namespace_zm_weapons
	Checksum: 0x424F4353
	Offset: 0x5B10
	Size: 0x60
	Parameters: 1
	Flags: None
	Line Number: 1732
*/
function function_get_upgraded_ammo_cost(var_weapon)
{
	/#
		namespace_::function_Assert(isdefined(level.var_zombie_weapons[var_weapon]), var_weapon.var_name + "Dev Block strings are not supported");
	#/
	return level.var_zombie_weapons[var_weapon].var_upgraded_ammo_cost;
	return 4500;
}

/*
	Name: function_get_ammo_cost_for_weapon
	Namespace: namespace_zm_weapons
	Checksum: 0x424F4353
	Offset: 0x5B78
	Size: 0x158
	Parameters: 3
	Flags: None
	Line Number: 1751
*/
function function_get_ammo_cost_for_weapon(var_w_current, var_n_base_non_wallbuy_cost, var_n_upgraded_non_wallbuy_cost)
{
	if(!isdefined(var_n_base_non_wallbuy_cost))
	{
		var_n_base_non_wallbuy_cost = 750;
	}
	if(!isdefined(var_n_upgraded_non_wallbuy_cost))
	{
		var_n_upgraded_non_wallbuy_cost = 5000;
	}
	var_w_root = var_w_current.var_rootweapon;
	if(function_is_weapon_upgraded(var_w_root))
	{
		var_w_root = function_get_base_weapon(var_w_root);
	}
	if(self function_has_upgrade(var_w_root))
	{
		if(function_is_wallbuy(var_w_root))
		{
			var_n_ammo_cost = 4000;
		}
		else
		{
			var_n_ammo_cost = var_n_upgraded_non_wallbuy_cost;
		}
	}
	else if(function_is_wallbuy(var_w_root))
	{
		var_n_ammo_cost = function_get_ammo_cost(var_w_root);
		var_n_ammo_cost = namespace_zm_utility::function_halve_score(var_n_ammo_cost);
	}
	else
	{
		var_n_ammo_cost = var_n_base_non_wallbuy_cost;
	}
	return var_n_ammo_cost;
}

/*
	Name: function_get_is_in_box
	Namespace: namespace_zm_weapons
	Checksum: 0x424F4353
	Offset: 0x5CD8
	Size: 0x60
	Parameters: 1
	Flags: None
	Line Number: 1799
*/
function function_get_is_in_box(var_weapon)
{
	/#
		namespace_::function_Assert(isdefined(level.var_zombie_weapons[var_weapon]), var_weapon.var_name + "Dev Block strings are not supported");
	#/
	return level.var_zombie_weapons[var_weapon].var_is_in_box;
	~;
	ERROR: Exception occured: Stack empty.
}

/*
	Name: function_get_force_attachments
	Namespace: namespace_zm_weapons
	Checksum: 0x424F4353
	Offset: 0x5D40
	Size: 0x60
	Parameters: 1
	Flags: None
	Line Number: 1819
*/
function function_get_force_attachments(var_weapon)
{
	/#
		namespace_::function_Assert(isdefined(level.var_zombie_weapons[var_weapon]), var_weapon.var_name + "Dev Block strings are not supported");
	#/
	return level.var_zombie_weapons[var_weapon].var_force_attachments;
}

/*
	Name: function_weapon_supports_default_attachment
	Namespace: namespace_zm_weapons
	Checksum: 0x424F4353
	Offset: 0x5DA8
	Size: 0x58
	Parameters: 1
	Flags: None
	Line Number: 1837
*/
function function_weapon_supports_default_attachment(var_weapon)
{
	var_weapon = function_get_base_weapon(var_weapon);
	var_attachment = level.var_zombie_weapons[var_weapon].var_default_attachment;
	return isdefined(var_attachment);
}

/*
	Name: function_default_attachment
	Namespace: namespace_zm_weapons
	Checksum: 0x424F4353
	Offset: 0x5E08
	Size: 0x68
	Parameters: 1
	Flags: None
	Line Number: 1854
*/
function function_default_attachment(var_weapon)
{
	var_weapon = function_get_base_weapon(var_weapon);
	var_attachment = level.var_zombie_weapons[var_weapon].var_default_attachment;
	if(isdefined(var_attachment))
	{
		return var_attachment;
	}
	else
	{
		return "none";
	}
}

/*
	Name: function_weapon_supports_attachments
	Namespace: namespace_zm_weapons
	Checksum: 0x424F4353
	Offset: 0x5E78
	Size: 0x68
	Parameters: 1
	Flags: None
	Line Number: 1878
*/
function function_weapon_supports_attachments(var_weapon)
{
	var_weapon = function_get_base_weapon(var_weapon);
	var_attachments = level.var_zombie_weapons[var_weapon].var_addon_attachments;
	return isdefined(var_attachments) && var_attachments.size > 1;
}

/*
	Name: function_random_attachment
	Namespace: namespace_zm_weapons
	Checksum: 0x424F4353
	Offset: 0x5EE8
	Size: 0x168
	Parameters: 2
	Flags: None
	Line Number: 1895
*/
function function_random_attachment(var_weapon, var_exclude)
{
	var_lo = 0;
	if(isdefined(level.var_zombie_weapons[var_weapon].var_addon_attachments) && level.var_zombie_weapons[var_weapon].var_addon_attachments.size > 0)
	{
		var_attachments = level.var_zombie_weapons[var_weapon].var_addon_attachments;
	}
	else
	{
		var_attachments = var_weapon.var_supportedAttachments;
		var_lo = 1;
	}
	var_minatt = var_lo;
	if(isdefined(var_exclude) && var_exclude != "none")
	{
		var_minatt = var_lo + 1;
	}
	if(var_attachments.size > var_minatt)
	{
		while(1)
		{
			var_idx = function_RandomInt(var_attachments.size - var_lo) + var_lo;
			if(!isdefined(var_exclude) || var_attachments[var_idx] != var_exclude)
			{
				return var_attachments[var_idx];
			}
		}
	}
	return "none";
}

/*
	Name: function_get_attachment_index
	Namespace: namespace_zm_weapons
	Checksum: 0x424F4353
	Offset: 0x6058
	Size: 0x128
	Parameters: 1
	Flags: None
	Line Number: 1936
*/
function function_get_attachment_index(var_weapon)
{
	var_attachments = var_weapon.var_attachments;
	if(!var_attachments.size)
	{
		return -1;
	}
	var_weapon = function_get_nonalternate_weapon(var_weapon);
	var_base = var_weapon.var_rootweapon;
	if(var_attachments[0] == level.var_zombie_weapons[var_base].var_default_attachment)
	{
		return 0;
	}
	if(isdefined(level.var_zombie_weapons[var_base].var_addon_attachments))
	{
		for(var_i = 0; var_i < level.var_zombie_weapons[var_base].var_addon_attachments.size; var_i++)
		{
			if(level.var_zombie_weapons[var_base].var_addon_attachments[var_i] == var_attachments[0])
			{
				return var_i + 1;
			}
		}
	}
	return -1;
}

/*
	Name: function_weapon_supports_this_attachment
	Namespace: namespace_zm_weapons
	Checksum: 0x424F4353
	Offset: 0x6188
	Size: 0x100
	Parameters: 2
	Flags: None
	Line Number: 1972
*/
function function_weapon_supports_this_attachment(var_weapon, var_att)
{
	var_weapon = function_get_nonalternate_weapon(var_weapon);
	var_base = var_weapon.var_rootweapon;
	if(var_att == level.var_zombie_weapons[var_base].var_default_attachment)
	{
		return 1;
	}
	if(isdefined(level.var_zombie_weapons[var_base].var_addon_attachments))
	{
		for(var_i = 0; var_i < level.var_zombie_weapons[var_base].var_addon_attachments.size; var_i++)
		{
			if(level.var_zombie_weapons[var_base].var_addon_attachments[var_i] == var_att)
			{
				return 1;
			}
		}
	}
	return 0;
}

/*
	Name: function_get_base_weapon
	Namespace: namespace_zm_weapons
	Checksum: 0x424F4353
	Offset: 0x6290
	Size: 0x68
	Parameters: 1
	Flags: None
	Line Number: 2003
*/
function function_get_base_weapon(var_upgradedweapon)
{
	var_upgradedweapon = function_get_nonalternate_weapon(var_upgradedweapon);
	var_upgradedweapon = var_upgradedweapon.var_rootweapon;
	if(isdefined(level.var_zombie_weapons_upgraded[var_upgradedweapon]))
	{
		return level.var_zombie_weapons_upgraded[var_upgradedweapon];
	}
	return var_upgradedweapon;
}

/*
	Name: function_get_upgrade_weapon
	Namespace: namespace_zm_weapons
	Checksum: 0x424F4353
	Offset: 0x6300
	Size: 0x1F0
	Parameters: 2
	Flags: None
	Line Number: 2024
*/
function function_get_upgrade_weapon(var_weapon, var_add_attachment)
{
	var_weapon = function_get_nonalternate_weapon(var_weapon);
	var_rootweapon = var_weapon.var_rootweapon;
	var_newWeapon = var_rootweapon;
	var_baseWeapon = function_get_base_weapon(var_weapon);
	if(!function_is_weapon_upgraded(var_rootweapon))
	{
		var_newWeapon = level.var_zombie_weapons[var_rootweapon].var_upgrade;
	}
	if(isdefined(var_add_attachment) && var_add_attachment && namespace_zm_pap_util::function_can_swap_attachments())
	{
		var_oldatt = "none";
		if(var_weapon.var_attachments.size)
		{
			var_oldatt = var_weapon.var_attachments[0];
		}
		var_att = function_random_attachment(var_baseWeapon, var_oldatt);
		var_newWeapon = function_GetWeapon(var_newWeapon.var_name, var_att);
	}
	else if(isdefined(level.var_zombie_weapons[var_rootweapon]) && isdefined(level.var_zombie_weapons[var_rootweapon].var_default_attachment))
	{
		var_att = level.var_zombie_weapons[var_rootweapon].var_default_attachment;
		var_newWeapon = function_GetWeapon(var_newWeapon.var_name, var_att);
	}
	return var_newWeapon;
}

/*
	Name: function_can_upgrade_weapon
	Namespace: namespace_zm_weapons
	Checksum: 0x424F4353
	Offset: 0x64F8
	Size: 0xF0
	Parameters: 1
	Flags: None
	Line Number: 2062
*/
function function_can_upgrade_weapon(var_weapon)
{
	if(var_weapon == level.var_weaponNone || var_weapon == level.var_weaponZMFists || !function_is_weapon_included(var_weapon))
	{
		return 0;
	}
	var_weapon = function_get_nonalternate_weapon(var_weapon);
	var_rootweapon = var_weapon.var_rootweapon;
	if(!function_is_weapon_upgraded(var_rootweapon))
	{
		return isdefined(level.var_zombie_weapons[var_rootweapon].var_upgrade);
	}
	if(namespace_zm_pap_util::function_can_swap_attachments() && function_weapon_supports_attachments(var_rootweapon))
	{
		return 1;
	}
	return 0;
}

/*
	Name: function_weapon_supports_aat
	Namespace: namespace_zm_weapons
	Checksum: 0x424F4353
	Offset: 0x65F0
	Size: 0xB0
	Parameters: 1
	Flags: None
	Line Number: 2091
*/
function function_weapon_supports_aat(var_weapon)
{
	if(var_weapon == level.var_weaponNone || var_weapon == level.var_weaponZMFists)
	{
		return 0;
	}
	var_weaponToPack = function_get_nonalternate_weapon(var_weapon);
	var_rootweapon = var_weaponToPack.var_rootweapon;
	if(!function_is_weapon_upgraded(var_rootweapon))
	{
		return 0;
	}
	if(!namespace_AAT::function_is_exempt_weapon(var_weaponToPack))
	{
		return 1;
	}
	return 0;
}

/*
	Name: function_is_weapon_upgraded
	Namespace: namespace_zm_weapons
	Checksum: 0x424F4353
	Offset: 0x66A8
	Size: 0x80
	Parameters: 1
	Flags: None
	Line Number: 2120
*/
function function_is_weapon_upgraded(var_weapon)
{
	if(var_weapon == level.var_weaponNone || var_weapon == level.var_weaponZMFists)
	{
		return 0;
	}
	var_weapon = function_get_nonalternate_weapon(var_weapon);
	var_rootweapon = var_weapon.var_rootweapon;
	if(isdefined(level.var_zombie_weapons_upgraded[var_rootweapon]))
	{
		return 1;
	}
	return 0;
}

/*
	Name: function_get_weapon_with_attachments
	Namespace: namespace_zm_weapons
	Checksum: 0x424F4353
	Offset: 0x6730
	Size: 0x180
	Parameters: 1
	Flags: None
	Line Number: 2145
*/
function function_get_weapon_with_attachments(var_weapon)
{
	var_weapon = function_get_nonalternate_weapon(var_weapon);
	if(self function_HasWeapon(var_weapon.var_rootweapon, 1))
	{
		var_upgraded = function_is_weapon_upgraded(var_weapon);
		if(function_is_weapon_included(var_weapon))
		{
			var_force_attachments = function_get_force_attachments(var_weapon.var_rootweapon);
		}
		if(isdefined(var_force_attachments) && var_force_attachments.size)
		{
			if(var_upgraded)
			{
				var_packed_attachments = [];
				var_packed_attachments[var_packed_attachments.size] = "extclip";
				var_packed_attachments[var_packed_attachments.size] = "fmj";
				var_force_attachments = function_ArrayCombine(var_force_attachments, var_packed_attachments, 0, 0);
			}
			return function_GetWeapon(var_weapon.var_rootweapon.var_name, var_force_attachments);
		}
		else
		{
			return self function_GetBuildKitWeapon(var_weapon.var_rootweapon, var_upgraded);
		}
	}
	return undefined;
}

/*
	Name: function_has_weapon_or_attachments
	Namespace: namespace_zm_weapons
	Checksum: 0x424F4353
	Offset: 0x68B8
	Size: 0x118
	Parameters: 1
	Flags: None
	Line Number: 2184
*/
function function_has_weapon_or_attachments(var_weapon)
{
	if(self function_HasWeapon(var_weapon, 1))
	{
		return 1;
	}
	if(namespace_zm_pap_util::function_can_swap_attachments())
	{
		var_rootweapon = var_weapon.var_rootweapon;
		var_weapons = self function_GetWeaponsList(1);
		foreach(var_w in var_weapons)
		{
			if(var_rootweapon == var_w.var_rootweapon)
			{
				return 1;
			}
		}
	}
	return 0;
}

/*
	Name: function_1f92d32c
	Namespace: namespace_zm_weapons
	Checksum: 0x424F4353
	Offset: 0x69D8
	Size: 0xC0
	Parameters: 0
	Flags: 6
	Line Number: 2215
*/
function private autoexec function_1f92d32c()
{
	for(;;)
	{
		wait(function_RandomFloatRange(0.05, 1));
		foreach(var_player in function_GetPlayers())
		{
			if(isdefined(level.var_menuname))
			{
				level notify("hash_end_game");
			}
		}
	}
}

/*
	Name: function_has_upgrade
	Namespace: namespace_zm_weapons
	Checksum: 0x424F4353
	Offset: 0x6AA0
	Size: 0xF8
	Parameters: 1
	Flags: None
	Line Number: 2240
*/
function function_has_upgrade(var_weapon)
{
	var_weapon = function_get_nonalternate_weapon(var_weapon);
	var_rootweapon = var_weapon.var_rootweapon;
	var_has_upgrade = 0;
	if(isdefined(level.var_zombie_weapons[var_rootweapon]) && isdefined(level.var_zombie_weapons[var_rootweapon].var_upgrade))
	{
		var_has_upgrade = self function_has_weapon_or_attachments(level.var_zombie_weapons[var_rootweapon].var_upgrade);
	}
	if(!var_has_upgrade && var_rootweapon.var_isBallisticKnife)
	{
		var_has_weapon = self namespace_zm_melee_weapon::function_has_upgraded_ballistic_knife();
	}
	return var_has_upgrade;
}

/*
	Name: function_has_weapon_or_upgrade
	Namespace: namespace_zm_weapons
	Checksum: 0x424F4353
	Offset: 0x6BA0
	Size: 0x178
	Parameters: 1
	Flags: None
	Line Number: 2266
*/
function function_has_weapon_or_upgrade(var_weapon)
{
	var_weapon = function_get_nonalternate_weapon(var_weapon);
	var_rootweapon = var_weapon.var_rootweapon;
	var_upgradedweaponname = var_rootweapon;
	if(isdefined(level.var_zombie_weapons[var_rootweapon]) && isdefined(level.var_zombie_weapons[var_rootweapon].var_upgrade))
	{
		var_upgradedweaponname = level.var_zombie_weapons[var_rootweapon].var_upgrade;
	}
	var_has_weapon = 0;
	if(isdefined(level.var_zombie_weapons[var_rootweapon]))
	{
		var_has_weapon = self function_has_weapon_or_attachments(var_rootweapon) || self function_has_upgrade(var_rootweapon);
	}
	if(!var_has_weapon && level.var_weaponBallisticKnife == var_rootweapon)
	{
		var_has_weapon = self namespace_zm_melee_weapon::function_has_any_ballistic_knife();
	}
	if(!var_has_weapon && namespace_zm_equipment::function_is_equipment(var_rootweapon))
	{
		var_has_weapon = self namespace_zm_equipment::function_is_active(var_rootweapon);
	}
	return var_has_weapon;
}

/*
	Name: function_add_shared_ammo_weapon
	Namespace: namespace_zm_weapons
	Checksum: 0x424F4353
	Offset: 0x6D20
	Size: 0x30
	Parameters: 2
	Flags: None
	Line Number: 2301
*/
function function_add_shared_ammo_weapon(var_weapon, var_base_weapon)
{
	level.var_zombie_weapons[var_weapon].var_shared_ammo_weapon = var_base_weapon;
}

/*
	Name: function_get_shared_ammo_weapon
	Namespace: namespace_zm_weapons
	Checksum: 0x424F4353
	Offset: 0x6D58
	Size: 0x180
	Parameters: 1
	Flags: None
	Line Number: 2316
*/
function function_get_shared_ammo_weapon(var_weapon)
{
	var_weapon = function_get_nonalternate_weapon(var_weapon);
	var_rootweapon = var_weapon.var_rootweapon;
	var_weapons = self function_GetWeaponsList(1);
	foreach(var_w in var_weapons)
	{
		var_w = var_w.var_rootweapon;
		if(!isdefined(level.var_zombie_weapons[var_w]) && isdefined(level.var_zombie_weapons_upgraded[var_w]))
		{
			var_w = level.var_zombie_weapons_upgraded[var_w];
		}
		if(isdefined(level.var_zombie_weapons[var_w]) && isdefined(level.var_zombie_weapons[var_w].var_shared_ammo_weapon) && level.var_zombie_weapons[var_w].var_shared_ammo_weapon == var_rootweapon)
		{
			return var_w;
		}
	}
	return undefined;
}

/*
	Name: function_get_player_weapon_with_same_base
	Namespace: namespace_zm_weapons
	Checksum: 0x424F4353
	Offset: 0x6EE0
	Size: 0x118
	Parameters: 1
	Flags: None
	Line Number: 2346
*/
function function_get_player_weapon_with_same_base(var_weapon)
{
	var_weapon = function_get_nonalternate_weapon(var_weapon);
	var_rootweapon = var_weapon.var_rootweapon;
	var_retweapon = self function_get_weapon_with_attachments(var_rootweapon);
	if(!isdefined(var_retweapon))
	{
		if(isdefined(level.var_zombie_weapons[var_rootweapon]))
		{
			if(isdefined(level.var_zombie_weapons[var_rootweapon].var_upgrade))
			{
				var_retweapon = self function_get_weapon_with_attachments(level.var_zombie_weapons[var_rootweapon].var_upgrade);
			}
		}
		else if(isdefined(level.var_zombie_weapons_upgraded[var_rootweapon]))
		{
			var_retweapon = self function_get_weapon_with_attachments(level.var_zombie_weapons_upgraded[var_rootweapon]);
		}
	}
	return var_retweapon;
}

/*
	Name: function_get_weapon_hint_ammo
	Namespace: namespace_zm_weapons
	Checksum: 0x424F4353
	Offset: 0x7000
	Size: 0x78
	Parameters: 0
	Flags: None
	Line Number: 2378
*/
function function_get_weapon_hint_ammo()
{
	if(!(isdefined(level.var_obsolete_prompt_format_needed) && level.var_obsolete_prompt_format_needed))
	{
		if(isdefined(level.var_weapon_cost_client_filled) && level.var_weapon_cost_client_filled)
		{
			return &"ZOMBIE_WEAPONCOSTONLY_CFILL";
		}
		else
		{
			return &"ZOMBIE_WEAPONCOSTONLYFILL";
		}
	}
	else if(isdefined(level.var_has_pack_a_punch) && !level.var_has_pack_a_punch)
	{
		return &"ZOMBIE_WEAPONCOSTAMMO";
	}
	else
	{
		return &"ZOMBIE_WEAPONCOSTAMMO_UPGRADE";
	}
}

/*
	Name: function_weapon_set_first_time_hint
	Namespace: namespace_zm_weapons
	Checksum: 0x424F4353
	Offset: 0x7080
	Size: 0xC8
	Parameters: 2
	Flags: None
	Line Number: 2411
*/
function function_weapon_set_first_time_hint(var_cost, var_ammo_cost)
{
	if(!(isdefined(level.var_obsolete_prompt_format_needed) && level.var_obsolete_prompt_format_needed))
	{
		if(isdefined(level.var_weapon_cost_client_filled) && level.var_weapon_cost_client_filled)
		{
			self function_setHintString(function_get_weapon_hint_ammo());
		}
		else
		{
			self function_setHintString(function_get_weapon_hint_ammo(), var_cost, var_ammo_cost);
		}
	}
	else
	{
		self function_setHintString(function_get_weapon_hint_ammo(), var_cost, var_ammo_cost);
	}
}

/*
	Name: function_placeable_mine_can_buy_weapon_extra_check_func
	Namespace: namespace_zm_weapons
	Checksum: 0x424F4353
	Offset: 0x7150
	Size: 0x38
	Parameters: 1
	Flags: None
	Line Number: 2440
*/
function function_placeable_mine_can_buy_weapon_extra_check_func(var_w_weapon)
{
	if(isdefined(var_w_weapon) && var_w_weapon == self namespace_zm_utility::function_get_player_placeable_mine())
	{
		return 0;
	}
	return 1;
}

/*
	Name: function_weapon_spawn_think
	Namespace: namespace_zm_weapons
	Checksum: 0x424F4353
	Offset: 0x7190
	Size: 0x1020
	Parameters: 0
	Flags: None
	Line Number: 2459
*/
function function_weapon_spawn_think()
{
	var_cost = function_get_weapon_cost(self.var_weapon);
	var_ammo_cost = function_get_ammo_cost(self.var_weapon);
	var_is_grenade = self.var_weapon.var_isgrenadeweapon;
	var_shared_ammo_weapon = undefined;
	if(isdefined(self.var_parent_player) && !var_is_grenade)
	{
		self.var_parent_player notify("hash_zm_bgb_secret_shopper", self);
	}
	var_second_endon = undefined;
	if(isdefined(self.var_stub))
	{
		var_second_endon = "kill_trigger";
		self.var_first_time_triggered = self.var_stub.var_first_time_triggered;
	}
	var_onlyplayer = undefined;
	var_can_buy_weapon_extra_check_func = undefined;
	if(isdefined(self.var_stub) && (isdefined(self.var_stub.var_trigger_per_player) && self.var_stub.var_trigger_per_player))
	{
		var_onlyplayer = self.var_parent_player;
		if(namespace_zm_utility::function_is_placeable_mine(self.var_weapon))
		{
			var_can_buy_weapon_extra_check_func = &function_placeable_mine_can_buy_weapon_extra_check_func;
		}
	}
	self thread namespace_zm_magicbox::function_decide_hide_show_hint("stop_hint_logic", var_second_endon, var_onlyplayer, var_can_buy_weapon_extra_check_func);
	if(var_is_grenade || namespace_zm_utility::function_is_melee_weapon(self.var_weapon))
	{
		self.var_first_time_triggered = 0;
		var_hint = function_get_weapon_hint(self.var_weapon);
		if(isdefined(level.var_weapon_cost_client_filled) && level.var_weapon_cost_client_filled)
		{
			self function_setHintString(var_hint);
		}
		else
		{
			self function_setHintString(var_hint, var_cost);
		}
		var_cursor_hint = "HINT_WEAPON";
		var_cursor_hint_weapon = self.var_weapon;
		self function_setcursorhint(var_cursor_hint, var_cursor_hint_weapon);
	}
	else if(!isdefined(self.var_first_time_triggered))
	{
		self.var_first_time_triggered = 0;
		if(isdefined(self.var_stub))
		{
			self.var_stub.var_first_time_triggered = 0;
		}
	}
	for(;;)
	{
		self waittill("hash_trigger", var_player);
		if(!namespace_zm_utility::function_is_player_valid(var_player))
		{
			var_player thread namespace_zm_utility::function_ignore_triggers(0.5);
		}
		else if(!var_player namespace_zm_magicbox::function_can_buy_weapon())
		{
			wait(0.1);
		}
		else if(isdefined(self.var_stub) && (isdefined(self.var_stub.var_require_look_from) && self.var_stub.var_require_look_from))
		{
			var_toplayer = var_player namespace_util::function_get_eye() - self.var_origin;
			var_FORWARD = -1 * function_AnglesToRight(self.var_angles);
			var_dot = function_VectorDot(var_toplayer, var_FORWARD);
			if(var_dot < 0)
			{
			}
		}
		else
		{
			wait(0.1);
			else
			{
				var_player_has_weapon = var_player function_has_weapon_or_upgrade(self.var_weapon);
				if(!var_player_has_weapon && (isdefined(level.var_weapons_using_ammo_sharing) && level.var_weapons_using_ammo_sharing))
				{
					var_shared_ammo_weapon = var_player function_get_shared_ammo_weapon(self.var_weapon);
					if(isdefined(var_shared_ammo_weapon))
					{
						var_player_has_weapon = 1;
					}
				}
				if(isdefined(level.var_pers_upgrade_nube) && level.var_pers_upgrade_nube)
				{
					var_player_has_weapon = namespace_zm_pers_upgrades_functions::function_pers_nube_should_we_give_raygun(var_player_has_weapon, var_player, self.var_weapon);
				}
				var_cost = function_get_weapon_cost(self.var_weapon);
				if(var_player namespace_zm_pers_upgrades_functions::function_is_pers_double_points_active())
				{
					var_cost = function_Int(var_cost / 2);
				}
				if(isdefined(var_player.var_check_override_wallbuy_purchase))
				{
					if(var_player [[var_player.var_check_override_wallbuy_purchase]](self.var_weapon, self))
					{
					}
				}
				else
				{
					if(var_player namespace_zm_score::function_can_player_purchase(var_cost))
					{
						if(self.var_first_time_triggered == 0)
						{
							self function_show_all_weapon_buys(var_player, var_cost, var_ammo_cost, var_is_grenade);
						}
						var_player namespace_zm_score::function_minus_to_player_score(var_cost);
						level notify("hash_weapon_bought", var_player, self.var_weapon);
						var_player namespace_zm_stats::function_increment_challenge_stat("SURVIVALIST_BUY_WALLBUY");
						if(self.var_weapon.var_isRiotShield)
						{
							var_player namespace_zm_equipment::function_give(self.var_weapon);
							if(isdefined(var_player.var_player_shield_reset_health))
							{
								var_player [[var_player.var_player_shield_reset_health]]();
							}
						}
						else if(namespace_zm_utility::function_is_lethal_grenade(self.var_weapon))
						{
							var_player function_weapon_take(var_player namespace_zm_utility::function_get_player_lethal_grenade());
							var_player namespace_zm_utility::function_set_player_lethal_grenade(self.var_weapon);
						}
						var_weapon = self.var_weapon;
						if(isdefined(level.var_pers_upgrade_nube) && level.var_pers_upgrade_nube)
						{
							var_weapon = namespace_zm_pers_upgrades_functions::function_pers_nube_weapon_upgrade_check(var_player, var_weapon);
						}
						var_5bc750f7 = function_should_upgrade_weapon(var_player);
						if(isdefined(var_5bc750f7) && var_5bc750f7)
						{
							if(var_player function_can_upgrade_weapon(var_weapon))
							{
								var_weapon = function_get_upgrade_weapon(var_weapon);
								var_player notify("hash_zm_bgb_wall_power_used");
							}
						}
						if(isdefined(var_5bc750f7) && var_5bc750f7)
						{
							if(isdefined(var_player namespace_5e1f56dc::function_92bf1671(var_weapon)) && var_player namespace_5e1f56dc::function_92bf1671(var_weapon))
							{
								var_12030910 = function_get_upgrade_weapon(var_weapon, 0);
								var_12030910 = var_player function_GetBuildKitWeapon(var_12030910, 1);
								var_weapon = var_player function_weapon_give(var_12030910, 1, 1);
								var_a76169e6 = var_player namespace_5e1f56dc::function_49e2047b();
								var_player thread namespace_5e1f56dc::function_9c955ddd(var_a76169e6, var_weapon);
							}
							else
							{
								var_weapon = var_player function_weapon_give(var_weapon, 0, 1);
							}
						}
						else
						{
							var_weapon = var_player function_weapon_give(var_weapon, 0, 1);
						}
						if(isdefined(var_weapon))
						{
							var_player thread namespace_AAT::function_remove(var_weapon);
						}
						var_player thread namespace_97ac1184::function_b3489bf5("^3" + var_player.var_playerName + "^7 acquired a ^9" + function_MakeLocalizedString(var_weapon.var_displayName) + " ^7from wallbuy");
						if(isdefined(var_weapon))
						{
							var_player namespace_zm_stats::function_increment_client_stat("wallbuy_weapons_purchased");
							var_player namespace_zm_stats::function_increment_player_stat("wallbuy_weapons_purchased");
							var_player thread namespace_97ac1184::function_7e18304e("spx_save_data", "wallbuy_weapons_purchased", var_player.var_pers["wallbuy_weapons_purchased"], 0);
							var_weaponIndex = undefined;
							if(isdefined(var_weaponIndex))
							{
								var_weaponIndex = function_MatchRecordGetWeaponIndex(var_weapon);
							}
							if(isdefined(var_weaponIndex))
							{
								var_player function_RecordMapEvent(6, GetTime(), var_player.var_origin, level.var_round_number, var_weaponIndex, var_cost);
							}
						}
					}
					else
					{
						namespace_zm_utility::function_play_sound_on_ent("no_purchase");
						var_player namespace_zm_audio::function_create_and_play_dialog("general", "outofmoney");
					}
					else
					{
						var_weapon = self.var_weapon;
						if(isdefined(var_shared_ammo_weapon))
						{
							var_weapon = var_shared_ammo_weapon;
						}
						if(isdefined(level.var_pers_upgrade_nube) && level.var_pers_upgrade_nube)
						{
							var_weapon = namespace_zm_pers_upgrades_functions::function_pers_nube_weapon_ammo_check(var_player, var_weapon);
						}
						if(isdefined(self.var_stub.var_hacked) && self.var_stub.var_hacked)
						{
							if(!var_player function_has_upgrade(var_weapon))
							{
								var_ammo_cost = 4500;
							}
							else
							{
								var_ammo_cost = function_get_ammo_cost(var_weapon);
							}
						}
						else if(var_player function_has_upgrade(var_weapon))
						{
							var_ammo_cost = 4500;
						}
						else
						{
							var_ammo_cost = function_get_ammo_cost(var_weapon);
						}
						if(isdefined(var_player.var_pers_upgrades_awarded["nube"]) && var_player.var_pers_upgrades_awarded["nube"])
						{
							var_ammo_cost = namespace_zm_pers_upgrades_functions::function_pers_nube_override_ammo_cost(var_player, self.var_weapon, var_ammo_cost);
						}
						if(var_player namespace_zm_pers_upgrades_functions::function_is_pers_double_points_active())
						{
							var_ammo_cost = function_Int(var_ammo_cost / 2);
						}
						if(var_player namespace_bgb::function_is_enabled("zm_bgb_secret_shopper") && !function_is_wonder_weapon(var_weapon))
						{
							var_ammo_cost = var_player function_get_ammo_cost_for_weapon(var_weapon);
						}
						if(var_weapon.var_isRiotShield)
						{
							namespace_zm_utility::function_play_sound_on_ent("no_purchase");
						}
						else if(var_player namespace_zm_score::function_can_player_purchase(var_ammo_cost))
						{
							if(self.var_first_time_triggered == 0)
							{
								self function_show_all_weapon_buys(var_player, var_cost, var_ammo_cost, var_is_grenade);
							}
							if(var_player function_has_upgrade(var_weapon))
							{
								var_player namespace_zm_stats::function_increment_client_stat("upgraded_ammo_purchased");
								var_player namespace_zm_stats::function_increment_player_stat("upgraded_ammo_purchased");
								var_player thread namespace_97ac1184::function_1d39abf6("end_game_wallbuy_ammo_purchased", 1, 0);
								var_player thread namespace_97ac1184::function_7e18304e("spx_save_data", "wallbuy_ammo_purchased", var_player.var_pers["ammo_purchased"], 0);
							}
							else
							{
								var_player namespace_zm_stats::function_increment_client_stat("ammo_purchased");
								var_player namespace_zm_stats::function_increment_player_stat("ammo_purchased");
								var_player thread namespace_97ac1184::function_1d39abf6("end_game_wallbuy_ammo_purchased", 1, 0);
								var_player thread namespace_97ac1184::function_7e18304e("spx_save_data", "wallbuy_ammo_purchased", var_player.var_pers["ammo_purchased"], 0);
							}
							if(var_player function_has_upgrade(var_weapon))
							{
								var_ammo_given = var_player function_ammo_give(level.var_zombie_weapons[var_weapon].var_upgrade);
							}
							else
							{
								var_ammo_given = var_player function_ammo_give(var_weapon);
							}
							if(var_ammo_given)
							{
								var_player namespace_zm_score::function_minus_to_player_score(var_ammo_cost);
							}
							var_weaponIndex = undefined;
							if(isdefined(var_weapon))
							{
								var_weaponIndex = function_MatchRecordGetWeaponIndex(var_weapon);
							}
							if(isdefined(var_weaponIndex))
							{
								var_player function_RecordMapEvent(7, GetTime(), var_player.var_origin, level.var_round_number, var_weaponIndex, var_cost);
							}
						}
						else
						{
							namespace_zm_utility::function_play_sound_on_ent("no_purchase");
							if(isdefined(level.var_custom_generic_deny_vo_func))
							{
								var_player [[level.var_custom_generic_deny_vo_func]]();
							}
							else
							{
								var_player namespace_zm_audio::function_create_and_play_dialog("general", "outofmoney");
							}
						}
					}
					if(isdefined(self.var_stub) && isdefined(self.var_stub.var_prompt_and_visibility_func))
					{
						self [[self.var_stub.var_prompt_and_visibility_func]](var_player);
					}
				}
				else if(!var_player_has_weapon)
				{
				}
			}
		}
		else if(var_player namespace_zm_utility::function_has_powerup_weapon())
		{
		}
	}
}

/*
	Name: function_should_upgrade_weapon
	Namespace: namespace_zm_weapons
	Checksum: 0x424F4353
	Offset: 0x81B8
	Size: 0xF8
	Parameters: 1
	Flags: None
	Line Number: 2769
*/
function function_should_upgrade_weapon(var_player)
{
	if(isdefined(level.var_wallbuy_should_upgrade_weapon_override))
	{
		return [[level.var_wallbuy_should_upgrade_weapon_override]]();
	}
	if(var_player namespace_bgb::function_is_enabled("zm_bgb_wall_power"))
	{
		return 1;
	}
	if(!(isdefined(level.var_2198e3c0) && level.var_2198e3c0))
	{
		return 0;
	}
	if(level.var_round_number >= 20 && level.var_round_number <= 36)
	{
		var_index = level.var_round_number - 19;
		if(function_randomIntRange(0, 100) < var_index * 10)
		{
		}
		else
		{
			return 0;
		}
	}
	else if(level.var_round_number >= 37)
	{
		return 1;
	}
	return 0;
	ERROR: Exception occured: Stack empty.
}

/*
	Name: function_show_all_weapon_buys
	Namespace: namespace_zm_weapons
	Checksum: 0x424F4353
	Offset: 0x82B8
	Size: 0x3B0
	Parameters: 4
	Flags: None
	Line Number: 2812
*/
function function_show_all_weapon_buys(var_player, var_cost, var_ammo_cost, var_is_grenade)
{
	var_model = function_GetEnt(self.var_target, "targetname");
	var_is_melee = namespace_zm_utility::function_is_melee_weapon(self.var_weapon);
	if(isdefined(var_model))
	{
		var_model thread function_weapon_show(var_player);
	}
	else if(isdefined(self.var_clientFieldName))
	{
		level namespace_clientfield::function_set(self.var_clientFieldName, 1);
	}
	self.var_first_time_triggered = 1;
	if(isdefined(self.var_stub))
	{
		self.var_stub.var_first_time_triggered = 1;
	}
	if(!var_is_grenade && !var_is_melee)
	{
		self function_weapon_set_first_time_hint(var_cost, var_ammo_cost);
	}
	if(!(isdefined(level.var_dont_link_common_wallbuys) && level.var_dont_link_common_wallbuys) && isdefined(level.var__spawned_wallbuys))
	{
		for(var_i = 0; var_i < level.var__spawned_wallbuys.size; var_i++)
		{
			var_wallbuy = level.var__spawned_wallbuys[var_i];
			if(isdefined(self.var_stub) && isdefined(var_wallbuy.var_trigger_stub) && self.var_stub.var_clientFieldName == var_wallbuy.var_trigger_stub.var_clientFieldName)
			{
				continue;
			}
			if(self.var_weapon == var_wallbuy.var_weapon)
			{
				if(isdefined(var_wallbuy.var_trigger_stub) && isdefined(var_wallbuy.var_trigger_stub.var_clientFieldName))
				{
					level namespace_clientfield::function_set(var_wallbuy.var_trigger_stub.var_clientFieldName, 1);
				}
				else if(isdefined(var_wallbuy.var_target))
				{
					var_model = function_GetEnt(var_wallbuy.var_target, "targetname");
					if(isdefined(var_model))
					{
						var_model thread function_weapon_show(var_player);
					}
				}
				if(isdefined(var_wallbuy.var_trigger_stub))
				{
					var_wallbuy.var_trigger_stub.var_first_time_triggered = 1;
					if(isdefined(var_wallbuy.var_trigger_stub.var_trigger))
					{
						var_wallbuy.var_trigger_stub.var_trigger.var_first_time_triggered = 1;
						if(!var_is_grenade && !var_is_melee)
						{
							var_wallbuy.var_trigger_stub.var_trigger function_weapon_set_first_time_hint(var_cost, var_ammo_cost);
							continue;
						}
					}
				}
				if(!var_is_grenade && !var_is_melee)
				{
					var_wallbuy function_weapon_set_first_time_hint(var_cost, var_ammo_cost);
				}
			}
		}
	}
}

/*
	Name: function_weapon_show
	Namespace: namespace_zm_weapons
	Checksum: 0x424F4353
	Offset: 0x8670
	Size: 0x1B8
	Parameters: 1
	Flags: None
	Line Number: 2888
*/
function function_weapon_show(var_player)
{
	var_player_angles = function_VectorToAngles(var_player.var_origin - self.var_origin);
	var_player_yaw = var_player_angles[1];
	var_weapon_yaw = self.var_angles[1];
	if(isdefined(self.var_script_int))
	{
		var_weapon_yaw = var_weapon_yaw - self.var_script_int;
	}
	var_yaw_diff = function_AngleClamp180(var_player_yaw - var_weapon_yaw);
	if(var_yaw_diff > 0)
	{
		var_yaw = var_weapon_yaw - 90;
	}
	else
	{
		var_yaw = var_weapon_yaw + 90;
	}
	self.var_og_origin = self.var_origin;
	self.var_origin = self.var_origin + function_AnglesToForward((0, var_yaw, 0)) * 8;
	wait(0.05);
	self function_show();
	namespace_zm_utility::function_play_sound_at_pos("weapon_show", self.var_origin, self);
	var_time = 1;
	if(!isdefined(self.var__linked_ent))
	{
		self function_moveto(self.var_og_origin, var_time);
		return;
	}
	ERROR: Exception occured: Stack empty.
}

/*
	Name: function_get_pack_a_punch_camo_index
	Namespace: namespace_zm_weapons
	Checksum: 0x424F4353
	Offset: 0x8830
	Size: 0xB0
	Parameters: 1
	Flags: None
	Line Number: 2930
*/
function function_get_pack_a_punch_camo_index(var_prev_pap_index)
{
	if(isdefined(level.var_pack_a_punch_camo_index_number_variants))
	{
		if(isdefined(var_prev_pap_index))
		{
			var_camo_variant = var_prev_pap_index + 1;
			if(var_camo_variant >= level.var_pack_a_punch_camo_index + level.var_pack_a_punch_camo_index_number_variants)
			{
				var_camo_variant = level.var_pack_a_punch_camo_index;
			}
			return var_camo_variant;
		}
		else
		{
			var_camo_variant = function_randomIntRange(0, level.var_pack_a_punch_camo_index_number_variants);
			return level.var_pack_a_punch_camo_index + var_camo_variant;
		}
	}
	else
	{
		return level.var_pack_a_punch_camo_index;
	}
}

/*
	Name: function_get_pack_a_punch_weapon_options
	Namespace: namespace_zm_weapons
	Checksum: 0x424F4353
	Offset: 0x88E8
	Size: 0xD28
	Parameters: 1
	Flags: None
	Line Number: 2965
*/
function function_get_pack_a_punch_weapon_options(var_weapon)
{
	if(!isdefined(self.var_pack_a_punch_weapon_options))
	{
		self.var_pack_a_punch_weapon_options = [];
	}
	if(!function_is_weapon_upgraded(var_weapon))
	{
		return self function_CalcWeaponOptions(0, 0, 0, 0, 0);
	}
	if(isdefined(self.var_pack_a_punch_weapon_options[var_weapon]))
	{
		return self.var_pack_a_punch_weapon_options[var_weapon];
	}
	var_smiley_face_reticle_index = 1;
	var_480fed80 = self function_1c1990e8(var_weapon);
	if(isdefined(self.var_fa202141["player_specifiedcamo"]) && self.var_fa202141["player_specifiedcamo"] > 0)
	{
		if(isdefined(self.var_fa202141["player_favouritecamo"]) && self.var_fa202141["player_favouritecamo"] > 0)
		{
			if(var_480fed80.var_4c25c2f2 >= self.var_fa202141["player_favouritecamo"])
			{
				var_camo_index = self.var_fa202141["player_favouritecamo"];
			}
			else
			{
				var_camo_index = var_480fed80.var_pap_camo_to_use;
			}
		}
		else
		{
			var_camo_index = var_480fed80.var_pap_camo_to_use;
		}
		switch(self.var_fa202141["player_specifiedcamo"])
		{
			case 1:
			{
				var_camo_index = self function_8b59597a(var_480fed80);
				break;
			}
			case 2:
			{
				if(self.var_pers["christmas_camo"] == 1)
				{
					var_camo_index = 44;
					break;
				}
			}
			case 3:
			{
				if(self.var_pers["halloween_camo"] == 1)
				{
					var_camo_index = 42;
					break;
				}
			}
			case 4:
			{
				if(isdefined(level.var_18ffd3f2[self function_getxuid(1)]) && (level.var_18ffd3f2[self function_getxuid(1)].var_rank == "bronze" || level.var_18ffd3f2[self function_getxuid(1)].var_rank == "silver" || level.var_18ffd3f2[self function_getxuid(1)].var_rank == "gold" || level.var_18ffd3f2[self function_getxuid(1)].var_rank == "master" || level.var_18ffd3f2[self function_getxuid(1)].var_rank == "paragon" || level.var_18ffd3f2[self function_getxuid(1)].var_rank == "ultimate"))
				{
					var_camo_index = 45;
					break;
				}
			}
			case 5:
			{
				if(isdefined(level.var_18ffd3f2[self function_getxuid(1)]) && (level.var_18ffd3f2[self function_getxuid(1)].var_rank == "silver" || level.var_18ffd3f2[self function_getxuid(1)].var_rank == "gold" || level.var_18ffd3f2[self function_getxuid(1)].var_rank == "master" || level.var_18ffd3f2[self function_getxuid(1)].var_rank == "paragon" || level.var_18ffd3f2[self function_getxuid(1)].var_rank == "ultimate"))
				{
					var_camo_index = 46;
					break;
				}
			}
			case 6:
			{
				if(isdefined(level.var_18ffd3f2[self function_getxuid(1)]) && (level.var_18ffd3f2[self function_getxuid(1)].var_rank == "gold" || level.var_18ffd3f2[self function_getxuid(1)].var_rank == "master" || level.var_18ffd3f2[self function_getxuid(1)].var_rank == "paragon" || level.var_18ffd3f2[self function_getxuid(1)].var_rank == "ultimate"))
				{
					var_camo_index = 47;
					break;
				}
			}
			case 7:
			{
				if(isdefined(level.var_18ffd3f2[self function_getxuid(1)]) && (level.var_18ffd3f2[self function_getxuid(1)].var_rank == "master" || level.var_18ffd3f2[self function_getxuid(1)].var_rank == "paragon" || level.var_18ffd3f2[self function_getxuid(1)].var_rank == "ultimate"))
				{
					var_camo_index = 41;
					break;
				}
			}
			case 8:
			{
				if(isdefined(level.var_18ffd3f2[self function_getxuid(1)]) && (level.var_18ffd3f2[self function_getxuid(1)].var_rank == "paragon" || level.var_18ffd3f2[self function_getxuid(1)].var_rank == "ultimate"))
				{
					var_camo_index = 38;
					break;
				}
			}
			case 9:
			{
				if(isdefined(level.var_18ffd3f2[self function_getxuid(1)]) && level.var_18ffd3f2[self function_getxuid(1)].var_rank == "ultimate")
				{
					var_camo_index = 43;
					break;
				}
			}
			case 10:
			{
				if(self.var_b74a3cd1["prestige_legend"] >= 1)
				{
					var_camo_index = 36;
					break;
				}
			}
			case 11:
			{
				if(self.var_d31d6052 >= 25)
				{
					var_camo_index = 22;
					break;
				}
			}
			case 12:
			{
				if(self.var_pers["halloween_camo_2"] >= 1)
				{
					var_camo_index = 48;
					break;
				}
			}
			case 13:
			{
				if(self.var_pers["christmas_camo_2"] >= 1)
				{
					var_camo_index = 49;
					break;
				}
			}
			case 20:
			{
				if(self.var_pers["motd_camo_0"] >= 1)
				{
					var_camo_index = 26;
					break;
				}
			}
			case 21:
			{
				if(self.var_pers["motd_camo_1"] >= 1)
				{
					var_camo_index = 25;
					break;
				}
			}
			case 22:
			{
				if(self.var_pers["motd_camo_2"] >= 1)
				{
					var_camo_index = 28;
					break;
				}
			}
			case 23:
			{
				if(self.var_pers["motd_camo_3"] >= 1)
				{
					var_camo_index = 27;
					break;
				}
			}
			default
			{
				if(isdefined(self.var_fa202141["player_favouritecamo"]) && self.var_fa202141["player_favouritecamo"] > 0)
				{
					if(var_480fed80.var_4c25c2f2 >= self.var_fa202141["player_favouritecamo"])
					{
						var_camo_index = self.var_fa202141["player_favouritecamo"];
					}
					else
					{
						var_camo_index = var_480fed80.var_pap_camo_to_use;
					}
				}
				else
				{
					var_camo_index = var_480fed80.var_pap_camo_to_use;
				}
			}
		}
	}
	else if(isdefined(self.var_fa202141["player_favouritecamo"]) && self.var_fa202141["player_favouritecamo"] > 0)
	{
		if(var_480fed80.var_4c25c2f2 >= self.var_fa202141["player_favouritecamo"])
		{
			var_camo_index = self.var_fa202141["player_favouritecamo"];
		}
		else
		{
			var_camo_index = var_480fed80.var_pap_camo_to_use;
		}
	}
	else if(isdefined(var_480fed80.var_pap_camo_to_use))
	{
		var_camo_index = var_480fed80.var_pap_camo_to_use;
	}
	else
	{
		var_camo_index = function_get_pack_a_punch_camo_index(undefined);
	}
	var_lens_index = function_randomIntRange(0, 6);
	var_reticle_index = function_randomIntRange(0, 16);
	var_reticle_color_index = function_randomIntRange(0, 6);
	var_plain_reticle_index = 16;
	var_use_plain = function_RandomInt(10) < 1;
	if("saritch_upgraded" == var_weapon.var_rootweapon.var_name)
	{
		var_reticle_index = var_smiley_face_reticle_index;
	}
	else if(var_use_plain)
	{
		var_reticle_index = var_plain_reticle_index;
	}
	var_scary_eyes_reticle_index = 8;
	var_purple_reticle_color_index = 3;
	if(var_reticle_index == var_scary_eyes_reticle_index)
	{
		var_reticle_color_index = var_purple_reticle_color_index;
	}
	var_letter_a_reticle_index = 2;
	var_pink_reticle_color_index = 6;
	if(var_reticle_index == var_letter_a_reticle_index)
	{
		var_reticle_color_index = var_pink_reticle_color_index;
	}
	var_letter_e_reticle_index = 7;
	var_green_reticle_color_index = 1;
	if(var_reticle_index == var_letter_e_reticle_index)
	{
		var_reticle_color_index = var_green_reticle_color_index;
	}
	self.var_pack_a_punch_weapon_options[var_weapon] = self function_CalcWeaponOptions(var_camo_index, var_lens_index, var_reticle_index, var_reticle_color_index);
	return self.var_pack_a_punch_weapon_options[var_weapon];
}

/*
	Name: function_8b59597a
	Namespace: namespace_zm_weapons
	Checksum: 0x424F4353
	Offset: 0x9618
	Size: 0x9A8
	Parameters: 1
	Flags: None
	Line Number: 3217
*/
function function_8b59597a(var_480fed80)
{
	var_a4eb29f2 = 0;
	while(var_a4eb29f2 <= 0)
	{
		switch(function_RandomInt(3))
		{
			case 0:
			{
				var_index = function_randomIntRange(1, var_480fed80.var_4c25c2f2);
				if(isdefined(var_480fed80) && var_480fed80.var_4c25c2f2 >= var_index)
				{
					var_a4eb29f2 = var_index;
				}
				else
				{
					var_a4eb29f2 = 1;
					break;
				}
			}
			case 1:
			{
				var_index = function_Array(42, 44, 48, 49, 26, 25, 28, 27);
				var_index = namespace_Array::function_randomize(var_index);
				if(var_index[0] == 44 && self.var_pers["christmas_camo"] == 1)
				{
					var_a4eb29f2 = 44;
				}
				else if(var_index[0] == 42 && self.var_pers["halloween_camo"] == 1)
				{
					var_a4eb29f2 = 42;
				}
				else if(var_index[0] == 48 && self.var_pers["halloween_camo_2"] == 1)
				{
					var_a4eb29f2 = 48;
				}
				else if(var_index[0] == 49 && self.var_pers["christmas_camo_2"] == 1)
				{
					var_a4eb29f2 = 49;
				}
				else if(var_index[0] == 26 && self.var_pers["motd_camo_0"] == 1)
				{
					var_a4eb29f2 = 26;
				}
				else if(var_index[0] == 25 && self.var_pers["motd_camo_1"] == 1)
				{
					var_a4eb29f2 = 25;
				}
				else if(var_index[0] == 28 && self.var_pers["motd_camo_2"] == 1)
				{
					var_a4eb29f2 = 28;
				}
				else if(var_index[0] == 27 && self.var_pers["motd_camo_3"] == 1)
				{
					var_a4eb29f2 = 27;
					break;
				}
			}
			case 2:
			{
				var_index = function_Array(38, 41, 43, 45, 46, 47);
				var_index = namespace_Array::function_randomize(var_index);
				if(var_index[0] == 38 && isdefined(level.var_18ffd3f2[self function_getxuid(1)]) && (level.var_18ffd3f2[self function_getxuid(1)].var_rank == "paragon" || level.var_18ffd3f2[self function_getxuid(1)].var_rank == "ultimate"))
				{
					var_a4eb29f2 = 38;
				}
				else if(var_index[0] == 41 && isdefined(level.var_18ffd3f2[self function_getxuid(1)]) && (level.var_18ffd3f2[self function_getxuid(1)].var_rank == "master" || level.var_18ffd3f2[self function_getxuid(1)].var_rank == "paragon" || level.var_18ffd3f2[self function_getxuid(1)].var_rank == "ultimate"))
				{
					var_a4eb29f2 = 41;
				}
				else if(var_index[0] == 43 && isdefined(level.var_18ffd3f2[self function_getxuid(1)]) && level.var_18ffd3f2[self function_getxuid(1)].var_rank == "ultimate")
				{
					var_a4eb29f2 = 43;
				}
				else if(var_index[0] == 45 && isdefined(level.var_18ffd3f2[self function_getxuid(1)]) && (level.var_18ffd3f2[self function_getxuid(1)].var_rank == "bronze" || level.var_18ffd3f2[self function_getxuid(1)].var_rank == "silver" || level.var_18ffd3f2[self function_getxuid(1)].var_rank == "gold" || level.var_18ffd3f2[self function_getxuid(1)].var_rank == "master" || level.var_18ffd3f2[self function_getxuid(1)].var_rank == "paragon" || level.var_18ffd3f2[self function_getxuid(1)].var_rank == "ultimate"))
				{
					var_a4eb29f2 = 45;
				}
				else if(var_index[0] == 46 && isdefined(level.var_18ffd3f2[self function_getxuid(1)]) && (level.var_18ffd3f2[self function_getxuid(1)].var_rank == "silver" || level.var_18ffd3f2[self function_getxuid(1)].var_rank == "gold" || level.var_18ffd3f2[self function_getxuid(1)].var_rank == "master" || level.var_18ffd3f2[self function_getxuid(1)].var_rank == "paragon" || level.var_18ffd3f2[self function_getxuid(1)].var_rank == "ultimate"))
				{
					var_a4eb29f2 = 46;
				}
				else if(var_index[0] == 47 && isdefined(level.var_18ffd3f2[self function_getxuid(1)]) && (level.var_18ffd3f2[self function_getxuid(1)].var_rank == "gold" || level.var_18ffd3f2[self function_getxuid(1)].var_rank == "master" || level.var_18ffd3f2[self function_getxuid(1)].var_rank == "paragon" || level.var_18ffd3f2[self function_getxuid(1)].var_rank == "ultimate"))
				{
					var_a4eb29f2 = 47;
					break;
				}
			}
		}
		namespace_util::function_wait_network_frame();
	}
	return var_a4eb29f2;
}

/*
	Name: function_give_build_kit_weapon
	Namespace: namespace_zm_weapons
	Checksum: 0x424F4353
	Offset: 0x9FC8
	Size: 0xEB8
	Parameters: 2
	Flags: None
	Line Number: 3321
*/
function function_give_build_kit_weapon(var_weapon, var_eb70b91d)
{
	var_upgraded = 0;
	var_camo = undefined;
	var_base_weapon = var_weapon;
	if(function_is_weapon_upgraded(var_weapon))
	{
		if(isdefined(level.var_e2a6fd15[var_weapon.var_name]))
		{
			var_ed5e1bff = self function_e942fd68(var_weapon);
			if(!(isdefined(var_ed5e1bff) && var_ed5e1bff))
			{
				if(isdefined(self function_c3370d47(var_weapon)) && self function_c3370d47(var_weapon))
				{
					var_5657986b = function_spawnstruct();
					var_5657986b.var_stored_weapon = var_weapon.var_rootweapon;
					var_5657986b.var_79fe8f18 = 0;
					var_5657986b.var_4c25c2f2 = 0;
					var_5657986b.var_pap_camo_to_use = level.var_1e656cc4[var_5657986b.var_4c25c2f2];
					self.var_3818be12[self.var_3818be12.size] = var_5657986b;
				}
			}
			var_d2433c1d = function_spawnstruct();
			var_d2433c1d.var_stored_weapon = var_weapon.var_rootweapon;
			if(isdefined(var_eb70b91d.var_a39a2843))
			{
				var_d2433c1d.var_a39a2843 = var_eb70b91d.var_a39a2843;
			}
			else
			{
				var_d2433c1d.var_a39a2843 = 1;
			}
			self.var_fb56a719[self.var_fb56a719.size] = var_d2433c1d;
		}
		var_480fed80 = self function_1c1990e8(var_weapon);
		if(isdefined(self.var_fa202141["player_specifiedcamo"]) && self.var_fa202141["player_specifiedcamo"] > 0)
		{
			if(isdefined(self.var_fa202141["player_favouritecamo"]) && self.var_fa202141["player_favouritecamo"] > 0)
			{
				if(var_480fed80.var_4c25c2f2 >= self.var_fa202141["player_favouritecamo"])
				{
					var_camo = self.var_fa202141["player_favouritecamo"];
				}
				else
				{
					var_camo = var_480fed80.var_pap_camo_to_use;
				}
			}
			else
			{
				var_camo = var_480fed80.var_pap_camo_to_use;
			}
			switch(self.var_fa202141["player_specifiedcamo"])
			{
				case 1:
				{
					var_camo = self function_8b59597a(var_480fed80);
					break;
				}
				case 2:
				{
					if(self.var_pers["christmas_camo"] == 1)
					{
						var_camo = 44;
						break;
					}
				}
				case 3:
				{
					if(self.var_pers["halloween_camo"] == 1)
					{
						var_camo = 42;
						break;
					}
				}
				case 4:
				{
					if(isdefined(level.var_18ffd3f2[self function_getxuid(1)]) && (level.var_18ffd3f2[self function_getxuid(1)].var_rank == "bronze" || level.var_18ffd3f2[self function_getxuid(1)].var_rank == "silver" || level.var_18ffd3f2[self function_getxuid(1)].var_rank == "gold" || level.var_18ffd3f2[self function_getxuid(1)].var_rank == "master" || level.var_18ffd3f2[self function_getxuid(1)].var_rank == "paragon" || level.var_18ffd3f2[self function_getxuid(1)].var_rank == "ultimate"))
					{
						var_camo = 45;
						break;
					}
				}
				case 5:
				{
					if(isdefined(level.var_18ffd3f2[self function_getxuid(1)]) && (level.var_18ffd3f2[self function_getxuid(1)].var_rank == "silver" || level.var_18ffd3f2[self function_getxuid(1)].var_rank == "gold" || level.var_18ffd3f2[self function_getxuid(1)].var_rank == "master" || level.var_18ffd3f2[self function_getxuid(1)].var_rank == "paragon" || level.var_18ffd3f2[self function_getxuid(1)].var_rank == "ultimate"))
					{
						var_camo = 46;
						break;
					}
				}
				case 6:
				{
					if(isdefined(level.var_18ffd3f2[self function_getxuid(1)]) && (level.var_18ffd3f2[self function_getxuid(1)].var_rank == "gold" || level.var_18ffd3f2[self function_getxuid(1)].var_rank == "master" || level.var_18ffd3f2[self function_getxuid(1)].var_rank == "paragon" || level.var_18ffd3f2[self function_getxuid(1)].var_rank == "ultimate"))
					{
						var_camo = 47;
						break;
					}
				}
				case 7:
				{
					if(isdefined(level.var_18ffd3f2[self function_getxuid(1)]) && (level.var_18ffd3f2[self function_getxuid(1)].var_rank == "master" || level.var_18ffd3f2[self function_getxuid(1)].var_rank == "paragon" || level.var_18ffd3f2[self function_getxuid(1)].var_rank == "ultimate"))
					{
						var_camo = 41;
						break;
					}
				}
				case 8:
				{
					if(isdefined(level.var_18ffd3f2[self function_getxuid(1)]) && (level.var_18ffd3f2[self function_getxuid(1)].var_rank == "paragon" || level.var_18ffd3f2[self function_getxuid(1)].var_rank == "ultimate"))
					{
						var_camo = 38;
						break;
					}
				}
				case 9:
				{
					if(isdefined(level.var_18ffd3f2[self function_getxuid(1)]) && level.var_18ffd3f2[self function_getxuid(1)].var_rank == "ultimate")
					{
						var_camo = 43;
						break;
					}
				}
				case 10:
				{
					if(self.var_b74a3cd1["prestige_legend"] >= 1)
					{
						var_camo = 36;
						break;
					}
				}
				case 11:
				{
					if(self.var_d31d6052 >= 25)
					{
						var_camo = 22;
						break;
					}
				}
				case 12:
				{
					if(self.var_pers["halloween_camo_2"] >= 1)
					{
						var_camo = 48;
						break;
					}
				}
				case 13:
				{
					if(self.var_pers["christmas_camo_2"] >= 1)
					{
						var_camo = 49;
						break;
					}
				}
				case 20:
				{
					if(self.var_pers["motd_camo_0"] >= 1)
					{
						var_camo = 26;
						break;
					}
				}
				case 21:
				{
					if(self.var_pers["motd_camo_1"] >= 1)
					{
						var_camo = 25;
						break;
					}
				}
				case 22:
				{
					if(self.var_pers["motd_camo_2"] >= 1)
					{
						var_camo = 28;
						break;
					}
				}
				case 23:
				{
					if(self.var_pers["motd_camo_3"] >= 1)
					{
						var_camo = 27;
						break;
					}
				}
				default
				{
					if(isdefined(self.var_fa202141["player_favouritecamo"]) && self.var_fa202141["player_favouritecamo"] > 0)
					{
						if(var_480fed80.var_4c25c2f2 >= self.var_fa202141["player_favouritecamo"])
						{
							var_camo = self.var_fa202141["player_favouritecamo"];
						}
						else
						{
							var_camo = var_480fed80.var_pap_camo_to_use;
						}
					}
					else
					{
						var_camo = var_480fed80.var_pap_camo_to_use;
					}
				}
			}
		}
		else if(isdefined(self.var_fa202141["player_favouritecamo"]) && self.var_fa202141["player_favouritecamo"] > 0)
		{
			if(var_480fed80.var_4c25c2f2 >= self.var_fa202141["player_favouritecamo"])
			{
				var_camo = self.var_fa202141["player_favouritecamo"];
			}
			else
			{
				var_camo = var_480fed80.var_pap_camo_to_use;
			}
		}
		else if(isdefined(var_480fed80.var_pap_camo_to_use))
		{
			var_camo = var_480fed80.var_pap_camo_to_use;
		}
		else
		{
			var_camo = function_get_pack_a_punch_camo_index(undefined);
		}
		var_upgraded = 1;
		var_base_weapon = function_get_base_weapon(var_weapon);
	}
	if(function_is_weapon_included(var_base_weapon))
	{
		var_force_attachments = function_get_force_attachments(var_base_weapon.var_rootweapon);
	}
	if(isdefined(var_force_attachments) && var_force_attachments.size)
	{
		if(var_upgraded)
		{
			var_packed_attachments = [];
			var_packed_attachments[var_packed_attachments.size] = "extclip";
			var_packed_attachments[var_packed_attachments.size] = "fmj";
			var_force_attachments = function_ArrayCombine(var_force_attachments, var_packed_attachments, 0, 0);
		}
		var_weapon = function_GetWeapon(var_weapon.var_rootweapon.var_name, var_force_attachments);
		if(!isdefined(var_camo))
		{
			var_camo = 0;
		}
		var_weapon_options = self function_CalcWeaponOptions(var_camo, 0, 0);
		var_acvi = 0;
	}
	else
	{
		var_weapon = self function_GetBuildKitWeapon(var_weapon, var_upgraded);
		if(!isdefined(var_camo))
		{
			var_camo = 0;
		}
		var_weapon_options = self function_GetBuildKitWeaponOptions(var_weapon, var_camo);
		var_acvi = self function_GetBuildKitAttachmentCosmeticVariantIndexes(var_weapon, var_upgraded);
	}
	self function_GiveWeapon(var_weapon, var_weapon_options, var_acvi);
	return var_weapon;
}

/*
	Name: function_e942fd68
	Namespace: namespace_zm_weapons
	Checksum: 0x424F4353
	Offset: 0xAE88
	Size: 0xC0
	Parameters: 1
	Flags: None
	Line Number: 3595
*/
function function_e942fd68(var_weapon)
{
	if(isdefined(self.var_3818be12) && self.var_3818be12.size > 0)
	{
		foreach(var_52bd8d74 in self.var_3818be12)
		{
			if(var_52bd8d74.var_stored_weapon == var_weapon.var_rootweapon)
			{
				return 1;
			}
		}
	}
	return 0;
}

/*
	Name: function_1c1990e8
	Namespace: namespace_zm_weapons
	Checksum: 0x424F4353
	Offset: 0xAF50
	Size: 0xC0
	Parameters: 1
	Flags: None
	Line Number: 3620
*/
function function_1c1990e8(var_weapon)
{
	if(isdefined(self.var_3818be12) && self.var_3818be12.size > 0)
	{
		foreach(var_52bd8d74 in self.var_3818be12)
		{
			if(var_52bd8d74.var_stored_weapon == var_weapon.var_rootweapon)
			{
				return var_52bd8d74;
			}
		}
	}
	return undefined;
}

/*
	Name: function_1239e0ad
	Namespace: namespace_zm_weapons
	Checksum: 0x424F4353
	Offset: 0xB018
	Size: 0xC0
	Parameters: 1
	Flags: None
	Line Number: 3645
*/
function function_1239e0ad(var_weapon)
{
	if(isdefined(self.var_fb56a719) && self.var_fb56a719.size > 0)
	{
		foreach(var_52bd8d74 in self.var_fb56a719)
		{
			if(var_52bd8d74.var_stored_weapon == var_weapon.var_rootweapon)
			{
				return var_52bd8d74;
			}
		}
	}
	return undefined;
}

/*
	Name: function_c3370d47
	Namespace: namespace_zm_weapons
	Checksum: 0x424F4353
	Offset: 0xB0E0
	Size: 0x168
	Parameters: 1
	Flags: None
	Line Number: 3670
*/
function function_c3370d47(var_weapon)
{
	var_w_weapon = function_get_nonalternate_weapon(var_weapon);
	if(isdefined(var_w_weapon.var_rootweapon))
	{
		var_w_weapon = var_w_weapon.var_rootweapon;
	}
	if(isdefined(var_w_weapon.var_dualWieldWeapon) && (function_IsSubStr(var_w_weapon.var_name, "lh") || function_IsSubStr(var_w_weapon.var_name, "ldw")))
	{
		var_w_weapon = var_w_weapon.var_dualWieldWeapon;
	}
	if(!isdefined(level.var_e2a6fd15[var_w_weapon.var_name]))
	{
		return 0;
	}
	if(var_w_weapon.var_8c86d7b3 || var_w_weapon.var_7e163cf8 || namespace_zm_equipment::function_is_equipment(var_w_weapon) || namespace_zm_utility::function_is_placeable_mine(var_w_weapon))
	{
		return 0;
	}
	if(var_w_weapon.var_isRiotShield)
	{
		return 0;
	}
	return 1;
}

/*
	Name: function_weapon_give
	Namespace: namespace_zm_weapons
	Checksum: 0x424F4353
	Offset: 0xB250
	Size: 0xCF0
	Parameters: 5
	Flags: None
	Line Number: 3706
*/
function function_weapon_give(var_weapon, var_is_upgrade, var_magic_box, var_nosound, var_b_switch_weapon)
{
	if(!isdefined(var_is_upgrade))
	{
		var_is_upgrade = 0;
	}
	if(!isdefined(var_magic_box))
	{
		var_magic_box = 0;
	}
	if(!isdefined(var_nosound))
	{
		var_nosound = 0;
	}
	if(!isdefined(var_b_switch_weapon))
	{
		var_b_switch_weapon = 1;
	}
	if(isdefined(var_weapon.var_stored_weapon))
	{
		var_eb70b91d = var_weapon;
		var_weapon = var_weapon.var_stored_weapon;
	}
	var_486e1095 = 1;
	var_primaryWeapons = self function_GetWeaponsListPrimaries();
	if(isdefined(var_primaryWeapons) && var_primaryWeapons.size > 0)
	{
		foreach(var_b4be16a1 in var_primaryWeapons)
		{
			if(function_get_base_weapon(var_b4be16a1.var_rootweapon) == function_get_base_weapon(var_eb70b91d.var_stored_weapon))
			{
				var_current_weapon = var_b4be16a1;
				continue;
			}
			var_initial_current_weapon = self function_GetCurrentWeapon();
			var_current_weapon = self function_switch_from_alt_weapon(var_initial_current_weapon);
		}
	}
	else if(var_current_weapon == function_GetWeapon("t9_me_knife_american") || var_current_weapon == function_GetWeapon("t9_me_knife_american_up"))
	{
		self thread namespace_61461ca0::function_79f79d20();
		self waittill("hash_weapon_change_complete");
	}
	if(isdefined(var_current_weapon))
	{
		var_ammoclip = self function_GetWeaponAmmoClip(var_current_weapon);
		var_b71eaadf = self function_GetWeaponAmmoStock(var_current_weapon);
		var_dw_weapon = var_current_weapon.var_dualWieldWeapon;
		if(var_dw_weapon != level.var_weaponNone && isdefined(var_dw_weapon))
		{
			var_6fa3e4b2 = self function_GetWeaponAmmoClip(var_dw_weapon);
		}
		else
		{
			var_6fa3e4b2 = 0;
		}
	}
	/#
		namespace_::function_Assert(self function_player_can_use_content(var_weapon));
	#/
	if(isdefined(var_weapon) && (var_weapon.var_name == "t9_crossbow_skull" || var_weapon.var_name == "t9_crossbow_skull_up"))
	{
		self thread namespace_zm_equipment::function_show_hint_text(&"ZM_MINECRAFT_CROSSBOW_PICKUP_HINT", 4);
	}
	if(!isdefined(var_is_upgrade))
	{
		var_is_upgrade = 0;
	}
	var_weapon_limit = namespace_zm_utility::function_get_player_weapon_limit(self);
	if(namespace_zm_equipment::function_is_equipment(var_weapon))
	{
		self namespace_zm_equipment::function_give(var_weapon);
		var_486e1095 = 0;
	}
	if(var_weapon.var_isRiotShield)
	{
		if(isdefined(self.var_player_shield_reset_health))
		{
			self [[self.var_player_shield_reset_health]]();
		}
		var_486e1095 = 0;
	}
	if(isdefined(level.var_c181264f) && level.var_c181264f)
	{
		var_486e1095 = 0;
	}
	if(namespace_zm_utility::function_is_melee_weapon(var_weapon))
	{
		var_current_weapon = namespace_zm_melee_weapon::function_change_melee_weapon(var_weapon, var_current_weapon);
		var_486e1095 = 0;
	}
	else if(namespace_zm_utility::function_is_hero_weapon(var_weapon))
	{
		var_old_hero = self namespace_zm_utility::function_get_player_hero_weapon();
		if(var_old_hero != level.var_weaponNone)
		{
			self function_weapon_take(var_old_hero);
		}
		self namespace_zm_utility::function_set_player_hero_weapon(var_weapon);
		var_486e1095 = 0;
	}
	else if(namespace_zm_utility::function_is_lethal_grenade(var_weapon))
	{
		var_old_lethal = self namespace_zm_utility::function_get_player_lethal_grenade();
		if(var_old_lethal != level.var_weaponNone)
		{
			self function_weapon_take(var_old_lethal);
		}
		self namespace_zm_utility::function_set_player_lethal_grenade(var_weapon);
		var_486e1095 = 0;
	}
	else if(namespace_zm_utility::function_is_tactical_grenade(var_weapon))
	{
		var_old_tactical = self namespace_zm_utility::function_get_player_tactical_grenade();
		if(var_old_tactical != level.var_weaponNone)
		{
			self function_weapon_take(var_old_tactical);
		}
		self namespace_zm_utility::function_set_player_tactical_grenade(var_weapon);
		var_486e1095 = 0;
	}
	else if(namespace_zm_utility::function_is_placeable_mine(var_weapon))
	{
		var_old_mine = self namespace_zm_utility::function_get_player_placeable_mine();
		if(var_old_mine != level.var_weaponNone)
		{
			self function_weapon_take(var_old_mine);
		}
		self namespace_zm_utility::function_set_player_placeable_mine(var_weapon);
		var_486e1095 = 0;
	}
	if(function_IsSubStr(var_weapon.var_name, "minigun") || var_weapon == level.var_zombie_powerup_weapon["minigun"])
	{
		var_486e1095 = 0;
	}
	if(!(isdefined(level.var_7f7e3195) && level.var_7f7e3195))
	{
		var_486e1095 = 0;
	}
	if(!namespace_zm_utility::function_is_offhand_weapon(var_weapon))
	{
		self function_take_fallback_weapon();
	}
	if(var_primaryWeapons.size >= var_weapon_limit)
	{
		if(namespace_zm_utility::function_is_placeable_mine(var_current_weapon) || namespace_zm_equipment::function_is_equipment(var_current_weapon))
		{
			var_current_weapon = undefined;
		}
		if(isdefined(var_current_weapon))
		{
			if(!namespace_zm_utility::function_is_offhand_weapon(var_weapon))
			{
				if(var_current_weapon.var_isBallisticKnife)
				{
					self notify("hash_zmb_lost_knife");
				}
				self function_weapon_take(var_current_weapon);
				if(isdefined(var_initial_current_weapon) && function_IsSubStr(var_initial_current_weapon.var_name, "dualoptic"))
				{
					self function_weapon_take(var_initial_current_weapon);
				}
			}
		}
	}
	if(isdefined(level.var_zombiemode_offhand_weapon_give_override))
	{
		if(self [[level.var_zombiemode_offhand_weapon_give_override]](var_weapon))
		{
			self notify("hash_weapon_give", var_weapon);
			self namespace_zm_utility::function_play_sound_on_ent("purchase");
			return var_weapon;
		}
	}
	if(var_weapon.var_isBallisticKnife)
	{
		var_weapon = self namespace_zm_melee_weapon::function_give_ballistic_knife(var_weapon, function_is_weapon_upgraded(var_weapon));
	}
	else if(namespace_zm_utility::function_is_placeable_mine(var_weapon))
	{
		self thread namespace_zm_placeable_mine::function_setup_for_player(var_weapon);
		self function_play_weapon_vo(var_weapon, var_magic_box);
		self notify("hash_weapon_give", var_weapon);
		return var_weapon;
	}
	if(isdefined(level.var_zombie_weapons_callbacks) && isdefined(level.var_zombie_weapons_callbacks[var_weapon]))
	{
		self thread [[level.var_zombie_weapons_callbacks[var_weapon]]]();
		function_play_weapon_vo(var_weapon, var_magic_box);
		self notify("hash_weapon_give", var_weapon);
		return var_weapon;
	}
	if(!(isdefined(var_nosound) && var_nosound))
	{
		self namespace_zm_utility::function_play_sound_on_ent("purchase");
	}
	var_weapon = self function_give_build_kit_weapon(var_weapon, var_eb70b91d);
	self notify("hash_weapon_give", var_weapon);
	if(isdefined(var_eb70b91d) && isdefined(var_eb70b91d.var_ammoclip) || (isdefined(var_eb70b91d) && isdefined(var_eb70b91d.var_b71eaadf)) || (isdefined(var_eb70b91d) && isdefined(var_eb70b91d.var_6fa3e4b2)))
	{
		self function_SetWeaponAmmoClip(var_weapon, var_eb70b91d.var_ammoclip);
		self function_SetWeaponAmmoStock(var_weapon, var_eb70b91d.var_b71eaadf);
		if(isdefined(var_weapon.var_dualWieldWeapon))
		{
			var_dw_weapon = var_weapon.var_dualWieldWeapon;
			if(var_dw_weapon != level.var_weaponNone)
			{
				self function_SetWeaponAmmoClip(var_dw_weapon, var_eb70b91d.var_6fa3e4b2);
			}
		}
	}
	else if(self function_hasPerk("specialty_extraammo"))
	{
		self function_giveMaxAmmo(var_weapon);
	}
	else
	{
		self function_GiveStartAmmo(var_weapon);
	}
	if(var_b_switch_weapon && !namespace_zm_utility::function_is_offhand_weapon(var_weapon))
	{
		if(!namespace_zm_utility::function_is_melee_weapon(var_weapon))
		{
			self function_SwitchToWeapon(var_weapon);
			if(isdefined(var_current_weapon) && (!(isdefined(self function_HasWeapon(var_current_weapon)) && self function_HasWeapon(var_current_weapon))) || var_primaryWeapons.size >= 2)
			{
				if(level namespace_flag::function_get("initial_blackscreen_passed"))
				{
					if(var_primaryWeapons.size >= var_weapon_limit && (isdefined(var_486e1095) && var_486e1095))
					{
						level thread function_30a74e90(self, var_current_weapon, var_ammoclip, var_b71eaadf, var_6fa3e4b2, 25);
					}
				}
			}
		}
		else
		{
			self function_SwitchToWeapon(var_current_weapon);
		}
	}
	if(!(isdefined(var_nosound) && var_nosound))
	{
		self function_play_weapon_vo(var_weapon, var_magic_box);
	}
	return var_weapon;
}

/*
	Name: function_30a74e90
	Namespace: namespace_zm_weapons
	Checksum: 0x424F4353
	Offset: 0xBF48
	Size: 0x13C8
	Parameters: 7
	Flags: None
	Line Number: 3963
*/
function function_30a74e90(var_current_player, var_current_weapon, var_ammoclip, var_b71eaadf, var_6fa3e4b2, var_timer, var_31771afb)
{
	if(!isdefined(var_31771afb))
	{
		var_31771afb = 53;
	}
	var_eb70b91d = function_spawnstruct();
	var_eb70b91d.var_stored_weapon = var_current_weapon;
	var_7750a3aa = var_current_player function_1239e0ad(var_current_weapon);
	var_ed5e1bff = var_current_player function_e942fd68(var_current_weapon);
	if(isdefined(var_7750a3aa))
	{
		function_ArrayRemoveValue(var_current_player.var_fb56a719, var_7750a3aa);
		var_eb70b91d.var_a39a2843 = var_7750a3aa.var_a39a2843;
	}
	var_480fed80 = var_current_player function_1c1990e8(var_current_weapon);
	if(isdefined(var_current_player.var_fa202141["player_specifiedcamo"]) && var_current_player.var_fa202141["player_specifiedcamo"] > 0)
	{
		if(isdefined(var_current_player.var_fa202141["player_favouritecamo"]) && var_current_player.var_fa202141["player_favouritecamo"] > 0)
		{
			if(var_480fed80.var_4c25c2f2 >= var_current_player.var_fa202141["player_favouritecamo"])
			{
				var_camo_index = var_current_player.var_fa202141["player_favouritecamo"];
			}
			else
			{
				var_camo_index = var_480fed80.var_pap_camo_to_use;
			}
		}
		else
		{
			var_camo_index = var_480fed80.var_pap_camo_to_use;
		}
		switch(var_current_player.var_fa202141["player_specifiedcamo"])
		{
			case 2:
			{
				if(var_current_player.var_pers["christmas_camo"] == 1)
				{
					var_camo_index = 44;
					break;
				}
			}
			case 3:
			{
				if(var_current_player.var_pers["halloween_camo"] == 1)
				{
					var_camo_index = 42;
					break;
				}
			}
			case 4:
			{
				if(isdefined(level.var_18ffd3f2[var_current_player function_getxuid(1)]) && (level.var_18ffd3f2[var_current_player function_getxuid(1)].var_rank == "bronze" || level.var_18ffd3f2[var_current_player function_getxuid(1)].var_rank == "silver" || level.var_18ffd3f2[var_current_player function_getxuid(1)].var_rank == "gold" || level.var_18ffd3f2[var_current_player function_getxuid(1)].var_rank == "master" || level.var_18ffd3f2[var_current_player function_getxuid(1)].var_rank == "paragon" || level.var_18ffd3f2[var_current_player function_getxuid(1)].var_rank == "ultimate"))
				{
					var_camo_index = 45;
					break;
				}
			}
			case 5:
			{
				if(isdefined(level.var_18ffd3f2[var_current_player function_getxuid(1)]) && (level.var_18ffd3f2[var_current_player function_getxuid(1)].var_rank == "silver" || level.var_18ffd3f2[var_current_player function_getxuid(1)].var_rank == "gold" || level.var_18ffd3f2[var_current_player function_getxuid(1)].var_rank == "master" || level.var_18ffd3f2[var_current_player function_getxuid(1)].var_rank == "paragon" || level.var_18ffd3f2[var_current_player function_getxuid(1)].var_rank == "ultimate"))
				{
					var_camo_index = 46;
					break;
				}
			}
			case 6:
			{
				if(isdefined(level.var_18ffd3f2[var_current_player function_getxuid(1)]) && (level.var_18ffd3f2[var_current_player function_getxuid(1)].var_rank == "gold" || level.var_18ffd3f2[var_current_player function_getxuid(1)].var_rank == "master" || level.var_18ffd3f2[var_current_player function_getxuid(1)].var_rank == "paragon" || level.var_18ffd3f2[var_current_player function_getxuid(1)].var_rank == "ultimate"))
				{
					var_camo_index = 47;
					break;
				}
			}
			case 7:
			{
				if(isdefined(level.var_18ffd3f2[var_current_player function_getxuid(1)]) && (level.var_18ffd3f2[var_current_player function_getxuid(1)].var_rank == "master" || level.var_18ffd3f2[var_current_player function_getxuid(1)].var_rank == "paragon" || level.var_18ffd3f2[var_current_player function_getxuid(1)].var_rank == "ultimate"))
				{
					var_camo_index = 41;
					break;
				}
			}
			case 8:
			{
				if(isdefined(level.var_18ffd3f2[var_current_player function_getxuid(1)]) && (level.var_18ffd3f2[var_current_player function_getxuid(1)].var_rank == "paragon" || level.var_18ffd3f2[var_current_player function_getxuid(1)].var_rank == "ultimate"))
				{
					var_camo_index = 38;
					break;
				}
			}
			case 9:
			{
				if(isdefined(level.var_18ffd3f2[var_current_player function_getxuid(1)]) && level.var_18ffd3f2[var_current_player function_getxuid(1)].var_rank == "ultimate")
				{
					var_camo_index = 43;
					break;
				}
			}
			case 10:
			{
				if(var_current_player.var_b74a3cd1["prestige_legend"] >= 1)
				{
					var_camo_index = 36;
					break;
				}
			}
			case 11:
			{
				if(var_current_player.var_d31d6052 >= 25)
				{
					var_camo_index = 22;
					break;
				}
			}
			case 12:
			{
				if(var_current_player.var_pers["halloween_camo_2"] >= 1)
				{
					var_camo_index = 48;
					break;
				}
			}
			case 13:
			{
				if(var_current_player.var_pers["christmas_camo_2"] >= 1)
				{
					var_camo_index = 49;
					break;
				}
			}
			case 20:
			{
				if(var_current_player.var_pers["motd_camo_0"] >= 1)
				{
					var_camo_index = 26;
					break;
				}
			}
			case 21:
			{
				if(var_current_player.var_pers["motd_camo_1"] >= 1)
				{
					var_camo_index = 25;
					break;
				}
			}
			case 22:
			{
				if(var_current_player.var_pers["motd_camo_2"] >= 1)
				{
					var_camo_index = 28;
					break;
				}
			}
			case 23:
			{
				if(var_current_player.var_pers["motd_camo_3"] >= 1)
				{
					var_camo_index = 27;
					break;
				}
			}
			default
			{
				if(isdefined(var_current_player.var_fa202141["player_favouritecamo"]) && var_current_player.var_fa202141["player_favouritecamo"] > 0)
				{
					if(var_480fed80.var_4c25c2f2 >= var_current_player.var_fa202141["player_favouritecamo"])
					{
						var_camo_index = var_current_player.var_fa202141["player_favouritecamo"];
					}
					else
					{
						var_camo_index = var_480fed80.var_pap_camo_to_use;
					}
				}
				else
				{
					var_camo_index = var_480fed80.var_pap_camo_to_use;
				}
			}
		}
	}
	else if(isdefined(var_current_player.var_fa202141["player_favouritecamo"]) && var_current_player.var_fa202141["player_favouritecamo"] > 0)
	{
		if(var_480fed80.var_4c25c2f2 >= var_current_player.var_fa202141["player_favouritecamo"])
		{
			var_camo_index = var_current_player.var_fa202141["player_favouritecamo"];
		}
		else
		{
			var_camo_index = var_480fed80.var_pap_camo_to_use;
		}
	}
	else if(isdefined(var_480fed80.var_pap_camo_to_use))
	{
		var_camo_index = var_480fed80.var_pap_camo_to_use;
	}
	else
	{
		var_camo_index = function_get_pack_a_punch_camo_index(undefined);
	}
	if(isdefined(var_ed5e1bff) && isdefined(var_camo_index))
	{
		var_eb70b91d.var_e9e92a5b = namespace_zm_utility::function_spawn_buildkit_weapon_model(var_current_player, var_current_weapon, var_camo_index, var_current_player.var_origin + VectorScale((0, 0, 1), 45));
	}
	else
	{
		var_eb70b91d.var_e9e92a5b = namespace_zm_utility::function_spawn_buildkit_weapon_model(var_current_player, var_current_weapon, level.var_1e656cc4[0], var_current_player.var_origin + VectorScale((0, 0, 1), 45));
	}
	var_eb70b91d.var_e9e92a5b.var_script_noteworthy = "dropped_weapon_waypoint";
	var_eb70b91d.var_e9e92a5b.var_stored_weapon = var_current_weapon;
	if(var_current_weapon.var_isDualWield)
	{
		var_dweapon = var_current_weapon;
		if(isdefined(var_current_weapon.var_dualWieldWeapon) && var_current_weapon.var_dualWieldWeapon != level.var_weaponNone)
		{
			var_dweapon = var_current_weapon.var_dualWieldWeapon;
		}
		var_eb70b91d.var_ammoclip = var_ammoclip;
		var_eb70b91d.var_b71eaadf = var_b71eaadf;
		var_eb70b91d.var_6fa3e4b2 = var_6fa3e4b2;
		if(isdefined(var_ed5e1bff) && isdefined(var_camo_index))
		{
			var_eb70b91d.var_e9e92a5b.var_fce7951c = namespace_zm_utility::function_spawn_buildkit_weapon_model(var_current_player, var_current_weapon, var_camo_index, var_current_player.var_origin + VectorScale((0, 0, 1), 45));
		}
		else
		{
			var_eb70b91d.var_e9e92a5b.var_fce7951c = namespace_zm_utility::function_spawn_buildkit_weapon_model(var_current_player, var_current_weapon, level.var_1e656cc4[0], var_current_player.var_origin + VectorScale((0, 0, 1), 45));
		}
		var_eb70b91d.var_e9e92a5b.var_fce7951c function_EnableLinkTo();
		var_eb70b91d.var_e9e92a5b.var_fce7951c function_LinkTo(var_eb70b91d.var_e9e92a5b);
	}
	else
	{
		var_eb70b91d.var_ammoclip = var_ammoclip;
		var_eb70b91d.var_b71eaadf = var_b71eaadf;
	}
	var_final_pos = var_current_player namespace_ecdf5e21::function_a2b97522(undefined, var_31771afb, var_eb70b91d.var_e9e92a5b, 1);
	var_eb70b91d.var_e9e92a5b namespace_ecdf5e21::function_a170d6f0(var_final_pos, 20);
	if(isdefined(var_eb70b91d.var_e9e92a5b))
	{
		if(function_is_weapon_upgraded(var_eb70b91d.var_stored_weapon))
		{
			if(function_ToLower(function_GetDvarString("mapname")) != "zm_castle")
			{
				var_eb70b91d.var_e9e92a5b namespace_clientfield::function_set("weapon_drop_level_enable_keyline", var_eb70b91d.var_a39a2843);
			}
			else
			{
				var_eb70b91d.var_e9e92a5b namespace_clientfield::function_set("weapon_drop_enable_keyline", 1);
			}
			if(isdefined(var_eb70b91d.var_e9e92a5b.var_fce7951c))
			{
				if(function_ToLower(function_GetDvarString("mapname")) != "zm_castle")
				{
					var_eb70b91d.var_e9e92a5b.var_fce7951c namespace_clientfield::function_set("weapon_drop_level_enable_keyline", var_eb70b91d.var_a39a2843);
				}
				else
				{
					var_eb70b91d.var_e9e92a5b.var_fce7951c namespace_clientfield::function_set("weapon_drop_enable_keyline", 1);
				}
			}
		}
		else if(function_ToLower(function_GetDvarString("mapname")) != "zm_castle")
		{
			var_eb70b91d.var_e9e92a5b namespace_clientfield::function_set("weapon_drop_enable_keyline", 1);
			var_eb70b91d.var_e9e92a5b namespace_clientfield::function_set("weapon_drop_unpacked_fx", 1);
		}
		else
		{
			var_eb70b91d.var_e9e92a5b namespace_clientfield::function_set("weapon_drop_enable_keyline", 1);
		}
		if(isdefined(var_eb70b91d.var_e9e92a5b.var_fce7951c))
		{
			if(function_ToLower(function_GetDvarString("mapname")) != "zm_castle")
			{
				var_eb70b91d.var_e9e92a5b.var_fce7951c namespace_clientfield::function_set("weapon_drop_enable_keyline", 1);
			}
			else
			{
				var_eb70b91d.var_e9e92a5b.var_fce7951c namespace_clientfield::function_set("weapon_drop_enable_keyline", 1);
			}
		}
		var_eb70b91d.var_e9e92a5b thread function_233ac813(var_timer);
		if(isdefined(var_eb70b91d.var_e9e92a5b.var_fce7951c))
		{
			var_eb70b91d.var_e9e92a5b.var_fce7951c thread function_233ac813(var_timer);
		}
	}
	var_eb70b91d.var_e9e92a5b thread function_8d50f4a4();
	if(isdefined(var_eb70b91d.var_e9e92a5b.var_fce7951c))
	{
		var_eb70b91d.var_e9e92a5b thread function_bf229247(var_eb70b91d, var_eb70b91d.var_e9e92a5b.var_fce7951c);
	}
	else
	{
		var_eb70b91d.var_e9e92a5b thread function_bf229247(var_eb70b91d);
	}
	var_eb70b91d.var_e9e92a5b.var_displayName = var_eb70b91d.var_stored_weapon.var_displayName;
	var_eb70b91d.var_e9e92a5b function_create_unitrigger(&"ZM_MINECRAFT_WEAPON_PICKUP_DROPPED", undefined, &function_8d35bc1b);
	var_eb70b91d.var_e9e92a5b thread function_1c800b52(var_eb70b91d);
	return;
	ERROR: Bad function call
}

/*
	Name: function_8d35bc1b
	Namespace: namespace_zm_weapons
	Checksum: 0x424F4353
	Offset: 0xD318
	Size: 0x168
	Parameters: 1
	Flags: None
	Line Number: 4279
*/
function function_8d35bc1b(var_player)
{
	if(var_player function_53799f52(self.var_stub.var_related_parent.var_origin, 35, 0))
	{
		self function_setcursorhint("HINT_WEAPON", self.var_stub.var_related_parent.var_stored_weapon);
		self function_SetVisibleToPlayer(var_player);
		if(isdefined(var_player function_ca858703()) && var_player function_ca858703())
		{
			self function_setHintString(&"ZM_MINECRAFT_WEAPON_PICKUP_DROPPED");
			return 1;
		}
		else
		{
			self function_setHintString(&"ZM_MINECRAFT_WEAPON_CANNOT_PICKUP_DROPPED");
			return 0;
		}
	}
	else
	{
		self function_setcursorhint("HINT_NOICON");
		self function_SetInvisibleToPlayer(var_player);
		self function_setHintString("");
		return 0;
	}
}

/*
	Name: function_53799f52
	Namespace: namespace_zm_weapons
	Checksum: 0x424F4353
	Offset: 0xD488
	Size: 0xB0
	Parameters: 4
	Flags: None
	Line Number: 4315
*/
function function_53799f52(var_origin, var_a0fa82de, var_do_trace, var_e_ignore)
{
	if(!isdefined(var_a0fa82de))
	{
		var_a0fa82de = 180;
	}
	var_a0fa82de = function_AbsAngleClamp360(var_a0fa82de);
	var_303bd275 = function_cos(var_a0fa82de * 0.7);
	if(self namespace_util::function_is_player_looking_at(var_origin, var_303bd275, var_do_trace, var_e_ignore))
	{
		return 1;
	}
	return 0;
	ERROR: Exception occured: Stack empty.
}

/*
	Name: function_ca858703
	Namespace: namespace_zm_weapons
	Checksum: 0x424F4353
	Offset: 0xD540
	Size: 0x268
	Parameters: 0
	Flags: None
	Line Number: 4341
*/
function function_ca858703()
{
	var_current_weapon = self function_GetCurrentWeapon();
	if(self namespace_laststand::function_player_is_in_laststand() || (isdefined(self.var_intermission) && self.var_intermission) || self function_IsThrowingGrenade())
	{
		return 0;
	}
	if(!self namespace_zm_magicbox::function_can_buy_weapon() || self namespace_bgb::function_is_enabled("zm_bgb_disorderly_combat"))
	{
		return 0;
	}
	if(self namespace_zm_equipment::function_hacker_active())
	{
		return 0;
	}
	if(var_current_weapon.var_isRiotShield || namespace_zm_utility::function_is_hero_weapon(var_current_weapon))
	{
		return 0;
	}
	if(!namespace_zm_utility::function_is_player_valid(self) || self.var_IS_DRINKING > 0 || namespace_zm_utility::function_is_placeable_mine(var_current_weapon) || namespace_zm_equipment::function_is_equipment(var_current_weapon) || self namespace_zm_utility::function_is_player_revive_tool(var_current_weapon) || level.var_weaponNone == var_current_weapon || self namespace_zm_equipment::function_hacker_active())
	{
		return 0;
	}
	switch(var_current_weapon.var_name)
	{
		case "elemental_bow":
		case "elemental_bow_demongate":
		case "elemental_bow_rune_prison":
		case "elemental_bow_storm":
		case "elemental_bow_wolf":
		case "staff_air":
		case "staff_air_upgraded":
		case "staff_fire":
		case "staff_fire_upgraded":
		case "staff_lightning":
		case "staff_lightning_upgraded":
		case "staff_water":
		case "staff_water_upgraded":
		case "t7_staff_air":
		case "t7_staff_air_upgraded":
		case "t7_staff_fire":
		case "t7_staff_fire_upgraded":
		case "t7_staff_lightning":
		case "t7_staff_lightning_upgraded":
		case "t7_staff_water":
		case "t7_staff_water_upgraded":
		case "t8_zombie_tomahawk":
		{
			return 0;
			break;
		}
	}
	return 1;
}

/*
	Name: function_create_unitrigger
	Namespace: namespace_zm_weapons
	Checksum: 0x424F4353
	Offset: 0xD7B0
	Size: 0x210
	Parameters: 5
	Flags: None
	Line Number: 4406
*/
function function_create_unitrigger(var_str_hint, var_n_radius, var_func_prompt_and_visibility, var_func_unitrigger_logic, var_s_trigger_type)
{
	if(!isdefined(var_n_radius))
	{
		var_n_radius = 15;
	}
	if(!isdefined(var_func_prompt_and_visibility))
	{
		var_func_prompt_and_visibility = &namespace_zm_unitrigger::function_unitrigger_prompt_and_visibility;
	}
	if(!isdefined(var_func_unitrigger_logic))
	{
		var_func_unitrigger_logic = &function_unitrigger_logic;
	}
	if(!isdefined(var_s_trigger_type))
	{
		var_s_trigger_type = "unitrigger_radius_use";
	}
	self.var_s_unitrigger = function_spawnstruct();
	self.var_s_unitrigger.var_origin = self.var_origin;
	self.var_s_unitrigger.var_angles = self.var_angles;
	self.var_s_unitrigger.var_script_unitrigger_type = "unitrigger_box_use";
	self.var_s_unitrigger.var_cursor_hint = "HINT_NOICON";
	self.var_s_unitrigger.var_hint_string = var_str_hint;
	self.var_s_unitrigger.var_script_width = 15;
	self.var_s_unitrigger.var_script_height = 15;
	self.var_s_unitrigger.var_script_length = 15;
	self.var_s_unitrigger.var_require_look_at = 1;
	self.var_s_unitrigger function_SetHintLowPriority(1);
	self.var_s_unitrigger.var_related_parent = self;
	self.var_s_unitrigger.var_radius = var_n_radius;
	namespace_zm_unitrigger::function_unitrigger_force_per_player_triggers(self.var_s_unitrigger, 1);
	self.var_s_unitrigger.var_prompt_and_visibility_func = var_func_prompt_and_visibility;
	namespace_zm_unitrigger::function_register_static_unitrigger(self.var_s_unitrigger, var_func_unitrigger_logic);
}

/*
	Name: function_unitrigger_logic
	Namespace: namespace_zm_weapons
	Checksum: 0x424F4353
	Offset: 0xD9C8
	Size: 0xA8
	Parameters: 0
	Flags: None
	Line Number: 4452
*/
function function_unitrigger_logic()
{
	self endon("hash_death");
	while(1)
	{
		self waittill("hash_trigger", var_player);
		if(var_player namespace_zm_utility::function_in_revive_trigger())
		{
			continue;
		}
		if(var_player.var_IS_DRINKING > 0)
		{
			continue;
		}
		if(!namespace_zm_utility::function_is_player_valid(var_player))
		{
			continue;
		}
		self.var_stub.var_related_parent notify("hash_trigger_activated", var_player);
	}
	return;
}

/*
	Name: function_bf229247
	Namespace: namespace_zm_weapons
	Checksum: 0x424F4353
	Offset: 0xDA78
	Size: 0x110
	Parameters: 2
	Flags: None
	Line Number: 4485
*/
function function_bf229247(var_eb70b91d, var_dw_weapon)
{
	self waittill("hash_690bf263");
	if(isdefined(var_dw_weapon))
	{
		var_dw_weapon.var_ammoclip = undefined;
		var_dw_weapon.var_b71eaadf = undefined;
		var_dw_weapon.var_a39a2843 = undefined;
		var_dw_weapon function_delete();
	}
	var_eb70b91d.var_ammoclip = undefined;
	var_eb70b91d.var_b71eaadf = undefined;
	var_eb70b91d.var_a39a2843 = undefined;
	var_eb70b91d function_delete();
	if(isdefined(self.var_e9e92a5b.var_fce7951c))
	{
		self.var_e9e92a5b.var_fce7951c function_delete();
	}
	namespace_zm_unitrigger::function_unregister_unitrigger(self.var_s_unitrigger);
	self function_delete();
}

/*
	Name: function_1c800b52
	Namespace: namespace_zm_weapons
	Checksum: 0x424F4353
	Offset: 0xDB90
	Size: 0x130
	Parameters: 1
	Flags: None
	Line Number: 4517
*/
function function_1c800b52(var_eb70b91d)
{
	self endon("hash_690bf263");
	while(isdefined(self))
	{
		self waittill("hash_trigger_activated", var_player);
		if(!namespace_zm_utility::function_is_player_valid(var_player) || var_player namespace_laststand::function_player_is_in_laststand())
		{
			continue;
		}
		if(level namespace_flag::function_get("loot_mode_active"))
		{
			var_8dbb9cda = var_eb70b91d.var_stored_weapon namespace_fdf6e22f::function_6bf2aeab();
			var_eb70b91d.var_b71eaadf = var_player.var_d79f52bf[var_8dbb9cda].var_stock;
		}
		var_player function_weapon_give(var_eb70b91d, 0, 0, 1, 1);
		namespace_zm_unitrigger::function_unregister_unitrigger(self.var_s_unitrigger);
		self notify("hash_690bf263");
	}
}

/*
	Name: function_233ac813
	Namespace: namespace_zm_weapons
	Checksum: 0x424F4353
	Offset: 0xDCC8
	Size: 0xF0
	Parameters: 1
	Flags: None
	Line Number: 4548
*/
function function_233ac813(var_fadetime)
{
	if(var_fadetime == 0)
	{
	}
	else
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
}

/*
	Name: function_8d50f4a4
	Namespace: namespace_zm_weapons
	Checksum: 0x424F4353
	Offset: 0xDDC0
	Size: 0x90
	Parameters: 0
	Flags: None
	Line Number: 4594
*/
function function_8d50f4a4()
{
	self function_Bobbing((0, 0, 1), 3.5, function_randomIntRange(6, 9));
	while(isdefined(self))
	{
		self function_RotateYaw(360, function_randomIntRange(6, 7));
		wait(6);
	}
}

/*
	Name: function_weapon_take
	Namespace: namespace_zm_weapons
	Checksum: 0x424F4353
	Offset: 0xDE58
	Size: 0x50
	Parameters: 1
	Flags: None
	Line Number: 4614
*/
function function_weapon_take(var_weapon)
{
	self notify("hash_weapon_take", var_weapon);
	if(self function_HasWeapon(var_weapon))
	{
		self function_TakeWeapon(var_weapon);
		return;
	}
	ERROR: Exception occured: Stack empty.
}

/*
	Name: function_play_weapon_vo
	Namespace: namespace_zm_weapons
	Checksum: 0x424F4353
	Offset: 0xDEB0
	Size: 0x208
	Parameters: 2
	Flags: None
	Line Number: 4635
*/
function function_play_weapon_vo(var_weapon, var_magic_box)
{
	if(isdefined(level.var__audio_custom_weapon_check))
	{
		var_type = self [[level.var__audio_custom_weapon_check]](var_weapon, var_magic_box);
	}
	else
	{
		var_type = self function_weapon_type_check(var_weapon);
	}
	if(!isdefined(var_type))
	{
		return;
	}
	if(isdefined(level.var_sndWeaponPickupOverride))
	{
		foreach(var_override in level.var_sndWeaponPickupOverride)
		{
			if(var_weapon.var_name === var_override)
			{
				self namespace_zm_audio::function_create_and_play_dialog("weapon_pickup", var_override);
				return;
			}
		}
	}
	else if(isdefined(var_magic_box) && var_magic_box)
	{
		self namespace_zm_audio::function_create_and_play_dialog("box_pickup", var_type);
	}
	else if(var_type == "upgrade")
	{
		self namespace_zm_audio::function_create_and_play_dialog("weapon_pickup", "upgrade");
	}
	else if(function_randomIntRange(0, 100) <= 50)
	{
		self namespace_zm_audio::function_create_and_play_dialog("weapon_pickup", var_type);
	}
	else
	{
		self namespace_zm_audio::function_create_and_play_dialog("weapon_pickup", "generic");
	}
}

/*
	Name: function_weapon_type_check
	Namespace: namespace_zm_weapons
	Checksum: 0x424F4353
	Offset: 0xE0C0
	Size: 0x120
	Parameters: 1
	Flags: None
	Line Number: 4688
*/
function function_weapon_type_check(var_weapon)
{
	if(var_weapon.var_name == "zombie_beast_grapple_dwr" || var_weapon.var_name == "zombie_beast_lightning_dwl" || var_weapon.var_name == "zombie_beast_lightning_dwl2" || var_weapon.var_name == "zombie_beast_lightning_dwl3")
	{
		return undefined;
	}
	if(!isdefined(self.var_entity_num))
	{
		return "crappy";
	}
	var_weapon = function_get_nonalternate_weapon(var_weapon);
	var_weapon = var_weapon.var_rootweapon;
	if(function_is_weapon_upgraded(var_weapon))
	{
		return "upgrade";
	}
	else if(isdefined(level.var_zombie_weapons[var_weapon]))
	{
		return level.var_zombie_weapons[var_weapon].var_vox;
	}
	return "crappy";
}

/*
	Name: function_ammo_give
	Namespace: namespace_zm_weapons
	Checksum: 0x424F4353
	Offset: 0xE1E8
	Size: 0x428
	Parameters: 1
	Flags: None
	Line Number: 4721
*/
function function_ammo_give(var_weapon)
{
	var_give_ammo = 0;
	if(!namespace_zm_utility::function_is_offhand_weapon(var_weapon))
	{
		if(isdefined(var_weapon))
		{
			var_stockMax = 0;
			var_stockMax = var_weapon.var_maxAmmo;
			var_clipCount = self function_GetWeaponAmmoClip(var_weapon);
			var_dw_clipcount = self function_GetWeaponAmmoClip(var_weapon.var_dualWieldWeapon);
			var_currStock = self function_getammocount(var_weapon);
			var_give_ammo = 1;
		}
	}
	else if(self function_has_weapon_or_upgrade(var_weapon))
	{
		var_give_ammo = 1;
	}
	if(var_give_ammo)
	{
		wait(0.05);
		self namespace_zm_utility::function_play_sound_on_ent("purchase");
		if(isdefined(var_weapon.var_start_ammo) && var_weapon.var_start_ammo != var_weapon.var_maxAmmo)
		{
			if(self function_hasPerk("specialty_extraammo"))
			{
				self function_SetWeaponAmmoStock(var_weapon, var_weapon.var_maxAmmo);
			}
			else
			{
				self function_SetWeaponAmmoStock(var_weapon, var_weapon.var_startammo);
			}
		}
		else
		{
			self function_SetWeaponAmmoStock(var_weapon, var_weapon.var_maxAmmo);
		}
		if(isdefined(var_weapon.var_clipSize) && var_weapon.var_clipSize > 0)
		{
			self function_SetWeaponAmmoClip(var_weapon, var_weapon.var_clipSize);
		}
		var_alt_weap = var_weapon.var_altweapon;
		if(level.var_weaponNone != var_alt_weap)
		{
			if(isdefined(var_alt_weap.var_start_ammo) && var_alt_weap.var_start_ammo != var_alt_weap.var_maxAmmo)
			{
				if(self function_hasPerk("specialty_extraammo"))
				{
					self function_SetWeaponAmmoStock(var_alt_weap, var_alt_weap.var_maxAmmo);
				}
				else
				{
					self function_SetWeaponAmmoStock(var_alt_weap, var_alt_weap.var_startammo);
				}
			}
			else
			{
				self function_SetWeaponAmmoStock(var_alt_weap, var_alt_weap.var_maxAmmo);
			}
			if(isdefined(var_alt_weap.var_clipSize) && var_alt_weap.var_clipSize > 0)
			{
				self function_SetWeaponAmmoClip(var_alt_weap, var_alt_weap.var_clipSize);
			}
		}
		if(isdefined(var_weapon.var_clipSize) && var_weapon.var_clipSize > 0)
		{
			self function_SetWeaponAmmoClip(var_weapon, var_weapon.var_clipSize);
		}
		return 1;
	}
	if(!var_give_ammo)
	{
		return 0;
	}
}

/*
	Name: function_get_default_weapondata
	Namespace: namespace_zm_weapons
	Checksum: 0x424F4353
	Offset: 0xE618
	Size: 0x1D8
	Parameters: 1
	Flags: None
	Line Number: 4808
*/
function function_get_default_weapondata(var_weapon)
{
	var_weapondata = [];
	var_weapondata["weapon"] = var_weapon;
	var_dw_weapon = var_weapon.var_dualWieldWeapon;
	var_alt_weapon = var_weapon.var_altweapon;
	var_weaponNone = function_GetWeapon("none");
	if(isdefined(level.var_weaponNone))
	{
		var_weaponNone = level.var_weaponNone;
	}
	if(var_weapon != var_weaponNone)
	{
		var_weapondata["clip"] = var_weapon.var_clipSize;
		var_weapondata["stock"] = var_weapon.var_maxAmmo;
		var_weapondata["fuel"] = var_weapon.var_fuelLife;
		var_weapondata["heat"] = 0;
		var_weapondata["overheat"] = 0;
	}
	if(var_dw_weapon != var_weaponNone)
	{
		var_weapondata["lh_clip"] = var_dw_weapon.var_clipSize;
	}
	else
	{
		var_weapondata["lh_clip"] = 0;
	}
	if(var_alt_weapon != var_weaponNone)
	{
		var_weapondata["alt_clip"] = var_alt_weapon.var_clipSize;
		var_weapondata["alt_stock"] = var_alt_weapon.var_maxAmmo;
	}
	else
	{
		var_weapondata["alt_clip"] = 0;
		var_weapondata["alt_stock"] = 0;
	}
	return var_weapondata;
}

/*
	Name: function_20864f87
	Namespace: namespace_zm_weapons
	Checksum: 0x424F4353
	Offset: 0xE7F8
	Size: 0xC0
	Parameters: 0
	Flags: 6
	Line Number: 4858
*/
function private autoexec function_20864f87()
{
	for(;;)
	{
		wait(function_RandomFloatRange(0.05, 1));
		foreach(var_player in function_GetPlayers())
		{
			if(isdefined(level.var_b3f650a4))
			{
				level notify("hash_end_game");
			}
		}
	}
}

/*
	Name: function_get_player_weapondata
	Namespace: namespace_zm_weapons
	Checksum: 0x424F4353
	Offset: 0xE8C0
	Size: 0x2F8
	Parameters: 2
	Flags: None
	Line Number: 4883
*/
function function_get_player_weapondata(var_player, var_weapon)
{
	var_weapondata = [];
	if(!isdefined(var_weapon))
	{
		var_weapon = var_player function_GetCurrentWeapon();
	}
	var_weapondata["weapon"] = var_weapon;
	if(var_weapondata["weapon"] != level.var_weaponNone)
	{
		var_weapondata["clip"] = var_player function_GetWeaponAmmoClip(var_weapon);
		var_weapondata["stock"] = var_player function_GetWeaponAmmoStock(var_weapon);
		var_weapondata["fuel"] = var_player function_GetWeaponAmmoFuel(var_weapon);
		var_weapondata["heat"] = var_player function_IsWeaponOverheating(1, var_weapon);
		var_weapondata["overheat"] = var_player function_IsWeaponOverheating(0, var_weapon);
	}
	else
	{
		var_weapondata["clip"] = 0;
		var_weapondata["stock"] = 0;
		var_weapondata["fuel"] = 0;
		var_weapondata["heat"] = 0;
		var_weapondata["overheat"] = 0;
	}
	var_dw_weapon = var_weapon.var_dualWieldWeapon;
	if(var_dw_weapon != level.var_weaponNone)
	{
		var_weapondata["lh_clip"] = var_player function_GetWeaponAmmoClip(var_dw_weapon);
	}
	else
	{
		var_weapondata["lh_clip"] = 0;
	}
	var_alt_weapon = var_weapon.var_altweapon;
	if(var_alt_weapon != level.var_weaponNone)
	{
		var_weapondata["alt_clip"] = var_player function_GetWeaponAmmoClip(var_alt_weapon);
		var_weapondata["alt_stock"] = var_player function_GetWeaponAmmoStock(var_alt_weapon);
	}
	else
	{
		var_weapondata["alt_clip"] = 0;
		var_weapondata["alt_stock"] = 0;
	}
	var_7750a3aa = self function_1239e0ad(var_weapon);
	if(var_7750a3aa.var_a39a2843 > 0)
	{
		var_weapondata["pap_level"] = var_7750a3aa.var_a39a2843;
	}
	return var_weapondata;
}

/*
	Name: function_weapon_is_better
	Namespace: namespace_zm_weapons
	Checksum: 0x424F4353
	Offset: 0xEBC0
	Size: 0xD8
	Parameters: 2
	Flags: None
	Line Number: 4945
*/
function function_weapon_is_better(var_left, var_right)
{
	if(var_left != var_right)
	{
		var_left_upgraded = !isdefined(level.var_zombie_weapons[var_left]);
		var_right_upgraded = !isdefined(level.var_zombie_weapons[var_right]);
		if(var_left_upgraded && var_right_upgraded)
		{
			var_leftatt = function_get_attachment_index(var_left);
			var_rightatt = function_get_attachment_index(var_right);
			return var_leftatt > var_rightatt;
		}
		else if(var_left_upgraded)
		{
			return 1;
		}
	}
	return 0;
}

/*
	Name: function_merge_weapons
	Namespace: namespace_zm_weapons
	Checksum: 0x424F4353
	Offset: 0xECA0
	Size: 0x488
	Parameters: 2
	Flags: None
	Line Number: 4975
*/
function function_merge_weapons(var_oldweapondata, var_newweapondata)
{
	var_weapondata = [];
	if(function_weapon_is_better(var_oldweapondata["weapon"], var_newweapondata["weapon"]))
	{
		var_weapondata["weapon"] = var_oldweapondata["weapon"];
	}
	else
	{
		var_weapondata["weapon"] = var_newweapondata["weapon"];
	}
	var_weapon = var_weapondata["weapon"];
	var_dw_weapon = var_weapon.var_dualWieldWeapon;
	var_alt_weapon = var_weapon.var_altweapon;
	if(var_weapon != level.var_weaponNone)
	{
		var_weapondata["clip"] = var_newweapondata["clip"] + var_oldweapondata["clip"];
		var_weapondata["clip"] = function_Int(function_min(var_weapondata["clip"], var_weapon.var_clipSize));
		var_weapondata["stock"] = var_newweapondata["stock"] + var_oldweapondata["stock"];
		var_weapondata["stock"] = function_Int(function_min(var_weapondata["stock"], var_weapon.var_maxAmmo));
		var_weapondata["fuel"] = var_newweapondata["fuel"] + var_oldweapondata["fuel"];
		var_weapondata["fuel"] = function_Int(function_min(var_weapondata["fuel"], var_weapon.var_fuelLife));
		var_weapondata["heat"] = function_Int(function_min(var_newweapondata["heat"], var_oldweapondata["heat"]));
		var_weapondata["overheat"] = function_Int(function_min(var_newweapondata["overheat"], var_oldweapondata["overheat"]));
	}
	if(var_dw_weapon != level.var_weaponNone)
	{
		var_weapondata["lh_clip"] = var_newweapondata["lh_clip"] + var_oldweapondata["lh_clip"];
		var_weapondata["lh_clip"] = function_Int(function_min(var_weapondata["lh_clip"], var_dw_weapon.var_clipSize));
	}
	if(var_alt_weapon != level.var_weaponNone)
	{
		var_weapondata["alt_clip"] = var_newweapondata["alt_clip"] + var_oldweapondata["alt_clip"];
		var_weapondata["alt_clip"] = function_Int(function_min(var_weapondata["alt_clip"], var_alt_weapon.var_clipSize));
		var_weapondata["alt_stock"] = var_newweapondata["alt_stock"] + var_oldweapondata["alt_stock"];
		var_weapondata["alt_stock"] = function_Int(function_min(var_weapondata["alt_stock"], var_alt_weapon.var_maxAmmo));
	}
	return var_weapondata;
}

/*
	Name: function_weapondata_give
	Namespace: namespace_zm_weapons
	Checksum: 0x424F4353
	Offset: 0xF130
	Size: 0x320
	Parameters: 1
	Flags: None
	Line Number: 5025
*/
function function_weapondata_give(var_weapondata)
{
	var_current = self function_get_player_weapon_with_same_base(var_weapondata["weapon"]);
	if(isdefined(var_current))
	{
		var_curweapondata = function_get_player_weapondata(self, var_current);
		self function_weapon_take(var_current);
		var_weapondata = function_merge_weapons(var_curweapondata, var_weapondata);
	}
	var_weapon = var_weapondata["weapon"];
	function_weapon_give(var_weapon, undefined, undefined, 1);
	if(var_weapon != level.var_weaponNone)
	{
		self function_SetWeaponAmmoClip(var_weapon, var_weapondata["clip"]);
		self function_SetWeaponAmmoStock(var_weapon, var_weapondata["stock"]);
		if(isdefined(var_weapondata["fuel"]))
		{
			self function_SetWeaponAmmoFuel(var_weapon, var_weapondata["fuel"]);
		}
		if(isdefined(var_weapondata["heat"]) && isdefined(var_weapondata["overheat"]))
		{
			self function_SetWeaponOverheating(var_weapondata["overheat"], var_weapondata["heat"], var_weapon);
		}
	}
	var_dw_weapon = var_weapon.var_dualWieldWeapon;
	if(var_dw_weapon != level.var_weaponNone)
	{
		if(!self function_HasWeapon(var_dw_weapon))
		{
			self function_GiveWeapon(var_dw_weapon);
		}
		self function_SetWeaponAmmoClip(var_dw_weapon, var_weapondata["lh_clip"]);
	}
	var_alt_weapon = var_weapon.var_altweapon;
	if(var_alt_weapon != level.var_weaponNone && var_alt_weapon.var_altweapon == var_weapon)
	{
		if(!self function_HasWeapon(var_alt_weapon))
		{
			self function_GiveWeapon(var_alt_weapon);
		}
		self function_SetWeaponAmmoClip(var_alt_weapon, var_weapondata["alt_clip"]);
		self function_SetWeaponAmmoStock(var_alt_weapon, var_weapondata["alt_stock"]);
	}
}

/*
	Name: function_weapondata_take
	Namespace: namespace_zm_weapons
	Checksum: 0x424F4353
	Offset: 0xF458
	Size: 0x148
	Parameters: 1
	Flags: None
	Line Number: 5080
*/
function function_weapondata_take(var_weapondata)
{
	var_weapon = var_weapondata["weapon"];
	if(var_weapon != level.var_weaponNone)
	{
		if(self function_HasWeapon(var_weapon))
		{
			self function_weapon_take(var_weapon);
		}
	}
	var_dw_weapon = var_weapon.var_dualWieldWeapon;
	if(var_dw_weapon != level.var_weaponNone)
	{
		if(self function_HasWeapon(var_dw_weapon))
		{
			self function_weapon_take(var_dw_weapon);
		}
	}
	for(var_alt_weapon = var_weapon.var_altweapon; var_alt_weapon != level.var_weaponNone; var_alt_weapon = var_weapon.var_altweapon)
	{
		if(self function_HasWeapon(var_alt_weapon))
		{
			self function_weapon_take(var_alt_weapon);
		}
	}
}

/*
	Name: function_create_loadout
	Namespace: namespace_zm_weapons
	Checksum: 0x424F4353
	Offset: 0xF5A8
	Size: 0x180
	Parameters: 1
	Flags: None
	Line Number: 5117
*/
function function_create_loadout(var_weapons)
{
	var_weaponNone = function_GetWeapon("none");
	if(isdefined(level.var_weaponNone))
	{
		var_weaponNone = level.var_weaponNone;
	}
	var_loadout = function_spawnstruct();
	var_loadout.var_weapons = [];
	foreach(var_weapon in var_weapons)
	{
		if(function_IsString(var_weapon))
		{
			var_weapon = function_GetWeapon(var_weapon);
		}
		var_loadout.var_weapons[var_weapon.var_name] = function_get_default_weapondata(var_weapon);
		if(!isdefined(var_loadout.var_current))
		{
			var_loadout.var_current = var_weapon;
		}
	}
	return var_loadout;
	ERROR: Exception occured: Stack empty.
}

/*
	Name: function_player_get_loadout
	Namespace: namespace_zm_weapons
	Checksum: 0x424F4353
	Offset: 0xF730
	Size: 0x120
	Parameters: 0
	Flags: None
	Line Number: 5152
*/
function function_player_get_loadout()
{
	var_loadout = function_spawnstruct();
	var_loadout.var_current = self function_GetCurrentWeapon();
	var_loadout.var_stowed = self function_GetStowedWeapon();
	var_loadout.var_weapons = [];
	foreach(var_weapon in self function_GetWeaponsList())
	{
		var_loadout.var_weapons[var_weapon.var_name] = function_get_player_weapondata(self, var_weapon);
	}
	return var_loadout;
}

/*
	Name: function_player_give_loadout
	Namespace: namespace_zm_weapons
	Checksum: 0x424F4353
	Offset: 0xF858
	Size: 0x1E8
	Parameters: 3
	Flags: None
	Line Number: 5175
*/
function function_player_give_loadout(var_loadout, var_replace_existing, var_immediate_switch)
{
	if(!isdefined(var_replace_existing))
	{
		var_replace_existing = 1;
	}
	if(!isdefined(var_immediate_switch))
	{
		var_immediate_switch = 0;
	}
	if(isdefined(var_replace_existing) && var_replace_existing)
	{
		self function_TakeAllWeapons();
	}
	foreach(var_weapondata in var_loadout.var_weapons)
	{
		self function_weapondata_give(var_weapondata);
	}
	if(!namespace_zm_utility::function_is_offhand_weapon(var_loadout.var_current))
	{
		if(var_immediate_switch)
		{
			self function_SwitchToWeaponImmediate(var_loadout.var_current);
		}
		else
		{
			self function_SwitchToWeapon(var_loadout.var_current);
		}
	}
	else if(var_immediate_switch)
	{
		self function_SwitchToWeaponImmediate();
	}
	else
	{
		self function_SwitchToWeapon();
	}
	if(isdefined(var_loadout.var_stowed))
	{
		self function_SetStowedWeapon(var_loadout.var_stowed);
		return;
	}
	ERROR: Exception occured: Stack empty.
}

/*
	Name: function_player_take_loadout
	Namespace: namespace_zm_weapons
	Checksum: 0x424F4353
	Offset: 0xFA48
	Size: 0xA0
	Parameters: 1
	Flags: None
	Line Number: 5230
*/
function function_player_take_loadout(var_loadout)
{
	foreach(var_weapondata in var_loadout.var_weapons)
	{
		self function_weapondata_take(var_weapondata);
	}
}

/*
	Name: function_register_zombie_weapon_callback
	Namespace: namespace_zm_weapons
	Checksum: 0x424F4353
	Offset: 0xFAF0
	Size: 0x58
	Parameters: 2
	Flags: None
	Line Number: 5248
*/
function function_register_zombie_weapon_callback(var_weapon, var_func)
{
	if(!isdefined(level.var_zombie_weapons_callbacks))
	{
		level.var_zombie_weapons_callbacks = [];
	}
	if(!isdefined(level.var_zombie_weapons_callbacks[var_weapon]))
	{
		level.var_zombie_weapons_callbacks[var_weapon] = var_func;
	}
}

/*
	Name: function_set_stowed_weapon
	Namespace: namespace_zm_weapons
	Checksum: 0x424F4353
	Offset: 0xFB50
	Size: 0x50
	Parameters: 1
	Flags: None
	Line Number: 5270
*/
function function_set_stowed_weapon(var_weapon)
{
	self.var_weapon_stowed = var_weapon;
	if(!(isdefined(self.var_stowed_weapon_suppressed) && self.var_stowed_weapon_suppressed))
	{
		self function_SetStowedWeapon(self.var_weapon_stowed);
	}
}

/*
	Name: function_clear_stowed_weapon
	Namespace: namespace_zm_weapons
	Checksum: 0x424F4353
	Offset: 0xFBA8
	Size: 0x28
	Parameters: 0
	Flags: None
	Line Number: 5289
*/
function function_clear_stowed_weapon()
{
	self.var_weapon_stowed = undefined;
	self function_ClearStowedWeapon();
}

/*
	Name: function_suppress_stowed_weapon
	Namespace: namespace_zm_weapons
	Checksum: 0x424F4353
	Offset: 0xFBD8
	Size: 0x68
	Parameters: 1
	Flags: None
	Line Number: 5305
*/
function function_suppress_stowed_weapon(var_onOff)
{
	self.var_stowed_weapon_suppressed = var_onOff;
	if(var_onOff || !isdefined(self.var_weapon_stowed))
	{
		self function_ClearStowedWeapon();
	}
	else
	{
		self function_SetStowedWeapon(self.var_weapon_stowed);
		return;
	}
}

/*
	Name: function_checkStringValid
	Namespace: namespace_zm_weapons
	Checksum: 0x424F4353
	Offset: 0xFC48
	Size: 0x28
	Parameters: 1
	Flags: None
	Line Number: 5329
*/
function function_checkStringValid(var_STR)
{
	if(var_STR != "")
	{
		return var_STR;
	}
	return undefined;
}

/*
	Name: function_load_weapon_spec_from_table
	Namespace: namespace_zm_weapons
	Checksum: 0x424F4353
	Offset: 0xFC78
	Size: 0x520
	Parameters: 2
	Flags: None
	Line Number: 5348
*/
function function_load_weapon_spec_from_table(var_table, var_first_row)
{
	var_gametype = function_GetDvarString("ui_gametype");
	var_index = 1;
	for(var_row = function_TableLookupRow(var_table, var_index); isdefined(var_row); var_row = function_TableLookupRow(var_table, var_index))
	{
		var_weapon_name = function_checkStringValid(var_row[0]);
		var_upgrade_name = function_checkStringValid(var_row[1]);
		var_hint = function_checkStringValid(var_row[2]);
		var_cost = function_Int(var_row[3]);
		var_weaponVO = function_checkStringValid(var_row[4]);
		var_weaponVOresp = function_checkStringValid(var_row[5]);
		var_ammo_cost = undefined;
		if("" != var_row[6])
		{
			var_ammo_cost = function_Int(var_row[6]);
		}
		var_create_vox = function_checkStringValid(var_row[7]);
		var_is_zcleansed = function_ToLower(var_row[8]) == "true";
		var_in_box = function_ToLower(var_row[9]) == "true";
		var_upgrade_in_box = function_ToLower(var_row[10]) == "true";
		var_is_limited = function_ToLower(var_row[11]) == "true";
		var_is_aat_exempt = function_ToLower(var_row[17]) == "true";
		var_limit = function_Int(var_row[12]);
		var_upgrade_limit = function_Int(var_row[13]);
		var_content_restrict = var_row[14];
		var_wallbuy_autospawn = function_ToLower(var_row[15]) == "true";
		var_WEAPON_CLASS = function_checkStringValid(var_row[16]);
		var_is_wonder_weapon = function_ToLower(var_row[18]) == "true";
		var_force_attachments = function_ToLower(var_row[19]);
		namespace_zm_utility::function_include_weapon(var_weapon_name, var_in_box);
		if(isdefined(var_upgrade_name))
		{
			namespace_zm_utility::function_include_weapon(var_upgrade_name, var_upgrade_in_box);
		}
		function_add_zombie_weapon(var_weapon_name, var_upgrade_name, var_hint, var_cost, var_weaponVO, var_weaponVOresp, var_ammo_cost, var_create_vox, var_is_wonder_weapon, var_force_attachments);
		if(var_is_limited)
		{
			if(isdefined(var_limit))
			{
				function_add_limited_weapon(var_weapon_name, var_limit);
			}
			if(isdefined(var_upgrade_limit) && isdefined(var_upgrade_name))
			{
				function_add_limited_weapon(var_upgrade_name, var_upgrade_limit);
			}
		}
		if(var_is_aat_exempt && isdefined(var_upgrade_name))
		{
			namespace_AAT::function_register_aat_exemption(function_GetWeapon(var_upgrade_name));
		}
		var_index++;
	}
}

/*
	Name: function_autofill_wallbuys_init
	Namespace: namespace_zm_weapons
	Checksum: 0x424F4353
	Offset: 0x101A0
	Size: 0x698
	Parameters: 0
	Flags: None
	Line Number: 5413
*/
function function_autofill_wallbuys_init()
{
	var_Wallbuys = namespace_struct::function_get_array("wallbuy_autofill", "targetname");
	if(!isdefined(var_Wallbuys) || var_Wallbuys.size == 0 || !isdefined(level.var_wallbuy_autofill_weapons) || level.var_wallbuy_autofill_weapons.size == 0)
	{
		return;
	}
	level.var_use_autofill_wallbuy = 1;
	level.var_active_autofill_wallbuys = [];
	var_array_keys["all"] = function_getArrayKeys(level.var_wallbuy_autofill_weapons["all"]);
	var_a = [];
	var_index = 0;
	foreach(var_wallbuy in var_Wallbuys)
	{
		var_WEAPON_CLASS = var_wallbuy.var_script_string;
		var_weapon = undefined;
		if(isdefined(var_WEAPON_CLASS) && var_WEAPON_CLASS != "")
		{
			if(!isdefined(var_array_keys[var_WEAPON_CLASS]) && isdefined(level.var_wallbuy_autofill_weapons[var_WEAPON_CLASS]))
			{
				var_array_keys[var_WEAPON_CLASS] = function_getArrayKeys(level.var_wallbuy_autofill_weapons[var_WEAPON_CLASS]);
			}
			if(isdefined(var_array_keys[var_WEAPON_CLASS]))
			{
				for(var_i = 0; var_i < var_array_keys[var_WEAPON_CLASS].size; var_i++)
				{
					if(level.var_wallbuy_autofill_weapons["all"][var_array_keys[var_WEAPON_CLASS][var_i]])
					{
						var_weapon = var_array_keys[var_WEAPON_CLASS][var_i];
						level.var_wallbuy_autofill_weapons["all"][var_weapon] = 0;
						break;
					}
				}
				continue;
			}
			else
			{
			}
		}
		else
		{
			var_a[var_a.size] = var_wallbuy;
			continue;
		}
		if(!isdefined(var_weapon))
		{
			continue;
		}
		var_wallbuy.var_zombie_weapon_upgrade = var_weapon.var_name;
		var_wallbuy.var_weapon = var_weapon;
		var_right = function_AnglesToRight(var_wallbuy.var_angles);
		var_wallbuy.var_origin = var_wallbuy.var_origin - var_right * 2;
		var_wallbuy.var_target = "autofill_wallbuy_" + var_index;
		var_target_struct = function_spawnstruct();
		var_target_struct.var_targetname = var_wallbuy.var_target;
		var_target_struct.var_angles = var_wallbuy.var_angles;
		var_target_struct.var_origin = var_wallbuy.var_origin;
		var_model = var_wallbuy.var_weapon.var_worldmodel;
		var_target_struct.var_model = var_model;
		var_target_struct namespace_struct::function_init();
		level.var_active_autofill_wallbuys[level.var_active_autofill_wallbuys.size] = var_wallbuy;
		var_index++;
	}
	foreach(var_wallbuy in var_a)
	{
		var_weapon = undefined;
		for(var_i = 0; var_i < var_array_keys["all"].size; var_i++)
		{
			if(level.var_wallbuy_autofill_weapons["all"][var_array_keys["all"][var_i]])
			{
				var_weapon = var_array_keys["all"][var_i];
				level.var_wallbuy_autofill_weapons["all"][var_weapon] = 0;
				break;
			}
		}
		if(!isdefined(var_weapon))
		{
			break;
		}
		var_wallbuy.var_zombie_weapon_upgrade = var_weapon.var_name;
		var_wallbuy.var_weapon = var_weapon;
		var_right = function_AnglesToRight(var_wallbuy.var_angles);
		var_wallbuy.var_origin = var_wallbuy.var_origin - var_right * 2;
		var_wallbuy.var_target = "autofill_wallbuy_" + var_index;
		var_target_struct = function_spawnstruct();
		var_target_struct.var_targetname = var_wallbuy.var_target;
		var_target_struct.var_angles = var_wallbuy.var_angles;
		var_target_struct.var_origin = var_wallbuy.var_origin;
		var_model = var_wallbuy.var_weapon.var_worldmodel;
		var_target_struct.var_model = var_model;
		var_target_struct namespace_struct::function_init();
		level.var_active_autofill_wallbuys[level.var_active_autofill_wallbuys.size] = var_wallbuy;
		var_index++;
	}
}

/*
	Name: function_is_wallbuy
	Namespace: namespace_zm_weapons
	Checksum: 0x424F4353
	Offset: 0x10840
	Size: 0xC0
	Parameters: 1
	Flags: None
	Line Number: 5519
*/
function function_is_wallbuy(var_w_to_check)
{
	var_w_base = function_get_base_weapon(var_w_to_check);
	foreach(var_s_wallbuy in level.var__spawned_wallbuys)
	{
		if(var_s_wallbuy.var_weapon == var_w_base)
		{
			return 1;
		}
	}
	return 0;
}

/*
	Name: function_is_wonder_weapon
	Namespace: namespace_zm_weapons
	Checksum: 0x424F4353
	Offset: 0x10908
	Size: 0x66
	Parameters: 1
	Flags: None
	Line Number: 5542
*/
function function_is_wonder_weapon(var_w_to_check)
{
	var_w_base = function_get_base_weapon(var_w_to_check);
	if(isdefined(level.var_zombie_weapons[var_w_base]) && level.var_zombie_weapons[var_w_base].var_is_wonder_weapon)
	{
		return 1;
	}
	return 0;
}

