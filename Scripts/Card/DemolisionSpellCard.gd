extends ActiveCard
class_name DemolitionSpellCard

func use(param):
	print("Se usa DemolisionSpellCard")
	var ref_spawner = param[0]
	var card = param[1]
	if (WaveManager.deactivate_spawner(ref_spawner)):
		GameEvents.OnRemoveBoardCards.Call([[card]])
		GameEvents.OnLoadDiscard.Call([[card]])
		return true
	return false

func SetTypeDetector(cardMovement : CardMovement):
	cardMovement.SetDemolitionDetector()
