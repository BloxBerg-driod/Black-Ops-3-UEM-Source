#include scripts\codescripts\struct;
#include scripts\shared\aat_shared;
#include scripts\shared\ai\systems\gib;
#include scripts\shared\ai\zombie_death;
#include scripts\shared\ai\zombie_shared;
#include scripts\shared\ai\zombie_utility;
#include scripts\shared\animation_shared;
#include scripts\shared\array_shared;
#include scripts\shared\callbacks_shared;
#include scripts\shared\clientfield_shared;
#include scripts\shared\demo_shared;
#include scripts\shared\duplicaterender_mgr;
#include scripts\shared\exploder_shared;
#include scripts\shared\flag_shared;
#include scripts\shared\flagsys_shared;
#include scripts\shared\hud_shared;
#include scripts\shared\hud_util_shared;
#include scripts\shared\laststand_shared;
#include scripts\shared\lui_shared;
#include scripts\shared\spawner_shared;
#include scripts\shared\system_shared;
#include scripts\shared\util_shared;
#include scripts\sphynx\leveling\_zm_sphynx_leveling;
#include scripts\zm\_util;
#include scripts\zm\_zm;
#include scripts\zm\_zm_audio;
#include scripts\zm\_zm_behavior;
#include scripts\zm\_zm_behavior_utility;
#include scripts\zm\_zm_bgb;
#include scripts\zm\_zm_blockers;
#include scripts\zm\_zm_equipment;
#include scripts\zm\_zm_laststand;
#include scripts\zm\_zm_net;
#include scripts\zm\_zm_perk_additionalprimaryweapon;
#include scripts\zm\_zm_perks;
#include scripts\zm\_zm_pers_upgrades;
#include scripts\zm\_zm_pers_upgrades_functions;
#include scripts\zm\_zm_powerup_nuke;
#include scripts\zm\_zm_powerups;
#include scripts\zm\_zm_puppet;
#include scripts\zm\_zm_score;
#include scripts\zm\_zm_spawner;
#include scripts\zm\_zm_stats;
#include scripts\zm\_zm_unitrigger;
#include scripts\zm\_zm_utility;
#include scripts\zm\_zm_weapon_upgrade_system;
#include scripts\zm\_zm_weapons;
#include scripts\zm\_zm_zonemgr;
#include scripts\zm\gametypes\_globallogic;
#include scripts\zm\gametypes\_globallogic_score;

#namespace namespace_zm_daily_challenges;

/*
	Name: function___init__sytem__
	Namespace: namespace_zm_daily_challenges
	Checksum: 0x424F4353
	Offset: 0x1170
	Size: 0x38
	Parameters: 0
	Flags: AutoExec
	Line Number: 63
*/
function autoexec function___init__sytem__()
{
	namespace_system::function_register("zm_daily_challenges_uem", &function___init__, undefined, undefined);
}

/*
	Name: function___init__
	Namespace: namespace_zm_daily_challenges
	Checksum: 0x424F4353
	Offset: 0x11B0
	Size: 0x28
	Parameters: 0
	Flags: None
	Line Number: 78
*/
function function___init__()
{
	namespace_callback::function_on_connect(&function_8cb3edd7);
}

