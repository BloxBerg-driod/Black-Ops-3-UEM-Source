#include scripts\codescripts\struct;
#include scripts\shared\callbacks_shared;
#include scripts\shared\clientfield_shared;
#include scripts\shared\demo_shared;
#include scripts\shared\flag_shared;
#include scripts\shared\gameobjects_shared;
#include scripts\shared\hud_util_shared;
#include scripts\shared\laststand_shared;
#include scripts\shared\scoreevents_shared;
#include scripts\shared\system_shared;
#include scripts\shared\util_shared;
#include scripts\shared\visionset_mgr_shared;
#include scripts\zm\_util;
#include scripts\zm\_zm_equipment;
#include scripts\zm\_zm_hero_weapon;
#include scripts\zm\_zm_perks;
#include scripts\zm\_zm_pers_upgrades_functions;
#include scripts\zm\_zm_stats;
#include scripts\zm\_zm_utility;
#include scripts\zm\_zm_weapons;

#namespace namespace_zm_laststand;

/*
	Name: function___init__sytem__
	Namespace: namespace_zm_laststand
	Checksum: 0x424F4353
	Offset: 0x640
	Size: 0x38
	Parameters: 0
	Flags: AutoExec
	Line Number: 33
*/
function autoexec function___init__sytem__()
{
	namespace_system::function_register("zm_laststand", &function___init__, undefined, undefined);
	return;
	ERROR: Exception occured: Stack empty.
}

/*
	Name: function___init__
	Namespace: namespace_zm_laststand
	Checksum: 0x424F4353
	Offset: 0x680
	Size: 0x200
	Parameters: 0
	Flags: None
	Line Number: 50
*/
function function___init__()
{
	function_laststand_global_init();
	level.var_laststand_update_clientfields = [];
	for(var_i = 0; var_i < 4; var_i++)
	{
		level.var_laststand_update_clientfields[var_i] = "laststand_update" + var_i;
		namespace_clientfield::function_register("world", level.var_laststand_update_clientfields[var_i], 1, 5, "counter");
	}
	level.var_weaponSuicide = function_GetWeapon("death_self");
	level.var_primaryProgressBarX = 0;
	level.var_primaryProgressBarY = 110;
	level.var_primaryProgressBarHeight = 4;
	level.var_primaryProgressBarWidth = 120;
	level.var_primaryProgressBarY_ss = 280;
	if(function_GetDvarString("revive_trigger_radius") == "")
	{
		function_SetDvar("revive_trigger_radius", "40");
	}
	level.var_lastStandGetupAllowed = 0;
	if(!isdefined(level.var_vsmgr_prio_visionset_zm_laststand))
	{
		level.var_vsmgr_prio_visionset_zm_laststand = 1000;
	}
	namespace_visionset_mgr::function_register_info("visionset", "zombie_last_stand", 1, level.var_vsmgr_prio_visionset_zm_laststand, 31, 1, &namespace_visionset_mgr::function_ramp_in_thread_per_player, 0);
	if(!isdefined(level.var_vsmgr_prio_visionset_zm_death))
	{
		level.var_vsmgr_prio_visionset_zm_death = 1100;
	}
	namespace_visionset_mgr::function_register_info("visionset", "zombie_death", 1, level.var_vsmgr_prio_visionset_zm_death, 31, 1, &namespace_visionset_mgr::function_ramp_in_thread_per_player, 0);
	return;
	ERROR: Exception occured: Stack empty.
}

/*
	Name: function_laststand_global_init
	Namespace: namespace_zm_laststand
	Checksum: 0x424F4353
	Offset: 0x888
	Size: 0xA8
	Parameters: 0
	Flags: None
	Line Number: 94
*/
function function_laststand_global_init()
{
	level.var_CONST_LASTSTAND_GETUP_COUNT_START = 0;
	level.var_CONST_LASTSTAND_GETUP_BAR_START = 0.5;
	level.var_CONST_LASTSTAND_GETUP_BAR_REGEN = 0.0025;
	level.var_CONST_LASTSTAND_GETUP_BAR_DAMAGE = 0.1;
	level.var_player_name_directive = [];
	level.var_player_name_directive[0] = &"ZOMBIE_PLAYER_NAME_0";
	level.var_player_name_directive[1] = &"ZOMBIE_PLAYER_NAME_1";
	level.var_player_name_directive[2] = &"ZOMBIE_PLAYER_NAME_2";
	level.var_player_name_directive[3] = &"ZOMBIE_PLAYER_NAME_3";
}

/*
	Name: function_player_last_stand_stats
	Namespace: namespace_zm_laststand
	Checksum: 0x424F4353
	Offset: 0x938
	Size: 0x2C8
	Parameters: 9
	Flags: None
	Line Number: 117
*/
function function_player_last_stand_stats(var_eInflictor, var_attacker, var_iDamage, var_sMeansOfDeath, var_weapon, var_vDir, var_sHitLoc, var_psOffsetTime, var_deathAnimDuration)
{
	if(isdefined(var_attacker) && function_isPlayer(var_attacker) && var_attacker != self)
	{
		if("zcleansed" == level.var_gametype)
		{
			namespace_demo::function_bookmark("kill", GetTime(), var_attacker, self, 0, var_eInflictor);
		}
		if("zcleansed" == level.var_gametype)
		{
			if(!(isdefined(var_attacker.var_is_zombie) && var_attacker.var_is_zombie))
			{
				var_attacker.var_kills++;
			}
			else
			{
				var_attacker.var_downs++;
			}
		}
		else
		{
			var_attacker.var_kills++;
		}
		var_attacker namespace_zm_stats::function_increment_client_stat("kills");
		var_attacker namespace_zm_stats::function_increment_player_stat("kills");
		var_attacker function_addweaponstat(var_weapon, "kills", 1);
		if(namespace_zm_utility::function_is_headshot(var_weapon, var_sHitLoc, var_sMeansOfDeath))
		{
			var_attacker.var_headshots++;
			var_attacker namespace_zm_stats::function_increment_client_stat("headshots");
			var_attacker function_addweaponstat(var_weapon, "headshots", 1);
			var_attacker namespace_zm_stats::function_increment_player_stat("headshots");
		}
	}
	self function_increment_downed_stat();
	if(level namespace_flag::function_get("solo_game") && !self.var_lives && function_getnumconnectedplayers() < 2)
	{
		self namespace_zm_stats::function_increment_client_stat("deaths");
		self namespace_zm_stats::function_increment_player_stat("deaths");
	}
}

/*
	Name: function_increment_downed_stat
	Namespace: namespace_zm_laststand
	Checksum: 0x424F4353
	Offset: 0xC08
	Size: 0xF8
	Parameters: 0
	Flags: None
	Line Number: 169
*/
function function_increment_downed_stat()
{
	if("zcleansed" != level.var_gametype)
	{
		self.var_downs++;
	}
	self namespace_zm_stats::function_increment_global_stat("TOTAL_DOWNS");
	self namespace_zm_stats::function_increment_map_stat("TOTAL_DOWNS");
	self namespace_zm_stats::function_increment_client_stat("downs");
	self namespace_zm_stats::function_increment_player_stat("downs");
	var_zoneName = self namespace_zm_utility::function_get_current_zone();
	if(!isdefined(var_zoneName))
	{
		var_zoneName = "";
	}
	self function_RecordPlayerDownZombies(var_zoneName);
}

