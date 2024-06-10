class_name HideBoardControl
extends Node

@export var m_panels : Array[Control] = []

var m_hide:bool=false

func _ready():
	GameEvents.OnHideBoard.AddListener(SetHide)

func _on_button_hide_board_cards_button_down():
	m_hide = !m_hide
	for p in m_panels:
		p.ChangeHide(m_hide)

func SetHide(param):
	m_hide = param[0]
	for p in m_panels:
		p.ChangeHide(m_hide)
