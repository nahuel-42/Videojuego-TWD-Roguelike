extends Panel
class_name CardControl

@export var m_top : Panel = null
@export var m_bottom : Panel = null
@export var m_info : Panel = null
@export var m_ID : int = 0
@export var m_textureRect : TextureRect = null


var m_baseCard : BaseCard = null
var e_inputEvent = null
var m_side : bool = true
#front
var pathFT = 'res://Assets/Sprites/Cards/PurpleBackground.png'
var pathFS = 'res://Assets/Sprites/Cards/GreenBackground.png'
var pathFU = 'res://Assets/Sprites/Cards/AquamarineBackground.png'
var pathFP = 'res://Assets/Sprites/Cards/BrownBackground.png'
var pathFSp = 'res://Assets/Sprites/Cards/BlueBackground.png'
var pathFC = 'res://Assets/Sprites/Cards/SiennaBackground.png'
#back
var pathB = 'res://Assets/Sprites/Cards/BlackBack.png'
#info
var pathFT2 = 'res://Assets/Sprites/Cards/Info.png'
var pathFS2 = 'res://Assets/Sprites/Cards/Info.png'
var pathFU2 = 'res://Assets/Sprites/Cards/Info.png'
var pathFP2 = 'res://Assets/Sprites/Cards/Info.png'
var pathFSp2 = 'res://Assets/Sprites/Cards/Info.png'
var pathFC2 = 'res://Assets/Sprites/Cards/Info.png'

func Init(baseCard):
	m_baseCard = baseCard
	#seteo de propiedades en texture y labels
	get_node("BottomSideCard/TextureRect").texture = load(pathB) #load(m_baseCard.m_refCard["sprite"])
	get_node("TopSideCard/Figure").texture = load(m_baseCard.m_refCard["sprite"])
	get_node("TopSideCard/name").text = m_baseCard.m_refCard["cardName"]
	get_node("TopSideCard/cost").text = str(m_baseCard.m_refCard["cost"])
	#infoSide
	get_node("InfoSideCard/Figure").texture = load(m_baseCard.m_refCard["sprite"])
	get_node("InfoSideCard/name").text = m_baseCard.m_refCard["cardName"]
	get_node("InfoSideCard/cost").text = str(m_baseCard.m_refCard["cost"])
	

	var type = m_baseCard.m_refCard["type"]

	#background
	if(type == 'tower'):
		get_node("TopSideCard/TextureRect").texture = load(pathFT)
		get_node("InfoSideCard/TextureRect").texture = load(pathFT2)
		get_node("InfoSideCard/TextureRect").texture = load(pathFT)
	elif (type == 'spell'):
		get_node("TopSideCard/TextureRect").texture = load(pathFS) 
		get_node("InfoSideCard/TextureRect").texture = load(pathFS)
	elif (type == 'upgrade'):
		get_node("TopSideCard/TextureRect").texture = load(pathFU)
		get_node("InfoSideCard/TextureRect").texture = load(pathFU)
	elif (type == 'passive'):
		get_node("TopSideCard/TextureRect").texture = load(pathFP)
		get_node("InfoSideCard/TextureRect").texture = load(pathFP)
	elif (type == 'speciality'):
		get_node("TopSideCard/TextureRect").texture = load(pathFSp)
		get_node("InfoSideCard/TextureRect").texture = load(pathFSp)
	elif (type == 'class'):
		get_node("TopSideCard/TextureRect").texture = load(pathFC)
		get_node("InfoSideCard/TextureRect").texture = load(pathFC)

	get_node("InfoSideCard/damage").text = '-'
	get_node("InfoSideCard/range").text = '-'
	get_node("InfoSideCard/attackSpeed").text = '-'
	get_node("InfoSideCard/accuracy").text = '-'
	
	if (type == 'tower'):
		var damage = m_baseCard.m_refCard["damage"]
		var range = m_baseCard.m_refCard["range"]
		var accuracy = m_baseCard.m_refCard["accuracy"]
		var attack = m_baseCard.m_refCard["attackSpeed"]
		get_node("TopSideCard/damage").text = str(damage)
		get_node("TopSideCard/range").text = str(range)
		get_node("TopSideCard/attackSpeed").text = str(attack)
		get_node("TopSideCard/accuracy").text = str(accuracy*100)+'%'
		#para infoSide
		get_node("InfoSideCard/damage").text = str(damage)
		get_node("InfoSideCard/range").text = str(range)
		get_node("InfoSideCard/attackSpeed").text = str(attack)
		get_node("InfoSideCard/accuracy").text = str(accuracy*100)+'%'
	var descr = m_baseCard.m_refCard['desc']
	get_node('TopSideCard/description').text = descr
	get_node('InfoSideCard/description').text = descr

func _ready():
	SetSide(1)

func GetID():
	return m_baseCard.GetID()

func SetInputEvent(inputEvent):
	e_inputEvent = inputEvent
	if (inputEvent != null):
		set_process_mode(Node.PROCESS_MODE_ALWAYS)
	
func _on_panel_gui_input(event):
	if (e_inputEvent != null):
		e_inputEvent.call(self, event)

func SetSide(side : int):
	m_side = side
	if(side == 0): #antes true
		m_top.set_visible(true)
		m_bottom.set_visible(false)
		m_info.set_visible(false)
	elif(side == 1): #antes false
		m_top.set_visible(false)
		m_bottom.set_visible(true)
		m_info.set_visible(false)	
	elif(side == 2):	
		m_top.set_visible(false)
		m_bottom.set_visible(false)
		m_info.set_visible(true)
	
func use(param):
	#set_process_mode(Node.ProcessMode.PROCESS_MODE_DISABLED)
	#visible = false
	#SetVisible(false)
	param.append(self)
	var cost = m_baseCard.m_refCard["cost"]
	if (GameController.manaCheck(cost)):
		m_baseCard.use(param)
		set_process_mode(Node.ProcessMode.PROCESS_MODE_DISABLED)
		GameController.manaConsumption(cost)
		return true
	return false

func SetVisible(value):
	visible = value
	
func SetTypeDetector(cardMovement):
	m_baseCard.SetTypeDetector(cardMovement)

func SetFront():
	self.z_index = 10
	
func SetBack():
	self.z_index = 1

func setTransparent(num):
	if (num==255):
		self.modulate=Color(1,1,1,1)
	else:
		self.modulate=Color(1,1,1,0.3)
		#self.set_modulate(num)
