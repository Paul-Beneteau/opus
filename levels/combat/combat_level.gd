extends Node

signal combat_ended()
@onready var combat_manager: CombatManager = $CombatManager

func _ready() -> void:
	combat_manager.combat_ended.connect(_on_combat_ended)


func _on_combat_ended() -> void:
	GameManager.state.health = $Player.health_comp.health
	GameManager.state.max_health = $Player.health_comp.max_health
	GameManager.save_game()
	combat_ended.emit()
