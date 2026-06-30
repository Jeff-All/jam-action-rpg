class_name Battle

extends Resource

var party: Array[CharacterBattle]
var campaign: Campaign
var options: BattleOptions
var front_row: Array[EnemyBattle]
var back_row: Array[EnemyBattle]

func build(_campaign: Campaign, _battle_options: BattleOptions):
	campaign = _campaign
	options = _battle_options
	
	build_party()
	build_enemies()

func build_party():
	for cur in campaign.party:
		party.append(cur.get_character_battle())

func build_enemies():
	build_enemy_row(front_row, options.front_row)
	build_enemy_row(back_row, options.back_row)

func build_enemy_row(row: Array[EnemyBattle], enemies: Array[Enemy]):
	for cur in enemies:
		row.append(cur.get_enemy_battle())
