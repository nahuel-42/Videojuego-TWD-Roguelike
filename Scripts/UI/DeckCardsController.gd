extends BaseDeck

@export var m_cardScene : String
@export var m_cardsAmount : int = 5

func CreateCards(amount):
	var scene = load(m_cardScene)
	
	for i in range(amount):
		#el diccionario aca serian las cartas del juegador (gameDeck)
		#var card = CardFactory.CreateCards(gameDeck[i]) 
		var instance = scene.instantiate()
		AddCards(instance)

func _on_button_button_up():
	CreateCards(m_cardsAmount)
	RestartCardIndex(m_cardsAmount)
	f_state = State_LoadCards

func _on_button_2_button_up():	
	var newList = RemoveCards(5)
	GameEvents.OnLoadBoard.Call(newList)
	m_actualCardIndex = 0
	f_state = State_LoadCards
