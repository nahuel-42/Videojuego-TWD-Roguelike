extends Object
class_name ForkGenerator

var width:int
var height:int	
var obstacle_generator:ObstacleGenerator
var path_generator:PathGenerator
var max_tries = 10

func _init(width:int, height:int, obstacle_generator:ObstacleGenerator, path_generator:PathGenerator):
	self.width = width
	self.height = height
	self.obstacle_generator = obstacle_generator
	self.path_generator = path_generator
	
func generate_forks(path:Array[Vector2i], obstacles:Array[Vector2i], n:int, padding:int, min_distance: float) -> Array[Array]:
	var start = padding - 1 # inclusive
	var end = len(path) - padding # exclusive
	
	var forks: Array[Array] = []
	
	for i in range(n):
		var path_index = randi_range(start, end)
		var path_position = path[path_index]

		
		var found = false
		var tries = 0
		var target_pos
		while not found and tries < max_tries:
			target_pos = generate_target(path_position, min_distance, min_distance * 2)
			
			if target_pos not in path and target_pos not in obstacles:
				found = true
				path_generator.generate_path(path_position, target_pos)
				var fork = path_generator.get_path()
				forks.append(fork)
				obstacle_generator.initial_obstacles.append_array(fork)
			tries += 1
	print("Forks generados: ", len(forks))
	
	return forks

func generate_target(initial_point: Vector2i, min_radius: float, max_radius: float) -> Vector2i:
	# Step 1: Generate a random angle between 0 and 2π
	var angle = randf() * 2.0 * PI

	# Step 2: Generate a random radius within the specified range
	# We use sqrt to ensure uniform distribution of points within the circle
	var u = randf()
	var radius = sqrt(u * (max_radius * max_radius - min_radius * min_radius) + min_radius * min_radius)

	# Step 3: Convert polar coordinates (radius, angle) to Cartesian coordinates (x, y)
	var x = radius * cos(angle)
	var y = radius * sin(angle)

	# Step 4: Adjust x and y by the initial point's coordinates and convert to integer
	return Vector2i(round(initial_point.x + x), round(initial_point.y + y))
