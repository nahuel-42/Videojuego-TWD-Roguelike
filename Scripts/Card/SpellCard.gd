extends BaseCard
class_name SpellCard
#puede que sea: class_name SpellCard extends 'BaseCard.gd'
#no interactuan con slots, podrian interactuar con el mapa

#func _init(id, cardName, description, sprite, cost):
#	super._init(id, cardName, description, sprite, cost)

func use(param):
	print("se usa SpellCard")
	
	var info = []
	info.append(m_refCard["cardName"])
	info.append(param[0])
	info.append(m_refCard["range"])
	info.append(m_refCard["damage"])
	info.append(1)
	
	GameEvents.OnSpellCardActivated.Call(info)
	#Se usa y va al descarte

func SetTypeDetector(cardMovement):
	cardMovement.SetSpellDetector()
