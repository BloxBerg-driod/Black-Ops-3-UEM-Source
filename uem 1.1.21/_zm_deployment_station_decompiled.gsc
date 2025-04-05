#include scripts\codescripts\struct;
#include scripts\shared\aat_shared;
#include scripts\shared\ai\zombie_utility;
#include scripts\shared\array_shared;
#include scripts\shared\callbacks_shared;
#include scripts\shared\clientfield_shared;
#include scripts\shared\compass;
#include scripts\shared\flag_shared;
#include scripts\shared\gameobjects_shared;
#include scripts\shared\laststand_shared;
#include scripts\shared\lui_shared;
#include scripts\shared\scene_shared;
#include scripts\shared\spawner_shared;
#include scripts\shared\system_shared;
#include scripts\shared\util_shared;
#include scripts\sphynx\leveling\_zm_sphynx_leveling;
#include scripts\sphynx\weapons\_zm_weapon_drop_system;
#include scripts\zm\_zm;
#include scripts\zm\_zm_audio;
#include scripts\zm\_zm_equipment;
#include scripts\zm\_zm_hero_weapon;
#include scripts\zm\_zm_magicbox;
#include scripts\zm\_zm_perks;
#include scripts\zm\_zm_score;
#include scripts\zm\_zm_spawner;
#include scripts\zm\_zm_stats;
#include scripts\zm\_zm_unitrigger;
#include scripts\zm\_zm_utility;
#include scripts\zm\_zm_weapon_upgrade_system;
#include scripts\zm\_zm_weapons;
#include scripts\zm\_zm_zonemgr;
#include scripts\zm\gametypes\_globallogic_player;
#include scripts\zm\gametypes\_globallogic_spawn;

#namespace namespace_a74e4f35;

/*
	Name: function___init__sytem__
	Namespace: namespace_a74e4f35
	Checksum: 0x424F4353
	Offset: 0x1B08
	Size: 0x38
	Parameters: 0
	Flags: AutoExec
	Line Number: 46
*/
function autoexec function___init__sytem__()
{
	namespace_system::function_register("zm_deployment_station", &function___init__, undefined, undefined);
}

/*
	Name: function___init__
	Namespace: namespace_a74e4f35
	Checksum: 0x424F4353
	Offset: 0x1B48
	Size: 0x450
	Parameters: 0
	Flags: None
	Line Number: 61
*/
function function___init__()
{
	namespace_util::function_registerClientSys("UEM.ExfilUI");
	level.var_e33eb0d5 = function_Array("ray_gun", "raygun_mark2", "raygun_mark3", "ray_gun_up", "raygun_mark2_up", "ray_gun_upgraded", "raygun_mark2_upgraded", "raygun_mark3_up", "raygun_mark3_upgraded", "thundergun", "idgun_0", "idgun_1", "idgun_2", "idgun_3", "idgun_upgraded_0", "idgun_genesis_0", "idgun_genesis_0_upgraded", "staff_fire", "staff_water", "staff_lightning", "staff_air", "idgun_upgraded_1", "idgun_upgraded_2", "idgun_upgraded_3", "t7_idgun_genesis_0", "t7_idgun_genesis_0_upgraded", "thundergun_upgraded", "t7_staff_air", "t7_staff_fire", "t7_staff_lightning", "t7_staff_water", "t7_hero_mirg2000", "t8_shotgun_blundergat", "t8_shotgun_acidgat", "t8_shotgun_magmagat", "t8_zombie_tomahawk", "t7_shrink_ray", "t7_staff_air_upgraded", "t7_staff_fire_upgraded", "t7_staff_lightning_upgraded", "t7_staff_water_upgraded", "t7_hero_mirg2000_upgraded", "t8_shotgun_blundergat_upgraded", "t8_shotgun_acidgat_upgraded", "t8_shotgun_magmagat_upgraded", "t8_zombie_tomahawk_upgraded", "t7_shrink_ray_upgraded", "t7_microwavegundw_upgraded", "t9_gallo_raygun", "t9_gallo_raygun_up", "staff_fire_upgraded", "staff_water_upgraded", "staff_lightning_upgraded", "staff_air_upgraded", "elemental_bow", "elemental_bow_storm", "elemental_bow_demongate", "elemental_bow_rune_prison", "elemental_bow_wolf", "t9_crossbow_skull", "t9_crossbow_skull_up", "shrink_ray", "madgaz_cng_zm", "madgaz_cng2_zm", "madgaz_cng3_zm", "tesla_gun", "tesla_gun_upgraded", "shrink_ray_upgraded", "madgaz_cng_upgraded_zm", "madgaz_cng2_upgraded_zm", "madgaz_cng3_upgraded_zm", "t7_microwavegundw", "microwavegundw", "microwavegundw_upgraded", "elemental_bow_wolf_howl", "pistol_m1911_upgraded", "t8_blundergat", "t8_blundergat_upgraded", "t8_blundersplat", "t8_blundersplat_upgraded", "t8_magmagat", "t8_magmagat_upgraded", "t6_xl_ray_gun", "t6_xl_ray_gun_up", "t6_xl_raygun_mark2", "t6_xl_raygun_mark2_up");
	level.var__effect["deployment_station_hologram_ammo"] = "_sphynx/_zm_hologram_deployment_station";
	level.var__effect["deployment_station_break"] = "dlc1/castle/fx_castle_electric_cherry_trail";
	level.var__effect["deployment_station_exfil_nuke_explosion"] = "custom/explosion/bow_arrow_explode_os";
	level.var_679e1a9e = 0;
	level.var_22a274bc = 1;
	level.var_6e1a05ca = 15;
	level.var_abcf67a6 = 0;
	level namespace_flag::function_init("exfil_activated");
	level namespace_flag::function_init("exfil_kills_completed");
	level thread function_737643fd();
	level thread function_f18486d2();
	namespace_callback::function_on_spawned(&function_on_player_spawned);
	wait(0.05);
	level namespace_flag::function_wait_till("initial_blackscreen_passed");
	level.var_ee5d3b93 = level.var_zombie_vars["zombie_between_round_time"];
	level.var_8e473ceb = level.var_zombie_vars["zombie_move_speed_multiplier"];
}

/*
	Name: function_737643fd
	Namespace: namespace_a74e4f35
	Checksum: 0x424F4353
	Offset: 0x1FA0
	Size: 0x138
	Parameters: 0
	Flags: None
	Line Number: 93
*/
function function_737643fd()
{
	level endon("hash_end_game");
	for(;;)
	{
		level waittill("hash_between_round_over");
		if(level.var_round_number == level.var_6e1a05ca && level.var_round_number != level.var_next_dog_round)
		{
			level.var_abcf67a6 = 1;
			level namespace_util::function_waittill_any_return("end_of_round", "increase_exfil_round");
			level.var_6e1a05ca = level.var_6e1a05ca + 5;
			level.var_abcf67a6 = 0;
		}
		else if(level.var_round_number == level.var_6e1a05ca && level.var_round_number == level.var_next_dog_round)
		{
			level.var_6e1a05ca = level.var_6e1a05ca + 1;
			if(level.var_round_number != level.var_6e1a05ca)
			{
			}
			else
			{
				level namespace_util::function_waittill_any_return("end_of_round", "increase_exfil_round");
				level.var_6e1a05ca = level.var_6e1a05ca + 4;
				level.var_abcf67a6 = 0;
			}
		}
	}
}

/*
	Name: function_f18486d2
	Namespace: namespace_a74e4f35
	Checksum: 0x424F4353
	Offset: 0x20E0
	Size: 0x2F0
	Parameters: 0
	Flags: None
	Line Number: 132
*/
function function_f18486d2()
{
	level endon("hash_end_game");
	while(1)
	{
		wait(10);
		foreach(var_player in function_GetPlayers())
		{
			if(function_GetPlayers().size >= 2)
			{
				if(var_player == function_GetPlayers()[0])
				{
					if(level namespace_flag::function_get("classic_enabled") || level namespace_flag::function_get("loot_mode_active"))
					{
						var_player.var_beea7f3e = function_Array("exfil", "rageinducer");
					}
					else
					{
						var_player.var_beea7f3e = function_Array("ammo", "wunderfizz", "cashshare", "exfil", "rageinducer");
					}
				}
				else if(level namespace_flag::function_get("classic_enabled") || level namespace_flag::function_get("loot_mode_active"))
				{
					var_player.var_beea7f3e = function_Array("");
				}
				else
				{
					var_player.var_beea7f3e = function_Array("ammo", "wunderfizz", "cashshare");
					continue;
				}
			}
			if(var_player == function_GetPlayers()[0])
			{
				if(level namespace_flag::function_get("classic_enabled") || level namespace_flag::function_get("loot_mode_active"))
				{
					var_player.var_beea7f3e = function_Array("exfil", "rageinducer");
					continue;
				}
				var_player.var_beea7f3e = function_Array("ammo", "wunderfizz", "exfil", "rageinducer");
			}
		}
	}
	return;
	ERROR: Exception occured: Stack empty.
}

/*
	Name: function_on_player_spawned
	Namespace: namespace_a74e4f35
	Checksum: 0x424F4353
	Offset: 0x23D8
	Size: 0x510
	Parameters: 0
	Flags: None
	Line Number: 188
*/
function function_on_player_spawned()
{
	self endon("hash_bled_out");
	self endon("hash_spawned_player");
	self endon("hash_disconnect");
	wait(0.05);
	level namespace_flag::function_wait_till("initial_blackscreen_passed");
	wait(2);
	self.var_1bfcbff5 = 0;
	if(function_GetPlayers().size >= 2)
	{
		if(self == function_GetPlayers()[0])
		{
			if(level namespace_flag::function_get("classic_enabled") || level namespace_flag::function_get("loot_mode_active"))
			{
				self.var_beea7f3e = function_Array("exfil", "rageinducer");
			}
			else
			{
				self.var_beea7f3e = function_Array("ammo", "wunderfizz", "cashshare", "exfil", "rageinducer");
			}
		}
		else if(level namespace_flag::function_get("classic_enabled") || level namespace_flag::function_get("loot_mode_active"))
		{
			self.var_beea7f3e = function_Array("");
		}
		else
		{
			self.var_beea7f3e = function_Array("ammo", "wunderfizz", "cashshare");
		}
	}
	else if(self == function_GetPlayers()[0])
	{
		if(level namespace_flag::function_get("classic_enabled") || level namespace_flag::function_get("loot_mode_active"))
		{
			self.var_beea7f3e = function_Array("exfil", "rageinducer");
		}
		else
		{
			self.var_beea7f3e = function_Array("ammo", "wunderfizz", "exfil", "rageinducer");
		}
	}
	while(self function_ActionSlotFourButtonPressed() && (isdefined(level.var_22a274bc) && level.var_22a274bc) && self.var_beea7f3e.size > 0)
	{
		if(isdefined(self.var_78f55b66))
		{
			self.var_78f55b66.var_owner notify("hash_ba61275c");
			wait(2);
		}
		else
		{
			wait(0.2);
			self.var_78f55b66 = namespace_util::function_spawn_model("tag_origin", self.var_origin, self.var_angles);
			var_playable_area = function_GetEntArray("player_volume", "script_noteworthy");
			var_valid_drop = 0;
			for(var_i = 0; var_i < var_playable_area.size; var_i++)
			{
				if(self.var_78f55b66 function_istouching(var_playable_area[var_i]))
				{
					var_valid_drop = 1;
					break;
				}
			}
			if(isdefined(var_valid_drop) && var_valid_drop)
			{
				self.var_1bfcbff5 = 60;
				self thread function_2688f86d();
				self.var_78f55b66 function_SetModel("p7_zm_ctl_artifact_containment");
				function_playsoundatposition("deployment_station_drop", self.var_origin);
				var_final_pos = self namespace_ecdf5e21::function_a2b97522(undefined, 60, self.var_78f55b66, 1);
				self.var_78f55b66 namespace_ecdf5e21::function_a170d6f0(var_final_pos, 0, 12);
				self.var_78f55b66 thread function_cad8d6d5(self, 60);
				wait(2);
			}
			else
			{
				self.var_78f55b66 function_delete();
				wait(2);
			}
		}
		wait(0.05);
	}
}

