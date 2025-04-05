#include scripts\codescripts\struct;
#include scripts\shared\array_shared;
#include scripts\shared\callbacks_shared;
#include scripts\shared\clientfield_shared;
#include scripts\shared\duplicaterender_mgr;
#include scripts\shared\fx_shared;
#include scripts\shared\spawner_shared;
#include scripts\shared\system_shared;
#include scripts\shared\util_shared;
#include scripts\zm\_zm;

#namespace namespace_974d07ca;

/*
	Name: function___init__sytem__
	Namespace: namespace_974d07ca
	Checksum: 0x424F4353
	Offset: 0x210
	Size: 0x38
	Parameters: 0
	Flags: AutoExec
	Line Number: 23
*/
function autoexec function___init__sytem__()
{
	namespace_system::function_register("zm_bloodsplatter", &function___init__, undefined, undefined);
}

/*
	Name: function___init__
	Namespace: namespace_974d07ca
	Checksum: 0x424F4353
	Offset: 0x250
	Size: 0xE8
	Parameters: 0
	Flags: Private
	Line Number: 38
*/
function private function___init__()
{
	namespace_clientfield::function_register("allplayers", "bloodsplatter_toggle", 12000, 1, "counter");
	namespace_Array::function_run_all(function_GetSpawnerArray(), &namespace_spawner::function_add_spawn_function, &function_b4c8cf33);
	namespace_Array::function_run_all(function_GetVehicleArray(), &namespace_spawner::function_add_spawn_function, &function_b4c8cf33);
	function_45d38cb7("sentinel_drone");
	function_45d38cb7("ghost");
}

/*
	Name: function_45d38cb7
	Namespace: namespace_974d07ca
	Checksum: 0x424F4353
	Offset: 0x340
	Size: 0x60
	Parameters: 1
	Flags: None
	Line Number: 57
*/
function function_45d38cb7(var_archetype)
{
	/#
		namespace_::function_Assert(isdefined(var_archetype), "Dev Block strings are not supported");
	#/
	if(!isdefined(level.var_816ad3df))
	{
		level.var_816ad3df = [];
	}
	level.var_816ad3df[var_archetype] = 1;
	return;
}

/*
	Name: function_c668e1b8
	Namespace: namespace_974d07ca
	Checksum: 0x424F4353
	Offset: 0x3A8
	Size: 0x60
	Parameters: 1
	Flags: None
	Line Number: 80
*/
function function_c668e1b8(var_archetype)
{
	/#
		namespace_::function_Assert(isdefined(var_archetype), "Dev Block strings are not supported");
	#/
	if(!isdefined(level.var_816ad3df))
	{
		level.var_816ad3df = [];
	}
	level.var_816ad3df[var_archetype] = 0;
}

/*
	Name: function_edcffb23
	Namespace: namespace_974d07ca
	Checksum: 0x424F4353
	Offset: 0x410
	Size: 0x48
	Parameters: 1
	Flags: None
	Line Number: 102
*/
function function_edcffb23(var_archetype)
{
	return isdefined(var_archetype) && isdefined(level.var_816ad3df) && (isdefined(level.var_816ad3df[var_archetype]) && level.var_816ad3df[var_archetype]);
	~;
	ERROR: Exception occured: Stack empty.
}

/*
	Name: function_1b3ee8d9
	Namespace: namespace_974d07ca
	Checksum: 0x424F4353
	Offset: 0x460
	Size: 0x40
	Parameters: 0
	Flags: None
	Line Number: 119
*/
function function_1b3ee8d9()
{
	if(self.var_f4d01b67["blood_splatter"] == 0)
	{
		self namespace_clientfield::function_increment("bloodsplatter_toggle", 1);
	}
}

/*
	Name: function_e6039dd0
	Namespace: namespace_974d07ca
	Checksum: 0x424F4353
	Offset: 0x4A8
	Size: 0x100
	Parameters: 2
	Flags: None
	Line Number: 137
*/
function function_e6039dd0(var_origin, var_dist)
{
	foreach(var_player in level.var_players)
	{
		if(function_DistanceSquared(var_player.var_origin, var_origin) < var_dist)
		{
			if(function_IsFunctionPtr(level.var_a314e5b8))
			{
				var_player [[level.var_a314e5b8]](var_origin, var_dist);
			}
			var_player function_1b3ee8d9();
		}
	}
}

/*
	Name: function_b4c8cf33
	Namespace: namespace_974d07ca
	Checksum: 0x424F4353
	Offset: 0x5B0
	Size: 0xA0
	Parameters: 0
	Flags: Private
	Line Number: 162
*/
function private function_b4c8cf33()
{
	if(isdefined(level.var_3f47f85d) && level.var_3f47f85d)
	{
		return;
	}
	if(!isdefined(self.var_archetype))
	{
		return;
	}
	if(function_edcffb23(self.var_archetype))
	{
		return;
	}
	level endon("hash_c2eeb069");
	while(function_isalive(self))
	{
		self waittill("hash_damage");
		if(!isdefined(self))
		{
			return;
		}
		function_e6039dd0(self.var_origin, 16384);
	}
}

