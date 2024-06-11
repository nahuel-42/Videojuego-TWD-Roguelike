extends Node2D
class_name SpellDetector

const FIREBALL_PREFAB = "res://Prefabs/Spells/Fireball.tscn"
const ICEBALL_PREFAB = "res://Prefabs/Spells/Iceball.tscn"
var size : Vector2
@onready var map = $"../TileMap"

func _init():
	GameEvents.OnSpellCardActivated.AddListener(SpellCardActivated)
func _exit_tree():
	GameEvents.OnSpellCardActivated.RemoveListener(SpellCardActivated)

func _ready():
	size = Vector2(map.width * map.CELL_DIMENSION, map.height * map.CELL_DIMENSION)
	$Area2D/CollisionShape2D.shape.size = size
	position = size / 2
	

func _on_area_2d_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.pressed and (event.button_index == MOUSE_BUTTON_RIGHT or event.button_index == MOUSE_BUTTON_MIDDLE):
		var prefab = load(FIREBALL_PREFAB if event.button_index == MOUSE_BUTTON_RIGHT else ICEBALL_PREFAB)
		var spell = prefab.instantiate()
		add_child(spell)
		spell.load_stats(get_global_mouse_position(), map.CELL_DIMENSION)

func SpellCardActivated(param):
	var type = param[0]
	var pos = param[1]
	var range = param[2]
	var damage = param[3]
	var amount = param[4]
	
	var rng = RandomNumberGenerator.new()
	
	for i in range(amount):
		var prefab = load(FIREBALL_PREFAB if type == "Fireball" else ICEBALL_PREFAB)
		var spell = prefab.instantiate()
		add_child(spell)
		
		var rx : float = 0#rng.randf_range(-range, range) / 2.0
		var ry : float = 0#rng.randf_range(-range, range) / 2.0
		
		spell.load_stats(pos + Vector2(rx, ry), map.CELL_DIMENSION)
