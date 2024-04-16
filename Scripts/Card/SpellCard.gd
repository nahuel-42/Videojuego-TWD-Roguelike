extends BaseCard
class_name SpellCard
#no interactuan con slots, podrian interactuar con el mapa

func _init(id, cardName, description, sprite, cost):
	super._init(id, cardName, description, sprite, cost)

func use():
	print("se usa SpellCard")
	#Se usa y va al descarte
