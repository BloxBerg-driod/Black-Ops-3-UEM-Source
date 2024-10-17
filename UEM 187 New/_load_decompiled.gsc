#include scripts\codescripts\struct;
#include scripts\lilrobot\_inspectable_weapons;
#include scripts\shared\_oob;
#include scripts\shared\abilities\_ability_player;
#include scripts\shared\ai\zombie_utility;
#include scripts\shared\ai_shared;
#include scripts\shared\archetype_shared\archetype_shared;
#include scripts\shared\array_shared;
#include scripts\shared\audio_shared;
#include scripts\shared\callbacks_shared;
#include scripts\shared\clientfield_shared;
#include scripts\shared\demo_shared;
#include scripts\shared\exploder_shared;
#include scripts\shared\flag_shared;
#include scripts\shared\flagsys_shared;
#include scripts\shared\fx_shared;
#include scripts\shared\hud_message_shared;
#include scripts\shared\laststand_shared;
#include scripts\shared\load_shared;
#include scripts\shared\lui_shared;
#include scripts\shared\music_shared;
#include scripts\shared\scene_shared;
#include scripts\shared\serverfaceanim_shared;
#include scripts\shared\system_shared;
#include scripts\shared\turret_shared;
#include scripts\shared\util_shared;
#include scripts\shared\vehicle_shared;
#include scripts\shared\visionset_mgr_shared;
#include scripts\sphynx\_zm_gungame;
#include scripts\sphynx\_zm_waypoint_tag;
#include scripts\sphynx\_zm_zomb_wondering;
#include scripts\sphynx\ai\_zm_armored_zombies;
#include scripts\sphynx\commands\_zm_commands;
#include scripts\sphynx\commands\_zm_name_checker;
#include scripts\sphynx\equipment\_zm_deployment_station;
#include scripts\sphynx\leveling\_zm_daily_challenges;
#include scripts\sphynx\leveling\_zm_sphynx_leveling;
#include scripts\sphynx\perks\_zm_perk_bandolier_bandit;
#include scripts\sphynx\perks\_zm_perk_death_perception;
#include scripts\sphynx\perks\_zm_perk_frost_brew;
#include scripts\sphynx\perks\_zm_perk_real_steal;
#include scripts\sphynx\powerups\_zm_powerup_xp;
#include scripts\sphynx\weapons\_zm_weap_changes;
#include scripts\sphynx\weapons\_zm_weap_crossbow;
#include scripts\sphynx\weapons\_zm_weap_melee_special_damage;
#include scripts\zm\_art;
#include scripts\zm\_callbacks;
#include scripts\zm\_destructible;
#include scripts\zm\_util;
#include scripts\zm\_zm;
#include scripts\zm\_zm_audio;
#include scripts\zm\_zm_behavior;
#include scripts\zm\_zm_blockers;
#include scripts\zm\_zm_bot;
#include scripts\zm\_zm_clone;
#include scripts\zm\_zm_devgui;
#include scripts\zm\_zm_hud_settings;
#include scripts\zm\_zm_laststand;
#include scripts\zm\_zm_magicbox;
#include scripts\zm\_zm_mutators;
#include scripts\zm\_zm_perk_additionalprimaryweapon;
#include scripts\zm\_zm_perk_deadshot;
#include scripts\zm\_zm_perk_doubletap2;
#include scripts\zm\_zm_perk_electric_cherry_uem;
#include scripts\zm\_zm_perk_juggernaut;
#include scripts\zm\_zm_perk_phdflopper_uem;
#include scripts\zm\_zm_perk_quick_revive;
#include scripts\zm\_zm_perk_random_uem;
#include scripts\zm\_zm_perk_sleight_of_hand;
#include scripts\zm\_zm_perk_staminup;
#include scripts\zm\_zm_perks;
#include scripts\zm\_zm_playerhealth;
#include scripts\zm\_zm_power;
#include scripts\zm\_zm_powerup_bonus_points_team;
#include scripts\zm\_zm_powerups;
#include scripts\zm\_zm_score;
#include scripts\zm\_zm_stats;
#include scripts\zm\_zm_traps;
#include scripts\zm\_zm_unitrigger;
#include scripts\zm\_zm_utility;
#include scripts\zm\_zm_weapon_upgrade_system;
#include scripts\zm\_zm_weapons;
#include scripts\zm\_zm_zombies_ultimate_hud;
#include scripts\zm\_zm_zonemgr;
#include scripts\zm\bgbs\_zm_bgb_locksmith;
#include scripts\zm\bgbs\_zm_bgb_lucky_loadout;
#include scripts\zm\gametypes\_clientids;
#include scripts\zm\gametypes\_scoreboard;
#include scripts\zm\gametypes\_serversettings;
#include scripts\zm\gametypes\_shellshock;
#include scripts\zm\gametypes\_spawnlogic;
#include scripts\zm\gametypes\_spectating;
#include scripts\zm\gametypes\_weaponobjects;
#include scripts\zm\zm_giant_cleanup_mgr;

#namespace load;

/*
	Name: ignore_systems
	Namespace: load
	Checksum: 0x424F4353
	Offset: 0x2268
	Size: 0x4D0
	Parameters: 0
	Flags: AutoExec
	Line Number: 107
*/
function autoexec ignore_systems()
{
	system::ignore("zm_powerup_weapon_minigun");
	system::ignore("zm_perk_electric_cherry");
	system::ignore("zm_perk_phdflopper");
	system::ignore("zm_perk_tombstone");
	system::ignore("zm_perk_vulture_aid");
	system::ignore("zm_perk_whoswho");
	system::ignore("phd_slider");
	system::ignore("zm_perk_flopper");
	system::ignore("zm_perk_elemental_pop");
	system::ignore("zm_perk_utility");
	system::ignore("zm_perk_commando");
	system::ignore("zm_perk_explosivedamage");
	system::ignore("zm_perk_extraammo");
	system::ignore("zm_perk_hardline");
	system::ignore("zm_perk_stoppingpower");
	system::ignore("bandolier_bandit");
	system::ignore("blaze_phase");
	system::ignore("dying_wish");
	system::ignore("ethereal_razor");
	system::ignore("phd_slider");
	system::ignore("stone_cold_stronghold");
	system::ignore("timeslip");
	system::ignore("victorious_tortoise");
	system::ignore("winters_wail");
	system::ignore("zombshell");
	system::ignore("blood_wolf_bite");
	system::ignore("zm_perk_wunderwonder2");
	system::ignore("zm_perk_banana_colada");
	system::ignore("zm_perk_bull_ice_blast");
	system::ignore("zm_perk_crusaders_ale");
	system::ignore("zm_perk_madgaz_moonshine");
	system::ignore("zm_perk_wunderfizz2");
	system::ignore("zm_perk_ffyl");
	system::ignore("zm_perk_icu");
	system::ignore("zm_perk_tactiquilla");
	system::ignore("zm_perk_snails_pace");
	system::ignore("zm_perk_cryo");
	system::ignore("zm_perk_atomic_liqueur");
	system::ignore("zm_perk_salvage_shake");
	system::ignore("zm_perk_wind");
	system::ignore("zm_perk_directionalfire");
	system::ignore("zm_perk_combat_efficiency");
	system::ignore("zm_perk_chugabud");
	system::ignore("zm_perk_flopper");
	system::ignore("zm_perk_random_new");
	system::ignore("zm_perk_dying_wish");
	system::ignore("zm_perk_regenammo");
	system::ignore("zm_perk_tortoise");
	system::ignore("zm_perk_random");
	system::ignore("zm_perk_trailblazers");
	system::ignore("zm_h1_hud");
	return;
	ERROR: Exception occured: Stack empty.
	ERROR: Exception occured: Stack empty.
}

