extends BaseDeck

func _ready():
	super._ready()
	GameEvents.OnLoadDiscard.AddListener(LoadDiscard)

func LoadDiscard(cards):
	for c in cards:
		AddCards(c)
		c.SetVisible(true)
		
	RestartCardIndex(len(cards))
	f_state = State_LoadCards
