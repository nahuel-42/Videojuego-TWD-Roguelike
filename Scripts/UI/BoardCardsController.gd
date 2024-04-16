extends Node

@export var m_cardMovement : Node
@export var m_cardsAmount : int = 5
@export var m_panels: Array[Panel] = []
@export var m_locationSpeed : float = 10.0
@export var m_hideBoardRef : Control = null
@export var m_boardRef : Control = null
var f_state = null
var m_cardsList = []
var m_hide:bool = true


func _ready():
	GameEvents.OnLoadBoard.AddListener(LoadBoard)

func _process(delta):
	if (f_state != null):
		f_state.call(delta)

#STATES

func State_CardsLocation(delta):
	var ending = false
	for i in range(len(m_cardsList)):
		var p = m_panels[i]
		var c = m_cardsList[i]
		c.global_position = Mathf.Lerp(c.global_position, p.global_position, delta * m_locationSpeed)	
		if (c.global_position.distance_to(p.global_position) < 5):
			UI_funcs.SetParent(p, c)
			c.position = Vector2.ZERO
			if (i == m_cardsAmount - 1):
				ending = true
	if (ending):
			f_state = null

#END

func LoadBoard(cardsList):
	for c in m_cardsList:
		c.SetInputEvent(null)	
	GameEvents.OnLoadDiscard.Call(m_cardsList)
	
	m_cardsList = cardsList	
	for i in range(len(m_cardsList)):
		var p = m_panels[i]
		var c = m_cardsList[i]
		c.SetInputEvent(GetInputEvent)
		
	f_state = State_CardsLocation

func GetInputEvent(card, event):
	m_cardMovement.GetInputEvent(card, event)

func _on_button_hide_board_cards_button_down():
	if (m_hide==false):
		m_boardRef.anchor_top=0
		m_boardRef.anchor_bottom=1
		m_hide=true
	else:
		m_boardRef.anchor_top=m_hideBoardRef.anchor_top
		m_boardRef.anchor_bottom=m_hideBoardRef.anchor_bottom
		m_hide=false
