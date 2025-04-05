#include scripts\codescripts\struct;
#include scripts\shared\ai\zombie_utility;
#include scripts\shared\array_shared;
#include scripts\shared\callbacks_shared;
#include scripts\shared\clientfield_shared;
#include scripts\shared\flag_shared;
#include scripts\shared\system_shared;
#include scripts\shared\util_shared;
#include scripts\sphynx\_zm_loot_mode;
#include scripts\sphynx\equipment\_zm_deployment_station;
#include scripts\sphynx\leveling\_zm_sphynx_leveling;
#include scripts\zm\_zm;
#include scripts\zm\_zm_audio;
#include scripts\zm\_zm_behavior;
#include scripts\zm\_zm_bgb;
#include scripts\zm\_zm_blockers;
#include scripts\zm\_zm_bot;
#include scripts\zm\_zm_clone;
#include scripts\zm\_zm_devgui;
#include scripts\zm\_zm_equipment;
#include scripts\zm\_zm_laststand;
#include scripts\zm\_zm_magicbox;
#include scripts\zm\_zm_perk_random;
#include scripts\zm\_zm_perks;
#include scripts\zm\_zm_playerhealth;
#include scripts\zm\_zm_power;
#include scripts\zm\_zm_powerups;
#include scripts\zm\_zm_score;
#include scripts\zm\_zm_spawner;
#include scripts\zm\_zm_stats;
#include scripts\zm\_zm_traps;
#include scripts\zm\_zm_unitrigger;
#include scripts\zm\_zm_utility;
#include scripts\zm\_zm_zonemgr;

#namespace namespace_1635148;

/*
	Name: function___init__sytem__
	Namespace: namespace_1635148
	Checksum: 0x424F4353
	Offset: 0x2368
	Size: 0x40
	Parameters: 0
	Flags: AutoExec
	Line Number: 47
*/
function autoexec function___init__sytem__()
{
	namespace_system::function_register("zm_mutators", &function___init__, &function___main__, undefined);
}

/*
	Name: function___init__
	Namespace: namespace_1635148
	Checksum: 0x424F4353
	Offset: 0x23B0
	Size: 0x130
	Parameters: 0
	Flags: Private
	Line Number: 62
*/
function private function___init__()
{
	if(!isdefined(level.var_1635148))
	{
		level.var_1635148 = [];
	}
	if(!isdefined(level.var_affed9f4))
	{
		level.var_affed9f4 = [];
	}
	level thread function_37f528c2();
	function_627e6ba4();
	foreach(var_a6f9d71d in level.var_1635148)
	{
		if(isdefined(var_a6f9d71d.var_prefunc) && function_IsFunctionPtr(var_a6f9d71d.var_prefunc))
		{
			level thread [[var_a6f9d71d.var_prefunc]](function_GetDvarInt(var_a6f9d71d.var_dvar));
		}
	}
}

/*
	Name: function___main__
	Namespace: namespace_1635148
	Checksum: 0x424F4353
	Offset: 0x24E8
	Size: 0xD8
	Parameters: 0
	Flags: Private
	Line Number: 93
*/
function private function___main__()
{
	foreach(var_a6f9d71d in level.var_1635148)
	{
		if(isdefined(var_a6f9d71d.var_postfunc) && function_IsFunctionPtr(var_a6f9d71d.var_postfunc))
		{
			level thread [[var_a6f9d71d.var_postfunc]](function_GetDvarInt(var_a6f9d71d.var_dvar));
		}
	}
}

/*
	Name: function_37f528c2
	Namespace: namespace_1635148
	Checksum: 0x424F4353
	Offset: 0x25C8
	Size: 0x130
	Parameters: 0
	Flags: None
	Line Number: 114
*/
function function_37f528c2()
{
	level namespace_flag::function_init("using_mutator_settings");
	wait(0.05);
	while(!level namespace_flag::function_get("using_mutator_settings"))
	{
		wait(0.5);
	}
	foreach(var_player in function_GetPlayers())
	{
		var_player.var_pers["mutator_settings"]++;
		var_player thread namespace_97ac1184::function_7e18304e("spx_save_data", "mutator_settings", var_player.var_pers["mutator_settings"], 0);
	}
}

/*
	Name: function_36137155
	Namespace: namespace_1635148
	Checksum: 0x424F4353
	Offset: 0x2700
	Size: 0x148
	Parameters: 4
	Flags: None
	Line Number: 139
*/
function function_36137155(var_27928f89, var_dvar_name, var_31a2eb85, var_facbf7a4)
{
	/#
		namespace_::function_Assert(isdefined(var_27928f89), "Dev Block strings are not supported");
	#/
	/#
		namespace_::function_Assert(isdefined(var_dvar_name), "Dev Block strings are not supported");
	#/
	/#
		namespace_::function_Assert(!isdefined(level.var_1635148[var_27928f89]), "Dev Block strings are not supported" + var_27928f89 + "Dev Block strings are not supported");
	#/
	level.var_1635148[var_27928f89] = function_spawnstruct();
	level.var_1635148[var_27928f89].var_name = var_27928f89;
	level.var_1635148[var_27928f89].var_dvar = var_dvar_name;
	level.var_1635148[var_27928f89].var_postfunc = var_facbf7a4;
	level.var_1635148[var_27928f89].var_prefunc = var_31a2eb85;
}

/*
	Name: function_627e6ba4
	Namespace: namespace_1635148
	Checksum: 0x424F4353
	Offset: 0x2850
	Size: 0xE28
	Parameters: 0
	Flags: Private
	Line Number: 167
*/
function private function_627e6ba4()
{
	namespace_zm_spawner::function_register_zombie_death_event_callback(&function_15e6b3ee);
	namespace_zm::function_register_vehicle_damage_callback(&function_ff1d538e);
	function_36137155("MutatorSettings_Classic", "mutator_classic", undefined, &function_6d475949);
	function_36137155("MutatorSettings_GameDifficulty", "mutator_gamedifficulty", undefined, &function_change_difficulty);
	function_36137155("MutatorSettings_RoamerOption", "mutator_roameroption", undefined, &function_ec1ce953);
	function_36137155("MutatorSettings_RageInducer", "mutator_rageinducer", undefined, &function_b41cf764);
	function_36137155("MutatorSettings_RageInducerInsane", "mutator_rageinducerinsane", undefined, &function_ca4241a9);
	function_36137155("MutatorSettings_StartingRound", "mutator_startround", &function_266c59d5, undefined);
	function_36137155("MutatorSettings_TimeCap", "mutator_timecap", undefined, &function_d4ea1ee9);
	function_36137155("MutatorSettings_KillCap", "mutator_killcap", &function_e2b8923d, undefined);
	function_36137155("MutatorSettings_Traps", "mutator_traps", undefined, &function_disable_traps);
	function_36137155("MutatorSettings_GobbleGums", "mutator_gobblegums", undefined, &function_8902641d);
	function_36137155("MutatorSettings_PaP", "mutator_pap", undefined, &function_d0str_vehicle_spawnere);
	function_36137155("MutatorSettings_AAT", "mutator_aat", undefined, &function_4b193327);
	function_36137155("MutatorSettings_MysteryBox", "mutator_mysterybox", undefined, &function_862020a8);
	function_36137155("MutatorSettings_PerkLimit", "mutator_perklimit", &function_2757c634, undefined);
	function_36137155("MutatorSettings_Speedrun", "mutator_speedrun", undefined, &function_3547f1cf);
	function_36137155("MutatorSettings_SeasonalContent", "mutator_seasonalcontent", &function_1cb87390, undefined);
	function_36137155("MutatorSettings_WeaponDropSystem", "mutator_weapondropsystem", &function_c204ff6b, undefined);
	function_36137155("MutatorSettings_DeploymentStation", "mutator_deploymentstation", &function_823b1606, undefined);
	function_36137155("MutatorSettings_UpgradedGunsRandomBox", "mutator_upgradedgunsrandombox", &function_5991cb2, undefined);
	function_36137155("MutatorSettings_PackaPunchRepackUses", "mutator_packapunchrepackuses", &function_4978a94b, undefined);
	function_36137155("MutatorSettings_InstantPaP", "mutator_instantpap", undefined, &function_15a87391);
	function_36137155("MutatorSettings_BlackOpsFourMaxAmmo", "mutator_blackopsfourmaxammo", &function_2df1ed06, undefined);
	function_36137155("MutatorSettings_BlackOpsFourCarpenter", "mutator_blackopsfourcarpenter", &function_4435e870, undefined);
	function_36137155("MutatorSettings_AmmoPacks", "mutator_ammopacks", &function_cfa85281, undefined);
	function_36137155("MutatorSettings_PerksAllow", "mutator_perksallow", undefined, &function_7f0e83d);
	function_36137155("MutatorSettings_WunderfizzActive", "mutator_wunderfizzactive", undefined, &function_6742a62);
	function_36137155("MutatorSettings_PerkJuggernogAllow", "mutator_perkjuggernogallow", undefined, &function_a476b02a);
	function_36137155("MutatorSettings_PerkQuickReviveAllow", "mutator_perkquickreviveallow", undefined, &function_disable_quickrevive);
	function_36137155("MutatorSettings_PerkSpeedColaAllow", "mutator_perkspeedcolaallow", undefined, &function_b576d858);
	function_36137155("MutatorSettings_PerkDoubleTapAllow", "mutator_perkdoubletapallow", undefined, &function_30fc5aa8);
	function_36137155("MutatorSettings_PerkStaminUpAllow", "mutator_perkstaminupallow", undefined, &function_7485ffdf);
	function_36137155("MutatorSettings_PerkMuleKickAllow", "mutator_perkmulekickallow", undefined, &function_51f03993);
	function_36137155("MutatorSettings_PerkDeadshotAllow", "mutator_perkdeadshotallow", undefined, &function_disable_deadshot);
	function_36137155("MutatorSettings_PerkWidowsWineAllow", "mutator_perkwidowswineallow", undefined, &function_51a8f0e8);
	function_36137155("MutatorSettings_PerkElectricCherryAllow", "mutator_perkelectriccherryallow", undefined, &function_77c02f38);
	function_36137155("MutatorSettings_PerkPhdFlopperAllow", "mutator_perkphdflopperallow", undefined, &function_93754032);
	function_36137155("MutatorSettings_PerkDeathPerceptionAllow", "mutator_perkdeathperceptionallow", undefined, &function_d810e879);
	function_36137155("MutatorSettings_PerkRealStealBrewAllow", "mutator_perkrealstealbrewallow", undefined, &function_b20b8e2f);
	function_36137155("MutatorSettings_PerkBandolierBanditAllow", "mutator_perkbandolierbanditallow", undefined, &function_6f7b74ec);
	function_36137155("MutatorSettings_PerkFrostBrewAllow", "mutator_perkfrostbrewallow", undefined, &function_e2e4bd74);
	function_36137155("MutatorSettings_PowerUps", "mutator_powerups", &function_8c94e755, undefined);
	function_36137155("MutatorSettings_NonUEMPowerups", "mutator_nonuempowerups", &function_19dfc39, undefined);
	function_36137155("MutatorSettings_XPDrop", "mutator_xpdrop", &function_2ff03255, undefined);
	function_36137155("MutatorSettings_StormSurge", "mutator_stormsurge", &function_76dda33d, undefined);
	function_36137155("MutatorSettings_DoublePoints", "mutator_doublepoints", &function_dced484c, undefined);
	function_36137155("MutatorSettings_Carpenter", "mutator_carpenter", &function_40d379e, undefined);
	function_36137155("MutatorSettings_BonusPoints", "mutator_bonuspoints", &function_e485a83a, undefined);
	function_36137155("MutatorSettings_FireSale", "mutator_firesale", &function_428816c7, undefined);
	function_36137155("MutatorSettings_InstaKill", "mutator_instakill", &function_5ff53437, undefined);
	function_36137155("MutatorSettings_MaxAmmo", "mutator_maxammo", &function_cca7fa66, undefined);
	function_36137155("MutatorSettings_Nuke", "mutator_nuke", &function_549245ed, undefined);
	function_36137155("MutatorSettings_Minigun", "mutator_minigun", &function_5a6a815f, undefined);
	function_36137155("MutatorSettings_ZombieBlood", "mutator_zombieblood", &function_40b5d6c8, undefined);
	function_36137155("MutatorSettings_WeaponUEM", "mutator_weaponuem", &function_f1adbb0c, undefined);
	function_36137155("MutatorSettings_WeaponMaps", "mutator_weaponmaps", &function_4d42012e, undefined);
	function_36137155("MutatorSettings_WallWeapons", "mutator_wallweapons", &function_806c4836, undefined);
	function_36137155("MutatorSettings_WeaponWonder", "mutator_weaponwonder", &function_7a19d952, undefined);
	function_36137155("MutatorSettings_WeaponWonderLimit", "mutator_weaponwonderlimit", &function_85c69390, undefined);
	function_36137155("MutatorSettings_WeaponDLC", "mutator_weapondlc", &function_8bc8b470, undefined);
	function_36137155("MutatorSettings_WeaponMelee", "mutator_weaponmelee", &function_8749d7c9, undefined);
	function_36137155("MutatorSettings_SprintReload", "mutator_sprintreload", &function_8aa75b62, undefined);
	function_36137155("MutatorSettings_PlayerSliding", "mutator_playersliding", &function_cb03afce, undefined);
	function_36137155("MutatorSettings_ArmoredZombies", "mutator_armoredzombies", undefined, &function_ec0a72dc);
	function_36137155("MutatorSettings_SpecialRounds", "mutator_specialrounds", undefined, &function_2bfbc731);
	function_36137155("MutatorSettings_HeadshotsOnly", "mutator_headshotsonly", &function_b3ace8ea, undefined);
	function_36137155("MutatorSettings_BossZombies", "mutator_bosszombies", undefined, &function_6be9a909);
	function_36137155("MutatorSettings_ElementalZombies", "mutator_elementalzombies", undefined, &function_417a0316);
	function_36137155("MutatorSettings_UemBossZombies", "mutator_uembosszombies", undefined, &function_9c404bf7);
	function_36137155("MutatorSettings_ZombieLimit", "mutator_zombielimit", undefined, &function_6299d599);
	function_36137155("MutatorSettings_GunGame", "mutator_gungame", undefined, &function_5eed7e2c);
	function_36137155("MutatorSettings_GunGameWeapons", "mutator_gungameweapons", undefined, &function_5813855e);
	function_36137155("MutatorSettings_GunGameRandomizer", "mutator_gungamerandomizer", undefined, &function_4c8f3a03);
	function_36137155("MutatorSettings_GunGameXPNeeded", "mutator_gungamexpneeded", undefined, &function_37de54c1);
	function_36137155("MutatorSettings_LootMode", "mutator_lootmode", undefined, &function_bef1eeb1);
}

