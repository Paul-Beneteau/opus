class_name Player
extends Control

@onready var health_comp: HealthComponent = $HealthComponent
@onready var health_bar: = $PlayerTexture/HealthBarUI


func _ready() -> void:	
	health_comp.health_changed.connect(health_bar.refresh)
	health_comp.max_health_changed.connect(health_bar.refresh)
	health_comp.health = GameManager.state.health
	health_comp.max_health = GameManager.state.max_health
	health_bar.refresh(health_comp.health, health_comp.max_health)
