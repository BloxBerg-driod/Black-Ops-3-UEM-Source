#include scripts\codescripts\struct;
#include scripts\shared\aat_shared;
#include scripts\shared\array_shared;
#include scripts\shared\callbacks_shared;
#include scripts\shared\clientfield_shared;
#include scripts\shared\demo_shared;
#include scripts\shared\flag_shared;
#include scripts\shared\laststand_shared;
#include scripts\shared\system_shared;
#include scripts\shared\trigger_shared;
#include scripts\shared\util_shared;
#include scripts\sphynx\leveling\_zm_sphynx_leveling;
#include scripts\zm\_util;
#include scripts\zm\_zm;
#include scripts\zm\_zm_audio;
#include scripts\zm\_zm_bgb;
#include scripts\zm\_zm_equipment;
#include scripts\zm\_zm_laststand;
#include scripts\zm\_zm_magicbox;
#include scripts\zm\_zm_pack_a_punch_util;
#include scripts\zm\_zm_pers_upgrades_functions;
#include scripts\zm\_zm_power;
#include scripts\zm\_zm_score;
#include scripts\zm\_zm_stats;
#include scripts\zm\_zm_unitrigger;
#include scripts\zm\_zm_utility;
#include scripts\zm\_zm_weapon_upgrade_system;
#include scripts\zm\_zm_weapons;

#namespace _zm_pack_a_punch;

/*
	Name: __init__sytem__
	Namespace: _zm_pack_a_punch
	Checksum: 0x424F4353
	Offset: 0x8C8
	Size: 0x40
	Parameters: 0
	Flags: AutoExec
	Line Number: 41
*/
function autoexec __init__sytem__()
{
	system::register("zm_pack_a_punch", &__init__, &__main__, undefined);
}

/*
	Name: __init__
	Namespace: _zm_pack_a_punch
	Checksum: 0x424F4353
	Offset: 0x910
	Size: 0x78
	Parameters: 0
	Flags: None
	Line Number: 56
*/
function __init__()
{
	zm_pap_util::init_parameters();
	clientfield::register("zbarrier", "pap_working_FX", 5000, 1, "int");
	clientfield::register("zbarrier", "pap_light", 5000, 2, "int");
}

/*
	Name: pap_weapon_move_out
	Namespace: _zm_pack_a_punch
	Checksum: 0x424F4353
	Offset: 0x990
	Size: 0x40
	Parameters: 4
	Flags: Private
	Line Number: 73
*/
function private pap_weapon_move_out(player, trigger, origin_offset, interact_offset)
{
	level endon("hash_2e94983b");
	trigger endon("hash_2bdcfec4");
}

/*
	Name: __main__
	Namespace: _zm_pack_a_punch
	Checksum: 0x424F4353
	Offset: 0x9D8
	Size: 0x168
	Parameters: 0
	Flags: None
	Line Number: 89
*/
function __main__()
{
	if(!isdefined(level.pap_zbarrier_state_func))
	{
		level.pap_zbarrier_state_func = &process_pap_zbarrier_state;
	}
	if(tolower(getdvarstring("mapname")) == "zm_zod")
	{
		spawn_init("zod");
	}
	else
	{
		spawn_init();
	}
	vending_weapon_upgrade_trigger = zm_pap_util::get_triggers();
	if(vending_weapon_upgrade_trigger.size >= 1)
	{
		array::thread_all(vending_weapon_upgrade_trigger, &vending_weapon_upgrade);
	}
	old_packs = getentarray("zombie_vending_upgrade", "targetname");
	for(i = 0; i < old_packs.size; i++)
	{
		vending_weapon_upgrade_trigger[vending_weapon_upgrade_trigger.size] = old_packs[i];
	}
	level flag::init("pack_machine_in_use");
}

/*
	Name: spawn_init
	Namespace: _zm_pack_a_punch
	Checksum: 0x424F4353
	Offset: 0xB48
	Size: 0x478
	Parameters: 1
	Flags: Private
	Line Number: 126
*/
function private spawn_init(map)
{
	zbarriers = getentarray("zm_pack_a_punch", "targetname");
	for(i = 0; i < zbarriers.size; i++)
	{
		if(!zbarriers[i] IsZBarrier())
		{
			continue;
		}
		if(!isdefined(level.pack_a_punch.interaction_height))
		{
			level.pack_a_punch.interaction_height = 35;
		}
		if(!isdefined(level.pack_a_punch.interaction_trigger_radius))
		{
			level.pack_a_punch.interaction_trigger_radius = 40;
		}
		if(!isdefined(level.pack_a_punch.interaction_trigger_height))
		{
			level.pack_a_punch.interaction_trigger_height = 70;
		}
		use_trigger = util::spawn_model("tag_origin", zbarriers[i].origin + (0, 0, level.pack_a_punch.interaction_height));
		if(map != "zod")
		{
			use_trigger create_unitrigger(&"ZOMBIE_NEED_POWER", undefined, &function_7e6983a0);
		}
		use_trigger.script_noteworthy = "pack_a_punch";
		use_trigger flag::init("pap_offering_gun");
		collision = spawn("script_model", zbarriers[i].origin, 1);
		collision.angles = zbarriers[i].angles;
		collision setmodel("zm_collision_perks1");
		collision.script_noteworthy = "clip";
		collision disconnectpaths();
		use_trigger.clip = collision;
		use_trigger.zbarrier = zbarriers[i];
		use_trigger.script_sound = "mus_perks_packa_jingle";
		use_trigger.script_label = "mus_perks_packa_sting";
		use_trigger.longJingleWait = 1;
		use_trigger.target = "vending_packapunch";
		use_trigger.zbarrier.targetname = "vending_packapunch";
		powered_on = get_start_state();
		use_trigger.powered = zm_power::add_powered_item(&turn_on, &turn_off, &get_range, &cost_func, 0, powered_on, use_trigger);
		if(isdefined(level.pack_a_punch.custom_power_think))
		{
			use_trigger thread [[level.pack_a_punch.custom_power_think]](powered_on);
		}
		else
		{
			use_trigger thread toggle_think(powered_on);
		}
		if(!isdefined(level.pack_a_punch.triggers))
		{
			level.pack_a_punch.triggers = [];
		}
		else if(!isarray(level.pack_a_punch.triggers))
		{
			level.pack_a_punch.triggers = array(level.pack_a_punch.triggers);
		}
		level.pack_a_punch.triggers[level.pack_a_punch.triggers.size] = use_trigger;
	}
}

