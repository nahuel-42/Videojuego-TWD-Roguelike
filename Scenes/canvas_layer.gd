extends CanvasLayer
@export var m_self : CanvasLayer = null
func _init():
	GameEvents.OnSetNotVisible.AddListener(SetVisible)
func _exit_tree():
	GameEvents.OnSetNotVisible.RemoveListener(SetVisible)
func SetVisible(param):
	var value=param[0]
	m_self.visible=value
