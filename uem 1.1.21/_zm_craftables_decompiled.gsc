#include scripts\codescripts\struct;
#include scripts\shared\array_shared;
#include scripts\shared\callbacks_shared;
#include scripts\shared\clientfield_shared;
#include scripts\shared\demo_shared;
#include scripts\shared\flag_shared;
#include scripts\shared\hud_util_shared;
#include scripts\shared\laststand_shared;
#include scripts\shared\system_shared;
#include scripts\shared\util_shared;
#include scripts\zm\_zm_audio;
#include scripts\zm\_zm_bgb;
#include scripts\zm\_zm_equipment;
#include scripts\zm\_zm_score;
#include scripts\zm\_zm_stats;
#include scripts\zm\_zm_unitrigger;
#include scripts\zm\_zm_utility;
#include scripts\zm\_zm_weap_riotshield;
#include scripts\zm\_zm_weapons;

#namespace namespace_zm_craftables;

/*
	Name: function___init__sytem__
	Namespace: namespace_zm_craftables
	Checksum: 0x424F4353
	Offset: 0x8D8
	Size: 0x40
	Parameters: 0
	Flags: AutoExec
	Line Number: 32
*/
function autoexec function___init__sytem__()
{
	namespace_system::function_register("zm_craftables", &function___init__, &function___main__, undefined);
}

/*
	Name: function___init__
	Namespace: namespace_zm_craftables
	Checksum: 0x424F4353
	Offset: 0x920
	Size: 0x28
	Parameters: 0
	Flags: None
	Line Number: 47
*/
function function___init__()
{
	namespace_callback::function_on_finalize_initialization(&function_set_craftable_clientfield);
}

/*
	Name: function_init
	Namespace: namespace_zm_craftables
	Checksum: 0x424F4353
	Offset: 0x950
	Size: 0x180
	Parameters: 0
	Flags: None
	Line Number: 62
*/
function function_init()
{
	if(!isdefined(level.var_craftable_piece_swap_allowed))
	{
		level.var_craftable_piece_swap_allowed = 1;
	}
	var_zombie_craftables_callbacks = [];
	level.var_craftablePickUps = [];
	level.var_craftables_crafted = [];
	level.var_a_uts_craftables = [];
	level thread function_d6d0874f();
	if(!isdefined(level.var_craftable_piece_count))
	{
		level.var_craftable_piece_count = 0;
	}
	level.var__effect["building_dust"] = "zombie/fx_crafting_dust_zmb";
	if(isdefined(level.var_init_craftables))
	{
		[[level.var_init_craftables]]();
	}
	var_open_table = function_spawnstruct();
	var_open_table.var_name = "open_table";
	var_open_table.var_triggerThink = &function_openTableCraftable;
	var_open_table.var_custom_craftablestub_update_prompt = &function_open_craftablestub_update_prompt;
	function_include_zombie_craftable(var_open_table);
	function_add_zombie_craftable("open_table", &"");
	if(isdefined(level.var_use_swipe_protection))
	{
		namespace_callback::function_on_connect(&function_craftables_watch_swipes);
	}
}

/*
	Name: function_d6d0874f
	Namespace: namespace_zm_craftables
	Checksum: 0x424F4353
	Offset: 0xAD8
	Size: 0x48
	Parameters: 0
	Flags: None
	Line Number: 104
*/
function function_d6d0874f()
{
	level.var_448ee6c4 = 1500;
	for(;;)
	{
		level waittill("hash_end_of_round");
		if(level.var_round_number % 5 == 0)
		{
			level.var_448ee6c4 = level.var_448ee6c4 + 500;
		}
	}
}

/*
	Name: function___main__
	Namespace: namespace_zm_craftables
	Checksum: 0x424F4353
	Offset: 0xB28
	Size: 0x20
	Parameters: 0
	Flags: None
	Line Number: 127
*/
function function___main__()
{
	level thread function_think_craftables();
}

/*
	Name: function_set_craftable_clientfield
	Namespace: namespace_zm_craftables
	Checksum: 0x424F4353
	Offset: 0xB50
	Size: 0x28
	Parameters: 0
	Flags: None
	Line Number: 142
*/
function function_set_craftable_clientfield()
{
	function_set_piece_count(level.var_zombie_craftableStubs.size);
}

/*
	Name: function_anystub_update_prompt
	Namespace: namespace_zm_craftables
	Checksum: 0x424F4353
	Offset: 0xB80
	Size: 0x130
	Parameters: 1
	Flags: None
	Line Number: 157
*/
function function_anystub_update_prompt(var_player)
{
	if(var_player namespace_laststand::function_player_is_in_laststand() || var_player namespace_zm_utility::function_in_revive_trigger())
	{
		self.var_hint_string = "";
		return 0;
	}
	if(isdefined(var_player.var_IS_DRINKING) && var_player.var_IS_DRINKING > 0)
	{
		self.var_hint_string = "";
		return 0;
	}
	if(isdefined(var_player.var_screecher_weapon))
	{
		self.var_hint_string = "";
		return 0;
	}
	var_initial_current_weapon = var_player function_GetCurrentWeapon();
	var_current_weapon = namespace_zm_weapons::function_get_nonalternate_weapon(var_initial_current_weapon);
	if(namespace_zm_equipment::function_is_equipment(var_current_weapon))
	{
		self.var_hint_string = "";
		return 0;
	}
	return 1;
}

/*
	Name: function_anystub_get_unitrigger_origin
	Namespace: namespace_zm_craftables
	Checksum: 0x424F4353
	Offset: 0xCB8
	Size: 0x28
	Parameters: 0
	Flags: None
	Line Number: 194
*/
function function_anystub_get_unitrigger_origin()
{
	if(isdefined(self.var_origin_parent))
	{
		return self.var_origin_parent.var_origin;
	}
	return self.var_origin;
}

/*
	Name: function_anystub_on_spawn_trigger
	Namespace: namespace_zm_craftables
	Checksum: 0x424F4353
	Offset: 0xCE8
	Size: 0x68
	Parameters: 1
	Flags: None
	Line Number: 213
*/
function function_anystub_on_spawn_trigger(var_trigger)
{
	if(isdefined(self.var_link_parent))
	{
		var_trigger function_EnableLinkTo();
		var_trigger function_LinkTo(self.var_link_parent);
		var_trigger function_SetMovingPlatformEnabled(1);
	}
}

/*
	Name: function_craftables_watch_swipes
	Namespace: namespace_zm_craftables
	Checksum: 0x424F4353
	Offset: 0xD58
	Size: 0x200
	Parameters: 0
	Flags: None
	Line Number: 233
*/
function function_craftables_watch_swipes()
{
	self endon("hash_disconnect");
	self notify("hash_craftables_watch_swipes");
	self endon("hash_craftables_watch_swipes");
	while(1)
	{
		self waittill("hash_melee_swipe", var_zombie);
		if(function_DistanceSquared(var_zombie.var_origin, self.var_origin) > var_zombie.var_meleeAttackDist * var_zombie.var_meleeAttackDist)
		{
			continue;
		}
		var_trigger = level.var__unitriggers.var_trigger_pool[self function_GetEntityNumber()];
		if(isdefined(var_trigger) && isdefined(var_trigger.var_stub.var_piece))
		{
			var_piece = var_trigger.var_stub.var_piece;
			if(!isdefined(var_piece.var_damage))
			{
				var_piece.var_damage = 0;
			}
			var_piece.var_damage++;
			if(var_piece.var_damage > 12)
			{
				thread namespace_zm_equipment::function_disappear_fx(var_trigger.var_stub namespace_zm_unitrigger::function_unitrigger_origin());
				var_piece function_piece_unspawn();
				self namespace_zm_stats::function_increment_client_stat("cheat_total", 0);
				if(function_isalive(self))
				{
					self function_playlocalsound(level.var_zmb_laugh_alias);
				}
			}
		}
	}
}

/*
	Name: function_ExplosionDamage
	Namespace: namespace_zm_craftables
	Checksum: 0x424F4353
	Offset: 0xF60
	Size: 0x38
	Parameters: 2
	Flags: None
	Line Number: 278
*/
function function_ExplosionDamage(var_damage, var_pos)
{
	self function_DoDamage(var_damage, var_pos);
	return;
	ERROR: Bad function call
}

/*
	Name: function_make_zombie_craftable_open
	Namespace: namespace_zm_craftables
	Checksum: 0x424F4353
	Offset: 0xFA0
	Size: 0xC8
	Parameters: 4
	Flags: None
	Line Number: 295
*/
function function_make_zombie_craftable_open(var_str_craftable, var_STR_MODEL, var_v_angle_offset, var_v_origin_offset)
{
	/#
		namespace_::function_Assert(isdefined(level.var_zombie_craftableStubs[var_str_craftable]), "Dev Block strings are not supported" + var_str_craftable + "Dev Block strings are not supported");
	#/
	var_s_craftable = level.var_zombie_craftableStubs[var_str_craftable];
	var_s_craftable.var_is_open_table = 1;
	var_s_craftable.var_STR_MODEL = var_STR_MODEL;
	var_s_craftable.var_v_angle_offset = var_v_angle_offset;
	var_s_craftable.var_v_origin_offset = var_v_origin_offset;
}

/*
	Name: function_add_zombie_craftable
	Namespace: namespace_zm_craftables
	Checksum: 0x424F4353
	Offset: 0x1070
	Size: 0x140
	Parameters: 6
	Flags: None
	Line Number: 317
*/
function function_add_zombie_craftable(var_craftable_name, var_str_to_craft, var_str_crafting, var_str_taken, var_onFullyCrafted, var_need_all_pieces)
{
	if(!isdefined(level.var_zombie_include_craftables))
	{
		level.var_zombie_include_craftables = [];
	}
	if(isdefined(level.var_zombie_include_craftables) && !isdefined(level.var_zombie_include_craftables[var_craftable_name]))
	{
		return;
	}
	var_craftable_struct = level.var_zombie_include_craftables[var_craftable_name];
	if(!isdefined(level.var_zombie_craftableStubs))
	{
		level.var_zombie_craftableStubs = [];
	}
	var_craftable_struct.var_str_to_craft = var_str_to_craft;
	var_craftable_struct.var_str_crafting = var_str_crafting;
	var_craftable_struct.var_str_taken = var_str_taken;
	var_craftable_struct.var_onFullyCrafted = var_onFullyCrafted;
	var_craftable_struct.var_need_all_pieces = var_need_all_pieces;
	level.var_zombie_craftableStubs[var_craftable_struct.var_name] = var_craftable_struct;
	return;
}

/*
	Name: function_set_hide_model_if_unavailable
	Namespace: namespace_zm_craftables
	Checksum: 0x424F4353
	Offset: 0x11B8
	Size: 0x48
	Parameters: 2
	Flags: None
	Line Number: 351
*/
function function_set_hide_model_if_unavailable(var_craftable_name, var_hide_when_unavailable)
{
	if(isdefined(level.var_zombie_craftableStubs[var_craftable_name]))
	{
		level.var_zombie_craftableStubs[var_craftable_name].var_hide_when_unavailable = var_hide_when_unavailable;
	}
}

/*
	Name: function_get_hide_model_if_unavailable
	Namespace: namespace_zm_craftables
	Checksum: 0x424F4353
	Offset: 0x1208
	Size: 0x58
	Parameters: 1
	Flags: None
	Line Number: 369
*/
function function_get_hide_model_if_unavailable(var_craftable_name)
{
	if(isdefined(level.var_zombie_craftableStubs[var_craftable_name]))
	{
		return isdefined(level.var_zombie_craftableStubs[var_craftable_name].var_hide_when_unavailable) && level.var_zombie_craftableStubs[var_craftable_name].var_hide_when_unavailable;
	}
	return 0;
}

/*
	Name: function_set_build_time
	Namespace: namespace_zm_craftables
	Checksum: 0x424F4353
	Offset: 0x1268
	Size: 0x48
	Parameters: 2
	Flags: None
	Line Number: 388
*/
function function_set_build_time(var_craftable_name, var_build_time)
{
	if(isdefined(level.var_zombie_craftableStubs[var_craftable_name]))
	{
		level.var_zombie_craftableStubs[var_craftable_name].var_useTime = var_build_time;
	}
}

/*
	Name: function_set_piece_count
	Namespace: namespace_zm_craftables
	Checksum: 0x424F4353
	Offset: 0x12B8
	Size: 0x68
	Parameters: 1
	Flags: None
	Line Number: 406
*/
function function_set_piece_count(var_n_count)
{
	var_bits = function_GetMinBitCountForNum(var_n_count);
	function_RegisterClientField("toplayer", "craftable", 1, var_bits, "int");
}

/*
	Name: function_add_zombie_craftable_vox_category
	Namespace: namespace_zm_craftables
	Checksum: 0x424F4353
	Offset: 0x1328
	Size: 0x40
	Parameters: 2
	Flags: None
	Line Number: 422
*/
function function_add_zombie_craftable_vox_category(var_craftable_name, var_vox_id)
{
	var_craftable_struct = level.var_zombie_include_craftables[var_craftable_name];
	var_craftable_struct.var_vox_id = var_vox_id;
}

/*
	Name: function_include_zombie_craftable
	Namespace: namespace_zm_craftables
	Checksum: 0x424F4353
	Offset: 0x1370
	Size: 0x88
	Parameters: 1
	Flags: None
	Line Number: 438
*/
function function_include_zombie_craftable(var_craftableStub)
{
	if(!isdefined(level.var_zombie_include_craftables))
	{
		level.var_zombie_include_craftables = [];
	}
	if(!isdefined(level.var_craftableIndex))
	{
		level.var_craftableIndex = 0;
	}
	level.var_zombie_include_craftables[var_craftableStub.var_name] = var_craftableStub;
	var_craftableStub.var_hash_id = function_HashString(var_craftableStub.var_name);
}

/*
	Name: function_generate_zombie_craftable_piece
	Namespace: namespace_zm_craftables
	Checksum: 0x424F4353
	Offset: 0x1400
	Size: 0x470
	Parameters: 18
	Flags: None
	Line Number: 462
*/
function function_generate_zombie_craftable_piece(var_craftablename, var_pieceName, var_radius, var_height, var_drop_offset, var_hud_icon, var_onPickup, var_onDrop, var_onCrafted, var_use_spawn_num, var_tag_name, var_can_reuse, var_client_field_value, var_is_shared, var_vox_id, var_b_one_time_vo, var_hint_string, var_slot)
{
	if(!isdefined(var_is_shared))
	{
		var_is_shared = 0;
	}
	if(!isdefined(var_b_one_time_vo))
	{
		var_b_one_time_vo = 0;
	}
	if(!isdefined(var_slot))
	{
		var_slot = 0;
	}
	var_pieceStub = function_spawnstruct();
	var_craftable_pieces = [];
	if(!isdefined(var_pieceName))
	{
		/#
			namespace_::function_ASSERTMSG("Dev Block strings are not supported");
		#/
	}
	var_craftable_pieces_structs = namespace_struct::function_get_array(var_craftablename + "_" + var_pieceName, "targetname");
	if(!isdefined(level.var_craftablePieceIndex))
	{
		level.var_craftablePieceIndex = 0;
	}
	foreach(var_struct in var_craftable_pieces_structs)
	{
		var_craftable_pieces[var_index] = var_struct;
		var_craftable_pieces[var_index].var_hasSpawned = 0;
	}
	var_pieceStub.var_spawns = var_craftable_pieces;
	var_pieceStub.var_craftablename = var_craftablename;
	var_pieceStub.var_pieceName = var_pieceName;
	if(var_craftable_pieces.size)
	{
		var_pieceStub.var_modelName = var_craftable_pieces[0].var_model;
	}
	var_pieceStub.var_hud_icon = var_hud_icon;
	var_pieceStub.var_radius = var_radius;
	var_pieceStub.var_height = var_height;
	var_pieceStub.var_tag_name = var_tag_name;
	var_pieceStub.var_can_reuse = var_can_reuse;
	var_pieceStub.var_drop_offset = var_drop_offset;
	var_pieceStub.var_max_instances = 256;
	var_pieceStub.var_onPickup = var_onPickup;
	var_pieceStub.var_onDrop = var_onDrop;
	var_pieceStub.var_onCrafted = var_onCrafted;
	var_pieceStub.var_use_spawn_num = var_use_spawn_num;
	var_pieceStub.var_is_shared = var_is_shared;
	var_pieceStub.var_vox_id = var_vox_id;
	var_pieceStub.var_hint_string = var_hint_string;
	var_pieceStub.var_inventory_slot = var_slot;
	var_pieceStub.var_hash_id = function_HashString(var_pieceName);
	if(isdefined(var_b_one_time_vo) && var_b_one_time_vo)
	{
		var_pieceStub.var_b_one_time_vo = var_b_one_time_vo;
	}
	if(isdefined(var_client_field_value))
	{
		if(isdefined(var_is_shared) && var_is_shared)
		{
			/#
				namespace_::function_Assert(function_IsString(var_client_field_value), "Dev Block strings are not supported" + var_pieceName + "Dev Block strings are not supported");
			#/
			var_pieceStub.var_client_field_id = var_client_field_value;
		}
		else
		{
			var_pieceStub.var_client_field_state = var_client_field_value;
		}
	}
	return var_pieceStub;
}

/*
	Name: function_manage_multiple_pieces
	Namespace: namespace_zm_craftables
	Checksum: 0x424F4353
	Offset: 0x1878
	Size: 0x30
	Parameters: 1
	Flags: None
	Line Number: 548
*/
function function_manage_multiple_pieces(var_max_instances)
{
	self.var_max_instances = var_max_instances;
	self.var_managing_pieces = 1;
	self.var_piece_allocated = [];
}

/*
	Name: function_combine_craftable_pieces
	Namespace: namespace_zm_craftables
	Checksum: 0x424F4353
	Offset: 0x18B0
	Size: 0x138
	Parameters: 3
	Flags: None
	Line Number: 565
*/
function function_combine_craftable_pieces(var_piece1, var_piece2, var_piece3)
{
	var_spawns1 = var_piece1.var_spawns;
	var_spawns2 = var_piece2.var_spawns;
	var_spawns = function_ArrayCombine(var_spawns1, var_spawns2, 1, 0);
	if(isdefined(var_piece3))
	{
		var_spawns3 = var_piece3.var_spawns;
		var_spawns = function_ArrayCombine(var_spawns, var_spawns3, 1, 0);
		var_spawns = namespace_Array::function_randomize(var_spawns);
		var_piece3.var_spawns = var_spawns;
	}
	else
	{
		var_spawns = namespace_Array::function_randomize(var_spawns);
	}
	var_piece1.var_spawns = var_spawns;
	var_piece2.var_spawns = var_spawns;
}

/*
	Name: function_add_craftable_piece
	Namespace: namespace_zm_craftables
	Checksum: 0x424F4353
	Offset: 0x19F0
	Size: 0xA8
	Parameters: 3
	Flags: None
	Line Number: 595
*/
function function_add_craftable_piece(var_pieceStub, var_tag_name, var_can_reuse)
{
	if(!isdefined(self.var_a_piecestubs))
	{
		self.var_a_piecestubs = [];
	}
	if(isdefined(var_tag_name))
	{
		var_pieceStub.var_tag_name = var_tag_name;
	}
	if(isdefined(var_can_reuse))
	{
		var_pieceStub.var_can_reuse = var_can_reuse;
	}
	self.var_a_piecestubs[self.var_a_piecestubs.size] = var_pieceStub;
	if(!isdefined(self.var_inventory_slot))
	{
		self.var_inventory_slot = var_pieceStub.var_inventory_slot;
	}
}

/*
	Name: function_player_drop_piece_on_downed
	Namespace: namespace_zm_craftables
	Checksum: 0x424F4353
	Offset: 0x1AA0
	Size: 0x40
	Parameters: 1
	Flags: None
	Line Number: 626
*/
function function_player_drop_piece_on_downed(var_slot)
{
	self endon("craftable_piece_released" + var_slot);
	self waittill("hash_bled_out");
	function_onPlayerLastStand();
}

