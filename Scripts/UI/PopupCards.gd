extends Control

@export var m_gridContainer : Node = null
@export var m_columns : int = 5
@export var m_separation : Vector2 = Vector2.ZERO
@export var m_speed : float = 50.0

var m_relativePosition : float
var m_height : float
var m_dragActivated : bool = false

func _init():
	GameEvents.OnShowPopCards.AddListener(ShowCards)

func ShowCards(param):
	if (len(param) > 0):
		visible = true
		m_gridContainer.position = Vector2.ZERO
		clear_grid_container_children()
		
		var amount = len(param)
		
		var originalSize : Vector2 = param[0].size
		var relationSize : float = originalSize.y / originalSize.x
		
		var sizeX : float = m_gridContainer.size.x / m_columns - m_separation.x
		
		var cardSize = Vector2(sizeX, sizeX * relationSize)
		
		m_height = -cardSize.y * (amount / m_columns)
		
		var i : int = 0
		var j : int = 0
		
		for card in param:
			var c = CardFactory.createCard(card.GetID())
			UI_funcs.LocateCard(m_gridContainer, c)
			
			c.position = Vector2(i, j) * cardSize
			c.position += Vector2(i, j) * m_separation + m_separation / 2.0
			c.size = cardSize
			c.SetSide(true)
			
			i += 1
			if (i >= m_columns):
				i = 0
				j += 1


func _on_exit_button_down():
	visible = false

func clear_grid_container_children():
	for child in m_gridContainer.get_children():
		m_gridContainer.remove_child(child)
		child.queue_free()

func _process(delta):
	if (m_dragActivated):
		var mousePosition = get_viewport().get_mouse_position()
		var mov = m_relativePosition - mousePosition.y 
		m_relativePosition = mousePosition.y
		m_gridContainer.position += Vector2.UP * mov
		m_gridContainer.position.y = clamp(m_gridContainer.position.y, m_height, 0)
		
func _on_detect_drag_gui_input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			m_relativePosition = get_viewport().get_mouse_position().y
			m_dragActivated = true
		else:
			m_dragActivated = false
