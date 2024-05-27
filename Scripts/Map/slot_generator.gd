extends Object
class_name SlotGenerator

var offsets = [
	Vector2i(-1, -1),
	Vector2i(-1, 0),
	Vector2i(-1, 1),
	Vector2i(0, -1),
	Vector2i(0, 1),
	Vector2i(1, -1),
	Vector2i(1, 0),
	Vector2i(1, 1),
]

var width: int
var height: int
var max_tries = 10

func _init(width: int, height: int):
	self.width = width
	self.height = height

func generate_slots(n: int, path: Array[Vector2i], padding: int, min_distance: float) -> Array[Vector2i]:
	print("Generating slots")
	var start = padding - 1 # inclusive
	var end = len(path) - padding # exclusive
	
	var slots: Array[Vector2i] = []
	
	for i in range(n):
		var path_index = randi_range(start, end)
		var path_position = path[path_index]
		
		var found = false
		var tries = 0
		while not found and tries < max_tries:
			# TODO: hacer que no pueda elegir dos veces el mismo offset
			var slot_offset = offsets.pick_random()
			var slot = path_position + slot_offset
			if is_valid_slot(slot, path, slots, min_distance):
				found = true
				slots.append(slot)
			tries += 1
	
	print("Generated slots: ", len(slots))
	
	return slots

func is_valid_slot(slot: Vector2i, path: Array[Vector2i], slots: Array[Vector2i], min_distance: int):
	return not slot in path and is_in_map(slot) and not is_near_slots(slot, slots, min_distance)

func is_near_slots(slot: Vector2i, slots: Array[Vector2i], min_distance: float):
	for other in slots:
		var distance = sqrt((slot.x - other.x) ** 2 + (slot.y - other.y) ** 2)
		if distance <= min_distance:
			return true
	return false

func is_in_map(pos: Vector2i):
	return pos.x >= 0 and pos.x < self.width and pos.y >= 0 and pos.y < self.height

