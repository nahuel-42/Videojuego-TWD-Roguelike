extends Object
class_name ForkGenerator

var width:int
var height:int

var min_sections:int
var max_sections:int
var min_distance:int
var max_distance:int

var obstacle_generator:ObstacleGenerator
var path_generator:PathGenerator
var max_tries = 10

func _init(width:int, height:int, min_sections:int, max_sections:int, min_distance:int, max_distance:int, path_generator:PathGenerator):
	self.width = width
	self.height = height
	self.min_sections = min_sections
	self.max_sections = max_sections
	self.min_distance = min_distance
	self.max_distance = max_distance
	self.obstacle_generator = path_generator.obstacle_generator
	self.path_generator = path_generator
	
func generate_forks(path:Array[Vector2i], obstacles:Array[Vector2i], n:int, padding:int) -> Array[Array]:
	print("Generating forking paths")
	var start = padding - 1 # inclusive
	var end = len(path) - padding # exclusive
	
	var forks: Array[Array] = []
	
	for i in range(n):
		var sections = randi_range(min_sections, max_sections)
		var path_index = randi_range(start, end)
		var initial_pos = path[path_index]
		var fork: Array[Vector2i] = []
		for j in range(sections):
			var found = false
			var tries = 0
			var target_pos
			while not found and tries < max_tries:
				target_pos = generate_target(initial_pos, min_distance, max_distance)
				
				if target_pos not in path and target_pos not in obstacles and path_generator.is_reachable(initial_pos, target_pos):
					found = true
					path_generator.generate_path(initial_pos, target_pos, 1.0)
					var section = path_generator.get_path()
					fork.append_array(section)
					fork.append(target_pos)
					var fork_obstacles: Array[Rect2i] = []
					for pos in section:
						fork_obstacles.append(Rect2i(pos.x, pos.y, 1, 1))
					obstacle_generator.add_obstacles(fork_obstacles)
					initial_pos = target_pos
				tries += 1
		forks.append(fork)

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
