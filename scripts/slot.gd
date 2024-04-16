extends Node2D

enum Type {
	TOWER,
	PASSIVE
}

var type
var child
var tower_point

const TOWER_PREFAB_PATH = "res://prefabs/tower.tscn"

func _ready():
	tower_point = $TowerPoint
	type = Type.TOWER
	# Este método debería invocarlo la carta, pasando por parámetro el correspondiente prefab
	create_tower(load(TOWER_PREFAB_PATH))

func check_card():
	pass
	
func apply_card():
	pass
	
func delete():
	pass
	
func create_tower(tower_prefab):
	child = tower_prefab.instantiate()
	add_child(child)
	child.position = tower_point.position
