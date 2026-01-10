extends ColorRect

@export var card_manager: CardManager

func _ready() -> void:
	card_manager.discard_pile_changed.connect(_on_card_manager_discard_pile_changed)
	refresh()
	
func refresh() -> void:
	var discard_pile_size = card_manager.discard_pile.size()
	$DiscardPileLabel.text = str(discard_pile_size)
	
func _on_card_manager_discard_pile_changed() -> void:
	refresh()
