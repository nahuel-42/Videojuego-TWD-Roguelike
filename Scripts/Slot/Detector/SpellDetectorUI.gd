class_name SpellDetectorUI
extends BasicDetectorUI

@export var m_circle : Node2D = null
@export var m_hightLimit : float = 0.8

var m_apply : bool = false
var m_sizeY : float = 0.0

func _init():
	GameEvents.OnGetSpellDetectorUI.AddListener(GetSpellDetector)
func _exit_tree():
	GameEvents.OnGetSpellDetectorUI.RemoveListener(GetSpellDetector)

func _ready():
	m_sizeY = get_viewport_rect().size.y

func draw_radius(radius : float):
	var circle_points = []
	m_circle.width = 1
	var segments = 32  # Número de segmentos para aproximar el círculo
	
	for i in range(segments + 1):
		var angle = i * (2 * PI / segments)
		var x = radius * cos(angle)
		var y = radius * sin(angle)
		circle_points.append(Vector2(x, y))
	
	m_circle.points = circle_points
	
	
func GetSpellDetector(param):
	return self

######BasicDetector######
func Start(card : CardControl):
	super.Start(card)
	m_activated = false
	var c = GlobalCardsList.find_card(card.GetID())
	draw_radius(c["range"])

func Update(delta):
	pass

func UpdatePosition(ui_position : Vector2):
	if (ui_position.y / m_sizeY >= m_hightLimit):
		m_circle.visible = false
		m_apply = false
	else:
		m_circle.visible = true
		m_apply = true 
	global_position = UItoWorld(ui_position)
	
func ApplyCard(card : CardControl):
	if (m_apply):
		card.use([global_position])
		GameEvents.OnRemoveBoardCards.Call([[card]])
		GameEvents.OnLoadDiscard.Call([[card]])
		return true
	return false
######End######
