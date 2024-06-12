class_name PopupSpeciality
extends Control

@export var m_images : Array[TextureButton] 

var m_specialityCard : SpecialityCard = null
var m_specialityType : int = -1

var m_specialitiesPath = [
	#Hunter: 0
	'res://Assets/Sprites/Cards/BlueBackground.png',#Harpoon
	'res://Assets/Sprites/Cards/BlueBackground.png',#Net
	'res://Assets/Sprites/Cards/BlueBackground.png',#Tamer
	
	#Soldier: 1
	'res://Assets/Sprites/Cards/BlueBackground.png',#Boiling
	'res://Assets/Sprites/Cards/BlueBackground.png',#Catapult
	'res://Assets/Sprites/Cards/BlueBackground.png',#Sniper
	
	#Mercenary: 2
	'res://Assets/Sprites/Cards/BlueBackground.png',#Sapper
	'res://Assets/Sprites/Cards/BlueBackground.png',#Gas
	'res://Assets/Sprites/Cards/BlueBackground.png',#Incendiary
	]

func _init():
	GameEvents.OnShowPopupSpeciality.AddListener(ShowPopupSpeciality)
func _exit_tree():
	GameEvents.OnShowPopupSpeciality.RemoveListener(ShowPopupSpeciality)

func ShowPopupSpeciality(param):
	visible = true
	m_specialityCard = param[0]
	m_specialityType = param[1]
	
#	var offset : int = m_specialityType * 3
#	for i in range(len(m_images)):
#		m_images[i].texture_normal = load(m_specialitiesPath[offset + i])

	#botones de eleccion
	get_node('background/Speciality1/image').texture_normal = load('res://Assets/Sprites/Cards/BlueBackground.png')
	get_node('background/Speciality2/image').texture_normal = load('res://Assets/Sprites/Cards/BlueBackground.png')
	get_node('background/Speciality3/image').texture_normal = load('res://Assets/Sprites/Cards/BlueBackground.png')
	
	#depende de la clase de la torre
	if(m_specialityType == 0):#Hunter
		#Speciality1
		get_node('background/Speciality1/figure').texture = load('res://Assets/Sprites/Cards/Speciality/Harpoon.png')
		get_node('background/Speciality1/name').text = 'Harpoon'
		#Specility2
		get_node('background/Speciality2/figure').texture = load('res://Assets/Sprites/Cards/Speciality/Net.png')		
		get_node('background/Speciality2/name').text = 'Net'
		#Speciality3
		get_node('background/Speciality3/figure').texture = load('res://Assets/Sprites/Cards/Speciality/Tamer.png')
		get_node('background/Speciality3/name').text = 'Tamer'
		
	if(m_specialityType == 1):#Soldier
		#Speciality1
		get_node('background/Speciality1/figure').texture = load('res://Assets/Sprites/Cards/Speciality/BoilingOil.png')
		get_node('background/Speciality1/name').text = 'Boiling Oil'
		#Specility2
		get_node('background/Speciality2/figure').texture = load('res://Assets/Sprites/Cards/Speciality/Catapult.png')		
		get_node('background/Speciality2/name').text = 'Catapult'
		#Speciality3
		get_node('background/Speciality3/figure').texture = load('res://Assets/Sprites/Cards/Speciality/Sniper.png')
		get_node('background/Speciality3/name').text = 'Sniper'

	if(m_specialityType == 2):#Mercenary
		#Speciality1
		get_node('background/Speciality1/figure').texture = load('res://Assets/Sprites/Cards/Speciality/Sapper.png')
		get_node('background/Speciality1/name').text = 'Sapper'
		#Specility2
		get_node('background/Speciality2/figure').texture = load('res://Assets/Sprites/Cards/Speciality/Gas.png')		
		get_node('background/Speciality2/name').text = 'Gas'
		#Speciality3
		get_node('background/Speciality3/figure').texture = load('res://Assets/Sprites/Cards/Speciality/Flamethrower.png')
		get_node('background/Speciality3/name').text = 'Incendiary'


func _on_exit_button_down():
	visible = false

func _on_button_down_speciality1():
	m_specialityCard.UseSpeciality(0)
	_on_exit_button_down()

func _on_button_down_speciality2():
	m_specialityCard.UseSpeciality(1)
	_on_exit_button_down()

func _on_button_down_speciality3():
	m_specialityCard.UseSpeciality(2)
	_on_exit_button_down()
