extends BaseCard
class_name SpellCard
#puede que sea: class_name SpellCard extends 'BaseCard.gd'
#no interactuan con slots, podrian interactuar con el mapa

#func _init(id, cardName, description, sprite, cost):
#	super._init(id, cardName, description, sprite, cost)

func use(param):
	print("se usa SpellCard")
	return false
	#Se usa y va al descarte

func SetTypeDetector(cardMovement):
	cardMovement.SetSpellDetector()
