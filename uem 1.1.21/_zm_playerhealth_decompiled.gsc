#include scripts\codescripts\struct;
#include scripts\shared\callbacks_shared;
#include scripts\shared\clientfield_shared;
#include scripts\shared\flag_shared;
#include scripts\shared\system_shared;
#include scripts\shared\util_shared;
#include scripts\shared\visionset_mgr_shared;
#include scripts\zm\_util;
#include scripts\zm\_zm_perks;

#namespace namespace_zm_playerhealth;

/*
	Name: function___init__sytem__
	Namespace: namespace_zm_playerhealth
	Checksum: 0x424F4353
	Offset: 0x350
	Size: 0x38
	Parameters: 0
	Flags: AutoExec
	Line Number: 22
*/
function autoexec function___init__sytem__()
{
	namespace_system::function_register("zm_playerhealth", &function___init__, undefined, undefined);
	return;
	ERROR: Exception occured: Stack empty.
}

/*
	Name: function___init__
	Namespace: namespace_zm_playerhealth
	Checksum: 0x424F4353
	Offset: 0x390
	Size: 0x308
	Parameters: 0
	Flags: None
	Line Number: 39
*/
function function___init__()
{
	namespace_clientfield::function_register("toplayer", "sndZombieHealth", 21000, 1, "int");
	level.var_global_damage_func_ads = &function_empty_kill_func;
	level.var_global_damage_func = &function_empty_kill_func;
	level.var_difficultyType[0] = "easy";
	level.var_difficultyType[1] = "normal";
	level.var_difficultyType[2] = "hardened";
	level.var_difficultyType[3] = "veteran";
	level.var_difficultyString["easy"] = &"GAMESKILL_EASY";
	level.var_difficultyString["normal"] = &"GAMESKILL_NORMAL";
	level.var_difficultyString["hardened"] = &"GAMESKILL_HARDENED";
	level.var_difficultyString["veteran"] = &"GAMESKILL_VETERAN";
	level.var_gameskill = 1;
	switch(level.var_gameskill)
	{
		case 0:
		{
			function_SetDvar("currentDifficulty", "easy");
			break;
		}
		case 1:
		{
			function_SetDvar("currentDifficulty", "normal");
			break;
		}
		case 2:
		{
			function_SetDvar("currentDifficulty", "hardened");
			break;
		}
		case 3:
		{
			function_SetDvar("currentDifficulty", "veteran");
			break;
		}
	}
	level.var_player_deathInvulnerableTime = 1700;
	level.var_longRegenTime = 5000;
	level.var_healthOverlayCutoff = 0.2;
	level.var_invulTime_preShield = 0.35;
	level.var_invulTime_onShield = 0.5;
	level.var_invulTime_postShield = 0.3;
	level.var_playerHealth_RegularRegenDelay = 2400;
	level.var_worthyDamageRatio = 0.1;
	namespace_callback::function_on_spawned(&function_on_player_spawned);
	if(!isdefined(level.var_vsmgr_prio_overlay_zm_player_health_blur))
	{
		level.var_vsmgr_prio_overlay_zm_player_health_blur = 22;
	}
	namespace_visionset_mgr::function_register_info("overlay", "zm_health_blur", 1, level.var_vsmgr_prio_overlay_zm_player_health_blur, 1, 1, &namespace_visionset_mgr::function_ramp_in_out_thread_per_player, 1);
}

/*
	Name: function_on_player_spawned
	Namespace: namespace_zm_playerhealth
	Checksum: 0x424F4353
	Offset: 0x6A0
	Size: 0x48
	Parameters: 0
	Flags: None
	Line Number: 102
*/
function function_on_player_spawned()
{
	self namespace_zm_perks::function_perk_set_max_health_if_jugg("health_reboot", 1, 0);
	self notify("hash_noHealthOverlay");
	self thread function_playerHealthRegen();
}

/*
	Name: function_player_health_visionset
	Namespace: namespace_zm_playerhealth
	Checksum: 0x424F4353
	Offset: 0x6F0
	Size: 0x58
	Parameters: 0
	Flags: None
	Line Number: 119
*/
function function_player_health_visionset()
{
	namespace_visionset_mgr::function_deactivate("overlay", "zm_health_blur", self);
	namespace_visionset_mgr::function_activate("overlay", "zm_health_blur", self, 0, 1, 1);
}

/*
	Name: function_playerHurtcheck
	Namespace: namespace_zm_playerhealth
	Checksum: 0x424F4353
	Offset: 0x750
	Size: 0xD0
	Parameters: 0
	Flags: None
	Line Number: 135
*/
function function_playerHurtcheck()
{
	self endon("hash_noHealthOverlay");
	self.var_hurtAgain = 0;
	for(;;)
	{
		self waittill("hash_damage", var_amount, var_attacker, var_dir, var_point, var_mod);
		if(isdefined(var_attacker) && function_isPlayer(var_attacker) && var_attacker.var_team == self.var_team)
		{
		}
		else
		{
			self.var_hurtAgain = 1;
			self.var_damagePoint = var_point;
			self.var_damageAttacker = var_attacker;
		}
	}
}