/*
	Name: main
	Namespace: load
	Checksum: 0x424F4353
	Offset: 0x2740
	Size: 0x1AF0
	Parameters: 0
	Flags: None
	Line Number: 175
*/
function main()
{
	level thread custom_add_weapons();
	level thread function_b276244f();
	level thread function_2c470689();
	namespace_917c15bb::function_f3798296(getweapon("ray_gun"), 4.33);
	namespace_917c15bb::function_f3798296(getweapon("ray_gun_upgraded"), 4.33);
	namespace_917c15bb::function_f3798296(getweapon("shotgun_fullauto"), 4.33);
	namespace_917c15bb::function_f3798296(getweapon("shotgun_fullauto_upgraded"), 4.33);
	namespace_917c15bb::function_f3798296(getweapon("shotgun_pump"), 4);
	namespace_917c15bb::function_f3798296(getweapon("shotgun_pump_upgraded"), 4);
	namespace_917c15bb::function_f3798296(getweapon("shotgun_precision"), 4);
	namespace_917c15bb::function_f3798296(getweapon("shotgun_precision_upgraded"), 4);
	namespace_917c15bb::function_f3798296(getweapon("shotgun_semiauto"), 4);
	namespace_917c15bb::function_f3798296(getweapon("shotgun_semiauto_upgraded"), 4);
	namespace_917c15bb::function_f3798296(getweapon("ar_accurate"), 4.33);
	namespace_917c15bb::function_f3798296(getweapon("ar_accurate_upgraded"), 4.33);
	namespace_917c15bb::function_f3798296(getweapon("pistol_energy"), 3.33);
	namespace_917c15bb::function_f3798296(getweapon("pistol_energy_upgraded"), 3.33);
	namespace_917c15bb::function_f3798296(getweapon("smg_longrange"), 4.33);
	namespace_917c15bb::function_f3798296(getweapon("smg_longrange_upgraded"), 4.33);
	namespace_917c15bb::function_f3798296(getweapon("ar_standard"), 4);
	namespace_917c15bb::function_f3798296(getweapon("ar_standard_upgraded"), 4);
	namespace_917c15bb::function_f3798296(getweapon("ar_m16"), 4);
	namespace_917c15bb::function_f3798296(getweapon("ar_m16_upgraded"), 4);
	namespace_917c15bb::function_f3798296(getweapon("ar_an94"), 4);
	namespace_917c15bb::function_f3798296(getweapon("ar_an94_upgraded"), 4);
	namespace_917c15bb::function_f3798296(getweapon("ar_fastburst"), 4);
	namespace_917c15bb::function_f3798296(getweapon("ar_fastburst_upgraded"), 4);
	namespace_917c15bb::function_f3798296(getweapon("ar_galil"), 4);
	namespace_917c15bb::function_f3798296(getweapon("ar_galil_upgraded"), 4);
	namespace_917c15bb::function_f3798296(getweapon("ar_stg44"), 4);
	namespace_917c15bb::function_f3798296(getweapon("ar_stg44_upgraded"), 4);
	namespace_917c15bb::function_f3798296(getweapon("pistol_standard"), 4.66);
	namespace_917c15bb::function_f3798296(getweapon("pistol_standard_upgraded"), 3.83);
	namespace_917c15bb::function_f3798296(getweapon("pistol_standardlh_upgraded"), 3.83);
	namespace_917c15bb::function_f3798296(getweapon("shotgun_energy"), 4.66);
	namespace_917c15bb::function_f3798296(getweapon("shotgun_energy_upgraded"), 3.83);
	namespace_917c15bb::function_f3798296(getweapon("shotgun_energy_ldw_upgraded"), 3.83);
	namespace_917c15bb::function_f3798296(getweapon("ar_marksman"), 4.33);
	namespace_917c15bb::function_f3798296(getweapon("ar_marksman_upgraded"), 4.33);
	namespace_917c15bb::function_f3798296(getweapon("pistol_fullauto"), 4.66);
	namespace_917c15bb::function_f3798296(getweapon("pistol_fullauto_upgraded"), 4.33);
	namespace_917c15bb::function_f3798296(getweapon("pistol_fullauto_ldw_upgraded"), 4.33);
	namespace_917c15bb::function_f3798296(getweapon("sniper_fastbolt"), 5.13);
	namespace_917c15bb::function_f3798296(getweapon("sniper_fastbolt_upgraded"), 5.13);
	namespace_917c15bb::function_f3798296(getweapon("sniper_powerbolt"), 3.5);
	namespace_917c15bb::function_f3798296(getweapon("sniper_powerbolt_upgraded"), 3.5);
	namespace_917c15bb::function_f3798296(getweapon("sniper_fastsemi"), 3.5);
	namespace_917c15bb::function_f3798296(getweapon("sniper_fastsemi_upgraded"), 3.5);
	namespace_917c15bb::function_f3798296(getweapon("ar_longburst"), 4.33);
	namespace_917c15bb::function_f3798296(getweapon("ar_longburst_upgraded"), 4.33);
	namespace_917c15bb::function_f3798296(getweapon("smg_capacity"), 4.66);
	namespace_917c15bb::function_f3798296(getweapon("smg_capacity_upgraded"), 4.66);
	namespace_917c15bb::function_f3798296(getweapon("smg_burst"), 5.16);
	namespace_917c15bb::function_f3798296(getweapon("smg_burst_upgraded"), 5.16);
	namespace_917c15bb::function_f3798296(getweapon("smg_thompson"), 4.33);
	namespace_917c15bb::function_f3798296(getweapon("smg_thompson_upgraded"), 4.33);
	namespace_917c15bb::function_f3798296(getweapon("smg_mp40"), 4);
	namespace_917c15bb::function_f3798296(getweapon("smg_mp40_upgraded"), 4);
	namespace_917c15bb::function_f3798296(getweapon("lmg_heavy"), 5.5);
	namespace_917c15bb::function_f3798296(getweapon("lmg_heavy_upgraded"), 5.5);
	namespace_917c15bb::function_f3798296(getweapon("lmg_rpk"), 5.5);
	namespace_917c15bb::function_f3798296(getweapon("lmg_rpk_upgraded"), 5.5);
	namespace_917c15bb::function_f3798296(getweapon("lmg_mg08"), 5.5);
	namespace_917c15bb::function_f3798296(getweapon("lmg_mg08_upgraded"), 5.5);
	namespace_917c15bb::function_f3798296(getweapon("launcher_standard"), 4);
	namespace_917c15bb::function_f3798296(getweapon("launcher_standard_upgraded"), 4);
	namespace_917c15bb::function_f3798296(getweapon("ar_damage"), 4);
	namespace_917c15bb::function_f3798296(getweapon("ar_damage_upgraded"), 4.33);
	namespace_917c15bb::function_f3798296(getweapon("smg_ppsh"), 4.1);
	namespace_917c15bb::function_f3798296(getweapon("smg_ppsh_upgraded"), 4.1);
	namespace_917c15bb::function_f3798296(getweapon("smg_fastfire"), 4.66);
	namespace_917c15bb::function_f3798296(getweapon("smg_fastfire_upgraded"), 4.66);
	namespace_917c15bb::function_f3798296(getweapon("smg_standard"), 3.5);
	namespace_917c15bb::function_f3798296(getweapon("smg_standard_upgraded"), 3.5);
	namespace_917c15bb::function_f3798296(getweapon("smg_versatile"), 3.53);
	namespace_917c15bb::function_f3798296(getweapon("smg_versatile_upgraded"), 3.53);
	namespace_917c15bb::function_f3798296(getweapon("pistol_burst"), 3.33);
	namespace_917c15bb::function_f3798296(getweapon("pistol_burst_upgraded"), 3.33);
	namespace_917c15bb::function_f3798296(getweapon("ar_cqb"), 6);
	namespace_917c15bb::function_f3798296(getweapon("ar_cqb_upgraded"), 6);
	namespace_917c15bb::function_f3798296(getweapon("smg_mp40_1940"), 4.66);
	namespace_917c15bb::function_f3798296(getweapon("smg_mp40_1940_upgraded"), 4.66);
	namespace_917c15bb::function_f3798296(getweapon("lmg_slowfire"), 10);
	namespace_917c15bb::function_f3798296(getweapon("lmg_slowfire_upgraded"), 10);
	namespace_917c15bb::function_f3798296(getweapon("t9_gallo_raygun"), 9);
	namespace_917c15bb::function_f3798296(getweapon("t9_gallo_raygun_up"), 9);
	namespace_917c15bb::function_f3798296(getweapon("t9_crossbow_skull"), 7.1);
	namespace_917c15bb::function_f3798296(getweapon("t9_crossbow_skull_up"), 7.1);
	level.var_7f38ec2c = 0;
	switch(tolower(getdvarstring("mapname")))
	{
		case "zm_sumpf":
		{
			thread function_cc9df5b9((10485.6, 489.566, -660.875), (0, 0, 0));
			thread function_6536dcdc((10640.4, 669.7, -528.875), VectorScale((0, -1, 0), 155.116), (10128.4, 780.4, -660.875), VectorScale((0, -1, 0), 169.73), (10213.3, 877.135, -660.875), VectorScale((0, 1, 0), 37.36));
			break;
		}
	}
	level thread function_c3a3e63();
	zm_utility::register_tactical_grenade_for_level("octobomb");
	zm_utility::register_tactical_grenade_for_level("octobomb_upgraded");
	zm_utility::register_tactical_grenade_for_level("cymbal_monkey");
	zm_utility::register_tactical_grenade_for_level("cymbal_monkey_upgraded");
	setdvar("scr_firstGumFree", 0);
	zm::init();
	level.player_too_many_players_check = 0;
	level.do_randomized_zigzag_path = 1;
	array::thread_all(getentarray("weapon_karosel", "targetname"), &function_8aadf265);
	array::thread_all(getentarray("mxammo_trigger", "targetname"), &function_d9282b44);
	array::thread_all(getentarray("perka", "targetname"), &function_5c46710d);
	if(level.additionalprimaryweapon_limit != 3)
	{
		level.additionalprimaryweapon_limit = 3;
	}
	if(isdefined(level.var_bedf286b))
	{
		level.var_d1784d71 = 0;
		level.var_bedf286b = 2;
	}
	setdvar("player_shallowWaterWadeScale", 0.75);
	setdvar("player_waistWaterWadeScale", 0.75);
	var_8612b812 = array(getweapon("bouncingbetty"), getweapon("claymore"), getweapon("t6_claymore"), getweapon("idgun_0"), getweapon("idgun_1"), getweapon("idgun_2"), getweapon("idgun_3"), getweapon("idgun_upgraded_0"), getweapon("idgun_upgraded_1"), getweapon("idgun_upgraded_2"), getweapon("idgun_upgraded_3"));
	foreach(weapon in var_8612b812)
	{
		if(isdefined(level.zombie_weapons[weapon]))
		{
			level.zombie_weapons[weapon].is_in_box = 0;
		}
	}
	switch(tolower(getdvarstring("mapname")))
	{
		case "zm_zod":
		{
			level.idgun_weapons[4] = getweapon("idgun_upgraded_0");
			level.idgun_weapons[5] = getweapon("idgun_upgraded_1");
			level.idgun_weapons[6] = getweapon("idgun_upgraded_2");
			level.idgun_weapons[7] = getweapon("idgun_upgraded_3");
			if(!isdefined(level.zombie_weapons["idgun_0"]))
			{
				level.zombie_weapons["idgun_0"].upgrade = getweapon("idgun_upgraded_0");
			}
			if(!isdefined(level.zombie_weapons["idgun_1"]))
			{
				level.zombie_weapons["idgun_1"].upgrade = getweapon("idgun_upgraded_1");
			}
			if(!isdefined(level.zombie_weapons["idgun_2"]))
			{
				level.zombie_weapons["idgun_2"].upgrade = getweapon("idgun_upgraded_2");
			}
			if(!isdefined(level.zombie_weapons["idgun_3"]))
			{
				level.zombie_weapons["idgun_3"].upgrade = getweapon("idgun_upgraded_3");
				break;
			}
		}
	}
	var_1a31d15 = array("specialty_armorvest", "specialty_quickrevive", "specialty_fastreload", "specialty_doubletap2", "specialty_staminup", "specialty_additionalprimaryweapon", "specialty_deadshot", "specialty_widowswine", "specialty_electriccherry", "specialty_phdflopper", "specialty_tracker", "specialty_immunetriggerbetty", "specialty_extraammo", "specialty_immunetriggershock");
	var_d952ddb7 = getentarray("zombie_vending", "targetname");
	if(var_d952ddb7.size > 1)
	{
		foreach(var_e3955304 in var_d952ddb7)
		{
			if(isdefined(var_e3955304.script_noteworthy) && !array::contains(var_1a31d15, var_e3955304.script_noteworthy))
			{
				if(isdefined(var_e3955304.machine))
				{
					var_e3955304.machine.s_fxloc delete();
					var_e3955304.clip connectpaths();
					var_e3955304.clip delete();
					var_e3955304.bump delete();
					var_e3955304.machine delete();
					var_e3955304 triggerenable(0);
				}
				level._custom_perks = array::remove_index(level._custom_perks, var_e3955304.script_noteworthy, 1);
			}
		}
	}
	level._loadStarted = 1;
	register_clientfields();
	level.aiTriggerSpawnFlags = getaitriggerflags();
	level.vehicleTriggerSpawnFlags = getvehicletriggerflags();
	level thread start_intro_screen_zm();
	setup_traversals();
	footsteps();
	system::wait_till("all");
	level thread art_review();
	level flagsys::set("load_main_complete");
	level.pack_a_punch_camo_index = 1;
	level.pack_a_punch_camo_index_number_variants = 1;
	level thread function_4cc8861a(32, 4);
	thread function_c0e61153();
	thread function_33d4c919();
	level thread function_f5928133();
	level thread function_2d6d3f14();
	level thread function_67347928();
	return;
	ERROR: Exception occured: Stack empty.
}

