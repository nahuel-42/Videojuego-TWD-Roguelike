extends Beast
class_name EnemyWolf

#TODO: la probabilidad de acierto disminuya con el

func init_stats():
	speed = 170
	health = 2

func take_damage(damage):
	if vulnerable:
		damage *= 2
	cooldown = 0.5
	modulate = Color(1, 0, 0)
	
	var rng = RandomNumberGenerator.new()
	var num = rng.randi_range (1,10)
	
	if (num > 5): #Le pega
		health -= damage
		health_bar.value -= damage

	if health > 0:
		return
		
	set_process_mode(Node.ProcessMode.PROCESS_MODE_DISABLED)
	visible = false