/*
	Name: function_8cb3edd7
	Namespace: namespace_zm_daily_challenges
	Checksum: 0x424F4353
	Offset: 0x11E0
	Size: 0x378
	Parameters: 0
	Flags: None
	Line Number: 93
*/
function function_8cb3edd7()
{
	self endon("hash_disconnect");
	while(1)
	{
		self waittill("hash_63cf7d21", var_challenge, var_d3d8af77, var_max, var_6c47d281, var_player_points, var_2a4ca729, var_994b33dd);
		if(!isdefined(var_challenge))
		{
			continue;
		}
		if(!(isdefined(self.var_c6452f46["challenges"]) && self.var_c6452f46["challenges"]))
		{
			continue;
		}
		if(isdefined(self.var_pers[var_challenge]) && self.var_pers[var_challenge] < var_max)
		{
			self.var_pers[var_challenge] = self.var_pers[var_challenge] + var_d3d8af77;
			if(self.var_pers[var_challenge] >= var_max)
			{
				self.var_pers[var_challenge] = var_max;
				if(function_Int(var_player_points) != 0)
				{
					if(function_Int(var_player_points) >= 1 && function_Int(var_player_points) <= 9999999)
					{
						self.var_pers["player_points"] = self.var_pers["player_points"] + var_player_points;
					}
					else
					{
						function_iprintln("^8[Challenges] ^7Tried to add a non-int value Player Points! Notify Sphynx on challenge");
					}
				}
				var_9e7ab2f5 = function_Int(var_6c47d281);
				if(self.var_b74a3cd1["prestige"] > 0)
				{
					self notify("hash_79ef118b", "challenge_" + var_challenge, var_6c47d281 * self.var_b74a3cd1["prestige"]);
				}
				else
				{
					self notify("hash_79ef118b", "challenge_" + var_challenge, var_6c47d281);
				}
				if(isdefined(var_2a4ca729))
				{
					self.var_pers[var_2a4ca729] = 1;
					wait(0.05);
					self thread namespace_97ac1184::function_7e18304e("spx_save_data", var_2a4ca729, self.var_pers[var_2a4ca729], 0);
				}
				if(isdefined(var_994b33dd))
				{
					self.var_pers[var_994b33dd] = 1;
					wait(0.05);
					self thread namespace_97ac1184::function_7e18304e("spx_save_data", var_994b33dd, self.var_pers[var_994b33dd], 0);
				}
				wait(0.05);
				self thread function_6711b7c3();
			}
			wait(0.05);
			self thread namespace_97ac1184::function_7e18304e("spx_challenges_save_data", var_challenge, self.var_pers[var_challenge], 0);
			else
			{
			}
		}
	}
	return;
	ERROR: Exception occured: Stack empty.
}

/*
	Name: function_dbd38088
	Namespace: namespace_zm_daily_challenges
	Checksum: 0x424F4353
	Offset: 0x1560
	Size: 0x180
	Parameters: 1
	Flags: None
	Line Number: 169
*/
function function_dbd38088(var_6c47d281)
{
	var_9e7ab2f5 = var_6c47d281;
	if(self.var_b74a3cd1["prestige"] > 0)
	{
		var_9e7ab2f5 = var_9e7ab2f5 * 1 + 0.05 * self.var_b74a3cd1["prestige"];
	}
	if(self.var_b74a3cd1["level"] > 100)
	{
		var_9e7ab2f5 = var_9e7ab2f5 + self.var_b74a3cd1["level"] - 100 * var_6c47d281 * 0.005;
	}
	if(self.var_b74a3cd1["prestige_legend"] > 0)
	{
		var_9e7ab2f5 = var_9e7ab2f5 * 1 + 0.1 * self.var_b74a3cd1["prestige_legend"];
	}
	if(self.var_b74a3cd1["prestige_absolute"] > 0)
	{
		var_9e7ab2f5 = var_9e7ab2f5 * 1 + 0.5 * self.var_b74a3cd1["prestige_absolute"];
	}
	if(self.var_b74a3cd1["prestige_ultimate"] > 0)
	{
		var_9e7ab2f5 = var_9e7ab2f5 * 1 + 2 * self.var_b74a3cd1["prestige_ultimate"];
	}
	return var_9e7ab2f5;
}

/*
	Name: function_568d306a
	Namespace: namespace_zm_daily_challenges
	Checksum: 0x424F4353
	Offset: 0x16E8
	Size: 0x38
	Parameters: 2
	Flags: None
	Line Number: 205
*/
function function_568d306a(var_current, var_Total)
{
	if(var_Total <= 0)
	{
		return 0;
	}
	return var_current / var_Total * 100;
}

/*
	Name: function_97666686
	Namespace: namespace_zm_daily_challenges
	Checksum: 0x424F4353
	Offset: 0x1728
	Size: 0x120
	Parameters: 3
	Flags: None
	Line Number: 224
*/
function function_97666686(var_challenges, var_5c824013, var_threshold)
{
	var_completed = 0;
	var_a43abe22 = var_challenges.size;
	foreach(var_value in var_challenges)
	{
		if(self.var_pers[var_key] >= var_value)
		{
			var_completed++;
		}
	}
	var_percentage = function_568d306a(var_completed, var_a43abe22);
	if(var_percentage >= var_threshold)
	{
		self.var_pers[var_5c824013] = 1;
		return 1;
	}
	return 0;
}

