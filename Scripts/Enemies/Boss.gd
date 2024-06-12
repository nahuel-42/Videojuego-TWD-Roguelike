class_name Boss
extends Enemy

var enabled = false
@onready var cs : CollisionShape2D = $CollisionShape2D
@onready var animated_sprite : AnimatedSprite2D = $Sprite2D

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
	

func init_stats():
	health = 150
	damage_to_health = 100
	speed = 60
	super()

func move(delta):
	if enabled:
		super(delta)
		
func enable_boss():
	animated_sprite.animation = "Walk"
	cs.disabled = false
	enabled = true
