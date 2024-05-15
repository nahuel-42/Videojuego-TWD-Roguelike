extends Object
class_name PathGenerator

var width:int
var height:int
var tile_size:Vector2i
var tilemap_size:Vector2i

var initial_pos:Vector2i
var target_pos:Vector2i

var n_obstacles

var path: Array[Vector2i]

var min_distance: float

var astar = AStarGrid2D.new()
var map_rect = Rect2i()
var obstacle_generator:ObstacleGenerator

# Configuration
var castle_size = 3

# TODO: Config Class
func _init(width:int, height:int, tile_size:Vector2i, tilemap_size:Vector2i, n_obstacles:int, obstacle_generator:ObstacleGenerator):
	self.width = width
	self.height = height
	self.tile_size = tile_size
	self.tilemap_size = tilemap_size
	self.n_obstacles = n_obstacles

	# TODO: dependency injection??
	self.obstacle_generator = obstacle_generator

# Precondicion: el camino es alcanzable
func generate_path(initial_pos:Vector2i, target_pos:Vector2i, curvature: float):
	var distance = abs(initial_pos.x - target_pos.x) + abs(initial_pos.y - target_pos.y)
	var min_distance = curvature * distance

	setup_astar()
	
	var generated = false
	var tries = 0
	while not generated:
		# TODO: podria ser un metodo que genere los obstaculos
		astar.fill_solid_region(astar.region, false)
		tries+=1
		var obstacles = obstacle_generator.generate_obstacles(n_obstacles)
		
		for obstacle in obstacles:
			astar.fill_solid_region(obstacle)
		
		path = astar.get_id_path(initial_pos, target_pos)
	
		if len(path) > min_distance:
			generated = true
		if tries > 5000:
			break
	var path_obstacles: Array[Rect2i] = []
	for pos in path:
		path_obstacles.append(Rect2i(pos.x, pos.y, 1, 1))
	obstacle_generator.add_obstacles(path_obstacles)
	path = path.slice(1, -1)
	
		
	# TODO: Devolver path cuando lo genera

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
	
func is_reachable(initial_pos: Vector2i, target_pos:Vector2i) -> bool:
	astar.fill_solid_region(astar.region, false)
	for obstacle in obstacle_generator.initial_obstacles:
			astar.fill_solid_region(obstacle)
			
	path = astar.get_id_path(initial_pos, target_pos)
	
	return len(path) > 0

