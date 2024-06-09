class_name SpecialityCard
extends ActiveCard

func use(param):
	print("Se uso SpecialityCard")
	return false
	#GameEvents.OnLoadDiscard(param)
#por ahora, se agregan a los slots/torre y van a un array del mapa o algo similar

func SetTypeDetector(cardMovement):
	cardMovement.SetSpecialityDetector()
