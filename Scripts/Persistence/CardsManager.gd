extends Node
class_name CardsManager

static var m_user_save = null

static var m_user_save_path = "user_save"

static func InitUserSave():
	m_user_save = Save.load_game(m_user_save_path, m_user_save)
	if (m_user_save == null):
		var collectionCard = GlobalCards.CollectionCard
		var value	
		for c in collectionCard:
			if (c["unlocked"]== 1):
				value = true
			else:
				value = false
			m_user_save.append(value)			
		Save.save_game(m_user_save_path, m_user_save)

static func CreateReferenceDeck(id : int):
	var typeDeck = GlobalCards.TypeDeckCards[id]
	var referenceDeck = []
	
	for t in typeDeck:
		var card = m_user_save[t]
		if (card == true):
			referenceDeck.append(t)

	print(referenceDeck)	
	return referenceDeck
