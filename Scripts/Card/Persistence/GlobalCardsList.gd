extends Node

var CollectionCard = load_collection()

const initialCollection = [
	################# TOWERS ####################
	{"id":0, "type": "tower", "cardName" : "Single Target Tower", "desc":"A tower that shoots piercing arrows", "sprite": "res://Assets/Sprites/Cards/Tower/FireArrowT.png", "cost":40, "range": 170, "damage": 1, "attackSpeed": 1, "accuracy": 0.7, "unlocked": true, 'path':'res://Prefabs/Towers/one_target_tower.tscn'},
	{"id":1, "type": "tower", "cardName" : "Area Tower", "desc":"A tower that damages everything in its range", "sprite": "res://Assets/Sprites/Cards/Tower/FireAreaT.png", "cost":60, "range": 125, "damage": 1, "attackSpeed": 1, "accuracy": 0.7, "unlocked": true, 'path':'res://Prefabs/Towers/all_in_range_tower.tscn'},
	{"id":2, "type": "tower", "cardName" : "Bomb Tower", "desc":"A tower that throws explosive bombs", "sprite": "res://Assets/Sprites/Cards/Tower/FireBombT.png", "cost":40, "range": 150, "damage": 1, "attackSpeed": 2, "accuracy": 0.7, "unlocked": false, 'path':'res://Prefabs/Towers/area_tower.tscn'},
	{"id":11, "type": "tower", "cardName" : "Single Target Tower", "desc":"A tower that shoots piercing arrows", "sprite": "res://Assets/Sprites/Cards/Tower/IceArrowT.png", "cost":40, "range": 170, "damage": 1, "attackSpeed": 1, "accuracy": 0.7, "unlocked": true, 'path':'res://Prefabs/Towers/one_target_tower.tscn'},
	{"id":12, "type": "tower", "cardName" : "Area Tower", "desc":"A tower that damages everything in its range", "sprite": "res://Assets/Sprites/Cards/Tower/IceAreaT.png", "cost":60, "range": 125, "damage": 1, "attackSpeed": 1, "accuracy": 0.7, "unlocked": true, 'path':'res://Prefabs/Towers/all_in_range_tower.tscn'},
	{"id":13, "type": "tower", "cardName" : "Bomb Tower", "desc":"A tower that throws explosive bombs", "sprite": "res://Assets/Sprites/Cards/Tower/IceBombT.png", "cost":40, "range": 150, "damage": 1, "attackSpeed": 2, "accuracy": 0.7, "unlocked": false, 'path':'res://Prefabs/Towers/area_tower.tscn'},
	################# CLASSES ####################
	{"id": 3, "type": "class", "cardName": "Class: Hunter", "desc": "The tower deals x2 damage to enemy beasts", "sprite": "res://Assets/Sprites/Cards/Class/Hunter.png", "texture": "res://Assets/Sprites/Enemy/Orc Crew/Orc - Shaman/Idle/Idle-Sheet.png", "cost": 40, "unlocked": true, 'path':"res://Prefabs/Specialities/Hunter.tscn"},
	{"id": 4, "type": "class", "cardName": "Class: Soldier", "desc": "The tower deals x2 damage to enemy soldiers", "sprite": "res://Assets/Sprites/Cards/Class/Soldier.png", "texture": "res://Assets/Sprites/Heroes/Knight/Idle/Idle-Sheet.png", "cost": 40, "unlocked": true, 'path':"res://Prefabs/Specialities/War.tscn"},
	{"id": 5, "type": "class", "cardName": "Class: Mercenary", "desc": "The tower deals x2 damage to enemy mercenaries", "sprite": "res://Assets/Sprites/Cards/Class/Mercenary.png", "texture": "res://Assets/Sprites/Enemy/Skeleton Crew/Skeleton - Mage/Idle/Idle-Sheet.png", "cost": 40, "unlocked": true, 'path':"res://Prefabs/Specialities/Mercenary.tscn"},
	################# SPECIALITY ####################
	{"id": 6, "type": "speciality", "cardName": "Speciality", "desc": "Select between three specialities depending on class", "sprite": "res://Assets/Sprites/Cards/Speciality/Speciality.png", "texture": "res://Assets/Sprites/Enemy/Orc Crew/Orc - Shaman/Idle/Idle-Sheet.png", "cost": 100, "unlocked": true, 'path':"res://Prefabs/Specialities/Hunter.tscn"},
	################# UPGRADES ####################
	{"id": 7, "type": "upgrade", "cardName": "Damage++", "desc": "Increases tower damage by 10%", "sprite": "res://Assets/Sprites/Cards/Upgrade/Damage.png", "cost": 25, "unlocked": true, "range": 0, "damage": 0.1, "attack_speed": 0, "accuracy": 0},
	{"id": 8, "type": "upgrade", "cardName": "Range++", "desc": "Increases tower range by 10%", "sprite": "res://Assets/Sprites/Cards/Upgrade/Range.png", "cost": 25, "unlocked": true, "range": 0.1, "damage": 0, "attack_speed": 0, "accuracy": 0},
	{"id": 9, "type": "upgrade", "cardName": "Attack speed++", "desc": "Increases tower attack speed by 10%", "sprite": "res://Assets/Sprites/Cards/Upgrade/AttackSpeed.png", "cost": 25, "unlocked": true, "range": 0, "damage": 0, "attack_speed": 0.1, "accuracy": 0},
	{"id": 10, "type": "upgrade", "cardName": "Accuracy++", "desc": "Increases tower accuracy by 10%", "sprite": "res://Assets/Sprites/Cards/Upgrade/Accuracy.png", "cost": 25, "unlocked": true, "range": 0, "damage": 0, "attack_speed": 0, "accuracy": 0.1},
	################# demolitionSpell ####################
	{"id":14, "type": "demolitionSpell", "cardName" : "Demolition", "desc":"Clears an enemy campament", "sprite": "res://Assets/Sprites/Cards/Spells/CampDestruction.png", "cost":100, "range": 0, "damage": 0, "attackSpeed": 0, "accuracy": 0, "unlocked": true, 'path':''},
	################# Spell ####################
	#{"id":15, "type": "spell", "cardName" : "Tower removal", "desc":"Removes a friendly tower and clears the slot", "sprite": "res://Assets/Sprites/Cards/Spells/TowerRemoval.png", "cost":15, "range": 0, "damage": 0, "attackSpeed": 0, "accuracy": 0, "unlocked": 1, 'path':''},
	{"id":16, "type": "spell", "cardName" : "Fireball", "desc":"Throws a fireball in the selected area", "sprite": "res://Assets/Sprites/Cards/Spells/Fireball.png", "cost":30, "range": 200, "damage": 0, "attackSpeed": 0, "accuracy": 0, "unlocked": true, 'path':''},
	{"id":17, "type": "spell", "cardName" : "Iceball", "desc":"Throws an iceball in the selected area", "sprite": "res://Assets/Sprites/Cards/Spells/Iceball.png", "cost":30, "range": 250, "damage": 0, "attackSpeed": 0, "accuracy": 0, "unlocked": true, 'path':''},
	################# Passives ####################
	{"id":18, "type": "passive", "cardName" : "Burning Field", "desc":"The fire enrages your troops, making them shoot faster", "sprite": "res://Assets/Sprites/Cards/Passive/BurningField.png", "cost":40, "range": 0, "damage": 0, "attackSpeed": 0, "accuracy": 0, "unlocked": true, 'path':'', "modifier": 1.2},
	{"id":19, "type": "passive", "cardName" : "Frozen Field", "desc":"Freezes the ground, slowing all enemies", "sprite": "res://Assets/Sprites/Cards/Passive/FrozenField.png", "cost":40, "range": 0, "damage": 0, "attackSpeed": 0, "accuracy": 0, "unlocked": true, 'path':'', "modifier": 0.8},
	################# Chest ####################
	{"id": 20, "type": "chest", "cardName": "Chest Key", "desc": "Opens a chest (single use)", "sprite": "res://Assets/Sprites/Cards/Chest/ChestKey.png", "cost": 100, "unlocked": true}
]

