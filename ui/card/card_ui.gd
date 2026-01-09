extends Control

var default_scale := Vector2(1, 1)
var zoom_scale := Vector2(1.2, 1.2)
var time := 0.1

func _ready():
	pivot_offset = size / 2 

func _on_texture_rect_mouse_entered():	
	var tween = create_tween()
	tween.tween_property(self, "scale", zoom_scale, time)

func _on_texture_rect_mouse_exited():	
	var tween = create_tween()
	tween.tween_property(self, "scale", default_scale, time)