/*
	Name: function_7e6983a0
	Namespace: _zm_pack_a_punch
	Checksum: 0x424F4353
	Offset: 0xFC8
	Size: 0x400
	Parameters: 1
	Flags: None
	Line Number: 198
*/
function function_7e6983a0(player)
{
	if(self.stub.related_parent.zbarrier.state == "powered")
	{
		var_7750a3aa = player namespace_5e1f56dc::function_1239e0ad(player getcurrentweapon());
		if(isdefined(var_7750a3aa))
		{
			if(var_7750a3aa.var_a39a2843 == 1)
			{
				player.var_439d3100 = 10000;
			}
			if(var_7750a3aa.var_a39a2843 == 2)
			{
				player.var_439d3100 = 15000;
			}
			if(var_7750a3aa.var_a39a2843 == 3)
			{
				player.var_439d3100 = 30000;
			}
			if(var_7750a3aa.var_a39a2843 == 4)
			{
				player.var_439d3100 = 50000;
			}
			if(var_7750a3aa.var_a39a2843 == 5)
			{
				player.var_439d3100 = 75000;
			}
			if(var_7750a3aa.var_a39a2843 == 6)
			{
				player.var_439d3100 = 100000;
			}
			if(var_7750a3aa.var_a39a2843 == 7)
			{
				player.var_439d3100 = 125000;
			}
			if(var_7750a3aa.var_a39a2843 == 8)
			{
				player.var_439d3100 = 150000;
			}
			if(var_7750a3aa.var_a39a2843 == 9)
			{
				player.var_439d3100 = 175000;
			}
			if(var_7750a3aa.var_a39a2843 == 10)
			{
				player.var_439d3100 = 200000;
			}
		}
		else
		{
			player.var_439d3100 = 5000;
		}
		if(isdefined(level.var_919b0320) && level.var_919b0320)
		{
			self sethintstring(&"ZM_MINECRAFT_HINTSTRING_PAP_DISABLED");
			return 0;
		}
		if(zm_weapons::is_weapon_upgraded(player getcurrentweapon()) && isdefined(var_7750a3aa) && var_7750a3aa.var_a39a2843 >= level.var_7ceb1b41)
		{
			self sethintstring(&"ZM_MINECRAFT_HINTSTRING_CANNOT_USE_PAP_WEAPON_MAX");
			return 0;
		}
		else if(!(isdefined(player player_use_can_pack_now()) && player player_use_can_pack_now()))
		{
			self sethintstring(&"ZM_MINECRAFT_HINTSTRING_CANNOT_USE_PAP_WEAPON");
			return 0;
		}
		else if(!player zm_score::can_player_purchase(player.var_439d3100))
		{
			self sethintstring(&"ZM_MINECRAFT_HINTSTRING_PAP_NO_MONEY", player.var_439d3100);
			return 0;
		}
		else
		{
			self sethintstring(&"ZM_MINECRAFT_HINTSTRING_CAN_PACK_A_PUNCH", player.var_439d3100);
			return 1;
		}
	}
	else
	{
		self sethintstring(&"ZOMBIE_NEED_POWER");
		return 0;
	}
}

/*
	Name: player_use_can_pack_now
	Namespace: _zm_pack_a_punch
	Checksum: 0x424F4353
	Offset: 0x13D0
	Size: 0x2F0
	Parameters: 0
	Flags: Private
	Line Number: 293
*/
function private player_use_can_pack_now()
{
	if(self laststand::player_is_in_laststand() || (isdefined(self.intermission) && self.intermission) || self IsThrowingGrenade())
	{
		return 0;
	}
	if(!self zm_magicbox::can_buy_weapon() || self bgb::is_enabled("zm_bgb_disorderly_combat") || zm_utility::is_hero_weapon(self getcurrentweapon()))
	{
		return 0;
	}
	if(!zm_utility::is_player_valid(self) || self.is_drinking > 0 || zm_utility::is_placeable_mine(self getcurrentweapon()) || zm_equipment::is_equipment(self getcurrentweapon()) || self zm_utility::is_player_revive_tool(self getcurrentweapon()) || level.weaponnone == self getcurrentweapon() || self zm_equipment::hacker_active())
	{
		return 0;
	}
	if(self getcurrentweapon().isRiotShield)
	{
		return 0;
	}
	weapon = self zm_weapons::get_nonalternate_weapon(self getcurrentweapon());
	if(!zm_weapons::is_weapon_or_base_included(self getcurrentweapon()))
	{
		return 0;
	}
	if(tolower(getdvarstring("mapname")) != "zm_zod")
	{
		if(!zm_weapons::is_weapon_upgraded(self getcurrentweapon()) && !self zm_weapons::can_upgrade_weapon(self getcurrentweapon()))
		{
			return 0;
		}
	}
	if(isdefined(self getcurrentweapon() namespace_5e1f56dc::function_25b21deb()) && self getcurrentweapon() namespace_5e1f56dc::function_25b21deb())
	{
		return 0;
	}
	return 1;
}

/*
	Name: pap_trigger_hintstring_monitor
	Namespace: _zm_pack_a_punch
	Checksum: 0x424F4353
	Offset: 0x16C8
	Size: 0xE8
	Parameters: 0
	Flags: Private
	Line Number: 340
*/
function private pap_trigger_hintstring_monitor()
{
	level endon("Pack_A_Punch_off");
	level waittill("Pack_A_Punch_on");
	self thread pap_trigger_hintstring_monitor_reset();
	while(1)
	{
		foreach(e_player in level.players)
		{
			if(e_player istouching(self))
			{
				self zm_pap_util::update_hint_string(e_player);
			}
		}
		wait(0.05);
	}
}

/*
	Name: pap_trigger_hintstring_monitor_reset
	Namespace: _zm_pack_a_punch
	Checksum: 0x424F4353
	Offset: 0x17B8
	Size: 0x28
	Parameters: 0
	Flags: Private
	Line Number: 368
*/
function private pap_trigger_hintstring_monitor_reset()
{
	level waittill("Pack_A_Punch_off");
	self thread pap_trigger_hintstring_monitor();
	return;
	ERROR: Exception occured: Index was out of range. Must be non-negative and less than the size of the collection.
Parameter name: index
}

