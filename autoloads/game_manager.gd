extends Node

const SAVE_PATH := "user://save.tres"

var initial_deck: InitialDeck = preload("res://cards/ressources/initial_deck.tres")
var state: GameState

func _ready() -> void:
	new_game()

func new_game() -> void:
	state = GameState.new()
	_initialize_deck()

func _initialize_deck():
	state.deck.clear()	
	for card_data in initial_deck.initial_deck:
		var card = CardInstance.new(card_data)
		state.deck.append(card)
		
func save_game() -> void:
	ResourceSaver.save(state, SAVE_PATH)

func load_game() -> bool:
	if ResourceLoader.exists(SAVE_PATH):
		state = ResourceLoader.load(SAVE_PATH)
		return true
	return false

func has_save() -> bool:
	return ResourceLoader.exists(SAVE_PATH)
