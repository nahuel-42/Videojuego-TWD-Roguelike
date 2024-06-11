extends Node
class_name Save
const SAVE_PATH = "user://saves.sav"
const ROOT_PATH = "user://"

static func IfExists(path):
	return false

#almacena una lista
static func save_game(path, list):
	#if (!FileAccess.file_exists(path)):
	var file = FileAccess.open(path, FileAccess.WRITE)
	for line in list:
		file.store_line(JSON.stringify(line))
	file.close()
	
static func load_game(path):
	var file = FileAccess.open(path, FileAccess.READ)
	if (file != null):
		var list = []
		var line = 0
		while (line != null):
			line = JSON.parse_string(file.get_line())
			if (line != null):
				list.append(line)
		return list
	return null
