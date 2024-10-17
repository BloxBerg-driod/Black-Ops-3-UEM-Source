#include scripts\codescripts\struct;
#include scripts\shared\ai\zombie_death;
#include scripts\shared\clientfield_shared;
#include scripts\shared\system_shared;
#include scripts\shared\util_shared;
#include scripts\zm\_zm_audio;
#include scripts\zm\_zm_bgb;
#include scripts\zm\_zm_bgb_machine;
#include scripts\zm\_zm_magicbox;
#include scripts\zm\_zm_pers_upgrades_functions;
#include scripts\zm\_zm_powerups;
#include scripts\zm\_zm_score;
#include scripts\zm\_zm_spawner;
#include scripts\zm\_zm_utility;

#namespace zm_powerup_fire_sale;

/*
	Name: __init__sytem__
	Namespace: zm_powerup_fire_sale
	Checksum: 0x424F4353
	Offset: 0x368
	Size: 0x38
	Parameters: 0
	Flags: AutoExec
	Line Number: 27
*/
function autoexec __init__sytem__()
{
	system::register("zm_powerup_fire_sale", &__init__, undefined, undefined);
	return;
	ERROR: Bad function call
}

/*
	Name: __init__
	Namespace: zm_powerup_fire_sale
	Checksum: 0x424F4353
	Offset: 0x3A8
	Size: 0xF0
	Parameters: 0
	Flags: None
	Line Number: 44
*/
function __init__()
{
	zm_powerups::register_powerup("fire_sale", &grab_fire_sale);
	if(tolower(getdvarstring("g_gametype")) != "zcleansed")
	{
		zm_powerups::add_zombie_powerup("fire_sale", "p7_zm_power_up_firesale", &"ZOMBIE_POWERUP_MAX_AMMO", &func_should_drop_fire_sale, 0, 0, 0, undefined, "powerup_fire_sale", "zombie_powerup_fire_sale_time", "zombie_powerup_fire_sale_on");
	}
	if(!isdefined(level.var_147d7517))
	{
		level.var_147d7517 = [];
	}
	level.var_147d7517["fire_sale"] = 1;
}

/*
	Name: grab_fire_sale
	Namespace: zm_powerup_fire_sale
	Checksum: 0x424F4353
	Offset: 0x4A0
	Size: 0x48
	Parameters: 1
	Flags: None
	Line Number: 68
*/
function grab_fire_sale(player)
{
	level thread start_fire_sale(self);
	player thread zm_powerups::powerup_vo("firesale");
}

/*
	Name: start_fire_sale
	Namespace: zm_powerup_fire_sale
	Checksum: 0x424F4353
	Offset: 0x4F0
	Size: 0x208
	Parameters: 1
	Flags: None
	Line Number: 84
*/
function start_fire_sale(item)
{
	if(isdefined(level.custom_firesale_box_leave) && level.custom_firesale_box_leave)
	{
		while(firesale_chest_is_leaving())
		{
			wait(0.05);
		}
	}
	else if(level.zombie_vars["zombie_powerup_fire_sale_time"] > 0 && (isdefined(level.zombie_vars["zombie_powerup_fire_sale_on"]) && level.zombie_vars["zombie_powerup_fire_sale_on"]))
	{
		level.zombie_vars["zombie_powerup_fire_sale_time"] = level.zombie_vars["zombie_powerup_fire_sale_time"] + 30;
		return;
	}
	level notify("powerup fire sale");
	level endon("powerup fire sale");
	level thread zm_audio::sndAnnouncerPlayVox("fire_sale");
	level.zombie_vars["zombie_powerup_fire_sale_on"] = 1;
	level.disable_firesale_drop = 1;
	level thread toggle_fire_sale_on();
	level.zombie_vars["zombie_powerup_fire_sale_time"] = 30;
	if(bgb::is_team_enabled("zm_bgb_temporal_gift"))
	{
		level.zombie_vars["zombie_powerup_fire_sale_time"] = level.zombie_vars["zombie_powerup_fire_sale_time"] + 30;
	}
	while(level.zombie_vars["zombie_powerup_fire_sale_time"] > 0)
	{
		wait(0.05);
		level.zombie_vars["zombie_powerup_fire_sale_time"] = level.zombie_vars["zombie_powerup_fire_sale_time"] - 0.05;
	}
	level thread check_to_clear_fire_sale();
	level.zombie_vars["zombie_powerup_fire_sale_on"] = 0;
	level notify("fire_sale_off");
	return;
	ERROR: Exception occured: Stack empty.
}

/*
	Name: check_to_clear_fire_sale
	Namespace: zm_powerup_fire_sale
	Checksum: 0x424F4353
	Offset: 0x700
	Size: 0x30
	Parameters: 0
	Flags: None
	Line Number: 131
*/
function check_to_clear_fire_sale()
{
	while(firesale_chest_is_leaving())
	{
		wait(0.05);
	}
	level.disable_firesale_drop = undefined;
}

/*
	Name: firesale_chest_is_leaving
	Namespace: zm_powerup_fire_sale
	Checksum: 0x424F4353
	Offset: 0x738
	Size: 0x100
	Parameters: 0
	Flags: None
	Line Number: 150
*/
function firesale_chest_is_leaving()
{
	for(i = 0; i < level.chests.size; i++)
	{
		if(i !== level.chest_index)
		{
			if(level.chests[i].zbarrier.state === "leaving" || level.chests[i].zbarrier.state === "open" || level.chests[i].zbarrier.state === "close" || level.chests[i].zbarrier.state === "closing")
			{
				return 1;
			}
		}
	}
	return 0;
	ERROR: Exception occured: Stack empty.
}

