class_name Harpoon
extends Hunter

func _ready():
	super()
	id = -1

func apply_effects(enemy):
	enemy.start_vulnerable()
