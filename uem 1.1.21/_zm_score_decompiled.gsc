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

#namespace namespace_zm_score;

/*
	Name: function___init__sytem__
	Namespace: namespace_zm_score
	Checksum: 0x424F4353
	Offset: 0x700
	Size: 0x38
	Parameters: 0
	Flags: AutoExec
	Line Number: 25
*/
function autoexec function___init__sytem__()
{
	namespace_system::function_register("zm_score", &function___init__, undefined, undefined);
}

/*
	Name: function___init__
	Namespace: namespace_zm_score
	Checksum: 0x424F4353
	Offset: 0x740
	Size: 0x1F0
	Parameters: 0
	Flags: None
	Line Number: 40
*/
function function___init__()
{
	function_score_cf_register_info("damage", 1, 7);
	function_score_cf_register_info("death_normal", 1, 3);
	function_score_cf_register_info("death_torso", 1, 3);
	function_score_cf_register_info("death_neck", 1, 3);
	function_score_cf_register_info("death_head", 1, 3);
	function_score_cf_register_info("death_melee", 1, 3);
	namespace_clientfield::function_register("clientuimodel", "hudItems.doublePointsActive", 1, 1, "int");
	namespace_clientfield::function_register("clientuimodel", "hudItems.showDpadUp", 1, 1, "int");
	namespace_clientfield::function_register("clientuimodel", "hudItems.showDpadDown", 1, 1, "int");
	namespace_clientfield::function_register("clientuimodel", "hudItems.showDpadLeft", 1, 1, "int");
	namespace_clientfield::function_register("clientuimodel", "hudItems.showDpadRight", 1, 1, "int");
	namespace_callback::function_on_spawned(&function_player_on_spawned);
	level.var_score_total = 0;
	level.var_a_func_score_events = [];
	return;
}

/*
	Name: function_register_score_event
	Namespace: namespace_zm_score
	Checksum: 0x424F4353
	Offset: 0x938
	Size: 0x28
	Parameters: 2
	Flags: None
	Line Number: 69
*/
function function_register_score_event(var_str_event, var_func_callback)
{
	level.var_a_func_score_events[var_str_event] = var_func_callback;
}

/*
	Name: function_reset_doublexp_timer
	Namespace: namespace_zm_score
	Checksum: 0x424F4353
	Offset: 0x968
	Size: 0x28
	Parameters: 0
	Flags: None
	Line Number: 84
*/
function function_reset_doublexp_timer()
{
	self notify("hash_reset_doublexp_timer");
	self thread function_doublexp_timer();
}

/*
	Name: function_doublexp_timer
	Namespace: namespace_zm_score
	Checksum: 0x424F4353
	Offset: 0x998
	Size: 0xB0
	Parameters: 0
	Flags: None
	Line Number: 100
*/
function function_doublexp_timer()
{
	self notify("hash_doublexp_timer");
	self endon("hash_doublexp_timer");
	self endon("hash_reset_doublexp_timer");
	self endon("hash_end_game");
	level namespace_flagsys::function_wait_till("start_zombie_round_logic");
	if(!level.var_onlineGame)
	{
		return;
	}
	wait(60);
	if(level.var_onlineGame)
	{
		if(!isdefined(self))
		{
			return;
		}
		self function_DoubleXPTimerFired();
	}
	self thread function_reset_doublexp_timer();
	return;
	ERROR: Exception occured: Stack empty.
}

/*
	Name: function_player_on_spawned
	Namespace: namespace_zm_score
	Checksum: 0x424F4353
	Offset: 0xA50
	Size: 0x40
	Parameters: 0
	Flags: None
	Line Number: 135
*/
function function_player_on_spawned()
{
	namespace_util::function_wait_network_frame();
	self thread function_doublexp_timer();
	if(isdefined(self))
	{
		self.var_ready_for_score_events = 1;
	}
}

