extends Node

var pos:Vector2i #no se si es reduntante que guarde la posicion porque la estamos guardando tambien en el map
var texture:int

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _setup(texture:int,pos:Vector2i):
	self.texture = texture
	self.pos = pos
