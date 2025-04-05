#include scripts\codescripts\struct;
#include scripts\shared\aat_shared;
#include scripts\shared\ai\zombie_utility;
#include scripts\shared\array_shared;
#include scripts\shared\callbacks_shared;
#include scripts\shared\clientfield_shared;
#include scripts\shared\exploder_shared;
#include scripts\shared\flag_shared;
#include scripts\shared\gameobjects_shared;
#include scripts\shared\laststand_shared;
#include scripts\shared\lui_shared;
#include scripts\shared\math_shared;
#include scripts\shared\objpoints_shared;
#include scripts\shared\scene_shared;
#include scripts\shared\spawner_shared;
#include scripts\shared\system_shared;
#include scripts\shared\util_shared;
#include scripts\sphynx\leveling\_zm_sphynx_leveling;
#include scripts\zm\_zm;
#include scripts\zm\_zm_audio;
#include scripts\zm\_zm_equipment;
#include scripts\zm\_zm_spawner;
#include scripts\zm\_zm_utility;
#include scripts\zm\_zm_weapon_upgrade_system;
#include scripts\zm\_zm_weapons;
#include scripts\zm\_zm_zonemgr;

#namespace namespace_456c991e;

/*
	Name: function___init__sytem__
	Namespace: namespace_456c991e
	Checksum: 0x424F4353
	Offset: 0xC30
	Size: 0x40
	Parameters: 0
	Flags: AutoExec
	Line Number: 39
*/
function autoexec function___init__sytem__()
{
	namespace_system::function_register("zm_zombies_ultimate_hud", &function___init__, &function___main__, undefined);
	return;
}

/*
	Name: function___init__
	Namespace: namespace_456c991e
	Checksum: 0x424F4353
	Offset: 0xC78
	Size: 0xE0
	Parameters: 0
	Flags: None
	Line Number: 55
*/
function function___init__()
{
	namespace_clientfield::function_register("clientuimodel", "ZMBU.MuleKick", 1, 1, "int");
	namespace_clientfield::function_register("clientuimodel", "ZMBU.rage_inducer", 1, 1, "int");
	namespace_clientfield::function_register("clientuimodel", "ZMBU.WeaponPapLevel", 1, 4, "int");
	level.var__supress_survived_screen = 1;
	namespace_callback::function_on_connect(&function_d7c1ad11);
	level thread function_cea699de();
	return;
	ERROR: Exception occured: Stack empty.
}

/*
	Name: function___main__
	Namespace: namespace_456c991e
	Checksum: 0x424F4353
	Offset: 0xD60
	Size: 0x238
	Parameters: 0
	Flags: None
	Line Number: 77
*/
function function___main__()
{
	namespace_callback::function_on_spawned(&function_28217684);
	namespace_callback::function_on_connect(&function_18672742);
	namespace_callback::function_on_spawned(&function_4659d62);
	namespace_callback::function_on_spawned(&function_a6f1e7f0);
	namespace_callback::function_on_spawned(&function_68ebef1d);
	namespace_callback::function_on_spawned(&function_e891e4f9);
	namespace_callback::function_on_spawned(&function_87306f09);
	level thread function_f0b6e8de();
	namespace_Array::function_run_all(function_8a06a11d(), &namespace_spawner::function_add_spawn_function, &function_5ecedc28);
	namespace_Array::function_run_all(function_GetSpawnerArray(), &namespace_spawner::function_add_spawn_function, &function_5ecedc28);
	namespace_Array::function_run_all(function_GetVehicleArray(), &namespace_spawner::function_add_spawn_function, &function_5ecedc28);
	level thread function_4f649f2e();
	namespace_zm_spawner::function_register_zombie_damage_callback(&function_79ffdd89);
	namespace_zm::function_register_vehicle_damage_callback(&function_79ffdd89);
	namespace_callback::function_on_connect(&function_on_player_connect);
}

/*
	Name: function_f0b6e8de
	Namespace: namespace_456c991e
	Checksum: 0x424F4353
	Offset: 0xFA0
	Size: 0x130
	Parameters: 0
	Flags: None
	Line Number: 106
*/
function function_f0b6e8de()
{
	var_a_colors = [];
	var_a_colors[0] = "0.57647058823 0.18823529411 0.85882352941 1";
	var_a_colors[1] = "0.47843137254 0.71372549019 0.18431372549 1";
	var_a_colors[2] = "0.91372549019 0.58823529411 0.06666666666 1";
	var_a_colors[3] = "0.15686274509 0.84705882352 0.94901960784 1";
	var_a_colors[4] = "0.94117647058 0.19607843137 0.15294117647 1";
	var_a_colors[5] = "0.25490196078 0.41176470588 0.88235294117 1";
	var_a_colors[6] = "0.94509803921 0.76862745098 0.05882352941 1";
	var_a_colors[7] = "0.38039215686 0.87843137254 0.7294117647 1";
	var_a_colors = namespace_Array::function_randomize(var_a_colors);
	for(var_i = 0; var_i < function_GetDvarInt("com_maxclients"); var_i++)
	{
		function_SetDvar("cg_ScoresColor_Gamertag_" + var_i, var_a_colors[var_i]);
	}
}

