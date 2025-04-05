#include scripts\codescripts\struct;
#include scripts\shared\aat_shared;
#include scripts\shared\ai\zombie_utility;
#include scripts\shared\array_shared;
#include scripts\shared\callbacks_shared;
#include scripts\shared\clientfield_shared;
#include scripts\shared\compass;
#include scripts\shared\flag_shared;
#include scripts\shared\gameobjects_shared;
#include scripts\shared\laststand_shared;
#include scripts\shared\scene_shared;
#include scripts\shared\spawner_shared;
#include scripts\shared\system_shared;
#include scripts\shared\util_shared;
#include scripts\zm\_zm;
#include scripts\zm\_zm_audio;
#include scripts\zm\_zm_bgb;
#include scripts\zm\_zm_equipment;
#include scripts\zm\_zm_hero_weapon;
#include scripts\zm\_zm_magicbox;
#include scripts\zm\_zm_score;
#include scripts\zm\_zm_spawner;
#include scripts\zm\_zm_unitrigger;
#include scripts\zm\_zm_utility;
#include scripts\zm\_zm_weapons;

#namespace namespace_37404292;

/*
	Name: function___init__sytem__
	Namespace: namespace_37404292
	Checksum: 0x424F4353
	Offset: 0x6B0
	Size: 0x40
	Parameters: 0
	Flags: AutoExec
	Line Number: 38
*/
function autoexec function___init__sytem__()
{
	namespace_system::function_register("zm_uem_pet", &function___init__, &function___main__, undefined);
	return;
	ERROR: Exception occured: Stack empty.
}

/*
	Name: function___init__
	Namespace: namespace_37404292
	Checksum: 0x424F4353
	Offset: 0x6F8
	Size: 0x40
	Parameters: 0
	Flags: None
	Line Number: 55
*/
function function___init__()
{
	namespace_callback::function_on_spawned(&function_25771d90);
	level.var__effect["uem_hearts"] = "_sphynx/_zm_hearts";
	return;
	ERROR: Exception occured: Stack empty.
}

/*
	Name: function___main__
	Namespace: namespace_37404292
	Checksum: 0x424F4353
	Offset: 0x740
	Size: 0x8
	Parameters: 0
	Flags: None
	Line Number: 73
*/
function function___main__()
{
}

/*
	Name: function_25771d90
	Namespace: namespace_37404292
	Checksum: 0x424F4353
	Offset: 0x750
	Size: 0x130
	Parameters: 0
	Flags: None
	Line Number: 87
*/
function function_25771d90()
{
	self endon("hash_bled_out");
	self endon("hash_spawned_player");
	self endon("hash_disconnect");
	wait(0.05);
	level namespace_flag::function_wait_till("initial_blackscreen_passed");
	while(!isdefined(self.var_fa202141["player_pet"]))
	{
		wait(1);
	}
	if(!isdefined(self.var_d3e2d270))
	{
		self.var_d3e2d270 = [];
	}
	self.var_d3e2d270["active"] = 0;
	self thread function_3bf33b61();
	for(;;)
	{
		var_time = 0;
		while(self function_ActionSlotThreeButtonPressed())
		{
			var_time = var_time + 0.05;
			if(var_time >= 1.5)
			{
				self thread function_3bf33b61();
				break;
			}
			wait(0.05);
		}
		wait(0.05);
	}
}