/*
	Name: third_person_weapon_upgrade
	Namespace: _zm_pack_a_punch
	Checksum: 0x424F4353
	Offset: 0x17E8
	Size: 0x4C0
	Parameters: 5
	Flags: Private
	Line Number: 387
*/
function private third_person_weapon_upgrade(current_weapon, upgrade_weapon, packa_rollers, pap_machine, trigger)
{
	level endon("Pack_A_Punch_off");
	trigger endon("pap_player_disconnected");
	current_weapon = self getbuildkitweapon(current_weapon, 0);
	upgrade_weapon = self getbuildkitweapon(upgrade_weapon, 1);
	trigger.current_weapon = current_weapon;
	trigger.current_weapon_options = self getbuildkitweaponoptions(trigger.current_weapon);
	trigger.current_weapon_acvi = self getbuildkitattachmentcosmeticvariantindexes(trigger.current_weapon, 0);
	trigger.upgrade_weapon = upgrade_weapon;
	upgrade_weapon.pap_camo_to_use = zm_weapons::get_pack_a_punch_camo_index(upgrade_weapon.pap_camo_to_use);
	trigger.upgrade_weapon_options = self getbuildkitweaponoptions(trigger.upgrade_weapon, upgrade_weapon.pap_camo_to_use);
	trigger.upgrade_weapon_acvi = self getbuildkitattachmentcosmeticvariantindexes(trigger.upgrade_weapon, 1);
	trigger.zbarrier setWeapon(trigger.current_weapon);
	trigger.zbarrier SetWeaponOptions(trigger.current_weapon_options);
	trigger.zbarrier SetAttachmentCosmeticVariantIndexes(trigger.current_weapon_acvi);
	trigger.zbarrier set_pap_zbarrier_state("take_gun");
	rel_entity = trigger.pap_machine;
	origin_offset = (0, 0, 0);
	angles_offset = (0, 0, 0);
	origin_base = self.origin;
	angles_base = self.angles;
	if(isdefined(rel_entity))
	{
		origin_offset = (0, 0, level.pack_a_punch.interaction_height);
		angles_offset = VectorScale((0, 1, 0), 90);
		origin_base = rel_entity.origin;
		angles_base = rel_entity.angles;
	}
	else
	{
		rel_entity = self;
	}
	forward = anglestoforward(angles_base + angles_offset);
	interact_offset = origin_offset + forward * -25;
	offsetdw = VectorScale((1, 1, 1), 3);
	pap_machine [[level.pack_a_punch.move_in_func]](self, trigger, origin_offset, angles_offset);
	self playsound("zmb_perks_packa_upgrade");
	wait(0.35);
	wait(3);
	trigger.zbarrier setWeapon(upgrade_weapon);
	trigger.zbarrier SetWeaponOptions(trigger.upgrade_weapon_options);
	trigger.zbarrier SetAttachmentCosmeticVariantIndexes(trigger.upgrade_weapon_acvi);
	trigger.zbarrier set_pap_zbarrier_state("eject_gun");
	if(isdefined(self))
	{
		self playsound("zmb_perks_packa_ready");
		return;
	}
	else
	{
	}
	rel_entity thread [[level.pack_a_punch.move_out_func]](self, trigger, origin_offset, interact_offset);
}

/*
	Name: can_pack_weapon
	Namespace: _zm_pack_a_punch
	Checksum: 0x424F4353
	Offset: 0x1CB0
	Size: 0xE8
	Parameters: 1
	Flags: Private
	Line Number: 452
*/
function private can_pack_weapon(weapon)
{
	if(weapon.isRiotShield)
	{
		return 0;
	}
	if(level flag::get("pack_machine_in_use"))
	{
		return 1;
	}
	if(!(isdefined(level.b_allow_idgun_pap) && level.b_allow_idgun_pap) && isdefined(level.idgun_weapons))
	{
		if(isinarray(level.idgun_weapons, weapon))
		{
			return 0;
		}
	}
	weapon = self zm_weapons::get_nonalternate_weapon(weapon);
	if(!zm_weapons::is_weapon_or_base_included(weapon))
	{
		return 0;
	}
	if(!self zm_weapons::can_upgrade_weapon(weapon))
	{
		return 0;
	}
	return 1;
}

/*
	Name: pack_a_punch_machine_trigger_think
	Namespace: _zm_pack_a_punch
	Checksum: 0x424F4353
	Offset: 0x1DA0
	Size: 0x148
	Parameters: 0
	Flags: Private
	Line Number: 491
*/
function private pack_a_punch_machine_trigger_think()
{
	self endon("death");
	self endon("Pack_A_Punch_off");
	self notify("pack_a_punch_trigger_think");
	self endon("pack_a_punch_trigger_think");
	while(1)
	{
		players = getplayers();
		for(i = 0; i < players.size; i++)
		{
			if(isdefined(self.pack_player) && self.pack_player != players[i] || !players[i] player_use_can_pack_now() || players[i] bgb::is_active("zm_bgb_ephemeral_enhancement"))
			{
				self setinvisibletoplayer(players[i], 1);
				continue;
			}
			self setinvisibletoplayer(players[i], 0);
		}
		wait(0.1);
	}
}

