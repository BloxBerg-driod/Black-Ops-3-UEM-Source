#include scripts\codescripts\struct;
#include scripts\shared\ai\zombie_utility;
#include scripts\shared\array_shared;
#include scripts\shared\flag_shared;
#include scripts\shared\system_shared;
#include scripts\shared\util_shared;
#include scripts\zm\_zm_utility;
#include scripts\zm\_zm_zonemgr;

#namespace namespace_giant_cleanup;

/*
	Name: function___init__sytem__
	Namespace: namespace_giant_cleanup
	Checksum: 0x424F4353
	Offset: 0x1A8
	Size: 0x40
	Parameters: 0
	Flags: AutoExec
	Line Number: 21
*/
function autoexec function___init__sytem__()
{
	namespace_system::function_register("giant_cleanup", &function___init__, &function___main__, undefined);
	return;
	ERROR: Exception occured: Stack empty.
}

/*
	Name: function___init__
	Namespace: namespace_giant_cleanup
	Checksum: 0x424F4353
	Offset: 0x1F0
	Size: 0x10
	Parameters: 0
	Flags: None
	Line Number: 38
*/
function function___init__()
{
	level.var_n_cleanups_processed_this_frame = 0;
}

/*
	Name: function___main__
	Namespace: namespace_giant_cleanup
	Checksum: 0x424F4353
	Offset: 0x208
	Size: 0x20
	Parameters: 0
	Flags: None
	Line Number: 53
*/
function function___main__()
{
	level thread function_cleanup_main();
}

/*
	Name: function_force_check_now
	Namespace: namespace_giant_cleanup
	Checksum: 0x424F4353
	Offset: 0x230
	Size: 0x18
	Parameters: 0
	Flags: None
	Line Number: 68
*/
function function_force_check_now()
{
	level notify("hash_pump_distance_check");
}

/*
	Name: function_cleanup_main
	Namespace: namespace_giant_cleanup
	Checksum: 0x424F4353
	Offset: 0x250
	Size: 0x248
	Parameters: 0
	Flags: Private
	Line Number: 83
*/
function private function_cleanup_main()
{
	var_n_next_eval = 0;
	while(1)
	{
		namespace_util::function_wait_network_frame();
		var_n_time = GetTime();
		if(var_n_time < var_n_next_eval)
		{
			continue;
		}
		if(isdefined(level.var_n_cleanup_manager_restart_time))
		{
			var_n_current_time = GetTime() / 1000;
			var_n_delta_time = var_n_current_time - level.var_n_cleanup_manager_restart_time;
			if(var_n_delta_time < 0)
			{
				continue;
			}
			level.var_n_cleanup_manager_restart_time = undefined;
		}
		var_n_round_time = var_n_time - level.var_round_start_time / 1000;
		if(level.var_round_number <= 5 && var_n_round_time < 30)
		{
			continue;
		}
		else if(level.var_round_number > 5 && var_n_round_time < 20)
		{
			continue;
		}
		var_n_override_cleanup_dist_sq = undefined;
		if(level.var_zombie_total == 0 && namespace_zombie_utility::function_get_current_zombie_count() < 3)
		{
			var_n_override_cleanup_dist_sq = 2250000;
		}
		var_n_next_eval = var_n_next_eval + 3000;
		var_a_ai_enemies = function_GetAITeamArray("axis");
		foreach(var_ai_enemy in var_a_ai_enemies)
		{
			if(level.var_n_cleanups_processed_this_frame >= 1)
			{
				level.var_n_cleanups_processed_this_frame = 0;
				namespace_util::function_wait_network_frame();
			}
			var_ai_enemy function_do_cleanup_check(var_n_override_cleanup_dist_sq);
		}
	}
}

/*
	Name: function_do_cleanup_check
	Namespace: namespace_giant_cleanup
	Checksum: 0x424F4353
	Offset: 0x4A0
	Size: 0x248
	Parameters: 1
	Flags: None
	Line Number: 142
*/
function function_do_cleanup_check(var_n_override_cleanup_dist)
{
	if(!function_isalive(self))
	{
		return;
	}
	if(self.var_b_ignore_cleanup === 1)
	{
		return;
	}
	var_n_time_alive = GetTime() - self.var_spawn_time;
	if(var_n_time_alive < 5000)
	{
		return;
	}
	if(var_n_time_alive < 45000 && self.var_script_string !== "find_flesh" && self.var_completed_emerging_into_playable_area !== 1)
	{
		return;
	}
	var_b_in_active_zone = self namespace_zm_zonemgr::function_entity_in_active_zone();
	level.var_n_cleanups_processed_this_frame++;
	if(!var_b_in_active_zone)
	{
		var_n_dist_sq_min = 10000000;
		var_e_closest_player = level.var_activePlayers[0];
		foreach(var_player in level.var_activePlayers)
		{
			var_n_dist_sq = function_DistanceSquared(self.var_origin, var_player.var_origin);
			if(var_n_dist_sq < var_n_dist_sq_min)
			{
				var_n_dist_sq_min = var_n_dist_sq;
				var_e_closest_player = var_player;
			}
		}
		if(isdefined(var_n_override_cleanup_dist))
		{
			var_n_cleanup_dist_sq = var_n_override_cleanup_dist;
		}
		else if(isdefined(var_e_closest_player) && function_player_ahead_of_me(var_e_closest_player))
		{
			var_n_cleanup_dist_sq = 189225;
		}
		else
		{
			var_n_cleanup_dist_sq = 250000;
		}
		if(var_n_dist_sq_min >= var_n_cleanup_dist_sq)
		{
			self thread function_delete_zombie_noone_looking();
		}
	}
}

