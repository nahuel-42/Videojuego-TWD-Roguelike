extends Node

func add_padding(positions: Array[Vector2i], padding: int = 1) -> Array[Vector2i]:
	var result: Array[Vector2i] = []
	for pos in positions:
		for i in range(-padding, padding + 1):
			for j in range(-padding, padding + 1):
				# Create a new Vector2i for the position with the current offset
				var new_pos = pos + Vector2i(i, j)
				# Add the new position to the result array
				result.append(new_pos)
	return result