/*
	Name: vending_weapon_upgrade
	Namespace: _zm_pack_a_punch
	Checksum: 0x424F4353
	Offset: 0x1EF0
	Size: 0xA68
	Parameters: 0
	Flags: Private
	Line Number: 523
*/
function private vending_weapon_upgrade()
{
	level endon("Pack_A_Punch_off");
	pap_machine = getent(self.target, "targetname");
	self.pap_machine = pap_machine;
	pap_machine_sound = getentarray("perksacola", "targetname");
	packa_rollers = spawn("script_origin", self.origin);
	packa_timer = spawn("script_origin", self.origin);
	packa_rollers linkto(self);
	packa_timer linkto(self);
	power_off = !self is_on();
	if(power_off)
	{
		pap_array = [];
		pap_array[0] = pap_machine;
		level waittill("Pack_A_Punch_on");
	}
	if(isdefined(level.pack_a_punch.power_on_callback))
	{
		pap_machine thread [[level.pack_a_punch.power_on_callback]]();
	}
	self thread pack_a_punch_machine_trigger_think();
	pap_machine playloopsound("zmb_perks_packa_loop");
	self thread shutOffPAPSounds(pap_machine, packa_rollers, packa_timer);
	for(;;)
	{
		self.pack_player = undefined;
		self waittill("trigger_activated", player);
		if(isdefined(pap_machine.state) && pap_machine.state == "leaving")
		{
		}
		else
		{
			index = zm_utility::get_player_index(player);
			current_weapon = player getcurrentweapon();
			current_weapon = player zm_weapons::switch_from_alt_weapon(current_weapon);
			if(!(isdefined(player player_use_can_pack_now()) && player player_use_can_pack_now()))
			{
			}
			else
			{
				current_cost = player.var_439d3100;
				if(!player zm_score::can_player_purchase(current_cost))
				{
					self playsound("zmb_perks_packa_deny");
					if(isdefined(level.pack_a_punch.custom_deny_func))
					{
						player [[level.pack_a_punch.custom_deny_func]]();
					}
					else
					{
						player zm_audio::create_and_play_dialog("general", "outofmoney", 0);
					}
				}
				else
				{
					player zm_stats::increment_client_stat("use_pap");
					player zm_stats::increment_player_stat("use_pap");
					player thread namespace_97ac1184::function_1d39abf6("end_game_use_pap", 1, 0);
					player thread namespace_97ac1184::function_7e18304e("spx_save_data", "use_pap", player.pers["use_pap"], 0);
					player zm_score::minus_to_player_score(current_cost);
					sound = "evt_bottle_dispense";
					playsoundatposition(sound, self.origin);
					self thread zm_audio::sndPerksJingles_Player(1);
					player zm_audio::create_and_play_dialog("general", "pap_wait");
					var_7750a3aa = player namespace_5e1f56dc::function_1239e0ad(current_weapon);
					var_12030910 = zm_weapons::get_upgrade_weapon(current_weapon, 0);
					var_ed5e1bff = player namespace_5e1f56dc::function_e942fd68(var_12030910);
					if(isdefined(var_7750a3aa))
					{
						if(isdefined(var_7750a3aa.var_a39a2843) && var_7750a3aa.var_a39a2843 < level.var_7ceb1b41)
						{
							var_7750a3aa.var_a39a2843 = var_7750a3aa.var_a39a2843 + 1;
							if(player.pers["highest_enchantment"] > var_7750a3aa.var_a39a2843)
							{
							}
							else
							{
								player.pers["highest_enchantment"] = var_7750a3aa.var_a39a2843;
								player thread namespace_97ac1184::function_7e18304e("spx_save_data", "highest_enchantment", player.pers["highest_enchantment"], 0);
							}
							if(var_7750a3aa.var_a39a2843 > player.var_ddbf6bf2)
							{
								player.var_ddbf6bf2++;
								player notify("hash_79ef118b", "milestone_completed_enchantment_" + var_7750a3aa.var_a39a2843, undefined);
							}
							player thread namespace_97ac1184::function_b3489bf5("^3" + player.playername + "^7 Pack-a-Punched to ^9" + var_7750a3aa namespace_5e1f56dc::function_3ce97289() + " ^7on " + makelocalizedstring(var_7750a3aa.stored_weapon.displayname));
							player namespace_5e1f56dc::function_febfc6ba(current_weapon);
						}
					}
					else if(isdefined(player.var_c6452f46["weapon"]) && player.var_c6452f46["weapon"])
					{
						if(!(isdefined(var_ed5e1bff) && var_ed5e1bff))
						{
							if(isdefined(player namespace_5e1f56dc::function_c3370d47(var_12030910)) && player namespace_5e1f56dc::function_c3370d47(var_12030910))
							{
								var_de6974d4 = spawnstruct();
								var_de6974d4.stored_weapon = var_12030910.rootweapon;
								var_de6974d4.var_79fe8f18 = 0;
								var_de6974d4.var_4c25c2f2 = 0;
								var_de6974d4.pap_camo_to_use = level.var_1e656cc4[var_de6974d4.var_4c25c2f2];
								player.var_3818be12[player.var_3818be12.size] = var_de6974d4;
							}
						}
					}
					if(!(isdefined(var_7750a3aa) && var_7750a3aa))
					{
						var_d2433c1d = spawnstruct();
						var_d2433c1d.stored_weapon = var_12030910.rootweapon;
						var_a76169e6 = namespace_5e1f56dc::function_49e2047b();
						var_d2433c1d.var_a39a2843 = var_a76169e6;
						player.var_fb56a719[player.var_fb56a719.size] = var_d2433c1d;
					}
					player takeweapon(current_weapon);
					player giveweapon(var_12030910, player zm_weapons::get_pack_a_punch_weapon_options(var_12030910));
					if(var_12030910.start_ammo != var_12030910.maxAmmo)
					{
						if(player hasperk("specialty_extraammo"))
						{
							player givemaxammo(var_12030910);
						}
						else
						{
							player givestartammo(var_12030910);
						}
					}
					else
					{
						player givemaxammo(var_12030910);
					}
					player switchtoweapon(var_12030910);
					player thread namespace_97ac1184::function_b3489bf5("^3" + player.playername + "^7 Pack-a-Punched to ^9" + var_d2433c1d namespace_5e1f56dc::function_3ce97289() + " ^7on " + makelocalizedstring(var_d2433c1d.stored_weapon.displayname));
					zm_utility::play_sound_at_pos("zmb_perks_packa_ready", player);
				}
			}
		}
	}
}

/*
	Name: shutOffPAPSounds
	Namespace: _zm_pack_a_punch
	Checksum: 0x424F4353
	Offset: 0x2960
	Size: 0xB0
	Parameters: 3
	Flags: Private
	Line Number: 672
*/
function private shutOffPAPSounds(ent1, ent2, ent3)
{
	while(1)
	{
		level waittill("Pack_A_Punch_off");
		level thread turnOnPAPSounds(ent1);
		ent1 stoploopsound(0.1);
		ent2 stoploopsound(0.1);
		ent3 stoploopsound(0.1);
	}
}

