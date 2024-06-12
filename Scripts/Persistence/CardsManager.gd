extends Node
class_name CardsManager

#Sirve como referencia en el menu para saber que cargar
# 0 = Carga la partida
# 1 = Inicia con el mazo de tipo 0
# 2 = Inicia con el mazo de tipo 1
static var m_user_loader : int = 1

#Indice 0 : guarda la coleccion de cartas
#Indice 1 : guarda el tipo de mazo
#Indice 2 : guarda las monedas
static var m_user_profile = [null, -1, 250]

#Direccion por defecto de la partida guardada
static var m_user_save_path = "user_save"

#Cambia el valor del tipo de carga, 0 carga la partida...
static func SetDeckType(type : int):
	m_user_loader = type

#Comprueba si la partida esta guardada (caso que user loader sea 0)
#O comprueba que el mazo del tipo user loader - 1 exista
static func CheckDeckTypeSelected():
	if (m_user_loader == 0):
		return Save.load_game(m_user_save_path) != null
	else:
		return m_user_loader - 1 < len(GlobalCardsList.TypeDeckCards)

static func InitUserSave():
	if (m_user_loader == 0):
		m_user_profile = Save.load_game(m_user_save_path)
	else:
		m_user_profile[0] = GlobalCardsList.get_unlocked_cards()
		m_user_profile[1] = m_user_loader - 1
		Save.save_game(m_user_save_path, m_user_profile)
		m_user_profile = Save.load_game(m_user_save_path)

static func CreateReferenceDeck():
	var typeDeck = GlobalCardsList.TypeDeckCards[m_user_profile[1]]
	var referenceDeck = []
	print(m_user_profile)
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
	while (i < len(m_user_profile[0])):
		if (m_user_profile[0][i][0] == id):
			return m_user_profile[0][i][1]
		i += 1
	return false
