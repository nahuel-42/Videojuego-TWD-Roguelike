extends Node

var target
@export var Slot = "res://Scripts/slots/slot.gd"

const GROUPS = {
	BEAST = "Beast",
	SOLDIER = "Soldier",
	MERCENARY = "Mercenary",
	DRAKE = "Drake",
	CAPTAIN = "Captain",
	TOWER = "Tower",
	ENEMY = "Enemy",
	PASSIVE = "Passive"
}

const BEAST_TYPES = [
	{"name": "Wolf", "prefab": "res://Prefabs/Enemies/Enemy Beast/Wolf.tscn", "first_percent": 0, "last_percent": 49},
	{"name": "Orc", "prefab": "res://Prefabs/Enemies/Enemy Beast/Orc.tscn", "first_percent": 50, "last_percent": 89},
	{"name": "Drake", "prefab": "res://Prefabs/Enemies/Enemy Beast/Drake.tscn", "first_percent": 90, "last_percent": 99},	
]

const SOLDIER_TYPES = [
	{"name": "Doctor", "prefab": "res://Prefabs/Enemies/Enemy Soldier/Doctor.tscn", "first_percent": 0, "last_percent": 44},
	{"name": "Lieutenant", "prefab": "res://Prefabs/Enemies/Enemy Soldier/Lieutenant.tscn", "first_percent": 45, "last_percent": 89},
	{"name": "Captain", "prefab": "res://Prefabs/Enemies/Enemy Soldier/Captain.tscn", "first_percent": 90, "last_percent": 99},
]

const MERCENARY_TYPES = [
	{"name": "Archer", "prefab": "res://Prefabs/Enemies/Enemy Mercenary/Archer.tscn", "first_percent": 0, "last_percent": 34},
	{"name": "Swordsman", "prefab": "res://Prefabs/Enemies/Enemy Mercenary/Swordsman.tscn", "first_percent": 35, "last_percent": 69},
	{"name": "Wizzard", "prefab": "res://Prefabs/Enemies/Enemy Mercenary/Wizzard.tscn", "first_percent": 70, "last_percent": 89},
	{"name": "Engineer", "prefab": "res://Prefabs/Enemies/Enemy Mercenary/Engineer.tscn", "first_percent": 90, "last_percent": 99}
]
