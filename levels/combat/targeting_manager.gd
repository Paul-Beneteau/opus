class_name TargetingManager
extends Node

var current_target: Node


func register_target(target: Node) -> void:
	target.mouse_hovered.connect(_on_target_hovered)
	target.mouse_unhovered.connect(_on_target_unhovered)


func _on_target_hovered(target: Node) -> void:
	current_target = target


func _on_target_unhovered(target: Node) -> void:
	if current_target == target:
		current_target = null