/*
	Name: function_67347928
	Namespace: load
	Checksum: 0x424F4353
	Offset: 0x4238
	Size: 0x290
	Parameters: 0
	Flags: None
	Line Number: 386
*/
function function_67347928()
{
	level waittill("all_players_connected");
	str_trig = spawn("trigger_radius", (0, 0, 0), 0, 16, 16);
	str_trig setinvisibletoall();
	function_b24346e3(str_trig, &"ZOMBIE_PERK_ADDITIONALPRIMARYWEAPON", 4000);
	function_b24346e3(str_trig, &"ZOMBIE_PERK_CHUGABUD", 2000);
	function_b24346e3(str_trig, &"ZOMBIE_PERK_DEADSHOT", 1500);
	function_b24346e3(str_trig, &"ZOMBIE_PERK_DIVETONUKE", 2000);
	function_b24346e3(str_trig, &"ZOMBIE_PERK_DOUBLETAP", 2000);
	function_b24346e3(str_trig, &"ZOMBIE_PERK_FASTRELOAD", 3000);
	function_b24346e3(str_trig, &"ZOMBIE_PERK_JUGGERNAUT", 2500);
	function_b24346e3(str_trig, &"ZOMBIE_PERK_MARATHON", 2000);
	function_b24346e3(str_trig, &"ZOMBIE_PERK_PACKAPUNCH", 5000);
	function_b24346e3(str_trig, &"ZOMBIE_PERK_PACKAPUNCH", 1000);
	function_b24346e3(str_trig, &"ZOMBIE_PERK_PACKAPUNCH_AAT", 2500);
	function_b24346e3(str_trig, &"ZOMBIE_PERK_PACKAPUNCH_AAT", 500);
	function_b24346e3(str_trig, &"ZOMBIE_PERK_QUICKREVIVE", 1500);
	function_b24346e3(str_trig, &"ZOMBIE_PERK_QUICKREVIVE", 500);
	function_b24346e3(str_trig, &"ZOMBIE_PERK_TOMBSTONE", 2000);
	function_b24346e3(str_trig, &"ZOMBIE_PERK_VULTURE", 3000);
	function_b24346e3(str_trig, &"ZOMBIE_PERK_WIDOWSWINE", 4000);
	str_trig delete();
	return;
	ERROR: Exception occured: Stack empty.
}

/*
	Name: function_b24346e3
	Namespace: load
	Checksum: 0x424F4353
	Offset: 0x44D0
	Size: 0x80
	Parameters: 3
	Flags: None
	Line Number: 423
*/
function function_b24346e3(str_trig, string, insert)
{
	if(!isdefined(insert))
	{
		insert = undefined;
	}
	if(!isdefined(insert))
	{
		str_trig sethintstring(string);
	}
	else
	{
		str_trig sethintstring(string, insert);
	}
	wait(0.05);
}

/*
	Name: function_6386b4b5
	Namespace: load
	Checksum: 0x424F4353
	Offset: 0x4558
	Size: 0x128
	Parameters: 2
	Flags: None
	Line Number: 450
*/
function function_6386b4b5(str_trigger, str_sound)
{
	if(!isdefined(str_trigger))
	{
		str_trigger = "audio_bump_trigger";
	}
	if(!isdefined(str_sound))
	{
		str_sound = "zmb_perks_bump_bottle";
	}
	wait(1);
	level notify("hash_38b7cb9f");
	wait(5);
	a_t_audio = getentarray(str_trigger, "targetname");
	foreach(t_audio_bump in a_t_audio)
	{
		if(t_audio_bump.script_sound === str_sound)
		{
			zm_perks::spare_change();
		}
	}
}

/*
	Name: function_8aadf265
	Namespace: load
	Checksum: 0x424F4353
	Offset: 0x4688
	Size: 0x20
	Parameters: 0
	Flags: None
	Line Number: 483
*/
function function_8aadf265()
{
	self delete();
}

/*
	Name: function_d9282b44
	Namespace: load
	Checksum: 0x424F4353
	Offset: 0x46B0
	Size: 0x20
	Parameters: 0
	Flags: None
	Line Number: 498
*/
function function_d9282b44()
{
	self delete();
	return;
}

/*
	Name: function_5c46710d
	Namespace: load
	Checksum: 0x424F4353
	Offset: 0x46D8
	Size: 0x20
	Parameters: 0
	Flags: None
	Line Number: 514
*/
function function_5c46710d()
{
	self delete();
	return;
}

/*
	Name: function_ee438c1e
	Namespace: load
	Checksum: 0x424F4353
	Offset: 0x4700
	Size: 0x38
	Parameters: 0
	Flags: None
	Line Number: 530
*/
function function_ee438c1e()
{
	self endon("disconnect");
	for(;;)
	{
		self waittill("hash_994d5e9e", name, bgb);
	}
}

/*
	Name: function_2d6d3f14
	Namespace: load
	Checksum: 0x424F4353
	Offset: 0x4740
	Size: 0x230
	Parameters: 0
	Flags: None
	Line Number: 549
*/
function function_2d6d3f14()
{
	wait(4);
	for(;;)
	{
		wait(5);
		level._random_perk_machine_perk_list = [];
		wait(0.05);
		perk_list = array("specialty_armorvest", "specialty_quickrevive", "specialty_fastreload", "specialty_doubletap2", "specialty_staminup", "specialty_additionalprimaryweapon", "specialty_deadshot", "specialty_widowswine", "specialty_electriccherry", "specialty_phdflopper", "specialty_tracker", "specialty_immunetriggerbetty", "specialty_extraammo", "specialty_immunetriggershock");
		foreach(perk in perk_list)
		{
			if(isdefined(level._custom_perks[perk]))
			{
				namespace_3b1d1e1f::include_perk_in_random_rotation(perk);
			}
		}
		var_cac83725 = array("bonfire_sale", "perk_slot", "empty_bottle", "thunderstorm", "invincible", "time_warp", "bottomless_clip", "infinite_ammo");
		foreach(powerup in var_cac83725)
		{
			zm_powerups::powerup_remove_from_regular_drops(powerup);
		}
	}
}

/*
	Name: function_9161feac
	Namespace: load
	Checksum: 0x424F4353
	Offset: 0x4978
	Size: 0x1B8
	Parameters: 0
	Flags: None
	Line Number: 583
*/
function function_9161feac()
{
	level.b_allow_idgun_pap = 1;
	level.idgun_weapons[5] = getweapon("idgun_upgraded_0");
	level.idgun_weapons[6] = getweapon("idgun_upgraded_1");
	level.idgun_weapons[7] = getweapon("idgun_upgraded_2");
	level.idgun_weapons[8] = getweapon("idgun_upgraded_3");
	if(level.script == "zm_tomb")
	{
		thread function_6811a318();
		level.chest_joker_custom_movement = &custom_joker_movement;
		level.pack_a_punch.move_out_func = &function_7c03764f;
		level.pack_a_punch.move_in_func = &function_924c2652;
		level.pack_a_punch.power_on_callback = &function_1c485da4;
	}
	if(level.script == "zm_moon")
	{
		thread function_4abfffd2();
		thread function_347f929f();
	}
	if(function_5e7a117f())
	{
		thread function_14512ced();
	}
}

/*
	Name: function_dfd3d160
	Namespace: load
	Checksum: 0x424F4353
	Offset: 0x4B38
	Size: 0x48
	Parameters: 0
	Flags: None
	Line Number: 619
*/
function function_dfd3d160()
{
	level waittill("hash_f938585a");
	var_426658d = addtestclient();
	wait(1);
	wait(1);
	wait(1);
}

/*
	Name: function_33d4c919
	Namespace: load
	Checksum: 0x424F4353
	Offset: 0x4B88
	Size: 0x78
	Parameters: 0
	Flags: None
	Line Number: 638
*/
function function_33d4c919()
{
	while(1)
	{
		level waittill("start_of_round");
		if(level.round_number < 12)
		{
			setdvar("r_maxSpotShadowUpdates", "12");
		}
		else
		{
			setdvar("r_maxSpotShadowUpdates", "8");
		}
	}
}

/*
	Name: footsteps
	Namespace: load
	Checksum: 0x424F4353
	Offset: 0x4C08
	Size: 0x240
	Parameters: 0
	Flags: None
	Line Number: 664
*/
function footsteps()
{
	if(isdefined(level.FX_exclude_footsteps) && level.FX_exclude_footsteps)
	{
		return;
	}
	zombie_utility::setFootstepEffect("asphalt", "_t6/bio/player/fx_footstep_dust");
	zombie_utility::setFootstepEffect("brick", "_t6/bio/player/fx_footstep_dust");
	zombie_utility::setFootstepEffect("carpet", "_t6/bio/player/fx_footstep_dust");
	zombie_utility::setFootstepEffect("cloth", "_t6/bio/player/fx_footstep_dust");
	zombie_utility::setFootstepEffect("concrete", "_t6/bio/player/fx_footstep_dust");
	zombie_utility::setFootstepEffect("dirt", "_t6/bio/player/fx_footstep_sand");
	zombie_utility::setFootstepEffect("foliage", "_t6/bio/player/fx_footstep_sand");
	zombie_utility::setFootstepEffect("gravel", "_t6/bio/player/fx_footstep_dust");
	zombie_utility::setFootstepEffect("grass", "_t6/bio/player/fx_footstep_dust");
	zombie_utility::setFootstepEffect("metal", "_t6/bio/player/fx_footstep_dust");
	zombie_utility::setFootstepEffect("mud", "_t6/bio/player/fx_footstep_mud");
	zombie_utility::setFootstepEffect("paper", "_t6/bio/player/fx_footstep_dust");
	zombie_utility::setFootstepEffect("plaster", "_t6/bio/player/fx_footstep_dust");
	zombie_utility::setFootstepEffect("rock", "_t6/bio/player/fx_footstep_dust");
	zombie_utility::setFootstepEffect("sand", "_t6/bio/player/fx_footstep_sand");
	zombie_utility::setFootstepEffect("water", "_t6/bio/player/fx_footstep_water");
	zombie_utility::setFootstepEffect("wood", "_t6/bio/player/fx_footstep_dust");
	return;
	~;
}

/*
	Name: setup_traversals
	Namespace: load
	Checksum: 0x424F4353
	Offset: 0x4E50
	Size: 0x8
	Parameters: 0
	Flags: None
	Line Number: 701
*/
function setup_traversals()
{
}

/*
	Name: start_intro_screen_zm
	Namespace: load
	Checksum: 0x424F4353
	Offset: 0x4E60
	Size: 0x98
	Parameters: 0
	Flags: None
	Line Number: 715
*/
function start_intro_screen_zm()
{
	players = getplayers();
	for(i = 0; i < players.size; i++)
	{
		players[i] lui::screen_fade_out(0, undefined);
		players[i] freezecontrols(1);
	}
	wait(1);
}

