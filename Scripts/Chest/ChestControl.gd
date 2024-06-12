extends Node

@export var m_sprite2D : Sprite2D = null
@export var padre : Node2D = null

func _ready():
	m_sprite2D = $Sprite2D
	
func glow_slot():
	padre.glow_chest(m_sprite2D)

func unglow_slot():
	padre.unglow_chest(m_sprite2D)

func use():
	padre.open()
