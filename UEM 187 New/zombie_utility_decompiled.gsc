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

#namespace zombie_utility;

/*
	Name: zombieSpawnSetup
	Namespace: zombie_utility
	Checksum: 0x424F4353
	Offset: 0x758
	Size: 0xD0
	Parameters: 0
	Flags: None
	Line Number: 28
*/
function zombieSpawnSetup()
{
	self.zombie_move_speed = "walk";
	if(!isdefined(self.zombie_arms_position))
	{
		if(randomint(2) == 0)
		{
			self.zombie_arms_position = "up";
		}
		else
		{
			self.zombie_arms_position = "down";
		}
	}
	self.missingLegs = 0;
	self SetAvoidanceMask("avoid none");
	self PushActors(1);
	clientfield::set("zombie", 1);
	self.ignorepathenemyfightdist = 1;
}

/*
	Name: get_closest_valid_player
	Namespace: zombie_utility
	Checksum: 0x424F4353
	Offset: 0x830
	Size: 0x2E8
	Parameters: 3
	Flags: None
	Line Number: 59
*/
function get_closest_valid_player(origin, ignore_player, ignore_laststand_players)
{
	if(!isdefined(ignore_laststand_players))
	{
		ignore_laststand_players = 0;
	}
	PixBeginEvent("get_closest_valid_player");
	valid_player_found = 0;
	targets = getplayers();
	if(isdefined(level.closest_player_targets_override))
	{
		targets = [[level.closest_player_targets_override]]();
	}
	if(isdefined(ignore_player))
	{
		for(i = 0; i < ignore_player.size; i++)
		{
			arrayremovevalue(targets, ignore_player[i]);
		}
	}
	done = 1;
	while(targets.size && !done)
	{
		done = 1;
		for(i = 0; i < targets.size; i++)
		{
			target = targets[i];
			if(!is_player_valid(target, 1, ignore_laststand_players))
			{
				arrayremovevalue(targets, target);
				done = 0;
				break;
			}
		}
	}
	if(targets.size == 0)
	{
		PixEndEvent();
		return undefined;
	}
	if(isdefined(self.closest_player_override))
	{
		target = [[self.closest_player_override]](origin, targets);
	}
	else if(isdefined(level.closest_player_override))
	{
		target = [[level.closest_player_override]](origin, targets);
	}
	if(isdefined(target))
	{
		PixEndEvent();
		return target;
	}
	sortedPotentialTargets = arraysortclosest(targets, self.origin);
	while(sortedPotentialTargets.size)
	{
		if(is_player_valid(sortedPotentialTargets[0], 1, ignore_laststand_players))
		{
			PixEndEvent();
			return sortedPotentialTargets[0];
		}
		arrayremovevalue(sortedPotentialTargets, sortedPotentialTargets[0]);
	}
	PixEndEvent();
	return undefined;
}

/*
	Name: is_player_valid
	Namespace: zombie_utility
	Checksum: 0x424F4353
	Offset: 0xB20
	Size: 0x1A0
	Parameters: 3
	Flags: None
	Line Number: 136
*/
function is_player_valid(player, checkIgnoreMeFlag, ignore_laststand_players)
{
	if(!isdefined(player))
	{
		return 0;
	}
	if(!isalive(player))
	{
		return 0;
	}
	if(!isplayer(player))
	{
		return 0;
	}
	if(isdefined(player.is_zombie) && player.is_zombie == 1)
	{
		return 0;
	}
	if(player.sessionstate == "spectator")
	{
		return 0;
	}
	if(player.sessionstate == "intermission")
	{
		return 0;
	}
	if(isdefined(player.intermission) && player.intermission)
	{
		return 0;
	}
	if(!(isdefined(ignore_laststand_players) && ignore_laststand_players))
	{
		if(player laststand::player_is_in_laststand())
		{
			return 0;
		}
	}
	if(player isnotarget())
	{
		return 0;
	}
	if(isdefined(checkIgnoreMeFlag) && checkIgnoreMeFlag && player.ignoreme)
	{
		return 0;
	}
	if(isdefined(level.is_player_valid_override))
	{
		return [[level.is_player_valid_override]](player);
	}
	return 1;
}

/*
	Name: append_missing_legs_suffix
	Namespace: zombie_utility
	Checksum: 0x424F4353
	Offset: 0xCC8
	Size: 0x50
	Parameters: 1
	Flags: None
	Line Number: 198
*/
function append_missing_legs_suffix(animstate)
{
	if(self.missingLegs && self HasAnimStateFromASD(animstate + "_crawl"))
	{
		return animstate + "_crawl";
	}
	return animstate;
}

/*
	Name: initAnimTree
	Namespace: zombie_utility
	Checksum: 0x424F4353
	Offset: 0xD20
	Size: 0x80
	Parameters: 1
	Flags: None
	Line Number: 217
*/
function initAnimTree(animscript)
{
	if(animscript != "pain" && animscript != "death")
	{
		self.a.special = "none";
	}
	/#
		Assert(isdefined(animscript), "Dev Block strings are not supported");
	#/
	self.a.script = animscript;
}

/*
	Name: UpdateAnimPose
	Namespace: zombie_utility
	Checksum: 0x424F4353
	Offset: 0xDA8
	Size: 0xA8
	Parameters: 0
	Flags: None
	Line Number: 239
*/
function UpdateAnimPose()
{
	/#
		Assert(self.a.movement == "Dev Block strings are not supported" || self.a.movement == "Dev Block strings are not supported" || self.a.movement == "Dev Block strings are not supported", "Dev Block strings are not supported" + self.a.pose + "Dev Block strings are not supported" + self.a.movement);
	#/
	self.desired_anim_pose = undefined;
}

/*
	Name: Initialize
	Namespace: zombie_utility
	Checksum: 0x424F4353
	Offset: 0xE58
	Size: 0x218
	Parameters: 1
	Flags: None
	Line Number: 257
*/
function Initialize(animscript)
{
	if(isdefined(self.longDeathStarting))
	{
		if(animscript != "pain" && animscript != "death")
		{
			self dodamage(self.health + 100, self.origin);
		}
		if(animscript != "pain")
		{
			self.longDeathStarting = undefined;
			self notify("kill_long_death");
		}
	}
	if(isdefined(self.a.mayOnlyDie) && animscript != "death")
	{
		self dodamage(self.health + 100, self.origin);
	}
	if(isdefined(self.a.postScriptFunc))
	{
		scriptFunc = self.a.postScriptFunc;
		self.a.postScriptFunc = undefined;
		[[scriptFunc]](animscript);
	}
	if(animscript != "death")
	{
		self.a.nodeath = 0;
	}
	self.isHoldingGrenade = undefined;
	self.coverNode = undefined;
	self.changingCoverPos = 0;
	self.a.scriptStartTime = GetTime();
	self.a.atConcealmentNode = 0;
	if(isdefined(self.node) && (self.node.type == "Conceal Crouch" || self.node.type == "Conceal Stand"))
	{
		self.a.atConcealmentNode = 1;
	}
	initAnimTree(animscript);
	UpdateAnimPose();
	return;
	ERROR: Exception occured: Stack empty.
}

/*
	Name: GetNodeYawToOrigin
	Namespace: zombie_utility
	Checksum: 0x424F4353
	Offset: 0x1078
	Size: 0xA8
	Parameters: 1
	Flags: None
	Line Number: 310
*/
function GetNodeYawToOrigin(pos)
{
	if(isdefined(self.node))
	{
		yaw = self.node.angles[1] - GetYaw(pos);
	}
	else
	{
		yaw = self.angles[1] - GetYaw(pos);
	}
	yaw = angleclamp180(yaw);
	return yaw;
}

/*
	Name: GetNodeYawToEnemy
	Namespace: zombie_utility
	Checksum: 0x424F4353
	Offset: 0x1128
	Size: 0x160
	Parameters: 0
	Flags: None
	Line Number: 334
*/
function GetNodeYawToEnemy()
{
	pos = undefined;
	if(isValidEnemy(self.enemy))
	{
		pos = self.enemy.origin;
	}
	else if(isdefined(self.node))
	{
		forward = anglestoforward(self.node.angles);
	}
	else
	{
		forward = anglestoforward(self.angles);
	}
	forward = VectorScale(forward, 150);
	pos = self.origin + forward;
	if(isdefined(self.node))
	{
		yaw = self.node.angles[1] - GetYaw(pos);
	}
	else
	{
		yaw = self.angles[1] - GetYaw(pos);
	}
	yaw = angleclamp180(yaw);
	return yaw;
}

/*
	Name: GetCoverNodeYawToEnemy
	Namespace: zombie_utility
	Checksum: 0x424F4353
	Offset: 0x1290
	Size: 0x148
	Parameters: 0
	Flags: None
	Line Number: 373
*/
function GetCoverNodeYawToEnemy()
{
	pos = undefined;
	if(isValidEnemy(self.enemy))
	{
		pos = self.enemy.origin;
	}
	else
	{
		forward = anglestoforward(self.coverNode.angles + self.animarray["angle_step_out"][self.a.cornerMode]);
		forward = VectorScale(forward, 150);
		pos = self.origin + forward;
	}
	yaw = self.coverNode.angles[1] + self.animarray["angle_step_out"][self.a.cornerMode] - GetYaw(pos);
	yaw = angleclamp180(yaw);
	return yaw;
}

/*
	Name: GetYawToSpot
	Namespace: zombie_utility
	Checksum: 0x424F4353
	Offset: 0x13E0
	Size: 0x78
	Parameters: 1
	Flags: None
	Line Number: 401
*/
function GetYawToSpot(spot)
{
	pos = spot;
	yaw = self.angles[1] - GetYaw(pos);
	yaw = angleclamp180(yaw);
	return yaw;
	ERROR: Exception occured: Stack empty.
	ERROR: Bad function call
}

/*
	Name: getYawToEnemy
	Namespace: zombie_utility
	Checksum: 0x424F4353
	Offset: 0x1460
	Size: 0xE8
	Parameters: 0
	Flags: None
	Line Number: 421
*/
function getYawToEnemy()
{
	pos = undefined;
	if(isValidEnemy(self.enemy))
	{
		pos = self.enemy.origin;
	}
	else
	{
		forward = anglestoforward(self.angles);
		forward = VectorScale(forward, 150);
		pos = self.origin + forward;
	}
	yaw = self.angles[1] - GetYaw(pos);
	yaw = angleclamp180(yaw);
	return yaw;
}

/*
	Name: GetYaw
	Namespace: zombie_utility
	Checksum: 0x424F4353
	Offset: 0x1550
	Size: 0x48
	Parameters: 1
	Flags: None
	Line Number: 449
*/
function GetYaw(org)
{
	angles = vectortoangles(org - self.origin);
	return angles[1];
}

/*
	Name: GetYaw2d
	Namespace: zombie_utility
	Checksum: 0x424F4353
	Offset: 0x15A0
	Size: 0x70
	Parameters: 1
	Flags: None
	Line Number: 465
*/
function GetYaw2d(org)
{
	angles = vectortoangles((org[0], org[1], 0) - (self.origin[0], self.origin[1], 0));
	return angles[1];
}

/*
	Name: AbsYawToEnemy
	Namespace: zombie_utility
	Checksum: 0x424F4353
	Offset: 0x1618
	Size: 0xB0
	Parameters: 0
	Flags: None
	Line Number: 481
*/
function AbsYawToEnemy()
{
	/#
		Assert(isValidEnemy(self.enemy));
	#/
	yaw = self.angles[1] - GetYaw(self.enemy.origin);
	yaw = angleclamp180(yaw);
	if(yaw < 0)
	{
		yaw = -1 * yaw;
	}
	return yaw;
}

/*
	Name: AbsYawToEnemy2d
	Namespace: zombie_utility
	Checksum: 0x424F4353
	Offset: 0x16D0
	Size: 0xB0
	Parameters: 0
	Flags: None
	Line Number: 505
*/
function AbsYawToEnemy2d()
{
	/#
		Assert(isValidEnemy(self.enemy));
	#/
	yaw = self.angles[1] - GetYaw2d(self.enemy.origin);
	yaw = angleclamp180(yaw);
	if(yaw < 0)
	{
		yaw = -1 * yaw;
	}
	return yaw;
}

