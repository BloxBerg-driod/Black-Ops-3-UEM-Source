#include scripts\codescripts\struct;
#include scripts\shared\ai\systems\gib;
#include scripts\shared\ai\zombie_death;
#include scripts\shared\array_shared;
#include scripts\shared\callbacks_shared;
#include scripts\shared\clientfield_shared;
#include scripts\shared\flag_shared;
#include scripts\shared\flagsys_shared;
#include scripts\shared\laststand_shared;
#include scripts\shared\system_shared;
#include scripts\shared\util_shared;
#include scripts\zm\_zm_audio;
#include scripts\zm\_zm_blockers;
#include scripts\zm\_zm_devgui;
#include scripts\zm\_zm_lightning_chain;
#include scripts\zm\_zm_melee_weapon;
#include scripts\zm\_zm_pers_upgrades;
#include scripts\zm\_zm_pers_upgrades_functions;
#include scripts\zm\_zm_powerups;
#include scripts\zm\_zm_score;
#include scripts\zm\_zm_spawner;
#include scripts\zm\_zm_utility;
#include scripts\zm\_zm_weapon_upgrade_system;
#include scripts\zm\_zm_weapons;

#namespace namespace_d6e84f96;

/*
	Name: function___init__sytem__
	Namespace: namespace_d6e84f96
	Checksum: 0x424F4353
	Offset: 0x4F8
	Size: 0x38
	Parameters: 0
	Flags: AutoExec
	Line Number: 37
*/
function autoexec function___init__sytem__()
{
	namespace_system::function_register("zm_powerup_storm_surge", &function___init__, undefined, undefined);
	return;
	ERROR: Exception occured: Stack empty.
	continue;
}

/*
	Name: function___init__
	Namespace: namespace_d6e84f96
	Checksum: 0x424F4353
	Offset: 0x538
	Size: 0x138
	Parameters: 0
	Flags: None
	Line Number: 55
*/
function function___init__()
{
	namespace_zm_powerups::function_register_powerup("storm_surge", &function_d7b3d5fa);
	if(function_ToLower(function_GetDvarString("g_gametype")) != "zcleansed")
	{
		namespace_zm_powerups::function_add_zombie_powerup("storm_surge", "p7_zm_power_up_storm_surge", &"ZOMBIE_POWERUP_STORM_SURGE", &function_4f0a6378, 1, 0, 0, undefined, "powerup_storm_surge", "zombie_powerup_storm_surge_time", "zombie_powerup_storm_surge_on");
	}
	namespace_callback::function_on_connect(&function_init_player_zombie_vars);
	if(!isdefined(level.var_147d7517))
	{
		level.var_147d7517 = [];
	}
	level.var_999cc9cf = 0;
	level.var_147d7517["storm_surge"] = 1;
	level.var__effect["storm_surge_player"] = "_sphynx/_zm_powerup_storm_surge";
}

/*
	Name: function_init_player_zombie_vars
	Namespace: namespace_d6e84f96
	Checksum: 0x424F4353
	Offset: 0x678
	Size: 0x30
	Parameters: 0
	Flags: None
	Line Number: 82
*/
function function_init_player_zombie_vars()
{
	self.var_zombie_vars["zombie_powerup_storm_surge_on"] = 0;
	self.var_zombie_vars["zombie_powerup_storm_surge_time"] = 0;
}

/*
	Name: function_4f0a6378
	Namespace: namespace_d6e84f96
	Checksum: 0x424F4353
	Offset: 0x6B0
	Size: 0x38
	Parameters: 0
	Flags: None
	Line Number: 98
*/
function function_4f0a6378()
{
	if(!(isdefined(level.var_147d7517["storm_surge"]) && level.var_147d7517["storm_surge"]))
	{
		return 0;
	}
	return 1;
}

/*
	Name: function_d7b3d5fa
	Namespace: namespace_d6e84f96
	Checksum: 0x424F4353
	Offset: 0x6F0
	Size: 0x30
	Parameters: 1
	Flags: None
	Line Number: 117
*/
function function_d7b3d5fa(var_player)
{
	level thread function_5ce3f83a(var_player, 15);
	return;
}

/*
	Name: function_5ce3f83a
	Namespace: namespace_d6e84f96
	Checksum: 0x424F4353
	Offset: 0x728
	Size: 0xD8
	Parameters: 2
	Flags: None
	Line Number: 133
*/
function function_5ce3f83a(var_ent_player, var_time)
{
	var_ent_player endon("hash_disconnect");
	var_ent_player endon("hash_death");
	var_ent_player endon("hash_player_downed");
	if(!isdefined(var_time))
	{
		var_time = 15;
	}
	if(var_ent_player.var_zombie_vars["zombie_powerup_storm_surge_on"])
	{
		if(var_ent_player.var_zombie_vars["zombie_powerup_storm_surge_time"] < var_time)
		{
			var_ent_player.var_zombie_vars["zombie_powerup_storm_surge_time"] = var_time;
			return;
		}
	}
	else
	{
		var_ent_player.var_zombie_vars["zombie_powerup_storm_surge_time"] = var_time;
	}
	level thread function_2733a5c4(var_ent_player);
}

