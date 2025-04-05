#include scripts\_zombies_ultimate\_zm_uem_pet;
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
#include scripts\sphynx\_zm_loot_mode;
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
#include scripts\sphynx\powerups\_zm_powerup_storm_surge;
#include scripts\sphynx\powerups\_zm_powerup_xp;
#include scripts\sphynx\weapons\_zm_weap_changes;
#include scripts\sphynx\weapons\_zm_weap_crossbow;
#include scripts\sphynx\weapons\_zm_weap_melee_special_damage;
#include scripts\sphynx\weapons\_zm_weapon_drop_system;
#include scripts\zm\_art;
#include scripts\zm\_callbacks;
#include scripts\zm\_destructible;
#include scripts\zm\_util;
#include scripts\zm\_zm;
#include scripts\zm\_zm_audio;
#include scripts\zm\_zm_behavior;
#include scripts\zm\_zm_blockers;
#include scripts\zm\_zm_bloodsplatter;
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
#include scripts\zm\aats\_zm_aat_ricochet;
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

#namespace namespace_load;

/*
	Name: function_ignore_systems
	Namespace: namespace_load
	Checksum: 0x424F4353
	Offset: 0x2740
	Size: 0x550
	Parameters: 0
	Flags: AutoExec
	Line Number: 113
*/
function autoexec function_ignore_systems()
{
	namespace_system::function_Ignore("zm_powerup_weapon_minigun");
	namespace_system::function_Ignore("zm_perk_electric_cherry");
	namespace_system::function_Ignore("zm_perk_phdflopper");
	namespace_system::function_Ignore("zm_perk_tombstone");
	namespace_system::function_Ignore("zm_perk_vulture_aid");
	if(function_ToLower(function_GetDvarString("mapname")) != "zm_die")
	{
		namespace_system::function_Ignore("zm_perk_whoswho");
	}
	namespace_system::function_Ignore("phd_slider");
	namespace_system::function_Ignore("zm_perk_flopper");
	namespace_system::function_Ignore("zm_perk_elemental_pop");
	namespace_system::function_Ignore("zm_perk_utility");
	namespace_system::function_Ignore("zm_perk_commando");
	namespace_system::function_Ignore("zm_perk_explosivedamage");
	namespace_system::function_Ignore("zm_perk_extraammo");
	namespace_system::function_Ignore("zm_perk_hardline");
	namespace_system::function_Ignore("zm_perk_stoppingpower");
	namespace_system::function_Ignore("bandolier_bandit");
	namespace_system::function_Ignore("blaze_phase");
	namespace_system::function_Ignore("dying_wish");
	namespace_system::function_Ignore("ethereal_razor");
	namespace_system::function_Ignore("phd_slider");
	namespace_system::function_Ignore("stone_cold_stronghold");
	namespace_system::function_Ignore("timeslip");
	namespace_system::function_Ignore("victorious_tortoise");
	namespace_system::function_Ignore("winters_wail");
	namespace_system::function_Ignore("zombshell");
	namespace_system::function_Ignore("blood_wolf_bite");
	namespace_system::function_Ignore("zm_perk_wunderwonder2");
	namespace_system::function_Ignore("zm_perk_banana_colada");
	namespace_system::function_Ignore("zm_perk_bull_ice_blast");
	namespace_system::function_Ignore("zm_perk_crusaders_ale");
	namespace_system::function_Ignore("zm_perk_madgaz_moonshine");
	namespace_system::function_Ignore("zm_perk_wunderfizz2");
	namespace_system::function_Ignore("zm_perk_ffyl");
	namespace_system::function_Ignore("zm_perk_icu");
	namespace_system::function_Ignore("zm_perk_tactiquilla");
	namespace_system::function_Ignore("zm_perk_snails_pace");
	namespace_system::function_Ignore("zm_perk_cryo");
	namespace_system::function_Ignore("zm_perk_atomic_liqueur");
	namespace_system::function_Ignore("zm_perk_salvage_shake");
	namespace_system::function_Ignore("zm_perk_wind");
	namespace_system::function_Ignore("zm_perk_directionalfire");
	namespace_system::function_Ignore("zm_perk_combat_efficiency");
	namespace_system::function_Ignore("zm_perk_chugabud");
	namespace_system::function_Ignore("zm_perk_flopper");
	namespace_system::function_Ignore("zm_perk_random_new");
	namespace_system::function_Ignore("zm_perk_dying_wish");
	namespace_system::function_Ignore("zm_perk_regenammo");
	namespace_system::function_Ignore("zm_perk_tortoise");
	namespace_system::function_Ignore("zm_perk_random");
	namespace_system::function_Ignore("zm_perk_trailblazers");
	namespace_system::function_Ignore("specialty_upgrades");
	namespace_system::function_Ignore("zm_weap_chrysalax");
	namespace_system::function_Ignore("zm_h1_hud");
	namespace_system::function_Ignore("zm_pregame_menu");
}

