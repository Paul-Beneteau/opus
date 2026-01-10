class_name HandUI
extends Control

signal held_card_picked(card_index: int)
signal held_card_released(card_index: int)

@export var card_ui: PackedScene
@onready var card_container : HBoxContainer = $CardContainer

		
func refresh(hand: Array[CardInstance]) -> void:		
	for child in card_container.get_children():
		child.queue_free()

	for card in hand:
		var card_ui_instance: CardUI = card_ui.instantiate()
		card_ui_instance.initialize(card)
		card_container.add_child(card_ui_instance)		
		card_ui_instance.card_picked.connect(_on_card_held_picked)
		card_ui_instance.card_released.connect(_on_card_held_released)


func _on_card_held_picked(card_index: int) -> void:
	held_card_picked.emit(card_index)

func _on_card_held_released(card_index: int) -> void:
	held_card_released.emit(card_index)
