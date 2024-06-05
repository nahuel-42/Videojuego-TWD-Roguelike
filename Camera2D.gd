extends Camera2D

@export  var target:NodePath

const ZOOM_SPEED_IN : float = 0.9
const ZOOM_SPEED_OUT : float = 1.1
const MIN_ZOOM : float = 0.3
const MAX_ZOOM : float = 3.0
const ZOOM_SPEED : float = 0.05
const CAM_SPEED : float = 1.1

var target_return_enabled = true
var target_return_rate = 0.02

var zoom_sensitivity = 10


#borrar estas dos en el futuro, es solo para pruebas
var ZOOM_SPEED_DOWN= 1
var ZOOM_SPEED_UP=1

var events = {}
var last_drag_distance = 0
	
var width
var height
var mapa:Node
var cell_size

var previous_pos : Vector2 = Vector2.ZERO
var move_cam : bool = false

func _ready():
	zoom = Vector2(1, 1)  
	await get_parent().ready
	mapa = get_parent()
	cell_size=mapa.CELL_DIMENSION
	width = mapa.width* cell_size
	height = mapa.height * cell_size
	
func _process(delta):
	
	if(position.x>0 && position.y>0 && position.y<height && position.x<width):
		get_node(target).position = position
	
	if target and target_return_enabled and events.size() == 0:
		position = lerp(position, get_node(target).position, target_return_rate)


func _unhandled_input(event):
	if event is InputEventScreenTouch:
		if event.pressed:
			events[event.index] = event
		else:
			events.erase(event.index)
	
	if event is InputEventScreenDrag:
		events[event.index] = event
		if events.size() == 1:
			position -= event.relative * zoom.x
		elif events.size() == 2:
			var drag_distance = events[0].position.distance_to(events[1].position)
			if abs(drag_distance - last_drag_distance) > zoom_sensitivity:
				var new_zoom = (1 + ZOOM_SPEED) if drag_distance < last_drag_distance else (1 - ZOOM_SPEED)
				new_zoom = clamp(zoom.x * new_zoom, MIN_ZOOM, MAX_ZOOM)
				zoom = Vector2.ONE * new_zoom
				last_drag_distance = drag_distance
				
				
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			get_viewport().set_input_as_handled()
			if event.is_pressed():
				previous_pos = event.position
				move_cam = true
			else:
				move_cam = false
		elif event.button_index == MOUSE_BUTTON_WHEEL_UP:
			zoom_in()
		elif event.button_index == MOUSE_BUTTON_WHEEL_DOWN:
			zoom_out()
	elif event is InputEventMouseMotion and move_cam:
		get_viewport().set_input_as_handled()
		position += (previous_pos - event.position) * CAM_SPEED
		previous_pos = event.position

func zoom_in():
	if (self.zoom*ZOOM_SPEED_IN <= Vector2.ONE*MIN_ZOOM):
		self.zoom = Vector2.ONE*MIN_ZOOM
	else:
		self.zoom *= ZOOM_SPEED_IN
	
func zoom_out():
	if (self.zoom*ZOOM_SPEED_OUT >= Vector2.ONE*MAX_ZOOM):
		self.zoom = Vector2.ONE*MAX_ZOOM
	else:
		self.zoom *= ZOOM_SPEED_OUT
