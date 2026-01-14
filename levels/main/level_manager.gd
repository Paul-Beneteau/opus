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
	
	if current_scene.has_signal("room_clicked"):
		current_scene.room_clicked.connect(_on_room_clicked)
	if current_scene.has_signal("combat_ended"):
		current_scene.combat_ended.connect(_on_combat_ended)


func _on_room_clicked(room_type: MapLevel.RoomType):		
	load_scene(combat_level_path)
	match room_type:
		MapLevel.RoomType.STANDARD_ENEMIES:
			current_scene.spawn_standard_enemies()
		MapLevel.RoomType.ELITE_ENEMY:
			current_scene.spawn_elite_enemy()


func _on_combat_ended():	
	load_scene(map_level_path)
