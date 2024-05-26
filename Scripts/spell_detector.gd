extends Node2D
class_name SpellDetector

const FIREBALL_PREFAB = "res://Prefabs/Spells/Fireball.tscn"

# Called when the node enters the scene tree for the first time.
func _ready():
	print($Area2D/CollisionShape2D.shape.size)
	$Area2D/CollisionShape2D.shape.size = get_viewport_rect().size
	position = get_viewport_rect().size /2

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_area_2d_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.pressed:
		print("viewport ", viewport.size)
		var prefab = load(FIREBALL_PREFAB)
		var spell = prefab.instantiate()
		add_child(spell)
		spell.load_stats(event.position)
		print("Detectando click en el area 2D en ", event.position)

