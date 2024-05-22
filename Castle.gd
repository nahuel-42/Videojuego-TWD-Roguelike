extends Node

var pos : Vector2i
var texture : int

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _setup(texture:int, pos:Vector2i):
	self.pos = pos
	self.texture = texture
	
func get_texture():
	return texture
