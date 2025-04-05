#include scripts\codescripts\struct;
#include scripts\shared\ai\zombie_death;
#include scripts\shared\clientfield_shared;
#include scripts\shared\laststand_shared;
#include scripts\shared\system_shared;
#include scripts\shared\util_shared;
#include scripts\zm\_zm_blockers;
#include scripts\zm\_zm_laststand;
#include scripts\zm\_zm_pers_upgrades;
#include scripts\zm\_zm_pers_upgrades_functions;
#include scripts\zm\_zm_powerups;
#include scripts\zm\_zm_score;
#include scripts\zm\_zm_spawner;
#include scripts\zm\_zm_utility;
#include scripts\zm\_zm_weap_riotshield;

#namespace namespace_zm_powerup_carpenter;

/*
	Name: function___init__sytem__
	Namespace: namespace_zm_powerup_carpenter
	Checksum: 0x424F4353
	Offset: 0x340
	Size: 0x38
	Parameters: 0
	Flags: AutoExec
	Line Number: 28
*/
function autoexec function___init__sytem__()
{
	namespace_system::function_register("zm_powerup_carpenter", &function___init__, undefined, undefined);
}

/*
	Name: function___init__
	Namespace: namespace_zm_powerup_carpenter
	Checksum: 0x424F4353
	Offset: 0x380
	Size: 0xE8
	Parameters: 0
	Flags: None
	Line Number: 43
*/
function function___init__()
{
	namespace_zm_powerups::function_register_powerup("carpenter", &function_grab_carpenter);
	if(function_ToLower(function_GetDvarString("g_gametype")) != "zcleansed")
	{
		namespace_zm_powerups::function_add_zombie_powerup("carpenter", "p7_zm_power_up_carpenter", &"ZOMBIE_POWERUP_MAX_AMMO", &function_func_should_drop_carpenter, 0, 0, 0);
	}
	if(!isdefined(level.var_147d7517))
	{
		level.var_147d7517 = [];
	}
	level.var_147d7517["carpenter"] = 1;
	level.var_use_new_carpenter_func = &function_start_carpenter_new;
	return;
	ERROR: Bad function call
}

/*
	Name: function_grab_carpenter
	Namespace: namespace_zm_powerup_carpenter
	Checksum: 0x424F4353
	Offset: 0x470
	Size: 0x128
	Parameters: 1
	Flags: None
	Line Number: 70
*/
function function_grab_carpenter(var_player)
{
	if(namespace_zm_utility::function_is_Classic())
	{
		var_player thread namespace_zm_pers_upgrades::function_persistent_carpenter_ability_check();
	}
	if(isdefined(level.var_use_new_carpenter_func))
	{
		level thread [[level.var_use_new_carpenter_func]](self.var_origin);
	}
	else
	{
		level thread function_start_carpenter(self.var_origin);
	}
	var_player thread namespace_zm_powerups::function_powerup_vo("carpenter");
	foreach(var_player in function_GetPlayers())
	{
		var_player thread function_dde76e47();
	}
	return;
	ERROR: Exception occured: Stack empty.
}

/*
	Name: function_dde76e47
	Namespace: namespace_zm_powerup_carpenter
	Checksum: 0x424F4353
	Offset: 0x5A0
	Size: 0x118
	Parameters: 0
	Flags: None
	Line Number: 103
*/
function function_dde76e47()
{
	while(self namespace_laststand::function_player_is_in_laststand())
	{
		wait(2);
	}
	foreach(var_weapon in self function_GetWeaponsList(1))
	{
		if(isdefined(var_weapon.var_isRiotShield) && var_weapon.var_isRiotShield)
		{
			self function_giveMaxAmmo(var_weapon);
			self namespace_riotshield::function_player_damage_shield(var_weapon.var_weaponstarthitpoints * -1);
		}
	}
}