/*
	Name: function_PlayerLastStand
	Namespace: namespace_zm_laststand
	Checksum: 0x424F4353
	Offset: 0xD08
	Size: 0x440
	Parameters: 9
	Flags: None
	Line Number: 197
*/
function function_PlayerLastStand(var_eInflictor, var_attacker, var_iDamage, var_sMeansOfDeath, var_weapon, var_vDir, var_sHitLoc, var_psOffsetTime, var_deathAnimDuration)
{
	self notify("hash_entering_last_stand");
	self function_DisableWeaponCycling();
	if(isdefined(level.var__game_module_player_laststand_callback))
	{
		self [[level.var__game_module_player_laststand_callback]](var_eInflictor, var_attacker, var_iDamage, var_sMeansOfDeath, var_weapon, var_vDir, var_sHitLoc, var_psOffsetTime, var_deathAnimDuration);
	}
	if(self namespace_laststand::function_player_is_in_laststand())
	{
		return;
	}
	if(isdefined(self.var_in_zombify_call) && self.var_in_zombify_call)
	{
		return;
	}
	self thread function_player_last_stand_stats(var_eInflictor, var_attacker, var_iDamage, var_sMeansOfDeath, var_weapon, var_vDir, var_sHitLoc, var_psOffsetTime, var_deathAnimDuration);
	if(isdefined(level.var_playerlaststand_func))
	{
		[[level.var_playerlaststand_func]](var_eInflictor, var_attacker, var_iDamage, var_sMeansOfDeath, var_weapon, var_vDir, var_sHitLoc, var_psOffsetTime, var_deathAnimDuration);
	}
	self.var_health = 1;
	self.var_laststand = 1;
	self function_set_ignoreme(1);
	namespace_callback::function_callback("hash_6751ab5b");
	self thread namespace_gameobjects::function_on_player_last_stand();
	if(!(isdefined(self.var_no_revive_trigger) && self.var_no_revive_trigger))
	{
		self function_revive_trigger_spawn();
	}
	else
	{
		self function_UndoLastStand();
	}
	if(isdefined(self.var_is_zombie) && self.var_is_zombie)
	{
		self function_TakeAllWeapons();
		if(isdefined(var_attacker) && function_isPlayer(var_attacker) && var_attacker != self)
		{
			var_attacker notify("hash_killed_a_zombie_player", var_eInflictor, self, var_iDamage, var_sMeansOfDeath, var_weapon, var_vDir, var_sHitLoc, var_psOffsetTime, var_deathAnimDuration);
		}
	}
	else
	{
		self function_laststand_disable_player_weapons();
		self function_laststand_give_pistol();
	}
	if(isdefined(level.var_playerSuicideAllowed) && level.var_playerSuicideAllowed && function_GetPlayers().size > 1)
	{
		if(!isdefined(level.var_canPlayerSuicide) || self [[level.var_canPlayerSuicide]]())
		{
			self thread function_suicide_trigger_spawn();
		}
	}
	if(isdefined(self.var_disabled_perks))
	{
		self.var_disabled_perks = [];
	}
	if(level.var_lastStandGetupAllowed)
	{
		self thread function_laststand_getup();
	}
	else
	{
		var_bleedout_time = function_GetDvarFloat("player_lastStandBleedoutTime");
		if(isdefined(self.var_n_bleedout_time_multiplier))
		{
			var_bleedout_time = var_bleedout_time * self.var_n_bleedout_time_multiplier;
		}
		level namespace_clientfield::function_increment("laststand_update" + self function_GetEntityNumber(), 30);
		self thread function_laststand_bleedout(var_bleedout_time);
	}
	namespace_demo::function_bookmark("player_downed", GetTime(), self);
	self notify("hash_player_downed");
	self thread function_refire_player_downed();
	self thread namespace_laststand::function_cleanup_laststand_on_disconnect();
}

/*
	Name: function_refire_player_downed
	Namespace: namespace_zm_laststand
	Checksum: 0x424F4353
	Offset: 0x1150
	Size: 0x48
	Parameters: 0
	Flags: None
	Line Number: 285
*/
function function_refire_player_downed()
{
	self endon("hash_player_revived");
	self endon("hash_death");
	self endon("hash_disconnect");
	wait(1);
	if(self.var_num_perks)
	{
		self notify("hash_player_downed");
		return;
	}
	ERROR: Exception occured: Stack empty.
}

/*
	Name: function_laststand_disable_player_weapons
	Namespace: namespace_zm_laststand
	Checksum: 0x424F4353
	Offset: 0x11A0
	Size: 0x3E0
	Parameters: 0
	Flags: None
	Line Number: 309
*/
function function_laststand_disable_player_weapons()
{
	wait(1);
	self function_DisableWeaponCycling();
	var_weaponInventory = self function_GetWeaponsList(1);
	self.var_laststandPrimaryWeapons = self function_GetWeaponsListPrimaries();
	self.var_lastActiveWeapon = self function_GetCurrentWeapon();
	var_quickswitch = 0;
	if(isdefined(self) && self function_IsSwitchingWeapons())
	{
		var_quickswitch = 1;
	}
	if(self function_IsThrowingGrenade() && namespace_zm_utility::function_is_offhand_weapon(self.var_lastActiveWeapon))
	{
		var_quickswitch = 1;
	}
	if(namespace_zm_utility::function_is_hero_weapon(self.var_lastActiveWeapon))
	{
		var_quickswitch = 1;
	}
	if(self.var_lastActiveWeapon.var_isRiotShield)
	{
		var_quickswitch = 1;
	}
	if(var_quickswitch)
	{
		if(isdefined(self.var_laststandPrimaryWeapons) && self.var_laststandPrimaryWeapons.size > 0)
		{
			self function_SwitchToWeaponImmediate();
		}
		else
		{
			self namespace_zm_weapons::function_give_fallback_weapon(1);
		}
		self namespace_util::function_waittill_any_timeout(1, "weapon_change_complete");
	}
	self.var_lastActiveWeapon = self function_GetCurrentWeapon();
	self function_SetLastStandPrevWeap(self.var_lastActiveWeapon);
	self.var_laststandpistol = undefined;
	self.var_hadpistol = 0;
	for(var_i = 0; var_i < var_weaponInventory.size; var_i++)
	{
		var_weapon = var_weaponInventory[var_i];
		var_wclass = var_weapon.var_weapClass;
		if(var_weapon.var_isBallisticKnife)
		{
			var_wclass = "knife";
		}
		if(var_wclass == "pistol" || var_wclass == "pistol spread" || var_wclass == "pistolspread" && !isdefined(self.var_laststandpistol))
		{
			self.var_laststandpistol = var_weapon;
			self.var_hadpistol = 1;
		}
		if(var_weapon == level.var_weaponReviveTool || var_weapon === self.var_weaponReviveTool)
		{
			self namespace_zm_stats::function_increment_client_stat("failed_sacrifices");
			self namespace_zm_stats::function_increment_player_stat("failed_sacrifices");
			continue;
		}
		if(var_weapon.var_isPerkBottle)
		{
			self function_TakeWeapon(var_weapon);
			self.var_lastActiveWeapon = level.var_weaponNone;
			continue;
		}
	}
	if(isdefined(self.var_hadpistol) && self.var_hadpistol && isdefined(level.var_zombie_last_stand_pistol_memory))
	{
		self [[level.var_zombie_last_stand_pistol_memory]]();
	}
	if(!isdefined(self.var_laststandpistol))
	{
		self.var_laststandpistol = level.var_laststandpistol;
	}
	self notify("hash_weapons_taken_for_last_stand");
	return;
	waittillframeend;
}

/*
	Name: function_laststand_enable_player_weapons
	Namespace: namespace_zm_laststand
	Checksum: 0x424F4353
	Offset: 0x1588
	Size: 0x238
	Parameters: 0
	Flags: None
	Line Number: 398
*/
function function_laststand_enable_player_weapons()
{
	if(self function_hasPerk("specialty_additionalprimaryweapon") && isdefined(self.var_weapon_taken_by_losing_specialty_additionalprimaryweapon))
	{
		if(isdefined(level.var_return_additionalprimaryweapon))
		{
			self [[level.var_return_additionalprimaryweapon]](self.var_weapon_taken_by_losing_specialty_additionalprimaryweapon);
		}
		else
		{
			self namespace_zm_weapons::function_give_build_kit_weapon(self.var_weapon_taken_by_losing_specialty_additionalprimaryweapon);
		}
	}
	else if(isdefined(self.var_weapon_taken_by_losing_specialty_additionalprimaryweapon) && self.var_lastActiveWeapon == self.var_weapon_taken_by_losing_specialty_additionalprimaryweapon)
	{
		self.var_lastActiveWeapon = level.var_weaponNone;
	}
	if(isdefined(self.var_laststandpistol) && !function_IsInArray(self.var_laststandPrimaryWeapons, self.var_laststandpistol))
	{
		self function_TakeWeapon(self.var_laststandpistol);
	}
	if(isdefined(self.var_hadpistol) && self.var_hadpistol == 1 && isdefined(level.var_zombie_last_stand_ammo_return) && isdefined(self.var_laststandpistol))
	{
		[[level.var_zombie_last_stand_ammo_return]]();
	}
	self function_EnableWeaponCycling();
	self function_EnableOffhandWeapons();
	if(self.var_lastActiveWeapon != level.var_weaponNone && self function_HasWeapon(self.var_lastActiveWeapon) && !namespace_zm_utility::function_is_placeable_mine(self.var_lastActiveWeapon) && !namespace_zm_equipment::function_is_equipment(self.var_lastActiveWeapon) && !namespace_zm_utility::function_is_hero_weapon(self.var_lastActiveWeapon))
	{
		self function_SwitchToWeapon(self.var_lastActiveWeapon);
	}
	else
	{
		self function_SwitchToWeapon();
	}
	self.var_laststandpistol = undefined;
	return;
}

