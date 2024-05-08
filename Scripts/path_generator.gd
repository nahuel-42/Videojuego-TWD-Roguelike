extends Object
class_name PathGenerator

var width:int
var height:int
var tile_size:Vector2i
var tilemap_size:Vector2i

var initial_pos:Vector2i
var target_pos:Vector2i

var n_obstacles
var min_size_obstacles
var max_size_obstacles

var path: Array[Vector2i]

var min_distance: float

var astar = AStarGrid2D.new()
var map_rect = Rect2i()
var obstacles = []

# Configuration
var castle_size = 3

# TODO: Config Class
func _init(width:int, height:int, tile_size:Vector2i, tilemap_size:Vector2i, initial_pos:Vector2i, target_pos:Vector2i, n_obstacles:int, min_size_obstacles:int, max_size_obstacles:int, curvature: float):
	self.width = width
	self.height = height
	self.tile_size = tile_size
	self.tilemap_size = tilemap_size
	self.n_obstacles = n_obstacles
	self.min_size_obstacles = min_size_obstacles
	self.max_size_obstacles = max_size_obstacles
	self.initial_pos = initial_pos
	self.target_pos = target_pos
	
	var distance = abs(initial_pos.x - target_pos.x) + abs(initial_pos.y - target_pos.y)
	self.min_distance = curvature * distance

# TODO: generar camino por tramos, para no descartar todo el camino por un solo tramo
func generate_path():
	setup_astar()
	
	var generated = false
	var tries = 0
	while not generated:
		astar.fill_solid_region(astar.region, false)
		clear_obstacles(initial_pos, target_pos, castle_size)
		tries+=1
		generate_obstacles(n_obstacles, min_size_obstacles, max_size_obstacles)
		
		path = astar.get_id_path(initial_pos, target_pos).slice(1, -1)

		if len(path) > min_distance:
			generated = true
		if tries > 5000:
			break
	print("Tries: ", tries)

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

func clear_obstacles(initial_pos, target_pos, size):	
	var initial_pos_offset = initial_pos - Vector2i(1, 1)
	var target_pos_offset = target_pos - Vector2i(1, 1)
	obstacles = []
	obstacles.append(Rect2i(initial_pos_offset, Vector2i(size, size)))
	obstacles.append(Rect2i(target_pos_offset, Vector2i(size, size)))
