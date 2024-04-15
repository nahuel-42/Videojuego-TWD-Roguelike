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

# Called when the node enters the scene tree for the first time.
func _ready():
	var viewport_size = get_viewport().size
	height = viewport_size.y / CELL_DIMENSION + 1
	width = viewport_size.x / CELL_DIMENSION + 1
	
	for i in range(width):
		map.append([])
		for j in range(height):
			map[i].append(TileType.PASTO)
			set_cell(0, Vector2i(i,j), 0, Vector2i(0,0))
	
	var path_generator = PathGenerator.new(width, height)
	var path = path_generator.generate_path()
	for cell in path:
		map[cell.x][cell.y] = TileType.CAMINO
		set_cell(0, cell, 0, Vector2i(1,3))
	
	print(map)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
