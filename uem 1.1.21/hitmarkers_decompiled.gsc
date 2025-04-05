#include scripts\shared\callbacks_shared;
#include scripts\shared\util_shared;
#include scripts\zm\_zm_spawner;
#include scripts\zm\_zm_utility;
#include scripts\zm\_zm_weapons;

#namespace namespace_74571cc1;

/*
	Name: function_init
	Namespace: namespace_74571cc1
	Checksum: 0x424F4353
	Offset: 0x188
	Size: 0x8
	Parameters: 0
	Flags: AutoExec
	Line Number: 18
*/
function autoexec function_init()
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
function function_9c301f1a(var_mod, var_HIT_LOCATION, var_hit_origin, var_player, var_amount, var_weapon, var_direction_vec, var_tagName, var_modelName, var_partName, var_dFlags, var_inflictor, var_chargeLevel)
{
	var_w_damage = namespace_zm_weapons::function_get_nonalternate_weapon(var_weapon);
	var_weaponClass = namespace_util::function_getWeaponClass(var_w_damage);
	if(var_HIT_LOCATION == "helmet" && var_weaponClass == "weapon_sniper")
	{
		var_player function_playlocalsound("mp_hit_indication_3d");
	}
	var_player notify("hash_hit_damage");
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
function function_5adbafc9(var_player)
{
	var_str_damagemod = self.var_damageMod;
	var_w_damage = self.var_damageWeapon;
	var_w_damage = namespace_zm_weapons::function_get_nonalternate_weapon(var_w_damage);
	var_weaponClass = namespace_util::function_getWeaponClass(var_w_damage);
	if(namespace_zm_utility::function_is_headshot(var_w_damage, self.var_damagelocation, var_str_damagemod) && var_weaponClass == "weapon_sniper")
	{
		self function_playlocalsound("mp_hit_indication_3d");
	}
	var_player notify("hash_5ccef29f");
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
		self waittill("hash_hit_damage");
		self function_playlocalsound("zmb_death_gibs");
		if(level.var_zombie_vars[self.var_team]["zombie_insta_kill"] == 1)
		{
			self function_playlocalsound("mp_hit_indication_3d");
			self.var_5ace6d11 = 1;
			self.var_hud_damagefeedback.var_alpha = 0;
			self.var_hud_damagefeedback.var_x = 0;
			self.var_hud_damagefeedback.var_y = 0;
			self.var_hud_damagefeedback.var_alignX = "center";
			self.var_hud_damagefeedback.var_alignY = "middle";
			self.var_hud_damagefeedback.var_horzAlign = "center";
			self.var_hud_damagefeedback.var_vertAlign = "middle";
			self.var_hud_damagefeedback function_SetShader("robit_hitmarker_death", 56, 56);
			self.var_hud_damagefeedback.var_color = (1, 1, 1);
			self.var_hud_damagefeedback.var_alpha = 1;
			self.var_hud_damagefeedback function_ScaleOverTime(0.2, 32, 32);
			wait(0.8);
			self.var_hud_damagefeedback function_fadeOverTime(0.2);
			self.var_hud_damagefeedback.var_alpha = 0;
			self.var_5ace6d11 = 0;
		}
		else if(self.var_5ace6d11 != 1)
		{
			self.var_hud_damagefeedback.var_alpha = 0;
			self.var_hud_damagefeedback.var_x = 0;
			self.var_hud_damagefeedback.var_y = 0;
			self.var_hud_damagefeedback.var_alignX = "center";
			self.var_hud_damagefeedback.var_alignY = "middle";
			self.var_hud_damagefeedback.var_horzAlign = "center";
			self.var_hud_damagefeedback.var_vertAlign = "middle";
			self.var_hud_damagefeedback function_SetShader("robit_hitmarker", 32, 32);
			self.var_hud_damagefeedback.var_color = (1, 1, 1);
			self.var_hud_damagefeedback.var_alpha = 1;
			wait(0.8);
			self.var_hud_damagefeedback function_fadeOverTime(0.4);
			self.var_hud_damagefeedback.var_alpha = 0;
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
		self function_playlocalsound("mp_hit_indication_3d");
		self.var_5ace6d11 = 1;
		self.var_hud_damagefeedback.var_alpha = 0;
		self.var_hud_damagefeedback.var_x = 0;
		self.var_hud_damagefeedback.var_y = 0;
		self.var_hud_damagefeedback.var_alignX = "center";
		self.var_hud_damagefeedback.var_alignY = "middle";
		self.var_hud_damagefeedback.var_horzAlign = "center";
		self.var_hud_damagefeedback.var_vertAlign = "middle";
		self.var_hud_damagefeedback function_SetShader("robit_hitmarker_death", 56, 56);
		self.var_hud_damagefeedback.var_color = (1, 1, 1);
		self.var_hud_damagefeedback.var_alpha = 1;
		self.var_hud_damagefeedback function_ScaleOverTime(0.2, 32, 32);
		wait(0.8);
		self.var_hud_damagefeedback function_fadeOverTime(0.2);
		self.var_hud_damagefeedback.var_alpha = 0;
		self.var_5ace6d11 = 0;
	}
}

