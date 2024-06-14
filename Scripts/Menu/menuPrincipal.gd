extends Control


var escena_mazos = load("res://Scenes/Menu/menuMazos.tscn")
var escena_tienda = load("res://Scenes/Menu/menuTienda.tscn")
var escena_inventario = load("res://Scenes/Menu/menuInventario.tscn")
var escena_configuracion = preload("res://Scenes/Menu/menuConfiguracion.tscn")


func _ready():	
	CardsManager.InitUserSave()

func _on_boton_jugar_pressed():
	get_tree().change_scene_to_packed(escena_mazos)


func _on_boton_tienda_pressed():
	get_tree().change_scene_to_packed(escena_tienda)
	
func _on_boton_inventario_pressed():
	get_tree().change_scene_to_packed(escena_inventario)


func _on_boton_configuracion_pressed():
	var configuracion_popup = escena_configuracion.instantiate()
	# Opcional: Si tu escena de configuración es un Popup o hereda de Popup, puedes hacerla modal
	if configuracion_popup is Popup:
		configuracion_popup.popup_centered()  # Esto muestra el popup y lo centra en la pantalla
		configuracion_popup.set_exclusive(true)  # Hace que el popup sea modal
	else:
		add_child(configuracion_popup)
		print("Hola")
	
