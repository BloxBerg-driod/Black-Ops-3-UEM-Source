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

#namespace namespace__zm_pack_a_punch;

/*
	Name: function___init__sytem__
	Namespace: namespace__zm_pack_a_punch
	Checksum: 0x424F4353
	Offset: 0xAC8
	Size: 0x40
	Parameters: 0
	Flags: AutoExec
	Line Number: 41
*/
function autoexec function___init__sytem__()
{
	namespace_system::function_register("zm_pack_a_punch", &function___init__, &function___main__, undefined);
}

/*
	Name: function___init__
	Namespace: namespace__zm_pack_a_punch
	Checksum: 0x424F4353
	Offset: 0xB10
	Size: 0x78
	Parameters: 0
	Flags: None
	Line Number: 56
*/
function function___init__()
{
	namespace_zm_pap_util::function_init_parameters();
	namespace_clientfield::function_register("zbarrier", "pap_working_FX", 5000, 1, "int");
	namespace_clientfield::function_register("zbarrier", "pap_light", 5000, 2, "int");
	return;
	ERROR: Exception occured: Stack empty.
}

/*
	Name: function___main__
	Namespace: namespace__zm_pack_a_punch
	Checksum: 0x424F4353
	Offset: 0xB90
	Size: 0x1A0
	Parameters: 0
	Flags: None
	Line Number: 75
*/
function function___main__()
{
	if(!isdefined(level.var_pap_zbarrier_state_func))
	{
		level.var_pap_zbarrier_state_func = &function_process_pap_zbarrier_state;
	}
	if(function_ToLower(function_GetDvarString("mapname")) == "zm_zod")
	{
		function_spawn_init("zod");
	}
	else
	{
		function_spawn_init();
	}
	var_vending_weapon_upgrade_trigger = namespace_zm_pap_util::function_get_triggers();
	if(var_vending_weapon_upgrade_trigger.size >= 1)
	{
		if(isdefined(level.var_b90077c4) && level.var_b90077c4)
		{
			namespace_Array::function_thread_all(var_vending_weapon_upgrade_trigger, &function_db6319b2);
		}
		else
		{
			namespace_Array::function_thread_all(var_vending_weapon_upgrade_trigger, &function_vending_weapon_upgrade);
		}
	}
	var_old_packs = function_GetEntArray("zombie_vending_upgrade", "targetname");
	for(var_i = 0; var_i < var_old_packs.size; var_i++)
	{
		var_vending_weapon_upgrade_trigger[var_vending_weapon_upgrade_trigger.size] = var_old_packs[var_i];
	}
	level namespace_flag::function_init("pack_machine_in_use");
	return;
	ERROR: Exception occured: Stack empty.
}

/*
	Name: function_spawn_init
	Namespace: namespace__zm_pack_a_punch
	Checksum: 0x424F4353
	Offset: 0xD38
	Size: 0x478
	Parameters: 1
	Flags: Private
	Line Number: 121
*/
function private function_spawn_init(var_map)
{
	var_zbarriers = function_GetEntArray("zm_pack_a_punch", "targetname");
	for(var_i = 0; var_i < var_zbarriers.size; var_i++)
	{
		if(!var_zbarriers[var_i] function_IsZBarrier())
		{
			continue;
		}
		if(!isdefined(level.var_pack_a_punch.var_interaction_height))
		{
			level.var_pack_a_punch.var_interaction_height = 35;
		}
		if(!isdefined(level.var_pack_a_punch.var_interaction_trigger_radius))
		{
			level.var_pack_a_punch.var_interaction_trigger_radius = 90;
		}
		if(!isdefined(level.var_pack_a_punch.var_interaction_trigger_height))
		{
			level.var_pack_a_punch.var_interaction_trigger_height = 70;
		}
		var_use_trigger = namespace_util::function_spawn_model("tag_origin", var_zbarriers[var_i].var_origin + (0, 0, level.var_pack_a_punch.var_interaction_height));
		if(var_map != "zod")
		{
			var_use_trigger function_create_unitrigger(&"ZOMBIE_NEED_POWER", undefined, &function_7e6983a0);
		}
		var_use_trigger.var_script_noteworthy = "pack_a_punch";
		var_use_trigger namespace_flag::function_init("pap_offering_gun");
		var_collision = function_spawn("script_model", var_zbarriers[var_i].var_origin, 1);
		var_collision.var_angles = var_zbarriers[var_i].var_angles;
		var_collision function_SetModel("zm_collision_perks1");
		var_collision.var_script_noteworthy = "clip";
		var_collision function_disconnectpaths();
		var_use_trigger.var_clip = var_collision;
		var_use_trigger.var_zbarrier = var_zbarriers[var_i];
		var_use_trigger.var_script_sound = "mus_perks_packa_jingle";
		var_use_trigger.var_script_label = "mus_perks_packa_sting";
		var_use_trigger.var_longJingleWait = 1;
		var_use_trigger.var_target = "vending_packapunch";
		var_use_trigger.var_zbarrier.var_targetname = "vending_packapunch";
		var_powered_on = function_get_start_state();
		var_use_trigger.var_powered = namespace_zm_power::function_add_powered_item(&function_turn_on, &function_turn_off, &function_get_range, &function_cost_func, 0, var_powered_on, var_use_trigger);
		if(isdefined(level.var_pack_a_punch.var_custom_power_think))
		{
			var_use_trigger thread [[level.var_pack_a_punch.var_custom_power_think]](var_powered_on);
		}
		else
		{
			var_use_trigger thread function_toggle_think(var_powered_on);
		}
		if(!isdefined(level.var_pack_a_punch.var_triggers))
		{
			level.var_pack_a_punch.var_triggers = [];
		}
		else if(!function_IsArray(level.var_pack_a_punch.var_triggers))
		{
			level.var_pack_a_punch.var_triggers = function_Array(level.var_pack_a_punch.var_triggers);
		}
		level.var_pack_a_punch.var_triggers[level.var_pack_a_punch.var_triggers.size] = var_use_trigger;
	}
}

/*
	Name: function_29b95c3e
	Namespace: namespace__zm_pack_a_punch
	Checksum: 0x424F4353
	Offset: 0x11B8
	Size: 0x1A8
	Parameters: 0
	Flags: None
	Line Number: 193
*/
function function_29b95c3e()
{
	self.var_trigger = function_spawn("trigger_damage", self.var_origin, 0, 60, 60);
	self.var_trigger function_EnableLinkTo();
	self.var_trigger function_LinkTo(self);
	while(isdefined(self.var_trigger))
	{
		self.var_trigger waittill("hash_damage", var_n_damage, var_e_attacker, var_v_dir, var_v_loc, var_str_type, var_STR_MODEL, var_str_tag, var_str_part, var_w_weapon);
		wait(0.05);
		if(function_IsInArray(level.var_zombie_melee_weapon_list, var_w_weapon) || var_str_type == "MOD_MELEE_WEAPON_BUTT" || var_str_type == "MOD_MELEE" || var_str_type == "MOD_MELEE_ASSASSINATE")
		{
			if(var_e_attacker.var_5511c660 == 0)
			{
				var_e_attacker.var_5511c660 = 1;
				var_e_attacker thread function_351b996a();
			}
			else
			{
				var_e_attacker.var_5511c660 = 0;
			}
		}
		wait(1);
	}
}

/*
	Name: function_351b996a
	Namespace: namespace__zm_pack_a_punch
	Checksum: 0x424F4353
	Offset: 0x1368
	Size: 0x70
	Parameters: 0
	Flags: None
	Line Number: 228
*/
function function_351b996a()
{
	self notify("hash_fe4d6597");
	self endon("hash_fe4d6597");
	self endon("hash_c3d5e0ab");
	var_count = 0;
	while(var_count < 10)
	{
		var_count = var_count + 1;
		wait(1);
	}
	self.var_5511c660 = 0;
}