/*
	Name: function_ec1ce953
	Namespace: namespace_1635148
	Checksum: 0x424F4353
	Offset: 0x3680
	Size: 0x80
	Parameters: 1
	Flags: None
	Line Number: 257
*/
function function_ec1ce953(var_dvar_value)
{
	level namespace_flag::function_init("roamer_option_enabled");
	wait(0.05);
	if(var_dvar_value == 2)
	{
		level namespace_flag::function_set("roamer_option_enabled");
		level.var_e5e729a2 = 0;
		level.var_func_get_delay_between_rounds = &function_get_delay_between_rounds;
	}
}

/*
	Name: function_get_delay_between_rounds
	Namespace: namespace_1635148
	Checksum: 0x424F4353
	Offset: 0x3708
	Size: 0x1E8
	Parameters: 0
	Flags: None
	Line Number: 279
*/
function function_get_delay_between_rounds()
{
	if(level namespace_flag::function_get("roamer_option_enabled"))
	{
		level.var_e5e729a2 = 1;
		level.var_3aee3ea7 = 0;
		foreach(var_player in function_GetPlayers())
		{
			var_player thread function_3c091b90();
		}
		var_host = namespace_util::function_getHostPlayer();
		var_host thread function_a4fb9419();
		function_6f78f4fc();
		level.var_e5e729a2 = 0;
		foreach(var_player in function_GetPlayers())
		{
			var_player thread namespace_97ac1184::function_8c165b4d("Data", "Roamer.Players", 0);
		}
		return 0;
	}
	else
	{
		return level.var_zombie_vars["zombie_between_round_time"];
	}
	return level.var_zombie_vars["zombie_between_round_time"];
}

/*
	Name: function_a4fb9419
	Namespace: namespace_1635148
	Checksum: 0x424F4353
	Offset: 0x38F8
	Size: 0x190
	Parameters: 0
	Flags: None
	Line Number: 316
*/
function function_a4fb9419()
{
	self endon("hash_disconnect");
	self endon("hash_3dc3333d");
	while(1)
	{
		self waittill("hash_menuresponse", var_menu, var_response);
		if(var_menu == "StartMenu_Main")
		{
			if(var_response == "disable_roamer")
			{
				function_iprintln("[Host] Disabled Roamer");
				level.var_e5e729a2 = 0;
				level namespace_flag::function_clear("roamer_option_enabled");
				function_SetDvar("mutator_roameroption", 0);
				level.var_3aee3ea7 = level.var_players.size;
				foreach(var_player in function_GetPlayers())
				{
					var_player thread namespace_97ac1184::function_8c165b4d("Data", "Roamer.Players", 0);
				}
				wait(0.05);
				level notify("hash_3dc3333d");
			}
		}
	}
}

/*
	Name: function_6f78f4fc
	Namespace: namespace_1635148
	Checksum: 0x424F4353
	Offset: 0x3A90
	Size: 0x30
	Parameters: 0
	Flags: None
	Line Number: 353
*/
function function_6f78f4fc()
{
	while(level.var_3aee3ea7 < level.var_players.size)
	{
		wait(1);
	}
	level.var_3aee3ea7 = 0;
}

/*
	Name: function_3c091b90
	Namespace: namespace_1635148
	Checksum: 0x424F4353
	Offset: 0x3AC8
	Size: 0x178
	Parameters: 0
	Flags: None
	Line Number: 372
*/
function function_3c091b90()
{
	self endon("hash_disconnect");
	level endon("hash_3dc3333d");
	self.var_10567d28 = 0;
	self thread namespace_97ac1184::function_8c165b4d("Data", "Roamer.Players", 1, 1);
	while(!self.var_10567d28)
	{
		var_time = 0;
		self thread namespace_97ac1184::function_8c165b4d("Data", "Roamer.Timer", var_time, 1);
		while(self function_meleeButtonPressed())
		{
			var_time = var_time + 0.05;
			self thread namespace_97ac1184::function_8c165b4d("Data", "Roamer.Timer", var_time / 2, 1);
			if(var_time >= 1.5)
			{
				level.var_3aee3ea7++;
				self thread namespace_97ac1184::function_8c165b4d("Data", "Roamer.Players", level.var_3aee3ea7 + 1, 1);
				self.var_10567d28 = 1;
				break;
			}
			wait(0.05);
		}
		wait(0.05);
	}
}

/*
	Name: function_6d475949
	Namespace: namespace_1635148
	Checksum: 0x424F4353
	Offset: 0x3C48
	Size: 0x330
	Parameters: 1
	Flags: None
	Line Number: 409
*/
function function_6d475949(var_dvar_value)
{
	level namespace_flag::function_init("classic_enabled");
	wait(0.05);
	if(var_dvar_value > 1)
	{
		level namespace_flag::function_set("classic_enabled");
		level thread function_6a298c67();
		namespace_callback::function_on_spawned(&function_57c443e8);
		level.var_7ceb1b41 = 1;
		level.var_b90077c4 = 1;
		level.var_2198e3c0 = 0;
		level.var_7f7e3195 = 0;
		level.var_fd6c66c2 = 0;
		wait(10);
		level.var_7f38ec2c = 0;
		level thread function_3b8ebb2("specialty_extraammo");
		level thread function_3b8ebb2("specialty_tracker");
		level thread function_3b8ebb2("specialty_widowswine");
		level thread function_3b8ebb2("specialty_immunetriggerbetty");
		level thread function_3b8ebb2("specialty_electriccherry");
		level thread function_3b8ebb2("specialty_immunetriggershock");
		if(var_dvar_value == 2)
		{
			level thread function_3b8ebb2("specialty_phdflopper");
			level thread function_3b8ebb2("specialty_staminup");
			level thread function_3b8ebb2("specialty_additionalprimaryweapon");
			level thread function_3b8ebb2("specialty_deadshot");
		}
		while(var_dvar_value == 2)
		{
			namespace_zm_powerups::function_powerup_remove_from_regular_drops("bonus_points_team");
			namespace_zm_powerups::function_powerup_remove_from_regular_drops("fire_sale");
			namespace_zm_powerups::function_powerup_remove_from_regular_drops("minigun");
			namespace_zm_powerups::function_powerup_remove_from_regular_drops("xp_drop");
			namespace_zm_powerups::function_powerup_remove_from_regular_drops("storm_surge");
			level.var_zombie_weapons[function_GetWeapon("t9_crossbow_skull")].var_is_in_box = 0;
			level.var_zombie_weapons[function_GetWeapon("t9_gallo_raygun")].var_is_in_box = 0;
			level.var_240d2289 = 0;
			level.var_c127fb71 = 0;
			wait(2);
		}
		return;
	}
	continue;
	ERROR: Exception occured: Stack empty.
}