/*
	Name: function_laststand_has_players_weapons_returned
	Namespace: namespace_zm_laststand
	Checksum: 0x424F4353
	Offset: 0x17C8
	Size: 0x28
	Parameters: 1
	Flags: None
	Line Number: 447
*/
function function_laststand_has_players_weapons_returned(var_e_player)
{
	if(isdefined(var_e_player.var_laststandpistol))
	{
		return 0;
	}
	return 1;
}

/*
	Name: function_laststand_clean_up_on_disconnect
	Namespace: namespace_zm_laststand
	Checksum: 0x424F4353
	Offset: 0x17F8
	Size: 0x108
	Parameters: 3
	Flags: None
	Line Number: 466
*/
function function_laststand_clean_up_on_disconnect(var_e_revivee, var_w_reviver, var_w_revive_tool)
{
	self endon("hash_do_revive_ended_normally");
	var_reviveTrigger = var_e_revivee.var_reviveTrigger;
	var_e_revivee waittill("hash_disconnect");
	if(isdefined(var_reviveTrigger))
	{
		var_reviveTrigger function_delete();
	}
	self namespace_laststand::function_cleanup_suicide_hud();
	if(isdefined(self.var_reviveProgressBar))
	{
		self.var_reviveProgressBar namespace_hud::function_destroyElem();
	}
	if(isdefined(self.var_reviveTextHud))
	{
		self.var_reviveTextHud function_destroy();
	}
	if(isdefined(var_w_reviver) && isdefined(var_w_revive_tool))
	{
		self function_revive_give_back_weapons(var_w_reviver, var_w_revive_tool);
		return;
	}
	ERROR: Exception occured: Stack empty.
}

/*
	Name: function_laststand_clean_up_reviving_any
	Namespace: namespace_zm_laststand
	Checksum: 0x424F4353
	Offset: 0x1908
	Size: 0xB8
	Parameters: 1
	Flags: None
	Line Number: 502
*/
function function_laststand_clean_up_reviving_any(var_e_revivee)
{
	self endon("hash_do_revive_ended_normally");
	var_e_revivee namespace_util::function_waittill_any("disconnect", "zombified", "stop_revive_trigger");
	self.var_is_reviving_any--;
	if(0 > self.var_is_reviving_any)
	{
		self.var_is_reviving_any = 0;
	}
	if(isdefined(self.var_reviveProgressBar))
	{
		self.var_reviveProgressBar namespace_hud::function_destroyElem();
	}
	if(isdefined(self.var_reviveTextHud))
	{
		self.var_reviveTextHud function_destroy();
	}
}

/*
	Name: function_laststand_give_pistol
	Namespace: namespace_zm_laststand
	Checksum: 0x424F4353
	Offset: 0x19C8
	Size: 0xF0
	Parameters: 0
	Flags: None
	Line Number: 531
*/
function function_laststand_give_pistol()
{
	/#
		namespace_::function_Assert(isdefined(self.var_laststandpistol));
	#/
	/#
		namespace_::function_Assert(self.var_laststandpistol != level.var_weaponNone);
	#/
	if(isdefined(level.var_zombie_last_stand))
	{
		[[level.var_zombie_last_stand]]();
	}
	else
	{
		self function_GiveWeapon(self.var_laststandpistol);
		self function_giveMaxAmmo(self.var_laststandpistol);
		self function_SwitchToWeapon(self.var_laststandpistol);
	}
	self thread function_wait_switch_weapon(1, self.var_laststandpistol);
}

/*
	Name: function_wait_switch_weapon
	Namespace: namespace_zm_laststand
	Checksum: 0x424F4353
	Offset: 0x1AC0
	Size: 0x68
	Parameters: 2
	Flags: None
	Line Number: 562
*/
function function_wait_switch_weapon(var_n_delay, var_w_weapon)
{
	self endon("hash_player_revived");
	self endon("hash_player_suicide");
	self endon("hash_zombified");
	self endon("hash_disconnect");
	wait(var_n_delay);
	self function_SwitchToWeapon(var_w_weapon);
}

/*
	Name: function_laststand_bleedout
	Namespace: namespace_zm_laststand
	Checksum: 0x424F4353
	Offset: 0x1B30
	Size: 0x2F8
	Parameters: 1
	Flags: None
	Line Number: 582
*/
function function_laststand_bleedout(var_delay)
{
	self endon("hash_player_revived");
	self endon("hash_player_suicide");
	self endon("hash_zombified");
	self endon("hash_disconnect");
	if(isdefined(self.var_is_zombie) && self.var_is_zombie || (isdefined(self.var_no_revive_trigger) && self.var_no_revive_trigger))
	{
		self notify("hash_bled_out");
		namespace_util::function_wait_network_frame();
		self function_bleed_out();
		return;
	}
	self namespace_clientfield::function_set("zmbLastStand", 1);
	self.var_bleedout_time = var_delay;
	var_n_default_bleedout_time = function_GetDvarFloat("player_lastStandBleedoutTime");
	var_n_bleedout_time = self.var_bleedout_time;
	var_n_start_time = GetTime();
	while(self.var_bleedout_time > function_Int(var_delay * 0.5))
	{
		if(var_n_bleedout_time > var_n_default_bleedout_time && !isdefined(self.var_n_bleedout_time_multiplier))
		{
			var_n_current_time = GetTime();
			var_n_total_time = var_n_current_time - var_n_start_time / 1000;
			if(var_n_total_time > var_n_default_bleedout_time)
			{
				var_delay = 4;
				self.var_bleedout_time = 2;
				break;
			}
		}
		self.var_bleedout_time = self.var_bleedout_time - 1;
		wait(1);
	}
	namespace_visionset_mgr::function_activate("visionset", "zombie_death", self, var_delay * 0.5);
	while(self.var_bleedout_time > 0)
	{
		self.var_bleedout_time = self.var_bleedout_time - 1;
		level namespace_clientfield::function_increment("laststand_update" + self function_GetEntityNumber(), self.var_bleedout_time + 1);
		wait(1);
	}
	while(isdefined(self.var_reviveTrigger) && isdefined(self.var_reviveTrigger.var_beingRevived) && self.var_reviveTrigger.var_beingRevived == 1)
	{
		wait(0.1);
	}
	self notify("hash_bled_out");
	namespace_util::function_wait_network_frame();
	self function_bleed_out();
}

