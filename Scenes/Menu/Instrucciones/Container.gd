extends ScrollContainer

var deck_scale = 1
var deck_current_scale = 1.15
var scroll_duration = 1.3

var current_deck_index: int = 0
var deck_x_positions: Array = []

var scroll_tween: Tween
var margin_r: int 
var deck_space: int 
var deck_nodes: Array

var card_scene = preload('res://Scenes/Menu/Instrucciones/cardInfo.tscn')
var upgrade_scene = preload('res://Scenes/Menu/Instrucciones/upgradeInfo.tscn')

const cards = [
	{'name': 'Spell', 'description':'Card description', 'color':'Green'},
	{'name': 'Tower', 'description':'Card description', 'color':'Purple'},
	{'name': 'Upgrade', 'description':'Card description', 'color':'Aquamarine'},
	{'name': 'Passive', 'description':'Card description', 'color':'Brown'},
	{'name': 'Speciality', 'description':'Card description', 'color':'Blue'},
	{'name': 'Class', 'description':'Card description', 'color':'Red'}
]
const enemies = [
	{'type':'Beast', 'name':'Orcs', 'description':'smt', 'sprite':'res://Assets/Menu/Instrucciones/Orc.png'},
	{'type':'Beast', 'name':'Werewolf', 'description':'smt', 'sprite':'res://Assets/Menu/Instrucciones/Werewolf.png'},
	{'type':'Beast', 'name':'Dragon', 'description':'smt', 'sprite':'res://Assets/Menu/Instrucciones/Dragon.png'},
	{'type':'Soldier', 'name':'Doctor', 'description':'smt', 'sprite':'res://Assets/Menu/Instrucciones/Doctor.png'},
	{'type':'Soldier', 'name':'Captain', 'description':'smt', 'sprite':'res://Assets/Menu/Instrucciones/Captain.png'},
	{'type':'Soldier', 'name':'Liutenant', 'description':'smt', 'sprite':'res://Assets/Menu/Instrucciones/Liutenant.png'},
	{'type':'Mercenary', 'name':'Archer', 'description':'smt', 'sprite':'res://Assets/Menu/Instrucciones/Archer.png'},
	{'type':'Mercenary', 'name':'Swordsman', 'description':'smt', 'sprite':'res://Assets/Menu/Instrucciones/Swordsman.png'},
	{'type':'Mercenary', 'name':'Engineer', 'description':'smt', 'sprite':'res://Assets/Menu/Instrucciones/Engineer.png'},
	{'type':'Mercenary', 'name':'Wizard', 'description':'smt', 'sprite':'res://Assets/Menu/Instrucciones/Wizard.png'}		
]
const specialities = [
	{'type':'Hunter', 'name':'Harpoon', 'description':'smt', 'sprite':'res://Assets/Sprites/Cards/Speciality/Harpoon.png'},
	{'type':'Hunter', 'name':'Net', 'description':'smt', 'sprite':'res://Assets/Sprites/Cards/Speciality/Net.png'},
	{'type':'Hunter', 'name':'Tamer', 'description':'smt', 'sprite':'res://Assets/Sprites/Cards/Speciality/Tamer.png'},
	{'type':'Soldier', 'name':'Boiling Oil', 'description':'smt', 'sprite':'res://Assets/Sprites/Cards/Speciality/BoilingOil.png'},
	{'type':'Soldier', 'name':'Catapult', 'description':'smt', 'sprite':'res://Assets/Sprites/Cards/Speciality/Catapult.png'},
	{'type':'Soldier', 'name':'Sniper', 'description':'smt', 'sprite':'res://Assets/Sprites/Cards/Speciality/Sniper.png'},
	{'type':'Mercenary', 'name':'Sapper', 'description':'smt', 'sprite':'res://Assets/Sprites/Cards/Speciality/Sapper.png'},
	{'type':'Mercenary', 'name':'Gas', 'description':'smt', 'sprite':'res://Assets/Sprites/Cards/Speciality/Gas.png'},
	{'type':'Mercenary', 'name':'Incendiary', 'description':'smt', 'sprite':'res://Assets/Sprites/Cards/Speciality/Incendiary.png'}
]

func showInfo(op):
	if (op == 0):
		for cData in cards:
			var cardInfo = card_scene.instantiate()
			cardInfo.init(cData)
			$BoxContainer/MarginContainer/HBoxContainer.add_child(cardInfo)
	elif (op == 1):
		for eData in enemies:
			var enemyInfo = upgrade_scene.instantiate()
			enemyInfo.init(eData)
			$BoxContainer/MarginContainer/HBoxContainer.add_child(enemyInfo)
	elif (op == 2):
		for sData in specialities:
			var specialityInfo = upgrade_scene.instantiate()
			specialityInfo.init(sData)
			$BoxContainer/MarginContainer/HBoxContainer.add_child(specialityInfo)

	scroll_tween =  get_tree().create_tween()
	margin_r = $BoxContainer/MarginContainer.get_theme_constant("margin_right")
	deck_space = $BoxContainer/MarginContainer/HBoxContainer.get_theme_constant("separation")
	deck_nodes = $BoxContainer/MarginContainer/HBoxContainer.get_children()
	get_h_scroll_bar().modulate.a = 0
	call_deferred("_calculate_deck_positions")


func _ready():
	showInfo(0)


func _calculate_deck_positions():
	for _deck in deck_nodes:
		var _deck_pos_x: float = (margin_r + _deck.position.x) - ((size.x - _deck.size.x) / 2)
		_deck.pivot_offset = (_deck.size / 2)
		deck_x_positions.append(_deck_pos_x)
	scroll_horizontal = deck_x_positions[current_deck_index]

func get_selected_deck_type():
	return deck_nodes[current_deck_index].type
	
func _process(delta):
	var closest_index = 0
	var closest_distance = INF
	var _swipe_current_length: float
	var _swipe_length: float 
	
	for _index in range(deck_x_positions.size()):
		var _deck_pos_x: float = deck_x_positions[_index]
		_swipe_length= (deck_nodes[_index].size.x / 2) + (deck_space / 2)
		_swipe_current_length = abs(_deck_pos_x - scroll_horizontal)
		var _deck_scale: float = remap(_swipe_current_length, _swipe_length, 0, deck_scale, deck_current_scale)
		var _deck_opacity: float = remap(_swipe_current_length, _swipe_length, 0, 0.3, 1)

		_deck_scale = clamp(_deck_scale, deck_scale, deck_current_scale)
		_deck_opacity = clamp(_deck_opacity, 0.3, 1)

		deck_nodes[_index].scale = Vector2(_deck_scale, _deck_scale)
		deck_nodes[_index].modulate.a = _deck_opacity

		if _swipe_current_length < closest_distance:
			closest_distance = _swipe_current_length
			closest_index = _index

	current_deck_index = closest_index
