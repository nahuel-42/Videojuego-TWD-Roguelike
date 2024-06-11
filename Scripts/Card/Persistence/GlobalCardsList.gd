#class_name GlobalCards
extends Node

# SpellCard: id, cardName, description, sprite, cost
# PassiveCard: id, cardName, description, sprite, cost, active, type, effect, value
# Tower: id, type, subtype ,cardName, description, sprite, cost, active, range, damage, attackSpeed, presition
# PowerUpCard: id, cardName, description, sprite, cost, active, type

var CollectionCard = [
	################# TOWERS ####################
	{"id":0, "type": "tower", "cardName" : "Single Target Tower", "desc":"A tower that shoots piercing arrows", "sprite": "res://Assets/Sprites/Cards/Tower/FireArrowT.png", "cost":20, "range": 170, "damage": 1, "attackSpeed": 1, "accuracy": 0.1, "unlocked": 1, 'path':'res://Prefabs/Towers/one_target_tower.tscn'},
	{"id":1, "type": "tower", "cardName" : "Area Tower", "desc":"A tower that damages everything in it's range", "sprite": "res://Assets/Sprites/Cards/Tower/FireAreaT.png", "cost":50, "range": 125, "damage": 1, "attackSpeed": 1, "accuracy": 0.1, "unlocked": 1, 'path':'res://Prefabs/Towers/all_in_range_tower.tscn'},
	{"id":2, "type": "tower", "cardName" : "Bomb Tower", "desc":"A tower that throws explosive bombs", "sprite": "res://Assets/Sprites/Cards/Tower/FireBombT.png", "cost":35, "range": 150, "damage": 1, "attackSpeed": 2, "accuracy": 0.1, "unlocked": 0, 'path':'res://Prefabs/Towers/area_tower.tscn'},
	{"id":11, "type": "tower", "cardName" : "Single Target Tower", "desc":"A tower that shoots piercing arrows", "sprite": "res://Assets/Sprites/Cards/Tower/IceArrowT.png", "cost":20, "range": 170, "damage": 1, "attackSpeed": 1, "accuracy": 0.1, "unlocked": 1, 'path':'res://Prefabs/Towers/one_target_tower.tscn'},
	{"id":12, "type": "tower", "cardName" : "Area Tower", "desc":"A tower that damages everything in it's range", "sprite": "res://Assets/Sprites/Cards/Tower/IceAreaT.png", "cost":50, "range": 125, "damage": 1, "attackSpeed": 1, "accuracy": 0.1, "unlocked": 1, 'path':'res://Prefabs/Towers/all_in_range_tower.tscn'},
	{"id":13, "type": "tower", "cardName" : "Bomb Tower", "desc":"A tower that throws explosive bombs", "sprite": "res://Assets/Sprites/Cards/Tower/IceBombT.png", "cost":35, "range": 150, "damage": 1, "attackSpeed": 2, "accuracy": 0.1, "unlocked": 0, 'path':'res://Prefabs/Towers/area_tower.tscn'},
	################# CLASSES ####################
	{"id": 3, "type": "class", "cardName": "Class: Hunter", "desc": "The tower deals x2 damage to enemy beasts", "sprite": "res://Assets/Sprites/Cards/Class/Hunter.png", "texture": "res://Assets/Sprites/Enemy/Orc Crew/Orc - Shaman/Idle/Idle-Sheet.png", "cost": 30, "unlocked": 0, 'path':"res://Prefabs/Specialities/Hunter.tscn"},
	{"id": 4, "type": "class", "cardName": "Class: Soldier", "desc": "The tower deals x2 damage to enemy soldiers", "sprite": "res://Assets/Sprites/Cards/Class/Soldier.png", "texture": "res://Assets/Sprites/Heroes/Knight/Idle/Idle-Sheet.png", "cost": 30, "unlocked": 0, 'path':"res://Prefabs/Specialities/War.tscn"},
	{"id": 5, "type": "class", "cardName": "Class: Mercenary", "desc": "The tower deals x2 damage to enemy mercenaries", "sprite": "res://Assets/Sprites/Cards/Class/Mercenary.png", "texture": "res://Assets/Sprites/Enemy/Skeleton Crew/Skeleton - Mage/Idle/Idle-Sheet.png", "cost": 30, "unlocked": 0, 'path':"res://Prefabs/Specialities/Mercenary.tscn"},
	################# SPECIALITY ####################
	{"id": 6, "type": "speciality", "cardName": "Speciality", "desc": "Select between three specialities depending on class", "sprite": "res://Assets/Sprites/Cards/Speciality/Speciality.png", "texture": "res://Assets/Sprites/Enemy/Orc Crew/Orc - Shaman/Idle/Idle-Sheet.png", "cost": 100, "unlocked": 1, 'path':"res://Prefabs/Specialities/Hunter.tscn"},
	################# UPGRADES ####################
	{"id": 7, "type": "upgrade", "cardName": "Damage++", "desc": "Increases tower damage by 10%", "sprite": "res://Assets/Sprites/Cards/Upgrade/Damage.png", "cost": 10, "unlocked": 1, "range": 0, "damage": 0.1, "attack_speed": 0, "accuracy": 0},
	{"id": 8, "type": "upgrade", "cardName": "Range++", "desc": "Increases tower range by 10%", "sprite": "res://Assets/Sprites/Cards/Upgrade/Range.png", "cost": 10, "unlocked": 1, "range": 0.1, "damage": 0, "attack_speed": 0, "accuracy": 0},
	{"id": 9, "type": "upgrade", "cardName": "Attack speed++", "desc": "Increases tower attack speed by 10%", "sprite": "res://Assets/Sprites/Cards/Upgrade/AttackSpeed.png", "cost": 10, "unlocked": 1, "range": 0, "damage": 0, "attack_speed": 0.1, "accuracy": 0},
	{"id": 10, "type": "upgrade", "cardName": "Accuracy++", "desc": "Increases tower accuracy by 10%", "sprite": "res://Assets/Sprites/Cards/Upgrade/Accuracy.png", "cost": 10, "unlocked": 1, "range": 0, "damage": 0, "attack_speed": 0, "accuracy": 0.1},
	################# Spell ####################
	{"id":14, "type": "demolitionSpell", "cardName" : "Demolition", "desc":"Clears an enemy campament", "sprite": "res://Assets/Sprites/Cards/Spells/CampDestruction.png", "cost":30, "range": 0, "damage": 0, "attackSpeed": 0, "accuracy": 0, "unlocked": 1, 'path':''},
	#{"id":15, "type": "spell", "cardName" : "Tower removal", "desc":"Removes a friendly tower and clears the slot", "sprite": "res://Assets/Sprites/Cards/Spells/TowerRemoval.png", "cost":15, "range": 0, "damage": 0, "attackSpeed": 0, "accuracy": 0, "unlocked": 1, 'path':''},
	{"id":16, "type": "spell", "cardName" : "Fireball", "desc":"Throws a fireball in the selected area", "sprite": "res://Assets/Sprites/Cards/Spells/Fireball.png", "cost":30, "range": 200, "damage": 0, "attackSpeed": 0, "accuracy": 0, "unlocked": 1, 'path':''},
	{"id":17, "type": "spell", "cardName" : "Iceball", "desc":"Throws an iceball in the selected area", "sprite": "res://Assets/Sprites/Cards/Spells/Iceball.png", "cost":30, "range": 250, "damage": 0, "attackSpeed": 0, "accuracy": 0, "unlocked": 1, 'path':''},
	################# Passives ####################
	{"id":18, "type": "passive", "cardName" : "Burning Field", "desc":"The fire enrages your troops, making them shoot faster", "sprite": "res://Assets/Sprites/Cards/Passive/BurningField.png", "cost":80, "range": 0, "damage": 0, "attackSpeed": 0, "accuracy": 0, "unlocked": 1, 'path':'', "modifier": 1.2},
	{"id":19, "type": "passive", "cardName" : "Frozen Field", "desc":"Freezes the ground, slowing all enemies", "sprite": "res://Assets/Sprites/Cards/Passive/FrozenField.png", "cost":80, "range": 0, "damage": 0, "attackSpeed": 0, "accuracy": 0, "unlocked": 1, 'path':'', "modifier": 0.8}
]

#FireCards, IceCards
var TypeDeckCards = [
#	[19,18,11,0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,16,17],#para probar todas las cartas
[6,11,11,11,11,12,12,12,13,13,3,3,4,4,5,5,6,7,7,7,8,8,8,9,9,9,10,10,10,14,14,17,17,17,19,19],
[0,0,0,0,1,1,1,2,2,3,3,4,4,5,5,6,7,7,7,8,8,8,9,9,9,10,10,10,14,14,16,16,16,18,18]	
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

######################################
###funciones que mezclan las cartas###
######################################
func GenerateDeck(deck):
	deck=randomizeDeck(deck)
	return deck
func randomizeDeck(deck):
	var cant=0
	var rng = RandomNumberGenerator.new()
	var aux=[]
	var auxTow=[null,null,null]
	var j
	
	for i in len(deck):
		aux.append(null)
	for i in len(deck):
		j=rng.randi_range(0, len(deck)-1)
		while (aux[j]!=null):
			j=rng.randi_range(0, len(deck)-1)
		aux[j]=deck[i]
	deck=aux
	return deck
func isTower(id):
	if (id<=2 or id>=11 and id<=13):
		return true
	else:
		return false
######################################
