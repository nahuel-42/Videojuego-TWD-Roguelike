class_name Tower
extends Node2D

@onready var animation = $Animation
@onready var sprite : Sprite2D = $Sprite2D
@onready var tower_sprite : Sprite2D = $Tower

var radius : Line2D
var attack_method : AttackMethod 

func _ready():
	attack_method = $AttackMethod

func load_stats(stats):
	attack_method.load_stats(stats)
	draw_radius()
	
func get_damage():
	attack_method.get_damage()

func _process(delta):
	attack_method.perform(delta)

func set_speciality(speciality, texture):
	add_child(speciality)
	#sprite.texture = load(texture)
	tower_sprite.frame += 1
	attack_method.set_speciality(speciality)

func draw_radius():
	var circle_points = []
	radius = $Radius
	radius.width = 1
	var segments = 32  # Número de segmentos para aproximar el círculo
	
	for i in range(segments + 1):
		var angle = i * (2 * PI / segments)
		var range = attack_method.get_range()
		var x = range * cos(angle)
		var y = range * sin(angle)
		circle_points.append(Vector2(x, y))
	
	radius.points = circle_points
	
func upgrade(damage, range, attack_speed, accuracy):
	attack_method.upgrade(damage, range, attack_speed, accuracy)
	draw_radius()
	

func _on_animation_animation_finished(anim_name):
	animation.play("Idle")
	
func glow():
	sprite.modulate = Color(255,255,34)
	tower_sprite.modulate = Color(255,255,34)
	
func unglow():
	sprite.modulate = Color(1, 1, 1)
	tower_sprite.modulate = Color(1, 1, 1)
