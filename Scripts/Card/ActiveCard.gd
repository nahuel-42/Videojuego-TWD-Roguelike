extends SlotCard
class_name ActiveCard

@export var m_range : float = 0
@export var m_damage : float = 0
@export var m_attackSpeed : float = 0
@export var m_presition : float = 0

func _init(id, cardName, description, sprite, cost, active, type, range, damage, attackSpeed, presition):
	super._init(id, cardName, description, sprite, cost, active, type)
	m_range = range
	m_damage = damage
	m_attackSpeed = attackSpeed
	m_presition = presition

func use():
	print("Se usa ActiveCard")
