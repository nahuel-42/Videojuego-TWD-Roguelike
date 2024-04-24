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

# Configuration
var padding = 3

# Called when the node enters the scene tree for the first time.
func _ready():
	var viewport_size = get_viewport().size
	height = viewport_size.y * 2 / CELL_DIMENSION
	width = viewport_size.x * 5 / CELL_DIMENSION
	
	var grass_texture = textures[TileType.PASTO]
	for i in range(width):
		map.append([])
		for j in range(height):
			map[i].append(TileType.PASTO)
			set_cell(grass_texture.layer, Vector2i(i,j), grass_texture.source, grass_texture.atlas)
	
	var initial_pos = Vector2i(0, height / 2)
	var target_pos = generate_target()
	var path_generator = PathGenerator.new(width, height, get_tileset().tile_size, get_used_rect().end - get_used_rect().position, initial_pos, target_pos, 150, 5, height / 2 - 1)
	path_generator.generate_path()
	var path = path_generator.get_path()
	
	# Generate border
	var border_texture = textures[TileType.BORDE]
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

	var path_texture = textures[TileType.CAMINO]
	for cell in path:
		map[cell.x][cell.y] = TileType.CAMINO
		set_cell(path_texture.layer, cell, path_texture.source, path_texture.atlas)
	var castle_texture = textures[TileType.CASTILLO]
	set_cell(castle_texture.layer, initial_pos, castle_texture.source, castle_texture.atlas, castle_texture.alternative)
	set_cell(castle_texture.layer, target_pos, castle_texture.source, castle_texture.atlas, castle_texture.alternative)

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

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