/*
	Name: function_start_carpenter
	Namespace: namespace_zm_powerup_carpenter
	Checksum: 0x424F4353
	Offset: 0x6C0
	Size: 0x328
	Parameters: 1
	Flags: None
	Line Number: 129
*/
function function_start_carpenter(var_origin)
{
	var_window_boards = namespace_struct::function_get_array("exterior_goal", "targetname");
	var_Total = level.var_exterior_goals.size;
	var_carp_ent = function_spawn("script_origin", (0, 0, 0));
	var_carp_ent function_PlayLoopSound("evt_carpenter");
	while(1)
	{
		var_windows = function_get_closest_window_repair(var_window_boards, var_origin);
		if(!isdefined(var_windows))
		{
			var_carp_ent function_StopLoopSound(1);
			var_carp_ent function_PlaySoundWithNotify("evt_carpenter_end", "sound_done");
			var_carp_ent waittill("hash_sound_done");
			break;
		}
		else
		{
			function_ArrayRemoveValue(var_window_boards, var_windows);
		}
		while(1)
		{
			if(namespace_zm_utility::function_all_chunks_intact(var_windows, var_windows.var_barrier_chunks))
			{
				break;
			}
			var_chunk = namespace_zm_utility::function_get_random_destroyed_chunk(var_windows, var_windows.var_barrier_chunks);
			if(!isdefined(var_chunk))
			{
				break;
			}
			var_windows thread namespace_zm_blockers::function_replace_chunk(var_windows, var_chunk, undefined, namespace_zm_powerups::function_is_carpenter_boards_upgraded(), 1);
			if(isdefined(var_windows.var_clip))
			{
				var_windows.var_clip function_TriggerEnable(1);
				var_windows.var_clip function_disconnectpaths();
			}
			else
			{
				namespace_zm_blockers::function_blocker_disconnect_paths(var_windows.var_neg_start, var_windows.var_neg_end);
			}
			namespace_util::function_wait_network_frame();
			wait(0.05);
		}
		namespace_util::function_wait_network_frame();
	}
	var_players = function_GetPlayers();
	for(var_i = 0; var_i < var_players.size; var_i++)
	{
		var_players[var_i] namespace_zm_score::function_player_add_points("carpenter_powerup", 200);
	}
	var_carp_ent function_delete();
}

/*
	Name: function_get_closest_window_repair
	Namespace: namespace_zm_powerup_carpenter
	Checksum: 0x424F4353
	Offset: 0x9F0
	Size: 0x140
	Parameters: 2
	Flags: None
	Line Number: 193
*/
function function_get_closest_window_repair(var_windows, var_origin)
{
	var_current_window = undefined;
	var_shortest_distance = undefined;
	for(var_i = 0; var_i < var_windows.size; var_i++)
	{
		if(namespace_zm_utility::function_all_chunks_intact(var_windows, var_windows[var_i].var_barrier_chunks))
		{
			continue;
		}
		if(!isdefined(var_current_window))
		{
			var_current_window = var_windows[var_i];
			var_shortest_distance = function_DistanceSquared(var_current_window.var_origin, var_origin);
			continue;
		}
		if(function_DistanceSquared(var_windows[var_i].var_origin, var_origin) < var_shortest_distance)
		{
			var_current_window = var_windows[var_i];
			var_shortest_distance = function_DistanceSquared(var_windows[var_i].var_origin, var_origin);
		}
	}
	return var_current_window;
}

