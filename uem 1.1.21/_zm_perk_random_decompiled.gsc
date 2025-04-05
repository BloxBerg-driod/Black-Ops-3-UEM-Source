#include scripts\shared\array_shared;
#include scripts\shared\clientfield_shared;
#include scripts\shared\flag_shared;
#include scripts\shared\flagsys_shared;
#include scripts\shared\scene_shared;
#include scripts\shared\system_shared;
#include scripts\shared\util_shared;
#include scripts\zm\_zm_devgui;
#include scripts\zm\_zm_equipment;
#include scripts\zm\_zm_perks;
#include scripts\zm\_zm_score;
#include scripts\zm\_zm_stats;
#include scripts\zm\_zm_unitrigger;
#include scripts\zm\_zm_utility;

#namespace namespace_zm_perk_random;

/*
	Name: function___init__sytem__
	Namespace: namespace_zm_perk_random
	Checksum: 0x424F4353
	Offset: 0x6E0
	Size: 0x40
	Parameters: 0
	Flags: AutoExec
	Line Number: 27
*/
function autoexec function___init__sytem__()
{
	namespace_system::function_register("zm_perk_random", &function___init__, &function___main__, undefined);
	return;
	ERROR: Exception occured: Stack empty.
}

/*
	Name: function___init__
	Namespace: namespace_zm_perk_random
	Checksum: 0x424F4353
	Offset: 0x728
	Size: 0x250
	Parameters: 0
	Flags: None
	Line Number: 44
*/
function function___init__()
{
	level.var__random_zombie_perk_cost = 1500;
	namespace_clientfield::function_register("scriptmover", "perk_bottle_cycle_state", 5000, 2, "int");
	namespace_clientfield::function_register("zbarrier", "set_client_light_state", 5000, 2, "int");
	namespace_clientfield::function_register("zbarrier", "client_stone_emmissive_blink", 5000, 1, "int");
	namespace_clientfield::function_register("zbarrier", "init_perk_random_machine", 5000, 1, "int");
	namespace_clientfield::function_register("scriptmover", "turn_active_perk_light_green", 5000, 1, "int");
	namespace_clientfield::function_register("scriptmover", "turn_on_location_indicator", 5000, 1, "int");
	namespace_clientfield::function_register("zbarrier", "lightning_bolt_FX_toggle", 10000, 1, "int");
	namespace_clientfield::function_register("scriptmover", "turn_active_perk_ball_light", 5000, 1, "int");
	namespace_clientfield::function_register("scriptmover", "zone_captured", 5000, 1, "int");
	level.var__effect["perk_machine_light_yellow"] = "dlc1/castle/fx_wonder_fizz_light_yellow";
	level.var__effect["perk_machine_light_red"] = "dlc1/castle/fx_wonder_fizz_light_red";
	level.var__effect["perk_machine_light_green"] = "dlc1/castle/fx_wonder_fizz_light_green";
	level.var__effect["perk_machine_location"] = "fx/zombie/fx_wonder_fizz_lightning_all";
	level namespace_flag::function_init("machine_can_reset");
	return;
	ERROR: Exception occured: Stack empty.
}

/*
	Name: function___main__
	Namespace: namespace_zm_perk_random
	Checksum: 0x424F4353
	Offset: 0x980
	Size: 0x70
	Parameters: 0
	Flags: None
	Line Number: 75
*/
function function___main__()
{
	if(!isdefined(level.var_perk_random_machine_count))
	{
		level.var_perk_random_machine_count = 1;
	}
	if(!isdefined(level.var_perk_random_machine_state_func))
	{
		level.var_perk_random_machine_state_func = &function_process_perk_random_machine_state;
	}
	/#
		level thread function_setup_devgui();
	#/
	level thread function_setup_perk_random_machines();
	return;
}

/*
	Name: function_setup_perk_random_machines
	Namespace: namespace_zm_perk_random
	Checksum: 0x424F4353
	Offset: 0x9F8
	Size: 0x80
	Parameters: 0
	Flags: Private
	Line Number: 102
*/
function private function_setup_perk_random_machines()
{
	waittillframeend;
	level.var_perk_bottle_weapon_array = function_ArrayCombine(level.var_machine_assets, level.var__custom_perks, 0, 1);
	level.var_perk_random_machines = function_GetEntArray("perk_random_machine", "targetname");
	level.var_perk_random_machine_count = level.var_perk_random_machines.size;
	function_perk_random_machine_init();
}

/*
	Name: function_perk_random_machine_init
	Namespace: namespace_zm_perk_random
	Checksum: 0x424F4353
	Offset: 0xA80
	Size: 0x150
	Parameters: 0
	Flags: None
	Line Number: 121
*/
function function_perk_random_machine_init()
{
	foreach(var_machine in level.var_perk_random_machines)
	{
		if(!isdefined(var_machine.var_cost))
		{
			var_machine.var_cost = 1500;
		}
		var_machine.var_current_perk_random_machine = 0;
		var_machine.var_uses_at_current_location = 0;
		var_machine function_create_perk_random_machine_unitrigger_stub();
		var_machine namespace_clientfield::function_set("init_perk_random_machine", 1);
		wait(0.5);
		var_machine thread function_set_perk_random_machine_state("power_off");
	}
	level.var_perk_random_machines = namespace_Array::function_randomize(level.var_perk_random_machines);
	function_init_starting_perk_random_machine_location();
}

