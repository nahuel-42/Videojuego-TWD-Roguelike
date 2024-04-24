class_name SlotDetector
extends Node2D

@export var m_size : float = 100.0
@export var m_collider : Node2D = null
@export var m_sprite : Node2D = null

var m_slotSelected = null
var m_slotList = []

var m_offset : Vector2 = Vector2.ZERO

func _init():
	GameEvents.OnGetSlotDetector.AddListener(GetDetSlotDetector)

func _ready():
	m_collider.scale = Vector2.ONE * m_size;
	m_sprite.scale = Vector2.ONE * m_size;
	m_offset = Vector2.ONE * m_size / 2.0

	SetActive(false)
	
func _physics_process(delta):
	if (m_slotSelected == null):
		FindCloseArea()
	else:
		CheckCloseArea()

######Events######
func GetDetSlotDetector(param):
	return self
######End######

######Public######
func UpdatePosition(ui_position : Vector2):
	global_position = get_viewport_transform().affine_inverse() * ui_position + m_offset

func SetActive(value : bool):
	#self.set_visible(value)
	m_collider.disabled = !value
	if (value == false):
		m_slotList.clear()
		if (m_slotSelected != null):
			m_slotSelected.unglow_slot()
			m_slotSelected = null

func ApplyCard(card):
	if (m_slotSelected != null):
		card.use([m_slotSelected])
		SetActive(false)
		return true
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
	
