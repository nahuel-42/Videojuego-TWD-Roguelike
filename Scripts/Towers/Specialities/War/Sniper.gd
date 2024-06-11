class_name Sniper
extends War

func _ready():
	super()
	id = -1
	var stats = {
		"range": 100,
		"damage": 5,
		"attackSpeed": 0.5,
		"accuracy": 0.1
	}
	tower.load_stats(stats)

func apply_effects(enemy):
	pass
