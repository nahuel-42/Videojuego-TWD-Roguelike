class_name DiscardCards
extends BaseDeck

func _ready():
	super._ready()
	GameEvents.OnLoadDiscard.AddListener(LoadDiscard)
	GameEvents.OnRestartDeck.AddListener(RestartDeck)

func LoadDiscard(param):
	var cards = param[0]
	var count : int = len(cards)
	if (count > 0):
		#cards = cards.reverse()
		for c in cards:
			c.SetVisible(true)
			AddCards(c)
		
		#GameEvents.OnRemoveBoardCards.Call([cards])
		f_state = State_LoadCards

func RestartDeck(param):
	var deckCardsController : DeckCards = param[0]
	deckCardsController.ReceiveCards(RemoveCards(len(m_cardsList)))

func _on_show_pop_button_down():
	GameEvents.OnShowPopCards.Call([m_cardsList, false, true])
