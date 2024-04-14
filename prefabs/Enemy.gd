extends CharacterBody2D


@export var speed = 20
var path_follow

func _ready():
	path_follow = get_parent()

func _process(delta):
	move(delta)
	

func move(delta):
	path_follow.set_progress(path_follow.get_progress() + speed*delta)
	if path_follow.get_progress_ratio() == 1:
		queue_free()
