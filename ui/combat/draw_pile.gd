extends ColorRect

@export var card_manager: CardManager

func _ready() -> void:
	card_manager.draw_pile_changed.connect(_on_card_manager_draw_pile_changed)
	
func _on_card_manager_draw_pile_changed() -> void:
	var draw_pile_size = card_manager.get_draw_pile().size()
	$DrawPileLabel.text = str(draw_pile_size)
