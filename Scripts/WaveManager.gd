extends Node

signal wave_completed
signal stage_completed

var wave_config = []
var wave_index = 0
var stage_index = 1
var waves_per_stage = 5  # Número base de oleadas por stage
var spawners = []
var stage_text : RichTextLabel
var wave_text : RichTextLabel

var percentage

func register_spawner(spawner):
	spawner.connect("stage_completed", _on_spawner_stage_completed)
	spawners.append(spawner)

func start_next_stage():
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
