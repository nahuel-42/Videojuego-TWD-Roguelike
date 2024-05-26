extends SlotCard
class_name PassiveCard

@export var m_effect : String = String()
@export var m_value : float = 0

#func _init(id, cardName, description, sprite, cost, active, type, effect, value):
#	super._init(id, cardName, description, sprite, cost, active, type)
#	m_effect = effect
#	m_value = value
	
func use(param):
	print("se usa PassiveCard")
	#quedan en un array de pasivas en uso o algo similar

func SetTypeDetector(cardMovement):
	cardMovement.SetPassiveDetector()
