extends Control

@export var m_gridContainer : Node = null
@export var m_columns : int = 5
@export var m_separation : Vector2 = Vector2.ZERO
@export var m_speed : float = 50.0

var m_relativePosition : float
var m_height : float
var m_dragActivated : bool = false
var val : bool = true

var op : int = 0
var card_scene = preload('res://Scenes/Menu/Instrucciones/cardInfo.tscn')
var upgrade_scene = preload('res://Scenes/Menu/Instrucciones/upgradeInfo.tscn')
var scene_principal = load("res://Scenes/Menu/menuPrincipal.tscn")

const cards = [
	{'name': 'Spell', 'description':'smt', 'color':'Green'},
	{'name': 'Tower', 'description':'smt', 'color':'Purple'},
	{'name': 'Upgrade', 'description':'smt', 'color':'Aquamarine'},
	{'name': 'Passive', 'description':'smt', 'color':'Brown'},
	{'name': 'Speciality', 'description':'smt', 'color':'Blue'},
	{'name': 'Class', 'description':'smt', 'color':'Red'}
]
const enemies = [
	{'type':'Beast', 'name':'Orcs', 'description':'Criaturas verdes lentas pero con gran resistencia a los ataques de las torres.', 'sprite':'res://Assets/Menu/Instrucciones/Orc.png'},
	{'type':'Beast', 'name':'Werewolfs', 'description':'Son veloces y tienen la capacidad de esquivar ataques. Sin embargo, cuentan con poca vida.', 'sprite':'res://Assets/Menu/Instrucciones/Werewolf.png'},
	{'type':'Beast', 'name':'Dragons', 'description':'Los más difíciles de encontrar. Sólo las torres especializadas en bestias son capaces de hacerles daño.', 'sprite':'res://Assets/Menu/Instrucciones/Dragon.png'},
	{'type':'Soldier', 'name':'Doctor', 'description':'Tienen la habilidad de sanar a otros soldados.', 'sprite':'res://Assets/Menu/Instrucciones/Doctor.png'},
	{'type':'Soldier', 'name':'Captain', 'description':'Su blindaje evita que puedan ser dañados con facilidad. Sólo pueden ser víctimas de ataques de torres especializadas en soldados.', 'sprite':'res://Assets/Menu/Instrucciones/Captain.png'},
	{'type':'Soldier', 'name':'Liutenant', 'description':'Pueden animar a sus compañeros soldados cercanos y darles velocidad de movimiento para que lleguen antes al castillo del jugador.', 'sprite':'res://Assets/Menu/Instrucciones/Liutenant.png'},
	{'type':'Mercenary', 'name':'Archer', 'description':'Simplemente tienen un arco.', 'sprite':'res://Assets/Menu/Instrucciones/Archer.png'},
	{'type':'Mercenary', 'name':'Swordsman', 'description':'Maestros marciales con altísima velocidad y la habilidad de esquivar ataques, pero muy débiles.', 'sprite':'res://Assets/Menu/Instrucciones/Swordsman.png'},
	{'type':'Mercenary', 'name':'Engineer', 'description':'Son conocedores de algunos trucos que permiten desactivar temporalmente las torres del jugador.', 'sprite':'res://Assets/Menu/Instrucciones/Engineer.png'},
	{'type':'Mercenary', 'name':'Wizard', 'description':'Con su magia reducen la velocidad de ataque de todas las torres cercanas.', 'sprite':'res://Assets/Menu/Instrucciones/Wizard.png'}		
]
const specialities = [
	{'type':'Hunter', 'name':'Harpoon', 'description':'smt', 'sprite':'res://Assets/Sprites/Cards/Speciality/Harpoon.png'},
	{'type':'Hunter', 'name':'Net', 'description':'smt', 'sprite':'res://Assets/Sprites/Cards/Speciality/Net.png'},
	{'type':'Hunter', 'name':'Tamer', 'description':'smt', 'sprite':'res://Assets/Sprites/Cards/Speciality/Tamer.png'},
	{'type':'Soldier', 'name':'Boiling Oil', 'description':'smt', 'sprite':'res://Assets/Sprites/Cards/Speciality/BoilingOil.png'},
	{'type':'Soldier', 'name':'Catapult', 'description':'smt', 'sprite':'res://Assets/Sprites/Cards/Speciality/Catapult.png'},
	{'type':'Soldier', 'name':'Sniper', 'description':'smt', 'sprite':'res://Assets/Sprites/Cards/Speciality/Sniper.png'},
	{'type':'Mercenary', 'name':'Sapper', 'description':'smt', 'sprite':'res://Assets/Sprites/Cards/Speciality/Sapper.png'},
	{'type':'Mercenary', 'name':'Gas', 'description':'smt', 'sprite':'res://Assets/Sprites/Cards/Speciality/Gas.png'},
	{'type':'Mercenary', 'name':'Incendiary', 'description':'smt', 'sprite':'res://Assets/Sprites/Cards/Speciality/Incendiary.png'}
]

func _init():
	GameEvents.OnShowInventory.AddListener(showInfo)

func _exit_tree():
	GameEvents.OnShowInventory.RemoveListener(showInfo)

func ready():
	showInfo(cards,0)

func getInfo(op):
	if (op == 0):
		showInfo(cards,0)
		for cData in cards:
			var cardInfo : Panel = card_scene.instantiate()
			cardInfo.init(cData)
			$Container/Grid.add_child(cardInfo)
	elif (op == 1):
		showInfo(enemies,1)

		for eData in enemies:
			var enemyInfo : Panel = upgrade_scene.instantiate()
			enemyInfo.init(eData)
			$Container/Grid.add_child(enemyInfo)
	elif (op == 2):
		showInfo(specialities,1)

		for sData in specialities:
			var specialityInfo : Panel = upgrade_scene.instantiate()
			specialityInfo.init(sData)
			$Container/Grid.add_child(specialityInfo)

func showInfo(dictionary,mode):
	var list = dictionary
	var amount = len(list)
	m_gridContainer.position = Vector2.ZERO
	clear_grid_container_children()		

	var originalSize : Vector2 
	if(mode == 0):
		originalSize = Vector2(250,250)
	else:
		originalSize = Vector2(250,400)
	var relationSize : float = originalSize.y / originalSize.x
	var sizeX : float = m_gridContainer.size.x / m_columns - m_separation.x
	var cardSize = Vector2(sizeX, sizeX * relationSize)
	
#	m_height = -cardSize.y * (amount / m_columns)
	
	var i : int = 0
	var j : int = 0
	var eInfo
	for elem in list:
		if(mode == 0):
			eInfo = card_scene.instantiate()
		else:
			eInfo = upgrade_scene.instantiate()
		eInfo.init(elem)
	#Se muestra la lista
	
		UI_funcs.LocateCard(m_gridContainer, eInfo)
		
		eInfo.position = Vector2(i, j) * cardSize
		eInfo.position += Vector2(i, j) * m_separation + m_separation / 2.0
		eInfo.size = cardSize
		
		i += 1
		if (i >= m_columns):
			i = 0
			j += 1

func _on_cards_pressed():
	if(op != 0):
		op = 0
		showInfo(cards,0)

func _on_enemies_pressed():
	if(op != 1):
		op = 1
		showInfo(enemies,1)

func _on_specialiy_pressed():
	if(op != 2):
		op = 2
		showInfo(specialities,1)

func _on_menu_pressed():
	get_tree().change_scene_to_packed(scene_principal)

func clear_grid_container_children():
	for child in m_gridContainer.get_children():
		m_gridContainer.remove_child(child)
		child.queue_free()

func _process(delta):
	if(val):
		showInfo(cards,0)
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
