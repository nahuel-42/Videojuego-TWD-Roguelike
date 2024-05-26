class_name SoldierSpawner
extends EnemiesSpawner

# Called when the node enters the scene tree for the first time.
func _ready():
	ENEMY_TYPES = Parameters.SOLDIER_TYPES
	super._ready()