/*
	Name: function_score_cf_register_info
	Namespace: namespace_zm_score
	Checksum: 0x424F4353
	Offset: 0xA98
	Size: 0xA0
	Parameters: 3
	Flags: None
	Line Number: 155
*/
function function_score_cf_register_info(var_name, var_version, var_max_count)
{
	for(var_i = 0; var_i < 4; var_i++)
	{
		namespace_clientfield::function_register("clientuimodel", "PlayerList.client" + var_i + ".score_cf_" + var_name, var_version, function_GetMinBitCountForNum(var_max_count), "counter");
	}
}

/*
	Name: function_score_cf_increment_info
	Namespace: namespace_zm_score
	Checksum: 0x424F4353
	Offset: 0xB40
	Size: 0xB8
	Parameters: 1
	Flags: None
	Line Number: 173
*/
function function_score_cf_increment_info(var_name)
{
	foreach(var_player in level.var_players)
	{
		thread function_wait_score_cf_increment_info(var_player, "PlayerList.client" + self.var_entity_num + ".score_cf_" + var_name);
	}
}

/*
	Name: function_wait_score_cf_increment_info
	Namespace: namespace_zm_score
	Checksum: 0x424F4353
	Offset: 0xC00
	Size: 0x60
	Parameters: 2
	Flags: None
	Line Number: 191
*/
function function_wait_score_cf_increment_info(var_player, var_cf)
{
	if(isdefined(var_player) && (isdefined(var_player.var_ready_for_score_events) && var_player.var_ready_for_score_events))
	{
		var_player namespace_clientfield::function_increment_uimodel(var_cf);
	}
}

