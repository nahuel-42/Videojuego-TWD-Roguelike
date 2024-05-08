extends BaseCard
class_name SlotCard
#todas las cartas que interactuan con un slot
#podria ser que necesitemos dos clases intermedias passive/active, pero no se me ocurre para que serviria ahora

#creo que no necesita una referencia al nodo, por verse
@export var m_active : bool = false
@export var m_type: String = String()

#func _init(id, cardName, description, sprite, cost, active, type):
#	super._init(id, cardName, description, sprite, cost)
#	m_active = active
#	m_type = type

func use(param):
	print("se usa una slotCard")
