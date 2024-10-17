#include scripts\codescripts\struct;
#include scripts\shared\callbacks_shared;
#include scripts\shared\clientfield_shared;
#include scripts\shared\flag_shared;
#include scripts\shared\system_shared;
#include scripts\shared\util_shared;
#include scripts\shared\visionset_mgr_shared;
#include scripts\zm\_util;
#include scripts\zm\_zm_perks;

#namespace zm_playerhealth;

/*
	Name: __init__sytem__
	Namespace: zm_playerhealth
	Checksum: 0x424F4353
	Offset: 0x310
	Size: 0x38
	Parameters: 0
	Flags: AutoExec
	Line Number: 22
*/
function autoexec __init__sytem__()
{
	system::register("zm_playerhealth", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: zm_playerhealth
	Checksum: 0x424F4353
	Offset: 0x350
	Size: 0x308
	Parameters: 0
	Flags: None
	Line Number: 37
*/
function __init__()
{
	clientfield::register("toplayer", "sndZombieHealth", 21000, 1, "int");
	level.global_damage_func_ads = &empty_kill_func;
	level.global_damage_func = &empty_kill_func;
	level.difficultyType[0] = "easy";
	level.difficultyType[1] = "normal";
	level.difficultyType[2] = "hardened";
	level.difficultyType[3] = "veteran";
	level.difficultyString["easy"] = &"GAMESKILL_EASY";
	level.difficultyString["normal"] = &"GAMESKILL_NORMAL";
	level.difficultyString["hardened"] = &"GAMESKILL_HARDENED";
	level.difficultyString["veteran"] = &"GAMESKILL_VETERAN";
	level.gameskill = 1;
	switch(level.gameskill)
	{
		case 0:
		{
			setdvar("currentDifficulty", "easy");
			break;
		}
		case 1:
		{
			setdvar("currentDifficulty", "normal");
			break;
		}
		case 2:
		{
			setdvar("currentDifficulty", "hardened");
			break;
		}
		case 3:
		{
			setdvar("currentDifficulty", "veteran");
			break;
		}
	}
	level.player_deathInvulnerableTime = 1700;
	level.longRegenTime = 5000;
	level.healthOverlayCutoff = 0.2;
	level.invulTime_preShield = 0.35;
	level.invulTime_onShield = 0.5;
	level.invulTime_postShield = 0.3;
	level.playerHealth_RegularRegenDelay = 2400;
	level.worthyDamageRatio = 0.1;
	callback::on_spawned(&on_player_spawned);
	if(!isdefined(level.vsmgr_prio_overlay_zm_player_health_blur))
	{
		level.vsmgr_prio_overlay_zm_player_health_blur = 22;
	}
	visionset_mgr::register_info("overlay", "zm_health_blur", 1, level.vsmgr_prio_overlay_zm_player_health_blur, 1, 1, &visionset_mgr::ramp_in_out_thread_per_player, 1);
}

/*
	Name: on_player_spawned
	Namespace: zm_playerhealth
	Checksum: 0x424F4353
	Offset: 0x660
	Size: 0x48
	Parameters: 0
	Flags: None
	Line Number: 100
*/
function on_player_spawned()
{
	self zm_perks::perk_set_max_health_if_jugg("health_reboot", 1, 0);
	self notify("noHealthOverlay");
	self thread playerHealthRegen();
}

/*
	Name: player_health_visionset
	Namespace: zm_playerhealth
	Checksum: 0x424F4353
	Offset: 0x6B0
	Size: 0x58
	Parameters: 0
	Flags: None
	Line Number: 117
*/
function player_health_visionset()
{
	visionset_mgr::deactivate("overlay", "zm_health_blur", self);
	visionset_mgr::activate("overlay", "zm_health_blur", self, 0, 1, 1);
}

/*
	Name: playerhurtcheck
	Namespace: zm_playerhealth
	Checksum: 0x424F4353
	Offset: 0x710
	Size: 0xD0
	Parameters: 0
	Flags: None
	Line Number: 133
*/
function playerhurtcheck()
{
	self endon("noHealthOverlay");
	self.hurtAgain = 0;
	for(;;)
	{
		self waittill("damage", amount, attacker, dir, point, mod);
		if(isdefined(attacker) && isplayer(attacker) && attacker.team == self.team)
		{
		}
		else
		{
			self.hurtAgain = 1;
			self.damagePoint = point;
			self.damageAttacker = attacker;
		}
	}
	return;
	ERROR: Bad function call
}

/*
	Name: playerHealthRegen
	Namespace: zm_playerhealth
	Checksum: 0x424F4353
	Offset: 0x7E8
	Size: 0x758
	Parameters: 0
	Flags: None
	Line Number: 164
*/
function playerHealthRegen()
{
	self notify("playerHealthRegen");
	self endon("playerHealthRegen");
	self endon("death");
	self endon("disconnect");
	if(!isdefined(self.flag))
	{
		self.flag = [];
		self.flags_lock = [];
	}
	if(!isdefined(self.flag["player_has_red_flashing_overlay"]))
	{
		self flag::init("player_has_red_flashing_overlay");
		self flag::init("player_is_invulnerable");
	}
	self flag::clear("player_has_red_flashing_overlay");
	self flag::clear("player_is_invulnerable");
	self thread healthoverlay();
	oldratio = 1;
	health_add = 0;
	regenRate = 0.1;
	veryHurt = 0;
	playerJustGotRedFlashing = 0;
	invulTime = 0;
	hurtTime = 0;
	newHealth = 0;
	lastinvulratio = 1;
	self thread playerhurtcheck();
	if(!isdefined(self.veryHurt))
	{
		self.veryHurt = 0;
	}
	self.boltHit = 0;
	if(getdvarstring("scr_playerInvulTimeScale") == "")
	{
		setdvar("scr_playerInvulTimeScale", 1);
	}
	playerInvulTimeScale = getdvarfloat("scr_playerInvulTimeScale");
	for(;;)
	{
		wait(0.05);
		waittillframeend;
		if(self.health == self.maxhealth)
		{
			if(self flag::get("player_has_red_flashing_overlay"))
			{
				self clientfield::set_to_player("sndZombieHealth", 0);
				self flag::clear("player_has_red_flashing_overlay");
			}
			lastinvulratio = 1;
			playerJustGotRedFlashing = 0;
			veryHurt = 0;
		}
		else if(self.health <= 0)
		{
			return;
		}
		wasVeryHurt = veryHurt;
		health_ratio = self.health / self.maxhealth;
		if(0.25 + self.var_fa202141["player_playerdifficulty"] * 0.01 > 0.3)
		{
			var_f59cf93c = 0.5;
		}
		else
		{
			var_f59cf93c = 0.25 + self.var_fa202141["player_playerdifficulty"] * 0.01;
		}
		if(level flag::get("classic_enabled") && health_ratio <= 0.5)
		{
			veryHurt = 1;
		}
		else if(self.var_fa202141["player_playerdifficulty"] > 0 && health_ratio <= var_f59cf93c)
		{
			veryHurt = 1;
		}
		else if(health_ratio <= level.healthOverlayCutoff)
		{
			veryHurt = 1;
		}
		if(!wasVeryHurt && veryHurt)
		{
			hurtTime = GetTime();
			self startfadingblur(3.6, 2);
			self clientfield::set_to_player("sndZombieHealth", 1);
			self flag::set("player_has_red_flashing_overlay");
			playerJustGotRedFlashing = 1;
		}
		if(self.hurtAgain)
		{
			hurtTime = GetTime();
			self.hurtAgain = 0;
		}
		if(health_ratio >= oldratio)
		{
			if(GetTime() - hurtTime < level.playerHealth_RegularRegenDelay)
			{
			}
			else if(veryHurt)
			{
				self.veryHurt = 1;
				newHealth = health_ratio;
				if(GetTime() > hurtTime + level.longRegenTime)
				{
					newHealth = newHealth + regenRate;
				}
			}
			else
			{
				newHealth = 1;
				self.veryHurt = 0;
			}
			if(newHealth > 1)
			{
				newHealth = 1;
			}
			if(newHealth <= 0)
			{
				return;
			}
			self setnormalhealth(newHealth);
			oldratio = self.health / self.maxhealth;
		}
		else
		{
			invulWorthyHealthDrop = lastinvulratio - health_ratio > level.worthyDamageRatio;
			if(self.health <= 1)
			{
				self setnormalhealth(2 / self.maxhealth);
				invulWorthyHealthDrop = 1;
			}
			oldratio = self.health / self.maxhealth;
			level notify("hit_again");
			health_add = 0;
			hurtTime = GetTime();
			self startfadingblur(3, 0.8);
			if(!invulWorthyHealthDrop || playerInvulTimeScale <= 0)
			{
			}
			else if(self flag::get("player_is_invulnerable"))
			{
			}
			else
			{
				self flag::set("player_is_invulnerable");
				level notify("player_becoming_invulnerable");
				if(playerJustGotRedFlashing)
				{
					invulTime = level.invulTime_onShield;
					playerJustGotRedFlashing = 0;
				}
				else if(veryHurt)
				{
					invulTime = level.invulTime_postShield;
				}
				else
				{
					invulTime = level.invulTime_preShield;
				}
				invulTime = invulTime * playerInvulTimeScale;
				lastinvulratio = self.health / self.maxhealth;
				self thread playerInvul(invulTime);
			}
		}
	}
}

/*
	Name: playerInvul
	Namespace: zm_playerhealth
	Checksum: 0x424F4353
	Offset: 0xF48
	Size: 0x58
	Parameters: 1
	Flags: None
	Line Number: 341
*/
function playerInvul(timer)
{
	self endon("death");
	self endon("disconnect");
	if(timer > 0)
	{
		wait(timer);
	}
	self flag::clear("player_is_invulnerable");
}

/*
	Name: healthoverlay
	Namespace: zm_playerhealth
	Checksum: 0x424F4353
	Offset: 0xFA8
	Size: 0x1E0
	Parameters: 0
	Flags: None
	Line Number: 362
*/
function healthoverlay()
{
	self endon("disconnect");
	self endon("noHealthOverlay");
	if(!isdefined(self._health_overlay))
	{
		self._health_overlay = newclienthudelem(self);
		self._health_overlay.x = 0;
		self._health_overlay.y = 0;
		self._health_overlay setshader("overlay_low_health", 640, 480);
		self._health_overlay.alignx = "left";
		self._health_overlay.aligny = "top";
		self._health_overlay.horzalign = "fullscreen";
		self._health_overlay.vertalign = "fullscreen";
		self._health_overlay.alpha = 0;
	}
	overlay = self._health_overlay;
	self thread healthOverlay_remove(overlay);
	self thread watchHideRedFlashingOverlay(overlay);
	pulseTime = 0.8;
	while(overlay.alpha > 0)
	{
		overlay fadeovertime(0.5);
		overlay.alpha = 0;
		self flag::wait_till("player_has_red_flashing_overlay");
		self redFlashingOverlay(overlay);
	}
}

/*
	Name: fadeFunc
	Namespace: zm_playerhealth
	Checksum: 0x424F4353
	Offset: 0x1190
	Size: 0x240
	Parameters: 4
	Flags: None
	Line Number: 401
*/
function fadeFunc(overlay, severity, mult, hud_scaleOnly)
{
	pulseTime = 0.8;
	scaleMin = 0.5;
	fadeInTime = pulseTime * 0.1;
	stayFullTime = pulseTime * 0.1 + severity * 0.2;
	fadeOutHalfTime = pulseTime * 0.1 + severity * 0.1;
	fadeOutFullTime = pulseTime * 0.3;
	remainingTime = pulseTime - fadeInTime - stayFullTime - fadeOutHalfTime - fadeOutFullTime;
	/#
		Assert(remainingTime >= -0.001);
	#/
	if(remainingTime < 0)
	{
		remainingTime = 0;
	}
	halfAlpha = 0.8 + severity * 0.1;
	leastAlpha = 0.5 + severity * 0.3;
	overlay fadeovertime(fadeInTime);
	overlay.alpha = mult * 1;
	wait(fadeInTime + stayFullTime);
	overlay fadeovertime(fadeOutHalfTime);
	overlay.alpha = mult * halfAlpha;
	wait(fadeOutHalfTime);
	overlay fadeovertime(fadeOutFullTime);
	overlay.alpha = mult * leastAlpha;
	wait(fadeOutFullTime);
	wait(remainingTime);
}

/*
	Name: watchHideRedFlashingOverlay
	Namespace: zm_playerhealth
	Checksum: 0x424F4353
	Offset: 0x13D8
	Size: 0xB0
	Parameters: 1
	Flags: None
	Line Number: 441
*/
function watchHideRedFlashingOverlay(overlay)
{
	self endon("death_or_disconnect");
	while(isdefined(overlay))
	{
		self waittill("clear_red_flashing_overlay");
		self clientfield::set_to_player("sndZombieHealth", 0);
		self flag::clear("player_has_red_flashing_overlay");
		overlay fadeovertime(0.05);
		overlay.alpha = 0;
		self notify("hit_again");
	}
	return;
}

/*
	Name: redFlashingOverlay
	Namespace: zm_playerhealth
	Checksum: 0x424F4353
	Offset: 0x1490
	Size: 0x250
	Parameters: 1
	Flags: None
	Line Number: 466
*/
function redFlashingOverlay(overlay)
{
	self endon("hit_again");
	self endon("damage");
	self endon("death");
	self endon("disconnect");
	self endon("clear_red_flashing_overlay");
	self.stopFlashingBadlyTime = GetTime() + level.longRegenTime;
	if(!(isdefined(self.is_in_process_of_zombify) && self.is_in_process_of_zombify) && (!(isdefined(self.is_zombie) && self.is_zombie)))
	{
		fadeFunc(overlay, 1, 1, 0);
		while(GetTime() < self.stopFlashingBadlyTime && isalive(self) && (!(isdefined(self.is_in_process_of_zombify) && self.is_in_process_of_zombify) && (!(isdefined(self.is_zombie) && self.is_zombie))))
		{
			fadeFunc(overlay, 0.9, 1, 0);
		}
		if(!(isdefined(self.is_in_process_of_zombify) && self.is_in_process_of_zombify) && (!(isdefined(self.is_zombie) && self.is_zombie)))
		{
			if(isalive(self))
			{
				fadeFunc(overlay, 0.65, 0.8, 0);
			}
			fadeFunc(overlay, 0, 0.6, 1);
		}
	}
	overlay fadeovertime(0.5);
	overlay.alpha = 0;
	self flag::clear("player_has_red_flashing_overlay");
	self clientfield::set_to_player("sndZombieHealth", 0);
	wait(0.5);
	self notify("hit_again");
}

/*
	Name: healthOverlay_remove
	Namespace: zm_playerhealth
	Checksum: 0x424F4353
	Offset: 0x16E8
	Size: 0x70
	Parameters: 1
	Flags: None
	Line Number: 508
*/
function healthOverlay_remove(overlay)
{
	self endon("disconnect");
	self util::waittill_any("noHealthOverlay", "death");
	overlay fadeovertime(3.5);
	overlay.alpha = 0;
}

/*
	Name: empty_kill_func
	Namespace: zm_playerhealth
	Checksum: 0x424F4353
	Offset: 0x1760
	Size: 0x2C
	Parameters: 5
	Flags: None
	Line Number: 526
*/
function empty_kill_func(type, loc, point, attacker, amount)
{
}

