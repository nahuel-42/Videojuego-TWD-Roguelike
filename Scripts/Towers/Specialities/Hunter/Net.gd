class_name Net
extends Hunter

func _ready():
	super()
	id = -1
	label.text = "Net (H)"

func apply_effects(enemy):
	enemy.start_slow()
