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

#namespace zm_daily_challenges;

/*
	Name: __init__sytem__
	Namespace: zm_daily_challenges
	Checksum: 0x424F4353
	Offset: 0xB08
	Size: 0x38
	Parameters: 0
	Flags: AutoExec
	Line Number: 63
*/
function autoexec __init__sytem__()
{
	system::register("zm_daily_challenges_uem", &__init__, undefined, undefined);
	return;
	ERROR: Exception occured: Stack empty.
	ERROR: Exception occured: Stack empty.
}

/*
	Name: __init__
	Namespace: zm_daily_challenges
	Checksum: 0x424F4353
	Offset: 0xB48
	Size: 0x28
	Parameters: 0
	Flags: None
	Line Number: 81
*/
function __init__()
{
	callback::on_connect(&function_8cb3edd7);
}

/*
	Name: function_8cb3edd7
	Namespace: zm_daily_challenges
	Checksum: 0x424F4353
	Offset: 0xB78
	Size: 0x2E0
	Parameters: 0
	Flags: None
	Line Number: 96
*/
function function_8cb3edd7()
{
	self endon("disconnect");
	self thread function_8a383506();
	while(1)
	{
		self waittill("hash_63cf7d21", challenge, var_d3d8af77, max, var_6c47d281, player_points, var_2a4ca729, var_994b33dd);
		if(!isdefined(challenge))
		{
			continue;
		}
		if(isdefined(self.pers[challenge]) && self.pers[challenge] < max)
		{
			self.pers[challenge] = self.pers[challenge] + var_d3d8af77;
			if(self.pers[challenge] >= max)
			{
				self.pers[challenge] = max;
				if(isdefined(player_points) && player_points)
				{
					self.pers["player_points"] = self.pers["player_points"] + var_6c47d281;
				}
				else
				{
					var_9e7ab2f5 = self function_dbd38088(var_6c47d281);
					if(self.var_b74a3cd1["prestige"] > 0)
					{
						self notify("hash_79ef118b", "halloween_challenge_" + challenge, var_6c47d281 * self.var_b74a3cd1["prestige"]);
					}
					else
					{
						self notify("hash_79ef118b", "halloween_challenge_" + challenge, var_6c47d281);
					}
				}
				if(isdefined(var_2a4ca729))
				{
					self.pers[var_2a4ca729] = 1;
					self thread namespace_97ac1184::function_7e18304e("spx_save_data", var_2a4ca729, self.pers[var_2a4ca729], 0);
				}
				if(isdefined(var_994b33dd))
				{
					self.pers[var_994b33dd] = 1;
					self thread namespace_97ac1184::function_7e18304e("spx_save_data", var_994b33dd, self.pers[var_994b33dd], 0);
				}
				wait(0.05);
				self thread function_6711b7c3();
			}
			wait(0.05);
			self thread namespace_97ac1184::function_7e18304e("spx_save_data", challenge, self.pers[challenge], 0);
			else
			{
			}
		}
	}
}

