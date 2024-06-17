extends Container


var scene_map = load("res://Scenes/Menu/menuCarga.tscn")
var scene_principal = load("res://Scenes/Menu/menuPrincipal.tscn")
@onready var label=$TextureRect/ColorRect/Label

func _ready():
	var boton1_visible = Save.LoadStore() == "true"
	label.text = str(CoinsManager.GetCoins())
	$TextureRect/VBoxContainer/ScrollContainer/BoxContainer/MarginContainer/HBoxContainer/HBoxContainer/TextureRect4/TextureRect2.visible = boton1_visible
	$TextureRect/VBoxContainer/ScrollContainer/BoxContainer/MarginContainer/HBoxContainer/HBoxContainer/MarginContainer2/TouchScreenButton.visible = !boton1_visible

func _on_touch_screen_button_pressed(num_boton):
	var coins = CoinsManager.GetCoins()
	var costo;
	if num_boton == 1:
		costo= int($TextureRect/VBoxContainer/ScrollContainer/BoxContainer/MarginContainer/HBoxContainer/HBoxContainer/MarginContainer2/TouchScreenButton/Label.text)
		if coins-costo>=0 :	
			coins -= costo
			CoinsManager.ConsumeCoins(costo)
			$TextureRect/VBoxContainer/ScrollContainer/BoxContainer/MarginContainer/HBoxContainer/HBoxContainer/MarginContainer2/TouchScreenButton.visible = false
			$TextureRect/VBoxContainer/ScrollContainer/BoxContainer/MarginContainer/HBoxContainer/HBoxContainer/TextureRect4/TextureRect2.visible=true
			Save.SaveStore("true")
	elif num_boton == 2:
		costo= int($TextureRect/VBoxContainer/ScrollContainer/BoxContainer/MarginContainer/HBoxContainer/HBoxContainer2/MarginContainer2/TouchScreenButton/Label.text)	
		if coins-costo>=0 :
			coins -= costo
			CoinsManager.ConsumeCoins(costo)
			
	elif num_boton == 3:
		costo= 50
		coins += costo
		CoinsManager.AddCoins(costo)
	elif num_boton == 4:
		costo= 250
		coins += costo
		CoinsManager.AddCoins(costo)
	elif num_boton == 5:
		costo= 1000
		coins += costo
		CoinsManager.AddCoins(costo)
	label.text = str(coins)

func _on_boton_atras_pressed():
	get_tree().change_scene_to_packed(scene_principal)