var initialDecks = {
	CardsManager.DeckType.ICE: 
		[20,20,6,11,11,11,11,12,12,12,13,13,3,3,4,4,5,5,6,7,7,7,8,8,8,9,9,9,10,10,10,14,14,17,17,17,19,19],
	CardsManager.DeckType.FIRE: 
		[20,20,0,0,0,0,1,1,1,2,2,3,3,4,4,5,5,6,7,7,7,8,8,8,9,9,9,10,10,10,14,14,16,16,16,18,18]
}

func unlock(id):
	for card in CollectionCard:
		if card["id"] == id:
			card["unlocked"] = true
			break
	Save.SaveCollection(CollectionCard)

func load_collection():
	var collection = Save.LoadCollection()
	if collection == null:
		Save.SaveCollection(initialCollection)
		collection = initialCollection.map(func(card): return card.duplicate())
	return collection

func find_card(id):
	return CollectionCard.filter(func (card): return card["id"] == id).front()

func isUnlocked(id):
	return find_card(id)["unlocked"] == true

func get_initial_deck(deck_type: CardsManager.DeckType):
	return initialDecks[deck_type]

func get_locked_ids():
	return CollectionCard.filter(func(card): return not card["unlocked"]).map(func(card): return card["id"])
	
func get_unlocked_ids():
	return CollectionCard.filter(func(card): return card["unlocked"]).map(func(card): return card["id"])
	
func is_tower(id):
	return find_card(id)["type"] == "tower"
