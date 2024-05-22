extends Panel

@export var m_top : Panel = null
@export var m_bottom : Panel = null
@export var m_ID : int = 0
@export var m_textureRect : TextureRect = null


var m_baseCard : BaseCard = null
var e_inputEvent = null
var m_side : bool = true
var path = 'res://Assets/Sprites/Frente.png'
func Init(baseCard):
	m_baseCard = baseCard
	#seteo de propiedades en texture y labels
	get_node("TopSideCard/TextureRect").texture = load(path) #load(m_baseCard.m_refCard["sprite"])
	get_node("TopSideCard/Figure").texture = load(m_baseCard.m_refCard["sprite"])
	get_node("TopSideCard/name").text = m_baseCard.m_refCard["cardName"]	
	get_node("TopSideCard/damage").text = str(m_baseCard.m_refCard["damage"])
	get_node("TopSideCard/attackSpeed").text = str(m_baseCard.m_refCard["attackSpeed"])
	get_node("TopSideCard/range").text = str(m_baseCard.m_refCard["range"])
	get_node("TopSideCard/cost").text = str(m_baseCard.m_refCard["cost"])
	
	
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