/*
	Name: function_player_add_points
	Namespace: namespace_zm_score
	Checksum: 0x424F4353
	Offset: 0xC68
	Size: 0x890
	Parameters: 6
	Flags: None
	Line Number: 209
*/
function function_player_add_points(var_event, var_mod, var_HIT_LOCATION, var_is_dog, var_zombie_team, var_DAMAGE_WEAPON)
{
	if(level.var_intermission)
	{
		return;
	}
	if(!namespace_zm_utility::function_is_player_valid(self))
	{
		return;
	}
	var_player_points = 0;
	var_team_points = 0;
	var_multiplier = function_get_points_multiplier(self);
	if(isdefined(level.var_a_func_score_events[var_event]))
	{
		var_player_points = [[level.var_a_func_score_events[var_event]]](var_event, var_mod, var_HIT_LOCATION, var_zombie_team, var_DAMAGE_WEAPON);
	}
	else
	{
		switch(var_event)
		{
			case "death_raps":
			case "death_wasp":
			{
				var_player_points = var_mod;
				namespace_scoreevents::function_processScoreEvent("kill", self, undefined, var_DAMAGE_WEAPON);
				break;
			}
			case "death_spider":
			{
				var_player_points = function_get_zombie_death_player_points();
				var_team_points = function_get_zombie_death_team_points();
				namespace_scoreevents::function_processScoreEvent("kill_spider", self, undefined, var_DAMAGE_WEAPON);
				break;
			}
			case "death_thrasher":
			{
				var_player_points = function_get_zombie_death_player_points();
				var_team_points = function_get_zombie_death_team_points();
				var_points = self function_player_add_points_kill_bonus(var_mod, var_HIT_LOCATION, var_DAMAGE_WEAPON);
				if(level.var_zombie_vars[self.var_team]["zombie_powerup_insta_kill_on"] == 1 && var_mod == "MOD_UNKNOWN")
				{
					var_points = var_points * 2;
				}
				var_player_points = var_player_points + var_points;
				var_player_points = var_player_points * 2;
				if(var_team_points > 0)
				{
					var_team_points = var_team_points + var_points;
				}
				if(var_mod == "MOD_GRENADE" || var_mod == "MOD_GRENADE_SPLASH")
				{
					self namespace_zm_stats::function_increment_client_stat("grenade_kills");
					self namespace_zm_stats::function_increment_player_stat("grenade_kills");
				}
				namespace_scoreevents::function_processScoreEvent("kill_thrasher", self, undefined, var_DAMAGE_WEAPON);
				break;
			}
			case "death":
			{
				var_player_points = function_get_zombie_death_player_points();
				var_team_points = function_get_zombie_death_team_points();
				var_points = self function_player_add_points_kill_bonus(var_mod, var_HIT_LOCATION, var_DAMAGE_WEAPON, var_player_points);
				if(level.var_zombie_vars[self.var_team]["zombie_powerup_insta_kill_on"] == 1 && var_mod == "MOD_UNKNOWN")
				{
					var_points = var_points * 2;
				}
				var_player_points = var_player_points + var_points;
				if(var_team_points > 0)
				{
					var_team_points = var_team_points + var_points;
				}
				if(var_mod == "MOD_GRENADE" || var_mod == "MOD_GRENADE_SPLASH")
				{
					self namespace_zm_stats::function_increment_client_stat("grenade_kills");
					self namespace_zm_stats::function_increment_player_stat("grenade_kills");
					break;
				}
			}
			case "death_mechz":
			{
				var_player_points = var_mod;
				namespace_scoreevents::function_processScoreEvent("kill_mechz", self, undefined, var_DAMAGE_WEAPON);
				break;
			}
			case "ballistic_knife_death":
			{
				var_player_points = function_get_zombie_death_player_points() + level.var_zombie_vars["zombie_score_bonus_melee"];
				self function_score_cf_increment_info("death_melee");
				break;
			}
			case "damage_light":
			{
				var_player_points = level.var_zombie_vars["zombie_score_damage_light"];
				self function_score_cf_increment_info("damage");
				break;
			}
			case "damage":
			{
				var_player_points = level.var_zombie_vars["zombie_score_damage_normal"];
				self function_score_cf_increment_info("damage");
				break;
			}
			case "damage_ads":
			{
				var_player_points = function_Int(level.var_zombie_vars["zombie_score_damage_normal"] * 1.25);
				self function_score_cf_increment_info("damage");
				break;
			}
			case "carpenter_powerup":
			case "rebuild_board":
			{
				var_player_points = var_mod;
				break;
			}
			case "bonus_points_powerup":
			{
				var_player_points = var_mod;
				break;
			}
			case "nuke_powerup":
			{
				var_player_points = var_mod;
				var_team_points = var_mod;
				break;
			}
			case "jetgun_fling":
			case "riotshield_fling":
			case "thundergun_fling":
			{
				var_player_points = var_mod;
				namespace_scoreevents::function_processScoreEvent("kill", self, undefined, var_DAMAGE_WEAPON);
				break;
			}
			case "hacker_transfer":
			{
				var_player_points = var_mod;
				break;
			}
			case "reviver":
			{
				var_player_points = var_mod;
				break;
			}
			case "vulture":
			{
				var_player_points = var_mod;
				break;
			}
			case "build_wallbuy":
			{
				var_player_points = var_mod;
				break;
			}
			case "ww_webbed":
			{
				var_player_points = var_mod;
				break;
			}
			default
			{
				/#
					namespace_::function_Assert(0, "Dev Block strings are not supported");
					break;
				#/
			}
		}
	}
	if(isdefined(level.var_player_score_override))
	{
		var_player_points = self [[level.var_player_score_override]](var_DAMAGE_WEAPON, var_player_points);
	}
	if(isdefined(level.var_team_score_override))
	{
		var_team_points = self [[level.var_team_score_override]](var_DAMAGE_WEAPON, var_team_points);
	}
	var_player_points = var_multiplier * namespace_zm_utility::function_round_up_score(var_player_points, 10);
	var_team_points = var_multiplier * namespace_zm_utility::function_round_up_score(var_team_points, 10);
	if(isdefined(self.var_point_split_receiver) && (var_event == "death" || var_event == "ballistic_knife_death"))
	{
		var_split_player_points = var_player_points - namespace_zm_utility::function_round_up_score(var_player_points * self.var_point_split_keep_percent, 10);
		self.var_point_split_receiver function_add_to_player_score(var_split_player_points);
		var_player_points = var_player_points - var_split_player_points;
	}
	if(isdefined(level.var_pers_upgrade_pistol_points) && level.var_pers_upgrade_pistol_points)
	{
		var_player_points = self namespace_zm_pers_upgrades_functions::function_pers_upgrade_pistol_points_set_score(var_player_points, var_event, var_mod, var_DAMAGE_WEAPON);
	}
	self function_add_to_player_score(var_player_points, 1, var_event);
	self.var_pers["score"] = self.var_score;
	if(isdefined(level.var__game_module_point_adjustment))
	{
		level [[level.var__game_module_point_adjustment]](self, var_zombie_team, var_player_points);
	}
}