/*
	Name: function_init_starting_perk_random_machine_location
	Namespace: namespace_zm_perk_random
	Checksum: 0x424F4353
	Offset: 0xBD8
	Size: 0x140
	Parameters: 0
	Flags: Private
	Line Number: 150
*/
function private function_init_starting_perk_random_machine_location()
{
	var_b_starting_machine_found = 0;
	for(var_i = 0; var_i < level.var_perk_random_machines.size; var_i++)
	{
		if(isdefined(level.var_perk_random_machines[var_i].var_script_noteworthy) && function_IsSubStr(level.var_perk_random_machines[var_i].var_script_noteworthy, "start_perk_random_machine") && (!(isdefined(var_b_starting_machine_found) && var_b_starting_machine_found)))
		{
			level.var_perk_random_machines[var_i].var_current_perk_random_machine = 1;
			level.var_perk_random_machines[var_i] thread function_machine_think();
			level.var_perk_random_machines[var_i] thread function_set_perk_random_machine_state("initial");
			var_b_starting_machine_found = 1;
			continue;
		}
		level.var_perk_random_machines[var_i] thread function_wait_for_power();
	}
	return;
	ERROR: Exception occured: Stack empty.
}

/*
	Name: function_create_perk_random_machine_unitrigger_stub
	Namespace: namespace_zm_perk_random
	Checksum: 0x424F4353
	Offset: 0xD20
	Size: 0x188
	Parameters: 0
	Flags: None
	Line Number: 179
*/
function function_create_perk_random_machine_unitrigger_stub()
{
	self.var_unitrigger_stub = function_spawnstruct();
	self.var_unitrigger_stub.var_script_width = 70;
	self.var_unitrigger_stub.var_script_height = 30;
	self.var_unitrigger_stub.var_script_length = 40;
	self.var_unitrigger_stub.var_origin = self.var_origin + function_AnglesToRight(self.var_angles) * self.var_unitrigger_stub.var_script_length + function_anglesToUp(self.var_angles) * self.var_unitrigger_stub.var_script_height / 2;
	self.var_unitrigger_stub.var_angles = self.var_angles;
	self.var_unitrigger_stub.var_script_unitrigger_type = "unitrigger_box_use";
	self.var_unitrigger_stub.var_trigger_target = self;
	namespace_zm_unitrigger::function_unitrigger_force_per_player_triggers(self.var_unitrigger_stub, 1);
	self.var_unitrigger_stub.var_prompt_and_visibility_func = &function_perk_random_machine_trigger_update_prompt;
	self.var_unitrigger_stub.var_script_int = self.var_script_int;
	thread namespace_zm_unitrigger::function_register_static_unitrigger(self.var_unitrigger_stub, &function_perk_random_unitrigger_think);
}

/*
	Name: function_perk_random_machine_trigger_update_prompt
	Namespace: namespace_zm_perk_random
	Checksum: 0x424F4353
	Offset: 0xEB0
	Size: 0x90
	Parameters: 1
	Flags: None
	Line Number: 205
*/
function function_perk_random_machine_trigger_update_prompt(var_player)
{
	var_can_use = self function_perk_random_machine_stub_update_prompt(var_player);
	if(isdefined(self.var_hint_string))
	{
		if(isdefined(self.var_hint_parm1))
		{
			self function_setHintString(self.var_hint_string, self.var_hint_parm1);
		}
		else
		{
			self function_setHintString(self.var_hint_string);
		}
	}
	return var_can_use;
}

/*
	Name: function_perk_random_machine_stub_update_prompt
	Namespace: namespace_zm_perk_random
	Checksum: 0x424F4353
	Offset: 0xF48
	Size: 0x290
	Parameters: 1
	Flags: None
	Line Number: 232
*/
function function_perk_random_machine_stub_update_prompt(var_player)
{
	self function_setcursorhint("HINT_NOICON");
	if(!self function_trigger_visible_to_player(var_player))
	{
		return 0;
	}
	self.var_hint_parm1 = undefined;
	var_n_power_on = function_is_power_on(self.var_stub.var_script_int);
	if(!var_n_power_on)
	{
		self.var_hint_string = &"ZOMBIE_NEED_POWER";
		return 0;
	}
	else if(self.var_stub.var_trigger_target.var_State == "idle" || self.var_stub.var_trigger_target.var_State == "vending")
	{
		var_n_purchase_limit = var_player namespace_zm_utility::function_get_player_perk_purchase_limit();
		if(!var_player namespace_zm_utility::function_can_player_purchase_perk())
		{
			self.var_hint_string = &"ZOMBIE_RANDOM_PERK_TOO_MANY";
			if(isdefined(var_n_purchase_limit))
			{
				self.var_hint_parm1 = var_n_purchase_limit;
			}
			return 0;
		}
		else if(isdefined(self.var_stub.var_trigger_target.var_machine_user))
		{
			if(isdefined(self.var_stub.var_trigger_target.var_grab_perk_hint) && self.var_stub.var_trigger_target.var_grab_perk_hint)
			{
				self.var_hint_string = &"ZOMBIE_RANDOM_PERK_PICKUP";
				return 1;
			}
			else
			{
				self.var_hint_string = "";
				return 0;
			}
		}
		else
		{
			var_n_purchase_limit = var_player namespace_zm_utility::function_get_player_perk_purchase_limit();
			if(!var_player namespace_zm_utility::function_can_player_purchase_perk())
			{
				self.var_hint_string = &"ZOMBIE_RANDOM_PERK_TOO_MANY";
				if(isdefined(var_n_purchase_limit))
				{
					self.var_hint_parm1 = var_n_purchase_limit;
				}
				return 0;
			}
			else
			{
				self.var_hint_string = &"ZOMBIE_RANDOM_PERK_BUY";
				self.var_hint_parm1 = level.var__random_zombie_perk_cost + var_player.var_num_perks * 250;
				return 1;
			}
		}
	}
	else
	{
		self.var_hint_string = &"ZOMBIE_RANDOM_PERK_ELSEWHERE";
		return 0;
		return;
	}
	ERROR: Exception occured: Stack empty.
}