/*
	Name: function_onPlayerLastStand
	Namespace: namespace_zm_craftables
	Checksum: 0x424F4353
	Offset: 0x1AE8
	Size: 0x1A0
	Parameters: 0
	Flags: None
	Line Number: 643
*/
function function_onPlayerLastStand()
{
	if(!isdefined(self.var_current_craftable_pieces))
	{
		self.var_current_craftable_pieces = [];
	}
	foreach(var_piece in self.var_current_craftable_pieces)
	{
		if(isdefined(var_piece))
		{
			var_return_to_start_pos = 0;
			if(isdefined(level.var_safe_place_for_craftable_piece))
			{
				if(!self [[level.var_safe_place_for_craftable_piece]](var_piece))
				{
					var_return_to_start_pos = 1;
				}
			}
			if(var_return_to_start_pos)
			{
				var_piece function_piece_spawn_at();
			}
			else
			{
				var_piece function_piece_spawn_at(self.var_origin + VectorScale((1, 1, 0), 5), self.var_angles);
			}
			if(isdefined(var_piece.var_onDrop))
			{
				var_piece [[var_piece.var_onDrop]](self);
			}
			self namespace_clientfield::function_set_to_player("craftable", 0);
		}
		self.var_current_craftable_pieces[var_index] = undefined;
		self notify("craftable_piece_released" + var_index);
	}
	return;
	ERROR: Exception occured: Stack empty.
}

/*
	Name: function_piecestub_get_unitrigger_origin
	Namespace: namespace_zm_craftables
	Checksum: 0x424F4353
	Offset: 0x1C90
	Size: 0x38
	Parameters: 0
	Flags: None
	Line Number: 692
*/
function function_piecestub_get_unitrigger_origin()
{
	if(isdefined(self.var_origin_parent))
	{
		return self.var_origin_parent.var_origin + VectorScale((0, 0, 1), 12);
	}
	return self.var_origin;
}

/*
	Name: function_generate_piece_unitrigger
	Namespace: namespace_zm_craftables
	Checksum: 0x424F4353
	Offset: 0x1CD0
	Size: 0x3D0
	Parameters: 9
	Flags: None
	Line Number: 711
*/
function function_generate_piece_unitrigger(var_classname, var_origin, var_angles, var_flags, var_radius, var_script_height, var_hint_string, var_moving, var_b_nolook)
{
	if(!isdefined(var_radius))
	{
		var_radius = 64;
	}
	if(!isdefined(var_script_height))
	{
		var_script_height = 64;
	}
	var_script_width = var_script_height;
	if(!isdefined(var_script_width))
	{
		var_script_width = 64;
	}
	var_script_length = var_script_height;
	if(!isdefined(var_script_length))
	{
		var_script_length = 64;
	}
	var_unitrigger_stub = function_spawnstruct();
	var_unitrigger_stub.var_origin = var_origin;
	if(isdefined(var_script_length))
	{
		var_unitrigger_stub.var_script_length = var_script_length;
	}
	else
	{
		var_unitrigger_stub.var_script_length = 13.5;
	}
	if(isdefined(var_script_width))
	{
		var_unitrigger_stub.var_script_width = var_script_width;
	}
	else
	{
		var_unitrigger_stub.var_script_width = 27.5;
	}
	if(isdefined(var_script_height))
	{
		var_unitrigger_stub.var_script_height = var_script_height;
	}
	else
	{
		var_unitrigger_stub.var_script_height = 24;
	}
	var_unitrigger_stub.var_radius = var_radius;
	var_unitrigger_stub.var_cursor_hint = "HINT_NOICON";
	if(isdefined(var_hint_string))
	{
		var_unitrigger_stub.var_hint_string_override = var_hint_string;
		var_unitrigger_stub.var_hint_string = var_unitrigger_stub.var_hint_string_override;
	}
	else
	{
		var_unitrigger_stub.var_hint_string = &"ZOMBIE_BUILD_PIECE_GRAB";
	}
	var_unitrigger_stub.var_script_unitrigger_type = "unitrigger_box_use";
	if(isdefined(var_b_nolook) && (isdefined(function_Int(var_b_nolook)) && function_Int(var_b_nolook)))
	{
		var_unitrigger_stub.var_require_look_toward = 0;
	}
	var_unitrigger_stub.var_require_look_at = 0;
	switch(var_classname)
	{
		case "trigger_radius":
		{
			var_unitrigger_stub.var_script_unitrigger_type = "unitrigger_radius";
			break;
		}
		case "trigger_radius_use":
		{
			var_unitrigger_stub.var_script_unitrigger_type = "unitrigger_radius_use";
			break;
		}
		case "trigger_box":
		{
			var_unitrigger_stub.var_script_unitrigger_type = "unitrigger_box";
			break;
		}
		case "trigger_box_use":
		{
			var_unitrigger_stub.var_script_unitrigger_type = "unitrigger_box_use";
			break;
		}
	}
	namespace_zm_unitrigger::function_unitrigger_force_per_player_triggers(var_unitrigger_stub, 1);
	var_unitrigger_stub.var_prompt_and_visibility_func = &function_piecetrigger_update_prompt;
	var_unitrigger_stub.var_originFunc = &function_piecestub_get_unitrigger_origin;
	var_unitrigger_stub.var_onSpawnFunc = &function_anystub_on_spawn_trigger;
	if(isdefined(var_moving) && var_moving)
	{
		namespace_zm_unitrigger::function_register_unitrigger(var_unitrigger_stub, &function_piece_unitrigger_think);
	}
	else
	{
		namespace_zm_unitrigger::function_register_static_unitrigger(var_unitrigger_stub, &function_piece_unitrigger_think);
	}
	return var_unitrigger_stub;
}

/*
	Name: function_piecetrigger_update_prompt
	Namespace: namespace_zm_craftables
	Checksum: 0x424F4353
	Offset: 0x20A8
	Size: 0xA0
	Parameters: 1
	Flags: None
	Line Number: 822
*/
function function_piecetrigger_update_prompt(var_player)
{
	if(!isdefined(var_player.var_current_craftable_pieces))
	{
		var_player.var_current_craftable_pieces = [];
	}
	var_can_use = self.var_stub function_piecestub_update_prompt(var_player);
	self function_SetInvisibleToPlayer(var_player, !var_can_use);
	self function_setHintString(self.var_stub.var_hint_string);
	return var_can_use;
}

/*
	Name: function_piecestub_update_prompt
	Namespace: namespace_zm_craftables
	Checksum: 0x424F4353
	Offset: 0x2150
	Size: 0x1A8
	Parameters: 2
	Flags: None
	Line Number: 844
*/
function function_piecestub_update_prompt(var_player, var_slot)
{
	if(!isdefined(var_slot))
	{
		var_slot = self.var_piece.var_inventory_slot;
	}
	if(!self function_anystub_update_prompt(var_player))
	{
		return 0;
	}
	if(isdefined(var_player.var_current_craftable_pieces[var_slot]) && (!(isdefined(self.var_piece.var_is_shared) && self.var_piece.var_is_shared)))
	{
		if(!level.var_craftable_piece_swap_allowed)
		{
			self.var_hint_string = &"ZOMBIE_CRAFTABLE_NO_SWITCH";
		}
		else
		{
			var_spiece = self.var_piece;
			var_cpiece = var_player.var_current_craftable_pieces[var_slot];
			if(var_spiece.var_pieceName == var_cpiece.var_pieceName && var_spiece.var_craftablename == var_cpiece.var_craftablename)
			{
				self.var_hint_string = "";
				return 0;
			}
			if(isdefined(self.var_hint_string_override))
			{
				self.var_hint_string = self.var_hint_string_override;
			}
			else
			{
				self.var_hint_string = &"ZOMBIE_BUILD_PIECE_SWITCH";
			}
		}
	}
	else if(isdefined(self.var_hint_string_override))
	{
		self.var_hint_string = self.var_hint_string_override;
	}
	else
	{
		self.var_hint_string = &"ZOMBIE_BUILD_PIECE_GRAB";
	}
	return 1;
}

/*
	Name: function_piece_unitrigger_think
	Namespace: namespace_zm_craftables
	Checksum: 0x424F4353
	Offset: 0x2300
	Size: 0x1D8
	Parameters: 0
	Flags: None
	Line Number: 900
*/
function function_piece_unitrigger_think()
{
	self endon("hash_kill_trigger");
	var_slot = self.var_stub.var_piece.var_inventory_slot;
	while(1)
	{
		self waittill("hash_trigger", var_player);
		self.var_stub notify("hash_trigger", var_player);
		if(var_player != self.var_parent_player)
		{
			continue;
		}
		if(isdefined(var_player.var_screecher_weapon))
		{
			continue;
		}
		if(!level.var_craftable_piece_swap_allowed && isdefined(var_player.var_current_craftable_pieces[var_slot]) && (!(isdefined(self.var_stub.var_piece.var_is_shared) && self.var_stub.var_piece.var_is_shared)))
		{
			continue;
		}
		if(!namespace_zm_utility::function_is_player_valid(var_player))
		{
			var_player thread namespace_zm_utility::function_ignore_triggers(0.5);
			continue;
		}
		var_status = var_player function_player_can_take_piece(self.var_stub.var_piece);
		if(!var_status)
		{
			self.var_stub.var_hint_string = "";
			self function_setHintString(self.var_stub.var_hint_string);
		}
		else
		{
			var_player thread function_player_take_piece(self.var_stub.var_piece);
		}
	}
}

/*
	Name: function_player_can_take_piece
	Namespace: namespace_zm_craftables
	Checksum: 0x424F4353
	Offset: 0x24E0
	Size: 0x20
	Parameters: 1
	Flags: None
	Line Number: 948
*/
function function_player_can_take_piece(var_piece)
{
	if(!isdefined(var_piece))
	{
		return 0;
	}
	return 1;
}

/*
	Name: function_player_throw_piece
	Namespace: namespace_zm_craftables
	Checksum: 0x424F4353
	Offset: 0x2508
	Size: 0x370
	Parameters: 6
	Flags: None
	Line Number: 967
*/
function function_player_throw_piece(var_piece, var_origin, var_dir, var_return_to_spawn, var_return_time, var_endAngles)
{
	/#
		namespace_::function_Assert(isdefined(var_piece));
	#/
	if(isdefined(var_piece))
	{
		var_pass = 0;
		var_done = 0;
		var_altmodel = undefined;
		while(var_pass < 2 && !var_done)
		{
			var_grenade = self function_MagicGrenadeType("buildable_piece", var_origin, var_dir, 30000);
			var_grenade thread function_watch_hit_players();
			var_grenade function_ghost();
			if(!isdefined(var_altmodel))
			{
				var_altmodel = function_spawn("script_model", var_grenade.var_origin);
				var_altmodel function_SetModel(var_piece.var_modelName);
			}
			var_altmodel.var_origin = var_grenade.var_angles;
			var_altmodel.var_angles = var_grenade.var_angles;
			var_altmodel function_LinkTo(var_grenade, "", (0, 0, 0), (0, 0, 0));
			var_grenade.var_altmodel = var_altmodel;
			var_grenade waittill("hash_stationary");
			var_grenade_origin = var_grenade.var_origin;
			var_grenade_angles = var_grenade.var_angles;
			var_landed_on = var_grenade function_GetGroundEnt();
			var_grenade function_delete();
			if(isdefined(var_landed_on) && var_landed_on == level)
			{
				var_done = 1;
			}
			else
			{
				var_origin = var_grenade_origin;
				var_dir = (var_dir[0] * -1 / 10, var_dir[1] * -1 / 10, -1);
				var_pass++;
			}
		}
		if(!isdefined(var_endAngles))
		{
			var_endAngles = var_grenade_angles;
		}
		var_piece function_piece_spawn_at(var_grenade_origin, var_endAngles);
		if(isdefined(var_altmodel))
		{
			var_altmodel function_delete();
		}
		if(isdefined(var_piece.var_onDrop))
		{
			var_piece [[var_piece.var_onDrop]](self);
		}
		if(isdefined(var_return_to_spawn) && var_return_to_spawn)
		{
			var_piece function_piece_wait_and_return(var_return_time);
		}
	}
}

/*
	Name: function_watch_hit_players
	Namespace: namespace_zm_craftables
	Checksum: 0x424F4353
	Offset: 0x2880
	Size: 0x90
	Parameters: 0
	Flags: None
	Line Number: 1037
*/
function function_watch_hit_players()
{
	self endon("hash_death");
	self endon("hash_stationary");
	while(isdefined(self))
	{
		self waittill("hash_grenade_bounce", var_pos, var_normal, var_ent);
		if(function_isPlayer(var_ent))
		{
			var_ent function_ExplosionDamage(25, var_pos);
		}
	}
}

/*
	Name: function_piece_wait_and_return
	Namespace: namespace_zm_craftables
	Checksum: 0x424F4353
	Offset: 0x2918
	Size: 0x168
	Parameters: 1
	Flags: None
	Line Number: 1061
*/
function function_piece_wait_and_return(var_return_time)
{
	self endon("hash_pickup");
	wait(0.15);
	if(isdefined(level.var_exploding_jetgun_fx))
	{
		function_PlayFXOnTag(level.var_exploding_jetgun_fx, self.var_model, "tag_origin");
	}
	else
	{
		function_PlayFXOnTag(level.var__effect["powerup_on"], self.var_model, "tag_origin");
	}
	wait(var_return_time - 6);
	self function_piece_hide();
	wait(1);
	self function_piece_show();
	wait(1);
	self function_piece_hide();
	wait(1);
	self function_piece_show();
	wait(1);
	self function_piece_hide();
	wait(1);
	self function_piece_show();
	wait(1);
	self notify("hash_Respawn");
	self function_piece_unspawn();
	self function_piece_spawn_at();
}

/*
	Name: function_player_return_piece_to_original_spawn
	Namespace: namespace_zm_craftables
	Checksum: 0x424F4353
	Offset: 0x2A88
	Size: 0xA0
	Parameters: 1
	Flags: None
	Line Number: 1101
*/
function function_player_return_piece_to_original_spawn(var_slot)
{
	if(!isdefined(var_slot))
	{
		var_slot = 0;
	}
	self notify("craftable_piece_released" + var_slot);
	var_piece = self.var_current_craftable_pieces[var_slot];
	self.var_current_craftable_pieces[var_slot] = undefined;
	if(isdefined(var_piece))
	{
		var_piece function_piece_spawn_at();
		self namespace_clientfield::function_set_to_player("craftable", 0);
	}
}

/*
	Name: function_player_drop_piece_on_death
	Namespace: namespace_zm_craftables
	Checksum: 0x424F4353
	Offset: 0x2B30
	Size: 0x138
	Parameters: 1
	Flags: None
	Line Number: 1127
*/
function function_player_drop_piece_on_death(var_slot)
{
	if(!isdefined(var_slot))
	{
		var_slot = 0;
	}
	self notify("craftable_piece_released" + var_slot);
	self endon("craftable_piece_released" + var_slot);
	self thread function_player_drop_piece_on_downed(var_slot);
	var_origin = self.var_origin;
	var_angles = self.var_angles;
	var_piece = self.var_current_craftable_pieces[var_slot];
	if(isdefined(var_piece) && isdefined(var_piece.var_start_origin))
	{
		var_origin = var_piece.var_start_origin;
		var_angles = var_piece.var_start_angles;
	}
	self waittill("hash_disconnect");
	var_piece function_piece_spawn_at(var_origin, var_angles);
	if(isdefined(self))
	{
		self namespace_clientfield::function_set_to_player("craftable", 0);
	}
}

/*
	Name: function_player_drop_piece
	Namespace: namespace_zm_craftables
	Checksum: 0x424F4353
	Offset: 0x2C70
	Size: 0xE8
	Parameters: 2
	Flags: None
	Line Number: 1162
*/
function function_player_drop_piece(var_piece, var_slot)
{
	if(!isdefined(var_piece))
	{
		var_piece = self.var_current_craftable_pieces[var_slot];
	}
	if(isdefined(var_piece))
	{
		var_piece.var_damage = 0;
		var_piece function_piece_spawn_at(self.var_origin, self.var_angles);
		self namespace_clientfield::function_set_to_player("craftable", 0);
		if(isdefined(var_piece.var_onDrop))
		{
			var_piece [[var_piece.var_onDrop]](self);
		}
	}
	self.var_current_craftable_pieces[var_slot] = undefined;
	self notify("craftable_piece_released" + var_slot);
}

/*
	Name: function_player_take_piece
	Namespace: namespace_zm_craftables
	Checksum: 0x424F4353
	Offset: 0x2D60
	Size: 0x2D0
	Parameters: 1
	Flags: None
	Line Number: 1192
*/
function function_player_take_piece(var_pieceSpawn)
{
	var_pieceStub = var_pieceSpawn.var_pieceStub;
	var_slot = var_pieceStub.var_inventory_slot;
	var_damage = var_pieceSpawn.var_damage;
	if(!isdefined(self.var_current_craftable_pieces))
	{
		self.var_current_craftable_pieces = [];
	}
	self notify("player_got_craftable_piece_for_" + var_pieceSpawn.var_craftablename);
	if(!(isdefined(var_pieceStub.var_is_shared) && var_pieceStub.var_is_shared) && isdefined(self.var_current_craftable_pieces[var_slot]))
	{
		var_other_piece = self.var_current_craftable_pieces[var_slot];
		self function_player_drop_piece(self.var_current_craftable_piece, var_slot);
		var_other_piece.var_damage = var_damage;
		self namespace_zm_utility::function_do_player_general_vox("general", "craft_swap");
	}
	if(isdefined(var_pieceStub.var_onPickup))
	{
		var_pieceSpawn [[var_pieceStub.var_onPickup]](self);
	}
	if(isdefined(var_pieceStub.var_is_shared) && var_pieceStub.var_is_shared)
	{
		if(isdefined(var_pieceStub.var_client_field_id))
		{
			level namespace_clientfield::function_set(var_pieceStub.var_client_field_id, 1);
		}
	}
	else if(isdefined(var_pieceStub.var_client_field_state))
	{
		self namespace_clientfield::function_set_to_player("craftable", var_pieceStub.var_client_field_state);
	}
	var_pieceSpawn function_piece_unspawn();
	var_pieceSpawn notify("hash_pickup");
	if(isdefined(var_pieceStub.var_is_shared) && var_pieceStub.var_is_shared)
	{
		var_pieceSpawn.var_in_shared_inventory = 1;
	}
	else
	{
		var_slot = var_pieceSpawn.var_inventory_slot;
		self.var_current_craftable_pieces[var_slot] = var_pieceSpawn;
		self thread function_player_drop_piece_on_death(var_slot);
	}
	self function_track_craftable_piece_pickedup(var_pieceSpawn);
}

/*
	Name: function_player_destroy_piece
	Namespace: namespace_zm_craftables
	Checksum: 0x424F4353
	Offset: 0x3038
	Size: 0x80
	Parameters: 2
	Flags: None
	Line Number: 1249
*/
function function_player_destroy_piece(var_piece, var_slot)
{
	if(!isdefined(var_piece))
	{
		var_piece = self.var_current_craftable_pieces[var_slot];
	}
	if(isdefined(var_piece))
	{
		self namespace_clientfield::function_set_to_player("craftable", 0);
	}
	self.var_current_craftable_pieces[var_slot] = undefined;
	self notify("craftable_piece_released" + var_slot);
}

/*
	Name: function_claim_location
	Namespace: namespace_zm_craftables
	Checksum: 0x424F4353
	Offset: 0x30C0
	Size: 0x58
	Parameters: 1
	Flags: None
	Line Number: 1273
*/
function function_claim_location(var_location)
{
	if(!isdefined(level.var_craftable_claimed_locations))
	{
		level.var_craftable_claimed_locations = [];
	}
	if(!isdefined(level.var_craftable_claimed_locations[var_location]))
	{
		level.var_craftable_claimed_locations[var_location] = 1;
		return 1;
	}
	return 0;
}

/*
	Name: function_is_point_in_craft_trigger
	Namespace: namespace_zm_craftables
	Checksum: 0x424F4353
	Offset: 0x3120
	Size: 0x188
	Parameters: 1
	Flags: None
	Line Number: 1297
*/
function function_is_point_in_craft_trigger(var_point)
{
	var_candidate_list = [];
	foreach(var_zone in level.var_zones)
	{
		if(isdefined(var_zone.var_unitrigger_stubs))
		{
			var_candidate_list = function_ArrayCombine(var_candidate_list, var_zone.var_unitrigger_stubs, 1, 0);
		}
	}
	var_valid_range = 128;
	var_closest = namespace_zm_unitrigger::function_get_closest_unitriggers(var_point, var_candidate_list, var_valid_range);
	for(var_index = 0; var_index < var_closest.size; var_index++)
	{
		if(isdefined(var_closest[var_index].var_registered) && var_closest[var_index].var_registered && isdefined(var_closest[var_index].var_piece))
		{
			return 1;
		}
	}
	return 0;
}