/*
	Name: function_2688f86d
	Namespace: namespace_a74e4f35
	Checksum: 0x424F4353
	Offset: 0x28F0
	Size: 0x50
	Parameters: 0
	Flags: None
	Line Number: 282
*/
function function_2688f86d()
{
	self endon("hash_bled_out");
	self endon("hash_spawned_player");
	self endon("hash_disconnect");
	while(self.var_1bfcbff5 > 0)
	{
		self.var_1bfcbff5--;
		wait(1);
	}
}

/*
	Name: function_cad8d6d5
	Namespace: namespace_a74e4f35
	Checksum: 0x424F4353
	Offset: 0x2948
	Size: 0x3F8
	Parameters: 2
	Flags: None
	Line Number: 304
*/
function function_cad8d6d5(var_owner, var_60a2c1f7)
{
	var_owner namespace_flag::function_init("deployment_machine_can_reset");
	self.var_54735102 = 0;
	self function_EnableLinkTo();
	wait(1);
	function_playsoundatposition("deployment_station_activate", self.var_origin);
	self function_PlayLoopSound("deployment_station_idle");
	self.var_owner = var_owner;
	self.var_e42e02e3 = 0;
	self.var_9186076d = namespace_util::function_spawn_model("tag_origin", self.var_origin, self.var_angles);
	self.var_9186076d = function_PlayFXOnTag(level.var__effect["deployment_station_hologram_ammo"], self.var_9186076d, "tag_origin");
	if(level namespace_flag::function_get("classic_enabled"))
	{
		self.var_40b69c4c = namespace_util::function_spawn_model("zmu_nuke_hologram_disabled", self.var_origin + VectorScale((0, 0, 1), 40), self.var_angles);
	}
	else
	{
		self.var_40b69c4c = namespace_util::function_spawn_model("zmu_bullet_hologram", self.var_origin + VectorScale((0, 0, 1), 40), self.var_angles);
	}
	self.var_40b69c4c thread function_2fc45e69();
	self.var_9186076d function_LinkTo(self);
	if(function_ToLower(function_GetDvarString("mapname")) != "zm_castle")
	{
		self namespace_clientfield::function_set("weapon_drop_level_enable_keyline", 2);
	}
	else
	{
		self namespace_clientfield::function_set("weapon_drop_enable_keyline", 2);
	}
	self thread function_549fbbec(var_60a2c1f7);
	self thread function_561555f1(var_owner);
	self function_create_unitrigger(&"ZM_MINECRAFT_DEPLOYMENT_STATION_DISABLED", undefined, &function_5b42a9c7);
	while(isdefined(self))
	{
		self waittill("hash_trigger_activated", var_player);
		switch(var_player.var_beea7f3e[self.var_54735102])
		{
			case "ammo":
			{
				self thread function_1de4829(var_player);
				break;
			}
			case "wunderfizz":
			{
				self thread function_bced5f58(var_player);
				break;
			}
			case "cashshare":
			{
				self thread function_c0efee41(var_player);
				break;
			}
			case "exfil":
			{
				self thread function_ab74af48(var_player);
				break;
			}
			case "rageinducer":
			{
				if(!(isdefined(self.var_e42e02e3) && self.var_e42e02e3))
				{
					self thread function_6d9383c(var_player);
					break;
				}
			}
		}
		wait(0.2);
	}
}

/*
	Name: function_bced5f58
	Namespace: namespace_a74e4f35
	Checksum: 0x424F4353
	Offset: 0x2D48
	Size: 0x4D8
	Parameters: 1
	Flags: None
	Line Number: 385
*/
function function_bced5f58(var_player)
{
	wait(0.1);
	if(!(isdefined(self.var_4c2c3d65) && self.var_4c2c3d65))
	{
		while(1)
		{
			var_player namespace_flag::function_clear("deployment_machine_can_reset");
			if(!var_player namespace_zm_score::function_can_player_purchase(level.var__random_zombie_perk_cost + var_player.var_num_perks * 250) || !var_player namespace_zm_utility::function_can_player_purchase_perk() || (isdefined(var_player function_player_has_all_available_perks()) && var_player function_player_has_all_available_perks()) || var_player.var_9ee9bcc6 < 10)
			{
				self function_playsound("evt_perk_deny");
				break;
			}
			self.var_owner.var_1bfcbff5 = self.var_owner.var_1bfcbff5 + 15;
			self.var_efe0cd4e = namespace_util::function_spawn_model("tag_origin", self.var_40b69c4c.var_origin, self.var_40b69c4c.var_angles);
			self.var_efe0cd4e = function_PlayFXOnTag("electric/fx_ability_elec_surge_short_robot_optim", self.var_efe0cd4e, "tag_origin");
			self.var_4c2c3d65 = 1;
			self.var_machine_user = var_player;
			var_player namespace_zm_score::function_minus_to_player_score(level.var__random_zombie_perk_cost + var_player.var_num_perks * 250);
			var_player.var_pers["deploy_wunderfizz"]++;
			var_player namespace_zm_stats::function_increment_player_stat("wunderfizz_used");
			var_player thread namespace_97ac1184::function_1d39abf6("end_game_deploy_wunderfizz", 1, 0);
			var_player thread namespace_97ac1184::function_7e18304e("spx_save_data", "deploy_wunderfizz", var_player.var_pers["deploy_wunderfizz"], 0);
			var_random_perk = function_get_weighted_random_perk(var_player);
			wait(1);
			self function_playsound("zmb_rand_perk_start");
			self function_PlayLoopSound("zmb_rand_perk_loop", 1);
			self thread function_start_perk_bottle_cycling();
			self thread function_perk_bottle_motion();
			var_model = function_get_perk_weapon_model(var_random_perk);
			wait(3);
			self notify("hash_done_cycling");
			wait(0.4);
			self.var_40b69c4c function_SetModel(var_model);
			self function_playsound("zmb_rand_perk_bottle");
			self.var_grab_perk_hint = 1;
			self thread function_grab_check(var_player, var_random_perk);
			self thread function_time_out_check(var_player);
			self namespace_util::function_waittill_either("grab_check", "time_out_check");
			self.var_grab_perk_hint = 0;
			self function_playsound("zmb_rand_perk_stop");
			self function_StopLoopSound(0.5);
			self.var_machine_user = undefined;
			self.var_40b69c4c function_SetModel("zmu_wunderfizz_hologram");
			if(isdefined(self.var_efe0cd4e))
			{
				self.var_efe0cd4e function_delete();
				break;
			}
		}
	}
	else
	{
		self function_playsound("evt_perk_deny");
	}
	var_player namespace_flag::function_wait_till("deployment_machine_can_reset");
	self.var_4c2c3d65 = 0;
	wait(0.2);
}

/*
	Name: function_ab74af48
	Namespace: namespace_a74e4f35
	Checksum: 0x424F4353
	Offset: 0x3228
	Size: 0x218
	Parameters: 1
	Flags: None
	Line Number: 455
*/
function function_ab74af48(var_player)
{
	if(!(isdefined(level.var_abcf67a6) && level.var_abcf67a6) || (isdefined(level namespace_flag::function_get("exfil_activated")) && level namespace_flag::function_get("exfil_activated")))
	{
		self.var_40b69c4c function_SetModel("zmu_nuke_hologram_disabled");
		wait(1);
		if(var_player.var_beea7f3e[self.var_54735102] == "exfil")
		{
			self.var_40b69c4c function_SetModel("zmu_nuke_hologram");
			return;
		}
	}
	else
	{
		self.var_owner notify("hash_ba61275c");
		wait(0.1);
		level thread namespace_LUI::function_screen_flash(0.5, 0.5, 0.5, 1, "white");
		wait(0.8);
		var_ecd7621f = namespace_util::function_spawn_model("zmu_nuke_barebones", self.var_origin, self.var_angles - VectorScale((0, 1, 0), 180));
		var_ecd7621f thread function_b45d4781();
		foreach(var_player in function_GetPlayers())
		{
			var_player function_playsoundtoplayer("exfil_objective_start", var_player);
		}
	}
}

/*
	Name: function_b45d4781
	Namespace: namespace_a74e4f35
	Checksum: 0x424F4353
	Offset: 0x3448
	Size: 0x2F0
	Parameters: 1
	Flags: None
	Line Number: 492
*/
function function_b45d4781(var_93d5d8b9)
{
	level namespace_flag::function_set("exfil_activated");
	foreach(var_player in function_GetPlayers())
	{
		var_player function_playsoundtoplayer("mus_exfil_start", var_player);
		var_player.var_pers["exfil_started"]++;
		var_player thread namespace_97ac1184::function_1d39abf6("end_game_exfil_started", 1, 0);
		var_player thread namespace_97ac1184::function_7e18304e("spx_save_data", "exfil_started", var_player.var_pers["exfil_started"], 0);
		wait(0.1 * var_player function_GetEntityNumber() + 1);
	}
	self.var_trigger_use = function_spawn("trigger_radius_use", self.var_origin + VectorScale((0, 0, 1), 40), 0, 100, 100);
	self.var_trigger_use function_TriggerIgnoreTeam();
	self.var_trigger_use function_SetVisibleToAll();
	self.var_trigger_use function_SetTeamForTrigger("none");
	self.var_trigger_use function_UseTriggerRequireLookAt();
	self.var_trigger_use function_setcursorhint("HINT_NOICON");
	self.var_trigger_use function_setHintString(&"ZM_MINECRAFT_EXFIL_NUKE_HINT_START");
	self.var_trigger_use function_TriggerEnable(0);
	self thread function_69808090();
	while(level namespace_flag::function_get("exfil_activated"))
	{
		self.var_trigger_use waittill("hash_trigger", var_player);
		self.var_trigger_use function_delete();
		self function_e78fd5a2();
		wait(0.05);
		break;
	}
}