/*
	Name: function_trigger_visible_to_player
	Namespace: namespace_zm_perk_random
	Checksum: 0x424F4353
	Offset: 0x11E0
	Size: 0x128
	Parameters: 1
	Flags: None
	Line Number: 310
*/
function function_trigger_visible_to_player(var_player)
{
	self function_SetInvisibleToPlayer(var_player);
	var_visible = 1;
	if(isdefined(self.var_stub.var_trigger_target.var_machine_user))
	{
		if(var_player != self.var_stub.var_trigger_target.var_machine_user || namespace_zm_utility::function_is_placeable_mine(self.var_stub.var_trigger_target.var_machine_user function_GetCurrentWeapon()))
		{
			var_visible = 0;
		}
	}
	else if(!var_player function_can_buy_perk())
	{
		var_visible = 0;
	}
	if(!var_visible)
	{
		return 0;
	}
	if(var_player function_player_has_all_available_perks())
	{
		return 0;
	}
	self function_SetVisibleToPlayer(var_player);
	return 1;
}

/*
	Name: function_player_has_all_available_perks
	Namespace: namespace_zm_perk_random
	Checksum: 0x424F4353
	Offset: 0x1310
	Size: 0x58
	Parameters: 0
	Flags: None
	Line Number: 347
*/
function function_player_has_all_available_perks()
{
	for(var_i = 0; var_i < level.var__random_perk_machine_perk_list.size; var_i++)
	{
		if(!self function_hasPerk(level.var__random_perk_machine_perk_list[var_i]))
		{
			return 0;
		}
	}
	return 1;
}

/*
	Name: function_can_buy_perk
	Namespace: namespace_zm_perk_random
	Checksum: 0x424F4353
	Offset: 0x1370
	Size: 0xA8
	Parameters: 0
	Flags: None
	Line Number: 369
*/
function function_can_buy_perk()
{
	if(isdefined(self.var_IS_DRINKING) && self.var_IS_DRINKING > 0)
	{
		return 0;
	}
	var_current_weapon = self function_GetCurrentWeapon();
	if(namespace_zm_utility::function_is_placeable_mine(var_current_weapon) || namespace_zm_equipment::function_is_equipment_that_blocks_purchase(var_current_weapon))
	{
		return 0;
	}
	if(self namespace_zm_utility::function_in_revive_trigger())
	{
		return 0;
	}
	if(var_current_weapon == level.var_weaponNone)
	{
		return 0;
	}
	return 1;
}

/*
	Name: function_perk_random_unitrigger_think
	Namespace: namespace_zm_perk_random
	Checksum: 0x424F4353
	Offset: 0x1420
	Size: 0x58
	Parameters: 1
	Flags: None
	Line Number: 401
*/
function function_perk_random_unitrigger_think(var_player)
{
	self endon("hash_kill_trigger");
	while(1)
	{
		self waittill("hash_trigger", var_player);
		self.var_stub.var_trigger_target notify("hash_trigger", var_player);
	}
}

