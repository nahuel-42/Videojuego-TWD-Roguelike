extends Camera2D

@export  var target:NodePath

const ZOOM_SPEED_IN : float = 0.9
const ZOOM_SPEED_OUT : float = 1.1
const MIN_ZOOM : float = 0.4
const MAX_ZOOM : float = 3.0
const ZOOM_SPEED : float = 0.03
const CAM_SPEED : float = 1.3

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
var last_tap_time = 0
var double_tap_threshold = 0.3 # 300 ms entre taps
var last_tap_position = Vector2()
var last_drag_velocity = Vector2.ZERO
var inertia_velocity = Vector2.ZERO
var applying_inertia = false
var previous_pos : Vector2 = Vector2.ZERO
var move_cam : bool = false
var tween: Tween

func _ready():
	zoom = Vector2(1, 1)  
	await get_parent().ready
	mapa = get_parent()
	cell_size=mapa.config.cell_dimension
	width = mapa.config.width* cell_size
	height = mapa.height * cell_size
	tween = create_tween()
	
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
	if event is InputEventScreenTouch:
		if event.pressed:
			var time_since_last_tap = Time.get_ticks_msec() / 1000.0 - last_tap_time
			if time_since_last_tap < double_tap_threshold and event.position.distance_to(last_tap_position) < 50:
				_apply_double_tap_zoom(event.position)
			last_tap_time = Time.get_ticks_msec() / 1000.0
			last_tap_position = event.position
			events[event.index] = event
			last_drag_velocity = Vector2.ZERO
		else:
			events.erase(event.index)
	
	if event is InputEventScreenDrag:
		events[event.index] = event
		if events.size() == 1:
			 # Escalar el movimiento por el inverso del nivel de zoom para ajustar la sensibilidad
			var movement_scale = 1 / zoom.x * 0.4
			position -= event.relative * movement_scale
			# Almacenar la última velocidad de arrastre
			last_drag_velocity = event.velocity*0.025
		elif events.size() == 2:
			var drag_distance = events[0].position.distance_to(events[1].position)
			if abs(drag_distance - last_drag_distance) > zoom_sensitivity:
				# Invertir la lógica aquí: disminuir el zoom si los dedos se alejan, aumentar si se acercan
				var new_zoom = (1 + ZOOM_SPEED) if drag_distance > last_drag_distance else (1 - ZOOM_SPEED)
				new_zoom = clamp(zoom.x * new_zoom, MIN_ZOOM, MAX_ZOOM)
				zoom = Vector2.ONE * new_zoom
				last_drag_distance = drag_distance
	if event is InputEventScreenTouch and not event.is_pressed():
		events.erase(event.index)
		if events.size() == 0:
		# Iniciar la inercia con la última velocidad de arrastre
			inertia_velocity = last_drag_velocity
			applying_inertia = true
				
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			get_viewport().set_input_as_handled()
			if event.is_pressed():
				previous_pos = event.position
				move_cam = true
			else:
				move_cam = false
		elif event.button_index == MOUSE_BUTTON_WHEEL_UP:
			zoom_out()
		elif event.button_index == MOUSE_BUTTON_WHEEL_DOWN:
			zoom_in()
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
				
func _apply_double_tap_zoom(tap_position):
	var target_zoom = Vector2(1.5, 1.5) if zoom.x < 1 else Vector2(0.5, 0.5)  # Alternar entre zoom 1x y 2x
	tween.stop()  # Detener animaciones anteriores
	tween = create_tween()
	var uno= tween.tween_property(self, "zoom", target_zoom, 0.5)
	var dos = uno.set_trans(Tween.TRANS_LINEAR)
	var tres = dos.set_ease(Tween.EASE_IN_OUT)
	tween.play()

func _physics_process(delta):
	if applying_inertia:
		position -= inertia_velocity * delta*100
		# Ajusta este factor para controlar la rapidez con la que disminuye la inercia
		inertia_velocity = inertia_velocity.lerp(Vector2.ZERO, 0.1)
		if inertia_velocity.length() < 1:
			applying_inertia = false
			inertia_velocity = Vector2.ZERO
