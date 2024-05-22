extends Camera2D

const ZOOM_SPEED_UP : float = 0.8
const ZOOM_SPEED_DOWN : float = 1.2
const CAM_SPEED : float = 1.1

var previous_pos : Vector2 = Vector2.ZERO
var move_cam : bool = false

func _unhandled_input(event : InputEvent):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			get_viewport().set_input_as_handled()
			if event.is_pressed():
				previous_pos = event.position
				move_cam = true
			else:
				move_cam = false
		elif event.button_index == MOUSE_BUTTON_WHEEL_UP:
			zoom *= ZOOM_SPEED_DOWN
		elif event.button_index == MOUSE_BUTTON_WHEEL_DOWN:
			zoom *= ZOOM_SPEED_UP
	elif event is InputEventMouseMotion and move_cam:
		get_viewport().set_input_as_handled()
		position += (previous_pos - event.position) * CAM_SPEED
		previous_pos = event.position
