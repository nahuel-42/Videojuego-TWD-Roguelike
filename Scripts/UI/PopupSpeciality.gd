class_name PopupSpeciality
extends Control

var m_specialityCard : SpecialityCard = null

func _init():
	GameEvents.OnShowPopupSpeciality.AddListener(ShowPopupSpeciality)
func _exit_tree():
	GameEvents.OnShowPopupSpeciality.RemoveListener(ShowPopupSpeciality)

func ShowPopupSpeciality(param):
	visible = true
	m_specialityCard = param[0]

func _on_exit_button_down():
	visible = false

func _on_button_down_speciality1():
	m_specialityCard.UseSpeciality1()
	_on_exit_button_down()

func _on_button_down_speciality2():
	m_specialityCard.UseSpeciality2()
	_on_exit_button_down()

func _on_button_down_speciality3():
	m_specialityCard.UseSpeciality3()
	_on_exit_button_down()
