extends BaseDeck
var cont:float=5.
var aux:float=1.


func _process(delta):
	super._process(delta)
	cont+=aux*delta
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
	if (cont>=5.):
		var newList = RemoveCards(5)
		GameEvents.OnLoadBoard.Call([newList])
		m_actualCardIndex = 0
		f_state = State_LoadCards
		cont=1


func _on_show_pop_button_down():
	GameEvents.OnShowPopCards.Call([m_cardsList, true, false])