/*
	Name: function_piece_allocate_spawn
	Namespace: namespace_zm_craftables
	Checksum: 0x424F4353
	Offset: 0x32B0
	Size: 0x2A8
	Parameters: 1
	Flags: None
	Line Number: 1329
*/
function function_piece_allocate_spawn(var_pieceStub)
{
	self.var_current_spawn = 0;
	self.var_managed_spawn = 1;
	self.var_pieceStub = var_pieceStub;
	if(self.var_spawns.size >= 1 && self.var_spawns.size > 1)
	{
		var_any_good = 0;
		var_any_okay = 0;
		var_totalWeight = 0;
		var_spawnweights = [];
		for(var_i = 0; var_i < self.var_spawns.size; var_i++)
		{
			if(isdefined(var_pieceStub.var_piece_allocated[var_i]) && var_pieceStub.var_piece_allocated[var_i])
			{
				var_spawnweights[var_i] = 0;
			}
			else if(function_is_point_in_craft_trigger(self.var_spawns[var_i].var_origin))
			{
				var_any_okay = 1;
				var_spawnweights[var_i] = 0.01;
			}
			else
			{
				var_any_good = 1;
				var_spawnweights[var_i] = 1;
			}
			var_totalWeight = var_totalWeight + var_spawnweights[var_i];
		}
		if(var_any_good)
		{
			var_totalWeight = function_float(function_Int(var_totalWeight));
		}
		var_r = function_RandomFloat(var_totalWeight);
		for(var_i = 0; var_i < self.var_spawns.size; var_i++)
		{
			if(!var_any_good || var_spawnweights[var_i] >= 1)
			{
				var_r = var_r - var_spawnweights[var_i];
				if(var_r < 0)
				{
					self.var_current_spawn = var_i;
					var_pieceStub.var_piece_allocated[self.var_current_spawn] = 1;
					return;
				}
			}
		}
		self.var_current_spawn = function_RandomInt(self.var_spawns.size);
		var_pieceStub.var_piece_allocated[self.var_current_spawn] = 1;
	}
}

/*
	Name: function_piece_deallocate_spawn
	Namespace: namespace_zm_craftables
	Checksum: 0x424F4353
	Offset: 0x3560
	Size: 0x40
	Parameters: 0
	Flags: None
	Line Number: 1391
*/
function function_piece_deallocate_spawn()
{
	if(isdefined(self.var_current_spawn))
	{
		self.var_pieceStub.var_piece_allocated[self.var_current_spawn] = 0;
		self.var_current_spawn = undefined;
	}
	self.var_start_origin = undefined;
}

/*
	Name: function_piece_pick_random_spawn
	Namespace: namespace_zm_craftables
	Checksum: 0x424F4353
	Offset: 0x35A8
	Size: 0x118
	Parameters: 0
	Flags: None
	Line Number: 1411
*/
function function_piece_pick_random_spawn()
{
	self.var_current_spawn = 0;
	if(self.var_spawns.size >= 1 && self.var_spawns.size > 1)
	{
		self.var_current_spawn = function_RandomInt(self.var_spawns.size);
		while(isdefined(self.var_spawns[self.var_current_spawn].var_claim_location) && !function_claim_location(self.var_spawns[self.var_current_spawn].var_claim_location))
		{
			function_ArrayRemoveIndex(self.var_spawns, self.var_current_spawn);
			if(self.var_spawns.size < 1)
			{
				self.var_current_spawn = 0;
				return;
			}
			self.var_current_spawn = function_RandomInt(self.var_spawns.size);
		}
	}
}

/*
	Name: function_piece_set_spawn
	Namespace: namespace_zm_craftables
	Checksum: 0x424F4353
	Offset: 0x36C8
	Size: 0x80
	Parameters: 1
	Flags: None
	Line Number: 1440
*/
function function_piece_set_spawn(var_num)
{
	self.var_current_spawn = 0;
	if(self.var_spawns.size >= 1 && self.var_spawns.size > 1)
	{
		self.var_current_spawn = function_Int(function_min(var_num, self.var_spawns.size - 1));
	}
}

/*
	Name: function_piece_spawn_in
	Namespace: namespace_zm_craftables
	Checksum: 0x424F4353
	Offset: 0x3750
	Size: 0x350
	Parameters: 1
	Flags: None
	Line Number: 1459
*/
function function_piece_spawn_in(var_pieceStub)
{
	if(self.var_spawns.size < 1)
	{
		return;
	}
	if(isdefined(self.var_managed_spawn) && self.var_managed_spawn)
	{
		if(!isdefined(self.var_current_spawn))
		{
			self function_piece_allocate_spawn(self.var_pieceStub);
		}
	}
	if(!isdefined(self.var_current_spawn))
	{
		self.var_current_spawn = 0;
	}
	var_spawndef = self.var_spawns[self.var_current_spawn];
	self.var_unitrigger = function_generate_piece_unitrigger("trigger_radius_use", var_spawndef.var_origin + VectorScale((0, 0, 1), 12), var_spawndef.var_angles, 0, var_pieceStub.var_radius, var_pieceStub.var_height, var_pieceStub.var_hint_string, 0, var_spawndef.var_script_string);
	self.var_unitrigger.var_piece = self;
	self.var_radius = var_pieceStub.var_radius;
	self.var_height = var_pieceStub.var_height;
	self.var_craftablename = var_pieceStub.var_craftablename;
	self.var_pieceName = var_pieceStub.var_pieceName;
	self.var_modelName = var_pieceStub.var_modelName;
	self.var_hud_icon = var_pieceStub.var_hud_icon;
	self.var_tag_name = var_pieceStub.var_tag_name;
	self.var_drop_offset = var_pieceStub.var_drop_offset;
	self.var_start_origin = var_spawndef.var_origin;
	self.var_start_angles = var_spawndef.var_angles;
	self.var_client_field_state = var_pieceStub.var_client_field_state;
	self.var_is_shared = var_pieceStub.var_is_shared;
	self.var_inventory_slot = var_pieceStub.var_inventory_slot;
	self.var_model = function_spawn("script_model", self.var_start_origin);
	if(isdefined(self.var_start_angles))
	{
		self.var_model.var_angles = self.var_start_angles;
	}
	self.var_model function_SetModel(var_pieceStub.var_modelName);
	if(isdefined(var_pieceStub.var_onSpawn))
	{
		self [[var_pieceStub.var_onSpawn]]();
	}
	self.var_model.var_hud_icon = var_pieceStub.var_hud_icon;
	self.var_pieceStub = var_pieceStub;
	self.var_unitrigger.var_origin_parent = self.var_model;
}

/*
	Name: function_piece_spawn_at
	Namespace: namespace_zm_craftables
	Checksum: 0x424F4353
	Offset: 0x3AA8
	Size: 0x398
	Parameters: 3
	Flags: None
	Line Number: 1517
*/
function function_piece_spawn_at(var_origin, var_angles, var_use_random_start)
{
	if(self.var_spawns.size < 1)
	{
		return;
	}
	if(isdefined(self.var_managed_spawn) && self.var_managed_spawn)
	{
		if(!isdefined(self.var_current_spawn) && !isdefined(var_origin))
		{
			self function_piece_allocate_spawn(self.var_pieceStub);
			var_spawndef = self.var_spawns[self.var_current_spawn];
			self.var_start_origin = var_spawndef.var_origin;
			self.var_start_angles = var_spawndef.var_angles;
		}
	}
	else if(!isdefined(self.var_current_spawn))
	{
		self.var_current_spawn = 0;
	}
	var_unitrigger_offset = VectorScale((0, 0, 1), 12);
	if(isdefined(var_use_random_start) && var_use_random_start)
	{
		self function_piece_pick_random_spawn();
		var_spawndef = self.var_spawns[self.var_current_spawn];
		self.var_start_origin = var_spawndef.var_origin;
		self.var_start_angles = var_spawndef.var_angles;
		var_origin = var_spawndef.var_origin;
		var_angles = var_spawndef.var_angles;
	}
	else if(!isdefined(var_origin))
	{
		var_origin = self.var_start_origin;
	}
	else
	{
		var_origin = var_origin + (0, 0, self.var_drop_offset);
		var_unitrigger_offset = var_unitrigger_offset - (0, 0, self.var_drop_offset);
	}
	if(!isdefined(var_angles))
	{
		var_angles = self.var_start_angles;
	}
	self.var_model = function_spawn("script_model", var_origin);
	if(isdefined(var_angles))
	{
		self.var_model.var_angles = var_angles;
	}
	self.var_model function_SetModel(self.var_modelName);
	if(isdefined(level.var_equipment_safe_to_drop))
	{
		if(![[level.var_equipment_safe_to_drop]](self.var_model))
		{
			var_origin = self.var_start_origin;
			var_angles = self.var_start_angles;
			self.var_model.var_origin = var_origin;
			self.var_model.var_angles = var_angles;
		}
	}
	if(isdefined(self.var_onSpawn))
	{
		self [[self.var_onSpawn]]();
	}
	self.var_unitrigger = function_generate_piece_unitrigger("trigger_radius_use", var_origin + var_unitrigger_offset, var_angles, 0, self.var_radius, self.var_height, self.var_pieceStub.var_hint_string, isdefined(self.var_model.var_canMove) && self.var_model.var_canMove);
	self.var_unitrigger.var_piece = self;
	self.var_model.var_hud_icon = self.var_hud_icon;
	self.var_unitrigger.var_origin_parent = self.var_model;
}

/*
	Name: function_piece_unspawn
	Namespace: namespace_zm_craftables
	Checksum: 0x424F4353
	Offset: 0x3E48
	Size: 0x90
	Parameters: 0
	Flags: None
	Line Number: 1596
*/
function function_piece_unspawn()
{
	if(isdefined(self.var_managed_spawn) && self.var_managed_spawn)
	{
		self function_piece_deallocate_spawn();
	}
	if(isdefined(self.var_model))
	{
		self.var_model function_delete();
	}
	self.var_model = undefined;
	if(isdefined(self.var_unitrigger))
	{
		thread namespace_zm_unitrigger::function_unregister_unitrigger(self.var_unitrigger);
	}
	self.var_unitrigger = undefined;
	return;
	ERROR: Bad function call
}

/*
	Name: function_piece_hide
	Namespace: namespace_zm_craftables
	Checksum: 0x424F4353
	Offset: 0x3EE0
	Size: 0x30
	Parameters: 0
	Flags: None
	Line Number: 1626
*/
function function_piece_hide()
{
	if(isdefined(self.var_model))
	{
		self.var_model function_ghost();
	}
}

/*
	Name: function_piece_show
	Namespace: namespace_zm_craftables
	Checksum: 0x424F4353
	Offset: 0x3F18
	Size: 0x30
	Parameters: 0
	Flags: None
	Line Number: 1644
*/
function function_piece_show()
{
	if(isdefined(self.var_model))
	{
		self.var_model function_show();
	}
}

/*
	Name: function_generate_piece
	Namespace: namespace_zm_craftables
	Checksum: 0x424F4353
	Offset: 0x3F50
	Size: 0x230
	Parameters: 1
	Flags: None
	Line Number: 1662
*/
function function_generate_piece(var_pieceStub)
{
	var_pieceSpawn = function_spawnstruct();
	var_pieceSpawn.var_spawns = var_pieceStub.var_spawns;
	if(isdefined(var_pieceStub.var_managing_pieces) && var_pieceStub.var_managing_pieces)
	{
		var_pieceSpawn function_piece_allocate_spawn(var_pieceStub);
	}
	else if(isdefined(var_pieceStub.var_use_spawn_num))
	{
		var_pieceSpawn function_piece_set_spawn(var_pieceStub.var_use_spawn_num);
	}
	else
	{
		var_pieceSpawn function_piece_pick_random_spawn();
	}
	if(isdefined(var_pieceStub.var_special_spawn_func))
	{
		var_pieceSpawn [[var_pieceStub.var_special_spawn_func]](var_pieceStub);
	}
	else
	{
		var_pieceSpawn function_piece_spawn_in(var_pieceStub);
	}
	if(var_pieceSpawn.var_spawns.size >= 1)
	{
		var_pieceSpawn.var_hud_icon = var_pieceStub.var_hud_icon;
	}
	if(isdefined(var_pieceStub.var_onPickup))
	{
		var_pieceSpawn.var_onPickup = var_pieceStub.var_onPickup;
	}
	else
	{
		var_pieceSpawn.var_onPickup = &function_onPickupUTS;
	}
	if(isdefined(var_pieceStub.var_onDrop))
	{
		var_pieceSpawn.var_onDrop = var_pieceStub.var_onDrop;
	}
	else
	{
		var_pieceSpawn.var_onDrop = &function_onDropUTS;
	}
	if(isdefined(var_pieceStub.var_onCrafted))
	{
		var_pieceSpawn.var_onCrafted = var_pieceStub.var_onCrafted;
	}
	return var_pieceSpawn;
	ERROR: Exception occured: Stack empty.
	waittillframeend;
}

/*
	Name: function_craftable_piece_unitriggers
	Namespace: namespace_zm_craftables
	Checksum: 0x424F4353
	Offset: 0x4188
	Size: 0x2F8
	Parameters: 2
	Flags: None
	Line Number: 1725
*/
function function_craftable_piece_unitriggers(var_craftable_name, var_origin)
{
	/#
		namespace_::function_Assert(isdefined(var_craftable_name));
	#/
	/#
		namespace_::function_Assert(isdefined(level.var_zombie_craftableStubs[var_craftable_name]), "Dev Block strings are not supported" + var_craftable_name);
	#/
	var_craftable = level.var_zombie_craftableStubs[var_craftable_name];
	if(!isdefined(var_craftable.var_a_piecestubs))
	{
		var_craftable.var_a_piecestubs = [];
	}
	level namespace_flag::function_wait_till("start_zombie_round_logic");
	var_craftableSpawn = function_spawnstruct();
	var_craftableSpawn.var_craftable_name = var_craftable_name;
	if(!isdefined(var_craftableSpawn.var_a_pieceSpawns))
	{
		var_craftableSpawn.var_a_pieceSpawns = [];
	}
	var_craftablePickUps = [];
	foreach(var_pieceStub in var_craftable.var_a_piecestubs)
	{
		if(!isdefined(var_craftableSpawn.var_inventory_slot))
		{
			var_craftableSpawn.var_inventory_slot = var_pieceStub.var_inventory_slot;
		}
		if(!isdefined(var_pieceStub.var_generated_instances))
		{
			var_pieceStub.var_generated_instances = 0;
		}
		if(isdefined(var_pieceStub.var_pieceSpawn) && (isdefined(var_pieceStub.var_can_reuse) && var_pieceStub.var_can_reuse))
		{
			var_piece = var_pieceStub.var_pieceSpawn;
		}
		else if(var_pieceStub.var_generated_instances >= var_pieceStub.var_max_instances)
		{
			var_piece = var_pieceStub.var_pieceSpawn;
		}
		else
		{
			var_piece = function_generate_piece(var_pieceStub);
			var_pieceStub.var_pieceSpawn = var_piece;
			var_pieceStub.var_generated_instances++;
		}
		var_craftableSpawn.var_a_pieceSpawns[var_craftableSpawn.var_a_pieceSpawns.size] = var_piece;
	}
	var_craftableSpawn.var_stub = self;
	return var_craftableSpawn;
	ERROR: Exception occured: Stack empty.
}

/*
	Name: function_hide_craftable_table_model
	Namespace: namespace_zm_craftables
	Checksum: 0x424F4353
	Offset: 0x4488
	Size: 0xC8
	Parameters: 1
	Flags: None
	Line Number: 1787
*/
function function_hide_craftable_table_model(var_trigger_targetname)
{
	var_trig = function_GetEnt(var_trigger_targetname, "targetname");
	if(!isdefined(var_trig))
	{
		return;
	}
	if(isdefined(var_trig.var_target))
	{
		var_model = function_GetEnt(var_trig.var_target, "targetname");
		if(isdefined(var_model))
		{
			var_model function_ghost();
			var_model function_notsolid();
		}
	}
}

/*
	Name: function_setup_unitrigger_craftable
	Namespace: namespace_zm_craftables
	Checksum: 0x424F4353
	Offset: 0x4558
	Size: 0x98
	Parameters: 6
	Flags: None
	Line Number: 1815
*/
function function_setup_unitrigger_craftable(var_trigger_targetname, var_equipname, var_weaponName, var_trigger_hintstring, var_DELETE_TRIGGER, var_Persistent)
{
	var_trig = function_GetEnt(var_trigger_targetname, "targetname");
	if(!isdefined(var_trig))
	{
		return;
	}
	return function_setup_unitrigger_craftable_internal(var_trig, var_equipname, var_weaponName, var_trigger_hintstring, var_DELETE_TRIGGER, var_Persistent);
}

/*
	Name: function_setup_unitrigger_craftable_array
	Namespace: namespace_zm_craftables
	Checksum: 0x424F4353
	Offset: 0x45F8
	Size: 0x120
	Parameters: 6
	Flags: None
	Line Number: 1835
*/
function function_setup_unitrigger_craftable_array(var_trigger_targetname, var_equipname, var_weaponName, var_trigger_hintstring, var_DELETE_TRIGGER, var_Persistent)
{
	var_triggers = function_GetEntArray(var_trigger_targetname, "targetname");
	var_stubs = [];
	foreach(var_trig in var_triggers)
	{
		var_stubs[var_stubs.size] = function_setup_unitrigger_craftable_internal(var_trig, var_equipname, var_weaponName, var_trigger_hintstring, var_DELETE_TRIGGER, var_Persistent);
	}
	return var_stubs;
	ERROR: Exception occured: Stack empty.
}