/*
	Name: function_6a298c67
	Namespace: namespace_1635148
	Checksum: 0x424F4353
	Offset: 0x3F80
	Size: 0x228
	Parameters: 0
	Flags: None
	Line Number: 467
*/
function function_6a298c67()
{
	var_9d8064ad = function_GetEntArray("bgb_machine_use", "targetname");
	level.var_bgb_in_use = 0;
	foreach(var_bgb in var_9d8064ad)
	{
		if(isdefined(var_bgb.var_unitrigger_stub))
		{
			var_bgb.var_unitrigger_stub.var_og_origin = var_bgb.var_unitrigger_stub.var_origin;
			var_bgb.var_unitrigger_stub.var_origin = var_bgb.var_unitrigger_stub.var_origin - VectorScale((0, 0, 1), 1000);
			var_bgb.var_unitrigger_stub.var_8b8a66cc = function_spawn("trigger_radius_use", var_bgb.var_unitrigger_stub.var_og_origin, 0, 16, 16);
			var_bgb.var_unitrigger_stub.var_8b8a66cc function_SetTeamForTrigger("allies");
			var_bgb.var_unitrigger_stub.var_8b8a66cc function_setcursorhint("HINT_NOICON");
			var_bgb.var_unitrigger_stub.var_8b8a66cc function_setHintString("Gums are Disabled in Classic Mode");
			var_bgb function_SetZBarrierPieceState(3, "closed");
		}
	}
	return;
}

