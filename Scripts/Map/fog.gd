extends Sprite2D

@onready var tilemap = $"../TileMap"

var width
var height
var border
var CELL_DIMENSION
var display_width
var display_height

var fog_texture_path = "res://Assets/fog.png"

func _ready():
	texture = load(fog_texture_path)
	width = tilemap.width
	height = floor(tilemap.height)
	border = tilemap.borderSize
	CELL_DIMENSION = tilemap.CELL_DIMENSION
	display_width = (width + border * 2) * CELL_DIMENSION
	display_height = (height + border * 2) * CELL_DIMENSION
	setup_shader()
	reset()

func setup_shader():
	var shader_material = ShaderMaterial.new()
	shader_material.shader = Shader.new()
	shader_material.shader.code = """
		shader_type canvas_item;
		uniform float edge_size : hint_range(0.0, 1.0) = 0.1;

		void fragment() {
			float alpha = smoothstep(0.0, edge_size, UV.x);
			COLOR.a *= alpha;
		}
	"""
	material = shader_material
	shader_material.set_shader_parameter("edge_size", 0.1)

func reveal_map(percentage: float):
	position.x = percentage * display_width - border * CELL_DIMENSION
	set_region_rect(Rect2(0, 0, display_width * (1.0 - percentage), display_height))
	
func reset():
	position = - Vector2(border, border) * CELL_DIMENSION
	set_region_rect(Rect2(0, 0, display_width, display_height))
