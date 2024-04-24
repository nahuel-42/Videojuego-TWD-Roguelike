class_name GlobalCards
extends Node

# SpellCard: id, cardName, description, sprite, cost
# PassiveCard: id, cardName, description, sprite, cost, active, type, effect, value
# Tower: id, type, subtype ,cardName, description, sprite, cost, active, range, damage, attackSpeed, presition
# PowerUpCard: id, cardName, description, sprite, cost, active, type

static var CollectionCard = [
	################# TOWERS ####################
	{"id":0, "type": "tower", "cardName" : "Fire Tower", "desc":"Data", "sprite":"res://Assets/Fire1.png", "cost":100, "range": 20, "damage":20, "attackSpeed": 1, "presition": 0.1, "unlocked": 1, 'path':'res://X.tscn'},
	{"id":1, "type": "tower", "cardName" : "Fire Tower2", "desc":"Data", "sprite":"res://Assets/Fire2.png", "cost":100, "range": 20, "damage":20, "attackSpeed": 1, "presition": 0.1, "unlocked": 1, 'path':'res://X.tscn'},
	{"id":2, "type": "tower", "cardName" : "Fire Tower3", "desc":"Data", "sprite":"url1", "cost":100, "range": 20, "damage":20, "attackSpeed": 1, "presition": 0.1, "unlocked": 0, 'path':'res://X.tscn'}
	################# Activate Card ####################
	################# POWER ####################
	################# Spell ####################
	################# Camp ####################
]

#static var FireCards = [0,0,1,1]
#static var IceCards = [0,0,1,1]
static var TypeDeckCards = [
	[0,0,1,2],
	[0,2,1,1]
	]
