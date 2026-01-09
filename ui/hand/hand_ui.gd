extends Control

@export var card_manager: CardManager
@export var card_ui: PackedScene
@onready var card_container = $CardContainer

func _ready() -> void:
	card_manager.hand_changed.connect(_on_hand_changed)

func _on_hand_changed() -> void:
	var card_ui_instance = card_ui.instantiate()
	card_container.add_child(card_ui_instance)
