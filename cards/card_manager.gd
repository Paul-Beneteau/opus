class_name CardManager
extends Node
		
signal hand_changed
signal draw_pile_changed
signal discard_pile_changed
signal card_played(card: CardInstance)

@onready var hand_ui: HandUI = $"../HandUI"
var hand: Array[CardInstance] = []
var draw_pile: Array[CardInstance] = []
var discard_pile: Array[CardInstance] = []


func _ready() -> void:
	hand_changed.connect(func(): hand_ui.refresh(hand))

				
	draw_pile = GameManager.state.deck.duplicate()
	shuffle_draw_pile()	


func shuffle_draw_pile() -> void:
	draw_pile.shuffle()
	draw_pile_changed.emit()


func draw_cards(count: int) -> void:
	for i in count:
		draw_single_card()


func draw_single_card() -> void:
	if draw_pile.is_empty():
		shuffle_discard_into_draw_pile()
	
	if draw_pile.is_empty():
		print("draw_single_card(): draw_pile is empty")
		return
	
	var card: CardInstance = draw_pile.pop_back()
	hand.append(card)
	
	draw_pile_changed.emit()
	hand_changed.emit()	


func discard_card(card: CardInstance) -> void:
	if not card:
		return
	
	var index := hand.find(card)
	if index == -1:
		push_warning("CardManager: Card not found in hand")
		return
	
	hand.remove_at(index)
	discard_pile.append(card)
	
	hand_changed.emit()
	discard_pile_changed.emit()


func discard_hand() -> void:
	while not hand.is_empty():
		var card: CardInstance = hand.pop_back()
		discard_pile.append(card)
	
	hand_changed.emit()
	discard_pile_changed.emit()


func play_card(card: CardInstance) -> void:
	if not card:
		return
	
	var index := hand.find(card)
	if index == -1:
		push_warning("CardManager: Card not found in hand")
		return
	
	hand.remove_at(index)
	discard_pile.append(card)
	
	card_played.emit(card)
	hand_changed.emit()
	discard_pile_changed.emit()


func shuffle_discard_into_draw_pile() -> void:
	if discard_pile.is_empty():
		return
	
	draw_pile.append_array(discard_pile)
	discard_pile.clear()
	
	shuffle_draw_pile()
	discard_pile_changed.emit()


func play_card_on_target(target: Node, card: CardInstance) -> void:
	_apply_card_effect(target, card)
	play_card(card)


func _apply_card_effect(target: Node, card: CardInstance) -> void:
	var health_comp := target.get_node_or_null("HealthComponent") as HealthComponent
	if not health_comp:
		push_warning("Target has no HealthComponent")
		return

	if card.card_data.damage_amount > 0:
		health_comp.add_health(-card.card_data.damage_amount)

	print("Dealt %d damage to %s" % [card.card_data.damage_amount, target.name])
