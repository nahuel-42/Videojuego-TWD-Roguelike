extends Sprite2D

const LightTexture = preload("res://Assets/Map/Light.png")
@onready var tilemap = $"../TileMap"

var width
var height
var border
var CELL_DIMENSION
var display_width
var display_height

var fogImage: Image
var fogTexture: ImageTexture
var time_since_last_fog_update = 0

func _ready():
	width = tilemap.width
	height = tilemap.height
	border = tilemap.border
	CELL_DIMENSION = tilemap.CELL_DIMENSION
	display_width = (width + border * 2) * CELL_DIMENSION
	display_height = (height + border * 2) * CELL_DIMENSION
	var fog_image_width = display_width / CELL_DIMENSION
	var fog_image_height = display_height / CELL_DIMENSION
	fogImage = Image.create(display_width, display_height, false, Image.FORMAT_RGBAH)
	fogImage.fill(Color.BLACK)
	fogTexture = ImageTexture.create_from_image(fogImage)
	texture = fogTexture
	position -= Vector2(border, border) * CELL_DIMENSION

# TODO: Optimizar
func reveal_map(percentage: float):
	var reveal_width = display_width * percentage
	var lightImage = Image.create(reveal_width, display_height, false, Image.FORMAT_RGBAH)
	lightImage.fill(Color.WHITE)
	var light_rect = Rect2(Vector2.ZERO, lightImage.get_size())
	fogImage.blend_rect(lightImage, light_rect, Vector2.ZERO)
	fogTexture.update(fogImage)