/*
	Name: function_main
	Namespace: namespace_load
	Checksum: 0x424F4353
	Offset: 0x2C98
	Size: 0x1B70
	Parameters: 0
	Flags: None
	Line Number: 184
*/
function function_main()
{
	level thread function_init_sounds();
	level thread function_custom_add_weapons();
	level thread function_2c470689();
	namespace_917c15bb::function_f3798296(function_GetWeapon("ray_gun"), 4.33);
	namespace_917c15bb::function_f3798296(function_GetWeapon("ray_gun_upgraded"), 4.33);
	namespace_917c15bb::function_f3798296(function_GetWeapon("shotgun_fullauto"), 4.33);
	namespace_917c15bb::function_f3798296(function_GetWeapon("shotgun_fullauto_upgraded"), 4.33);
	namespace_917c15bb::function_f3798296(function_GetWeapon("shotgun_pump"), 4);
	namespace_917c15bb::function_f3798296(function_GetWeapon("shotgun_pump_upgraded"), 4);
	namespace_917c15bb::function_f3798296(function_GetWeapon("shotgun_precision"), 4);
	namespace_917c15bb::function_f3798296(function_GetWeapon("shotgun_precision_upgraded"), 4);
	namespace_917c15bb::function_f3798296(function_GetWeapon("shotgun_semiauto"), 4);
	namespace_917c15bb::function_f3798296(function_GetWeapon("shotgun_semiauto_upgraded"), 4);
	namespace_917c15bb::function_f3798296(function_GetWeapon("ar_accurate"), 4.33);
	namespace_917c15bb::function_f3798296(function_GetWeapon("ar_accurate_upgraded"), 4.33);
	namespace_917c15bb::function_f3798296(function_GetWeapon("pistol_energy"), 3.33);
	namespace_917c15bb::function_f3798296(function_GetWeapon("pistol_energy_upgraded"), 3.33);
	namespace_917c15bb::function_f3798296(function_GetWeapon("smg_longrange"), 4.33);
	namespace_917c15bb::function_f3798296(function_GetWeapon("smg_longrange_upgraded"), 4.33);
	namespace_917c15bb::function_f3798296(function_GetWeapon("ar_standard"), 4);
	namespace_917c15bb::function_f3798296(function_GetWeapon("ar_standard_upgraded"), 4);
	namespace_917c15bb::function_f3798296(function_GetWeapon("ar_m16"), 4);
	namespace_917c15bb::function_f3798296(function_GetWeapon("ar_m16_upgraded"), 4);
	namespace_917c15bb::function_f3798296(function_GetWeapon("ar_an94"), 4);
	namespace_917c15bb::function_f3798296(function_GetWeapon("ar_an94_upgraded"), 4);
	namespace_917c15bb::function_f3798296(function_GetWeapon("ar_fastburst"), 4);
	namespace_917c15bb::function_f3798296(function_GetWeapon("ar_fastburst_upgraded"), 4);
	namespace_917c15bb::function_f3798296(function_GetWeapon("ar_galil"), 4);
	namespace_917c15bb::function_f3798296(function_GetWeapon("ar_galil_upgraded"), 4);
	namespace_917c15bb::function_f3798296(function_GetWeapon("ar_stg44"), 4);
	namespace_917c15bb::function_f3798296(function_GetWeapon("ar_stg44_upgraded"), 4);
	namespace_917c15bb::function_f3798296(function_GetWeapon("pistol_standard"), 4.66);
	namespace_917c15bb::function_f3798296(function_GetWeapon("pistol_standard_upgraded"), 3.83);
	namespace_917c15bb::function_f3798296(function_GetWeapon("pistol_standardlh_upgraded"), 3.83);
	namespace_917c15bb::function_f3798296(function_GetWeapon("shotgun_energy"), 4.66);
	namespace_917c15bb::function_f3798296(function_GetWeapon("shotgun_energy_upgraded"), 3.83);
	namespace_917c15bb::function_f3798296(function_GetWeapon("shotgun_energy_ldw_upgraded"), 3.83);
	namespace_917c15bb::function_f3798296(function_GetWeapon("ar_marksman"), 4.33);
	namespace_917c15bb::function_f3798296(function_GetWeapon("ar_marksman_upgraded"), 4.33);
	namespace_917c15bb::function_f3798296(function_GetWeapon("pistol_fullauto"), 4.66);
	namespace_917c15bb::function_f3798296(function_GetWeapon("pistol_fullauto_upgraded"), 4.33);
	namespace_917c15bb::function_f3798296(function_GetWeapon("pistol_fullauto_ldw_upgraded"), 4.33);
	namespace_917c15bb::function_f3798296(function_GetWeapon("sniper_fastbolt"), 5.13);
	namespace_917c15bb::function_f3798296(function_GetWeapon("sniper_fastbolt_upgraded"), 5.13);
	namespace_917c15bb::function_f3798296(function_GetWeapon("sniper_powerbolt"), 3.5);
	namespace_917c15bb::function_f3798296(function_GetWeapon("sniper_powerbolt_upgraded"), 3.5);
	namespace_917c15bb::function_f3798296(function_GetWeapon("sniper_fastsemi"), 3.5);
	namespace_917c15bb::function_f3798296(function_GetWeapon("sniper_fastsemi_upgraded"), 3.5);
	namespace_917c15bb::function_f3798296(function_GetWeapon("ar_longburst"), 4.33);
	namespace_917c15bb::function_f3798296(function_GetWeapon("ar_longburst_upgraded"), 4.33);
	namespace_917c15bb::function_f3798296(function_GetWeapon("smg_capacity"), 4.66);
	namespace_917c15bb::function_f3798296(function_GetWeapon("smg_capacity_upgraded"), 4.66);
	namespace_917c15bb::function_f3798296(function_GetWeapon("smg_burst"), 5.16);
	namespace_917c15bb::function_f3798296(function_GetWeapon("smg_burst_upgraded"), 5.16);
	namespace_917c15bb::function_f3798296(function_GetWeapon("smg_thompson"), 4.33);
	namespace_917c15bb::function_f3798296(function_GetWeapon("smg_thompson_upgraded"), 4.33);
	namespace_917c15bb::function_f3798296(function_GetWeapon("smg_mp40"), 4);
	namespace_917c15bb::function_f3798296(function_GetWeapon("smg_mp40_upgraded"), 4);
	namespace_917c15bb::function_f3798296(function_GetWeapon("lmg_heavy"), 5.5);
	namespace_917c15bb::function_f3798296(function_GetWeapon("lmg_heavy_upgraded"), 5.5);
	namespace_917c15bb::function_f3798296(function_GetWeapon("lmg_rpk"), 5.5);
	namespace_917c15bb::function_f3798296(function_GetWeapon("lmg_rpk_upgraded"), 5.5);
	namespace_917c15bb::function_f3798296(function_GetWeapon("lmg_mg08"), 5.5);
	namespace_917c15bb::function_f3798296(function_GetWeapon("lmg_mg08_upgraded"), 5.5);
	namespace_917c15bb::function_f3798296(function_GetWeapon("launcher_standard"), 4);
	namespace_917c15bb::function_f3798296(function_GetWeapon("launcher_standard_upgraded"), 4);
	namespace_917c15bb::function_f3798296(function_GetWeapon("ar_damage"), 4);
	namespace_917c15bb::function_f3798296(function_GetWeapon("ar_damage_upgraded"), 4.33);
	namespace_917c15bb::function_f3798296(function_GetWeapon("smg_ppsh"), 4.1);
	namespace_917c15bb::function_f3798296(function_GetWeapon("smg_ppsh_upgraded"), 4.1);
	namespace_917c15bb::function_f3798296(function_GetWeapon("smg_fastfire"), 4.66);
	namespace_917c15bb::function_f3798296(function_GetWeapon("smg_fastfire_upgraded"), 4.66);
	namespace_917c15bb::function_f3798296(function_GetWeapon("smg_standard"), 3.5);
	namespace_917c15bb::function_f3798296(function_GetWeapon("smg_standard_upgraded"), 3.5);
	namespace_917c15bb::function_f3798296(function_GetWeapon("smg_versatile"), 3.53);
	namespace_917c15bb::function_f3798296(function_GetWeapon("smg_versatile_upgraded"), 3.53);
	namespace_917c15bb::function_f3798296(function_GetWeapon("pistol_burst"), 3.33);
	namespace_917c15bb::function_f3798296(function_GetWeapon("pistol_burst_upgraded"), 3.33);
	namespace_917c15bb::function_f3798296(function_GetWeapon("ar_cqb"), 6);
	namespace_917c15bb::function_f3798296(function_GetWeapon("ar_cqb_upgraded"), 6);
	namespace_917c15bb::function_f3798296(function_GetWeapon("smg_mp40_1940"), 4.66);
	namespace_917c15bb::function_f3798296(function_GetWeapon("smg_mp40_1940_upgraded"), 4.66);
	namespace_917c15bb::function_f3798296(function_GetWeapon("lmg_slowfire"), 10);
	namespace_917c15bb::function_f3798296(function_GetWeapon("lmg_slowfire_upgraded"), 10);
	namespace_917c15bb::function_f3798296(function_GetWeapon("t9_gallo_raygun"), 9);
	namespace_917c15bb::function_f3798296(function_GetWeapon("t9_gallo_raygun_up"), 9);
	namespace_917c15bb::function_f3798296(function_GetWeapon("t9_crossbow_skull"), 7.1);
	namespace_917c15bb::function_f3798296(function_GetWeapon("t9_crossbow_skull_up"), 7.1);
	level.var_7f38ec2c = 1;
	level.var_4f9a86e = 1;
	switch(function_ToLower(function_GetDvarString("mapname")))
	{
		case "zm_sumpf":
		{
			thread function_cc9df5b9((10485.6, 489.566, -660.875), (0, 0, 0));
			thread function_6536dcdc((10640.4, 669.7, -528.875), VectorScale((0, -1, 0), 155.116), (10128.4, 780.4, -660.875), VectorScale((0, -1, 0), 169.73), (10213.3, 877.135, -660.875), VectorScale((0, 1, 0), 37.36));
			break;
		}
	}
	level thread function_c3a3e63();
	namespace_zm_utility::function_register_tactical_grenade_for_level("octobomb");
	namespace_zm_utility::function_register_tactical_grenade_for_level("octobomb_upgraded");
	namespace_zm_utility::function_register_tactical_grenade_for_level("cymbal_monkey");
	namespace_zm_utility::function_register_tactical_grenade_for_level("cymbal_monkey_upgraded");
	function_SetDvar("fast_restart", 0);
	function_8b57c052("fast_restart", 0);
	function_SetDvar("scr_firstGumFree", 0);
	namespace_zm::function_init();
	level.var_7f38ec2c = 1;
	level.var_player_too_many_players_check = 0;
	level.var_do_randomized_zigzag_path = 1;
	namespace_Array::function_thread_all(function_GetEntArray("weapon_karosel", "targetname"), &function_8aadf265);
	namespace_Array::function_thread_all(function_GetEntArray("mxammo_trigger", "targetname"), &function_d9282b44);
	namespace_Array::function_thread_all(function_GetEntArray("perka", "targetname"), &function_5c46710d);
	namespace_Array::function_thread_all(function_GetEntArray("rampage_inducer", "targetname"), &function_7388bb1e);
	if(level.var_additionalprimaryweapon_limit != 3)
	{
		level.var_additionalprimaryweapon_limit = 3;
	}
	if(isdefined(level.var_bedf286b))
	{
		level.var_d1784d71 = 0;
		level.var_bedf286b = 2;
	}
	var_8612b812 = function_Array(function_GetWeapon("bouncingbetty"), function_GetWeapon("claymore"), function_GetWeapon("t6_claymore"), function_GetWeapon("idgun_0"), function_GetWeapon("idgun_1"), function_GetWeapon("idgun_2"), function_GetWeapon("idgun_3"), function_GetWeapon("idgun_upgraded_0"), function_GetWeapon("idgun_upgraded_1"), function_GetWeapon("idgun_upgraded_2"), function_GetWeapon("idgun_upgraded_3"));
	foreach(var_weapon in var_8612b812)
	{
		if(isdefined(level.var_zombie_weapons[var_weapon]))
		{
			level.var_zombie_weapons[var_weapon].var_is_in_box = 0;
		}
	}
	switch(function_ToLower(function_GetDvarString("mapname")))
	{
		case "zm_zod":
		{
			level.var_idgun_weapons[4] = function_GetWeapon("idgun_upgraded_0");
			level.var_idgun_weapons[5] = function_GetWeapon("idgun_upgraded_1");
			level.var_idgun_weapons[6] = function_GetWeapon("idgun_upgraded_2");
			level.var_idgun_weapons[7] = function_GetWeapon("idgun_upgraded_3");
			if(!isdefined(level.var_zombie_weapons["idgun_0"]))
			{
				level.var_zombie_weapons["idgun_0"].var_upgrade = function_GetWeapon("idgun_upgraded_0");
			}
			if(!isdefined(level.var_zombie_weapons["idgun_1"]))
			{
				level.var_zombie_weapons["idgun_1"].var_upgrade = function_GetWeapon("idgun_upgraded_1");
			}
			if(!isdefined(level.var_zombie_weapons["idgun_2"]))
			{
				level.var_zombie_weapons["idgun_2"].var_upgrade = function_GetWeapon("idgun_upgraded_2");
			}
			if(!isdefined(level.var_zombie_weapons["idgun_3"]))
			{
				level.var_zombie_weapons["idgun_3"].var_upgrade = function_GetWeapon("idgun_upgraded_3");
				break;
			}
		}
	}
	var_1a31d15 = function_Array("specialty_armorvest", "specialty_quickrevive", "specialty_fastreload", "specialty_doubletap2", "specialty_staminup", "specialty_additionalprimaryweapon", "specialty_deadshot", "specialty_widowswine", "specialty_electriccherry", "specialty_phdflopper", "specialty_tracker", "specialty_immunetriggerbetty", "specialty_extraammo", "specialty_immunetriggershock");
	namespace_zm_perks::function_perk_machine_removal("specialty_electriccherry");
	var_d952ddb7 = function_GetEntArray("zombie_vending", "targetname");
	if(var_d952ddb7.size > 1)
	{
		foreach(var_e3955304 in var_d952ddb7)
		{
			if(isdefined(var_e3955304.var_script_noteworthy) && !namespace_Array::function_contains(var_1a31d15, var_e3955304.var_script_noteworthy))
			{
				if(isdefined(var_e3955304.var_machine))
				{
					var_e3955304.var_machine.var_s_fxloc function_delete();
					var_e3955304.var_clip function_connectpaths();
					var_e3955304.var_clip function_delete();
					var_e3955304.var_bump function_delete();
					var_e3955304.var_machine function_delete();
					var_e3955304 function_TriggerEnable(0);
				}
				level.var__custom_perks = namespace_Array::function_remove_index(level.var__custom_perks, var_e3955304.var_script_noteworthy, 1);
			}
		}
	}
	level.var__loadStarted = 1;
	function_register_clientfields();
	level.var_aiTriggerSpawnFlags = function_getaitriggerflags();
	level.var_vehicleTriggerSpawnFlags = function_getvehicletriggerflags();
	level thread function_start_intro_screen_zm();
	function_setup_traversals();
	function_footsteps();
	namespace_system::function_wait_till("all");
	level thread function_art_review();
	level namespace_flagsys::function_set("load_main_complete");
	level.var_pack_a_punch_camo_index = 1;
	level.var_pack_a_punch_camo_index_number_variants = 1;
	level thread function_4cc8861a(32, 4);
	thread function_c0e61153();
	thread function_33d4c919();
	namespace_callback::function_on_connect(&function_on_player_connect);
	level thread function_f5928133();
	level thread function_2d6d3f14();
	level thread function_67347928();
}

/*
	Name: function_on_player_connect
	Namespace: namespace_load
	Checksum: 0x424F4353
	Offset: 0x4810
	Size: 0x8
	Parameters: 0
	Flags: None
	Line Number: 398
*/
function function_on_player_connect()
{
	return;
	ERROR: Exception occured: Stack empty.
}

/*
	Name: function_ced4a98f
	Namespace: namespace_load
	Checksum: 0x424F4353
	Offset: 0x4820
	Size: 0xF0
	Parameters: 0
	Flags: None
	Line Number: 414
*/
function function_ced4a98f()
{
	self endon("hash_disconnect");
	self.var_89a989c2 = 0;
	for(;;)
	{
		var_ret = self namespace_util::function_waittill_any_return("jump_begin", "jump_end");
		switch(var_ret)
		{
			case "jump_begin":
			{
				self function_setdoublejumpenergy(0);
				self function_7c34e9c7(0);
				self.var_89a989c2 = 1;
				break;
			}
			case "jump_end":
			{
				self function_setdoublejumpenergy(1);
				self function_7c34e9c7(1);
				self.var_89a989c2 = 0;
				break;
			}
		}
	}
	return;
}

/*
	Name: function_67347928
	Namespace: namespace_load
	Checksum: 0x424F4353
	Offset: 0x4918
	Size: 0x290
	Parameters: 0
	Flags: None
	Line Number: 452
*/
function function_67347928()
{
	level waittill("hash_all_players_connected");
	var_str_trig = function_spawn("trigger_radius", (0, 0, 0), 0, 16, 16);
	var_str_trig function_SetInvisibleToAll();
	function_b24346e3(var_str_trig, &"ZOMBIE_PERK_ADDITIONALPRIMARYWEAPON", 4000);
	function_b24346e3(var_str_trig, &"ZOMBIE_PERK_CHUGABUD", 2000);
	function_b24346e3(var_str_trig, &"ZOMBIE_PERK_DEADSHOT", 1500);
	function_b24346e3(var_str_trig, &"ZOMBIE_PERK_DIVETONUKE", 2000);
	function_b24346e3(var_str_trig, &"ZOMBIE_PERK_DOUBLETAP", 2000);
	function_b24346e3(var_str_trig, &"ZOMBIE_PERK_FASTRELOAD", 3000);
	function_b24346e3(var_str_trig, &"ZOMBIE_PERK_JUGGERNAUT", 2500);
	function_b24346e3(var_str_trig, &"ZOMBIE_PERK_MARATHON", 2000);
	function_b24346e3(var_str_trig, &"ZOMBIE_PERK_PACKAPUNCH", 5000);
	function_b24346e3(var_str_trig, &"ZOMBIE_PERK_PACKAPUNCH", 1000);
	function_b24346e3(var_str_trig, &"ZOMBIE_PERK_PACKAPUNCH_AAT", 2500);
	function_b24346e3(var_str_trig, &"ZOMBIE_PERK_PACKAPUNCH_AAT", 500);
	function_b24346e3(var_str_trig, &"ZOMBIE_PERK_QUICKREVIVE", 1500);
	function_b24346e3(var_str_trig, &"ZOMBIE_PERK_QUICKREVIVE", 500);
	function_b24346e3(var_str_trig, &"ZOMBIE_PERK_TOMBSTONE", 2000);
	function_b24346e3(var_str_trig, &"ZOMBIE_PERK_VULTURE", 3000);
	function_b24346e3(var_str_trig, &"ZOMBIE_PERK_WIDOWSWINE", 4000);
	var_str_trig function_delete();
}

/*
	Name: function_b24346e3
	Namespace: namespace_load
	Checksum: 0x424F4353
	Offset: 0x4BB0
	Size: 0x80
	Parameters: 3
	Flags: None
	Line Number: 487
*/
function function_b24346e3(var_str_trig, var_string, var_insert)
{
	if(!isdefined(var_insert))
	{
		var_insert = undefined;
	}
	if(!isdefined(var_insert))
	{
		var_str_trig function_setHintString(var_string);
	}
	else
	{
		var_str_trig function_setHintString(var_string, var_insert);
	}
	wait(0.05);
}