/*
	Name: function_4f649f2e
	Namespace: namespace_456c991e
	Checksum: 0x424F4353
	Offset: 0x10D8
	Size: 0x48
	Parameters: 0
	Flags: None
	Line Number: 134
*/
function function_4f649f2e()
{
	level endon("hash_disconnect");
	for(;;)
	{
		level waittill("hash_a34fab6c", var_entity);
		var_entity thread function_5ecedc28();
		wait(0.05);
	}
}

/*
	Name: function_87306f09
	Namespace: namespace_456c991e
	Checksum: 0x424F4353
	Offset: 0x1128
	Size: 0x1E0
	Parameters: 0
	Flags: None
	Line Number: 155
*/
function function_87306f09()
{
	self endon("hash_bled_out");
	self endon("hash_spawned_player");
	self endon("hash_disconnect");
	while(isdefined(self.var_is_hotjoining) && self.var_is_hotjoining)
	{
		wait(1);
	}
	while(self.var_sessionstate != "playing")
	{
		wait(1);
	}
	if(!isdefined(self.var_1efe29b2))
	{
		self.var_1efe29b2 = namespace_gameobjects::function_get_next_obj_id();
		function_objective_add(self.var_1efe29b2, "active", self, function_istring("zm_player_waypoint_" + self function_GetEntityNumber()));
		function_Objective_SetProgress(self.var_1efe29b2, namespace_math::function_clamp(self.var_health / self.var_maxhealth, 0, 1));
	}
	self thread function_17ab545a();
	function_Objective_SetInvisibleToPlayer(self.var_1efe29b2, self);
	for(;;)
	{
		wait(0.05);
		function_Objective_SetProgress(self.var_1efe29b2, namespace_math::function_clamp(self.var_health / self.var_maxhealth, 0, 1));
		function_objective_icon(self.var_1efe29b2, "zmu_ui_icon_rank_" + self.var_b74a3cd1["level"]);
	}
}

/*
	Name: function_17ab545a
	Namespace: namespace_456c991e
	Checksum: 0x424F4353
	Offset: 0x1310
	Size: 0x78
	Parameters: 0
	Flags: None
	Line Number: 194
*/
function function_17ab545a()
{
	self namespace_util::function_waittill_any_return("fake_death", "death", "bled_out");
	if(isdefined(self.var_1efe29b2))
	{
		function_objective_delete(self.var_1efe29b2);
		namespace_gameobjects::function_release_obj_id(self.var_1efe29b2);
	}
}

