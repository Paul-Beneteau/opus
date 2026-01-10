class_name CombatManager
extends Node

@onready var card_manager: CardManager = $"../CardManager"
@onready var hand_ui: HandUI = $"../HandUI"
@onready var targeting_manager: TargetingManager = $"../TargetingManager"


func _ready() -> void:
	call_deferred("_start_combat")


func _start_combat() -> void:
	_register_targets()
	hand_ui.held_card_released.connect(_on_held_card_released)
	card_manager.draw_cards(5)


func _on_held_card_released(card_index: int) -> void:
	var target = targeting_manager.current_target
	if target:
		card_manager.play_card_on_target(target, card_manager.hand[card_index])


func _register_targets() -> void:
	var enemies = get_tree().get_nodes_in_group("enemies")
	for enemy in enemies:
		targeting_manager.register_target(enemy)
	
