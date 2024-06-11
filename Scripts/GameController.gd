extends Node
var InitialMana:float=100
var ActualMana:float=InitialMana
var DeltaTime:float=10.0
var InitialHealth:int=100
var ActualHealth:int=InitialHealth
var passives = []

func _ready():
	GameEvents.OnUpdateMana.Call([InitialMana/InitialMana])
	GameEvents.OnUpdateHealth.Call([100.0])
	pass # Replace with function body.

func _process(delta):
	if (ActualMana<=100):
		ActualMana+=DeltaTime*delta
		#if ((int)(ActualMana) % 2 == 0):
		GameEvents.OnUpdateMana.Call([ActualMana/InitialMana])

func manaCheck(cant):
	return cant<=ActualMana

func manaConsumption(cant):
	if (cant>ActualMana):
		return false
	else:
		ActualMana-=cant
		GameEvents.OnUpdateMana.Call([ActualMana/InitialMana])
		return true

func HealthLoss(cant):
	if (ActualHealth-cant>0):
		ActualHealth-=cant
		GameEvents.OnUpdateHealth.Call([float(ActualHealth)])
	else:
		var change_scene = load("res://Scenes/Menu/gameOver.tscn")
		#MAXIMA VIDA, OJO
		ActualHealth = 100
		get_tree().change_scene_to_packed(change_scene)

func StartWave():
	WaveManager.start_next_wave()

func apply_passives():
	for passive in passives:
		apply_passive(passive)

func apply_passive(passive):
	match passive.id:
		18:
			var towers = get_tree().get_nodes_in_group(Parameters.GROUPS.TOWER)
			for tower in towers:
				tower.apply_attack_speed_passive(passive.modifier)
		19:
			var enemies = get_tree().get_nodes_in_group(Parameters.GROUPS.ENEMY)
			for enemy in enemies:
				enemy.apply_speed_passive(passive.modifier)

func add_passive(passive):
	passives.append(passive)
	apply_passives()

func remove_passive(passive):
	passives.erase(passive)
