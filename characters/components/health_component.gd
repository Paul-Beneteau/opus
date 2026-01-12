class_name HealthComponent
extends Node

signal health_changed(health: int, max_health: int)
signal max_health_changed(health: int, max_health: int)
signal die

var health: int = 10
var max_health : int = 10


func get_health() -> int:
	return health


func get_max_health() -> int:
	return max_health
	
	
func add_health(delta: int) -> void:
	var previous_health = health
	health = clamp(health + delta, 0, max_health)
	if health != previous_health:
		health_changed.emit(health, max_health)
		if health == 0:
			die.emit()


func add_max_health(delta: int) -> void:
	var previous_max_health = max_health
	max_health = max(max_health + delta, 0)
	if max_health != previous_max_health:
		max_health_changed.emit(health, max_health)