/*
	Name: function_5ecedc28
	Namespace: namespace_456c991e
	Checksum: 0x424F4353
	Offset: 0x1390
	Size: 0xCC0
	Parameters: 0
	Flags: None
	Line Number: 214
*/
function function_5ecedc28()
{
	self endon("hash_d3650eef");
	if(!isdefined(self.var_enemyObjID))
	{
		while(isdefined(self.var_in_the_ground) && self.var_in_the_ground)
		{
			wait(1);
			if(!isdefined(self))
			{
				self notify("hash_d3650eef");
			}
		}
		self.var_enemyObjID = namespace_gameobjects::function_get_next_obj_id();
		switch(self.var_archetype)
		{
			case "undead_saint":
			{
				function_objective_add(self.var_enemyObjID, "active", self, function_istring("zm_enemy_waypoint_boss"));
				break;
			}
			case "uem_ghost":
			{
				function_objective_add(self.var_enemyObjID, "active", self, function_istring("zm_enemy_waypoint_ghost"));
				break;
			}
			case "robot":
			{
				function_objective_add(self.var_enemyObjID, "active", self, function_istring("zm_enemy_waypoint_robot"));
				break;
			}
			case "warlord":
			{
				function_objective_add(self.var_enemyObjID, "active", self, function_istring("zm_enemy_waypoint_warlord"));
				break;
			}
			case "zombie_dog":
			{
				function_objective_add(self.var_enemyObjID, "active", self, function_istring("zm_enemy_waypoint_zombie_dog"));
				break;
			}
			case "direwolf":
			{
				function_objective_add(self.var_enemyObjID, "active", self, function_istring("zm_enemy_waypoint_direwolf"));
				break;
			}
			case "civilian":
			{
				function_objective_add(self.var_enemyObjID, "active", self, function_istring("zm_enemy_waypoint_civilian"));
				break;
			}
			case "skeleton":
			{
				function_objective_add(self.var_enemyObjID, "active", self, function_istring("zm_enemy_waypoint_skeleton"));
				break;
			}
			case "zod_companion":
			{
				function_objective_add(self.var_enemyObjID, "active", self, function_istring("zm_enemy_waypoint_zod_companion"));
				break;
				break;
			}
			case "margwa":
			{
			}
			case "mechz":
			{
				function_objective_add(self.var_enemyObjID, "active", self, function_istring("zm_enemy_waypoint_mechz"));
				break;
			}
			case "mannequin":
			{
				function_objective_add(self.var_enemyObjID, "active", self, function_istring("zm_enemy_waypoint_mannequin"));
				break;
			}
			case "thrasher":
			{
				function_objective_add(self.var_enemyObjID, "active", self, function_istring("zm_enemy_waypoint_thrasher"));
				break;
			}
			case "raz":
			{
				function_objective_add(self.var_enemyObjID, "active", self, function_istring("zm_enemy_waypoint_raz"));
				break;
			}
			case "zombie_quad":
			{
				function_objective_add(self.var_enemyObjID, "active", self, function_istring("zm_enemy_waypoint_zombie_quad"));
				break;
			}
			case "keeper_companion":
			{
				function_objective_add(self.var_enemyObjID, "active", self, function_istring("zm_enemy_waypoint_keeper_companion"));
				break;
			}
			case "apothicon_fury":
			{
				function_objective_add(self.var_enemyObjID, "active", self, function_istring("zm_enemy_waypoint_apothicon_fury"));
				break;
			}
			case "keeper":
			{
				function_objective_add(self.var_enemyObjID, "active", self, function_istring("zm_enemy_waypoint_keeper"));
				break;
			}
			case "monkey":
			{
				function_objective_add(self.var_enemyObjID, "active", self, function_istring("zm_enemy_waypoint_monkey"));
				break;
			}
			case "astronaut":
			{
				function_objective_add(self.var_enemyObjID, "active", self, function_istring("zm_enemy_waypoint_astronaut"));
				break;
			}
			case "raps":
			{
				function_objective_add(self.var_enemyObjID, "active", self, function_istring("zm_enemy_waypoint_raps"));
				break;
			}
			case "wasp":
			{
				function_objective_add(self.var_enemyObjID, "active", self, function_istring("zm_enemy_waypoint_wasp"));
				break;
			}
			case "parasite":
			{
				function_objective_add(self.var_enemyObjID, "active", self, function_istring("zm_enemy_waypoint_parasite"));
				break;
			}
			case "spider":
			{
				function_objective_add(self.var_enemyObjID, "active", self, function_istring("zm_enemy_waypoint_spider"));
				break;
			}
			case "brutus":
			{
				function_objective_add(self.var_enemyObjID, "active", self, function_istring("zm_enemy_waypoint_brutus"));
				break;
			}
			default
			{
				if(isdefined(self.var_81b254b3))
				{
					function_objective_add(self.var_enemyObjID, "active", self, function_istring("zm_enemy_waypoint_boss_armored"));
				}
				else if(self.var_animName == "napalm_zombie")
				{
					function_objective_add(self.var_enemyObjID, "active", self, function_istring("zm_enemy_waypoint_boss_napalm"));
				}
				else if(isdefined(self.var_fc3ab987) && self.var_fc3ab987)
				{
					if(isdefined(self.var_2a280bef) && self.var_2a280bef)
					{
						function_objective_add(self.var_enemyObjID, "active", self, function_istring("zm_enemy_waypoint_heavy_armored"));
					}
					else
					{
						function_objective_add(self.var_enemyObjID, "active", self, function_istring("zm_enemy_waypoint_armored"));
					}
				}
				else if(self.var_animName == "keeper")
				{
					function_objective_add(self.var_enemyObjID, "active", self, function_istring("zm_enemy_waypoint_keeper"));
				}
				else if(isdefined(self.var_ec7527e0) && self.var_ec7527e0)
				{
					function_objective_add(self.var_enemyObjID, "active", self, function_istring("zm_enemy_waypoint_christmas"));
				}
				else
				{
					function_objective_add(self.var_enemyObjID, "active", self, function_istring("zm_enemy_waypoint"));
					break;
				}
			}
		}
		foreach(var_player in function_GetPlayers())
		{
			function_Objective_SetInvisibleToPlayer(self.var_enemyObjID, var_player);
		}
		wait(1);
		if(self.var_archetype == "margwa")
		{
			if(!isdefined(self.var_7cc3eb1b))
			{
				self.var_7cc3eb1b = 0;
				if(isdefined(self.var_heads))
				{
					foreach(var_head in self.var_heads)
					{
						self.var_7cc3eb1b = self.var_7cc3eb1b + var_head.var_health;
					}
				}
			}
			self.var_currentHealth = 0;
			if(isdefined(self.var_heads))
			{
				foreach(var_head in self.var_heads)
				{
					self.var_currentHealth = self.var_currentHealth + var_head.var_health;
				}
			}
			function_Objective_SetProgress(self.var_enemyObjID, namespace_math::function_clamp(self.var_currentHealth / self.var_7cc3eb1b, 0, 1));
		}
		else if(!isdefined(self.var_maxhealth))
		{
			function_Objective_SetProgress(self.var_enemyObjID, namespace_math::function_clamp(self.var_health / self.var_max_health, 0, 1));
		}
		else
		{
			function_Objective_SetProgress(self.var_enemyObjID, namespace_math::function_clamp(self.var_health / self.var_maxhealth, 0, 1));
		}
		self namespace_util::function_waittill_any("death", "entityshutdown");
		function_objective_delete(self.var_enemyObjID);
		namespace_gameobjects::function_release_obj_id(self.var_enemyObjID);
	}
}

