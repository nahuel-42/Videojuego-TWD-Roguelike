class_name DeckCards
extends BaseDeck

@export var m_maxTime : float = 5.
var m_timeCont:float=m_maxTime
var m_restartCount : int = 0

func _ready():
	super._ready()
	StartDeck()

func _physics_process(delta):
	super._physics_process(delta)
	m_timeCont = clamp(m_timeCont+delta, 0.0, m_maxTime)

func StartDeck():
	#por ahora se crea solo fuego
	CardsManager.InitUserSave()
	var deck = CardsManager.CreateReferenceDeck(0)
	
	#Crea las cartas en la UI para mezclar
	var temporaryDeck = []
	for id in deck:
		temporaryDeck.append(CardFactory.createCard(id))
	
	#Se mezclan y se agrega al deck
	temporaryDeck=GlobalCardsList.GenerateDeck(temporaryDeck)
	for c in temporaryDeck:
		c.SetSide(false)
		AddCardsPosition(c)
	
	#Pone N cartas en el board
	#_on_button_2_button_up()
	
	#Activa el modo loadcards
	f_state = State_LoadCards
	
func ReceiveCards(cards):
	#Recibe las cartas del discard para mezclaras y volverlas a agregar
	cards=GlobalCardsList.GenerateDeck(cards)
	for c in cards:
		c.SetSide(false)
		AddCardsPosition(c)

func _on_button_2_button_up():
	#chequea que el tiempo sea mayor al max time para el discard
	if (m_timeCont>=m_maxTime):
		if (len(m_cardsList) == 0):
			m_restartCount += 1
		var newList = RemoveCards(5)
		GameEvents.OnLoadBoard.Call([newList])
		
		#Activa el modo loadcards
		f_state = State_LoadCards
		m_timeCont=0.0
		
		#Cambiar a 1 para que resetee antes
		if (m_restartCount == 2):
			GameEvents.OnRestartDeck.Call([self])
			m_restartCount = 0

func _on_show_pop_button_down():
	GameEvents.OnShowPopCards.Call([m_cardsList, true, false])
