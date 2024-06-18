extends Panel

func init(data: Dictionary):
	$Name.text = data["name"]
	$Type.text = data["type"]
	$Description.text = data["description"]
	$Sprite.texture = load(data["sprite"])