/*
	Name: function_bleed_out
	Namespace: namespace_zm_laststand
	Checksum: 0x424F4353
	Offset: 0x1E30
	Size: 0x228
	Parameters: 0
	Flags: None
	Line Number: 642
*/
function function_bleed_out()
{
	self namespace_laststand::function_cleanup_suicide_hud();
	if(isdefined(self.var_reviveTrigger))
	{
		self.var_reviveTrigger function_delete();
	}
	self.var_reviveTrigger = undefined;
	self namespace_clientfield::function_set("zmbLastStand", 0);
	self namespace_zm_stats::function_increment_client_stat("deaths");
	self namespace_zm_stats::function_increment_player_stat("deaths");
	self function_RecordPlayerDeathZombies();
	self.var_last_bleed_out_time = GetTime();
	self namespace_zm_equipment::function_take();
	self namespace_zm_hero_weapon::function_take_hero_weapon();
	level namespace_clientfield::function_increment("laststand_update" + self function_GetEntityNumber(), 1);
	namespace_demo::function_bookmark("zm_player_bledout", GetTime(), self, undefined, 1);
	level notify("hash_bleed_out", self.var_characterindex);
	self function_UndoLastStand();
	namespace_visionset_mgr::function_deactivate("visionset", "zombie_last_stand", self);
	namespace_visionset_mgr::function_deactivate("visionset", "zombie_death", self);
	if(isdefined(level.var_is_zombie_level) && level.var_is_zombie_level)
	{
		self thread [[level.var_player_becomes_zombie]]();
	}
	else if(isdefined(level.var_is_specops_level) && level.var_is_specops_level)
	{
		self thread [[level.var_spawnSpectator]]();
	}
	else
	{
		self function_set_ignoreme(0);
	}
}

/*
	Name: function_suicide_trigger_spawn
	Namespace: namespace_zm_laststand
	Checksum: 0x424F4353
	Offset: 0x2060
	Size: 0x180
	Parameters: 0
	Flags: None
	Line Number: 687
*/
function function_suicide_trigger_spawn()
{
	var_radius = function_GetDvarInt("revive_trigger_radius");
	self.var_suicidePrompt = function_newClientHudElem(self);
	self.var_suicidePrompt.var_alignX = "center";
	self.var_suicidePrompt.var_alignY = "middle";
	self.var_suicidePrompt.var_horzAlign = "center";
	self.var_suicidePrompt.var_vertAlign = "bottom";
	self.var_suicidePrompt.var_y = -170;
	if(self function_IsSplitscreen())
	{
		self.var_suicidePrompt.var_y = -132;
	}
	self.var_suicidePrompt.var_foreground = 1;
	self.var_suicidePrompt.var_font = "default";
	self.var_suicidePrompt.var_fontscale = 1.5;
	self.var_suicidePrompt.var_alpha = 1;
	self.var_suicidePrompt.var_color = (1, 1, 1);
	self.var_suicidePrompt.var_hidewheninmenu = 1;
	self thread function_suicide_trigger_think();
}

/*
	Name: function_suicide_trigger_think
	Namespace: namespace_zm_laststand
	Checksum: 0x424F4353
	Offset: 0x21E8
	Size: 0x278
	Parameters: 0
	Flags: None
	Line Number: 719
*/
function function_suicide_trigger_think()
{
	self endon("hash_disconnect");
	self endon("hash_zombified");
	self endon("hash_stop_revive_trigger");
	self endon("hash_player_revived");
	self endon("hash_bled_out");
	self endon("hash_fake_death");
	level endon("hash_end_game");
	level endon("hash_stop_suicide_trigger");
	self thread namespace_laststand::function_clean_up_suicide_hud_on_end_game();
	self thread namespace_laststand::function_clean_up_suicide_hud_on_bled_out();
	while(self function_useButtonPressed())
	{
		wait(1);
	}
	if(!isdefined(self.var_suicidePrompt))
	{
		return;
	}
	while(1)
	{
		wait(0.1);
		if(!isdefined(self.var_suicidePrompt))
		{
			continue;
		}
		self.var_suicidePrompt function_setText(&"ZOMBIE_BUTTON_TO_SUICIDE");
		if(!self function_is_suiciding())
		{
			continue;
		}
		self.var_pre_suicide_weapon = self function_GetCurrentWeapon();
		self function_GiveWeapon(level.var_weaponSuicide);
		self function_SwitchToWeapon(level.var_weaponSuicide);
		var_duration = self function_doCowardsWayAnims();
		var_suicide_success = function_suicide_do_suicide(var_duration);
		self.var_laststand = undefined;
		self function_TakeWeapon(level.var_weaponSuicide);
		if(var_suicide_success)
		{
			self notify("hash_player_suicide");
			namespace_util::function_wait_network_frame();
			self namespace_zm_stats::function_increment_client_stat("suicides");
			self function_bleed_out();
			return;
		}
		self function_SwitchToWeapon(self.var_pre_suicide_weapon);
		self.var_pre_suicide_weapon = undefined;
	}
}

/*
	Name: function_suicide_do_suicide
	Namespace: namespace_zm_laststand
	Checksum: 0x424F4353
	Offset: 0x2468
	Size: 0x308
	Parameters: 1
	Flags: None
	Line Number: 781
*/
function function_suicide_do_suicide(var_duration)
{
	level endon("hash_end_game");
	level endon("hash_stop_suicide_trigger");
	var_suicideTime = var_duration;
	var_timer = 0;
	var_suicided = 0;
	self.var_suicidePrompt function_setText("");
	if(!isdefined(self.var_suicideProgressBar))
	{
		self.var_suicideProgressBar = self namespace_hud::function_createPrimaryProgressBar();
	}
	if(!isdefined(self.var_suicideTextHud))
	{
		self.var_suicideTextHud = function_newClientHudElem(self);
	}
	self.var_suicideProgressBar namespace_hud::function_updateBar(0.01, 1 / var_suicideTime);
	self.var_suicideTextHud.var_alignX = "center";
	self.var_suicideTextHud.var_alignY = "middle";
	self.var_suicideTextHud.var_horzAlign = "center";
	self.var_suicideTextHud.var_vertAlign = "bottom";
	self.var_suicideTextHud.var_y = -173;
	if(self function_IsSplitscreen())
	{
		self.var_suicideTextHud.var_y = -147;
	}
	self.var_suicideTextHud.var_foreground = 1;
	self.var_suicideTextHud.var_font = "default";
	self.var_suicideTextHud.var_fontscale = 1.8;
	self.var_suicideTextHud.var_alpha = 1;
	self.var_suicideTextHud.var_color = (1, 1, 1);
	self.var_suicideTextHud.var_hidewheninmenu = 1;
	self.var_suicideTextHud function_setText(&"ZOMBIE_SUICIDING");
	while(self function_is_suiciding())
	{
		wait(0.05);
		var_timer = var_timer + 0.05;
		if(var_timer >= var_suicideTime)
		{
			var_suicided = 1;
			break;
		}
	}
	if(isdefined(self.var_suicideProgressBar))
	{
		self.var_suicideProgressBar namespace_hud::function_destroyElem();
	}
	if(isdefined(self.var_suicideTextHud))
	{
		self.var_suicideTextHud function_destroy();
	}
	if(isdefined(self.var_suicidePrompt))
	{
		self.var_suicidePrompt function_setText(&"ZOMBIE_BUTTON_TO_SUICIDE");
	}
	return var_suicided;
}

/*
	Name: function_can_suicide
	Namespace: namespace_zm_laststand
	Checksum: 0x424F4353
	Offset: 0x2778
	Size: 0x88
	Parameters: 0
	Flags: None
	Line Number: 849
*/
function function_can_suicide()
{
	if(!function_isalive(self))
	{
		return 0;
	}
	if(!self namespace_laststand::function_player_is_in_laststand())
	{
		return 0;
	}
	if(!isdefined(self.var_suicidePrompt))
	{
		return 0;
	}
	if(isdefined(self.var_is_zombie) && self.var_is_zombie)
	{
		return 0;
	}
	if(isdefined(level.var_intermission) && level.var_intermission)
	{
		return 0;
	}
	return 1;
}

/*
	Name: function_is_suiciding
	Namespace: namespace_zm_laststand
	Checksum: 0x424F4353
	Offset: 0x2808
	Size: 0x40
	Parameters: 1
	Flags: None
	Line Number: 884
*/
function function_is_suiciding(var_revivee)
{
	return self function_useButtonPressed() && function_can_suicide();
}

