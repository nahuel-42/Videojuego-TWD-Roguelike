extends Object
class_name ForkGenerator

var width:int
var height:int

var min_sections:int
var max_sections:int
var min_distance:int
var max_distance:int

var obstacle_generator:ObstacleGenerator
var path_generator:PathGenerator
var max_tries = 10

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
	self.obstacle_generator = path_generator.obstacle_generator
	self.path_generator = path_generator
	
func generate_forks(path:Array[Vector2i], obstacles:Array[Vector2i], n:int, padding:int) -> Array[Array]:
	print("Generating forking paths")
	var forks: Array[Array] = []
	var i=0
	var minimum_length= 10
	while i<=n:
		var target_pos = Vector2i(randi_range(0, width),randi_range(0, height)) 
		
		var fork: Array[Vector2i] = []
		var initial_pos
		initial_pos = generate_target_in_the_main_way(target_pos,path)
		
		if target_pos not in path and target_pos not in obstacles and path_generator.is_reachable(initial_pos, target_pos):
			
			path_generator.generate_path(initial_pos, target_pos, 1.0)
			var section = path_generator.get_path()
			if len(section)>= minimum_length:
				fork.append_array(section)
				fork.append(target_pos)
				var fork_obstacles: Array[Rect2i] = []
				for pos in section:
					fork_obstacles.append(Rect2i(pos.x, pos.y, 1, 1))
				obstacle_generator.add_obstacles(fork_obstacles)
				i+=1
				forks.append(fork)

	print("Forks generados: ", len(forks))
	return forks

func generate_target_in_the_main_way(initial_point: Vector2i, path:Array[Vector2i]) -> Vector2i:
	
	var padding=10
	var n = padding 
	var min_distance=999
	var min_node= path[n]
	var distance
	var incremento=5

	while (n<= len(path)-padding):
		distance=Vector2(initial_point).distance_to(path[n]) 
		if distance <= min_distance:
			min_node= path[n]
			min_distance= distance
		n+=10
	return min_node
