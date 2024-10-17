#include scripts\codescripts\struct;
#include scripts\shared\ai\zombie_utility;
#include scripts\shared\array_shared;
#include scripts\shared\callbacks_shared;
#include scripts\shared\clientfield_shared;
#include scripts\shared\system_shared;
#include scripts\shared\util_shared;
#include scripts\shared\visionset_mgr_shared;
#include scripts\zm\_util;
#include scripts\zm\_zm;
#include scripts\zm\_zm_perk_random;
#include scripts\zm\_zm_perks;
#include scripts\zm\_zm_pers_upgrades;
#include scripts\zm\_zm_pers_upgrades_functions;
#include scripts\zm\_zm_pers_upgrades_system;
#include scripts\zm\_zm_stats;
#include scripts\zm\_zm_utility;
#include scripts\zm\gametypes\_globallogic_score;

#namespace namespace_6beed036;

/*
	Name: __init__sytem__
	Namespace: namespace_6beed036
	Checksum: 0x424F4353
	Offset: 0x498
	Size: 0x38
	Parameters: 0
	Flags: AutoExec
	Line Number: 31
*/
function autoexec __init__sytem__()
{
	system::register("zm_perk_phdflopper_uem", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: namespace_6beed036
	Checksum: 0x424F4353
	Offset: 0x4D8
	Size: 0x38
	Parameters: 0
	Flags: None
	Line Number: 46
*/
function __init__()
{
	function_555fd93f();
	callback::on_spawned(&function_ea8141d2);
}

/*
	Name: function_555fd93f
	Namespace: namespace_6beed036
	Checksum: 0x424F4353
	Offset: 0x518
	Size: 0x140
	Parameters: 0
	Flags: Private
	Line Number: 62
*/
function private function_555fd93f()
{
	zm_perks::register_perk_basic_info("specialty_phdflopper", "phd", 2500, &"ZM_MINECRAFT_PERK_PHDFLOPPER", getweapon("zombie_perk_bottle_phd"));
	zm_perks::register_perk_precache_func("specialty_phdflopper", &function_f7f52842);
	zm_perks::register_perk_clientfields("specialty_phdflopper", &function_8818abe0, &function_d1668e59);
	zm_perks::register_perk_machine("specialty_phdflopper", &function_e9598115);
	zm_perks::register_perk_host_migration_params("specialty_phdflopper", "vending_phd", "vending_phd_light");
	zm_perks::register_perk_threads("specialty_phdflopper", &function_67e89377, &function_94a6ffae);
	function_476330a8();
}

/*
	Name: function_f7f52842
	Namespace: namespace_6beed036
	Checksum: 0x424F4353
	Offset: 0x660
	Size: 0xE0
	Parameters: 0
	Flags: Private
	Line Number: 83
*/
function private function_f7f52842()
{
	if(isdefined(level.var_fb2fb2b6))
	{
		[[level.var_fb2fb2b6]]();
		return;
	}
	level._effect["vending_phd_light"] = "_mikeyray/perks/phd/fx_perk_phd";
	level.machine_assets["specialty_phdflopper"] = spawnstruct();
	level.machine_assets["specialty_phdflopper"].weapon = getweapon("zombie_perk_bottle_phd");
	level.machine_assets["specialty_phdflopper"].off_model = "p7_zm_vending_phd";
	level.machine_assets["specialty_phdflopper"].on_model = "p7_zm_vending_phd_active";
}

/*
	Name: function_8818abe0
	Namespace: namespace_6beed036
	Checksum: 0x424F4353
	Offset: 0x748
	Size: 0x38
	Parameters: 0
	Flags: Private
	Line Number: 107
*/
function private function_8818abe0()
{
	clientfield::register("clientuimodel", "hudItems.perks.phdflopper", 1, 2, "int");
}

/*
	Name: function_d1668e59
	Namespace: namespace_6beed036
	Checksum: 0x424F4353
	Offset: 0x788
	Size: 0x30
	Parameters: 1
	Flags: Private
	Line Number: 122
*/
function private function_d1668e59(state)
{
	self clientfield::set_player_uimodel("hudItems.perks.phdflopper", state);
}

/*
	Name: function_e9598115
	Namespace: namespace_6beed036
	Checksum: 0x424F4353
	Offset: 0x7C0
	Size: 0xC0
	Parameters: 4
	Flags: Private
	Line Number: 137
*/
function private function_e9598115(use_trigger, perk_machine, bump_trigger, collision)
{
	use_trigger.script_sound = "mus_perks_phdflopper_jingle";
	use_trigger.script_string = "phdflopper_perk";
	use_trigger.script_label = "mus_perks_phdflopper_sting";
	use_trigger.target = "vending_phd";
	perk_machine.script_string = "phdflopper_perk";
	perk_machine.targetname = "vending_phd";
	if(isdefined(bump_trigger))
	{
		bump_trigger.script_string = "phdflopper_perk";
		return;
	}
}

/*
	Name: function_476330a8
	Namespace: namespace_6beed036
	Checksum: 0x424F4353
	Offset: 0x888
	Size: 0xC8
	Parameters: 0
	Flags: None
	Line Number: 162
*/
function function_476330a8()
{
	level._effect["phdflopper_explode"] = "explosions/fx_exp_grenade_default";
	if(isdefined(1) && 1)
	{
		zm::register_player_damage_callback(&function_d2f3568f);
	}
	if(isdefined(0) && 0)
	{
		zm::register_actor_damage_callback(&function_463b4d36);
		zm::register_vehicle_damage_callback(&function_ad0ee016);
	}
	wait(0.05);
	zm_perk_random::include_perk_in_random_rotation("specialty_phdflopper");
}

/*
	Name: function_d2f3568f
	Namespace: namespace_6beed036
	Checksum: 0x424F4353
	Offset: 0x958
	Size: 0xE8
	Parameters: 12
	Flags: Private
	Line Number: 188
*/
function private function_d2f3568f(inflictor, attacker, damage, flags, mod, weapon, vpoint, vdir, shitloc, psoffsettime, boneindex, surfacetype)
{
	if(isplayer(self) && self hasperk("specialty_phdflopper") && (zm_utility::is_explosive_damage(mod) || mod == "MOD_FALLING"))
	{
		return 0;
	}
	if(mod == "MOD_EXPLOSIVE")
	{
		return 0;
	}
	return -1;
}

/*
	Name: function_463b4d36
	Namespace: namespace_6beed036
	Checksum: 0x424F4353
	Offset: 0xA48
	Size: 0xD0
	Parameters: 12
	Flags: Private
	Line Number: 211
*/
function private function_463b4d36(inflictor, attacker, damage, flags, mod, weapon, vpoint, vdir, shitloc, psoffsettime, boneindex, surfacetype)
{
	if(isplayer(attacker) && attacker hasperk("specialty_phdflopper") && zm_utility::is_explosive_damage(mod))
	{
		return damage * 1.75;
	}
	return -1;
}

/*
	Name: function_ad0ee016
	Namespace: namespace_6beed036
	Checksum: 0x424F4353
	Offset: 0xB20
	Size: 0xE0
	Parameters: 15
	Flags: Private
	Line Number: 230
*/
function private function_ad0ee016(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, psoffsettime, damagefromunderneath, modelindex, partname, vsurfacenormal)
{
	if(isplayer(eattacker) && eattacker hasperk("specialty_phdflopper") && zm_utility::is_explosive_damage(smeansofdeath))
	{
		return idamage * 1.75;
	}
	return 0;
}

/*
	Name: function_67e89377
	Namespace: namespace_6beed036
	Checksum: 0x424F4353
	Offset: 0xC08
	Size: 0x78
	Parameters: 0
	Flags: None
	Line Number: 249
*/
function function_67e89377()
{
	self endon("death");
	self endon("disconnect");
	self endon("specialty_phdflopper" + "_stop");
	if(isdefined(0) && 0)
	{
		self thread function_b7b929aa();
	}
	if(isdefined(0) && 0)
	{
		self thread function_ad30eb10();
	}
}

/*
	Name: function_b7b929aa
	Namespace: namespace_6beed036
	Checksum: 0x424F4353
	Offset: 0xC88
	Size: 0x120
	Parameters: 0
	Flags: None
	Line Number: 274
*/
function function_b7b929aa()
{
	self endon("death");
	self endon("disconnect");
	self endon("specialty_phdflopper" + "_stop");
	for(;;)
	{
		self util::waittill_any_return("jump_begin", "slide_begin");
		startpos = self.origin[2];
		while(self IsSliding())
		{
			wait(0.1);
		}
		while(!self isonground())
		{
			wait(0.1);
		}
		endpos = self.origin[2];
		heightDiff = startpos - endpos;
		if(heightDiff > 48)
		{
			self function_eda743ac();
			wait(3);
		}
	}
}

/*
	Name: function_ad30eb10
	Namespace: namespace_6beed036
	Checksum: 0x424F4353
	Offset: 0xDB0
	Size: 0xA8
	Parameters: 0
	Flags: None
	Line Number: 311
*/
function function_ad30eb10()
{
	self endon("death");
	self endon("disconnect");
	self endon("specialty_phdflopper" + "_stop");
	while(self IsSliding())
	{
		self thread function_eda743ac();
		self.var_7607af34 = 1;
		wait(0.2);
		continue;
		if(isdefined(self.var_7607af34) && self.var_7607af34)
		{
			wait(5);
			self.var_7607af34 = 0;
		}
		wait(0.05);
	}
}

/*
	Name: function_eda743ac
	Namespace: namespace_6beed036
	Checksum: 0x424F4353
	Offset: 0xE60
	Size: 0x138
	Parameters: 0
	Flags: None
	Line Number: 341
*/
function function_eda743ac()
{
	fxModel = util::spawn_model("tag_origin", self.origin);
	fx = playfxontag(level._effect["phdflopper_explode"], fxModel, "tag_origin");
	fxModel playsound("wpn_grenade_explode");
	if(isdefined(1) && 1)
	{
		earthquake(0.42, 1, self.origin, 300);
	}
	radiusdamage(self.origin, 300, 5000, 1000, self, "MOD_EXPLOSIVE");
	wait(2);
	fxModel delete();
	if(isdefined(fx))
	{
		fx delete();
		return;
	}
	ERROR: Exception occured: Stack empty.
	waittillframeend;
}

/*
	Name: function_94a6ffae
	Namespace: namespace_6beed036
	Checksum: 0x424F4353
	Offset: 0xFA0
	Size: 0x38
	Parameters: 3
	Flags: None
	Line Number: 372
*/
function function_94a6ffae(b_pause, str_perk, str_result)
{
	self notify("specialty_phdflopper" + "_stop");
}

/*
	Name: function_ea8141d2
	Namespace: namespace_6beed036
	Checksum: 0x424F4353
	Offset: 0xFE0
	Size: 0x2C
	Parameters: 0
	Flags: None
	Line Number: 387
*/
function function_ea8141d2()
{
	self globallogic_score::initPersStat("specialty_phdflopper" + "_drank", 0);
}

