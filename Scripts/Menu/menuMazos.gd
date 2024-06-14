extends Container

var scene_map = load("res://Scenes/Menu/menuCarga.tscn")
var scene_principal = load("res://Scenes/Menu/menuPrincipal.tscn")

func _ready():
	var continuarPartida: HBoxContainer= $TextureRect/VBoxContainer/ScrollContainer/BoxContainer/MarginContainer/HBoxContainer/HBoxContainer8
	var ingame = Save.LoadIngame()
	if ingame == null:
		ingame = false
	# TODO: hacer que la carta de continuar aparezca diferente si no se puede continuar (ingame == false)
	# porque aparece el index aunque la carta esté oculta
	continuarPartida.visible = ingame

func _on_touch_screen_button_pressed():
	var container = $TextureRect/VBoxContainer/ScrollContainer
	var type = container.get_selected_deck_type()
	if type == CardsManager.DeckType.CONTINUE and not Save.LoadIngame():
		return
	CardsManager.SetDeckType(type)
	get_tree().change_scene_to_packed(scene_map)

func _on_boton_atras_pressed():
	get_tree().change_scene_to_packed(scene_principal)
