extends Control
@export var HealthBar:ProgressBar=null
@export var ManaBar:ProgressBar=null

func _init():
	GameEvents.OnUpdateMana.AddListener(UpdateMana)
	GameEvents.OnUpdateHealth.AddListener(UpdateHealth)
func _exit_tree():
	GameEvents.OnUpdateMana.RemoveListener(UpdateMana)
	GameEvents.OnUpdateHealth.RemoveListener(UpdateHealth)
	
func UpdateMana(param):
	var ManaActual=param[0]
	ManaBar.value=ManaActual
	
func UpdateHealth(param):
	var HealthActual=param[0]
	print(str(HealthBar.value)+" vs " +str(HealthActual))
	HealthBar.value=HealthActual
	print(str(HealthBar.value)+" vs " +str(HealthActual))