/*
	Name: function_6386b4b5
	Namespace: namespace_load
	Checksum: 0x424F4353
	Offset: 0x4C38
	Size: 0x128
	Parameters: 2
	Flags: None
	Line Number: 514
*/
function function_6386b4b5(var_str_trigger, var_str_sound)
{
	if(!isdefined(var_str_trigger))
	{
		var_str_trigger = "audio_bump_trigger";
	}
	if(!isdefined(var_str_sound))
	{
		var_str_sound = "zmb_perks_bump_bottle";
	}
	wait(1);
	level notify("hash_38b7cb9f");
	wait(5);
	var_a_t_audio = function_GetEntArray(var_str_trigger, "targetname");
	foreach(var_t_audio_bump in var_a_t_audio)
	{
		if(var_t_audio_bump.var_script_sound === var_str_sound)
		{
			namespace_zm_perks::function_spare_change();
		}
	}
}

/*
	Name: function_8aadf265
	Namespace: namespace_load
	Checksum: 0x424F4353
	Offset: 0x4D68
	Size: 0x20
	Parameters: 0
	Flags: None
	Line Number: 547
*/
function function_8aadf265()
{
	self function_delete();
}

/*
	Name: function_d9282b44
	Namespace: namespace_load
	Checksum: 0x424F4353
	Offset: 0x4D90
	Size: 0x20
	Parameters: 0
	Flags: None
	Line Number: 562
*/
function function_d9282b44()
{
	self function_delete();
}

/*
	Name: function_5c46710d
	Namespace: namespace_load
	Checksum: 0x424F4353
	Offset: 0x4DB8
	Size: 0x20
	Parameters: 0
	Flags: None
	Line Number: 577
*/
function function_5c46710d()
{
	self function_delete();
}

/*
	Name: function_7388bb1e
	Namespace: namespace_load
	Checksum: 0x424F4353
	Offset: 0x4DE0
	Size: 0x78
	Parameters: 0
	Flags: None
	Line Number: 592
*/
function function_7388bb1e()
{
	if(isdefined(self.var_s_unitrigger))
	{
		namespace_zm_unitrigger::function_unregister_unitrigger(self.var_s_unitrigger);
	}
	var_4650151 = function_GetEnt(self.var_target, "targetname");
	wait(1);
	self function_delete();
}

/*
	Name: function_ee438c1e
	Namespace: namespace_load
	Checksum: 0x424F4353
	Offset: 0x4E60
	Size: 0x38
	Parameters: 0
	Flags: None
	Line Number: 613
*/
function function_ee438c1e()
{
	self endon("hash_disconnect");
	for(;;)
	{
		self waittill("hash_994d5e9e", var_name, var_bgb);
	}
}

/*
	Name: function_2d6d3f14
	Namespace: namespace_load
	Checksum: 0x424F4353
	Offset: 0x4EA0
	Size: 0x240
	Parameters: 0
	Flags: None
	Line Number: 632
*/
function function_2d6d3f14()
{
	wait(4);
	for(;;)
	{
		wait(5);
		level.var__random_perk_machine_perk_list = [];
		wait(0.05);
		var_perk_list = function_Array("specialty_armorvest", "specialty_quickrevive", "specialty_fastreload", "specialty_doubletap2", "specialty_staminup", "specialty_additionalprimaryweapon", "specialty_deadshot", "specialty_widowswine", "specialty_electriccherry", "specialty_phdflopper", "specialty_tracker", "specialty_immunetriggerbetty", "specialty_extraammo", "specialty_immunetriggershock");
		foreach(var_perk in var_perk_list)
		{
			if(isdefined(level.var__custom_perks[var_perk]))
			{
				if(!isdefined(level.var_c0bbcc46[var_perk]))
				{
					namespace_3b1d1e1f::function_include_perk_in_random_rotation(var_perk);
				}
			}
		}
		var_cac83725 = function_Array("bonfire_sale", "perk_slot", "empty_bottle", "thunderstorm", "invincible", "time_warp", "bottomless_clip", "infinite_ammo");
		foreach(var_powerup in var_cac83725)
		{
			namespace_zm_powerups::function_powerup_remove_from_regular_drops(var_powerup);
		}
	}
}

/*
	Name: function_9161feac
	Namespace: namespace_load
	Checksum: 0x424F4353
	Offset: 0x50E8
	Size: 0x1B8
	Parameters: 0
	Flags: None
	Line Number: 669
*/
function function_9161feac()
{
	level.var_b_allow_idgun_pap = 1;
	level.var_idgun_weapons[5] = function_GetWeapon("idgun_upgraded_0");
	level.var_idgun_weapons[6] = function_GetWeapon("idgun_upgraded_1");
	level.var_idgun_weapons[7] = function_GetWeapon("idgun_upgraded_2");
	level.var_idgun_weapons[8] = function_GetWeapon("idgun_upgraded_3");
	if(level.var_script == "zm_tomb")
	{
		thread function_6811a318();
		level.var_chest_joker_custom_movement = &function_custom_joker_movement;
		level.var_pack_a_punch.var_move_out_func = &function_7c03764f;
		level.var_pack_a_punch.var_move_in_func = &function_924c2652;
		level.var_pack_a_punch.var_power_on_callback = &function_1c485da4;
	}
	if(level.var_script == "zm_moon")
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
	Namespace: namespace_load
	Checksum: 0x424F4353
	Offset: 0x52A8
	Size: 0x48
	Parameters: 0
	Flags: None
	Line Number: 705
*/
function function_dfd3d160()
{
	level waittill("hash_f938585a");
	var_426658d = function_AddTestClient();
	wait(1);
	wait(1);
	wait(1);
}

/*
	Name: function_33d4c919
	Namespace: namespace_load
	Checksum: 0x424F4353
	Offset: 0x52F8
	Size: 0x78
	Parameters: 0
	Flags: None
	Line Number: 724
*/
function function_33d4c919()
{
	while(1)
	{
		level waittill("hash_start_of_round");
		if(level.var_round_number < 12)
		{
			function_SetDvar("r_maxSpotShadowUpdates", "12");
		}
		else
		{
			function_SetDvar("r_maxSpotShadowUpdates", "8");
		}
	}
}

/*
	Name: function_footsteps
	Namespace: namespace_load
	Checksum: 0x424F4353
	Offset: 0x5378
	Size: 0x240
	Parameters: 0
	Flags: None
	Line Number: 750
*/
function function_footsteps()
{
	if(isdefined(level.var_FX_exclude_footsteps) && level.var_FX_exclude_footsteps)
	{
		return;
	}
	namespace_zombie_utility::function_setFootstepEffect("asphalt", "_t6/bio/player/fx_footstep_dust");
	namespace_zombie_utility::function_setFootstepEffect("brick", "_t6/bio/player/fx_footstep_dust");
	namespace_zombie_utility::function_setFootstepEffect("carpet", "_t6/bio/player/fx_footstep_dust");
	namespace_zombie_utility::function_setFootstepEffect("cloth", "_t6/bio/player/fx_footstep_dust");
	namespace_zombie_utility::function_setFootstepEffect("concrete", "_t6/bio/player/fx_footstep_dust");
	namespace_zombie_utility::function_setFootstepEffect("dirt", "_t6/bio/player/fx_footstep_sand");
	namespace_zombie_utility::function_setFootstepEffect("foliage", "_t6/bio/player/fx_footstep_sand");
	namespace_zombie_utility::function_setFootstepEffect("gravel", "_t6/bio/player/fx_footstep_dust");
	namespace_zombie_utility::function_setFootstepEffect("grass", "_t6/bio/player/fx_footstep_dust");
	namespace_zombie_utility::function_setFootstepEffect("metal", "_t6/bio/player/fx_footstep_dust");
	namespace_zombie_utility::function_setFootstepEffect("mud", "_t6/bio/player/fx_footstep_mud");
	namespace_zombie_utility::function_setFootstepEffect("paper", "_t6/bio/player/fx_footstep_dust");
	namespace_zombie_utility::function_setFootstepEffect("plaster", "_t6/bio/player/fx_footstep_dust");
	namespace_zombie_utility::function_setFootstepEffect("rock", "_t6/bio/player/fx_footstep_dust");
	namespace_zombie_utility::function_setFootstepEffect("sand", "_t6/bio/player/fx_footstep_sand");
	namespace_zombie_utility::function_setFootstepEffect("water", "_t6/bio/player/fx_footstep_water");
	namespace_zombie_utility::function_setFootstepEffect("wood", "_t6/bio/player/fx_footstep_dust");
}

/*
	Name: function_setup_traversals
	Namespace: namespace_load
	Checksum: 0x424F4353
	Offset: 0x55C0
	Size: 0x8
	Parameters: 0
	Flags: None
	Line Number: 785
*/
function function_setup_traversals()
{
}

/*
	Name: function_start_intro_screen_zm
	Namespace: namespace_load
	Checksum: 0x424F4353
	Offset: 0x55D0
	Size: 0x98
	Parameters: 0
	Flags: None
	Line Number: 799
*/
function function_start_intro_screen_zm()
{
	var_players = function_GetPlayers();
	for(var_i = 0; var_i < var_players.size; var_i++)
	{
		var_players[var_i] namespace_LUI::function_screen_fade_out(0, undefined);
		var_players[var_i] function_FreezeControls(1);
	}
	wait(1);
}

/*
	Name: function_register_clientfields
	Namespace: namespace_load
	Checksum: 0x424F4353
	Offset: 0x5670
	Size: 0xC8
	Parameters: 0
	Flags: None
	Line Number: 820
*/
function function_register_clientfields()
{
	namespace_clientfield::function_register("allplayers", "zmbLastStand", 1, 1, "int");
	namespace_clientfield::function_register("clientuimodel", "zmhud.swordEnergy", 1, 7, "float");
	namespace_clientfield::function_register("clientuimodel", "zmhud.swordState", 1, 4, "int");
	namespace_clientfield::function_register("clientuimodel", "zmhud.swordChargeUpdate", 1, 1, "counter");
}

/*
	Name: function_custom_add_weapons
	Namespace: namespace_load
	Checksum: 0x424F4353
	Offset: 0x5740
	Size: 0x80
	Parameters: 0
	Flags: None
	Line Number: 838
*/
function function_custom_add_weapons()
{
	namespace_zm_weapons::function_load_weapon_spec_from_table("gamedata/weapons/zm/zm_qol_mod_weapons.csv", 1);
	switch(function_ToLower(function_GetDvarString("mapname")))
	{
		case "zm_zod":
		{
			namespace_zm_weapons::function_load_weapon_spec_from_table("gamedata/weapons/zm/zm_zod_qol_weapons.csv", 1);
			break;
		}
	}
}

/*
	Name: function_checkStringValid
	Namespace: namespace_load
	Checksum: 0x424F4353
	Offset: 0x57C8
	Size: 0x28
	Parameters: 1
	Flags: None
	Line Number: 861
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
	Name: function_b276244f
	Namespace: namespace_load
	Checksum: 0x424F4353
	Offset: 0x57F8
	Size: 0x148
	Parameters: 0
	Flags: None
	Line Number: 880
*/
function function_b276244f()
{
	var_index = 1;
	var_table = "gamedata/weapons/weapon_delete_from_box.csv";
	level.var_6849ec14 = [];
	for(var_row = function_TableLookupRow(var_table, var_index); isdefined(var_row); var_row = function_TableLookupRow(var_table, var_index))
	{
		var_weapon_name = function_checkStringValid(var_row[0]);
		var_5b7ff18 = function_checkStringValid(var_row[1]);
		var_struct = function_spawnstruct();
		var_struct.var_weapon_name = var_weapon_name;
		if(isdefined(var_5b7ff18))
		{
			var_struct.var_5b7ff18 = var_5b7ff18;
		}
		level.var_6849ec14[var_weapon_name] = var_struct;
		var_index++;
	}
}

/*
	Name: function_2c470689
	Namespace: namespace_load
	Checksum: 0x424F4353
	Offset: 0x5948
	Size: 0x140
	Parameters: 0
	Flags: None
	Line Number: 910
*/
function function_2c470689()
{
	var_index = 1;
	var_table = "gamedata/weapons/weapon_uem_list.csv";
	level.var_7a0bbec5 = [];
	for(var_row = function_TableLookupRow(var_table, var_index); isdefined(var_row); var_row = function_TableLookupRow(var_table, var_index))
	{
		var_weapon_name = function_checkStringValid(var_row[0]);
		var_weapon_base = function_checkStringValid(var_row[1]);
		var_struct = function_spawnstruct();
		var_struct.var_weapon_name = var_weapon_name;
		var_struct.var_weapon_base = var_weapon_base;
		level.var_7a0bbec5[var_weapon_name] = var_struct;
		var_index++;
	}
	return;
	return function_TableLookupRow(var_table, var_index);
}

/*
	Name: function_c3a3e63
	Namespace: namespace_load
	Checksum: 0x424F4353
	Offset: 0x5A90
	Size: 0x6E0
	Parameters: 0
	Flags: Private
	Line Number: 939
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
	var_1291a337 = namespace_struct::function_get_array("claymore_purchase", "targetname");
	if(var_1291a337.size > 1)
	{
		foreach(var_wallbuy in var_1291a337)
		{
			switch(var_wallbuy.var_zombie_weapon_upgrade)
			{
				case "bouncingbetty":
				{
					var_wallbuy function_MoveZ(var_wallbuy.var_origin - VectorScale((0, 0, 1), 1000), 0.1);
					var_wallbuy.var_trigger_stub.var_origin = var_wallbuy.var_origin - VectorScale((0, 0, 1), 1000);
					wait(0.05);
					var_wallbuy namespace_struct::function_delete();
					break;
				}
			}
		}
	}
	wait(0.05);
	level namespace_flag::function_wait_till("initial_blackscreen_passed");
	while(!isdefined(level.var_7a0bbec5))
	{
		wait(0.05);
	}
	wait(1);
	foreach(var_weapon in level.var_7a0bbec5)
	{
		level.var_zombie_weapons[function_GetWeapon(var_weapon.var_weapon_base)].var_is_in_box = 1;
	}
	wait(1);
	foreach(var_weapon in function_getArrayKeys(level.var_zombie_weapons))
	{
		if(var_weapon.var_name == "idgun_0" || var_weapon.var_name == "idgun_1" || var_weapon.var_name == "idgun_2" || var_weapon.var_name == "idgun_3" || var_weapon.var_name == "idgun_upgraded_0" || var_weapon.var_name == "idgun_upgraded_1" || var_weapon.var_name == "idgun_upgraded_2" || var_weapon.var_name == "idgun_upgraded_3" || var_weapon.var_name == "idgun_genesis_0" || var_weapon.var_name == "idgun_genesis_0_upgraded")
		{
			if(level.var_zombie_weapons[var_weapon].var_is_in_box == 1)
			{
				if(!function_ToLower(function_GetDvarString("mapname")) == "zm_genesis")
				{
					level.var_e7e4be0e = 1;
				}
			}
		}
	}
	wait(1);
	var_8612b812 = function_Array(function_GetWeapon("special_bfg"), function_GetWeapon("special_bfg_upgraded"), function_GetWeapon("t9_me_knife_american"), function_GetWeapon("hero_gravityspikes_melee"), function_GetWeapon("bowie_knife"), function_GetWeapon("zod_riotshield"), function_GetWeapon("knife"), function_GetWeapon("frag_grenade"));
	foreach(var_weapon in var_8612b812)
	{
		if(isdefined(level.var_zombie_weapons[var_weapon]))
		{
			level.var_zombie_weapons[var_weapon].var_is_in_box = 0;
		}
	}
	for(;;)
	{
		var_d8c285e2 = function_Array(function_GetWeapon("pistol_standard"), function_GetWeapon("pistol_burst"), function_GetWeapon("pistol_fullauto"));
		foreach(var_weapon in var_d8c285e2)
		{
			function_ArrayRemoveValue(level.var_aat_exemptions, var_weapon);
		}
		wait(5);
	}
}

/*
	Name: function_b400349f
	Namespace: namespace_load
	Checksum: 0x424F4353
	Offset: 0x6178
	Size: 0xC8
	Parameters: 0
	Flags: None
	Line Number: 1022
*/
function function_b400349f()
{
	switch(function_ToLower(function_GetDvarString("mapname")))
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
	Namespace: namespace_load
	Checksum: 0x424F4353
	Offset: 0x6248
	Size: 0x130
	Parameters: 2
	Flags: Private
	Line Number: 1062
*/
function private function_cc9df5b9(var_origin, var_angles)
{
	var_f8d51566 = namespace_util::function_spawn_model("zmu_workbench", var_origin, var_angles);
	var_trigger = function_spawn("trigger_radius_use", var_origin + VectorScale((0, 0, 1), 40), 0, 64, 64);
	var_trigger function_setHintString("Craftable not available yet");
	var_trigger function_TriggerIgnoreTeam();
	var_trigger function_SetVisibleToAll();
	var_trigger function_UseTriggerRequireLookAt();
	var_trigger function_setcursorhint("HINT_NOICON");
	var_trigger.var_targetname = "craft_vineshield_zm_craftable_trigger";
	var_trigger.var_zombie_weapon_upgrade = "vine_shield";
}

/*
	Name: function_6536dcdc
	Namespace: namespace_load
	Checksum: 0x424F4353
	Offset: 0x6380
	Size: 0x1D0
	Parameters: 6
	Flags: None
	Line Number: 1085
*/
function function_6536dcdc(var_origin_1, var_ec82b4c9, var_origin_2, var_12852f32, var_544f0d11, var_3887a99b)
{
	for(var_i = 0; var_i < 3; var_i++)
	{
		if(var_i == 0)
		{
			var_struct = namespace_struct::function_spawn(var_origin_1, var_ec82b4c9);
			var_struct.var_angles = var_ec82b4c9;
		}
		else if(var_i == 1)
		{
			var_struct = namespace_struct::function_spawn(var_origin_2, var_12852f32);
			var_struct.var_angles = var_12852f32;
		}
		else
		{
			var_struct = namespace_struct::function_spawn(var_544f0d11, var_3887a99b);
			var_struct.var_angles = var_3887a99b;
		}
		var_struct.var_targetname = "craft_vineshield_zm_part_" + var_i;
		if(!isdefined(level.var_struct_class_names["targetname"]["craft_vineshield_zm_part_" + var_i]))
		{
			level.var_struct_class_names["targetname"]["craft_vineshield_zm_part_" + var_i] = [];
		}
		level.var_struct_class_names["targetname"]["craft_vineshield_zm_part_" + var_i][level.var_struct_class_names["targetname"]["craft_vineshield_zm_part_" + var_i].size] = var_struct;
	}
}

/*
	Name: function_f5928133
	Namespace: namespace_load
	Checksum: 0x424F4353
	Offset: 0x6558
	Size: 0x288
	Parameters: 0
	Flags: None
	Line Number: 1123
*/
function function_f5928133()
{
	wait(0.05);
	level namespace_flag::function_wait_till("initial_blackscreen_passed");
	level namespace_flag::function_wait_till("all_players_connected");
	if(function_GetPlayers().size > 4)
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
				var_bgb.var_unitrigger_stub.var_8b8a66cc function_setHintString("Gums are Disabled");
				var_bgb function_SetZBarrierPieceState(3, "closed");
			}
		}
	}
}

