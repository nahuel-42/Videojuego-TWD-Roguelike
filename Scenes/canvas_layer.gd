extends CanvasLayer

@export var m_HUD : Control = null

var gameOver_scene = preload("res://Scenes/Menu/gameOver.tscn")
var continue_scene = preload("res://Scenes/Menu/menuCambioNivel.tscn")

func _init():
	GameEvents.OnSetVisible.AddListener(SetVisible)
	GameEvents.OnShowGamerOver.AddListener(ShowGamerOver)
	GameEvents.OnShowContinueMenu.AddListener(ShowContinue)
	
func _exit_tree():
	GameEvents.OnSetVisible.RemoveListener(SetVisible)
	GameEvents.OnShowGamerOver.RemoveListener(ShowGamerOver)
	GameEvents.OnShowContinueMenu.RemoveListener(ShowContinue)
	
func SetVisible(param):
	var value=param[0]
	m_HUD.visible = value
	
	
func ShowGamerOver(param):
	var gm=gameOver_scene.instantiate()
	add_child(gm)
	
func ShowContinue(param):
	var menu = continue_scene.instantiate()
	add_child(menu)


func _on_next_stage_button_pressed():
	WaveManager.start_next_stage()
	$HUD/WavesCanvas/NextStageButton.visible = false