/*
	Name: function_6711b7c3
	Namespace: namespace_zm_daily_challenges
	Checksum: 0x424F4353
	Offset: 0x1850
	Size: 0xF60
	Parameters: 0
	Flags: None
	Line Number: 254
*/
function function_6711b7c3()
{
	while(!(isdefined(self.var_c6452f46["challenges"]) && self.var_c6452f46["challenges"]))
	{
		wait(0.5);
	}
	wait(0.05);
	var_d54495a = [];
	var_d54495a["cc2_massacre_undead"] = 25000;
	var_d54495a["cc2_headshot_hunter"] = 6000;
	var_d54495a["cc2_headshot_longshot_slayer"] = 750;
	var_d54495a["cc2_rapid_mayhem"] = 2500;
	var_d54495a["cc2_melee_mayhem"] = 1500;
	var_d54495a["cc2_wonder_weapon_slayer"] = 2500;
	var_d54495a["cc2_upgraded_killer"] = 5000;
	var_d54495a["cc2_hipfire_veteran"] = 1200;
	var_d54495a["cc2_headshot_specialist"] = 750;
	var_d54495a["cc2_ads_specialist"] = 1250;
	var_d54495a["cc2_packed_precision"] = 1500;
	var_d54495a["cc2_consecutive_headshot_master"] = 1500;
	var_d54495a["cc2_explosive_expert"] = 2500;
	var_493a120a = [];
	var_493a120a["cc2_perk_enthusiast"] = 50;
	var_493a120a["cc2_perk_perfectionist"] = 5;
	var_493a120a["cc2_no_perk_master"] = 1;
	var_493a120a["cc2_powerups_master"] = 250;
	var_1e4f116c = [];
	var_1e4f116c["cc2_round_master"] = 250;
	var_1e4f116c["cc2_round_grinder"] = 5;
	var_1e4f116c["cc2_flawless_survivor"] = 45;
	var_1e4f116c["cc2_big_spender"] = 2000000;
	var_1e4f116c["cc2_box_hoarder"] = 200;
	var_1e4f116c["cc2_door_master"] = 40;
	var_7fb3b32a = [];
	var_7fb3b32a["cc2_repack"] = 75;
	var_7fb3b32a["cc2_lmg_dominator"] = 3000;
	var_7fb3b32a["cc2_ar_master"] = 2000;
	var_7fb3b32a["cc2_smg_slayer"] = 2000;
	var_7fb3b32a["cc2_hipfire_sniper"] = 500;
	var_7fb3b32a["cc2_sniper_expert"] = 1500;
	var_7fb3b32a["cc2_shotgun_savior"] = 1500;
	var_7fb3b32a["cc2_pistol_perfectionist"] = 1000;
	if(self function_97666686(var_d54495a, "cc2_kill_completionist", 40))
	{
		self.var_pers["christmas_camo"] = 1;
		self.var_pers["christmas_hat"] = 1;
		self thread namespace_97ac1184::function_7e18304e("spx_save_data", "christmas_camo", self.var_pers["christmas_camo"], 0);
		self thread namespace_97ac1184::function_7e18304e("spx_save_data", "christmas_hat", self.var_pers["christmas_hat"], 0);
	}
	if(self function_97666686(var_493a120a, "cc2_perk_completionist", 40))
	{
		self thread namespace_97ac1184::function_7e18304e("spx_challenges_save_data", "cc2_perk_completionist", self.var_pers["cc2_perk_completionist"], 0);
	}
	if(self function_97666686(var_1e4f116c, "cc2_round_completionist", 40))
	{
		self thread namespace_97ac1184::function_7e18304e("spx_challenges_save_data", "cc2_round_completionist", self.var_pers["cc2_round_completionist"], 0);
	}
	if(self function_97666686(var_7fb3b32a, "cc2_weapon_completionist", 40))
	{
		self.var_pers["christmas_camo_2"] = 1;
		self thread namespace_97ac1184::function_7e18304e("spx_save_data", "christmas_camo_2", self.var_pers["christmas_camo_2"], 0);
	}
	var_a43abe22 = var_d54495a.size + var_493a120a.size + var_1e4f116c.size + var_7fb3b32a.size;
	var_1b2ea7e8 = 0;
	foreach(var_challenge in var_d54495a)
	{
		if(self.var_pers[var_challenge.var_key] >= var_challenge.var_value)
		{
			var_1b2ea7e8++;
		}
	}
	foreach(var_challenge in var_493a120a)
	{
		if(self.var_pers[var_challenge.var_key] >= var_challenge.var_value)
		{
			var_1b2ea7e8++;
		}
	}
	foreach(var_challenge in var_1e4f116c)
	{
		if(self.var_pers[var_challenge.var_key] >= var_challenge.var_value)
		{
			var_1b2ea7e8++;
		}
	}
	foreach(var_challenge in var_7fb3b32a)
	{
		if(self.var_pers[var_challenge.var_key] >= var_challenge.var_value)
		{
			var_1b2ea7e8++;
		}
	}
	var_ec7889b7 = function_568d306a(var_1b2ea7e8, var_a43abe22);
	if(var_ec7889b7 >= 50)
	{
		self.var_pers["cc2_ultimate_completionist"] = 1;
		self.var_pers["christmas_pet"] = 1;
		self.var_pers["christmas_hat_2"] = 1;
		self thread namespace_97ac1184::function_7e18304e("spx_save_data", "christmas_pet", self.var_pers["christmas_pet"], 0);
		self thread namespace_97ac1184::function_7e18304e("spx_save_data", "christmas_hat_2", self.var_pers["christmas_hat_2"], 0);
		self thread namespace_97ac1184::function_7e18304e("spx_challenges_save_data", "cc2_ultimate_completionist", self.var_pers["cc2_ultimate_completionist"], 0);
	}
	wait(0.05);
	if(self.var_pers["map0_motd_rounds"] >= 65 && self.var_pers["map0_motd_kills"] >= 1500 && self.var_pers["map0_motd_escape"] >= 1 && self.var_pers["map0_motd_golden_escape"] >= 3 && self.var_pers["map0_motd_headshots"] >= 750 && self.var_pers["map0_motd_perks"] >= 15 && self.var_pers["map0_motd_revive"] >= 3 && self.var_pers["map0_motd_dog_heads"] >= 1 && self.var_pers["map0_motd_blundergat"] >= 250 && self.var_pers["map0_motd_bridge_kills"] >= 500 && self.var_pers["map0_motd_warden_kills"] >= 10 && self.var_pers["map0_motd_hells_retriever"] >= 100 && self.var_pers["map0_motd_pack_a_punched"] >= 1 && self.var_pers["map0_motd_pack_a_punched_multiple"] >= 25 && self.var_pers["map0_motd_pack_a_punched_multiple_2"] >= 125 && self.var_pers["map0_motd_enchantment_kills"] >= 1500 && self.var_pers["map0_motd_enchantment_kills_2"] >= 10000 && self.var_pers["map0_motd_enchantment_kills_3"] >= 50000 && self.var_pers["map0_motd_complete_all"] < 1)
	{
		self notify("hash_63cf7d21", "map0_motd_complete_all", 1, 1, 250000, 500);
		wait(0.05);
		self.var_pers["motd_camo_0"] = 1;
		self.var_pers["motd_camo_1"] = 1;
		self.var_pers["motd_camo_2"] = 1;
		self.var_pers["motd_camo_3"] = 1;
		self.var_pers["motd_plushie"] = 1;
		self.var_pers["motd_title"] = 1;
		wait(0.05);
		self thread namespace_97ac1184::function_7e18304e("spx_save_data", "motd_camo_0", self.var_pers["motd_camo_0"], 0);
		self thread namespace_97ac1184::function_7e18304e("spx_save_data", "motd_camo_1", self.var_pers["motd_camo_1"], 0);
		self thread namespace_97ac1184::function_7e18304e("spx_save_data", "motd_camo_2", self.var_pers["motd_camo_2"], 0);
		self thread namespace_97ac1184::function_7e18304e("spx_save_data", "motd_camo_3", self.var_pers["motd_camo_3"], 0);
		self thread namespace_97ac1184::function_7e18304e("spx_save_data", "motd_plushie", self.var_pers["motd_plushie"], 0);
		self thread namespace_97ac1184::function_7e18304e("spx_save_data", "motd_title", self.var_pers["motd_title"], 0);
		function_iprintln("^8[Challenges] ^7MOTD Ultimate Completionist Completed");
	}
	wait(0.05);
	if(self.var_pers["map0_skyblock_rounds"] >= 45 && self.var_pers["map0_skyblock_kills"] >= 5000 && self.var_pers["map0_skyblock_longshots"] >= 1200 && self.var_pers["map0_skyblock_ads"] >= 1250 && self.var_pers["map0_skyblock_enchantment"] >= 2500 && self.var_pers["map0_skyblock_headshots"] >= 1500 && self.var_pers["map0_skyblock_perks"] >= 30 && self.var_pers["map0_skyblock_end_kills"] >= 1500 && self.var_pers["map0_skyblock_desert_kills"] >= 1250 && self.var_pers["map0_skyblock_enchantment_ritual_kills"] >= 1000 && self.var_pers["map0_skyblock_wildlands_kills"] >= 1750 && self.var_pers["map0_skyblock_complete_all"] < 1)
	{
		self notify("hash_63cf7d21", "map0_skyblock_complete_all", 1, 1, 250000, 500);
		self.var_pers["mc_plushie_1"] = 1;
		self.var_pers["mc_title_1"] = 1;
		wait(0.05);
		self thread namespace_97ac1184::function_7e18304e("spx_save_data", "mc_plushie_1", self.var_pers["mc_plushie_1"], 0);
		self thread namespace_97ac1184::function_7e18304e("spx_save_data", "mc_title_1", self.var_pers["mc_title_1"], 0);
		function_iprintln("^8[Challenges] ^7Skyblock Ultimate Completionist Completed");
	}
	wait(0.05);
	self thread namespace_97ac1184::function_231f215a();
}

