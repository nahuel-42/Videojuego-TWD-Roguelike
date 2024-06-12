class_name DeckCards
extends BaseDeck

@export var m_maxTime : float = 5.
@export var m_timeOutBar : TimeOutDiscard = null
var m_timeCont:float=m_maxTime
var m_restartCount : int = 0

func _init():
	GameEvents.OnAddDeckCards.AddListener(AddCards)
func _exit_tree():
	GameEvents.OnAddDeckCards.RemoveListener(AddCards)

func _ready():
	super._ready()
	StartDeck()

func _physics_process(delta):
	super._physics_process(delta)
	m_timeCont = clamp(m_timeCont+delta, 0.0, m_maxTime)
	m_timeOutBar.SetValue(clamp(m_timeCont / m_maxTime, 0.0, 1.0))

func StartDeck():
	CardsManager.InitUserSave()
	var deck = CardsManager.CreateReferenceDeck()
	
	#Crea las cartas en la UI para mezclar
	var temporaryDeck = []
	for id in deck:
		temporaryDeck.append(CardFactory.createCard(id))
	
	#Se mezclan y se agrega al deck
	temporaryDeck=GlobalCardsList.GenerateDeck(temporaryDeck)
	for c in temporaryDeck:
		c.SetSide(1)
		AddCardsPosition(c)
		
	#Pone N cartas en el board
	_on_button_2_button_up(true)
	
	#Activa el modo loadcards
	f_state = State_LoadCards
	
func AddCards(param):
	var cards = param[0]
	for c in cards:
		c.SetSide(1)
		AddCardsPosition(c)
			
func ReceiveCards(cards):
	#Recibe las cartas del discard para mezclaras y volverlas a agregar	
	cards=GlobalCardsList.GenerateDeck(cards)
	for c in cards:
		c.SetSide(1)
		AddCardsPosition(c)
	
	#Pone N cartas en el board
	m_restartCount = 0
	_on_button_2_button_up(true)

func _on_button_2_button_up(conf : bool = false):
	#chequea que el tiempo sea mayor al max time para el discard
	if (m_timeCont>=m_maxTime or conf):
		if (len(m_cardsList) == 0):
			m_restartCount += 1
		var newList = RemoveCards(5)
		GameEvents.OnLoadBoard.Call([newList])
		
		#Activa el modo loadcards
		f_state = State_LoadCards
		m_timeCont=0.0
		m_actualIndex = 0
		
		#Cambiar a 1 para que resetee antes
		if (m_restartCount == 1):
			GameEvents.OnRestartDeck.Call([self])
			m_restartCount = 0

func _on_show_pop_button_down():
	GameEvents.OnShowPopCards.Call([m_cardsList, true, false])