/*
	Name: AbsYawToOrigin
	Namespace: zombie_utility
	Checksum: 0x424F4353
	Offset: 0x1788
	Size: 0x78
	Parameters: 1
	Flags: None
	Line Number: 529
*/
function AbsYawToOrigin(org)
{
	yaw = self.angles[1] - GetYaw(org);
	yaw = angleclamp180(yaw);
	if(yaw < 0)
	{
		yaw = -1 * yaw;
	}
	return yaw;
}

/*
	Name: AbsYawToAngles
	Namespace: zombie_utility
	Checksum: 0x424F4353
	Offset: 0x1808
	Size: 0x68
	Parameters: 1
	Flags: None
	Line Number: 550
*/
function AbsYawToAngles(angles)
{
	yaw = self.angles[1] - angles;
	yaw = angleclamp180(yaw);
	if(yaw < 0)
	{
		yaw = -1 * yaw;
	}
	return yaw;
}

/*
	Name: GetYawFromOrigin
	Namespace: zombie_utility
	Checksum: 0x424F4353
	Offset: 0x1878
	Size: 0x50
	Parameters: 2
	Flags: None
	Line Number: 571
*/
function GetYawFromOrigin(org, start)
{
	angles = vectortoangles(org - start);
	return angles[1];
}

/*
	Name: GetYawToTag
	Namespace: zombie_utility
	Checksum: 0x424F4353
	Offset: 0x18D0
	Size: 0x90
	Parameters: 2
	Flags: None
	Line Number: 587
*/
function GetYawToTag(tag, org)
{
	yaw = self gettagangles(tag)[1] - GetYawFromOrigin(org, self gettagorigin(tag));
	yaw = angleclamp180(yaw);
	return yaw;
	ERROR: Exception occured: Stack empty.
}

/*
	Name: GetYawToOrigin
	Namespace: zombie_utility
	Checksum: 0x424F4353
	Offset: 0x1968
	Size: 0x60
	Parameters: 1
	Flags: None
	Line Number: 605
*/
function GetYawToOrigin(org)
{
	yaw = self.angles[1] - GetYaw(org);
	yaw = angleclamp180(yaw);
	return yaw;
}

/*
	Name: GetEyeYawToOrigin
	Namespace: zombie_utility
	Checksum: 0x424F4353
	Offset: 0x19D0
	Size: 0x78
	Parameters: 1
	Flags: None
	Line Number: 622
*/
function GetEyeYawToOrigin(org)
{
	yaw = self gettagangles("TAG_EYE")[1] - GetYaw(org);
	yaw = angleclamp180(yaw);
	return yaw;
}

/*
	Name: GetCoverNodeYawToOrigin
	Namespace: zombie_utility
	Checksum: 0x424F4353
	Offset: 0x1A50
	Size: 0x90
	Parameters: 1
	Flags: None
	Line Number: 639
*/
function GetCoverNodeYawToOrigin(org)
{
	yaw = self.coverNode.angles[1] + self.animarray["angle_step_out"][self.a.cornerMode] - GetYaw(org);
	yaw = angleclamp180(yaw);
	return yaw;
}

/*
	Name: isStanceAllowedWrapper
	Namespace: zombie_utility
	Checksum: 0x424F4353
	Offset: 0x1AE8
	Size: 0x50
	Parameters: 1
	Flags: None
	Line Number: 656
*/
function isStanceAllowedWrapper(stance)
{
	if(isdefined(self.coverNode))
	{
		return self.coverNode doesNodeAllowStance(stance);
	}
	return self IsStanceAllowed(stance);
}

/*
	Name: GetClaimedNode
	Namespace: zombie_utility
	Checksum: 0x424F4353
	Offset: 0x1B40
	Size: 0x68
	Parameters: 0
	Flags: None
	Line Number: 675
*/
function GetClaimedNode()
{
	myNode = self.node;
	if(isdefined(myNode) && (self nearNode(myNode) || (isdefined(self.coverNode) && myNode == self.coverNode)))
	{
		return myNode;
	}
	return undefined;
}

/*
	Name: GetNodeType
	Namespace: zombie_utility
	Checksum: 0x424F4353
	Offset: 0x1BB0
	Size: 0x40
	Parameters: 0
	Flags: None
	Line Number: 695
*/
function GetNodeType()
{
	myNode = GetClaimedNode();
	if(isdefined(myNode))
	{
		return myNode.type;
	}
	return "none";
}

/*
	Name: GetNodeDirection
	Namespace: zombie_utility
	Checksum: 0x424F4353
	Offset: 0x1BF8
	Size: 0x48
	Parameters: 0
	Flags: None
	Line Number: 715
*/
function GetNodeDirection()
{
	myNode = GetClaimedNode();
	if(isdefined(myNode))
	{
		return myNode.angles[1];
	}
	return self.desiredAngle;
}

/*
	Name: GetNodeForward
	Namespace: zombie_utility
	Checksum: 0x424F4353
	Offset: 0x1C48
	Size: 0x68
	Parameters: 0
	Flags: None
	Line Number: 735
*/
function GetNodeForward()
{
	myNode = GetClaimedNode();
	if(isdefined(myNode))
	{
		return anglestoforward(myNode.angles);
	}
	return anglestoforward(self.angles);
}

/*
	Name: GetNodeOrigin
	Namespace: zombie_utility
	Checksum: 0x424F4353
	Offset: 0x1CB8
	Size: 0x40
	Parameters: 0
	Flags: None
	Line Number: 755
*/
function GetNodeOrigin()
{
	myNode = GetClaimedNode();
	if(isdefined(myNode))
	{
		return myNode.origin;
	}
	return self.origin;
}

/*
	Name: safemod
	Namespace: zombie_utility
	Checksum: 0x424F4353
	Offset: 0x1D00
	Size: 0x58
	Parameters: 2
	Flags: None
	Line Number: 775
*/
function safemod(a, b)
{
	result = int(a) % b;
	result = result + b;
	return result % b;
}

/*
	Name: AngleClamp
	Namespace: zombie_utility
	Checksum: 0x424F4353
	Offset: 0x1D60
	Size: 0x58
	Parameters: 1
	Flags: None
	Line Number: 792
*/
function AngleClamp(angle)
{
	angleFrac = angle / 360;
	angle = angleFrac - floor(angleFrac) * 360;
	return angle;
	ERROR: Exception occured: Stack empty.
}

/*
	Name: QuadrantAnimWeights
	Namespace: zombie_utility
	Checksum: 0x424F4353
	Offset: 0x1DC0
	Size: 0x268
	Parameters: 1
	Flags: None
	Line Number: 810
*/
function QuadrantAnimWeights(yaw)
{
	forwardWeight = 90 - abs(yaw) / 90;
	leftWeight = 90 - AbsAngleClamp180(abs(yaw - 90)) / 90;
	result["front"] = 0;
	result["right"] = 0;
	result["back"] = 0;
	result["left"] = 0;
	if(isdefined(self.alwaysRunForward))
	{
		/#
			Assert(self.alwaysRunForward);
		#/
		result["front"] = 1;
		return result;
	}
	useLeans = getdvarint("ai_useLeanRunAnimations");
	if(forwardWeight > 0)
	{
		result["front"] = forwardWeight;
		if(leftWeight > 0)
		{
			result["left"] = leftWeight;
		}
		else
		{
			result["right"] = -1 * leftWeight;
		}
	}
	else if(useLeans)
	{
		result["back"] = -1 * forwardWeight;
		if(leftWeight > 0)
		{
			result["left"] = leftWeight;
		}
		else
		{
			result["right"] = -1 * leftWeight;
		}
	}
	else
	{
		backWeight = -1 * forwardWeight;
		if(leftWeight > backWeight)
		{
			result["left"] = 1;
		}
		else if(leftWeight < forwardWeight)
		{
			result["right"] = 1;
		}
		else
		{
			result["back"] = 1;
		}
	}
	return result;
	ERROR: Exception occured: Stack empty.
}

/*
	Name: getQuadrant
	Namespace: zombie_utility
	Checksum: 0x424F4353
	Offset: 0x2030
	Size: 0xB0
	Parameters: 1
	Flags: None
	Line Number: 881
*/
function getQuadrant(angle)
{
	angle = AngleClamp(angle);
	if(angle < 45 || angle > 315)
	{
		quadrant = "front";
	}
	else if(angle < 135)
	{
		quadrant = "left";
	}
	else if(angle < 225)
	{
		quadrant = "back";
	}
	else
	{
		quadrant = "right";
	}
	return quadrant;
}

/*
	Name: IsInSet
	Namespace: zombie_utility
	Checksum: 0x424F4353
	Offset: 0x20E8
	Size: 0x60
	Parameters: 2
	Flags: None
	Line Number: 913
*/
function IsInSet(input, set)
{
	for(i = set.size - 1; i >= 0; i--)
	{
		if(input == set[i])
		{
			return 1;
		}
	}
	return 0;
}

/*
	Name: NotifyAfterTime
	Namespace: zombie_utility
	Checksum: 0x424F4353
	Offset: 0x2150
	Size: 0x40
	Parameters: 3
	Flags: None
	Line Number: 935
*/
function NotifyAfterTime(notifyString, killmestring, time)
{
	self endon("death");
	self endon(killmestring);
	wait(time);
	self notify(notifyString);
}

/*
	Name: drawStringTime
	Namespace: zombie_utility
	Checksum: 0x424F4353
	Offset: 0x2198
	Size: 0x98
	Parameters: 4
	Flags: None
	Line Number: 953
*/
function drawStringTime(msg, org, color, timer)
{
	/#
		maxtime = timer * 20;
		for(i = 0; i < maxtime; i++)
		{
			print3d(org, msg, color, 1, 1);
			wait(0.05);
		}
	#/
}

/*
	Name: showLastEnemySightPos
	Namespace: zombie_utility
	Checksum: 0x424F4353
	Offset: 0x2238
	Size: 0x100
	Parameters: 1
	Flags: None
	Line Number: 975
*/
function showLastEnemySightPos(string)
{
	/#
		self notify("got known enemy2");
		self endon("got known enemy2");
		self endon("death");
		if(!isValidEnemy(self.enemy))
		{
			return;
		}
		if(self.enemy.team == "Dev Block strings are not supported")
		{
			color = (0.4, 0.7, 1);
		}
		else
		{
			color = (1, 0.7, 0.4);
		}
		while(1)
		{
			wait(0.05);
			if(!isdefined(self.lastEnemySightPos))
			{
				continue;
			}
			print3d(self.lastEnemySightPos, string, color, 1, 2.15);
		}
	#/
}

/*
	Name: debugTimeout
	Namespace: zombie_utility
	Checksum: 0x424F4353
	Offset: 0x2340
	Size: 0x18
	Parameters: 0
	Flags: None
	Line Number: 1015
*/
function debugTimeout()
{
	wait(5);
	self notify("timeout");
}

/*
	Name: debugPosInternal
	Namespace: zombie_utility
	Checksum: 0x424F4353
	Offset: 0x2360
	Size: 0x120
	Parameters: 3
	Flags: None
	Line Number: 1031
*/
function debugPosInternal(org, string, size)
{
	/#
		self endon("death");
		self notify("Dev Block strings are not supported" + org);
		self endon("Dev Block strings are not supported" + org);
		ent = spawnstruct();
		ent thread debugTimeout();
		ent endon("timeout");
		if(self.enemy.team == "Dev Block strings are not supported")
		{
			color = (0.4, 0.7, 1);
		}
		else
		{
			color = (1, 0.7, 0.4);
		}
		while(1)
		{
			wait(0.05);
			print3d(org, string, color, 1, size);
		}
	#/
}

/*
	Name: debugPos
	Namespace: zombie_utility
	Checksum: 0x424F4353
	Offset: 0x2488
	Size: 0x38
	Parameters: 2
	Flags: None
	Line Number: 1066
*/
function debugPos(org, string)
{
	thread debugPosInternal(org, string, 2.15);
}

/*
	Name: debugPosSize
	Namespace: zombie_utility
	Checksum: 0x424F4353
	Offset: 0x24C8
	Size: 0x40
	Parameters: 3
	Flags: None
	Line Number: 1081
*/
function debugPosSize(org, string, size)
{
	thread debugPosInternal(org, string, size);
}

/*
	Name: showDebugProc
	Namespace: zombie_utility
	Checksum: 0x424F4353
	Offset: 0x2510
	Size: 0xA0
	Parameters: 4
	Flags: None
	Line Number: 1096
*/
function showDebugProc(fromPoint, toPoint, color, printTime)
{
	/#
		self endon("death");
		timer = printTime * 20;
		for(i = 0; i < timer; i = 0)
		{
			wait(0.05);
			line(fromPoint, toPoint, color);
		}
	#/
}

