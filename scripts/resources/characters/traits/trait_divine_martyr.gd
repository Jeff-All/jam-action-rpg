class_name TraitDivineMartyr

extends Trait

@export var shield_scale: float = 0.5

var effect_applied: bool = false
var pcui: PCUI
var battle: Battle

func apply(_pcui: PCUI, _battle: Battle):
	pcui = _pcui
	battle = _battle
	pcui.on_death.connect(_on_character_death)

func remove(_pcui: PCUI):
	pcui.on_death.disconnect(_on_character_death)
	pcui = null
	battle = null

func _on_character_death(_pc: PCUI):
	var shields = (_pc.character.resources[CharacterCampaign.Resources.HEALTH]._max.adjusted + _pc.character.attributes[CharacterCampaign.Attributes.MAGIC].adjusted) * shield_scale
	
	for cur in battle.party:
		if !cur.dead: 
			var cur_shields = cur.resources[CharacterCampaign.Resources.SHIELDING].cur 
			if shields > cur_shields:
				cur.resources[CharacterCampaign.Resources.SHIELDING].cur = shields

func apply_effect():
	effect_applied = true