/*
	Name: function_e78fd5a2
	Namespace: namespace_a74e4f35
	Checksum: 0x424F4353
	Offset: 0x3740
	Size: 0x850
	Parameters: 0
	Flags: None
	Line Number: 532
*/
function function_e78fd5a2()
{
	foreach(var_player in function_GetPlayers())
	{
		var_player function_playsoundtoplayer("exfil_nuke_countdown_popup", var_player);
	}
	wait(2);
	foreach(var_player in function_GetPlayers())
	{
		var_player function_playsoundtoplayer("exfil_nuke_countdown", var_player);
	}
	wait(3);
	foreach(var_player in function_GetPlayers())
	{
		var_player.var_pers["succesful_exfil"]++;
		level notify("hash_8c3d4295", var_player, "succesful_exfil", 1, 0);
		if(var_player.var_downs < 1)
		{
			var_player thread namespace_97ac1184::function_7e18304e("spx_save_data", "flawless_game", var_player.var_pers["flawless_game"], 0);
		}
		var_player thread namespace_97ac1184::function_1d39abf6("end_game_succesful_exfil", 1, 0);
		var_player thread namespace_97ac1184::function_7e18304e("spx_save_data", "succesful_exfil", var_player.var_pers["succesful_exfil"], 0);
		var_player notify("hash_79ef118b", "succesful_exfil", undefined);
		wait(0.1 * var_player function_GetEntityNumber() + 1);
	}
	wait(2.8);
	level namespace_flag::function_clear("spawn_zombies");
	var_a_ai_enemies = function_GetAITeamArray("axis");
	foreach(var_ai_enemy in var_a_ai_enemies)
	{
		level.var_zombie_total++;
		level.var_zombie_respawns++;
		var_ai_enemy function_DoDamage(var_ai_enemy.var_health + 666, var_ai_enemy.var_origin);
		wait(0.05);
	}
	wait(2.4);
	foreach(var_player in function_GetPlayers())
	{
		var_player function_playsoundtoplayer("exfil_nuke_blast_start", var_player);
		var_player function_LUINotifyEvent(&"spx_milestone_notification", 1, &"ZM_MINECRAFT_NOTIFICATION_SUCCESFUL_EXFIL");
		wait(0.1 * var_player function_GetEntityNumber() + 1);
	}
	wait(1.8);
	var_8d2d167 = namespace_util::function_spawn_model("tag_origin", self.var_origin, self.var_angles);
	var_8d2d167 = function_PlayFXOnTag(level.var__effect["deployment_station_exfil_nuke_explosion"], var_8d2d167, "tag_origin");
	function_Earthquake(1, 0.5, self.var_origin, 1000);
	foreach(var_player in function_GetPlayers())
	{
		var_player function_EnableInvulnerability();
		var_player function_DisableWeapons();
		var_player function_disableOffhandWeapons();
		var_player function_FreezeControls(1);
		var_player function_playsoundtoplayer("exfil_nuke_blast_main", var_player);
		var_player function_playsoundtoplayer("exfil_nuke_blast_main_quad", var_player);
	}
	level.var_custom_game_over_hud_elem = &function_fdef49b1;
	wait(0.15);
	level thread namespace_LUI::function_screen_flash(0.5, 0.5, 0.5, 1, "white");
	wait(1);
	self function_delete();
	level thread namespace_97ac1184::function_231f215a();
	wait(2);
	function_b8bbdc71();
	foreach(var_player in function_GetPlayers())
	{
		var_player function_playsoundtoplayer("exfil_nuke_blast_tail", var_player);
	}
	wait(4);
	foreach(var_player in function_GetPlayers())
	{
		var_player function_playsoundtoplayer("exfil_nuke_blast_debris", var_player);
	}
	var_8d2d167 function_delete();
	return;
	ERROR: Exception occured: Stack empty.
}

/*
	Name: function_e73f8706
	Namespace: namespace_a74e4f35
	Checksum: 0x424F4353
	Offset: 0x3F98
	Size: 0x68
	Parameters: 0
	Flags: None
	Line Number: 619
*/
function function_e73f8706()
{
	self endon("hash_c34621d7");
	self.var_11c8060e = 0;
	if(self.var_11c8060e > 1)
	{
		while(self.var_b85985e3 < self.var_11c8060e)
		{
			level waittill("hash_5dcb913f", var_player);
			self.var_b85985e3++;
		}
		return;
	}
}

/*
	Name: function_69808090
	Namespace: namespace_a74e4f35
	Checksum: 0x424F4353
	Offset: 0x4008
	Size: 0x6A8
	Parameters: 0
	Flags: None
	Line Number: 644
*/
function function_69808090()
{
	var_a_ai_enemies = function_GetAITeamArray("axis");
	foreach(var_ai_enemy in var_a_ai_enemies)
	{
		level.var_zombie_total++;
		level.var_zombie_respawns++;
		var_ai_enemy function_kill();
		wait(0.1);
	}
	level.var_147d7517["nuke"] = 0;
	level.var_147d7517["insta_kill"] = 0;
	level.var_a08671cd = function_Int(80 + function_GetPlayers().size * 35);
	foreach(var_player in function_GetPlayers())
	{
		var_player function_LUINotifyEvent(&"ZMBU_info", 2, &"ZM_MINECRAFT_ZOMBIES_EXFIL_REMAINING", level.var_a08671cd);
	}
	level thread function_change_difficulty("insane");
	wait(0.05);
	namespace_zm_spawner::function_register_zombie_death_event_callback(&function_7ff88724);
	self thread function_6670e675();
	self thread function_9de33d29();
	self namespace_util::function_waittill_any_timeout(180, "stop_exfil_function");
	if(level.var_a08671cd <= 0)
	{
		level thread function_6ee0e787("Show1");
		level thread namespace_LUI::function_screen_flash(0.2, 0.5, 1, 0.8, "white");
		self.var_trigger_use function_setHintString(&"ZM_MINECRAFT_EXFIL_NUKE_HINT_END");
		self.var_trigger_use function_TriggerEnable(1);
		self namespace_util::function_waittill_any_timeout(60, "stop_exfil_function");
		level namespace_flag::function_clear("spawn_zombies");
		var_a_ai_enemies = function_GetAITeamArray("axis");
		foreach(var_ai_enemy in var_a_ai_enemies)
		{
			level.var_zombie_total++;
			level.var_zombie_respawns++;
			var_ai_enemy function_DoDamage(var_ai_enemy.var_health + 666, var_ai_enemy.var_origin);
			wait(0.1);
		}
	}
	else
	{
		foreach(var_player in function_GetPlayers())
		{
			var_player function_LUINotifyEvent(&"spx_milestone_notification", 1, &"ZM_MINECRAFT_NOTIFICATION_UNSUCCESFUL_EXFIL");
		}
		level thread function_6ee0e787("Show2");
		level namespace_flag::function_set("spawn_zombies");
		level namespace_flag::function_clear("exfil_kills_completed");
		level namespace_flag::function_clear("exfil_activated");
		if(!(isdefined(level.var_679e1a9e) && level.var_679e1a9e))
		{
			level thread function_change_difficulty("normal");
		}
		level.var_custom_game_over_hud_elem = undefined;
		level notify("hash_67d1d80d");
		wait(0.05);
		self.var_trigger_use function_delete();
		self function_delete();
	}
	level.var_147d7517["nuke"] = 1;
	level.var_147d7517["insta_kill"] = 1;
	foreach(var_player in function_GetPlayers())
	{
		var_player function_stopSound("mus_exfil_start");
	}
	namespace_zm_spawner::function_deregister_zombie_death_event_callback(&function_7ff88724);
	wait(5);
	level thread function_6ee0e787("0");
	return;
	waittillframeend;
}

/*
	Name: function_6ee0e787
	Namespace: namespace_a74e4f35
	Checksum: 0x424F4353
	Offset: 0x46B8
	Size: 0xB0
	Parameters: 1
	Flags: None
	Line Number: 727
*/
function function_6ee0e787(var_value)
{
	foreach(var_player in function_GetPlayers())
	{
		namespace_util::function_setClientSysState("UEM.ExfilUI", var_value, var_player);
		wait(0.5);
	}
}

/*
	Name: function_9de33d29
	Namespace: namespace_a74e4f35
	Checksum: 0x424F4353
	Offset: 0x4770
	Size: 0x60
	Parameters: 0
	Flags: None
	Line Number: 746
*/
function function_9de33d29()
{
	for(var_i = 180; var_i > 0; var_i--)
	{
		level thread function_6ee0e787(level.var_a08671cd + "," + var_i);
		wait(1);
	}
	return;
}

/*
	Name: function_6670e675
	Namespace: namespace_a74e4f35
	Checksum: 0x424F4353
	Offset: 0x47D8
	Size: 0x90
	Parameters: 0
	Flags: None
	Line Number: 766
*/
function function_6670e675()
{
	self endon("hash_c34621d7");
	while(level namespace_flag::function_get("exfil_activated") && level.var_a08671cd > 0)
	{
		wait(1);
	}
	level namespace_flag::function_set("exfil_kills_completed");
	self notify("hash_c34621d7");
	level thread function_6ee0e787("0");
}

/*
	Name: function_5b5b8605
	Namespace: namespace_a74e4f35
	Checksum: 0x424F4353
	Offset: 0x4870
	Size: 0x190
	Parameters: 0
	Flags: None
	Line Number: 788
*/
function function_5b5b8605()
{
	var_f70e33ad = 0;
	var_9e8d37be = level.var_a08671cd + 50;
	while(level namespace_flag::function_get("exfil_activated") && var_f70e33ad < var_9e8d37be + 30)
	{
		if(namespace_zombie_utility::function_get_current_zombie_count() < 36)
		{
			var_spawner = namespace_Array::function_random(level.var_zombie_spawners);
			var_zombie = namespace_zombie_utility::function_spawn_zombie(var_spawner);
			wait(0.5);
			var_zombie.var_b_ignore_cleanup = 1;
			var_zombie.var_ignore_cleanup_mgr = 1;
			var_zombie.var_no_powerups = 1;
			if(isdefined(var_zombie.var_health))
			{
				var_zombie.var_health = var_zombie.var_health + var_zombie.var_health * 3;
				var_zombie.var_maxhealth = var_zombie.var_health;
			}
			var_zombie thread function_75e5ed2();
			var_f70e33ad++;
		}
		wait(0.15);
	}
}

