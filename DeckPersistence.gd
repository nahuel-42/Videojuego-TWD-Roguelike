extends Node

const refDeckPath = "user://saves/deck.save"
const globalCardsPath = "res://deck/globalDeck.dat"

func save(): 
	#para que los elementos se guarden deben pertenecer al grupo "CardPersistence"
	#la funcion save crea un diccionario con los datos a persistir, las cartas del referenceDeck tiene las id de la carta correspondiente a la GlobalCardList
	var save_game = FileAccess.open(refDeckPath, FileAccess.WRITE)
	var save_nodes = get_tree().get_nodes_in_group("CardPersistence")
	for node in save_nodes:	#en este caso, el unico nodo a instanciar va a ser el referenceDeck
		var node_data = node.call("save")		
		var json_string = JSON.stringify(node_data)
		save_game.store_line(json_string)

func load_decks():
	#hacer la carga de los mazos obligatorios acá, puede que tenga que ir en otro lugar
	#ambos mazos deben pertenecer al grupo "Decks"
	if not FileAccess.file_exists(globalCardsPath):
		return # No deberia suceder una vez que tengamos los archivos de las cartas y los personajes
	var decks = get_tree().get_nodes_in_group("Decks")
	for i in decks:
		i.queue_free()
	# Load the file line by line and process that dictionary to restore the object it represents.
	var save_game = FileAccess.open(globalCardsPath, FileAccess.READ)
	#el archivo va a tener un unico objeto, asi que solo va a leer una linea
	while save_game.get_position() < save_game.get_length(): 
		var json_string = save_game.get_line()
		var json = JSON.new() # Creates the helper class to interact with JSON

		var parse_result = json.parse(json_string) # Check if there is any error while parsing the JSON string, skip in case of failure
		if not parse_result == OK:
			print("JSON Parse Error ", json.get_error_message(),"  in ", json_string,"  at line ", json.get_error_line())
			continue

		var node_data = json.get_data() # Get the data from the JSON object
		# Firstly, we need to create the object and add it to the tree and set its position.
		var new_object = load(node_data["filename"]).instantiate()
		get_node(node_data["parent"]).add_child(new_object)
		#new_object.position = Vector2(node_data["pos_x"], node_data["pos_y"])
		# Now we set the remaining variables.
		for i in node_data.keys():
			if i == "filename" or i == "parent": # or i == "pos_x" or i == "pos_y":
				continue
			new_object.set(i, node_data[i])

func load_game():
	if not FileAccess.file_exists(refDeckPath):
		return # Error! We don't have a save to load.

	# We need to revert the game state so we're not cloning objects during loading. This will vary wildly depending on the needs of a project, so take care with this step.
	# For our example, we will accomplish this by deleting saveable objects.
	var save_nodes = get_tree().get_nodes_in_group("CardPersistence")
	for i in save_nodes:
		i.queue_free()

	# Load the file line by line and process that dictionary to restore the object it represents.
	var save_game = FileAccess.open(refDeckPath, FileAccess.READ)
	#el archivo va a tener un unico objeto, asi que solo va a leer una linea
	while save_game.get_position() < save_game.get_length(): 
		var json_string = save_game.get_line()
		var json = JSON.new() # Creates the helper class to interact with JSON

		var parse_result = json.parse(json_string) # Check if there is any error while parsing the JSON string, skip in case of failure
		if not parse_result == OK:
			print("JSON Parse Error ", json.get_error_message(),"  in ", json_string,"  at line ", json.get_error_line())
			continue

		var node_data = json.get_data() # Get the data from the JSON object
		# Firstly, we need to create the object and add it to the tree and set its position.
		var new_object = load(node_data["filename"]).instantiate()
		get_node(node_data["parent"]).add_child(new_object)
		#new_object.position = Vector2(node_data[pos_x], node_data[pos_y])

		# Now we set the remaining variables.
		for i in node_data.keys():
			if i == "filename" or i == "parent": #or i == pos_x or i == pos_y
				continue
			new_object.set(i, node_data[i])
