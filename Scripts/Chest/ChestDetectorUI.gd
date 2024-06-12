class_name ChestDetectorUI
extends BasicDetectorUI

@export var m_collider : Node2D = null 
@export var m_sprite : Node2D = null
@export var m_collision : CollisionObject2D = null

var m_chestSelected = null
var m_chestList = []

func _init():
	GameEvents.OnGetChestDetectorUI.AddListener(GetChestDetector)
func _exit_tree():
	GameEvents.OnGetChestDetectorUI.RemoveListener(GetChestDetector)
	
func _ready():
	super._ready()
	m_collider = $CollisionShape2D
	m_sprite = $Sprite2D
	m_collider.scale = Vector2.ONE * m_size;
	m_sprite.scale = Vector2.ONE * m_size;

	SetActive(false)
	
func Update(delta):
	if (m_chestSelected == null):
		FindCloseArea()
	else:
		CheckCloseArea()

######Events######
func GetChestDetector(param):
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
		m_chestList.clear()
		if (m_chestSelected != null):
			m_chestSelected.unglow_chest(m_sprite)
			m_chestSelected = null

func ApplyCard(card : CardControl):
	if (m_chestSelected != null):
		#SetActive(false)
		return card.use([m_chestSelected])
	return false
######End######

############# Collider ##############
func _on_area_entered(area):
	if (!m_chestList.has(area)):
		m_chestList.append(area)

func _on_area_exited(area):
	var index = m_chestList.find(area)
	if (index >= 0):
		if (m_chestSelected != null and m_chestList[index] == m_chestSelected):
			m_chestSelected.unglow_chest(m_sprite)
		m_chestList.remove_at(index)
	if (m_chestSelected == area):
		m_chestSelected = null
################# End ################

func CheckCloseArea():
	var d1 = global_position.distance_to(m_chestSelected.global_position)
	var newChest = null
	for a in m_chestList:
		if (a != m_chestSelected):
			var d2 = global_position.distance_to(a.global_position)
			if (d1 > d2):
				d1 = d2
				newChest = a
	if (newChest != null):
		m_chestSelected.unglow_chest(m_sprite)
		m_chestSelected = newChest
		m_chestSelected.glow_chest(m_sprite)
		#m_slotSelected.apply_card(cards)#diccionary

func FindCloseArea():
	var newChest = null
	var d1 = 0.0
	for a in m_chestList:
		if (newChest == null):
			d1 = global_position.distance_to(a.global_position)
			newChest = a
		else:
			var d2 = global_position.distance_to(a.global_position)
			if (d1 > d2):
				d1 = d2
				newChest = a
	if (newChest != null):
		m_chestSelected = newChest
		m_chestSelected.glow_chest(m_sprite)
