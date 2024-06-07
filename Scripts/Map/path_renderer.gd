extends TileMap

const SLOT_PATH = "res://Prefabs/Slots/tower_slot.tscn"
const BEAST_SPAWNER_PATH = "res://Prefabs/Spawners/BeastSpawner.tscn"
const CASTLE_PATH = "res://Scenes/castle.tscn"
const ENEMY_CASTLE_PATH = "res://Scenes/enemy_castle.tscn"

@export var slot_scene : PackedScene #!
@export var chest_scene : PackedScene
@export var camp_scene : PackedScene
@export var castle_scene : PackedScene

@export var seedName : String = ""
var seed : int
var camera2D
var CELL_DIMENSION = 32
var ASPECT_RATIO = 16.0 / 9.0
var width = 200
var height
var last_target_pos = null
var map
var borderSize = 10

enum TileType {
	PASTO,
	CAMINO,
	CAMPAMENTO,
	TORRE,
	OBSTACULO,
	CASTILLO,
	BORDE,
	SLOT,
	CHEST
}

# TODO: hacer diccionario de layers (cambiar que layer sea layers.decoracion, por ejemplo o sea digamos)
# TODO: cambiar a ingles
var textures = {
	TileType.PASTO: {
		"layer": 1,
		"source": 1,
		"atlas": Rect2i(Vector2i(0,0),Vector2i(7,3)),
		"alternative": 0 
	},
	TileType.CAMINO: {
		"layer": 0,
		"source": 1,
		"atlas": Rect2i(0,4,1,3),
		"alternative": 0 
	},
	TileType.CAMPAMENTO: {
		"layer" : 2,
		"source" : 3,
		"atlas" : Rect2i(5,3,0,0),
		"alternative" : 0
	},
	TileType.OBSTACULO: {
		"layer": 2,
		"source": 2,
		"atlas":Rect2i(1,6,0,0),
		"alternative": 0 
	},
	TileType.CASTILLO: {
		"layer": 2,
		"source": 3,
		"atlas": Rect2i(3,1,0,0),
		"alternative": 0 
	},
	TileType.BORDE: {
		"layer": 0,
		"source": 3,
		"atlas": Rect2i(7,1,0,0),
		"alternative": 0 
	},
	TileType.SLOT: {
		"layer": 2,
		"source": 3,
		"atlas": Rect2i(3,5,0,0),
		"alternative": 0 
	},
	TileType.CHEST: {
		"layer" : 2,
		"source" : 3,
		"atlas": Rect2i(3,1,0,0),
		"alternative" : 0
	}
}

# Configuration
var padding = 3

# Called when the node enters the scene tree for the first time.
func _ready():
	var viewport_size = get_viewport().size
	height = width / ASPECT_RATIO
	camera2D = $Camera2D
	var initial_pos = get_initial_pos()
	var target_pos = generate_target()
	
	print(initial_pos)
	camera2D.position= Vector2i(camera2D.get_viewport_rect().size.y/2 + 32, initial_pos.y*32)
	
	if seedName:
		self.seed = hash(seedName)
	else:
		self.seed = randi()
	seed(self.seed)
	print("La seed es ",self.seed)
	
	setup_level(initial_pos, target_pos)
	$"../Target".position = initial_pos * CELL_DIMENSION