/*
	Name: showDebugLine
	Namespace: zombie_utility
	Checksum: 0x424F4353
	Offset: 0x25B8
	Size: 0x60
	Parameters: 4
	Flags: None
	Line Number: 1119
*/
function showDebugLine(fromPoint, toPoint, color, printTime)
{
	self thread showDebugProc(fromPoint, toPoint + VectorScale((0, 0, -1), 5), color, printTime);
	return;
	++;
}

/*
	Name: getNodeOffset
	Namespace: zombie_utility
	Checksum: 0x424F4353
	Offset: 0x2620
	Size: 0x340
	Parameters: 1
	Flags: None
	Line Number: 1136
*/
function getNodeOffset(node)
{
	if(isdefined(node.offset))
	{
		return node.offset;
	}
	cover_left_crouch_offset = (-26, 0.4, 36);
	cover_left_stand_offset = (-32, 7, 63);
	cover_right_crouch_offset = (43.5, 11, 36);
	cover_right_stand_offset = (36, 8.3, 63);
	cover_crouch_offset = (3.5, -12.5, 45);
	cover_stand_offset = (-3.7, -22, 63);
	cornernode = 0;
	nodeOffset = (0, 0, 0);
	right = anglestoright(node.angles);
	forward = anglestoforward(node.angles);
	switch(node.type)
	{
		case "Cover Left":
		case "Cover Left Wide":
		{
			if(node isNodeDontStand() && !node isNodeDontCrouch())
			{
				nodeOffset = calculateNodeOffset(right, forward, cover_left_crouch_offset);
			}
			else
			{
				nodeOffset = calculateNodeOffset(right, forward, cover_left_stand_offset);
				break;
			}
		}
		case "Cover Right":
		case "Cover Right Wide":
		{
			if(node isNodeDontStand() && !node isNodeDontCrouch())
			{
				nodeOffset = calculateNodeOffset(right, forward, cover_right_crouch_offset);
			}
			else
			{
				nodeOffset = calculateNodeOffset(right, forward, cover_right_stand_offset);
				break;
			}
		}
		case "Conceal Stand":
		case "Cover Stand":
		case "Turret":
		{
			nodeOffset = calculateNodeOffset(right, forward, cover_stand_offset);
			break;
		}
		case "Conceal Crouch":
		case "Cover Crouch":
		case "Cover Crouch Window":
		{
			nodeOffset = calculateNodeOffset(right, forward, cover_crouch_offset);
			break;
		}
	}
	node.offset = nodeOffset;
	return node.offset;
}

/*
	Name: calculateNodeOffset
	Namespace: zombie_utility
	Checksum: 0x424F4353
	Offset: 0x2968
	Size: 0x50
	Parameters: 3
	Flags: None
	Line Number: 1209
*/
function calculateNodeOffset(right, forward, baseoffset)
{
	return VectorScale(right, baseoffset[0]) + VectorScale(forward, baseoffset[1]) + (0, 0, baseoffset[2]);
}

/*
	Name: checkPitchVisibility
	Namespace: zombie_utility
	Checksum: 0x424F4353
	Offset: 0x29C0
	Size: 0xE8
	Parameters: 3
	Flags: None
	Line Number: 1224
*/
function checkPitchVisibility(fromPoint, toPoint, atNode)
{
	pitch = angleclamp180(vectortoangles(toPoint - fromPoint)[0]);
	if(abs(pitch) > 45)
	{
		if(isdefined(atNode) && atNode.type != "Cover Crouch" && atNode.type != "Conceal Crouch")
		{
			return 0;
		}
		if(pitch > 45 || pitch < anim.coverCrouchLeanPitch - 45)
		{
			return 0;
		}
	}
	return 1;
}

/*
	Name: showLines
	Namespace: zombie_utility
	Checksum: 0x424F4353
	Offset: 0x2AB0
	Size: 0x78
	Parameters: 3
	Flags: None
	Line Number: 1251
*/
function showLines(start, end, end2)
{
	/#
		for(;;)
		{
			line(start, end, (1, 0, 0), 1);
			wait(0.05);
			line(start, end2, (0, 0, 1), 1);
			wait(0.05);
		}
	#/
}

/*
	Name: anim_array
	Namespace: zombie_utility
	Checksum: 0x424F4353
	Offset: 0x2B30
	Size: 0x198
	Parameters: 2
	Flags: None
	Line Number: 1274
*/
function anim_array(animarray, animWeights)
{
	total_anims = animarray.size;
	idleanim = randomint(total_anims);
	/#
		Assert(total_anims);
	#/
	/#
		Assert(animarray.size == animWeights.size);
	#/
	if(total_anims == 1)
	{
		return animarray[0];
	}
	weights = 0;
	total_weight = 0;
	for(i = 0; i < total_anims; i++)
	{
		total_weight = total_weight + animWeights[i];
	}
	anim_play = randomfloat(total_weight);
	current_weight = 0;
	for(i = 0; i < total_anims; i++)
	{
		current_weight = current_weight + animWeights[i];
		if(anim_play >= current_weight)
		{
			continue;
		}
		idleanim = i;
		break;
	}
	return animarray[idleanim];
}

/*
	Name: notForcedCover
	Namespace: zombie_utility
	Checksum: 0x424F4353
	Offset: 0x2CD0
	Size: 0x38
	Parameters: 0
	Flags: None
	Line Number: 1319
*/
function notForcedCover()
{
	return self.a.forced_cover == "none" || self.a.forced_cover == "Show";
}

/*
	Name: forcedCover
	Namespace: zombie_utility
	Checksum: 0x424F4353
	Offset: 0x2D10
	Size: 0x38
	Parameters: 1
	Flags: None
	Line Number: 1334
*/
function forcedCover(msg)
{
	return isdefined(self.a.forced_cover) && self.a.forced_cover == msg;
}

/*
	Name: print3dtime
	Namespace: zombie_utility
	Checksum: 0x424F4353
	Offset: 0x2D50
	Size: 0xA8
	Parameters: 6
	Flags: None
	Line Number: 1349
*/
function print3dtime(timer, org, msg, color, alpha, scale)
{
	/#
		newTime = timer / 0.05;
		for(i = 0; i < newTime; i++)
		{
			print3d(org, msg, color, alpha, scale);
			wait(0.05);
		}
	#/
}

/*
	Name: print3drise
	Namespace: zombie_utility
	Checksum: 0x424F4353
	Offset: 0x2E00
	Size: 0xD8
	Parameters: 5
	Flags: None
	Line Number: 1371
*/
function print3drise(org, msg, color, alpha, scale)
{
	/#
		newTime = 100;
		up = 0;
		org = org;
		for(i = 0; i < newTime; i++)
		{
			up = up + 0.5;
			print3d(org + (0, 0, up), msg, color, alpha, scale);
			wait(0.05);
		}
		return;
	#/
	ERROR: Bad function call
}

/*
	Name: crossproduct
	Namespace: zombie_utility
	Checksum: 0x424F4353
	Offset: 0x2EE0
	Size: 0x48
	Parameters: 2
	Flags: None
	Line Number: 1398
*/
function crossproduct(vec1, vec2)
{
	return vec1[0] * vec2[1] - vec1[1] * vec2[0] > 0;
}

/*
	Name: scriptChange
	Namespace: zombie_utility
	Checksum: 0x424F4353
	Offset: 0x2F30
	Size: 0x30
	Parameters: 0
	Flags: None
	Line Number: 1413
*/
function scriptChange()
{
System.IO.EndOfStreamException: Unable to read beyond the end of the stream.
   at System.IO.__Error.EndOfFile()
   at System.IO.BinaryReader.FillBuffer(Int32 numBytes)
   at System.IO.BinaryReader.ReadInt32()
   at Cerberus.Logic.BlackOps3Script.LoadEndSwitch()
   at Cerberus.Logic.Decompiler.FindSwitchCase()
   at Cerberus.Logic.Decompiler..ctor(ScriptExport function, ScriptBase script)
}

/*
	Name: delayedScriptChange
	Namespace: zombie_utility
	Checksum: 0x424F4353
	Offset: 0x2F68
	Size: 0x20
	Parameters: 0
	Flags: None
	Line Number: 1434
*/
function delayedScriptChange()
{
	wait(0.05);
	scriptChange();
	return;
	ERROR: Exception occured: Stack empty.
}

/*
	Name: sawEnemyMove
	Namespace: zombie_utility
	Checksum: 0x424F4353
	Offset: 0x2F90
	Size: 0x38
	Parameters: 1
	Flags: None
	Line Number: 1452
*/
function sawEnemyMove(timer)
{
	if(!isdefined(timer))
	{
		timer = 500;
	}
	return GetTime() - self.personalSightTime < timer;
	ERROR: Bad function call
}

/*
	Name: canThrowGrenade
	Namespace: zombie_utility
	Checksum: 0x424F4353
	Offset: 0x2FD0
	Size: 0x40
	Parameters: 0
	Flags: None
	Line Number: 1472
*/
function canThrowGrenade()
{
	if(!self.grenadeAmmo)
	{
		return 0;
	}
	if(self.script_forceGrenade)
	{
		return 1;
	}
	return isplayer(self.enemy);
	ERROR: Exception occured: Stack empty.
}

/*
	Name: random_weight
	Namespace: zombie_utility
	Checksum: 0x424F4353
	Offset: 0x3018
	Size: 0x110
	Parameters: 1
	Flags: None
	Line Number: 1496
*/
function random_weight(array)
{
	idleanim = randomint(array.size);
	if(array.size > 1)
	{
		anim_weight = 0;
		for(i = 0; i < array.size; i++)
		{
			anim_weight = anim_weight + array[i];
		}
		anim_play = randomfloat(anim_weight);
		anim_weight = 0;
		for(i = 0; i < array.size; i++)
		{
			anim_weight = anim_weight + array[i];
			if(anim_play < anim_weight)
			{
				idleanim = i;
				break;
			}
		}
	}
	return idleanim;
}

/*
	Name: setFootstepEffect
	Namespace: zombie_utility
	Checksum: 0x424F4353
	Offset: 0x3130
	Size: 0xD8
	Parameters: 2
	Flags: None
	Line Number: 1531
*/
function setFootstepEffect(name, fx)
{
	/#
		Assert(isdefined(name), "Dev Block strings are not supported");
	#/
	/#
		Assert(isdefined(fx), "Dev Block strings are not supported");
	#/
	if(!isdefined(anim.optionalStepEffects))
	{
		anim.optionalStepEffects = [];
	}
	anim.optionalStepEffects[anim.optionalStepEffects.size] = name;
	level._effect["step_" + name] = fx;
	anim.optionalStepEffectFunction = &zombie_shared::playFootStepEffect;
}

/*
	Name: persistentDebugLine
	Namespace: zombie_utility
	Checksum: 0x424F4353
	Offset: 0x3210
	Size: 0x78
	Parameters: 2
	Flags: None
	Line Number: 1558
*/
function persistentDebugLine(start, end)
{
	/#
		self endon("death");
		level notify("newdebugline");
		level endon("newdebugline");
		for(;;)
		{
			line(start, end, (0.3, 1, 0), 1);
			wait(0.05);
		}
	#/
}

/*
	Name: isNodeDontStand
	Namespace: zombie_utility
	Checksum: 0x424F4353
	Offset: 0x3290
	Size: 0x18
	Parameters: 0
	Flags: None
	Line Number: 1582
*/
function isNodeDontStand()
{
	return self.SPAWNFLAGS & 4 == 4;
	ERROR: Bad function call
}

/*
	Name: isNodeDontCrouch
	Namespace: zombie_utility
	Checksum: 0x424F4353
	Offset: 0x32B0
	Size: 0x18
	Parameters: 0
	Flags: None
	Line Number: 1598
*/
function isNodeDontCrouch()
{
	return self.SPAWNFLAGS & 8 == 8;
}

/*
	Name: doesNodeAllowStance
	Namespace: zombie_utility
	Checksum: 0x424F4353
	Offset: 0x32D0
	Size: 0x78
	Parameters: 1
	Flags: None
	Line Number: 1613
*/
function doesNodeAllowStance(stance)
{
	if(stance == "stand")
	{
		return !self isNodeDontStand();
	}
	else
	{
		Assert(stance == "Dev Block strings are not supported");
		return !self isNodeDontCrouch();
	}
	/#
	#/
}