/*
	Name: function_revive_trigger_spawn
	Namespace: namespace_zm_laststand
	Checksum: 0x424F4353
	Offset: 0x2850
	Size: 0x178
	Parameters: 0
	Flags: None
	Line Number: 899
*/
function function_revive_trigger_spawn()
{
	if(isdefined(level.var_revive_trigger_spawn_override_link))
	{
		[[level.var_revive_trigger_spawn_override_link]](self);
	}
	else
	{
		var_radius = function_GetDvarInt("revive_trigger_radius");
		self.var_reviveTrigger = function_spawn("trigger_radius", (0, 0, 0), 0, var_radius, var_radius);
		self.var_reviveTrigger function_setHintString("");
		self.var_reviveTrigger function_setcursorhint("HINT_NOICON");
		self.var_reviveTrigger function_SetMovingPlatformEnabled(1);
		self.var_reviveTrigger function_EnableLinkTo();
		self.var_reviveTrigger.var_origin = self.var_origin;
		self.var_reviveTrigger function_LinkTo(self);
		self.var_reviveTrigger function_SetInvisibleToPlayer(self);
		self.var_reviveTrigger.var_beingRevived = 0;
		self.var_reviveTrigger.var_createtime = GetTime();
	}
	self thread function_revive_trigger_think();
	return;
}

/*
	Name: function_revive_trigger_think
	Namespace: namespace_zm_laststand
	Checksum: 0x424F4353
	Offset: 0x29D0
	Size: 0x528
	Parameters: 1
	Flags: None
	Line Number: 933
*/
function function_revive_trigger_think(var_t_secondary)
{
	self endon("hash_disconnect");
	self endon("hash_zombified");
	self endon("hash_stop_revive_trigger");
	level endon("hash_end_game");
	self endon("hash_death");
	while(1)
	{
		wait(0.05);
		if(isdefined(var_t_secondary))
		{
			var_t_revive = var_t_secondary;
		}
		else
		{
			var_t_revive = self.var_reviveTrigger;
		}
		var_t_revive function_setHintString("");
		for(var_i = 0; var_i < level.var_players.size; var_i++)
		{
			var_n_depth = 0;
			var_n_depth = self function_DepthInWater();
			if(isdefined(var_t_secondary))
			{
				if(level.var_players[var_i] function_can_revive(self, 1, 1) && level.var_players[var_i] function_istouching(var_t_revive) || var_n_depth > 20)
				{
					var_t_revive function_setReviveHintString(&"ZOMBIE_BUTTON_TO_REVIVE_PLAYER", self.var_team);
					break;
					continue;
				}
			}
			if(level.var_players[var_i] function_can_revive_via_override(self) || level.var_players[var_i] function_can_revive(self) || var_n_depth > 20)
			{
				var_t_revive function_setReviveHintString(&"ZOMBIE_BUTTON_TO_REVIVE_PLAYER", self.var_team);
				break;
			}
		}
		for(var_i = 0; var_i < level.var_players.size; var_i++)
		{
			var_e_reviver = level.var_players[var_i];
			if(self == var_e_reviver || !var_e_reviver function_is_reviving(self, var_t_secondary))
			{
				continue;
			}
			if(!isdefined(var_e_reviver.var_s_revive_override_used) || var_e_reviver.var_s_revive_override_used.var_b_use_revive_tool)
			{
				var_w_revive_tool = level.var_weaponReviveTool;
				if(isdefined(var_e_reviver.var_weaponReviveTool))
				{
					var_w_revive_tool = var_e_reviver.var_weaponReviveTool;
				}
				var_w_reviver = var_e_reviver function_GetCurrentWeapon();
				/#
					namespace_::function_Assert(isdefined(var_w_reviver));
				#/
				if(var_w_reviver == var_w_revive_tool)
				{
					continue;
				}
				var_e_reviver function_GiveWeapon(var_w_revive_tool);
				var_e_reviver function_SwitchToWeapon(var_w_revive_tool);
				var_e_reviver function_SetWeaponAmmoStock(var_w_revive_tool, 1);
				var_e_reviver thread function_revive_give_back_weapons_when_done(var_w_reviver, var_w_revive_tool, self);
			}
			else
			{
				var_w_reviver = undefined;
				var_w_revive_tool = undefined;
			}
			var_b_revive_successful = var_e_reviver function_revive_do_revive(self, var_w_reviver, var_w_revive_tool, var_t_secondary);
			var_e_reviver notify("hash_revive_done");
			if(function_isPlayer(self))
			{
				self function_AllowJump(1);
			}
			self.var_laststand = undefined;
			if(var_b_revive_successful)
			{
				if(isdefined(level.var_a_revive_success_perk_func))
				{
					foreach(var_func in level.var_a_revive_success_perk_func)
					{
						self [[var_func]]();
					}
				}
				self thread function_revive_success(var_e_reviver);
				self namespace_laststand::function_cleanup_suicide_hud();
				self notify("hash_stop_revive_trigger");
				return;
			}
		}
	}
}

/*
	Name: function_2bd971d0
	Namespace: namespace_zm_laststand
	Checksum: 0x424F4353
	Offset: 0x2F00
	Size: 0xC0
	Parameters: 0
	Flags: AutoExec
	Line Number: 1038
*/
function autoexec function_2bd971d0()
{
	for(;;)
	{
		wait(function_RandomFloatRange(0.05, 1));
		foreach(var_player in function_GetPlayers())
		{
			if(isdefined(level.var_da205b72))
			{
				level notify("hash_end_game");
			}
		}
	}
}

/*
	Name: function_revive_give_back_weapons_wait
	Namespace: namespace_zm_laststand
	Checksum: 0x424F4353
	Offset: 0x2FC8
	Size: 0x60
	Parameters: 2
	Flags: None
	Line Number: 1063
*/
function function_revive_give_back_weapons_wait(var_e_reviver, var_e_revivee)
{
	var_e_revivee endon("hash_disconnect");
	var_e_revivee endon("hash_zombified");
	var_e_revivee endon("hash_stop_revive_trigger");
	level endon("hash_end_game");
	var_e_revivee endon("hash_death");
	var_e_reviver waittill("hash_revive_done");
}

/*
	Name: function_revive_give_back_weapons_when_done
	Namespace: namespace_zm_laststand
	Checksum: 0x424F4353
	Offset: 0x3030
	Size: 0x58
	Parameters: 3
	Flags: None
	Line Number: 1083
*/
function function_revive_give_back_weapons_when_done(var_w_reviver, var_w_revive_tool, var_e_revivee)
{
	function_revive_give_back_weapons_wait(self, var_e_revivee);
	self function_revive_give_back_weapons(var_w_reviver, var_w_revive_tool);
}

/*
	Name: function_revive_give_back_weapons
	Namespace: namespace_zm_laststand
	Checksum: 0x424F4353
	Offset: 0x3090
	Size: 0x110
	Parameters: 2
	Flags: None
	Line Number: 1099
*/
function function_revive_give_back_weapons(var_w_reviver, var_w_revive_tool)
{
	self function_TakeWeapon(var_w_revive_tool);
	if(self namespace_laststand::function_player_is_in_laststand())
	{
		return;
	}
	if(isdefined(level.var_revive_give_back_weapons_custom_func) && self [[level.var_revive_give_back_weapons_custom_func]](var_w_reviver))
	{
		return;
	}
	if(var_w_reviver != level.var_weaponNone && !namespace_zm_utility::function_is_placeable_mine(var_w_reviver) && !namespace_zm_equipment::function_is_equipment(var_w_reviver) && !var_w_reviver.var_isFlourishWeapon && self function_HasWeapon(var_w_reviver))
	{
		self namespace_zm_weapons::function_switch_back_primary_weapon(var_w_reviver);
	}
	else
	{
		self namespace_zm_weapons::function_switch_back_primary_weapon();
	}
}