/*
	Name: function_8a383506
	Namespace: namespace_zm_daily_challenges
	Checksum: 0x424F4353
	Offset: 0x27B8
	Size: 0xC28
	Parameters: 0
	Flags: None
	Line Number: 401
*/
function function_8a383506()
{
	self namespace_globallogic_score::function_initPersStat("map0_motd_rounds", 0);
	self namespace_globallogic_score::function_initPersStat("map0_motd_kills", 0);
	self namespace_globallogic_score::function_initPersStat("map0_motd_escape", 0);
	self namespace_globallogic_score::function_initPersStat("map0_motd_golden_escape", 0);
	self namespace_globallogic_score::function_initPersStat("map0_motd_headshots", 0);
	self namespace_globallogic_score::function_initPersStat("map0_motd_perks", 0);
	self namespace_globallogic_score::function_initPersStat("map0_motd_revive", 0);
	self namespace_globallogic_score::function_initPersStat("map0_motd_dog_heads", 0);
	self namespace_globallogic_score::function_initPersStat("map0_motd_blundergat", 0);
	self namespace_globallogic_score::function_initPersStat("map0_motd_bridge_kills", 0);
	self namespace_globallogic_score::function_initPersStat("map0_motd_warden_kills", 0);
	self namespace_globallogic_score::function_initPersStat("map0_motd_hells_retriever", 0);
	self namespace_globallogic_score::function_initPersStat("map0_motd_pack_a_punched", 0);
	self namespace_globallogic_score::function_initPersStat("map0_motd_pack_a_punched_multiple", 0);
	self namespace_globallogic_score::function_initPersStat("map0_motd_pack_a_punched_multiple_2", 0);
	self namespace_globallogic_score::function_initPersStat("map0_motd_enchantment_kills", 0);
	self namespace_globallogic_score::function_initPersStat("map0_motd_enchantment_kills_2", 0);
	self namespace_globallogic_score::function_initPersStat("map0_motd_enchantment_kills_3", 0);
	self namespace_globallogic_score::function_initPersStat("map0_motd_complete_all", 0);
	self namespace_globallogic_score::function_initPersStat("map0_skyblock_rounds", 0);
	self namespace_globallogic_score::function_initPersStat("map0_skyblock_kills", 0);
	self namespace_globallogic_score::function_initPersStat("map0_skyblock_longshots", 0);
	self namespace_globallogic_score::function_initPersStat("map0_skyblock_ads", 0);
	self namespace_globallogic_score::function_initPersStat("map0_skyblock_enchantment", 0);
	self namespace_globallogic_score::function_initPersStat("map0_skyblock_headshots", 0);
	self namespace_globallogic_score::function_initPersStat("map0_skyblock_perks", 0);
	self namespace_globallogic_score::function_initPersStat("map0_skyblock_end_kills", 0);
	self namespace_globallogic_score::function_initPersStat("map0_skyblock_desert_kills", 0);
	self namespace_globallogic_score::function_initPersStat("map0_skyblock_enchantment_ritual_kills", 0);
	self namespace_globallogic_score::function_initPersStat("map0_skyblock_wildlands_kills", 0);
	self namespace_globallogic_score::function_initPersStat("map0_skyblock_complete_all", 0);
	self namespace_globallogic_score::function_initPersStat("map0_verruckt_rounds", 0);
	self namespace_globallogic_score::function_initPersStat("map0_verruckt_kills", 0);
	self namespace_globallogic_score::function_initPersStat("map0_verruckt_headshots", 0);
	self namespace_globallogic_score::function_initPersStat("map0_verruckt_longshots", 0);
	self namespace_globallogic_score::function_initPersStat("map0_verruckt_ads", 0);
	self namespace_globallogic_score::function_initPersStat("map0_verruckt_pack", 0);
	self namespace_globallogic_score::function_initPersStat("map0_verruckt_perks", 0);
	self namespace_globallogic_score::function_initPersStat("map0_shinonuma_rounds", 0);
	self namespace_globallogic_score::function_initPersStat("map0_shinonuma_kills", 0);
	self namespace_globallogic_score::function_initPersStat("map0_shinonuma_headshots", 0);
	self namespace_globallogic_score::function_initPersStat("map0_shinonuma_longshots", 0);
	self namespace_globallogic_score::function_initPersStat("map0_shinonuma_ads", 0);
	self namespace_globallogic_score::function_initPersStat("map0_shinonuma_pack", 0);
	self namespace_globallogic_score::function_initPersStat("map0_shinonuma_perks", 0);
	self namespace_globallogic_score::function_initPersStat("map0_shoothouse_rounds", 0);
	self namespace_globallogic_score::function_initPersStat("map0_shoothouse_kills", 0);
	self namespace_globallogic_score::function_initPersStat("map0_shoothouse_longshots", 0);
	self namespace_globallogic_score::function_initPersStat("map0_shoothouse_ads", 0);
	self namespace_globallogic_score::function_initPersStat("map0_shoothouse_box", 0);
	self namespace_globallogic_score::function_initPersStat("map0_shoothouse_crouch", 0);
	self namespace_globallogic_score::function_initPersStat("map0_shoothouse_headshots", 0);
	self namespace_globallogic_score::function_initPersStat("map0_shoothouse_pack", 0);
	self namespace_globallogic_score::function_initPersStat("cc2_massacre_undead", 0);
	self namespace_globallogic_score::function_initPersStat("cc2_headshot_hunter", 0);
	self namespace_globallogic_score::function_initPersStat("cc2_round_master", 0);
	self namespace_globallogic_score::function_initPersStat("cc2_big_spender", 0);
	self namespace_globallogic_score::function_initPersStat("cc2_box_hoarder", 0);
	self namespace_globallogic_score::function_initPersStat("cc2_perk_enthusiast", 0);
	self namespace_globallogic_score::function_initPersStat("cc2_gift_collector", 0);
	self namespace_globallogic_score::function_initPersStat("cc2_repack", 0);
	self namespace_globallogic_score::function_initPersStat("cc2_ads_specialist", 0);
	self namespace_globallogic_score::function_initPersStat("cc2_headshot_longshot_slayer", 0);
	self namespace_globallogic_score::function_initPersStat("cc2_rapid_mayhem", 0);
	self namespace_globallogic_score::function_initPersStat("cc2_hipfire_veteran", 0);
	self namespace_globallogic_score::function_initPersStat("cc2_perk_collector", 0);
	self namespace_globallogic_score::function_initPersStat("cc2_gift_hoarder", 0);
	self namespace_globallogic_score::function_initPersStat("cc2_flawless_survivor", 0);
	self namespace_globallogic_score::function_initPersStat("cc2_fire_sale_specialist", 0);
	self namespace_globallogic_score::function_initPersStat("cc2_wonder_weapon_slayer", 0);
	self namespace_globallogic_score::function_initPersStat("cc2_headshot_specialist", 0);
	self namespace_globallogic_score::function_initPersStat("cc2_ar_master", 0);
	self namespace_globallogic_score::function_initPersStat("cc2_smg_slayer", 0);
	self namespace_globallogic_score::function_initPersStat("cc2_upgraded_killer", 0);
	self namespace_globallogic_score::function_initPersStat("cc2_melee_mayhem", 0);
	self namespace_globallogic_score::function_initPersStat("cc2_consecutive_headshot_master", 0);
	self namespace_globallogic_score::function_initPersStat("cc2_round_grinder", 0);
	self namespace_globallogic_score::function_initPersStat("cc2_mythic_enchanter", 0);
	self namespace_globallogic_score::function_initPersStat("cc2_undead_saint_slayer", 0);
	self namespace_globallogic_score::function_initPersStat("cc2_crouched_killed", 0);
	self namespace_globallogic_score::function_initPersStat("cc2_gift_savior", 0);
	self namespace_globallogic_score::function_initPersStat("cc2_lmg_dominator", 0);
	self namespace_globallogic_score::function_initPersStat("cc2_perk_perfectionist", 0);
	self namespace_globallogic_score::function_initPersStat("cc2_hipfire_sniper", 0);
	self namespace_globallogic_score::function_initPersStat("cc2_door_master", 0);
	self namespace_globallogic_score::function_initPersStat("cc2_powerups_master", 0);
	self namespace_globallogic_score::function_initPersStat("cc2_sniper_expert", 0);
	self namespace_globallogic_score::function_initPersStat("cc2_shotgun_savior", 0);
	self namespace_globallogic_score::function_initPersStat("cc2_pistol_perfectionist", 0);
	self namespace_globallogic_score::function_initPersStat("cc2_explosive_expert", 0);
	self namespace_globallogic_score::function_initPersStat("cc2_packed_precision", 0);
	self namespace_globallogic_score::function_initPersStat("cc2_no_perk_master", 0);
	self namespace_globallogic_score::function_initPersStat("cc2_round_completionist", 0);
	self namespace_globallogic_score::function_initPersStat("cc2_kill_completionist", 0);
	self namespace_globallogic_score::function_initPersStat("cc2_perk_completionist", 0);
	self namespace_globallogic_score::function_initPersStat("cc2_weapon_completionist", 0);
	self namespace_globallogic_score::function_initPersStat("cc2_ultimate_completionist", 0);
}

