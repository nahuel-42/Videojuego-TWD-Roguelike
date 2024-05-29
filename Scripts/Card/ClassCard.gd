class_name ClassCard
extends ActiveCard

func use(param):
	print("Se uso PowerCard")
	#GameEvents.OnLoadDiscard(param)
#por ahora, se agregan a los slots/torre y van a un array del mapa o algo similar

func SetTypeDetector(cardMovement):
	cardMovement.SetClassDetector()
