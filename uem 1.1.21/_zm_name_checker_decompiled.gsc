#include scripts\shared\util_shared;
#include scripts\zm\_util;
#include scripts\zm\_zm;
#include scripts\zm\_zm_powerups;

#namespace namespace_71d987dc;

/*
	Name: function_2f134368
	Namespace: namespace_71d987dc
	Checksum: 0x424F4353
	Offset: 0x968
	Size: 0x3E8
	Parameters: 1
	Flags: None
	Line Number: 17
*/
function function_2f134368(var_84893f3)
{
	if(!isdefined(var_84893f3))
	{
		return;
	}
	switch(var_84893f3)
	{
		case "jugg":
		case "juggernog":
		case "juggnog":
		case "nog":
		case "specialty_armorvest":
		{
			return "specialty_armorvest";
		}
		case "quick":
		case "quickrevive":
		case "revive":
		case "specialty_quickrevive":
		{
			return "specialty_quickrevive";
		}
		case "fastreload":
		case "reload":
		case "specialty_fastreload":
		case "speed":
		case "speedcola":
		{
			return "specialty_fastreload";
		}
		case "double":
		case "doubletap":
		case "fastfire":
		case "specialty_doubletap2":
		{
			return "specialty_doubletap2";
		}
		case "marathon":
		case "specialty_staminup":
		case "stamin":
		case "staminup":
		{
			return "specialty_staminup";
		}
		case "flopper":
		case "phd":
		case "phdflopper":
		case "specialty_phdflopper":
		{
			return "specialty_phdflopper";
		}
		case "ads":
		case "daiquiri":
		case "deadshot":
		case "specialty_deadshot":
		{
			return "specialty_deadshot";
		}
		case "additionalprimaryweapon":
		case "mule":
		case "mulekick":
		case "specialty_additionalprimaryweapon":
		{
			return "specialty_additionalprimaryweapon";
		}
		case "cherry":
		case "electric":
		case "electric_cherry":
		case "electriccherry":
		case "specialty_electriccherry":
		{
			return "specialty_electriccherry";
		}
		case "specialty_tombstone":
		case "tomb":
		case "tombstone":
		{
			return "specialty_tombstone";
		}
		case "specialty_whoswho":
		case "whos":
		case "whos_who":
		case "whoswho":
		{
			return "specialty_whoswho";
		}
		case "aid":
		case "specialty_vultureaid":
		case "vulture":
		case "vultureaid":
		{
			return "specialty_vultureaid";
		}
		case "specialty_widowswine":
		case "widows":
		case "widowswine":
		case "wine":
		{
			return "specialty_widowswine";
		}
		case "frost":
		case "frost_brew":
		case "frostbrew":
		case "specialty_immunetriggershock":
		{
			return "specialty_immunetriggershock";
		}
		case "madgaz_moonshine":
		case "moon":
		case "moonshine":
		case "shine":
		case "specialty_flakjacket":
		{
			return "specialty_flakjacket";
		}
		case "ale":
		case "crusader":
		case "crusader_ale":
		case "madgaz_crusader":
		case "specialty_flashprotection":
		{
			return "specialty_flashprotection";
		}
		case "bull":
		case "bull_ice":
		case "bull_ice_blast":
		case "bullice":
		case "bulliceblast":
		case "bullsiceblast":
		case "ice_blast":
		case "iceblast":
		case "madgaz_bull":
		case "specialty_proximityprotection":
		{
			return "specialty_proximityprotection";
		}
		case "banana":
		case "banana_colada":
		case "bananacolada":
		case "colada":
		case "madgaz_banana":
		case "specialty_immunecounteruav":
		{
			return "specialty_immunecounteruav";
		}
		case "rush":
		case "specialty_directionalfire":
		case "vigor":
		case "vigor_rush":
		case "vigorrush":
		{
			return "specialty_directionalfire";
		}
		case "death":
		case "death_perception":
		case "dp":
		case "perception":
		{
			return "specialty_tracker";
		}
		case "madgaz":
		{
			return "specialty_immunecounteruav specialty_proximityprotection specialty_flashprotection specialty_flakjacket ;";
		}
		case "classic":
		{
			return "specialty_armorvest specialty_fastreload specialty_doubletap2 specialty_quickrevive ;";
		}
		default
		{
			return var_84893f3;
		}
	}
}

