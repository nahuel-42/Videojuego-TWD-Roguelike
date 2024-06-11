class_name BoardCards
extends BaseDeck

@export var m_cardMovement : CardMovement = null
@export var m_panels: Array[Panel] = []
@export var m_locationSpeed : float = 10.0
@export var m_cardsInGameReference : Node

var m_cardsListInGame = []
var m_cardsAmount : int = 0

func _init():
	GameEvents.OnLoadBoard.AddListener(LoadBoard)
	GameEvents.OnAddCardsInGame.AddListener(AddCardsInGame)
	GameEvents.OnSwapCardsInGame.AddListener(SwapCardsInGame)
	GameEvents.OnRemoveBoardCards.AddListener(RemoveBoardCards)

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
		for i in range(len(m_cardsList)):
			var p = m_panels[i]
			var c = m_cardsList[i]
			UI_funcs.SetParent(m_panels[i], m_cardsList[i])
			m_cardsList[i].position = Vector2.ZERO
			
			f_state = null
#END

func LoadBoard(param):
	var cardsList = param[0]
	for c in m_cardsList:
		c.SetInputEvent(null)
		m_cardMovement.ClearAllCards()
	GameEvents.OnLoadDiscard.Call([m_cardsList])
	
	m_cardsList = cardsList
	m_cardsAmount = len(m_cardsList)
	for i in range(m_cardsAmount):
		var p = m_panels[i]
		var c = m_cardsList[i]
		c.SetInputEvent(GetInputEvent)
		c.SetSide(0)
		
	f_state = State_CardsLocation
	
func GetInputEvent(card, event):
	m_cardMovement.GetInputEvent(card, event)

################CardsInGame################
func AddCardsInGame(param):
	var card = m_cardMovement.GetCardSelected()
	if (card != null):
		UI_funcs.LocateCard(m_cardsInGameReference, card)
	else:
		print("Error card selected")
	
	m_cardsListInGame.append(card)
	
	var index = m_cardsList.find(card)
	m_cardsList[index].SetInputEvent(null)
	m_cardsList.remove_at(index)
	
func SwapCardsInGame(param):
	var i = 0
	var id = param[0]
	var count = len(m_cardsListInGame)
	while (i < count && m_cardsListInGame[i].GetID() != id ):
		i += 1

	if (i<count):
		GameEvents.OnLoadDiscard.Call([[m_cardsListInGame[i]]])
		m_cardsListInGame.remove_at(i)
	else:
		print("Error Swap")
	GameEvents.OnAddCardsInGame.Call([-1])

func RemoveBoardCards(param):
	var list = param[0]
	m_cardMovement.ClearCards(list)
	for c in list:
		var index = m_cardsList.find(c)
		if (index >= 0):
			m_cardsList[index].SetInputEvent(null)
			m_cardsList.remove_at(index)
###########################################
