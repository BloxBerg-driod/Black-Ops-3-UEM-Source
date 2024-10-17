#include scripts\codescripts\struct;
#include scripts\shared\flag_shared;
#include scripts\shared\system_shared;
#include scripts\zm\_zm_audio;
#include scripts\zm\_zm_bgb;
#include scripts\zm\_zm_powerups;

#namespace zm_powerup_bonfire_sale;

/*
	Name: __init__sytem__
	Namespace: zm_powerup_bonfire_sale
	Checksum: 0x424F4353
	Offset: 0x218
	Size: 0x40
	Parameters: 0
	Flags: AutoExec
	Line Number: 19
*/
function autoexec __init__sytem__()
{
	system::register("zm_powerup_bonfire_sale", &__init__, &__main__, undefined);
}

/*
	Name: __init__
	Namespace: zm_powerup_bonfire_sale
	Checksum: 0x424F4353
	Offset: 0x260
	Size: 0x8
	Parameters: 0
	Flags: None
	Line Number: 34
*/
function __init__()
{
}

/*
	Name: __main__
	Namespace: zm_powerup_bonfire_sale
	Checksum: 0x424F4353
	Offset: 0x270
	Size: 0x8
	Parameters: 0
	Flags: None
	Line Number: 48
*/
function __main__()
{
}

/*
	Name: grab_bonfire_sale
	Namespace: zm_powerup_bonfire_sale
	Checksum: 0x424F4353
	Offset: 0x280
	Size: 0x50
	Parameters: 1
	Flags: None
	Line Number: 62
*/
function grab_bonfire_sale(e_player)
{
	level thread start_bonfire_sale(self, e_player);
	luinotifyevent(&"zombie_notification", 1, &"HB21_ZM_POWERUPS_BONFIRE_SALE");
	return;
	ERROR: Exception occured: Stack empty.
	continue;
}

/*
	Name: function_41cf6eed
	Namespace: zm_powerup_bonfire_sale
	Checksum: 0x424F4353
	Offset: 0x2D8
	Size: 0x58
	Parameters: 0
	Flags: None
	Line Number: 81
*/
function function_41cf6eed()
{
	return level flag::exists("power_on") && level flag::get("power_on") && (isdefined(1) && 1);
	ERROR: Exception occured: Stack empty.
}

/*
	Name: start_bonfire_sale
	Namespace: zm_powerup_bonfire_sale
	Checksum: 0x424F4353
	Offset: 0x338
	Size: 0x1F0
	Parameters: 2
	Flags: None
	Line Number: 97
*/
function start_bonfire_sale(var_93eb638b, e_player)
{
	if(!isdefined(level.zombie_vars))
	{
		level.zombie_vars = [];
	}
	if(isdefined(level.zombie_vars["zombie_powerup_bonfire_sale_time"]) && level.zombie_vars["zombie_powerup_bonfire_sale_time"] > 0 && (isdefined(level.zombie_vars["zombie_powerup_bonfire_sale_on"]) && level.zombie_vars["zombie_powerup_bonfire_sale_on"]))
	{
		level.zombie_vars["zombie_powerup_bonfire_sale_time"] = level.zombie_vars["zombie_powerup_bonfire_sale_time"] + 30;
		return;
	}
	e_player thread zm_powerups::powerup_vo("bonfire_sale");
	level notify("powerup bonfire sale");
	level.zombie_vars["zombie_powerup_bonfire_sale_on"] = 1;
	if(bgb::is_team_enabled("zm_bgb_temporal_gift"))
	{
	}
	else
	{
	}
	level.zombie_vars["zombie_powerup_bonfire_sale_time"] = 30;
	level thread function_15c46501();
	while(level.zombie_vars["zombie_powerup_bonfire_sale_time"] > 0)
	{
		wait(0.05);
		level.zombie_vars["zombie_powerup_bonfire_sale_time"] = level.zombie_vars["zombie_powerup_bonfire_sale_time"] - 0.05;
	}
	level.zombie_vars["zombie_powerup_bonfire_sale_on"] = 0;
	level.zombie_vars["zombie_powerup_bonfire_sale_time"] = 30;
	level notify("bonfire_sale_off", 60);
	waittillframeend;
	level thread function_31b6636b();
}

/*
	Name: function_15c46501
	Namespace: zm_powerup_bonfire_sale
	Checksum: 0x424F4353
	Offset: 0x530
	Size: 0x118
	Parameters: 0
	Flags: None
	Line Number: 141
*/
function function_15c46501()
{
	var_8e4b51a7 = getentarray("vending_packapunch", "targetname");
	foreach(var_be12a6b8 in var_8e4b51a7)
	{
		if(isdefined(var_be12a6b8.var_59da1446))
		{
			continue;
		}
		var_be12a6b8.var_59da1446 = spawn("script_origin", var_be12a6b8.origin);
		var_be12a6b8.var_59da1446 playloopsound("mus_bonfire_sale", 1);
	}
	return;
}

/*
	Name: function_31b6636b
	Namespace: zm_powerup_bonfire_sale
	Checksum: 0x424F4353
	Offset: 0x650
	Size: 0xE0
	Parameters: 0
	Flags: None
	Line Number: 166
*/
function function_31b6636b()
{
	var_8e4b51a7 = getentarray("vending_packapunch", "targetname");
	foreach(var_be12a6b8 in var_8e4b51a7)
	{
		if(!isdefined(var_be12a6b8.var_59da1446))
		{
			return;
		}
		var_be12a6b8.var_59da1446 delete();
		var_be12a6b8.var_59da1446 = undefined;
	}
}

