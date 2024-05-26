extends Node
class_name CardFactory
static var cardScene : String = 'res://Scenes/card.tscn'

static func createCard(id):
	var card: BaseCard = null
#	var id = dict[0]
#	var type = dict[1]
#	var cardName = dict[2]
#	var desc = dict[3]
#	var sprite = dict[4] 
#	var cost = dict[5]

	var scene = load(cardScene)
	
	#el diccionario aca serian las cartas del juegador (gameDeck)
	#var card = CardFactory.CreateCards(gameDeck[i]) 
	var instance = scene.instantiate()		

	var type = GlobalCardsList.CollectionCard[id]['type']
	#instance.Init(TowerCard.new(id, GlobalCardsList.CollectionCard[id]))




	if(type == 'spell'):
		instance.Init(SpellCard.new(id, GlobalCardsList.CollectionCard[id]))

# SpellCard: id, cardName, desc, sprite, cost
# los mismos que la baseCard
#		pass
	elif(type == 'passive'):
# PassiveCard: id, cardName, description, sprite, cost, active, type, effect, value
		instance.Init(PassiveCard.new(id, GlobalCardsList.CollectionCard[id]))

#		pass
	elif (type == 'powerUp'):
	# PowerUpCard: id, cardName, description, sprite, cost, active, type
		instance.Init(PowerUpCard.new(id, GlobalCardsList.CollectionCard[id]))

#		pass
	elif (type == 'tower'):
	# Tower: id, type, subtype ,cardName, description, sprite, cost, active, range, damage, attackSpeed, presition
		instance.Init(TowerCard.new(id, GlobalCardsList.CollectionCard[id]))
#		pass
	return instance