/*
	Name: function_2733a5c4
	Namespace: namespace_d6e84f96
	Checksum: 0x424F4353
	Offset: 0x808
	Size: 0x328
	Parameters: 1
	Flags: None
	Line Number: 167
*/
function function_2733a5c4(var_ent_player)
{
	var_ent_player endon("hash_disconnect");
	var_ent_player endon("hash_death");
	var_ent_player endon("hash_player_downed");
	if(!(isdefined(var_ent_player.var_zombie_vars["zombie_powerup_storm_surge_on"]) && var_ent_player.var_zombie_vars["zombie_powerup_storm_surge_on"]))
	{
		var_ent_player.var_zombie_vars["zombie_powerup_storm_surge_on"] = 1;
	}
	var_ent_player namespace_clientfield::function_set_player_uimodel("powerup_storm_surge", 1);
	var_ent_player.var_15bdb2ec = namespace_util::function_spawn_model("tag_origin", var_ent_player.var_origin + VectorScale((0, 0, 1), 40), var_ent_player.var_angles);
	var_ent_player.var_15bdb2ec = function_PlayFXOnTag(level.var__effect["storm_surge_player"], var_ent_player.var_15bdb2ec, "tag_origin");
	var_ent_player.var_15bdb2ec function_EnableLinkTo();
	var_ent_player.var_15bdb2ec function_LinkTo(var_ent_player);
	var_ent_player thread function_cf4173e4();
	level thread function_202d34d3(var_ent_player, "zombie_powerup_storm_surge_time");
	while(var_ent_player.var_zombie_vars["zombie_powerup_storm_surge_on"])
	{
		var_zombies = namespace_Array::function_get_all_closest(var_ent_player.var_origin, function_GetAITeamArray(level.var_zombie_team), undefined, undefined, 196);
		for(var_i = 0; var_i < var_zombies.size; var_i++)
		{
			if(!isdefined(var_zombies[var_i]) || !function_isalive(var_zombies[var_i]))
			{
				continue;
			}
			if(!var_zombies[var_i] function_cansee(var_ent_player))
			{
				continue;
			}
			var_ent_player thread function_20654ca0(var_zombies[var_i]);
			wait(0.05);
		}
		wait(0.1);
	}
	wait(0.1);
	if(isdefined(var_ent_player.var_15bdb2ec))
	{
		var_ent_player.var_15bdb2ec function_delete();
	}
	var_ent_player notify("hash_81ed11d5");
	var_ent_player namespace_clientfield::function_set_player_uimodel("powerup_storm_surge", 0);
	return;
}

/*
	Name: function_cf4173e4
	Namespace: namespace_d6e84f96
	Checksum: 0x424F4353
	Offset: 0xB38
	Size: 0x68
	Parameters: 0
	Flags: None
	Line Number: 221
*/
function function_cf4173e4()
{
	self endon("hash_81ed11d5");
	self namespace_util::function_waittill_any("fake_death", "death", "player_downed");
	if(isdefined(self.var_15bdb2ec))
	{
		self.var_15bdb2ec function_delete();
		return;
	}
	continue;
}

/*
	Name: function_202d34d3
	Namespace: namespace_d6e84f96
	Checksum: 0x424F4353
	Offset: 0xBA8
	Size: 0xA8
	Parameters: 2
	Flags: None
	Line Number: 243
*/
function function_202d34d3(var_ent_player, var_str_weapon_time)
{
	while(var_ent_player.var_zombie_vars[var_str_weapon_time] > 0)
	{
		wait(0.05);
		var_ent_player.var_zombie_vars[var_str_weapon_time] = var_ent_player.var_zombie_vars[var_str_weapon_time] - 0.05;
	}
	var_ent_player.var_zombie_vars["zombie_powerup_storm_surge_on"] = 0;
	var_ent_player namespace_clientfield::function_set_player_uimodel("powerup_storm_surge", 0);
}

/*
	Name: function_20654ca0
	Namespace: namespace_d6e84f96
	Checksum: 0x424F4353
	Offset: 0xC58
	Size: 0xD0
	Parameters: 1
	Flags: None
	Line Number: 264
*/
function function_20654ca0(var_ai)
{
	self endon("hash_disconnect");
	if(!isdefined(var_ai) || !function_isalive(var_ai))
	{
		return;
	}
	if(!isdefined(self.var_tesla_enemies_hit))
	{
		self.var_tesla_enemies_hit = 1;
	}
	var_ai notify("hash_bhtn_action_notify", "electrocute");
	var_ai.var_tesla_death = 0;
	var_ai thread function_fe8a580e(var_ai.var_origin, var_ai.var_origin, self);
	var_ai thread function_tesla_death(self);
}

/*
	Name: function_fe8a580e
	Namespace: namespace_d6e84f96
	Checksum: 0x424F4353
	Offset: 0xD30
	Size: 0x68
	Parameters: 3
	Flags: None
	Line Number: 291
*/
function function_fe8a580e(var_HIT_LOCATION, var_hit_origin, var_player)
{
	var_player endon("hash_disconnect");
	if(isdefined(self.var_zombie_tesla_hit) && self.var_zombie_tesla_hit)
	{
		return;
	}
	self namespace_lightning_chain::function_arc_damage(self, var_player, 1, level.var_tesla_lightning_params);
}

/*
	Name: function_tesla_death
	Namespace: namespace_d6e84f96
	Checksum: 0x424F4353
	Offset: 0xDA0
	Size: 0xEC
	Parameters: 1
	Flags: None
	Line Number: 311
*/
function function_tesla_death(var_player)
{
	self endon("hash_death");
	wait(1);
	var_player thread namespace_zm_audio::function_create_and_play_dialog("kill", "sword_slam");
	function_PlayFXOnTag(level.var__effect["crossbow_skull_zombie_explode"], self, "j_head");
	if(isdefined(self) && function_IsActor(self))
	{
		namespace_GibServerUtils::function_GibHead(self);
	}
	self function_DoDamage(self.var_health + 666, self.var_origin, var_player, undefined, "none", "MOD_ELECTROCUTED", 0, undefined);
}

