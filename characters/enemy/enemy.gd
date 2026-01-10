class_name Enemy
extends Control

#TODO: fix 2d scene and remove these signal to use default mouse_entered/exited
signal mouse_hovered(target: Node)
signal mouse_unhovered(target: Node)

@onready var health_comp: HealthComponent = $HealthComponent
@onready var health_bar: = $EnemyTexture/HealthBarUI
@onready var highlight_target = $EnemyTexture/HighlightTarget

func _ready() -> void:
	health_comp.health_changed.connect(
		func(h): health_bar.refresh(h, health_comp.get_health(), health_comp.get_max_health())
	)
	health_bar.refresh(health_comp.get_health(), health_comp.get_max_health())

	health_comp.health_changed.connect(health_bar.refresh)
	mouse_entered.connect(_on_mouse_entered)
	mouse_exited.connect(_on_mouse_exited)


func _on_mouse_entered() -> void:
	highlight_target.visible = true
	mouse_hovered.emit(self)


func _on_mouse_exited() -> void:
	highlight_target.visible = false
	mouse_unhovered.emit(self)
