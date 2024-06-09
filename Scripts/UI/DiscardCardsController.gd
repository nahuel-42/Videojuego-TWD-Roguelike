extends BaseDeck

func _ready():
	super._ready()
	GameEvents.OnLoadDiscard.AddListener(LoadDiscard)

func LoadDiscard(param):
	var cards = param[0]
	for c in cards:
		c.SetVisible(true)
		AddCards(c, true)
	#GameEvents.OnRemoveBoardCards.Call([cards])
	RestartCardIndex(len(cards))
	f_state = State_LoadCards


func _on_show_pop_button_down():
	GameEvents.OnShowPopCards.Call([m_cardsList, false, true])