/*
	Name: function_75e5ed2
	Namespace: namespace_a74e4f35
	Checksum: 0x424F4353
	Offset: 0x4A08
	Size: 0x1A8
	Parameters: 0
	Flags: None
	Line Number: 824
*/
function function_75e5ed2()
{
	wait(5);
	if(isdefined(self))
	{
		if(!self function_CanPath(self.var_origin, self.var_favoriteenemy.var_origin))
		{
			var_dog_locs = namespace_Array::function_randomize(level.var_zm_loc_types["dog_location"]);
			if(var_dog_locs.size > 0)
			{
				self function_ForceTeleport(var_dog_locs.var_origin, var_dog_locs.var_angles, 1);
			}
			else
			{
				var_741d29ca = function_GetPlayers()[0] namespace_zm_zonemgr::function_get_player_zone();
				var_a638c0c2 = function_GetClosestPointOnNavMesh(namespace_Array::function_random(function_getArrayKeys(level.var_zones[var_741d29ca].var_adjacent_zones))[0].var_origin, 250, 250);
				if(function_IsPointOnNavMesh(var_a638c0c2, self))
				{
					self function_ForceTeleport(var_a638c0c2.var_origin, var_a638c0c2.var_angles, 1);
				}
			}
		}
	}
}

/*
	Name: function_7ff88724
	Namespace: namespace_a74e4f35
	Checksum: 0x424F4353
	Offset: 0x4BB8
	Size: 0x48
	Parameters: 1
	Flags: Private
	Line Number: 859
*/
function private function_7ff88724(var_e_attacker)
{
	level.var_a08671cd--;
	var_e_attacker function_LUINotifyEvent(&"ZMBU_info", 2, &"ZM_MINECRAFT_ZOMBIES_EXFIL_REMAINING", level.var_a08671cd);
	return -1;
}

/*
	Name: function_fdef49b1
	Namespace: namespace_a74e4f35
	Checksum: 0x424F4353
	Offset: 0x4C08
	Size: 0x400
	Parameters: 3
	Flags: None
	Line Number: 876
*/
function function_fdef49b1(var_player, var_game_over, var_survived)
{
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
	var_game_over function_setText("Succesfully Detonated M.O.A.B");
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
	if(level.var_round_number < 2)
	{
		if(level.var_script == "zm_moon")
		{
			if(!isdefined(level.var_left_nomans_land))
			{
				var_nomanslandtime = level.var_nml_best_time;
				var_player_survival_time = function_Int(var_nomanslandtime / 1000);
				var_player_survival_time_in_mins = namespace_zm::function_to_mins(var_player_survival_time);
				var_survived function_setText(&"ZOMBIE_SURVIVED_NOMANS", var_player_survival_time_in_mins);
			}
			else if(level.var_left_nomans_land == 2)
			{
				var_survived function_setText(&"ZOMBIE_SURVIVED_ROUND");
			}
		}
		else
		{
			var_survived function_setText(&"ZOMBIE_SURVIVED_ROUND");
		}
	}
	else
	{
		var_survived function_setText(&"ZOMBIE_SURVIVED_ROUNDS", level.var_round_number);
	}
	var_survived function_fadeOverTime(1);
	var_survived.var_alpha = 1;
}

/*
	Name: function_c0efee41
	Namespace: namespace_a74e4f35
	Checksum: 0x424F4353
	Offset: 0x5010
	Size: 0x3B0
	Parameters: 1
	Flags: None
	Line Number: 950
*/
function function_c0efee41(var_player)
{
	if(var_player function_hasPerk("specialty_immunetriggerbetty"))
	{
	}
	else
	{
	}
	var_a8ce65bc = 1100;
	if(!var_player namespace_zm_score::function_can_player_purchase(var_a8ce65bc))
	{
		namespace_zm_utility::function_play_sound_at_pos("no_purchase", var_player.var_origin);
		var_player namespace_zm_audio::function_create_and_play_dialog("general", "outofmoney");
		self.var_40b69c4c function_SetModel("zmu_cash_share_hologram_disabled");
		wait(1);
		if(var_player.var_beea7f3e[self.var_54735102] == "cashshare")
		{
			self.var_40b69c4c function_SetModel("zmu_cash_share_hologram");
			return;
		}
	}
	self.var_owner.var_1bfcbff5 = self.var_owner.var_1bfcbff5 + 15;
	var_a85e9ccd = function_GetPlayers();
	if(var_a85e9ccd.size > 1)
	{
		var_a85e9ccd = function_ArraySortClosest(var_a85e9ccd, self.var_origin);
		if(var_a85e9ccd[0] == var_player)
		{
			var_target_player = var_a85e9ccd[1];
		}
		else
		{
			var_target_player = var_a85e9ccd[0];
		}
		if(var_player namespace_zm_score::function_can_player_purchase(var_a8ce65bc) && isdefined(var_target_player))
		{
			if(function_Distance(self.var_origin, var_target_player.var_origin) < 500)
			{
				var_player namespace_zm_score::function_minus_to_player_score(var_a8ce65bc);
				namespace_zm_utility::function_play_sound_at_pos("purchase", var_player.var_origin);
				var_player namespace_zm_audio::function_create_and_play_dialog("general", "generic_wall_buy");
				var_player.var_pers["deploy_cash_shared"] = var_player.var_pers["deploy_cash_shared"] + 1000;
				var_player thread namespace_97ac1184::function_1d39abf6("end_game_deploy_cash_shared", 1000, 0);
				var_player thread namespace_97ac1184::function_7e18304e("spx_save_data", "deploy_cash_shared", var_player.var_pers["deploy_cash_shared"], 0);
				var_target_player namespace_zm_score::function_add_to_player_score(1000, 1, "deployment_cash");
			}
			else
			{
				self.var_40b69c4c function_SetModel("zmu_cash_share_hologram_disabled");
				wait(1);
				if(var_player.var_beea7f3e[self.var_54735102] == "cashshare")
				{
					self.var_40b69c4c function_SetModel("zmu_cash_share_hologram");
				}
			}
		}
	}
}

/*
	Name: function_561555f1
	Namespace: namespace_a74e4f35
	Checksum: 0x424F4353
	Offset: 0x53C8
	Size: 0x3A8
	Parameters: 1
	Flags: None
	Line Number: 1019
*/
function function_561555f1(var_owner)
{
	self.var_f7ad445d = function_spawn("trigger_damage", self.var_origin + VectorScale((0, 0, 1), 45), 0, 120, 120);
	while(isdefined(self.var_f7ad445d))
	{
		self.var_f7ad445d waittill("hash_damage", var_n_damage, var_e_attacker, var_v_dir, var_v_loc, var_str_type, var_STR_MODEL, var_str_tag, var_str_part, var_w_weapon);
		self.var_owner.var_1bfcbff5 = self.var_owner.var_1bfcbff5 + 5;
		if(var_e_attacker == self.var_owner)
		{
			if(function_IsInArray(level.var_zombie_melee_weapon_list, var_w_weapon) || var_str_type == "MOD_MELEE_WEAPON_BUTT" || var_str_type == "MOD_MELEE" || var_str_type == "MOD_MELEE_ASSASSINATE")
			{
				if(!(isdefined(self.var_4c2c3d65) && self.var_4c2c3d65))
				{
					self.var_54735102++;
					if(self.var_54735102 > self.var_owner.var_beea7f3e.size - 1)
					{
						self.var_54735102 = 0;
					}
					switch(var_e_attacker.var_beea7f3e[self.var_54735102])
					{
						case "ammo":
						{
							self.var_40b69c4c function_SetModel("zmu_bullet_hologram");
							break;
						}
						case "wunderfizz":
						{
							self.var_40b69c4c function_SetModel("zmu_wunderfizz_hologram");
							break;
						}
						case "cashshare":
						{
							self.var_40b69c4c function_SetModel("zmu_cash_share_hologram");
							break;
						}
						case "exfil":
						{
							if(!(isdefined(level.var_abcf67a6) && level.var_abcf67a6) || (isdefined(level namespace_flag::function_get("exfil_activated")) && level namespace_flag::function_get("exfil_activated")))
							{
								self.var_40b69c4c function_SetModel("zmu_nuke_hologram_disabled");
							}
							else
							{
								self.var_40b69c4c function_SetModel("zmu_nuke_hologram");
								break;
							}
						}
						case "rageinducer":
						{
							if(isdefined(self.var_e42e02e3) && self.var_e42e02e3)
							{
								self.var_40b69c4c function_SetModel("zmu_skull_hologram_disabled");
							}
							else
							{
								self.var_40b69c4c function_SetModel("zmu_skull_hologram");
								break;
							}
						}
						default
						{
							self.var_40b69c4c function_SetModel("zmu_bullet_hologram");
						}
					}
					else
					{
					}
					else
					{
					}
					else
					{
					}
				}
			}
		}
	}
}

/*
	Name: function_5b42a9c7
	Namespace: namespace_a74e4f35
	Checksum: 0x424F4353
	Offset: 0x5778
	Size: 0x1D0
	Parameters: 1
	Flags: None
	Line Number: 1108
*/
function function_5b42a9c7(var_player)
{
	self.var_hint_parm1 = undefined;
	self.var_hint_string = "";
	switch(var_player.var_beea7f3e[self.var_stub.var_related_parent.var_54735102])
	{
		case "ammo":
		{
			var_can_use = self function_b787d79(var_player);
			break;
		}
		case "wunderfizz":
		{
			var_can_use = self function_a8410970(var_player);
			break;
		}
		case "cashshare":
		{
			var_can_use = self function_1efa629(var_player);
			break;
		}
		case "exfil":
		{
			var_can_use = self function_61960960(var_player);
			break;
		}
		case "rageinducer":
		{
			var_can_use = self function_5aa2a964(var_player);
			break;
		}
		default
		{
			var_can_use = self function_6949af66(var_player);
		}
	}
	if(isdefined(self.var_hint_string))
	{
		if(isdefined(self.var_hint_parm1))
		{
			self function_setHintString(self.var_hint_string, self.var_hint_parm1);
		}
		else
		{
			self function_setHintString(self.var_hint_string);
		}
	}
	else
	{
		self function_setHintString(&"ZM_MINECRAFT_DEPLOYMENT_STATION_DISABLED");
	}
	return var_can_use;
}

/*
	Name: function_6949af66
	Namespace: namespace_a74e4f35
	Checksum: 0x424F4353
	Offset: 0x5950
	Size: 0x28
	Parameters: 1
	Flags: None
	Line Number: 1172
*/
function function_6949af66(var_player)
{
	self.var_hint_string = &"ZM_MINECRAFT_DEPLOYMENT_STATION_DISABLED";
	self.var_hint_parm1 = undefined;
	return 0;
}

