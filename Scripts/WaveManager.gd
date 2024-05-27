extends Node

signal wave_completed

var wave_config = []
var wave_index = 0
var total_waves = 5  # Número total de oleadas
var spawners = []

func load_waves():
	generate_waves(total_waves)

func generate_waves(total_waves):
	for i in range(total_waves):
		var wave = {
			"enemy_count": randi() % 15 + 5  # Genera entre 5 y 20 enemigos en total
		}
		print("Enemigos de wave numero " + str(i) + ": " + str(wave["enemy_count"]))
		wave_config.append(wave)

func register_spawner(spawner):
	spawner.connect("wave_completed", _on_spawner_wave_completed)
	spawners.append(spawner)

func start_next_wave():
	if wave_index < len(wave_config):
		print("Comenzando wave numero " + str(wave_index))
		var current_wave = wave_config[wave_index]
		distribute_enemies(current_wave["enemy_count"])
		wave_index += 1
	else:
		print("Todas las waves finalizaron")

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
	print("WaveManager recibio la señal de wave finalizada")
	if all_spawners_completed():
		emit_signal("wave_completed")

func all_spawners_completed():
	for spawner in spawners:
		if not spawner.is_wave_completed():
			return false
	return true