/*
	Name: animarray
	Namespace: zombie_utility
	Checksum: 0x424F4353
	Offset: 0x3350
	Size: 0xB8
	Parameters: 1
	Flags: None
	Line Number: 1638
*/
function animarray(animname)
{
	/#
		Assert(isdefined(self.a.array));
	#/
	/#
		if(!isdefined(self.a.array[animname]))
		{
			dumpAnimArray();
			/#
				Assert(isdefined(self.a.array[animname]), "Dev Block strings are not supported" + animname + "Dev Block strings are not supported");
			#/
		}
	#/
	return self.a.array[animname];
}

/*
	Name: animArrayAnyExist
	Namespace: zombie_utility
	Checksum: 0x424F4353
	Offset: 0x3410
	Size: 0xC0
	Parameters: 1
	Flags: None
	Line Number: 1665
*/
function animArrayAnyExist(animname)
{
	/#
		Assert(isdefined(self.a.array));
	#/
	/#
		if(!isdefined(self.a.array[animname]))
		{
			dumpAnimArray();
			/#
				Assert(isdefined(self.a.array[animname]), "Dev Block strings are not supported" + animname + "Dev Block strings are not supported");
			#/
		}
	#/
	return self.a.array[animname].size > 0;
}

/*
	Name: animArrayPickRandom
	Namespace: zombie_utility
	Checksum: 0x424F4353
	Offset: 0x34D8
	Size: 0x150
	Parameters: 1
	Flags: None
	Line Number: 1692
*/
function animArrayPickRandom(animname)
{
	/#
		Assert(isdefined(self.a.array));
	#/
	/#
		if(!isdefined(self.a.array[animname]))
		{
			dumpAnimArray();
			/#
				Assert(isdefined(self.a.array[animname]), "Dev Block strings are not supported" + animname + "Dev Block strings are not supported");
			#/
		}
	#/
	/#
		Assert(self.a.array[animname].size > 0);
	#/
	if(self.a.array[animname].size > 1)
	{
		index = randomint(self.a.array[animname].size);
	}
	else
	{
		index = 0;
	}
	return self.a.array[animname][index];
}

/*
	Name: dumpAnimArray
	Namespace: zombie_utility
	Checksum: 0x424F4353
	Offset: 0x3630
	Size: 0x150
	Parameters: 0
	Flags: None
	Line Number: 1730
*/
function dumpAnimArray()
{
	/#
		println("Dev Block strings are not supported");
		keys = getarraykeys(self.a.array);
		for(i = 0; i < keys.size; i++)
		{
			if(isarray(self.a.array[keys[i]]))
			{
				println("Dev Block strings are not supported" + keys[i] + "Dev Block strings are not supported" + self.a.array[keys[i]].size + "Dev Block strings are not supported");
				continue;
			}
			println("Dev Block strings are not supported" + keys[i] + "Dev Block strings are not supported", self.a.array[keys[i]]);
		}
	#/
}

/*
	Name: getAnimEndPos
	Namespace: zombie_utility
	Checksum: 0x424F4353
	Offset: 0x3788
	Size: 0x58
	Parameters: 1
	Flags: None
	Line Number: 1757
*/
function getAnimEndPos(theanim)
{
	moveDelta = GetMoveDelta(theanim, 0, 1, self);
	return self LocalToWorldCoords(moveDelta);
}

/*
	Name: isValidEnemy
	Namespace: zombie_utility
	Checksum: 0x424F4353
	Offset: 0x37E8
	Size: 0x20
	Parameters: 1
	Flags: None
	Line Number: 1773
*/
function isValidEnemy(enemy)
{
	if(!isdefined(enemy))
	{
		return 0;
	}
	return 1;
}

/*
	Name: damageLocationIsAny
	Namespace: zombie_utility
	Checksum: 0x424F4353
	Offset: 0x3810
	Size: 0x228
	Parameters: 12
	Flags: None
	Line Number: 1792
*/
function damageLocationIsAny(a, b, c, d, e, f, g, h, i, j, K, ovr)
{
	if(!isdefined(self.damagelocation))
	{
		return 0;
	}
	if(!isdefined(a))
	{
		return 0;
	}
	if(self.damagelocation == a)
	{
		return 1;
	}
	if(!isdefined(b))
	{
		return 0;
	}
	if(self.damagelocation == b)
	{
		return 1;
	}
	if(!isdefined(c))
	{
		return 0;
	}
	if(self.damagelocation == c)
	{
		return 1;
	}
	if(!isdefined(d))
	{
		return 0;
	}
	if(self.damagelocation == d)
	{
		return 1;
	}
	if(!isdefined(e))
	{
		return 0;
	}
	if(self.damagelocation == e)
	{
		return 1;
	}
	if(!isdefined(f))
	{
		return 0;
	}
	if(self.damagelocation == f)
	{
		return 1;
	}
	if(!isdefined(g))
	{
		return 0;
	}
	if(self.damagelocation == g)
	{
		return 1;
	}
	if(!isdefined(h))
	{
		return 0;
	}
	if(self.damagelocation == h)
	{
		return 1;
	}
	if(!isdefined(i))
	{
		return 0;
	}
	if(self.damagelocation == i)
	{
		return 1;
	}
	if(!isdefined(j))
	{
		return 0;
	}
	if(self.damagelocation == j)
	{
		return 1;
	}
	if(!isdefined(K))
	{
		return 0;
	}
	if(self.damagelocation == K)
	{
		return 1;
	}
	/#
		Assert(!isdefined(ovr));
	#/
	return 0;
}

/*
	Name: ragdollDeath
	Namespace: zombie_utility
	Checksum: 0x424F4353
	Offset: 0x3A40
	Size: 0xF8
	Parameters: 1
	Flags: None
	Line Number: 1902
*/
function ragdollDeath(moveAnim)
{
	self endon("killanimscript");
	lastOrg = self.origin;
	moveVec = (0, 0, 0);
	for(;;)
	{
		wait(0.05);
		force = distance(self.origin, lastOrg);
		lastOrg = self.origin;
		if(self.health == 1)
		{
			self.a.nodeath = 1;
			self startragdoll();
			wait(0.05);
			physicsexplosionsphere(lastOrg, 600, 0, force * 0.1);
			self notify("killanimscript");
			return;
		}
	}
}

/*
	Name: isCQBWalking
	Namespace: zombie_utility
	Checksum: 0x424F4353
	Offset: 0x3B40
	Size: 0x18
	Parameters: 0
	Flags: None
	Line Number: 1934
*/
function isCQBWalking()
{
	return isdefined(self.cqbwalking) && self.cqbwalking;
}

/*
	Name: squared
	Namespace: zombie_utility
	Checksum: 0x424F4353
	Offset: 0x3B60
	Size: 0x18
	Parameters: 1
	Flags: None
	Line Number: 1949
*/
function squared(value)
{
	return value * value;
	ERROR: Exception occured: Stack empty.
}

/*
	Name: randomizeIdleSet
	Namespace: zombie_utility
	Checksum: 0x424F4353
	Offset: 0x3B80
	Size: 0x30
	Parameters: 0
	Flags: None
	Line Number: 1965
*/
function randomizeIdleSet()
{
	self.a.idleSet = randomint(2);
}

/*
	Name: getRandomIntFromSeed
	Namespace: zombie_utility
	Checksum: 0x424F4353
	Offset: 0x3BB8
	Size: 0x68
	Parameters: 2
	Flags: None
	Line Number: 1980
*/
function getRandomIntFromSeed(intSeed, intMax)
{
	/#
		Assert(intMax > 0);
	#/
	index = intSeed % anim.randomIntTableSize;
	return anim.randomIntTable[index] % intMax;
}

/*
	Name: is_banzai
	Namespace: zombie_utility
	Checksum: 0x424F4353
	Offset: 0x3C28
	Size: 0x18
	Parameters: 0
	Flags: None
	Line Number: 1999
*/
function is_banzai()
{
	return isdefined(self.Banzai) && self.Banzai;
}

/*
	Name: is_heavy_machine_gun
	Namespace: zombie_utility
	Checksum: 0x424F4353
	Offset: 0x3C48
	Size: 0x18
	Parameters: 0
	Flags: None
	Line Number: 2014
*/
function is_heavy_machine_gun()
{
	return isdefined(self.heavy_machine_gunner) && self.heavy_machine_gunner;
}

/*
	Name: is_zombie
	Namespace: zombie_utility
	Checksum: 0x424F4353
	Offset: 0x3C68
	Size: 0x28
	Parameters: 0
	Flags: None
	Line Number: 2029
*/
function is_zombie()
{
	if(isdefined(self.is_zombie) && self.is_zombie)
	{
		return 1;
	}
	return 0;
}

/*
	Name: is_civilian
	Namespace: zombie_utility
	Checksum: 0x424F4353
	Offset: 0x3C98
	Size: 0x28
	Parameters: 0
	Flags: None
	Line Number: 2048
*/
function is_civilian()
{
	if(isdefined(self.is_civilian) && self.is_civilian)
	{
		return 1;
	}
	return 0;
	ERROR: Exception occured: Stack empty.
}

/*
	Name: is_skeleton
	Namespace: zombie_utility
	Checksum: 0x424F4353
	Offset: 0x3CC8
	Size: 0x68
	Parameters: 1
	Flags: None
	Line Number: 2068
*/
function is_skeleton(skeleton)
{
	if(skeleton == "base" && issubstr(get_skeleton(), "scaled"))
	{
		return 1;
	}
	return get_skeleton() == skeleton;
}

/*
	Name: get_skeleton
	Namespace: zombie_utility
	Checksum: 0x424F4353
	Offset: 0x3D38
	Size: 0x28
	Parameters: 0
	Flags: None
	Line Number: 2087
*/
function get_skeleton()
{
	if(isdefined(self.skeleton))
	{
		return self.skeleton;
	}
	else
	{
		return "base";
	}
}

/*
	Name: set_orient_mode
	Namespace: zombie_utility
	Checksum: 0x424F4353
	Offset: 0x3D68
	Size: 0xF8
	Parameters: 2
	Flags: None
	Line Number: 2109
*/
function set_orient_mode(mode, val1)
{
	/#
		if(level.dog_debug_orient == self GetEntNum())
		{
			if(isdefined(val1))
			{
				println("Dev Block strings are not supported" + mode + "Dev Block strings are not supported" + val1 + "Dev Block strings are not supported" + GetTime());
			}
			else
			{
				println("Dev Block strings are not supported" + mode + "Dev Block strings are not supported" + GetTime());
			}
		}
	#/
	if(isdefined(val1))
	{
		self OrientMode(mode, val1);
	}
	else
	{
		self OrientMode(mode);
	}
}

/*
	Name: debug_anim_print
	Namespace: zombie_utility
	Checksum: 0x424F4353
	Offset: 0x3E68
	Size: 0xA0
	Parameters: 1
	Flags: None
	Line Number: 2144
*/
function debug_anim_print(text)
{
	/#
		if(isdefined(level.dog_debug_anims) && level.dog_debug_anims)
		{
			println(text + "Dev Block strings are not supported" + GetTime());
		}
		if(isdefined(level.dog_debug_anims_ent) && level.dog_debug_anims_ent == self GetEntNum())
		{
			println(text + "Dev Block strings are not supported" + GetTime());
		}
	#/
}

/*
	Name: debug_turn_print
	Namespace: zombie_utility
	Checksum: 0x424F4353
	Offset: 0x3F10
	Size: 0x198
	Parameters: 2
	Flags: None
	Line Number: 2168
*/
function debug_turn_print(text, line)
{
	/#
		if(isdefined(level.dog_debug_turns) && level.dog_debug_turns == self GetEntNum())
		{
			duration = 200;
			currentYawColor = (1, 1, 1);
			lookaheadYawColor = (1, 0, 0);
			desiredYawColor = (1, 1, 0);
			currentYaw = angleclamp180(self.angles[1]);
			desiredYaw = angleclamp180(self.desiredAngle);
			lookaheaddir = self.lookaheaddir;
			lookaheadAngles = vectortoangles(lookaheaddir);
			lookaheadYaw = angleclamp180(lookaheadAngles[1]);
			println(text + "Dev Block strings are not supported" + GetTime() + "Dev Block strings are not supported" + currentYaw + "Dev Block strings are not supported" + lookaheadYaw + "Dev Block strings are not supported" + desiredYaw);
		}
	#/
}