/*
	Name: function_3bf33b61
	Namespace: namespace_37404292
	Checksum: 0x424F4353
	Offset: 0x888
	Size: 0x6B8
	Parameters: 0
	Flags: None
	Line Number: 131
*/
function function_3bf33b61()
{
	if(!(isdefined(self.var_d3e2d270["active"]) && self.var_d3e2d270["active"]))
	{
		switch(self.var_fa202141["player_pet"])
		{
			case 1:
			{
				if(self.var_pers["halloween_pet"] == 1)
				{
					self thread function_e389836c("halloween_plushie", "_zmu_halloween_drop_plushie", "Bob", &function_d3d0e213);
					break;
				}
			}
			case 2:
			{
				if(self.var_pers["motd_plushie"] == 1)
				{
					self thread function_e389836c("motd_plushie", "_zmu_plushie_alcatraz_plane", "Alcatraz Plane", &function_ab5c8c3f);
					break;
				}
			}
			case 3:
			{
				if(self.var_pers["christmas_pet"] == 1)
				{
					self thread function_e389836c("christmas_pet", "_zmu_plushie_snowman", "Little XMass Murder", &function_ebacb725);
					break;
				}
			}
			case 4:
			{
				if(self.var_pers["mc_plushie_1"] == 1)
				{
					self thread function_e389836c("mc_plushie_1", "_zmu_plushie_bee", "Minecraft Bee", &function_5664ef);
					break;
				}
			}
			case 100:
			{
				if(isdefined(level.var_18ffd3f2[self function_getxuid(1)]) && (level.var_18ffd3f2[self function_getxuid(1)].var_rank == "gold" || level.var_18ffd3f2[self function_getxuid(1)].var_rank == "master" || level.var_18ffd3f2[self function_getxuid(1)].var_rank == "paragon" || level.var_18ffd3f2[self function_getxuid(1)].var_rank == "ultimate"))
				{
					self thread function_e389836c("vip_gold_plushie", "_zmu_plushie_ufo_gold_vip", "Gold UFO", &function_12f3bcdd);
					break;
				}
			}
			case 101:
			{
				if(isdefined(level.var_18ffd3f2[self function_getxuid(1)]) && (level.var_18ffd3f2[self function_getxuid(1)].var_rank == "master" || level.var_18ffd3f2[self function_getxuid(1)].var_rank == "paragon" || level.var_18ffd3f2[self function_getxuid(1)].var_rank == "ultimate"))
				{
					self thread function_e389836c("vip_gold_plushie", "_zmu_plushie_ufo_master_vip", "Master UFO", &function_12f3bcdd);
					break;
				}
			}
			case 102:
			{
				if(isdefined(level.var_18ffd3f2[self function_getxuid(1)]) && (level.var_18ffd3f2[self function_getxuid(1)].var_rank == "paragon" || level.var_18ffd3f2[self function_getxuid(1)].var_rank == "ultimate"))
				{
					self thread function_e389836c("vip_gold_plushie", "_zmu_plushie_ufo_paragon_vip", "Paragon UFO", &function_12f3bcdd);
					break;
				}
			}
			case 103:
			{
				if(isdefined(level.var_18ffd3f2[self function_getxuid(1)]) && level.var_18ffd3f2[self function_getxuid(1)].var_rank == "ultimate")
				{
					self thread function_e389836c("vip_gold_plushie", "_zmu_plushie_ufo_ultimate_vip", "Ultimate UFO", &function_12f3bcdd);
					break;
				}
			}
			case 999:
			{
				if(self function_getxuid(1) == "76561198160068017" || self function_getxuid(1) == "76561198228573464" || self function_getxuid(1) == "76561198075603410")
				{
					self thread function_e389836c("dev_plushie", "_zmu_plushie_blahaj", "Blahaj", &function_d0312279);
					break;
				}
			}
		}
	}
	else if(isdefined(self.var_d3e2d270["pet"]))
	{
		self.var_d3e2d270["pet"] notify("hash_43657fe3");
	}
}

/*
	Name: function_e389836c
	Namespace: namespace_37404292
	Checksum: 0x424F4353
	Offset: 0xF48
	Size: 0x2D8
	Parameters: 4
	Flags: None
	Line Number: 227
*/
function function_e389836c(var_pet, var_model, var_name, var_537a7aff)
{
	self.var_d3e2d270["active"] = 1;
	wait(0.05);
	self thread [[var_537a7aff]]();
	self thread function_d6c30699();
	var_direction = self function_getPlayerAngles();
	var_forward_dir = function_AnglesToForward(var_direction);
	self.var_d3e2d270["pet"] = namespace_util::function_spawn_model(var_model, self.var_origin + var_forward_dir * 60 + VectorScale((0, 0, 1), 45), var_direction);
	self.var_d3e2d270["pet"].var_pet = var_pet;
	self.var_d3e2d270["pet"].var_model = var_model;
	self.var_d3e2d270["pet"].var_name = var_name;
	function_iprintln("^8[Pet Func] ^7" + var_name + " has spawned");
	self.var_d3e2d270["pet"] thread function_b082109();
	self.var_d3e2d270["pet"] thread function_d914b3b2(self);
	self.var_d3e2d270["pet"] thread function_d137df4b(self);
	self.var_d3e2d270["pet"] thread function_38fc5ec9();
	self.var_d3e2d270["pet"] waittill("hash_43657fe3");
	function_iprintln("^8[Pet Func] ^7" + var_name + " went away :(");
	self.var_d3e2d270["active"] = 0;
	self.var_d3e2d270["pet"].var_trigger_use function_delete();
	self.var_d3e2d270["pet"] function_delete();
	return;
	self.var_d3e2d270["active"]++;
}

/*
	Name: function_d6c30699
	Namespace: namespace_37404292
	Checksum: 0x424F4353
	Offset: 0x1228
	Size: 0x68
	Parameters: 0
	Flags: None
	Line Number: 263
*/
function function_d6c30699()
{
	self namespace_util::function_waittill_any_return("fake_death", "death", "bled_out");
	if(isdefined(self.var_d3e2d270["pet"]))
	{
		self.var_d3e2d270["pet"] notify("hash_43657fe3");
	}
}

