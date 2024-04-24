extends Node
class_name CardFactory
var cardScene : String = 'res://Scenes/card.tscn'
func createCard(id):
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

	var type = GlobalCards.CollectionCard[id]['type']
	instance._init(TowerCard.new(id, GlobalCards.CollectionCard[id]))




	if(type == 'spell'):
		instance._init(SpellCard.new(id, GlobalCards.CollectionCard[id]))

# SpellCard: id, cardName, desc, sprite, cost
# los mismos que la baseCard
#		pass
	elif(type == 'passive'):
# PassiveCard: id, cardName, description, sprite, cost, active, type, effect, value
		instance._init(PassiveCard.new(id, GlobalCards.CollectionCard[id]))

#		pass
	elif (type == 'powerUp'):
	# PowerUpCard: id, cardName, description, sprite, cost, active, type
		instance._init(PowerUpCard.new(id, GlobalCards.CollectionCard[id]))

#		pass
	elif (type == 'tower'):
	# Tower: id, type, subtype ,cardName, description, sprite, cost, active, range, damage, attackSpeed, presition
		instance._init(TowerCard.new(id, GlobalCards.CollectionCard[id]))
#		pass
#	return card
