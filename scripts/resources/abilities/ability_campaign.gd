class_name AbilityCampaign

extends Resource

var base: Ability

func get_ability_battle(character: Character) -> AbilityBattle:
	return AbilityBattle.new(self, character)
