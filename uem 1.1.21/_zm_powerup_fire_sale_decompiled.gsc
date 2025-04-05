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

#namespace namespace_zm_powerup_fire_sale;

/*
	Name: function___init__sytem__
	Namespace: namespace_zm_powerup_fire_sale
	Checksum: 0x424F4353
	Offset: 0x368
	Size: 0x38
	Parameters: 0
	Flags: AutoExec
	Line Number: 27
*/
function autoexec function___init__sytem__()
{
	namespace_system::function_register("zm_powerup_fire_sale", &function___init__, undefined, undefined);
}

/*
	Name: function___init__
	Namespace: namespace_zm_powerup_fire_sale
	Checksum: 0x424F4353
	Offset: 0x3A8
	Size: 0xF0
	Parameters: 0
	Flags: None
	Line Number: 42
*/
function function___init__()
{
	namespace_zm_powerups::function_register_powerup("fire_sale", &function_grab_fire_sale);
	if(function_ToLower(function_GetDvarString("g_gametype")) != "zcleansed")
	{
		namespace_zm_powerups::function_add_zombie_powerup("fire_sale", "p7_zm_power_up_firesale", &"ZOMBIE_POWERUP_MAX_AMMO", &function_func_should_drop_fire_sale, 0, 0, 0, undefined, "powerup_fire_sale", "zombie_powerup_fire_sale_time", "zombie_powerup_fire_sale_on");
	}
	if(!isdefined(level.var_147d7517))
	{
		level.var_147d7517 = [];
	}
	level.var_147d7517["fire_sale"] = 1;
}

/*
	Name: function_grab_fire_sale
	Namespace: namespace_zm_powerup_fire_sale
	Checksum: 0x424F4353
	Offset: 0x4A0
	Size: 0x48
	Parameters: 1
	Flags: None
	Line Number: 66
*/
function function_grab_fire_sale(var_player)
{
	level thread function_start_fire_sale(self);
	var_player thread namespace_zm_powerups::function_powerup_vo("firesale");
	return;
	ERROR: Exception occured: Stack empty.
}

/*
	Name: function_start_fire_sale
	Namespace: namespace_zm_powerup_fire_sale
	Checksum: 0x424F4353
	Offset: 0x4F0
	Size: 0x208
	Parameters: 1
	Flags: None
	Line Number: 84
*/
function function_start_fire_sale(var_item)
{
	if(isdefined(level.var_custom_firesale_box_leave) && level.var_custom_firesale_box_leave)
	{
		while(function_firesale_chest_is_leaving())
		{
			wait(0.05);
		}
	}
	else if(level.var_zombie_vars["zombie_powerup_fire_sale_time"] > 0 && (isdefined(level.var_zombie_vars["zombie_powerup_fire_sale_on"]) && level.var_zombie_vars["zombie_powerup_fire_sale_on"]))
	{
		level.var_zombie_vars["zombie_powerup_fire_sale_time"] = level.var_zombie_vars["zombie_powerup_fire_sale_time"] + 30;
		return;
	}
	level notify("hash_powerup fire sale");
	level endon("hash_powerup fire sale");
	level thread namespace_zm_audio::function_sndAnnouncerPlayVox("fire_sale");
	level.var_zombie_vars["zombie_powerup_fire_sale_on"] = 1;
	level.var_disable_firesale_drop = 1;
	level thread function_toggle_fire_sale_on();
	level.var_zombie_vars["zombie_powerup_fire_sale_time"] = 30;
	if(namespace_bgb::function_is_team_enabled("zm_bgb_temporal_gift"))
	{
		level.var_zombie_vars["zombie_powerup_fire_sale_time"] = level.var_zombie_vars["zombie_powerup_fire_sale_time"] + 30;
	}
	while(level.var_zombie_vars["zombie_powerup_fire_sale_time"] > 0)
	{
		wait(0.05);
		level.var_zombie_vars["zombie_powerup_fire_sale_time"] = level.var_zombie_vars["zombie_powerup_fire_sale_time"] - 0.05;
	}
	level thread function_check_to_clear_fire_sale();
	level.var_zombie_vars["zombie_powerup_fire_sale_on"] = 0;
	level notify("hash_fire_sale_off");
}

