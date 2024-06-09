extends Panel
class_name CardControl

@export var m_top : Panel = null
@export var m_bottom : Panel = null
@export var m_ID : int = 0
@export var m_textureRect : TextureRect = null


var m_baseCard : BaseCard = null
var e_inputEvent = null
var m_side : bool = true
var pathFT = 'res://Assets/Sprites/Cards/PurpleBackground.png'
var pathFS = 'res://Assets/Sprites/Cards/GreenBackground.png'
var pathFU = 'res://Assets/Sprites/Cards/AquamarineBackground.png'
var pathFP = 'res://Assets/Sprites/Cards/BrownBackground.png'
var pathFSp = 'res://Assets/Sprites/Cards/BlueBackground.png'
var pathFC = 'res://Assets/Sprites/Cards/SiennaBackground.png'
var pathB = 'res://Assets/Sprites/Cards/BlackBack.png'
func Init(baseCard):
	m_baseCard = baseCard
	#seteo de propiedades en texture y labels
	get_node("BottomSideCard/TextureRect").texture = load(pathB) #load(m_baseCard.m_refCard["sprite"])
	get_node("TopSideCard/Figure").texture = load(m_baseCard.m_refCard["sprite"])
	get_node("TopSideCard/name").text = m_baseCard.m_refCard["cardName"]
	get_node("TopSideCard/cost").text = str(m_baseCard.m_refCard["cost"])
	var type = m_baseCard.m_refCard["type"]

	#background
	if(type == 'tower'):
		get_node("TopSideCard/TextureRect").texture = load(pathFT)
	elif (type == 'spell'):
		get_node("TopSideCard/TextureRect").texture = load(pathFS) 
	elif (type == 'upgrade'):
		var descr = m_baseCard.m_refCard['desc']
		get_node("TopSideCard/TextureRect").texture = load(pathFU)
	elif (type == 'passive'):
		get_node("TopSideCard/TextureRect").texture = load(pathFP)
	elif (type == 'speciality'):
		get_node("TopSideCard/TextureRect").texture = load(pathFSp)
	elif (type == 'class'):
		get_node("TopSideCard/TextureRect").texture = load(pathFC)

	if (type == 'tower'):
		var damage = m_baseCard.m_refCard["damage"]
		var range = m_baseCard.m_refCard["range"]
		var accuracy = m_baseCard.m_refCard["accuracy"]
		var attack = m_baseCard.m_refCard["attackSpeed"]
		get_node("TopSideCard/damage").text = str(damage)
		get_node("TopSideCard/range").text = str(range)
		get_node("TopSideCard/attackSpeed").text = str(attack)
		get_node("TopSideCard/accuracy").text = str(accuracy*100)+'%'
	else:
		var descr = m_baseCard.m_refCard['desc']
		get_node('TopSideCard/description').text = descr
	
func _ready():
	SetSide(false)

func GetID():
	return m_baseCard.GetID()

func SetInputEvent(inputEvent):
	e_inputEvent = inputEvent
	
func _on_panel_gui_input(event):
	if (e_inputEvent != null):
		e_inputEvent.call(self, event)

func SetSide(side : bool):
	m_side = side
	
	m_top.set_visible(side)
	m_bottom.set_visible(!side)

func use(param):
	#set_process_mode(Node.ProcessMode.PROCESS_MODE_DISABLED)
	#visible = false
	#SetVisible(false)
	param.append(self)
	if (GameController.manaConsumption(m_baseCard.m_refCard["cost"]) and m_baseCard.use(param)):
		set_process_mode(Node.ProcessMode.PROCESS_MODE_DISABLED)
		return true
	return false

func SetVisible(value):
	visible = value
	
func SetTypeDetector(cardMovement):
	m_baseCard.SetTypeDetector(cardMovement)
