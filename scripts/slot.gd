extends Node2D

enum Type {
	TOWER,
	SPAWNER,
	PASSIVE
}

var type
var child
var tower_point

const TOWER_PREFAB_PATH = "res://prefabs/tower.tscn"
const DAMAGE_DECORATOR = "res://prefabs/damage_decorator.tscn"

func _ready():
	tower_point = $TowerPoint
	type = Type.TOWER
	# Este método debería invocarlo la carta, pasando por parámetro el correspondiente prefab
	
func _process(delta):
	if Input.is_action_just_released("upgrade_tower"):
		upgrade_tower()

func check_card():
	pass
	
func apply_card():
	pass
	
func delete():
	pass
	
# -------------- type TOWER -------------------------
func create_tower(tower_prefab):
	child = tower_prefab.instantiate()
	add_child(child)
	child.position = tower_point.position

func upgrade_tower():
	var decorator_prefab = load(DAMAGE_DECORATOR)
	var decorator_instance = decorator_prefab.instantiate()
	get_child(3).set("inner_tower",decorator_instance) 
	#print("no exploto")


func _on_click(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		if child == null:
			create_tower(load(TOWER_PREFAB_PATH))
		else:
			upgrade_tower()
