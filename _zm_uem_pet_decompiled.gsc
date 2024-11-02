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
	Name: __init__sytem__
	Namespace: namespace_37404292
	Checksum: 0x424F4353
	Offset: 0x548
	Size: 0x40
	Parameters: 0
	Flags: AutoExec
	Line Number: 38
*/
function autoexec __init__sytem__()
{
	system::register("zm_uem_pet", &__init__, &__main__, undefined);
}

/*
	Name: __init__
	Namespace: namespace_37404292
	Checksum: 0x424F4353
	Offset: 0x590
	Size: 0x40
	Parameters: 0
	Flags: None
	Line Number: 53
*/
function __init__()
{
	callback::on_spawned(&function_25771d90);
	level._effect["uem_hearts"] = "_sphynx/_zm_hearts";
}

/*
	Name: __main__
	Namespace: namespace_37404292
	Checksum: 0x424F4353
	Offset: 0x5D8
	Size: 0x8
	Parameters: 0
	Flags: None
	Line Number: 69
*/
function __main__()
{
}

/*
	Name: function_25771d90
	Namespace: namespace_37404292
	Checksum: 0x424F4353
	Offset: 0x5E8
	Size: 0x118
	Parameters: 0
	Flags: None
	Line Number: 83
*/
function function_25771d90()
{
	self endon("bled_out");
	self endon("spawned_player");
	self endon("disconnect");
	wait(0.05);
	level flag::wait_till("initial_blackscreen_passed");
	while(!isdefined(self.var_fa202141["player_pet"]))
	{
		wait(1);
	}
	if(!isdefined(self.var_d3e2d270))
	{
		self.var_d3e2d270 = [];
	}
	self.var_d3e2d270["active"] = 0;
	for(;;)
	{
		time = 0;
		while(self actionslotonebuttonpressed())
		{
			time = time + 0.05;
			if(time >= 1.5)
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
	Offset: 0x708
	Size: 0x1A8
	Parameters: 0
	Flags: None
	Line Number: 126
*/
function function_3bf33b61()
{
	if(!(isdefined(self.var_d3e2d270["active"]) && self.var_d3e2d270["active"]))
	{
		switch(self.var_fa202141["player_pet"])
		{
			case 1:
			{
				if(self.pers["halloween_pet"] == 1)
				{
					self thread function_e389836c("halloween_plushie", "_zmu_halloween_drop", "Bob", &function_d3d0e213);
					break;
				}
			}
			case 999:
			{
				if(self getxuid(1) == "76561198160068017" || self getxuid(1) == "76561198228573464" || self getxuid(1) == "76561198075603410")
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
	Offset: 0x8B8
	Size: 0x2D8
	Parameters: 4
	Flags: None
	Line Number: 166
*/
function function_e389836c(pet, model, name, var_537a7aff)
{
	self.var_d3e2d270["active"] = 1;
	wait(0.05);
	self thread [[var_537a7aff]]();
	self thread function_d6c30699();
	direction = self getplayerangles();
	forward_dir = anglestoforward(direction);
	self.var_d3e2d270["pet"] = util::spawn_model(model, self.origin + forward_dir * 60 + VectorScale((0, 0, 1), 45), direction);
	self.var_d3e2d270["pet"].pet = pet;
	self.var_d3e2d270["pet"].model = model;
	self.var_d3e2d270["pet"].name = name;
	iprintln("^8[Pet Func] ^7" + name + " has spawned");
	self.var_d3e2d270["pet"] thread function_b082109();
	self.var_d3e2d270["pet"] thread function_d914b3b2(self);
	self.var_d3e2d270["pet"] thread function_d137df4b(self);
	self.var_d3e2d270["pet"] thread function_38fc5ec9();
	self.var_d3e2d270["pet"] waittill("hash_43657fe3");
	iprintln("^8[Pet Func] ^7" + name + " went away :(");
	self.var_d3e2d270["active"] = 0;
	self.var_d3e2d270["pet"].trigger_use delete();
	self.var_d3e2d270["pet"] delete();
}

/*
	Name: function_d6c30699
	Namespace: namespace_37404292
	Checksum: 0x424F4353
	Offset: 0xB98
	Size: 0x68
	Parameters: 0
	Flags: None
	Line Number: 200
*/
function function_d6c30699()
{
	self util::waittill_any_return("fake_death", "death", "player_downed");
	if(isdefined(self.var_d3e2d270["pet"]))
	{
		self.var_d3e2d270["pet"] notify("hash_43657fe3");
	}
}

/*
	Name: function_d914b3b2
	Namespace: namespace_37404292
	Checksum: 0x424F4353
	Offset: 0xC08
	Size: 0xE0
	Parameters: 1
	Flags: None
	Line Number: 219
*/
function function_d914b3b2(player)
{
	self endon("hash_43657fe3");
	for(;;)
	{
		wait(0.15);
		v_to_enemy = (player.origin - self.origin[0], player.origin - self.origin[1], 0);
		v_to_enemy = vectornormalize(v_to_enemy);
		goalAngles = vectortoangles(v_to_enemy);
		self rotateto(goalAngles - VectorScale((0, 1, 0), 270), 0.2);
	}
}

/*
	Name: function_d137df4b
	Namespace: namespace_37404292
	Checksum: 0x424F4353
	Offset: 0xCF0
	Size: 0x228
	Parameters: 1
	Flags: None
	Line Number: 242
*/
function function_d137df4b(player)
{
	self endon("hash_43657fe3");
	var_a35e9a3c = 70;
	var_e41830d0 = 70;
	var_930d0c56 = 0.15;
	height_offset = 50;
	while(player.var_d3e2d270["active"])
	{
		self.var_97f038af = 0;
		current_position = player.origin;
		var_f9bdc8ce = distance(current_position, self.origin);
		if(var_f9bdc8ce > var_a35e9a3c)
		{
			direction = player getplayerangles();
			var_dfd0f682 = anglestoforward(direction + VectorScale((0, 1, 0), 180));
			var_5cdf442f = current_position + var_dfd0f682 * var_e41830d0 + (0, 0, height_offset);
			if(var_5cdf442f[2] < current_position[2] + height_offset)
			{
				var_5cdf442f[2] = current_position[2] + height_offset;
			}
			player_speed = distance(current_position, self.origin) / var_930d0c56;
			var_96bdb8c4 = 2.5 / 1 + player_speed / 500;
			self moveto(var_5cdf442f, var_96bdb8c4);
			self.var_97f038af = 1;
		}
		wait(var_930d0c56);
	}
}

/*
	Name: function_b082109
	Namespace: namespace_37404292
	Checksum: 0x424F4353
	Offset: 0xF20
	Size: 0x288
	Parameters: 0
	Flags: None
	Line Number: 282
*/
function function_b082109()
{
	self.trigger_use = spawn("trigger_radius_use", self.origin, 0, 35, 35);
	self.trigger_use triggerignoreteam();
	self.trigger_use setvisibletoall();
	self.trigger_use setteamfortrigger("none");
	self.trigger_use usetriggerrequirelookat();
	self.trigger_use setcursorhint("HINT_NOICON");
	self.trigger_use sethintstring(&"ZM_MINECRAFT_PLUSHIE_PET", self.name);
	self.trigger_use EnableLinkTo();
	self.trigger_use linkto(self);
	while(isdefined(self.trigger_use))
	{
		self.trigger_use waittill("trigger", player);
		playsoundatposition("plushie_pet", self.origin);
		self.var_19517463 = util::spawn_model("tag_origin", self.origin + VectorScale((0, 0, 1), 8), self.angles);
		self.var_19517463 = playfxontag(level._effect["uem_hearts"], self.var_19517463, "tag_origin");
		self.var_19517463 EnableLinkTo();
		self.var_19517463 linkto(self);
		iprintln("^8[Pet Func] ^7You pet your Plushie " + self.name + " | He loves him some scratches!");
		wait(3);
		self.var_19517463 delete();
	}
	if(isdefined(self.var_19517463))
	{
		self.var_19517463 delete();
	}
}

/*
	Name: function_38fc5ec9
	Namespace: namespace_37404292
	Checksum: 0x424F4353
	Offset: 0x11B0
	Size: 0x118
	Parameters: 5
	Flags: None
	Line Number: 321
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
			self Bobbing((0, 0, 1), var_466503ff, randomintrange(var_278b47c3, var_aa7689cd));
		}
		while(!(isdefined(self.var_97f038af) && self.var_97f038af))
		{
			wait(0.5);
		}
		wait(0.5);
	}
}

/*
	Name: function_d3d0e213
	Namespace: namespace_37404292
	Checksum: 0x424F4353
	Offset: 0x12D0
	Size: 0x48
	Parameters: 0
	Flags: None
	Line Number: 367
*/
function function_d3d0e213()
{
	self endon("bled_out");
	self endon("spawned_player");
	self endon("disconnect");
	self thread function_854862c8(1, 20);
}

/*
	Name: function_d0312279
	Namespace: namespace_37404292
	Checksum: 0x424F4353
	Offset: 0x1320
	Size: 0x68
	Parameters: 0
	Flags: None
	Line Number: 385
*/
function function_d0312279()
{
	self endon("bled_out");
	self endon("spawned_player");
	self endon("disconnect");
	self thread function_854862c8(1, 50);
	self thread function_a8caa41(5, 1);
}

/*
	Name: function_a8caa41
	Namespace: namespace_37404292
	Checksum: 0x424F4353
	Offset: 0x1390
	Size: 0xE0
	Parameters: 2
	Flags: None
	Line Number: 404
*/
function function_a8caa41(chance, points)
{
	self endon("bled_out");
	self endon("spawned_player");
	self endon("disconnect");
	while(self.var_d3e2d270["active"])
	{
		self waittill("weapon_fired", w_weapon, point);
		if(randomintrange(0, 100) < chance)
		{
			var_b7c5b19 = self getweaponammoclip(w_weapon);
			self setweaponammoclip(w_weapon, var_b7c5b19 + points);
		}
	}
}

/*
	Name: function_854862c8
	Namespace: namespace_37404292
	Checksum: 0x424F4353
	Offset: 0x1478
	Size: 0xC0
	Parameters: 2
	Flags: None
	Line Number: 430
*/
function function_854862c8(chance, points)
{
	self endon("bled_out");
	self endon("spawned_player");
	self endon("disconnect");
	while(self.var_d3e2d270["active"])
	{
		level waittill("earned_points", e_player, var_c9edfaa8);
		if(randomintrange(0, 100) < chance)
		{
			e_player zm_score::add_to_player_score(int(points));
		}
	}
}

