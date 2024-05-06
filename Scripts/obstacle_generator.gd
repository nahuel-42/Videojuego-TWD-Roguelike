extends Object
class_name ObstacleGenerator

var width:int
var height:int

var min_size:int
var max_size:int

var initial_obstacles: Array

func _init(width:int, height:int, min_size:int, max_size:int, initial_obstacles:Array = []):
	self.width = width
	self.height = height
	self.min_size = min_size
	self.max_size = max_size
	self.initial_obstacles = initial_obstacles
	
	
func generate_obstacles(n: int) -> Array:
	var obstacles = []
	obstacles.append_array(initial_obstacles)
	var n_obstacles = 0
	while n_obstacles < n:
		var size = randi_range(min_size, max_size)
		var pos_x = randi_range(0, width-1)
		var pos_y = randi_range(0, height - size)
		var pos = Vector2i(pos_x, pos_y)
		var collided = false
		var rect = Rect2i(pos, Vector2i(1, size))
		for obstacle in obstacles:
			if obstacle.intersects(rect):
				collided = true
				break
		if !collided:
			obstacles.append(rect)
			n_obstacles += 1
			
	return obstacles