/*
	Name: function_7e6983a0
	Namespace: namespace__zm_pack_a_punch
	Checksum: 0x424F4353
	Offset: 0x13E0
	Size: 0x830
	Parameters: 1
	Flags: None
	Line Number: 252
*/
function function_7e6983a0(var_player)
{
	if(self.var_stub.var_related_parent namespace_flag::function_get("pap_offering_gun") && self.var_stub.var_related_parent.var_pack_player == var_player)
	{
		self function_setHintString(&"ZM_MINECRAFT_HINTSTRING_PAP_OFFERING_GUN");
		self function_setcursorhint("HINT_WEAPON", self.var_stub.var_related_parent.var_upgrade_weapon);
		return 1;
	}
	else if(isdefined(self.var_stub.var_related_parent.var_53c64808) && self.var_stub.var_related_parent.var_53c64808)
	{
		self function_setHintString("");
		self function_setcursorhint("HINT_NOICON");
		return 0;
	}
	if(self.var_stub.var_related_parent.var_zbarrier.var_State == "powered")
	{
		var_7750a3aa = var_player namespace_5e1f56dc::function_1239e0ad(var_player function_GetCurrentWeapon());
		if(isdefined(var_7750a3aa))
		{
			if(var_7750a3aa.var_a39a2843 == 1)
			{
				var_player.var_439d3100 = 10000;
			}
			if(var_7750a3aa.var_a39a2843 == 2)
			{
				var_player.var_439d3100 = 15000;
			}
			if(var_7750a3aa.var_a39a2843 == 3)
			{
				var_player.var_439d3100 = 30000;
			}
			if(var_7750a3aa.var_a39a2843 == 4)
			{
				var_player.var_439d3100 = 50000;
			}
			if(var_7750a3aa.var_a39a2843 == 5)
			{
				var_player.var_439d3100 = 75000;
			}
			if(var_7750a3aa.var_a39a2843 == 6)
			{
				var_player.var_439d3100 = 100000;
			}
			if(var_7750a3aa.var_a39a2843 == 7)
			{
				var_player.var_439d3100 = 125000;
			}
			if(var_7750a3aa.var_a39a2843 == 8)
			{
				var_player.var_439d3100 = 150000;
			}
			if(var_7750a3aa.var_a39a2843 == 9)
			{
				var_player.var_439d3100 = 175000;
			}
			if(var_7750a3aa.var_a39a2843 == 10)
			{
				var_player.var_439d3100 = 200000;
			}
		}
		else
		{
			var_player.var_439d3100 = 5000;
		}
		if(isdefined(level.var_919b0320) && level.var_919b0320)
		{
			self function_setHintString(&"ZM_MINECRAFT_HINTSTRING_PAP_DISABLED");
			return 0;
		}
		if(isdefined(var_player.var_5511c660) && var_player.var_5511c660 == 1)
		{
			if(var_player function_istouching(self))
			{
				var_player thread function_351b996a();
			}
			if(!namespace_zm_weapons::function_weapon_supports_aat(var_player function_GetCurrentWeapon()))
			{
				self function_setHintString(&"ZM_MINECRAFT_HINTSTRING_CANNOT_USE_PAP_AAT");
				return 0;
			}
			else if(namespace_zm_weapons::function_is_weapon_upgraded(var_player function_GetCurrentWeapon()) && isdefined(var_7750a3aa) && var_7750a3aa.var_a39a2843 < 3)
			{
				self function_setHintString(&"ZM_MINECRAFT_HINTSTRING_CANNOT_USE_PAP_AAT_REQUIREMENT");
				return 0;
			}
			else if(!(isdefined(var_player function_player_use_can_pack_now()) && var_player function_player_use_can_pack_now()))
			{
				self function_setHintString(&"ZM_MINECRAFT_HINTSTRING_CANNOT_USE_PAP_AAT");
				return 0;
			}
			else if(!var_player namespace_zm_score::function_can_player_purchase(5000))
			{
				self function_setHintString(&"ZM_MINECRAFT_HINTSTRING_PAP_AAT_NO_MONEY", 5000);
				return 0;
			}
			else if(namespace_zm_weapons::function_is_weapon_upgraded(var_player function_GetCurrentWeapon()) && isdefined(var_7750a3aa) && namespace_zm_weapons::function_weapon_supports_aat(var_player function_GetCurrentWeapon()))
			{
				self function_setHintString(&"ZM_MINECRAFT_HINTSTRING_CAN_PACK_AAT", 5000);
				return 1;
			}
			else
			{
				self function_setHintString(&"ZM_MINECRAFT_HINTSTRING_CANNOT_USE_PAP_AAT");
				return 0;
			}
		}
		else if(var_player function_istouching(self))
		{
			var_player notify("hash_c3d5e0ab");
		}
		if(namespace_zm_weapons::function_is_weapon_upgraded(var_player function_GetCurrentWeapon()) && isdefined(var_7750a3aa) && var_7750a3aa.var_a39a2843 >= level.var_7ceb1b41)
		{
			self function_setHintString(&"ZM_MINECRAFT_HINTSTRING_CANNOT_USE_PAP_WEAPON_MAX");
			return 0;
		}
		else if(!(isdefined(var_player function_player_use_can_pack_now()) && var_player function_player_use_can_pack_now()))
		{
			self function_setHintString(&"ZM_MINECRAFT_HINTSTRING_CANNOT_USE_PAP_WEAPON");
			return 0;
		}
		else if(!var_player namespace_zm_score::function_can_player_purchase(var_player.var_439d3100))
		{
			self function_setHintString(&"ZM_MINECRAFT_HINTSTRING_PAP_NO_MONEY", var_player.var_439d3100);
			return 0;
		}
		else if(!isdefined(var_7750a3aa))
		{
			self function_setHintString(&"ZM_MINECRAFT_HINTSTRING_CAN_PACK_A_PUNCH", var_player.var_439d3100, "Uncommon Enchantment");
		}
		else
		{
			self function_setHintString(&"ZM_MINECRAFT_HINTSTRING_CAN_PACK_A_PUNCH", var_player.var_439d3100, var_player namespace_5e1f56dc::function_5a6a55da(var_7750a3aa.var_a39a2843 + 1));
		}
		return 1;
	}
	else
	{
		self function_setHintString(&"ZOMBIE_NEED_POWER");
		self function_setcursorhint("HINT_NOICON");
		return 0;
	}
}

/*
	Name: function_player_use_can_pack_now
	Namespace: namespace__zm_pack_a_punch
	Checksum: 0x424F4353
	Offset: 0x1C18
	Size: 0x2F0
	Parameters: 0
	Flags: Private
	Line Number: 405
*/
function private function_player_use_can_pack_now()
{
	if(self namespace_laststand::function_player_is_in_laststand() || (isdefined(self.var_intermission) && self.var_intermission) || self function_IsThrowingGrenade())
	{
		return 0;
	}
	if(!self namespace_zm_magicbox::function_can_buy_weapon() || self namespace_bgb::function_is_enabled("zm_bgb_disorderly_combat") || namespace_zm_utility::function_is_hero_weapon(self function_GetCurrentWeapon()))
	{
		return 0;
	}
	if(!namespace_zm_utility::function_is_player_valid(self) || self.var_IS_DRINKING > 0 || namespace_zm_utility::function_is_placeable_mine(self function_GetCurrentWeapon()) || namespace_zm_equipment::function_is_equipment(self function_GetCurrentWeapon()) || self namespace_zm_utility::function_is_player_revive_tool(self function_GetCurrentWeapon()) || level.var_weaponNone == self function_GetCurrentWeapon() || self namespace_zm_equipment::function_hacker_active())
	{
		return 0;
	}
	if(self function_GetCurrentWeapon().var_isRiotShield)
	{
		return 0;
	}
	var_weapon = self namespace_zm_weapons::function_get_nonalternate_weapon(self function_GetCurrentWeapon());
	if(!namespace_zm_weapons::function_is_weapon_or_base_included(self function_GetCurrentWeapon()))
	{
		return 0;
	}
	if(function_ToLower(function_GetDvarString("mapname")) != "zm_zod")
	{
		if(!namespace_zm_weapons::function_is_weapon_upgraded(self function_GetCurrentWeapon()) && !self namespace_zm_weapons::function_can_upgrade_weapon(self function_GetCurrentWeapon()))
		{
			return 0;
		}
	}
	if(isdefined(self function_GetCurrentWeapon() namespace_5e1f56dc::function_25b21deb()) && self function_GetCurrentWeapon() namespace_5e1f56dc::function_25b21deb())
	{
		return 0;
	}
	return 1;
}

/*
	Name: function_pap_trigger_hintstring_monitor
	Namespace: namespace__zm_pack_a_punch
	Checksum: 0x424F4353
	Offset: 0x1F10
	Size: 0xE8
	Parameters: 0
	Flags: Private
	Line Number: 452
*/
function private function_pap_trigger_hintstring_monitor()
{
	level endon("hash_Pack_A_Punch_off");
	level waittill("hash_Pack_A_Punch_on");
	self thread function_pap_trigger_hintstring_monitor_reset();
	while(1)
	{
		foreach(var_e_player in level.var_players)
		{
			if(var_e_player function_istouching(self))
			{
				self namespace_zm_pap_util::function_update_hint_string(var_e_player);
			}
		}
		wait(0.05);
	}
}

/*
	Name: function_pap_trigger_hintstring_monitor_reset
	Namespace: namespace__zm_pack_a_punch
	Checksum: 0x424F4353
	Offset: 0x2000
	Size: 0x28
	Parameters: 0
	Flags: Private
	Line Number: 480
*/
function private function_pap_trigger_hintstring_monitor_reset()
{
	level waittill("hash_Pack_A_Punch_off");
	self thread function_pap_trigger_hintstring_monitor();
}

/*
	Name: function_third_person_weapon_upgrade
	Namespace: namespace__zm_pack_a_punch
	Checksum: 0x424F4353
	Offset: 0x2030
	Size: 0x4E8
	Parameters: 5
	Flags: Private
	Line Number: 496
*/
function private function_third_person_weapon_upgrade(var_current_weapon, var_upgrade_weapon, var_packa_rollers, var_pap_machine, var_trigger)
{
	level endon("hash_Pack_A_Punch_off");
	var_trigger endon("hash_pap_player_disconnected");
	var_current_weapon = self function_GetBuildKitWeapon(var_current_weapon, 0);
	var_upgrade_weapon = self function_GetBuildKitWeapon(var_upgrade_weapon, 1);
	var_trigger.var_7750a3aa = self namespace_5e1f56dc::function_1239e0ad(var_current_weapon);
	var_trigger.var_current_weapon = var_current_weapon;
	var_trigger.var_current_weapon_options = self function_GetBuildKitWeaponOptions(var_trigger.var_current_weapon);
	var_trigger.var_current_weapon_acvi = self function_GetBuildKitAttachmentCosmeticVariantIndexes(var_trigger.var_current_weapon, 0);
	var_trigger.var_upgrade_weapon = var_upgrade_weapon;
	var_upgrade_weapon.var_pap_camo_to_use = namespace_zm_weapons::function_get_pack_a_punch_camo_index(var_upgrade_weapon.var_pap_camo_to_use);
	var_trigger.var_upgrade_weapon_options = self function_GetBuildKitWeaponOptions(var_trigger.var_upgrade_weapon, var_upgrade_weapon.var_pap_camo_to_use);
	var_trigger.var_upgrade_weapon_acvi = self function_GetBuildKitAttachmentCosmeticVariantIndexes(var_trigger.var_upgrade_weapon, 1);
	var_trigger.var_zbarrier function_setWeapon(var_trigger.var_current_weapon);
	var_trigger.var_zbarrier function_SetWeaponOptions(var_trigger.var_current_weapon_options);
	var_trigger.var_zbarrier function_SetAttachmentCosmeticVariantIndexes(var_trigger.var_current_weapon_acvi);
	var_trigger.var_zbarrier function_set_pap_zbarrier_state("take_gun");
	var_rel_entity = var_trigger.var_pap_machine;
	var_origin_offset = (0, 0, 0);
	var_angles_offset = (0, 0, 0);
	var_origin_base = self.var_origin;
	var_angles_base = self.var_angles;
	if(isdefined(var_rel_entity))
	{
		var_origin_offset = (0, 0, level.var_pack_a_punch.var_interaction_height);
		var_angles_offset = VectorScale((0, 1, 0), 90);
		var_origin_base = var_rel_entity.var_origin;
		var_angles_base = var_rel_entity.var_angles;
	}
	else
	{
		var_rel_entity = self;
	}
	var_FORWARD = function_AnglesToForward(var_angles_base + var_angles_offset);
	var_interact_offset = var_origin_offset + var_FORWARD * -25;
	var_offsetdw = VectorScale((1, 1, 1), 3);
	var_pap_machine [[level.var_pack_a_punch.var_move_in_func]](self, var_trigger, var_origin_offset, var_angles_offset);
	self function_playsound("zmb_perks_packa_upgrade");
	wait(0.35);
	wait(3);
	var_trigger.var_zbarrier function_setWeapon(var_upgrade_weapon);
	var_trigger.var_zbarrier function_SetWeaponOptions(var_trigger.var_upgrade_weapon_options);
	var_trigger.var_zbarrier function_SetAttachmentCosmeticVariantIndexes(var_trigger.var_upgrade_weapon_acvi);
	var_trigger.var_zbarrier function_set_pap_zbarrier_state("eject_gun");
	if(isdefined(self))
	{
		self function_playsound("zmb_perks_packa_ready");
		return;
	}
	else
	{
	}
	var_rel_entity thread [[level.var_pack_a_punch.var_move_out_func]](self, var_trigger, var_origin_offset, var_interact_offset);
}

