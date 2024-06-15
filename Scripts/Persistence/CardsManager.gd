class_name CardsManager
extends Node

enum DeckType {
	CONTINUE, ICE, FIRE, BLOCKED
}

static var current_deck_type
static var deck = []

static func SetDeckType(type: DeckType):
	current_deck_type = type

static func InitUserSave():
	deck = Save.LoadDeck()
	if (deck == null):
		deck = GlobalCardsList.get_unlocked_ids()
		Save.SaveDeck(deck)

static func GetDeck():
	var deck
	if current_deck_type == DeckType.CONTINUE:
		deck = Save.LoadDeck()
	else:
		deck = GlobalCardsList.get_initial_deck(current_deck_type)
		deck = deck.filter(func (id): return GlobalCardsList.isUnlocked(id))
	return deck

static func AddCard(idCard : int):
	deck.append(idCard)