/*
	Name: function_c7f76461
	Namespace: namespace_456c991e
	Checksum: 0x424F4353
	Offset: 0x2058
	Size: 0x78
	Parameters: 0
	Flags: None
	Line Number: 442
*/
function function_c7f76461()
{
	wait(0.5);
	while(function_isalive(self))
	{
		wait(0.5);
	}
	if(isdefined(self.var_enemyObjID))
	{
		function_objective_delete(self.var_enemyObjID);
		namespace_gameobjects::function_release_obj_id(self.var_enemyObjID);
	}
}

/*
	Name: function_79ffdd89
	Namespace: namespace_456c991e
	Checksum: 0x424F4353
	Offset: 0x20D8
	Size: 0x2F0
	Parameters: 13
	Flags: None
	Line Number: 466
*/
function function_79ffdd89(var_str_mod, var_str_hit_location, var_v_hit_origin, var_e_attacker, var_n_amount, var_w_weapon, var_direction_vec, var_tagName, var_modelName, var_partName, var_dFlags, var_inflictor, var_chargeLevel)
{
	if(isdefined(self.var_enemyObjID))
	{
		var_1fadf02e = 1;
		if(self.var_archetype == "margwa" && !self function_7db1344c(var_v_hit_origin))
		{
			var_1fadf02e = 0;
		}
		if(!(isdefined(self.var_86bf39b2) && self.var_86bf39b2) && (isdefined(self.var_a44ca904) && self.var_a44ca904 || self.var_archetype == "ghost"))
		{
			var_1fadf02e = 0;
		}
		if(isdefined(self.var_22ce02e1) && self.var_22ce02e1)
		{
			var_1fadf02e = 0;
		}
		if(var_1fadf02e && var_e_attacker.var_f4d01b67["healthbars"] < 2)
		{
			if(self.var_archetype == "margwa")
			{
				self.var_currentHealth = 0;
				foreach(var_head in self.var_heads)
				{
					self.var_currentHealth = self.var_currentHealth + var_head.var_health;
				}
				function_Objective_SetProgress(self.var_enemyObjID, namespace_math::function_clamp(self.var_currentHealth / self.var_7cc3eb1b, 0, 1));
			}
			else if(!isdefined(self.var_maxhealth))
			{
				function_Objective_SetProgress(self.var_enemyObjID, namespace_math::function_clamp(self.var_health / self.var_max_health, 0, 1));
			}
			else
			{
				function_Objective_SetProgress(self.var_enemyObjID, namespace_math::function_clamp(self.var_health / self.var_maxhealth, 0, 1));
			}
		}
	}
	return 0;
}

/*
	Name: function_7db1344c
	Namespace: namespace_456c991e
	Checksum: 0x424F4353
	Offset: 0x23D0
	Size: 0x118
	Parameters: 1
	Flags: None
	Line Number: 517
*/
function function_7db1344c(var_v_point)
{
	var_6a28811 = 0;
	if(isdefined(self.var_head))
	{
		foreach(var_head in self.var_head)
		{
			var_head_pos = self function_GetTagOrigin(var_head.var_tag);
			if(function_DistanceSquared(var_head_pos, var_v_point) < 250 && var_head.var_canDamage)
			{
				var_6a28811 = 1;
			}
		}
	}
	else if(var_6a28811)
	{
		return 1;
	}
	return 0;
}

/*
	Name: function_2dce8d67
	Namespace: namespace_456c991e
	Checksum: 0x424F4353
	Offset: 0x24F0
	Size: 0xC0
	Parameters: 0
	Flags: None
	Line Number: 548
*/
function function_2dce8d67()
{
	switch(self.var_archetype)
	{
		case "astronaut":
		case "margwa":
		case "mechz":
		case "raz":
		case "thrasher":
		case "undead_saint":
		case "zombie_george":
		{
			return 1;
		}
	}
	if(self.var_animName == "napalm_zombie" || self.var_animName == "sonic_zombie" || self.var_animName == "zombie_boss" || (isdefined(self.var_a44ca904) && self.var_a44ca904) || isdefined(self.var_81b254b3))
	{
		return 1;
	}
	return 0;
}

