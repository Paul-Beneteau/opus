class_name CardUI
extends Control

signal card_picked(card_index: int)
signal card_released(card_index: int)

@onready var description_label: Label = $CardTexture/DescriptionLabel
var is_card_held: bool = false
var default_position := Vector2(1, 1)
var default_scale := Vector2(1, 1)
var zoom_scale := Vector2(1.2, 1.2)
var held_card_scale := Vector2(0.8, 0.8)
var time := 0.1
	
	
func _ready():	
	mouse_entered.connect(_handle_mouse_entered)
	mouse_exited.connect(_handle_mouse_exited)
	gui_input.connect(_handle_gui_input)
	card_picked.connect(_handle_card_picked)
	card_released.connect(_handle_card_released)	
	
	await get_tree().process_frame
	default_position = global_position


func initialize(card_instance: CardInstance) -> void:
	if not is_node_ready():
		await ready
	description_label.text = card_instance.get_description()


func _handle_mouse_entered() -> void:
	if not is_card_held:
				create_tween().tween_property(self, "scale", zoom_scale, time)


func _handle_mouse_exited() -> void:
	if not is_card_held:
				create_tween().tween_property(self, "scale", default_scale, time)


func _handle_gui_input(event: InputEvent):	
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if  event.pressed:
			card_picked.emit(get_index())
		else:
			card_released.emit(get_index())


func _handle_card_picked(_card_index: int) -> void:
	is_card_held = true
	var tween = create_tween()
	tween.tween_property(self, "scale", held_card_scale, time)


func _handle_card_released(_card_index: int) -> void:
	is_card_held = false
	var tween = create_tween()
	tween.set_trans(Tween.TRANS_QUINT)
	tween.set_ease(Tween.EASE_OUT)
	tween.tween_property(self, "global_position", default_position, 0.2)
	tween.tween_property(self, "scale", default_scale, time)


func _process(_delta: float) -> void:
	if is_card_held:
		var target_pos = get_global_mouse_position() - (size * scale / 2)
		global_position = global_position.lerp(target_pos, 25 * _delta)
