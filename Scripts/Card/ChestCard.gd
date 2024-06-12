extends BaseCard
class_name ChestCard

@export var m_effect : String = String()
@export var m_value : float = 0

func use(param):
	var area = param[0]
	area.use()
	var card = param[1]
	GameEvents.OnRemoveBoardCards.Call([[card]])
	GameEvents.OnLoadDiscard.Call([[card]])
	return true

func SetTypeDetector(cardMovement):
	cardMovement.SetChestDetector()
