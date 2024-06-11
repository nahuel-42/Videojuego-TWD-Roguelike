extends Node
var InitialMana:float=100
var ActualMana:float=InitialMana
var DeltaTime:float=10.0
var InitialHealth:int=100
var ActualHealth:int=InitialHealth

func _ready():
	GameEvents.OnUpdateMana.Call([InitialMana/InitialMana])
	GameEvents.OnUpdateHealth.Call([100])
	pass # Replace with function body.

func _process(delta):
	if (ActualMana<=100):
		ActualMana+=DeltaTime*delta
		#if ((int)(ActualMana) % 2 == 0):
		GameEvents.OnUpdateMana.Call([ActualMana/InitialMana])
	pass

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
		GameEvents.OnUpdateHealth.Call([ActualHealth])
	else:
		GameEvents.OnUpdateHealth.Call([InitialHealth])
		pass #aca va el game over
func StartWave():
	WaveManager.start_next_wave()
