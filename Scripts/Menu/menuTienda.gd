extends Container


var scene_map = load("res://Scenes/Menu/menuCarga.tscn")
var scene_principal = load("res://Scenes/Menu/menuPrincipal.tscn")

func _ready():
	var file = FileAccess.open("res://Scripts/Menu/persistenciaTienda.txt", FileAccess.READ)
	var boton1_visible = file.get_line() == "true"
	file.close()
	$TextureRect/VBoxContainer/ScrollContainer/BoxContainer/MarginContainer/HBoxContainer/HBoxContainer/TextureRect4/TextureRect2.visible = boton1_visible
	$TextureRect/VBoxContainer/ScrollContainer/BoxContainer/MarginContainer/HBoxContainer/HBoxContainer/MarginContainer2/TouchScreenButton.visible = !boton1_visible

func _on_touch_screen_button_pressed(num_boton):
	var label=$TextureRect/ColorRect/Label
	var text= int(label.text)
	var costo;
	if num_boton == 1:
		costo= int($TextureRect/VBoxContainer/ScrollContainer/BoxContainer/MarginContainer/HBoxContainer/HBoxContainer/MarginContainer2/TouchScreenButton/Label.text)
		if text-costo>=0 :	
			label.text= str(text-costo)
			$TextureRect/VBoxContainer/ScrollContainer/BoxContainer/MarginContainer/HBoxContainer/HBoxContainer/MarginContainer2/TouchScreenButton.visible = false
			$TextureRect/VBoxContainer/ScrollContainer/BoxContainer/MarginContainer/HBoxContainer/HBoxContainer/TextureRect4/TextureRect2.visible=true
			var file = FileAccess.open("res://Scripts/Menu/persistenciaTienda.txt", FileAccess.WRITE)
			file.store_string("true")
			file.close()
	elif num_boton == 2:
		costo= int($TextureRect/VBoxContainer/ScrollContainer/BoxContainer/MarginContainer/HBoxContainer/HBoxContainer2/MarginContainer2/TouchScreenButton/Label.text)	
		if text-costo>=0 :
			label.text= str(text-costo)
			
	elif num_boton == 3:
		costo= 50
		label.text= str(text+costo)
	elif num_boton == 4:
		costo= 250
		label.text= str(text+costo)
	elif num_boton == 5:
		costo= 1000
		label.text= str(text+costo)

func _on_boton_atras_pressed():
	get_tree().change_scene_to_packed(scene_principal)
