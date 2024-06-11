extends ScrollContainer



@export var card_scale = 1
@export  var card_current_scale = 1.3
@export  var scroll_duration = 1.3

var card_current_index: int = 0
var card_x_positions: Array = []

var scroll_tween: Tween
var margin_r: int 
var card_space: int 
var card_nodes: Array

func _ready():
	#$CenterContainer/MarginContainer.add_theme_constant_override("margin_right", 100)  setear
	#var margin_right_value = $CenterContainer/MarginContainer.get_theme_constant("margin_right") obtener una propertie
	scroll_tween =  get_tree().create_tween()

	margin_r = $BoxContainer/MarginContainer.get_theme_constant("margin_right")
	card_space = $BoxContainer/MarginContainer/HBoxContainer.get_theme_constant("separation")
	card_nodes = $BoxContainer/MarginContainer/HBoxContainer.get_children()
	#add_child(scroll_tween)
	print(margin_r)
	print(card_nodes)
	get_h_scroll_bar().modulate.a = 0
	call_deferred("_calculate_card_positions")
	
func _calculate_card_positions():
	for _card in card_nodes:
		var _card_pos_x: float = (margin_r + _card.position.x) - ((size.x - _card.size.x) / 2)
		_card.pivot_offset = (_card.size / 2)
		card_x_positions.append(_card_pos_x)
	scroll_horizontal = card_x_positions[card_current_index]
	
	
func _process(delta):
	var closest_index = 0
	var closest_distance = INF
	var _swipe_current_length: float
	var _swipe_length: float 
	for _index in range(card_x_positions.size()):
		var _card_pos_x: float = card_x_positions[_index]
		_swipe_length= (card_nodes[_index].size.x / 2) + (card_space / 2)
		_swipe_current_length = abs(_card_pos_x - scroll_horizontal)
		var _card_scale: float = remap(_swipe_current_length, _swipe_length, 0, card_scale, card_current_scale)
		var _card_opacity: float = remap(_swipe_current_length, _swipe_length, 0, 0.3, 1)

		_card_scale = clamp(_card_scale, card_scale, card_current_scale)
		_card_opacity = clamp(_card_opacity, 0.3, 1)

		card_nodes[_index].scale = Vector2(_card_scale, _card_scale)
		card_nodes[_index].modulate.a = _card_opacity

		if _swipe_current_length < closest_distance:
			closest_distance = _swipe_current_length
			closest_index = _index

	if _swipe_current_length < _swipe_length:
		card_current_index = closest_index
		
	#Setea el tipo para despues cargar con ese valor
	CardsManager.SetDeckType(closest_index)


