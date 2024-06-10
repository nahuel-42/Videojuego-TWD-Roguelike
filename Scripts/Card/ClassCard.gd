class_name ClassCard
extends ActiveCard

func use(param):
	var slot = param[0]
	var card : CardControl = param[1]
	print("Se uso ClassCard")
	var id = slot.apply_card(m_idCard)
	if (id != -1):
		GameEvents.OnLoadDiscard.Call([[card]])
		return true
	return false
	#GameEvents.OnLoadDiscard(param)
#por ahora, se agregan a los slots/torre y van a un array del mapa o algo similar

func SetTypeDetector(cardMovement : CardMovement):
	cardMovement.SetClassDetector()
