extends ActiveCard
class_name DemolitionSpellCard

func use(param):
	var slot = param[0]
	print("Se usa DemolisionSpellCard")
	var ref_spawner = param[0]
	WaveManager.deactivate_spawner(ref_spawner)
	#llamada para generar un slot de torre <3 (cuando lo encuentre)
	return true

func SetTypeDetector(cardMovement):
	cardMovement.SetSlotDetector()
