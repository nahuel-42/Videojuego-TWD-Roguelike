extends Node
class_name Save
const SAVE_PATH = "user://saves.sav"

func save_game(path, dictionary):
	#if (!FileAccess.file_exists(path)):
	var file = FileAccess.open(path, FileAccess.WRITE)
	file.store_line(JSON.stringify(dictionary))
	file.close()
	

func load_game(path):
	var file = FileAccess.open(path, FileAccess.READ)
	if (file != null):
		print(file.get_line())
