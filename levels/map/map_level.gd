class_name MapLevel
extends Node

signal room_clicked(room_type: RoomType)

enum RoomType {
	STANDARD_ENEMIES,
	ELITE_ENEMY,
	SHOP,
}


func _ready() -> void:
	_initialize_map()


func _initialize_map() -> void:
	var standard_enemy_buttons = get_tree().get_nodes_in_group("standard_enemy_button")
	for standard_enemy_button in standard_enemy_buttons:
		standard_enemy_button.pressed.connect(_on_standard_enemy_button_clicked.bind(standard_enemy_button))
		if standard_enemy_button.name in GameManager.state.visited_rooms:
			standard_enemy_button.disabled = true

	var boss_enemy_buttons = get_tree().get_nodes_in_group("boss_enemy_button")
	for boss_enemy_button in boss_enemy_buttons:
		boss_enemy_button.pressed.connect(_on_boss_enemy_button_clicked.bind(boss_enemy_button))
		if boss_enemy_button.name in GameManager.state.visited_rooms:
			boss_enemy_button.disabled = true
			

func _on_standard_enemy_button_clicked(standard_enemy_button: Button):
	standard_enemy_button.disabled = true
	if standard_enemy_button.name not in GameManager.state.visited_rooms:
		GameManager.state.visited_rooms.append(standard_enemy_button.name)
	GameManager.save_game()
	room_clicked.emit(RoomType.STANDARD_ENEMIES)


func _on_boss_enemy_button_clicked(boss_enemy_button: Button):
	boss_enemy_button.disabled = true
	if boss_enemy_button.name not in GameManager.state.visited_rooms:
		GameManager.state.visited_rooms.append(boss_enemy_button.name)
	GameManager.save_game()
	room_clicked.emit(RoomType.ELITE_ENEMY)