/*
	Name: function_machine_think
	Namespace: namespace_zm_perk_random
	Checksum: 0x424F4353
	Offset: 0x1480
	Size: 0x6C8
	Parameters: 0
	Flags: None
	Line Number: 421
*/
function function_machine_think()
{
	level notify("hash_machine_think");
	level endon("hash_machine_think");
	self.var_num_time_used = 0;
	self.var_num_til_moved = function_randomIntRange(3, 7);
	if(self.var_State !== "initial" || "idle")
	{
		self thread function_set_perk_random_machine_state("arrive");
		self waittill("hash_arrived");
		self thread function_set_perk_random_machine_state("initial");
		wait(1);
	}
	if(isdefined(level.var_zm_custom_perk_random_power_flag))
	{
		level namespace_flag::function_wait_till(level.var_zm_custom_perk_random_power_flag);
	}
	else
	{
		wait(1);
	}
	while(!function_is_power_on(self.var_script_int))
	{
	}
	self thread function_set_perk_random_machine_state("idle");
	if(isdefined(level.var_bottle_spawn_location))
	{
		level.var_bottle_spawn_location function_delete();
	}
	level.var_bottle_spawn_location = function_spawn("script_model", self.var_origin);
	level.var_bottle_spawn_location function_SetModel("tag_origin");
	level.var_bottle_spawn_location.var_angles = self.var_angles;
	level.var_bottle_spawn_location.var_origin = level.var_bottle_spawn_location.var_origin + VectorScale((0, 0, 1), 65);
	while(1)
	{
		self waittill("hash_trigger", var_player);
		level namespace_flag::function_clear("machine_can_reset");
		if(!var_player namespace_zm_score::function_can_player_purchase(level.var__random_zombie_perk_cost + var_player.var_num_perks * 250))
		{
			self function_playsound("evt_perk_deny");
			continue;
		}
		self.var_machine_user = var_player;
		self.var_num_time_used++;
		var_player namespace_zm_stats::function_increment_client_stat("use_perk_random");
		var_player namespace_zm_stats::function_increment_player_stat("use_perk_random");
		var_player namespace_zm_stats::function_increment_player_stat("wunderfizz_used");
		var_player namespace_zm_score::function_minus_to_player_score(level.var__random_zombie_perk_cost + var_player.var_num_perks * 250);
		self thread function_set_perk_random_machine_state("vending");
		if(isdefined(level.var_perk_random_vo_func_usemachine) && isdefined(var_player))
		{
			var_player thread [[level.var_perk_random_vo_func_usemachine]]();
		}
		while(1)
		{
			var_random_perk = function_get_weighted_random_perk(var_player);
			self function_playsound("zmb_rand_perk_start");
			self function_PlayLoopSound("zmb_rand_perk_loop", 1);
			wait(1);
			self notify("hash_bottle_spawned");
			self thread function_start_perk_bottle_cycling();
			self thread function_perk_bottle_motion();
			var_model = function_get_perk_weapon_model(var_random_perk);
			wait(3);
			self notify("hash_done_cycling");
			if(self.var_num_time_used >= self.var_num_til_moved && level.var_perk_random_machine_count > 1)
			{
				level.var_bottle_spawn_location function_SetModel("wpn_t7_zmb_perk_bottle_bear_world");
				self function_StopLoopSound(0.5);
				self thread function_set_perk_random_machine_state("leaving");
				wait(3);
				var_player namespace_zm_score::function_add_to_player_score(level.var__random_zombie_perk_cost + var_player.var_num_perks * 250);
				level.var_bottle_spawn_location function_SetModel("tag_origin");
				self thread function_machine_selector();
				self namespace_clientfield::function_set("lightning_bolt_FX_toggle", 0);
				self.var_machine_user = undefined;
				break;
			}
			else
			{
				level.var_bottle_spawn_location function_SetModel(var_model);
			}
			self function_playsound("zmb_rand_perk_bottle");
			self.var_grab_perk_hint = 1;
			self thread function_grab_check(var_player, var_random_perk);
			self thread function_time_out_check();
			self namespace_util::function_waittill_either("grab_check", "time_out_check");
			self.var_grab_perk_hint = 0;
			self function_playsound("zmb_rand_perk_stop");
			self function_StopLoopSound(0.5);
			self.var_machine_user = undefined;
			level.var_bottle_spawn_location function_SetModel("tag_origin");
			self thread function_set_perk_random_machine_state("idle");
			break;
		}
		level namespace_flag::function_wait_till("machine_can_reset");
	}
}

/*
	Name: function_grab_check
	Namespace: namespace_zm_perk_random
	Checksum: 0x424F4353
	Offset: 0x1B50
	Size: 0x268
	Parameters: 2
	Flags: None
	Line Number: 530
*/
function function_grab_check(var_player, var_random_perk)
{
	self endon("hash_time_out_check");
	var_perk_is_bought = 0;
	while(!var_perk_is_bought)
	{
		self waittill("hash_trigger", var_e_triggerer);
		if(var_e_triggerer == var_player)
		{
			if(isdefined(var_player.var_IS_DRINKING) && var_player.var_IS_DRINKING > 0)
			{
				wait(0.1);
				continue;
			}
			if(var_player namespace_zm_utility::function_can_player_purchase_perk())
			{
				var_perk_is_bought = 1;
			}
			else
			{
				self function_playsound("evt_perk_deny");
				self notify("hash_time_out_or_perk_grab");
				return;
			}
		}
	}
	var_player namespace_zm_stats::function_increment_client_stat("grabbed_from_perk_random");
	var_player namespace_zm_stats::function_increment_player_stat("grabbed_from_perk_random");
	var_player thread function_monitor_when_player_acquires_perk();
	self notify("hash_grab_check");
	self notify("hash_time_out_or_perk_grab");
	var_player notify("hash_perk_purchased", var_random_perk);
	var_gun = var_player namespace_zm_perks::function_perk_give_bottle_begin(var_random_perk);
	var_evt = var_player namespace_util::function_waittill_any_ex("fake_death", "death", "player_downed", "weapon_change_complete", self, "time_out_check");
	if(var_evt == "weapon_change_complete")
	{
		var_player thread namespace_zm_perks::function_wait_give_perk(var_random_perk, 1);
	}
	var_player namespace_zm_perks::function_perk_give_bottle_end(var_gun, var_random_perk);
	if(!(isdefined(var_player.var_has_drunk_wunderfizz) && var_player.var_has_drunk_wunderfizz))
	{
		var_player.var_has_drunk_wunderfizz = 1;
	}
}

