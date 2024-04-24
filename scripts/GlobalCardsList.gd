class_name GlobalCards
extends Node

# SpellCard: id, cardName, description, sprite, cost
# PassiveCard: id, cardName, description, sprite, cost, active, type, effect, value
# Tower: id, type, subtype ,cardName, description, sprite, cost, active, range, damage, attackSpeed, presition
# PowerUpCard: id, cardName, description, sprite, cost, active, type

static var CollectionCard = {
	"towers": [
		{"id":0, "type": "tower", "cardName" : "Archer Tower", "desc":"Data", "cost":100, "range": 150, "damage": 1, "attackSpeed": 1, "accuracy": 0.1, "unlocked": 0, 'path':'res://prefabs/archer_tower.tscn'},
		{"id":1, "type": "tower", "cardName" : "Area Tower", "desc":"Data", "cost":100, "range": 125, "damage": 1, "attackSpeed": 1, "accuracy": 0.1, "unlocked": 0, 'path':'res://prefabs/area_tower.tscn'}
	]
}

static var FireCards = [0,0,1,1]
static var IceCards = [0,0,1,1]


static var UnlockedCards = [0, 0, 0, 0, 0, 0, 0]