/*
	Name: turnOnPAPSounds
	Namespace: _zm_pack_a_punch
	Checksum: 0x424F4353
	Offset: 0x2A18
	Size: 0x38
	Parameters: 1
	Flags: Private
	Line Number: 694
*/
function private turnOnPAPSounds(ent)
{
	level waittill("Pack_A_Punch_on");
	ent playloopsound("zmb_perks_packa_loop");
	return;
}

/*
	Name: vending_weapon_upgrade_cost
	Namespace: _zm_pack_a_punch
	Checksum: 0x424F4353
	Offset: 0x2A58
	Size: 0x68
	Parameters: 0
	Flags: Private
	Line Number: 711
*/
function private vending_weapon_upgrade_cost()
{
	level endon("Pack_A_Punch_off");
	while(1)
	{
		self.cost = 5000;
		self.aat_cost = 2500;
		level waittill("powerup bonfire sale");
		self.cost = 1000;
		self.aat_cost = 500;
		level waittill("bonfire_sale_off");
	}
}

/*
	Name: wait_for_player_to_take
	Namespace: _zm_pack_a_punch
	Checksum: 0x424F4353
	Offset: 0x2AC8
	Size: 0x650
	Parameters: 5
	Flags: Private
	Line Number: 735
*/
function private wait_for_player_to_take(player, weapon, packa_timer, b_weapon_supports_aat, isRepack)
{
	current_weapon = self.current_weapon;
	upgrade_weapon = self.upgrade_weapon;
	/#
		Assert(isdefined(current_weapon), "Dev Block strings are not supported");
	#/
	/#
		Assert(isdefined(upgrade_weapon), "Dev Block strings are not supported");
	#/
	self endon("pap_timeout");
	level endon("Pack_A_Punch_off");
	while(isdefined(player))
	{
		packa_timer playloopsound("zmb_perks_packa_ticktock");
		self waittill("trigger", trigger_player);
		if(level.pack_a_punch.grabbable_by_anyone)
		{
			player = trigger_player;
		}
		packa_timer stoploopsound(0.05);
		if(trigger_player == player)
		{
			player zm_stats::increment_client_stat("pap_weapon_grabbed");
			player zm_stats::increment_player_stat("pap_weapon_grabbed");
			current_weapon = player getcurrentweapon();
			/#
				if(level.weaponnone == current_weapon)
				{
					iprintlnbold("Dev Block strings are not supported");
				}
			#/
			if(zm_utility::is_player_valid(player) && !player.is_drinking > 0 && !zm_utility::is_placeable_mine(current_weapon) && !zm_equipment::is_equipment(current_weapon) && !player zm_utility::is_player_revive_tool(current_weapon) && level.weaponnone != current_weapon && !player zm_equipment::hacker_active())
			{
				demo::bookmark("zm_player_grabbed_packapunch", GetTime(), player);
				self notify("pap_taken");
				player notify("pap_taken");
				player.pap_used = 1;
				weapon_limit = zm_utility::get_player_weapon_limit(player);
				player zm_weapons::take_fallback_weapon();
				Primaries = player getweaponslistprimaries();
				if(isdefined(Primaries) && Primaries.size >= weapon_limit)
				{
					upgrade_weapon = player zm_weapons::weapon_give(upgrade_weapon);
				}
				else
				{
					upgrade_weapon = player zm_weapons::give_build_kit_weapon(upgrade_weapon);
					player givestartammo(upgrade_weapon);
				}
				player notify("weapon_give", upgrade_weapon);
				aatID = -1;
				if(isdefined(b_weapon_supports_aat) && b_weapon_supports_aat)
				{
					player thread aat::acquire(upgrade_weapon);
					aatObj = player aat::getAATOnWeapon(upgrade_weapon);
					if(isdefined(aatObj))
					{
						aatID = aatObj.hash_id;
					}
				}
				else
				{
					player thread aat::remove(upgrade_weapon);
				}
				weaponIdx = undefined;
				if(isdefined(weapon))
				{
					weaponIdx = MatchRecordGetWeaponIndex(weapon);
				}
				if(isdefined(weaponIdx))
				{
					if(!isRepack)
					{
						player RecordMapEvent(27, GetTime(), player.origin, level.round_number, weaponIdx, aatID);
					}
					else
					{
						player RecordMapEvent(28, GetTime(), player.origin, level.round_number, weaponIdx, aatID);
					}
				}
				player switchtoweapon(upgrade_weapon);
				if(isdefined(player.restore_ammo) && player.restore_ammo)
				{
					new_clip = player.restore_clip + upgrade_weapon.clipsize - player.restore_clip_size;
					new_stock = player.restore_stock + upgrade_weapon.maxAmmo - player.restore_max;
					player setweaponammostock(upgrade_weapon, new_stock);
					player setweaponammoclip(upgrade_weapon, new_clip);
				}
				player.restore_ammo = undefined;
				player.restore_clip = undefined;
				player.restore_stock = undefined;
				player.restore_max = undefined;
				player.restore_clip_size = undefined;
				player zm_weapons::play_weapon_vo(upgrade_weapon);
				return;
			}
		}
		wait(0.05);
	}
}

/*
	Name: wait_for_timeout
	Namespace: _zm_pack_a_punch
	Checksum: 0x424F4353
	Offset: 0x3120
	Size: 0x208
	Parameters: 4
	Flags: Private
	Line Number: 847
*/
function private wait_for_timeout(weapon, packa_timer, player, isRepack)
{
	self endon("pap_taken");
	self endon("pap_player_disconnected");
	self thread wait_for_disconnect(player);
	wait(level.pack_a_punch.timeout);
	self notify("pap_timeout");
	packa_timer stoploopsound(0.05);
	packa_timer playsound("zmb_perks_packa_deny");
	if(isdefined(player))
	{
		player zm_stats::increment_client_stat("pap_weapon_not_grabbed");
		player zm_stats::increment_player_stat("pap_weapon_not_grabbed");
		weaponIdx = undefined;
		if(isdefined(weapon))
		{
			weaponIdx = MatchRecordGetWeaponIndex(weapon);
		}
		if(isdefined(weaponIdx))
		{
			if(!isRepack)
			{
				player RecordMapEvent(20, GetTime(), player.origin, level.round_number, weaponIdx);
			}
			else
			{
				aatOnWeapon = player aat::getAATOnWeapon(weapon);
				aatHash = -1;
				if(isdefined(aatOnWeapon))
				{
					aatHash = aatOnWeapon.hash_id;
				}
				player RecordMapEvent(26, GetTime(), player.origin, level.round_number, weaponIdx, aatHash);
			}
		}
	}
}

