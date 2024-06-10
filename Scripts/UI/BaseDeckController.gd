class_name BaseDeck
extends Node

@export var m_cardOffsetPosition : float = 10.0
@export var m_cardLoadSpeed : float = 10.0
@export var m_maxCardAmount : int = 20
@export var m_hideCards: Control = null
@export var m_mainRef: Control = null

@export var m_distanceWaitNextCard: float = 100

var m_cardsList = []

var m_screenSize : Vector2
var m_hide:bool=true

var f_state = null

func _ready():
	m_screenSize = get_viewport().get_visible_rect().size

func _physics_process(delta):
	if (f_state != null):
		f_state.call(delta)
	
func AddCardsPosition(card : CardControl):
	m_cardsList.append(card)
	UI_funcs.LocateCard(m_mainRef, card)
	card.position -= Vector2(0, m_screenSize.y * 4)
		
func AddCards(card : CardControl):
	m_cardsList.append(card)
	UI_funcs.SetParent(m_mainRef, card, true)
	
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
	var cond : bool = true
	var index : int = 0
	while (cond):
		if (index < len(m_cardsList)):
			var card = m_cardsList[index]
			
			var a : Vector2 = card.position
			var cardIndex : int = clamp(index, 0, m_maxCardAmount)
			var b = Vector2(0, - m_cardOffsetPosition * cardIndex)
			var t : float = delta * m_cardLoadSpeed
			card.position = Mathf.Lerp(a, b, t)
			
			var distance : float = card.position.distance_to(b)
			
			if (distance < m_distanceWaitNextCard):
				if (distance < 1.0):
					card.position = b
			else:
				cond = false
			index += 1
		else:
			cond = false

func RestartCardIndex(i : int):
	pass#m_actualCardIndex = 0
	#if (m_actualCardIndex - i < 0):
	#	m_actualCardIndex = 0
	#else:
	#	m_actualCardIndex -= i

func ChangeHide(hide : bool):
	m_hide = hide
	if (m_hide==false):
		m_mainRef.anchor_top=0.0
		m_mainRef.anchor_bottom=1.0
		m_mainRef.anchor_left = 0.0
		m_mainRef.anchor_right = 1.0
	else:
		m_mainRef.anchor_top=m_hideCards.anchor_top
		m_mainRef.anchor_bottom=m_hideCards.anchor_bottom
		m_mainRef.anchor_left = m_hideCards.anchor_left 
		m_mainRef.anchor_right = m_hideCards.anchor_right
