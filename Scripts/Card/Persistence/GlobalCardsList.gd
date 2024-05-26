class_name GlobalCards
extends Node

# SpellCard: id, cardName, description, sprite, cost
# PassiveCard: id, cardName, description, sprite, cost, active, type, effect, value
# Tower: id, type, subtype ,cardName, description, sprite, cost, active, range, damage, attackSpeed, presition
# PowerUpCard: id, cardName, description, sprite, cost, active, type

## LAS ID's DEBEN SER SIEMPRE CONSECUTIVAS!!!
var CollectionCard = [
	################# TOWERS ####################
	{"id":0, "type": "tower", "cardName" : "Archer Tower", "desc":"", "sprite": "res://Assets/Sprites/Rogue.png", "cost":100, "range": 150, "damage": 1, "attackSpeed": 1, "accuracy": 0.1, "unlocked": 1, 'path':'res://prefabs/archer_tower.tscn'},
	{"id":1, "type": "tower", "cardName" : "Area Tower", "desc":"", "sprite": "res://Assets/Sprites/Wizard.png", "cost":100, "range": 125, "damage": 1, "attackSpeed": 1, "accuracy": 0.1, "unlocked": 1, 'path':'res://prefabs/area_tower.tscn'},
	{"id":2, "type": "tower", "cardName" : "Bomb Tower CRASH", "desc":"", "sprite": "", "cost":100, "range": 150, "damage": 1, "attackSpeed": 1, "accuracy": 0.1, "unlocked": 1, 'path':''},
	{"id":3, "type": "tower", "cardName" : "Archer Tower", "desc":"", "sprite": "", "cost":100, "range": 125, "damage": 1, "attackSpeed": 1, "accuracy": 0.1, "unlocked": 1, 'path':''},
	################# Upgrade Cards #############
	{"id":4, "type": "tower", "cardName" : "Area Tower", "desc":"", "sprite": "", "cost":100, "range": 150, "damage": 1, "attackSpeed": 1, "accuracy": 0.1, "unlocked": 1, 'path':''},
	{"id":5, "type": "tower", "cardName" : "Bomb Tower", "desc":"", "sprite": "", "cost":100, "range": 125, "damage": 1, "attackSpeed": 1, "accuracy": 0.1, "unlocked": 1, 'path':''},
	################# Passive Cards #############
	{"id":6, "type": "passive", "cardName" : "Passive 1", "desc":"", "sprite": "", "cost":100, "range": 150, "damage": 1, "attackSpeed": 1, "accuracy": 0.1, "unlocked": 1, 'path':''},
	{"id":7, "type": "passive", "cardName" : "Passive 2", "desc":"", "sprite": "", "cost":100, "range": 125, "damage": 1, "attackSpeed": 1, "accuracy": 0.1, "unlocked": 1, 'path':''},
	################# Power/Spell Cards ####################
	{"id":8, "type": "spell", "cardName" : "Spell 1", "desc":"", "sprite": "", "cost":100, "range": 150, "damage": 1, "attackSpeed": 1, "accuracy": 0.1, "unlocked": 1, 'path':''},
	{"id":9, "type": "spell", "cardName" : "Spell 2", "desc":"", "sprite": "", "cost":100, "range": 125, "damage": 1, "attackSpeed": 1, "accuracy": 0.1, "unlocked": 1, 'path':''},
	################# Camp ####################
]

#static var FireCards = [0,0,1,1]
#static var IceCards = [0,0,1,1]
var TypeDeckCards = [
	[0,0,1,1,1,2, 6,7,8,9],#fireDeck
	[0,2,1,1] #iceDeck
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
