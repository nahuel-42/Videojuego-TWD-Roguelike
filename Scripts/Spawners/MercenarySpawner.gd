class_name MercenarySpawner
extends EnemiesSpawner


# Called when the node enters the scene tree for the first time.
func _ready():
	ENEMY_TYPES = Parameters.MERCENARY_TYPES
	super._ready()

