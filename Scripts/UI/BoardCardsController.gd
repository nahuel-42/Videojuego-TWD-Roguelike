extends BaseDeck

@export var m_cardMovement : Node
@export var m_panels: Array[Panel] = []
@export var m_locationSpeed : float = 10.0

@export var m_cardsInGameReference : Node

var m_cardsAmount : int = 0

func _ready():
	super._ready()
	GameEvents.OnLoadBoard.AddListener(LoadBoard)
	
	GameEvents.OnAddCardsInGame.AddListener(AddCardsInGame)
	GameEvents.OnSwapCardsInGame.AddListener(SwapCardsInGame)

#STATES
func State_CardsLocation(delta):
	var ending = false
	for i in range(len(m_cardsList)):
		var p = m_panels[i]
		var c = m_cardsList[i]
		c.global_position = Mathf.Lerp(c.global_position, p.global_position, delta * m_locationSpeed)	
		if (c.global_position.distance_to(p.global_position) < 5):
			UI_funcs.SetParent(p, c)
			c.position = Vector2.ZERO
			if (i == m_cardsAmount - 1):
				ending = true
	if (ending):
			f_state = null
#END

func LoadBoard(cardsList):
	for c in m_cardsList:
		c.SetInputEvent(null)	
	GameEvents.OnLoadDiscard.Call(m_cardsList)
	
	m_cardsList = cardsList
	m_cardsAmount = len(m_cardsList)
	for i in range(m_cardsAmount):
		var p = m_panels[i]
		var c = m_cardsList[i]
		c.SetInputEvent(GetInputEvent)
		c.SetSide(true)
		
	f_state = State_CardsLocation

func GetInputEvent(card, event):
	m_cardMovement.GetInputEvent(card, event)

#CardsInGame
func AddCardsInGame(param):
	var card = m_cardMovement.GetCardSelected()
	if (card != null):
		UI_funcs.LocateCard(m_cardsInGameReference, card)
	else:
		print("Error card selected")

func SwapCardsInGame(param):
	var i = 0
	var id = param[0]
	var count = len(m_cardsList)
	while (i < count && m_cardsList[i].GetID() != id ):
		i += 1
			
	if (i<count):
		GameEvents.OnLoadDiscard.Call([m_cardsList[i]])
	else:
		print("Error Swap")
	GameEvents.OnAddCardsInGame.Call([-1])