/*
	Name: function_monitor_when_player_acquires_perk
	Namespace: namespace_zm_perk_random
	Checksum: 0x424F4353
	Offset: 0x1DC0
	Size: 0x58
	Parameters: 0
	Flags: None
	Line Number: 585
*/
function function_monitor_when_player_acquires_perk()
{
	self namespace_util::function_waittill_any("perk_acquired", "death_or_disconnect", "player_downed");
	level namespace_flag::function_set("machine_can_reset");
}

/*
	Name: function_time_out_check
	Namespace: namespace_zm_perk_random
	Checksum: 0x424F4353
	Offset: 0x1E20
	Size: 0x48
	Parameters: 0
	Flags: None
	Line Number: 601
*/
function function_time_out_check()
{
	self endon("hash_grab_check");
	wait(10);
	self notify("hash_time_out_check");
	level namespace_flag::function_set("machine_can_reset");
}

/*
	Name: function_wait_for_power
	Namespace: namespace_zm_perk_random
	Checksum: 0x424F4353
	Offset: 0x1E70
	Size: 0xB8
	Parameters: 0
	Flags: None
	Line Number: 619
*/
function function_wait_for_power()
{
	if(isdefined(self.var_script_int))
	{
		var_str_wait = "power_on" + self.var_script_int;
		level namespace_flag::function_wait_till(var_str_wait);
	}
	else if(isdefined(level.var_zm_custom_perk_random_power_flag))
	{
		level namespace_flag::function_wait_till(level.var_zm_custom_perk_random_power_flag);
	}
	else
	{
		level namespace_flag::function_wait_till("power_on");
	}
	self thread function_set_perk_random_machine_state("away");
}

/*
	Name: function_machine_selector
	Namespace: namespace_zm_perk_random
	Checksum: 0x424F4353
	Offset: 0x1F30
	Size: 0xC8
	Parameters: 0
	Flags: None
	Line Number: 647
*/
function function_machine_selector()
{
	if(level.var_perk_random_machines.size == 1)
	{
		var_new_machine = level.var_perk_random_machines[0];
		var_new_machine thread function_machine_think();
	}
	else
	{
		var_new_machine = level.var_perk_random_machines[function_RandomInt(level.var_perk_random_machines.size)];
		var_new_machine.var_current_perk_random_machine = 1;
		self.var_current_perk_random_machine = 0;
		wait(10);
		var_new_machine thread function_machine_think();
	}
	do
	{
	}
	while(!var_new_machine.var_current_perk_random_machine == 1);
}

/*
	Name: function_include_perk_in_random_rotation
	Namespace: namespace_zm_perk_random
	Checksum: 0x424F4353
	Offset: 0x2000
	Size: 0x98
	Parameters: 1
	Flags: None
	Line Number: 678
*/
function function_include_perk_in_random_rotation(var_perk)
{
	if(!isdefined(level.var__random_perk_machine_perk_list))
	{
		level.var__random_perk_machine_perk_list = [];
	}
	if(!isdefined(level.var__random_perk_machine_perk_list))
	{
		level.var__random_perk_machine_perk_list = [];
	}
	else if(!function_IsArray(level.var__random_perk_machine_perk_list))
	{
		level.var__random_perk_machine_perk_list = function_Array(level.var__random_perk_machine_perk_list);
	}
	level.var__random_perk_machine_perk_list[level.var__random_perk_machine_perk_list.size] = var_perk;
}

/*
	Name: function_get_weighted_random_perk
	Namespace: namespace_zm_perk_random
	Checksum: 0x424F4353
	Offset: 0x20A0
	Size: 0x150
	Parameters: 1
	Flags: None
	Line Number: 705
*/
function function_get_weighted_random_perk(var_player)
{
	var_keys = namespace_Array::function_randomize(function_getArrayKeys(level.var__random_perk_machine_perk_list));
	if(isdefined(level.var_custom_random_perk_weights))
	{
		var_keys = var_player [[level.var_custom_random_perk_weights]]();
	}
	/#
		var_forced_perk = function_GetDvarString("Dev Block strings are not supported");
		if(var_forced_perk != "Dev Block strings are not supported" && isdefined(level.var__random_perk_machine_perk_list[var_forced_perk]))
		{
			function_ArrayInsert(var_keys, var_forced_perk, 0);
		}
	#/
	for(var_i = 0; var_i < var_keys.size; var_i++)
	{
		if(var_player function_hasPerk(level.var__random_perk_machine_perk_list[var_keys[var_i]]))
		{
			continue;
			continue;
		}
		return level.var__random_perk_machine_perk_list[var_keys[var_i]];
	}
	return level.var__random_perk_machine_perk_list[var_keys[0]];
}