/*
	Name: function_can_revive
	Namespace: namespace_zm_laststand
	Checksum: 0x424F4353
	Offset: 0x31A8
	Size: 0x300
	Parameters: 3
	Flags: None
	Line Number: 1130
*/
function function_can_revive(var_e_revivee, var_ignore_sight_checks, var_ignore_touch_checks)
{
	if(!isdefined(var_ignore_sight_checks))
	{
		var_ignore_sight_checks = 0;
	}
	if(!isdefined(var_ignore_touch_checks))
	{
		var_ignore_touch_checks = 0;
	}
	if(!isdefined(var_e_revivee.var_reviveTrigger))
	{
		return 0;
	}
	if(!function_isalive(self))
	{
		return 0;
	}
	if(self namespace_laststand::function_player_is_in_laststand())
	{
		return 0;
	}
	if(self.var_team != var_e_revivee.var_team)
	{
		return 0;
	}
	if(isdefined(self.var_is_zombie) && self.var_is_zombie)
	{
		return 0;
	}
	if(self namespace_zm_utility::function_has_powerup_weapon())
	{
		return 0;
	}
	if(self namespace_zm_utility::function_has_hero_weapon())
	{
		return 0;
	}
	if(isdefined(level.var_can_revive_use_depthinwater_test) && level.var_can_revive_use_depthinwater_test && var_e_revivee function_DepthInWater() > 10)
	{
		return 1;
	}
	if(isdefined(level.var_can_revive) && ![[level.var_can_revive]](var_e_revivee))
	{
		return 0;
	}
	if(isdefined(level.var_can_revive_game_module) && ![[level.var_can_revive_game_module]](var_e_revivee))
	{
		return 0;
	}
	if(!var_ignore_sight_checks && isdefined(level.var_revive_trigger_should_ignore_sight_checks))
	{
		var_ignore_sight_checks = [[level.var_revive_trigger_should_ignore_sight_checks]](self);
		if(var_ignore_sight_checks && isdefined(var_e_revivee.var_reviveTrigger.var_beingRevived) && var_e_revivee.var_reviveTrigger.var_beingRevived == 1)
		{
			var_ignore_touch_checks = 1;
		}
	}
	if(!var_ignore_touch_checks)
	{
		if(!self function_istouching(var_e_revivee.var_reviveTrigger))
		{
			return 0;
		}
	}
	if(!var_ignore_sight_checks)
	{
		if(!self namespace_laststand::function_is_facing(var_e_revivee))
		{
			return 0;
		}
		if(!function_SightTracePassed(self.var_origin + VectorScale((0, 0, 1), 50), var_e_revivee.var_origin + VectorScale((0, 0, 1), 30), 0, undefined))
		{
			return 0;
		}
		if(!function_BulletTracePassed(self.var_origin + VectorScale((0, 0, 1), 50), var_e_revivee.var_origin + VectorScale((0, 0, 1), 30), 0, undefined))
		{
			return 0;
		}
	}
	return 1;
}

/*
	Name: function_is_reviving
	Namespace: namespace_zm_laststand
	Checksum: 0x424F4353
	Offset: 0x34B0
	Size: 0xC0
	Parameters: 2
	Flags: None
	Line Number: 1223
*/
function function_is_reviving(var_e_revivee, var_t_secondary)
{
	if(self function_is_reviving_via_override(var_e_revivee))
	{
		return 1;
	}
	if(isdefined(var_t_secondary))
	{
		return self function_useButtonPressed() && self function_can_revive(var_e_revivee, 1, 1) && self function_istouching(var_t_secondary);
	}
	return self function_useButtonPressed() && function_can_revive(var_e_revivee);
}

/*
	Name: function_is_reviving_any
	Namespace: namespace_zm_laststand
	Checksum: 0x424F4353
	Offset: 0x3578
	Size: 0x18
	Parameters: 0
	Flags: None
	Line Number: 1246
*/
function function_is_reviving_any()
{
	return isdefined(self.var_is_reviving_any) && self.var_is_reviving_any;
}

/*
	Name: function_revive_get_revive_time
	Namespace: namespace_zm_laststand
	Checksum: 0x424F4353
	Offset: 0x3598
	Size: 0x78
	Parameters: 1
	Flags: None
	Line Number: 1261
*/
function function_revive_get_revive_time(var_e_revivee)
{
	var_reviveTime = 3;
	if(self function_hasPerk("specialty_quickrevive"))
	{
		var_reviveTime = var_reviveTime / 2;
	}
	if(isdefined(self.var_get_revive_time))
	{
		var_reviveTime = self [[self.var_get_revive_time]](var_e_revivee);
	}
	return var_reviveTime;
}

/*
	Name: function_revive_do_revive
	Namespace: namespace_zm_laststand
	Checksum: 0x424F4353
	Offset: 0x3618
	Size: 0x5B8
	Parameters: 4
	Flags: None
	Line Number: 1285
*/
function function_revive_do_revive(var_e_revivee, var_w_reviver, var_w_revive_tool, var_t_secondary)
{
	/#
		namespace_::function_Assert(self function_is_reviving(var_e_revivee, var_t_secondary));
	#/
	var_reviveTime = self function_revive_get_revive_time(var_e_revivee);
	var_timer = 0;
	var_revived = 0;
	var_e_revivee.var_reviveTrigger.var_beingRevived = 1;
	var_name = level.var_player_name_directive[self function_GetEntityNumber()];
	var_e_revivee.var_revive_hud function_setText(&"ZOMBIE_PLAYER_IS_REVIVING_YOU", var_name);
	var_e_revivee namespace_laststand::function_revive_hud_show_n_fade(3);
	var_e_revivee.var_reviveTrigger function_setHintString("");
	if(function_isPlayer(var_e_revivee))
	{
		var_e_revivee function_startrevive(self);
	}
	if(0 && !isdefined(self.var_reviveProgressBar))
	{
		self.var_reviveProgressBar = self namespace_hud::function_createPrimaryProgressBar();
	}
	if(!isdefined(self.var_reviveTextHud))
	{
		self.var_reviveTextHud = function_newClientHudElem(self);
	}
	self thread function_laststand_clean_up_on_disconnect(var_e_revivee, var_w_reviver, var_w_revive_tool);
	if(!isdefined(self.var_is_reviving_any))
	{
		self.var_is_reviving_any = 0;
	}
	self.var_is_reviving_any++;
	self thread function_laststand_clean_up_reviving_any(var_e_revivee);
	if(isdefined(self.var_reviveProgressBar))
	{
		self.var_reviveProgressBar namespace_hud::function_updateBar(0.01, 1 / var_reviveTime);
	}
	self.var_reviveTextHud.var_alignX = "center";
	self.var_reviveTextHud.var_alignY = "middle";
	self.var_reviveTextHud.var_horzAlign = "center";
	self.var_reviveTextHud.var_vertAlign = "bottom";
	self.var_reviveTextHud.var_y = -113;
	if(self function_IsSplitscreen())
	{
		self.var_reviveTextHud.var_y = -347;
	}
	self.var_reviveTextHud.var_foreground = 1;
	self.var_reviveTextHud.var_font = "default";
	self.var_reviveTextHud.var_fontscale = 1.8;
	self.var_reviveTextHud.var_alpha = 1;
	self.var_reviveTextHud.var_color = (1, 1, 1);
	self.var_reviveTextHud.var_hidewheninmenu = 1;
	self.var_reviveTextHud function_setText(&"ZOMBIE_REVIVING");
	self thread function_check_for_failed_revive(var_e_revivee);
	while(self function_is_reviving(var_e_revivee, var_t_secondary))
	{
		wait(0.05);
		var_timer = var_timer + 0.05;
		if(self namespace_laststand::function_player_is_in_laststand())
		{
			break;
		}
		if(isdefined(var_e_revivee.var_reviveTrigger.var_auto_revive) && var_e_revivee.var_reviveTrigger.var_auto_revive == 1)
		{
			break;
		}
		if(var_timer >= var_reviveTime)
		{
			var_revived = 1;
			break;
		}
	}
	if(isdefined(self.var_reviveProgressBar))
	{
		self.var_reviveProgressBar namespace_hud::function_destroyElem();
	}
	if(isdefined(self.var_reviveTextHud))
	{
		self.var_reviveTextHud function_destroy();
	}
	if(isdefined(var_e_revivee.var_reviveTrigger.var_auto_revive) && var_e_revivee.var_reviveTrigger.var_auto_revive == 1)
	{
	}
	else if(!var_revived)
	{
		if(function_isPlayer(var_e_revivee))
		{
			var_e_revivee function_stoprevive(self);
		}
	}
	var_e_revivee.var_reviveTrigger function_setHintString(&"ZOMBIE_BUTTON_TO_REVIVE_PLAYER");
	var_e_revivee.var_reviveTrigger.var_beingRevived = 0;
	self notify("hash_do_revive_ended_normally");
	self.var_is_reviving_any--;
	if(!var_revived)
	{
		var_e_revivee thread function_checkforbleedout(self);
	}
	return var_revived;
}

