extends Node

@onready var health = 10
@onready var health_bar : ProgressBar = $CanvasLayer/Bars/HealthBar
var target

func _ready():
	target = $Target
	Parameters.target = target
	target.connect("body_entered", lose_health)
	WaveManager.connect("wave_completed", _on_wave_completed)

func _on_wave_completed():
	print("Todos los spawners finalizaron su wave")
	WaveManager.start_next_wave()
	
func lose_health(body):
	GameController.HealthLoss(10)
	body.reach_target()
		
func game_over():
	# TODO: En vez de resetear la vida, hacer el Game Over
	health = 10
	health_bar.value = health

func _on_start_wave_button_pressed():
	WaveManager.start_next_wave()