/*
	Name: function_e350ab20
	Namespace: namespace_71d987dc
	Checksum: 0x424F4353
	Offset: 0xD58
	Size: 0x3A0
	Parameters: 1
	Flags: None
	Line Number: 203
*/
function function_e350ab20(var_36e03f75)
{
	if(!isdefined(var_36e03f75))
	{
		return;
	}
	switch(var_36e03f75)
	{
		case "ammo":
		case "full_ammo":
		case "max":
		case "max_ammo":
		case "maxammo":
		{
			return "full_ammo";
		}
		case "boom":
		case "nuke":
		{
			return "nuke";
		}
		case "insta":
		case "insta_kill":
		case "instakill":
		case "kill":
		{
			return "insta_kill";
		}
		case "double":
		case "double_points":
		case "doublepoints":
		case "dpoints":
		{
			return "double_points";
		}
		case "carpenter":
		{
			return "carpenter";
		}
		case "fire":
		case "fire_sale":
		case "firesale":
		case "sale":
		{
			return "fire_sale";
		}
		case "bonfire":
		case "bonfire_sale":
		case "bonfiresale":
		{
			return "bonfire_sale";
		}
		case "minigun":
		{
			return "minigun";
		}
		case "free_perk":
		case "freeperk":
		case "perk":
		{
			return "free_perk";
		}
		case "tesla":
		{
			return "tesla";
		}
		case "random_weapon":
		case "randomweapon":
		case "weapon":
		{
			return "random_weapon";
		}
		case "bonus_player":
		case "bonus_points_player":
		case "money_player":
		case "playerpoints":
		case "points_player":
		{
			return "bonus_points_player";
		}
		case "bonus_points_team":
		case "bonus_team":
		case "money_team":
		case "points":
		case "points_team":
		case "teampoints":
		{
			return "bonus_points_team";
		}
		case "lose_points_team":
		case "losepointsteam":
		case "team_lose":
		case "teamlose":
		{
			return "lose_points_team";
		}
		case "lose_perk":
		case "loseperk":
		{
			return "lose_perk";
		}
		case "empty_clip":
		case "emptyclip":
		{
			return "empty_clip";
		}
		case "blood":
		case "zombie":
		case "zombie_blood":
		case "zombieblood":
		{
			return "zombie_blood";
		}
		case "widows":
		case "widowswine":
		case "widowswinegrenade":
		case "ww":
		case "ww_grenade":
		case "wwgrenade":
		{
			return "ww_grenade";
		}
		case "charge":
		case "shield":
		case "shield_charge":
		case "shieldcharge":
		{
			return "shield_charge";
		}
		case "perk_slot":
		case "perkslot":
		case "slot":
		{
			return "perk_slot";
		}
		case "full_power":
		case "fullpower":
		case "power":
		{
			return "full_power";
		}
		case "blood_money":
		case "blood_points":
		case "bloodmoney":
		case "bloodpoints":
		{
			return "blood_money";
		}
		case "bottomless":
		case "bottomless_clip":
		case "bottomlessclip":
		case "clip":
		case "infinite":
		case "infiniteammo":
		{
			return "bottomless_clip";
		}
		case "fast":
		case "fast_feet":
		case "fastfeet":
		case "feet":
		{
			return "fast_feet";
		}
		default
		{
			return var_36e03f75;
		}
	}
}

/*
	Name: function_a2ccecad
	Namespace: namespace_71d987dc
	Checksum: 0x424F4353
	Offset: 0x1100
	Size: 0xF8
	Parameters: 2
	Flags: None
	Line Number: 384
*/
function function_a2ccecad(var_str_powerup, var_v_origin)
{
	if(!isdefined(var_v_origin))
	{
		var_v_origin = self.var_origin + VectorScale(function_AnglesToForward((0, self function_getPlayerAngles()[1], 0)), 60) + VectorScale((0, 0, 1), 5);
	}
	var_93eb638b = namespace_zm_powerups::function_specific_powerup_drop(var_str_powerup, var_v_origin);
	wait(1);
	if(isdefined(var_93eb638b) && (!var_93eb638b namespace_zm::function_in_enabled_playable_area() && !var_93eb638b namespace_zm::function_in_life_brush()))
	{
		level thread function_434235f9(var_93eb638b);
	}
}

