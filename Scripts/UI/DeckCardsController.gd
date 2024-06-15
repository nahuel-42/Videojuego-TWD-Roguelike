class_name DeckCards
extends BaseDeck

@export var m_maxTime : float = 5.
@export var m_timeOutBar : TimeOutDiscard = null
var m_timeCont:float=m_maxTime
var m_restartCount : int = 0
var m_timeOutUpdate : bool = false

func _init():
	GameEvents.OnAddDeckCards.AddListener(AddCards)
	GameEvents.OnSetTimeOut.AddListener(SetTimeOut)
func _exit_tree():
	GameEvents.OnAddDeckCards.RemoveListener(AddCards)
	GameEvents.OnSetTimeOut.RemoveListener(SetTimeOut)

func _ready():
	super._ready()
	StartDeck()

func _physics_process(delta):
	super._physics_process(delta)
	if (m_timeOutUpdate):
		m_timeCont = clamp(m_timeCont+delta, 0.0, m_maxTime)
		m_timeOutBar.SetValue(clamp(m_timeCont / m_maxTime, 0.0, 1.0))

func StartDeck():
	var deck = CardsManager.GetDeck()
	
	#Crea las cartas en la UI para mezclar
	var card_nodes = []
	for id in deck:
		card_nodes.append(CardFactory.createCard(id))
	
	var hasTowers = false
	var minTowersInHand = 3
	while not hasTowers:
		card_nodes.shuffle()
		hasTowers = len(card_nodes.slice(0,5).filter(func(card): return GlobalCardsList.is_tower(card.GetID()))) >= minTowersInHand
	
	for c in card_nodes:
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

func SetTimeOut(param):
	m_timeOutUpdate = param[0]
	if (!m_timeOutUpdate):		
		m_timeCont = 0.0
		m_timeOutBar.SetValue(0.0)
