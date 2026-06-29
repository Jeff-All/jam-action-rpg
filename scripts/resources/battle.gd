class_name Battle

extends Resource

var party: Array[CharacterBattle]
var campaign: Campaign
var options: BattleOptions

func build(_campaign: Campaign, _battle_options: BattleOptions):
	campaign = _campaign
	options = _battle_options
	
	build_party()

func build_party():
	for cur in campaign.party:
		party.append(cur.get_character_battle())
