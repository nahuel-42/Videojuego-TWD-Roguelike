class_name EnemySwordsman
extends Mercenary

#TODO: la probabilidad de acierto disminuye con el

func init_stats(): #sujeto a cambios
	speed = 140
	health = 1
	damage_to_health = 13
	super()

func take_damage(damage):
	if vulnerable:
		damage *= 2
	cooldown = 0.5
	
	var rng = RandomNumberGenerator.new()
	var num = rng.randi_range (1,10)
	
	if (num > 5): #Le pega
		health -= damage
		health_bar.value -= damage

	if health > 0:
		return
		
	set_process_mode(Node.ProcessMode.PROCESS_MODE_DISABLED)
	visible = false
