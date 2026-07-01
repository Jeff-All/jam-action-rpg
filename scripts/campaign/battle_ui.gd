class_name BattleUI

extends Control

@export var play_button_texture: Texture2D
@export var pause_button_texture: Texture2D

var play_button: SimpleButton
var chrono_controller: ChronoController

var front_row: Array[EnemyUI]
var back_row: Array[EnemyUI]
var pcs: Array[PCUI]
var battle: Battle

var state: State = State.BASE

enum State {BASE, ABILITY_SELECTED}

var selected_ability_button: AbilityButton
var selected_pc: PCUI

func _ready():
	play_button = $MarginContainer/PlayButton
	chrono_controller = $ChronoController
	
	for cur in $Foreground/VBoxContainer2/Enemies/FrontRow.get_children():
		front_row.append(cur)
	
	for cur in $Foreground/VBoxContainer2/Enemies/BackRow.get_children():
		back_row.append(cur)
	
	for cur in $Foreground/VBoxContainer2/PCs.get_children():
		pcs.append(cur)

func process_step():
	for cur in pcs:
		cur.process_step()

func _chono_controller_on_process_step():
	process_step()

func setup_battle(_battle: Battle):
	battle = _battle
	setup_enemies()
	setup_party()
	
	go_to_base_state()

func setup_enemies():
	hide_enemies()
	setup_enemy_row(front_row, battle.front_row)
	setup_enemy_row(back_row, battle.back_row)

func hide_enemies():
	for cur in front_row:
		cur.visible = false
	for cur in back_row:
		cur.visible = false

func setup_enemy_row(row: Array[EnemyUI], enemies: Array[EnemyBattle]):
	var index = 0
	for cur in enemies: 
		if index >= row.size():
			break
		row[index].enemy = cur
		row[index].visible = true
		index += 1

func setup_party():
	hide_pcs()
	var index = 0
	for cur in battle.party:
		if index > pcs.size():
			break
		pcs[index].character = cur
		pcs[index].visible = true
		index += 1

func hide_pcs():
	for cur in pcs:
		cur.visible = false

func go_to_base_state():
	state = State.BASE
	clear_targeting()
	for cur in pcs:
		for cur_ability in cur.abilities:
			cur_ability.selected = false

func _pcui_on_ability_pressed(_pcui: PCUI, ability_button: AbilityButton):
	if state == State.ABILITY_SELECTED:
		selected_ability_button.selected = false
	ability_button.selected = true
	selected_ability_button =  ability_button
	selected_pc = _pcui
	
	target_ability(_pcui, ability_button.ability)
	
	state = State.ABILITY_SELECTED

func target_ability(_pcui: PCUI, ability: Ability):
	clear_targeting()
	
	match ability.targeting:
		Ability.Targeting.SELF:
			target_self(_pcui)
		Ability.Targeting.ALLIES:
			target_allies(_pcui)
		Ability.Targeting.PARTY:
			target_party()
		Ability.Targeting.MELEE:
			target_melee()
		Ability.Targeting.RANGED:
			target_ranged()
		Ability.Targeting.ALL:
			target_all()

func clear_targeting():
	for cur in pcs:
		cur.clickable = false
	for cur in front_row:
		cur.clickable = false
	for cur in back_row:
		cur.clickable = false

func target_self(_self: PCUI):
	_self.clickable = true

func target_allies(_self: PCUI):
	for cur in pcs:
		if cur != _self:
			cur.clickable = true

func target_party():
	for cur in pcs:
		cur.clickable = true

func target_melee():
	var front_has = false
	if front_row.size() > 0:
		for cur in front_row:
			if cur._enemy != null && !cur._enemy.dead:
				cur.clickable = true
				front_has = true
	if !front_has:
		for cur in back_row:
			if cur._enemy != null && !cur._enemy.dead:
				cur.clickable = true

func target_ranged():
	for cur in front_row:
		if cur._enemy != null && !cur._enemy.dead:
			cur.clickable = true
	for cur in back_row:
		if cur._enemy != null && !cur._enemy.dead:
			cur.clickable = true

func target_all():
	target_party()
	target_ranged()

func _enemy_ui_on_pressed(enemy_ui: EnemyUI, _row_index: int, _index: int):
	match state:
		State.ABILITY_SELECTED:
			process_ability_use_on_enemy(enemy_ui)

func process_ability_use_on_enemy(_enemy_ui: EnemyUI):
	selected_ability_button.ability.execute(selected_ability_button, selected_pc, _enemy_ui)
	go_to_base_state()

func _on_play_button_pressed(simple_button: SimpleButton):
	if chrono_controller.play_pause():
		simple_button.texture_rect.texture = play_button_texture
	else:
		simple_button.texture_rect.texture = pause_button_texture
