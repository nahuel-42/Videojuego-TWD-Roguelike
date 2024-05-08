extends Control
@export var HealthBar:ProgressBar=null
@export var ManaBar:ProgressBar=null
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_health_mana_button_down():
	HealthBar.value-=10
	ManaBar.value-=10