/*
	Name: function_perk_bottle_motion
	Namespace: namespace_zm_perk_random
	Checksum: 0x424F4353
	Offset: 0x21F8
	Size: 0x208
	Parameters: 0
	Flags: None
	Line Number: 741
*/
function function_perk_bottle_motion()
{
	var_putOutTime = 3;
	var_putBackTime = 10;
	var_v_float = function_AnglesToForward(self.var_angles - (0, 90, 0)) * 10;
	level.var_bottle_spawn_location.var_origin = self.var_origin + (0, 0, 53);
	level.var_bottle_spawn_location.var_angles = self.var_angles;
	level.var_bottle_spawn_location.var_origin = level.var_bottle_spawn_location.var_origin - var_v_float;
	level.var_bottle_spawn_location function_moveto(level.var_bottle_spawn_location.var_origin + var_v_float, var_putOutTime, var_putOutTime * 0.5);
	level.var_bottle_spawn_location.var_angles = level.var_bottle_spawn_location.var_angles + (0, 0, 10);
	level.var_bottle_spawn_location function_RotateYaw(720, var_putOutTime, var_putOutTime * 0.5);
	self waittill("hash_done_cycling");
	level.var_bottle_spawn_location.var_angles = self.var_angles;
	level.var_bottle_spawn_location function_moveto(level.var_bottle_spawn_location.var_origin - var_v_float, var_putBackTime, var_putBackTime * 0.5);
	level.var_bottle_spawn_location function_RotateYaw(90, var_putBackTime, var_putBackTime * 0.5);
}

/*
	Name: function_start_perk_bottle_cycling
	Namespace: namespace_zm_perk_random
	Checksum: 0x424F4353
	Offset: 0x2408
	Size: 0x138
	Parameters: 0
	Flags: None
	Line Number: 768
*/
function function_start_perk_bottle_cycling()
{
	self endon("hash_done_cycling");
	var_array_key = function_getArrayKeys(level.var_perk_bottle_weapon_array);
	var_timer = 0;
	while(1)
	{
		for(var_i = 0; var_i < var_array_key.size; var_i++)
		{
			if(isdefined(level.var_perk_bottle_weapon_array[var_array_key[var_i]].var_weapon))
			{
				var_model = function_GetWeaponModel(level.var_perk_bottle_weapon_array[var_array_key[var_i]].var_weapon);
			}
			else
			{
				var_model = function_GetWeaponModel(level.var_perk_bottle_weapon_array[var_array_key[var_i]].var_perk_bottle_weapon);
			}
			level.var_bottle_spawn_location function_SetModel(var_model);
			wait(0.2);
		}
	}
}

/*
	Name: function_get_perk_weapon_model
	Namespace: namespace_zm_perk_random
	Checksum: 0x424F4353
	Offset: 0x2548
	Size: 0x98
	Parameters: 1
	Flags: None
	Line Number: 801
*/
function function_get_perk_weapon_model(var_perk)
{
	var_weapon = level.var_machine_assets[var_perk].var_weapon;
	if(isdefined(level.var__custom_perks[var_perk]) && isdefined(level.var__custom_perks[var_perk].var_perk_bottle_weapon))
	{
		var_weapon = level.var__custom_perks[var_perk].var_perk_bottle_weapon;
	}
	return function_GetWeaponModel(var_weapon);
}

/*
	Name: function_perk_random_vending
	Namespace: namespace_zm_perk_random
	Checksum: 0x424F4353
	Offset: 0x25E8
	Size: 0xD0
	Parameters: 0
	Flags: None
	Line Number: 821
*/
function function_perk_random_vending()
{
	self namespace_clientfield::function_set("client_stone_emmissive_blink", 1);
	self thread function_perk_random_loop_anim(5, "opening", "opening");
	self thread function_perk_random_loop_anim(3, "closing", "closing");
	self thread function_perk_random_vend_sfx();
	self notify("hash_vending");
	self waittill("hash_bottle_spawned");
	self function_SetZBarrierPieceState(4, "opening");
	return;
}

/*
	Name: function_perk_random_loop_anim
	Namespace: namespace_zm_perk_random
	Checksum: 0x424F4353
	Offset: 0x26C0
	Size: 0xE8
	Parameters: 3
	Flags: None
	Line Number: 843
*/
function function_perk_random_loop_anim(var_n_piece, var_s_anim_1, var_s_anim_2)
{
	self endon("hash_zbarrier_state_change");
	var_current_state = self.var_State;
	while(self.var_State == var_current_state)
	{
		self function_SetZBarrierPieceState(var_n_piece, var_s_anim_1);
		while(self function_GetZBarrierPieceState(var_n_piece) == var_s_anim_1)
		{
			wait(0.05);
		}
		self function_SetZBarrierPieceState(var_n_piece, var_s_anim_2);
		while(self function_GetZBarrierPieceState(var_n_piece) == var_s_anim_2)
		{
			wait(0.05);
		}
	}
}

