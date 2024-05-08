extends Node

var m_cardUnSelected = []
var m_cardSelected = null

var m_relativePosition : Vector2
var m_backSpeed : float = 5

var m_slotDetector : SlotDetector = null

func _ready():
	m_slotDetector = GameEvents.OnGetSlotDetector.Call(null)

func _process(delta):
	if (m_cardSelected != null):
		MoveCardSelected()
	UpdateCardsUnSelected(delta)

func GetInputEvent(card, event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			m_relativePosition = card.global_position + Vector2.ONE*50
			if (m_cardSelected != null):
				m_cardUnSelected.append([m_cardSelected, card.get_parent().global_position])
			m_cardSelected = card
			m_slotDetector.SetActive(true)
		else:
			if (!m_slotDetector.ApplyCard(m_cardSelected)):
				m_cardUnSelected.append([m_cardSelected, card.get_parent().global_position])			
			m_cardSelected = null
			m_slotDetector.SetActive(false)

func MoveCardSelected():
	var mousePosition = get_viewport().get_mouse_position()
	var mov = mousePosition - m_relativePosition 
	m_relativePosition = mousePosition
	m_cardSelected.global_position += mov
	
	m_slotDetector.UpdatePosition(m_cardSelected.global_position)	

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
