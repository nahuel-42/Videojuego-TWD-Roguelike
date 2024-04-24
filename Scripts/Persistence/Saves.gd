extends Node
class_name Save
const SAVE_PATH = "user://saves.sav"
const ROOT_PATH = "user://"

static func IfExists(path):
	return false

static func save_game(path, dictionary):
	#if (!FileAccess.file_exists(path)):
	var file = FileAccess.open(path, FileAccess.WRITE)
	file.store_line(JSON.stringify(dictionary))
	file.close()
	

static func load_game(path, dictionary):
	var file = FileAccess.open(path, FileAccess.READ)
	if (file != null):
		#print(file.get_line())
		return true
	return false
