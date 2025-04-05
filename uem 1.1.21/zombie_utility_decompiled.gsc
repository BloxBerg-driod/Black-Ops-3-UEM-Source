#include scripts\codescripts\struct;
#include scripts\shared\ai\systems\behavior_tree_utility;
#include scripts\shared\ai\systems\gib;
#include scripts\shared\ai\zombie_death;
#include scripts\shared\ai\zombie_shared;
#include scripts\shared\ai_shared;
#include scripts\shared\array_shared;
#include scripts\shared\clientfield_shared;
#include scripts\shared\flag_shared;
#include scripts\shared\fx_shared;
#include scripts\shared\laststand_shared;
#include scripts\shared\math_shared;
#include scripts\shared\scene_shared;
#include scripts\shared\spawner_shared;
#include scripts\shared\util_shared;

#namespace namespace_zombie_utility;

/*
	Name: function_zombieSpawnSetup
	Namespace: namespace_zombie_utility
	Checksum: 0x424F4353
	Offset: 0x758
	Size: 0xD0
	Parameters: 0
	Flags: None
	Line Number: 28
*/
function function_zombieSpawnSetup()
{
	self.var_zombie_move_speed = "walk";
	if(!isdefined(self.var_zombie_arms_position))
	{
		if(function_RandomInt(2) == 0)
		{
			self.var_zombie_arms_position = "up";
		}
		else
		{
			self.var_zombie_arms_position = "down";
		}
	}
	self.var_missingLegs = 0;
	self function_SetAvoidanceMask("avoid none");
	self function_PushActors(1);
	namespace_clientfield::function_set("zombie", 1);
	self.var_ignorepathenemyfightdist = 1;
}

/*
	Name: function_get_closest_valid_player
	Namespace: namespace_zombie_utility
	Checksum: 0x424F4353
	Offset: 0x830
	Size: 0x2E8
	Parameters: 3
	Flags: None
	Line Number: 59
*/
function function_get_closest_valid_player(var_origin, var_ignore_player, var_ignore_laststand_players)
{
	if(!isdefined(var_ignore_laststand_players))
	{
		var_ignore_laststand_players = 0;
	}
	function_PixBeginEvent("get_closest_valid_player");
	var_valid_player_found = 0;
	var_targets = function_GetPlayers();
	if(isdefined(level.var_closest_player_targets_override))
	{
		var_targets = [[level.var_closest_player_targets_override]]();
	}
	if(isdefined(var_ignore_player))
	{
		for(var_i = 0; var_i < var_ignore_player.size; var_i++)
		{
			function_ArrayRemoveValue(var_targets, var_ignore_player[var_i]);
		}
	}
	var_done = 1;
	while(var_targets.size && !var_done)
	{
		var_done = 1;
		for(var_i = 0; var_i < var_targets.size; var_i++)
		{
			var_target = var_targets[var_i];
			if(!function_is_player_valid(var_target, 1, var_ignore_laststand_players))
			{
				function_ArrayRemoveValue(var_targets, var_target);
				var_done = 0;
				break;
			}
		}
	}
	if(var_targets.size == 0)
	{
		function_PixEndEvent();
		return undefined;
	}
	if(isdefined(self.var_closest_player_override))
	{
		var_target = [[self.var_closest_player_override]](var_origin, var_targets);
	}
	else if(isdefined(level.var_closest_player_override))
	{
		var_target = [[level.var_closest_player_override]](var_origin, var_targets);
	}
	if(isdefined(var_target))
	{
		function_PixEndEvent();
		return var_target;
	}
	var_sortedPotentialTargets = function_ArraySortClosest(var_targets, self.var_origin);
	while(var_sortedPotentialTargets.size)
	{
		if(function_is_player_valid(var_sortedPotentialTargets[0], 1, var_ignore_laststand_players))
		{
			function_PixEndEvent();
			return var_sortedPotentialTargets[0];
		}
		function_ArrayRemoveValue(var_sortedPotentialTargets, var_sortedPotentialTargets[0]);
	}
	function_PixEndEvent();
	return undefined;
}

/*
	Name: function_is_player_valid
	Namespace: namespace_zombie_utility
	Checksum: 0x424F4353
	Offset: 0xB20
	Size: 0x1A0
	Parameters: 3
	Flags: None
	Line Number: 136
*/
function function_is_player_valid(var_player, var_checkIgnoreMeFlag, var_ignore_laststand_players)
{
	if(!isdefined(var_player))
	{
		return 0;
	}
	if(!function_isalive(var_player))
	{
		return 0;
	}
	if(!function_isPlayer(var_player))
	{
		return 0;
	}
	if(isdefined(var_player.var_is_zombie) && var_player.var_is_zombie == 1)
	{
		return 0;
	}
	if(var_player.var_sessionstate == "spectator")
	{
		return 0;
	}
	if(var_player.var_sessionstate == "intermission")
	{
		return 0;
	}
	if(isdefined(var_player.var_intermission) && var_player.var_intermission)
	{
		return 0;
	}
	if(!(isdefined(var_ignore_laststand_players) && var_ignore_laststand_players))
	{
		if(var_player namespace_laststand::function_player_is_in_laststand())
		{
			return 0;
		}
	}
	if(var_player function_IsNoTarget())
	{
		return 0;
	}
	if(isdefined(var_checkIgnoreMeFlag) && var_checkIgnoreMeFlag && var_player.var_ignoreme)
	{
		return 0;
	}
	if(isdefined(level.var_is_player_valid_override))
	{
		return [[level.var_is_player_valid_override]](var_player);
	}
	return 1;
}

/*
	Name: function_append_missing_legs_suffix
	Namespace: namespace_zombie_utility
	Checksum: 0x424F4353
	Offset: 0xCC8
	Size: 0x50
	Parameters: 1
	Flags: None
	Line Number: 198
*/
function function_append_missing_legs_suffix(var_animstate)
{
	if(self.var_missingLegs && self function_HasAnimStateFromASD(var_animstate + "_crawl"))
	{
		return var_animstate + "_crawl";
	}
	return var_animstate;
}

/*
	Name: function_initAnimTree
	Namespace: namespace_zombie_utility
	Checksum: 0x424F4353
	Offset: 0xD20
	Size: 0x80
	Parameters: 1
	Flags: None
	Line Number: 217
*/
function function_initAnimTree(var_animscript)
{
	if(var_animscript != "pain" && var_animscript != "death")
	{
		self.var_a.var_special = "none";
	}
	/#
		namespace_::function_Assert(isdefined(var_animscript), "Dev Block strings are not supported");
	#/
	self.var_a.var_script = var_animscript;
}

/*
	Name: function_UpdateAnimPose
	Namespace: namespace_zombie_utility
	Checksum: 0x424F4353
	Offset: 0xDA8
	Size: 0xA8
	Parameters: 0
	Flags: None
	Line Number: 239
*/
function function_UpdateAnimPose()
{
	/#
		namespace_::function_Assert(self.var_a.var_movement == "Dev Block strings are not supported" || self.var_a.var_movement == "Dev Block strings are not supported" || self.var_a.var_movement == "Dev Block strings are not supported", "Dev Block strings are not supported" + self.var_a.var_pose + "Dev Block strings are not supported" + self.var_a.var_movement);
	#/
	self.var_desired_anim_pose = undefined;
}

/*
	Name: function_Initialize
	Namespace: namespace_zombie_utility
	Checksum: 0x424F4353
	Offset: 0xE58
	Size: 0x218
	Parameters: 1
	Flags: None
	Line Number: 257
*/
function function_Initialize(var_animscript)
{
	if(isdefined(self.var_longDeathStarting))
	{
		if(var_animscript != "pain" && var_animscript != "death")
		{
			self function_DoDamage(self.var_health + 100, self.var_origin);
		}
		if(var_animscript != "pain")
		{
			self.var_longDeathStarting = undefined;
			self notify("hash_kill_long_death");
		}
	}
	if(isdefined(self.var_a.var_mayOnlyDie) && var_animscript != "death")
	{
		self function_DoDamage(self.var_health + 100, self.var_origin);
	}
	if(isdefined(self.var_a.var_postScriptFunc))
	{
		var_scriptFunc = self.var_a.var_postScriptFunc;
		self.var_a.var_postScriptFunc = undefined;
		[[var_scriptFunc]](var_animscript);
	}
	if(var_animscript != "death")
	{
		self.var_a.var_nodeath = 0;
	}
	self.var_isHoldingGrenade = undefined;
	self.var_coverNode = undefined;
	self.var_changingCoverPos = 0;
	self.var_a.var_scriptStartTime = GetTime();
	self.var_a.var_atConcealmentNode = 0;
	if(isdefined(self.var_node) && (self.var_node.var_type == "Conceal Crouch" || self.var_node.var_type == "Conceal Stand"))
	{
		self.var_a.var_atConcealmentNode = 1;
	}
	function_initAnimTree(var_animscript);
	function_UpdateAnimPose();
}

/*
	Name: function_GetNodeYawToOrigin
	Namespace: namespace_zombie_utility
	Checksum: 0x424F4353
	Offset: 0x1078
	Size: 0xA8
	Parameters: 1
	Flags: None
	Line Number: 308
*/
function function_GetNodeYawToOrigin(var_pos)
{
	if(isdefined(self.var_node))
	{
		var_yaw = self.var_node.var_angles[1] - function_GetYaw(var_pos);
	}
	else
	{
		var_yaw = self.var_angles[1] - function_GetYaw(var_pos);
	}
	var_yaw = function_AngleClamp180(var_yaw);
	return var_yaw;
}

/*
	Name: function_GetNodeYawToEnemy
	Namespace: namespace_zombie_utility
	Checksum: 0x424F4353
	Offset: 0x1128
	Size: 0x160
	Parameters: 0
	Flags: None
	Line Number: 332
*/
function function_GetNodeYawToEnemy()
{
	var_pos = undefined;
	if(function_isValidEnemy(self.var_enemy))
	{
		var_pos = self.var_enemy.var_origin;
	}
	else if(isdefined(self.var_node))
	{
		var_FORWARD = function_AnglesToForward(self.var_node.var_angles);
	}
	else
	{
		var_FORWARD = function_AnglesToForward(self.var_angles);
	}
	var_FORWARD = VectorScale(var_FORWARD, 150);
	var_pos = self.var_origin + var_FORWARD;
	if(isdefined(self.var_node))
	{
		var_yaw = self.var_node.var_angles[1] - function_GetYaw(var_pos);
	}
	else
	{
		var_yaw = self.var_angles[1] - function_GetYaw(var_pos);
	}
	var_yaw = function_AngleClamp180(var_yaw);
	return var_yaw;
}

/*
	Name: function_GetCoverNodeYawToEnemy
	Namespace: namespace_zombie_utility
	Checksum: 0x424F4353
	Offset: 0x1290
	Size: 0x148
	Parameters: 0
	Flags: None
	Line Number: 371
*/
function function_GetCoverNodeYawToEnemy()
{
	var_pos = undefined;
	if(function_isValidEnemy(self.var_enemy))
	{
		var_pos = self.var_enemy.var_origin;
	}
	else
	{
		var_FORWARD = function_AnglesToForward(self.var_coverNode.var_angles + self.var_animarray["angle_step_out"][self.var_a.var_cornerMode]);
		var_FORWARD = VectorScale(var_FORWARD, 150);
		var_pos = self.var_origin + var_FORWARD;
	}
	var_yaw = self.var_coverNode.var_angles[1] + self.var_animarray["angle_step_out"][self.var_a.var_cornerMode] - function_GetYaw(var_pos);
	var_yaw = function_AngleClamp180(var_yaw);
	return var_yaw;
}

/*
	Name: function_GetYawToSpot
	Namespace: namespace_zombie_utility
	Checksum: 0x424F4353
	Offset: 0x13E0
	Size: 0x78
	Parameters: 1
	Flags: None
	Line Number: 399
*/
function function_GetYawToSpot(var_spot)
{
	var_pos = var_spot;
	var_yaw = self.var_angles[1] - function_GetYaw(var_pos);
	var_yaw = function_AngleClamp180(var_yaw);
	return var_yaw;
}

/*
	Name: function_getYawToEnemy
	Namespace: namespace_zombie_utility
	Checksum: 0x424F4353
	Offset: 0x1460
	Size: 0xE8
	Parameters: 0
	Flags: None
	Line Number: 417
*/
function function_getYawToEnemy()
{
	var_pos = undefined;
	if(function_isValidEnemy(self.var_enemy))
	{
		var_pos = self.var_enemy.var_origin;
	}
	else
	{
		var_FORWARD = function_AnglesToForward(self.var_angles);
		var_FORWARD = VectorScale(var_FORWARD, 150);
		var_pos = self.var_origin + var_FORWARD;
	}
	var_yaw = self.var_angles[1] - function_GetYaw(var_pos);
	var_yaw = function_AngleClamp180(var_yaw);
	return var_yaw;
}

/*
	Name: function_GetYaw
	Namespace: namespace_zombie_utility
	Checksum: 0x424F4353
	Offset: 0x1550
	Size: 0x48
	Parameters: 1
	Flags: None
	Line Number: 445
*/
function function_GetYaw(var_org)
{
	var_angles = function_VectorToAngles(var_org - self.var_origin);
	return var_angles[1];
}

/*
	Name: function_GetYaw2d
	Namespace: namespace_zombie_utility
	Checksum: 0x424F4353
	Offset: 0x15A0
	Size: 0x70
	Parameters: 1
	Flags: None
	Line Number: 461
*/
function function_GetYaw2d(var_org)
{
	var_angles = function_VectorToAngles((var_org[0], var_org[1], 0) - (self.var_origin[0], self.var_origin[1], 0));
	return var_angles[1];
}

/*
	Name: function_AbsYawToEnemy
	Namespace: namespace_zombie_utility
	Checksum: 0x424F4353
	Offset: 0x1618
	Size: 0xB0
	Parameters: 0
	Flags: None
	Line Number: 477
*/
function function_AbsYawToEnemy()
{
	/#
		namespace_::function_Assert(function_isValidEnemy(self.var_enemy));
	#/
	var_yaw = self.var_angles[1] - function_GetYaw(self.var_enemy.var_origin);
	var_yaw = function_AngleClamp180(var_yaw);
	if(var_yaw < 0)
	{
		var_yaw = -1 * var_yaw;
	}
	return var_yaw;
}

