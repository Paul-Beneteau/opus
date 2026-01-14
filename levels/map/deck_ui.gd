extends Control

@export var card_ui_scene: PackedScene
@onready var grid: GridContainer = $ScrollContainer/CardGrid
@onready var return_button: Button = $ReturnButton


func _ready() -> void:
	return_button.pressed.connect(func(): queue_free())
	display_deck()

func display_deck() -> void:
	for card_instance in GameManager.state.deck:		
		var card_ui = card_ui_scene.instantiate()
		if card_ui.has_method("initialize"):
			card_ui.initialize(card_instance)
		grid.add_child(card_ui)
