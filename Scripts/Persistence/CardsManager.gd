extends Node
class_name CardsManager

static var m_user_save = null

static var m_user_save_path = "user_save"

static func InitUserSave():
	m_user_save = Save.load_game(m_user_save_path, m_user_save)
	if (m_user_save != null):
		m_user_save = GlobalCardsList.get_unlocked_cards()			
		Save.save_game(m_user_save_path, m_user_save)

static func CreateReferenceDeck(id : int):
	var typeDeck = GlobalCardsList.TypeDeckCards[id]
	var referenceDeck = []
	
	for t in typeDeck:
		var card = m_user_save[t]
		if (card == true):
			referenceDeck.append(t)

	print(referenceDeck)	
	return referenceDeck
