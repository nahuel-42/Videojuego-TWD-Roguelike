class_name Soldier
extends Enemy

var is_boosted = false
var speed_boosted = 100
var original_speed
var max_health = 5 #vida maxima

func set_group():
	add_to_group(Parameters.GROUPS.SOLDIER)

func heal(healing):
	if health + healing > max_health:
		health = max_health
		health_bar.value = max_health
	else:
		health += healing
		health_bar.value = health

func boost_speed():
	is_boosted = true
	original_speed = speed
	speed = speed_boosted

func decrease_speed():
	is_boosted = false
	speed = original_speed
