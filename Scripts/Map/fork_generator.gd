extends Object
class_name ForkGenerator

var width:int
var height:int

var min_sections:int
var max_sections:int
var min_distance:float # La distancia entre inicio de un fork y otro (distancia euclideana)
var min_lenght:int # El largo minimo de un fork (en tiles)
var max_lenght:int # El largo maximo de un fork (en tiles)

var path_generator:PathGenerator
var max_tries = 10
var targets: Array[Vector2i]

# TODO:
# - Arreglar la forma de los forks
# - Sacar los obstaculos para generar los forks
# - Alejar los forks del camino o hacer que la direccion se aleje del camino
# - Revisar que se agrega a obstacles generator

func _init(width:int, height:int, min_distance:float, min_lenght:int, max_lenght:int, path_generator:PathGenerator):
	self.width = width
	self.height = height
	self.min_distance = min_distance
	self.min_lenght = min_lenght
	self.max_lenght = max_lenght
	self.path_generator = path_generator
	self.targets = []
	
# Min lenght deberia estar aca?
func generate_fork(path:Array[Vector2i], forks_initial_pos:Array[Vector2i], padding:int) -> Array[Vector2i]:
	var fork: Array[Vector2i] = []
	var valid = false
	var target_pos
	var initial_pos
	
	while not valid:
		target_pos = Vector2i(randi_range(0, width),randi_range(0, height))
		if target_pos in path or target_pos in ObstacleGenerator.initial_obstacles:
			continue
		 
		initial_pos = generate_target_in_the_main_way(target_pos,path,padding)
		var aux = Vector2(initial_pos)
		for other in forks_initial_pos:
			var distance = aux.distance_to(other)
			if distance < self.min_distance:
				continue
				
		remove_obstacles(initial_pos)
		if not path_generator.is_reachable(initial_pos, target_pos):
			restore_obstacles(initial_pos)
			continue
			
		fork = path_generator.generate_path(initial_pos, target_pos, 1.0)
		
		if len(fork) < min_lenght or len(fork) > max_lenght:
			restore_obstacles(initial_pos)
			continue
		
		valid = true
		
	print(len(fork))
	fork.insert(0, initial_pos)
	fork.append(target_pos)
	print(len(fork))
	print(initial_pos in fork)
	restore_obstacles(initial_pos)
		
	return fork

func generate_target_in_the_main_way(initial_point: Vector2i, path:Array[Vector2i], padding: int, incremento: int = 5) -> Vector2i:
	var forkeable_path = path.slice(padding + 1, -padding)
	var min_distance=9999
	var min_node = forkeable_path[0]

	for n in range(0, len(forkeable_path), incremento):
		var distance = Vector2(initial_point).distance_to(forkeable_path[n]) 
		if distance <= min_distance:
			min_node = forkeable_path[n]
			min_distance = distance
			
	return min_node
	
func remove_obstacles(pos: Vector2i):
	ObstacleGenerator.remove_obstacle(pos - Vector2i(1,0))
	ObstacleGenerator.remove_obstacle(pos + Vector2i(1,0))
	ObstacleGenerator.remove_obstacle(pos - Vector2i(0,1))
	ObstacleGenerator.remove_obstacle(pos + Vector2i(0,1))
	
func restore_obstacles(pos: Vector2i):
	ObstacleGenerator.add_obstacles([pos - Vector2i(1,0)])
	ObstacleGenerator.add_obstacles([pos + Vector2i(1,0)])
	ObstacleGenerator.add_obstacles([pos - Vector2i(0,1)])
	ObstacleGenerator.add_obstacles([pos + Vector2i(0,1)])
