class_name CardsManager
extends Node

enum DeckType {
	CONTINUE, ICE, FIRE
}

static var current_deck_type

#Indice 0 : guarda la coleccion de cartas
#Indice 1 : guarda el tipo de mazo
#Indice 2 : guarda las monedas
static var user_profile : UserProfile = UserProfile.new()

#Direccion por defecto de la partida guardada
static var m_user_save_path = "user_save"

#Cambia el valor del tipo de carga, 0 carga la partida...
static func SetDeckType(type: DeckType):
	current_deck_type = type

#Comprueba si la partida esta guardada (caso que user loader sea 0)
#O comprueba que el mazo del tipo user loader - 1 exista
static func CheckDeckTypeSelected():
	pass
	#return m_user_loader - 1 < len(GlobalCardsList.TypeDeckCards)

static func InitUserSave():
	pass
	#user_profile.LoadDeck()
	
	#if (m_user_loader == 0):
	#	printerr("Deberia cargase el stage con el tipo de mazo!!")

static func GetDeck():
	pass
	#return user_profile.GetDeck(m_user_loader - 1)

#Sirve para agregar cantidad al mazo o desbloquear una carta
static func AddCard(idCard : int):
	user_profile.AddCard(idCard)