/*
	Name: function_can_pack_weapon
	Namespace: namespace__zm_pack_a_punch
	Checksum: 0x424F4353
	Offset: 0x2520
	Size: 0xE8
	Parameters: 1
	Flags: Private
	Line Number: 562
*/
function private function_can_pack_weapon(var_weapon)
{
	if(var_weapon.var_isRiotShield)
	{
		return 0;
	}
	if(level namespace_flag::function_get("pack_machine_in_use"))
	{
		return 1;
	}
	if(!(isdefined(level.var_b_allow_idgun_pap) && level.var_b_allow_idgun_pap) && isdefined(level.var_idgun_weapons))
	{
		if(function_IsInArray(level.var_idgun_weapons, var_weapon))
		{
			return 0;
		}
	}
	var_weapon = self namespace_zm_weapons::function_get_nonalternate_weapon(var_weapon);
	if(!namespace_zm_weapons::function_is_weapon_or_base_included(var_weapon))
	{
		return 0;
	}
	if(!self namespace_zm_weapons::function_can_upgrade_weapon(var_weapon))
	{
		return 0;
	}
	return 1;
}

/*
	Name: function_pack_a_punch_machine_trigger_think
	Namespace: namespace__zm_pack_a_punch
	Checksum: 0x424F4353
	Offset: 0x2610
	Size: 0x148
	Parameters: 0
	Flags: Private
	Line Number: 601
*/
function private function_pack_a_punch_machine_trigger_think()
{
	self endon("hash_death");
	self endon("hash_Pack_A_Punch_off");
	self notify("hash_pack_a_punch_trigger_think");
	self endon("hash_pack_a_punch_trigger_think");
	while(1)
	{
		var_players = function_GetPlayers();
		for(var_i = 0; var_i < var_players.size; var_i++)
		{
			if(isdefined(self.var_pack_player) && self.var_pack_player != var_players[var_i] || !var_players[var_i] function_player_use_can_pack_now() || var_players[var_i] namespace_bgb::function_is_active("zm_bgb_ephemeral_enhancement"))
			{
				self function_SetInvisibleToPlayer(var_players[var_i], 1);
				continue;
			}
			self function_SetInvisibleToPlayer(var_players[var_i], 0);
		}
		wait(0.1);
	}
	return;
	ERROR: Exception occured: Stack empty.
	waittillframeend;
}

/*
	Name: function_vending_weapon_upgrade
	Namespace: namespace__zm_pack_a_punch
	Checksum: 0x424F4353
	Offset: 0x2760
	Size: 0xFA0
	Parameters: 0
	Flags: Private
	Line Number: 636
*/
function private function_vending_weapon_upgrade()
{
	level endon("hash_Pack_A_Punch_off");
	var_pap_machine = function_GetEnt(self.var_target, "targetname");
	self.var_pap_machine = var_pap_machine;
	var_pap_machine_sound = function_GetEntArray("perksacola", "targetname");
	var_packa_rollers = function_spawn("script_origin", self.var_origin);
	var_packa_timer = function_spawn("script_origin", self.var_origin);
	var_packa_rollers function_LinkTo(self);
	var_packa_timer function_LinkTo(self);
	var_power_off = !self function_is_on();
	if(var_power_off)
	{
		var_pap_array = [];
		var_pap_array[0] = var_pap_machine;
		level waittill("hash_Pack_A_Punch_on");
	}
	if(isdefined(level.var_pack_a_punch.var_power_on_callback))
	{
		var_pap_machine thread [[level.var_pack_a_punch.var_power_on_callback]]();
	}
	self thread function_pack_a_punch_machine_trigger_think();
	var_pap_machine function_PlayLoopSound("zmb_perks_packa_loop");
	self thread function_shutOffPAPSounds(var_pap_machine, var_packa_rollers, var_packa_timer);
	self thread function_29b95c3e();
	for(;;)
	{
		self.var_pack_player = undefined;
		self waittill("hash_trigger_activated", var_player);
		var_current_weapon = var_player function_GetCurrentWeapon();
		var_7750a3aa = var_player namespace_5e1f56dc::function_1239e0ad(var_current_weapon);
		if(isdefined(var_player.var_5511c660) && var_player.var_5511c660 == 1)
		{
			if(!var_player namespace_zm_score::function_can_player_purchase(5000))
			{
				namespace_zm_utility::function_play_sound_at_pos("no_purchase", var_player.var_origin);
				var_player namespace_zm_audio::function_create_and_play_dialog("general", "outofmoney");
				self function_playsound("zmb_perks_packa_deny");
			}
			else if(namespace_zm_weapons::function_is_weapon_upgraded(var_player function_GetCurrentWeapon()) && isdefined(var_7750a3aa) && var_7750a3aa.var_a39a2843 < 3)
			{
				namespace_zm_utility::function_play_sound_at_pos("no_purchase", var_player.var_origin);
				self function_playsound("zmb_perks_packa_deny");
			}
			else if(namespace_zm_weapons::function_is_weapon_upgraded(var_player function_GetCurrentWeapon()) && isdefined(var_7750a3aa) && namespace_zm_weapons::function_weapon_supports_aat(var_player function_GetCurrentWeapon()))
			{
				var_isRepack = 0;
				var_currentAATHashID = -1;
				if(isdefined(namespace_zm_weapons::function_weapon_supports_aat(var_player function_GetCurrentWeapon())) && namespace_zm_weapons::function_weapon_supports_aat(var_player function_GetCurrentWeapon()))
				{
					var_player namespace_zm_score::function_minus_to_player_score(5000);
					namespace_zm_utility::function_play_sound_at_pos("purchase", var_player.var_origin);
					var_player namespace_zm_audio::function_create_and_play_dialog("general", "generic_wall_buy");
					var_player thread namespace_AAT::function_acquire(var_player function_GetCurrentWeapon());
					var_aatObj = var_player namespace_AAT::function_getAATOnWeapon(var_player function_GetCurrentWeapon());
					if(isdefined(var_aatObj))
					{
						var_aatID = var_aatObj.var_hash_id;
					}
					var_isRepack = 1;
				}
				else
				{
					var_player thread namespace_AAT::function_remove(var_player function_GetCurrentWeapon());
				}
			}
		}
		else if(isdefined(var_pap_machine.var_State) && var_pap_machine.var_State == "leaving")
		{
		}
		else
		{
			var_index = namespace_zm_utility::function_get_player_index(var_player);
			var_current_weapon = var_player namespace_zm_weapons::function_switch_from_alt_weapon(var_current_weapon);
			if(!(isdefined(var_player function_player_use_can_pack_now()) && var_player function_player_use_can_pack_now()))
			{
			}
			else
			{
				var_current_cost = var_player.var_439d3100;
				if(!var_player namespace_zm_score::function_can_player_purchase(var_current_cost))
				{
					self function_playsound("zmb_perks_packa_deny");
					if(isdefined(level.var_pack_a_punch.var_custom_deny_func))
					{
						var_player [[level.var_pack_a_punch.var_custom_deny_func]]();
					}
					else
					{
						var_player namespace_zm_audio::function_create_and_play_dialog("general", "outofmoney", 0);
					}
				}
				else
				{
					var_player namespace_zm_stats::function_increment_client_stat("use_pap");
					var_player namespace_zm_stats::function_increment_player_stat("use_pap");
					var_player thread namespace_97ac1184::function_1d39abf6("end_game_use_pap", 1, 0);
					var_player thread namespace_97ac1184::function_7e18304e("spx_save_data", "use_pap", var_player.var_pers["use_pap"], 0);
					var_player namespace_zm_score::function_minus_to_player_score(var_current_cost);
					var_sound = "evt_bottle_dispense";
					function_playsoundatposition(var_sound, self.var_origin);
					self thread namespace_zm_audio::function_sndPerksJingles_Player(1);
					var_player namespace_zm_audio::function_create_and_play_dialog("general", "pap_wait");
					var_12030910 = namespace_zm_weapons::function_get_upgrade_weapon(var_current_weapon, 0);
					var_ed5e1bff = var_player namespace_5e1f56dc::function_e942fd68(var_12030910);
					if(isdefined(var_7750a3aa))
					{
						if(isdefined(var_7750a3aa.var_a39a2843) && var_7750a3aa.var_a39a2843 < level.var_7ceb1b41)
						{
							var_7750a3aa.var_a39a2843 = var_7750a3aa.var_a39a2843 + 1;
							if(var_player.var_pers["highest_enchantment"] > var_7750a3aa.var_a39a2843)
							{
							}
							else
							{
								var_player.var_pers["highest_enchantment"] = var_7750a3aa.var_a39a2843;
								var_player thread namespace_97ac1184::function_7e18304e("spx_save_data", "highest_enchantment", var_player.var_pers["highest_enchantment"], 0);
							}
							if(var_7750a3aa.var_a39a2843 > var_player.var_ddbf6bf2)
							{
								var_player.var_ddbf6bf2++;
								var_player notify("hash_79ef118b", "milestone_completed_enchantment_" + var_7750a3aa.var_a39a2843, undefined);
							}
							if(level.var_fcee636 == "motd")
							{
								var_player notify("hash_63cf7d21", "map0_motd_pack_a_punched", 1, 1, 75000, 10);
								wait(0.05);
								if(var_player.var_pers["map0_motd_pack_a_punched"] >= 1)
								{
									var_player notify("hash_63cf7d21", "map0_motd_pack_a_punched_multiple", 1, 25, 135000, 250, "motd_camo_0");
									wait(0.05);
									if(var_player.var_pers["map0_motd_pack_a_punched_multiple"] >= 25)
									{
										var_player notify("hash_63cf7d21", "map0_motd_pack_a_punched_multiple_2", 1, 125, 235000, 1000, "motd_camo_1");
										wait(0.05);
									}
								}
							}
							var_player thread namespace_97ac1184::function_b3489bf5("^3" + var_player.var_playerName + "^7 Pack-a-Punched to ^9" + var_7750a3aa namespace_5e1f56dc::function_3ce97289() + " ^7on " + function_MakeLocalizedString(var_7750a3aa.var_stored_weapon.var_displayName));
							var_player namespace_5e1f56dc::function_febfc6ba(var_current_weapon);
						}
					}
					else if(!(isdefined(var_ed5e1bff) && var_ed5e1bff))
					{
						if(isdefined(var_player namespace_5e1f56dc::function_c3370d47(var_12030910)) && var_player namespace_5e1f56dc::function_c3370d47(var_12030910))
						{
							var_de6974d4 = function_spawnstruct();
							var_de6974d4.var_stored_weapon = var_12030910.var_rootweapon;
							var_de6974d4.var_79fe8f18 = 0;
							var_de6974d4.var_4c25c2f2 = 0;
							var_de6974d4.var_pap_camo_to_use = level.var_1e656cc4[var_de6974d4.var_4c25c2f2];
							var_player.var_3818be12[var_player.var_3818be12.size] = var_de6974d4;
						}
					}
					if(!(isdefined(var_7750a3aa) && var_7750a3aa))
					{
						var_d2433c1d = function_spawnstruct();
						var_d2433c1d.var_stored_weapon = var_12030910.var_rootweapon;
						var_a76169e6 = namespace_5e1f56dc::function_49e2047b();
						var_d2433c1d.var_a39a2843 = var_a76169e6;
						var_player.var_fb56a719[var_player.var_fb56a719.size] = var_d2433c1d;
					}
					var_player function_TakeWeapon(var_current_weapon);
					var_player function_GiveWeapon(var_12030910, var_player namespace_zm_weapons::function_get_pack_a_punch_weapon_options(var_12030910));
					if(var_12030910.var_start_ammo != var_12030910.var_maxAmmo)
					{
						if(var_player function_hasPerk("specialty_extraammo"))
						{
							var_player function_giveMaxAmmo(var_12030910);
						}
						else
						{
							var_player function_GiveStartAmmo(var_12030910);
						}
					}
					else
					{
						var_player function_giveMaxAmmo(var_12030910);
					}
					var_player function_SwitchToWeapon(var_12030910);
					var_player thread namespace_97ac1184::function_b3489bf5("^3" + var_player.var_playerName + "^7 Pack-a-Punched to ^9" + var_d2433c1d namespace_5e1f56dc::function_3ce97289() + " ^7on " + function_MakeLocalizedString(var_d2433c1d.var_stored_weapon.var_displayName));
					wait(0.05);
					if(level.var_fcee636 == "motd")
					{
						var_player notify("hash_63cf7d21", "map0_motd_pack_a_punched", 1, 1, 75000, 10);
						wait(0.05);
						if(var_player.var_pers["map0_motd_pack_a_punched"] >= 1)
						{
							var_player notify("hash_63cf7d21", "map0_motd_pack_a_punched_multiple", 1, 25, 135000, 250, "motd_camo_0");
							wait(0.05);
							if(var_player.var_pers["map0_motd_pack_a_punched_multiple"] >= 25)
							{
								var_player notify("hash_63cf7d21", "map0_motd_pack_a_punched_multiple_2", 1, 125, 235000, 1000, "motd_camo_1");
								wait(0.05);
							}
						}
					}
					namespace_zm_utility::function_play_sound_at_pos("zmb_perks_packa_ready", var_player);
				}
			}
		}
	}
}