/*
	Name: toggle_fire_sale_on
	Namespace: zm_powerup_fire_sale
	Checksum: 0x424F4353
	Offset: 0x840
	Size: 0x258
	Parameters: 0
	Flags: None
	Line Number: 176
*/
function toggle_fire_sale_on()
{
	level endon("powerup fire sale");
	if(!isdefined(level.zombie_vars["zombie_powerup_fire_sale_on"]))
	{
		return;
	}
	level thread sndFiresaleMusic_Start();
	bgb_machine::turn_on_fire_sale();
	for(i = 0; i < level.chests.size; i++)
	{
		show_firesale_box = level.chests[i] [[level._zombiemode_check_firesale_loc_valid_func]]();
		if(show_firesale_box)
		{
			level.chests[i].zombie_cost = 10;
			if(level.chest_index != i)
			{
				level.chests[i].was_temp = 1;
				if(isdefined(level.chests[i].hidden) && level.chests[i].hidden)
				{
					level.chests[i] thread apply_fire_sale_to_chest();
				}
			}
		}
	}
	level notify("fire_sale_on");
	level waittill("fire_sale_off");
	waittillframeend;
	level thread sndFiresaleMusic_Stop();
	bgb_machine::turn_off_fire_sale();
	for(i = 0; i < level.chests.size; i++)
	{
		show_firesale_box = level.chests[i] [[level._zombiemode_check_firesale_loc_valid_func]]();
		if(show_firesale_box)
		{
			if(level.chest_index != i && isdefined(level.chests[i].was_temp))
			{
				level.chests[i].was_temp = undefined;
				level thread remove_temp_chest(i);
			}
			level.chests[i].zombie_cost = level.chests[i].old_cost;
		}
	}
	return;
}

/*
	Name: apply_fire_sale_to_chest
	Namespace: zm_powerup_fire_sale
	Checksum: 0x424F4353
	Offset: 0xAA0
	Size: 0x98
	Parameters: 0
	Flags: None
	Line Number: 232
*/
function apply_fire_sale_to_chest()
{
	if(self.zbarrier GetZBarrierPieceState(1) == "closing")
	{
		while(self.zbarrier GetZBarrierPieceState(1) == "closing")
		{
			wait(0.1);
		}
		self.zbarrier waittill("left");
	}
	wait(0.1);
	self thread zm_magicbox::show_chest();
}

/*
	Name: remove_temp_chest
	Namespace: zm_powerup_fire_sale
	Checksum: 0x424F4353
	Offset: 0xB40
	Size: 0x268
	Parameters: 1
	Flags: None
	Line Number: 256
*/
function remove_temp_chest(chest_index)
{
	level.chests[chest_index].being_removed = 1;
	while(isdefined(level.chests[chest_index].chest_user) || (isdefined(level.chests[chest_index]._box_open) && level.chests[chest_index]._box_open == 1))
	{
		util::wait_network_frame();
	}
	if(level.zombie_vars["zombie_powerup_fire_sale_on"])
	{
		level.chests[chest_index].was_temp = 1;
		level.chests[chest_index].zombie_cost = 10;
		level.chests[chest_index].being_removed = 0;
		return;
	}
	for(i = 0; i < chest_index; i++)
	{
		util::wait_network_frame();
	}
	playfx(level._effect["poltergeist"], level.chests[chest_index].orig_origin);
	level.chests[chest_index].zbarrier playsound("zmb_box_poof_land");
	level.chests[chest_index].zbarrier playsound("zmb_couch_slam");
	util::wait_network_frame();
	if(isdefined(level.custom_firesale_box_leave) && level.custom_firesale_box_leave)
	{
		level.chests[chest_index] zm_magicbox::hide_chest(1);
	}
	else
	{
		level.chests[chest_index] zm_magicbox::hide_chest();
	}
	level.chests[chest_index].being_removed = 0;
}

/*
	Name: func_should_drop_fire_sale
	Namespace: zm_powerup_fire_sale
	Checksum: 0x424F4353
	Offset: 0xDB0
	Size: 0x80
	Parameters: 0
	Flags: None
	Line Number: 299
*/
function func_should_drop_fire_sale()
{
	if(level.zombie_vars["zombie_powerup_fire_sale_on"] == 1 || level.chest_moves < 1 || (isdefined(level.disable_firesale_drop) && level.disable_firesale_drop) || (!(isdefined(level.var_147d7517["fire_sale"]) && level.var_147d7517["fire_sale"])))
	{
		return 0;
	}
	return 1;
}

/*
	Name: sndFiresaleMusic_Start
	Namespace: zm_powerup_fire_sale
	Checksum: 0x424F4353
	Offset: 0xE38
	Size: 0x150
	Parameters: 0
	Flags: None
	Line Number: 318
*/
function sndFiresaleMusic_Start()
{
	array = level.chests;
	foreach(struct in array)
	{
		if(!isdefined(struct.sndent))
		{
			struct.sndent = spawn("script_origin", struct.origin + VectorScale((0, 0, 1), 100));
		}
		if(isdefined(level.player_4_vox_override) && level.player_4_vox_override)
		{
			struct.sndent playloopsound("mus_fire_sale_rich", 1);
			continue;
		}
		struct.sndent playloopsound("mus_fire_sale", 1);
	}
}

/*
	Name: sndFiresaleMusic_Stop
	Namespace: zm_powerup_fire_sale
	Checksum: 0x424F4353
	Offset: 0xF90
	Size: 0xC8
	Parameters: 0
	Flags: None
	Line Number: 346
*/
function sndFiresaleMusic_Stop()
{
	array = level.chests;
	foreach(struct in array)
	{
		if(isdefined(struct.sndent))
		{
			struct.sndent delete();
			struct.sndent = undefined;
		}
	}
}

