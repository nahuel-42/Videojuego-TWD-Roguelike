class_name SpecialityCard
extends ActiveCard

var m_slot = null
var m_specialityType : int = -1
var m_specialitySubType : int = -1

func use(param):
	print("Se uso SpecialityCard")
	m_slot = param[0]
	var card : CardControl = param[1]
	
	var id = m_slot.apply_card(m_idCard)
	if (id != -1):
		m_specialityType = id
		GameEvents.OnShowPopupSpeciality.Call([self, id])
		GameEvents.OnRemoveBoardCards.Call([[card]])
		GameEvents.OnLoadDiscard.Call([[card]])
		return true
	return false
	#GameEvents.OnLoadDiscard(param)

func UseSpeciality(type : int):
	m_slot.apply_speciality(m_specialityType, type)
	
func SetTypeDetector(cardMovement : CardMovement):
	cardMovement.SetSpecialityDetector()
