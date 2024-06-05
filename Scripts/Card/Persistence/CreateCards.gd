extends Node
class_name CardFactory
static var cardScene : String = 'res://Scenes/card.tscn'

static func createCard(id):

	var scene = load(cardScene)
	var cardData = GlobalCardsList.find_card(id) #obtiene la linea a partir de la funcion, no accede a la collection directamente
	var instance = scene.instantiate()		
	var type = cardData.type

	if(type == 'spell'):
		instance.Init(SpellCard.new(id, cardData))#GlobalCardsList.CollectionCard[id]))
	elif(type == 'passive'):
	# PassiveCard: id, cardName, description, sprite, cost, active, type, effect, value
		instance.Init(PassiveCard.new(id, cardData))# GlobalCardsList.CollectionCard[id]))
	elif (type == 'upgrade'):
	# PowerUpCard: id, cardName, description, sprite, cost, active, type
		instance.Init(PowerUpCard.new(id, cardData))# GlobalCardsList.CollectionCard[id]))
	elif (type == 'tower'):
	# Tower: id, type, subtype ,cardName, description, sprite, cost, active, range, damage, attackSpeed, presition
		instance.Init(TowerCard.new(id, cardData))# GlobalCardsList.CollectionCard[id]))
	elif (type=='class'):
		instance.Init(ClassCard.new(id, cardData))# GlobalCardsList.CollectionCard[id]))
	elif (type=='speciality'):
		instance.Init(SpecialityCard.new(id, cardData))# GlobalCardsList.CollectionCard[id]))
	else: 
		print("Error type card: "  + str(type))
	return instance