/*
	Name: function_check_to_clear_fire_sale
	Namespace: namespace_zm_powerup_fire_sale
	Checksum: 0x424F4353
	Offset: 0x700
	Size: 0x30
	Parameters: 0
	Flags: None
	Line Number: 129
*/
function function_check_to_clear_fire_sale()
{
	while(function_firesale_chest_is_leaving())
	{
		wait(0.05);
	}
	level.var_disable_firesale_drop = undefined;
	return;
	ERROR: Exception occured: Stack empty.
}

/*
	Name: function_firesale_chest_is_leaving
	Namespace: namespace_zm_powerup_fire_sale
	Checksum: 0x424F4353
	Offset: 0x738
	Size: 0x100
	Parameters: 0
	Flags: None
	Line Number: 150
*/
function function_firesale_chest_is_leaving()
{
	for(var_i = 0; var_i < level.var_chests.size; var_i++)
	{
		if(var_i !== level.var_chest_index)
		{
			if(level.var_chests[var_i].var_zbarrier.var_State === "leaving" || level.var_chests[var_i].var_zbarrier.var_State === "open" || level.var_chests[var_i].var_zbarrier.var_State === "close" || level.var_chests[var_i].var_zbarrier.var_State === "closing")
			{
				return 1;
			}
		}
	}
	return 0;
}

/*
	Name: function_toggle_fire_sale_on
	Namespace: namespace_zm_powerup_fire_sale
	Checksum: 0x424F4353
	Offset: 0x840
	Size: 0x258
	Parameters: 0
	Flags: None
	Line Number: 175
*/
function function_toggle_fire_sale_on()
{
	level endon("hash_powerup fire sale");
	if(!isdefined(level.var_zombie_vars["zombie_powerup_fire_sale_on"]))
	{
		return;
	}
	level thread function_sndFiresaleMusic_Start();
	namespace_bgb_machine::function_turn_on_fire_sale();
	for(var_i = 0; var_i < level.var_chests.size; var_i++)
	{
		var_show_firesale_box = level.var_chests[var_i] [[level.var__zombiemode_check_firesale_loc_valid_func]]();
		if(var_show_firesale_box)
		{
			level.var_chests[var_i].var_zombie_cost = 10;
			if(level.var_chest_index != var_i)
			{
				level.var_chests[var_i].var_was_temp = 1;
				if(isdefined(level.var_chests[var_i].var_hidden) && level.var_chests[var_i].var_hidden)
				{
					level.var_chests[var_i] thread function_apply_fire_sale_to_chest();
				}
			}
		}
	}
	level notify("hash_fire_sale_on");
	level waittill("hash_fire_sale_off");
	waittillframeend;
	level thread function_sndFiresaleMusic_Stop();
	namespace_bgb_machine::function_turn_off_fire_sale();
	for(var_i = 0; var_i < level.var_chests.size; var_i++)
	{
		var_show_firesale_box = level.var_chests[var_i] [[level.var__zombiemode_check_firesale_loc_valid_func]]();
		if(var_show_firesale_box)
		{
			if(level.var_chest_index != var_i && isdefined(level.var_chests[var_i].var_was_temp))
			{
				level.var_chests[var_i].var_was_temp = undefined;
				level thread function_remove_temp_chest(var_i);
			}
			level.var_chests[var_i].var_zombie_cost = level.var_chests[var_i].var_old_cost;
		}
	}
}

/*
	Name: function_apply_fire_sale_to_chest
	Namespace: namespace_zm_powerup_fire_sale
	Checksum: 0x424F4353
	Offset: 0xAA0
	Size: 0x98
	Parameters: 0
	Flags: None
	Line Number: 230
*/
function function_apply_fire_sale_to_chest()
{
	if(self.var_zbarrier function_GetZBarrierPieceState(1) == "closing")
	{
		while(self.var_zbarrier function_GetZBarrierPieceState(1) == "closing")
		{
			wait(0.1);
		}
		self.var_zbarrier waittill("hash_left");
	}
	wait(0.1);
	self thread namespace_zm_magicbox::function_show_chest();
}