/*
	Name: function_setup_unitrigger_craftable_internal
	Namespace: namespace_zm_craftables
	Checksum: 0x424F4353
	Offset: 0x4720
	Size: 0x9C0
	Parameters: 6
	Flags: None
	Line Number: 1857
*/
function function_setup_unitrigger_craftable_internal(var_trig, var_equipname, var_weaponName, var_trigger_hintstring, var_DELETE_TRIGGER, var_Persistent)
{
	if(!isdefined(var_trig))
	{
		return;
	}
	var_unitrigger_stub = function_spawnstruct();
	var_unitrigger_stub.var_craftableStub = level.var_zombie_include_craftables[var_equipname];
	var_angles = var_trig.var_script_angles;
	if(!isdefined(var_angles))
	{
		var_angles = (0, 0, 0);
	}
	var_unitrigger_stub.var_origin = var_trig.var_origin + function_AnglesToRight(var_angles) * -6;
	var_unitrigger_stub.var_angles = var_trig.var_angles;
	if(isdefined(var_trig.var_script_angles))
	{
		var_unitrigger_stub.var_angles = var_trig.var_script_angles;
	}
	var_unitrigger_stub.var_equipname = var_equipname;
	var_unitrigger_stub.var_weaponName = function_GetWeapon(var_weaponName);
	var_unitrigger_stub.var_trigger_hintstring = var_trigger_hintstring;
	var_unitrigger_stub.var_DELETE_TRIGGER = var_DELETE_TRIGGER;
	var_unitrigger_stub.var_crafted = 0;
	var_unitrigger_stub.var_Persistent = var_Persistent;
	var_unitrigger_stub.var_useTime = function_Int(3000);
	if(isdefined(self.var_useTime))
	{
		var_unitrigger_stub.var_useTime = self.var_useTime;
	}
	else if(isdefined(var_trig.var_useTime))
	{
		var_unitrigger_stub.var_useTime = var_trig.var_useTime;
	}
	var_unitrigger_stub.var_onBeginUse = &function_onBeginUseUTS;
	var_unitrigger_stub.var_onEndUse = &function_onEndUseUTS;
	var_unitrigger_stub.var_onUse = &function_onUsePlantObjectUTS;
	var_unitrigger_stub.var_onCantUse = &function_onCantUseUTS;
	var_tmins = var_trig function_GetMins();
	var_tmaxs = var_trig function_GetMaxs();
	var_tsize = var_tmaxs - var_tmins;
	if(isdefined(var_trig.var_script_depth))
	{
		var_unitrigger_stub.var_script_length = var_trig.var_script_depth;
	}
	else
	{
		var_unitrigger_stub.var_script_length = var_tsize[1];
	}
	if(isdefined(var_trig.var_script_width))
	{
		var_unitrigger_stub.var_script_width = var_trig.var_script_width;
	}
	else
	{
		var_unitrigger_stub.var_script_width = var_tsize[0];
	}
	if(isdefined(var_trig.var_script_height))
	{
		var_unitrigger_stub.var_script_height = var_trig.var_script_height;
	}
	else
	{
		var_unitrigger_stub.var_script_height = var_tsize[2];
	}
	var_unitrigger_stub.var_target = var_trig.var_target;
	var_unitrigger_stub.var_targetname = var_trig.var_targetname;
	var_unitrigger_stub.var_script_noteworthy = var_trig.var_script_noteworthy;
	var_unitrigger_stub.var_script_parameters = var_trig.var_script_parameters;
	var_unitrigger_stub.var_cursor_hint = "HINT_NOICON";
	if(isdefined(level.var_zombie_craftableStubs[var_equipname].var_str_to_craft))
	{
		var_unitrigger_stub.var_hint_string = level.var_zombie_craftableStubs[var_equipname].var_str_to_craft;
	}
	var_unitrigger_stub.var_script_unitrigger_type = "unitrigger_box_use";
	var_unitrigger_stub.var_require_look_at = 1;
	var_unitrigger_stub.var_require_look_toward = 0;
	namespace_zm_unitrigger::function_unitrigger_force_per_player_triggers(var_unitrigger_stub, 1);
	if(isdefined(var_unitrigger_stub.var_craftableStub.var_custom_craftablestub_update_prompt))
	{
		var_unitrigger_stub.var_custom_craftablestub_update_prompt = var_unitrigger_stub.var_craftableStub.var_custom_craftablestub_update_prompt;
	}
	var_unitrigger_stub.var_prompt_and_visibility_func = &function_craftabletrigger_update_prompt;
	namespace_zm_unitrigger::function_register_static_unitrigger(var_unitrigger_stub, &function_craftable_place_think);
	var_unitrigger_stub.var_piece_trigger = var_trig;
	var_trig.var_trigger_stub = var_unitrigger_stub;
	if(isdefined(var_trig.var_zombie_weapon_upgrade))
	{
		var_unitrigger_stub.var_zombie_weapon_upgrade = function_GetWeapon(var_trig.var_zombie_weapon_upgrade);
	}
	if(isdefined(var_unitrigger_stub.var_target))
	{
		var_unitrigger_stub.var_model = function_GetEnt(var_unitrigger_stub.var_target, "targetname");
		if(isdefined(var_unitrigger_stub.var_model))
		{
			if(isdefined(var_unitrigger_stub.var_zombie_weapon_upgrade))
			{
				var_unitrigger_stub.var_model function_UseWeaponHideTags(var_unitrigger_stub.var_zombie_weapon_upgrade);
			}
			if(isdefined(var_unitrigger_stub.var_model.var_script_parameters))
			{
				var_a_utm_params = function_StrTok(var_unitrigger_stub.var_model.var_script_parameters, " ");
				foreach(var_Param in var_a_utm_params)
				{
					if(var_Param == "starts_visible")
					{
						var_b_start_visible = 1;
						continue;
						continue;
					}
					if(var_Param == "starts_empty")
					{
						var_b_start_empty = 1;
					}
				}
			}
			else if(var_b_start_visible !== 1)
			{
				var_unitrigger_stub.var_model function_ghost();
				var_unitrigger_stub.var_model function_notsolid();
			}
		}
	}
	if(var_unitrigger_stub.var_equipname == "open_table")
	{
		var_unitrigger_stub.var_a_uts_open_craftables_available = [];
		var_unitrigger_stub.var_n_open_craftable_choice = -1;
		var_unitrigger_stub.var_b_open_craftable_checking_input = 0;
	}
	var_unitrigger_stub.var_craftableSpawn = var_unitrigger_stub function_craftable_piece_unitriggers(var_equipname, var_unitrigger_stub.var_origin);
	if(isdefined(var_unitrigger_stub.var_model) && var_b_start_empty === 1)
	{
		for(var_i = 0; var_i < var_unitrigger_stub.var_craftableSpawn.var_a_pieceSpawns.size; var_i++)
		{
			if(isdefined(var_unitrigger_stub.var_craftableSpawn.var_a_pieceSpawns[var_i].var_tag_name))
			{
				if(var_unitrigger_stub.var_craftableSpawn.var_a_pieceSpawns[var_i].var_crafted !== 1)
				{
					var_unitrigger_stub.var_model function_HidePart(var_unitrigger_stub.var_craftableSpawn.var_a_pieceSpawns[var_i].var_tag_name);
					continue;
				}
				var_unitrigger_stub.var_model function_ShowPart(var_unitrigger_stub.var_craftableSpawn.var_a_pieceSpawns[var_i].var_tag_name);
			}
		}
	}
	else if(var_DELETE_TRIGGER)
	{
		var_trig function_delete();
	}
	level.var_a_uts_craftables[level.var_a_uts_craftables.size] = var_unitrigger_stub;
	return var_unitrigger_stub;
}

/*
	Name: function_setup_craftable_pieces
	Namespace: namespace_zm_craftables
	Checksum: 0x424F4353
	Offset: 0x50E8
	Size: 0xA8
	Parameters: 0
	Flags: None
	Line Number: 2020
*/
function function_setup_craftable_pieces()
{
	var_unitrigger_stub = function_spawnstruct();
	var_unitrigger_stub.var_craftableStub = level.var_zombie_include_craftables[self.var_name];
	var_unitrigger_stub.var_equipname = self.var_name;
	var_unitrigger_stub.var_craftableSpawn = var_unitrigger_stub function_craftable_piece_unitriggers(self.var_name, var_unitrigger_stub.var_origin);
	level.var_a_uts_craftables[level.var_a_uts_craftables.size] = var_unitrigger_stub;
	return var_unitrigger_stub;
}

/*
	Name: function_craftable_has_piece
	Namespace: namespace_zm_craftables
	Checksum: 0x424F4353
	Offset: 0x5198
	Size: 0x98
	Parameters: 1
	Flags: None
	Line Number: 2040
*/
function function_craftable_has_piece(var_piece)
{
	for(var_i = 0; var_i < self.var_a_pieceSpawns.size; var_i++)
	{
		if(self.var_a_pieceSpawns[var_i].var_pieceName == var_piece.var_pieceName && self.var_a_pieceSpawns[var_i].var_craftablename == var_piece.var_craftablename)
		{
			return 1;
		}
	}
	return 0;
}

/*
	Name: function_get_actual_uts_craftable
	Namespace: namespace_zm_craftables
	Checksum: 0x424F4353
	Offset: 0x5238
	Size: 0x50
	Parameters: 0
	Flags: None
	Line Number: 2062
*/
function function_get_actual_uts_craftable()
{
	if(self.var_craftable_name == "open_table" && self.var_n_open_craftable_choice != -1)
	{
		return self.var_stub.var_a_uts_open_craftables_available[self.var_n_open_craftable_choice];
	}
	else
	{
		return self.var_stub;
	}
}

/*
	Name: function_get_actual_craftableSpawn
	Namespace: namespace_zm_craftables
	Checksum: 0x424F4353
	Offset: 0x5290
	Size: 0x98
	Parameters: 0
	Flags: None
	Line Number: 2084
*/
function function_get_actual_craftableSpawn()
{
	if(self.var_craftable_name == "open_table" && self.var_stub.var_n_open_craftable_choice != -1 && isdefined(self.var_stub.var_a_uts_open_craftables_available[self.var_stub.var_n_open_craftable_choice].var_craftableSpawn))
	{
		return self.var_stub.var_a_uts_open_craftables_available[self.var_stub.var_n_open_craftable_choice].var_craftableSpawn;
	}
	else
	{
		return self;
		return;
	}
	waittillframeend;
}

/*
	Name: function_craftable_can_use_shared_piece
	Namespace: namespace_zm_craftables
	Checksum: 0x424F4353
	Offset: 0x5330
	Size: 0x208
	Parameters: 0
	Flags: None
	Line Number: 2108
*/
function function_craftable_can_use_shared_piece()
{
	var_uts_craftable = self.var_stub;
	if(isdefined(var_uts_craftable.var_n_open_craftable_choice) && var_uts_craftable.var_n_open_craftable_choice != -1 && isdefined(var_uts_craftable.var_a_uts_open_craftables_available[var_uts_craftable.var_n_open_craftable_choice]))
	{
		return 1;
	}
	if(isdefined(var_uts_craftable.var_craftableStub.var_need_all_pieces) && var_uts_craftable.var_craftableStub.var_need_all_pieces)
	{
		foreach(var_piece in self.var_a_pieceSpawns)
		{
			if(!(isdefined(var_piece.var_in_shared_inventory) && var_piece.var_in_shared_inventory))
			{
				return 0;
			}
		}
		return 1;
	}
	else
	{
		foreach(var_piece in self.var_a_pieceSpawns)
		{
			if(!(isdefined(var_piece.var_crafted) && var_piece.var_crafted) && (isdefined(var_piece.var_in_shared_inventory) && var_piece.var_in_shared_inventory))
			{
				return 1;
			}
		}
	}
	return 0;
}

/*
	Name: function_craftable_set_piece_crafted
	Namespace: namespace_zm_craftables
	Checksum: 0x424F4353
	Offset: 0x5540
	Size: 0x1D8
	Parameters: 2
	Flags: None
	Line Number: 2149
*/
function function_craftable_set_piece_crafted(var_pieceSpawn_check, var_player)
{
	var_craftableSpawn_check = function_get_actual_craftableSpawn();
	foreach(var_pieceSpawn in var_craftableSpawn_check.var_a_pieceSpawns)
	{
		if(isdefined(var_pieceSpawn_check))
		{
			if(var_pieceSpawn.var_pieceName == var_pieceSpawn_check.var_pieceName && var_pieceSpawn.var_craftablename == var_pieceSpawn_check.var_craftablename)
			{
				var_pieceSpawn.var_crafted = 1;
				if(isdefined(var_pieceSpawn.var_onCrafted))
				{
					var_pieceSpawn thread [[var_pieceSpawn.var_onCrafted]](var_player);
					continue;
				}
			}
		}
		if(isdefined(var_pieceSpawn.var_is_shared) && var_pieceSpawn.var_is_shared && (isdefined(var_pieceSpawn.var_in_shared_inventory) && var_pieceSpawn.var_in_shared_inventory))
		{
			var_pieceSpawn.var_crafted = 1;
			if(isdefined(var_pieceSpawn.var_onCrafted))
			{
				var_pieceSpawn thread [[var_pieceSpawn.var_onCrafted]](var_player);
			}
			var_pieceSpawn.var_in_shared_inventory = 0;
		}
	}
}

/*
	Name: function_craftable_set_piece_crafting
	Namespace: namespace_zm_craftables
	Checksum: 0x424F4353
	Offset: 0x5720
	Size: 0x160
	Parameters: 1
	Flags: None
	Line Number: 2188
*/
function function_craftable_set_piece_crafting(var_pieceSpawn_check)
{
	var_craftableSpawn_check = function_get_actual_craftableSpawn();
	foreach(var_pieceSpawn in var_craftableSpawn_check.var_a_pieceSpawns)
	{
		if(isdefined(var_pieceSpawn_check))
		{
			if(var_pieceSpawn.var_pieceName == var_pieceSpawn_check.var_pieceName && var_pieceSpawn.var_craftablename == var_pieceSpawn_check.var_craftablename)
			{
				var_pieceSpawn.var_crafting = 1;
			}
		}
		if(isdefined(var_pieceSpawn.var_is_shared) && var_pieceSpawn.var_is_shared && (isdefined(var_pieceSpawn.var_in_shared_inventory) && var_pieceSpawn.var_in_shared_inventory))
		{
			var_pieceSpawn.var_crafting = 1;
		}
	}
}

/*
	Name: function_craftable_clear_piece_crafting
	Namespace: namespace_zm_craftables
	Checksum: 0x424F4353
	Offset: 0x5888
	Size: 0x120
	Parameters: 1
	Flags: None
	Line Number: 2217
*/
function function_craftable_clear_piece_crafting(var_pieceSpawn_check)
{
	if(isdefined(var_pieceSpawn_check))
	{
		var_pieceSpawn_check.var_crafting = 0;
	}
	var_craftableSpawn_check = function_get_actual_craftableSpawn();
	foreach(var_pieceSpawn in var_craftableSpawn_check.var_a_pieceSpawns)
	{
		if(isdefined(var_pieceSpawn.var_is_shared) && var_pieceSpawn.var_is_shared && (isdefined(var_pieceSpawn.var_in_shared_inventory) && var_pieceSpawn.var_in_shared_inventory))
		{
			var_pieceSpawn.var_crafting = 0;
		}
	}
}

/*
	Name: function_craftable_is_piece_crafted
	Namespace: namespace_zm_craftables
	Checksum: 0x424F4353
	Offset: 0x59B0
	Size: 0xC0
	Parameters: 1
	Flags: None
	Line Number: 2243
*/
function function_craftable_is_piece_crafted(var_piece)
{
	for(var_i = 0; var_i < self.var_a_pieceSpawns.size; var_i++)
	{
		if(self.var_a_pieceSpawns[var_i].var_pieceName == var_piece.var_pieceName && self.var_a_pieceSpawns[var_i].var_craftablename == var_piece.var_craftablename)
		{
			return isdefined(self.var_a_pieceSpawns[var_i].var_crafted) && self.var_a_pieceSpawns[var_i].var_crafted;
		}
	}
	return 0;
}

/*
	Name: function_start_crafting_shared_piece
	Namespace: namespace_zm_craftables
	Checksum: 0x424F4353
	Offset: 0x5A78
	Size: 0x20
	Parameters: 0
	Flags: None
	Line Number: 2265
*/
function function_start_crafting_shared_piece()
{
	if(!isdefined(level.var_shared_crafting_in_progress))
	{
		level.var_shared_crafting_in_progress = self;
	}
}

/*
	Name: function_finish_crafting_shared_piece
	Namespace: namespace_zm_craftables
	Checksum: 0x424F4353
	Offset: 0x5AA0
	Size: 0x20
	Parameters: 0
	Flags: None
	Line Number: 2283
*/
function function_finish_crafting_shared_piece()
{
	if(self === level.var_shared_crafting_in_progress)
	{
		level.var_shared_crafting_in_progress = undefined;
	}
}

/*
	Name: function_can_craft_shared_piece
	Namespace: namespace_zm_craftables
	Checksum: 0x424F4353
	Offset: 0x5AC8
	Size: 0x30
	Parameters: 1
	Flags: None
	Line Number: 2301
*/
function function_can_craft_shared_piece(var_continuing)
{
	if(var_continuing)
	{
		return self === level.var_shared_crafting_in_progress;
	}
	return !isdefined(level.var_shared_crafting_in_progress);
}

/*
	Name: function_craftable_is_piece_crafting
	Namespace: namespace_zm_craftables
	Checksum: 0x424F4353
	Offset: 0x5B00
	Size: 0x170
	Parameters: 1
	Flags: None
	Line Number: 2320
*/
function function_craftable_is_piece_crafting(var_pieceSpawn_check)
{
	var_craftableSpawn_check = function_get_actual_craftableSpawn();
	foreach(var_pieceSpawn in var_craftableSpawn_check.var_a_pieceSpawns)
	{
		if(isdefined(var_pieceSpawn_check))
		{
			if(var_pieceSpawn.var_pieceName == var_pieceSpawn_check.var_pieceName && var_pieceSpawn.var_craftablename == var_pieceSpawn_check.var_craftablename)
			{
				return var_pieceSpawn.var_crafting;
			}
		}
		if(isdefined(var_pieceSpawn.var_is_shared) && var_pieceSpawn.var_is_shared && (isdefined(var_pieceSpawn.var_in_shared_inventory) && var_pieceSpawn.var_in_shared_inventory) && (isdefined(var_pieceSpawn.var_crafting) && var_pieceSpawn.var_crafting))
		{
			return 1;
		}
	}
	return 0;
}

/*
	Name: function_craftable_is_piece_crafted_or_crafting
	Namespace: namespace_zm_craftables
	Checksum: 0x424F4353
	Offset: 0x5C78
	Size: 0xF8
	Parameters: 1
	Flags: None
	Line Number: 2350
*/
function function_craftable_is_piece_crafted_or_crafting(var_piece)
{
	for(var_i = 0; var_i < self.var_a_pieceSpawns.size; var_i++)
	{
		if(self.var_a_pieceSpawns[var_i].var_pieceName == var_piece.var_pieceName && self.var_a_pieceSpawns[var_i].var_craftablename == var_piece.var_craftablename)
		{
			return isdefined(self.var_a_pieceSpawns[var_i].var_crafted) && self.var_a_pieceSpawns[var_i].var_crafted || (isdefined(self.var_a_pieceSpawns[var_i].var_crafting) && self.var_a_pieceSpawns[var_i].var_crafting);
		}
	}
	return 0;
}

/*
	Name: function_craftable_all_crafted
	Namespace: namespace_zm_craftables
	Checksum: 0x424F4353
	Offset: 0x5D78
	Size: 0x160
	Parameters: 0
	Flags: None
	Line Number: 2372
*/
function function_craftable_all_crafted()
{
	if(isdefined(self.var_stub.var_craftableStub.var_need_all_pieces) && self.var_stub.var_craftableStub.var_need_all_pieces)
	{
		foreach(var_piece in self.var_a_pieceSpawns)
		{
			if(!(isdefined(var_piece.var_in_shared_inventory) && var_piece.var_in_shared_inventory) && !var_piece.var_crafted)
			{
				return 0;
			}
		}
		return 1;
	}
	for(var_i = 0; var_i < self.var_a_pieceSpawns.size; var_i++)
	{
		if(!(isdefined(self.var_a_pieceSpawns[var_i].var_crafted) && self.var_a_pieceSpawns[var_i].var_crafted))
		{
			return 0;
		}
	}
	return 1;
}

/*
	Name: function_waittill_crafted
	Namespace: namespace_zm_craftables
	Checksum: 0x424F4353
	Offset: 0x5EE0
	Size: 0x30
	Parameters: 1
	Flags: None
	Line Number: 2405
*/
function function_waittill_crafted(var_craftable_name)
{
	level waittill(var_craftable_name + "_crafted", var_player);
	return var_player;
}

/*
	Name: function_player_can_craft
	Namespace: namespace_zm_craftables
	Checksum: 0x424F4353
	Offset: 0x5F18
	Size: 0x290
	Parameters: 3
	Flags: None
	Line Number: 2421
*/
function function_player_can_craft(var_craftableSpawn, var_continuing, var_slot)
{
	if(!isdefined(var_craftableSpawn))
	{
		return 0;
	}
	if(!isdefined(var_slot))
	{
		var_slot = var_craftableSpawn.var_inventory_slot;
	}
	if(!var_craftableSpawn function_craftable_can_use_shared_piece())
	{
		if(!isdefined(var_slot))
		{
			return 0;
		}
		if(!isdefined(self.var_current_craftable_pieces[var_slot]))
		{
			return 0;
		}
		if(!var_craftableSpawn function_craftable_has_piece(self.var_current_craftable_pieces[var_slot]))
		{
			return 0;
		}
		if(isdefined(var_continuing) && var_continuing)
		{
			if(var_craftableSpawn function_craftable_is_piece_crafted(self.var_current_craftable_pieces[var_slot]))
			{
				return 0;
			}
		}
		else if(var_craftableSpawn function_craftable_is_piece_crafted_or_crafting(self.var_current_craftable_pieces[var_slot]))
		{
			return 0;
		}
	}
	else if(isdefined(var_craftableSpawn.var_stub.var_crafted) && var_craftableSpawn.var_stub.var_crafted && !var_continuing)
	{
		return 0;
	}
	if(var_craftableSpawn.var_stub.var_useTime > 0 && !self function_can_craft_shared_piece(var_continuing))
	{
		return 0;
	}
	if(isdefined(var_craftableSpawn.var_stub) && isdefined(var_craftableSpawn.var_stub.var_custom_craftablestub_update_prompt) && isdefined(var_craftableSpawn.var_stub.var_playertrigger[0]) && isdefined(var_craftableSpawn.var_stub.var_playertrigger[0].var_stub) && !var_craftableSpawn.var_stub.var_playertrigger[0].var_stub [[var_craftableSpawn.var_stub.var_custom_craftablestub_update_prompt]](self, 1, var_craftableSpawn.var_stub.var_playertrigger[self function_GetEntityNumber()]))
	{
		return 0;
	}
	return 1;
}

