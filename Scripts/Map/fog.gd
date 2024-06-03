extends Sprite2D

var display_width
var display_height
const LightTexture = preload("res://Assets/Map/Light.png")
@onready var tilemap = $"../TileMap"

var width = tilemap.width
var height = tilemap.height
var CELL_DIMENSION = tilemap.CELL_DIMENSION

var fogImage: Image
var fogTexture: ImageTexture
var light_rect: Rect2
var lightImage = LightTexture.get_image()
var light_offset = Vector2(LightTexture.get_width()/2, LightTexture.get_height()/2)
var time_since_last_fog_update = 0

func _ready():
	lightImage.resize(512, 512)
	var display_width = width * CELL_DIMENSION
	var display_height = height * CELL_DIMENSION
	var fog_image_width = display_width / CELL_DIMENSION
	var fog_image_height = display_height / CELL_DIMENSION
	fogImage = Image.create(display_width, display_height, false, Image.FORMAT_RGBAH)
	fogImage.fill(Color.BLACK)
	fogTexture = ImageTexture.create_from_image(fogImage)
	texture = fogTexture
	light_rect = Rect2(Vector2.ZERO, lightImage.get_size())
	lightImage.convert(Image.FORMAT_RGBAH)

func update_fog(new_grid_position):
	fogImage.blend_rect(lightImage, light_rect, new_grid_position - light_offset)
	fogTexture.update(fogImage)

func _process(delta):
	time_since_last_fog_update += delta
	var debounce_time = 0.1
	if (time_since_last_fog_update >= debounce_time):
		time_since_last_fog_update = 0.0
		update_fog(get_local_mouse_position())