/*
	Name: function_57c443e8
	Namespace: namespace_1635148
	Checksum: 0x424F4353
	Offset: 0x41B0
	Size: 0x38
	Parameters: 0
	Flags: None
	Line Number: 497
*/
function function_57c443e8()
{
System.InvalidOperationException: Stack empty.
   at System.ThrowHelper.ThrowInvalidOperationException(ExceptionResource resource)
   at System.Collections.Generic.Stack`1.Pop()
   at Cerberus.Logic.Decompiler.BuildCondition(Int32 startIndex)
   at Cerberus.Logic.Decompiler.FindIfStatements()
   at Cerberus.Logic.Decompiler..ctor(ScriptExport function, ScriptBase script)
}

/*
	Name: function_90a3e012
	Namespace: namespace_1635148
	Checksum: 0x424F4353
	Offset: 0x41F0
	Size: 0xC0
	Parameters: 0
	Flags: None
	Line Number: 517
*/
function function_90a3e012()
{
	self endon("hash_bled_out");
	self endon("hash_spawned_player");
	self endon("hash_disconnect");
	level.var_8aa75b62 = 1;
	while(1)
	{
		if(isdefined(self))
		{
			if(namespace_zm_utility::function_is_player_valid(self))
			{
				while(self function_IsReloading())
				{
					self function_AllowSprint(0);
					wait(0.1);
				}
				self function_AllowSprint(1);
			}
		}
		wait(0.1);
	}
}

/*
	Name: function_a3da1c9d
	Namespace: namespace_1635148
	Checksum: 0x424F4353
	Offset: 0x42B8
	Size: 0x80
	Parameters: 0
	Flags: None
	Line Number: 551
*/
function function_a3da1c9d()
{
	self endon("hash_bled_out");
	self endon("hash_spawned_player");
	self endon("hash_disconnect");
	level.var_cb03afce = 1;
	while(1)
	{
		if(isdefined(self))
		{
			if(namespace_zm_utility::function_is_player_valid(self))
			{
				self function_4651aaf7(0);
			}
		}
		wait(0.1);
	}
}

/*
	Name: function_3547f1cf
	Namespace: namespace_1635148
	Checksum: 0x424F4353
	Offset: 0x4340
	Size: 0x80
	Parameters: 1
	Flags: None
	Line Number: 580
*/
function function_3547f1cf(var_dvar_value)
{
	level namespace_flag::function_init("speedrun_enabled");
	wait(0.05);
	if(var_dvar_value == 1)
	{
		level namespace_flag::function_set("speedrun_enabled");
		level namespace_flag::function_set("using_mutator_settings");
		return;
	}
}

/*
	Name: function_1cb87390
	Namespace: namespace_1635148
	Checksum: 0x424F4353
	Offset: 0x43C8
	Size: 0x80
	Parameters: 1
	Flags: None
	Line Number: 602
*/
function function_1cb87390(var_dvar_value)
{
	level namespace_flag::function_init("seasonal_content_disabled");
	wait(0.05);
	if(var_dvar_value >= 1)
	{
		level namespace_flag::function_set("seasonal_content_disabled");
		level namespace_flag::function_set("using_mutator_settings");
	}
}

/*
	Name: function_2757c634
	Namespace: namespace_1635148
	Checksum: 0x424F4353
	Offset: 0x4450
	Size: 0x68
	Parameters: 1
	Flags: Private
	Line Number: 623
*/
function private function_2757c634(var_dvar_value)
{
	if(var_dvar_value >= 2)
	{
		while(!isdefined(level.var_machine_assets))
		{
			wait(0.05);
		}
		wait(5);
		level.var_842626f0 = var_dvar_value;
		level namespace_flag::function_set("using_mutator_settings");
	}
}

/*
	Name: function_266c59d5
	Namespace: namespace_1635148
	Checksum: 0x424F4353
	Offset: 0x44C0
	Size: 0xB8
	Parameters: 1
	Flags: Private
	Line Number: 647
*/
function private function_266c59d5(var_dvar_value)
{
	if(var_dvar_value >= 2)
	{
		if(function_GetDvarInt("mutator_gungame") == 2)
		{
			function_iprintln("[Gun Game] Detected Starting Round Change. Not Allowed!");
		}
		else
		{
			namespace_callback::function_on_connect(&function_aa0d54c);
			level.var_round_prestart_func = &function_set_round_number;
			level namespace_flag::function_set("using_mutator_settings");
		}
	}
}

/*
	Name: function_set_round_number
	Namespace: namespace_1635148
	Checksum: 0x424F4353
	Offset: 0x4580
	Size: 0xB0
	Parameters: 0
	Flags: Private
	Line Number: 674
*/
function private function_set_round_number()
{
	var_round = function_GetDvarInt("mutator_startround");
	level.var_91874529 = var_round;
	level.var_round_number = var_round;
	function_SetRoundsPlayed(level.var_round_number);
	game["roundsplayed"] = level.var_round_number;
	level.var_zombie_move_speed = level.var_round_number * level.var_zombie_vars["zombie_move_speed_multiplier"];
	namespace_zm::function_set_round_number(var_round);
}

/*
	Name: function_aa0d54c
	Namespace: namespace_1635148
	Checksum: 0x424F4353
	Offset: 0x4638
	Size: 0x40
	Parameters: 0
	Flags: Private
	Line Number: 695
*/
function private function_aa0d54c()
{
	wait(6);
	self namespace_zm_score::function_add_to_player_score(150 * function_GetDvarInt("mutator_startround"));
}

/*
	Name: function_change_difficulty
	Namespace: namespace_1635148
	Checksum: 0x424F4353
	Offset: 0x4680
	Size: 0x178
	Parameters: 0
	Flags: Private
	Line Number: 711
*/
function private function_change_difficulty()
{
	var_difficulty = function_GetDvarInt("mutator_gamedifficulty");
	wait(0.05);
	level namespace_flag::function_wait_till("initial_blackscreen_passed");
	wait(2);
	if(var_difficulty > 1)
	{
		switch(var_difficulty)
		{
			case 2:
			{
				foreach(var_player in function_GetPlayers())
				{
					var_player function_LUINotifyEvent(&"spx_milestone_notification", 1, &"ZM_MINECRAFT_STARTUP_BABY_MODE");
				}
				level thread function_eee87dde("easy");
				level.var_affed9f4["zombie_max"] = 16;
				level.var_bdc116e3 = 2;
				break;
			}
		}
		level namespace_flag::function_set("using_mutator_settings");
		return;
	}
	ERROR: Exception occured: Index was out of range. Must be non-negative and less than the size of the collection.
Parameter name: index
}

/*
	Name: function_eee87dde
	Namespace: namespace_1635148
	Checksum: 0x424F4353
	Offset: 0x4800
	Size: 0x448
	Parameters: 1
	Flags: None
	Line Number: 750
*/
function function_eee87dde(var_difficulty)
{
	if(isdefined(var_difficulty) && var_difficulty == "easy")
	{
		level.var_zombie_vars["zombie_between_round_time"] = level.var_ee5d3b93;
		level.var_zombie_vars["zombie_move_speed_multiplier"] = 1;
		foreach(var_ai_enemy in function_GetAITeamArray("axis"))
		{
			var_ai_enemy namespace_zombie_utility::function_set_zombie_run_cycle_restore_from_override();
			var_ai_enemy namespace_zombie_utility::function_set_zombie_run_cycle_override_value("walk");
		}
	}
	else if(isdefined(var_difficulty) && var_difficulty == "normal")
	{
		level.var_zombie_vars["zombie_between_round_time"] = level.var_ee5d3b93;
		level.var_zombie_vars["zombie_move_speed_multiplier"] = level.var_8e473ceb;
		foreach(var_ai_enemy in function_GetAITeamArray("axis"))
		{
			var_ai_enemy namespace_zombie_utility::function_set_zombie_run_cycle_restore_from_override();
			if(level.var_round_number <= 5)
			{
				var_ai_enemy namespace_zombie_utility::function_set_zombie_run_cycle_override_value("walk");
				continue;
			}
			var_ai_enemy namespace_zombie_utility::function_set_zombie_run_cycle_override_value("run");
		}
	}
	else if(isdefined(var_difficulty) && var_difficulty == "hard")
	{
		level.var_zombie_vars["zombie_between_round_time"] = 0.1;
		level.var_zombie_vars["zombie_move_speed_multiplier"] = 60;
		foreach(var_ai_enemy in function_GetAITeamArray("axis"))
		{
			var_ai_enemy namespace_zombie_utility::function_set_zombie_run_cycle_restore_from_override();
			var_ai_enemy namespace_zombie_utility::function_set_zombie_run_cycle_override_value("sprint");
		}
	}
	else if(isdefined(var_difficulty) && var_difficulty == "super_hard")
	{
		level.var_zombie_vars["zombie_between_round_time"] = 0.1;
		level.var_zombie_vars["zombie_move_speed_multiplier"] = 200;
		foreach(var_ai_enemy in function_GetAITeamArray("axis"))
		{
			var_ai_enemy namespace_zombie_utility::function_set_zombie_run_cycle_restore_from_override();
			var_ai_enemy namespace_zombie_utility::function_set_zombie_run_cycle_override_value("super_sprint");
		}
	}
}

/*
	Name: function_b41cf764
	Namespace: namespace_1635148
	Checksum: 0x424F4353
	Offset: 0x4C50
	Size: 0x130
	Parameters: 1
	Flags: Private
	Line Number: 809
*/
function private function_b41cf764(var_dvar_value)
{
	var_difficulty = function_GetDvarInt("mutator_rageinducer");
	wait(0.05);
	level namespace_flag::function_wait_till("initial_blackscreen_passed");
	wait(4);
	if(var_difficulty > 1)
	{
		if(level namespace_flag::function_get("insane_rage_inducer"))
		{
			level thread namespace_a74e4f35::function_change_difficulty("insane");
		}
		else
		{
			level thread namespace_a74e4f35::function_change_difficulty("hard");
		}
		level.var_zombie_actor_limit = 40 + 4 * function_GetPlayers().size;
		level.var_zombie_ai_limit = 40 + 4 * function_GetPlayers().size;
		level namespace_flag::function_set("using_mutator_settings");
		return;
	}
}

/*
	Name: function_ca4241a9
	Namespace: namespace_1635148
	Checksum: 0x424F4353
	Offset: 0x4D88
	Size: 0x80
	Parameters: 1
	Flags: Private
	Line Number: 842
*/
function private function_ca4241a9(var_dvar_value)
{
	level namespace_flag::function_init("insane_rage_inducer");
	wait(1);
	if(var_dvar_value == 2)
	{
		level namespace_flag::function_set("insane_rage_inducer");
		level namespace_flag::function_set("using_mutator_settings");
	}
}

/*
	Name: function_8902641d
	Namespace: namespace_1635148
	Checksum: 0x424F4353
	Offset: 0x4E10
	Size: 0x258
	Parameters: 1
	Flags: Private
	Line Number: 863
*/
function private function_8902641d(var_dvar_value)
{
	wait(0.05);
	if(var_dvar_value == 2)
	{
		level.var_bgb_in_use = 0;
		var_9d8064ad = function_GetEntArray("bgb_machine_use", "targetname");
		foreach(var_bgb in var_9d8064ad)
		{
			if(isdefined(var_bgb.var_unitrigger_stub))
			{
				var_bgb.var_unitrigger_stub.var_og_origin = var_bgb.var_unitrigger_stub.var_origin;
				var_bgb.var_unitrigger_stub.var_origin = var_bgb.var_unitrigger_stub.var_origin - VectorScale((0, 0, 1), 1000);
				var_bgb.var_unitrigger_stub.var_8b8a66cc = function_spawn("trigger_radius_use", var_bgb.var_unitrigger_stub.var_og_origin, 0, 16, 16);
				var_bgb.var_unitrigger_stub.var_8b8a66cc function_SetTeamForTrigger("allies");
				var_bgb.var_unitrigger_stub.var_8b8a66cc function_setcursorhint("HINT_NOICON");
				var_bgb.var_unitrigger_stub.var_8b8a66cc function_setHintString("Gobblegums are disabled");
				var_bgb function_SetZBarrierPieceState(3, "closed");
			}
		}
		level namespace_flag::function_set("using_mutator_settings");
		return;
	}
}

/*
	Name: function_d0str_vehicle_spawnere
	Namespace: namespace_1635148
	Checksum: 0x424F4353
	Offset: 0x5070
	Size: 0x58
	Parameters: 1
	Flags: Private
	Line Number: 898
*/
function private function_d0str_vehicle_spawnere(var_dvar_value)
{
	wait(0.05);
	if(var_dvar_value == 2)
	{
		wait(5);
		level.var_919b0320 = 1;
		level namespace_flag::function_set("using_mutator_settings");
	}
}

/*
	Name: function_4b193327
	Namespace: namespace_1635148
	Checksum: 0x424F4353
	Offset: 0x50D0
	Size: 0x58
	Parameters: 1
	Flags: Private
	Line Number: 919
*/
function private function_4b193327(var_dvar_value)
{
	wait(0.05);
	if(var_dvar_value == 2)
	{
		wait(5);
		level.var_7f38ec2c = 0;
		level namespace_flag::function_set("using_mutator_settings");
	}
}

/*
	Name: function_15a87391
	Namespace: namespace_1635148
	Checksum: 0x424F4353
	Offset: 0x5130
	Size: 0x50
	Parameters: 1
	Flags: Private
	Line Number: 940
*/
function private function_15a87391(var_dvar_value)
{
	wait(0.05);
	if(var_dvar_value == 2)
	{
		level.var_b90077c4 = 1;
		level namespace_flag::function_set("using_mutator_settings");
	}
}

/*
	Name: function_862020a8
	Namespace: namespace_1635148
	Checksum: 0x424F4353
	Offset: 0x5188
	Size: 0x118
	Parameters: 1
	Flags: Private
	Line Number: 960
*/
function private function_862020a8(var_dvar_value)
{
	wait(0.05);
	if(var_dvar_value == 2)
	{
		while(!isdefined(level.var_chests))
		{
			wait(2);
		}
		level.var_bcf7eaa1 = 1;
		foreach(var_box in level.var_chests)
		{
			var_box.var_zbarrier namespace_zm_magicbox::function_set_magic_box_zbarrier_state("away");
			var_box notify("hash_kill_chest_think");
		}
		level notify("hash_kill_chest_think");
		level namespace_flag::function_set("using_mutator_settings");
	}
}

/*
	Name: function_c204ff6b
	Namespace: namespace_1635148
	Checksum: 0x424F4353
	Offset: 0x52A8
	Size: 0x50
	Parameters: 1
	Flags: Private
	Line Number: 990
*/
function private function_c204ff6b(var_dvar_value)
{
	wait(0.05);
	if(var_dvar_value == 2)
	{
		level.var_7f7e3195 = 0;
		level namespace_flag::function_set("using_mutator_settings");
	}
}

/*
	Name: function_5991cb2
	Namespace: namespace_1635148
	Checksum: 0x424F4353
	Offset: 0x5300
	Size: 0x50
	Parameters: 1
	Flags: Private
	Line Number: 1010
*/
function private function_5991cb2(var_dvar_value)
{
	wait(0.05);
	if(var_dvar_value == 2)
	{
		level.var_2198e3c0 = 0;
		level namespace_flag::function_set("using_mutator_settings");
	}
}

/*
	Name: function_823b1606
	Namespace: namespace_1635148
	Checksum: 0x424F4353
	Offset: 0x5358
	Size: 0x50
	Parameters: 1
	Flags: Private
	Line Number: 1030
*/
function private function_823b1606(var_dvar_value)
{
	wait(0.05);
	if(var_dvar_value == 2)
	{
		level.var_22a274bc = 0;
		level namespace_flag::function_set("using_mutator_settings");
	}
}

/*
	Name: function_4978a94b
	Namespace: namespace_1635148
	Checksum: 0x424F4353
	Offset: 0x53B0
	Size: 0xC8
	Parameters: 1
	Flags: Private
	Line Number: 1050
*/
function private function_4978a94b(var_dvar_value)
{
	wait(0.05);
	if(var_dvar_value >= 2)
	{
		switch(var_dvar_value)
		{
			case 12:
			{
				break;
			}
			case 2:
			case 3:
			case 4:
			case 5:
			case 6:
			case 7:
			case 8:
			case 9:
			case 10:
			case 11:
			{
				level.var_7ceb1b41 = var_dvar_value - 1;
				break;
			}
		}
		level namespace_flag::function_set("using_mutator_settings");
		return;
	}
	ERROR: Bad function call
}

/*
	Name: function_2df1ed06
	Namespace: namespace_1635148
	Checksum: 0x424F4353
	Offset: 0x5480
	Size: 0x60
	Parameters: 1
	Flags: Private
	Line Number: 1092
*/
function private function_2df1ed06(var_dvar_value)
{
	level.var_240d2289 = 1;
	wait(0.05);
	if(var_dvar_value == 2)
	{
		wait(10);
		level.var_240d2289 = 0;
		level namespace_flag::function_set("using_mutator_settings");
	}
}

/*
	Name: function_4435e870
	Namespace: namespace_1635148
	Checksum: 0x424F4353
	Offset: 0x54E8
	Size: 0x58
	Parameters: 1
	Flags: Private
	Line Number: 1114
*/
function private function_4435e870(var_dvar_value)
{
	wait(0.05);
	if(var_dvar_value == 2)
	{
		wait(10);
		level.var_c127fb71 = 0;
		level namespace_flag::function_set("using_mutator_settings");
	}
}

/*
	Name: function_cfa85281
	Namespace: namespace_1635148
	Checksum: 0x424F4353
	Offset: 0x5548
	Size: 0x50
	Parameters: 1
	Flags: Private
	Line Number: 1135
*/
function private function_cfa85281(var_dvar_value)
{
	wait(0.05);
	if(var_dvar_value == 2)
	{
		level.var_fd6c66c2 = 0;
		level namespace_flag::function_set("using_mutator_settings");
	}
}

/*
	Name: function_f1adbb0c
	Namespace: namespace_1635148
	Checksum: 0x424F4353
	Offset: 0x55A0
	Size: 0x80
	Parameters: 1
	Flags: Private
	Line Number: 1155
*/
function private function_f1adbb0c(var_dvar_value)
{
	level namespace_flag::function_init("remove_uem_weapons");
	wait(0.05);
	if(var_dvar_value == 1)
	{
		level namespace_flag::function_set("remove_uem_weapons");
		level namespace_flag::function_set("using_mutator_settings");
	}
}

/*
	Name: function_4d42012e
	Namespace: namespace_1635148
	Checksum: 0x424F4353
	Offset: 0x5628
	Size: 0x80
	Parameters: 1
	Flags: Private
	Line Number: 1176
*/
function private function_4d42012e(var_dvar_value)
{
	level namespace_flag::function_init("keep_map_weapons");
	wait(0.05);
	if(var_dvar_value == 2)
	{
		level namespace_flag::function_set("keep_map_weapons");
		level namespace_flag::function_set("using_mutator_settings");
	}
}

/*
	Name: function_806c4836
	Namespace: namespace_1635148
	Checksum: 0x424F4353
	Offset: 0x56B0
	Size: 0x330
	Parameters: 1
	Flags: Private
	Line Number: 1197
*/
function private function_806c4836(var_dvar_value)
{
	wait(0.05);
	if(var_dvar_value == 2)
	{
		var_1291a337 = namespace_struct::function_get_array("claymore_purchase", "targetname");
		if(var_1291a337.size > 1)
		{
			foreach(var_wallbuy in var_1291a337)
			{
				var_wallbuy.var_trigger_stub.var_origin = var_wallbuy.var_origin - VectorScale((0, 0, 1), 1000);
				wait(0.05);
				var_wallbuy namespace_struct::function_delete();
			}
		}
		var_30d7709f = namespace_struct::function_get_array("weapon_upgrade", "targetname");
		if(var_30d7709f.size > 1)
		{
			foreach(var_wallbuy in var_30d7709f)
			{
				var_wallbuy.var_trigger_stub.var_origin = var_wallbuy.var_origin - VectorScale((0, 0, 1), 1000);
				wait(0.05);
				var_wallbuy namespace_struct::function_delete();
			}
		}
		var_59eea563 = namespace_struct::function_get_array("bowie_upgrade", "targetname");
		if(var_59eea563.size > 1)
		{
			foreach(var_wallbuy in var_59eea563)
			{
				var_wallbuy.var_trigger_stub.var_origin = var_wallbuy.var_origin - VectorScale((0, 0, 1), 1000);
				wait(0.05);
				var_wallbuy namespace_struct::function_delete();
			}
		}
		level namespace_flag::function_set("using_mutator_settings");
	}
}

/*
	Name: function_7a19d952
	Namespace: namespace_1635148
	Checksum: 0x424F4353
	Offset: 0x59E8
	Size: 0x3D0
	Parameters: 1
	Flags: Private
	Line Number: 1246
*/
function private function_7a19d952(var_dvar_value)
{
	wait(0.05);
	if(var_dvar_value == 2)
	{
		var_e33eb0d5 = function_Array("thundergun", "thundergun_upgraded", "idgun_upgraded", "idgun_0", "idgun_upgraded_0", "idgun_1", "idgun_upgraded_1", "idgun_2", "idgun_upgraded_2", "idgun_3", "idgun_upgraded_3", "idgun_4", "idgun_upgraded_4", "t7_idgun_genesis_0", "t7_idgun_genesis_0_upgraded", "idgun_genesis_0", "idgun_genesis_0_upgraded", "microwavegundw", "microwavegundw_upgraded", "microwavegun", "microwavegun_upgraded", "microwavegunlh", "microwavegunlh_upgraded", "t7_hero_mirg2000", "t7_hero_mirg2000_upgraded", "hero_mirg2000", "hero_mirg2000_upgraded", "skull_gun", "t7_shrink_ray", "t7_shrink_ray_upgraded", "octobomb", "octobomb_upgraded", "hero_gravityspikes_melee", "tesla_gun", "tesla_gun_upgraded", "staff_fire", "staff_fire_upgraded2", "staff_fire_upgraded3", "staff_water", "staff_water_upgraded2", "staff_water_upgraded3", "staff_lightning", "staff_lightning_upgraded2", "staff_lightning_upgraded3", "staff_air", "staff_air_upgraded2", "staff_air_upgraded3", "t7_staff_air", "t7_staff_fire", "t7_staff_lightning", "t7_staff_water", "t7_staff_air_upgraded", "t7_staff_fire_upgraded", "t7_staff_lightning_upgraded", "t7_staff_water_upgraded", "elemental_bow", "elemental_bow1", "elemental_bow2", "elemental_bow3", "elemental_bow4", "elemental_bow_storm", "elemental_bow_storm1", "elemental_bow_storm2", "elemental_bow_storm3", "elemental_bow_storm4", "elemental_bow_demongate", "elemental_bow_demongate1", "elemental_bow_demongate2", "elemental_bow_demongate3", "elemental_bow_demongate4", "elemental_bow_rune_prison", "elemental_bow_rune_prison1", "elemental_bow_rune_prison2", "elemental_bow_rune_prison3", "elemental_bow_rune_prison4", "elemental_bow_wolf", "elemental_bow_wolf1", "elemental_bow_wolf2", "elemental_bow_wolf3", "elemental_bow_wolf4", "elemental_bow_wolf_howl", "elemental_bow_wolf_howl1", "elemental_bow_wolf_howl2", "elemental_bow_wolf_howl3", "elemental_bow_wolf_howl4");
		for(;;)
		{
			foreach(var_weapon in var_e33eb0d5)
			{
				if(isdefined(level.var_zombie_weapons[function_GetWeapon(var_weapon)]))
				{
					level.var_zombie_weapons[function_GetWeapon(var_weapon)].var_is_in_box = 0;
				}
			}
			wait(30);
		}
		level namespace_flag::function_set("using_mutator_settings");
		return;
	}
	ERROR: Exception occured: Stack empty.
	ERROR: Bad function call
}

/*
	Name: function_85c69390
	Namespace: namespace_1635148
	Checksum: 0x424F4353
	Offset: 0x5DC0
	Size: 0x50
	Parameters: 1
	Flags: Private
	Line Number: 1280
*/
function private function_85c69390(var_dvar_value)
{
	wait(0.05);
	if(var_dvar_value == 2)
	{
		level.var_e37f7a7c = 2;
		level namespace_flag::function_set("using_mutator_settings");
	}
}

/*
	Name: function_8bc8b470
	Namespace: namespace_1635148
	Checksum: 0x424F4353
	Offset: 0x5E18
	Size: 0x468
	Parameters: 1
	Flags: Private
	Line Number: 1300
*/
function private function_8bc8b470(var_dvar_value)
{
	wait(6);
	if(var_dvar_value == 2)
	{
		var_492da764 = function_Array(function_GetWeapon("pistol_energy"), function_GetWeapon("pistol_m1911"), function_GetWeapon("pistol_shotgun_dw"), function_GetWeapon("pistol_c96"), function_GetWeapon("ar_famas"), function_GetWeapon("ar_garand"), function_GetWeapon("ar_peacekeeper"), function_GetWeapon("ar_an94"), function_GetWeapon("ar_galil"), function_GetWeapon("ar_m14"), function_GetWeapon("ar_m16"), function_GetWeapon("ar_pulse"), function_GetWeapon("ar_fastburst"), function_GetWeapon("ar_stg44"), function_GetWeapon("smg_sten"), function_GetWeapon("smg_mp40"), function_GetWeapon("smg_ppsh"), function_GetWeapon("smg_thompson"), function_GetWeapon("smg_longrange"), function_GetWeapon("smg_ak74u"), function_GetWeapon("smg_msmc"), function_GetWeapon("smg_nailgun"), function_GetWeapon("smg_rechamber"), function_GetWeapon("smg_sten2"), function_GetWeapon("smg_mp40_1940"), function_GetWeapon("lmg_infinite"), function_GetWeapon("lmg_rpk"), function_GetWeapon("lmg_mg08"), function_GetWeapon("shotgun_energy"), function_GetWeapon("shotgun_olympia"), function_GetWeapon("launcher_ex41"), function_GetWeapon("sniper_double"), function_GetWeapon("sniper_quickscope"), function_GetWeapon("sniper_mosin"), function_GetWeapon("sniper_chargeshot"), function_GetWeapon("sniper_xpr50"));
		for(;;)
		{
			foreach(var_weapon in var_492da764)
			{
				if(isdefined(level.var_zombie_weapons[var_weapon]))
				{
					level.var_zombie_weapons[var_weapon].var_is_in_box = 0;
				}
			}
			wait(30);
		}
		level namespace_flag::function_set("using_mutator_settings");
		return;
	}
	ERROR: Bad function call
}

/*
	Name: function_8749d7c9
	Namespace: namespace_1635148
	Checksum: 0x424F4353
	Offset: 0x6288
	Size: 0x3B8
	Parameters: 1
	Flags: Private
	Line Number: 1333
*/
function private function_8749d7c9(var_dvar_value)
{
	wait(6);
	if(var_dvar_value == 2)
	{
		var_4278db2b = function_Array(function_GetWeapon("t9_bat_crockiller"), function_GetWeapon("sw_lightsaber_obi_wan"), function_GetWeapon("melee_shovel"), function_GetWeapon("melee_knuckles"), function_GetWeapon("melee_chainsaw"), function_GetWeapon("melee_butterfly"), function_GetWeapon("melee_improvise"), function_GetWeapon("melee_bowie"), function_GetWeapon("melee_loadout"), function_GetWeapon("melee_shockbaton"), function_GetWeapon("melee_sword"), function_GetWeapon("melee_crowbar"), function_GetWeapon("melee_katana"), function_GetWeapon("melee_prosthetic"), function_GetWeapon("melee_dagger"), function_GetWeapon("melee_bat"), function_GetWeapon("melee_jug"), function_GetWeapon("melee_jug_up"), function_GetWeapon("melee_boneglass"), function_GetWeapon("melee_nunchuks"), function_GetWeapon("melee_boxing"), function_GetWeapon("melee_crescent"), function_GetWeapon("melee_mace"), function_GetWeapon("melee_fireaxe"), function_GetWeapon("melee_wrench"), function_GetWeapon("melee_christmas_pipe"), function_GetWeapon("melee_4090"), function_GetWeapon("melee_seasonal_pipe"));
		for(;;)
		{
			foreach(var_weapon in var_4278db2b)
			{
				if(isdefined(level.var_zombie_weapons[var_weapon]) || isdefined(level.var_zombie_weapons_upgraded[var_weapon]))
				{
					level.var_zombie_weapons[var_weapon].var_is_in_box = 0;
				}
			}
			wait(30);
		}
		level namespace_flag::function_set("using_mutator_settings");
	}
}

/*
	Name: function_b3ace8ea
	Namespace: namespace_1635148
	Checksum: 0x424F4353
	Offset: 0x6648
	Size: 0x50
	Parameters: 1
	Flags: Private
	Line Number: 1364
*/
function private function_b3ace8ea(var_dvar_value)
{
	wait(0.05);
	if(var_dvar_value == 2)
	{
		level.var_headshots_only = 1;
		level namespace_flag::function_set("using_mutator_settings");
	}
}

/*
	Name: function_d4ea1ee9
	Namespace: namespace_1635148
	Checksum: 0x424F4353
	Offset: 0x66A0
	Size: 0xA8
	Parameters: 1
	Flags: Private
	Line Number: 1384
*/
function private function_d4ea1ee9(var_dvar_value)
{
	level endon("hash_end_game");
	level endon("hash_end_round_think");
	if(var_dvar_value >= 1)
	{
		level namespace_flag::function_set("using_mutator_settings");
		wait(15);
		var_n_max_time = var_dvar_value * 60;
		for(var_n_timer = 0; var_n_timer < var_n_max_time; var_n_timer++)
		{
			wait(1);
		}
		level notify("hash_end_game");
	}
}

/*
	Name: function_3eacb2ed
	Namespace: namespace_1635148
	Checksum: 0x424F4353
	Offset: 0x6750
	Size: 0x160
	Parameters: 9
	Flags: None
	Line Number: 1411
*/
function function_3eacb2ed(var_elem, var_sort, var_x_align, var_82301424, var_x, var_y, var_font_scale, var_font, var_text)
{
	var_elem.var_sort = var_sort;
	var_elem.var_alignX = var_x_align;
	var_elem.var_alignY = var_82301424;
	var_elem.var_horzAlign = var_x_align;
	var_elem.var_vertAlign = var_82301424;
	var_elem.var_xOffset = 0;
	var_elem.var_yOffset = 0;
	var_elem.var_x = var_x;
	var_elem.var_y = var_y;
	var_elem.var_hidewheninmenu = 0;
	var_elem.var_hideWhenInDemo = 0;
	var_elem.var_fontscale = var_font_scale;
	var_elem.var_font = var_font;
	var_elem function_setText(var_text);
	return var_elem;
}

/*
	Name: function_48ef7026
	Namespace: namespace_1635148
	Checksum: 0x424F4353
	Offset: 0x68B8
	Size: 0x108
	Parameters: 1
	Flags: Private
	Line Number: 1440
*/
function private function_48ef7026(var_dvar_value)
{
	if(var_dvar_value === 2)
	{
		level.var_9fffc62 = function_3eacb2ed(function_NewHudElem(), 0, "center", "top", 0, 0, 1.8, "objective", &"");
		level.var_9fffc62 function_SetTimerUp(0);
		level waittill("hash_end_game");
		if(isdefined(level.var_9fffc62))
		{
			level.var_9fffc62 function_fadeOverTime(1);
			level.var_9fffc62.var_alpha = 0;
			wait(2);
			level.var_hudelem_count--;
			level.var_9fffc62 function_destroy();
		}
	}
}

/*
	Name: function_e2b8923d
	Namespace: namespace_1635148
	Checksum: 0x424F4353
	Offset: 0x69C8
	Size: 0x58
	Parameters: 1
	Flags: Private
	Line Number: 1468
*/
function private function_e2b8923d(var_dvar_value)
{
	if(var_dvar_value >= 100)
	{
		level.var_fb7be6ac = var_dvar_value;
		level.var_f345e88f = 0;
		level namespace_flag::function_set("using_mutator_settings");
	}
}

/*
	Name: function_disable_traps
	Namespace: namespace_1635148
	Checksum: 0x424F4353
	Offset: 0x6A28
	Size: 0x320
	Parameters: 1
	Flags: Private
	Line Number: 1488
*/
function private function_disable_traps(var_dvar_value)
{
	wait(0.05);
	if(var_dvar_value == 2)
	{
		foreach(var_trap in function_GetEntArray("zombie_trap", "targetname"))
		{
			foreach(var_trig in var_trap.var__trap_use_trigs)
			{
				var_trig function_TriggerEnable(0);
			}
		}
		foreach(var_trap in function_GetEntArray("pendulum_buy_trigger", "targetname"))
		{
			var_trap function_TriggerEnable(0);
		}
		foreach(var_trap in function_GetEntArray("use_trap_chain", "targetname"))
		{
			var_trap function_TriggerEnable(0);
		}
		foreach(var_trap in namespace_struct::function_get_array("s_onswitch_unitrigger", "script_label"))
		{
			namespace_zm_unitrigger::function_unregister_unitrigger(var_trap);
		}
		level namespace_flag::function_set("using_mutator_settings");
		return;
	}
	ERROR: Exception occured: Stack empty.
}

/*
	Name: function_7f0e83d
	Namespace: namespace_1635148
	Checksum: 0x424F4353
	Offset: 0x6D50
	Size: 0x120
	Parameters: 1
	Flags: Private
	Line Number: 1528
*/
function private function_7f0e83d(var_dvar_value)
{
	if(var_dvar_value == 2)
	{
		level.var_842626f0 = 0;
		level namespace_flag::function_set("using_mutator_settings");
		wait(12);
		level.var__random_perk_machine_perk_list = [];
		wait(0.05);
		var_d952ddb7 = function_GetEntArray("zombie_vending", "targetname");
		if(var_d952ddb7.size > 1)
		{
			foreach(var_e3955304 in var_d952ddb7)
			{
				var_e3955304 thread function_874b5971();
			}
			return;
		}
	}
}

/*
	Name: function_874b5971
	Namespace: namespace_1635148
	Checksum: 0x424F4353
	Offset: 0x6E78
	Size: 0xE0
	Parameters: 0
	Flags: Private
	Line Number: 1559
*/
function private function_874b5971()
{
	if(isdefined(self.var_machine))
	{
		self.var_machine.var_s_fxloc function_delete();
		self.var_clip function_connectpaths();
		self.var_clip function_delete();
		self.var_bump function_delete();
		self.var_machine function_delete();
		self function_TriggerEnable(0);
	}
	level.var__custom_perks = namespace_Array::function_remove_index(level.var__custom_perks, self.var_script_noteworthy, 1);
}

/*
	Name: function_6742a62
	Namespace: namespace_1635148
	Checksum: 0x424F4353
	Offset: 0x6F60
	Size: 0x100
	Parameters: 1
	Flags: Private
	Line Number: 1583
*/
function private function_6742a62(var_dvar_value)
{
	if(var_dvar_value == 2)
	{
		wait(0.05);
		level namespace_flag::function_set("using_mutator_settings");
		wait(5);
		level notify("hash_machine_think");
		foreach(var_machine in function_GetEntArray("perk_random_machine", "targetname"))
		{
			var_machine thread namespace_zm_perk_random::function_set_perk_random_machine_state("away");
		}
	}
}

/*
	Name: function_a476b02a
	Namespace: namespace_1635148
	Checksum: 0x424F4353
	Offset: 0x7068
	Size: 0x58
	Parameters: 1
	Flags: Private
	Line Number: 1608
*/
function private function_a476b02a(var_dvar_value)
{
	if(var_dvar_value == 2)
	{
		level namespace_flag::function_set("using_mutator_settings");
		wait(10);
		level thread function_3b8ebb2("specialty_armorvest");
	}
}

/*
	Name: function_disable_quickrevive
	Namespace: namespace_1635148
	Checksum: 0x424F4353
	Offset: 0x70C8
	Size: 0x58
	Parameters: 1
	Flags: Private
	Line Number: 1628
*/
function private function_disable_quickrevive(var_dvar_value)
{
	if(var_dvar_value == 2)
	{
		level namespace_flag::function_set("using_mutator_settings");
		wait(10);
		level thread function_3b8ebb2("specialty_quickrevive");
	}
}

/*
	Name: function_b576d858
	Namespace: namespace_1635148
	Checksum: 0x424F4353
	Offset: 0x7128
	Size: 0x58
	Parameters: 1
	Flags: Private
	Line Number: 1648
*/
function private function_b576d858(var_dvar_value)
{
	if(var_dvar_value == 2)
	{
		level namespace_flag::function_set("using_mutator_settings");
		wait(10);
		level thread function_3b8ebb2("specialty_fastreload");
	}
}

/*
	Name: function_30fc5aa8
	Namespace: namespace_1635148
	Checksum: 0x424F4353
	Offset: 0x7188
	Size: 0x58
	Parameters: 1
	Flags: Private
	Line Number: 1668
*/
function private function_30fc5aa8(var_dvar_value)
{
	if(var_dvar_value == 2)
	{
		level namespace_flag::function_set("using_mutator_settings");
		wait(10);
		level thread function_3b8ebb2("specialty_doubletap2");
	}
}

/*
	Name: function_7485ffdf
	Namespace: namespace_1635148
	Checksum: 0x424F4353
	Offset: 0x71E8
	Size: 0x58
	Parameters: 1
	Flags: Private
	Line Number: 1688
*/
function private function_7485ffdf(var_dvar_value)
{
	if(var_dvar_value == 2)
	{
		level namespace_flag::function_set("using_mutator_settings");
		wait(10);
		level thread function_3b8ebb2("specialty_staminup");
		return;
	}
}

/*
	Name: function_51f03993
	Namespace: namespace_1635148
	Checksum: 0x424F4353
	Offset: 0x7248
	Size: 0x58
	Parameters: 1
	Flags: Private
	Line Number: 1709
*/
function private function_51f03993(var_dvar_value)
{
	if(var_dvar_value == 2)
	{
		level namespace_flag::function_set("using_mutator_settings");
		wait(10);
		level thread function_3b8ebb2("specialty_additionalprimaryweapon");
		return;
	}
	ERROR: Exception occured: Stack empty.
}

/*
	Name: function_disable_deadshot
	Namespace: namespace_1635148
	Checksum: 0x424F4353
	Offset: 0x72A8
	Size: 0x58
	Parameters: 1
	Flags: Private
	Line Number: 1731
*/
function private function_disable_deadshot(var_dvar_value)
{
	if(var_dvar_value == 2)
	{
		level namespace_flag::function_set("using_mutator_settings");
		wait(10);
		level thread function_3b8ebb2("specialty_deadshot");
	}
}

/*
	Name: function_51a8f0e8
	Namespace: namespace_1635148
	Checksum: 0x424F4353
	Offset: 0x7308
	Size: 0x58
	Parameters: 1
	Flags: Private
	Line Number: 1751
*/
function private function_51a8f0e8(var_dvar_value)
{
	if(var_dvar_value == 2)
	{
		level namespace_flag::function_set("using_mutator_settings");
		wait(10);
		level thread function_3b8ebb2("specialty_widowswine");
	}
}

/*
	Name: function_77c02f38
	Namespace: namespace_1635148
	Checksum: 0x424F4353
	Offset: 0x7368
	Size: 0x58
	Parameters: 1
	Flags: Private
	Line Number: 1771
*/
function private function_77c02f38(var_dvar_value)
{
	if(var_dvar_value == 2)
	{
		level namespace_flag::function_set("using_mutator_settings");
		wait(10);
		level thread function_3b8ebb2("specialty_electriccherry");
		return;
	}
	ERROR: Exception occured: Stack empty.
}

/*
	Name: function_93754032
	Namespace: namespace_1635148
	Checksum: 0x424F4353
	Offset: 0x73C8
	Size: 0x58
	Parameters: 1
	Flags: Private
	Line Number: 1793
*/
function private function_93754032(var_dvar_value)
{
	if(var_dvar_value == 2)
	{
		level namespace_flag::function_set("using_mutator_settings");
		wait(10);
		level thread function_3b8ebb2("specialty_phdflopper");
	}
}

/*
	Name: function_d810e879
	Namespace: namespace_1635148
	Checksum: 0x424F4353
	Offset: 0x7428
	Size: 0x58
	Parameters: 1
	Flags: Private
	Line Number: 1813
*/
function private function_d810e879(var_dvar_value)
{
	if(var_dvar_value == 2)
	{
		level namespace_flag::function_set("using_mutator_settings");
		wait(10);
		level thread function_3b8ebb2("specialty_tracker");
	}
}

/*
	Name: function_b20b8e2f
	Namespace: namespace_1635148
	Checksum: 0x424F4353
	Offset: 0x7488
	Size: 0x58
	Parameters: 1
	Flags: Private
	Line Number: 1833
*/
function private function_b20b8e2f(var_dvar_value)
{
	if(var_dvar_value == 2)
	{
		level namespace_flag::function_set("using_mutator_settings");
		wait(10);
		level thread function_3b8ebb2("specialty_immunetriggerbetty");
	}
}

/*
	Name: function_6f7b74ec
	Namespace: namespace_1635148
	Checksum: 0x424F4353
	Offset: 0x74E8
	Size: 0x58
	Parameters: 1
	Flags: Private
	Line Number: 1853
*/
function private function_6f7b74ec(var_dvar_value)
{
	if(var_dvar_value == 2)
	{
		level namespace_flag::function_set("using_mutator_settings");
		wait(10);
		level thread function_3b8ebb2("specialty_extraammo");
	}
}

/*
	Name: function_e2e4bd74
	Namespace: namespace_1635148
	Checksum: 0x424F4353
	Offset: 0x7548
	Size: 0x58
	Parameters: 1
	Flags: Private
	Line Number: 1873
*/
function function_e2e4bd74()
{
System.InvalidOperationException: Stack empty.
   at System.ThrowHelper.ThrowInvalidOperationException(ExceptionResource resource)
   at System.Collections.Generic.Stack`1.Pop()
   at Cerberus.Logic.Decompiler.BuildCondition(Int32 startIndex)
   at Cerberus.Logic.Decompiler.FindIfStatements()
   at Cerberus.Logic.Decompiler..ctor(ScriptExport function, ScriptBase script)
}

