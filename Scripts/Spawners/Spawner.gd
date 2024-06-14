class_name Spawner
extends Node2D

@onready var timer : Timer = $Timer
var characters = []
var characters_node : Node2D
var last_character_index : int = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	z_index = 2

func start_next_wave(count):
	last_character_index = 0
	load_characters(count)
	timer.start()

func instantiate_character():
	pass

func load_characters(count):
	characters = []
	for i in range(count):
		var instance = instantiate_character()
		#characters_node.add_child(instance)
		get_parent().add_child(instance)
		instance.position = position
		characters.append(instance)
		instance.set_process_mode(Node.ProcessMode.PROCESS_MODE_DISABLED)
		instance.visible = false

func stop():
	timer.stop()

func _on_timer_timeout():
	if last_character_index < len(characters):
		characters[last_character_index].set_process_mode(Node.ProcessMode.PROCESS_MODE_INHERIT)
		characters[last_character_index].visible = true
		last_character_index += 1

func remove_disabled_characters():
	var characters_to_remove = []
	for character in characters:
		if character.get_process_mode() == Node.ProcessMode.PROCESS_MODE_DISABLED:
			characters_to_remove.append(character)
	for character in characters_to_remove:
		characters_node.remove_child(character)
		characters.erase(character)
