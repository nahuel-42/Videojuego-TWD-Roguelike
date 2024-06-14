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
	Save.SaveCoins(coins)

static func Load():
	var coins = Save.LoadCoins()
	if coins == null:
		return 0
	return coins
