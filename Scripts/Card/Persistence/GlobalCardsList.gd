class_name GlobalCards
extends Node

# SpellCard: id, cardName, description, sprite, cost
# PassiveCard: id, cardName, description, sprite, cost, active, type, effect, value
# Tower: id, type, subtype ,cardName, description, sprite, cost, active, range, damage, attackSpeed, presition
# PowerUpCard: id, cardName, description, sprite, cost, active, type

var CollectionCard = [
	################# TOWERS ####################
	{"id":0, "type": "tower", "cardName" : "Fire Archer Tower", "desc":"", "sprite": "res://Assets/Sprites/Rogue.png", "cost":100, "range": 150, "damage": 1, "attackSpeed": 1, "accuracy": 0.1, "unlocked": 1, 'path':'res://prefabs/archer_tower.tscn'},
	{"id":1, "type": "tower", "cardName" : "Fire Area Tower", "desc":"", "sprite": "res://Assets/Sprites/Wizard.png", "cost":100, "range": 125, "damage": 1, "attackSpeed": 1, "accuracy": 0.1, "unlocked": 1, 'path':'res://prefabs/area_tower.tscn'},
	{"id":2, "type": "tower", "cardName" : "Fire Bomb Tower", "desc":"", "sprite": "", "cost":100, "range": 150, "damage": 1, "attackSpeed": 1, "accuracy": 0.1, "unlocked": 1, 'path':''},
	{"id":3, "type": "tower", "cardName" : "Ice Archer Tower", "desc":"", "sprite": "", "cost":100, "range": 125, "damage": 1, "attackSpeed": 1, "accuracy": 0.1, "unlocked": 1, 'path':''},
	{"id":4, "type": "tower", "cardName" : "Ice Area Tower", "desc":"", "sprite": "", "cost":100, "range": 150, "damage": 1, "attackSpeed": 1, "accuracy": 0.1, "unlocked": 1, 'path':''},
	{"id":5, "type": "tower", "cardName" : "Ice Bomb Tower", "desc":"", "sprite": "", "cost":100, "range": 125, "damage": 1, "attackSpeed": 1, "accuracy": 0.1, "unlocked": 1, 'path':''},
	################# Upgrade Card #############
	
	################# Activate Card #############
	################# Spell ####################
	################# Camp ####################
]

#static var FireCards = [0,0,1,1]
#static var IceCards = [0,0,1,1]
var TypeDeckCards = [
	[0,0,1,1,1,2],
	[0,2,1,1]
]
	
func find_card(id):
	return CollectionCard[id]

func get_type(id):
	return TypeDeckCards[id]
	
func get_unlocked_cards():
	var unlocked_cards = []
	for c in CollectionCard:
		unlocked_cards.append(c["unlocked"] == 1)
	return unlocked_cards
