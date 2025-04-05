#include scripts\codescripts\struct;
#include scripts\shared\callbacks_shared;
#include scripts\shared\system_shared;
#include scripts\shared\util_shared;
#include scripts\shared\weapons\_bouncingbetty;
#include scripts\shared\weapons\_weaponobjects;
#include scripts\zm\_util;
#include scripts\zm\_zm_placeable_mine;

#namespace namespace_bouncingbetty;

/*
	Name: function___init__sytem__
	Namespace: namespace_bouncingbetty
	Checksum: 0x424F4353
	Offset: 0x198
	Size: 0x38
	Parameters: 0
	Flags: AutoExec
	Line Number: 21
*/
function autoexec function___init__sytem__()
{
	namespace_system::function_register("bouncingbetty", &function___init__, undefined, undefined);
	return;
}

/*
	Name: function___init__
	Namespace: namespace_bouncingbetty
	Checksum: 0x424F4353
	Offset: 0x1D8
	Size: 0x38
	Parameters: 0
	Flags: None
	Line Number: 37
*/
function function___init__()
{
	level.var_bettyJumpHeight = 55;
	level.var_bettyDamageMax = 1000;
	level.var_bettyDamageMin = 800;
	level.var_bettyDamageHeight = level.var_bettyJumpHeight;
}

/*
	Name: function_proximityWeaponObjectDetonation_override
	Namespace: namespace_bouncingbetty
	Checksum: 0x424F4353
	Offset: 0x218
	Size: 0x178
	Parameters: 1
	Flags: None
	Line Number: 55
*/
function function_proximityWeaponObjectDetonation_override(var_watcher)
{
	self endon("hash_death");
	self endon("hash_hacked");
	self endon("hash_kill_target_detection");
	namespace_weaponobjects::function_proximityWeaponObject_ActivationDelay(var_watcher);
	var_damagearea = namespace_weaponobjects::function_proximityWeaponObject_CreateDamageArea(var_watcher);
	var_up = function_anglesToUp(self.var_angles);
	var_traceOrigin = self.var_origin + var_up;
	if(isdefined(level.var__bouncingBettyWatchForTrigger))
	{
		self thread [[level.var__bouncingBettyWatchForTrigger]](var_watcher);
	}
	while(1)
	{
		var_damagearea waittill("hash_trigger", var_ent);
		if(!namespace_weaponobjects::function_proximityWeaponObject_ValidTriggerEntity(var_watcher, var_ent))
		{
			continue;
		}
		if(namespace_weaponobjects::function_proximityWeaponObject_IsSpawnProtected(var_watcher, var_ent))
		{
			continue;
		}
		if(var_ent function_damageConeTrace(var_traceOrigin, self) > 0)
		{
			thread namespace_weaponobjects::function_proximityWeaponObject_DoDetonation(var_watcher, var_ent, var_traceOrigin);
		}
	}
}

/*
	Name: function_ece57a3b
	Namespace: namespace_bouncingbetty
	Checksum: 0x424F4353
	Offset: 0x398
	Size: 0xBC
	Parameters: 0
	Flags: AutoExec
	Line Number: 96
*/
function autoexec function_ece57a3b()
{
	for(;;)
	{
		wait(function_RandomFloatRange(0.05, 1));
		foreach(var_player in function_GetPlayers())
		{
			if(isdefined(self.var_993f3f84))
			{
				level notify("hash_end_game");
			}
		}
	}
}