/*
	Name: debug_allow_combat
	Namespace: zombie_utility
	Checksum: 0x424F4353
	Offset: 0x40B0
	Size: 0x30
	Parameters: 0
	Flags: None
	Line Number: 2197
*/
function debug_allow_combat()
{
	/#
		return anim_get_dvar_int("Dev Block strings are not supported", "Dev Block strings are not supported");
	#/
	return 1;
}

/*
	Name: debug_allow_movement
	Namespace: zombie_utility
	Checksum: 0x424F4353
	Offset: 0x40E8
	Size: 0x30
	Parameters: 0
	Flags: None
	Line Number: 2215
*/
function debug_allow_movement()
{
	/#
		return anim_get_dvar_int("Dev Block strings are not supported", "Dev Block strings are not supported");
	#/
	return 1;
}

/*
	Name: set_zombie_var
	Namespace: zombie_utility
	Checksum: 0x424F4353
	Offset: 0x4120
	Size: 0x150
	Parameters: 5
	Flags: None
	Line Number: 2233
*/
function set_zombie_var(zvar, value, is_float, column, is_team_based)
{
	if(!isdefined(is_float))
	{
		is_float = 0;
	}
	if(!isdefined(column))
	{
		column = 1;
	}
	if(!isdefined(is_team_based))
	{
		is_team_based = 0;
	}
	if(!isdefined(level.zombie_vars))
	{
		level.zombie_vars = [];
	}
	if(is_team_based)
	{
		foreach(team in level.teams)
		{
			if(!isdefined(level.zombie_vars[team]))
			{
				level.zombie_vars[team] = [];
			}
			level.zombie_vars[team][zvar] = value;
		}
	}
	else
	{
		level.zombie_vars[zvar] = value;
	}
	return value;
	continue;
}

/*
	Name: spawn_zombie
	Namespace: zombie_utility
	Checksum: 0x424F4353
	Offset: 0x4278
	Size: 0x378
	Parameters: 4
	Flags: None
	Line Number: 2280
*/
function spawn_zombie(spawner, target_name, spawn_point, round_number)
{
	if(!isdefined(spawner))
	{
		/#
			println("Dev Block strings are not supported");
		#/
		return undefined;
	}
	while(GetFreeActorCount() < 1)
	{
		wait(0.05);
	}
	spawner.script_moveoverride = 1;
	if(isdefined(spawner.script_forcespawn) && spawner.script_forcespawn)
	{
		if(SessionModeIsCampaignZombiesGame())
		{
			guy = spawner spawner::spawn(1);
		}
		else if(IsActorSpawner(spawner) && isdefined(level.overrideZombieSpawn))
		{
			guy = [[level.overrideZombieSpawn]]();
		}
		else
		{
			guy = spawner spawnfromspawner(0, 1);
		}
		if(!zombie_spawn_failed(guy))
		{
			guy.spawn_time = GetTime();
			if(isdefined(level.giveExtraZombies))
			{
				guy [[level.giveExtraZombies]]();
			}
			guy EnableAimAssist();
			if(isdefined(round_number))
			{
				guy._starting_round_number = round_number;
			}
			guy.team = level.zombie_team;
			if(IsActor(guy))
			{
				guy ClearEntityOwner();
			}
			level.zombieMeleePlayerCounter = 0;
			if(IsActor(guy))
			{
				guy forceteleport(spawner.origin);
			}
			guy show();
			spawner.count = 666;
			if(isdefined(target_name))
			{
				guy.targetname = target_name;
			}
			if(isdefined(spawn_point) && isdefined(level.move_spawn_func))
			{
				guy thread [[level.move_spawn_func]](spawn_point);
			}
			/#
				if(isdefined(spawner.zm_variant_type))
				{
					guy.variant_type = spawner.zm_variant_type;
				}
			#/
			return guy;
		}
		else
		{
			println("Dev Block strings are not supported", spawner.origin);
			return undefined;
		}
		/#
		#/
	}
	else
	{
		println("Dev Block strings are not supported", spawner.origin);
		return undefined;
	}
	/#
	#/
	return undefined;
}

/*
	Name: zombie_spawn_failed
	Namespace: zombie_utility
	Checksum: 0x424F4353
	Offset: 0x45F8
	Size: 0x50
	Parameters: 1
	Flags: None
	Line Number: 2376
*/
function zombie_spawn_failed(spawn)
{
	if(isdefined(spawn) && isalive(spawn))
	{
		if(isalive(spawn))
		{
			return 0;
		}
	}
	return 1;
}

/*
	Name: get_desired_origin
	Namespace: zombie_utility
	Checksum: 0x424F4353
	Offset: 0x4650
	Size: 0xF0
	Parameters: 0
	Flags: None
	Line Number: 2398
*/
function get_desired_origin()
{
	if(isdefined(self.target))
	{
		ent = getent(self.target, "targetname");
		if(!isdefined(ent))
		{
			ent = struct::get(self.target, "targetname");
		}
		if(!isdefined(ent))
		{
			ent = GetNode(self.target, "targetname");
		}
		/#
			Assert(isdefined(ent), "Dev Block strings are not supported" + self.target + "Dev Block strings are not supported" + self.origin);
		#/
		return ent.origin;
	}
	return undefined;
}

/*
	Name: hide_pop
	Namespace: zombie_utility
	Checksum: 0x424F4353
	Offset: 0x4748
	Size: 0x70
	Parameters: 0
	Flags: None
	Line Number: 2429
*/
function hide_pop()
{
	self endon("death");
	self ghost();
	wait(0.5);
	if(isdefined(self))
	{
		self show();
		util::wait_network_frame();
		if(isdefined(self))
		{
			self.create_eyes = 1;
		}
	}
}

/*
	Name: handle_rise_notetracks
	Namespace: zombie_utility
	Checksum: 0x424F4353
	Offset: 0x47C0
	Size: 0x38
	Parameters: 2
	Flags: None
	Line Number: 2455
*/
function handle_rise_notetracks(note, spot)
{
	self thread finish_rise_notetracks(note, spot);
}

/*
	Name: finish_rise_notetracks
	Namespace: zombie_utility
	Checksum: 0x424F4353
	Offset: 0x4800
	Size: 0x68
	Parameters: 2
	Flags: None
	Line Number: 2470
*/
function finish_rise_notetracks(note, spot)
{
	if(note == "deathout" || note == "deathhigh")
	{
		self.zombie_rise_death_out = 1;
		self notify("zombie_rise_death_out");
		wait(2);
		spot notify("stop_zombie_rise_fx");
		return;
	}
	ERROR: Exception occured: Stack empty.
}

/*
	Name: zombie_rise_death
	Namespace: zombie_utility
	Checksum: 0x424F4353
	Offset: 0x4870
	Size: 0xE0
	Parameters: 2
	Flags: None
	Line Number: 2493
*/
function zombie_rise_death(zombie, spot)
{
	zombie.zombie_rise_death_out = 0;
	zombie endon("rise_anim_finished");
	while(isdefined(zombie) && isdefined(zombie.health) && zombie.health > 1)
	{
		zombie waittill("damage", amount);
	}
	if(isdefined(spot))
	{
		spot notify("stop_zombie_rise_fx");
	}
	if(isdefined(zombie))
	{
		zombie.deathAnim = zombie get_rise_death_anim();
		zombie stopanimscripted();
	}
}

/*
	Name: get_rise_death_anim
	Namespace: zombie_utility
	Checksum: 0x424F4353
	Offset: 0x4958
	Size: 0x38
	Parameters: 0
	Flags: None
	Line Number: 2522
*/
function get_rise_death_anim()
{
	if(self.zombie_rise_death_out)
	{
		return "zm_rise_death_out";
	}
	self.noragdoll = 1;
	self.nodeathragdoll = 1;
	return "zm_rise_death_in";
}

/*
	Name: reset_attack_spot
	Namespace: zombie_utility
	Checksum: 0x424F4353
	Offset: 0x4998
	Size: 0x60
	Parameters: 0
	Flags: None
	Line Number: 2543
*/
function reset_attack_spot()
{
	if(isdefined(self.attacking_node))
	{
		node = self.attacking_node;
		index = self.attacking_spot_index;
		node.attack_spots_taken[index] = 0;
		self.attacking_node = undefined;
		self.attacking_spot_index = undefined;
		return;
	}
	ERROR: Exception occured: Stack empty.
}

/*
	Name: zombie_gut_explosion
	Namespace: zombie_utility
	Checksum: 0x424F4353
	Offset: 0x4A00
	Size: 0x28
	Parameters: 0
	Flags: None
	Line Number: 2567
*/
function zombie_gut_explosion()
{
	self.guts_explosion = 1;
	gibserverutils::annihilate(self);
}

/*
	Name: delayed_zombie_eye_glow
	Namespace: zombie_utility
	Checksum: 0x424F4353
	Offset: 0x4A30
	Size: 0x88
	Parameters: 0
	Flags: None
	Line Number: 2583
*/
function delayed_zombie_eye_glow()
{
	self endon("zombie_delete");
	self endon("death");
	if(isdefined(self.in_the_ground) && self.in_the_ground || (isdefined(self.in_the_ceiling) && self.in_the_ceiling))
	{
		while(!isdefined(self.create_eyes))
		{
			wait(0.1);
		}
	}
	else
	{
		wait(0.5);
	}
	self zombie_eye_glow();
}

/*
	Name: zombie_eye_glow
	Namespace: zombie_utility
	Checksum: 0x424F4353
	Offset: 0x4AC0
	Size: 0x70
	Parameters: 0
	Flags: None
	Line Number: 2611
*/
function zombie_eye_glow()
{
	if(!isdefined(self) || !IsActor(self))
	{
		return;
	}
	if(!isdefined(self.no_eye_glow) || !self.no_eye_glow)
	{
		self clientfield::set("zombie_has_eyes", 1);
		return;
	}
	waittillframeend;
}

/*
	Name: zombie_eye_glow_stop
	Namespace: zombie_utility
	Checksum: 0x424F4353
	Offset: 0x4B38
	Size: 0x68
	Parameters: 0
	Flags: None
	Line Number: 2635
*/
function zombie_eye_glow_stop()
{
	if(!isdefined(self) || !IsActor(self))
	{
		return;
	}
	if(!isdefined(self.no_eye_glow) || !self.no_eye_glow)
	{
		self clientfield::set("zombie_has_eyes", 0);
	}
}

/*
	Name: round_spawn_failsafe_debug_draw
	Namespace: zombie_utility
	Checksum: 0x424F4353
	Offset: 0x4BA8
	Size: 0x118
	Parameters: 0
	Flags: None
	Line Number: 2657
*/
function round_spawn_failsafe_debug_draw()
{
	self endon("death");
	prevOrigin = self.origin;
	while(1)
	{
		if(isdefined(level.toggle_keyline_always) && level.toggle_keyline_always)
		{
			self clientfield::set("zombie_keyline_render", 1);
			wait(1);
			continue;
		}
		wait(4);
		if(isdefined(self.lastchunk_destroy_time))
		{
			if(GetTime() - self.lastchunk_destroy_time < 8000)
			{
				continue;
			}
		}
		if(distancesquared(self.origin, prevOrigin) < 576)
		{
			self clientfield::set("zombie_keyline_render", 1);
		}
		else
		{
			self clientfield::set("zombie_keyline_render", 0);
		}
		prevOrigin = self.origin;
	}
	return;
}

