class_name SpecialityCard
extends ActiveCard

var m_slot = null

func use(param):
	print("Se uso SpecialityCard")
	m_slot = param[0]
	var card : CardControl = param[1]
	
	var id = m_slot.check_speciality(m_idCard)
	if (id != -1):
		GameEvents.OnShowPopupSpeciality.Call([self])
		GameEvents.OnRemoveBoardCards.Call([[card]])
		GameEvents.OnLoadDiscard.Call([[card]])
		return true
	return false
	#GameEvents.OnLoadDiscard(param)

func UseSpeciality1():
	pass

func UseSpeciality2():
	pass

func UseSpeciality3():
	pass
	
func SetTypeDetector(cardMovement : CardMovement):
	cardMovement.SetSpecialityDetector()