/*
	Name: function_a8410970
	Namespace: namespace_a74e4f35
	Checksum: 0x424F4353
	Offset: 0x5980
	Size: 0x340
	Parameters: 1
	Flags: None
	Line Number: 1189
*/
function function_a8410970(var_player)
{
	if(var_player.var_9ee9bcc6 < 10)
	{
		self.var_hint_string = &"ZM_MINECRAFT_DEPLOYMENT_STATION_WUNDERFIZZ_ROUND";
		self.var_hint_parm1 = 10 - var_player.var_9ee9bcc6;
		return 0;
	}
	else
	{
		var_dea0891b = level.var__random_zombie_perk_cost + var_player.var_num_perks * 250;
		if(!self function_trigger_visible_to_player(var_player))
		{
			self.var_hint_string = &"ZOMBIE_RANDOM_PERK_TOO_MANY";
			self.var_hint_parm1 = undefined;
			return 0;
		}
		if(self.var_stub.var_related_parent.var_owner === var_player)
		{
			var_n_purchase_limit = var_player namespace_zm_utility::function_get_player_perk_purchase_limit();
			if(!var_player namespace_zm_utility::function_can_player_purchase_perk() || (isdefined(var_player function_player_has_all_available_perks()) && var_player function_player_has_all_available_perks()))
			{
				self.var_hint_string = &"ZM_MINECRAFT_DEPLOYMENT_STATION_WUNDERFIZZ_ALL_PERKS";
				self.var_hint_parm1 = var_n_purchase_limit;
				return 0;
			}
			else if(isdefined(self.var_stub.var_related_parent.var_machine_user))
			{
				if(isdefined(self.var_stub.var_related_parent.var_grab_perk_hint) && self.var_stub.var_related_parent.var_grab_perk_hint)
				{
					self.var_hint_string = &"ZOMBIE_RANDOM_PERK_PICKUP";
					self.var_hint_parm1 = undefined;
					return 1;
				}
				else
				{
					self.var_hint_string = "";
					self.var_hint_parm1 = undefined;
					return 0;
				}
			}
			else
			{
				var_n_purchase_limit = var_player namespace_zm_utility::function_get_player_perk_purchase_limit();
				if(isdefined(var_player function_player_has_all_available_perks()) && var_player function_player_has_all_available_perks())
				{
					self.var_hint_string = &"ZM_MINECRAFT_DEPLOYMENT_STATION_WUNDERFIZZ_ALL_PERKS";
					self.var_hint_parm1 = undefined;
					return 0;
				}
				else if(!var_player namespace_zm_utility::function_can_player_purchase_perk())
				{
					self.var_hint_string = &"ZOMBIE_RANDOM_PERK_TOO_MANY";
					self.var_hint_parm1 = var_n_purchase_limit;
					return 0;
				}
				else if(var_player namespace_zm_score::function_can_player_purchase(var_dea0891b))
				{
					self.var_hint_string = &"ZM_MINECRAFT_DEPLOYMENT_STATION_WUNDERFIZZ";
					self.var_hint_parm1 = var_dea0891b;
					return 1;
				}
				else
				{
					self.var_hint_string = &"ZM_MINECRAFT_DEPLOYMENT_STATION_WUNDERFIZZ_NO_POINTS";
					self.var_hint_parm1 = var_dea0891b;
					return 0;
				}
			}
		}
		else
		{
			self.var_hint_string = &"ZM_MINECRAFT_DEPLOYMENT_STATION_WUNDERFIZZ_PLAYER_ONLY";
			self.var_hint_parm1 = undefined;
			return 0;
		}
	}
}

/*
	Name: function_5aa2a964
	Namespace: namespace_a74e4f35
	Checksum: 0x424F4353
	Offset: 0x5CC8
	Size: 0x108
	Parameters: 1
	Flags: None
	Line Number: 1278
*/
function function_5aa2a964(var_player)
{
	if(self.var_stub.var_related_parent.var_owner === var_player)
	{
		if(!(isdefined(self.var_stub.var_related_parent.var_e42e02e3) && self.var_stub.var_related_parent.var_e42e02e3))
		{
			if(!(isdefined(level.var_679e1a9e) && level.var_679e1a9e))
			{
				self.var_hint_string = &"ZM_MINECRAFT_DEPLOYMENT_STATION_RAGE_INDUCER";
				self.var_hint_parm1 = undefined;
				return 1;
			}
			else
			{
				self.var_hint_string = &"ZM_MINECRAFT_DEPLOYMENT_STATION_RAGE_INDUCER_DISABLE";
				self.var_hint_parm1 = undefined;
				return 1;
			}
		}
		else
		{
			self.var_hint_string = &"ZM_MINECRAFT_DEPLOYMENT_STATION_RAGE_INDUCER_COOLDOWN";
			self.var_hint_parm1 = undefined;
			return 0;
		}
	}
	else
	{
		self.var_hint_string = &"ZM_MINECRAFT_DEPLOYMENT_STATION_HOST_OPTION";
		self.var_hint_parm1 = undefined;
		return 1;
	}
}

/*
	Name: function_61960960
	Namespace: namespace_a74e4f35
	Checksum: 0x424F4353
	Offset: 0x5DD8
	Size: 0x110
	Parameters: 1
	Flags: None
	Line Number: 1322
*/
function function_61960960(var_player)
{
	if(self.var_stub.var_related_parent.var_owner === var_player)
	{
		if(isdefined(level namespace_flag::function_get("exfil_activated")) && level namespace_flag::function_get("exfil_activated"))
		{
			self.var_hint_string = &"ZM_MINECRAFT_DEPLOYMENT_STATION_EXFIL_IN_PROGRESS";
			self.var_hint_parm1 = undefined;
			return 1;
		}
		else if(level.var_abcf67a6)
		{
			self.var_hint_string = &"ZM_MINECRAFT_DEPLOYMENT_STATION_EXFIL";
			self.var_hint_parm1 = undefined;
			return 1;
		}
		else
		{
			self.var_hint_string = &"ZM_MINECRAFT_DEPLOYMENT_STATION_EXFIL_DISABLED";
			self.var_hint_parm1 = level.var_6e1a05ca;
			return 0;
		}
	}
	else
	{
		self.var_hint_string = &"ZM_MINECRAFT_DEPLOYMENT_STATION_HOST_OPTION";
		self.var_hint_parm1 = undefined;
		return 1;
	}
}

/*
	Name: function_1efa629
	Namespace: namespace_a74e4f35
	Checksum: 0x424F4353
	Offset: 0x5EF0
	Size: 0x140
	Parameters: 1
	Flags: None
	Line Number: 1363
*/
function function_1efa629(var_player)
{
	var_a8ce65bc = 1230;
	if(var_player function_hasPerk("specialty_immunetriggerbetty"))
	{
	}
	else
	{
	}
	var_a8ce65bc = 1100;
	if(self.var_stub.var_related_parent.var_owner === var_player)
	{
		if(var_player namespace_zm_score::function_can_player_purchase(var_a8ce65bc))
		{
			self.var_hint_string = &"ZM_MINECRAFT_DEPLOYMENT_STATION_CASH_SHARE_OWNER";
			self.var_hint_parm1 = 100;
			return 1;
		}
		else
		{
			self.var_hint_string = &"ZM_MINECRAFT_DEPLOYMENT_STATION_CASH_SHARE_NO_POINTS_OWNER";
			self.var_hint_parm1 = var_a8ce65bc;
			return 0;
		}
	}
	else if(var_player namespace_zm_score::function_can_player_purchase(var_a8ce65bc))
	{
		self.var_hint_string = &"ZM_MINECRAFT_DEPLOYMENT_STATION_CASH_SHARE";
		self.var_hint_parm1 = 100;
		return 1;
	}
	else
	{
		self.var_hint_string = &"ZM_MINECRAFT_DEPLOYMENT_STATION_CASH_SHARE_NO_POINTS";
		self.var_hint_parm1 = var_a8ce65bc;
		return 0;
	}
}

/*
	Name: function_6d9383c
	Namespace: namespace_a74e4f35
	Checksum: 0x424F4353
	Offset: 0x6038
	Size: 0x280
	Parameters: 1
	Flags: None
	Line Number: 1412
*/
function function_6d9383c(var_player)
{
	self.var_owner.var_1bfcbff5 = self.var_owner.var_1bfcbff5 + 15;
	self.var_e42e02e3 = 1;
	if(isdefined(level.var_679e1a9e) && level.var_679e1a9e)
	{
		level.var_679e1a9e = 0;
		if(!isdefined(level.var_bdc116e3) || level.var_bdc116e3 < 2)
		{
			level thread function_change_difficulty("normal");
			var_player thread namespace_97ac1184::function_b3489bf5("^3" + var_player.var_playerName + "^7 turned off ^9Rage Inducer");
		}
	}
	else
	{
		level.var_679e1a9e = 1;
		if(!isdefined(level.var_bdc116e3) || level.var_bdc116e3 < 2)
		{
			if(level namespace_flag::function_get("insane_rage_inducer"))
			{
				level thread function_change_difficulty("hard");
			}
			else
			{
				level thread function_change_difficulty("insane");
			}
			var_player thread namespace_97ac1184::function_b3489bf5("^3" + var_player.var_playerName + "^7 turned on ^9Rage Inducer");
		}
	}
	var_player.var_pers["deploy_rage_inducer"]++;
	var_player thread namespace_97ac1184::function_1d39abf6("end_game_deploy_rage_inducer", 1, 0);
	var_player thread namespace_97ac1184::function_7e18304e("spx_save_data", "deploy_rage_inducer", var_player.var_pers["deploy_rage_inducer"], 0);
	self.var_40b69c4c function_SetModel("zmu_skull_hologram_disabled");
	wait(10);
	if(var_player.var_beea7f3e[self.var_54735102] == "rageinducer")
	{
		self.var_40b69c4c function_SetModel("zmu_skull_hologram");
	}
	self.var_e42e02e3 = 0;
}

