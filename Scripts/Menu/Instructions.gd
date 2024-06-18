extends Node2D

@export var container : Container = null
var op : int = 0
var card_scene = preload('res://Scenes/Menu/Instrucciones/cardInfo.tscn')
var upgrade_scene = preload('res://Scenes/Menu/Instrucciones/upgradeInfo.tscn')
var scene_principal = load("res://Scenes/Menu/menuPrincipal.tscn")

const cards = [
	{'name': 'Spell', 'description':'smt', 'color':'Green'},
	{'name': 'Tower', 'description':'smt', 'color':'Purple'},
	{'name': 'Upgrade', 'description':'smt', 'color':'Aquamarine'},
	{'name': 'Passive', 'description':'smt', 'color':'Brown'},
	{'name': 'Speciality', 'description':'smt', 'color':'Blue'},
	{'name': 'Class', 'description':'smt', 'color':'Red'}
]
const enemies = [
	{'type':'Beast', 'name':'Orcs', 'description':'smt', 'sprite':'res://Assets/Menu/Instrucciones/Orc.png'},
	{'type':'Beast', 'name':'Werewolf', 'description':'smt', 'sprite':'res://Assets/Menu/Instrucciones/Werewolf.png'},
	{'type':'Beast', 'name':'Dragon', 'description':'smt', 'sprite':'res://Assets/Menu/Instrucciones/Dragon.png'},
	{'type':'Soldier', 'name':'Doctor', 'description':'smt', 'sprite':'res://Assets/Menu/Instrucciones/Doctor.png'},
	{'type':'Soldier', 'name':'Captain', 'description':'smt', 'sprite':'res://Assets/Menu/Instrucciones/Captain.png'},
	{'type':'Soldier', 'name':'Liutenant', 'description':'smt', 'sprite':'res://Assets/Menu/Instrucciones/Liutenant.png'},
	{'type':'Mercenary', 'name':'Archer', 'description':'smt', 'sprite':'res://Assets/Menu/Instrucciones/Archer.png'},
	{'type':'Mercenary', 'name':'Swordsman', 'description':'smt', 'sprite':'res://Assets/Menu/Instrucciones/Swordsman.png'},
	{'type':'Mercenary', 'name':'Engineer', 'description':'smt', 'sprite':'res://Assets/Menu/Instrucciones/Engineer.png'},
	{'type':'Mercenary', 'name':'Wizard', 'description':'smt', 'sprite':'res://Assets/Menu/Instrucciones/Wizard.png'}		
]
const specialities = [
	{'type':'Hunter', 'name':'Harpoon', 'description':'smt', 'sprite':'res://Assets/Sprites/Cards/Speciality/Harpoon.png'},
	{'type':'Hunter', 'name':'Net', 'description':'smt', 'sprite':'res://Assets/Sprites/Cards/Speciality/Net.png'},
	{'type':'Hunter', 'name':'Tamer', 'description':'smt', 'sprite':'res://Assets/Sprites/Cards/Speciality/Tamer.png'},
	{'type':'Soldier', 'name':'Boiling Oil', 'description':'smt', 'sprite':'res://Assets/Sprites/Cards/Speciality/BoilingOil.png'},
	{'type':'Soldier', 'name':'Catapult', 'description':'smt', 'sprite':'res://Assets/Sprites/Cards/Speciality/Catapult.png'},
	{'type':'Soldier', 'name':'Sniper', 'description':'smt', 'sprite':'res://Assets/Sprites/Cards/Speciality/Sniper.png'},
	{'type':'Mercenary', 'name':'Sapper', 'description':'smt', 'sprite':'res://Assets/Sprites/Cards/Speciality/Sapper.png'},
	{'type':'Mercenary', 'name':'Gas', 'description':'smt', 'sprite':'res://Assets/Sprites/Cards/Speciality/Gas.png'},
	{'type':'Mercenary', 'name':'Incendiary', 'description':'smt', 'sprite':'res://Assets/Sprites/Cards/Speciality/Incendiary.png'}
]

func _ready():
	pass
	showInfo(0)

func showInfo(op):
	if (op == 0):
		for cData in cards:
			var cardInfo = card_scene.instantiate()
			cardInfo.init(cData)
			$Container/Grid.add_child(cardInfo)
	elif (op == 1):
		for eData in enemies:
			var enemyInfo = upgrade_scene.instantiate()
			enemyInfo.init(eData)
			$Container/Grid.add_child(enemyInfo)
	elif (op == 2):
		for sData in specialities:
			var specialityInfo = upgrade_scene.instantiate()
			specialityInfo.init(sData)
			$Container/Grid.add_child(specialityInfo)

func _on_cards_pressed():
	if(op != 0):
		op = 0
		showInfo(0)	

func _on_enemies_pressed():
	if(op != 1):
		op = 1
		showInfo(1)	

func _on_specialiy_pressed():
	if(op != 2):
		op = 2
		showInfo(2)	


func _on_menu_pressed():
	get_tree().change_scene_to_packed(scene_principal)