/*
	Name: function_perk_random_vend_sfx
	Namespace: namespace_zm_perk_random
	Checksum: 0x424F4353
	Offset: 0x27B0
	Size: 0x80
	Parameters: 0
	Flags: None
	Line Number: 872
*/
function function_perk_random_vend_sfx()
{
	self function_PlayLoopSound("zmb_rand_perk_sparks");
	level.var_bottle_spawn_location function_PlayLoopSound("zmb_rand_perk_vortex");
	self waittill("hash_zbarrier_state_change");
	self function_StopLoopSound();
	level.var_bottle_spawn_location function_StopLoopSound();
}

/*
	Name: function_perk_random_initial
	Namespace: namespace_zm_perk_random
	Checksum: 0x424F4353
	Offset: 0x2838
	Size: 0x28
	Parameters: 0
	Flags: None
	Line Number: 891
*/
function function_perk_random_initial()
{
	self function_SetZBarrierPieceState(3, "opening");
}

/*
	Name: function_perk_random_idle
	Namespace: namespace_zm_perk_random
	Checksum: 0x424F4353
	Offset: 0x2868
	Size: 0xA8
	Parameters: 0
	Flags: None
	Line Number: 906
*/
function function_perk_random_idle()
{
	self namespace_clientfield::function_set("client_stone_emmissive_blink", 0);
	if(isdefined(level.var_perk_random_idle_effects_override))
	{
		self [[level.var_perk_random_idle_effects_override]]();
	}
	else
	{
		self namespace_clientfield::function_set("lightning_bolt_FX_toggle", 1);
		while(self.var_State == "idle")
		{
			wait(0.05);
		}
		self namespace_clientfield::function_set("lightning_bolt_FX_toggle", 0);
	}
}

/*
	Name: function_perk_random_arrive
	Namespace: namespace_zm_perk_random
	Checksum: 0x424F4353
	Offset: 0x2918
	Size: 0x48
	Parameters: 0
	Flags: None
	Line Number: 934
*/
function function_perk_random_arrive()
{
	while(self function_GetZBarrierPieceState(0) == "opening")
	{
		wait(0.05);
	}
	self notify("hash_arrived");
}

/*
	Name: function_perk_random_leaving
	Namespace: namespace_zm_perk_random
	Checksum: 0x424F4353
	Offset: 0x2968
	Size: 0x60
	Parameters: 0
	Flags: None
	Line Number: 953
*/
function function_perk_random_leaving()
{
	while(self function_GetZBarrierPieceState(0) == "closing")
	{
		wait(0.05);
	}
	wait(0.05);
	self thread function_set_perk_random_machine_state("away");
}

/*
	Name: function_set_perk_random_machine_state
	Namespace: namespace_zm_perk_random
	Checksum: 0x424F4353
	Offset: 0x29D0
	Size: 0x88
	Parameters: 1
	Flags: None
	Line Number: 973
*/
function function_set_perk_random_machine_state(var_State)
{
	wait(0.1);
	for(var_i = 0; var_i < self function_GetNumZBarrierPieces(); var_i++)
	{
		self function_HideZBarrierPiece(var_i);
	}
	self notify("hash_zbarrier_state_change");
	self [[level.var_perk_random_machine_state_func]](var_State);
}

/*
	Name: function_process_perk_random_machine_state
	Namespace: namespace_zm_perk_random
	Checksum: 0x424F4353
	Offset: 0x2A60
	Size: 0x4A0
	Parameters: 1
	Flags: None
	Line Number: 994
*/
function function_process_perk_random_machine_state(var_State)
{
	switch(var_State)
	{
		case "arrive":
		{
			self function_ShowZBarrierPiece(0);
			self function_ShowZBarrierPiece(1);
			self function_SetZBarrierPieceState(0, "opening");
			self function_SetZBarrierPieceState(1, "opening");
			self namespace_clientfield::function_set("set_client_light_state", 1);
			self thread function_perk_random_arrive();
			self.var_State = "arrive";
			break;
		}
		case "idle":
		{
			self function_ShowZBarrierPiece(5);
			self function_ShowZBarrierPiece(2);
			self function_SetZBarrierPieceState(2, "opening");
			self namespace_clientfield::function_set("set_client_light_state", 1);
			self.var_State = "idle";
			self thread function_perk_random_idle();
			break;
		}
		case "power_off":
		{
			self function_ShowZBarrierPiece(2);
			self function_SetZBarrierPieceState(2, "closing");
			self namespace_clientfield::function_set("set_client_light_state", 0);
			self.var_State = "power_off";
			break;
		}
		case "vending":
		{
			self function_ShowZBarrierPiece(5);
			self function_ShowZBarrierPiece(3);
			self function_ShowZBarrierPiece(4);
			self namespace_clientfield::function_set("set_client_light_state", 1);
			self.var_State = "vending";
			self thread function_perk_random_vending();
			break;
		}
		case "leaving":
		{
			self function_ShowZBarrierPiece(1);
			self function_ShowZBarrierPiece(0);
			self function_SetZBarrierPieceState(0, "closing");
			self function_SetZBarrierPieceState(1, "closing");
			self namespace_clientfield::function_set("set_client_light_state", 3);
			self thread function_perk_random_leaving();
			self.var_State = "leaving";
			break;
		}
		case "away":
		{
			self function_ShowZBarrierPiece(2);
			self function_SetZBarrierPieceState(2, "closing");
			self namespace_clientfield::function_set("set_client_light_state", 3);
			self.var_State = "away";
			break;
		}
		case "initial":
		{
			self function_ShowZBarrierPiece(3);
			self function_SetZBarrierPieceState(3, "opening");
			self function_ShowZBarrierPiece(5);
			self namespace_clientfield::function_set("set_client_light_state", 0);
			self.var_State = "initial";
			break;
		}
		default
		{
			if(isdefined(level.var_custom_perk_random_state_handler))
			{
				self [[level.var_custom_perk_random_state_handler]](var_State);
				break;
			}
		}
	}
	return;
	ERROR: Exception occured: Stack empty.
}

