class_name GlobalCards
extends Node

# SpellCard: id, cardName, description, sprite, cost
# PassiveCard: id, cardName, description, sprite, cost, active, type, effect, value
# Tower: id, type, subtype ,cardName, description, sprite, cost, active, range, damage, attackSpeed, presition
# PowerUpCard: id, cardName, description, sprite, cost, active, type

var CollectionCard = [
	################# TOWERS ####################
	{"id":0, "type": "tower", "cardName" : "Archer tower", "desc":"", "sprite": "res://Assets/Sprites/Cards/Tower/FireArcherT.png", "cost":100, "range": 150, "damage": 1, "attackSpeed": 1, "accuracy": 0.1, "unlocked": 1, 'path':'res://prefabs/archer_tower.tscn'},
	{"id":1, "type": "tower", "cardName" : "Area tower", "desc":"", "sprite": "res://Assets/Sprites/Cards/Tower/FireAreaT.png", "cost":100, "range": 125, "damage": 1, "attackSpeed": 1, "accuracy": 0.1, "unlocked": 1, 'path':'res://prefabs/area_tower.tscn'},
	{"id":2, "type": "tower", "cardName" : "Bomb tower", "desc":"", "sprite": "res://Assets/Sprites/Cards/Tower/FireBombT.png", "cost":100, "range": 150, "damage": 1, "attackSpeed": 1, "accuracy": 0.1, "unlocked": 1, 'path':''},
	{"id":3, "type": "tower", "cardName" : "Archer tower", "desc":"", "sprite": "res://Assets/Sprites/Cards/Tower/IceArcherT.png", "cost":100, "range": 150, "damage": 1, "attackSpeed": 1, "accuracy": 0.1, "unlocked": 1, 'path':'res://prefabs/archer_tower.tscn'},
	{"id":4, "type": "tower", "cardName" : "Area tower", "desc":"", "sprite": "res://Assets/Sprites/Cards/Tower/IceAreaT.png", "cost":100, "range": 125, "damage": 1, "attackSpeed": 1, "accuracy": 0.1, "unlocked": 1, 'path':'res://prefabs/area_tower.tscn'},
	{"id":5, "type": "tower", "cardName" : "Bomb tower", "desc":"", "sprite": "res://Assets/Sprites/Cards/Tower/IceBombT.png", "cost":100, "range": 150, "damage": 1, "attackSpeed": 1, "accuracy": 0.1, "unlocked": 1, 'path':''},

	################# POWERUP / UPGRADES #############
	{"id":6, "type": "powerUp", "cardName" : "+ Damage", "desc":"", "sprite": "res://Assets/Sprites/Cards/Upgrade/Damage.png", "cost":0, "range": 0, "damage": 1, "attackSpeed": 0, "accuracy": 0, "unlocked": 1, 'path':''},
	{"id":7, "type": "powerUp", "cardName" : "+ Accuracy", "desc":"", "sprite": "res://Assets/Sprites/Cards/Upgrade/Accuracy.png", "cost":0, "range": 0, "damage": 1, "attackSpeed": 0, "accuracy": 0, "unlocked": 1, 'path':''},
	{"id":8, "type": "powerUp", "cardName" : "+ Attack speed", "desc":"", "sprite": "res://Assets/Sprites/Upgrade/Cards/AttackSpeed.png", "cost":0, "range": 0, "damage": 1, "attackSpeed": 0, "accuracy": 0, "unlocked": 1, 'path':''},
	{"id":9, "type": "powerUp", "cardName" : "+ Range", "desc":"", "sprite": "res://Assets/Sprites/Cards/Upgrade/Range.png", "cost":0, "range": 0, "damage": 1, "attackSpeed": 0, "accuracy": 0, "unlocked": 1, 'path':''},
	
	################# PASSIVE #############
	{"id":10, "type": "passive", "cardName" : "Burning field", "desc":"", "sprite": "res://Assets/Sprites/Cards/Passive/BurningField.png", "cost":0, "range": 0, "damage": 0, "attackSpeed": 0, "accuracy": 0, "unlocked": 1, 'path':''},
	{"id":11, "type": "passive", "cardName" : "Frozen field", "desc":"", "sprite": "res://Assets/Sprites/Cards/Passive/FrozenField.png", "cost":0, "range": 0, "damage": 0, "attackSpeed": 0, "accuracy": 0, "unlocked": 1, 'path':''},

	################# SPELLS ####################
	{"id":12, "type": "spell", "cardName" : "Campament destruction", "desc":"", "sprite": "res://Assets/Sprites/Cards/Spell/CampDestruction.png", "cost":0, "range": 0, "damage": 0, "attackSpeed": 0, "accuracy": 0, "unlocked": 1, 'path':''},
	{"id":13, "type": "spell", "cardName" : "Tower removal", "desc":"", "sprite": "res://Assets/Sprites/Cards/Spell/TowerRemoval.png", "cost":0, "range": 0, "damage": 0, "attackSpeed": 0, "accuracy": 0, "unlocked": 1, 'path':''},
	{"id":14, "type": "spell", "cardName" : "Fireball", "desc":"", "sprite": "res://Assets/Sprites/Cards/Spell/Fireball.png", "cost":0, "range": 0, "damage": 0, "attackSpeed": 0, "accuracy": 0, "unlocked": 1, 'path':''},
	{"id":15, "type": "spell", "cardName" : "Iceball", "desc":"", "sprite": "res://Assets/Sprites/Cards/Spell/Iceball.png", "cost":0, "range": 0, "damage": 0, "attackSpeed": 0, "accuracy": 0, "unlocked": 1, 'path':''},

	################# SPECIALIZATIONS / POWERUP ####################
	{"id":16, "type": "powerUp", "cardName" : "Hunter", "desc":"", "sprite": "res://Assets/Sprites/Cards/Specialization/Hunter.png", "cost":0, "range": 0, "damage": 0, "attackSpeed": 0, "accuracy": 0, "unlocked": 1, 'path':''},
	{"id":17, "type": "powerUp", "cardName" : "Soldier", "desc":"", "sprite": "res://Assets/Sprites/Cards/Specialization/Soldier.png", "cost":0, "range": 0, "damage": 0, "attackSpeed": 0, "accuracy": 0, "unlocked": 1, 'path':''},
	{"id":18, "type": "powerUp", "cardName" : "Mercenary", "desc":"", "sprite": "res://Assets/Sprites/Cards/Specialization/Mercenary.png", "cost":0, "range": 0, "damage": 0, "attackSpeed": 0, "accuracy": 0, "unlocked": 1, 'path':''},
	{"id":19, "type": "powerUp", "cardName" : "Specialization", "desc":"", "sprite": "res://Assets/Sprites/Cards/Specialization/Specialization.png", "cost":0, "range": 0, "damage": 0, "attackSpeed": 0, "accuracy": 0, "unlocked": 1, 'path':''},

]

#static var FireCards = [0,0,1,1]
#static var IceCards = [0,0,1,1]
var TypeDeckCards = [
	[0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19],#para probar todas las cartas
	[0,0,1,1,1,2],#fireDeck
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
