extends CanvasLayer
@export var m_self : CanvasLayer = null
func _init():
	GameEvents.OnSetVisible.AddListener(SetVisible)
func _exit_tree():
	GameEvents.OnSetVisible.RemoveListener(SetVisible)
func SetVisible(param):
	var value=param[0]
	m_self.visible=value
