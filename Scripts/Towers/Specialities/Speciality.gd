class_name Speciality
extends Node2D

const GROUPS = {
	BEAST = "Beast",
	SOLDIER = "Soldier",
	MERCENARY = "Mercenary",
	DRAKE = "Drake",
	CAPTAIN = "Captain"
}

func apply_effects(enemy):
	pass

func modify_damage(enemy, damage):
	return damage

func act(enemy, damage):
	damage = modify_damage(enemy, damage)
	#print(str(get_parent()) + " hace " + str(damage) + " daño a " + str(enemy.get_groups()))
	enemy.take_damage(damage)
	apply_effects(enemy)
