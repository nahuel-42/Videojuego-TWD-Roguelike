extends ActiveCard
class_name PowerUpCard

#func init():
#la defino cuando sepa donde va

func use(param):
	print("Se uso PowerCard")
	#GameEvents.OnLoadDiscard(param)
#por ahora, se agregan a los slots/torre y van a un array del mapa o algo similar

func SetTypeDetector(cardMovement):
	cardMovement.SetPowerDetector()