/*
	Name: function_d914b3b2
	Namespace: namespace_37404292
	Checksum: 0x424F4353
	Offset: 0x1298
	Size: 0xE0
	Parameters: 1
	Flags: None
	Line Number: 282
*/
function function_d914b3b2(var_player)
{
	self endon("hash_43657fe3");
	for(;;)
	{
		wait(0.15);
		var_v_to_enemy = (var_player.var_origin - self.var_origin[0], var_player.var_origin - self.var_origin[1], 0);
		var_v_to_enemy = function_VectorNormalize(var_v_to_enemy);
		var_goalAngles = function_VectorToAngles(var_v_to_enemy);
		self function_RotateTo(var_goalAngles - VectorScale((0, 1, 0), 270), 0.2);
	}
}

/*
	Name: function_d137df4b
	Namespace: namespace_37404292
	Checksum: 0x424F4353
	Offset: 0x1380
	Size: 0x228
	Parameters: 1
	Flags: None
	Line Number: 305
*/
function function_d137df4b(var_player)
{
	self endon("hash_43657fe3");
	var_a35e9a3c = 70;
	var_e41830d0 = 70;
	var_930d0c56 = 0.15;
	var_height_offset = 43;
	while(var_player.var_d3e2d270["active"])
	{
		self.var_97f038af = 0;
		var_current_position = var_player.var_origin;
		var_f9bdc8ce = function_Distance(var_current_position, self.var_origin);
		if(var_f9bdc8ce > var_a35e9a3c)
		{
			var_direction = var_player function_getPlayerAngles();
			var_dfd0f682 = function_AnglesToForward(var_direction + VectorScale((0, 1, 0), 180));
			var_5cdf442f = var_current_position + var_dfd0f682 * var_e41830d0 + (0, 0, var_height_offset);
			if(var_5cdf442f[2] < var_current_position[2] + var_height_offset)
			{
				var_5cdf442f[2] = var_current_position[2] + var_height_offset;
			}
			var_player_speed = function_Distance(var_current_position, self.var_origin) / var_930d0c56;
			var_96bdb8c4 = 2.5 / 1 + var_player_speed / 500;
			self function_moveto(var_5cdf442f, var_96bdb8c4);
			self.var_97f038af = 1;
		}
		wait(var_930d0c56);
	}
}

/*
	Name: function_b082109
	Namespace: namespace_37404292
	Checksum: 0x424F4353
	Offset: 0x15B0
	Size: 0x288
	Parameters: 0
	Flags: None
	Line Number: 345
*/
function function_b082109()
{
	self.var_trigger_use = function_spawn("trigger_radius_use", self.var_origin, 0, 35, 35);
	self.var_trigger_use function_TriggerIgnoreTeam();
	self.var_trigger_use function_SetVisibleToAll();
	self.var_trigger_use function_SetTeamForTrigger("none");
	self.var_trigger_use function_UseTriggerRequireLookAt();
	self.var_trigger_use function_setcursorhint("HINT_NOICON");
	self.var_trigger_use function_setHintString(&"ZM_MINECRAFT_PLUSHIE_PET", self.var_name);
	self.var_trigger_use function_EnableLinkTo();
	self.var_trigger_use function_LinkTo(self);
	while(isdefined(self.var_trigger_use))
	{
		self.var_trigger_use waittill("hash_trigger", var_player);
		function_playsoundatposition("plushie_pet", self.var_origin);
		self.var_19517463 = namespace_util::function_spawn_model("tag_origin", self.var_origin + VectorScale((0, 0, 1), 8), self.var_angles);
		self.var_19517463 = function_PlayFXOnTag(level.var__effect["uem_hearts"], self.var_19517463, "tag_origin");
		self.var_19517463 function_EnableLinkTo();
		self.var_19517463 function_LinkTo(self);
		function_iprintln("^8[Pet Func] ^7You pet your Plushie " + self.var_name + " | He loves him some scratches!");
		wait(3);
		self.var_19517463 function_delete();
	}
	if(isdefined(self.var_19517463))
	{
		self.var_19517463 function_delete();
	}
}

