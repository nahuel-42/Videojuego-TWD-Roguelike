extends Node

@export var m_movementCardSound : AudioStreamPlayer = null
@export var m_usedCardSound : AudioStreamPlayer = null

func _init():
	GameEvents.OnPlayMovementCard.AddListener(playMovementCard)
	GameEvents.OnPlayUsedCard.AddListener(playUsedCard)
func _exit_tree():
	GameEvents.OnPlayMovementCard.AddListener(playMovementCard)
	GameEvents.OnPlayUsedCard.RemoveListener(playUsedCard)
	
func playMovementCard(param):
	m_movementCardSound.play()
	
func playUsedCard(param):
	m_usedCardSound.play()
