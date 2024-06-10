class_name DeckCards
extends BaseDeck

@export var m_maxTime : float = 5.
var cont:float=m_maxTime
var aux:float=1.


func _physics_process(delta):
	super._physics_process(delta)
	cont = clamp(cont+aux*delta, 0, m_maxTime)
	
func CreateCards(deck):
	var i : int = 0
	for id in deck:
		var instance = CardFactory.createCard(id)
		#el diccionario aca serian las cartas del juegador (gameDeck)
		#var card = CardFactory.CreateCards(gameDeck[i]) 
		AddCardsPosition(instance)

func _on_button_button_up():
	#por ahora se crea solo fuego
	CardsManager.InitUserSave()
	var deck = CardsManager.CreateReferenceDeck(0)
	CreateCards(deck)
	RestartCardIndex(len(deck))
	f_state = State_LoadCards

func _on_button_2_button_up():	
	if (cont>=m_maxTime):
		var newList = RemoveCards(5)
		GameEvents.OnLoadBoard.Call([newList])
		#m_actualCardIndex = 0
		f_state = State_LoadCards
		cont=1


func _on_show_pop_button_down():
	GameEvents.OnShowPopCards.Call([m_cardsList, true, false])