/*
	Name: function_c0e61153
	Namespace: namespace_load
	Checksum: 0x424F4353
	Offset: 0x67E8
	Size: 0x78
	Parameters: 0
	Flags: None
	Line Number: 1158
*/
function function_c0e61153()
{
	level endon("hash_end_game");
	wait(0.05);
	level namespace_flag::function_wait_till("initial_blackscreen_passed");
	level.var_842626f0 = level.var__custom_perks.size;
	while(!isdefined(level.var_machine_assets))
	{
		wait(0.05);
	}
	for(;;)
	{
		wait(20);
		level.var_perk_purchase_limit = level.var_842626f0;
	}
}

/*
	Name: function_4cc8861a
	Namespace: namespace_load
	Checksum: 0x424F4353
	Offset: 0x6868
	Size: 0x6B8
	Parameters: 2
	Flags: None
	Line Number: 1185
*/
function function_4cc8861a(var_f8fb9f96, var_d3d8af77)
{
	level endon("hash_end_game");
	while(isdefined(self))
	{
		level namespace_util::function_waittill_any("end_of_round", "start_of_round");
		wait(0.2);
		namespace_zombie_utility::function_set_zombie_var("zombie_intermission_time", 120);
		if(level.var_bdc116e3 != 2)
		{
			level.var_DOG_HEALTH = 400 * level.var_round_number / 10 + 1;
		}
		level.var_e7a01594 = level.var_zombie_total;
		level.var_max_zombie_func = &namespace_zombie_utility::function_default_max_zombie_func;
		if(level.var_zombie_vars["zombie_max_ai"] != 24)
		{
			level.var_zombie_vars["zombie_max_ai"] = 24;
		}
		namespace_zombie_utility::function_set_zombie_var("zombie_ai_per_player", 6, 0);
		if(function_ToLower(function_GetDvarString("mapname")) == "zm_daybreak")
		{
			self thread function_f9e7d600();
		}
		if(level.var_round_number >= 10)
		{
			if(level.var_round_number >= 80)
			{
				namespace_zombie_utility::function_set_zombie_var("zombie_powerup_drop_max_per_round", 10);
			}
			else
			{
				namespace_zombie_utility::function_set_zombie_var("zombie_powerup_drop_max_per_round", 4 + function_Int(level.var_round_number / 10));
			}
		}
		else
		{
			namespace_zombie_utility::function_set_zombie_var("zombie_powerup_drop_max_per_round", 4);
		}
		level.var_55a7e1ae = 0;
		namespace_zombie_utility::function_set_zombie_var("zombie_health_increase", 100, 0);
		namespace_zombie_utility::function_set_zombie_var("zombie_health_increase_multiplier", 0.1, 1);
		namespace_zombie_utility::function_set_zombie_var("zombie_health_start", 150, 0);
		namespace_zombie_utility::function_set_zombie_var("player_base_health", 100);
		namespace_zombie_utility::function_set_zombie_var("penalty_no_revive", 0.1, 1);
		namespace_zombie_utility::function_set_zombie_var("penalty_died", 0, 1);
		namespace_zombie_utility::function_set_zombie_var("penalty_downed", 0.05, 1);
		namespace_zombie_utility::function_set_zombie_var("zombie_score_kill_4player", 50);
		namespace_zombie_utility::function_set_zombie_var("zombie_score_kill_3player", 50);
		namespace_zombie_utility::function_set_zombie_var("zombie_score_kill_2player", 50);
		namespace_zombie_utility::function_set_zombie_var("zombie_score_kill_1player", 50);
		namespace_zombie_utility::function_set_zombie_var("zombie_score_damage_normal", 10);
		namespace_zombie_utility::function_set_zombie_var("zombie_score_damage_light", 10);
		namespace_zombie_utility::function_set_zombie_var("zombie_score_bonus_melee", 80);
		namespace_zombie_utility::function_set_zombie_var("zombie_score_bonus_head", 50);
		namespace_zombie_utility::function_set_zombie_var("zombie_score_bonus_neck", 20);
		namespace_zombie_utility::function_set_zombie_var("zombie_score_bonus_torso", 10);
		namespace_zombie_utility::function_set_zombie_var("zombie_score_bonus_burn", 10);
		if(isdefined(level.var_affed9f4["zombie_max"]))
		{
			level.var_zombie_actor_limit = level.var_affed9f4["zombie_max"];
			level.var_zombie_ai_limit = level.var_affed9f4["zombie_max"];
		}
		else if(isdefined(level.var_679e1a9e) && level.var_679e1a9e)
		{
			level.var_zombie_actor_limit = var_f8fb9f96 + 8 + var_d3d8af77 * function_GetPlayers().size;
			level.var_zombie_ai_limit = var_f8fb9f96 + 8 + var_d3d8af77 * function_GetPlayers().size;
		}
		else
		{
			level.var_zombie_actor_limit = var_f8fb9f96 + var_d3d8af77 * function_GetPlayers().size;
			level.var_zombie_ai_limit = var_f8fb9f96 + var_d3d8af77 * function_GetPlayers().size;
		}
		if(level.var_bdc116e3 == 2)
		{
			level.var_zombie_vars["zombie_between_round_time"] = level.var_ee5d3b93;
			level.var_zombie_vars["zombie_move_speed_multiplier"] = 1;
			foreach(var_ai_enemy in function_GetAITeamArray("axis"))
			{
				var_ai_enemy namespace_zombie_utility::function_set_zombie_run_cycle_restore_from_override();
				var_ai_enemy namespace_zombie_utility::function_set_zombie_run_cycle_override_value("walk");
			}
		}
		function_SetDvar("player_shallowWaterWadeScale", 0.75);
		function_SetDvar("player_waistWaterWadeScale", 0.75);
	}
}

