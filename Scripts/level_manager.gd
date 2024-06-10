extends Node
var target

func _ready():
	target = $Target
	Parameters.target = target
	target.connect("body_entered", lose_health)
	WaveManager.connect("wave_completed", _on_wave_completed)

func _on_wave_completed():
	print("Todos los spawners finalizaron su wave")
	GameController.StartWave()
	
func lose_health(body):
	GameController.HealthLoss(10)
	body.reach_target()

func _on_start_wave_button_pressed():
	GameController.StartWave()
