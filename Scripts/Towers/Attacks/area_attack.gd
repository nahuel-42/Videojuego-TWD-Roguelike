class_name AreaAttackMethod
extends OneTargetAttackMethod

@onready var area_cs : CollisionShape2D = $"../Area2D/CollisionShape2D"
@onready var DYNAMITE_PREFAB : String = "res://Prefabs/Towers/Dynamite.tscn"

func _onready():
	area_cs.disabled = true

func fire():
	if current_target != null and current_target in enemies_in_range:
		area_cs.global_position = current_target.global_position
		throw_dynamite()
		cooldown = 1 / get_attack_speed()

func throw_dynamite():
	var dynamite : Dynamite = load(DYNAMITE_PREFAB).instantiate()
	dynamite.set_target(current_target.global_position)
	dynamite.set_cs(area_cs)
	add_child(dynamite)
	
func hit_targets(body):
	if body.is_in_group("Enemy"):
		speciality.act(body, get_damage())

