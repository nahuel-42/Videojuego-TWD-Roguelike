extends Node2D
class_name SpellDetector

const FIREBALL_PREFAB = "res://Prefabs/Spells/Fireball.tscn"

# Called when the node enters the scene tree for the first time.
func _ready():
	$Area2D/CollisionShape2D.shape.size = get_viewport().size
	position = get_viewport_rect().size /2

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_area_2d_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.pressed:
		var prefab = load(FIREBALL_PREFAB)
		var spell = prefab.instantiate()
		add_child(spell)
		spell.load_stats(event.position)

func _on_area_2d_body_entered(body):
	print("Enemy detected")
	$Fireball.set_process(false)
