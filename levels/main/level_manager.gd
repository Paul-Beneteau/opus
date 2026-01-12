extends Node

@onready var main_level: Node = $".."
var current_scene: Node
var map_level_path: String = "res://levels/map/map_level.tscn"
var combat_level_path: String = "res://levels/combat/combat_level.tscn"


func _ready():
	load_scene(map_level_path)


func load_scene(scene_path: String):	
	if current_scene:
		current_scene.queue_free()
	
	var scene = load(scene_path)
	current_scene = scene.instantiate()
	add_child(current_scene)
	
	if current_scene.has_signal("combat_requested"):
		current_scene.combat_requested.connect(_on_combat_requested)
	if current_scene.has_signal("combat_ended"):
		current_scene.combat_ended.connect(_on_combat_ended)


func _on_combat_requested():		
	load_scene(combat_level_path)


func _on_combat_ended():	
	load_scene(map_level_path)