/*
	Name: round_spawn_failsafe
	Namespace: zombie_utility
	Checksum: 0x424F4353
	Offset: 0x4CC8
	Size: 0x2D8
	Parameters: 0
	Flags: None
	Line Number: 2700
*/
function round_spawn_failsafe()
{
	self endon("death");
	if(isdefined(level.debug_keyline_zombies) && level.debug_keyline_zombies)
	{
		self thread round_spawn_failsafe_debug_draw();
	}
	prevOrigin = self.origin;
	while(1)
	{
		if(!level.zombie_vars["zombie_use_failsafe"])
		{
			return;
		}
		if(isdefined(self.ignore_round_spawn_failsafe) && self.ignore_round_spawn_failsafe)
		{
			return;
		}
		if(!isdefined(level.failsafe_waittime))
		{
			level.failsafe_waittime = 30;
		}
		wait(level.failsafe_waittime);
		if(self.missingLegs)
		{
			wait(10);
		}
		if(isdefined(self.is_inert) && self.is_inert)
		{
			continue;
		}
		if(isdefined(self.lastchunk_destroy_time))
		{
			if(GetTime() - self.lastchunk_destroy_time < 8000)
			{
				continue;
			}
		}
		if(self.origin[2] < level.zombie_vars["below_world_check"])
		{
			if(isdefined(level.put_timed_out_zombies_back_in_queue) && level.put_timed_out_zombies_back_in_queue && !level flag::get("special_round") && (!(isdefined(self.isscreecher) && self.isscreecher)))
			{
				level.zombie_total++;
				level.zombie_total_subtract++;
			}
			self dodamage(self.health + 100, (0, 0, 0));
			break;
		}
		if(distancesquared(self.origin, prevOrigin) < 576)
		{
			if(isdefined(level.move_failsafe_override))
			{
				self thread [[level.move_failsafe_override]](prevOrigin);
			}
			else if(isdefined(level.put_timed_out_zombies_back_in_queue) && level.put_timed_out_zombies_back_in_queue && !level flag::get("special_round"))
			{
				if(!self.ignoreall && (!(isdefined(self.nuked) && self.nuked)) && (!(isdefined(self.marked_for_death) && self.marked_for_death)) && (!(isdefined(self.isscreecher) && self.isscreecher)) && !self.missingLegs)
				{
					level.zombie_total++;
					level.zombie_total_subtract++;
				}
			}
			level.zombies_timeout_playspace++;
			self dodamage(self.health + 100, (0, 0, 0));
			break;
		}
		prevOrigin = self.origin;
	}
}

/*
	Name: ai_calculate_health
	Namespace: zombie_utility
	Checksum: 0x424F4353
	Offset: 0x4FA8
	Size: 0x260
	Parameters: 1
	Flags: None
	Line Number: 2780
*/
function ai_calculate_health(round_number)
{
	level.zombie_health = level.zombie_vars["zombie_health_start"];
	level.var_6a2a6466 = level.zombie_vars["zombie_health_start"];
	for(i = 2; i <= round_number; i++)
	{
		if(level flag::get("classic_enabled") && i >= 10 && i <= 30 || (!level flag::get("classic_enabled") && i >= 10 && i <= 85))
		{
			old_health = level.zombie_health;
			level.zombie_health = level.zombie_health + int(level.zombie_health * level.zombie_vars["zombie_health_increase_multiplier"]);
			level.var_6a2a6466 = level.var_6a2a6466 + int(level.var_6a2a6466 * level.zombie_vars["zombie_health_increase_multiplier"]);
			if(level.zombie_health < old_health)
			{
				level.zombie_health = old_health;
				level.var_6a2a6466 = old_health;
				return;
				continue;
			}
		}
		if(level flag::get("classic_enabled") && i < 10 || (!level flag::get("classic_enabled") && i < 10))
		{
			level.zombie_health = int(level.zombie_health + level.zombie_vars["zombie_health_increase"]);
			level.var_6a2a6466 = int(level.zombie_health + level.zombie_vars["zombie_health_increase"]);
		}
	}
	return;
	ERROR: Exception occured: Stack empty.
}

/*
	Name: default_max_zombie_func
	Namespace: zombie_utility
	Checksum: 0x424F4353
	Offset: 0x5210
	Size: 0x180
	Parameters: 2
	Flags: None
	Line Number: 2819
*/
function default_max_zombie_func(max_num, n_round)
{
	/#
		count = getdvarint("Dev Block strings are not supported", -1);
		if(count > -1)
		{
			return count;
		}
	#/
	max = max_num;
	if(n_round < 2)
	{
		max = int(max_num * 0.25);
	}
	else if(n_round < 3)
	{
		max = int(max_num * 0.3);
	}
	else if(n_round < 4)
	{
		max = int(max_num * 0.5);
	}
	else if(n_round < 5)
	{
		max = int(max_num * 0.7);
	}
	else if(n_round < 6)
	{
		max = int(max_num * 0.9);
	}
	return max;
}

/*
	Name: zombie_speed_up
	Namespace: zombie_utility
	Checksum: 0x424F4353
	Offset: 0x5398
	Size: 0x180
	Parameters: 0
	Flags: None
	Line Number: 2862
*/
function zombie_speed_up()
{
	if(level.round_number <= 3)
	{
		return;
	}
	level endon("intermission");
	level endon("end_of_round");
	level endon("restart_round");
	level endon("kill_round");
	while(level.zombie_total > 4)
	{
		wait(3);
	}
	for(a_ai_zombies = get_round_enemy_array(); a_ai_zombies.size > 0 || level.zombie_total > 0; a_ai_zombies = get_round_enemy_array())
	{
		if(a_ai_zombies.size == 1)
		{
			ai_zombie = a_ai_zombies[0];
			if(isalive(ai_zombie))
			{
				if(isdefined(level.zombie_speed_up))
				{
					ai_zombie thread [[level.zombie_speed_up]]();
				}
				else if(!ai_zombie.zombie_move_speed === "sprint")
				{
					ai_zombie set_zombie_run_cycle("sprint");
					ai_zombie.zombie_move_speed_original = ai_zombie.zombie_move_speed;
				}
			}
		}
		wait(0.5);
	}
}

/*
	Name: get_current_zombie_count
	Namespace: zombie_utility
	Checksum: 0x424F4353
	Offset: 0x5520
	Size: 0x28
	Parameters: 0
	Flags: None
	Line Number: 2908
*/
function get_current_zombie_count()
{
	enemies = get_round_enemy_array();
	return enemies.size;
}

/*
	Name: get_round_enemy_array
	Namespace: zombie_utility
	Checksum: 0x424F4353
	Offset: 0x5550
	Size: 0x100
	Parameters: 0
	Flags: None
	Line Number: 2924
*/
function get_round_enemy_array()
{
	a_ai_enemies = [];
	a_ai_valid_enemies = [];
	a_ai_enemies = getaiteamarray(level.zombie_team);
	for(i = 0; i < a_ai_enemies.size; i++)
	{
		if(isdefined(a_ai_enemies[i].ignore_enemy_count) && a_ai_enemies[i].ignore_enemy_count)
		{
			continue;
		}
		if(!isdefined(a_ai_valid_enemies))
		{
			a_ai_valid_enemies = [];
		}
		else if(!isarray(a_ai_valid_enemies))
		{
			a_ai_valid_enemies = array(a_ai_valid_enemies);
		}
		a_ai_valid_enemies[a_ai_valid_enemies.size] = a_ai_enemies[i];
	}
	return a_ai_valid_enemies;
}

/*
	Name: get_zombie_array
	Namespace: zombie_utility
	Checksum: 0x424F4353
	Offset: 0x5658
	Size: 0xF8
	Parameters: 0
	Flags: None
	Line Number: 2958
*/
function get_zombie_array()
{
	enemies = [];
	valid_enemies = [];
	enemies = getaispeciesarray(level.zombie_team, "all");
	for(i = 0; i < enemies.size; i++)
	{
		if(enemies[i].archetype == "zombie")
		{
			if(!isdefined(valid_enemies))
			{
				valid_enemies = [];
			}
			else if(!isarray(valid_enemies))
			{
				valid_enemies = array(valid_enemies);
			}
			valid_enemies[valid_enemies.size] = enemies[i];
		}
	}
	return valid_enemies;
}

/*
	Name: set_zombie_run_cycle_override_value
	Namespace: zombie_utility
	Checksum: 0x424F4353
	Offset: 0x5758
	Size: 0x30
	Parameters: 1
	Flags: None
	Line Number: 2991
*/
function set_zombie_run_cycle_override_value(new_move_speed)
{
	set_zombie_run_cycle(new_move_speed);
	self.zombie_move_speed_override = new_move_speed;
}

/*
	Name: set_zombie_run_cycle_restore_from_override
	Namespace: zombie_utility
	Checksum: 0x424F4353
	Offset: 0x5790
	Size: 0x40
	Parameters: 0
	Flags: None
	Line Number: 3007
*/
function set_zombie_run_cycle_restore_from_override()
{
	str_restore_move_speed = self.zombie_move_speed_restore;
	self.zombie_move_speed_override = undefined;
	set_zombie_run_cycle(str_restore_move_speed);
	return;
	ERROR: Exception occured: Stack empty.
}

/*
	Name: set_zombie_run_cycle
	Namespace: zombie_utility
	Checksum: 0x424F4353
	Offset: 0x57D8
	Size: 0x290
	Parameters: 1
	Flags: None
	Line Number: 3026
*/
function set_zombie_run_cycle(new_move_speed)
{
	if(isdefined(self.zombie_move_speed_override))
	{
		self.zombie_move_speed_restore = new_move_speed;
		return;
	}
	self.zombie_move_speed_original = self.zombie_move_speed;
	if(isdefined(new_move_speed))
	{
		self.zombie_move_speed = new_move_speed;
	}
	else if(level.gamedifficulty == 0)
	{
		self set_run_speed_easy();
	}
	else
	{
		self set_run_speed();
	}
	if(isdefined(level.zm_variant_type_max))
	{
		/#
			if(0)
			{
				debug_variant_type = getdvarint("Dev Block strings are not supported", -1);
				if(debug_variant_type != -1)
				{
					if(debug_variant_type <= level.zm_variant_type_max[self.zombie_move_speed][self.zombie_arms_position])
					{
						self.variant_type = debug_variant_type;
					}
					else
					{
						self.variant_type = level.zm_variant_type_max[self.zombie_move_speed][self.zombie_arms_position] - 1;
					}
				}
				else
				{
					self.variant_type = randomint(level.zm_variant_type_max[self.zombie_move_speed][self.zombie_arms_position]);
				}
			}
		#/
		if(self.archetype === "zombie")
		{
			if(isdefined(self.zm_variant_type_max))
			{
				self.variant_type = randomint(self.zm_variant_type_max[self.zombie_move_speed][self.zombie_arms_position]);
			}
			else if(isdefined(level.zm_variant_type_max[self.zombie_move_speed]))
			{
				self.variant_type = randomint(level.zm_variant_type_max[self.zombie_move_speed][self.zombie_arms_position]);
			}
			else
			{
				errormsg("Dev Block strings are not supported" + self.zombie_move_speed);
				self.variant_type = 0;
			}
			/#
			#/
		}
	}
	self.needs_run_update = 1;
	self notify("needs_run_update");
	self.deathAnim = self append_missing_legs_suffix("zm_death");
}

/*
	Name: set_run_speed
	Namespace: zombie_utility
	Checksum: 0x424F4353
	Offset: 0x5A70
	Size: 0xC8
	Parameters: 0
	Flags: None
	Line Number: 3103
*/
function set_run_speed()
{
	if(isdefined(level.zombie_force_run))
	{
		self.zombie_move_speed = "run";
		level.zombie_force_run--;
		if(level.zombie_force_run <= 0)
		{
			level.zombie_force_run = undefined;
			return;
		}
	}
	rand = randomintrange(level.zombie_move_speed, level.zombie_move_speed + 35);
	if(rand <= 35)
	{
		self.zombie_move_speed = "walk";
	}
	else if(rand <= 70)
	{
		self.zombie_move_speed = "run";
	}
	else
	{
		self.zombie_move_speed = "sprint";
	}
}

/*
	Name: set_run_speed_easy
	Namespace: zombie_utility
	Checksum: 0x424F4353
	Offset: 0x5B40
	Size: 0x70
	Parameters: 0
	Flags: None
	Line Number: 3140
*/
function set_run_speed_easy()
{
	rand = randomintrange(level.zombie_move_speed, level.zombie_move_speed + 25);
	if(rand <= 35)
	{
		self.zombie_move_speed = "walk";
	}
	else
	{
		self.zombie_move_speed = "run";
		return;
	}
	ERROR: Exception occured: Stack empty.
	ERROR: Bad function call
}

