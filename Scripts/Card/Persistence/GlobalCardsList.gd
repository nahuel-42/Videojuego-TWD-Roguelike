#class_name GlobalCards
extends Node

# SpellCard: id, cardName, description, sprite, cost
# PassiveCard: id, cardName, description, sprite, cost, active, type, effect, value
# Tower: id, type, subtype ,cardName, description, sprite, cost, active, range, damage, attackSpeed, presition
# PowerUpCard: id, cardName, description, sprite, cost, active, type

var CollectionCard = [
	################# TOWERS ####################
	{"id":0, "type": "tower", "cardName" : "One target tower", "desc":"Data", "sprite": "res://Assets/Sprites/TowerCards/One_target_tower.png", "cost":100, "range": 170, "damage": 1, "attackSpeed": 1, "accuracy": 0.1, "unlocked": 1, 'path':'res://Prefabs/Towers/one_target_tower.tscn'},
	{"id":1, "type": "tower", "cardName" : "All in range Tower", "desc":"Data", "sprite": "res://Assets/Sprites/TowerCards/All_in_range_tower.png", "cost":100, "range": 125, "damage": 1, "attackSpeed": 1, "accuracy": 0.1, "unlocked": 1, 'path':'res://Prefabs/Towers/all_in_range_tower.tscn'},
	{"id":2, "type": "tower", "cardName" : "Area Tower", "desc":"Data", "sprite": "res://Assets/Sprites/TowerCards/Area_tower.png", "cost":100, "range": 150, "damage": 1, "attackSpeed": 2, "accuracy": 0.1, "unlocked": 1, 'path':"res://Prefabs/Towers/area_tower.tscn"},
	################# CLASSES ####################
	{"id": 3, "type": "class", "cardName": "Hunter class", "desc": "Data", "sprite": "res://Assets/Sprites/SpecialitiesCards/Hunter.png", "texture": "res://Assets/Sprites/Enemy/Orc Crew/Orc - Shaman/Idle/Idle-Sheet.png", "cost": 100, "unlocked": 1, 'path':"res://Prefabs/Specialities/Hunter.tscn"},
	{"id": 4, "type": "class", "cardName": "War class", "desc": "Data", "sprite": "res://Assets/Sprites/SpecialitiesCards/War.png", "texture": "res://Assets/Sprites/Heroes/Knight/Idle/Idle-Sheet.png", "cost": 100, "unlocked": 1, 'path':"res://Prefabs/Specialities/War.tscn"},
	{"id": 5, "type": "class", "cardName": "Mercenary class", "desc": "Data", "sprite": "res://Assets/Sprites/SpecialitiesCards/Mercenary.png", "texture": "res://Assets/Sprites/Enemy/Skeleton Crew/Skeleton - Mage/Idle/Idle-Sheet.png", "cost": 100, "unlocked": 1, 'path':"res://Prefabs/Specialities/Mercenary.tscn"},
	################# SPECIALITY ####################
	{"id": 6, "type": "speciality", "cardName": "Speciality", "desc": "Data", "sprite": "res://Assets/Sprites/SpecialitiesCards/Speciality.png", "texture": "res://Assets/Sprites/Enemy/Orc Crew/Orc - Shaman/Idle/Idle-Sheet.png", "cost": 100, "unlocked": 1, 'path':"res://Prefabs/Specialities/Hunter.tscn"},
	################# UPGRADES ####################
	{"id": 7, "type": "upgrade", "cardName": "Damage++", "desc": "Data", "sprite": "res://Assets/Sprites/UpgradeCards/Damage.png", "cost": 100, "unlocked": 1, "range": 0, "damage": 1, "attack_speed": 0, "accuracy": 0},
	{"id": 8, "type": "upgrade", "cardName": "Range++", "desc": "Data", "sprite": "res://Assets/Sprites/UpgradeCards/Range.png", "cost": 100, "unlocked": 1, "range": 0.1, "damage": 0, "attack_speed": 0, "accuracy": 0},
	{"id": 9, "type": "upgrade", "cardName": "Attack speed++", "desc": "Data", "sprite": "res://Assets/Sprites/UpgradeCards/Attack speed.png", "cost": 100, "unlocked": 1, "range": 0, "damage": 0, "attack_speed": 0.1, "accuracy": 0},
	{"id": 10, "type": "upgrade", "cardName": "Accuracy++", "desc": "Data", "sprite": "res://Assets/Sprites/UpgradeCards/Accuracy.png", "cost": 100, "unlocked": 1, "range": 0, "damage": 0, "attack_speed": 0, "accuracy": 0.1},
	################# POWER ####################
	################# Spell ####################
	################# Camp ####################
]

#static var FireCards = [0,0,1,1]
#static var IceCards = [0,0,1,1]
var TypeDeckCards = [
	[0,1,7,8,3],
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
