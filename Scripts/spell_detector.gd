extends Node2D
class_name SpellDetector

const FIREBALL_PREFAB = "res://Prefabs/Spells/Fireball.tscn"
var size : Vector2
@onready var map = $"../TileMap"

# Called when the node enters the scene tree for the first time.
func _ready():
	size = Vector2(map.width * map.CELL_DIMENSION, map.height * map.CELL_DIMENSION)
	$Area2D/CollisionShape2D.shape.size = size
	position = size / 2

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_area_2d_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.pressed:
		var prefab = load(FIREBALL_PREFAB)
		var spell = prefab.instantiate()
		add_child(spell)
		spell.load_stats(get_global_mouse_position(), map.CELL_DIMENSION)
		print("Se clickeo en: " + str(event.global_position))
		print("Se clickeo en (mouse): " + str(get_global_mouse_position()))

