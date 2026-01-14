class_name CombatManager
extends Node

signal combat_ended()

@onready var card_manager: CardManager = $"../CardManager"
@onready var hand_ui: HandUI = $"../HandUI"
@onready var targeting_manager: TargetingManager = $"../TargetingManager"
@onready var turn_manager: TurnManager = $"../TurnManager"
@onready var end_turn_button: Button = $"../EndTurnButton"
@onready var player: Player = $"../Player"
var enemies_alive_count: int = 0

func _ready() -> void:
	call_deferred("start_combat")
	var enemies = get_tree().get_nodes_in_group("enemies")
	for enemy in enemies:
		if enemy is Enemy:
			enemies_alive_count += 1
			enemy.die.connect(_on_enemy_die)

func start_combat() -> void:
	var enemies = get_tree().get_nodes_in_group("enemies")
	for enemy in enemies:
		if enemy is Enemy:
			enemies_alive_count += 1
			enemy.die.connect(_on_enemy_die)
	_register_targets()
	_connect_signals()
	turn_manager.start_player_turn()


func _connect_signals() -> void:
	hand_ui.held_card_released.connect(_on_held_card_released)
	end_turn_button.pressed.connect(_on_end_turn_pressed)
	turn_manager.player_turn_started.connect(_on_player_turn_started)
	turn_manager.enemy_turn_started.connect(_on_enemy_turn_started)


func _on_held_card_released(card_index: int) -> void:
	if not turn_manager.is_player_turn():
		return

	var target = targeting_manager.current_target
	if target:
		card_manager.play_card_on_target(target, card_manager.hand[card_index])


func _on_end_turn_pressed() -> void:
	if turn_manager.is_player_turn():
		turn_manager.end_player_turn()


func _on_player_turn_started() -> void:
	end_turn_button.disabled = false
	card_manager.discard_hand()
	card_manager.draw_cards(5)
	print("=== PLAYER TURN ===")


func _on_enemy_turn_started() -> void:
	end_turn_button.disabled = true
	print("=== ENEMY TURN ===")
	await _execute_enemy_turns()
	turn_manager.end_enemy_turn()


func _execute_enemy_turns() -> void:
	var enemies = get_tree().get_nodes_in_group("enemies")
	for enemy in enemies:
		if enemy is Enemy:
			await enemy.play_turn(player)
			await get_tree().create_timer(0.8).timeout


func _register_targets() -> void:
	var enemies = get_tree().get_nodes_in_group("enemies")
	for enemy in enemies:
		targeting_manager.register_target(enemy)
	
func _on_enemy_die() -> void:
	print("die")
	enemies_alive_count -= 1
	print(str(enemies_alive_count))
	if enemies_alive_count == 0:
		combat_ended.emit()
