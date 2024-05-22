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
	
#func generate_forks(path:Array[Vector2i], obstacles:Array[Vector2i], n:int, padding:int) -> Array[Array]:
	#print("Generating forking paths")
	#var forks: Array[Array] = []
	#var i=0
	#var minimum_length= 10
	#var total_target=[]
	#var minimum_distance_each = 30
	#while i<=n:
		#var target_pos = Vector2i(randi_range(0, width),randi_range(0, height)) 
		#var fork: Array[Vector2i] = []
		#var initial_pos
		#var distance=0
		#var not_far_enough=false
		#initial_pos = generate_target_in_the_main_way(target_pos,path)
		#path_generator.setup_astar()
		##valida que la distancia entre los nodos no este a menos de minimum_distance_each celdas
		#for j in range(len(total_target)):
			#distance=Vector2(target_pos).distance_to(total_target[j])
			#if distance<minimum_distance_each:
				#not_far_enough=true
			 #
		#if target_pos not in path and target_pos not in obstacles and path_generator.is_reachable(initial_pos, target_pos) and !not_far_enough:
			#path_generator.generate_path(initial_pos, target_pos, 1.0)
			#var section = path_generator.get_path()
			#if len(section)>= minimum_length:
				#fork.append_array(section)
				#fork.append(target_pos)
				#var fork_obstacles: Array[Rect2i] = []
				#for pos in section:
					#fork_obstacles.append(Rect2i(pos.x, pos.y, 1, 1))
				#obstacle_generator.add_obstacles(fork_obstacles)
				#i+=1
				#total_target.append(target_pos)
				#forks.append(fork)
#
	#print("Forks generados: ", len(forks))
	#return forks
	
func generate_fork(path:Array[Vector2i], padding:int, min_length: int = 10, min_distance: int = 30) -> Array[Vector2i]:
	var fork: Array[Vector2i] = []
	var valid = false
	var target_pos
	var initial_pos
	
	while not valid:
		target_pos = Vector2i(randi_range(0, width),randi_range(0, height)) 
		initial_pos = generate_target_in_the_main_way(target_pos,path)
		valid = is_fork_valid(initial_pos, target_pos, path, min_length)
		
	path_generator.generate_path(initial_pos, target_pos, 1.0)
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
