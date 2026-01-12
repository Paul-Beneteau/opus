class_name CardData
extends Resource

enum CardType { ATTACK, SKILL, POWER }
enum CardRarity { COMMON, UNCOMMON, RARE }

@export var card_id: StringName
@export var display_name: String
@export_multiline var description: String

@export var card_type: CardType = CardType.ATTACK
@export var rarity: CardRarity = CardRarity.COMMON
@export_range(0, 10) var energy_cost: int = 1

@export var card_art: Texture2D

@export var damage_amount: int = 0
@export var block_amount: int = 0
@export var draw_amount: int = 0
