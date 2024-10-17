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
	return;
	ERROR: Bad function call
}

/*
	Name: function_e350ab20
	Namespace: namespace_71d987dc
	Checksum: 0x424F4353
	Offset: 0xD58
	Size: 0x3A0
	Parameters: 1
	Flags: None
	Line Number: 205
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
	Line Number: 386
*/
function function_a2ccecad(str_powerup, v_origin)
{
	if(!isdefined(v_origin))
	{
		v_origin = self.origin + VectorScale(anglestoforward((0, self getplayerangles()[1], 0)), 60) + VectorScale((0, 0, 1), 5);
	}
	var_93eb638b = zm_powerups::specific_powerup_drop(str_powerup, v_origin);
	wait(1);
	if(isdefined(var_93eb638b) && (!var_93eb638b zm::in_enabled_playable_area() && !var_93eb638b zm::in_life_brush()))
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
	Line Number: 410
*/
function function_7248d053(var_d858aeb5)
{
	var_7ec6c170 = self.origin + VectorScale(anglestoforward((0, self getplayerangles()[1], 0)), 60) + VectorScale((0, 0, 1), 5);
	v_up = VectorScale((0, 0, 1), 5);
	var_8e2dcc47 = var_7ec6c170 + anglestoforward(self.angles) * 60 + v_up;
	var_682b51de = var_8e2dcc47 + anglestoforward(self.angles) * 60 + v_up;
	switch(var_d858aeb5)
	{
		case 1:
		{
			v_origin = var_7ec6c170 + anglestoright(self.angles) * -60 + v_up;
			break;
		}
		case 2:
		{
			v_origin = var_7ec6c170;
			break;
		}
		case 3:
		{
			v_origin = var_7ec6c170 + anglestoright(self.angles) * 60 + v_up;
			break;
		}
		case 4:
		{
			v_origin = var_8e2dcc47 + anglestoright(self.angles) * -60 + v_up;
			break;
		}
		case 5:
		{
			v_origin = var_8e2dcc47;
			break;
		}
		case 6:
		{
			v_origin = var_8e2dcc47 + anglestoright(self.angles) * 60 + v_up;
			break;
		}
		case 7:
		{
			v_origin = var_682b51de + anglestoright(self.angles) * -60 + v_up;
			break;
		}
		case 8:
		{
			v_origin = var_682b51de;
			break;
		}
		case 9:
		{
			v_origin = var_682b51de + anglestoright(self.angles) * 60 + v_up;
			break;
		}
		default
		{
			v_origin = var_7ec6c170;
			break;
		}
	}
	return v_origin;
}

/*
	Name: function_434235f9
	Namespace: namespace_71d987dc
	Checksum: 0x424F4353
	Offset: 0x14C8
	Size: 0x37C
	Parameters: 1
	Flags: None
	Line Number: 482
*/
function function_434235f9(var_93eb638b)
{
	if(!isdefined(var_93eb638b))
	{
		return;
	}
	var_93eb638b ghost();
	var_93eb638b.clone_model = util::spawn_model(var_93eb638b.model, var_93eb638b.origin, var_93eb638b.angles);
	var_93eb638b.clone_model linkto(var_93eb638b);
	direction = var_93eb638b.origin;
	direction = (direction[1], direction[0], 0);
	if(direction[1] < 0 || (direction[0] > 0 && direction[1] > 0))
	{
		direction = (direction[0], direction[1] * -1, 0);
	}
	else if(direction[0] < 0)
	{
		direction = (direction[0] * -1, direction[1], 0);
	}
	if(!(isdefined(var_93eb638b.sndNoSamLaugh) && var_93eb638b.sndNoSamLaugh))
	{
		players = getplayers();
		for(i = 0; i < players.size; i++)
		{
			if(isalive(players[i]))
			{
				players[i] playlocalsound(level.zmb_laugh_alias);
			}
		}
	}
	playfxontag(level._effect["samantha_steal"], var_93eb638b, "tag_origin");
	var_93eb638b.clone_model unlink();
	var_93eb638b.clone_model movez(60, 1, 0.25, 0.25);
	var_93eb638b.clone_model vibrate(direction, 1.5, 2.5, 1);
	var_93eb638b.clone_model waittill("movedone");
	if(isdefined(self.damagearea))
	{
		self.damagearea delete();
	}
	var_93eb638b.clone_model delete();
	if(isdefined(var_93eb638b))
	{
		if(isdefined(var_93eb638b.damagearea))
		{
			var_93eb638b.damagearea delete();
		}
		var_93eb638b zm_powerups::powerup_delete();
	}
}

