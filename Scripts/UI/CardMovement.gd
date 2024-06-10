class_name CardMovement
extends Node

var m_cardUnSelected = []
var m_cardSelected = null

var m_relativePosition : Vector2
var m_backSpeed : float = 8

var m_detector : BasicDetectorUI = null

var m_sizeCard : Vector2 = Vector2.ZERO

func _ready():
	pass

func _process(delta):
	if (m_cardSelected != null):
		MoveCardSelected()
	UpdateCardsUnSelected(delta)

func GetCardSelected():
	return m_cardSelected
	
func ClearAllCards():
	m_cardUnSelected.clear()
	m_cardSelected = null
	
func ClearCards(cardsList):
	for c in cardsList:
		var index : int = m_cardUnSelected.find(c)
		if (index >= 0):
			m_cardUnSelected.remove_at(index)
		else:
			if (c == m_cardSelected):
				m_cardSelected = null

###############DETECTOR###############
func SetSlotDetector():
	m_detector = GameEvents.OnGetSlotDetectorUI.Call([2])
func SetSpellDetector():
	m_detector = GameEvents.OnGetSpellDetectorUI.Call([2])
func SetPassiveDetector():
	m_detector = GameEvents.OnGetPassiveDetectorUI.Call([6])
func SetSpecialityDetector():
	m_detector = GameEvents.OnGetSlotDetectorUI.Call([2])
func SetClassDetector():
	m_detector = GameEvents.OnGetSlotDetectorUI.Call([2])
######################################

###################INPUT##############
func GetInputEvent(card, event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			ClickPressed(card)
		else:
			ClickUnPressed(card)

func ClickPressed(card):
	card.z_index = 10
	card.SetTypeDetector(self)
	m_sizeCard = card.size / 2.0
	m_relativePosition = card.global_position + m_sizeCard
	
	if (m_cardSelected != null):
		m_cardUnSelected.append([m_cardSelected, card.get_parent().global_position])
	m_cardSelected = card
	
	m_detector.Start(card)
	
func ClickUnPressed(card):
	card.z_index = 1
	if (!m_detector.ApplyCard(m_cardSelected)):
		m_cardUnSelected.append([m_cardSelected, card.get_parent().global_position])
		
	m_cardSelected = null
	m_detector.Exit()
######################################
func MoveCardSelected():
	var mousePosition = get_viewport().get_mouse_position()
	var mov = mousePosition - m_relativePosition 
	m_relativePosition = mousePosition
	m_cardSelected.global_position += mov
	
	m_detector.UpdatePosition(m_cardSelected.global_position + m_sizeCard)

func UpdateCardsUnSelected(delta):
	var i = 0
	while i < len(m_cardUnSelected):
		var c = m_cardUnSelected[i][0]
		var originPosition = m_cardUnSelected[i][1]
		c.global_position = Mathf.Lerp(c.global_position, originPosition, delta * m_backSpeed)
		if (c.global_position.distance_to(originPosition) < 1):
			c.global_position = originPosition
			m_cardUnSelected.remove_at(i)
		else:
			i += 1
