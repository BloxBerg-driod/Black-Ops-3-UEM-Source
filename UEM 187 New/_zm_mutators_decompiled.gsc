#include scripts\codescripts\struct;
#include scripts\shared\ai\zombie_utility;
#include scripts\shared\array_shared;
#include scripts\shared\callbacks_shared;
#include scripts\shared\clientfield_shared;
#include scripts\shared\flag_shared;
#include scripts\shared\system_shared;
#include scripts\shared\util_shared;
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
	Name: __init__sytem__
	Namespace: namespace_1635148
	Checksum: 0x424F4353
	Offset: 0x2068
	Size: 0x40
	Parameters: 0
	Flags: AutoExec
	Line Number: 46
*/
function autoexec __init__sytem__()
{
	system::register("zm_mutators", &__init__, &__main__, undefined);
	return;
	ERROR: Exception occured: Stack empty.
}

/*
	Name: __init__
	Namespace: namespace_1635148
	Checksum: 0x424F4353
	Offset: 0x20B0
	Size: 0x130
	Parameters: 0
	Flags: Private
	Line Number: 63
*/
function private __init__()
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
		if(isdefined(var_a6f9d71d.prefunc) && IsFunctionPtr(var_a6f9d71d.prefunc))
		{
			level thread [[var_a6f9d71d.prefunc]](getdvarint(var_a6f9d71d.dvar));
		}
	}
	return;
}

/*
	Name: __main__
	Namespace: namespace_1635148
	Checksum: 0x424F4353
	Offset: 0x21E8
	Size: 0xD8
	Parameters: 0
	Flags: Private
	Line Number: 95
*/
function private __main__()
{
	foreach(var_a6f9d71d in level.var_1635148)
	{
		if(isdefined(var_a6f9d71d.postfunc) && IsFunctionPtr(var_a6f9d71d.postfunc))
		{
			level thread [[var_a6f9d71d.postfunc]](getdvarint(var_a6f9d71d.dvar));
		}
	}
}

/*
	Name: function_37f528c2
	Namespace: namespace_1635148
	Checksum: 0x424F4353
	Offset: 0x22C8
	Size: 0x130
	Parameters: 0
	Flags: None
	Line Number: 116
*/
function function_37f528c2()
{
	level flag::init("using_mutator_settings");
	wait(0.05);
	while(!level flag::get("using_mutator_settings"))
	{
		wait(0.5);
	}
	foreach(player in getplayers())
	{
		player.pers["mutator_settings"]++;
		player thread namespace_97ac1184::function_7e18304e("spx_save_data", "mutator_settings", player.pers["mutator_settings"], 0);
	}
}

/*
	Name: function_36137155
	Namespace: namespace_1635148
	Checksum: 0x424F4353
	Offset: 0x2400
	Size: 0x148
	Parameters: 4
	Flags: None
	Line Number: 141
*/
function function_36137155(var_27928f89, dvar_name, var_31a2eb85, var_facbf7a4)
{
	/#
		Assert(isdefined(var_27928f89), "Dev Block strings are not supported");
	#/
	/#
		Assert(isdefined(dvar_name), "Dev Block strings are not supported");
	#/
	/#
		Assert(!isdefined(level.var_1635148[var_27928f89]), "Dev Block strings are not supported" + var_27928f89 + "Dev Block strings are not supported");
	#/
	level.var_1635148[var_27928f89] = spawnstruct();
	level.var_1635148[var_27928f89].name = var_27928f89;
	level.var_1635148[var_27928f89].dvar = dvar_name;
	level.var_1635148[var_27928f89].postfunc = var_facbf7a4;
	level.var_1635148[var_27928f89].prefunc = var_31a2eb85;
}

/*
	Name: function_627e6ba4
	Namespace: namespace_1635148
	Checksum: 0x424F4353
	Offset: 0x2550
	Size: 0xC48
	Parameters: 0
	Flags: Private
	Line Number: 169
*/
function private function_627e6ba4()
{
	zm_spawner::register_zombie_death_event_callback(&function_15e6b3ee);
	zm::register_vehicle_damage_callback(&function_ff1d538e);
	function_36137155("MutatorSettings_Classic", "mutator_classic", undefined, &function_6d475949);
	function_36137155("MutatorSettings_GameDifficulty", "mutator_gamedifficulty", undefined, &change_difficulty);
	function_36137155("MutatorSettings_RoamerOption", "mutator_roameroption", undefined, &function_ec1ce953);
	function_36137155("MutatorSettings_RageInducer", "mutator_rageinducer", undefined, &function_b41cf764);
	function_36137155("MutatorSettings_StartingRound", "mutator_startround", &function_266c59d5, undefined);
	function_36137155("MutatorSettings_TimeCap", "mutator_timecap", undefined, &function_d4ea1ee9);
	function_36137155("MutatorSettings_KillCap", "mutator_killcap", &function_e2b8923d, undefined);
	function_36137155("MutatorSettings_Traps", "mutator_traps", undefined, &disable_traps);
	function_36137155("MutatorSettings_GobbleGums", "mutator_gobblegums", undefined, &function_8902641d);
	function_36137155("MutatorSettings_PaP", "mutator_pap", undefined, &function_d06ebb6e);
	function_36137155("MutatorSettings_MysteryBox", "mutator_mysterybox", undefined, &function_862020a8);
	function_36137155("MutatorSettings_PerkLimit", "mutator_perklimit", &function_2757c634, undefined);
	function_36137155("MutatorSettings_Speedrun", "mutator_speedrun", undefined, &function_3547f1cf);
	function_36137155("MutatorSettings_WeaponDropSystem", "mutator_weapondropsystem", &function_c204ff6b, undefined);
	function_36137155("MutatorSettings_DeploymentStation", "mutator_deploymentstation", &function_823b1606, undefined);
	function_36137155("MutatorSettings_UpgradedGunsRandomBox", "mutator_upgradedgunsrandombox", &function_5991cb2, undefined);
	function_36137155("MutatorSettings_PackaPunchRepackUses", "mutator_packapunchrepackuses", &function_4978a94b, undefined);
	function_36137155("MutatorSettings_BlackOpsFourMaxAmmo", "mutator_blackopsfourmaxammo", &function_2df1ed06, undefined);
	function_36137155("MutatorSettings_BlackOpsFourCarpenter", "mutator_blackopsfourcarpenter", &function_4435e870, undefined);
	function_36137155("MutatorSettings_AmmoPacks", "mutator_ammopacks", &function_cfa85281, undefined);
	function_36137155("MutatorSettings_PerksAllow", "mutator_perksallow", undefined, &function_7f0e83d);
	function_36137155("MutatorSettings_WunderfizzActive", "mutator_wunderfizzactive", undefined, &function_6742a62);
	function_36137155("MutatorSettings_PerkJuggernogAllow", "mutator_perkjuggernogallow", undefined, &function_a476b02a);
	function_36137155("MutatorSettings_PerkQuickReviveAllow", "mutator_perkquickreviveallow", undefined, &disable_quickrevive);
	function_36137155("MutatorSettings_PerkSpeedColaAllow", "mutator_perkspeedcolaallow", undefined, &function_b576d858);
	function_36137155("MutatorSettings_PerkDoubleTapAllow", "mutator_perkdoubletapallow", undefined, &function_30fc5aa8);
	function_36137155("MutatorSettings_PerkStaminUpAllow", "mutator_perkstaminupallow", undefined, &function_7485ffdf);
	function_36137155("MutatorSettings_PerkMuleKickAllow", "mutator_perkmulekickallow", undefined, &function_51f03993);
	function_36137155("MutatorSettings_PerkDeadshotAllow", "mutator_perkdeadshotallow", undefined, &disable_deadshot);
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
	function_36137155("MutatorSettings_DoublePoints", "mutator_doublepoints", &function_dced484c, undefined);
	function_36137155("MutatorSettings_Carpenter", "mutator_carpenter", &function_40d379e, undefined);
	function_36137155("MutatorSettings_BonusPoints", "mutator_bonuspoints", &function_e485a83a, undefined);
	function_36137155("MutatorSettings_FireSale", "mutator_firesale", &function_428816c7, undefined);
	function_36137155("MutatorSettings_InstaKill", "mutator_instakill", &function_5ff53437, undefined);
	function_36137155("MutatorSettings_MaxAmmo", "mutator_maxammo", &function_cca7fa66, undefined);
	function_36137155("MutatorSettings_Nuke", "mutator_nuke", &function_549245ed, undefined);
	function_36137155("MutatorSettings_Minigun", "mutator_minigun", &function_5a6a815f, undefined);
	function_36137155("MutatorSettings_ZombieBlood", "mutator_zombieblood", &function_40b5d6c8, undefined);
	function_36137155("MutatorSettings_WeaponMaps", "mutator_weaponmaps", &function_4d42012e, undefined);
	function_36137155("MutatorSettings_WallWeapons", "mutator_wallweapons", &function_806c4836, undefined);
	function_36137155("MutatorSettings_WeaponWonder", "mutator_weaponwonder", &function_7a19d952, undefined);
	function_36137155("MutatorSettings_WeaponWonderLimit", "mutator_weaponwonderlimit", &function_85c69390, undefined);
	function_36137155("MutatorSettings_WeaponDLC", "mutator_weapondlc", &function_8bc8b470, undefined);
	function_36137155("MutatorSettings_WeaponMelee", "mutator_weaponmelee", &function_8749d7c9, undefined);
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
	return;
}

