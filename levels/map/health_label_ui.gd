extends Label


func _ready() -> void:
	pass


func _process(_delta: float) -> void:
	text = "Health: " + str(GameManager.state.health) + "/" + str(GameManager.state.max_health)
