#include scripts\shared\callbacks_shared;
#include scripts\shared\util_shared;
#include scripts\zm\_zm_spawner;
#include scripts\zm\_zm_utility;
#include scripts\zm\_zm_weapons;

#namespace namespace_74571cc1;

/*
	Name: init
	Namespace: namespace_74571cc1
	Checksum: 0x424F4353
	Offset: 0x188
	Size: 0x8
	Parameters: 0
	Flags: AutoExec
	Line Number: 18
*/
function autoexec init()
{
}

/*
	Name: function_9c301f1a
	Namespace: namespace_74571cc1
	Checksum: 0x424F4353
	Offset: 0x198
	Size: 0x100
	Parameters: 13
	Flags: None
	Line Number: 32
*/
function function_9c301f1a(mod, hit_location, hit_origin, player, amount, weapon, direction_vec, tagname, modelname, partname, dflags, inflictor, chargelevel)
{
	w_damage = zm_weapons::get_nonalternate_weapon(weapon);
	weaponClass = util::getWeaponClass(w_damage);
	if(hit_location == "helmet" && weaponClass == "weapon_sniper")
	{
		player playlocalsound("mp_hit_indication_3d");
	}
	player notify("hit_damage");
	return 0;
}

/*
	Name: function_5adbafc9
	Namespace: namespace_74571cc1
	Checksum: 0x424F4353
	Offset: 0x2A0
	Size: 0xD8
	Parameters: 1
	Flags: None
	Line Number: 54
*/
function function_5adbafc9(player)
{
	str_damagemod = self.damageMod;
	w_damage = self.damageWeapon;
	w_damage = zm_weapons::get_nonalternate_weapon(w_damage);
	weaponClass = util::getWeaponClass(w_damage);
	if(zm_utility::is_headshot(w_damage, self.damagelocation, str_damagemod) && weaponClass == "weapon_sniper")
	{
		self playlocalsound("mp_hit_indication_3d");
	}
	player notify("hash_5ccef29f");
	return 0;
}

/*
	Name: function_9eb73aef
	Namespace: namespace_74571cc1
	Checksum: 0x424F4353
	Offset: 0x380
	Size: 0x328
	Parameters: 0
	Flags: None
	Line Number: 78
*/
function function_9eb73aef()
{
	while(1)
	{
		self waittill("hit_damage");
		self playlocalsound("zmb_death_gibs");
		if(level.zombie_vars[self.team]["zombie_insta_kill"] == 1)
		{
			self playlocalsound("mp_hit_indication_3d");
			self.var_5ace6d11 = 1;
			self.hud_damagefeedback.alpha = 0;
			self.hud_damagefeedback.x = 0;
			self.hud_damagefeedback.y = 0;
			self.hud_damagefeedback.alignx = "center";
			self.hud_damagefeedback.aligny = "middle";
			self.hud_damagefeedback.horzalign = "center";
			self.hud_damagefeedback.vertalign = "middle";
			self.hud_damagefeedback setshader("robit_hitmarker_death", 56, 56);
			self.hud_damagefeedback.color = (1, 1, 1);
			self.hud_damagefeedback.alpha = 1;
			self.hud_damagefeedback scaleovertime(0.2, 32, 32);
			wait(0.8);
			self.hud_damagefeedback fadeovertime(0.2);
			self.hud_damagefeedback.alpha = 0;
			self.var_5ace6d11 = 0;
		}
		else if(self.var_5ace6d11 != 1)
		{
			self.hud_damagefeedback.alpha = 0;
			self.hud_damagefeedback.x = 0;
			self.hud_damagefeedback.y = 0;
			self.hud_damagefeedback.alignx = "center";
			self.hud_damagefeedback.aligny = "middle";
			self.hud_damagefeedback.horzalign = "center";
			self.hud_damagefeedback.vertalign = "middle";
			self.hud_damagefeedback setshader("robit_hitmarker", 32, 32);
			self.hud_damagefeedback.color = (1, 1, 1);
			self.hud_damagefeedback.alpha = 1;
			wait(0.8);
			self.hud_damagefeedback fadeovertime(0.4);
			self.hud_damagefeedback.alpha = 0;
			self.var_5ace6d11 = 0;
		}
	}
}

/*
	Name: function_1b66e392
	Namespace: namespace_74571cc1
	Checksum: 0x424F4353
	Offset: 0x6B0
	Size: 0x1A0
	Parameters: 0
	Flags: None
	Line Number: 134
*/
function function_1b66e392()
{
	while(1)
	{
		self waittill("hash_5ccef29f");
		self playlocalsound("mp_hit_indication_3d");
		self.var_5ace6d11 = 1;
		self.hud_damagefeedback.alpha = 0;
		self.hud_damagefeedback.x = 0;
		self.hud_damagefeedback.y = 0;
		self.hud_damagefeedback.alignx = "center";
		self.hud_damagefeedback.aligny = "middle";
		self.hud_damagefeedback.horzalign = "center";
		self.hud_damagefeedback.vertalign = "middle";
		self.hud_damagefeedback setshader("robit_hitmarker_death", 56, 56);
		self.hud_damagefeedback.color = (1, 1, 1);
		self.hud_damagefeedback.alpha = 1;
		self.hud_damagefeedback scaleovertime(0.2, 32, 32);
		wait(0.8);
		self.hud_damagefeedback fadeovertime(0.2);
		self.hud_damagefeedback.alpha = 0;
		self.var_5ace6d11 = 0;
	}
}

