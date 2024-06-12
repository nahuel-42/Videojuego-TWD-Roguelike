extends Node

signal wave_completed
signal stage_completed
signal activate_spawner
signal enable_boss

const BOSS_PATH = "res://Prefabs/Enemies/Boss.tscn"
var wave_config = []
var wave_index = 0
var stages = 2
var stage_index = 1
var waves_per_stage = 1  # Número base de oleadas por stage
var spawners = []
var stage_text : RichTextLabel
var wave_text : RichTextLabel

var percentage
var activation_percentage

func is_active(x_pos: int):
	return x_pos <= activation_percentage

func activate_spawners():
	emit_signal("activate_spawner")
	
func register_spawner(spawner):
	if is_active(spawner.position.x):
		spawner.connect("stage_completed", _on_spawner_stage_completed)
		spawners.append(spawner)
		print("Se registro " + str(spawner))

#para demolition
func deactivate_spawner(spawner):
	if is_active(spawner.position.x):
		spawners.erase(spawner)
		return true
	return false
		#spawner.removeSprite()

func start_next_stage():
	if stage_index == stages:
		var boss_instance = load(BOSS_PATH).instantiate()
		add_child(boss_instance)
		boss_instance.global_position = Parameters.boss_position
		emit_signal("enable_boss")
		return
		
	activate_spawners()
	wave_config = []
	wave_index = 0
	load_stage_config()
	start_next_wave()

func load_stage_config():
	# Entre 5 y 10 waves por stage
	for i in range(waves_per_stage + stage_index % 6):
		var wave = {
			"enemy_count": 5 + 2*stage_index + randi() % 15
		}
		wave_config.append(wave)

func start_next_wave():
	wave_text.text = str(wave_index + 1)
	var current_wave = wave_config[wave_index]
	distribute_enemies(current_wave["enemy_count"])
	wave_index += 1
	
func distribute_enemies(total_enemies):
	if len(spawners) == 0:
		return

	var enemies_per_spawner = int(total_enemies / len(spawners))
	var extra_enemies = total_enemies % len(spawners)
	
	for spawner in spawners:
		var count = enemies_per_spawner
		if extra_enemies > 0:
			count += 1
			extra_enemies -= 1
		spawner.start_next_wave(count)

func _on_spawner_stage_completed():
	if all_spawners_completed():
		if wave_index < len(wave_config):
			emit_signal("wave_completed")
			start_next_wave()
		else:
			stop_spawners()
			stage_index += 1
			stage_text.text = str(stage_index)
			emit_signal("stage_completed")

func all_spawners_completed():
	for spawner in spawners:
		if not spawner.is_stage_completed():
			return false
	return true
	
func stop_spawners():
	for spawner in spawners:
		spawner.stop()

func set_texts(stage, wave):
	stage_text = stage
	wave_text = wave
	stage_text.text = str(stage_index)

func reset():
	wave_config = []
	wave_index = 0
	stages = 5
	stage_index = 1
	waves_per_stage = 5  # Número base de oleadas por stage
	for spawner in spawners:
		spawner.queue_free()
	spawners = []
