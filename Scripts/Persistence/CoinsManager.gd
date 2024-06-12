extends Node
class_name CoinsManager

static var path = "coins"
static var coins = Load()

static func AddCoins(amount):
	coins += amount
	Persist()

static func ConsumeCoins(amount):
	coins -= amount
	Persist()

static func GetCoins():
	return coins

static func Persist():
	var file = FileAccess.open(path, FileAccess.WRITE)
	file.store_32(coins)
	file.close()

static func Load():
	if not FileAccess.file_exists(path):
		return 0
	var file = FileAccess.open(path, FileAccess.READ)
	var coins = file.get_32()
	file.close()
	return coins