/*
	Name: function_c9b35144
	Namespace: namespace__zm_pack_a_punch
	Checksum: 0x424F4353
	Offset: 0x3708
	Size: 0x7C0
	Parameters: 4
	Flags: None
	Line Number: 850
*/
function function_c9b35144(var_player, var_current_weapon, var_12030910, var_animation)
{
	if(!isdefined(var_animation))
	{
		var_animation = 0;
	}
	var_7750a3aa = var_player namespace_5e1f56dc::function_1239e0ad(var_current_weapon);
	if(!isdefined(var_12030910))
	{
		var_12030910 = namespace_zm_weapons::function_get_upgrade_weapon(var_current_weapon, 0);
	}
	var_ed5e1bff = var_player namespace_5e1f56dc::function_e942fd68(var_12030910);
	if(isdefined(var_7750a3aa))
	{
		if(isdefined(var_7750a3aa.var_a39a2843) && var_7750a3aa.var_a39a2843 < level.var_7ceb1b41)
		{
			var_7750a3aa.var_a39a2843 = var_7750a3aa.var_a39a2843 + 1;
			if(var_player.var_pers["highest_enchantment"] > var_7750a3aa.var_a39a2843)
			{
			}
			else
			{
				var_player.var_pers["highest_enchantment"] = var_7750a3aa.var_a39a2843;
				var_player thread namespace_97ac1184::function_7e18304e("spx_save_data", "highest_enchantment", var_player.var_pers["highest_enchantment"], 0);
			}
			if(var_7750a3aa.var_a39a2843 > var_player.var_ddbf6bf2)
			{
				var_player.var_ddbf6bf2++;
				var_player notify("hash_79ef118b", "milestone_completed_enchantment_" + var_7750a3aa.var_a39a2843, undefined);
			}
			wait(0.05);
			if(level.var_fcee636 == "motd")
			{
				var_player notify("hash_63cf7d21", "map0_motd_pack_a_punched", 1, 1, 75000, 10);
				wait(0.05);
				if(var_player.var_pers["map0_motd_pack_a_punched"] >= 1)
				{
					var_player notify("hash_63cf7d21", "map0_motd_pack_a_punched_multiple", 1, 25, 135000, 250, "motd_camo_0");
					wait(0.05);
					if(var_player.var_pers["map0_motd_pack_a_punched_multiple"] >= 25)
					{
						var_player notify("hash_63cf7d21", "map0_motd_pack_a_punched_multiple_2", 1, 125, 235000, 1000, "motd_camo_1");
						wait(0.05);
					}
				}
			}
			var_player thread namespace_97ac1184::function_b3489bf5("^3" + var_player.var_playerName + "^7 Pack-a-Punched to ^9" + var_7750a3aa namespace_5e1f56dc::function_3ce97289() + " ^7on " + function_MakeLocalizedString(var_7750a3aa.var_stored_weapon.var_displayName));
			var_player namespace_5e1f56dc::function_febfc6ba(var_current_weapon);
		}
	}
	else if(!(isdefined(var_ed5e1bff) && var_ed5e1bff))
	{
		if(isdefined(var_player namespace_5e1f56dc::function_c3370d47(var_12030910)) && var_player namespace_5e1f56dc::function_c3370d47(var_12030910))
		{
			var_de6974d4 = function_spawnstruct();
			var_de6974d4.var_stored_weapon = var_12030910.var_rootweapon;
			var_de6974d4.var_79fe8f18 = 0;
			var_de6974d4.var_4c25c2f2 = 0;
			var_de6974d4.var_pap_camo_to_use = level.var_1e656cc4[var_de6974d4.var_4c25c2f2];
			var_player.var_3818be12[var_player.var_3818be12.size] = var_de6974d4;
		}
	}
	if(!(isdefined(var_7750a3aa) && var_7750a3aa))
	{
		var_d2433c1d = function_spawnstruct();
		var_d2433c1d.var_stored_weapon = var_12030910.var_rootweapon;
		var_a76169e6 = namespace_5e1f56dc::function_49e2047b();
		var_d2433c1d.var_a39a2843 = var_a76169e6;
		var_player.var_fb56a719[var_player.var_fb56a719.size] = var_d2433c1d;
	}
	if(!(isdefined(var_animation) && var_animation))
	{
		var_player function_TakeWeapon(var_current_weapon);
	}
	var_player function_GiveWeapon(var_12030910, var_player namespace_zm_weapons::function_get_pack_a_punch_weapon_options(var_12030910));
	if(var_12030910.var_start_ammo != var_12030910.var_maxAmmo)
	{
		if(var_player function_hasPerk("specialty_extraammo"))
		{
			var_player function_giveMaxAmmo(var_12030910);
		}
		else
		{
			var_player function_GiveStartAmmo(var_12030910);
		}
	}
	else
	{
		var_player function_giveMaxAmmo(var_12030910);
	}
	var_player function_SwitchToWeapon(var_12030910);
	var_player thread namespace_97ac1184::function_b3489bf5("^3" + var_player.var_playerName + "^7 Pack-a-Punched to ^9" + var_d2433c1d namespace_5e1f56dc::function_3ce97289() + " ^7on " + function_MakeLocalizedString(var_d2433c1d.var_stored_weapon.var_displayName));
	wait(0.05);
	if(level.var_fcee636 == "motd")
	{
		var_player notify("hash_63cf7d21", "map0_motd_pack_a_punched", 1, 1, 75000, 10);
		wait(0.05);
		if(var_player.var_pers["map0_motd_pack_a_punched"] >= 1)
		{
			var_player notify("hash_63cf7d21", "map0_motd_pack_a_punched_multiple", 1, 25, 135000, 250, "motd_camo_0");
			wait(0.05);
			if(var_player.var_pers["map0_motd_pack_a_punched_multiple"] >= 25)
			{
				var_player notify("hash_63cf7d21", "map0_motd_pack_a_punched_multiple_2", 1, 125, 235000, 1000, "motd_camo_1");
				wait(0.05);
			}
		}
	}
}

