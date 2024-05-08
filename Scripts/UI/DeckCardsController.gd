extends BaseDeck

func CreateCards(deck):	
	for i in deck:
		var instance = CardFactory.createCard(i)
		#el diccionario aca serian las cartas del juegador (gameDeck)
		#var card = CardFactory.CreateCards(gameDeck[i]) 
		AddCards(instance)

func _on_button_button_up():
	#por ahora se crea solo fuego
	CardsManager.InitUserSave()
	var deck = CardsManager.CreateReferenceDeck(0)
	CreateCards(deck)
	RestartCardIndex(len(deck))
	f_state = State_LoadCards

func _on_button_2_button_up():	
	var newList = RemoveCards(5)
	GameEvents.OnLoadBoard.Call(newList)
	m_actualCardIndex = 0
	f_state = State_LoadCards
