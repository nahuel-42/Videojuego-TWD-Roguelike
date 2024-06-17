extends Node
class_name Save
const SAVE_PATH = "user://saves.sav"
const ROOT_PATH = "user://"

const SAVE_DATA_PATH = "save_data"

# ########## LOAD ##########

static func LoadCoins():
	return ReadKey("coins")
	
static func LoadCollection():
	return ReadKey("collection")
	
static func LoadProfile():
	return ReadKey("profile")

static func LoadStore():
	return ReadKey("store")

static func LoadMaxCastles():
	return ReadKey("max_castles")
	
static func LoadCurrentCastles():
	return ReadKey("current_castles")

static func LoadVolume():
	return ReadKey("volume")

static func LoadDeck():
	return ReadKey("deck")

static func LoadIngame():
	return ReadKey("ingame")
	
static func LoadLastTargetPos():
	var value = ReadKey("last_target_pos")
	
	if value != null:
		value = value.erase(0, 1)
		value = value.erase(value.length() - 1, 1)
		var array: Array = value.split(", ")
		value = Vector2(int(array[0]), int(array[1]))
		
	return value
	
# ########## SAVE ##########

static func SaveCoins(amount):
	StoreKey("coins", amount)
	
static func SaveCollection(collection):
	StoreKey("collection", collection)
	
static func SaveProfile(deck):
	StoreKey("profile", deck)

static func SaveStore(store):
	StoreKey("store", store)

static func SaveMaxCastles(castles):
	StoreKey("max_castles", castles)
	
static func SaveCurrentCastles(castles):
	StoreKey("current_castles", castles)

static func SaveVolume(volume):
	StoreKey("volume", volume)

static func SaveDeck(deck):
	StoreKey("deck", deck)

static func SaveIngame(ingame):
	StoreKey("ingame", ingame)

static func SaveLastTargetPos(last_target_pos):
	StoreKey("last_target_pos", last_target_pos)

static func StoreKey(key, value):
	if not FileAccess.file_exists(SAVE_DATA_PATH):
		var file = FileAccess.open(SAVE_DATA_PATH, FileAccess.WRITE)
		var dict = {key: value}
		file.store_line(JSON.stringify(dict))
		file.close()
	else:
		var file = FileAccess.open(SAVE_DATA_PATH, FileAccess.READ)
		var dict = JSON.parse_string(file.get_line())
		file.close()
		file = FileAccess.open(SAVE_DATA_PATH, FileAccess.WRITE)
		dict[key] = value
		file.store_line(JSON.stringify(dict))
		file.close()

static func ReadKey(key):
	if not FileAccess.file_exists(SAVE_DATA_PATH):
		return null
	var file = FileAccess.open(SAVE_DATA_PATH, FileAccess.READ)
	var dict = JSON.parse_string(file.get_line())
	file.close()
	if key in dict:
		return dict[key]
	else:
		return null