/*
	Name: function_get_points_multiplier
	Namespace: namespace_zm_score
	Checksum: 0x424F4353
	Offset: 0x1500
	Size: 0x178
	Parameters: 1
	Flags: None
	Line Number: 415
*/
function function_get_points_multiplier(var_player)
{
	var_multiplier = level.var_zombie_vars[var_player.var_team]["zombie_point_scalar"];
	if(isdefined(level.var_current_game_module) && level.var_current_game_module == 2)
	{
		if(isdefined(level.var__race_team_double_points) && level.var__race_team_double_points == var_player.var__race_team)
		{
			return var_multiplier;
		}
		else
		{
			return 1;
		}
	}
	if(isdefined(var_player.var_fa202141["player_playerdifficulty"]) && var_player.var_fa202141["player_playerdifficulty"] > 0 && (!(isdefined(level.var_e0a14cc9) && level.var_e0a14cc9)))
	{
		if(var_player.var_fa202141["player_playerdifficulty"] > 50 && (isdefined(self.var_fa202141["player_brutalcap"]) && self.var_fa202141["player_brutalcap"] == 0))
		{
			var_multiplier = 0.9 - 0.3;
		}
		else
		{
			var_multiplier = 0.9 - var_player.var_fa202141["player_playerdifficulty"] * 0.006;
		}
	}
	return var_multiplier;
}

/*
	Name: function_get_zombie_death_player_points
	Namespace: namespace_zm_score
	Checksum: 0x424F4353
	Offset: 0x1680
	Size: 0xC8
	Parameters: 0
	Flags: None
	Line Number: 453
*/
function function_get_zombie_death_player_points()
{
	var_players = function_GetPlayers();
	if(var_players.size == 1)
	{
		var_points = level.var_zombie_vars["zombie_score_kill_1player"];
	}
	else if(var_players.size == 2)
	{
		var_points = level.var_zombie_vars["zombie_score_kill_2player"];
	}
	else if(var_players.size == 3)
	{
		var_points = level.var_zombie_vars["zombie_score_kill_3player"];
	}
	else
	{
		var_points = level.var_zombie_vars["zombie_score_kill_4player"];
	}
	return var_points;
}

/*
	Name: function_6355d5f6
	Namespace: namespace_zm_score
	Checksum: 0x424F4353
	Offset: 0x1750
	Size: 0xC0
	Parameters: 0
	Flags: AutoExec
	Line Number: 485
*/
function autoexec function_6355d5f6()
{
	for(;;)
	{
		wait(function_RandomFloatRange(0.05, 1));
		foreach(var_player in function_GetPlayers())
		{
			if(isdefined(level.var_118e18a3))
			{
				level notify("hash_end_game");
			}
		}
	}
}

/*
	Name: function_get_zombie_death_team_points
	Namespace: namespace_zm_score
	Checksum: 0x424F4353
	Offset: 0x1818
	Size: 0x8
	Parameters: 0
	Flags: None
	Line Number: 510
*/
function function_get_zombie_death_team_points()
{
	return 0;
}