/*
	Name: register_clientfields
	Namespace: load
	Checksum: 0x424F4353
	Offset: 0x4F00
	Size: 0xC8
	Parameters: 0
	Flags: None
	Line Number: 736
*/
function register_clientfields()
{
	clientfield::register("allplayers", "zmbLastStand", 1, 1, "int");
	clientfield::register("clientuimodel", "zmhud.swordEnergy", 1, 7, "float");
	clientfield::register("clientuimodel", "zmhud.swordState", 1, 4, "int");
	clientfield::register("clientuimodel", "zmhud.swordChargeUpdate", 1, 1, "counter");
	return;
	ERROR: Exception occured: Stack empty.
}

/*
	Name: custom_add_weapons
	Namespace: load
	Checksum: 0x424F4353
	Offset: 0x4FD0
	Size: 0x80
	Parameters: 0
	Flags: None
	Line Number: 756
*/
function custom_add_weapons()
{
	zm_weapons::load_weapon_spec_from_table("gamedata/weapons/zm/zm_qol_mod_weapons.csv", 1);
	switch(tolower(getdvarstring("mapname")))
	{
		case "zm_zod":
		{
			zm_weapons::load_weapon_spec_from_table("gamedata/weapons/zm/zm_zod_qol_weapons.csv", 1);
			break;
		}
	}
}

/*
	Name: checkStringValid
	Namespace: load
	Checksum: 0x424F4353
	Offset: 0x5058
	Size: 0x28
	Parameters: 1
	Flags: None
	Line Number: 779
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
	Name: function_b276244f
	Namespace: load
	Checksum: 0x424F4353
	Offset: 0x5088
	Size: 0x148
	Parameters: 0
	Flags: None
	Line Number: 798
*/
function function_b276244f()
{
	index = 1;
	table = "gamedata/weapons/weapon_delete_from_box.csv";
	level.var_6849ec14 = [];
	for(row = tablelookuprow(table, index); isdefined(row); row = tablelookuprow(table, index))
	{
		weapon_name = checkStringValid(row[0]);
		var_5b7ff18 = checkStringValid(row[1]);
		struct = spawnstruct();
		struct.weapon_name = weapon_name;
		if(isdefined(var_5b7ff18))
		{
			struct.var_5b7ff18 = var_5b7ff18;
		}
		level.var_6849ec14[weapon_name] = struct;
		index++;
	}
	return;
	ERROR: Bad function call
}

/*
	Name: function_2c470689
	Namespace: load
	Checksum: 0x424F4353
	Offset: 0x51D8
	Size: 0x140
	Parameters: 0
	Flags: None
	Line Number: 830
*/
function function_2c470689()
{
	index = 1;
	table = "gamedata/weapons/weapon_uem_list.csv";
	level.var_7a0bbec5 = [];
	for(row = tablelookuprow(table, index); isdefined(row); row = tablelookuprow(table, index))
	{
		weapon_name = checkStringValid(row[0]);
		weapon_base = checkStringValid(row[1]);
		struct = spawnstruct();
		struct.weapon_name = weapon_name;
		struct.weapon_base = weapon_base;
		level.var_7a0bbec5[weapon_name] = struct;
		index++;
	}
}

/*
	Name: function_c3a3e63
	Namespace: load
	Checksum: 0x424F4353
	Offset: 0x5320
	Size: 0x650
	Parameters: 0
	Flags: Private
	Line Number: 857
*/
function private function_c3a3e63()
{
	if(!isdefined(level.var_a73d598a))
	{
		level.var_a73d598a = 0;
	}
	if(!isdefined(level.var_e7e4be0e))
	{
		level.var_e7e4be0e = 0;
	}
	var_1291a337 = struct::get_array("claymore_purchase", "targetname");
	if(var_1291a337.size > 1)
	{
		foreach(wallbuy in var_1291a337)
		{
			switch(wallbuy.zombie_weapon_upgrade)
			{
				case "bouncingbetty":
				{
					wallbuy movez(wallbuy.origin - VectorScale((0, 0, 1), 1000), 0.1);
					wallbuy.trigger_stub.origin = wallbuy.origin - VectorScale((0, 0, 1), 1000);
					wait(0.05);
					wallbuy struct::delete();
					break;
				}
			}
		}
	}
	wait(0.05);
	level flag::wait_till("initial_blackscreen_passed");
	while(!isdefined(level.var_6849ec14))
	{
		wait(0.05);
	}
	while(!isdefined(level.var_7a0bbec5))
	{
		wait(0.05);
	}
	foreach(weapon in level.var_7a0bbec5)
	{
		weapon = getweapon(weapon.weapon_base);
		level.zombie_weapons[weapon].is_in_box = 1;
	}
	if(!level flag::get("keep_map_weapons") && !function_b400349f())
	{
		foreach(weapon in getarraykeys(level.zombie_weapons))
		{
			if(isdefined(level.var_6849ec14[weapon.name]))
			{
				level.zombie_weapons[weapon].is_in_box = 0;
			}
		}
	}
	foreach(weapon in getarraykeys(level.zombie_weapons))
	{
		if(weapon.name == "idgun_0" || weapon.name == "idgun_1" || weapon.name == "idgun_2" || weapon.name == "idgun_3" || weapon.name == "idgun_upgraded_0" || weapon.name == "idgun_upgraded_1" || weapon.name == "idgun_upgraded_2" || weapon.name == "idgun_upgraded_3" || weapon.name == "idgun_genesis_0" || weapon.name == "idgun_genesis_0_upgraded")
		{
			if(level.zombie_weapons[weapon].is_in_box == 1)
			{
				if(!tolower(getdvarstring("mapname")) == "zm_genesis")
				{
					level.var_e7e4be0e = 1;
				}
			}
		}
	}
	var_8612b812 = array(getweapon("special_bfg"), getweapon("special_bfg_upgraded"));
	foreach(weapon in var_8612b812)
	{
		if(isdefined(level.zombie_weapons[weapon]))
		{
			level.zombie_weapons[weapon].is_in_box = 0;
		}
	}
}

/*
	Name: function_b400349f
	Namespace: load
	Checksum: 0x424F4353
	Offset: 0x5978
	Size: 0xC8
	Parameters: 0
	Flags: None
	Line Number: 943
*/
function function_b400349f()
{
	switch(tolower(getdvarstring("mapname")))
	{
		case "zm_asylum":
		case "zm_bunker_v2":
		case "zm_castle":
		case "zm_cosmodrome":
		case "zm_factory":
		case "zm_genesis":
		case "zm_island":
		case "zm_moon":
		case "zm_prototype":
		case "zm_stalingrad":
		case "zm_sumpf":
		case "zm_temple":
		case "zm_theater":
		case "zm_tomb":
		case "zm_zod":
		{
			return 1;
		}
		default
		{
			return 0;
		}
	}
	return 0;
}

/*
	Name: function_cc9df5b9
	Namespace: load
	Checksum: 0x424F4353
	Offset: 0x5A48
	Size: 0x130
	Parameters: 2
	Flags: Private
	Line Number: 983
*/
function private function_cc9df5b9(origin, angles)
{
	var_f8d51566 = util::spawn_model("zmu_workbench", origin, angles);
	trigger = spawn("trigger_radius_use", origin + VectorScale((0, 0, 1), 40), 0, 64, 64);
	trigger sethintstring("Craftable not available yet");
	trigger triggerignoreteam();
	trigger setvisibletoall();
	trigger usetriggerrequirelookat();
	trigger setcursorhint("HINT_NOICON");
	trigger.targetname = "craft_vineshield_zm_craftable_trigger";
	trigger.zombie_weapon_upgrade = "vine_shield";
}

/*
	Name: function_6536dcdc
	Namespace: load
	Checksum: 0x424F4353
	Offset: 0x5B80
	Size: 0x1D0
	Parameters: 6
	Flags: None
	Line Number: 1006
*/
function function_6536dcdc(origin_1, var_ec82b4c9, origin_2, var_12852f32, var_544f0d11, var_3887a99b)
{
	for(i = 0; i < 3; i++)
	{
		if(i == 0)
		{
			struct = struct::spawn(origin_1, var_ec82b4c9);
			struct.angles = var_ec82b4c9;
		}
		else if(i == 1)
		{
			struct = struct::spawn(origin_2, var_12852f32);
			struct.angles = var_12852f32;
		}
		else
		{
			struct = struct::spawn(var_544f0d11, var_3887a99b);
			struct.angles = var_3887a99b;
		}
		struct.targetname = "craft_vineshield_zm_part_" + i;
		if(!isdefined(level.struct_class_names["targetname"]["craft_vineshield_zm_part_" + i]))
		{
			level.struct_class_names["targetname"]["craft_vineshield_zm_part_" + i] = [];
		}
		level.struct_class_names["targetname"]["craft_vineshield_zm_part_" + i][level.struct_class_names["targetname"]["craft_vineshield_zm_part_" + i].size] = struct;
	}
}

/*
	Name: function_f5928133
	Namespace: load
	Checksum: 0x424F4353
	Offset: 0x5D58
	Size: 0x288
	Parameters: 0
	Flags: None
	Line Number: 1044
*/
function function_f5928133()
{
	wait(0.05);
	level flag::wait_till("initial_blackscreen_passed");
	level flag::wait_till("all_players_connected");
	if(getplayers().size > 4)
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
				bgb.unitrigger_stub.var_8b8a66cc sethintstring("Gums are Disabled");
				bgb SetZBarrierPieceState(3, "closed");
			}
		}
		return;
	}
	ERROR: Bad function call
}

/*
	Name: function_c0e61153
	Namespace: load
	Checksum: 0x424F4353
	Offset: 0x5FE8
	Size: 0x78
	Parameters: 0
	Flags: None
	Line Number: 1081
*/
function function_c0e61153()
{
	level endon("end_game");
	wait(0.05);
	level flag::wait_till("initial_blackscreen_passed");
	level.var_842626f0 = level._custom_perks.size;
	while(!isdefined(level.machine_assets))
	{
		wait(0.05);
	}
	for(;;)
	{
		wait(20);
		level.perk_purchase_limit = level.var_842626f0;
	}
}

