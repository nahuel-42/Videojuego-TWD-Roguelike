extends BaseDeck

func _ready():
	super._ready()
	GameEvents.OnLoadDiscard.AddListener(LoadDiscard)

func LoadDiscard(cards):
	for c in cards:
		AddCards(c)
		
	RestartCardIndex(len(cards))
	f_state = State_LoadCards