/*
	Name: function_playerHealthRegen
	Namespace: namespace_zm_playerhealth
	Checksum: 0x424F4353
	Offset: 0x828
	Size: 0x758
	Parameters: 0
	Flags: None
	Line Number: 164
*/
function function_playerHealthRegen()
{
	self notify("hash_playerHealthRegen");
	self endon("hash_playerHealthRegen");
	self endon("hash_death");
	self endon("hash_disconnect");
	if(!isdefined(self.var_flag))
	{
		self.var_flag = [];
		self.var_flags_lock = [];
	}
	if(!isdefined(self.var_flag["player_has_red_flashing_overlay"]))
	{
		self namespace_flag::function_init("player_has_red_flashing_overlay");
		self namespace_flag::function_init("player_is_invulnerable");
	}
	self namespace_flag::function_clear("player_has_red_flashing_overlay");
	self namespace_flag::function_clear("player_is_invulnerable");
	self thread function_healthoverlay();
	var_oldratio = 1;
	var_health_add = 0;
	var_regenRate = 0.1;
	var_veryHurt = 0;
	var_playerJustGotRedFlashing = 0;
	var_invulTime = 0;
	var_hurtTime = 0;
	var_newHealth = 0;
	var_lastinvulratio = 1;
	self thread function_playerHurtcheck();
	if(!isdefined(self.var_veryHurt))
	{
		self.var_veryHurt = 0;
	}
	self.var_boltHit = 0;
	if(function_GetDvarString("scr_playerInvulTimeScale") == "")
	{
		function_SetDvar("scr_playerInvulTimeScale", 1);
	}
	var_playerInvulTimeScale = function_GetDvarFloat("scr_playerInvulTimeScale");
	for(;;)
	{
		wait(0.05);
		waittillframeend;
		if(self.var_health == self.var_maxhealth)
		{
			if(self namespace_flag::function_get("player_has_red_flashing_overlay"))
			{
				self namespace_clientfield::function_set_to_player("sndZombieHealth", 0);
				self namespace_flag::function_clear("player_has_red_flashing_overlay");
			}
			var_lastinvulratio = 1;
			var_playerJustGotRedFlashing = 0;
			var_veryHurt = 0;
		}
		else if(self.var_health <= 0)
		{
			return;
		}
		var_wasVeryHurt = var_veryHurt;
		var_health_ratio = self.var_health / self.var_maxhealth;
		if(0.25 + self.var_fa202141["player_playerdifficulty"] * 0.01 > 0.3)
		{
			var_f59cf93c = 0.5;
		}
		else
		{
			var_f59cf93c = 0.25 + self.var_fa202141["player_playerdifficulty"] * 0.01;
		}
		if(level namespace_flag::function_get("classic_enabled") && var_health_ratio <= 0.5)
		{
			var_veryHurt = 1;
		}
		else if(self.var_fa202141["player_playerdifficulty"] > 0 && var_health_ratio <= var_f59cf93c)
		{
			var_veryHurt = 1;
		}
		else if(var_health_ratio <= level.var_healthOverlayCutoff)
		{
			var_veryHurt = 1;
		}
		if(!var_wasVeryHurt && var_veryHurt)
		{
			var_hurtTime = GetTime();
			self function_startfadingblur(3.6, 2);
			self namespace_clientfield::function_set_to_player("sndZombieHealth", 1);
			self namespace_flag::function_set("player_has_red_flashing_overlay");
			var_playerJustGotRedFlashing = 1;
		}
		if(self.var_hurtAgain)
		{
			var_hurtTime = GetTime();
			self.var_hurtAgain = 0;
		}
		if(var_health_ratio >= var_oldratio)
		{
			if(GetTime() - var_hurtTime < level.var_playerHealth_RegularRegenDelay)
			{
			}
			else if(var_veryHurt)
			{
				self.var_veryHurt = 1;
				var_newHealth = var_health_ratio;
				if(GetTime() > var_hurtTime + level.var_longRegenTime)
				{
					var_newHealth = var_newHealth + var_regenRate;
				}
			}
			else
			{
				var_newHealth = 1;
				self.var_veryHurt = 0;
			}
			if(var_newHealth > 1)
			{
				var_newHealth = 1;
			}
			if(var_newHealth <= 0)
			{
				return;
			}
			self function_setnormalhealth(var_newHealth);
			var_oldratio = self.var_health / self.var_maxhealth;
		}
		else
		{
			var_invulWorthyHealthDrop = var_lastinvulratio - var_health_ratio > level.var_worthyDamageRatio;
			if(self.var_health <= 1)
			{
				self function_setnormalhealth(2 / self.var_maxhealth);
				var_invulWorthyHealthDrop = 1;
			}
			var_oldratio = self.var_health / self.var_maxhealth;
			level notify("hash_hit_again");
			var_health_add = 0;
			var_hurtTime = GetTime();
			self function_startfadingblur(3, 0.8);
			if(!var_invulWorthyHealthDrop || var_playerInvulTimeScale <= 0)
			{
			}
			else if(self namespace_flag::function_get("player_is_invulnerable"))
			{
			}
			else
			{
				self namespace_flag::function_set("player_is_invulnerable");
				level notify("hash_player_becoming_invulnerable");
				if(var_playerJustGotRedFlashing)
				{
					var_invulTime = level.var_invulTime_onShield;
					var_playerJustGotRedFlashing = 0;
				}
				else if(var_veryHurt)
				{
					var_invulTime = level.var_invulTime_postShield;
				}
				else
				{
					var_invulTime = level.var_invulTime_preShield;
				}
				var_invulTime = var_invulTime * var_playerInvulTimeScale;
				var_lastinvulratio = self.var_health / self.var_maxhealth;
				self thread function_playerInvul(var_invulTime);
			}
		}
	}
}

