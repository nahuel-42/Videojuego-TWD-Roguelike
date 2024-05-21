extends ObstacleGenerator
class_name ObstacleGeneratorCuadrados

func generate_obstacles(n: int) -> Array[Rect2i]:
	var obstacles: Array[Rect2i] = []
	obstacles.append_array(initial_obstacles)
	var n_obstacles = 0
	while n_obstacles < n:
		var size = randi_range(min_size, max_size)
		var pos_x = randi_range(0, width-1)
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
			n_obstacles += 1
			
	return obstacles
