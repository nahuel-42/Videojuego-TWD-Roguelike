#class_name GlobalCards
extends Node

# SpellCard: id, cardName, description, sprite, cost
# PassiveCard: id, cardName, description, sprite, cost, active, type, effect, value
# Tower: id, type, subtype ,cardName, description, sprite, cost, active, range, damage, attackSpeed, presition
# PowerUpCard: id, cardName, description, sprite, cost, active, type

var CollectionCard = [
	################# TOWERS ####################
	{"id":0, "type": "tower", "cardName" : "Single Target Tower", "desc":"Data", "sprite": "res://Assets/Sprites/Cards/Tower/FireArrowT.png", "cost":20, "range": 170, "damage": 1, "attackSpeed": 1, "accuracy": 0.1, "unlocked": 1, 'path':'res://Prefabs/Towers/one_target_tower.tscn'},
	{"id":1, "type": "tower", "cardName" : "Area Tower", "desc":"Data", "sprite": "res://Assets/Sprites/Cards/Tower/FireAreaT.png", "cost":50, "range": 125, "damage": 1, "attackSpeed": 1, "accuracy": 0.1, "unlocked": 1, 'path':'res://Prefabs/Towers/all_in_range_tower.tscn'},
	{"id":2, "type": "tower", "cardName" : "Bomb Tower", "desc":"Data", "sprite": "res://Assets/Sprites/Cards/Tower/FireBombT.png", "cost":35, "range": 150, "damage": 1, "attackSpeed": 2, "accuracy": 0.1, "unlocked": 1, 'path':'res://Prefabs/Towers/area_tower.tscn'},
	{"id":11, "type": "tower", "cardName" : "Single Target Tower", "desc":"", "sprite": "res://Assets/Sprites/Cards/Tower/IceArrowT.png", "cost":20, "range": 150, "damage": 1, "attackSpeed": 1, "accuracy": 0.1, "unlocked": 1, 'path':'res://Prefabs/Towers/one_target_tower.tscn'},
	{"id":12, "type": "tower", "cardName" : "Area Tower", "desc":"", "sprite": "res://Assets/Sprites/Cards/Tower/IceAreaT.png", "cost":50, "range": 125, "damage": 1, "attackSpeed": 1, "accuracy": 0.1, "unlocked": 1, 'path':'res://Prefabs/Towers/all_in_range_tower.tscn'},
	{"id":13, "type": "tower", "cardName" : "Bomb Tower", "desc":"", "sprite": "res://Assets/Sprites/Cards/Tower/IceBombT.png", "cost":35, "range": 150, "damage": 1, "attackSpeed": 1, "accuracy": 0.1, "unlocked": 1, 'path':'res://Prefabs/Towers/area_tower.tscn'},
	################# CLASSES ####################
	{"id": 3, "type": "class", "cardName": "Hunter class", "desc": "+10% damage to beasts", "sprite": "res://Assets/Sprites/Cards/Class/Hunter.png", "texture": "res://Assets/Sprites/Enemy/Orc Crew/Orc - Shaman/Idle/Idle-Sheet.png", "cost": 30, "unlocked": 1, 'path':"res://Prefabs/Specialities/Hunter.tscn"},
	{"id": 4, "type": "class", "cardName": "Soldier class", "desc": "+10% damage to ", "sprite": "res://Assets/Sprites/Cards/Class/Soldier.png", "texture": "res://Assets/Sprites/Heroes/Knight/Idle/Idle-Sheet.png", "cost": 30, "unlocked": 1, 'path':"res://Prefabs/Specialities/War.tscn"},
	{"id": 5, "type": "class", "cardName": "Mercenary class", "desc": "+10% damage to ", "sprite": "res://Assets/Sprites/Cards/Class/Mercenary.png", "texture": "res://Assets/Sprites/Enemy/Skeleton Crew/Skeleton - Mage/Idle/Idle-Sheet.png", "cost": 30, "unlocked": 1, 'path':"res://Prefabs/Specialities/Mercenary.tscn"},
	################# SPECIALITY ####################
	{"id": 6, "type": "speciality", "cardName": "Speciality", "desc": "Select between three specialities depending on class", "sprite": "res://Assets/Sprites/Cards/Speciality/Speciality.png", "texture": "res://Assets/Sprites/Enemy/Orc Crew/Orc - Shaman/Idle/Idle-Sheet.png", "cost": 100, "unlocked": 1, 'path':"res://Prefabs/Specialities/Hunter.tscn"},
	################# UPGRADES ####################
	{"id": 7, "type": "upgrade", "cardName": "Damage++", "desc": "+10% damage", "sprite": "res://Assets/Sprites/Cards/Upgrade/Damage.png", "cost": 10, "unlocked": 1, "range": 0, "damage": 0.1, "attack_speed": 0, "accuracy": 0},
	{"id": 8, "type": "upgrade", "cardName": "Range++", "desc": "+10% range", "sprite": "res://Assets/Sprites/Cards/Upgrade/Range.png", "cost": 10, "unlocked": 1, "range": 0.1, "damage": 0, "attack_speed": 0, "accuracy": 0},
	{"id": 9, "type": "upgrade", "cardName": "Attack speed++", "desc": "+10% attack speed", "sprite": "res://Assets/Sprites/Cards/Upgrade/AttackSpeed.png", "cost": 10, "unlocked": 1, "range": 0, "damage": 0, "attack_speed": 0.1, "accuracy": 0},
	{"id": 10, "type": "upgrade", "cardName": "Accuracy++", "desc": "+10% accuracy", "sprite": "res://Assets/Sprites/Cards/Upgrade/Accuracy.png", "cost": 10, "unlocked": 1, "range": 0, "damage": 0, "attack_speed": 0, "accuracy": 0.1},
	################# Spell ####################
	{"id":14, "type": "spell", "cardName" : "Campament destruction", "desc":"Clears an enemy campament", "sprite": "res://Assets/Sprites/Cards/Spells/CampDestruction.png", "cost":30, "range": 0, "damage": 0, "attackSpeed": 0, "accuracy": 0, "unlocked": 1, 'path':''},
	#{"id":15, "type": "spell", "cardName" : "Tower removal", "desc":"Removes a friendly tower and clears the slot", "sprite": "res://Assets/Sprites/Cards/Spells/TowerRemoval.png", "cost":15, "range": 0, "damage": 0, "attackSpeed": 0, "accuracy": 0, "unlocked": 1, 'path':''},
	{"id":16, "type": "spell", "cardName" : "Fireball", "desc":"Throws a fireball in the selected area", "sprite": "res://Assets/Sprites/Cards/Spells/Fireball.png", "cost":30, "range": 0, "damage": 0, "attackSpeed": 0, "accuracy": 0, "unlocked": 1, 'path':''},
	{"id":17, "type": "spell", "cardName" : "Iceball", "desc":"Throws an iceball in the selected area", "sprite": "res://Assets/Sprites/Cards/Spells/Iceball.png", "cost":30, "range": 0, "damage": 0, "attackSpeed": 0, "accuracy": 0, "unlocked": 1, 'path':''},
	################# Passives ####################
	{"id":18, "type": "passive", "cardName" : "Burning Field", "desc":"Sets the ground on fire, damaging all enemies (by ---) every second", "sprite": "res://Assets/Sprites/Cards/Passive/BurningField.png", "cost":80, "range": 0, "damage": 0, "attackSpeed": 0, "accuracy": 0, "unlocked": 1, 'path':''},
	{"id":19, "type": "passive", "cardName" : "Frozen Field", "desc":"Freezes the ground, slowing all enemies (by---)", "sprite": "res://Assets/Sprites/Cards/Passive/FrozenField.png", "cost":80, "range": 0, "damage": 0, "attackSpeed": 0, "accuracy": 0, "unlocked": 1, 'path':''}
]

#static var FireCards = [0,0,1,1]
#static var IceCards = [0,0,1,1]
var TypeDeckCards = [
	[19,18,11,0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,16,17],#para probar todas las cartas
	[0,1,2,8,3,14,18],
	[0,2,1,1]
]
	
func find_card(id):
	var card = null
	var i : int = 0
	while (i < len(CollectionCard) && card == null):
		if (CollectionCard[i]["id"] == id):
			card = CollectionCard[i]
		i += 1
	return card

func get_type(id):
	return TypeDeckCards[id]
	
func get_unlocked_cards():
	var unlocked_cards = []
	for c in CollectionCard:
		var node = [c["id"], c["unlocked"] == 1]
		unlocked_cards.append(node)
	print(unlocked_cards)
	return unlocked_cards
