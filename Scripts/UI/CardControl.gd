extends Node

@export var m_top : Panel = null
@export var m_bottom : Panel = null
@export var m_ID : int = 0
@export var m_textureRect : TextureRect = null

var m_baseCard : BaseCard = null
var e_inputEvent = null
var m_side : bool = true

func Init(baseCard):
	m_baseCard = baseCard
	m_textureRect.texture = m_baseCard.m_refCard["sprite"]
	
func _ready():
	SetSide(false)

func SetInputEvent(inputEvent):
	e_inputEvent = inputEvent
	

func _on_panel_gui_input(event):
	if (e_inputEvent != null):
		e_inputEvent.call(self, event)

func SetSide(side : bool):
	m_side = side
	
	m_top.set_visible(side)
	m_bottom.set_visible(!side)

func use(param):
	m_baseCard.use(param)