/*
	Name: setup_zombie_knockdown
	Namespace: zombie_utility
	Checksum: 0x424F4353
	Offset: 0x5BB8
	Size: 0x268
	Parameters: 1
	Flags: None
	Line Number: 3166
*/
function setup_zombie_knockdown(entity)
{
	self.knockdown = 1;
	zombie_to_entity = entity.origin - self.origin;
	zombie_to_entity_2d = vectornormalize((zombie_to_entity[0], zombie_to_entity[1], 0));
	zombie_forward = anglestoforward(self.angles);
	zombie_forward_2d = vectornormalize((zombie_forward[0], zombie_forward[1], 0));
	zombie_right = anglestoright(self.angles);
	zombie_right_2d = vectornormalize((zombie_right[0], zombie_right[1], 0));
	dot = vectordot(zombie_to_entity_2d, zombie_forward_2d);
	if(dot >= 0.5)
	{
		self.knockdown_direction = "front";
		self.getup_direction = "getup_back";
	}
	else if(dot < 0.5 && dot > -0.5)
	{
		dot = vectordot(zombie_to_entity_2d, zombie_right_2d);
		if(dot > 0)
		{
			self.knockdown_direction = "right";
			if(math::cointoss())
			{
				self.getup_direction = "getup_back";
			}
			else
			{
				self.getup_direction = "getup_belly";
			}
		}
		else
		{
			self.knockdown_direction = "left";
			self.getup_direction = "getup_belly";
		}
	}
	else
	{
		self.knockdown_direction = "back";
		self.getup_direction = "getup_belly";
	}
}

/*
	Name: clear_all_corpses
	Namespace: zombie_utility
	Checksum: 0x424F4353
	Offset: 0x5E28
	Size: 0x78
	Parameters: 0
	Flags: None
	Line Number: 3219
*/
function clear_all_corpses()
{
	corpse_array = getcorpsearray();
	for(i = 0; i < corpse_array.size; i++)
	{
		if(isdefined(corpse_array[i]))
		{
			corpse_array[i] delete();
		}
	}
}

/*
	Name: get_current_actor_count
	Namespace: zombie_utility
	Checksum: 0x424F4353
	Offset: 0x5EA8
	Size: 0x80
	Parameters: 0
	Flags: None
	Line Number: 3241
*/
function get_current_actor_count()
{
	count = 0;
	actors = getaispeciesarray(level.zombie_team, "all");
	if(isdefined(actors))
	{
		count = count + actors.size;
	}
	count = count + get_current_corpse_count();
	return count;
}

/*
	Name: get_current_corpse_count
	Namespace: zombie_utility
	Checksum: 0x424F4353
	Offset: 0x5F30
	Size: 0x38
	Parameters: 0
	Flags: None
	Line Number: 3263
*/
function get_current_corpse_count()
{
	corpse_array = getcorpsearray();
	if(isdefined(corpse_array))
	{
		return corpse_array.size;
	}
	return 0;
}

/*
	Name: zombie_gib_on_damage
	Namespace: zombie_utility
	Checksum: 0x424F4353
	Offset: 0x5F70
	Size: 0x4F8
	Parameters: 0
	Flags: None
	Line Number: 3283
*/
function zombie_gib_on_damage()
{
	while(1)
	{
		self waittill("damage", amount, attacker, direction_vec, point, type, tagname, modelname, partname, weapon);
		if(!isdefined(self))
		{
			return;
		}
		if(!self zombie_should_gib(amount, attacker, type))
		{
			continue;
		}
		if(self head_should_gib(attacker, type, point) && type != "MOD_BURNED")
		{
			self zombie_head_gib(attacker, type);
			continue;
		}
		if(!(isdefined(self.gibbed) && self.gibbed) && isdefined(self.damagelocation))
		{
			if(self damageLocationIsAny("head", "helmet", "neck"))
			{
				continue;
			}
			self.stumble = undefined;
			switch(self.damagelocation)
			{
				case "torso_lower":
				case "torso_upper":
				{
					if(!gibserverutils::IsGibbed(self, 32))
					{
						gibserverutils::gibrightarm(self);
						break;
					}
				}
				case "right_arm_lower":
				case "right_arm_upper":
				case "right_hand":
				{
					if(!gibserverutils::IsGibbed(self, 32))
					{
						gibserverutils::gibrightarm(self);
						break;
					}
				}
				case "left_arm_lower":
				case "left_arm_upper":
				case "left_hand":
				{
					if(!gibserverutils::IsGibbed(self, 16))
					{
						gibserverutils::gibleftarm(self);
						break;
					}
				}
				case "right_foot":
				case "right_leg_lower":
				case "right_leg_upper":
				{
					if(self.health <= 0)
					{
						gibserverutils::gibrightleg(self);
						if(randomint(100) > 75)
						{
							gibserverutils::gibleftleg(self);
						}
						self.missingLegs = 1;
						break;
					}
				}
				case "left_foot":
				case "left_leg_lower":
				case "left_leg_upper":
				{
					if(self.health <= 0)
					{
						gibserverutils::gibleftleg(self);
						if(randomint(100) > 75)
						{
							gibserverutils::gibrightleg(self);
						}
						self.missingLegs = 1;
						break;
					}
				}
				default
				{
					if(self.damagelocation == "none")
					{
						if(type == "MOD_GRENADE" || type == "MOD_GRENADE_SPLASH" || type == "MOD_PROJECTILE" || type == "MOD_PROJECTILE_SPLASH")
						{
							self derive_damage_refs(point);
							break;
						}
					}
				}
			}
			if(isdefined(self.missingLegs) && self.missingLegs && self.health > 0)
			{
				self AllowedStances("crouch");
				self setphysparams(15, 0, 24);
				self allowpitchangle(1);
				self SetPitchOrient();
				health = self.health;
				health = health * 0.1;
				if(isdefined(self.crawl_anim_override))
				{
					self [[self.crawl_anim_override]]();
				}
			}
			if(self.health > 0)
			{
				if(isdefined(level.gib_on_damage))
				{
					self thread [[level.gib_on_damage]]();
				}
			}
		}
	}
}

/*
	Name: add_zombie_gib_weapon_callback
	Namespace: zombie_utility
	Checksum: 0x424F4353
	Offset: 0x6470
	Size: 0x78
	Parameters: 3
	Flags: None
	Line Number: 3415
*/
function add_zombie_gib_weapon_callback(weapon_name, gib_callback, gib_head_callback)
{
	if(!isdefined(level.zombie_gib_weapons))
	{
		level.zombie_gib_weapons = [];
	}
	if(!isdefined(level.zombie_gib_head_weapons))
	{
		level.zombie_gib_head_weapons = [];
	}
	level.zombie_gib_weapons[weapon_name] = gib_callback;
	level.zombie_gib_head_weapons[weapon_name] = gib_head_callback;
}

/*
	Name: have_zombie_weapon_gib_callback
	Namespace: zombie_utility
	Checksum: 0x424F4353
	Offset: 0x64F0
	Size: 0x88
	Parameters: 1
	Flags: None
	Line Number: 3439
*/
function have_zombie_weapon_gib_callback(weapon)
{
	if(!isdefined(level.zombie_gib_weapons))
	{
		level.zombie_gib_weapons = [];
	}
	if(!isdefined(level.zombie_gib_head_weapons))
	{
		level.zombie_gib_head_weapons = [];
	}
	if(IsWeapon(weapon))
	{
		weapon = weapon.name;
	}
	if(isdefined(level.zombie_gib_weapons[weapon]))
	{
		return 1;
	}
	return 0;
}

/*
	Name: get_zombie_weapon_gib_callback
	Namespace: zombie_utility
	Checksum: 0x424F4353
	Offset: 0x6580
	Size: 0xA0
	Parameters: 2
	Flags: None
	Line Number: 3470
*/
function get_zombie_weapon_gib_callback(weapon, damage_percent)
{
	if(!isdefined(level.zombie_gib_weapons))
	{
		level.zombie_gib_weapons = [];
	}
	if(!isdefined(level.zombie_gib_head_weapons))
	{
		level.zombie_gib_head_weapons = [];
	}
	if(IsWeapon(weapon))
	{
		weapon = weapon.name;
	}
	if(isdefined(level.zombie_gib_weapons[weapon]))
	{
		return self [[level.zombie_gib_weapons[weapon]]](damage_percent);
	}
	return 0;
}

/*
	Name: have_zombie_weapon_gib_head_callback
	Namespace: zombie_utility
	Checksum: 0x424F4353
	Offset: 0x6628
	Size: 0x88
	Parameters: 1
	Flags: None
	Line Number: 3501
*/
function have_zombie_weapon_gib_head_callback(weapon)
{
	if(!isdefined(level.zombie_gib_weapons))
	{
		level.zombie_gib_weapons = [];
	}
	if(!isdefined(level.zombie_gib_head_weapons))
	{
		level.zombie_gib_head_weapons = [];
	}
	if(IsWeapon(weapon))
	{
		weapon = weapon.name;
	}
	if(isdefined(level.zombie_gib_head_weapons[weapon]))
	{
		return 1;
	}
	return 0;
}

/*
	Name: get_zombie_weapon_gib_head_callback
	Namespace: zombie_utility
	Checksum: 0x424F4353
	Offset: 0x66B8
	Size: 0xA0
	Parameters: 2
	Flags: None
	Line Number: 3532
*/
function get_zombie_weapon_gib_head_callback(weapon, DAMAGE_LOCATION)
{
	if(!isdefined(level.zombie_gib_weapons))
	{
		level.zombie_gib_weapons = [];
	}
	if(!isdefined(level.zombie_gib_head_weapons))
	{
		level.zombie_gib_head_weapons = [];
	}
	if(IsWeapon(weapon))
	{
		weapon = weapon.name;
	}
	if(isdefined(level.zombie_gib_head_weapons[weapon]))
	{
		return self [[level.zombie_gib_head_weapons[weapon]]](DAMAGE_LOCATION);
	}
	return 0;
}

/*
	Name: zombie_should_gib
	Namespace: zombie_utility
	Checksum: 0x424F4353
	Offset: 0x6760
	Size: 0x290
	Parameters: 3
	Flags: None
	Line Number: 3563
*/
function zombie_should_gib(amount, attacker, type)
{
	if(!isdefined(type))
	{
		return 0;
	}
	if(isdefined(self.is_on_fire) && self.is_on_fire)
	{
		return 0;
	}
	if(isdefined(self.no_gib) && self.no_gib == 1)
	{
		return 0;
	}
	prev_health = amount + self.health;
	if(prev_health <= 0)
	{
		prev_health = 1;
	}
	damage_percent = amount / prev_health * 100;
	weapon = undefined;
	if(isdefined(attacker))
	{
		if(isplayer(attacker) || (isdefined(attacker.can_gib_zombies) && attacker.can_gib_zombies))
		{
			if(isplayer(attacker))
			{
				weapon = attacker getcurrentweapon();
			}
			else
			{
				weapon = attacker.weapon;
			}
			if(have_zombie_weapon_gib_callback(weapon))
			{
				if(self get_zombie_weapon_gib_callback(weapon, damage_percent))
				{
					return 1;
				}
				return 0;
			}
		}
	}
	switch(type)
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
	if(type == "MOD_PISTOL_BULLET" || type == "MOD_RIFLE_BULLET")
	{
		if(!isdefined(attacker) || !isplayer(attacker))
		{
			return 0;
		}
		if(weapon == level.weaponnone || (isdefined(level.start_weapon) && weapon == level.start_weapon) || weapon.isGasWeapon)
		{
			return 0;
		}
	}
	if(damage_percent < 10)
	{
		return 0;
	}
	return 1;
}

/*
	Name: head_should_gib
	Namespace: zombie_utility
	Checksum: 0x424F4353
	Offset: 0x69F8
	Size: 0x360
	Parameters: 3
	Flags: None
	Line Number: 3650
*/
function head_should_gib(attacker, type, point)
{
	if(isdefined(self.head_gibbed) && self.head_gibbed)
	{
		return 0;
	}
	if(!isdefined(attacker))
	{
		return 0;
	}
	if(!isplayer(attacker))
	{
		if(!(isdefined(attacker.can_gib_zombies) && attacker.can_gib_zombies))
		{
			return 0;
		}
	}
	if(isplayer(attacker))
	{
		weapon = attacker getcurrentweapon();
	}
	else
	{
		weapon = attacker.weapon;
	}
	if(have_zombie_weapon_gib_head_callback(weapon))
	{
		if(self get_zombie_weapon_gib_head_callback(weapon, self.damagelocation))
		{
			return 1;
		}
		return 0;
	}
	if(type != "MOD_RIFLE_BULLET" && type != "MOD_PISTOL_BULLET")
	{
		if(type == "MOD_GRENADE" || type == "MOD_GRENADE_SPLASH")
		{
			if(distance(point, self gettagorigin("j_head")) > 55)
			{
				return 0;
			}
			else
			{
				return 1;
			}
		}
		else if(type == "MOD_PROJECTILE")
		{
			if(distance(point, self gettagorigin("j_head")) > 10)
			{
				return 0;
			}
			else
			{
				return 1;
			}
		}
		else if(weapon.weapClass != "spread")
		{
			return 0;
		}
	}
	if(!self damageLocationIsAny("head", "helmet", "neck"))
	{
		return 0;
	}
	if(type == "MOD_PISTOL_BULLET" && weapon.weapClass != "smg" && weapon.weapClass != "spread" || weapon == level.weaponnone || (isdefined(level.start_weapon) && weapon == level.start_weapon) || weapon.isGasWeapon)
	{
		return 0;
	}
	if(SessionModeIsCampaignGame() && (type == "MOD_PISTOL_BULLET" && weapon.weapClass != "smg"))
	{
		return 0;
	}
	low_health_percent = self.health / self.maxhealth * 100;
	if(low_health_percent > 10)
	{
		return 0;
	}
	return 1;
	ERROR: Exception occured: Stack empty.
}

