class_name SlotDetector
extends Node2D

@export var m_collider : CollisionShape2D = null

var m_slotSelected = null
var m_slotList = []

func _ready():
	GameEvents.OnUpadteSlotDetectorPosition.AddListener(UpdatePosition)
	GameEvents.OnSetActiveSlotDetector.AddListener(SetActive)
	
	SetActive(false)
	#self.set_visible(false)
	
func _physics_process(delta):
	if (m_slotSelected == null):
		FindCloseArea()
	else:
		CheckCloseArea()

func UpdatePosition(ui_position : Vector2):
	global_position = get_viewport_transform().affine_inverse() * ui_position

func SetActive(value : bool):
	#self.set_visible(value)
	m_collider.disabled = !value
	if (value == false):
		m_slotList.clear()
		if (m_slotSelected != null):
			m_slotSelected.UnSelected()
			m_slotSelected = null

func _on_area_entered(area):
	if (!m_slotList.has(area)):
		m_slotList.append(area)

func _on_area_exited(area):
	var index = m_slotList.find(area)
	if (index >= 0):
		area.UnSelected()
		m_slotList.remove_at(index)
	if (m_slotSelected == area):
		m_slotSelected = null

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
		m_slotSelected.UnSelected()
		m_slotSelected = newSlot
		m_slotSelected.OnSelected()
		m_slotSelected.apply_card(cards)#diccionary
		
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
		m_slotSelected.OnSelected()