/*
	Name: function_craftable_transfer_data
	Namespace: namespace_zm_craftables
	Checksum: 0x424F4353
	Offset: 0x61B0
	Size: 0x230
	Parameters: 0
	Flags: None
	Line Number: 2482
*/
function function_craftable_transfer_data()
{
	var_uts_craftable = self.var_stub;
	if(var_uts_craftable.var_n_open_craftable_choice == -1 || !isdefined(var_uts_craftable.var_a_uts_open_craftables_available[var_uts_craftable.var_n_open_craftable_choice]))
	{
		return;
	}
	var_uts_source = var_uts_craftable.var_a_uts_open_craftables_available[var_uts_craftable.var_n_open_craftable_choice];
	var_uts_target = var_uts_craftable;
	var_uts_target.var_craftableStub = var_uts_source.var_craftableStub;
	var_uts_target.var_craftableSpawn = var_uts_source.var_craftableSpawn;
	var_uts_target.var_crafted = var_uts_source.var_crafted;
	var_uts_target.var_cursor_hint = var_uts_source.var_cursor_hint;
	var_uts_target.var_custom_craftable_update_prompt = var_uts_source.var_custom_craftable_update_prompt;
	var_uts_target.var_equipname = var_uts_source.var_equipname;
	var_uts_target.var_hint_string = var_uts_source.var_hint_string;
	var_uts_target.var_Persistent = var_uts_source.var_Persistent;
	var_uts_target.var_prompt_and_visibility_func = var_uts_source.var_prompt_and_visibility_func;
	var_uts_target.var_trigger_func = var_uts_source.var_trigger_func;
	var_uts_target.var_trigger_hintstring = var_uts_source.var_trigger_hintstring;
	var_uts_target.var_weaponName = var_uts_source.var_weaponName;
	var_uts_target.var_craftableSpawn.var_stub = var_uts_target;
	thread namespace_zm_unitrigger::function_unregister_unitrigger(var_uts_source);
	var_uts_source function_craftablestub_remove();
	return var_uts_target;
}

/*
	Name: function_player_craft
	Namespace: namespace_zm_craftables
	Checksum: 0x424F4353
	Offset: 0x63E8
	Size: 0x588
	Parameters: 2
	Flags: None
	Line Number: 2519
*/
function function_player_craft(var_craftableSpawn, var_slot)
{
	if(!isdefined(var_slot))
	{
		var_slot = var_craftableSpawn.var_inventory_slot;
	}
	if(!isdefined(self.var_current_craftable_pieces))
	{
		self.var_current_craftable_pieces = [];
	}
	if(isdefined(var_slot))
	{
		var_craftableSpawn function_craftable_set_piece_crafted(self.var_current_craftable_pieces[var_slot], self);
	}
	if(isdefined(var_slot) && isdefined(self.var_current_craftable_pieces[var_slot]) && (isdefined(self.var_current_craftable_pieces[var_slot].var_crafted) && self.var_current_craftable_pieces[var_slot].var_crafted))
	{
		function_player_destroy_piece(self.var_current_craftable_pieces[var_slot], var_slot);
	}
	if(isdefined(var_craftableSpawn.var_stub.var_n_open_craftable_choice))
	{
		var_uts_craftable = var_craftableSpawn function_craftable_transfer_data();
		var_craftableSpawn = var_uts_craftable.var_craftableSpawn;
		function_update_open_table_status();
	}
	else
	{
		var_uts_craftable = var_craftableSpawn.var_stub;
	}
	if(!isdefined(var_uts_craftable.var_model) && isdefined(var_uts_craftable.var_craftableStub.var_STR_MODEL))
	{
		var_craftableStub = var_uts_craftable.var_craftableStub;
		var_s_model = namespace_struct::function_get(var_uts_craftable.var_target, "targetname");
		if(isdefined(var_s_model))
		{
			var_m_spawn = function_spawn("script_model", var_s_model.var_origin);
			if(isdefined(var_craftableStub.var_v_origin_offset))
			{
				var_m_spawn.var_origin = var_m_spawn.var_origin + var_craftableStub.var_v_origin_offset;
			}
			var_m_spawn.var_angles = var_s_model.var_angles;
			if(isdefined(var_craftableStub.var_v_angle_offset))
			{
				var_m_spawn.var_angles = var_m_spawn.var_angles + var_craftableStub.var_v_angle_offset;
			}
			var_m_spawn function_SetModel(var_craftableStub.var_STR_MODEL);
			var_uts_craftable.var_model = var_m_spawn;
		}
	}
	if(isdefined(var_uts_craftable.var_model))
	{
		for(var_i = 0; var_i < var_craftableSpawn.var_a_pieceSpawns.size; var_i++)
		{
			if(isdefined(var_craftableSpawn.var_a_pieceSpawns[var_i].var_tag_name))
			{
				var_uts_craftable.var_model function_notsolid();
				if(!(isdefined(var_craftableSpawn.var_a_pieceSpawns[var_i].var_crafted) && var_craftableSpawn.var_a_pieceSpawns[var_i].var_crafted))
				{
					var_uts_craftable.var_model function_HidePart(var_craftableSpawn.var_a_pieceSpawns[var_i].var_tag_name);
					continue;
				}
				var_uts_craftable.var_model function_show();
				var_uts_craftable.var_model function_ShowPart(var_craftableSpawn.var_a_pieceSpawns[var_i].var_tag_name);
			}
		}
	}
	self function_track_craftable_pieces_crafted(var_craftableSpawn);
	if(var_craftableSpawn function_craftable_all_crafted())
	{
		self function_player_finish_craftable(var_craftableSpawn);
		self function_track_craftables_crafted(var_craftableSpawn);
		if(isdefined(level.var_craftable_crafted_custom_func))
		{
			self thread [[level.var_craftable_crafted_custom_func]](var_craftableSpawn);
		}
	}
	else
	{
		self function_playsound("zmb_buildable_piece_add");
		/#
			namespace_::function_Assert(isdefined(level.var_zombie_craftableStubs[var_craftableSpawn.var_craftable_name].var_str_crafting), "Dev Block strings are not supported");
		#/
		if(isdefined(level.var_zombie_craftableStubs[var_craftableSpawn.var_craftable_name].var_str_crafting))
		{
			return level.var_zombie_craftableStubs[var_craftableSpawn.var_craftable_name].var_str_crafting;
		}
	}
	return "";
	ERROR: Exception occured: Stack empty.
}

/*
	Name: function_update_open_table_status
	Namespace: namespace_zm_craftables
	Checksum: 0x424F4353
	Offset: 0x6978
	Size: 0x268
	Parameters: 0
	Flags: None
	Line Number: 2619
*/
function function_update_open_table_status()
{
	var_b_open_craftables_remaining = 0;
	foreach(var_uts_craftable in level.var_a_uts_craftables)
	{
		if(isdefined(level.var_zombie_include_craftables[var_uts_craftable.var_equipname]) && (isdefined(level.var_zombie_include_craftables[var_uts_craftable.var_equipname].var_is_open_table) && level.var_zombie_include_craftables[var_uts_craftable.var_equipname].var_is_open_table))
		{
			var_b_piece_crafted = 0;
			foreach(var_pieceSpawn in var_uts_craftable.var_craftableSpawn.var_a_pieceSpawns)
			{
				if(isdefined(var_pieceSpawn.var_crafted) && var_pieceSpawn.var_crafted)
				{
					var_b_piece_crafted = 1;
					break;
				}
			}
			if(!var_b_piece_crafted)
			{
				var_b_open_craftables_remaining = 1;
			}
		}
	}
	if(!var_b_open_craftables_remaining)
	{
		foreach(var_uts_craftable in level.var_a_uts_craftables)
		{
			if(var_uts_craftable.var_equipname == "open_table")
			{
				thread namespace_zm_unitrigger::function_unregister_unitrigger(var_uts_craftable);
			}
		}
	}
}

/*
	Name: function_player_finish_craftable
	Namespace: namespace_zm_craftables
	Checksum: 0x424F4353
	Offset: 0x6BE8
	Size: 0x88
	Parameters: 1
	Flags: None
	Line Number: 2663
*/
function function_player_finish_craftable(var_craftableSpawn)
{
	var_craftableSpawn.var_crafted = 1;
	var_craftableSpawn.var_stub.var_crafted = 1;
	var_craftableSpawn notify("hash_crafted", self);
	level.var_craftables_crafted[var_craftableSpawn.var_craftable_name] = 1;
	level notify(var_craftableSpawn.var_craftable_name + "_crafted", self);
}

/*
	Name: function_complete_craftable
	Namespace: namespace_zm_craftables
	Checksum: 0x424F4353
	Offset: 0x6C78
	Size: 0x138
	Parameters: 1
	Flags: None
	Line Number: 2682
*/
function function_complete_craftable(var_str_craftable_name)
{
	foreach(var_uts_craftable in level.var_a_uts_craftables)
	{
		if(var_uts_craftable.var_craftableStub.var_name == var_str_craftable_name)
		{
			var_player = function_GetPlayers()[0];
			var_player function_player_finish_craftable(var_uts_craftable.var_craftableSpawn);
			thread namespace_zm_unitrigger::function_unregister_unitrigger(var_uts_craftable);
			if(isdefined(var_uts_craftable.var_craftableStub.var_onFullyCrafted))
			{
				var_uts_craftable [[var_uts_craftable.var_craftableStub.var_onFullyCrafted]]();
				return;
			}
		}
	}
}

/*
	Name: function_craftablestub_remove
	Namespace: namespace_zm_craftables
	Checksum: 0x424F4353
	Offset: 0x6DB8
	Size: 0x20
	Parameters: 0
	Flags: None
	Line Number: 2710
*/
function function_craftablestub_remove()
{
	function_ArrayRemoveValue(level.var_a_uts_craftables, self);
}

/*
	Name: function_craftabletrigger_update_prompt
	Namespace: namespace_zm_craftables
	Checksum: 0x424F4353
	Offset: 0x6DE0
	Size: 0xB0
	Parameters: 1
	Flags: None
	Line Number: 2725
*/
function function_craftabletrigger_update_prompt(var_player)
{
	var_can_use = self.var_stub function_craftablestub_update_prompt(var_player);
	if(isdefined(self.var_stub.var_hint_parm1))
	{
		self function_setHintString(self.var_stub.var_hint_string, self.var_stub.var_hint_parm1);
	}
	else
	{
		self function_setHintString(self.var_stub.var_hint_string);
	}
	return var_can_use;
}

/*
	Name: function_craftablestub_update_prompt
	Namespace: namespace_zm_craftables
	Checksum: 0x424F4353
	Offset: 0x6E98
	Size: 0x3F0
	Parameters: 3
	Flags: None
	Line Number: 2749
*/
function function_craftablestub_update_prompt(var_player, var_unitrigger, var_slot)
{
	if(!isdefined(var_slot))
	{
		var_slot = self.var_craftableStub.var_inventory_slot;
	}
	if(!isdefined(var_player.var_current_craftable_pieces))
	{
		var_player.var_current_craftable_pieces = [];
	}
	self.var_hint_parm1 = undefined;
	if(!self function_anystub_update_prompt(var_player))
	{
		return 0;
	}
	if(var_player namespace_bgb::function_is_enabled("zm_bgb_disorderly_combat"))
	{
		self.var_hint_string = "";
		return 0;
	}
	if(isdefined(self.var_is_locked) && self.var_is_locked)
	{
		return 1;
	}
	var_can_use = 1;
	if(isdefined(self.var_custom_craftablestub_update_prompt) && !self [[self.var_custom_craftablestub_update_prompt]](var_player))
	{
		return 0;
	}
	var_initial_current_weapon = var_player function_GetCurrentWeapon();
	var_current_weapon = namespace_zm_weapons::function_get_nonalternate_weapon(var_initial_current_weapon);
	if(var_current_weapon.var_isHeroWeapon || var_current_weapon.var_isgadget)
	{
		self.var_hint_string = "";
		return 0;
	}
	if(!(isdefined(self.var_crafted) && self.var_crafted))
	{
		if(!self.var_craftableSpawn function_craftable_can_use_shared_piece())
		{
			if(!isdefined(var_player.var_current_craftable_pieces[var_slot]))
			{
				self.var_hint_string = &"ZOMBIE_BUILD_PIECE_MORE";
				return 0;
			}
			else if(!self.var_craftableSpawn function_craftable_has_piece(var_player.var_current_craftable_pieces[var_slot]))
			{
				self.var_hint_string = &"ZOMBIE_BUILD_PIECE_WRONG";
				return 0;
			}
		}
		/#
			namespace_::function_Assert(isdefined(level.var_zombie_craftableStubs[self.var_equipname].var_str_to_craft), "Dev Block strings are not supported");
		#/
		self.var_hint_string = level.var_zombie_craftableStubs[self.var_equipname].var_str_to_craft;
	}
	else if(self.var_Persistent == 1)
	{
		if(namespace_zm_equipment::function_is_limited(self.var_weaponName) && namespace_zm_equipment::function_limited_in_use(self.var_weaponName))
		{
			self.var_hint_string = &"ZOMBIE_BUILD_PIECE_ONLY_ONE";
			return 0;
		}
		if(var_player namespace_zm_equipment::function_has_player_equipment(self.var_weaponName))
		{
			self.var_hint_string = &"ZM_MINECRAFT_BUILD_PIECE_BUY_AGAIN";
			self.var_hint_parm1 = level.var_448ee6c4;
			return 1;
		}
		self.var_hint_string = self.var_trigger_hintstring;
	}
	else if(self.var_Persistent == 2)
	{
		if(!namespace_zm_weapons::function_limited_weapon_below_quota(self.var_weaponName, undefined))
		{
			self.var_hint_string = &"ZOMBIE_GO_TO_THE_BOX_LIMITED";
			return 0;
		}
		else if(isdefined(self.var_str_taken) && self.var_str_taken)
		{
			self.var_hint_string = &"ZOMBIE_GO_TO_THE_BOX";
			return 0;
		}
		self.var_hint_string = self.var_trigger_hintstring;
	}
	else
	{
		self.var_hint_string = "";
		return 0;
	}
	return 1;
}

/*
	Name: function_choose_open_craftable
	Namespace: namespace_zm_craftables
	Checksum: 0x424F4353
	Offset: 0x7290
	Size: 0x3C8
	Parameters: 1
	Flags: None
	Line Number: 2852
*/
function function_choose_open_craftable(var_player)
{
	self endon("hash_kill_choose_open_craftable");
	var_n_playernum = var_player function_GetEntityNumber();
	self.var_b_open_craftable_checking_input = 1;
	var_b_got_input = 1;
	var_hintTextHudElem = function_newClientHudElem(var_player);
	var_hintTextHudElem.var_alignX = "center";
	var_hintTextHudElem.var_alignY = "middle";
	var_hintTextHudElem.var_horzAlign = "center";
	var_hintTextHudElem.var_vertAlign = "middle";
	var_hintTextHudElem.var_y = 95;
	if(var_player function_IsSplitscreen())
	{
		var_hintTextHudElem.var_y = -50;
	}
	var_hintTextHudElem.var_foreground = 1;
	var_hintTextHudElem.var_font = "default";
	var_hintTextHudElem.var_fontscale = 1.1;
	var_hintTextHudElem.var_alpha = 1;
	var_hintTextHudElem.var_color = (1, 1, 1);
	var_hintTextHudElem function_setText(&"ZOMBIE_CRAFTABLE_CHANGE_BUILD");
	if(!isdefined(self.var_openCraftableHudElem))
	{
		self.var_openCraftableHudElem = [];
	}
	self.var_openCraftableHudElem[var_n_playernum] = var_hintTextHudElem;
	while(isdefined(self.var_playertrigger[var_n_playernum]) && !self.var_crafted)
	{
		if(var_player function_ActionSlotOneButtonPressed())
		{
			self.var_n_open_craftable_choice++;
			var_b_got_input = 1;
		}
		else if(var_player function_ActionSlotTwoButtonPressed())
		{
			self.var_n_open_craftable_choice--;
			var_b_got_input = 1;
		}
		if(self.var_n_open_craftable_choice >= self.var_a_uts_open_craftables_available.size)
		{
			self.var_n_open_craftable_choice = 0;
		}
		else if(self.var_n_open_craftable_choice < 0)
		{
			self.var_n_open_craftable_choice = self.var_a_uts_open_craftables_available.size - 1;
		}
		if(var_b_got_input)
		{
			self.var_equipname = self.var_a_uts_open_craftables_available[self.var_n_open_craftable_choice].var_equipname;
			self.var_hint_string = self.var_a_uts_open_craftables_available[self.var_n_open_craftable_choice].var_hint_string;
			self.var_playertrigger[var_n_playernum] function_setHintString(self.var_hint_string);
			var_b_got_input = 0;
			wait(0.5);
		}
		if(var_player namespace_util::function_is_player_looking_at(self.var_playertrigger[var_n_playernum].var_origin, 0.76))
		{
			self.var_openCraftableHudElem[var_n_playernum].var_alpha = 1;
		}
		else
		{
			self.var_openCraftableHudElem[var_n_playernum].var_alpha = 0;
		}
		wait(0.05);
	}
	self.var_b_open_craftable_checking_input = 0;
	self.var_openCraftableHudElem[var_n_playernum] function_destroy();
	self.var_openCraftableHudElem[var_n_playernum] = undefined;
}

/*
	Name: function_open_craftablestub_update_prompt
	Namespace: namespace_zm_craftables
	Checksum: 0x424F4353
	Offset: 0x7660
	Size: 0x3A8
	Parameters: 2
	Flags: None
	Line Number: 2932
*/
function function_open_craftablestub_update_prompt(var_player, var_slot)
{
	if(!isdefined(var_slot))
	{
		var_slot = 0;
	}
	if(!(isdefined(self.var_crafted) && self.var_crafted))
	{
		self.var_a_uts_open_craftables_available = [];
		foreach(var_uts_craftable in level.var_a_uts_craftables)
		{
			if(isdefined(var_uts_craftable.var_craftableStub.var_is_open_table) && var_uts_craftable.var_craftableStub.var_is_open_table && (!(isdefined(var_uts_craftable.var_crafted) && var_uts_craftable.var_crafted)) && var_uts_craftable.var_craftableSpawn.var_craftable_name != "open_table" && var_uts_craftable.var_craftableSpawn function_craftable_can_use_shared_piece())
			{
				self.var_a_uts_open_craftables_available[self.var_a_uts_open_craftables_available.size] = var_uts_craftable;
			}
		}
		if(self.var_a_uts_open_craftables_available.size < 2)
		{
			self notify("hash_kill_choose_open_craftable");
			self.var_b_open_craftable_checking_input = 0;
			var_n_entitynum = var_player function_GetEntityNumber();
			if(isdefined(self.var_openCraftableHudElem) && isdefined(self.var_openCraftableHudElem[var_n_entitynum]))
			{
				self.var_openCraftableHudElem[var_n_entitynum] function_destroy();
				self.var_openCraftableHudElem[var_n_entitynum] = undefined;
			}
		}
		switch(self.var_a_uts_open_craftables_available.size)
		{
			case 0:
			{
				if(!isdefined(var_player.var_current_craftable_pieces[var_slot]))
				{
					self.var_hint_string = &"ZOMBIE_BUILD_PIECE_MORE";
					self.var_n_open_craftable_choice = -1;
					return 0;
					break;
				}
			}
			case 1:
			{
				self.var_n_open_craftable_choice = 0;
				self.var_equipname = self.var_a_uts_open_craftables_available[self.var_n_open_craftable_choice].var_equipname;
				return 1;
			}
			default
			{
				if(!self.var_b_open_craftable_checking_input)
				{
					thread function_choose_open_craftable(var_player);
				}
				return 1;
			}
		}
	}
	else if(self.var_Persistent == 2)
	{
		if(!namespace_zm_weapons::function_limited_weapon_below_quota(self.var_weaponName, undefined))
		{
			self.var_hint_string = &"ZOMBIE_GO_TO_THE_BOX_LIMITED";
			return 0;
		}
		else if(isdefined(self.var_bought) && self.var_bought)
		{
			self.var_hint_string = &"ZOMBIE_GO_TO_THE_BOX";
			return 0;
		}
		else if(isdefined(self.var_str_taken) && self.var_str_taken)
		{
			self.var_hint_string = &"ZOMBIE_GO_TO_THE_BOX";
			return 0;
		}
		self.var_hint_string = self.var_trigger_hintstring;
		return 1;
	}
	else if(self.var_Persistent == 1)
	{
		return 1;
	}
	return 0;
}