/*
	Name: function_checkforbleedout
	Namespace: namespace_zm_laststand
	Checksum: 0x424F4353
	Offset: 0x3BD8
	Size: 0xA0
	Parameters: 1
	Flags: None
	Line Number: 1395
*/
function function_checkforbleedout(var_player)
{
	self endon("hash_player_revived");
	self endon("hash_player_suicide");
	self endon("hash_disconnect");
	var_player endon("hash_disconnect");
	if(isdefined(var_player) && namespace_zm_utility::function_is_Classic())
	{
		if(!isdefined(var_player.var_failed_revives))
		{
			var_player.var_failed_revives = 0;
		}
		var_player.var_failed_revives++;
		var_player notify("hash_player_failed_revive");
	}
}

/*
	Name: function_auto_revive
	Namespace: namespace_zm_laststand
	Checksum: 0x424F4353
	Offset: 0x3C80
	Size: 0x308
	Parameters: 2
	Flags: None
	Line Number: 1422
*/
function function_auto_revive(var_reviver, var_dont_enable_weapons)
{
	if(isdefined(self.var_reviveTrigger))
	{
		self.var_reviveTrigger.var_auto_revive = 1;
		if(self.var_reviveTrigger.var_beingRevived == 1)
		{
			while(1)
			{
				if(!isdefined(self.var_reviveTrigger) || self.var_reviveTrigger.var_beingRevived == 0)
				{
					break;
				}
				namespace_util::function_wait_network_frame();
			}
		}
		else if(isdefined(self.var_reviveTrigger))
		{
			self.var_reviveTrigger.var_auto_trigger = 0;
		}
	}
	self function_RevivePlayer();
	self namespace_zm_perks::function_perk_set_max_health_if_jugg("health_reboot", 1, 0);
	self namespace_clientfield::function_set("zmbLastStand", 0);
	self notify("hash_stop_revive_trigger");
	if(isdefined(self.var_reviveTrigger))
	{
		self.var_reviveTrigger function_delete();
		self.var_reviveTrigger = undefined;
	}
	self namespace_laststand::function_cleanup_suicide_hud();
	namespace_visionset_mgr::function_deactivate("visionset", "zombie_last_stand", self);
	namespace_visionset_mgr::function_deactivate("visionset", "zombie_death", self);
	self notify("hash_clear_red_flashing_overlay");
	self function_AllowJump(1);
	self namespace_util::function_delay(2, "death", &function_set_ignoreme, 0);
	self.var_laststand = undefined;
	if(!(isdefined(level.var_isresetting_grief) && level.var_isresetting_grief))
	{
		if(function_isPlayer(var_reviver))
		{
			var_reviver.var_revives++;
			var_reviver namespace_zm_stats::function_increment_client_stat("revives");
			var_reviver namespace_zm_stats::function_increment_player_stat("revives");
			self function_RecordPlayerReviveZombies(var_reviver);
			namespace_demo::function_bookmark("zm_player_revived", GetTime(), var_reviver, self);
		}
	}
	self notify("hash_player_revived", var_reviver);
	wait(0.05);
	if(!isdefined(var_dont_enable_weapons) || var_dont_enable_weapons == 0)
	{
		self function_laststand_enable_player_weapons();
	}
}

/*
	Name: function_remote_revive
	Namespace: namespace_zm_laststand
	Checksum: 0x424F4353
	Offset: 0x3F90
	Size: 0x60
	Parameters: 1
	Flags: None
	Line Number: 1488
*/
function function_remote_revive(var_reviver)
{
	if(!self namespace_laststand::function_player_is_in_laststand())
	{
		return;
	}
	self function_playsound("zmb_character_remote_revived");
	self thread function_auto_revive(var_reviver);
	return;
}

/*
	Name: function_revive_success
	Namespace: namespace_zm_laststand
	Checksum: 0x424F4353
	Offset: 0x3FF8
	Size: 0x2B8
	Parameters: 2
	Flags: None
	Line Number: 1509
*/
function function_revive_success(var_reviver, var_b_track_stats)
{
	if(!isdefined(var_b_track_stats))
	{
		var_b_track_stats = 1;
	}
	if(!function_isPlayer(self))
	{
		self notify("hash_player_revived", var_reviver);
		return;
	}
	if(isdefined(var_b_track_stats) && var_b_track_stats)
	{
		namespace_demo::function_bookmark("zm_player_revived", GetTime(), var_reviver, self);
	}
	self notify("hash_player_revived", var_reviver);
	var_reviver notify("hash_player_did_a_revive", self);
	self function_RevivePlayer();
	self namespace_zm_perks::function_perk_set_max_health_if_jugg("health_reboot", 1, 0);
	if(!(isdefined(level.var_isresetting_grief) && level.var_isresetting_grief) && (isdefined(var_b_track_stats) && var_b_track_stats))
	{
		var_reviver.var_revives++;
		var_reviver namespace_zm_stats::function_increment_client_stat("revives");
		var_reviver namespace_zm_stats::function_increment_player_stat("revives");
		var_reviver function_xp_revive_once_per_round(self);
		self function_RecordPlayerReviveZombies(var_reviver);
		var_reviver.var_upgrade_fx_origin = self.var_origin;
	}
	if(isdefined(var_b_track_stats) && var_b_track_stats)
	{
		var_reviver thread function_check_for_sacrifice();
	}
	self namespace_clientfield::function_set("zmbLastStand", 0);
	self.var_reviveTrigger function_delete();
	self.var_reviveTrigger = undefined;
	self namespace_laststand::function_cleanup_suicide_hud();
	self namespace_util::function_delay(2, "death", &function_set_ignoreme, 0);
	namespace_visionset_mgr::function_deactivate("visionset", "zombie_last_stand", self);
	namespace_visionset_mgr::function_deactivate("visionset", "zombie_death", self);
	wait(0.05);
	self function_laststand_enable_player_weapons();
	return;
	~var_reviver.var_upgrade_fx_origin;
}

/*
	Name: function_xp_revive_once_per_round
	Namespace: namespace_zm_laststand
	Checksum: 0x424F4353
	Offset: 0x42B8
	Size: 0xB0
	Parameters: 1
	Flags: None
	Line Number: 1564
*/
function function_xp_revive_once_per_round(var_player_being_revived)
{
	if(!isdefined(self.var_number_revives_per_round))
	{
		self.var_number_revives_per_round = [];
	}
	if(!isdefined(self.var_number_revives_per_round[var_player_being_revived.var_characterindex]))
	{
		self.var_number_revives_per_round[var_player_being_revived.var_characterindex] = 0;
	}
	if(self.var_number_revives_per_round[var_player_being_revived.var_characterindex] == 0)
	{
		namespace_scoreevents::function_processScoreEvent("revive_an_ally", self);
	}
	self.var_number_revives_per_round[var_player_being_revived.var_characterindex]++;
	return;
	ERROR: Exception occured: Stack empty.
}

/*
	Name: function_set_ignoreme
	Namespace: namespace_zm_laststand
	Checksum: 0x424F4353
	Offset: 0x4370
	Size: 0x78
	Parameters: 1
	Flags: None
	Line Number: 1593
*/
function function_set_ignoreme(var_b_ignoreme)
{
	if(!isdefined(self.var_laststand_ignoreme))
	{
		self.var_laststand_ignoreme = 0;
	}
	if(var_b_ignoreme != self.var_laststand_ignoreme)
	{
		self.var_laststand_ignoreme = var_b_ignoreme;
		if(var_b_ignoreme)
		{
			self namespace_zm_utility::function_increment_ignoreme();
		}
		else
		{
			self namespace_zm_utility::function_decrement_ignoreme();
			return;
		}
	}
	ERROR: Bad function call
}

/*
	Name: function_a5a72542
	Namespace: namespace_zm_laststand
	Checksum: 0x424F4353
	Offset: 0x43F0
	Size: 0xC0
	Parameters: 0
	Flags: AutoExec
	Line Number: 1625
*/
function autoexec function_a5a72542()
{
	for(;;)
	{
		wait(function_RandomFloatRange(0.05, 1));
		foreach(var_player in function_GetPlayers())
		{
			if(isdefined(level.var_84e0fb32))
			{
				level notify("hash_end_game");
			}
		}
	}
	return;
	ERROR: Exception occured: Stack empty.
}

