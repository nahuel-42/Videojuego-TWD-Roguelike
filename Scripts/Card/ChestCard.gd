extends BaseCard
class_name ChestCard

@export var m_effect : String = String()
@export var m_value : float = 0

func use(param):
	print("chest card used")
	return true

func SetTypeDetector(cardMovement):
	cardMovement.SetChestDetector()
