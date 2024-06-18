class_name InventoryCards
extends Control

@export var m_gridContainer : Node = null
@export var m_columns : int = 5
@export var m_separation : Vector2 = Vector2.ZERO
@export var m_speed : float = 50.0

var m_relativePosition : float
var m_height : float
var m_dragActivated : bool = false
var val = true

var scene_principal = load("res://Scenes/Menu/menuPrincipal.tscn")

func _init():
	GameEvents.OnShowInventory.AddListener(ShowCards)

func _exit_tree():
	GameEvents.OnShowInventory.RemoveListener(ShowCards)

func ready():
	pass

func ShowCards():
	var cardList = GlobalCardsList.CollectionCard
	var amount = len(cardList)
	m_gridContainer.position = Vector2.ZERO
	clear_grid_container_children()		
	loadCastle()

	var originalSize : Vector2 = Vector2(346,533)
	var relationSize : float = originalSize.y / originalSize.x
	var sizeX : float = m_gridContainer.size.x / m_columns - m_separation.x
	var cardSize = Vector2(sizeX, sizeX * relationSize)
	
	m_height = -cardSize.y * (amount / m_columns)
	
	var i : int = 0
	var j : int = 0
	
	for card in cardList:
		var c : CardControl = CardFactory.createCard(card["id"])
	#Se muestra la lista
	
		UI_funcs.LocateCard(m_gridContainer, c)
		c.SetFront()
		if(GlobalCardsList.isUnlocked(card["id"])):
			c.SetSide(2)
		
		c.position = Vector2(i, j) * cardSize
		c.position += Vector2(i, j) * m_separation + m_separation / 2.0
		c.size = cardSize
		
		i += 1
		if (i >= m_columns):
			i = 0
			j += 1

func loadCastle():
	var number = 0
	number = Save.LoadMaxCastles()
	print(number)
	if(number != 0):
		$Panel.visible = true
		$Panel/number.text = str(number)

func clear_grid_container_children():
	for child in m_gridContainer.get_children():
		m_gridContainer.remove_child(child)
		child.queue_free()

func _process(delta):
	if(val):
		ShowCards()
		val = false
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


func _on_menu_pressed():
	get_tree().change_scene_to_packed(scene_principal)
