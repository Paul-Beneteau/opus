class_name HealthBarUI
extends ProgressBar

@onready var health_label: Label = $HealthLabel

func refresh(health: int, max_health: int) -> void:
	if max_health != 0:
		value = (float(health) / max_health) * 100
		health_label.text = str(health) + "/" + str(max_health)
