class_name CardInstance
extends Resource

var card_data: CardData
var cost_modifier: int = 0
var is_upgraded: bool = false


func _init(data: CardData = null) -> void:
	card_data = data
