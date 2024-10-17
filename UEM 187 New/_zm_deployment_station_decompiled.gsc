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
	Name: __init__sytem__
	Namespace: namespace_a74e4f35
	Checksum: 0x424F4353
	Offset: 0x19E8
	Size: 0x38
	Parameters: 0
	Flags: AutoExec
	Line Number: 45
*/
function autoexec __init__sytem__()
{
	system::register("zm_deployment_station", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: namespace_a74e4f35
	Checksum: 0x424F4353
	Offset: 0x1A28
	Size: 0x400
	Parameters: 0
	Flags: None
	Line Number: 60
*/
function __init__()
{
	util::registerClientSys("UEM.ExfilUI");
	level.var_e33eb0d5 = array("ray_gun", "raygun_mark2", "raygun_mark3", "ray_gun_up", "raygun_mark2_up", "ray_gun_upgraded", "raygun_mark2_upgraded", "raygun_mark3_up", "raygun_mark3_upgraded", "thundergun", "idgun_0", "idgun_1", "idgun_2", "idgun_3", "idgun_upgraded_0", "idgun_genesis_0", "idgun_genesis_0_upgraded", "staff_fire", "staff_water", "staff_lightning", "staff_air", "idgun_upgraded_1", "idgun_upgraded_2", "idgun_upgraded_3", "t7_idgun_genesis_0", "t7_idgun_genesis_0_upgraded", "thundergun_upgraded", "t7_staff_air", "t7_staff_fire", "t7_staff_lightning", "t7_staff_water", "t7_hero_mirg2000", "t8_shotgun_blundergat", "t8_shotgun_acidgat", "t8_shotgun_magmagat", "t8_zombie_tomahawk", "t7_shrink_ray", "t7_staff_air_upgraded", "t7_staff_fire_upgraded", "t7_staff_lightning_upgraded", "t7_staff_water_upgraded", "t7_hero_mirg2000_upgraded", "t8_shotgun_blundergat_upgraded", "t8_shotgun_acidgat_upgraded", "t8_shotgun_magmagat_upgraded", "t8_zombie_tomahawk_upgraded", "t7_shrink_ray_upgraded", "t7_microwavegundw_upgraded", "t9_gallo_raygun", "t9_gallo_raygun_up", "staff_fire_upgraded", "staff_water_upgraded", "staff_lightning_upgraded", "staff_air_upgraded", "elemental_bow", "elemental_bow_storm", "elemental_bow_demongate", "elemental_bow_rune_prison", "elemental_bow_wolf", "t9_crossbow_skull", "t9_crossbow_skull_up", "shrink_ray", "madgaz_cng_zm", "madgaz_cng2_zm", "madgaz_cng3_zm", "tesla_gun", "tesla_gun_upgraded", "shrink_ray_upgraded", "madgaz_cng_upgraded_zm", "madgaz_cng2_upgraded_zm", "madgaz_cng3_upgraded_zm", "t7_microwavegundw", "microwavegundw", "microwavegundw_upgraded", "elemental_bow_wolf_howl", "pistol_m1911_upgraded");
	level._effect["deployment_station_hologram_ammo"] = "_sphynx/_zm_hologram_deployment_station";
	level._effect["deployment_station_break"] = "dlc1/castle/fx_castle_electric_cherry_trail";
	level._effect["deployment_station_exfil_nuke_explosion"] = "custom/explosion/bow_arrow_explode_os";
	level.var_679e1a9e = 0;
	level.var_22a274bc = 1;
	level.var_6e1a05ca = 15;
	level.var_abcf67a6 = 0;
	level flag::init("exfil_activated");
	level flag::init("exfil_kills_completed");
	level thread function_737643fd();
	level thread function_f18486d2();
	callback::on_spawned(&on_player_spawned);
	wait(0.05);
	level flag::wait_till("initial_blackscreen_passed");
	level.var_ee5d3b93 = level.zombie_vars["zombie_between_round_time"];
	level.var_8e473ceb = level.zombie_vars["zombie_move_speed_multiplier"];
}

/*
	Name: function_737643fd
	Namespace: namespace_a74e4f35
	Checksum: 0x424F4353
	Offset: 0x1E30
	Size: 0x138
	Parameters: 0
	Flags: None
	Line Number: 92
*/
function function_737643fd()
{
	level endon("end_game");
	for(;;)
	{
		level waittill("between_round_over");
		if(level.round_number == level.var_6e1a05ca && level.round_number != level.next_dog_round)
		{
			level.var_abcf67a6 = 1;
			level util::waittill_any_return("end_of_round", "increase_exfil_round");
			level.var_6e1a05ca = level.var_6e1a05ca + 5;
			level.var_abcf67a6 = 0;
		}
		else if(level.round_number == level.var_6e1a05ca && level.round_number == level.next_dog_round)
		{
			level.var_6e1a05ca = level.var_6e1a05ca + 1;
			if(level.round_number != level.var_6e1a05ca)
			{
			}
			else
			{
				level util::waittill_any_return("end_of_round", "increase_exfil_round");
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
	Offset: 0x1F70
	Size: 0x290
	Parameters: 0
	Flags: None
	Line Number: 131
*/
function function_f18486d2()
{
	level endon("end_game");
	while(1)
	{
		wait(10);
		foreach(player in getplayers())
		{
			if(getplayers().size >= 2)
			{
				if(player == getplayers()[0])
				{
					if(level flag::get("classic_enabled"))
					{
						player.var_beea7f3e = array("exfil", "rageinducer");
					}
					else
					{
						player.var_beea7f3e = array("ammo", "wunderfizz", "cashshare", "exfil", "rageinducer");
					}
				}
				else if(level flag::get("classic_enabled"))
				{
					player.var_beea7f3e = array("");
				}
				else
				{
					player.var_beea7f3e = array("ammo", "wunderfizz", "cashshare");
					continue;
				}
			}
			if(player == getplayers()[0])
			{
				if(level flag::get("classic_enabled"))
				{
					player.var_beea7f3e = array("exfil", "rageinducer");
					continue;
				}
				player.var_beea7f3e = array("ammo", "wunderfizz", "exfil", "rageinducer");
			}
		}
	}
}

/*
	Name: on_player_spawned
	Namespace: namespace_a74e4f35
	Checksum: 0x424F4353
	Offset: 0x2208
	Size: 0x4D0
	Parameters: 0
	Flags: None
	Line Number: 185
*/
function on_player_spawned()
{
	self endon("bled_out");
	self endon("spawned_player");
	self endon("disconnect");
	wait(0.05);
	level flag::wait_till("initial_blackscreen_passed");
	wait(2);
	self.var_1bfcbff5 = 0;
	if(getplayers().size >= 2)
	{
		if(self == getplayers()[0])
		{
			if(level flag::get("classic_enabled"))
			{
				self.var_beea7f3e = array("exfil", "rageinducer");
			}
			else
			{
				self.var_beea7f3e = array("ammo", "wunderfizz", "cashshare", "exfil", "rageinducer");
			}
		}
		else if(level flag::get("classic_enabled"))
		{
			self.var_beea7f3e = array("");
		}
		else
		{
			self.var_beea7f3e = array("ammo", "wunderfizz", "cashshare");
		}
	}
	else if(self == getplayers()[0])
	{
		if(level flag::get("classic_enabled"))
		{
			self.var_beea7f3e = array("exfil", "rageinducer");
		}
		else
		{
			self.var_beea7f3e = array("ammo", "wunderfizz", "exfil", "rageinducer");
		}
	}
	while(self actionslotfourbuttonpressed() && (isdefined(level.var_22a274bc) && level.var_22a274bc) && self.var_beea7f3e.size > 0)
	{
		if(isdefined(self.var_78f55b66))
		{
			self.var_78f55b66.owner notify("hash_ba61275c");
			wait(2);
		}
		else
		{
			wait(0.2);
			self.var_78f55b66 = util::spawn_model("tag_origin", self.origin, self.angles);
			playable_area = getentarray("player_volume", "script_noteworthy");
			valid_drop = 0;
			for(i = 0; i < playable_area.size; i++)
			{
				if(self.var_78f55b66 istouching(playable_area[i]))
				{
					valid_drop = 1;
					break;
				}
			}
			if(isdefined(valid_drop) && valid_drop)
			{
				self.var_1bfcbff5 = 60;
				self thread function_2688f86d();
				self.var_78f55b66 setmodel("p7_zm_ctl_artifact_containment");
				playsoundatposition("deployment_station_drop", self.origin);
				final_pos = zm_weapons::function_a2b97522(self, 60, self.var_78f55b66);
				var_8f7442a5 = util::ground_position(final_pos, 500, 4);
				self.var_78f55b66 zm_utility::fake_physicslaunch(var_8f7442a5, 140);
				self.var_78f55b66 thread function_cad8d6d5(self, 60);
				wait(2);
			}
			else
			{
				self.var_78f55b66 delete();
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
	Offset: 0x26E0
	Size: 0x50
	Parameters: 0
	Flags: None
	Line Number: 280
*/
function function_2688f86d()
{
	self endon("bled_out");
	self endon("spawned_player");
	self endon("disconnect");
	while(self.var_1bfcbff5 > 0)
	{
		self.var_1bfcbff5--;
		wait(1);
	}
	return;
}

/*
	Name: function_cad8d6d5
	Namespace: namespace_a74e4f35
	Checksum: 0x424F4353
	Offset: 0x2738
	Size: 0x3F8
	Parameters: 2
	Flags: None
	Line Number: 303
*/
function function_cad8d6d5(owner, var_60a2c1f7)
{
	owner flag::init("deployment_machine_can_reset");
	self.var_54735102 = 0;
	self EnableLinkTo();
	wait(1);
	playsoundatposition("deployment_station_activate", self.origin);
	self playloopsound("deployment_station_idle");
	self.owner = owner;
	self.var_e42e02e3 = 0;
	self.var_9186076d = util::spawn_model("tag_origin", self.origin, self.angles);
	self.var_9186076d = playfxontag(level._effect["deployment_station_hologram_ammo"], self.var_9186076d, "tag_origin");
	if(level flag::get("classic_enabled"))
	{
		self.var_40b69c4c = util::spawn_model("zmu_nuke_hologram_disabled", self.origin + VectorScale((0, 0, 1), 40), self.angles);
	}
	else
	{
		self.var_40b69c4c = util::spawn_model("zmu_bullet_hologram", self.origin + VectorScale((0, 0, 1), 40), self.angles);
	}
	self.var_40b69c4c thread function_2fc45e69();
	self.var_9186076d linkto(self);
	if(tolower(getdvarstring("mapname")) != "zm_castle")
	{
		self clientfield::set("weapon_drop_level_enable_keyline", 2);
	}
	else
	{
		self clientfield::set("weapon_drop_enable_keyline", 2);
	}
	self thread function_549fbbec(var_60a2c1f7);
	self thread function_561555f1(owner);
	self create_unitrigger(&"ZM_MINECRAFT_DEPLOYMENT_STATION_DISABLED", undefined, &function_5b42a9c7);
	while(isdefined(self))
	{
		self waittill("trigger_activated", player);
		switch(player.var_beea7f3e[self.var_54735102])
		{
			case "ammo":
			{
				self thread function_1de4829(player);
				break;
			}
			case "wunderfizz":
			{
				self thread function_bced5f58(player);
				break;
			}
			case "cashshare":
			{
				self thread function_c0efee41(player);
				break;
			}
			case "exfil":
			{
				self thread function_ab74af48(player);
				break;
			}
			case "rageinducer":
			{
				if(!(isdefined(self.var_e42e02e3) && self.var_e42e02e3))
				{
					self thread function_6d9383c(player);
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
	Offset: 0x2B38
	Size: 0x4C8
	Parameters: 1
	Flags: None
	Line Number: 384
*/
function function_bced5f58(player)
{
	wait(0.1);
	if(!(isdefined(self.var_4c2c3d65) && self.var_4c2c3d65))
	{
		while(1)
		{
			player flag::clear("deployment_machine_can_reset");
			if(!player zm_score::can_player_purchase(level._random_zombie_perk_cost + player.num_perks * 250) || !player zm_utility::can_player_purchase_perk() || (isdefined(player player_has_all_available_perks()) && player player_has_all_available_perks()) || player.var_9ee9bcc6 < 10)
			{
				self playsound("evt_perk_deny");
				break;
			}
			self.owner.var_1bfcbff5 = self.owner.var_1bfcbff5 + 15;
			self.var_efe0cd4e = util::spawn_model("tag_origin", self.var_40b69c4c.origin, self.var_40b69c4c.angles);
			self.var_efe0cd4e = playfxontag("electric/fx_ability_elec_surge_short_robot_optim", self.var_efe0cd4e, "tag_origin");
			self.var_4c2c3d65 = 1;
			self.machine_user = player;
			player zm_score::minus_to_player_score(level._random_zombie_perk_cost + player.num_perks * 250);
			player.pers["deploy_wunderfizz"]++;
			player zm_stats::increment_player_stat("wunderfizz_used");
			player thread namespace_97ac1184::function_1d39abf6("end_game_deploy_wunderfizz", 1, 0);
			player thread namespace_97ac1184::function_7e18304e("spx_save_data", "deploy_wunderfizz", player.pers["deploy_wunderfizz"], 0);
			random_perk = get_weighted_random_perk(player);
			wait(1);
			self playsound("zmb_rand_perk_start");
			self playloopsound("zmb_rand_perk_loop", 1);
			self thread start_perk_bottle_cycling();
			self thread perk_bottle_motion();
			model = get_perk_weapon_model(random_perk);
			wait(3);
			self notify("done_cycling");
			self.var_40b69c4c setmodel(model);
			self playsound("zmb_rand_perk_bottle");
			self.grab_perk_hint = 1;
			self thread grab_check(player, random_perk);
			self thread time_out_check(player);
			self util::waittill_either("grab_check", "time_out_check");
			self.grab_perk_hint = 0;
			self playsound("zmb_rand_perk_stop");
			self stoploopsound(0.5);
			self.machine_user = undefined;
			self.var_40b69c4c setmodel("zmu_wunderfizz_hologram");
			if(isdefined(self.var_efe0cd4e))
			{
				self.var_efe0cd4e delete();
				break;
			}
		}
	}
	else
	{
		self playsound("evt_perk_deny");
	}
	player flag::wait_till("deployment_machine_can_reset");
	self.var_4c2c3d65 = 0;
	wait(0.2);
}

/*
	Name: function_ab74af48
	Namespace: namespace_a74e4f35
	Checksum: 0x424F4353
	Offset: 0x3008
	Size: 0x218
	Parameters: 1
	Flags: None
	Line Number: 453
*/
function function_ab74af48(player)
{
	if(!(isdefined(level.var_abcf67a6) && level.var_abcf67a6) || (isdefined(level flag::get("exfil_activated")) && level flag::get("exfil_activated")))
	{
		self.var_40b69c4c setmodel("zmu_nuke_hologram_disabled");
		wait(1);
		if(player.var_beea7f3e[self.var_54735102] == "exfil")
		{
			self.var_40b69c4c setmodel("zmu_nuke_hologram");
			return;
		}
	}
	else
	{
		self.owner notify("hash_ba61275c");
		wait(0.1);
		level thread lui::screen_flash(0.5, 0.5, 0.5, 1, "white");
		wait(0.8);
		var_ecd7621f = util::spawn_model("zmu_nuke", self.origin, self.angles - VectorScale((0, 1, 0), 180));
		var_ecd7621f thread function_b45d4781();
		foreach(player in getplayers())
		{
			player playsoundtoplayer("exfil_objective_start", player);
		}
	}
}

/*
	Name: function_b45d4781
	Namespace: namespace_a74e4f35
	Checksum: 0x424F4353
	Offset: 0x3228
	Size: 0x2F0
	Parameters: 1
	Flags: None
	Line Number: 490
*/
function function_b45d4781(var_93d5d8b9)
{
	level flag::set("exfil_activated");
	foreach(player in getplayers())
	{
		player playsoundtoplayer("mus_exfil_start", player);
		player.pers["exfil_started"]++;
		player thread namespace_97ac1184::function_1d39abf6("end_game_exfil_started", 1, 0);
		player thread namespace_97ac1184::function_7e18304e("spx_save_data", "exfil_started", player.pers["exfil_started"], 0);
		wait(0.1 * player getentitynumber() + 1);
	}
	self.trigger_use = spawn("trigger_radius_use", self.origin + VectorScale((0, 0, 1), 40), 0, 100, 100);
	self.trigger_use triggerignoreteam();
	self.trigger_use setvisibletoall();
	self.trigger_use setteamfortrigger("none");
	self.trigger_use usetriggerrequirelookat();
	self.trigger_use setcursorhint("HINT_NOICON");
	self.trigger_use sethintstring(&"ZM_MINECRAFT_EXFIL_NUKE_HINT_START");
	self.trigger_use triggerenable(0);
	self thread function_69808090();
	while(level flag::get("exfil_activated"))
	{
		self.trigger_use waittill("trigger", player);
		self.trigger_use delete();
		self function_e78fd5a2();
		wait(0.05);
		break;
	}
	return;
	ERROR: Exception occured: Stack empty.
}

/*
	Name: function_e78fd5a2
	Namespace: namespace_a74e4f35
	Checksum: 0x424F4353
	Offset: 0x3520
	Size: 0x850
	Parameters: 0
	Flags: None
	Line Number: 532
*/
function function_e78fd5a2()
{
	foreach(player in getplayers())
	{
		player playsoundtoplayer("exfil_nuke_countdown_popup", player);
	}
	wait(2);
	foreach(player in getplayers())
	{
		player playsoundtoplayer("exfil_nuke_countdown", player);
	}
	wait(3);
	foreach(player in getplayers())
	{
		player.pers["succesful_exfil"]++;
		level notify("hash_8c3d4295", player, "succesful_exfil", 1, 0);
		if(player.downs < 1)
		{
			player thread namespace_97ac1184::function_7e18304e("spx_save_data", "flawless_game", player.pers["flawless_game"], 0);
		}
		player thread namespace_97ac1184::function_1d39abf6("end_game_succesful_exfil", 1, 0);
		player thread namespace_97ac1184::function_7e18304e("spx_save_data", "succesful_exfil", player.pers["succesful_exfil"], 0);
		player notify("hash_79ef118b", "succesful_exfil", undefined);
		wait(0.1 * player getentitynumber() + 1);
	}
	wait(2.8);
	level flag::clear("spawn_zombies");
	a_ai_enemies = getaiteamarray("axis");
	foreach(ai_enemy in a_ai_enemies)
	{
		level.zombie_total++;
		level.zombie_respawns++;
		ai_enemy dodamage(ai_enemy.health + 666, ai_enemy.origin);
		wait(0.05);
	}
	wait(2.4);
	foreach(player in getplayers())
	{
		player playsoundtoplayer("exfil_nuke_blast_start", player);
		player luinotifyevent(&"spx_milestone_notification", 1, &"ZM_MINECRAFT_NOTIFICATION_SUCCESFUL_EXFIL");
		wait(0.1 * player getentitynumber() + 1);
	}
	wait(1.8);
	var_8d2d167 = util::spawn_model("tag_origin", self.origin, self.angles);
	var_8d2d167 = playfxontag(level._effect["deployment_station_exfil_nuke_explosion"], var_8d2d167, "tag_origin");
	earthquake(1, 0.5, self.origin, 1000);
	foreach(player in getplayers())
	{
		player enableinvulnerability();
		player disableweapons();
		player disableoffhandweapons();
		player freezecontrols(1);
		player playsoundtoplayer("exfil_nuke_blast_main", player);
		player playsoundtoplayer("exfil_nuke_blast_main_quad", player);
	}
	level.custom_game_over_hud_elem = &function_fdef49b1;
	wait(0.15);
	level thread lui::screen_flash(0.5, 0.5, 0.5, 1, "white");
	wait(1);
	self delete();
	level thread namespace_97ac1184::function_231f215a();
	wait(2);
	function_b8bbdc71();
	foreach(player in getplayers())
	{
		player playsoundtoplayer("exfil_nuke_blast_tail", player);
	}
	wait(4);
	foreach(player in getplayers())
	{
		player playsoundtoplayer("exfil_nuke_blast_debris", player);
	}
	var_8d2d167 delete();
}

/*
	Name: function_e73f8706
	Namespace: namespace_a74e4f35
	Checksum: 0x424F4353
	Offset: 0x3D78
	Size: 0x68
	Parameters: 0
	Flags: None
	Line Number: 617
*/
function function_e73f8706()
{
	self endon("hash_c34621d7");
	self.var_11c8060e = 0;
	if(self.var_11c8060e > 1)
	{
		while(self.var_b85985e3 < self.var_11c8060e)
		{
			level waittill("hash_5dcb913f", player);
			self.var_b85985e3++;
		}
		return;
	}
	return;
}

/*
	Name: function_69808090
	Namespace: namespace_a74e4f35
	Checksum: 0x424F4353
	Offset: 0x3DE8
	Size: 0x6A8
	Parameters: 0
	Flags: None
	Line Number: 643
*/
function function_69808090()
{
	a_ai_enemies = getaiteamarray("axis");
	foreach(ai_enemy in a_ai_enemies)
	{
		level.zombie_total++;
		level.zombie_respawns++;
		ai_enemy kill();
		wait(0.1);
	}
	level.var_147d7517["nuke"] = 0;
	level.var_147d7517["insta_kill"] = 0;
	level.var_a08671cd = int(80 + getplayers().size * 35);
	foreach(player in getplayers())
	{
		player luinotifyevent(&"ZMBU_info", 2, &"ZM_MINECRAFT_ZOMBIES_EXFIL_REMAINING", level.var_a08671cd);
	}
	level thread change_difficulty("super_hard");
	wait(0.05);
	zm_spawner::register_zombie_death_event_callback(&function_7ff88724);
	self thread function_6670e675();
	self thread function_9de33d29();
	self util::waittill_any_timeout(180, "stop_exfil_function");
	if(level.var_a08671cd <= 0)
	{
		level thread function_6ee0e787("Show1");
		level thread lui::screen_flash(0.2, 0.5, 1, 0.8, "white");
		self.trigger_use sethintstring(&"ZM_MINECRAFT_EXFIL_NUKE_HINT_END");
		self.trigger_use triggerenable(1);
		self util::waittill_any_timeout(60, "stop_exfil_function");
		level flag::clear("spawn_zombies");
		a_ai_enemies = getaiteamarray("axis");
		foreach(ai_enemy in a_ai_enemies)
		{
			level.zombie_total++;
			level.zombie_respawns++;
			ai_enemy dodamage(ai_enemy.health + 666, ai_enemy.origin);
			wait(0.1);
		}
	}
	else
	{
		foreach(player in getplayers())
		{
			player luinotifyevent(&"spx_milestone_notification", 1, &"ZM_MINECRAFT_NOTIFICATION_UNSUCCESFUL_EXFIL");
		}
		level thread function_6ee0e787("Show2");
		level flag::set("spawn_zombies");
		level flag::clear("exfil_kills_completed");
		level flag::clear("exfil_activated");
		if(!(isdefined(level.var_679e1a9e) && level.var_679e1a9e))
		{
			level thread change_difficulty("normal");
		}
		level.custom_game_over_hud_elem = undefined;
		level notify("hash_67d1d80d");
		wait(0.05);
		self.trigger_use delete();
		self delete();
	}
	level.var_147d7517["nuke"] = 1;
	level.var_147d7517["insta_kill"] = 1;
	foreach(player in getplayers())
	{
		player stopSound("mus_exfil_start");
	}
	zm_spawner::deregister_zombie_death_event_callback(&function_7ff88724);
	wait(5);
	level thread function_6ee0e787("0");
}

/*
	Name: function_6ee0e787
	Namespace: namespace_a74e4f35
	Checksum: 0x424F4353
	Offset: 0x4498
	Size: 0xB0
	Parameters: 1
	Flags: None
	Line Number: 724
*/
function function_6ee0e787(value)
{
	foreach(player in getplayers())
	{
		util::setclientsysstate("UEM.ExfilUI", value, player);
		wait(0.5);
	}
}

/*
	Name: function_9de33d29
	Namespace: namespace_a74e4f35
	Checksum: 0x424F4353
	Offset: 0x4550
	Size: 0x60
	Parameters: 0
	Flags: None
	Line Number: 743
*/
function function_9de33d29()
{
	for(i = 180; i > 0; i--)
	{
		level thread function_6ee0e787(level.var_a08671cd + "," + i);
		wait(1);
	}
	return;
	~i;
	ERROR: Exception occured: Stack empty.
}

/*
	Name: function_6670e675
	Namespace: namespace_a74e4f35
	Checksum: 0x424F4353
	Offset: 0x45B8
	Size: 0x90
	Parameters: 0
	Flags: None
	Line Number: 765
*/
function function_6670e675()
{
	self endon("hash_c34621d7");
	while(level flag::get("exfil_activated") && level.var_a08671cd > 0)
	{
		wait(1);
	}
	level flag::set("exfil_kills_completed");
	self notify("hash_c34621d7");
	level thread function_6ee0e787("0");
}

/*
	Name: function_5b5b8605
	Namespace: namespace_a74e4f35
	Checksum: 0x424F4353
	Offset: 0x4650
	Size: 0x190
	Parameters: 0
	Flags: None
	Line Number: 787
*/
function function_5b5b8605()
{
	var_f70e33ad = 0;
	var_9e8d37be = level.var_a08671cd + 50;
	while(level flag::get("exfil_activated") && var_f70e33ad < var_9e8d37be + 30)
	{
		if(zombie_utility::get_current_zombie_count() < 36)
		{
			spawner = array::random(level.zombie_spawners);
			zombie = zombie_utility::spawn_zombie(spawner);
			wait(0.5);
			zombie.b_ignore_cleanup = 1;
			zombie.ignore_cleanup_mgr = 1;
			zombie.no_powerups = 1;
			if(isdefined(zombie.health))
			{
				zombie.health = zombie.health + zombie.health * 3;
				zombie.maxhealth = zombie.health;
			}
			zombie thread function_75e5ed2();
			var_f70e33ad++;
		}
		wait(0.15);
	}
}

/*
	Name: function_75e5ed2
	Namespace: namespace_a74e4f35
	Checksum: 0x424F4353
	Offset: 0x47E8
	Size: 0x1A8
	Parameters: 0
	Flags: None
	Line Number: 823
*/
function function_75e5ed2()
{
	wait(5);
	if(isdefined(self))
	{
		if(!self CanPath(self.origin, self.favoriteenemy.origin))
		{
			dog_locs = array::randomize(level.zm_loc_types["dog_location"]);
			if(dog_locs.size > 0)
			{
				self forceteleport(dog_locs.origin, dog_locs.angles, 1);
			}
			else
			{
				var_741d29ca = getplayers()[0] zm_zonemgr::get_player_zone();
				var_a638c0c2 = getclosestpointonnavmesh(array::random(getarraykeys(level.zones[var_741d29ca].adjacent_zones))[0].origin, 250, 250);
				if(ispointonnavmesh(var_a638c0c2, self))
				{
					self forceteleport(var_a638c0c2.origin, var_a638c0c2.angles, 1);
				}
			}
		}
	}
}

/*
	Name: function_7ff88724
	Namespace: namespace_a74e4f35
	Checksum: 0x424F4353
	Offset: 0x4998
	Size: 0x48
	Parameters: 1
	Flags: Private
	Line Number: 858
*/
function private function_7ff88724(e_attacker)
{
	level.var_a08671cd--;
	e_attacker luinotifyevent(&"ZMBU_info", 2, &"ZM_MINECRAFT_ZOMBIES_EXFIL_REMAINING", level.var_a08671cd);
	return -1;
}

/*
	Name: function_fdef49b1
	Namespace: namespace_a74e4f35
	Checksum: 0x424F4353
	Offset: 0x49E8
	Size: 0x400
	Parameters: 3
	Flags: None
	Line Number: 875
*/
function function_fdef49b1(player, game_over, survived)
{
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
	game_over settext("Succesfully Detonated M.O.A.B");
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
	if(level.round_number < 2)
	{
		if(level.script == "zm_moon")
		{
			if(!isdefined(level.left_nomans_land))
			{
				nomanslandtime = level.nml_best_time;
				player_survival_time = int(nomanslandtime / 1000);
				player_survival_time_in_mins = zm::to_mins(player_survival_time);
				survived settext(&"ZOMBIE_SURVIVED_NOMANS", player_survival_time_in_mins);
			}
			else if(level.left_nomans_land == 2)
			{
				survived settext(&"ZOMBIE_SURVIVED_ROUND");
			}
		}
		else
		{
			survived settext(&"ZOMBIE_SURVIVED_ROUND");
		}
	}
	else
	{
		survived settext(&"ZOMBIE_SURVIVED_ROUNDS", level.round_number);
	}
	survived fadeovertime(1);
	survived.alpha = 1;
}

/*
	Name: function_c0efee41
	Namespace: namespace_a74e4f35
	Checksum: 0x424F4353
	Offset: 0x4DF0
	Size: 0x3B0
	Parameters: 1
	Flags: None
	Line Number: 949
*/
function function_c0efee41(player)
{
	if(player hasperk("specialty_immunetriggerbetty"))
	{
	}
	else
	{
	}
	var_a8ce65bc = 1100;
	if(!player zm_score::can_player_purchase(var_a8ce65bc))
	{
		zm_utility::play_sound_at_pos("no_purchase", player.origin);
		player zm_audio::create_and_play_dialog("general", "outofmoney");
		self.var_40b69c4c setmodel("zmu_cash_share_hologram_disabled");
		wait(1);
		if(player.var_beea7f3e[self.var_54735102] == "cashshare")
		{
			self.var_40b69c4c setmodel("zmu_cash_share_hologram");
			return;
		}
	}
	self.owner.var_1bfcbff5 = self.owner.var_1bfcbff5 + 15;
	var_a85e9ccd = getplayers();
	if(var_a85e9ccd.size > 1)
	{
		var_a85e9ccd = arraysortclosest(var_a85e9ccd, self.origin);
		if(var_a85e9ccd[0] == player)
		{
			target_player = var_a85e9ccd[1];
		}
		else
		{
			target_player = var_a85e9ccd[0];
		}
		if(player zm_score::can_player_purchase(var_a8ce65bc) && isdefined(target_player))
		{
			if(distance(self.origin, target_player.origin) < 500)
			{
				player zm_score::minus_to_player_score(var_a8ce65bc);
				zm_utility::play_sound_at_pos("purchase", player.origin);
				player zm_audio::create_and_play_dialog("general", "generic_wall_buy");
				player.pers["deploy_cash_shared"] = player.pers["deploy_cash_shared"] + 1000;
				player thread namespace_97ac1184::function_1d39abf6("end_game_deploy_cash_shared", 1000, 0);
				player thread namespace_97ac1184::function_7e18304e("spx_save_data", "deploy_cash_shared", player.pers["deploy_cash_shared"], 0);
				target_player zm_score::add_to_player_score(1000, 1, "deployment_cash");
			}
			else
			{
				self.var_40b69c4c setmodel("zmu_cash_share_hologram_disabled");
				wait(1);
				if(player.var_beea7f3e[self.var_54735102] == "cashshare")
				{
					self.var_40b69c4c setmodel("zmu_cash_share_hologram");
				}
			}
		}
	}
}

/*
	Name: function_561555f1
	Namespace: namespace_a74e4f35
	Checksum: 0x424F4353
	Offset: 0x51A8
	Size: 0x3A8
	Parameters: 1
	Flags: None
	Line Number: 1018
*/
function function_561555f1(owner)
{
	self.var_f7ad445d = spawn("trigger_damage", self.origin + VectorScale((0, 0, 1), 45), 0, 120, 120);
	while(isdefined(self.var_f7ad445d))
	{
		self.var_f7ad445d waittill("damage", n_damage, e_attacker, v_dir, v_loc, str_type, str_model, str_tag, str_part, w_weapon);
		self.owner.var_1bfcbff5 = self.owner.var_1bfcbff5 + 5;
		if(e_attacker == self.owner)
		{
			if(isinarray(level.zombie_melee_weapon_list, w_weapon) || str_type == "MOD_MELEE_WEAPON_BUTT" || str_type == "MOD_MELEE" || str_type == "MOD_MELEE_ASSASSINATE")
			{
				if(!(isdefined(self.var_4c2c3d65) && self.var_4c2c3d65))
				{
					self.var_54735102++;
					if(self.var_54735102 > self.owner.var_beea7f3e.size - 1)
					{
						self.var_54735102 = 0;
					}
					switch(e_attacker.var_beea7f3e[self.var_54735102])
					{
						case "ammo":
						{
							self.var_40b69c4c setmodel("zmu_bullet_hologram");
							break;
						}
						case "wunderfizz":
						{
							self.var_40b69c4c setmodel("zmu_wunderfizz_hologram");
							break;
						}
						case "cashshare":
						{
							self.var_40b69c4c setmodel("zmu_cash_share_hologram");
							break;
						}
						case "exfil":
						{
							if(!(isdefined(level.var_abcf67a6) && level.var_abcf67a6) || (isdefined(level flag::get("exfil_activated")) && level flag::get("exfil_activated")))
							{
								self.var_40b69c4c setmodel("zmu_nuke_hologram_disabled");
							}
							else
							{
								self.var_40b69c4c setmodel("zmu_nuke_hologram");
								break;
							}
						}
						case "rageinducer":
						{
							if(isdefined(self.var_e42e02e3) && self.var_e42e02e3)
							{
								self.var_40b69c4c setmodel("zmu_skull_hologram_disabled");
							}
							else
							{
								self.var_40b69c4c setmodel("zmu_skull_hologram");
								break;
							}
						}
						default
						{
							self.var_40b69c4c setmodel("zmu_bullet_hologram");
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
	Offset: 0x5558
	Size: 0x1D0
	Parameters: 1
	Flags: None
	Line Number: 1107
*/
function function_5b42a9c7(player)
{
	self.hint_parm1 = undefined;
	self.hint_string = "";
	switch(player.var_beea7f3e[self.stub.related_parent.var_54735102])
	{
		case "ammo":
		{
			can_use = self function_b787d79(player);
			break;
		}
		case "wunderfizz":
		{
			can_use = self function_a8410970(player);
			break;
		}
		case "cashshare":
		{
			can_use = self function_1efa629(player);
			break;
		}
		case "exfil":
		{
			can_use = self function_61960960(player);
			break;
		}
		case "rageinducer":
		{
			can_use = self function_5aa2a964(player);
			break;
		}
		default
		{
			can_use = self function_6949af66(player);
		}
	}
	if(isdefined(self.hint_string))
	{
		if(isdefined(self.hint_parm1))
		{
			self sethintstring(self.hint_string, self.hint_parm1);
		}
		else
		{
			self sethintstring(self.hint_string);
		}
	}
	else
	{
		self sethintstring(&"ZM_MINECRAFT_DEPLOYMENT_STATION_DISABLED");
	}
	return can_use;
}

/*
	Name: function_6949af66
	Namespace: namespace_a74e4f35
	Checksum: 0x424F4353
	Offset: 0x5730
	Size: 0x28
	Parameters: 1
	Flags: None
	Line Number: 1171
*/
function function_6949af66(player)
{
	self.hint_string = &"ZM_MINECRAFT_DEPLOYMENT_STATION_DISABLED";
	self.hint_parm1 = undefined;
	return 0;
}

/*
	Name: function_a8410970
	Namespace: namespace_a74e4f35
	Checksum: 0x424F4353
	Offset: 0x5760
	Size: 0x340
	Parameters: 1
	Flags: None
	Line Number: 1188
*/
function function_a8410970(player)
{
	if(player.var_9ee9bcc6 < 10)
	{
		self.hint_string = &"ZM_MINECRAFT_DEPLOYMENT_STATION_WUNDERFIZZ_ROUND";
		self.hint_parm1 = 10 - player.var_9ee9bcc6;
		return 0;
	}
	else
	{
		var_dea0891b = level._random_zombie_perk_cost + player.num_perks * 250;
		if(!self trigger_visible_to_player(player))
		{
			self.hint_string = &"ZOMBIE_RANDOM_PERK_TOO_MANY";
			self.hint_parm1 = undefined;
			return 0;
		}
		if(self.stub.related_parent.owner === player)
		{
			n_purchase_limit = player zm_utility::get_player_perk_purchase_limit();
			if(!player zm_utility::can_player_purchase_perk() || (isdefined(player player_has_all_available_perks()) && player player_has_all_available_perks()))
			{
				self.hint_string = &"ZM_MINECRAFT_DEPLOYMENT_STATION_WUNDERFIZZ_ALL_PERKS";
				self.hint_parm1 = n_purchase_limit;
				return 0;
			}
			else if(isdefined(self.stub.related_parent.machine_user))
			{
				if(isdefined(self.stub.related_parent.grab_perk_hint) && self.stub.related_parent.grab_perk_hint)
				{
					self.hint_string = &"ZOMBIE_RANDOM_PERK_PICKUP";
					self.hint_parm1 = undefined;
					return 1;
				}
				else
				{
					self.hint_string = "";
					self.hint_parm1 = undefined;
					return 0;
				}
			}
			else
			{
				n_purchase_limit = player zm_utility::get_player_perk_purchase_limit();
				if(isdefined(player player_has_all_available_perks()) && player player_has_all_available_perks())
				{
					self.hint_string = &"ZM_MINECRAFT_DEPLOYMENT_STATION_WUNDERFIZZ_ALL_PERKS";
					self.hint_parm1 = undefined;
					return 0;
				}
				else if(!player zm_utility::can_player_purchase_perk())
				{
					self.hint_string = &"ZOMBIE_RANDOM_PERK_TOO_MANY";
					self.hint_parm1 = n_purchase_limit;
					return 0;
				}
				else if(player zm_score::can_player_purchase(var_dea0891b))
				{
					self.hint_string = &"ZM_MINECRAFT_DEPLOYMENT_STATION_WUNDERFIZZ";
					self.hint_parm1 = var_dea0891b;
					return 1;
				}
				else
				{
					self.hint_string = &"ZM_MINECRAFT_DEPLOYMENT_STATION_WUNDERFIZZ_NO_POINTS";
					self.hint_parm1 = var_dea0891b;
					return 0;
				}
			}
		}
		else
		{
			self.hint_string = &"ZM_MINECRAFT_DEPLOYMENT_STATION_WUNDERFIZZ_PLAYER_ONLY";
			self.hint_parm1 = undefined;
			return 0;
			return;
		}
	}
}

/*
	Name: function_5aa2a964
	Namespace: namespace_a74e4f35
	Checksum: 0x424F4353
	Offset: 0x5AA8
	Size: 0x108
	Parameters: 1
	Flags: None
	Line Number: 1278
*/
function function_5aa2a964(player)
{
	if(self.stub.related_parent.owner === player)
	{
		if(!(isdefined(self.stub.related_parent.var_e42e02e3) && self.stub.related_parent.var_e42e02e3))
		{
			if(!(isdefined(level.var_679e1a9e) && level.var_679e1a9e))
			{
				self.hint_string = &"ZM_MINECRAFT_DEPLOYMENT_STATION_RAGE_INDUCER";
				self.hint_parm1 = undefined;
				return 1;
			}
			else
			{
				self.hint_string = &"ZM_MINECRAFT_DEPLOYMENT_STATION_RAGE_INDUCER_DISABLE";
				self.hint_parm1 = undefined;
				return 1;
			}
		}
		else
		{
			self.hint_string = &"ZM_MINECRAFT_DEPLOYMENT_STATION_RAGE_INDUCER_COOLDOWN";
			self.hint_parm1 = undefined;
			return 0;
		}
	}
	else
	{
		self.hint_string = &"ZM_MINECRAFT_DEPLOYMENT_STATION_HOST_OPTION";
		self.hint_parm1 = undefined;
		return 1;
	}
}

/*
	Name: function_61960960
	Namespace: namespace_a74e4f35
	Checksum: 0x424F4353
	Offset: 0x5BB8
	Size: 0x110
	Parameters: 1
	Flags: None
	Line Number: 1322
*/
function function_61960960(player)
{
	if(self.stub.related_parent.owner === player)
	{
		if(isdefined(level flag::get("exfil_activated")) && level flag::get("exfil_activated"))
		{
			self.hint_string = &"ZM_MINECRAFT_DEPLOYMENT_STATION_EXFIL_IN_PROGRESS";
			self.hint_parm1 = undefined;
			return 1;
		}
		else if(level.var_abcf67a6)
		{
			self.hint_string = &"ZM_MINECRAFT_DEPLOYMENT_STATION_EXFIL";
			self.hint_parm1 = undefined;
			return 1;
		}
		else
		{
			self.hint_string = &"ZM_MINECRAFT_DEPLOYMENT_STATION_EXFIL_DISABLED";
			self.hint_parm1 = level.var_6e1a05ca;
			return 0;
		}
	}
	else
	{
		self.hint_string = &"ZM_MINECRAFT_DEPLOYMENT_STATION_HOST_OPTION";
		self.hint_parm1 = undefined;
		return 1;
	}
}

/*
	Name: function_1efa629
	Namespace: namespace_a74e4f35
	Checksum: 0x424F4353
	Offset: 0x5CD0
	Size: 0x140
	Parameters: 1
	Flags: None
	Line Number: 1363
*/
function function_1efa629(player)
{
	var_a8ce65bc = 1230;
	if(player hasperk("specialty_immunetriggerbetty"))
	{
	}
	else
	{
	}
	var_a8ce65bc = 1100;
	if(self.stub.related_parent.owner === player)
	{
		if(player zm_score::can_player_purchase(var_a8ce65bc))
		{
			self.hint_string = &"ZM_MINECRAFT_DEPLOYMENT_STATION_CASH_SHARE_OWNER";
			self.hint_parm1 = 100;
			return 1;
		}
		else
		{
			self.hint_string = &"ZM_MINECRAFT_DEPLOYMENT_STATION_CASH_SHARE_NO_POINTS_OWNER";
			self.hint_parm1 = var_a8ce65bc;
			return 0;
		}
	}
	else if(player zm_score::can_player_purchase(var_a8ce65bc))
	{
		self.hint_string = &"ZM_MINECRAFT_DEPLOYMENT_STATION_CASH_SHARE";
		self.hint_parm1 = 100;
		return 1;
	}
	else
	{
		self.hint_string = &"ZM_MINECRAFT_DEPLOYMENT_STATION_CASH_SHARE_NO_POINTS";
		self.hint_parm1 = var_a8ce65bc;
		return 0;
	}
}

/*
	Name: function_6d9383c
	Namespace: namespace_a74e4f35
	Checksum: 0x424F4353
	Offset: 0x5E18
	Size: 0x240
	Parameters: 1
	Flags: None
	Line Number: 1412
*/
function function_6d9383c(player)
{
	self.owner.var_1bfcbff5 = self.owner.var_1bfcbff5 + 15;
	self.var_e42e02e3 = 1;
	if(isdefined(level.var_679e1a9e) && level.var_679e1a9e)
	{
		level.var_679e1a9e = 0;
		if(!isdefined(level.var_bdc116e3) || level.var_bdc116e3 < 2)
		{
			level thread change_difficulty("normal");
			player thread namespace_97ac1184::function_b3489bf5("^3" + player.playername + "^7 turned off ^9Rage Inducer");
		}
	}
	else
	{
		level.var_679e1a9e = 1;
		if(!isdefined(level.var_bdc116e3) || level.var_bdc116e3 < 2)
		{
			level thread change_difficulty("hard");
			player thread namespace_97ac1184::function_b3489bf5("^3" + player.playername + "^7 turned on ^9Rage Inducer");
		}
	}
	player.pers["deploy_rage_inducer"]++;
	player thread namespace_97ac1184::function_1d39abf6("end_game_deploy_rage_inducer", 1, 0);
	player thread namespace_97ac1184::function_7e18304e("spx_save_data", "deploy_rage_inducer", player.pers["deploy_rage_inducer"], 0);
	self.var_40b69c4c setmodel("zmu_skull_hologram_disabled");
	wait(10);
	if(player.var_beea7f3e[self.var_54735102] == "rageinducer")
	{
		self.var_40b69c4c setmodel("zmu_skull_hologram");
	}
	self.var_e42e02e3 = 0;
}

/*
	Name: change_difficulty
	Namespace: namespace_a74e4f35
	Checksum: 0x424F4353
	Offset: 0x6060
	Size: 0x4F0
	Parameters: 1
	Flags: None
	Line Number: 1456
*/
function change_difficulty(difficulty)
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
		level.zombie_actor_limit = 40 + 4 * getplayers().size;
		level.zombie_ai_limit = 40 + 4 * getplayers().size;
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
		level.zombie_vars["zombie_move_speed_multiplier"] = 80;
		level.zombie_actor_limit = 48 + 4 * getplayers().size;
		level.zombie_ai_limit = 48 + 4 * getplayers().size;
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
	Name: function_b787d79
	Namespace: namespace_a74e4f35
	Checksum: 0x424F4353
	Offset: 0x6558
	Size: 0x398
	Parameters: 1
	Flags: None
	Line Number: 1519
*/
function function_b787d79(player)
{
	current_weapon = player getcurrentweapon();
	current_weapon = zm_weapons::get_nonalternate_weapon(current_weapon);
	current_weapon function_249f1eeb(player);
	player.var_397c0fc5 = function_9b879eb3(player, current_weapon);
	if(self.stub.related_parent.owner === player)
	{
		if(isdefined(player function_9bcac1e6(current_weapon)) && player function_9bcac1e6(current_weapon))
		{
			if(!player hasperk("specialty_extraammo") && current_weapon.var_e5532822 < current_weapon.var_ec2ed08e || (player hasperk("specialty_extraammo") && current_weapon.var_e5532822 < current_weapon.var_8c142720))
			{
				self.hint_string = &"ZM_MINECRAFT_AMMO_CRATE_WEAPON_AMMO_BUY_OWNER";
				self.hint_parm1 = player.var_397c0fc5;
				return 1;
			}
			else if(!(isdefined(player function_9bcac1e6(current_weapon)) && player function_9bcac1e6(current_weapon)))
			{
				self.hint_string = "";
				self.hint_parm1 = undefined;
				return 0;
			}
			else
			{
				self.hint_string = &"ZM_MINECRAFT_AMMO_CRATE_WEAPON_FULL_OWNER";
				self.hint_parm1 = undefined;
				return 0;
			}
		}
	}
	else if(isdefined(player function_9bcac1e6(current_weapon)) && player function_9bcac1e6(current_weapon))
	{
		if(!player hasperk("specialty_extraammo") && current_weapon.var_e5532822 < current_weapon.var_ec2ed08e || (player hasperk("specialty_extraammo") && current_weapon.var_e5532822 < current_weapon.var_8c142720))
		{
			self.hint_string = &"ZM_MINECRAFT_AMMO_CRATE_WEAPON_AMMO_BUY";
			self.hint_parm1 = player.var_397c0fc5;
			return 1;
		}
		else if(!(isdefined(player function_9bcac1e6(current_weapon)) && player function_9bcac1e6(current_weapon)))
		{
			self.hint_string = "";
			self.hint_parm1 = undefined;
			return 0;
		}
		else
		{
			self.hint_string = &"ZM_MINECRAFT_AMMO_CRATE_WEAPON_FULL";
			self.hint_parm1 = undefined;
			return 0;
		}
	}
}

/*
	Name: function_1de4829
	Namespace: namespace_a74e4f35
	Checksum: 0x424F4353
	Offset: 0x68F8
	Size: 0x470
	Parameters: 1
	Flags: None
	Line Number: 1582
*/
function function_1de4829(player)
{
	current_weapon = player getcurrentweapon();
	if(current_weapon.name != "")
	{
		current_weapon = player zm_weapons::switch_from_alt_weapon(current_weapon);
	}
	var_e5532822 = player getweaponammostock(current_weapon);
	current_weapon function_249f1eeb(player);
	if(current_weapon.isRiotShield && (current_weapon == level.zombie_powerup_weapon["minigun"] || zm_utility::is_hero_weapon(current_weapon) || current_weapon.name == "none" || current_weapon.name == "zombie_bgb_grab" || current_weapon.name == "zombie_bgb_use" || current_weapon.name == "zombie_beast_grapple_dwr" || current_weapon.name == "staff_revive" || current_weapon.clipsize <= 0))
	{
		return;
	}
	if(!player zm_score::can_player_purchase(player.var_397c0fc5) || (!player hasperk("specialty_extraammo") && current_weapon.var_e5532822 >= current_weapon.var_ec2ed08e) || (player hasperk("specialty_extraammo") && current_weapon.var_e5532822 >= current_weapon.var_8c142720))
	{
		zm_utility::play_sound_at_pos("no_purchase", player.origin);
		player zm_audio::create_and_play_dialog("general", "outofmoney");
		return;
	}
	if(player zm_score::can_player_purchase(player.var_397c0fc5))
	{
		self.owner.var_1bfcbff5 = self.owner.var_1bfcbff5 + 15;
		player zm_score::minus_to_player_score(player.var_397c0fc5);
		zm_utility::play_sound_at_pos("purchase", player.origin);
		player zm_audio::create_and_play_dialog("general", "generic_wall_buy");
		current_weapon = player getcurrentweapon();
		player setweaponammoclip(current_weapon, current_weapon.clipsize);
		if(player hasperk("specialty_extraammo"))
		{
			player setweaponammostock(current_weapon, current_weapon.maxAmmo);
		}
		else
		{
			player setweaponammostock(current_weapon, current_weapon.startammo);
		}
		player.pers["deploy_ammo_buy"]++;
		player thread namespace_97ac1184::function_1d39abf6("end_game_deploy_ammo_buy", 1, 0);
		player thread namespace_97ac1184::function_7e18304e("spx_save_data", "deploy_ammo_buy", player.pers["deploy_ammo_buy"], 0);
		return;
	}
}

/*
	Name: function_2fc45e69
	Namespace: namespace_a74e4f35
	Checksum: 0x424F4353
	Offset: 0x6D70
	Size: 0x90
	Parameters: 2
	Flags: None
	Line Number: 1634
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
		var_ec3f8524 = randomintrange(var_df20f103, var_620c330d);
		self rotateyaw(360, var_ec3f8524);
		wait(var_ec3f8524);
	}
}

/*
	Name: function_5e0c32c8
	Namespace: namespace_a74e4f35
	Checksum: 0x424F4353
	Offset: 0x6E08
	Size: 0x18
	Parameters: 0
	Flags: None
	Line Number: 1662
*/
function function_5e0c32c8()
{
	wait(20);
	self notify("time_out_check");
	return;
}

/*
	Name: function_549fbbec
	Namespace: namespace_a74e4f35
	Checksum: 0x424F4353
	Offset: 0x6E28
	Size: 0x270
	Parameters: 1
	Flags: None
	Line Number: 1679
*/
function function_549fbbec(var_60a2c1f7)
{
	self.owner util::waittill_any_timeout(var_60a2c1f7, "destroy_deployment_station", "disconnect");
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
		self.var_efe0cd4e delete();
	}
	self stoploopsound(0.5);
	self.var_54735102 = 0;
	if(isdefined(self.s_unitrigger))
	{
		zm_unitrigger::unregister_unitrigger(self.s_unitrigger);
	}
	if(isdefined(self.var_f7ad445d))
	{
		self.var_f7ad445d delete();
	}
	if(isdefined(self.var_9186076d))
	{
		self.var_9186076d delete();
	}
	if(isdefined(self.var_40b69c4c))
	{
		self.var_40b69c4c delete();
	}
	self.var_9186076d = util::spawn_model("tag_origin", self.origin, self.angles);
	self.var_9186076d = playfxontag(level._effect["deployment_station_break"], self.var_9186076d, "tag_origin");
	playsoundatposition("deployment_station_break", self.origin);
	wait(1);
	playsoundatposition("deployment_station_break_explode", self.origin);
	if(isdefined(self.var_9186076d))
	{
		self.var_9186076d delete();
	}
	self delete();
}

/*
	Name: function_249f1eeb
	Namespace: namespace_a74e4f35
	Checksum: 0x424F4353
	Offset: 0x70A0
	Size: 0x90
	Parameters: 1
	Flags: Private
	Line Number: 1734
*/
function private function_249f1eeb(player)
{
	self.var_e5532822 = player getweaponammostock(self);
	self.var_8c142720 = self.maxAmmo;
	self.var_ec2ed08e = self.startammo;
	if(isdefined(self.dualWieldWeapon) && self.dualWieldWeapon != level.weaponnone)
	{
		self.var_ec2ed08e = self.var_ec2ed08e - self.dualWieldWeapon.clipsize;
		return;
	}
	ERROR: Bad function call
}

/*
	Name: function_9bcac1e6
	Namespace: namespace_a74e4f35
	Checksum: 0x424F4353
	Offset: 0x7138
	Size: 0x110
	Parameters: 1
	Flags: Private
	Line Number: 1757
*/
function private function_9bcac1e6(current_weapon)
{
	if(self laststand::player_is_in_laststand() || (isdefined(self.intermission) && self.intermission) || self IsThrowingGrenade())
	{
		return 0;
	}
	if(!zm_utility::is_player_valid(self) || self.is_drinking > 0 || zm_utility::is_placeable_mine(current_weapon) || zm_equipment::is_equipment(current_weapon) || self zm_utility::is_player_revive_tool(current_weapon) || level.weaponnone == current_weapon || self zm_equipment::hacker_active() || zm_utility::is_hero_weapon(current_weapon))
	{
		return 0;
	}
	return 1;
	ERROR: Exception occured: Stack empty.
}

/*
	Name: function_9b879eb3
	Namespace: namespace_a74e4f35
	Checksum: 0x424F4353
	Offset: 0x7250
	Size: 0x258
	Parameters: 2
	Flags: Private
	Line Number: 1781
*/
function private function_9b879eb3(player, current_weapon)
{
	var_7750a3aa = player namespace_5e1f56dc::function_1239e0ad(player getcurrentweapon());
	if(isdefined(var_7750a3aa) && var_7750a3aa.var_a39a2843 > 0)
	{
		if(isdefined(current_weapon.is_wonder_weapon) && current_weapon.is_wonder_weapon || array::contains(level.var_e33eb0d5, current_weapon.name))
		{
			var_e61884a5 = 12000;
			for(i = 1; i < var_7750a3aa.var_a39a2843; i++)
			{
				var_e61884a5 = var_e61884a5 * 1.1;
			}
		}
		else
		{
			var_e61884a5 = 1000;
			for(i = 1; i < var_7750a3aa.var_a39a2843; i++)
			{
				var_e61884a5 = var_e61884a5 * 1.2;
			}
		}
		var_e61884a5 = zm_utility::round_up_score(var_e61884a5, 100);
	}
	else
	{
		var_e61884a5 = 0;
	}
	if(isdefined(current_weapon.is_wonder_weapon) && current_weapon.is_wonder_weapon || array::contains(level.var_e33eb0d5, current_weapon.name))
	{
		if(zm_weapons::is_weapon_upgraded(current_weapon))
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
	Name: create_unitrigger
	Namespace: namespace_a74e4f35
	Checksum: 0x424F4353
	Offset: 0x74B0
	Size: 0x210
	Parameters: 5
	Flags: None
	Line Number: 1845
*/
function create_unitrigger(str_hint, n_radius, func_prompt_and_visibility, func_unitrigger_logic, s_trigger_type)
{
	if(!isdefined(n_radius))
	{
		n_radius = 48;
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
	self.s_unitrigger.origin = self.origin + VectorScale((0, 0, 1), 50);
	self.s_unitrigger.angles = self.angles + VectorScale((0, 0, 1), 50);
	self.s_unitrigger.script_unitrigger_type = "unitrigger_box_use";
	self.s_unitrigger.cursor_hint = "HINT_NOICON";
	self.s_unitrigger.hint_string = str_hint;
	self.s_unitrigger.script_width = 48;
	self.s_unitrigger.script_height = 48;
	self.s_unitrigger.script_length = 48;
	self.s_unitrigger.require_look_at = 1;
	self.s_unitrigger.related_parent = self;
	self.s_unitrigger.radius = n_radius;
	zm_unitrigger::unitrigger_force_per_player_triggers(self.s_unitrigger, 1);
	self.s_unitrigger.prompt_and_visibility_func = func_prompt_and_visibility;
	zm_unitrigger::register_static_unitrigger(self.s_unitrigger, func_unitrigger_logic);
	return;
	~self.s_unitrigger.prompt_and_visibility_func;
	ERROR: Exception occured: Stack empty.
}

/*
	Name: unitrigger_logic
	Namespace: namespace_a74e4f35
	Checksum: 0x424F4353
	Offset: 0x76C8
	Size: 0xB8
	Parameters: 0
	Flags: None
	Line Number: 1893
*/
function unitrigger_logic()
{
	self endon("death");
	self endon("kill_trigger");
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
	Name: get_weighted_random_perk
	Namespace: namespace_a74e4f35
	Checksum: 0x424F4353
	Offset: 0x7788
	Size: 0xC8
	Parameters: 1
	Flags: None
	Line Number: 1926
*/
function get_weighted_random_perk(player)
{
	keys = array::randomize(getarraykeys(level._random_perk_machine_perk_list));
	for(i = 0; i < keys.size; i++)
	{
		if(player hasperk(level._random_perk_machine_perk_list[keys[i]]))
		{
			continue;
			continue;
		}
		return level._random_perk_machine_perk_list[keys[i]];
	}
	return level._random_perk_machine_perk_list[keys[0]];
}

/*
	Name: start_perk_bottle_cycling
	Namespace: namespace_a74e4f35
	Checksum: 0x424F4353
	Offset: 0x7858
	Size: 0x138
	Parameters: 0
	Flags: None
	Line Number: 1951
*/
function start_perk_bottle_cycling()
{
	self endon("done_cycling");
	array_key = getarraykeys(level.perk_bottle_weapon_array);
	timer = 0;
	while(1)
	{
		for(i = 0; i < array_key.size; i++)
		{
			if(isdefined(level.perk_bottle_weapon_array[array_key[i]].weapon))
			{
				model = GetWeaponModel(level.perk_bottle_weapon_array[array_key[i]].weapon);
			}
			else
			{
				model = GetWeaponModel(level.perk_bottle_weapon_array[array_key[i]].perk_bottle_weapon);
			}
			self.var_40b69c4c setmodel(model);
			wait(0.2);
		}
	}
	return;
}

/*
	Name: get_perk_weapon_model
	Namespace: namespace_a74e4f35
	Checksum: 0x424F4353
	Offset: 0x7998
	Size: 0x98
	Parameters: 1
	Flags: None
	Line Number: 1985
*/
function get_perk_weapon_model(perk)
{
	weapon = level.machine_assets[perk].weapon;
	if(isdefined(level._custom_perks[perk]) && isdefined(level._custom_perks[perk].perk_bottle_weapon))
	{
		weapon = level._custom_perks[perk].perk_bottle_weapon;
	}
	return GetWeaponModel(weapon);
}

/*
	Name: GetWeaponModel
	Namespace: namespace_a74e4f35
	Checksum: 0x424F4353
	Offset: 0x7A38
	Size: 0x20
	Parameters: 1
	Flags: None
	Line Number: 2005
*/
function GetWeaponModel(weapon)
{
	return weapon.worldmodel;
}

/*
	Name: perk_bottle_motion
	Namespace: namespace_a74e4f35
	Checksum: 0x424F4353
	Offset: 0x7A60
	Size: 0x168
	Parameters: 0
	Flags: None
	Line Number: 2020
*/
function perk_bottle_motion()
{
	putOutTime = 3;
	putBackTime = 10;
	v_float = anglestoforward(self.angles - (0, 90, 0)) * 10;
	self.var_40b69c4c.origin = self.origin + (0, 0, 40);
	self.var_40b69c4c.angles = self.angles;
	self.var_40b69c4c.angles = self.var_40b69c4c.angles + (0, 0, 10);
	self.var_40b69c4c rotateyaw(720, putOutTime, putOutTime * 0.5);
	self waittill("done_cycling");
	self.var_40b69c4c.angles = self.angles;
	self.var_40b69c4c rotateyaw(90, putBackTime, putBackTime * 0.5);
	return;
	ERROR: Exception occured: Stack empty.
}

/*
	Name: grab_check
	Namespace: namespace_a74e4f35
	Checksum: 0x424F4353
	Offset: 0x7BD0
	Size: 0x218
	Parameters: 2
	Flags: None
	Line Number: 2046
*/
function grab_check(player, random_perk)
{
	self endon("time_out_check");
	perk_is_bought = 0;
	while(!perk_is_bought)
	{
		self waittill("trigger_activated", e_triggerer);
		if(e_triggerer == player)
		{
			if(isdefined(player.is_drinking) && player.is_drinking > 0)
			{
				wait(0.1);
				continue;
			}
			if(player zm_utility::can_player_purchase_perk())
			{
				perk_is_bought = 1;
			}
			else
			{
				self playsound("evt_perk_deny");
				player zm_audio::create_and_play_dialog("general", "sigh");
				self notify("time_out_or_perk_grab");
				return;
			}
		}
	}
	player thread monitor_when_player_acquires_perk();
	self notify("grab_check");
	self notify("time_out_or_perk_grab");
	player notify("perk_purchased", random_perk);
	gun = player zm_perks::perk_give_bottle_begin(random_perk);
	evt = player util::waittill_any_ex("fake_death", "death", "player_downed", "weapon_change_complete", self, "time_out_check");
	if(evt == "weapon_change_complete")
	{
		player thread zm_perks::wait_give_perk(random_perk, 1);
	}
	player zm_perks::perk_give_bottle_end(gun, random_perk);
}

/*
	Name: monitor_when_player_acquires_perk
	Namespace: namespace_a74e4f35
	Checksum: 0x424F4353
	Offset: 0x7DF0
	Size: 0x60
	Parameters: 0
	Flags: None
	Line Number: 2096
*/
function monitor_when_player_acquires_perk()
{
	self util::waittill_any("perk_acquired", "death_or_disconnect", "player_downed", "forced_deployment_closure");
	self flag::set("deployment_machine_can_reset");
}

/*
	Name: time_out_check
	Namespace: namespace_a74e4f35
	Checksum: 0x424F4353
	Offset: 0x7E58
	Size: 0x48
	Parameters: 1
	Flags: None
	Line Number: 2112
*/
function time_out_check(player)
{
	self endon("grab_check");
	wait(10);
	self notify("time_out_check");
	player flag::set("deployment_machine_can_reset");
}

/*
	Name: can_buy_perk
	Namespace: namespace_a74e4f35
	Checksum: 0x424F4353
	Offset: 0x7EA8
	Size: 0xA8
	Parameters: 0
	Flags: None
	Line Number: 2130
*/
function can_buy_perk()
{
	if(isdefined(self.is_drinking) && self.is_drinking > 0)
	{
		return 0;
	}
	current_weapon = self getcurrentweapon();
	if(zm_utility::is_placeable_mine(current_weapon) || zm_equipment::is_equipment_that_blocks_purchase(current_weapon))
	{
		return 0;
	}
	if(self zm_utility::in_revive_trigger())
	{
		return 0;
	}
	if(current_weapon == level.weaponnone)
	{
		return 0;
	}
	return 1;
}

/*
	Name: trigger_visible_to_player
	Namespace: namespace_a74e4f35
	Checksum: 0x424F4353
	Offset: 0x7F58
	Size: 0x108
	Parameters: 1
	Flags: None
	Line Number: 2162
*/
function trigger_visible_to_player(player)
{
	self setinvisibletoplayer(player);
	visible = 1;
	if(isdefined(self.stub.trigger_target.machine_user))
	{
		if(player != self.stub.trigger_target.machine_user || zm_utility::is_placeable_mine(self.stub.trigger_target.machine_user getcurrentweapon()))
		{
			visible = 0;
		}
	}
	else if(!player can_buy_perk())
	{
		visible = 0;
	}
	if(!visible)
	{
		return 0;
	}
	self setvisibletoplayer(player);
	return 1;
}

/*
	Name: player_has_all_available_perks
	Namespace: namespace_a74e4f35
	Checksum: 0x424F4353
	Offset: 0x8068
	Size: 0x58
	Parameters: 0
	Flags: None
	Line Number: 2195
*/
function player_has_all_available_perks()
{
	for(i = 0; i < level._custom_perks.size; i++)
	{
		if(!self hasperk(level._custom_perks[i]))
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
	Offset: 0x80C8
	Size: 0xD80
	Parameters: 0
	Flags: None
	Line Number: 2217
*/
function function_b8bbdc71()
{
	foreach(player in getplayers())
	{
		while(player.var_84298650.size > 0)
		{
			wait(0.1);
		}
	}
	zm::check_end_game_intermission_delay();
	setmatchflag("game_ended", 1);
	level clientfield::set("gameplay_started", 0);
	level clientfield::set("game_end_time", int(GetTime() - level.n_gameplay_start_time + 500 / 1000));
	util::clientnotify("zesn");
	level thread zm_audio::sndmusicsystem_playstate("game_over");
	players = getplayers();
	for(i = 0; i < players.size; i++)
	{
		players[i] clientfield::set("zmbLastStand", 0);
	}
	for(i = 0; i < players.size; i++)
	{
		if(players[i] laststand::player_is_in_laststand())
		{
			players[i] RecordPlayerDeathZombies();
			players[i] zm_stats::increment_player_stat("deaths");
			players[i] zm_stats::increment_client_stat("deaths");
		}
		if(isdefined(players[i].reviveTextHud))
		{
			players[i].reviveTextHud destroy();
		}
	}
	StopAllRumbles();
	level.intermission = 1;
	level.zombie_vars["zombie_powerup_insta_kill_time"] = 0;
	level.zombie_vars["zombie_powerup_fire_sale_time"] = 0;
	level.zombie_vars["zombie_powerup_double_points_time"] = 0;
	wait(0.1);
	game_over = [];
	survived = [];
	players = getplayers();
	setmatchflag("disableIngameMenu", 1);
	foreach(player in players)
	{
		player closeInGameMenu();
		player CloseMenu("StartMenu_Main");
	}
	foreach(player in players)
	{
		player setdstat("AfterActionReportStats", "lobbyPopup", "summary");
	}
	if(!isdefined(level._supress_survived_screen))
	{
		for(i = 0; i < players.size; i++)
		{
			game_over[i] = newclienthudelem(players[i]);
			survived[i] = newclienthudelem(players[i]);
			if(isdefined(level.custom_game_over_hud_elem))
			{
				[[level.custom_game_over_hud_elem]](players[i], game_over[i], survived[i]);
			}
			else
			{
				game_over[i].alignx = "center";
				game_over[i].aligny = "middle";
				game_over[i].horzalign = "center";
				game_over[i].vertalign = "middle";
				game_over[i].y = game_over[i].y - 180;
				game_over[i].foreground = 1;
				game_over[i].fontscale = 3;
				game_over[i].alpha = 0;
				game_over[i].color = (1, 1, 1);
				game_over[i].hidewheninmenu = 1;
				game_over[i] settext(level.var_9b1ad299);
				game_over[i] fadeovertime(1);
				game_over[i].alpha = 1;
				if(players[i] issplitscreen())
				{
					game_over[i].fontscale = 2;
					game_over[i].y = game_over[i].y + 40;
				}
				survived[i].alignx = "center";
				survived[i].aligny = "middle";
				survived[i].horzalign = "center";
				survived[i].vertalign = "middle";
				survived[i].y = survived[i].y - 150;
				survived[i].foreground = 1;
				survived[i].fontscale = 2;
				survived[i].alpha = 0;
				survived[i].color = (1, 1, 1);
				survived[i].hidewheninmenu = 1;
				if(players[i] issplitscreen())
				{
					survived[i].fontscale = 1.5;
					survived[i].y = survived[i].y + 40;
				}
			}
			if(level.round_number < 2)
			{
				survived[i] settext(&"ZOMBIE_SURVIVED_ROUND");
			}
			else
			{
				survived[i] settext(&"ZOMBIE_SURVIVED_ROUNDS", level.round_number);
			}
			survived[i] fadeovertime(1);
			survived[i].alpha = 1;
		}
	}
	else if(isdefined(level.custom_end_screen))
	{
		level [[level.custom_end_screen]]();
	}
	for(i = 0; i < players.size; i++)
	{
		players[i] setclientuivisibilityflag("weapon_hud_visible", 0);
		players[i] SetClientMiniScoreboardHide(1);
		players[i] notify("report_bgb_consumption");
	}
	uploadstats();
	zm_stats::update_players_stats_at_match_end(players);
	zm_stats::update_global_counters_on_match_end();
	zm::upload_leaderboards();
	recordGameResult("draw");
	finalizeMatchRecord();
	players = getplayers();
	foreach(player in players)
	{
		if(isdefined(player.sessionstate) && player.sessionstate == "spectator")
		{
			player.sessionstate = "playing";
			player thread zm::end_game_player_was_spectator();
		}
	}
	wait(0.05);
	players = getplayers();
	luinotifyevent(&"force_scoreboard", 1, 1);
	zm::intermission();
	wait(level.zombie_vars["zombie_intermission_time"]);
	if(!isdefined(level._supress_survived_screen))
	{
		for(i = 0; i < players.size; i++)
		{
			survived[i] destroy();
			game_over[i] destroy();
		}
	}
	else
	{
		for(i = 0; i < players.size; i++)
		{
			if(isdefined(players[i].survived_hud))
			{
				players[i].survived_hud destroy();
			}
			if(isdefined(players[i].game_over_hud))
			{
				players[i].game_over_hud destroy();
			}
		}
	}
	level notify("stop_intermission");
	array::thread_all(getplayers(), &player_exit_level);
	wait(1.5);
	players = getplayers();
	for(i = 0; i < players.size; i++)
	{
		players[i] cameraactivate(0);
	}
	exitlevel(0);
	wait(666);
}

/*
	Name: player_exit_level
	Namespace: namespace_a74e4f35
	Checksum: 0x424F4353
	Offset: 0x8E50
	Size: 0x4C
	Parameters: 0
	Flags: None
	Line Number: 2401
*/
function player_exit_level()
{
	self AllowStand(1);
	self allowcrouch(0);
	self allowprone(0);
}

