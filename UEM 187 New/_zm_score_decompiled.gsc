#include scripts\codescripts\struct;
#include scripts\shared\callbacks_shared;
#include scripts\shared\clientfield_shared;
#include scripts\shared\flagsys_shared;
#include scripts\shared\scoreevents_shared;
#include scripts\shared\system_shared;
#include scripts\shared\util_shared;
#include scripts\zm\_zm_bgb;
#include scripts\zm\_zm_bgb_token;
#include scripts\zm\_zm_pers_upgrades_functions;
#include scripts\zm\_zm_stats;
#include scripts\zm\_zm_utility;

#namespace zm_score;

/*
	Name: __init__sytem__
	Namespace: zm_score
	Checksum: 0x424F4353
	Offset: 0x700
	Size: 0x38
	Parameters: 0
	Flags: AutoExec
	Line Number: 25
*/
function autoexec __init__sytem__()
{
	system::register("zm_score", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: zm_score
	Checksum: 0x424F4353
	Offset: 0x740
	Size: 0x1F0
	Parameters: 0
	Flags: None
	Line Number: 40
*/
function __init__()
{
	score_cf_register_info("damage", 1, 7);
	score_cf_register_info("death_normal", 1, 3);
	score_cf_register_info("death_torso", 1, 3);
	score_cf_register_info("death_neck", 1, 3);
	score_cf_register_info("death_head", 1, 3);
	score_cf_register_info("death_melee", 1, 3);
	clientfield::register("clientuimodel", "hudItems.doublePointsActive", 1, 1, "int");
	clientfield::register("clientuimodel", "hudItems.showDpadUp", 1, 1, "int");
	clientfield::register("clientuimodel", "hudItems.showDpadDown", 1, 1, "int");
	clientfield::register("clientuimodel", "hudItems.showDpadLeft", 1, 1, "int");
	clientfield::register("clientuimodel", "hudItems.showDpadRight", 1, 1, "int");
	callback::on_spawned(&player_on_spawned);
	level.score_total = 0;
	level.a_func_score_events = [];
}

/*
	Name: register_score_event
	Namespace: zm_score
	Checksum: 0x424F4353
	Offset: 0x938
	Size: 0x28
	Parameters: 2
	Flags: None
	Line Number: 68
*/
function register_score_event(str_event, func_callback)
{
	level.a_func_score_events[str_event] = func_callback;
}

/*
	Name: reset_doublexp_timer
	Namespace: zm_score
	Checksum: 0x424F4353
	Offset: 0x968
	Size: 0x28
	Parameters: 0
	Flags: None
	Line Number: 83
*/
function reset_doublexp_timer()
{
	self notify("reset_doublexp_timer");
	self thread doublexp_timer();
}

/*
	Name: doublexp_timer
	Namespace: zm_score
	Checksum: 0x424F4353
	Offset: 0x998
	Size: 0xB0
	Parameters: 0
	Flags: None
	Line Number: 99
*/
function doublexp_timer()
{
	self notify("doublexp_timer");
	self endon("doublexp_timer");
	self endon("reset_doublexp_timer");
	self endon("end_game");
	level flagsys::wait_till("start_zombie_round_logic");
	if(!level.onlineGame)
	{
		return;
	}
	wait(60);
	if(level.onlineGame)
	{
		if(!isdefined(self))
		{
			return;
		}
		self DoubleXPTimerFired();
	}
	self thread reset_doublexp_timer();
}

/*
	Name: player_on_spawned
	Namespace: zm_score
	Checksum: 0x424F4353
	Offset: 0xA50
	Size: 0x40
	Parameters: 0
	Flags: None
	Line Number: 132
*/
function player_on_spawned()
{
	util::wait_network_frame();
	self thread doublexp_timer();
	if(isdefined(self))
	{
		self.ready_for_score_events = 1;
	}
}

/*
	Name: score_cf_register_info
	Namespace: zm_score
	Checksum: 0x424F4353
	Offset: 0xA98
	Size: 0xA0
	Parameters: 3
	Flags: None
	Line Number: 152
*/
function score_cf_register_info(name, version, max_count)
{
	for(i = 0; i < 4; i++)
	{
		clientfield::register("clientuimodel", "PlayerList.client" + i + ".score_cf_" + name, version, GetMinBitCountForNum(max_count), "counter");
	}
}

/*
	Name: score_cf_increment_info
	Namespace: zm_score
	Checksum: 0x424F4353
	Offset: 0xB40
	Size: 0xB8
	Parameters: 1
	Flags: None
	Line Number: 170
*/
function score_cf_increment_info(name)
{
	foreach(player in level.players)
	{
		thread wait_score_cf_increment_info(player, "PlayerList.client" + self.entity_num + ".score_cf_" + name);
	}
	return;
	ERROR: Bad function call
}

/*
	Name: wait_score_cf_increment_info
	Namespace: zm_score
	Checksum: 0x424F4353
	Offset: 0xC00
	Size: 0x60
	Parameters: 2
	Flags: None
	Line Number: 190
*/
function wait_score_cf_increment_info(player, cf)
{
	if(isdefined(player) && (isdefined(player.ready_for_score_events) && player.ready_for_score_events))
	{
		player clientfield::increment_uimodel(cf);
	}
}

/*
	Name: player_add_points
	Namespace: zm_score
	Checksum: 0x424F4353
	Offset: 0xC68
	Size: 0x890
	Parameters: 6
	Flags: None
	Line Number: 208
*/
function player_add_points(event, mod, hit_location, is_dog, zombie_team, damage_weapon)
{
	if(level.intermission)
	{
		return;
	}
	if(!zm_utility::is_player_valid(self))
	{
		return;
	}
	player_points = 0;
	team_points = 0;
	multiplier = get_points_multiplier(self);
	if(isdefined(level.a_func_score_events[event]))
	{
		player_points = [[level.a_func_score_events[event]]](event, mod, hit_location, zombie_team, damage_weapon);
	}
	else
	{
		switch(event)
		{
			case "death_raps":
			case "death_wasp":
			{
				player_points = mod;
				scoreevents::processscoreevent("kill", self, undefined, damage_weapon);
				break;
			}
			case "death_spider":
			{
				player_points = get_zombie_death_player_points();
				team_points = get_zombie_death_team_points();
				scoreevents::processscoreevent("kill_spider", self, undefined, damage_weapon);
				break;
			}
			case "death_thrasher":
			{
				player_points = get_zombie_death_player_points();
				team_points = get_zombie_death_team_points();
				points = self player_add_points_kill_bonus(mod, hit_location, damage_weapon);
				if(level.zombie_vars[self.team]["zombie_powerup_insta_kill_on"] == 1 && mod == "MOD_UNKNOWN")
				{
					points = points * 2;
				}
				player_points = player_points + points;
				player_points = player_points * 2;
				if(team_points > 0)
				{
					team_points = team_points + points;
				}
				if(mod == "MOD_GRENADE" || mod == "MOD_GRENADE_SPLASH")
				{
					self zm_stats::increment_client_stat("grenade_kills");
					self zm_stats::increment_player_stat("grenade_kills");
				}
				scoreevents::processscoreevent("kill_thrasher", self, undefined, damage_weapon);
				break;
			}
			case "death":
			{
				player_points = get_zombie_death_player_points();
				team_points = get_zombie_death_team_points();
				points = self player_add_points_kill_bonus(mod, hit_location, damage_weapon, player_points);
				if(level.zombie_vars[self.team]["zombie_powerup_insta_kill_on"] == 1 && mod == "MOD_UNKNOWN")
				{
					points = points * 2;
				}
				player_points = player_points + points;
				if(team_points > 0)
				{
					team_points = team_points + points;
				}
				if(mod == "MOD_GRENADE" || mod == "MOD_GRENADE_SPLASH")
				{
					self zm_stats::increment_client_stat("grenade_kills");
					self zm_stats::increment_player_stat("grenade_kills");
					break;
				}
			}
			case "death_mechz":
			{
				player_points = mod;
				scoreevents::processscoreevent("kill_mechz", self, undefined, damage_weapon);
				break;
			}
			case "ballistic_knife_death":
			{
				player_points = get_zombie_death_player_points() + level.zombie_vars["zombie_score_bonus_melee"];
				self score_cf_increment_info("death_melee");
				break;
			}
			case "damage_light":
			{
				player_points = level.zombie_vars["zombie_score_damage_light"];
				self score_cf_increment_info("damage");
				break;
			}
			case "damage":
			{
				player_points = level.zombie_vars["zombie_score_damage_normal"];
				self score_cf_increment_info("damage");
				break;
			}
			case "damage_ads":
			{
				player_points = int(level.zombie_vars["zombie_score_damage_normal"] * 1.25);
				self score_cf_increment_info("damage");
				break;
			}
			case "carpenter_powerup":
			case "rebuild_board":
			{
				player_points = mod;
				break;
			}
			case "bonus_points_powerup":
			{
				player_points = mod;
				break;
			}
			case "nuke_powerup":
			{
				player_points = mod;
				team_points = mod;
				break;
			}
			case "jetgun_fling":
			case "riotshield_fling":
			case "thundergun_fling":
			{
				player_points = mod;
				scoreevents::processscoreevent("kill", self, undefined, damage_weapon);
				break;
			}
			case "hacker_transfer":
			{
				player_points = mod;
				break;
			}
			case "reviver":
			{
				player_points = mod;
				break;
			}
			case "vulture":
			{
				player_points = mod;
				break;
			}
			case "build_wallbuy":
			{
				player_points = mod;
				break;
			}
			case "ww_webbed":
			{
				player_points = mod;
				break;
			}
			default
			{
				/#
					Assert(0, "Dev Block strings are not supported");
					break;
				#/
			}
		}
	}
	if(isdefined(level.player_score_override))
	{
		player_points = self [[level.player_score_override]](damage_weapon, player_points);
	}
	if(isdefined(level.team_score_override))
	{
		team_points = self [[level.team_score_override]](damage_weapon, team_points);
	}
	player_points = multiplier * zm_utility::round_up_score(player_points, 10);
	team_points = multiplier * zm_utility::round_up_score(team_points, 10);
	if(isdefined(self.point_split_receiver) && (event == "death" || event == "ballistic_knife_death"))
	{
		split_player_points = player_points - zm_utility::round_up_score(player_points * self.point_split_keep_percent, 10);
		self.point_split_receiver add_to_player_score(split_player_points);
		player_points = player_points - split_player_points;
	}
	if(isdefined(level.pers_upgrade_pistol_points) && level.pers_upgrade_pistol_points)
	{
		player_points = self zm_pers_upgrades_functions::pers_upgrade_pistol_points_set_score(player_points, event, mod, damage_weapon);
	}
	self add_to_player_score(player_points, 1, event);
	self.pers["score"] = self.score;
	if(isdefined(level._game_module_point_adjustment))
	{
		level [[level._game_module_point_adjustment]](self, zombie_team, player_points);
	}
}

/*
	Name: get_points_multiplier
	Namespace: zm_score
	Checksum: 0x424F4353
	Offset: 0x1500
	Size: 0x178
	Parameters: 1
	Flags: None
	Line Number: 414
*/
function get_points_multiplier(player)
{
	multiplier = level.zombie_vars[player.team]["zombie_point_scalar"];
	if(isdefined(level.current_game_module) && level.current_game_module == 2)
	{
		if(isdefined(level._race_team_double_points) && level._race_team_double_points == player._race_team)
		{
			return multiplier;
		}
		else
		{
			return 1;
		}
	}
	if(isdefined(player.var_fa202141["player_playerdifficulty"]) && player.var_fa202141["player_playerdifficulty"] > 0 && (!(isdefined(level.var_e0a14cc9) && level.var_e0a14cc9)))
	{
		if(player.var_fa202141["player_playerdifficulty"] > 50 && (isdefined(self.var_fa202141["player_brutalcap"]) && self.var_fa202141["player_brutalcap"] == 0))
		{
			multiplier = 0.9 - 0.3;
		}
		else
		{
			multiplier = 0.9 - player.var_fa202141["player_playerdifficulty"] * 0.006;
		}
	}
	return multiplier;
}

/*
	Name: get_zombie_death_player_points
	Namespace: zm_score
	Checksum: 0x424F4353
	Offset: 0x1680
	Size: 0xC8
	Parameters: 0
	Flags: None
	Line Number: 452
*/
function get_zombie_death_player_points()
{
	players = getplayers();
	if(players.size == 1)
	{
		points = level.zombie_vars["zombie_score_kill_1player"];
	}
	else if(players.size == 2)
	{
		points = level.zombie_vars["zombie_score_kill_2player"];
	}
	else if(players.size == 3)
	{
		points = level.zombie_vars["zombie_score_kill_3player"];
	}
	else
	{
		points = level.zombie_vars["zombie_score_kill_4player"];
	}
	return points;
}

/*
	Name: get_zombie_death_team_points
	Namespace: zm_score
	Checksum: 0x424F4353
	Offset: 0x1750
	Size: 0x8
	Parameters: 0
	Flags: None
	Line Number: 484
*/
function get_zombie_death_team_points()
{
	return 0;
}

/*
	Name: player_add_points_kill_bonus
	Namespace: zm_score
	Checksum: 0x424F4353
	Offset: 0x1760
	Size: 0x2D0
	Parameters: 4
	Flags: None
	Line Number: 499
*/
function player_add_points_kill_bonus(mod, hit_location, weapon, player_points)
{
	if(!isdefined(player_points))
	{
		player_points = undefined;
	}
	if(mod != "MOD_MELEE")
	{
		if("head" == hit_location || "helmet" == hit_location)
		{
			scoreevents::processscoreevent("headshot", self, undefined, weapon);
		}
		else
		{
			scoreevents::processscoreevent("kill", self, undefined, weapon);
		}
	}
	if(isdefined(level.player_score_override))
	{
		new_points = self [[level.player_score_override]](weapon, player_points);
		if(new_points > 0 && new_points != player_points)
		{
			return 0;
		}
	}
	if(mod == "MOD_MELEE")
	{
		self score_cf_increment_info("death_melee");
		scoreevents::processscoreevent("melee_kill", self, undefined, weapon);
		return level.zombie_vars["zombie_score_bonus_melee"];
	}
	if(mod == "MOD_BURNED")
	{
		self score_cf_increment_info("death_torso");
		return level.zombie_vars["zombie_score_bonus_burn"];
	}
	score = 0;
	if(isdefined(hit_location))
	{
		switch(hit_location)
		{
			case "head":
			case "helmet":
			{
				self score_cf_increment_info("death_head");
				score = level.zombie_vars["zombie_score_bonus_head"];
				break;
			}
			case "neck":
			{
				self score_cf_increment_info("death_neck");
				score = level.zombie_vars["zombie_score_bonus_neck"];
				break;
			}
			case "torso_lower":
			case "torso_upper":
			{
				self score_cf_increment_info("death_torso");
				score = level.zombie_vars["zombie_score_bonus_torso"];
				break;
			}
			default
			{
				self score_cf_increment_info("death_normal");
				break;
			}
		}
	}
	return score;
}

/*
	Name: player_reduce_points
	Namespace: zm_score
	Checksum: 0x424F4353
	Offset: 0x1A38
	Size: 0x218
	Parameters: 2
	Flags: None
	Line Number: 580
*/
function player_reduce_points(event, n_amount)
{
	if(level.intermission)
	{
		return;
	}
	points = 0;
	switch(event)
	{
		case "take_all":
		{
			points = self.score;
			break;
		}
		case "take_half":
		{
			points = int(self.score / 2);
			break;
		}
		case "take_specified":
		{
			points = n_amount;
			break;
		}
		case "no_revive_penalty":
		{
			percent = level.zombie_vars["penalty_no_revive"];
			points = self.score * percent;
			break;
		}
		case "died":
		{
			percent = level.zombie_vars["penalty_died"];
			points = self.score * percent;
			break;
		}
		case "downed":
		{
			percent = level.zombie_vars["penalty_downed"];
			self notify("I_am_down");
			points = self.score * percent;
			self.score_lost_when_downed = zm_utility::round_up_to_ten(int(points));
			break;
		}
		default
		{
			/#
				Assert(0, "Dev Block strings are not supported");
				break;
			#/
		}
	}
	points = self.score - zm_utility::round_up_to_ten(int(points));
	if(points < 0)
	{
		points = 0;
	}
	self.score = points;
}

/*
	Name: add_to_player_score
	Namespace: zm_score
	Checksum: 0x424F4353
	Offset: 0x1C58
	Size: 0x140
	Parameters: 3
	Flags: None
	Line Number: 650
*/
function add_to_player_score(points, b_add_to_total, str_awarded_by)
{
	if(!isdefined(b_add_to_total))
	{
		b_add_to_total = 1;
	}
	if(!isdefined(str_awarded_by))
	{
		str_awarded_by = "";
	}
	if(!isdefined(points) || level.intermission)
	{
		return;
	}
	points = zm_utility::round_up_score(points, 10);
	n_points_to_add_to_currency = bgb::add_to_player_score_override(points, str_awarded_by);
	self.score = self.score + n_points_to_add_to_currency;
	self.pers["score"] = self.score;
	self IncrementPlayerStat("scoreEarned", n_points_to_add_to_currency);
	level notify("earned_points", self, points, str_awarded_by);
	if(b_add_to_total)
	{
		self.score_total = self.score_total + points;
		level.score_total = level.score_total + points;
	}
}

/*
	Name: minus_to_player_score
	Namespace: zm_score
	Checksum: 0x424F4353
	Offset: 0x1DA0
	Size: 0xE0
	Parameters: 1
	Flags: None
	Line Number: 687
*/
function minus_to_player_score(points)
{
	if(!isdefined(points) || level.intermission)
	{
		return;
	}
	if(self bgb::is_enabled("zm_bgb_shopping_free"))
	{
		self bgb::do_one_shot_use();
		self playsoundtoplayer("zmb_bgb_shoppingfree_coinreturn", self);
		return;
	}
	self.score = self.score - points;
	self.pers["score"] = self.score;
	self IncrementPlayerStat("scoreSpent", points);
	level notify("spent_points", self, points);
}

/*
	Name: add_to_team_score
	Namespace: zm_score
	Checksum: 0x424F4353
	Offset: 0x1E88
	Size: 0x10
	Parameters: 1
	Flags: None
	Line Number: 715
*/
function add_to_team_score(points)
{
}

/*
	Name: minus_to_team_score
	Namespace: zm_score
	Checksum: 0x424F4353
	Offset: 0x1EA0
	Size: 0x10
	Parameters: 1
	Flags: None
	Line Number: 729
*/
function minus_to_team_score(points)
{
}

/*
	Name: player_died_penalty
	Namespace: zm_score
	Checksum: 0x424F4353
	Offset: 0x1EB8
	Size: 0xA8
	Parameters: 0
	Flags: None
	Line Number: 743
*/
function player_died_penalty()
{
	players = getplayers(self.team);
	for(i = 0; i < players.size; i++)
	{
		if(players[i] != self && !players[i].is_zombie)
		{
			players[i] player_reduce_points("no_revive_penalty");
		}
	}
}

/*
	Name: player_downed_penalty
	Namespace: zm_score
	Checksum: 0x424F4353
	Offset: 0x1F68
	Size: 0x48
	Parameters: 0
	Flags: None
	Line Number: 765
*/
function player_downed_penalty()
{
	/#
		println("Dev Block strings are not supported");
	#/
	self player_reduce_points("downed");
}

/*
	Name: can_player_purchase
	Namespace: zm_score
	Checksum: 0x424F4353
	Offset: 0x1FB8
	Size: 0x46
	Parameters: 1
	Flags: None
	Line Number: 783
*/
function can_player_purchase(n_cost)
{
	if(self.score >= n_cost)
	{
		return 1;
	}
	if(self bgb::is_enabled("zm_bgb_shopping_free"))
	{
		return 1;
	}
	return 0;
}

