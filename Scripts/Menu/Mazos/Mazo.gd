extends VBoxContainer

var type: CardsManager.DeckType

func init(data: Dictionary):
	$Name.text = data["name"]
	$Image.texture = load(data["image_path"])
	$MarginContainer2/Color.color = data["color"]
	$MarginContainer2/Color/Pasive.text = data["pasive_desc"]
	
	type = data["type"]

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
