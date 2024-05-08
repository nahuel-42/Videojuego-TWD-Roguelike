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
	BORDE,
	SLOT
}

# TODO: hacer diccionario de layers (cambiar que layer sea layers.decoracion, por ejemplo o sea digamos)
# TODO: cambiar a ingles
var textures = {
	TileType.PASTO: {
		"layer": 0,
		"source": 1,
		"atlas": Rect2i(Vector2i(0,0),Vector2i(7,3)),
		"alternative": 0 
	},
	TileType.CAMINO: {
		"layer": 1,
		"source": 1,
		"atlas": Rect2i(0,4,1,3),
		"alternative": 0 
	},
	TileType.OBSTACULO: {
		"layer": 2,
		"source": 2,
		"atlas":Rect2i(1,6,0,0),
		"alternative": 0 
	},
	TileType.CASTILLO: {
		"layer": 2,
		"source": 3,
		"atlas": Rect2i(3,1,0,0),
		"alternative": 0 
	},
	TileType.BORDE: {
		"layer": 0,
		"source": 3,
		"atlas": Rect2i(7,1,0,0),
		"alternative": 0 
	},
	TileType.SLOT: {
		"layer": 2,
		"source": 3,
		"atlas": Rect2i(3,5,0,0),
		"alternative": 0 
	}
}

var map = {}

# Configuration
var padding = 3

# Called when the node enters the scene tree for the first time.
func _ready():
	var viewport_size = get_viewport().size
	height = viewport_size.y * 2 / CELL_DIMENSION
	width = viewport_size.x * 5 / CELL_DIMENSION
	
	render_grass(width, height)
	
	var initial_pos = Vector2i(0, height / 2)
	var target_pos = generate_target()
	
	map[initial_pos] = TileType.CASTILLO
	map[target_pos] = TileType.CASTILLO
	
	var obstacle_generator = ObstacleGenerator.new(width, height,5, height / 2 - 1)
	var path_generator = PathGenerator.new(width, height, get_tileset().tile_size, get_used_rect().end - get_used_rect().position, 150, obstacle_generator)
	path_generator.generate_path(initial_pos, target_pos, 2.0)

	var path = path_generator.get_path()
	
	for cell in path:
		map[cell] = TileType.CAMINO

	# TODO: Agregar los slots como initial_obstacles en obstacle_generator
	var slots = SlotGenerator.new(width, height).generate_slots(100, path, 10, 5)
	for slot in slots:
		map[slot] = TileType.SLOT
	
	var forks = ForkGenerator.new(width, height, 2, 3, 3, 4, path_generator).generate_forks(path, slots, 3, 3)
	for fork in forks:
		for cell in fork:
			map[cell] = TileType.CASTILLO


	render_path()

func render_path():
	var rand : Vector2i

	for pos in map:
		var texture = textures[map[pos]]
		rand.x = randi_range(texture.atlas.position.x,texture.atlas.end.x)
		rand = Vector2i(randi_range(texture.atlas.position.x,texture.atlas.end.x),randi_range(texture.atlas.position.y,texture.atlas.end.y))
		set_cell(texture.layer, pos, texture.source, rand)

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

func render_grass(width: int, height: int):
	var grass_texture = textures[TileType.PASTO]
	var rand
	for i in range(width):
		for j in range(height):
			rand = Vector2i(randi_range(grass_texture.atlas.position.x,grass_texture.atlas.end.x),randi_range(grass_texture.atlas.position.y,grass_texture.atlas.end.y))
			set_cell(grass_texture.layer, Vector2i(i,j), grass_texture.source, rand)

func render_border(padding: int):
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

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
