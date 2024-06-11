extends Control
@export var HealthBar:ProgressBar=null
@export var ManaBar:ProgressBar=null
# Called when the node enters the scene tree for the first time.
func _ready():
	GameEvents.OnUpdateMana.AddListener(UpdateMana)
	GameEvents.OnUpdateHealth.AddListener(UpdateHealth)
# Called every frame. 'delta' is the elapsed time since the previous frame.
func UpdateMana(param):
	var ManaActual=param[0]
	ManaBar.value=ManaActual
	
func UpdateHealth(param):
	var HealthActual=param[0]
	HealthBar.value=HealthActual
	pass
