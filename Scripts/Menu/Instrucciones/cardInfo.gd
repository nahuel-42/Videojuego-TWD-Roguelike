extends Panel

func init(data: Dictionary):
	$Name.text = data["name"]
	$Color.text= data["color"]
	$Description.text = data["description"]