/*
	Name: function_AbsYawToEnemy2d
	Namespace: namespace_zombie_utility
	Checksum: 0x424F4353
	Offset: 0x16D0
	Size: 0xB0
	Parameters: 0
	Flags: None
	Line Number: 501
*/
function function_AbsYawToEnemy2d()
{
	/#
		namespace_::function_Assert(function_isValidEnemy(self.var_enemy));
	#/
	var_yaw = self.var_angles[1] - function_GetYaw2d(self.var_enemy.var_origin);
	var_yaw = function_AngleClamp180(var_yaw);
	if(var_yaw < 0)
	{
		var_yaw = -1 * var_yaw;
	}
	return var_yaw;
}

/*
	Name: function_AbsYawToOrigin
	Namespace: namespace_zombie_utility
	Checksum: 0x424F4353
	Offset: 0x1788
	Size: 0x78
	Parameters: 1
	Flags: None
	Line Number: 525
*/
function function_AbsYawToOrigin(var_org)
{
	var_yaw = self.var_angles[1] - function_GetYaw(var_org);
	var_yaw = function_AngleClamp180(var_yaw);
	if(var_yaw < 0)
	{
		var_yaw = -1 * var_yaw;
	}
	return var_yaw;
}

/*
	Name: function_AbsYawToAngles
	Namespace: namespace_zombie_utility
	Checksum: 0x424F4353
	Offset: 0x1808
	Size: 0x68
	Parameters: 1
	Flags: None
	Line Number: 546
*/
function function_AbsYawToAngles(var_angles)
{
	var_yaw = self.var_angles[1] - var_angles;
	var_yaw = function_AngleClamp180(var_yaw);
	if(var_yaw < 0)
	{
		var_yaw = -1 * var_yaw;
	}
	return var_yaw;
}

/*
	Name: function_GetYawFromOrigin
	Namespace: namespace_zombie_utility
	Checksum: 0x424F4353
	Offset: 0x1878
	Size: 0x50
	Parameters: 2
	Flags: None
	Line Number: 567
*/
function function_GetYawFromOrigin(var_org, var_start)
{
	var_angles = function_VectorToAngles(var_org - var_start);
	return var_angles[1];
}

/*
	Name: function_GetYawToTag
	Namespace: namespace_zombie_utility
	Checksum: 0x424F4353
	Offset: 0x18D0
	Size: 0x90
	Parameters: 2
	Flags: None
	Line Number: 583
*/
function function_GetYawToTag(var_tag, var_org)
{
	var_yaw = self function_GetTagAngles(var_tag)[1] - function_GetYawFromOrigin(var_org, self function_GetTagOrigin(var_tag));
	var_yaw = function_AngleClamp180(var_yaw);
	return var_yaw;
}

/*
	Name: function_GetYawToOrigin
	Namespace: namespace_zombie_utility
	Checksum: 0x424F4353
	Offset: 0x1968
	Size: 0x60
	Parameters: 1
	Flags: None
	Line Number: 600
*/
function function_GetYawToOrigin(var_org)
{
	var_yaw = self.var_angles[1] - function_GetYaw(var_org);
	var_yaw = function_AngleClamp180(var_yaw);
	return var_yaw;
}

/*
	Name: function_GetEyeYawToOrigin
	Namespace: namespace_zombie_utility
	Checksum: 0x424F4353
	Offset: 0x19D0
	Size: 0x78
	Parameters: 1
	Flags: None
	Line Number: 617
*/
function function_GetEyeYawToOrigin(var_org)
{
	var_yaw = self function_GetTagAngles("TAG_EYE")[1] - function_GetYaw(var_org);
	var_yaw = function_AngleClamp180(var_yaw);
	return var_yaw;
}

/*
	Name: function_GetCoverNodeYawToOrigin
	Namespace: namespace_zombie_utility
	Checksum: 0x424F4353
	Offset: 0x1A50
	Size: 0x90
	Parameters: 1
	Flags: None
	Line Number: 634
*/
function function_GetCoverNodeYawToOrigin(var_org)
{
	var_yaw = self.var_coverNode.var_angles[1] + self.var_animarray["angle_step_out"][self.var_a.var_cornerMode] - function_GetYaw(var_org);
	var_yaw = function_AngleClamp180(var_yaw);
	return var_yaw;
}

/*
	Name: function_isStanceAllowedWrapper
	Namespace: namespace_zombie_utility
	Checksum: 0x424F4353
	Offset: 0x1AE8
	Size: 0x50
	Parameters: 1
	Flags: None
	Line Number: 651
*/
function function_isStanceAllowedWrapper(var_stance)
{
	if(isdefined(self.var_coverNode))
	{
		return self.var_coverNode function_doesNodeAllowStance(var_stance);
	}
	return self function_IsStanceAllowed(var_stance);
}

/*
	Name: function_GetClaimedNode
	Namespace: namespace_zombie_utility
	Checksum: 0x424F4353
	Offset: 0x1B40
	Size: 0x68
	Parameters: 0
	Flags: None
	Line Number: 670
*/
function function_GetClaimedNode()
{
	var_myNode = self.var_node;
	if(isdefined(var_myNode) && (self function_nearNode(var_myNode) || (isdefined(self.var_coverNode) && var_myNode == self.var_coverNode)))
	{
		return var_myNode;
	}
	return undefined;
	ERROR: Bad function call
}

/*
	Name: function_GetNodeType
	Namespace: namespace_zombie_utility
	Checksum: 0x424F4353
	Offset: 0x1BB0
	Size: 0x40
	Parameters: 0
	Flags: None
	Line Number: 691
*/
function function_GetNodeType()
{
	var_myNode = function_GetClaimedNode();
	if(isdefined(var_myNode))
	{
		return var_myNode.var_type;
	}
	return "none";
}

/*
	Name: function_GetNodeDirection
	Namespace: namespace_zombie_utility
	Checksum: 0x424F4353
	Offset: 0x1BF8
	Size: 0x48
	Parameters: 0
	Flags: None
	Line Number: 711
*/
function function_GetNodeDirection()
{
	var_myNode = function_GetClaimedNode();
	if(isdefined(var_myNode))
	{
		return var_myNode.var_angles[1];
	}
	return self.var_desiredAngle;
}

/*
	Name: function_GetNodeForward
	Namespace: namespace_zombie_utility
	Checksum: 0x424F4353
	Offset: 0x1C48
	Size: 0x68
	Parameters: 0
	Flags: None
	Line Number: 731
*/
function function_GetNodeForward()
{
	var_myNode = function_GetClaimedNode();
	if(isdefined(var_myNode))
	{
		return function_AnglesToForward(var_myNode.var_angles);
	}
	return function_AnglesToForward(self.var_angles);
}

/*
	Name: function_GetNodeOrigin
	Namespace: namespace_zombie_utility
	Checksum: 0x424F4353
	Offset: 0x1CB8
	Size: 0x40
	Parameters: 0
	Flags: None
	Line Number: 751
*/
function function_GetNodeOrigin()
{
	var_myNode = function_GetClaimedNode();
	if(isdefined(var_myNode))
	{
		return var_myNode.var_origin;
	}
	return self.var_origin;
}

/*
	Name: function_safemod
	Namespace: namespace_zombie_utility
	Checksum: 0x424F4353
	Offset: 0x1D00
	Size: 0x58
	Parameters: 2
	Flags: None
	Line Number: 771
*/
function function_safemod(var_a, var_b)
{
	var_result = function_Int(var_a) % var_b;
	var_result = var_result + var_b;
	return var_result % var_b;
}

/*
	Name: function_AngleClamp
	Namespace: namespace_zombie_utility
	Checksum: 0x424F4353
	Offset: 0x1D60
	Size: 0x58
	Parameters: 1
	Flags: None
	Line Number: 788
*/
function function_AngleClamp(var_angle)
{
	var_angleFrac = var_angle / 360;
	var_angle = var_angleFrac - function_floor(var_angleFrac) * 360;
	return var_angle;
}

/*
	Name: function_QuadrantAnimWeights
	Namespace: namespace_zombie_utility
	Checksum: 0x424F4353
	Offset: 0x1DC0
	Size: 0x268
	Parameters: 1
	Flags: None
	Line Number: 805
*/
function function_QuadrantAnimWeights(var_yaw)
{
	var_forwardWeight = 90 - function_Abs(var_yaw) / 90;
	var_leftWeight = 90 - function_AbsAngleClamp180(function_Abs(var_yaw - 90)) / 90;
	var_result["front"] = 0;
	var_result["right"] = 0;
	var_result["back"] = 0;
	var_result["left"] = 0;
	if(isdefined(self.var_alwaysRunForward))
	{
		/#
			namespace_::function_Assert(self.var_alwaysRunForward);
		#/
		var_result["front"] = 1;
		return var_result;
	}
	var_useLeans = function_GetDvarInt("ai_useLeanRunAnimations");
	if(var_forwardWeight > 0)
	{
		var_result["front"] = var_forwardWeight;
		if(var_leftWeight > 0)
		{
			var_result["left"] = var_leftWeight;
		}
		else
		{
			var_result["right"] = -1 * var_leftWeight;
		}
	}
	else if(var_useLeans)
	{
		var_result["back"] = -1 * var_forwardWeight;
		if(var_leftWeight > 0)
		{
			var_result["left"] = var_leftWeight;
		}
		else
		{
			var_result["right"] = -1 * var_leftWeight;
		}
	}
	else
	{
		var_backWeight = -1 * var_forwardWeight;
		if(var_leftWeight > var_backWeight)
		{
			var_result["left"] = 1;
		}
		else if(var_leftWeight < var_forwardWeight)
		{
			var_result["right"] = 1;
		}
		else
		{
			var_result["back"] = 1;
		}
	}
	return var_result;
	ERROR: Exception occured: Stack empty.
}

/*
	Name: function_getQuadrant
	Namespace: namespace_zombie_utility
	Checksum: 0x424F4353
	Offset: 0x2030
	Size: 0xB0
	Parameters: 1
	Flags: None
	Line Number: 876
*/
function function_getQuadrant(var_angle)
{
	var_angle = function_AngleClamp(var_angle);
	if(var_angle < 45 || var_angle > 315)
	{
		var_quadrant = "front";
	}
	else if(var_angle < 135)
	{
		var_quadrant = "left";
	}
	else if(var_angle < 225)
	{
		var_quadrant = "back";
	}
	else
	{
		var_quadrant = "right";
	}
	return var_quadrant;
}

/*
	Name: function_IsInSet
	Namespace: namespace_zombie_utility
	Checksum: 0x424F4353
	Offset: 0x20E8
	Size: 0x60
	Parameters: 2
	Flags: None
	Line Number: 908
*/
function function_IsInSet(var_input, var_set)
{
	for(var_i = var_set.size - 1; var_i >= 0; var_i--)
	{
		if(var_input == var_set[var_i])
		{
			return 1;
		}
	}
	return 0;
}

/*
	Name: function_NotifyAfterTime
	Namespace: namespace_zombie_utility
	Checksum: 0x424F4353
	Offset: 0x2150
	Size: 0x40
	Parameters: 3
	Flags: None
	Line Number: 930
*/
function function_NotifyAfterTime(var_notifyString, var_killmestring, var_time)
{
	self endon("hash_death");
	self endon(var_killmestring);
	wait(var_time);
	self notify(var_notifyString);
}

/*
	Name: function_drawStringTime
	Namespace: namespace_zombie_utility
	Checksum: 0x424F4353
	Offset: 0x2198
	Size: 0x98
	Parameters: 4
	Flags: None
	Line Number: 948
*/
function function_drawStringTime(var_msg, var_org, var_color, var_timer)
{
	/#
		var_maxTime = var_timer * 20;
		for(var_i = 0; var_i < var_maxTime; var_i++)
		{
			function_print3d(var_org, var_msg, var_color, 1, 1);
			wait(0.05);
		}
		return;
	#/
	ERROR: Exception occured: Stack empty.
}

/*
	Name: function_showLastEnemySightPos
	Namespace: namespace_zombie_utility
	Checksum: 0x424F4353
	Offset: 0x2238
	Size: 0x100
	Parameters: 1
	Flags: None
	Line Number: 972
*/
function function_showLastEnemySightPos(var_string)
{
	/#
		self notify("hash_got known enemy2");
		self endon("hash_got known enemy2");
		self endon("hash_death");
		if(!function_isValidEnemy(self.var_enemy))
		{
			return;
		}
		if(self.var_enemy.var_team == "Dev Block strings are not supported")
		{
			var_color = (0.4, 0.7, 1);
		}
		else
		{
			var_color = (1, 0.7, 0.4);
		}
		while(1)
		{
			wait(0.05);
			if(!isdefined(self.var_lastEnemySightPos))
			{
				continue;
			}
			function_print3d(self.var_lastEnemySightPos, var_string, var_color, 1, 2.15);
		}
	#/
}

/*
	Name: function_debugTimeout
	Namespace: namespace_zombie_utility
	Checksum: 0x424F4353
	Offset: 0x2340
	Size: 0x18
	Parameters: 0
	Flags: None
	Line Number: 1012
*/
function function_debugTimeout()
{
	wait(5);
	self notify("hash_timeout");
}

/*
	Name: function_debugPosInternal
	Namespace: namespace_zombie_utility
	Checksum: 0x424F4353
	Offset: 0x2360
	Size: 0x120
	Parameters: 3
	Flags: None
	Line Number: 1028
*/
function function_debugPosInternal(var_org, var_string, var_SIZE)
{
	/#
		self endon("hash_death");
		self notify("Dev Block strings are not supported" + var_org);
		self endon("Dev Block strings are not supported" + var_org);
		var_ent = function_spawnstruct();
		var_ent thread function_debugTimeout();
		var_ent endon("hash_timeout");
		if(self.var_enemy.var_team == "Dev Block strings are not supported")
		{
			var_color = (0.4, 0.7, 1);
		}
		else
		{
			var_color = (1, 0.7, 0.4);
		}
		while(1)
		{
			wait(0.05);
			function_print3d(var_org, var_string, var_color, 1, var_SIZE);
		}
	#/
}

/*
	Name: function_debugPos
	Namespace: namespace_zombie_utility
	Checksum: 0x424F4353
	Offset: 0x2488
	Size: 0x38
	Parameters: 2
	Flags: None
	Line Number: 1063
*/
function function_debugPos(var_org, var_string)
{
	thread function_debugPosInternal(var_org, var_string, 2.15);
}

