class_name TurnManager
extends Node

enum TurnState {
	PLAYER_TURN,
	ENEMY_TURN,
}

signal turn_started(state: TurnState)
signal turn_ended(state: TurnState)
signal player_turn_started
signal player_turn_ended
signal enemy_turn_started
signal enemy_turn_ended

var current_state: TurnState = TurnState.PLAYER_TURN


func start_player_turn() -> void:
	current_state = TurnState.PLAYER_TURN
	turn_started.emit(current_state)
	player_turn_started.emit()


func end_player_turn() -> void:
	turn_ended.emit(current_state)
	player_turn_ended.emit()
	start_enemy_turn()


func start_enemy_turn() -> void:
	current_state = TurnState.ENEMY_TURN
	turn_started.emit(current_state)
	enemy_turn_started.emit()


func end_enemy_turn() -> void:
	turn_ended.emit(current_state)
	enemy_turn_ended.emit()
	start_player_turn()


func is_player_turn() -> bool:
	return current_state == TurnState.PLAYER_TURN


func is_enemy_turn() -> bool:
	return current_state == TurnState.ENEMY_TURN