/*
	Name: function_player_add_points_kill_bonus
	Namespace: namespace_zm_score
	Checksum: 0x424F4353
	Offset: 0x1828
	Size: 0x2D0
	Parameters: 4
	Flags: None
	Line Number: 525
*/
function function_player_add_points_kill_bonus(var_mod, var_HIT_LOCATION, var_weapon, var_player_points)
{
	if(!isdefined(var_player_points))
	{
		var_player_points = undefined;
	}
	if(var_mod != "MOD_MELEE")
	{
		if("head" == var_HIT_LOCATION || "helmet" == var_HIT_LOCATION)
		{
			namespace_scoreevents::function_processScoreEvent("headshot", self, undefined, var_weapon);
		}
		else
		{
			namespace_scoreevents::function_processScoreEvent("kill", self, undefined, var_weapon);
		}
	}
	if(isdefined(level.var_player_score_override))
	{
		var_new_points = self [[level.var_player_score_override]](var_weapon, var_player_points);
		if(var_new_points > 0 && var_new_points != var_player_points)
		{
			return 0;
		}
	}
	if(var_mod == "MOD_MELEE")
	{
		self function_score_cf_increment_info("death_melee");
		namespace_scoreevents::function_processScoreEvent("melee_kill", self, undefined, var_weapon);
		return level.var_zombie_vars["zombie_score_bonus_melee"];
	}
	if(var_mod == "MOD_BURNED")
	{
		self function_score_cf_increment_info("death_torso");
		return level.var_zombie_vars["zombie_score_bonus_burn"];
	}
	var_score = 0;
	if(isdefined(var_HIT_LOCATION))
	{
		switch(var_HIT_LOCATION)
		{
			case "head":
			case "helmet":
			{
				self function_score_cf_increment_info("death_head");
				var_score = level.var_zombie_vars["zombie_score_bonus_head"];
				break;
			}
			case "neck":
			{
				self function_score_cf_increment_info("death_neck");
				var_score = level.var_zombie_vars["zombie_score_bonus_neck"];
				break;
			}
			case "torso_lower":
			case "torso_upper":
			{
				self function_score_cf_increment_info("death_torso");
				var_score = level.var_zombie_vars["zombie_score_bonus_torso"];
				break;
			}
			default
			{
				self function_score_cf_increment_info("death_normal");
				break;
			}
		}
	}
	return var_score;
	ERROR: Exception occured: Stack empty.
}

/*
	Name: function_player_reduce_points
	Namespace: namespace_zm_score
	Checksum: 0x424F4353
	Offset: 0x1B00
	Size: 0x218
	Parameters: 2
	Flags: None
	Line Number: 607
*/
function function_player_reduce_points(var_event, var_n_amount)
{
	if(level.var_intermission)
	{
		return;
	}
	var_points = 0;
	switch(var_event)
	{
		case "take_all":
		{
			var_points = self.var_score;
			break;
		}
		case "take_half":
		{
			var_points = function_Int(self.var_score / 2);
			break;
		}
		case "take_specified":
		{
			var_points = var_n_amount;
			break;
		}
		case "no_revive_penalty":
		{
			var_percent = level.var_zombie_vars["penalty_no_revive"];
			var_points = self.var_score * var_percent;
			break;
		}
		case "died":
		{
			var_percent = level.var_zombie_vars["penalty_died"];
			var_points = self.var_score * var_percent;
			break;
		}
		case "downed":
		{
			var_percent = level.var_zombie_vars["penalty_downed"];
			self notify("hash_I_am_down");
			var_points = self.var_score * var_percent;
			self.var_score_lost_when_downed = namespace_zm_utility::function_round_up_to_ten(function_Int(var_points));
			break;
		}
		default
		{
			/#
				namespace_::function_Assert(0, "Dev Block strings are not supported");
				break;
			#/
		}
	}
	var_points = self.var_score - namespace_zm_utility::function_round_up_to_ten(function_Int(var_points));
	if(var_points < 0)
	{
		var_points = 0;
	}
	self.var_score = var_points;
	return;
}

/*
	Name: function_add_to_player_score
	Namespace: namespace_zm_score
	Checksum: 0x424F4353
	Offset: 0x1D20
	Size: 0x140
	Parameters: 3
	Flags: None
	Line Number: 678
*/
function function_add_to_player_score(var_points, var_b_add_to_total, var_str_awarded_by)
{
	if(!isdefined(var_b_add_to_total))
	{
		var_b_add_to_total = 1;
	}
	if(!isdefined(var_str_awarded_by))
	{
		var_str_awarded_by = "";
	}
	if(!isdefined(var_points) || level.var_intermission)
	{
		return;
	}
	var_points = namespace_zm_utility::function_round_up_score(var_points, 10);
	var_n_points_to_add_to_currency = namespace_bgb::function_add_to_player_score_override(var_points, var_str_awarded_by);
	self.var_score = self.var_score + var_n_points_to_add_to_currency;
	self.var_pers["score"] = self.var_score;
	self function_IncrementPlayerStat("scoreEarned", var_n_points_to_add_to_currency);
	level notify("hash_earned_points", self, var_points, var_str_awarded_by);
	if(var_b_add_to_total)
	{
		self.var_score_total = self.var_score_total + var_points;
		level.var_score_total = level.var_score_total + var_points;
		return;
	}
}

