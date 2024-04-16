extends Node

@export var m_speed : float = 1000.0

var m_movement : Vector2 = Vector2.ZERO

func _ready():
	pass


func _process(delta):
	var horizontal =  1.0 if Input.is_key_pressed(KEY_D) else (-1.0 if Input.is_key_pressed(KEY_A) else 0.0)
	var vertical = -1.0 if Input.is_key_pressed(KEY_W) else (1.0 if Input.is_key_pressed(KEY_S) else 0.0)

	var mov = Vector2(horizontal, vertical)
	m_movement = Mathf.Lerp(m_movement, mov, 0.1)
	self.position += m_movement * m_speed * delta