/*
	Name: function_delete_zombie_noone_looking
	Namespace: namespace_giant_cleanup
	Checksum: 0x424F4353
	Offset: 0x6F0
	Size: 0x248
	Parameters: 0
	Flags: Private
	Line Number: 205
*/
function private function_delete_zombie_noone_looking()
{
	if(isdefined(self.var_in_the_ground) && self.var_in_the_ground)
	{
		return;
	}
	foreach(var_player in level.var_players)
	{
		if(var_player.var_sessionstate == "spectator")
		{
			continue;
		}
		if(self function_player_can_see_me(var_player))
		{
			return;
		}
	}
	if(!(isdefined(self.var_exclude_cleanup_adding_to_total) && self.var_exclude_cleanup_adding_to_total))
	{
		level.var_zombie_total++;
		level.var_zombie_respawns++;
		if(self.var_health < self.var_maxhealth)
		{
			if(!isdefined(level.var_a_zombie_respawn_health[self.var_archetype]))
			{
				level.var_a_zombie_respawn_health[self.var_archetype] = [];
			}
			if(!isdefined(level.var_a_zombie_respawn_health[self.var_archetype]))
			{
				level.var_a_zombie_respawn_health[self.var_archetype] = [];
			}
			else if(!function_IsArray(level.var_a_zombie_respawn_health[self.var_archetype]))
			{
				level.var_a_zombie_respawn_health[self.var_archetype] = function_Array(level.var_a_zombie_respawn_health[self.var_archetype]);
			}
			level.var_a_zombie_respawn_health[self.var_archetype][level.var_a_zombie_respawn_health[self.var_archetype].size] = self.var_health;
		}
	}
	self namespace_zombie_utility::function_reset_attack_spot();
	self function_kill();
	wait(0.05);
	if(isdefined(self))
	{
		self function_delete();
		return;
	}
	ERROR: Exception occured: Stack empty.
}

/*
	Name: function_player_can_see_me
	Namespace: namespace_giant_cleanup
	Checksum: 0x424F4353
	Offset: 0x940
	Size: 0xD8
	Parameters: 1
	Flags: Private
	Line Number: 264
*/
function private function_player_can_see_me(var_player)
{
	var_v_player_angles = var_player function_getPlayerAngles();
	var_v_player_forward = function_AnglesToForward(var_v_player_angles);
	var_v_player_to_self = self.var_origin - var_player function_GetOrigin();
	var_v_player_to_self = function_VectorNormalize(var_v_player_to_self);
	var_n_dot = function_VectorDot(var_v_player_forward, var_v_player_to_self);
	if(var_n_dot < 0.766)
	{
		return 0;
	}
	return 1;
}

/*
	Name: function_player_ahead_of_me
	Namespace: namespace_giant_cleanup
	Checksum: 0x424F4353
	Offset: 0xA20
	Size: 0xB8
	Parameters: 1
	Flags: Private
	Line Number: 288
*/
function private function_player_ahead_of_me(var_player)
{
	var_v_player_angles = var_player function_getPlayerAngles();
	var_v_player_forward = function_AnglesToForward(var_v_player_angles);
	var_v_dir = var_player function_GetOrigin() - self.var_origin;
	var_n_dot = function_VectorDot(var_v_player_forward, var_v_dir);
	if(var_n_dot < 0)
	{
		return 0;
	}
	return 1;
}