/*
	Name: wait_for_disconnect
	Namespace: _zm_pack_a_punch
	Checksum: 0x424F4353
	Offset: 0x3330
	Size: 0x68
	Parameters: 1
	Flags: Private
	Line Number: 895
*/
function private wait_for_disconnect(player)
{
	self endon("pap_taken");
	self endon("pap_timeout");
	while(isdefined(player))
	{
		wait(0.1);
	}
	/#
		println("Dev Block strings are not supported");
	#/
	self notify("pap_player_disconnected");
	return;
	ERROR: Exception occured: Stack empty.
}

/*
	Name: destroy_weapon_in_blackout
	Namespace: _zm_pack_a_punch
	Checksum: 0x424F4353
	Offset: 0x33A0
	Size: 0xA8
	Parameters: 1
	Flags: Private
	Line Number: 921
*/
function private destroy_weapon_in_blackout(player)
{
	self endon("pap_timeout");
	self endon("pap_taken");
	self endon("pap_player_disconnected");
	level waittill("Pack_A_Punch_off");
	self.zbarrier set_pap_zbarrier_state("take_gun");
	player playlocalsound(level.zmb_laugh_alias);
	wait(1.5);
	self.zbarrier set_pap_zbarrier_state("power_off");
	return;
}

/*
	Name: do_knuckle_crack
	Namespace: _zm_pack_a_punch
	Checksum: 0x424F4353
	Offset: 0x3450
	Size: 0x78
	Parameters: 0
	Flags: Private
	Line Number: 944
*/
function private do_knuckle_crack()
{
	self endon("disconnect");
	self upgrade_knuckle_crack_begin();
	self util::waittill_any("fake_death", "death", "player_downed", "weapon_change_complete");
	self upgrade_knuckle_crack_end();
	return;
}

/*
	Name: upgrade_knuckle_crack_begin
	Namespace: _zm_pack_a_punch
	Checksum: 0x424F4353
	Offset: 0x34D0
	Size: 0x140
	Parameters: 0
	Flags: Private
	Line Number: 963
*/
function private upgrade_knuckle_crack_begin()
{
	self zm_utility::increment_is_drinking();
	self zm_utility::disable_player_move_states(1);
	Primaries = self getweaponslistprimaries();
	original_weapon = self getcurrentweapon();
	weapon = getweapon("zombie_knuckle_crack");
	if(original_weapon != level.weaponnone && !zm_utility::is_placeable_mine(original_weapon) && !zm_equipment::is_equipment(original_weapon))
	{
		self notify("zmb_lost_knife");
		self takeweapon(original_weapon);
		return;
	}
	else
	{
	}
	self giveweapon(weapon);
	self switchtoweapon(weapon);
}

/*
	Name: upgrade_knuckle_crack_end
	Namespace: _zm_pack_a_punch
	Checksum: 0x424F4353
	Offset: 0x3618
	Size: 0x108
	Parameters: 0
	Flags: Private
	Line Number: 993
*/
function private upgrade_knuckle_crack_end()
{
	self zm_utility::enable_player_move_states();
	weapon = getweapon("zombie_knuckle_crack");
	if(self laststand::player_is_in_laststand() || (isdefined(self.intermission) && self.intermission))
	{
		self takeweapon(weapon);
		return;
	}
	self zm_utility::decrement_is_drinking();
	self takeweapon(weapon);
	Primaries = self getweaponslistprimaries();
	if(self.is_drinking > 0)
	{
		return;
	}
	else
	{
		self zm_weapons::switch_back_primary_weapon();
	}
}

/*
	Name: get_range
	Namespace: _zm_pack_a_punch
	Checksum: 0x424F4353
	Offset: 0x3728
	Size: 0xF8
	Parameters: 3
	Flags: Private
	Line Number: 1025
*/
function private get_range(delta, origin, radius)
{
	if(isdefined(self.target))
	{
		paporigin = self.target.origin;
		if(isdefined(self.target.trigger_off) && self.target.trigger_off)
		{
			paporigin = self.target.realorigin;
		}
		else if(isdefined(self.target.disabled) && self.target.disabled)
		{
			paporigin = paporigin + VectorScale((0, 0, 1), 10000);
		}
		if(distancesquared(paporigin, origin) < radius * radius)
		{
			return 1;
		}
	}
	return 0;
	ERROR: Bad function call
}

/*
	Name: turn_on
	Namespace: _zm_pack_a_punch
	Checksum: 0x424F4353
	Offset: 0x3828
	Size: 0x48
	Parameters: 2
	Flags: Private
	Line Number: 1057
*/
function private turn_on(origin, radius)
{
	/#
		println("Dev Block strings are not supported");
	#/
	level notify("Pack_A_Punch_on");
}

/*
	Name: turn_off
	Namespace: _zm_pack_a_punch
	Checksum: 0x424F4353
	Offset: 0x3878
	Size: 0x70
	Parameters: 2
	Flags: Private
	Line Number: 1075
*/
function private turn_off(origin, radius)
{
	/#
		println("Dev Block strings are not supported");
	#/
	level notify("Pack_A_Punch_off");
	self.target notify("death");
	self.target thread vending_weapon_upgrade();
	return;
	ERROR: Exception occured: Stack empty.
}

/*
	Name: is_on
	Namespace: _zm_pack_a_punch
	Checksum: 0x424F4353
	Offset: 0x38F0
	Size: 0x28
	Parameters: 0
	Flags: Private
	Line Number: 1097
*/
function private is_on()
{
	if(isdefined(self.powered))
	{
		return self.powered.power;
	}
	return 0;
}

/*
	Name: get_start_state
	Namespace: _zm_pack_a_punch
	Checksum: 0x424F4353
	Offset: 0x3920
	Size: 0x28
	Parameters: 0
	Flags: Private
	Line Number: 1116
*/
function private get_start_state()
{
	if(isdefined(level.vending_machines_powered_on_at_start) && level.vending_machines_powered_on_at_start)
	{
		return 1;
	}
	return 0;
}

