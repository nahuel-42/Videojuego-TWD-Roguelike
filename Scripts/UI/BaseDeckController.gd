class_name BaseDeck
extends Node

@export var m_cardOffsetPosition : float = 10.0
@export var m_cardLoadSpeed : float = 10.0

var m_cardsList = []
var m_screenSize : Vector2
var m_actualCardIndex = 0

var f_state = null

func _ready():
	m_screenSize = get_viewport().get_visible_rect().size

func _process(delta):
	if (f_state != null):
		f_state.call(delta)
	
func AddCards(card):
	m_cardsList.append(card)
		
	UI_funcs.LocateCard(self, card)
	card.position -= Vector2(0, m_screenSize.y + 100)
	
func RemoveCards(amount):
	var list = []
	var i = 0
	var count = len(m_cardsList)
	while i < amount and i < count:
		list.append(m_cardsList[0])
		m_cardsList.remove_at(0)
		i += 1
	return list
	
func State_LoadCards(delta):
	if (m_actualCardIndex < len(m_cardsList)):
		var card = m_cardsList[m_actualCardIndex]
		
		var a = card.position
		var b = Vector2(0, - m_cardOffsetPosition * m_actualCardIndex)
		var t = delta * m_cardLoadSpeed
		card.position = Mathf.Lerp(a, b, t)
		
		if (card.position.distance_to(b) < 1.0):
			card.position = b
			m_actualCardIndex += 1

func RestartCardIndex(i : int):	
	if (m_actualCardIndex - i < 0):
		m_actualCardIndex = 0
	else:
		m_actualCardIndex -= i