/*
	Name: function_dbd38088
	Namespace: zm_daily_challenges
	Checksum: 0x424F4353
	Offset: 0xE60
	Size: 0x180
	Parameters: 1
	Flags: None
	Line Number: 161
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
	Name: function_6711b7c3
	Namespace: zm_daily_challenges
	Checksum: 0x424F4353
	Offset: 0xFE8
	Size: 0x898
	Parameters: 0
	Flags: None
	Line Number: 197
*/
function function_6711b7c3()
{
	wait(0.05);
	if(self.pers["hc2_trick_or_treat"] >= 150 && self.pers["halloween_pumpkin_hat"] != 1)
	{
		self.pers["halloween_pumpkin_hat"] = 1;
		self iprintln("^8[Challenges] ^7Completed Hat Challenges");
	}
	wait(0.05);
	if(self.pers["hc2_rounds"] >= 250 && self.pers["hc2_round_35_five_times"] >= 5 && self.pers["hc2_no_damage_rounds"] >= 35 && self.pers["hc2_trick_or_treat_single_game"] >= 10 && self.pers["hc2_perk_master"] >= 5 && self.pers["hc2_perfect_game"] >= 1 && self.pers["hc2_complete_round_challenges"] < 1)
	{
		self notify("hash_63cf7d21", "hc2_complete_round_challenges", 1, 1, 100000, "halloween_pet");
		self.pers["halloween_pet"] = 1;
		self iprintln("^8[Challenges] ^7Completed Round Challenges");
	}
	wait(0.05);
	if(self.pers["hc2_kills"] >= 25000 && self.pers["hc2_headshots"] >= 6000 && self.pers["hc2_repack"] >= 75 && self.pers["hc2_rapidkills"] >= 2500 && self.pers["hc2_melee_kills"] >= 1500 && self.pers["hc2_ghost_kills"] >= 12 && self.pers["hc2_ads_kills"] >= 1000 && self.pers["hc2_crouch_kills"] >= 750 && self.pers["hc2_sniper_kills"] >= 1500 && self.pers["hc2_pistol_kills"] >= 1000 && self.pers["hc2_ar_kills"] >= 2500 && self.pers["hc2_shotgun_kills"] >= 1500 && self.pers["hc2_smg_kills"] >= 2500 && self.pers["hc2_lmg_kills"] >= 3000 && self.pers["hc2_hipfire_kills"] >= 450 && self.pers["hc2_explosive_kills"] >= 2500 && self.pers["hc2_longshot_pap_kills"] >= 1500 && self.pers["hc2_consecutive_headshots"] >= 1500 && self.pers["hc2_upgraded_kills"] >= 5000 && self.pers["hc2_kill_challenges_complete"] < 1)
	{
		self notify("hash_63cf7d21", "hc2_kill_challenges_complete", 1, 1, 250000, "halloween_camo");
		self.pers["halloween_camo"] = 1;
		self iprintln("^8[Challenges] ^7Completed Kill Challenges");
	}
	wait(0.05);
	if(self.pers["hc2_kills"] >= 25000 && self.pers["hc2_headshots"] >= 6000 && self.pers["hc2_rounds"] >= 250 && self.pers["hc2_repack"] >= 75 && self.pers["hc2_trick_or_treat"] >= 150 && self.pers["hc2_random_box"] >= 175 && self.pers["hc2_rapidkills"] >= 2500 && self.pers["hc2_melee_kills"] >= 1500 && self.pers["hc2_perks_purchased"] >= 75 && self.pers["hc2_ghost_kills"] >= 12 && self.pers["hc2_spend_points"] >= 2000000 && self.pers["hc2_ads_kills"] >= 1000 && self.pers["hc2_crouch_kills"] >= 750 && self.pers["hc2_round_35_five_times"] >= 5 && self.pers["hc2_single_game_headshots"] >= 500 && self.pers["hc2_sniper_kills"] >= 1500 && self.pers["hc2_pistol_kills"] >= 1000 && self.pers["hc2_ar_kills"] >= 2500 && self.pers["hc2_shotgun_kills"] >= 1500 && self.pers["hc2_smg_kills"] >= 2500 && self.pers["hc2_lmg_kills"] >= 3000 && self.pers["hc2_hipfire_kills"] >= 450 && self.pers["hc2_no_damage_rounds"] >= 35 && self.pers["hc2_fire_sale_weapons"] >= 35 && self.pers["hc2_trick_or_treat_single_game"] >= 10 && self.pers["hc2_perk_master"] >= 5 && self.pers["hc2_explosive_kills"] >= 2500 && self.pers["hc2_consecutive_headshots"] >= 1500 && self.pers["hc2_longshot_pap_kills"] >= 1500 && self.pers["hc2_upgraded_kills"] >= 5000 && self.pers["hc2_perfect_game"] >= 1 && self.pers["hc2_complete_round_challenges"] >= 1 && self.pers["hc2_kill_challenges_complete"] >= 1 && self.pers["hc2_all_challenges"] < 1)
	{
		self notify("hash_63cf7d21", "hc2_all_challenges", 1, 1, 250000, "halloween_camo_2", "halloween_title");
		self.pers["halloween_camo_2"] = 1;
		self.pers["halloween_title"] = 1;
		self iprintln("^8[Challenges] ^7Completed All Challenges");
	}
	wait(0.05);
	self thread namespace_97ac1184::function_231f215a();
}

