extends Button


func _ready() -> void:
	pressed.connect(_on_deck_button_pressed)


func _on_deck_button_pressed() -> void:
	var deck_ui_scene = load("res://levels/map/deck_ui.tscn")
	var deck_ui_instance = deck_ui_scene.instantiate()
	get_tree().current_scene.add_child(deck_ui_instance)