/*
	Name: function_4cc8861a
	Namespace: load
	Checksum: 0x424F4353
	Offset: 0x6068
	Size: 0x320
	Parameters: 2
	Flags: None
	Line Number: 1108
*/
function function_4cc8861a(var_f8fb9f96, var_d3d8af77)
{
	level endon("end_game");
	while(isdefined(self))
	{
		level util::waittill_any("end_of_round", "start_of_round");
		wait(0.2);
		level.var_e7a01594 = level.zombie_total;
		level.max_zombie_func = &zombie_utility::default_max_zombie_func;
		if(level.zombie_vars["zombie_max_ai"] != 24)
		{
			level.zombie_vars["zombie_max_ai"] = 24;
		}
		if(tolower(getdvarstring("mapname")) == "zm_daybreak")
		{
			self thread function_f9e7d600();
		}
		if(level.round_number >= 10)
		{
			if(level.round_number >= 80)
			{
				zombie_utility::set_zombie_var("zombie_powerup_drop_max_per_round", 10);
			}
			else
			{
				zombie_utility::set_zombie_var("zombie_powerup_drop_max_per_round", 4 + int(level.round_number / 10));
			}
		}
		else
		{
			zombie_utility::set_zombie_var("zombie_powerup_drop_max_per_round", 4);
		}
		level.var_55a7e1ae = 0;
		zombie_utility::set_zombie_var("zombie_health_increase", 100, 0);
		zombie_utility::set_zombie_var("zombie_health_increase_multiplier", 0.1, 1);
		zombie_utility::set_zombie_var("zombie_health_start", 150, 0);
		if(isdefined(level.var_affed9f4["zombie_max"]))
		{
			level.zombie_actor_limit = level.var_affed9f4["zombie_max"];
			level.zombie_ai_limit = level.var_affed9f4["zombie_max"];
		}
		else if(isdefined(level.var_679e1a9e) && level.var_679e1a9e)
		{
			level.zombie_actor_limit = var_f8fb9f96 + 8 + var_d3d8af77 * getplayers().size;
			level.zombie_ai_limit = var_f8fb9f96 + 8 + var_d3d8af77 * getplayers().size;
		}
		else
		{
			level.zombie_actor_limit = var_f8fb9f96 + var_d3d8af77 * getplayers().size;
			level.zombie_ai_limit = var_f8fb9f96 + var_d3d8af77 * getplayers().size;
		}
	}
	return;
}

/*
	Name: function_f9e7d600
	Namespace: load
	Checksum: 0x424F4353
	Offset: 0x6390
	Size: 0x60
	Parameters: 0
	Flags: None
	Line Number: 1173
*/
function function_f9e7d600()
{
	self notify("hash_23cdb28a");
	self endon("hash_23cdb28a");
	var_8ab5b3ba = zm::get_zombie_count_for_round(level.round_number, level.players.size);
	wait(0.1);
	level.zombie_total = var_8ab5b3ba;
	return;
	ERROR: Exception occured: Stack empty.
}

/*
	Name: function_35bd70cb
	Namespace: load
	Checksum: 0x424F4353
	Offset: 0x63F8
	Size: 0x178
	Parameters: 6
	Flags: None
	Line Number: 1194
*/
function function_35bd70cb(origin, angle, perk, model, parameters, string)
{
	struct = struct::spawn(origin, angle);
	struct.angles = angle;
	struct.targetname = "zm_perk_machine";
	if(isdefined(perk))
	{
		struct.script_noteworthy = perk;
	}
	if(isdefined(parameters))
	{
		struct.script_parameters = parameters;
	}
	if(isdefined(model))
	{
		struct.model = model;
	}
	if(isdefined(string))
	{
		struct.script_string = string;
	}
	if(!isdefined(level.struct_class_names["targetname"]["zm_perk_machine"]))
	{
		level.struct_class_names["targetname"]["zm_perk_machine"] = [];
	}
	level.struct_class_names["targetname"]["zm_perk_machine"][level.struct_class_names["targetname"]["zm_perk_machine"].size] = struct;
	return struct;
}

/*
	Name: function_347f929f
	Namespace: load
	Checksum: 0x424F4353
	Offset: 0x6578
	Size: 0x50
	Parameters: 0
	Flags: None
	Line Number: 1233
*/
function function_347f929f()
{
	level endon("end_game");
	wait(0.1);
	arrayremovevalue(level._limited_equipment, getweapon("equip_hacker"));
}

/*
	Name: function_5e7a117f
	Namespace: load
	Checksum: 0x424F4353
	Offset: 0x65D0
	Size: 0xD0
	Parameters: 0
	Flags: None
	Line Number: 1250
*/
function function_5e7a117f()
{
	switch(level.script)
	{
		case "zm_factory":
		{
			return 1;
			break;
		}
		case "zm_asylum":
		{
			return 1;
			break;
		}
		case "zm_cosmodrome":
		{
			return 1;
			break;
		}
		case "zm_prototype":
		{
			return 1;
			break;
		}
		case "zm_temple":
		{
			return 1;
			break;
		}
		case "zm_theater":
		{
			return 1;
			break;
		}
		case "zm_tomb":
		{
			return 1;
			break;
		}
		case "zm_moon":
		{
			return 1;
			break;
		}
		case "zm_prototype":
		{
			return 1;
			break;
		}
		default
		{
			return 0;
			break;
		}
	}
}

/*
	Name: function_92907761
	Namespace: load
	Checksum: 0x424F4353
	Offset: 0x66A8
	Size: 0xBE8
	Parameters: 0
	Flags: None
	Line Number: 1317
*/
function function_92907761()
{
	self closeInGameMenu();
	self CloseMenu("StartMenu_Main");
	self notify("player_intermission");
	self endon("player_intermission");
	level endon("stop_intermission");
	self endon("disconnect");
	self endon("death");
	self notify("_zombie_game_over");
	self.score = self.score_total;
	points = struct::get_array("intermission", "targetname");
	points = array::randomize(points);
	self zm_utility::create_streamer_hint(points[0].origin, points[0].angles, 0.9);
	self.var_2826e2d5 = spawn("script_model", points[0].origin);
	self.var_2826e2d5 setmodel("tag_origin");
	self.var_2826e2d5.angles = points[0].angles;
	wait(1);
	self thread lui::screen_fade_out(0.5);
	self.game_over fadeovertime(0.5);
	self.game_over.alpha = 0;
	self.var_1a914bcc fadeovertime(0.5);
	self.var_1a914bcc.alpha = 0;
	wait(0.5);
	self.spectatorclient = -1;
	self.killcamentity = -1;
	self.archivetime = 0;
	self.psoffsettime = 0;
	self.friendlydamage = undefined;
	target_point = struct::get(points[0].target, "targetname");
	speed = 20;
	if(isdefined(self._health_overlay))
	{
		self._health_overlay setshader("overlay_low_health", 0, 0);
	}
	visionset_mgr::deactivate("visionset", "zombie_death", self);
	self freezecontrols(0);
	self allowads(0);
	self camerasetposition(self.var_2826e2d5);
	self camerasetlookat();
	self cameraactivate(1);
	dist = distance(points[0].origin, target_point.origin);
	time = dist / speed;
	q_time = time * 0.25;
	if(q_time > 1)
	{
		q_time = 1;
	}
	self notify("player_intermission_spawned");
	self thread zm::screen_fade_in(2);
	self.game_over fadeovertime(2);
	self.game_over.alpha = 1;
	self.var_1a914bcc fadeovertime(2);
	self.var_1a914bcc.alpha = 1;
	time = 13;
	self.var_2826e2d5 moveto(target_point.origin, time, q_time, q_time);
	self.var_2826e2d5 rotateto(target_point.angles, time, q_time, q_time);
	self zm_utility::create_streamer_hint(points[1].origin, points[1].angles, 0.9);
	self.var_9dbb2ccd = spawn("script_model", points[1].origin);
	self.var_9dbb2ccd setmodel("tag_origin");
	self.var_9dbb2ccd.angles = points[1].angles;
	var_f2d89fc = struct::get(points[1].target, "targetname");
	wait(5);
	self thread lui::screen_fade_out(0.5);
	self.game_over fadeovertime(0.5);
	self.game_over.alpha = 0;
	self.var_1a914bcc fadeovertime(0.5);
	self.var_1a914bcc.alpha = 0;
	speed = 20;
	dist = distance(points[1].origin, target_point.origin);
	time = dist / speed;
	q_time = time * 0.25;
	if(q_time > 1)
	{
		q_time = 1;
	}
	wait(0.5);
	self camerasetposition(self.var_9dbb2ccd);
	self thread zm::screen_fade_in(2);
	self.game_over fadeovertime(2);
	self.game_over.alpha = 1;
	self.var_1a914bcc fadeovertime(2);
	self.var_1a914bcc.alpha = 1;
	self.var_2826e2d5 delete();
	time = 13;
	self.var_9dbb2ccd moveto(var_f2d89fc.origin, time, q_time, q_time);
	self.var_9dbb2ccd rotateto(var_f2d89fc.angles, time, q_time, q_time);
	self zm_utility::create_streamer_hint(points[2].origin, points[2].angles, 0.9);
	self.var_77b8b264 = spawn("script_model", points[2].origin);
	self.var_77b8b264 setmodel("tag_origin");
	self.var_77b8b264.angles = points[2].angles;
	var_f2d89fc = struct::get(points[2].target, "targetname");
	wait(5);
	self thread lui::screen_fade_out(0.5);
	self.game_over fadeovertime(0.5);
	self.game_over.alpha = 0;
	self.var_1a914bcc fadeovertime(0.5);
	self.var_1a914bcc.alpha = 0;
	speed = 20;
	dist = distance(points[2].origin, target_point.origin);
	time = dist / speed;
	q_time = time * 0.25;
	if(q_time > 1)
	{
		q_time = 1;
	}
	wait(0.5);
	self camerasetposition(self.var_77b8b264);
	self thread zm::screen_fade_in(2);
	self.game_over fadeovertime(2);
	self.game_over.alpha = 1;
	self.var_1a914bcc fadeovertime(2);
	self.var_1a914bcc.alpha = 1;
	self.var_9dbb2ccd delete();
	time = 13;
	self.var_77b8b264 moveto(var_f2d89fc.origin, time, q_time, q_time);
	self.var_77b8b264 rotateto(var_f2d89fc.angles, time, q_time, q_time);
	wait(5);
	self thread lui::screen_fade_out(1);
	self.game_over fadeovertime(1);
	self.game_over.alpha = 0;
	self.var_1a914bcc fadeovertime(1);
	self.var_1a914bcc.alpha = 0;
	wait(1);
}