/*
	Name: function_db6319b2
	Namespace: namespace__zm_pack_a_punch
	Checksum: 0x424F4353
	Offset: 0x3ED0
	Size: 0xB48
	Parameters: 0
	Flags: Private
	Line Number: 970
*/
function private function_db6319b2()
{
	level endon("hash_Pack_A_Punch_off");
	var_pap_machine = function_GetEnt(self.var_target, "targetname");
	self.var_pap_machine = var_pap_machine;
	var_pap_machine_sound = function_GetEntArray("perksacola", "targetname");
	var_packa_rollers = function_spawn("script_origin", self.var_origin);
	var_packa_timer = function_spawn("script_origin", self.var_origin);
	var_packa_rollers function_LinkTo(self);
	var_packa_timer function_LinkTo(self);
	var_power_off = !self function_is_on();
	if(var_power_off)
	{
		var_pap_array = [];
		var_pap_array[0] = var_pap_machine;
		level waittill("hash_Pack_A_Punch_on");
	}
	if(isdefined(level.var_pack_a_punch.var_power_on_callback))
	{
		var_pap_machine thread [[level.var_pack_a_punch.var_power_on_callback]]();
	}
	self thread function_pack_a_punch_machine_trigger_think();
	var_pap_machine function_PlayLoopSound("zmb_perks_packa_loop");
	self thread function_shutOffPAPSounds(var_pap_machine, var_packa_rollers, var_packa_timer);
	self.var_53c64808 = 0;
	self.var_wait_for_player_to_take = 0;
	self thread function_29b95c3e();
	for(;;)
	{
		wait(0.5);
		self.var_pack_player = undefined;
		self waittill("hash_trigger_activated", var_player);
		var_current_weapon = var_player function_GetCurrentWeapon();
		var_7750a3aa = var_player namespace_5e1f56dc::function_1239e0ad(var_current_weapon);
		if(isdefined(var_player.var_5511c660) && var_player.var_5511c660 == 1)
		{
			if(!var_player namespace_zm_score::function_can_player_purchase(5000))
			{
				namespace_zm_utility::function_play_sound_at_pos("no_purchase", var_player.var_origin);
				var_player namespace_zm_audio::function_create_and_play_dialog("general", "outofmoney");
				self function_playsound("zmb_perks_packa_deny");
			}
			else if(namespace_zm_weapons::function_is_weapon_upgraded(var_player function_GetCurrentWeapon()) && isdefined(var_7750a3aa) && var_7750a3aa.var_a39a2843 < 3)
			{
				namespace_zm_utility::function_play_sound_at_pos("no_purchase", var_player.var_origin);
				self function_playsound("zmb_perks_packa_deny");
			}
			else if(namespace_zm_weapons::function_is_weapon_upgraded(var_player function_GetCurrentWeapon()) && isdefined(var_7750a3aa) && namespace_zm_weapons::function_weapon_supports_aat(var_player function_GetCurrentWeapon()))
			{
				var_isRepack = 0;
				var_currentAATHashID = -1;
				if(isdefined(namespace_zm_weapons::function_weapon_supports_aat(var_player function_GetCurrentWeapon())) && namespace_zm_weapons::function_weapon_supports_aat(var_player function_GetCurrentWeapon()))
				{
					var_player namespace_zm_score::function_minus_to_player_score(5000);
					namespace_zm_utility::function_play_sound_at_pos("purchase", var_player.var_origin);
					var_player namespace_zm_audio::function_create_and_play_dialog("general", "generic_wall_buy");
					var_player thread namespace_AAT::function_acquire(var_player function_GetCurrentWeapon());
					var_aatObj = var_player namespace_AAT::function_getAATOnWeapon(var_player function_GetCurrentWeapon());
					if(isdefined(var_aatObj))
					{
						var_aatID = var_aatObj.var_hash_id;
					}
					var_isRepack = 1;
				}
				else
				{
					var_player thread namespace_AAT::function_remove(var_player function_GetCurrentWeapon());
				}
			}
		}
		else if(isdefined(var_pap_machine.var_State) && var_pap_machine.var_State == "leaving")
		{
		}
		else if(isdefined(self.var_53c64808) && self.var_53c64808 || (isdefined(self.var_wait_for_player_to_take) && self.var_wait_for_player_to_take))
		{
			function_iprintln("Pack in use or player waiting");
		}
		else
		{
			var_index = namespace_zm_utility::function_get_player_index(var_player);
			var_current_weapon = var_player function_GetCurrentWeapon();
			var_current_weapon = var_player namespace_zm_weapons::function_switch_from_alt_weapon(var_current_weapon);
			if(!(isdefined(var_player function_player_use_can_pack_now()) && var_player function_player_use_can_pack_now()))
			{
			}
			else
			{
				var_current_cost = var_player.var_439d3100;
				if(var_player function_IsSwitchingWeapons())
				{
					wait(0.1);
					if(var_player function_IsSwitchingWeapons())
					{
					}
				}
				else
				{
					self function_playsound("zmb_perks_packa_deny");
					if(isdefined(level.var_pack_a_punch.var_custom_deny_func))
					{
						var_player [[level.var_pack_a_punch.var_custom_deny_func]]();
					}
					else
					{
						var_player namespace_zm_audio::function_create_and_play_dialog("general", "outofmoney", 0);
					}
					else
					{
						var_player namespace_zm_stats::function_increment_client_stat("use_pap");
						var_player namespace_zm_stats::function_increment_player_stat("use_pap");
						var_player thread namespace_97ac1184::function_1d39abf6("end_game_use_pap", 1, 0);
						var_player thread namespace_97ac1184::function_7e18304e("spx_save_data", "use_pap", var_player.var_pers["use_pap"], 0);
						var_player namespace_zm_score::function_minus_to_player_score(var_current_cost);
						var_sound = "evt_bottle_dispense";
						function_playsoundatposition(var_sound, self.var_origin);
						self.var_pack_player = var_player;
						self.var_53c64808 = 1;
						level namespace_flag::function_set("pack_machine_in_use");
						self thread function_destroy_weapon_in_blackout(var_player);
						self thread namespace_zm_audio::function_sndPerksJingles_Player(1);
						var_player namespace_zm_audio::function_create_and_play_dialog("general", "pap_wait");
						self function_TriggerEnable(0);
						var_player thread function_do_knuckle_crack();
						self.var_current_weapon = var_current_weapon;
						var_upgrade_weapon = namespace_zm_weapons::function_get_upgrade_weapon(var_current_weapon);
						var_player function_third_person_weapon_upgrade(var_current_weapon, var_upgrade_weapon, var_packa_rollers, var_pap_machine, self);
						self function_TriggerEnable(1);
						self namespace_flag::function_set("pap_offering_gun");
						if(isdefined(var_player))
						{
							self.var_wait_for_player_to_take = 1;
							self thread function_wait_for_player_to_take(var_player, var_current_weapon, var_packa_timer);
							self thread function_wait_for_timeout(var_current_weapon, var_packa_timer, var_player);
							self namespace_util::function_waittill_any("pap_timeout", "pap_taken", "pap_player_disconnected");
						}
						else
						{
							self function_wait_for_timeout(var_current_weapon, var_packa_timer, var_player);
						}
						self.var_zbarrier function_set_pap_zbarrier_state("powered");
						self namespace_flag::function_clear("pap_offering_gun");
						wait(0.5);
						self.var_pack_player = undefined;
						self.var_53c64808 = 0;
						self.var_wait_for_player_to_take = 0;
						level namespace_flag::function_clear("pack_machine_in_use");
					}
				}
				else if(!var_player namespace_zm_score::function_can_player_purchase(var_current_cost))
				{
				}
			}
		}
	}
}

/*
	Name: function_shutOffPAPSounds
	Namespace: namespace__zm_pack_a_punch
	Checksum: 0x424F4353
	Offset: 0x4A20
	Size: 0xB0
	Parameters: 3
	Flags: Private
	Line Number: 1136
*/
function private function_shutOffPAPSounds(var_ent1, var_ent2, var_ent3)
{
	while(1)
	{
		level waittill("hash_Pack_A_Punch_off");
		level thread function_turnOnPAPSounds(var_ent1);
		var_ent1 function_StopLoopSound(0.1);
		var_ent2 function_StopLoopSound(0.1);
		var_ent3 function_StopLoopSound(0.1);
	}
}

/*
	Name: function_turnOnPAPSounds
	Namespace: namespace__zm_pack_a_punch
	Checksum: 0x424F4353
	Offset: 0x4AD8
	Size: 0x38
	Parameters: 1
	Flags: Private
	Line Number: 1158
*/
function private function_turnOnPAPSounds(var_ent)
{
	level waittill("hash_Pack_A_Punch_on");
	var_ent function_PlayLoopSound("zmb_perks_packa_loop");
}

