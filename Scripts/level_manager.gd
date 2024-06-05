extends Node

@onready var health = 10
@onready var health_bar : ProgressBar = $CanvasLayer/Bars/HealthBar
@onready var next_stage_button : Button = $WavesCanvas/NextStageButton
@onready var stage_text : RichTextLabel = $WavesCanvas/StageNumber
@onready var wave_text : RichTextLabel = $WavesCanvas/WaveNumber
@onready var fog = $Fog
var width

var target
var percentage

func _ready():
	var tilemap = $TileMap
	width = tilemap.width * tilemap.CELL_DIMENSION
	health_bar.max_value = health
	target = $Target
	Parameters.target = target
	target.connect("body_entered", lose_health)
	WaveManager.connect("wave_completed", _on_wave_completed)
	WaveManager.connect("stage_completed", _on_stage_completed)
	WaveManager.set_texts(stage_text, wave_text)
	percentage = (1.0 + WaveManager.wave_index) / WaveManager.waves_per_stage
	fog.reveal_map(percentage)

func _on_wave_completed():
	percentage = (1.0 + WaveManager.wave_index) / WaveManager.waves_per_stage
	fog.reveal_map(percentage)

func _on_stage_completed():
	fog.reset()
	percentage = (1.0 + WaveManager.wave_index) / WaveManager.waves_per_stage
	fog.reveal_map(percentage)
	next_stage_button.visible = true
	
func lose_health(body):
	print(body)
	health -= body.reach_target()
	health_bar.value = health
	if health <= 0:
		game_over()
		
func game_over():
	# TODO: En vez de resetear la vida, hacer el Game Over
	health = 10
	health_bar.value = health

func _on_start_stage_button_pressed():
	WaveManager.start_next_stage()
	next_stage_button.visible = false

func is_revealed(x_pos: int):
	return x_pos <= percentage * width

func is_active(x_pos: int):
	var activation_distance = 1.0 / WaveManager.waves_per_stage
	return x_pos <= (percentage + activation_distance) * width