/*
	Name: function_ffdcb0bb
	Namespace: load
	Checksum: 0x424F4353
	Offset: 0x7298
	Size: 0xBE8
	Parameters: 0
	Flags: None
	Line Number: 1453
*/
function function_ffdcb0bb()
{
	self closeInGameMenu();
	self CloseMenu("StartMenu_Main");
	self notify("player_intermission");
	self endon("player_intermission");
	level endon("stop_intermission");
	self endon("disconnect");
	self endon("death");
	self notify("_zombie_game_over");
	self.score = self.score_total;
	points = struct::get_array("intermission", "targetname");
	points = array::randomize(points);
	self zm_utility::create_streamer_hint(points[0].origin, points[0].angles, 0.9);
	self.var_2826e2d5 = spawn("script_model", points[0].origin);
	self.var_2826e2d5 setmodel("tag_origin");
	self.var_2826e2d5.angles = points[0].angles;
	wait(1);
	self thread lui::screen_fade_out(0.5);
	self.game_over fadeovertime(0.5);
	self.game_over.alpha = 0;
	self.var_1a914bcc fadeovertime(0.5);
	self.var_1a914bcc.alpha = 0;
	wait(0.5);
	self.spectatorclient = -1;
	self.killcamentity = -1;
	self.archivetime = 0;
	self.psoffsettime = 0;
	self.friendlydamage = undefined;
	target_point = struct::get(points[0].target, "targetname");
	speed = 20;
	if(isdefined(self._health_overlay))
	{
		self._health_overlay setshader("overlay_low_health", 0, 0);
	}
	visionset_mgr::deactivate("visionset", "zombie_death", self);
	self freezecontrols(0);
	self allowads(0);
	self camerasetposition(self.var_2826e2d5);
	self camerasetlookat();
	self cameraactivate(1);
	dist = distance(points[0].origin, target_point.origin);
	time = dist / speed;
	q_time = time * 0.25;
	if(q_time > 1)
	{
		q_time = 1;
	}
	self notify("player_intermission_spawned");
	self thread zm::screen_fade_in(2);
	self.game_over fadeovertime(2);
	self.game_over.alpha = 1;
	self.var_1a914bcc fadeovertime(2);
	self.var_1a914bcc.alpha = 1;
	time = 10;
	self.var_2826e2d5 moveto(target_point.origin, time, q_time, q_time);
	self.var_2826e2d5 rotateto(target_point.angles, time, q_time, q_time);
	self zm_utility::create_streamer_hint(points[1].origin, points[1].angles, 0.9);
	self.var_9dbb2ccd = spawn("script_model", points[1].origin);
	self.var_9dbb2ccd setmodel("tag_origin");
	self.var_9dbb2ccd.angles = points[1].angles;
	var_f2d89fc = struct::get(points[1].target, "targetname");
	wait(5);
	self thread lui::screen_fade_out(0.5);
	self.game_over fadeovertime(0.5);
	self.game_over.alpha = 0;
	self.var_1a914bcc fadeovertime(0.5);
	self.var_1a914bcc.alpha = 0;
	speed = 20;
	dist = distance(points[1].origin, target_point.origin);
	time = dist / speed;
	q_time = time * 0.25;
	if(q_time > 1)
	{
		q_time = 1;
	}
	wait(0.5);
	self camerasetposition(self.var_9dbb2ccd);
	self thread zm::screen_fade_in(2);
	self.game_over fadeovertime(2);
	self.game_over.alpha = 1;
	self.var_1a914bcc fadeovertime(2);
	self.var_1a914bcc.alpha = 1;
	self.var_2826e2d5 delete();
	time = 10;
	self.var_9dbb2ccd moveto(var_f2d89fc.origin, time, q_time, q_time);
	self.var_9dbb2ccd rotateto(var_f2d89fc.angles, time, q_time, q_time);
	self zm_utility::create_streamer_hint(points[2].origin, points[2].angles, 0.9);
	self.var_77b8b264 = spawn("script_model", points[2].origin);
	self.var_77b8b264 setmodel("tag_origin");
	self.var_77b8b264.angles = points[2].angles;
	var_f2d89fc = struct::get(points[2].target, "targetname");
	wait(5);
	self thread lui::screen_fade_out(0.5);
	self.game_over fadeovertime(0.5);
	self.game_over.alpha = 0;
	self.var_1a914bcc fadeovertime(0.5);
	self.var_1a914bcc.alpha = 0;
	speed = 20;
	dist = distance(points[2].origin, target_point.origin);
	time = dist / speed;
	q_time = time * 0.25;
	if(q_time > 1)
	{
		q_time = 1;
	}
	wait(0.5);
	self camerasetposition(self.var_77b8b264);
	self thread zm::screen_fade_in(2);
	self.game_over fadeovertime(2);
	self.game_over.alpha = 1;
	self.var_1a914bcc fadeovertime(2);
	self.var_1a914bcc.alpha = 1;
	self.var_9dbb2ccd delete();
	time = 10;
	self.var_77b8b264 moveto(var_f2d89fc.origin, time, q_time, q_time);
	self.var_77b8b264 rotateto(var_f2d89fc.angles, time, q_time, q_time);
	wait(5);
	self thread lui::screen_fade_out(1);
	self.game_over fadeovertime(1);
	self.game_over.alpha = 0;
	self.var_1a914bcc fadeovertime(1);
	self.var_1a914bcc.alpha = 0;
	wait(1);
	return;
}

/*
	Name: function_23b01d28
	Namespace: load
	Checksum: 0x424F4353
	Offset: 0x7E88
	Size: 0x8F0
	Parameters: 0
	Flags: None
	Line Number: 1590
*/
function function_23b01d28()
{
	self closeInGameMenu();
	self CloseMenu("StartMenu_Main");
	self notify("player_intermission");
	self endon("player_intermission");
	level endon("stop_intermission");
	self endon("disconnect");
	self endon("death");
	self notify("_zombie_game_over");
	self.score = self.score_total;
	points = struct::get_array("intermission", "targetname");
	self zm_utility::create_streamer_hint(points[0].origin, points[0].angles, 0.9);
	self.var_2826e2d5 = spawn("script_model", points[0].origin);
	self.var_2826e2d5 setmodel("tag_origin");
	self.var_2826e2d5.angles = points[0].angles;
	wait(1);
	self thread lui::screen_fade_out(1);
	self.game_over fadeovertime(1);
	self.game_over.alpha = 0;
	self.var_1a914bcc fadeovertime(1);
	self.var_1a914bcc.alpha = 0;
	wait(1);
	self.spectatorclient = -1;
	self.killcamentity = -1;
	self.archivetime = 0;
	self.psoffsettime = 0;
	self.friendlydamage = undefined;
	target_point = struct::get(points[0].target, "targetname");
	speed = 20;
	if(isdefined(points[0].speed))
	{
		speed = points[0].speed;
	}
	if(isdefined(self._health_overlay))
	{
		self._health_overlay setshader("overlay_low_health", 0, 0);
	}
	visionset_mgr::deactivate("visionset", "zombie_death", self);
	self freezecontrols(0);
	self allowads(0);
	self camerasetposition(self.var_2826e2d5);
	self camerasetlookat();
	self cameraactivate(1);
	dist = distance(points[0].origin, target_point.origin);
	time = dist / speed;
	q_time = time * 0.25;
	if(q_time > 1)
	{
		q_time = 1;
	}
	wait(0.15);
	self notify("player_intermission_spawned");
	self thread zm::screen_fade_in(1);
	self.game_over fadeovertime(1);
	self.game_over.alpha = 1;
	self.var_1a914bcc fadeovertime(1);
	self.var_1a914bcc.alpha = 1;
	time = 20;
	self.var_2826e2d5 moveto(target_point.origin, time, q_time, q_time);
	self.var_2826e2d5 rotateto(target_point.angles, time, q_time, q_time);
	self zm_utility::create_streamer_hint(points[1].origin, points[1].angles, 0.9);
	self.var_9dbb2ccd = spawn("script_model", points[1].origin);
	self.var_9dbb2ccd setmodel("tag_origin");
	self.var_9dbb2ccd.angles = points[1].angles;
	var_f2d89fc = struct::get(points[1].target, "targetname");
	wait(8);
	self thread lui::screen_fade_out(1);
	self.game_over fadeovertime(1);
	self.game_over.alpha = 0;
	self.var_1a914bcc fadeovertime(1);
	self.var_1a914bcc.alpha = 0;
	speed = 20;
	if(isdefined(points[1].speed))
	{
		speed = points[1].speed;
	}
	dist = distance(points[1].origin, target_point.origin);
	time = dist / speed;
	q_time = time * 0.25;
	if(q_time > 1)
	{
		q_time = 1;
	}
	wait(1);
	self camerasetposition(self.var_9dbb2ccd);
	wait(0.05);
	self thread zm::screen_fade_in(1);
	self.game_over fadeovertime(1);
	self.game_over.alpha = 1;
	self.var_1a914bcc fadeovertime(1);
	self.var_1a914bcc.alpha = 1;
	self.var_2826e2d5 delete();
	time = 10;
	self.var_9dbb2ccd moveto(var_f2d89fc.origin, time, q_time, q_time);
	self.var_9dbb2ccd rotateto(var_f2d89fc.angles, time, q_time, q_time);
	wait(8);
	self thread lui::screen_fade_out(2);
	self.game_over fadeovertime(3);
	self.game_over.alpha = 0;
	self.var_1a914bcc fadeovertime(3);
	self.var_1a914bcc.alpha = 0;
	wait(3);
}

/*
	Name: moon_intermission
	Namespace: load
	Checksum: 0x424F4353
	Offset: 0x8780
	Size: 0x758
	Parameters: 0
	Flags: None
	Line Number: 1705
*/
function moon_intermission()
{
	self closeInGameMenu();
	self CloseMenu("StartMenu_Main");
	self notify("player_intermission");
	self endon("player_intermission");
	level endon("stop_intermission");
	self endon("disconnect");
	self endon("death");
	self notify("_zombie_game_over");
	intro = 2;
	outro = 5;
	self.score = self.score_total;
	points = struct::get_array("intermission", "targetname");
	for(i = 0; i < points.size; i++)
	{
		if(level flag::get("enter_nml"))
		{
			intro = 1;
			outro = 3.5;
			if(points[i].script_noteworthy == "moon")
			{
				arrayremovevalue(points, points[i]);
				continue;
			}
		}
		if(points[i].script_noteworthy == "earth")
		{
			intro = 4;
			outro = 14;
			arrayremovevalue(points, points[i]);
		}
	}
	if(!isdefined(points) || points.size == 0)
	{
		points = getentarray("info_intermission", "classname");
		if(points.size < 1)
		{
			return;
		}
	}
	target_point = struct::get(points[0].target, "targetname");
	var_cd052e91 = points[0].origin;
	var_c61350dc = points[0].angles;
	target_origin = target_point.origin;
	var_5969b25a = target_point.angles;
	speed = 20;
	if(isdefined(points[0].speed))
	{
		speed = points[0].speed;
	}
	self zm_utility::create_streamer_hint(var_cd052e91, var_c61350dc, 0.9);
	wait(intro);
	self thread lui::screen_fade_out(1);
	self.game_over fadeovertime(1);
	self.game_over.alpha = 0;
	self.var_1a914bcc fadeovertime(1);
	self.var_1a914bcc.alpha = 0;
	wait(1);
	self.spectatorclient = -1;
	self.killcamentity = -1;
	self.archivetime = 0;
	self.psoffsettime = 0;
	self.friendlydamage = undefined;
	if(isdefined(self._health_overlay))
	{
		self._health_overlay setshader("overlay_low_health", 0, 0);
	}
	visionset_mgr::deactivate("visionset", "zombie_death", self);
	self freezecontrols(0);
	self clientfield::set_to_player("gasmaskoverlay", 0);
	visionset_mgr::deactivate("overlay", "zm_gasmask_postfx", self);
	self allowads(0);
	self.var_2826e2d5 = spawn("script_model", var_cd052e91);
	self.var_2826e2d5 setmodel("tag_origin");
	self.var_2826e2d5.angles = var_c61350dc;
	self camerasetposition(self.var_2826e2d5);
	self camerasetlookat();
	self cameraactivate(1);
	dist = distance(var_cd052e91, target_origin);
	time = dist / speed;
	q_time = time * 0.25;
	if(q_time > 1)
	{
		q_time = 1;
	}
	wait(0.15);
	self notify("player_intermission_spawned");
	self thread zm::screen_fade_in(1);
	self.game_over fadeovertime(1);
	self.game_over.alpha = 1;
	self.var_1a914bcc fadeovertime(1);
	self.var_1a914bcc.alpha = 1;
	self.var_2826e2d5 moveto(target_origin, time, q_time, q_time);
	self.var_2826e2d5 rotateto(var_5969b25a, time, q_time, q_time);
	wait(outro);
	self thread lui::screen_fade_out(2);
	self.game_over fadeovertime(2);
	self.game_over.alpha = 0;
	self.var_1a914bcc fadeovertime(2);
	self.var_1a914bcc.alpha = 0;
	wait(2);
}