/*
	Name: function_change_difficulty
	Namespace: namespace_a74e4f35
	Checksum: 0x424F4353
	Offset: 0x62C0
	Size: 0x680
	Parameters: 1
	Flags: None
	Line Number: 1463
*/
function function_change_difficulty(var_difficulty)
{
	self notify("hash_4c5f89d4");
	self endon("hash_4c5f89d4");
	if(isdefined(var_difficulty) && var_difficulty == "easy")
	{
		level.var_zombie_vars["zombie_between_round_time"] = level.var_ee5d3b93;
		level.var_zombie_vars["zombie_move_speed_multiplier"] = 1;
		level.var_b83ee546 = 0;
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
		level.var_zombie_actor_limit = 40 + 4 * function_GetPlayers().size;
		level.var_zombie_ai_limit = 40 + 4 * function_GetPlayers().size;
		level.var_b83ee546 = 0;
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
		level.var_zombie_vars["zombie_move_speed_multiplier"] = 80;
		level.var_zombie_actor_limit = 48 + 4 * function_GetPlayers().size;
		level.var_zombie_ai_limit = 48 + 4 * function_GetPlayers().size;
		level.var_b83ee546 = 0;
		foreach(var_ai_enemy in function_GetAITeamArray("axis"))
		{
			var_ai_enemy namespace_zombie_utility::function_set_zombie_run_cycle_restore_from_override();
			var_ai_enemy namespace_zombie_utility::function_set_zombie_run_cycle_override_value("sprint");
		}
	}
	else if(isdefined(var_difficulty) && var_difficulty == "insane")
	{
		level.var_zombie_vars["zombie_between_round_time"] = 0.1;
		level.var_zombie_vars["zombie_move_speed_multiplier"] = 200;
		level.var_zombie_actor_limit = 48 + 4 * function_GetPlayers().size;
		level.var_zombie_ai_limit = 48 + 4 * function_GetPlayers().size;
		level.var_b83ee546 = 1;
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
		level.var_b83ee546 = 0;
		foreach(var_ai_enemy in function_GetAITeamArray("axis"))
		{
			var_ai_enemy namespace_zombie_utility::function_set_zombie_run_cycle_restore_from_override();
			var_ai_enemy namespace_zombie_utility::function_set_zombie_run_cycle_override_value("sprint");
		}
	}
}

/*
	Name: function_b787d79
	Namespace: namespace_a74e4f35
	Checksum: 0x424F4353
	Offset: 0x6948
	Size: 0x398
	Parameters: 1
	Flags: None
	Line Number: 1545
*/
function function_b787d79(var_player)
{
	var_current_weapon = var_player function_GetCurrentWeapon();
	var_current_weapon = namespace_zm_weapons::function_get_nonalternate_weapon(var_current_weapon);
	var_current_weapon function_249f1eeb(var_player);
	var_player.var_397c0fc5 = function_9b879eb3(var_player, var_current_weapon);
	if(self.var_stub.var_related_parent.var_owner === var_player)
	{
		if(isdefined(var_player function_9bcac1e6(var_current_weapon)) && var_player function_9bcac1e6(var_current_weapon))
		{
			if(!var_player function_hasPerk("specialty_extraammo") && var_current_weapon.var_e5532822 < var_current_weapon.var_ec2ed08e || (var_player function_hasPerk("specialty_extraammo") && var_current_weapon.var_e5532822 < var_current_weapon.var_8c142720))
			{
				self.var_hint_string = &"ZM_MINECRAFT_AMMO_CRATE_WEAPON_AMMO_BUY_OWNER";
				self.var_hint_parm1 = var_player.var_397c0fc5;
				return 1;
			}
			else if(!(isdefined(var_player function_9bcac1e6(var_current_weapon)) && var_player function_9bcac1e6(var_current_weapon)))
			{
				self.var_hint_string = "";
				self.var_hint_parm1 = undefined;
				return 0;
			}
			else
			{
				self.var_hint_string = &"ZM_MINECRAFT_AMMO_CRATE_WEAPON_FULL_OWNER";
				self.var_hint_parm1 = undefined;
				return 0;
			}
		}
	}
	else if(isdefined(var_player function_9bcac1e6(var_current_weapon)) && var_player function_9bcac1e6(var_current_weapon))
	{
		if(!var_player function_hasPerk("specialty_extraammo") && var_current_weapon.var_e5532822 < var_current_weapon.var_ec2ed08e || (var_player function_hasPerk("specialty_extraammo") && var_current_weapon.var_e5532822 < var_current_weapon.var_8c142720))
		{
			self.var_hint_string = &"ZM_MINECRAFT_AMMO_CRATE_WEAPON_AMMO_BUY";
			self.var_hint_parm1 = var_player.var_397c0fc5;
			return 1;
		}
		else if(!(isdefined(var_player function_9bcac1e6(var_current_weapon)) && var_player function_9bcac1e6(var_current_weapon)))
		{
			self.var_hint_string = "";
			self.var_hint_parm1 = undefined;
			return 0;
		}
		else
		{
			self.var_hint_string = &"ZM_MINECRAFT_AMMO_CRATE_WEAPON_FULL";
			self.var_hint_parm1 = undefined;
			return 0;
		}
	}
}

/*
	Name: function_1de4829
	Namespace: namespace_a74e4f35
	Checksum: 0x424F4353
	Offset: 0x6CE8
	Size: 0x470
	Parameters: 1
	Flags: None
	Line Number: 1608
*/
function function_1de4829(var_player)
{
	var_current_weapon = var_player function_GetCurrentWeapon();
	if(var_current_weapon.var_name != "")
	{
		var_current_weapon = var_player namespace_zm_weapons::function_switch_from_alt_weapon(var_current_weapon);
	}
	var_e5532822 = var_player function_GetWeaponAmmoStock(var_current_weapon);
	var_current_weapon function_249f1eeb(var_player);
	if(var_current_weapon.var_isRiotShield && (var_current_weapon == level.var_zombie_powerup_weapon["minigun"] || namespace_zm_utility::function_is_hero_weapon(var_current_weapon) || var_current_weapon.var_name == "none" || var_current_weapon.var_name == "zombie_bgb_grab" || var_current_weapon.var_name == "zombie_bgb_use" || var_current_weapon.var_name == "zombie_beast_grapple_dwr" || var_current_weapon.var_name == "staff_revive" || var_current_weapon.var_clipSize <= 0))
	{
		return;
	}
	if(!var_player namespace_zm_score::function_can_player_purchase(var_player.var_397c0fc5) || (!var_player function_hasPerk("specialty_extraammo") && var_current_weapon.var_e5532822 >= var_current_weapon.var_ec2ed08e) || (var_player function_hasPerk("specialty_extraammo") && var_current_weapon.var_e5532822 >= var_current_weapon.var_8c142720))
	{
		namespace_zm_utility::function_play_sound_at_pos("no_purchase", var_player.var_origin);
		var_player namespace_zm_audio::function_create_and_play_dialog("general", "outofmoney");
		return;
	}
	if(var_player namespace_zm_score::function_can_player_purchase(var_player.var_397c0fc5))
	{
		self.var_owner.var_1bfcbff5 = self.var_owner.var_1bfcbff5 + 15;
		var_player namespace_zm_score::function_minus_to_player_score(var_player.var_397c0fc5);
		namespace_zm_utility::function_play_sound_at_pos("purchase", var_player.var_origin);
		var_player namespace_zm_audio::function_create_and_play_dialog("general", "generic_wall_buy");
		var_current_weapon = var_player function_GetCurrentWeapon();
		var_player function_SetWeaponAmmoClip(var_current_weapon, var_current_weapon.var_clipSize);
		if(var_player function_hasPerk("specialty_extraammo"))
		{
			var_player function_SetWeaponAmmoStock(var_current_weapon, var_current_weapon.var_maxAmmo);
		}
		else
		{
			var_player function_SetWeaponAmmoStock(var_current_weapon, var_current_weapon.var_startammo);
		}
		var_player.var_pers["deploy_ammo_buy"]++;
		var_player thread namespace_97ac1184::function_1d39abf6("end_game_deploy_ammo_buy", 1, 0);
		var_player thread namespace_97ac1184::function_7e18304e("spx_save_data", "deploy_ammo_buy", var_player.var_pers["deploy_ammo_buy"], 0);
		return;
	}
}

/*
	Name: function_2fc45e69
	Namespace: namespace_a74e4f35
	Checksum: 0x424F4353
	Offset: 0x7160
	Size: 0x90
	Parameters: 2
	Flags: None
	Line Number: 1660
*/
function function_2fc45e69(var_df20f103, var_620c330d)
{
	if(!isdefined(var_df20f103))
	{
		var_df20f103 = 6;
	}
	if(!isdefined(var_620c330d))
	{
		var_620c330d = 7;
	}
	while(isdefined(self))
	{
		var_ec3f8524 = function_randomIntRange(var_df20f103, var_620c330d);
		self function_RotateYaw(360, var_ec3f8524);
		wait(var_ec3f8524);
	}
}

/*
	Name: function_5e0c32c8
	Namespace: namespace_a74e4f35
	Checksum: 0x424F4353
	Offset: 0x71F8
	Size: 0x18
	Parameters: 0
	Flags: None
	Line Number: 1688
*/
function function_5e0c32c8()
{
	wait(20);
	self notify("hash_time_out_check");
	return;
}

/*
	Name: function_549fbbec
	Namespace: namespace_a74e4f35
	Checksum: 0x424F4353
	Offset: 0x7218
	Size: 0x270
	Parameters: 1
	Flags: None
	Line Number: 1705
*/
function function_549fbbec(var_60a2c1f7)
{
	self.var_owner namespace_util::function_waittill_any_timeout(var_60a2c1f7, "destroy_deployment_station", "disconnect");
	if(isdefined(self.var_4c2c3d65) && self.var_4c2c3d65)
	{
		self thread function_5e0c32c8();
	}
	while(isdefined(self.var_4c2c3d65) && self.var_4c2c3d65)
	{
		wait(0.5);
	}
	if(isdefined(self.var_efe0cd4e))
	{
		self.var_efe0cd4e function_delete();
	}
	self function_StopLoopSound(0.5);
	self.var_54735102 = 0;
	if(isdefined(self.var_s_unitrigger))
	{
		namespace_zm_unitrigger::function_unregister_unitrigger(self.var_s_unitrigger);
	}
	if(isdefined(self.var_f7ad445d))
	{
		self.var_f7ad445d function_delete();
	}
	if(isdefined(self.var_9186076d))
	{
		self.var_9186076d function_delete();
	}
	if(isdefined(self.var_40b69c4c))
	{
		self.var_40b69c4c function_delete();
	}
	self.var_9186076d = namespace_util::function_spawn_model("tag_origin", self.var_origin, self.var_angles);
	self.var_9186076d = function_PlayFXOnTag(level.var__effect["deployment_station_break"], self.var_9186076d, "tag_origin");
	function_playsoundatposition("deployment_station_break", self.var_origin);
	wait(1);
	function_playsoundatposition("deployment_station_break_explode", self.var_origin);
	if(isdefined(self.var_9186076d))
	{
		self.var_9186076d function_delete();
	}
	self function_delete();
}

/*
	Name: function_249f1eeb
	Namespace: namespace_a74e4f35
	Checksum: 0x424F4353
	Offset: 0x7490
	Size: 0x90
	Parameters: 1
	Flags: Private
	Line Number: 1760
*/
function private function_249f1eeb(var_player)
{
	self.var_e5532822 = var_player function_GetWeaponAmmoStock(self);
	self.var_8c142720 = self.var_maxAmmo;
	self.var_ec2ed08e = self.var_startammo;
	if(isdefined(self.var_dualWieldWeapon) && self.var_dualWieldWeapon != level.var_weaponNone)
	{
		self.var_ec2ed08e = self.var_ec2ed08e - self.var_dualWieldWeapon.var_clipSize;
		return;
	}
	ERROR: Exception occured: Stack empty.
}