/*
	Name: function_machine_sounds
	Namespace: namespace_zm_perk_random
	Checksum: 0x424F4353
	Offset: 0x2F08
	Size: 0xE8
	Parameters: 0
	Flags: None
	Line Number: 1088
*/
function function_machine_sounds()
{
	level endon("hash_machine_think");
	while(1)
	{
		level waittill("hash_pmstrt");
		var_rndprk_ent = function_spawn("script_origin", self.var_origin);
		var_rndprk_ent function_stopsounds();
		var_state_switch = level namespace_util::function_waittill_any_return("pmstop", "pmmove", "machine_think");
		var_rndprk_ent function_StopLoopSound(1);
		if(var_state_switch == "pmstop")
		{
			else
			{
			}
		}
		var_rndprk_ent function_delete();
	}
}

/*
	Name: function_GetWeaponModel
	Namespace: namespace_zm_perk_random
	Checksum: 0x424F4353
	Offset: 0x2FF8
	Size: 0x20
	Parameters: 1
	Flags: None
	Line Number: 1118
*/
function function_GetWeaponModel(var_weapon)
{
	return var_weapon.var_worldmodel;
}

/*
	Name: function_is_power_on
	Namespace: namespace_zm_perk_random
	Checksum: 0x424F4353
	Offset: 0x3020
	Size: 0xB8
	Parameters: 1
	Flags: None
	Line Number: 1133
*/
function function_is_power_on(var_n_power_index)
{
	if(isdefined(var_n_power_index))
	{
		var_str_power = "power_on" + var_n_power_index;
		var_n_power_on = level namespace_flag::function_get(var_str_power);
	}
	else if(isdefined(level.var_zm_custom_perk_random_power_flag))
	{
		var_n_power_on = level namespace_flag::function_get(level.var_zm_custom_perk_random_power_flag);
	}
	else
	{
		var_n_power_on = level namespace_flag::function_get("power_on");
	}
	return var_n_power_on;
}

/*
	Name: function_setup_devgui
	Namespace: namespace_zm_perk_random
	Checksum: 0x424F4353
	Offset: 0x30E0
	Size: 0x20
	Parameters: 0
	Flags: None
	Line Number: 1161
*/
function function_setup_devgui()
{
	/#
		level.var_perk_random_devgui_callback = &function_wunderfizz_devgui_callback;
	#/
}

/*
	Name: function_wunderfizz_devgui_callback
	Namespace: namespace_zm_perk_random
	Checksum: 0x424F4353
	Offset: 0x3108
	Size: 0x1D6
	Parameters: 1
	Flags: None
	Line Number: 1178
*/
function function_wunderfizz_devgui_callback(var_cmd)
{
	/#
		var_players = function_GetPlayers();
		var_a_e_wunderfizzes = function_GetEntArray("Dev Block strings are not supported", "Dev Block strings are not supported");
		var_e_wunderfizz = function_ArrayGetClosest(function_GetPlayers()[0].var_origin, var_a_e_wunderfizzes);
		switch(var_cmd)
		{
			case "Dev Block strings are not supported":
			{
				var_e_wunderfizz thread function_set_perk_random_machine_state("Dev Block strings are not supported");
				break;
			}
			case "Dev Block strings are not supported":
			{
				var_e_wunderfizz thread function_set_perk_random_machine_state("Dev Block strings are not supported");
				break;
			}
			case "Dev Block strings are not supported":
			{
				var_e_wunderfizz thread function_set_perk_random_machine_state("Dev Block strings are not supported");
				var_e_wunderfizz notify("hash_bottle_spawned");
				break;
			}
			case "Dev Block strings are not supported":
			{
				var_e_wunderfizz thread function_set_perk_random_machine_state("Dev Block strings are not supported");
				break;
			}
			case "Dev Block strings are not supported":
			{
				var_e_wunderfizz thread function_set_perk_random_machine_state("Dev Block strings are not supported");
				break;
			}
			case "Dev Block strings are not supported":
			{
				var_e_wunderfizz thread function_set_perk_random_machine_state("Dev Block strings are not supported");
				break;
			}
			case "Dev Block strings are not supported":
			{
				var_e_wunderfizz thread function_set_perk_random_machine_state("Dev Block strings are not supported");
				break;
			}
		}
	#/
}

