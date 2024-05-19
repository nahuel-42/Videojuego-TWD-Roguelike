class_name AreaAttackMethod
extends OneTargetAttackMethod

@onready var area_cs : CollisionShape2D = $"../Area2D/CollisionShape2D"

func _onready():
	area_cs.disabled = true

func fire():
	if current_target != null and current_target in enemies_in_range:
		get_parent().modulate = Color(1, 0, 0)
		area_cs.global_position = current_target.global_position
		hit_main_target()
		cooldown = attack_speed
		
	set_new_target()

# TODO: Llamar al finalizar la animación de ataque.
func hit_main_target():
	area_cs.disabled = false
	
func hit_targets(body):
	speciality.act(body, damage)