/*
	Name: function_7248d053
	Namespace: namespace_71d987dc
	Checksum: 0x424F4353
	Offset: 0x1200
	Size: 0x2C0
	Parameters: 1
	Flags: None
	Line Number: 408
*/
function function_7248d053(var_d858aeb5)
{
	var_7ec6c170 = self.var_origin + VectorScale(function_AnglesToForward((0, self function_getPlayerAngles()[1], 0)), 60) + VectorScale((0, 0, 1), 5);
	var_v_up = VectorScale((0, 0, 1), 5);
	var_8e2dcc47 = var_7ec6c170 + function_AnglesToForward(self.var_angles) * 60 + var_v_up;
	var_682b51de = var_8e2dcc47 + function_AnglesToForward(self.var_angles) * 60 + var_v_up;
	switch(var_d858aeb5)
	{
		case 1:
		{
			var_v_origin = var_7ec6c170 + function_AnglesToRight(self.var_angles) * -60 + var_v_up;
			break;
		}
		case 2:
		{
			var_v_origin = var_7ec6c170;
			break;
		}
		case 3:
		{
			var_v_origin = var_7ec6c170 + function_AnglesToRight(self.var_angles) * 60 + var_v_up;
			break;
		}
		case 4:
		{
			var_v_origin = var_8e2dcc47 + function_AnglesToRight(self.var_angles) * -60 + var_v_up;
			break;
		}
		case 5:
		{
			var_v_origin = var_8e2dcc47;
			break;
		}
		case 6:
		{
			var_v_origin = var_8e2dcc47 + function_AnglesToRight(self.var_angles) * 60 + var_v_up;
			break;
		}
		case 7:
		{
			var_v_origin = var_682b51de + function_AnglesToRight(self.var_angles) * -60 + var_v_up;
			break;
		}
		case 8:
		{
			var_v_origin = var_682b51de;
			break;
		}
		case 9:
		{
			var_v_origin = var_682b51de + function_AnglesToRight(self.var_angles) * 60 + var_v_up;
			break;
		}
		default
		{
			var_v_origin = var_7ec6c170;
			break;
		}
	}
	return var_v_origin;
	ERROR: Exception occured: Stack empty.
}

/*
	Name: function_434235f9
	Namespace: namespace_71d987dc
	Checksum: 0x424F4353
	Offset: 0x14C8
	Size: 0x37C
	Parameters: 1
	Flags: None
	Line Number: 481
*/
function function_434235f9(var_93eb638b)
{
	if(!isdefined(var_93eb638b))
	{
		return;
	}
	var_93eb638b function_ghost();
	var_93eb638b.var_clone_model = namespace_util::function_spawn_model(var_93eb638b.var_model, var_93eb638b.var_origin, var_93eb638b.var_angles);
	var_93eb638b.var_clone_model function_LinkTo(var_93eb638b);
	var_direction = var_93eb638b.var_origin;
	var_direction = (var_direction[1], var_direction[0], 0);
	if(var_direction[1] < 0 || (var_direction[0] > 0 && var_direction[1] > 0))
	{
		var_direction = (var_direction[0], var_direction[1] * -1, 0);
	}
	else if(var_direction[0] < 0)
	{
		var_direction = (var_direction[0] * -1, var_direction[1], 0);
	}
	if(!(isdefined(var_93eb638b.var_sndNoSamLaugh) && var_93eb638b.var_sndNoSamLaugh))
	{
		var_players = function_GetPlayers();
		for(var_i = 0; var_i < var_players.size; var_i++)
		{
			if(function_isalive(var_players[var_i]))
			{
				var_players[var_i] function_playlocalsound(level.var_zmb_laugh_alias);
			}
		}
	}
	function_PlayFXOnTag(level.var__effect["samantha_steal"], var_93eb638b, "tag_origin");
	var_93eb638b.var_clone_model function_Unlink();
	var_93eb638b.var_clone_model function_MoveZ(60, 1, 0.25, 0.25);
	var_93eb638b.var_clone_model function_vibrate(var_direction, 1.5, 2.5, 1);
	var_93eb638b.var_clone_model waittill("hash_movedone");
	if(isdefined(self.var_damagearea))
	{
		self.var_damagearea function_delete();
	}
	var_93eb638b.var_clone_model function_delete();
	if(isdefined(var_93eb638b))
	{
		if(isdefined(var_93eb638b.var_damagearea))
		{
			var_93eb638b.var_damagearea function_delete();
		}
		var_93eb638b namespace_zm_powerups::function_powerup_delete();
	}
}