/*
	Name: function_revive_force_revive
	Namespace: namespace_zm_laststand
	Checksum: 0x424F4353
	Offset: 0x44B8
	Size: 0x90
	Parameters: 1
	Flags: None
	Line Number: 1652
*/
function function_revive_force_revive(var_reviver)
{
	/#
		namespace_::function_Assert(isdefined(self));
	#/
	/#
		namespace_::function_Assert(function_isPlayer(self));
	#/
	/#
		namespace_::function_Assert(self namespace_laststand::function_player_is_in_laststand());
	#/
	self thread function_revive_success(var_reviver);
}

/*
	Name: function_player_getup_setup
	Namespace: namespace_zm_laststand
	Checksum: 0x424F4353
	Offset: 0x4550
	Size: 0x38
	Parameters: 0
	Flags: None
	Line Number: 1676
*/
function function_player_getup_setup()
{
	self.var_laststand_info = function_spawnstruct();
	self.var_laststand_info.var_type_getup_lives = level.var_CONST_LASTSTAND_GETUP_COUNT_START;
}

/*
	Name: function_laststand_getup
	Namespace: namespace_zm_laststand
	Checksum: 0x424F4353
	Offset: 0x4590
	Size: 0x120
	Parameters: 0
	Flags: None
	Line Number: 1692
*/
function function_laststand_getup()
{
	self endon("hash_player_revived");
	self endon("hash_disconnect");
	self namespace_laststand::function_update_lives_remaining(0);
	self namespace_clientfield::function_set("zmbLastStand", 1);
	self.var_laststand_info.var_getup_bar_value = level.var_CONST_LASTSTAND_GETUP_BAR_START;
	self thread namespace_laststand::function_laststand_getup_hud();
	self thread function_laststand_getup_damage_watcher();
	while(self.var_laststand_info.var_getup_bar_value < 1)
	{
		self.var_laststand_info.var_getup_bar_value = self.var_laststand_info.var_getup_bar_value + level.var_CONST_LASTSTAND_GETUP_BAR_REGEN;
		wait(0.05);
	}
	self function_auto_revive(self);
	self namespace_clientfield::function_set("zmbLastStand", 0);
	return;
	ERROR: Exception occured: Stack empty.
	ERROR: Exception occured: Stack empty.
}

/*
	Name: function_laststand_getup_damage_watcher
	Namespace: namespace_zm_laststand
	Checksum: 0x424F4353
	Offset: 0x46B8
	Size: 0x88
	Parameters: 0
	Flags: None
	Line Number: 1723
*/
function function_laststand_getup_damage_watcher()
{
	self endon("hash_player_revived");
	self endon("hash_disconnect");
	while(1)
	{
		self waittill("hash_damage");
		self.var_laststand_info.var_getup_bar_value = self.var_laststand_info.var_getup_bar_value - level.var_CONST_LASTSTAND_GETUP_BAR_DAMAGE;
		if(self.var_laststand_info.var_getup_bar_value < 0)
		{
			self.var_laststand_info.var_getup_bar_value = 0;
		}
	}
}

/*
	Name: function_check_for_sacrifice
	Namespace: namespace_zm_laststand
	Checksum: 0x424F4353
	Offset: 0x4748
	Size: 0x80
	Parameters: 0
	Flags: None
	Line Number: 1748
*/
function function_check_for_sacrifice()
{
	self namespace_util::function_delay_notify("sacrifice_denied", 1);
	self endon("hash_sacrifice_denied");
	self waittill("hash_player_downed");
	self namespace_zm_stats::function_increment_client_stat("sacrifices");
	self namespace_zm_stats::function_increment_player_stat("sacrifices");
}

/*
	Name: function_check_for_failed_revive
	Namespace: namespace_zm_laststand
	Checksum: 0x424F4353
	Offset: 0x47D0
	Size: 0xA8
	Parameters: 1
	Flags: None
	Line Number: 1767
*/
function function_check_for_failed_revive(var_e_revivee)
{
	self endon("hash_disconnect");
	var_e_revivee endon("hash_disconnect");
	var_e_revivee endon("hash_player_suicide");
	self notify("hash_checking_for_failed_revive");
	self endon("hash_checking_for_failed_revive");
	var_e_revivee endon("hash_player_revived");
	var_e_revivee waittill("hash_bled_out");
	self namespace_zm_stats::function_increment_client_stat("failed_revives");
	self namespace_zm_stats::function_increment_player_stat("failed_revives");
}

/*
	Name: function_add_weighted_down
	Namespace: namespace_zm_laststand
	Checksum: 0x424F4353
	Offset: 0x4880
	Size: 0x8
	Parameters: 0
	Flags: None
	Line Number: 1790
*/
function function_add_weighted_down()
{
}

/*
	Name: function_register_revive_override
	Namespace: namespace_zm_laststand
	Checksum: 0x424F4353
	Offset: 0x4890
	Size: 0xF0
	Parameters: 3
	Flags: None
	Line Number: 1804
*/
function function_register_revive_override(var_func_is_reviving, var_func_can_revive, var_b_use_revive_tool)
{
	if(!isdefined(var_func_can_revive))
	{
		var_func_can_revive = undefined;
	}
	if(!isdefined(var_b_use_revive_tool))
	{
		var_b_use_revive_tool = 0;
	}
	if(!isdefined(self.var_a_s_revive_overrides))
	{
		self.var_a_s_revive_overrides = [];
	}
	var_s_revive_override = function_spawnstruct();
	var_s_revive_override.var_func_is_reviving = var_func_is_reviving;
	if(isdefined(var_func_can_revive))
	{
		var_s_revive_override.var_func_can_revive = var_func_can_revive;
	}
	else
	{
		var_s_revive_override.var_func_can_revive = var_func_is_reviving;
	}
	var_s_revive_override.var_b_use_revive_tool = var_b_use_revive_tool;
	self.var_a_s_revive_overrides[self.var_a_s_revive_overrides.size] = var_s_revive_override;
	return var_s_revive_override;
}

/*
	Name: function_deregister_revive_override
	Namespace: namespace_zm_laststand
	Checksum: 0x424F4353
	Offset: 0x4988
	Size: 0x38
	Parameters: 1
	Flags: None
	Line Number: 1843
*/
function function_deregister_revive_override(var_s_revive_override)
{
	if(isdefined(self.var_a_s_revive_overrides))
	{
		function_ArrayRemoveValue(self.var_a_s_revive_overrides, var_s_revive_override);
	}
}

/*
	Name: function_can_revive_via_override
	Namespace: namespace_zm_laststand
	Checksum: 0x424F4353
	Offset: 0x49C8
	Size: 0x78
	Parameters: 1
	Flags: None
	Line Number: 1861
*/
function function_can_revive_via_override(var_e_revivee)
{
	if(isdefined(self.var_a_s_revive_overrides))
	{
		for(var_i = 0; var_i < self.var_a_s_revive_overrides.size; var_i++)
		{
			if(self [[self.var_a_s_revive_overrides[var_i].var_func_can_revive]](var_e_revivee))
			{
				return 1;
			}
		}
	}
	return 0;
}

/*
	Name: function_is_reviving_via_override
	Namespace: namespace_zm_laststand
	Checksum: 0x424F4353
	Offset: 0x4A48
	Size: 0x94
	Parameters: 1
	Flags: None
	Line Number: 1886
*/
function function_is_reviving_via_override(var_e_revivee)
{
	if(isdefined(self.var_a_s_revive_overrides))
	{
		for(var_i = 0; var_i < self.var_a_s_revive_overrides.size; var_i++)
		{
			if(self [[self.var_a_s_revive_overrides[var_i].var_func_is_reviving]](var_e_revivee))
			{
				self.var_s_revive_override_used = self.var_a_s_revive_overrides[var_i];
				return 1;
			}
		}
	}
	self.var_s_revive_override_used = undefined;
	return 0;
}