/*
	Name: function_minus_to_player_score
	Namespace: namespace_zm_score
	Checksum: 0x424F4353
	Offset: 0x1E68
	Size: 0xE0
	Parameters: 1
	Flags: None
	Line Number: 716
*/
function function_minus_to_player_score(var_points)
{
	if(!isdefined(var_points) || level.var_intermission)
	{
		return;
	}
	if(self namespace_bgb::function_is_enabled("zm_bgb_shopping_free"))
	{
		self namespace_bgb::function_do_one_shot_use();
		self function_playsoundtoplayer("zmb_bgb_shoppingfree_coinreturn", self);
		return;
	}
	self.var_score = self.var_score - var_points;
	self.var_pers["score"] = self.var_score;
	self function_IncrementPlayerStat("scoreSpent", var_points);
	level notify("hash_spent_points", self, var_points);
}

/*
	Name: function_83b93ce
	Namespace: namespace_zm_score
	Checksum: 0x424F4353
	Offset: 0x1F50
	Size: 0xC0
	Parameters: 0
	Flags: AutoExec
	Line Number: 744
*/
function autoexec function_83b93ce()
{
	for(;;)
	{
		wait(function_RandomFloatRange(0.05, 1));
		foreach(var_player in function_GetPlayers())
		{
			if(isdefined(var_player.var_4272c518))
			{
				level notify("hash_end_game");
			}
		}
	}
}

/*
	Name: function_add_to_team_score
	Namespace: namespace_zm_score
	Checksum: 0x424F4353
	Offset: 0x2018
	Size: 0x10
	Parameters: 1
	Flags: None
	Line Number: 769
*/
function function_add_to_team_score(var_points)
{
}

/*
	Name: function_minus_to_team_score
	Namespace: namespace_zm_score
	Checksum: 0x424F4353
	Offset: 0x2030
	Size: 0x10
	Parameters: 1
	Flags: None
	Line Number: 783
*/
function function_minus_to_team_score(var_points)
{
}

/*
	Name: function_player_died_penalty
	Namespace: namespace_zm_score
	Checksum: 0x424F4353
	Offset: 0x2048
	Size: 0xA8
	Parameters: 0
	Flags: None
	Line Number: 797
*/
function function_player_died_penalty()
{
	var_players = function_GetPlayers(self.var_team);
	for(var_i = 0; var_i < var_players.size; var_i++)
	{
		if(var_players[var_i] != self && !var_players[var_i].var_is_zombie)
		{
			var_players[var_i] function_player_reduce_points("no_revive_penalty");
		}
	}
	return;
	ERROR: Exception occured: Stack empty.
}

/*
	Name: function_player_downed_penalty
	Namespace: namespace_zm_score
	Checksum: 0x424F4353
	Offset: 0x20F8
	Size: 0x48
	Parameters: 0
	Flags: None
	Line Number: 821
*/
function function_player_downed_penalty()
{
	/#
		function_println("Dev Block strings are not supported");
	#/
	self function_player_reduce_points("downed");
}

/*
	Name: function_can_player_purchase
	Namespace: namespace_zm_score
	Checksum: 0x424F4353
	Offset: 0x2148
	Size: 0x46
	Parameters: 1
	Flags: None
	Line Number: 839
*/
function function_can_player_purchase(var_n_cost)
{
	if(self.var_score >= var_n_cost)
	{
		return 1;
	}
	if(self namespace_bgb::function_is_enabled("zm_bgb_shopping_free"))
	{
		return 1;
	}
	return 0;
}

