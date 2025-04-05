#include scripts\codescripts\struct;
#include scripts\shared\aat_shared;
#include scripts\shared\ai\systems\gib;
#include scripts\shared\ai\zombie_utility;
#include scripts\shared\array_shared;
#include scripts\shared\clientfield_shared;
#include scripts\shared\flag_shared;
#include scripts\shared\math_shared;
#include scripts\shared\system_shared;
#include scripts\shared\util_shared;
#include scripts\zm\_zm_lightning_chain;
#include scripts\zm\_zm_utility;

#namespace namespace_zm_aat_dead_wire;

/*
	Name: function___init__sytem__
	Namespace: namespace_zm_aat_dead_wire
	Checksum: 0x424F4353
	Offset: 0x290
	Size: 0x38
	Parameters: 0
	Flags: AutoExec
	Line Number: 25
*/
function autoexec function___init__sytem__()
{
	namespace_system::function_register("zm_aat_dead_wire", &function___init__, undefined, "aat");
	return;
	ERROR: Exception occured: Stack empty.
}

/*
	Name: function___init__
	Namespace: namespace_zm_aat_dead_wire
	Checksum: 0x424F4353
	Offset: 0x2D0
	Size: 0x158
	Parameters: 0
	Flags: None
	Line Number: 42
*/
function function___init__()
{
	if(!(isdefined(level.var_aat_in_use) && level.var_aat_in_use))
	{
		return;
	}
	namespace_AAT::function_register("zm_aat_dead_wire", 0.1, 0, function_randomIntRange(27, 32), 2, 1, &function_result, "t7_hud_zm_aat_deadwire", "wpn_aat_dead_wire_plr");
	namespace_clientfield::function_register("actor", "zm_aat_dead_wire" + "_zap", 1, 1, "int");
	namespace_clientfield::function_register("vehicle", "zm_aat_dead_wire" + "_zap_vehicle", 1, 1, "int");
	level.var_zm_aat_dead_wire_lightning_chain_params = namespace_lightning_chain::function_create_lightning_chain_params(5, 6, 110);
	level.var_zm_aat_dead_wire_lightning_chain_params.var_head_gib_chance = 100;
	level.var_zm_aat_dead_wire_lightning_chain_params.var_network_death_choke = 4;
	level.var_zm_aat_dead_wire_lightning_chain_params.var_challenge_stat_name = "ZOMBIE_HUNTER_DEAD_WIRE";
}

/*
	Name: function_result
	Namespace: namespace_zm_aat_dead_wire
	Checksum: 0x424F4353
	Offset: 0x430
	Size: 0xCC
	Parameters: 4
	Flags: None
	Line Number: 67
*/
function function_result(var_death, var_attacker, var_mod, var_weapon)
{
	if(!isdefined(level.var_zombie_vars["tesla_head_gib_chance"]))
	{
		namespace_zombie_utility::function_set_zombie_var("tesla_head_gib_chance", 50);
	}
	var_attacker.var_tesla_enemies = undefined;
	var_attacker.var_tesla_enemies_hit = 1;
	var_attacker.var_tesla_powerup_dropped = 0;
	var_attacker.var_tesla_arc_count = 0;
	level.var_zm_aat_dead_wire_lightning_chain_params.var_weapon = var_weapon;
	self namespace_lightning_chain::function_arc_damage(self, var_attacker, 1, level.var_zm_aat_dead_wire_lightning_chain_params);
}