func setup_level(initial_pos: Vector2i, target_pos: Vector2i):
	clear()
	last_target_pos = target_pos
	render_grass(width, height)
	map = {}
	
	var start_castle : Sprite2D = load(CASTLE_PATH).instantiate()
	var target_castle : Sprite2D = load(ENEMY_CASTLE_PATH).instantiate()
	start_castle.position  = initial_pos * CELL_DIMENSION
	target_castle.position = target_pos * CELL_DIMENSION
	add_child(start_castle)
	add_child(target_castle)
	
	map[initial_pos] = start_castle
	map[target_pos] = target_castle
	
	ObstacleGenerator.init(width, height,5, height / 2 - 1)
	
	var path_generator = PathGenerator.new(width, height, get_tileset().tile_size, get_used_rect().end - get_used_rect().position, 150)
	var path = path_generator.generate_path(initial_pos, target_pos, 2.0)
	ObstacleGenerator.add_obstacles(Utils.add_padding(path))
	# Add castles to initial obstacles
	ObstacleGenerator.add_obstacles([initial_pos, target_pos])	
	
	for cell in path:
		map[cell] = TileType.CAMINO

	# TODO: Agregar los slots como initial_obstacles en obstacle_generator
	var slots = SlotGenerator.new(width, height).generate_slots(100, path, 10, 5)
	for slot in slots:
		#var new_slot = slot_scene.instantiate() #!
		#new_slot._setup(TileType.SLOT)
		var new_slot = load(SLOT_PATH).instantiate() #!
		new_slot.position = slot * CELL_DIMENSION
		add_child(new_slot)
		map[slot] = new_slot #ahora tiene un objeto, el valor del diccionario #TileType.SLOT
	ObstacleGenerator.add_obstacles(slots)
	
	var castle_padding = 30
	var n_forks = 15
	# (path.size() - 2 * castle_padding) es la cantidad de tiles de donde puede salir un fork
	# / n_forks es la distancia maxima entre el inicio de un fork y otro en el que se pueden generar todos los forks
	# / 2 para calcular la distancia minima
	var min_distance = ((path.size() - 2 * castle_padding) / n_forks) / 2
	var min_fork_lenght = 5
	var max_fork_lenght = 15
	var fork_generator = ForkGenerator.new(width, height, min_distance, min_fork_lenght, max_fork_lenght, path_generator)
	var forks_initial_pos: Array[Vector2i] = []
	for i in range(n_forks):
		var fork = fork_generator.generate_fork(path, forks_initial_pos, castle_padding)
		forks_initial_pos.append(fork[0])
		for cell in fork:
			map[cell] = TileType.CAMINO
		
		# TODO: elegir un criterio mejor para elegir los campamentos / cofres
		var element
		if i < n_forks / 2:
			element = chest_scene.instantiate()
			element._setup(TileType.CHEST,fork[-1])
		else:
			element = load(BEAST_SPAWNER_PATH).instantiate()
			element.position = fork[-1] * CELL_DIMENSION
			add_child(element)
			
		map[fork[-1]] = element # EN ESTA LINEA SE INSTANCIA EL COFRE/CAMPAMENTO
		ObstacleGenerator.add_obstacles(Utils.add_padding(fork))
	
	render_border(borderSize)
	render_path()
	#WaveManager.load_waves()

func render_path():
	var rand : Vector2i

	for pos in map:
		var texture #= textures[map[pos]]
		if (map[pos] is int):
			texture = textures[map[pos]]			
			rand.x = randi_range(texture.atlas.position.x,texture.atlas.end.x)
			rand = Vector2i(randi_range(texture.atlas.position.x,texture.atlas.end.x),randi_range(texture.atlas.position.y,texture.atlas.end.y))
			set_cell(texture.layer, pos, texture.source, rand)

func generate_target():
	var side = randi_range(1,3)
	var pos_x
	var pos_y
	if side == 1: # Up
		pos_x = randi_range(width * 0.90, width -1)
		pos_y = 0
	if side == 2: # Right
		pos_x = width - 1
		pos_y = randi_range(0, height - 1)
	if side == 3: # Bottom
		pos_x = randi_range(width * 0.90, width -1)
		pos_y = height - 1 
	
	return Vector2i(pos_x, pos_y)

func render_grass(width: int, height: int):
	var grass_texture = textures[TileType.PASTO]
	var rand
	for i in range(width):
		for j in range(height):
			rand = Vector2i(randi_range(grass_texture.atlas.position.x,grass_texture.atlas.end.x),randi_range(grass_texture.atlas.position.y,grass_texture.atlas.end.y))
			set_cell(grass_texture.layer, Vector2i(i,j), grass_texture.source, rand)

func render_border(padding: int):
	var border_texture = textures[TileType.PASTO]
	print(border_texture)
	for p in range(1, padding + 1):
		if p==5:
			border_texture = textures[TileType.BORDE]
		for j in range(-p, height + p):
			set_cell(border_texture.layer, Vector2i(-p, j), border_texture.source, border_texture.atlas.position)
			set_cell(border_texture.layer, Vector2i(width + p - 1, j), border_texture.source, border_texture.atlas.position)
		
		for i in range(-p, width + p):
			set_cell(border_texture.layer, Vector2i(i, -p), border_texture.source, border_texture.atlas.position)
			set_cell(border_texture.layer, Vector2i(i, height + p - 1), border_texture.source, border_texture.atlas.position)

var percentage = 0
func _process(delta):
	if Input.is_action_just_released("regenerate_level"):
		print("regenerating level")
		var initial_pos = get_initial_pos()
		var target_pos = generate_target()
		setup_level(initial_pos, target_pos)
	elif Input.is_action_just_released("reveal_map"):
		var fog = $"../Fog"
		percentage += 0.1
		fog.reveal_map(percentage)

func get_initial_pos():
	if last_target_pos == null:
		return Vector2i(0, height / 2)
	elif last_target_pos.x == width - 1:
		return Vector2i(0, last_target_pos.y)
	else:
		return Vector2i(width - last_target_pos.x, height - last_target_pos.y - 1)
	
