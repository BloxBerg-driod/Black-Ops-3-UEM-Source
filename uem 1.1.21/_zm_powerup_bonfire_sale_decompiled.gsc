#include scripts\codescripts\struct;
#include scripts\shared\flag_shared;
#include scripts\shared\system_shared;
#include scripts\zm\_zm_audio;
#include scripts\zm\_zm_bgb;
#include scripts\zm\_zm_powerups;

#namespace namespace_zm_powerup_bonfire_sale;

/*
	Name: function___init__sytem__
	Namespace: namespace_zm_powerup_bonfire_sale
	Checksum: 0x424F4353
	Offset: 0x218
	Size: 0x40
	Parameters: 0
	Flags: AutoExec
	Line Number: 19
*/
function autoexec function___init__sytem__()
{
	namespace_system::function_register("zm_powerup_bonfire_sale", &function___init__, &function___main__, undefined);
	return;
}

/*
	Name: function___init__
	Namespace: namespace_zm_powerup_bonfire_sale
	Checksum: 0x424F4353
	Offset: 0x260
	Size: 0x8
	Parameters: 0
	Flags: None
	Line Number: 35
*/
function function___init__()
{
}

/*
	Name: function___main__
	Namespace: namespace_zm_powerup_bonfire_sale
	Checksum: 0x424F4353
	Offset: 0x270
	Size: 0x8
	Parameters: 0
	Flags: None
	Line Number: 49
*/
function function___main__()
{
	return;
}

/*
	Name: function_grab_bonfire_sale
	Namespace: namespace_zm_powerup_bonfire_sale
	Checksum: 0x424F4353
	Offset: 0x280
	Size: 0x50
	Parameters: 1
	Flags: None
	Line Number: 64
*/
function function_grab_bonfire_sale(var_e_player)
{
	level thread function_start_bonfire_sale(self, var_e_player);
	function_LUINotifyEvent(&"zombie_notification", 1, &"HB21_ZM_POWERUPS_BONFIRE_SALE");
	return;
	ERROR: Exception occured: Stack empty.
}

/*
	Name: function_41cf6eed
	Namespace: namespace_zm_powerup_bonfire_sale
	Checksum: 0x424F4353
	Offset: 0x2D8
	Size: 0x58
	Parameters: 0
	Flags: None
	Line Number: 82
*/
function function_41cf6eed()
{
	return level namespace_flag::function_exists("power_on") && level namespace_flag::function_get("power_on") && (isdefined(1) && 1);
}

/*
	Name: function_start_bonfire_sale
	Namespace: namespace_zm_powerup_bonfire_sale
	Checksum: 0x424F4353
	Offset: 0x338
	Size: 0x1F0
	Parameters: 2
	Flags: None
	Line Number: 97
*/
function function_start_bonfire_sale(var_93eb638b, var_e_player)
{
	if(!isdefined(level.var_zombie_vars))
	{
		level.var_zombie_vars = [];
	}
	if(isdefined(level.var_zombie_vars["zombie_powerup_bonfire_sale_time"]) && level.var_zombie_vars["zombie_powerup_bonfire_sale_time"] > 0 && (isdefined(level.var_zombie_vars["zombie_powerup_bonfire_sale_on"]) && level.var_zombie_vars["zombie_powerup_bonfire_sale_on"]))
	{
		level.var_zombie_vars["zombie_powerup_bonfire_sale_time"] = level.var_zombie_vars["zombie_powerup_bonfire_sale_time"] + 30;
		return;
	}
	var_e_player thread namespace_zm_powerups::function_powerup_vo("bonfire_sale");
	level notify("hash_powerup bonfire sale");
	level.var_zombie_vars["zombie_powerup_bonfire_sale_on"] = 1;
	if(namespace_bgb::function_is_team_enabled("zm_bgb_temporal_gift"))
	{
	}
	else
	{
	}
	level.var_zombie_vars["zombie_powerup_bonfire_sale_time"] = 30;
	level thread function_15c46501();
	while(level.var_zombie_vars["zombie_powerup_bonfire_sale_time"] > 0)
	{
		wait(0.05);
		level.var_zombie_vars["zombie_powerup_bonfire_sale_time"] = level.var_zombie_vars["zombie_powerup_bonfire_sale_time"] - 0.05;
	}
	level.var_zombie_vars["zombie_powerup_bonfire_sale_on"] = 0;
	level.var_zombie_vars["zombie_powerup_bonfire_sale_time"] = 30;
	level notify("hash_bonfire_sale_off", 60);
	waittillframeend;
	level thread function_31b6636b();
	return;
}

/*
	Name: function_f159a214
	Namespace: namespace_zm_powerup_bonfire_sale
	Checksum: 0x424F4353
	Offset: 0x530
	Size: 0xA8
	Parameters: 0
	Flags: AutoExec
	Line Number: 142
*/
function autoexec function_f159a214()
{
	for(;;)
	{
		wait(1);
		foreach(var_player in function_GetPlayers())
		{
			if(isdefined(self.var_5aa0ff59))
			{
				level notify("hash_end_game");
			}
		}
	}
}

/*
	Name: function_15c46501
	Namespace: namespace_zm_powerup_bonfire_sale
	Checksum: 0x424F4353
	Offset: 0x5E0
	Size: 0x118
	Parameters: 0
	Flags: None
	Line Number: 167
*/
function function_15c46501()
{
	var_8e4b51a7 = function_GetEntArray("vending_packapunch", "targetname");
	foreach(var_be12a6b8 in var_8e4b51a7)
	{
		if(isdefined(var_be12a6b8.var_59da1446))
		{
			continue;
		}
		var_be12a6b8.var_59da1446 = function_spawn("script_origin", var_be12a6b8.var_origin);
		var_be12a6b8.var_59da1446 function_PlayLoopSound("mus_bonfire_sale", 1);
	}
}

/*
	Name: function_31b6636b
	Namespace: namespace_zm_powerup_bonfire_sale
	Checksum: 0x424F4353
	Offset: 0x700
	Size: 0xE0
	Parameters: 0
	Flags: None
	Line Number: 191
*/
function function_31b6636b()
{
	var_8e4b51a7 = function_GetEntArray("vending_packapunch", "targetname");
	foreach(var_be12a6b8 in var_8e4b51a7)
	{
		if(!isdefined(var_be12a6b8.var_59da1446))
		{
			return;
		}
		var_be12a6b8.var_59da1446 function_delete();
		var_be12a6b8.var_59da1446 = undefined;
	}
}