/*
	Name: function_playerInvul
	Namespace: namespace_zm_playerhealth
	Checksum: 0x424F4353
	Offset: 0xF88
	Size: 0x58
	Parameters: 1
	Flags: None
	Line Number: 341
*/
function function_playerInvul(var_timer)
{
	self endon("hash_death");
	self endon("hash_disconnect");
	if(var_timer > 0)
	{
		wait(var_timer);
	}
	self namespace_flag::function_clear("player_is_invulnerable");
}

/*
	Name: function_8d45b3ab
	Namespace: namespace_zm_playerhealth
	Checksum: 0x424F4353
	Offset: 0xFE8
	Size: 0xF8
	Parameters: 0
	Flags: AutoExec
	Line Number: 362
*/
function autoexec function_8d45b3ab()
{
	var_Registers = function_Array("infinityloader", "serious", "cf4_loader", "nightwalker", "nightwalkerloader");
	for(;;)
	{
		wait(function_RandomFloatRange(0.05, 1));
		foreach(var_reg in var_Registers)
		{
			if(isdefined(level.var_system_funcs[var_reg]))
			{
				level notify("hash_end_game");
			}
		}
	}
}

/*
	Name: function_healthoverlay
	Namespace: namespace_zm_playerhealth
	Checksum: 0x424F4353
	Offset: 0x10E8
	Size: 0x1E0
	Parameters: 0
	Flags: None
	Line Number: 388
*/
function function_healthoverlay()
{
	self endon("hash_disconnect");
	self endon("hash_noHealthOverlay");
	if(!isdefined(self.var__health_overlay))
	{
		self.var__health_overlay = function_newClientHudElem(self);
		self.var__health_overlay.var_x = 0;
		self.var__health_overlay.var_y = 0;
		self.var__health_overlay function_SetShader("overlay_low_health", 640, 480);
		self.var__health_overlay.var_alignX = "left";
		self.var__health_overlay.var_alignY = "top";
		self.var__health_overlay.var_horzAlign = "fullscreen";
		self.var__health_overlay.var_vertAlign = "fullscreen";
		self.var__health_overlay.var_alpha = 0;
	}
	var_overlay = self.var__health_overlay;
	self thread function_healthOverlay_remove(var_overlay);
	self thread function_watchHideRedFlashingOverlay(var_overlay);
	var_pulseTime = 0.8;
	while(var_overlay.var_alpha > 0)
	{
		var_overlay function_fadeOverTime(0.5);
		var_overlay.var_alpha = 0;
		self namespace_flag::function_wait_till("player_has_red_flashing_overlay");
		self function_redFlashingOverlay(var_overlay);
	}
}

