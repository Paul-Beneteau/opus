class_name CardInstance
extends RefCounted

var card_data: CardData
var cost_modifier: int = 0
var is_upgraded: bool = false


func _init(data: CardData = null) -> void:
	card_data = data


func get_current_energy_cost() -> int:
	if not card_data:
		return 0
	return maxi(0, card_data.energy_cost + cost_modifier)


func get_display_name() -> String:
	if not card_data:
		return ""
	return card_data.display_name


func get_description() -> String:
	if not card_data:
		return ""
	return card_data.description
