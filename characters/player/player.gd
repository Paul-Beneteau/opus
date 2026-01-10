class_name Player
extends Control

@onready var health_comp: HealthComponent = $HealthComponent
@onready var health_bar: = $PlayerTexture/HealthBarUI


func _ready() -> void:	
	health_comp.health_changed.connect(
		func(h): health_bar.refresh(h, health_comp.get_health(), health_comp.get_max_health())
	)	
	health_bar.refresh(health_comp.get_health(), health_comp.get_max_health())
	
	health_comp.health_changed.connect(health_bar.refresh)