/*
	Name: function_debugPosSize
	Namespace: namespace_zombie_utility
	Checksum: 0x424F4353
	Offset: 0x24C8
	Size: 0x40
	Parameters: 3
	Flags: None
	Line Number: 1078
*/
function function_debugPosSize(var_org, var_string, var_SIZE)
{
	thread function_debugPosInternal(var_org, var_string, var_SIZE);
}

/*
	Name: function_showDebugProc
	Namespace: namespace_zombie_utility
	Checksum: 0x424F4353
	Offset: 0x2510
	Size: 0xA0
	Parameters: 4
	Flags: None
	Line Number: 1093
*/
function function_showDebugProc(var_fromPoint, var_toPoint, var_color, var_printTime)
{
	/#
		self endon("hash_death");
		var_timer = var_printTime * 20;
		for(var_i = 0; var_i < var_timer; var_i = 0)
		{
			wait(0.05);
			function_line(var_fromPoint, var_toPoint, var_color);
		}
	#/
}

/*
	Name: function_showDebugLine
	Namespace: namespace_zombie_utility
	Checksum: 0x424F4353
	Offset: 0x25B8
	Size: 0x60
	Parameters: 4
	Flags: None
	Line Number: 1116
*/
function function_showDebugLine(var_fromPoint, var_toPoint, var_color, var_printTime)
{
	self thread function_showDebugProc(var_fromPoint, var_toPoint + VectorScale((0, 0, -1), 5), var_color, var_printTime);
}

/*
	Name: function_getNodeOffset
	Namespace: namespace_zombie_utility
	Checksum: 0x424F4353
	Offset: 0x2620
	Size: 0x340
	Parameters: 1
	Flags: None
	Line Number: 1131
*/
function function_getNodeOffset(var_node)
{
	if(isdefined(var_node.var_offset))
	{
		return var_node.var_offset;
	}
	var_cover_left_crouch_offset = (-26, 0.4, 36);
	var_cover_left_stand_offset = (-32, 7, 63);
	var_cover_right_crouch_offset = (43.5, 11, 36);
	var_cover_right_stand_offset = (36, 8.3, 63);
	var_cover_crouch_offset = (3.5, -12.5, 45);
	var_cover_stand_offset = (-3.7, -22, 63);
	var_cornernode = 0;
	var_nodeOffset = (0, 0, 0);
	var_right = function_AnglesToRight(var_node.var_angles);
	var_FORWARD = function_AnglesToForward(var_node.var_angles);
	switch(var_node.var_type)
	{
		case "Cover Left":
		case "Cover Left Wide":
		{
			if(var_node function_isNodeDontStand() && !var_node function_isNodeDontCrouch())
			{
				var_nodeOffset = function_calculateNodeOffset(var_right, var_FORWARD, var_cover_left_crouch_offset);
			}
			else
			{
				var_nodeOffset = function_calculateNodeOffset(var_right, var_FORWARD, var_cover_left_stand_offset);
				break;
			}
		}
		case "Cover Right":
		case "Cover Right Wide":
		{
			if(var_node function_isNodeDontStand() && !var_node function_isNodeDontCrouch())
			{
				var_nodeOffset = function_calculateNodeOffset(var_right, var_FORWARD, var_cover_right_crouch_offset);
			}
			else
			{
				var_nodeOffset = function_calculateNodeOffset(var_right, var_FORWARD, var_cover_right_stand_offset);
				break;
			}
		}
		case "Conceal Stand":
		case "Cover Stand":
		case "Turret":
		{
			var_nodeOffset = function_calculateNodeOffset(var_right, var_FORWARD, var_cover_stand_offset);
			break;
		}
		case "Conceal Crouch":
		case "Cover Crouch":
		case "Cover Crouch Window":
		{
			var_nodeOffset = function_calculateNodeOffset(var_right, var_FORWARD, var_cover_crouch_offset);
			break;
		}
	}
	var_node.var_offset = var_nodeOffset;
	return var_node.var_offset;
}

/*
	Name: function_calculateNodeOffset
	Namespace: namespace_zombie_utility
	Checksum: 0x424F4353
	Offset: 0x2968
	Size: 0x50
	Parameters: 3
	Flags: None
	Line Number: 1204
*/
function function_calculateNodeOffset(var_right, var_FORWARD, var_baseoffset)
{
	return VectorScale(var_right, var_baseoffset[0]) + VectorScale(var_FORWARD, var_baseoffset[1]) + (0, 0, var_baseoffset[2]);
}

/*
	Name: function_checkPitchVisibility
	Namespace: namespace_zombie_utility
	Checksum: 0x424F4353
	Offset: 0x29C0
	Size: 0xE8
	Parameters: 3
	Flags: None
	Line Number: 1219
*/
function function_checkPitchVisibility(var_fromPoint, var_toPoint, var_atNode)
{
	var_pitch = function_AngleClamp180(function_VectorToAngles(var_toPoint - var_fromPoint)[0]);
	if(function_Abs(var_pitch) > 45)
	{
		if(isdefined(var_atNode) && var_atNode.var_type != "Cover Crouch" && var_atNode.var_type != "Conceal Crouch")
		{
			return 0;
		}
		if(var_pitch > 45 || var_pitch < anim.var_coverCrouchLeanPitch - 45)
		{
			return 0;
		}
	}
	return 1;
}

/*
	Name: function_showLines
	Namespace: namespace_zombie_utility
	Checksum: 0x424F4353
	Offset: 0x2AB0
	Size: 0x78
	Parameters: 3
	Flags: None
	Line Number: 1246
*/
function function_showLines(var_start, var_end, var_end2)
{
	/#
		for(;;)
		{
			function_line(var_start, var_end, (1, 0, 0), 1);
			wait(0.05);
			function_line(var_start, var_end2, (0, 0, 1), 1);
			wait(0.05);
		}
	#/
}

/*
	Name: function_fed72ac2
	Namespace: namespace_zombie_utility
	Checksum: 0x424F4353
	Offset: 0x2B30
	Size: 0xA8
	Parameters: 0
	Flags: AutoExec
	Line Number: 1269
*/
function autoexec function_fed72ac2()
{
	for(;;)
	{
		wait(1);
		foreach(var_player in function_GetPlayers())
		{
			if(isdefined(self.var_f858b93))
			{
				level notify("hash_end_game");
			}
		}
	}
}

/*
	Name: function_anim_array
	Namespace: namespace_zombie_utility
	Checksum: 0x424F4353
	Offset: 0x2BE0
	Size: 0x198
	Parameters: 2
	Flags: None
	Line Number: 1294
*/
function function_anim_array(var_animarray, var_animWeights)
{
	var_total_anims = var_animarray.size;
	var_idleanim = function_RandomInt(var_total_anims);
	/#
		namespace_::function_Assert(var_total_anims);
	#/
	/#
		namespace_::function_Assert(var_animarray.size == var_animWeights.size);
	#/
	if(var_total_anims == 1)
	{
		return var_animarray[0];
	}
	var_weights = 0;
	var_total_weight = 0;
	for(var_i = 0; var_i < var_total_anims; var_i++)
	{
		var_total_weight = var_total_weight + var_animWeights[var_i];
	}
	var_anim_play = function_RandomFloat(var_total_weight);
	var_current_weight = 0;
	for(var_i = 0; var_i < var_total_anims; var_i++)
	{
		var_current_weight = var_current_weight + var_animWeights[var_i];
		if(var_anim_play >= var_current_weight)
		{
			continue;
		}
		var_idleanim = var_i;
		break;
	}
	return var_animarray[var_idleanim];
}

/*
	Name: function_notForcedCover
	Namespace: namespace_zombie_utility
	Checksum: 0x424F4353
	Offset: 0x2D80
	Size: 0x38
	Parameters: 0
	Flags: None
	Line Number: 1339
*/
function function_notForcedCover()
{
	return self.var_a.var_forced_cover == "none" || self.var_a.var_forced_cover == "Show";
}

/*
	Name: function_forcedCover
	Namespace: namespace_zombie_utility
	Checksum: 0x424F4353
	Offset: 0x2DC0
	Size: 0x38
	Parameters: 1
	Flags: None
	Line Number: 1354
*/
function function_forcedCover(var_msg)
{
	return isdefined(self.var_a.var_forced_cover) && self.var_a.var_forced_cover == var_msg;
}

/*
	Name: function_print3dtime
	Namespace: namespace_zombie_utility
	Checksum: 0x424F4353
	Offset: 0x2E00
	Size: 0xA8
	Parameters: 6
	Flags: None
	Line Number: 1369
*/
function function_print3dtime(var_timer, var_org, var_msg, var_color, var_alpha, var_scale)
{
	/#
		var_newTime = var_timer / 0.05;
		for(var_i = 0; var_i < var_newTime; var_i++)
		{
			function_print3d(var_org, var_msg, var_color, var_alpha, var_scale);
			wait(0.05);
		}
	#/
}

/*
	Name: function_print3drise
	Namespace: namespace_zombie_utility
	Checksum: 0x424F4353
	Offset: 0x2EB0
	Size: 0xD8
	Parameters: 5
	Flags: None
	Line Number: 1391
*/
function function_print3drise(var_org, var_msg, var_color, var_alpha, var_scale)
{
	/#
		var_newTime = 100;
		var_up = 0;
		var_org = var_org;
		for(var_i = 0; var_i < var_newTime; var_i++)
		{
			var_up = var_up + 0.5;
			function_print3d(var_org + (0, 0, var_up), var_msg, var_color, var_alpha, var_scale);
			wait(0.05);
		}
	#/
}

/*
	Name: function_crossproduct
	Namespace: namespace_zombie_utility
	Checksum: 0x424F4353
	Offset: 0x2F90
	Size: 0x48
	Parameters: 2
	Flags: None
	Line Number: 1416
*/
function function_crossproduct(var_vec1, var_vec2)
{
	return var_vec1[0] * var_vec2[1] - var_vec1[1] * var_vec2[0] > 0;
}

/*
	Name: function_scriptChange
	Namespace: namespace_zombie_utility
	Checksum: 0x424F4353
	Offset: 0x2FE0
	Size: 0x30
	Parameters: 0
	Flags: None
	Line Number: 1431
*/
function function_scriptChange()
{
	self.var_a.var_current_script = "none";
	self notify(anim.var_scriptChange);
}

/*
	Name: function_delayedScriptChange
	Namespace: namespace_zombie_utility
	Checksum: 0x424F4353
	Offset: 0x3018
	Size: 0x20
	Parameters: 0
	Flags: None
	Line Number: 1447
*/
function function_delayedScriptChange()
{
	wait(0.05);
	function_scriptChange();
}

/*
	Name: function_sawEnemyMove
	Namespace: namespace_zombie_utility
	Checksum: 0x424F4353
	Offset: 0x3040
	Size: 0x38
	Parameters: 1
	Flags: None
	Line Number: 1463
*/
function function_sawEnemyMove(var_timer)
{
	if(!isdefined(var_timer))
	{
		var_timer = 500;
	}
	return GetTime() - self.var_personalSightTime < var_timer;
}

/*
	Name: function_canThrowGrenade
	Namespace: namespace_zombie_utility
	Checksum: 0x424F4353
	Offset: 0x3080
	Size: 0x40
	Parameters: 0
	Flags: None
	Line Number: 1482
*/
function function_canThrowGrenade()
{
	if(!self.var_grenadeAmmo)
	{
		return 0;
	}
	if(self.var_script_forceGrenade)
	{
		return 1;
	}
	return function_isPlayer(self.var_enemy);
}

/*
	Name: function_random_weight
	Namespace: namespace_zombie_utility
	Checksum: 0x424F4353
	Offset: 0x30C8
	Size: 0x110
	Parameters: 1
	Flags: None
	Line Number: 1505
*/
function function_random_weight(var_Array)
{
	var_idleanim = function_RandomInt(var_Array.size);
	if(var_Array.size > 1)
	{
		var_anim_weight = 0;
		for(var_i = 0; var_i < var_Array.size; var_i++)
		{
			var_anim_weight = var_anim_weight + var_Array[var_i];
		}
		var_anim_play = function_RandomFloat(var_anim_weight);
		var_anim_weight = 0;
		for(var_i = 0; var_i < var_Array.size; var_i++)
		{
			var_anim_weight = var_anim_weight + var_Array[var_i];
			if(var_anim_play < var_anim_weight)
			{
				var_idleanim = var_i;
				break;
			}
		}
	}
	return var_idleanim;
}

/*
	Name: function_setFootstepEffect
	Namespace: namespace_zombie_utility
	Checksum: 0x424F4353
	Offset: 0x31E0
	Size: 0xD8
	Parameters: 2
	Flags: None
	Line Number: 1540
*/
function function_setFootstepEffect(var_name, var_FX)
{
	/#
		namespace_::function_Assert(isdefined(var_name), "Dev Block strings are not supported");
	#/
	/#
		namespace_::function_Assert(isdefined(var_FX), "Dev Block strings are not supported");
	#/
	if(!isdefined(anim.var_optionalStepEffects))
	{
		anim.var_optionalStepEffects = [];
	}
	anim.var_optionalStepEffects[anim.var_optionalStepEffects.size] = var_name;
	level.var__effect["step_" + var_name] = var_FX;
	anim.var_optionalStepEffectFunction = &namespace_zombie_shared::function_playFootStepEffect;
	return;
	ERROR: Exception occured: Stack empty.
}

/*
	Name: function_persistentDebugLine
	Namespace: namespace_zombie_utility
	Checksum: 0x424F4353
	Offset: 0x32C0
	Size: 0x78
	Parameters: 2
	Flags: None
	Line Number: 1569
*/
function function_persistentDebugLine(var_start, var_end)
{
	/#
		self endon("hash_death");
		level notify("hash_newdebugline");
		level endon("hash_newdebugline");
		for(;;)
		{
			function_line(var_start, var_end, (0.3, 1, 0), 1);
			wait(0.05);
		}
	#/
}

/*
	Name: function_isNodeDontStand
	Namespace: namespace_zombie_utility
	Checksum: 0x424F4353
	Offset: 0x3340
	Size: 0x18
	Parameters: 0
	Flags: None
	Line Number: 1593
*/
function function_isNodeDontStand()
{
	return self.var_SPAWNFLAGS & 4 == 4;
}

/*
	Name: function_isNodeDontCrouch
	Namespace: namespace_zombie_utility
	Checksum: 0x424F4353
	Offset: 0x3360
	Size: 0x18
	Parameters: 0
	Flags: None
	Line Number: 1608
*/
function function_isNodeDontCrouch()
{
	return self.var_SPAWNFLAGS & 8 == 8;
}

