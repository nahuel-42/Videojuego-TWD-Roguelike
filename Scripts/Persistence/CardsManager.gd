class_name CardsManager
extends Node

enum DeckType {
	CONTINUE, ICE, FIRE
}

static var current_deck_type
static var deck = []

static var m_user_save_path = "user_save"

static func SetDeckType(type: DeckType):
	current_deck_type = type

static func InitUserSave():
	deck = Save.LoadDeck()
	if (deck == null):
		deck = GlobalCardsList.get_unlocked_ids()
		Save.SaveDeck(deck)

static func GetDeck():
	var reference_deck = GlobalCardsList.get_type(current_deck_type - 1)
	return reference_deck.filter(func (id): return GlobalCardsList.isUnlocked(id))

static func AddCard(idCard : int):
	deck.append(idCard)
