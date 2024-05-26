extends Node

var width:int
var height:int

var min_size:int
var max_size:int

#var initial_obstacles: Array[Rect2i]
var initial_obstacles: Dictionary # Rect2i: null

func init(width:int, height:int, min_size:int, max_size:int, initial_obstacles:Dictionary = {}):
	self.width = width
	self.height = height
	self.min_size = min_size
	self.max_size = max_size
	self.initial_obstacles = initial_obstacles
	
	
func generate_obstacles(n: int) -> Array[Rect2i]:
	var obstacles: Array[Rect2i] = []
	obstacles.append_array(initial_obstacles.keys())
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

	
func get_initial_obstacles():
	return self.initial_obstacles
	
func add_obstacles(obstacles: Array[Vector2i]):
	for obstacle in obstacles:
		initial_obstacles[Rect2i(obstacle, Vector2i(1,1))] = null
		
func remove_obstacle(obstacle: Vector2i):
	initial_obstacles.erase(Rect2i(obstacle, Vector2i(1,1)))

func set_seed(seed : int):
	seed(seed)