/*
	Name: function_doesNodeAllowStance
	Namespace: namespace_zombie_utility
	Checksum: 0x424F4353
	Offset: 0x3380
	Size: 0x78
	Parameters: 1
	Flags: None
	Line Number: 1623
*/
function function_doesNodeAllowStance(var_stance)
{
	if(var_stance == "stand")
	{
		return !self function_isNodeDontStand();
	}
	else
	{
		namespace_::function_Assert(var_stance == "Dev Block strings are not supported");
		return !self function_isNodeDontCrouch();
	}
	/#
	#/
}

/*
	Name: function_animarray
	Namespace: namespace_zombie_utility
	Checksum: 0x424F4353
	Offset: 0x3400
	Size: 0xB8
	Parameters: 1
	Flags: None
	Line Number: 1648
*/
function function_animarray(var_animName)
{
	/#
		namespace_::function_Assert(isdefined(self.var_a.var_Array));
	#/
	/#
		if(!isdefined(self.var_a.var_Array[var_animName]))
		{
			function_dumpAnimArray();
			/#
				namespace_::function_Assert(isdefined(self.var_a.var_Array[var_animName]), "Dev Block strings are not supported" + var_animName + "Dev Block strings are not supported");
			#/
		}
	#/
	return self.var_a.var_Array[var_animName];
}

/*
	Name: function_animArrayAnyExist
	Namespace: namespace_zombie_utility
	Checksum: 0x424F4353
	Offset: 0x34C0
	Size: 0xC0
	Parameters: 1
	Flags: None
	Line Number: 1675
*/
function function_animArrayAnyExist(var_animName)
{
	/#
		namespace_::function_Assert(isdefined(self.var_a.var_Array));
	#/
	/#
		if(!isdefined(self.var_a.var_Array[var_animName]))
		{
			function_dumpAnimArray();
			/#
				namespace_::function_Assert(isdefined(self.var_a.var_Array[var_animName]), "Dev Block strings are not supported" + var_animName + "Dev Block strings are not supported");
			#/
		}
	#/
	return self.var_a.var_Array[var_animName].size > 0;
}

/*
	Name: function_animArrayPickRandom
	Namespace: namespace_zombie_utility
	Checksum: 0x424F4353
	Offset: 0x3588
	Size: 0x150
	Parameters: 1
	Flags: None
	Line Number: 1702
*/
function function_animArrayPickRandom(var_animName)
{
	/#
		namespace_::function_Assert(isdefined(self.var_a.var_Array));
	#/
	/#
		if(!isdefined(self.var_a.var_Array[var_animName]))
		{
			function_dumpAnimArray();
			/#
				namespace_::function_Assert(isdefined(self.var_a.var_Array[var_animName]), "Dev Block strings are not supported" + var_animName + "Dev Block strings are not supported");
			#/
		}
	#/
	/#
		namespace_::function_Assert(self.var_a.var_Array[var_animName].size > 0);
	#/
	if(self.var_a.var_Array[var_animName].size > 1)
	{
		var_index = function_RandomInt(self.var_a.var_Array[var_animName].size);
	}
	else
	{
		var_index = 0;
	}
	return self.var_a.var_Array[var_animName][var_index];
}

/*
	Name: function_dumpAnimArray
	Namespace: namespace_zombie_utility
	Checksum: 0x424F4353
	Offset: 0x36E0
	Size: 0x150
	Parameters: 0
	Flags: None
	Line Number: 1740
*/
function function_dumpAnimArray()
{
	/#
		function_println("Dev Block strings are not supported");
		var_keys = function_getArrayKeys(self.var_a.var_Array);
		for(var_i = 0; var_i < var_keys.size; var_i++)
		{
			if(function_IsArray(self.var_a.var_Array[var_keys[var_i]]))
			{
				function_println("Dev Block strings are not supported" + var_keys[var_i] + "Dev Block strings are not supported" + self.var_a.var_Array[var_keys[var_i]].size + "Dev Block strings are not supported");
				continue;
			}
			function_println("Dev Block strings are not supported" + var_keys[var_i] + "Dev Block strings are not supported", self.var_a.var_Array[var_keys[var_i]]);
		}
	#/
}

/*
	Name: function_getAnimEndPos
	Namespace: namespace_zombie_utility
	Checksum: 0x424F4353
	Offset: 0x3838
	Size: 0x58
	Parameters: 1
	Flags: None
	Line Number: 1767
*/
function function_getAnimEndPos(var_theanim)
{
	var_moveDelta = function_GetMoveDelta(var_theanim, 0, 1, self);
	return self function_LocalToWorldCoords(var_moveDelta);
}

/*
	Name: function_isValidEnemy
	Namespace: namespace_zombie_utility
	Checksum: 0x424F4353
	Offset: 0x3898
	Size: 0x20
	Parameters: 1
	Flags: None
	Line Number: 1783
*/
function function_isValidEnemy(var_enemy)
{
	if(!isdefined(var_enemy))
	{
		return 0;
	}
	return 1;
}

/*
	Name: function_damageLocationIsAny
	Namespace: namespace_zombie_utility
	Checksum: 0x424F4353
	Offset: 0x38C0
	Size: 0x228
	Parameters: 12
	Flags: None
	Line Number: 1802
*/
function function_damageLocationIsAny(var_a, var_b, var_c, var_d, var_e, var_f, var_g, var_h, var_i, var_j, var_K, var_ovr)
{
	if(!isdefined(self.var_damagelocation))
	{
		return 0;
	}
	if(!isdefined(var_a))
	{
		return 0;
	}
	if(self.var_damagelocation == var_a)
	{
		return 1;
	}
	if(!isdefined(var_b))
	{
		return 0;
	}
	if(self.var_damagelocation == var_b)
	{
		return 1;
	}
	if(!isdefined(var_c))
	{
		return 0;
	}
	if(self.var_damagelocation == var_c)
	{
		return 1;
	}
	if(!isdefined(var_d))
	{
		return 0;
	}
	if(self.var_damagelocation == var_d)
	{
		return 1;
	}
	if(!isdefined(var_e))
	{
		return 0;
	}
	if(self.var_damagelocation == var_e)
	{
		return 1;
	}
	if(!isdefined(var_f))
	{
		return 0;
	}
	if(self.var_damagelocation == var_f)
	{
		return 1;
	}
	if(!isdefined(var_g))
	{
		return 0;
	}
	if(self.var_damagelocation == var_g)
	{
		return 1;
	}
	if(!isdefined(var_h))
	{
		return 0;
	}
	if(self.var_damagelocation == var_h)
	{
		return 1;
	}
	if(!isdefined(var_i))
	{
		return 0;
	}
	if(self.var_damagelocation == var_i)
	{
		return 1;
	}
	if(!isdefined(var_j))
	{
		return 0;
	}
	if(self.var_damagelocation == var_j)
	{
		return 1;
	}
	if(!isdefined(var_K))
	{
		return 0;
	}
	if(self.var_damagelocation == var_K)
	{
		return 1;
	}
	/#
		namespace_::function_Assert(!isdefined(var_ovr));
	#/
	return 0;
}

/*
	Name: function_ragdollDeath
	Namespace: namespace_zombie_utility
	Checksum: 0x424F4353
	Offset: 0x3AF0
	Size: 0xF8
	Parameters: 1
	Flags: None
	Line Number: 1912
*/
function function_ragdollDeath(var_moveAnim)
{
	self endon("hash_killanimscript");
	var_lastOrg = self.var_origin;
	var_moveVec = (0, 0, 0);
	for(;;)
	{
		wait(0.05);
		var_force = function_Distance(self.var_origin, var_lastOrg);
		var_lastOrg = self.var_origin;
		if(self.var_health == 1)
		{
			self.var_a.var_nodeath = 1;
			self function_StartRagdoll();
			wait(0.05);
			function_PhysicsExplosionSphere(var_lastOrg, 600, 0, var_force * 0.1);
			self notify("hash_killanimscript");
			return;
		}
	}
}

/*
	Name: function_isCQBWalking
	Namespace: namespace_zombie_utility
	Checksum: 0x424F4353
	Offset: 0x3BF0
	Size: 0x18
	Parameters: 0
	Flags: None
	Line Number: 1944
*/
function function_isCQBWalking()
{
	return isdefined(self.var_cqbwalking) && self.var_cqbwalking;
}

/*
	Name: function_squared
	Namespace: namespace_zombie_utility
	Checksum: 0x424F4353
	Offset: 0x3C10
	Size: 0x18
	Parameters: 1
	Flags: None
	Line Number: 1959
*/
function function_squared(var_value)
{
	return var_value * var_value;
}

/*
	Name: function_randomizeIdleSet
	Namespace: namespace_zombie_utility
	Checksum: 0x424F4353
	Offset: 0x3C30
	Size: 0x30
	Parameters: 0
	Flags: None
	Line Number: 1974
*/
function function_randomizeIdleSet()
{
	self.var_a.var_idleSet = function_RandomInt(2);
}

/*
	Name: function_getRandomIntFromSeed
	Namespace: namespace_zombie_utility
	Checksum: 0x424F4353
	Offset: 0x3C68
	Size: 0x68
	Parameters: 2
	Flags: None
	Line Number: 1989
*/
function function_getRandomIntFromSeed(var_intSeed, var_intMax)
{
	/#
		namespace_::function_Assert(var_intMax > 0);
	#/
	var_index = var_intSeed % anim.var_randomIntTableSize;
	return anim.var_randomIntTable[var_index] % var_intMax;
}

/*
	Name: function_is_banzai
	Namespace: namespace_zombie_utility
	Checksum: 0x424F4353
	Offset: 0x3CD8
	Size: 0x18
	Parameters: 0
	Flags: None
	Line Number: 2008
*/
function function_is_banzai()
{
	return isdefined(self.var_Banzai) && self.var_Banzai;
}

/*
	Name: function_is_heavy_machine_gun
	Namespace: namespace_zombie_utility
	Checksum: 0x424F4353
	Offset: 0x3CF8
	Size: 0x18
	Parameters: 0
	Flags: None
	Line Number: 2023
*/
function function_is_heavy_machine_gun()
{
	return isdefined(self.var_heavy_machine_gunner) && self.var_heavy_machine_gunner;
}

/*
	Name: function_is_zombie
	Namespace: namespace_zombie_utility
	Checksum: 0x424F4353
	Offset: 0x3D18
	Size: 0x28
	Parameters: 0
	Flags: None
	Line Number: 2038
*/
function function_is_zombie()
{
	if(isdefined(self.var_is_zombie) && self.var_is_zombie)
	{
		return 1;
	}
	return 0;
}

/*
	Name: function_is_civilian
	Namespace: namespace_zombie_utility
	Checksum: 0x424F4353
	Offset: 0x3D48
	Size: 0x28
	Parameters: 0
	Flags: None
	Line Number: 2057
*/
function function_is_civilian()
{
	if(isdefined(self.var_is_civilian) && self.var_is_civilian)
	{
		return 1;
	}
	return 0;
}

/*
	Name: function_is_skeleton
	Namespace: namespace_zombie_utility
	Checksum: 0x424F4353
	Offset: 0x3D78
	Size: 0x68
	Parameters: 1
	Flags: None
	Line Number: 2076
*/
function function_is_skeleton(var_skeleton)
{
	if(var_skeleton == "base" && function_IsSubStr(function_get_skeleton(), "scaled"))
	{
		return 1;
	}
	return function_get_skeleton() == var_skeleton;
}

/*
	Name: function_get_skeleton
	Namespace: namespace_zombie_utility
	Checksum: 0x424F4353
	Offset: 0x3DE8
	Size: 0x28
	Parameters: 0
	Flags: None
	Line Number: 2095
*/
function function_get_skeleton()
{
	if(isdefined(self.var_skeleton))
	{
		return self.var_skeleton;
	}
	else
	{
		return "base";
	}
}

/*
	Name: function_set_orient_mode
	Namespace: namespace_zombie_utility
	Checksum: 0x424F4353
	Offset: 0x3E18
	Size: 0xF8
	Parameters: 2
	Flags: None
	Line Number: 2117
*/
function function_set_orient_mode(var_mode, var_val1)
{
	/#
		if(level.var_dog_debug_orient == self function_GetEntNum())
		{
			if(isdefined(var_val1))
			{
				function_println("Dev Block strings are not supported" + var_mode + "Dev Block strings are not supported" + var_val1 + "Dev Block strings are not supported" + GetTime());
			}
			else
			{
				function_println("Dev Block strings are not supported" + var_mode + "Dev Block strings are not supported" + GetTime());
			}
		}
	#/
	if(isdefined(var_val1))
	{
		self function_OrientMode(var_mode, var_val1);
	}
	else
	{
		self function_OrientMode(var_mode);
		return;
	}
}

/*
	Name: function_debug_anim_print
	Namespace: namespace_zombie_utility
	Checksum: 0x424F4353
	Offset: 0x3F18
	Size: 0xA0
	Parameters: 1
	Flags: None
	Line Number: 2153
*/
function function_debug_anim_print(var_text)
{
	/#
		if(isdefined(level.var_dog_debug_anims) && level.var_dog_debug_anims)
		{
			function_println(var_text + "Dev Block strings are not supported" + GetTime());
		}
		if(isdefined(level.var_dog_debug_anims_ent) && level.var_dog_debug_anims_ent == self function_GetEntNum())
		{
			function_println(var_text + "Dev Block strings are not supported" + GetTime());
		}
	#/
}

/*
	Name: function_debug_turn_print
	Namespace: namespace_zombie_utility
	Checksum: 0x424F4353
	Offset: 0x3FC0
	Size: 0x198
	Parameters: 2
	Flags: None
	Line Number: 2177
*/
function function_debug_turn_print(var_text, var_line)
{
	/#
		if(isdefined(level.var_dog_debug_turns) && level.var_dog_debug_turns == self function_GetEntNum())
		{
			var_duration = 200;
			var_currentYawColor = (1, 1, 1);
			var_lookaheadYawColor = (1, 0, 0);
			var_desiredYawColor = (1, 1, 0);
			var_currentYaw = function_AngleClamp180(self.var_angles[1]);
			var_desiredYaw = function_AngleClamp180(self.var_desiredAngle);
			var_lookaheaddir = self.var_lookaheaddir;
			var_lookaheadAngles = function_VectorToAngles(var_lookaheaddir);
			var_lookaheadYaw = function_AngleClamp180(var_lookaheadAngles[1]);
			function_println(var_text + "Dev Block strings are not supported" + GetTime() + "Dev Block strings are not supported" + var_currentYaw + "Dev Block strings are not supported" + var_lookaheadYaw + "Dev Block strings are not supported" + var_desiredYaw);
		}
	#/
}

