extends BaseDeck

@export var m_cardPrefab : String
@export var m_cardsAmount : int = 5

func CreateCards(amount):
	var scene = load(m_cardPrefab)
	
	for i in range(amount):
		var instance = scene.instantiate()
		AddCards(instance)

func _on_button_button_up():
	CreateCards(m_cardsAmount)
	RestartCardIndex(m_cardsAmount)
	f_state = State_LoadCards

func _on_button_2_button_up():	
	var newList = RemoveCards(5)
	GameEvents.OnLoadBoard_Call(newList)
	m_actualCardIndex = 0
	f_state = State_LoadCards
