extends Object
class_name PathGenerator

var width:int
var height:int
var tile_size:Vector2i
var tilemap_size:Vector2i

var n_obstacles
var min_size_obstacles
var max_size_obstacles

var path: Array[Vector2i]

var astar = AStarGrid2D.new()
var map_rect = Rect2i()
var obstacles = []

# Configuration
var castle_size = 3

func _init(width:int, height:int, tile_size:Vector2i, tilemap_size:Vector2i, n_obstacles:int, min_size_obstacles:int, max_size_obstacles:int):
	print("hola")
	self.width = width
	self.height = height
	self.tile_size = tile_size
	self.tilemap_size = tilemap_size
	self.n_obstacles = n_obstacles
	self.min_size_obstacles = min_size_obstacles
	self.max_size_obstacles = max_size_obstacles

func generate_path():
	print("hola2")
	setup_astar()
	var initial_pos = Vector2i(0, height/2)
	var target_pos = generate_target()
	
	var generated = false
	var tries = 0
	while not generated:
		astar.fill_solid_region(astar.region, false)
		clear_obstacles(initial_pos, target_pos, castle_size)
		tries+=1
		generate_obstacles(n_obstacles, min_size_obstacles, max_size_obstacles)
				
		path = astar.get_id_path(initial_pos, target_pos).slice(1, -1)

		if len(path) > 0:
			generated = true
		if tries > 5000:
			break
	print(path)
	print(tries)

func get_path() -> Array[Vector2i]:
	return path

func setup_astar():
	map_rect = Rect2i(Vector2i(), tilemap_size)

	astar.clear()
	astar.region = map_rect
	astar.cell_size = tile_size
	astar.offset = tile_size * 0.5
	astar.default_compute_heuristic = AStarGrid2D.HEURISTIC_MANHATTAN
	astar.default_estimate_heuristic = AStarGrid2D.HEURISTIC_MANHATTAN
	astar.diagonal_mode = AStarGrid2D.DIAGONAL_MODE_NEVER
	astar.update()
	
func generate_obstacles(n, size_min, size_max):
	var n_obstacles = 0
	while n_obstacles < n:
		var size = randi_range(size_min, size_max)
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
			astar.fill_solid_region(rect)
			n_obstacles += 1

func generate_target():
	var side = randi_range(1,3)
	var pos_x
	var pos_y
	if side == 1: # Up
		pos_x = randi_range(width * 0.90, width -1)
		pos_y = 0
	if side == 2: # Right
		pos_x = width - 1
		pos_y = randi_range(0, height - 1)
	if side == 3: # Bottom
		pos_x = randi_range(width * 0.90, width -1)
		pos_y = height - 1 
	
	return Vector2i(pos_x, pos_y)
	
func clear_obstacles(initial_pos, target_pos, size):	
	var initial_pos_offset = initial_pos - Vector2i(1, 1)
	var target_pos_offset = target_pos - Vector2i(1, 1)
	obstacles = []
	obstacles.append(Rect2i(initial_pos_offset, Vector2i(size, size)))
	obstacles.append(Rect2i(target_pos_offset, Vector2i(size, size)))