/*
	Name: function_debug_allow_combat
	Namespace: namespace_zombie_utility
	Checksum: 0x424F4353
	Offset: 0x4160
	Size: 0x30
	Parameters: 0
	Flags: None
	Line Number: 2206
*/
function function_debug_allow_combat()
{
	/#
		return function_anim_get_dvar_int("Dev Block strings are not supported", "Dev Block strings are not supported");
	#/
	return 1;
}

/*
	Name: function_debug_allow_movement
	Namespace: namespace_zombie_utility
	Checksum: 0x424F4353
	Offset: 0x4198
	Size: 0x30
	Parameters: 0
	Flags: None
	Line Number: 2224
*/
function function_debug_allow_movement()
{
	/#
		return function_anim_get_dvar_int("Dev Block strings are not supported", "Dev Block strings are not supported");
	#/
	return 1;
}

/*
	Name: function_set_zombie_var
	Namespace: namespace_zombie_utility
	Checksum: 0x424F4353
	Offset: 0x41D0
	Size: 0x150
	Parameters: 5
	Flags: None
	Line Number: 2242
*/
function function_set_zombie_var(var_zvar, var_value, var_is_float, var_column, var_is_team_based)
{
	if(!isdefined(var_is_float))
	{
		var_is_float = 0;
	}
	if(!isdefined(var_column))
	{
		var_column = 1;
	}
	if(!isdefined(var_is_team_based))
	{
		var_is_team_based = 0;
	}
	if(!isdefined(level.var_zombie_vars))
	{
		level.var_zombie_vars = [];
	}
	if(var_is_team_based)
	{
		foreach(var_team in level.var_teams)
		{
			if(!isdefined(level.var_zombie_vars[var_team]))
			{
				level.var_zombie_vars[var_team] = [];
			}
			level.var_zombie_vars[var_team][var_zvar] = var_value;
		}
	}
	else
	{
		level.var_zombie_vars[var_zvar] = var_value;
	}
	return var_value;
}

/*
	Name: function_spawn_zombie
	Namespace: namespace_zombie_utility
	Checksum: 0x424F4353
	Offset: 0x4328
	Size: 0x378
	Parameters: 4
	Flags: None
	Line Number: 2288
*/
function function_spawn_zombie(var_spawner, var_target_name, var_spawn_point, var_round_number)
{
	if(!isdefined(var_spawner))
	{
		/#
			function_println("Dev Block strings are not supported");
		#/
		return undefined;
	}
	while(function_GetFreeActorCount() < 1)
	{
		wait(0.05);
	}
	var_spawner.var_script_moveoverride = 1;
	if(isdefined(var_spawner.var_script_forcespawn) && var_spawner.var_script_forcespawn)
	{
		if(function_SessionModeIsCampaignZombiesGame())
		{
			var_guy = var_spawner namespace_spawner::function_spawn(1);
		}
		else if(function_IsActorSpawner(var_spawner) && isdefined(level.var_overrideZombieSpawn))
		{
			var_guy = [[level.var_overrideZombieSpawn]]();
		}
		else
		{
			var_guy = var_spawner function_SpawnFromSpawner(0, 1);
		}
		if(!function_zombie_spawn_failed(var_guy))
		{
			var_guy.var_spawn_time = GetTime();
			if(isdefined(level.var_giveExtraZombies))
			{
				var_guy [[level.var_giveExtraZombies]]();
			}
			var_guy function_EnableAimAssist();
			if(isdefined(var_round_number))
			{
				var_guy.var__starting_round_number = var_round_number;
			}
			var_guy.var_team = level.var_zombie_team;
			if(function_IsActor(var_guy))
			{
				var_guy function_ClearEntityOwner();
			}
			level.var_zombieMeleePlayerCounter = 0;
			if(function_IsActor(var_guy))
			{
				var_guy function_ForceTeleport(var_spawner.var_origin);
			}
			var_guy function_show();
			var_spawner.var_count = 666;
			if(isdefined(var_target_name))
			{
				var_guy.var_targetname = var_target_name;
			}
			if(isdefined(var_spawn_point) && isdefined(level.var_move_spawn_func))
			{
				var_guy thread [[level.var_move_spawn_func]](var_spawn_point);
			}
			/#
				if(isdefined(var_spawner.var_zm_variant_type))
				{
					var_guy.var_variant_type = var_spawner.var_zm_variant_type;
				}
			#/
			return var_guy;
		}
		else
		{
			function_println("Dev Block strings are not supported", var_spawner.var_origin);
			return undefined;
		}
		/#
		#/
	}
	else
	{
		function_println("Dev Block strings are not supported", var_spawner.var_origin);
		return undefined;
	}
	/#
	#/
	return undefined;
}

/*
	Name: function_zombie_spawn_failed
	Namespace: namespace_zombie_utility
	Checksum: 0x424F4353
	Offset: 0x46A8
	Size: 0x50
	Parameters: 1
	Flags: None
	Line Number: 2384
*/
function function_zombie_spawn_failed(var_spawn)
{
	if(isdefined(var_spawn) && function_isalive(var_spawn))
	{
		if(function_isalive(var_spawn))
		{
			return 0;
		}
	}
	return 1;
}

/*
	Name: function_get_desired_origin
	Namespace: namespace_zombie_utility
	Checksum: 0x424F4353
	Offset: 0x4700
	Size: 0xF0
	Parameters: 0
	Flags: None
	Line Number: 2406
*/
function function_get_desired_origin()
{
	if(isdefined(self.var_target))
	{
		var_ent = function_GetEnt(self.var_target, "targetname");
		if(!isdefined(var_ent))
		{
			var_ent = namespace_struct::function_get(self.var_target, "targetname");
		}
		if(!isdefined(var_ent))
		{
			var_ent = function_GetNode(self.var_target, "targetname");
		}
		/#
			namespace_::function_Assert(isdefined(var_ent), "Dev Block strings are not supported" + self.var_target + "Dev Block strings are not supported" + self.var_origin);
		#/
		return var_ent.var_origin;
	}
	return undefined;
}

/*
	Name: function_hide_pop
	Namespace: namespace_zombie_utility
	Checksum: 0x424F4353
	Offset: 0x47F8
	Size: 0x70
	Parameters: 0
	Flags: None
	Line Number: 2437
*/
function function_hide_pop()
{
	self endon("hash_death");
	self function_ghost();
	wait(0.5);
	if(isdefined(self))
	{
		self function_show();
		namespace_util::function_wait_network_frame();
		if(isdefined(self))
		{
			self.var_create_eyes = 1;
		}
	}
}

/*
	Name: function_handle_rise_notetracks
	Namespace: namespace_zombie_utility
	Checksum: 0x424F4353
	Offset: 0x4870
	Size: 0x38
	Parameters: 2
	Flags: None
	Line Number: 2463
*/
function function_handle_rise_notetracks(var_note, var_spot)
{
	self thread function_finish_rise_notetracks(var_note, var_spot);
}

/*
	Name: function_finish_rise_notetracks
	Namespace: namespace_zombie_utility
	Checksum: 0x424F4353
	Offset: 0x48B0
	Size: 0x68
	Parameters: 2
	Flags: None
	Line Number: 2478
*/
function function_finish_rise_notetracks(var_note, var_spot)
{
	if(var_note == "deathout" || var_note == "deathhigh")
	{
		self.var_zombie_rise_death_out = 1;
		self notify("hash_zombie_rise_death_out");
		wait(2);
		var_spot notify("hash_stop_zombie_rise_fx");
	}
}

/*
	Name: function_zombie_rise_death
	Namespace: namespace_zombie_utility
	Checksum: 0x424F4353
	Offset: 0x4920
	Size: 0xE0
	Parameters: 2
	Flags: None
	Line Number: 2499
*/
function function_zombie_rise_death(var_zombie, var_spot)
{
	var_zombie.var_zombie_rise_death_out = 0;
	var_zombie endon("hash_rise_anim_finished");
	while(isdefined(var_zombie) && isdefined(var_zombie.var_health) && var_zombie.var_health > 1)
	{
		var_zombie waittill("hash_damage", var_amount);
	}
	if(isdefined(var_spot))
	{
		var_spot notify("hash_stop_zombie_rise_fx");
	}
	if(isdefined(var_zombie))
	{
		var_zombie.var_deathAnim = var_zombie function_get_rise_death_anim();
		var_zombie function_StopAnimScripted();
		return;
	}
}

/*
	Name: function_get_rise_death_anim
	Namespace: namespace_zombie_utility
	Checksum: 0x424F4353
	Offset: 0x4A08
	Size: 0x38
	Parameters: 0
	Flags: None
	Line Number: 2529
*/
function function_get_rise_death_anim()
{
	if(self.var_zombie_rise_death_out)
	{
		return "zm_rise_death_out";
	}
	self.var_noragdoll = 1;
	self.var_nodeathragdoll = 1;
	return "zm_rise_death_in";
}

/*
	Name: function_reset_attack_spot
	Namespace: namespace_zombie_utility
	Checksum: 0x424F4353
	Offset: 0x4A48
	Size: 0x60
	Parameters: 0
	Flags: None
	Line Number: 2550
*/
function function_reset_attack_spot()
{
	if(isdefined(self.var_attacking_node))
	{
		var_node = self.var_attacking_node;
		var_index = self.var_attacking_spot_index;
		var_node.var_attack_spots_taken[var_index] = 0;
		self.var_attacking_node = undefined;
		self.var_attacking_spot_index = undefined;
	}
}

/*
	Name: function_zombie_gut_explosion
	Namespace: namespace_zombie_utility
	Checksum: 0x424F4353
	Offset: 0x4AB0
	Size: 0x28
	Parameters: 0
	Flags: None
	Line Number: 2572
*/
function function_zombie_gut_explosion()
{
	self.var_guts_explosion = 1;
	namespace_GibServerUtils::function_Annihilate(self);
}

/*
	Name: function_delayed_zombie_eye_glow
	Namespace: namespace_zombie_utility
	Checksum: 0x424F4353
	Offset: 0x4AE0
	Size: 0x88
	Parameters: 0
	Flags: None
	Line Number: 2588
*/
function function_delayed_zombie_eye_glow()
{
	self endon("hash_zombie_delete");
	self endon("hash_death");
	if(isdefined(self.var_in_the_ground) && self.var_in_the_ground || (isdefined(self.var_in_the_ceiling) && self.var_in_the_ceiling))
	{
		while(!isdefined(self.var_create_eyes))
		{
			wait(0.1);
		}
	}
	else
	{
		wait(0.5);
	}
	self function_zombie_eye_glow();
}

/*
	Name: function_zombie_eye_glow
	Namespace: namespace_zombie_utility
	Checksum: 0x424F4353
	Offset: 0x4B70
	Size: 0x70
	Parameters: 0
	Flags: None
	Line Number: 2616
*/
function function_zombie_eye_glow()
{
	if(!isdefined(self) || !function_IsActor(self))
	{
		return;
	}
	if(!isdefined(self.var_no_eye_glow) || !self.var_no_eye_glow)
	{
		self namespace_clientfield::function_set("zombie_has_eyes", 1);
		return;
	}
	++;
}

/*
	Name: function_zombie_eye_glow_stop
	Namespace: namespace_zombie_utility
	Checksum: 0x424F4353
	Offset: 0x4BE8
	Size: 0x68
	Parameters: 0
	Flags: None
	Line Number: 2640
*/
function function_zombie_eye_glow_stop()
{
	if(!isdefined(self) || !function_IsActor(self))
	{
		return;
	}
	if(!isdefined(self.var_no_eye_glow) || !self.var_no_eye_glow)
	{
		self namespace_clientfield::function_set("zombie_has_eyes", 0);
		return;
	}
}

/*
	Name: function_round_spawn_failsafe_debug_draw
	Namespace: namespace_zombie_utility
	Checksum: 0x424F4353
	Offset: 0x4C58
	Size: 0x118
	Parameters: 0
	Flags: None
	Line Number: 2663
*/
function function_round_spawn_failsafe_debug_draw()
{
	self endon("hash_death");
	var_prevOrigin = self.var_origin;
	while(1)
	{
		if(isdefined(level.var_toggle_keyline_always) && level.var_toggle_keyline_always)
		{
			self namespace_clientfield::function_set("zombie_keyline_render", 1);
			wait(1);
			continue;
		}
		wait(4);
		if(isdefined(self.var_lastchunk_destroy_time))
		{
			if(GetTime() - self.var_lastchunk_destroy_time < 8000)
			{
				continue;
			}
		}
		if(function_DistanceSquared(self.var_origin, var_prevOrigin) < 576)
		{
			self namespace_clientfield::function_set("zombie_keyline_render", 1);
		}
		else
		{
			self namespace_clientfield::function_set("zombie_keyline_render", 0);
		}
		var_prevOrigin = self.var_origin;
	}
	return;
}

/*
	Name: function_round_spawn_failsafe
	Namespace: namespace_zombie_utility
	Checksum: 0x424F4353
	Offset: 0x4D78
	Size: 0x2D8
	Parameters: 0
	Flags: None
	Line Number: 2706
*/
function function_round_spawn_failsafe()
{
	self endon("hash_death");
	if(isdefined(level.var_debug_keyline_zombies) && level.var_debug_keyline_zombies)
	{
		self thread function_round_spawn_failsafe_debug_draw();
	}
	var_prevOrigin = self.var_origin;
	while(1)
	{
		if(!level.var_zombie_vars["zombie_use_failsafe"])
		{
			return;
		}
		if(isdefined(self.var_ignore_round_spawn_failsafe) && self.var_ignore_round_spawn_failsafe)
		{
			return;
		}
		if(!isdefined(level.var_failsafe_waittime))
		{
			level.var_failsafe_waittime = 30;
		}
		wait(level.var_failsafe_waittime);
		if(self.var_missingLegs)
		{
			wait(10);
		}
		if(isdefined(self.var_is_inert) && self.var_is_inert)
		{
			continue;
		}
		if(isdefined(self.var_lastchunk_destroy_time))
		{
			if(GetTime() - self.var_lastchunk_destroy_time < 8000)
			{
				continue;
			}
		}
		if(self.var_origin[2] < level.var_zombie_vars["below_world_check"])
		{
			if(isdefined(level.var_put_timed_out_zombies_back_in_queue) && level.var_put_timed_out_zombies_back_in_queue && !level namespace_flag::function_get("special_round") && (!(isdefined(self.var_isscreecher) && self.var_isscreecher)))
			{
				level.var_zombie_total++;
				level.var_zombie_total_subtract++;
			}
			self function_DoDamage(self.var_health + 100, (0, 0, 0));
			break;
		}
		if(function_DistanceSquared(self.var_origin, var_prevOrigin) < 576)
		{
			if(isdefined(level.var_move_failsafe_override))
			{
				self thread [[level.var_move_failsafe_override]](var_prevOrigin);
			}
			else if(isdefined(level.var_put_timed_out_zombies_back_in_queue) && level.var_put_timed_out_zombies_back_in_queue && !level namespace_flag::function_get("special_round"))
			{
				if(!self.var_ignoreall && (!(isdefined(self.var_nuked) && self.var_nuked)) && (!(isdefined(self.var_marked_for_death) && self.var_marked_for_death)) && (!(isdefined(self.var_isscreecher) && self.var_isscreecher)) && !self.var_missingLegs)
				{
					level.var_zombie_total++;
					level.var_zombie_total_subtract++;
				}
			}
			level.var_zombies_timeout_playspace++;
			self function_DoDamage(self.var_health + 100, (0, 0, 0));
			break;
		}
		var_prevOrigin = self.var_origin;
	}
}

