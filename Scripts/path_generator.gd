extends Node
class_name PathGenerator

var _grid_width:int
var _grid_height:int

var _path: Array[Vector2i]

func _init(width:int, height:int):
	_grid_width = width
	_grid_height = height

func _ready():
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
	
	for i in tilemap_size.x:
		for j in tilemap_size.y:
			var coordinates = Vector2i(i, j)
			var tile_data = get_cell_tile_data(0, coordinates)
			if tile_data and tile_data.get_custom_data('name') == "wall":
				astar.set_point_solid(coordinates)

func get_tile_score(tile:Vector2i) -> int:
	var score:int = 0
	var x = tile.x
	var y = tile.y
	
	score += 1 if _path.has(Vector2i(x,y-1)) else 0
	score += 2 if _path.has(Vector2i(x+1,y)) else 0
	score += 4 if _path.has(Vector2i(x,y+1)) else 0
	score += 8 if _path.has(Vector2i(x-1,y)) else 0
	
	return score

func get_path() -> Array[Vector2i]:
	return _path
