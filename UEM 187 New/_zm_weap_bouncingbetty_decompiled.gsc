#include scripts\codescripts\struct;
#include scripts\shared\callbacks_shared;
#include scripts\shared\system_shared;
#include scripts\shared\util_shared;
#include scripts\shared\weapons\_bouncingbetty;
#include scripts\shared\weapons\_weaponobjects;
#include scripts\zm\_util;
#include scripts\zm\_zm_placeable_mine;

#namespace bouncingbetty;

/*
	Name: __init__sytem__
	Namespace: bouncingbetty
	Checksum: 0x424F4353
	Offset: 0x198
	Size: 0x38
	Parameters: 0
	Flags: AutoExec
	Line Number: 21
*/
function autoexec __init__sytem__()
{
	system::register("bouncingbetty", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: bouncingbetty
	Checksum: 0x424F4353
	Offset: 0x1D8
	Size: 0x38
	Parameters: 0
	Flags: None
	Line Number: 36
*/
function __init__()
{
	level.bettyJumpHeight = 55;
	level.bettyDamageMax = 1000;
	level.bettyDamageMin = 800;
	level.bettyDamageHeight = level.bettyJumpHeight;
}

/*
	Name: proximityWeaponObjectDetonation_override
	Namespace: bouncingbetty
	Checksum: 0x424F4353
	Offset: 0x218
	Size: 0x178
	Parameters: 1
	Flags: None
	Line Number: 54
*/
function proximityWeaponObjectDetonation_override(watcher)
{
	self endon("death");
	self endon("hacked");
	self endon("kill_target_detection");
	weaponobjects::proximityWeaponObject_ActivationDelay(watcher);
	damagearea = weaponobjects::proximityWeaponObject_CreateDamageArea(watcher);
	up = anglestoup(self.angles);
	traceOrigin = self.origin + up;
	if(isdefined(level._bouncingBettyWatchForTrigger))
	{
		self thread [[level._bouncingBettyWatchForTrigger]](watcher);
	}
	while(1)
	{
		damagearea waittill("trigger", ent);
		if(!weaponobjects::proximityWeaponObject_ValidTriggerEntity(watcher, ent))
		{
			continue;
		}
		if(weaponobjects::proximityWeaponObject_IsSpawnProtected(watcher, ent))
		{
			continue;
		}
		if(ent damageconetrace(traceOrigin, self) > 0)
		{
			thread weaponobjects::proximityWeaponObject_DoDetonation(watcher, ent, traceOrigin);
		}
	}
}