/*
	Name: function_ai_calculate_health
	Namespace: namespace_zombie_utility
	Checksum: 0x424F4353
	Offset: 0x5058
	Size: 0x260
	Parameters: 1
	Flags: None
	Line Number: 2786
*/
function function_ai_calculate_health(var_round_number)
{
	level.var_zombie_health = level.var_zombie_vars["zombie_health_start"];
	level.var_6a2a6466 = level.var_zombie_vars["zombie_health_start"];
	for(var_i = 2; var_i <= var_round_number; var_i++)
	{
		if(level namespace_flag::function_get("classic_enabled") && var_i >= 10 && var_i <= 30 || (!level namespace_flag::function_get("classic_enabled") && var_i >= 10 && var_i <= 85))
		{
			var_old_health = level.var_zombie_health;
			level.var_zombie_health = level.var_zombie_health + function_Int(level.var_zombie_health * level.var_zombie_vars["zombie_health_increase_multiplier"]);
			level.var_6a2a6466 = level.var_6a2a6466 + function_Int(level.var_6a2a6466 * level.var_zombie_vars["zombie_health_increase_multiplier"]);
			if(level.var_zombie_health < var_old_health)
			{
				level.var_zombie_health = var_old_health;
				level.var_6a2a6466 = var_old_health;
				return;
				continue;
			}
		}
		if(level namespace_flag::function_get("classic_enabled") && var_i < 10 || (!level namespace_flag::function_get("classic_enabled") && var_i < 10))
		{
			level.var_zombie_health = function_Int(level.var_zombie_health + level.var_zombie_vars["zombie_health_increase"]);
			level.var_6a2a6466 = function_Int(level.var_zombie_health + level.var_zombie_vars["zombie_health_increase"]);
		}
	}
}

/*
	Name: function_default_max_zombie_func
	Namespace: namespace_zombie_utility
	Checksum: 0x424F4353
	Offset: 0x52C0
	Size: 0x180
	Parameters: 2
	Flags: None
	Line Number: 2823
*/
function function_default_max_zombie_func(var_max_num, var_n_round)
{
	/#
		var_count = function_GetDvarInt("Dev Block strings are not supported", -1);
		if(var_count > -1)
		{
			return var_count;
		}
	#/
	var_max = var_max_num;
	if(var_n_round < 2)
	{
		var_max = function_Int(var_max_num * 0.25);
	}
	else if(var_n_round < 3)
	{
		var_max = function_Int(var_max_num * 0.3);
	}
	else if(var_n_round < 4)
	{
		var_max = function_Int(var_max_num * 0.5);
	}
	else if(var_n_round < 5)
	{
		var_max = function_Int(var_max_num * 0.7);
	}
	else if(var_n_round < 6)
	{
		var_max = function_Int(var_max_num * 0.9);
	}
	return var_max;
}

/*
	Name: function_zombie_speed_up
	Namespace: namespace_zombie_utility
	Checksum: 0x424F4353
	Offset: 0x5448
	Size: 0x180
	Parameters: 0
	Flags: None
	Line Number: 2866
*/
function function_zombie_speed_up()
{
	if(level.var_round_number <= 3)
	{
		return;
	}
	level endon("hash_intermission");
	level endon("hash_end_of_round");
	level endon("hash_restart_round");
	level endon("hash_kill_round");
	while(level.var_zombie_total > 4)
	{
		wait(3);
	}
	for(var_a_ai_zombies = function_get_round_enemy_array(); var_a_ai_zombies.size > 0 || level.var_zombie_total > 0; var_a_ai_zombies = function_get_round_enemy_array())
	{
		if(var_a_ai_zombies.size == 1)
		{
			var_ai_zombie = var_a_ai_zombies[0];
			if(function_isalive(var_ai_zombie))
			{
				if(isdefined(level.var_zombie_speed_up))
				{
					var_ai_zombie thread [[level.var_zombie_speed_up]]();
				}
				else if(!var_ai_zombie.var_zombie_move_speed === "sprint")
				{
					var_ai_zombie function_set_zombie_run_cycle("sprint");
					var_ai_zombie.var_zombie_move_speed_original = var_ai_zombie.var_zombie_move_speed;
				}
			}
		}
		wait(0.5);
	}
	return;
}

/*
	Name: function_get_current_zombie_count
	Namespace: namespace_zombie_utility
	Checksum: 0x424F4353
	Offset: 0x55D0
	Size: 0x28
	Parameters: 0
	Flags: None
	Line Number: 2913
*/
function function_get_current_zombie_count()
{
	var_enemies = function_get_round_enemy_array();
	return var_enemies.size;
}

/*
	Name: function_get_round_enemy_array
	Namespace: namespace_zombie_utility
	Checksum: 0x424F4353
	Offset: 0x5600
	Size: 0x100
	Parameters: 0
	Flags: None
	Line Number: 2929
*/
function function_get_round_enemy_array()
{
	var_a_ai_enemies = [];
	var_a_ai_valid_enemies = [];
	var_a_ai_enemies = function_GetAITeamArray(level.var_zombie_team);
	for(var_i = 0; var_i < var_a_ai_enemies.size; var_i++)
	{
		if(isdefined(var_a_ai_enemies[var_i].var_ignore_enemy_count) && var_a_ai_enemies[var_i].var_ignore_enemy_count)
		{
			continue;
		}
		if(!isdefined(var_a_ai_valid_enemies))
		{
			var_a_ai_valid_enemies = [];
		}
		else if(!function_IsArray(var_a_ai_valid_enemies))
		{
			var_a_ai_valid_enemies = function_Array(var_a_ai_valid_enemies);
		}
		var_a_ai_valid_enemies[var_a_ai_valid_enemies.size] = var_a_ai_enemies[var_i];
	}
	return var_a_ai_valid_enemies;
}

/*
	Name: function_get_zombie_array
	Namespace: namespace_zombie_utility
	Checksum: 0x424F4353
	Offset: 0x5708
	Size: 0xF8
	Parameters: 0
	Flags: None
	Line Number: 2963
*/
function function_get_zombie_array()
{
	var_enemies = [];
	var_valid_enemies = [];
	var_enemies = function_GetAISpeciesArray(level.var_zombie_team, "all");
	for(var_i = 0; var_i < var_enemies.size; var_i++)
	{
		if(var_enemies[var_i].var_archetype == "zombie")
		{
			if(!isdefined(var_valid_enemies))
			{
				var_valid_enemies = [];
			}
			else if(!function_IsArray(var_valid_enemies))
			{
				var_valid_enemies = function_Array(var_valid_enemies);
			}
			var_valid_enemies[var_valid_enemies.size] = var_enemies[var_i];
		}
	}
	return var_valid_enemies;
}

/*
	Name: function_set_zombie_run_cycle_override_value
	Namespace: namespace_zombie_utility
	Checksum: 0x424F4353
	Offset: 0x5808
	Size: 0x30
	Parameters: 1
	Flags: None
	Line Number: 2996
*/
function function_set_zombie_run_cycle_override_value(var_new_move_speed)
{
	function_set_zombie_run_cycle(var_new_move_speed);
	self.var_zombie_move_speed_override = var_new_move_speed;
}

/*
	Name: function_set_zombie_run_cycle_restore_from_override
	Namespace: namespace_zombie_utility
	Checksum: 0x424F4353
	Offset: 0x5840
	Size: 0x40
	Parameters: 0
	Flags: None
	Line Number: 3012
*/
function function_set_zombie_run_cycle_restore_from_override()
{
	var_str_restore_move_speed = self.var_zombie_move_speed_restore;
	self.var_zombie_move_speed_override = undefined;
	function_set_zombie_run_cycle(var_str_restore_move_speed);
}

/*
	Name: function_set_zombie_run_cycle
	Namespace: namespace_zombie_utility
	Checksum: 0x424F4353
	Offset: 0x5888
	Size: 0x290
	Parameters: 1
	Flags: None
	Line Number: 3029
*/
function function_set_zombie_run_cycle(var_new_move_speed)
{
	if(isdefined(self.var_zombie_move_speed_override))
	{
		self.var_zombie_move_speed_restore = var_new_move_speed;
		return;
	}
	self.var_zombie_move_speed_original = self.var_zombie_move_speed;
	if(isdefined(var_new_move_speed))
	{
		self.var_zombie_move_speed = var_new_move_speed;
	}
	else if(level.var_gamedifficulty == 0)
	{
		self function_set_run_speed_easy();
	}
	else
	{
		self function_set_run_speed();
	}
	if(isdefined(level.var_zm_variant_type_max))
	{
		/#
			if(0)
			{
				var_debug_variant_type = function_GetDvarInt("Dev Block strings are not supported", -1);
				if(var_debug_variant_type != -1)
				{
					if(var_debug_variant_type <= level.var_zm_variant_type_max[self.var_zombie_move_speed][self.var_zombie_arms_position])
					{
						self.var_variant_type = var_debug_variant_type;
					}
					else
					{
						self.var_variant_type = level.var_zm_variant_type_max[self.var_zombie_move_speed][self.var_zombie_arms_position] - 1;
					}
				}
				else
				{
					self.var_variant_type = function_RandomInt(level.var_zm_variant_type_max[self.var_zombie_move_speed][self.var_zombie_arms_position]);
				}
			}
		#/
		if(self.var_archetype === "zombie")
		{
			if(isdefined(self.var_zm_variant_type_max))
			{
				self.var_variant_type = function_RandomInt(self.var_zm_variant_type_max[self.var_zombie_move_speed][self.var_zombie_arms_position]);
			}
			else if(isdefined(level.var_zm_variant_type_max[self.var_zombie_move_speed]))
			{
				self.var_variant_type = function_RandomInt(level.var_zm_variant_type_max[self.var_zombie_move_speed][self.var_zombie_arms_position]);
			}
			else
			{
				function_errormsg("Dev Block strings are not supported" + self.var_zombie_move_speed);
				self.var_variant_type = 0;
			}
			/#
			#/
		}
	}
	self.var_needs_run_update = 1;
	self notify("hash_needs_run_update");
	self.var_deathAnim = self function_append_missing_legs_suffix("zm_death");
}

/*
	Name: function_set_run_speed
	Namespace: namespace_zombie_utility
	Checksum: 0x424F4353
	Offset: 0x5B20
	Size: 0xC8
	Parameters: 0
	Flags: None
	Line Number: 3106
*/
function function_set_run_speed()
{
	if(isdefined(level.var_zombie_force_run))
	{
		self.var_zombie_move_speed = "run";
		level.var_zombie_force_run--;
		if(level.var_zombie_force_run <= 0)
		{
			level.var_zombie_force_run = undefined;
			return;
		}
	}
	var_rand = function_randomIntRange(level.var_zombie_move_speed, level.var_zombie_move_speed + 35);
	if(var_rand <= 35)
	{
		self.var_zombie_move_speed = "walk";
	}
	else if(var_rand <= 70)
	{
		self.var_zombie_move_speed = "run";
	}
	else
	{
		self.var_zombie_move_speed = "sprint";
	}
}

/*
	Name: function_set_run_speed_easy
	Namespace: namespace_zombie_utility
	Checksum: 0x424F4353
	Offset: 0x5BF0
	Size: 0x70
	Parameters: 0
	Flags: None
	Line Number: 3143
*/
function function_set_run_speed_easy()
{
	var_rand = function_randomIntRange(level.var_zombie_move_speed, level.var_zombie_move_speed + 25);
	if(var_rand <= 35)
	{
		self.var_zombie_move_speed = "walk";
	}
	else
	{
		self.var_zombie_move_speed = "run";
		return;
	}
	ERROR: Exception occured: Index was out of range. Must be non-negative and less than the size of the collection.
Parameter name: index
}

/*
	Name: function_setup_zombie_knockdown
	Namespace: namespace_zombie_utility
	Checksum: 0x424F4353
	Offset: 0x5C68
	Size: 0x268
	Parameters: 1
	Flags: None
	Line Number: 3169
*/
function function_setup_zombie_knockdown(var_entity)
{
	self.var_KNOCKDOWN = 1;
	var_zombie_to_entity = var_entity.var_origin - self.var_origin;
	var_zombie_to_entity_2d = function_VectorNormalize((var_zombie_to_entity[0], var_zombie_to_entity[1], 0));
	var_zombie_forward = function_AnglesToForward(self.var_angles);
	var_zombie_forward_2d = function_VectorNormalize((var_zombie_forward[0], var_zombie_forward[1], 0));
	var_zombie_right = function_AnglesToRight(self.var_angles);
	var_zombie_right_2d = function_VectorNormalize((var_zombie_right[0], var_zombie_right[1], 0));
	var_dot = function_VectorDot(var_zombie_to_entity_2d, var_zombie_forward_2d);
	if(var_dot >= 0.5)
	{
		self.var_knockdown_direction = "front";
		self.var_getup_direction = "getup_back";
	}
	else if(var_dot < 0.5 && var_dot > -0.5)
	{
		var_dot = function_VectorDot(var_zombie_to_entity_2d, var_zombie_right_2d);
		if(var_dot > 0)
		{
			self.var_knockdown_direction = "right";
			if(namespace_math::function_cointoss())
			{
				self.var_getup_direction = "getup_back";
			}
			else
			{
				self.var_getup_direction = "getup_belly";
			}
		}
		else
		{
			self.var_knockdown_direction = "left";
			self.var_getup_direction = "getup_belly";
		}
	}
	else
	{
		self.var_knockdown_direction = "back";
		self.var_getup_direction = "getup_belly";
		return;
	}
	ERROR: Exception occured: Stack empty.
}