/*
	Name: function_on_player_connect
	Namespace: namespace_456c991e
	Checksum: 0x424F4353
	Offset: 0x25B8
	Size: 0x20
	Parameters: 0
	Flags: None
	Line Number: 580
*/
function function_on_player_connect()
{
	self thread function_c731046b();
}

/*
	Name: function_c731046b
	Namespace: namespace_456c991e
	Checksum: 0x424F4353
	Offset: 0x25E0
	Size: 0x428
	Parameters: 0
	Flags: None
	Line Number: 595
*/
function function_c731046b()
{
	self endon("hash_disconnect");
	while(1)
	{
		if(!namespace_zm_utility::function_is_player_valid(self))
		{
			wait(0.05);
			continue;
		}
		var_view_pos = self function_GetWeaponMuzzlePoint();
		var_zombies = namespace_Array::function_get_all_closest(var_view_pos, function_GetAITeamArray("axis"), undefined, undefined, 5000);
		var_zombies = function_ArraySortClosest(var_zombies, var_view_pos);
		for(var_i = 0; var_i < 4; var_i++)
		{
			if(!function_isalive(var_zombies[var_i]) && !isdefined(var_zombies[var_i].var_enemyObjID))
			{
				continue;
			}
			if(self.var_f4d01b67["healthbars"] < 2)
			{
				var_47e4ea77 = 0;
				var_view_pos = self function_GetWeaponMuzzlePoint();
				var_v_player_angles = self function_getPlayerAngles();
				var_v_player_forward = function_AnglesToForward(var_v_player_angles);
				var_v_player_to_self = var_zombies[var_i].var_origin - self function_GetOrigin();
				var_v_player_to_self = function_VectorNormalize(var_v_player_to_self);
				var_n_dot = function_VectorDot(var_v_player_forward, var_v_player_to_self);
				if(0.925 > var_n_dot)
				{
					var_47e4ea77 = 1;
				}
				if(!var_zombies[var_i] function_cansee(self))
				{
					var_47e4ea77 = 1;
				}
				if(0 == var_zombies[var_i] function_damageConeTrace(var_view_pos, self))
				{
					var_47e4ea77 = 1;
				}
				if(!self function_2dce8d67() || self.var_archetype != "uem_ghost" && self.var_f4d01b67["healthbars"] == 1)
				{
					var_47e4ea77 = 1;
				}
				if(function_Distance(self.var_origin, var_zombies[var_i].var_origin) > 500 && self namespace_util::function_is_looking_at(var_zombies[var_i], 0.8, 1))
				{
					var_47e4ea77 = 0;
				}
				else if(function_Distance(self.var_origin, var_zombies[var_i].var_origin) > 500)
				{
					var_47e4ea77 = 1;
				}
				if(isdefined(var_47e4ea77) && var_47e4ea77)
				{
					function_Objective_SetInvisibleToPlayer(var_zombies[var_i].var_enemyObjID, self);
				}
				else
				{
					function_Objective_SetVisibleToPlayer(var_zombies[var_i].var_enemyObjID, self);
					continue;
				}
			}
			function_Objective_SetInvisibleToPlayer(var_zombies[var_i].var_enemyObjID, self);
		}
		wait(0.05);
	}
}

/*
	Name: function_d7c1ad11
	Namespace: namespace_456c991e
	Checksum: 0x424F4353
	Offset: 0x2A10
	Size: 0x20
	Parameters: 0
	Flags: None
	Line Number: 673
*/
function function_d7c1ad11()
{
	self thread function_c8010df4();
}

/*
	Name: function_c8010df4
	Namespace: namespace_456c991e
	Checksum: 0x424F4353
	Offset: 0x2A38
	Size: 0x158
	Parameters: 0
	Flags: None
	Line Number: 688
*/
function function_c8010df4()
{
	self endon("hash_disconnect");
	level namespace_util::function_waittill_any("end_game", "end_game_uem");
	level thread namespace_zm_audio::function_sndMusicSystem_PlayState("game_over");
	namespace_Array::function_run_all(level.var_players, &namespace_clientfield::function_set, "zmbLastStand", 0);
	level namespace_clientfield::function_set("game_end_time", function_Int(GetTime() - level.var_n_gameplay_start_time + 500 / 1000));
	self function_closeInGameMenu();
	self function_CloseMenu("StartMenu_Main");
	wait(1);
	function_LUINotifyEvent(&"force_scoreboard", 0);
	level notify("hash_stop_intermission");
	wait(2);
	self function_openMenu("Intermission_Main");
}