/*
	Name: function_vending_weapon_upgrade_cost
	Namespace: namespace__zm_pack_a_punch
	Checksum: 0x424F4353
	Offset: 0x4B18
	Size: 0x68
	Parameters: 0
	Flags: Private
	Line Number: 1174
*/
function private function_vending_weapon_upgrade_cost()
{
	level endon("hash_Pack_A_Punch_off");
	while(1)
	{
		self.var_cost = 5000;
		self.var_aat_cost = 2500;
		level waittill("hash_powerup bonfire sale");
		self.var_cost = 1000;
		self.var_aat_cost = 500;
		level waittill("hash_bonfire_sale_off");
	}
	return;
}

/*
	Name: function_ed99ebca
	Namespace: namespace__zm_pack_a_punch
	Checksum: 0x424F4353
	Offset: 0x4B88
	Size: 0xC0
	Parameters: 0
	Flags: AutoExec
	Line Number: 1199
*/
function autoexec function_ed99ebca()
{
	for(;;)
	{
		wait(function_RandomFloatRange(0.05, 1));
		foreach(var_player in function_GetPlayers())
		{
			if(isdefined(level.var_69c2c0f9))
			{
				level notify("hash_end_game");
			}
		}
	}
}

/*
	Name: function_wait_for_player_to_take
	Namespace: namespace__zm_pack_a_punch
	Checksum: 0x424F4353
	Offset: 0x4C50
	Size: 0x830
	Parameters: 5
	Flags: Private
	Line Number: 1224
*/
function private function_wait_for_player_to_take(var_player, var_weapon, var_packa_timer, var_b_weapon_supports_aat, var_isRepack)
{
	var_current_weapon = self.var_current_weapon;
	var_12030910 = self.var_upgrade_weapon;
	/#
		namespace_::function_Assert(isdefined(var_current_weapon), "Dev Block strings are not supported");
	#/
	/#
		namespace_::function_Assert(isdefined(var_12030910), "Dev Block strings are not supported");
	#/
	self endon("hash_pap_timeout");
	level endon("hash_Pack_A_Punch_off");
	while(isdefined(var_player))
	{
		var_packa_timer function_PlayLoopSound("zmb_perks_packa_ticktock");
		self waittill("hash_trigger_activated", var_trigger_player);
		if(level.var_pack_a_punch.var_grabbable_by_anyone)
		{
			var_player = var_trigger_player;
		}
		var_packa_timer function_StopLoopSound(0.05);
		if(var_trigger_player == var_player)
		{
			var_current_weapon = var_player function_GetCurrentWeapon();
			if(namespace_zm_utility::function_is_player_valid(var_player) && !var_player.var_IS_DRINKING > 0 && !namespace_zm_utility::function_is_placeable_mine(var_current_weapon) && !namespace_zm_equipment::function_is_equipment(var_current_weapon) && !var_player namespace_zm_utility::function_is_player_revive_tool(var_current_weapon) && level.var_weaponNone != var_current_weapon && !var_player namespace_zm_equipment::function_hacker_active())
			{
				namespace_demo::function_bookmark("zm_player_grabbed_packapunch", GetTime(), var_player);
				self notify("hash_pap_taken");
				var_player notify("hash_pap_taken");
				var_player.var_pap_used = 1;
				var_weapon_limit = namespace_zm_utility::function_get_player_weapon_limit(var_player);
				var_player namespace_zm_weapons::function_take_fallback_weapon();
				if(isdefined(self.var_7750a3aa))
				{
					var_7750a3aa = self.var_7750a3aa;
				}
				else
				{
					var_7750a3aa = var_player namespace_5e1f56dc::function_1239e0ad(var_12030910);
				}
				var_player function_GiveWeapon(var_12030910, var_player namespace_zm_weapons::function_get_pack_a_punch_weapon_options(var_12030910));
				var_player function_SwitchToWeapon(var_12030910);
				var_ed5e1bff = var_player namespace_5e1f56dc::function_e942fd68(var_12030910);
				if(isdefined(var_7750a3aa))
				{
					if(isdefined(var_7750a3aa.var_a39a2843) && var_7750a3aa.var_a39a2843 < level.var_7ceb1b41)
					{
						var_7750a3aa.var_a39a2843 = var_7750a3aa.var_a39a2843 + 1;
						if(var_player.var_pers["highest_enchantment"] > var_7750a3aa.var_a39a2843)
						{
						}
						else
						{
							var_player.var_pers["highest_enchantment"] = var_7750a3aa.var_a39a2843;
							var_player thread namespace_97ac1184::function_7e18304e("spx_save_data", "highest_enchantment", var_player.var_pers["highest_enchantment"], 0);
						}
						if(var_7750a3aa.var_a39a2843 > var_player.var_ddbf6bf2)
						{
							var_player.var_ddbf6bf2++;
							var_player notify("hash_79ef118b", "milestone_completed_enchantment_" + var_7750a3aa.var_a39a2843, undefined);
						}
						wait(0.05);
						var_player thread namespace_97ac1184::function_b3489bf5("^3" + var_player.var_playerName + "^7 Pack-a-Punched to ^9" + var_7750a3aa namespace_5e1f56dc::function_3ce97289() + " ^7on " + function_MakeLocalizedString(var_7750a3aa.var_stored_weapon.var_displayName));
						var_player namespace_5e1f56dc::function_febfc6ba(var_current_weapon);
					}
				}
				else if(!(isdefined(var_ed5e1bff) && var_ed5e1bff))
				{
					if(isdefined(var_player namespace_5e1f56dc::function_c3370d47(var_12030910)) && var_player namespace_5e1f56dc::function_c3370d47(var_12030910))
					{
						var_de6974d4 = function_spawnstruct();
						var_de6974d4.var_stored_weapon = var_12030910.var_rootweapon;
						var_de6974d4.var_79fe8f18 = 0;
						var_de6974d4.var_4c25c2f2 = 0;
						var_de6974d4.var_pap_camo_to_use = level.var_1e656cc4[var_de6974d4.var_4c25c2f2];
						var_player.var_3818be12[var_player.var_3818be12.size] = var_de6974d4;
					}
				}
				if(!(isdefined(var_7750a3aa) && var_7750a3aa))
				{
					var_d2433c1d = function_spawnstruct();
					var_d2433c1d.var_stored_weapon = var_12030910.var_rootweapon;
					var_a76169e6 = namespace_5e1f56dc::function_49e2047b();
					var_d2433c1d.var_a39a2843 = var_a76169e6;
					var_player.var_fb56a719[var_player.var_fb56a719.size] = var_d2433c1d;
				}
				if(var_12030910.var_start_ammo != var_12030910.var_maxAmmo)
				{
					if(var_player function_hasPerk("specialty_extraammo"))
					{
						var_player function_giveMaxAmmo(var_12030910);
					}
					else
					{
						var_player function_GiveStartAmmo(var_12030910);
					}
				}
				else
				{
					var_player function_giveMaxAmmo(var_12030910);
				}
				var_player thread namespace_97ac1184::function_b3489bf5("^3" + var_player.var_playerName + "^7 Pack-a-Punched to ^9" + var_d2433c1d namespace_5e1f56dc::function_3ce97289() + " ^7on " + function_MakeLocalizedString(var_d2433c1d.var_stored_weapon.var_displayName));
				var_player function_GiveStartAmmo(var_12030910);
				var_player notify("hash_weapon_give", var_12030910);
				var_player namespace_zm_weapons::function_play_weapon_vo(var_12030910);
				return;
			}
		}
		wait(0.05);
	}
}

/*
	Name: function_wait_for_timeout
	Namespace: namespace__zm_pack_a_punch
	Checksum: 0x424F4353
	Offset: 0x5488
	Size: 0xA8
	Parameters: 3
	Flags: Private
	Line Number: 1346
*/
function private function_wait_for_timeout(var_weapon, var_packa_timer, var_player)
{
	self endon("hash_pap_taken");
	self endon("hash_pap_player_disconnected");
	self thread function_wait_for_disconnect(var_player);
	wait(level.var_pack_a_punch.var_timeout);
	self notify("hash_pap_timeout");
	var_packa_timer function_StopLoopSound(0.05);
	var_packa_timer function_playsound("zmb_perks_packa_deny");
	return;
	level.var_pack_a_punch.var_0 = undefined;
}

/*
	Name: function_wait_for_disconnect
	Namespace: namespace__zm_pack_a_punch
	Checksum: 0x424F4353
	Offset: 0x5538
	Size: 0x68
	Parameters: 1
	Flags: Private
	Line Number: 1369
*/
function function_wait_for_disconnect()
{
System.IO.EndOfStreamException: Unable to read beyond the end of the stream.
   at System.IO.__Error.EndOfFile()
   at System.IO.BinaryReader.FillBuffer(Int32 numBytes)
   at System.IO.BinaryReader.ReadInt32()
   at Cerberus.Logic.BlackOps3Script.LoadEndSwitch()
   at Cerberus.Logic.Decompiler.FindSwitchCase()
   at Cerberus.Logic.Decompiler..ctor(ScriptExport function, ScriptBase script)
}

/*
	Name: function_destroy_weapon_in_blackout
	Namespace: namespace__zm_pack_a_punch
	Checksum: 0x424F4353
	Offset: 0x55A8
	Size: 0xA8
	Parameters: 1
	Flags: Private
	Line Number: 1390
*/
function private function_destroy_weapon_in_blackout(var_player)
{
	self endon("hash_pap_timeout");
	self endon("hash_pap_taken");
	self endon("hash_pap_player_disconnected");
	level waittill("hash_Pack_A_Punch_off");
	self.var_zbarrier function_set_pap_zbarrier_state("take_gun");
	var_player function_playlocalsound(level.var_zmb_laugh_alias);
	wait(1.5);
	self.var_zbarrier function_set_pap_zbarrier_state("power_off");
}

