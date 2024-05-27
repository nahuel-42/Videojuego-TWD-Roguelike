extends Object
class_name PathGenerator

var width:int
var height:int
var tile_size:Vector2i
var tilemap_size:Vector2i

var initial_pos:Vector2i
var target_pos:Vector2i

var n_obstacles

var min_distance: float

var astar 
var map_rect = Rect2i()

# Configuration
var castle_size = 3

# TODO: Config Class
func _init(width:int, height:int, tile_size:Vector2i, tilemap_size:Vector2i, n_obstacles:int):
	self.width = width
	self.height = height
	self.tile_size = tile_size
	self.tilemap_size = tilemap_size
	self.n_obstacles = n_obstacles

# Precondicion: el camino es alcanzable
func generate_path(initial_pos:Vector2i, target_pos:Vector2i, curvature: float):
	var distance = abs(initial_pos.x - target_pos.x) + abs(initial_pos.y - target_pos.y)
	var min_distance = curvature * distance
	var path

	setup_astar()
	var generated = false
	var tries = 0
	while not generated:
		# TODO: podria ser un metodo que genere los obstaculos
		astar.fill_solid_region(astar.region, false)
		tries+=1
		var obstacles = ObstacleGenerator.generate_obstacles(n_obstacles)
		
		for obstacle in obstacles:
			astar.fill_solid_region(obstacle)
		
		path = astar.get_id_path(initial_pos, target_pos)
				
		if len(path) > min_distance:
			generated = true
		if tries > 5000:
			break
	
	path = path.slice(1, -1)
	
	return path

func setup_astar():
	astar = AStarGrid2D.new()
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
	for obstacle in ObstacleGenerator.initial_obstacles:
			astar.fill_solid_region(obstacle)
	var path = astar.get_id_path(initial_pos, target_pos)
	
	return len(path) > 0

