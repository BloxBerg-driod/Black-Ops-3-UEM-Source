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
	Name: init
	Namespace: namespace_6103e868
	Checksum: 0x424F4353
	Offset: 0x1B8
	Size: 0x30
	Parameters: 0
	Flags: AutoExec
	Line Number: 22
*/
function autoexec init()
{
	spawner::add_archetype_spawn_function("zombie", &wondering);
}

/*
	Name: wondering
	Namespace: namespace_6103e868
	Checksum: 0x424F4353
	Offset: 0x1F0
	Size: 0x1F8
	Parameters: 0
	Flags: None
	Line Number: 37
*/
function wondering()
{
	self endon("death");
	level endon("end_game");
	self.var_5bb6cdc1 = 0;
	while(isdefined(self))
	{
		wait(0.5);
		if(isdefined(self))
		{
			self.v_zombie_custom_goal_pos = undefined;
		}
		if(!self zm_utility::in_playable_area() && isdefined(self))
		{
			continue;
		}
		if(self CanPath(self.origin, self.favoriteenemy.origin))
		{
			continue;
		}
		if(isdefined(self.poi_active) && self.poi_active)
		{
			continue;
		}
		self.v_zombie_custom_goal_pos = self thread function_43d54cb7(vectornormalize(self.favoriteenemy.origin - self.origin), level.botSettings.damageWanderMin, level.botSettings.damageWanderMax, level.botSettings.damageWanderSpacing, level.botSettings.damageWanderFwdDot);
		self.var_5bb6cdc1 = 1;
		while(isdefined(self) && distance(self.origin, getclosestpointonnavmesh(self.v_zombie_custom_goal_pos, 50, 15)) >= 50 && !self CanPath(self.origin, self.favoriteenemy.origin))
		{
			wait(0.5);
		}
		self.var_5bb6cdc1 = 0;
		wait(0.5);
	}
}

/*
	Name: function_43d54cb7
	Namespace: namespace_6103e868
	Checksum: 0x424F4353
	Offset: 0x3F0
	Size: 0x1B0
	Parameters: 5
	Flags: None
	Line Number: 82
*/
function function_43d54cb7(fwd, radiusMin, radiusMax, spacing, fwdDot)
{
	move_away_points = positionquery_source_navigation(self.origin, 100, 3000, 750, 40, 1, 300);
	PositionQuery_Filter_InClaimedLocation(move_away_points, self);
	for(i = 0; i < move_away_points.data.size; i++)
	{
		if(!zm_utility::check_point_in_playable_area(move_away_points.data[i].origin) || PathDistance(getclosestpointonnavmesh(self.origin, 50, 15), getclosestpointonnavmesh(move_away_points.data[i].origin, 50, 15), 1, self, level.pathdist_type) > 2000)
		{
			continue;
		}
		origin = move_away_points.data[i].origin;
		break;
	}
	if(!isdefined(origin))
	{
		return undefined;
	}
	return origin;
}

/*
	Name: looking
	Namespace: namespace_6103e868
	Checksum: 0x424F4353
	Offset: 0x5A8
	Size: 0x500
	Parameters: 0
	Flags: None
	Line Number: 112
*/
function looking()
{
	self endon("death");
	self endon("hash_660209e6");
	level endon("end_game");
	while(isdefined(self) && !self CanPath(self.origin, self.favoriteenemy.origin))
	{
		wait(1);
		structs = struct::get_array("structs_wondering");
		foreach(str in structs)
		{
			if(!isdefined(str.number))
			{
				str.number = 0;
			}
		}
		origin = undefined;
		var_e8ef0e4 = undefined;
		while(isdefined(self) && !isdefined(origin))
		{
			if(!isdefined(structs) || structs.size == 0)
			{
				move_away_points = positionquery_source_navigation(self.origin, 300, 2000, 350, 40, 1, 300);
				PositionQuery_Filter_InClaimedLocation(move_away_points, self);
				for(i = 0; i < move_away_points.data.size; i++)
				{
					if(!zm_utility::check_point_in_playable_area(move_away_points.data[i].origin) || PathDistance(getclosestpointonnavmesh(self.origin, 50, 15), getclosestpointonnavmesh(move_away_points.data[i].origin, 50, 15), 1, self, level.pathdist_type) > 2000)
					{
						continue;
					}
					origin = move_away_points.data[i].origin;
					break;
				}
			}
			else
			{
				var_6cdfbcd2 = arraysortclosest(structs, self.origin, 4, 50, 1500);
				var_e8ef0e4 = array::random(var_6cdfbcd2);
				if(self CanPath(self.origin, var_e8ef0e4.origin) && PathDistance(getclosestpointonnavmesh(self.origin, 50, 15), getclosestpointonnavmesh(var_e8ef0e4.origin, 50, 15), 1, self, level.pathdist_type) > 50 && var_e8ef0e4.number < 4)
				{
					var_e8ef0e4.number++;
					origin = var_e8ef0e4.origin;
					break;
				}
				if(var_e8ef0e4.number > 3)
				{
					arrayremovevalue(structs, var_e8ef0e4);
				}
			}
			wait(1);
		}
		if(!isdefined(origin))
		{
			return;
		}
		self.v_zombie_custom_goal_pos = origin;
		while(isdefined(self) && distance(self.origin, getclosestpointonnavmesh(origin, 50, 15)) >= 50 && !self CanPath(self.origin, self.favoriteenemy.origin))
		{
			wait(1);
		}
		if(isdefined(var_e8ef0e4.number))
		{
			var_e8ef0e4.number--;
		}
	}
}

