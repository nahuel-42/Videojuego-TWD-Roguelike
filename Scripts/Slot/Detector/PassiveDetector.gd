extends BasicDetector
class_name PassiveDetector

@export var m_background : CanvasItem = null
@export var m_panels: Array[Panel] = []

@export var m_colorStart : Color = Color.WHITE
@export var m_colorEnd : Color = Color.WHITE

@export var m_speedColor : float = 1.0
var m_colorTimer : float = 0.0

var m_listCards = [null, null]
var m_indexCollision : int = -1

func _init():
	GameEvents.OnGetPassiveDetector.AddListener(GetPassiveDetector)
	
func GetPassiveDetector(param):
	return self
	
######BasicDetector######
func Start(card : CardControl):
	super.Start(card)
	m_colorTimer = 0.0

func Exit():
	super.Exit()
	m_background.modulate = m_colorStart

func Update(delta):
	m_colorTimer += delta * m_speedColor
	if (m_colorTimer < 1.0):
		m_background.modulate = Mathf.Lerp_Color(m_colorStart, m_colorEnd, m_colorTimer)
	else: 
		if (m_colorTimer <= 2.0):
			m_background.modulate = Mathf.Lerp_Color(m_colorEnd, m_colorStart, m_colorTimer - 1.0)
		else: 
			m_colorTimer = 0.0

func UpdatePosition(ui_position : Vector2):
	var index : int = -1
	var distance : float = 0.0
	
	for i in range(len(m_panels)):
		if (PanelCollision(ui_position, m_panels[i])):
			var d : float = ui_position.distance_to(m_panels[i].global_position)
			if (index == -1 or d < distance):
				index = i
				distance = d
	if (index >= 0):
		m_indexCollision = index

func ApplyCard(card : CardControl):
	if (m_indexCollision >= 0):
		InsertCard(card, m_indexCollision)
		card.use([null])
		return true
	return false
######End######

func InsertCard(card, index : int):
	if (m_listCards[index] != null):
		GameEvents.OnLoadDiscard.Call([m_listCards[index]])
	GameEvents.OnRemoveBoardCards.Call([card])
	m_listCards[index] = card
	UI_funcs.SetParent(m_panels[index], card)
	card.position = Vector2.ZERO

func PanelCollision(pointer, panel : Panel):
	var p = Vector2.ZERO
	#if (position.x - panel.size.x <= player.position.x + p.x and position.x + panel.size.x >= player.position.x - p.x and 
	#	position.y - panel.size.y <= player.position.y + p.y and position.y + panel.size.y >= player.position.y - p.y):	
	if (panel.global_position.x - panel.size.x <= pointer.x + p.x and panel.global_position.x + panel.size.x >= pointer.x - p.x and 
		panel.global_position.y - panel.size.y <= pointer.y + p.y and panel.global_position.y + panel.size.y >= pointer.y - p.y):	
		return true
	return false
