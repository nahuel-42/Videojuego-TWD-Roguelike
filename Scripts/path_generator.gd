extends Object
class_name PathGenerator

var _grid_width:int
var _grid_height:int

var _path: Array[Vector2i]

func _init(width:int, height:int):
	_grid_width = width
	_grid_height = height

func generate_path():
	_path.clear()
	
	var x = 0
	var y = int(_grid_height/2)
	_path.append(Vector2i(x,y))
	var step = 2
	while x < _grid_width:
		var direction:int = randi_range(0,2)
		for i in range(step):
			if direction == 0 or x == _grid_width-1 and not _path.has(Vector2i(x+1, y)):
				x += 1
			#elif direction == 3 and not _path.has(Vector2i(x-1, y)):
				#x -= 1
			elif direction == 1 and y < _grid_height-2 and not _path.has(Vector2i(x,y+1)):
				y += 1
			elif direction == 2 and y > 1 and not _path.has(Vector2i(x,y-1)):
				y -= 1
			if not _path.has(Vector2i(x,y)):
				_path.append(Vector2i(x,y))
		
	return _path

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
