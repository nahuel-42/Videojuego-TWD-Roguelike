class_name Boss
extends Enemy

var enabled = false
@onready var cs : CollisionShape2D = $CollisionShape2D
var allies_in_range = []

func start_slow():
	pass
	
func start_bleeding():
	pass

func start_stun():
	pass
	
func start_vulnerable():
	pass

func load_stats():
	pass

func _ready():
	super()
	WaveManager.connect("enable_boss", enable_boss)
	cs.disabled = true
	Parameters.boss = self
	add_to_group("BOSS")
	

func init_stats():
	health = 150
	damage_to_health = 100
	speed = 60
	super()

func _physics_process(delta):
	if !enabled:
		return
		
	if allies_in_range.is_empty():
		move(delta)	
	else:
		fight()

func move(delta):
	animation.play("Walk")
	super(delta)
		
func enable_boss():
	cs.disabled = false
	enabled = true

func fight():
	if len(allies_in_range) >= 3:
		animation.play("Attack")
	else:
		animation.play("Idle")

func do_damage():
	for ally in allies_in_range:
		ally.take_damage(999)

func _on_allies_detector_body_entered(body):
	if body.is_in_group("ALLIES"):
		allies_in_range.append(body)

func _on_allies_detector_body_exited(body):
	if body.is_in_group("ALLIES"):
		allies_in_range.erase(body)