/*
	Name: function_38fc5ec9
	Namespace: namespace_37404292
	Checksum: 0x424F4353
	Offset: 0x1840
	Size: 0x118
	Parameters: 5
	Flags: None
	Line Number: 384
*/
function function_38fc5ec9(var_466503ff, var_278b47c3, var_aa7689cd, var_df20f103, var_620c330d)
{
	if(!isdefined(var_466503ff))
	{
		var_466503ff = 3.5;
	}
	if(!isdefined(var_278b47c3))
	{
		var_278b47c3 = 6;
	}
	if(!isdefined(var_aa7689cd))
	{
		var_aa7689cd = 9;
	}
	if(!isdefined(var_df20f103))
	{
		var_df20f103 = 6;
	}
	if(!isdefined(var_620c330d))
	{
		var_620c330d = 7;
	}
	while(isdefined(self))
	{
		if(!(isdefined(self.var_97f038af) && self.var_97f038af))
		{
			self function_Bobbing((0, 0, 1), var_466503ff, function_randomIntRange(var_278b47c3, var_aa7689cd));
		}
		while(!(isdefined(self.var_97f038af) && self.var_97f038af))
		{
			wait(0.5);
		}
		wait(0.5);
	}
	return;
	ERROR: Exception occured: Stack empty.
}

/*
	Name: function_d3d0e213
	Namespace: namespace_37404292
	Checksum: 0x424F4353
	Offset: 0x1960
	Size: 0x48
	Parameters: 0
	Flags: None
	Line Number: 432
*/
function function_d3d0e213()
{
	self endon("hash_bled_out");
	self endon("hash_spawned_player");
	self endon("hash_disconnect");
	self thread function_854862c8(1, 20);
	return;
}

/*
	Name: function_d0312279
	Namespace: namespace_37404292
	Checksum: 0x424F4353
	Offset: 0x19B0
	Size: 0x68
	Parameters: 0
	Flags: None
	Line Number: 451
*/
function function_d0312279()
{
	self endon("hash_bled_out");
	self endon("hash_spawned_player");
	self endon("hash_disconnect");
	self thread function_854862c8(1, 50);
	self thread function_a8caa41(5, 1);
}

/*
	Name: function_a8caa41
	Namespace: namespace_37404292
	Checksum: 0x424F4353
	Offset: 0x1A20
	Size: 0xE0
	Parameters: 2
	Flags: None
	Line Number: 470
*/
function function_a8caa41(var_chance, var_points)
{
	self endon("hash_bled_out");
	self endon("hash_spawned_player");
	self endon("hash_disconnect");
	while(self.var_d3e2d270["active"])
	{
		self waittill("hash_weapon_fired", var_w_weapon, var_point);
		if(function_randomIntRange(0, 100) < var_chance)
		{
			var_b7c5b19 = self function_GetWeaponAmmoClip(var_w_weapon);
			self function_SetWeaponAmmoClip(var_w_weapon, var_b7c5b19 + var_points);
		}
	}
}

/*
	Name: function_854862c8
	Namespace: namespace_37404292
	Checksum: 0x424F4353
	Offset: 0x1B08
	Size: 0xC0
	Parameters: 2
	Flags: None
	Line Number: 496
*/
function function_854862c8(var_chance, var_points)
{
	self endon("hash_bled_out");
	self endon("hash_spawned_player");
	self endon("hash_disconnect");
	while(self.var_d3e2d270["active"])
	{
		level waittill("hash_earned_points", var_e_player, var_c9edfaa8);
		if(function_randomIntRange(0, 100) < var_chance)
		{
			var_e_player namespace_zm_score::function_add_to_player_score(function_Int(var_points));
		}
	}
}

/*
	Name: function_ab5c8c3f
	Namespace: namespace_37404292
	Checksum: 0x424F4353
	Offset: 0x1BD0
	Size: 0x28
	Parameters: 0
	Flags: None
	Line Number: 521
*/
function function_ab5c8c3f()
{
	self endon("hash_bled_out");
	self endon("hash_spawned_player");
	self endon("hash_disconnect");
	return;
	ERROR: Exception occured: Stack empty.
}

/*
	Name: function_5664ef
	Namespace: namespace_37404292
	Checksum: 0x424F4353
	Offset: 0x1C00
	Size: 0x28
	Parameters: 0
	Flags: None
	Line Number: 540
*/
function function_5664ef()
{
	self endon("hash_bled_out");
	self endon("hash_spawned_player");
	self endon("hash_disconnect");
	return;
	ERROR: Exception occured: Stack empty.
}

/*
	Name: function_ebacb725
	Namespace: namespace_37404292
	Checksum: 0x424F4353
	Offset: 0x1C30
	Size: 0x28
	Parameters: 0
	Flags: None
	Line Number: 559
*/
function function_ebacb725()
{
	self endon("hash_bled_out");
	self endon("hash_spawned_player");
	self endon("hash_disconnect");
}

/*
	Name: function_12f3bcdd
	Namespace: namespace_37404292
	Checksum: 0x424F4353
	Offset: 0x1C60
	Size: 0x26
	Parameters: 0
	Flags: None
	Line Number: 576
*/
function function_12f3bcdd()
{
	self endon("hash_bled_out");
	self endon("hash_spawned_player");
	self endon("hash_disconnect");
}

