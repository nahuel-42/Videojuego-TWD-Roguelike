class_name SlotDetectorUI
extends BasicDetectorUI

@export var m_collider : Node2D = null 
@export var m_sprite : Node2D = null
@export var m_collision : CollisionObject2D = null

var m_slotSelected = null
var m_slotList = []

func _init():
	GameEvents.OnGetSlotDetectorUI.AddListener(GetSlotDetector)
func _exit_tree():
	GameEvents.OnGetSlotDetectorUI.RemoveListener(GetSlotDetector)
	
func _ready():
	super._ready()
	m_collider = $CollisionShape2D
	m_sprite = $Sprite2D
	m_collider.scale = Vector2.ONE * m_size;
	m_sprite.scale = Vector2.ONE * m_size;

	SetActive(false)
	
func Update(delta):
	if (m_slotSelected == null):
		FindCloseArea()
	else:
		CheckCloseArea()

######Events######
func GetSlotDetector(param):
	var layer = param[0]
	m_collision.collision_layer = layer
	m_collision.collision_mask = layer
	return self
######End######

######Public######
func UpdatePosition(ui_position : Vector2):
	global_position = UItoWorld(ui_position)

func SetActive(value : bool):
	#self.set_visible(value)
	super.SetActive(value)
	m_collider.disabled = !value
	if (value == false):
		m_slotList.clear()
		if (m_slotSelected != null):
			m_slotSelected.unglow_slot()
			m_slotSelected = null

func ApplyCard(card : CardControl):
	if (m_slotSelected != null):
		#SetActive(false)
		return card.use([m_slotSelected])
	return false
######End######

######Collider######
func _on_area_entered(area):
	if (!m_slotList.has(area)):
		m_slotList.append(area)

func _on_area_exited(area):
	var index = m_slotList.find(area)
	if (index >= 0):
		if (m_slotSelected != null):
			m_slotSelected.unglow_slot()
		m_slotList.remove_at(index)
	if (m_slotSelected == area):
		m_slotSelected = null
######End######

func CheckCloseArea():
	var d1 = global_position.distance_to(m_slotSelected.global_position)
	var newSlot = null
	for a in m_slotList:
		if (a != m_slotSelected):
			var d2 = global_position.distance_to(a.global_position)
			if (d1 > d2):
				d1 = d2
				newSlot = a
	if (newSlot != null):
		m_slotSelected.unglow_slot()
		m_slotSelected = newSlot
		m_slotSelected.glow_slot()
		#m_slotSelected.apply_card(cards)#diccionary

func FindCloseArea():
	var newSlot = null
	var d1 = 0.0
	for a in m_slotList:
		if (newSlot == null):
			d1 = global_position.distance_to(a.global_position)
			newSlot = a
		else:
			var d2 = global_position.distance_to(a.global_position)
			if (d1 > d2):
				d1 = d2
				newSlot = a
	if (newSlot != null):
		m_slotSelected = newSlot
		m_slotSelected.glow_slot()
