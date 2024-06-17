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

var deck_scene = preload("res://Scenes/Menu/Mazos/Mazo.tscn")
var decks = [
	{
		"name": "Continue previous game",
		"image_path": "res://Assets/Menu/Dorso2.png",
		"color": Color(0, 0, 0, 0),
		"pasive_desc": "",
		"type": CardsManager.DeckType.CONTINUE
	},
	{
		"name": "Ice",
		"image_path": "res://Assets/Menu/Dorso2.png",
		"color": Color(0.39, 0.54, 0.69, 1.0),
		"pasive_desc": "Makes your enemies slower by 15%",
		"type": CardsManager.DeckType.ICE
	},
	{
		"name": "Fire",
		"image_path": "res://Assets/Menu/Dorso2.png",
		"color": Color(0.81, 0.25, 0.16, 1.0),
		"pasive_desc": "Each fire tower increases its range by 30%",
		"type": CardsManager.DeckType.FIRE
	},
	{
		"name": "????",
		"image_path": "res://Assets/Menu/Dorso3.png",
		"color": Color(0.58, 0.58, 0.58, 1.0),
		"pasive_desc": "Bloqueado",
		"type": CardsManager.DeckType.BLOCKED
	},
	{
		"name": "????",
		"image_path": "res://Assets/Menu/Dorso3.png",
		"color": Color(0.58, 0.58, 0.58, 1.0),
		"pasive_desc": "Bloqueado",
		"type": CardsManager.DeckType.BLOCKED
	},
	{
		"name": "????",
		"image_path": "res://Assets/Menu/Dorso3.png",
		"color": Color(0.58, 0.58, 0.58, 1.0),
		"pasive_desc": "Bloqueado",
		"type": CardsManager.DeckType.BLOCKED
	},
	{
		"name": "????",
		"image_path": "res://Assets/Menu/Dorso3.png",
		"color": Color(0.58, 0.58, 0.58, 1.0),
		"pasive_desc": "Bloqueado",
		"type": CardsManager.DeckType.BLOCKED
	},
	{
		"name": "????",
		"image_path": "res://Assets/Menu/Dorso3.png",
		"color": Color(0.58, 0.58, 0.58, 1.0),
		"pasive_desc": "Bloqueado",
		"type": CardsManager.DeckType.BLOCKED
	}
]

func _ready():
	for deck_data in decks:
		if deck_data["type"] == CardsManager.DeckType.CONTINUE and not Save.LoadIngame():
			continue
		var deck = deck_scene.instantiate()
		deck.init(deck_data)
		$BoxContainer/MarginContainer/HBoxContainer.add_child(deck)
	scroll_tween =  get_tree().create_tween()

	margin_r = $BoxContainer/MarginContainer.get_theme_constant("margin_right")
	deck_space = $BoxContainer/MarginContainer/HBoxContainer.get_theme_constant("separation")
	deck_nodes = $BoxContainer/MarginContainer/HBoxContainer.get_children()

	get_h_scroll_bar().modulate.a = 0
	call_deferred("_calculate_deck_positions")

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
