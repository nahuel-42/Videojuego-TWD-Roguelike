extends TileMap

var CELL_DIMENSION = 32
var height
var width

enum TileType {
	PASTO,
	CAMINO,
	CAMPAMENTO,
	TORRE
}

var map = []
var obstacles = []
var astar = AStarGrid2D.new()
var map_rect = Rect2i()

# Called when the node enters the scene tree for the first time.
func _ready():
	var viewport_size = get_viewport().size
	height = viewport_size.y / CELL_DIMENSION
	width = viewport_size.x / CELL_DIMENSION
	
	for i in range(width):
		map.append([])
		for j in range(height):
			map[i].append(TileType.PASTO)
			set_cell(0, Vector2i(i,j), 0, Vector2i(0,0))

	setup_astar()
	var initial_pos = Vector2i(0, height/2)
	var target_pos = Vector2i(width-1, height/2)
	var initial_obstacle_size = 4
	var initial_pos_offset = initial_pos - Vector2i(initial_obstacle_size / 2, initial_obstacle_size / 2)
	obstacles.append(Rect2i(initial_pos_offset, Vector2i(initial_obstacle_size, initial_obstacle_size)))
	var target_pos_offset = target_pos - Vector2i(initial_obstacle_size / 2, initial_obstacle_size / 2)
	obstacles.append(Rect2i(target_pos_offset, Vector2i(initial_obstacle_size, initial_obstacle_size)))
	
	generate_obstacles(20, 1, 4)
	
	var path = astar.get_id_path(initial_pos, target_pos).slice(1, -1)
	for cell in path:
		map[cell.x][cell.y] = TileType.CAMINO
		set_cell(0, cell, 0, Vector2i(1, 3))

func generate_obstacles(n, size_min, size_max):
	for k in range(n):
		var size = randi_range(size_min, size_max)
		var pos_x = randi_range(0, width - size)
		var pos_y = randi_range(0, height - size)
		var pos = Vector2i(pos_x, pos_y)
		var collided = false
		var rect = Rect2i(pos, Vector2i(size, size))
		for obstacle in obstacles:
			if obstacle.intersects(rect):
				collided = true
				break
		if !collided:
			obstacles.append(rect)
			astar.fill_solid_region(rect)
			for i in range(pos_x, pos_x+size):
				for j in range(pos_y, pos_y + size):
					set_cell(0, Vector2i(i, j), 0, Vector2i(1, 2))

func setup_astar():
		var tile_size = get_tileset().tile_size
		var tilemap_size = get_used_rect().end - get_used_rect().position
		map_rect = Rect2i(Vector2i(), tilemap_size)

		astar.region = map_rect
		astar.cell_size = tile_size
		astar.offset = tile_size * 0.5
		astar.default_compute_heuristic = AStarGrid2D.HEURISTIC_MANHATTAN
		astar.default_estimate_heuristic = AStarGrid2D.HEURISTIC_MANHATTAN
		astar.diagonal_mode = AStarGrid2D.DIAGONAL_MODE_NEVER
		astar.update()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
