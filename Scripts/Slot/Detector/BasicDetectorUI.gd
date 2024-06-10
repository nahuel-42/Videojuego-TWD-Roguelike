extends Node2D
class_name BasicDetectorUI

var m_activated = false

@export var m_size : float = 100.0
var m_offset : Vector2 = Vector2.ZERO

func _ready():
	pass
	
func _process(delta):
	if (m_activated):
		Update(delta)
		
######Protected####
func UItoWorld(ui_position):
	return get_viewport().get_canvas_transform().affine_inverse() * ui_position
	#return get_viewport_transform().affine_inverse() * ui_position + m_offset
###################
######Public######
func Start(card : CardControl):
	SetActive(true)
	
func Exit():
	SetActive(false)

func Update(delta):
	pass

func UpdatePosition(ui_position : Vector2):
	pass

func SetActive(value : bool):
	m_activated = value
	visible = value

func ApplyCard(card : CardControl):
	pass
######End######