/*
	Name: function_remove_temp_chest
	Namespace: namespace_zm_powerup_fire_sale
	Checksum: 0x424F4353
	Offset: 0xB40
	Size: 0x268
	Parameters: 1
	Flags: None
	Line Number: 254
*/
function function_remove_temp_chest(var_chest_index)
{
	level.var_chests[var_chest_index].var_being_removed = 1;
	while(isdefined(level.var_chests[var_chest_index].var_chest_user) || (isdefined(level.var_chests[var_chest_index].var__box_open) && level.var_chests[var_chest_index].var__box_open == 1))
	{
		namespace_util::function_wait_network_frame();
	}
	if(level.var_zombie_vars["zombie_powerup_fire_sale_on"])
	{
		level.var_chests[var_chest_index].var_was_temp = 1;
		level.var_chests[var_chest_index].var_zombie_cost = 10;
		level.var_chests[var_chest_index].var_being_removed = 0;
		return;
	}
	for(var_i = 0; var_i < var_chest_index; var_i++)
	{
		namespace_util::function_wait_network_frame();
	}
	function_playFX(level.var__effect["poltergeist"], level.var_chests[var_chest_index].var_orig_origin);
	level.var_chests[var_chest_index].var_zbarrier function_playsound("zmb_box_poof_land");
	level.var_chests[var_chest_index].var_zbarrier function_playsound("zmb_couch_slam");
	namespace_util::function_wait_network_frame();
	if(isdefined(level.var_custom_firesale_box_leave) && level.var_custom_firesale_box_leave)
	{
		level.var_chests[var_chest_index] namespace_zm_magicbox::function_hide_chest(1);
	}
	else
	{
		level.var_chests[var_chest_index] namespace_zm_magicbox::function_hide_chest();
	}
	level.var_chests[var_chest_index].var_being_removed = 0;
}

/*
	Name: function_func_should_drop_fire_sale
	Namespace: namespace_zm_powerup_fire_sale
	Checksum: 0x424F4353
	Offset: 0xDB0
	Size: 0x80
	Parameters: 0
	Flags: None
	Line Number: 297
*/
function function_func_should_drop_fire_sale()
{
	if(level.var_zombie_vars["zombie_powerup_fire_sale_on"] == 1 || level.var_chest_moves < 1 || (isdefined(level.var_disable_firesale_drop) && level.var_disable_firesale_drop) || (!(isdefined(level.var_147d7517["fire_sale"]) && level.var_147d7517["fire_sale"])))
	{
		return 0;
	}
	return 1;
	ERROR: Exception occured: Stack empty.
}

/*
	Name: function_sndFiresaleMusic_Start
	Namespace: namespace_zm_powerup_fire_sale
	Checksum: 0x424F4353
	Offset: 0xE38
	Size: 0x150
	Parameters: 0
	Flags: None
	Line Number: 317
*/
function function_sndFiresaleMusic_Start()
{
	var_Array = level.var_chests;
	foreach(var_struct in var_Array)
	{
		if(!isdefined(var_struct.var_sndent))
		{
			var_struct.var_sndent = function_spawn("script_origin", var_struct.var_origin + VectorScale((0, 0, 1), 100));
		}
		if(isdefined(level.var_player_4_vox_override) && level.var_player_4_vox_override)
		{
			var_struct.var_sndent function_PlayLoopSound("mus_fire_sale_rich", 1);
			continue;
		}
		var_struct.var_sndent function_PlayLoopSound("mus_fire_sale", 1);
	}
}

/*
	Name: function_sndFiresaleMusic_Stop
	Namespace: namespace_zm_powerup_fire_sale
	Checksum: 0x424F4353
	Offset: 0xF90
	Size: 0xC8
	Parameters: 0
	Flags: None
	Line Number: 345
*/
function function_sndFiresaleMusic_Stop()
{
	var_Array = level.var_chests;
	foreach(var_struct in var_Array)
	{
		if(isdefined(var_struct.var_sndent))
		{
			var_struct.var_sndent function_delete();
			var_struct.var_sndent = undefined;
		}
	}
}

