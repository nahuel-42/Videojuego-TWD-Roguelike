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
	var amount = len(param[0])
	if (amount > 0):
		var cardList = param[0]
		var order : bool = param[1]
		var repeat : bool = param[2]
		
		visible = true
		m_gridContainer.position = Vector2.ZERO
		clear_grid_container_children()		
		
		var originalSize : Vector2 = cardList[0].size
		var relationSize : float = originalSize.y / originalSize.x
		
		var sizeX : float = m_gridContainer.size.x / m_columns - m_separation.x
		
		var cardSize = Vector2(sizeX, sizeX * relationSize)
		
		m_height = -cardSize.y * (amount / m_columns)
		
		var i : int = 0
		var j : int = 0
		
		#Se crea la lista
		var newCardList = []
		for card in cardList:
			var id : int = card.GetID()
			var k : int = 0
			if (repeat == true or newCardList.find(id) == -1):
				while (order == true and k < len(newCardList) and newCardList[k] < id):
					k += 1
				if (order == false or k == len(newCardList)):
					newCardList.append(id)
				else:
					newCardList.insert(k, id)
		
		#Se muestra la lista
		for card in newCardList:
			var c = CardFactory.createCard(card)
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
		m_gridContainer.position += Vector2.UP * mov * m_speed
		m_gridContainer.position.y = clamp(m_gridContainer.position.y, m_height, 0)
		
func _on_detect_drag_gui_input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			m_relativePosition = get_viewport().get_mouse_position().y
			m_dragActivated = true
		else:
			m_dragActivated = false
