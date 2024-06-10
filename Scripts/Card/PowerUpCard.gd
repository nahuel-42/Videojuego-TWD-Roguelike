class_name PowerUpCard
extends ActiveCard

#func init():
#la defino cuando sepa donde va

func use(param):
	var slot = param[0]
	var card : CardControl = param[1]
	print("Se uso PowerCard")
	var id = slot.apply_card(m_idCard)
	if (id != -1):
		GameEvents.OnRemoveBoardCards.Call([[card]])
		GameEvents.OnLoadDiscard.Call([[card]])
		return true
	return false
#por ahora, se agregan a los slots/torre y van a un array del mapa o algo similar

func SetTypeDetector(cardMovement : CardMovement):
	cardMovement.SetSlotDetector()
