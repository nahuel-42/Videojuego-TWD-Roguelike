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
	CreateCards(deck)
	RestartCardIndex(len(deck))
	f_state = State_LoadCards
	
func CreateCards(deck):
	for id in deck:
		var instance = CardFactory.createCard(id)
		instance.SetSide(1)
		AddCardsPosition(instance)

func RecieveCards(cards):
	for c in cards:
		c.SetSide(1)
		AddCardsPosition(c)

func _on_button_2_button_up():
	if (m_timeCont>=m_maxTime):
		if (len(m_cardsList) == 0):
			m_restartCount += 1
		var newList = RemoveCards(5)
		GameEvents.OnLoadBoard.Call([newList])
		#m_actualCardIndex = 0
		f_state = State_LoadCards
		m_timeCont=0.0
		
		#Cambiar a 1 para que resetee antes
		if (m_restartCount == 1):
			GameEvents.OnRestartDeck.Call([self])
			m_restartCount = 0

func _on_show_pop_button_down():
	GameEvents.OnShowPopCards.Call([m_cardsList, true, false])
