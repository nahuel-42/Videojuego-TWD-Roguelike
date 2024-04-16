extends Node
class_name BaseCard

@export var m_ID : int = 0
@export var m_cardName : String = String()
@export var m_description : String = String()
@export var m_sprite : String = String()
@export var m_cost : int = 0

func _init(id, cardName, description, sprite, cost):
	m_ID = id
	m_cardName = cardName
	m_description = description
	m_sprite = sprite 
	m_cost = cost

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func use():
	print("Se usa la carta base")

func canBeUsed():
	#chequea si hay la energia/mana/elixir necesario para usar la carta
	pass