/*
	Name: function_f9e7d600
	Namespace: namespace_load
	Checksum: 0x424F4353
	Offset: 0x6F28
	Size: 0x60
	Parameters: 0
	Flags: None
	Line Number: 1282
*/
function function_f9e7d600()
{
	self notify("hash_23cdb28a");
	self endon("hash_23cdb28a");
	var_8ab5b3ba = namespace_zm::function_get_zombie_count_for_round(level.var_round_number, level.var_players.size);
	wait(0.1);
	level.var_zombie_total = var_8ab5b3ba;
	return;
}

/*
	Name: function_init_sounds
	Namespace: namespace_load
	Checksum: 0x424F4353
	Offset: 0x6F90
	Size: 0x2F8
	Parameters: 0
	Flags: None
	Line Number: 1302
*/
function function_init_sounds()
{
	if(0)
	{
		if(!isdefined(function_GetDvarInt("mutator_seasonalcontent")) || function_GetDvarInt("mutator_seasonalcontent") == 0)
		{
			while(isdefined(level.var_zombie_sounds))
			{
				wait(0.5);
			}
			if(isdefined(level.var_zombie_sounds["music_chest"]))
			{
				function_ArrayRemoveValue(level.var_zombie_sounds, level.var_zombie_sounds["music_chest"]);
				level.var_zombie_sounds["music_chest"] = "christmas_zmb_music_box";
			}
			namespace_zm_utility::function_add_sound("music_chest", "christmas_zmb_music_box");
			namespace_zm_utility::function_add_sound("music_chest_christmas", "christmas_zmb_music_box");
			while(!isdefined(level.var_zmAnnouncerVox))
			{
				wait(0.5);
			}
			var_55cde6bd = function_Array("carpenter", "insta_kill", "double_points", "nuke", "full_ammo", "fire_sale", "minigun");
			foreach(var_sound in level.var_zmAnnouncerVox)
			{
				if(namespace_Array::function_contains(level.var_zmAnnouncerVox, var_55cde6bd))
				{
					function_ArrayRemoveValue(var_sound, level.var_zmAnnouncerVox);
				}
			}
			namespace_zm_audio::function_sndAnnouncerVoxAdd("carpenter", "christmas_powerup_carpenter_0");
			namespace_zm_audio::function_sndAnnouncerVoxAdd("insta_kill", "christmas_powerup_instakill_0");
			namespace_zm_audio::function_sndAnnouncerVoxAdd("double_points", "christmas_powerup_doublepoints_0");
			namespace_zm_audio::function_sndAnnouncerVoxAdd("nuke", "christmas_powerup_nuke_0");
			namespace_zm_audio::function_sndAnnouncerVoxAdd("full_ammo", "christmas_powerup_maxammo_0");
			namespace_zm_audio::function_sndAnnouncerVoxAdd("fire_sale", "christmas_powerup_firesale_0");
			namespace_zm_audio::function_sndAnnouncerVoxAdd("minigun", "christmas_powerup_death_machine_0");
			return;
		}
	}
	ERROR: Exception occured: Stack empty.
	ERROR: Exception occured: Stack empty.
}

/*
	Name: function_35bd70cb
	Namespace: namespace_load
	Checksum: 0x424F4353
	Offset: 0x7290
	Size: 0x178
	Parameters: 6
	Flags: None
	Line Number: 1355
*/
function function_35bd70cb(var_origin, var_angle, var_perk, var_model, var_parameters, var_string)
{
	var_struct = namespace_struct::function_spawn(var_origin, var_angle);
	var_struct.var_angles = var_angle;
	var_struct.var_targetname = "zm_perk_machine";
	if(isdefined(var_perk))
	{
		var_struct.var_script_noteworthy = var_perk;
	}
	if(isdefined(var_parameters))
	{
		var_struct.var_script_parameters = var_parameters;
	}
	if(isdefined(var_model))
	{
		var_struct.var_model = var_model;
	}
	if(isdefined(var_string))
	{
		var_struct.var_script_string = var_string;
	}
	if(!isdefined(level.var_struct_class_names["targetname"]["zm_perk_machine"]))
	{
		level.var_struct_class_names["targetname"]["zm_perk_machine"] = [];
	}
	level.var_struct_class_names["targetname"]["zm_perk_machine"][level.var_struct_class_names["targetname"]["zm_perk_machine"].size] = var_struct;
	return var_struct;
}

/*
	Name: function_347f929f
	Namespace: namespace_load
	Checksum: 0x424F4353
	Offset: 0x7410
	Size: 0x50
	Parameters: 0
	Flags: None
	Line Number: 1394
*/
function function_347f929f()
{
	level endon("hash_end_game");
	wait(0.1);
	function_ArrayRemoveValue(level.var__limited_equipment, function_GetWeapon("equip_hacker"));
}