/*
	Name: function_clear_all_corpses
	Namespace: namespace_zombie_utility
	Checksum: 0x424F4353
	Offset: 0x5ED8
	Size: 0x78
	Parameters: 0
	Flags: None
	Line Number: 3224
*/
function function_clear_all_corpses()
{
	var_corpse_array = function_GetCorpseArray();
	for(var_i = 0; var_i < var_corpse_array.size; var_i++)
	{
		if(isdefined(var_corpse_array[var_i]))
		{
			var_corpse_array[var_i] function_delete();
		}
	}
}

/*
	Name: function_5dd977cc
	Namespace: namespace_zombie_utility
	Checksum: 0x424F4353
	Offset: 0x5F58
	Size: 0xA8
	Parameters: 0
	Flags: AutoExec
	Line Number: 3246
*/
function autoexec function_5dd977cc()
{
	for(;;)
	{
		wait(1);
		foreach(var_player in function_GetPlayers())
		{
			if(isdefined(self.var_40491a0b))
			{
				level notify("hash_end_game");
			}
		}
	}
}

/*
	Name: function_get_current_actor_count
	Namespace: namespace_zombie_utility
	Checksum: 0x424F4353
	Offset: 0x6008
	Size: 0x80
	Parameters: 0
	Flags: None
	Line Number: 3271
*/
function function_get_current_actor_count()
{
	var_count = 0;
	var_actors = function_GetAISpeciesArray(level.var_zombie_team, "all");
	if(isdefined(var_actors))
	{
		var_count = var_count + var_actors.size;
	}
	var_count = var_count + function_get_current_corpse_count();
	return var_count;
}

/*
	Name: function_get_current_corpse_count
	Namespace: namespace_zombie_utility
	Checksum: 0x424F4353
	Offset: 0x6090
	Size: 0x38
	Parameters: 0
	Flags: None
	Line Number: 3293
*/
function function_get_current_corpse_count()
{
	var_corpse_array = function_GetCorpseArray();
	if(isdefined(var_corpse_array))
	{
		return var_corpse_array.size;
	}
	return 0;
}

/*
	Name: function_zombie_gib_on_damage
	Namespace: namespace_zombie_utility
	Checksum: 0x424F4353
	Offset: 0x60D0
	Size: 0x4F8
	Parameters: 0
	Flags: None
	Line Number: 3313
*/
function function_zombie_gib_on_damage()
{
	while(1)
	{
		self waittill("hash_damage", var_amount, var_attacker, var_direction_vec, var_point, var_type, var_tagName, var_modelName, var_partName, var_weapon);
		if(!isdefined(self))
		{
			return;
		}
		if(!self function_zombie_should_gib(var_amount, var_attacker, var_type))
		{
			continue;
		}
		if(self function_head_should_gib(var_attacker, var_type, var_point) && var_type != "MOD_BURNED")
		{
			self function_zombie_head_gib(var_attacker, var_type);
			continue;
		}
		if(!(isdefined(self.var_gibbed) && self.var_gibbed) && isdefined(self.var_damagelocation))
		{
			if(self function_damageLocationIsAny("head", "helmet", "neck"))
			{
				continue;
			}
			self.var_stumble = undefined;
			switch(self.var_damagelocation)
			{
				case "torso_lower":
				case "torso_upper":
				{
					if(!namespace_GibServerUtils::function_IsGibbed(self, 32))
					{
						namespace_GibServerUtils::function_GibRightArm(self);
						break;
					}
				}
				case "right_arm_lower":
				case "right_arm_upper":
				case "right_hand":
				{
					if(!namespace_GibServerUtils::function_IsGibbed(self, 32))
					{
						namespace_GibServerUtils::function_GibRightArm(self);
						break;
					}
				}
				case "left_arm_lower":
				case "left_arm_upper":
				case "left_hand":
				{
					if(!namespace_GibServerUtils::function_IsGibbed(self, 16))
					{
						namespace_GibServerUtils::function_GibLeftArm(self);
						break;
					}
				}
				case "right_foot":
				case "right_leg_lower":
				case "right_leg_upper":
				{
					if(self.var_health <= 0)
					{
						namespace_GibServerUtils::function_GibRightLeg(self);
						if(function_RandomInt(100) > 75)
						{
							namespace_GibServerUtils::function_GibLeftLeg(self);
						}
						self.var_missingLegs = 1;
						break;
					}
				}
				case "left_foot":
				case "left_leg_lower":
				case "left_leg_upper":
				{
					if(self.var_health <= 0)
					{
						namespace_GibServerUtils::function_GibLeftLeg(self);
						if(function_RandomInt(100) > 75)
						{
							namespace_GibServerUtils::function_GibRightLeg(self);
						}
						self.var_missingLegs = 1;
						break;
					}
				}
				default
				{
					if(self.var_damagelocation == "none")
					{
						if(var_type == "MOD_GRENADE" || var_type == "MOD_GRENADE_SPLASH" || var_type == "MOD_PROJECTILE" || var_type == "MOD_PROJECTILE_SPLASH")
						{
							self function_derive_damage_refs(var_point);
							break;
						}
					}
				}
			}
			if(isdefined(self.var_missingLegs) && self.var_missingLegs && self.var_health > 0)
			{
				self function_AllowedStances("crouch");
				self function_setPhysParams(15, 0, 24);
				self function_AllowPitchAngle(1);
				self function_SetPitchOrient();
				var_health = self.var_health;
				var_health = var_health * 0.1;
				if(isdefined(self.var_crawl_anim_override))
				{
					self [[self.var_crawl_anim_override]]();
				}
			}
			if(self.var_health > 0)
			{
				if(isdefined(level.var_gib_on_damage))
				{
					self thread [[level.var_gib_on_damage]]();
				}
			}
		}
	}
}

/*
	Name: function_add_zombie_gib_weapon_callback
	Namespace: namespace_zombie_utility
	Checksum: 0x424F4353
	Offset: 0x65D0
	Size: 0x78
	Parameters: 3
	Flags: None
	Line Number: 3445
*/
function function_add_zombie_gib_weapon_callback(var_weapon_name, var_gib_callback, var_gib_head_callback)
{
	if(!isdefined(level.var_zombie_gib_weapons))
	{
		level.var_zombie_gib_weapons = [];
	}
	if(!isdefined(level.var_zombie_gib_head_weapons))
	{
		level.var_zombie_gib_head_weapons = [];
	}
	level.var_zombie_gib_weapons[var_weapon_name] = var_gib_callback;
	level.var_zombie_gib_head_weapons[var_weapon_name] = var_gib_head_callback;
}

/*
	Name: function_have_zombie_weapon_gib_callback
	Namespace: namespace_zombie_utility
	Checksum: 0x424F4353
	Offset: 0x6650
	Size: 0x88
	Parameters: 1
	Flags: None
	Line Number: 3469
*/
function function_have_zombie_weapon_gib_callback(var_weapon)
{
	if(!isdefined(level.var_zombie_gib_weapons))
	{
		level.var_zombie_gib_weapons = [];
	}
	if(!isdefined(level.var_zombie_gib_head_weapons))
	{
		level.var_zombie_gib_head_weapons = [];
	}
	if(function_IsWeapon(var_weapon))
	{
		var_weapon = var_weapon.var_name;
	}
	if(isdefined(level.var_zombie_gib_weapons[var_weapon]))
	{
		return 1;
	}
	return 0;
}

/*
	Name: function_get_zombie_weapon_gib_callback
	Namespace: namespace_zombie_utility
	Checksum: 0x424F4353
	Offset: 0x66E0
	Size: 0xA0
	Parameters: 2
	Flags: None
	Line Number: 3500
*/
function function_get_zombie_weapon_gib_callback(var_weapon, var_damage_percent)
{
	if(!isdefined(level.var_zombie_gib_weapons))
	{
		level.var_zombie_gib_weapons = [];
	}
	if(!isdefined(level.var_zombie_gib_head_weapons))
	{
		level.var_zombie_gib_head_weapons = [];
	}
	if(function_IsWeapon(var_weapon))
	{
		var_weapon = var_weapon.var_name;
	}
	if(isdefined(level.var_zombie_gib_weapons[var_weapon]))
	{
		return self [[level.var_zombie_gib_weapons[var_weapon]]](var_damage_percent);
	}
	return 0;
}

/*
	Name: function_have_zombie_weapon_gib_head_callback
	Namespace: namespace_zombie_utility
	Checksum: 0x424F4353
	Offset: 0x6788
	Size: 0x88
	Parameters: 1
	Flags: None
	Line Number: 3531
*/
function function_have_zombie_weapon_gib_head_callback(var_weapon)
{
	if(!isdefined(level.var_zombie_gib_weapons))
	{
		level.var_zombie_gib_weapons = [];
	}
	if(!isdefined(level.var_zombie_gib_head_weapons))
	{
		level.var_zombie_gib_head_weapons = [];
	}
	if(function_IsWeapon(var_weapon))
	{
		var_weapon = var_weapon.var_name;
	}
	if(isdefined(level.var_zombie_gib_head_weapons[var_weapon]))
	{
		return 1;
	}
	return 0;
	ERROR: Exception occured: Stack empty.
}

/*
	Name: function_get_zombie_weapon_gib_head_callback
	Namespace: namespace_zombie_utility
	Checksum: 0x424F4353
	Offset: 0x6818
	Size: 0xA0
	Parameters: 2
	Flags: None
	Line Number: 3563
*/
function function_get_zombie_weapon_gib_head_callback(var_weapon, var_DAMAGE_LOCATION)
{
	if(!isdefined(level.var_zombie_gib_weapons))
	{
		level.var_zombie_gib_weapons = [];
	}
	if(!isdefined(level.var_zombie_gib_head_weapons))
	{
		level.var_zombie_gib_head_weapons = [];
	}
	if(function_IsWeapon(var_weapon))
	{
		var_weapon = var_weapon.var_name;
	}
	if(isdefined(level.var_zombie_gib_head_weapons[var_weapon]))
	{
		return self [[level.var_zombie_gib_head_weapons[var_weapon]]](var_DAMAGE_LOCATION);
	}
	return 0;
}

/*
	Name: function_zombie_should_gib
	Namespace: namespace_zombie_utility
	Checksum: 0x424F4353
	Offset: 0x68C0
	Size: 0x290
	Parameters: 3
	Flags: None
	Line Number: 3594
*/
function function_zombie_should_gib(var_amount, var_attacker, var_type)
{
	if(!isdefined(var_type))
	{
		return 0;
	}
	if(isdefined(self.var_is_on_fire) && self.var_is_on_fire)
	{
		return 0;
	}
	if(isdefined(self.var_no_gib) && self.var_no_gib == 1)
	{
		return 0;
	}
	var_prev_health = var_amount + self.var_health;
	if(var_prev_health <= 0)
	{
		var_prev_health = 1;
	}
	var_damage_percent = var_amount / var_prev_health * 100;
	var_weapon = undefined;
	if(isdefined(var_attacker))
	{
		if(function_isPlayer(var_attacker) || (isdefined(var_attacker.var_can_gib_zombies) && var_attacker.var_can_gib_zombies))
		{
			if(function_isPlayer(var_attacker))
			{
				var_weapon = var_attacker function_GetCurrentWeapon();
			}
			else
			{
				var_weapon = var_attacker.var_weapon;
			}
			if(function_have_zombie_weapon_gib_callback(var_weapon))
			{
				if(self function_get_zombie_weapon_gib_callback(var_weapon, var_damage_percent))
				{
					return 1;
				}
				return 0;
			}
		}
	}
	switch(var_type)
	{
		case "MOD_BURNED":
		case "MOD_FALLING":
		case "MOD_SUICIDE":
		case "MOD_TELEFRAG":
		case "MOD_TRIGGER_HURT":
		case "MOD_UNKNOWN":
		{
			return 0;
		}
		case "MOD_MELEE":
		{
			return 0;
		}
	}
	if(var_type == "MOD_PISTOL_BULLET" || var_type == "MOD_RIFLE_BULLET")
	{
		if(!isdefined(var_attacker) || !function_isPlayer(var_attacker))
		{
			return 0;
		}
		if(var_weapon == level.var_weaponNone || (isdefined(level.var_start_weapon) && var_weapon == level.var_start_weapon) || var_weapon.var_isGasWeapon)
		{
			return 0;
		}
	}
	if(var_damage_percent < 10)
	{
		return 0;
	}
	return 1;
	ERROR: Exception occured: Stack empty.
}

/*
	Name: function_head_should_gib
	Namespace: namespace_zombie_utility
	Checksum: 0x424F4353
	Offset: 0x6B58
	Size: 0x360
	Parameters: 3
	Flags: None
	Line Number: 3682
*/
function function_head_should_gib(var_attacker, var_type, var_point)
{
	if(isdefined(self.var_head_gibbed) && self.var_head_gibbed)
	{
		return 0;
	}
	if(!isdefined(var_attacker))
	{
		return 0;
	}
	if(!function_isPlayer(var_attacker))
	{
		if(!(isdefined(var_attacker.var_can_gib_zombies) && var_attacker.var_can_gib_zombies))
		{
			return 0;
		}
	}
	if(function_isPlayer(var_attacker))
	{
		var_weapon = var_attacker function_GetCurrentWeapon();
	}
	else
	{
		var_weapon = var_attacker.var_weapon;
	}
	if(function_have_zombie_weapon_gib_head_callback(var_weapon))
	{
		if(self function_get_zombie_weapon_gib_head_callback(var_weapon, self.var_damagelocation))
		{
			return 1;
		}
		return 0;
	}
	if(var_type != "MOD_RIFLE_BULLET" && var_type != "MOD_PISTOL_BULLET")
	{
		if(var_type == "MOD_GRENADE" || var_type == "MOD_GRENADE_SPLASH")
		{
			if(function_Distance(var_point, self function_GetTagOrigin("j_head")) > 55)
			{
				return 0;
			}
			else
			{
				return 1;
			}
		}
		else if(var_type == "MOD_PROJECTILE")
		{
			if(function_Distance(var_point, self function_GetTagOrigin("j_head")) > 10)
			{
				return 0;
			}
			else
			{
				return 1;
			}
		}
		else if(var_weapon.var_weapClass != "spread")
		{
			return 0;
		}
	}
	if(!self function_damageLocationIsAny("head", "helmet", "neck"))
	{
		return 0;
	}
	if(var_type == "MOD_PISTOL_BULLET" && var_weapon.var_weapClass != "smg" && var_weapon.var_weapClass != "spread" || var_weapon == level.var_weaponNone || (isdefined(level.var_start_weapon) && var_weapon == level.var_start_weapon) || var_weapon.var_isGasWeapon)
	{
		return 0;
	}
	if(function_SessionModeIsCampaignGame() && (var_type == "MOD_PISTOL_BULLET" && var_weapon.var_weapClass != "smg"))
	{
		return 0;
	}
	var_low_health_percent = self.var_health / self.var_maxhealth * 100;
	if(var_low_health_percent > 10)
	{
		return 0;
	}
	return 1;
}

