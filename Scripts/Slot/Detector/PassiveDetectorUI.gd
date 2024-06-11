extends BasicDetectorUI
class_name PassiveDetectorUI

@export var m_background : CanvasItem = null
@export var m_panels: Array[Panel] = []

@export var m_colorStart : Color = Color.WHITE
@export var m_colorEnd : Color = Color.WHITE

@export var m_panelColor : Color = Color.WHITE
@export var m_panelSelectedColor : Color = Color.YELLOW

@export var m_speedColor : float = 1.0
var m_colorTimer : float = 0.0

var m_listCards = [null, null]
var m_indexCollision : int = -1
var m_cardSize : Vector2 = Vector2(100, 100)

func _init():
	GameEvents.OnGetPassiveDetectorUI.AddListener(GetPassiveDetector)
func _exit_tree():
	GameEvents.OnGetPassiveDetectorUI.RemoveListener(GetPassiveDetector)

func GetPassiveDetector(param):
	return self
	
######BasicDetector######
func Start(card : CardControl):
	super.Start(card)
	m_indexCollision = -1
	m_colorTimer = 0.0
	m_cardSize = card.size / 2.0

#Desactiva los colores de todos los paneles
func Exit():
	super.Exit()
	m_background.modulate = m_colorStart
	
	for panel in m_panels:
		panel.modulate = m_panelColor

#Actualiza los colores cuando una carta pasiva es seleccionada
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
		#Verifica si hay colision
		if (PanelCollision(ui_position, m_panels[i])):
			#Si colisiona con dos paneles, chequea cual esta mas cerca.
			#Los paneles tienen pivot en la esquina izquierda
			var d : float = ui_position.distance_to(m_panels[i].global_position + m_panels[i].size / 2.0)
			if (index == -1 or d < distance):
				index = i
				distance = d
	
	#Si cambia el indice seleccionado, hace el cambio de color
	if (index != m_indexCollision):
		SetPanelColor(m_indexCollision, m_panelColor)
		m_indexCollision = index
	SetPanelColor(index, m_panelSelectedColor)

func SetPanelColor(index : int, color : Color):
	if (index >= 0):
		m_panels[index].modulate = color

func ApplyCard(card : CardControl):
	if (m_indexCollision >= 0 and card.use([m_indexCollision])):
		InsertCard(card, m_indexCollision)
		m_indexCollision = -1
		return true
	return false
######End######

func InsertCard(card, index : int):
	if (m_listCards[index] != null):
		GameEvents.OnLoadDiscard.Call([[m_listCards[index]]])
	GameEvents.OnRemoveBoardCards.Call([[card]])
	m_listCards[index] = card
	UI_funcs.SetParent(m_panels[index], card)
	card.position = Vector2.ZERO

#Detecta colision entre la carta (el pivot es el centro) y el panel (el pivot es la esquina izquierda)
func PanelCollision(c, panel : Panel):
	var cs = m_cardSize
	var p = panel.global_position
	var ps = panel.size
	if (p.x <= c.x + cs.x and p.x + ps.x >= c.x - cs.x and 
		p.y <= c.y + cs.y and p.y + ps.y >= c.y - cs.y):
		return true
	return false