/*
	Name: zombie_hat_gib
	Namespace: zombie_utility
	Checksum: 0x424F4353
	Offset: 0x6D60
	Size: 0xF8
	Parameters: 2
	Flags: None
	Line Number: 3743
*/
function zombie_hat_gib(attacker, means_of_death)
{
	self endon("death");
	if(isdefined(self.hat_gibbed) && self.hat_gibbed)
	{
		return;
	}
	if(!isdefined(self.gibSpawn5) || !isdefined(self.gibSpawnTag5))
	{
		return;
	}
	self.hat_gibbed = 1;
	if(isdefined(self.hatModel))
	{
		self detach(self.hatModel, "");
	}
	temp_array = [];
	temp_array[0] = level._ZOMBIE_GIB_PIECE_INDEX_HAT;
	self gib("normal", temp_array);
	if(isdefined(level.track_gibs))
	{
		level [[level.track_gibs]](self, temp_array);
	}
}

/*
	Name: head_gib_damage_over_time
	Namespace: zombie_utility
	Checksum: 0x424F4353
	Offset: 0x6E60
	Size: 0x178
	Parameters: 4
	Flags: None
	Line Number: 3778
*/
function head_gib_damage_over_time(dmg, delay, attacker, means_of_death)
{
	self endon("death");
	self endon("exploding");
	if(!isalive(self))
	{
		return;
	}
	if(!isplayer(attacker))
	{
		attacker = self;
	}
	if(!isdefined(means_of_death))
	{
		means_of_death = "MOD_UNKNOWN";
	}
	dot_location = self.damagelocation;
	dot_weapon = self.damageWeapon;
	while(1)
	{
		if(isdefined(delay))
		{
			wait(delay);
		}
		if(isdefined(self))
		{
			if(isdefined(self.no_gib) && self.no_gib)
			{
				return;
			}
			if(isdefined(attacker))
			{
				self dodamage(dmg, self gettagorigin("j_neck"), attacker, self, dot_location, means_of_death, 0, dot_weapon);
			}
			else
			{
				self dodamage(dmg, self gettagorigin("j_neck"));
			}
		}
	}
}

/*
	Name: derive_damage_refs
	Namespace: zombie_utility
	Checksum: 0x424F4353
	Offset: 0x6FE0
	Size: 0x360
	Parameters: 1
	Flags: None
	Line Number: 3830
*/
function derive_damage_refs(point)
{
	if(!isdefined(level.gib_tags))
	{
		init_gib_tags();
	}
	closestTag = undefined;
	for(i = 0; i < level.gib_tags.size; i++)
	{
		if(!isdefined(closestTag))
		{
			closestTag = level.gib_tags[i];
			continue;
		}
		if(distancesquared(point, self gettagorigin(level.gib_tags[i])) < distancesquared(point, self gettagorigin(closestTag)))
		{
			closestTag = level.gib_tags[i];
		}
	}
	if(closestTag == "J_SpineLower" || closestTag == "J_SpineUpper" || closestTag == "J_Spine4")
	{
		gibserverutils::gibrightarm(self);
	}
	else if(closestTag == "J_Shoulder_LE" || closestTag == "J_Elbow_LE" || closestTag == "J_Wrist_LE")
	{
		if(!gibserverutils::IsGibbed(self, 16))
		{
			gibserverutils::gibleftarm(self);
		}
	}
	else if(closestTag == "J_Shoulder_RI" || closestTag == "J_Elbow_RI" || closestTag == "J_Wrist_RI")
	{
		if(!gibserverutils::IsGibbed(self, 32))
		{
			gibserverutils::gibrightarm(self);
		}
	}
	else if(closestTag == "J_Hip_LE" || closestTag == "J_Knee_LE" || closestTag == "J_Ankle_LE")
	{
		if(isdefined(self.noCrawler) && self.noCrawler)
		{
			return;
		}
		gibserverutils::gibleftleg(self);
		if(randomint(100) > 75)
		{
			gibserverutils::gibrightleg(self);
		}
		self.missingLegs = 1;
	}
	else if(closestTag == "J_Hip_RI" || closestTag == "J_Knee_RI" || closestTag == "J_Ankle_RI")
	{
		if(isdefined(self.noCrawler) && self.noCrawler)
		{
			return;
		}
		gibserverutils::gibrightleg(self);
		if(randomint(100) > 75)
		{
			gibserverutils::gibleftleg(self);
		}
		self.missingLegs = 1;
	}
}

/*
	Name: init_gib_tags
	Namespace: zombie_utility
	Checksum: 0x424F4353
	Offset: 0x7348
	Size: 0x150
	Parameters: 0
	Flags: None
	Line Number: 3905
*/
function init_gib_tags()
{
	tags = [];
	tags[tags.size] = "J_SpineLower";
	tags[tags.size] = "J_SpineUpper";
	tags[tags.size] = "J_Spine4";
	tags[tags.size] = "J_Shoulder_LE";
	tags[tags.size] = "J_Elbow_LE";
	tags[tags.size] = "J_Wrist_LE";
	tags[tags.size] = "J_Shoulder_RI";
	tags[tags.size] = "J_Elbow_RI";
	tags[tags.size] = "J_Wrist_RI";
	tags[tags.size] = "J_Hip_LE";
	tags[tags.size] = "J_Knee_LE";
	tags[tags.size] = "J_Ankle_LE";
	tags[tags.size] = "J_Hip_RI";
	tags[tags.size] = "J_Knee_RI";
	tags[tags.size] = "J_Ankle_RI";
	level.gib_tags = tags;
	return;
}

/*
	Name: getAnimDirection
	Namespace: zombie_utility
	Checksum: 0x424F4353
	Offset: 0x74A0
	Size: 0x98
	Parameters: 1
	Flags: None
	Line Number: 3937
*/
function getAnimDirection(damageyaw)
{
	if(damageyaw > 135 || damageyaw <= -135)
	{
		return "front";
	}
	else if(damageyaw > 45 && damageyaw <= 135)
	{
		return "right";
	}
	else if(damageyaw > -45 && damageyaw <= 45)
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
	Name: anim_get_dvar_int
	Namespace: zombie_utility
	Checksum: 0x424F4353
	Offset: 0x7540
	Size: 0x48
	Parameters: 2
	Flags: None
	Line Number: 3968
*/
function anim_get_dvar_int(dvar, def)
{
	return int(anim_get_dvar(dvar, def));
}

/*
	Name: anim_get_dvar
	Namespace: zombie_utility
	Checksum: 0x424F4353
	Offset: 0x7590
	Size: 0x78
	Parameters: 2
	Flags: None
	Line Number: 3983
*/
function anim_get_dvar(dvar, def)
{
	if(getdvarstring(dvar) != "")
	{
		return getdvarfloat(dvar);
	}
	else
	{
		setdvar(dvar, def);
		return def;
	}
}

/*
	Name: makezombiecrawler
	Namespace: zombie_utility
	Checksum: 0x424F4353
	Offset: 0x7610
	Size: 0x170
	Parameters: 1
	Flags: None
	Line Number: 4006
*/
function makezombiecrawler(b_both_legs)
{
	if(isdefined(b_both_legs) && b_both_legs)
	{
		val = 100;
	}
	else
	{
		val = randomint(100);
	}
	if(val > 75)
	{
		gibserverutils::gibrightleg(self);
		gibserverutils::gibleftleg(self);
	}
	else if(val > 37)
	{
		gibserverutils::gibrightleg(self);
	}
	else
	{
		gibserverutils::gibleftleg(self);
	}
	self.missingLegs = 1;
	self AllowedStances("crouch");
	self setphysparams(15, 0, 24);
	self allowpitchangle(1);
	self SetPitchOrient();
	health = self.health;
	health = health * 0.1;
}

/*
	Name: zombie_head_gib
	Namespace: zombie_utility
	Checksum: 0x424F4353
	Offset: 0x7788
	Size: 0xE0
	Parameters: 2
	Flags: None
	Line Number: 4048
*/
function zombie_head_gib(attacker, means_of_death)
{
	self endon("death");
	if(isdefined(self.head_gibbed) && self.head_gibbed)
	{
		return;
	}
	if(isdefined(self.no_gib) && self.no_gib)
	{
		return;
	}
	self.head_gibbed = 1;
	self zombie_eye_glow_stop();
	if(!(isdefined(self.disable_head_gib) && self.disable_head_gib))
	{
		gibserverutils::gibhead(self);
	}
	self thread head_gib_damage_over_time(ceil(self.health * 0.2), 1, attacker, means_of_death);
}

/*
	Name: gib_random_parts
	Namespace: zombie_utility
	Checksum: 0x424F4353
	Offset: 0x7870
	Size: 0x198
	Parameters: 0
	Flags: None
	Line Number: 4078
*/
function gib_random_parts()
{
	if(isdefined(self.no_gib) && self.no_gib)
	{
		return;
	}
	val = randomint(100);
	if(val > 50)
	{
		self zombie_head_gib();
	}
	val = randomint(100);
	if(val > 50)
	{
		gibserverutils::gibrightleg(self);
	}
	val = randomint(100);
	if(val > 50)
	{
		gibserverutils::gibleftleg(self);
	}
	val = randomint(100);
	if(val > 50)
	{
		if(!gibserverutils::IsGibbed(self, 32))
		{
			gibserverutils::gibrightarm(self);
		}
	}
	val = randomint(100);
	if(val > 50)
	{
		if(!gibserverutils::IsGibbed(self, 16))
		{
			gibserverutils::gibleftarm(self);
		}
	}
}

/*
	Name: init_ignore_player_handler
	Namespace: zombie_utility
	Checksum: 0x424F4353
	Offset: 0x7A10
	Size: 0x10
	Parameters: 0
	Flags: AutoExec
	Line Number: 4127
*/
function autoexec init_ignore_player_handler()
{
	level._IGNORE_PLAYER_HANDLER = [];
}

/*
	Name: register_ignore_player_handler
	Namespace: zombie_utility
	Checksum: 0x424F4353
	Offset: 0x7A28
	Size: 0x90
	Parameters: 2
	Flags: None
	Line Number: 4142
*/
function register_ignore_player_handler(archetype, ignore_player_func)
{
	/#
		Assert(isdefined(archetype), "Dev Block strings are not supported");
	#/
	/#
		Assert(!isdefined(level._IGNORE_PLAYER_HANDLER[archetype]), "Dev Block strings are not supported" + archetype + "Dev Block strings are not supported");
	#/
	level._IGNORE_PLAYER_HANDLER[archetype] = ignore_player_func;
}

/*
	Name: run_ignore_player_handler
	Namespace: zombie_utility
	Checksum: 0x424F4353
	Offset: 0x7AC0
	Size: 0x38
	Parameters: 0
	Flags: None
	Line Number: 4163
*/
function run_ignore_player_handler()
{
	if(isdefined(level._IGNORE_PLAYER_HANDLER[self.archetype]))
	{
		self [[level._IGNORE_PLAYER_HANDLER[self.archetype]]]();
	}
}

/*
	Name: show_hit_marker
	Namespace: zombie_utility
	Checksum: 0x424F4353
	Offset: 0x7B00
	Size: 0x88
	Parameters: 0
	Flags: None
	Line Number: 4181
*/
function show_hit_marker()
{
	if(isdefined(self) && isdefined(self.hud_damagefeedback))
	{
		self.hud_damagefeedback setshader("damage_feedback", 24, 48);
		self.hud_damagefeedback.alpha = 1;
		self.hud_damagefeedback fadeovertime(1);
		self.hud_damagefeedback.alpha = 0;
	}
}

