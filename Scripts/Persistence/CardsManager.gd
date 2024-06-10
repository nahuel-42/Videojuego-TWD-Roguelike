extends Node
class_name CardsManager

static var m_user_save = null

static var m_user_save_path = "user_save"

static func InitUserSave():
	m_user_save = Save.load_game(m_user_save_path, m_user_save)
	#if (m_user_save != null):
	m_user_save = GlobalCardsList.get_unlocked_cards()
	Save.save_game(m_user_save_path, m_user_save)

static func CreateReferenceDeck(id : int):
	var typeDeck = GlobalCardsList.TypeDeckCards[id]
	var referenceDeck = []
	print(m_user_save)
	print("__________________________________")
	print(typeDeck)
	for t in typeDeck:
		var card = GetUnlocked(t)
		if (card == true):
			referenceDeck.append(t)

	print(referenceDeck)
	return referenceDeck

static func GetUnlocked(id):
	var i : int = 0
	while (i < len(m_user_save)):
		if (m_user_save[i][0] == id):
			return m_user_save[i][1]
		i += 1
	return false