/*
	Name: function_e891e4f9
	Namespace: namespace_456c991e
	Checksum: 0x424F4353
	Offset: 0x2B98
	Size: 0x100
	Parameters: 0
	Flags: None
	Line Number: 714
*/
function function_e891e4f9()
{
	self endon("hash_bled_out");
	self endon("hash_spawned_player");
	self endon("hash_disconnect");
	wait(0.05);
	level namespace_flag::function_wait_till("initial_blackscreen_passed");
	var_fb5258da = 0;
	for(;;)
	{
		wait(0.05);
		level.var_ec5f9c56 = namespace_zombie_utility::function_get_current_zombie_count() + level.var_zombie_total;
		if(var_fb5258da != level.var_ec5f9c56)
		{
			if(isdefined(level.var_zombie_actor_limit) && level.var_zombie_actor_limit != 0)
			{
				self thread namespace_97ac1184::function_8c165b4d("Data", "ZombiesLeft", level.var_ec5f9c56 + ":" + level.var_zombie_actor_limit);
				var_fb5258da = level.var_ec5f9c56;
			}
		}
	}
}

/*
	Name: function_68ebef1d
	Namespace: namespace_456c991e
	Checksum: 0x424F4353
	Offset: 0x2CA0
	Size: 0x160
	Parameters: 0
	Flags: None
	Line Number: 747
*/
function function_68ebef1d()
{
	self endon("hash_bled_out");
	self endon("hash_spawned_player");
	self endon("hash_disconnect");
	wait(0.05);
	level namespace_flag::function_wait_till("initial_blackscreen_passed");
	while(1)
	{
		if(isdefined(self))
		{
			if(namespace_zm_utility::function_is_player_valid(self))
			{
				var_w_current = self function_GetCurrentWeapon();
				var_w_current = namespace_zm_weapons::function_get_nonalternate_weapon(var_w_current);
				if(isdefined(var_w_current.var_rootweapon))
				{
					var_w_current = var_w_current.var_rootweapon;
				}
				var_7750a3aa = self namespace_5e1f56dc::function_1239e0ad(var_w_current);
				if(isdefined(var_7750a3aa))
				{
					self namespace_clientfield::function_set_player_uimodel("ZMBU.WeaponPapLevel", var_7750a3aa.var_a39a2843);
				}
				else
				{
					self namespace_clientfield::function_set_player_uimodel("ZMBU.WeaponPapLevel", 0);
				}
			}
		}
		wait(0.1);
	}
}

/*
	Name: function_762bdac0
	Namespace: namespace_456c991e
	Checksum: 0x424F4353
	Offset: 0x2E08
	Size: 0x118
	Parameters: 0
	Flags: None
	Line Number: 791
*/
function function_762bdac0()
{
	self endon("hash_bled_out");
	self endon("hash_spawned_player");
	self endon("hash_disconnect");
	wait(0.05);
	level namespace_flag::function_wait_till("initial_blackscreen_passed");
	while(1)
	{
		if(isdefined(self))
		{
			if(namespace_zm_utility::function_is_player_valid(self))
			{
				if(!self namespace_clientfield::function_get_player_uimodel("ZMBU.Health") === self.var_health)
				{
					self namespace_clientfield::function_set_player_uimodel("ZMBU.Health", self.var_health);
				}
			}
			else if(!self namespace_clientfield::function_get_player_uimodel("ZMBU.Health") === 0)
			{
				self namespace_clientfield::function_set_player_uimodel("ZMBU.Health", 0);
			}
		}
		wait(0.05);
	}
}

/*
	Name: function_28217684
	Namespace: namespace_456c991e
	Checksum: 0x424F4353
	Offset: 0x2F28
	Size: 0x1E0
	Parameters: 0
	Flags: None
	Line Number: 828
*/
function function_28217684()
{
	self endon("hash_bled_out");
	self endon("hash_spawned_player");
	self endon("hash_disconnect");
	wait(0.05);
	level namespace_flag::function_wait_till("initial_blackscreen_passed");
	while(1)
	{
		if(isdefined(self))
		{
			if(namespace_zm_utility::function_is_player_valid(self) && !namespace_zm_utility::function_is_placeable_mine(self function_GetCurrentWeapon()) && !namespace_zm_equipment::function_is_equipment(self function_GetCurrentWeapon()) && !self namespace_zm_utility::function_is_player_revive_tool(self function_GetCurrentWeapon()) && level.var_zombie_powerup_weapon["minigun"] != self function_GetCurrentWeapon() && level.var_weaponNone != self function_GetCurrentWeapon() && isdefined(self function_GetWeaponsListPrimaries()[2]) && self function_GetWeaponsListPrimaries()[2] == self function_GetCurrentWeapon())
			{
				self namespace_clientfield::function_set_player_uimodel("ZMBU.MuleKick", 1);
			}
			else
			{
				self namespace_clientfield::function_set_player_uimodel("ZMBU.MuleKick", 0);
			}
		}
		wait(0.05);
	}
}

