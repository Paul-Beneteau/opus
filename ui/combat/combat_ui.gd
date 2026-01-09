class_name CombatManager
extends Control

@onready var card_manager: CardManager = $CardManager

func _ready() -> void:
	start_combat()

func start_combat() -> void:
	card_manager.initialize()
	card_manager.draw_cards(5)
