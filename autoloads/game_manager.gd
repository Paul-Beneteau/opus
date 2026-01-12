extends Node

const SAVE_PATH := "user://save.tres"

var state: GameState

func _ready() -> void:
	new_game()

func new_game() -> void:
	state = GameState.new()

func save_game() -> void:
	ResourceSaver.save(state, SAVE_PATH)

func load_game() -> bool:
	if ResourceLoader.exists(SAVE_PATH):
		state = ResourceLoader.load(SAVE_PATH)
		return true
	return false

func has_save() -> bool:
	return ResourceLoader.exists(SAVE_PATH)