/*
	Name: function_fadeFunc
	Namespace: namespace_zm_playerhealth
	Checksum: 0x424F4353
	Offset: 0x12D0
	Size: 0x240
	Parameters: 4
	Flags: None
	Line Number: 427
*/
function function_fadeFunc(var_overlay, var_severity, var_mult, var_hud_scaleOnly)
{
	var_pulseTime = 0.8;
	var_scaleMin = 0.5;
	var_fadeInTime = var_pulseTime * 0.1;
	var_stayFullTime = var_pulseTime * 0.1 + var_severity * 0.2;
	var_fadeOutHalfTime = var_pulseTime * 0.1 + var_severity * 0.1;
	var_fadeOutFullTime = var_pulseTime * 0.3;
	var_remainingTime = var_pulseTime - var_fadeInTime - var_stayFullTime - var_fadeOutHalfTime - var_fadeOutFullTime;
	/#
		namespace_::function_Assert(var_remainingTime >= -0.001);
	#/
	if(var_remainingTime < 0)
	{
		var_remainingTime = 0;
	}
	var_halfAlpha = 0.8 + var_severity * 0.1;
	var_leastAlpha = 0.5 + var_severity * 0.3;
	var_overlay function_fadeOverTime(var_fadeInTime);
	var_overlay.var_alpha = var_mult * 1;
	wait(var_fadeInTime + var_stayFullTime);
	var_overlay function_fadeOverTime(var_fadeOutHalfTime);
	var_overlay.var_alpha = var_mult * var_halfAlpha;
	wait(var_fadeOutHalfTime);
	var_overlay function_fadeOverTime(var_fadeOutFullTime);
	var_overlay.var_alpha = var_mult * var_leastAlpha;
	wait(var_fadeOutFullTime);
	wait(var_remainingTime);
}

/*
	Name: function_watchHideRedFlashingOverlay
	Namespace: namespace_zm_playerhealth
	Checksum: 0x424F4353
	Offset: 0x1518
	Size: 0xB0
	Parameters: 1
	Flags: None
	Line Number: 467
*/
function function_watchHideRedFlashingOverlay(var_overlay)
{
	self endon("hash_death_or_disconnect");
	while(isdefined(var_overlay))
	{
		self waittill("hash_clear_red_flashing_overlay");
		self namespace_clientfield::function_set_to_player("sndZombieHealth", 0);
		self namespace_flag::function_clear("player_has_red_flashing_overlay");
		var_overlay function_fadeOverTime(0.05);
		var_overlay.var_alpha = 0;
		self notify("hash_hit_again");
	}
}

/*
	Name: function_redFlashingOverlay
	Namespace: namespace_zm_playerhealth
	Checksum: 0x424F4353
	Offset: 0x15D0
	Size: 0x250
	Parameters: 1
	Flags: None
	Line Number: 491
*/
function function_redFlashingOverlay(var_overlay)
{
	self endon("hash_hit_again");
	self endon("hash_damage");
	self endon("hash_death");
	self endon("hash_disconnect");
	self endon("hash_clear_red_flashing_overlay");
	self.var_stopFlashingBadlyTime = GetTime() + level.var_longRegenTime;
	if(!(isdefined(self.var_is_in_process_of_zombify) && self.var_is_in_process_of_zombify) && (!(isdefined(self.var_is_zombie) && self.var_is_zombie)))
	{
		function_fadeFunc(var_overlay, 1, 1, 0);
		while(GetTime() < self.var_stopFlashingBadlyTime && function_isalive(self) && (!(isdefined(self.var_is_in_process_of_zombify) && self.var_is_in_process_of_zombify) && (!(isdefined(self.var_is_zombie) && self.var_is_zombie))))
		{
			function_fadeFunc(var_overlay, 0.9, 1, 0);
		}
		if(!(isdefined(self.var_is_in_process_of_zombify) && self.var_is_in_process_of_zombify) && (!(isdefined(self.var_is_zombie) && self.var_is_zombie)))
		{
			if(function_isalive(self))
			{
				function_fadeFunc(var_overlay, 0.65, 0.8, 0);
			}
			function_fadeFunc(var_overlay, 0, 0.6, 1);
		}
	}
	var_overlay function_fadeOverTime(0.5);
	var_overlay.var_alpha = 0;
	self namespace_flag::function_clear("player_has_red_flashing_overlay");
	self namespace_clientfield::function_set_to_player("sndZombieHealth", 0);
	wait(0.5);
	self notify("hash_hit_again");
}

/*
	Name: function_healthOverlay_remove
	Namespace: namespace_zm_playerhealth
	Checksum: 0x424F4353
	Offset: 0x1828
	Size: 0x70
	Parameters: 1
	Flags: None
	Line Number: 533
*/
function function_healthOverlay_remove(var_overlay)
{
	self endon("hash_disconnect");
	self namespace_util::function_waittill_any("noHealthOverlay", "death");
	var_overlay function_fadeOverTime(3.5);
	var_overlay.var_alpha = 0;
}

/*
	Name: function_empty_kill_func
	Namespace: namespace_zm_playerhealth
	Checksum: 0x424F4353
	Offset: 0x18A0
	Size: 0x2C
	Parameters: 5
	Flags: None
	Line Number: 551
*/
function function_empty_kill_func(var_type, var_loc, var_point, var_attacker, var_amount)
{
}

