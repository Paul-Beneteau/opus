class_name CardManager
extends Node

signal hand_changed
signal draw_pile_changed
signal discard_pile_changed
signal card_drawn(card: CardInstance)
signal card_discarded(card: CardInstance)
signal card_played(card: CardInstance)

@export var initial_deck: Array[CardData] = []

var _deck: Array[CardInstance] = []
var _hand: Array[CardInstance] = []
var _draw_pile: Array[CardInstance] = []
var _discard_pile: Array[CardInstance] = []

# Getter/Setter

func get_draw_pile() -> Array[CardInstance]:
	return _draw_pile


func get_hand() -> Array[CardInstance]:
	return _hand


func get_discard_pile() -> Array[CardInstance]:
	return _discard_pile


func get_draw_pile_count() -> int:
	return _draw_pile.size()


func get_hand_count() -> int:
	return _hand.size()


func get_discard_pile_count() -> int:
	return _discard_pile.size()

# endregion

# Setup

func initialize() -> void:
	_deck.clear()
	_draw_pile.clear()
	_hand.clear()
	_discard_pile.clear()
	
	for data in initial_deck:
		if data:
			var card := CardInstance.new(data)
			_deck.append(card)
	
	_draw_pile = _deck.duplicate()
	shuffle_draw_pile()
	
	draw_pile_changed.emit()

# endregion

# region Actions

func shuffle_draw_pile() -> void:
	_draw_pile.shuffle()
	draw_pile_changed.emit()


func draw_cards(count: int) -> void:
	for i in count:
		draw_single_card()


func draw_single_card() -> CardInstance:
	if _draw_pile.is_empty():
		shuffle_discard_into_draw_pile()
	
	if _draw_pile.is_empty():
		return null
	
	var card: CardInstance = _draw_pile.pop_back()
	_hand.append(card)
	
	card_drawn.emit(card)
	draw_pile_changed.emit()
	hand_changed.emit()
	
	return card


func discard_card(card: CardInstance) -> void:
	if not card:
		return
	
	var index := _hand.find(card)
	if index == -1:
		push_warning("CardManager: Card not found in hand")
		return
	
	_hand.remove_at(index)
	_discard_pile.append(card)
	
	card_discarded.emit(card)
	hand_changed.emit()
	discard_pile_changed.emit()


func discard_hand() -> void:
	while not _hand.is_empty():
		var card: CardInstance = _hand.pop_back()
		_discard_pile.append(card)
		card_discarded.emit(card)
	
	hand_changed.emit()
	discard_pile_changed.emit()


func play_card(card: CardInstance) -> void:
	if not card:
		return
	
	var index := _hand.find(card)
	if index == -1:
		push_warning("CardManager: Card not found in hand")
		return
	
	_hand.remove_at(index)
	_discard_pile.append(card)
	
	card_played.emit(card)
	hand_changed.emit()
	discard_pile_changed.emit()


func shuffle_discard_into_draw_pile() -> void:
	if _discard_pile.is_empty():
		return
	
	_draw_pile.append_array(_discard_pile)
	_discard_pile.clear()
	
	shuffle_draw_pile()
	discard_pile_changed.emit()

# endregion
