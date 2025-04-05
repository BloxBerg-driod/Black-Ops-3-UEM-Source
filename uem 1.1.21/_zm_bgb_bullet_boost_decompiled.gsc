#include scripts\codescripts\struct;
#include scripts\shared\aat_shared;
#include scripts\shared\flag_shared;
#include scripts\shared\laststand_shared;
#include scripts\shared\system_shared;
#include scripts\shared\util_shared;
#include scripts\zm\_zm_bgb;
#include scripts\zm\_zm_magicbox;
#include scripts\zm\_zm_powerups;
#include scripts\zm\_zm_utility;
#include scripts\zm\_zm_weapons;

#namespace namespace_59f1b581;

/*
	Name: function___init__sytem__
	Namespace: namespace_59f1b581
	Checksum: 0x424F4353
	Offset: 0x218
	Size: 0x38
	Parameters: 0
	Flags: AutoExec
	Line Number: 24
*/
function autoexec function___init__sytem__()
{
	namespace_system::function_register("zm_bgb_bullet_boost", &function___init__, undefined, "bgb");
}

/*
	Name: function___init__
	Namespace: namespace_59f1b581
	Checksum: 0x424F4353
	Offset: 0x258
	Size: 0x20
	Parameters: 0
	Flags: None
	Line Number: 39
*/
function function___init__()
{
	if(!(isdefined(level.var_bgb_in_use) && level.var_bgb_in_use))
	{
		return;
	}
}

/*
	Name: function_validation
	Namespace: namespace_59f1b581
	Checksum: 0x424F4353
	Offset: 0x280
	Size: 0x130
	Parameters: 0
	Flags: None
	Line Number: 57
*/
function function_validation()
{
	var_current_weapon = self function_GetCurrentWeapon();
	if(!self namespace_zm_magicbox::function_can_buy_weapon() || self namespace_laststand::function_player_is_in_laststand() || (isdefined(self.var_intermission) && self.var_intermission) || self function_IsThrowingGrenade() || (!self namespace_zm_weapons::function_can_upgrade_weapon(var_current_weapon) && !namespace_zm_weapons::function_weapon_supports_aat(var_current_weapon)))
	{
		return 0;
	}
	if(self function_IsSwitchingWeapons())
	{
		return 0;
	}
	if(!namespace_zm_weapons::function_is_weapon_or_base_included(var_current_weapon))
	{
		return 0;
	}
	var_b_weapon_supports_aat = namespace_zm_weapons::function_weapon_supports_aat(var_current_weapon);
	if(!var_b_weapon_supports_aat)
	{
		return 0;
	}
	return 1;
}

/*
	Name: function_activation
	Namespace: namespace_59f1b581
	Checksum: 0x424F4353
	Offset: 0x3B8
	Size: 0x164
	Parameters: 0
	Flags: None
	Line Number: 90
*/
function function_activation()
{
	self endon("hash_f49a0cb");
	self endon("hash_82223b0f");
	self function_playsoundtoplayer("zmb_bgb_bullet_boost", self);
	self namespace_util::function_waittill_any_timeout(1, "weapon_change_complete", "death", "disconnect");
	var_current_weapon = self function_GetCurrentWeapon();
	var_current_weapon = self namespace_zm_weapons::function_switch_from_alt_weapon(var_current_weapon);
	var_3a5329e8 = 0;
	while(var_current_weapon === level.var_weaponNone || !namespace_zm_weapons::function_weapon_supports_aat(var_current_weapon))
	{
		wait(0.05);
		var_current_weapon = self function_GetCurrentWeapon();
		var_3a5329e8++;
		if(var_current_weapon === level.var_weaponNone || (!namespace_zm_weapons::function_weapon_supports_aat(var_current_weapon) && var_3a5329e8 > 300))
		{
			return;
		}
	}
	self namespace_AAT::function_acquire(var_current_weapon);
}