/*
	Name: function_get_escape_position
	Namespace: namespace_giant_cleanup
	Checksum: 0x424F4353
	Offset: 0xAE0
	Size: 0xB8
	Parameters: 0
	Flags: None
	Line Number: 311
*/
function function_get_escape_position()
{
	self endon("hash_death");
	var_str_zone = self.var_zone_name;
	if(!isdefined(var_str_zone))
	{
		var_str_zone = self.var_zone_name;
	}
	if(isdefined(var_str_zone))
	{
		var_a_zones = function_get_adjacencies_to_zone(var_str_zone);
		var_a_wait_locations = function_get_wait_locations_in_zones(var_a_zones);
		var_s_farthest = self function_get_farthest_wait_location(var_a_wait_locations);
	}
	return var_s_farthest;
}

/*
	Name: function_get_adjacencies_to_zone
	Namespace: namespace_giant_cleanup
	Checksum: 0x424F4353
	Offset: 0xBA0
	Size: 0x120
	Parameters: 1
	Flags: None
	Line Number: 338
*/
function function_get_adjacencies_to_zone(var_str_zone)
{
	var_a_adjacencies = [];
	var_a_adjacencies[0] = var_str_zone;
	var_a_adjacent_zones = function_getArrayKeys(level.var_zones[var_str_zone].var_adjacent_zones);
	for(var_i = 0; var_i < var_a_adjacent_zones.size; var_i++)
	{
		if(level.var_zones[var_str_zone].var_adjacent_zones[var_a_adjacent_zones[var_i]].var_is_connected)
		{
			if(!isdefined(var_a_adjacencies))
			{
				var_a_adjacencies = [];
			}
			else if(!function_IsArray(var_a_adjacencies))
			{
				var_a_adjacencies = function_Array(var_a_adjacencies);
			}
			var_a_adjacencies[var_a_adjacencies.size] = var_a_adjacent_zones[var_i];
		}
	}
	return var_a_adjacencies;
}

/*
	Name: function_get_wait_locations_in_zones
	Namespace: namespace_giant_cleanup
	Checksum: 0x424F4353
	Offset: 0xCC8
	Size: 0xD8
	Parameters: 1
	Flags: Private
	Line Number: 371
*/
function private function_get_wait_locations_in_zones(var_a_zones)
{
	var_a_wait_locations = [];
	foreach(var_zone in var_a_zones)
	{
		var_a_wait_locations = function_ArrayCombine(var_a_wait_locations, level.var_zones[var_zone].var_a_loc_types["dog_location"], 0, 0);
	}
	return var_a_wait_locations;
}

/*
	Name: function_get_farthest_wait_location
	Namespace: namespace_giant_cleanup
	Checksum: 0x424F4353
	Offset: 0xDA8
	Size: 0xD8
	Parameters: 1
	Flags: Private
	Line Number: 391
*/
function private function_get_farthest_wait_location(var_a_wait_locations)
{
	if(!isdefined(var_a_wait_locations) || var_a_wait_locations.size == 0)
	{
		return undefined;
	}
	var_n_farthest_index = 0;
	var_n_distance_farthest = 0;
	for(var_i = 0; var_i < var_a_wait_locations.size; var_i++)
	{
		var_n_distance_sq = function_DistanceSquared(self.var_origin, var_a_wait_locations[var_i].var_origin);
		if(var_n_distance_sq > var_n_distance_farthest)
		{
			var_n_distance_farthest = var_n_distance_sq;
			var_n_farthest_index = var_i;
		}
	}
	return var_a_wait_locations[var_n_farthest_index];
}

/*
	Name: function_get_wait_locations_in_zone
	Namespace: namespace_giant_cleanup
	Checksum: 0x424F4353
	Offset: 0xE88
	Size: 0x88
	Parameters: 1
	Flags: Private
	Line Number: 421
*/
function private function_get_wait_locations_in_zone(var_zone)
{
	if(isdefined(level.var_zones[var_zone].var_a_loc_types["dog_location"]))
	{
		var_a_wait_locations = [];
		var_a_wait_locations = function_ArrayCombine(var_a_wait_locations, level.var_zones[var_zone].var_a_loc_types["dog_location"], 0, 0);
		return var_a_wait_locations;
	}
	return undefined;
}

/*
	Name: function_get_escape_position_in_current_zone
	Namespace: namespace_giant_cleanup
	Checksum: 0x424F4353
	Offset: 0xF18
	Size: 0x9C
	Parameters: 0
	Flags: None
	Line Number: 442
*/
function function_get_escape_position_in_current_zone()
{
	self endon("hash_death");
	var_str_zone = self.var_zone_name;
	if(!isdefined(var_str_zone))
	{
		var_str_zone = self.var_zone_name;
	}
	if(isdefined(var_str_zone))
	{
		var_a_wait_locations = function_get_wait_locations_in_zone(var_str_zone);
		if(isdefined(var_a_wait_locations))
		{
			var_s_farthest = self function_get_farthest_wait_location(var_a_wait_locations);
		}
	}
	return var_s_farthest;
}