/*
	Name: function_9bbe41da
	Namespace: namespace_zm_daily_challenges
	Checksum: 0x424F4353
	Offset: 0x33E8
	Size: 0x38
	Parameters: 0
	Flags: None
	Line Number: 512
*/
function function_9bbe41da()
{
	self endon("hash_disconnect");
	wait(0.05);
	level namespace_flag::function_wait_till("initial_blackscreen_passed");
}

/*
	Name: function_c1b361af
	Namespace: namespace_zm_daily_challenges
	Checksum: 0x424F4353
	Offset: 0x3428
	Size: 0x60
	Parameters: 0
	Flags: None
	Line Number: 529
*/
function function_c1b361af()
{
	self endon("hash_disconnect");
	for(;;)
	{
		self waittill("hash_menuresponse", var_menu, var_response);
		if(var_menu == "gettimemenu")
		{
			function_IPrintLnBold(var_response);
		}
	}
}

/*
	Name: function_96f9b29
	Namespace: namespace_zm_daily_challenges
	Checksum: 0x424F4353
	Offset: 0x3490
	Size: 0x108
	Parameters: 1
	Flags: Private
	Line Number: 552
*/
function private function_96f9b29(var_34d37a48)
{
	function_8b57c052("gettime", "");
	for(;;)
	{
		wait(0.05);
		var_dvar_value = function_GetDvarString("gettime", "");
		if(isdefined(var_dvar_value) && var_dvar_value != "")
		{
			function_8b57c052("gettime", "");
			function_GetPlayers()[0] function_SetControllerUIModelValue("UEM.get_current_time", var_dvar_value);
			wait(0.05);
			function_GetPlayers()[0] function_SetControllerUIModelValue("UEM.get_current_time", 0);
		}
	}
}

