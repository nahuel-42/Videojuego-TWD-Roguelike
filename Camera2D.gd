extends Camera2D

@export  var target:NodePath

var target_return_enabled = true
var target_return_rate = 0.02
var min_zoom = 0.5
var max_zoom = 2
var zoom_sensitivity = 10
var zoom_speed = 0.05

#borrar estas dos en el futuro, es solo para pruebas
var ZOOM_SPEED_DOWN= 1
var ZOOM_SPEED_UP=1

var events = {}
var last_drag_distance = 0
	
var width
var height
var mapa:Node
var cell_size
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
				var new_zoom = (1 + zoom_speed) if drag_distance < last_drag_distance else (1 - zoom_speed)
				new_zoom = clamp(zoom.x * new_zoom, min_zoom, max_zoom)
				zoom = Vector2.ONE * new_zoom
				last_drag_distance = drag_distance
	if event is InputEventMouseButton:	
		if event.button_index == MOUSE_BUTTON_WHEEL_UP:
			zoom *= ZOOM_SPEED_DOWN
		elif event.button_index == MOUSE_BUTTON_WHEEL_DOWN:
			zoom *= ZOOM_SPEED_UP