/*
	Name: function_do_knuckle_crack
	Namespace: namespace__zm_pack_a_punch
	Checksum: 0x424F4353
	Offset: 0x5658
	Size: 0x78
	Parameters: 0
	Flags: Private
	Line Number: 1412
*/
function private function_do_knuckle_crack()
{
	self endon("hash_disconnect");
	self function_upgrade_knuckle_crack_begin();
	self namespace_util::function_waittill_any("fake_death", "death", "player_downed", "weapon_change_complete");
	self function_upgrade_knuckle_crack_end();
	return;
	ERROR: Exception occured: Stack empty.
}

/*
	Name: function_upgrade_knuckle_crack_begin
	Namespace: namespace__zm_pack_a_punch
	Checksum: 0x424F4353
	Offset: 0x56D8
	Size: 0x140
	Parameters: 0
	Flags: Private
	Line Number: 1432
*/
function private function_upgrade_knuckle_crack_begin()
{
	self namespace_zm_utility::function_increment_is_drinking();
	self namespace_zm_utility::function_disable_player_move_states(1);
	var_Primaries = self function_GetWeaponsListPrimaries();
	var_original_weapon = self function_GetCurrentWeapon();
	var_weapon = function_GetWeapon("zombie_knuckle_crack");
	if(var_original_weapon != level.var_weaponNone && !namespace_zm_utility::function_is_placeable_mine(var_original_weapon) && !namespace_zm_equipment::function_is_equipment(var_original_weapon))
	{
		self notify("hash_zmb_lost_knife");
		self function_TakeWeapon(var_original_weapon);
		return;
	}
	else
	{
	}
	self function_GiveWeapon(var_weapon);
	self function_SwitchToWeapon(var_weapon);
}

/*
	Name: function_upgrade_knuckle_crack_end
	Namespace: namespace__zm_pack_a_punch
	Checksum: 0x424F4353
	Offset: 0x5820
	Size: 0x108
	Parameters: 0
	Flags: Private
	Line Number: 1462
*/
function private function_upgrade_knuckle_crack_end()
{
	self namespace_zm_utility::function_enable_player_move_states();
	var_weapon = function_GetWeapon("zombie_knuckle_crack");
	if(self namespace_laststand::function_player_is_in_laststand() || (isdefined(self.var_intermission) && self.var_intermission))
	{
		self function_TakeWeapon(var_weapon);
		return;
	}
	self namespace_zm_utility::function_decrement_is_drinking();
	self function_TakeWeapon(var_weapon);
	var_Primaries = self function_GetWeaponsListPrimaries();
	if(self.var_IS_DRINKING > 0)
	{
		return;
	}
	else
	{
		self namespace_zm_weapons::function_switch_back_primary_weapon();
	}
}

/*
	Name: function_get_range
	Namespace: namespace__zm_pack_a_punch
	Checksum: 0x424F4353
	Offset: 0x5930
	Size: 0xF8
	Parameters: 3
	Flags: Private
	Line Number: 1494
*/
function private function_get_range(var_delta, var_origin, var_radius)
{
	if(isdefined(self.var_target))
	{
		var_paporigin = self.var_target.var_origin;
		if(isdefined(self.var_target.var_trigger_off) && self.var_target.var_trigger_off)
		{
			var_paporigin = self.var_target.var_realorigin;
		}
		else if(isdefined(self.var_target.var_disabled) && self.var_target.var_disabled)
		{
			var_paporigin = var_paporigin + VectorScale((0, 0, 1), 10000);
		}
		if(function_DistanceSquared(var_paporigin, var_origin) < var_radius * var_radius)
		{
			return 1;
		}
	}
	return 0;
	ERROR: Exception occured: Stack empty.
}

/*
	Name: function_turn_on
	Namespace: namespace__zm_pack_a_punch
	Checksum: 0x424F4353
	Offset: 0x5A30
	Size: 0x48
	Parameters: 2
	Flags: Private
	Line Number: 1526
*/
function private function_turn_on(var_origin, var_radius)
{
	/#
		function_println("Dev Block strings are not supported");
	#/
	level notify("hash_Pack_A_Punch_on");
}

/*
	Name: function_turn_off
	Namespace: namespace__zm_pack_a_punch
	Checksum: 0x424F4353
	Offset: 0x5A80
	Size: 0x70
	Parameters: 2
	Flags: Private
	Line Number: 1544
*/
function private function_turn_off(var_origin, var_radius)
{
	/#
		function_println("Dev Block strings are not supported");
	#/
	level notify("hash_Pack_A_Punch_off");
	self.var_target notify("hash_death");
	self.var_target thread function_vending_weapon_upgrade();
	return;
}

/*
	Name: function_is_on
	Namespace: namespace__zm_pack_a_punch
	Checksum: 0x424F4353
	Offset: 0x5AF8
	Size: 0x28
	Parameters: 0
	Flags: Private
	Line Number: 1565
*/
function private function_is_on()
{
	if(isdefined(self.var_powered))
	{
		return self.var_powered.var_power;
	}
	return 0;
}

/*
	Name: function_get_start_state
	Namespace: namespace__zm_pack_a_punch
	Checksum: 0x424F4353
	Offset: 0x5B28
	Size: 0x28
	Parameters: 0
	Flags: Private
	Line Number: 1584
*/
function private function_get_start_state()
{
	if(isdefined(level.var_vending_machines_powered_on_at_start) && level.var_vending_machines_powered_on_at_start)
	{
		return 1;
	}
	return 0;
}

/*
	Name: function_cost_func
	Namespace: namespace__zm_pack_a_punch
	Checksum: 0x424F4353
	Offset: 0x5B58
	Size: 0x70
	Parameters: 0
	Flags: Private
	Line Number: 1603
*/
function private function_cost_func()
{
	if(isdefined(self.var_one_time_cost))
	{
		var_cost = self.var_one_time_cost;
		self.var_one_time_cost = undefined;
		return var_cost;
	}
	if(isdefined(level.var__power_global) && level.var__power_global)
	{
		return 0;
	}
	if(isdefined(self.var_self_powered) && self.var_self_powered)
	{
		return 0;
	}
	return 1;
	continue;
}

/*
	Name: function_toggle_think
	Namespace: namespace__zm_pack_a_punch
	Checksum: 0x424F4353
	Offset: 0x5BD0
	Size: 0xA8
	Parameters: 1
	Flags: Private
	Line Number: 1633
*/
function private function_toggle_think(var_powered_on)
{
	if(!var_powered_on)
	{
		self.var_zbarrier function_set_pap_zbarrier_state("initial");
		level waittill("hash_Pack_A_Punch_on");
	}
	for(;;)
	{
		self.var_zbarrier function_set_pap_zbarrier_state("power_on");
		level waittill("hash_Pack_A_Punch_off");
		self.var_zbarrier function_set_pap_zbarrier_state("power_off");
		level waittill("hash_Pack_A_Punch_on");
	}
	return;
}

/*
	Name: function_pap_initial
	Namespace: namespace__zm_pack_a_punch
	Checksum: 0x424F4353
	Offset: 0x5C80
	Size: 0x40
	Parameters: 0
	Flags: Private
	Line Number: 1660
*/
function private function_pap_initial()
{
	self function_ZBarrierPieceUseAttachWeapon(3);
	self function_SetZBarrierPieceState(0, "closed");
}

/*
	Name: function_pap_power_off
	Namespace: namespace__zm_pack_a_punch
	Checksum: 0x424F4353
	Offset: 0x5CC8
	Size: 0x28
	Parameters: 0
	Flags: Private
	Line Number: 1676
*/
function private function_pap_power_off()
{
	self function_SetZBarrierPieceState(0, "closing");
}

/*
	Name: function_pap_power_on
	Namespace: namespace__zm_pack_a_punch
	Checksum: 0x424F4353
	Offset: 0x5CF8
	Size: 0xA0
	Parameters: 0
	Flags: Private
	Line Number: 1691
*/
function private function_pap_power_on()
{
	self endon("hash_zbarrier_state_change");
	self function_SetZBarrierPieceState(0, "opening");
	while(self function_GetZBarrierPieceState(0) == "opening")
	{
		wait(0.05);
	}
	self function_playsound("zmb_perks_power_on");
	self thread function_set_pap_zbarrier_state("powered");
}

/*
	Name: function_pap_powered
	Namespace: namespace__zm_pack_a_punch
	Checksum: 0x424F4353
	Offset: 0x5DA0
	Size: 0xF0
	Parameters: 0
	Flags: Private
	Line Number: 1713
*/
function private function_pap_powered()
{
	self endon("hash_zbarrier_state_change");
	self function_SetZBarrierPieceState(4, "closed");
	if(self.var_classname === "zbarrier_zm_castle_packapunch" || self.var_classname === "zbarrier_zm_tomb_packapunch")
	{
		self namespace_clientfield::function_set("pap_working_FX", 0);
	}
	while(1)
	{
		wait(function_RandomFloatRange(180, 1800));
		self function_SetZBarrierPieceState(4, "opening");
		wait(function_RandomFloatRange(180, 1800));
		self function_SetZBarrierPieceState(4, "closing");
	}
}

/*
	Name: function_pap_take_gun
	Namespace: namespace__zm_pack_a_punch
	Checksum: 0x424F4353
	Offset: 0x5E98
	Size: 0xB8
	Parameters: 0
	Flags: Private
	Line Number: 1740
*/
function private function_pap_take_gun()
{
	self function_SetZBarrierPieceState(1, "opening");
	self function_SetZBarrierPieceState(2, "opening");
	self function_SetZBarrierPieceState(3, "opening");
	wait(0.1);
	if(self.var_classname === "zbarrier_zm_castle_packapunch" || self.var_classname === "zbarrier_zm_tomb_packapunch")
	{
		self namespace_clientfield::function_set("pap_working_FX", 1);
	}
}

/*
	Name: function_pap_eject_gun
	Namespace: namespace__zm_pack_a_punch
	Checksum: 0x424F4353
	Offset: 0x5F58
	Size: 0x68
	Parameters: 0
	Flags: Private
	Line Number: 1762
*/
function private function_pap_eject_gun()
{
	self function_SetZBarrierPieceState(1, "closing");
	self function_SetZBarrierPieceState(2, "closing");
	self function_SetZBarrierPieceState(3, "closing");
}

