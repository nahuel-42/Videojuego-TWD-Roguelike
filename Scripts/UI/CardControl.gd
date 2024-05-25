extends Panel

@export var m_top : Panel = null
@export var m_bottom : Panel = null
@export var m_ID : int = 0
@export var m_textureRect : TextureRect = null


var m_baseCard : BaseCard = null
var e_inputEvent = null
var m_side : bool = true
var pathF = 'res://Assets/Sprites/Cards/Front.png'
var pathB = 'res://Assets/Sprites/Cards/Back.png'
func Init(baseCard):
	m_baseCard = baseCard
	#seteo de propiedades en texture y labels
	get_node("TopSideCard/TextureRect").texture = load(pathF) #load(m_baseCard.m_refCard["sprite"])
	get_node("BottomSideCard/TextureRect").texture = load(pathB) #load(m_baseCard.m_refCard["sprite"])
	
	get_node("TopSideCard/Figure").texture = load(m_baseCard.m_refCard["sprite"])
	#get_node("TopSideCard/Figure").texture
	get_node("TopSideCard/name").text = m_baseCard.m_refCard["cardName"]
	get_node("TopSideCard/cost").text = str(m_baseCard.m_refCard["cost"])
	var type = m_baseCard.m_refCard["type"]
	#LO QUE SIGUE DEPENDE DE LO QUE MODIFIQUE CADA TIPO DE CARTA
	#SI QUIEREN QUE APAREZCAN TODAS LAS ESTRUCTURAS IGUALES, EL IF ANIDADO SE VA
	if(type == "tower"):	
		get_node("TopSideCard/damage").text = str(m_baseCard.m_refCard["damage"])
		get_node("TopSideCard/attackSpeed").text = str(m_baseCard.m_refCard["attackSpeed"])
		get_node("TopSideCard/range").text = str(m_baseCard.m_refCard["range"])
	elif (type == 'spell'):
		get_node("TopSideCard/damage").text = str(m_baseCard.m_refCard["damage"])
		get_node("TopSideCard/attackSpeed").text = str(m_baseCard.m_refCard["attackSpeed"])
		get_node("TopSideCard/range").text = str(m_baseCard.m_refCard["range"])		
	elif(type == 'passive'):
		get_node("TopSideCard/damage").text = str(m_baseCard.m_refCard["damage"])
		get_node("TopSideCard/attackSpeed").text = str(m_baseCard.m_refCard["attackSpeed"])
		get_node("TopSideCard/range").text = str(m_baseCard.m_refCard["range"])
	elif (type == 'powerUp'):
		get_node("TopSideCard/damage").text = str(m_baseCard.m_refCard["damage"])
		get_node("TopSideCard/attackSpeed").text = str(m_baseCard.m_refCard["attackSpeed"])
		get_node("TopSideCard/range").text = str(m_baseCard.m_refCard["range"])
	
	#probablemente haya que crear cuatro estructuras de cartas, para que pueda mostrar los atributos que corresponden. 
	
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
	m_baseCard.use(param)
	set_process_mode(Node.ProcessMode.PROCESS_MODE_DISABLED)
	SetVisible(false)

func SetVisible(value):
	visible = value
