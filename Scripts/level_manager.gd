extends Node

@onready var health = 10
@onready var health_bar : ProgressBar = $CanvasLayer/Bars/HealthBar
@onready var next_stage_button : Button = $WavesCanvas/NextStageButton
@onready var stage_text : RichTextLabel = $WavesCanvas/StageNumber
@onready var wave_text : RichTextLabel = $WavesCanvas/WaveNumber
@onready var fog = $Fog
var width

var target

func _ready():
	var tilemap = $TileMap
	width = tilemap.width * tilemap.CELL_DIMENSION
	#health_bar.max_value = health
	target = $Target
	Parameters.target = target
	target.connect("body_entered", lose_health)
	WaveManager.connect("wave_completed", _on_wave_completed)
	WaveManager.connect("stage_completed", _on_stage_completed)
	WaveManager.set_texts(stage_text, wave_text)
	WaveManager.percentage = (1.0 + WaveManager.stage_index) / WaveManager.stages
	fog.reveal_map(WaveManager.percentage)
	WaveManager.activation_percentage = (WaveManager.percentage + 1.0 / WaveManager.stages) * width

func _on_wave_completed():
	pass

func _on_stage_completed():
	#fog.reset()
	#WaveManager.percentage = (1.0 + WaveManager.wave_index) / WaveManager.waves_per_stage
	#fog.reveal_map(WaveManager.percentage)
	#next_stage_button.visible = true
	WaveManager.percentage = (1.0 + WaveManager.stage_index) / WaveManager.stages
	fog.reveal_map(WaveManager.percentage)
	
func lose_health(body):
	GameController.HealthLoss(10)
	body.reach_target()

func _on_start_stage_button_pressed():
	WaveManager.start_next_stage()
	next_stage_button.visible = false

func is_revealed(x_pos: int):
	return x_pos <= WaveManager.percentage * width
	