/*
	Name: function_player_continue_crafting
	Namespace: namespace_zm_craftables
	Checksum: 0x424F4353
	Offset: 0x7A10
	Size: 0x290
	Parameters: 2
	Flags: None
	Line Number: 3024
*/
function function_player_continue_crafting(var_craftableSpawn, var_slot)
{
	if(self namespace_laststand::function_player_is_in_laststand() || self namespace_zm_utility::function_in_revive_trigger())
	{
		return 0;
	}
	if(!self function_player_can_craft(var_craftableSpawn, 1))
	{
		return 0;
	}
	if(isdefined(self.var_screecher))
	{
		return 0;
	}
	if(!self function_useButtonPressed())
	{
		return 0;
	}
	if(var_craftableSpawn.var_stub.var_useTime > 0 && isdefined(var_slot) && !var_craftableSpawn function_craftable_is_piece_crafting(self.var_current_craftable_pieces[var_slot]))
	{
		return 0;
	}
	var_trigger = var_craftableSpawn.var_stub namespace_zm_unitrigger::function_unitrigger_trigger(self);
	if(var_craftableSpawn.var_stub.var_script_unitrigger_type == "unitrigger_radius_use")
	{
		var_torigin = var_craftableSpawn.var_stub namespace_zm_unitrigger::function_unitrigger_origin();
		var_porigin = self function_GetEye();
		var_radius_sq = 2.25 * var_craftableSpawn.var_stub.var_radius * var_craftableSpawn.var_stub.var_radius;
		if(function_Distance2DSquared(var_torigin, var_porigin) > var_radius_sq)
		{
			return 0;
		}
	}
	else if(!isdefined(var_trigger) || !var_trigger function_istouching(self))
	{
		return 0;
	}
	if(isdefined(var_craftableSpawn.var_stub.var_require_look_at) && var_craftableSpawn.var_stub.var_require_look_at && !self namespace_util::function_is_player_looking_at(var_trigger.var_origin, 0.76))
	{
		return 0;
	}
	return 1;
}

/*
	Name: function_player_progress_bar_update
	Namespace: namespace_zm_craftables
	Checksum: 0x424F4353
	Offset: 0x7CA8
	Size: 0xD0
	Parameters: 2
	Flags: None
	Line Number: 3078
*/
function function_player_progress_bar_update(var_start_time, var_craft_time)
{
	self endon("hash_entering_last_stand");
	self endon("hash_death");
	self endon("hash_disconnect");
	self endon("hash_craftable_progress_end");
	while(isdefined(self) && GetTime() - var_start_time < var_craft_time)
	{
		var_progress = GetTime() - var_start_time / var_craft_time;
		if(var_progress < 0)
		{
			var_progress = 0;
		}
		if(var_progress > 1)
		{
			var_progress = 1;
		}
		self.var_useBar namespace_hud::function_updateBar(var_progress);
		wait(0.05);
	}
}

/*
	Name: function_player_progress_bar
	Namespace: namespace_zm_craftables
	Checksum: 0x424F4353
	Offset: 0x7D80
	Size: 0xE0
	Parameters: 2
	Flags: None
	Line Number: 3110
*/
function function_player_progress_bar(var_start_time, var_craft_time)
{
	self.var_useBar = self namespace_hud::function_createPrimaryProgressBar();
	self.var_useBarText = self namespace_hud::function_createPrimaryProgressBarText();
	self.var_useBarText function_setText(&"ZOMBIE_BUILDING");
	if(isdefined(self) && isdefined(var_start_time) && isdefined(var_craft_time))
	{
		self function_player_progress_bar_update(var_start_time, var_craft_time);
	}
	self.var_useBarText namespace_hud::function_destroyElem();
	self.var_useBar namespace_hud::function_destroyElem();
}

/*
	Name: function_craftable_use_hold_think_internal
	Namespace: namespace_zm_craftables
	Checksum: 0x424F4353
	Offset: 0x7E68
	Size: 0x4D8
	Parameters: 2
	Flags: None
	Line Number: 3133
*/
function function_craftable_use_hold_think_internal(var_player, var_slot)
{
	if(!isdefined(var_slot))
	{
		var_slot = self.var_stub.var_craftableSpawn.var_inventory_slot;
	}
	wait(0.01);
	if(!isdefined(self))
	{
		if(isdefined(var_player.var_craftableAudio))
		{
			var_player.var_craftableAudio function_delete();
			var_player.var_craftableAudio = undefined;
			return;
		}
	}
	if(self.var_stub.var_craftableSpawn function_craftable_can_use_shared_piece())
	{
		var_slot = undefined;
	}
	if(!isdefined(self.var_useTime))
	{
		self.var_useTime = function_Int(3000);
	}
	self.var_craft_time = self.var_useTime;
	self.var_craft_start_time = GetTime();
	var_craft_time = self.var_craft_time;
	var_craft_start_time = self.var_craft_start_time;
	if(var_craft_time > 0)
	{
		var_player namespace_zm_utility::function_disable_player_move_states(1);
		var_player namespace_zm_utility::function_increment_is_drinking();
		var_orgweapon = var_player function_GetCurrentWeapon();
		var_build_weapon = function_GetWeapon("zombie_builder");
		var_player function_GiveWeapon(var_build_weapon);
		var_player function_SwitchToWeapon(var_build_weapon);
		if(isdefined(var_slot))
		{
			self.var_stub.var_craftableSpawn function_craftable_set_piece_crafting(var_player.var_current_craftable_pieces[var_slot]);
		}
		else
		{
			var_player function_start_crafting_shared_piece();
		}
		var_player thread function_player_progress_bar(var_craft_start_time, var_craft_time);
		if(isdefined(level.var_craftable_craft_custom_func))
		{
			var_player thread [[level.var_craftable_craft_custom_func]](self.var_stub);
		}
		while(isdefined(self) && var_player function_player_continue_crafting(self.var_stub.var_craftableSpawn, var_slot) && GetTime() - self.var_craft_start_time < self.var_craft_time)
		{
			wait(0.05);
		}
		var_player notify("hash_craftable_progress_end");
		var_player namespace_zm_weapons::function_switch_back_primary_weapon(var_orgweapon);
		var_player function_TakeWeapon(var_build_weapon);
		if(isdefined(var_player.var_IS_DRINKING) && var_player.var_IS_DRINKING)
		{
			var_player namespace_zm_utility::function_decrement_is_drinking();
		}
		var_player namespace_zm_utility::function_enable_player_move_states();
	}
	if(isdefined(self) && var_player function_player_continue_crafting(self.var_stub.var_craftableSpawn, var_slot) && (self.var_craft_time <= 0 || GetTime() - self.var_craft_start_time >= self.var_craft_time))
	{
		if(isdefined(var_slot))
		{
			self.var_stub.var_craftableSpawn function_craftable_clear_piece_crafting(var_player.var_current_craftable_pieces[var_slot]);
		}
		else
		{
			var_player function_finish_crafting_shared_piece();
		}
		self notify("hash_craft_succeed");
	}
	else if(isdefined(var_player.var_craftableAudio))
	{
		var_player.var_craftableAudio function_delete();
		var_player.var_craftableAudio = undefined;
	}
	if(isdefined(var_slot))
	{
		self.var_stub.var_craftableSpawn function_craftable_clear_piece_crafting(var_player.var_current_craftable_pieces[var_slot]);
	}
	else
	{
		var_player function_finish_crafting_shared_piece();
	}
	self notify("hash_craft_failed");
}

/*
	Name: function_craftable_play_craft_fx
	Namespace: namespace_zm_craftables
	Checksum: 0x424F4353
	Offset: 0x8348
	Size: 0x88
	Parameters: 1
	Flags: None
	Line Number: 3233
*/
function function_craftable_play_craft_fx(var_player)
{
	self endon("hash_kill_trigger");
	self endon("hash_craft_succeed");
	self endon("hash_craft_failed");
	while(1)
	{
		function_playFX(level.var__effect["building_dust"], var_player function_GetPlayerCameraPos(), var_player.var_angles);
		wait(0.5);
	}
}

/*
	Name: function_craftable_use_hold_think
	Namespace: namespace_zm_craftables
	Checksum: 0x424F4353
	Offset: 0x83D8
	Size: 0x88
	Parameters: 1
	Flags: None
	Line Number: 3255
*/
function function_craftable_use_hold_think(var_player)
{
	self thread function_craftable_play_craft_fx(var_player);
	self thread function_craftable_use_hold_think_internal(var_player);
	var_retval = self namespace_util::function_waittill_any_return("craft_succeed", "craft_failed");
	if(var_retval == "craft_succeed")
	{
		return 1;
	}
	return 0;
}

/*
	Name: function_craftable_place_think
	Namespace: namespace_zm_craftables
	Checksum: 0x424F4353
	Offset: 0x8468
	Size: 0x1090
	Parameters: 0
	Flags: None
	Line Number: 3277
*/
function function_craftable_place_think()
{
	self notify("hash_craftable_place_think");
	self endon("hash_craftable_place_think");
	self endon("hash_kill_trigger");
	var_player_crafted = undefined;
	while(!(isdefined(self.var_stub.var_crafted) && self.var_stub.var_crafted))
	{
		self waittill("hash_trigger", var_player);
		if(isdefined(level.var_custom_craftable_validation))
		{
			var_valid = self [[level.var_custom_craftable_validation]](var_player);
			if(!var_valid)
			{
				continue;
			}
		}
		if(var_player != self.var_parent_player)
		{
			continue;
		}
		if(isdefined(var_player.var_screecher_weapon))
		{
			continue;
		}
		if(!namespace_zm_utility::function_is_player_valid(var_player))
		{
			var_player thread namespace_zm_utility::function_ignore_triggers(0.5);
			continue;
		}
		var_status = var_player function_player_can_craft(self.var_stub.var_craftableSpawn, 0);
		if(!var_status)
		{
			self.var_stub.var_hint_string = "";
			self function_setHintString(self.var_stub.var_hint_string);
			if(isdefined(self.var_stub.var_onCantUse))
			{
				self.var_stub [[self.var_stub.var_onCantUse]](var_player);
			}
		}
		else if(isdefined(self.var_stub.var_onBeginUse))
		{
			self.var_stub [[self.var_stub.var_onBeginUse]](var_player);
		}
		var_result = self function_craftable_use_hold_think(var_player);
		var_team = var_player.var_pers["team"];
		if(isdefined(self.var_stub.var_onEndUse))
		{
			self.var_stub [[self.var_stub.var_onEndUse]](var_team, var_player, var_result);
		}
		if(!var_result)
		{
			continue;
		}
		if(isdefined(self.var_stub.var_onUse))
		{
			self.var_stub [[self.var_stub.var_onUse]](var_player);
		}
		var_prompt = var_player function_player_craft(self.var_stub.var_craftableSpawn);
		var_player_crafted = var_player;
		self.var_stub.var_hint_string = var_prompt;
		self function_setHintString(self.var_stub.var_hint_string);
	}
	if(isdefined(self.var_stub.var_craftableStub.var_onFullyCrafted))
	{
		var_b_result = self.var_stub [[self.var_stub.var_craftableStub.var_onFullyCrafted]]();
		if(!var_b_result)
		{
			return;
		}
	}
	if(isdefined(var_player_crafted))
	{
		var_player_crafted function_playsound("zmb_craftable_complete");
	}
	if(self.var_stub.var_Persistent == 0)
	{
		self.var_stub function_craftablestub_remove();
		thread namespace_zm_unitrigger::function_unregister_unitrigger(self.var_stub);
		return;
	}
	if(self.var_stub.var_Persistent == 3)
	{
		function_stub_uncraft_craftable(self.var_stub, 1);
		return;
	}
	if(self.var_stub.var_Persistent == 2)
	{
		if(isdefined(var_player_crafted))
		{
			self function_craftabletrigger_update_prompt(var_player_crafted);
		}
		if(!namespace_zm_weapons::function_limited_weapon_below_quota(self.var_stub.var_weaponName, undefined))
		{
			self.var_stub.var_hint_string = &"ZOMBIE_GO_TO_THE_BOX_LIMITED";
			self function_setHintString(self.var_stub.var_hint_string);
			return;
		}
		if(isdefined(self.var_stub.var_str_taken) && self.var_stub.var_str_taken)
		{
			self.var_stub.var_hint_string = &"ZOMBIE_GO_TO_THE_BOX";
			self function_setHintString(self.var_stub.var_hint_string);
			return;
		}
		if(isdefined(self.var_stub.var_model))
		{
			self.var_stub.var_model function_notsolid();
			self.var_stub.var_model function_show();
		}
		while(self.var_stub.var_Persistent == 2)
		{
			self waittill("hash_trigger", var_player);
			if(isdefined(self.var_stub.var_bought) && self.var_stub.var_bought == 1)
			{
				continue;
			}
			if(isdefined(var_player.var_screecher_weapon))
			{
				continue;
			}
			var_current_weapon = var_player function_GetCurrentWeapon();
			if(namespace_zm_utility::function_is_placeable_mine(var_current_weapon) || namespace_zm_equipment::function_is_equipment_that_blocks_purchase(var_current_weapon))
			{
				continue;
			}
			if(var_current_weapon.var_isHeroWeapon || var_current_weapon.var_isgadget)
			{
				continue;
			}
			if(var_player namespace_bgb::function_is_enabled("zm_bgb_disorderly_combat"))
			{
				continue;
			}
			if(isdefined(level.var_custom_craftable_validation))
			{
				var_valid = self [[level.var_custom_craftable_validation]](var_player);
				if(!var_valid)
				{
					continue;
				}
			}
			if(!(isdefined(self.var_stub.var_crafted) && self.var_stub.var_crafted))
			{
				self.var_stub.var_hint_string = "";
				self function_setHintString(self.var_stub.var_hint_string);
				return;
			}
			if(var_player != self.var_parent_player)
			{
				continue;
			}
			if(!namespace_zm_utility::function_is_player_valid(var_player))
			{
				var_player thread namespace_zm_utility::function_ignore_triggers(0.5);
				continue;
			}
			self.var_stub.var_bought = 1;
			if(isdefined(self.var_stub.var_model))
			{
				self.var_stub.var_model thread function_model_fly_away(self);
			}
			if(namespace_zm_weapons::function_limited_weapon_below_quota(self.var_stub.var_weaponName, undefined))
			{
				var_player namespace_zm_weapons::function_weapon_give(self.var_stub.var_weaponName);
				if(isdefined(level.var_zombie_include_craftables[self.var_stub.var_equipname].var_onBuyWeapon))
				{
					self [[level.var_zombie_include_craftables[self.var_stub.var_equipname].var_onBuyWeapon]](var_player);
				}
			}
			if(!namespace_zm_weapons::function_limited_weapon_below_quota(self.var_stub.var_weaponName, undefined))
			{
				self.var_stub.var_hint_string = &"ZOMBIE_GO_TO_THE_BOX_LIMITED";
			}
			else
			{
				self.var_stub.var_hint_string = &"ZOMBIE_GO_TO_THE_BOX";
			}
			self function_setHintString(self.var_stub.var_hint_string);
			var_player function_track_craftables_pickedup(self.var_stub.var_craftableSpawn);
		}
	}
	else if(!isdefined(var_player_crafted) || self function_craftabletrigger_update_prompt(var_player_crafted))
	{
		var_visible = 1;
		var_Hide = function_get_hide_model_if_unavailable(self.var_stub.var_equipname);
		if(var_Hide && isdefined(level.var_custom_craftable_validation))
		{
			var_visible = self [[level.var_custom_craftable_validation]](var_player);
		}
		if(var_visible && isdefined(self.var_stub.var_model))
		{
			self.var_stub.var_model function_notsolid();
			self.var_stub.var_model function_show();
		}
		while(self.var_stub.var_Persistent == 1)
		{
			self waittill("hash_trigger", var_player);
			if(isdefined(var_player.var_screecher_weapon))
			{
				continue;
			}
			if(isdefined(level.var_custom_craftable_validation))
			{
				var_valid = self [[level.var_custom_craftable_validation]](var_player);
				if(!var_valid)
				{
					continue;
				}
			}
			if(!(isdefined(self.var_stub.var_crafted) && self.var_stub.var_crafted))
			{
				self.var_stub.var_hint_string = "";
				self function_setHintString(self.var_stub.var_hint_string);
				return;
			}
			if(var_player != self.var_parent_player)
			{
				continue;
			}
			if(!namespace_zm_utility::function_is_player_valid(var_player))
			{
				var_player thread namespace_zm_utility::function_ignore_triggers(0.5);
				continue;
			}
			if(var_player namespace_zm_equipment::function_has_player_equipment(self.var_stub.var_weaponName))
			{
				if(!var_player namespace_zm_score::function_can_player_purchase(level.var_448ee6c4))
				{
					namespace_zm_utility::function_play_sound_at_pos("no_purchase", var_player.var_origin);
					var_player namespace_zm_audio::function_create_and_play_dialog("general", "outofmoney");
					continue;
				}
				else
				{
					var_player namespace_zm_score::function_minus_to_player_score(level.var_448ee6c4);
					namespace_zm_utility::function_play_sound_at_pos("purchase", var_player.var_origin);
					var_player namespace_zm_audio::function_create_and_play_dialog("general", "generic_wall_buy");
					foreach(var_weapon in var_player function_GetWeaponsList(1))
					{
						if(isdefined(var_weapon.var_isRiotShield) && var_weapon.var_isRiotShield)
						{
							var_player namespace_zm_equipment::function_start_ammo(var_weapon);
							var_player function_giveMaxAmmo(var_weapon);
							var_player namespace_riotshield::function_player_damage_shield(var_weapon.var_weaponstarthitpoints * -1);
						}
					}
					continue;
				}
			}
			if(var_player namespace_bgb::function_is_enabled("zm_bgb_disorderly_combat"))
			{
				continue;
			}
			if(isdefined(level.var_zombie_craftable_persistent_weapon))
			{
				if(self [[level.var_zombie_craftable_persistent_weapon]](var_player))
				{
					continue;
				}
			}
			if(isdefined(level.var_zombie_custom_equipment_setup))
			{
				if(self [[level.var_zombie_custom_equipment_setup]](var_player))
				{
					continue;
				}
			}
			if(!namespace_zm_equipment::function_is_limited(self.var_stub.var_weaponName) || !namespace_zm_equipment::function_limited_in_use(self.var_stub.var_weaponName))
			{
				var_player namespace_zm_equipment::function_buy(self.var_stub.var_weaponName);
				var_player function_GiveWeapon(self.var_stub.var_weaponName);
				var_player namespace_zm_equipment::function_start_ammo(self.var_stub.var_weaponName);
				var_player notify(self.var_stub.var_weaponName.var_name + "_pickup_from_table");
				if(isdefined(level.var_zombie_include_craftables[self.var_stub.var_equipname].var_onBuyWeapon))
				{
					self [[level.var_zombie_include_craftables[self.var_stub.var_equipname].var_onBuyWeapon]](var_player);
				}
				else if(self.var_stub.var_weaponName != "keys_zm")
				{
					var_player function_SetActionSlot(1, "weapon", self.var_stub.var_weaponName);
				}
				if(isdefined(level.var_zombie_craftableStubs[self.var_stub.var_equipname].var_str_taken))
				{
					self.var_stub.var_hint_string = level.var_zombie_craftableStubs[self.var_stub.var_equipname].var_str_taken;
				}
				else
				{
					self.var_stub.var_hint_string = "";
				}
				self function_setHintString(self.var_stub.var_hint_string);
				var_player function_track_craftables_pickedup(self.var_stub.var_craftableSpawn);
			}
			else
			{
				self.var_stub.var_hint_string = "";
				self function_setHintString(self.var_stub.var_hint_string);
			}
		}
	}
}

/*
	Name: function_model_fly_away
	Namespace: namespace_zm_craftables
	Checksum: 0x424F4353
	Offset: 0x9500
	Size: 0x178
	Parameters: 1
	Flags: None
	Line Number: 3588
*/
function function_model_fly_away(var_unitrigger)
{
	self function_moveto(self.var_origin + VectorScale((0, 0, 1), 40), 3);
	var_direction = self.var_origin;
	var_direction = (var_direction[1], var_direction[0], 0);
	if(var_direction[1] < 0 || (var_direction[0] > 0 && var_direction[1] > 0))
	{
		var_direction = (var_direction[0], var_direction[1] * -1, 0);
	}
	else if(var_direction[0] < 0)
	{
		var_direction = (var_direction[0] * -1, var_direction[1], 0);
	}
	self function_vibrate(var_direction, 10, 0.5, 4);
	self waittill("hash_movedone");
	self function_ghost();
	function_playFX(level.var__effect["poltergeist"], self.var_origin);
}

