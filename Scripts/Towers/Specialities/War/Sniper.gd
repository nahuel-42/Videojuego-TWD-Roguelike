class_name Sniper
extends War

func _ready():
	super()
	id = -1
	var stats = {
		"range": 250,
		"damage": 5,
		"attackSpeed": 0.5,
		"accuracy": 1
	}
	tower.load_stats(stats)
	label.text = "Sniper (S)"

func apply_effects(enemy):
	pass