/*
	Name: function_3b8ebb2
	Namespace: namespace_1635148
	Checksum: 0x424F4353
	Offset: 0x75A8
	Size: 0x80
	Parameters: 1
	Flags: None
	Line Number: 1893
*/
function function_3b8ebb2(var_perk_name)
{
	for(;;)
	{
		level.var__custom_perks = namespace_Array::function_remove_index(level.var__custom_perks, var_perk_name, 1);
		namespace_zm_perks::function_perk_machine_removal(var_perk_name);
		if(!isdefined(level.var_c0bbcc46))
		{
			level.var_c0bbcc46 = [];
		}
		level.var_c0bbcc46[var_perk_name] = 1;
		wait(2);
	}
}

/*
	Name: function_8c94e755
	Namespace: namespace_1635148
	Checksum: 0x424F4353
	Offset: 0x7630
	Size: 0x68
	Parameters: 1
	Flags: Private
	Line Number: 1918
*/
function private function_8c94e755(var_dvar_value)
{
	wait(2);
	if(var_dvar_value == 2)
	{
		level namespace_flag::function_set("using_mutator_settings");
		level namespace_flag::function_clear("zombie_drop_powerups");
		level.var_8c94e755 = 1;
	}
}

/*
	Name: function_19dfc39
	Namespace: namespace_1635148
	Checksum: 0x424F4353
	Offset: 0x76A0
	Size: 0xD8
	Parameters: 1
	Flags: Private
	Line Number: 1939
*/
function private function_19dfc39(var_dvar_value)
{
	wait(2);
	namespace_zm_powerups::function_powerup_remove_from_regular_drops("random_weapon");
	namespace_zm_powerups::function_powerup_remove_from_regular_drops("fast_feet");
	namespace_zm_powerups::function_powerup_remove_from_regular_drops("free_packapunch");
	if(var_dvar_value == 2)
	{
		level namespace_flag::function_set("using_mutator_settings");
		for(;;)
		{
			namespace_zm_powerups::function_include_zombie_powerup("random_weapon");
			namespace_zm_powerups::function_include_zombie_powerup("fast_feet");
			namespace_zm_powerups::function_include_zombie_powerup("free_packapunch");
			wait(1);
		}
	}
}

