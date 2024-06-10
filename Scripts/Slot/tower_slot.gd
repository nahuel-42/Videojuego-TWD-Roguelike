extends Slot

#const CARDS_PATH = "res://cards/"
var current_card_id = -1
@onready var sprite : Sprite2D = $Area2D/Sprite2D 

func _ready():
	tower_point = $TowerPoint
	z_index = 2

# Si existía una torre, devuelve su ID, sino devuelve -1.
func apply_card(card):
	var previous_card_id = current_card_id
	match card.type:
		"tower":
			if current_card_id != -1:
				delete_tower()
			create_tower(card.id)
			current_card_id = card.id
			sprite.visible = false
		"upgrade":
			if child != null:
				upgrade_tower(card.id)
		"class":
			if child != null:
				set_class(card.id)
		"delete":
			delete_tower()
			current_card_id = -1
	return previous_card_id

func create_tower(id):
	var stats = GlobalCardsList.find_card(id)
	var prefab = load(stats["path"])
	child = prefab.instantiate()
	add_child(child)
	child.load_stats(stats)
	child.position = tower_point.position

func set_class(id):
	var stats = GlobalCardsList.find_card(id)
	var prefab = load(stats["path"])
	speciality = prefab.instantiate()
	child.set_speciality(speciality, stats["texture"])

# TODO: Al momento de setear la especialidad de tier 2, que permita elegir entre los 3 posibles para esa clase.
# Luego, se deben modificar las stats base (damage, attackSpeed, etc) de la torre sobre la que se aplica la mejora.

func upgrade_tower(id):
	var stats = GlobalCardsList.find_card(id)
	child.upgrade(stats["damage"], stats["range"], stats["attack_speed"], stats["accuracy"])

func delete_tower():
	child.queue_free()
