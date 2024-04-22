extends TileMap

var CELL_DIMENSION = 32
var height
var width

enum TileType {
	PASTO,
	CAMINO,
	CAMPAMENTO,
	TORRE,
	OBSTACULO,
	CASTILLO,
	BORDE
}

var textures = {
	TileType.PASTO: {
		"layer": 0,
		"source": 1,
		"atlas": Vector2i(0, 0),
		"alternative": 0 
	},
	TileType.CAMINO: {
		"layer": 1,
		"source": 1,
		"atlas": Vector2i(0, 4),
		"alternative": 0 
	},
	TileType.OBSTACULO: {
		"layer": 2,
		"source": 2,
		"atlas": Vector2i(1, 6),
		"alternative": 0 
	},
	TileType.CASTILLO: {
		"layer": 2,
		"source": 3,
		"atlas": Vector2i(3, 1),
		"alternative": 0 
	},
	TileType.BORDE: {
		"layer": 0,
		"source": 3,
		"atlas": Vector2i(7, 1),
		"alternative": 0 
	},
}

var map = []
var obstacles = []
var astar = AStarGrid2D.new()
var map_rect = Rect2i()

# Configuration
var padding = 3

# Called when the node enters the scene tree for the first time.
func _ready():
	var viewport_size = get_viewport().size
	height = viewport_size.y * 2 / CELL_DIMENSION
	width = viewport_size.x * 5 / CELL_DIMENSION
	
	#textures
	var grass_texture = textures[TileType.PASTO]
	var border_texture = textures[TileType.BORDE]
	
	#Generate border
	for j in range(-padding, height+padding):
		for i in range(-padding,-padding+padding):
			set_cell(border_texture.layer, Vector2i(i,j), border_texture.source, border_texture.atlas)
		for i in range(width,width+padding):
			set_cell(border_texture.layer, Vector2i(i,j), border_texture.source, border_texture.atlas)
	for i in range(0, width):
		for j in range(-padding,0):
			set_cell(border_texture.layer, Vector2i(i,j), border_texture.source, border_texture.atlas)
		for j in range(height,height+padding):
			set_cell(border_texture.layer, Vector2i(i,j), border_texture.source, border_texture.atlas)
		
	#Generate grass
	for i in range(width):
		map.append([])
		for j in range(height):
			map[i].append(TileType.PASTO)
			set_cell(grass_texture.layer, Vector2i(i,j), grass_texture.source, grass_texture.atlas)
	
	
	setup_astar()
	var initial_pos = Vector2i(0, height/2)
	var target_pos = generate_target()
	var initial_obstacle_size = 3

	#Generate path
	var path_generator = PathGenerator.new(width, height, get_tileset().tile_size, get_used_rect().end - get_used_rect().position, 150, 5, height / 2 - 1)
	path_generator.generate_path()
	var path = path_generator.get_path()
	
	var generated = false
	var tries = 0
	while not generated:
		astar.fill_solid_region(astar.region, false)
		clear_obstacles(initial_pos, target_pos, initial_obstacle_size)
		tries+=1
		generate_obstacles(300, 5, height / 10)
		print("Obstaculos: ", len(obstacles))
		
		path = astar.get_id_path(initial_pos, target_pos).slice(1, -1)

		if len(path) > 0:
			generated = true
		if tries > 5000:
			break
	#
	var path_texture = textures[TileType.CAMINO]

	for cell in path:
		map[cell.x][cell.y] = TileType.CAMINO
		set_cell(path_texture.layer, cell, path_texture.source, path_texture.atlas)
	print("Intentos de generacion: ",+tries)

func clear_obstacles(initial_pos, target_pos, size):	
	var initial_pos_offset = initial_pos - Vector2i(1, 1)
	var target_pos_offset = target_pos - Vector2i(1, 1)
	var castle_texture = textures[TileType.CASTILLO]		
	clear_layer(textures[TileType.OBSTACULO].layer)
	obstacles = []
	obstacles.append(Rect2i(initial_pos_offset, Vector2i(size, size)))
	obstacles.append(Rect2i(target_pos_offset, Vector2i(size, size)))
	set_cell(castle_texture.layer, initial_pos, castle_texture.source, castle_texture.atlas)
	set_cell(0, target_pos, textures[TileType.CASTILLO].source, textures[TileType.CASTILLO].atlas)
			
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

func generate_obstacles(n, size_min, size_max):
	var obstacle_texture = textures[TileType.OBSTACULO]
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
			for i in range(pos_y, pos_y + size):
				set_cell(obstacle_texture.layer, Vector2i(pos_x, i), obstacle_texture.source, obstacle_texture.atlas)
			n_obstacles += 1

func setup_astar():
		var tile_size = get_tileset().tile_size
		var tilemap_size = Vector2i(width, height)
		map_rect = Rect2i(Vector2i(), tilemap_size)

		astar.clear()
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