/*
	Name: function_9bcac1e6
	Namespace: namespace_a74e4f35
	Checksum: 0x424F4353
	Offset: 0x7528
	Size: 0x110
	Parameters: 1
	Flags: Private
	Line Number: 1783
*/
function private function_9bcac1e6(var_current_weapon)
{
	if(self namespace_laststand::function_player_is_in_laststand() || (isdefined(self.var_intermission) && self.var_intermission) || self function_IsThrowingGrenade())
	{
		return 0;
	}
	if(!namespace_zm_utility::function_is_player_valid(self) || self.var_IS_DRINKING > 0 || namespace_zm_utility::function_is_placeable_mine(var_current_weapon) || namespace_zm_equipment::function_is_equipment(var_current_weapon) || self namespace_zm_utility::function_is_player_revive_tool(var_current_weapon) || level.var_weaponNone == var_current_weapon || self namespace_zm_equipment::function_hacker_active() || namespace_zm_utility::function_is_hero_weapon(var_current_weapon))
	{
		return 0;
	}
	return 1;
}

/*
	Name: function_9b879eb3
	Namespace: namespace_a74e4f35
	Checksum: 0x424F4353
	Offset: 0x7640
	Size: 0x258
	Parameters: 2
	Flags: Private
	Line Number: 1806
*/
function private function_9b879eb3(var_player, var_current_weapon)
{
	var_7750a3aa = var_player namespace_5e1f56dc::function_1239e0ad(var_player function_GetCurrentWeapon());
	if(isdefined(var_7750a3aa) && var_7750a3aa.var_a39a2843 > 0)
	{
		if(isdefined(var_current_weapon.var_is_wonder_weapon) && var_current_weapon.var_is_wonder_weapon || namespace_Array::function_contains(level.var_e33eb0d5, var_current_weapon.var_name))
		{
			var_e61884a5 = 12000;
			for(var_i = 1; var_i < var_7750a3aa.var_a39a2843; var_i++)
			{
				var_e61884a5 = var_e61884a5 * 1.1;
			}
		}
		else
		{
			var_e61884a5 = 1000;
			for(var_i = 1; var_i < var_7750a3aa.var_a39a2843; var_i++)
			{
				var_e61884a5 = var_e61884a5 * 1.2;
			}
		}
		var_e61884a5 = namespace_zm_utility::function_round_up_score(var_e61884a5, 100);
	}
	else
	{
		var_e61884a5 = 0;
	}
	if(isdefined(var_current_weapon.var_is_wonder_weapon) && var_current_weapon.var_is_wonder_weapon || namespace_Array::function_contains(level.var_e33eb0d5, var_current_weapon.var_name))
	{
		if(namespace_zm_weapons::function_is_weapon_upgraded(var_current_weapon))
		{
		}
		else
		{
		}
		var_397c0fc5 = 6000 + 1000;
	}
	else if(isdefined(var_7750a3aa))
	{
		var_397c0fc5 = 4500 + var_e61884a5;
	}
	else
	{
		var_397c0fc5 = 1250;
	}
	if(isdefined(var_397c0fc5))
	{
	}
	else
	{
		return 1250;
	}
}

