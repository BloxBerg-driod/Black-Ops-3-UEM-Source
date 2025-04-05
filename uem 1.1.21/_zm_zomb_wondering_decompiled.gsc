#include scripts\codescripts\struct;
#include scripts\shared\array_shared;
#include scripts\shared\callbacks_shared;
#include scripts\shared\laststand_shared;
#include scripts\shared\math_shared;
#include scripts\shared\spawner_shared;
#include scripts\shared\system_shared;
#include scripts\shared\util_shared;
#include scripts\zm\_zm_utility;

#namespace namespace_6103e868;

/*
	Name: function_init
	Namespace: namespace_6103e868
	Checksum: 0x424F4353
	Offset: 0x1B8
	Size: 0x30
	Parameters: 0
	Flags: AutoExec
	Line Number: 22
*/
function autoexec function_init()
{
	namespace_spawner::function_add_archetype_spawn_function("zombie", &function_wondering);
}

/*
	Name: function_wondering
	Namespace: namespace_6103e868
	Checksum: 0x424F4353
	Offset: 0x1F0
	Size: 0x2C0
	Parameters: 0
	Flags: None
	Line Number: 37
*/
function function_wondering()
{
	self endon("hash_death");
	level endon("hash_end_game");
	self.var_5bb6cdc1 = 0;
	while(isdefined(self))
	{
		wait(1);
		if(isdefined(self))
		{
			self.var_v_zombie_custom_goal_pos = undefined;
		}
		if(!self namespace_zm_utility::function_in_playable_area() && isdefined(self))
		{
			continue;
		}
		if(self function_CanPath(self.var_origin, self.var_favoriteenemy.var_origin))
		{
			continue;
		}
		if(isdefined(self.var_poi_active) && self.var_poi_active)
		{
			continue;
		}
		if(isdefined(self.var_favoriteenemy.var_89a989c2) && self.var_favoriteenemy.var_89a989c2)
		{
			continue;
		}
		if(isdefined(self.var_favoriteenemy.var_afterlife) && self.var_favoriteenemy.var_afterlife && self function_CanPath(self.var_origin, self.var_favoriteenemy.var_origin) && (!(isdefined(self.var_a44ca904) && self.var_a44ca904)))
		{
			continue;
		}
		wait(1);
		if(self function_CanPath(self.var_origin, self.var_favoriteenemy.var_origin))
		{
			continue;
		}
		self.var_5bb6cdc1 = 1;
		self.var_v_zombie_custom_goal_pos = self thread function_43d54cb7(function_VectorNormalize(self.var_favoriteenemy.var_origin - self.var_origin), level.var_botSettings.var_damageWanderMin, level.var_botSettings.var_damageWanderMax, level.var_botSettings.var_damageWanderSpacing, level.var_botSettings.var_damageWanderFwdDot);
		while(isdefined(self) && function_Distance(self.var_origin, function_GetClosestPointOnNavMesh(self.var_v_zombie_custom_goal_pos, 50, 15)) >= 50 && !self function_CanPath(self.var_origin, self.var_favoriteenemy.var_origin))
		{
			wait(0.5);
		}
		self.var_5bb6cdc1 = 0;
		wait(1);
	}
}

/*
	Name: function_43d54cb7
	Namespace: namespace_6103e868
	Checksum: 0x424F4353
	Offset: 0x4B8
	Size: 0x1B0
	Parameters: 5
	Flags: None
	Line Number: 95
*/
function function_43d54cb7(var_fwd, var_radiusMin, var_radiusMax, var_spacing, var_fwdDot)
{
	var_move_away_points = function_PositionQuery_Source_Navigation(self.var_origin, 100, 3000, 750, 40, 1, 300);
	function_PositionQuery_Filter_InClaimedLocation(var_move_away_points, self);
	for(var_i = 0; var_i < var_move_away_points.var_data.size; var_i++)
	{
		if(!namespace_zm_utility::function_check_point_in_playable_area(var_move_away_points.var_data[var_i].var_origin) || function_PathDistance(function_GetClosestPointOnNavMesh(self.var_origin, 50, 15), function_GetClosestPointOnNavMesh(var_move_away_points.var_data[var_i].var_origin, 50, 15), 1, self, level.var_pathdist_type) > 2000)
		{
			continue;
		}
		var_origin = var_move_away_points.var_data[var_i].var_origin;
		break;
	}
	if(!isdefined(var_origin))
	{
		return undefined;
	}
	return var_origin;
}

/*
	Name: function_looking
	Namespace: namespace_6103e868
	Checksum: 0x424F4353
	Offset: 0x670
	Size: 0x500
	Parameters: 0
	Flags: None
	Line Number: 125
*/
function function_looking()
{
	self endon("hash_death");
	self endon("hash_660209e6");
	level endon("hash_end_game");
	while(isdefined(self) && !self function_CanPath(self.var_origin, self.var_favoriteenemy.var_origin))
	{
		wait(1);
		var_structs = namespace_struct::function_get_array("structs_wondering");
		foreach(var_STR in var_structs)
		{
			if(!isdefined(var_STR.var_Number))
			{
				var_STR.var_Number = 0;
			}
		}
		var_origin = undefined;
		var_e8ef0e4 = undefined;
		while(isdefined(self) && !isdefined(var_origin))
		{
			if(!isdefined(var_structs) || var_structs.size == 0)
			{
				var_move_away_points = function_PositionQuery_Source_Navigation(self.var_origin, 300, 2000, 350, 40, 1, 300);
				function_PositionQuery_Filter_InClaimedLocation(var_move_away_points, self);
				for(var_i = 0; var_i < var_move_away_points.var_data.size; var_i++)
				{
					if(!namespace_zm_utility::function_check_point_in_playable_area(var_move_away_points.var_data[var_i].var_origin) || function_PathDistance(function_GetClosestPointOnNavMesh(self.var_origin, 50, 15), function_GetClosestPointOnNavMesh(var_move_away_points.var_data[var_i].var_origin, 50, 15), 1, self, level.var_pathdist_type) > 2000)
					{
						continue;
					}
					var_origin = var_move_away_points.var_data[var_i].var_origin;
					break;
				}
			}
			else
			{
				var_6cdfbcd2 = function_ArraySortClosest(var_structs, self.var_origin, 4, 50, 1500);
				var_e8ef0e4 = namespace_Array::function_random(var_6cdfbcd2);
				if(self function_CanPath(self.var_origin, var_e8ef0e4.var_origin) && function_PathDistance(function_GetClosestPointOnNavMesh(self.var_origin, 50, 15), function_GetClosestPointOnNavMesh(var_e8ef0e4.var_origin, 50, 15), 1, self, level.var_pathdist_type) > 50 && var_e8ef0e4.var_Number < 4)
				{
					var_e8ef0e4.var_Number++;
					var_origin = var_e8ef0e4.var_origin;
					break;
				}
				if(var_e8ef0e4.var_Number > 3)
				{
					function_ArrayRemoveValue(var_structs, var_e8ef0e4);
				}
			}
			wait(1);
		}
		if(!isdefined(var_origin))
		{
			return;
		}
		self.var_v_zombie_custom_goal_pos = var_origin;
		while(isdefined(self) && function_Distance(self.var_origin, function_GetClosestPointOnNavMesh(var_origin, 50, 15)) >= 50 && !self function_CanPath(self.var_origin, self.var_favoriteenemy.var_origin))
		{
			wait(1);
		}
		if(isdefined(var_e8ef0e4.var_Number))
		{
			var_e8ef0e4.var_Number--;
		}
	}
}

