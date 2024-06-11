class_name Harpoon
extends Hunter

func _ready():
	super()
	id = -1
	label.text = "Harpoon (H)"

func apply_effects(enemy):
	enemy.start_vulnerable()