/*
	Name: function_8a383506
	Namespace: zm_daily_challenges
	Checksum: 0x424F4353
	Offset: 0x1888
	Size: 0x448
	Parameters: 0
	Flags: None
	Line Number: 241
*/
function function_8a383506()
{
	self globallogic_score::initPersStat("hc2_kills", 0);
	self globallogic_score::initPersStat("hc2_headshots", 0);
	self globallogic_score::initPersStat("hc2_rounds", 0);
	self globallogic_score::initPersStat("hc2_repack", 0);
	self globallogic_score::initPersStat("hc2_trick_or_treat", 0);
	self globallogic_score::initPersStat("hc2_random_box", 0);
	self globallogic_score::initPersStat("hc2_rapidkills", 0);
	self globallogic_score::initPersStat("hc2_melee_kills", 0);
	self globallogic_score::initPersStat("hc2_perks_purchased", 0);
	self globallogic_score::initPersStat("hc2_ghost_kills", 0);
	self globallogic_score::initPersStat("hc2_spend_points", 0);
	self globallogic_score::initPersStat("hc2_ads_kills", 0);
	self globallogic_score::initPersStat("hc2_crouch_kills", 0);
	self globallogic_score::initPersStat("hc2_round_35_five_times", 0);
	self globallogic_score::initPersStat("hc2_single_game_headshots", 0);
	self globallogic_score::initPersStat("hc2_sniper_kills", 0);
	self globallogic_score::initPersStat("hc2_pistol_kills", 0);
	self globallogic_score::initPersStat("hc2_ar_kills", 0);
	self globallogic_score::initPersStat("hc2_shotgun_kills", 0);
	self globallogic_score::initPersStat("hc2_smg_kills", 0);
	self globallogic_score::initPersStat("hc2_lmg_kills", 0);
	self globallogic_score::initPersStat("hc2_hipfire_kills", 0);
	self globallogic_score::initPersStat("hc2_no_damage_rounds", 0);
	self globallogic_score::initPersStat("hc2_fire_sale_weapons", 0);
	self globallogic_score::initPersStat("hc2_trick_or_treat_single_game", 0);
	self globallogic_score::initPersStat("hc2_perk_master", 0);
	self globallogic_score::initPersStat("hc2_explosive_kills", 0);
	self globallogic_score::initPersStat("hc2_consecutive_headshots", 0);
	self globallogic_score::initPersStat("hc2_longshot_pap_kills", 0);
	self globallogic_score::initPersStat("hc2_upgraded_kills", 0);
	self globallogic_score::initPersStat("hc2_perfect_game", 0);
	self globallogic_score::initPersStat("hc2_complete_round_challenges", 0);
	self globallogic_score::initPersStat("hc2_kill_challenges_complete", 0);
	self globallogic_score::initPersStat("hc2_all_challenges", 0);
	return;
}

/*
	Name: function_9bbe41da
	Namespace: zm_daily_challenges
	Checksum: 0x424F4353
	Offset: 0x1CD8
	Size: 0x38
	Parameters: 0
	Flags: None
	Line Number: 290
*/
function function_9bbe41da()
{
	self endon("disconnect");
	wait(0.05);
	level flag::wait_till("initial_blackscreen_passed");
}

/*
	Name: function_c1b361af
	Namespace: zm_daily_challenges
	Checksum: 0x424F4353
	Offset: 0x1D18
	Size: 0x60
	Parameters: 0
	Flags: None
	Line Number: 307
*/
function function_c1b361af()
{
	self endon("disconnect");
	for(;;)
	{
		self waittill("menuresponse", menu, response);
		if(menu == "gettimemenu")
		{
			iprintlnbold(response);
		}
	}
}

/*
	Name: function_96f9b29
	Namespace: zm_daily_challenges
	Checksum: 0x424F4353
	Offset: 0x1D80
	Size: 0x108
	Parameters: 1
	Flags: Private
	Line Number: 330
*/
function private function_96f9b29(var_34d37a48)
{
	function_8b57c052("gettime", "");
	for(;;)
	{
		wait(0.05);
		dvar_value = getdvarstring("gettime", "");
		if(isdefined(dvar_value) && dvar_value != "")
		{
			function_8b57c052("gettime", "");
			getplayers()[0] SetControllerUIModelValue("UEM.get_current_time", dvar_value);
			wait(0.05);
			getplayers()[0] SetControllerUIModelValue("UEM.get_current_time", 0);
		}
	}
}

