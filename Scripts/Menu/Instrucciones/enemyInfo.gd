extends Panel

func _init(data: Dictionary):
	$Name.text = data["name"]
	$Type.text = data["type"]
	$Description.text = data["descr"]
	$Sprite.texture = load(data["sprite"])