/*
	Name: function_find_craftable_stub
	Namespace: namespace_zm_craftables
	Checksum: 0x424F4353
	Offset: 0x9680
	Size: 0xA0
	Parameters: 1
	Flags: None
	Line Number: 3617
*/
function function_find_craftable_stub(var_equipname)
{
	foreach(var_stub in level.var_a_uts_craftables)
	{
		if(var_stub.var_equipname == var_equipname)
		{
			return var_stub;
		}
	}
	return undefined;
}

/*
	Name: function_uncraft_craftable
	Namespace: namespace_zm_craftables
	Checksum: 0x424F4353
	Offset: 0x9728
	Size: 0x70
	Parameters: 4
	Flags: None
	Line Number: 3639
*/
function function_uncraft_craftable(var_equipname, var_return_pieces, var_origin, var_angles)
{
	var_stub = function_find_craftable_stub(var_equipname);
	function_stub_uncraft_craftable(var_stub, var_return_pieces, var_origin, var_angles);
}

/*
	Name: function_stub_uncraft_craftable
	Namespace: namespace_zm_craftables
	Checksum: 0x424F4353
	Offset: 0x97A0
	Size: 0x2D8
	Parameters: 5
	Flags: None
	Line Number: 3655
*/
function function_stub_uncraft_craftable(var_stub, var_return_pieces, var_origin, var_angles, var_use_random_start)
{
	if(isdefined(var_stub))
	{
		var_craftable = var_stub.var_craftableSpawn;
		var_craftable.var_crafted = 0;
		var_craftable.var_stub.var_crafted = 0;
		var_craftable notify("hash_uncrafted");
		level.var_craftables_crafted[var_craftable.var_craftable_name] = 0;
		level notify(var_craftable.var_craftable_name + "_uncrafted");
		for(var_i = 0; var_i < var_craftable.var_a_pieceSpawns.size; var_i++)
		{
			var_craftable.var_a_pieceSpawns[var_i].var_crafted = 0;
			if(isdefined(var_craftable.var_a_pieceSpawns[var_i].var_tag_name))
			{
				var_craftable.var_stub.var_model function_notsolid();
				if(!(isdefined(var_craftable.var_a_pieceSpawns[var_i].var_crafted) && var_craftable.var_a_pieceSpawns[var_i].var_crafted))
				{
					var_craftable.var_stub.var_model function_HidePart(var_craftable.var_a_pieceSpawns[var_i].var_tag_name);
				}
				else
				{
					var_craftable.var_stub.var_model function_show();
					var_craftable.var_stub.var_model function_ShowPart(var_craftable.var_a_pieceSpawns[var_i].var_tag_name);
				}
			}
			if(isdefined(var_return_pieces) && var_return_pieces)
			{
				var_craftable.var_a_pieceSpawns[var_i] function_piece_spawn_at(var_origin, var_angles, var_use_random_start);
			}
		}
		if(isdefined(var_craftable.var_stub.var_model))
		{
			var_craftable.var_stub.var_model function_ghost();
			return;
		}
	}
	ERROR: Exception occured: Stack empty.
}

/*
	Name: function_player_explode_craftable
	Namespace: namespace_zm_craftables
	Checksum: 0x424F4353
	Offset: 0x9A80
	Size: 0x388
	Parameters: 5
	Flags: None
	Line Number: 3705
*/
function function_player_explode_craftable(var_equipname, var_origin, var_speed, var_return_to_spawn, var_return_time)
{
	self function_ExplosionDamage(50, var_origin);
	var_stub = function_find_craftable_stub(var_equipname);
	if(isdefined(var_stub))
	{
		var_craftable = var_stub.var_craftableSpawn;
		var_craftable.var_crafted = 0;
		var_craftable.var_stub.var_crafted = 0;
		var_craftable notify("hash_uncrafted");
		level.var_craftables_crafted[var_craftable.var_craftable_name] = 0;
		level notify(var_craftable.var_craftable_name + "_uncrafted");
		for(var_i = 0; var_i < var_craftable.var_a_pieceSpawns.size; var_i++)
		{
			var_craftable.var_a_pieceSpawns[var_i].var_crafted = 0;
			if(isdefined(var_craftable.var_a_pieceSpawns[var_i].var_tag_name))
			{
				var_craftable.var_stub.var_model function_notsolid();
				if(!(isdefined(var_craftable.var_a_pieceSpawns[var_i].var_crafted) && var_craftable.var_a_pieceSpawns[var_i].var_crafted))
				{
					var_craftable.var_stub.var_model function_HidePart(var_craftable.var_a_pieceSpawns[var_i].var_tag_name);
				}
				else
				{
					var_craftable.var_stub.var_model function_show();
					var_craftable.var_stub.var_model function_ShowPart(var_craftable.var_a_pieceSpawns[var_i].var_tag_name);
				}
			}
			var_ang = function_RandomFloat(360);
			var_h = 0.25 + function_RandomFloat(0.5);
			var_dir = (function_sin(var_ang), function_cos(var_ang), var_h);
			self thread function_player_throw_piece(var_craftable.var_a_pieceSpawns[var_i], var_origin, var_speed * var_dir, var_return_to_spawn, var_return_time);
		}
		var_craftable.var_stub.var_model function_ghost();
	}
}

/*
	Name: function_think_craftables
	Namespace: namespace_zm_craftables
	Checksum: 0x424F4353
	Offset: 0x9E10
	Size: 0xA0
	Parameters: 0
	Flags: None
	Line Number: 3752
*/
function function_think_craftables()
{
	foreach(var_craftable in level.var_zombie_include_craftables)
	{
		if(isdefined(var_craftable.var_triggerThink))
		{
			var_craftable [[var_craftable.var_triggerThink]]();
		}
	}
	return;
	ERROR: Exception occured: Stack empty.
}

/*
	Name: function_openTableCraftable
	Namespace: namespace_zm_craftables
	Checksum: 0x424F4353
	Offset: 0x9EB8
	Size: 0x108
	Parameters: 0
	Flags: None
	Line Number: 3775
*/
function function_openTableCraftable()
{
	var_a_trigs = function_GetEntArray("open_craftable_trigger", "targetname");
	foreach(var_trig in var_a_trigs)
	{
		var_unitrigger_stub = function_setup_unitrigger_craftable_internal(var_trig, "open_table", "", "OPEN_CRAFTABLE", 1, 0);
		var_unitrigger_stub.var_require_look_at = 0;
		var_unitrigger_stub.var_require_look_toward = 1;
	}
}

/*
	Name: function_craftable_trigger_think
	Namespace: namespace_zm_craftables
	Checksum: 0x424F4353
	Offset: 0x9FC8
	Size: 0x60
	Parameters: 6
	Flags: None
	Line Number: 3796
*/
function function_craftable_trigger_think(var_trigger_targetname, var_equipname, var_weaponName, var_trigger_hintstring, var_DELETE_TRIGGER, var_Persistent)
{
	return function_setup_unitrigger_craftable(var_trigger_targetname, var_equipname, var_weaponName, var_trigger_hintstring, var_DELETE_TRIGGER, var_Persistent);
}

/*
	Name: function_craftable_trigger_think_array
	Namespace: namespace_zm_craftables
	Checksum: 0x424F4353
	Offset: 0xA030
	Size: 0x60
	Parameters: 6
	Flags: None
	Line Number: 3811
*/
function function_craftable_trigger_think_array(var_trigger_targetname, var_equipname, var_weaponName, var_trigger_hintstring, var_DELETE_TRIGGER, var_Persistent)
{
	return function_setup_unitrigger_craftable_array(var_trigger_targetname, var_equipname, var_weaponName, var_trigger_hintstring, var_DELETE_TRIGGER, var_Persistent);
}

/*
	Name: function_setup_vehicle_unitrigger_craftable
	Namespace: namespace_zm_craftables
	Checksum: 0x424F4353
	Offset: 0xA098
	Size: 0x5B0
	Parameters: 7
	Flags: None
	Line Number: 3826
*/
function function_setup_vehicle_unitrigger_craftable(var_parent, var_trigger_targetname, var_equipname, var_weaponName, var_trigger_hintstring, var_DELETE_TRIGGER, var_Persistent)
{
	var_trig = function_GetEnt(var_trigger_targetname, "targetname");
	if(!isdefined(var_trig))
	{
		return;
	}
	var_unitrigger_stub = function_spawnstruct();
	var_unitrigger_stub.var_craftableStub = level.var_zombie_include_craftables[var_equipname];
	var_unitrigger_stub.var_link_parent = var_parent;
	var_unitrigger_stub.var_origin_parent = var_trig;
	var_unitrigger_stub.var_trigger_targetname = var_trigger_targetname;
	var_unitrigger_stub.var_originFunc = &function_anystub_get_unitrigger_origin;
	var_unitrigger_stub.var_onSpawnFunc = &function_anystub_on_spawn_trigger;
	var_unitrigger_stub.var_origin = var_trig.var_origin;
	var_unitrigger_stub.var_angles = var_trig.var_angles;
	var_unitrigger_stub.var_equipname = var_equipname;
	var_unitrigger_stub.var_weaponName = var_weaponName;
	var_unitrigger_stub.var_trigger_hintstring = var_trigger_hintstring;
	var_unitrigger_stub.var_DELETE_TRIGGER = var_DELETE_TRIGGER;
	var_unitrigger_stub.var_crafted = 0;
	var_unitrigger_stub.var_Persistent = var_Persistent;
	var_unitrigger_stub.var_useTime = function_Int(3000);
	var_unitrigger_stub.var_onBeginUse = &function_onBeginUseUTS;
	var_unitrigger_stub.var_onEndUse = &function_onEndUseUTS;
	var_unitrigger_stub.var_onUse = &function_onUsePlantObjectUTS;
	var_unitrigger_stub.var_onCantUse = &function_onCantUseUTS;
	var_tmins = var_trig function_GetMins();
	var_tmaxs = var_trig function_GetMaxs();
	var_tsize = var_tmaxs - var_tmins;
	if(isdefined(var_trig.var_script_length))
	{
		var_unitrigger_stub.var_script_length = var_trig.var_script_length;
	}
	else
	{
		var_unitrigger_stub.var_script_length = var_tsize[1];
	}
	if(isdefined(var_trig.var_script_width))
	{
		var_unitrigger_stub.var_script_width = var_trig.var_script_width;
	}
	else
	{
		var_unitrigger_stub.var_script_width = var_tsize[0];
	}
	if(isdefined(var_trig.var_script_height))
	{
		var_unitrigger_stub.var_script_height = var_trig.var_script_height;
	}
	else
	{
		var_unitrigger_stub.var_script_height = var_tsize[2];
	}
	if(isdefined(var_trig.var_radius))
	{
		var_unitrigger_stub.var_radius = var_trig.var_radius;
	}
	else
	{
		var_unitrigger_stub.var_radius = 64;
	}
	var_unitrigger_stub.var_target = var_trig.var_target;
	var_unitrigger_stub.var_targetname = var_trig.var_targetname + "_trigger";
	var_unitrigger_stub.var_script_noteworthy = var_trig.var_script_noteworthy;
	var_unitrigger_stub.var_script_parameters = var_trig.var_script_parameters;
	var_unitrigger_stub.var_cursor_hint = "HINT_NOICON";
	if(isdefined(level.var_zombie_craftableStubs[var_equipname].var_str_to_craft))
	{
		var_unitrigger_stub.var_hint_string = level.var_zombie_craftableStubs[var_equipname].var_str_to_craft;
	}
	var_unitrigger_stub.var_script_unitrigger_type = "unitrigger_radius_use";
	var_unitrigger_stub.var_require_look_at = 1;
	namespace_zm_unitrigger::function_unitrigger_force_per_player_triggers(var_unitrigger_stub, 1);
	var_unitrigger_stub.var_prompt_and_visibility_func = &function_craftabletrigger_update_prompt;
	namespace_zm_unitrigger::function_register_unitrigger(var_unitrigger_stub, &function_craftable_place_think);
	var_unitrigger_stub.var_piece_trigger = var_trig;
	var_trig.var_trigger_stub = var_unitrigger_stub;
	var_unitrigger_stub.var_craftableSpawn = var_unitrigger_stub function_craftable_piece_unitriggers(var_equipname, var_unitrigger_stub.var_origin);
	if(var_DELETE_TRIGGER)
	{
		var_trig function_delete();
	}
	level.var_a_uts_craftables[level.var_a_uts_craftables.size] = var_unitrigger_stub;
	return var_unitrigger_stub;
	ERROR: Exception occured: Stack empty.
}

/*
	Name: function_vehicle_craftable_trigger_think
	Namespace: namespace_zm_craftables
	Checksum: 0x424F4353
	Offset: 0xA650
	Size: 0x70
	Parameters: 7
	Flags: None
	Line Number: 3924
*/
function function_vehicle_craftable_trigger_think(var_vehicle, var_trigger_targetname, var_equipname, var_weaponName, var_trigger_hintstring, var_DELETE_TRIGGER, var_Persistent)
{
	return function_setup_vehicle_unitrigger_craftable(var_vehicle, var_trigger_targetname, var_equipname, var_weaponName, var_trigger_hintstring, var_DELETE_TRIGGER, var_Persistent);
}

/*
	Name: function_onPickupUTS
	Namespace: namespace_zm_craftables
	Checksum: 0x424F4353
	Offset: 0xA6C8
	Size: 0x10
	Parameters: 1
	Flags: None
	Line Number: 3939
*/
function function_onPickupUTS(var_player)
{
	return;
	ERROR: Exception occured: Stack empty.
}

/*
	Name: function_onDropUTS
	Namespace: namespace_zm_craftables
	Checksum: 0x424F4353
	Offset: 0xA6E0
	Size: 0x20
	Parameters: 1
	Flags: None
	Line Number: 3955
*/
function function_onDropUTS(var_player)
{
	var_player notify("hash_event_ended");
}

/*
	Name: function_onBeginUseUTS
	Namespace: namespace_zm_craftables
	Checksum: 0x424F4353
	Offset: 0xA708
	Size: 0xB8
	Parameters: 1
	Flags: None
	Line Number: 3970
*/
function function_onBeginUseUTS(var_player)
{
	if(isdefined(self.var_craftableStub.var_onBeginUse))
	{
		self [[self.var_craftableStub.var_onBeginUse]](var_player);
	}
	if(isdefined(var_player) && !isdefined(var_player.var_craftableAudio))
	{
		var_player.var_craftableAudio = function_spawn("script_origin", var_player.var_origin);
		var_player.var_craftableAudio function_PlayLoopSound("zmb_craftable_loop");
	}
}

/*
	Name: function_onEndUseUTS
	Namespace: namespace_zm_craftables
	Checksum: 0x424F4353
	Offset: 0xA7C8
	Size: 0xB8
	Parameters: 3
	Flags: None
	Line Number: 3993
*/
function function_onEndUseUTS(var_team, var_player, var_result)
{
	if(!isdefined(var_player))
	{
		return;
	}
	if(isdefined(var_player.var_craftableAudio))
	{
		var_player.var_craftableAudio function_delete();
		var_player.var_craftableAudio = undefined;
	}
	if(isdefined(self.var_craftableStub.var_onEndUse))
	{
		self [[self.var_craftableStub.var_onEndUse]](var_team, var_player, var_result);
	}
	var_player notify("hash_event_ended");
	return;
	ERROR: Exception occured: Stack empty.
}

/*
	Name: function_onCantUseUTS
	Namespace: namespace_zm_craftables
	Checksum: 0x424F4353
	Offset: 0xA888
	Size: 0x40
	Parameters: 1
	Flags: None
	Line Number: 4023
*/
function function_onCantUseUTS(var_player)
{
	if(isdefined(self.var_craftableStub.var_onCantUse))
	{
		self [[self.var_craftableStub.var_onCantUse]](var_player);
	}
}

/*
	Name: function_onUsePlantObjectUTS
	Namespace: namespace_zm_craftables
	Checksum: 0x424F4353
	Offset: 0xA8D0
	Size: 0x50
	Parameters: 1
	Flags: None
	Line Number: 4041
*/
function function_onUsePlantObjectUTS(var_player)
{
	if(isdefined(self.var_craftableStub.var_onUsePlantObject))
	{
		self [[self.var_craftableStub.var_onUsePlantObject]](var_player);
	}
	var_player notify("hash_bomb_planted");
}

/*
	Name: function_is_craftable
	Namespace: namespace_zm_craftables
	Checksum: 0x424F4353
	Offset: 0xA928
	Size: 0x98
	Parameters: 0
	Flags: None
	Line Number: 4060
*/
function function_is_craftable()
{
	if(!isdefined(level.var_zombie_craftableStubs))
	{
		return 0;
	}
	if(isdefined(self.var_zombie_weapon_upgrade) && isdefined(level.var_zombie_craftableStubs[self.var_zombie_weapon_upgrade]))
	{
		return 1;
	}
	if(isdefined(self.var_script_noteworthy) && self.var_script_noteworthy == "specialty_weapupgrade")
	{
		if(isdefined(level.var_craftables_crafted["pap"]) && level.var_craftables_crafted["pap"])
		{
			return 0;
		}
		return 1;
	}
	return 0;
}

/*
	Name: function_craftable_crafted
	Namespace: namespace_zm_craftables
	Checksum: 0x424F4353
	Offset: 0xA9C8
	Size: 0x10
	Parameters: 0
	Flags: None
	Line Number: 4091
*/
function function_craftable_crafted()
{
	self.var_a_pieceSpawns--;
}

/*
	Name: function_craftable_complete
	Namespace: namespace_zm_craftables
	Checksum: 0x424F4353
	Offset: 0xA9E0
	Size: 0x20
	Parameters: 0
	Flags: None
	Line Number: 4106
*/
function function_craftable_complete()
{
	if(self.var_a_pieceSpawns <= 0)
	{
		return 1;
	}
	return 0;
}

/*
	Name: function_get_craftable_hint
	Namespace: namespace_zm_craftables
	Checksum: 0x424F4353
	Offset: 0xAA08
	Size: 0x58
	Parameters: 1
	Flags: None
	Line Number: 4125
*/
function function_get_craftable_hint(var_craftable_name)
{
	/#
		namespace_::function_Assert(isdefined(level.var_zombie_craftableStubs[var_craftable_name]), var_craftable_name + "Dev Block strings are not supported");
	#/
	return level.var_zombie_craftableStubs[var_craftable_name].var_str_to_craft;
}

/*
	Name: function_delete_on_disconnect
	Namespace: namespace_zm_craftables
	Checksum: 0x424F4353
	Offset: 0xAA68
	Size: 0xC0
	Parameters: 3
	Flags: None
	Line Number: 4143
*/
function function_delete_on_disconnect(var_craftable, var_self_notify, var_skip_delete)
{
	var_craftable endon("hash_death");
	self waittill("hash_disconnect");
	if(isdefined(var_self_notify))
	{
		self notify(var_self_notify);
	}
	if(!(isdefined(var_skip_delete) && var_skip_delete))
	{
		if(isdefined(var_craftable.var_stub))
		{
			thread namespace_zm_unitrigger::function_unregister_unitrigger(var_craftable.var_stub);
			var_craftable.var_stub = undefined;
		}
		if(isdefined(var_craftable))
		{
			var_craftable function_delete();
			return;
		}
	}
	ERROR: Exception occured: Stack empty.
	waittillframeend;
}

/*
	Name: function_is_holding_part
	Namespace: namespace_zm_craftables
	Checksum: 0x424F4353
	Offset: 0xAB30
	Size: 0x1F8
	Parameters: 3
	Flags: None
	Line Number: 4178
*/
function function_is_holding_part(var_craftable_name, var_piece_name, var_slot)
{
	if(!isdefined(var_slot))
	{
		var_slot = 0;
	}
	if(isdefined(self.var_current_craftable_pieces) && isdefined(self.var_current_craftable_pieces[var_slot]))
	{
		if(self.var_current_craftable_pieces[var_slot].var_craftablename == var_craftable_name && self.var_current_craftable_pieces[var_slot].var_modelName == var_piece_name)
		{
			return 1;
		}
	}
	if(isdefined(level.var_a_uts_craftables))
	{
		foreach(var_craftable_stub in level.var_a_uts_craftables)
		{
			if(var_craftable_stub.var_craftableStub.var_name == var_craftable_name)
			{
				foreach(var_piece in var_craftable_stub.var_craftableSpawn.var_a_pieceSpawns)
				{
					if(var_piece.var_pieceName == var_piece_name)
					{
						if(isdefined(var_piece.var_in_shared_inventory) && var_piece.var_in_shared_inventory)
						{
							return 1;
						}
					}
				}
			}
		}
	}
	return 0;
}