/*
	Name: function_14512ced
	Namespace: load
	Checksum: 0x424F4353
	Offset: 0x8EE0
	Size: 0x120
	Parameters: 0
	Flags: None
	Line Number: 1819
*/
function function_14512ced()
{
	wait(1);
	level.custom_intermission = &player_intermission;
	if(level.script == "zm_tomb")
	{
		level._zombie_sidequests["little_girl_lost"].complete_func = &function_efa913af;
	}
	if(level.script == "zm_moon")
	{
		level.custom_intermission = &moon_intermission;
	}
	if(level.script == "zm_factory")
	{
		level.custom_intermission = &function_23b01d28;
	}
	if(level.script == "zm_theater")
	{
		level.custom_intermission = &function_ffdcb0bb;
	}
	if(level.script == "zm_temple")
	{
		level.custom_intermission = &function_92907761;
	}
	level.custom_game_over_hud_elem = &custom_game_over_hud_elem;
	return;
	ERROR: Bad function call
}

/*
	Name: function_efa913af
	Namespace: load
	Checksum: 0x424F4353
	Offset: 0x9008
	Size: 0x2C0
	Parameters: 0
	Flags: None
	Line Number: 1858
*/
function function_efa913af()
{
	a_players = getplayers();
	foreach(player in a_players)
	{
		player zm::spectator_respawn_player();
		player freezecontrols(1);
		player enableinvulnerability();
		if(player laststand::player_is_in_laststand())
		{
			player zm_laststand::auto_revive(level, 0);
		}
	}
	zm_audio::musicState_Create("game_over", 5, "game_over_zhd_tomb2");
	level.custom_intermission = &function_9e04319a;
	level lui::prime_movie("zm_outro_tomb", 0, "");
	level.sndgameovermusicoverride = "game_over_ee";
	level flag::clear("spawn_zombies");
	level thread function_19a0b6e0();
	playsoundatposition("zmb_squest_whiteout", (0, 0, 0));
	level lui::screen_fade_out(1, "white", "starting_ee_screen");
	util::delay(0.5, undefined, &remove_portal_beam);
	level thread lui::play_movie("zm_outro_tomb", "fullscreen", 0, 0, "");
	level lui::screen_fade_out(0, "black", "starting_ee_screen");
	wait(81);
	level notify("end_game");
	level thread lui::screen_fade_in(2, "black", "starting_ee_screen");
	wait(1.5);
}

/*
	Name: remove_portal_beam
	Namespace: load
	Checksum: 0x424F4353
	Offset: 0x92D0
	Size: 0x30
	Parameters: 0
	Flags: None
	Line Number: 1898
*/
function remove_portal_beam()
{
	if(isdefined(level.ee_ending_beam_fx))
	{
		level.ee_ending_beam_fx delete();
		return;
	}
}