/*
	Name: function_ec1ce953
	Namespace: namespace_1635148
	Checksum: 0x424F4353
	Offset: 0x31A0
	Size: 0x80
	Parameters: 1
	Flags: None
	Line Number: 250
*/
function function_ec1ce953(dvar_value)
{
	level flag::init("roamer_option_enabled");
	wait(0.05);
	if(dvar_value == 2)
	{
		level flag::set("roamer_option_enabled");
		level.var_e5e729a2 = 0;
		level.func_get_delay_between_rounds = &get_delay_between_rounds;
	}
}

/*
	Name: get_delay_between_rounds
	Namespace: namespace_1635148
	Checksum: 0x424F4353
	Offset: 0x3228
	Size: 0x1B8
	Parameters: 0
	Flags: None
	Line Number: 272
*/
function get_delay_between_rounds()
{
	if(level flag::get("roamer_option_enabled"))
	{
		level.var_e5e729a2 = 1;
		level.var_3aee3ea7 = 0;
		foreach(player in getplayers())
		{
			player thread function_3c091b90();
		}
		function_6f78f4fc();
		level.var_e5e729a2 = 0;
		foreach(player in getplayers())
		{
			player thread namespace_97ac1184::function_8c165b4d("Data", "Roamer.Players", 0);
		}
		return 0;
	}
	else
	{
		return level.zombie_vars["zombie_between_round_time"];
	}
	return level.zombie_vars["zombie_between_round_time"];
}

/*
	Name: function_6f78f4fc
	Namespace: namespace_1635148
	Checksum: 0x424F4353
	Offset: 0x33E8
	Size: 0x30
	Parameters: 0
	Flags: None
	Line Number: 307
*/
function function_6f78f4fc()
{
	while(level.var_3aee3ea7 < level.players.size)
	{
		wait(1);
	}
	level.var_3aee3ea7 = 0;
}

