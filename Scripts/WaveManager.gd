extends Node

signal wave_completed

var wave_config = []
var wave_index = 0
var stage_index = 1
var waves_per_stage = 5  # Número base de oleadas por stage
var spawners = []
var stage_text : RichTextLabel
var wave_text : RichTextLabel

func start_next_stage():
	wave_config = []
	wave_index = 0
	load_waves()
	start_next_wave()

func load_waves():
	print("Cargando waves del stage " + str(stage_index))
	generate_waves(waves_per_stage + stage_index % 6) # Entre 5 y 10 waves por stage

func generate_waves(waves_per_stage):
	for i in range(waves_per_stage):
		var wave = {
			"enemy_count": 1#5 + 2*stage_index + randi() % 15
		}
		print("Enemigos de wave numero " + str(i) + ": " + str(wave["enemy_count"]))
		wave_config.append(wave)

func register_spawner(spawner):
	spawner.connect("wave_completed", _on_spawner_wave_completed)
	spawners.append(spawner)

func start_next_wave():
	wave_text.text = str(wave_index + 1)
	print("Comenzando wave numero " + str(wave_index))
	var current_wave = wave_config[wave_index]
	distribute_enemies(current_wave["enemy_count"])
	wave_index += 1

func distribute_enemies(total_enemies):
	if len(spawners) == 0:
		return

	var enemies_per_spawner = total_enemies / len(spawners)
	var extra_enemies = total_enemies % len(spawners)
	
	for spawner in spawners:
		var count = enemies_per_spawner
		if extra_enemies > 0:
			count += 1
			extra_enemies -= 1
		spawner.start_next_wave(count)

func _on_spawner_wave_completed():
	if all_spawners_completed():
		if wave_index < len(wave_config):
			start_next_wave()
		else:
			stage_index += 1
			stage_text.text = str(stage_index)
			emit_signal("wave_completed")

func all_spawners_completed():
	for spawner in spawners:
		if not spawner.is_wave_completed():
			return false
	return true

func set_texts(stage, wave):
	stage_text = stage
	wave_text = wave
	stage_text.text = str(stage_index)
