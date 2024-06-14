extends Node
var InitialMana:float=100
var ActualMana:float=InitialMana
var DeltaTime:float=10.0
var InitialHealth:int=100
var ActualHealth:int=InitialHealth
var passives = [ null, null]

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
		#GameEvents.OnSetVisible.Call([false])
		#var gameOver_scene = load("res://Scenes/Menu/gameOver.tscn").instantiate()
		#get_tree().root.add_child(gameOver_scene)
		#get_tree().paused = true
		var change_scene=load("res://Scenes/Menu/gameOver.tscn")
		WaveManager.reset()
		#MAXIMA VIDA, OJO
		ActualHealth = 100
		get_tree().change_scene_to_packed(change_scene)

func StartWave():
	WaveManager.start_next_wave()

#No se usa porque se aplican individualmente
func apply_passives():
	for passive in passives:
		if (passive != null):
			apply_passive(passive)

func apply_passive(passive, apply : int = 1):
	match passive.id:
		18:
			var towers = get_tree().get_nodes_in_group(Parameters.GROUPS.TOWER)
			for tower in towers:
				tower.apply_attack_speed_passive(passive.modifier * apply)
		19:
			var enemies = get_tree().get_nodes_in_group(Parameters.GROUPS.ENEMY)
			for enemy in enemies:
				enemy.apply_speed_passive(passive.modifier * apply)

func add_passive(passive, slotPassive : int):
	if (passives[slotPassive] != null):
		apply_passive(passives[slotPassive], -1)
	passives[slotPassive] = passive
	apply_passive(passive)
	
#No se usa porque se aplican individualmente
func remove_passive(passive):
	pass#passives.erase(passive)