/*
	Name: cost_func
	Namespace: _zm_pack_a_punch
	Checksum: 0x424F4353
	Offset: 0x3950
	Size: 0x70
	Parameters: 0
	Flags: Private
	Line Number: 1135
*/
function private cost_func()
{
	if(isdefined(self.one_time_cost))
	{
		cost = self.one_time_cost;
		self.one_time_cost = undefined;
		return cost;
	}
	if(isdefined(level._power_global) && level._power_global)
	{
		return 0;
	}
	if(isdefined(self.self_powered) && self.self_powered)
	{
		return 0;
	}
	return 1;
}

/*
	Name: toggle_think
	Namespace: _zm_pack_a_punch
	Checksum: 0x424F4353
	Offset: 0x39C8
	Size: 0xA8
	Parameters: 1
	Flags: Private
	Line Number: 1164
*/
function private toggle_think(powered_on)
{
	if(!powered_on)
	{
		self.zbarrier set_pap_zbarrier_state("initial");
		level waittill("Pack_A_Punch_on");
	}
	for(;;)
	{
		self.zbarrier set_pap_zbarrier_state("power_on");
		level waittill("Pack_A_Punch_off");
		self.zbarrier set_pap_zbarrier_state("power_off");
		level waittill("Pack_A_Punch_on");
	}
}

/*
	Name: pap_initial
	Namespace: _zm_pack_a_punch
	Checksum: 0x424F4353
	Offset: 0x3A78
	Size: 0x40
	Parameters: 0
	Flags: Private
	Line Number: 1190
*/
function private pap_initial()
{
	self ZBarrierPieceUseAttachWeapon(3);
	self SetZBarrierPieceState(0, "closed");
}

/*
	Name: pap_power_off
	Namespace: _zm_pack_a_punch
	Checksum: 0x424F4353
	Offset: 0x3AC0
	Size: 0x28
	Parameters: 0
	Flags: Private
	Line Number: 1206
*/
function private pap_power_off()
{
	self SetZBarrierPieceState(0, "closing");
}

/*
	Name: pap_power_on
	Namespace: _zm_pack_a_punch
	Checksum: 0x424F4353
	Offset: 0x3AF0
	Size: 0xA0
	Parameters: 0
	Flags: Private
	Line Number: 1221
*/
function private pap_power_on()
{
	self endon("zbarrier_state_change");
	self SetZBarrierPieceState(0, "opening");
	while(self GetZBarrierPieceState(0) == "opening")
	{
		wait(0.05);
	}
	self playsound("zmb_perks_power_on");
	self thread set_pap_zbarrier_state("powered");
	return;
}

/*
	Name: pap_powered
	Namespace: _zm_pack_a_punch
	Checksum: 0x424F4353
	Offset: 0x3B98
	Size: 0xF0
	Parameters: 0
	Flags: Private
	Line Number: 1244
*/
function private pap_powered()
{
	self endon("zbarrier_state_change");
	self SetZBarrierPieceState(4, "closed");
	if(self.classname === "zbarrier_zm_castle_packapunch" || self.classname === "zbarrier_zm_tomb_packapunch")
	{
		self clientfield::set("pap_working_FX", 0);
	}
	while(1)
	{
		wait(randomfloatrange(180, 1800));
		self SetZBarrierPieceState(4, "opening");
		wait(randomfloatrange(180, 1800));
		self SetZBarrierPieceState(4, "closing");
	}
}

/*
	Name: pap_take_gun
	Namespace: _zm_pack_a_punch
	Checksum: 0x424F4353
	Offset: 0x3C90
	Size: 0xB8
	Parameters: 0
	Flags: Private
	Line Number: 1271
*/
function private pap_take_gun()
{
	self SetZBarrierPieceState(1, "opening");
	self SetZBarrierPieceState(2, "opening");
	self SetZBarrierPieceState(3, "opening");
	wait(0.1);
	if(self.classname === "zbarrier_zm_castle_packapunch" || self.classname === "zbarrier_zm_tomb_packapunch")
	{
		self clientfield::set("pap_working_FX", 1);
	}
}

/*
	Name: pap_eject_gun
	Namespace: _zm_pack_a_punch
	Checksum: 0x424F4353
	Offset: 0x3D50
	Size: 0x68
	Parameters: 0
	Flags: Private
	Line Number: 1293
*/
function private pap_eject_gun()
{
	self SetZBarrierPieceState(1, "closing");
	self SetZBarrierPieceState(2, "closing");
	self SetZBarrierPieceState(3, "closing");
}

/*
	Name: pap_leaving
	Namespace: _zm_pack_a_punch
	Checksum: 0x424F4353
	Offset: 0x3DC0
	Size: 0x88
	Parameters: 0
	Flags: Private
	Line Number: 1310
*/
function private pap_leaving()
{
	self SetZBarrierPieceState(5, "closing");
	do
	{
		wait(0.05);
	}
	while(!self GetZBarrierPieceState(5) == "closing");
	self SetZBarrierPieceState(5, "closed");
	self notify("leave_anim_done");
}

/*
	Name: pap_arriving
	Namespace: _zm_pack_a_punch
	Checksum: 0x424F4353
	Offset: 0x3E50
	Size: 0xA0
	Parameters: 0
	Flags: Private
	Line Number: 1332
*/
function private pap_arriving()
{
	self endon("zbarrier_state_change");
	self SetZBarrierPieceState(0, "opening");
	while(self GetZBarrierPieceState(0) == "opening")
	{
		wait(0.05);
	}
	self playsound("zmb_perks_power_on");
	self thread set_pap_zbarrier_state("powered");
}

/*
	Name: get_pap_zbarrier_state
	Namespace: _zm_pack_a_punch
	Checksum: 0x424F4353
	Offset: 0x3EF8
	Size: 0x10
	Parameters: 0
	Flags: Private
	Line Number: 1354
*/
function private get_pap_zbarrier_state()
{
	return self.state;
}

/*
	Name: set_pap_zbarrier_state
	Namespace: _zm_pack_a_punch
	Checksum: 0x424F4353
	Offset: 0x3F10
	Size: 0x80
	Parameters: 1
	Flags: Private
	Line Number: 1369
*/
function private set_pap_zbarrier_state(state)
{
	for(i = 0; i < self getnumzbarrierpieces(); i++)
	{
		self hidezbarrierpiece(i);
	}
	self notify("zbarrier_state_change");
	self [[level.pap_zbarrier_state_func]](state);
}