/*
	Name: function_start_carpenter_new
	Namespace: namespace_zm_powerup_carpenter
	Checksum: 0x424F4353
	Offset: 0xB38
	Size: 0x498
	Parameters: 1
	Flags: None
	Line Number: 228
*/
function function_start_carpenter_new(var_origin)
{
	level.var_carpenter_powerup_active = 1;
	var_window_boards = namespace_struct::function_get_array("exterior_goal", "targetname");
	if(isdefined(level.var__additional_carpenter_nodes))
	{
		var_window_boards = function_ArrayCombine(var_window_boards, level.var__additional_carpenter_nodes, 0, 0);
	}
	var_carp_ent = function_spawn("script_origin", (0, 0, 0));
	var_carp_ent function_PlayLoopSound("evt_carpenter");
	var_boards_near_players = function_get_near_boards(var_window_boards);
	var_boards_far_from_players = function_get_far_boards(var_window_boards);
	level function_repair_far_boards(var_boards_far_from_players, namespace_zm_powerups::function_is_carpenter_boards_upgraded());
	for(var_i = 0; var_i < var_boards_near_players.size; var_i++)
	{
		var_window = var_boards_near_players[var_i];
		var_num_chunks_checked = 0;
		var_last_repaired_chunk = undefined;
		while(1)
		{
			if(namespace_zm_utility::function_all_chunks_intact(var_window, var_window.var_barrier_chunks))
			{
				break;
			}
			var_chunk = namespace_zm_utility::function_get_random_destroyed_chunk(var_window, var_window.var_barrier_chunks);
			if(!isdefined(var_chunk))
			{
				break;
			}
			var_window thread namespace_zm_blockers::function_replace_chunk(var_window, var_chunk, undefined, namespace_zm_powerups::function_is_carpenter_boards_upgraded(), 1);
			var_last_repaired_chunk = var_chunk;
			if(isdefined(var_window.var_clip))
			{
				var_window.var_clip function_TriggerEnable(1);
				var_window.var_clip function_disconnectpaths();
			}
			else
			{
				namespace_zm_blockers::function_blocker_disconnect_paths(var_window.var_neg_start, var_window.var_neg_end);
			}
			namespace_util::function_wait_network_frame();
			var_num_chunks_checked++;
			if(var_num_chunks_checked >= 20)
			{
				break;
			}
		}
		if(isdefined(var_window.var_zbarrier))
		{
			if(isdefined(var_last_repaired_chunk))
			{
				while(var_window.var_zbarrier function_GetZBarrierPieceState(var_last_repaired_chunk) == "closing")
				{
					wait(0.05);
				}
				if(isdefined(var_window.var__post_carpenter_callback))
				{
					var_window [[var_window.var__post_carpenter_callback]]();
					continue;
				}
			}
		}
		while(isdefined(var_last_repaired_chunk) && var_last_repaired_chunk.var_State == "mid_repair")
		{
			wait(0.05);
		}
	}
	var_carp_ent function_StopLoopSound(1);
	var_carp_ent function_PlaySoundWithNotify("evt_carpenter_end", "sound_done");
	var_carp_ent waittill("hash_sound_done");
	var_players = function_GetPlayers();
	for(var_i = 0; var_i < var_players.size; var_i++)
	{
		var_players[var_i] namespace_zm_score::function_player_add_points("carpenter_powerup", 200);
	}
	var_carp_ent function_delete();
	level notify("hash_carpenter_finished");
	level.var_carpenter_powerup_active = undefined;
}

/*
	Name: function_get_near_boards
	Namespace: namespace_zm_powerup_carpenter
	Checksum: 0x424F4353
	Offset: 0xFD8
	Size: 0x168
	Parameters: 1
	Flags: None
	Line Number: 318
*/
function function_get_near_boards(var_windows)
{
	var_players = function_GetPlayers();
	var_boards_near_players = [];
	for(var_j = 0; var_j < var_windows.size; var_j++)
	{
		var_close = 0;
		for(var_i = 0; var_i < var_players.size; var_i++)
		{
			var_origin = undefined;
			if(isdefined(var_windows[var_j].var_zbarrier))
			{
				var_origin = var_windows[var_j].var_zbarrier.var_origin;
			}
			else
			{
				var_origin = var_windows[var_j].var_origin;
			}
			if(function_DistanceSquared(var_players[var_i].var_origin, var_origin) <= 562500)
			{
				var_close = 1;
				break;
			}
		}
		if(var_close)
		{
			var_boards_near_players[var_boards_near_players.size] = var_windows[var_j];
		}
	}
	return var_boards_near_players;
}

