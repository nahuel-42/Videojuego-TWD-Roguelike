class_name Tower
extends Node2D

@onready var animation = $Animation

var radius : Line2D
var attack_method : AttackMethod 

func _ready():
	attack_method = $AttackMethod
	animation.play("idle")

func load_stats(stats):
	attack_method.load_stats(stats)
	draw_radius()
	
func get_damage():
	attack_method.get_damage()

func _process(delta):
	attack_method.perform(delta)

func set_speciality(speciality):
	add_child(speciality)
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
	

	
