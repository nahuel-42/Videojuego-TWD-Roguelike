extends Node
var InitialMana:float=100
var ActualMana:float=InitialMana
var DeltaTime:float=10.0
func _ready():
	GameEvents.OnUpdateMana.Call([InitialMana/InitialMana])
	pass # Replace with function body.

func _process(delta):
	if (ActualMana<=100):
		ActualMana+=DeltaTime*delta
		#if ((int)(ActualMana) % 2 == 0):
		GameEvents.OnUpdateMana.Call([ActualMana/InitialMana])
	pass

func manaConsumption(cant):
	if (cant>ActualMana):
		return false
	else:
		ActualMana-=cant
		GameEvents.OnUpdateMana.Call([ActualMana/InitialMana])
		return true
