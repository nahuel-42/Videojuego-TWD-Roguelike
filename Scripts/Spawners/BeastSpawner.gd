class_name BeastSpawner
extends EnemiesSpawner


# Called when the node enters the scene tree for the first time.
func _ready():
	ENEMY_TYPES = Parameters.BEAST_TYPES
	super._ready()
