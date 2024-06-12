extends Node
class_name CardFactory
static var cardScene : String 

static func createCard(id):
	cardScene = 'res://Scenes/card.tscn'
	var scene = load(cardScene)
	var cardData = GlobalCardsList.find_card(id) #obtiene la linea a partir de la funcion, no accede a la collection directamente
	var instance = scene.instantiate()		
	var type = cardData.type

	if(type == 'spell'):
		instance.Init(SpellCard.new(id, cardData))
	elif(type == 'passive'):
		instance.Init(PassiveCard.new(id, cardData))
	elif (type == 'upgrade'):
		instance.Init(PowerUpCard.new(id, cardData))
	elif (type == 'tower'):
		instance.Init(TowerCard.new(id, cardData))
	elif (type=='class'):
		instance.Init(ClassCard.new(id, cardData))
	elif (type=='speciality'):
		instance.Init(SpecialityCard.new(id, cardData))
	elif (type == 'demolitionSpell'):
		instance.Init(DemolitionSpellCard.new(id, cardData))
	elif (type == 'chest'):
		instance.Init(ChestCard.new(id, cardData))
	else: 
		print("Error type card: "  + str(type))
	return instance