/*
	Name: function_2ff03255
	Namespace: namespace_1635148
	Checksum: 0x424F4353
	Offset: 0x7780
	Size: 0x58
	Parameters: 1
	Flags: Private
	Line Number: 1968
*/
function private function_2ff03255(var_dvar_value)
{
	wait(2);
	if(var_dvar_value == 2)
	{
		level.var_147d7517["xp_drop"] = 0;
		level namespace_flag::function_set("using_mutator_settings");
		return;
	}
	ERROR: Bad function call
}

/*
	Name: function_76dda33d
	Namespace: namespace_1635148
	Checksum: 0x424F4353
	Offset: 0x77E0
	Size: 0x58
	Parameters: 1
	Flags: Private
	Line Number: 1990
*/
function private function_76dda33d(var_dvar_value)
{
	wait(2);
	if(var_dvar_value == 2)
	{
		level.var_147d7517["storm_surge"] = 0;
		level namespace_flag::function_set("using_mutator_settings");
		return;
	}
}

/*
	Name: function_dced484c
	Namespace: namespace_1635148
	Checksum: 0x424F4353
	Offset: 0x7840
	Size: 0x58
	Parameters: 1
	Flags: Private
	Line Number: 2011
*/
function private function_dced484c(var_dvar_value)
{
	wait(2);
	if(var_dvar_value == 2)
	{
		level.var_147d7517["double_points"] = 0;
		level namespace_flag::function_set("using_mutator_settings");
		return;
	}
	ERROR: Exception occured: Stack empty.
}