/*
	Name: function_create_unitrigger
	Namespace: namespace_a74e4f35
	Checksum: 0x424F4353
	Offset: 0x78A0
	Size: 0x210
	Parameters: 5
	Flags: None
	Line Number: 1870
*/
function function_create_unitrigger(var_str_hint, var_n_radius, var_func_prompt_and_visibility, var_func_unitrigger_logic, var_s_trigger_type)
{
	if(!isdefined(var_n_radius))
	{
		var_n_radius = 48;
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
	self.var_s_unitrigger.var_origin = self.var_origin + VectorScale((0, 0, 1), 50);
	self.var_s_unitrigger.var_angles = self.var_angles + VectorScale((0, 0, 1), 50);
	self.var_s_unitrigger.var_script_unitrigger_type = "unitrigger_box_use";
	self.var_s_unitrigger.var_cursor_hint = "HINT_NOICON";
	self.var_s_unitrigger.var_hint_string = var_str_hint;
	self.var_s_unitrigger.var_script_width = 48;
	self.var_s_unitrigger.var_script_height = 48;
	self.var_s_unitrigger.var_script_length = 48;
	self.var_s_unitrigger.var_require_look_at = 1;
	self.var_s_unitrigger.var_related_parent = self;
	self.var_s_unitrigger.var_radius = var_n_radius;
	namespace_zm_unitrigger::function_unitrigger_force_per_player_triggers(self.var_s_unitrigger, 1);
	self.var_s_unitrigger.var_prompt_and_visibility_func = var_func_prompt_and_visibility;
	namespace_zm_unitrigger::function_register_static_unitrigger(self.var_s_unitrigger, var_func_unitrigger_logic);
}

/*
	Name: function_unitrigger_logic
	Namespace: namespace_a74e4f35
	Checksum: 0x424F4353
	Offset: 0x7AB8
	Size: 0xB8
	Parameters: 0
	Flags: None
	Line Number: 1915
*/
function function_unitrigger_logic()
{
	self endon("hash_death");
	self endon("hash_kill_trigger");
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
	continue;
}

/*
	Name: function_get_weighted_random_perk
	Namespace: namespace_a74e4f35
	Checksum: 0x424F4353
	Offset: 0x7B78
	Size: 0xC8
	Parameters: 1
	Flags: None
	Line Number: 1950
*/
function function_get_weighted_random_perk(var_player)
{
	var_keys = namespace_Array::function_randomize(function_getArrayKeys(level.var__random_perk_machine_perk_list));
	for(var_i = 0; var_i < var_keys.size; var_i++)
	{
		if(var_player function_hasPerk(level.var__random_perk_machine_perk_list[var_keys[var_i]]))
		{
			continue;
			continue;
		}
		return level.var__random_perk_machine_perk_list[var_keys[var_i]];
	}
	return level.var__random_perk_machine_perk_list[var_keys[0]];
}

/*
	Name: function_start_perk_bottle_cycling
	Namespace: namespace_a74e4f35
	Checksum: 0x424F4353
	Offset: 0x7C48
	Size: 0x138
	Parameters: 0
	Flags: None
	Line Number: 1975
*/
function function_start_perk_bottle_cycling()
{
	self endon("hash_done_cycling");
	var_array_key = function_getArrayKeys(level.var_perk_bottle_weapon_array);
	var_timer = 0;
	while(1)
	{
		for(var_i = 0; var_i < var_array_key.size; var_i++)
		{
			if(isdefined(level.var_perk_bottle_weapon_array[var_array_key[var_i]].var_weapon))
			{
				var_model = function_GetWeaponModel(level.var_perk_bottle_weapon_array[var_array_key[var_i]].var_weapon);
			}
			else
			{
				var_model = function_GetWeaponModel(level.var_perk_bottle_weapon_array[var_array_key[var_i]].var_perk_bottle_weapon);
			}
			self.var_40b69c4c function_SetModel(var_model);
			wait(0.2);
		}
	}
}

/*
	Name: function_get_perk_weapon_model
	Namespace: namespace_a74e4f35
	Checksum: 0x424F4353
	Offset: 0x7D88
	Size: 0x98
	Parameters: 1
	Flags: None
	Line Number: 2008
*/
function function_get_perk_weapon_model(var_perk)
{
	var_weapon = level.var_machine_assets[var_perk].var_weapon;
	if(isdefined(level.var__custom_perks[var_perk]) && isdefined(level.var__custom_perks[var_perk].var_perk_bottle_weapon))
	{
		var_weapon = level.var__custom_perks[var_perk].var_perk_bottle_weapon;
	}
	return function_GetWeaponModel(var_weapon);
	ERROR: Exception occured: Stack empty.
}

/*
	Name: function_GetWeaponModel
	Namespace: namespace_a74e4f35
	Checksum: 0x424F4353
	Offset: 0x7E28
	Size: 0x20
	Parameters: 1
	Flags: None
	Line Number: 2029
*/
function function_GetWeaponModel(var_weapon)
{
	return var_weapon.var_worldmodel;
}

/*
	Name: function_perk_bottle_motion
	Namespace: namespace_a74e4f35
	Checksum: 0x424F4353
	Offset: 0x7E50
	Size: 0x168
	Parameters: 0
	Flags: None
	Line Number: 2044
*/
function function_perk_bottle_motion()
{
	var_putOutTime = 3;
	var_putBackTime = 10;
	var_v_float = function_AnglesToForward(self.var_angles - (0, 90, 0)) * 10;
	self.var_40b69c4c.var_origin = self.var_origin + (0, 0, 40);
	self.var_40b69c4c.var_angles = self.var_angles;
	self.var_40b69c4c.var_angles = self.var_40b69c4c.var_angles + (0, 0, 10);
	self.var_40b69c4c function_RotateYaw(720, var_putOutTime, var_putOutTime * 0.5);
	self waittill("hash_done_cycling");
	self.var_40b69c4c.var_angles = self.var_angles;
	self.var_40b69c4c function_RotateYaw(90, var_putBackTime, var_putBackTime * 0.5);
}

/*
	Name: function_grab_check
	Namespace: namespace_a74e4f35
	Checksum: 0x424F4353
	Offset: 0x7FC0
	Size: 0x280
	Parameters: 2
	Flags: None
	Line Number: 2068
*/
function function_grab_check(var_player, var_random_perk)
{
	self endon("hash_time_out_check");
	var_perk_is_bought = 0;
	while(!var_perk_is_bought)
	{
		self waittill("hash_trigger_activated", var_e_triggerer);
		if(var_e_triggerer == var_player)
		{
			if(isdefined(var_player.var_IS_DRINKING) && var_player.var_IS_DRINKING > 0)
			{
				wait(0.1);
				continue;
			}
			if(var_player function_hasPerk(var_random_perk))
			{
				var_random_perk = function_get_weighted_random_perk(var_player);
			}
			if(var_player function_hasPerk(var_random_perk))
			{
				function_iprintln("^8[Wunderfizz] Softlock Prevented | Cannot take perk");
				continue;
			}
			if(var_player namespace_zm_utility::function_can_player_purchase_perk())
			{
				var_perk_is_bought = 1;
			}
			else
			{
				self function_playsound("evt_perk_deny");
				var_player namespace_zm_audio::function_create_and_play_dialog("general", "sigh");
				self notify("hash_time_out_or_perk_grab");
				return;
			}
		}
	}
	var_player thread function_monitor_when_player_acquires_perk();
	self notify("hash_grab_check");
	self notify("hash_time_out_or_perk_grab");
	var_player notify("hash_perk_purchased", var_random_perk);
	var_gun = var_player namespace_zm_perks::function_perk_give_bottle_begin(var_random_perk);
	var_evt = var_player namespace_util::function_waittill_any_ex("fake_death", "death", "player_downed", "weapon_change_complete", self, "time_out_check");
	if(var_evt == "weapon_change_complete")
	{
		var_player thread namespace_zm_perks::function_wait_give_perk(var_random_perk, 1);
	}
	var_player namespace_zm_perks::function_perk_give_bottle_end(var_gun, var_random_perk);
}

/*
	Name: function_monitor_when_player_acquires_perk
	Namespace: namespace_a74e4f35
	Checksum: 0x424F4353
	Offset: 0x8248
	Size: 0x60
	Parameters: 0
	Flags: None
	Line Number: 2127
*/
function function_monitor_when_player_acquires_perk()
{
	self namespace_util::function_waittill_any("perk_acquired", "death_or_disconnect", "player_downed", "forced_deployment_closure");
	self namespace_flag::function_set("deployment_machine_can_reset");
}

/*
	Name: function_time_out_check
	Namespace: namespace_a74e4f35
	Checksum: 0x424F4353
	Offset: 0x82B0
	Size: 0x48
	Parameters: 1
	Flags: None
	Line Number: 2143
*/
function function_time_out_check(var_player)
{
	self endon("hash_grab_check");
	wait(10);
	self notify("hash_time_out_check");
	var_player namespace_flag::function_set("deployment_machine_can_reset");
}

/*
	Name: function_can_buy_perk
	Namespace: namespace_a74e4f35
	Checksum: 0x424F4353
	Offset: 0x8300
	Size: 0xA8
	Parameters: 0
	Flags: None
	Line Number: 2161
*/
function function_can_buy_perk()
{
	if(isdefined(self.var_IS_DRINKING) && self.var_IS_DRINKING > 0)
	{
		return 0;
	}
	var_current_weapon = self function_GetCurrentWeapon();
	if(namespace_zm_utility::function_is_placeable_mine(var_current_weapon) || namespace_zm_equipment::function_is_equipment_that_blocks_purchase(var_current_weapon))
	{
		return 0;
	}
	if(self namespace_zm_utility::function_in_revive_trigger())
	{
		return 0;
	}
	if(var_current_weapon == level.var_weaponNone)
	{
		return 0;
	}
	return 1;
	ERROR: Exception occured: Stack empty.
	ERROR: Exception occured: Stack empty.
}

/*
	Name: function_trigger_visible_to_player
	Namespace: namespace_a74e4f35
	Checksum: 0x424F4353
	Offset: 0x83B0
	Size: 0x108
	Parameters: 1
	Flags: None
	Line Number: 2195
*/
function function_trigger_visible_to_player(var_player)
{
	self function_SetInvisibleToPlayer(var_player);
	var_visible = 1;
	if(isdefined(self.var_stub.var_trigger_target.var_machine_user))
	{
		if(var_player != self.var_stub.var_trigger_target.var_machine_user || namespace_zm_utility::function_is_placeable_mine(self.var_stub.var_trigger_target.var_machine_user function_GetCurrentWeapon()))
		{
			var_visible = 0;
		}
	}
	else if(!var_player function_can_buy_perk())
	{
		var_visible = 0;
	}
	if(!var_visible)
	{
		return 0;
	}
	self function_SetVisibleToPlayer(var_player);
	return 1;
}

/*
	Name: function_player_has_all_available_perks
	Namespace: namespace_a74e4f35
	Checksum: 0x424F4353
	Offset: 0x84C0
	Size: 0x98
	Parameters: 0
	Flags: None
	Line Number: 2228
*/
function function_player_has_all_available_perks()
{
	for(var_i = 0; var_i < level.var__custom_perks.size; var_i++)
	{
		if(isdefined(level.var_c0bbcc46[level.var__custom_perks[var_i]]) && level.var_c0bbcc46[level.var__custom_perks[var_i]])
		{
			continue;
		}
		if(!self function_hasPerk(level.var__custom_perks[var_i]))
		{
			return 0;
		}
	}
	return 1;
}

/*
	Name: function_b8bbdc71
	Namespace: namespace_a74e4f35
	Checksum: 0x424F4353
	Offset: 0x8560
	Size: 0xB68
	Parameters: 0
	Flags: None
	Line Number: 2254
*/
function function_b8bbdc71()
{
	level notify("hash_end_game");
	foreach(var_player in function_GetPlayers())
	{
		while(var_player.var_84298650.size > 0)
		{
			wait(0.1);
		}
	}
	namespace_zm::function_check_end_game_intermission_delay();
	function_SetMatchFlag("game_ended", 1);
	level namespace_clientfield::function_set("gameplay_started", 0);
	level namespace_clientfield::function_set("game_end_time", function_Int(GetTime() - level.var_n_gameplay_start_time + 500 / 1000));
	namespace_util::function_clientNotify("zesn");
	level thread namespace_zm_audio::function_sndMusicSystem_PlayState("game_over");
	var_players = function_GetPlayers();
	for(var_i = 0; var_i < var_players.size; var_i++)
	{
		var_players[var_i] namespace_clientfield::function_set("zmbLastStand", 0);
	}
	for(var_i = 0; var_i < var_players.size; var_i++)
	{
		if(var_players[var_i] namespace_laststand::function_player_is_in_laststand())
		{
			var_players[var_i] function_RecordPlayerDeathZombies();
			var_players[var_i] namespace_zm_stats::function_increment_player_stat("deaths");
			var_players[var_i] namespace_zm_stats::function_increment_client_stat("deaths");
		}
		if(isdefined(var_players[var_i].var_reviveTextHud))
		{
			var_players[var_i].var_reviveTextHud function_destroy();
		}
	}
	function_StopAllRumbles();
	level.var_intermission = 1;
	level.var_zombie_vars["zombie_powerup_insta_kill_time"] = 0;
	level.var_zombie_vars["zombie_powerup_fire_sale_time"] = 0;
	level.var_zombie_vars["zombie_powerup_double_points_time"] = 0;
	wait(0.1);
	var_game_over = [];
	var_survived = [];
	function_SetMatchFlag("disableIngameMenu", 1);
	foreach(var_player in var_players)
	{
		var_player function_closeInGameMenu();
		var_player function_CloseMenu("StartMenu_Main");
	}
	foreach(var_player in var_players)
	{
		var_player function_SetDStat("AfterActionReportStats", "lobbyPopup", "summary");
	}
	if(!isdefined(level.var__supress_survived_screen))
	{
		for(var_i = 0; var_i < var_players.size; var_i++)
		{
			var_game_over[var_i] = function_newClientHudElem(var_players[var_i]);
			var_survived[var_i] = function_newClientHudElem(var_players[var_i]);
			if(isdefined(level.var_custom_game_over_hud_elem))
			{
				[[level.var_custom_game_over_hud_elem]](var_players[var_i], var_game_over[var_i], var_survived[var_i]);
			}
			else
			{
				var_game_over[var_i].var_alignX = "center";
				var_game_over[var_i].var_alignY = "middle";
				var_game_over[var_i].var_horzAlign = "center";
				var_game_over[var_i].var_vertAlign = "middle";
				var_game_over[var_i].var_y = var_game_over[var_i].var_y - 180;
				var_game_over[var_i].var_foreground = 1;
				var_game_over[var_i].var_fontscale = 3;
				var_game_over[var_i].var_alpha = 0;
				var_game_over[var_i].var_color = (1, 1, 1);
				var_game_over[var_i].var_hidewheninmenu = 1;
				var_game_over[var_i] function_setText(level.var_9b1ad299);
				var_game_over[var_i] function_fadeOverTime(1);
				var_game_over[var_i].var_alpha = 1;
				if(var_players[var_i] function_IsSplitscreen())
				{
					var_game_over[var_i].var_fontscale = 2;
					var_game_over[var_i].var_y = var_game_over[var_i].var_y + 40;
				}
				var_survived[var_i].var_alignX = "center";
				var_survived[var_i].var_alignY = "middle";
				var_survived[var_i].var_horzAlign = "center";
				var_survived[var_i].var_vertAlign = "middle";
				var_survived[var_i].var_y = var_survived[var_i].var_y - 150;
				var_survived[var_i].var_foreground = 1;
				var_survived[var_i].var_fontscale = 2;
				var_survived[var_i].var_alpha = 0;
				var_survived[var_i].var_color = (1, 1, 1);
				var_survived[var_i].var_hidewheninmenu = 1;
				if(var_players[var_i] function_IsSplitscreen())
				{
					var_survived[var_i].var_fontscale = 1.5;
					var_survived[var_i].var_y = var_survived[var_i].var_y + 40;
				}
			}
			if(level.var_round_number < 2)
			{
				var_survived[var_i] function_setText(&"ZOMBIE_SURVIVED_ROUND");
			}
			else
			{
				var_survived[var_i] function_setText(&"ZOMBIE_SURVIVED_ROUNDS", level.var_round_number);
			}
			var_survived[var_i] function_fadeOverTime(1);
			var_survived[var_i].var_alpha = 1;
		}
	}
	else if(isdefined(level.var_custom_end_screen))
	{
		level [[level.var_custom_end_screen]]();
	}
	for(var_i = 0; var_i < var_players.size; var_i++)
	{
		var_players[var_i] function_setClientUIVisibilityFlag("weapon_hud_visible", 0);
		var_players[var_i] function_SetClientMiniScoreboardHide(1);
		var_players[var_i] notify("hash_report_bgb_consumption");
	}
	function_UploadStats();
	namespace_zm_stats::function_update_players_stats_at_match_end(var_players);
	namespace_zm_stats::function_update_global_counters_on_match_end();
	namespace_zm::function_upload_leaderboards();
	function_recordGameResult("draw");
	function_finalizeMatchRecord();
	var_players = function_GetPlayers();
	foreach(var_player in var_players)
	{
		if(isdefined(var_player.var_sessionstate) && var_player.var_sessionstate == "spectator")
		{
			var_player.var_sessionstate = "playing";
			var_player thread namespace_zm::function_end_game_player_was_spectator();
		}
	}
	level.var_disable_intermission = 1;
	wait(0.05);
	level notify("hash_7eb0c57");
}

/*
	Name: function_player_exit_level
	Namespace: namespace_a74e4f35
	Checksum: 0x424F4353
	Offset: 0x90D0
	Size: 0x4C
	Parameters: 0
	Flags: None
	Line Number: 2404
*/
function function_player_exit_level()
{
	self function_AllowStand(1);
	self function_AllowCrouch(0);
	self function_AllowProne(0);
}

