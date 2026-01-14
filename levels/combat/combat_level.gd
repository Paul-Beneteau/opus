class_name CombatLevel
extends Node

signal combat_ended()
@onready var combat_manager: CombatManager = $CombatManager
@onready var enemies_panel: HBoxContainer = $EnemiesPanel

const STANDARD_ENEMIES_SCENE = preload("res://characters/enemy/wolf/wolf.tscn")
const ELITE_ENEMIES_SCENE = preload("res://characters/enemy/elite_wolf/elite_wolf.tscn")


func _ready() -> void:
	combat_manager.combat_ended.connect(_on_combat_ended)


func spawn_standard_enemies() -> void:
	for i in 2:
		var standard_enemy = STANDARD_ENEMIES_SCENE.instantiate()
		enemies_panel.add_child(standard_enemy)


func spawn_elite_enemy() -> void:
	var elite_enemy = ELITE_ENEMIES_SCENE.instantiate()
	enemies_panel.add_child(elite_enemy)
		

func _on_combat_ended() -> void:
	GameManager.state.health = $Player.health_comp.health
	GameManager.state.max_health = $Player.health_comp.max_health
	GameManager.save_game()
	combat_ended.emit()