/*
	Name: function_40d379e
	Namespace: namespace_1635148
	Checksum: 0x424F4353
	Offset: 0x78A0
	Size: 0x58
	Parameters: 1
	Flags: Private
	Line Number: 2033
*/
function private function_40d379e(var_dvar_value)
{
	wait(2);
	if(var_dvar_value == 2)
	{
		level.var_147d7517["carpenter"] = 0;
		level namespace_flag::function_set("using_mutator_settings");
	}
}

/*
	Name: function_e485a83a
	Namespace: namespace_1635148
	Checksum: 0x424F4353
	Offset: 0x7900
	Size: 0x58
	Parameters: 1
	Flags: Private
	Line Number: 2053
*/
function private function_e485a83a(var_dvar_value)
{
	wait(2);
	if(var_dvar_value == 2)
	{
		level.var_147d7517["bonus_points_team"] = 0;
		level namespace_flag::function_set("using_mutator_settings");
	}
}

/*
	Name: function_428816c7
	Namespace: namespace_1635148
	Checksum: 0x424F4353
	Offset: 0x7960
	Size: 0x58
	Parameters: 1
	Flags: Private
	Line Number: 2073
*/
function private function_428816c7(var_dvar_value)
{
	wait(2);
	if(var_dvar_value == 2)
	{
		level.var_147d7517["fire_sale"] = 0;
		level namespace_flag::function_set("using_mutator_settings");
	}
}

/*
	Name: function_5ff53437
	Namespace: namespace_1635148
	Checksum: 0x424F4353
	Offset: 0x79C0
	Size: 0x58
	Parameters: 1
	Flags: Private
	Line Number: 2093
*/
function private function_5ff53437(var_dvar_value)
{
	wait(2);
	if(var_dvar_value == 2)
	{
		level.var_147d7517["insta_kill"] = 0;
		level namespace_flag::function_set("using_mutator_settings");
	}
}

/*
	Name: function_cca7fa66
	Namespace: namespace_1635148
	Checksum: 0x424F4353
	Offset: 0x7A20
	Size: 0x58
	Parameters: 1
	Flags: Private
	Line Number: 2113
*/
function private function_cca7fa66(var_dvar_value)
{
	wait(2);
	if(var_dvar_value == 2)
	{
		level.var_147d7517["full_ammo"] = 0;
		level namespace_flag::function_set("using_mutator_settings");
		return;
	}
}

