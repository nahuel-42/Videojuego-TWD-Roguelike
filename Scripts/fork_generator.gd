extends Object
class_name ForkGenerator

var width:int
var height:int

var min_sections:int
var max_sections:int
var min_distance:int
var max_distance:int

var path_generator:PathGenerator
var max_tries = 10
var targets: Array[Vector2i]

# TODO:
# - Arreglar la forma de los forks
# - Sacar los obstaculos para generar los forks
# - Alejar los forks del camino o hacer que la direccion se aleje del camino
# - Revisar que se agrega a obstacles generator

func _init(width:int, height:int, min_distance:int, max_distance:int, path_generator:PathGenerator):
	self.width = width
	self.height = height
	self.min_distance = min_distance
	self.max_distance = max_distance
	self.path_generator = path_generator
	self.targets = []
	
func generate_fork(path:Array[Vector2i], padding:int, min_length: int = 10, min_distance: int = 30) -> Array[Vector2i]:
	var fork: Array[Vector2i] = []
	var valid = false
	var target_pos
	var initial_pos
	
	# TODO: Quizas hay una forma mejor de hacerlo
	while not valid:
		target_pos = Vector2i(randi_range(0, width),randi_range(0, height)) 
		initial_pos = generate_target_in_the_main_way(target_pos,path)
		ObstacleGenerator.remove_obstacle(initial_pos - Vector2i(1,0))
		ObstacleGenerator.remove_obstacle(initial_pos + Vector2i(1,0))
		ObstacleGenerator.remove_obstacle(initial_pos - Vector2i(0,1))
		ObstacleGenerator.remove_obstacle(initial_pos + Vector2i(0,1))
		valid = is_fork_valid(initial_pos, target_pos, path, min_length)
		if not valid:
			ObstacleGenerator.add_obstacles([initial_pos - Vector2i(1,0)])
			ObstacleGenerator.add_obstacles([initial_pos + Vector2i(1,0)])
			ObstacleGenerator.add_obstacles([initial_pos - Vector2i(0,1)])
			ObstacleGenerator.add_obstacles([initial_pos + Vector2i(0,1)])
		
	path_generator.generate_path(initial_pos, target_pos, 1.0)
	ObstacleGenerator.add_obstacles([initial_pos - Vector2i(1,0)])
	ObstacleGenerator.add_obstacles([initial_pos + Vector2i(1,0)])
	ObstacleGenerator.add_obstacles([initial_pos - Vector2i(0,1)])
	ObstacleGenerator.add_obstacles([initial_pos + Vector2i(0,1)])
	fork = path_generator.get_path()
	fork.append(target_pos)
	
	return fork
	
# TODO variable resultado para hacerlo mas legible
func is_fork_valid(initial_pos: Vector2i, target_pos: Vector2i, path: Array[Vector2i], min_lenght: int) -> bool:
	return target_pos not in path and target_pos not in ObstacleGenerator.initial_obstacles and len(path) > min_lenght and path_generator.is_reachable(initial_pos, target_pos) and is_target_valid(target_pos, min_distance)
	
func is_target_valid(target: Vector2i, min_distance: float) -> bool:
	var aux = Vector2(target)
	for other in targets:
		var distance = aux.distance_to(other)
		if distance < min_distance:
			return false
			
	return true

func generate_target_in_the_main_way(initial_point: Vector2i, path:Array[Vector2i]) -> Vector2i:
	
	var padding=10
	var n = padding 
	var min_distance=999
	var min_node= path[n]
	var distance
	var incremento=2

	while (n<= len(path)-padding):
		distance=Vector2(initial_point).distance_to(path[n]) 
		if distance <= min_distance:
			min_node= path[n]
			min_distance= distance
		n+=incremento
	return min_node
