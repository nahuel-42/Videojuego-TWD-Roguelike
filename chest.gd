extends Node

enum RewardType {
	CARD,
	COINS,
	UNLOCK
}

var rewardSprites = {
	RewardType.CARD: "res://Assets/Menu/Dorso2.png",
	RewardType.COINS: "res://Assets/Menu/AdolfoCoins.png",
	RewardType.UNLOCK: "res://Assets/Menu/Dorso3.png"
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
		RewardType.UNLOCK:
			var locked_cards = GlobalCardsList.get_locked_ids()
			if (len(locked_cards) == 0):
				reward_type = RewardType.CARD
				reward = GlobalCardsList.get_unlocked_ids().pick_random()
			else:
				reward = locked_cards.pick_random()
	$Sprite2D.texture = load(rewardSprites[reward_type])
	
func _setup(texture:int):
	self.texture = texture

# TODO: Implementar el premio de desbloquear carta
func open():
	if opened or not WaveManager.is_active($Sprite2D.position.x):
		return

	match reward_type:
		RewardType.COINS:
			CoinsManager.AddCoins(reward)
		RewardType.CARD:
			var card = CardFactory.createCard(reward)
			GameEvents.OnAddDeckCards.Call([[card]])
		RewardType.UNLOCK:
			GlobalCardsList.unlock(reward)
	var sprite: Sprite2D = $Area2D/Sprite2D
	sprite.texture = open_texture
	$AnimationPlayer.play("give_reward")

func glow_chest(sprite):
	if not opened and WaveManager.is_active($Sprite2D.position.x):
		sprite.modulate = Color(255,255,34)

func unglow_chest(sprite):
	sprite.modulate = Color(1, 1, 1)