/*
	Name: function_549245ed
	Namespace: namespace_1635148
	Checksum: 0x424F4353
	Offset: 0x7A80
	Size: 0x58
	Parameters: 1
	Flags: Private
	Line Number: 2134
*/
function function_549245ed()
{
System.InvalidOperationException: Stack empty.
   at System.ThrowHelper.ThrowInvalidOperationException(ExceptionResource resource)
   at System.Collections.Generic.Stack`1.Pop()
   at Cerberus.Logic.Decompiler.BuildCondition(Int32 startIndex)
   at Cerberus.Logic.Decompiler.FindIfStatements()
   at Cerberus.Logic.Decompiler..ctor(ScriptExport function, ScriptBase script)
}

/*
	Name: function_5a6a815f
	Namespace: namespace_1635148
	Checksum: 0x424F4353
	Offset: 0x7AE0
	Size: 0x58
	Parameters: 1
	Flags: Private
	Line Number: 2154
*/
function private function_5a6a815f(var_dvar_value)
{
	wait(2);
	if(var_dvar_value == 2)
	{
		level.var_147d7517["minigun"] = 0;
		level namespace_flag::function_set("using_mutator_settings");
	}
}

/*
	Name: function_40b5d6c8
	Namespace: namespace_1635148
	Checksum: 0x424F4353
	Offset: 0x7B40
	Size: 0x68
	Parameters: 1
	Flags: Private
	Line Number: 2174
*/
function private function_40b5d6c8(var_dvar_value)
{
	wait(2);
	if(var_dvar_value == 2)
	{
		level namespace_flag::function_set("using_mutator_settings");
		for(;;)
		{
			wait(5);
			level.var_zombie_powerups["zombie_blood"].var_func_should_drop_with_regular_powerups = 0;
		}
	}
}

/*
	Name: function_9c404bf7
	Namespace: namespace_1635148
	Checksum: 0x424F4353
	Offset: 0x7BB0
	Size: 0x40
	Parameters: 1
	Flags: Private
	Line Number: 2198
*/
function private function_9c404bf7(var_dvar_value)
{
	if(var_dvar_value == 2)
	{
		level namespace_flag::function_set("using_mutator_settings");
		level.var_f7494eda = 0;
	}
}

/*
	Name: function_6be9a909
	Namespace: namespace_1635148
	Checksum: 0x424F4353
	Offset: 0x7BF8
	Size: 0x170
	Parameters: 1
	Flags: Private
	Line Number: 2217
*/
function private function_6be9a909(var_dvar_value)
{
	if(var_dvar_value == 2)
	{
		level namespace_flag::function_set("using_mutator_settings");
		level.var_mechz_rounds_enabled = 0;
		level.var_napalmZombiesEnabled = 0;
		level.var_sonicZombiesEnabled = 0;
		var_spawners = function_GetEnt("actor_spawner_zm_theater_quad", "classname");
		var_spawners function_delete();
		var_spawners = function_GetEnt("actor_spawner_zm_moon_quad", "classname");
		var_spawners function_delete();
		var_spawners = function_GetEnt("actor_spawner_zm_moon_astro", "classname");
		var_spawners function_delete();
		wait(5);
		level.var_29b69441 = 1;
		level namespace_flag::function_wait_till("power_on");
		level namespace_flag::function_wait_till("perk_bought");
		wait(2);
		level.var_next_monkey_round = 9999;
	}
}

/*
	Name: function_6299d599
	Namespace: namespace_1635148
	Checksum: 0x424F4353
	Offset: 0x7D70
	Size: 0x50
	Parameters: 1
	Flags: Private
	Line Number: 2250
*/
function private function_6299d599(var_dvar_value)
{
	if(var_dvar_value >= 2)
	{
		level namespace_flag::function_set("using_mutator_settings");
		level.var_affed9f4["zombie_max"] = var_dvar_value;
	}
}

/*
	Name: function_cb03afce
	Namespace: namespace_1635148
	Checksum: 0x424F4353
	Offset: 0x7DC8
	Size: 0x70
	Parameters: 1
	Flags: None
	Line Number: 2269
*/
function function_cb03afce(var_dvar_value)
{
	wait(0.05);
	if(var_dvar_value > 1)
	{
		wait(3);
		if(level namespace_flag::function_get("classic_enabled"))
		{
			return;
		}
		namespace_callback::function_on_spawned(&function_a05dc214);
	}
}

/*
	Name: function_a05dc214
	Namespace: namespace_1635148
	Checksum: 0x424F4353
	Offset: 0x7E40
	Size: 0x20
	Parameters: 0
	Flags: None
	Line Number: 2293
*/
function function_a05dc214()
{
	self thread function_a3da1c9d();
}

/*
	Name: function_8aa75b62
	Namespace: namespace_1635148
	Checksum: 0x424F4353
	Offset: 0x7E68
	Size: 0x70
	Parameters: 1
	Flags: None
	Line Number: 2308
*/
function function_8aa75b62(var_dvar_value)
{
	wait(0.05);
	if(var_dvar_value > 1)
	{
		wait(3);
		if(level namespace_flag::function_get("classic_enabled"))
		{
			return;
		}
		namespace_callback::function_on_spawned(&function_528e9750);
	}
}

/*
	Name: function_528e9750
	Namespace: namespace_1635148
	Checksum: 0x424F4353
	Offset: 0x7EE0
	Size: 0x20
	Parameters: 0
	Flags: None
	Line Number: 2332
*/
function function_528e9750()
{
	self thread function_90a3e012();
}

/*
	Name: function_2bfbc731
	Namespace: namespace_1635148
	Checksum: 0x424F4353
	Offset: 0x7F08
	Size: 0x1C8
	Parameters: 1
	Flags: Private
	Line Number: 2347
*/
function private function_2bfbc731(var_dvar_value)
{
	wait(0.05);
	if(var_dvar_value == 2)
	{
		level namespace_flag::function_set("using_mutator_settings");
		level.var_dogs_enabled = 0;
		var_spawners = function_GetEnt("actor_spawner_zm_theater_quad", "classname");
		var_spawners function_delete();
		var_spawners = function_GetEnt("actor_spawner_zm_moon_quad", "classname");
		var_spawners function_delete();
		var_spawners = function_GetEnt("actor_spawner_zm_moon_astro", "classname");
		var_spawners function_delete();
		wait(5);
		level.var_n_next_raps_round = 9999;
		level.var_3013498 = 9999;
		level.var_a78effc7 = 9999;
		level.var_next_wasp_round = 9999;
		level.var_next_dog_round = 9999;
		level namespace_flag::function_wait_till("power_on");
		level.var_n_next_raps_round = 9999;
		level.var_3013498 = 9999;
		level.var_a78effc7 = 9999;
		level.var_next_wasp_round = 9999;
		level.var_next_dog_round = 9999;
		level namespace_flag::function_wait_till("perk_bought");
		wait(2);
		level.var_next_monkey_round = 9999;
	}
}

/*
	Name: function_theater_ignore_spawner
	Namespace: namespace_1635148
	Checksum: 0x424F4353
	Offset: 0x80D8
	Size: 0x30
	Parameters: 1
	Flags: None
	Line Number: 2388
*/
function function_theater_ignore_spawner(var_spawner)
{
	if(var_spawner.var_script_noteworthy == "quad_zombie_spawner")
	{
		return 1;
	}
	return 0;
}

/*
	Name: function_417a0316
	Namespace: namespace_1635148
	Checksum: 0x424F4353
	Offset: 0x8110
	Size: 0x88
	Parameters: 1
	Flags: None
	Line Number: 2407
*/
function function_417a0316(var_dvar_value)
{
	level namespace_flag::function_init("allow_elemental_zombies");
	wait(0.05);
	if(var_dvar_value == 2)
	{
		wait(2);
		level namespace_flag::function_set("allow_elemental_zombies");
		level namespace_flag::function_set("using_mutator_settings");
	}
}

/*
	Name: function_ec0a72dc
	Namespace: namespace_1635148
	Checksum: 0x424F4353
	Offset: 0x81A0
	Size: 0x88
	Parameters: 1
	Flags: None
	Line Number: 2429
*/
function function_ec0a72dc(var_dvar_value)
{
	level namespace_flag::function_init("disable_armored_zombies");
	wait(0.05);
	if(var_dvar_value == 2)
	{
		wait(2);
		level namespace_flag::function_set("disable_armored_zombies");
		level namespace_flag::function_set("using_mutator_settings");
		return;
	}
}

/*
	Name: function_5eed7e2c
	Namespace: namespace_1635148
	Checksum: 0x424F4353
	Offset: 0x8230
	Size: 0x398
	Parameters: 1
	Flags: None
	Line Number: 2452
*/
function function_5eed7e2c(var_dvar_value)
{
	level namespace_flag::function_init("allow_gungame");
	wait(0.05);
	if(var_dvar_value == 2)
	{
		level namespace_flag::function_set("allow_gungame");
		level namespace_flag::function_set("using_mutator_settings");
		level.var_bgb_in_use = 0;
		level.var_919b0320 = 1;
		level.var_fd6c66c2 = 0;
		var_9d8064ad = function_GetEntArray("bgb_machine_use", "targetname");
		foreach(var_bgb in var_9d8064ad)
		{
			if(isdefined(var_bgb.var_unitrigger_stub))
			{
				var_bgb.var_unitrigger_stub.var_og_origin = var_bgb.var_unitrigger_stub.var_origin;
				var_bgb.var_unitrigger_stub.var_origin = var_bgb.var_unitrigger_stub.var_origin - VectorScale((0, 0, 1), 1000);
				var_bgb.var_unitrigger_stub.var_8b8a66cc = function_spawn("trigger_radius_use", var_bgb.var_unitrigger_stub.var_og_origin, 0, 16, 16);
				var_bgb.var_unitrigger_stub.var_8b8a66cc function_SetTeamForTrigger("allies");
				var_bgb.var_unitrigger_stub.var_8b8a66cc function_setcursorhint("HINT_NOICON");
				var_bgb.var_unitrigger_stub.var_8b8a66cc function_setHintString("Gobblegums are disabled");
				var_bgb function_SetZBarrierPieceState(3, "closed");
			}
		}
		wait(8);
		level.var_fd6c66c2 = 0;
		for(;;)
		{
			wait(4);
			namespace_zm_powerups::function_powerup_remove_from_regular_drops("full_ammo");
			namespace_zm_powerups::function_powerup_remove_from_regular_drops("fire_sale");
			namespace_zm_powerups::function_powerup_remove_from_regular_drops("minigun");
			level thread function_3b8ebb2("specialty_additionalprimaryweapon");
			level thread function_3b8ebb2("specialty_extraammo");
			level.var_147d7517["minigun"] = 0;
			level.var_147d7517["fire_sale"] = 0;
			level.var_147d7517["full_ammo"] = 0;
		}
	}
}

/*
	Name: function_5813855e
	Namespace: namespace_1635148
	Checksum: 0x424F4353
	Offset: 0x85D0
	Size: 0x58
	Parameters: 1
	Flags: None
	Line Number: 2504
*/
function function_5813855e(var_dvar_value)
{
	if(!isdefined(level.var_90d57b96))
	{
		level.var_90d57b96 = function_Int(var_dvar_value);
	}
	level.var_90d57b96 = function_Int(var_dvar_value);
}

/*
	Name: function_4c8f3a03
	Namespace: namespace_1635148
	Checksum: 0x424F4353
	Offset: 0x8630
	Size: 0x58
	Parameters: 1
	Flags: None
	Line Number: 2523
*/
function function_4c8f3a03(var_dvar_value)
{
	if(!isdefined(level.var_9ff42471))
	{
		level.var_9ff42471 = function_Int(var_dvar_value);
	}
	level.var_9ff42471 = function_Int(var_dvar_value);
	return;
}

/*
	Name: function_37de54c1
	Namespace: namespace_1635148
	Checksum: 0x424F4353
	Offset: 0x8690
	Size: 0x58
	Parameters: 1
	Flags: None
	Line Number: 2543
*/
function function_37de54c1(var_dvar_value)
{
	if(!isdefined(level.var_b1cf1e73))
	{
		level.var_b1cf1e73 = function_Int(var_dvar_value);
	}
	level.var_b1cf1e73 = function_Int(var_dvar_value);
}

/*
	Name: function_bef1eeb1
	Namespace: namespace_1635148
	Checksum: 0x424F4353
	Offset: 0x86F0
	Size: 0x300
	Parameters: 1
	Flags: None
	Line Number: 2562
*/
function function_bef1eeb1(var_dvar_value)
{
	level namespace_flag::function_init("allow_loot_mode");
	wait(0.05);
	if(var_dvar_value == 2)
	{
		var_6ee6222b = namespace_fdf6e22f::function_e57c5b69();
		if(isdefined(var_6ee6222b) && var_6ee6222b)
		{
			level namespace_flag::function_set("allow_loot_mode");
			level namespace_flag::function_set("using_mutator_settings");
			level.var_bgb_in_use = 0;
			level.var_fd6c66c2 = 0;
			var_9d8064ad = function_GetEntArray("bgb_machine_use", "targetname");
			foreach(var_bgb in var_9d8064ad)
			{
				if(isdefined(var_bgb.var_unitrigger_stub))
				{
					var_bgb.var_unitrigger_stub.var_og_origin = var_bgb.var_unitrigger_stub.var_origin;
					var_bgb.var_unitrigger_stub.var_origin = var_bgb.var_unitrigger_stub.var_origin - VectorScale((0, 0, 1), 1000);
					var_bgb.var_unitrigger_stub.var_8b8a66cc = function_spawn("trigger_radius_use", var_bgb.var_unitrigger_stub.var_og_origin, 0, 16, 16);
					var_bgb.var_unitrigger_stub.var_8b8a66cc function_SetTeamForTrigger("allies");
					var_bgb.var_unitrigger_stub.var_8b8a66cc function_setcursorhint("HINT_NOICON");
					var_bgb.var_unitrigger_stub.var_8b8a66cc function_setHintString("Gobblegums are disabled");
					var_bgb function_SetZBarrierPieceState(3, "closed");
				}
			}
			wait(8);
			level thread function_2bfbc731(2);
			level.var_fd6c66c2 = 0;
		}
	}
}

/*
	Name: function_15e6b3ee
	Namespace: namespace_1635148
	Checksum: 0x424F4353
	Offset: 0x89F8
	Size: 0x70
	Parameters: 1
	Flags: Private
	Line Number: 2606
*/
function private function_15e6b3ee(var_attacker)
{
	if(isdefined(level.var_fb7be6ac) && isdefined(level.var_f345e88f) && function_isPlayer(var_attacker))
	{
		level.var_f345e88f++;
		if(level.var_f345e88f >= level.var_fb7be6ac)
		{
			level notify("hash_end_game");
		}
	}
}

/*
	Name: function_ff1d538e
	Namespace: namespace_1635148
	Checksum: 0x424F4353
	Offset: 0x8A70
	Size: 0xE0
	Parameters: 15
	Flags: Private
	Line Number: 2628
*/
function function_ff1d538e()
{
System.InvalidOperationException: Stack empty.
   at System.ThrowHelper.ThrowInvalidOperationException(ExceptionResource resource)
   at System.Collections.Generic.Stack`1.Pop()
   at Cerberus.Logic.Decompiler.BuildCondition(Int32 startIndex)
   at Cerberus.Logic.Decompiler.FindIfStatements()
   at Cerberus.Logic.Decompiler..ctor(ScriptExport function, ScriptBase script)
}

/*
	Name: function_ab963c2c
	Namespace: namespace_1635148
	Checksum: 0x424F4353
	Offset: 0x8B58
	Size: 0x4
	Parameters: 0
	Flags: Private
	Line Number: 2648
*/
function private function_ab963c2c()
{
}

