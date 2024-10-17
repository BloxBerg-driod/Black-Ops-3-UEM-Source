#include scripts\codescripts\struct;
#include scripts\shared\aat_shared;
#include scripts\shared\array_shared;
#include scripts\shared\callbacks_shared;
#include scripts\shared\clientfield_shared;
#include scripts\shared\flag_shared;
#include scripts\shared\laststand_shared;
#include scripts\shared\util_shared;
#include scripts\shared\weapons\_weaponobjects;
#include scripts\sphynx\leveling\_zm_sphynx_leveling;
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

#namespace zm_weapons;

/*
	Name: init
	Namespace: zm_weapons
	Checksum: 0x424F4353
	Offset: 0x10E0
	Size: 0x770
	Parameters: 0
	Flags: None
	Line Number: 39
*/
function init()
{
	level.var_47a8a2a5 = array(getweapon("cymbal_monkey"), getweapon("ray_gun"), getweapon("elemental_bow_wolf_howl4"), getweapon("elemental_bow_wolf_howl3"), getweapon("elemental_bow_wolf_howl2"), getweapon("elemental_bow_wolf_howl1"), getweapon("elemental_bow_wolf_howl"), getweapon("elemental_bow_wolf4"), getweapon("elemental_bow_wolf3"), getweapon("elemental_bow_wolf2"), getweapon("elemental_bow_wolf1"), getweapon("elemental_bow_wolf"), getweapon("elemental_bow_rune_prison"), getweapon("elemental_bow_demongate"), getweapon("elemental_bow_storm"), getweapon("elemental_bow"), getweapon("t7_staff_water_upgraded"), getweapon("t7_staff_lightning_upgraded"), getweapon("t7_staff_fire_upgraded"), getweapon("t7_staff_air_upgraded"), getweapon("t7_staff_water"), getweapon("t7_staff_lightning"), getweapon("t7_staff_fire"), getweapon("t7_staff_air"), getweapon("staff_air"), getweapon("staff_lightning"), getweapon("staff_water"), getweapon("staff_fire"), getweapon("t7_shrink_ray_upgraded"), getweapon("t7_shrink_ray"), getweapon("t7_hero_mirg2000_upgraded"), getweapon("t7_hero_mirg2000"), getweapon("microwavegundw"), getweapon("microwavegundw_upgraded"), getweapon("microwavegun"), getweapon("microwavegun_upgraded"), getweapon("idgun_genesis_0_upgraded"), getweapon("idgun_genesis_0"), getweapon("t7_idgun_genesis_0_upgraded"), getweapon("t7_idgun_genesis_0"), getweapon("idgun_upgraded_4"), getweapon("idgun_4"), getweapon("idgun_upgraded_3"), getweapon("idgun_3"), getweapon("idgun_upgraded_2"), getweapon("idgun_2"), getweapon("idgun_upgraded_1"), getweapon("idgun_1"), getweapon("idgun_upgraded_0"), getweapon("idgun_0"), getweapon("idgun_upgraded"), getweapon("thundergun_upgraded"), getweapon("thundergun"), getweapon("skull_gun"), getweapon("hero_mirg2000"), getweapon("glaive_apothicon_3"), getweapon("glaive_apothicon_2"), getweapon("glaive_apothicon_1"), getweapon("glaive_apothicon_0"), getweapon("raygun_mark2"), getweapon("tesla_gun"), getweapon("raygun_mark3"), getweapon("ray_gun"), getweapon("hero_annihilator"), getweapon("hero_gravityspikes_melee"), getweapon("zod_riotshield"), getweapon("octobomb"), getweapon("cymbal_monkey"), getweapon("bouncingbetty"));
	if(!isdefined(level.pack_a_punch_camo_index))
	{
		level.pack_a_punch_camo_index = 42;
	}
	if(!isdefined(level.weapon_cost_client_filled))
	{
		level.weapon_cost_client_filled = 1;
	}
	if(!isdefined(level.obsolete_prompt_format_needed))
	{
		level.obsolete_prompt_format_needed = 0;
	}
	init_weapons();
	init_weapon_upgrade();
	level._weaponobjects_on_player_connect_override = &weaponobjects_on_player_connect_override;
	level._zombiemode_check_firesale_loc_valid_func = &default_check_firesale_loc_valid_func;
	level.MissileEntities = [];
	level thread onplayerconnect();
	level.var_256c9d48 = array();
	level.var_7f7e3195 = 1;
}

/*
	Name: onplayerconnect
	Namespace: zm_weapons
	Checksum: 0x424F4353
	Offset: 0x1858
	Size: 0x38
	Parameters: 0
	Flags: None
	Line Number: 74
*/
function onplayerconnect()
{
	for(;;)
	{
		level waittill("connecting", player);
		player thread onplayerspawned();
	}
}

/*
	Name: onplayerspawned
	Namespace: zm_weapons
	Checksum: 0x424F4353
	Offset: 0x1898
	Size: 0x60
	Parameters: 0
	Flags: None
	Line Number: 93
*/
function onplayerspawned()
{
	self endon("disconnect");
	for(;;)
	{
		self waittill("spawned_player");
		self thread watchForGrenadeDuds();
		self thread watchForGrenadeLauncherDuds();
		self.staticWeaponsStartTime = GetTime();
	}
	return;
}

/*
	Name: watchForGrenadeDuds
	Namespace: zm_weapons
	Checksum: 0x424F4353
	Offset: 0x1900
	Size: 0xC0
	Parameters: 0
	Flags: None
	Line Number: 116
*/
function watchForGrenadeDuds()
{
	self endon("spawned_player");
	self endon("disconnect");
	while(1)
	{
		self waittill("grenade_fire", grenade, weapon);
		if(!zm_equipment::is_equipment(weapon) && !zm_utility::is_placeable_mine(weapon))
		{
			grenade thread checkGrenadeForDud(weapon, 1, self);
			grenade thread watchForScriptExplosion(weapon, 1, self);
		}
	}
}

/*
	Name: watchForGrenadeLauncherDuds
	Namespace: zm_weapons
	Checksum: 0x424F4353
	Offset: 0x19C8
	Size: 0x88
	Parameters: 0
	Flags: None
	Line Number: 141
*/
function watchForGrenadeLauncherDuds()
{
	self endon("spawned_player");
	self endon("disconnect");
	while(1)
	{
		self waittill("grenade_launcher_fire", grenade, weapon);
		grenade thread checkGrenadeForDud(weapon, 0, self);
		grenade thread watchForScriptExplosion(weapon, 0, self);
	}
}

/*
	Name: grenade_safe_to_throw
	Namespace: zm_weapons
	Checksum: 0x424F4353
	Offset: 0x1A58
	Size: 0x40
	Parameters: 2
	Flags: None
	Line Number: 163
*/
function grenade_safe_to_throw(player, weapon)
{
	if(isdefined(level.grenade_safe_to_throw))
	{
		return self [[level.grenade_safe_to_throw]](player, weapon);
	}
	return 1;
}

/*
	Name: grenade_safe_to_bounce
	Namespace: zm_weapons
	Checksum: 0x424F4353
	Offset: 0x1AA0
	Size: 0x40
	Parameters: 2
	Flags: None
	Line Number: 182
*/
function grenade_safe_to_bounce(player, weapon)
{
	if(isdefined(level.grenade_safe_to_bounce))
	{
		return self [[level.grenade_safe_to_bounce]](player, weapon);
	}
	return 1;
}

/*
	Name: makeGrenadeDudAndDestroy
	Namespace: zm_weapons
	Checksum: 0x424F4353
	Offset: 0x1AE8
	Size: 0x50
	Parameters: 0
	Flags: None
	Line Number: 201
*/
function makeGrenadeDudAndDestroy()
{
	self endon("death");
	self notify("grenade_dud");
	self makeGrenadeDud();
	wait(3);
	if(isdefined(self))
	{
		self delete();
		return;
	}
	ERROR: Exception occured: Stack empty.
}

/*
	Name: checkGrenadeForDud
	Namespace: zm_weapons
	Checksum: 0x424F4353
	Offset: 0x1B40
	Size: 0xF8
	Parameters: 3
	Flags: None
	Line Number: 225
*/
function checkGrenadeForDud(weapon, isThrownGrenade, player)
{
	self endon("death");
	player endon("zombify");
	if(!isdefined(self))
	{
		return;
	}
	if(!self grenade_safe_to_throw(player, weapon))
	{
		self thread makeGrenadeDudAndDestroy();
		return;
	}
	for(;;)
	{
		self util::waittill_any_ex(0.25, "grenade_bounce", "stationary", "death", player, "zombify");
		if(!self grenade_safe_to_bounce(player, weapon))
		{
			self thread makeGrenadeDudAndDestroy();
			return;
		}
	}
}

/*
	Name: wait_explode
	Namespace: zm_weapons
	Checksum: 0x424F4353
	Offset: 0x1C40
	Size: 0x60
	Parameters: 0
	Flags: None
	Line Number: 259
*/
function wait_explode()
{
	self endon("grenade_dud");
	self endon("done");
	self waittill("explode", position);
	level.explode_position = position;
	level.explode_position_valid = 1;
	self notify("done");
}

/*
	Name: wait_timeout
	Namespace: zm_weapons
	Checksum: 0x424F4353
	Offset: 0x1CA8
	Size: 0x50
	Parameters: 1
	Flags: None
	Line Number: 279
*/
function wait_timeout(time)
{
	self endon("grenade_dud");
	self endon("done");
	self endon("explode");
	wait(time);
	if(isdefined(self))
	{
		self notify("done");
	}
}

/*
	Name: wait_for_explosion
	Namespace: zm_weapons
	Checksum: 0x424F4353
	Offset: 0x1D00
	Size: 0x80
	Parameters: 1
	Flags: None
	Line Number: 301
*/
function wait_for_explosion(time)
{
	level.explode_position = (0, 0, 0);
	level.explode_position_valid = 0;
	self thread wait_explode();
	self thread wait_timeout(time);
	self waittill("done");
	self notify("death_or_explode", level.explode_position_valid, level.explode_position);
	return;
	ERROR: Exception occured: Stack empty.
}

/*
	Name: watchForScriptExplosion
	Namespace: zm_weapons
	Checksum: 0x424F4353
	Offset: 0x1D88
	Size: 0xB0
	Parameters: 3
	Flags: None
	Line Number: 323
*/
function watchForScriptExplosion(weapon, isThrownGrenade, player)
{
	self endon("grenade_dud");
	if(zm_utility::is_lethal_grenade(weapon) || weapon.isLauncher)
	{
		self thread wait_for_explosion(20);
		self waittill("death_or_explode", exploded, position);
		if(exploded)
		{
			level notify("grenade_exploded", position, 256, 300, 75);
		}
	}
}

/*
	Name: get_nonalternate_weapon
	Namespace: zm_weapons
	Checksum: 0x424F4353
	Offset: 0x1E40
	Size: 0x30
	Parameters: 1
	Flags: None
	Line Number: 347
*/
function get_nonalternate_weapon(weapon)
{
	if(weapon.isAltMode)
	{
		return weapon.altweapon;
	}
	return weapon;
}

/*
	Name: switch_from_alt_weapon
	Namespace: zm_weapons
	Checksum: 0x424F4353
	Offset: 0x1E78
	Size: 0xB8
	Parameters: 1
	Flags: None
	Line Number: 366
*/
function switch_from_alt_weapon(weapon)
{
	if(weapon.ischargeshot)
	{
		return weapon;
	}
	alt = get_nonalternate_weapon(weapon);
	if(alt != weapon)
	{
		if(!weaponhasattachment(weapon, "dualoptic"))
		{
			self switchtoweaponimmediate(alt);
			self util::waittill_any_timeout(1, "weapon_change_complete");
		}
		return alt;
	}
	return weapon;
}

/*
	Name: give_start_weapons
	Namespace: zm_weapons
	Checksum: 0x424F4353
	Offset: 0x1F38
	Size: 0x50
	Parameters: 2
	Flags: None
	Line Number: 395
*/
function give_start_weapons(takeallweapons, alreadyspawned)
{
	self giveweapon(level.weaponBaseMelee);
	self zm_utility::give_start_weapon(1);
	return;
	ERROR: Bad function call
}

/*
	Name: give_fallback_weapon
	Namespace: zm_weapons
	Checksum: 0x424F4353
	Offset: 0x1F90
	Size: 0x38
	Parameters: 1
	Flags: None
	Line Number: 413
*/
function give_fallback_weapon(immediate)
{
	if(!isdefined(immediate))
	{
		immediate = 0;
	}
	zm_melee_weapon::give_fallback_weapon(immediate);
}

/*
	Name: take_fallback_weapon
	Namespace: zm_weapons
	Checksum: 0x424F4353
	Offset: 0x1FD0
	Size: 0x18
	Parameters: 0
	Flags: None
	Line Number: 432
*/
function take_fallback_weapon()
{
	zm_melee_weapon::take_fallback_weapon();
}

/*
	Name: switch_back_primary_weapon
	Namespace: zm_weapons
	Checksum: 0x424F4353
	Offset: 0x1FF0
	Size: 0x228
	Parameters: 2
	Flags: None
	Line Number: 447
*/
function switch_back_primary_weapon(oldprimary, immediate)
{
	if(!isdefined(immediate))
	{
		immediate = 0;
	}
	if(isdefined(self.laststand) && self.laststand)
	{
		return;
	}
	if(!isdefined(oldprimary) || oldprimary == level.weaponnone || oldprimary.isFlourishWeapon || zm_utility::is_melee_weapon(oldprimary) || zm_utility::is_placeable_mine(oldprimary) || zm_utility::is_lethal_grenade(oldprimary) || zm_utility::is_tactical_grenade(oldprimary) || !self hasweapon(oldprimary))
	{
		oldprimary = undefined;
	}
	else if(oldprimary.isHeroWeapon || oldprimary.isgadget && (!isdefined(self.hero_power) || self.hero_power <= 0))
	{
		oldprimary = undefined;
	}
	primaryWeapons = self getweaponslistprimaries();
	if(isdefined(oldprimary) && isinarray(primaryWeapons, oldprimary))
	{
		if(immediate)
		{
			self switchtoweaponimmediate(oldprimary);
		}
		else
		{
			self switchtoweapon(oldprimary);
		}
	}
	else if(primaryWeapons.size > 0)
	{
		if(immediate)
		{
			self switchtoweaponimmediate();
		}
		else
		{
			self switchtoweapon();
		}
	}
	else
	{
		give_fallback_weapon(immediate);
	}
}

/*
	Name: add_retrievable_knife_init_name
	Namespace: zm_weapons
	Checksum: 0x424F4353
	Offset: 0x2220
	Size: 0x40
	Parameters: 1
	Flags: None
	Line Number: 504
*/
function add_retrievable_knife_init_name(name)
{
	if(!isdefined(level.retrievable_knife_init_names))
	{
		level.retrievable_knife_init_names = [];
	}
	level.retrievable_knife_init_names[level.retrievable_knife_init_names.size] = name;
	return;
	ERROR: Exception occured: Stack empty.
}

