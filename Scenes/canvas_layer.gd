extends CanvasLayer

@export var m_HUD : Control = null

var gameOver_scene = preload("res://Scenes/Menu/gameOver.tscn")

func _init():
	GameEvents.OnSetVisible.AddListener(SetVisible)
	GameEvents.OnShowGamerOver.AddListener(ShowGamerOver)
	
func _exit_tree():
	GameEvents.OnSetVisible.RemoveListener(SetVisible)
	GameEvents.OnShowGamerOver.RemoveListener(ShowGamerOver)
	
func SetVisible(param):
	var value=param[0]
	m_HUD.visible = value
	#for node in get_children():
	#	node.visible = value
	
func ShowGamerOver(param):
	var gm=gameOver_scene.instantiate()
	add_child(gm)
	#get_tree().paused = false