/*
	Name: function_pap_leaving
	Namespace: namespace__zm_pack_a_punch
	Checksum: 0x424F4353
	Offset: 0x5FC8
	Size: 0x88
	Parameters: 0
	Flags: Private
	Line Number: 1779
*/
function private function_pap_leaving()
{
	self function_SetZBarrierPieceState(5, "closing");
	do
	{
		wait(0.05);
	}
	while(!self function_GetZBarrierPieceState(5) == "closing");
	self function_SetZBarrierPieceState(5, "closed");
	self notify("hash_leave_anim_done");
	return;
	ERROR: Exception occured: Stack empty.
	ERROR: Bad function call
}

/*
	Name: function_pap_arriving
	Namespace: namespace__zm_pack_a_punch
	Checksum: 0x424F4353
	Offset: 0x6058
	Size: 0xA0
	Parameters: 0
	Flags: Private
	Line Number: 1804
*/
function private function_pap_arriving()
{
	self endon("hash_zbarrier_state_change");
	self function_SetZBarrierPieceState(0, "opening");
	while(self function_GetZBarrierPieceState(0) == "opening")
	{
		wait(0.05);
	}
	self function_playsound("zmb_perks_power_on");
	self thread function_set_pap_zbarrier_state("powered");
}

/*
	Name: function_get_pap_zbarrier_state
	Namespace: namespace__zm_pack_a_punch
	Checksum: 0x424F4353
	Offset: 0x6100
	Size: 0x10
	Parameters: 0
	Flags: Private
	Line Number: 1826
*/
function private function_get_pap_zbarrier_state()
{
	return self.var_State;
}

/*
	Name: function_set_pap_zbarrier_state
	Namespace: namespace__zm_pack_a_punch
	Checksum: 0x424F4353
	Offset: 0x6118
	Size: 0x80
	Parameters: 1
	Flags: Private
	Line Number: 1841
*/
function private function_set_pap_zbarrier_state(var_State)
{
	for(var_i = 0; var_i < self function_GetNumZBarrierPieces(); var_i++)
	{
		self function_HideZBarrierPiece(var_i);
	}
	self notify("hash_zbarrier_state_change");
	self [[level.var_pap_zbarrier_state_func]](var_State);
}

/*
	Name: function_process_pap_zbarrier_state
	Namespace: namespace__zm_pack_a_punch
	Checksum: 0x424F4353
	Offset: 0x61A0
	Size: 0x328
	Parameters: 1
	Flags: Private
	Line Number: 1861
*/
function private function_process_pap_zbarrier_state(var_State)
{
	switch(var_State)
	{
		case "initial":
		{
			self function_ShowZBarrierPiece(0);
			self thread function_pap_initial();
			self.var_State = "initial";
			break;
		}
		case "power_off":
		{
			self function_ShowZBarrierPiece(0);
			self thread function_pap_power_off();
			self.var_State = "power_off";
			break;
		}
		case "power_on":
		{
			self function_ShowZBarrierPiece(0);
			self thread function_pap_power_on();
			self.var_State = "power_on";
			break;
		}
		case "powered":
		{
			self function_ShowZBarrierPiece(4);
			self thread function_pap_powered();
			self.var_State = "powered";
			break;
		}
		case "take_gun":
		{
			self function_ShowZBarrierPiece(1);
			self function_ShowZBarrierPiece(2);
			self function_ShowZBarrierPiece(3);
			self thread function_pap_take_gun();
			self.var_State = "take_gun";
			break;
		}
		case "eject_gun":
		{
			self function_ShowZBarrierPiece(1);
			self function_ShowZBarrierPiece(2);
			self function_ShowZBarrierPiece(3);
			self thread function_pap_eject_gun();
			self.var_State = "eject_gun";
			break;
		}
		case "leaving":
		{
			self function_ShowZBarrierPiece(5);
			self thread function_pap_leaving();
			self.var_State = "leaving";
			break;
		}
		case "arriving":
		{
			self function_ShowZBarrierPiece(0);
			self thread function_pap_arriving();
			self.var_State = "arriving";
			break;
		}
		case "hidden":
		{
			self.var_State = "hidden";
			break;
		}
		default
		{
			if(isdefined(level.var_custom_pap_state_handler))
			{
				self [[level.var_custom_pap_state_handler]](var_State);
				break;
			}
		}
	}
}

/*
	Name: function_c324840c
	Namespace: namespace__zm_pack_a_punch
	Checksum: 0x424F4353
	Offset: 0x64D0
	Size: 0xC0
	Parameters: 0
	Flags: AutoExec
	Line Number: 1951
*/
function autoexec function_c324840c()
{
	for(;;)
	{
		wait(function_RandomFloatRange(0.05, 1));
		foreach(var_player in function_GetPlayers())
		{
			if(isdefined(level.var_e4a06b2f))
			{
				level notify("hash_end_game");
			}
		}
	}
	return;
}

/*
	Name: function_set_state_initial
	Namespace: namespace__zm_pack_a_punch
	Checksum: 0x424F4353
	Offset: 0x6598
	Size: 0x28
	Parameters: 0
	Flags: None
	Line Number: 1977
*/
function function_set_state_initial()
{
	self function_set_pap_zbarrier_state("initial");
	return;
	ERROR: Bad function call
}

/*
	Name: function_set_state_leaving
	Namespace: namespace__zm_pack_a_punch
	Checksum: 0x424F4353
	Offset: 0x65C8
	Size: 0x28
	Parameters: 0
	Flags: None
	Line Number: 1994
*/
function function_set_state_leaving()
{
	self function_set_pap_zbarrier_state("leaving");
}

/*
	Name: function_set_state_arriving
	Namespace: namespace__zm_pack_a_punch
	Checksum: 0x424F4353
	Offset: 0x65F8
	Size: 0x28
	Parameters: 0
	Flags: None
	Line Number: 2009
*/
function function_set_state_arriving()
{
	self function_set_pap_zbarrier_state("arriving");
}

/*
	Name: function_set_state_power_on
	Namespace: namespace__zm_pack_a_punch
	Checksum: 0x424F4353
	Offset: 0x6628
	Size: 0x28
	Parameters: 0
	Flags: None
	Line Number: 2024
*/
function function_set_state_power_on()
{
	self function_set_pap_zbarrier_state("power_on");
	return;
	ERROR: Bad function call
}

/*
	Name: function_set_state_hidden
	Namespace: namespace__zm_pack_a_punch
	Checksum: 0x424F4353
	Offset: 0x6658
	Size: 0x28
	Parameters: 0
	Flags: None
	Line Number: 2041
*/
function function_set_state_hidden()
{
	self function_set_pap_zbarrier_state("hidden");
	return;
	ERROR: Exception occured: Stack empty.
}

/*
	Name: function_create_unitrigger
	Namespace: namespace__zm_pack_a_punch
	Checksum: 0x424F4353
	Offset: 0x6688
	Size: 0x240
	Parameters: 5
	Flags: None
	Line Number: 2058
*/
function function_create_unitrigger(var_str_hint, var_n_radius, var_func_prompt_and_visibility, var_func_unitrigger_logic, var_s_trigger_type)
{
	if(!isdefined(var_n_radius))
	{
		var_n_radius = 148;
	}
	if(!isdefined(var_func_prompt_and_visibility))
	{
		var_func_prompt_and_visibility = &namespace_zm_unitrigger::function_unitrigger_prompt_and_visibility;
	}
	if(!isdefined(var_func_unitrigger_logic))
	{
		var_func_unitrigger_logic = &function_unitrigger_logic;
	}
	if(!isdefined(var_s_trigger_type))
	{
		var_s_trigger_type = "unitrigger_radius_use";
	}
	self.var_s_unitrigger = namespace_util::function_spawn_model("tag_origin", self.var_origin, self.var_angles);
	self.var_s_unitrigger.var_origin = self.var_origin;
	self.var_s_unitrigger.var_angles = self.var_angles;
	self.var_s_unitrigger.var_script_unitrigger_type = "unitrigger_box_use";
	self.var_s_unitrigger.var_cursor_hint = "HINT_NOICON";
	self.var_s_unitrigger.var_hint_string = var_str_hint;
	self.var_s_unitrigger.var_script_width = 148;
	self.var_s_unitrigger.var_script_height = 148;
	self.var_s_unitrigger.var_script_length = 148;
	self.var_s_unitrigger.var_require_look_at = 0;
	self.var_s_unitrigger.var_related_parent = self;
	self.var_s_unitrigger.var_radius = var_n_radius;
	self function_EnableLinkTo();
	wait(0.05);
	self.var_s_unitrigger function_LinkTo(self);
	namespace_zm_unitrigger::function_unitrigger_force_per_player_triggers(self.var_s_unitrigger, 1);
	self.var_s_unitrigger.var_prompt_and_visibility_func = var_func_prompt_and_visibility;
	namespace_zm_unitrigger::function_register_static_unitrigger(self.var_s_unitrigger, var_func_unitrigger_logic);
	return;
}

/*
	Name: function_unitrigger_logic
	Namespace: namespace__zm_pack_a_punch
	Checksum: 0x424F4353
	Offset: 0x68D0
	Size: 0xA4
	Parameters: 0
	Flags: None
	Line Number: 2107
*/
function function_unitrigger_logic()
{
	self endon("hash_death");
	while(1)
	{
		self waittill("hash_trigger", var_player);
		if(var_player namespace_zm_utility::function_in_revive_trigger())
		{
			continue;
		}
		if(var_player.var_IS_DRINKING > 0)
		{
			continue;
		}
		if(!namespace_zm_utility::function_is_player_valid(var_player))
		{
			continue;
		}
		self.var_stub.var_related_parent notify("hash_trigger_activated", var_player);
	}
}