/*
	Name: function_18672742
	Namespace: namespace_456c991e
	Checksum: 0x424F4353
	Offset: 0x3110
	Size: 0x250
	Parameters: 0
	Flags: None
	Line Number: 862
*/
function function_18672742()
{
	self endon("hash_disconnect");
	self endon("hash_entityshutdown");
	wait(0.05);
	level namespace_flag::function_wait_till("initial_blackscreen_passed");
	while(1)
	{
		if(isdefined(self))
		{
			if(namespace_zm_utility::function_is_player_valid(self) && !namespace_zm_utility::function_is_placeable_mine(self function_GetCurrentWeapon()) && !namespace_zm_equipment::function_is_equipment(self function_GetCurrentWeapon()) && !self namespace_zm_utility::function_is_player_revive_tool(self function_GetCurrentWeapon()) && level.var_zombie_powerup_weapon["minigun"] != self function_GetCurrentWeapon() && level.var_weaponNone != self function_GetCurrentWeapon() && isdefined(self namespace_AAT::function_getAATOnWeapon(self function_GetCurrentWeapon())))
			{
				var_weapon = self function_GetCurrentWeapon();
				var_currentAAT = self namespace_AAT::function_getAATOnWeapon(var_weapon);
				if(!self function_d7f04f83("UEM.AAT.Name") === var_currentAAT.var_name)
				{
					self function_SetControllerUIModelValue("UEM.AAT.Name", var_currentAAT.var_name);
				}
			}
			else if(!self function_d7f04f83("UEM.AAT.Name") === "none")
			{
				self function_SetControllerUIModelValue("UEM.AAT.Name", "none");
			}
		}
		wait(0.15);
	}
}

/*
	Name: function_4659d62
	Namespace: namespace_456c991e
	Checksum: 0x424F4353
	Offset: 0x3368
	Size: 0x108
	Parameters: 0
	Flags: None
	Line Number: 900
*/
function function_4659d62()
{
	self endon("hash_bled_out");
	self endon("hash_spawned_player");
	self endon("hash_disconnect");
	wait(0.05);
	level namespace_flag::function_wait_till("initial_blackscreen_passed");
	var_a239db2d = 0;
	while(1)
	{
		if(isdefined(self))
		{
			if(isdefined(level.var_679e1a9e) && level.var_679e1a9e)
			{
				if(!(isdefined(var_a239db2d) && var_a239db2d))
				{
					self namespace_clientfield::function_set_player_uimodel("ZMBU.rage_inducer", 1);
					var_a239db2d = 1;
				}
			}
			else if(isdefined(var_a239db2d) && var_a239db2d)
			{
				self namespace_clientfield::function_set_player_uimodel("ZMBU.rage_inducer", 0);
				var_a239db2d = 0;
			}
		}
		wait(1);
	}
}

/*
	Name: function_cea699de
	Namespace: namespace_456c991e
	Checksum: 0x424F4353
	Offset: 0x3478
	Size: 0x140
	Parameters: 0
	Flags: None
	Line Number: 940
*/
function function_cea699de()
{
	level.var_ef8088c1 = [];
	if(function_b400349f())
	{
		var_file = function_ce660824();
		var_66a7154d = function_1556496c(var_file);
		for(var_i = 0; var_i < var_66a7154d; var_i++)
		{
			var_row = function_TableLookupRow(var_file, var_i);
			var_f8a0eae0 = function_checkStringValid(var_row[1]);
			var_zone_name = function_checkStringValid(var_row[2]);
			if(isdefined(var_f8a0eae0) && isdefined(var_zone_name))
			{
				level.var_ef8088c1[var_f8a0eae0] = var_zone_name;
			}
		}
	}
	else
	{
		level.var_ef8088c1 = undefined;
		return;
	}
	level.var_0 = undefined;
}

