extends Node

enum RewardType {
	CARD,
	COINS
}

var reward
var reward_type: RewardType
var opened
var open_texture = preload("res://Assets/Sprites/Chests/OpenChest.png")

func _ready():
	opened = false
	reward_type = RewardType.values().pick_random()
	match reward_type:
		RewardType.COINS:
			reward = randi_range(5, 10)
		RewardType.CARD:
			reward = GlobalCardsList.get_unlocked_ids().pick_random()

func _setup(texture:int,pos:Vector2i):
	self.texture = texture

# TODO: ejecutar esta función cuando se arrastre la carta
# TODO: cambiar textura cuando se abre el cofre
func open():
	# TODO: hacer animacion para la recompensa
	print("se abre cofre")
	$AnimationPlayer.play("give_coins")
	if opened:
		return
	match reward_type:
		RewardType.COINS:
			CoinsManager.AddCoins(reward)
		RewardType.CARD:
			var card = CardFactory.createCard(reward)
			GameEvents.OnAddDeckCards.Call([[card]])
	var sprite: Sprite2D = $Area2D/Sprite2D
	sprite.texture = open_texture

func glow_chest(sprite):
	if not opened:
		sprite.modulate = Color(255,255,34)

func unglow_chest(sprite):
	sprite.modulate = Color(1, 1, 1)