/*
	Name: function_is_part_crafted
	Namespace: namespace_zm_craftables
	Checksum: 0x424F4353
	Offset: 0xAD30
	Size: 0x1A0
	Parameters: 2
	Flags: None
	Line Number: 4223
*/
function function_is_part_crafted(var_craftable_name, var_piece_name)
{
	if(isdefined(level.var_a_uts_craftables))
	{
		foreach(var_craftable_stub in level.var_a_uts_craftables)
		{
			if(var_craftable_stub.var_craftableStub.var_name == var_craftable_name)
			{
				if(isdefined(var_craftable_stub.var_crafted) && var_craftable_stub.var_crafted)
				{
					return 1;
				}
				foreach(var_piece in var_craftable_stub.var_craftableSpawn.var_a_pieceSpawns)
				{
					if(var_piece.var_pieceName == var_piece_name)
					{
						if(isdefined(var_piece.var_crafted) && var_piece.var_crafted)
						{
							return 1;
						}
					}
				}
			}
		}
	}
	return 0;
}

/*
	Name: function_track_craftable_piece_pickedup
	Namespace: namespace_zm_craftables
	Checksum: 0x424F4353
	Offset: 0xAED8
	Size: 0x210
	Parameters: 1
	Flags: None
	Line Number: 4261
*/
function function_track_craftable_piece_pickedup(var_piece)
{
	if(!isdefined(var_piece) || !isdefined(var_piece.var_craftablename))
	{
		return;
	}
	self function_add_map_craftable_stat(var_piece.var_craftablename, "pieces_pickedup", 1);
	if(isdefined(var_piece.var_pieceStub) && isdefined(var_piece.var_pieceStub.var_hash_id))
	{
		self function_RecordMapEvent(13, GetTime(), self.var_origin, level.var_round_number, var_piece.var_pieceStub.var_hash_id);
	}
	if(isdefined(var_piece.var_pieceStub.var_vox_id))
	{
		if(isdefined(var_piece.var_pieceStub.var_b_one_time_vo) && var_piece.var_pieceStub.var_b_one_time_vo)
		{
			if(!isdefined(self.var_a_one_time_piece_pickup_vo))
			{
				self.var_a_one_time_piece_pickup_vo = [];
			}
			if(isdefined(self.var_dontspeak) && self.var_dontspeak)
			{
				return;
			}
			if(function_IsInArray(self.var_a_one_time_piece_pickup_vo, var_piece.var_pieceStub.var_vox_id))
			{
				return;
			}
			self.var_a_one_time_piece_pickup_vo[self.var_a_one_time_piece_pickup_vo.size] = var_piece.var_pieceStub.var_vox_id;
		}
		self thread namespace_zm_utility::function_do_player_general_vox("general", var_piece.var_pieceStub.var_vox_id + "_pickup");
	}
	else
	{
		self thread namespace_zm_utility::function_do_player_general_vox("general", "build_pickup");
		return;
	}
	ERROR: Bad function call
}

/*
	Name: function_track_craftable_pieces_crafted
	Namespace: namespace_zm_craftables
	Checksum: 0x424F4353
	Offset: 0xB0F0
	Size: 0xF0
	Parameters: 1
	Flags: None
	Line Number: 4310
*/
function function_track_craftable_pieces_crafted(var_craftable)
{
	if(!isdefined(var_craftable) || !isdefined(var_craftable.var_craftable_name))
	{
		return;
	}
	var_bname = var_craftable.var_craftable_name;
	if(isdefined(var_craftable.var_stat_name))
	{
		var_bname = var_craftable.var_stat_name;
	}
	self function_add_map_craftable_stat(var_bname, "pieces_built", 1);
	if(!var_craftable function_craftable_all_crafted())
	{
		self thread namespace_zm_utility::function_do_player_general_vox("general", "build_add");
	}
	level notify(var_bname + "_crafted", self);
}

/*
	Name: function_track_craftables_crafted
	Namespace: namespace_zm_craftables
	Checksum: 0x424F4353
	Offset: 0xB1E8
	Size: 0x270
	Parameters: 1
	Flags: None
	Line Number: 4339
*/
function function_track_craftables_crafted(var_craftable)
{
	if(!isdefined(var_craftable) || !isdefined(var_craftable.var_craftable_name))
	{
		return;
	}
	var_bname = var_craftable.var_craftable_name;
	if(isdefined(var_craftable.var_stat_name))
	{
		var_bname = var_craftable.var_stat_name;
	}
	self function_add_map_craftable_stat(var_bname, "buildable_built", 1);
	self namespace_zm_stats::function_increment_client_stat("buildables_built", 0);
	self namespace_zm_stats::function_increment_player_stat("buildables_built");
	if(isdefined(var_craftable.var_stub) && isdefined(var_craftable.var_stub.var_craftableStub) && isdefined(var_craftable.var_stub.var_craftableStub.var_hash_id))
	{
		self function_RecordMapEvent(14, GetTime(), self.var_origin, level.var_round_number, var_craftable.var_stub.var_craftableStub.var_hash_id);
	}
	if(!isdefined(var_craftable.var_stub.var_craftableStub.var_no_challenge_stat) || var_craftable.var_stub.var_craftableStub.var_no_challenge_stat == 0)
	{
		self namespace_zm_stats::function_increment_challenge_stat("SURVIVALIST_CRAFTABLE");
	}
	if(isdefined(var_craftable.var_stub.var_craftableStub.var_vox_id))
	{
		if(isdefined(level.var_zombie_custom_craftable_built_vo))
		{
			self thread [[level.var_zombie_custom_craftable_built_vo]](var_craftable.var_stub);
		}
		self thread namespace_zm_utility::function_do_player_general_vox("general", var_craftable.var_stub.var_craftableStub.var_vox_id + "_final");
	}
}

/*
	Name: function_track_craftables_pickedup
	Namespace: namespace_zm_craftables
	Checksum: 0x424F4353
	Offset: 0xB460
	Size: 0x190
	Parameters: 1
	Flags: None
	Line Number: 4381
*/
function function_track_craftables_pickedup(var_craftable)
{
	if(!isdefined(var_craftable))
	{
		return;
	}
	var_stat_name = function_get_craftable_stat_name(var_craftable.var_craftable_name);
	if(isdefined(var_craftable.var_stub) && isdefined(var_craftable.var_stub.var_craftableStub) && isdefined(var_craftable.var_stub.var_craftableStub.var_hash_id))
	{
		self function_RecordMapEvent(16, GetTime(), self.var_origin, level.var_round_number, var_craftable.var_stub.var_craftableStub.var_hash_id);
	}
	if(!isdefined(var_stat_name))
	{
		return;
	}
	self function_add_map_craftable_stat(var_stat_name, "buildable_pickedup", 1);
	if(isdefined(var_craftable.var_stub.var_craftableStub.var_vox_id))
	{
		self thread namespace_zm_utility::function_do_player_general_vox("general", var_craftable.var_stub.var_craftableStub.var_vox_id + "_plc");
	}
	self function_say_pickup_craftable_vo(var_craftable, 0);
}

/*
	Name: function_track_craftables_planted
	Namespace: namespace_zm_craftables
	Checksum: 0x424F4353
	Offset: 0xB5F8
	Size: 0x150
	Parameters: 1
	Flags: None
	Line Number: 4414
*/
function function_track_craftables_planted(var_equipment)
{
	if(!isdefined(var_equipment))
	{
		return;
	}
	var_craftable_name = undefined;
	if(isdefined(var_equipment.var_name))
	{
		var_craftable_name = function_get_craftable_stat_name(var_equipment.var_name);
	}
	if(!isdefined(var_craftable_name))
	{
		return;
	}
	namespace_demo::function_bookmark("zm_player_buildable_placed", GetTime(), self);
	self function_add_map_craftable_stat(var_craftable_name, "buildable_placed", 1);
	if(isdefined(var_equipment.var_stub) && isdefined(var_equipment.var_stub.var_craftableStub) && isdefined(var_equipment.var_stub.var_craftableStub.var_hash_id))
	{
		self function_RecordMapEvent(15, GetTime(), self.var_origin, level.var_round_number, var_equipment.var_stub.var_craftableStub.var_hash_id);
	}
}

/*
	Name: function_placed_craftable_vo_timer
	Namespace: namespace_zm_craftables
	Checksum: 0x424F4353
	Offset: 0xB750
	Size: 0x30
	Parameters: 0
	Flags: None
	Line Number: 4447
*/
function function_placed_craftable_vo_timer()
{
	self endon("hash_disconnect");
	self.var_craftable_timer = 1;
	wait(60);
	self.var_craftable_timer = 0;
}

/*
	Name: function_craftable_pickedup_timer
	Namespace: namespace_zm_craftables
	Checksum: 0x424F4353
	Offset: 0xB788
	Size: 0x30
	Parameters: 0
	Flags: None
	Line Number: 4465
*/
function function_craftable_pickedup_timer()
{
	self endon("hash_disconnect");
	self.var_craftable_pickedup_timer = 1;
	wait(60);
	self.var_craftable_pickedup_timer = 0;
}

/*
	Name: function_track_planted_craftables_pickedup
	Namespace: namespace_zm_craftables
	Checksum: 0x424F4353
	Offset: 0xB7C0
	Size: 0x100
	Parameters: 1
	Flags: None
	Line Number: 4483
*/
function function_track_planted_craftables_pickedup(var_equipment)
{
	if(!isdefined(var_equipment))
	{
		return;
	}
	if(var_equipment == "equip_turbine_zm" || var_equipment == "equip_turret_zm" || var_equipment == "equip_electrictrap_zm" || var_equipment == "riotshield_zm" || var_equipment == "alcatraz_shield_zm" || var_equipment == "tomb_shield_zm")
	{
		self namespace_zm_stats::function_increment_client_stat("planted_buildables_pickedup", 0);
		self namespace_zm_stats::function_increment_player_stat("planted_buildables_pickedup");
	}
	if(!(isdefined(self.var_craftable_pickedup_timer) && self.var_craftable_pickedup_timer))
	{
		self function_say_pickup_craftable_vo(var_equipment, 1);
		self thread function_craftable_pickedup_timer();
		return;
	}
	ERROR: Exception occured: Stack empty.
}

/*
	Name: function_track_placed_craftables
	Namespace: namespace_zm_craftables
	Checksum: 0x424F4353
	Offset: 0xB8C8
	Size: 0x98
	Parameters: 1
	Flags: None
	Line Number: 4513
*/
function function_track_placed_craftables(var_craftable_name)
{
	if(!isdefined(var_craftable_name))
	{
		return;
	}
	self function_add_map_craftable_stat(var_craftable_name, "buildable_placed", 1);
	var_vo_name = undefined;
	if(var_craftable_name == level.var_riotshield_name)
	{
		var_vo_name = "craft_plc_shield";
	}
	if(!isdefined(var_vo_name))
	{
		return;
	}
	self thread namespace_zm_utility::function_do_player_general_vox("general", var_vo_name);
}

/*
	Name: function_zombie_craftable_set_record_stats
	Namespace: namespace_zm_craftables
	Checksum: 0x424F4353
	Offset: 0xB968
	Size: 0x40
	Parameters: 2
	Flags: None
	Line Number: 4542
*/
function function_zombie_craftable_set_record_stats(var_str_craftable, var_b_record)
{
	if(!isdefined(level.var_craftables_stats_recorded))
	{
		level.var_craftables_stats_recorded = [];
	}
	level.var_craftables_stats_recorded[var_str_craftable] = var_b_record;
	return;
}

/*
	Name: function_add_map_craftable_stat
	Namespace: namespace_zm_craftables
	Checksum: 0x424F4353
	Offset: 0xB9B0
	Size: 0xE8
	Parameters: 3
	Flags: None
	Line Number: 4562
*/
function function_add_map_craftable_stat(var_piece_name, var_stat_name, var_value)
{
	if(!isdefined(var_piece_name) || var_piece_name == "sq_common" || var_piece_name == "keys_zm")
	{
		return;
	}
	if(isdefined(level.var_zm_disable_recording_stats) && level.var_zm_disable_recording_stats || (isdefined(level.var_zm_disable_recording_buildable_stats) && level.var_zm_disable_recording_buildable_stats))
	{
		return;
	}
	if(!isdefined(level.var_craftables_stats_recorded))
	{
		level.var_craftables_stats_recorded = [];
	}
	if(!(isdefined(level.var_craftables_stats_recorded[var_piece_name]) && level.var_craftables_stats_recorded[var_piece_name]))
	{
		return;
	}
	self function_AddDStat("buildables", var_piece_name, var_stat_name, var_value);
	return;
	.var_0 = undefined;
}

/*
	Name: function_say_pickup_craftable_vo
	Namespace: namespace_zm_craftables
	Checksum: 0x424F4353
	Offset: 0xBAA0
	Size: 0x18
	Parameters: 2
	Flags: None
	Line Number: 4595
*/
function function_say_pickup_craftable_vo(var_craftable_name, var_b_world)
{
}

/*
	Name: function_get_craftable_vo_name
	Namespace: namespace_zm_craftables
	Checksum: 0x424F4353
	Offset: 0xBAC0
	Size: 0x10
	Parameters: 1
	Flags: None
	Line Number: 4609
*/
function function_get_craftable_vo_name(var_craftable_name)
{
}

/*
	Name: function_get_craftable_stat_name
	Namespace: namespace_zm_craftables
	Checksum: 0x424F4353
	Offset: 0xBAD8
	Size: 0x90
	Parameters: 1
	Flags: None
	Line Number: 4623
*/
function function_get_craftable_stat_name(var_craftable_name)
{
	if(isdefined(var_craftable_name))
	{
		switch(var_craftable_name)
		{
			case "equip_riotshield_zm":
			{
				return "riotshield_zm";
			}
			case "equip_turbine_zm":
			{
				return "turbine";
			}
			case "equip_turret_zm":
			{
				return "turret";
			}
			case "equip_electrictrap_zm":
			{
				return "electric_trap";
			}
			case "equip_springpad_zm":
			{
				return "springpad_zm";
			}
			case "equip_slipgun_zm":
			{
				return "slipgun_zm";
			}
		}
	}
	return var_craftable_name;
}

/*
	Name: function_get_craftable_model
	Namespace: namespace_zm_craftables
	Checksum: 0x424F4353
	Offset: 0xBB70
	Size: 0xC8
	Parameters: 1
	Flags: None
	Line Number: 4668
*/
function function_get_craftable_model(var_str_craftable)
{
	foreach(var_uts_craftable in level.var_a_uts_craftables)
	{
		if(var_uts_craftable.var_craftableStub.var_name == var_str_craftable)
		{
			if(isdefined(var_uts_craftable.var_model))
			{
				return var_uts_craftable.var_model;
				break;
			}
		}
	}
	return undefined;
}

/*
	Name: function_get_craftable_piece
	Namespace: namespace_zm_craftables
	Checksum: 0x424F4353
	Offset: 0xBC40
	Size: 0x148
	Parameters: 2
	Flags: None
	Line Number: 4694
*/
function function_get_craftable_piece(var_str_craftable, var_str_piece)
{
	foreach(var_uts_craftable in level.var_a_uts_craftables)
	{
		if(var_uts_craftable.var_craftableStub.var_name == var_str_craftable)
		{
			foreach(var_pieceSpawn in var_uts_craftable.var_craftableSpawn.var_a_pieceSpawns)
			{
				if(var_pieceSpawn.var_pieceName == var_str_piece)
				{
					return var_pieceSpawn;
				}
			}
			break;
		}
	}
	return undefined;
}

/*
	Name: function_player_get_craftable_piece
	Namespace: namespace_zm_craftables
	Checksum: 0x424F4353
	Offset: 0xBD90
	Size: 0x60
	Parameters: 2
	Flags: None
	Line Number: 4723
*/
function function_player_get_craftable_piece(var_str_craftable, var_str_piece)
{
	var_pieceSpawn = function_get_craftable_piece(var_str_craftable, var_str_piece);
	if(isdefined(var_pieceSpawn))
	{
		self function_player_take_piece(var_pieceSpawn);
		return;
	}
	ERROR: Exception occured: Stack empty.
}

/*
	Name: function_player_remove_craftable_piece
	Namespace: namespace_zm_craftables
	Checksum: 0x424F4353
	Offset: 0xBDF8
	Size: 0x60
	Parameters: 2
	Flags: None
	Line Number: 4744
*/
function function_player_remove_craftable_piece(var_str_craftable, var_str_piece)
{
	var_pieceSpawn = function_get_craftable_piece(var_str_craftable, var_str_piece);
	if(isdefined(var_pieceSpawn))
	{
		self function_player_remove_piece(var_pieceSpawn);
		return;
	}
}

/*
	Name: function_player_remove_piece
	Namespace: namespace_zm_craftables
	Checksum: 0x424F4353
	Offset: 0xBE60
	Size: 0x118
	Parameters: 1
	Flags: None
	Line Number: 4764
*/
function function_player_remove_piece(var_piece_to_remove)
{
	if(!isdefined(self.var_current_craftable_pieces))
	{
		self.var_current_craftable_pieces = [];
	}
	foreach(var_self_piece in self.var_current_craftable_pieces)
	{
		if(var_piece_to_remove.var_pieceName === var_self_piece.var_pieceName && var_piece_to_remove.var_craftablename === var_self_piece.var_craftablename)
		{
			self namespace_clientfield::function_set_to_player("craftable", 0);
			self.var_current_craftable_pieces[var_slot] = undefined;
			self notify("craftable_piece_released" + var_slot);
		}
	}
}

/*
	Name: function_get_craftable_piece_model
	Namespace: namespace_zm_craftables
	Checksum: 0x424F4353
	Offset: 0xBF80
	Size: 0x168
	Parameters: 2
	Flags: None
	Line Number: 4791
*/
function function_get_craftable_piece_model(var_str_craftable, var_str_piece)
{
	foreach(var_uts_craftable in level.var_a_uts_craftables)
	{
		if(var_uts_craftable.var_craftableStub.var_name == var_str_craftable)
		{
			foreach(var_pieceSpawn in var_uts_craftable.var_craftableSpawn.var_a_pieceSpawns)
			{
				if(var_pieceSpawn.var_pieceName == var_str_piece && isdefined(var_pieceSpawn.var_model))
				{
					return var_pieceSpawn.var_model;
				}
			}
			break;
		}
	}
	return undefined;
	ERROR: Exception occured: Stack empty.
}

/*
	Name: function_player_show_craftable_parts_ui
	Namespace: namespace_zm_craftables
	Checksum: 0x424F4353
	Offset: 0xC0F0
	Size: 0xA8
	Parameters: 3
	Flags: None
	Line Number: 4821
*/
function function_player_show_craftable_parts_ui(var_str_crafted_clientuimodel, var_str_widget_clientuimodel, var_b_is_crafted)
{
	self notify("hash_player_show_craftable_parts_ui");
	self endon("hash_player_show_craftable_parts_ui");
	if(var_b_is_crafted)
	{
		if(isdefined(var_str_crafted_clientuimodel))
		{
			self thread namespace_clientfield::function_set_player_uimodel(var_str_crafted_clientuimodel, 1);
		}
		var_n_show_ui_duration = 3.5;
	}
	else
	{
		var_n_show_ui_duration = 3.5;
	}
	self thread function_player_hide_craftable_parts_ui_after_duration(var_str_widget_clientuimodel, var_n_show_ui_duration);
}

/*
	Name: function_player_hide_craftable_parts_ui_after_duration
	Namespace: namespace_zm_craftables
	Checksum: 0x424F4353
	Offset: 0xC1A0
	Size: 0x5C
	Parameters: 2
	Flags: None
	Line Number: 4850
*/
function function_player_hide_craftable_parts_ui_after_duration(var_str_widget_clientuimodel, var_n_show_ui_duration)
{
	self endon("hash_disconnect");
	self thread namespace_clientfield::function_set_player_uimodel(var_str_widget_clientuimodel, 1);
	wait(var_n_show_ui_duration);
	self thread namespace_clientfield::function_set_player_uimodel(var_str_widget_clientuimodel, 0);
}