/*
	Name: function_3c091b90
	Namespace: namespace_1635148
	Checksum: 0x424F4353
	Offset: 0x3420
	Size: 0x160
	Parameters: 0
	Flags: None
	Line Number: 326
*/
function function_3c091b90()
{
	self.var_10567d28 = 0;
	self thread namespace_97ac1184::function_8c165b4d("Data", "Roamer.Players", 1, 1);
	while(!self.var_10567d28)
	{
		time = 0;
		self thread namespace_97ac1184::function_8c165b4d("Data", "Roamer.Timer", time, 1);
		while(self meleebuttonpressed())
		{
			time = time + 0.05;
			self thread namespace_97ac1184::function_8c165b4d("Data", "Roamer.Timer", time / 2, 1);
			if(time >= 1.5)
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
	Offset: 0x3588
	Size: 0x300
	Parameters: 1
	Flags: None
	Line Number: 361
*/
function function_6d475949(dvar_value)
{
	level flag::init("classic_enabled");
	wait(0.05);
	if(dvar_value > 1)
	{
		level flag::set("classic_enabled");
		level thread function_6a298c67();
		callback::on_spawned(&function_57c443e8);
		level.var_7ceb1b41 = 1;
		level.var_2198e3c0 = 0;
		level.var_7f7e3195 = 0;
		level.var_fd6c66c2 = 0;
		wait(10);
		level thread function_3b8ebb2("specialty_extraammo");
		level thread function_3b8ebb2("specialty_tracker");
		level thread function_3b8ebb2("specialty_widowswine");
		level thread function_3b8ebb2("specialty_immunetriggerbetty");
		level thread function_3b8ebb2("specialty_electriccherry");
		level thread function_3b8ebb2("specialty_immunetriggershock");
		if(dvar_value == 2)
		{
			level thread function_3b8ebb2("specialty_phdflopper");
			level thread function_3b8ebb2("specialty_staminup");
			level thread function_3b8ebb2("specialty_additionalprimaryweapon");
			level thread function_3b8ebb2("specialty_deadshot");
		}
		while(dvar_value == 2)
		{
			zm_powerups::powerup_remove_from_regular_drops("bonus_points_team");
			zm_powerups::powerup_remove_from_regular_drops("fire_sale");
			zm_powerups::powerup_remove_from_regular_drops("minigun");
			zm_powerups::powerup_remove_from_regular_drops("xp_drop");
			level.zombie_weapons[getweapon("t9_crossbow_skull")].is_in_box = 0;
			level.zombie_weapons[getweapon("t9_gallo_raygun")].is_in_box = 0;
			level.var_240d2289 = 0;
			level.var_c127fb71 = 0;
			wait(2);
		}
	}
}

/*
	Name: function_6a298c67
	Namespace: namespace_1635148
	Checksum: 0x424F4353
	Offset: 0x3890
	Size: 0x228
	Parameters: 0
	Flags: None
	Line Number: 413
*/
function function_6a298c67()
{
	var_9d8064ad = getentarray("bgb_machine_use", "targetname");
	level.bgb_in_use = 0;
	foreach(bgb in var_9d8064ad)
	{
		if(isdefined(bgb.unitrigger_stub))
		{
			bgb.unitrigger_stub.og_origin = bgb.unitrigger_stub.origin;
			bgb.unitrigger_stub.origin = bgb.unitrigger_stub.origin - VectorScale((0, 0, 1), 1000);
			bgb.unitrigger_stub.var_8b8a66cc = spawn("trigger_radius_use", bgb.unitrigger_stub.og_origin, 0, 16, 16);
			bgb.unitrigger_stub.var_8b8a66cc setteamfortrigger("allies");
			bgb.unitrigger_stub.var_8b8a66cc setcursorhint("HINT_NOICON");
			bgb.unitrigger_stub.var_8b8a66cc sethintstring("Gums are Disabled for now");
			bgb SetZBarrierPieceState(3, "closed");
		}
	}
}

/*
	Name: function_57c443e8
	Namespace: namespace_1635148
	Checksum: 0x424F4353
	Offset: 0x3AC0
	Size: 0x38
	Parameters: 0
	Flags: None
	Line Number: 442
*/
function function_57c443e8()
{
	self thread function_90a3e012();
	self thread function_a3da1c9d();
}

/*
	Name: function_90a3e012
	Namespace: namespace_1635148
	Checksum: 0x424F4353
	Offset: 0x3B00
	Size: 0xB0
	Parameters: 0
	Flags: None
	Line Number: 458
*/
function function_90a3e012()
{
	self endon("bled_out");
	self endon("spawned_player");
	self endon("disconnect");
	while(1)
	{
		if(isdefined(self))
		{
			if(zm_utility::is_player_valid(self))
			{
				while(self isreloading())
				{
					self allowsprint(0);
					wait(0.1);
				}
				self allowsprint(1);
			}
		}
		wait(0.1);
	}
}

/*
	Name: function_a3da1c9d
	Namespace: namespace_1635148
	Checksum: 0x424F4353
	Offset: 0x3BB8
	Size: 0x70
	Parameters: 0
	Flags: None
	Line Number: 491
*/
function function_a3da1c9d()
{
	self endon("bled_out");
	self endon("spawned_player");
	self endon("disconnect");
	while(1)
	{
		if(isdefined(self))
		{
			if(zm_utility::is_player_valid(self))
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
	Offset: 0x3C30
	Size: 0x80
	Parameters: 1
	Flags: None
	Line Number: 519
*/
function function_3547f1cf(dvar_value)
{
	level flag::init("speedrun_enabled");
	wait(0.05);
	if(dvar_value == 2)
	{
		level flag::set("speedrun_enabled");
		level flag::set("using_mutator_settings");
	}
}

/*
	Name: function_2757c634
	Namespace: namespace_1635148
	Checksum: 0x424F4353
	Offset: 0x3CB8
	Size: 0x68
	Parameters: 1
	Flags: Private
	Line Number: 540
*/
function private function_2757c634(dvar_value)
{
	if(dvar_value >= 2)
	{
		while(!isdefined(level.machine_assets))
		{
			wait(0.05);
		}
		wait(5);
		level.var_842626f0 = dvar_value;
		level flag::set("using_mutator_settings");
	}
}

/*
	Name: function_266c59d5
	Namespace: namespace_1635148
	Checksum: 0x424F4353
	Offset: 0x3D28
	Size: 0x78
	Parameters: 1
	Flags: Private
	Line Number: 564
*/
function private function_266c59d5(dvar_value)
{
	if(dvar_value >= 2)
	{
		callback::on_connect(&function_aa0d54c);
		level.round_prestart_func = &set_round_number;
		level flag::set("using_mutator_settings");
	}
}

/*
	Name: set_round_number
	Namespace: namespace_1635148
	Checksum: 0x424F4353
	Offset: 0x3DA8
	Size: 0xB0
	Parameters: 0
	Flags: Private
	Line Number: 584
*/
function private set_round_number()
{
	round = getdvarint("mutator_startround");
	level.var_91874529 = round;
	level.round_number = round;
	setroundsplayed(level.round_number);
	game["roundsplayed"] = level.round_number;
	level.zombie_move_speed = level.round_number * level.zombie_vars["zombie_move_speed_multiplier"];
	zm::set_round_number(round);
}

/*
	Name: function_aa0d54c
	Namespace: namespace_1635148
	Checksum: 0x424F4353
	Offset: 0x3E60
	Size: 0x40
	Parameters: 0
	Flags: Private
	Line Number: 605
*/
function private function_aa0d54c()
{
	wait(6);
	self zm_score::add_to_player_score(100 * getdvarint("mutator_startround"));
}

/*
	Name: change_difficulty
	Namespace: namespace_1635148
	Checksum: 0x424F4353
	Offset: 0x3EA8
	Size: 0x188
	Parameters: 0
	Flags: Private
	Line Number: 621
*/
function private change_difficulty()
{
	difficulty = getdvarint("mutator_gamedifficulty");
	wait(0.05);
	level flag::wait_till("initial_blackscreen_passed");
	wait(2);
	if(difficulty > 1)
	{
		zm::register_player_damage_callback(&function_87d1927f);
		switch(difficulty)
		{
			case 2:
			{
				foreach(player in getplayers())
				{
					player luinotifyevent(&"spx_milestone_notification", 1, &"ZM_MINECRAFT_STARTUP_BABY_MODE");
				}
				level thread function_eee87dde("easy");
				level.var_bdc116e3 = 2;
				break;
			}
		}
		level flag::set("using_mutator_settings");
	}
}

/*
	Name: function_87d1927f
	Namespace: namespace_1635148
	Checksum: 0x424F4353
	Offset: 0x4038
	Size: 0xB0
	Parameters: 10
	Flags: None
	Line Number: 657
*/
function function_87d1927f(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime)
{
	if(isdefined(eattacker) && weapon.name == "zombie_ai_defaultmelee")
	{
		switch(level.var_bdc116e3)
		{
			case 2:
			{
				return 30;
			}
			default
			{
				return -1;
			}
		}
	}
	return -1;
}

/*
	Name: function_eee87dde
	Namespace: namespace_1635148
	Checksum: 0x424F4353
	Offset: 0x40F0
	Size: 0x448
	Parameters: 1
	Flags: None
	Line Number: 686
*/
function function_eee87dde(difficulty)
{
	if(isdefined(difficulty) && difficulty == "easy")
	{
		level.zombie_vars["zombie_between_round_time"] = level.var_ee5d3b93;
		level.zombie_vars["zombie_move_speed_multiplier"] = 1;
		foreach(ai_enemy in getaiteamarray("axis"))
		{
			ai_enemy zombie_utility::set_zombie_run_cycle_restore_from_override();
			ai_enemy zombie_utility::set_zombie_run_cycle_override_value("walk");
		}
	}
	else if(isdefined(difficulty) && difficulty == "normal")
	{
		level.zombie_vars["zombie_between_round_time"] = level.var_ee5d3b93;
		level.zombie_vars["zombie_move_speed_multiplier"] = level.var_8e473ceb;
		foreach(ai_enemy in getaiteamarray("axis"))
		{
			ai_enemy zombie_utility::set_zombie_run_cycle_restore_from_override();
			if(level.round_number <= 5)
			{
				ai_enemy zombie_utility::set_zombie_run_cycle_override_value("walk");
				continue;
			}
			ai_enemy zombie_utility::set_zombie_run_cycle_override_value("run");
		}
	}
	else if(isdefined(difficulty) && difficulty == "hard")
	{
		level.zombie_vars["zombie_between_round_time"] = 0.1;
		level.zombie_vars["zombie_move_speed_multiplier"] = 60;
		foreach(ai_enemy in getaiteamarray("axis"))
		{
			ai_enemy zombie_utility::set_zombie_run_cycle_restore_from_override();
			ai_enemy zombie_utility::set_zombie_run_cycle_override_value("sprint");
		}
	}
	else if(isdefined(difficulty) && difficulty == "super_hard")
	{
		level.zombie_vars["zombie_between_round_time"] = 0.1;
		level.zombie_vars["zombie_move_speed_multiplier"] = 200;
		foreach(ai_enemy in getaiteamarray("axis"))
		{
			ai_enemy zombie_utility::set_zombie_run_cycle_restore_from_override();
			ai_enemy zombie_utility::set_zombie_run_cycle_override_value("super_sprint");
		}
	}
}

/*
	Name: function_b41cf764
	Namespace: namespace_1635148
	Checksum: 0x424F4353
	Offset: 0x4540
	Size: 0xF8
	Parameters: 0
	Flags: Private
	Line Number: 745
*/
function private function_b41cf764()
{
	difficulty = getdvarint("mutator_rageinducer");
	wait(0.05);
	level flag::wait_till("initial_blackscreen_passed");
	wait(4);
	if(difficulty > 1)
	{
		level.var_679e1a9e = 1;
		level thread namespace_a74e4f35::change_difficulty("hard");
		level.zombie_actor_limit = 40 + 4 * getplayers().size;
		level.zombie_ai_limit = 40 + 4 * getplayers().size;
		level flag::set("using_mutator_settings");
	}
}

/*
	Name: function_8902641d
	Namespace: namespace_1635148
	Checksum: 0x424F4353
	Offset: 0x4640
	Size: 0x258
	Parameters: 1
	Flags: Private
	Line Number: 771
*/
function private function_8902641d(dvar_value)
{
	wait(0.05);
	if(dvar_value == 2)
	{
		level.bgb_in_use = 0;
		var_9d8064ad = getentarray("bgb_machine_use", "targetname");
		foreach(bgb in var_9d8064ad)
		{
			if(isdefined(bgb.unitrigger_stub))
			{
				bgb.unitrigger_stub.og_origin = bgb.unitrigger_stub.origin;
				bgb.unitrigger_stub.origin = bgb.unitrigger_stub.origin - VectorScale((0, 0, 1), 1000);
				bgb.unitrigger_stub.var_8b8a66cc = spawn("trigger_radius_use", bgb.unitrigger_stub.og_origin, 0, 16, 16);
				bgb.unitrigger_stub.var_8b8a66cc setteamfortrigger("allies");
				bgb.unitrigger_stub.var_8b8a66cc setcursorhint("HINT_NOICON");
				bgb.unitrigger_stub.var_8b8a66cc sethintstring("Gobblegums are disabled");
				bgb SetZBarrierPieceState(3, "closed");
			}
		}
		level flag::set("using_mutator_settings");
		return;
	}
}

/*
	Name: function_d06ebb6e
	Namespace: namespace_1635148
	Checksum: 0x424F4353
	Offset: 0x48A0
	Size: 0x58
	Parameters: 1
	Flags: Private
	Line Number: 806
*/
function private function_d06ebb6e(dvar_value)
{
	wait(0.05);
	if(dvar_value == 2)
	{
		wait(5);
		level.var_919b0320 = 1;
		level flag::set("using_mutator_settings");
	}
}

/*
	Name: function_862020a8
	Namespace: namespace_1635148
	Checksum: 0x424F4353
	Offset: 0x4900
	Size: 0x110
	Parameters: 1
	Flags: Private
	Line Number: 827
*/
function private function_862020a8(dvar_value)
{
	wait(0.05);
	if(dvar_value == 2)
	{
		while(!isdefined(level.chests))
		{
			wait(2);
		}
		foreach(box in level.chests)
		{
			box.zbarrier zm_magicbox::set_magic_box_zbarrier_state("away");
			box notify("kill_chest_think");
		}
		level notify("kill_chest_think");
		level flag::set("using_mutator_settings");
	}
}

/*
	Name: function_c204ff6b
	Namespace: namespace_1635148
	Checksum: 0x424F4353
	Offset: 0x4A18
	Size: 0x50
	Parameters: 1
	Flags: Private
	Line Number: 856
*/
function private function_c204ff6b(dvar_value)
{
	wait(0.05);
	if(dvar_value == 2)
	{
		level.var_7f7e3195 = 0;
		level flag::set("using_mutator_settings");
	}
}

/*
	Name: function_5991cb2
	Namespace: namespace_1635148
	Checksum: 0x424F4353
	Offset: 0x4A70
	Size: 0x50
	Parameters: 1
	Flags: Private
	Line Number: 876
*/
function private function_5991cb2(dvar_value)
{
	wait(0.05);
	if(dvar_value == 2)
	{
		level.var_2198e3c0 = 0;
		level flag::set("using_mutator_settings");
	}
}

/*
	Name: function_823b1606
	Namespace: namespace_1635148
	Checksum: 0x424F4353
	Offset: 0x4AC8
	Size: 0x50
	Parameters: 1
	Flags: Private
	Line Number: 896
*/
function private function_823b1606(dvar_value)
{
	wait(0.05);
	if(dvar_value == 2)
	{
		level.var_22a274bc = 0;
		level flag::set("using_mutator_settings");
		return;
	}
	ERROR: Exception occured: Stack empty.
}

/*
	Name: function_4978a94b
	Namespace: namespace_1635148
	Checksum: 0x424F4353
	Offset: 0x4B20
	Size: 0xC8
	Parameters: 1
	Flags: Private
	Line Number: 918
*/
function private function_4978a94b(dvar_value)
{
	wait(0.05);
	if(dvar_value >= 2)
	{
		switch(dvar_value)
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
				level.var_7ceb1b41 = dvar_value - 1;
				break;
			}
		}
		level flag::set("using_mutator_settings");
	}
}

/*
	Name: function_2df1ed06
	Namespace: namespace_1635148
	Checksum: 0x424F4353
	Offset: 0x4BF0
	Size: 0x60
	Parameters: 1
	Flags: Private
	Line Number: 958
*/
function private function_2df1ed06(dvar_value)
{
	level.var_240d2289 = 1;
	wait(0.05);
	if(dvar_value == 2)
	{
		wait(10);
		level.var_240d2289 = 0;
		level flag::set("using_mutator_settings");
	}
}

/*
	Name: function_4435e870
	Namespace: namespace_1635148
	Checksum: 0x424F4353
	Offset: 0x4C58
	Size: 0x58
	Parameters: 1
	Flags: Private
	Line Number: 980
*/
function private function_4435e870(dvar_value)
{
	wait(0.05);
	if(dvar_value == 2)
	{
		wait(10);
		level.var_c127fb71 = 0;
		level flag::set("using_mutator_settings");
		return;
	}
}

/*
	Name: function_cfa85281
	Namespace: namespace_1635148
	Checksum: 0x424F4353
	Offset: 0x4CB8
	Size: 0x50
	Parameters: 1
	Flags: Private
	Line Number: 1002
*/
function private function_cfa85281(dvar_value)
{
	wait(0.05);
	if(dvar_value == 2)
	{
		level.var_fd6c66c2 = 0;
		level flag::set("using_mutator_settings");
	}
}

/*
	Name: function_4d42012e
	Namespace: namespace_1635148
	Checksum: 0x424F4353
	Offset: 0x4D10
	Size: 0x80
	Parameters: 1
	Flags: Private
	Line Number: 1022
*/
function private function_4d42012e(dvar_value)
{
	level flag::init("keep_map_weapons");
	wait(0.05);
	if(dvar_value == 2)
	{
		level flag::set("keep_map_weapons");
		level flag::set("using_mutator_settings");
		return;
	}
	ERROR: Exception occured: Stack empty.
}

/*
	Name: function_806c4836
	Namespace: namespace_1635148
	Checksum: 0x424F4353
	Offset: 0x4D98
	Size: 0x330
	Parameters: 1
	Flags: Private
	Line Number: 1045
*/
function private function_806c4836(dvar_value)
{
	wait(0.05);
	if(dvar_value == 2)
	{
		var_1291a337 = struct::get_array("claymore_purchase", "targetname");
		if(var_1291a337.size > 1)
		{
			foreach(wallbuy in var_1291a337)
			{
				wallbuy.trigger_stub.origin = wallbuy.origin - VectorScale((0, 0, 1), 1000);
				wait(0.05);
				wallbuy struct::delete();
			}
		}
		var_30d7709f = struct::get_array("weapon_upgrade", "targetname");
		if(var_30d7709f.size > 1)
		{
			foreach(wallbuy in var_30d7709f)
			{
				wallbuy.trigger_stub.origin = wallbuy.origin - VectorScale((0, 0, 1), 1000);
				wait(0.05);
				wallbuy struct::delete();
			}
		}
		var_59eea563 = struct::get_array("bowie_upgrade", "targetname");
		if(var_59eea563.size > 1)
		{
			foreach(wallbuy in var_59eea563)
			{
				wallbuy.trigger_stub.origin = wallbuy.origin - VectorScale((0, 0, 1), 1000);
				wait(0.05);
				wallbuy struct::delete();
			}
		}
		level flag::set("using_mutator_settings");
	}
}

/*
	Name: function_7a19d952
	Namespace: namespace_1635148
	Checksum: 0x424F4353
	Offset: 0x50D0
	Size: 0x3D0
	Parameters: 1
	Flags: Private
	Line Number: 1094
*/
function private function_7a19d952(dvar_value)
{
	wait(0.05);
	if(dvar_value == 2)
	{
		var_e33eb0d5 = array("thundergun", "thundergun_upgraded", "idgun_upgraded", "idgun_0", "idgun_upgraded_0", "idgun_1", "idgun_upgraded_1", "idgun_2", "idgun_upgraded_2", "idgun_3", "idgun_upgraded_3", "idgun_4", "idgun_upgraded_4", "t7_idgun_genesis_0", "t7_idgun_genesis_0_upgraded", "idgun_genesis_0", "idgun_genesis_0_upgraded", "microwavegundw", "microwavegundw_upgraded", "microwavegun", "microwavegun_upgraded", "microwavegunlh", "microwavegunlh_upgraded", "t7_hero_mirg2000", "t7_hero_mirg2000_upgraded", "hero_mirg2000", "hero_mirg2000_upgraded", "skull_gun", "t7_shrink_ray", "t7_shrink_ray_upgraded", "octobomb", "octobomb_upgraded", "hero_gravityspikes_melee", "tesla_gun", "tesla_gun_upgraded", "staff_fire", "staff_fire_upgraded2", "staff_fire_upgraded3", "staff_water", "staff_water_upgraded2", "staff_water_upgraded3", "staff_lightning", "staff_lightning_upgraded2", "staff_lightning_upgraded3", "staff_air", "staff_air_upgraded2", "staff_air_upgraded3", "t7_staff_air", "t7_staff_fire", "t7_staff_lightning", "t7_staff_water", "t7_staff_air_upgraded", "t7_staff_fire_upgraded", "t7_staff_lightning_upgraded", "t7_staff_water_upgraded", "elemental_bow", "elemental_bow1", "elemental_bow2", "elemental_bow3", "elemental_bow4", "elemental_bow_storm", "elemental_bow_storm1", "elemental_bow_storm2", "elemental_bow_storm3", "elemental_bow_storm4", "elemental_bow_demongate", "elemental_bow_demongate1", "elemental_bow_demongate2", "elemental_bow_demongate3", "elemental_bow_demongate4", "elemental_bow_rune_prison", "elemental_bow_rune_prison1", "elemental_bow_rune_prison2", "elemental_bow_rune_prison3", "elemental_bow_rune_prison4", "elemental_bow_wolf", "elemental_bow_wolf1", "elemental_bow_wolf2", "elemental_bow_wolf3", "elemental_bow_wolf4", "elemental_bow_wolf_howl", "elemental_bow_wolf_howl1", "elemental_bow_wolf_howl2", "elemental_bow_wolf_howl3", "elemental_bow_wolf_howl4");
		for(;;)
		{
			foreach(weapon in var_e33eb0d5)
			{
				if(isdefined(level.zombie_weapons[getweapon(weapon)]))
				{
					level.zombie_weapons[getweapon(weapon)].is_in_box = 0;
				}
			}
			wait(30);
		}
		level flag::set("using_mutator_settings");
	}
}

/*
	Name: function_85c69390
	Namespace: namespace_1635148
	Checksum: 0x424F4353
	Offset: 0x54A8
	Size: 0x50
	Parameters: 1
	Flags: Private
	Line Number: 1125
*/
function private function_85c69390(dvar_value)
{
	wait(0.05);
	if(dvar_value == 2)
	{
		level.var_e37f7a7c = 2;
		level flag::set("using_mutator_settings");
	}
}

/*
	Name: function_8bc8b470
	Namespace: namespace_1635148
	Checksum: 0x424F4353
	Offset: 0x5500
	Size: 0x468
	Parameters: 1
	Flags: Private
	Line Number: 1145
*/
function private function_8bc8b470(dvar_value)
{
	wait(6);
	if(dvar_value == 2)
	{
		var_492da764 = array(getweapon("pistol_energy"), getweapon("pistol_m1911"), getweapon("pistol_shotgun_dw"), getweapon("pistol_c96"), getweapon("ar_famas"), getweapon("ar_garand"), getweapon("ar_peacekeeper"), getweapon("ar_an94"), getweapon("ar_galil"), getweapon("ar_m14"), getweapon("ar_m16"), getweapon("ar_pulse"), getweapon("ar_fastburst"), getweapon("ar_stg44"), getweapon("smg_sten"), getweapon("smg_mp40"), getweapon("smg_ppsh"), getweapon("smg_thompson"), getweapon("smg_longrange"), getweapon("smg_ak74u"), getweapon("smg_msmc"), getweapon("smg_nailgun"), getweapon("smg_rechamber"), getweapon("smg_sten2"), getweapon("smg_mp40_1940"), getweapon("lmg_infinite"), getweapon("lmg_rpk"), getweapon("lmg_mg08"), getweapon("shotgun_energy"), getweapon("shotgun_olympia"), getweapon("launcher_ex41"), getweapon("sniper_double"), getweapon("sniper_quickscope"), getweapon("sniper_mosin"), getweapon("sniper_chargeshot"), getweapon("sniper_xpr50"));
		for(;;)
		{
			foreach(weapon in var_492da764)
			{
				if(isdefined(level.zombie_weapons[weapon]))
				{
					level.zombie_weapons[weapon].is_in_box = 0;
				}
			}
			wait(30);
		}
		level flag::set("using_mutator_settings");
	}
}

/*
	Name: function_8749d7c9
	Namespace: namespace_1635148
	Checksum: 0x424F4353
	Offset: 0x5970
	Size: 0x3B8
	Parameters: 1
	Flags: Private
	Line Number: 1176
*/
function private function_8749d7c9(dvar_value)
{
	wait(6);
	if(dvar_value == 2)
	{
		var_4278db2b = array(getweapon("t9_bat_crockiller"), getweapon("sw_lightsaber_obi_wan"), getweapon("melee_shovel"), getweapon("melee_knuckles"), getweapon("melee_chainsaw"), getweapon("melee_butterfly"), getweapon("melee_improvise"), getweapon("melee_bowie"), getweapon("melee_loadout"), getweapon("melee_shockbaton"), getweapon("melee_sword"), getweapon("melee_crowbar"), getweapon("melee_katana"), getweapon("melee_prosthetic"), getweapon("melee_dagger"), getweapon("melee_bat"), getweapon("melee_jug"), getweapon("melee_jug_up"), getweapon("melee_boneglass"), getweapon("melee_nunchuks"), getweapon("melee_boxing"), getweapon("melee_crescent"), getweapon("melee_mace"), getweapon("melee_fireaxe"), getweapon("melee_wrench"), getweapon("melee_christmas_pipe"), getweapon("melee_4090"), getweapon("melee_4090_up"));
		for(;;)
		{
			foreach(weapon in var_4278db2b)
			{
				if(isdefined(level.zombie_weapons[weapon]) || isdefined(level.zombie_weapons_upgraded[weapon]))
				{
					level.zombie_weapons[weapon].is_in_box = 0;
				}
			}
			wait(30);
		}
		level flag::set("using_mutator_settings");
	}
}

/*
	Name: function_b3ace8ea
	Namespace: namespace_1635148
	Checksum: 0x424F4353
	Offset: 0x5D30
	Size: 0x50
	Parameters: 1
	Flags: Private
	Line Number: 1207
*/
function private function_b3ace8ea(dvar_value)
{
	wait(0.05);
	if(dvar_value == 2)
	{
		level.headshots_only = 1;
		level flag::set("using_mutator_settings");
	}
}

/*
	Name: function_d4ea1ee9
	Namespace: namespace_1635148
	Checksum: 0x424F4353
	Offset: 0x5D88
	Size: 0xA8
	Parameters: 1
	Flags: Private
	Line Number: 1227
*/
function private function_d4ea1ee9(dvar_value)
{
	level endon("end_game");
	level endon("end_round_think");
	if(dvar_value >= 1)
	{
		level flag::set("using_mutator_settings");
		wait(15);
		n_max_time = dvar_value * 60;
		for(n_timer = 0; n_timer < n_max_time; n_timer++)
		{
			wait(1);
		}
		level notify("end_game");
	}
}

/*
	Name: function_3eacb2ed
	Namespace: namespace_1635148
	Checksum: 0x424F4353
	Offset: 0x5E38
	Size: 0x160
	Parameters: 9
	Flags: None
	Line Number: 1254
*/
function function_3eacb2ed(elem, sort, x_align, var_82301424, x, y, font_scale, font, text)
{
	elem.sort = sort;
	elem.alignx = x_align;
	elem.aligny = var_82301424;
	elem.horzalign = x_align;
	elem.vertalign = var_82301424;
	elem.xoffset = 0;
	elem.yoffset = 0;
	elem.x = x;
	elem.y = y;
	elem.hidewheninmenu = 0;
	elem.hideWhenInDemo = 0;
	elem.fontscale = font_scale;
	elem.font = font;
	elem settext(text);
	return elem;
}

/*
	Name: function_48ef7026
	Namespace: namespace_1635148
	Checksum: 0x424F4353
	Offset: 0x5FA0
	Size: 0x108
	Parameters: 1
	Flags: Private
	Line Number: 1283
*/
function private function_48ef7026(dvar_value)
{
	if(dvar_value === 2)
	{
		level.var_9fffc62 = function_3eacb2ed(newhudelem(), 0, "center", "top", 0, 0, 1.8, "objective", &"");
		level.var_9fffc62 SetTimerUp(0);
		level waittill("end_game");
		if(isdefined(level.var_9fffc62))
		{
			level.var_9fffc62 fadeovertime(1);
			level.var_9fffc62.alpha = 0;
			wait(2);
			level.hudelem_count--;
			level.var_9fffc62 destroy();
		}
	}
}

/*
	Name: function_e2b8923d
	Namespace: namespace_1635148
	Checksum: 0x424F4353
	Offset: 0x60B0
	Size: 0x58
	Parameters: 1
	Flags: Private
	Line Number: 1311
*/
function private function_e2b8923d(dvar_value)
{
	if(dvar_value >= 100)
	{
		level.var_fb7be6ac = dvar_value;
		level.var_f345e88f = 0;
		level flag::set("using_mutator_settings");
	}
}

/*
	Name: disable_traps
	Namespace: namespace_1635148
	Checksum: 0x424F4353
	Offset: 0x6110
	Size: 0x320
	Parameters: 1
	Flags: Private
	Line Number: 1331
*/
function private disable_traps(dvar_value)
{
	wait(0.05);
	if(dvar_value == 2)
	{
		foreach(trap in getentarray("zombie_trap", "targetname"))
		{
			foreach(trig in trap._trap_use_trigs)
			{
				trig triggerenable(0);
			}
		}
		foreach(trap in getentarray("pendulum_buy_trigger", "targetname"))
		{
			trap triggerenable(0);
		}
		foreach(trap in getentarray("use_trap_chain", "targetname"))
		{
			trap triggerenable(0);
		}
		foreach(trap in struct::get_array("s_onswitch_unitrigger", "script_label"))
		{
			zm_unitrigger::unregister_unitrigger(trap);
		}
		level flag::set("using_mutator_settings");
		return;
	}
	ERROR: Exception occured: Stack empty.
}

/*
	Name: function_7f0e83d
	Namespace: namespace_1635148
	Checksum: 0x424F4353
	Offset: 0x6438
	Size: 0x120
	Parameters: 1
	Flags: Private
	Line Number: 1371
*/
function private function_7f0e83d(dvar_value)
{
	if(dvar_value == 2)
	{
		level.var_842626f0 = 0;
		level flag::set("using_mutator_settings");
		wait(12);
		level._random_perk_machine_perk_list = [];
		wait(0.05);
		var_d952ddb7 = getentarray("zombie_vending", "targetname");
		if(var_d952ddb7.size > 1)
		{
			foreach(var_e3955304 in var_d952ddb7)
			{
				var_e3955304 thread function_874b5971();
			}
		}
	}
}

/*
	Name: function_874b5971
	Namespace: namespace_1635148
	Checksum: 0x424F4353
	Offset: 0x6560
	Size: 0xE0
	Parameters: 0
	Flags: Private
	Line Number: 1401
*/
function private function_874b5971()
{
	if(isdefined(self.machine))
	{
		self.machine.s_fxloc delete();
		self.clip connectpaths();
		self.clip delete();
		self.bump delete();
		self.machine delete();
		self triggerenable(0);
	}
	level._custom_perks = array::remove_index(level._custom_perks, self.script_noteworthy, 1);
}

/*
	Name: function_6742a62
	Namespace: namespace_1635148
	Checksum: 0x424F4353
	Offset: 0x6648
	Size: 0x100
	Parameters: 1
	Flags: Private
	Line Number: 1425
*/
function private function_6742a62(dvar_value)
{
	if(dvar_value == 2)
	{
		wait(0.05);
		level flag::set("using_mutator_settings");
		wait(5);
		level notify("machine_think");
		foreach(machine in getentarray("perk_random_machine", "targetname"))
		{
			machine thread zm_perk_random::set_perk_random_machine_state("away");
		}
	}
}

/*
	Name: function_a476b02a
	Namespace: namespace_1635148
	Checksum: 0x424F4353
	Offset: 0x6750
	Size: 0x58
	Parameters: 1
	Flags: Private
	Line Number: 1450
*/
function private function_a476b02a(dvar_value)
{
	if(dvar_value == 2)
	{
		level flag::set("using_mutator_settings");
		wait(10);
		level thread function_3b8ebb2("specialty_armorvest");
	}
}

/*
	Name: disable_quickrevive
	Namespace: namespace_1635148
	Checksum: 0x424F4353
	Offset: 0x67B0
	Size: 0x58
	Parameters: 1
	Flags: Private
	Line Number: 1470
*/
function private disable_quickrevive(dvar_value)
{
	if(dvar_value == 2)
	{
		level flag::set("using_mutator_settings");
		wait(10);
		level thread function_3b8ebb2("specialty_quickrevive");
	}
}

/*
	Name: function_b576d858
	Namespace: namespace_1635148
	Checksum: 0x424F4353
	Offset: 0x6810
	Size: 0x58
	Parameters: 1
	Flags: Private
	Line Number: 1490
*/
function private function_b576d858(dvar_value)
{
	if(dvar_value == 2)
	{
		level flag::set("using_mutator_settings");
		wait(10);
		level thread function_3b8ebb2("specialty_fastreload");
	}
}

/*
	Name: function_30fc5aa8
	Namespace: namespace_1635148
	Checksum: 0x424F4353
	Offset: 0x6870
	Size: 0x58
	Parameters: 1
	Flags: Private
	Line Number: 1510
*/
function private function_30fc5aa8(dvar_value)
{
	if(dvar_value == 2)
	{
		level flag::set("using_mutator_settings");
		wait(10);
		level thread function_3b8ebb2("specialty_doubletap2");
	}
}

/*
	Name: function_7485ffdf
	Namespace: namespace_1635148
	Checksum: 0x424F4353
	Offset: 0x68D0
	Size: 0x58
	Parameters: 1
	Flags: Private
	Line Number: 1530
*/
function private function_7485ffdf(dvar_value)
{
	if(dvar_value == 2)
	{
		level flag::set("using_mutator_settings");
		wait(10);
		level thread function_3b8ebb2("specialty_staminup");
	}
}

/*
	Name: function_51f03993
	Namespace: namespace_1635148
	Checksum: 0x424F4353
	Offset: 0x6930
	Size: 0x58
	Parameters: 1
	Flags: Private
	Line Number: 1550
*/
function private function_51f03993(dvar_value)
{
	if(dvar_value == 2)
	{
		level flag::set("using_mutator_settings");
		wait(10);
		level thread function_3b8ebb2("specialty_additionalprimaryweapon");
		return;
	}
	.var_0 = undefined;
}

/*
	Name: disable_deadshot
	Namespace: namespace_1635148
	Checksum: 0x424F4353
	Offset: 0x6990
	Size: 0x58
	Parameters: 1
	Flags: Private
	Line Number: 1572
*/
function private disable_deadshot(dvar_value)
{
	if(dvar_value == 2)
	{
		level flag::set("using_mutator_settings");
		wait(10);
		level thread function_3b8ebb2("specialty_deadshot");
	}
}

/*
	Name: function_51a8f0e8
	Namespace: namespace_1635148
	Checksum: 0x424F4353
	Offset: 0x69F0
	Size: 0x58
	Parameters: 1
	Flags: Private
	Line Number: 1592
*/
function private function_51a8f0e8(dvar_value)
{
	if(dvar_value == 2)
	{
		level flag::set("using_mutator_settings");
		wait(10);
		level thread function_3b8ebb2("specialty_widowswine");
	}
}

/*
	Name: function_77c02f38
	Namespace: namespace_1635148
	Checksum: 0x424F4353
	Offset: 0x6A50
	Size: 0x58
	Parameters: 1
	Flags: Private
	Line Number: 1612
*/
function private function_77c02f38(dvar_value)
{
	if(dvar_value == 2)
	{
		level flag::set("using_mutator_settings");
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
	Offset: 0x6AB0
	Size: 0x58
	Parameters: 1
	Flags: Private
	Line Number: 1634
*/
function private function_93754032(dvar_value)
{
	if(dvar_value == 2)
	{
		level flag::set("using_mutator_settings");
		wait(10);
		level thread function_3b8ebb2("specialty_phdflopper");
		return;
	}
	ERROR: Exception occured: Stack empty.
}

/*
	Name: function_d810e879
	Namespace: namespace_1635148
	Checksum: 0x424F4353
	Offset: 0x6B10
	Size: 0x58
	Parameters: 1
	Flags: Private
	Line Number: 1656
*/
function private function_d810e879(dvar_value)
{
	if(dvar_value == 2)
	{
		level flag::set("using_mutator_settings");
		wait(10);
		level thread function_3b8ebb2("specialty_tracker");
		return;
	}
	~;
	ERROR: Exception occured: Stack empty.
}

/*
	Name: function_b20b8e2f
	Namespace: namespace_1635148
	Checksum: 0x424F4353
	Offset: 0x6B70
	Size: 0x58
	Parameters: 1
	Flags: Private
	Line Number: 1679
*/
function private function_b20b8e2f(dvar_value)
{
	if(dvar_value == 2)
	{
		level flag::set("using_mutator_settings");
		wait(10);
		level thread function_3b8ebb2("specialty_immunetriggerbetty");
	}
}

/*
	Name: function_6f7b74ec
	Namespace: namespace_1635148
	Checksum: 0x424F4353
	Offset: 0x6BD0
	Size: 0x58
	Parameters: 1
	Flags: Private
	Line Number: 1699
*/
function private function_6f7b74ec(dvar_value)
{
	if(dvar_value == 2)
	{
		level flag::set("using_mutator_settings");
		wait(10);
		level thread function_3b8ebb2("specialty_extraammo");
	}
}

/*
	Name: function_e2e4bd74
	Namespace: namespace_1635148
	Checksum: 0x424F4353
	Offset: 0x6C30
	Size: 0x58
	Parameters: 1
	Flags: Private
	Line Number: 1719
*/
function private function_e2e4bd74(dvar_value)
{
	if(dvar_value == 2)
	{
		level flag::set("using_mutator_settings");
		wait(10);
		level thread function_3b8ebb2("specialty_immunetriggershock");
	}
}

/*
	Name: function_3b8ebb2
	Namespace: namespace_1635148
	Checksum: 0x424F4353
	Offset: 0x6C90
	Size: 0x58
	Parameters: 1
	Flags: None
	Line Number: 1739
*/
function function_3b8ebb2(perk_name)
{
	for(;;)
	{
		level._custom_perks = array::remove_index(level._custom_perks, perk_name, 1);
		zm_perks::perk_machine_removal(perk_name);
		wait(2);
	}
	return;
	ERROR: Exception occured: Stack empty.
}

/*
	Name: function_8c94e755
	Namespace: namespace_1635148
	Checksum: 0x424F4353
	Offset: 0x6CF0
	Size: 0x60
	Parameters: 1
	Flags: Private
	Line Number: 1761
*/
function private function_8c94e755(dvar_value)
{
	wait(2);
	if(dvar_value == 2)
	{
		level flag::set("using_mutator_settings");
		level flag::clear("zombie_drop_powerups");
	}
}

/*
	Name: function_19dfc39
	Namespace: namespace_1635148
	Checksum: 0x424F4353
	Offset: 0x6D58
	Size: 0xD8
	Parameters: 1
	Flags: Private
	Line Number: 1781
*/
function private function_19dfc39(dvar_value)
{
	wait(2);
	zm_powerups::powerup_remove_from_regular_drops("random_weapon");
	zm_powerups::powerup_remove_from_regular_drops("fast_feet");
	zm_powerups::powerup_remove_from_regular_drops("free_packapunch");
	if(dvar_value == 2)
	{
		level flag::set("using_mutator_settings");
		for(;;)
		{
			zm_powerups::include_zombie_powerup("random_weapon");
			zm_powerups::include_zombie_powerup("fast_feet");
			zm_powerups::include_zombie_powerup("free_packapunch");
			wait(1);
		}
		return;
	}
}

/*
	Name: function_2ff03255
	Namespace: namespace_1635148
	Checksum: 0x424F4353
	Offset: 0x6E38
	Size: 0x58
	Parameters: 1
	Flags: Private
	Line Number: 1811
*/
function private function_2ff03255(dvar_value)
{
	wait(2);
	if(dvar_value == 2)
	{
		level.var_147d7517["xp_drop"] = 0;
		level flag::set("using_mutator_settings");
	}
}

/*
	Name: function_dced484c
	Namespace: namespace_1635148
	Checksum: 0x424F4353
	Offset: 0x6E98
	Size: 0x58
	Parameters: 1
	Flags: Private
	Line Number: 1831
*/
function private function_dced484c(dvar_value)
{
	wait(2);
	if(dvar_value == 2)
	{
		level.var_147d7517["double_points"] = 0;
		level flag::set("using_mutator_settings");
	}
}

/*
	Name: function_40d379e
	Namespace: namespace_1635148
	Checksum: 0x424F4353
	Offset: 0x6EF8
	Size: 0x58
	Parameters: 1
	Flags: Private
	Line Number: 1851
*/
function private function_40d379e(dvar_value)
{
	wait(2);
	if(dvar_value == 2)
	{
		level.var_147d7517["carpenter"] = 0;
		level flag::set("using_mutator_settings");
	}
}

/*
	Name: function_e485a83a
	Namespace: namespace_1635148
	Checksum: 0x424F4353
	Offset: 0x6F58
	Size: 0x58
	Parameters: 1
	Flags: Private
	Line Number: 1871
*/
function private function_e485a83a(dvar_value)
{
	wait(2);
	if(dvar_value == 2)
	{
		level.var_147d7517["bonus_points_team"] = 0;
		level flag::set("using_mutator_settings");
		return;
	}
	ERROR: Exception occured: Stack empty.
}

/*
	Name: function_428816c7
	Namespace: namespace_1635148
	Checksum: 0x424F4353
	Offset: 0x6FB8
	Size: 0x58
	Parameters: 1
	Flags: Private
	Line Number: 1893
*/
function private function_428816c7(dvar_value)
{
	wait(2);
	if(dvar_value == 2)
	{
		level.var_147d7517["fire_sale"] = 0;
		level flag::set("using_mutator_settings");
		return;
	}
	ERROR: Exception occured: Stack empty.
}

/*
	Name: function_5ff53437
	Namespace: namespace_1635148
	Checksum: 0x424F4353
	Offset: 0x7018
	Size: 0x58
	Parameters: 1
	Flags: Private
	Line Number: 1915
*/
function private function_5ff53437(dvar_value)
{
	wait(2);
	if(dvar_value == 2)
	{
		level.var_147d7517["insta_kill"] = 0;
		level flag::set("using_mutator_settings");
	}
}

/*
	Name: function_cca7fa66
	Namespace: namespace_1635148
	Checksum: 0x424F4353
	Offset: 0x7078
	Size: 0x58
	Parameters: 1
	Flags: Private
	Line Number: 1935
*/
function private function_cca7fa66(dvar_value)
{
	wait(2);
	if(dvar_value == 2)
	{
		level.var_147d7517["full_ammo"] = 0;
		level flag::set("using_mutator_settings");
		return;
	}
	level.var_147d7517["full_ammo"]++;
}

/*
	Name: function_549245ed
	Namespace: namespace_1635148
	Checksum: 0x424F4353
	Offset: 0x70D8
	Size: 0x58
	Parameters: 1
	Flags: Private
	Line Number: 1957
*/
function private function_549245ed(dvar_value)
{
	wait(2);
	if(dvar_value == 2)
	{
		level.var_147d7517["nuke"] = 0;
		level flag::set("using_mutator_settings");
	}
}

/*
	Name: function_5a6a815f
	Namespace: namespace_1635148
	Checksum: 0x424F4353
	Offset: 0x7138
	Size: 0x58
	Parameters: 1
	Flags: Private
	Line Number: 1977
*/
function private function_5a6a815f(dvar_value)
{
	wait(2);
	if(dvar_value == 2)
	{
		level.var_147d7517["minigun"] = 0;
		level flag::set("using_mutator_settings");
	}
}

/*
	Name: function_40b5d6c8
	Namespace: namespace_1635148
	Checksum: 0x424F4353
	Offset: 0x7198
	Size: 0x68
	Parameters: 1
	Flags: Private
	Line Number: 1997
*/
function private function_40b5d6c8(dvar_value)
{
	wait(2);
	if(dvar_value == 2)
	{
		level flag::set("using_mutator_settings");
		for(;;)
		{
			wait(5);
			level.zombie_powerups["zombie_blood"].func_should_drop_with_regular_powerups = 0;
		}
		return;
	}
	ERROR: Exception occured: Stack empty.
	waittillframeend;
}

/*
	Name: function_9c404bf7
	Namespace: namespace_1635148
	Checksum: 0x424F4353
	Offset: 0x7208
	Size: 0x40
	Parameters: 1
	Flags: Private
	Line Number: 2024
*/
function private function_9c404bf7(dvar_value)
{
	if(dvar_value == 2)
	{
		level flag::set("using_mutator_settings");
		level.var_f7494eda = 0;
	}
}

/*
	Name: function_6be9a909
	Namespace: namespace_1635148
	Checksum: 0x424F4353
	Offset: 0x7250
	Size: 0x100
	Parameters: 1
	Flags: Private
	Line Number: 2043
*/
function private function_6be9a909(dvar_value)
{
	if(dvar_value == 2)
	{
		level flag::set("using_mutator_settings");
		level.mechz_rounds_enabled = 0;
		level.napalmZombiesEnabled = 0;
		level.sonicZombiesEnabled = 0;
		spawners = getent("actor_spawner_zm_theater_quad", "classname");
		spawners delete();
		wait(5);
		level.var_29b69441 = 1;
		level flag::wait_till("power_on");
		level flag::wait_till("perk_bought");
		wait(2);
		level.next_monkey_round = 9999;
	}
}

/*
	Name: function_6299d599
	Namespace: namespace_1635148
	Checksum: 0x424F4353
	Offset: 0x7358
	Size: 0x50
	Parameters: 1
	Flags: Private
	Line Number: 2072
*/
function private function_6299d599(dvar_value)
{
	if(dvar_value >= 2)
	{
		level flag::set("using_mutator_settings");
		level.var_affed9f4["zombie_max"] = dvar_value;
	}
}

/*
	Name: function_2bfbc731
	Namespace: namespace_1635148
	Checksum: 0x424F4353
	Offset: 0x73B0
	Size: 0x190
	Parameters: 1
	Flags: Private
	Line Number: 2091
*/
function private function_2bfbc731(dvar_value)
{
	wait(0.05);
	if(dvar_value == 2)
	{
		level flag::set("using_mutator_settings");
		level.dogs_enabled = 0;
		spawners = getent("actor_spawner_zm_theater_quad", "classname");
		spawners delete();
		spawners = getent("actor_spawner_zm_moon_quad", "classname");
		spawners delete();
		wait(5);
		level.n_next_raps_round = 9999;
		level.var_3013498 = 9999;
		level.var_a78effc7 = 9999;
		level.next_wasp_round = 9999;
		level.next_dog_round = 9999;
		level flag::wait_till("power_on");
		level.n_next_raps_round = 9999;
		level.var_3013498 = 9999;
		level.var_a78effc7 = 9999;
		level.next_wasp_round = 9999;
		level.next_dog_round = 9999;
		level flag::wait_till("perk_bought");
		wait(2);
		level.next_monkey_round = 9999;
	}
}

/*
	Name: theater_ignore_spawner
	Namespace: namespace_1635148
	Checksum: 0x424F4353
	Offset: 0x7548
	Size: 0x30
	Parameters: 1
	Flags: None
	Line Number: 2130
*/
function theater_ignore_spawner(spawner)
{
	if(spawner.script_noteworthy == "quad_zombie_spawner")
	{
		return 1;
	}
	return 0;
}

/*
	Name: function_417a0316
	Namespace: namespace_1635148
	Checksum: 0x424F4353
	Offset: 0x7580
	Size: 0x88
	Parameters: 1
	Flags: None
	Line Number: 2149
*/
function function_417a0316(dvar_value)
{
	level flag::init("allow_elemental_zombies");
	wait(0.05);
	if(dvar_value == 2)
	{
		wait(2);
		level flag::set("allow_elemental_zombies");
		level flag::set("using_mutator_settings");
	}
}

/*
	Name: function_5eed7e2c
	Namespace: namespace_1635148
	Checksum: 0x424F4353
	Offset: 0x7610
	Size: 0x348
	Parameters: 1
	Flags: None
	Line Number: 2171
*/
function function_5eed7e2c(dvar_value)
{
	level flag::init("allow_gungame");
	wait(0.05);
	if(dvar_value == 2)
	{
		level flag::set("allow_gungame");
		level flag::set("using_mutator_settings");
		level.bgb_in_use = 0;
		level.var_919b0320 = 1;
		level.var_fd6c66c2 = 0;
		var_9d8064ad = getentarray("bgb_machine_use", "targetname");
		foreach(bgb in var_9d8064ad)
		{
			if(isdefined(bgb.unitrigger_stub))
			{
				bgb.unitrigger_stub.og_origin = bgb.unitrigger_stub.origin;
				bgb.unitrigger_stub.origin = bgb.unitrigger_stub.origin - VectorScale((0, 0, 1), 1000);
				bgb.unitrigger_stub.var_8b8a66cc = spawn("trigger_radius_use", bgb.unitrigger_stub.og_origin, 0, 16, 16);
				bgb.unitrigger_stub.var_8b8a66cc setteamfortrigger("allies");
				bgb.unitrigger_stub.var_8b8a66cc setcursorhint("HINT_NOICON");
				bgb.unitrigger_stub.var_8b8a66cc sethintstring("Gobblegums are disabled");
				bgb SetZBarrierPieceState(3, "closed");
			}
		}
		wait(8);
		level.var_fd6c66c2 = 0;
		level thread function_3b8ebb2("specialty_additionalprimaryweapon");
		level thread function_3b8ebb2("specialty_extraammo");
		level.var_147d7517["minigun"] = 0;
		level.var_147d7517["fire_sale"] = 0;
		level.var_147d7517["full_ammo"] = 0;
	}
}

/*
	Name: function_5813855e
	Namespace: namespace_1635148
	Checksum: 0x424F4353
	Offset: 0x7960
	Size: 0x58
	Parameters: 1
	Flags: None
	Line Number: 2216
*/
function function_5813855e(dvar_value)
{
	if(!isdefined(level.var_90d57b96))
	{
		level.var_90d57b96 = int(dvar_value);
	}
	level.var_90d57b96 = int(dvar_value);
	return;
	ERROR: Exception occured: Stack empty.
}

/*
	Name: function_4c8f3a03
	Namespace: namespace_1635148
	Checksum: 0x424F4353
	Offset: 0x79C0
	Size: 0x58
	Parameters: 1
	Flags: None
	Line Number: 2237
*/
function function_4c8f3a03(dvar_value)
{
	if(!isdefined(level.var_9ff42471))
	{
		level.var_9ff42471 = int(dvar_value);
	}
	level.var_9ff42471 = int(dvar_value);
}

/*
	Name: function_37de54c1
	Namespace: namespace_1635148
	Checksum: 0x424F4353
	Offset: 0x7A20
	Size: 0x58
	Parameters: 1
	Flags: None
	Line Number: 2256
*/
function function_37de54c1(dvar_value)
{
	if(!isdefined(level.var_b1cf1e73))
	{
		level.var_b1cf1e73 = int(dvar_value);
	}
	level.var_b1cf1e73 = int(dvar_value);
}

/*
	Name: function_15e6b3ee
	Namespace: namespace_1635148
	Checksum: 0x424F4353
	Offset: 0x7A80
	Size: 0x70
	Parameters: 1
	Flags: Private
	Line Number: 2275
*/
function private function_15e6b3ee(attacker)
{
	if(isdefined(level.var_fb7be6ac) && isdefined(level.var_f345e88f) && isplayer(attacker))
	{
		level.var_f345e88f++;
		if(level.var_f345e88f >= level.var_fb7be6ac)
		{
			level notify("end_game");
		}
	}
}

/*
	Name: function_ff1d538e
	Namespace: namespace_1635148
	Checksum: 0x424F4353
	Offset: 0x7AF8
	Size: 0xE0
	Parameters: 15
	Flags: Private
	Line Number: 2297
*/
function private function_ff1d538e(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, psoffsettime, damagefromunderneath, modelindex, partname, vsurfacenormal)
{
	if(isdefined(level.var_fb7be6ac) && isdefined(level.var_f345e88f) && isplayer(eattacker))
	{
		level.var_f345e88f++;
		if(level.var_f345e88f >= level.var_fb7be6ac)
		{
			level notify("end_game");
		}
	}
}

/*
	Name: function_ab963c2c
	Namespace: namespace_1635148
	Checksum: 0x424F4353
	Offset: 0x7BE0
	Size: 0x4
	Parameters: 0
	Flags: Private
	Line Number: 2319
*/
function private function_ab963c2c()
{
}

