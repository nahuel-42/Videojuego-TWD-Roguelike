class_name PopupSpeciality
extends Control

@export var m_images : Array[TextureButton] 

var m_specialityCard : SpecialityCard = null
var m_specialityType : int = -1

var m_specialitiesPath = [
	#Hunter: 0
	'res://Assets/Sprites/Cards/PurpleBackground.png',#Harpoon
	'res://Assets/Sprites/Cards/PurpleBackground.png',#Net
	'res://Assets/Sprites/Cards/PurpleBackground.png',#Tamer
	
	#Soldier: 1
	'res://Assets/Sprites/Cards/GreenBackground.png',#Boiling
	'res://Assets/Sprites/Cards/GreenBackground.png',#Catapult
	'res://Assets/Sprites/Cards/GreenBackground.png',#Sniper
	
	#Mercenary: 2
	'res://Assets/Sprites/Cards/BrownBackground.png',#Sapper
	'res://Assets/Sprites/Cards/BrownBackground.png',#Gas
	'res://Assets/Sprites/Cards/BrownBackground.png',#Incendiary
	]

func _init():
	GameEvents.OnShowPopupSpeciality.AddListener(ShowPopupSpeciality)
func _exit_tree():
	GameEvents.OnShowPopupSpeciality.RemoveListener(ShowPopupSpeciality)

func ShowPopupSpeciality(param):
	visible = true
	m_specialityCard = param[0]
	m_specialityType = param[1]
	
	var offset : int = m_specialityType * 3
	for i in range(len(m_images)):
		m_images[i].texture_normal = load(m_specialitiesPath[offset + i])

func _on_exit_button_down():
	visible = false

func _on_button_down_speciality1():
	m_specialityCard.UseSpeciality(1)
	_on_exit_button_down()

func _on_button_down_speciality2():
	m_specialityCard.UseSpeciality(2)
	_on_exit_button_down()

func _on_button_down_speciality3():
	m_specialityCard.UseSpeciality(3)
	_on_exit_button_down()
