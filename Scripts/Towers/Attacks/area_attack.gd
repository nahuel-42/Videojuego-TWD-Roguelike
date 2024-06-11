class_name AreaAttackMethod
extends OneTargetAttackMethod

@onready var DYNAMITE_PREFAB : String = "res://Prefabs/Towers/Dynamite.tscn"

func fire():
	if current_target != null and current_target in enemies_in_range:
		throw_dynamite()
		cooldown = 1 / get_attack_speed()

func throw_dynamite():
	var dynamite : Dynamite = load(DYNAMITE_PREFAB).instantiate()
	dynamite.set_target(current_target.global_position)
	dynamite.set_speciality(speciality)
	dynamite.set_damage(get_damage())
	add_child(dynamite)