/*
	Name: watchWeaponUsageZM
	Namespace: zm_weapons
	Checksum: 0x424F4353
	Offset: 0x2268
	Size: 0x118
	Parameters: 0
	Flags: None
	Line Number: 525
*/
function watchWeaponUsageZM()
{
	self endon("death");
	self endon("disconnect");
	level endon("game_ended");
	for(;;)
	{
		self waittill("weapon_fired", curweapon);
		self.lastFireTime = GetTime();
		self.hasDoneCombat = 1;
		switch(curweapon.weapClass)
		{
			case "mg":
			case "pistol":
			case "pistol spread":
			case "pistolspread":
			case "rifle":
			case "smg":
			case "spread":
			{
				self weapons::trackWeaponFire(curweapon);
				level.globalShotsFired++;
				break;
			}
			case "grenade":
			case "rocketlauncher":
			{
				self addweaponstat(curweapon, "shots", 1);
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
	Name: trackWeaponZM
	Namespace: zm_weapons
	Checksum: 0x424F4353
	Offset: 0x2388
	Size: 0x168
	Parameters: 0
	Flags: None
	Line Number: 573
*/
function trackWeaponZM()
{
	self.currentweapon = self getcurrentweapon();
	self.currentTime = GetTime();
	spawnid = getplayerspawnid(self);
	while(1)
	{
		event = self util::waittill_any_return("weapon_change", "death", "disconnect", "bled_out");
		newTime = GetTime();
		if(event == "weapon_change")
		{
			newweapon = self getcurrentweapon();
			if(newweapon != level.weaponnone && newweapon != self.currentweapon)
			{
				updateLastHeldWeaponTimingsZM(newTime);
				self.currentweapon = newweapon;
				self.currentTime = newTime;
			}
		}
		else if(event != "death" && event != "disconnect")
		{
			updateWeaponTimingsZM(newTime);
			return;
		}
	}
}

/*
	Name: updateLastHeldWeaponTimingsZM
	Namespace: zm_weapons
	Checksum: 0x424F4353
	Offset: 0x24F8
	Size: 0xA0
	Parameters: 1
	Flags: None
	Line Number: 610
*/
function updateLastHeldWeaponTimingsZM(newTime)
{
	if(isdefined(self.currentweapon) && isdefined(self.currentTime))
	{
		curweapon = self.currentweapon;
		totalTime = int(newTime - self.currentTime / 1000);
		if(totalTime > 0)
		{
			self addweaponstat(curweapon, "timeUsed", totalTime);
		}
	}
}

/*
	Name: updateWeaponTimingsZM
	Namespace: zm_weapons
	Checksum: 0x424F4353
	Offset: 0x25A0
	Size: 0x98
	Parameters: 1
	Flags: None
	Line Number: 633
*/
function updateWeaponTimingsZM(newTime)
{
	if(self util::is_bot())
	{
		return;
	}
	updateLastHeldWeaponTimingsZM(newTime);
	if(!isdefined(self.staticWeaponsStartTime))
	{
		return;
	}
	totalTime = int(newTime - self.staticWeaponsStartTime / 1000);
	if(totalTime < 0)
	{
		return;
	}
	self.staticWeaponsStartTime = newTime;
}

/*
	Name: watchWeaponChangeZM
	Namespace: zm_weapons
	Checksum: 0x424F4353
	Offset: 0x2640
	Size: 0xC8
	Parameters: 0
	Flags: None
	Line Number: 662
*/
function watchWeaponChangeZM()
{
	self endon("death");
	self endon("disconnect");
	self.lastdroppableweapon = self getcurrentweapon();
	self.hitsThisMag = [];
	weapon = self getcurrentweapon();
	while(1)
	{
		previous_weapon = self getcurrentweapon();
		self waittill("weapon_change", newweapon);
		if(weapons::mayDropWeapon(newweapon))
		{
			self.lastdroppableweapon = newweapon;
		}
	}
}

/*
	Name: weaponobjects_on_player_connect_override_internal
	Namespace: zm_weapons
	Checksum: 0x424F4353
	Offset: 0x2710
	Size: 0x158
	Parameters: 0
	Flags: None
	Line Number: 690
*/
function weaponobjects_on_player_connect_override_internal()
{
	self weaponobjects::createBaseWatchers();
	self zm_placeable_mine::setup_watchers();
	for(i = 0; i < level.retrievable_knife_init_names.size; i++)
	{
		self createBallisticKnifeWatcher_zm(level.retrievable_knife_init_names[i]);
	}
	self weaponobjects::setupRetrievableWatcher();
	if(!isdefined(self.weaponObjectWatcherArray))
	{
		self.weaponObjectWatcherArray = [];
	}
	self.concussionEndTime = 0;
	self.hasDoneCombat = 0;
	self.lastFireTime = 0;
	self thread watchWeaponUsageZM();
	self thread weapons::watchGrenadeUsage();
	self thread weapons::watchMissileUsage();
	self thread watchWeaponChangeZM();
	self thread trackWeaponZM();
	self notify("weapon_watchers_created");
	return;
	ERROR: Exception occured: Stack empty.
}

/*
	Name: weaponobjects_on_player_connect_override
	Namespace: zm_weapons
	Checksum: 0x424F4353
	Offset: 0x2870
	Size: 0x58
	Parameters: 0
	Flags: None
	Line Number: 726
*/
function weaponobjects_on_player_connect_override()
{
	add_retrievable_knife_init_name("knife_ballistic");
	add_retrievable_knife_init_name("knife_ballistic_upgraded");
	callback::on_connect(&weaponobjects_on_player_connect_override_internal);
}

/*
	Name: createBallisticKnifeWatcher_zm
	Namespace: zm_weapons
	Checksum: 0x424F4353
	Offset: 0x28D0
	Size: 0x90
	Parameters: 1
	Flags: None
	Line Number: 743
*/
function createBallisticKnifeWatcher_zm(weaponname)
{
	watcher = self weaponobjects::createUseWeaponObjectWatcher(weaponname, self.team);
	watcher.onSpawn = &_zm_weap_ballistic_knife::on_spawn;
	watcher.onSpawnRetrieveTriggers = &_zm_weap_ballistic_knife::on_spawn_retrieve_trigger;
	watcher.storeDifferentObject = 1;
	watcher.headicon = 0;
}

/*
	Name: default_check_firesale_loc_valid_func
	Namespace: zm_weapons
	Checksum: 0x424F4353
	Offset: 0x2968
	Size: 0x8
	Parameters: 0
	Flags: None
	Line Number: 762
*/
function default_check_firesale_loc_valid_func()
{
	return 1;
}

/*
	Name: add_zombie_weapon
	Namespace: zm_weapons
	Checksum: 0x424F4353
	Offset: 0x2978
	Size: 0x470
	Parameters: 10
	Flags: None
	Line Number: 777
*/
function add_zombie_weapon(weapon_name, upgrade_name, hint, cost, weaponVO, weaponVOresp, ammo_cost, create_vox, is_wonder_weapon, force_attachments)
{
	weapon = getweapon(weapon_name);
	upgrade = undefined;
	if(isdefined(upgrade_name))
	{
		upgrade = getweapon(upgrade_name);
	}
	if(isdefined(level.zombie_include_weapons) && !isdefined(level.zombie_include_weapons[weapon]))
	{
		return;
	}
	struct = spawnstruct();
	if(!isdefined(level.zombie_weapons))
	{
		level.zombie_weapons = [];
	}
	if(!isdefined(level.zombie_weapons_upgraded))
	{
		level.zombie_weapons_upgraded = [];
	}
	if(isdefined(upgrade_name))
	{
		level.zombie_weapons_upgraded[upgrade] = weapon;
	}
	struct.weapon = weapon;
	struct.upgrade = upgrade;
	struct.weapon_classname = "weapon_" + weapon_name + "_zm";
	if(isdefined(level.weapon_cost_client_filled) && level.weapon_cost_client_filled)
	{
		struct.hint = &"ZOMBIE_WEAPONCOSTONLY_CFILL";
	}
	else
	{
		struct.hint = &"ZOMBIE_WEAPONCOSTONLYFILL";
	}
	struct.cost = cost;
	struct.vox = weaponVO;
	struct.vox_response = weaponVOresp;
	struct.is_wonder_weapon = is_wonder_weapon;
	struct.force_attachments = [];
	if("" != force_attachments)
	{
		force_attachments_list = strtok(force_attachments, " ");
		/#
			Assert(6 >= force_attachments_list.size, weapon_name + "Dev Block strings are not supported");
		#/
		foreach(attachment in force_attachments_list)
		{
			struct.force_attachments[struct.force_attachments.size] = attachment;
		}
	}
	struct.is_in_box = level.zombie_include_weapons[weapon];
	if(!isdefined(ammo_cost))
	{
		ammo_cost = zm_utility::round_up_to_ten(int(cost * 0.5));
	}
	struct.ammo_cost = ammo_cost;
	if(weapon.isEmp || (isdefined(upgrade) && upgrade.isEmp))
	{
		level.should_watch_for_emp = 1;
	}
	level.zombie_weapons[weapon] = struct;
	if(zm_pap_util::can_swap_attachments() && isdefined(upgrade_name))
	{
		add_attachments(weapon_name, upgrade_name);
	}
	if(isdefined(create_vox))
	{
		level.vox zm_audio::zmbVoxAdd("player", "weapon_pickup", weapon, weaponVO, undefined);
	}
}

/*
	Name: add_attachments
	Namespace: zm_weapons
	Checksum: 0x424F4353
	Offset: 0x2DF0
	Size: 0x1A8
	Parameters: 2
	Flags: None
	Line Number: 860
*/
function add_attachments(weapon, upgrade)
{
	table = "gamedata/weapons/zm/pap_attach.csv";
	if(isdefined(level.weapon_attachment_table))
	{
		table = level.weapon_attachment_table;
	}
	row = TableLookupRowNum(table, 0, upgrade);
	if(row > -1)
	{
		level.zombie_weapons[weapon].default_attachment = tablelookup(table, 0, upgrade.name, 1);
		level.zombie_weapons[weapon].addon_attachments = [];
		index = 2;
		for(next_addon = tablelookup(table, 0, upgrade.name, index); isdefined(next_addon) && next_addon.size > 0; next_addon = tablelookup(table, 0, upgrade.name, index))
		{
			level.zombie_weapons[weapon].addon_attachments[level.zombie_weapons[weapon].addon_attachments.size] = next_addon;
			index++;
		}
	}
}

/*
	Name: is_weapon_included
	Namespace: zm_weapons
	Checksum: 0x424F4353
	Offset: 0x2FA0
	Size: 0x58
	Parameters: 1
	Flags: None
	Line Number: 891
*/
function is_weapon_included(weapon)
{
	if(!isdefined(level.zombie_weapons))
	{
		return 0;
	}
	weapon = get_nonalternate_weapon(weapon);
	return isdefined(level.zombie_weapons[weapon.rootweapon]);
}

/*
	Name: is_weapon_or_base_included
	Namespace: zm_weapons
	Checksum: 0x424F4353
	Offset: 0x3000
	Size: 0x68
	Parameters: 1
	Flags: None
	Line Number: 911
*/
function is_weapon_or_base_included(weapon)
{
	weapon = get_nonalternate_weapon(weapon);
	return isdefined(level.zombie_weapons[weapon.rootweapon]) || isdefined(level.zombie_weapons[get_base_weapon(weapon)]);
}

/*
	Name: include_zombie_weapon
	Namespace: zm_weapons
	Checksum: 0x424F4353
	Offset: 0x3070
	Size: 0x68
	Parameters: 2
	Flags: None
	Line Number: 927
*/
function include_zombie_weapon(weapon_name, in_box)
{
	if(!isdefined(level.zombie_include_weapons))
	{
		level.zombie_include_weapons = [];
	}
	if(!isdefined(in_box))
	{
		in_box = 1;
	}
	level.zombie_include_weapons[getweapon(weapon_name)] = in_box;
}

/*
	Name: init_weapons
	Namespace: zm_weapons
	Checksum: 0x424F4353
	Offset: 0x30E0
	Size: 0x20
	Parameters: 0
	Flags: None
	Line Number: 950
*/
function init_weapons()
{
	if(isdefined(level._zombie_custom_add_weapons))
	{
		[[level._zombie_custom_add_weapons]]();
	}
}

/*
	Name: add_limited_weapon
	Namespace: zm_weapons
	Checksum: 0x424F4353
	Offset: 0x3108
	Size: 0x50
	Parameters: 2
	Flags: None
	Line Number: 968
*/
function add_limited_weapon(weapon_name, amount)
{
	if(!isdefined(level.limited_weapons))
	{
		level.limited_weapons = [];
	}
	level.limited_weapons[getweapon(weapon_name)] = amount;
}

/*
	Name: limited_weapon_below_quota
	Namespace: zm_weapons
	Checksum: 0x424F4353
	Offset: 0x3160
	Size: 0x3F8
	Parameters: 3
	Flags: None
	Line Number: 987
*/
function limited_weapon_below_quota(weapon, ignore_player, pap_triggers)
{
	if(isdefined(level.limited_weapons[weapon]))
	{
		if(!isdefined(pap_triggers))
		{
			pap_triggers = zm_pap_util::get_triggers();
		}
		if(isdefined(level.no_limited_weapons) && level.no_limited_weapons)
		{
			return 0;
		}
		upgradedweapon = weapon;
		if(isdefined(level.zombie_weapons[weapon]) && isdefined(level.zombie_weapons[weapon].upgrade))
		{
			upgradedweapon = level.zombie_weapons[weapon].upgrade;
		}
		players = getplayers();
		count = 0;
		limit = level.limited_weapons[weapon];
		for(i = 0; i < players.size; i++)
		{
			if(isdefined(ignore_player) && ignore_player == players[i])
			{
				continue;
			}
			if(players[i] has_weapon_or_upgrade(weapon))
			{
				count++;
				if(count >= limit)
				{
					return 0;
				}
			}
		}
		for(K = 0; K < pap_triggers.size; K++)
		{
			if(isdefined(pap_triggers[K].current_weapon) && (pap_triggers[K].current_weapon == weapon || pap_triggers[K].current_weapon == upgradedweapon))
			{
				count++;
				if(count >= limit)
				{
					return 0;
				}
			}
		}
		for(chestIndex = 0; chestIndex < level.chests.size; chestIndex++)
		{
			if(isdefined(level.chests[chestIndex].zbarrier.weapon) && level.chests[chestIndex].zbarrier.weapon == weapon)
			{
				count++;
				if(count >= limit)
				{
					return 0;
				}
			}
		}
		if(isdefined(level.custom_limited_weapon_checks))
		{
			foreach(check in level.custom_limited_weapon_checks)
			{
				count = count + [[check]](weapon);
			}
			if(count >= limit)
			{
				return 0;
			}
		}
		if(isdefined(level.random_weapon_powerups))
		{
			for(powerupIndex = 0; powerupIndex < level.random_weapon_powerups.size; powerupIndex++)
			{
				if(isdefined(level.random_weapon_powerups[powerupIndex]) && level.random_weapon_powerups[powerupIndex].base_weapon == weapon)
				{
					count++;
					if(count >= limit)
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
	Name: add_custom_limited_weapon_check
	Namespace: zm_weapons
	Checksum: 0x424F4353
	Offset: 0x3560
	Size: 0x40
	Parameters: 1
	Flags: None
	Line Number: 1083
*/
function add_custom_limited_weapon_check(callback)
{
	if(!isdefined(level.custom_limited_weapon_checks))
	{
		level.custom_limited_weapon_checks = [];
	}
	level.custom_limited_weapon_checks[level.custom_limited_weapon_checks.size] = callback;
	return;
	ERROR: Exception occured: Stack empty.
}

/*
	Name: add_weapon_to_content
	Namespace: zm_weapons
	Checksum: 0x424F4353
	Offset: 0x35A8
	Size: 0x50
	Parameters: 2
	Flags: None
	Line Number: 1104
*/
function add_weapon_to_content(weapon_name, package)
{
	if(!isdefined(level.content_weapons))
	{
		level.content_weapons = [];
	}
	level.content_weapons[getweapon(weapon_name)] = package;
}

/*
	Name: player_can_use_content
	Namespace: zm_weapons
	Checksum: 0x424F4353
	Offset: 0x3600
	Size: 0x50
	Parameters: 1
	Flags: None
	Line Number: 1123
*/
function player_can_use_content(weapon)
{
	if(isdefined(level.content_weapons))
	{
		if(isdefined(level.content_weapons[weapon]))
		{
			return self HasDLCAvailable(level.content_weapons[weapon]);
		}
	}
	return 1;
}

/*
	Name: init_spawnable_weapon_upgrade
	Namespace: zm_weapons
	Checksum: 0x424F4353
	Offset: 0x3658
	Size: 0xC68
	Parameters: 0
	Flags: None
	Line Number: 1145
*/
function init_spawnable_weapon_upgrade()
{
	spawn_list = [];
	spawnable_weapon_spawns = struct::get_array("weapon_upgrade", "targetname");
	spawnable_weapon_spawns = arraycombine(spawnable_weapon_spawns, struct::get_array("bowie_upgrade", "targetname"), 1, 0);
	spawnable_weapon_spawns = arraycombine(spawnable_weapon_spawns, struct::get_array("sickle_upgrade", "targetname"), 1, 0);
	spawnable_weapon_spawns = arraycombine(spawnable_weapon_spawns, struct::get_array("tazer_upgrade", "targetname"), 1, 0);
	spawnable_weapon_spawns = arraycombine(spawnable_weapon_spawns, struct::get_array("buildable_wallbuy", "targetname"), 1, 0);
	if(isdefined(level.use_autofill_wallbuy) && level.use_autofill_wallbuy)
	{
		spawnable_weapon_spawns = arraycombine(spawnable_weapon_spawns, level.active_autofill_wallbuys, 1, 0);
	}
	if(!(isdefined(level.headshots_only) && level.headshots_only))
	{
		spawnable_weapon_spawns = arraycombine(spawnable_weapon_spawns, struct::get_array("claymore_purchase", "targetname"), 1, 0);
	}
	location = level.scr_zm_map_start_location;
	if(location == "default" || location == "" && isdefined(level.default_start_location))
	{
		location = level.default_start_location;
	}
	match_string = level.scr_zm_ui_gametype;
	if("" != location)
	{
		match_string = match_string + "_" + location;
	}
	match_string_plus_space = " " + match_string;
	for(i = 0; i < spawnable_weapon_spawns.size; i++)
	{
		spawnable_weapon = spawnable_weapon_spawns[i];
		spawnable_weapon.weapon = getweapon(spawnable_weapon.zombie_weapon_upgrade);
		if(isdefined(spawnable_weapon.zombie_weapon_upgrade) && spawnable_weapon.weapon.isgrenadeweapon && (isdefined(level.headshots_only) && level.headshots_only))
		{
			continue;
		}
		if(!isdefined(spawnable_weapon.script_noteworthy) || spawnable_weapon.script_noteworthy == "")
		{
			spawn_list[spawn_list.size] = spawnable_weapon;
			continue;
		}
		matches = strtok(spawnable_weapon.script_noteworthy, ",");
		for(j = 0; j < matches.size; j++)
		{
			if(matches[j] == match_string || matches[j] == match_string_plus_space)
			{
				spawn_list[spawn_list.size] = spawnable_weapon;
			}
		}
	}
	tempModel = spawn("script_model", (0, 0, 0));
	for(i = 0; i < spawn_list.size; i++)
	{
		clientFieldName = spawn_list[i].zombie_weapon_upgrade + "_" + spawn_list[i].origin;
		numBits = 2;
		if(isdefined(level._wallbuy_override_num_bits))
		{
			numBits = level._wallbuy_override_num_bits;
		}
		clientfield::register("world", clientFieldName, 1, numBits, "int");
		target_struct = struct::get(spawn_list[i].target, "targetname");
		if(spawn_list[i].targetname == "buildable_wallbuy")
		{
			bits = 4;
			if(isdefined(level.buildable_wallbuy_weapons))
			{
				bits = GetMinBitCountForNum(level.buildable_wallbuy_weapons.size + 1);
			}
			clientfield::register("world", clientFieldName + "_idx", 1, bits, "int");
			spawn_list[i].clientFieldName = clientFieldName;
			continue;
		}
		if(!isinarray(level.var_47a8a2a5, spawn_list[i].weapon))
		{
			unitrigger_stub = spawnstruct();
			unitrigger_stub.origin = spawn_list[i].origin;
			unitrigger_stub.angles = spawn_list[i].angles;
			tempModel.origin = spawn_list[i].origin;
			tempModel.angles = spawn_list[i].angles;
			mins = undefined;
			maxs = undefined;
			absmins = undefined;
			absmaxs = undefined;
			tempModel setmodel(target_struct.model);
			tempModel UseWeaponHideTags(spawn_list[i].weapon);
			mins = tempModel getmins();
			maxs = tempModel getmaxs();
			absmins = tempModel GetAbsMins();
			absmaxs = tempModel GetAbsMaxs();
			bounds = absmaxs - absmins;
			unitrigger_stub.script_length = bounds[0] * 0.25;
			unitrigger_stub.script_width = bounds[1];
			unitrigger_stub.script_height = bounds[2];
			unitrigger_stub.origin = unitrigger_stub.origin - anglestoright(unitrigger_stub.angles) * unitrigger_stub.script_length * 0.4;
			unitrigger_stub.target = spawn_list[i].target;
			unitrigger_stub.targetname = spawn_list[i].targetname;
			unitrigger_stub.cursor_hint = "HINT_NOICON";
			if(spawn_list[i].targetname == "weapon_upgrade")
			{
				unitrigger_stub.cost = get_weapon_cost(spawn_list[i].weapon);
				unitrigger_stub.hint_string = get_weapon_hint(spawn_list[i].weapon);
				if(!(isdefined(level.weapon_cost_client_filled) && level.weapon_cost_client_filled))
				{
					unitrigger_stub.hint_parm1 = unitrigger_stub.cost;
				}
				unitrigger_stub.cursor_hint = "HINT_WEAPON";
				unitrigger_stub.cursor_hint_weapon = spawn_list[i].weapon;
			}
			unitrigger_stub.weapon = spawn_list[i].weapon;
			unitrigger_stub.script_unitrigger_type = "unitrigger_box_use";
			if(isdefined(spawn_list[i].script_string) && (isdefined(int(spawn_list[i].script_string)) && int(spawn_list[i].script_string)))
			{
				unitrigger_stub.require_look_toward = 0;
				unitrigger_stub.require_look_at = 0;
				unitrigger_stub.script_unitrigger_type = "unitrigger_box_use";
				unitrigger_stub.script_length = bounds[0] * 0.4;
				unitrigger_stub.script_width = bounds[1] * 2;
				unitrigger_stub.script_height = bounds[2];
			}
			else
			{
				unitrigger_stub.require_look_at = 1;
			}
			if(isdefined(spawn_list[i].require_look_from) && spawn_list[i].require_look_from)
			{
				unitrigger_stub.require_look_from = 1;
			}
			unitrigger_stub.clientFieldName = clientFieldName;
			zm_unitrigger::unitrigger_force_per_player_triggers(unitrigger_stub, 1);
			if(unitrigger_stub.weapon.isMeleeWeapon || unitrigger_stub.weapon.isgrenadeweapon)
			{
				if(unitrigger_stub.weapon.name == "tazer_knuckles" && isdefined(level.taser_trig_adjustment))
				{
					unitrigger_stub.origin = unitrigger_stub.origin + level.taser_trig_adjustment;
				}
				zm_unitrigger::register_static_unitrigger(unitrigger_stub, &weapon_spawn_think);
			}
			else
			{
				unitrigger_stub.prompt_and_visibility_func = &wall_weapon_update_prompt;
				zm_unitrigger::register_static_unitrigger(unitrigger_stub, &weapon_spawn_think);
			}
			spawn_list[i].trigger_stub = unitrigger_stub;
		}
	}
	level._spawned_wallbuys = spawn_list;
	tempModel delete();
	return;
}

/*
	Name: add_dynamic_wallbuy
	Namespace: zm_weapons
	Checksum: 0x424F4353
	Offset: 0x42C8
	Size: 0x768
	Parameters: 3
	Flags: None
	Line Number: 1304
*/
function add_dynamic_wallbuy(weapon, wallbuy, pristine)
{
	if(!isinarray(level.var_47a8a2a5, weapon))
	{
		spawned_wallbuy = undefined;
		for(i = 0; i < level._spawned_wallbuys.size; i++)
		{
			if(level._spawned_wallbuys[i].target == wallbuy)
			{
				spawned_wallbuy = level._spawned_wallbuys[i];
				break;
			}
		}
		if(!isdefined(spawned_wallbuy))
		{
			/#
				assertmsg("Dev Block strings are not supported");
				return;
			#/
		}
		if(isdefined(spawned_wallbuy.trigger_stub))
		{
			/#
				assertmsg("Dev Block strings are not supported");
				return;
			#/
		}
		target_struct = struct::get(wallbuy, "targetname");
		wallModel = zm_utility::spawn_weapon_model(weapon, undefined, target_struct.origin, target_struct.angles, undefined);
		clientFieldName = spawned_wallbuy.clientFieldName;
		model = weapon.worldmodel;
		unitrigger_stub = spawnstruct();
		unitrigger_stub.origin = target_struct.origin;
		unitrigger_stub.angles = target_struct.angles;
		wallModel.origin = target_struct.origin;
		wallModel.angles = target_struct.angles;
		mins = undefined;
		maxs = undefined;
		absmins = undefined;
		absmaxs = undefined;
		wallModel setmodel(model);
		wallModel UseWeaponHideTags(weapon);
		mins = wallModel getmins();
		maxs = wallModel getmaxs();
		absmins = wallModel GetAbsMins();
		absmaxs = wallModel GetAbsMaxs();
		bounds = absmaxs - absmins;
		unitrigger_stub.script_length = bounds[0] * 0.25;
		unitrigger_stub.script_width = bounds[1];
		unitrigger_stub.script_height = bounds[2];
		unitrigger_stub.origin = unitrigger_stub.origin - anglestoright(unitrigger_stub.angles) * unitrigger_stub.script_length * 0.4;
		unitrigger_stub.target = spawned_wallbuy.target;
		unitrigger_stub.targetname = "weapon_upgrade";
		unitrigger_stub.cursor_hint = "HINT_NOICON";
		unitrigger_stub.first_time_triggered = !pristine;
		if(!weapon.isMeleeWeapon)
		{
			if(pristine || zm_utility::is_placeable_mine(weapon))
			{
				unitrigger_stub.hint_string = get_weapon_hint(weapon);
			}
			else
			{
				unitrigger_stub.hint_string = get_weapon_hint_ammo();
			}
			unitrigger_stub.cost = get_weapon_cost(weapon);
			if(!(isdefined(level.weapon_cost_client_filled) && level.weapon_cost_client_filled))
			{
				unitrigger_stub.hint_parm1 = unitrigger_stub.cost;
			}
		}
		unitrigger_stub.weapon = weapon;
		unitrigger_stub.weapon_upgrade = weapon;
		unitrigger_stub.script_unitrigger_type = "unitrigger_box_use";
		unitrigger_stub.require_look_at = 1;
		unitrigger_stub.clientFieldName = clientFieldName;
		zm_unitrigger::unitrigger_force_per_player_triggers(unitrigger_stub, 1);
		if(weapon.isMeleeWeapon)
		{
			if(weapon == "tazer_knuckles" && isdefined(level.taser_trig_adjustment))
			{
				unitrigger_stub.origin = unitrigger_stub.origin + level.taser_trig_adjustment;
			}
			zm_melee_weapon::add_stub(unitrigger_stub, weapon);
			zm_unitrigger::register_static_unitrigger(unitrigger_stub, &zm_melee_weapon::melee_weapon_think);
		}
		else
		{
			unitrigger_stub.prompt_and_visibility_func = &wall_weapon_update_prompt;
			zm_unitrigger::register_static_unitrigger(unitrigger_stub, &weapon_spawn_think);
		}
		spawned_wallbuy.trigger_stub = unitrigger_stub;
		weaponIdx = undefined;
		if(isdefined(level.buildable_wallbuy_weapons))
		{
			for(i = 0; i < level.buildable_wallbuy_weapons.size; i++)
			{
				if(weapon == level.buildable_wallbuy_weapons[i])
				{
					weaponIdx = i;
					break;
				}
			}
		}
		else if(isdefined(weaponIdx))
		{
			level clientfield::set(clientFieldName + "_idx", weaponIdx + 1);
			wallModel delete();
			if(!pristine)
			{
				level clientfield::set(clientFieldName, 1);
			}
		}
		else
		{
			level clientfield::set(clientFieldName, 1);
			wallModel show();
		}
	}
}

/*
	Name: wall_weapon_update_prompt
	Namespace: zm_weapons
	Checksum: 0x424F4353
	Offset: 0x4A38
	Size: 0x738
	Parameters: 1
	Flags: None
	Line Number: 1435
*/
function wall_weapon_update_prompt(player)
{
	weapon = self.stub.weapon;
	player_has_weapon = player has_weapon_or_upgrade(weapon);
	if(!player_has_weapon && (isdefined(level.weapons_using_ammo_sharing) && level.weapons_using_ammo_sharing))
	{
		shared_ammo_weapon = player get_shared_ammo_weapon(self.zombie_weapon_upgrade);
		if(isdefined(shared_ammo_weapon))
		{
			weapon = shared_ammo_weapon;
			player_has_weapon = 1;
		}
	}
	if(isdefined(level.func_override_wallbuy_prompt))
	{
		if(!self [[level.func_override_wallbuy_prompt]](player))
		{
			return 0;
		}
	}
	if(!player_has_weapon)
	{
		self.stub.cursor_hint = "HINT_WEAPON";
		cost = get_weapon_cost(weapon);
		if(isdefined(level.weapon_cost_client_filled) && level.weapon_cost_client_filled)
		{
			if(player bgb::is_enabled("zm_bgb_secret_shopper") && !is_wonder_weapon(player.currentweapon) && player.currentweapon.type !== "melee")
			{
				self.stub.hint_string = &"ZOMBIE_WEAPONCOSTONLY_CFILL_BGB_SECRET_SHOPPER";
				self sethintstring(self.stub.hint_string);
			}
			else
			{
				self.stub.hint_string = &"ZOMBIE_WEAPONCOSTONLY_CFILL";
				self sethintstring(self.stub.hint_string);
			}
		}
		else if(player bgb::is_enabled("zm_bgb_secret_shopper") && !is_wonder_weapon(player.currentweapon) && player.currentweapon.type !== "melee")
		{
			self.stub.hint_string = &"ZOMBIE_WEAPONCOSTONLYFILL_BGB_SECRET_SHOPPER";
			n_bgb_cost = player get_ammo_cost_for_weapon(player.currentweapon);
			self sethintstring(self.stub.hint_string, cost, n_bgb_cost);
		}
		else
		{
			self.stub.hint_string = &"ZOMBIE_WEAPONCOSTONLYFILL";
			self sethintstring(self.stub.hint_string, cost);
		}
	}
	else if(player bgb::is_enabled("zm_bgb_secret_shopper") && !is_wonder_weapon(player.currentweapon) && player.currentweapon.type !== "melee")
	{
		ammo_cost = player get_ammo_cost_for_weapon(weapon);
	}
	else if(player has_upgrade(weapon) && self.stub.hacked !== 1)
	{
		ammo_cost = get_upgraded_ammo_cost(weapon);
	}
	else
	{
		ammo_cost = get_ammo_cost(weapon);
	}
	if(isdefined(level.weapon_cost_client_filled) && level.weapon_cost_client_filled)
	{
		if(player bgb::is_enabled("zm_bgb_secret_shopper") && !is_wonder_weapon(player.currentweapon) && player.currentweapon.type !== "melee")
		{
			if(isdefined(self.stub.hacked) && self.stub.hacked)
			{
				self.stub.hint_string = &"ZOMBIE_WEAPONAMMOHACKED_CFILL_BGB_SECRET_SHOPPER";
			}
			else
			{
				self.stub.hint_string = &"ZOMBIE_WEAPONAMMOONLY_CFILL_BGB_SECRET_SHOPPER";
			}
			self sethintstring(self.stub.hint_string);
		}
		else if(isdefined(self.stub.hacked) && self.stub.hacked)
		{
			self.stub.hint_string = &"ZOMBIE_WEAPONAMMOHACKED_CFILL";
		}
		else
		{
			self.stub.hint_string = &"ZOMBIE_WEAPONAMMOONLY_CFILL";
		}
		self sethintstring(self.stub.hint_string);
	}
	else if(player bgb::is_enabled("zm_bgb_secret_shopper") && !is_wonder_weapon(player.currentweapon) && player.currentweapon.type !== "melee")
	{
		self.stub.hint_string = &"ZOMBIE_WEAPONAMMOONLY_BGB_SECRET_SHOPPER";
		n_bgb_cost = player get_ammo_cost_for_weapon(player.currentweapon);
		self sethintstring(self.stub.hint_string, ammo_cost, n_bgb_cost);
	}
	else
	{
		self.stub.hint_string = &"ZOMBIE_WEAPONAMMOONLY";
		self sethintstring(self.stub.hint_string, ammo_cost);
	}
	self.stub.cursor_hint = "HINT_WEAPON";
	self.stub.cursor_hint_weapon = weapon;
	self setcursorhint(self.stub.cursor_hint, self.stub.cursor_hint_weapon);
	return 1;
}

/*
	Name: reset_wallbuy_internal
	Namespace: zm_weapons
	Checksum: 0x424F4353
	Offset: 0x5178
	Size: 0xF8
	Parameters: 1
	Flags: None
	Line Number: 1547
*/
function reset_wallbuy_internal(set_hint_string)
{
	if(isdefined(self.first_time_triggered) && self.first_time_triggered)
	{
		self.first_time_triggered = 0;
		if(isdefined(self.clientFieldName))
		{
			level clientfield::set(self.clientFieldName, 0);
		}
		if(set_hint_string)
		{
			hint_string = get_weapon_hint(self.weapon);
			cost = get_weapon_cost(self.weapon);
			if(isdefined(level.weapon_cost_client_filled) && level.weapon_cost_client_filled)
			{
				self sethintstring(hint_string);
			}
			else
			{
				self sethintstring(hint_string, cost);
			}
		}
	}
}

/*
	Name: reset_wallbuys
	Namespace: zm_weapons
	Checksum: 0x424F4353
	Offset: 0x5278
	Size: 0x3F8
	Parameters: 0
	Flags: None
	Line Number: 1582
*/
function reset_wallbuys()
{
	weapon_spawns = [];
	weapon_spawns = getentarray("weapon_upgrade", "targetname");
	melee_and_grenade_spawns = [];
	melee_and_grenade_spawns = getentarray("bowie_upgrade", "targetname");
	melee_and_grenade_spawns = arraycombine(melee_and_grenade_spawns, getentarray("sickle_upgrade", "targetname"), 1, 0);
	melee_and_grenade_spawns = arraycombine(melee_and_grenade_spawns, getentarray("tazer_upgrade", "targetname"), 1, 0);
	if(!(isdefined(level.headshots_only) && level.headshots_only))
	{
		melee_and_grenade_spawns = arraycombine(melee_and_grenade_spawns, getentarray("claymore_purchase", "targetname"), 1, 0);
	}
	for(i = 0; i < weapon_spawns.size; i++)
	{
		weapon_spawns[i].weapon = getweapon(weapon_spawns[i].zombie_weapon_upgrade);
		weapon_spawns[i] reset_wallbuy_internal(1);
	}
	for(i = 0; i < melee_and_grenade_spawns.size; i++)
	{
		melee_and_grenade_spawns[i].weapon = getweapon(melee_and_grenade_spawns[i].zombie_weapon_upgrade);
		melee_and_grenade_spawns[i] reset_wallbuy_internal(0);
	}
	if(isdefined(level._unitriggers))
	{
		candidates = [];
		for(i = 0; i < level._unitriggers.trigger_stubs.size; i++)
		{
			stub = level._unitriggers.trigger_stubs[i];
			tn = stub.targetname;
			if(tn == "weapon_upgrade" || tn == "bowie_upgrade" || tn == "sickle_upgrade" || tn == "tazer_upgrade" || tn == "claymore_purchase")
			{
				stub.first_time_triggered = 0;
				if(isdefined(stub.clientFieldName))
				{
					level clientfield::set(stub.clientFieldName, 0);
				}
				if(tn == "weapon_upgrade")
				{
					stub.hint_string = get_weapon_hint(stub.weapon);
					stub.cost = get_weapon_cost(stub.weapon);
					if(!(isdefined(level.weapon_cost_client_filled) && level.weapon_cost_client_filled))
					{
						stub.hint_parm1 = stub.cost;
					}
				}
			}
		}
	}
}

/*
	Name: init_weapon_upgrade
	Namespace: zm_weapons
	Checksum: 0x424F4353
	Offset: 0x5678
	Size: 0x258
	Parameters: 0
	Flags: None
	Line Number: 1642
*/
function init_weapon_upgrade()
{
	init_spawnable_weapon_upgrade();
	weapon_spawns = [];
	weapon_spawns = getentarray("weapon_upgrade", "targetname");
	for(i = 0; i < weapon_spawns.size; i++)
	{
		weapon_spawns[i].weapon = getweapon(weapon_spawns[i].zombie_weapon_upgrade);
		hint_string = get_weapon_hint(weapon_spawns[i].weapon);
		cost = get_weapon_cost(weapon_spawns[i].weapon);
		if(isdefined(level.weapon_cost_client_filled) && level.weapon_cost_client_filled)
		{
			weapon_spawns[i] sethintstring(hint_string);
		}
		else
		{
			weapon_spawns[i] sethintstring(hint_string, cost);
		}
		weapon_spawns[i] setcursorhint("HINT_NOICON");
		weapon_spawns[i] usetriggerrequirelookat();
		weapon_spawns[i] thread weapon_spawn_think();
		model = getent(weapon_spawns[i].target, "targetname");
		if(isdefined(model))
		{
			model UseWeaponHideTags(weapon_spawns[i].weapon);
			model hide();
		}
	}
}

/*
	Name: get_weapon_hint
	Namespace: zm_weapons
	Checksum: 0x424F4353
	Offset: 0x58D8
	Size: 0x60
	Parameters: 1
	Flags: None
	Line Number: 1682
*/
function get_weapon_hint(weapon)
{
	/#
		Assert(isdefined(level.zombie_weapons[weapon]), weapon.name + "Dev Block strings are not supported");
	#/
	return level.zombie_weapons[weapon].hint;
}

/*
	Name: get_weapon_cost
	Namespace: zm_weapons
	Checksum: 0x424F4353
	Offset: 0x5940
	Size: 0x60
	Parameters: 1
	Flags: None
	Line Number: 1700
*/
function get_weapon_cost(weapon)
{
	/#
		Assert(isdefined(level.zombie_weapons[weapon]), weapon.name + "Dev Block strings are not supported");
	#/
	return level.zombie_weapons[weapon].cost;
}

/*
	Name: get_ammo_cost
	Namespace: zm_weapons
	Checksum: 0x424F4353
	Offset: 0x59A8
	Size: 0x60
	Parameters: 1
	Flags: None
	Line Number: 1718
*/
function get_ammo_cost(weapon)
{
	/#
		Assert(isdefined(level.zombie_weapons[weapon]), weapon.name + "Dev Block strings are not supported");
	#/
	return level.zombie_weapons[weapon].ammo_cost;
	ERROR: Exception occured: Stack empty.
}

/*
	Name: get_upgraded_ammo_cost
	Namespace: zm_weapons
	Checksum: 0x424F4353
	Offset: 0x5A10
	Size: 0x60
	Parameters: 1
	Flags: None
	Line Number: 1737
*/
function get_upgraded_ammo_cost(weapon)
{
	/#
		Assert(isdefined(level.zombie_weapons[weapon]), weapon.name + "Dev Block strings are not supported");
	#/
	return level.zombie_weapons[weapon].upgraded_ammo_cost;
	return 4500;
}

/*
	Name: get_ammo_cost_for_weapon
	Namespace: zm_weapons
	Checksum: 0x424F4353
	Offset: 0x5A78
	Size: 0x158
	Parameters: 3
	Flags: None
	Line Number: 1756
*/
function get_ammo_cost_for_weapon(w_current, n_base_non_wallbuy_cost, n_upgraded_non_wallbuy_cost)
{
	if(!isdefined(n_base_non_wallbuy_cost))
	{
		n_base_non_wallbuy_cost = 750;
	}
	if(!isdefined(n_upgraded_non_wallbuy_cost))
	{
		n_upgraded_non_wallbuy_cost = 5000;
	}
	w_root = w_current.rootweapon;
	if(is_weapon_upgraded(w_root))
	{
		w_root = get_base_weapon(w_root);
	}
	if(self has_upgrade(w_root))
	{
		if(is_wallbuy(w_root))
		{
			n_ammo_cost = 4000;
		}
		else
		{
			n_ammo_cost = n_upgraded_non_wallbuy_cost;
		}
	}
	else if(is_wallbuy(w_root))
	{
		n_ammo_cost = get_ammo_cost(w_root);
		n_ammo_cost = zm_utility::halve_score(n_ammo_cost);
	}
	else
	{
		n_ammo_cost = n_base_non_wallbuy_cost;
	}
	return n_ammo_cost;
}

/*
	Name: get_is_in_box
	Namespace: zm_weapons
	Checksum: 0x424F4353
	Offset: 0x5BD8
	Size: 0x60
	Parameters: 1
	Flags: None
	Line Number: 1804
*/
function get_is_in_box(weapon)
{
	/#
		Assert(isdefined(level.zombie_weapons[weapon]), weapon.name + "Dev Block strings are not supported");
	#/
	return level.zombie_weapons[weapon].is_in_box;
}

/*
	Name: get_force_attachments
	Namespace: zm_weapons
	Checksum: 0x424F4353
	Offset: 0x5C40
	Size: 0x60
	Parameters: 1
	Flags: None
	Line Number: 1822
*/
function get_force_attachments(weapon)
{
	/#
		Assert(isdefined(level.zombie_weapons[weapon]), weapon.name + "Dev Block strings are not supported");
	#/
	return level.zombie_weapons[weapon].force_attachments;
}

/*
	Name: weapon_supports_default_attachment
	Namespace: zm_weapons
	Checksum: 0x424F4353
	Offset: 0x5CA8
	Size: 0x58
	Parameters: 1
	Flags: None
	Line Number: 1840
*/
function weapon_supports_default_attachment(weapon)
{
	weapon = get_base_weapon(weapon);
	attachment = level.zombie_weapons[weapon].default_attachment;
	return isdefined(attachment);
}

/*
	Name: default_attachment
	Namespace: zm_weapons
	Checksum: 0x424F4353
	Offset: 0x5D08
	Size: 0x68
	Parameters: 1
	Flags: None
	Line Number: 1857
*/
function default_attachment(weapon)
{
	weapon = get_base_weapon(weapon);
	attachment = level.zombie_weapons[weapon].default_attachment;
	if(isdefined(attachment))
	{
		return attachment;
	}
	else
	{
		return "none";
	}
}

/*
	Name: weapon_supports_attachments
	Namespace: zm_weapons
	Checksum: 0x424F4353
	Offset: 0x5D78
	Size: 0x68
	Parameters: 1
	Flags: None
	Line Number: 1881
*/
function weapon_supports_attachments(weapon)
{
	weapon = get_base_weapon(weapon);
	attachments = level.zombie_weapons[weapon].addon_attachments;
	return isdefined(attachments) && attachments.size > 1;
}

/*
	Name: random_attachment
	Namespace: zm_weapons
	Checksum: 0x424F4353
	Offset: 0x5DE8
	Size: 0x168
	Parameters: 2
	Flags: None
	Line Number: 1898
*/
function random_attachment(weapon, exclude)
{
	lo = 0;
	if(isdefined(level.zombie_weapons[weapon].addon_attachments) && level.zombie_weapons[weapon].addon_attachments.size > 0)
	{
		attachments = level.zombie_weapons[weapon].addon_attachments;
	}
	else
	{
		attachments = weapon.supportedattachments;
		lo = 1;
	}
	minatt = lo;
	if(isdefined(exclude) && exclude != "none")
	{
		minatt = lo + 1;
	}
	if(attachments.size > minatt)
	{
		while(1)
		{
			idx = randomint(attachments.size - lo) + lo;
			if(!isdefined(exclude) || attachments[idx] != exclude)
			{
				return attachments[idx];
			}
		}
	}
	return "none";
}

/*
	Name: get_attachment_index
	Namespace: zm_weapons
	Checksum: 0x424F4353
	Offset: 0x5F58
	Size: 0x128
	Parameters: 1
	Flags: None
	Line Number: 1939
*/
function get_attachment_index(weapon)
{
	attachments = weapon.attachments;
	if(!attachments.size)
	{
		return -1;
	}
	weapon = get_nonalternate_weapon(weapon);
	base = weapon.rootweapon;
	if(attachments[0] == level.zombie_weapons[base].default_attachment)
	{
		return 0;
	}
	if(isdefined(level.zombie_weapons[base].addon_attachments))
	{
		for(i = 0; i < level.zombie_weapons[base].addon_attachments.size; i++)
		{
			if(level.zombie_weapons[base].addon_attachments[i] == attachments[0])
			{
				return i + 1;
			}
		}
	}
	return -1;
}

/*
	Name: weapon_supports_this_attachment
	Namespace: zm_weapons
	Checksum: 0x424F4353
	Offset: 0x6088
	Size: 0x100
	Parameters: 2
	Flags: None
	Line Number: 1975
*/
function weapon_supports_this_attachment(weapon, att)
{
	weapon = get_nonalternate_weapon(weapon);
	base = weapon.rootweapon;
	if(att == level.zombie_weapons[base].default_attachment)
	{
		return 1;
	}
	if(isdefined(level.zombie_weapons[base].addon_attachments))
	{
		for(i = 0; i < level.zombie_weapons[base].addon_attachments.size; i++)
		{
			if(level.zombie_weapons[base].addon_attachments[i] == att)
			{
				return 1;
			}
		}
	}
	return 0;
}

/*
	Name: get_base_weapon
	Namespace: zm_weapons
	Checksum: 0x424F4353
	Offset: 0x6190
	Size: 0x68
	Parameters: 1
	Flags: None
	Line Number: 2006
*/
function get_base_weapon(upgradedweapon)
{
	upgradedweapon = get_nonalternate_weapon(upgradedweapon);
	upgradedweapon = upgradedweapon.rootweapon;
	if(isdefined(level.zombie_weapons_upgraded[upgradedweapon]))
	{
		return level.zombie_weapons_upgraded[upgradedweapon];
	}
	return upgradedweapon;
}

/*
	Name: get_upgrade_weapon
	Namespace: zm_weapons
	Checksum: 0x424F4353
	Offset: 0x6200
	Size: 0x1F0
	Parameters: 2
	Flags: None
	Line Number: 2027
*/
function get_upgrade_weapon(weapon, add_attachment)
{
	weapon = get_nonalternate_weapon(weapon);
	rootweapon = weapon.rootweapon;
	newweapon = rootweapon;
	baseWeapon = get_base_weapon(weapon);
	if(!is_weapon_upgraded(rootweapon))
	{
		newweapon = level.zombie_weapons[rootweapon].upgrade;
	}
	if(isdefined(add_attachment) && add_attachment && zm_pap_util::can_swap_attachments())
	{
		oldatt = "none";
		if(weapon.attachments.size)
		{
			oldatt = weapon.attachments[0];
		}
		att = random_attachment(baseWeapon, oldatt);
		newweapon = getweapon(newweapon.name, att);
	}
	else if(isdefined(level.zombie_weapons[rootweapon]) && isdefined(level.zombie_weapons[rootweapon].default_attachment))
	{
		att = level.zombie_weapons[rootweapon].default_attachment;
		newweapon = getweapon(newweapon.name, att);
	}
	return newweapon;
}

/*
	Name: can_upgrade_weapon
	Namespace: zm_weapons
	Checksum: 0x424F4353
	Offset: 0x63F8
	Size: 0xF0
	Parameters: 1
	Flags: None
	Line Number: 2065
*/
function can_upgrade_weapon(weapon)
{
	if(weapon == level.weaponnone || weapon == level.weaponZMFists || !is_weapon_included(weapon))
	{
		return 0;
	}
	weapon = get_nonalternate_weapon(weapon);
	rootweapon = weapon.rootweapon;
	if(!is_weapon_upgraded(rootweapon))
	{
		return isdefined(level.zombie_weapons[rootweapon].upgrade);
	}
	if(zm_pap_util::can_swap_attachments() && weapon_supports_attachments(rootweapon))
	{
		return 1;
	}
	return 0;
	ERROR: Bad function call
}

/*
	Name: weapon_supports_aat
	Namespace: zm_weapons
	Checksum: 0x424F4353
	Offset: 0x64F0
	Size: 0xB0
	Parameters: 1
	Flags: None
	Line Number: 2095
*/
function weapon_supports_aat(weapon)
{
	if(weapon == level.weaponnone || weapon == level.weaponZMFists)
	{
		return 0;
	}
	weaponToPack = get_nonalternate_weapon(weapon);
	rootweapon = weaponToPack.rootweapon;
	if(!is_weapon_upgraded(rootweapon))
	{
		return 0;
	}
	if(!aat::is_exempt_weapon(weaponToPack))
	{
		return 1;
	}
	return 0;
}

/*
	Name: is_weapon_upgraded
	Namespace: zm_weapons
	Checksum: 0x424F4353
	Offset: 0x65A8
	Size: 0x80
	Parameters: 1
	Flags: None
	Line Number: 2124
*/
function is_weapon_upgraded(weapon)
{
	if(weapon == level.weaponnone || weapon == level.weaponZMFists)
	{
		return 0;
	}
	weapon = get_nonalternate_weapon(weapon);
	rootweapon = weapon.rootweapon;
	if(isdefined(level.zombie_weapons_upgraded[rootweapon]))
	{
		return 1;
	}
	return 0;
}

/*
	Name: get_weapon_with_attachments
	Namespace: zm_weapons
	Checksum: 0x424F4353
	Offset: 0x6630
	Size: 0x180
	Parameters: 1
	Flags: None
	Line Number: 2149
*/
function get_weapon_with_attachments(weapon)
{
	weapon = get_nonalternate_weapon(weapon);
	if(self hasweapon(weapon.rootweapon, 1))
	{
		upgraded = is_weapon_upgraded(weapon);
		if(is_weapon_included(weapon))
		{
			force_attachments = get_force_attachments(weapon.rootweapon);
		}
		if(isdefined(force_attachments) && force_attachments.size)
		{
			if(upgraded)
			{
				packed_attachments = [];
				packed_attachments[packed_attachments.size] = "extclip";
				packed_attachments[packed_attachments.size] = "fmj";
				force_attachments = arraycombine(force_attachments, packed_attachments, 0, 0);
			}
			return getweapon(weapon.rootweapon.name, force_attachments);
		}
		else
		{
			return self getbuildkitweapon(weapon.rootweapon, upgraded);
		}
	}
	return undefined;
	ERROR: Bad function call
}

/*
	Name: has_weapon_or_attachments
	Namespace: zm_weapons
	Checksum: 0x424F4353
	Offset: 0x67B8
	Size: 0x118
	Parameters: 1
	Flags: None
	Line Number: 2189
*/
function has_weapon_or_attachments(weapon)
{
	if(self hasweapon(weapon, 1))
	{
		return 1;
	}
	if(zm_pap_util::can_swap_attachments())
	{
		rootweapon = weapon.rootweapon;
		weapons = self getweaponslist(1);
		foreach(w in weapons)
		{
			if(rootweapon == w.rootweapon)
			{
				return 1;
			}
		}
	}
	return 0;
}

/*
	Name: has_upgrade
	Namespace: zm_weapons
	Checksum: 0x424F4353
	Offset: 0x68D8
	Size: 0xF8
	Parameters: 1
	Flags: None
	Line Number: 2220
*/
function has_upgrade(weapon)
{
	weapon = get_nonalternate_weapon(weapon);
	rootweapon = weapon.rootweapon;
	has_upgrade = 0;
	if(isdefined(level.zombie_weapons[rootweapon]) && isdefined(level.zombie_weapons[rootweapon].upgrade))
	{
		has_upgrade = self has_weapon_or_attachments(level.zombie_weapons[rootweapon].upgrade);
	}
	if(!has_upgrade && rootweapon.isBallisticKnife)
	{
		has_weapon = self zm_melee_weapon::has_upgraded_ballistic_knife();
	}
	return has_upgrade;
}

/*
	Name: has_weapon_or_upgrade
	Namespace: zm_weapons
	Checksum: 0x424F4353
	Offset: 0x69D8
	Size: 0x178
	Parameters: 1
	Flags: None
	Line Number: 2246
*/
function has_weapon_or_upgrade(weapon)
{
	weapon = get_nonalternate_weapon(weapon);
	rootweapon = weapon.rootweapon;
	upgradedweaponname = rootweapon;
	if(isdefined(level.zombie_weapons[rootweapon]) && isdefined(level.zombie_weapons[rootweapon].upgrade))
	{
		upgradedweaponname = level.zombie_weapons[rootweapon].upgrade;
	}
	has_weapon = 0;
	if(isdefined(level.zombie_weapons[rootweapon]))
	{
		has_weapon = self has_weapon_or_attachments(rootweapon) || self has_upgrade(rootweapon);
	}
	if(!has_weapon && level.weaponBallisticKnife == rootweapon)
	{
		has_weapon = self zm_melee_weapon::has_any_ballistic_knife();
	}
	if(!has_weapon && zm_equipment::is_equipment(rootweapon))
	{
		has_weapon = self zm_equipment::is_active(rootweapon);
	}
	return has_weapon;
}

/*
	Name: add_shared_ammo_weapon
	Namespace: zm_weapons
	Checksum: 0x424F4353
	Offset: 0x6B58
	Size: 0x30
	Parameters: 2
	Flags: None
	Line Number: 2281
*/
function add_shared_ammo_weapon(weapon, base_weapon)
{
	level.zombie_weapons[weapon].shared_ammo_weapon = base_weapon;
}

/*
	Name: get_shared_ammo_weapon
	Namespace: zm_weapons
	Checksum: 0x424F4353
	Offset: 0x6B90
	Size: 0x180
	Parameters: 1
	Flags: None
	Line Number: 2296
*/
function get_shared_ammo_weapon(weapon)
{
	weapon = get_nonalternate_weapon(weapon);
	rootweapon = weapon.rootweapon;
	weapons = self getweaponslist(1);
	foreach(w in weapons)
	{
		w = w.rootweapon;
		if(!isdefined(level.zombie_weapons[w]) && isdefined(level.zombie_weapons_upgraded[w]))
		{
			w = level.zombie_weapons_upgraded[w];
		}
		if(isdefined(level.zombie_weapons[w]) && isdefined(level.zombie_weapons[w].shared_ammo_weapon) && level.zombie_weapons[w].shared_ammo_weapon == rootweapon)
		{
			return w;
		}
	}
	return undefined;
}

/*
	Name: get_player_weapon_with_same_base
	Namespace: zm_weapons
	Checksum: 0x424F4353
	Offset: 0x6D18
	Size: 0x118
	Parameters: 1
	Flags: None
	Line Number: 2326
*/
function get_player_weapon_with_same_base(weapon)
{
	weapon = get_nonalternate_weapon(weapon);
	rootweapon = weapon.rootweapon;
	retweapon = self get_weapon_with_attachments(rootweapon);
	if(!isdefined(retweapon))
	{
		if(isdefined(level.zombie_weapons[rootweapon]))
		{
			if(isdefined(level.zombie_weapons[rootweapon].upgrade))
			{
				retweapon = self get_weapon_with_attachments(level.zombie_weapons[rootweapon].upgrade);
			}
		}
		else if(isdefined(level.zombie_weapons_upgraded[rootweapon]))
		{
			retweapon = self get_weapon_with_attachments(level.zombie_weapons_upgraded[rootweapon]);
		}
	}
	return retweapon;
}

/*
	Name: get_weapon_hint_ammo
	Namespace: zm_weapons
	Checksum: 0x424F4353
	Offset: 0x6E38
	Size: 0x78
	Parameters: 0
	Flags: None
	Line Number: 2358
*/
function get_weapon_hint_ammo()
{
	if(!(isdefined(level.obsolete_prompt_format_needed) && level.obsolete_prompt_format_needed))
	{
		if(isdefined(level.weapon_cost_client_filled) && level.weapon_cost_client_filled)
		{
			return &"ZOMBIE_WEAPONCOSTONLY_CFILL";
		}
		else
		{
			return &"ZOMBIE_WEAPONCOSTONLYFILL";
		}
	}
	else if(isdefined(level.has_pack_a_punch) && !level.has_pack_a_punch)
	{
		return &"ZOMBIE_WEAPONCOSTAMMO";
	}
	else
	{
		return &"ZOMBIE_WEAPONCOSTAMMO_UPGRADE";
	}
}

/*
	Name: weapon_set_first_time_hint
	Namespace: zm_weapons
	Checksum: 0x424F4353
	Offset: 0x6EB8
	Size: 0xC8
	Parameters: 2
	Flags: None
	Line Number: 2391
*/
function weapon_set_first_time_hint(cost, ammo_cost)
{
	if(!(isdefined(level.obsolete_prompt_format_needed) && level.obsolete_prompt_format_needed))
	{
		if(isdefined(level.weapon_cost_client_filled) && level.weapon_cost_client_filled)
		{
			self sethintstring(get_weapon_hint_ammo());
		}
		else
		{
			self sethintstring(get_weapon_hint_ammo(), cost, ammo_cost);
		}
	}
	else
	{
		self sethintstring(get_weapon_hint_ammo(), cost, ammo_cost);
	}
}

/*
	Name: placeable_mine_can_buy_weapon_extra_check_func
	Namespace: zm_weapons
	Checksum: 0x424F4353
	Offset: 0x6F88
	Size: 0x38
	Parameters: 1
	Flags: None
	Line Number: 2420
*/
function placeable_mine_can_buy_weapon_extra_check_func(w_weapon)
{
	if(isdefined(w_weapon) && w_weapon == self zm_utility::get_player_placeable_mine())
	{
		return 0;
	}
	return 1;
}

/*
	Name: weapon_spawn_think
	Namespace: zm_weapons
	Checksum: 0x424F4353
	Offset: 0x6FC8
	Size: 0x1020
	Parameters: 0
	Flags: None
	Line Number: 2439
*/
function weapon_spawn_think()
{
	cost = get_weapon_cost(self.weapon);
	ammo_cost = get_ammo_cost(self.weapon);
	is_grenade = self.weapon.isgrenadeweapon;
	shared_ammo_weapon = undefined;
	if(isdefined(self.parent_player) && !is_grenade)
	{
		self.parent_player notify("zm_bgb_secret_shopper", self);
	}
	second_endon = undefined;
	if(isdefined(self.stub))
	{
		second_endon = "kill_trigger";
		self.first_time_triggered = self.stub.first_time_triggered;
	}
	onlyplayer = undefined;
	can_buy_weapon_extra_check_func = undefined;
	if(isdefined(self.stub) && (isdefined(self.stub.trigger_per_player) && self.stub.trigger_per_player))
	{
		onlyplayer = self.parent_player;
		if(zm_utility::is_placeable_mine(self.weapon))
		{
			can_buy_weapon_extra_check_func = &placeable_mine_can_buy_weapon_extra_check_func;
		}
	}
	self thread zm_magicbox::decide_hide_show_hint("stop_hint_logic", second_endon, onlyplayer, can_buy_weapon_extra_check_func);
	if(is_grenade || zm_utility::is_melee_weapon(self.weapon))
	{
		self.first_time_triggered = 0;
		hint = get_weapon_hint(self.weapon);
		if(isdefined(level.weapon_cost_client_filled) && level.weapon_cost_client_filled)
		{
			self sethintstring(hint);
		}
		else
		{
			self sethintstring(hint, cost);
		}
		cursor_hint = "HINT_WEAPON";
		cursor_hint_weapon = self.weapon;
		self setcursorhint(cursor_hint, cursor_hint_weapon);
	}
	else if(!isdefined(self.first_time_triggered))
	{
		self.first_time_triggered = 0;
		if(isdefined(self.stub))
		{
			self.stub.first_time_triggered = 0;
		}
	}
	for(;;)
	{
		self waittill("trigger", player);
		if(!zm_utility::is_player_valid(player))
		{
			player thread zm_utility::ignore_triggers(0.5);
		}
		else if(!player zm_magicbox::can_buy_weapon())
		{
			wait(0.1);
		}
		else if(isdefined(self.stub) && (isdefined(self.stub.require_look_from) && self.stub.require_look_from))
		{
			toplayer = player util::get_eye() - self.origin;
			forward = -1 * anglestoright(self.angles);
			dot = vectordot(toplayer, forward);
			if(dot < 0)
			{
			}
		}
		else
		{
			wait(0.1);
			else
			{
				player_has_weapon = player has_weapon_or_upgrade(self.weapon);
				if(!player_has_weapon && (isdefined(level.weapons_using_ammo_sharing) && level.weapons_using_ammo_sharing))
				{
					shared_ammo_weapon = player get_shared_ammo_weapon(self.weapon);
					if(isdefined(shared_ammo_weapon))
					{
						player_has_weapon = 1;
					}
				}
				if(isdefined(level.pers_upgrade_nube) && level.pers_upgrade_nube)
				{
					player_has_weapon = zm_pers_upgrades_functions::pers_nube_should_we_give_raygun(player_has_weapon, player, self.weapon);
				}
				cost = get_weapon_cost(self.weapon);
				if(player zm_pers_upgrades_functions::is_pers_double_points_active())
				{
					cost = int(cost / 2);
				}
				if(isdefined(player.check_override_wallbuy_purchase))
				{
					if(player [[player.check_override_wallbuy_purchase]](self.weapon, self))
					{
					}
				}
				else
				{
					if(player zm_score::can_player_purchase(cost))
					{
						if(self.first_time_triggered == 0)
						{
							self show_all_weapon_buys(player, cost, ammo_cost, is_grenade);
						}
						player zm_score::minus_to_player_score(cost);
						level notify("weapon_bought", player, self.weapon);
						player zm_stats::increment_challenge_stat("SURVIVALIST_BUY_WALLBUY");
						if(self.weapon.isRiotShield)
						{
							player zm_equipment::give(self.weapon);
							if(isdefined(player.player_shield_reset_health))
							{
								player [[player.player_shield_reset_health]]();
							}
						}
						else if(zm_utility::is_lethal_grenade(self.weapon))
						{
							player weapon_take(player zm_utility::get_player_lethal_grenade());
							player zm_utility::set_player_lethal_grenade(self.weapon);
						}
						weapon = self.weapon;
						if(isdefined(level.pers_upgrade_nube) && level.pers_upgrade_nube)
						{
							weapon = zm_pers_upgrades_functions::pers_nube_weapon_upgrade_check(player, weapon);
						}
						var_5bc750f7 = should_upgrade_weapon(player);
						if(isdefined(var_5bc750f7) && var_5bc750f7)
						{
							if(player can_upgrade_weapon(weapon))
							{
								weapon = get_upgrade_weapon(weapon);
								player notify("zm_bgb_wall_power_used");
							}
						}
						if(isdefined(var_5bc750f7) && var_5bc750f7)
						{
							if(isdefined(player namespace_5e1f56dc::function_92bf1671(weapon)) && player namespace_5e1f56dc::function_92bf1671(weapon))
							{
								var_12030910 = get_upgrade_weapon(weapon, 0);
								var_12030910 = player getbuildkitweapon(var_12030910, 1);
								weapon = player weapon_give(var_12030910, 1, 1);
								var_a76169e6 = player namespace_5e1f56dc::function_49e2047b();
								player thread namespace_5e1f56dc::function_9c955ddd(var_a76169e6, weapon);
							}
							else
							{
								weapon = player weapon_give(weapon, 0, 1);
							}
						}
						else
						{
							weapon = player weapon_give(weapon, 0, 1);
						}
						if(isdefined(weapon))
						{
							player thread aat::remove(weapon);
						}
						player thread namespace_97ac1184::function_b3489bf5("^3" + player.playername + "^7 acquired a ^9" + makelocalizedstring(weapon.displayname) + " ^7from wallbuy");
						if(isdefined(weapon))
						{
							player zm_stats::increment_client_stat("wallbuy_weapons_purchased");
							player zm_stats::increment_player_stat("wallbuy_weapons_purchased");
							player thread namespace_97ac1184::function_7e18304e("spx_save_data", "wallbuy_weapons_purchased", player.pers["wallbuy_weapons_purchased"], 0);
							weaponIndex = undefined;
							if(isdefined(weaponIndex))
							{
								weaponIndex = MatchRecordGetWeaponIndex(weapon);
							}
							if(isdefined(weaponIndex))
							{
								player RecordMapEvent(6, GetTime(), player.origin, level.round_number, weaponIndex, cost);
							}
						}
					}
					else
					{
						zm_utility::play_sound_on_ent("no_purchase");
						player zm_audio::create_and_play_dialog("general", "outofmoney");
					}
					else
					{
						weapon = self.weapon;
						if(isdefined(shared_ammo_weapon))
						{
							weapon = shared_ammo_weapon;
						}
						if(isdefined(level.pers_upgrade_nube) && level.pers_upgrade_nube)
						{
							weapon = zm_pers_upgrades_functions::pers_nube_weapon_ammo_check(player, weapon);
						}
						if(isdefined(self.stub.hacked) && self.stub.hacked)
						{
							if(!player has_upgrade(weapon))
							{
								ammo_cost = 4500;
							}
							else
							{
								ammo_cost = get_ammo_cost(weapon);
							}
						}
						else if(player has_upgrade(weapon))
						{
							ammo_cost = 4500;
						}
						else
						{
							ammo_cost = get_ammo_cost(weapon);
						}
						if(isdefined(player.pers_upgrades_awarded["nube"]) && player.pers_upgrades_awarded["nube"])
						{
							ammo_cost = zm_pers_upgrades_functions::pers_nube_override_ammo_cost(player, self.weapon, ammo_cost);
						}
						if(player zm_pers_upgrades_functions::is_pers_double_points_active())
						{
							ammo_cost = int(ammo_cost / 2);
						}
						if(player bgb::is_enabled("zm_bgb_secret_shopper") && !is_wonder_weapon(weapon))
						{
							ammo_cost = player get_ammo_cost_for_weapon(weapon);
						}
						if(weapon.isRiotShield)
						{
							zm_utility::play_sound_on_ent("no_purchase");
						}
						else if(player zm_score::can_player_purchase(ammo_cost))
						{
							if(self.first_time_triggered == 0)
							{
								self show_all_weapon_buys(player, cost, ammo_cost, is_grenade);
							}
							if(player has_upgrade(weapon))
							{
								player zm_stats::increment_client_stat("upgraded_ammo_purchased");
								player zm_stats::increment_player_stat("upgraded_ammo_purchased");
								player thread namespace_97ac1184::function_1d39abf6("end_game_wallbuy_ammo_purchased", 1, 0);
								player thread namespace_97ac1184::function_7e18304e("spx_save_data", "wallbuy_ammo_purchased", player.pers["ammo_purchased"], 0);
							}
							else
							{
								player zm_stats::increment_client_stat("ammo_purchased");
								player zm_stats::increment_player_stat("ammo_purchased");
								player thread namespace_97ac1184::function_1d39abf6("end_game_wallbuy_ammo_purchased", 1, 0);
								player thread namespace_97ac1184::function_7e18304e("spx_save_data", "wallbuy_ammo_purchased", player.pers["ammo_purchased"], 0);
							}
							if(player has_upgrade(weapon))
							{
								ammo_given = player ammo_give(level.zombie_weapons[weapon].upgrade);
							}
							else
							{
								ammo_given = player ammo_give(weapon);
							}
							if(ammo_given)
							{
								player zm_score::minus_to_player_score(ammo_cost);
							}
							weaponIndex = undefined;
							if(isdefined(weapon))
							{
								weaponIndex = MatchRecordGetWeaponIndex(weapon);
							}
							if(isdefined(weaponIndex))
							{
								player RecordMapEvent(7, GetTime(), player.origin, level.round_number, weaponIndex, cost);
							}
						}
						else
						{
							zm_utility::play_sound_on_ent("no_purchase");
							if(isdefined(level.custom_generic_deny_vo_func))
							{
								player [[level.custom_generic_deny_vo_func]]();
							}
							else
							{
								player zm_audio::create_and_play_dialog("general", "outofmoney");
							}
						}
					}
					if(isdefined(self.stub) && isdefined(self.stub.prompt_and_visibility_func))
					{
						self [[self.stub.prompt_and_visibility_func]](player);
					}
				}
				else if(!player_has_weapon)
				{
				}
			}
		}
		else if(player zm_utility::has_powerup_weapon())
		{
		}
	}
}

/*
	Name: should_upgrade_weapon
	Namespace: zm_weapons
	Checksum: 0x424F4353
	Offset: 0x7FF0
	Size: 0xF8
	Parameters: 1
	Flags: None
	Line Number: 2749
*/
function should_upgrade_weapon(player)
{
	if(isdefined(level.wallbuy_should_upgrade_weapon_override))
	{
		return [[level.wallbuy_should_upgrade_weapon_override]]();
	}
	if(player bgb::is_enabled("zm_bgb_wall_power"))
	{
		return 1;
	}
	if(!(isdefined(level.var_2198e3c0) && level.var_2198e3c0))
	{
		return 0;
	}
	if(level.round_number >= 20 && level.round_number <= 36)
	{
		index = level.round_number - 19;
		if(randomintrange(0, 100) < index * 10)
		{
		}
		else
		{
			return 0;
		}
	}
	else if(level.round_number >= 37)
	{
		return 1;
	}
	return 0;
}

/*
	Name: show_all_weapon_buys
	Namespace: zm_weapons
	Checksum: 0x424F4353
	Offset: 0x80F0
	Size: 0x3B0
	Parameters: 4
	Flags: None
	Line Number: 2791
*/
function show_all_weapon_buys(player, cost, ammo_cost, is_grenade)
{
	model = getent(self.target, "targetname");
	is_melee = zm_utility::is_melee_weapon(self.weapon);
	if(isdefined(model))
	{
		model thread weapon_show(player);
	}
	else if(isdefined(self.clientFieldName))
	{
		level clientfield::set(self.clientFieldName, 1);
	}
	self.first_time_triggered = 1;
	if(isdefined(self.stub))
	{
		self.stub.first_time_triggered = 1;
	}
	if(!is_grenade && !is_melee)
	{
		self weapon_set_first_time_hint(cost, ammo_cost);
	}
	if(!(isdefined(level.dont_link_common_wallbuys) && level.dont_link_common_wallbuys) && isdefined(level._spawned_wallbuys))
	{
		for(i = 0; i < level._spawned_wallbuys.size; i++)
		{
			wallbuy = level._spawned_wallbuys[i];
			if(isdefined(self.stub) && isdefined(wallbuy.trigger_stub) && self.stub.clientFieldName == wallbuy.trigger_stub.clientFieldName)
			{
				continue;
			}
			if(self.weapon == wallbuy.weapon)
			{
				if(isdefined(wallbuy.trigger_stub) && isdefined(wallbuy.trigger_stub.clientFieldName))
				{
					level clientfield::set(wallbuy.trigger_stub.clientFieldName, 1);
				}
				else if(isdefined(wallbuy.target))
				{
					model = getent(wallbuy.target, "targetname");
					if(isdefined(model))
					{
						model thread weapon_show(player);
					}
				}
				if(isdefined(wallbuy.trigger_stub))
				{
					wallbuy.trigger_stub.first_time_triggered = 1;
					if(isdefined(wallbuy.trigger_stub.trigger))
					{
						wallbuy.trigger_stub.trigger.first_time_triggered = 1;
						if(!is_grenade && !is_melee)
						{
							wallbuy.trigger_stub.trigger weapon_set_first_time_hint(cost, ammo_cost);
							continue;
						}
					}
				}
				if(!is_grenade && !is_melee)
				{
					wallbuy weapon_set_first_time_hint(cost, ammo_cost);
				}
			}
		}
	}
}

/*
	Name: weapon_show
	Namespace: zm_weapons
	Checksum: 0x424F4353
	Offset: 0x84A8
	Size: 0x1B8
	Parameters: 1
	Flags: None
	Line Number: 2867
*/
function weapon_show(player)
{
	player_angles = vectortoangles(player.origin - self.origin);
	player_yaw = player_angles[1];
	weapon_yaw = self.angles[1];
	if(isdefined(self.script_int))
	{
		weapon_yaw = weapon_yaw - self.script_int;
	}
	yaw_diff = angleclamp180(player_yaw - weapon_yaw);
	if(yaw_diff > 0)
	{
		yaw = weapon_yaw - 90;
	}
	else
	{
		yaw = weapon_yaw + 90;
	}
	self.og_origin = self.origin;
	self.origin = self.origin + anglestoforward((0, yaw, 0)) * 8;
	wait(0.05);
	self show();
	zm_utility::play_sound_at_pos("weapon_show", self.origin, self);
	time = 1;
	if(!isdefined(self._linked_ent))
	{
		self moveto(self.og_origin, time);
		return;
	}
}

/*
	Name: get_pack_a_punch_camo_index
	Namespace: zm_weapons
	Checksum: 0x424F4353
	Offset: 0x8668
	Size: 0xB0
	Parameters: 1
	Flags: None
	Line Number: 2908
*/
function get_pack_a_punch_camo_index(prev_pap_index)
{
	if(isdefined(level.pack_a_punch_camo_index_number_variants))
	{
		if(isdefined(prev_pap_index))
		{
			camo_variant = prev_pap_index + 1;
			if(camo_variant >= level.pack_a_punch_camo_index + level.pack_a_punch_camo_index_number_variants)
			{
				camo_variant = level.pack_a_punch_camo_index;
			}
			return camo_variant;
		}
		else
		{
			camo_variant = randomintrange(0, level.pack_a_punch_camo_index_number_variants);
			return level.pack_a_punch_camo_index + camo_variant;
		}
	}
	else
	{
		return level.pack_a_punch_camo_index;
	}
}

/*
	Name: get_pack_a_punch_weapon_options
	Namespace: zm_weapons
	Checksum: 0x424F4353
	Offset: 0x8720
	Size: 0xC10
	Parameters: 1
	Flags: None
	Line Number: 2943
*/
function get_pack_a_punch_weapon_options(weapon)
{
	if(!isdefined(self.pack_a_punch_weapon_options))
	{
		self.pack_a_punch_weapon_options = [];
	}
	if(!is_weapon_upgraded(weapon))
	{
		return self calcweaponoptions(0, 0, 0, 0, 0);
	}
	if(isdefined(self.pack_a_punch_weapon_options[weapon]))
	{
		return self.pack_a_punch_weapon_options[weapon];
	}
	smiley_face_reticle_index = 1;
	var_480fed80 = self function_1c1990e8(weapon);
	if(isdefined(self.var_fa202141["player_specifiedcamo"]) && self.var_fa202141["player_specifiedcamo"] > 0)
	{
		if(isdefined(self.var_fa202141["player_favouritecamo"]) && self.var_fa202141["player_favouritecamo"] > 0)
		{
			if(var_480fed80.var_4c25c2f2 >= self.var_fa202141["player_favouritecamo"])
			{
				camo_index = self.var_fa202141["player_favouritecamo"];
			}
			else
			{
				camo_index = var_480fed80.pap_camo_to_use;
			}
		}
		else
		{
			camo_index = var_480fed80.pap_camo_to_use;
		}
		switch(self.var_fa202141["player_specifiedcamo"])
		{
			case 1:
			{
				camo_index = self function_8b59597a(var_480fed80);
				break;
			}
			case 2:
			{
				if(self.pers["christmas_camo"] == 1)
				{
					camo_index = 44;
					break;
				}
			}
			case 3:
			{
				if(self.pers["halloween_camo"] == 1)
				{
					camo_index = 42;
					break;
				}
			}
			case 4:
			{
				if(isdefined(level.var_18ffd3f2[self getxuid(1)]) && (level.var_18ffd3f2[self getxuid(1)].rank == "bronze" || level.var_18ffd3f2[self getxuid(1)].rank == "silver" || level.var_18ffd3f2[self getxuid(1)].rank == "gold" || level.var_18ffd3f2[self getxuid(1)].rank == "master" || level.var_18ffd3f2[self getxuid(1)].rank == "paragon" || level.var_18ffd3f2[self getxuid(1)].rank == "ultimate"))
				{
					camo_index = 45;
					break;
				}
			}
			case 5:
			{
				if(isdefined(level.var_18ffd3f2[self getxuid(1)]) && (level.var_18ffd3f2[self getxuid(1)].rank == "silver" || level.var_18ffd3f2[self getxuid(1)].rank == "gold" || level.var_18ffd3f2[self getxuid(1)].rank == "master" || level.var_18ffd3f2[self getxuid(1)].rank == "paragon" || level.var_18ffd3f2[self getxuid(1)].rank == "ultimate"))
				{
					camo_index = 46;
					break;
				}
			}
			case 6:
			{
				if(isdefined(level.var_18ffd3f2[self getxuid(1)]) && (level.var_18ffd3f2[self getxuid(1)].rank == "gold" || level.var_18ffd3f2[self getxuid(1)].rank == "master" || level.var_18ffd3f2[self getxuid(1)].rank == "paragon" || level.var_18ffd3f2[self getxuid(1)].rank == "ultimate"))
				{
					camo_index = 47;
					break;
				}
			}
			case 7:
			{
				if(isdefined(level.var_18ffd3f2[self getxuid(1)]) && (level.var_18ffd3f2[self getxuid(1)].rank == "master" || level.var_18ffd3f2[self getxuid(1)].rank == "paragon" || level.var_18ffd3f2[self getxuid(1)].rank == "ultimate"))
				{
					camo_index = 41;
					break;
				}
			}
			case 8:
			{
				if(isdefined(level.var_18ffd3f2[self getxuid(1)]) && (level.var_18ffd3f2[self getxuid(1)].rank == "paragon" || level.var_18ffd3f2[self getxuid(1)].rank == "ultimate"))
				{
					camo_index = 38;
					break;
				}
			}
			case 9:
			{
				if(isdefined(level.var_18ffd3f2[self getxuid(1)]) && level.var_18ffd3f2[self getxuid(1)].rank == "ultimate")
				{
					camo_index = 43;
					break;
				}
			}
			case 10:
			{
				if(self.pers["legend_camo"] == 1)
				{
					camo_index = 36;
					break;
				}
			}
			case 11:
			{
				if(self.pers["master_camo"] == 1)
				{
					camo_index = 22;
					break;
				}
			}
			default
			{
				if(isdefined(self.var_fa202141["player_favouritecamo"]) && self.var_fa202141["player_favouritecamo"] > 0)
				{
					if(var_480fed80.var_4c25c2f2 >= self.var_fa202141["player_favouritecamo"])
					{
						camo_index = self.var_fa202141["player_favouritecamo"];
					}
					else
					{
						camo_index = var_480fed80.pap_camo_to_use;
					}
				}
				else
				{
					camo_index = var_480fed80.pap_camo_to_use;
				}
			}
		}
	}
	else if(isdefined(self.var_fa202141["player_favouritecamo"]) && self.var_fa202141["player_favouritecamo"] > 0)
	{
		if(var_480fed80.var_4c25c2f2 >= self.var_fa202141["player_favouritecamo"])
		{
			camo_index = self.var_fa202141["player_favouritecamo"];
		}
		else
		{
			camo_index = var_480fed80.pap_camo_to_use;
		}
	}
	else if(isdefined(var_480fed80.pap_camo_to_use))
	{
		camo_index = var_480fed80.pap_camo_to_use;
	}
	else
	{
		camo_index = get_pack_a_punch_camo_index(undefined);
	}
	lens_index = randomintrange(0, 6);
	reticle_index = randomintrange(0, 16);
	reticle_color_index = randomintrange(0, 6);
	plain_reticle_index = 16;
	use_plain = randomint(10) < 1;
	if("saritch_upgraded" == weapon.rootweapon.name)
	{
		reticle_index = smiley_face_reticle_index;
	}
	else if(use_plain)
	{
		reticle_index = plain_reticle_index;
	}
	scary_eyes_reticle_index = 8;
	purple_reticle_color_index = 3;
	if(reticle_index == scary_eyes_reticle_index)
	{
		reticle_color_index = purple_reticle_color_index;
	}
	letter_a_reticle_index = 2;
	pink_reticle_color_index = 6;
	if(reticle_index == letter_a_reticle_index)
	{
		reticle_color_index = pink_reticle_color_index;
	}
	letter_e_reticle_index = 7;
	green_reticle_color_index = 1;
	if(reticle_index == letter_e_reticle_index)
	{
		reticle_color_index = green_reticle_color_index;
	}
	self.pack_a_punch_weapon_options[weapon] = self calcweaponoptions(camo_index, lens_index, reticle_index, reticle_color_index);
	return self.pack_a_punch_weapon_options[weapon];
}

/*
	Name: function_8b59597a
	Namespace: zm_weapons
	Checksum: 0x424F4353
	Offset: 0x9338
	Size: 0x828
	Parameters: 1
	Flags: None
	Line Number: 3147
*/
function function_8b59597a(var_480fed80)
{
	var_a4eb29f2 = 0;
	while(var_a4eb29f2 <= 0)
	{
		switch(randomint(3))
		{
			case 0:
			{
				index = randomintrange(1, var_480fed80.var_4c25c2f2);
				if(isdefined(var_480fed80) && var_480fed80.var_4c25c2f2 >= index)
				{
					var_a4eb29f2 = index;
				}
				else
				{
					var_a4eb29f2 = 1;
					break;
				}
			}
			case 1:
			{
				index = array(42, 44);
				index = array::randomize(index);
				if(index[0] == 44 && self.pers["christmas_camo"] == 1)
				{
					var_a4eb29f2 = 44;
				}
				else if(index[0] == 42 && self.pers["halloween_camo"] == 1)
				{
					var_a4eb29f2 = 42;
					break;
				}
			}
			case 2:
			{
				index = array(38, 41, 43, 45, 46, 47);
				index = array::randomize(index);
				if(index[0] == 38 && isdefined(level.var_18ffd3f2[self getxuid(1)]) && (level.var_18ffd3f2[self getxuid(1)].rank == "paragon" || level.var_18ffd3f2[self getxuid(1)].rank == "ultimate"))
				{
					var_a4eb29f2 = 38;
				}
				else if(index[0] == 41 && isdefined(level.var_18ffd3f2[self getxuid(1)]) && (level.var_18ffd3f2[self getxuid(1)].rank == "master" || level.var_18ffd3f2[self getxuid(1)].rank == "paragon" || level.var_18ffd3f2[self getxuid(1)].rank == "ultimate"))
				{
					var_a4eb29f2 = 41;
				}
				else if(index[0] == 43 && isdefined(level.var_18ffd3f2[self getxuid(1)]) && level.var_18ffd3f2[self getxuid(1)].rank == "ultimate")
				{
					var_a4eb29f2 = 43;
				}
				else if(index[0] == 45 && isdefined(level.var_18ffd3f2[self getxuid(1)]) && (level.var_18ffd3f2[self getxuid(1)].rank == "bronze" || level.var_18ffd3f2[self getxuid(1)].rank == "silver" || level.var_18ffd3f2[self getxuid(1)].rank == "gold" || level.var_18ffd3f2[self getxuid(1)].rank == "master" || level.var_18ffd3f2[self getxuid(1)].rank == "paragon" || level.var_18ffd3f2[self getxuid(1)].rank == "ultimate"))
				{
					var_a4eb29f2 = 45;
				}
				else if(index[0] == 46 && isdefined(level.var_18ffd3f2[self getxuid(1)]) && (level.var_18ffd3f2[self getxuid(1)].rank == "silver" || level.var_18ffd3f2[self getxuid(1)].rank == "gold" || level.var_18ffd3f2[self getxuid(1)].rank == "master" || level.var_18ffd3f2[self getxuid(1)].rank == "paragon" || level.var_18ffd3f2[self getxuid(1)].rank == "ultimate"))
				{
					var_a4eb29f2 = 46;
				}
				else if(index[0] == 47 && isdefined(level.var_18ffd3f2[self getxuid(1)]) && (level.var_18ffd3f2[self getxuid(1)].rank == "gold" || level.var_18ffd3f2[self getxuid(1)].rank == "master" || level.var_18ffd3f2[self getxuid(1)].rank == "paragon" || level.var_18ffd3f2[self getxuid(1)].rank == "ultimate"))
				{
					var_a4eb29f2 = 47;
					break;
				}
			}
		}
		util::wait_network_frame();
	}
	return var_a4eb29f2;
}

/*
	Name: give_build_kit_weapon
	Namespace: zm_weapons
	Checksum: 0x424F4353
	Offset: 0x9B68
	Size: 0xD90
	Parameters: 2
	Flags: None
	Line Number: 3227
*/
function give_build_kit_weapon(weapon, var_eb70b91d)
{
	upgraded = 0;
	camo = undefined;
	base_weapon = weapon;
	if(isdefined(level.var_e2a6fd15[weapon.name]))
	{
		var_ed5e1bff = self function_e942fd68(weapon);
		if(!(isdefined(var_ed5e1bff) && var_ed5e1bff))
		{
			if(isdefined(self function_c3370d47(weapon)) && self function_c3370d47(weapon))
			{
				var_5657986b = spawnstruct();
				var_5657986b.stored_weapon = weapon.rootweapon;
				var_5657986b.var_79fe8f18 = 0;
				var_5657986b.var_4c25c2f2 = 0;
				var_5657986b.pap_camo_to_use = level.var_1e656cc4[var_5657986b.var_4c25c2f2];
				self.var_3818be12[self.var_3818be12.size] = var_5657986b;
			}
		}
		var_d2433c1d = spawnstruct();
		var_d2433c1d.stored_weapon = weapon.rootweapon;
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
	if(is_weapon_upgraded(weapon))
	{
		var_480fed80 = self function_1c1990e8(weapon);
		if(isdefined(self.var_fa202141["player_specifiedcamo"]) && self.var_fa202141["player_specifiedcamo"] > 0)
		{
			if(isdefined(self.var_fa202141["player_favouritecamo"]) && self.var_fa202141["player_favouritecamo"] > 0)
			{
				if(var_480fed80.var_4c25c2f2 >= self.var_fa202141["player_favouritecamo"])
				{
					camo = self.var_fa202141["player_favouritecamo"];
				}
				else
				{
					camo = var_480fed80.pap_camo_to_use;
				}
			}
			else
			{
				camo = var_480fed80.pap_camo_to_use;
			}
			switch(self.var_fa202141["player_specifiedcamo"])
			{
				case 1:
				{
					camo = self function_8b59597a(var_480fed80);
					break;
				}
				case 2:
				{
					if(self.pers["christmas_camo"] == 1)
					{
						camo = 44;
						break;
					}
				}
				case 3:
				{
					if(self.pers["halloween_camo"] == 1)
					{
						camo = 42;
						break;
					}
				}
				case 4:
				{
					if(isdefined(level.var_18ffd3f2[self getxuid(1)]) && (level.var_18ffd3f2[self getxuid(1)].rank == "bronze" || level.var_18ffd3f2[self getxuid(1)].rank == "silver" || level.var_18ffd3f2[self getxuid(1)].rank == "gold" || level.var_18ffd3f2[self getxuid(1)].rank == "master" || level.var_18ffd3f2[self getxuid(1)].rank == "paragon" || level.var_18ffd3f2[self getxuid(1)].rank == "ultimate"))
					{
						camo = 45;
						break;
					}
				}
				case 5:
				{
					if(isdefined(level.var_18ffd3f2[self getxuid(1)]) && (level.var_18ffd3f2[self getxuid(1)].rank == "silver" || level.var_18ffd3f2[self getxuid(1)].rank == "gold" || level.var_18ffd3f2[self getxuid(1)].rank == "master" || level.var_18ffd3f2[self getxuid(1)].rank == "paragon" || level.var_18ffd3f2[self getxuid(1)].rank == "ultimate"))
					{
						camo = 46;
						break;
					}
				}
				case 6:
				{
					if(isdefined(level.var_18ffd3f2[self getxuid(1)]) && (level.var_18ffd3f2[self getxuid(1)].rank == "gold" || level.var_18ffd3f2[self getxuid(1)].rank == "master" || level.var_18ffd3f2[self getxuid(1)].rank == "paragon" || level.var_18ffd3f2[self getxuid(1)].rank == "ultimate"))
					{
						camo = 47;
						break;
					}
				}
				case 7:
				{
					if(isdefined(level.var_18ffd3f2[self getxuid(1)]) && (level.var_18ffd3f2[self getxuid(1)].rank == "master" || level.var_18ffd3f2[self getxuid(1)].rank == "paragon" || level.var_18ffd3f2[self getxuid(1)].rank == "ultimate"))
					{
						camo = 41;
						break;
					}
				}
				case 8:
				{
					if(isdefined(level.var_18ffd3f2[self getxuid(1)]) && (level.var_18ffd3f2[self getxuid(1)].rank == "paragon" || level.var_18ffd3f2[self getxuid(1)].rank == "ultimate"))
					{
						camo = 38;
						break;
					}
				}
				case 9:
				{
					if(isdefined(level.var_18ffd3f2[self getxuid(1)]) && level.var_18ffd3f2[self getxuid(1)].rank == "ultimate")
					{
						camo = 43;
						break;
					}
				}
				case 10:
				{
					if(self.pers["legend_camo"] == 1)
					{
						camo = 36;
						break;
					}
				}
				case 11:
				{
					if(self.pers["master_camo"] == 1)
					{
						camo = 22;
						break;
					}
				}
				default
				{
					if(isdefined(self.var_fa202141["player_favouritecamo"]) && self.var_fa202141["player_favouritecamo"] > 0)
					{
						if(var_480fed80.var_4c25c2f2 >= self.var_fa202141["player_favouritecamo"])
						{
							camo = self.var_fa202141["player_favouritecamo"];
						}
						else
						{
							camo = var_480fed80.pap_camo_to_use;
						}
					}
					else
					{
						camo = var_480fed80.pap_camo_to_use;
					}
				}
			}
		}
		else if(isdefined(self.var_fa202141["player_favouritecamo"]) && self.var_fa202141["player_favouritecamo"] > 0)
		{
			if(var_480fed80.var_4c25c2f2 >= self.var_fa202141["player_favouritecamo"])
			{
				camo = self.var_fa202141["player_favouritecamo"];
			}
			else
			{
				camo = var_480fed80.pap_camo_to_use;
			}
		}
		else if(isdefined(var_480fed80.pap_camo_to_use))
		{
			camo = var_480fed80.pap_camo_to_use;
		}
		else
		{
			camo = get_pack_a_punch_camo_index(undefined);
		}
		upgraded = 1;
		base_weapon = get_base_weapon(weapon);
	}
	if(is_weapon_included(base_weapon))
	{
		force_attachments = get_force_attachments(base_weapon.rootweapon);
	}
	if(isdefined(force_attachments) && force_attachments.size)
	{
		if(upgraded)
		{
			packed_attachments = [];
			packed_attachments[packed_attachments.size] = "extclip";
			packed_attachments[packed_attachments.size] = "fmj";
			force_attachments = arraycombine(force_attachments, packed_attachments, 0, 0);
		}
		weapon = getweapon(weapon.rootweapon.name, force_attachments);
		if(!isdefined(camo))
		{
			camo = 0;
		}
		weapon_options = self calcweaponoptions(camo, 0, 0);
		acvi = 0;
	}
	else
	{
		weapon = self getbuildkitweapon(weapon, upgraded);
		weapon_options = self getbuildkitweaponoptions(weapon, camo);
		acvi = self getbuildkitattachmentcosmeticvariantindexes(weapon, upgraded);
	}
	self giveweapon(weapon, weapon_options, acvi);
	return weapon;
}

/*
	Name: function_e942fd68
	Namespace: zm_weapons
	Checksum: 0x424F4353
	Offset: 0xA900
	Size: 0xC0
	Parameters: 1
	Flags: None
	Line Number: 3449
*/
function function_e942fd68(weapon)
{
	if(isdefined(self.var_3818be12) && self.var_3818be12.size > 0)
	{
		foreach(var_52bd8d74 in self.var_3818be12)
		{
			if(var_52bd8d74.stored_weapon == weapon.rootweapon)
			{
				return 1;
			}
		}
	}
	return 0;
}

/*
	Name: function_1c1990e8
	Namespace: zm_weapons
	Checksum: 0x424F4353
	Offset: 0xA9C8
	Size: 0xC0
	Parameters: 1
	Flags: None
	Line Number: 3474
*/
function function_1c1990e8(weapon)
{
	if(isdefined(self.var_3818be12) && self.var_3818be12.size > 0)
	{
		foreach(var_52bd8d74 in self.var_3818be12)
		{
			if(var_52bd8d74.stored_weapon == weapon.rootweapon)
			{
				return var_52bd8d74;
			}
		}
	}
	return undefined;
}

/*
	Name: function_1239e0ad
	Namespace: zm_weapons
	Checksum: 0x424F4353
	Offset: 0xAA90
	Size: 0xC0
	Parameters: 1
	Flags: None
	Line Number: 3499
*/
function function_1239e0ad(weapon)
{
	if(isdefined(self.var_fb56a719) && self.var_fb56a719.size > 0)
	{
		foreach(var_52bd8d74 in self.var_fb56a719)
		{
			if(var_52bd8d74.stored_weapon == weapon.rootweapon)
			{
				return var_52bd8d74;
			}
		}
	}
	return undefined;
}

/*
	Name: function_c3370d47
	Namespace: zm_weapons
	Checksum: 0x424F4353
	Offset: 0xAB58
	Size: 0x168
	Parameters: 1
	Flags: None
	Line Number: 3524
*/
function function_c3370d47(weapon)
{
	w_weapon = get_nonalternate_weapon(weapon);
	if(isdefined(w_weapon.rootweapon))
	{
		w_weapon = w_weapon.rootweapon;
	}
	if(isdefined(w_weapon.dualWieldWeapon) && (issubstr(w_weapon.name, "lh") || issubstr(w_weapon.name, "ldw")))
	{
		w_weapon = w_weapon.dualWieldWeapon;
	}
	if(!isdefined(level.var_e2a6fd15[w_weapon.name]))
	{
		return 0;
	}
	if(w_weapon.var_8c86d7b3 || w_weapon.var_7e163cf8 || zm_equipment::is_equipment(w_weapon) || zm_utility::is_placeable_mine(w_weapon))
	{
		return 0;
	}
	if(w_weapon.isRiotShield)
	{
		return 0;
	}
	return 1;
}

/*
	Name: weapon_give
	Namespace: zm_weapons
	Checksum: 0x424F4353
	Offset: 0xACC8
	Size: 0xCA0
	Parameters: 5
	Flags: None
	Line Number: 3560
*/
function weapon_give(weapon, is_upgrade, magic_box, nosound, b_switch_weapon)
{
	if(!isdefined(is_upgrade))
	{
		is_upgrade = 0;
	}
	if(!isdefined(magic_box))
	{
		magic_box = 0;
	}
	if(!isdefined(nosound))
	{
		nosound = 0;
	}
	if(!isdefined(b_switch_weapon))
	{
		b_switch_weapon = 1;
	}
	if(isdefined(weapon.stored_weapon))
	{
		var_eb70b91d = weapon;
		weapon = weapon.stored_weapon;
	}
	var_486e1095 = 1;
	primaryWeapons = self getweaponslistprimaries();
	if(isdefined(primaryWeapons) && primaryWeapons.size > 0)
	{
		foreach(var_b4be16a1 in primaryWeapons)
		{
			if(get_base_weapon(var_b4be16a1.rootweapon) == get_base_weapon(var_eb70b91d.stored_weapon))
			{
				current_weapon = var_b4be16a1;
				continue;
			}
			initial_current_weapon = self getcurrentweapon();
			current_weapon = self switch_from_alt_weapon(initial_current_weapon);
		}
	}
	else if(isdefined(current_weapon))
	{
		ammoclip = self getweaponammoclip(current_weapon);
		var_b71eaadf = self getweaponammostock(current_weapon);
		dw_weapon = current_weapon.dualWieldWeapon;
		if(dw_weapon != level.weaponnone && isdefined(dw_weapon))
		{
			var_6fa3e4b2 = self getweaponammoclip(dw_weapon);
		}
		else
		{
			var_6fa3e4b2 = 0;
		}
	}
	/#
		Assert(self player_can_use_content(weapon));
	#/
	if(isdefined(weapon) && (weapon.name == "t9_crossbow_skull" || weapon.name == "t9_crossbow_skull_up"))
	{
		self thread zm_equipment::show_hint_text(&"ZM_MINECRAFT_CROSSBOW_PICKUP_HINT", 4);
	}
	if(!isdefined(is_upgrade))
	{
		is_upgrade = 0;
	}
	weapon_limit = zm_utility::get_player_weapon_limit(self);
	if(zm_equipment::is_equipment(weapon))
	{
		self zm_equipment::give(weapon);
		var_486e1095 = 0;
	}
	if(weapon.isRiotShield)
	{
		if(isdefined(self.player_shield_reset_health))
		{
			self [[self.player_shield_reset_health]]();
		}
		var_486e1095 = 0;
	}
	if(isdefined(level.var_c181264f) && level.var_c181264f)
	{
		var_486e1095 = 0;
	}
	if(zm_utility::is_melee_weapon(weapon))
	{
		current_weapon = zm_melee_weapon::change_melee_weapon(weapon, current_weapon);
		var_486e1095 = 0;
	}
	else if(zm_utility::is_hero_weapon(weapon))
	{
		old_hero = self zm_utility::get_player_hero_weapon();
		if(old_hero != level.weaponnone)
		{
			self weapon_take(old_hero);
		}
		self zm_utility::set_player_hero_weapon(weapon);
		var_486e1095 = 0;
	}
	else if(zm_utility::is_lethal_grenade(weapon))
	{
		old_lethal = self zm_utility::get_player_lethal_grenade();
		if(old_lethal != level.weaponnone)
		{
			self weapon_take(old_lethal);
		}
		self zm_utility::set_player_lethal_grenade(weapon);
		var_486e1095 = 0;
	}
	else if(zm_utility::is_tactical_grenade(weapon))
	{
		old_tactical = self zm_utility::get_player_tactical_grenade();
		if(old_tactical != level.weaponnone)
		{
			self weapon_take(old_tactical);
		}
		self zm_utility::set_player_tactical_grenade(weapon);
		var_486e1095 = 0;
	}
	else if(zm_utility::is_placeable_mine(weapon))
	{
		old_mine = self zm_utility::get_player_placeable_mine();
		if(old_mine != level.weaponnone)
		{
			self weapon_take(old_mine);
		}
		self zm_utility::set_player_placeable_mine(weapon);
		var_486e1095 = 0;
	}
	if(issubstr(weapon.name, "minigun") || weapon == level.zombie_powerup_weapon["minigun"])
	{
		var_486e1095 = 0;
	}
	if(!(isdefined(level.var_7f7e3195) && level.var_7f7e3195))
	{
		var_486e1095 = 0;
	}
	if(!zm_utility::is_offhand_weapon(weapon))
	{
		self take_fallback_weapon();
	}
	if(primaryWeapons.size >= weapon_limit)
	{
		if(zm_utility::is_placeable_mine(current_weapon) || zm_equipment::is_equipment(current_weapon))
		{
			current_weapon = undefined;
		}
		if(isdefined(current_weapon))
		{
			if(!zm_utility::is_offhand_weapon(weapon))
			{
				if(current_weapon.isBallisticKnife)
				{
					self notify("zmb_lost_knife");
				}
				self weapon_take(current_weapon);
				if(isdefined(initial_current_weapon) && issubstr(initial_current_weapon.name, "dualoptic"))
				{
					self weapon_take(initial_current_weapon);
				}
			}
		}
	}
	if(isdefined(level.zombiemode_offhand_weapon_give_override))
	{
		if(self [[level.zombiemode_offhand_weapon_give_override]](weapon))
		{
			self notify("weapon_give", weapon);
			self zm_utility::play_sound_on_ent("purchase");
			return weapon;
		}
	}
	if(weapon.isBallisticKnife)
	{
		weapon = self zm_melee_weapon::give_ballistic_knife(weapon, is_weapon_upgraded(weapon));
	}
	else if(zm_utility::is_placeable_mine(weapon))
	{
		self thread zm_placeable_mine::setup_for_player(weapon);
		self play_weapon_vo(weapon, magic_box);
		self notify("weapon_give", weapon);
		return weapon;
	}
	if(isdefined(level.zombie_weapons_callbacks) && isdefined(level.zombie_weapons_callbacks[weapon]))
	{
		self thread [[level.zombie_weapons_callbacks[weapon]]]();
		play_weapon_vo(weapon, magic_box);
		self notify("weapon_give", weapon);
		return weapon;
	}
	if(!(isdefined(nosound) && nosound))
	{
		self zm_utility::play_sound_on_ent("purchase");
	}
	weapon = self give_build_kit_weapon(weapon, var_eb70b91d);
	self notify("weapon_give", weapon);
	if(isdefined(var_eb70b91d))
	{
		else
		{
		}
	}
	if(isdefined(var_eb70b91d) && isdefined(var_eb70b91d.ammoclip) || (isdefined(var_eb70b91d) && isdefined(var_eb70b91d.var_b71eaadf)) || (isdefined(var_eb70b91d) && isdefined(var_eb70b91d.var_6fa3e4b2)))
	{
		self setweaponammoclip(weapon, var_eb70b91d.ammoclip);
		self setweaponammostock(weapon, var_eb70b91d.var_b71eaadf);
		if(isdefined(weapon.dualWieldWeapon))
		{
			dw_weapon = weapon.dualWieldWeapon;
			if(dw_weapon != level.weaponnone)
			{
				self setweaponammoclip(dw_weapon, var_eb70b91d.var_6fa3e4b2);
			}
		}
	}
	else if(self hasperk("specialty_extraammo"))
	{
		self givemaxammo(weapon);
	}
	else
	{
		self givestartammo(weapon);
	}
	if(b_switch_weapon && !zm_utility::is_offhand_weapon(weapon))
	{
		if(!zm_utility::is_melee_weapon(weapon))
		{
			self switchtoweapon(weapon);
			if(isdefined(current_weapon) && (!(isdefined(self hasweapon(current_weapon)) && self hasweapon(current_weapon))) || primaryWeapons.size >= 2)
			{
				if(level flag::get("initial_blackscreen_passed"))
				{
					if(primaryWeapons.size >= weapon_limit && (isdefined(var_486e1095) && var_486e1095))
					{
						level thread function_30a74e90(self, current_weapon, ammoclip, var_b71eaadf, var_6fa3e4b2, 25);
					}
				}
			}
		}
		else
		{
			self switchtoweapon(current_weapon);
		}
	}
	if(!(isdefined(nosound) && nosound))
	{
		self play_weapon_vo(weapon, magic_box);
	}
	return weapon;
}

/*
	Name: function_30a74e90
	Namespace: zm_weapons
	Checksum: 0x424F4353
	Offset: 0xB970
	Size: 0x1258
	Parameters: 6
	Flags: None
	Line Number: 3818
*/
function function_30a74e90(current_player, current_weapon, ammoclip, var_b71eaadf, var_6fa3e4b2, timer)
{
	var_eb70b91d = spawnstruct();
	var_eb70b91d.stored_weapon = current_weapon;
	var_7750a3aa = current_player function_1239e0ad(current_weapon);
	var_ed5e1bff = current_player function_e942fd68(current_weapon);
	if(isdefined(var_7750a3aa))
	{
		arrayremovevalue(current_player.var_fb56a719, var_7750a3aa);
		var_eb70b91d.var_a39a2843 = var_7750a3aa.var_a39a2843;
	}
	var_480fed80 = current_player function_1c1990e8(current_weapon);
	if(isdefined(current_player.var_fa202141["player_specifiedcamo"]) && current_player.var_fa202141["player_specifiedcamo"] > 0)
	{
		if(isdefined(current_player.var_fa202141["player_favouritecamo"]) && current_player.var_fa202141["player_favouritecamo"] > 0)
		{
			if(var_480fed80.var_4c25c2f2 >= current_player.var_fa202141["player_favouritecamo"])
			{
				camo_index = current_player.var_fa202141["player_favouritecamo"];
			}
			else
			{
				camo_index = var_480fed80.pap_camo_to_use;
			}
		}
		else
		{
			camo_index = var_480fed80.pap_camo_to_use;
		}
		switch(current_player.var_fa202141["player_specifiedcamo"])
		{
			case 2:
			{
				if(current_player.pers["christmas_camo"] == 1)
				{
					camo_index = 44;
					break;
				}
			}
			case 3:
			{
				if(current_player.pers["halloween_camo"] == 1)
				{
					camo_index = 42;
					break;
				}
			}
			case 4:
			{
				if(isdefined(level.var_18ffd3f2[current_player getxuid(1)]) && (level.var_18ffd3f2[current_player getxuid(1)].rank == "bronze" || level.var_18ffd3f2[current_player getxuid(1)].rank == "silver" || level.var_18ffd3f2[current_player getxuid(1)].rank == "gold" || level.var_18ffd3f2[current_player getxuid(1)].rank == "master" || level.var_18ffd3f2[current_player getxuid(1)].rank == "paragon" || level.var_18ffd3f2[current_player getxuid(1)].rank == "ultimate"))
				{
					camo_index = 45;
					break;
				}
			}
			case 5:
			{
				if(isdefined(level.var_18ffd3f2[current_player getxuid(1)]) && (level.var_18ffd3f2[current_player getxuid(1)].rank == "silver" || level.var_18ffd3f2[current_player getxuid(1)].rank == "gold" || level.var_18ffd3f2[current_player getxuid(1)].rank == "master" || level.var_18ffd3f2[current_player getxuid(1)].rank == "paragon" || level.var_18ffd3f2[current_player getxuid(1)].rank == "ultimate"))
				{
					camo_index = 46;
					break;
				}
			}
			case 6:
			{
				if(isdefined(level.var_18ffd3f2[current_player getxuid(1)]) && (level.var_18ffd3f2[current_player getxuid(1)].rank == "gold" || level.var_18ffd3f2[current_player getxuid(1)].rank == "master" || level.var_18ffd3f2[current_player getxuid(1)].rank == "paragon" || level.var_18ffd3f2[current_player getxuid(1)].rank == "ultimate"))
				{
					camo_index = 47;
					break;
				}
			}
			case 7:
			{
				if(isdefined(level.var_18ffd3f2[current_player getxuid(1)]) && (level.var_18ffd3f2[current_player getxuid(1)].rank == "master" || level.var_18ffd3f2[current_player getxuid(1)].rank == "paragon" || level.var_18ffd3f2[current_player getxuid(1)].rank == "ultimate"))
				{
					camo_index = 41;
					break;
				}
			}
			case 8:
			{
				if(isdefined(level.var_18ffd3f2[current_player getxuid(1)]) && (level.var_18ffd3f2[current_player getxuid(1)].rank == "paragon" || level.var_18ffd3f2[current_player getxuid(1)].rank == "ultimate"))
				{
					camo_index = 38;
					break;
				}
			}
			case 9:
			{
				if(isdefined(level.var_18ffd3f2[current_player getxuid(1)]) && level.var_18ffd3f2[current_player getxuid(1)].rank == "ultimate")
				{
					camo_index = 43;
					break;
				}
			}
			case 10:
			{
				if(current_player.pers["legend_camo"] == 1)
				{
					camo_index = 36;
					break;
				}
			}
			case 11:
			{
				if(current_player.pers["master_camo"] == 1)
				{
					camo_index = 22;
					break;
				}
			}
			default
			{
				if(isdefined(current_player.var_fa202141["player_favouritecamo"]) && current_player.var_fa202141["player_favouritecamo"] > 0)
				{
					if(var_480fed80.var_4c25c2f2 >= current_player.var_fa202141["player_favouritecamo"])
					{
						camo_index = current_player.var_fa202141["player_favouritecamo"];
					}
					else
					{
						camo_index = var_480fed80.pap_camo_to_use;
					}
				}
				else
				{
					camo_index = var_480fed80.pap_camo_to_use;
				}
			}
		}
	}
	else if(isdefined(current_player.var_fa202141["player_favouritecamo"]) && current_player.var_fa202141["player_favouritecamo"] > 0)
	{
		if(var_480fed80.var_4c25c2f2 >= current_player.var_fa202141["player_favouritecamo"])
		{
			camo_index = current_player.var_fa202141["player_favouritecamo"];
		}
		else
		{
			camo_index = var_480fed80.pap_camo_to_use;
		}
	}
	else if(isdefined(var_480fed80.pap_camo_to_use))
	{
		camo_index = var_480fed80.pap_camo_to_use;
	}
	else
	{
		camo_index = get_pack_a_punch_camo_index(undefined);
	}
	if(isdefined(var_ed5e1bff) && isdefined(camo_index))
	{
		var_eb70b91d.var_e9e92a5b = zm_utility::spawn_buildkit_weapon_model(current_player, current_weapon, camo_index, current_player.origin + VectorScale((0, 0, 1), 45));
	}
	else
	{
		var_eb70b91d.var_e9e92a5b = zm_utility::spawn_buildkit_weapon_model(current_player, current_weapon, level.var_1e656cc4[0], current_player.origin + VectorScale((0, 0, 1), 45));
	}
	var_eb70b91d.var_e9e92a5b EnableLinkTo();
	var_eb70b91d.var_e9e92a5b.script_noteworthy = "dropped_weapon_waypoint";
	var_eb70b91d.var_e9e92a5b.stored_weapon = current_weapon;
	if(current_weapon.isDualWield)
	{
		dweapon = current_weapon;
		if(isdefined(current_weapon.dualWieldWeapon) && current_weapon.dualWieldWeapon != level.weaponnone)
		{
			dweapon = current_weapon.dualWieldWeapon;
		}
		var_eb70b91d.ammoclip = ammoclip;
		var_eb70b91d.var_b71eaadf = var_b71eaadf;
		var_eb70b91d.var_6fa3e4b2 = var_6fa3e4b2;
		if(isdefined(var_ed5e1bff) && isdefined(camo_index))
		{
			var_eb70b91d.var_e9e92a5b.var_fce7951c = zm_utility::spawn_buildkit_weapon_model(current_player, current_weapon, camo_index, current_player.origin + VectorScale((0, 0, 1), 45));
		}
		else
		{
			var_eb70b91d.var_e9e92a5b.var_fce7951c = zm_utility::spawn_buildkit_weapon_model(current_player, current_weapon, level.var_1e656cc4[0], current_player.origin + VectorScale((0, 0, 1), 45));
		}
		var_eb70b91d.var_e9e92a5b.var_fce7951c linkto(var_eb70b91d.var_e9e92a5b);
	}
	else
	{
		var_eb70b91d.ammoclip = ammoclip;
		var_eb70b91d.var_b71eaadf = var_b71eaadf;
	}
	final_pos = function_a2b97522(current_player, 23, var_eb70b91d.var_e9e92a5b);
	var_8f7442a5 = util::ground_position(final_pos, 500, 20);
	var_eb70b91d.var_e9e92a5b zm_utility::fake_physicslaunch(var_8f7442a5, randomintrange(50, 100));
	wait(0.8);
	if(isdefined(var_eb70b91d.var_e9e92a5b))
	{
		if(is_weapon_upgraded(var_eb70b91d.stored_weapon))
		{
			if(tolower(getdvarstring("mapname")) != "zm_castle")
			{
				var_eb70b91d.var_e9e92a5b clientfield::set("weapon_drop_level_enable_keyline", var_eb70b91d.var_a39a2843);
			}
			else
			{
				var_eb70b91d.var_e9e92a5b clientfield::set("weapon_drop_enable_keyline", 1);
			}
			if(isdefined(var_eb70b91d.var_e9e92a5b.var_fce7951c))
			{
				if(tolower(getdvarstring("mapname")) != "zm_castle")
				{
					var_eb70b91d.var_e9e92a5b.var_fce7951c clientfield::set("weapon_drop_level_enable_keyline", var_eb70b91d.var_a39a2843);
				}
				else
				{
					var_eb70b91d.var_e9e92a5b.var_fce7951c clientfield::set("weapon_drop_enable_keyline", 1);
				}
			}
		}
		else if(tolower(getdvarstring("mapname")) != "zm_castle")
		{
			var_eb70b91d.var_e9e92a5b clientfield::set("weapon_drop_enable_keyline", 1);
			var_eb70b91d.var_e9e92a5b clientfield::set("weapon_drop_unpacked_fx", 1);
		}
		else
		{
			var_eb70b91d.var_e9e92a5b clientfield::set("weapon_drop_enable_keyline", 1);
		}
		if(isdefined(var_eb70b91d.var_e9e92a5b.var_fce7951c))
		{
			if(tolower(getdvarstring("mapname")) != "zm_castle")
			{
				var_eb70b91d.var_e9e92a5b.var_fce7951c clientfield::set("weapon_drop_enable_keyline", 1);
			}
			else
			{
				var_eb70b91d.var_e9e92a5b.var_fce7951c clientfield::set("weapon_drop_enable_keyline", 1);
			}
		}
		var_eb70b91d.var_e9e92a5b thread function_233ac813(timer);
		if(isdefined(var_eb70b91d.var_e9e92a5b.var_fce7951c))
		{
			var_eb70b91d.var_e9e92a5b.var_fce7951c thread function_233ac813(timer);
		}
	}
	var_eb70b91d.var_e9e92a5b thread function_8d50f4a4();
	var_eb70b91d.var_e9e92a5b thread function_bf229247(var_eb70b91d);
	var_eb70b91d.var_e9e92a5b.displayname = var_eb70b91d.stored_weapon.displayname;
	var_eb70b91d.var_e9e92a5b create_unitrigger(&"ZM_MINECRAFT_WEAPON_PICKUP_DROPPED", undefined, &function_8d35bc1b);
	var_eb70b91d.var_e9e92a5b thread function_1c800b52(var_eb70b91d);
}

/*
	Name: function_b4c587b5
	Namespace: zm_weapons
	Checksum: 0x424F4353
	Offset: 0xCBD0
	Size: 0xC0
	Parameters: 1
	Flags: None
	Line Number: 4075
*/
function function_b4c587b5(origin)
{
	if(randomintrange(0, 1) == 0)
	{
		return origin - (randomintrange(0, 3) * 12, randomintrange(0, 3) * 12, 0);
	}
	return origin + (randomintrange(0, 3) * 12, randomintrange(0, 3) * 12, 0);
}

/*
	Name: function_a2b97522
	Namespace: zm_weapons
	Checksum: 0x424F4353
	Offset: 0xCC98
	Size: 0xDC0
	Parameters: 4
	Flags: None
	Line Number: 4094
*/
function function_a2b97522(current_player, var_31771afb, weapon_model, Randomized)
{
	if(!isdefined(Randomized))
	{
		Randomized = 0;
	}
	start = current_player.origin;
	forward_dir = anglestoforward(current_player.angles);
	end = start + forward_dir * var_31771afb;
	trace = bullettrace(start, end, 0, undefined);
	final_pos = trace["position"];
	final_pos = function_b4c587b5(final_pos);
	if(weapon_model function_3680e113(start, final_pos, weapon_model.radius) && (!(isdefined(Randomized) && Randomized)))
	{
		return final_pos;
	}
	if(isdefined(Randomized) && Randomized)
	{
		switch(randomintrange(0, 5))
		{
			case 0:
			{
				start = current_player.origin;
				forward_dir = anglestoforward(current_player.angles - (0, randomintrange(7, 10) * 5, 0));
				end = start + forward_dir * var_31771afb;
				trace = bullettrace(start, end, 0, undefined);
				final_pos = trace["position"];
				final_pos = function_b4c587b5(final_pos);
				if(weapon_model function_3680e113(start, final_pos, weapon_model.radius))
				{
					return final_pos;
					break;
				}
			}
			case 1:
			{
				start = current_player.origin;
				forward_dir = anglestoforward(current_player.angles + (0, randomintrange(7, 10) * 5, 0));
				end = start + forward_dir * var_31771afb;
				trace = bullettrace(start, end, 0, undefined);
				final_pos = trace["position"];
				final_pos = function_b4c587b5(final_pos);
				if(weapon_model function_3680e113(start, final_pos, weapon_model.radius))
				{
					return final_pos;
					break;
				}
			}
			case 2:
			{
				start = current_player.origin;
				forward_dir = anglestoforward(current_player.angles - (0, randomintrange(7, 10) * 10, 0));
				end = start + forward_dir * var_31771afb;
				trace = bullettrace(start, end, 0, undefined);
				final_pos = trace["position"];
				final_pos = function_b4c587b5(final_pos);
				if(weapon_model function_3680e113(start, final_pos, weapon_model.radius))
				{
					return final_pos;
					break;
				}
			}
			case 3:
			{
				start = current_player.origin;
				forward_dir = anglestoforward(current_player.angles + (0, randomintrange(7, 10) * 10, 0));
				end = start + forward_dir * var_31771afb;
				trace = bullettrace(start, end, 0, undefined);
				final_pos = trace["position"];
				final_pos = function_b4c587b5(final_pos);
				if(weapon_model function_3680e113(start, final_pos, weapon_model.radius))
				{
					return final_pos;
					break;
				}
			}
			case 4:
			{
				start = current_player.origin;
				forward_dir = anglestoforward(current_player.angles + (0, randomintrange(11, 16) * 10, 0));
				end = start + forward_dir * var_31771afb;
				trace = bullettrace(start, end, 0, undefined);
				final_pos = trace["position"];
				final_pos = function_b4c587b5(final_pos);
				if(weapon_model function_3680e113(start, final_pos, weapon_model.radius))
				{
					return final_pos;
					break;
				}
			}
			case 5:
			{
				start = current_player.origin;
				forward_dir = anglestoforward(current_player.angles - (0, randomintrange(11, 16) * 10, 0));
				end = start + forward_dir * var_31771afb;
				trace = bullettrace(start, end, 0, undefined);
				final_pos = trace["position"];
				final_pos = function_b4c587b5(final_pos);
				if(weapon_model function_3680e113(start, final_pos, weapon_model.radius))
				{
					return final_pos;
					break;
				}
			}
		}
	}
	else
	{
		switch(randomintrange(0, 3))
		{
			case 0:
			{
				start = current_player.origin;
				forward_dir = anglestoforward(current_player.angles - (0, randomintrange(7, 10) * 4, 0));
				end = start + forward_dir * var_31771afb;
				trace = bullettrace(start, end, 0, undefined);
				final_pos = trace["position"];
				final_pos = function_b4c587b5(final_pos);
				if(weapon_model function_3680e113(start, final_pos, weapon_model.radius))
				{
					return final_pos;
					break;
				}
			}
			case 1:
			{
				start = current_player.origin;
				forward_dir = anglestoforward(current_player.angles + (0, randomintrange(7, 10) * 5, 0));
				end = start + forward_dir * var_31771afb;
				trace = bullettrace(start, end, 0, undefined);
				final_pos = trace["position"];
				final_pos = function_b4c587b5(final_pos);
				if(weapon_model function_3680e113(start, final_pos, weapon_model.radius))
				{
					return final_pos;
					break;
				}
			}
			case 2:
			{
				start = current_player.origin;
				forward_dir = anglestoforward(current_player.angles - (0, randomintrange(7, 10) * 10, 0));
				end = start + forward_dir * var_31771afb;
				trace = bullettrace(start, end, 0, undefined);
				final_pos = trace["position"];
				final_pos = function_b4c587b5(final_pos);
				if(weapon_model function_3680e113(start, final_pos, weapon_model.radius))
				{
					return final_pos;
					break;
				}
			}
			case 3:
			{
				start = current_player.origin;
				forward_dir = anglestoforward(current_player.angles + (0, randomintrange(7, 10) * 10, 0));
				end = start + forward_dir * var_31771afb;
				trace = bullettrace(start, end, 0, undefined);
				final_pos = trace["position"];
				final_pos = function_b4c587b5(final_pos);
				if(weapon_model function_3680e113(start, final_pos, weapon_model.radius))
				{
					return final_pos;
					break;
				}
			}
		}
		start = current_player.origin;
		forward_dir = anglestoforward(current_player.angles - VectorScale((0, 1, 0), 135));
		end = start + forward_dir * var_31771afb;
		trace = bullettrace(start, end, 0, undefined);
		final_pos = trace["position"];
		final_pos = function_b4c587b5(final_pos);
		if(weapon_model function_3680e113(start, final_pos, weapon_model.radius))
		{
			return final_pos;
		}
		start = current_player.origin;
		forward_dir = anglestoforward(current_player.angles + VectorScale((0, 1, 0), 135));
		end = start + forward_dir * var_31771afb;
		trace = bullettrace(start, end, 0, undefined);
		final_pos = trace["position"];
		final_pos = function_b4c587b5(final_pos);
		if(weapon_model function_3680e113(start, final_pos, weapon_model.radius))
		{
			return final_pos;
		}
	}
	final_pos = current_player.origin;
	final_pos = function_b4c587b5(final_pos);
	if(weapon_model function_3680e113(start, final_pos, weapon_model.radius))
	{
		return final_pos;
	}
}

/*
	Name: function_3680e113
	Namespace: zm_weapons
	Checksum: 0x424F4353
	Offset: 0xDA60
	Size: 0xF0
	Parameters: 3
	Flags: None
	Line Number: 4300
*/
function function_3680e113(start, final_pos, radius)
{
	box = arraygetclosest(final_pos, level.chests);
	if(distance2dsquared(final_pos, box.origin) > 1800)
	{
		if(ispointonnavmesh(final_pos, radius * 2.5) && TracePassedOnNavMesh(start, final_pos, radius))
		{
			if(self MayMoveFromPointToPoint(start, final_pos, 0, 0))
			{
				return 1;
			}
		}
	}
	return 0;
}

/*
	Name: function_8d35bc1b
	Namespace: zm_weapons
	Checksum: 0x424F4353
	Offset: 0xDB58
	Size: 0x168
	Parameters: 1
	Flags: None
	Line Number: 4326
*/
function function_8d35bc1b(player)
{
	if(player function_53799f52(self.stub.related_parent.origin, 35, 0))
	{
		self setcursorhint("HINT_WEAPON", self.stub.related_parent.stored_weapon);
		self setvisibletoplayer(player);
		if(isdefined(player function_ca858703()) && player function_ca858703())
		{
			self sethintstring(&"ZM_MINECRAFT_WEAPON_PICKUP_DROPPED");
			return 1;
		}
		else
		{
			self sethintstring(&"ZM_MINECRAFT_WEAPON_CANNOT_PICKUP_DROPPED");
			return 0;
		}
	}
	else
	{
		self setcursorhint("HINT_NOICON");
		self setinvisibletoplayer(player);
		self sethintstring("");
		return 0;
	}
}

/*
	Name: function_53799f52
	Namespace: zm_weapons
	Checksum: 0x424F4353
	Offset: 0xDCC8
	Size: 0xB0
	Parameters: 4
	Flags: None
	Line Number: 4362
*/
function function_53799f52(origin, var_a0fa82de, do_trace, e_ignore)
{
	if(!isdefined(var_a0fa82de))
	{
		var_a0fa82de = 180;
	}
	var_a0fa82de = AbsAngleClamp360(var_a0fa82de);
	var_303bd275 = cos(var_a0fa82de * 0.7);
	if(self util::is_player_looking_at(origin, var_303bd275, do_trace, e_ignore))
	{
		return 1;
	}
	return 0;
}

/*
	Name: function_ca858703
	Namespace: zm_weapons
	Checksum: 0x424F4353
	Offset: 0xDD80
	Size: 0x268
	Parameters: 0
	Flags: None
	Line Number: 4387
*/
function function_ca858703()
{
	current_weapon = self getcurrentweapon();
	if(self laststand::player_is_in_laststand() || (isdefined(self.intermission) && self.intermission) || self IsThrowingGrenade())
	{
		return 0;
	}
	if(!self zm_magicbox::can_buy_weapon() || self bgb::is_enabled("zm_bgb_disorderly_combat"))
	{
		return 0;
	}
	if(self zm_equipment::hacker_active())
	{
		return 0;
	}
	if(current_weapon.isRiotShield || zm_utility::is_hero_weapon(current_weapon))
	{
		return 0;
	}
	if(!zm_utility::is_player_valid(self) || self.is_drinking > 0 || zm_utility::is_placeable_mine(current_weapon) || zm_equipment::is_equipment(current_weapon) || self zm_utility::is_player_revive_tool(current_weapon) || level.weaponnone == current_weapon || self zm_equipment::hacker_active())
	{
		return 0;
	}
	switch(current_weapon.name)
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
	Name: create_unitrigger
	Namespace: zm_weapons
	Checksum: 0x424F4353
	Offset: 0xDFF0
	Size: 0x210
	Parameters: 5
	Flags: None
	Line Number: 4452
*/
function create_unitrigger(str_hint, n_radius, func_prompt_and_visibility, func_unitrigger_logic, s_trigger_type)
{
	if(!isdefined(n_radius))
	{
		n_radius = 15;
	}
	if(!isdefined(func_prompt_and_visibility))
	{
		func_prompt_and_visibility = &zm_unitrigger::unitrigger_prompt_and_visibility;
	}
	if(!isdefined(func_unitrigger_logic))
	{
		func_unitrigger_logic = &unitrigger_logic;
	}
	if(!isdefined(s_trigger_type))
	{
		s_trigger_type = "unitrigger_radius_use";
	}
	self.s_unitrigger = spawnstruct();
	self.s_unitrigger.origin = self.origin;
	self.s_unitrigger.angles = self.angles;
	self.s_unitrigger.script_unitrigger_type = "unitrigger_box_use";
	self.s_unitrigger.cursor_hint = "HINT_NOICON";
	self.s_unitrigger.hint_string = str_hint;
	self.s_unitrigger.script_width = 15;
	self.s_unitrigger.script_height = 15;
	self.s_unitrigger.script_length = 15;
	self.s_unitrigger.require_look_at = 1;
	self.s_unitrigger SetHintLowPriority(1);
	self.s_unitrigger.related_parent = self;
	self.s_unitrigger.radius = n_radius;
	zm_unitrigger::unitrigger_force_per_player_triggers(self.s_unitrigger, 1);
	self.s_unitrigger.prompt_and_visibility_func = func_prompt_and_visibility;
	zm_unitrigger::register_static_unitrigger(self.s_unitrigger, func_unitrigger_logic);
	return;
	ERROR: Exception occured: Stack empty.
}

/*
	Name: unitrigger_logic
	Namespace: zm_weapons
	Checksum: 0x424F4353
	Offset: 0xE208
	Size: 0xA8
	Parameters: 0
	Flags: None
	Line Number: 4500
*/
function unitrigger_logic()
{
	self endon("death");
	while(1)
	{
		self waittill("trigger", player);
		if(player zm_utility::in_revive_trigger())
		{
			continue;
		}
		if(player.is_drinking > 0)
		{
			continue;
		}
		if(!zm_utility::is_player_valid(player))
		{
			continue;
		}
		self.stub.related_parent notify("trigger_activated", player);
	}
}

/*
	Name: function_bf229247
	Namespace: zm_weapons
	Checksum: 0x424F4353
	Offset: 0xE2B8
	Size: 0xC0
	Parameters: 1
	Flags: None
	Line Number: 4532
*/
function function_bf229247(var_eb70b91d)
{
	self waittill("hash_690bf263");
	var_eb70b91d.ammoclip = undefined;
	var_eb70b91d.var_b71eaadf = undefined;
	var_eb70b91d.var_a39a2843 = undefined;
	var_eb70b91d delete();
	if(isdefined(self.var_e9e92a5b.var_fce7951c))
	{
		self.var_e9e92a5b.var_fce7951c delete();
	}
	zm_unitrigger::unregister_unitrigger(self.s_unitrigger);
	self delete();
}

/*
	Name: function_1c800b52
	Namespace: zm_weapons
	Checksum: 0x424F4353
	Offset: 0xE380
	Size: 0xC0
	Parameters: 1
	Flags: None
	Line Number: 4557
*/
function function_1c800b52(var_eb70b91d)
{
	self endon("hash_690bf263");
	while(isdefined(self))
	{
		self waittill("trigger_activated", player);
		if(!zm_utility::is_player_valid(player) || player laststand::player_is_in_laststand())
		{
			continue;
		}
		player weapon_give(var_eb70b91d, 0, 0, 1, 1);
		zm_unitrigger::unregister_unitrigger(self.s_unitrigger);
		self notify("hash_690bf263");
	}
}

/*
	Name: function_233ac813
	Namespace: zm_weapons
	Checksum: 0x424F4353
	Offset: 0xE448
	Size: 0xF0
	Parameters: 1
	Flags: None
	Line Number: 4583
*/
function function_233ac813(fadetime)
{
	if(fadetime == 0)
	{
	}
	else
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
}

/*
	Name: function_8d50f4a4
	Namespace: zm_weapons
	Checksum: 0x424F4353
	Offset: 0xE540
	Size: 0x90
	Parameters: 0
	Flags: None
	Line Number: 4629
*/
function function_8d50f4a4()
{
	self Bobbing((0, 0, 1), 3.5, randomintrange(6, 9));
	while(isdefined(self))
	{
		self rotateyaw(360, randomintrange(6, 7));
		wait(6);
	}
}

/*
	Name: weapon_take
	Namespace: zm_weapons
	Checksum: 0x424F4353
	Offset: 0xE5D8
	Size: 0x50
	Parameters: 1
	Flags: None
	Line Number: 4649
*/
function weapon_take(weapon)
{
	self notify("weapon_take", weapon);
	if(self hasweapon(weapon))
	{
		self takeweapon(weapon);
	}
}

/*
	Name: play_weapon_vo
	Namespace: zm_weapons
	Checksum: 0x424F4353
	Offset: 0xE630
	Size: 0x208
	Parameters: 2
	Flags: None
	Line Number: 4668
*/
function play_weapon_vo(weapon, magic_box)
{
	if(isdefined(level._audio_custom_weapon_check))
	{
		type = self [[level._audio_custom_weapon_check]](weapon, magic_box);
	}
	else
	{
		type = self weapon_type_check(weapon);
	}
	if(!isdefined(type))
	{
		return;
	}
	if(isdefined(level.sndWeaponPickupOverride))
	{
		foreach(override in level.sndWeaponPickupOverride)
		{
			if(weapon.name === override)
			{
				self zm_audio::create_and_play_dialog("weapon_pickup", override);
				return;
			}
		}
	}
	else if(isdefined(magic_box) && magic_box)
	{
		self zm_audio::create_and_play_dialog("box_pickup", type);
	}
	else if(type == "upgrade")
	{
		self zm_audio::create_and_play_dialog("weapon_pickup", "upgrade");
	}
	else if(randomintrange(0, 100) <= 50)
	{
		self zm_audio::create_and_play_dialog("weapon_pickup", type);
	}
	else
	{
		self zm_audio::create_and_play_dialog("weapon_pickup", "generic");
	}
}

/*
	Name: weapon_type_check
	Namespace: zm_weapons
	Checksum: 0x424F4353
	Offset: 0xE840
	Size: 0x120
	Parameters: 1
	Flags: None
	Line Number: 4721
*/
function weapon_type_check(weapon)
{
	if(weapon.name == "zombie_beast_grapple_dwr" || weapon.name == "zombie_beast_lightning_dwl" || weapon.name == "zombie_beast_lightning_dwl2" || weapon.name == "zombie_beast_lightning_dwl3")
	{
		return undefined;
	}
	if(!isdefined(self.entity_num))
	{
		return "crappy";
	}
	weapon = get_nonalternate_weapon(weapon);
	weapon = weapon.rootweapon;
	if(is_weapon_upgraded(weapon))
	{
		return "upgrade";
	}
	else if(isdefined(level.zombie_weapons[weapon]))
	{
		return level.zombie_weapons[weapon].vox;
	}
	return "crappy";
}

/*
	Name: ammo_give
	Namespace: zm_weapons
	Checksum: 0x424F4353
	Offset: 0xE968
	Size: 0x428
	Parameters: 1
	Flags: None
	Line Number: 4754
*/
function ammo_give(weapon)
{
	give_ammo = 0;
	if(!zm_utility::is_offhand_weapon(weapon))
	{
		if(isdefined(weapon))
		{
			stockMax = 0;
			stockMax = weapon.maxAmmo;
			clipCount = self getweaponammoclip(weapon);
			dw_clipcount = self getweaponammoclip(weapon.dualWieldWeapon);
			currStock = self getammocount(weapon);
			give_ammo = 1;
		}
	}
	else if(self has_weapon_or_upgrade(weapon))
	{
		give_ammo = 1;
	}
	if(give_ammo)
	{
		wait(0.05);
		self zm_utility::play_sound_on_ent("purchase");
		if(isdefined(weapon.start_ammo) && weapon.start_ammo != weapon.maxAmmo)
		{
			if(self hasperk("specialty_extraammo"))
			{
				self setweaponammostock(weapon, weapon.maxAmmo);
			}
			else
			{
				self setweaponammostock(weapon, weapon.startammo);
			}
		}
		else
		{
			self setweaponammostock(weapon, weapon.maxAmmo);
		}
		if(isdefined(weapon.clipsize) && weapon.clipsize > 0)
		{
			self setweaponammoclip(weapon, weapon.clipsize);
		}
		alt_weap = weapon.altweapon;
		if(level.weaponnone != alt_weap)
		{
			if(isdefined(alt_weap.start_ammo) && alt_weap.start_ammo != alt_weap.maxAmmo)
			{
				if(self hasperk("specialty_extraammo"))
				{
					self setweaponammostock(alt_weap, alt_weap.maxAmmo);
				}
				else
				{
					self setweaponammostock(alt_weap, alt_weap.startammo);
				}
			}
			else
			{
				self setweaponammostock(alt_weap, alt_weap.maxAmmo);
			}
			if(isdefined(alt_weap.clipsize) && alt_weap.clipsize > 0)
			{
				self setweaponammoclip(alt_weap, alt_weap.clipsize);
			}
		}
		if(isdefined(weapon.clipsize) && weapon.clipsize > 0)
		{
			self setweaponammoclip(weapon, weapon.clipsize);
		}
		return 1;
	}
	if(!give_ammo)
	{
		return 0;
	}
}

/*
	Name: get_default_weapondata
	Namespace: zm_weapons
	Checksum: 0x424F4353
	Offset: 0xED98
	Size: 0x1D8
	Parameters: 1
	Flags: None
	Line Number: 4841
*/
function get_default_weapondata(weapon)
{
	weapondata = [];
	weapondata["weapon"] = weapon;
	dw_weapon = weapon.dualWieldWeapon;
	alt_weapon = weapon.altweapon;
	weaponnone = getweapon("none");
	if(isdefined(level.weaponnone))
	{
		weaponnone = level.weaponnone;
	}
	if(weapon != weaponnone)
	{
		weapondata["clip"] = weapon.clipsize;
		weapondata["stock"] = weapon.maxAmmo;
		weapondata["fuel"] = weapon.fuelLife;
		weapondata["heat"] = 0;
		weapondata["overheat"] = 0;
	}
	if(dw_weapon != weaponnone)
	{
		weapondata["lh_clip"] = dw_weapon.clipsize;
	}
	else
	{
		weapondata["lh_clip"] = 0;
	}
	if(alt_weapon != weaponnone)
	{
		weapondata["alt_clip"] = alt_weapon.clipsize;
		weapondata["alt_stock"] = alt_weapon.maxAmmo;
	}
	else
	{
		weapondata["alt_clip"] = 0;
		weapondata["alt_stock"] = 0;
	}
	return weapondata;
}

/*
	Name: get_player_weapondata
	Namespace: zm_weapons
	Checksum: 0x424F4353
	Offset: 0xEF78
	Size: 0x2F8
	Parameters: 2
	Flags: None
	Line Number: 4891
*/
function get_player_weapondata(player, weapon)
{
	weapondata = [];
	if(!isdefined(weapon))
	{
		weapon = player getcurrentweapon();
	}
	weapondata["weapon"] = weapon;
	if(weapondata["weapon"] != level.weaponnone)
	{
		weapondata["clip"] = player getweaponammoclip(weapon);
		weapondata["stock"] = player getweaponammostock(weapon);
		weapondata["fuel"] = player GetWeaponAmmoFuel(weapon);
		weapondata["heat"] = player IsWeaponOverheating(1, weapon);
		weapondata["overheat"] = player IsWeaponOverheating(0, weapon);
	}
	else
	{
		weapondata["clip"] = 0;
		weapondata["stock"] = 0;
		weapondata["fuel"] = 0;
		weapondata["heat"] = 0;
		weapondata["overheat"] = 0;
	}
	dw_weapon = weapon.dualWieldWeapon;
	if(dw_weapon != level.weaponnone)
	{
		weapondata["lh_clip"] = player getweaponammoclip(dw_weapon);
	}
	else
	{
		weapondata["lh_clip"] = 0;
	}
	alt_weapon = weapon.altweapon;
	if(alt_weapon != level.weaponnone)
	{
		weapondata["alt_clip"] = player getweaponammoclip(alt_weapon);
		weapondata["alt_stock"] = player getweaponammostock(alt_weapon);
	}
	else
	{
		weapondata["alt_clip"] = 0;
		weapondata["alt_stock"] = 0;
	}
	var_7750a3aa = self function_1239e0ad(weapon);
	if(var_7750a3aa.var_a39a2843 > 0)
	{
		weapondata["pap_level"] = var_7750a3aa.var_a39a2843;
	}
	return weapondata;
}

/*
	Name: weapon_is_better
	Namespace: zm_weapons
	Checksum: 0x424F4353
	Offset: 0xF278
	Size: 0xD8
	Parameters: 2
	Flags: None
	Line Number: 4953
*/
function weapon_is_better(left, right)
{
	if(left != right)
	{
		left_upgraded = !isdefined(level.zombie_weapons[left]);
		right_upgraded = !isdefined(level.zombie_weapons[right]);
		if(left_upgraded && right_upgraded)
		{
			leftatt = get_attachment_index(left);
			rightatt = get_attachment_index(right);
			return leftatt > rightatt;
		}
		else if(left_upgraded)
		{
			return 1;
		}
	}
	return 0;
}

/*
	Name: merge_weapons
	Namespace: zm_weapons
	Checksum: 0x424F4353
	Offset: 0xF358
	Size: 0x488
	Parameters: 2
	Flags: None
	Line Number: 4983
*/
function merge_weapons(oldweapondata, newweapondata)
{
	weapondata = [];
	if(weapon_is_better(oldweapondata["weapon"], newweapondata["weapon"]))
	{
		weapondata["weapon"] = oldweapondata["weapon"];
	}
	else
	{
		weapondata["weapon"] = newweapondata["weapon"];
	}
	weapon = weapondata["weapon"];
	dw_weapon = weapon.dualWieldWeapon;
	alt_weapon = weapon.altweapon;
	if(weapon != level.weaponnone)
	{
		weapondata["clip"] = newweapondata["clip"] + oldweapondata["clip"];
		weapondata["clip"] = int(min(weapondata["clip"], weapon.clipsize));
		weapondata["stock"] = newweapondata["stock"] + oldweapondata["stock"];
		weapondata["stock"] = int(min(weapondata["stock"], weapon.maxAmmo));
		weapondata["fuel"] = newweapondata["fuel"] + oldweapondata["fuel"];
		weapondata["fuel"] = int(min(weapondata["fuel"], weapon.fuelLife));
		weapondata["heat"] = int(min(newweapondata["heat"], oldweapondata["heat"]));
		weapondata["overheat"] = int(min(newweapondata["overheat"], oldweapondata["overheat"]));
	}
	if(dw_weapon != level.weaponnone)
	{
		weapondata["lh_clip"] = newweapondata["lh_clip"] + oldweapondata["lh_clip"];
		weapondata["lh_clip"] = int(min(weapondata["lh_clip"], dw_weapon.clipsize));
	}
	if(alt_weapon != level.weaponnone)
	{
		weapondata["alt_clip"] = newweapondata["alt_clip"] + oldweapondata["alt_clip"];
		weapondata["alt_clip"] = int(min(weapondata["alt_clip"], alt_weapon.clipsize));
		weapondata["alt_stock"] = newweapondata["alt_stock"] + oldweapondata["alt_stock"];
		weapondata["alt_stock"] = int(min(weapondata["alt_stock"], alt_weapon.maxAmmo));
	}
	return weapondata;
	ERROR: Exception occured: Stack empty.
}

/*
	Name: weapondata_give
	Namespace: zm_weapons
	Checksum: 0x424F4353
	Offset: 0xF7E8
	Size: 0x320
	Parameters: 1
	Flags: None
	Line Number: 5034
*/
function weapondata_give(weapondata)
{
	current = self get_player_weapon_with_same_base(weapondata["weapon"]);
	if(isdefined(current))
	{
		curweapondata = get_player_weapondata(self, current);
		self weapon_take(current);
		weapondata = merge_weapons(curweapondata, weapondata);
	}
	weapon = weapondata["weapon"];
	weapon_give(weapon, undefined, undefined, 1);
	if(weapon != level.weaponnone)
	{
		self setweaponammoclip(weapon, weapondata["clip"]);
		self setweaponammostock(weapon, weapondata["stock"]);
		if(isdefined(weapondata["fuel"]))
		{
			self SetWeaponAmmoFuel(weapon, weapondata["fuel"]);
		}
		if(isdefined(weapondata["heat"]) && isdefined(weapondata["overheat"]))
		{
			self SetWeaponOverheating(weapondata["overheat"], weapondata["heat"], weapon);
		}
	}
	dw_weapon = weapon.dualWieldWeapon;
	if(dw_weapon != level.weaponnone)
	{
		if(!self hasweapon(dw_weapon))
		{
			self giveweapon(dw_weapon);
		}
		self setweaponammoclip(dw_weapon, weapondata["lh_clip"]);
	}
	alt_weapon = weapon.altweapon;
	if(alt_weapon != level.weaponnone && alt_weapon.altweapon == weapon)
	{
		if(!self hasweapon(alt_weapon))
		{
			self giveweapon(alt_weapon);
		}
		self setweaponammoclip(alt_weapon, weapondata["alt_clip"]);
		self setweaponammostock(alt_weapon, weapondata["alt_stock"]);
		return;
	}
	ERROR: Exception occured: Stack empty.
}

/*
	Name: weapondata_take
	Namespace: zm_weapons
	Checksum: 0x424F4353
	Offset: 0xFB10
	Size: 0x148
	Parameters: 1
	Flags: None
	Line Number: 5091
*/
function weapondata_take(weapondata)
{
	weapon = weapondata["weapon"];
	if(weapon != level.weaponnone)
	{
		if(self hasweapon(weapon))
		{
			self weapon_take(weapon);
		}
	}
	dw_weapon = weapon.dualWieldWeapon;
	if(dw_weapon != level.weaponnone)
	{
		if(self hasweapon(dw_weapon))
		{
			self weapon_take(dw_weapon);
		}
	}
	for(alt_weapon = weapon.altweapon; alt_weapon != level.weaponnone; alt_weapon = weapon.altweapon)
	{
		if(self hasweapon(alt_weapon))
		{
			self weapon_take(alt_weapon);
		}
	}
	return;
	ERROR: Exception occured: Stack empty.
}

/*
	Name: create_loadout
	Namespace: zm_weapons
	Checksum: 0x424F4353
	Offset: 0xFC60
	Size: 0x180
	Parameters: 1
	Flags: None
	Line Number: 5130
*/
function create_loadout(weapons)
{
	weaponnone = getweapon("none");
	if(isdefined(level.weaponnone))
	{
		weaponnone = level.weaponnone;
	}
	loadout = spawnstruct();
	loadout.weapons = [];
	foreach(weapon in weapons)
	{
		if(isstring(weapon))
		{
			weapon = getweapon(weapon);
		}
		loadout.weapons[weapon.name] = get_default_weapondata(weapon);
		if(!isdefined(loadout.current))
		{
			loadout.current = weapon;
		}
	}
	return loadout;
}

/*
	Name: player_get_loadout
	Namespace: zm_weapons
	Checksum: 0x424F4353
	Offset: 0xFDE8
	Size: 0x120
	Parameters: 0
	Flags: None
	Line Number: 5164
*/
function player_get_loadout()
{
	loadout = spawnstruct();
	loadout.current = self getcurrentweapon();
	loadout.stowed = self GetStowedWeapon();
	loadout.weapons = [];
	foreach(weapon in self getweaponslist())
	{
		loadout.weapons[weapon.name] = get_player_weapondata(self, weapon);
	}
	return loadout;
}

/*
	Name: player_give_loadout
	Namespace: zm_weapons
	Checksum: 0x424F4353
	Offset: 0xFF10
	Size: 0x1E8
	Parameters: 3
	Flags: None
	Line Number: 5187
*/
function player_give_loadout(loadout, replace_existing, immediate_switch)
{
	if(!isdefined(replace_existing))
	{
		replace_existing = 1;
	}
	if(!isdefined(immediate_switch))
	{
		immediate_switch = 0;
	}
	if(isdefined(replace_existing) && replace_existing)
	{
		self takeallweapons();
	}
	foreach(weapondata in loadout.weapons)
	{
		self weapondata_give(weapondata);
	}
	if(!zm_utility::is_offhand_weapon(loadout.current))
	{
		if(immediate_switch)
		{
			self switchtoweaponimmediate(loadout.current);
		}
		else
		{
			self switchtoweapon(loadout.current);
		}
	}
	else if(immediate_switch)
	{
		self switchtoweaponimmediate();
	}
	else
	{
		self switchtoweapon();
	}
	if(isdefined(loadout.stowed))
	{
		self SetStowedWeapon(loadout.stowed);
		return;
	}
}

/*
	Name: player_take_loadout
	Namespace: zm_weapons
	Checksum: 0x424F4353
	Offset: 0x10100
	Size: 0xA0
	Parameters: 1
	Flags: None
	Line Number: 5241
*/
function player_take_loadout(loadout)
{
	foreach(weapondata in loadout.weapons)
	{
		self weapondata_take(weapondata);
	}
}

/*
	Name: register_zombie_weapon_callback
	Namespace: zm_weapons
	Checksum: 0x424F4353
	Offset: 0x101A8
	Size: 0x58
	Parameters: 2
	Flags: None
	Line Number: 5259
*/
function register_zombie_weapon_callback(weapon, func)
{
	if(!isdefined(level.zombie_weapons_callbacks))
	{
		level.zombie_weapons_callbacks = [];
	}
	if(!isdefined(level.zombie_weapons_callbacks[weapon]))
	{
		level.zombie_weapons_callbacks[weapon] = func;
	}
}

/*
	Name: set_stowed_weapon
	Namespace: zm_weapons
	Checksum: 0x424F4353
	Offset: 0x10208
	Size: 0x50
	Parameters: 1
	Flags: None
	Line Number: 5281
*/
function set_stowed_weapon(weapon)
{
	self.weapon_stowed = weapon;
	if(!(isdefined(self.stowed_weapon_suppressed) && self.stowed_weapon_suppressed))
	{
		self SetStowedWeapon(self.weapon_stowed);
	}
}

/*
	Name: clear_stowed_weapon
	Namespace: zm_weapons
	Checksum: 0x424F4353
	Offset: 0x10260
	Size: 0x28
	Parameters: 0
	Flags: None
	Line Number: 5300
*/
function clear_stowed_weapon()
{
	self.weapon_stowed = undefined;
	self ClearStowedWeapon();
	return;
	~;
	ERROR: Exception occured: Stack empty.
}

/*
	Name: suppress_stowed_weapon
	Namespace: zm_weapons
	Checksum: 0x424F4353
	Offset: 0x10290
	Size: 0x68
	Parameters: 1
	Flags: None
	Line Number: 5319
*/
function suppress_stowed_weapon(onOff)
{
	self.stowed_weapon_suppressed = onOff;
	if(onOff || !isdefined(self.weapon_stowed))
	{
		self ClearStowedWeapon();
	}
	else
	{
		self SetStowedWeapon(self.weapon_stowed);
	}
}

/*
	Name: checkStringValid
	Namespace: zm_weapons
	Checksum: 0x424F4353
	Offset: 0x10300
	Size: 0x28
	Parameters: 1
	Flags: None
	Line Number: 5342
*/
function checkStringValid(str)
{
	if(str != "")
	{
		return str;
	}
	return undefined;
}

/*
	Name: load_weapon_spec_from_table
	Namespace: zm_weapons
	Checksum: 0x424F4353
	Offset: 0x10330
	Size: 0x520
	Parameters: 2
	Flags: None
	Line Number: 5361
*/
function load_weapon_spec_from_table(table, first_row)
{
	gametype = getdvarstring("ui_gametype");
	index = 1;
	for(row = tablelookuprow(table, index); isdefined(row); row = tablelookuprow(table, index))
	{
		weapon_name = checkStringValid(row[0]);
		upgrade_name = checkStringValid(row[1]);
		hint = checkStringValid(row[2]);
		cost = int(row[3]);
		weaponVO = checkStringValid(row[4]);
		weaponVOresp = checkStringValid(row[5]);
		ammo_cost = undefined;
		if("" != row[6])
		{
			ammo_cost = int(row[6]);
		}
		create_vox = checkStringValid(row[7]);
		is_zcleansed = tolower(row[8]) == "true";
		in_box = tolower(row[9]) == "true";
		upgrade_in_box = tolower(row[10]) == "true";
		is_limited = tolower(row[11]) == "true";
		is_aat_exempt = tolower(row[17]) == "true";
		limit = int(row[12]);
		upgrade_limit = int(row[13]);
		content_restrict = row[14];
		wallbuy_autospawn = tolower(row[15]) == "true";
		WEAPON_CLASS = checkStringValid(row[16]);
		is_wonder_weapon = tolower(row[18]) == "true";
		force_attachments = tolower(row[19]);
		zm_utility::include_weapon(weapon_name, in_box);
		if(isdefined(upgrade_name))
		{
			zm_utility::include_weapon(upgrade_name, upgrade_in_box);
		}
		add_zombie_weapon(weapon_name, upgrade_name, hint, cost, weaponVO, weaponVOresp, ammo_cost, create_vox, is_wonder_weapon, force_attachments);
		if(is_limited)
		{
			if(isdefined(limit))
			{
				add_limited_weapon(weapon_name, limit);
			}
			if(isdefined(upgrade_limit) && isdefined(upgrade_name))
			{
				add_limited_weapon(upgrade_name, upgrade_limit);
			}
		}
		if(is_aat_exempt && isdefined(upgrade_name))
		{
			aat::register_aat_exemption(getweapon(upgrade_name));
		}
		index++;
	}
	return;
	ERROR: Bad function call
}

/*
	Name: autofill_wallbuys_init
	Namespace: zm_weapons
	Checksum: 0x424F4353
	Offset: 0x10858
	Size: 0x698
	Parameters: 0
	Flags: None
	Line Number: 5428
*/
function autofill_wallbuys_init()
{
	Wallbuys = struct::get_array("wallbuy_autofill", "targetname");
	if(!isdefined(Wallbuys) || Wallbuys.size == 0 || !isdefined(level.wallbuy_autofill_weapons) || level.wallbuy_autofill_weapons.size == 0)
	{
		return;
	}
	level.use_autofill_wallbuy = 1;
	level.active_autofill_wallbuys = [];
	array_keys["all"] = getarraykeys(level.wallbuy_autofill_weapons["all"]);
	class_all = [];
	index = 0;
	foreach(wallbuy in Wallbuys)
	{
		WEAPON_CLASS = wallbuy.script_string;
		weapon = undefined;
		if(isdefined(WEAPON_CLASS) && WEAPON_CLASS != "")
		{
			if(!isdefined(array_keys[WEAPON_CLASS]) && isdefined(level.wallbuy_autofill_weapons[WEAPON_CLASS]))
			{
				array_keys[WEAPON_CLASS] = getarraykeys(level.wallbuy_autofill_weapons[WEAPON_CLASS]);
			}
			if(isdefined(array_keys[WEAPON_CLASS]))
			{
				for(i = 0; i < array_keys[WEAPON_CLASS].size; i++)
				{
					if(level.wallbuy_autofill_weapons["all"][array_keys[WEAPON_CLASS][i]])
					{
						weapon = array_keys[WEAPON_CLASS][i];
						level.wallbuy_autofill_weapons["all"][weapon] = 0;
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
			class_all[class_all.size] = wallbuy;
			continue;
		}
		if(!isdefined(weapon))
		{
			continue;
		}
		wallbuy.zombie_weapon_upgrade = weapon.name;
		wallbuy.weapon = weapon;
		right = anglestoright(wallbuy.angles);
		wallbuy.origin = wallbuy.origin - right * 2;
		wallbuy.target = "autofill_wallbuy_" + index;
		target_struct = spawnstruct();
		target_struct.targetname = wallbuy.target;
		target_struct.angles = wallbuy.angles;
		target_struct.origin = wallbuy.origin;
		model = wallbuy.weapon.worldmodel;
		target_struct.model = model;
		target_struct struct::init();
		level.active_autofill_wallbuys[level.active_autofill_wallbuys.size] = wallbuy;
		index++;
	}
	foreach(wallbuy in class_all)
	{
		weapon = undefined;
		for(i = 0; i < array_keys["all"].size; i++)
		{
			if(level.wallbuy_autofill_weapons["all"][array_keys["all"][i]])
			{
				weapon = array_keys["all"][i];
				level.wallbuy_autofill_weapons["all"][weapon] = 0;
				break;
			}
		}
		if(!isdefined(weapon))
		{
			break;
		}
		wallbuy.zombie_weapon_upgrade = weapon.name;
		wallbuy.weapon = weapon;
		right = anglestoright(wallbuy.angles);
		wallbuy.origin = wallbuy.origin - right * 2;
		wallbuy.target = "autofill_wallbuy_" + index;
		target_struct = spawnstruct();
		target_struct.targetname = wallbuy.target;
		target_struct.angles = wallbuy.angles;
		target_struct.origin = wallbuy.origin;
		model = wallbuy.weapon.worldmodel;
		target_struct.model = model;
		target_struct struct::init();
		level.active_autofill_wallbuys[level.active_autofill_wallbuys.size] = wallbuy;
		index++;
	}
	return;
	ERROR: Exception occured: Stack empty.
}

/*
	Name: is_wallbuy
	Namespace: zm_weapons
	Checksum: 0x424F4353
	Offset: 0x10EF8
	Size: 0xC0
	Parameters: 1
	Flags: None
	Line Number: 5536
*/
function is_wallbuy(w_to_check)
{
	w_base = get_base_weapon(w_to_check);
	foreach(s_wallbuy in level._spawned_wallbuys)
	{
		if(s_wallbuy.weapon == w_base)
		{
			return 1;
		}
	}
	return 0;
}

/*
	Name: is_wonder_weapon
	Namespace: zm_weapons
	Checksum: 0x424F4353
	Offset: 0x10FC0
	Size: 0x66
	Parameters: 1
	Flags: None
	Line Number: 5559
*/
function is_wonder_weapon(w_to_check)
{
	w_base = get_base_weapon(w_to_check);
	if(isdefined(level.zombie_weapons[w_base]) && level.zombie_weapons[w_base].is_wonder_weapon)
	{
		return 1;
	}
	return 0;
}