/*
	Name: function_get_far_boards
	Namespace: namespace_zm_powerup_carpenter
	Checksum: 0x424F4353
	Offset: 0x1148
	Size: 0x168
	Parameters: 1
	Flags: None
	Line Number: 360
*/
function function_get_far_boards(var_windows)
{
	var_players = function_GetPlayers();
	var_boards_far_from_players = [];
	for(var_j = 0; var_j < var_windows.size; var_j++)
	{
		var_close = 0;
		for(var_i = 0; var_i < var_players.size; var_i++)
		{
			var_origin = undefined;
			if(isdefined(var_windows[var_j].var_zbarrier))
			{
				var_origin = var_windows[var_j].var_zbarrier.var_origin;
			}
			else
			{
				var_origin = var_windows[var_j].var_origin;
			}
			if(function_DistanceSquared(var_players[var_i].var_origin, var_origin) >= 562500)
			{
				var_close = 1;
				break;
			}
		}
		if(var_close)
		{
			var_boards_far_from_players[var_boards_far_from_players.size] = var_windows[var_j];
		}
	}
	return var_boards_far_from_players;
}

/*
	Name: function_repair_far_boards
	Namespace: namespace_zm_powerup_carpenter
	Checksum: 0x424F4353
	Offset: 0x12B8
	Size: 0x2F0
	Parameters: 2
	Flags: None
	Line Number: 402
*/
function function_repair_far_boards(var_barriers, var_upgrade)
{
	for(var_i = 0; var_i < var_barriers.size; var_i++)
	{
		var_barrier = var_barriers[var_i];
		if(namespace_zm_utility::function_all_chunks_intact(var_barrier, var_barrier.var_barrier_chunks))
		{
			continue;
		}
		if(isdefined(var_barrier.var_zbarrier))
		{
			var_a_pieces = var_barrier.var_zbarrier function_GetZBarrierPieceIndicesInState("open");
			if(isdefined(var_a_pieces))
			{
				for(var_xx = 0; var_xx < var_a_pieces.size; var_xx++)
				{
					var_chunk = var_a_pieces[var_xx];
					if(var_upgrade)
					{
						var_barrier.var_zbarrier function_ZBarrierPieceUseUpgradedModel(var_chunk);
						var_barrier.var_zbarrier.var_chunk_health[var_chunk] = var_barrier.var_zbarrier function_GetUpgradedPieceNumLives(var_chunk);
						continue;
					}
					var_barrier.var_zbarrier function_ZBarrierPieceUseDefaultModel(var_chunk);
					var_barrier.var_zbarrier.var_chunk_health[var_chunk] = 0;
				}
			}
			for(var_x = 0; var_x < var_barrier.var_zbarrier function_GetNumZBarrierPieces(); var_x++)
			{
				var_barrier.var_zbarrier function_SetZBarrierPieceState(var_x, "closed");
				var_barrier.var_zbarrier function_ShowZBarrierPiece(var_x);
			}
		}
		else if(isdefined(var_barrier.var_clip))
		{
			var_barrier.var_clip function_TriggerEnable(1);
			var_barrier.var_clip function_disconnectpaths();
		}
		else
		{
			namespace_zm_blockers::function_blocker_disconnect_paths(var_barrier.var_neg_start, var_barrier.var_neg_end);
		}
		if(var_i % 4 == 0)
		{
			namespace_util::function_wait_network_frame();
		}
	}
}

/*
	Name: function_func_should_drop_carpenter
	Namespace: namespace_zm_powerup_carpenter
	Checksum: 0x424F4353
	Offset: 0x15B0
	Size: 0x58
	Parameters: 0
	Flags: None
	Line Number: 461
*/
function function_func_should_drop_carpenter()
{
	if(function_get_num_window_destroyed() < 5 || (!(isdefined(level.var_147d7517["carpenter"]) && level.var_147d7517["carpenter"])))
	{
		return 0;
	}
	return 1;
}

/*
	Name: function_get_num_window_destroyed
	Namespace: namespace_zm_powerup_carpenter
	Checksum: 0x424F4353
	Offset: 0x1610
	Size: 0x8C
	Parameters: 0
	Flags: None
	Line Number: 480
*/
function function_get_num_window_destroyed()
{
	var_num = 0;
	for(var_i = 0; var_i < level.var_exterior_goals.size; var_i++)
	{
		if(namespace_zm_utility::function_all_chunks_destroyed(level.var_exterior_goals[var_i], level.var_exterior_goals[var_i].var_barrier_chunks))
		{
			var_num = var_num + 1;
		}
	}
	return var_num;
}

