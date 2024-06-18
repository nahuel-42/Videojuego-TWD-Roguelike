class_name AllInRangeAttackMethod
extends AttackMethod

@onready var explosion_anim : AnimationPlayer = $"../ExplosionAnimation"
var explosion_sprite : Sprite2D 

func _ready():
	explosion_sprite = $"../Sprite2D/Explosion"
	explosion_sprite.visible = false
	attack_sound = "fireballExplosion"

func fire():
	if len(enemies_in_range) != 0:
		cooldown = 1 / get_attack_speed()
	for enemy in enemies_in_range:
		speciality.act(enemy, get_damage())

func explosion():
	explosion_sprite.visible = true
	explosion_anim.play("Explosion")