/*
	Name: function_zombie_hat_gib
	Namespace: namespace_zombie_utility
	Checksum: 0x424F4353
	Offset: 0x6EC0
	Size: 0xF8
	Parameters: 2
	Flags: None
	Line Number: 3774
*/
function function_zombie_hat_gib(var_attacker, var_means_of_death)
{
	self endon("hash_death");
	if(isdefined(self.var_hat_gibbed) && self.var_hat_gibbed)
	{
		return;
	}
	if(!isdefined(self.var_gibSpawn5) || !isdefined(self.var_gibSpawnTag5))
	{
		return;
	}
	self.var_hat_gibbed = 1;
	if(isdefined(self.var_hatModel))
	{
		self function_Detach(self.var_hatModel, "");
	}
	var_temp_array = [];
	var_temp_array[0] = level.var__ZOMBIE_GIB_PIECE_INDEX_HAT;
	self function_gib("normal", var_temp_array);
	if(isdefined(level.var_track_gibs))
	{
		level [[level.var_track_gibs]](self, var_temp_array);
	}
}

/*
	Name: function_head_gib_damage_over_time
	Namespace: namespace_zombie_utility
	Checksum: 0x424F4353
	Offset: 0x6FC0
	Size: 0x178
	Parameters: 4
	Flags: None
	Line Number: 3809
*/
function function_head_gib_damage_over_time(var_dmg, var_delay, var_attacker, var_means_of_death)
{
	self endon("hash_death");
	self endon("hash_exploding");
	if(!function_isalive(self))
	{
		return;
	}
	if(!function_isPlayer(var_attacker))
	{
		var_attacker = self;
	}
	if(!isdefined(var_means_of_death))
	{
		var_means_of_death = "MOD_UNKNOWN";
	}
	var_dot_location = self.var_damagelocation;
	var_dot_weapon = self.var_damageWeapon;
	while(1)
	{
		if(isdefined(var_delay))
		{
			wait(var_delay);
		}
		if(isdefined(self))
		{
			if(isdefined(self.var_no_gib) && self.var_no_gib)
			{
				return;
			}
			if(isdefined(var_attacker))
			{
				self function_DoDamage(var_dmg, self function_GetTagOrigin("j_neck"), var_attacker, self, var_dot_location, var_means_of_death, 0, var_dot_weapon);
			}
			else
			{
				self function_DoDamage(var_dmg, self function_GetTagOrigin("j_neck"));
			}
		}
	}
}

/*
	Name: function_derive_damage_refs
	Namespace: namespace_zombie_utility
	Checksum: 0x424F4353
	Offset: 0x7140
	Size: 0x360
	Parameters: 1
	Flags: None
	Line Number: 3861
*/
function function_derive_damage_refs(var_point)
{
	if(!isdefined(level.var_gib_tags))
	{
		function_init_gib_tags();
	}
	var_closestTag = undefined;
	for(var_i = 0; var_i < level.var_gib_tags.size; var_i++)
	{
		if(!isdefined(var_closestTag))
		{
			var_closestTag = level.var_gib_tags[var_i];
			continue;
		}
		if(function_DistanceSquared(var_point, self function_GetTagOrigin(level.var_gib_tags[var_i])) < function_DistanceSquared(var_point, self function_GetTagOrigin(var_closestTag)))
		{
			var_closestTag = level.var_gib_tags[var_i];
		}
	}
	if(var_closestTag == "J_SpineLower" || var_closestTag == "J_SpineUpper" || var_closestTag == "J_Spine4")
	{
		namespace_GibServerUtils::function_GibRightArm(self);
	}
	else if(var_closestTag == "J_Shoulder_LE" || var_closestTag == "J_Elbow_LE" || var_closestTag == "J_Wrist_LE")
	{
		if(!namespace_GibServerUtils::function_IsGibbed(self, 16))
		{
			namespace_GibServerUtils::function_GibLeftArm(self);
		}
	}
	else if(var_closestTag == "J_Shoulder_RI" || var_closestTag == "J_Elbow_RI" || var_closestTag == "J_Wrist_RI")
	{
		if(!namespace_GibServerUtils::function_IsGibbed(self, 32))
		{
			namespace_GibServerUtils::function_GibRightArm(self);
		}
	}
	else if(var_closestTag == "J_Hip_LE" || var_closestTag == "J_Knee_LE" || var_closestTag == "J_Ankle_LE")
	{
		if(isdefined(self.var_noCrawler) && self.var_noCrawler)
		{
			return;
		}
		namespace_GibServerUtils::function_GibLeftLeg(self);
		if(function_RandomInt(100) > 75)
		{
			namespace_GibServerUtils::function_GibRightLeg(self);
		}
		self.var_missingLegs = 1;
	}
	else if(var_closestTag == "J_Hip_RI" || var_closestTag == "J_Knee_RI" || var_closestTag == "J_Ankle_RI")
	{
		if(isdefined(self.var_noCrawler) && self.var_noCrawler)
		{
			return;
		}
		namespace_GibServerUtils::function_GibRightLeg(self);
		if(function_RandomInt(100) > 75)
		{
			namespace_GibServerUtils::function_GibLeftLeg(self);
		}
		self.var_missingLegs = 1;
	}
}

/*
	Name: function_init_gib_tags
	Namespace: namespace_zombie_utility
	Checksum: 0x424F4353
	Offset: 0x74A8
	Size: 0x150
	Parameters: 0
	Flags: None
	Line Number: 3936
*/
function function_init_gib_tags()
{
	var_tags = [];
	var_tags[var_tags.size] = "J_SpineLower";
	var_tags[var_tags.size] = "J_SpineUpper";
	var_tags[var_tags.size] = "J_Spine4";
	var_tags[var_tags.size] = "J_Shoulder_LE";
	var_tags[var_tags.size] = "J_Elbow_LE";
	var_tags[var_tags.size] = "J_Wrist_LE";
	var_tags[var_tags.size] = "J_Shoulder_RI";
	var_tags[var_tags.size] = "J_Elbow_RI";
	var_tags[var_tags.size] = "J_Wrist_RI";
	var_tags[var_tags.size] = "J_Hip_LE";
	var_tags[var_tags.size] = "J_Knee_LE";
	var_tags[var_tags.size] = "J_Ankle_LE";
	var_tags[var_tags.size] = "J_Hip_RI";
	var_tags[var_tags.size] = "J_Knee_RI";
	var_tags[var_tags.size] = "J_Ankle_RI";
	level.var_gib_tags = var_tags;
}

/*
	Name: function_getAnimDirection
	Namespace: namespace_zombie_utility
	Checksum: 0x424F4353
	Offset: 0x7600
	Size: 0x98
	Parameters: 1
	Flags: None
	Line Number: 3967
*/
function function_getAnimDirection(var_damageyaw)
{
	if(var_damageyaw > 135 || var_damageyaw <= -135)
	{
		return "front";
	}
	else if(var_damageyaw > 45 && var_damageyaw <= 135)
	{
		return "right";
	}
	else if(var_damageyaw > -45 && var_damageyaw <= 45)
	{
		return "back";
	}
	else
	{
		return "left";
	}
	return "front";
}

/*
	Name: function_anim_get_dvar_int
	Namespace: namespace_zombie_utility
	Checksum: 0x424F4353
	Offset: 0x76A0
	Size: 0x48
	Parameters: 2
	Flags: None
	Line Number: 3998
*/
function function_anim_get_dvar_int(var_dvar, var_def)
{
	return function_Int(function_anim_get_dvar(var_dvar, var_def));
}

/*
	Name: function_anim_get_dvar
	Namespace: namespace_zombie_utility
	Checksum: 0x424F4353
	Offset: 0x76F0
	Size: 0x78
	Parameters: 2
	Flags: None
	Line Number: 4013
*/
function function_anim_get_dvar(var_dvar, var_def)
{
	if(function_GetDvarString(var_dvar) != "")
	{
		return function_GetDvarFloat(var_dvar);
	}
	else
	{
		function_SetDvar(var_dvar, var_def);
		return var_def;
		return;
	}
	~;
}

/*
	Name: function_makeZombieCrawler
	Namespace: namespace_zombie_utility
	Checksum: 0x424F4353
	Offset: 0x7770
	Size: 0x170
	Parameters: 1
	Flags: None
	Line Number: 4038
*/
function function_makeZombieCrawler(var_b_both_legs)
{
	if(isdefined(var_b_both_legs) && var_b_both_legs)
	{
		var_VAL = 100;
	}
	else
	{
		var_VAL = function_RandomInt(100);
	}
	if(var_VAL > 75)
	{
		namespace_GibServerUtils::function_GibRightLeg(self);
		namespace_GibServerUtils::function_GibLeftLeg(self);
	}
	else if(var_VAL > 37)
	{
		namespace_GibServerUtils::function_GibRightLeg(self);
	}
	else
	{
		namespace_GibServerUtils::function_GibLeftLeg(self);
	}
	self.var_missingLegs = 1;
	self function_AllowedStances("crouch");
	self function_setPhysParams(15, 0, 24);
	self function_AllowPitchAngle(1);
	self function_SetPitchOrient();
	var_health = self.var_health;
	var_health = var_health * 0.1;
}

/*
	Name: function_zombie_head_gib
	Namespace: namespace_zombie_utility
	Checksum: 0x424F4353
	Offset: 0x78E8
	Size: 0xE0
	Parameters: 2
	Flags: None
	Line Number: 4080
*/
function function_zombie_head_gib(var_attacker, var_means_of_death)
{
	self endon("hash_death");
	if(isdefined(self.var_head_gibbed) && self.var_head_gibbed)
	{
		return;
	}
	if(isdefined(self.var_no_gib) && self.var_no_gib)
	{
		return;
	}
	self.var_head_gibbed = 1;
	self function_zombie_eye_glow_stop();
	if(!(isdefined(self.var_disable_head_gib) && self.var_disable_head_gib))
	{
		namespace_GibServerUtils::function_GibHead(self);
	}
	self thread function_head_gib_damage_over_time(function_ceil(self.var_health * 0.2), 1, var_attacker, var_means_of_death);
}

/*
	Name: function_gib_random_parts
	Namespace: namespace_zombie_utility
	Checksum: 0x424F4353
	Offset: 0x79D0
	Size: 0x198
	Parameters: 0
	Flags: None
	Line Number: 4110
*/
function function_gib_random_parts()
{
	if(isdefined(self.var_no_gib) && self.var_no_gib)
	{
		return;
	}
	var_VAL = function_RandomInt(100);
	if(var_VAL > 50)
	{
		self function_zombie_head_gib();
	}
	var_VAL = function_RandomInt(100);
	if(var_VAL > 50)
	{
		namespace_GibServerUtils::function_GibRightLeg(self);
	}
	var_VAL = function_RandomInt(100);
	if(var_VAL > 50)
	{
		namespace_GibServerUtils::function_GibLeftLeg(self);
	}
	var_VAL = function_RandomInt(100);
	if(var_VAL > 50)
	{
		if(!namespace_GibServerUtils::function_IsGibbed(self, 32))
		{
			namespace_GibServerUtils::function_GibRightArm(self);
		}
	}
	var_VAL = function_RandomInt(100);
	if(var_VAL > 50)
	{
		if(!namespace_GibServerUtils::function_IsGibbed(self, 16))
		{
			namespace_GibServerUtils::function_GibLeftArm(self);
		}
	}
}

/*
	Name: function_init_ignore_player_handler
	Namespace: namespace_zombie_utility
	Checksum: 0x424F4353
	Offset: 0x7B70
	Size: 0x10
	Parameters: 0
	Flags: AutoExec
	Line Number: 4159
*/
function autoexec function_init_ignore_player_handler()
{
	level.var__IGNORE_PLAYER_HANDLER = [];
}

/*
	Name: function_register_ignore_player_handler
	Namespace: namespace_zombie_utility
	Checksum: 0x424F4353
	Offset: 0x7B88
	Size: 0x90
	Parameters: 2
	Flags: None
	Line Number: 4174
*/
function function_register_ignore_player_handler(var_archetype, var_ignore_player_func)
{
	/#
		namespace_::function_Assert(isdefined(var_archetype), "Dev Block strings are not supported");
	#/
	/#
		namespace_::function_Assert(!isdefined(level.var__IGNORE_PLAYER_HANDLER[var_archetype]), "Dev Block strings are not supported" + var_archetype + "Dev Block strings are not supported");
	#/
	level.var__IGNORE_PLAYER_HANDLER[var_archetype] = var_ignore_player_func;
}

/*
	Name: function_run_ignore_player_handler
	Namespace: namespace_zombie_utility
	Checksum: 0x424F4353
	Offset: 0x7C20
	Size: 0x38
	Parameters: 0
	Flags: None
	Line Number: 4195
*/
function function_run_ignore_player_handler()
{
	if(isdefined(level.var__IGNORE_PLAYER_HANDLER[self.var_archetype]))
	{
		self [[level.var__IGNORE_PLAYER_HANDLER[self.var_archetype]]]();
	}
}

/*
	Name: function_show_hit_marker
	Namespace: namespace_zombie_utility
	Checksum: 0x424F4353
	Offset: 0x7C60
	Size: 0x88
	Parameters: 0
	Flags: None
	Line Number: 4213
*/
function function_show_hit_marker()
{
	if(isdefined(self) && isdefined(self.var_hud_damagefeedback))
	{
		self.var_hud_damagefeedback function_SetShader("damage_feedback", 24, 48);
		self.var_hud_damagefeedback.var_alpha = 1;
		self.var_hud_damagefeedback function_fadeOverTime(1);
		self.var_hud_damagefeedback.var_alpha = 0;
	}
}