/*
	Name: function_a6f1e7f0
	Namespace: namespace_456c991e
	Checksum: 0x424F4353
	Offset: 0x35C0
	Size: 0x1F8
	Parameters: 0
	Flags: None
	Line Number: 976
*/
function function_a6f1e7f0()
{
	self endon("hash_bled_out");
	self endon("hash_spawned_player");
	self endon("hash_disconnect");
	wait(0.05);
	level namespace_flag::function_wait_till("initial_blackscreen_passed");
	self.var_f4d01b67["location_information"] = function_Int(0);
	while(1)
	{
		if(isdefined(self))
		{
			var_str_zone = self namespace_zm_zonemgr::function_get_player_zone();
			var_zone = self namespace_zm_utility::function_get_current_zone(1);
			var_zone_name = self function_zone_name(var_zone, var_str_zone);
			if(isdefined(var_zone_name))
			{
				if(!self function_d7f04f83("ZMBU.zone_name") === var_zone_name)
				{
					if(self.var_f4d01b67["location_information"] == 0)
					{
						self function_SetControllerUIModelValue("ZMBU.zone_name", var_zone_name);
					}
					else
					{
						self function_SetControllerUIModelValue("ZMBU.zone_name", "");
					}
				}
			}
			else if(self.var_f4d01b67["location_information"] == 0)
			{
				self function_SetControllerUIModelValue("ZMBU.zone_name", "Unknown Location");
			}
			else
			{
				self function_SetControllerUIModelValue("ZMBU.zone_name", "");
			}
		}
		wait(1);
	}
}

/*
	Name: function_zone_name
	Namespace: namespace_456c991e
	Checksum: 0x424F4353
	Offset: 0x37C0
	Size: 0xD0
	Parameters: 2
	Flags: None
	Line Number: 1028
*/
function function_zone_name(var_zone, var_str_zone)
{
	var_zones = var_zone.var_Volumes;
	for(var_i = 0; var_i < var_zones.size; var_i++)
	{
		if(self function_istouching(var_zones[var_i]))
		{
			return var_zones[var_i].var_script_string;
		}
	}
	if(!isdefined(var_zone))
	{
		return "";
	}
	if(isdefined(level.var_ef8088c1[var_str_zone]))
	{
		return level.var_ef8088c1[var_str_zone];
	}
	return "";
	ERROR: Bad function call
}

/*
	Name: function_6df56a67
	Namespace: namespace_456c991e
	Checksum: 0x424F4353
	Offset: 0x3898
	Size: 0xE0
	Parameters: 1
	Flags: None
	Line Number: 1060
*/
function function_6df56a67(var_zone)
{
	if(!isdefined(var_zone))
	{
		var_value = "Unknown Location";
	}
	var_zones = var_zone.var_Volumes;
	for(var_i = 0; var_i < var_zones.size; var_i++)
	{
		if(self function_istouching(var_zones[var_i]))
		{
			var_file = function_ce660824();
			var_value = function_b036e24c(var_file, var_zones[var_i]);
		}
	}
	return var_value;
}

/*
	Name: function_b036e24c
	Namespace: namespace_456c991e
	Checksum: 0x424F4353
	Offset: 0x3980
	Size: 0x100
	Parameters: 2
	Flags: None
	Line Number: 1088
*/
function function_b036e24c(var_file, var_zone)
{
	var_66a7154d = function_1556496c(var_file);
	for(var_i = 0; var_i < var_66a7154d; var_i++)
	{
		var_row = function_TableLookupRow(var_file, var_i);
		var_f8a0eae0 = function_checkStringValid(var_row[1]);
		var_zone_name = function_checkStringValid(var_row[2]);
		if(var_f8a0eae0 == var_zone.var_targetname)
		{
			return var_zone_name;
		}
	}
	return "Unknown Location";
	~var_zone_name;
}

/*
	Name: function_ce660824
	Namespace: namespace_456c991e
	Checksum: 0x424F4353
	Offset: 0x3A88
	Size: 0x40
	Parameters: 0
	Flags: None
	Line Number: 1115
*/
function function_ce660824()
{
	return "gamedata/zone_names/zone_names_" + function_ToLower(function_GetDvarString("mapname") + ".csv");
	.var_0 = undefined;
}

/*
	Name: function_b400349f
	Namespace: namespace_456c991e
	Checksum: 0x424F4353
	Offset: 0x3AD0
	Size: 0xD8
	Parameters: 0
	Flags: None
	Line Number: 1131
*/
function function_b400349f()
{
	switch(function_ToLower(function_GetDvarString("mapname")))
	{
		case "zm_asylum":
		case "zm_castle":
		case "zm_cosmodrome":
		case "zm_factory":
		case "zm_genesis":
		case "zm_island":
		case "zm_moon":
		case "zm_prison":
		case "zm_prototype":
		case "zm_stalingrad":
		case "zm_sumpf":
		case "zm_temple":
		case "zm_theater":
		case "zm_tomb":
		case "zm_town":
		case "zm_town_hd":
		case "zm_zod":
		{
			return 1;
		}
		default
		{
			return 0;
		}
	}
	return 0;
}

/*
	Name: function_checkStringValid
	Namespace: namespace_456c991e
	Checksum: 0x424F4353
	Offset: 0x3BB0
	Size: 0x24
	Parameters: 1
	Flags: None
	Line Number: 1173
*/
function function_checkStringValid(var_STR)
{
	if(var_STR != "")
	{
		return var_STR;
	}
	return undefined;
}