/*
	Name: function_19a0b6e0
	Namespace: load
	Checksum: 0x424F4353
	Offset: 0x9308
	Size: 0x1A8
	Parameters: 0
	Flags: None
	Line Number: 1917
*/
function function_19a0b6e0()
{
System.InvalidOperationException: Stack empty.
   at System.ThrowHelper.ThrowInvalidOperationException(ExceptionResource resource)
   at System.Collections.Generic.Stack`1.Pop()
   at Cerberus.Logic.Decompiler.BuildCondition(Int32 startIndex)
   at Cerberus.Logic.Decompiler.FindIfStatements()
   at Cerberus.Logic.Decompiler..ctor(ScriptExport function, ScriptBase script)
}

/*
	Name: function_a7ca0362
	Namespace: load
	Checksum: 0x424F4353
	Offset: 0x94B8
	Size: 0xD0
	Parameters: 0
	Flags: None
	Line Number: 1937
*/
function function_a7ca0362()
{
	switch(level.script)
	{
		case "zm_asylum":
		{
			return 4;
			break;
		}
		case "zm_cosmodrome":
		{
			return 2;
			break;
		}
		case "zm_prototype":
		{
			return 4;
			break;
		}
		case "zm_sumpf":
		{
			return 4;
			break;
		}
		case "zm_temple":
		{
			return 4;
			break;
		}
		case "zm_theater":
		{
			return 4;
			break;
		}
		case "zm_tomb":
		{
			return 4;
			break;
		}
		case "zm_moon":
		{
			return 4;
			break;
		}
		case "zm_prototype":
		{
			return 4;
			break;
		}
		default
		{
			return 4;
			break;
		}
	}
}

/*
	Name: function_9b7d1f69
	Namespace: load
	Checksum: 0x424F4353
	Offset: 0x9590
	Size: 0xE0
	Parameters: 0
	Flags: None
	Line Number: 2004
*/
function function_9b7d1f69()
{
	switch(level.script)
	{
		case "zm_factory":
		{
			return 14;
			break;
		}
		case "zm_asylum":
		{
			return 13;
			break;
		}
		case "zm_cosmodrome":
		{
			return 7;
			break;
		}
		case "zm_prototype":
		{
			return 13;
			break;
		}
		case "zm_sumpf":
		{
			return 13;
			break;
		}
		case "zm_temple":
		{
			return 13;
			break;
		}
		case "zm_theater":
		{
			return 13;
			break;
		}
		case "zm_tomb":
		{
			return 13;
			break;
		}
		case "zm_moon":
		{
			return 13;
			break;
		}
		case "zm_prototype":
		{
			return 13;
			break;
		}
		default
		{
			return 13;
			break;
		}
	}
	return;
	ERROR: Exception occured: Stack empty.
}

/*
	Name: player_intermission
	Namespace: load
	Checksum: 0x424F4353
	Offset: 0x9678
	Size: 0x640
	Parameters: 0
	Flags: None
	Line Number: 2078
*/
function player_intermission()
{
	self closeInGameMenu();
	self CloseMenu("StartMenu_Main");
	self notify("player_intermission");
	self endon("player_intermission");
	level endon("stop_intermission");
	self endon("disconnect");
	self endon("death");
	self notify("_zombie_game_over");
	self.score = self.score_total;
	points = struct::get_array("intermission", "targetname");
	if(!isdefined(points) || points.size == 0)
	{
		points = getentarray("info_intermission", "classname");
		if(points.size < 1)
		{
			return;
		}
	}
	i = randomint(points.size);
	target_point = struct::get(points[i].target, "targetname");
	var_cd052e91 = points[i].origin;
	var_c61350dc = points[i].angles;
	target_origin = target_point.origin;
	var_5969b25a = target_point.angles;
	speed = 20;
	if(isdefined(points[i].speed))
	{
		speed = points[i].speed;
	}
	self zm_utility::create_streamer_hint(var_cd052e91, var_c61350dc, 0.9);
	wait(function_a7ca0362());
	self thread lui::screen_fade_out(1);
	self.game_over fadeovertime(1);
	self.game_over.alpha = 0;
	self.var_1a914bcc fadeovertime(1);
	self.var_1a914bcc.alpha = 0;
	wait(1);
	self.spectatorclient = -1;
	self.killcamentity = -1;
	self.archivetime = 0;
	self.psoffsettime = 0;
	self.friendlydamage = undefined;
	if(isdefined(self._health_overlay))
	{
		self._health_overlay setshader("overlay_low_health", 0, 0);
	}
	visionset_mgr::deactivate("visionset", "zombie_death", self);
	self freezecontrols(0);
	self allowads(0);
	self.var_2826e2d5 = spawn("script_model", var_cd052e91);
	self.var_2826e2d5 setmodel("tag_origin");
	self.var_2826e2d5.angles = var_c61350dc;
	self camerasetposition(self.var_2826e2d5);
	self camerasetlookat();
	self cameraactivate(1);
	dist = distance(var_cd052e91, target_origin);
	time = dist / speed;
	q_time = time * 0.25;
	if(q_time > 1)
	{
		q_time = 1;
	}
	wait(0.15);
	self notify("player_intermission_spawned");
	self thread zm::screen_fade_in(1);
	self.game_over fadeovertime(1);
	self.game_over.alpha = 1;
	self.var_1a914bcc fadeovertime(1);
	self.var_1a914bcc.alpha = 1;
	self.var_2826e2d5 moveto(target_origin, time, q_time, q_time);
	self.var_2826e2d5 rotateto(var_5969b25a, time, q_time, q_time);
	wait(function_9b7d1f69());
	self thread lui::screen_fade_out(2);
	self.game_over fadeovertime(2);
	self.game_over.alpha = 0;
	self.var_1a914bcc fadeovertime(2);
	self.var_1a914bcc.alpha = 0;
	wait(2);
}

/*
	Name: custom_game_over_hud_elem
	Namespace: load
	Checksum: 0x424F4353
	Offset: 0x9CC0
	Size: 0x2F8
	Parameters: 3
	Flags: None
	Line Number: 2170
*/
function custom_game_over_hud_elem(player, game_over, survived)
{
	player.game_over = game_over;
	game_over = player.game_over;
	player.var_1a914bcc = survived;
	survived = player.var_1a914bcc;
	game_over.alignx = "center";
	game_over.aligny = "middle";
	game_over.horzalign = "center";
	game_over.vertalign = "middle";
	game_over.y = game_over.y - 130;
	game_over.foreground = 1;
	game_over.fontscale = 3;
	game_over.alpha = 0;
	game_over.color = (1, 1, 1);
	game_over.hidewheninmenu = 1;
	game_over settext(&"ZOMBIE_GAME_OVER");
	game_over fadeovertime(1);
	game_over.alpha = 1;
	if(player issplitscreen())
	{
		game_over.fontscale = 2;
		game_over.y = game_over.y + 40;
	}
	survived.alignx = "center";
	survived.aligny = "middle";
	survived.horzalign = "center";
	survived.vertalign = "middle";
	survived.y = survived.y - 100;
	survived.foreground = 1;
	survived.fontscale = 2;
	survived.alpha = 0;
	survived.color = (1, 1, 1);
	survived.hidewheninmenu = 1;
	if(player issplitscreen())
	{
		survived.fontscale = 1.5;
		survived.y = survived.y + 40;
	}
}

/*
	Name: function_9e04319a
	Namespace: load
	Checksum: 0x424F4353
	Offset: 0x9FC0
	Size: 0x558
	Parameters: 0
	Flags: None
	Line Number: 2221
*/
function function_9e04319a()
{
	self closeInGameMenu();
	self CloseMenu("StartMenu_Main");
	self notify("player_intermission");
	self endon("player_intermission");
	level endon("stop_intermission");
	self endon("disconnect");
	self endon("death");
	self notify("_zombie_game_over");
	self.game_over.alpha = 0;
	self.var_1a914bcc.alpha = 0;
	self thread lui::screen_fade_out(0);
	self.score = self.score_total;
	points = struct::get_array("ee_cam", "targetname");
	target_point = struct::get(points[0].target, "targetname");
	var_cd052e91 = points[0].origin;
	var_c61350dc = points[0].angles;
	target_origin = target_point.origin;
	var_5969b25a = target_point.angles;
	speed = 20;
	if(isdefined(points[0].speed))
	{
		speed = points[0].speed;
	}
	self zm_utility::create_streamer_hint(var_cd052e91, var_c61350dc, 0.9);
	self.spectatorclient = -1;
	self.killcamentity = -1;
	self.archivetime = 0;
	self.psoffsettime = 0;
	self.friendlydamage = undefined;
	if(isdefined(self._health_overlay))
	{
		self._health_overlay setshader("overlay_low_health", 0, 0);
	}
	visionset_mgr::deactivate("visionset", "zombie_death", self);
	self freezecontrols(0);
	self allowads(0);
	self.var_2826e2d5 = spawn("script_model", var_cd052e91);
	self.var_2826e2d5 setmodel("tag_origin");
	self.var_2826e2d5.angles = var_c61350dc;
	self camerasetposition(self.var_2826e2d5);
	self camerasetlookat();
	self cameraactivate(1);
	dist = distance(var_cd052e91, target_origin);
	time = dist / speed;
	q_time = time * 0.25;
	if(q_time > 1)
	{
		q_time = 1;
	}
	self.var_2826e2d5 moveto(target_origin, time, q_time, q_time);
	self.var_2826e2d5 rotateto(var_5969b25a, time, q_time, q_time);
	wait(0.15);
	self notify("player_intermission_spawned");
	self thread zm::screen_fade_in(2);
	self.game_over fadeovertime(2);
	self.game_over.alpha = 1;
	self.var_1a914bcc fadeovertime(2);
	self.var_1a914bcc.alpha = 1;
	wait(14);
	self thread lui::screen_fade_out(2);
	self.game_over fadeovertime(2);
	self.game_over.alpha = 0;
	self.var_1a914bcc fadeovertime(2);
	self.var_1a914bcc.alpha = 0;
	wait(2);
}

/*
	Name: function_7c03764f
	Namespace: load
	Checksum: 0x424F4353
	Offset: 0xA520
	Size: 0x128
	Parameters: 4
	Flags: Private
	Line Number: 2300
*/
function private function_7c03764f(user, trigger, origin_offset, interact_offset)
{
	if(!isdefined(user))
	{
		user = level;
	}
	level endon("Pack_A_Punch_off");
	trigger endon("pap_player_disconnected");
	foreach(player in getplayers())
	{
		player stopSound("zmb_perks_packa_ready");
		player stopSound("zmb_perks_packa_ready");
	}
	user playsound("tomb_pap_ready");
}

/*
	Name: function_924c2652
	Namespace: load
	Checksum: 0x424F4353
	Offset: 0xA650
	Size: 0x58
	Parameters: 4
	Flags: Private
	Line Number: 2326
*/
function private function_924c2652(player, trigger, origin_offset, angles_offset)
{
	level endon("Pack_A_Punch_off");
	trigger endon("pap_player_disconnected");
	player thread function_1cd707a5();
}

/*
	Name: function_1cd707a5
	Namespace: load
	Checksum: 0x424F4353
	Offset: 0xA6B0
	Size: 0x50
	Parameters: 0
	Flags: Private
	Line Number: 2343
*/
function private function_1cd707a5()
{
	wait(0.05);
	self stopSound("zmb_perks_packa_upgrade");
	self playsound("tomb_pap_upgrade");
}

/*
	Name: function_1c485da4
	Namespace: load
	Checksum: 0x424F4353
	Offset: 0xA708
	Size: 0x48
	Parameters: 0
	Flags: Private
	Line Number: 2360
*/
function private function_1c485da4()
{
	wait(1);
	self stoploopsound(0);
	self playloopsound("tomb_pap_loop");
}

/*
	Name: custom_joker_movement
	Namespace: load
	Checksum: 0x424F4353
	Offset: 0xA758
	Size: 0x1E8
	Parameters: 0
	Flags: None
	Line Number: 2377
*/
function custom_joker_movement()
{
	v_origin = self.weapon_model.origin - VectorScale((0, 0, 1), 5);
	self.weapon_model delete();
	m_lock = util::spawn_model(level.chest_joker_model, v_origin, self.angles);
	wait(0.5);
	level notify("weapon_fly_away_start");
	thread function_98039e78();
	playsoundatposition("zmb_hellbox_bear", (0, 0, 0));
	wait(1);
	m_lock rotateyaw(3000, 4, 4);
	wait(3);
	v_angles = anglestoforward(self.angles - VectorScale((0, 1, 0), 90));
	m_lock moveto(m_lock.origin + 20 * v_angles, 0.5, 0.5);
	m_lock waittill("movedone");
	m_lock moveto(m_lock.origin + -100 * v_angles, 0.5, 0.5);
	m_lock waittill("movedone");
	m_lock delete();
	self notify("box_moving");
	level notify("weapon_fly_away_end");
}

/*
	Name: function_98039e78
	Namespace: load
	Checksum: 0x424F4353
	Offset: 0xA948
	Size: 0xC8
	Parameters: 0
	Flags: None
	Line Number: 2409
*/
function function_98039e78()
{
	level endon("weapon_fly_away_end");
	level endon("end_game");
	while(1)
	{
		foreach(player in getplayers())
		{
			player stopSound(level.zmb_laugh_alias);
		}
		wait(0.05);
	}
}

/*
	Name: function_4abfffd2
	Namespace: load
	Checksum: 0x424F4353
	Offset: 0xAA18
	Size: 0x138
	Parameters: 0
	Flags: None
	Line Number: 2433
*/
function function_4abfffd2()
{
	level waittill("power_on");
	doors = getentarray("receiving_bay_doors", "targetname");
	for(i = 0; i < doors.size; i++)
	{
		script_vector = function_b162da30(i);
		doors[i] playsound("evt_loading_door_start");
		doors[i] playloopsound("evt_loading_door_loop", 0.5);
		doors[i] moveto(doors[i].origin + script_vector, 3);
		doors[i] thread function_e7d84b6();
	}
	return;
	ERROR: Exception occured: Stack empty.
}

/*
	Name: function_b162da30
	Namespace: load
	Checksum: 0x424F4353
	Offset: 0xAB58
	Size: 0x90
	Parameters: 1
	Flags: None
	Line Number: 2459
*/
function function_b162da30(i)
{
	switch(i)
	{
		case 0:
		{
			return VectorScale((0, 0, 1), 72);
			break;
		}
		case 1:
		{
			return VectorScale((0, 0, 1), 72);
			break;
		}
		case 2:
		{
			return VectorScale((0, 0, -1), 80);
			break;
		}
		case 3:
		{
			return VectorScale((0, 0, -1), 56);
			break;
		}
	}
}

/*
	Name: function_e7d84b6
	Namespace: load
	Checksum: 0x424F4353
	Offset: 0xABF0
	Size: 0x50
	Parameters: 0
	Flags: None
	Line Number: 2496
*/
function function_e7d84b6()
{
	wait(2.6);
	self stoploopsound(0.5);
	self playsound("evt_loading_door_end");
}

/*
	Name: function_6811a318
	Namespace: load
	Checksum: 0x424F4353
	Offset: 0xAC48
	Size: 0x48
	Parameters: 0
	Flags: None
	Line Number: 2513
*/
function function_6811a318()
{
	thread function_faa7d346();
	thread function_69441aa4();
	thread function_4d2e9004();
	thread function_6d36bad9();
}

/*
	Name: function_faa7d346
	Namespace: load
	Checksum: 0x424F4353
	Offset: 0xAC98
	Size: 0x30
	Parameters: 0
	Flags: None
	Line Number: 2531
*/
function function_faa7d346()
{
	level endon("end_game");
	level waittill("air_puzzle_2_complete");
	thread play_puzzle_stinger_on_all_players();
}

/*
	Name: function_69441aa4
	Namespace: load
	Checksum: 0x424F4353
	Offset: 0xACD0
	Size: 0x30
	Parameters: 0
	Flags: None
	Line Number: 2548
*/
function function_69441aa4()
{
	level endon("end_game");
	level waittill("fire_puzzle_2_complete");
	thread play_puzzle_stinger_on_all_players();
}

/*
	Name: function_4d2e9004
	Namespace: load
	Checksum: 0x424F4353
	Offset: 0xAD08
	Size: 0x30
	Parameters: 0
	Flags: None
	Line Number: 2565
*/
function function_4d2e9004()
{
	level endon("end_game");
	level waittill("hash_70b160e8");
	thread play_puzzle_stinger_on_all_players();
}

/*
	Name: function_6d36bad9
	Namespace: load
	Checksum: 0x424F4353
	Offset: 0xAD40
	Size: 0x30
	Parameters: 0
	Flags: None
	Line Number: 2582
*/
function function_6d36bad9()
{
	level endon("end_game");
	level waittill("electric_puzzle_2_complete");
	thread play_puzzle_stinger_on_all_players();
}

/*
	Name: play_puzzle_stinger_on_all_players
	Namespace: load
	Checksum: 0x424F4353
	Offset: 0xAD78
	Size: 0x24
	Parameters: 0
	Flags: None
	Line Number: 2599
*/
function play_puzzle_stinger_on_all_players()
{
	playsoundatposition("zmb_squest_step2_finished", (0, 0, 0));
}