/*
	Name: process_pap_zbarrier_state
	Namespace: _zm_pack_a_punch
	Checksum: 0x424F4353
	Offset: 0x3F98
	Size: 0x328
	Parameters: 1
	Flags: Private
	Line Number: 1389
*/
function private process_pap_zbarrier_state(state)
{
	switch(state)
	{
		case "initial":
		{
			self ShowZBarrierPiece(0);
			self thread pap_initial();
			self.state = "initial";
			break;
		}
		case "power_off":
		{
			self ShowZBarrierPiece(0);
			self thread pap_power_off();
			self.state = "power_off";
			break;
		}
		case "power_on":
		{
			self ShowZBarrierPiece(0);
			self thread pap_power_on();
			self.state = "power_on";
			break;
		}
		case "powered":
		{
			self ShowZBarrierPiece(4);
			self thread pap_powered();
			self.state = "powered";
			break;
		}
		case "take_gun":
		{
			self ShowZBarrierPiece(1);
			self ShowZBarrierPiece(2);
			self ShowZBarrierPiece(3);
			self thread pap_take_gun();
			self.state = "take_gun";
			break;
		}
		case "eject_gun":
		{
			self ShowZBarrierPiece(1);
			self ShowZBarrierPiece(2);
			self ShowZBarrierPiece(3);
			self thread pap_eject_gun();
			self.state = "eject_gun";
			break;
		}
		case "leaving":
		{
			self ShowZBarrierPiece(5);
			self thread pap_leaving();
			self.state = "leaving";
			break;
		}
		case "arriving":
		{
			self ShowZBarrierPiece(0);
			self thread pap_arriving();
			self.state = "arriving";
			break;
		}
		case "hidden":
		{
			self.state = "hidden";
			break;
		}
		default
		{
			if(isdefined(level.custom_pap_state_handler))
			{
				self [[level.custom_pap_state_handler]](state);
				break;
			}
		}
	}
}

/*
	Name: set_state_initial
	Namespace: _zm_pack_a_punch
	Checksum: 0x424F4353
	Offset: 0x42C8
	Size: 0x28
	Parameters: 0
	Flags: None
	Line Number: 1479
*/
function set_state_initial()
{
	self set_pap_zbarrier_state("initial");
}

/*
	Name: set_state_leaving
	Namespace: _zm_pack_a_punch
	Checksum: 0x424F4353
	Offset: 0x42F8
	Size: 0x28
	Parameters: 0
	Flags: None
	Line Number: 1494
*/
function set_state_leaving()
{
	self set_pap_zbarrier_state("leaving");
}

/*
	Name: set_state_arriving
	Namespace: _zm_pack_a_punch
	Checksum: 0x424F4353
	Offset: 0x4328
	Size: 0x28
	Parameters: 0
	Flags: None
	Line Number: 1509
*/
function set_state_arriving()
{
	self set_pap_zbarrier_state("arriving");
}

/*
	Name: set_state_power_on
	Namespace: _zm_pack_a_punch
	Checksum: 0x424F4353
	Offset: 0x4358
	Size: 0x28
	Parameters: 0
	Flags: None
	Line Number: 1524
*/
function set_state_power_on()
{
	self set_pap_zbarrier_state("power_on");
	return;
}

/*
	Name: set_state_hidden
	Namespace: _zm_pack_a_punch
	Checksum: 0x424F4353
	Offset: 0x4388
	Size: 0x28
	Parameters: 0
	Flags: None
	Line Number: 1540
*/
function set_state_hidden()
{
	self set_pap_zbarrier_state("hidden");
}

/*
	Name: create_unitrigger
	Namespace: _zm_pack_a_punch
	Checksum: 0x424F4353
	Offset: 0x43B8
	Size: 0x240
	Parameters: 5
	Flags: None
	Line Number: 1555
*/
function create_unitrigger(str_hint, n_radius, func_prompt_and_visibility, func_unitrigger_logic, s_trigger_type)
{
	if(!isdefined(n_radius))
	{
		n_radius = 48;
	}
	if(!isdefined(func_prompt_and_visibility))
	{
		func_prompt_and_visibility = &zm_unitrigger::unitrigger_prompt_and_visibility;
	}
	if(!isdefined(func_unitrigger_logic))
	{
		func_unitrigger_logic = &unitrigger_logic;
	}
	if(!isdefined(s_trigger_type))
	{
		s_trigger_type = "unitrigger_radius_use";
	}
	self.s_unitrigger = util::spawn_model("tag_origin", self.origin, self.angles);
	self.s_unitrigger.origin = self.origin;
	self.s_unitrigger.angles = self.angles;
	self.s_unitrigger.script_unitrigger_type = "unitrigger_box_use";
	self.s_unitrigger.cursor_hint = "HINT_NOICON";
	self.s_unitrigger.hint_string = str_hint;
	self.s_unitrigger.script_width = 96;
	self.s_unitrigger.script_height = 96;
	self.s_unitrigger.script_length = 96;
	self.s_unitrigger.require_look_at = 0;
	self.s_unitrigger.related_parent = self;
	self.s_unitrigger.radius = n_radius;
	self EnableLinkTo();
	wait(0.05);
	self.s_unitrigger linkto(self);
	zm_unitrigger::unitrigger_force_per_player_triggers(self.s_unitrigger, 1);
	self.s_unitrigger.prompt_and_visibility_func = func_prompt_and_visibility;
	zm_unitrigger::register_static_unitrigger(self.s_unitrigger, func_unitrigger_logic);
}

/*
	Name: unitrigger_logic
	Namespace: _zm_pack_a_punch
	Checksum: 0x424F4353
	Offset: 0x4600
	Size: 0xA4
	Parameters: 0
	Flags: None
	Line Number: 1603
*/
function unitrigger_logic()
{
	self endon("death");
	while(1)
	{
		self waittill("trigger", player);
		if(player zm_utility::in_revive_trigger())
		{
			continue;
		}
		if(player.is_drinking > 0)
		{
			continue;
		}
		if(!zm_utility::is_player_valid(player))
		{
			continue;
		}
		self.stub.related_parent notify("trigger_activated", player);
	}
}

