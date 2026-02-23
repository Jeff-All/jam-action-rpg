class_name ShankAction

extends Action

@export var damage: int
@export var hit: int

func on_hover_target(attacker: Character, target: CharacterUI, battle_board: BattleBoard):
	var hit_chance = min(100, hit + ((attacker.attack - target.character.defense) * 5))
	var _attribute_damage = attacker.get_attribute(attribute)
	battle_board.tooltip.text = "Attacks Agility(%s) times\n%s%% chance to hit\n%s damage" %[attacker.agility, hit_chance, damage]
	battle_board.tooltip.visible = true

func on_pressed_target(attacker: Character, target: CharacterUI, battle_board: BattleBoard) -> bool:
	super(attacker, target, battle_board)
	for i in max(1, attacker.agility):
		if i > 0:
			await Global.get_tree().create_timer(0.2).timeout
		_attack(attacker, target, battle_board)
	return true

func _attack(attacker: Character, target: CharacterUI, battle_board: BattleBoard):
	var roll = randi_range(1,100)
	if roll < hit + attacker.attack - target.character.defense:
		target.character.take_damage_from_player_character(attacker, damage)
		battle_board.combat_text.show_combat_text(target.center, "%s" % damage)
	else:
		battle_board.combat_text.show_combat_text(target.center, "MISS")

func render_tooltip(attacker: PlayerCharacter, tooltip:ToolTip):
	var hit_chance = min(100, hit + (attacker.attack * 5))
	tooltip.text = "Attacks Agility(%s) times\n%s%% chance to hit\n%s damaage" % [attacker.agility, hit_chance, damage]