/*
	Name: function_5e7a117f
	Namespace: namespace_load
	Checksum: 0x424F4353
	Offset: 0x7468
	Size: 0xD0
	Parameters: 0
	Flags: None
	Line Number: 1411
*/
function function_5e7a117f()
{
	switch(level.var_script)
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
	Namespace: namespace_load
	Checksum: 0x424F4353
	Offset: 0x7540
	Size: 0xBE8
	Parameters: 0
	Flags: None
	Line Number: 1478
*/
function function_92907761()
{
	self function_closeInGameMenu();
	self function_CloseMenu("StartMenu_Main");
	self notify("hash_player_intermission");
	self endon("hash_player_intermission");
	level endon("hash_stop_intermission");
	self endon("hash_disconnect");
	self endon("hash_death");
	self notify("hash__zombie_game_over");
	self.var_score = self.var_score_total;
	var_points = namespace_struct::function_get_array("intermission", "targetname");
	var_points = namespace_Array::function_randomize(var_points);
	self namespace_zm_utility::function_create_streamer_hint(var_points[0].var_origin, var_points[0].var_angles, 0.9);
	self.var_2826e2d5 = function_spawn("script_model", var_points[0].var_origin);
	self.var_2826e2d5 function_SetModel("tag_origin");
	self.var_2826e2d5.var_angles = var_points[0].var_angles;
	wait(1);
	self thread namespace_LUI::function_screen_fade_out(0.5);
	self.var_game_over function_fadeOverTime(0.5);
	self.var_game_over.var_alpha = 0;
	self.var_1a914bcc function_fadeOverTime(0.5);
	self.var_1a914bcc.var_alpha = 0;
	wait(0.5);
	self.var_spectatorclient = -1;
	self.var_killcamentity = -1;
	self.var_archivetime = 0;
	self.var_psOffsetTime = 0;
	self.var_friendlydamage = undefined;
	var_target_point = namespace_struct::function_get(var_points[0].var_target, "targetname");
	var_speed = 20;
	if(isdefined(self.var__health_overlay))
	{
		self.var__health_overlay function_SetShader("overlay_low_health", 0, 0);
	}
	namespace_visionset_mgr::function_deactivate("visionset", "zombie_death", self);
	self function_FreezeControls(0);
	self function_AllowAds(0);
	self function_CameraSetPosition(self.var_2826e2d5);
	self function_CameraSetLookAt();
	self function_CameraActivate(1);
	var_dist = function_Distance(var_points[0].var_origin, var_target_point.var_origin);
	var_time = var_dist / var_speed;
	var_q_time = var_time * 0.25;
	if(var_q_time > 1)
	{
		var_q_time = 1;
	}
	self notify("hash_player_intermission_spawned");
	self thread namespace_zm::function_screen_fade_in(2);
	self.var_game_over function_fadeOverTime(2);
	self.var_game_over.var_alpha = 1;
	self.var_1a914bcc function_fadeOverTime(2);
	self.var_1a914bcc.var_alpha = 1;
	var_time = 13;
	self.var_2826e2d5 function_moveto(var_target_point.var_origin, var_time, var_q_time, var_q_time);
	self.var_2826e2d5 function_RotateTo(var_target_point.var_angles, var_time, var_q_time, var_q_time);
	self namespace_zm_utility::function_create_streamer_hint(var_points[1].var_origin, var_points[1].var_angles, 0.9);
	self.var_9dbb2ccd = function_spawn("script_model", var_points[1].var_origin);
	self.var_9dbb2ccd function_SetModel("tag_origin");
	self.var_9dbb2ccd.var_angles = var_points[1].var_angles;
	var_f2d89fc = namespace_struct::function_get(var_points[1].var_target, "targetname");
	wait(5);
	self thread namespace_LUI::function_screen_fade_out(0.5);
	self.var_game_over function_fadeOverTime(0.5);
	self.var_game_over.var_alpha = 0;
	self.var_1a914bcc function_fadeOverTime(0.5);
	self.var_1a914bcc.var_alpha = 0;
	var_speed = 20;
	var_dist = function_Distance(var_points[1].var_origin, var_target_point.var_origin);
	var_time = var_dist / var_speed;
	var_q_time = var_time * 0.25;
	if(var_q_time > 1)
	{
		var_q_time = 1;
	}
	wait(0.5);
	self function_CameraSetPosition(self.var_9dbb2ccd);
	self thread namespace_zm::function_screen_fade_in(2);
	self.var_game_over function_fadeOverTime(2);
	self.var_game_over.var_alpha = 1;
	self.var_1a914bcc function_fadeOverTime(2);
	self.var_1a914bcc.var_alpha = 1;
	self.var_2826e2d5 function_delete();
	var_time = 13;
	self.var_9dbb2ccd function_moveto(var_f2d89fc.var_origin, var_time, var_q_time, var_q_time);
	self.var_9dbb2ccd function_RotateTo(var_f2d89fc.var_angles, var_time, var_q_time, var_q_time);
	self namespace_zm_utility::function_create_streamer_hint(var_points[2].var_origin, var_points[2].var_angles, 0.9);
	self.var_77b8b264 = function_spawn("script_model", var_points[2].var_origin);
	self.var_77b8b264 function_SetModel("tag_origin");
	self.var_77b8b264.var_angles = var_points[2].var_angles;
	var_f2d89fc = namespace_struct::function_get(var_points[2].var_target, "targetname");
	wait(5);
	self thread namespace_LUI::function_screen_fade_out(0.5);
	self.var_game_over function_fadeOverTime(0.5);
	self.var_game_over.var_alpha = 0;
	self.var_1a914bcc function_fadeOverTime(0.5);
	self.var_1a914bcc.var_alpha = 0;
	var_speed = 20;
	var_dist = function_Distance(var_points[2].var_origin, var_target_point.var_origin);
	var_time = var_dist / var_speed;
	var_q_time = var_time * 0.25;
	if(var_q_time > 1)
	{
		var_q_time = 1;
	}
	wait(0.5);
	self function_CameraSetPosition(self.var_77b8b264);
	self thread namespace_zm::function_screen_fade_in(2);
	self.var_game_over function_fadeOverTime(2);
	self.var_game_over.var_alpha = 1;
	self.var_1a914bcc function_fadeOverTime(2);
	self.var_1a914bcc.var_alpha = 1;
	self.var_9dbb2ccd function_delete();
	var_time = 13;
	self.var_77b8b264 function_moveto(var_f2d89fc.var_origin, var_time, var_q_time, var_q_time);
	self.var_77b8b264 function_RotateTo(var_f2d89fc.var_angles, var_time, var_q_time, var_q_time);
	wait(5);
	self thread namespace_LUI::function_screen_fade_out(1);
	self.var_game_over function_fadeOverTime(1);
	self.var_game_over.var_alpha = 0;
	self.var_1a914bcc function_fadeOverTime(1);
	self.var_1a914bcc.var_alpha = 0;
	wait(1);
}

/*
	Name: function_ffdcb0bb
	Namespace: namespace_load
	Checksum: 0x424F4353
	Offset: 0x8130
	Size: 0xBE8
	Parameters: 0
	Flags: None
	Line Number: 1614
*/
function function_ffdcb0bb()
{
	self function_closeInGameMenu();
	self function_CloseMenu("StartMenu_Main");
	self notify("hash_player_intermission");
	self endon("hash_player_intermission");
	level endon("hash_stop_intermission");
	self endon("hash_disconnect");
	self endon("hash_death");
	self notify("hash__zombie_game_over");
	self.var_score = self.var_score_total;
	var_points = namespace_struct::function_get_array("intermission", "targetname");
	var_points = namespace_Array::function_randomize(var_points);
	self namespace_zm_utility::function_create_streamer_hint(var_points[0].var_origin, var_points[0].var_angles, 0.9);
	self.var_2826e2d5 = function_spawn("script_model", var_points[0].var_origin);
	self.var_2826e2d5 function_SetModel("tag_origin");
	self.var_2826e2d5.var_angles = var_points[0].var_angles;
	wait(1);
	self thread namespace_LUI::function_screen_fade_out(0.5);
	self.var_game_over function_fadeOverTime(0.5);
	self.var_game_over.var_alpha = 0;
	self.var_1a914bcc function_fadeOverTime(0.5);
	self.var_1a914bcc.var_alpha = 0;
	wait(0.5);
	self.var_spectatorclient = -1;
	self.var_killcamentity = -1;
	self.var_archivetime = 0;
	self.var_psOffsetTime = 0;
	self.var_friendlydamage = undefined;
	var_target_point = namespace_struct::function_get(var_points[0].var_target, "targetname");
	var_speed = 20;
	if(isdefined(self.var__health_overlay))
	{
		self.var__health_overlay function_SetShader("overlay_low_health", 0, 0);
	}
	namespace_visionset_mgr::function_deactivate("visionset", "zombie_death", self);
	self function_FreezeControls(0);
	self function_AllowAds(0);
	self function_CameraSetPosition(self.var_2826e2d5);
	self function_CameraSetLookAt();
	self function_CameraActivate(1);
	var_dist = function_Distance(var_points[0].var_origin, var_target_point.var_origin);
	var_time = var_dist / var_speed;
	var_q_time = var_time * 0.25;
	if(var_q_time > 1)
	{
		var_q_time = 1;
	}
	self notify("hash_player_intermission_spawned");
	self thread namespace_zm::function_screen_fade_in(2);
	self.var_game_over function_fadeOverTime(2);
	self.var_game_over.var_alpha = 1;
	self.var_1a914bcc function_fadeOverTime(2);
	self.var_1a914bcc.var_alpha = 1;
	var_time = 10;
	self.var_2826e2d5 function_moveto(var_target_point.var_origin, var_time, var_q_time, var_q_time);
	self.var_2826e2d5 function_RotateTo(var_target_point.var_angles, var_time, var_q_time, var_q_time);
	self namespace_zm_utility::function_create_streamer_hint(var_points[1].var_origin, var_points[1].var_angles, 0.9);
	self.var_9dbb2ccd = function_spawn("script_model", var_points[1].var_origin);
	self.var_9dbb2ccd function_SetModel("tag_origin");
	self.var_9dbb2ccd.var_angles = var_points[1].var_angles;
	var_f2d89fc = namespace_struct::function_get(var_points[1].var_target, "targetname");
	wait(5);
	self thread namespace_LUI::function_screen_fade_out(0.5);
	self.var_game_over function_fadeOverTime(0.5);
	self.var_game_over.var_alpha = 0;
	self.var_1a914bcc function_fadeOverTime(0.5);
	self.var_1a914bcc.var_alpha = 0;
	var_speed = 20;
	var_dist = function_Distance(var_points[1].var_origin, var_target_point.var_origin);
	var_time = var_dist / var_speed;
	var_q_time = var_time * 0.25;
	if(var_q_time > 1)
	{
		var_q_time = 1;
	}
	wait(0.5);
	self function_CameraSetPosition(self.var_9dbb2ccd);
	self thread namespace_zm::function_screen_fade_in(2);
	self.var_game_over function_fadeOverTime(2);
	self.var_game_over.var_alpha = 1;
	self.var_1a914bcc function_fadeOverTime(2);
	self.var_1a914bcc.var_alpha = 1;
	self.var_2826e2d5 function_delete();
	var_time = 10;
	self.var_9dbb2ccd function_moveto(var_f2d89fc.var_origin, var_time, var_q_time, var_q_time);
	self.var_9dbb2ccd function_RotateTo(var_f2d89fc.var_angles, var_time, var_q_time, var_q_time);
	self namespace_zm_utility::function_create_streamer_hint(var_points[2].var_origin, var_points[2].var_angles, 0.9);
	self.var_77b8b264 = function_spawn("script_model", var_points[2].var_origin);
	self.var_77b8b264 function_SetModel("tag_origin");
	self.var_77b8b264.var_angles = var_points[2].var_angles;
	var_f2d89fc = namespace_struct::function_get(var_points[2].var_target, "targetname");
	wait(5);
	self thread namespace_LUI::function_screen_fade_out(0.5);
	self.var_game_over function_fadeOverTime(0.5);
	self.var_game_over.var_alpha = 0;
	self.var_1a914bcc function_fadeOverTime(0.5);
	self.var_1a914bcc.var_alpha = 0;
	var_speed = 20;
	var_dist = function_Distance(var_points[2].var_origin, var_target_point.var_origin);
	var_time = var_dist / var_speed;
	var_q_time = var_time * 0.25;
	if(var_q_time > 1)
	{
		var_q_time = 1;
	}
	wait(0.5);
	self function_CameraSetPosition(self.var_77b8b264);
	self thread namespace_zm::function_screen_fade_in(2);
	self.var_game_over function_fadeOverTime(2);
	self.var_game_over.var_alpha = 1;
	self.var_1a914bcc function_fadeOverTime(2);
	self.var_1a914bcc.var_alpha = 1;
	self.var_9dbb2ccd function_delete();
	var_time = 10;
	self.var_77b8b264 function_moveto(var_f2d89fc.var_origin, var_time, var_q_time, var_q_time);
	self.var_77b8b264 function_RotateTo(var_f2d89fc.var_angles, var_time, var_q_time, var_q_time);
	wait(5);
	self thread namespace_LUI::function_screen_fade_out(1);
	self.var_game_over function_fadeOverTime(1);
	self.var_game_over.var_alpha = 0;
	self.var_1a914bcc function_fadeOverTime(1);
	self.var_1a914bcc.var_alpha = 0;
	wait(1);
}

/*
	Name: function_23b01d28
	Namespace: namespace_load
	Checksum: 0x424F4353
	Offset: 0x8D20
	Size: 0x8F0
	Parameters: 0
	Flags: None
	Line Number: 1750
*/
function function_23b01d28()
{
	self function_closeInGameMenu();
	self function_CloseMenu("StartMenu_Main");
	self notify("hash_player_intermission");
	self endon("hash_player_intermission");
	level endon("hash_stop_intermission");
	self endon("hash_disconnect");
	self endon("hash_death");
	self notify("hash__zombie_game_over");
	self.var_score = self.var_score_total;
	var_points = namespace_struct::function_get_array("intermission", "targetname");
	self namespace_zm_utility::function_create_streamer_hint(var_points[0].var_origin, var_points[0].var_angles, 0.9);
	self.var_2826e2d5 = function_spawn("script_model", var_points[0].var_origin);
	self.var_2826e2d5 function_SetModel("tag_origin");
	self.var_2826e2d5.var_angles = var_points[0].var_angles;
	wait(1);
	self thread namespace_LUI::function_screen_fade_out(1);
	self.var_game_over function_fadeOverTime(1);
	self.var_game_over.var_alpha = 0;
	self.var_1a914bcc function_fadeOverTime(1);
	self.var_1a914bcc.var_alpha = 0;
	wait(1);
	self.var_spectatorclient = -1;
	self.var_killcamentity = -1;
	self.var_archivetime = 0;
	self.var_psOffsetTime = 0;
	self.var_friendlydamage = undefined;
	var_target_point = namespace_struct::function_get(var_points[0].var_target, "targetname");
	var_speed = 20;
	if(isdefined(var_points[0].var_speed))
	{
		var_speed = var_points[0].var_speed;
	}
	if(isdefined(self.var__health_overlay))
	{
		self.var__health_overlay function_SetShader("overlay_low_health", 0, 0);
	}
	namespace_visionset_mgr::function_deactivate("visionset", "zombie_death", self);
	self function_FreezeControls(0);
	self function_AllowAds(0);
	self function_CameraSetPosition(self.var_2826e2d5);
	self function_CameraSetLookAt();
	self function_CameraActivate(1);
	var_dist = function_Distance(var_points[0].var_origin, var_target_point.var_origin);
	var_time = var_dist / var_speed;
	var_q_time = var_time * 0.25;
	if(var_q_time > 1)
	{
		var_q_time = 1;
	}
	wait(0.15);
	self notify("hash_player_intermission_spawned");
	self thread namespace_zm::function_screen_fade_in(1);
	self.var_game_over function_fadeOverTime(1);
	self.var_game_over.var_alpha = 1;
	self.var_1a914bcc function_fadeOverTime(1);
	self.var_1a914bcc.var_alpha = 1;
	var_time = 20;
	self.var_2826e2d5 function_moveto(var_target_point.var_origin, var_time, var_q_time, var_q_time);
	self.var_2826e2d5 function_RotateTo(var_target_point.var_angles, var_time, var_q_time, var_q_time);
	self namespace_zm_utility::function_create_streamer_hint(var_points[1].var_origin, var_points[1].var_angles, 0.9);
	self.var_9dbb2ccd = function_spawn("script_model", var_points[1].var_origin);
	self.var_9dbb2ccd function_SetModel("tag_origin");
	self.var_9dbb2ccd.var_angles = var_points[1].var_angles;
	var_f2d89fc = namespace_struct::function_get(var_points[1].var_target, "targetname");
	wait(8);
	self thread namespace_LUI::function_screen_fade_out(1);
	self.var_game_over function_fadeOverTime(1);
	self.var_game_over.var_alpha = 0;
	self.var_1a914bcc function_fadeOverTime(1);
	self.var_1a914bcc.var_alpha = 0;
	var_speed = 20;
	if(isdefined(var_points[1].var_speed))
	{
		var_speed = var_points[1].var_speed;
	}
	var_dist = function_Distance(var_points[1].var_origin, var_target_point.var_origin);
	var_time = var_dist / var_speed;
	var_q_time = var_time * 0.25;
	if(var_q_time > 1)
	{
		var_q_time = 1;
	}
	wait(1);
	self function_CameraSetPosition(self.var_9dbb2ccd);
	wait(0.05);
	self thread namespace_zm::function_screen_fade_in(1);
	self.var_game_over function_fadeOverTime(1);
	self.var_game_over.var_alpha = 1;
	self.var_1a914bcc function_fadeOverTime(1);
	self.var_1a914bcc.var_alpha = 1;
	self.var_2826e2d5 function_delete();
	var_time = 10;
	self.var_9dbb2ccd function_moveto(var_f2d89fc.var_origin, var_time, var_q_time, var_q_time);
	self.var_9dbb2ccd function_RotateTo(var_f2d89fc.var_angles, var_time, var_q_time, var_q_time);
	wait(8);
	self thread namespace_LUI::function_screen_fade_out(2);
	self.var_game_over function_fadeOverTime(3);
	self.var_game_over.var_alpha = 0;
	self.var_1a914bcc function_fadeOverTime(3);
	self.var_1a914bcc.var_alpha = 0;
	wait(3);
	return;
	ERROR: Exception occured: Stack empty.
}

/*
	Name: function_moon_intermission
	Namespace: namespace_load
	Checksum: 0x424F4353
	Offset: 0x9618
	Size: 0x758
	Parameters: 0
	Flags: None
	Line Number: 1867
*/
function function_moon_intermission()
{
	self function_closeInGameMenu();
	self function_CloseMenu("StartMenu_Main");
	self notify("hash_player_intermission");
	self endon("hash_player_intermission");
	level endon("hash_stop_intermission");
	self endon("hash_disconnect");
	self endon("hash_death");
	self notify("hash__zombie_game_over");
	var_intro = 2;
	var_outro = 5;
	self.var_score = self.var_score_total;
	var_points = namespace_struct::function_get_array("intermission", "targetname");
	for(var_i = 0; var_i < var_points.size; var_i++)
	{
		if(level namespace_flag::function_get("enter_nml"))
		{
			var_intro = 1;
			var_outro = 3.5;
			if(var_points[var_i].var_script_noteworthy == "moon")
			{
				function_ArrayRemoveValue(var_points, var_points[var_i]);
				continue;
			}
		}
		if(var_points[var_i].var_script_noteworthy == "earth")
		{
			var_intro = 4;
			var_outro = 14;
			function_ArrayRemoveValue(var_points, var_points[var_i]);
		}
	}
	if(!isdefined(var_points) || var_points.size == 0)
	{
		var_points = function_GetEntArray("info_intermission", "classname");
		if(var_points.size < 1)
		{
			return;
		}
	}
	var_target_point = namespace_struct::function_get(var_points[0].var_target, "targetname");
	var_cd052e91 = var_points[0].var_origin;
	var_c61350dc = var_points[0].var_angles;
	var_target_origin = var_target_point.var_origin;
	var_5969b25a = var_target_point.var_angles;
	var_speed = 20;
	if(isdefined(var_points[0].var_speed))
	{
		var_speed = var_points[0].var_speed;
	}
	self namespace_zm_utility::function_create_streamer_hint(var_cd052e91, var_c61350dc, 0.9);
	wait(var_intro);
	self thread namespace_LUI::function_screen_fade_out(1);
	self.var_game_over function_fadeOverTime(1);
	self.var_game_over.var_alpha = 0;
	self.var_1a914bcc function_fadeOverTime(1);
	self.var_1a914bcc.var_alpha = 0;
	wait(1);
	self.var_spectatorclient = -1;
	self.var_killcamentity = -1;
	self.var_archivetime = 0;
	self.var_psOffsetTime = 0;
	self.var_friendlydamage = undefined;
	if(isdefined(self.var__health_overlay))
	{
		self.var__health_overlay function_SetShader("overlay_low_health", 0, 0);
	}
	namespace_visionset_mgr::function_deactivate("visionset", "zombie_death", self);
	self function_FreezeControls(0);
	self namespace_clientfield::function_set_to_player("gasmaskoverlay", 0);
	namespace_visionset_mgr::function_deactivate("overlay", "zm_gasmask_postfx", self);
	self function_AllowAds(0);
	self.var_2826e2d5 = function_spawn("script_model", var_cd052e91);
	self.var_2826e2d5 function_SetModel("tag_origin");
	self.var_2826e2d5.var_angles = var_c61350dc;
	self function_CameraSetPosition(self.var_2826e2d5);
	self function_CameraSetLookAt();
	self function_CameraActivate(1);
	var_dist = function_Distance(var_cd052e91, var_target_origin);
	var_time = var_dist / var_speed;
	var_q_time = var_time * 0.25;
	if(var_q_time > 1)
	{
		var_q_time = 1;
	}
	wait(0.15);
	self notify("hash_player_intermission_spawned");
	self thread namespace_zm::function_screen_fade_in(1);
	self.var_game_over function_fadeOverTime(1);
	self.var_game_over.var_alpha = 1;
	self.var_1a914bcc function_fadeOverTime(1);
	self.var_1a914bcc.var_alpha = 1;
	self.var_2826e2d5 function_moveto(var_target_origin, var_time, var_q_time, var_q_time);
	self.var_2826e2d5 function_RotateTo(var_5969b25a, var_time, var_q_time, var_q_time);
	wait(var_outro);
	self thread namespace_LUI::function_screen_fade_out(2);
	self.var_game_over function_fadeOverTime(2);
	self.var_game_over.var_alpha = 0;
	self.var_1a914bcc function_fadeOverTime(2);
	self.var_1a914bcc.var_alpha = 0;
	wait(2);
}

/*
	Name: function_14512ced
	Namespace: namespace_load
	Checksum: 0x424F4353
	Offset: 0x9D78
	Size: 0x120
	Parameters: 0
	Flags: None
	Line Number: 1981
*/
function function_14512ced()
{
	wait(1);
	level.var_custom_intermission = &function_player_intermission;
	if(level.var_script == "zm_tomb")
	{
		level.var__zombie_sidequests["little_girl_lost"].var_complete_func = &function_efa913af;
	}
	if(level.var_script == "zm_moon")
	{
		level.var_custom_intermission = &function_moon_intermission;
	}
	if(level.var_script == "zm_factory")
	{
		level.var_custom_intermission = &function_23b01d28;
	}
	if(level.var_script == "zm_theater")
	{
		level.var_custom_intermission = &function_ffdcb0bb;
	}
	if(level.var_script == "zm_temple")
	{
		level.var_custom_intermission = &function_92907761;
	}
	level.var_custom_game_over_hud_elem = &function_custom_game_over_hud_elem;
}

/*
	Name: function_efa913af
	Namespace: namespace_load
	Checksum: 0x424F4353
	Offset: 0x9EA0
	Size: 0x2C0
	Parameters: 0
	Flags: None
	Line Number: 2018
*/
function function_efa913af()
{
	var_a_players = function_GetPlayers();
	foreach(var_player in var_a_players)
	{
		var_player namespace_zm::function_spectator_respawn_player();
		var_player function_FreezeControls(1);
		var_player function_EnableInvulnerability();
		if(var_player namespace_laststand::function_player_is_in_laststand())
		{
			var_player namespace_zm_laststand::function_auto_revive(level, 0);
		}
	}
	namespace_zm_audio::function_musicState_Create("game_over", 5, "game_over_zhd_tomb2");
	level.var_custom_intermission = &function_9e04319a;
	level namespace_LUI::function_prime_movie("zm_outro_tomb", 0, "");
	level.var_sndgameovermusicoverride = "game_over_ee";
	level namespace_flag::function_clear("spawn_zombies");
	level thread function_19a0b6e0();
	function_playsoundatposition("zmb_squest_whiteout", (0, 0, 0));
	level namespace_LUI::function_screen_fade_out(1, "white", "starting_ee_screen");
	namespace_util::function_delay(0.5, undefined, &function_remove_portal_beam);
	level thread namespace_LUI::function_play_movie("zm_outro_tomb", "fullscreen", 0, 0, "");
	level namespace_LUI::function_screen_fade_out(0, "black", "starting_ee_screen");
	wait(81);
	level notify("hash_end_game");
	level thread namespace_LUI::function_screen_fade_in(2, "black", "starting_ee_screen");
	wait(1.5);
}

/*
	Name: function_remove_portal_beam
	Namespace: namespace_load
	Checksum: 0x424F4353
	Offset: 0xA168
	Size: 0x30
	Parameters: 0
	Flags: None
	Line Number: 2058
*/
function function_remove_portal_beam()
{
	if(isdefined(level.var_ee_ending_beam_fx))
	{
		level.var_ee_ending_beam_fx function_delete();
	}
}

/*
	Name: function_19a0b6e0
	Namespace: namespace_load
	Checksum: 0x424F4353
	Offset: 0xA1A0
	Size: 0x1A8
	Parameters: 0
	Flags: None
	Line Number: 2076
*/
function function_19a0b6e0()
{
	var_a_ai_enemies = function_GetAITeamArray("axis");
	foreach(var_ai in var_a_ai_enemies)
	{
		if(function_isalive(var_ai))
		{
			var_ai.var_marked_for_death = 1;
			var_ai namespace_ai::function_set_ignoreall(1);
		}
		namespace_util::function_wait_network_frame();
	}
	foreach(var_ai in var_a_ai_enemies)
	{
		if(function_isalive(var_ai))
		{
			var_ai function_DoDamage(var_ai.var_health + 666, var_ai.var_origin);
		}
	}
}

/*
	Name: function_a7ca0362
	Namespace: namespace_load
	Checksum: 0x424F4353
	Offset: 0xA350
	Size: 0xD0
	Parameters: 0
	Flags: None
	Line Number: 2107
*/
function function_a7ca0362()
{
	switch(level.var_script)
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
	Namespace: namespace_load
	Checksum: 0x424F4353
	Offset: 0xA428
	Size: 0xE0
	Parameters: 0
	Flags: None
	Line Number: 2174
*/
function function_9b7d1f69()
{
	switch(level.var_script)
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
	Name: function_player_intermission
	Namespace: namespace_load
	Checksum: 0x424F4353
	Offset: 0xA510
	Size: 0x640
	Parameters: 0
	Flags: None
	Line Number: 2248
*/
function function_player_intermission()
{
	self function_closeInGameMenu();
	self function_CloseMenu("StartMenu_Main");
	self notify("hash_player_intermission");
	self endon("hash_player_intermission");
	level endon("hash_stop_intermission");
	self endon("hash_disconnect");
	self endon("hash_death");
	self notify("hash__zombie_game_over");
	self.var_score = self.var_score_total;
	var_points = namespace_struct::function_get_array("intermission", "targetname");
	if(!isdefined(var_points) || var_points.size == 0)
	{
		var_points = function_GetEntArray("info_intermission", "classname");
		if(var_points.size < 1)
		{
			return;
		}
	}
	var_i = function_RandomInt(var_points.size);
	var_target_point = namespace_struct::function_get(var_points[var_i].var_target, "targetname");
	var_cd052e91 = var_points[var_i].var_origin;
	var_c61350dc = var_points[var_i].var_angles;
	var_target_origin = var_target_point.var_origin;
	var_5969b25a = var_target_point.var_angles;
	var_speed = 20;
	if(isdefined(var_points[var_i].var_speed))
	{
		var_speed = var_points[var_i].var_speed;
	}
	self namespace_zm_utility::function_create_streamer_hint(var_cd052e91, var_c61350dc, 0.9);
	wait(function_a7ca0362());
	self thread namespace_LUI::function_screen_fade_out(1);
	self.var_game_over function_fadeOverTime(1);
	self.var_game_over.var_alpha = 0;
	self.var_1a914bcc function_fadeOverTime(1);
	self.var_1a914bcc.var_alpha = 0;
	wait(1);
	self.var_spectatorclient = -1;
	self.var_killcamentity = -1;
	self.var_archivetime = 0;
	self.var_psOffsetTime = 0;
	self.var_friendlydamage = undefined;
	if(isdefined(self.var__health_overlay))
	{
		self.var__health_overlay function_SetShader("overlay_low_health", 0, 0);
	}
	namespace_visionset_mgr::function_deactivate("visionset", "zombie_death", self);
	self function_FreezeControls(0);
	self function_AllowAds(0);
	self.var_2826e2d5 = function_spawn("script_model", var_cd052e91);
	self.var_2826e2d5 function_SetModel("tag_origin");
	self.var_2826e2d5.var_angles = var_c61350dc;
	self function_CameraSetPosition(self.var_2826e2d5);
	self function_CameraSetLookAt();
	self function_CameraActivate(1);
	var_dist = function_Distance(var_cd052e91, var_target_origin);
	var_time = var_dist / var_speed;
	var_q_time = var_time * 0.25;
	if(var_q_time > 1)
	{
		var_q_time = 1;
	}
	wait(0.15);
	self notify("hash_player_intermission_spawned");
	self thread namespace_zm::function_screen_fade_in(1);
	self.var_game_over function_fadeOverTime(1);
	self.var_game_over.var_alpha = 1;
	self.var_1a914bcc function_fadeOverTime(1);
	self.var_1a914bcc.var_alpha = 1;
	self.var_2826e2d5 function_moveto(var_target_origin, var_time, var_q_time, var_q_time);
	self.var_2826e2d5 function_RotateTo(var_5969b25a, var_time, var_q_time, var_q_time);
	wait(function_9b7d1f69());
	self thread namespace_LUI::function_screen_fade_out(2);
	self.var_game_over function_fadeOverTime(2);
	self.var_game_over.var_alpha = 0;
	self.var_1a914bcc function_fadeOverTime(2);
	self.var_1a914bcc.var_alpha = 0;
	wait(2);
	return;
}

/*
	Name: function_custom_game_over_hud_elem
	Namespace: namespace_load
	Checksum: 0x424F4353
	Offset: 0xAB58
	Size: 0x2F8
	Parameters: 3
	Flags: None
	Line Number: 2341
*/
function function_custom_game_over_hud_elem(var_player, var_game_over, var_survived)
{
	var_player.var_game_over = var_game_over;
	var_game_over = var_player.var_game_over;
	var_player.var_1a914bcc = var_survived;
	var_survived = var_player.var_1a914bcc;
	var_game_over.var_alignX = "center";
	var_game_over.var_alignY = "middle";
	var_game_over.var_horzAlign = "center";
	var_game_over.var_vertAlign = "middle";
	var_game_over.var_y = var_game_over.var_y - 130;
	var_game_over.var_foreground = 1;
	var_game_over.var_fontscale = 3;
	var_game_over.var_alpha = 0;
	var_game_over.var_color = (1, 1, 1);
	var_game_over.var_hidewheninmenu = 1;
	var_game_over function_setText(&"ZOMBIE_GAME_OVER");
	var_game_over function_fadeOverTime(1);
	var_game_over.var_alpha = 1;
	if(var_player function_IsSplitscreen())
	{
		var_game_over.var_fontscale = 2;
		var_game_over.var_y = var_game_over.var_y + 40;
	}
	var_survived.var_alignX = "center";
	var_survived.var_alignY = "middle";
	var_survived.var_horzAlign = "center";
	var_survived.var_vertAlign = "middle";
	var_survived.var_y = var_survived.var_y - 100;
	var_survived.var_foreground = 1;
	var_survived.var_fontscale = 2;
	var_survived.var_alpha = 0;
	var_survived.var_color = (1, 1, 1);
	var_survived.var_hidewheninmenu = 1;
	if(var_player function_IsSplitscreen())
	{
		var_survived.var_fontscale = 1.5;
		var_survived.var_y = var_survived.var_y + 40;
	}
}

/*
	Name: function_9e04319a
	Namespace: namespace_load
	Checksum: 0x424F4353
	Offset: 0xAE58
	Size: 0x558
	Parameters: 0
	Flags: None
	Line Number: 2392
*/
function function_9e04319a()
{
	self function_closeInGameMenu();
	self function_CloseMenu("StartMenu_Main");
	self notify("hash_player_intermission");
	self endon("hash_player_intermission");
	level endon("hash_stop_intermission");
	self endon("hash_disconnect");
	self endon("hash_death");
	self notify("hash__zombie_game_over");
	self.var_game_over.var_alpha = 0;
	self.var_1a914bcc.var_alpha = 0;
	self thread namespace_LUI::function_screen_fade_out(0);
	self.var_score = self.var_score_total;
	var_points = namespace_struct::function_get_array("ee_cam", "targetname");
	var_target_point = namespace_struct::function_get(var_points[0].var_target, "targetname");
	var_cd052e91 = var_points[0].var_origin;
	var_c61350dc = var_points[0].var_angles;
	var_target_origin = var_target_point.var_origin;
	var_5969b25a = var_target_point.var_angles;
	var_speed = 20;
	if(isdefined(var_points[0].var_speed))
	{
		var_speed = var_points[0].var_speed;
	}
	self namespace_zm_utility::function_create_streamer_hint(var_cd052e91, var_c61350dc, 0.9);
	self.var_spectatorclient = -1;
	self.var_killcamentity = -1;
	self.var_archivetime = 0;
	self.var_psOffsetTime = 0;
	self.var_friendlydamage = undefined;
	if(isdefined(self.var__health_overlay))
	{
		self.var__health_overlay function_SetShader("overlay_low_health", 0, 0);
	}
	namespace_visionset_mgr::function_deactivate("visionset", "zombie_death", self);
	self function_FreezeControls(0);
	self function_AllowAds(0);
	self.var_2826e2d5 = function_spawn("script_model", var_cd052e91);
	self.var_2826e2d5 function_SetModel("tag_origin");
	self.var_2826e2d5.var_angles = var_c61350dc;
	self function_CameraSetPosition(self.var_2826e2d5);
	self function_CameraSetLookAt();
	self function_CameraActivate(1);
	var_dist = function_Distance(var_cd052e91, var_target_origin);
	var_time = var_dist / var_speed;
	var_q_time = var_time * 0.25;
	if(var_q_time > 1)
	{
		var_q_time = 1;
	}
	self.var_2826e2d5 function_moveto(var_target_origin, var_time, var_q_time, var_q_time);
	self.var_2826e2d5 function_RotateTo(var_5969b25a, var_time, var_q_time, var_q_time);
	wait(0.15);
	self notify("hash_player_intermission_spawned");
	self thread namespace_zm::function_screen_fade_in(2);
	self.var_game_over function_fadeOverTime(2);
	self.var_game_over.var_alpha = 1;
	self.var_1a914bcc function_fadeOverTime(2);
	self.var_1a914bcc.var_alpha = 1;
	wait(14);
	self thread namespace_LUI::function_screen_fade_out(2);
	self.var_game_over function_fadeOverTime(2);
	self.var_game_over.var_alpha = 0;
	self.var_1a914bcc function_fadeOverTime(2);
	self.var_1a914bcc.var_alpha = 0;
	wait(2);
}

/*
	Name: function_7c03764f
	Namespace: namespace_load
	Checksum: 0x424F4353
	Offset: 0xB3B8
	Size: 0x128
	Parameters: 4
	Flags: Private
	Line Number: 2471
*/
function private function_7c03764f(var_User, var_trigger, var_origin_offset, var_interact_offset)
{
	if(!isdefined(var_User))
	{
		var_User = level;
	}
	level endon("hash_Pack_A_Punch_off");
	var_trigger endon("hash_pap_player_disconnected");
	foreach(var_player in function_GetPlayers())
	{
		var_player function_stopSound("zmb_perks_packa_ready");
		var_player function_stopSound("zmb_perks_packa_ready");
	}
	var_User function_playsound("tomb_pap_ready");
}

/*
	Name: function_924c2652
	Namespace: namespace_load
	Checksum: 0x424F4353
	Offset: 0xB4E8
	Size: 0x58
	Parameters: 4
	Flags: Private
	Line Number: 2497
*/
function private function_924c2652(var_player, var_trigger, var_origin_offset, var_angles_offset)
{
	level endon("hash_Pack_A_Punch_off");
	var_trigger endon("hash_pap_player_disconnected");
	var_player thread function_1cd707a5();
	return;
	waittillframeend;
}

/*
	Name: function_1cd707a5
	Namespace: namespace_load
	Checksum: 0x424F4353
	Offset: 0xB548
	Size: 0x50
	Parameters: 0
	Flags: Private
	Line Number: 2516
*/
function private function_1cd707a5()
{
	wait(0.05);
	self function_stopSound("zmb_perks_packa_upgrade");
	self function_playsound("tomb_pap_upgrade");
}

/*
	Name: function_1c485da4
	Namespace: namespace_load
	Checksum: 0x424F4353
	Offset: 0xB5A0
	Size: 0x48
	Parameters: 0
	Flags: Private
	Line Number: 2533
*/
function private function_1c485da4()
{
	wait(1);
	self function_StopLoopSound(0);
	self function_PlayLoopSound("tomb_pap_loop");
	return;
	ERROR: Exception occured: Stack empty.
}

/*
	Name: function_custom_joker_movement
	Namespace: namespace_load
	Checksum: 0x424F4353
	Offset: 0xB5F0
	Size: 0x1E8
	Parameters: 0
	Flags: None
	Line Number: 2552
*/
function function_custom_joker_movement()
{
	var_v_origin = self.var_weapon_model.var_origin - VectorScale((0, 0, 1), 5);
	self.var_weapon_model function_delete();
	var_m_lock = namespace_util::function_spawn_model(level.var_chest_joker_model, var_v_origin, self.var_angles);
	wait(0.5);
	level notify("hash_weapon_fly_away_start");
	thread function_98039e78();
	function_playsoundatposition("zmb_hellbox_bear", (0, 0, 0));
	wait(1);
	var_m_lock function_RotateYaw(3000, 4, 4);
	wait(3);
	var_v_angles = function_AnglesToForward(self.var_angles - VectorScale((0, 1, 0), 90));
	var_m_lock function_moveto(var_m_lock.var_origin + 20 * var_v_angles, 0.5, 0.5);
	var_m_lock waittill("hash_movedone");
	var_m_lock function_moveto(var_m_lock.var_origin + -100 * var_v_angles, 0.5, 0.5);
	var_m_lock waittill("hash_movedone");
	var_m_lock function_delete();
	self notify("hash_box_moving");
	level notify("hash_weapon_fly_away_end");
}

/*
	Name: function_98039e78
	Namespace: namespace_load
	Checksum: 0x424F4353
	Offset: 0xB7E0
	Size: 0xC8
	Parameters: 0
	Flags: None
	Line Number: 2584
*/
function function_98039e78()
{
	level endon("hash_weapon_fly_away_end");
	level endon("hash_end_game");
	while(1)
	{
		foreach(var_player in function_GetPlayers())
		{
			var_player function_stopSound(level.var_zmb_laugh_alias);
		}
		wait(0.05);
	}
}

/*
	Name: function_4abfffd2
	Namespace: namespace_load
	Checksum: 0x424F4353
	Offset: 0xB8B0
	Size: 0x138
	Parameters: 0
	Flags: None
	Line Number: 2608
*/
function function_4abfffd2()
{
	level waittill("hash_power_on");
	var_doors = function_GetEntArray("receiving_bay_doors", "targetname");
	for(var_i = 0; var_i < var_doors.size; var_i++)
	{
		var_script_vector = function_b162da30(var_i);
		var_doors[var_i] function_playsound("evt_loading_door_start");
		var_doors[var_i] function_PlayLoopSound("evt_loading_door_loop", 0.5);
		var_doors[var_i] function_moveto(var_doors[var_i].var_origin + var_script_vector, 3);
		var_doors[var_i] thread function_e7d84b6();
	}
}

/*
	Name: function_b162da30
	Namespace: namespace_load
	Checksum: 0x424F4353
	Offset: 0xB9F0
	Size: 0x90
	Parameters: 1
	Flags: None
	Line Number: 2632
*/
function function_b162da30(var_i)
{
	switch(var_i)
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
	Namespace: namespace_load
	Checksum: 0x424F4353
	Offset: 0xBA88
	Size: 0x50
	Parameters: 0
	Flags: None
	Line Number: 2669
*/
function function_e7d84b6()
{
	wait(2.6);
	self function_StopLoopSound(0.5);
	self function_playsound("evt_loading_door_end");
}

/*
	Name: function_6811a318
	Namespace: namespace_load
	Checksum: 0x424F4353
	Offset: 0xBAE0
	Size: 0x48
	Parameters: 0
	Flags: None
	Line Number: 2686
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
	Namespace: namespace_load
	Checksum: 0x424F4353
	Offset: 0xBB30
	Size: 0x30
	Parameters: 0
	Flags: None
	Line Number: 2704
*/
function function_faa7d346()
{
	level endon("hash_end_game");
	level waittill("hash_air_puzzle_2_complete");
	thread function_play_puzzle_stinger_on_all_players();
}

/*
	Name: function_69441aa4
	Namespace: namespace_load
	Checksum: 0x424F4353
	Offset: 0xBB68
	Size: 0x30
	Parameters: 0
	Flags: None
	Line Number: 2721
*/
function function_69441aa4()
{
	level endon("hash_end_game");
	level waittill("hash_fire_puzzle_2_complete");
	thread function_play_puzzle_stinger_on_all_players();
}

/*
	Name: function_4d2e9004
	Namespace: namespace_load
	Checksum: 0x424F4353
	Offset: 0xBBA0
	Size: 0x30
	Parameters: 0
	Flags: None
	Line Number: 2738
*/
function function_4d2e9004()
{
	level endon("hash_end_game");
	level waittill("hash_70b160e8");
	thread function_play_puzzle_stinger_on_all_players();
}

/*
	Name: function_6d36bad9
	Namespace: namespace_load
	Checksum: 0x424F4353
	Offset: 0xBBD8
	Size: 0x30
	Parameters: 0
	Flags: None
	Line Number: 2755
*/
function function_6d36bad9()
{
	level endon("hash_end_game");
	level waittill("hash_electric_puzzle_2_complete");
	thread function_play_puzzle_stinger_on_all_players();
}

/*
	Name: function_play_puzzle_stinger_on_all_players
	Namespace: namespace_load
	Checksum: 0x424F4353
	Offset: 0xBC10
	Size: 0x24
	Parameters: 0
	Flags: None
	Line Number: 2772
*/
function function_play_puzzle_stinger_on_all_players()
{
	function_playsoundatposition("zmb_squest_step2_finished", (0, 0, 0));
}

